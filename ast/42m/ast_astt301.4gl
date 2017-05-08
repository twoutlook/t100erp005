#該程式已解開Section, 不再透過樣板產出!
{<section id="astt301.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000183
#+ 
#+ Filename...: astt301
#+ Description: 自營合約異動申請單
#+ Creator....: 01533(2013/10/21)
#+ Modifier...: 01533(2013/11/08)
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="astt301.global" >}

    
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
#160318-00005#44  2016/03/26  By pengxin    修正azzi920重复定义之错误讯息
#160318-00025#37  2016/04/19  By pengxin    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160513-00002#3   2016/5/23   by 08172      画面调整
#160818-00017#38  2016-08-23  By 08734      删除修改未重新判断状态码
#160902-00009#1   2016/09/02  By 08734      在_action_chk中增遗漏的RETURN TRUE
#160905-00007#16  2016/09/05  By 02599      SQL条件增加ent
#161024-00025#6   2016/10/25  By 02481      门店开窗调整
#161108-00016#1   2016/11/09  By 08742      修改 g_browser_cnt 定义大小
#161111-00028#3   2016/11/16  By 02481      标准程式定义采用宣告模式,弃用.*写法
#161214-00032#1   2016/12/15  By 07900      石狮通达权限设置.freestyle或者是改过section者,需检核规格【资料表关联设定】主表要跟现在程序主表一致;主sql部分要补上cl_sql_add_filter
#170106-00009#1   2016/01/10  By Jessica    1.不需簽核時，查詢流程按鈕(鋼筆)未設為失效
#                                           2.已拒絕及抽單狀態下，按作廢提示 "非未確認不得作廢"
#                                           3.開啟作業帶單號參數，未帶出該單
#                                           4.提交失敗(已通過檢核段，是BPM回覆失敗)，但狀態仍變送簽中，可測單號CNJ-889-201701060002

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
{<Module define>}
 
#單頭 type 宣告
PRIVATE type type_g_staj_m        RECORD
       staj000 LIKE staj_t.staj000, 
       staj039 LIKE staj_t.staj039,
   stajdocno LIKE staj_t.stajdocno, 
   stajdocdt LIKE staj_t.stajdocdt, 
   staj002 LIKE staj_t.staj002, 
   staj001 LIKE staj_t.staj001, 
   staj003 LIKE staj_t.staj003, 
   staj021 LIKE staj_t.staj021, 
   stanstus LIKE type_t.chr10, 
   staj004 LIKE staj_t.staj004, 
   staj004_desc LIKE type_t.chr80, 
   staj005 LIKE staj_t.staj005, 
   staj005_desc LIKE type_t.chr80, 
   staj006 LIKE staj_t.staj006, 
   staj006_desc LIKE type_t.chr80, 
   staj007 LIKE staj_t.staj007, 
   staj007_desc LIKE type_t.chr80, 
   staj008 LIKE staj_t.staj008,
   staj008_desc LIKE type_t.chr80,
   staj024 LIKE staj_t.staj024,    #150506-00007#3 120522 by sakura
   staj024_desc LIKE type_t.chr80, #150506-00007#3 120522 by sakura      
   staj025 LIKE staj_t.staj025,    #150506-00007#3 120522 by sakura
   staj040    LIKE staj_t.staj040,             #151013-00001#11 1051021 by yangxf
   staj025_desc LIKE type_t.chr80, #150506-00007#3 120522 by sakura   
   staj026 LIKE staj_t.staj026,    #150506-00007#3 120522 by sakura
   staj027 LIKE staj_t.staj027,    #150506-00007#3 120522 by sakura
   staj028 LIKE staj_t.staj028,    #150506-00007#3 120522 by sakura
   staj036 LIKE staj_t.staj036,
   staj037 LIKE staj_t.staj037,
   staj038 LIKE staj_t.staj038,
   staj029 LIKE staj_t.staj029,    #150506-00007#3 120522 by sakura
   staj030 LIKE staj_t.staj030,    #150506-00007#3 120522 by sakura
   staj031 LIKE staj_t.staj031,    #150512-00006#2 
   staj033 LIKE staj_t.staj033,
   staj034 LIKE staj_t.staj034,
   staj042 LIKE staj_t.staj042,    #160303-00028#33 20160318 by geza 
   staj009 LIKE staj_t.staj009, 
   staj009_desc LIKE type_t.chr80, 
   staj010 LIKE staj_t.staj010, 
   staj010_desc LIKE type_t.chr80, 
   staj015 LIKE staj_t.staj015, 
   staj015_desc LIKE type_t.chr80, 
   staj016 LIKE staj_t.staj016, 
   staj016_desc LIKE type_t.chr80, 
   staj011 LIKE staj_t.staj011, 
   staj012 LIKE staj_t.staj012, 
   staj013 LIKE staj_t.staj013, 
   staj013_desc LIKE type_t.chr80, 
   staj035 LIKE staj_t.staj035,
   staj014 LIKE staj_t.staj014, 
   staj014_desc LIKE type_t.chr80, 
   staj041 LIKE staj_t.staj041,
   staj041_desc LIKE type_t.chr80,
   staj017 LIKE staj_t.staj017, 
   staj018 LIKE staj_t.staj018, 
   staj019 LIKE staj_t.staj019, 
   staj020 LIKE staj_t.staj020, 
   stajsite LIKE staj_t.stajsite, 
   stajsite_desc LIKE type_t.chr80, 
   stajunit LIKE staj_t.stajunit, 
   stajstus LIKE staj_t.stajstus, 
   stajownid LIKE staj_t.stajownid, 
   stajownid_desc LIKE type_t.chr80, 
   stajowndp LIKE staj_t.stajowndp, 
   stajowndp_desc LIKE type_t.chr80, 
   stajcrtid LIKE staj_t.stajcrtid, 
   stajcrtid_desc LIKE type_t.chr80, 
   stajcrtdp LIKE staj_t.stajcrtdp, 
   stajcrtdp_desc LIKE type_t.chr80, 
   stajcrtdt DATETIME YEAR TO SECOND, 
   stajmodid LIKE staj_t.stajmodid, 
   stajmodid_desc LIKE type_t.chr80, 
   stajmoddt DATETIME YEAR TO SECOND, 
   stajcnfid LIKE staj_t.stajcnfid, 
   stajcnfid_desc LIKE type_t.chr80, 
   stajcnfdt DATETIME YEAR TO SECOND
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_stak_d        RECORD
       stakseq LIKE stak_t.stakseq, 
   stak003 LIKE stak_t.stak003, 
   stak003_desc LIKE type_t.chr500, 
   stak023 LIKE stak_t.stak023,        #150602-00003#27 20150611 by geza
   stak024 LIKE stak_t.stak024,        #150602-00003#27 20150611 by geza
   stak025 LIKE stak_t.stak025,
   stak025_desc  LIKE type_t.chr500,
   stak004 LIKE stak_t.stak004, 
   stak005 LIKE stak_t.stak005, 
   stak006 LIKE stak_t.stak006, 
   stak028 LIKE stak_t.stak028,
   stak007 LIKE stak_t.stak007, 
   stak008 LIKE stak_t.stak008, 
   stak027 LIKE stak_t.stak027,       #150612-00023#5 add
   stak009 LIKE stak_t.stak009, 
   stak009_desc LIKE type_t.chr500, 
   stak010 LIKE stak_t.stak010, 
   stak010_desc LIKE type_t.chr500, 
   stak011 LIKE stak_t.stak011, 
   stak012 LIKE stak_t.stak012, 
   stak013 LIKE stak_t.stak013, 
   stak014 LIKE stak_t.stak014, 
   stak015 LIKE stak_t.stak015, 
   stak016 LIKE stak_t.stak016, 
   stak029    LIKE stak_t.stak029,     #151013-00001#11 1051021 by yangxf
   stak030    LIKE stak_t.stak030,     #151013-00001#11 1051021 by yangxf
   stak022 LIKE stak_t.stak022,            #150512-00006#2 
   stak017 LIKE stak_t.stak017, 
   stak018 LIKE stak_t.stak018, 
   stakacti LIKE stak_t.stakacti,   
   stak026 LIKE stak_t.stak026,            #add by yangxf 
   stak019 LIKE stak_t.stak019,
   stak020 LIKE stak_t.stak020,
   stak021 LIKE stak_t.stak021,
   stakunit LIKE stak_t.stakunit, 
   staksite LIKE stak_t.staksite
       END RECORD
PRIVATE TYPE type_g_stak2_d RECORD
       stamseq LIKE stam_t.stamseq, 
   stam003 LIKE stam_t.stam003, 
   stam003_desc LIKE type_t.chr500, 
   stam005 LIKE stam_t.stam005,
   stam004 LIKE stam_t.stam004, 
   stamacti     LIKE stam_t.stamacti,
   stamunit LIKE stam_t.stamunit, 
   stamsite LIKE stam_t.stamsite
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_staj_m          type_g_staj_m
DEFINE g_staj_m_t        type_g_staj_m
 
   DEFINE g_stajdocno_t LIKE staj_t.stajdocno
 
 
DEFINE g_stak_d          DYNAMIC ARRAY OF type_g_stak_d
DEFINE g_stak_d_t        type_g_stak_d
DEFINE g_stak2_d   DYNAMIC ARRAY OF type_g_stak2_d
DEFINE g_stak2_d_t type_g_stak2_d
DEFINE g_stak2_d_o type_g_stak2_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_stajdocno LIKE staj_t.stajdocno,
      b_stajdocdt LIKE staj_t.stajdocdt,
      b_staj000 LIKE staj_t.staj000,
      b_staj001 LIKE staj_t.staj001,
      b_staj002 LIKE staj_t.staj002,
      b_staj003 LIKE staj_t.staj003,
      b_staj004 LIKE staj_t.staj004,
      b_staj005 LIKE staj_t.staj005,
      b_staj005_desc LIKE type_t.chr500,
      b_staj006 LIKE staj_t.staj006,
      b_staj007 LIKE staj_t.staj007,
      b_staj008 LIKE staj_t.staj008,
      b_staj009 LIKE staj_t.staj009,
      b_staj010 LIKE staj_t.staj010,
      b_staj011 LIKE staj_t.staj011,
      b_staj012 LIKE staj_t.staj012,
      b_staj013 LIKE staj_t.staj013,
      b_staj014 LIKE staj_t.staj014,
      b_staj015 LIKE staj_t.staj015,
      b_staj016 LIKE staj_t.staj016,
      b_staj017 LIKE staj_t.staj017,
      b_staj018 LIKE staj_t.staj018,
      b_staj019 LIKE staj_t.staj019,
      b_staj020 LIKE staj_t.staj020,
      b_staj021 LIKE staj_t.staj021,
      b_stajsite LIKE staj_t.stajsite,
      b_stajacti LIKE staj_t.stajacti
         #,rank           LIKE type_t.num10
      END RECORD 
      
DEFINE g_browser_f  RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_stajdocno LIKE staj_t.stajdocno,
      b_stajdocdt LIKE staj_t.stajdocdt,
      b_staj000 LIKE staj_t.staj000,
      b_staj001 LIKE staj_t.staj001,
      b_staj002 LIKE staj_t.staj002,
      b_staj003 LIKE staj_t.staj003,
      b_staj004 LIKE staj_t.staj004,
      b_staj005 LIKE staj_t.staj005,
      b_staj005_desc LIKE type_t.chr500,
      b_staj006 LIKE staj_t.staj006,
      b_staj007 LIKE staj_t.staj007,
      b_staj008 LIKE staj_t.staj008,
      b_staj009 LIKE staj_t.staj009,
      b_staj010 LIKE staj_t.staj010,
      b_staj011 LIKE staj_t.staj011,
      b_staj012 LIKE staj_t.staj012,
      b_staj013 LIKE staj_t.staj013,
      b_staj014 LIKE staj_t.staj014,
      b_staj015 LIKE staj_t.staj015,
      b_staj016 LIKE staj_t.staj016,
      b_staj017 LIKE staj_t.staj017,
      b_staj018 LIKE staj_t.staj018,
      b_staj019 LIKE staj_t.staj019,
      b_staj020 LIKE staj_t.staj020,
      b_staj021 LIKE staj_t.staj021,
      b_stajsite LIKE staj_t.stajsite,
      b_stajacti LIKE staj_t.stajacti
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
 TYPE type_g_stak3_d RECORD
   stbjseq LIKE stbj_t.stbjseq, 
   stbj001 LIKE stbj_t.stbj001,
   stbjunit LIKE stbj_t.stbjunit, 
   stbjsite LIKE stbj_t.stbjsite
       END RECORD 
DEFINE g_stak3_d   DYNAMIC ARRAY OF type_g_stak3_d
DEFINE g_stak3_d_t type_g_stak3_d 
DEFINE g_wc2_table7   STRING

TYPE type_g_stak4_d RECORD
   stbnseq  LIKE stbn_t.stbnseq, 
   stbn001  LIKE stbn_t.stbn001,
   stbn001_desc LIKE type_t.chr500,
   stbnacti LIKE stbn_t.stbnacti,
   stbnunit LIKE stbn_t.stbnunit, 
   stbnsite LIKE stbn_t.stbnsite
       END RECORD 
DEFINE g_stak4_d   DYNAMIC ARRAY OF type_g_stak4_d
DEFINE g_stak4_d_t type_g_stak4_d 
DEFINE g_wc2_table8   STRING
DEFINE g_wc2_table9   STRING 
 TYPE type_g_stal_d        RECORD
    stalseq2 LIKE stal_t.stalseq2, 
    stal004 LIKE stal_t.stal004, 
    stal005 LIKE stal_t.stal005, 
    stal006 LIKE stal_t.stal006
       END RECORD
DEFINE g_stal_d        DYNAMIC ARRAY OF type_g_stal_d  
DEFINE g_stal_d_t      type_g_stal_d
DEFINE l_ac3           LIKE type_t.num5
DEFINE g_rec_b3        LIKE type_t.num5
DEFINE g_detail_idx3   LIKE type_t.num5
DEFINE g_wc2_table3          STRING
DEFINE g_ooef004      LIKE ooef_t.ooef004
DEFINE g_ooef005      LIKE ooef_t.ooef005
DEFINE g_assign_no    LIKE type_t.chr1
DEFINE g_stak_d_o        type_g_stak_d
DEFINE g_flag         LIKE type_t.num5
DEFINE g_staj_m_o        type_g_staj_m

TYPE type_g_staw_d        RECORD
    stawsite LIKE staw_t.stawsite,
    stawunit LIKE staw_t.stawunit,
    stawseq  LIKE staw_t.stawseq, 
    staw007  LIKE staw_t.staw007,
    staw007_desc  LIKE type_t.chr50,
    staw002  LIKE staw_t.staw002, 
    staw003  LIKE staw_t.staw003, 
    staw004  LIKE staw_t.staw004,
    staw005  LIKE staw_t.staw005,
    staw006  LIKE staw_t.staw006
       END RECORD
DEFINE g_staw_d        DYNAMIC ARRAY OF type_g_staw_d  
DEFINE g_staw_d_t      type_g_staw_d
DEFINE g_staw_d_o      type_g_staw_d
TYPE type_g_stbw_d        RECORD
    stbwsite LIKE stbw_t.stbwsite,
    stbwunit LIKE stbw_t.stbwunit,
    stbwseq  LIKE stbw_t.stbwseq, 
    stbw001  LIKE stbw_t.stbw001,
    stbw008  LIKE stbw_t.stbw008,
    stbw008_desc  LIKE type_t.chr50,
    stbw009  LIKE stbw_t.stbw009,
    stbw007  LIKE stbw_t.stbw007,
    stbw007_desc  LIKE type_t.chr50,
    stbw002  LIKE stbw_t.stbw002, 
    stbw003  LIKE stbw_t.stbw003, 
    stbw004  LIKE stbw_t.stbw004,
    stbw005  LIKE stbw_t.stbw005,
    stbw006  LIKE stbw_t.stbw006
       END RECORD
DEFINE g_stbw_d        DYNAMIC ARRAY OF type_g_stbw_d  
DEFINE g_stbw_d_t      type_g_stbw_d
DEFINE g_stbw_d_o      type_g_stbw_d
DEFINE g_wc2_table4    STRING
DEFINE g_ooef019       LIKE ooef_t.ooef019 #稅區 #150506-00007#3 150522 by sakura add

#############################150512-00006#2
TYPE type_g_stay_d       RECORD 
     stayseq2  LIKE stay_t.stayseq2,
     stay001   LIKE stay_t.stay001,
     stay002   LIKE stay_t.stay002,
     stay004   LIKE stay_t.stay004,
     stay004_desc LIKE type_t.chr80    
     END RECORD
     
DEFINE g_stay_d        DYNAMIC ARRAY OF type_g_stay_d  
DEFINE g_stay_d_t      type_g_stay_d
DEFINE g_wc2_table5    STRING

TYPE type_g_stay1_d       RECORD 
     stayseq2  LIKE stay_t.stayseq2,
     stay001   LIKE stay_t.stay001,
     stay002   LIKE stay_t.stay002,
     stay005   LIKE stay_t.stay005,     #add by yangxf
     stay003   LIKE stay_t.stay003,
     stay004   LIKE stay_t.stay004,
     stay004_desc LIKE type_t.chr80    
     END RECORD
     
DEFINE g_stay1_d        DYNAMIC ARRAY OF type_g_stay1_d  
DEFINE g_stay1_d_t      type_g_stay1_d
DEFINE g_wc2_table6     STRING
DEFINE g_field          LIKE type_t.chr10
DEFINE g_period_flag    LIKE type_t.chr1
#############################
#end add-point
 
#add-point:傳入參數說明
DEFINE g_site_flag     LIKE type_t.num5  #ken 需求單號：141208-00001 項次：18 
#end add-point
 
{</section>}
 
{<section id="astt301.main" >}
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
   LET g_forupd_sql = "SELECT staj000,staj039,stajdocno,stajdocdt,staj002,staj001,staj003,staj021,'',staj004, 
       '',staj005,'',staj006,'',staj007,'',staj008,'',staj024,'',staj025,'',staj040,staj026,staj027,staj028,staj036,staj037,staj038,staj029,staj030,staj031,staj033,staj034,staj042,staj009,'',staj010,'',staj015,'',staj016,'',staj011, 
       staj012,staj013,'',staj014,'',staj041,'',staj017,staj018,staj019,staj020,stajsite,'',stajunit,stajstus, 
       stajownid,'',stajowndp,'',stajcrtid,'',stajcrtdp,'',stajcrtdt,stajmodid,'',stajmoddt,stajcnfid, 
       '',stajcnfdt FROM staj_t WHERE stajent= ? AND stajdocno=? FOR UPDATE"
   #add-point:SQL_define
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE astt301_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
            
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_astt301 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astt301_init()   
 
      #進入選單 Menu (="N")
      CALL astt301_ui_dialog() 
	  
      #add-point:畫面關閉前
      CALL s_aooi500_drop_temp() RETURNING l_success
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astt301
      
   END IF 
   
   CLOSE astt301_cl
   
   
 
   #add-point:作業離開前
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/20 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="astt301.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION astt301_init()
   #add-point:init段define
   DEFINE l_success LIKE type_t.num5      
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
      CALL cl_set_combo_scc_part('stanstus','50','N,Y,X')
      CALL cl_set_combo_scc_part('stajstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('staj000','6863') 
   CALL cl_set_combo_scc('staj002','6013') 
   CALL cl_set_combo_scc('stak005','6006') 
   CALL cl_set_combo_scc('stak006','6007') 
   CALL cl_set_combo_scc('stak007','6008') 
   CALL cl_set_combo_scc('stak008','6009') 
   CALL cl_set_combo_scc('stak013','6010') 
   CALL cl_set_combo_scc('stak016','6011') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   #CALL cl_set_combo_scc_part('staj002','6013','1,2,3,5')  #160303-00028#33 mark by geza 
   CALL cl_set_combo_scc_part('staj002','6013','1,2,3')   #160303-00028#33 add by geza 
   CALL cl_set_combo_scc('b_staj000','6863') 
   CALL cl_set_combo_scc_part('b_staj002','6013','1,2,3,5')
   CALL cl_set_combo_scc_part('stak005','6006','1,2')
   #150506-00007#3 150522 by sakura add---STR
   CALL cl_set_combo_scc('staj028','6816') #超出處理方式
   CALL cl_set_combo_scc('staj029','2087') #內外購
   CALL cl_set_combo_scc('staj030','2086') #匯率計算基準
   #150506-00007#3 150522 by sakura add---END
   CALL cl_set_combo_scc('staj031','6785') #合約狀態
   CALL cl_set_combo_scc('staj034','6202')
   CALL cl_set_combo_scc('stak022','6818') #自定義範圍  #150512-00006#2
   CALL cl_set_combo_scc_part('stay003','6517','4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,11,12') #屬性類型    #150512-00006#2
   CALL cl_set_combo_scc('stay005','6761')     #add by yangxf
   
   LET g_ooef004 = ''
   LET g_ooef005 = ''
   SELECT ooef004,ooef005 INTO g_ooef004,g_ooef005 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   IF cl_null(g_ooef005) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00008'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   #150506-00007#3 150522 by sakura add---STR
   LET g_ooef019 = ''
   CALL s_tax_get_ooef019(g_site) RETURNING l_success,g_ooef019
   #150506-00007#3 150522 by sakura add---END
   CALL s_aooi500_create_temp() RETURNING l_success   
   #end add-point
   
   CALL astt301_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="astt301.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION astt301_ui_dialog()
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
      
  
  #    INITIALIZE g_errparam TO NULL
  #    LET g_errparam.extend = ""
  #    LET g_errparam.code   = 'ast-00221'
  #    LET g_errparam.popup  = TRUE
  #    CALL cl_err()
  #    RETURN
  # END IF  
      
   #end add-point
   
   WHILE TRUE 
   
      CALL astt301_browser_fill("")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
            
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_stajdocno = g_stajdocno_t
 
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
               
               CALL astt301_fetch('') # reload data
               LET l_ac = 1
               CALL astt301_ui_detailshow() #Setting the current row 
      
               CALL astt301_idx_chk()
               #NEXT FIELD stakseq
         
         END DISPLAY
        
         DISPLAY ARRAY g_stak_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL astt301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作
                                             CALL astt301_b3_fill()
               CALL astt301_reflesh()
               # add geza 150504-00002#1 (S)  
               IF g_stak_d[l_ac].stak016 = '1' THEN
                  CALL cl_set_comp_visible('group7',FALSE)
               ELSE
                  CALL cl_set_comp_visible('group7',TRUE)
               END IF 
               # add geza 150504-00002#1 (E)
               CALL astt301_set_visible(g_detail_idx)               
               CALL astt301_b_fill2('2')
               CALL astt301_b_fill2('3')
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL astt301_idx_chk()
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
                                                
                        #END add-point
                        
                     END IF
 
 
                  ON ACTION asti202
 
                     LET g_action_choice="asti202"
                     IF cl_auth_chk_act("asti202") THEN 
                        #add-point:ON ACTION asti202
                                                
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
        
         DISPLAY ARRAY g_stak2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL astt301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作
                              
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               CALL astt301_idx_chk()
               #add-point:page2自定義行為
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為
                        
            #end add-point
         
         END DISPLAY
 
 
         
         #add-point:ui_dialog段自定義display array
       DISPLAY ARRAY g_stak4_d TO s_detail8.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL astt301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail8")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作
                              
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail8")
               LET g_current_page = 8
               CALL astt301_idx_chk()
               #add-point:page2自定義行為
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為
                        
            #end add-point
         
       END DISPLAY

      DISPLAY ARRAY g_stak3_d TO s_detail7.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL astt301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail7")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作
                              
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 7
               CALL astt301_idx_chk()
               #add-point:page2自定義行為
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為
                        
            #end add-point
         
         END DISPLAY
         
      



      DISPLAY ARRAY g_stal_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) #page1  
    
            BEFORE ROW
               CALL astt301_idx_chk()
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx3 = l_ac3
               
               #add-point:page1, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx3)
               LET l_ac3 = DIALOG.getCurrentRow("s_detail3")
               CALL astt301_idx_chk()
               LET g_current_page = 3
               
            #自訂ACTION(detail_show,page_1)
            

            #add-point:page1自定義行為
            
            #end add-point
               
         END DISPLAY 
         
         DISPLAY ARRAY g_staw_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL astt301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作
               
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               CALL astt301_idx_chk()
   
   
         END DISPLAY
         
         #########################
         DISPLAY ARRAY g_stay_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL astt301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx2 = l_ac
               
               #add-point:page2, before row動作
               
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page =5 
               CALL astt301_idx_chk()
   
   
         END DISPLAY
         
          DISPLAY ARRAY g_stay1_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL astt301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx2 = l_ac
               
               #add-point:page2, before row動作
               
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page =6 
               CALL astt301_idx_chk()
   
   
         END DISPLAY

         DISPLAY ARRAY g_stbw_d TO s_detail9.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL astt301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail9")
               LET g_detail_idx = l_ac
               
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail9")
               LET g_current_page = 9
               CALL astt301_idx_chk()
   
         END DISPLAY
         #########################
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
               CALL astt301_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL astt301_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL astt301_idx_chk()
            
            #add-point:ui_dialog段before_dialog2
                  
            #end add-point
            
            #NEXT FIELD stakseq
        
         ON ACTION statechange
            CALL astt301_statechange()
            LET g_action_choice = "statechange"
            EXIT DIALOG
      
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status
            
            #END add-point
          
         #ACTION表單列
         ON ACTION filter
            CALL astt301_filter()
            EXIT DIALOG
         
         ON ACTION first
            CALL astt301_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt301_idx_chk()
            
         ON ACTION previous
            CALL astt301_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt301_idx_chk()
            
         ON ACTION jump
            CALL astt301_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt301_idx_chk()
            
         ON ACTION next
            CALL astt301_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt301_idx_chk()
            
         ON ACTION last
            CALL astt301_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt301_idx_chk()
            
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
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL astt301_insert()
               #add-point:ON ACTION insert
                              
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL astt301_query()
               #add-point:ON ACTION query
                              
               #END add-point
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
                              
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL astt301_delete()
               #add-point:ON ACTION delete
                              
               #END add-point
            END IF
 
 
         ON ACTION modify
 
            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL astt301_modify()
               #add-point:ON ACTION modify
               CALL astt301_b_fill()
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify_detail
 
            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN 
               CALL astt301_modify()
               #add-point:ON ACTION modify_detail
               CALL astt301_b_fill()
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL astt301_reproduce()
               #add-point:ON ACTION reproduce
                              
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION prog_staj001
 
            LET g_action_choice="prog_staj001"
            IF cl_auth_chk_act("prog_staj001") THEN 
               CALL cl_cmdrun_wait("astm301")
               #add-point:ON ACTION prog_staj001
                              
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION prog_staj004
 
            LET g_action_choice="prog_staj004"
            IF cl_auth_chk_act("prog_staj004") THEN 
               CALL cl_cmdrun_wait("astm201")
               #add-point:ON ACTION prog_staj004
                              
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION prog_staj005
 
            LET g_action_choice="prog_staj005"
            IF cl_auth_chk_act("prog_staj005") THEN 
               CALL cl_cmdrun_wait("apmm800")
               #add-point:ON ACTION prog_staj005
                              
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION prog_staj006
 
            LET g_action_choice="prog_staj006"
            IF cl_auth_chk_act("prog_staj006") THEN 
               CALL cl_cmdrun_wait("aooi140")
               #add-point:ON ACTION prog_staj006
                              
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION prog_staj007
 
            LET g_action_choice="prog_staj007"
            IF cl_auth_chk_act("prog_staj007") THEN 
               CALL cl_cmdrun_wait("aooi610")
               #add-point:ON ACTION prog_staj007
                              
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION prog_staj009
 
            LET g_action_choice="prog_staj009"
            IF cl_auth_chk_act("prog_staj009") THEN 
               CALL cl_cmdrun_wait("asti201")
               #add-point:ON ACTION prog_staj009
                              
               #END add-point
               EXIT DIALOG
            END IF
 
         #ken---add---s 需求單號：150107-00009 項次：11
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
                  LET g_export_node[1] = base.typeInfo.create(g_stak_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  LET g_export_node[2] = base.typeInfo.create(g_stak2_d)
                  LET g_export_id[2]   = "s_detail2"
                  
                  LET g_export_node[3] = base.typeInfo.create(g_stal_d)
                  LET g_export_id[3]   = "s_detail3"
                  
                           
                  LET g_export_node[4] = base.typeInfo.create(g_staw_d)
                  LET g_export_id[4]   = "s_detail4"
                  
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
         #ken---add---e
         
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
 
{<section id="astt301.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION astt301_browser_fill(ps_page_action)
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
   DEFINE l_where           STRING #ken 需求單號：141208-00001 項次：18   
   CALL g_stal_d.clear()
   CALL g_staw_d.clear()
   CALL g_stak3_d.clear()
   CALL g_stak4_d.clear()
   CALL g_stay_d.clear()
   CALL g_stay1_d.clear()
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_staj_m.* TO NULL
   CALL g_stak_d.clear()        
   CALL g_stak2_d.clear() 
 
 
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "stajdocno"
 
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   #170106-00009#1-S
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   #170106-00009#1-E
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   #add-point:browser_fill,foreach前
   #IF cl_null(g_wc)  THEN LET g_wc  = " 1=1" END IF   #160810-00002#1 160812 by lori mark
   #IF cl_null(g_wc2) THEN LET g_wc2 = " 1=1" END IF   #160810-00002#1 160812 by lori mark
   #ken------------------------s 需求單號：141208-00001 項次：18
   CALL s_aooi500_sql_where(g_prog,'stajsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where   
   #ken------------------------e
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  
      RETURN
   END IF

  # LET l_wc = l_wc CLIPPED," AND staj002='1' "
  # LET g_wc = g_wc CLIPPED," AND staj002='1' "    
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE stajdocno ",
 
                        " FROM staj_t ",
                              " ",
                              " LEFT JOIN stak_t ON stakent = stajent AND stajdocno = stakdocno ",
                              " LEFT JOIN stam_t ON stament = stajent AND stajdocno = stamdocno", 
 
 
 
                              " ", 
                              " ", 
                       " WHERE stajent = '" ||g_enterprise|| "' AND stakent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE stajdocno ",
 
                        " FROM staj_t ", 
                              " ",
                              " ",
                        "WHERE stajent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
 
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
   IF cl_null(g_wc2_table1) THEN 
      LET g_wc2_table1 = " 1=1"
   END IF 
   IF cl_null(g_wc2_table2) THEN 
      LET g_wc2_table2 = " 1=1"
   END IF 
   IF cl_null(g_wc2_table3) THEN 
      LET g_wc2_table3 = " 1=1"
   END IF 
   IF cl_null(g_wc2_table4) THEN 
      LET g_wc2_table4 = " 1=1"
   END IF 
   IF cl_null(g_wc2_table5) THEN 
      LET g_wc2_table5 = " 1=1"
   END IF 
   IF cl_null(g_wc2_table6) THEN 
      LET g_wc2_table6 = " 1=1"
   END IF 
   IF cl_null(g_wc2_table7) THEN 
      LET g_wc2_table7 = " 1=1"
   END IF 
   IF cl_null(g_wc2_table8) THEN 
      LET g_wc2_table8 = " 1=1"
   END IF 
   IF cl_null(g_wc2_table9) THEN 
      LET g_wc2_table9 = " 1=1"
   END IF
   LET l_sub_sql = " SELECT UNIQUE stajdocno ",
                   "   FROM staj_t "
   IF g_wc2_table1 <> " 1=1" THEN 
      LET l_sub_sql = l_sub_sql," LEFT JOIN stak_t ON stakent = stajent AND stajdocno = stakdocno "
   END IF 
   IF g_wc2_table2 <> " 1=1" THEN 
      LET l_sub_sql = l_sub_sql," LEFT JOIN stam_t ON stament = stajent AND stajdocno = stamdocno"
   END IF 
   IF g_wc2_table3 <> " 1=1" THEN 
      LET l_sub_sql = l_sub_sql," LEFT JOIN stal_t ON stalent = stajent AND staldocno = stajdocno "
   END IF 
   IF g_wc2_table4 <> " 1=1" THEN 
      LET l_sub_sql = l_sub_sql," LEFT JOIN staw_t ON stawent = stajent AND stajdocno = stawdocno"
   END IF 
   IF g_wc2_table5 <> " 1=1" OR g_wc2_table6 <> " 1=1" THEN 
      LET l_sub_sql = l_sub_sql," LEFT JOIN stay_t ON stayent = stajent AND staydocno = stajdocno "
   END IF
   IF g_wc2_table7 <> " 1=1" THEN 
      LET l_sub_sql = l_sub_sql," LEFT JOIN stbj_t ON stbjent = stajent AND stbjdocno = stajdocno "
   END IF 
   IF g_wc2_table8 <> " 1=1" THEN 
      LET l_sub_sql = l_sub_sql," LEFT JOIN stbn_t ON stbnent = stajent AND stbndocno = stajdocno "
   END IF 
   IF g_wc2_table9 <> " 1=1" THEN 
      LET l_sub_sql = l_sub_sql," LEFT JOIN stbw_t ON stbwent = stajent AND stajdocno = stajdocno"
   END IF 
   LET l_sub_sql = l_sub_sql," WHERE stajent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, " AND ", l_wc2 CLIPPED,cl_sql_add_filter("staj_t")  #161214-00032#1 add  CLIPPED,cl_sql_add_filter("staj_t") 
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
      #依照stajdocno,stajdocdt,staj000,staj001,staj002,staj003,staj004,staj005,staj006,staj007,staj008,staj009,staj010,staj011,staj012,staj013,staj014,staj015,staj016,staj017,staj018,staj019,staj020,staj021,stajsite,stajacti Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT stajstus,stajdocno,stajdocdt,staj000,staj001,staj002,staj003, 
          staj004,staj005,staj006,staj007,staj008,staj024,staj025,staj026,staj027,staj028,staj029,staj030,staj009,staj010,staj011,staj012,staj013,staj014,staj041,staj015, 
          staj016,staj017,staj018,staj019,staj020,staj021,stajsite,stajacti,DENSE_RANK() OVER(ORDER BY stajdocno ", 
          g_order,") AS RANK ",
                        " FROM staj_t ",
                              " ",
                              " LEFT JOIN stak_t ON stakent = stajent AND stajdocno = stakdocno ",
                              " LEFT JOIN stam_t ON stament = stajent AND stajdocno = stamdocno",
 
 
 
                              " ",
                              " ",
                       " ",
                       " WHERE stajent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT stajstus,stajdocno,stajdocdt,staj000,staj001,staj002,staj003, 
          staj004,staj005,staj006,staj007,staj008,staj024,staj025,staj026,staj027,staj028,staj029,staj030,staj009,staj010,staj011,staj012,staj013,staj014,staj015, 
          staj016,staj017,staj018,staj019,staj020,staj021,stajsite,stajacti,DENSE_RANK() OVER(ORDER BY stajdocno ", 
          g_order,") AS RANK ",
                       " FROM staj_t ",
                            "  ",
                            "  ",
                       " WHERE stajent = '" ||g_enterprise|| "' AND ", g_wc
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT stajstus,stajdocno,stajdocdt,staj000,staj001,staj002,staj003,staj004,staj005,staj006, 
       staj007,staj008,staj024,staj025,staj026,staj027,staj028,staj029,staj030,staj009,staj010,staj011,staj012,staj013,staj014,staj041,staj015,staj016,staj017,staj018, 
       staj019,staj020,staj021,stajsite,stajacti FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
               
   #add-point:browser_fill,before_prepare
   LET l_sql_rank = "SELECT DISTINCT stajstus,stajdocno,stajdocdt,staj000,staj001,staj002,staj003, 
                                     staj004,staj005,staj006,staj007,staj008,staj024,staj025,staj026,staj027,staj028,staj029,staj030,staj009,staj010,staj011,staj012,staj013,staj014,staj015, 
                                     staj016,staj017,staj018,staj019,staj020,staj021,stajsite,stajacti,DENSE_RANK() OVER(ORDER BY stajdocno ", 
                                     g_order,") AS RANK ",
                        " FROM staj_t "
   IF g_wc2_table1 <> " 1=1" THEN 
      LET l_sql_rank = l_sql_rank," LEFT JOIN stak_t ON stakent = stajent AND stajdocno = stakdocno "
   END IF 
   IF g_wc2_table2 <> " 1=1" THEN 
      LET l_sql_rank = l_sql_rank," LEFT JOIN stam_t ON stament = stajent AND stajdocno = stamdocno"
   END IF 
   IF g_wc2_table3 <> " 1=1" THEN 
      LET l_sql_rank = l_sql_rank," LEFT JOIN stal_t ON stalent = stajent AND staldocno = stajdocno "
   END IF 
   IF g_wc2_table4 <> " 1=1" THEN 
      LET l_sql_rank = l_sql_rank," LEFT JOIN staw_t ON stawent = stajent AND stawdocno = stajdocno"
   END IF 
   IF g_wc2_table5 <> " 1=1" OR g_wc2_table6 <> " 1=1" THEN 
      LET l_sql_rank = l_sql_rank," LEFT JOIN stay_t ON stayent = stajent AND staydocno = stajdocno "
   END IF
   IF g_wc2_table7 <> " 1=1" THEN 
      LET l_sql_rank = l_sql_rank," LEFT JOIN stbj_t ON stbjent = stajent AND stbjdocno = stajdocno "
   END IF 
   IF g_wc2_table8 <> " 1=1" THEN 
      LET l_sql_rank = l_sql_rank," LEFT JOIN stbn_t ON stbnent = stajent AND stbndocno = stajdocno "
   END IF 
   IF g_wc2_table9 <> " 1=1" THEN 
      LET l_sql_rank = l_sql_rank," LEFT JOIN stbw_t ON stbwent = stajent AND stbwdocno = stajdocno"
   END IF 
   LET l_sql_rank = l_sql_rank," WHERE stajent = '" ||g_enterprise|| "' AND ", g_wc," AND ",g_wc2 CLIPPED,cl_sql_add_filter("staj_t")  #161214-00032#1 add  CLIPPED,cl_sql_add_filter("staj_t") 
   #定義翻頁CURSOR
   LET g_sql= "SELECT stajstus,stajdocno,stajdocdt,staj000,staj001,staj002,staj003,staj004,staj005,staj006, 
       staj007,staj008,staj009,staj010,staj011,staj012,staj013,staj014,staj015,staj016,staj017,staj018, 
       staj019,staj020,staj021,stajsite,stajacti FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
   #end add-point
               
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill,open
      
   #end add-point
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_stajdocno,g_browser[g_cnt].b_stajdocdt, 
       g_browser[g_cnt].b_staj000,g_browser[g_cnt].b_staj001,g_browser[g_cnt].b_staj002,g_browser[g_cnt].b_staj003, 
       g_browser[g_cnt].b_staj004,g_browser[g_cnt].b_staj005,g_browser[g_cnt].b_staj006,g_browser[g_cnt].b_staj007, 
       g_browser[g_cnt].b_staj008,g_browser[g_cnt].b_staj009,g_browser[g_cnt].b_staj010,g_browser[g_cnt].b_staj011, 
       g_browser[g_cnt].b_staj012,g_browser[g_cnt].b_staj013,g_browser[g_cnt].b_staj014,g_browser[g_cnt].b_staj015, 
       g_browser[g_cnt].b_staj016,g_browser[g_cnt].b_staj017,g_browser[g_cnt].b_staj018,g_browser[g_cnt].b_staj019, 
       g_browser[g_cnt].b_staj020,g_browser[g_cnt].b_staj021,g_browser[g_cnt].b_stajsite,g_browser[g_cnt].b_stajacti 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      
  
      #add-point:browser_fill段reference
      SELECT pmaal004 INTO  g_browser[g_cnt].b_staj005_desc FROM pmaal_t
       WHERE pmaalent = g_enterprise AND pmaal001 =  g_browser[g_cnt].b_staj005 AND pmaal002 = g_dlang     
      #end add-point
  
            #此段落由子樣板a24產生
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
 
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
 
{<section id="astt301.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION astt301_ui_headershow()
   #add-point:ui_headershow段define
      
   #end add-point    
   
   LET g_staj_m.stajdocno = g_browser[g_current_idx].b_stajdocno   
 
    SELECT UNIQUE staj000,staj039,stajdocno,stajdocdt,staj002,staj001,staj003,staj021,staj004,staj005,staj006, 
        staj007,staj008,
        staj024,staj025,staj026,staj027,staj028,staj029,staj030, #150506-00007#3 150522 by sakura add
        staj031,staj033,staj034,
        staj009,staj010,staj015,staj016,staj011,staj012,staj013,staj014,staj017, 
        staj018,staj019,staj020,stajsite,stajunit,stajstus,stajownid,stajowndp,stajcrtid,stajcrtdp,stajcrtdt, 
        stajmodid,stajmoddt,stajcnfid,stajcnfdt
 INTO g_staj_m.staj000,g_staj_m.staj039,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_staj_m.staj002,g_staj_m.staj001,g_staj_m.staj003, 
     g_staj_m.staj021,g_staj_m.staj004,g_staj_m.staj005,g_staj_m.staj006,g_staj_m.staj007,g_staj_m.staj008, 
     g_staj_m.staj024,g_staj_m.staj025,g_staj_m.staj026,g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj029,g_staj_m.staj030, #150506-00007#3 150522 by sakura add
     g_staj_m.staj031,g_staj_m.staj033,g_staj_m.staj034,
     g_staj_m.staj009,g_staj_m.staj010,g_staj_m.staj015,g_staj_m.staj016,g_staj_m.staj011,
     g_staj_m.staj012,g_staj_m.staj013,g_staj_m.staj014,g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj019, 
     g_staj_m.staj020,g_staj_m.stajsite,g_staj_m.stajunit,g_staj_m.stajstus,g_staj_m.stajownid,g_staj_m.stajowndp, 
     g_staj_m.stajcrtid,g_staj_m.stajcrtdp,g_staj_m.stajcrtdt,g_staj_m.stajmodid,g_staj_m.stajmoddt, 
     g_staj_m.stajcnfid,g_staj_m.stajcnfdt
 FROM staj_t
 WHERE stajent = g_enterprise AND stajdocno = g_staj_m.stajdocno
   CALL astt301_show()
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION astt301_ui_detailshow()
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
 
{<section id="astt301.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION astt301_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
      
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_stajdocno = g_staj_m.stajdocno 
 
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
 
{<section id="astt301.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION astt301_construct()
 
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   {</Local define>}
   #add-point:cs段define
   DEFINE  l_sys                 LIKE type_t.num5      
       
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_staj_m.* TO NULL
   CALL g_stak_d.clear()        
   CALL g_stak2_d.clear()
   CALL g_stak3_d.clear()
   CALL g_stak4_d.clear()   
   CALL g_staw_d.clear() 
   CALL g_stay_d.clear()
   CALL g_stay1_d.clear()
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
   INITIALIZE g_wc2_table7 TO NULL
   INITIALIZE g_wc2_table8 TO NULL
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   CALL g_stal_d.clear()  
   CALL g_stbw_d.clear()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON stajsite,stajdocdt,stajdocno,staj000,staj039,staj001,staj003,
          staj004,staj002,staj031,staj021,staj005,staj016,
          staj017,staj018,staj012,staj014,staj041,staj013,
          staj036,staj037,staj038,staj015,staj009,staj010,
          staj034,staj042,staj033,staj035,staj019,staj020,staj029,
          staj030,staj008,staj024,staj006,staj007,staj025,
          staj040,staj026,staj027,staj028,staj011,stajstus,stajownid,stajowndp, 
          stajcrtid,stajcrtdp,stajcrtdt,stajmodid,stajmoddt,stajcnfid,stajcnfdt
 
         BEFORE CONSTRUCT
#saki            CALL cl_qbe_init()
            #add-point:cs段before_construct
                        
            #end add-point 
            
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<stajownid>>----
         #ON ACTION controlp INFIELD stajownid
         #   CALL q_common('staj_t','stajownid',TRUE,FALSE,g_staj_m.stajownid) RETURNING ls_return
         #   DISPLAY ls_return TO stajownid
         #   NEXT FIELD stajownid  
         #
         ##----<<stajowndp>>----
         #ON ACTION controlp INFIELD stajowndp
         #   CALL q_common('staj_t','stajowndp',TRUE,FALSE,g_staj_m.stajowndp) RETURNING ls_return
         #   DISPLAY ls_return TO stajowndp
         #   NEXT FIELD stajowndp
         #
         ##----<<stajcrtid>>----
         #ON ACTION controlp INFIELD stajcrtid
         #   CALL q_common('staj_t','stajcrtid',TRUE,FALSE,g_staj_m.stajcrtid) RETURNING ls_return
         #   DISPLAY ls_return TO stajcrtid
         #   NEXT FIELD stajcrtid
         #
         ##----<<stajcrtdp>>----
         #ON ACTION controlp INFIELD stajcrtdp
         #   CALL q_common('staj_t','stajcrtdp',TRUE,FALSE,g_staj_m.stajcrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO stajcrtdp
         #   NEXT FIELD stajcrtdp
         #
         ##----<<stajmodid>>----
         #ON ACTION controlp INFIELD stajmodid
         #   CALL q_common('staj_t','stajmodid',TRUE,FALSE,g_staj_m.stajmodid) RETURNING ls_return
         #   DISPLAY ls_return TO stajmodid
         #   NEXT FIELD stajmodid
         #
         ##----<<stajcnfid>>----
         #ON ACTION controlp INFIELD stajcnfid
         #   CALL q_common('staj_t','stajcnfid',TRUE,FALSE,g_staj_m.stajcnfid) RETURNING ls_return
         #   DISPLAY ls_return TO stajcnfid
         #   NEXT FIELD stajcnfid
         #
         ##----<<stajpstid>>----
         ##ON ACTION controlp INFIELD stajpstid
         ##   CALL q_common('staj_t','stajpstid',TRUE,FALSE,g_staj_m.stajpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO stajpstid
         ##   NEXT FIELD stajpstid
         
         ##----<<stajcrtdt>>----
         AFTER FIELD stajcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stajmoddt>>----
         AFTER FIELD stajmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stajcnfdt>>----
         AFTER FIELD stajcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stajpstdt>>----
         #AFTER FIELD stajpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
            
         #一般欄位開窗相關處理    
         #---------------------------<  Master  >---------------------------
         #----<<staj000>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj000
            #add-point:BEFORE FIELD staj000
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj000
            
            #add-point:AFTER FIELD staj000
                        
            #END add-point
            
 
         #Ctrlp:construct.c.staj000
         ON ACTION controlp INFIELD staj000
            #add-point:ON ACTION controlp INFIELD staj000
                        
            #END add-point
 
         #----<<stajdocno>>----
         #Ctrlp:construct.c.stajdocno
         ON ACTION controlp INFIELD stajdocno
            #add-point:ON ACTION controlp INFIELD stajdocno
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_stajdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stajdocno  #顯示到畫面上

            NEXT FIELD stajdocno                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stajdocno
            #add-point:BEFORE FIELD stajdocno
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajdocno
            
            #add-point:AFTER FIELD stajdocno
                        
            #END add-point
            
 
         #----<<stajdocdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stajdocdt
            #add-point:BEFORE FIELD stajdocdt
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajdocdt
            
            #add-point:AFTER FIELD stajdocdt
                        
            #END add-point
            
 
         #Ctrlp:construct.c.stajdocdt
         ON ACTION controlp INFIELD stajdocdt
            #add-point:ON ACTION controlp INFIELD stajdocdt
                        
            #END add-point
 
         #----<<staj002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj002
            #add-point:BEFORE FIELD staj002
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj002
            
            #add-point:AFTER FIELD staj002
                        
            #END add-point
            
 
         #Ctrlp:construct.c.staj002
         ON ACTION controlp INFIELD staj002
            #add-point:ON ACTION controlp INFIELD staj002
                        
            #END add-point
 
         #----<<staj001>>----
         #Ctrlp:construct.c.staj001
         ON ACTION controlp INFIELD staj001
            #add-point:ON ACTION controlp INFIELD staj001
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " stanent =",g_enterprise   #add by geza 20150614
            CALL q_stan001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staj001  #顯示到畫面上

            NEXT FIELD staj001                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj001
            #add-point:BEFORE FIELD staj001
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj001
            
            #add-point:AFTER FIELD staj001
                        
            #END add-point
            
 
         #----<<staj003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj003
            #add-point:BEFORE FIELD staj003
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj003
            
            #add-point:AFTER FIELD staj003
                        
            #END add-point
            
 
         #Ctrlp:construct.c.staj003
         ON ACTION controlp INFIELD staj003
            #add-point:ON ACTION controlp INFIELD staj003
                        
            #END add-point
 
         #----<<staj021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj021
            #add-point:BEFORE FIELD staj021
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj021
            
            #add-point:AFTER FIELD staj021
                        
            #END add-point
            
 
         #Ctrlp:construct.c.staj021
         ON ACTION controlp INFIELD staj021
            #add-point:ON ACTION controlp INFIELD staj021
                        
            #END add-point
 
         
                        
    
 
        
            
                        
          
            
 
       
                        
          
 
         #----<<staj004>>----
         #Ctrlp:construct.c.staj004
         ON ACTION controlp INFIELD staj004
            #add-point:ON ACTION controlp INFIELD staj004
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_stag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staj004  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stagl003 #說明 

            NEXT FIELD staj004                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj004
            #add-point:BEFORE FIELD staj004
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj004
            
            #add-point:AFTER FIELD staj004
                        
            #END add-point
            
 
         #----<<staj005>>----
         #Ctrlp:construct.c.staj005
         ON ACTION controlp INFIELD staj005
            #add-point:ON ACTION controlp INFIELD staj005
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staj005  #顯示到畫面上

            NEXT FIELD staj005                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj005
            #add-point:BEFORE FIELD staj005
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj005
            
            #add-point:AFTER FIELD staj005
                        
            #END add-point
            
 
         #----<<staj006>>----
         #Ctrlp:construct.c.staj006
         ON ACTION controlp INFIELD staj006
            #add-point:ON ACTION controlp INFIELD staj006
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staj006  #顯示到畫面上

            NEXT FIELD staj006                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj006
            #add-point:BEFORE FIELD staj006
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj006
            
            #add-point:AFTER FIELD staj006
                        
            #END add-point
            
 
         #----<<staj007>>----
         #Ctrlp:construct.c.staj007
         ON ACTION controlp INFIELD staj007
            #add-point:ON ACTION controlp INFIELD staj007
                                    #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_site
            CALL q_oodb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staj007  #顯示到畫面上

            NEXT FIELD staj007                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj007
            #add-point:BEFORE FIELD staj007
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj007
            
            #add-point:AFTER FIELD staj007
                        
            #END add-point
            
 
         #----<<staj008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj008
            #add-point:BEFORE FIELD staj008
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj008
            
            #add-point:AFTER FIELD staj008
                        
            #END add-point
            
 
         #Ctrlp:construct.c.staj008
         ON ACTION controlp INFIELD staj008
            #add-point:ON ACTION controlp INFIELD staj008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooib002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staj008  #顯示到畫面上

            NEXT FIELD staj008                     #返回原欄位            
            #END add-point
            
         #150506-00007#3 150522 by sakura add--STR
         #交易條件
         ON ACTION controlp INFIELD staj024
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '238'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO staj024
            NEXT FIELD staj024
         #發票類型
         ON ACTION controlp INFIELD staj025
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_ooef019 #稅區
            LET g_qryparam.arg2 = "1"       #進銷項類型            
            CALL q_isac002_2()
            DISPLAY g_qryparam.return1 TO staj025
            NEXT FIELD staj025            
         #150506-00007#3 150522 by sakura add--END
 
         #----<<staj009>>----
         #Ctrlp:construct.c.staj009
         ON ACTION controlp INFIELD staj009
            #add-point:ON ACTION controlp INFIELD staj009
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " staaent = ",g_enterprise," "  #150613-00002#1--add by dongsz
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staj009  #顯示到畫面上

            NEXT FIELD staj009                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj009
            #add-point:BEFORE FIELD staj009
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj009
            
            #add-point:AFTER FIELD staj009
                        
            #END add-point
            
 
         #----<<staj010>>----
         #Ctrlp:construct.c.staj010
         ON ACTION controlp INFIELD staj010
            #add-point:ON ACTION controlp INFIELD staj010
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			  LET g_qryparam.arg1 = "2060"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staj010  #顯示到畫面上

            NEXT FIELD staj010                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj010
            #add-point:BEFORE FIELD staj010
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj010
            
            #add-point:AFTER FIELD staj010
                        
            #END add-point
            
 
         #----<<staj015>>----
         #Ctrlp:construct.c.staj015
         ON ACTION controlp INFIELD staj015
            #add-point:ON ACTION controlp INFIELD staj015
                                    #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = 'A'
#            LET g_qryparam.where = "ooef212 = 'Y'"
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'staj015') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'staj015',g_site,'c')
               CALL q_ooef001_23() 
            ELSE
               LET g_qryparam.where = "ooef212 = 'Y'"
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO staj015  #顯示到畫面上

            NEXT FIELD staj015                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj015
            #add-point:BEFORE FIELD staj015
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj015
            
            #add-point:AFTER FIELD staj015
                        
            #END add-point
            
 
         #----<<staj016>>----
         #Ctrlp:construct.c.staj016
         ON ACTION controlp INFIELD staj016
            #add-point:ON ACTION controlp INFIELD staj016
                                    #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = 'D'
#            LET g_qryparam.where = "ooef303 = 'Y'"
#            CALL q_ooef001()                             #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'staj016') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'staj016',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef303 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO staj016  #顯示到畫面上

            NEXT FIELD staj016                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj016
            #add-point:BEFORE FIELD staj016
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj016
            
            #add-point:AFTER FIELD staj016
                        
            #END add-point
            
 
         #----<<staj011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj011
            #add-point:BEFORE FIELD staj011
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj011
            
            #add-point:AFTER FIELD staj011
                        
            #END add-point
            
 
         #Ctrlp:construct.c.staj011
         ON ACTION controlp INFIELD staj011
            #add-point:ON ACTION controlp INFIELD staj011
                        
 
                        
 
                        
 
 
                        
 
         #----<<staj012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj012
            #add-point:BEFORE FIELD staj012
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj012
            
            #add-point:AFTER FIELD staj012
                        
            #END add-point
            
 
         #Ctrlp:construct.c.staj012
         ON ACTION controlp INFIELD staj012
            #add-point:ON ACTION controlp INFIELD staj012
                        
            #END add-point
 
         #----<<staj013>>----
         #Ctrlp:construct.c.staj013
         ON ACTION controlp INFIELD staj013
            #add-point:ON ACTION controlp INFIELD staj013
                                    #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
           # LET g_qryparam.arg1 = '1'
#            LET g_qryparam.where = "ooef003 = 'Y'"
#            CALL q_ooef001()                          #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'staj013') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'staj013',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef003 = 'Y'"
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO staj013  #顯示到畫面上

            NEXT FIELD staj013                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj013
            #add-point:BEFORE FIELD staj013
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj013
            
            #add-point:AFTER FIELD staj013
                        
            #END add-point
            
 
         #----<<staj014>>----
         #Ctrlp:construct.c.staj014
         ON ACTION controlp INFIELD staj014
            #add-point:ON ACTION controlp INFIELD staj014
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staj014  #顯示到畫面上

            NEXT FIELD staj014                     #返回原欄位


            #END add-point
         ON ACTION controlp INFIELD staj041
            #add-point:ON ACTION controlp INFIELD staj014
                                    #此段落由子樣板a08產生
            #開窗c段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staj041  #顯示到畫面上
 
            NEXT FIELD staj041                     #返回原欄位
            
         #此段落由子樣板a01產生
         BEFORE FIELD staj014
            #add-point:BEFORE FIELD staj014
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj014
            
            #add-point:AFTER FIELD staj014
                        
            #END add-point
            
 
         #----<<staj017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj017
            #add-point:BEFORE FIELD staj017
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj017
            
            #add-point:AFTER FIELD staj017
                        
            #END add-point
            
 
         #Ctrlp:construct.c.staj017
         ON ACTION controlp INFIELD staj017
            #add-point:ON ACTION controlp INFIELD staj017
                        
            #END add-point
 
         #----<<staj018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj018
            #add-point:BEFORE FIELD staj018
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj018
            
            #add-point:AFTER FIELD staj018
                        
            #END add-point
            
 
         #Ctrlp:construct.c.staj018
         ON ACTION controlp INFIELD staj018
            #add-point:ON ACTION controlp INFIELD staj018
                        
            #END add-point
 
         #----<<staj019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj019
            #add-point:BEFORE FIELD staj019
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj019
            
            #add-point:AFTER FIELD staj019
                        
            #END add-point
            
 
         #Ctrlp:construct.c.staj019
         ON ACTION controlp INFIELD staj019
            #add-point:ON ACTION controlp INFIELD staj019
                        
            #END add-point
 
         #----<<staj020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj020
            #add-point:BEFORE FIELD staj020
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj020
            
            #add-point:AFTER FIELD staj020
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)            
            #END add-point
            
 
         #Ctrlp:construct.c.staj020
         ON ACTION controlp INFIELD staj020
            #add-point:ON ACTION controlp INFIELD staj020
 
            #END add-point
 
         #----<<stajsite>>----
         #Ctrlp:construct.c.stajsite
         ON ACTION controlp INFIELD stajsite
            #add-point:ON ACTION controlp INFIELD stajsite
                                    #此段落由子樣板a08產生
            #開窗c段
			#ken_mark---------------------------s
			#INITIALIZE g_qryparam.* TO NULL
         #   LET g_qryparam.state = 'c'
			#LET g_qryparam.reqry = FALSE
			##LET g_qryparam.arg1 = '2'
			#   LET g_qryparam.where = "ooef201 = 'Y'"
         #   CALL q_ooef001()                           #呼叫開窗
         #   DISPLAY g_qryparam.return1 TO stajsite  #顯示到畫面上
         #
         #   NEXT FIELD stajsite                     #返回原欄位
         #ken_mark---------------------------e
         
         #ken---------------------------s 需求單號：141208-00001 項次：18
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = s_aooi500_q_where(g_prog,'stajsite',g_site,'c')
         CALL q_ooef001_24()                     #呼叫開窗
         DISPLAY g_qryparam.return1 TO stajsite  #顯示到畫面上
         NEXT FIELD stajsite                     #返回原欄位
         #ken---------------------------e   

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stajsite
            #add-point:BEFORE FIELD stajsite
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajsite
            
            #add-point:AFTER FIELD stajsite
                        
            #END add-point
            
 
         #----<<stajunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stajunit
            #add-point:BEFORE FIELD stajunit
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajunit
            
            #add-point:AFTER FIELD stajunit
                        
            #END add-point
            
 
         #Ctrlp:construct.c.stajunit
         ON ACTION controlp INFIELD stajunit
            #add-point:ON ACTION controlp INFIELD stajunit
                        
            #END add-point
 
         #----<<stajstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stajstus
            #add-point:BEFORE FIELD stajstus
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajstus
            
            #add-point:AFTER FIELD stajstus
                        
            #END add-point
            
 
         #Ctrlp:construct.c.stajstus
         ON ACTION controlp INFIELD stajstus
            #add-point:ON ACTION controlp INFIELD stajstus
                        
            #END add-point
 
         #----<<stajownid>>----
         #Ctrlp:construct.c.stajownid
         ON ACTION controlp INFIELD stajownid
            #add-point:ON ACTION controlp INFIELD stajownid
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stajownid  #顯示到畫面上

            NEXT FIELD stajownid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stajownid
            #add-point:BEFORE FIELD stajownid
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajownid
            
            #add-point:AFTER FIELD stajownid
                        
            #END add-point
            
 
         #----<<stajowndp>>----
         #Ctrlp:construct.c.stajowndp
         ON ACTION controlp INFIELD stajowndp
            #add-point:ON ACTION controlp INFIELD stajowndp
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stajowndp  #顯示到畫面上

            NEXT FIELD stajowndp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stajowndp
            #add-point:BEFORE FIELD stajowndp
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajowndp
            
            #add-point:AFTER FIELD stajowndp
                        
            #END add-point
            
 
         #----<<stajcrtid>>----
         #Ctrlp:construct.c.stajcrtid
         ON ACTION controlp INFIELD stajcrtid
            #add-point:ON ACTION controlp INFIELD stajcrtid
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stajcrtid  #顯示到畫面上

            NEXT FIELD stajcrtid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stajcrtid
            #add-point:BEFORE FIELD stajcrtid
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajcrtid
            
            #add-point:AFTER FIELD stajcrtid
                        
            #END add-point
            
 
         #----<<stajcrtdp>>----
         #Ctrlp:construct.c.stajcrtdp
         ON ACTION controlp INFIELD stajcrtdp
            #add-point:ON ACTION controlp INFIELD stajcrtdp
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stajcrtdp  #顯示到畫面上

            NEXT FIELD stajcrtdp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stajcrtdp
            #add-point:BEFORE FIELD stajcrtdp
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajcrtdp
            
            #add-point:AFTER FIELD stajcrtdp
                        
            #END add-point
            
 
         #----<<stajcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stajcrtdt
            #add-point:BEFORE FIELD stajcrtdt
                        
            #END add-point
 
         #----<<stajmodid>>----
         #Ctrlp:construct.c.stajmodid
         ON ACTION controlp INFIELD stajmodid
            #add-point:ON ACTION controlp INFIELD stajmodid
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stajmodid  #顯示到畫面上

            NEXT FIELD stajmodid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stajmodid
            #add-point:BEFORE FIELD stajmodid
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajmodid
            
            #add-point:AFTER FIELD stajmodid
                        
            #END add-point
            
 
         #----<<stajmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stajmoddt
            #add-point:BEFORE FIELD stajmoddt
                        
            #END add-point
 
         #----<<stajcnfid>>----
         #Ctrlp:construct.c.stajcnfid
         ON ACTION controlp INFIELD stajcnfid
            #add-point:ON ACTION controlp INFIELD stajcnfid
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stajcnfid  #顯示到畫面上

            NEXT FIELD stajcnfid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stajcnfid
            #add-point:BEFORE FIELD stajcnfid
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajcnfid
            
            #add-point:AFTER FIELD stajcnfid
                        
            #END add-point
            
 
         #----<<stajcnfdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stajcnfdt
            #add-point:BEFORE FIELD stajcnfdt
                        
            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON stakseq,stak003,stak023,stak024,stak025,stak004,stak005,stak006,stak028,stak007,stak008,stak027,stak009,stak010, 
          stak011,stak012,stak013,stak014,stak015,stak016,stak029,stak030,stak022,stak017,stak018,stakacti,stak026,stak019,stak020,stak021,stakunit,staksite
           FROM s_detail1[1].stakseq,s_detail1[1].stak003,s_detail1[1].stak023,s_detail1[1].stak024,  #add by geza stak023,stak024 
               s_detail1[1].stak025,s_detail1[1].stak004,s_detail1[1].stak005, 
               s_detail1[1].stak006,s_detail1[1].stak028,s_detail1[1].stak007,s_detail1[1].stak008,s_detail1[1].stak027,s_detail1[1].stak009,s_detail1[1].stak010,   #150612-00023 #add stak027
               s_detail1[1].stak011,s_detail1[1].stak012,s_detail1[1].stak013,s_detail1[1].stak014,s_detail1[1].stak015, 
               s_detail1[1].stak016,s_detail1[1].stak029,s_detail1[1].stak030,s_detail1[1].stak022,s_detail1[1].stak017,s_detail1[1].stak018,s_detail1[1].stakacti,s_detail1[1].stak026,s_detail1[1].stak019,s_detail1[1].stak020,
               s_detail1[1].stak021,s_detail1[1].stakunit, s_detail1[1].staksite
                      
         BEFORE CONSTRUCT
#saki            CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<stakseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stakseq
            #add-point:BEFORE FIELD stakseq
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stakseq
            
            #add-point:AFTER FIELD stakseq
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stakseq
         ON ACTION controlp INFIELD stakseq
            #add-point:ON ACTION controlp INFIELD stakseq
                        
            #END add-point
 
         #----<<stak003>>----
         #Ctrlp:construct.c.page1.stak003
         ON ACTION controlp INFIELD stak003
            #add-point:ON ACTION controlp INFIELD stak003
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stak003  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stael003 #說明 
               #DISPLAY g_qryparam.return3 TO stae001 #費用編號 

            NEXT FIELD stak003                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stak003
            #add-point:BEFORE FIELD stak003
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak003
            
            #add-point:AFTER FIELD stak003
                        
            #END add-point
            
 
         #----<<stak004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak004
            #add-point:BEFORE FIELD stak004
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak004
            
            #add-point:AFTER FIELD stak004
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak004
         ON ACTION controlp INFIELD stak004
            #add-point:ON ACTION controlp INFIELD stak004
            
         ON ACTION controlp INFIELD stak025 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
      
            LET g_qryparam.arg1 = l_sys 
            CALL q_rtax001_3()                       
            DISPLAY g_qryparam.return1 TO stak025  #顯示到畫面上
            NEXT FIELD stak025                     #返回原欄位

         
         
            #END add-point
 
         #----<<stak005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak005
            #add-point:BEFORE FIELD stak005
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak005
            
            #add-point:AFTER FIELD stak005
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak005
         ON ACTION controlp INFIELD stak005
            #add-point:ON ACTION controlp INFIELD stak005
                        
            #END add-point
 
         #----<<stak006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak006
            #add-point:BEFORE FIELD stak006
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak006
            
            #add-point:AFTER FIELD stak006
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak006
         ON ACTION controlp INFIELD stak006
            #add-point:ON ACTION controlp INFIELD stak006
                        
            #END add-point
 
         #----<<stak007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak007
            #add-point:BEFORE FIELD stak007
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak007
            
            #add-point:AFTER FIELD stak007
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak007
         ON ACTION controlp INFIELD stak007
            #add-point:ON ACTION controlp INFIELD stak007
                        
            #END add-point
 
         #----<<stak008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak008
            #add-point:BEFORE FIELD stak008
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak008
            
            #add-point:AFTER FIELD stak008
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak008
         ON ACTION controlp INFIELD stak008
            #add-point:ON ACTION controlp INFIELD stak008
                        
            #END add-point
 
         #----<<stak009>>----
         #Ctrlp:construct.c.page1.stak009
         ON ACTION controlp INFIELD stak009
            #add-point:ON ACTION controlp INFIELD stak009
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_stab001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stak009  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stabl003 #說明 
               #DISPLAY g_qryparam.return3 TO stabl004 #助記碼 

            NEXT FIELD stak009                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stak009
            #add-point:BEFORE FIELD stak009
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak009
            
            #add-point:AFTER FIELD stak009
                        
            #END add-point
            
 
         #----<<stak010>>----
         #Ctrlp:construct.c.page1.stak010
         ON ACTION controlp INFIELD stak010
            #add-point:ON ACTION controlp INFIELD stak010
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_stab001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stak010  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stabl003 #說明 
               #DISPLAY g_qryparam.return3 TO stabl004 #助記碼 

            NEXT FIELD stak010                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stak010
            #add-point:BEFORE FIELD stak010
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak010
            
            #add-point:AFTER FIELD stak010
                        
            #END add-point
            
 
         #----<<stak011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak011
            #add-point:BEFORE FIELD stak011
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak011
            
            #add-point:AFTER FIELD stak011
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak011
         ON ACTION controlp INFIELD stak011
            #add-point:ON ACTION controlp INFIELD stak011
                        
            #END add-point
 
         #----<<stak012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak012
            #add-point:BEFORE FIELD stak012
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak012
            
            #add-point:AFTER FIELD stak012
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak012
         ON ACTION controlp INFIELD stak012
            #add-point:ON ACTION controlp INFIELD stak012
                        
            #END add-point
 
         #----<<stak013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak013
            #add-point:BEFORE FIELD stak013
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak013
            
            #add-point:AFTER FIELD stak013
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak013
         ON ACTION controlp INFIELD stak013
            #add-point:ON ACTION controlp INFIELD stak013
                        
            #END add-point
 
         #----<<stak014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak014
            #add-point:BEFORE FIELD stak014
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak014
            
            #add-point:AFTER FIELD stak014
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak014
         ON ACTION controlp INFIELD stak014
            #add-point:ON ACTION controlp INFIELD stak014
                        
            #END add-point
 
         #----<<stak015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak015
            #add-point:BEFORE FIELD stak015
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak015
            
            #add-point:AFTER FIELD stak015
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak015
         ON ACTION controlp INFIELD stak015
            #add-point:ON ACTION controlp INFIELD stak015
                        
            #END add-point
 
         #----<<stak016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak016
            #add-point:BEFORE FIELD stak016
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak016
            
            #add-point:AFTER FIELD stak016
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak016
         ON ACTION controlp INFIELD stak016
            #add-point:ON ACTION controlp INFIELD stak016
                        
            #END add-point
 
         #----<<stak017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak017
            #add-point:BEFORE FIELD stak017
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak017
            
            #add-point:AFTER FIELD stak017
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak017
         ON ACTION controlp INFIELD stak017
            #add-point:ON ACTION controlp INFIELD stak017
                        
            #END add-point
 
         #----<<stak018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak018
            #add-point:BEFORE FIELD stak018
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak018
            
            #add-point:AFTER FIELD stak018
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak018
         ON ACTION controlp INFIELD stak018
            #add-point:ON ACTION controlp INFIELD stak018
                        
            #END add-point
 
         #----<<stak019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak019
            #add-point:BEFORE FIELD stak019
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak019
            
            #add-point:AFTER FIELD stak019
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stak019
         ON ACTION controlp INFIELD stak019
            #add-point:ON ACTION controlp INFIELD stak019
                        
            #END add-point
 
         #----<<stakunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stakunit
            #add-point:BEFORE FIELD stakunit
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stakunit
            
            #add-point:AFTER FIELD stakunit
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.stakunit
         ON ACTION controlp INFIELD stakunit
            #add-point:ON ACTION controlp INFIELD stakunit
                        
            #END add-point
 
         #----<<staksite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staksite
            #add-point:BEFORE FIELD staksite
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staksite
            
            #add-point:AFTER FIELD staksite
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page1.staksite
         ON ACTION controlp INFIELD staksite
            #add-point:ON ACTION controlp INFIELD staksite
                        
            #END add-point
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON stamseq,stam003,stam005,stam004,stamacti,stamunit,stamsite
           FROM s_detail2[1].stamseq,s_detail2[1].stam003,s_detail2[1].stam005,s_detail2[1].stam004,s_detail2[1].stamacti,s_detail2[1].stamunit, 
               s_detail2[1].stamsite
                      
         BEFORE CONSTRUCT
#saki            CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page2  >---------------------
         #----<<stamseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stamseq
            #add-point:BEFORE FIELD stamseq
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stamseq
            
            #add-point:AFTER FIELD stamseq
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page2.stamseq
         ON ACTION controlp INFIELD stamseq
            #add-point:ON ACTION controlp INFIELD stamseq
                        
            #END add-point
 
         #----<<stam003>>----
         #Ctrlp:construct.c.page2.stam003
         ON ACTION controlp INFIELD stam003
            #add-point:ON ACTION controlp INFIELD stam003
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
            #給予arg
            LET g_qryparam.arg1 = l_sys 
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stam003  #顯示到畫面上

            NEXT FIELD stam003                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stam003
            #add-point:BEFORE FIELD stam003
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stam003
            
            #add-point:AFTER FIELD stam003
 
            #END add-point
            
 
         #----<<stam004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stam004
            #add-point:BEFORE FIELD stam004
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stam004
            
            #add-point:AFTER FIELD stam004
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page2.stam004
         ON ACTION controlp INFIELD stam004
            #add-point:ON ACTION controlp INFIELD stam004
                        
            #END add-point
 
         #----<<stamunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stamunit
            #add-point:BEFORE FIELD stamunit
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stamunit
            
            #add-point:AFTER FIELD stamunit
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page2.stamunit
         ON ACTION controlp INFIELD stamunit
            #add-point:ON ACTION controlp INFIELD stamunit
                        
            #END add-point
 
         #----<<stamsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stamsite
            #add-point:BEFORE FIELD stamsite
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stamsite
            
            #add-point:AFTER FIELD stamsite
                        
            #END add-point
            
 
         #Ctrlp:construct.c.page2.stamsite
         ON ACTION controlp INFIELD stamsite
            #add-point:ON ACTION controlp INFIELD stamsite
                        
            #END add-point
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
       CONSTRUCT g_wc2_table7 ON stbjseq,stbj001,stbjunit,stbjsite
           FROM s_detail7[1].stbjseq,s_detail7[1].stbj001,s_detail7[1].stbjunit, 
               s_detail7[1].stbjsite
                      
         BEFORE CONSTRUCT
#saki            CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
                        
            #end add-point 
               
      END CONSTRUCT
      
       CONSTRUCT g_wc2_table8 ON stbnseq,stbn001,stbnacti,stbnunit,stbnsite
           FROM s_detail8[1].stbnseq,s_detail8[1].stbn001,s_detail8[1].stbnacti,s_detail8[1].stbnunit, 
               s_detail8[1].stbnsite
                      
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD stbn001
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			#161024-00025#6---mark----begin-----     
         #  IF s_aooi500_setpoint(g_prog,'stbn001') THEN
         #     LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbn001',g_site,'c')                
         #  END IF
         #  CALL q_ooef001_23()
         #161024-00025#6---mark----end------
         #161024-00025#6---add----begin-----
           IF s_aooi500_setpoint(g_prog,'stbn001') THEN
              LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbn001',g_site,'c')
              CALL q_ooef001_24()  
           ELSE
              LET g_qryparam.where = " ooef304 = 'Y'"
              CALL q_ooef001()
           END IF
           
         #161024-00025#6---add----end----- 
         
            DISPLAY g_qryparam.return1 TO stbn001  #顯示到畫面上

            NEXT FIELD stbn001                     #返回原欄位 
               
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table3 ON stalseq2,stal004,stal005,stal006
           FROM s_detail3[1].stalseq2, s_detail3[1].stal004, s_detail3[1].stal005, s_detail3[1].stal006
                      
         BEFORE CONSTRUCT
        
            #add-point:cs段more_construct
      END CONSTRUCT
      
       CONSTRUCT g_wc2_table4 ON stawseq,staw007,staw002,staw003,staw004,staw005,staw006
           FROM s_detail4[1].stawseq,s_detail4[1].staw007,s_detail4[1].staw002,s_detail4[1].staw003,s_detail4[1].staw004,s_detail4[1].staw005,s_detail4[1].staw006
                      
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD staw007
	         INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO staw007  #顯示到畫面上
            NEXT FIELD staw007                     #返回原欄位 
       
      END CONSTRUCT
      
      #######################150512-00006#2
       CONSTRUCT g_wc2_table5 ON stayseq2,stay001,stay002,stay004
           FROM s_detail5[1].stayseq2, s_detail5[1].stay001, s_detail5[1].stay002, s_detail5[1].stay004
                      
         BEFORE CONSTRUCT
                
          ON ACTION controlp INFIELD stay004
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			  #161024-00025#6---mark----begin-----
           #IF s_aooi500_setpoint(g_prog,'stay004') THEN
           #   LET g_qryparam.where = s_aooi500_q_where(g_prog,'stay004',g_site,'c')                
           #END IF
           #CALL q_ooef001_23()
           #161024-00025#6---mark----end-----
           #161024-00025#6---add-----begin-----------
            IF s_aooi500_setpoint(g_prog,'stay004') THEN
              LET g_qryparam.where = s_aooi500_q_where(g_prog,'stay004',g_site,'c')
              CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = " ooef304 = 'Y'"
               CALL q_ooef001() 
            END IF
           
           #161024-00025#6---add-----end-------------
            DISPLAY g_qryparam.return1 TO stay004  #顯示到畫面上

            NEXT FIELD stay004                     #返回原欄位
                
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table6 ON stayseq2,stay001,stay002,stay005,stay003,stay004
           FROM s_detail6[1].stayseq2_1, s_detail6[1].stay001_1, s_detail6[1].stay002_1,s_detail6[1].stay005,s_detail6[1].stay003, s_detail6[1].stay004_1
                      
         BEFORE CONSTRUCT
                  
      END CONSTRUCT
      
      #######################
      
      CONSTRUCT g_wc2_table9 ON stbwseq,stbw008,stbw009,stbw007,stbw002,stbw003,stbw004,stbw005,stbw006
          FROM s_detail9[1].stbwseq,s_detail9[1].stbw008,s_detail9[1].stbw009,s_detail9[1].stbw007,
               s_detail9[1].stbw002,s_detail9[1].stbw003,s_detail9[1].stbw004,
               s_detail9[1].stbw005,s_detail9[1].stbw006
                     
        BEFORE CONSTRUCT
        
         ON ACTION controlp INFIELD stbw007
	         INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()
            DISPLAY g_qryparam.return1 TO stbw007  #顯示到畫面上
            NEXT FIELD stbw007                     #返回原欄位 
       
         ON ACTION controlp INFIELD stbw008
	         INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO stbw008  #顯示到畫面上
            NEXT FIELD stbw008                     #返回原欄位 
            
         ON ACTION controlp INFIELD stbw005
	         INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_stbw005()
            DISPLAY g_qryparam.return1 TO stbw005  #顯示到畫面上
            NEXT FIELD stbw005                     #返回原欄位 

      END CONSTRUCT
      #end add-point
 
      BEFORE DIALOG
         #add-point:cs段b_dialog
        # DISPLAY '1' TO staj002 
                  
         #end add-point  
 
      ON ACTION qbe_select     #條件查詢
#saki         CALL cl_qbe_list() RETURNING lc_qbe_sn
#saki         CALL cl_qbe_display_condition(lc_qbe_sn)
 
      ON ACTION qbe_save       #條件儲存
#saki         CALL cl_qbe_save()
 
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
   ###############150512-00006#2
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
   IF g_wc2_table6 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
   END IF   
   ###############
   IF g_wc2_table7 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
   END IF 
   
   IF g_wc2_table8 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table8
   END IF 
   IF g_wc2_table9 <> " 1=1" THEN 
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table9
   END IF 
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="astt301.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astt301_filter()
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
      CONSTRUCT g_wc_filter ON stajdocno,stajdocdt,staj000,staj001,staj002,staj003,staj004,staj005,staj006, 
          staj007,staj008, 
          staj009,staj010,staj011,staj012,staj013,staj014,staj015,staj016,staj017,staj018, 
          staj019,staj020,staj021,stajsite,stajacti
                          FROM s_browse[1].b_stajdocno,s_browse[1].b_stajdocdt,s_browse[1].b_staj000, 
                              s_browse[1].b_staj001,s_browse[1].b_staj002,s_browse[1].b_staj003,s_browse[1].b_staj004, 
                              s_browse[1].b_staj005,s_browse[1].b_staj006,s_browse[1].b_staj007,s_browse[1].b_staj008,
                              s_browse[1].b_staj009,s_browse[1].b_staj010,s_browse[1].b_staj011,s_browse[1].b_staj012, 
                              s_browse[1].b_staj013,s_browse[1].b_staj014,s_browse[1].b_staj015,s_browse[1].b_staj016, 
                              s_browse[1].b_staj017,s_browse[1].b_staj018,s_browse[1].b_staj019,s_browse[1].b_staj020, 
                              s_browse[1].b_staj021,s_browse[1].b_stajsite,s_browse[1].b_stajacti
 
         BEFORE CONSTRUCT
               DISPLAY astt301_filter_parser('stajdocno') TO s_browse[1].b_stajdocno
            DISPLAY astt301_filter_parser('stajdocdt') TO s_browse[1].b_stajdocdt
            DISPLAY astt301_filter_parser('staj000') TO s_browse[1].b_staj000
            DISPLAY astt301_filter_parser('staj001') TO s_browse[1].b_staj001
            #DISPLAY '1' TO s_browse[1].b_staj002
            DISPLAY astt301_filter_parser('staj003') TO s_browse[1].b_staj003
            DISPLAY astt301_filter_parser('staj004') TO s_browse[1].b_staj004
            DISPLAY astt301_filter_parser('staj005') TO s_browse[1].b_staj005
            DISPLAY astt301_filter_parser('staj006') TO s_browse[1].b_staj006
            DISPLAY astt301_filter_parser('staj007') TO s_browse[1].b_staj007
            DISPLAY astt301_filter_parser('staj008') TO s_browse[1].b_staj008
          
            DISPLAY astt301_filter_parser('staj009') TO s_browse[1].b_staj009
            DISPLAY astt301_filter_parser('staj010') TO s_browse[1].b_staj010
            DISPLAY astt301_filter_parser('staj011') TO s_browse[1].b_staj011
            DISPLAY astt301_filter_parser('staj012') TO s_browse[1].b_staj012
            DISPLAY astt301_filter_parser('staj013') TO s_browse[1].b_staj013
            DISPLAY astt301_filter_parser('staj014') TO s_browse[1].b_staj014
            DISPLAY astt301_filter_parser('staj015') TO s_browse[1].b_staj015
            DISPLAY astt301_filter_parser('staj016') TO s_browse[1].b_staj016
            DISPLAY astt301_filter_parser('staj017') TO s_browse[1].b_staj017
            DISPLAY astt301_filter_parser('staj018') TO s_browse[1].b_staj018
            DISPLAY astt301_filter_parser('staj019') TO s_browse[1].b_staj019
            DISPLAY astt301_filter_parser('staj020') TO s_browse[1].b_staj020
            DISPLAY astt301_filter_parser('staj021') TO s_browse[1].b_staj021
            DISPLAY astt301_filter_parser('stajsite') TO s_browse[1].b_stajsite
            DISPLAY astt301_filter_parser('stajacti') TO s_browse[1].b_stajacti
      
                            #add-point:filter段cs_ctrl
            AFTER FIELD b_staj020   
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
 
      CALL astt301_filter_show('stajdocno')
   CALL astt301_filter_show('stajdocdt')
   CALL astt301_filter_show('staj000')
   CALL astt301_filter_show('staj001')
   CALL astt301_filter_show('staj002')
   CALL astt301_filter_show('staj003')
   CALL astt301_filter_show('staj004')
   CALL astt301_filter_show('staj005')
   CALL astt301_filter_show('staj006')
   CALL astt301_filter_show('staj007')
   CALL astt301_filter_show('staj008')
 
   CALL astt301_filter_show('staj009')
   CALL astt301_filter_show('staj010')
   CALL astt301_filter_show('staj011')
   CALL astt301_filter_show('staj012')
   CALL astt301_filter_show('staj013')
   CALL astt301_filter_show('staj014')
   CALL astt301_filter_show('staj015')
   CALL astt301_filter_show('staj016')
   CALL astt301_filter_show('staj017')
   CALL astt301_filter_show('staj018')
   CALL astt301_filter_show('staj019')
   CALL astt301_filter_show('staj020')
   CALL astt301_filter_show('staj021')
   CALL astt301_filter_show('stajsite')
END FUNCTION
 
{</section>}
 
{<section id="astt301.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION astt301_filter_parser(ps_field)
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
 
{<section id="astt301.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION astt301_filter_show(ps_field)
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
   LET ls_condition = astt301_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
   
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION astt301_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
          CALL g_stal_d.clear()
          CALL g_staw_d.clear()
          CALL g_stak3_d.clear() 
          CALL g_stak4_d.clear()           
          CALL g_stay_d.clear()   
          CALL g_stay1_d.clear()          
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
   CALL g_stak_d.clear()
   CALL g_stak2_d.clear()
 
 
   
   #add-point:query段other

   CALL cl_set_comp_visible('group7',TRUE)
   CALL cl_set_comp_visible('group_6',TRUE) 
   CALL cl_set_comp_visible('s_detail5',TRUE)
   CALL cl_set_comp_visible('s_detail6',TRUE)   
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL astt301_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL astt301_browser_fill("")
      CALL astt301_fetch("")
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
      CALL astt301_filter_show('stajdocno')
   CALL astt301_filter_show('stajdocdt')
   CALL astt301_filter_show('staj000')
   CALL astt301_filter_show('staj001')
   CALL astt301_filter_show('staj002')
   CALL astt301_filter_show('staj003')
   CALL astt301_filter_show('staj004')
   CALL astt301_filter_show('staj005')
   CALL astt301_filter_show('staj006')
   CALL astt301_filter_show('staj007')
   CALL astt301_filter_show('staj008')
  ##150506-00007#3 150522 by sakura add---STR
  #CALL astt301_filter_show('staj024')
  #CALL astt301_filter_show('staj025')
  #CALL astt301_filter_show('staj026')
  #CALL astt301_filter_show('staj027')
  #CALL astt301_filter_show('staj028')
  #CALL astt301_filter_show('staj029')
  #CALL astt301_filter_show('staj030')
  ##150506-00007#3 150522 by sakura add---END
  #CALL astt301_filter_show('staj031')
  #CALL astt301_filter_show('staj032')
   CALL astt301_filter_show('staj009')
   CALL astt301_filter_show('staj010')
   CALL astt301_filter_show('staj011')
   CALL astt301_filter_show('staj012')
   CALL astt301_filter_show('staj013')
   CALL astt301_filter_show('staj014')
   CALL astt301_filter_show('staj015')
   CALL astt301_filter_show('staj016')
   CALL astt301_filter_show('staj017')
   CALL astt301_filter_show('staj018')
   CALL astt301_filter_show('staj019')
   CALL astt301_filter_show('staj020')
   CALL astt301_filter_show('staj021')
   CALL astt301_filter_show('stajsite')
   LET g_error_show = 1
   CALL astt301_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   ELSE
      CALL astt301_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="astt301.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION astt301_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
   #add-point:fetch段define
   DEFINE l_success  LIKE type_t.num5 #150506-00007#3 150522 by sakura add   
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
   
   LET g_staj_m.stajdocno = g_browser[g_current_idx].b_stajdocno
 
   
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE staj000,stajdocno,stajdocdt,staj002,staj001,staj003,staj021,staj004,staj005,staj006, 
        staj007,staj008,
        staj024,staj025,staj040,staj026,staj027,staj028,staj036,staj037,staj038,staj029,staj030, #150506-00007#3 150522 by sakura add
        staj031,staj033,staj035,staj034,staj042,  #160303-00028#33 20160318 by geza 
        staj009,staj010,staj015,staj039,staj016,staj011,staj012,staj013,staj014,staj041,staj017, 
        staj018,staj019,staj020,stajsite,stajunit,stajstus,stajownid,stajowndp,stajcrtid,stajcrtdp,stajcrtdt, 
        stajmodid,stajmoddt,stajcnfid,stajcnfdt
 INTO g_staj_m.staj000,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_staj_m.staj002,g_staj_m.staj001,g_staj_m.staj003, 
     g_staj_m.staj021,g_staj_m.staj004,g_staj_m.staj005,g_staj_m.staj006,g_staj_m.staj007,g_staj_m.staj008, 
     g_staj_m.staj024,g_staj_m.staj025,g_staj_m.staj040,g_staj_m.staj026,g_staj_m.staj027,g_staj_m.staj028,
     g_staj_m.staj036,g_staj_m.staj037,g_staj_m.staj038,g_staj_m.staj029,g_staj_m.staj030, #150506-00007#3 150522 by sakura add
     g_staj_m.staj031,g_staj_m.staj033,g_staj_m.staj035,g_staj_m.staj034,g_staj_m.staj042, #160303-00028#33 20160318 by geza
     g_staj_m.staj009,g_staj_m.staj010,g_staj_m.staj015,g_staj_m.staj039,g_staj_m.staj016,g_staj_m.staj011, 
     g_staj_m.staj012,g_staj_m.staj013,g_staj_m.staj014,g_staj_m.staj041,g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj019, 
     g_staj_m.staj020,g_staj_m.stajsite,g_staj_m.stajunit,g_staj_m.stajstus,g_staj_m.stajownid,g_staj_m.stajowndp, 
     g_staj_m.stajcrtid,g_staj_m.stajcrtdp,g_staj_m.stajcrtdt,g_staj_m.stajmodid,g_staj_m.stajmoddt, 
     g_staj_m.stajcnfid,g_staj_m.stajcnfdt
 FROM staj_t
 WHERE stajent = g_enterprise AND stajdocno = g_staj_m.stajdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "staj_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      INITIALIZE g_staj_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
   CALL cl_set_act_visible("modify,delete,insert,modify_detail",TRUE)
   IF g_staj_m.stajstus MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF  
   CALL cl_set_act_visible("reproduce",FALSE)
   
   
   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
       CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前
   
   #end add-point
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #重新顯示   
   CALL astt301_show()
   
   #170106-00009#1-S
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
   #170106-00009#1-E
END FUNCTION
 
{</section>}
 
{<section id="astt301.insert" >}
#+ 資料新增
PRIVATE FUNCTION astt301_insert()
   #add-point:insert段define
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5  #ken 需求單號：141208-00001 項次：18    
         CALL g_stal_d.clear() 
   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_stak_d.clear()   
   CALL g_stak2_d.clear()
   CALL g_stak3_d.clear()
   CALL g_stak4_d.clear()
   CALL g_stal_d.clear()    
   CALL g_staw_d.clear()
   CALL g_stay_d.clear()
   CALL g_stay1_d.clear()
   CALL g_stbw_d.clear()
 
 
   INITIALIZE g_staj_m.* LIKE staj_t.*             #DEFAULT 設定
   
   LET g_stajdocno_t = NULL
 
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生    
      LET g_staj_m.stajownid = g_user
      LET g_staj_m.stajowndp = g_dept
      LET g_staj_m.stajcrtid = g_user
      LET g_staj_m.stajcrtdp = g_dept 
      LET g_staj_m.stajcrtdt = cl_get_current()
      LET g_staj_m.stajmodid = ""
      LET g_staj_m.stajmoddt = ""
      #LET g_staj_m.stajstus = ""
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_staj_m.staj000 = "I"
      LET g_staj_m.staj002 = "1"
      LET g_staj_m.stanstus = "N"
 
  
      #add-point:單頭預設值
      #add by geza 20160324(S)
      LET g_staj_m.stajmodid = g_user
      LET g_staj_m.stajmoddt = cl_get_current()
      #add by geza 20160324(E)
      LET g_staj_m.staj003 = 1
      LET g_staj_m.stajdocdt = g_today
      LET g_staj_m.staj002 = ''
      LET g_staj_m.stajstus = "N"   
      LET g_staj_m.staj012 = cl_get_current()
      #150506-00007#3 150522 by sakura add---STR
      LET g_staj_m.staj026 = 'N' #採購價格允許人工修改
      LET g_staj_m.staj027 = 0   #修改容差率 
      LET g_staj_m.staj028 = '1' #超出處理方式
      LET g_staj_m.staj029 = '1' #內外購
      LET g_staj_m.staj030 = '1' #匯率計算基準
      #150506-00007#3 150522 by sakura add---END
      LET g_staj_m.staj031 = '1'   #150512-00006#2
      LET g_staj_m.staj040 = 'Y'
      #LET g_staj_m.stajsite = g_site #ken_mark
      #ken-------------------------s 需求單號：141208-00001 項次：18
      CALL s_aooi500_default(g_prog,'stajsite',g_staj_m.stajsite)
         RETURNING l_insert,g_staj_m.stajsite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      LET g_staj_m.stajunit = g_staj_m.stajsite
      LET g_site_flag = FALSE
      #ken-------------------------e
      CALL astt301_stajsite_ref()
      #dongsz--add--str---
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_staj_m.stajsite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_staj_m.stajdocno = r_doctype
      #dongsz--add--end---
      #LET g_staj_m.staj013 = g_legal
      SELECT ooef017 INTO g_staj_m.staj013 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_staj_m.stajsite
      CALL astt301_staj013_ref()
      ###################
      #LET g_staj_m.staj017 = cl_get_current()
      #LET g_staj_m.staj018 = g_staj_m.staj017+1
      ###################
      LET g_staj_m.staj011 = 'N'
      LET g_staj_m.staj036 = 'N'
      LET g_staj_m.staj042 = 'Y'
      LET g_staj_m.staj014 = g_user
      CALL astt301_staj014_ref()
      #部门
      SELECT ooag003 INTO g_staj_m.staj041
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_staj_m.staj014
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_staj_m.staj041
      CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_staj_m.staj041_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_staj_m.staj041_desc
      
      LET g_staj_m.staj034 = '0'
      LET g_staj_m_t.* = g_staj_m.*
      LET g_staj_m_o.* = g_staj_m.*
      #end add-point 
     
      CALL astt301_input("a")
      
      #add-point:單頭輸入後
                  CALL g_stal_d.clear()
      LET g_rec_b3 = 0 
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_staj_m.* = g_staj_m_t.*
         CALL astt301_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_stak_d.clear()
      CALL g_stak2_d.clear()
      CALL g_stak3_d.clear()
      CALL g_stak4_d.clear()
      CALL g_staw_d.clear()
      CALL g_stay_d.clear()
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   LET g_state = "Y"
   
   LET g_stajdocno_t = g_staj_m.stajdocno
 
   
   LET g_wc = g_wc,  
              " OR ( stajent = '" ||g_enterprise|| "' AND",
              " stajdocno = '", g_staj_m.stajdocno CLIPPED, "' "
 
              , ") "
   
   CLOSE astt301_cl
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.modify" >}
#+ 資料修改
PRIVATE FUNCTION astt301_modify()
   {<Local define>}
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define
     
   #end add-point    
   
   IF g_staj_m.stajdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   
    SELECT UNIQUE staj000,staj039,stajdocno,stajdocdt,staj002,staj001,staj003,staj021,staj004,staj005,staj006, 
        staj007,staj008,
        staj024,staj025,staj026,staj027,staj028,staj029,staj030, #150506-00007#3 150522 by sakura add
        staj031,staj033,staj034,
        staj009,staj010,staj015,staj016,staj011,staj012,staj013,staj014,staj017, 
        staj018,staj019,staj020,stajsite,stajunit,stajstus,stajownid,stajowndp,stajcrtid,stajcrtdp,stajcrtdt, 
        stajmodid,stajmoddt,stajcnfid,stajcnfdt
 INTO g_staj_m.staj000,g_staj_m.staj039,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_staj_m.staj002,g_staj_m.staj001,g_staj_m.staj003, 
     g_staj_m.staj021,g_staj_m.staj004,g_staj_m.staj005,g_staj_m.staj006,g_staj_m.staj007,g_staj_m.staj008, 
     g_staj_m.staj024,g_staj_m.staj025,g_staj_m.staj026,g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj029,g_staj_m.staj030, #150506-00007#3 150522 by sakura add
     g_staj_m.staj031,g_staj_m.staj033,g_staj_m.staj034,
     g_staj_m.staj009,g_staj_m.staj010,g_staj_m.staj015,g_staj_m.staj016,g_staj_m.staj011,
     g_staj_m.staj012,g_staj_m.staj013,g_staj_m.staj014,g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj019, 
     g_staj_m.staj020,g_staj_m.stajsite,g_staj_m.stajunit,g_staj_m.stajstus,g_staj_m.stajownid,g_staj_m.stajowndp, 
     g_staj_m.stajcrtid,g_staj_m.stajcrtdp,g_staj_m.stajcrtdt,g_staj_m.stajmodid,g_staj_m.stajmoddt, 
     g_staj_m.stajcnfid,g_staj_m.stajcnfdt
 FROM staj_t
 WHERE stajent = g_enterprise AND stajdocno = g_staj_m.stajdocno
 
   ERROR ""
  
   LET g_stajdocno_t = g_staj_m.stajdocno
 
   CALL s_transaction_begin()
   
   OPEN astt301_cl USING g_enterprise,g_staj_m.stajdocno
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN astt301_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE astt301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH astt301_cl INTO g_staj_m.staj000,g_staj_m.staj039,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_staj_m.staj002,g_staj_m.staj001, 
       g_staj_m.staj003,g_staj_m.staj021,g_staj_m.stanstus,g_staj_m.staj004,g_staj_m.staj004_desc,g_staj_m.staj005, 
       g_staj_m.staj005_desc,g_staj_m.staj006,g_staj_m.staj006_desc,g_staj_m.staj007,g_staj_m.staj007_desc, 
       g_staj_m.staj008,g_staj_m.staj008_desc,
       g_staj_m.staj024,g_staj_m.staj024_desc,g_staj_m.staj025,g_staj_m.staj025_desc,g_staj_m.staj040,g_staj_m.staj026, #150506-00007#3 150522 by sakura add
       g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj036,g_staj_m.staj037,g_staj_m.staj038,g_staj_m.staj029,g_staj_m.staj030,                            #150506-00007#3 150522 by sakura add
       g_staj_m.staj031,g_staj_m.staj033,g_staj_m.staj034,g_staj_m.staj042,
       g_staj_m.staj009,g_staj_m.staj009_desc,g_staj_m.staj010,g_staj_m.staj010_desc, 
       g_staj_m.staj015,g_staj_m.staj015_desc,g_staj_m.staj016,g_staj_m.staj016_desc,g_staj_m.staj011, 
       g_staj_m.staj012,g_staj_m.staj013,g_staj_m.staj013_desc,g_staj_m.staj014,g_staj_m.staj014_desc,g_staj_m.staj041,g_staj_m.staj041_desc,
       g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj019,g_staj_m.staj020,g_staj_m.stajsite,g_staj_m.stajsite_desc, 
       g_staj_m.stajunit,g_staj_m.stajstus,g_staj_m.stajownid,g_staj_m.stajownid_desc,g_staj_m.stajowndp, 
       g_staj_m.stajowndp_desc,g_staj_m.stajcrtid,g_staj_m.stajcrtid_desc,g_staj_m.stajcrtdp,g_staj_m.stajcrtdp_desc, 
       g_staj_m.stajcrtdt,g_staj_m.stajmodid,g_staj_m.stajmodid_desc,g_staj_m.stajmoddt,g_staj_m.stajcnfid, 
       g_staj_m.stajcnfid_desc,g_staj_m.stajcnfdt
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_staj_m.stajdocno
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      CLOSE astt301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
 
   CALL astt301_show()
   WHILE TRUE
      LET g_stajdocno_t = g_staj_m.stajdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_staj_m.stajmodid = g_user 
LET g_staj_m.stajmoddt = cl_get_current()
 
      
      #add-point:modify段修改前
      IF NOT astt301_chk_b() THEN
         CALL s_transaction_end('N','0')
         EXIT WHILE    
      END IF
      
      #檢查是否允許此動作
   IF NOT astt301_action_chk() THEN
      CLOSE astt301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
      
      
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_staj_m.stajstus MATCHES "[DR]" THEN
         LET g_staj_m.stajstus = "N"
      END IF      
      #end add-point
      
      CALL astt301_input("u")     #欄位更改
 
      #add-point:modify段修改後
            
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_staj_m.* = g_staj_m_t.*
         CALL astt301_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_staj_m.stajdocno != g_stajdocno_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前
                  
         #end add-point
         
         #更新單身key值
         UPDATE stak_t SET stakdocno = g_staj_m.stajdocno
 
          WHERE stakent = g_enterprise AND stakdocno = g_stajdocno_t
 
            
         #add-point:單身fk修改中
                  
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "stak_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stak_t"
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
         UPDATE stam_t
            SET stamdocno = g_staj_m.stajdocno
 
          WHERE stament = g_enterprise AND
                stamdocno = g_stajdocno_t
 
         #add-point:單身fk修改中
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "stam_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stam_t"
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
   IF NOT cl_log_modified_record(g_staj_m.stajdocno,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE astt301_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_staj_m.stajdocno,'U')
   
END FUNCTION   
 
{</section>}
 
{<section id="astt301.input" >}
#+ 資料輸入
PRIVATE FUNCTION astt301_input(p_cmd)
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
   DEFINE  t_staj004             LIKE staj_t.staj004
   DEFINE  l_flag                LIKE type_t.chr1
   DEFINE  l_flag_1                LIKE type_t.chr1
   DEFINE  tok            base.StringTokenizer
   DEFINE  l_sys                 LIKE type_t.num5
 #  DEFINE  l_stam_flag           LIKE type_t.chr1
   DEFINE  l_sys_1               LIKE type_t.chr1
   #ken---------------------s 需求單號：141208-00001 項次：18
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_where               STRING
   #ken---------------------e
   DEFINE  l_stawseq             LIKE staw_t.stawseq
   DEFINE  l_staw003             LIKE staw_t.staw003
   DEFINE  l_ooef019             LIKE ooef_t.ooef019
   DEFINE  l_stao020             LIKE stao_t.stao020
   #add--2015/05/08 By shiun--(S)
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   #add--2015/05/08 By shiun--(E)
   DEFINE  l_ins                 LIKE type_t.chr1
   DEFINE  l_end                 LIKE type_t.dat
   DEFINE  l_ooaa002             LIKE ooaa_t.ooaa002
   DEFINE  l_str                 STRING               #add by yangxf 
   DEFINE  i                     LIKE type_t.num5     #add by yangxf
   DEFINE  l_stao002             LIKE stao_t.stao002
   DEFINE  l_str_wc              STRING 
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
         LET g_forupd_sql = "SELECT stalseq2,stal004,stal005,stal006 FROM stal_t WHERE stalent=? AND staldocno=? AND stalseq1=? AND stalseq2 = ? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astt301_bcl3 CURSOR FROM g_forupd_sql
   #end add-point 
   LET g_forupd_sql = "SELECT stakseq,stak003,'',stak023,stak024,stak025,'',stak004,stak005,stak006,stak028,stak007,stak008,stak027,stak009,'',   
       stak010,'',stak011,stak012,stak013,stak014,stak015,stak016,stak029,stak030,stak022,stak017,stak018,stak019,stakunit,staksite  
       FROM stak_t WHERE stakent=? AND stakdocno=? AND stakseq=? FOR UPDATE"  #add by geza 20150610  stak023,stak024 #150612-00023#5 add stak027
   #add-point:input段define_sql
      
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astt301_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql
      
   #end add-point    
   LET g_forupd_sql = "SELECT stamseq,stam003,'',stam005,stam004,stamunit,stamsite FROM stam_t WHERE stament=?  
       AND stamdocno=? AND stamseq=? FOR UPDATE"
   #add-point:input段define_sql
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astt301_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql
   LET g_forupd_sql = "SELECT stbjseq,stbj001,stbjsite,stbjunit FROM stbj_t WHERE stbjent=?  
       AND stbjdocno=? AND stbjseq=? FOR UPDATE" 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astt301_bcl7 CURSOR FROM g_forupd_sql 
    
   LET g_forupd_sql = "SELECT stbnseq,stbn001,stbnacti,stbnsite,stbnunit FROM stbn_t WHERE stbnent=?  
       AND stbndocno=? AND stbnseq=? FOR UPDATE" 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astt301_bcl8 CURSOR FROM g_forupd_sql  
    
    LET g_forupd_sql = "SELECT stawsite,stawunit,stawseq,staw002,staw003,staw004,staw005,staw006,staw007 FROM staw_t WHERE stawent=? AND stawdocno=? AND  
       stawseq=? AND staw007 =? FOR UPDATE"
    LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astt301_bcl4 CURSOR FROM g_forupd_sql    
   
   #################150512-00006#2
   LET g_forupd_sql = "SELECT stayseq2,stay001,stay002,stay004,'' FROM stay_t WHERE stayent=? AND staydocno=? AND  
       stayseq1=? AND stayseq2 = ? FOR UPDATE"
    LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astt301_bcl5 CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT stayseq2,stay001,stay002,stay005,stay003,stay004,'' FROM stay_t WHERE stayent=? AND staydocno=? AND  
       stayseq1=? AND stayseq2 = ? FOR UPDATE"
    LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE astt301_bcl6 CURSOR FROM g_forupd_sql   
   #################150512-00006#2
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL astt301_set_entry(p_cmd)
   #add-point:set_entry後
      
   #end add-point
   CALL astt301_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_staj_m.stajsite,g_staj_m.stajdocdt,g_staj_m.stajdocno,g_staj_m.staj000,g_staj_m.staj039,g_staj_m.staj001,g_staj_m.staj003,
              g_staj_m.staj004,g_staj_m.staj002,g_staj_m.staj031,g_staj_m.staj021,g_staj_m.staj005,g_staj_m.staj016,
              g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj012,g_staj_m.staj014,g_staj_m.staj041,g_staj_m.staj013,
              g_staj_m.staj036,g_staj_m.staj037,g_staj_m.staj038,g_staj_m.staj015,g_staj_m.staj009,g_staj_m.staj010,
              g_staj_m.staj034,g_staj_m.staj042,g_staj_m.staj033,g_staj_m.staj035,g_staj_m.staj019,g_staj_m.staj020,g_staj_m.staj029,
              g_staj_m.staj030,g_staj_m.staj008,g_staj_m.staj024,g_staj_m.staj006,g_staj_m.staj007,g_staj_m.staj025,
              g_staj_m.staj040,g_staj_m.staj026,g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj011,g_staj_m.stajstus
 
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
         LET g_ooef004 = ''
   LET g_ooef005 = ''
 #  LET l_stam_flag = 'N'
   SELECT ooef004,ooef005 INTO g_ooef004,g_ooef005 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   IF cl_null(g_ooef005) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00008'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF  
   
   LET t_staj004 = g_staj_m.staj004
   
   LET l_flag = TRUE
   LET g_flag = FALSE
  # IF l_stam_flag = 'Y' THEN 
  #    CALL s_transaction_begin()
  #  END IF
     WHILE TRUE
      LET l_flag_1 = 'N'
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
 
{</section>}
 
{<section id="astt301.input.head" >}
      #單頭段
      INPUT BY NAME g_staj_m.stajsite,g_staj_m.stajdocdt,g_staj_m.stajdocno,g_staj_m.staj000,g_staj_m.staj039,g_staj_m.staj001,
              g_staj_m.staj003,g_staj_m.staj004,g_staj_m.staj002,g_staj_m.staj021,g_staj_m.staj005,g_staj_m.staj016,
              g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj012,g_staj_m.staj014,g_staj_m.staj041,g_staj_m.staj013,
              g_staj_m.staj036,g_staj_m.staj037,g_staj_m.staj038,g_staj_m.staj015,g_staj_m.staj009,g_staj_m.staj010,
              g_staj_m.staj034,g_staj_m.staj042,g_staj_m.staj033,g_staj_m.staj035,g_staj_m.staj019,g_staj_m.staj020,g_staj_m.staj029,
              g_staj_m.staj030,g_staj_m.staj008,g_staj_m.staj024,g_staj_m.staj006,g_staj_m.staj007,g_staj_m.staj025,
              g_staj_m.staj040,g_staj_m.staj026,g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj011,g_staj_m.stajstus
              
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:資料輸入前
            CALL astt301_set_entry(p_cmd)
           # IF l_stam_flag = 'Y' THEN 
           #    LET l_stam_flag = 'N'
           #    NEXT FIELD stamseq
           # END IF
            CALL astt301_set_no_entry(p_cmd)
            CALL cl_set_comp_required('staj002',TRUE)
            #end add-point
 
         #---------------------------<  Master  >---------------------------
         #----<<staj000>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj000
            #add-point:BEFORE FIELD staj000
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj000
            
            #add-point:AFTER FIELD staj000
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj000
            #add-point:ON CHANGE staj000
            CALL astt301_set_entry(p_cmd)
            CALL astt301_set_no_entry(p_cmd)
            CALL astt301_clear()
            #END add-point
 
         AFTER FIELD staj039
            IF NOT cl_null(g_staj_m.staj039) THEN
               #延期日期不为空            
               IF NOT cl_null(g_staj_m.staj033) THEN 
                  IF g_staj_m.staj039 > g_staj_m.staj033 OR g_staj_m.staj039 < g_staj_m.staj017 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00484'
                     LET g_errparam.extend = g_site
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_staj_m.staj039 = g_staj_m_t.staj039
                     NEXT FIELD staj039
                  END IF 
               ELSE
                  IF g_staj_m.staj039 > g_staj_m.staj018 OR g_staj_m.staj039 < g_staj_m.staj017 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00484'
                     LET g_errparam.extend = g_site
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_staj_m.staj039 = g_staj_m_t.staj039
                     NEXT FIELD staj039
                  END IF 
               END IF 
            END IF 
         #----<<stajdocno>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stajdocno
            #add-point:BEFORE FIELD stajdocno
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajdocno
            
            #add-point:AFTER FIELD stajdocno
                                    #此段落由子樣板a05產生
            IF NOT cl_null(g_staj_m.stajdocno) AND p_cmd = 'a' THEN
              #IF NOT s_aooi200_chk_slip(g_site,'',g_staj_m.stajdocno,g_prog) THEN #sakura mark
               IF NOT s_aooi200_chk_slip(g_staj_m.stajsite,'',g_staj_m.stajdocno,g_prog) THEN #sakura add
                  LET g_staj_m.stajdocno = g_staj_m_t.stajdocno
                  NEXT FIELD CURRENT
               END IF
            END IF
            IF  NOT cl_null(g_staj_m.stajdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_staj_m.stajdocno != g_stajdocno_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM staj_t WHERE "||"stajent = '" ||g_enterprise|| "' AND "||"stajdocno = '"||g_staj_m.stajdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
              #ken_mark 需求單號：141208-00001 項次：18 
             #CALL s_aooi200_gen_docno(g_site,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_prog) RETURNING l_flag,g_staj_m.stajdocno  
             # IF NOT l_flag THEN
             #    INITIALIZE g_errparam TO NULL
             #    LET g_errparam.code = 'apm-00003'
             #    LET g_errparam.extend = g_staj_m.stajdocno
             #    LET g_errparam.popup = TRUE
             #    CALL cl_err()
             #
             #    LET g_staj_m.stajdocno = g_staj_m_t.stajdocno
             #    DISPLAY g_staj_m.stajdocno TO stajdocno
             #    NEXT FIELD CURRENT
             # END IF
             # LET g_flag = TRUE
            ELSE
               NEXT FIELD CURRENT
            END IF
            CALL astt301_set_entry(p_cmd)
            CALL astt301_set_no_entry(p_cmd)


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stajdocno
            #add-point:ON CHANGE stajdocno
                        
            #END add-point
 
         #----<<stajdocdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stajdocdt
            #add-point:BEFORE FIELD stajdocdt
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajdocdt
            
            #add-point:AFTER FIELD stajdocdt
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stajdocdt
            #add-point:ON CHANGE stajdocdt
                        
            #END add-point
 
         #----<<staj002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj002
            #add-point:BEFORE FIELD staj002
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj002
            
            #add-point:AFTER FIELD staj002
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj002
            #add-point:ON CHANGE staj002
             IF NOT cl_null(g_staj_m.staj004) THEN
                  SELECT stag002 INTO l_stag002 FROM stag_t WHERE stagent = g_enterprise AND stag001 = g_staj_m.staj004
                  IF l_stag002 <> g_staj_m.staj002 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00023'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_staj_m.staj002 = g_staj_m_t.staj002
                     NEXT FIELD staj002   
                  END IF
             END IF
            #END add-point
 
         #----<<staj001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj001
            #add-point:BEFORE FIELD staj001
            ################################add by huangtao
           # IF cl_null(g_staj_m.stajdocdt) THEN
           #    NEXT FIELD stajdocdt
           # END IF
           # IF cl_null(g_staj_m.stajdocno) THEN
           #    NEXT FIELD stajdocno
           # END IF
           # IF g_flag = FALSE THEN
           #    CALL s_aooi200_gen_docno(g_site,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_prog) RETURNING l_flag,g_staj_m.stajdocno  
           #    IF NOT l_flag THEN
           #       INITIALIZE g_errparam TO NULL
           #       LET g_errparam.code = 'apm-00003'
           #       LET g_errparam.extend = g_staj_m.stajdocno
           #       LET g_errparam.popup = TRUE
           #       CALL cl_err()
           #   
           #       LET g_staj_m.stajdocno = g_staj_m_t.stajdocno
           #       DISPLAY g_staj_m.stajdocno TO stajdocno
           #       NEXT FIELD stajdocno
           #    END IF
           # END IF
           # LET g_flag = TRUE
           # CALL astt301_set_entry(p_cmd)
           # CALL astt301_set_no_entry(p_cmd)
             ################################add by huangtao
            CALL cl_get_para(g_enterprise,g_site,'E-CIR-0010') RETURNING l_sys_1
            IF l_sys_1 = 'Y' THEN
               IF p_cmd = 'a' AND g_staj_m.staj000 = 'I' AND cl_null(g_staj_m.staj001) THEN    
#                  CALL s_aooi390('22') RETURNING l_flag,g_staj_m.staj001  #mark--2015/05/08 By shiun
                  CALL s_aooi390_gen('22') RETURNING l_success,g_staj_m.staj001,l_oofg_return   #add--2015/05/08 By shiun
                  IF NOT astt301_staj001_chk(p_cmd,g_staj_m.staj001) THEN
                     LET g_staj_m.staj001 = ''
                  END IF
                  
               END IF     
            END IF               
            #END add-point
   
         #此段落由子樣板a02產生
         AFTER FIELD staj001
            
            #add-point:AFTER FIELD staj001
           IF NOT cl_null(g_staj_m.staj001) THEN
               IF NOT astt301_staj001_chk(p_cmd,g_staj_m.staj001) THEN
                  LET g_staj_m.staj001 = g_staj_m_t.staj001
                  NEXT FIELD staj001
               END IF
               #U修改时，如果合同有异动自动带出单身
               #######################################
               #IF g_staj_m.staj000 = 'U' AND (cl_null(g_staj_m_o.staj001) OR g_staj_m_o.staj001 <>  g_staj_m.staj001) THEN
               #   IF NOT astt301_staj001_genb() THEN
               #      LET g_staj_m.staj001 = g_staj_m_o.staj001
               #      NEXT FIELD staj001
               #   END IF
               #   CALL astt301_staj001_other()
               #   CALL astt301_b_fill()
               #   LET l_ac3 = 1
               #   CALL astt301_b3_fill()
               #   CALL astt301_reflesh()
               #   LET g_staj_m_o.staj001 = g_staj_m.staj001
               #END IF
               ########################################
              # IF p_cmd = 'a' OR (p_cmd = 'u' AND g_staj_m_t.staj001 <>  g_staj_m.staj001) THEN               
              #    IF g_staj_m.staj000 = 'U' THEN
              #       CALL astt301_staj001_other()
              #    END IF
              # END IF
               #############################
              IF (g_staj_m.staj000 = 'U' OR g_staj_m.staj000 = 'R') AND (cl_null(g_staj_m_o.staj001) OR g_staj_m_o.staj001 <>  g_staj_m.staj001) THEN    #add by yangxf 
                 CALL astt301_staj001_other()
                  LET g_staj_m_o.staj001 = g_staj_m.staj001
              END IF
              #############################
               CALL cl_set_comp_entry("staj000",FALSE)
               IF g_staj_m.staj000 = 'U' THEN 
                  CALL cl_set_comp_entry("staj004",FALSE)
               ELSE
                  CALL cl_set_comp_entry("staj004",TRUE)               
               END IF     
               #add--2015/05/08 By shiun--(S)
               IF NOT s_aooi390_chk('22',g_staj_m.staj001) THEN
                  LET g_staj_m.staj001 = g_staj_m_t.staj001
                  DISPLAY BY NAME g_staj_m.staj001
                  NEXT FIELD CURRENT
               END IF
               #add--2015/05/08 By shiun--(E)
            ELSE
               CALL cl_set_comp_entry("staj000",TRUE)            
            END IF
            #add by geza 20150729(S)
            CALL astt301_set_entry(l_cmd)
            CALL astt301_set_no_entry(l_cmd)
            LET g_staj_m_t.staj031 = g_staj_m.staj031
            #add by geza 20150729(E)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj001
            #add-point:ON CHANGE staj001
            
            #END add-point
 
         #----<<staj003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj003
            #add-point:BEFORE FIELD staj003
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj003
            
            #add-point:AFTER FIELD staj003
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj003
            #add-point:ON CHANGE staj003
                        
            #END add-point
 
         #----<<staj021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj021
            #add-point:BEFORE FIELD staj021
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj021
            
            #add-point:AFTER FIELD staj021
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj021
            #add-point:ON CHANGE staj021
                        
            #END add-point
 
         #----<<stanstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stanstus
            #add-point:BEFORE FIELD stanstus
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stanstus
            
            #add-point:AFTER FIELD stanstus
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stanstus
            #add-point:ON CHANGE stanstus
                        
            #END add-point
 
         #----<<staj004>>----
         #此段落由子樣板a02產生
         AFTER FIELD staj004
            
            #add-point:AFTER FIELD staj004
           LET g_staj_m.staj004_desc = ''
           DISPLAY BY NAME  g_staj_m.staj004_desc
           IF NOT cl_null(g_staj_m.staj004) THEN
              IF NOT astt301_staj004_chk(g_staj_m.staj004) THEN
                  LET g_staj_m.staj004 = g_staj_m_t.staj004
                  CALL astt301_staj004_ref()
                  NEXT FIELD staj004
               END IF 
               
                IF NOT cl_null(g_staj_m.staj002) THEN
                  SELECT stag002 INTO l_stag002 FROM stag_t WHERE stagent = g_enterprise AND stag001 = g_staj_m.staj004
                  IF l_stag002 <> g_staj_m.staj002 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00023'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_staj_m.staj004 = g_staj_m_t.staj004
                     CALL astt301_staj004_ref()
                     NEXT FIELD staj004   
                  END IF
               END IF
           END IF
           CALL astt301_staj004_ref()
            IF g_staj_m.staj004 <>t_staj004 OR  t_staj004 is null THEN
               CALL astt301_staj004_other()
            END IF
            LET t_staj004 =  g_staj_m.staj004
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj004
            #add-point:BEFORE FIELD staj004
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE staj004
            #add-point:ON CHANGE staj004
                        
            #END add-point
 
         #----<<staj005>>----
         #此段落由子樣板a02產生
         AFTER FIELD staj005
            
            #add-point:AFTER FIELD staj005
            LET g_staj_m.staj005_desc = ''
            DISPLAY BY NAME g_staj_m.staj005_desc
            IF NOT cl_null(g_staj_m.staj005) THEN 
               IF g_staj_m.staj005 != g_staj_m_o.staj005 OR cl_null(g_staj_m_o.staj005) THEN
               IF NOT astt301_staj005_chk(g_staj_m.staj005) THEN
                  LET g_staj_m.staj005 = g_staj_m_o.staj005
                  CALL astt301_staj005_ref()
                  NEXT FIELD staj005
               END IF
               
               
               #IF NOT cl_null(g_staj_m.staj017) AND NOT cl_null(g_staj_m.staj018) THEN
               #   IF NOT astt301_interval_chk() THEN
               #      LET g_staj_m.staj005 = g_staj_m_t.staj005
               #      CALL astt301_staj005_ref()
               #      NEXT FIELD staj005
               #   END IF
               #END IF
               #150506-00007#3 150522 by sakura add--STR
               #新增時,抓取廠商帳戶資料為預設值
               IF g_staj_m.staj000 = 'I' THEN
                  CALL astt301_staj005_other()
               END IF
               #150506-00007#3 150522 by sakura add--END  
               END IF               
            END IF  
            LET g_staj_m_o.staj005 =   g_staj_m.staj005          
            CALL astt301_staj005_ref()
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj005
            #add-point:BEFORE FIELD staj005
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE staj005
            #add-point:ON CHANGE staj005
                        
            #END add-point
 
         #----<<staj006>>----
         #此段落由子樣板a02產生
         AFTER FIELD staj006
            
            #add-point:AFTER FIELD staj006
                                    LET g_staj_m.staj006_desc = ''
            DISPLAY BY NAME g_staj_m.staj006_desc
            IF NOT cl_null(g_staj_m.staj006) THEN
               IF NOT astt301_staj006_chk(g_staj_m.staj006) THEN
                  LET g_staj_m.staj006 = g_staj_m_t.staj006
                  CALL astt301_staj006_ref()
                  NEXT FIELD staj006
               END IF   
            END IF
            CALL astt301_staj006_ref() 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj006
            #add-point:BEFORE FIELD staj006
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE staj006
            #add-point:ON CHANGE staj006
                        
            #END add-point
 
         #----<<staj007>>----
         #此段落由子樣板a02產生
         AFTER FIELD staj007
            
            #add-point:AFTER FIELD staj007
            LET g_staj_m.staj007_desc = ''
            DISPLAY BY NAME g_staj_m.staj007_desc
            IF NOT cl_null(g_staj_m.staj007) THEN
               #150213-00006#1 2015/02/13 By pomelo add(S)
               #IF g_staj_m.staj007 != g_staj_m_o.staj007 OR cl_null(g_staj_m_o.staj007) THEN
               #150213-00006#1 2015/02/13 By pomelo add(E)
                  IF NOT astt301_staj007_chk(g_staj_m.staj007) THEN
                     #LET g_staj_m.staj007 = g_staj_m_t.staj007 #150213-00006#1 2015/02/13 By pomelo mark
                     LET g_staj_m.staj007 = g_staj_m_o.staj007  #150213-00006#1 2015/02/13 By pomelo add
                     CALL astt301_staj007_ref()
                     NEXT FIELD staj007
                  END IF 
                  CALL astt301_staj007_ref()
               #END IF    #150213-00006#1 2015/02/13 By pomelo add
            ELSE
               LET g_staj_m.staj007_desc = ''
               DISPLAY BY NAME g_staj_m.staj007_desc
            END IF
            CALL astt301_staj007_ref() #150506-00007#3 150522 by sakura add 
            LET g_staj_m_o.staj007 = g_staj_m.staj007   #150213-00006#1 2015/02/13 By pomelo add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj007
            #add-point:BEFORE FIELD staj007
            #150213-00006#1 2015/02/13 By pomelo add(S)
            IF cl_null(g_staj_m.staj013) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ast-00220'
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD staj013
            END IF
            #150213-00006#1 2015/02/13 By pomelo add(E)
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE staj007
            #add-point:ON CHANGE staj007
                        
            #END add-point
 
         #----<<staj008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj008
            #add-point:BEFORE FIELD staj008
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj008
            
            #add-point:AFTER FIELD staj008
            LET g_staj_m.staj008_desc = ''
            DISPLAY BY NAME g_staj_m.staj008_desc
            IF NOT cl_null(g_staj_m.staj008) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_staj_m.staj008
               
               #160318-00025#37  2016/04/19  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apm-00186:sub-01302|aooi716|",cl_get_progname("aooi716",g_lang,"2"),"|:EXEPROGaooi716"
               #160318-00025#37  2016/04/19  by pengxin  add(E)
               
               IF NOT cl_chk_exist("v_ooib002") THEN
                  LET g_staj_m.staj008 = g_staj_m_t.staj008 
                  CALL astt301_staj008_ref()
                  NEXT FIELD staj008
               END IF 
               CALL astt301_staj008_ref()             
            ELSE
               LET g_staj_m.staj008_desc = ''
               DISPLAY BY NAME g_staj_m.staj008_desc
            END IF            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj008
            #add-point:ON CHANGE staj008
                        
            #END add-point
         
         #150506-00007#3 150522 by sakura add---STR
         #交易條件
         BEFORE FIELD staj024
         AFTER FIELD staj024
            LET g_staj_m.staj024_desc = ' '
            DISPLAY BY NAME g_staj_m.staj024_desc
            IF NOT cl_null(g_staj_m.staj024) THEN
               IF g_staj_m.staj024 != g_staj_m_o.staj024 OR cl_null(g_staj_m_t.staj024) THEN
                  IF NOT s_azzi650_chk_exist('238',g_staj_m.staj024) THEN
                     LET g_staj_m.staj024 = g_staj_m_o.staj024
                     CALL s_desc_get_acc_desc('238',g_staj_m.staj024) RETURNING g_staj_m.staj024_desc
                     DISPLAY BY NAME g_staj_m.staj024_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_staj_m_o.staj024 = g_staj_m.staj024
            CALL s_desc_get_acc_desc('238',g_staj_m.staj024) RETURNING g_staj_m.staj024_desc
            DISPLAY BY NAME g_staj_m.staj024_desc         
         ON CHANGE staj024
         #發票類型
         BEFORE FIELD staj025
         AFTER FIELD staj025
            LET g_staj_m.staj025_desc = ''
            DISPLAY BY NAME g_staj_m.staj025_desc
            IF NOT cl_null(g_staj_m.staj025) THEN
               IF g_staj_m.staj025 != g_staj_m_o.staj025 OR cl_null(g_staj_m_t.staj025) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooef019
                  LET g_chkparam.arg2 = g_staj_m.staj025
                  IF NOT cl_chk_exist("v_isac002_1") THEN
                     LET g_staj_m.staj025 = g_staj_m_o.staj025
                     CALL s_desc_get_invoice_type_desc1(g_site,g_staj_m.staj025) RETURNING g_staj_m.staj025_desc
                     DISPLAY BY NAME g_staj_m.staj025_desc
                     NEXT FIELD CURRENT
                  END IF
                  #add by yangxf ----start---
                  SELECT isacud001 INTO g_staj_m.staj040
                    FROM isac_t
                   WHERE isacent = g_enterprise
                     AND isac001 = g_ooef019
                     AND isac002 = g_staj_m.staj025
                  IF cl_null(g_staj_m.staj040) THEN 
                     LET g_staj_m.staj040 = 'N'
                  END IF 
                  DISPLAY BY NAME g_staj_m.staj040
                  #add by yangxf ----end-----
               END IF
            END IF
            LET g_staj_m_o.staj025 = g_staj_m.staj025
            CALL s_desc_get_invoice_type_desc1(g_site,g_staj_m.staj025) RETURNING g_staj_m.staj025_desc
            DISPLAY BY NAME g_staj_m.staj025_desc         
         ON CHANGE staj025         
         #採購價格允許人工修改
         BEFORE FIELD staj026
#mark by yangxf ---start---20160115
#         AFTER FIELD staj026
#           CALL astt301_set_entry(p_cmd)
#           CALL astt301_set_no_entry(p_cmd)
#makr by yangxf ---end----20160115
           
#add by yangxf ---start----20160115           
         ON CHANGE staj026   
            IF g_staj_m.staj026 = 'Y' THEN 
               CALL cl_set_comp_entry("staj027,staj028",TRUE)
               CALL cl_set_comp_required("staj027,staj028",TRUE)
            ELSE
               LET g_staj_m.staj027 = 0
               LET g_staj_m.staj028 = '1'
               DISPLAY BY NAME g_staj_m.staj027,g_staj_m.staj028
               CALL cl_set_comp_entry("staj027,staj028",FALSE)
               CALL cl_set_comp_required("staj027,staj028",FALSE)
            END IF 
#add by yangxf ----end-----20160115            
            
         #修改容差率
         BEFORE FIELD staj027
         AFTER FIELD staj027
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_staj_m.staj027,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD staj027
            END IF          
         ON CHANGE staj027          
         #超出處理方式
         BEFORE FIELD staj028
         AFTER FIELD staj028
         ON CHANGE staj028        
 
         ON CHANGE staj036
            IF g_staj_m.staj036 = 'Y' THEN 
               CALL cl_set_comp_entry('staj037,staj038',TRUE)
            ELSE
               LET g_staj_m.staj037 = ''
               LET g_staj_m.staj038 = ''
               CALL cl_set_comp_entry('staj037,staj038',FALSE)
            END IF 
            
         #內外購
         BEFORE FIELD staj029
         AFTER FIELD staj029
         ON CHANGE staj029         
         #匯率計算基準
         BEFORE FIELD staj030
         AFTER FIELD staj030
         ON CHANGE staj030         
         #150506-00007#3 150522 by sakura add---END
         #----<<staj009>>----
         #此段落由子樣板a02產生
         
            ON CHANGE staj040
            IF g_stak_d.getLength() > 0 THEN 
               IF cl_ask_confirm('ast-00453') THEN
                  #更新费用明细页签
                  UPDATE stak_t SET stak023 = CASE g_staj_m.staj040 WHEN 'Y' THEN 'N' ELSE 'Y'END ,
                                    stak024 = (SELECT stae007 
                                                 FROM stae_t  
                                                WHERE staeent = g_enterprise
                                                  AND stae001 = stak003
                                                  AND stakent = staeent 
                                                  AND stakdocno = g_staj_m.stajdocno)
                   WHERE stakent = g_enterprise
                     AND stakdocno = g_staj_m.stajdocno
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_staj_m.staj040
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_staj_m.staj040 = g_staj_m_t.staj040
                     NEXT FIELD staj040
                  END IF 
                  #更新费用明细页签纳入结算单栏位为Y(当票扣否为Y)
                  UPDATE stak_t SET stak023 = 'Y'
                   WHERE stakent = g_enterprise
                     AND stakdocno = g_staj_m.stajdocno
                     AND stak024 = 'Y'
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_staj_m.staj040
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_staj_m.staj040 = g_staj_m_t.staj040
                     NEXT FIELD staj040
                  END IF 
               END IF 
               CALL astt301_b_fill()
            END IF 
         
         AFTER FIELD staj009
            
            #add-point:AFTER FIELD staj009
                                    LET g_staj_m.staj009_desc = ''
            DISPLAY BY NAME g_staj_m.staj009_desc
            IF NOT cl_null(g_staj_m.staj009) THEN
               IF NOT astt301_staj009_chk(g_staj_m.staj009)THEN 
                  LET g_staj_m.staj009 = g_staj_m_t.staj009
                  CALL astt301_staj009_ref()
                  NEXT FIELD staj009
               END IF
               
                #计算下次计算日
               IF NOT astt301_staj017_018_chk(p_cmd,'staj009') THEN
                  LET g_staj_m.staj009 = g_staj_m_t.staj009
                  CALL astt301_staj009_ref()
                  NEXT FIELD staj009
               END IF
            END IF
            CALL astt301_staj009_ref()
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj009
            #add-point:BEFORE FIELD staj009
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE staj009
            #add-point:ON CHANGE staj009
                        
            #END add-point
 
         #----<<staj010>>----
         #此段落由子樣板a02產生
         AFTER FIELD staj010
            
            #add-point:AFTER FIELD staj010
                                    LET g_staj_m.staj010_desc = ''
            DISPLAY BY NAME g_staj_m.staj010_desc
            IF NOT cl_null(g_staj_m.staj010) THEN
               IF NOT astt301_staj010_chk(g_staj_m.staj010)THEN 
                  LET g_staj_m.staj010 = g_staj_m_t.staj010
                  CALL astt301_staj010_ref()
                  NEXT FIELD staj010
               END IF
            END IF
            CALL astt301_staj010_ref()
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj010
            #add-point:BEFORE FIELD staj010
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE staj010
            #add-point:ON CHANGE staj010
                        
            #END add-point
 
         #----<<staj015>>----
         #此段落由子樣板a02產生
         AFTER FIELD staj015
            
            #add-point:AFTER FIELD staj015
                                   LET g_staj_m.staj015_desc = ''
            DISPLAY BY NAME  g_staj_m.staj015_desc 
            IF NOT cl_null(g_staj_m.staj015) THEN
#               IF NOT astt301_staj015_chk(g_staj_m.staj015)THEN 
#                  LET g_staj_m.staj015 = g_staj_m_t.staj015
#                  CALL astt301_staj015_ref()
#                  NEXT FIELD staj015
#               END IF
               IF s_aooi500_setpoint(g_prog,'staj015') THEN
                  CALL s_aooi500_chk(g_prog,'staj015',g_staj_m.staj015,g_staj_m.stajsite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_staj_m.staj015
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     LET g_staj_m.staj015= g_staj_m_t.staj015
                     CALL s_desc_get_department_desc(g_staj_m.staj015) RETURNING g_staj_m.staj015_desc
                     DISPLAY BY NAME g_staj_m.staj015,g_staj_m.staj015_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT astt301_staj015_chk(g_staj_m.staj015)THEN 
                     LET g_staj_m.staj015 = g_staj_m_t.staj015
                     CALL astt301_staj015_ref()
                     NEXT FIELD staj015
                  END IF
               END IF
            END IF
            CALL astt301_staj015_ref() 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj015
            #add-point:BEFORE FIELD staj015
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE staj015
            #add-point:ON CHANGE staj015
                        
            #END add-point
 
         #----<<staj016>>----
         #此段落由子樣板a02產生
         AFTER FIELD staj016
            
            #add-point:AFTER FIELD staj016
                                    LET g_staj_m.staj016_desc = ''
            DISPLAY BY NAME g_staj_m.staj016_desc
            IF NOT cl_null(g_staj_m.staj016) THEN
#               IF NOT astt301_staj016_chk(g_staj_m.staj016)THEN 
#                  LET g_staj_m.staj016 = g_staj_m_t.staj016
#                  CALL astt301_staj016_ref()
#                  NEXT FIELD staj016
#               END IF
               IF s_aooi500_setpoint(g_prog,'staj016') THEN
                  CALL s_aooi500_chk(g_prog,'staj016',g_staj_m.staj016,g_staj_m.stajsite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_staj_m.staj016
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     LET g_staj_m.staj016= g_staj_m_t.staj016
                     CALL s_desc_get_department_desc(g_staj_m.staj016) RETURNING g_staj_m.staj016_desc
                     DISPLAY BY NAME g_staj_m.staj016,g_staj_m.staj016_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT astt301_staj016_chk(g_staj_m.staj016)THEN 
                     LET g_staj_m.staj016 = g_staj_m_t.staj016
                     CALL astt301_staj016_ref()
                     NEXT FIELD staj016
                  END IF
               END IF
            END IF
            CALL astt301_staj016_ref()

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj016
            #add-point:BEFORE FIELD staj016
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE staj016
            #add-point:ON CHANGE staj016
                        
            #END add-point
 
         #----<<staj011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj011
            #add-point:BEFORE FIELD staj011
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj011
            
            #add-point:AFTER FIELD staj011
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj011
            #add-point:ON CHANGE staj011
                        
            #END add-point
 
                        
            #END add-point
 
                        
            #END add-point
            
 
                        
            #END add-point
 
         #----<<staj012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj012
            #add-point:BEFORE FIELD staj012
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj012
            
            #add-point:AFTER FIELD staj012
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj012
            #add-point:ON CHANGE staj012
                        
            #END add-point
 
         #----<<staj013>>----
         #此段落由子樣板a02產生
         AFTER FIELD staj013
            
            #add-point:AFTER FIELD staj013
            LET g_staj_m.staj013_desc = ''
            DISPLAY BY NAME g_staj_m.staj013_desc
            IF NOT cl_null(g_staj_m.staj013) THEN
#               IF NOT astt301_staj013_chk(g_staj_m.staj013) THEN
#                  LET g_staj_m.staj013 = g_staj_m_t.staj013
#                  CALL astt301_staj013_ref()
#                  NEXT FIELD staj013
#               END IF
               #150213-00006#1 2015/02/13 By pomelo add(S)
               IF g_staj_m.staj013 != g_staj_m_o.staj013 OR cl_null(g_staj_m_o.staj013) THEN
               #150213-00006#1 2015/02/13 By pomelo add(E)
                  IF s_aooi500_setpoint(g_prog,'staj013') THEN
                     CALL s_aooi500_chk(g_prog,'staj013',g_staj_m.staj013,g_staj_m.stajsite) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_staj_m.staj013
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        
                        #LET g_staj_m.staj013 = g_staj_m_t.staj013  #150213-00006#1 2015/02/13 By pomelo mark
                        LET g_staj_m.staj013 = g_staj_m_o.staj013   #150213-00006#1 2015/02/13 By pomelo add
                        CALL s_desc_get_department_desc(g_staj_m.staj013) RETURNING g_staj_m.staj013_desc
                        DISPLAY BY NAME g_staj_m.staj013,g_staj_m.staj013_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF NOT astt301_staj013_chk(g_staj_m.staj013) THEN
                        #LET g_staj_m.staj013 = g_staj_m_t.staj013  #150213-00006#1 2015/02/13 By pomelo mark
                        LET g_staj_m.staj013 = g_staj_m_o.staj013   #150213-00006#1 2015/02/13 By pomelo add
                        CALL astt301_staj013_ref()
                        NEXT FIELD staj013
                     END IF
                  END IF
               #150213-00006#1 2015/02/13 By pomelo add(S)
                  IF NOT cl_null(g_staj_m.staj007) THEN
                     IF NOT astt301_staj007_chk(g_staj_m.staj007) THEN
                        LET g_staj_m.staj013 = g_staj_m_o.staj013 
                        CALL astt301_staj013_ref()
                        NEXT FIELD CURRENT
                     END IF 
                     CALL astt301_staj007_ref()
                  END IF
               END IF
            ELSE
               LET g_staj_m.staj007 = ''
               LET g_staj_m.staj007_desc = ''
               DISPLAY BY NAME g_staj_m.staj007, g_staj_m.staj007_desc
               #150213-00006#1 2015/02/13 By pomelo add(E)
            END IF
            CALL astt301_staj013_ref()
            #150213-00006#1 2015/02/13 By pomelo add(S)
            LET g_staj_m_o.staj007 = g_staj_m.staj007
            LET g_staj_m_o.staj013 = g_staj_m.staj013
            #150213-00006#1 2015/02/13 By pomelo add(E)
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj013
            #add-point:BEFORE FIELD staj013
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE staj013
            #add-point:ON CHANGE staj013
                        
            #END add-point
 
         #----<<staj014>>----
         #此段落由子樣板a02產生
         AFTER FIELD staj014
            
            #add-point:AFTER FIELD staj014
            LET g_staj_m.staj014_desc = ''
            DISPLAY BY NAME g_staj_m.staj014_desc 
            IF NOT cl_null(g_staj_m.staj014) THEN
               IF NOT astt301_staj014_chk(g_staj_m.staj014) THEN
                  LET g_staj_m.staj014 = g_staj_m_t.staj014
                  CALL astt301_staj014_ref()
                  NEXT FIELD staj014
               END IF
            END IF
            CALL astt301_staj014_ref()

         AFTER FIELD staj041
            IF NOT cl_null(g_staj_m.staj041) THEN 
               CALL astt301_staj041_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_staj_m.staj041 = g_staj_m_t.staj041
                  NEXT FIELD staj041
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_staj_m.staj041
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_staj_m.staj041_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_staj_m.staj041_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD staj014
            #add-point:BEFORE FIELD staj014
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE staj014
            #add-point:ON CHANGE staj014
                        
            #END add-point
         
         #----<<staj017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj017
            #add-point:BEFORE FIELD staj017
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj017
            
            #add-point:AFTER FIELD staj017
            IF NOT cl_null(g_staj_m.staj017) THEN
               IF NOT astt301_staj017_018_chk(p_cmd,"staj017") THEN
                  LET g_staj_m.staj017 = g_staj_m_t.staj017
                  NEXT FIELD staj017
               END IF
               #IF NOT cl_null(g_staj_m.staj005) AND NOT cl_null(g_staj_m.staj018) THEN
               #   IF NOT astt301_interval_chk() THEN
               #      LET g_staj_m.staj017 = g_staj_m_t.staj017
               #      NEXT FIELD staj017
               #   END IF   
               #END IF 
               IF cl_null(g_staj_m.staj039) AND g_staj_m.staj000 = 'I' THEN 
                  LET g_staj_m.staj039 = g_staj_m.staj017
                  DISPLAY BY NAME g_staj_m.staj039
               END IF 
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj017
            #add-point:ON CHANGE staj017
                        
            #END add-point
 
         #----<<staj018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj018
            #add-point:BEFORE FIELD staj018
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj018
            
            #add-point:AFTER FIELD staj018
            IF NOT cl_null(g_staj_m.staj018) THEN
               IF NOT astt301_staj017_018_chk(p_cmd,"staj018") THEN
                  LET g_staj_m.staj018 = g_staj_m_t.staj018
                  NEXT FIELD staj018
               END IF
               #IF NOT cl_null(g_staj_m.staj005) AND NOT cl_null(g_staj_m.staj017) THEN
               #   IF NOT astt301_interval_chk() THEN
               #      LET g_staj_m.staj018 = g_staj_m_t.staj018
               #      NEXT FIELD staj018
               #   END IF   
               #END IF 
               IF NOT astt301_staj033_chk() THEN
                  LET g_staj_m.staj018 = g_staj_m_t.staj018
                  NEXT FIELD staj018           
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj018
            #add-point:ON CHANGE staj018
                        
            #END add-point
 
         #----<<staj019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj019
            #add-point:BEFORE FIELD staj019
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj019
            
            #add-point:AFTER FIELD staj019
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj019
            #add-point:ON CHANGE staj019
                        
            #END add-point
 
         #----<<staj020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staj020
            #add-point:BEFORE FIELD staj020
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staj020
            
            #add-point:AFTER FIELD staj020
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staj020
            #add-point:ON CHANGE staj020
        
#         AFTER FIELD staj032
#            IF NOT cl_null(g_staj_m.staj032) THEN
#               IF NOT astt301_staj032_chk() THEN
#                  LET g_staj_m.staj032 = g_staj_m_t.staj032
#                  NEXT FIELD staj032              
#               END IF 
#               ##########维护了原合同 如果有异动 带出原合同的相关信息，单身的日期预设单头日期
#               IF g_staj_m.staj032 <> g_staj_m_o.staj032 OR cl_null(g_staj_m_o.staj032) THEN
#                  CALL astt301_staj032_other()             
#               END IF               
#               ##########               
#            END IF
#            #150427-00012#7 20160104 add by beckxie---S
#            LET g_staj_m_t.staj032 = g_staj_m.staj032
#            #150427-00012#7 20160104 add by beckxie---E

         AFTER FIELD staj033
            IF NOT cl_null(g_staj_m.staj033) THEN
               IF NOT astt301_staj033_chk() THEN
                  LET g_staj_m.staj033 = g_staj_m_t.staj033
                  NEXT FIELD staj033              
               END IF                        
            END IF
         
         
            #END add-point
 
         #----<<stajsite>>----
         #此段落由子樣板a02產生
         AFTER FIELD stajsite
            
            #add-point:AFTER FIELD stajsite
            #ken-------------------------------s 需求單號：141208-00001 項次：18
            IF NOT cl_null(g_staj_m.stajsite) THEN
               CALL s_aooi500_chk(g_prog,'stajsite',g_staj_m.stajsite,g_staj_m.stajsite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_staj_m.stajsite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_staj_m.stajsite = g_staj_m_t.stajsite
                  CALL astt301_stajsite_ref()
                  NEXT FIELD CURRENT
               END IF
               LET g_staj_m.stajunit = g_staj_m.stajsite
            #sakura---add---str
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_staj_m.stajsite = g_staj_m_t.stajsite
               CALL astt301_stajsite_ref()
               NEXT FIELD CURRENT
            #sakura---add---end
            END IF
            
            #ken-------------------------------e
            LET g_site_flag = TRUE           #sakura add
            CALL astt301_stajsite_ref()
            CALL astt301_set_entry(p_cmd)    #sakura add
            CALL astt301_set_no_entry(p_cmd) #sakura add            

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stajsite
            #add-point:BEFORE FIELD stajsite
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stajsite
            #add-point:ON CHANGE stajsite
                        
            #END add-point
 
         #----<<stajunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stajunit
            #add-point:BEFORE FIELD stajunit
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajunit
            
            #add-point:AFTER FIELD stajunit
       
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stajunit
            #add-point:ON CHANGE stajunit
                        
            #END add-point
 
         #----<<stajstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stajstus
            #add-point:BEFORE FIELD stajstus
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stajstus
            
            #add-point:AFTER FIELD stajstus
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stajstus
            #add-point:ON CHANGE stajstus
                        
            #END add-point
 
         #----<<stajownid>>----
         #----<<stajowndp>>----
         #----<<stajcrtid>>----
         #----<<stajcrtdp>>----
         #----<<stajcrtdt>>----
         #----<<stajmodid>>----
         #----<<stajmoddt>>----
         #----<<stajcnfid>>----
         #----<<stajcnfdt>>----
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<staj000>>----
         #Ctrlp:input.c.staj000
         ON ACTION controlp INFIELD staj000
            #add-point:ON ACTION controlp INFIELD staj000
                        
            #END add-point
 
         #----<<stajdocno>>----
         #Ctrlp:input.c.stajdocno
         ON ACTION controlp INFIELD stajdocno
            #add-point:ON ACTION controlp INFIELD stajdocno
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.stajdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 =  g_ooef004 #
            #LET g_qryparam.arg2 = "astt301" #   #160705-00042#5 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#5 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_staj_m.stajdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.stajdocno TO stajdocno              #顯示到畫面上

            NEXT FIELD stajdocno                          #返回原欄位


            #END add-point
 
         #----<<stajdocdt>>----
         #Ctrlp:input.c.stajdocdt
         ON ACTION controlp INFIELD stajdocdt
            #add-point:ON ACTION controlp INFIELD stajdocdt
                        
            #END add-point
 
         #----<<staj002>>----
         #Ctrlp:input.c.staj002
         ON ACTION controlp INFIELD staj002
            #add-point:ON ACTION controlp INFIELD staj002
                        
            #END add-point
 
         #----<<staj001>>----
         #Ctrlp:input.c.staj001
         ON ACTION controlp INFIELD staj001
            #add-point:ON ACTION controlp INFIELD staj001
                        #此段落由子樣板a07產生            
            IF g_staj_m.staj000 = 'U' OR g_staj_m.staj000 = 'R' THEN
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_staj_m.staj001             #給予default值
               #LET g_qryparam.where = " stanent =",g_enterprise   #add by geza 20150614  #mark by geza 20150615
               #給予arg
               #add by geza 20150615 #150614-00016#1
               IF NOT cl_null(g_staj_m.staj005) THEN
                  LET g_qryparam.where = " stanent =",g_enterprise," AND stan005 = '",g_staj_m.staj005,"'"   
               ELSE
                  LET g_qryparam.where = " stanent =",g_enterprise   
               END IF 
               #add by geza 20150615 #150614-00016#1
               CALL q_stan001_1()                                #呼叫開窗

               LET g_staj_m.staj001 = g_qryparam.return1              #將開窗取得的值回傳到變數

               DISPLAY g_staj_m.staj001 TO staj001              #顯示到畫面上

               NEXT FIELD staj001                          #返回原欄位
            END IF

            #END add-point
 
         #----<<staj003>>----
         #Ctrlp:input.c.staj003
         ON ACTION controlp INFIELD staj003
            #add-point:ON ACTION controlp INFIELD staj003
                        
            #END add-point
 
         #----<<staj021>>----
         #Ctrlp:input.c.staj021
         ON ACTION controlp INFIELD staj021
            #add-point:ON ACTION controlp INFIELD staj021
                        
            #END add-point
 
         #----<<stanstus>>----
         #Ctrlp:input.c.stanstus
         ON ACTION controlp INFIELD stanstus
            #add-point:ON ACTION controlp INFIELD stanstus
                        
            #END add-point
 
         #----<<staj004>>----
         #Ctrlp:input.c.staj004
         ON ACTION controlp INFIELD staj004
            #add-point:ON ACTION controlp INFIELD staj004
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj004             #給予default值
            LET g_qryparam.default2 = '' #g_staj_m.stagl003 #說明
            LET g_qryparam.where = " stag002 = '",g_staj_m.staj002,"'"
            #給予arg

            CALL q_stag001()                                #呼叫開窗
            LET g_qryparam.where = ''   
            LET g_staj_m.staj004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_staj_m.stagl003 = g_qryparam.return2 #說明

            DISPLAY g_staj_m.staj004 TO staj004              #顯示到畫面上
            #DISPLAY g_staj_m.stagl003 TO stagl003 #說明
            CALL astt301_staj004_ref()
            NEXT FIELD staj004                          #返回原欄位


            #END add-point
 
         #----<<staj005>>----
         #Ctrlp:input.c.staj005
         ON ACTION controlp INFIELD staj005
            #add-point:ON ACTION controlp INFIELD staj005
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "('1','3')" #

            CALL q_pmaa001_1()                                #呼叫開窗

            LET g_staj_m.staj005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj005 TO staj005              #顯示到畫面上
        
            CALL astt301_staj005_ref()
            NEXT FIELD staj005                          #返回原欄位


            #END add-point
 
         #----<<staj006>>----
         #Ctrlp:input.c.staj006
         ON ACTION controlp INFIELD staj006
            #add-point:ON ACTION controlp INFIELD staj006
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_staj_m.staj006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj006 TO staj006              #顯示到畫面上
            CALL astt301_staj006_ref()
            NEXT FIELD staj006                          #返回原欄位


            #END add-point
 
         #----<<staj007>>----
         #Ctrlp:input.c.staj007
         ON ACTION controlp INFIELD staj007
            #add-point:ON ACTION controlp INFIELD staj007
                        #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj007             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = g_site           #150213-00006#1 2015/02/13 By pomelo mark
            LET g_qryparam.arg1 = g_staj_m.staj013  #150213-00006#1 2015/02/13 By pomelo add

            CALL q_oodb002_1()                                #呼叫開窗

            LET g_staj_m.staj007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj007 TO staj007              #顯示到畫面上
            CALL astt301_staj007_ref()
            NEXT FIELD staj007                          #返回原欄位


            #END add-point
 
         #----<<staj008>>----
         #Ctrlp:input.c.staj008
         ON ACTION controlp INFIELD staj008
            #add-point:ON ACTION controlp INFIELD staj008
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj008             #給予default值

            CALL q_ooib002_1()                                #呼叫開窗

            LET g_staj_m.staj008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj008 TO staj008              #顯示到畫面上
            CALL astt301_staj008_ref()
            NEXT FIELD staj008                          #返回原欄位            
            #END add-point
            
         #150506-00007#3 150522 by sakura add---STR
         #交易條件
         ON ACTION controlp INFIELD staj024
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_staj_m.staj024
            LET g_qryparam.arg1 = '238'
            CALL q_oocq002()
            LET g_staj_m.staj024 = g_qryparam.return1              
            DISPLAY g_staj_m.staj024 TO staj024              
            CALL s_desc_get_acc_desc('238',g_staj_m.staj024) RETURNING g_staj_m.staj024_desc
            DISPLAY BY NAME g_staj_m.staj024_desc
            NEXT FIELD staj024
         #發票類型   
         ON ACTION controlp INFIELD staj025            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_staj_m.staj025
            LET g_qryparam.arg1 = g_ooef019  #稅區
            LET g_qryparam.arg2 = "1"        #進銷項類型
            CALL q_isac002_2()
            LET g_staj_m.staj025 = g_qryparam.return1
            DISPLAY g_staj_m.staj025 TO staj025
            CALL s_desc_get_invoice_type_desc1(g_site,g_staj_m.staj025) RETURNING g_staj_m.staj025_desc
            DISPLAY BY NAME g_staj_m.staj025_desc
            NEXT FIELD staj025            
         #150506-00007#3 150522 by sakura add---END
 
         #----<<staj009>>----
         #Ctrlp:input.c.staj009
         ON ACTION controlp INFIELD staj009
            #add-point:ON ACTION controlp INFIELD staj009
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj009             #給予default值

            #給予arg
            LET g_qryparam.where = " staaent = ",g_enterprise," "  #150613-00002#1--add by dongsz
            CALL q_staa001()                                #呼叫開窗

            LET g_staj_m.staj009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj009 TO staj009              #顯示到畫面上
            CALL astt301_staj009_ref() 
            NEXT FIELD staj009                          #返回原欄位


            #END add-point
 
         #----<<staj010>>----
         #Ctrlp:input.c.staj010
         ON ACTION controlp INFIELD staj010
            #add-point:ON ACTION controlp INFIELD staj010
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2060" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_staj_m.staj010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj010 TO staj010              #顯示到畫面上
            CALL astt301_staj010_ref()
            NEXT FIELD staj010                          #返回原欄位


            #END add-point
 
         #----<<staj015>>----
         #Ctrlp:input.c.staj015
         ON ACTION controlp INFIELD staj015
            #add-point:ON ACTION controlp INFIELD staj015
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj015             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = 'A'
#            LET g_qryparam.where = ""
#            CALL q_ooef001()                               #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'staj015') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'staj015',g_staj_m.stajsite,'i')
               CALL q_ooef001_24() 
            ELSE
               #LET g_qryparam.where = ""      #150613-00004#1--mark by dongsz
               LET g_qryparam.where = " ooef212 = 'Y' "  #150613-00004#1--add by dongsz
               CALL q_ooef001()  
            END IF
            LET g_staj_m.staj015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj015 TO staj015              #顯示到畫面上
            CALL astt301_staj015_ref()
            NEXT FIELD staj015                          #返回原欄位


            #END add-point
 
         #----<<staj016>>----
         #Ctrlp:input.c.staj016
         ON ACTION controlp INFIELD staj016
            #add-point:ON ACTION controlp INFIELD staj016
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj016             #給予default值

            #給予arg

            #LET g_qryparam.arg1 = 'D'
#            LET g_qryparam.where = "ooef303 = 'Y'"
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'staj016') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'staj016',g_staj_m.stajsite,'i')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef303 = 'Y'"
               CALL q_ooef001()  
            END IF

            LET g_staj_m.staj016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj016 TO staj016              #顯示到畫面上
            CALL astt301_staj016_ref()
            NEXT FIELD staj016                          #返回原欄位


            #END add-point
 
         #----<<staj011>>----
         #Ctrlp:input.c.staj011
         ON ACTION controlp INFIELD staj011
            #add-point:ON ACTION controlp INFIELD staj011
                        
            #END add-point
 
                        
            #END add-point
 
         #----<<staj012>>----
         #Ctrlp:input.c.staj012
         ON ACTION controlp INFIELD staj012
            #add-point:ON ACTION controlp INFIELD staj012
                        
            #END add-point
 
         #----<<staj013>>----
         #Ctrlp:input.c.staj013
         ON ACTION controlp INFIELD staj013
            #add-point:ON ACTION controlp INFIELD staj013
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj013             #給予default值

            #給予arg

            #LET g_qryparam.arg1 = '1'
#            LET g_qryparam.where = "ooef003 ='Y'"
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'staj013') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'staj013',g_staj_m.stajsite,'i')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef003 ='Y'"
               CALL q_ooef001()
            END IF
            LET g_staj_m.staj013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj013 TO staj013              #顯示到畫面上
            CALL astt301_staj013_ref()  
            NEXT FIELD staj013                          #返回原欄位


            #END add-point
 
         #----<<staj014>>----
         #Ctrlp:input.c.staj014
         ON ACTION controlp INFIELD staj014
            #add-point:ON ACTION controlp INFIELD staj014
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_staj_m.staj014             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_staj_m.staj014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj014 TO staj014              #顯示到畫面上
            CALL astt301_staj014_ref()
            NEXT FIELD staj014                          #返回原欄位


         ON ACTION controlp INFIELD staj041
            #add-point:ON ACTION controlp INFIELD staj041
                        #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_staj_m.staj041             #給予default值
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                #呼叫開窗
            LET g_staj_m.staj041 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_staj_m.staj041 TO staj041              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_staj_m.staj041
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_staj_m.staj041_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_staj_m.staj041_desc
            NEXT FIELD staj041                          #返回原欄位
            #END add-point
 
         #----<<staj017>>----
         #Ctrlp:input.c.staj017
         ON ACTION controlp INFIELD staj017
            #add-point:ON ACTION controlp INFIELD staj017
                        
            #END add-point
 
         #----<<staj018>>----
         #Ctrlp:input.c.staj018
         ON ACTION controlp INFIELD staj018
            #add-point:ON ACTION controlp INFIELD staj018
                        
            #END add-point
 
         #----<<staj019>>----
         #Ctrlp:input.c.staj019
         ON ACTION controlp INFIELD staj019
            #add-point:ON ACTION controlp INFIELD staj019
                        
            #END add-point
 
         #----<<staj020>>----
         #Ctrlp:input.c.staj020
         ON ACTION controlp INFIELD staj020
            #add-point:ON ACTION controlp INFIELD staj020
         


           
            #END add-point
 
         #----<<stajsite>>----
         #Ctrlp:input.c.stajsite
         ON ACTION controlp INFIELD stajsite
            #add-point:ON ACTION controlp INFIELD stajsite
                        #此段落由子樣板a07產生            
            #開窗i段
			#INITIALIZE g_qryparam.* TO NULL
         #   LET g_qryparam.state = 'i'
			#LET g_qryparam.reqry = FALSE
         #
         #   LET g_qryparam.default1 = g_staj_m.stajsite             #給予default值
         #
         #   #給予arg
         #   LET g_qryparam.arg1 = "" #
         #   LET g_qryparam.arg2 = "" #
         #
         #   CALL q_ooed004()                                #呼叫開窗
         #
         #   LET g_staj_m.stajsite = g_qryparam.return1              #將開窗取得的值回傳到變數
         #
         #   DISPLAY g_staj_m.stajsite TO stajsite              #顯示到畫面上
         #
         #   NEXT FIELD stajsite                          #返回原欄位

            #ken-------------------------s 需求單號：141208-00001 項次：18
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_staj_m.stajsite             #給予default值
            
            #給予arg
            CALL s_aooi500_q_where(g_prog,'stajsite',g_staj_m.stajsite,'i') RETURNING l_where
            LET g_qryparam.where = l_where
            CALL q_ooef001_24()
            LET g_staj_m.stajsite = g_qryparam.return1
            DISPLAY g_staj_m.stajsite TO stajsite
            CALL s_desc_get_department_desc(g_staj_m.stajsite) RETURNING g_staj_m.stajsite_desc
            DISPLAY BY NAME g_staj_m.stajsite_desc
            NEXT FIELD stajsite                          #返回原欄位
            #ken-------------------------e
            #END add-point
 
         #----<<stajunit>>----
         #Ctrlp:input.c.stajunit
         ON ACTION controlp INFIELD stajunit
            #add-point:ON ACTION controlp INFIELD stajunit
                        
            #END add-point
 
         #----<<stajstus>>----
         #Ctrlp:input.c.stajstus
         ON ACTION controlp INFIELD stajstus
            #add-point:ON ACTION controlp INFIELD stajstus
                        
            #END add-point
 
         #----<<stajownid>>----
         #----<<stajowndp>>----
         #----<<stajcrtid>>----
         #----<<stajcrtdp>>----
         #----<<stajcrtdt>>----
         #----<<stajmodid>>----
         #----<<stajmoddt>>----
         #----<<stajcnfid>>----
         #----<<stajcnfdt>>----
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
           # CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME g_staj_m.stajdocno             
 
                            
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
              #CALL s_aooi200_gen_docno(g_site,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_prog) #ken 需求單號：141208-00001 項次：18 #sakura mark
               CALL s_aooi200_gen_docno(g_staj_m.stajsite,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_prog) #sakura add
                 RETURNING l_flag,g_staj_m.stajdocno
                IF NOT l_flag THEN
                   NEXT FIELD stajdocno
                END IF 
                IF NOT astt301_interval_chk(p_cmd) THEN
                  # CALL s_transaction_end('N','0')
                   NEXT FIELD CURRENT
                END IF  
               LET g_staj_m.stajunit = g_staj_m.stajsite   #ken 需求單號：141208-00001 項次：18
               #IF g_staj_m.staj000 != 'R' THEN            #mark by geza 20150916  
               IF g_staj_m.staj000 ='I' THEN               #add by geza 20150916 
                  #geza 20150615 add --------------(S)
                  CALL s_aooi390_get_auto_no('22',g_staj_m.staj001) RETURNING l_success,g_staj_m.staj001
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
                  #geza 20150615 add --------------(E)
                  CALL s_aooi390_oofi_upd('22',g_staj_m.staj001) RETURNING l_success  #add--2015/05/08 By shiun 增加編碼功能
               END IF 
               #end add-point
               
               INSERT INTO staj_t (stajent,staj000,staj039,stajdocno,stajdocdt,staj002,staj001,staj003,staj021, 
                   staj004,staj005,staj006,staj007,staj008,
                   staj024,staj025,staj040,staj026,staj027,staj028,staj029,staj030, #150506-00007#3 150522 by sakura add
                   staj031,
                   staj033,staj034,staj035,staj036,staj037,staj038,
                   staj009,staj010,staj015,staj016,staj011,
                   staj012,staj013,staj014,staj041,staj017,staj018,staj019,staj020,stajsite,stajunit,stajstus,staj042,  #add by geza 20160318 staj042 
                   stajownid,stajowndp,stajcrtid,stajcrtdp,stajcrtdt,stajmodid,stajmoddt,stajcnfid,stajcnfdt) 
 
               VALUES (g_enterprise,g_staj_m.staj000,g_staj_m.staj039,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_staj_m.staj002, 
                   g_staj_m.staj001,g_staj_m.staj003,g_staj_m.staj021,g_staj_m.staj004,g_staj_m.staj005, 
                   g_staj_m.staj006,g_staj_m.staj007,g_staj_m.staj008,
                   g_staj_m.staj024,g_staj_m.staj025,g_staj_m.staj040,g_staj_m.staj026,g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj029,g_staj_m.staj030, #150506-00007#3 150522 by sakura add
                   g_staj_m.staj031,
                   g_staj_m.staj033,g_staj_m.staj034,g_staj_m.staj035,g_staj_m.staj036,g_staj_m.staj037,g_staj_m.staj038,
                   g_staj_m.staj009,g_staj_m.staj010, 
                   g_staj_m.staj015,g_staj_m.staj016,g_staj_m.staj011,g_staj_m.staj012, 
                   g_staj_m.staj013,g_staj_m.staj014,g_staj_m.staj041,g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj019, 
                   g_staj_m.staj020,g_staj_m.stajsite,g_staj_m.stajunit,g_staj_m.stajstus,g_staj_m.staj042,g_staj_m.stajownid, #add by geza 20160318 staj042
                   g_staj_m.stajowndp,g_staj_m.stajcrtid,g_staj_m.stajcrtdp,g_staj_m.stajcrtdt,g_staj_m.stajmodid, 
                   g_staj_m.stajmoddt,g_staj_m.stajcnfid,g_staj_m.stajcnfdt) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_staj_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭新增中
               IF NOT cl_null(g_staj_m.staj004) AND g_staj_m.staj000 = 'I' THEN
                   CALL astt301_staj004_genb()
                   CALL astt301_b_fill()
                   LET l_ac3 = 1
                   CALL astt301_b3_fill()
                   CALL astt301_reflesh()
                END IF   
                LET g_period_flag = 'N'
               IF g_staj_m.staj000 = 'U' AND NOT cl_null(g_staj_m.staj001) THEN
                  IF NOT astt301_staj001_genb() THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF         
                  CALL astt301_b_fill()
                  LET l_ac3 = 1
                  CALL astt301_b3_fill()
                  CALL astt301_reflesh()
               END IF
                #add by yangxf ----start----
                IF g_staj_m.staj000 = 'R' AND NOT cl_null(g_staj_m.staj001) THEN                            
                  IF NOT astt301_staj001_genb_2() THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF         
                  CALL astt301_b_fill()
                  LET l_ac3 = 1
                  CALL astt301_b3_fill()
                  CALL astt301_reflesh()
               END IF
                #add by yangxf ----end-----

                IF NOT astt301_stak_upd() THEN 
                   CALL s_transaction_end('N','0')
                   NEXT FIELD CURRENT
                END IF 
                IF NOT cl_null(g_staj_m.staj033) THEN 
                   UPDATE stak_t SET stak017 = g_staj_m.staj017,
                                     stak018 = g_staj_m.staj033
                    WHERE stakent = g_enterprise
                      AND stakdocno = g_staj_m.stajdocno
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = "upd stak_t"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      CALL s_transaction_end('N','0')
                      CONTINUE DIALOG
                   END IF
                   CALL astt301_b_fill()
                   LET l_ac3 = 1
                   CALL astt301_b3_fill()
                   CALL astt301_reflesh()
                ELSE
                   UPDATE stak_t SET stak017 = g_staj_m.staj017,
                                     stak018 = g_staj_m.staj018
                    WHERE stakent = g_enterprise
                      AND stakdocno = g_staj_m.stajdocno
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = "upd stak_t"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      CALL s_transaction_end('N','0')
                      CONTINUE DIALOG
                   END IF
                   CALL astt301_b_fill()
                   LET l_ac3 = 1
                   CALL astt301_b3_fill()
                   CALL astt301_reflesh()
                END IF 
                ############
                #更新纳入结算单否、票扣否
                IF NOT astt301_staj040_upd() THEN
                   CALL s_transaction_end('N','0')
                   NEXT FIELD CURRENT
                END IF 
                CALL astt301_b_fill()
               #end add-point
               
               
               
               CALL s_transaction_end('Y','0') 
               
               #add-point:單頭新增後
                                                          
               #end add-point
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL astt301_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
 
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前
               IF NOT astt301_interval_chk(p_cmd) THEN
                   CALL s_transaction_end('N','0')
                   NEXT FIELD CURRENT
               END IF          
#               LET g_period_flag = 'N'   #add by yangxf 
#               IF NOT astt301_upd_staw(p_cmd) THEN
#                    CALL s_transaction_end('N','0')
#                    NEXT FIELD CURRENT
#               END IF
               
               LET g_staj_m.stajunit = g_staj_m.stajsite   #ken 需求單號：141208-00001 項次：18
               #end add-point
               
               UPDATE staj_t SET (staj000,staj039,stajdocno,stajdocdt,staj002,staj001,staj003,staj021,staj004, 
                   staj005,staj006,staj007,staj008,
                   staj024,staj025,staj040,staj026,staj027,staj028,staj029,staj030, #150506-00007#3 150522 by sakura add
                   staj031,
                   staj033,staj034,staj035,staj036,staj037,staj038,
                   staj009,staj010,staj015,staj016,staj011,
                   staj012,staj013,staj014,staj041,staj017,staj018,staj019,staj020,stajsite,stajunit,stajstus,staj042, #add by geza 20160318 staj042 
                   stajownid,stajowndp,stajcrtid,stajcrtdp,stajcrtdt,stajmodid,stajmoddt,stajcnfid,stajcnfdt) = (g_staj_m.staj000, 
                   g_staj_m.staj039,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_staj_m.staj002,g_staj_m.staj001,g_staj_m.staj003, 
                   g_staj_m.staj021,g_staj_m.staj004,g_staj_m.staj005,g_staj_m.staj006,g_staj_m.staj007, 
                   g_staj_m.staj008,
                   g_staj_m.staj024,g_staj_m.staj025,g_staj_m.staj040,g_staj_m.staj026,g_staj_m.staj027, #150506-00007#3 150522 by sakura add 
                   g_staj_m.staj028,g_staj_m.staj029,g_staj_m.staj030,                  #150506-00007#3 150522 by sakura add
                   g_staj_m.staj031,
                   g_staj_m.staj033,g_staj_m.staj034,g_staj_m.staj035,g_staj_m.staj036,g_staj_m.staj037,g_staj_m.staj038,
                   g_staj_m.staj009,g_staj_m.staj010,g_staj_m.staj015,g_staj_m.staj016, 
                   g_staj_m.staj011,g_staj_m.staj012,g_staj_m.staj013,g_staj_m.staj014,g_staj_m.staj041,
                   g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj019,g_staj_m.staj020,g_staj_m.stajsite, 
                   g_staj_m.stajunit,g_staj_m.stajstus,g_staj_m.staj042,g_staj_m.stajownid,g_staj_m.stajowndp,g_staj_m.stajcrtid, #add by geza 20160318 staj042
                   g_staj_m.stajcrtdp,g_staj_m.stajcrtdt,g_staj_m.stajmodid,g_staj_m.stajmoddt,g_staj_m.stajcnfid, 
                   g_staj_m.stajcnfdt)
                WHERE stajent = g_enterprise AND stajdocno = g_stajdocno_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "staj_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭修改中
                                            IF g_staj_m_t.staj004 <> g_staj_m.staj004 AND p_cmd = 'u' THEN  
                IF NOT cl_null(g_staj_m.staj004) AND g_staj_m.staj000 = 'I'  THEN            
                   DELETE FROM stak_t WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno
                   DELETE FROM stal_t WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno
                   CALL astt301_staj004_genb()
                   CALL astt301_b_fill()
                   LET l_ac3 = 1
                   CALL astt301_b3_fill()
                   CALL astt301_reflesh()
                END IF
              END IF
              
               ############

                ############
             #add by yangxf ---start----
             IF NOT astt301_stak_upd() THEN 
                CALL s_transaction_end('N','0')
                NEXT FIELD CURRENT
             END IF 
             IF NOT cl_null(g_staj_m.staj033) THEN 
                IF g_staj_m.staj017 != g_staj_m_t.staj017 OR g_staj_m.staj018 != g_staj_m_t.staj018
                OR cl_null(g_staj_m_t.staj033) OR g_staj_m.staj033 != g_staj_m_t.staj033 THEN 
                   UPDATE stak_t SET stak017 = g_staj_m.staj017,
                                     stak018 = g_staj_m.staj033
                    WHERE stakent = g_enterprise
                      AND stakdocno = g_staj_m.stajdocno
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = "upd stak_t"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      CALL s_transaction_end('N','0')
                      CONTINUE DIALOG
                   END IF
                   CALL astt301_b_fill()
                   LET l_ac3 = 1
                   CALL astt301_b3_fill()
                   CALL astt301_reflesh()
                END IF 
             ELSE
                IF g_staj_m.staj017 != g_staj_m_t.staj017 OR g_staj_m.staj018 != g_staj_m_t.staj018 
                OR NOT cl_null(g_staj_m_t.staj033) THEN 
                   UPDATE stak_t SET stak017 = g_staj_m.staj017,
                                     stak018 = g_staj_m.staj018
                    WHERE stakent = g_enterprise
                      AND stakdocno = g_staj_m.stajdocno
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = "upd stak_t"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      CALL s_transaction_end('N','0')
                      CONTINUE DIALOG
                   END IF
                   CALL astt301_b_fill()
                   LET l_ac3 = 1
                   CALL astt301_b3_fill()
                   CALL astt301_reflesh()
                END IF 
             END IF 
             #add by yangxf ----end-----
             # IF g_staj_m_t.staj001 <> g_staj_m.staj001 AND p_cmd = 'u' THEN  
             #   IF NOT cl_null(g_staj_m.staj001) AND g_staj_m.staj000 = 'U' THEN
             #      CALL astt301_staj001_genb()
             #      CALL astt301_b_fill()
             #      LET l_ac3 = 1
             #      CALL astt301_b3_fill()
             #      CALL astt301_reflesh()
             #   END IF
             # END IF                
               #end add-point
               
               
               
               CALL s_transaction_end('Y','0')
               
               #add-point:單頭修改後
                              
               #end add-point
            END IF
            
            LET g_stajdocno_t = g_staj_m.stajdocno
 
            #controlp
            
      END INPUT
   
 
{</section>}
 
{<section id="astt301.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_stak_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stak_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt301_b_fill()
            LET g_rec_b = g_stak_d.getLength()
            #add-point:資料輸入前
            LET g_field = 'stak'
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            CALL astt301_b_fill2('2')
            CALL astt301_b_fill2('3')
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN astt301_cl USING g_enterprise,g_staj_m.stajdocno
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astt301_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE astt301_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_stak_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stak_d[l_ac].stakseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stak_d_t.* = g_stak_d[l_ac].*  #BACKUP
               CALL astt301_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
                              
               #end add-point  
               CALL astt301_set_no_entry_b(l_cmd)
               IF NOT astt301_lock_b("stak_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt301_bcl INTO g_stak_d[l_ac].stakseq,g_stak_d[l_ac].stak003,g_stak_d[l_ac].stak003_desc,g_stak_d[l_ac].stak023,g_stak_d[l_ac].stak024,   #add  by geza 20150610 
                      g_stak_d[l_ac].stak025,g_stak_d[l_ac].stak025_desc,g_stak_d[l_ac].stak004,g_stak_d[l_ac].stak005,g_stak_d[l_ac].stak006,g_stak_d[l_ac].stak028,g_stak_d[l_ac].stak007, 
                      g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak027,g_stak_d[l_ac].stak009,g_stak_d[l_ac].stak009_desc,g_stak_d[l_ac].stak010,     #150612-00023#5 add stak027
                      g_stak_d[l_ac].stak010_desc,g_stak_d[l_ac].stak011,g_stak_d[l_ac].stak012,g_stak_d[l_ac].stak013, 
                      g_stak_d[l_ac].stak014,g_stak_d[l_ac].stak015,g_stak_d[l_ac].stak016,g_stak_d[l_ac].stak029,g_stak_d[l_ac].stak030,g_stak_d[l_ac].stak022,g_stak_d[l_ac].stak017, 
                      g_stak_d[l_ac].stak018,g_stak_d[l_ac].stak019,g_stak_d[l_ac].stakunit,g_stak_d[l_ac].staksite 
 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_stak_d_t.stakseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astt301_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
             IF l_cmd = 'u' THEN
                 CALL astt301_b3_fill()
                 CALL astt301_reflesh()
             END IF 
  
             CALL astt301_set_entry_b(l_cmd)
             CALL astt301_set_no_required_b(l_cmd)
             CALL astt301_set_required_b(l_cmd)
             CALL astt301_set_no_entry_b(l_cmd)
             IF NOT cl_null(g_stak_d[l_ac].stak030) THEN
                CALL cl_set_comp_required('stak029',TRUE)          
             ELSE
                CALL cl_set_comp_required('stak029',FALSE)
             END IF
             LET g_stak_d_t.* = g_stak_d[l_ac].*
             LET g_stak_d_o.* = g_stak_d[l_ac].*
             # add geza 150504-00002#1 (S)  
             IF g_stak_d[l_ac].stak016 = '1' THEN
                CALL cl_set_comp_visible('group7',FALSE)
             ELSE
                CALL cl_set_comp_visible('group7',TRUE)
             END IF     
             # add geza 150504-00002#1 (E)   
             CALL astt301_set_visible(g_detail_idx)

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stak_d[l_ac].* TO NULL 
                  LET g_stak_d[l_ac].stak013 = "1"
      LET g_stak_d[l_ac].stak016 = "1"
 
 
            LET g_stak_d_t.* = g_stak_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt301_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
                        
            #end add-point
            CALL astt301_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stak_d[li_reproduce_target].* = g_stak_d[li_reproduce].*
 
               LET g_stak_d[li_reproduce_target].stakseq = NULL
 
            END IF
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert
                                     LET g_insert = 'Y'
             CALL g_stal_d.clear()
             CALL astt301_set_entry_b(l_cmd)
             CALL astt301_set_no_required_b(l_cmd)
             CALL astt301_set_required_b(l_cmd)
             CALL astt301_set_no_entry_b(l_cmd)
             SELECT MAX(stakseq)+1 INTO  g_stak_d[l_ac].stakseq FROM stak_t
              WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno
             IF cl_null( g_stak_d[l_ac].stakseq ) THEN             
                LET g_stak_d[l_ac].stakseq = 1
             END IF
             SELECT MAX(stao002)+1 INTO l_stao002 FROM stao_t
              WHERE staoent = g_enterprise AND stao001 = g_staj_m.staj001
             IF cl_null(l_stao002) THEN 
                LET l_stao002 = 1
             END IF 
             IF g_stak_d[l_ac].stakseq < l_stao002 THEN
                LET g_stak_d[l_ac].stakseq = l_stao002
             END IF
            LET g_stak_d[l_ac].stak022 = '0'
            LET g_stak_d[l_ac].stak017  = g_staj_m.staj017
            LET g_stak_d[l_ac].stak018  = g_staj_m.staj018 
            LET g_stak_d[l_ac].staksite = g_staj_m.stajsite
            LET g_stak_d[l_ac].stakunit = g_staj_m.stajunit
            LET g_stak_d[l_ac].stak027 = 'Y' #150612-00023#5 add
            LET g_stak_d[l_ac].stak028 = 'N' 
            LET g_stak_d[l_ac].stakacti = 'Y' 
            IF g_stak_d[l_ac].stak016 = '1' THEN
                CALL cl_set_comp_visible('group7',FALSE)
             ELSE
                CALL cl_set_comp_visible('group7',TRUE)
             END IF     
             CALL s_astt301_get_stak023_stak024(g_staj_m.staj040,'')
                   RETURNING g_stak_d[l_ac].stak023,g_stak_d[l_ac].stak024
             CALL astt301_set_visible(g_detail_idx)
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
            SELECT COUNT(*) INTO l_count FROM stak_t 
             WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno
 
               AND stakseq = g_stak_d[l_ac].stakseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
                              
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak_d[g_detail_idx].stakseq
               CALL astt301_insert_b('stak_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
                              
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_stak_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stak_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt301_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
                              
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_stak_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_stak_d.deleteElement(l_ac)
               NEXT FIELD stakseq
            END IF
         
            IF g_stak_d[l_ac].stakseq IS NOT NULL
 
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
#               IF astt301_chk_astm301_jiesuan(g_stak_d_t.stakseq) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code =  "ast-00148"
#                  LET g_errparam.extend = ""
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#               
#                  CANCEL DELETE
#               END IF
               
               DELETE FROM stal_t
                WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno AND

                      stalseq1 = g_stak_d_t.stakseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "stal_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE 
               END IF    
               
               DELETE FROM stay_t 
                WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno AND
                      stayseq1 = g_stak_d_t.stakseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "stay_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE 
               END IF
               #end add-point 
               
               DELETE FROM stak_t
                WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno AND
 
                      stakseq = g_stak_d_t.stakseq
 
                  
               #add-point:單身刪除中
                              
               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stak_t"
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
               CLOSE astt301_bcl
               LET l_count = g_stak_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak_d[g_detail_idx].stakseq
 
              
         AFTER DELETE 
            #add-point:單身刪除後2
                        
            #end add-point
                           CALL astt301_delete_b('stak_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<stakseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stakseq
            #add-point:BEFORE FIELD stakseq
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stakseq
            
            #add-point:AFTER FIELD stakseq
                                    #此段落由子樣板a05產生
            IF  NOT cl_null(g_staj_m.stajdocno) AND NOT cl_null(g_stak_d[g_detail_idx].stakseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_staj_m.stajdocno != g_stajdocno_t OR g_stak_d[g_detail_idx].stakseq != g_stak_d_t.stakseq))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stak_t WHERE "||"stakent = '" ||g_enterprise|| "' AND "||"stakdocno = '"||g_staj_m.stajdocno ||"' AND "|| "stakseq = '"||g_stak_d[g_detail_idx].stakseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
#                  IF astt301_chk_astm301_jiesuan(g_stak_d_t.stakseq) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'ast-00204'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_stak_d[l_ac].stakseq  = g_stak_d_t.stakseq 
#                     NEXT FIELD stakseq
#                  END IF  
               END IF
            END IF
            LET g_stak_d_t.stakseq = g_stak_d[l_ac].stakseq 

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stakseq
            #add-point:ON CHANGE stakseq
                        
            #END add-point
 
         #----<<stak003>>----
         #此段落由子樣板a02產生
         AFTER FIELD stak003
            
            #add-point:AFTER FIELD stak003
                                   LET g_stak_d[l_ac].stak003_desc = ''
           DISPLAY BY NAME g_stak_d[l_ac].stak003_desc           
           IF NOT cl_null(g_stak_d[l_ac].stak003) THEN
              IF NOT astt301_stak003_chk(g_stak_d[l_ac].stak003 ) THEN
                 LET g_stak_d[l_ac].stak003 = g_stak_d_t.stak003
                 CALL astt301_stak003_ref() 
                 SELECT stae006 INTO  g_stak_d[l_ac].stak005 FROM stae_t WHERE staeent = g_enterprise AND stae001 = g_stak_d[l_ac].stak003
                 DISPLAY BY NAME g_stak_d[l_ac].stak005 
               
                 NEXT FIELD stak003
              END IF
              
            
               
              IF g_stak_d[l_ac].stak003 <> g_stak_d_o.stak003 AND NOT cl_null(g_stak_d_o.stak003) THEN
                # SELECT COUNT(*) INTO l_n FROM staf_t
                #  WHERE stafent = g_enterprise AND staf001= g_stak_d[l_ac].stak003 AND staf002 = g_staj_m.staj002
                #    AND staf003 = 'stak016' AND staf004 = 'N'
                # IF l_n> 0 THEN
                #       IF cl_ask_confirm('ast-00024') THEN
                #          DELETE FROM stal_t
                #           WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno AND
                #                 stalseq1 = g_stak_d_t.stakseq
                #           CALL g_stal_d.clear()
                #       ELSE
                #           LET g_stak_d[l_ac].stak003 = g_stak_d_t.stak003
                #           CALL astt301_stak003_ref() 
                #           NEXT FIELD stak003
                #       END IF
                # END IF
                 IF l_cmd = 'u' AND g_stal_d.getlength() > 0 THEN
                     IF cl_ask_confirm('ast-00018') THEN
                        DELETE FROM stal_t
                         WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno AND
                               stalseq1 = g_stak_d_t.stakseq
                         CALL g_stal_d.clear()
               
                     END IF  
                 END IF  
               END IF
               IF (g_stak_d[l_ac].stak003 <> g_stak_d_o.stak003 AND NOT cl_null(g_stak_d_o.stak003)) OR (l_cmd = 'a' AND cl_null(g_stak_d_o.stak003)) THEN
                 LET g_stak_d_t.stakseq = g_stak_d[l_ac].stakseq
                 LET g_stak_d_t.stak003 = g_stak_d[l_ac].stak003
                 INITIALIZE g_stak_d[l_ac].* TO NULL
                 LET g_stak_d[l_ac].stak013 = "1"
                 LET g_stak_d[l_ac].stak016 = "1"
                 LET g_stak_d[l_ac].stak022 = '0'                   #mark by yangxf 20160114 #add by geza 20160322
                 #LET g_stak_d[l_ac].stak022 = g_stak_d_t.stak022    #add by yangxf 20160114 #mark by geza 20160322
                 LET g_stak_d[l_ac].stak027 = 'Y'  #150612-00023#5 add
                 LET g_stak_d[l_ac].stakacti = 'Y'
                 LET g_stak_d[l_ac].stak017  = g_staj_m.staj017
                 LET g_stak_d[l_ac].stak018  = g_staj_m.staj018 
                 LET g_stak_d[l_ac].stakseq = g_stak_d_t.stakseq
                 LET g_stak_d[l_ac].stak003 =  g_stak_d_t.stak003 
                 
                  #帶出費用編號預設
                 SELECT stae006 INTO  g_stak_d[l_ac].stak005 FROM stae_t WHERE staeent = g_enterprise AND stae001 = g_stak_d[l_ac].stak003
                   DISPLAY BY NAME g_stak_d[l_ac].stak003_desc,g_stak_d[l_ac].stak005
                 IF g_stak_d[l_ac].stak005 = '3' THEN
                    LET g_stak_d[l_ac].stak005 = ''
                 END IF                    
                #費用合約設定asti204
                 CALL astt301_default(g_staj_m.staj002,g_stak_d[l_ac].stak003)
              END IF
              CALL astt301_stak003_ref()
              #SELECT stae006 INTO  g_stak_d[l_ac].stak005 FROM stae_t WHERE staeent = g_enterprise AND stae001 = g_stak_d[l_ac].stak003
              #帶出納入結算單否，票扣否   #add by geza 20150609(S)           
#mark by yangxf ----start----              
#               SELECT stae011,stae007 INTO g_stak_d[l_ac].stak023,g_stak_d[l_ac].stak024
#                 FROM stae_t
#                WHERE staeent = g_enterprise   
#                  AND stae001 = g_stak_d[l_ac].stak003
#mark by yangxf ----end-----
#add by yangxf ----start-----
              CALL s_astt301_get_stak023_stak024(g_staj_m.staj040,g_stak_d[l_ac].stak003)
                   RETURNING g_stak_d[l_ac].stak023,g_stak_d[l_ac].stak024
#add by yangxf ----end-------
               IF cl_null(g_stak_d[l_ac].stak023) THEN
                  LET g_stak_d[l_ac].stak023 = 'Y' 
               END IF
               IF cl_null(g_stak_d[l_ac].stak024) THEN
                  LET g_stak_d[l_ac].stak024 = 'N' 
               END IF
               DISPLAY g_stak_d[l_ac].stak023 TO stak023   
               DISPLAY g_stak_d[l_ac].stak024 TO stak024      
              #add by geza 20150609(E)
           ELSE
              LET g_stak_d[l_ac].stak003_desc = ''
              LET g_stak_d[l_ac].stak005 = ''
           END IF
           
           LET g_stak_d_o.stak003 = g_stak_d[l_ac].stak003
              CALL astt301_set_entry_b(l_cmd)
              CALL astt301_set_no_required_b(l_cmd)
              CALL astt301_set_required_b(l_cmd)
              CALL astt301_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stak003
            #add-point:BEFORE FIELD stak003
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stak003
            #add-point:ON CHANGE stak003
               
         BEFORE FIELD stak023
            
            #add-point:BEFORE FIELD stak023
                                 
                     
          #END add-point
         #此段落由子樣板a02產生
         AFTER FIELD stak023
            
            #add-point:AFTER FIELD stak023
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak023
            #add-point:ON CHANGE stak023
            #add by geza 20150610
            IF g_stak_d[l_ac].stak023 = 'N' THEN
               LET g_stak_d[l_ac].stak024 = 'N'
            END IF
            CALL astt301_set_entry_b(l_cmd)
            CALL astt301_set_no_entry_b(l_cmd) 
            #add by geza 20150610            
            #END add-point
            
         BEFORE FIELD stak024
            
            #add-point:BEFORE FIELD stak024
                                 
                     
          #END add-point
         #此段落由子樣板a02產生
         AFTER FIELD stak024
            
            #add-point:AFTER FIELD stak024
                        
            #END add-point
          
         AFTER FIELD stak025
             IF NOT cl_null(g_stak_d[l_ac].stak025) THEN
                IF NOT astt301_stak025_chk() THEN
                   LET g_stak_d[l_ac].stak025 = g_stak_d_t.stak025
                   CALL astt301_stak025_ref()
                   NEXT FIELD stak025
                END IF
             END IF
             CALL astt301_stak025_ref() 
 
         #此段落由子樣板a04產生
         ON CHANGE stak024
            #add-point:ON CHANGE stak024
                        
            #END add-point   
            
         #此段落由子樣板a02產生
         BEFORE FIELD stak004
            
          #add-point:BEFORE FIELD stak004                                
                     
          #END add-point
         #此段落由子樣板a02產生
         AFTER FIELD stak004
            
            #add-point:AFTER FIELD stak004
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak004
            #add-point:ON CHANGE stak004
                        
            #END add-point
 
         #----<<stak005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak005
            #add-point:BEFORE FIELD stak005
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak005
            
            #add-point:AFTER FIELD stak005
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak005
            #add-point:ON CHANGE stak005
                        
            #END add-point
 
         #----<<stak006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak006
            #add-point:BEFORE FIELD stak006
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak006
            
            #add-point:AFTER FIELD stak006
             CALL astt301_set_entry_b(l_cmd)
             CALL astt301_set_no_required_b(l_cmd)
             CALL astt301_set_required_b(l_cmd)
             CALL astt301_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak006
            #add-point:ON CHANGE stak006
            IF g_stak_d[l_ac].stak006 = '1' THEN 
               LET g_stak_d[l_ac].stak028 = 'N'
               CALL cl_set_comp_entry('stak028',FALSE)
            ELSE
               CALL cl_set_comp_entry('stak028',TRUE)
            END IF 
            #END add-point
 
         #----<<stak007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak007
            #add-point:BEFORE FIELD stak007
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak007
            
            #add-point:AFTER FIELD stak007
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak007
            #add-point:ON CHANGE stak007
#            IF NOT cl_null(g_stak_d[l_ac].stak007) AND NOT cl_null(g_stak_d[l_ac].stak008)  AND NOT cl_null(g_stak_d[l_ac].stak017) AND NOT cl_null(g_stak_d[l_ac].stak018) THEN    
#               IF astt301_rtao_chk(g_stak_d[l_ac].stakseq) THEN      #add by yangxf         
#                  CALL astt301_cal_nextd() RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#               #add by yangxf ---start---
#               ELSE
#                  CALL s_astt301_cal_nextd_2(g_stak_d[l_ac].stak007,g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak017,g_stak_d[l_ac].stak018,'Y',g_staj_m.stajdocno)
#                       RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#               END IF 
#               #add by yangxf ----end----
#            END IF             
            #END add-point
 
         #----<<stak008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak008
            #add-point:BEFORE FIELD stak008
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak008
            
            #add-point:AFTER FIELD stak008
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak008
            #add-point:ON CHANGE stak008
#            IF NOT cl_null(g_stak_d[l_ac].stak007) AND NOT cl_null(g_stak_d[l_ac].stak008)  AND NOT cl_null(g_stak_d[l_ac].stak017) AND NOT cl_null(g_stak_d[l_ac].stak018) THEN    
#               IF astt301_rtao_chk(g_stak_d[l_ac].stakseq) THEN      #add by yangxf         
#                  CALL astt301_cal_nextd() RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#               #add by yangxf ---start---
#               ELSE
#                  CALL s_astt301_cal_nextd_2(g_stak_d[l_ac].stak007,g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak017,g_stak_d[l_ac].stak018,'Y',g_staj_m.stajdocno)
#                       RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#               END IF 
#               #add by yangxf ----end----
#            END IF              
            #END add-point
 
         #----<<stak009>>----
         #此段落由子樣板a02產生
         AFTER FIELD stak009
            
            #add-point:AFTER FIELD stak009
            LET g_stak_d[l_ac].stak009_desc = ''
            IF NOT cl_null(g_stak_d[l_ac].stak009) THEN
               IF NOT astt301_stak009_chk(g_stak_d[l_ac].stak009) THEN
                  LET g_stak_d[l_ac].stak009 = g_stak_d_t.stak009
                  CALL astt301_stak009_ref()
                  NEXT FIELD stak009
               END IF
               IF NOT astt301_stand_chk(g_stak_d[l_ac].stak009) THEN
                  LET g_stak_d[l_ac].stak009 = g_stak_d_t.stak009
                  CALL astt301_stak009_ref()
                  NEXT FIELD stak009
               END IF
               
            END IF
            CALL astt301_stak009_ref()
            
            CALL astt301_set_entry_b(l_cmd)
            CALL astt301_set_no_required_b(l_cmd)
            CALL astt301_set_required_b(l_cmd)
            CALL astt301_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stak009
            #add-point:BEFORE FIELD stak009
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stak009
            #add-point:ON CHANGE stak009
                        
            #END add-point
 
         #----<<stak010>>----
         #此段落由子樣板a02產生
         AFTER FIELD stak010
            
            #add-point:AFTER FIELD stak010
            LET g_stak_d[l_ac].stak010_desc = ''
            IF NOT cl_null(g_stak_d[l_ac].stak010) THEN
               IF NOT astt301_stak009_chk(g_stak_d[l_ac].stak010) THEN
                  LET g_stak_d[l_ac].stak010 = g_stak_d_t.stak010
                  CALL astt301_stak010_ref()
                  NEXT FIELD stak010
               END IF
               IF NOT astt301_stand_chk(g_stak_d[l_ac].stak009) THEN
                   LET g_stak_d[l_ac].stak010 = g_stak_d_t.stak010
                   CALL astt301_stak010_ref()
                   NEXT FIELD stak010
               END IF
            END IF
            CALL astt301_stak010_ref()
            CALL astt301_set_entry_b(l_cmd)
            CALL astt301_set_no_required_b(l_cmd)
            CALL astt301_set_required_b(l_cmd)
            CALL astt301_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stak010
            #add-point:BEFORE FIELD stak010
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stak010
            #add-point:ON CHANGE stak010
                        
            #END add-point
 
         #----<<stak011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak011
            #add-point:BEFORE FIELD stak011
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak011
            
            #add-point:AFTER FIELD stak011
                                   IF NOT cl_null(g_stak_d[l_ac].stak011) THEN
               IF g_stak_d[l_ac].stak011 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stak_d[l_ac].stak011 = g_stak_d_t.stak011
                  NEXT FIELD stak011
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak011
            #add-point:ON CHANGE stak011
                        
            #END add-point
 
         #----<<stak012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak012
            #add-point:BEFORE FIELD stak012
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak012
            
            #add-point:AFTER FIELD stak012
                                     IF NOT cl_null( g_stak_d[l_ac].stak012) THEN
               IF g_stak_d[l_ac].stak012 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stak_d[l_ac].stak012 = g_stak_d_t.stak012
                  NEXT FIELD stak012
               END IF
            END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak012
            #add-point:ON CHANGE stak012
                        
            #END add-point
 
         #----<<stak013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak013
            #add-point:BEFORE FIELD stak013
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak013
            
            #add-point:AFTER FIELD stak013
            #160303-00028#33 mark by geza(S)
#            CALL astt301_set_entry_b(l_cmd)
#            CALL astt301_set_no_required_b(l_cmd)
#            CALL astt301_set_required_b(l_cmd)
#            CALL astt301_set_no_entry_b(l_cmd)
            #160303-00028#33 mark by geza(E) 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak013
            #add-point:ON CHANGE stak013
            #160303-00028#33 mark by geza(S)
            CALL astt301_set_entry_b(l_cmd)
            CALL astt301_set_no_required_b(l_cmd)
            CALL astt301_set_required_b(l_cmd)
            CALL astt301_set_no_entry_b(l_cmd)
            #160303-00028#33 mark by geza(E)                
            #END add-point
 
         #----<<stak014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak014
            #add-point:BEFORE FIELD stak014
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak014
            
            #add-point:AFTER FIELD stak014
                                    IF NOT cl_null(g_stak_d[l_ac].stak014) THEN
               IF g_stak_d[l_ac].stak014 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stak_d[l_ac].stak014 = g_stak_d_t.stak014
                  NEXT FIELD stak014
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak014
            #add-point:ON CHANGE stak014
                        
            #END add-point
 
         #----<<stak015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak015
            #add-point:BEFORE FIELD stak015
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak015
            
            #add-point:AFTER FIELD stak015
                                    IF NOT cl_null(g_stak_d[l_ac].stak015) THEN
               IF g_stak_d[l_ac].stak015 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stak_d[l_ac].stak015 = g_stak_d_t.stak015
                  NEXT FIELD stak015
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak015
            #add-point:ON CHANGE stak015
                        
            #END add-point
 
         #----<<stak016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak016
            #add-point:BEFORE FIELD stak016
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak016
            
            #add-point:AFTER FIELD stak016
                                    CALL astt301_set_entry_b(l_cmd)
             CALL astt301_set_no_required_b(l_cmd)
             CALL astt301_set_required_b(l_cmd)
             CALL astt301_set_no_entry_b(l_cmd)
            IF g_stak_d[l_ac].stak016 = '1' AND g_stal_d.getlength() > 0 THEN
               IF cl_ask_confirm('ast-00018') THEN
                  DELETE FROM stal_t
                   WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno AND
                         stalseq1 = g_stak_d_t.stakseq
                   CALL g_stal_d.clear()
               ELSE
                  LET  g_stak_d[l_ac].stak016 = g_stak_d_t.stak016 
               END IF  
             END IF  
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak016
            #add-point:ON CHANGE stak016
            # add geza 150504-00002#1 (S)  
            IF g_stak_d[l_ac].stak016 = '1' THEN
               CALL cl_set_comp_visible('group7',FALSE)
            ELSE
               CALL cl_set_comp_visible('group7',TRUE)
            END IF  
      
      
         ON CHANGE stak022
            CALL astt301_set_visible(g_detail_idx) 
            #add by yangxf ---start---
            CASE g_stak_d[l_ac].stak022
                 #无
                 WHEN '0'
                        DELETE FROM stay_t 
                         WHERE stayent = g_enterprise
                           AND staydocno = g_staj_m.stajdocno
                           AND stayseq1 = g_stak_d_t.stakseq
                        CALL g_stay1_d.clear()
                        CALL g_stay_d.clear()
                 #门店
                 WHEN '1'
                        DELETE FROM stay_t
                         WHERE stayent = g_enterprise
                           AND staydocno = g_staj_m.stajdocno
                           AND stayseq1 = g_stak_d_t.stakseq
                           AND stay002 = '2'
                        CALL g_stay1_d.clear()
                 #属性
                 WHEN '2'
                        DELETE FROM stay_t 
                         WHERE stayent = g_enterprise
                           AND staydocno = g_staj_m.stajdocno
                           AND stayseq1 = g_stak_d_t.stakseq
                           AND stay002 = '1'
                         CALL g_stay_d.clear()
            END CASE 
            #add by yangxf ----end-----
            # add geza 150504-00002#1 (E)       

         AFTER FIELD stak029   #促销扣率
            IF NOT cl_null(g_stak_d[l_ac].stak029) THEN
               IF g_stak_d[l_ac].stak029 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_stak_d[l_ac].stak029 = g_stak_d_t.stak029               
                  NEXT FIELD stak029
               END IF           
            END IF
         
                 
         
         AFTER FIELD stak030   #促销商品销售占比
            IF NOT cl_null(g_stak_d[l_ac].stak030) THEN
               IF g_stak_d[l_ac].stak030 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_stak_d[l_ac].stak030 = g_stak_d_t.stak030               
                  NEXT FIELD stak030
               END IF    

               CALL cl_set_comp_required('stak029',TRUE)
               
            ELSE
               CALL cl_set_comp_required('stak029',FALSE)
            END IF
            #END add-point
 
         #----<<stak017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak017
            #add-point:BEFORE FIELD stak017
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak017
            
            #add-point:AFTER FIELD stak017
                                     IF NOT cl_null(g_stak_d[l_ac].stak017) THEN
               IF NOT astt301_stak017_018_chk() THEN
                  LET g_stak_d[l_ac].stak017 =g_stak_d_t.stak017
                  NEXT FIELD stak017
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak017
            #add-point:ON CHANGE stak017
                        
            #END add-point
 
         #----<<stak018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak018
            #add-point:BEFORE FIELD stak018
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak018
            
            #add-point:AFTER FIELD stak018
            IF NOT cl_null(g_stak_d[l_ac].stak018) THEN
               IF NOT astt301_stak017_018_chk() THEN
                  LET g_stak_d[l_ac].stak018 =g_stak_d_t.stak018
                  NEXT FIELD stak018
               END IF
#mark by yangxf ---start----
#                #失效日期修改不可以小于astm301里面的下次费用开始日期-1天
#               IF g_staj_m.staj000 = 'U' THEN
#                  IF astt301_chk_astm301_jiesuan(g_stak_d[l_ac].stakseq) THEN
#                      SELECT stao020 INTO l_stao020 FROM stao_t 
#                       WHERE staoent = g_enterprise AND stao001 = g_staj_m.staj001 AND stao002 = g_stak_d[l_ac].stakseq
#                     IF g_stak_d[l_ac].stak018 < l_stao020-1 THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = 'ast-00203'
#                        LET g_errparam.extend = ''
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#                        
#                        LET g_stak_d[l_ac].stak018 = g_stak_d_t.stak018
#                        NEXT FIELD stak018 
#                     END IF
#                  END IF
#               END IF
#mark by yangxf ---end----
            END IF
            
         #add by yangxf ---start----
         AFTER FIELD stak026
            IF NOT cl_null(g_stak_d[l_ac].stak026) THEN
               LET l_str = g_stak_d[l_ac].stak026
               LET l_str = l_str.trim()
               IF l_str.getLength() <> 12 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00359'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_stak_d[l_ac].stak026 = g_stak_d_t.stak026
                  NEXT FIELD stak026 
               END IF 
               FOR i =1 TO l_str.getLength()
                  IF l_str.subString(i,i) NOT MATCHES '[01]' THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00359'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_stak_d[l_ac].stak026 = g_stak_d_t.stak026
                     NEXT FIELD stak026 
                  END IF 
               END FOR 
            END IF
            #add by yangxf ---end----
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak018
            #add-point:ON CHANGE stak018
                        
            #END add-point
 
         #----<<stak019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stak019
            #add-point:BEFORE FIELD stak019
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stak019
            
            #add-point:AFTER FIELD stak019
            IF NOT cl_null(g_stak_d[l_ac].stak019) THEN
               IF NOT astt301_stak019_chk() THEN
                  LET g_stak_d[l_ac].stak019 = g_stak_d_t.stak019
                  NEXT FIELD stak019                
               END IF          
            END IF            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stak019
            #add-point:ON CHANGE stak019
                        
            #END add-point
 
         #----<<stakunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stakunit
            #add-point:BEFORE FIELD stakunit
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stakunit
            
            #add-point:AFTER FIELD stakunit
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stakunit
            #add-point:ON CHANGE stakunit
                        
            #END add-point
 
         #----<<staksite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD staksite
            #add-point:BEFORE FIELD staksite
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD staksite
            
            #add-point:AFTER FIELD staksite
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE staksite
            #add-point:ON CHANGE staksite
                        
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<stakseq>>----
         #Ctrlp:input.c.page1.stakseq
         ON ACTION controlp INFIELD stakseq
            #add-point:ON ACTION controlp INFIELD stakseq
                        
            #END add-point
 
         #----<<stak003>>----
         #Ctrlp:input.c.page1.stak003
         ON ACTION controlp INFIELD stak003
            #add-point:ON ACTION controlp INFIELD stak003
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stak_d[l_ac].stak003             #給予default值
            LET g_qryparam.default2 = "" #g_stak_d[l_ac].stael003 #說明
            LET g_qryparam.default3 = "" #g_stak_d[l_ac].stae001 #費用編號

            #給予arg
            SELECT ooef019 INTO l_ooef019 FROM ooef_t 
             WHERE ooefent = g_enterprise AND ooef001 = g_staj_m.staj013
            LET g_qryparam.where = " (stae009 = 'N' OR stae010 IN (SELECT oodb002 FROM oodb_t WHERE oodbent = '",g_enterprise,"' AND oodb001 = '",l_ooef019,"'))"
                                                               
            CALL q_stae001()                                #呼叫開窗

            LET g_stak_d[l_ac].stak003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_stak_d[l_ac].stael003 = g_qryparam.return2 #說明
            #LET g_stak_d[l_ac].stae001 = g_qryparam.return3 #費用編號

            DISPLAY g_stak_d[l_ac].stak003 TO stak003              #顯示到畫面上
            #DISPLAY g_stak_d[l_ac].stael003 TO stael003 #說明
            #DISPLAY g_stak_d[l_ac].stae001 TO stae001 #費用編號

            NEXT FIELD stak003                          #返回原欄位





         ON ACTION controlp INFIELD stak025
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002
            LET g_qryparam.arg1 = l_ooaa002
            CALL q_rtax001_3() 
            LET g_stak_d[l_ac].stak025 = g_qryparam.return1 
            DISPLAY g_stak_d[l_ac].stak025 TO stak025
            NEXT FIELD stak025
            
         ON ACTION controlp INFIELD stak026
            CALL astt301_getstak026() RETURNING g_stak_d[l_ac].stak026
            DISPLAY g_stak_d[l_ac].stak026 TO stak026
            NEXT FIELD stak026
            #END add-point
 
         #----<<stak004>>----
         #Ctrlp:input.c.page1.stak004
         ON ACTION controlp INFIELD stak004
            #add-point:ON ACTION controlp INFIELD stak004
                        
            #END add-point
 
         #----<<stak005>>----
         #Ctrlp:input.c.page1.stak005
         ON ACTION controlp INFIELD stak005
            #add-point:ON ACTION controlp INFIELD stak005
                        
            #END add-point
 
         #----<<stak006>>----
         #Ctrlp:input.c.page1.stak006
         ON ACTION controlp INFIELD stak006
            #add-point:ON ACTION controlp INFIELD stak006
                        
            #END add-point
 
         #----<<stak007>>----
         #Ctrlp:input.c.page1.stak007
         ON ACTION controlp INFIELD stak007
            #add-point:ON ACTION controlp INFIELD stak007
                        
            #END add-point
 
         #----<<stak008>>----
         #Ctrlp:input.c.page1.stak008
         ON ACTION controlp INFIELD stak008
            #add-point:ON ACTION controlp INFIELD stak008
                        
            #END add-point
 
         #----<<stak009>>----
         #Ctrlp:input.c.page1.stak009
         ON ACTION controlp INFIELD stak009
            #add-point:ON ACTION controlp INFIELD stak009
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stak_d[l_ac].stak009             #給予default值
            LET g_qryparam.default2 = "" #g_stak_d[l_ac].stabl003 #說明
            LET g_qryparam.default3 = "" #g_stak_d[l_ac].stabl004 #助記碼

            #給予arg
            LET g_qryparam.arg1 = g_staj_m.staj002
            LET g_qryparam.arg2 = g_staj_m.staj010
            CALL q_stab001_3()                                #呼叫開窗

            LET g_stak_d[l_ac].stak009 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_stak_d[l_ac].stabl003 = g_qryparam.return2 #說明
            #LET g_stak_d[l_ac].stabl004 = g_qryparam.return3 #助記碼

            DISPLAY g_stak_d[l_ac].stak009 TO stak009              #顯示到畫面上
            #DISPLAY g_stak_d[l_ac].stabl003 TO stabl003 #說明
            #DISPLAY g_stak_d[l_ac].stabl004 TO stabl004 #助記碼
            CALL astt301_stak009_ref()
            NEXT FIELD stak009                          #返回原欄位


            #END add-point
 
         #----<<stak010>>----
         #Ctrlp:input.c.page1.stak010
         ON ACTION controlp INFIELD stak010
            #add-point:ON ACTION controlp INFIELD stak010
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stak_d[l_ac].stak010             #給予default值
            LET g_qryparam.default2 = "" #g_stak_d[l_ac].stabl003 #說明
            LET g_qryparam.default3 = "" #g_stak_d[l_ac].stabl004 #助記碼

            #給予arg
            LET g_qryparam.arg1 = g_staj_m.staj002
            LET g_qryparam.arg2 = g_staj_m.staj010
            CALL q_stab001_3()                                #呼叫開窗

            LET g_stak_d[l_ac].stak010 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_stak_d[l_ac].stabl003 = g_qryparam.return2 #說明
            #LET g_stak_d[l_ac].stabl004 = g_qryparam.return3 #助記碼

            DISPLAY g_stak_d[l_ac].stak010 TO stak010              #顯示到畫面上
            #DISPLAY g_stak_d[l_ac].stabl003 TO stabl003 #說明
            #DISPLAY g_stak_d[l_ac].stabl004 TO stabl004 #助記碼
            CALL astt301_stak010_ref()
            NEXT FIELD stak010                          #返回原欄位


            #END add-point
 
         #----<<stak011>>----
         #Ctrlp:input.c.page1.stak011
         ON ACTION controlp INFIELD stak011
            #add-point:ON ACTION controlp INFIELD stak011
                        
            #END add-point
 
         #----<<stak012>>----
         #Ctrlp:input.c.page1.stak012
         ON ACTION controlp INFIELD stak012
            #add-point:ON ACTION controlp INFIELD stak012
                        
            #END add-point
 
         #----<<stak013>>----
         #Ctrlp:input.c.page1.stak013
         ON ACTION controlp INFIELD stak013
            #add-point:ON ACTION controlp INFIELD stak013
                        
            #END add-point
 
         #----<<stak014>>----
         #Ctrlp:input.c.page1.stak014
         ON ACTION controlp INFIELD stak014
            #add-point:ON ACTION controlp INFIELD stak014
                        
            #END add-point
 
         #----<<stak015>>----
         #Ctrlp:input.c.page1.stak015
         ON ACTION controlp INFIELD stak015
            #add-point:ON ACTION controlp INFIELD stak015
                        
            #END add-point
 
         #----<<stak016>>----
         #Ctrlp:input.c.page1.stak016
         ON ACTION controlp INFIELD stak016
            #add-point:ON ACTION controlp INFIELD stak016
                        
            #END add-point
 
         #----<<stak017>>----
         #Ctrlp:input.c.page1.stak017
         ON ACTION controlp INFIELD stak017
            #add-point:ON ACTION controlp INFIELD stak017
                        
            #END add-point
 
         #----<<stak018>>----
         #Ctrlp:input.c.page1.stak018
         ON ACTION controlp INFIELD stak018
            #add-point:ON ACTION controlp INFIELD stak018
                        
            #END add-point
 
         #----<<stak019>>----
         #Ctrlp:input.c.page1.stak019
         ON ACTION controlp INFIELD stak019
            #add-point:ON ACTION controlp INFIELD stak019
                        
            #END add-point
 
         #----<<stakunit>>----
         #Ctrlp:input.c.page1.stakunit
         ON ACTION controlp INFIELD stakunit
            #add-point:ON ACTION controlp INFIELD stakunit
                        
            #END add-point
 
         #----<<staksite>>----
         #Ctrlp:input.c.page1.staksite
         ON ACTION controlp INFIELD staksite
            #add-point:ON ACTION controlp INFIELD staksite
                        
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_stak_d[l_ac].* = g_stak_d_t.*
               CLOSE astt301_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_stak_d[l_ac].stakseq
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_stak_d[l_ac].* = g_stak_d_t.*
            ELSE
            
               #add-point:單身修改前
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE stak_t SET (stakdocno,stakseq,stakacti,stak003,stak023,stak024,stak025,stak004,stak005,stak006,stak007,stak008,stak027,    #add by geza 20150610 stak023,stak024 #150612-00023#5 add stak027
                   stak009,stak010,stak011,stak012,stak013,stak014,stak015,stak016,stak022,stak017,stak018,stak026,stak019,stak020,stak021,stak028,stak029,stak030, 
                   stakunit,staksite) = (g_staj_m.stajdocno,g_stak_d[l_ac].stakseq,g_stak_d[l_ac].stakacti,g_stak_d[l_ac].stak003,g_stak_d[l_ac].stak023,g_stak_d[l_ac].stak024, #add by geza 20150610 stak023,stak024
                   g_stak_d[l_ac].stak025,g_stak_d[l_ac].stak004,g_stak_d[l_ac].stak005,g_stak_d[l_ac].stak006,g_stak_d[l_ac].stak007, 
                   g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak027,g_stak_d[l_ac].stak009,g_stak_d[l_ac].stak010,g_stak_d[l_ac].stak011, 
                   g_stak_d[l_ac].stak012,g_stak_d[l_ac].stak013,g_stak_d[l_ac].stak014,g_stak_d[l_ac].stak015, 
                   g_stak_d[l_ac].stak016,g_stak_d[l_ac].stak022,g_stak_d[l_ac].stak017,g_stak_d[l_ac].stak018,g_stak_d[l_ac].stak026,g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021,
                   g_stak_d[l_ac].stak028,g_stak_d[l_ac].stak029,g_stak_d[l_ac].stak030,g_stak_d[l_ac].stakunit,g_stak_d[l_ac].staksite)
                WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno 
 
                  AND stakseq = g_stak_d_t.stakseq #項次   
 
                  
               #add-point:單身修改中
                              
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "stak_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_stak_d[l_ac].* = g_stak_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stak_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                     LET g_stak_d[l_ac].* = g_stak_d_t.*                     
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys_bak[1] = g_stajdocno_t
               LET gs_keys[2] = g_stak_d[g_detail_idx].stakseq
               LET gs_keys_bak[2] = g_stak_d_t.stakseq
               CALL astt301_update_b('stak_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後
                              
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row
                                    #  IF NOT astt301_stak017_018_chk() THEN    
            #     NEXT FIELD CURRENT
            #  END IF
            #end add-point
            CALL astt301_unlock_b("stak_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 
                        
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_stak_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_stak_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_stak2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stak2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt301_b_fill()
            LET g_rec_b = g_stak2_d.getLength()
            #add-point:資料輸入前
            LET g_field = 'stam'
            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stak2_d[l_ac].* TO NULL 
                  LET g_stak2_d[l_ac].stam004 = "Y"
 
 
            LET g_stak2_d_t.* = g_stak2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt301_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
                        
            #end add-point
            CALL astt301_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stak2_d[li_reproduce_target].* = g_stak2_d[li_reproduce].*
 
               LET g_stak2_d[li_reproduce_target].stamseq = NULL
            END IF
            #公用欄位給值(單身2)
            
            
            #add-point:modify段before insert
                                    SELECT MAX(stamseq)+1 INTO  g_stak2_d[l_ac].stamseq FROM stam_t
             WHERE stament = g_enterprise AND stamdocno = g_staj_m.stajdocno
            IF cl_null(  g_stak2_d[l_ac].stamseq ) THEN             
               LET   g_stak2_d[l_ac].stamseq = 1
            END IF
           # LET g_stak2_d[l_ac].stamsite = g_staj_m.stajsite
            LET g_stak2_d[l_ac].stamunit = g_staj_m.stajunit
            LET g_stak2_d[l_ac].stam005 = 'N'
            LET g_stak2_d[l_ac].stamacti = "Y"
            LET g_stak2_d_o.* = g_stak2_d[l_ac].*
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
            OPEN astt301_cl USING g_enterprise,g_staj_m.stajdocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astt301_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE astt301_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_stak2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stak2_d[l_ac].stamseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_stak2_d_t.* = g_stak2_d[l_ac].*  #BACKUP
               CALL astt301_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
                              
               #end add-point  
               CALL astt301_set_no_entry_b(l_cmd)
               IF NOT astt301_lock_b("stam_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt301_bcl2 INTO g_stak2_d[l_ac].stamseq,g_stak2_d[l_ac].stam003,g_stak2_d[l_ac].stam003_desc,g_stak2_d[l_ac].stam005,
                      g_stak2_d[l_ac].stam004,g_stak2_d[l_ac].stamunit,g_stak2_d[l_ac].stamsite
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astt301_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            LET g_stak2_d_o.* = g_stak2_d[l_ac].*          
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_stak2_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_stak2_d.deleteElement(l_ac)
               NEXT FIELD stamseq
            END IF
         
            IF g_stak2_d[l_ac].stamseq IS NOT NULL
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
               
               DELETE FROM stam_t
                WHERE stament = g_enterprise AND stamdocno = g_staj_m.stajdocno AND
                      stamseq = g_stak2_d_t.stamseq
                  
               #add-point:單身2刪除中
                              
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stak_t"
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
               CLOSE astt301_bcl
               LET l_count = g_stak_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak2_d[g_detail_idx].stamseq
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
                        
            #end add-point
                           CALL astt301_delete_b('stam_t',gs_keys,"'2'")
 
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
            SELECT COUNT(*) INTO l_count FROM stam_t 
             WHERE stament = g_enterprise AND stamdocno = g_staj_m.stajdocno
               AND stamseq = g_stak2_d[l_ac].stamseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
                              
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak2_d[g_detail_idx].stamseq
               CALL astt301_insert_b('stam_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2
                              
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_stak_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stam_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt301_b_fill()
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
               LET g_stak2_d[l_ac].* = g_stak2_d_t.*
               CLOSE astt301_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_stak2_d[l_ac].* = g_stak2_d_t.*
            ELSE
               #add-point:單身page2修改前
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               UPDATE stam_t SET (stamdocno,stamseq,stam003,stam005,stam004,stamacti,stamunit,stamsite) = (g_staj_m.stajdocno, 
                   g_stak2_d[l_ac].stamseq,g_stak2_d[l_ac].stam003,g_stak2_d[l_ac].stam005,g_stak2_d[l_ac].stam004,g_stak2_d[l_ac].stamacti,g_stak2_d[l_ac].stamunit, 
                   g_stak2_d[l_ac].stamsite) #自訂欄位頁簽
                WHERE stament = g_enterprise AND stamdocno = g_staj_m.stajdocno
                  AND stamseq = g_stak2_d_t.stamseq #項次 
                  
               #add-point:單身page2修改中
                              
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "stam_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_stak2_d[l_ac].* = g_stak2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stam_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_stak2_d[l_ac].* = g_stak2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys_bak[1] = g_stajdocno_t
               LET gs_keys[2] = g_stak2_d[g_detail_idx].stamseq
               LET gs_keys_bak[2] = g_stak2_d_t.stamseq
               CALL astt301_update_b('stam_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page2修改後
                              
               #end add-point
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<stamseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stamseq
            #add-point:BEFORE FIELD stamseq
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stamseq
            
            #add-point:AFTER FIELD stamseq
                                    #此段落由子樣板a05產生
            IF  NOT cl_null(g_staj_m.stajdocno) AND NOT cl_null(g_stak2_d[g_detail_idx].stamseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_staj_m.stajdocno != g_stajdocno_t OR g_stak2_d[g_detail_idx].stamseq != g_stak2_d_t.stamseq))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stam_t WHERE "||"stament = '" ||g_enterprise|| "' AND "||"stamdocno = '"||g_staj_m.stajdocno ||"' AND "|| "stamseq = '"||g_stak2_d[g_detail_idx].stamseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stamseq
            #add-point:ON CHANGE stamseq
                        
            #END add-point
 
         #----<<stam003>>----
         #此段落由子樣板a02產生
         AFTER FIELD stam003
            
            #add-point:AFTER FIELD stam003
                                   LET g_stak2_d[l_ac].stam003_desc = ''
           DISPLAY BY NAME g_stak2_d[l_ac].stam003_desc
           IF NOT cl_null(g_stak2_d[l_ac].stam003) THEN
              IF NOT astt301_stam003_chk(g_stak2_d[l_ac].stam003) THEN
                    LET g_stak2_d[l_ac].stam003 = g_stak2_d_t.stam003
                    CALL astt301_stam003_ref()
                    NEXT FIELD  stam003                
              END IF
                 SELECT COUNT(*) INTO l_n FROM stam_t
                  WHERE stament = g_enterprise AND stamdocno= g_staj_m.stajdocno
                    AND stam003 =g_stak2_d[l_ac].stam003 AND stamseq <> g_stak2_d[l_ac].stamseq
                 IF l_n > 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'ast-00025'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    NEXT FIELD  stam003 
                 END IF
             
           END IF
           CALL astt301_stam003_ref()
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stam003
            #add-point:BEFORE FIELD stam003
                        
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stam003
            #add-point:ON CHANGE stam003
         

                  
         AFTER FIELD stam005
         
         
         ON CHANGE stam005
            IF NOT cl_null(g_stak2_d[l_ac].stam005) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_stak2_d[l_ac].stam005 <> g_stak2_d_t.stam005 ) THEN
               IF g_stak2_d[l_ac].stam005 = 'Y' THEN
                  #整单必须有且仅有一个主品类
                  SELECT COUNT(*) INTO l_n FROM stam_t WHERE stament = g_enterprise AND stamdocno = g_staj_m.stajdocno AND stam005 = 'Y'
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00343'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_stak2_d[l_ac].stam005 = 'N'
                     NEXT FIELD  stam005                          
                  END IF             
               END IF  
               END IF
    
            END IF
            #END add-point
 
         #----<<stam004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stam004
            #add-point:BEFORE FIELD stam004
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stam004
            
            #add-point:AFTER FIELD stam004
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stam004
            #add-point:ON CHANGE stam004
                        
            #END add-point
 
         #----<<stamunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stamunit
            #add-point:BEFORE FIELD stamunit
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stamunit
            
            #add-point:AFTER FIELD stamunit
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stamunit
            #add-point:ON CHANGE stamunit
                        
            #END add-point
 
         #----<<stamsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stamsite
            #add-point:BEFORE FIELD stamsite
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stamsite
            
            #add-point:AFTER FIELD stamsite
                        
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stamsite
            #add-point:ON CHANGE stamsite
                        
            #END add-point
 
 
         #---------------------<  Detail: page2  >---------------------
         #----<<stamseq>>----
         #Ctrlp:input.c.page2.stamseq
         ON ACTION controlp INFIELD stamseq
            #add-point:ON ACTION controlp INFIELD stamseq
                        
            #END add-point
 
         #----<<stam003>>----
         #Ctrlp:input.c.page2.stam003
         ON ACTION controlp INFIELD stam003
            #add-point:ON ACTION controlp INFIELD stam003
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stak2_d[l_ac].stam003             #給予default值

            CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
            #給予arg
            LET g_qryparam.arg1 = l_sys 

            CALL q_rtax001_3()
                       
            IF NOT cl_null(g_qryparam.return1) THEN  
               LET tok = base.StringTokenizer.create(g_qryparam.return1,"|")
               WHILE tok.hasMoreTokens()
                 LET l_str = tok.nextToken()
                 CALL astt301_ins_stam(l_str)  
               END WHILE
              # LET l_stam_flag = 'Y'                
               LET l_flag_1 = 'Y'
               EXIT DIALOG
            ELSE
                  #160604-00009#74--add--str--ZN
                 LET g_stak2_d[l_ac].stam003 = g_qryparam.return1              #將開窗取得的值回傳到變數
                 DISPLAY g_stak2_d[l_ac].stam003 TO stam003              #顯示到畫面上
                 CALL astt301_stam003_ref()
                 NEXT FIELD stam003
                  #160604-00009#74--add--end--ZN                 
            END IF            
                       #返回原欄位
    

            #END add-point
 
         #----<<stam004>>----
         #Ctrlp:input.c.page2.stam004
         ON ACTION controlp INFIELD stam004
            #add-point:ON ACTION controlp INFIELD stam004
                        
            #END add-point
 
         #----<<stamunit>>----
         #Ctrlp:input.c.page2.stamunit
         ON ACTION controlp INFIELD stamunit
            #add-point:ON ACTION controlp INFIELD stamunit
                        
            #END add-point
 
         #----<<stamsite>>----
         #Ctrlp:input.c.page2.stamsite
         ON ACTION controlp INFIELD stamsite
            #add-point:ON ACTION controlp INFIELD stamsite
                        
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
                  LET g_stak2_d[l_ac].* = g_stak2_d_t.*
               END IF
               CLOSE astt301_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL astt301_unlock_b("stam_t","'2'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 
          
            
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_stak2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_stak2_d.getLength()+1
 
      END INPUT
 
 
      
 
      
 
      
 
      
 
{</section>}
 
{<section id="astt301.input.other" >}
      
      #add-point:自定義input
   INPUT ARRAY g_stak3_d FROM s_detail7.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 

                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stak3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt301_b_fill()
            LET g_rec_b = g_stak3_d.getLength()
            #add-point:資料輸入前
            LET g_field = 'stbj'
            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stak3_d[l_ac].* TO NULL 
 
            LET g_stak3_d_t.* = g_stak3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt301_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
                        
            #end add-point
            CALL astt301_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stak3_d[li_reproduce_target].* = g_stak3_d[li_reproduce].*
 
               LET g_stak3_d[li_reproduce_target].stbjseq = NULL
            END IF
            #公用欄位給值(單身2)
            
            
            #add-point:modify段before insert
            SELECT MAX(stbjseq)+1 INTO  g_stak3_d[l_ac].stbjseq FROM stbj_t
             WHERE stbjent = g_enterprise AND stbjdocno = g_staj_m.stajdocno
            IF cl_null(  g_stak3_d[l_ac].stbjseq ) THEN             
               LET   g_stak3_d[l_ac].stbjseq = 1
            END IF
            LET g_stak3_d[l_ac].stbjsite = g_staj_m.stajsite
            LET g_stak3_d[l_ac].stbjunit = g_staj_m.stajunit
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
            OPEN astt301_cl USING g_enterprise,g_staj_m.stajdocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astt301_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE astt301_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_stak3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stak3_d[l_ac].stbjseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_stak3_d_t.* = g_stak3_d[l_ac].*  #BACKUP
               CALL astt301_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
                              
               #end add-point  
               CALL astt301_set_no_entry_b(l_cmd)
               IF NOT astt301_lock_b("stbj_t","'7'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt301_bcl7 INTO g_stak3_d[l_ac].stbjseq,g_stak3_d[l_ac].stbj001,g_stak3_d[l_ac].stbjsite,g_stak3_d[l_ac].stbjunit
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astt301_show()
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
            IF l_cmd = 'a' AND g_stak3_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_stak3_d.deleteElement(l_ac)
               NEXT FIELD stbjseq
            END IF
         
            IF g_stak3_d[l_ac].stbjseq IS NOT NULL
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
               
               DELETE FROM stbj_t
                WHERE stbjent = g_enterprise AND stbjdocno = g_staj_m.stajdocno AND
                      stbjseq = g_stak3_d_t.stbjseq
                  
               #add-point:單身2刪除中
                              
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stbj_t"
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
               CLOSE astt301_bcl
               LET l_count = g_stak3_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak3_d[g_detail_idx].stbjseq
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
                        
            #end add-point
                           CALL astt301_delete_b('stbj_t',gs_keys,"'7'")
 
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
            SELECT COUNT(*) INTO l_count FROM stbj_t 
             WHERE stbjent = g_enterprise AND stbjdocno = g_staj_m.stajdocno
               AND stbjseq = g_stak3_d[l_ac].stbjseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
                              
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak3_d[g_detail_idx].stbjseq
               CALL astt301_insert_b('stbj_t',gs_keys,"'7'")
                           
               #add-point:單身新增後2
                              
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_stak3_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stbj_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt301_b_fill()
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
               LET g_stak3_d[l_ac].* = g_stak3_d_t.*
               CLOSE astt301_bcl7
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_stak3_d[l_ac].* = g_stak3_d_t.*
            ELSE
               #add-point:單身page2修改前
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               UPDATE stbj_t SET (stbjdocno,stbjseq,stbj001,stbjunit,stbjsite) = (g_staj_m.stajdocno, 
                   g_stak3_d[l_ac].stbjseq,g_stak3_d[l_ac].stbj001,g_stak3_d[l_ac].stbjunit, 
                   g_stak3_d[l_ac].stbjsite) #自訂欄位頁簽
                WHERE stbjent = g_enterprise AND stbjdocno = g_staj_m.stajdocno
                  AND stbjseq = g_stak3_d_t.stbjseq #項次 
                  
               #add-point:單身page2修改中
                              
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "stbj_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_stak3_d[l_ac].* = g_stak3_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stbj_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_stak3_d[l_ac].* = g_stak3_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys_bak[1] = g_stajdocno_t
               LET gs_keys[2] = g_stak3_d[g_detail_idx].stbjseq
               LET gs_keys_bak[2] = g_stak3_d_t.stbjseq
               CALL astt301_update_b('stbj_t',gs_keys,gs_keys_bak,"'7'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page2修改後
                              
               #end add-point
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<stamseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stbjseq
            #add-point:BEFORE FIELD stamseq
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stbjseq
            
            #add-point:AFTER FIELD stamseq
                                    #此段落由子樣板a05產生
            IF  NOT cl_null(g_staj_m.stajdocno) AND NOT cl_null(g_stak3_d[g_detail_idx].stbjseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_staj_m.stajdocno != g_stajdocno_t OR g_stak3_d[g_detail_idx].stbjseq != g_stak3_d_t.stbjseq))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stbj_t WHERE "||"stbjent = '" ||g_enterprise|| "' AND "||"stbjdocno = '"||g_staj_m.stajdocno ||"' AND "|| "stbjseq = '"||g_stak3_d[g_detail_idx].stbjseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #DISPLAY BY NAME g_stak3_d[l_ac].stbjseq

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stbjseq
            #add-point:ON CHANGE stamseq
                        
            #END add-point
 
         #----<<stam003>>----
         #此段落由子樣板a02產生
         AFTER FIELD stbj001
            
         ON ACTION controlp INFIELD stbj001

		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stak3_d[l_ac].stbj001

            #給予arg
            LET g_qryparam.arg1 = '2136'
            CALL q_oocq002()                                #呼叫開窗
           
            LET g_stak3_d[l_ac].stbj001 = g_qryparam.return2 #說明
            DISPLAY BY NAME g_stak3_d[l_ac].stbj001
            NEXT FIELD stbj001                          
 
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
                  LET g_stak3_d[l_ac].* = g_stak3_d_t.*
               END IF
               CLOSE astt301_bcl7
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL astt301_unlock_b("stbj_t","'7'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 
                        
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_stak3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_stak3_d.getLength()+1
 
      END INPUT


     INPUT ARRAY g_stak4_d FROM s_detail8.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 

                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stak4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt301_b_fill()
            LET g_rec_b = g_stak4_d.getLength()
            #add-point:資料輸入前
            LET g_field = 'stbn'
            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stak4_d[l_ac].* TO NULL 
 
            LET g_stak4_d_t.* = g_stak4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt301_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
                        
            #end add-point
            CALL astt301_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stak4_d[li_reproduce_target].* = g_stak4_d[li_reproduce].*
 
               LET g_stak4_d[li_reproduce_target].stbnseq = NULL
            END IF
            #公用欄位給值(單身2)
            
            
            #add-point:modify段before insert
            SELECT MAX(stbnseq)+1 INTO  g_stak4_d[l_ac].stbnseq FROM stbn_t
             WHERE stbnent = g_enterprise AND stbndocno = g_staj_m.stajdocno
            IF cl_null( g_stak4_d[l_ac].stbnseq ) THEN             
               LET   g_stak4_d[l_ac].stbnseq = 1
            END IF
            LET g_stak4_d[l_ac].stbnacti = 'Y'
            LET g_stak4_d[l_ac].stbnsite = g_staj_m.stajsite
            LET g_stak4_d[l_ac].stbnunit = g_staj_m.stajunit
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
            OPEN astt301_cl USING g_enterprise,g_staj_m.stajdocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astt301_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE astt301_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_stak4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stak4_d[l_ac].stbnseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_stak4_d_t.* = g_stak4_d[l_ac].*  #BACKUP
               CALL astt301_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
                              
               #end add-point  
               CALL astt301_set_no_entry_b(l_cmd)
               IF NOT astt301_lock_b("stbn_t","'8'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt301_bcl8 INTO g_stak4_d[l_ac].stbnseq,g_stak4_d[l_ac].stbn001,g_stak4_d[l_ac].stbnacti,g_stak4_d[l_ac].stbnsite,g_stak4_d[l_ac].stbnunit
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astt301_show()
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
            IF l_cmd = 'a' AND g_stak4_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_stak4_d.deleteElement(l_ac)
               NEXT FIELD stbnseq
            END IF
         
            IF g_stak4_d[l_ac].stbnseq IS NOT NULL
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
               
               DELETE FROM stbn_t
                WHERE stbnent = g_enterprise AND stbndocno = g_staj_m.stajdocno AND
                      stbnseq = g_stak4_d_t.stbnseq
                  
               #add-point:單身2刪除中
                              
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stbn_t"
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
               CLOSE astt301_bcl
               LET l_count = g_stak4_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak4_d[g_detail_idx].stbnseq
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
                        
            #end add-point
                           CALL astt301_delete_b('stbn_t',gs_keys,"'8'")
 
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
            SELECT COUNT(*) INTO l_count FROM stbn_t 
             WHERE stbnent = g_enterprise AND stbndocno = g_staj_m.stajdocno
               AND stbnseq = g_stak4_d[l_ac].stbnseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
                              
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak4_d[g_detail_idx].stbnseq
               CALL astt301_insert_b('stbn_t',gs_keys,"'8'")
                           
               #add-point:單身新增後2
                              
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_stak4_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stbn_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt301_b_fill()
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
               LET g_stak4_d[l_ac].* = g_stak4_d_t.*
               CLOSE astt301_bcl8
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_stak4_d[l_ac].* = g_stak4_d_t.*
            ELSE
               #add-point:單身page2修改前
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               UPDATE stbn_t SET (stbndocno,stbnseq,stbn001,stbnacti,stbnunit,stbnsite) = (g_staj_m.stajdocno, 
                   g_stak4_d[l_ac].stbnseq,g_stak4_d[l_ac].stbn001,g_stak4_d[l_ac].stbnacti,g_stak4_d[l_ac].stbnunit, 
                   g_stak4_d[l_ac].stbnsite) #自訂欄位頁簽
                WHERE stbnent = g_enterprise AND stbndocno = g_staj_m.stajdocno
                  AND stbnseq = g_stak4_d_t.stbnseq #項次 
                  
               #add-point:單身page2修改中
                              
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "stbn_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_stak4_d[l_ac].* = g_stak4_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stbn_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_stak4_d[l_ac].* = g_stak4_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys_bak[1] = g_stajdocno_t
               LET gs_keys[2] = g_stak4_d[g_detail_idx].stbnseq
               LET gs_keys_bak[2] = g_stak4_d_t.stbnseq
               CALL astt301_update_b('stbn_t',gs_keys,gs_keys_bak,"'8'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page2修改後
                              
               #end add-point
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<stamseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stbnseq
            #add-point:BEFORE FIELD stamseq
                        
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stbnseq
            
            #add-point:AFTER FIELD stamseq
                                    #此段落由子樣板a05產生
            IF  NOT cl_null(g_staj_m.stajdocno) AND NOT cl_null(g_stak4_d[g_detail_idx].stbnseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_staj_m.stajdocno != g_stajdocno_t OR g_stak4_d[g_detail_idx].stbnseq != g_stak4_d_t.stbnseq))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stbn_t WHERE "||"stbnent = '" ||g_enterprise|| "' AND "||"stbndocno = '"||g_staj_m.stajdocno ||"' AND "|| "stbnseq = '"||g_stak4_d[g_detail_idx].stbnseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
          

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stbnseq
            #add-point:ON CHANGE stamseq
                        
            #END add-point
 
         #----<<stam003>>----
         #此段落由子樣板a02產生
         AFTER FIELD stbn001
            IF NOT cl_null(g_stak4_d[l_ac].stbn001) THEN
              #检查门店是否重复
              IF l_cmd = 'a' OR (l_cmd = 'u' AND g_stak4_d[l_ac].stbn001 != g_stak4_d_t.stbn001) THEN 
                 LET l_n = 0
                 SELECT COUNT(*) INTO l_n
                   FROM stbn_t
                  WHERE stbnent = g_enterprise
                    AND stbndocno = g_staj_m.stajdocno
                    AND stbn001 = g_stak4_d[l_ac].stbn001
                 IF l_n > 0 THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = g_stak4_d[l_ac].stbn001
                    LET g_errparam.code   = 'std-00004'
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()
                    LET g_stak4_d[l_ac].stbn001 = g_stak4_d_t.stbn001
                    CALL astt301_stbn001_ref()
                    NEXT FIELD CURRENT
                 END IF 
              END IF 
              IF s_aooi500_setpoint(g_prog,'staj015') THEN
                 CALL s_aooi500_chk(g_prog,'stbn001',g_stak4_d[l_ac].stbn001,g_staj_m.staj015) RETURNING l_success,l_errno
                 IF NOT l_success THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = g_stak4_d[l_ac].stbn001
                    LET g_errparam.code   = l_errno
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()
                 
                    LET g_stak4_d[l_ac].stbn001 = g_stak4_d_t.stbn001
                    CALL astt301_stbn001_ref()
                    NEXT FIELD CURRENT
                 END IF
              ELSE
                 IF NOT astt301_stbn001_chk() THEN
                    LET g_stak4_d[l_ac].stbn001 = g_stak4_d_t.stbn001
                    CALL astt301_stbn001_ref()
                    NEXT FIELD CURRENT                
                 END IF             
              END IF
              DISPLAY BY NAME g_stak4_d[l_ac].stbn001
              CALL astt301_stbn001_ref()             
          END IF
            
            
            
            
         ON ACTION controlp INFIELD stbn001

		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_stak4_d[l_ac].stbn001
            
          #161024-00025#6---mark----begin-----   
          #  IF s_aooi500_setpoint(g_prog,'stbn001') THEN
          #     CALL s_aooi500_q_where(g_prog,'stbn001',g_staj_m.staj015,'i') RETURNING l_where
          #     LET g_qryparam.where = l_where                    
          #  END IF
          #  IF NOT cl_null(g_qryparam.where) THEN 
          #     LET g_qryparam.where = g_qryparam.where," AND ooefstus = 'Y' "
          #  ELSE
          #     LET g_qryparam.where = " ooefstus = 'Y' "
          #  END IF 
          #  
          #  CALL q_ooef001_23() 
          #161024-00025#6---mark----end----- 
          #161024-00025#6---add----begin-----
           IF s_aooi500_setpoint(g_prog,'stbn001') THEN
              CALL s_aooi500_q_where(g_prog,'stbn001',g_staj_m.staj015,'i') RETURNING g_qryparam.where
              CALL q_ooef001_24()
           ELSE
               LET g_qryparam.where = " ooef304 = 'Y'"
                CALL q_ooef001()
           END IF 
          #161024-00025#6---add----end-----          
                    
            LET l_str_wc = g_qryparam.return1 
            CALL  astt301_ins_stbn(l_str_wc)
            CALL astt301_input('u')
            EXIT DIALOG 

            
   
 
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
                  LET g_stak4_d[l_ac].* = g_stak4_d_t.*
               END IF
               CLOSE astt301_bcl8
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL astt301_unlock_b("stbj_t","'8'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 
                        
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_stak4_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_stak4_d.getLength()+1
 
      END INPUT




     INPUT ARRAY g_stal_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b3,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 

         BEFORE INPUT
            IF g_stak_d[l_ac].stak016 = '1' OR cl_null(g_stak_d[l_ac].stak016) THEN
               NEXT FIELD stakseq
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stal_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 
            LET g_field = 'stal'
            CALL astt301_b3_fill()
            LET g_rec_b3 = g_stal_d.getLength()

            
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac3 = ARR_CURR()
            LET g_detail_idx3 = l_ac3
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac3 TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN astt301_cl USING g_enterprise,g_staj_m.staj001

            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astt301_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE astt301_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         
            
            LET g_rec_b3 = g_stal_d.getLength()
            
            IF g_rec_b3 >= l_ac3 
               AND NOT cl_null(g_stal_d[l_ac3].stalseq2) 

            THEN
               LET l_cmd='u'
               LET g_stal_d_t.* = g_stal_d[l_ac3].*  #BACKUP
               CALL astt301_set_entry_b(l_cmd)
               CALL astt301_set_no_entry_b(l_cmd)
               IF NOT astt301_lock_b("stal_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt301_bcl3 INTO g_stal_d[l_ac3].stalseq2,  g_stal_d[l_ac3].stal004,g_stal_d[l_ac3].stal005,g_stal_d[l_ac3].stal006
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_stal_d_t.stalseq2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astt301_show()
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
            INITIALIZE g_stal_d[l_ac3].* TO NULL 
            
            LET g_stal_d_t.* = g_stal_d[l_ac3].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt301_set_entry_b(l_cmd)
            CALL astt301_set_no_entry_b(l_cmd)
            #公用欄位給值(單身)
            
   
            SELECT MAX(stalseq2)+1 INTO  g_stal_d[l_ac3].stalseq2 FROM stal_t
             WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno AND stalseq1 =g_stak_d[l_ac].stakseq 
            IF cl_null(  g_stal_d[l_ac3].stalseq2 ) THEN             
               LET  g_stal_d[l_ac3].stalseq2 = 1
            END IF
            
            SELECT MAX(stal005)+1 INTO  g_stal_d[l_ac3].stal004 FROM stal_t
             WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno AND stalseq1 =g_stak_d[l_ac].stakseq  
            IF cl_null(  g_stal_d[l_ac3].stal004 ) THEN             
               LET  g_stal_d[l_ac3].stalseq2 = 1
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
            SELECT COUNT(*) INTO l_count FROM stal_t 
             WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno

               AND stalseq1 = g_stak_d[l_ac].stakseq AND stalseq2 = g_stal_d[l_ac3].stalseq2

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak_d[l_ac].stakseq
               CALL astt301_insert_b('stal_t',gs_keys,"'3'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_stal_d[l_ac3].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stal_t"
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
            IF NOT cl_null(g_stal_d[l_ac3].stalseq2) 

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
               
               DELETE FROM stal_t
                WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno AND

                      stalseq1 = g_stak_d[l_ac].stakseq AND stalseq2 =  g_stal_d_t.stalseq2

                  
               #add-point:單身刪除中

               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stal_t"
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
               CLOSE astt301_bcl3
               LET l_count = g_stal_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak_d[l_ac].stakseq



         
         AFTER FIELD stal004,stal005
            IF NOT cl_null(g_stal_d[l_ac3].stal004) THEN
               IF g_stal_d[l_ac3].stal004 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stal_d[l_ac3].stal004 = g_stal_d_t.stal004
                  NEXT FIELD stal004
               END IF
            END IF
            IF NOT cl_null(g_stal_d[l_ac3].stal005) THEN
               IF g_stal_d[l_ac3].stal005 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stal_d[l_ac3].stal005 = g_stal_d_t.stal005
                  NEXT FIELD stal005
               END IF
            END IF
            IF NOT cl_null(g_stal_d[l_ac3].stal004) AND NOT cl_null(g_stal_d[l_ac3].stal005) THEN
               IF g_stal_d[l_ac3].stal005 < g_stal_d[l_ac3].stal004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00017'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            
               SELECT COUNT(*) INTO l_n FROM stal_t
                WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno 
                  AND stalseq1 = g_stak_d[l_ac].stakseq
                  AND ((stal004 between g_stal_d[l_ac3].stal004 AND g_stal_d[l_ac3].stal005)
                      OR (stal005 between g_stal_d[l_ac3].stal004 AND g_stal_d[l_ac3].stal005)
                      OR (g_stal_d[l_ac3].stal004  between stal004 AND stal005)
                      OR (g_stal_d[l_ac3].stal005  between stal004 AND stal005))
                  AND stalseq2 <> g_stal_d[l_ac3].stalseq2
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00016'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
             
            END IF
         
     
         
         
         AFTER FIELD stal006
            IF NOT cl_null(g_stal_d[l_ac3].stal006) THEN
               IF g_stal_d[l_ac3].stal006<= 0 THEN
                 INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                 LET g_stal_d[l_ac3].stal006 = g_stal_d_t.stal006
                 NEXT FIELD stal006
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
               LET g_stal_d[l_ac3].* = g_stal_d_t.*
               CLOSE astt301_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_stal_d[l_ac3].stalseq2
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_stal_d[l_ac3].* = g_stal_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE stal_t SET (stalseq2,stal004,stal005,stal006) = (g_stal_d[l_ac3].stalseq2,g_stal_d[l_ac3].stal004,g_stal_d[l_ac3].stal005,g_stal_d[l_ac3].stal006)
                WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno 
                  AND stalseq1 = g_stak_d[l_ac].stakseq #項次   
                  AND stalseq2 = g_stal_d_t.stalseq2
                  
               #add-point:單身修改中

               #end add-point
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stal_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_stal_d[l_ac3].* = g_stal_d_t.*
             
                  
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL astt301_unlock_b("stal_t","'3'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
              
     
                 
      END INPUT 
#160513-00002#3     
#      INPUT ARRAY g_staw_d FROM s_detail4.*
#          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
#                  INSERT ROW = l_allow_insert, 
#                  DELETE ROW = l_allow_delete,
#                  APPEND ROW = l_allow_insert)
# 
#
#         BEFORE INPUT      
#            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
#              CALL FGL_SET_ARR_CURR(g_staw_d.getLength()+1) 
#              LET g_insert = 'N' 
#            END IF 
#            LET g_field = 'staw'
#            LET g_rec_b = g_staw_d.getLength()
#
#            
#         BEFORE ROW
#            LET l_insert = FALSE
#            LET l_cmd = ''
#            LET l_ac = ARR_CURR()
#            LET g_detail_idx = l_ac
#            
#            LET l_lock_sw = 'N'            #DEFAULT
#            LET l_n = ARR_COUNT()
#            DISPLAY l_ac TO FORMONLY.idx
#         
#            CALL s_transaction_begin()
#            OPEN astt301_cl USING g_enterprise,g_staj_m.stajdocno
#
#            IF STATUS THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code =  STATUS
#               LET g_errparam.extend = "OPEN astt301_cl:"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               CLOSE astt301_cl
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
#         
#            
#            LET g_rec_b = g_staw_d.getLength()
#            
#            IF g_rec_b >= l_ac 
#               AND NOT cl_null(g_staw_d[l_ac].stawseq) 
#
#            THEN
#               LET l_cmd='u'
#               LET g_staw_d_t.* = g_staw_d[l_ac].*  #BACKUP
#               LET g_staw_d_o.* = g_staw_d[l_ac].* 
#               CALL astt301_set_entry_b(l_cmd)
#               CALL astt301_set_no_entry_b(l_cmd)
#               IF NOT astt301_lock_b("staw_t","'4'") THEN
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH astt301_bcl4 INTO g_staw_d[l_ac].stawsite,g_staw_d[l_ac].stawunit,g_staw_d[l_ac].stawseq,  g_staw_d[l_ac].staw002,g_staw_d[l_ac].staw003,
#                                          g_staw_d[l_ac].staw004,g_staw_d[l_ac].staw005,g_staw_d[l_ac].staw006,g_staw_d[l_ac].staw007
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = g_staw_d_t.stawseq
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET l_lock_sw = "Y"
#                  END IF
#                  
#                  LET g_bfill = "N"
#                  CALL astt301_show()
#                  LET g_bfill = "Y"
#                  
#                  CALL cl_show_fld_cont()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
#      
#            #其他table資料備份(確定是否更改用)
#             CALL astt301_set_entry_b(l_cmd)
#             CALL astt301_set_no_entry_b(l_cmd)
#            #其他table進行lock
#            
#        
#         BEFORE INSERT
#            
#            LET l_insert = TRUE
#            LET l_n = ARR_COUNT()
#            LET l_cmd = 'a'
#            INITIALIZE g_staw_d[l_ac].* TO NULL 
#            INITIALIZE g_staw_d_t.* TO NULL
#            INITIALIZE g_staw_d_o.* TO NULL  
#            
#            LET g_staw_d[l_ac].stawsite = g_staj_m.stajsite
#            LET g_staw_d[l_ac].stawunit = g_staj_m.stajunit
#            LET g_staw_d[l_ac].staw005 = 'N'
#            LET g_staw_d_t.* = g_staw_d[l_ac].*     #新輸入資料
#            LET g_staw_d_o.* = g_staw_d[l_ac].*   
#            CALL cl_show_fld_cont()
#            CALL astt301_set_entry_b(l_cmd)
#            CALL astt301_set_no_entry_b(l_cmd)
#            #公用欄位給值(單身)
#           
#            CALL astt301_set_entry_b(l_cmd)
#            CALL astt301_set_no_entry_b(l_cmd)
#            CALL cl_set_comp_entry('stawsite,stawunit,stawseq,staw002,staw003,staw004,staw005,staw006,staw007',FALSE) #160513-00002#3
#  
#         AFTER INSERT
#            LET l_insert = FALSE
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 9001
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = FALSE
#               CALL cl_err()
#
#               LET INT_FLAG = 0
#               CANCEL INSERT
#            END IF
#               
#            #add-point:單身新增
#
#            #end add-point
#			   
#            LET l_count = 1  
#            SELECT COUNT(*) INTO l_count FROM staw_t 
#             WHERE stawent = g_enterprise AND stawdocno = g_staj_m.stajdocno
#
#               AND stawseq = g_staw_d[l_ac].stawseq 
#
#                
#            #資料未重複, 插入新增資料
#            IF l_count = 0 THEN 
#               #add-point:單身新增前
#
#               #end add-point
#            
#               INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_staj_m.stajdocno
#               LET gs_keys[2] = g_staw_d[l_ac].stawseq
#               CALL astt301_insert_b('staw_t',gs_keys,"'4'")
#                           
#               #add-point:單身新增後
#
#               #end add-point
#            ELSE    
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = "std-00006"
#               LET g_errparam.extend = 'INSERT'
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               INITIALIZE g_staw_d[l_ac].* TO NULL
#               CALL s_transaction_end('N','0')
#               CANCEL INSERT
#            END IF
# 
#            IF SQLCA.SQLcode  THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "staw_t"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#  
#               CALL s_transaction_end('N','0')                    
#               CANCEL INSERT
#            ELSE
#               #先刷新資料
#              
#               CALL s_transaction_end('Y','0')
#               ERROR 'INSERT O.K'
#               LET g_rec_b = g_rec_b + 1
#            END IF
#              
#         BEFORE DELETE                            #是否取消單身
#            IF NOT cl_null(g_staw_d[l_ac].stawseq) 
#
#               THEN 
#               
#               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
#               END IF
#               IF l_lock_sw = "Y" THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code =  -263
#                  LET g_errparam.extend = ""
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CANCEL DELETE
#               END IF
#               
#               #add-point:單身刪除前
#
#               #end add-point 
#               
#               DELETE FROM staw_t
#                WHERE stawent = g_enterprise AND stawdocno = g_staj_m.stajdocno AND
#
#                      stawseq = g_staw_d_t.stawseq 
#
#                  
#               #add-point:單身刪除中
#
#               #end add-point 
#               
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "staw_t"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
#               ELSE
#                  LET g_rec_b = g_rec_b-1
#                  
#                  #add-point:單身刪除後
#
#                  #end add-point
#                  CALL s_transaction_end('Y','0')
#               END IF 
#               CLOSE astt301_bcl4
#               LET l_count = g_staw_d.getLength()
#            END IF 
#            
#                           INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_staj_m.stajdocno
#               LET gs_keys[2] = g_staw_d[l_ac].stawseq
#
#
#
#         
#         
#         AFTER FIELD staw003
#           IF NOT cl_null(g_staw_d[l_ac].staw003) THEN
#              #150427-00012#7 150528 add by beckxie
#              #IF l_cmd = 'a' OR (l_cmd = 'u' AND g_staw_d[l_ac].staw003 <> g_staw_d_o.staw003 ) THEN
#              #IF g_staw_d[l_ac].staw003 <> g_staw_d_o.staw003 THEN   #150427-00012#7 20160104 mark by beckxie
#              IF g_staw_d[l_ac].staw003 <> g_staw_d_o.staw003 OR cl_null(g_staw_d_o.staw003) THEN   #150427-00012#7 20160104 add by beckxie
#                 LET g_staw_d[l_ac].staw004 = g_staw_d[l_ac].staw003
#              END IF             
#           END IF
#           LET g_staw_d_o.staw003 = g_staw_d[l_ac].staw003
#     
#         ON ROW CHANGE
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 9001
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = FALSE
#               CALL cl_err()
#
#               LET INT_FLAG = 0
#               LET g_staw_d[l_ac].* = g_staw_d_t.*
#               CLOSE astt301_bcl4
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
#              
#            IF l_lock_sw = 'Y' THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = -263
#               LET g_errparam.extend = g_staw_d[l_ac].stawseq
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               LET g_staw_d[l_ac].* = g_staw_d_t.*
#            ELSE
#            
#               #add-point:單身修改前
#
#               #end add-point
#               
#               #寫入修改者/修改日期資訊(單身)
#               
#      
#               UPDATE staw_t SET (stawseq,staw002,staw003,staw004) = (g_staw_d[l_ac].stawseq,g_staw_d[l_ac].staw002,g_staw_d[l_ac].staw003,g_staw_d[l_ac].staw004)
#                WHERE stawent = g_enterprise AND stawdocno = g_staj_m.stajdocno   
#                  AND stawseq = g_staw_d_t.stawseq
#                  
#               #add-point:單身修改中
#
#               #end add-point
#               
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "staw_t"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#   
#                  LET g_staw_d[l_ac].* = g_staw_d_t.*
#             
#                  
#               END IF
#               
#               #add-point:單身修改後
#
#               #end add-point
# 
#            END IF
#            
#         AFTER ROW
#            CALL astt301_unlock_b("staw_t","'4'")
#            CALL s_transaction_end('Y','0')
#            #其他table進行unlock
#            
#              
#         AFTER INPUT
#            #add-point:input段after input 
#
#            #end add-point   
#              
#     
#                 
#      END INPUT 
      
      
      ##########################150512-00006#2
      INPUT ARRAY g_stay_d FROM s_detail5.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 

         BEFORE INPUT      
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stay_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 
            LET g_field = 'stay'
            LET g_rec_b = g_stay_d.getLength()

            
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN astt301_cl USING g_enterprise,g_staj_m.stajdocno
            OPEN astt301_bcl USING g_enterprise,g_staj_m.stajdocno,g_stak_d[g_detail_idx].stakseq
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astt301_cl5:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CLOSE astt301_cl
               CLOSE astt301_bcl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         
            
            LET g_rec_b = g_stay_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_stay_d[l_ac].stayseq2) 

            THEN
               LET l_cmd='u'
               LET g_stay_d_t.* = g_stay_d[l_ac].*  #BACKUP
               CALL astt301_set_entry_b(l_cmd)
               CALL astt301_set_no_entry_b(l_cmd)
               IF NOT astt301_lock_b("stay_t","'5'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt301_bcl5 INTO g_stay_d[l_ac].stayseq2,g_stay_d[l_ac].stay001,g_stay_d[l_ac].stay002,g_stay_d[l_ac].stay004,g_stay_d[l_ac].stay004_desc
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_stay_d_t.stayseq2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astt301_show()
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
            INITIALIZE g_stay_d[l_ac].* TO NULL 
            
            LET g_stay_d_t.* = g_stay_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt301_set_entry_b(l_cmd)
            CALL astt301_set_no_entry_b(l_cmd)
            #公用欄位給值(單身)
            LET g_stay_d[l_ac].stay001 = g_staj_m.staj001
            LET g_stay_d[l_ac].stay002 = '1'
            SELECT NVL(MAX(stayseq2)+1,1) INTO g_stay_d[l_ac].stayseq2 FROM stay_t
             WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno AND stayseq1 = g_stak_d[g_detail_idx].stakseq
            LET l_ins='N'
     
  
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
            IF l_ins = 'Y' THEN
               CONTINUE DIALOG
            END IF
            #end add-point
			   
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM stay_t 
             WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno
               AND stayseq1 = g_stak_d[g_detail_idx].stakseq
               AND stayseq2 = g_stay_d[l_ac].stayseq2 

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] =  g_stak_d[g_detail_idx].stakseq
               LET gs_keys[3] = g_stay_d[l_ac].stayseq2 
               CALL astt301_insert_b('stay_t',gs_keys,"'5'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_stay_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stay_t"
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
            IF NOT cl_null(g_stay_d[l_ac].stayseq2) 

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
               
               DELETE FROM stay_t
                WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno
                  AND stayseq1 = g_stak_d[g_detail_idx].stakseq         
                  AND stayseq2 = g_stay_d_t.stayseq2 

                  
               #add-point:單身刪除中

               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stay_t"
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
               CLOSE astt301_bcl5
               LET l_count = g_stay_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak_d[g_detail_idx].stakseq 
               LET gs_keys[3] = g_stay_d[l_ac].stayseq2


         
        AFTER FIELD stay004
          IF NOT cl_null(g_stay_d[l_ac].stay004) THEN
              
              IF s_aooi500_setpoint(g_prog,'staj015') THEN
                 CALL s_aooi500_chk(g_prog,'stay004',g_stay_d[l_ac].stay004,g_staj_m.staj016) RETURNING l_success,l_errno
                 IF NOT l_success THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = g_stay_d[l_ac].stay004
                    LET g_errparam.code   = l_errno
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()
                 
                    LET g_stay_d[l_ac].stay004 = g_stay_d_t.stay004
                    CALL astt301_stay004_ref()
                    NEXT FIELD CURRENT
                 END IF
              ELSE
                 IF NOT astt301_stay004_chk() THEN
                    LET g_stay_d[l_ac].stay004 = g_stay_d_t.stay004
                    CALL astt301_stay004_ref()
                    NEXT FIELD CURRENT                
                 END IF             
              END IF
              DISPLAY BY NAME g_stay_d[l_ac].stay004
              CALL astt301_stay004_ref()             
          END IF
        
        ON ACTION controlp INFIELD stay004
            #add-point:ON ACTION controlp INFIELD steaunit
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
           # INITIALIZE g_qryparam.* TO NULL
           # LET g_qryparam.state = 'i'
           # LET g_qryparam.reqry = FALSE
           #
           # LET g_qryparam.default1 = g_stay_d[l_ac].stay004            #給予default值
           #
           # #給予arg
           # LET g_qryparam.arg1 = "" #s
           # 
           # IF s_aooi500_setpoint(g_prog,'stay004') THEN
           #    CALL s_aooi500_q_where(g_prog,'stay004',g_staj_m.staj016,'i') RETURNING l_where
           #    LET g_qryparam.where = l_where                    
           # END IF
           # CALL q_ooef001_18()                                #呼叫開窗
           #  
           # LET g_stay_d[l_ac].stay004 = g_qryparam.return1                    #
           # DISPLAY BY NAME g_stay_d[l_ac].stay004
           # CALL astt301_stay004_ref()
           # NEXT FIELD stay004     
           
             INITIALIZE g_qryparam.* TO NULL           
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             IF s_aooi500_setpoint(g_prog,'stay004') THEN
                CALL s_aooi500_q_where(g_prog,'stay004',g_staj_m.staj015,'i') RETURNING l_where
                LET g_qryparam.where = l_where 
                CALL q_ooef001_24()  #161024-00025#6--add 
             ELSE
                LET g_qryparam.where = " ooef304 = 'Y'"    #161024-00025#6--add    
                CALL q_ooef001()                           #161024-00025#6--add                  
             END IF
            # CALL q_ooef001_23()  #161024-00025#6--mark
                        
             DISPLAY g_qryparam.return1 TO stay004 
             CALL astt301_stay004_ins(l_cmd,g_qryparam.return1)
             CALL astt301_b_fill2('2')
            IF l_cmd = 'a' THEN
               LET l_ins = 'Y'
            END IF
             

     
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_stay_d[l_ac].* = g_stay_d_t.*
               CLOSE astt301_bcl5
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_stay_d[l_ac].stayseq2
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_stay_d[l_ac].* = g_stay_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE stay_t SET (stayseq2,stay001,stay002,stay004) = (g_stay_d[l_ac].stayseq2,g_stay_d[l_ac].stay001,g_stay_d[l_ac].stay002,g_stay_d[l_ac].stay004)
                WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno   
                  AND stayseq1 = g_stak_d[g_detail_idx].stakseq AND stayseq2 = g_stay_d_t.stayseq2
                  
               #add-point:單身修改中

               #end add-point
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stay_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_stay_d[l_ac].* = g_stay_d_t.*
             
                  
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL astt301_unlock_b("stay_t","'5'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
              
     
                 
      END INPUT 
      
      
        INPUT ARRAY g_stay1_d FROM s_detail6.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 

         BEFORE INPUT      
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stay1_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 
            LET g_field = 'stay'
            LET g_rec_b = g_stay1_d.getLength()

            
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN astt301_cl USING g_enterprise,g_staj_m.stajdocno
            OPEN astt301_bcl USING g_enterprise,g_staj_m.stajdocno,g_stak_d[g_detail_idx].stakseq
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN astt301_cl6:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CLOSE astt301_cl
               CLOSE astt301_bcl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         
            
            LET g_rec_b = g_stay1_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_stay1_d[l_ac].stayseq2) 

            THEN
               LET l_cmd='u'
               LET g_stay1_d_t.* = g_stay1_d[l_ac].*  #BACKUP
               CALL astt301_set_entry_b(l_cmd)
               CALL astt301_set_no_entry_b(l_cmd)
               IF NOT astt301_lock_b("stay_t_1","'6'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt301_bcl6 INTO g_stay1_d[l_ac].stayseq2,g_stay1_d[l_ac].stay001,g_stay1_d[l_ac].stay002,g_stay1_d[l_ac].stay005,g_stay1_d[l_ac].stay003,g_stay1_d[l_ac].stay004,g_stay1_d[l_ac].stay004_desc
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_stay1_d_t.stayseq2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL astt301_show()
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
            INITIALIZE g_stay1_d[l_ac].* TO NULL 
            LET g_stay1_d[l_ac].stay005 = '1'     #add by yangxf
            LET g_stay1_d_t.* = g_stay1_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt301_set_entry_b(l_cmd)
            CALL astt301_set_no_entry_b(l_cmd)
            #公用欄位給值(單身)
            SELECT NVL(MAX(stayseq2)+1,1) INTO g_stay1_d[l_ac].stayseq2 FROM stay_t
             WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno AND stayseq1 = g_stak_d[g_detail_idx].stakseq
            LET g_stay1_d[l_ac].stay001 = g_staj_m.staj001
            LET g_stay1_d[l_ac].stay002 = '2'
            LET g_stay1_d[l_ac].stay003 = '4'
            LET l_ins='N'
       
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
            IF l_ins = 'Y' THEN
               CONTINUE DIALOG
            END IF
            #end add-point
			   
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM stay_t 
             WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno
               AND stayseq1 = g_stak_d[g_detail_idx].stakseq
               AND stayseq2 = g_stay1_d[l_ac].stayseq2 

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] =  g_stak_d[g_detail_idx].stakseq
               LET gs_keys[3] = g_stay1_d[l_ac].stayseq2 
               CALL astt301_insert_b('stay_t',gs_keys,"'6'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_stay1_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stay_t"
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
            IF NOT cl_null(g_stay1_d[l_ac].stayseq2) 

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
               
               DELETE FROM stay_t
                WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno
                  AND stayseq1 = g_stak_d[g_detail_idx].stakseq         
                  AND stayseq2 = g_stay1_d_t.stayseq2 

                  
               #add-point:單身刪除中

               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stay_t"
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
               CLOSE astt301_bcl6
               LET l_count = g_stay1_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_staj_m.stajdocno
               LET gs_keys[2] = g_stak_d[g_detail_idx].stakseq 
               LET gs_keys[3] = g_stay1_d[l_ac].stayseq2


        ON CHANGE stay003
           IF NOT cl_null(g_stay1_d[l_ac].stay003) THEN    
              #卡、款别、其它条件两两不可共存
              IF NOT astt301_stay003_chk() THEN
                 LET g_stay1_d[l_ac].stay003 = g_stay1_d_t.stay003
                 NEXT FIELD stay003
              END IF
              LET g_stay1_d_t.stay003 = g_stay1_d[l_ac].stay003
              LET g_stay1_d[l_ac].stay004 = ''
              LET g_stay1_d[l_ac].stay004_desc = ''
              NEXT FIELD stay004_1
           END IF
        
        AFTER FIELD stay003
           IF NOT cl_null(g_stay1_d[l_ac].stay003) THEN    
              #卡、款别、其它条件两两不可共存
              IF NOT astt301_stay003_chk() THEN
                 LET g_stay1_d[l_ac].stay003 = g_stay1_d_t.stay003
                 NEXT FIELD stay003
              END IF          
           END IF
           LET g_stay1_d_t.stay003 = g_stay1_d[l_ac].stay003
        
        AFTER FIELD stay004_1
          IF NOT cl_null(g_stay1_d[l_ac].stay004) THEN
             CALL s_aint800_01_check(g_stay1_d[l_ac].stay003,g_stay1_d[l_ac].stay004,'','','') RETURNING l_success,g_stay1_d[l_ac].stay004_desc 
             IF NOT l_success THEN
                LET g_stay1_d[l_ac].stay004 = g_stay1_d_t.stay004
                DISPLAY g_stay1_d[l_ac].stay004 TO stay004_1
                CALL s_aint800_01_show(g_stay1_d[l_ac].stay003,g_stay1_d[l_ac].stay004,'','','') RETURNING l_success,g_stay1_d[l_ac].stay004_desc 
                NEXT FIELD CURRENT           
             END IF
         END IF
         DISPLAY g_stay1_d[l_ac].stay004 TO stay004_1
         CALL s_aint800_01_show(g_stay1_d[l_ac].stay003,g_stay1_d[l_ac].stay004,'','','') RETURNING l_success,g_stay1_d[l_ac].stay004_desc 
        


        ON ACTION controlp INFIELD stay004_1
            #add-point:ON ACTION controlp INFIELD steaunit
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
           #INITIALIZE g_qryparam.* TO NULL
           #LET g_qryparam.state = 'i'
           #LET g_qryparam.reqry = FALSE
           #
           #LET g_qryparam.default1 = g_stay1_d[l_ac].stay004            #給予default值
           #
           ##給予arg
           #LET g_qryparam.arg1 = "" #s
           #CALL s_aint800_01_controlp(g_stay1_d[l_ac].stay003,'','') RETURNING l_success           
           # 
           #LET g_stay1_d[l_ac].stay004 = g_qryparam.return1                    #
           #DISPLAY g_stay1_d[l_ac].stay004 TO stay004_1
           #CALL s_aint800_01_show(g_stay1_d[l_ac].stay003,g_stay1_d[l_ac].stay004,'','','') RETURNING l_success,g_stay1_d[l_ac].stay004_desc 
           #NEXT FIELD stay004_1    
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
           CALL s_aint800_01_controlp(g_stay1_d[l_ac].stay003,'','') RETURNING l_success
           DISPLAY g_qryparam.return1 TO stay004_1 
           CALL astt301_stay004_ins_1(l_cmd,g_qryparam.return1)
           CALL astt301_b_fill2('3')
           IF l_cmd = 'a' THEN
              LET l_ins = 'Y'
           END IF
     
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_stay1_d[l_ac].* = g_stay1_d_t.*
               CLOSE astt301_bcl6
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_stay1_d[l_ac].stayseq2
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_stay1_d[l_ac].* = g_stay1_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE stay_t SET (stayseq2,stay001,stay002,stay005,stay003,stay004) = (g_stay1_d[l_ac].stayseq2,g_stay1_d[l_ac].stay001,g_stay1_d[l_ac].stay002,g_stay1_d[l_ac].stay005,g_stay1_d[l_ac].stay003,g_stay1_d[l_ac].stay004)
                WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno   
                  AND stayseq1 = g_stak_d[g_detail_idx].stakseq AND stayseq2 = g_stay1_d_t.stayseq2
                  
               #add-point:單身修改中

               #end add-point
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stay_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_stay1_d[l_ac].* = g_stay1_d_t.*
             
                  
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL astt301_unlock_b("stay_t","'6'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
              
     
                 
      END INPUT 
      ############################150512-00006#2
      DISPLAY ARRAY g_stbw_d TO s_detail9.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL astt301_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail9")
            LET g_detail_idx = l_ac
            
            
         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = DIALOG.getCurrentRow("s_detail9")
            LET g_current_page = 9
            CALL astt301_idx_chk()
      
      END DISPLAY
      #end add-point
      
      BEFORE DIALOG 
         #add-point:input段before dialog
                  
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD stajsite #sakura add
            NEXT FIELD stajdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD stakseq
               WHEN "s_detail2"
                  NEXT FIELD stamseq
 
 
            END CASE
         END IF
    
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")
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
    IF l_flag_1 = 'Y' THEN
      CONTINUE WHILE
    else
      IF NOT s_astt301_period('1',g_staj_m.stajdocno,g_staj_m.staj001,g_staj_m.staj039) THEN
        RETURN
      end if
       EXIT WHILE      
   END IF
  END WHILE 
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="astt301.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION astt301_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num5
   {</Local define>}
   #add-point:show段define
   DEFINE l_success LIKE type_t.num5
   #end add-point  
 
   #add-point:show段之前
   LET g_staj_m_o.* = g_staj_m.*
   #end add-point
   
   
   
   LET g_staj_m_t.* = g_staj_m.*      #保存單頭舊值
   
   IF g_bfill = "Y" THEN
      CALL astt301_b_fill() #單身填充
      CALL astt301_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_staj_m.stajownid_desc = cl_get_username(g_staj_m.stajownid)
      #LET g_staj_m.stajowndp_desc = cl_get_deptname(g_staj_m.stajowndp)
      #LET g_staj_m.stajcrtid_desc = cl_get_username(g_staj_m.stajcrtid)
      #LET g_staj_m.stajcrtdp_desc = cl_get_deptname(g_staj_m.stajcrtdp)
      #LET g_staj_m.stajmodid_desc = cl_get_username(g_staj_m.stajmodid)
      #LET g_staj_m.stajcnfid_desc = cl_get_deptname(g_staj_m.stajcnfid)
      ##LET g_staj_m.stajpstid_desc = cl_get_deptname(g_staj_m.stajpstid)
      
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
            CALL astt301_staj005_ref()
      CALL astt301_staj004_ref()
      CALL astt301_staj006_ref()
      CALL astt301_staj007_ref()
      CALL astt301_staj008_ref()
      #150506-00007#3 150522 by sakura add---STR
      #交易條件
      CALL s_desc_get_acc_desc('238',g_staj_m.staj024) RETURNING g_staj_m.staj024_desc
      DISPLAY BY NAME g_staj_m.staj024_desc
      #發票類型
      CALL s_desc_get_invoice_type_desc1(g_site,g_staj_m.staj025) RETURNING g_staj_m.staj025_desc
      DISPLAY BY NAME g_staj_m.staj025_desc
      #150506-00007#3 150522 by sakura add---END
      CALL astt301_staj009_ref()
      CALL astt301_staj010_ref()
      CALL astt301_staj015_ref()
      CALL astt301_staj016_ref()
      CALL astt301_staj013_ref()
      CALL astt301_staj014_ref()     
      CALL astt301_stajsite_ref()
      IF g_staj_m.staj000 = 'I' THEN
         LET g_staj_m.stanstus = 'N'
      ELSE
         SELECT stanstus INTO g_staj_m.stanstus FROM stan_t WHERE stanent = g_enterprise AND stan001 = g_staj_m.staj001
      END IF
      DISPLAY BY NAME  g_staj_m.stanstus 
      
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_staj_m.stajownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_staj_m.stajownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_staj_m.stajownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_staj_m.stajowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_staj_m.stajowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_staj_m.stajowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_staj_m.stajcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_staj_m.stajcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_staj_m.stajcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_staj_m.stajcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_staj_m.stajcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_staj_m.stajcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_staj_m.stajmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_staj_m.stajmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_staj_m.stajmodid_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_staj_m.stajcnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_staj_m.stajcnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_staj_m.stajcnfid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_staj_m.staj041
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_staj_m.staj041_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_staj_m.staj041_desc
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_staj_m.stajsite,g_staj_m.stajdocdt,g_staj_m.stajdocno,g_staj_m.staj000,g_staj_m.staj039,g_staj_m.staj001,g_staj_m.staj003,
              g_staj_m.staj004,g_staj_m.staj002,g_staj_m.staj031,g_staj_m.staj021,g_staj_m.staj005,g_staj_m.staj016,
              g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj012,g_staj_m.staj014,g_staj_m.staj041,g_staj_m.staj013,
              g_staj_m.staj036,g_staj_m.staj037,g_staj_m.staj038,g_staj_m.staj015,g_staj_m.staj009,g_staj_m.staj010,
              g_staj_m.staj034,g_staj_m.staj042,g_staj_m.staj033,g_staj_m.staj035,g_staj_m.staj019,g_staj_m.staj020,g_staj_m.staj029,
              g_staj_m.staj030,g_staj_m.staj008,g_staj_m.staj024,g_staj_m.staj006,g_staj_m.staj007,g_staj_m.staj025,
              g_staj_m.staj040,g_staj_m.staj026,g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj011,
              g_staj_m.stajstus,g_staj_m.stajunit,g_staj_m.stajownid,g_staj_m.stajownid_desc,g_staj_m.stajowndp, 
              g_staj_m.stajowndp_desc,g_staj_m.stajcrtid,g_staj_m.stajcrtid_desc,g_staj_m.stajcrtdp,g_staj_m.stajcrtdp_desc, 
              g_staj_m.stajcrtdt,g_staj_m.stajmodid,g_staj_m.stajmodid_desc,g_staj_m.stajmoddt,g_staj_m.stajcnfid, 
              g_staj_m.stajcnfid_desc,g_staj_m.stajcnfdt
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_staj_m.stajstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange","stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange","stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange","stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange","stus/32/signing.png")
         
      END CASE
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_stak_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
                    INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_stak_d[l_ac].stak003
        CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_stak_d[l_ac].stak003_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_stak_d[l_ac].stak003_desc
         
         CALL astt301_stak009_ref()
         CALL astt301_stak010_ref()
         CALL astt301_stak025_ref()
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_stak2_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
                  CALL astt301_stam003_ref()
      #end add-point
   END FOR
 
 
   
    
   
   #add-point:show段other
   ###############150512-00006#2
   FOR l_ac = 1 TO g_stay_d.getLength()
       CALL astt301_stay004_ref()
   END FOR
   
   FOR l_ac = 1 TO g_stay1_d.getLength()
       CALL s_aint800_01_show(g_stay1_d[l_ac].stay003,g_stay1_d[l_ac].stay004,'','','') RETURNING l_success,g_stay1_d[l_ac].stay004_desc 
   END FOR
   
   ############### 
   FOR l_ac = 1 TO g_stak4_d.getLength()
       CALL astt301_stbn001_ref()   
   END FOR
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL astt301_detail_show()
   
   #add-point:show段之後
  ## add geza 20150610(S) 
  #CALL astt301_set_visible(1)   
  #IF g_stak_d[1].stak016 = '1' THEN
  #   CALL cl_set_comp_visible('group7',FALSE)
  #ELSE
  #   CALL cl_set_comp_visible('group7',TRUE)
  #END IF 
  ## add geza 20150610(E)   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.detail_show" >}
#+ 單身reference detail_show
PRIVATE FUNCTION astt301_detail_show()
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
 
{<section id="astt301.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION astt301_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE staj_t.stajdocno 
   DEFINE l_oldno     LIKE staj_t.stajdocno 
 
   DEFINE l_master    RECORD LIKE staj_t.*
   DEFINE l_detail    RECORD LIKE stak_t.*
   DEFINE l_detail2    RECORD LIKE stam_t.*
 
 
 
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5  #ken 需求單號：141208-00001 項次：18 
   #end add-point   
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   IF g_staj_m.stajdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
    
   LET g_stajdocno_t = g_staj_m.stajdocno
 
    
   LET g_staj_m.stajdocno = ""
 
    
   CALL astt301_set_entry('a')
   CALL astt301_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      LET g_staj_m.stajownid = g_user
      LET g_staj_m.stajowndp = g_dept
      LET g_staj_m.stajcrtid = g_user
      LET g_staj_m.stajcrtdp = g_dept 
      LET g_staj_m.stajcrtdt = cl_get_current()
      LET g_staj_m.stajmodid = ""
      LET g_staj_m.stajmoddt = ""
      #LET g_staj_m.stajstus = ""
 
 
   
   #add-point:複製輸入前
   #ken-------------------------s 需求單號：141208-00001 項次：18
   CALL s_aooi500_default(g_prog,'stajsite',g_staj_m.stajsite)
      RETURNING l_insert,g_staj_m.stajsite
   IF l_insert = FALSE THEN
      RETURN
   END IF
   #ken-------------------------e
   
   #dongsz--add--str---
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_staj_m.stajsite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_staj_m.stajdocno = r_doctype
   #dongsz--add--end---
   #end add-point
   
   CALL astt301_input("r")
   
   
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
 
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " stajdocno = '", g_staj_m.stajdocno CLIPPED, "' "
 
              , ") "
   
   #add-point:完成複製段落後
      
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION astt301_detail_reproduce()
   {<Local define>}
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE stak_t.*
   DEFINE l_detail2    RECORD LIKE stam_t.*
 
 
 
   {</Local define>}
   #add-point:delete段define
      
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE astt301_detail
   
   #add-point:單身複製前1
      
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE astt301_detail AS ",
                "SELECT * FROM stak_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO astt301_detail SELECT * FROM stak_t 
                                         WHERE stakent = g_enterprise AND stakdocno = g_stajdocno_t
 
   
   #將key修正為調整後   
   UPDATE astt301_detail 
      #更新key欄位
      SET stakdocno = g_staj_m.stajdocno
 
      #更新共用欄位
      
                                       
  
   #將資料塞回原table   
   INSERT INTO stak_t SELECT * FROM astt301_detail
   
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
   DROP TABLE astt301_detail
   
   #add-point:單身複製後1
      
   #end add-point
 
   #add-point:單身複製前
      
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE astt301_detail AS ",
      "SELECT * FROM stam_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO astt301_detail SELECT * FROM stam_t
                                         WHERE stament = g_enterprise AND stamdocno = g_stajdocno_t
 
 
   #將key修正為調整後   
   UPDATE astt301_detail SET stamdocno = g_staj_m.stajdocno
 
  
   #將資料塞回原table   
   INSERT INTO stam_t SELECT * FROM astt301_detail
   
   #add-point:單身複製中
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE astt301_detail
   
   #add-point:單身複製後
      
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_stajdocno_t = g_staj_m.stajdocno
 
   
   DROP TABLE astt301_detail
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.delete" >}
#+ 資料刪除
PRIVATE FUNCTION astt301_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
      
   #end add-point     
   
   IF g_staj_m.stajdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
    SELECT UNIQUE staj000,stajdocno,stajdocdt,staj002,staj001,staj003,staj021,staj004,staj005,staj006, 
        staj007,staj008,
        staj024,staj025,staj026,staj027,staj028,staj029,staj030, #150506-00007#3 150522 by sakura add
        staj031,staj033,staj034,
        staj009,staj010,staj015,staj016,staj011,staj012,staj013,staj014,staj017, 
        staj018,staj019,staj020,stajsite,stajunit,stajstus,stajownid,stajowndp,stajcrtid,stajcrtdp,stajcrtdt, 
        stajmodid,stajmoddt,stajcnfid,stajcnfdt
 INTO g_staj_m.staj000,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_staj_m.staj002,g_staj_m.staj001,g_staj_m.staj003, 
     g_staj_m.staj021,g_staj_m.staj004,g_staj_m.staj005,g_staj_m.staj006,g_staj_m.staj007,g_staj_m.staj008, 
     g_staj_m.staj024,g_staj_m.staj025,g_staj_m.staj026,g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj029,g_staj_m.staj030, #150506-00007#3 150522 by sakura add
     g_staj_m.staj031,g_staj_m.staj033,g_staj_m.staj034,
     g_staj_m.staj009,g_staj_m.staj010,g_staj_m.staj015,g_staj_m.staj016,g_staj_m.staj011,
     g_staj_m.staj012,g_staj_m.staj013,g_staj_m.staj014,g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj019, 
     g_staj_m.staj020,g_staj_m.stajsite,g_staj_m.stajunit,g_staj_m.stajstus,g_staj_m.stajownid,g_staj_m.stajowndp, 
     g_staj_m.stajcrtid,g_staj_m.stajcrtdp,g_staj_m.stajcrtdt,g_staj_m.stajmodid,g_staj_m.stajmoddt, 
     g_staj_m.stajcnfid,g_staj_m.stajcnfdt
 FROM staj_t
 WHERE stajent = g_enterprise AND stajdocno = g_staj_m.stajdocno
   
   
 
   CALL astt301_show()
   
   CALL s_transaction_begin()
 
   OPEN astt301_cl USING g_enterprise,g_staj_m.stajdocno
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN astt301_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE astt301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   FETCH astt301_cl INTO g_staj_m.staj000,g_staj_m.staj039,g_staj_m.stajdocno,g_staj_m.stajdocdt,g_staj_m.staj002,g_staj_m.staj001, 
       g_staj_m.staj003,g_staj_m.staj021,g_staj_m.stanstus,g_staj_m.staj004,g_staj_m.staj004_desc,g_staj_m.staj005, 
       g_staj_m.staj005_desc,g_staj_m.staj006,g_staj_m.staj006_desc,g_staj_m.staj007,g_staj_m.staj007_desc, 
       g_staj_m.staj008,g_staj_m.staj008_desc,
       g_staj_m.staj024,g_staj_m.staj024_desc,g_staj_m.staj025,g_staj_m.staj025_desc,g_staj_m.staj040,        #150506-00007#3 150522 by sakura add
       g_staj_m.staj026,g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj036,g_staj_m.staj037,g_staj_m.staj038,
       g_staj_m.staj029,g_staj_m.staj030, #150506-00007#3 150522 by sakura add
       g_staj_m.staj031,g_staj_m.staj033,g_staj_m.staj034,g_staj_m.staj042, #add by geza 20160318
       g_staj_m.staj009,g_staj_m.staj009_desc,g_staj_m.staj010,g_staj_m.staj010_desc, 
       g_staj_m.staj015,g_staj_m.staj015_desc,g_staj_m.staj016,g_staj_m.staj016_desc,g_staj_m.staj011, 
       g_staj_m.staj012,g_staj_m.staj013,g_staj_m.staj013_desc,g_staj_m.staj014,g_staj_m.staj014_desc,g_staj_m.staj041,g_staj_m.staj041_desc,
       g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj019,g_staj_m.staj020,g_staj_m.stajsite,g_staj_m.stajsite_desc, 
       g_staj_m.stajunit,g_staj_m.stajstus,g_staj_m.stajownid,g_staj_m.stajownid_desc,g_staj_m.stajowndp, 
       g_staj_m.stajowndp_desc,g_staj_m.stajcrtid,g_staj_m.stajcrtid_desc,g_staj_m.stajcrtdp,g_staj_m.stajcrtdp_desc, 
       g_staj_m.stajcrtdt,g_staj_m.stajmodid,g_staj_m.stajmodid_desc,g_staj_m.stajmoddt,g_staj_m.stajcnfid, 
       g_staj_m.stajcnfid_desc,g_staj_m.stajcnfdt              #鎖住將被更改或取消的資料 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_staj_m.stajdocno
      LET g_errparam.popup = FALSE
      CALL cl_err()
          #資料被他人LOCK
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前
      #檢查是否允許此動作
   IF NOT astt301_action_chk() THEN
      CLOSE astt301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
         
      #end add-point   
      
      INITIALIZE g_doc.* TO NULL         
      LET g_doc.column1 = "stajdocno"       
      LET g_doc.value1 = g_staj_m.stajdocno     
      CALL cl_doc_remove()  
  
      #資料備份
      LET g_stajdocno_t = g_staj_m.stajdocno
 
 
      DELETE FROM staj_t
       WHERE stajent = g_enterprise AND stajdocno = g_staj_m.stajdocno
 
       
      #add-point:單頭刪除中
            
      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_staj_m.stajdocno
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後
      #ken------------------s 需求單號：141208-00001 項次：18
      IF NOT s_aooi200_del_docno(g_staj_m.stajdocno,g_staj_m.stajdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #ken------------------e
      #end add-point
  
      #add-point:單身刪除前
       DELETE FROM stal_t
       WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stal_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
       END IF   
      CALL g_stal_d.clear()
      
      DELETE FROM stbj_t
       WHERE stbjent = g_enterprise AND stbjdocno = g_staj_m.stajdocno
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stbj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
       END IF  
       
       DELETE FROM stbn_t
       WHERE stbnent = g_enterprise AND stbndocno = g_staj_m.stajdocno
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stbn_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
       END IF  

      DELETE FROM stay_t
       WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stay_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
       END IF 
      #end add-point
      
      DELETE FROM stak_t
       WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno
 
 
      #add-point:單身刪除中
            
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stak_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後
            
      #end add-point
      
            
                                                               
      #add-point:單身刪除前
            
      #end add-point
      DELETE FROM stam_t
       WHERE stament = g_enterprise AND
             stamdocno = g_staj_m.stajdocno
      #add-point:單身刪除中
            
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stam_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後
      DELETE FROM staw_t
       WHERE stawent = g_enterprise AND stawdocno = g_staj_m.stajdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "staw_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
      #end add-point
 
 
 
 
                                                               
      CLEAR FORM
      CALL g_stak_d.clear() 
      CALL g_stak2_d.clear()
      CALL g_stak3_d.clear()
      CALL g_stak4_d.clear() 
      CALL g_stal_d.clear()         
      CALL g_staw_d.clear()
      CALL g_stay_d.clear()
      CALL g_stay1_d.clear()
 
     
      CALL astt301_ui_browser_refresh()  
      CALL astt301_ui_headershow()  
      CALL astt301_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL astt301_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      ELSE
         LET g_wc = " 1=1"
         CALL astt301_browser_fill("F")
      END IF
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
 
 
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE astt301_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_staj_m.stajdocno,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="astt301.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astt301_b_fill()
   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
      
   #end add-point     
 
   CALL g_stak_d.clear()    #g_stak_d 單頭及單身 
   CALL g_stak2_d.clear()
    CALL g_staw_d.clear()
    CALL g_stak3_d.clear()
    CALL g_stak4_d.clear()
 
 
   #add-point:b_fill段sql_before
      
   #end add-point
   
   #判斷是否填充
   IF astt301_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE stakseq,stak003,'',stak023,stak024,stak025,'',stak004,stak005,stak006,stak007,stak008,stak027,stak009,  
          '',stak010,'',stak011,stak012,stak013,stak014,stak015,stak016,stak022,stak017,stak018,stak026,stak019,stakunit, 
          staksite FROM stak_t",   
                  " INNER JOIN staj_t ON stajdocno = stakdocno ",
 
                  #"",
                  
                  "",
                  " WHERE stakent=? AND stakdocno=?"
      #add-point:b_fill段sql_before
            
      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY stak_t.stakseq"
      
      #add-point:單身填充控制
      LET g_sql = "SELECT  UNIQUE stakseq,stakacti,stak003,'',stak023,stak024,stak025,'',stak004,stak005,stak006,stak028,stak007,stak008,stak027,stak009, 
          '',stak010,'',stak011,stak012,stak013,stak014,stak015,stak016,stak029,stak030,stak022,stak017,stak018,stak026,stak019,stak020,stak021,stakunit, 
                staksite FROM stak_t", 
                #  " INNER JOIN staj_t ON stajdocno = stakdocno ",
                   " LEFT JOIN stal_t ON stalent = stakent AND stakdocno = staldocno AND stakseq = stalseq1 ",      
             
                  "",
                  " WHERE stakent=? AND stakdocno=?"
      
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table3 CLIPPED
      END IF
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY stak_t.stakseq"  
      #end add-point
      
      PREPARE astt301_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR astt301_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_staj_m.stajdocno
 
                                               
      FOREACH b_fill_cs INTO g_stak_d[l_ac].stakseq,g_stak_d[l_ac].stakacti,g_stak_d[l_ac].stak003,g_stak_d[l_ac].stak003_desc,g_stak_d[l_ac].stak023,g_stak_d[l_ac].stak024, #add by geza 20150610 stak023,stak024
          g_stak_d[l_ac].stak025,g_stak_d[l_ac].stak025_desc,g_stak_d[l_ac].stak004,g_stak_d[l_ac].stak005,g_stak_d[l_ac].stak006,g_stak_d[l_ac].stak028,g_stak_d[l_ac].stak007, 
          g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak027,g_stak_d[l_ac].stak009,g_stak_d[l_ac].stak009_desc,g_stak_d[l_ac].stak010,   #150612-00023#add stak027
          g_stak_d[l_ac].stak010_desc,g_stak_d[l_ac].stak011,g_stak_d[l_ac].stak012,g_stak_d[l_ac].stak013, 
          g_stak_d[l_ac].stak014,g_stak_d[l_ac].stak015,g_stak_d[l_ac].stak016,g_stak_d[l_ac].stak029,g_stak_d[l_ac].stak030,g_stak_d[l_ac].stak022,g_stak_d[l_ac].stak017, 
          g_stak_d[l_ac].stak018,g_stak_d[l_ac].stak026,g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021,g_stak_d[l_ac].stakunit,g_stak_d[l_ac].staksite 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
                          CALL astt301_stak003_ref()
         CALL astt301_stak009_ref()
         CALL astt301_stak010_ref()
         CALL astt301_stak025_ref()
        # add geza 150504-00002#1 (S)  
        # IF g_stak_d[l_ac].stak016 = '1' THEN
        #    CALL cl_set_comp_visible('group7',FALSE)
        # ELSE
        #    CALL cl_set_comp_visible('group7',TRUE)
        # END IF   
         # add geza 150504-00002#1 (E)  
          CALL astt301_set_visible(1)   
          IF g_stak_d[1].stak016 = '1' THEN
             CALL cl_set_comp_visible('group7',FALSE)
          ELSE
             CALL cl_set_comp_visible('group7',TRUE)
          END IF 
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
   IF astt301_fill_chk(2) THEN
      LET g_sql = "SELECT  UNIQUE stamseq,stam003,'',stam005,stam004,stamacti,stamunit,stamsite FROM stam_t",   
                  " INNER JOIN staj_t ON stajdocno = stamdocno ",
 
                  "",
                  
                  " WHERE stament=? AND stamdocno=?"   
      #add-point:b_fill段sql_before
      #150204-00001#45--add by dongsz--str---
      LET g_sql = "SELECT  UNIQUE stamseq,stam003,'',stam005,stam004,stamacti,stamunit,stamsite FROM stam_t",
 
                  "",
                  
                  " WHERE stament=? AND stamdocno=?"  
      #150204-00001#45--add by dongsz--end---
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY stam_t.stamseq"
      
      #add-point:單身填充控制
            
      #end add-point
      
      PREPARE astt301_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR astt301_pb2
      
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_staj_m.stajdocno
 
                                               
      FOREACH b_fill_cs2 INTO g_stak2_d[l_ac].stamseq,g_stak2_d[l_ac].stam003,g_stak2_d[l_ac].stam003_desc,g_stak2_d[l_ac].stam005, 
          g_stak2_d[l_ac].stam004,g_stak2_d[l_ac].stamacti,g_stak2_d[l_ac].stamunit,g_stak2_d[l_ac].stamsite
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
    IF astt301_fill_chk(7) THEN
      LET g_sql = "SELECT  UNIQUE stbjseq,stbj001,stbjunit,stbjsite FROM stbj_t",   
                  "",
                  
                  " WHERE stbjent=? AND stbjdocno=?"   
      #end add-point
      IF NOT cl_null(g_wc2_table7) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table7 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY stbj_t.stbjseq"
      
      #add-point:單身填充控制
            
      #end add-point
      
      PREPARE astt301_pb7 FROM g_sql
      DECLARE b_fill_cs7 CURSOR FOR astt301_pb7
      
      LET l_ac = 1
      
      OPEN b_fill_cs7 USING g_enterprise,g_staj_m.stajdocno
 
                                               
      FOREACH b_fill_cs7 INTO g_stak3_d[l_ac].stbjseq,g_stak3_d[l_ac].stbj001,g_stak3_d[l_ac].stbjunit,g_stak3_d[l_ac].stbjsite
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
   CALL g_stak3_d.deleteElement(g_stak3_d.getLength())
   
   
    IF astt301_fill_chk(8) THEN
      LET g_sql = "SELECT  UNIQUE stbnseq,stbn001,stbnacti,stbnunit,stbnsite FROM stbn_t",   
                  "",
                  
                  " WHERE stbnent=? AND stbndocno=?"   
      #end add-point
      IF NOT cl_null(g_wc2_table8) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table8 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY stbn_t.stbnseq"
      
      #add-point:單身填充控制
            
      #end add-point
      
      PREPARE astt301_pb8 FROM g_sql
      DECLARE b_fill_cs8 CURSOR FOR astt301_pb8
      
      LET l_ac = 1
      
      OPEN b_fill_cs8 USING g_enterprise,g_staj_m.stajdocno
 
                                               
      FOREACH b_fill_cs8 INTO g_stak4_d[l_ac].stbnseq,g_stak4_d[l_ac].stbn001,g_stak4_d[l_ac].stbnacti,g_stak4_d[l_ac].stbnunit,g_stak4_d[l_ac].stbnsite
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         CALL astt301_stbn001_ref()          
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
   CALL g_stak4_d.deleteElement(g_stak4_d.getLength())

   IF astt301_fill_chk(4) THEN
      LET g_sql = "SELECT  UNIQUE stawsite,stawunit,stawseq,staw002,staw003,staw004,staw005,staw006,staw007,ooefl003 FROM staw_t",   
                  " LEFT JOIN ooefl_t ON ooeflent = ",g_enterprise," AND ooefl001 = staw007 AND ooefl002 = '",g_dlang,"'",
                  
                  " WHERE stawent=? AND stawdocno=? "   
      #add-point:b_fill段sql_before
      
      #end add-point
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY staw_t.stawseq"
      
      #add-point:單身填充控制
      
      #end add-point
      
      PREPARE astt301_pb4 FROM g_sql
      DECLARE b_fill_cs4 CURSOR FOR astt301_pb4
      
      LET l_ac = 1
      
      OPEN b_fill_cs4 USING g_enterprise,g_staj_m.stajdocno
 
                                               
      FOREACH b_fill_cs4 INTO g_staw_d[l_ac].stawsite,g_staw_d[l_ac].stawunit,g_staw_d[l_ac].stawseq, g_staw_d[l_ac].staw002, 
          g_staw_d[l_ac].staw003,g_staw_d[l_ac].staw004,g_staw_d[l_ac].staw005,g_staw_d[l_ac].staw006,g_staw_d[l_ac].staw007,
          g_staw_d[l_ac].staw007_desc
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
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   CALL g_staw_d.deleteElement(g_staw_d.getLength())  
   IF astt301_fill_chk(9) THEN
      LET g_sql = "SELECT  UNIQUE stbwsite,stbwunit,stbwseq,stbw001,stbw002,stbw003,stbw004,stbw005,stbw006,stbw007,stael003,stbw008,ooefl003,stbw009 FROM stbw_t",
                  " LEFT JOIN stael_t ON staelent = ",g_enterprise," AND stael001 = stbw007 AND stael002 = '",g_dlang,"'",
                  " LEFT JOIN ooefl_t ON ooeflent = ",g_enterprise," AND ooefl001 = stbw008 AND ooefl002 = '",g_dlang,"'",   
                  " WHERE stbwent=? AND stbwdocno=?"   

      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY stbw_t.stbwseq"
      CALL g_stbw_d.clear()
      
      PREPARE astt301_pb9 FROM g_sql
      DECLARE b_fill_cs9 CURSOR FOR astt301_pb9
      
      LET l_ac = 1
      
      OPEN b_fill_cs9 USING g_enterprise,g_staj_m.stajdocno
 
                                               
      FOREACH b_fill_cs9 INTO g_stbw_d[l_ac].stbwsite,g_stbw_d[l_ac].stbwunit,g_stbw_d[l_ac].stbwseq,g_stbw_d[l_ac].stbw001,g_stbw_d[l_ac].stbw002, 
                              g_stbw_d[l_ac].stbw003,g_stbw_d[l_ac].stbw004,g_stbw_d[l_ac].stbw005,g_stbw_d[l_ac].stbw006,
                              g_stbw_d[l_ac].stbw007,g_stbw_d[l_ac].stbw007_desc,g_stbw_d[l_ac].stbw008,g_stbw_d[l_ac].stbw008_desc,g_stbw_d[l_ac].stbw009
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
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   CALL g_stbw_d.deleteElement(g_stbw_d.getLength())     
   #end add-point
   
   CALL g_stak_d.deleteElement(g_stak_d.getLength())
   CALL g_stak2_d.deleteElement(g_stak2_d.getLength())
 
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE astt301_pb
   FREE astt301_pb2
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION astt301_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM stak_t
       WHERE stakent = g_enterprise AND
         stakdocno = ps_keys_bak[1] AND stakseq = ps_keys_bak[2]
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
      DELETE FROM stam_t
       WHERE stament = g_enterprise AND
         stamdocno = ps_keys_bak[1] AND stamseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中
            
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stam_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
            
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
            
      #end add-point    
      DELETE FROM stbj_t
       WHERE stbjent = g_enterprise AND
         stbjdocno = ps_keys_bak[1] AND stbjseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中
            
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stbj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
            
      #end add-point    
   END IF  


   LET ls_group = "'8',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
            
      #end add-point    
      DELETE FROM stbn_t
       WHERE stbnent = g_enterprise AND
         stbndocno = ps_keys_bak[1] AND stbnseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中
            
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stbn_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
            
      #end add-point    
   END IF 
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION astt301_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO stal_t
                  (stalent,staldocno,stalseq1,stalseq2,stal004,stal005,stal006)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],
                   g_stal_d[l_ac3].stalseq2,g_stal_d[l_ac3].stal004,g_stal_d[l_ac3].stal005,g_stal_d[l_ac3].stal006)

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stal_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
  
   END IF
   
   
          LET ls_group = "'4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
     INSERT INTO staw_t
                  (stawent,stawsite,stawunit,stawseq,stawdocno,staw002,staw003,staw004,staw005,staw006,staw007)
            VALUES(g_enterprise,g_staw_d[l_ac].stawsite,g_staw_d[l_ac].stawunit,
                   ps_keys[2],ps_keys[1],
                   g_staw_d[l_ac].staw002,g_staw_d[l_ac].staw003,g_staw_d[l_ac].staw004,g_staw_d[l_ac].staw005,
                   g_staw_d[l_ac].staw006,g_staw_d[l_ac].staw007)
                   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "staw_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
  
   END IF
   #############################150512-00006#2
   LET ls_group = "'5',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
     INSERT INTO stay_t
                  (stayent,staydocno,stayseq1,stayseq2,stay001,stay002,stay003,stay004)
            VALUES(g_enterprise,ps_keys[1],ps_keys[2],ps_keys[3],g_staj_m.staj001,'1','',g_stay_d[l_ac].stay004)
                   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stay_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
  
   END IF
   
   
   LET ls_group = "'6',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
     INSERT INTO stay_t
                  (stayent,staydocno,stayseq1,stayseq2,stay001,stay002,stay005,stay003,stay004)
            VALUES(g_enterprise,gs_keys[1],gs_keys[2],gs_keys[3],g_staj_m.staj001,'2',g_stay1_d[l_ac].stay005,g_stay1_d[l_ac].stay003,g_stay1_d[l_ac].stay004)
                   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stay_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
  
   END IF
   
   
   #############################
   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
            
      #end add-point 
      INSERT INTO stak_t
                  (stakent,
                   stakdocno,
                   stakseq,
                   stakacti
                   ,stak003,stak023,stak024,stak025,stak004,stak005,stak006,stak007,stak008,stak027,stak009,stak010,stak011,stak012,stak013,stak014,stak015,stak016,stak017,stak018,stak026,stak019,stak020,stak021,stak022,stak028,stak029,stak030,stakunit,staksite) #add by geza 20150610 stak023,stak024 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],
                   g_stak_d[g_detail_idx].stakacti
                   ,g_stak_d[g_detail_idx].stak003,g_stak_d[g_detail_idx].stak023,g_stak_d[g_detail_idx].stak024,g_stak_d[g_detail_idx].stak025,g_stak_d[g_detail_idx].stak004,g_stak_d[g_detail_idx].stak005, #add by geza 20150610 stak023,stak024
                       g_stak_d[g_detail_idx].stak006,g_stak_d[g_detail_idx].stak007,g_stak_d[g_detail_idx].stak008,g_stak_d[g_detail_idx].stak027,                                 #150612-00023#5 add stak027 
                       g_stak_d[g_detail_idx].stak009,g_stak_d[g_detail_idx].stak010,g_stak_d[g_detail_idx].stak011, 
                       g_stak_d[g_detail_idx].stak012,g_stak_d[g_detail_idx].stak013,g_stak_d[g_detail_idx].stak014, 
                       g_stak_d[g_detail_idx].stak015,g_stak_d[g_detail_idx].stak016,g_stak_d[g_detail_idx].stak017, 
                       g_stak_d[g_detail_idx].stak018,g_stak_d[g_detail_idx].stak026,g_stak_d[g_detail_idx].stak019,g_stak_d[g_detail_idx].stak020,g_stak_d[g_detail_idx].stak021,g_stak_d[g_detail_idx].stak022,g_stak_d[g_detail_idx].stak028,g_stak_d[g_detail_idx].stak029,g_stak_d[g_detail_idx].stak030,g_stak_d[g_detail_idx].stakunit, 
                       g_stak_d[g_detail_idx].staksite)
      #add-point:insert_b段資料新增中
            
      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stak_t"
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
      INSERT INTO stam_t
                  (stament,
                   stamdocno,
                   stamseq
                   ,stam003,stam004,stamacti,stam005,stamunit,stamsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stak2_d[g_detail_idx].stam003,g_stak2_d[g_detail_idx].stam004,g_stak2_d[g_detail_idx].stamacti,g_stak2_d[g_detail_idx].stam005,g_stak2_d[g_detail_idx].stamunit, 
                       g_stak2_d[g_detail_idx].stamsite)
      #add-point:insert_b段資料新增中
            
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stam_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後
            
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other
    LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
            
      #end add-point 
      INSERT INTO stbj_t
                  (stbjent,
                   stbjdocno,
                   stbjseq
                   ,stbj001,stbjunit,stbjsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stak3_d[g_detail_idx].stbj001,g_stak3_d[g_detail_idx].stbjunit, 
                       g_stak3_d[g_detail_idx].stbjsite)
      #add-point:insert_b段資料新增中
            
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stbj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
            
      #end add-point
   END IF   
   
   
    LET ls_group = "'8',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
            
      #end add-point 
      INSERT INTO stbn_t
                  (stbnent,
                   stbndocno,
                   stbnseq
                   ,stbn001,stbnacti,stbnunit,stbnsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stak4_d[g_detail_idx].stbn001,g_stak4_d[g_detail_idx].stbnacti,g_stak4_d[g_detail_idx].stbnunit, 
                       g_stak4_d[g_detail_idx].stbnsite)
      #add-point:insert_b段資料新增中
            
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "stbn_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
            
      #end add-point
   END IF   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION astt301_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stak_t" THEN
      #add-point:update_b段修改前
            
      #end add-point     
      UPDATE stak_t 
         SET (stakdocno,
              stakseq,
              stakacti
              ,stak003,stak023,stak024,stak025,stak004,stak005,stak006,stak007,stak008,stak027,stak009,stak010,stak011,stak012,stak013,stak014,stak015,stak016,stak017,stak018,stak026,stak019,stak022,stak028,stak029,stak030,stakunit,staksite) #add by 20150610 stak023,stak024
              = 
             (ps_keys[1],ps_keys[2],
              g_stak_d[g_detail_idx].stakacti
              ,g_stak_d[g_detail_idx].stak003,g_stak_d[g_detail_idx].stak023,g_stak_d[g_detail_idx].stak024,g_stak_d[g_detail_idx].stak025,g_stak_d[g_detail_idx].stak004,g_stak_d[g_detail_idx].stak005, #add by 20150610 stak023,stak024
                  g_stak_d[g_detail_idx].stak006,g_stak_d[g_detail_idx].stak007,g_stak_d[g_detail_idx].stak008,g_stak_d[g_detail_idx].stak027,
                  g_stak_d[g_detail_idx].stak009,g_stak_d[g_detail_idx].stak010,g_stak_d[g_detail_idx].stak011, 
                  g_stak_d[g_detail_idx].stak012,g_stak_d[g_detail_idx].stak013,g_stak_d[g_detail_idx].stak014, 
                  g_stak_d[g_detail_idx].stak015,g_stak_d[g_detail_idx].stak016,g_stak_d[g_detail_idx].stak017, 
                  g_stak_d[g_detail_idx].stak018,g_stak_d[g_detail_idx].stak026,g_stak_d[g_detail_idx].stak019,g_stak_d[g_detail_idx].stak022,
                  g_stak_d[g_detail_idx].stak028,g_stak_d[g_detail_idx].stak029,g_stak_d[g_detail_idx].stak030,g_stak_d[g_detail_idx].stakunit, 
                  g_stak_d[g_detail_idx].staksite) 
         WHERE stakent = g_enterprise AND stakdocno = ps_keys_bak[1] AND stakseq = ps_keys_bak[2]
      #add-point:update_b段修改中
            
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "stak_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "stak_t"
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stam_t" THEN
      #add-point:update_b段修改前
            
      #end add-point     
      UPDATE stam_t 
         SET (stamdocno,
              stamseq
              ,stam003,stam004,stam005,stamacti,stamunit,stamsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stak2_d[g_detail_idx].stam003,g_stak2_d[g_detail_idx].stam004,g_stak2_d[g_detail_idx].stam005,g_stak2_d[g_detail_idx].stamacti,g_stak2_d[g_detail_idx].stamunit, 
                  g_stak2_d[g_detail_idx].stamsite) 
         WHERE stament = g_enterprise AND stamdocno = ps_keys_bak[1] AND stamseq = ps_keys_bak[2]
      #add-point:update_b段修改中
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "stam_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "stam_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
            
      #end add-point  
   END IF
 
 
   
 
   
 
   
   #add-point:update_b段other
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stbj_t" THEN
      #add-point:update_b段修改前
            
      #end add-point     
      UPDATE stbj_t 
         SET (stbjdocno,
              stbjseq
              ,stbj001,stbjunit,stbjsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stak3_d[g_detail_idx].stbj001,g_stak3_d[g_detail_idx].stbjunit, 
                  g_stak3_d[g_detail_idx].stbjsite) 
         WHERE stbjent = g_enterprise AND stbjdocno = ps_keys_bak[1] AND stbjseq = ps_keys_bak[2]

      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "stbj_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "stbj_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE

   END IF    
   
   
    LET ls_group = "'8',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stbn_t" THEN
      #add-point:update_b段修改前
            
      #end add-point     
      UPDATE stbn_t 
         SET (stbndocno,
              stbnseq
              ,stbn001,stbnacti,stbnunit,stbnsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stak4_d[g_detail_idx].stbn001,g_stak4_d[g_detail_idx].stbnacti,g_stak4_d[g_detail_idx].stbnunit, 
                  g_stak4_d[g_detail_idx].stbnsite) 
         WHERE stbnent = g_enterprise AND stbndocno = ps_keys_bak[1] AND stbnseq = ps_keys_bak[2]

      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "stbn_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "stbn_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE

   END IF    
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION astt301_lock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define
          IF ps_table = "stal_t" THEN
      OPEN astt301_bcl3 USING g_enterprise,
                                       g_staj_m.stajdocno,g_stak_d[l_ac].stakseq,g_stal_d[l_ac3].stalseq2
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astt301_bcl3"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF 
   
   IF ps_table = "staw_t" THEN
      OPEN astt301_bcl4 USING g_enterprise,
                                       g_staj_m.stajdocno,g_staw_d[l_ac].stawseq,g_staw_d[l_ac].staw007
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astt301_bcl4"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF 
   
   ##########################150512-00006#2
   IF ps_table = "stay_t" THEN
      OPEN astt301_bcl5 USING g_enterprise,
                                       g_staj_m.stajdocno,g_stak_d[g_detail_idx].stakseq,g_stay_d[l_ac].stayseq2
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astt301_bcl5"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF 
   
   IF ps_table = "stay_t_1" THEN
      OPEN astt301_bcl6 USING g_enterprise,
                                       g_staj_m.stajdocno,g_stak_d[g_detail_idx].stakseq,g_stay1_d[l_ac].stayseq2
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astt301_bcl6"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF 
     
   ##########################
   #end add-point   
   
   #先刷新資料
   #CALL astt301_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "stak_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt301_bcl USING g_enterprise,
                                       g_staj_m.stajdocno,g_stak_d[g_detail_idx].stakseq
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astt301_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "stam_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt301_bcl2 USING g_enterprise,
                                             g_staj_m.stajdocno,g_stak2_d[g_detail_idx].stamseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astt301_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other
    LET ls_group = "stbj_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt301_bcl7 USING g_enterprise,
                                             g_staj_m.stajdocno,g_stak3_d[g_detail_idx].stbjseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astt301_bcl7"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF 

   LET ls_group = "stbn_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt301_bcl8 USING g_enterprise,
                                             g_staj_m.stajdocno,g_stak4_d[g_detail_idx].stbnseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astt301_bcl8"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF   
   

   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="astt301.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION astt301_unlock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define
          LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,3) THEN
      CLOSE astt301_bcl3
   END IF
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astt301_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astt301_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other
    LET ls_group = "'4',"
   IF ls_group.getIndexOf(ps_page,4) THEN
      CLOSE astt301_bcl4
   END IF 
   
   ########################150512-00006#2
     LET ls_group = "'5',"
   IF ls_group.getIndexOf(ps_page,5) THEN
      CLOSE astt301_bcl5
   END IF 
   
     LET ls_group = "'6',"
   IF ls_group.getIndexOf(ps_page,6) THEN
      CLOSE astt301_bcl6
   END IF 
   ########################
   
   LET ls_group = "'7',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astt301_bcl7
   END IF
   
   LET ls_group = "'8',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astt301_bcl8
   END IF

   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="astt301.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION astt301_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1  
   {</Local define>}
   #add-point:set_entry段define
      
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("stajdocno",TRUE)
      #add-point:set_entry段欄位控制
      CALL cl_set_comp_entry("stajdocdt,staj000",TRUE)

      CALL cl_set_comp_entry("staj001",TRUE) 
      CALL cl_set_comp_entry("staj002",TRUE) 
      CALL cl_set_comp_entry("staj004",TRUE) 
      CALL cl_set_comp_entry("stajsite",TRUE)  #ken 需求單號：141208-00001 項次：18
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後

   #add by yangxf ---start---
   IF g_staj_m.staj036 = 'Y' THEN
      CALL cl_set_comp_entry('staj037,staj038',TRUE)
   ELSE
      CALL cl_set_comp_entry('staj037,staj038',FALSE)
   END IF 
   #add by yangxf ----end----
   #150506-00007#3 120522 by sakura--STR
   #修改容差率,超出處理方式
   CALL cl_set_comp_entry("staj015,staj017,staj018,staj027,staj028",TRUE)
   #150506-00007#3 120522 by sakura--END
  
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt301.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION astt301_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_no_entry段define
   DEFINE l_n  LIKE type_t.num5    
   #end add-point     
 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("stajdocno",FALSE)
      #add-point:set_no_entry段欄位控制
                  CALL cl_set_comp_entry("stajdocdt,staj000",FALSE)
                  CALL cl_set_comp_entry("staj001",FALSE)
                  CALL cl_set_comp_entry("stajsite",FALSE) #ken 需求單號：141208-00001 項次：18
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
  

   IF g_staj_m.staj000 = 'U' OR p_cmd = 'u' THEN
      CALL cl_set_comp_entry("staj004,staj002",FALSE) 
   END IF
   #IF g_flag THEN  #ken_mark 需求單號：141208-00001 項次：18
   #   CALL cl_set_comp_entry("stajdocno,stajdocdt",FALSE)
   #END IF
    
   IF g_staj_m.staj000 = 'U' AND NOT cl_null(g_staj_m.staj001) THEN
      SELECT COUNT(*) INTO l_n FROM stax_t
      WHERE staxent = g_enterprise AND stax001 = g_staj_m.staj001 AND stax005 = 'Y'
     IF l_n > 0 THEN
        CALL cl_set_comp_entry("staj017",FALSE)
     ELSE
        CALL cl_set_comp_entry("staj017",TRUE)
     END IF
   END IF
  #IF g_flag THEN
  #   CALL cl_set_comp_entry("stajdocno,stajdocdt",FALSE)
  #END IF
   
   #ken---------------------------s 需求單號：141208-00001 項次：18
   #aooi500設定的欄位控卡
   IF NOT s_aooi500_comp_entry(g_prog,'stajsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("stajsite",FALSE)
   END IF
   #ken---------------------------e
   
   #150506-00007#3 120522 by sakura--STR
   #修改容差率,超出處理方式
   IF g_staj_m.staj026 = 'N' THEN
      LET g_staj_m.staj027 = 0
      LET g_staj_m.staj028 = '1'
      CALL cl_set_comp_entry("staj027,staj028",FALSE)
   END IF
   #150506-00007#3 120522 by sakura--END
   IF g_staj_m.staj000 = 'U' AND g_staj_m.staj031 = '4' THEN 
      CALL cl_set_comp_entry("staj018",FALSE)
   END IF 
   IF g_staj_m.staj000 != 'I' THEN 
      CALL cl_set_comp_entry("staj015",FALSE)
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt301.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION astt301_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_entry_b段define
         DEFINE l_n     LIKE type_t.num5
   DEFINE l_staf003 LIKE staf_t.staf003
   DEFINE l_staf004 LIKE staf_t.staf004
   DEFINE l_staf005 LIKE staf_t.staf005
   DEFINE l_stae006 LIKE stae_t.stae006
   #end add-point     
   #add-point:set_entry_b段
         
  CALL astt301_init_entry(p_cmd)
  IF g_field = 'stak' THEN 
     IF NOT cl_null(g_stak_d[l_ac].stak003) THEN
        #檢查費用編號+經營方式是否存在asti204
        
        SELECT COUNT(*) INTO l_n FROM staf_t
         WHERE stafent = g_enterprise AND staf001= g_stak_d[l_ac].stak003 AND staf002 = g_staj_m.staj002
        IF l_n > 0 THEN
           DECLARE sel_staf CURSOR FOR 
            SELECT staf003,staf004,staf005 FROM staf_t
             WHERE  stafent = g_enterprise AND staf001= g_stak_d[l_ac].stak003 AND staf002 = g_staj_m.staj002
           FOREACH sel_staf INTO l_staf003,l_staf004,l_staf005
              IF l_staf003 = "stao005" THEN
                 CONTINUE FOREACH
              END IF
              LET l_staf003 = cl_str_replace(l_staf003,"stao","stak")
              IF l_staf004 = 'Y' THEN
                 CALL cl_set_comp_entry(l_staf003,TRUE)
              END IF
           END FOREACH 
        ELSE
           IF g_stak_d[l_ac].stak006 = '1' THEN    #變動
              IF g_stak_d[l_ac].stak016 = '1' THEN      
                 CALL cl_set_comp_entry('stak012',TRUE)
              END IF
              CALL cl_set_comp_entry('stak009,stak010',TRUE)
              CALL cl_set_comp_entry('stak013,stak014,stak015,stak016',TRUE)
           ELSE                                    #固定
              CALL cl_set_comp_entry('stak011',TRUE)
           END IF
           #150613-00005#1--mark by dongsz---str---
#           IF g_stak_d[l_ac].stak013 <> '1' THEN    #保底
#              CALL cl_set_comp_entry('stak014,stak015',TRUE)
#           END IF 
           #150613-00005#1--mark by dongsz--end---
           #抓取价款类型
           SELECT stae006 INTO  l_stae006 FROM stae_t WHERE staeent = g_enterprise AND stae001 = g_stak_d[l_ac].stak003
           #mark by geza 20150610(S)
          # IF l_stae006 = '3' THEN
          #    CALL cl_set_comp_entry('stak005',TRUE)
          # ELSE
          #    CALL cl_set_comp_entry('stak005',FALSE)
          # END IF 
           #mark by geza 20150610(E)
        END IF    
     ELSE
         IF g_stak_d[l_ac].stak006 = '1' THEN    #變動
            IF g_stak_d[l_ac].stak016 = '1' THEN      
               CALL cl_set_comp_entry('stak012',TRUE)
            END IF
            CALL cl_set_comp_entry('stak009,stak010',TRUE)
            CALL cl_set_comp_entry('stak013,stak014,stak015,stak016',TRUE)
         ELSE                                    #固定
            CALL cl_set_comp_entry('stak011',TRUE)
         END IF
         IF g_stak_d[l_ac].stak013 <> '1' THEN    #保底
            CALL cl_set_comp_entry('stak014,stak015',TRUE)
         END IF 
         
     END IF   
    #费用编号不为空
  #IF NOT cl_null(g_stak_d[l_ac].stak003) THEN
  #   #抓取价款类型
  #   SELECT stae006 INTO  l_stae006 FROM stae_t WHERE staeent = g_enterprise AND stae001 = g_stak_d[l_ac].stak003
  #   IF l_stae006 = '3' THEN
  #      CALL cl_set_comp_entry('stak005',TRUE)
  #   ELSE
  #      CALL cl_set_comp_entry('stak005',FALSE)
  #   END IF       
  #END IF
  
      #150613-00005#1--add by dongsz---str---
      IF g_stak_d[l_ac].stak013 <> '1' THEN    #保底
         CALL cl_set_comp_entry('stak014,stak015',TRUE)
      END IF 
      #150613-00005#1--add by dongsz--end---
      CALL cl_set_comp_entry('stak019,stak020,stak021,stak024,stak028,stak029,stak030',TRUE) #add by geza 20150610
   END IF 
   IF g_staw_d[l_ac].staw005 = 'Y' THEN
      CALL cl_set_comp_entry('stawseq,staw002,staw003',FALSE)
   ELSE
      CALL cl_set_comp_entry('stawseq,staw002,staw003',TRUE)
   END IF
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="astt301.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION astt301_set_no_entry_b(p_cmd)
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
        
   IF g_field = 'stak' THEN 
       #已结算费用不可维护
#      IF g_staj_m.staj000 != 'I' THEN
#         IF astt301_chk_astm301_jiesuan(g_stak_d[l_ac].stakseq) THEN
#            #结算完的费用不可维护费用截止日以及其它
#            IF astt301_chk_astm301_jiesuan_end(g_stak_d[l_ac].stakseq) THEN
#               CALL cl_set_comp_entry("stak018",FALSE) 
#               CALL cl_set_comp_entry("stak003,stak004,stak006,stak007,stak008,stak009,stak010,stak011,stak012,stak013,stak014,stak015,stak016,stak017",FALSE) 
#            ELSE
#               CALL cl_set_comp_entry("stak003,stak017",FALSE) 
#               CALL cl_set_comp_entry("stak004,stak006,stak007,stak008,stak009,stak010,stak011,stak012,stak013,stak014,stak015,stak016,stak018",TRUE)            
#            END IF
#         ELSE
#            CALL cl_set_comp_entry("stak003,stak017",TRUE) 
#         END IF
#      END IF
      
      
      IF NOT cl_null(g_stak_d[l_ac].stak003) THEN
         #檢查費用編號+經營方式是否存在asti204
         
         SELECT COUNT(*) INTO l_n FROM staf_t
          WHERE stafent = g_enterprise AND staf001= g_stak_d[l_ac].stak003 AND staf002 = g_staj_m.staj002
         IF l_n > 0 THEN
            DECLARE sel_staf_ne CURSOR FOR 
             SELECT staf003,staf004,staf005 FROM staf_t
              WHERE  stafent = g_enterprise AND staf001= g_stak_d[l_ac].stak003 AND staf002 = g_staj_m.staj002
            FOREACH sel_staf_ne INTO l_staf003,l_staf004,l_staf005
               IF l_staf003 = "stao005" THEN
                  CONTINUE FOREACH
               END IF
               LET l_staf003 = cl_str_replace(l_staf003,"stao","stak")
               IF l_staf004 = 'N' THEN
                  CALL cl_set_comp_entry(l_staf003,FALSE)
               END IF
            END FOREACH 
         ELSE
            IF g_stak_d[l_ac].stak006 = '1' THEN    #變動
               IF g_stak_d[l_ac].stak016 <> '1' THEN      
                  LET g_stak_d[l_ac].stak012 = ''
                  CALL cl_set_comp_entry('stak012',FALSE)
               END IF
            ELSE                                    #固定
                LET g_stak_d[l_ac].stak009 = ''
                LET g_stak_d[l_ac].stak009_desc = ''
                LET g_stak_d[l_ac].stak010 = ''
                LET g_stak_d[l_ac].stak010_desc = ''
                LET g_stak_d[l_ac].stak012 = ''
                LET g_stak_d[l_ac].stak013 = '1'
                LET g_stak_d[l_ac].stak014 = ''
                LET g_stak_d[l_ac].stak015 = ''
                LET g_stak_d[l_ac].stak016 = '1'
                CALL cl_set_comp_entry('stak009,stak010,stak012',FALSE)
                CALL cl_set_comp_entry('stak013,stak014,stak015,stak016',FALSE)        
               #LET g_stak_d[l_ac].stak012 = ''
               #CALL cl_set_comp_entry('stak012',FALSE)
            END IF
            
            #150613-00005#1--mark by dongsz---str---
#            IF g_stak_d[l_ac].stak013 = '1' THEN    #保底
#               LET g_stak_d[l_ac].stak014 = ''
#               LET g_stak_d[l_ac].stak015 = ''
#               CALL cl_set_comp_entry('stak014,stak015',FALSE)
#            END IF
            #150613-00005#1--mark by dongsz---end---
            IF g_stak_d[l_ac].stak013 = '3' THEN    #保底扣减
               LET g_stak_d[l_ac].stak015 = ''
               CALL cl_set_comp_entry('stak015',FALSE)
            END IF
         END IF 
      ELSE
          IF g_stak_d[l_ac].stak006 = '1' THEN         #變動
             IF g_stak_d[l_ac].stak016 <> '1' THEN      
                LET g_stak_d[l_ac].stak012 = ''
                CALL cl_set_comp_entry('stak012',FALSE) #費用比率
             END IF
          ELSE                                    #固定
             LET g_stak_d[l_ac].stak009 = ''
             LET g_stak_d[l_ac].stak009_desc = ''
             LET g_stak_d[l_ac].stak010 = ''
             LET g_stak_d[l_ac].stak010_desc = ''
             LET g_stak_d[l_ac].stak012 = ''
             LET g_stak_d[l_ac].stak013 = '1'
             LET g_stak_d[l_ac].stak014 = ''
             LET g_stak_d[l_ac].stak015 = ''
             LET g_stak_d[l_ac].stak016 = '1'
             CALL cl_set_comp_entry('stak009,stak010,stak012',FALSE)
             CALL cl_set_comp_entry('stak013,stak014,stak015,stak016',FALSE)
          END IF
          
          IF g_stak_d[l_ac].stak013 = '1' THEN    #保底
             LET g_stak_d[l_ac].stak014 = ''
             LET g_stak_d[l_ac].stak015 = ''           
             CALL cl_set_comp_entry('stak014,stak015',FALSE)         
          END IF
          IF g_stak_d[l_ac].stak013 = '3' THEN    #保底扣减
             LET g_stak_d[l_ac].stak015 = ''
             CALL cl_set_comp_entry('stak015',FALSE)
          END IF
      END IF   
      #150613-00005#1--add by dongsz---str---
      IF g_stak_d[l_ac].stak013 = '1' THEN    #保底
         LET g_stak_d[l_ac].stak014 = ''
         LET g_stak_d[l_ac].stak015 = ''
         CALL cl_set_comp_entry('stak014,stak015',FALSE)
      END IF
      #150613-00005#1--add by dongsz---end---
      #add by geza 20150610(S)
      IF g_stak_d[l_ac].stak023 = 'N' THEN
         CALL cl_set_comp_entry('stak024',FALSE)     
      END IF 
      IF g_staj_m.staj002 != '3' THEN 
         CALL cl_set_comp_entry('stak029,stak030',FALSE)     
      END IF 
      IF g_stak_d[l_ac].stak006 = '1' OR cl_null(g_stak_d[l_ac].stak006) THEN 
         LET g_stak_d[l_ac].stak028 = 'N'
         CALL cl_set_comp_entry('stak028',FALSE)
      ELSE
         CALL cl_set_comp_entry('stak028',TRUE)
      END IF 
   END IF 
   #add by geza 20150610(E)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="astt301.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION astt301_default_search()
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
      LET ls_wc = ls_wc, " stajdocno = '", g_argv[1], "' AND "
   END IF
   
     
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      #160810-00002#1 160812 by lori mod---(S)  
      #舊程式樣板標準---(S)
      #IF cl_null(g_wc) THEN
      #   LET g_wc = " 1=1" 
      #END IF
      #舊程式樣板標準---(E)
      
      #若無外部參數則預設為1=2
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF  
      #160810-00002#1 160812 by lori mod---(E)
   END IF
   #add-point:default_search段結束前
      
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="astt301.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION astt301_statechange()
   {<Local define>}
   DEFINE lc_state LIKE type_t.chr5
   {</Local define>}
   #add-point:statechange段define
         DEFINE l_success LIKE type_t.chr5
   #end add-point  
   
   #add-point:statechange段開始前
      
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_staj_m.stajdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
   CALL s_transaction_begin() #170106-00009#1
   
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_staj_m.stajstus
            WHEN "N"
               HIDE OPTION "open"
            WHEN "X"
               HIDE OPTION "invalid"
 
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
 
            
         END CASE
     
      #add-point:menu前
      #檢查是否允許此動作
    #   IF NOT astt301_action_chk() THEN
     #     CLOSE astt301_cl
     #     CALL s_transaction_end('N','0')
      #    RETURN
     #  END IF
      
      
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("open,invalid,confirmed",TRUE) #xujing add
  
      
      CASE g_staj_m.stajstus
         WHEN "N"
            CALL cl_set_act_visible("open,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            LET g_action_choice = "statechange"                 #151109-00006#2 151223 add TT.Jessica
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
            
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,open,hold",FALSE)
            
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,open,hold",FALSE)
            
         WHEN "Y"
            HIDE OPTION "open"
            HIDE OPTION "invalid"
            RETURN
            
         WHEN "X"
            HIDE OPTION "open"
            HIDE OPTION "confirmed"
            RETURN 
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("open,invalid,confirmed,hold",FALSE)
            
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("open,invalid,hold",FALSE)
            
      END CASE
      #end add-point
      
      ON ACTION open
         LET lc_state = "N"
         #add-point:action控制
                  
         #end add-point
         EXIT MENU
  
                  
        
 
      ON ACTION confirmed
         LET lc_state = "Y"
         #add-point:action控制
                  
         #end add-point
         EXIT MENU
      #提交
      ON ACTION signing
         #170106-00009#1-S
         #IF cl_auth_chk_act("signing") THEN
         #   IF NOT astt301_send() THEN
         #     RETURN
         #   END IF
         #END IF
         #LET lc_state = ''  #因為_send()已有執行update動作
         #EXIT MENU
         IF cl_auth_chk_act("signing") THEN
            IF NOT astt301_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE astt301_cl
            RETURN
         END IF
         #170106-00009#1-E
 
      #抽單
      ON ACTION withdraw
         #170106-00009#1-S
         #IF cl_auth_chk_act("withdraw") THEN
         #   IF NOT astt301_draw_out() THEN
         #      RETURN
         #   END IF
         #END IF
         #LET lc_state = ''   #因為_draw_out()已有執行update動作
         #EXIT MENU
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT astt301_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE astt301_cl
            RETURN
         END IF
         #170106-00009#1-E
 
 
      ON ACTION invalid
         LET lc_state = "X"
        
         EXIT MENU
      
      #add-point:stus控制
            
      #end add-point
    
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "X"
 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
 
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
          LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y'       
         CALL s_astt301_conf_chk(g_staj_m.stajdocno) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_astt301_conf_upd(g_staj_m.stajdocno) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_staj_m.stajdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

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
                  LET g_errparam.extend = g_staj_m.stajdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

            RETURN            
         END IF         
      WHEN 'X'
         CALL s_astt301_void_chk(g_staj_m.stajdocno) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_astt301_void_upd(g_staj_m.stajdocno) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_staj_m.stajdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

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
                  LET g_errparam.extend = g_staj_m.stajdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

            RETURN    
         END IF
   END CASE
   #end add-point
      
   UPDATE staj_t SET stajstus = lc_state 
    WHERE stajent = g_enterprise AND stajdocno = g_staj_m.stajdocno
 
  
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
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
 
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
 
         
      END CASE
      LET g_staj_m.stajstus = lc_state
      DISPLAY BY NAME g_staj_m.stajstus
   END IF
 
   #add-point:stus修改後
      
   #end add-point
 
   #add-point:statechange段結束前
      
   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="astt301.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION astt301_idx_chk()
   #add-point:idx_chk段define
         IF g_current_page = 3 THEN
      LET g_detail_idx3 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx3 > g_stal_d.getLength() THEN
         LET g_detail_idx3 = g_stal_d.getLength()
      END IF
      IF g_detail_idx3 = 0 AND g_stal_d.getLength() <> 0 THEN
         LET g_detail_idx3 = 1
      END IF
      DISPLAY g_detail_idx3 TO FORMONLY.idx
      DISPLAY g_stal_d.getLength() TO FORMONLY.cnt
   END IF
   
   ##################
   IF g_current_page = 5 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx2 > g_stay_d.getLength() THEN
         LET g_detail_idx2 = g_stay_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_stay_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_stay_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 6 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx2 > g_stay1_d.getLength() THEN
         LET g_detail_idx2 = g_stay1_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_stay1_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_stay1_d.getLength() TO FORMONLY.cnt
   END IF
   ##################
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_stak_d.getLength() THEN
         LET g_detail_idx = g_stak_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stak_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stak_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_stak2_d.getLength() THEN
         LET g_detail_idx = g_stak2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stak2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stak2_d.getLength() TO FORMONLY.cnt
   END IF
 
 
   
   #add-point:idx_chk段other
 
               #add-point:page1自定義行為
   # IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN LET g_detail_idx = 1 END IF
   # IF g_stak_d[g_detail_idx].stak016 = '1' THEN
   #    CALL cl_set_comp_visible('group7',FALSE)
   # ELSE
   #    CALL cl_set_comp_visible('group7',TRUE)
   # END IF 
   # 
   # CALL astt301_set_visible(g_detail_idx)    
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astt301_b_fill2(pi_idx)
   {<Local define>}
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   {</Local define>}
   #add-point:b_fill2段define
   DEFINE l_success       LIKE type_t.num5 
   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後
   CALL astt301_b3_fill()
   CALL astt301_reflesh()
   #add by yangxf ---start----
   IF g_detail_idx <= 0 THEN 
      RETURN 
   END IF 
   IF g_detail_idx > g_stak_d.getLength() THEN
      RETURN 
   END IF 
   #add by yangxf ---end----
   ###################150512-00006#2
   IF (pi_idx = 2 OR pi_idx = 0 ) AND g_stak_d.getLength() > 0 THEN
               CALL g_stay_d.clear()
 
         LET g_sql = "SELECT  UNIQUE stayseq2,stay001,stay002,stay004,ooefl003 FROM stay_t",    
                     "",
                     " LEFT JOIN ooefl_t ON stayent = ooeflent AND stay002 = '1' AND stay004 = ooefl001 AND ooefl002='"||g_dlang||"' ",
 
                     " WHERE stayent=? AND staydocno=? AND stayseq1=? AND stay002 = '1' "
         
         IF NOT cl_null(g_wc2_table5) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  stay_t.stayseq2" 
                            
    
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt301_pb5 FROM g_sql
         DECLARE b_fill_curs5 CURSOR FOR astt301_pb5
         
         OPEN b_fill_curs5 USING g_enterprise,g_staj_m.stajdocno,g_stak_d[g_detail_idx].stakseq
         LET l_ac = 1
         FOREACH b_fill_curs5 INTO g_stay_d[l_ac].stayseq2,g_stay_d[l_ac].stay001,g_stay_d[l_ac].stay002,g_stay_d[l_ac].stay004,g_stay_d[l_ac].stay004_desc 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
      
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
         CALL g_stay_d.deleteElement(g_stay_d.getLength())
         LET g_rec_b = g_stay_d.getLength()
      END IF
      
      
       IF (pi_idx = 3 OR pi_idx = 0 ) AND g_stak_d.getLength() > 0 THEN
               CALL g_stay1_d.clear()
 
         LET g_sql = "SELECT  UNIQUE stayseq2,stay001,stay002,stay005,stay003,stay004,'' FROM stay_t",    
                     "",
                     " WHERE stayent=? AND staydocno=? AND stayseq1=? AND stay002 = '2' "
         
         IF NOT cl_null(g_wc2_table6) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table6 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  stay_t.stayseq2" 
                            
    
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt301_pb6 FROM g_sql
         DECLARE b_fill_curs6 CURSOR FOR astt301_pb6
         
         OPEN b_fill_curs6 USING g_enterprise,g_staj_m.stajdocno,g_stak_d[g_detail_idx].stakseq
         LET l_ac = 1
         FOREACH b_fill_curs6 INTO g_stay1_d[l_ac].stayseq2,g_stay1_d[l_ac].stay001,g_stay1_d[l_ac].stay002,g_stay1_d[l_ac].stay005,g_stay1_d[l_ac].stay003,g_stay1_d[l_ac].stay004,g_stay1_d[l_ac].stay004_desc 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
             CALL s_aint800_01_show(g_stay1_d[l_ac].stay003,g_stay1_d[l_ac].stay004,'','','') RETURNING l_success,g_stay1_d[l_ac].stay004_desc 
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
         CALL g_stay1_d.deleteElement(g_stay1_d.getLength())
         LET g_rec_b = g_stay1_d.getLength()
      END IF

   ###################
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL astt301_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="astt301.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION astt301_fill_chk(ps_idx)
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
 
     #根據wc判定是否需要填充
   IF ps_idx = 7 AND
      ((NOT cl_null(g_wc2_table7) AND g_wc2_table7.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
   IF ps_idx = 8 AND
      ((NOT cl_null(g_wc2_table8) AND g_wc2_table8.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="astt301.signature" >}
   
 
{</section>}
 
{<section id="astt301.set_pk_array" >}
 
 
{</section>}
 
{<section id="astt301.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="astt301.other_function" readonly="Y" >}
   
#+
PUBLIC FUNCTION astt301_b3_fill()
DEFINE p_wc2      STRING
 DEFINE l_a      LIKE type_t.num5
 
   IF g_stak_d.getLength() < 1 THEN 
      RETURN 
   END IF 
   CALL g_stal_d.clear()   
   
   LET g_sql = "SELECT  UNIQUE stalseq2,stal004,stal005,stal006 FROM stal_t",    
               "",
               " WHERE stalent=? AND staldocno=? AND stalseq1 = ?"
 
   IF NOT cl_null(g_wc2_table3) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table3 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY stal_t.stalseq2"
 
   #add-point:單身填充控制

   #end add-point
   
   PREPARE astt301_pb3 FROM g_sql
   DECLARE b_fill_cs3 CURSOR FOR astt301_pb3
 
   LET g_cnt = l_a
   LET l_a = 1
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF
   IF l_ac > g_stak_d.getLength() THEN
      LET l_ac = 1 
   END IF 
   OPEN b_fill_cs3 USING g_enterprise,g_staj_m.stajdocno,g_stak_d[l_ac].stakseq

                                            
   FOREACH b_fill_cs3 INTO g_stal_d[l_a].stalseq2,g_stal_d[l_a].stal004,g_stal_d[l_a].stal005,g_stal_d[l_a].stal006
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
   
   CALL g_stal_d.deleteElement(g_stal_d.getLength())

   LET l_a = g_cnt
   LET g_cnt = 0  
   
   FREE astt301_pb3
END FUNCTION
#+
PUBLIC FUNCTION astt301_reflesh()
  DISPLAY ARRAY g_stak_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)
     BEFORE DISPLAY
         EXIT DISPLAY
  END DISPLAY 
  
  DISPLAY ARRAY g_stak2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)
     BEFORE DISPLAY
         EXIT DISPLAY
  END DISPLAY 
  
  DISPLAY ARRAY g_stal_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3)
       BEFORE DISPLAY
         EXIT DISPLAY
    END DISPLAY
    
  DISPLAY ARRAY g_staw_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)
     BEFORE DISPLAY
       EXIT DISPLAY
   END DISPLAY
END FUNCTION
#+
PUBLIC FUNCTION astt301_set_no_required_b(p_cmd)
 DEFINE p_cmd   LIKE type_t.chr1   
   DEFINE l_n     LIKE type_t.num5
   DEFINE l_staf003 LIKE staf_t.staf003
   DEFINE l_staf004 LIKE staf_t.staf004
   DEFINE l_staf005 LIKE staf_t.staf005


  
   CALL astt301_init_required(p_cmd)

   IF NOT cl_null(g_stak_d[l_ac].stak003) THEN
      #檢查費用編號+經營方式是否存在asti204
      
      SELECT COUNT(*) INTO l_n FROM staf_t
       WHERE stafent = g_enterprise AND staf001= g_stak_d[l_ac].stak003 AND staf002 = g_staj_m.staj002
      IF l_n > 0 THEN

         DECLARE sel_staf_nq CURSOR FOR 
          SELECT staf003,staf004,staf005 FROM staf_t
           WHERE  stafent = g_enterprise AND staf001= g_stak_d[l_ac].stak003 AND staf002 = g_staj_m.staj002
         FOREACH sel_staf_nq INTO l_staf003,l_staf004,l_staf005
            IF l_staf003 = "stao005" THEN
               CONTINUE FOREACH
            END IF
            LET l_staf003 = cl_str_replace(l_staf003,"stao","stak")           
            IF l_staf005 = 'N' THEN
               CALL cl_set_comp_required(l_staf003,FALSE)
            END IF            
         END FOREACH 

      ELSE
         IF g_stak_d[l_ac].stak006 = '1' THEN    #變動
            CALL cl_set_comp_required('stak009',FALSE)
            IF cl_null(g_stak_d[l_ac].stak009) THEN
               CALL cl_set_comp_required('stak011',FALSE)
            END IF
            IF g_stak_d[l_ac].stak016 <> '1' THEN      
               LET g_stak_d[l_ac].stak012 = ''
               CALL cl_set_comp_required('stak012',FALSE)
            END IF
         ELSE                                    #固定
            CALL cl_set_comp_required('stak010',FALSE) 
            LET g_stak_d[l_ac].stak012 = ''
            CALL cl_set_comp_required('stak012',FALSE) 
         END IF   
         IF g_stak_d[l_ac].stak013 = '1' THEN    #保底
            CALL cl_set_comp_required('stak014,stak015',FALSE)
         END IF
      END IF 
   ELSE
      IF g_stak_d[l_ac].stak006 = '1' THEN    #變動
         CALL cl_set_comp_required('stak009',FALSE)
         IF cl_null(g_stak_d[l_ac].stak009) THEN
            CALL cl_set_comp_required('stak011',FALSE)
         END IF
         IF g_stak_d[l_ac].stak016 <> '1' THEN      
            LET g_stak_d[l_ac].stak012 = ''
            CALL cl_set_comp_required('stak012',FALSE)
         END IF
      ELSE                                    #固定
         CALL cl_set_comp_required('stak010',FALSE) 
         LET g_stak_d[l_ac].stak012 = ''
         CALL cl_set_comp_required('stak012',FALSE) 
      END IF   
      IF g_stak_d[l_ac].stak013 = '1' THEN    #保底
         CALL cl_set_comp_required('stak014,stak015',FALSE)
      END IF   
   END IF  
  
END FUNCTION
#+
PUBLIC FUNCTION astt301_stak003_ref()
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_stak_d[l_ac].stak003
    CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_stak_d[l_ac].stak003_desc = '', g_rtn_fields[1] , ''  
    DISPLAY BY NAME g_stak_d[l_ac].stak003_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_set_required_b(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1   
DEFINE l_n     LIKE type_t.num5
DEFINE l_staf003 LIKE staf_t.staf003
DEFINE l_staf004 LIKE staf_t.staf004
DEFINE l_staf005 LIKE staf_t.staf005



  

   IF NOT cl_null(g_stak_d[l_ac].stak003) THEN
      #檢查費用編號+經營方式是否存在asti204
      
      SELECT COUNT(*) INTO l_n FROM staf_t
       WHERE stafent = g_enterprise AND staf001= g_stak_d[l_ac].stak003 AND staf002 = g_staj_m.staj002
      IF l_n > 0 THEN
         DECLARE sel_staf_q CURSOR FOR 
          SELECT staf003,staf004,staf005 FROM staf_t
           WHERE  stafent = g_enterprise AND staf001= g_stak_d[l_ac].stak003 AND staf002 = g_staj_m.staj002
         FOREACH sel_staf_q INTO l_staf003,l_staf004,l_staf005
            IF l_staf003 = "stao005" THEN
               CONTINUE FOREACH
            END IF
            LET l_staf003 = cl_str_replace(l_staf003,"stao","stak")
            IF l_staf005 = 'Y' THEN
            
                CALL cl_set_comp_required(l_staf003,TRUE)
            END IF
         END FOREACH
      ELSE
          IF g_stak_d[l_ac].stak006 = '1' THEN    #變動
             CALL cl_set_comp_required('stak009',FALSE)
             IF NOT cl_null(g_stak_d[l_ac].stak009) THEN
                CALL cl_set_comp_required('stak011',TRUE)
             END IF
             CALL cl_set_comp_required('stak010',TRUE)
             IF g_stak_d[l_ac].stak016 = '1' THEN      
                CALL cl_set_comp_required('stak012',TRUE) 
             END IF
          ELSE                                    #固定
             CALL cl_set_comp_required('stak011',TRUE)
          END IF   
          IF g_stak_d[l_ac].stak013 <> '1' THEN    #保底
             CALL cl_set_comp_required('stak014,stak015',TRUE)
          END IF      
      END IF    
   ELSE
      IF g_stak_d[l_ac].stak006 = '1' THEN    #變動
         CALL cl_set_comp_required('stak009',FALSE)
         IF NOT cl_null(g_stak_d[l_ac].stak009) THEN
            CALL cl_set_comp_required('stak011',TRUE)
         END IF
         CALL cl_set_comp_required('stak010',TRUE)
         IF g_stak_d[l_ac].stak016 = '1' THEN      
            CALL cl_set_comp_required('stak012',TRUE) 
         END IF
      ELSE                                    #固定
         CALL cl_set_comp_required('stak011',TRUE)
      END IF   
      IF g_stak_d[l_ac].stak013 <> '1' THEN    #保底
         CALL cl_set_comp_required('stak014,stak015',TRUE)
      END IF   
   END IF 
  
END FUNCTION
#+
PUBLIC FUNCTION astt301_stak009_chk(p_stab001)
DEFINE p_stab001   LIKE stab_t.stab001
DEFINE l_stabstus  LIKE stab_t.stabstus
DEFINE l_n         LIKE type_t.num5
  #SELECT stabstus INTO l_stabstus FROM stab_t
  # WHERE stabent = g_enterprise AND stab001 = p_stab001
  # 
  #IF STATUS = 100 OR cl_null(l_stabstus) THEN
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code = 'ast-00014'
  #   LET g_errparam.extend = ''
  #   LET g_errparam.popup = TRUE
  #   CALL cl_err()
  #
  #   RETURN FALSE
  #ELSE
  #   IF l_stabstus = 'N' THEN
  #      INITIALIZE g_errparam TO NULL
  #      LET g_errparam.code = 'ast-00015'
  #      LET g_errparam.extend = ''
  #      LET g_errparam.popup = TRUE
  #      CALL cl_err()
  #
  #      RETURN FALSE 
  #   END IF
  #END IF
   LET g_errshow = '1'
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_stab001
   IF NOT cl_chk_exist("v_stab001") THEN
      RETURN FALSE
   END IF
   
   SELECT COUNT(*) INTO l_n FROM stab_t LEFT OUTER JOIN stat_t ON stabent = statent AND stab001 = stat003
     WHERE  stabent = g_enterprise AND stab001= p_stab001 AND stat001 = g_staj_m.staj002 AND stat002 = g_staj_m.staj010 
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00189'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astt301_stak003_chk(p_stae001)
DEFINE p_stae001  LIKE stae_t.stae001
DEFINE l_staestus LIKE stae_t.staestus
DEFINE l_stae010  LIKE stae_t.stae010
DEFINE l_n        LIKE type_t.num5
DEFINE l_ooef019  LIKE ooef_t.ooef019

   SELECT staestus INTO l_staestus FROM stae_t
    WHERE stae001 = p_stae001 AND staeent = g_enterprise
   
   IF STATUS = 100 OR  cl_null(l_staestus) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   ELSE
      IF l_staestus = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00002'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   
   #税别要存在于签订法人税区里面的税别
   SELECT stae010 INTO l_stae010 FROM stae_t WHERE staeent = g_enterprise AND stae001 = p_stae001
   SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_staj_m.staj013
   
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
PUBLIC FUNCTION astt301_staj005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.staj005
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_staj_m.staj005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.staj005_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj005_chk(p_pmaa001)
DEFINE p_pmaa001   LIKE pmaa_t.pmaa001
DEFINE l_pmaastus  LIKE pmaa_t.pmaastus

   SELECT pmaastus INTO l_pmaastus FROM pmaa_t
    WHERE pmaaent = g_enterprise AND pmaa001 = p_pmaa001 AND pmaa002 IN ('1','3')
   IF STATUS = 100 OR cl_null(l_pmaastus) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00016'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   ELSE
      IF l_pmaastus <> 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00017'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.staj004
   CALL ap_ref_array2(g_ref_fields,"SELECT stagl003 FROM stagl_t WHERE staglent='"||g_enterprise||"' AND stagl001=? AND stagl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_staj_m.staj004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.staj004_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj004_chk(p_stag001)
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
PUBLIC FUNCTION astt301_staj006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.staj006
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_staj_m.staj006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.staj006_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj006_chk(p_staj006)
DEFINE p_staj006  LIKE staj_t.staj006
  
   LET g_errshow = '1'
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_site
   LET g_chkparam.arg2 = p_staj006
   
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
PUBLIC FUNCTION astt301_staj007_ref()
  SELECT oodbl004 INTO g_staj_m.staj007_desc
    FROM oodbl_t,ooef_t
   WHERE oodblent = g_enterprise
    AND oodbl001 = ooef019 
    AND oodbl002 = g_staj_m.staj007
    AND oodbl003 = g_dlang
    AND ooefent = g_enterprise
    AND ooef001 = g_staj_m.staj013    #150213-00006#1 2015/02/13 By pomelo 
    #AND ooef001 = g_site             #150213-00006#1 2015/02/13 By mark
   DISPLAY BY NAME g_staj_m.staj007_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj007_chk(p_staj007)
DEFINE  p_staj007    LIKE staj_t.staj007
DEFINE  l_oodcstus   LIKE oodc_t.oodcstus

   LET g_errno = ''
   SELECT oodbstus INTO l_oodcstus
     FROM oodb_t,ooef_t
    WHERE oodbent = g_enterprise
      AND oodb001 = ooef019
      AND oodb002 = p_staj007
      AND oodb004 = '1'
      AND ooefent = g_enterprise
      AND ooef001 = g_staj_m.staj013    #150213-00006#1 2015/02/13 By pomelo 
      #AND ooef001 = g_site             #150213-00006#1 2015/02/13 By mark
      
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'ast-00009' #稅目不存在
                               LET g_staj_m.staj007_desc = ''
      WHEN l_oodcstus <> 'Y'   LET g_errno = 'ast-00010' #稅目已無效
                               LET  g_staj_m.staj007_desc = ''
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
#+
PUBLIC FUNCTION astt301_staj009_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.staj009
   CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_staj_m.staj009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.staj009_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj010_ref()
    INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.staj010
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2060' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_staj_m.staj010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.staj010_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj010_chk(p_staj010)
DEFINE p_staj010  LIKE staj_t.staj010
DEFINE l_oocqstus LIKE oocq_t.oocqstus
DEFINE l_n1        LIKE type_t.num5
DEFINE l_n2        LIKE type_t.num5

   SELECT oocqstus INTO l_oocqstus FROM oocq_t
    WHERE oocqent =  g_enterprise AND oocq001 = '2060' AND oocq002 = p_staj010
    
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
   
     #单身条件基准 和单头的结算类型不符合就报错 
   SELECT COUNT(*) INTO l_n1 FROM stak_t 
    WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno AND stak009 IS NOT NULL
      AND  NOT EXISTS (SELECT 1 FROM stab_t LEFT OUTER JOIN stat_t ON stabent = statent AND stab001 = stat003
              WHERE stab001 = stak009 AND stat001 = g_staj_m.staj002 AND stat002 = p_staj010)
              
              
   SELECT COUNT(*) INTO l_n2 FROM stak_t 
    WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno AND stak010 IS NOT NULL
      AND  NOT EXISTS (SELECT 1 FROM stab_t LEFT OUTER JOIN stat_t ON stabent = statent AND stab001 = stat003
              WHERE stab001 = stak010 AND stat001 = g_staj_m.staj002 AND stat002 = p_staj010)

   
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
#+
PUBLIC FUNCTION astt301_staj009_chk(p_staj009)
DEFINE p_staj009  LIKE staj_t.staj009
DEFINE l_staastus LIKE staa_t.staastus
DEFINE l_n1        LIKE type_t.num5
DEFINE l_n2        LIKE type_t.num5

   SELECT staastus INTO l_staastus FROM staa_t 
     WHERE staaent = g_enterprise AND staa001 = p_staj009
     
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
PUBLIC FUNCTION astt301_staj015_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.staj015
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_staj_m.staj015_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.staj015_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj015_chk(p_staj015)
DEFINE p_staj015  LIKE staj_t.staj015

   INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = '1'
   LET g_chkparam.arg1 = p_staj015
   #LET g_chkparam.arg2 = 'A'
   IF NOT cl_chk_exist("v_ooef001_31") THEN
      RETURN FALSE
   END IF
 
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj016_ref()
   INITIALIZE g_ref_fields TO NULL
  LET g_ref_fields[1] = g_staj_m.staj016
  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
  LET g_staj_m.staj016_desc = '', g_rtn_fields[1] , ''
  DISPLAY BY NAME g_staj_m.staj016_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj016_chk(p_staj016)
DEFINE p_staj016  LIKE staj_t.staj016

   INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = '1'
   LET g_chkparam.arg1 = p_staj016
   #LET g_chkparam.arg2 = 'D'
   IF NOT cl_chk_exist("v_ooef001_34") THEN
      RETURN FALSE
   END IF
   RETURN TRUE  
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj004_other()
   
   SELECT stag003,stag004,stag005,stag006,stag007#,stag008 
     INTO g_staj_m.staj008,g_staj_m.staj009,g_staj_m.staj010,g_staj_m.staj006,
          g_staj_m.staj007#,g_staj_m.stajsite
     FROM stag_t
    WHERE stagent = g_enterprise AND stag001 = g_staj_m.staj004
    
   
   #LET g_staj_m_t.* = g_staj_m.*
   LET g_staj_m_t.staj008 = g_staj_m.staj008
   LET g_staj_m_t.staj009 = g_staj_m.staj009
   LET g_staj_m_t.staj010 = g_staj_m.staj010
   LET g_staj_m_t.staj006 = g_staj_m.staj006
   LET g_staj_m_t.staj007 = g_staj_m.staj007
   
   DISPLAY BY NAME g_staj_m.staj008,g_staj_m.staj009,g_staj_m.staj010,g_staj_m.staj006,g_staj_m.staj007,g_staj_m.stajsite
   
   CALL astt301_staj008_ref()
   CALL astt301_staj009_ref()
   CALL astt301_staj010_ref()
   CALL astt301_staj006_ref()
   CALL astt301_staj007_ref()
   
 
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj004_genb()
DEFINE l_sql    STRING
#DEFINE l_stah   RECORD LIKE stah_t.* #161111-00028#3--mark
DEFINE l_next_b LIKE type_t.dat
DEFINE l_stak019 LIKE stak_t.stak019
DEFINE l_stak020 LIKE stak_t.stak020
DEFINE l_stak021 LIKE stak_t.stak021 

#   DECLARE  sel_stah CURSOR FOR SELECT stahent,stah001,stah002,stah003,stah004,stah005,stah006,
#          stah007,stah008,stah009,stah010,stah011,stah012,stah013,stah014,stah015,stah016
#     FROM stah_t 
#    WHERE stahent = g_enterprise AND stah001 =g_staj_m.staj004 
#   
#   FOREACH sel_stah INTO l_stah.*
#   
#       CALL s_astt301_cal_nextd(l_stah.stah007,l_stah.stah008,g_staj_m.staj017,g_staj_m.staj018,'','','Y',g_staj_m.stajdocno) RETURNING l_stak019,l_stak020,l_stak021
#       
#      INSERT INTO stak_t(stakent,stakunit,staksite,stakdocno,stakseq,stakacti,stak003,stak004,stak005,stak006,stak007,
#                      stak008,stak009,stak010,stak011,stak012,stak013,stak014,stak015,stak016,stak017,stak018,stak019,stak020,stak021,stak027)
#          VALUES (l_stah.stahent,g_staj_m.stajunit,g_staj_m.stajsite,g_staj_m.stajdocno,l_stah.stah002,'Y',l_stah.stah003,l_stah.stah004,l_stah.stah005,
#                    l_stah.stah006,l_stah.stah007,l_stah.stah008,l_stah.stah009,l_stah.stah010,l_stah.stah011,l_stah.stah012,
#                    l_stah.stah013,l_stah.stah014,l_stah.stah015,l_stah.stah016,g_staj_m.staj017,g_staj_m.staj018,l_stak019,l_stak020,l_stak021,'Y')
#                                  
#   END FOREACH 
    
   INSERT INTO stal_t(stalent,staldocno,stalseq1,stalseq2,stal004,stal005,stal006)
   SELECT staient,g_staj_m.stajdocno,stai002,stai003,stai004,stai005,stai006
     FROM stai_t 
    WHERE staient =   g_enterprise AND stai001 = g_staj_m.staj004   
END FUNCTION
#+
PUBLIC FUNCTION astt301_stam003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stak2_d[l_ac].stam003
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stak2_d[l_ac].stam003_desc = '', g_rtn_fields[1] , ''

   DISPLAY BY NAME g_stak2_d[l_ac].stam003_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_stam003_chk(p_stam003)
DEFINE p_stam003  LIKE stam_t.stam003
DEFINE l_sys      LIKE type_t.num5
DEFINE l_n        LIKE type_t.num5

   INITIALIZE g_chkparam.* TO NULL

   LET g_chkparam.arg1 = p_stam003
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
   
#mark by yangxf ---start---
#   SELECT COUNT(stan001) INTO l_n FROM stan_t LEFT OUTER JOIN staq_t ON stanent = staqent AND stan001 = staq001
#    WHERE stanent = g_enterprise AND stan002 = g_staj_m.staj002 
#      AND stan005 = g_staj_m.staj005 
#      AND (stan017 BETWEEN g_staj_m.staj017 AND g_staj_m.staj018
#           OR stan018 BETWEEN g_staj_m.staj017 AND g_staj_m.staj018
#           OR g_staj_m.staj017 BETWEEN stan017 AND stan018
#           OR g_staj_m.staj018 BETWEEN stan017 AND stan018)
#      AND stan001 <>  g_staj_m.staj001
#      AND stanstus = 'Y'
#      AND staq003 = p_stam003
#   IF l_n > 0 THEN   
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'ast-00036'
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#
#      RETURN FALSE  
#   END IF
#mark by yangxf ---end---
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj013_ref()
    INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.staj013
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_staj_m.staj013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.staj013_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj014_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.staj014
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_staj_m.staj014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.staj014_desc
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj013_chk(p_staj013)
DEFINE p_staj013  LIKE staj_t.staj013

   INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = '1'
   LET g_chkparam.arg1 = p_staj013
   #LET g_chkparam.arg2 = '1'
   IF NOT cl_chk_exist("v_ooef001_1") THEN
      RETURN FALSE
   END IF
   RETURN TRUE   
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj014_chk(p_staj014)
DEFINE p_staj014  LIKE staj_t.staj014
DEFINE l_ooagstus LIKE ooag_t.ooagstus
DEFINE l_ooag003   LIKE ooag_t.ooag003

   SELECT ooag003,ooagstus INTO l_ooag003,l_ooagstus FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = p_staj014
    
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
#         LET g_errparam.code = 'aoo-00071'   #160318-00005#44  mark
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
   LET g_staj_m.staj041 = l_ooag003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.staj041
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_staj_m.staj041_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.staj041,g_staj_m.staj041_desc
   RETURN TRUE
END FUNCTION
#
PUBLIC FUNCTION astt301_staj001_chk(p_cmd,p_staj001)
DEFINE p_cmd       LIKE type_t.chr1
DEFINE p_staj001   LIKE staj_t.staj001
DEFINE l_stanstus  LIKE stan_t.stanstus
DEFINE l_n         LIKE type_t.num5
DEFINE l_stan029   LIKE stan_t.stan029

   #新增
   IF g_staj_m.staj000 = 'I' THEN
      SELECT COUNT(*) INTO l_n FROM stan_t WHERE stanent = g_enterprise AND stan001 = p_staj001
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00029'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   #更改
   IF g_staj_m.staj000 = 'U' OR g_staj_m.staj000 = 'R' THEN
      SELECT stanstus,stan029 INTO l_stanstus,l_stan029 FROM stan_t WHERE stanent = g_enterprise AND stan001 = p_staj001
      IF STATUS = 100 OR cl_null(l_stanstus) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00030'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      IF l_stanstus <> 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00017'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      IF l_stan029 = '5' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00348'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
         
   END IF
   IF p_cmd = 'a' THEN
      SELECT COUNT(*) INTO l_n FROM staj_t
      WHERE stajent = g_enterprise AND staj001 = p_staj001 AND stajstus = 'N'
   ELSE
     SELECT COUNT(*) INTO l_n FROM staj_t
      WHERE stajent = g_enterprise AND staj001 = p_staj001 AND stajstus = 'N'
        AND stajdocno <> g_staj_m.stajdocno
   END IF
   
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00141'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj001_other()
   
   SELECT stan002,stan021,stan005,stan004,stan006,
          stan007,stan008,stan022,stan023,stan024,
          stan025,stan026,stan027,stan028,stan034,             #150506-00007#3 150522 by sakura add
          stan035,stan036,stan029,stan031,
          stan032,stan009,stan010,stan015,stan016,
          stan011,stan012,stan013,stan014,stan017,
          #stan018,stan019,stan020,NVL(stan003+1,2),CASE stanstus WHEN 'X' THEN 'N' ELSE 'Y' END ,stan037,stan038,stan039  #mark by geza 20160318 
          stan018,stan019,stan020,NVL(stan003+1,2),stan037,stan038,stan039  #add by geza 20160318
     INTO g_staj_m.staj002,g_staj_m.staj021,g_staj_m.staj005,g_staj_m.staj004,g_staj_m.staj006,
          g_staj_m.staj007,g_staj_m.staj008,g_staj_m.staj024,g_staj_m.staj025,g_staj_m.staj026,
          g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj029,g_staj_m.staj030,g_staj_m.staj036,            #150506-00007#3 150522 by sakura add
          g_staj_m.staj037,g_staj_m.staj038,g_staj_m.staj031,g_staj_m.staj033,
          g_staj_m.staj034,g_staj_m.staj009,g_staj_m.staj010,g_staj_m.staj015,g_staj_m.staj016,
          g_staj_m.staj011,g_staj_m.staj012,g_staj_m.staj013,g_staj_m.staj014,g_staj_m.staj017,
          g_staj_m.staj018,g_staj_m.staj019,g_staj_m.staj020,g_staj_m.staj003,g_staj_m.staj040,g_staj_m.staj041,g_staj_m.staj042  #add by geza 20160318 
     FROM stan_t
    WHERE stanent = g_enterprise AND stan001 = g_staj_m.staj001
   
    
   LET g_staj_m.staj003 = g_staj_m.staj003 USING "<<<<<<<<<#" 
  
   #LET g_staj_m_t.* = g_staj_m.*
   DISPLAY BY NAME g_staj_m.staj002,g_staj_m.staj031,g_staj_m.staj021,g_staj_m.staj005,g_staj_m.staj016,
                   g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj012,g_staj_m.staj014,g_staj_m.staj041,g_staj_m.staj013,
                   g_staj_m.staj036,g_staj_m.staj037,g_staj_m.staj038,g_staj_m.staj015,g_staj_m.staj009,g_staj_m.staj010,
                   g_staj_m.staj034,g_staj_m.staj033,g_staj_m.staj035,g_staj_m.staj019,g_staj_m.staj020,g_staj_m.staj029,
                   g_staj_m.staj030,g_staj_m.staj008,g_staj_m.staj024,g_staj_m.staj006,g_staj_m.staj007,g_staj_m.staj025,
                   g_staj_m.staj040,g_staj_m.staj026,g_staj_m.staj027,g_staj_m.staj028,g_staj_m.staj011,g_staj_m.stajstus
   
   CALL astt301_staj008_ref()
   CALL astt301_staj004_ref()
   CALL astt301_staj005_ref()
   CALL astt301_staj006_ref()
   CALL astt301_staj007_ref()
   CALL astt301_staj009_ref()
   CALL astt301_staj010_ref()
   CALL astt301_staj015_ref()
   CALL astt301_staj016_ref()
   CALL astt301_staj013_ref()
   CALL astt301_staj014_ref()
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_staj_m.staj041
    CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_staj_m.staj041_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_staj_m.staj041_desc
   #150506-00007#3 150522 by sakura add---STR
   #交易條件
   CALL s_desc_get_acc_desc('238',g_staj_m.staj024) RETURNING g_staj_m.staj024_desc
   DISPLAY BY NAME g_staj_m.staj024_desc
   #發票類型
   CALL s_desc_get_invoice_type_desc1(g_site,g_staj_m.staj025) RETURNING g_staj_m.staj025_desc
   DISPLAY BY NAME g_staj_m.staj025_desc
   #150506-00007#3 150522 by sakura add---END
   IF g_staj_m.staj000 != 'U' THEN 
      LET g_staj_m.staj036 = 'N'
      LET g_staj_m.staj037 = ''
      LET g_staj_m.staj038 = ''
   END IF 
   IF g_staj_m.staj036 = 'Y' THEN
      CALL cl_set_comp_entry('staj037,staj038',TRUE)
   ELSE
      CALL cl_set_comp_entry('staj037,staj038',FALSE)
   END IF 
   #带值执行日期
   CALL astt301_get_staj039() RETURNING g_staj_m.staj039
   DISPLAY BY NAME g_staj_m.staj039
END FUNCTION
#+
PUBLIC FUNCTION astt301_staj001_genb()

#mark by yangxf ----start----
#   IF g_stak_d.getLength() > 0 OR g_stak2_d.getLength() > 0 OR g_stal_d.getLength() > 0 OR g_staw_d.getLength() > 0 
#      OR g_stak3_d.getLength() > 0 THEN
#mark by yangxf ----end----
   IF g_stak_d.getLength() > 0 OR g_stak2_d.getLength() > 0 OR g_stal_d.getLength() > 0 OR g_stak3_d.getLength() > 0 THEN  #add by yangxf 
      IF NOT cl_ask_confirm('axm-00175') THEN     
         RETURN FALSE
      END IF
      
      DELETE FROM stak_t WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stak'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      
      DELETE FROM stal_t WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stal'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      
      DELETE FROM stam_t WHERE stament = g_enterprise AND stamdocno = g_staj_m.stajdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stam'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      
      IF g_period_flag = 'N' THEN   #add by yangxf
         DELETE FROM staw_t WHERE stawent = g_enterprise AND stawdocno = g_staj_m.stajdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'del staw'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            RETURN FALSE
         END IF
      END IF              #add by yangxf
      
      DELETE FROM stay_t WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stay'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      
      DELETE FROM stbj_t WHERE stbjent = g_enterprise AND stbjdocno = g_staj_m.stajdocno
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stbj'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      
      DELETE FROM stbn_t WHERE stbnent = g_enterprise AND stbndocno = g_staj_m.stajdocno
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stbn'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      
   END IF
   INSERT INTO stak_t(stakent,stakunit,staksite,stakdocno,stakseq,stakacti,stak003,stak004,stak005,stak006,
                     stak007,stak008,stak027,stak009,stak010,stak011,stak012,stak013,stak014,stak015,stak016,stak017,stak018,stak026,stak019,stak020,stak021,stak022,stak023,stak024,stak025,stak028,stak029,stak030) #150612-00023#5 add stak027   #add by geza 20150610  stak023,stak024
   SELECT staoent,g_staj_m.stajunit,g_staj_m.stajsite,g_staj_m.stajdocno,stao002,staoacti,stao003,stao004,stao005,stao006,                     
          stao007,stao008,stao027,stao009,stao010,stao011,stao012,stao013,stao014,stao015,stao016,g_staj_m.staj017,g_staj_m.staj018,stao026,stao019,stao020,stao021,stao022,stao023,stao024,stao025,stao028,stao029,stao030   #add by geza 20150610  stao023,stao024
     FROM stao_t 
    WHERE staoent = g_enterprise AND stao001 =g_staj_m.staj001 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stak'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   INSERT INTO stal_t(stalent,staldocno,stalseq1,stalseq2,stal004,stal005,stal006)
   SELECT stapent,g_staj_m.stajdocno,stap002,stap003,stap004,stap005,stap006
     FROM stap_t 
    WHERE stapent =   g_enterprise AND stap001 = g_staj_m.staj001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stal'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   INSERT INTO stam_t(stament,stamunit,stamsite,stamdocno,stamseq,stam003,stam004,stam005,stamacti)
   SELECT staqent,g_staj_m.stajunit,g_staj_m.stajsite,g_staj_m.stajdocno,staq002,staq003,staq004,staq005,staqacti
     FROM staq_t
    WHERE staqent = g_enterprise AND staq001 = g_staj_m.staj001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stam'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   ######
    INSERT INTO stbj_t(stbjent,stbjsite,stbjunit,stbjdocno,stbjseq,stbj001)
    #SELECT stbkent,g_staj_m.stajsite,g_staj_m.stajunit,g_staj_m.stajdocno,stbk001,stbk002 FROM stbk_t   #150613-00017#1--mark by dongsz
    SELECT stbkent,g_staj_m.stajsite,g_staj_m.stajunit,g_staj_m.stajdocno,stbk002,stbk003 FROM stbk_t    #150613-00017#1--add by dongsz
     WHERE stbkent = g_enterprise AND stbk001 = g_staj_m.staj001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stbj'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF  
   
   INSERT INTO stbn_t(stbnent,stbnsite,stbnacti,stbnunit,stbndocno,stbnseq,stbn001)
    SELECT stboent,g_staj_m.stajsite,stboacti,g_staj_m.stajunit,g_staj_m.stajdocno,stbo002,stbo003 FROM stbo_t   
     WHERE stboent = g_enterprise AND stbo001 = g_staj_m.staj001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stbn'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF  
   ######
   
#   IF g_period_flag = 'N' THEN #add by yangxf
      INSERT INTO staw_t(stawent,stawsite,stawunit,stawdocno,stawseq,staw001,staw002,staw003,staw004,staw005,staw006,staw007)
        SELECT staxent,staxsite,staxunit,g_staj_m.stajdocno,staxseq,stax001,stax002,stax003,stax004,stax005,stax006,stax007
         FROM stax_t
        WHERE staxent = g_enterprise AND stax001 =  g_staj_m.staj001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins staw'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         RETURN FALSE
      END IF
#   END IF    #add by yangxf
   
   ###################
   INSERT INTO stay_t(stayent,staydocno,stayseq1,stayseq2,stay001,stay002,stay005,stay003,stay004)
      SELECT stazent,g_staj_m.stajdocno,stazseq1,stazseq2,staz001,staz002,staz005,staz003,staz004 FROM staz_t
       WHERE stazent = g_enterprise AND staz001 =  g_staj_m.staj001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stay'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   ###################
   
   #add by yangxf ----start----
   DELETE FROM stbw_t WHERE stbwent = g_enterprise AND stbwdocno = g_staj_m.stajdocno
   INSERT INTO stbw_t(stbwent,stbwsite,stbwunit,stbwdocno,stbwseq,stbw001,stbw002,stbw003,stbw004,stbw005,stbw006,stbw007,stbw008,stbw009)
     SELECT stbxent,stbxsite,stbxunit,g_staj_m.stajdocno,stbxseq,stbxseq1,stbx002,stbx003,stbx004,stbx005,stbx006,stbx007,stbx008,stbx009  
      FROM stbx_t
     WHERE stbxent = g_enterprise AND stbx001 =  g_staj_m.staj001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stbw'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      RETURN FALSE
   END IF
   
   #add by yangxf ---end-----
   RETURN TRUE
   
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL astt301_default(p_staj002,p_stak003)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION astt301_default(p_staj002,p_stak003)
DEFINE p_staj002 LIKE staj_t.staj002
DEFINE p_stak003 LIKE stak_t.stak003
DEFINE l_staf003 LIKE staf_t.staf003
DEFINE l_staf006 LIKE staf_t.staf006

    DECLARE sel_staf_d CURSOR FOR 
     SELECT staf003,staf006 FROM staf_t
      WHERE  stafent = g_enterprise AND staf001= p_stak003 AND staf002 = p_staj002
   FOREACH sel_staf_d INTO l_staf003,l_staf006
       LET l_staf003 = cl_str_replace(l_staf003,"stao","stak")
      CASE l_staf003
          WHEN 'stak004'
             LET g_stak_d[l_ac].stak004 = l_staf006
          WHEN 'stak005'
             IF NOT cl_null(l_staf006) THEN
                LET g_stak_d[l_ac].stak005 = l_staf006
             END IF
          WHEN 'stak006'
             LET g_stak_d[l_ac].stak006 = l_staf006
          WHEN 'stak007'
             LET g_stak_d[l_ac].stak007 = l_staf006
          WHEN 'stak008'
             LET g_stak_d[l_ac].stak008 = l_staf006
          WHEN 'stak009'
             LET g_stak_d[l_ac].stak009 = l_staf006
             CALL astt301_stak009_ref()
          WHEN 'stak010'
             LET g_stak_d[l_ac].stak010 = l_staf006
             CALL astt301_stak010_ref()
          WHEN 'stak011'
             LET g_stak_d[l_ac].stak011 = l_staf006
          WHEN 'stak012'
             LET g_stak_d[l_ac].stak012 = l_staf006
          WHEN 'stak013'
             LET g_stak_d[l_ac].stak013 = l_staf006
          WHEN 'stak014'
             LET g_stak_d[l_ac].stak014 = l_staf006
          WHEN 'stak015'
             LET g_stak_d[l_ac].stak015 = l_staf006
          WHEN 'stak016'
             LET g_stak_d[l_ac].stak016 = l_staf006
          WHEN 'stak017'
             IF NOT cl_null(l_staf006) THEN
                LET g_stak_d[l_ac].stak017 = l_staf006
             END IF
          WHEN 'stak018'
             IF NOT cl_null(l_staf006) THEN
                LET g_stak_d[l_ac].stak018 = l_staf006
             END IF
      END CASE
#       CALL astt301_cal_nextd() RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
   END FOREACH 
   DISPLAY BY NAME g_stak_d[l_ac].stak004,g_stak_d[l_ac].stak005,g_stak_d[l_ac].stak006,
                  g_stak_d[l_ac].stak007,g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak009,g_stak_d[l_ac].stak009_desc,
                  g_stak_d[l_ac].stak010,g_stak_d[l_ac].stak010_desc,g_stak_d[l_ac].stak011,g_stak_d[l_ac].stak012,
                  g_stak_d[l_ac].stak013,g_stak_d[l_ac].stak014,g_stak_d[l_ac].stak015,
                  g_stak_d[l_ac].stak016,g_stak_d[l_ac].stak017,g_stak_d[l_ac].stak018,g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021


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
PUBLIC FUNCTION astt301_stak009_ref()
  
  INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stak_d[l_ac].stak009
   CALL ap_ref_array2(g_ref_fields,"SELECT stabl003 FROM stabl_t WHERE stablent='"||g_enterprise||"' AND stabl001=? AND stabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stak_d[l_ac].stak009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stak_d[l_ac].stak009_desc
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
PUBLIC FUNCTION astt301_stak010_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stak_d[l_ac].stak010
   CALL ap_ref_array2(g_ref_fields,"SELECT stabl003 FROM stabl_t WHERE stablent='"||g_enterprise||"' AND stabl001=? AND stabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stak_d[l_ac].stak010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stak_d[l_ac].stak010_desc
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
PUBLIC FUNCTION astt301_stak017_018_chk()
DEFINE l_n  LIKE type_t.num5
   
   LET l_n = 0
   IF cl_null(g_staj_m.staj033) THEN    #add by yangxf 
      IF g_stak_d[l_ac].stak017 < g_staj_m.staj017 OR g_stak_d[l_ac].stak017 > g_staj_m.staj018 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00032'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         RETURN FALSE
      END IF
   
      IF g_stak_d[l_ac].stak018 < g_staj_m.staj017 OR g_stak_d[l_ac].stak018 > g_staj_m.staj018 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00032'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         RETURN FALSE
      END IF
   END IF    #add by yangxf 
   IF NOT cl_null(g_stak_d[l_ac].stak017) AND NOT cl_null(g_stak_d[l_ac].stak018) THEN
      IF g_stak_d[l_ac].stak017 > g_stak_d[l_ac].stak018 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aoo-00122'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   
  # IF NOT cl_null(g_stak_d[l_ac].stak017) AND NOT cl_null(g_stak_d[l_ac].stak018) AND NOT cl_null(g_stak_d[l_ac].stakseq) AND NOT cl_null(g_stak_d[l_ac].stak003)THEN
  #   SELECT COUNT(*) INTO l_n FROM stak_t 
  #    WHERE stakdocno = g_staj_m.stajdocno
  #      AND stak003 = g_stak_d[l_ac].stak003
  #      AND stakseq <> g_stak_d[l_ac].stakseq
  #      AND ((stak017 between g_stak_d[l_ac].stak017 AND g_stak_d[l_ac].stak018)
  #       OR (stak018 between g_stak_d[l_ac].stak017 AND g_stak_d[l_ac].stak018)
  #       OR (g_stak_d[l_ac].stak017 between stak017 AND stak018  )
  #       OR (g_stak_d[l_ac].stak018 between stak017 AND stak018  ))         
  # END IF      
  # IF l_n > 0 THEN
  #    INITIALIZE g_errparam TO NULL
  #    LET g_errparam.code = 'ast-00031'
  #    LET g_errparam.extend = ''
  #    LET g_errparam.popup = TRUE
  #    CALL cl_err()
  #
  #    RETURN FALSE
  # ELSE
  #    RETURN TRUE 
  # END IF
#   IF astt301_rtao_chk(g_stak_d[l_ac].stakseq) THEN      #add by yangxf         
#      CALL astt301_cal_nextd() RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#   #add by yangxf ---start---
#   ELSE
#      CALL s_astt301_cal_nextd_2(g_stak_d[l_ac].stak007,g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak017,g_stak_d[l_ac].stak018,'Y',g_staj_m.stajdocno)
#           RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#   END IF 
#   #add by yangxf ----end----
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
PUBLIC FUNCTION astt301_staj017_018_chk(p_cmd,p_field)
DEFINE p_cmd       LIKE type_t.chr1
DEFINE p_field     STRING
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_stax003   LIKE stax_t.stax003

   IF NOT cl_null(g_staj_m.staj017) AND NOT cl_null(g_staj_m.staj018) THEN
      IF g_staj_m.staj017 >g_staj_m.staj018 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'aoo-00122'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN FALSE
      END IF
   END IF
#mark by yangxf ---start----
#     #判断生效日期，不可大于单身的生效日期
#   IF p_field = 'staj017' THEN  
#      IF p_cmd = 'u' THEN
#         LET l_cnt = 0
#         SELECT COUNT(*) INTO l_cnt
#           FROM stak_t
#          WHERE stakent = g_enterprise
#            AND stakdocno = g_staj_m.stajdocno
#            AND stak017 < g_staj_m.staj017
#         IF l_cnt > 0 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'ast-00032'
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#         
#            RETURN FALSE
#         END IF
#      ELSE
#         IF g_staj_m.staj000 = 'U' THEN
#            LET l_cnt = 0
#            SELECT COUNT(*) INTO l_cnt
#              FROM stao_t
#             WHERE staoent = g_enterprise
#               AND stao001 = g_staj_m.staj001
#               AND stao017 < g_staj_m.staj017
#            IF l_cnt > 0 THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'ast-00263'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#            
#               RETURN FALSE
#            END IF
#            
#         END IF 
#          
#      END IF
#   END IF
#   
#   #判断失效日期，不可小于单身的失效日期
#   IF p_field = 'staj018' THEN
#      IF p_cmd = 'u' THEN
#         LET l_cnt = 0
#         SELECT COUNT(*) INTO l_cnt
#           FROM stak_t
#          WHERE stakent = g_enterprise
#            AND stakdocno = g_staj_m.stajdocno
#            AND stak018 > g_staj_m.staj018
#         IF l_cnt > 0 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'ast-00032'
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#        
#            RETURN FALSE
#         END IF
#      ELSE
#         IF g_staj_m.staj000 = 'U' THEN
#            LET l_cnt = 0
#            SELECT COUNT(*) INTO l_cnt
#              FROM stao_t
#             WHERE staoent = g_enterprise
#               AND stao001 = g_staj_m.staj001
#               AND stao018 > g_staj_m.staj018
#            IF l_cnt > 0 THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'ast-00263'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#            
#               RETURN FALSE
#            END IF
#            
#         END IF 
#      END IF
#   END IF
#mark by yangxf ----end----
   
    #U修改合同时，判断失效日期，不可小于最小已结算帐期的截止日期
#   LET l_stax003 = NULL
#   IF (g_staj_m.staj000 = 'U' OR g_staj_m.staj000 = 'R') AND NOT cl_null( g_staj_m.staj001) THEN
#      SELECT stax003 INTO l_stax003 FROM stax_t 
#       WHERE staxent = g_enterprise AND stax001 = g_staj_m.staj001 
#         AND staxseq = ( SELECT MAX(staxseq) FROM stax_t
#                          WHERE staxent = g_enterprise AND stax001 = g_staj_m.staj001
#                            AND stax005 = 'Y' )
#      IF SQLCA.sqlcode = 100 THEN LET l_stax003 = NULL END IF
#      IF g_staj_m.staj018 < l_stax003 AND g_staj_m.staj000 = 'U' THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'ast-00140'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         RETURN FALSE
#      END IF
#   END IF
   
   #如果生效/失效日期/结算方式有修改，自动算下次计算日

#   IF NOT cl_null(g_staj_m.staj017) AND NOT cl_NULL(g_staj_m.staj018) AND NOT cl_null(g_staj_m.staj009) THEN
#      IF cl_null(g_staj_m_o.staj017) OR 
#         g_staj_m.staj017 <> g_staj_m_o.staj017 OR g_staj_m.staj018 <> g_staj_m_o.staj018 OR
#         g_staj_m.staj009 <> g_staj_m_o.staj009 THEN
#         IF NOT cl_null(l_stax003) THEN #表示已经有结算，已结算部分的帐期不可以异动
#            LET g_staj_m.next_b = astt301_get_nextdate(g_staj_m.staj009,l_stax003+1,g_staj_m.staj018)
#         ELSE
#            LET g_staj_m.next_b = astt301_get_nextdate(g_staj_m.staj009,g_staj_m.staj017,g_staj_m.staj018)
#         END IF
#      END IF
#      DISPLAY g_staj_m.next_b TO next_b
#      LET g_staj_m_o.staj017 = g_staj_m.staj017
#      LET g_staj_m_o.staj018 = g_staj_m.staj018
#      LET g_staj_m_o.staj009 = g_staj_m.staj009
#   END IF
   
   
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
PUBLIC FUNCTION astt301_stajsite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.stajsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_staj_m.stajsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.stajsite_desc
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
PUBLIC FUNCTION astt301_init_required(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1
   CALL cl_set_comp_required("stak006,stak007,stak008,stak009,stak010,stak011,stak013,stak016,stak017,stak018",TRUE)
   CALL cl_set_comp_required("stak004,stak012,stak014,stak015",FALSE)
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
PUBLIC FUNCTION astt301_interval_chk(p_cmd)
DEFINE l_n       LIKE type_t.num5
DEFINE p_cmd     LIKE type_t.chr1

  IF g_staj_m.staj000 = 'I' AND (p_cmd = 'a' OR  p_cmd = 'r' ) THEN

   #  SELECT COUNT(*) INTO l_n FROM stan_t
   #   WHERE stanent = g_enterprise AND stan002 = g_staj_m.staj002 
   #     AND stan005 = g_staj_m.staj005 
   #     AND (stan017 BETWEEN g_staj_m.staj017 AND g_staj_m.staj018
   #          OR stan018 BETWEEN g_staj_m.staj017 AND g_staj_m.staj018
   #          OR g_staj_m.staj017 BETWEEN stan017 AND stan018
   #          OR g_staj_m.staj018 BETWEEN stan017 AND stan018)
   #     AND stanstus = 'Y'

  ELSE
    IF g_staj_m.staj000 = 'U' AND p_cmd = 'a' THEN
       SELECT COUNT(stan001) INTO l_n FROM stan_t LEFT OUTER JOIN staq_t ON stanent = staqent AND stan001 = staq001
        WHERE stanent = g_enterprise AND stan002 = g_staj_m.staj002 
          AND stan005 = g_staj_m.staj005 
          AND (stan017 BETWEEN g_staj_m.staj017 AND g_staj_m.staj018
               OR stan018 BETWEEN g_staj_m.staj017 AND g_staj_m.staj018
               OR g_staj_m.staj017 BETWEEN stan017 AND stan018
               OR g_staj_m.staj018 BETWEEN stan017 AND stan018)
          AND stan001 <>  g_staj_m.staj001
          AND stanstus = 'Y'
          AND staq003 IN (SELECT staq003 FROM staq_t WHERE staqent = g_enterprise AND staq001 = g_staj_m.staj001)
    ELSE
       SELECT COUNT(stan001) INTO l_n FROM stan_t LEFT OUTER JOIN staq_t ON stanent = staqent AND stan001 = staq001
        WHERE stanent = g_enterprise AND stan002 = g_staj_m.staj002 
          AND stan005 = g_staj_m.staj005 
          AND (stan017 BETWEEN g_staj_m.staj017 AND g_staj_m.staj018
               OR stan018 BETWEEN g_staj_m.staj017 AND g_staj_m.staj018
               OR g_staj_m.staj017 BETWEEN stan017 AND stan018
               OR g_staj_m.staj018 BETWEEN stan017 AND stan018)
          AND stan001 <>  g_staj_m.staj001
          AND stanstus = 'Y'
          AND staq003 IN (SELECT stam003 FROM stam_t WHERE stament = g_enterprise AND stamdocno = g_staj_m.stajdocno)
     END IF
       
  END IF
#mark by yangxf ---start---
#   IF l_n > 0 THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'ast-00036'
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#
#      RETURN FALSE
#   END IF
#mark by yangxf ---end---
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
PUBLIC FUNCTION astt301_init_entry(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1

   CALL cl_set_comp_entry("stak004,stak006,stak007,stak008,stak009,stak010,stak011,stak012,stak013,stak014,stak015,stak016,stak017,stak018",TRUE)
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
PUBLIC FUNCTION astt301_staj008_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_staj_m.staj008
   CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_staj_m.staj008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_staj_m.staj008_desc
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
PUBLIC FUNCTION astt301_clear()
DEFINE l_staj   type_g_staj_m

   LET l_staj.* = g_staj_m.*  
   INITIALIZE g_staj_m.* TO NULL
   LET g_staj_m_o.staj001 = ''

   LET g_staj_m.stajsite = g_site
   CALL astt301_stajsite_ref()
   LET g_staj_m.stajunit = g_site
   LET g_staj_m.stajdocdt = l_staj.stajdocdt
   LET g_staj_m.stajdocno = l_staj.stajdocno
   LET g_staj_m.staj000 = l_staj.staj000
   LET g_staj_m.stajownid = g_user
   LET g_staj_m.stajowndp = g_dept
   LET g_staj_m.stajcrtid = g_user
   LET g_staj_m.stajcrtdp = g_dept 
   LET g_staj_m.stajcrtdt = cl_get_current()
   LET g_staj_m.stajmodid = ""
   LET g_staj_m.stajmoddt = ""
   LET g_staj_m.stajstus = "N" 
   
      
   IF g_staj_m.staj000 = 'I' THEN
      LET g_staj_m.staj003 = 1
      LET g_staj_m.staj002 = '1'
      LET g_staj_m.staj012 = cl_get_current()
      SELECT ooef017 INTO g_staj_m.staj013 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_staj_m.stajsite
      CALL astt301_staj013_ref()
      LET g_staj_m.staj011 = 'N'

      LET g_staj_m.staj014 = g_user
      CALL astt301_staj014_ref()
   END IF
   

   CLEAR FORM
   CALL g_stak_d.clear()   
   CALL g_stak2_d.clear()  
   CALL g_stal_d.clear()
   CALL g_staw_d.clear()
   CALL g_stak3_d.clear() 
   CALL g_stak4_d.clear() 
   CALL g_stay_d.clear() 
   CALL g_stay1_d.clear()   
   DELETE FROM stak_t WHERE stakent = g_enterprise AND stakdocno = l_staj.stajdocno
   DELETE FROM stal_t WHERE stalent = g_enterprise AND staldocno = l_staj.stajdocno
   DELETE FROM stam_t WHERE stament = g_enterprise AND stamdocno = l_staj.stajdocno
   DELETE FROM staw_t WHERE stawent = g_enterprise AND stawdocno = l_staj.stajdocno 
   DELETE FROM stbj_t WHERE stbjent = g_enterprise AND stbjdocno = l_staj.stajdocno
   DELETE FROM stbn_t WHERE stbnent = g_enterprise AND stbndocno = l_staj.stajdocno  
   DELETE FROM stay_t WHERE stayent = g_enterprise AND staydocno = l_staj.stajdocno 
   
   LET g_bfill = 'N'   
   CALL astt301_show()
   LET g_bfill = 'Y'   
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
PRIVATE FUNCTION astt301_get_nextdate(p_staj009,p_date1,p_date2)
DEFINE p_staj009   LIKE staj_t.staj009
DEFINE p_date1     LIKE stca_t.stca017
DEFINE p_date2     LIKE stca_t.stca018
DEFINE r_nextdate  LIKE stca_t.stca017
DEFINE l_staa002   LIKE staa_t.staa002
DEFINE l_staa003   LIKE staa_t.staa003
DEFINE l_staa004   LIKE staa_t.staa004
DEFINE l_staa005   LIKE staa_t.staa005
DEFINE l_date      LIKE type_t.dat
DEFINE l_c         LIKE type_t.num5

   IF cl_null(p_staj009) OR cl_null(p_date1) OR cl_null(p_date2) THEN
      RETURN ''
   END IF
   
   SELECT staa002,staa003,staa004,staa005 INTO l_staa002,l_staa003,l_staa004,l_staa005
     FROM staa_t
    WHERE staa001 = p_staj009
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
         #LET r_nextdate = s_date_get_date(l_date,0,l_staa003-1)
         IF l_staa005 >0 THEN
            #加入月拆分期的计算
            #例:加天为7 月拆分为4   2月1-28 最后一期为2月22-2月28 最后一期7天
            #例:加天为7 月拆分为4   8月1-31 最后一期为8月22-8月31 最后一期10天      
            CALL s_astt301_cal_nextb(l_date,l_staa003,l_staa005) RETURNING l_date,r_nextdate,l_c
         ELSE
            LET r_nextdate = s_date_get_date(l_date,0,l_staa003-1)
         END IF                       
      END IF
   END IF
   IF l_staa004 = '2' AND l_staa005 =0 THEN
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
PRIVATE FUNCTION astt301_cal_nextd()
DEFINE p_stcf006   LIKE stcf_t.stcf006
DEFINE p_stcf007   LIKE stcf_t.stcf007
DEFINE p_stcf016   LIKE stcf_t.stcf016
DEFINE p_stcf017   LIKE stcf_t.stcf017
DEFINE p_begin     LIKE type_t.dat
DEFINE p_end       LIKE type_t.dat
DEFINE r_nextd     LIKE type_t.dat
DEFINE r_begin     LIKE type_t.dat
DEFINE r_end       LIKE type_t.dat
DEFINE l_stak020   LIKE stak_t.stak020
DEFINE l_stao020   LIKE stao_t.stao020    #add by yangxf

  
#  IF  NOT cl_null(g_stak_d[l_ac].stak007) AND NOT cl_null(g_stak_d[l_ac].stak008) AND NOT cl_null(g_stak_d[l_ac].stak017) AND NOT cl_null(g_stak_d[l_ac].stak018) THEN
#     #如果是U:修改，已有部分费用已结算，且修改了失效日期
#     IF astt301_chk_astm301_jiesuan(g_stak_d[l_ac].stakseq) THEN
#        IF astt301_chk_astm301_jiesuan_end(g_stak_d[l_ac].stakseq) THEN
#           LET g_stak_d[l_ac].stak019 = NULL
#           LET g_stak_d[l_ac].stak020 = NULL
#           LET g_stak_d[l_ac].stak021 = NULL
#           RETURN g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#        ELSE
#           IF g_stak_d[l_ac].stak018 = g_stak_d[l_ac].stak020 - 1 THEN
#              LET g_stak_d[l_ac].stak019 = NULL
#              LET g_stak_d[l_ac].stak020 = NULL
#              LET g_stak_d[l_ac].stak021 = NULL
#              RETURN g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#           END IF           
#        END IF
#        IF g_stak_d[l_ac].stak018 <> g_stak_d_t.stak018 OR #g_stcb_d[l_ac].stcb005 <> g_stcb_d_t.stcb005 OR 
#           g_stak_d[l_ac].stak007 <> g_stak_d_t.stak007 OR g_stak_d[l_ac].stak008 <> g_stak_d_t.stak008 THEN
#           
#              IF cl_null(g_stak_d_t.stak020) THEN
#                 LET l_stak020 = g_stak_d_t.stak018+1
#              ELSE
#                 LET l_stak020 =  g_stak_d_t.stak020
#              END IF
#              CALL s_astt301_cal_nextd(g_stak_d[l_ac].stak007,g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak017,g_stak_d[l_ac].stak018,l_stak020,'',g_staj_m.stajdocno)
#                   RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#        ELSE
#           LET g_stak_d[l_ac].stak019 = g_stak_d_t.stak019
#           LET g_stak_d[l_ac].stak020 = g_stak_d_t.stak020
#           LET g_stak_d[l_ac].stak021 = g_stak_d_t.stak021
#        END IF
#      ELSE
#      #否则正常计算下次计算日、下次费用开始日stcb019和下次费用截止日stcb020
#         CALL s_astt301_cal_nextd(g_stak_d[l_ac].stak007,g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak017,g_stak_d[l_ac].stak018,'','',g_staj_m.stajdocno)
#            RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#      END IF   
     #add by yangxf ----start---
#     LET l_stao020 = ''
#     SELECT stao020 INTO l_stao020
#       FROM stao_t 
#      WHERE staoent = g_enterprise
#        AND stao001 = g_staj_m.staj001
#        AND stao002 = g_stak_d[l_ac].stakseq
#     IF NOT cl_null(l_stao020) THEN 
#        CALL s_astt301_cal_nextd(g_stak_d[l_ac].stak007,g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak017,g_stak_d[l_ac].stak018,l_stao020,'','Y',g_staj_m.stajdocno)
#             RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#     ELSE
#        CALL s_astt301_cal_nextd(g_stak_d[l_ac].stak007,g_stak_d[l_ac].stak008,g_stak_d[l_ac].stak017,g_stak_d[l_ac].stak018,'','','Y',g_staj_m.stajdocno)
#             RETURNING g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021
#     END IF 
#     #add by yangxf ---end----
#  ELSE
#      RETURN '','',''
#  END IF
#  
#   RETURN g_stak_d[l_ac].stak019,g_stak_d[l_ac].stak020,g_stak_d[l_ac].stak021


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
PRIVATE FUNCTION astt301_chk_b()
DEFINE l_stawseq LIKE staw_t.stawseq
DEFINE l_staxseq LIKE stax_t.staxseq
#DEFINE l_stao  RECORD LIKE stao_t.*  #161111-00028#3--mark
#DEFINE l_stak  RECORD LIKE stak_t.*  #161111-00028#3--mark

#   IF g_staj_m.staj000 = 'U' THEN
   
#      DECLARE sel_stak CURSOR  FOR  SELECT * FROM stak_t
#                                 WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno 
#      FOREACH sel_stak INTO l_stak.*
#        SELECT * INTO l_stao.* FROM stao_t
#         WHERE staoent = g_enterprise AND stao001 = g_staj_m.staj001 AND stao002 =l_stak.stakseq
#            
#        #单身有一笔资料的下次费用开始日与astm601不一致，提示
#        IF astt301_chk_astm301_jiesuan(l_stak.stakseq) AND (l_stak.stak020 <> l_stao.stao020 OR (NOT cl_null(l_stak.stak020) AND cl_null(l_stao.stao020))) THEN
#           INITIALIZE g_errparam TO NULL
#           LET g_errparam.code = 'ast-00257'
#           LET g_errparam.extend = ''
#           LET g_errparam.popup = TRUE
#           CALL cl_err()
#           RETURN FALSE            
#        END IF
#     END FOREACH
    
    
    
#     SELECT NVL(MAX(stawseq),0) INTO l_stawseq FROM staw_t
#       WHERE stawent = g_enterprise AND stawdocno = g_staj_m.stajdocno AND staw005 = 'Y'
#      
#      SELECT NVL(MAX(staxseq),0) INTO l_staxseq FROM stax_t
#       WHERE staxent = g_enterprise AND stax001 = g_staj_m.staj001 AND stax005 = 'Y'
#      
#      IF l_stawseq <> l_staxseq THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'ast-00202'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         RETURN FALSE  
#      END IF
#   END IF  

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
PRIVATE FUNCTION astt301_upd_staw(p_cmd)
DEFINE p_cmd       LIKE type_t.chr1
DEFINE r_success   LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_stan009   LIKE stan_t.stan009
DEFINE l_stan017   LIKE stan_t.stan017
DEFINE l_stan018   LIKE stan_t.stan018
DEFINE l_stax004   LIKE stax_t.stax004
DEFINE l_stan031   LIKE stan_t.stan031
DEFINE l_enddate   LIKE stan_t.stan018

   LET r_success = TRUE
   #如果结算方式、生失效日期、下次计算日有异动才提示是否删除为结算帐期，重新产生帐期
   IF p_cmd = 'a' AND (g_staj_m.staj000 = 'U') THEN   
      SELECT stan009,stan017,stan018,stan031 INTO l_stan009,l_stan017,l_stan018,l_stan031
       FROM stan_t
      WHERE stanent = g_enterprise
        AND stan001 = g_staj_m.staj001
      SELECT MIN(stax004) INTO l_stax004 FROM stax_t
       WHERE staxent = g_enterprise
         AND stax001 = g_staj_m.staj001
         AND stax005 = 'N'
      IF g_staj_m.staj009 <> l_stan009 OR g_staj_m.staj017 <> l_stan017 OR
         (g_staj_m.staj018 <> l_stan018 AND cl_null(g_staj_m.staj033) AND cl_null(l_stan031)) OR
         (NOT cl_null(g_staj_m.staj033) AND cl_null(l_stan031)) OR (cl_null(g_staj_m.staj033) AND NOT cl_null(l_stan031)) OR
         (NOT cl_null(g_staj_m.staj033) AND NOT cl_null(l_stan031) AND g_staj_m.staj033 <> l_stan031)  THEN
         IF NOT cl_ask_confirm('ast-00146') THEN
            LET r_success = FALSE
         END IF
      ELSE
         #没有变，不用更新单身帐期
         RETURN TRUE
      END IF
   END IF
   
   IF p_cmd = 'u'  THEN
      IF g_staj_m.staj009 <> g_staj_m_t.staj009 OR g_staj_m.staj017 <> g_staj_m_t.staj017 OR
         (g_staj_m.staj018 <> g_staj_m_t.staj018 AND cl_null(g_staj_m.staj033) AND cl_null(g_staj_m_t.staj033)) OR
         (NOT cl_null(g_staj_m.staj033) AND cl_null(g_staj_m_t.staj033)) OR (cl_null(g_staj_m.staj033) AND NOT cl_null(g_staj_m_t.staj033)) OR
         (NOT cl_null(g_staj_m.staj033) AND NOT cl_null(g_staj_m_t.staj033) AND g_staj_m.staj033 <> g_staj_m_t.staj033)  THEN

         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM staw_t
          WHERE stawent = g_enterprise AND stawdocno = g_staj_m.stajdocno
            AND staw005 = 'Y'
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
      IF cl_null(g_staj_m.staj033) THEN
         LET l_enddate = g_staj_m.staj018
      ELSE
         LET l_enddate = g_staj_m.staj033
      END IF
   
      IF NOT s_astt301_cal_period(g_staj_m.stajdocno,g_staj_m.staj001,g_staj_m.staj017,l_enddate,g_staj_m.staj009,'',g_staj_m.stajsite,g_staj_m.stajunit) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00049'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      #add by yangxf ---start---
      IF r_success THEN 
         LET g_period_flag = 'Y'
      END IF 
      #add by yangxf ---end----
   END IF
   
   IF r_success = FALSE THEN
      IF p_cmd = 'a' AND g_staj_m.staj000 = 'U' THEN
         LET g_staj_m.staj009 = l_stan009
         LET g_staj_m.staj017 = l_stan017
         LET g_staj_m.staj018 = l_stan018
         LET g_staj_m.staj033 = l_stan031
      ELSE
         LET g_staj_m.staj009 = g_staj_m_t.staj009
         LET g_staj_m.staj017 = g_staj_m_t.staj017
         LET g_staj_m.staj018 = g_staj_m_t.staj018
         LET g_staj_m.staj033 = g_staj_m_t.staj033      
      END IF
   ELSE
      CALL astt301_b_fill()
   END IF
   DISPLAY BY NAME g_staj_m.staj009,g_staj_m.staj017,g_staj_m.staj018,g_staj_m.staj033
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
PRIVATE FUNCTION astt301_chk_astm301_jiesuan(p_stakseq)
DEFINE p_stakseq    LIKE stak_t.stakseq
#DEFINE l_stao  RECORD LIKE stao_t.* #161111-00028#3--mark
#161111-00028#3--add----begin-------
DEFINE l_stao RECORD  #自營合約費用設定檔
       staoent LIKE stao_t.staoent, #企業編號
       stao001 LIKE stao_t.stao001, #合約編號
       stao002 LIKE stao_t.stao002, #項次
       stao003 LIKE stao_t.stao003, #費用編號
       stao004 LIKE stao_t.stao004, #會計期間
       stao005 LIKE stao_t.stao005, #價款類別
       stao006 LIKE stao_t.stao006, #計算類型
       stao007 LIKE stao_t.stao007, #費用週期
       stao008 LIKE stao_t.stao008, #費用週期方式
       stao009 LIKE stao_t.stao009, #條件基準
       stao010 LIKE stao_t.stao010, #計算基準
       stao011 LIKE stao_t.stao011, #費用淨額
       stao012 LIKE stao_t.stao012, #費用比率
       stao013 LIKE stao_t.stao013, #保底否
       stao014 LIKE stao_t.stao014, #保底金額
       stao015 LIKE stao_t.stao015, #保底扣率
       stao016 LIKE stao_t.stao016, #分量扣點
       stao017 LIKE stao_t.stao017, #生效日期
       stao018 LIKE stao_t.stao018, #失效日期
       stao019 LIKE stao_t.stao019, #下次計算日
       stao020 LIKE stao_t.stao020, #下次費用開始日
       stao021 LIKE stao_t.stao021, #下次費用截止日
       stao022 LIKE stao_t.stao022, #自定義範圍
       stao023 LIKE stao_t.stao023, #納入結算單否
       stao024 LIKE stao_t.stao024, #票扣否
       stao025 LIKE stao_t.stao025, #管理品類
       stao026 LIKE stao_t.stao026, #生效月份
       stao027 LIKE stao_t.stao027, #按自然月計費否
       staoacti LIKE stao_t.staoacti, #有效
       stao028 LIKE stao_t.stao028, #固定費用是否按法人收取
       stao029 LIKE stao_t.stao029, #促銷扣率
       stao030 LIKE stao_t.stao030  #促銷銷售額占比
       END RECORD
#161111-00028#3--add----end---------


   INITIALIZE l_stao.* TO NULL
   
   IF g_staj_m.staj000 = 'U' OR g_staj_m.staj000 = 'R' THEN
      
    # SELECT * INTO l_stao.*   #161111-00028#3--mark
    #161111-00028#3--add---begin--------
      SELECT staoent,stao001,stao002,stao003,stao004,stao005,stao006,stao007,stao008,stao009,stao010,
             stao011,stao012,stao013,stao014,stao015,stao016,stao017,stao018,stao019,stao020,stao021,
             stao022,stao023,stao024,stao025,stao026,stao027,staoacti,stao028,stao029,stao030 INTO l_stao.*
    #161111-00028#3--add---end----------
      FROM stao_t
       WHERE staoent = g_enterprise AND stao001 = g_staj_m.staj001 AND stao002 = p_stakseq
     
      IF NOT cl_null(l_stao.stao017) AND NOT cl_null(l_stao.stao020) THEN       
         #看astm301有结算与否
         IF l_stao.stao017 = l_stao.stao020 THEN
            #未结算
            RETURN FALSE         
         ELSE   
            #有结算
            RETURN TRUE
         END IF
      ELSE 
         IF NOT cl_null(l_stao.stao017) AND cl_null(l_stao.stao020) THEN        
            #有结算
            RETURN TRUE 
         ELSE
             #未结算
            RETURN FALSE  
         END IF         
      END IF

   ELSE
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
PRIVATE FUNCTION astt301_chk_astm301_jiesuan_end(p_stakseq)
DEFINE p_stakseq    LIKE stak_t.stakseq
#DEFINE l_stao  RECORD LIKE stao_t.* #161111-00028#3--mark
#161111-00028#3--add----begin-------
DEFINE l_stao RECORD  #自營合約費用設定檔
       staoent LIKE stao_t.staoent, #企業編號
       stao001 LIKE stao_t.stao001, #合約編號
       stao002 LIKE stao_t.stao002, #項次
       stao003 LIKE stao_t.stao003, #費用編號
       stao004 LIKE stao_t.stao004, #會計期間
       stao005 LIKE stao_t.stao005, #價款類別
       stao006 LIKE stao_t.stao006, #計算類型
       stao007 LIKE stao_t.stao007, #費用週期
       stao008 LIKE stao_t.stao008, #費用週期方式
       stao009 LIKE stao_t.stao009, #條件基準
       stao010 LIKE stao_t.stao010, #計算基準
       stao011 LIKE stao_t.stao011, #費用淨額
       stao012 LIKE stao_t.stao012, #費用比率
       stao013 LIKE stao_t.stao013, #保底否
       stao014 LIKE stao_t.stao014, #保底金額
       stao015 LIKE stao_t.stao015, #保底扣率
       stao016 LIKE stao_t.stao016, #分量扣點
       stao017 LIKE stao_t.stao017, #生效日期
       stao018 LIKE stao_t.stao018, #失效日期
       stao019 LIKE stao_t.stao019, #下次計算日
       stao020 LIKE stao_t.stao020, #下次費用開始日
       stao021 LIKE stao_t.stao021, #下次費用截止日
       stao022 LIKE stao_t.stao022, #自定義範圍
       stao023 LIKE stao_t.stao023, #納入結算單否
       stao024 LIKE stao_t.stao024, #票扣否
       stao025 LIKE stao_t.stao025, #管理品類
       stao026 LIKE stao_t.stao026, #生效月份
       stao027 LIKE stao_t.stao027, #按自然月計費否
       staoacti LIKE stao_t.staoacti, #有效
       stao028 LIKE stao_t.stao028, #固定費用是否按法人收取
       stao029 LIKE stao_t.stao029, #促銷扣率
       stao030 LIKE stao_t.stao030  #促銷銷售額占比
       END RECORD
#161111-00028#3--add----end---------


   INITIALIZE l_stao.* TO NULL
    
   IF astt301_chk_astm301_jiesuan(p_stakseq) THEN    
     #SELECT * INTO l_stao.*   #161111-00028#3--mark
     #161111-00028#3--add---begin--------
      SELECT staoent,stao001,stao002,stao003,stao004,stao005,stao006,stao007,stao008,stao009,stao010,
             stao011,stao012,stao013,stao014,stao015,stao016,stao017,stao018,stao019,stao020,stao021,
             stao022,stao023,stao024,stao025,stao026,stao027,staoacti,stao028,stao029,stao030 INTO l_stao.*
     #161111-00028#3--add---end----------
       FROM stao_t  
       WHERE staoent = g_enterprise AND stao001 = g_staj_m.staj001 AND stao002 = p_stakseq
     
      #看astm301有结算完毕
      IF cl_null(l_stao.stao020) AND cl_null(l_stao.stao021) THEN
         #结算完毕
         RETURN TRUE         
      ELSE   
         #未结算完
         RETURN FALSE
      END IF
   ELSE
      RETURN FALSE  
   END IF
END FUNCTION
#BPM提交
PRIVATE FUNCTION astt301_send()
   #add-point:send段define
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   #add-point:send段define(客製用)

   #end add-point 
 
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL astt301_show()
#   CALL astt301_set_pk_array()
   
   #add-point: 提交前的ADP
   #確認前檢核段
   #MOD BY zhujing 2015-6-16 添加报错消息
   CALL s_astt301_conf_chk(g_staj_m.stajdocno) RETURNING l_success,g_errno
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_staj_m.stajdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE astt301_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_staj_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_stak_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_stak2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_stal_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_staw_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP

   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL astt301_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL astt301_ui_headershow()
   CALL astt301_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION

PRIVATE FUNCTION astt301_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point
   #add-point:set_pk_array段define

   #end add-point
   
   #add-point:set_pk_array段之前

   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_staj_m.stajdocno
   LET g_pk_array[1].column = 'stajdocno'
 
   
   #add-point:set_pk_array段之後

   #end add-point  
   
END FUNCTION
#BPM抽单
PRIVATE FUNCTION astt301_draw_out()
   #add-point:draw段define

   #end add-point
   #add-point:draw段define

   #end add-point
 
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_row].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL astt301_ui_headershow()  
   CALL astt301_ui_detailshow()
 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 取供應商帳務資料
# Memo...........:
# Usage..........: CALL astt301_staj005_other()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/05/22 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_staj005_other()
DEFINE l_staj006   LIKE staj_t.staj006  #幣別   
DEFINE l_staj007   LIKE staj_t.staj007  #稅別
DEFINE l_staj008   LIKE staj_t.staj008  #付款方式
DEFINE l_staj024   LIKE staj_t.staj024  #交易條件
DEFINE l_staj025   LIKE staj_t.staj025  #發票類型
DEFINE l_staj029   LIKE staj_t.staj029  #內外購
DEFINE l_staj030   LIKE staj_t.staj030  #匯率計算基準
   
   SELECT pmab033,pmab034,pmab037,pmab053,pmab056,pmab057,pmab058
     INTO l_staj006,l_staj007,l_staj008,l_staj024,
          l_staj025,l_staj029,l_staj030
     FROM pmab_t
    WHERE pmabent = g_enterprise AND pmab001 = g_staj_m.staj005
      AND pmabsite = 'ALL'

    
    IF cl_null(g_staj_m.staj006) THEN
       LET g_staj_m.staj006 = l_staj006
    END IF
    IF cl_null(g_staj_m.staj007) THEN
       LET g_staj_m.staj007 = l_staj007
    END IF
    IF cl_null(g_staj_m.staj008) THEN
       LET g_staj_m.staj008 = l_staj008
    END IF
    LET g_staj_m.staj024 = l_staj024  
    LET g_staj_m.staj025 = l_staj025
    LET g_staj_m.staj029 = l_staj029
    LET g_staj_m.staj030 = l_staj030
    
    DISPLAY BY NAME g_staj_m.staj006,g_staj_m.staj007,g_staj_m.staj008,
                    g_staj_m.staj024,g_staj_m.staj025,g_staj_m.staj029,
                    g_staj_m.staj030
                    
    CALL astt301_staj006_ref()
    CALL astt301_staj007_ref()
    CALL astt301_staj008_ref()
    
    CALL s_desc_get_acc_desc('238',g_staj_m.staj024) 
      RETURNING g_staj_m.staj024_desc
    DISPLAY BY NAME g_staj_m.staj024_desc 
    CALL s_desc_get_invoice_type_desc1(g_site,g_staj_m.staj025) 
      RETURNING g_staj_m.staj025_desc
    DISPLAY BY NAME g_staj_m.staj025_desc     
    
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
PRIVATE FUNCTION astt301_stay004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stay_d[l_ac].stay004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stay_d[l_ac].stay004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stay_d[l_ac].stay004_desc
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
PRIVATE FUNCTION astt301_stay004_chk()
  INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = '1'
   LET g_chkparam.arg1 = g_stay_d[l_ac].stay004

 # IF NOT cl_chk_exist("v_ooef001_31") THEN  #161024-00025#6--mark
   IF NOT cl_chk_exist("v_ooef001_35") THEN  #161024-00025#6--add换成门店开窗检核
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
PRIVATE FUNCTION astt301_set_visible(p_ac)
DEFINE p_ac LIKE type_t.num5

    IF g_stak_d[p_ac].stak022 = '0' THEN
       CALL cl_set_comp_visible('group_6',FALSE)
    ELSE
       CALL cl_set_comp_visible('group_6',TRUE)
       IF g_stak_d[p_ac].stak022 = '1' THEN 
          CALL cl_set_comp_visible('s_detail5',TRUE)
          CALL cl_set_comp_visible('s_detail6',FALSE)       
       END IF
       IF g_stak_d[p_ac].stak022 = '2' THEN 
          CALL cl_set_comp_visible('s_detail5',FALSE)
          CALL cl_set_comp_visible('s_detail6',TRUE)       
       END IF
       IF g_stak_d[p_ac].stak022 = '3' THEN 
          CALL cl_set_comp_visible('s_detail5',TRUE)
          CALL cl_set_comp_visible('s_detail6',TRUE)       
       END IF       
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
PRIVATE FUNCTION astt301_staj033_chk()
    
    IF NOT cl_null(g_staj_m.staj018) AND NOT cl_null(g_staj_m.staj033)  THEN
       #失效日必须小于延期日
       IF g_staj_m.staj018 >= g_staj_m.staj033 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'ast-00342'
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
PRIVATE FUNCTION astt301_stak019_chk()
  
   #延期合同（延期日期不为空） 单身下次费用计算日 需要存在 单头生效日期 到 单头延期日期区间
   #正常合同（延期日期为空) 单身下次费用计算日 需要存在 单头生效日期 到 单头失效日期区间
   #if 延期 edate = 单头延期日期  else  edate = 单头失效日期
   # 判断下次费用计算日 在  单头生效日期和 edate 区间 
   
   #费用类型为年 下次费用计算日 只能是 单头生效日期和 edate 区间 的年初 或年末，若费用周期方式为期初，则为年初，否则为年末
   
   
   #费用类型为季
   
   #费用类型为月
   
   #费用类型为单次，让下次费用计算日随便录，下次费用开始 ，下次费用结束 给空
   
   
   
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
PRIVATE FUNCTION astt301_stay004_ins(p_cmd,p_str)
DEFINE p_cmd      LIKE type_t.chr1
DEFINE p_str     STRING
DEFINE l_token    base.StringTokenizer
DEFINE l_stay004  LIKE stay_t.stay004
DEFINE l_n        LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5

   IF cl_null(p_str) THEN
      RETURN 
   END IF
   IF p_cmd = 'u' THEN  

      DELETE FROM stay_t
       WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno 
         AND stayseq1 = g_stak_d[g_detail_idx].stakseq AND stayseq2 = g_stay_d[l_ac].stayseq2
   END IF
   LET l_token = base.StringTokenizer.create(p_str,"|")
   LET l_n = g_stay_d[l_ac].stayseq2
   
   WHILE l_token.hasMoreTokens()
      LET l_stay004 =l_token.nextToken()
      
      SELECT COUNT(*) INTO l_cnt FROM stay_t
       WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno 
         AND stayseq1 = g_stak_d[g_detail_idx].stakseq AND stay004 = l_stay004 AND stay002 = '1'
         
      IF l_cnt = 0 THEN
         INSERT INTO stay_t (stayent,staydocno,stayseq1,stayseq2,stay001,stay002,stay003,stay004) 
               VALUES (g_enterprise,g_staj_m.stajdocno,g_stak_d[g_detail_idx].stakseq,l_n,g_staj_m.staj001,1,'',l_stay004) 
         SELECT NVL(MAX(stayseq2)+1,1) INTO l_n FROM stay_t
          WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno AND stayseq1 = g_stak_d[g_detail_idx].stakseq
      END IF
         
   END WHILE
   
 
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
PRIVATE FUNCTION astt301_stay004_ins_1(p_cmd,p_str)
DEFINE p_cmd      LIKE type_t.chr1
DEFINE p_str     STRING
DEFINE l_token    base.StringTokenizer
DEFINE l_stay004  LIKE stay_t.stay004
DEFINE l_n        LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5

   IF cl_null(p_str) THEN
      RETURN 
   END IF
   IF p_cmd = 'u' THEN  
      DELETE FROM stay_t
       WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno 
         AND stayseq1 = g_stak_d[g_detail_idx].stakseq AND stayseq2 = g_stay1_d[l_ac].stayseq2
   END IF
   LET l_token = base.StringTokenizer.create(p_str,"|")
   LET l_n = g_stay1_d[l_ac].stayseq2
   
   WHILE l_token.hasMoreTokens()
      LET l_stay004 =l_token.nextToken()
      
      SELECT COUNT(*) INTO l_cnt FROM stay_t
       WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno 
         AND stayseq1 = g_stak_d[g_detail_idx].stakseq AND stay004 = l_stay004 AND stay002 = '2' AND stay003 = g_stay1_d[l_ac].stay003
         
      IF l_cnt = 0 THEN
         INSERT INTO stay_t (stayent,staydocno,stayseq1,stayseq2,stay001,stay002,stay005,stay003,stay004) 
               VALUES (g_enterprise,g_staj_m.stajdocno,g_stak_d[g_detail_idx].stakseq,l_n,g_staj_m.staj001,2,g_stay1_d[l_ac].stay005,g_stay1_d[l_ac].stay003,l_stay004) 
         SELECT NVL(MAX(stayseq2)+1,1) INTO l_n FROM stay_t
          WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno AND stayseq1 = g_stak_d[g_detail_idx].stakseq
      END IF
         
   END WHILE
     
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
PRIVATE FUNCTION astt301_stay003_chk()
DEFINE l_n         LIKE type_t.num5


   IF g_stay1_d[l_ac].stay003 = 'M' THEN
      SELECT COUNT(*) INTO l_n FROM stay_t 
       WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno AND stay003 <> 'M' 
         AND stayseq2 <> g_stay1_d[l_ac].stayseq2 AND stayseq1 = g_stak_d[g_detail_idx].stakseq
   END IF
   IF g_stay1_d[l_ac].stay003 = '12' THEN
      SELECT COUNT(*) INTO l_n FROM stay_t 
       WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno AND stay003 <> '12' 
         AND stayseq2 <> g_stay1_d[l_ac].stayseq2 AND stayseq1 = g_stak_d[g_detail_idx].stakseq  
   END IF
   IF g_stay1_d[l_ac].stay003 <> 'M' AND  g_stay1_d[l_ac].stay003 <> '12'  THEN
      SELECT COUNT(*) INTO l_n FROM stay_t 
       WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno AND (stay003 = '12' OR stay003 = 'M') 
          AND stayseq2 <> g_stay1_d[l_ac].stayseq2  AND stayseq1 = g_stak_d[g_detail_idx].stakseq
   END IF  
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00345'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()            
      RETURN FALSE 
   END IF
   
   IF NOT cl_null(g_stak_d[g_detail_idx].stak009) THEN
      IF NOT astt301_range_chk(g_stak_d[g_detail_idx].stak009) THEN
         RETURN FALSE
      END IF
   END IF
   
   IF NOT cl_null(g_stak_d[g_detail_idx].stak010) THEN
      IF NOT astt301_range_chk(g_stak_d[g_detail_idx].stak010) THEN
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
PRIVATE FUNCTION astt301_stand_chk(p_stab001)
DEFINE  p_stab001   LIKE stab_t.stab001
DEFINE  l_n         LIKE type_t.num5
DEFINE  l_stab012   LIKE stab_t.stab012

   SELECT stab012 INTO l_stab012 FROM stab_t
    WHERE stabent = g_enterprise AND stab001 = p_stab001

   IF l_stab012 = 'Y' THEN #勾选款别金额
      #判断单身是否含有非卡、非款别的资料
      SELECT COUNT(*) INTO l_n FROM stay_t
       WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno AND stayseq1 = g_stak_d[g_detail_idx].stakseq
         AND NOT (stay003 = 'M' OR stay003 = '12')            
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00346'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()  
         RETURN FALSE      
      END IF  
   ELSE
      #判断单身是否含有卡或者款别的资料
       SELECT COUNT(*) INTO l_n FROM stay_t
       WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno AND stayseq1 = g_stak_d[g_detail_idx].stakseq
         AND (stay003 = 'M' OR stay003 = '12')    
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00346'
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
PRIVATE FUNCTION astt301_range_chk(p_stab001)
DEFINE  p_stab001   LIKE stab_t.stab001
DEFINE  l_n         LIKE type_t.num5
DEFINE l_stab012   LIKE stab_t.stab012  
 
   SELECT stab012 INTO l_stab012 FROM stab_t WHERE stabent = g_enterprise AND stab001 = p_stab001
   IF l_stab012 = 'Y' THEN
      IF NOT (g_stay1_d[l_ac].stay003 = 'M' OR g_stay1_d[l_ac].stay003 = '12') THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00347'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()            
         RETURN FALSE  
      END IF         
   ELSE
      IF g_stay1_d[l_ac].stay003 = 'M' OR g_stay1_d[l_ac].stay003 = '12' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00347'
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
PRIVATE FUNCTION astt301_stak025_chk()
DEFINE l_ooaa002    LIKE ooaa_t.ooaa002
   
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002        
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_stak_d[l_ac].stak025
   LET g_chkparam.arg2 = l_ooaa002
   
   #160318-00025#37  2016/04/19  by pengxin  add(S)
   LET g_errshow = TRUE #是否開窗 
   LET g_chkparam.err_str[1] = "ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"
   #160318-00025#37  2016/04/19  by pengxin  add(E)
   
   IF NOT cl_chk_exist("v_rtax001_2") THEN
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
PRIVATE FUNCTION astt301_stak025_ref()
   SELECT rtaxl003 INTO g_stak_d[l_ac].stak025_desc
    FROM rtaxl_t
   WHERE rtaxlent = g_enterprise AND rtaxl001 = g_stak_d[l_ac].stak025 AND rtaxl002 = g_dlang
   
   DISPLAY BY NAME g_stak_d[l_ac].stak025_desc
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
PRIVATE FUNCTION astt301_stbn001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stak4_d[l_ac].stbn001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stak4_d[l_ac].stbn001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stak4_d[l_ac].stbn001_desc
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
PRIVATE FUNCTION astt301_stbn001_chk()
   INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = '1'
   LET g_chkparam.arg1 = g_stak4_d[l_ac].stbn001

 # IF NOT cl_chk_exist("v_ooef001_31") THEN  #161024-00025#6--mark
   IF NOT cl_chk_exist("v_ooef001_35") THEN  #161024-00025#6--add换成门店开窗检核
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL astt301_rtao_chk(p_stakseq)
# Input parameter: p_stakseq      项次
# Return code....: r_successs     状态
# Date & Author..: 2015/08/26 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_rtao_chk(p_stakseq)
DEFINE p_stakseq    LIKE stak_t.stakseq
DEFINE l_n          LIKE type_t.num10

   #新增原合同为空
   IF g_staj_m.staj000 = 'I' THEN
      RETURN TRUE   
   END IF 
   IF g_staj_m.staj000 = 'I' 
   OR g_staj_m.staj000 = 'U' OR g_staj_m.staj000 = 'R' THEN 
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM stao_t
       WHERE staoent = g_enterprise
         AND stao001 = g_staj_m.staj001
         AND stao002 = p_stakseq
      IF l_n > 0 THEN
         #存在主档   
         RETURN TRUE  
      ELSE
         #不存在主档
         RETURN FALSE
      END IF 
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 续期自动产生单身明细
# Memo...........:
# Usage..........: CALL astt301_staj001_genb_2()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/08/25 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_staj001_genb_2()
   DEFINE l_enddate   LIKE stan_t.stan018
   
   IF g_stak_d.getLength() > 0 OR g_stak2_d.getLength() > 0 OR g_stal_d.getLength() > 0 OR g_stak3_d.getLength() > 0 THEN
      IF NOT cl_ask_confirm('axm-00175') THEN     
         RETURN FALSE
      END IF
 
      DELETE FROM stak_t WHERE stakent = g_enterprise AND stakdocno = g_staj_m.stajdocno
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stak'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         RETURN FALSE
      END IF
      
      DELETE FROM stal_t WHERE stalent = g_enterprise AND staldocno = g_staj_m.stajdocno
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stal'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         RETURN FALSE
      END IF
      
      DELETE FROM stam_t WHERE stament = g_enterprise AND stamdocno = g_staj_m.stajdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stam'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         RETURN FALSE
      END IF
      IF g_staw_d.getLength() > 0 THEN 
         DELETE FROM staw_t WHERE stawent = g_enterprise AND stawdocno = g_staj_m.stajdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'del staw'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            RETURN FALSE
         END IF
      END IF              #add by yangxf
      DELETE FROM stay_t WHERE stayent = g_enterprise AND staydocno = g_staj_m.stajdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stay'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         RETURN FALSE
      END IF
      
      DELETE FROM stbj_t WHERE stbjent = g_enterprise AND stbjdocno = g_staj_m.stajdocno
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stbj'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         RETURN FALSE
      END IF
      DELETE FROM stbn_t WHERE stbnent = g_enterprise AND stbndocno = g_staj_m.stajdocno
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del stbn'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         RETURN FALSE
      END IF
   END IF 
   INSERT INTO stak_t(stakent,stakunit,staksite,stakdocno,stakseq,stakacti,stak003,stak004,stak005,stak006,
                     stak007,stak008,stak009,stak010,stak011,stak012,stak013,stak014,stak015,stak016,stak030,stak029,stak017,stak018,stak026,stak019,stak020,stak021,stak022,stak023,stak024,stak025,stak027,stak028)   
   SELECT staoent,g_staj_m.stajunit,g_staj_m.stajsite,g_staj_m.stajdocno,stao002,staoacti,stao003,stao004,stao005,stao006,
          stao007,stao008,stao009,stao010,stao011,stao012,stao013,stao014,stao015,stao016,stao030,stao029,stao017,stao018,stao026,stao019,stao020,stao021,stao022,stao023,stao024,stao025,stao027,stao028
     FROM stao_t 
    WHERE staoent = g_enterprise AND stao001 =g_staj_m.staj001 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stak'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   INSERT INTO stal_t(stalent,staldocno,stalseq1,stalseq2,stal004,stal005,stal006)
   SELECT stapent,g_staj_m.stajdocno,stap002,stap003,stap004,stap005,stap006
     FROM stap_t 
    WHERE stapent =   g_enterprise AND stap001 = g_staj_m.staj001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stal'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   INSERT INTO stam_t(stament,stamunit,stamsite,stamdocno,stamseq,stam003,stam004,stam005,stamacti)
   SELECT staqent,g_staj_m.stajunit,g_staj_m.stajsite,g_staj_m.stajdocno,staq002,staq003,staq004,staq005,staqacti
     FROM staq_t
    WHERE staqent = g_enterprise AND staq001 = g_staj_m.staj001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stam'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
    INSERT INTO stbj_t(stbjent,stbjsite,stbjunit,stbjdocno,stbjseq,stbj001)
    SELECT stbkent,g_staj_m.stajsite,g_staj_m.stajunit,g_staj_m.stajdocno,stbk002,stbk003 FROM stbk_t
     WHERE stbkent = g_enterprise AND stbk001 = g_staj_m.staj001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stbj'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF  
#   IF cl_null(g_staj_m.staj033) THEN
#      LET l_enddate = g_staj_m.staj018
#   ELSE
#      LET l_enddate = g_staj_m.staj033
#   END IF
#   IF NOT s_astt301_cal_period(g_staj_m.stajdocno,g_staj_m.staj001,g_staj_m.staj017,l_enddate,g_staj_m.staj009,g_staj_m.next_b,g_staj_m.stajsite,g_staj_m.stajunit) THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'ast-00049'
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      RETURN FALSE
#   END IF
   INSERT INTO stay_t(stayent,staydocno,stayseq1,stayseq2,stay001,stay002,stay005,stay003,stay004)
      SELECT stazent,g_staj_m.stajdocno,stazseq1,stazseq2,staz001,staz002,staz005,staz003,staz004 FROM staz_t
       WHERE stazent = g_enterprise AND staz001 =  g_staj_m.staj001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stay'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   INSERT INTO stbn_t(stbnent,stbnunit,stbnsite,stbndocno,stbnseq,stbn001,stbnacti)
   SELECT stboent,g_staj_m.stajunit,g_staj_m.stajsite,g_staj_m.stajdocno,stbo002,stbo003,stboacti
     FROM stbo_t
    WHERE stboent = g_enterprise AND stbo001 = g_staj_m.staj001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins stbn'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   INSERT INTO staw_t(stawent,stawsite,stawunit,stawdocno,stawseq,staw001,staw002,staw003,staw004,staw005,staw006,staw007)
     SELECT staxent,staxsite,staxunit,g_staj_m.stajdocno,staxseq,stax001,stax002,stax003,stax004,stax005,stax006,stax007
      FROM stax_t
     WHERE staxent = g_enterprise AND stax001 =  g_staj_m.staj001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins staw'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 更新单身费用周期为5.帐期的下次计算日期、下次开始日期、下次截止日期
# Memo...........:
# Usage..........: CALL astt301_stak_upd()
# Input parameter: 无
# Return code....: r_success   处理状态
# Date & Author..: 2015/08/29 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_stak_upd()
DEFINE l_staw002   LIKE staw_t.staw002
DEFINE l_staw003   LIKE staw_t.staw003
DEFINE l_staw004   LIKE staw_t.staw004
DEFINE l_stax002   LIKE stax_t.stax002
DEFINE l_stax003   LIKE stax_t.stax003
DEFINE l_stax004   LIKE stax_t.stax004

   IF g_period_flag = 'N' THEN 
      RETURN TRUE
   END IF 
   LET l_staw004 = ''
   LET l_staw003 = ''
   LET l_staw002 = ''
   LET l_stax004 = ''
   LET l_stax003 = ''
   LET l_stax002 = ''
   #获取最大已结算帐期的结算日期
   SELECT MAX(staw004) INTO l_staw004
     FROM staw_t
    WHERE stawent = g_enterprise
      AND stawdocno = g_staj_m.stajdocno
      AND staw005 = 'Y'
   IF NOT cl_null(l_staw004) THEN
      #获取截止日期
      SELECT staw003 INTO l_staw003
        FROM staw_t
       WHERE stawent = g_enterprise
         AND stawdocno = g_staj_m.stajdocno
         AND staw004 = l_staw004
      #下一帐期开始日期   
      LET l_staw002 = l_staw003 + 1
      SELECT staw002,staw003,staw004 
        INTO l_stax002,l_stax003,l_stax004
        FROM staw_t
       WHERE stawent = g_enterprise
         AND stawdocno = g_staj_m.stajdocno
         AND staw002 =  l_staw002
   ELSE 
      #抓取未结算最小结算日期
      SELECT MIN(staw004) INTO l_staw004
        FROM staw_t
       WHERE stawent = g_enterprise
         AND stawdocno = g_staj_m.stajdocno
         AND staw005 = 'N'
      SELECT staw002,staw003,staw004 
        INTO l_stax002,l_stax003,l_stax004
        FROM staw_t
       WHERE stawent = g_enterprise
         AND stawdocno = g_staj_m.stajdocno
         AND staw004 =  l_staw004
   END IF 
   
   UPDATE stak_t SET stak019 = l_stax004,
                     stak020 = l_stax002,
                     stak021 = l_stax003
    WHERE stakent = g_enterprise
      AND stakdocno = g_staj_m.stajdocno
      AND stak007 = '5'
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd stak_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()               
      RETURN FALSE
   END IF 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 批量新增单身
# Memo...........:
# Usage..........: CALL astt301_ins_stbn(p_wc)
# Input parameter: p_wc
# Return code....: 无
# Date & Author..: 2015/09/23 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_ins_stbn(p_wc)
DEFINE p_wc        STRING 
DEFINE l_sql       STRING
DEFINE l_str       STRING
DEFINE l_ooef001   LIKE ooef_t.ooef001
DEFINE l_stbnseq   LIKE stbn_t.stbnseq

   IF cl_null(p_wc) THEN 
      RETURN 
   END IF 
   CALL astt301_str_get(p_wc) RETURNING l_str
   LET l_sql = " SELECT ooef001 FROM ooef_t ",
               "  WHERE ooef001 IN(",l_str,")",
               "    AND ooefent = ",g_enterprise,
               "    AND NOT EXISTS(SELECT 1 FROM stbn_t ",
               "                    WHERE ooef001 = stbn001 ",
               "                      AND ooefent = stbnent ",
               "                      AND stbnent = ",g_enterprise,
               "                      AND stbndocno = '",g_staj_m.stajdocno,"'",
               ")"
   PREPARE sel_ooef FROM l_sql
   DECLARE sel_ooef_cs CURSOR FOR sel_ooef
   FOREACH sel_ooef_cs INTO l_ooef001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel_ooef_cs:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      SELECT MAX(stbnseq)+1 INTO l_stbnseq 
        FROM stbn_t
       WHERE stbnent = g_enterprise
         AND stbndocno = g_staj_m.stajdocno
      IF cl_null(l_stbnseq) THEN 
         LET l_stbnseq = 1
      END IF 
      INSERT INTO stbn_t(stbnent,stbnsite,stbnunit,stbndocno,stbnseq,stbn001,stbnacti)
       VALUES(g_enterprise,g_staj_m.stajsite,g_staj_m.stajunit,g_staj_m.stajdocno,l_stbnseq,l_ooef001,'Y')
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert stbn_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH 
   CALL astt301_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 重组SQL条件
# Memo...........:
# Usage..........: CALL astt301_str_get(p_wc)
# Input parameter: p_wc
# Return code....: r_str
# Date & Author..: 2015/09/23 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_str_get(p_wc)
DEFINE p_wc       STRING 
DEFINE r_str      STRING
DEFINE l_ooef001  LIKE ooef_t.ooef001
DEFINE tok        base.StringTokenizer

   LET tok = base.StringTokenizer.create(p_wc,"|")
   LET l_ooef001 = ""
   WHILE tok.hasMoreTokens()
       LET l_ooef001 = tok.nextToken()
       IF r_str IS NULL THEN
          LET r_str = "'",l_ooef001,"'"
       ELSE
          LET r_str = r_str,",'",l_ooef001,"'"
       END IF
   END WHILE
   RETURN r_str
END FUNCTION

################################################################################
# Descriptions...: 开窗获取生效月份
# Memo...........:
# Usage..........: CALL astt301_getstak026()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/10/09 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_getstak026()
DEFINE l_stak026_t   LIKE stak_t.stak026
DEFINE lwin_curr     ui.Window
DEFINE lfrm_curr     ui.Form
DEFINE ls_path       STRING
DEFINE l_flag        LIKE type_t.chr1
DEFINE l_stak026     LIKE stak_t.stak026
DEFINE l_str         STRING
DEFINE l_i           LIKE type_t.num10
DEFINE l_item        DYNAMIC ARRAY OF RECORD
            sel      LIKE type_t.chr1,
            b_month  LIKE type_t.num10   
                     END RECORD 

   WHENEVER ERROR CONTINUE
   
   LET l_stak026_t = g_stak_d[l_ac].stak026
   #畫面開啟 (identifier)
   OPEN WINDOW w_astt301_s01 WITH FORM cl_ap_formpath("ast","astt301_s01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL l_item.clear()
   FOR l_i = 1 TO 12
      IF l_stak026_t[l_i,l_i] = '1' THEN 
         LET l_item[l_i].sel = 'Y'
      ELSE
         LET l_item[l_i].sel = 'N'
      END IF 
      LET l_item[l_i].b_month = l_i
   END FOR 
   LET l_flag = 'N'
   WHILE TRUE 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         INPUT ARRAY l_item FROM s_detail1.*
               ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, 
                  INSERT ROW = TRUE, 
                  DELETE ROW = TRUE,
                  APPEND ROW = TRUE)
         BEFORE INPUT 
            LET g_rec_b = l_item.getLength()
            
         BEFORE INSERT 
            CANCEL INSERT 
            
         BEFORE DELETE
            CANCEL DELETE
            
         END INPUT 
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
         
         ON ACTION cancel
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         ON ACTION accept
            LET l_flag = 'Y'
            ACCEPT DIALOG
            
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
      IF g_action_choice = "exit" OR l_flag = 'Y' THEN
         EXIT WHILE
      END IF
    
   END WHILE
   CALL cl_set_act_visible("accept,cancel", TRUE)
   #畫面關閉
   CLOSE WINDOW w_astt301_s01 
   LET l_str = ''
   IF l_flag = 'Y' THEN 
      FOR l_i =1 TO 12
         IF l_item[l_i].sel = 'Y' THEN 
            IF cl_null(l_str) THEN 
               LET l_str = '1'
            ELSE
               LET l_str = l_str.trim(),'1'
            END IF 
         ELSE
            IF cl_null(l_str) THEN 
               LET l_str = '0'
            ELSE
               LET l_str = l_str.trim(),'0'
            END IF 
         END IF 
      END FOR 
      LET l_stak026 = l_str
      RETURN l_stak026
   ELSE
      RETURN l_stak026_t
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 更新纳入结算单否、票扣否
# Memo...........:
# Usage..........: CALL astt301_staj040_upd()
# Input parameter: 无
# Return code....: r_success
# Date & Author..: 2015/09/09 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_staj040_upd()
DEFINE l_stan037    LIKE stan_t.stan037

   SELECT stan037 INTO l_stan037
     FROM stan_t
    WHERE stanent = g_enterprise
      AND stan001 = g_stan_m.stan001
   IF cl_null(l_stan037) OR l_stan037 = g_staj_m.staj040 THEN 
      RETURN TRUE
   END IF 
   IF g_stak_d.getLength() > 0 THEN 
      IF cl_ask_confirm('ast-00453') THEN
         #更新费用明细页签
         UPDATE stak_t SET stak023 = CASE g_staj_m.staj040 WHEN 'Y' THEN 'N' ELSE 'Y'END ,
                           stak024 = (SELECT stae007 
                                        FROM stae_t  
                                       WHERE staeent = g_enterprise
                                         AND stae001 = stak003
                                         AND stakent = staeent 
                                         AND stakdocno = g_staj_m.stajdocno)
          WHERE stakent = g_enterprise
            AND stakdocno = g_staj_m.stajdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = g_staj_m.staj040
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF 
         #更新费用明细页签纳入结算单栏位为Y(当票扣否为Y)
         UPDATE stak_t SET stak023 = 'Y'
          WHERE stakent = g_enterprise
            AND stakdocno = g_staj_m.stajdocno
            AND stak024 = 'Y'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = g_staj_m.staj040
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF 
      END IF
   END IF 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 预设执行日期
# Memo...........:
# Usage..........: CALL astt301_get_staj039()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/10/22 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_get_staj039()
DEFINE l_stax004   LIKE stax_t.stax004
DEFINE l_date      LIKE type_t.dat

   LET l_date = ''
   LET l_stax004 = ''
   SELECT MAX(stax004) INTO l_stax004
     FROM stax_t
    WHERE staxent = g_enterprise
      AND stax001 = g_staj_m.staj001
      AND stax005 = 'Y'
   IF cl_null(l_stax004) THEN 
     SELECT MIN(stax002) INTO l_date
       FROM stax_t
      WHERE staxent = g_enterprise
        AND stax001 = g_staj_m.staj001
   ELSE
      LET l_date = l_stax004 + 1
   END IF 
   RETURN l_date
END FUNCTION

################################################################################
# Descriptions...: 部门检查
# Memo...........:
# Usage..........: 
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/11/30 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_staj041_chk()
DEFINE l_ooegstus  LIKE ooag_t.ooagstus
DEFINE l_n         LIKE type_t.num5
   LET g_errno = ''
   SELECT ooegstus INTO l_ooegstus
     FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = g_staj_m.staj041
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00352'
      WHEN l_ooegstus <> 'Y'   LET g_errno = 'art-00353'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      IF NOT cl_null(g_staj_m.staj014) THEN
         LET l_n = 0      
         SELECT COUNT(*) INTO l_n
           FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = g_staj_m.staj014 
            AND ooag003 = g_staj_m.staj041
         IF l_n = 0 THEN 
            LET g_errno = 'art-00224'
         END IF 
      END IF 
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
PRIVATE FUNCTION astt301_ins_stam(l_stam003)
DEFINE l_stam003 LIKE stam_t.stam003
DEFINE l_n   INT 
LET g_success = 'Y'
IF s_transaction_chk("N",0) THEN
    CALL s_transaction_begin()
 END IF
SELECT count(*) INTO l_n FROM stam_t WHERE stament=g_enterprise  AND stamdocno=g_staj_m.stajdocno
IF cl_null(l_n)  THEN 
   LET l_n=1
ELSE
   LET l_n=l_n+1
END IF 
INSERT INTO stam_t (stament,stamdocno,stamseq,stam003,stam004,stamacti,stam005,stamunit,stamsite) 
VALUES(g_enterprise,g_staj_m.stajdocno,l_n,l_stam003,'Y','Y','N',g_staj_m.stajunit,g_staj_m.stajsite)

   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL astt301_b_fill()
END FUNCTION

################################################################################
# Date & Author..: 2016/08/23 By 08734
# Modify.........:
################################################################################
PRIVATE FUNCTION astt301_action_chk()
#160818-00017#38 add-S
   SELECT stajstus  INTO g_staj_m.stajstus
     FROM staj_t
    WHERE stajent = g_enterprise
      AND stajdocno = g_staj_m.stajdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_staj_m.stajstus
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
        LET g_errparam.extend = g_staj_m.stajdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        IF g_staj_m.stajstus MATCHES "[NDR]" THEN
           CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
        ELSE 
           CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
        END IF 
        CALL astt301_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#38 add-E
   
   RETURN TRUE #160902-00009#1 add
END FUNCTION

 
{</section>}
 
