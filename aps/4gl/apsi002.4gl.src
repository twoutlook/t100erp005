#該程式已解開Section, 不再透過樣板產出!
{<section id="apsi002.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000153
#+ 
#+ Filename...: apsi002
#+ Description: APS版本維護作業
#+ Creator....: 03079(2014/03/15)
#+ Modifier...: 03079(2014/04/09)
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="apsi002.global" >}
#151207-00012#1   2015/12/16 By shiun    增加psca039、psca040
#160318-00005#41  2016/03/26 By pengxin  修正azzi920重复定义之错误讯息
#160318-00025#21  2016/04/19 BY 07900    校验代码重复错误讯息的修改
#160509-00009#1   2016/05/16 By ming     增加欄位psca041,psca042,psca043,psca044 
#160608-00013#1   2016/06/20 By ming     刪除時，判斷為進階APS，才去執行APS資料庫刪除的動作 
#160525-00029#1   2016/07/26 By catmoon  離開編輯時，不需重抓資料
#160902-00048#1   2016/09/05 By dorislai 修正SQL少ent的問題
#161108-00013#1   2016/11/08 By dorislai 與筆數相關的全域變數，型態改為num10，如：g_browser_cnt...
#161107-00011#1   2016/11/09 By dorislai 僅能輸入數字或英文 
#161015-00001#1   2016/11/09 By dorislai 拿掉欄位psca013(允許庫存批混批供給)、psca043(SET替代滿足方式)
#161228-00044#2   2017/02/02 By dorislai 最近執行時間後面，多增加顯示最近執行者(psea005)
    
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
 
#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_psca_m        RECORD
       psca001 LIKE psca_t.psca001, 
   pscal003 LIKE pscal_t.pscal003, 
   pscal004 LIKE pscal_t.pscal004, 
   psca002 LIKE psca_t.psca002, 
   pscasite LIKE psca_t.pscasite, 
   pscastus LIKE psca_t.pscastus, 
   #add--151207-00012#1 By shiun--(S)
   psca039 LIKE psca_t.psca039, 
   psca040 LIKE psca_t.psca040, 
   #add--151207-00012#1 By shiun--(E)
   #151120-00005#1 20151120 add by beckxie---S
   l_psea002_1 LIKE psea_t.psea002,
   #151120-00005#1 20151120 add by beckxie---E
   #161228-00044#2-s-add
   l_psea005_1 LIKE psea_t.psea005,
   l_psea005_1_desc LIKE ooag_t.ooag011,
   #161228-00044#2-e-add
   psca003 LIKE psca_t.psca003, 
   psca009 LIKE psca_t.psca009, 
   psca004 LIKE psca_t.psca004, 
   psca011 LIKE psca_t.psca011, 
   psca012 LIKE psca_t.psca012, 
   psca005 LIKE psca_t.psca005, 
   #psca013 LIKE psca_t.psca013, #161015-00001#1-mark
   psca006 LIKE psca_t.psca006, 
   psca014 LIKE psca_t.psca014, 
   psca007 LIKE psca_t.psca007, 
   #151120-00005#1 20151120 add by beckxie---S
   psca037 LIKE psca_t.psca037,
   #151120-00005#1 20151120 add by beckxie---E
   #ming 20141020 add --------------------------------------(S) 
   psca035 LIKE psca_t.psca035, 
   psca035_desc LIKE type_t.chr80, 
   #ming 20141020 add --------------------------------------(E)  
   #151120-00005#1 20151120 add by beckxie---S
   psca038 LIKE psca_t.psca038,
   #151120-00005#1 20151120 add by beckxie---E
   #ming 20150521 add --------------------------------------(S)  
   psca036 LIKE psca_t.psca036, 
   #ming 20150521 add --------------------------------------(E)  
   psca008 LIKE psca_t.psca008, 
   psca015 LIKE psca_t.psca015, 
   psca032 LIKE psca_t.psca032, 
   psca016 LIKE psca_t.psca016, 
   psca033 LIKE psca_t.psca033, 
   psca017 LIKE psca_t.psca017, 
   psca034 LIKE psca_t.psca034, 
   psca019 LIKE psca_t.psca019, 
   psca020 LIKE psca_t.psca020, 
   psca020_desc LIKE type_t.chr80, 
   psca021 LIKE psca_t.psca021, 
   psca031 LIKE psca_t.psca031, 
   psca022 LIKE psca_t.psca022, 
   psca023 LIKE psca_t.psca023, 
   psca024 LIKE psca_t.psca024, 
   psca025 LIKE psca_t.psca025, 
   psca026 LIKE psca_t.psca026, 
   psca029 LIKE psca_t.psca029, 
   psca030 LIKE psca_t.psca030, 
   #160509-00009#1 20160516 add by ming -----(S) 
   psca041 LIKE psca_t.psca041,
   psca042 LIKE psca_t.psca042,
   #psca043 LIKE psca_t.psca043, #161015-00001#1-mark
   psca044 LIKE psca_t.psca044,
   #160509-00009#1 20160516 add by ming -----(E) 
   pscaownid LIKE psca_t.pscaownid, 
   pscaownid_desc LIKE type_t.chr80, 
   pscaowndp LIKE psca_t.pscaowndp, 
   pscaowndp_desc LIKE type_t.chr80, 
   pscacrtid LIKE psca_t.pscacrtid, 
   pscacrtid_desc LIKE type_t.chr80, 
   pscacrtdp LIKE psca_t.pscacrtdp, 
   pscacrtdp_desc LIKE type_t.chr80, 
   pscacrtdt DATETIME YEAR TO SECOND, 
   pscamodid LIKE psca_t.pscamodid, 
   pscamodid_desc LIKE type_t.chr80, 
   pscamoddt DATETIME YEAR TO SECOND 
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pscc_d        RECORD
       pscc002 LIKE type_t.chr5, 
   pscc002_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_pscc4_d RECORD
       pscd002 LIKE type_t.chr10, 
   inaa002 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_pscc5_d RECORD
       psce003 LIKE type_t.num5, 
   psce002 LIKE type_t.chr10, 
   psce002_desc LIKE type_t.chr500
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_psca_m          type_g_psca_m
DEFINE g_psca_m_t        type_g_psca_m
 
   DEFINE g_psca001_t LIKE psca_t.psca001
DEFINE g_pscasite_t LIKE psca_t.pscasite
 
 
DEFINE g_pscc_d          DYNAMIC ARRAY OF type_g_pscc_d
DEFINE g_pscc_d_t        type_g_pscc_d
DEFINE g_pscc4_d   DYNAMIC ARRAY OF type_g_pscc4_d
DEFINE g_pscc4_d_t type_g_pscc4_d
DEFINE g_pscc5_d   DYNAMIC ARRAY OF type_g_pscc5_d
DEFINE g_pscc5_d_t type_g_pscc5_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_psca001 LIKE psca_t.psca001,
   b_psca001_desc LIKE type_t.chr80,
      b_pscasite LIKE psca_t.pscasite,
      b_psca002 LIKE psca_t.psca002
      END RECORD 
      
DEFINE g_browser_f  RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_psca001 LIKE psca_t.psca001,
   b_psca001_desc LIKE type_t.chr80,
      b_pscasite LIKE psca_t.pscasite,
      b_psca002 LIKE psca_t.psca002
      END RECORD 
      
DEFINE g_master_multi_table_t    RECORD
      pscal001 LIKE pscal_t.pscal001,
      pscal003 LIKE pscal_t.pscal003,
      pscal004 LIKE pscal_t.pscal004
      END RECORD
#無單身append欄位定義
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5      
#161108-00013#1-s-mod  把筆數num5變num10
#DEFINE g_rec_b               LIKE type_t.num5           
#DEFINE l_ac                  LIKE type_t.num5    
#DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
#    
#DEFINE g_pagestart           LIKE type_t.num5           
#DEFINE gwin_curr             ui.Window                     #Current Window
#DEFINE gfrm_curr             ui.Form                       #Current Form
#DEFINE g_page_action         STRING                        #page action
#DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
#DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
#DEFINE g_page                STRING                        #第幾頁
#DEFINE g_state               STRING       
 
#DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
#DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
#DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數  
#DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
#DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
 
#DEFINE g_searchcol           STRING                        #查詢欄位代碼
#DEFINE g_searchstr           STRING                        #查詢欄位字串
#DEFINE g_order               STRING                        #查詢排序欄位
#DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
#DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
#DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
#DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
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
DEFINE g_state               STRING       
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數  
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
#161108-00013#1-e-mod 
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
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
 
#add-point:自定義模組變數(Module Variable)
 TYPE type_g_gzcb_d RECORD
                              gzcb003 LIKE gzcb_t.gzcb003,
                              gzcb002 LIKE gzcb_t.gzcb002
                           END RECORD
DEFINE g_gzcb_d            DYNAMIC ARRAY OF type_g_gzcb_d

 TYPE type_g_pscb_d RECORD 
                              pscb003 LIKE pscb_t.pscb003, 
                              pscb002 LIKE pscb_t.pscb002, 
                              pscb004 LIKE pscb_t.pscb004 
                           END RECORD 
DEFINE g_pscb_d            DYNAMIC ARRAY OF type_g_pscb_d 
DEFINE g_pscb_d_t          type_g_pscb_d
DEFINE g_ooef004           LIKE ooef_t.ooef004           #組織的單據別參照表號 
DEFINE g_psea002           LIKE psea_t.psea002           #161228-00044#2-add
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="apsi002.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define

   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aps","")
 
   #add-point:作業初始化
   #建立temp table 
   CALL apsi002_create_tmp()
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
   #151120-00005#1 20151120 mark by beckxie---S
   ##ming 20141020 modify ------------------------------------------------------------(S) 
   ##LET g_forupd_sql = "SELECT psca001,'','',psca002,pscasite,pscastus,psca003,psca009,psca004,psca011, 
   ##    psca012,psca005,psca013,psca006,psca014,psca007,psca008,psca015,psca032,psca016,psca033,psca017, 
   ##    psca034,psca019,psca020,'',psca021,psca031,psca022,psca023,psca024,psca025,psca026,
   ##    psca029,psca030,pscaownid,'',pscaowndp,'',pscacrtid,'',pscacrtdp,'',pscacrtdt,pscamodid,'',pscamoddt  
   ##    FROM psca_t WHERE pscaent= ? AND pscasite=? AND psca001=? FOR UPDATE"
   #LET g_forupd_sql = "SELECT psca001,'','',psca002,pscasite,pscastus,psca003,psca009,psca004,psca011, ",
   #                   #ming 20150521 modify ------------------------------------------------------------------(S) 
   #                   #"       psca012,psca005,psca013,psca006,psca014,psca007,psca035,'',psca008,psca015, ",
   #                   "       psca012,psca005,psca013,psca006,psca014,psca007,psca035,'',psca036,psca008,psca015, ",
   #                   #ming 20150521 modify ------------------------------------------------------------------(E) 
   #                   "       psca032,psca016,psca033,psca017,psca034,psca019,psca020,'',psca021,psca031, ",
   #                   "       psca022,psca023,psca024,psca025,psca026,psca029,psca030,pscaownid,'', ",
   #                   "       pscaowndp,'',pscacrtid,'',pscacrtdp,'',pscacrtdt,pscamodid,'',pscamoddt ",
   #                   "  FROM psca_t WHERE pscaent= ? AND pscasite=? AND psca001=? FOR UPDATE"
   ##ming 20141020 modify ------------------------------------------------------------(E) 
   #151120-00005#1 20151120 mark by beckxie---E
   #151120-00005#1 20151120  add by beckxie---S
   LET g_forupd_sql = "SELECT psca001,'','',psca002,pscasite,pscastus,psca039,psca040,'',psca003,psca009,psca004,psca011, ", #modify--151207-00012#1 By shiun 增加psca039、40
                      #161015-00001#1-s-mod  拿掉psca013
                      ##ming 20150521 modify ------------------------------------------------------------------(S) 
                      ##"       psca012,psca005,psca013,psca006,psca014,psca007,psca035,'',psca008,psca015, ",
                      #"       psca012,psca005,psca013,psca006,psca014,psca007,psca037,psca035,'',psca038,psca036,psca008,psca015, ",
                      ##ming 20150521 modify ------------------------------------------------------------------(E) 
                      "       psca012,psca005,psca006,psca014,psca007,psca037,psca035,'',psca038,psca036,psca008,psca015, ",
                      #161015-00001#1-e-mod
                      "       psca032,psca016,psca033,psca017,psca034,psca019,psca020,'',psca021,psca031, ",
                      #161015-00001#1-s-mod 拿掉psca043
                      ##160509-00009#1 20160516 modify by ming -----(S) 
                      ##"       psca022,psca023,psca024,psca025,psca026,psca029,psca030,pscaownid,'', ",
                      #"       psca022,psca023,psca024,psca025,psca026,psca029,psca030, ",
                      #"       psca041,psca042,psca043,psca044, ",
                      #"       pscaownid,'', ",
                      ##160509-00009#1 20160516 modify by ming -----(E) 
                      "       psca022,psca023,psca024,psca025,psca026,psca029,psca030, ",
                      "       psca041,psca042,psca044,pscaownid,'', ",
                      #161015-00001#1-e-mod
                      "       pscaowndp,'',pscacrtid,'',pscacrtdp,'',pscacrtdt,pscamodid,'',pscamoddt ",
                      "  FROM psca_t WHERE pscaent= ? AND pscasite=? AND psca001=? FOR UPDATE"
   #151120-00005#1 20151120  add by beckxie---E
   
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE apsi002_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
   #151120-00005#1 20151120 mark by beckxie---S
   ##ming 20141020 modify ------------------------------------------------------------(S) 
   ##LET g_sql = " SELECT UNIQUE psca001,psca002,pscasite,pscastus,psca003,psca009,psca004,psca011,psca012, 
   ##    psca005,psca013,psca006,psca014,psca007,psca008,psca015,psca032,psca016,psca033,psca017,psca034, 
   ##    psca019,psca020,psca021,psca031,psca022,psca023,psca024,psca025,psca026,psca029, 
   ##    psca030,pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,pscamodid,pscamoddt",
   ##            " FROM psca_t",
   ##            " WHERE pscaent = '" ||g_enterprise|| "' AND pscasite = ? AND psca001 = ?"
   #LET g_sql = " SELECT UNIQUE psca001,psca002,pscasite,pscastus,psca003,psca009,psca004,psca011,psca012, ",
   #            #ming 20150521 modify ---------------------------------------------------------------------(S) 
   #            #"               psca005,psca013,psca006,psca014,psca007,psca035,psca008,psca015,psca032, ",
   #            "               psca005,psca013,psca006,psca014,psca007,psca035,psca036,psca008,psca015,psca032, ",
   #            #ming 20150521 modify ---------------------------------------------------------------------(E) 
   #            "               psca016,psca033,psca017,psca034,psca019,psca020,psca021,psca031,psca022, ",
   #            "               psca023,psca024,psca025,psca026,psca029,psca030,pscaownid,pscaowndp, ",
   #            "               pscacrtid,pscacrtdp,pscacrtdt,pscamodid,pscamoddt",
   #            "   FROM psca_t",
   #            "  WHERE pscaent = '" ||g_enterprise|| "' AND pscasite = ? AND psca001 = ?"
   ##ming 20141020 modify ------------------------------------------------------------(E) 
   #151120-00005#1 20151120 mark by beckxie---E
   #151120-00005#1 20151120  add by beckxie---S
   LET g_sql = " SELECT UNIQUE psca001,psca002,pscasite,pscastus,psca039,psca040, ",   #modify--151207-00012#1 By shiun   增加psca039、40
               "               psca003,psca009,psca004,psca011,psca012, ",
               #161015-00001#1-s-mod 拿掉psca013
               ##ming 20150521 modify ---------------------------------------------------------------------(S) 
               ##"               psca005,psca013,psca006,psca014,psca007,psca035,psca008,psca015,psca032, ",
               #"               psca005,psca013,psca006,psca014,psca007,psca037,psca035,psca038,psca036,psca008,psca015,psca032, ",
               ##ming 20150521 modify ---------------------------------------------------------------------(E) 
               "               psca005,psca006,psca014,psca007,psca037,psca035,psca038,psca036,psca008,psca015,psca032, ",
               #161015-00001#1-e-mod
               "               psca016,psca033,psca017,psca034,psca019,psca020,psca021,psca031,psca022, ",
               #161015-00001#1-s-mod  拿掉psca043
               ##160509-00009#1 20160516 modify by ming -----(S) 
               ##"               psca023,psca024,psca025,psca026,psca029,psca030,pscaownid,pscaowndp, ",
               #"               psca023,psca024,psca025,psca026,psca029,psca030, ",
               #"               psca041,psca042,psca043,psca044, ",
               #"               pscaownid,pscaowndp, ",
               ##160509-00009#1 20160516 modify by ming -----(E) 
               "               psca023,psca024,psca025,psca026,psca029,psca030, ",
               "               psca041,psca042,psca044,pscaownid,pscaowndp, ",
               #161015-00001#1-e-mod
               "               pscacrtid,pscacrtdp,pscacrtdt,pscamodid,pscamoddt",
               "   FROM psca_t",
               "  WHERE pscaent = '" ||g_enterprise|| "' AND pscasite = ? AND psca001 = ?"
   #151120-00005#1 20151120  add by beckxie---E
   #add-point:SQL_define

   #end add-point
   PREPARE apsi002_master_referesh FROM g_sql
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsi002 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsi002_init()   
 
      #進入選單 Menu (="N")
      CALL apsi002_ui_dialog() 
      
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apsi002
      
   END IF 
   
   CLOSE apsi002_cl
   
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="apsi002.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apsi002_init()
   #add-point:init段define

   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET l_ac = 1
      CALL cl_set_combo_scc_part('pscastus','17','N,Y')
      CALL cl_set_combo_scc('psca039','5419')   #add--151207-00012#1 By shiun
      CALL cl_set_combo_scc('psca002','5422') 
   CALL cl_set_combo_scc('psca003','5410') 
   CALL cl_set_combo_scc('psca004','5411') 
   CALL cl_set_combo_scc('psca011','5414') 
   CALL cl_set_combo_scc('psca006','5412') 
   CALL cl_set_combo_scc('psca008','5413') 
   CALL cl_set_combo_scc('psca015','5415') 
   CALL cl_set_combo_scc('psca032','5432') 
   CALL cl_set_combo_scc('psca016','5416') 
   CALL cl_set_combo_scc('psca033','5433') 
   CALL cl_set_combo_scc('psca021','37') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('b_psca002','5422')

   #CALL cl_set_combo_scc('psca002','5422')
   #CALL cl_set_combo_scc('psca003','5410')
   #CALL cl_set_combo_scc('psca004','5411')
   #CALL cl_set_combo_scc('psca006','5412')
   #CALL cl_set_combo_scc('psca008','5413')
   #CALL cl_set_combo_scc('psca011','5414')
   #CALL cl_set_combo_scc('psca015','5415')
   #CALL cl_set_combo_scc('psca016','5416')

   CALL cl_set_combo_scc('gzcb003','5423')
   CALL cl_set_combo_scc('gzcb002','5409')

   CALL cl_set_combo_scc('pscb003','5423')
   CALL cl_set_combo_scc('pscb002','5409')

   #CALL cl_set_combo_scc('psca021','37')
   #add--151207-00012#1 By shiun--(S)   APS引擎
   CALL cl_set_comp_visible("psca039,psca040",TRUE)
   CALL cl_set_act_visible_toolbaritem("create_apsdata,drop_apsdata",TRUE)
   IF cl_get_para(g_enterprise,g_site,'S-MFG-0036') != '2' THEN
      CALL cl_set_comp_visible("psca039,psca040",FALSE)
      CALL cl_set_act_visible_toolbaritem("create_apsdata,drop_apsdata",FALSE)
   END IF
   #add--151207-00012#1 By shiun--(E) 
   
   #161015-00001#1-s-mark
   ##160509-00009#1 20160516 add by ming -----(S) 
   #CALL cl_set_combo_scc('psca043','5451')  
   ##160509-00009#1 20160516 add by ming -----(E) 
   #161015-00001#1-e-mark
   #end add-point
   
   CALL apsi002_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apsi002.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apsi002_ui_dialog()
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
   DEFINE ls_cnt                 LIKE type_t.num10
   DEFINE l_dnd                  ui.DragDrop
   DEFINE l_source               STRING
   DEFINE l_success              LIKE type_t.num5
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
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
   
   #action default動作
   #+ 此段落由子樣板a42產生
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL apsi002_insert()
            #add-point:ON ACTION insert

            #END add-point
         END IF
 
      #add-point:action default自訂

      #end add-point
      OTHERWISE
         
   END CASE
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE 
   
      CALL apsi002_browser_fill("")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
            
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_pscasite = g_pscasite_t
               AND g_browser[li_idx].b_psca001 = g_psca001_t
 
               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
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
               
               CALL apsi002_fetch('') # reload data
               LET l_ac = 1
               CALL apsi002_ui_detailshow() #Setting the current row 
      
               CALL apsi002_idx_chk()
               #NEXT FIELD pscc002
         
         END DISPLAY
        
         DISPLAY ARRAY g_pscc_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL apsi002_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 1
               CALL apsi002_idx_chk()
               #add-point:page1自定義行為

               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_pscc4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL apsi002_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 2
               CALL apsi002_idx_chk()
               #add-point:page2自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_pscc5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL apsi002_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 3
               CALL apsi002_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_gzcb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL apsi002_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL apsi002_idx_chk()
               
            #ON DRAG_START(l_dnd)
            #   LET l_source = "LEFT"
            #   LET l_ac = ARR_CURR()
            #   
            #ON DRAG_OVER(l_dnd)
            #   IF l_source == "LEFT" THEN
            #      CALL l_dnd.setOperation(NULL)
            #   ELSE
            #      CALL l_dnd.setOperation("move")
            #      CALL l_dnd.setFeedback("insert")
            #   END IF 
            #ON DROP(l_dnd)
            #   IF g_psca_m.pscastus = 'Y' THEN
            #      IF l_source == "RIGHT" AND l_ac > 0 THEN
            #         FOR li_idx = 1 TO g_pscb_d.getLength()
            #            IF DIALOG.isRowSelected("s_detail2",li_idx) THEN
            #               DELETE FROM pscb_t WHERE pscbent = g_enterprise
            #                                    AND pscbsite = g_psca_m.pscasite
            #                                    AND pscb001 = g_psca_m.psca001
            #                                    AND pscb002 = g_pscb_d[li_idx].pscb002
            #            END IF
            #         END FOR
            #         CALL apsi002_gzcb_b_fill()
            #         CALL apsi002_array2_b_fill()
            #         LET l_ac = 0
            #      END IF
            #   END IF
               
         END DISPLAY
         
         DISPLAY ARRAY g_pscb_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)
            BEFORE ROW
               CALL apsi002_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 1
               CALL apsi002_idx_chk()

            #ON DRAG_START(l_dnd)
            #   LET l_source = "RIGHT"
            #   LET l_ac = ARR_CURR() 
            #   
            #ON DRAG_OVER(l_dnd)
            #   IF l_source == "RIGHT" THEN
            #      CALL l_dnd.setOperation(NULL)
            #   ELSE
            #      CALL l_dnd.setOperation("move")
            #      CALL l_dnd.setFeedback("insert")
            #   END IF 
            #
            #ON DROP(l_dnd)
            #   IF g_psca_m.pscastus = 'Y' THEN
            #      IF l_source == "LEFT" AND l_ac > 0 THEN
            #         #刪除左邊，新增右邊 兩邊都要b_fill 
            #         FOR li_idx = 1 TO g_gzcb_d.getLength()
            #            IF DIALOG.isRowSelected("s_detail1",li_idx) THEN
            #
            #               SELECT COUNT(*) INTO ls_cnt
            #                 FROM pscb_t
            #                WHERE pscbent = g_enterprise
            #                  AND pscbsite = g_psca_m.pscasite
            #                  AND pscb001 = g_psca_m.psca001
            #                  AND pscb002 = g_gzcb_d[li_idx].gzcb002
            #
            #               IF ls_cnt > 0 THEN
            #                  #MESSAGE "Repeat Data"     #資料已存在   
            #               ELSE
            #                   INSERT INTO pscb_t VALUES(g_enterprise,g_psca_m.pscasite,g_psca_m.psca001,
            #                                             g_gzcb_d[li_idx].gzcb002,g_gzcb_d[li_idx].gzcb003,'N')
            #                   DELETE FROM apsi002_gzcb_tmp WHERE gzcb003 = g_gzcb_d[li_idx].gzcb003
            #                                                  AND gzcb002 = g_gzcb_d[li_idx].gzcb002
            #               END IF
            #
            #            END IF
            #         END FOR
            #
            #         CALL apsi002_array2_b_fill()
            #         LET l_ac = 0
            #      END IF
            #   END IF
         END DISPLAY
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
               CALL apsi002_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apsi002_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apsi002_idx_chk()
            
            #add-point:ui_dialog段before_dialog2
            #modify--151207-00012#1 By shiun--(S)
            #CALL apsi002_init() #160525-00029#1 mark
            #modify--151207-00012#1 By shiun--(E)
            CALL apsi002_set_act_visible()     #151207-00012#1 add
            CALL apsi002_set_act_no_visible()  #151207-00012#1 add
            #單身可多選的關鍵 
            #CALL DIALOG.setSelectionMode("s_detail1",1)
            #CALL DIALOG.setSelectionMode("s_detail2",1)
            #end add-point
            
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD pscc002
            END IF
         
         #add--151207-00012#1 By shiun--(S)
         ON ACTION create_apsdata
            LET g_action_choice="create_apsdata"
            IF cl_auth_chk_act("create_apsdata") THEN
               
               #add-point:ON ACTION create_apsdata
               IF NOT cl_null(g_psca_m.psca001) THEN
                  #當psca039=2.進階APS時，執行以下三個動作：
                  #1.CALL s_apsp500_advanced_command，參數：'erp_sync',psca001(APS版本),'','',''
                  #2.CALL s_apsp500_advanced_command，參數：'create_db',psca001(APS版本),'','',''
                  #3.更新psca040 = 'Y'
                  IF g_psca_m.psca039 = '2' THEN
                     CALL s_apsp500_advanced_command('erp_sync',g_psca_m.psca001,'','','')
                          RETURNING l_success                     
 
                     CALL s_apsp500_advanced_command('create_db',g_psca_m.psca001,'','','')
                          RETURNING l_success
                     
                     IF l_success THEN
                        UPDATE psca_t SET psca040 = 'Y'
                         WHERE pscaent  = g_enterprise
                           AND pscasite = g_psca_m.pscasite
                           AND psca001  = g_psca_m.psca001
                           
                        CALL apsi002_fetch("")
                     END IF
                  END IF                     
               END IF
               #END add-point
               
            END IF
         
         ON ACTION drop_apsdata
            LET g_action_choice="drop_apsdata"
            IF cl_auth_chk_act("drop_apsdata") THEN
               
               #add-point:ON ACTION drop_apsdata
               IF NOT cl_null(g_psca_m.psca001) THEN
                  #當psca039=2.進階APS時，執行以下兩個動作：
                  #1.CALL s_apsp500_advanced_command，參數：'delete_db',psca001(APS版本),'','',''
                  #3.更新psca040 = 'N'
                  IF g_psca_m.psca039 = '2' THEN   
                     CALL s_apsp500_advanced_command('delete_db',g_psca_m.psca001,'','','')
                          RETURNING l_success
                  
                     IF l_success THEN
                        UPDATE psca_t SET psca040 = 'N'
                         WHERE pscaent  = g_enterprise
                           AND pscasite = g_psca_m.pscasite
                           AND psca001  = g_psca_m.psca001
                           
                        CALL apsi002_fetch("")
                     END IF
                  END IF
               END IF
               #END add-point
               
            END IF
         #add--151207-00012#1 By shiun--(E)
         
         ON ACTION statechange
            CALL apsi002_statechange()
            LET g_action_choice = "statechange"
            EXIT DIALOG
      
         
          
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL apsi002_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
 
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL apsi002_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "-100"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL apsi002_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #+ 此段落由子樣板a49產生
            ON ACTION filter
               #add-point:filter action

               #end add-point
               CALL apsi002_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            CALL apsi002_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apsi002_idx_chk()
            
         ON ACTION previous
            CALL apsi002_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apsi002_idx_chk()
            
         ON ACTION jump
            CALL apsi002_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apsi002_idx_chk()
            
         ON ACTION next
            CALL apsi002_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apsi002_idx_chk()
            
         ON ACTION last
            CALL apsi002_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apsi002_idx_chk()
         
         #dorislai-20150915-add----(S)
         #excel匯出功能          
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
                  LET g_export_node[1] = base.typeInfo.create(g_gzcb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_pscb_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_pscc_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_pscc4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_pscc5_d)
                  LET g_export_id[5]   = "s_detail5"
                  
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
         #dorislai-20150915-add----(E)
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
               CALL apsi002_insert()
               #add-point:ON ACTION insert
 
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
 
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL apsi002_delete()
               #add-point:ON ACTION delete

               #END add-point
            END IF
 
 
         ON ACTION modify
 
            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL apsi002_modify()
               #add-point:ON ACTION modify

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify_detail
 
            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN 
               CALL apsi002_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL apsi002_query()
               #add-point:ON ACTION query

               #END add-point
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL apsi002_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               EXIT DIALOG
            END IF
 
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL apsi002_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apsi002_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apsi002_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         #modify--151207-00012#1 By shiun--(S)
         #&include "main_menu.4gl"
         &include "main_menu_exit_dialog.4gl"
         #modify--151207-00012#1 By shiun--(E)
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
 
{<section id="apsi002.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apsi002_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
   
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_psca_m.* TO NULL
   CALL g_pscc_d.clear()        
   CALL g_pscc4_d.clear() 
   CALL g_pscc5_d.clear() 
 
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "pscasite"
                        ,",psca001"
 
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   #add-point:browser_fill,foreach前
   LET l_wc = l_wc , " AND pscasite = '",g_site,"' "
   LET g_wc = g_wc , " AND pscasite = '",g_site,"' "
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE pscasite ",
                                    ",psca001 ",
 
                        " FROM psca_t ",
                              " ",
                              " LEFT JOIN pscc_t ON psccent = pscaent AND pscasite = psccsite AND psca001 = pscc001 ",
                              " LEFT JOIN pscd_t ON pscdent = pscaent AND pscasite = pscdsite AND psca001 = pscd001", 
 
                              " LEFT JOIN psce_t ON psceent = pscaent AND pscasite = pscesite AND psca001 = psce001", 
 
 
 
                              " LEFT JOIN pscal_t ON psca001 = pscal001 AND pscal002 = '",g_lang,"' ", 
                              " ", 
                       " WHERE pscaent = '" ||g_enterprise|| "' AND psccent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("psca_t")
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE pscasite ",
                                    ",psca001 ",
 
                        " FROM psca_t ", 
                              " ",
                              " LEFT JOIN pscal_t ON psca001 = pscal001 AND pscal002 = '",g_lang,"' ",
                        "WHERE pscaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("psca_t")
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
   
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
      #依照psca001,'',pscasite,psca002 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT pscastus,psca001,'',pscasite,psca002,DENSE_RANK() OVER(ORDER BY pscasite, 
          psca001 ",g_order,") AS RANK ",
                        " FROM psca_t ",
                              " ",
                              " LEFT JOIN pscc_t ON psccent = pscaent AND pscasite = psccsite AND psca001 = pscc001 ",
                              " LEFT JOIN pscd_t ON pscdent = pscaent AND pscasite = pscdsite AND psca001 = pscd001",
 
                              " LEFT JOIN psce_t ON psceent = pscaent AND pscasite = pscesite AND psca001 = psce001",
 
 
 
                              " LEFT JOIN pscal_t ON psca001 = pscal001 AND pscal002 = '",g_lang,"' ",
                              " ",
                       " ",
                       " WHERE pscaent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2, cl_sql_add_filter("psca_t")
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT pscastus,psca001,'',pscasite,psca002,DENSE_RANK() OVER(ORDER BY pscasite, 
          psca001 ",g_order,") AS RANK ",
                       " FROM psca_t ",
                            "  ",
                            "  LEFT JOIN pscal_t ON psca001 = pscal001 AND pscal002 = '",g_lang,"' ",
                       " WHERE pscaent = '" ||g_enterprise|| "' AND ", g_wc, cl_sql_add_filter("psca_t")
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT pscastus,psca001,'',pscasite,psca002 FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
               
   #add-point:browser_fill,before_prepare
   
   #end add-point
               
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill,open
   
   #end add-point
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_psca001,g_browser[g_cnt].b_psca001_desc, 
       g_browser[g_cnt].b_pscasite,g_browser[g_cnt].b_psca002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_psca001
      CALL ap_ref_array2(g_ref_fields,"SELECT pscal003 FROM pscal_t WHERE pscalent='"||g_enterprise||"' AND pscal001=? AND pscal002='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_psca001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_psca001_desc
 
  
      #add-point:browser_fill段reference
      
      #end add-point
  
            #此段落由子樣板a24產生
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
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
 
{<section id="apsi002.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apsi002_ui_headershow()
   #add-point:ui_headershow段define

   #end add-point    
   
   LET g_psca_m.pscasite = g_browser[g_current_idx].b_pscasite   
   LET g_psca_m.psca001 = g_browser[g_current_idx].b_psca001   
   #151120-00005#1 20151120 mark by beckxie---S
   ##ming 20141020 modify ------------------------------------------------------------------------------------------(S) 
   ##EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001 INTO g_psca_m.psca001,g_psca_m.psca002, 
   ##    g_psca_m.pscasite,g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011, 
   ##    g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007, 
   ##    g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017, 
   ##    g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022, 
   ##    g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
   ##    g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp, 
   ##    g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   #EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001
   #                                 INTO g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,
   #                                      g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,
   #                                      g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012,
   #                                      g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,
   #                                      g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035, 
   #                                      #ming 20150521 add ---------------------------------------(S) 
   #                                      g_psca_m.psca036,
   #                                      #ming 20150521 add ---------------------------------------(E) 
   #                                      g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,
   #                                      g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,
   #                                      g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
   #                                      g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,
   #                                      g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
   #                                      g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,
   #                                      g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp,
   #                                      g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   ##ming 20141020 modify ------------------------------------------------------------------------------------------(E) 
   #151120-00005#1 20151120 mark by beckxie---E
   #151120-00005#1 20151120  add by beckxie---S
   EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001
                                    INTO g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,
                                         g_psca_m.pscastus,g_psca_m.psca039,g_psca_m.psca040,  #modify--151207-00012#1 By shiun   增加psca039、40
                                         g_psca_m.psca003,g_psca_m.psca009,
                                         g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012,
                                         #161015-00001#1-s-mod 拿掉psca013
                                         #g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,
                                         g_psca_m.psca005,g_psca_m.psca006,
                                         #161015-00001#1-e-mod
                                         g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca038,
                                         #ming 20150521 add ---------------------------------------(S) 
                                         g_psca_m.psca036,
                                         #ming 20150521 add ---------------------------------------(E) 
                                         g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,
                                         g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,
                                         g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
                                         g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,
                                         g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
                                         #161015-00001#1-s-mod 拿掉psca043
                                         ##160509-00009#1 20160516 modify by ming -----(S) 
                                         ##g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,
                                         #g_psca_m.psca029,g_psca_m.psca030,
                                         #g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044,
                                         #g_psca_m.pscaownid,
                                         ##160509-00009#1 20160516 modify by ming -----(E) 
                                         g_psca_m.psca029,g_psca_m.psca030,g_psca_m.psca041,g_psca_m.psca042,
                                         g_psca_m.psca044,g_psca_m.pscaownid,
                                         #161015-00001#1-e-mod
                                         g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp,
                                         g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   #151120-00005#1 20151120  add by beckxie---E
   CALL apsi002_show()
   
END FUNCTION
 
{</section>}
 
{<section id="apsi002.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apsi002_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apsi002.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apsi002_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_pscasite = g_psca_m.pscasite 
         AND g_browser[l_i].b_psca001 = g_psca_m.psca001 
 
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
 
{<section id="apsi002.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsi002_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define

   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_psca_m.* TO NULL
   CALL g_pscc_d.clear()        
   CALL g_pscc4_d.clear() 
   CALL g_pscc5_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前

   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      #151120-00005#1 20151120 mark by beckxie---S
      ##ming 20141020 modify ----------------------------------------------------------------------(S) 
      ##CONSTRUCT BY NAME g_wc ON psca001,pscal003,pscal004,psca002,pscasite,pscastus,psca003,psca009, 
      ##    psca004,psca011,psca012,psca005,psca013,psca006,psca014,psca007,psca008,psca015,psca032,psca016, 
      ##    psca033,psca017,psca034,psca019,psca020,psca021,psca031,psca022,psca023,psca024,psca025,psca026, 
      ##    psca029,psca030,pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,pscamodid, 
      #CONSTRUCT BY NAME g_wc ON psca001,pscal003,pscal004,psca002,pscasite,pscastus,psca003,psca009,
      #                          psca004,psca011,psca012,psca005,psca013,psca006,psca014,psca007,psca035, 
      #                          #ming 20150521 add ------------------------------------------------------(S) 
      #                          psca036,
      #                          #ming 20150521 add ------------------------------------------------------(E) 
      #                          psca008,psca015,psca032,psca016,psca033,psca017,psca034,psca019,psca020,
      #                          psca021,psca031,psca022,psca023,psca024,psca025,psca026,psca029,psca030,
      #                          pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,pscamodid,pscamoddt
      ##ming 20141020 modify ----------------------------------------------------------------------(E) 
      #151120-00005#1 20151120 mark by beckxie---E
      #151120-00005#1 20151120  add by beckxie---S
      CONSTRUCT BY NAME g_wc ON psca001,pscal003,pscal004,psca002,pscasite,pscastus,psca039,psca040,psca003,psca009,   #modify--151207-00012#1 By shiun   增加psca039、40
                                #161015-00001#1-s-mod 拿掉psca013
                                #psca004,psca011,psca012,psca005,psca013,psca006,psca014,psca007,psca037,psca035,psca038,
                                psca004,psca011,psca012,psca005,psca006,psca014,psca007,psca037,psca035,psca038,
                                #161015-00001#1-e-mod
                                #ming 20150521 add ------------------------------------------------------(S) 
                                psca036,
                                #ming 20150521 add ------------------------------------------------------(E) 
                                psca008,psca015,psca032,psca016,psca033,psca017,psca034,psca019,psca020,
                                psca021,psca031,psca022,psca023,psca024,psca025,psca026,psca029,psca030,
                                #161015-00001#1-s-mod 拿掉psca043
                                ##160509-00009#1 20160516 add by ming -----(S) 
                                #psca041,psca042,psca043,psca044,
                                ##160509-00009#1 20160516 add by ming -----(E) 
                                psca041,psca042,psca044,
                                #161015-00001#1-e-mod
                                pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,pscamodid,pscamoddt
      #151120-00005#1 20151120  add by beckxie---E
      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<pscaownid>>----
         #ON ACTION controlp INFIELD pscaownid
         #   CALL q_common('psca_t','pscaownid',TRUE,FALSE,g_psca_m.pscaownid) RETURNING ls_return
         #   DISPLAY ls_return TO pscaownid
         #   NEXT FIELD pscaownid  
         #
         ##----<<pscaowndp>>----
         #ON ACTION controlp INFIELD pscaowndp
         #   CALL q_common('psca_t','pscaowndp',TRUE,FALSE,g_psca_m.pscaowndp) RETURNING ls_return
         #   DISPLAY ls_return TO pscaowndp
         #   NEXT FIELD pscaowndp
         #
         ##----<<pscacrtid>>----
         #ON ACTION controlp INFIELD pscacrtid
         #   CALL q_common('psca_t','pscacrtid',TRUE,FALSE,g_psca_m.pscacrtid) RETURNING ls_return
         #   DISPLAY ls_return TO pscacrtid
         #   NEXT FIELD pscacrtid
         #
         ##----<<pscacrtdp>>----
         #ON ACTION controlp INFIELD pscacrtdp
         #   CALL q_common('psca_t','pscacrtdp',TRUE,FALSE,g_psca_m.pscacrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO pscacrtdp
         #   NEXT FIELD pscacrtdp
         #
         ##----<<pscamodid>>----
         #ON ACTION controlp INFIELD pscamodid
         #   CALL q_common('psca_t','pscamodid',TRUE,FALSE,g_psca_m.pscamodid) RETURNING ls_return
         #   DISPLAY ls_return TO pscamodid
         #   NEXT FIELD pscamodid
         #
         ##----<<pscacnfid>>----
         ##ON ACTION controlp INFIELD pscacnfid
         ##   CALL q_common('psca_t','pscacnfid',TRUE,FALSE,g_psca_m.pscacnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO pscacnfid
         ##   NEXT FIELD pscacnfid
         #
         ##----<<pscapstid>>----
         ##ON ACTION controlp INFIELD pscapstid
         ##   CALL q_common('psca_t','pscapstid',TRUE,FALSE,g_psca_m.pscapstid) RETURNING ls_return
         ##   DISPLAY ls_return TO pscapstid
         ##   NEXT FIELD pscapstid
         
         ##----<<pscacrtdt>>----
         AFTER FIELD pscacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pscamoddt>>----
         AFTER FIELD pscamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pscacnfdt>>----
         #AFTER FIELD pscacnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pscapstdt>>----
         #AFTER FIELD pscapstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
            
         #一般欄位開窗相關處理    
         #---------------------------<  Master  >---------------------------
         #----<<psca001>>----
         #Ctrlp:construct.c.psca001
         ON ACTION controlp INFIELD psca001
            #add-point:ON ACTION controlp INFIELD psca001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psca001  #顯示到畫面上

            NEXT FIELD psca001                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD psca001
            #add-point:BEFORE FIELD psca001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca001
            
            #add-point:AFTER FIELD psca001

            #END add-point
            
 
         #----<<pscal003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pscal003
            #add-point:BEFORE FIELD pscal003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscal003
            
            #add-point:AFTER FIELD pscal003

            #END add-point
            
 
         #Ctrlp:construct.c.pscal003
         ON ACTION controlp INFIELD pscal003
            #add-point:ON ACTION controlp INFIELD pscal003

            #END add-point
 
         #----<<pscal004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pscal004
            #add-point:BEFORE FIELD pscal004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscal004
            
            #add-point:AFTER FIELD pscal004

            #END add-point
            
 
         #Ctrlp:construct.c.pscal004
         ON ACTION controlp INFIELD pscal004
            #add-point:ON ACTION controlp INFIELD pscal004

            #END add-point
 
         #----<<psca002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca002
            #add-point:BEFORE FIELD psca002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca002
            
            #add-point:AFTER FIELD psca002

            #END add-point
            
 
         #Ctrlp:construct.c.psca002
         ON ACTION controlp INFIELD psca002
            #add-point:ON ACTION controlp INFIELD psca002

            #END add-point
 
         #----<<pscasite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pscasite
            #add-point:BEFORE FIELD pscasite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscasite
            
            #add-point:AFTER FIELD pscasite

            #END add-point
            
 
         #Ctrlp:construct.c.pscasite
         ON ACTION controlp INFIELD pscasite
            #add-point:ON ACTION controlp INFIELD pscasite

            #END add-point
 
         #----<<pscastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pscastus
            #add-point:BEFORE FIELD pscastus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscastus
            
            #add-point:AFTER FIELD pscastus

            #END add-point
            
 
         #Ctrlp:construct.c.pscastus
         ON ACTION controlp INFIELD pscastus
            #add-point:ON ACTION controlp INFIELD pscastus

            #END add-point
         #add--151207-00012#1 By shiun--(S)
         #----<<psca039>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca039
            #add-point:BEFORE FIELD psca039
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca039
            
            #add-point:AFTER FIELD psca039
            
            #END add-point
            
 
         #Ctrlp:construct.c.psca039
         ON ACTION controlp INFIELD psca039
            #add-point:ON ACTION controlp INFIELD psca039
            
            #END add-point
 
         #----<<psca040>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca040
            #add-point:BEFORE FIELD psca040
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca040
            
            #add-point:AFTER FIELD psca040
            
            #END add-point
            
 
         #Ctrlp:construct.c.psca040
         ON ACTION controlp INFIELD psca040
            #add-point:ON ACTION controlp INFIELD psca040
            
            #END add-point
         #add--151207-00012#1 By shiun--(E)
         #----<<psca003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca003
            #add-point:BEFORE FIELD psca003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca003
            
            #add-point:AFTER FIELD psca003

            #END add-point
            
 
         #Ctrlp:construct.c.psca003
         ON ACTION controlp INFIELD psca003
            #add-point:ON ACTION controlp INFIELD psca003

            #END add-point
 
         #----<<psca009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca009
            #add-point:BEFORE FIELD psca009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca009
            
            #add-point:AFTER FIELD psca009

            #END add-point
            
 
         #Ctrlp:construct.c.psca009
         ON ACTION controlp INFIELD psca009
            #add-point:ON ACTION controlp INFIELD psca009

            #END add-point
 
         #----<<psca004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca004
            #add-point:BEFORE FIELD psca004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca004
            
            #add-point:AFTER FIELD psca004

            #END add-point
            
 
         #Ctrlp:construct.c.psca004
         ON ACTION controlp INFIELD psca004
            #add-point:ON ACTION controlp INFIELD psca004

            #END add-point
 
         #----<<psca011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca011
            #add-point:BEFORE FIELD psca011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca011
            
            #add-point:AFTER FIELD psca011

            #END add-point
            
 
         #Ctrlp:construct.c.psca011
         ON ACTION controlp INFIELD psca011
            #add-point:ON ACTION controlp INFIELD psca011

            #END add-point
 
         #----<<psca012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca012
            #add-point:BEFORE FIELD psca012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca012
            
            #add-point:AFTER FIELD psca012

            #END add-point
            
 
         #Ctrlp:construct.c.psca012
         ON ACTION controlp INFIELD psca012
            #add-point:ON ACTION controlp INFIELD psca012

            #END add-point
 
         #----<<psca005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca005
            #add-point:BEFORE FIELD psca005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca005
            
            #add-point:AFTER FIELD psca005

            #END add-point
            
 
         #Ctrlp:construct.c.psca005
         ON ACTION controlp INFIELD psca005
            #add-point:ON ACTION controlp INFIELD psca005

            #END add-point
         
         #161015-00001#1-s-mark
         ##----<<psca013>>----
         ##此段落由子樣板a01產生
         #BEFORE FIELD psca013
         #   #add-point:BEFORE FIELD psca013

         #   #END add-point
         #
         ##此段落由子樣板a02產生
         #AFTER FIELD psca013
         #   
         #   #add-point:AFTER FIELD psca013

         #   #END add-point
         #   
         #
         ##Ctrlp:construct.c.psca013
         #ON ACTION controlp INFIELD psca013
         #   #add-point:ON ACTION controlp INFIELD psca013

         #   #END add-point
         #161015-00001#1-e-mark
         
         #----<<psca006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca006
            #add-point:BEFORE FIELD psca006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca006
            
            #add-point:AFTER FIELD psca006

            #END add-point
            
 
         #Ctrlp:construct.c.psca006
         ON ACTION controlp INFIELD psca006
            #add-point:ON ACTION controlp INFIELD psca006

            #END add-point
 
         #----<<psca014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca014
            #add-point:BEFORE FIELD psca014

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca014
            
            #add-point:AFTER FIELD psca014

            #END add-point
            
 
         #Ctrlp:construct.c.psca014
         ON ACTION controlp INFIELD psca014
            #add-point:ON ACTION controlp INFIELD psca014

            #END add-point
 
         #----<<psca007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca007
            #add-point:BEFORE FIELD psca007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca007
            
            #add-point:AFTER FIELD psca007

            #END add-point
            
 
         #Ctrlp:construct.c.psca007
         ON ACTION controlp INFIELD psca007
            #add-point:ON ACTION controlp INFIELD psca007

            #END add-point
 
         #ming 20141020 add -------------------------------------(S) 
         BEFORE FIELD psca035
 
         AFTER FIELD psca035
 
         ON ACTION controlp INFIELD psca035
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psca035      #顯示到畫面上
 
            NEXT FIELD psca035                         #返回原欄位
         #ming 20141020 add -------------------------------------(E) 
         
         #----<<psca008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca008
            #add-point:BEFORE FIELD psca008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca008
            
            #add-point:AFTER FIELD psca008

            #END add-point
            
 
         #Ctrlp:construct.c.psca008
         ON ACTION controlp INFIELD psca008
            #add-point:ON ACTION controlp INFIELD psca008

            #END add-point
 
         #----<<psca015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca015
            #add-point:BEFORE FIELD psca015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca015
            
            #add-point:AFTER FIELD psca015

            #END add-point
            
 
         #Ctrlp:construct.c.psca015
         ON ACTION controlp INFIELD psca015
            #add-point:ON ACTION controlp INFIELD psca015

            #END add-point
 
         #----<<psca032>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca032
            #add-point:BEFORE FIELD psca032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca032
            
            #add-point:AFTER FIELD psca032

            #END add-point
            
 
         #Ctrlp:construct.c.psca032
         ON ACTION controlp INFIELD psca032
            #add-point:ON ACTION controlp INFIELD psca032

            #END add-point
 
         #----<<psca016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca016
            #add-point:BEFORE FIELD psca016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca016
            
            #add-point:AFTER FIELD psca016

            #END add-point
            
 
         #Ctrlp:construct.c.psca016
         ON ACTION controlp INFIELD psca016
            #add-point:ON ACTION controlp INFIELD psca016

            #END add-point
 
         #----<<psca033>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca033
            #add-point:BEFORE FIELD psca033

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca033
            
            #add-point:AFTER FIELD psca033

            #END add-point
            
 
         #Ctrlp:construct.c.psca033
         ON ACTION controlp INFIELD psca033
            #add-point:ON ACTION controlp INFIELD psca033

            #END add-point
 
         #----<<psca017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca017
            #add-point:BEFORE FIELD psca017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca017
            
            #add-point:AFTER FIELD psca017

            #END add-point
            
 
         #Ctrlp:construct.c.psca017
         ON ACTION controlp INFIELD psca017
            #add-point:ON ACTION controlp INFIELD psca017

            #END add-point
 
         #----<<psca034>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca034
            #add-point:BEFORE FIELD psca034

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca034
            
            #add-point:AFTER FIELD psca034

            #END add-point
            
 
         #Ctrlp:construct.c.psca034
         ON ACTION controlp INFIELD psca034
            #add-point:ON ACTION controlp INFIELD psca034

            #END add-point
 
         #----<<psca019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca019
            #add-point:BEFORE FIELD psca019

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca019
            
            #add-point:AFTER FIELD psca019

            #END add-point
            
 
         #Ctrlp:construct.c.psca019
         ON ACTION controlp INFIELD psca019
            #add-point:ON ACTION controlp INFIELD psca019

            #END add-point
 
         #----<<psca020>>----
         #Ctrlp:construct.c.psca020
         ON ACTION controlp INFIELD psca020
            #add-point:ON ACTION controlp INFIELD psca020
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_psba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psca020  #顯示到畫面上

            NEXT FIELD psca020                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD psca020
            #add-point:BEFORE FIELD psca020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca020
            
            #add-point:AFTER FIELD psca020

            #END add-point
            
 
         #----<<psca020_desc>>----
         #----<<psca021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca021
            #add-point:BEFORE FIELD psca021

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca021
            
            #add-point:AFTER FIELD psca021

            #END add-point
            
 
         #Ctrlp:construct.c.psca021
         ON ACTION controlp INFIELD psca021
            #add-point:ON ACTION controlp INFIELD psca021

            #END add-point
 
         #----<<psca031>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca031
            #add-point:BEFORE FIELD psca031

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca031
            
            #add-point:AFTER FIELD psca031

            #END add-point
            
 
         #Ctrlp:construct.c.psca031
         ON ACTION controlp INFIELD psca031
            #add-point:ON ACTION controlp INFIELD psca031

            #END add-point
 
         #----<<psca022>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca022
            #add-point:BEFORE FIELD psca022

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca022
            
            #add-point:AFTER FIELD psca022

            #END add-point
            
 
         #Ctrlp:construct.c.psca022
         ON ACTION controlp INFIELD psca022
            #add-point:ON ACTION controlp INFIELD psca022

            #END add-point
 
         #----<<psca023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca023
            #add-point:BEFORE FIELD psca023

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca023
            
            #add-point:AFTER FIELD psca023

            #END add-point
            
 
         #Ctrlp:construct.c.psca023
         ON ACTION controlp INFIELD psca023
            #add-point:ON ACTION controlp INFIELD psca023

            #END add-point
 
         #----<<psca024>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca024
            #add-point:BEFORE FIELD psca024

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca024
            
            #add-point:AFTER FIELD psca024

            #END add-point
            
 
         #Ctrlp:construct.c.psca024
         ON ACTION controlp INFIELD psca024
            #add-point:ON ACTION controlp INFIELD psca024

            #END add-point
 
         #----<<psca025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca025
            #add-point:BEFORE FIELD psca025

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca025
            
            #add-point:AFTER FIELD psca025

            #END add-point
            
 
         #Ctrlp:construct.c.psca025
         ON ACTION controlp INFIELD psca025
            #add-point:ON ACTION controlp INFIELD psca025

            #END add-point
 
         #----<<psca026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca026
            #add-point:BEFORE FIELD psca026

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca026
            
            #add-point:AFTER FIELD psca026

            #END add-point
            
 
         #Ctrlp:construct.c.psca026
         ON ACTION controlp INFIELD psca026
            #add-point:ON ACTION controlp INFIELD psca026

            #END add-point
 
         #----<<psca027>>----
         #此段落由子樣板a01產生
         #BEFORE FIELD psca027
            #add-point:BEFORE FIELD psca027

            #END add-point
 
         #此段落由子樣板a02產生
         #AFTER FIELD psca027
            
            #add-point:AFTER FIELD psca027

            #END add-point
            
 
         #Ctrlp:construct.c.psca027
         #ON ACTION controlp INFIELD psca027
            #add-point:ON ACTION controlp INFIELD psca027

            #END add-point
 
         #----<<psca028>>----
         #此段落由子樣板a01產生
         #BEFORE FIELD psca028
            #add-point:BEFORE FIELD psca028

            #END add-point
 
         #此段落由子樣板a02產生
         #AFTER FIELD psca028
            
            #add-point:AFTER FIELD psca028

            #END add-point
            
 
         #Ctrlp:construct.c.psca028
         #ON ACTION controlp INFIELD psca028
            #add-point:ON ACTION controlp INFIELD psca028

            #END add-point
 
         #----<<psca029>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca029
            #add-point:BEFORE FIELD psca029

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca029
            
            #add-point:AFTER FIELD psca029

            #END add-point
            
 
         #Ctrlp:construct.c.psca029
         ON ACTION controlp INFIELD psca029
            #add-point:ON ACTION controlp INFIELD psca029

            #END add-point
 
         #----<<psca030>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca030
            #add-point:BEFORE FIELD psca030

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca030
            
            #add-point:AFTER FIELD psca030

            #END add-point
            
 
         #Ctrlp:construct.c.psca030
         ON ACTION controlp INFIELD psca030
            #add-point:ON ACTION controlp INFIELD psca030

            #END add-point
 
         #----<<pscaownid>>----
         #Ctrlp:construct.c.pscaownid
         ON ACTION controlp INFIELD pscaownid
            #add-point:ON ACTION controlp INFIELD pscaownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pscaownid  #顯示到畫面上

            NEXT FIELD pscaownid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD pscaownid
            #add-point:BEFORE FIELD pscaownid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscaownid
            
            #add-point:AFTER FIELD pscaownid

            #END add-point
            
 
         #----<<pscaownid_desc>>----
         #----<<pscaowndp>>----
         #Ctrlp:construct.c.pscaowndp
         ON ACTION controlp INFIELD pscaowndp
            #add-point:ON ACTION controlp INFIELD pscaowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pscaowndp  #顯示到畫面上

            NEXT FIELD pscaowndp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD pscaowndp
            #add-point:BEFORE FIELD pscaowndp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscaowndp
            
            #add-point:AFTER FIELD pscaowndp

            #END add-point
            
 
         #----<<pscaowndp_desc>>----
         #----<<pscacrtid>>----
         #Ctrlp:construct.c.pscacrtid
         ON ACTION controlp INFIELD pscacrtid
            #add-point:ON ACTION controlp INFIELD pscacrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pscacrtid  #顯示到畫面上

            NEXT FIELD pscacrtid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD pscacrtid
            #add-point:BEFORE FIELD pscacrtid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscacrtid
            
            #add-point:AFTER FIELD pscacrtid

            #END add-point
            
 
         #----<<pscacrtid_desc>>----
         #----<<pscacrtdp>>----
         #Ctrlp:construct.c.pscacrtdp
         ON ACTION controlp INFIELD pscacrtdp
            #add-point:ON ACTION controlp INFIELD pscacrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pscacrtdp  #顯示到畫面上

            NEXT FIELD pscacrtdp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD pscacrtdp
            #add-point:BEFORE FIELD pscacrtdp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscacrtdp
            
            #add-point:AFTER FIELD pscacrtdp

            #END add-point
            
 
         #----<<pscacrtdp_desc>>----
         #----<<pscacrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pscacrtdt
            #add-point:BEFORE FIELD pscacrtdt

            #END add-point
 
         #----<<pscamodid>>----
         #Ctrlp:construct.c.pscamodid
         ON ACTION controlp INFIELD pscamodid
            #add-point:ON ACTION controlp INFIELD pscamodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pscamodid  #顯示到畫面上

            NEXT FIELD pscamodid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD pscamodid
            #add-point:BEFORE FIELD pscamodid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscamodid
            
            #add-point:AFTER FIELD pscamodid

            #END add-point
            
 
         #----<<pscamodid_desc>>----
         #----<<pscamoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pscamoddt
            #add-point:BEFORE FIELD pscamoddt

            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pscc002
           FROM s_detail3[1].pscc002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<pscc002>>----
         #Ctrlp:construct.c.page3.pscc002
         ON ACTION controlp INFIELD pscc002
            #add-point:ON ACTION controlp INFIELD pscc002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
			LET g_qryparam.where = "ooba001 = '",g_ooef004,"' " 
            CALL q_ooba002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pscc002  #顯示到畫面上

            NEXT FIELD pscc002                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD pscc002
            #add-point:BEFORE FIELD pscc002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscc002
            
            #add-point:AFTER FIELD pscc002

            #END add-point
            
 
         #----<<pscc002_desc>>----
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON pscd002
           FROM s_detail4[1].pscd002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page2  >---------------------
         #----<<pscd002>>----
         #Ctrlp:construct.c.page4.pscd002
         ON ACTION controlp INFIELD pscd002
            #add-point:ON ACTION controlp INFIELD pscd002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pscd002  #顯示到畫面上

            NEXT FIELD pscd002                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD pscd002
            #add-point:BEFORE FIELD pscd002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscd002
            
            #add-point:AFTER FIELD pscd002

            #END add-point
            
 
         #----<<inaa002>>----
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON psce003,psce002
           FROM s_detail5[1].psce003,s_detail5[1].psce002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page3  >---------------------
         #----<<psce003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psce003
            #add-point:BEFORE FIELD psce003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psce003
            
            #add-point:AFTER FIELD psce003

            #END add-point
            
 
         #Ctrlp:construct.c.page5.psce003
         ON ACTION controlp INFIELD psce003
            #add-point:ON ACTION controlp INFIELD psce003

            #END add-point
 
         #----<<psce002>>----
         #Ctrlp:construct.c.page5.psce002
         ON ACTION controlp INFIELD psce002
            #add-point:ON ACTION controlp INFIELD psce002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_psda001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psce002  #顯示到畫面上

            NEXT FIELD psce002                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD psce002
            #add-point:BEFORE FIELD psce002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psce002
            
            #add-point:AFTER FIELD psce002

            #END add-point
            
 
         #----<<psce002_desc>>----
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)

      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog

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
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前

   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.filter" >}
#+ 此段落由子樣板a50產生
#+ filter過濾功能
PRIVATE FUNCTION apsi002_filter()
   #add-point:filter段define
   
   #end add-point   
 
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON psca001,pscasite,psca002
                          FROM s_browse[1].b_psca001,s_browse[1].b_pscasite,s_browse[1].b_psca002
 
         BEFORE CONSTRUCT
               DISPLAY apsi002_filter_parser('psca001') TO s_browse[1].b_psca001
            DISPLAY apsi002_filter_parser('pscasite') TO s_browse[1].b_pscasite
            DISPLAY apsi002_filter_parser('psca002') TO s_browse[1].b_psca002
      
         #add-point:filter段cs_ctrl
         
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
 
      CALL apsi002_filter_show('psca001')
   CALL apsi002_filter_show('pscasite')
   CALL apsi002_filter_show('psca002')
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apsi002_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
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
 
{<section id="apsi002.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apsi002_filter_show(ps_field)
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
   LET ls_condition = apsi002_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apsi002_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
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
   CALL g_pscc_d.clear()
   CALL g_pscc4_d.clear()
   CALL g_pscc5_d.clear()
 
   
   #add-point:query段other
   CALL g_pscb_d.clear()
   CALL g_gzcb_d.clear() 
   
   CALL cl_set_combo_scc('psca016','5416') 
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL apsi002_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL apsi002_browser_fill("")
      CALL apsi002_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL apsi002_filter_show('psca001')
   CALL apsi002_filter_show('pscasite')
   CALL apsi002_filter_show('psca002')
   CALL apsi002_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   ELSE
      CALL apsi002_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apsi002_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
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
   
   LET g_psca_m.pscasite = g_browser[g_current_idx].b_pscasite
   LET g_psca_m.psca001 = g_browser[g_current_idx].b_psca001
 
   
   #重讀DB,因TEMP有不被更新特性
   #151120-00005#1 20151120 mark by beckxie---S
   ##ming 20141020 modify --------------------------------------------------------------(S) 
   ##EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001 INTO g_psca_m.psca001,g_psca_m.psca002, 
   ##    g_psca_m.pscasite,g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011, 
   ##    g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007, 
   ##    g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017, 
   ##    g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022, 
   ##    g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
   ##    g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp, 
   ##    g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   #EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001
   #                                 INTO g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus,
   #                                      g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
   #                                      g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,
   #                                      #ming 20150521 modify -----------------------------------------------(S) 
   #                                      #g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca008,
   #                                      g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca036,g_psca_m.psca008,
   #                                      #ming 20150521 modify -----------------------------------------------(E) 
   #                                      g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,
   #                                      g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
   #                                      g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,
   #                                      g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,
   #                                      g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
   #                                      g_psca_m.pscacrtdp,g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   ##ming 20141020 modify --------------------------------------------------------------(E) 
   #151120-00005#1 20151120 mark by beckxie---E
   #151120-00005#1 20151120  add by beckxie---S
   EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001
                                    INTO g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus,
                                         #add--151207-00012#1 By shiun--(S)
                                         g_psca_m.psca039,g_psca_m.psca040,
                                         #add--151207-00012#1 By shiun--(E)
                                         g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
                                         #161015-00001#1-s-mod 拿掉psca013
                                         #g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,
                                         g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca006,
                                         #161015-00001#1-e-mod
                                         #ming 20150521 modify -----------------------------------------------(S) 
                                         #g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca008,
                                         g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca038,g_psca_m.psca036,g_psca_m.psca008,
                                         #ming 20150521 modify -----------------------------------------------(E) 
                                         g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,
                                         g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
                                         g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,
                                         g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,
                                         #161015-00001#1-s-mod 拿掉psca043
                                         ##160509-00009#1 20160516 modify by ming -----(S) 
                                         ##g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
                                         #g_psca_m.psca030,
                                         #g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044,
                                         #g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
                                         ##160509-00009#1 20160516 modify by ming -----(E) 
                                         g_psca_m.psca030,g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca044,
                                         g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
                                         #161015-00001#1-e-mod
                                         g_psca_m.pscacrtdp,g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   #151120-00005#1 20151120  add by beckxie---E
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "psca_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      INITIALIZE g_psca_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
   IF g_psca_m.pscastus = 'Y' THEN
      #CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
      CALL cl_set_act_visible("delete",TRUE)
   ELSE
      #CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
      CALL cl_set_act_visible("delete",FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前
   CALL apsi002_get_ooef004() 
   
   CALL cl_set_combo_scc('psca016','5416')
   IF g_psca_m.psca002 = '1' THEN 
      CALL cl_set_combo_scc_part('psca016','5416','1,2')
   END IF

   #end add-point
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #重新顯示   
   CALL apsi002_show()
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.insert" >}
#+ 資料新增
PRIVATE FUNCTION apsi002_insert()
   #add-point:insert段define

   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pscc_d.clear()   
   CALL g_pscc4_d.clear()  
   CALL g_pscc5_d.clear()  
 
 
   INITIALIZE g_psca_m.* LIKE psca_t.*             #DEFAULT 設定
   
   LET g_pscasite_t = NULL
   LET g_psca001_t = NULL
 
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生    
      LET g_psca_m.pscaownid = g_user
      LET g_psca_m.pscaowndp = g_dept
      LET g_psca_m.pscacrtid = g_user
      LET g_psca_m.pscacrtdp = g_dept 
      LET g_psca_m.pscacrtdt = cl_get_current()
      LET g_psca_m.pscamodid = ""
      LET g_psca_m.pscamoddt = ""
      #LET g_psca_m.pscastus = ""
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值
      CALL g_pscb_d.clear() 
      
      LET g_psca_m.pscastus = 'Y'
      #add--151207-00012#1 By shiun--(S)
      LET g_psca_m.psca039 = '1'
      LET g_psca_m.psca040 = 'N'
      #add--151207-00012#1 By shiun--(E)
      LET g_psca_m.pscasite = g_site
      LET g_psca_m.psca005 = 'N'      #Hardpegging可挪用  
      LET g_psca_m.psca007 = 'N'      #手調鎖定可挪用   
      LET g_psca_m.psca009 = 'N'      #處理取替代料   
      LET g_psca_m.psca012 = ''       #保留天數  
      #LET g_psca_m.psca013 = 'N'      #允許庫存批混批供給  #161015-00001#1-mark
      LET g_psca_m.psca014 = 'N'      #庫存無效過期不可延用  
      LET g_psca_m.psca017 = 'N'      #交出嚴守交期時，壓縮非瓶頸資源的前後置時間 
      LET g_psca_m.psca019 = 'N'      #使用MDS   
      LET g_psca_m.psca029 = 'N'      #使用供給法則  
      LET g_psca_m.psca031 = 'N'      #供給法則供給量可提供未指定需求  
      
      LET g_psca_m.psca002 = '2'    
      LET g_psca_m.psca003 = '0'
      LET g_psca_m.psca004 = '1'
      LET g_psca_m.psca006 = '1'
      LET g_psca_m.psca008 = '1'
      LET g_psca_m.psca011 = '1'
      LET g_psca_m.psca015 = '4'
      LET g_psca_m.psca016 = '3'
      LET g_psca_m.psca021 = '2'  
      
      LET g_psca_m.psca036 = 'Y' 
      
      CALL apsi002_get_ooef004()    #取得營運據點單據別參照表編號  
      #151120-00005#1 20151120 add by beckxie---S
      LET g_psca_m.psca037 = 'N'
      LET g_psca_m.psca038 = 'N'
      #151120-00005#1 20151120 add by beckxie---E
      
      #160509-00009#1 20160516 add by ming -----(S) 
      LET g_psca_m.psca041 = 'Y'
      LET g_psca_m.psca042 = 'Y'
      #LET g_psca_m.psca043 = '1'  #161015-00001#1-mark
      LET g_psca_m.psca044 = 'Y'
      #160509-00009#1 20160516 add by ming -----(E) 
      
      LET g_psca_m_t.* = g_psca_m.*
      #end add-point 
     
      CALL apsi002_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_psca_m.* = g_psca_m_t.*
         CALL apsi002_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_pscc_d.clear()
      CALL g_pscc4_d.clear()
      CALL g_pscc5_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   LET g_state = "Y"
   
   LET g_pscasite_t = g_psca_m.pscasite
   LET g_psca001_t = g_psca_m.psca001
 
   
   LET g_wc = g_wc,  
              " OR ( pscaent = '" ||g_enterprise|| "' AND",
              " pscasite = '", g_psca_m.pscasite CLIPPED, "' "
              ," AND psca001 = '", g_psca_m.psca001 CLIPPED, "' "
 
              , ") "
   
   CLOSE apsi002_cl
   
END FUNCTION
 
{</section>}
 
{<section id="apsi002.modify" >}
#+ 資料修改
PRIVATE FUNCTION apsi002_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   #add-point:modify段define

   #end add-point    
   
   IF g_psca_m.pscasite IS NULL OR g_psca_m.psca001 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   #151120-00005#1 20151120 mark by beckxie---S
   ##ming 20141020 modify ---------------------------------------------------------------------------------------(S) 
   ##EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001 INTO g_psca_m.psca001,g_psca_m.psca002, 
   ##    g_psca_m.pscasite,g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011, 
   ##    g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007, 
   ##    g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017, 
   ##    g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022, 
   ##    g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
   ##    g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp, 
   ##    g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   #EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001
   #                                 INTO g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus,
   #                                      g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
   #                                      g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,
   #                                      #ming 20150521 modify --------------------------------------------(S) 
   #                                      #g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca008,
   #                                      g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca036,g_psca_m.psca008,
   #                                      #ming 20150521 modify --------------------------------------------(E) 
   #                                      g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,
   #                                      g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
   #                                      g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,
   #                                      g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,
   #                                      g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
   #                                      g_psca_m.pscacrtdp,g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   ##ming 20141020 modify ---------------------------------------------------------------------------------------(E) 
   #151120-00005#1 20151120 mark by beckxie---E
   #151120-00005#1 20151120  add by beckxie---S
   EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001
                                    INTO g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus,
                                         #add--151207-00012#1 By shiun--(S)
                                         g_psca_m.psca039,g_psca_m.psca040,
                                         #add--151207-00012#1 By shiun--(E)
                                         g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
                                         #161015-00001#1-s-mod 拿掉psca013
                                         #g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,
                                         g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca006,
                                         #161015-00001#1-e-mod
                                         #ming 20150521 modify --------------------------------------------(S) 
                                         #g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca008,
                                         g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca038,g_psca_m.psca036,g_psca_m.psca008,
                                         #ming 20150521 modify --------------------------------------------(E) 
                                         g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,
                                         g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
                                         g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,
                                         g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,
                                         #161015-00001#1-s-mod 拿掉psca043
                                         ##160509-00009#1 20160516 modify by ming -----(S) 
                                         ##g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
                                         #g_psca_m.psca030,
                                         #g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044,
                                         #g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
                                         ##160509-00009#1 20160516 modify by ming -----(E) 
                                         g_psca_m.psca030,g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca044,
                                         g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
                                         #161015-00001#1-e-mod
                                         g_psca_m.pscacrtdp,g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   #151120-00005#1 20151120  add by beckxie---E
   ERROR ""
  
   LET g_pscasite_t = g_psca_m.pscasite
   LET g_psca001_t = g_psca_m.psca001
 
   CALL s_transaction_begin()
   
   OPEN apsi002_cl USING g_enterprise,g_psca_m.pscasite
                                                       ,g_psca_m.psca001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN apsi002_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE apsi002_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   #151120-00005#1 20151120 mark by beckxie---S
   ##ming 20141020 modify ------------------------------------------------------------------------------------(S) 
   ##FETCH apsi002_cl INTO g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite, 
   ##    g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012, 
   ##    g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca008, 
   ##    g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034, 
   ##    g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca020_desc,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022, 
   ##    g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
   ##    g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaownid_desc,g_psca_m.pscaowndp, 
   ##    g_psca_m.pscaowndp_desc,g_psca_m.pscacrtid,g_psca_m.pscacrtid_desc,g_psca_m.pscacrtdp,g_psca_m.pscacrtdp_desc, 
   ##    g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamodid_desc,g_psca_m.pscamoddt
   #FETCH apsi002_cl INTO g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite,
   #                      g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
   #                      g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,
   #                      #ming 20150521 modify ------------------------------------------------------------------(S) 
   #                      #g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca035_desc,g_psca_m.psca008,g_psca_m.psca015,
   #                      g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca035_desc,g_psca_m.psca036,g_psca_m.psca008,g_psca_m.psca015,
   #                      #ming 20150521 modify ------------------------------------------------------------------(E) 
   #                      g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,
   #                      g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca020_desc,g_psca_m.psca021,g_psca_m.psca031,
   #                      g_psca_m.psca022,g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
   #                      g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaownid_desc,
   #                      g_psca_m.pscaowndp,g_psca_m.pscaowndp_desc,g_psca_m.pscacrtid,g_psca_m.pscacrtid_desc,
   #                      g_psca_m.pscacrtdp,g_psca_m.pscacrtdp_desc,g_psca_m.pscacrtdt,g_psca_m.pscamodid,
   #                      g_psca_m.pscamodid_desc,g_psca_m.pscamoddt
   ##ming 20141020 modify ------------------------------------------------------------------------------------(E)
   #151120-00005#1 20151120 mark by beckxie---E
   #151120-00005#1 20151120  add by beckxie---S
   FETCH apsi002_cl INTO g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite,
                         g_psca_m.pscastus,g_psca_m.psca039,g_psca_m.psca040,g_psca_m.l_psea002_1,g_psca_m.psca003,   #modify--151207-00012#1 By shiun  增加psca039、040
                         g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
                         #161015-00001#1-s-mod 拿掉psca013
                         #g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,
                         g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca006,g_psca_m.psca014,
                         #161015-00001#1-e-mod
                         #ming 20150521 modify ------------------------------------------------------------------(S) 
                         #g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca035_desc,g_psca_m.psca008,g_psca_m.psca015,
                         g_psca_m.psca007,g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca035_desc,g_psca_m.psca038,g_psca_m.psca036,g_psca_m.psca008,g_psca_m.psca015,
                         #ming 20150521 modify ------------------------------------------------------------------(E) 
                         g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,
                         g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca020_desc,g_psca_m.psca021,g_psca_m.psca031,
                         g_psca_m.psca022,g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
                         #161015-00001#1-s-mod 拿掉psca043
                         ##160509-00009#1 20160516 modify by ming -----(S) 
                         ##g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaownid_desc,
                         #g_psca_m.psca029,g_psca_m.psca030,
                         #g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044,
                         #g_psca_m.pscaownid,g_psca_m.pscaownid_desc,
                         ##160509-00009#1 20160516 modify by ming -----(E) 
                         g_psca_m.psca029,g_psca_m.psca030,
                         g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca044,
                         g_psca_m.pscaownid,g_psca_m.pscaownid_desc,
                         #161015-00001#1-e-mod
                         g_psca_m.pscaowndp,g_psca_m.pscaowndp_desc,g_psca_m.pscacrtid,g_psca_m.pscacrtid_desc,
                         g_psca_m.pscacrtdp,g_psca_m.pscacrtdp_desc,g_psca_m.pscacrtdt,g_psca_m.pscamodid,
                         g_psca_m.pscamodid_desc,g_psca_m.pscamoddt
   #151120-00005#1 20151120  add by beckxie---E
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_psca_m.pscasite
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      CLOSE apsi002_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
   
   #add-point:modify段show之前

   #end add-point  
   
   CALL apsi002_show()
   WHILE TRUE
      LET g_pscasite_t = g_psca_m.pscasite
      LET g_psca001_t = g_psca_m.psca001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_psca_m.pscamodid = g_user 
LET g_psca_m.pscamoddt = cl_get_current()
 
      
      #add-point:modify段修改前

      #end add-point
      
      CALL apsi002_input("u")     #欄位更改
 
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_psca_m.* = g_psca_m_t.*
         CALL apsi002_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_psca_m.pscasite != g_pscasite_t 
      OR g_psca_m.psca001 != g_psca001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前

         #end add-point
         
         #更新單身key值
         UPDATE pscc_t SET psccsite = g_psca_m.pscasite
                                      ,pscc001 = g_psca_m.psca001
 
          WHERE psccent = g_enterprise AND psccsite = g_pscasite_t
            AND pscc001 = g_psca001_t
 
            
         #add-point:單身fk修改中

         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "pscc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pscc_t"
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
         UPDATE pscd_t
            SET pscdsite = g_psca_m.pscasite
               ,pscd001 = g_psca_m.psca001
 
          WHERE pscdent = g_enterprise AND
                pscdsite = g_pscasite_t
            AND pscd001 = g_psca001_t
 
         #add-point:單身fk修改中

         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "pscd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pscd_t"
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
         UPDATE psce_t
            SET pscesite = g_psca_m.pscasite
               ,psce001 = g_psca_m.psca001
 
          WHERE psceent = g_enterprise AND
                pscesite = g_pscasite_t
            AND psce001 = g_psca001_t
 
         #add-point:單身fk修改中

         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "psce_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "psce_t"
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
   IF NOT cl_log_modified_record(g_psca_m.pscasite,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apsi002_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_psca_m.pscasite,'U')
 
END FUNCTION   
 
{</section>}
 
{<section id="apsi002.input" >}
#+ 資料輸入
PRIVATE FUNCTION apsi002_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
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
   #add-point:input段define
   DEFINE  ls_cnt                LIKE type_t.num5
   DEFINE  li_idx                LIKE type_t.num5 
   #ming 20150818 add -----------------------------------------(S) 
   DEFINE l_pscc002              LIKE pscc_t.pscc002
   DEFINE l_pscd002              LIKE pscd_t.pscd002
   DEFINE l_multi_pscc_ins       LIKE type_t.num5      #是否有開窗多選單據別  
   DEFINE l_multi_pscd_ins       LIKE type_t.num5      #是否有開窗多選庫位 
   #ming 20150818 add -----------------------------------------(E) 
   DEFINE ls_psca001             STRING   #20151020 by stellar add
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

   #end add-point 
   LET g_forupd_sql = "SELECT '','' FROM pscc_t WHERE psccent=? AND psccsite=? AND pscc001=? AND pscc002=?  
       FOR UPDATE"
   #add-point:input段define_sql
   LET g_forupd_sql = "SELECT pscc002,'' FROM pscc_t ", 
                      " WHERE psccent = ? ", 
                      "   AND psccsite = ? ", 
                      "   AND pscc001 = ? ", 
                      "   AND pscc002 = ? ", 
                      "   FOR UPDATE "                       
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apsi002_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql

   #end add-point    
   LET g_forupd_sql = "SELECT '','' FROM pscd_t WHERE pscdent=? AND pscdsite=? AND pscd001=? AND pscd002=?  
       FOR UPDATE"
   #add-point:input段define_sql
   LET g_forupd_sql = "SELECT pscd002,'' FROM pscd_t ", 
                      " WHERE pscdent = ? ", 
                      "   AND pscdsite = ? ", 
                      "   AND pscd001 = ? ", 
                      "   AND pscd002 = ? ", 
                      "   FOR UPDATE " 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apsi002_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql

   #end add-point    
   LET g_forupd_sql = "SELECT '','','' FROM psce_t WHERE psceent=? AND pscesite=? AND psce001=? AND  
       psce002=? FOR UPDATE"
   #add-point:input段define_sql
   LET g_forupd_sql = "SELECT psce003,psce002 FROM psce_t ", 
                      " WHERE psceent = ? ", 
                      "   AND pscesite = ? ", 
                      "   AND psce001 = ? ", 
                      "   AND psce002 = ? ", 
                      "   FOR UPDATE " 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apsi002_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql
   LET g_forupd_sql = "SELECT pscb003,pscb002,pscb004 ",
                      "  FROM pscb_t ",
                      " WHERE pscbent = ? ",
                      "   AND pscbsite = ? ",
                      "   AND pscb001 = ? ",
                      "   AND pscb002 = ? ",
                      "   FOR UPDATE "
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apsi002_bcl4 CURSOR FROM g_forupd_sql
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apsi002_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL apsi002_set_no_entry(p_cmd)
   #151120-00005#1 20151120 mark by beckxie---S
   ##ming 20141020 modify ----------------------------------------------------------(S) 
   ##DISPLAY BY NAME g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite, 
   ##    g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012, 
   ##    g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca008, 
   ##    g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034, 
   ##    g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023, 
   ##    g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029, 
   ##    g_psca_m.psca030
   #DISPLAY BY NAME g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite,
   #    g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012,
   #    g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,
   #    #ming 20150521 add -----------------------------------(S) 
   #    g_psca_m.psca036,
   #    #ming 20150521 add -----------------------------------(E) 
   #    g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,
   #    g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,
   #    g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030
   ##ming 20141020 modify ----------------------------------------------------------(E) 
   #151120-00005#1 20151120 mark by beckxie---E
   #151120-00005#1 20151120  add by beckxie---S
   DISPLAY BY NAME g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite,
       g_psca_m.pscastus,g_psca_m.psca039,g_psca_m.psca040,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012,   #modify--151207-00012#1 By shiun  增加psca039、040
       #161015-00001#1-s-mod 拿掉psca013
       #g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca038,
       g_psca_m.psca005,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca038,
       #161015-00001#1-e-mod
       #ming 20150521 add -----------------------------------(S) 
       g_psca_m.psca036,
       #ming 20150521 add -----------------------------------(E) 
       g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,
       g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,
       g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030
   #151120-00005#1 20151120  add by beckxie---E
   
   #161015-00001#1-s-mod 拿掉psca043
   ##160509-00009#1 20160516 add by ming -----(S) 
   #DISPLAY BY NAME g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044
   ##160509-00009#1 20160516 add by ming -----(E) 
   DISPLAY BY NAME g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca044
   #161015-00001#1-e-mod
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
   IF NOT (l_cmd_t = 'r' AND p_cmd = 'a') THEN
      CALL apsi002_gzcb_b_fill()
   END IF 
   
   CALL cl_set_combo_scc('psca016','5416')
   IF g_psca_m.psca002 = '1' THEN
      CALL cl_set_combo_scc_part('psca016','5416','1,2')
   END IF
   
   #ming 20150818 add -----------------------------------(S) 
   WHILE TRUE
      LET l_multi_pscc_ins = FALSE
      LET l_multi_pscd_ins = FALSE
   #ming 20150818 add -----------------------------------(E) 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
 
{</section>}
 
{<section id="apsi002.input.head" >}
      #單頭段
      #151120-00005#1 20151120 mark by beckxie---S
      ##ming 20141020 modify --------------------------------------------------(S) 
      ##INPUT BY NAME g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite, 
      ##    g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012, 
      ##    g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca008, 
      ##    g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034, 
      ##    g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023, 
      ##    g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029, 
      ##    g_psca_m.psca030 
      #INPUT BY NAME g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite,
      #              g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
      #              g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,
      #              #ming 20150521 modify -----------------------------------------------------------------(S) 
      #              #g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,
      #              g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca036,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,
      #              #ming 20150521 modify -----------------------------------------------------------------(E) 
      #              g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,
      #              g_psca_m.psca020,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,
      #              g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030
      ##ming 20141020 modify --------------------------------------------------(E) 
      #151120-00005#1 20151120 mark by beckxie---E
      #151120-00005#1 20151120  add by beckxie---S
      INPUT BY NAME g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite,
                    g_psca_m.pscastus,g_psca_m.psca039,g_psca_m.psca040,   #modify--151207-00012#1 By shiun   增加psca039、040
                    g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
                    #161015-00001#1-s-mod 拿掉psca013
                    #g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,
                    g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca006,g_psca_m.psca014,
                    #161015-00001#1-e-mod
                    #ming 20150521 modify -----------------------------------------------------------------(S) 
                    #g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,
                    g_psca_m.psca007,g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca038,g_psca_m.psca036,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,
                    #ming 20150521 modify -----------------------------------------------------------------(E) 
                    g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,
                    g_psca_m.psca020,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,
                    g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030, 
                    #161015-00001#1-s-mod 拿掉psca043
                    ##160509-00009#1 20160516 add by ming -----(S) 
                    #g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044
                    ##160509-00009#1 20160516 add by ming -----(E) 
                    g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca044 
                    #161015-00001#1-e-mod
      #151120-00005#1 20151120  add by beckxie---E
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
 
         ON ACTION update_item
            #add-point:ON ACTION update_item

            #END add-point
 
 
         #ON ACTION all_go_left
 
         #   LET g_action_choice="all_go_left"
         #   IF cl_auth_chk_act("all_go_left") THEN 
               #add-point:ON ACTION all_go_left
 
               #END add-point
         #   END IF
 
 
         #ON ACTION all_go_right
 
         #   LET g_action_choice="all_go_right"
         #   IF cl_auth_chk_act("all_go_right") THEN 
               #add-point:ON ACTION all_go_right
 
               #END add-point
         #   END IF
 
 
         #ON ACTION go_left
 
         #   LET g_action_choice="go_left"
         #   IF cl_auth_chk_act("go_left") THEN 
               #add-point:ON ACTION go_left
 
               #END add-point
         #   END IF
 
 
         #ON ACTION go_right
 
         #   LET g_action_choice="go_right"
         #   IF cl_auth_chk_act("go_right") THEN 
               #add-point:ON ACTION go_right
 
               #END add-point
         #   END IF
 
     
         BEFORE INPUT
            LET g_master_multi_table_t.pscal001 = g_psca_m.psca001
            LET g_master_multi_table_t.pscal003 = g_psca_m.pscal003
            LET g_master_multi_table_t.pscal004 = g_psca_m.pscal004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.pscal001 = ''
               LET g_master_multi_table_t.pscal003 = ''
               LET g_master_multi_table_t.pscal004 = ''
 
            END IF
            #add-point:資料輸入前
            NEXT FIELD psca001 
            #end add-point
 
         #---------------------------<  Master  >---------------------------
         #----<<psca001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca001
            #add-point:BEFORE FIELD psca001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca001
            
            #add-point:AFTER FIELD psca001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_psca_m.pscasite) AND NOT cl_null(g_psca_m.psca001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_psca_m.pscasite != g_pscasite_t  OR g_psca_m.psca001 != g_psca001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM psca_t WHERE "||"pscaent = '" ||g_enterprise|| "' AND "||"pscasite = '"||g_psca_m.pscasite ||"' AND "|| "psca001 = '"||g_psca_m.psca001 ||"'",'std-00004',0) THEN 
                     LET  g_psca_m.psca001 = g_psca_m_t.psca001 
                     NEXT FIELD CURRENT
                  END IF 
                  
                  #ming 20141020 add ------------------------------(S) 
                  #雖然說不太可能 但是為求保險 還是設定一下  
                  IF NOT cl_null(g_psca_m.psca035) THEN
                     IF g_psca_m.psca001 = g_psca_m.psca035 THEN
                        LET g_psca_m.psca035 = ''
                        LET g_psca_m.psca035_desc = ''
                        DISPLAY BY NAME g_psca_m.psca035,g_psca_m.psca035_desc
                     END IF
                  END IF
                  #ming 20141020 add ------------------------------(E) 
               END IF
               #161107-00011#1-s-add 僅能輸入數字或英文
               IF NOT s_chr_alphanumeric(g_psca_m.psca001,'3') THEN
                  LET  g_psca_m.psca001 = g_psca_m_t.psca001 
                  NEXT FIELD CURRENT
               END IF
               #161107-00011#1-e-add
               #20151020 by stellar add ----- (S)
               #stellar add:APS版本的欄位控制，不能輸入含有空白的代碼，不然APS在計算寫入log目錄會判斷錯誤
               LET g_psca_m.psca001 = g_psca_m.psca001 CLIPPED
               LET ls_psca001 = g_psca_m.psca001
               IF ls_psca001.getIndexOf(' ',1) > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aps-00139'
                  LET g_errparam.extend = g_psca_m.psca001
                  LET g_errparam.popup = TRUE
                  
                  CALL cl_err()
                  LET g_psca_m.psca001 = g_psca_m_t.psca001 
                  NEXT FIELD psca001
               END IF
               #20151020 by stellar add ----- (E)
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca001
            #add-point:ON CHANGE psca001

            #END add-point
 
         #----<<pscal003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pscal003
            #add-point:BEFORE FIELD pscal003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscal003
            
            #add-point:AFTER FIELD pscal003

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE pscal003
            #add-point:ON CHANGE pscal003

            #END add-point
 
         #----<<pscal004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pscal004
            #add-point:BEFORE FIELD pscal004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscal004
            
            #add-point:AFTER FIELD pscal004

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE pscal004
            #add-point:ON CHANGE pscal004

            #END add-point
 
         #----<<psca002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca002
            #add-point:BEFORE FIELD psca002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca002
            
            #add-point:AFTER FIELD psca002
            CALL cl_set_combo_scc('psca016','5416')
            LET g_psca_m.psca016 = '3'

            IF g_psca_m.psca002 = '1' THEN
               CALL cl_set_combo_scc_part('psca016','5416','1,2')
               LET g_psca_m.psca016 = '2'
            END IF

            DISPLAY BY NAME g_psca_m.psca016
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca002
            #add-point:ON CHANGE psca002

            #END add-point
 
         #----<<pscasite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pscasite
            #add-point:BEFORE FIELD pscasite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscasite
            
            #add-point:AFTER FIELD pscasite
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_psca_m.pscasite) AND NOT cl_null(g_psca_m.psca001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_psca_m.pscasite != g_pscasite_t  OR g_psca_m.psca001 != g_psca001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM psca_t WHERE "||"pscaent = '" ||g_enterprise|| "' AND "||"pscasite = '"||g_psca_m.pscasite ||"' AND "|| "psca001 = '"||g_psca_m.psca001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE pscasite
            #add-point:ON CHANGE pscasite

            #END add-point
 
         #----<<pscastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pscastus
            #add-point:BEFORE FIELD pscastus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD pscastus
            
            #add-point:AFTER FIELD pscastus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE pscastus
            #add-point:ON CHANGE pscastus
            
            #END add-point
         #add--151207-00012#1 By shiun--(S)
         #----<<psca039>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca039
            #add-point:BEFORE FIELD psca039
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca039
            
            #add-point:AFTER FIELD psca039
            
            #END add-point
            
 
         #Ctrlp:construct.c.psca039
         ON CHANGE psca039
            #add-point:ON CHANGE psca039
            
            #END add-point
 
         #----<<psca040>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca040
            #add-point:BEFORE FIELD psca040
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca040
            
            #add-point:AFTER FIELD psca040
            
            #END add-point
            
 
         #Ctrlp:construct.c.psca040
         ON CHANGE psca040
            #add-point:ON CHANGE psca040

            #END add-point
 
         #----<<psca003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca003
            #add-point:BEFORE FIELD psca003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca003
            
            #add-point:AFTER FIELD psca003

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca003
            #add-point:ON CHANGE psca003

            #END add-point
 
         #----<<psca009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca009
            #add-point:BEFORE FIELD psca009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca009
            
            #add-point:AFTER FIELD psca009

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca009
            #add-point:ON CHANGE psca009

            #END add-point
 
         #----<<psca004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca004
            #add-point:BEFORE FIELD psca004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca004
            
            #add-point:AFTER FIELD psca004

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca004
            #add-point:ON CHANGE psca004

            #END add-point
 
         #----<<psca011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca011
            #add-point:BEFORE FIELD psca011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca011
            
            #add-point:AFTER FIELD psca011
            IF g_psca_m.psca011 <> '2' THEN 
               LET g_psca_m.psca012 = '' 
               DISPLAY BY NAME g_psca_m.psca012 
            END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca011
            #add-point:ON CHANGE psca011
            CALL apsi002_set_entry(p_cmd)
            CALL apsi002_set_no_entry(p_cmd)
            #END add-point
 
         #----<<psca012>>----
         #此段落由子樣板a02產生
         AFTER FIELD psca012
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_psca_m.psca012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD psca012
            END IF
 
 
            #add-point:AFTER FIELD psca012
            IF NOT cl_null(g_psca_m.psca012) THEN
               #IF g_psca_m.psca012 < 0 THEN
               #   CALL cl_err('','aps-00061',1)    #天數不可小於0  
               #   LET g_psca_m.psca012 = g_psca_m_t.psca012
               #   DISPLAY BY NAME g_psca_m.psca012
               #   NEXT FIELD CURRENT
               #END IF 
            END IF 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD psca012
            #add-point:BEFORE FIELD psca012

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE psca012
            #add-point:ON CHANGE psca012

            #END add-point
 
         #----<<psca005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca005
            #add-point:BEFORE FIELD psca005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca005
            
            #add-point:AFTER FIELD psca005

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca005
            #add-point:ON CHANGE psca005

            #END add-point
         
         #161015-00001#1-s-mark
         ##----<<psca013>>----
         ##此段落由子樣板a01產生
         #BEFORE FIELD psca013
         #   #add-point:BEFORE FIELD psca013

         #   #END add-point
         #
         ##此段落由子樣板a02產生
         #AFTER FIELD psca013
         #   
         #   #add-point:AFTER FIELD psca013

         #   #END add-point
         #   
         #
         ##此段落由子樣板a04產生
         #ON CHANGE psca013
         #   #add-point:ON CHANGE psca013

         #   #END add-point
         #161015-00001#1-e-mark
         
         #----<<psca006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca006
            #add-point:BEFORE FIELD psca006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca006
            
            #add-point:AFTER FIELD psca006

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca006
            #add-point:ON CHANGE psca006

            #END add-point
 
         #----<<psca014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca014
            #add-point:BEFORE FIELD psca014

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca014
            
            #add-point:AFTER FIELD psca014

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca014
            #add-point:ON CHANGE psca014

            #END add-point
 
         #----<<psca007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca007
            #add-point:BEFORE FIELD psca007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca007
            
            #add-point:AFTER FIELD psca007

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca007
            #add-point:ON CHANGE psca007

            #END add-point
 
         #ming 20141020 add ---------------------------------(S) 
         BEFORE FIELD psca035
 
         AFTER FIELD psca035 
            LET g_psca_m.psca035_desc = ''
            CALL apsi002_psca035_ref(g_psca_m.psca035)
                 RETURNING g_psca_m.psca035_desc
            DISPLAY BY NAME g_psca_m.psca035_desc
         
            IF NOT cl_null(g_psca_m.psca035) THEN
 
               CALL apsi002_chk_psca035()
 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160318-00005#41 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'apsi002'
                        LET g_errparam.replace[2] = cl_get_progname('apsi002',g_lang,"2")
                        LET g_errparam.exeprog = 'apsi002'
                  END CASE
                  #160318-00005#41 --e add
                  LET g_errparam.popup  = TRUE
 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
 
         ON CHANGE psca035
 
         #ming 20141020 add ---------------------------------(E) 
 
         #----<<psca008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca008
            #add-point:BEFORE FIELD psca008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca008
            
            #add-point:AFTER FIELD psca008

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca008
            #add-point:ON CHANGE psca008

            #END add-point
 
         #----<<psca015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca015
            #add-point:BEFORE FIELD psca015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca015
            
            #add-point:AFTER FIELD psca015

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca015
            #add-point:ON CHANGE psca015

            #END add-point
 
         #----<<psca032>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca032
            #add-point:BEFORE FIELD psca032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca032
            
            #add-point:AFTER FIELD psca032

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca032
            #add-point:ON CHANGE psca032

            #END add-point
 
         #----<<psca016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca016
            #add-point:BEFORE FIELD psca016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca016
            
            #add-point:AFTER FIELD psca016

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca016
            #add-point:ON CHANGE psca016

            #END add-point
 
         #----<<psca033>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca033
            #add-point:BEFORE FIELD psca033

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca033
            
            #add-point:AFTER FIELD psca033

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca033
            #add-point:ON CHANGE psca033

            #END add-point
 
         #----<<psca017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca017
            #add-point:BEFORE FIELD psca017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca017
            
            #add-point:AFTER FIELD psca017

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca017
            #add-point:ON CHANGE psca017

            #END add-point
 
         #----<<psca034>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca034
            #add-point:BEFORE FIELD psca034

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca034
            
            #add-point:AFTER FIELD psca034
            IF NOT cl_null(g_psca_m.psca034) THEN 
               IF g_psca_m.psca034 < 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aps-00061'
                  LET g_errparam.extend = g_psca_m.psca034
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  NEXT FIELD psca034 
               END IF 
            END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca034
            #add-point:ON CHANGE psca034

            #END add-point
 
         #----<<psca019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca019
            #add-point:BEFORE FIELD psca019

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca019
            
            #add-point:AFTER FIELD psca019
            
            CALL apsi002_set_no_required(l_cmd) 
            CALL apsi002_set_required(l_cmd) 
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca019
            #add-point:ON CHANGE psca019

            #END add-point
 
         #----<<psca020>>----
         #此段落由子樣板a02產生
         AFTER FIELD psca020
            
            #add-point:AFTER FIELD psca020
            LET g_psca_m.psca020_desc = ' '
            DISPLAY BY NAME g_psca_m.psca020_desc
            IF NOT cl_null(g_psca_m.psca020) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_psca_m.psca020 != g_psca_m_t.psca020 OR
                                                   g_psca_m_t.psca020 IS NULL)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_psca_m.psca020
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aps-00044:sub-01302|apsi001|",cl_get_progname("apsi001",g_lang,"2"),"|:EXEPROGapsi001"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_psba001") THEN
                     LET g_psca_m.psca020 = g_psca_m_t.psca020
                     CALL apsi002_psca020_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apsi002_psca020_ref()
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD psca020
            #add-point:BEFORE FIELD psca020

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE psca020
            #add-point:ON CHANGE psca020

            #END add-point
 
         #----<<psca020_desc>>----
         #----<<psca021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca021
            #add-point:BEFORE FIELD psca021

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca021
            
            #add-point:AFTER FIELD psca021

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca021
            #add-point:ON CHANGE psca021

            #END add-point
 
         #----<<psca031>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca031
            #add-point:BEFORE FIELD psca031

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca031
            
            #add-point:AFTER FIELD psca031

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca031
            #add-point:ON CHANGE psca031

            #END add-point
 
         #----<<psca022>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca022
            #add-point:BEFORE FIELD psca022

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca022
            
            #add-point:AFTER FIELD psca022

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca022
            #add-point:ON CHANGE psca022

            #END add-point
 
         #----<<psca023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca023
            #add-point:BEFORE FIELD psca023

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca023
            
            #add-point:AFTER FIELD psca023

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca023
            #add-point:ON CHANGE psca023

            #END add-point
 
         #----<<psca024>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca024
            #add-point:BEFORE FIELD psca024

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca024
            
            #add-point:AFTER FIELD psca024

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca024
            #add-point:ON CHANGE psca024

            #END add-point
 
         #----<<psca025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca025
            #add-point:BEFORE FIELD psca025

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca025
            
            #add-point:AFTER FIELD psca025

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca025
            #add-point:ON CHANGE psca025

            #END add-point
 
         #----<<psca026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca026
            #add-point:BEFORE FIELD psca026

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca026
            
            #add-point:AFTER FIELD psca026

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca026
            #add-point:ON CHANGE psca026

            #END add-point
 
         #----<<psca027>>----
         #此段落由子樣板a01產生
         #BEFORE FIELD psca027
            #add-point:BEFORE FIELD psca027

            #END add-point
 
         #此段落由子樣板a02產生
         #AFTER FIELD psca027
            
            #add-point:AFTER FIELD psca027

            #END add-point
            
 
         #此段落由子樣板a04產生
         #ON CHANGE psca027
            #add-point:ON CHANGE psca027

            #END add-point
 
         #----<<psca028>>----
         #此段落由子樣板a01產生
         #BEFORE FIELD psca028
            #add-point:BEFORE FIELD psca028

            #END add-point
 
         #此段落由子樣板a02產生
         #AFTER FIELD psca028
            
            #add-point:AFTER FIELD psca028

            #END add-point
            
 
         #此段落由子樣板a04產生
         #ON CHANGE psca028
            #add-point:ON CHANGE psca028

            #END add-point
 
         #----<<psca029>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca029
            #add-point:BEFORE FIELD psca029

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca029
            
            #add-point:AFTER FIELD psca029

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca029
            #add-point:ON CHANGE psca029

            #END add-point
 
         #----<<psca030>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psca030
            #add-point:BEFORE FIELD psca030

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psca030
            
            #add-point:AFTER FIELD psca030

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psca030
            #add-point:ON CHANGE psca030

            #END add-point
 
         #----<<pscaownid>>----
         #----<<pscaownid_desc>>----
         #----<<pscaowndp>>----
         #----<<pscaowndp_desc>>----
         #----<<pscacrtid>>----
         #----<<pscacrtid_desc>>----
         #----<<pscacrtdp>>----
         #----<<pscacrtdp_desc>>----
         #----<<pscacrtdt>>----
         #----<<pscamodid>>----
         #----<<pscamodid_desc>>----
         #----<<pscamoddt>>----
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<psca001>>----
         #Ctrlp:input.c.psca001
         ON ACTION controlp INFIELD psca001
            #add-point:ON ACTION controlp INFIELD psca001

            #END add-point
 
         #----<<pscal003>>----
         #Ctrlp:input.c.pscal003
         ON ACTION controlp INFIELD pscal003
            #add-point:ON ACTION controlp INFIELD pscal003

            #END add-point
 
         #----<<pscal004>>----
         #Ctrlp:input.c.pscal004
         ON ACTION controlp INFIELD pscal004
            #add-point:ON ACTION controlp INFIELD pscal004

            #END add-point
 
         #----<<psca002>>----
         #Ctrlp:input.c.psca002
         ON ACTION controlp INFIELD psca002
            #add-point:ON ACTION controlp INFIELD psca002

            #END add-point
 
         #----<<pscasite>>----
         #Ctrlp:input.c.pscasite
         ON ACTION controlp INFIELD pscasite
            #add-point:ON ACTION controlp INFIELD pscasite

            #END add-point
 
         #----<<pscastus>>----
         #Ctrlp:input.c.pscastus
         ON ACTION controlp INFIELD pscastus
            #add-point:ON ACTION controlp INFIELD pscastus

            #END add-point
         #add--151207-00012#1 By shiun--(S)
         #----<<psca039>>----
         #Ctrlp:input.c.psca039
         ON ACTION controlp INFIELD psca039
            #add-point:ON ACTION controlp INFIELD psca039
 
            #END add-point
         #----<<psca040>>----
         #Ctrlp:input.c.psca040
         ON ACTION controlp INFIELD psca040
            #add-point:ON ACTION controlp INFIELD psca040
 
            #END add-point
         #add--151207-00012#1 By shiun--(E)
         #----<<psca003>>----
         #Ctrlp:input.c.psca003
         ON ACTION controlp INFIELD psca003
            #add-point:ON ACTION controlp INFIELD psca003

            #END add-point
 
         #----<<psca009>>----
         #Ctrlp:input.c.psca009
         ON ACTION controlp INFIELD psca009
            #add-point:ON ACTION controlp INFIELD psca009

            #END add-point
 
         #----<<psca004>>----
         #Ctrlp:input.c.psca004
         ON ACTION controlp INFIELD psca004
            #add-point:ON ACTION controlp INFIELD psca004

            #END add-point
 
         #----<<psca011>>----
         #Ctrlp:input.c.psca011
         ON ACTION controlp INFIELD psca011
            #add-point:ON ACTION controlp INFIELD psca011

            #END add-point
 
         #----<<psca012>>----
         #Ctrlp:input.c.psca012
         ON ACTION controlp INFIELD psca012
            #add-point:ON ACTION controlp INFIELD psca012

            #END add-point
 
         #----<<psca005>>----
         #Ctrlp:input.c.psca005
         ON ACTION controlp INFIELD psca005
            #add-point:ON ACTION controlp INFIELD psca005

            #END add-point
         #161015-00001#1-s-mark
         ##----<<psca013>>----
         ##Ctrlp:input.c.psca013
         #ON ACTION controlp INFIELD psca013
         #   #add-point:ON ACTION controlp INFIELD psca013

         #   #END add-point
         #161015-00001#1-e-mark
         #----<<psca006>>----
         #Ctrlp:input.c.psca006
         ON ACTION controlp INFIELD psca006
            #add-point:ON ACTION controlp INFIELD psca006

            #END add-point
 
         #----<<psca014>>----
         #Ctrlp:input.c.psca014
         ON ACTION controlp INFIELD psca014
            #add-point:ON ACTION controlp INFIELD psca014

            #END add-point
 
         #----<<psca007>>----
         #Ctrlp:input.c.psca007
         ON ACTION controlp INFIELD psca007
            #add-point:ON ACTION controlp INFIELD psca007

            #END add-point
 
         #ming 20141020 add ------------------------------(S) 
         ON ACTION controlp INFIELD psca035
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " psca001 != '",g_psca_m.psca001,"' "
 
            CALL q_psca001()                           #呼叫開窗
            LET g_psca_m.psca035 = g_qryparam.return1
            DISPLAY BY NAME g_psca_m.psca035 
            CALL apsi002_psca035_ref(g_psca_m.psca035)
                 RETURNING g_psca_m.psca035_desc
            DISPLAY BY NAME g_psca_m.psca035_desc
            NEXT FIELD psca035
 
         #ming 20141020 add ------------------------------(E) 
 
         #----<<psca008>>----
         #Ctrlp:input.c.psca008
         ON ACTION controlp INFIELD psca008
            #add-point:ON ACTION controlp INFIELD psca008

            #END add-point
 
         #----<<psca015>>----
         #Ctrlp:input.c.psca015
         ON ACTION controlp INFIELD psca015
            #add-point:ON ACTION controlp INFIELD psca015

            #END add-point
 
         #----<<psca032>>----
         #Ctrlp:input.c.psca032
         ON ACTION controlp INFIELD psca032
            #add-point:ON ACTION controlp INFIELD psca032

            #END add-point
 
         #----<<psca016>>----
         #Ctrlp:input.c.psca016
         ON ACTION controlp INFIELD psca016
            #add-point:ON ACTION controlp INFIELD psca016

            #END add-point
 
         #----<<psca033>>----
         #Ctrlp:input.c.psca033
         ON ACTION controlp INFIELD psca033
            #add-point:ON ACTION controlp INFIELD psca033

            #END add-point
 
         #----<<psca017>>----
         #Ctrlp:input.c.psca017
         ON ACTION controlp INFIELD psca017
            #add-point:ON ACTION controlp INFIELD psca017

            #END add-point
 
         #----<<psca034>>----
         #Ctrlp:input.c.psca034
         ON ACTION controlp INFIELD psca034
            #add-point:ON ACTION controlp INFIELD psca034

            #END add-point
 
         #----<<psca019>>----
         #Ctrlp:input.c.psca019
         ON ACTION controlp INFIELD psca019
            #add-point:ON ACTION controlp INFIELD psca019

            #END add-point
 
         #----<<psca020>>----
         #Ctrlp:input.c.psca020
         ON ACTION controlp INFIELD psca020
            #add-point:ON ACTION controlp INFIELD psca020
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE 
            CALL q_psba001()
            IF NOT cl_null(g_qryparam.return1) THEN
               LET g_psca_m.psca020 = g_qryparam.return1
               DISPLAY BY NAME g_psca_m.psca020
               CALL apsi002_psca020_ref()
            END IF
            NEXT FIELD psca020 
            #END add-point
 
         #----<<psca020_desc>>----
         #----<<psca021>>----
         #Ctrlp:input.c.psca021
         ON ACTION controlp INFIELD psca021
            #add-point:ON ACTION controlp INFIELD psca021

            #END add-point
 
         #----<<psca031>>----
         #Ctrlp:input.c.psca031
         ON ACTION controlp INFIELD psca031
            #add-point:ON ACTION controlp INFIELD psca031

            #END add-point
 
         #----<<psca022>>----
         #Ctrlp:input.c.psca022
         ON ACTION controlp INFIELD psca022
            #add-point:ON ACTION controlp INFIELD psca022

            #END add-point
 
         #----<<psca023>>----
         #Ctrlp:input.c.psca023
         ON ACTION controlp INFIELD psca023
            #add-point:ON ACTION controlp INFIELD psca023

            #END add-point
 
         #----<<psca024>>----
         #Ctrlp:input.c.psca024
         ON ACTION controlp INFIELD psca024
            #add-point:ON ACTION controlp INFIELD psca024

            #END add-point
 
         #----<<psca025>>----
         #Ctrlp:input.c.psca025
         ON ACTION controlp INFIELD psca025
            #add-point:ON ACTION controlp INFIELD psca025

            #END add-point
 
         #----<<psca026>>----
         #Ctrlp:input.c.psca026
         ON ACTION controlp INFIELD psca026
            #add-point:ON ACTION controlp INFIELD psca026

            #END add-point
 
         #----<<psca027>>----
         #Ctrlp:input.c.psca027
         #ON ACTION controlp INFIELD psca027
            #add-point:ON ACTION controlp INFIELD psca027

            #END add-point
 
         #----<<psca028>>----
         #Ctrlp:input.c.psca028
         #ON ACTION controlp INFIELD psca028
            #add-point:ON ACTION controlp INFIELD psca028

            #END add-point
 
         #----<<psca029>>----
         #Ctrlp:input.c.psca029
         ON ACTION controlp INFIELD psca029
            #add-point:ON ACTION controlp INFIELD psca029

            #END add-point
 
         #----<<psca030>>----
         #Ctrlp:input.c.psca030
         ON ACTION controlp INFIELD psca030
            #add-point:ON ACTION controlp INFIELD psca030

            #END add-point
 
         #----<<pscaownid>>----
         #----<<pscaownid_desc>>----
         #----<<pscaowndp>>----
         #----<<pscaowndp_desc>>----
         #----<<pscacrtid>>----
         #----<<pscacrtid_desc>>----
         #----<<pscacrtdp>>----
         #----<<pscacrtdp_desc>>----
         #----<<pscacrtdt>>----
         #----<<pscamodid>>----
         #----<<pscamodid_desc>>----
         #----<<pscamoddt>>----
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME g_psca_m.pscasite             
                            ,g_psca_m.psca001   
 
                            
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前

               #end add-point
               #151120-00005#1 20151120 mark by beckxie---S
               ##ming 20141020 modify -------------------------------------------------------------------(S) 
               ##INSERT INTO psca_t (pscaent,psca001,psca002,pscasite,pscastus,psca003,psca009,psca004, 
               ##    psca011,psca012,psca005,psca013,psca006,psca014,psca007,psca008,psca015,psca032,psca016, 
               ##    psca033,psca017,psca034,psca019,psca020,psca021,psca031,psca022,psca023,psca024,psca025, 
               ##    psca026,psca029,psca030,pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt, 
               ##    pscamodid,pscamoddt)
               ##VALUES (g_enterprise,g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus, 
               ##    g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012, 
               ##    g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007, 
               ##    g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033, 
               ##    g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca021, 
               ##    g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025, 
               ##    g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030, 
               ##    g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp,g_psca_m.pscacrtdt, 
               ##    g_psca_m.pscamodid,g_psca_m.pscamoddt) 
               #INSERT INTO psca_t (pscaent,psca001,psca002,pscasite,pscastus,psca003,psca009,psca004,
               #                    psca011,psca012,psca005,psca013,psca006,psca014,psca007,psca035, 
               #                    #ming 20150521 add ------------------------------------------(S) 
               #                    psca036,
               #                    #ming 20150521 add ------------------------------------------(E) 
               #                    psca008,psca015,psca032,psca016,psca033,psca017,psca034,psca019,
               #                    psca020,psca021,psca031,psca022,psca023,psca024,psca025,psca026,
               #                    psca029,psca030,pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,
               #                    pscamodid,pscamoddt)
               #     VALUES (g_enterprise,g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus,
               #             g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012,
               #             g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,
               #             #ming 20150521 modify ---------------------------------------------------------------(S) 
               #             #g_psca_m.psca035,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,
               #             g_psca_m.psca035,g_psca_m.psca036,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,
               #             #ming 20150521 modify ---------------------------------------------------------------(E) 
               #             g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
               #             g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,g_psca_m.psca024,
               #             g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,
               #             g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp,g_psca_m.pscacrtdt,
               #             g_psca_m.pscamodid,g_psca_m.pscamoddt) 
               ##ming 20141020 modify -------------------------------------------------------------------(E) 
               #151120-00005#1 20151120 mark by beckxie---E
               #151120-00005#1 20151120  add by beckxie---S
               INSERT INTO psca_t (pscaent,psca001,psca002,pscasite,pscastus,psca039,psca040,   #modify--151207-00012#1 By shiun   增加psca039、040
                                   psca003,psca009,psca004,
                                   #161015-00001#1-s-mod 拿掉psca013
                                   #psca011,psca012,psca005,psca013,psca006,psca014,psca007,psca037,psca035,psca038,
                                   psca011,psca012,psca005,psca006,psca014,psca007,psca037,psca035,psca038,
                                   #161015-00001#1-e-mod
                                   #ming 20150521 add ------------------------------------------(S) 
                                   psca036,
                                   #ming 20150521 add ------------------------------------------(E) 
                                   psca008,psca015,psca032,psca016,psca033,psca017,psca034,psca019,
                                   psca020,psca021,psca031,psca022,psca023,psca024,psca025,psca026,
                                   #161015-00001#1-s-mod 拿掉psca043
                                   ##160509-00009#1 20160516 modify by ming -----(S) 
                                   ##psca029,psca030,pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,
                                   #psca029,psca030,
                                   #psca041,psca042,psca043,psca044,
                                   #pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,
                                   ##160509-00009#1 20160516 modify by ming -----(E) 
                                   psca029,psca030,psca041,psca042,psca044,
                                   pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,
                                   #161015-00001#1-e-mod
                                   pscamodid,pscamoddt)
                    VALUES (g_enterprise,g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus,
                            #add--151207-00012#1 By shiun--(S)
                            g_psca_m.psca039,g_psca_m.psca040,
                            #add--151207-00012#1 By shiun--(E)
                            g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012,
                            #161015-00001#1-s-mod 拿掉psca013
                            #g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,
                            g_psca_m.psca005,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,
                            #161015-00001#1-e-mod
                            #ming 20150521 modify ---------------------------------------------------------------(S) 
                            #g_psca_m.psca035,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,
                            g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca038,g_psca_m.psca036,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,
                            #ming 20150521 modify ---------------------------------------------------------------(E) 
                            g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
                            g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,g_psca_m.psca024,
                            #161015-00001#1-s-mod 拿掉psca043
                            ##160509-00009#1 20160516 modify by ming -----(S) 
                            ##g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,
                            #g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030,
                            #g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044,
                            #g_psca_m.pscaownid,
                            ##160509-00009#1 20160516 modify by ming -----(E) 
                            g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030,
                            g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca044,g_psca_m.pscaownid,
                            #161015-00001#1-e-mod
                            g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp,g_psca_m.pscacrtdt,
                            g_psca_m.pscamodid,g_psca_m.pscamoddt) 
               #151120-00005#1 20151120  add by beckxie---E
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_psca_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭新增中

               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_psca_m.psca001 = g_master_multi_table_t.pscal001 AND
         g_psca_m.pscal003 = g_master_multi_table_t.pscal003 AND 
         g_psca_m.pscal004 = g_master_multi_table_t.pscal004  THEN
         ELSE 
            LET l_var_keys[01] = g_psca_m.psca001
            LET l_field_keys[01] = 'pscal001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.pscal001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'pscal002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_psca_m.pscal003
            LET l_fields[01] = 'pscal003'
            LET l_vars[02] = g_psca_m.pscal004
            LET l_fields[02] = 'pscal004'
            LET l_vars[03] = g_site 
            LET l_fields[03] = 'pscalsite'
            LET l_vars[04] = g_enterprise 
            LET l_fields[04] = 'pscalent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pscal_t')
         END IF 
 
               
               #add-point:單頭新增後

               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apsi002_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前

               #end add-point
               #151120-00005#1 20151120 mark by beckxie---S
               ##ming 20141020 modify -----------------------------------------------------------------(S) 
               ##UPDATE psca_t SET (psca001,psca002,pscasite,pscastus,psca003,psca009,psca004,psca011, 
               ##    psca012,psca005,psca013,psca006,psca014,psca007,psca008,psca015,psca032,psca016,psca033, 
               ##    psca017,psca034,psca019,psca020,psca021,psca031,psca022,psca023,psca024,psca025,psca026, 
               ##    psca029,psca030,pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt, 
               ##    pscamodid,pscamoddt) = (g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus, 
               ##    g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012, 
               ##    g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007, 
               ##    g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033, 
               ##    g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca021, 
               ##    g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025, 
               ##    g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030, 
               ##    g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp,g_psca_m.pscacrtdt, 
               ##    g_psca_m.pscamodid,g_psca_m.pscamoddt)
               ## WHERE pscaent = g_enterprise AND pscasite = g_pscasite_t
               ##   AND psca001 = g_psca001_t
               #UPDATE psca_t SET (psca001,psca002,pscasite,pscastus,psca003,psca009,psca004,psca011,
               #                   #ming 20150521 modify -------------------------------------------(S) 
               #                   #psca012,psca005,psca013,psca006,psca014,psca007,psca035,psca008,
               #                   psca012,psca005,psca013,psca006,psca014,psca007,psca035,psca036,psca008,
               #                   #ming 20150521 modify -------------------------------------------(E) 
               #                   psca015,psca032,psca016,psca033,psca017,psca034,psca019,psca020,
               #                   psca021,psca031,psca022,psca023,psca024,psca025,psca026,psca029,
               #                   psca030,pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,
               #                   pscamodid,pscamoddt) = (g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus,
               #                   g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012,
               #                   g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,
               #                   #ming 20150521 modify ---------------------------------------------------------------(S) 
               #                   #g_psca_m.psca035,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,
               #                   g_psca_m.psca035,g_psca_m.psca036,g_psca_m.psca008,g_psca_m.psca015,
               #                   g_psca_m.psca032,g_psca_m.psca016,
               #                   #ming 20150521 modify ---------------------------------------------------------------(E) 
               #                   g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
               #                   g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,g_psca_m.psca024,
               #                   g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,
               #                   g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp,g_psca_m.pscacrtdt, 
               #                   g_psca_m.pscamodid,g_psca_m.pscamoddt)
               # WHERE pscaent = g_enterprise AND pscasite = g_pscasite_t
               #   AND psca001 = g_psca001_t
               ##ming 20141020 modify -----------------------------------------------------------------(E) 
               #151120-00005#1 20151120  add by beckxie---S
               UPDATE psca_t SET (psca001,psca002,pscasite,pscastus,psca039,psca040,   #add--151207-00012#1 By shiun  增加psca039、040
                                  psca003,psca009,psca004,psca011,
                                  #161015-00001#1-s-mod 拿掉psca013
                                  ##ming 20150521 modify -------------------------------------------(S) 
                                  ##psca012,psca005,psca013,psca006,psca014,psca007,psca035,psca008,
                                  #psca012,psca005,psca013,psca006,psca014,psca007,psca037,psca035,psca038,psca036,psca008,
                                  ##ming 20150521 modify -------------------------------------------(E) 
                                  psca012,psca005,psca006,psca014,psca007,psca037,psca035,psca038,psca036,psca008,
                                  #161015-00001#1-e-mod
                                  psca015,psca032,psca016,psca033,psca017,psca034,psca019,psca020,
                                  psca021,psca031,psca022,psca023,psca024,psca025,psca026,psca029,
                                  #161015-00001#1-s-mod 拿掉psca043
                                  ##160509-00009#1 20160516 modify by ming -----(S) 
                                  ##psca030,pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,
                                  #psca030,
                                  #psca041,psca042,psca043,psca044,
                                  #pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,
                                  ##160509-00009#1 20160516 modify by ming -----(E) 
                                  psca030,psca041,psca042,psca044,
                                  pscaownid,pscaowndp,pscacrtid,pscacrtdp,pscacrtdt,
                                  #161015-00001#1-e-mod
                                  pscamodid,pscamoddt) = (g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus,
                                  #add--151207-00012#1 By shiun--(S)
                                  g_psca_m.psca039,g_psca_m.psca040,
                                  #add--151207-00012#1 By shiun--(E)
                                  g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012,
                                  #161015-00001#1-s-mod 拿掉psca013
                                  #g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,
                                  g_psca_m.psca005,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,
                                  #161015-00001#1-e-mod
                                  #ming 20150521 modify ---------------------------------------------------------------(S) 
                                  #g_psca_m.psca035,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,
                                  g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca038,g_psca_m.psca036,g_psca_m.psca008,g_psca_m.psca015,
                                  g_psca_m.psca032,g_psca_m.psca016,
                                  #ming 20150521 modify ---------------------------------------------------------------(E) 
                                  g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
                                  g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,g_psca_m.psca024,
                                  #161015-00001#1-s-mod 拿掉psca043
                                  ##160509-00009#1 20160516 modify by ming -----(S) 
                                  ##g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,
                                  #g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030,
                                  #g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044,
                                  #g_psca_m.pscaownid,
                                  ##160509-00009#1 20160516 modify by ming -----(E) 
                                  g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030,
                                  g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca044,g_psca_m.pscaownid,
                                  #161015-00001#1-e-mod
                                  g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp,g_psca_m.pscacrtdt, 
                                  g_psca_m.pscamodid,g_psca_m.pscamoddt)
                WHERE pscaent = g_enterprise AND pscasite = g_pscasite_t
                  AND psca001 = g_psca001_t
               #151120-00005#1 20151120  add by beckxie---E
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "psca_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭修改中

               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_psca_m.psca001 = g_master_multi_table_t.pscal001 AND
         g_psca_m.pscal003 = g_master_multi_table_t.pscal003 AND 
         g_psca_m.pscal004 = g_master_multi_table_t.pscal004  THEN
         ELSE 
            LET l_var_keys[01] = g_psca_m.psca001
            LET l_field_keys[01] = 'pscal001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.pscal001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'pscal002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_psca_m.pscal003
            LET l_fields[01] = 'pscal003'
            LET l_vars[02] = g_psca_m.pscal004
            LET l_fields[02] = 'pscal004'
            LET l_vars[03] = g_site 
            LET l_fields[03] = 'pscalsite'
            LET l_vars[04] = g_enterprise 
            LET l_fields[04] = 'pscalent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pscal_t')
         END IF 
 
               CALL s_transaction_end('Y','0')
               
               #add-point:單頭修改後

               #end add-point
            END IF
            
            LET g_pscasite_t = g_psca_m.pscasite
            LET g_psca001_t = g_psca_m.psca001
 
            #controlp
            
      END INPUT
   
 
{</section>}
 
{<section id="apsi002.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pscc_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pscc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apsi002_b_fill()
            LET g_rec_b = g_pscc_d.getLength()
            #add-point:資料輸入前
            
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
            OPEN apsi002_cl USING g_enterprise,g_psca_m.pscasite
                                                                ,g_psca_m.psca001
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apsi002_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE apsi002_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_pscc_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pscc_d[l_ac].pscc002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pscc_d_t.* = g_pscc_d[l_ac].*  #BACKUP
               CALL apsi002_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               
               #end add-point  
               CALL apsi002_set_no_entry_b(l_cmd)
               IF NOT apsi002_lock_b("pscc_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apsi002_bcl INTO g_pscc_d[l_ac].pscc002,g_pscc_d[l_ac].pscc002_desc
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_pscc_d_t.pscc002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL apsi002_show()
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
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pscc_d[l_ac].* TO NULL 
            
            LET g_pscc_d_t.* = g_pscc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apsi002_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL apsi002_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pscc_d[li_reproduce_target].* = g_pscc_d[li_reproduce].*
 
               LET g_pscc_d[li_reproduce_target].pscc002 = NULL
 
            END IF
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert
            
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
            SELECT COUNT(*) INTO l_count FROM pscc_t 
             WHERE psccent = g_enterprise AND psccsite = g_psca_m.pscasite
               AND pscc001 = g_psca_m.psca001
 
               AND pscc002 = g_pscc_d[l_ac].pscc002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psca_m.pscasite
               LET gs_keys[2] = g_psca_m.psca001
               LET gs_keys[3] = g_pscc_d[g_detail_idx].pscc002
               CALL apsi002_insert_b('pscc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_pscc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pscc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apsi002_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_pscc_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_pscc_d.deleteElement(l_ac)
               NEXT FIELD pscc002
            END IF
         
            IF g_pscc_d[l_ac].pscc002 IS NOT NULL
 
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
               
               DELETE FROM pscc_t
                WHERE psccent = g_enterprise AND psccsite = g_psca_m.pscasite AND
                                          pscc001 = g_psca_m.psca001 AND
 
                      pscc002 = g_pscc_d_t.pscc002
 
                  
               #add-point:單身刪除中
               
               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pscc_t"
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
               CLOSE apsi002_bcl
               LET l_count = g_pscc_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psca_m.pscasite
               LET gs_keys[2] = g_psca_m.psca001
               LET gs_keys[3] = g_pscc_d[g_detail_idx].pscc002
 
              
         AFTER DELETE 
            #add-point:單身刪除後2
            
            #end add-point
                           CALL apsi002_delete_b('pscc_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<pscc002>>----
         #此段落由子樣板a02產生
         AFTER FIELD pscc002
            
            #add-point:AFTER FIELD pscc002
            #此段落由子樣板a05產生 
            
            LET g_pscc_d[g_detail_idx].pscc002_desc = ' ' 
            DISPLAY BY NAME g_pscc_d[g_detail_idx].pscc002_desc 
            IF g_psca_m.pscasite IS NOT NULL AND g_psca_m.psca001 IS NOT NULL AND g_pscc_d[g_detail_idx].pscc002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_psca_m.pscasite != g_pscasite_t OR g_psca_m.psca001 != g_psca001_t OR g_pscc_d[g_detail_idx].pscc002 != g_pscc_d_t.pscc002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pscc_t WHERE "||"psccent = '" ||g_enterprise|| "' AND "||"psccsite = '"||g_psca_m.pscasite ||"' AND "|| "pscc001 = '"||g_psca_m.psca001 ||"' AND "|| "pscc002 = '"||g_pscc_d[g_detail_idx].pscc002 ||"'",'std-00004',0) THEN 
                     LET g_pscc_d[g_detail_idx].pscc002 = g_pscc_d_t.pscc002
                     CALL apsi002_pscc002_ref(g_detail_idx)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_pscc_d[g_detail_idx].pscc002) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pscc_d[g_detail_idx].pscc002 != g_pscc_d_t.pscc002 OR
                                                   g_pscc_d_t.pscc002 IS NULL)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooef004
                  LET g_chkparam.arg2 = g_pscc_d[g_detail_idx].pscc002

                  IF NOT cl_chk_exist("v_ooba002") THEN
                     LET g_pscc_d[g_detail_idx].pscc002 = g_pscc_d_t.pscc002
                     CALL apsi002_pscc002_ref(g_detail_idx)
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF
            CALL apsi002_pscc002_ref(g_detail_idx)
            
            #IF  g_psca_m.pscasite IS NOT NULL AND g_psca_m.psca001 IS NOT NULL AND g_gzcb3_d[g_detail_idx].pscc002 IS NOT NULL THEN 
            #   IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_psca_m.pscasite != g_pscasite_t OR g_psca_m.psca001 != g_psca001_t OR g_gzcb3_d[g_detail_idx].pscc002 != g_gzcb3_d_t.pscc002)) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pscc_t WHERE "||"psccent = '" ||g_enterprise|| "' AND "||"psccsite = '"||g_psca_m.pscasite ||"' AND "|| "pscc001 = '"||g_psca_m.psca001 ||"' AND "|| "pscc002 = '"||g_gzcb3_d[g_detail_idx].pscc002 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD pscc002
            #add-point:BEFORE FIELD pscc002
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE pscc002
            #add-point:ON CHANGE pscc002
            
            #END add-point
 
         #----<<pscc002_desc>>----
 
         #---------------------<  Detail: page1  >---------------------
         #----<<pscc002>>----
         #Ctrlp:input.c.page3.pscc002
         ON ACTION controlp INFIELD pscc002
            #add-point:ON ACTION controlp INFIELD pscc002
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            #ming 20150821 modify ---------------------------(S) 
            #LET g_qryparam.state = 'i'
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            ELSE
               LET g_qryparam.state = 'i'
            END IF
            #ming 20150821 modify ---------------------------(E) 
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pscc_d[l_ac].pscc002             #給予default值
            LET g_qryparam.where = "ooba001 = '",g_ooef004,"' " 

            #給予arg 

            CALL q_ooba002()                                #呼叫開窗

            #ming 20150821 modify ---------------------------------(S) 
            #IF NOT cl_null(g_qryparam.return1) THEN
            #
            #   LET g_pscc_d[l_ac].pscc002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #
            #   #DISPLAY g_pscc_d[l_ac].pscc002 TO pscc002              #顯示到畫面上
            #   CALL apsi002_pscc002_ref(l_ac)
            #END IF
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  IF g_qryparam.str_array.getLength() = 1 THEN   #如果只有一筆時，就走原本的流程  
                     #將開窗取得的值回傳到變數 
                     LET g_pscc_d[l_ac].pscc002 = g_qryparam.str_array[1]
                     CALL apsi002_pscc002_ref(l_ac)
                  ELSE
                     LET l_multi_pscc_ins = TRUE
                     CALL apsi002_unlock_b("pscc_t","'1'")
                     CALL s_transaction_end('Y','0')
                     EXIT DIALOG
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_qryparam.return1) THEN

                  LET g_pscc_d[l_ac].pscc002 = g_qryparam.return1              #將開窗取得的值回傳到變數

                  #DISPLAY g_pscc_d[l_ac].pscc002 TO pscc002              #顯示到畫面上
                  CALL apsi002_pscc002_ref(l_ac)
               END IF
            END IF
            #ming 20150821 modify ---------------------------------(E) 
            NEXT FIELD pscc002                          #返回原欄位


            #END add-point
 
         #----<<pscc002_desc>>----
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_pscc_d[l_ac].* = g_pscc_d_t.*
               CLOSE apsi002_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_pscc_d[l_ac].pscc002
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_pscc_d[l_ac].* = g_pscc_d_t.*
            ELSE
            
               #add-point:單身修改前
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE pscc_t SET (psccsite,pscc001,pscc002) = (g_psca_m.pscasite,g_psca_m.psca001,g_pscc_d[l_ac].pscc002) 
 
                WHERE psccent = g_enterprise AND psccsite = g_psca_m.pscasite 
                  AND pscc001 = g_psca_m.psca001 
 
                  AND pscc002 = g_pscc_d_t.pscc002 #項次   
 
                  
               #add-point:單身修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pscc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_pscc_d[l_ac].* = g_pscc_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pscc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                     LET g_pscc_d[l_ac].* = g_pscc_d_t.*                     
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psca_m.pscasite
               LET gs_keys_bak[1] = g_pscasite_t
               LET gs_keys[2] = g_psca_m.psca001
               LET gs_keys_bak[2] = g_psca001_t
               LET gs_keys[3] = g_pscc_d[g_detail_idx].pscc002
               LET gs_keys_bak[3] = g_pscc_d_t.pscc002
               CALL apsi002_update_b('pscc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row
            
            #end add-point
            CALL apsi002_unlock_b("pscc_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_pscc_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_pscc_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_pscc4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pscc4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apsi002_b_fill()
            LET g_rec_b = g_pscc4_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pscc4_d[l_ac].* TO NULL 
            
            LET g_pscc4_d_t.* = g_pscc4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apsi002_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL apsi002_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pscc4_d[li_reproduce_target].* = g_pscc4_d[li_reproduce].*
 
               LET g_pscc4_d[li_reproduce_target].pscd002 = NULL
            END IF
            #公用欄位給值(單身2)
            
            
            #add-point:modify段before insert
            
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
            OPEN apsi002_cl USING g_enterprise,g_psca_m.pscasite
                                                                ,g_psca_m.psca001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apsi002_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE apsi002_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_pscc4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pscc4_d[l_ac].pscd002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_pscc4_d_t.* = g_pscc4_d[l_ac].*  #BACKUP
               CALL apsi002_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               
               #end add-point  
               CALL apsi002_set_no_entry_b(l_cmd)
               IF NOT apsi002_lock_b("pscd_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apsi002_bcl2 INTO g_pscc4_d[l_ac].pscd002,g_pscc4_d[l_ac].inaa002
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL apsi002_show()
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
            IF l_cmd = 'a' AND g_pscc4_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_pscc4_d.deleteElement(l_ac)
               NEXT FIELD pscd002
            END IF
         
            IF g_pscc4_d[l_ac].pscd002 IS NOT NULL
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
               
               DELETE FROM pscd_t
                WHERE pscdent = g_enterprise AND pscdsite = g_psca_m.pscasite AND
                                          pscd001 = g_psca_m.psca001 AND
                      pscd002 = g_pscc4_d_t.pscd002
                  
               #add-point:單身2刪除中
               
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pscc_t"
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
               CLOSE apsi002_bcl
               LET l_count = g_pscc_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psca_m.pscasite
               LET gs_keys[2] = g_psca_m.psca001
               LET gs_keys[3] = g_pscc4_d[g_detail_idx].pscd002
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
            
            #end add-point
                           CALL apsi002_delete_b('pscd_t',gs_keys,"'2'")
 
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
            SELECT COUNT(*) INTO l_count FROM pscd_t 
             WHERE pscdent = g_enterprise AND pscdsite = g_psca_m.pscasite
               AND pscd001 = g_psca_m.psca001
               AND pscd002 = g_pscc4_d[l_ac].pscd002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psca_m.pscasite
               LET gs_keys[2] = g_psca_m.psca001
               LET gs_keys[3] = g_pscc4_d[g_detail_idx].pscd002
               CALL apsi002_insert_b('pscd_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_pscc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pscd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apsi002_b_fill()
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
               LET g_pscc4_d[l_ac].* = g_pscc4_d_t.*
               CLOSE apsi002_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_pscc4_d[l_ac].* = g_pscc4_d_t.*
            ELSE
               #add-point:單身page2修改前
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               UPDATE pscd_t SET (pscdsite,pscd001,pscd002) = (g_psca_m.pscasite,g_psca_m.psca001,g_pscc4_d[l_ac].pscd002)  
                   #自訂欄位頁簽
                WHERE pscdent = g_enterprise AND pscdsite = g_psca_m.pscasite
                  AND pscd001 = g_psca_m.psca001
                  AND pscd002 = g_pscc4_d_t.pscd002 #項次 
                  
               #add-point:單身page2修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pscd_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_pscc4_d[l_ac].* = g_pscc4_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pscd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_pscc4_d[l_ac].* = g_pscc4_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psca_m.pscasite
               LET gs_keys_bak[1] = g_pscasite_t
               LET gs_keys[2] = g_psca_m.psca001
               LET gs_keys_bak[2] = g_psca001_t
               LET gs_keys[3] = g_pscc4_d[g_detail_idx].pscd002
               LET gs_keys_bak[3] = g_pscc4_d_t.pscd002
               CALL apsi002_update_b('pscd_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page2修改後
               
               #end add-point
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<pscd002>>----
         #此段落由子樣板a02產生
         AFTER FIELD pscd002
            
            #add-point:AFTER FIELD pscd002
            #此段落由子樣板a05產生
            
            LET g_pscc4_d[g_detail_idx].inaa002 = ' ' 
            DISPLAY BY NAME g_pscc4_d[g_detail_idx].inaa002 
             IF  g_psca_m.pscasite IS NOT NULL AND g_psca_m.psca001 IS NOT NULL AND g_pscc4_d[g_detail_idx].pscd002 IS NOT NULL THEN 
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_psca_m.pscasite != g_pscasite_t OR g_psca_m.psca001 != g_psca001_t OR g_pscc4_d[g_detail_idx].pscd002 != g_pscc4_d_t.pscd002)) THEN 
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pscd_t WHERE "||"pscdent = '" ||g_enterprise|| "' AND "||"pscdsite = '"||g_psca_m.pscasite ||"' AND "|| "pscd001 = '"||g_psca_m.psca001 ||"' AND "|| "pscd002 = '"||g_pscc4_d[g_detail_idx].pscd002 ||"'",'std-00004',0) THEN 
                      LET g_pscc4_d[g_detail_idx].pscd002 = g_pscc4_d_t.pscd002
                      CALL apsi002_pscd002_ref(g_detail_idx)
                      NEXT FIELD CURRENT
                   END IF
                END IF
             END IF
             
             IF NOT cl_null(g_pscc4_d[g_detail_idx].pscd002) THEN
               IF l_cmd = 'a' OR (p_cmd = 'u' AND (g_pscc4_d[g_detail_idx].pscd002 != g_pscc4_d_t.pscd002 OR
                                                   g_pscc4_d_t.pscd002 IS NULL)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_psca_m.pscasite
                  LET g_chkparam.arg2 = g_pscc4_d[g_detail_idx].pscd002
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     LET g_pscc4_d[g_detail_idx].pscd002 =g_pscc4_d_t.pscd002
                     CALL apsi002_pscd002_ref(g_detail_idx)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apsi002_pscd002_ref(g_detail_idx)
            
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD pscd002
            #add-point:BEFORE FIELD pscd002
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE pscd002
            #add-point:ON CHANGE pscd002
            
            #END add-point
 
         #----<<inaa002>>----
 
         #---------------------<  Detail: page2  >---------------------
         #----<<pscd002>>----
         #Ctrlp:input.c.page4.pscd002
         ON ACTION controlp INFIELD pscd002
            #add-point:ON ACTION controlp INFIELD pscd002
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            #ming 20150818 modify ---------------------------------(S) 
            #LET g_qryparam.state = 'i'
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            ELSE
               LET g_qryparam.state = 'i'
            END IF
            #ming 20150818 modify ---------------------------------(E) 
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pscc4_d[l_ac].pscd002             #給予default值

            #給予arg

            CALL q_inaa001()                                #呼叫開窗

            #ming 20150818 modify ------------------------------------(S) 
            #IF NOT cl_null(g_qryparam.return1) THEN
            #   LET g_pscc4_d[l_ac].pscd002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #
            #   #DISPLAY g_pscc4_d[l_ac].pscd002 TO pscd002              #顯示到畫面上
            #   CALL apsi002_pscd002_ref(l_ac)
            #END IF

            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN

                  IF g_qryparam.str_array.getLength() = 1 THEN
                     LET g_pscc4_d[l_ac].pscd002 = g_qryparam.str_array[1]           #將開窗取得的值回傳到變數
                     CALL apsi002_pscd002_ref(l_ac)
                  ELSE
                     LET l_multi_pscd_ins = TRUE
                     CALL apsi002_unlock_b("pscd_t","'2'")
                     CALL s_transaction_end('Y','0')
                     EXIT DIALOG
                  END IF

               END IF
            ELSE
               IF NOT cl_null(g_qryparam.return1) THEN
                  LET g_pscc4_d[l_ac].pscd002 = g_qryparam.return1              #將開窗取得的值回傳到變數

                  #DISPLAY g_pscc4_d[l_ac].pscd002 TO pscd002              #顯示到畫面上
                  CALL apsi002_pscd002_ref(l_ac)
               END IF
            END IF
            #ming 20150818 modify ------------------------------------(E) 
            NEXT FIELD pscd002                          #返回原欄位


            #END add-point
 
         #----<<inaa002>>----
 
 
         AFTER ROW
            #add-point:單身page2 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pscc4_d[l_ac].* = g_pscc4_d_t.*
               END IF
               CLOSE apsi002_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL apsi002_unlock_b("pscd_t","'2'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_pscc4_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_pscc4_d.getLength()+1
 
      END INPUT
      INPUT ARRAY g_pscc5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pscc5_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apsi002_b_fill()
            LET g_rec_b = g_pscc5_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pscc5_d[l_ac].* TO NULL 
            
            LET g_pscc5_d_t.* = g_pscc5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apsi002_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL apsi002_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pscc5_d[li_reproduce_target].* = g_pscc5_d[li_reproduce].*
 
               LET g_pscc5_d[li_reproduce_target].psce002 = NULL
            END IF
            #公用欄位給值(單身3)
            
            
            #add-point:modify段before insert
            NEXT FIELD psce003 
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
            OPEN apsi002_cl USING g_enterprise,g_psca_m.pscasite
                                                                ,g_psca_m.psca001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apsi002_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE apsi002_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_pscc5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pscc5_d[l_ac].psce002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_pscc5_d_t.* = g_pscc5_d[l_ac].*  #BACKUP
               CALL apsi002_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               
               #end add-point  
               CALL apsi002_set_no_entry_b(l_cmd)
               IF NOT apsi002_lock_b("psce_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apsi002_bcl3 INTO g_pscc5_d[l_ac].psce003,g_pscc5_d[l_ac].psce002,g_pscc5_d[l_ac].psce002_desc 
 
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL apsi002_show()
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
            IF l_cmd = 'a' AND g_pscc5_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_pscc5_d.deleteElement(l_ac)
               NEXT FIELD psce002
            END IF
         
            IF g_pscc5_d[l_ac].psce002 IS NOT NULL
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
               
               #add-point:單身3刪除前
               
               #end add-point    
               
               DELETE FROM psce_t
                WHERE psceent = g_enterprise AND pscesite = g_psca_m.pscasite AND
                                          psce001 = g_psca_m.psca001 AND
                      psce002 = g_pscc5_d_t.psce002
                  
               #add-point:單身3刪除中
               
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pscc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身3刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE apsi002_bcl
               LET l_count = g_pscc_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psca_m.pscasite
               LET gs_keys[2] = g_psca_m.psca001
               LET gs_keys[3] = g_pscc5_d[g_detail_idx].psce002
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
            
            #end add-point
                           CALL apsi002_delete_b('psce_t',gs_keys,"'3'")
 
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
               
            #add-point:單身3新增前
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM psce_t 
             WHERE psceent = g_enterprise AND pscesite = g_psca_m.pscasite
               AND psce001 = g_psca_m.psca001
               AND psce002 = g_pscc5_d[l_ac].psce002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psca_m.pscasite
               LET gs_keys[2] = g_psca_m.psca001
               LET gs_keys[3] = g_pscc5_d[g_detail_idx].psce002
               CALL apsi002_insert_b('psce_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_pscc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "psce_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apsi002_b_fill()
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
               LET g_pscc5_d[l_ac].* = g_pscc5_d_t.*
               CLOSE apsi002_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_pscc5_d[l_ac].* = g_pscc5_d_t.*
            ELSE
               #add-point:單身page3修改前
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               UPDATE psce_t SET (pscesite,psce001,psce003,psce002) = (g_psca_m.pscasite,g_psca_m.psca001, 
                   g_pscc5_d[l_ac].psce003,g_pscc5_d[l_ac].psce002) #自訂欄位頁簽
                WHERE psceent = g_enterprise AND pscesite = g_psca_m.pscasite
                  AND psce001 = g_psca_m.psca001
                  AND psce002 = g_pscc5_d_t.psce002 #項次 
                  
               #add-point:單身page3修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "psce_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_pscc5_d[l_ac].* = g_pscc5_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "psce_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_pscc5_d[l_ac].* = g_pscc5_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_psca_m.pscasite
               LET gs_keys_bak[1] = g_pscasite_t
               LET gs_keys[2] = g_psca_m.psca001
               LET gs_keys_bak[2] = g_psca001_t
               LET gs_keys[3] = g_pscc5_d[g_detail_idx].psce002
               LET gs_keys_bak[3] = g_pscc5_d_t.psce002
               CALL apsi002_update_b('psce_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page3修改後
               
               #end add-point
            END IF
         
         #---------------------<  Detail: page3  >---------------------
         #----<<psce003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD psce003
            #add-point:BEFORE FIELD psce003
            IF cl_null(g_pscc5_d[g_detail_idx].psce003) OR g_pscc5_d[g_detail_idx].psce003 = 0 THEN 
               SELECT MAX(psce003) + 1 INTO g_pscc5_d[g_detail_idx].psce003 
                 FROM psce_t 
                WHERE psceent = g_enterprise 
                  AND pscesite = g_site 
                  AND psce001 = g_psca_m.psca001 
			   
               IF cl_null(g_pscc5_d[g_detail_idx].psce003) THEN 
                  LET g_pscc5_d[g_detail_idx].psce003 = 1 
               END IF  
            
            END IF 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD psce003
            
            #add-point:AFTER FIELD psce003
            IF NOT cl_null(g_pscc5_d[g_detail_idx].psce003) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pscc5_d[g_detail_idx].psce003 != g_pscc5_d_t.psce003 OR
                                                   g_pscc5_d_t.psce003 IS NULL)) THEN 
                                                   
                  IF g_pscc5_d[g_detail_idx].psce003 <= 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aps-00063'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
    #顺序不可小於1
                     LET g_pscc5_d[g_detail_idx].psce003 = g_pscc5_d_t.psce003 
                     NEXT FIELD CURRENT 
                  END IF 
                  
                  LET l_count = 0
                  SELECT COUNT(*) INTO l_count
                    FROM psce_t
                   WHERE psceent = g_enterprise
                     AND pscesite = g_psca_m.pscasite
                     AND psce001 = g_psca_m.psca001
                     AND psce003 = g_pscc5_d[g_detail_idx].psce003

                  IF l_count > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aps-00062'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
     #顺序不可重复！
                     LET g_pscc5_d[g_detail_idx].psce003 = g_pscc5_d_t.psce003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE psce003
            #add-point:ON CHANGE psce003
            
            #END add-point
 
         #----<<psce002>>----
         #此段落由子樣板a02產生
         AFTER FIELD psce002
            
            #add-point:AFTER FIELD psce002
            #此段落由子樣板a05產生          
            
            LET g_pscc5_d[g_detail_idx].psce002_desc = ' '
            DISPLAY BY NAME g_pscc5_d[g_detail_idx].psce002_desc
            IF  g_psca_m.pscasite IS NOT NULL AND g_psca_m.psca001 IS NOT NULL AND g_pscc5_d[g_detail_idx].psce002 IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_psca_m.pscasite != g_pscasite_t OR g_psca_m.psca001 != g_psca001_t OR g_pscc5_d[g_detail_idx].psce002 != g_pscc5_d_t.psce002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM psce_t WHERE "||"psceent = '" ||g_enterprise|| "' AND "||"pscesite = '"||g_psca_m.pscasite ||"' AND "|| "psce001 = '"||g_psca_m.psca001 ||"' AND "|| "psce002 = '"||g_pscc5_d[g_detail_idx].psce002 ||"'",'std-00004',0) THEN 
                     LET g_pscc5_d[g_detail_idx].psce002 = g_pscc5_d_t.psce002
                     CALL apsi002_psce002_ref(g_detail_idx)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_pscc5_d[g_detail_idx].psce002) THEN
               INITIALIZE g_chkparam.* TO NULL 
               LET g_chkparam.arg1 = g_psca_m.pscasite 
               LET g_chkparam.arg2 = g_pscc5_d[g_detail_idx].psce002 

               IF NOT cl_chk_exist("v_psda001") THEN    
                  LET g_pscc5_d[g_detail_idx].psce002 = g_pscc5_d_t.psce002 
                  CALL apsi002_psce002_ref(g_detail_idx) 
                  NEXT FIELD CURRENT 
               END IF 
            END IF

            CALL apsi002_psce002_ref(g_detail_idx)


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD psce002
            #add-point:BEFORE FIELD psce002
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE psce002
            #add-point:ON CHANGE psce002
 
            #END add-point
 
         #----<<psce002_desc>>----
 
         #---------------------<  Detail: page3  >---------------------
         #----<<psce003>>----
         #Ctrlp:input.c.page5.psce003
         ON ACTION controlp INFIELD psce003
            #add-point:ON ACTION controlp INFIELD psce003
            
            #END add-point
 
         #----<<psce002>>----
         #Ctrlp:input.c.page5.psce002
         ON ACTION controlp INFIELD psce002
            #add-point:ON ACTION controlp INFIELD psce002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pscc5_d[l_ac].psce002             #給予default值

            #給予arg

            CALL q_psda001()                                      #呼叫開窗

            IF NOT cl_null(g_qryparam.return1) THEN
               LET g_pscc5_d[l_ac].psce002 = g_qryparam.return1      #將開窗取得的值回傳到變數

               #DISPLAY g_pscc5_d[l_ac].psce002 TO psce002            #顯示到畫面上
               CALL apsi002_psce002_ref(l_ac)
            END IF
            NEXT FIELD psce002                                    #返回原欄位
            #END add-point
 
         #----<<psce002_desc>>----
 
 
         AFTER ROW
            #add-point:單身page3 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pscc5_d[l_ac].* = g_pscc5_d_t.*
               END IF
               CLOSE apsi002_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL apsi002_unlock_b("psce_t","'3'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_pscc5_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_pscc5_d.getLength()+1
 
      END INPUT
 
      
 
      
 
      
 
      
 
{</section>}
 
{<section id="apsi002.input.other" >}
      
      #add-point:自定義input
      DISPLAY ARRAY g_gzcb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)

         BEFORE ROW
            CALL apsi002_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            LET g_detail_idx = l_ac

         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            LET g_current_page = 1
            CALL apsi002_idx_chk()
            
      END DISPLAY 
      
      
      INPUT ARRAY g_pscb_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = FALSE,
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_pscb_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL apsi002_b_fill()
            LET g_rec_b = g_pscb_d.getLength()


         BEFORE INSERT

         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN apsi002_cl USING g_enterprise,g_psca_m.pscasite,g_psca_m.psca001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apsi002_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE apsi002_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            LET g_rec_b = g_pscb_d.getLength()

            IF g_rec_b >= l_ac
               AND g_pscb_d[l_ac].pscb002 IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_pscb_d_t.* = g_pscb_d[l_ac].*  #BACKUP
               CALL apsi002_set_entry_b(l_cmd)
 
               CALL apsi002_set_no_entry_b(l_cmd)
               IF NOT apsi002_lock_b("pscb_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apsi002_bcl4 INTO g_pscb_d[l_ac].pscb003,g_pscb_d[l_ac].pscb002,g_pscb_d[l_ac].pscb004
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL apsi002_show()
                  LET g_bfill = "Y"

                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pscb_d[l_ac].* = g_pscb_d_t.*
               CLOSE apsi002_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pscb_d[l_ac].* = g_pscb_d_t.*
            ELSE
               UPDATE pscb_t SET pscbsite = g_psca_m.pscasite,
                                 pscb001  = g_psca_m.psca001,
                                 pscb002  = g_pscb_d[l_ac].pscb002,
                                 pscb003  = g_pscb_d[l_ac].pscb003,
                                 pscb004  = g_pscb_d[l_ac].pscb004
                WHERE pscbent  = g_enterprise
                  AND pscbsite = g_psca_m.pscasite
                  AND pscb001  = g_psca_m.psca001
                  AND pscb002  = g_pscb_d_t.pscb002

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pscb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_pscb_d[l_ac].* = g_pscb_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pscb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_pscb_d[l_ac].* = g_pscb_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL
                     LET gs_keys[1] = g_psca_m.pscasite
                     LET gs_keys_bak[1] = g_pscasite_t
                     LET gs_keys[2] = g_psca_m.psca001
                     LET gs_keys_bak[2] = g_psca001_t
                     LET gs_keys[3] = g_pscb_d[g_detail_idx].pscb002
                     LET gs_keys_bak[3] = g_pscb_d_t.pscb002
                     #不會與其他table之間的連動 
                     #CALL apsi002_update_b('pscb_t',gs_keys,gs_keys_bak,"'4'") 

               END CASE
           END IF 

         AFTER ROW
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pscb_d[l_ac].* = g_pscb_d_t.*
               END IF
               CLOSE apsi002_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF 


            CALL apsi002_unlock_b("pscb_t","'4'")
            CALL s_transaction_end('Y','0')

      END INPUT
      
      ON ACTION all_go_left
      
         LET g_action_choice="all_go_left"
         IF cl_auth_chk_act("all_go_left") THEN
            IF g_psca_m.pscastus =  'N' THEN
               EXIT DIALOG
            END IF
            IF NOT cl_null(g_psca_m.psca001) THEN
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt
                 FROM pscb_t
                WHERE pscbent = g_enterprise
                  AND pscbsite = g_psca_m.pscasite
                  AND pscb001 = g_psca_m.psca001
      
               IF ls_cnt > 0 THEN
                  FOR li_idx = 1 TO g_pscb_d.getLength()
                     DELETE FROM pscb_t WHERE pscbent = g_enterprise
                                          AND pscbsite = g_psca_m.pscasite
                                          AND pscb001 = g_psca_m.psca001
                                          AND pscb002 = g_pscb_d[li_idx].pscb002
                  END FOR
                  CALL apsi002_mod_upd()
                  CALL apsi002_gzcb_b_fill()
                  CALL apsi002_array2_b_fill()
                  LET l_ac = 0
               END IF
            END IF
         END IF


      ON ACTION all_go_right
      
         LET g_action_choice="all_go_right"
         IF cl_auth_chk_act("all_go_right") THEN
            IF g_psca_m.pscastus =  'N' THEN
               EXIT DIALOG
            END IF
            IF NOT cl_null(g_psca_m.psca001) THEN
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt
                 FROM apsi002_gzcb_tmp
               IF ls_cnt > 0 THEN
                  FOR li_idx = 1 TO g_gzcb_d.getLength()
                     CALL apsi002_left_go_right(li_idx)
                  END FOR
      
                  CALL apsi002_mod_upd()
                  CALL apsi002_array2_b_fill()
                  LET l_ac = 0
               END IF
            END IF
         END IF

      ON ACTION go_left
      
         LET g_action_choice="go_left"
         IF cl_auth_chk_act("go_left") THEN
            IF g_psca_m.pscastus =  'N' THEN
               EXIT DIALOG
            END IF
            IF NOT cl_null(g_psca_m.psca001) THEN
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt
                 FROM pscb_t
                WHERE pscbent = g_enterprise
                  AND pscbsite = g_psca_m.pscasite
                  AND pscb001 = g_psca_m.psca001
      
               IF ls_cnt > 0 THEN
                  FOR li_idx = 1 TO g_pscb_d.getLength()
                     IF DIALOG.isRowSelected("s_detail2",li_idx) THEN
                        DELETE FROM pscb_t WHERE pscbent = g_enterprise
                                             AND pscbsite = g_psca_m.pscasite
                                             AND pscb001 = g_psca_m.psca001
                                             AND pscb002 = g_pscb_d[li_idx].pscb002
                     END IF
                  END FOR
                  CALL apsi002_mod_upd()
                  CALL apsi002_gzcb_b_fill()
                  CALL apsi002_array2_b_fill()
                  LET l_ac = 0
               END IF
            END IF
         END IF 
        
      ON ACTION go_right
      
         LET g_action_choice="go_right"
         IF cl_auth_chk_act("go_right") THEN
      
            IF g_psca_m.pscastus =  'N' THEN
               EXIT DIALOG
            END IF
            IF NOT cl_null(g_psca_m.psca001) THEN
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt
                 FROM apsi002_gzcb_tmp
               IF ls_cnt > 0 THEN
                  FOR li_idx = 1 TO g_gzcb_d.getLength()
                     IF DIALOG.isRowSelected("s_detail1",li_idx) THEN
                        CALL apsi002_left_go_right(li_idx)
                     END IF
                  END FOR
                  CALL apsi002_mod_upd()
                  CALL apsi002_array2_b_fill()
                  LET l_ac = 0
               END IF
            END IF
         END IF
      #end add-point
      
      BEFORE DIALOG 
         #add-point:input段before dialog
         #單身可多選的關鍵 
         CALL DIALOG.setSelectionMode("s_detail1",1)
         CALL DIALOG.setSelectionMode("s_detail2",1)
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD pscasite
         ELSE
            CASE g_aw
               WHEN "s_detail3"
                  NEXT FIELD pscc002
               WHEN "s_detail4"
                  NEXT FIELD pscd002
               WHEN "s_detail5"
                  NEXT FIELD psce003
 
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
         #add-point:input段accept 
         
         #end add-point    
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
   #ming 20150821 add ------------------------------------(S) 
      IF l_multi_pscc_ins THEN
         LET g_errshow = 0
         FOR l_i = 1 TO g_qryparam.str_array.getLength()
            LET l_pscc002 = g_qryparam.str_array[l_i]

            #重覆性檢查 
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM pscc_t
             WHERE psccent  = g_enterprise
               AND psccsite = g_psca_m.pscasite
               AND pscc001  = g_psca_m.psca001
               AND pscc002  = l_pscc002
            IF l_cnt > 0 THEN
               CONTINUE FOR
            END IF

            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_ooef004
            LET g_chkparam.arg2 = l_pscc002

            IF NOT cl_chk_exist("v_ooba002") THEN
               CONTINUE FOR
            END IF 
            
            INSERT INTO pscc_t(psccent,psccsite,pscc001,pscc002)
                 VALUES(g_enterprise,g_psca_m.pscasite,g_psca_m.psca001,l_pscc002)

         END FOR
         LET g_errshow = 1

         CALL apsi002_b_fill()

         CONTINUE WHILE
      END IF
   #ming 20150821 add ------------------------------------(E) 
   
   #ming 20150818 add ------------------------------------(S)    
      IF l_multi_pscd_ins THEN
         LET g_errshow = 0
         FOR l_i = 1 TO g_qryparam.str_array.getLength()
            LET l_pscd002 = g_qryparam.str_array[l_i]

            #重覆性檢查 
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM pscd_t
             WHERE pscdent  = g_enterprise
               AND pscdsite = g_psca_m.pscasite
               AND pscd001  = g_psca_m.psca001
               AND pscd002  = l_pscd002

            IF l_cnt > 0 THEN
               CONTINUE FOR
            END IF

            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_psca_m.pscasite
            LET g_chkparam.arg2 = l_pscd002
            #160318-00025#21  by 07900 --add-str
            LET g_errshow = TRUE #是否開窗                   
            LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
            #160318-00025#21  by 07900 --add-end
            IF NOT cl_chk_exist("v_inaa001") THEN
               CONTINUE FOR
            END IF 
            
            INSERT INTO pscd_t(pscdent,pscdsite,pscd001,pscd002)
                 VALUES(g_enterprise,g_psca_m.pscasite,g_psca_m.psca001,l_pscd002)
         END FOR
         LET g_errshow = 1

         CALL apsi002_b_fill()

         CONTINUE WHILE
      END IF

      EXIT WHILE
   END WHILE
   #ming 20150818 add ------------------------------------(E)    
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apsi002_show()
   DEFINE l_ac_t    LIKE type_t.num5
   #add-point:show段define

   #end add-point  
 
   #add-point:show段之前

   #end add-point
   
   
   
   LET g_psca_m_t.* = g_psca_m.*      #保存單頭舊值
   
   IF g_bfill = "Y" THEN
      CALL apsi002_b_fill() #單身填充
      CALL apsi002_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_psca_m.pscaownid_desc = cl_get_username(g_psca_m.pscaownid)
      #LET g_psca_m.pscaowndp_desc = cl_get_deptname(g_psca_m.pscaowndp)
      #LET g_psca_m.pscacrtid_desc = cl_get_username(g_psca_m.pscacrtid)
      #LET g_psca_m.pscacrtdp_desc = cl_get_deptname(g_psca_m.pscacrtdp)
      #LET g_psca_m.pscamodid_desc = cl_get_username(g_psca_m.pscamodid)
      ##LET g_psca_m.pscacnfid_desc = cl_get_deptname(g_psca_m.pscacnfid)
      ##LET g_psca_m.pscapstid_desc = cl_get_deptname(g_psca_m.pscapstid)
      
 
 
   
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL apsi002_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psca_m.psca001
   CALL ap_ref_array2(g_ref_fields," SELECT pscal003,pscal004 FROM pscal_t WHERE pscalent = '"||g_enterprise||"' AND pscal001 = ? AND pscal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_psca_m.pscal003 = g_rtn_fields[1] 
   LET g_psca_m.pscal004 = g_rtn_fields[2] 
   DISPLAY g_psca_m.pscal003,g_psca_m.pscal004 TO pscal003,pscal004
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psca_m.pscaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_psca_m.pscaownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psca_m.pscaownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psca_m.pscaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_psca_m.pscaowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psca_m.pscaowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psca_m.pscacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_psca_m.pscacrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psca_m.pscacrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psca_m.pscacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_psca_m.pscacrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psca_m.pscacrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_psca_m.pscamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_psca_m.pscamodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_psca_m.pscamodid_desc

   CALL apsi002_psca020_ref() 
   CALL apsi002_get_psea002() 
   CALL apsi002_psca035_ref(g_psca_m.psca035) RETURNING g_psca_m.psca035_desc
   
   #161228-00044#2-s-add
   #取得最後執行者
   SELECT psea005,ooag011 INTO g_psca_m.l_psea005_1,g_psca_m.l_psea005_1_desc
    FROM psea_t
    LEFT OUTER JOIN ooag_t ON ooagent=pseaent AND ooag001=psea005
   WHERE pseaent = g_enterprise     AND pseasite = g_site 
     AND psea001 = g_psca_m.psca001 AND psea002 = g_psea002
   DISPLAY BY NAME g_psca_m.l_psea005_1,g_psca_m.l_psea005_1_desc
   #161228-00044#2-e-add
   #end add-point
   
   #將資料輸出到畫面上
   #161015-00001#1-s-mod 拿掉psca013
   ##ming 20141020 modify ----------------------------------------------------------------------------------(S) 
   ##DISPLAY BY NAME g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite, 
   ##    g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012, 
   ##    g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca008, 
   ##    g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034, 
   ##    g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca020_desc,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022, 
   ##    g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
   ##    g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaownid_desc,g_psca_m.pscaowndp, 
   ##    g_psca_m.pscaowndp_desc,g_psca_m.pscacrtid,g_psca_m.pscacrtid_desc,g_psca_m.pscacrtdp,g_psca_m.pscacrtdp_desc, 
   ##    g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamodid_desc,g_psca_m.pscamoddt
   #DISPLAY BY NAME g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite,
   #                g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012,
   #                g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,
   #                g_psca_m.psca035_desc,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,
   #                g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
   #                g_psca_m.psca020_desc,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,
   #                g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,
   #                g_psca_m.pscaownid_desc,g_psca_m.pscaowndp,g_psca_m.pscaowndp_desc,g_psca_m.pscacrtid,
   #                g_psca_m.pscacrtid_desc,g_psca_m.pscacrtdp,g_psca_m.pscacrtdp_desc,g_psca_m.pscacrtdt,
   #                g_psca_m.pscamodid,g_psca_m.pscamodid_desc,g_psca_m.pscamoddt
   ##ming 20141020 modify ----------------------------------------------------------------------------------(E) 
   DISPLAY BY NAME g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite,
                   g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012,
                   g_psca_m.psca005,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,
                   g_psca_m.psca035_desc,g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,
                   g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
                   g_psca_m.psca020_desc,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,
                   g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,
                   g_psca_m.pscaownid_desc,g_psca_m.pscaowndp,g_psca_m.pscaowndp_desc,g_psca_m.pscacrtid,
                   g_psca_m.pscacrtid_desc,g_psca_m.pscacrtdp,g_psca_m.pscacrtdp_desc,g_psca_m.pscacrtdt,
                   g_psca_m.pscamodid,g_psca_m.pscamodid_desc,g_psca_m.pscamoddt
   #161015-00001#1-e-mod
   #ming 20150521 add ----------(S) 
   DISPLAY BY NAME g_psca_m.psca036
   #ming 20150521 add ----------(E) 
   #151120-00005#1 20151120  add by beckxie---S
   DISPLAY BY NAME g_psca_m.psca037,g_psca_m.psca038,g_psca_m.l_psea002_1
   #151120-00005#1 20151120  add by beckxie---E
   DISPLAY BY NAME g_psca_m.psca039,g_psca_m.psca040   #add--151207-00012#1 By shiun 
   
   #161015-00001#1-s-mod 拿掉psca043
   ##160509-00009#1 20160516 add by ming -----(S) 
   #DISPLAY BY NAME g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044
   ##160509-00009#1 20160516 add by ming -----(E) 
   DISPLAY BY NAME g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca044
   #161015-00001#1-e-mod
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_psca_m.pscastus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pscc_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
      CALL apsi002_pscc002_ref(l_ac)
            
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_pscc4_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
      CALL apsi002_pscd002_ref(l_ac)
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_pscc5_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
      CALL apsi002_psce002_ref(l_ac)
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other
   CALL apsi002_set_act_visible()     #151207-00012#1 add
   CALL apsi002_set_act_no_visible()  #151207-00012#1 add
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apsi002_detail_show()
   
   #add-point:show段之後

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsi002.detail_show" >}
#+ 單身reference detail_show
PRIVATE FUNCTION apsi002_detail_show()
   #add-point:detail_show段define
   
   #end add-point  
 
   #add-point:detail_show段之前
   
   #end add-point
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsi002.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apsi002_reproduce()
   DEFINE l_newno     LIKE psca_t.pscasite 
   DEFINE l_oldno     LIKE psca_t.pscasite 
   DEFINE l_newno02     LIKE psca_t.psca001 
   DEFINE l_oldno02     LIKE psca_t.psca001 
 
   DEFINE l_master    RECORD LIKE psca_t.*
   DEFINE l_detail    RECORD LIKE pscc_t.*
   DEFINE l_detail2    RECORD LIKE pscd_t.*
 
   DEFINE l_detail3    RECORD LIKE psce_t.*
 
 
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   
   #end add-point   
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   IF g_psca_m.pscasite IS NULL
   OR g_psca_m.psca001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
    
   LET g_pscasite_t = g_psca_m.pscasite
   LET g_psca001_t = g_psca_m.psca001
 
    
   LET g_psca_m.pscasite = ""
   LET g_psca_m.psca001 = ""
 
    
   CALL apsi002_set_entry('a')
   CALL apsi002_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      LET g_psca_m.pscaownid = g_user
      LET g_psca_m.pscaowndp = g_dept
      LET g_psca_m.pscacrtid = g_user
      LET g_psca_m.pscacrtdp = g_dept 
      LET g_psca_m.pscacrtdt = cl_get_current()
      LET g_psca_m.pscamodid = ""
      LET g_psca_m.pscamoddt = ""
      #LET g_psca_m.pscastus = ""
 
 
   
   #add-point:複製輸入前
   LET g_psca_m.pscastus = 'Y'
   LET g_psca_m.pscasite = g_site
   LET g_psca_m.psca039 = '1'
   LET g_psca_m.psca040 = 'N'
   #end add-point
   
   CALL apsi002_input("r")
   
   
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
 
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " pscasite = '", g_psca_m.pscasite CLIPPED, "' "
              ," AND psca001 = '", g_psca_m.psca001 CLIPPED, "' "
 
              , ") "
   
   #add-point:完成複製段落後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsi002.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apsi002_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pscc_t.*
   DEFINE l_detail2    RECORD LIKE pscd_t.*
 
   DEFINE l_detail3    RECORD LIKE psce_t.*
 
 
 
   #add-point:delete段define
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apsi002_detail
   
   #add-point:單身複製前1
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE apsi002_detail AS ",
                "SELECT * FROM pscc_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apsi002_detail SELECT * FROM pscc_t 
                                         WHERE psccent = g_enterprise AND psccsite = g_pscasite_t
                                         AND pscc001 = g_psca001_t
 
   
   #將key修正為調整後   
   UPDATE apsi002_detail 
      #更新key欄位
      SET psccsite = g_psca_m.pscasite
          , pscc001 = g_psca_m.psca001
 
      #更新共用欄位
      
                                       
  
   #將資料塞回原table   
   INSERT INTO pscc_t SELECT * FROM apsi002_detail
   
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
   DROP TABLE apsi002_detail
   
   #add-point:單身複製後1
   
   #end add-point
 
   #add-point:單身複製前
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE apsi002_detail AS ",
      "SELECT * FROM pscd_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apsi002_detail SELECT * FROM pscd_t
                                         WHERE pscdent = g_enterprise AND pscdsite = g_pscasite_t
                                         AND pscd001 = g_psca001_t
 
 
   #將key修正為調整後   
   UPDATE apsi002_detail SET pscdsite = g_psca_m.pscasite
                                       , pscd001 = g_psca_m.psca001
 
  
   #將資料塞回原table   
   INSERT INTO pscd_t SELECT * FROM apsi002_detail
   
   #add-point:單身複製中
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apsi002_detail
   
   #add-point:單身複製後
   
   #end add-point
 
   #add-point:單身複製前
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE apsi002_detail AS ",
      "SELECT * FROM psce_t "
   PREPARE repro_tbl3 FROM ls_sql
   EXECUTE repro_tbl3
   FREE repro_tbl3
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apsi002_detail SELECT * FROM psce_t
                                         WHERE psceent = g_enterprise AND pscesite = g_pscasite_t
                                         AND psce001 = g_psca001_t
 
 
   #將key修正為調整後   
   UPDATE apsi002_detail SET pscesite = g_psca_m.pscasite
                                       , psce001 = g_psca_m.psca001
 
  
   #將資料塞回原table   
   INSERT INTO psce_t SELECT * FROM apsi002_detail
   
   #add-point:單身複製中
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apsi002_detail
   
   #add-point:單身複製後
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE apsi002_detail AS ",
                "SELECT * FROM pscb_t "
   PREPARE repro_tbl4 FROM ls_sql
   EXECUTE repro_tbl4
   FREE repro_tbl4

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apsi002_detail SELECT * FROM pscb_t
                               WHERE pscbent = g_enterprise
                                 AND pscbsite = g_pscasite_t
                                 AND pscb001 = g_psca001_t

   #將key修正為調整後   
   UPDATE apsi002_detail SET pscbsite = g_psca_m.pscasite,
                             pscb001 = g_psca_m.psca001

   #將資料塞回原table   
   INSERT INTO pscb_t SELECT * FROM apsi002_detail
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pscasite_t = g_psca_m.pscasite
   LET g_psca001_t = g_psca_m.psca001
 
   
   DROP TABLE apsi002_detail
   
END FUNCTION
 
{</section>}
 
{<section id="apsi002.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apsi002_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   #add--151207-00012#1 By shiun--(S)
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE l_success LIKE type_t.num5
   #add--151207-00012#1 By shiun--(E)
   #end add-point     
   
   IF g_psca_m.pscasite IS NULL OR g_psca_m.psca001 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   #151120-00005#1 20151120 mark by beckxie---S
   ##ming 20141020 modify ----------------------------------------------------(S) 
   ##EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001 INTO g_psca_m.psca001,g_psca_m.psca002, 
   ##    g_psca_m.pscasite,g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011, 
   ##    g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007, 
   ##    g_psca_m.psca008,g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017, 
   ##    g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022, 
   ##    g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026, 
   ##    g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,g_psca_m.pscacrtdp, 
   ##    g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   #EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001
   #                                 INTO g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus,
   #                                      g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
   #                                      g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,
   #                                      #ming 20150521 modify ---------------------------------------------(S) 
   #                                      #g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca008,
   #                                      g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca036,g_psca_m.psca008,
   #                                      #ming 20150521 modify ---------------------------------------------(E) 
   #                                      g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,
   #                                      g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
   #                                      g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,
   #                                      g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,
   #                                      g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
   #                                      g_psca_m.pscacrtdp,g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   ##ming 20141020 modify ----------------------------------------------------(E) 
   #151120-00005#1 20151120 mark by beckxie---E
   #151120-00005#1 20151120  add by beckxie---S
   EXECUTE apsi002_master_referesh USING g_psca_m.pscasite,g_psca_m.psca001
                                    INTO g_psca_m.psca001,g_psca_m.psca002,g_psca_m.pscasite,g_psca_m.pscastus,
                                         #add--151207-00012#1 By shiun--(S)
                                         g_psca_m.psca039,g_psca_m.psca040,
                                         #add--151207-00012#1 By shiun--(E)
                                         g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
                                         #161015-00001#1-s-mod 拿掉psca013
                                         #g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,
                                         g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca006,
                                         #161015-00001#1-e-mod
                                         g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca038,g_psca_m.psca036,g_psca_m.psca008,
                                         g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,
                                         g_psca_m.psca017,g_psca_m.psca034,g_psca_m.psca019,g_psca_m.psca020,
                                         g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022,g_psca_m.psca023,
                                         g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,g_psca_m.psca029,
                                         #161015-00001#1-s-mod 拿掉psca043
                                         ##160509-00009#1 20160516 modify by ming -----(S) 
                                         ##g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
                                         #g_psca_m.psca030,
                                         #g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044,
                                         #g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
                                         ##160509-00009#1 20160516 modify by ming -----(E) 
                                         g_psca_m.psca030,g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca044,
                                         g_psca_m.pscaownid,g_psca_m.pscaowndp,g_psca_m.pscacrtid,
                                         #161015-00001#1-e-mod
                                         g_psca_m.pscacrtdp,g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamoddt
   #151120-00005#1 20151120  add by beckxie---E
   LET g_master_multi_table_t.pscal001 = g_psca_m.psca001
   LET g_master_multi_table_t.pscal003 = g_psca_m.pscal003
   LET g_master_multi_table_t.pscal004 = g_psca_m.pscal004
 
 
   CALL apsi002_show()
   
   CALL s_transaction_begin()
 
   OPEN apsi002_cl USING g_enterprise,g_psca_m.pscasite
                                                       ,g_psca_m.psca001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN apsi002_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE apsi002_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #151120-00005#1 20151120 mark by beckxie---S
   ##ming 20141020 modify -------------------------------------------(S) 
   ##FETCH apsi002_cl INTO g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite, 
   ##    g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,g_psca_m.psca012, 
   ##    g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,g_psca_m.psca007,g_psca_m.psca008, 
   ##    g_psca_m.psca015,g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034, 
   ##    g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca020_desc,g_psca_m.psca021,g_psca_m.psca031,g_psca_m.psca022, 
   ##    g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
   ##    g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaownid_desc,g_psca_m.pscaowndp, 
   ##    g_psca_m.pscaowndp_desc,g_psca_m.pscacrtid,g_psca_m.pscacrtid_desc,g_psca_m.pscacrtdp,g_psca_m.pscacrtdp_desc, 
   ##    g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamodid_desc,g_psca_m.pscamoddt              
   #FETCH apsi002_cl INTO g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite,
   #                      g_psca_m.pscastus,g_psca_m.psca003,g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
   #                      g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,
   #                      #ming 20150521 modify ----------------------------------------------------------------(S) 
   #                      #g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca035_desc,g_psca_m.psca008,g_psca_m.psca015,
   #                      g_psca_m.psca007,g_psca_m.psca035,g_psca_m.psca035_desc,g_psca_m.psca036,g_psca_m.psca008,g_psca_m.psca015,
   #                      #ming 20150521 modify ----------------------------------------------------------------(E) 
   #                      g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,
   #                      g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca020_desc,g_psca_m.psca021,g_psca_m.psca031,
   #                      g_psca_m.psca022,g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
   #                      g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaownid_desc,g_psca_m.pscaowndp,
   #                      g_psca_m.pscaowndp_desc,g_psca_m.pscacrtid,g_psca_m.pscacrtid_desc,g_psca_m.pscacrtdp,
   #                      g_psca_m.pscacrtdp_desc,g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamodid_desc,
   #                      g_psca_m.pscamoddt
   ##ming 20141020 modify -------------------------------------------(E)     
   #151120-00005#1 20151120 mark by beckxie---E
   #151120-00005#1 20151120  add by beckxie---S
   FETCH apsi002_cl INTO g_psca_m.psca001,g_psca_m.pscal003,g_psca_m.pscal004,g_psca_m.psca002,g_psca_m.pscasite,
                         g_psca_m.pscastus,g_psca_m.psca039,g_psca_m.psca040,g_psca_m.l_psea002_1,g_psca_m.psca003,   #modify--151207-00012#1 By shiun   增加psca039、040
                         g_psca_m.psca009,g_psca_m.psca004,g_psca_m.psca011,
                         #161015-00001#1-s-mod 拿掉psca013
                         #g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca013,g_psca_m.psca006,g_psca_m.psca014,
                         g_psca_m.psca012,g_psca_m.psca005,g_psca_m.psca006,g_psca_m.psca014,
                         #161015-00001#1-e-mod
                         g_psca_m.psca007,g_psca_m.psca037,g_psca_m.psca035,g_psca_m.psca035_desc,g_psca_m.psca038,g_psca_m.psca036,g_psca_m.psca008,g_psca_m.psca015,
                         g_psca_m.psca032,g_psca_m.psca016,g_psca_m.psca033,g_psca_m.psca017,g_psca_m.psca034,
                         g_psca_m.psca019,g_psca_m.psca020,g_psca_m.psca020_desc,g_psca_m.psca021,g_psca_m.psca031,
                         g_psca_m.psca022,g_psca_m.psca023,g_psca_m.psca024,g_psca_m.psca025,g_psca_m.psca026,
                         #161015-00001#1-s-mod 拿掉psca043
                         ##160509-00009#1 20160516 modify by ming -----(S) 
                         ##g_psca_m.psca029,g_psca_m.psca030,g_psca_m.pscaownid,g_psca_m.pscaownid_desc,g_psca_m.pscaowndp,
                         #g_psca_m.psca029,g_psca_m.psca030,
                         #g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca043,g_psca_m.psca044,
                         #g_psca_m.pscaownid,g_psca_m.pscaownid_desc,g_psca_m.pscaowndp,
                         ##160509-00009#1 20160516 modify by ming -----(E) 
                         g_psca_m.psca029,g_psca_m.psca030,g_psca_m.psca041,g_psca_m.psca042,g_psca_m.psca044,
                         g_psca_m.pscaownid,g_psca_m.pscaownid_desc,g_psca_m.pscaowndp,
                         #161015-00001#1-e-mod
                         g_psca_m.pscaowndp_desc,g_psca_m.pscacrtid,g_psca_m.pscacrtid_desc,g_psca_m.pscacrtdp,
                         g_psca_m.pscacrtdp_desc,g_psca_m.pscacrtdt,g_psca_m.pscamodid,g_psca_m.pscamodid_desc,
                         g_psca_m.pscamoddt
   #151120-00005#1 20151120  add by beckxie---E
        #鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_psca_m.pscasite
      LET g_errparam.popup = FALSE
      CALL cl_err()
          #資料被他人LOCK
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段before ask

   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前

      #end add-point   
      
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL apsi002_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
  
  
      #資料備份
      LET g_pscasite_t = g_psca_m.pscasite
      LET g_psca001_t = g_psca_m.psca001
 
 
      DELETE FROM psca_t
       WHERE pscaent = g_enterprise AND pscasite = g_psca_m.pscasite
         AND psca001 = g_psca_m.psca001
 
       
      #add-point:單頭刪除中

      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_psca_m.pscasite
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後

      #end add-point
  
      #add-point:單身刪除前
      DELETE FROM pscb_t
       WHERE pscbent = g_enterprise
         AND pscbsite = g_psca_m.pscasite
         AND pscb001 = g_psca_m.psca001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pscb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
      
      DELETE FROM pscc_t
       WHERE psccent = g_enterprise AND psccsite = g_psca_m.pscasite
         AND pscc001 = g_psca_m.psca001
 
 
      #add-point:單身刪除中

      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pscc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後

      #end add-point
      
            
                                                               
      #add-point:單身刪除前

      #end add-point
      DELETE FROM pscd_t
       WHERE pscdent = g_enterprise AND
             pscdsite = g_psca_m.pscasite AND pscd001 = g_psca_m.psca001
      #add-point:單身刪除中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pscd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後

      #end add-point
 
      #add-point:單身刪除前

      #end add-point
      DELETE FROM psce_t
       WHERE psceent = g_enterprise AND
             pscesite = g_psca_m.pscasite AND psce001 = g_psca_m.psca001
      #add-point:單身刪除中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "psce_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後
      #160608-00013#1 20160620 modify by ming -----(S) 
      ##add--151207-00012#1 By shiun--(S)
      #CALL s_apsp500_advanced_command('delete_db',g_psca_m.psca001,'','','')
      #     RETURNING l_success
      ##add--151207-00012#1 By shiun--(E)
      IF g_psca_m.psca039 = '2' THEN 
         CALL s_apsp500_advanced_command('delete_db',g_psca_m.psca001,'','','')
              RETURNING l_success
      END IF 
      #160608-00013#1 20160620 modify by ming -----(E) 
      #end add-point
 
 
 
 
                                                               
      CLEAR FORM
      CALL g_pscc_d.clear() 
      CALL g_pscc4_d.clear()       
      CALL g_pscc5_d.clear()       
 
     
      CALL apsi002_ui_browser_refresh()  
      CALL apsi002_ui_headershow()  
      CALL apsi002_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL apsi002_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      ELSE
         LET g_wc = " 1=1"
         CALL apsi002_browser_fill("F")
      END IF
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_master_multi_table_t.pscal001
   LET l_field_keys[01] = 'pscal001'
   LET l_var_keys_bak[02] = g_dlang
   LET l_field_keys[02] = 'pscal002'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'pscal_t')
 
      
      #單身多語言刪除
      
      
 
      
 
 
 
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE apsi002_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_psca_m.pscasite,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="apsi002.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsi002_b_fill()
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   DEFINE l_sql      STRING
   #end add-point     
 
   CALL g_pscc_d.clear()    #g_pscc_d 單頭及單身 
   CALL g_pscc4_d.clear()
   CALL g_pscc5_d.clear()
 
 
   #add-point:b_fill段sql_before
   CALL g_pscb_d.clear() 
   CALL g_gzcb_d.clear() 
   #end add-point
   
   #判斷是否填充
   IF apsi002_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE pscc002,'' FROM pscc_t",   
                  " INNER JOIN psca_t ON pscasite = psccsite ",
                  " AND psca001 = pscc001 ",
 
                  #"",
                  
                  "",
                  " WHERE psccent=? AND psccsite=? AND pscc001=?"
      #add-point:b_fill段sql_before
      
      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY pscc_t.pscc002"
      
      #add-point:單身填充控制
      
      #end add-point
      
      PREPARE apsi002_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR apsi002_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_psca_m.pscasite
                                               ,g_psca_m.psca001
 
                                               
      FOREACH b_fill_cs INTO g_pscc_d[l_ac].pscc002,g_pscc_d[l_ac].pscc002_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         CALL apsi002_pscc002_ref(l_ac)
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
            END IF
            EXIT FOREACH
         END IF
         
      END FOREACH
      LET g_error_show = 0
   
   END IF
   
   #判斷是否填充
   IF apsi002_fill_chk(2) THEN
      LET g_sql = "SELECT  UNIQUE pscd002,'' FROM pscd_t",   
                  " INNER JOIN psca_t ON pscasite = pscdsite ",
                  " AND psca001 = pscd001 ",
 
                  "",
                  
                  " WHERE pscdent=? AND pscdsite=? AND pscd001=?"   
      #add-point:b_fill段sql_before
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY pscd_t.pscd002"
      
      #add-point:單身填充控制
      
      #end add-point
      
      PREPARE apsi002_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR apsi002_pb2
      
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_psca_m.pscasite
                                               ,g_psca_m.psca001
 
                                               
      FOREACH b_fill_cs2 INTO g_pscc4_d[l_ac].pscd002,g_pscc4_d[l_ac].inaa002
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         CALL apsi002_pscd002_ref(l_ac)
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
 
   #判斷是否填充
   IF apsi002_fill_chk(3) THEN
      LET g_sql = "SELECT  UNIQUE psce003,psce002,'' FROM psce_t",   
                  " INNER JOIN psca_t ON pscasite = pscesite ",
                  " AND psca001 = psce001 ",
 
                  "",
                  
                  " WHERE psceent=? AND pscesite=? AND psce001=?"   
      #add-point:b_fill段sql_before
      LET l_sql = g_sql
      IF NOT cl_null(g_wc2_table3) THEN
         LET l_sql = l_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      #end add-point
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY psce_t.psce002"
      
      #add-point:單身填充控制
      LET g_sql = l_sql," ORDER BY psce_t.psce003,psce_t.psce002 "
      #end add-point
      
      PREPARE apsi002_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR apsi002_pb3
      
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_psca_m.pscasite
                                               ,g_psca_m.psca001
 
                                               
      FOREACH b_fill_cs3 INTO g_pscc5_d[l_ac].psce003,g_pscc5_d[l_ac].psce002,g_pscc5_d[l_ac].psce002_desc 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         CALL apsi002_psce002_ref(l_ac)
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
   LET g_sql = "SELECT UNIQUE pscb003,pscb002,pscb004 ",
               "  FROM pscb_t INNER JOIN psca_t ON pscasite = pscbsite ",
               "                               AND psca001 = pscb001 ",
               " WHERE pscbent = ? ",
               "   AND pscbsite = ? ",
               "   AND pscb001= ? ",
               " ORDER BY pscb_t.pscb003,pscb_t.pscb002 "
   PREPARE apsi002_pb4 FROM g_sql
   DECLARE b_fill_cs4 CURSOR FOR apsi002_pb4
   LET l_ac = 1

   OPEN b_fill_cs4 USING g_enterprise,g_psca_m.pscasite,g_psca_m.psca001

   FOREACH b_fill_cs4 INTO g_pscb_d[l_ac].pscb003,g_pscb_d[l_ac].pscb002,
                           g_pscb_d[l_ac].pscb004
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
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH 
   
   CALL g_pscb_d.deleteElement(g_pscb_d.getLength())

   FREE apsi002_pb4  
   
   CALL apsi002_gzcb_b_fill()
   #end add-point
   
   CALL g_pscc_d.deleteElement(g_pscc_d.getLength())
   CALL g_pscc4_d.deleteElement(g_pscc4_d.getLength())
   CALL g_pscc5_d.deleteElement(g_pscc5_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apsi002_pb
   FREE apsi002_pb2
 
   FREE apsi002_pb3
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="apsi002.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apsi002_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM pscc_t
       WHERE psccent = g_enterprise AND
         psccsite = ps_keys_bak[1] AND pscc001 = ps_keys_bak[2] AND pscc002 = ps_keys_bak[3]
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
      DELETE FROM pscd_t
       WHERE pscdent = g_enterprise AND
         pscdsite = ps_keys_bak[1] AND pscd001 = ps_keys_bak[2] AND pscd002 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pscd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM psce_t
       WHERE psceent = g_enterprise AND
         pscesite = ps_keys_bak[1] AND psce001 = ps_keys_bak[2] AND psce002 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "psce_t"
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
 
{<section id="apsi002.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apsi002_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define
   
   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point 
      INSERT INTO pscc_t
                  (psccent,
                   psccsite,pscc001,
                   pscc002
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
      #add-point:insert_b段資料新增中
      
      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pscc_t"
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
      INSERT INTO pscd_t
                  (pscdent,
                   pscdsite,pscd001,
                   pscd002
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pscd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point 
      INSERT INTO psce_t
                  (psceent,
                   pscesite,psce001,
                   psce002
                   ,psce003) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_pscc5_d[g_detail_idx].psce003)
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "psce_t"
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
 
{<section id="apsi002.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apsi002_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pscc_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE pscc_t 
         SET (psccsite,pscc001,
              pscc002
              ) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ) 
         WHERE psccent = g_enterprise AND psccsite = ps_keys_bak[1] AND pscc001 = ps_keys_bak[2] AND pscc002 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "pscc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pscc_t"
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pscd_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE pscd_t 
         SET (pscdsite,pscd001,
              pscd002
              ) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ) 
         WHERE pscdent = g_enterprise AND pscdsite = ps_keys_bak[1] AND pscd001 = ps_keys_bak[2] AND pscd002 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "pscd_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pscd_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      
      #end add-point  
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "psce_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE psce_t 
         SET (pscesite,psce001,
              psce002
              ,psce003) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_pscc5_d[g_detail_idx].psce003) 
         WHERE psceent = g_enterprise AND pscesite = ps_keys_bak[1] AND psce001 = ps_keys_bak[2] AND psce002 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "psce_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "psce_t"
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
 
{<section id="apsi002.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apsi002_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL apsi002_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pscc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apsi002_bcl USING g_enterprise,
                                       g_psca_m.pscasite,g_psca_m.psca001,g_pscc_d[g_detail_idx].pscc002  
                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "apsi002_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "pscd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apsi002_bcl2 USING g_enterprise,
                                             g_psca_m.pscasite,g_psca_m.psca001,g_pscc4_d[g_detail_idx].pscd002 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "apsi002_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "psce_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apsi002_bcl3 USING g_enterprise,
                                             g_psca_m.pscasite,g_psca_m.psca001,g_pscc5_d[g_detail_idx].psce002 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "apsi002_bcl3"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other
   LET ls_group = "pscb_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apsi002_bcl4 USING g_enterprise,g_psca_m.pscasite,g_psca_m.psca001,
                              g_pscb_d[g_detail_idx].pscb002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "apsi002_bcl4"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apsi002_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apsi002_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apsi002_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apsi002_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other
   LET ls_group = "'4',"
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apsi002_bcl4
   END IF
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apsi002_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pscasite,psca001",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry("psca012",TRUE) 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apsi002_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pscasite,psca001",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry段欄位控制後
   IF g_psca_m.psca011 <> '2' THEN 
      CALL cl_set_comp_entry("psca012",FALSE)
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apsi002_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   #add-point:set_entry_b段
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="apsi002.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apsi002_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   #add-point:set_no_entry_b段
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="apsi002.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apsi002_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " pscasite = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " psca001 = '", g_argv[02], "' AND "
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
   
   #add-point:default_search段結束前
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION apsi002_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define
   DEFINE l_pscamoddt    DATETIME YEAR TO SECOND 
   #end add-point  
   
   #add-point:statechange段開始前
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_psca_m.pscasite IS NULL
      OR g_psca_m.psca001 IS NULL
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
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_psca_m.pscastus
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
            
         END CASE
     
      #add-point:menu前
      
      #end add-point
      
      ON ACTION inactive
         LET lc_state = "N"
         #add-point:action控制
         
         #end add-point
         EXIT MENU
      ON ACTION active
         LET lc_state = "Y"
         #add-point:action控制
         
         #end add-point
         EXIT MENU
      
      
      
      #add-point:stus控制
      
      #end add-point
      
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
   LET l_pscamoddt = cl_get_current() 
   
   UPDATE psca_t SET pscamoddt = l_pscamoddt
    WHERE pscaent = g_enterprise
      AND pscasite = g_psca_m.pscasite
      AND psca001 = g_psca_m.psca001

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point
      
   UPDATE psca_t SET pscastus = lc_state 
    WHERE pscaent = g_enterprise AND pscasite = g_psca_m.pscasite
      AND psca001 = g_psca_m.psca001
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
      LET g_psca_m.pscastus = lc_state
      DISPLAY BY NAME g_psca_m.pscastus
   END IF
 
   #add-point:stus修改後
   
   #end add-point
 
   #add-point:statechange段結束前
   
   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="apsi002.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION apsi002_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_pscc_d.getLength() THEN
         LET g_detail_idx = g_pscc_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pscc_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pscc_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_pscc4_d.getLength() THEN
         LET g_detail_idx = g_pscc4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pscc4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pscc4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_pscc5_d.getLength() THEN
         LET g_detail_idx = g_pscc5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pscc5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pscc5_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apsi002.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsi002_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL apsi002_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="apsi002.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apsi002_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
   
   #end add-point
   
   #add-point:fill_chk段before_chk
   
   #end add-point
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk
      
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
 
   IF ps_idx = 3 AND
      ((NOT cl_null(g_wc2_table3) AND g_wc2_table3.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
 
 
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="apsi002.signature" >}
   
 
{</section>}
 
{<section id="apsi002.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION apsi002_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_psca_m.pscasite
   LET g_pk_array[1].column = 'pscasite'
   LET g_pk_array[2].values = g_psca_m.psca001
   LET g_pk_array[2].column = 'psca001'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="apsi002.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="apsi002.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 產生被拖拉的資料
# Memo...........:
# Usage..........: CALL apsi002_gzcb_b_fill()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/18 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_gzcb_b_fill()
   DEFINE l_sql     STRING
   DEFINE l_gzcb003 LIKE gzcb_t.gzcb003
   DEFINE l_gzcb002 LIKE gzcb_t.gzcb002
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_gzcb012 LIKE gzcb_t.gzcb012
   DEFINE l_count   LIKE type_t.num5

   LET l_sql = "SELECT gzcb003,gzcb002 ",
               "  FROM gzcb_t ",
               " WHERE gzcb001 = '5409' ",
               " ORDER BY gzcb003,gzcb012 "

   PREPARE apsi002_gzcb_prep FROM l_sql
   DECLARE apsi002_gzcb_curs CURSOR FOR apsi002_gzcb_prep

   LET l_cnt = 1
   DELETE FROM apsi002_gzcb_tmp
   
   FOREACH apsi002_gzcb_curs INTO l_gzcb003,l_gzcb002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_count = 0
      #SELECT COUNT(*) INTO l_count FROM apsi002_pscb_tmp
      # WHERE pscb003 = l_gzcb003
      #   AND pscb002 = l_gzcb002 
      
      SELECT COUNT(*) INTO l_count FROM pscb_t 
       WHERE pscbent = g_enterprise 
         AND pscbsite = g_psca_m.pscasite 
         AND pscb001 = g_psca_m.psca001 
         AND pscb002 = l_gzcb002 

      IF l_count > 0 THEN
         CONTINUE FOREACH
      END IF
      
      LET g_gzcb_d[l_cnt].gzcb003 = l_gzcb003
      LET g_gzcb_d[l_cnt].gzcb002 = l_gzcb002
      
      LET l_gzcb012 = l_cnt + 10
      LET l_gzcb012 = l_gzcb012 USING "&&&&"
      INSERT INTO apsi002_gzcb_tmp VALUES(l_gzcb003,l_gzcb002,l_gzcb012)

      LET l_cnt = l_cnt + 1
   END FOREACH

   LET g_rec_b = l_cnt - 1  
   
END FUNCTION
################################################################################
# Descriptions...: 顯示可拖拉的單身資料
# Memo...........:
# Usage..........: CALL apsi002_array2_b_fill()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/20 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_array2_b_fill()
   CALL g_pscb_d.clear()
   CALL g_gzcb_d.clear()
   
   DECLARE apsi002_pscb_curs2 CURSOR FOR SELECT pscb003,pscb002,pscb004 
                                           FROM pscb_t 
                                          WHERE pscbent = g_enterprise 
                                            AND pscbsite = g_psca_m.pscasite 
                                            AND pscb001 = g_psca_m.psca001 
                                            
   LET g_cnt = 1 
   FOREACH apsi002_pscb_curs2 INTO g_pscb_d[g_cnt].* 
      IF SQLCA.sqlcode THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH 
      END IF 
      
      LET g_cnt = g_cnt + 1 
   END FOREACH 
   
   CALL g_pscb_d.deleteElement(g_cnt) 

   #DECLARE apsi002_pscb_curs2 CURSOR FOR SELECT pscb003,pscb002,pscb004
   #                                        FROM apsi002_pscb_tmp
   #                                       ORDER BY pscb003,pscb002
   #LET g_cnt = 1
   #FOREACH apsi002_pscb_curs2 INTO g_pscb_d[g_cnt].*
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'foreach:'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()

   #      EXIT FOREACH
   #   END IF
   #
   #   LET g_cnt = g_cnt + 1
   #END FOREACH
   #
   #CALL g_pscb_d.deleteElement(g_cnt)

   DECLARE apsi002_gzcb_curs2 CURSOR FOR SELECT gzcb003,gzcb002
                                           FROM apsi002_gzcb_tmp
                                          ORDER BY gzcb012
   LET g_cnt = 1
   FOREACH apsi002_gzcb_curs2 INTO g_gzcb_d[g_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET g_cnt = g_cnt + 1
   END FOREACH

   CALL g_gzcb_d.deleteElement(g_cnt)
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
PRIVATE FUNCTION apsi002_create_tmp()
   DROP TABLE apsi002_gzcb_tmp
   DROP TABLE apsi002_pscb_tmp

   SELECT gzcb003,gzcb002,gzcb012 FROM gzcb_t WHERE 1=2 INTO TEMP apsi002_gzcb_tmp
   SELECT pscb003,pscb002,pscb004 FROM pscb_t WHERE 1=2 INTO TEMP apsi002_pscb_tmp
END FUNCTION
################################################################################
# Descriptions...: 取得此據點的單據別參照表編號
# Memo...........:
# Usage..........: CALL apsi002_get_ooef004() 
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/21 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_get_ooef004()
   LET g_ooef004 = ''
   SELECT ooef004 INTO g_ooef004
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_psca_m.pscasite  
END FUNCTION
################################################################################
# Descriptions...: 找MDS編號的說明
# Memo...........:
# Usage..........: CALL apsi002_psca020_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/21 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_psca020_ref()
   DEFINE l_psbal003     LIKE psbal_t.psbal003

   LET l_psbal003 = ''
   SELECT psbal003 INTO l_psbal003
     FROM psbal_t
    WHERE psbalent = g_enterprise
      AND psbal001 = g_psca_m.psca020
      AND psbal002 = g_dlang

   LET g_psca_m.psca020_desc = l_psbal003
   DISPLAY BY NAME g_psca_m.psca020_desc
END FUNCTION
################################################################################
# Descriptions...: 找供給法則的說明
# Memo...........:
# Usage..........: CALL apsi002_pscd002_ref(p_ac)
# Input parameter: p_ac：單身編號
# Return code....: 無
# Date & Author..: 2014/03/21 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_pscd002_ref(p_ac)
   DEFINE p_ac      LIKE type_t.num5
   DEFINE l_inaa002 LIKE inaa_t.inaa002

   CALL s_desc_get_stock_desc(g_site,g_pscc4_d[p_ac].pscd002)
        RETURNING l_inaa002

   LET g_pscc4_d[p_ac].inaa002 = l_inaa002
END FUNCTION
################################################################################
# Descriptions...: 找單據別的說明
# Memo...........:
# Usage..........: CALL apsi002_pscc002_ref(p_ac)
# Input parameter: p_ac：單身編號 
# Return code....: 無
# Date & Author..: 2014/03/21 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_pscc002_ref(p_ac)
   DEFINE p_ac     LIKE type_t.num5

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pscc_d[p_ac].pscc002
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT oobxl003 FROM oobxl_t WHERE oobxlent='"||g_enterprise||"' AND oobxl001=? AND oobxl002='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_pscc_d[p_ac].pscc002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pscc_d[p_ac].pscc002_desc
END FUNCTION
################################################################################
# Descriptions...: 找供給法則說明
# Memo...........:
# Usage..........: CALL apsi002_psce002_ref(p_ac)
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/21 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_psce002_ref(p_ac)
   DEFINE p_ac       LIKE type_t.num5

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pscc5_d[l_ac].psce002
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT psdal003 FROM psdal_t WHERE psdalent='"||g_enterprise||"' AND psdal001=? AND psdal002='"||g_dlang||"'",
                      "")
        RETURNING g_rtn_fields
   LET g_pscc5_d[l_ac].psce002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pscc5_d[l_ac].psce002_desc
END FUNCTION
################################################################################
# Descriptions...: 處理左方單身拖拉到右方後的資料增刪
# Memo...........:
# Usage..........: CALL apsi002_left_go_right(p_ac)
# Input parameter: p_ac:單身編號
# Return code....: 無
# Date & Author..: 2014/03/22 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_left_go_right(p_ac)
   DEFINE p_ac     LIKE type_t.num5
   DEFINE ls_cnt   LIKE type_t.num5

   SELECT COUNT(*) INTO ls_cnt
     FROM pscb_t
    WHERE pscbent = g_enterprise
      AND pscbsite = g_psca_m.pscasite
      AND pscb001 = g_psca_m.psca001
      AND pscb002 = g_gzcb_d[p_ac].gzcb002

   IF ls_cnt > 0 THEN
      #MESSAGE "Repeat Data"     #資料已存在   
   ELSE
       INSERT INTO pscb_t(pscbent,pscbsite,pscb001,pscb002,pscb003,pscb004)
          VALUES(g_enterprise,g_psca_m.pscasite,g_psca_m.psca001,
                 g_gzcb_d[p_ac].gzcb002,g_gzcb_d[p_ac].gzcb003,'N')
       DELETE FROM apsi002_gzcb_tmp WHERE gzcb003 = g_gzcb_d[p_ac].gzcb003
                                      AND gzcb002 = g_gzcb_d[p_ac].gzcb002
   END IF

END FUNCTION
################################################################################
# Descriptions...: 設定必要輸入
# Memo...........:
# Usage..........: CALL apsi002_set_required(p_cmd)
# Input parameter: p_cmd：模式
# Return code....: 無
# Date & Author..: 2014/03/24 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_set_required(p_cmd)
   DEFINE p_cmd LIKE type_t.num5  
   
   IF g_psca_m.psca019 = 'Y' THEN 
      CALL cl_set_comp_required("psca020",TRUE) 
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 設定非必輸
# Memo...........:
# Usage..........: CALL apsi002_set_no_required(p_cmd)
# Input parameter: p_cmd：模式
# Return code....: 無
# Date & Author..: 2014/03/24 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_set_no_required(p_cmd)
   DEFINE p_cmd LIKE type_t.num5 

   CALL cl_set_comp_required("psca020",FALSE) 
END FUNCTION

################################################################################
# Descriptions...: 更新最後修改者與修改日期
# Memo...........:
# Usage..........: CALL apsi002_mod_upd()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/07 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_mod_upd()
   DEFINE l_pscamoddt     DATETIME YEAR TO SECOND

   LET l_pscamoddt = cl_get_current()

   UPDATE psca_t SET pscamodid = g_user,
                     pscamoddt = l_pscamoddt
    WHERE psca001 = g_psca_m.psca001
      AND pscaent = g_site         #160902-00048#1-add
      AND pscasite = g_enterprise  #160902-00048#1-add
END FUNCTION

################################################################################
# Descriptions...: 檢查參考APS編號
# Memo...........:
# Usage..........: CALL apsi002_chk_psca035()
# Date & Author..: 2014/10/21 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_chk_psca035()
   DEFINE l_pscastus     LIKE psca_t.pscastus

   LET g_errno = ''

   IF NOT cl_null(g_psca_m.psca001) THEN
      IF g_psca_m.psca001 = g_psca_m.psca035 THEN
         LET g_errno = 'aps-00125'                                 #參考APS編號不可與自身APS編號相同！  
         RETURN
      END IF
   END IF

   LET l_pscastus = ''
   SELECT pscastus INTO l_pscastus
     FROM psca_t
    WHERE pscaent  = g_enterprise
      AND pscasite = g_site
      AND psca001  = g_psca_m.psca035

   CASE
      WHEN SQLCA.sqlcode = 100      LET g_errno = 'aps-00073'      #輸入的資料不存在於AP 版本資料檔中！  
#      WHEN l_pscastus <> 'Y'        LET g_errno = 'aps-00074'      #輸入的資料無效！          #160318-00005#41  mark
      WHEN l_pscastus <> 'Y'        LET g_errno = 'sub-01302'      #輸入的資料無效！        #160318-00005#41  add
      OTHERWISE                     LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

PRIVATE FUNCTION apsi002_psca035_ref(p_psca035)
   DEFINE p_psca035     LIKE psca_t.psca035
   DEFINE r_pscal003    LIKE pscal_t.pscal003

   LET r_pscal003 = ''
   SELECT pscal003 INTO r_pscal003
     FROM pscal_t
    WHERE pscalent  = g_enterprise
      AND pscalsite = g_site
      AND pscal001  = p_psca035
      AND pscal002  = g_dlang

   RETURN r_pscal003
END FUNCTION

################################################################################
# Descriptions...: 取得最近執行日期
# Memo...........:
# Usage..........: CALL apsi002_get_psea002()
# Input parameter: 
# Return code....:
# Date & Author..: 20151120 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION apsi002_get_psea002()
   DEFINE l_str LIKE psea_t.psea002
   LET g_psca_m.l_psea002_1=''
   LET l_str= ''
   SELECT MAX(psea002) INTO l_str     
     FROM psea_t
    WHERE pseaent = g_enterprise
      AND pseasite= g_psca_m.pscasite
      AND psea001 = g_psca_m.psca001
   IF NOT cl_null(l_str) THEN
      LET g_psca_m.l_psea002_1 = l_str[1,4],"/",l_str[5,6],"/",l_str[7,8]," ",l_str[9,10],":",l_str[11,12],":",l_str[13,14]
      LET g_psea002 = l_str  #161228-00044#2-add
   END IF
END FUNCTION

################################################################################
# Descriptions...: 開啟ACTION
# Memo...........:
# Usage..........: CALL apsi002_set_act_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/12/21 By Sarah
# Modify.........: 151207-00012#1 add
################################################################################
PRIVATE FUNCTION apsi002_set_act_visible()

   
   IF g_psca_m.psca039 = '2' THEN
      CALL cl_set_act_visible('create_apsdata,drop_apsdata',TRUE)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 關閉ACTION
# Memo...........:
# Usage..........: CALL apsi002_set_act_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/12/21 By Sarah
# Modify.........: 151207-00012#1 add
################################################################################
PRIVATE FUNCTION apsi002_set_act_no_visible()

   #當psca039=2.進階APS時，才有可能使用這兩個ACTION
   IF g_psca_m.psca039 = '2' THEN
      #判斷psca040=N(APS資料庫建立)時，"APS資料庫建立"才可使用
      IF g_psca_m.psca040 <> 'N' THEN
         CALL cl_set_act_visible('create_apsdata',FALSE)
      END IF
   
      #判斷psca040=Y(APS資料庫建立)時，"APS資料庫刪除"才可使用
      IF g_psca_m.psca040 <> 'Y' THEN
         CALL cl_set_act_visible('drop_apsdata',FALSE)
      END IF
   ELSE    #當psca039=1.APS時，將這兩個ACTION隱藏
      CALL cl_set_act_visible('create_apsdata,drop_apsdata',FALSE)
   END IF
   
END FUNCTION

 
{</section>}
 
