#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt450.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2016-11-04 09:52:53), PR版次:0017(2016-11-04 09:38:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000702
#+ Filename...: ammt450
#+ Description: 累計積點兌換維護作業
#+ Creator....: 04226(2014-03-13 09:09:22)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="ammt450.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#47 2016/04/29 By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160705-00042#10 2016/07/13 By sakura   程式中寫死g_prog(g_prog_name)部分改寫MATCHES方式
#160729-00077#20 2016/08/17 By lori     換贈活動提供符合卡號所屬會員的卡種/會員等級/會員屬性一~五清單,及校驗調整
#160816-00068#4  2016/08/19 By earl     調整transaction
#160818-00017#23 2016/08/29 By 08742    删除修改未重新判断状态码
#160905-00007#6  2016/09/05 By 02599    SQL条件增加ent
#160819-00054#14 2016/10/03 By lori     ammt451:基本資料/兌換規則資訊：新增資訊：來源單號(rtia007)、兌換業態(rtia066),及相關處理
#161004-00003#1  2016/10/05 By lori     ammt450_exchange_info() 中"此次兌換積點" SQL錯誤,mmci_t 相關SQL一併檢查處理
#161103-00027#1  2016/11/04 Ly lori     換贈活動規則開窗應過濾活動類型(使用argv[1])
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
PRIVATE type type_g_rtia_m        RECORD
       rtiasite LIKE rtia_t.rtiasite, 
   rtiasite_desc LIKE type_t.chr80, 
   rtiadocdt LIKE rtia_t.rtiadocdt, 
   rtia035 LIKE rtia_t.rtia035, 
   rtiadocno LIKE rtia_t.rtiadocno, 
   rtia006 LIKE rtia_t.rtia006, 
   rtia001 LIKE rtia_t.rtia001, 
   rtia001_desc LIKE type_t.chr80, 
   rtia042 LIKE rtia_t.rtia042, 
   rtia042_desc LIKE type_t.chr80, 
   rtia043 LIKE rtia_t.rtia043, 
   rtia044 LIKE rtia_t.rtia044, 
   rtia045 LIKE rtia_t.rtia045, 
   rtia044_desc LIKE type_t.chr80, 
   mmby006 LIKE mmby_t.mmby006, 
   rtia041 LIKE rtia_t.rtia041, 
   rtiastus LIKE rtia_t.rtiastus, 
   mmby009 LIKE mmby_t.mmby009, 
   mmby010 LIKE mmby_t.mmby010, 
   mmby011 LIKE mmby_t.mmby011, 
   mmby012 LIKE mmby_t.mmby012, 
   mmby013 LIKE mmby_t.mmby013, 
   rtia007 LIKE rtia_t.rtia007, 
   rtia066 LIKE rtia_t.rtia066, 
   rtia046 LIKE rtia_t.rtia046, 
   rtia0461 LIKE type_t.num15_3, 
   rtia047 LIKE rtia_t.rtia047, 
   rtia0471 LIKE type_t.num15_3, 
   rtia014 LIKE rtia_t.rtia014, 
   rtia015 LIKE rtia_t.rtia015, 
   rtiaunit LIKE rtia_t.rtiaunit, 
   rtia000 LIKE rtia_t.rtia000, 
   rtia026 LIKE rtia_t.rtia026, 
   rtia027 LIKE rtia_t.rtia027, 
   rtia002 LIKE rtia_t.rtia002, 
   rtia025 LIKE rtia_t.rtia025, 
   rtia032 LIKE rtia_t.rtia032, 
   rtia036 LIKE rtia_t.rtia036, 
   rtia036_desc LIKE type_t.chr80, 
   rtia037 LIKE rtia_t.rtia037, 
   rtia037_desc LIKE type_t.chr80, 
   rtia038 LIKE rtia_t.rtia038, 
   rtia038_desc LIKE type_t.chr80, 
   rtia039 LIKE rtia_t.rtia039, 
   isaf009 LIKE isaf_t.isaf009, 
   isaf013 LIKE isaf_t.isaf013, 
   isaf044 LIKE isaf_t.isaf044, 
   isaf202 LIKE isaf_t.isaf202, 
   isaf203 LIKE isaf_t.isaf203, 
   isaf204 LIKE isaf_t.isaf204, 
   isaf201 LIKE isaf_t.isaf201, 
   isaf207 LIKE isaf_t.isaf207, 
   rtiaownid LIKE rtia_t.rtiaownid, 
   rtiaownid_desc LIKE type_t.chr80, 
   rtiaowndp LIKE rtia_t.rtiaowndp, 
   rtiaowndp_desc LIKE type_t.chr80, 
   rtiacrtid LIKE rtia_t.rtiacrtid, 
   rtiacrtid_desc LIKE type_t.chr80, 
   rtiacrtdp LIKE rtia_t.rtiacrtdp, 
   rtiacrtdp_desc LIKE type_t.chr80, 
   rtiacrtdt LIKE rtia_t.rtiacrtdt, 
   rtiamodid LIKE rtia_t.rtiamodid, 
   rtiamodid_desc LIKE type_t.chr80, 
   rtiamoddt LIKE rtia_t.rtiamoddt, 
   rtiacnfid LIKE rtia_t.rtiacnfid, 
   rtiacnfid_desc LIKE type_t.chr80, 
   rtiacnfdt LIKE rtia_t.rtiacnfdt, 
   rtiapstid LIKE rtia_t.rtiapstid, 
   rtiapstid_desc LIKE type_t.chr80, 
   rtiapstdt LIKE rtia_t.rtiapstdt, 
   sum1 LIKE type_t.num10, 
   sum2 LIKE type_t.num20_6, 
   sum3 LIKE type_t.num20_6, 
   sum4 LIKE type_t.num20_6
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mmfe_d        RECORD
       mmfeseq LIKE mmfe_t.mmfeseq, 
   mmfe001 LIKE mmfe_t.mmfe001, 
   mmfe001_desc LIKE type_t.chr500, 
   mmfe003 LIKE mmfe_t.mmfe003, 
   mmfe003_desc LIKE type_t.chr500, 
   mmfe004 LIKE mmfe_t.mmfe004, 
   mmfe005 LIKE mmfe_t.mmfe005, 
   mmfe006 LIKE mmfe_t.mmfe006, 
   mmfe007 LIKE mmfe_t.mmfe007, 
   mmfe008 LIKE mmfe_t.mmfe008, 
   mmfe009 LIKE mmfe_t.mmfe009, 
   mmfe010 LIKE mmfe_t.mmfe010, 
   mmfe010_desc LIKE type_t.chr500, 
   mmfe011 LIKE mmfe_t.mmfe011, 
   mmfe012 LIKE mmfe_t.mmfe012, 
   mmfe013 LIKE mmfe_t.mmfe013, 
   mmfe013_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_mmfe2_d RECORD
       rtibseq LIKE rtib_t.rtibseq, 
   rtib003 LIKE rtib_t.rtib003, 
   rtib004 LIKE rtib_t.rtib004, 
   rtib004_desc LIKE type_t.chr500, 
   rtib006 LIKE rtib_t.rtib006, 
   rtib006_desc LIKE type_t.chr500, 
   rtib008 LIKE rtib_t.rtib008, 
   rtib009 LIKE rtib_t.rtib009, 
   rtib010 LIKE rtib_t.rtib010, 
   rtib012 LIKE rtib_t.rtib012, 
   rtib013 LIKE rtib_t.rtib013, 
   rtib013_desc LIKE type_t.chr500, 
   rtib018 LIKE rtib_t.rtib018, 
   rtib018_desc LIKE type_t.chr500, 
   rtib015 LIKE rtib_t.rtib015, 
   rtib015_desc LIKE type_t.chr500, 
   rtib016 LIKE rtib_t.rtib016, 
   rtib019 LIKE rtib_t.rtib019, 
   rtib020 LIKE rtib_t.rtib020, 
   rtib021 LIKE rtib_t.rtib021, 
   rtib022 LIKE rtib_t.rtib022, 
   rtib025 LIKE rtib_t.rtib025, 
   rtib025_desc LIKE type_t.chr500, 
   rtib030 LIKE rtib_t.rtib030
       END RECORD
PRIVATE TYPE type_g_mmfe3_d RECORD
       xrcd007 LIKE xrcd_t.xrcd007, 
   xrcdld LIKE xrcd_t.xrcdld, 
   xrcdseq LIKE xrcd_t.xrcdseq, 
   rtib0031 LIKE type_t.chr500, 
   rtib0041 LIKE type_t.chr500, 
   rtib0041_desc LIKE type_t.chr500, 
   xrcdseq2 LIKE xrcd_t.xrcdseq2, 
   xrcd002 LIKE xrcd_t.xrcd002, 
   xrcd002_desc LIKE type_t.chr500, 
   xrcd003 LIKE xrcd_t.xrcd003, 
   xrcd006 LIKE xrcd_t.xrcd006, 
   xrcd004 LIKE xrcd_t.xrcd004, 
   xrcd104 LIKE xrcd_t.xrcd104
       END RECORD
PRIVATE TYPE type_g_mmfe4_d RECORD
       rtieseq LIKE rtie_t.rtieseq, 
   rtieseq1 LIKE rtie_t.rtieseq1, 
   rtib0032 LIKE type_t.chr500, 
   rtib0042 LIKE type_t.chr500, 
   rtib0042_desc LIKE type_t.chr500, 
   rtie001 LIKE rtie_t.rtie001, 
   rtie002 LIKE rtie_t.rtie002, 
   rtie002_desc LIKE type_t.chr500, 
   rtie006 LIKE rtie_t.rtie006
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rtiasite LIKE rtia_t.rtiasite,
   b_rtiasite_desc LIKE type_t.chr80,
      b_rtiadocdt LIKE rtia_t.rtiadocdt,
      b_rtia035 LIKE rtia_t.rtia035,
      b_rtiadocno LIKE rtia_t.rtiadocno,
      b_rtia001 LIKE rtia_t.rtia001,
   b_rtia001_desc LIKE type_t.chr80,
      b_rtia042 LIKE rtia_t.rtia042,
   b_rtia042_desc LIKE type_t.chr80,
      b_rtia043 LIKE rtia_t.rtia043
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_ooef015             LIKE ooef_t.ooef015
DEFINE g_ooef016             LIKE ooef_t.ooef016
DEFINE g_ooef019             LIKE ooef_t.ooef019
DEFINE g_ooef108             LIKE ooef_t.ooef108
DEFINE g_rtia044_str         STRING
DEFINE g_prog_name           LIKE type_t.chr10
DEFINE g_mmbo004             LIKE mmbo_t.mmbo004
DEFINE g_err_str             STRING
DEFINE g_gzcb002             LIKE gzcb_t.gzcb002
DEFINE g_mmby002             LIKE mmby_t.mmby002
DEFINE g_site_flag           LIKE type_t.num5
#160819-00054#14 161003 by lori add---(S)
DEFINE g_mmby014             LIKE mmby_t.mmby014
DEFINE g_mmby015             LIKE mmby_t.mmby015
DEFINE g_mmby024             LIKE mmby_t.mmby024
#160819-00054#14 161003 by lori add---(E)
#end add-point
       
#模組變數(Module Variables)
DEFINE g_rtia_m          type_g_rtia_m
DEFINE g_rtia_m_t        type_g_rtia_m
DEFINE g_rtia_m_o        type_g_rtia_m
DEFINE g_rtia_m_mask_o   type_g_rtia_m #轉換遮罩前資料
DEFINE g_rtia_m_mask_n   type_g_rtia_m #轉換遮罩後資料
 
   DEFINE g_rtiadocno_t LIKE rtia_t.rtiadocno
 
 
DEFINE g_mmfe_d          DYNAMIC ARRAY OF type_g_mmfe_d
DEFINE g_mmfe_d_t        type_g_mmfe_d
DEFINE g_mmfe_d_o        type_g_mmfe_d
DEFINE g_mmfe_d_mask_o   DYNAMIC ARRAY OF type_g_mmfe_d #轉換遮罩前資料
DEFINE g_mmfe_d_mask_n   DYNAMIC ARRAY OF type_g_mmfe_d #轉換遮罩後資料
DEFINE g_mmfe2_d          DYNAMIC ARRAY OF type_g_mmfe2_d
DEFINE g_mmfe2_d_t        type_g_mmfe2_d
DEFINE g_mmfe2_d_o        type_g_mmfe2_d
DEFINE g_mmfe2_d_mask_o   DYNAMIC ARRAY OF type_g_mmfe2_d #轉換遮罩前資料
DEFINE g_mmfe2_d_mask_n   DYNAMIC ARRAY OF type_g_mmfe2_d #轉換遮罩後資料
DEFINE g_mmfe3_d          DYNAMIC ARRAY OF type_g_mmfe3_d
DEFINE g_mmfe3_d_t        type_g_mmfe3_d
DEFINE g_mmfe3_d_o        type_g_mmfe3_d
DEFINE g_mmfe3_d_mask_o   DYNAMIC ARRAY OF type_g_mmfe3_d #轉換遮罩前資料
DEFINE g_mmfe3_d_mask_n   DYNAMIC ARRAY OF type_g_mmfe3_d #轉換遮罩後資料
DEFINE g_mmfe4_d          DYNAMIC ARRAY OF type_g_mmfe4_d
DEFINE g_mmfe4_d_t        type_g_mmfe4_d
DEFINE g_mmfe4_d_o        type_g_mmfe4_d
DEFINE g_mmfe4_d_mask_o   DYNAMIC ARRAY OF type_g_mmfe4_d #轉換遮罩前資料
DEFINE g_mmfe4_d_mask_n   DYNAMIC ARRAY OF type_g_mmfe4_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
 
 
DEFINE g_wc2_extend          STRING
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
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ammt450.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化 name="main.init"
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
   LET g_argv[1] = cl_replace_str(g_argv[1], '\'', '')
   LET g_prog_name = ''
   LET g_mmbo004 = ''
   CASE g_argv[1]
      WHEN '4'    #換贈
         LET g_prog_name = 'ammt450'
         LET g_gzcb002 = '7'
         LET g_mmbo004 = '4'
         #amm-00317 4 換贈規則(積點)
         LET g_err_str = cl_getmsg('amm-00317',g_dlang)
         
      WHEN '5'    #累計消費額
         LET g_prog_name = 'ammt451'
         LET g_gzcb002 = '8'
         LET g_mmbo004 = '5'
         #amm-00318 5 換贈規則(累計消費額)
         LET g_err_str = cl_getmsg('amm-00318',g_dlang)
        
      WHEN '6'    #外社卡
         LET g_prog_name = 'ammt452'
         LET g_gzcb002 = '9'
         LET g_mmbo004 = '6'
         #amm-00319 6 換贈規則(外社卡)
         LET g_err_str = cl_getmsg('amm-00319',g_dlang)
         
   END CASE
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT rtiasite,'',rtiadocdt,rtia035,rtiadocno,rtia006,rtia001,'',rtia042,'', 
       rtia043,rtia044,rtia045,'','',rtia041,rtiastus,'','','','','',rtia007,rtia066,rtia046,'',rtia047, 
       '',rtia014,rtia015,rtiaunit,rtia000,rtia026,rtia027,rtia002,rtia025,rtia032,rtia036,'',rtia037, 
       '',rtia038,'',rtia039,'','','','','','','','',rtiaownid,'',rtiaowndp,'',rtiacrtid,'',rtiacrtdp, 
       '',rtiacrtdt,rtiamodid,'',rtiamoddt,rtiacnfid,'',rtiacnfdt,rtiapstid,'',rtiapstdt,'','','',''", 
        
                      " FROM rtia_t",
                      " WHERE rtiaent= ? AND rtiadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   #151111-00021#1 20151112 mark by beckxie---S
   #LET g_forupd_sql = " SELECT rtiasite,'',rtiadocdt,rtia035,rtiadocno,rtia006,rtia001,'',rtia042,'', 
   #    rtia043,rtia044,rtia045,'','',rtia041,rtiastus,'','','','','',rtia046,'',rtia047,'',rtia014,rtia015, 
   #    rtiaunit,rtia000,rtia026,rtia027,rtia002,rtia025,rtia032,'','','','','','','','',rtiaownid,'', 
   #    rtiaowndp,'',rtiacrtid,'',rtiacrtdp,'',rtiacrtdt,rtiamodid,'',rtiamoddt,rtiacnfid,'',rtiacnfdt, 
   #    rtiapstid,'',rtiapstdt,'','','',''", 
   #    "FROM rtia_t WHERE rtiaent=  ? AND rtiadocno=? AND rtia000 = '",g_prog_name,"' FOR UPDATE"
   #151111-00021#1 20151112 mark by beckxie---E
   #151111-00021#1 20151112 add by beckxie---S
   LET g_forupd_sql = " SELECT rtiasite,'',rtiadocdt,rtia035,rtiadocno,rtia006,rtia001,'',rtia042,'', ",
       "rtia043,rtia044,rtia045,'','',rtia041,rtiastus,'','','','','',rtia007,rtia066,rtia046,'',rtia047,'',rtia014,rtia015, ",     #160819-00054#14 161003 by lori add:rtia007,rtia066
       "rtiaunit,rtia000,rtia026,rtia027,rtia002,rtia025,rtia032,rtia036,'',rtia037,'',rtia038,'',rtia039, ",
       "'','','','','','','','',rtiaownid,'',rtiaowndp,'',rtiacrtid,'',rtiacrtdp,'',rtiacrtdt,rtiamodid, ",
       "'',rtiamoddt,rtiacnfid,'',rtiacnfdt,rtiapstid,'',rtiapstdt,'','','',''", 
       "FROM rtia_t WHERE rtiaent=  ? AND rtiadocno=? AND rtia000 = '",g_prog_name,"' FOR UPDATE"
   #151111-00021#1 20151112 add by beckxie---E
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt450_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rtiasite,t0.rtiadocdt,t0.rtia035,t0.rtiadocno,t0.rtia006,t0.rtia001, 
       t0.rtia042,t0.rtia043,t0.rtia044,t0.rtia045,t0.rtia041,t0.rtiastus,t0.rtia007,t0.rtia066,t0.rtia046, 
       t0.rtia047,t0.rtia014,t0.rtia015,t0.rtiaunit,t0.rtia000,t0.rtia026,t0.rtia027,t0.rtia002,t0.rtia025, 
       t0.rtia032,t0.rtia036,t0.rtia037,t0.rtia038,t0.rtia039,t0.rtiaownid,t0.rtiaowndp,t0.rtiacrtid, 
       t0.rtiacrtdp,t0.rtiacrtdt,t0.rtiamodid,t0.rtiamoddt,t0.rtiacnfid,t0.rtiacnfdt,t0.rtiapstid,t0.rtiapstdt, 
       t1.ooefl003 ,t2.mmaf008 ,t3.mmanl003 ,t4.mmbyl004 ,t5.pcaal003 ,t6.pcab003 ,t7.oogd002 ,t8.ooag011 , 
       t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 ,t12.ooag011 ,t13.ooag011 ,t14.ooag011",
               " FROM rtia_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtiasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mmaf_t t2 ON t2.mmafent="||g_enterprise||" AND t2.mmaf003=t0.rtia001  ",
               " LEFT JOIN mmanl_t t3 ON t3.mmanlent="||g_enterprise||" AND t3.mmanl001=t0.rtia042 AND t3.mmanl002='"||g_dlang||"' ",
               " LEFT JOIN mmbyl_t t4 ON t4.mmbylent="||g_enterprise||" AND mmbysite=t0.rtiasite AND t4.mmbyl001=t0.rtia044 AND t4.mmbyl002=t0.rtia045 AND t4.mmbyl003='"||g_dlang||"' ",
               " LEFT JOIN pcaal_t t5 ON t5.pcaalent="||g_enterprise||" AND t5.pcaalsite=t0.rtiasite AND t5.pcaal001=t0.rtia036 AND t5.pcaal002='"||g_dlang||"' ",
               " LEFT JOIN pcab_t t6 ON t6.pcabent="||g_enterprise||" AND t6.pcab001=t0.rtia037  ",
               " LEFT JOIN oogd_t t7 ON t7.oogdent="||g_enterprise||" AND t7.oogd001=t0.rtia038 AND t7.oogdsite=t0.rtiasite  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.rtiaownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.rtiaowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.rtiacrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.rtiacrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.rtiamodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.rtiacnfid  ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.rtiapstid  ",
 
               " WHERE t0.rtiaent = " ||g_enterprise|| " AND t0.rtiadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   #151111-00021#1 20151112 mark by beckxie---S
   #LET g_sql = " SELECT UNIQUE t0.rtiasite,t0.rtiadocdt,t0.rtia035,t0.rtiadocno,t0.rtia006,t0.rtia001, 
   #    t0.rtia042,t0.rtia043,t0.rtia044,t0.rtia045,t0.rtia041,t0.rtiastus,t0.rtia046,t0.rtia047,t0.rtia014, 
   #    t0.rtia015,t0.rtiaunit,t0.rtia000,t0.rtia026,t0.rtia027,t0.rtia002,t0.rtia025,t0.rtia032,t0.rtiaownid, 
   #    t0.rtiaowndp,t0.rtiacrtid,t0.rtiacrtdp,t0.rtiacrtdt,t0.rtiamodid,t0.rtiamoddt,t0.rtiacnfid,t0.rtiacnfdt, 
   #    t0.rtiapstid,t0.rtiapstdt,t1.ooefl003 ,t2.mmaf008 ,t3.mmanl003 ,t4.mmbyl004 ,t5.ooag011 ,t6.ooefl003 , 
   #    t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooag011 ,t11.ooag011",
   #            " FROM rtia_t t0",
   #            " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.rtiasite AND t1.ooefl002='"||g_dlang||"' ",
   #            " LEFT JOIN mmaf_t t2 ON t2.mmafent='"||g_enterprise||"' AND t2.mmaf003=t0.rtia001  ",
   #            " LEFT JOIN mmanl_t t3 ON t3.mmanlent='"||g_enterprise||"' AND t3.mmanl001=t0.rtia042 AND t3.mmanl002='"||g_dlang||"' ",
   #            " LEFT JOIN mmbyl_t t4 ON t4.mmbylent='"||g_enterprise||"' AND t4.mmbylsite=t0.rtiasite AND t4.mmbyl001=t0.rtia044 AND t4.mmbyl002=t0.rtia045 AND t4.mmbyl003='"||g_dlang||"' ",
   #            " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.rtiaownid  ",
   #            " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=t0.rtiaowndp AND t6.ooefl002='"||g_dlang||"' ",
   #            " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t0.rtiacrtid  ",
   #            " LEFT JOIN ooefl_t t8 ON t8.ooeflent='"||g_enterprise||"' AND t8.ooefl001=t0.rtiacrtdp AND t8.ooefl002='"||g_dlang||"' ",
   #            " LEFT JOIN ooag_t t9 ON t9.ooagent='"||g_enterprise||"' AND t9.ooag001=t0.rtiamodid  ",
   #            " LEFT JOIN ooag_t t10 ON t10.ooagent='"||g_enterprise||"' AND t10.ooag001=t0.rtiacnfid  ",
   #            " LEFT JOIN ooag_t t11 ON t11.ooagent='"||g_enterprise||"' AND t11.ooag001=t0.rtiapstid  ",
   #
   #            " WHERE t0.rtiaent = '" ||g_enterprise|| "' AND t0.rtiadocno = ? AND t0.rtia000 = '",g_prog_name,"' "
   #151111-00021#1 20151112 mark by beckxie---E
   #151111-00021#1 20151112 add by beckxie---S
   LET g_sql = " SELECT UNIQUE t0.rtiasite,t0.rtiadocdt,t0.rtia035,t0.rtiadocno,t0.rtia006,t0.rtia001, ",
               "               t0.rtia042,t0.rtia043,t0.rtia044,t0.rtia045,t0.rtia041,t0.rtiastus,t0.rtia007,t0.rtia066,t0.rtia046,t0.rtia047,t0.rtia014, ",    #160819-00054#14 161003 by lori add:rtia007,rtia066
               "               t0.rtia015,t0.rtiaunit,t0.rtia000,t0.rtia026,t0.rtia027,t0.rtia002,t0.rtia025,t0.rtia032,t0.rtia036, ",
               "               t0.rtia037,t0.rtia038,t0.rtia039,t0.rtiaownid,t0.rtiaowndp,t0.rtiacrtid,t0.rtiacrtdp,t0.rtiacrtdt, ",
               "               t0.rtiamodid,t0.rtiamoddt,t0.rtiacnfid,t0.rtiacnfdt,t0.rtiapstid,t0.rtiapstdt,t1.ooefl003 ,t2.mmaf008 , ",
               "               t3.mmanl003 ,t4.mmbyl004 ,t5.pcaal003 ,t6.ooag011 ,t7.oogd002 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 , ",
               "               t11.ooefl003 ,t12.ooag011 ,t13.ooag011 ,t14.ooag011",
               " FROM rtia_t t0",
               " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.rtiasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mmaf_t t2 ON t2.mmafent='"||g_enterprise||"' AND t2.mmaf003=t0.rtia001  ",
               " LEFT JOIN mmanl_t t3 ON t3.mmanlent='"||g_enterprise||"' AND t3.mmanl001=t0.rtia042 AND t3.mmanl002='"||g_dlang||"' ",
               " LEFT JOIN mmbyl_t t4 ON t4.mmbylent='"||g_enterprise||"' AND mmbylsite=t0.rtiasite AND t4.mmbyl001=t0.rtia044 AND t4.mmbyl002=t0.rtia045 AND t4.mmbyl003='"||g_dlang||"' ",
               " LEFT JOIN pcaal_t t5 ON t5.pcaalent='"||g_enterprise||"' AND t5.pcaalsite=t0.rtiasite AND t5.pcaal001=t0.rtia036 AND t5.pcaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=t0.rtia037  ",
               " LEFT JOIN oogd_t t7 ON t7.oogdent='"||g_enterprise||"' AND t7.oogd001=t0.rtia038 AND t7.oogdsite=t0.rtiasite  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.rtiaownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=t0.rtiaowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent='"||g_enterprise||"' AND t10.ooag001=t0.rtiacrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent='"||g_enterprise||"' AND t11.ooefl001=t0.rtiacrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent='"||g_enterprise||"' AND t12.ooag001=t0.rtiamodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent='"||g_enterprise||"' AND t13.ooag001=t0.rtiacnfid  ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent='"||g_enterprise||"' AND t14.ooag001=t0.rtiapstid  ",
 
               " WHERE t0.rtiaent = '" ||g_enterprise|| "' AND t0.rtiadocno = ? AND t0.rtia000 = '",g_prog_name,"' "
   #LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #151111-00021#1 20151112 add by beckxie---E
   #end add-point
   PREPARE ammt450_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammt450 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammt450_init()   
 
      #進入選單 Menu (="N")
      CALL ammt450_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
 
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammt450
      
   END IF 
   
   CLOSE ammt450_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE ammt450_tmp
   DROP TABLE ammt450_tmp1 
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ammt450.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ammt450_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('rtiastus','13','N,Y,S,Z,A,D,R,W,X')
 
      CALL cl_set_combo_scc('mmby009','6534') 
   CALL cl_set_combo_scc('mmby010','6535') 
   CALL cl_set_combo_scc('mmby011','6536') 
   CALL cl_set_combo_scc('rtia066','6201') 
   CALL cl_set_combo_scc('rtia032','6544') 
   CALL cl_set_combo_scc('rtia039','6202') 
   CALL cl_set_combo_scc('mmfe012','6517') 
   CALL cl_set_combo_scc('rtie001','8310') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('mmby009','6534')
   CALL cl_set_combo_scc('mmby010','6535')
   CALL cl_set_combo_scc('mmby011','6536')
   LET g_ooef004 = ''
   LET g_ooef015 = ''
   LET g_ooef016 = ''
   LET g_ooef019 = ''
   LET g_ooef108 = ''
   SELECT ooef004,ooef015,ooef016,ooef019,ooef108
     INTO g_ooef004,g_ooef015,g_ooef016,g_ooef019,g_ooef108
     FROM ooef_t
    WHERE ooef001 = g_site
      AND ooefent = g_enterprise
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   LET g_errshow = 1
   IF g_mmbo004 = '4' THEN
      CALL cl_set_comp_visible("rtia043",TRUE)
      CALL cl_set_comp_required("rtia001",TRUE)   #150513-00009#1 By pomelo add
   ELSE
      CALL cl_set_comp_visible("rtia043",FALSE)
      CALL cl_set_comp_required("rtia042",TRUE)   #150513-00009#1 By pomelo add
   END IF
   CALL ammt450_change_text()
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   
   #160819-00054#14 161003 by lori add---(S)
   CALL ammt450_set_visible() 
   CALL ammt450_set_no_visible()   
   CALL ammt450_set_no_required()   
   CALL ammt450_set_required()
   #160819-00054#14 161003 by lori add----(E)
   #end add-point
   
   #初始化搜尋條件
   CALL ammt450_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="ammt450.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION ammt450_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_cnt       LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
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
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL ammt450_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_rtia_m.* TO NULL
         CALL g_mmfe_d.clear()
         CALL g_mmfe2_d.clear()
         CALL g_mmfe3_d.clear()
         CALL g_mmfe4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ammt450_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
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
               
               CALL ammt450_fetch('') # reload data
               LET l_ac = 1
               CALL ammt450_ui_detailshow() #Setting the current row 
         
               CALL ammt450_idx_chk()
               #NEXT FIELD mmfeseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mmfe_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt450_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL ammt450_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_mmfe2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt450_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL ammt450_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mmfe3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt450_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL ammt450_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page3_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aooi610
                  LET g_action_choice="prog_aooi610"
                  IF cl_auth_chk_act("prog_aooi610") THEN
                     
                     #add-point:ON ACTION prog_aooi610 name="menu.detail_show.page3_sub.prog_aooi610"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aooi610'
               LET la_param.param[1] = g_mmfe3_d[l_ac].xrcd002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page3.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mmfe4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt450_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL ammt450_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL ammt450_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL ammt450_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL ammt450_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL ammt450_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
 
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL ammt450_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL ammt450_set_act_visible()   
            CALL ammt450_set_act_no_visible()
            IF NOT (g_rtia_m.rtiadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rtiaent = " ||g_enterprise|| " AND",
                                  " rtiadocno = '", g_rtia_m.rtiadocno, "' "
 
               #填到對應位置
               CALL ammt450_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "rtia_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmfe_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtib_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xrcd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "rtie_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL ammt450_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "rtia_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmfe_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtib_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xrcd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "rtie_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL ammt450_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammt450_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL ammt450_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL ammt450_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt450_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL ammt450_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt450_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL ammt450_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt450_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL ammt450_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt450_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL ammt450_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt450_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mmfe_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mmfe2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_mmfe3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_mmfe4_d)
                  LET g_export_id[4]   = "s_detail4"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()
            END IF
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
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
               NEXT FIELD mmfeseq
            END IF
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
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
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL ammt450_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL ammt450_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ammt450_s_note
            LET g_action_choice="ammt450_s_note"
            IF cl_auth_chk_act("ammt450_s_note") THEN
               
               #add-point:ON ACTION ammt450_s_note name="menu.ammt450_s_note"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ammt450_aooi360_01
            LET g_action_choice="ammt450_aooi360_01"
            IF cl_auth_chk_act("ammt450_aooi360_01") THEN
               
               #add-point:ON ACTION ammt450_aooi360_01 name="menu.ammt450_aooi360_01"
               CALL aooi360_01('6',g_rtia_m.rtiadocno,'','','','','','','','','')
               LET g_action_choice= ""
               LET INT_FLAG = ''
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL ammt450_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammt450_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_ammt450_01
            LET g_action_choice="open_ammt450_01"
            IF cl_auth_chk_act("open_ammt450_01") THEN
               
               #add-point:ON ACTION open_ammt450_01 name="menu.open_ammt450_01"
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM rtie_t
                WHERE rtieent = g_enterprise
                  AND rtiedocno = g_rtia_m.rtiadocno
               IF l_cnt >= 1 THEN
                  #此單據已有收款明細，無法進行換贈的動作！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00290'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               IF NOT cl_null(g_rtia_m.rtiadocno) AND l_cnt = 0 AND g_rtia_m.rtiastus = 'N' THEN
                  CALL s_transaction_begin()
                  CALL ammt450_create_temptable()
                  CALL ammt450_01(g_rtia_m.rtiadocno)
                  CALL ammt450_recount_point()
                  CALL s_transaction_end('Y','0') 
                  LET g_action_choice = ""
                  LET INT_FLAG = ''
                  CALL ammt450_b_fill()   #160106-00002#3 20160107 add by beckxie
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amm/ammt450_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amm/ammt450_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL ammt450_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammt450_query()
               #add-point:ON ACTION query name="menu.query"
               #160819-00054#14 161003 by lori add---(S)
               CALL ammt450_set_visible() 
               CALL ammt450_set_no_visible()   
               CALL ammt450_set_no_required()   
               CALL ammt450_set_required()
               #160819-00054#14 161003 by lori add----(E)
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ammt450_s_pay_09
            LET g_action_choice="ammt450_s_pay_09"
            IF cl_auth_chk_act("ammt450_s_pay_09") THEN
               
               #add-point:ON ACTION ammt450_s_pay_09 name="menu.ammt450_s_pay_09"
               CALL s_pay_09(g_rtia_m.rtiadocno)
               LET g_action_choice= ""
               LET INT_FLAG = ''
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ammt450_s_pay
            LET g_action_choice="ammt450_s_pay"
            IF cl_auth_chk_act("ammt450_s_pay") THEN
               
               #add-point:ON ACTION ammt450_s_pay name="menu.ammt450_s_pay"
               IF g_rtia_m.rtiastus = 'N'  THEN
                  CALL s_pay('rtia_t',1,g_rtia_m.rtiadocno)
                  LET g_action_choice= ""
                  LET INT_FLAG = ''
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammt450_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt450_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt450_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rtia_m.rtiadocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="ammt450.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION ammt450_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   LET l_where = s_aooi500_sql_where(g_prog_name,'rtiasite')
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT rtiadocno ",
                      " FROM rtia_t ",
                      " ",
                      " LEFT JOIN mmfe_t ON mmfeent = rtiaent AND rtiadocno = mmfedocno ", "  ",
                      #add-point:browser_fill段sql(mmfe_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN rtib_t ON rtibent = rtiaent AND rtiadocno = rtibdocno", "  ",
                      #add-point:browser_fill段sql(rtib_t1) name="browser_fill.cnt.join.rtib_t1"
                      
                      #end add-point
 
                      " LEFT JOIN xrcd_t ON xrcdent = rtiaent AND rtiadocno = xrcddocno", "  ",
                      #add-point:browser_fill段sql(xrcd_t1) name="browser_fill.cnt.join.xrcd_t1"
                      
                      #end add-point
 
                      " LEFT JOIN rtie_t ON rtieent = rtiaent AND rtiadocno = rtiedocno", "  ",
                      #add-point:browser_fill段sql(rtie_t1) name="browser_fill.cnt.join.rtie_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE rtiaent = " ||g_enterprise|| " AND mmfeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rtia_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rtiadocno ",
                      " FROM rtia_t ", 
                      "  ",
                      "  ",
                      " WHERE rtiaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rtia_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql CLIPPED," AND ",l_where
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
 
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_rtia_m.* TO NULL
      CALL g_mmfe_d.clear()        
      CALL g_mmfe2_d.clear() 
      CALL g_mmfe3_d.clear() 
      CALL g_mmfe4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rtiasite,t0.rtiadocdt,t0.rtia035,t0.rtiadocno,t0.rtia001,t0.rtia042,t0.rtia043 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtiastus,t0.rtiasite,t0.rtiadocdt,t0.rtia035,t0.rtiadocno,t0.rtia001, 
          t0.rtia042,t0.rtia043,t1.ooefl003 ,t2.mmaf008 ,t3.mmanl003 ",
                  " FROM rtia_t t0",
                  "  ",
                  "  LEFT JOIN mmfe_t ON mmfeent = rtiaent AND rtiadocno = mmfedocno ", "  ", 
                  #add-point:browser_fill段sql(mmfe_t1) name="browser_fill.join.mmfe_t1"
                  
                  #end add-point
                  "  LEFT JOIN rtib_t ON rtibent = rtiaent AND rtiadocno = rtibdocno", "  ", 
                  #add-point:browser_fill段sql(rtib_t1) name="browser_fill.join.rtib_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xrcd_t ON xrcdent = rtiaent AND rtiadocno = xrcddocno", "  ", 
                  #add-point:browser_fill段sql(xrcd_t1) name="browser_fill.join.xrcd_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN rtie_t ON rtieent = rtiaent AND rtiadocno = rtiedocno", "  ", 
                  #add-point:browser_fill段sql(rtie_t1) name="browser_fill.join.rtie_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtiasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mmaf_t t2 ON t2.mmafent="||g_enterprise||" AND t2.mmaf003=t0.rtia001  ",
               " LEFT JOIN mmanl_t t3 ON t3.mmanlent="||g_enterprise||" AND t3.mmanl001=t0.rtia042 AND t3.mmanl002='"||g_dlang||"' ",
 
                  " WHERE t0.rtiaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rtia_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtiastus,t0.rtiasite,t0.rtiadocdt,t0.rtia035,t0.rtiadocno,t0.rtia001, 
          t0.rtia042,t0.rtia043,t1.ooefl003 ,t2.mmaf008 ,t3.mmanl003 ",
                  " FROM rtia_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtiasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mmaf_t t2 ON t2.mmafent="||g_enterprise||" AND t2.mmaf003=t0.rtia001  ",
               " LEFT JOIN mmanl_t t3 ON t3.mmanlent="||g_enterprise||" AND t3.mmanl001=t0.rtia042 AND t3.mmanl002='"||g_dlang||"' ",
 
                  " WHERE t0.rtiaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rtia_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql CLIPPED," AND ",l_where
   #end add-point
   LET g_sql = g_sql, " ORDER BY rtiadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
 
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtia_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rtiasite,g_browser[g_cnt].b_rtiadocdt, 
          g_browser[g_cnt].b_rtia035,g_browser[g_cnt].b_rtiadocno,g_browser[g_cnt].b_rtia001,g_browser[g_cnt].b_rtia042, 
          g_browser[g_cnt].b_rtia043,g_browser[g_cnt].b_rtiasite_desc,g_browser[g_cnt].b_rtia001_desc, 
          g_browser[g_cnt].b_rtia042_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_rtia001
      CALL ap_ref_array2(g_ref_fields,"SELECT mmaf008 FROM mmaq_t LEFT OUTER JOIN mmaf_t ON mmaq003 = mmaf001 AND mmafent = mmaqent
                                        WHERE mmafent='"||g_enterprise||"' AND mmaq001=? ","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_rtia001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_rtia001_desc
         #end add-point
      
         #遮罩相關處理
         CALL ammt450_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
         WHEN "Z"
            LET g_browser[g_cnt].b_statepic = "stus/16/unposted.png"
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
   
   IF cl_null(g_browser[g_cnt].b_rtiadocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
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
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION ammt450_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rtia_m.rtiadocno = g_browser[g_current_idx].b_rtiadocno   
 
   EXECUTE ammt450_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtia035,g_rtia_m.rtiadocno,g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043, 
       g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia041,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia066, 
       g_rtia_m.rtia046,g_rtia_m.rtia047,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000, 
       g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036, 
       g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtiaownid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtid, 
       g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid, 
       g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia001_desc, 
       g_rtia_m.rtia042_desc,g_rtia_m.rtia044_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
   CALL ammt450_rtia_t_mask()
   CALL ammt450_show()
      
END FUNCTION
 
{</section>}
 
{<section id="ammt450.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION ammt450_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION ammt450_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_rtiadocno = g_rtia_m.rtiadocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
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
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammt450_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_rtia_m.* TO NULL
   CALL g_mmfe_d.clear()        
   CALL g_mmfe2_d.clear() 
   CALL g_mmfe3_d.clear() 
   CALL g_mmfe4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON rtiasite,rtiadocdt,rtia035,rtiadocno,rtia006,rtia001,rtia042,rtia043, 
          rtia044,rtia045,rtia041,rtiastus,rtia007,rtia066,rtia0471,rtia015,rtiaunit,rtia000,rtia026, 
          rtia027,rtia002,rtia025,rtia032,rtia036,rtia037,rtia038,rtia039,rtiaownid,rtiaowndp,rtiacrtid, 
          rtiacrtdp,rtiacrtdt,rtiamodid,rtiamoddt,rtiacnfid,rtiacnfdt,rtiapstid,rtiapstdt,sum1,sum4
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtiacrtdt>>----
         AFTER FIELD rtiacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtiamoddt>>----
         AFTER FIELD rtiamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtiacnfdt>>----
         AFTER FIELD rtiacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtiapstdt>>----
         AFTER FIELD rtiapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rtiasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiasite
            #add-point:ON ACTION controlp INFIELD rtiasite name="construct.c.rtiasite"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog_name,'rtiasite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiasite  #顯示到畫面上
            NEXT FIELD rtiasite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiasite
            #add-point:BEFORE FIELD rtiasite name="construct.b.rtiasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiasite
            
            #add-point:AFTER FIELD rtiasite name="construct.a.rtiasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiadocdt
            #add-point:BEFORE FIELD rtiadocdt name="construct.b.rtiadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiadocdt
            
            #add-point:AFTER FIELD rtiadocdt name="construct.a.rtiadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiadocdt
            #add-point:ON ACTION controlp INFIELD rtiadocdt name="construct.c.rtiadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia035
            #add-point:BEFORE FIELD rtia035 name="construct.b.rtia035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia035
            
            #add-point:AFTER FIELD rtia035 name="construct.a.rtia035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia035
            #add-point:ON ACTION controlp INFIELD rtia035 name="construct.c.rtia035"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtiadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiadocno
            #add-point:ON ACTION controlp INFIELD rtiadocno name="construct.c.rtiadocno"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " rtia000 = '",g_prog_name,"'"
            CALL q_rtiadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiadocno  #顯示到畫面上

            NEXT FIELD rtiadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiadocno
            #add-point:BEFORE FIELD rtiadocno name="construct.b.rtiadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiadocno
            
            #add-point:AFTER FIELD rtiadocno name="construct.a.rtiadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia006
            #add-point:BEFORE FIELD rtia006 name="construct.b.rtia006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia006
            
            #add-point:AFTER FIELD rtia006 name="construct.a.rtia006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia006
            #add-point:ON ACTION controlp INFIELD rtia006 name="construct.c.rtia006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtia001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia001
            #add-point:ON ACTION controlp INFIELD rtia001 name="construct.c.rtia001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmaq001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia001  #顯示到畫面上

            NEXT FIELD rtia001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia001
            #add-point:BEFORE FIELD rtia001 name="construct.b.rtia001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia001
            
            #add-point:AFTER FIELD rtia001 name="construct.a.rtia001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia042
            #add-point:ON ACTION controlp INFIELD rtia042 name="construct.c.rtia042"
            #此段落由子樣板a08產生
            #開窗c段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	#160705-00042#9 160713 by sakura mark(S)
		   	#CASE g_prog_name
			   #   WHEN 'ammt452'
			   #160705-00042#9 160713 by sakura mark(E)
			   #160705-00042#9 160713 by sakura add(S)
		   	CASE 
			      WHEN g_prog_name MATCHES 'ammt452'	
            #160705-00042#9 160713 by sakura add(E)			      
			        CALL q_mman001_3()
			      OTHERWISE
                  CALL q_mman001_9()                           #呼叫開窗
            END CASE
            DISPLAY g_qryparam.return1 TO rtia042  #顯示到畫面上

            NEXT FIELD rtia042                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia042
            #add-point:BEFORE FIELD rtia042 name="construct.b.rtia042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia042
            
            #add-point:AFTER FIELD rtia042 name="construct.a.rtia042"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia043
            #add-point:BEFORE FIELD rtia043 name="construct.b.rtia043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia043
            
            #add-point:AFTER FIELD rtia043 name="construct.a.rtia043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia043
            #add-point:ON ACTION controlp INFIELD rtia043 name="construct.c.rtia043"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtia044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia044
            #add-point:ON ACTION controlp INFIELD rtia044 name="construct.c.rtia044"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		    	LET g_qryparam.reqry = FALSE
		    	LET g_qryparam.where = " mmby004 = '",g_mmbo004,"'"
            CALL q_mmby001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia044  #顯示到畫面上

            NEXT FIELD rtia044                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia044
            #add-point:BEFORE FIELD rtia044 name="construct.b.rtia044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia044
            
            #add-point:AFTER FIELD rtia044 name="construct.a.rtia044"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia045
            #add-point:BEFORE FIELD rtia045 name="construct.b.rtia045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia045
            
            #add-point:AFTER FIELD rtia045 name="construct.a.rtia045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia045
            #add-point:ON ACTION controlp INFIELD rtia045 name="construct.c.rtia045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia041
            #add-point:BEFORE FIELD rtia041 name="construct.b.rtia041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia041
            
            #add-point:AFTER FIELD rtia041 name="construct.a.rtia041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia041
            #add-point:ON ACTION controlp INFIELD rtia041 name="construct.c.rtia041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiastus
            #add-point:BEFORE FIELD rtiastus name="construct.b.rtiastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiastus
            
            #add-point:AFTER FIELD rtiastus name="construct.a.rtiastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiastus
            #add-point:ON ACTION controlp INFIELD rtiastus name="construct.c.rtiastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtia007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia007
            #add-point:ON ACTION controlp INFIELD rtia007 name="construct.c.rtia007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160819-00054#14 161003 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_rtia007()       
            
            DISPLAY g_qryparam.return1 TO rtia007 
            NEXT FIELD rtia007 
            #160819-00054#14 161003 by lori add---(E)            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia007
            #add-point:BEFORE FIELD rtia007 name="construct.b.rtia007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia007
            
            #add-point:AFTER FIELD rtia007 name="construct.a.rtia007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia066
            #add-point:BEFORE FIELD rtia066 name="construct.b.rtia066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia066
            
            #add-point:AFTER FIELD rtia066 name="construct.a.rtia066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia066
            #add-point:ON ACTION controlp INFIELD rtia066 name="construct.c.rtia066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia047
            #add-point:BEFORE FIELD rtia047 name="construct.b.rtia047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia047
            
            #add-point:AFTER FIELD rtia047 name="construct.a.rtia047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia047
            #add-point:ON ACTION controlp INFIELD rtia047 name="construct.c.rtia047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia0471
            #add-point:BEFORE FIELD rtia0471 name="construct.b.rtia0471"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia0471
            
            #add-point:AFTER FIELD rtia0471 name="construct.a.rtia0471"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia0471
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia0471
            #add-point:ON ACTION controlp INFIELD rtia0471 name="construct.c.rtia0471"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia015
            #add-point:BEFORE FIELD rtia015 name="construct.b.rtia015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia015
            
            #add-point:AFTER FIELD rtia015 name="construct.a.rtia015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia015
            #add-point:ON ACTION controlp INFIELD rtia015 name="construct.c.rtia015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiaunit
            #add-point:BEFORE FIELD rtiaunit name="construct.b.rtiaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiaunit
            
            #add-point:AFTER FIELD rtiaunit name="construct.a.rtiaunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiaunit
            #add-point:ON ACTION controlp INFIELD rtiaunit name="construct.c.rtiaunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia000
            #add-point:BEFORE FIELD rtia000 name="construct.b.rtia000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia000
            
            #add-point:AFTER FIELD rtia000 name="construct.a.rtia000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia000
            #add-point:ON ACTION controlp INFIELD rtia000 name="construct.c.rtia000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia026
            #add-point:BEFORE FIELD rtia026 name="construct.b.rtia026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia026
            
            #add-point:AFTER FIELD rtia026 name="construct.a.rtia026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia026
            #add-point:ON ACTION controlp INFIELD rtia026 name="construct.c.rtia026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia027
            #add-point:BEFORE FIELD rtia027 name="construct.b.rtia027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia027
            
            #add-point:AFTER FIELD rtia027 name="construct.a.rtia027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia027
            #add-point:ON ACTION controlp INFIELD rtia027 name="construct.c.rtia027"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtia002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia002
            #add-point:ON ACTION controlp INFIELD rtia002 name="construct.c.rtia002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia002  #顯示到畫面上

            NEXT FIELD rtia002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia002
            #add-point:BEFORE FIELD rtia002 name="construct.b.rtia002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia002
            
            #add-point:AFTER FIELD rtia002 name="construct.a.rtia002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia025
            #add-point:BEFORE FIELD rtia025 name="construct.b.rtia025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia025
            
            #add-point:AFTER FIELD rtia025 name="construct.a.rtia025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia025
            #add-point:ON ACTION controlp INFIELD rtia025 name="construct.c.rtia025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia032
            #add-point:BEFORE FIELD rtia032 name="construct.b.rtia032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia032
            
            #add-point:AFTER FIELD rtia032 name="construct.a.rtia032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia032
            #add-point:ON ACTION controlp INFIELD rtia032 name="construct.c.rtia032"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtia036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia036
            #add-point:ON ACTION controlp INFIELD rtia036 name="construct.c.rtia036"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pcaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia036  #顯示到畫面上
            NEXT FIELD rtia036                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia036
            #add-point:BEFORE FIELD rtia036 name="construct.b.rtia036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia036
            
            #add-point:AFTER FIELD rtia036 name="construct.a.rtia036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia037
            #add-point:ON ACTION controlp INFIELD rtia037 name="construct.c.rtia037"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pcab001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia037  #顯示到畫面上
            NEXT FIELD rtia037                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia037
            #add-point:BEFORE FIELD rtia037 name="construct.b.rtia037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia037
            
            #add-point:AFTER FIELD rtia037 name="construct.a.rtia037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia038
            #add-point:ON ACTION controlp INFIELD rtia038 name="construct.c.rtia038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oogd001_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia038  #顯示到畫面上
            NEXT FIELD rtia038                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia038
            #add-point:BEFORE FIELD rtia038 name="construct.b.rtia038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia038
            
            #add-point:AFTER FIELD rtia038 name="construct.a.rtia038"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia039
            #add-point:BEFORE FIELD rtia039 name="construct.b.rtia039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia039
            
            #add-point:AFTER FIELD rtia039 name="construct.a.rtia039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia039
            #add-point:ON ACTION controlp INFIELD rtia039 name="construct.c.rtia039"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtiaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiaownid
            #add-point:ON ACTION controlp INFIELD rtiaownid name="construct.c.rtiaownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiaownid  #顯示到畫面上

            NEXT FIELD rtiaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiaownid
            #add-point:BEFORE FIELD rtiaownid name="construct.b.rtiaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiaownid
            
            #add-point:AFTER FIELD rtiaownid name="construct.a.rtiaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiaowndp
            #add-point:ON ACTION controlp INFIELD rtiaowndp name="construct.c.rtiaowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiaowndp  #顯示到畫面上

            NEXT FIELD rtiaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiaowndp
            #add-point:BEFORE FIELD rtiaowndp name="construct.b.rtiaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiaowndp
            
            #add-point:AFTER FIELD rtiaowndp name="construct.a.rtiaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiacrtid
            #add-point:ON ACTION controlp INFIELD rtiacrtid name="construct.c.rtiacrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiacrtid  #顯示到畫面上

            NEXT FIELD rtiacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiacrtid
            #add-point:BEFORE FIELD rtiacrtid name="construct.b.rtiacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiacrtid
            
            #add-point:AFTER FIELD rtiacrtid name="construct.a.rtiacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiacrtdp
            #add-point:ON ACTION controlp INFIELD rtiacrtdp name="construct.c.rtiacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiacrtdp  #顯示到畫面上

            NEXT FIELD rtiacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiacrtdp
            #add-point:BEFORE FIELD rtiacrtdp name="construct.b.rtiacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiacrtdp
            
            #add-point:AFTER FIELD rtiacrtdp name="construct.a.rtiacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiacrtdt
            #add-point:BEFORE FIELD rtiacrtdt name="construct.b.rtiacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtiamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiamodid
            #add-point:ON ACTION controlp INFIELD rtiamodid name="construct.c.rtiamodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiamodid  #顯示到畫面上

            NEXT FIELD rtiamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiamodid
            #add-point:BEFORE FIELD rtiamodid name="construct.b.rtiamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiamodid
            
            #add-point:AFTER FIELD rtiamodid name="construct.a.rtiamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiamoddt
            #add-point:BEFORE FIELD rtiamoddt name="construct.b.rtiamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtiacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiacnfid
            #add-point:ON ACTION controlp INFIELD rtiacnfid name="construct.c.rtiacnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiacnfid  #顯示到畫面上

            NEXT FIELD rtiacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiacnfid
            #add-point:BEFORE FIELD rtiacnfid name="construct.b.rtiacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiacnfid
            
            #add-point:AFTER FIELD rtiacnfid name="construct.a.rtiacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiacnfdt
            #add-point:BEFORE FIELD rtiacnfdt name="construct.b.rtiacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtiapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiapstid
            #add-point:ON ACTION controlp INFIELD rtiapstid name="construct.c.rtiapstid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiapstid  #顯示到畫面上

            NEXT FIELD rtiapstid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiapstid
            #add-point:BEFORE FIELD rtiapstid name="construct.b.rtiapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiapstid
            
            #add-point:AFTER FIELD rtiapstid name="construct.a.rtiapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiapstdt
            #add-point:BEFORE FIELD rtiapstdt name="construct.b.rtiapstdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sum1
            #add-point:BEFORE FIELD sum1 name="construct.b.sum1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sum1
            
            #add-point:AFTER FIELD sum1 name="construct.a.sum1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sum1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sum1
            #add-point:ON ACTION controlp INFIELD sum1 name="construct.c.sum1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sum4
            #add-point:BEFORE FIELD sum4 name="construct.b.sum4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sum4
            
            #add-point:AFTER FIELD sum4 name="construct.a.sum4"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sum4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sum4
            #add-point:ON ACTION controlp INFIELD sum4 name="construct.c.sum4"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mmfeseq,mmfe001,mmfe003,mmfe004,mmfe005,mmfe006,mmfe007,mmfe008,mmfe009, 
          mmfe010,mmfe011,mmfe012,mmfe013,mmfe013_desc
           FROM s_detail1[1].mmfeseq,s_detail1[1].mmfe001,s_detail1[1].mmfe003,s_detail1[1].mmfe004, 
               s_detail1[1].mmfe005,s_detail1[1].mmfe006,s_detail1[1].mmfe007,s_detail1[1].mmfe008,s_detail1[1].mmfe009, 
               s_detail1[1].mmfe010,s_detail1[1].mmfe011,s_detail1[1].mmfe012,s_detail1[1].mmfe013,s_detail1[1].mmfe013_desc 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfeseq
            #add-point:BEFORE FIELD mmfeseq name="construct.b.page1.mmfeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfeseq
            
            #add-point:AFTER FIELD mmfeseq name="construct.a.page1.mmfeseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfeseq
            #add-point:ON ACTION controlp INFIELD mmfeseq name="construct.c.page1.mmfeseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmfe001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe001
            #add-point:ON ACTION controlp INFIELD mmfe001 name="construct.c.page1.mmfe001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmfe001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmfe001  #顯示到畫面上
            NEXT FIELD mmfe001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe001
            #add-point:BEFORE FIELD mmfe001 name="construct.b.page1.mmfe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe001
            
            #add-point:AFTER FIELD mmfe001 name="construct.a.page1.mmfe001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfe003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe003
            #add-point:ON ACTION controlp INFIELD mmfe003 name="construct.c.page1.mmfe003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2071'
            LET g_qryparam.where = " oocq019 = '40'"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmfe003  #顯示到畫面上
            NEXT FIELD mmfe003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe003
            #add-point:BEFORE FIELD mmfe003 name="construct.b.page1.mmfe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe003
            
            #add-point:AFTER FIELD mmfe003 name="construct.a.page1.mmfe003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfe004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe004
            #add-point:ON ACTION controlp INFIELD mmfe004 name="construct.c.page1.mmfe004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmfe004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmfe004  #顯示到畫面上
            NEXT FIELD mmfe004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe004
            #add-point:BEFORE FIELD mmfe004 name="construct.b.page1.mmfe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe004
            
            #add-point:AFTER FIELD mmfe004 name="construct.a.page1.mmfe004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfe005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe005
            #add-point:ON ACTION controlp INFIELD mmfe005 name="construct.c.page1.mmfe005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmfe005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmfe005  #顯示到畫面上
            NEXT FIELD mmfe005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe005
            #add-point:BEFORE FIELD mmfe005 name="construct.b.page1.mmfe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe005
            
            #add-point:AFTER FIELD mmfe005 name="construct.a.page1.mmfe005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe006
            #add-point:BEFORE FIELD mmfe006 name="construct.b.page1.mmfe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe006
            
            #add-point:AFTER FIELD mmfe006 name="construct.a.page1.mmfe006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe006
            #add-point:ON ACTION controlp INFIELD mmfe006 name="construct.c.page1.mmfe006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe007
            #add-point:BEFORE FIELD mmfe007 name="construct.b.page1.mmfe007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe007
            
            #add-point:AFTER FIELD mmfe007 name="construct.a.page1.mmfe007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfe007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe007
            #add-point:ON ACTION controlp INFIELD mmfe007 name="construct.c.page1.mmfe007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe008
            #add-point:BEFORE FIELD mmfe008 name="construct.b.page1.mmfe008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe008
            
            #add-point:AFTER FIELD mmfe008 name="construct.a.page1.mmfe008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfe008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe008
            #add-point:ON ACTION controlp INFIELD mmfe008 name="construct.c.page1.mmfe008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe009
            #add-point:BEFORE FIELD mmfe009 name="construct.b.page1.mmfe009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe009
            
            #add-point:AFTER FIELD mmfe009 name="construct.a.page1.mmfe009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfe009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe009
            #add-point:ON ACTION controlp INFIELD mmfe009 name="construct.c.page1.mmfe009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmfe010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe010
            #add-point:ON ACTION controlp INFIELD mmfe010 name="construct.c.page1.mmfe010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmfe010  #顯示到畫面上
            NEXT FIELD mmfe010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe010
            #add-point:BEFORE FIELD mmfe010 name="construct.b.page1.mmfe010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe010
            
            #add-point:AFTER FIELD mmfe010 name="construct.a.page1.mmfe010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe011
            #add-point:BEFORE FIELD mmfe011 name="construct.b.page1.mmfe011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe011
            
            #add-point:AFTER FIELD mmfe011 name="construct.a.page1.mmfe011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfe011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe011
            #add-point:ON ACTION controlp INFIELD mmfe011 name="construct.c.page1.mmfe011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe012
            #add-point:BEFORE FIELD mmfe012 name="construct.b.page1.mmfe012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe012
            
            #add-point:AFTER FIELD mmfe012 name="construct.a.page1.mmfe012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfe012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe012
            #add-point:ON ACTION controlp INFIELD mmfe012 name="construct.c.page1.mmfe012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmfe013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe013
            #add-point:ON ACTION controlp INFIELD mmfe013 name="construct.c.page1.mmfe013"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmfe013()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmfe013  #顯示到畫面上
            NEXT FIELD mmfe013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe013
            #add-point:BEFORE FIELD mmfe013 name="construct.b.page1.mmfe013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe013
            
            #add-point:AFTER FIELD mmfe013 name="construct.a.page1.mmfe013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe013_desc
            #add-point:BEFORE FIELD mmfe013_desc name="construct.b.page1.mmfe013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe013_desc
            
            #add-point:AFTER FIELD mmfe013_desc name="construct.a.page1.mmfe013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmfe013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe013_desc
            #add-point:ON ACTION controlp INFIELD mmfe013_desc name="construct.c.page1.mmfe013_desc"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON rtibseq,rtib003,rtib004,rtib006,rtib008,rtib009,rtib010,rtib012,rtib013, 
          rtib018,rtib015,rtib016,rtib019,rtib020,rtib021,rtib022,rtib025,rtib030
           FROM s_detail2[1].rtibseq,s_detail2[1].rtib003,s_detail2[1].rtib004,s_detail2[1].rtib006, 
               s_detail2[1].rtib008,s_detail2[1].rtib009,s_detail2[1].rtib010,s_detail2[1].rtib012,s_detail2[1].rtib013, 
               s_detail2[1].rtib018,s_detail2[1].rtib015,s_detail2[1].rtib016,s_detail2[1].rtib019,s_detail2[1].rtib020, 
               s_detail2[1].rtib021,s_detail2[1].rtib022,s_detail2[1].rtib025,s_detail2[1].rtib030
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtibseq
            #add-point:BEFORE FIELD rtibseq name="construct.b.page2.rtibseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtibseq
            
            #add-point:AFTER FIELD rtibseq name="construct.a.page2.rtibseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtibseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtibseq
            #add-point:ON ACTION controlp INFIELD rtibseq name="construct.c.page2.rtibseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtib003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib003
            #add-point:ON ACTION controlp INFIELD rtib003 name="construct.c.page2.rtib003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtib003  #顯示到畫面上
            NEXT FIELD rtib003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib003
            #add-point:BEFORE FIELD rtib003 name="construct.b.page2.rtib003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib003
            
            #add-point:AFTER FIELD rtib003 name="construct.a.page2.rtib003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib004
            #add-point:ON ACTION controlp INFIELD rtib004 name="construct.c.page2.rtib004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtib004  #顯示到畫面上

            NEXT FIELD rtib004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib004
            #add-point:BEFORE FIELD rtib004 name="construct.b.page2.rtib004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib004
            
            #add-point:AFTER FIELD rtib004 name="construct.a.page2.rtib004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib006
            #add-point:ON ACTION controlp INFIELD rtib006 name="construct.c.page2.rtib006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xrcd002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtib006  #顯示到畫面上
            NEXT FIELD rtib006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib006
            #add-point:BEFORE FIELD rtib006 name="construct.b.page2.rtib006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib006
            
            #add-point:AFTER FIELD rtib006 name="construct.a.page2.rtib006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib008
            #add-point:BEFORE FIELD rtib008 name="construct.b.page2.rtib008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib008
            
            #add-point:AFTER FIELD rtib008 name="construct.a.page2.rtib008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib008
            #add-point:ON ACTION controlp INFIELD rtib008 name="construct.c.page2.rtib008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib009
            #add-point:BEFORE FIELD rtib009 name="construct.b.page2.rtib009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib009
            
            #add-point:AFTER FIELD rtib009 name="construct.a.page2.rtib009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib009
            #add-point:ON ACTION controlp INFIELD rtib009 name="construct.c.page2.rtib009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib010
            #add-point:BEFORE FIELD rtib010 name="construct.b.page2.rtib010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib010
            
            #add-point:AFTER FIELD rtib010 name="construct.a.page2.rtib010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib010
            #add-point:ON ACTION controlp INFIELD rtib010 name="construct.c.page2.rtib010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib012
            #add-point:BEFORE FIELD rtib012 name="construct.b.page2.rtib012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib012
            
            #add-point:AFTER FIELD rtib012 name="construct.a.page2.rtib012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib012
            #add-point:ON ACTION controlp INFIELD rtib012 name="construct.c.page2.rtib012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtib013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib013
            #add-point:ON ACTION controlp INFIELD rtib013 name="construct.c.page2.rtib013"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtib013  #顯示到畫面上

            NEXT FIELD rtib013                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib013
            #add-point:BEFORE FIELD rtib013 name="construct.b.page2.rtib013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib013
            
            #add-point:AFTER FIELD rtib013 name="construct.a.page2.rtib013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib018
            #add-point:ON ACTION controlp INFIELD rtib018 name="construct.c.page2.rtib018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtib018  #顯示到畫面上
            NEXT FIELD rtib018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib018
            #add-point:BEFORE FIELD rtib018 name="construct.b.page2.rtib018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib018
            
            #add-point:AFTER FIELD rtib018 name="construct.a.page2.rtib018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib015
            #add-point:ON ACTION controlp INFIELD rtib015 name="construct.c.page2.rtib015"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtib015  #顯示到畫面上

            NEXT FIELD rtib015                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib015
            #add-point:BEFORE FIELD rtib015 name="construct.b.page2.rtib015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib015
            
            #add-point:AFTER FIELD rtib015 name="construct.a.page2.rtib015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib016
            #add-point:BEFORE FIELD rtib016 name="construct.b.page2.rtib016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib016
            
            #add-point:AFTER FIELD rtib016 name="construct.a.page2.rtib016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib016
            #add-point:ON ACTION controlp INFIELD rtib016 name="construct.c.page2.rtib016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib019
            #add-point:BEFORE FIELD rtib019 name="construct.b.page2.rtib019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib019
            
            #add-point:AFTER FIELD rtib019 name="construct.a.page2.rtib019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib019
            #add-point:ON ACTION controlp INFIELD rtib019 name="construct.c.page2.rtib019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib020
            #add-point:BEFORE FIELD rtib020 name="construct.b.page2.rtib020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib020
            
            #add-point:AFTER FIELD rtib020 name="construct.a.page2.rtib020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib020
            #add-point:ON ACTION controlp INFIELD rtib020 name="construct.c.page2.rtib020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib021
            #add-point:BEFORE FIELD rtib021 name="construct.b.page2.rtib021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib021
            
            #add-point:AFTER FIELD rtib021 name="construct.a.page2.rtib021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib021
            #add-point:ON ACTION controlp INFIELD rtib021 name="construct.c.page2.rtib021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib022
            #add-point:BEFORE FIELD rtib022 name="construct.b.page2.rtib022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib022
            
            #add-point:AFTER FIELD rtib022 name="construct.a.page2.rtib022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib022
            #add-point:ON ACTION controlp INFIELD rtib022 name="construct.c.page2.rtib022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtib025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib025
            #add-point:ON ACTION controlp INFIELD rtib025 name="construct.c.page2.rtib025"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtib025  #顯示到畫面上

            NEXT FIELD rtib025                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib025
            #add-point:BEFORE FIELD rtib025 name="construct.b.page2.rtib025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib025
            
            #add-point:AFTER FIELD rtib025 name="construct.a.page2.rtib025"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib030
            #add-point:BEFORE FIELD rtib030 name="construct.b.page2.rtib030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib030
            
            #add-point:AFTER FIELD rtib030 name="construct.a.page2.rtib030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtib030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib030
            #add-point:ON ACTION controlp INFIELD rtib030 name="construct.c.page2.rtib030"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON xrcd007,xrcdld,xrcdseq,xrcdseq2,xrcd002,xrcd003,xrcd006,xrcd004
           FROM s_detail3[1].xrcd007,s_detail3[1].xrcdld,s_detail3[1].xrcdseq,s_detail3[1].xrcdseq2, 
               s_detail3[1].xrcd002,s_detail3[1].xrcd003,s_detail3[1].xrcd006,s_detail3[1].xrcd004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd007
            #add-point:BEFORE FIELD xrcd007 name="construct.b.page3.xrcd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd007
            
            #add-point:AFTER FIELD xrcd007 name="construct.a.page3.xrcd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd007
            #add-point:ON ACTION controlp INFIELD xrcd007 name="construct.c.page3.xrcd007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdld
            #add-point:BEFORE FIELD xrcdld name="construct.b.page3.xrcdld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdld
            
            #add-point:AFTER FIELD xrcdld name="construct.a.page3.xrcdld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcdld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdld
            #add-point:ON ACTION controlp INFIELD xrcdld name="construct.c.page3.xrcdld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq
            #add-point:BEFORE FIELD xrcdseq name="construct.b.page3.xrcdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq
            
            #add-point:AFTER FIELD xrcdseq name="construct.a.page3.xrcdseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq
            #add-point:ON ACTION controlp INFIELD xrcdseq name="construct.c.page3.xrcdseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq2
            #add-point:BEFORE FIELD xrcdseq2 name="construct.b.page3.xrcdseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq2
            
            #add-point:AFTER FIELD xrcdseq2 name="construct.a.page3.xrcdseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcdseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq2
            #add-point:ON ACTION controlp INFIELD xrcdseq2 name="construct.c.page3.xrcdseq2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xrcd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd002
            #add-point:ON ACTION controlp INFIELD xrcd002 name="construct.c.page3.xrcd002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xrcd002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcd002  #顯示到畫面上
            NEXT FIELD xrcd002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd002
            #add-point:BEFORE FIELD xrcd002 name="construct.b.page3.xrcd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd002
            
            #add-point:AFTER FIELD xrcd002 name="construct.a.page3.xrcd002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd003
            #add-point:BEFORE FIELD xrcd003 name="construct.b.page3.xrcd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd003
            
            #add-point:AFTER FIELD xrcd003 name="construct.a.page3.xrcd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd003
            #add-point:ON ACTION controlp INFIELD xrcd003 name="construct.c.page3.xrcd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd006
            #add-point:BEFORE FIELD xrcd006 name="construct.b.page3.xrcd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd006
            
            #add-point:AFTER FIELD xrcd006 name="construct.a.page3.xrcd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd006
            #add-point:ON ACTION controlp INFIELD xrcd006 name="construct.c.page3.xrcd006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd004
            #add-point:BEFORE FIELD xrcd004 name="construct.b.page3.xrcd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd004
            
            #add-point:AFTER FIELD xrcd004 name="construct.a.page3.xrcd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd004
            #add-point:ON ACTION controlp INFIELD xrcd004 name="construct.c.page3.xrcd004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON rtieseq,rtieseq1,rtie001,rtie002,rtie006
           FROM s_detail4[1].rtieseq,s_detail4[1].rtieseq1,s_detail4[1].rtie001,s_detail4[1].rtie002, 
               s_detail4[1].rtie006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtieseq
            #add-point:BEFORE FIELD rtieseq name="construct.b.page4.rtieseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtieseq
            
            #add-point:AFTER FIELD rtieseq name="construct.a.page4.rtieseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtieseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtieseq
            #add-point:ON ACTION controlp INFIELD rtieseq name="construct.c.page4.rtieseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtieseq1
            #add-point:BEFORE FIELD rtieseq1 name="construct.b.page4.rtieseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtieseq1
            
            #add-point:AFTER FIELD rtieseq1 name="construct.a.page4.rtieseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtieseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtieseq1
            #add-point:ON ACTION controlp INFIELD rtieseq1 name="construct.c.page4.rtieseq1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtie001
            #add-point:BEFORE FIELD rtie001 name="construct.b.page4.rtie001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtie001
            
            #add-point:AFTER FIELD rtie001 name="construct.a.page4.rtie001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtie001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtie001
            #add-point:ON ACTION controlp INFIELD rtie001 name="construct.c.page4.rtie001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.rtie002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtie002
            #add-point:ON ACTION controlp INFIELD rtie002 name="construct.c.page4.rtie002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtie002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtie002  #顯示到畫面上
            NEXT FIELD rtie002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtie002
            #add-point:BEFORE FIELD rtie002 name="construct.b.page4.rtie002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtie002
            
            #add-point:AFTER FIELD rtie002 name="construct.a.page4.rtie002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtie006
            #add-point:BEFORE FIELD rtie006 name="construct.b.page4.rtie006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtie006
            
            #add-point:AFTER FIELD rtie006 name="construct.a.page4.rtie006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtie006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtie006
            #add-point:ON ACTION controlp INFIELD rtie006 name="construct.c.page4.rtie006"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
            INITIALIZE g_wc2_table4 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "rtia_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmfe_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtib_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "xrcd_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "rtie_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
 
               END CASE
            END FOR
         END IF
    
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
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   LET g_wc = g_wc," AND rtia000 = '",g_prog_name,"' "
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION ammt450_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
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
      CONSTRUCT g_wc_filter ON rtiasite,rtiadocdt,rtia035,rtiadocno,rtia001,rtia042,rtia043
                          FROM s_browse[1].b_rtiasite,s_browse[1].b_rtiadocdt,s_browse[1].b_rtia035, 
                              s_browse[1].b_rtiadocno,s_browse[1].b_rtia001,s_browse[1].b_rtia042,s_browse[1].b_rtia043 
 
 
         BEFORE CONSTRUCT
               DISPLAY ammt450_filter_parser('rtiasite') TO s_browse[1].b_rtiasite
            DISPLAY ammt450_filter_parser('rtiadocdt') TO s_browse[1].b_rtiadocdt
            DISPLAY ammt450_filter_parser('rtia035') TO s_browse[1].b_rtia035
            DISPLAY ammt450_filter_parser('rtiadocno') TO s_browse[1].b_rtiadocno
            DISPLAY ammt450_filter_parser('rtia001') TO s_browse[1].b_rtia001
            DISPLAY ammt450_filter_parser('rtia042') TO s_browse[1].b_rtia042
            DISPLAY ammt450_filter_parser('rtia043') TO s_browse[1].b_rtia043
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
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
 
      CALL ammt450_filter_show('rtiasite')
   CALL ammt450_filter_show('rtiadocdt')
   CALL ammt450_filter_show('rtia035')
   CALL ammt450_filter_show('rtiadocno')
   CALL ammt450_filter_show('rtia001')
   CALL ammt450_filter_show('rtia042')
   CALL ammt450_filter_show('rtia043')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION ammt450_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="ammt450.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION ammt450_filter_show(ps_field)
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
   LET ls_condition = ammt450_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION ammt450_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
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
   CALL g_mmfe_d.clear()
   CALL g_mmfe2_d.clear()
   CALL g_mmfe3_d.clear()
   CALL g_mmfe4_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL ammt450_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL ammt450_browser_fill("")
      CALL ammt450_fetch("")
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
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL ammt450_filter_show('rtiasite')
   CALL ammt450_filter_show('rtiadocdt')
   CALL ammt450_filter_show('rtia035')
   CALL ammt450_filter_show('rtiadocno')
   CALL ammt450_filter_show('rtia001')
   CALL ammt450_filter_show('rtia042')
   CALL ammt450_filter_show('rtia043')
   CALL ammt450_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL ammt450_fetch("F") 
      #顯示單身筆數
      CALL ammt450_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION ammt450_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
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
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
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
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_rtia_m.rtiadocno = g_browser[g_current_idx].b_rtiadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE ammt450_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtia035,g_rtia_m.rtiadocno,g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043, 
       g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia041,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia066, 
       g_rtia_m.rtia046,g_rtia_m.rtia047,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000, 
       g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036, 
       g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtiaownid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtid, 
       g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid, 
       g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia001_desc, 
       g_rtia_m.rtia042_desc,g_rtia_m.rtia044_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
   #遮罩相關處理
   LET g_rtia_m_mask_o.* =  g_rtia_m.*
   CALL ammt450_rtia_t_mask()
   LET g_rtia_m_mask_n.* =  g_rtia_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt450_set_act_visible()   
   CALL ammt450_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #IF g_rtia_m.rtiastus = 'N' THEN
   #151111-00021#1 20151116 mark by beckxie---S
   #IF g_rtia_m.rtiastus MATCHES "[NDR]" THEN   
   #   CALL cl_set_act_visible("modify,modify_detail,delete,open_ammt450_01,ammt450_s_pay,ammt450_s_note,ammt450_s_pay_09,ammt450_aooi360_01",TRUE)
   #ELSE
   #   CALL cl_set_act_visible("modify,modify_detail,delete,open_ammt450_01,ammt450_s_pay,ammt450_s_note,ammt450_s_pay_09,ammt450_aooi360_01",FALSE)
   #END IF
   #151111-00021#1 20151116 mark by beckxie---E
   #151111-00021#1 20151116 add by beckxie---S
   IF g_rtia_m.rtiastus MATCHES "[NDR]" THEN   
      CALL cl_set_act_visible("modify,modify_detail,delete,open_ammt450_01,ammt450_s_pay,ammt450_s_note,ammt450_aooi360_01",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,modify_detail,delete,open_ammt450_01,ammt450_s_pay,ammt450_s_note,ammt450_aooi360_01",FALSE)
   END IF
   IF g_rtia_m.rtiastus MATCHES "[NDRS]" THEN   
      CALL cl_set_act_visible("ammt450_s_pay_09",TRUE)
   ELSE
      CALL cl_set_act_visible("ammt450_s_pay_09",FALSE)
   END IF
   #151111-00021#1 20151116 add by beckxie---E
   
   #160819-00054#14 161003 by lori add---(S)
   CALL ammt450_set_visible() 
   CALL ammt450_set_no_visible()   
   CALL ammt450_set_no_required()   
   CALL ammt450_set_required()
   CALL ammt450_rtia066_init()
   #160819-00054#14 161003 by lori add----(E)   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtia_m_t.* = g_rtia_m.*
   LET g_rtia_m_o.* = g_rtia_m.*
   
   LET g_data_owner = g_rtia_m.rtiaownid      
   LET g_data_dept  = g_rtia_m.rtiaowndp
   
   #重新顯示   
   CALL ammt450_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammt450_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_doctype       LIKE rtai_t.rtai004
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_sql           STRING   #151111-00021#1 20160104 add by beckxie
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mmfe_d.clear()   
   CALL g_mmfe2_d.clear()  
   CALL g_mmfe3_d.clear()  
   CALL g_mmfe4_d.clear()  
 
 
   INITIALIZE g_rtia_m.* TO NULL             #DEFAULT 設定
   
   LET g_rtiadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtia_m.rtiaownid = g_user
      LET g_rtia_m.rtiaowndp = g_dept
      LET g_rtia_m.rtiacrtid = g_user
      LET g_rtia_m.rtiacrtdp = g_dept 
      LET g_rtia_m.rtiacrtdt = cl_get_current()
      LET g_rtia_m.rtiamodid = g_user
      LET g_rtia_m.rtiamoddt = cl_get_current()
      LET g_rtia_m.rtiastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_rtia_m.rtiastus = "N"
      LET g_rtia_m.rtia032 = "1"
      LET g_rtia_m.rtia039 = "0"
      LET g_rtia_m.isaf009 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL s_aooi500_default(g_prog_name,'rtiasite',g_rtia_m.rtiasite)
         RETURNING l_insert,g_rtia_m.rtiasite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      CALL s_aooi500_default(g_prog_name,'rtiaunit',g_rtia_m.rtiasite)
         RETURNING l_insert,g_rtia_m.rtiaunit
      IF l_insert = FALSE THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_rtia_m.rtiasite) RETURNING g_rtia_m.rtiasite_desc
      DISPLAY BY NAME g_rtia_m.rtiasite_desc
      LET g_rtia_m.rtiadocdt = g_today
      LET g_rtia_m.rtia035 = cl_get_time()
      LET g_rtia_m.rtia000 = g_prog_name
      LET g_rtia_m.rtia032 = '1'
      LET g_rtia_m.rtia046 = 0
      
      #預設單據的單別
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_rtia_m.rtiasite,g_prog_name,'1') 
         RETURNING l_success,l_doctype
      LET g_rtia_m.rtiadocno = l_doctype
      
      LET g_ooef004 = ''
      LET g_ooef015 = ''
      LET g_ooef016 = ''
      LET g_ooef019 = ''
      LET g_ooef108 = ''
      SELECT ooef004,ooef015,ooef016,ooef019,ooef108
        INTO g_ooef004,g_ooef015,g_ooef016,g_ooef019,g_ooef108
        FROM ooef_t
       WHERE ooef001 = g_rtia_m.rtiasite
         AND ooefent = g_enterprise
      IF cl_null(g_ooef004) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00007'
         LET g_errparam.extend = g_rtia_m.rtiasite
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
      #151111-00021#1 20151116 add by beckxie---S
      #151111-00021#1 20160104 mark by beckxie---S
      #SELECT pcab001 INTO g_rtia_m.rtia037
      #FROM pcab_t
      #WHERE pcabent=g_enterprise
      #  AND pcab002=g_user
      #151111-00021#1 20160104 mark by beckxie---E
      #151111-00021#1 20160104 add by beckxie---S
      LET l_sql = "SELECT pcab001 ",
                  "  FROM pcab_t ",
                  " WHERE pcabent = ",g_enterprise," ",
                  "   AND pcab002 = '",g_user,"' ",
                  "   AND EXISTS ",
                  "       (SELECT 1 ",
                  "          FROM pcac_t ",
                  "         WHERE pcacent  = pcabent ", 
                  "           AND pcac001  = pcab001 ",
                  "           AND pcac002  = '",g_rtia_m.rtiasite,"' ", 
                  "           AND pcacstus = 'Y' ) "
      PREPARE get_rtia037_pre FROM l_sql
      DECLARE get_rtia037_cs SCROLL CURSOR FOR get_rtia037_pre
      OPEN get_rtia037_cs
      FETCH FIRST get_rtia037_cs INTO g_rtia_m.rtia037 
      CLOSE get_rtia037_cs
      #151111-00021#1 20160104 add by beckxie---E
      CALL ammt450_rtia037_ref()
      #151111-00021#1 20151116 add by beckxie---E
      LET g_site_flag = FALSE
      LET g_rtia_m_t.* = g_rtia_m.*
      LET g_rtia_m_o.* = g_rtia_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rtia_m_t.* = g_rtia_m.*
      LET g_rtia_m_o.* = g_rtia_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtia_m.rtiastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
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
 
 
 
    
      CALL ammt450_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_rtia_m.* TO NULL
         INITIALIZE g_mmfe_d TO NULL
         INITIALIZE g_mmfe2_d TO NULL
         INITIALIZE g_mmfe3_d TO NULL
         INITIALIZE g_mmfe4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL ammt450_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mmfe_d.clear()
      #CALL g_mmfe2_d.clear()
      #CALL g_mmfe3_d.clear()
      #CALL g_mmfe4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt450_set_act_visible()   
   CALL ammt450_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtiaent = " ||g_enterprise|| " AND",
                      " rtiadocno = '", g_rtia_m.rtiadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt450_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE ammt450_cl
   
   CALL ammt450_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE ammt450_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtia035,g_rtia_m.rtiadocno,g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043, 
       g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia041,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia066, 
       g_rtia_m.rtia046,g_rtia_m.rtia047,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000, 
       g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036, 
       g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtiaownid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtid, 
       g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid, 
       g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia001_desc, 
       g_rtia_m.rtia042_desc,g_rtia_m.rtia044_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
   
   #遮罩相關處理
   LET g_rtia_m_mask_o.* =  g_rtia_m.*
   CALL ammt450_rtia_t_mask()
   LET g_rtia_m_mask_n.* =  g_rtia_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc,g_rtia_m.rtiadocdt,g_rtia_m.rtia035,g_rtia_m.rtiadocno, 
       g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia001_desc,g_rtia_m.rtia042,g_rtia_m.rtia042_desc, 
       g_rtia_m.rtia043,g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia044_desc,g_rtia_m.mmby006,g_rtia_m.rtia041, 
       g_rtia_m.rtiastus,g_rtia_m.mmby009,g_rtia_m.mmby010,g_rtia_m.mmby011,g_rtia_m.mmby012,g_rtia_m.mmby013, 
       g_rtia_m.rtia007,g_rtia_m.rtia066,g_rtia_m.rtia046,g_rtia_m.rtia0461,g_rtia_m.rtia047,g_rtia_m.rtia0471, 
       g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000,g_rtia_m.rtia026,g_rtia_m.rtia027, 
       g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036,g_rtia_m.rtia036_desc,g_rtia_m.rtia037, 
       g_rtia_m.rtia037_desc,g_rtia_m.rtia038,g_rtia_m.rtia038_desc,g_rtia_m.rtia039,g_rtia_m.isaf009, 
       g_rtia_m.isaf013,g_rtia_m.isaf044,g_rtia_m.isaf202,g_rtia_m.isaf203,g_rtia_m.isaf204,g_rtia_m.isaf201, 
       g_rtia_m.isaf207,g_rtia_m.rtiaownid,g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp,g_rtia_m.rtiaowndp_desc, 
       g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdp_desc,g_rtia_m.rtiacrtdt, 
       g_rtia_m.rtiamodid,g_rtia_m.rtiamodid_desc,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfid_desc, 
       g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstid_desc,g_rtia_m.rtiapstdt,g_rtia_m.sum1, 
       g_rtia_m.sum2,g_rtia_m.sum3,g_rtia_m.sum4
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rtia_m.rtiaownid      
   LET g_data_dept  = g_rtia_m.rtiaowndp
   
   #功能已完成,通報訊息中心
   CALL ammt450_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammt450_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtia_m_t.* = g_rtia_m.*
   LET g_rtia_m_o.* = g_rtia_m.*
   
   IF g_rtia_m.rtiadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
   CALL s_transaction_begin()
   
   OPEN ammt450_cl USING g_enterprise,g_rtia_m.rtiadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt450_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt450_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt450_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtia035,g_rtia_m.rtiadocno,g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043, 
       g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia041,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia066, 
       g_rtia_m.rtia046,g_rtia_m.rtia047,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000, 
       g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036, 
       g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtiaownid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtid, 
       g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid, 
       g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia001_desc, 
       g_rtia_m.rtia042_desc,g_rtia_m.rtia044_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
   #檢查是否允許此動作
   IF NOT ammt450_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtia_m_mask_o.* =  g_rtia_m.*
   CALL ammt450_rtia_t_mask()
   LET g_rtia_m_mask_n.* =  g_rtia_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
 
 
   
   CALL ammt450_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
 
 
    
   WHILE TRUE
      LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rtia_m.rtiamodid = g_user 
LET g_rtia_m.rtiamoddt = cl_get_current()
LET g_rtia_m.rtiamodid_desc = cl_get_username(g_rtia_m.rtiamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_rtia_m.rtiastus MATCHES "[DR]" THEN 
         LET g_rtia_m.rtiastus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL ammt450_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rtia_t SET (rtiamodid,rtiamoddt) = (g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt)
          WHERE rtiaent = g_enterprise AND rtiadocno = g_rtiadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rtia_m.* = g_rtia_m_t.*
            CALL ammt450_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rtia_m.rtiadocno != g_rtia_m_t.rtiadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mmfe_t SET mmfedocno = g_rtia_m.rtiadocno
 
          WHERE mmfeent = g_enterprise AND mmfedocno = g_rtia_m_t.rtiadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmfe_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmfe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE rtib_t
            SET rtibdocno = g_rtia_m.rtiadocno
 
          WHERE rtibent = g_enterprise AND
                rtibdocno = g_rtiadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtib_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE xrcd_t
            SET xrcddocno = g_rtia_m.rtiadocno
 
          WHERE xrcdent = g_enterprise AND
                xrcddocno = g_rtiadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xrcd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
         
         #end add-point
         
         UPDATE rtie_t
            SET rtiedocno = g_rtia_m.rtiadocno
 
          WHERE rtieent = g_enterprise AND
                rtiedocno = g_rtiadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtie_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt450_set_act_visible()   
   CALL ammt450_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rtiaent = " ||g_enterprise|| " AND",
                      " rtiadocno = '", g_rtia_m.rtiadocno, "' "
 
   #填到對應位置
   CALL ammt450_browser_fill("")
 
   CLOSE ammt450_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt450_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="ammt450.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammt450_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
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
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_where               STRING
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
   DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc,g_rtia_m.rtiadocdt,g_rtia_m.rtia035,g_rtia_m.rtiadocno, 
       g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia001_desc,g_rtia_m.rtia042,g_rtia_m.rtia042_desc, 
       g_rtia_m.rtia043,g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia044_desc,g_rtia_m.mmby006,g_rtia_m.rtia041, 
       g_rtia_m.rtiastus,g_rtia_m.mmby009,g_rtia_m.mmby010,g_rtia_m.mmby011,g_rtia_m.mmby012,g_rtia_m.mmby013, 
       g_rtia_m.rtia007,g_rtia_m.rtia066,g_rtia_m.rtia046,g_rtia_m.rtia0461,g_rtia_m.rtia047,g_rtia_m.rtia0471, 
       g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000,g_rtia_m.rtia026,g_rtia_m.rtia027, 
       g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036,g_rtia_m.rtia036_desc,g_rtia_m.rtia037, 
       g_rtia_m.rtia037_desc,g_rtia_m.rtia038,g_rtia_m.rtia038_desc,g_rtia_m.rtia039,g_rtia_m.isaf009, 
       g_rtia_m.isaf013,g_rtia_m.isaf044,g_rtia_m.isaf202,g_rtia_m.isaf203,g_rtia_m.isaf204,g_rtia_m.isaf201, 
       g_rtia_m.isaf207,g_rtia_m.rtiaownid,g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp,g_rtia_m.rtiaowndp_desc, 
       g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdp_desc,g_rtia_m.rtiacrtdt, 
       g_rtia_m.rtiamodid,g_rtia_m.rtiamodid_desc,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfid_desc, 
       g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstid_desc,g_rtia_m.rtiapstdt,g_rtia_m.sum1, 
       g_rtia_m.sum2,g_rtia_m.sum3,g_rtia_m.sum4
   
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
   LET g_forupd_sql = "SELECT mmfeseq,mmfe001,mmfe003,mmfe004,mmfe005,mmfe006,mmfe007,mmfe008,mmfe009, 
       mmfe010,mmfe011,mmfe012,mmfe013 FROM mmfe_t WHERE mmfeent=? AND mmfedocno=? AND mmfeseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt450_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT rtibseq,rtib003,rtib004,rtib006,rtib008,rtib009,rtib010,rtib012,rtib013, 
       rtib018,rtib015,rtib016,rtib019,rtib020,rtib021,rtib022,rtib025,rtib030 FROM rtib_t WHERE rtibent=?  
       AND rtibdocno=? AND rtibseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt450_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xrcd007,xrcdld,xrcdseq,xrcdseq2,xrcd002,xrcd003,xrcd006,xrcd004,xrcd104  
       FROM xrcd_t WHERE xrcdent=? AND xrcddocno=? AND xrcdld=? AND xrcdseq=? AND xrcdseq2=? AND xrcd007=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt450_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT rtieseq,rtieseq1,rtie001,rtie002,rtie006 FROM rtie_t WHERE rtieent=? AND  
       rtiedocno=? AND rtieseq=? AND rtieseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt450_bcl4 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL ammt450_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL ammt450_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtia035,g_rtia_m.rtiadocno,g_rtia_m.rtia006, 
       g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043,g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia041, 
       g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia066,g_rtia_m.rtia046,g_rtia_m.rtia0471,g_rtia_m.rtia015, 
       g_rtia_m.rtiaunit,g_rtia_m.rtia000,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025, 
       g_rtia_m.rtia032,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.sum1, 
       g_rtia_m.sum4
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="ammt450.input.head" >}
      #單頭段
      INPUT BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtia035,g_rtia_m.rtiadocno,g_rtia_m.rtia006, 
          g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043,g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia041, 
          g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia066,g_rtia_m.rtia046,g_rtia_m.rtia0471,g_rtia_m.rtia015, 
          g_rtia_m.rtiaunit,g_rtia_m.rtia000,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025, 
          g_rtia_m.rtia032,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.sum1, 
          g_rtia_m.sum4 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN ammt450_cl USING g_enterprise,g_rtia_m.rtiadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt450_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt450_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL ammt450_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL cl_showmsg_init()
            #end add-point
            CALL ammt450_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiasite
            
            #add-point:AFTER FIELD rtiasite name="input.a.rtiasite"
            LET g_rtia_m.rtiasite_desc = ' '
            DISPLAY BY NAME g_rtia_m.rtiasite_desc
            IF NOT cl_null(g_rtia_m.rtiasite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtia_m.rtiasite != g_rtia_m_t.rtiasite OR g_rtia_m_t.rtiasite IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog_name,'rtiasite',g_rtia_m.rtiasite,g_rtia_m.rtiasite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_rtia_m.rtiasite = g_rtia_m_t.rtiasite
                     CALL s_desc_get_department_desc(g_rtia_m.rtiasite) RETURNING g_rtia_m.rtiasite_desc
                     DISPLAY BY NAME g_rtia_m.rtiasite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_rtia_m.rtiasite) RETURNING g_rtia_m.rtiasite_desc
            DISPLAY BY NAME g_rtia_m.rtiasite_desc
            CALL ammt450_set_entry(p_cmd)
            CALL ammt450_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiasite
            #add-point:BEFORE FIELD rtiasite name="input.b.rtiasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtiasite
            #add-point:ON CHANGE rtiasite name="input.g.rtiasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiadocdt
            #add-point:BEFORE FIELD rtiadocdt name="input.b.rtiadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiadocdt
            
            #add-point:AFTER FIELD rtiadocdt name="input.a.rtiadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtiadocdt
            #add-point:ON CHANGE rtiadocdt name="input.g.rtiadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia035
            #add-point:BEFORE FIELD rtia035 name="input.b.rtia035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia035
            
            #add-point:AFTER FIELD rtia035 name="input.a.rtia035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia035
            #add-point:ON CHANGE rtia035 name="input.g.rtia035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiadocno
            #add-point:BEFORE FIELD rtiadocno name="input.b.rtiadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiadocno
            
            #add-point:AFTER FIELD rtiadocno name="input.a.rtiadocno"
            #此段落由子樣板a05產生
            IF p_cmd = 'a' AND NOT cl_null(g_rtia_m.rtiadocno) THEN
               IF NOT s_aooi200_chk_slip(g_rtia_m.rtiasite,'',g_rtia_m.rtiadocno,g_prog_name) THEN
                  LET g_rtia_m.rtiadocno = g_rtia_m_t.rtiadocno
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtiadocno
            #add-point:ON CHANGE rtiadocno name="input.g.rtiadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia006
            #add-point:BEFORE FIELD rtia006 name="input.b.rtia006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia006
            
            #add-point:AFTER FIELD rtia006 name="input.a.rtia006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia006
            #add-point:ON CHANGE rtia006 name="input.g.rtia006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia001
            
            #add-point:AFTER FIELD rtia001 name="input.a.rtia001"
            IF cl_null(g_rtia_m.rtia001) THEN
               #IF g_prog_name = 'ammt450' THEN        #160705-00042#9 160713 by sakura mark
               IF g_prog_name MATCHES 'ammt450' THEN   #160705-00042#9 160713 by sakura add
                  LET g_rtia_m.rtia042 = ''
                  LET g_rtia_m.rtia042_desc = ''
               END IF
               LET g_rtia_m.rtia043 = ''
               DISPLAY BY NAME g_rtia_m.rtia042_desc
            END IF
            LET g_rtia_m.rtia001_desc = ' '
            LET g_rtia_m.rtia042_desc = ' '
            DISPLAY BY NAME g_rtia_m.rtia001_desc,g_rtia_m.rtia042_desc
            IF NOT cl_null(g_rtia_m.rtia001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtia_m.rtia001 != g_rtia_m_o.rtia001 OR g_rtia_m_o.rtia001 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtia_m.rtia001
                  IF NOT cl_chk_exist("v_mmaq001_2") THEN
                     LET g_rtia_m.rtia001 = g_rtia_m_o.rtia001
                     CALL ammt450_rtia001_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #檢查卡號是否已存在未確認贈品換單
                  CALL ammt450_chk_rtia001()
                  IF NOT cl_null(g_errno) THEN
                     #此會員卡號已存在未確認贈品換單資料檔中，不可輸入！
                     #請查詢[ammt450 累計積點兌換維護作業]後，重新輸入！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
                  CALL ammt450_carry_mmaq()
                  #當規則編號已有輸入
                  IF NOT cl_null(g_rtia_m.rtia044) THEN
                     ##150508-00025#1 150508 By pomelo mark(S)
                     #CALL ammt450_chk_rtia044(g_rtia_m.rtia044)
                     #IF NOT cl_null(g_errno) THEN
                     #   CASE g_errno
                     #      #此規則編號的活動類型不等於：%1！
                     #      WHEN 'amm-00311'
                     #         INITIALIZE g_errparam TO NULL
                     #         LET g_errparam.code = g_errno
                     #         LET g_errparam.extend = NULL
                     #         LET g_errparam.popup = TRUE
                     #         CALL cl_err()
                     #
                     #      OTHERWISE
                     #         INITIALIZE g_errparam TO NULL
                     #         LET g_errparam.code = g_errno
                     #         LET g_errparam.extend = ''
                     #         LET g_errparam.popup = TRUE
                     #         CALL cl_err()
                     #
                     #   END CASE
                     ##150508-00025#1 150508 By pomelo mark(E)
                     #150508-00025#1 150508 By pomelo add(S)
                     IF NOT ammt450_chk_rtia044('i',g_rtia_m.rtia044) THEN    #160729-00077#20 160818 by lori mod:第一個參數值
                     #150508-00025#1 150508 By pomelo add(E)
                        LET g_rtia_m.rtia001 = g_rtia_m_o.rtia001
                        LET g_rtia_m.rtia042 = g_rtia_m_o.rtia042
                        LET g_rtia_m.rtia043 = g_rtia_m_o.rtia043
                        CALL ammt450_rtia001_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL ammt450_get_client_usual_info()
               END IF
            END IF
            CALL ammt450_rtia001_ref()
            CALL s_desc_get_mman_desc(g_rtia_m.rtia042) RETURNING g_rtia_m.rtia042_desc
            DISPLAY BY NAME g_rtia_m.rtia042_desc
            LET g_rtia_m_o.rtia001 = g_rtia_m.rtia001
            LET g_rtia_m_o.rtia042 = g_rtia_m.rtia042
            LET g_rtia_m_o.rtia043 = g_rtia_m.rtia043
            CALL ammt450_set_entry(p_cmd)
            CALL ammt450_set_no_entry(p_cmd)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia001
            #add-point:BEFORE FIELD rtia001 name="input.b.rtia001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia001
            #add-point:ON CHANGE rtia001 name="input.g.rtia001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia042
            
            #add-point:AFTER FIELD rtia042 name="input.a.rtia042"
            LET g_rtia_m.rtia042_desc = ' '
            DISPLAY BY NAME g_rtia_m.rtia042_desc
            IF NOT cl_null(g_rtia_m.rtia042) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtia_m.rtia042 != g_rtia_m_o.rtia042 OR g_rtia_m_o.rtia042 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtia_m.rtia042
                  #160705-00042#9 160713 by sakura mark(S)
                  #CASE g_prog_name
                  #   WHEN 'ammt451'
                  #160705-00042#9 160713 by sakura mark(E)
                  #160705-00042#9 160713 by sakura add(S)
                  CASE 
                     WHEN g_prog_name MATCHES 'ammt451'
                  #160705-00042#9 160713 by sakura add(E)                     
                        IF NOT cl_chk_exist("v_mman001_1") THEN
                           LET g_rtia_m.rtia042 = g_rtia_m_o.rtia042
                           CALL s_desc_get_mman_desc(g_rtia_m.rtia042) RETURNING g_rtia_m.rtia042_desc
                           DISPLAY BY NAME g_rtia_m.rtia042_desc
                           NEXT FIELD CURRENT
                        END IF
                     #WHEN 'ammt452'                      #160705-00042#9 160713 by sakura mark
                     WHEN g_prog_name MATCHES 'ammt452'   #160705-00042#9 160713 by sakura add
                        IF NOT cl_chk_exist("v_mman001_2") THEN
                           LET g_rtia_m.rtia042 = g_rtia_m_o.rtia042
                           CALL s_desc_get_mman_desc(g_rtia_m.rtia042) RETURNING g_rtia_m.rtia042_desc
                           DISPLAY BY NAME g_rtia_m.rtia042_desc
                           NEXT FIELD CURRENT
                        END IF
                  END CASE
               END IF
            END IF
            CALL s_desc_get_mman_desc(g_rtia_m.rtia042) RETURNING g_rtia_m.rtia042_desc
            DISPLAY BY NAME g_rtia_m.rtia042_desc
            LET g_rtia_m_o.rtia042 = g_rtia_m.rtia042
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia042
            #add-point:BEFORE FIELD rtia042 name="input.b.rtia042"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia042
            #add-point:ON CHANGE rtia042 name="input.g.rtia042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia043
            #add-point:BEFORE FIELD rtia043 name="input.b.rtia043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia043
            
            #add-point:AFTER FIELD rtia043 name="input.a.rtia043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia043
            #add-point:ON CHANGE rtia043 name="input.g.rtia043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia044
            
            #add-point:AFTER FIELD rtia044 name="input.a.rtia044"
            
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM mmfe_t
             WHERE mmfeent = g_enterprise
               AND mmfedocno = g_rtia_m.rtiadocno
            
            LET g_rtia_m.rtia044_desc = ' '
            DISPLAY BY NAME g_rtia_m.rtia044_desc
            IF NOT cl_null(g_rtia_m.rtia044) THEN
               IF l_cnt = 0 OR cl_null(l_cnt) THEN
                  ##150508-00025#1 150508 By pomelo mark(S)
                  #CALL ammt450_chk_rtia044(g_rtia_m.rtia044)
                  #IF NOT cl_null(g_errno) THEN
                  #   CASE g_errno
                  #      #此規則編號的活動類型不等於：%1！
                  #      WHEN 'amm-00311'
                  #         INITIALIZE g_errparam TO NULL
                  #         LET g_errparam.code = g_errno
                  #         LET g_errparam.extend = NULL
                  #         LET g_errparam.popup = TRUE
                  #         CALL cl_err()
                  #
                  #      OTHERWISE
                  #         INITIALIZE g_errparam TO NULL
                  #         LET g_errparam.code = g_errno
                  #         LET g_errparam.extend = ''
                  #         LET g_errparam.popup = TRUE
                  #         CALL cl_err()
                  #
                  #   END CASE
                  ##150508-00025#1 150508 By pomelo mark(E)
                  #150508-00025#1 150508 By pomelo add(S)
                  IF NOT ammt450_chk_rtia044('i',g_rtia_m.rtia044) THEN   #160729-00077#20 160818 by lori mod:第一個參數值
                  #150508-00025#1 150508 By pomelo add(E)
                     LET g_rtia_m.rtia044 = g_rtia_m_o.rtia044
                     LET g_rtia_m.rtia045 = g_rtia_m_o.rtia045
                     CALL ammt450_rtia044_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL ammt450_carry_mmby()
                  CALL ammt450_exchange_info()
               END IF
            END IF
            CALL ammt450_rtia044_ref()
            LET g_rtia_m_o.rtia044 = g_rtia_m.rtia044
            LET g_rtia_m_o.rtia045 = g_rtia_m.rtia045
            CALL ammt450_set_entry(p_cmd)
            CALL ammt450_set_no_entry(p_cmd)
            #160819-00054#14 161003 by lori add---(S)
            CALL ammt450_set_visible()   
            CALL ammt450_set_no_visible()
            CALL ammt450_set_no_required()                
            CALL ammt450_set_required()  
            CALL ammt450_rtia066_init()
            #160819-00054#14 161003 by lori add---(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia044
            #add-point:BEFORE FIELD rtia044 name="input.b.rtia044"
            CALL ammt450_control_rtia044()
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               IF g_errno = 'amm-00272' THEN
                  NEXT FIELD rtia001
               ELSE
                  NEXT FIELD rtia042
               END IF
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia044
            #add-point:ON CHANGE rtia044 name="input.g.rtia044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia045
            #add-point:BEFORE FIELD rtia045 name="input.b.rtia045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia045
            
            #add-point:AFTER FIELD rtia045 name="input.a.rtia045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia045
            #add-point:ON CHANGE rtia045 name="input.g.rtia045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia041
            #add-point:BEFORE FIELD rtia041 name="input.b.rtia041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia041
            
            #add-point:AFTER FIELD rtia041 name="input.a.rtia041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia041
            #add-point:ON CHANGE rtia041 name="input.g.rtia041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiastus
            #add-point:BEFORE FIELD rtiastus name="input.b.rtiastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiastus
            
            #add-point:AFTER FIELD rtiastus name="input.a.rtiastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtiastus
            #add-point:ON CHANGE rtiastus name="input.g.rtiastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia007
            #add-point:BEFORE FIELD rtia007 name="input.b.rtia007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia007
            
            #add-point:AFTER FIELD rtia007 name="input.a.rtia007"
            #160819-00054#14 161003 by lori add---(S)
            IF NOT cl_null(g_rtia_m.rtia007) THEN
               IF g_rtia_m.rtia007 != g_rtia_m_o.rtia007 OR cl_null(g_rtia_m_o.rtia007)THEN
                  CALL ammt450_rtia066_def()
                  
                  IF NOT ammt450_rtia007_and_rtia066_chk() THEN
                     LET g_rtia_m.rtia007 = g_rtia_m_o.rtia007
                     LET g_rtia_m.rtia066 = g_rtia_m_o.rtia066
                     NEXT FIELD CURRENT
                  END IF
                  
                  #POS銷售單據以上傳至系統中時,檢查若無符合換贈條件者,不可進行換贈
                  IF ammt450_rtia007_chk() THEN
                     LET g_rtia_m.rtia046 = 0
                     
                     CALL ammt450_get_rtia046(g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.mmby009)
                        RETURNING g_rtia_m.rtia046 
                        
                     DISPLAY BY NAME g_rtia_m.rtia046    
                     
                     IF g_rtia_m.rtia046 = 0 THEN
                        LET g_rtia_m.rtia007 = g_rtia_m_o.rtia007
                        LET g_rtia_m.rtia066 = g_rtia_m_o.rtia066
                        LET g_rtia_m.rtia046 = g_rtia_m_o.rtia046
                        
                        DISPLAY BY NAME g_rtia_m.rtia007,g_rtia_m.rtia066,g_rtia_m.rtia046  
                        
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_rtia_m.rtia007
                        LET g_errparam.code = 'art-00780'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()     
                        
                        NEXT FIELD CURRENT
                     END IF   
                  END IF
                  
                  CALL ammt450_rtia066_init()                    
               END IF
            END IF
            
            LET g_rtia_m_o.rtia007 = g_rtia_m.rtia007
            LET g_rtia_m_o.rtia066 = g_rtia_m.rtia066
            LET g_rtia_m_o.rtia046 = g_rtia_m.rtia046
            #160819-00054#14 161003 by lori add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia007
            #add-point:ON CHANGE rtia007 name="input.g.rtia007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia066
            #add-point:BEFORE FIELD rtia066 name="input.b.rtia066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia066
            
            #add-point:AFTER FIELD rtia066 name="input.a.rtia066"
            #160819-00054#14 161003 by lori add---(S)
            IF NOT cl_null(g_rtia_m.rtia066) THEN
               IF g_rtia_m.rtia066 != g_rtia_m_o.rtia066 OR cl_null(g_rtia_m_o.rtia066) THEN
                  IF NOT ammt450_rtia007_and_rtia066_chk() THEN
                     LET g_rtia_m.rtia066 = g_rtia_m_o.rtia066
                     
                     DISPLAY BY NAME g_rtia_m.rtia066
                     
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL ammt450_get_rtia046(g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.mmby009)
                     RETURNING g_rtia_m.rtia046   
                     
                  DISPLAY BY NAME g_rtia_m.rtia046                         
               END IF
            END IF
            
            LET g_rtia_m_o.rtia066 = g_rtia_m.rtia066
            LET g_rtia_m_o.rtia046 = g_rtia_m.rtia046
            #160819-00054#14 161003 by lori add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia066
            #add-point:ON CHANGE rtia066 name="input.g.rtia066"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia046
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtia_m.rtia046,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtia046
            END IF 
 
 
 
            #add-point:AFTER FIELD rtia046 name="input.a.rtia046"
            IF NOT cl_null(g_rtia_m.rtia046) THEN 
            END IF 

            LET g_rtia_m_o.rtia046 = g_rtia_m.rtia046   #160819-00054#14 161003 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia046
            #add-point:BEFORE FIELD rtia046 name="input.b.rtia046"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia046
            #add-point:ON CHANGE rtia046 name="input.g.rtia046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia047
            #add-point:BEFORE FIELD rtia047 name="input.b.rtia047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia047
            
            #add-point:AFTER FIELD rtia047 name="input.a.rtia047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia047
            #add-point:ON CHANGE rtia047 name="input.g.rtia047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia0471
            #add-point:BEFORE FIELD rtia0471 name="input.b.rtia0471"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia0471
            
            #add-point:AFTER FIELD rtia0471 name="input.a.rtia0471"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia0471
            #add-point:ON CHANGE rtia0471 name="input.g.rtia0471"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia015
            #add-point:BEFORE FIELD rtia015 name="input.b.rtia015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia015
            
            #add-point:AFTER FIELD rtia015 name="input.a.rtia015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia015
            #add-point:ON CHANGE rtia015 name="input.g.rtia015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiaunit
            #add-point:BEFORE FIELD rtiaunit name="input.b.rtiaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiaunit
            
            #add-point:AFTER FIELD rtiaunit name="input.a.rtiaunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtiaunit
            #add-point:ON CHANGE rtiaunit name="input.g.rtiaunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia000
            #add-point:BEFORE FIELD rtia000 name="input.b.rtia000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia000
            
            #add-point:AFTER FIELD rtia000 name="input.a.rtia000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia000
            #add-point:ON CHANGE rtia000 name="input.g.rtia000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia026
            #add-point:BEFORE FIELD rtia026 name="input.b.rtia026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia026
            
            #add-point:AFTER FIELD rtia026 name="input.a.rtia026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia026
            #add-point:ON CHANGE rtia026 name="input.g.rtia026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia027
            #add-point:BEFORE FIELD rtia027 name="input.b.rtia027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia027
            
            #add-point:AFTER FIELD rtia027 name="input.a.rtia027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia027
            #add-point:ON CHANGE rtia027 name="input.g.rtia027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia002
            #add-point:BEFORE FIELD rtia002 name="input.b.rtia002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia002
            
            #add-point:AFTER FIELD rtia002 name="input.a.rtia002"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia002
            #add-point:ON CHANGE rtia002 name="input.g.rtia002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia025
            #add-point:BEFORE FIELD rtia025 name="input.b.rtia025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia025
            
            #add-point:AFTER FIELD rtia025 name="input.a.rtia025"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia025
            #add-point:ON CHANGE rtia025 name="input.g.rtia025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia032
            #add-point:BEFORE FIELD rtia032 name="input.b.rtia032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia032
            
            #add-point:AFTER FIELD rtia032 name="input.a.rtia032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia032
            #add-point:ON CHANGE rtia032 name="input.g.rtia032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia036
            
            #add-point:AFTER FIELD rtia036 name="input.a.rtia036"
            #151111-00021#1 20151112 add by beckxie---S
            IF NOT cl_null(g_rtia_m.rtia036) THEN
              IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_rtia_m.rtia036 != g_rtia_m_t.rtia036 OR cl_null(g_rtia_m_t.rtia036)) THEN           
                 INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtia_m.rtiasite
                  LET g_chkparam.arg2 = g_rtia_m.rtia036
                  #160318-00025#48  2016/04/29  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "apc-00005:sub-01302|apci201|",cl_get_progname("apci201",g_lang,"2"),"|:EXEPROGapci201"
                  #160318-00025#48  2016/04/29  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pcaa001") THEN
                     LET g_rtia_m.rtia036 = g_rtia_m_t.rtia036
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL ammt450_rtia036_ref()   
            #151111-00021#1 20151112 add by beckxie---E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia036
            #add-point:BEFORE FIELD rtia036 name="input.b.rtia036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia036
            #add-point:ON CHANGE rtia036 name="input.g.rtia036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia037
            
            #add-point:AFTER FIELD rtia037 name="input.a.rtia037"
            #151111-00021#1 20151112 add by beckxie---S
            IF NOT cl_null(g_rtia_m.rtia037) THEN
              IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_rtia_m.rtia037 != g_rtia_m_t.rtia037 OR cl_null(g_rtia_m_t.rtia037)) THEN           
                 INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtia_m.rtia037
                  LET g_chkparam.arg2 = g_rtia_m.rtiasite
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pcab001_1") THEN
                     LET g_rtia_m.rtia037 = g_rtia_m_t.rtia037
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL ammt450_rtia037_ref()
            #151111-00021#1 20151112 add by beckxie---E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia037
            #add-point:BEFORE FIELD rtia037 name="input.b.rtia037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia037
            #add-point:ON CHANGE rtia037 name="input.g.rtia037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia038
            
            #add-point:AFTER FIELD rtia038 name="input.a.rtia038"
            #151111-00021#1 20151112 add by beckxie---S
            IF NOT cl_null(g_rtia_m.rtia038) THEN
              IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_rtia_m.rtia038 != g_rtia_m_t.rtia038 OR cl_null(g_rtia_m_t.rtia038)) THEN
                 INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtia_m.rtiasite
                  LET g_chkparam.arg2 = g_rtia_m.rtia038
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_oogd001") THEN
                     LET g_rtia_m.rtia038 = g_rtia_m_t.rtia038
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL ammt450_rtia038_ref()
            #151111-00021#1 20151112 add by beckxie---E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia038
            #add-point:BEFORE FIELD rtia038 name="input.b.rtia038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia038
            #add-point:ON CHANGE rtia038 name="input.g.rtia038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia039
            #add-point:BEFORE FIELD rtia039 name="input.b.rtia039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia039
            
            #add-point:AFTER FIELD rtia039 name="input.a.rtia039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia039
            #add-point:ON CHANGE rtia039 name="input.g.rtia039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sum1
            #add-point:BEFORE FIELD sum1 name="input.b.sum1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sum1
            
            #add-point:AFTER FIELD sum1 name="input.a.sum1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sum1
            #add-point:ON CHANGE sum1 name="input.g.sum1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sum4
            #add-point:BEFORE FIELD sum4 name="input.b.sum4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sum4
            
            #add-point:AFTER FIELD sum4 name="input.a.sum4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sum4
            #add-point:ON CHANGE sum4 name="input.g.sum4"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rtiasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiasite
            #add-point:ON ACTION controlp INFIELD rtiasite name="input.c.rtiasite"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtiasite             #給予default值

            #給予arg
            CALL s_aooi500_q_where(g_prog_name,'rtiasite',g_rtia_m.rtiasite,'i') RETURNING l_where #150308-00001#3 150309 pomelo add 'i'
            LET g_qryparam.where = l_where
            CALL q_ooef001_24()

            LET g_rtia_m.rtiasite = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtiasite TO rtiasite              #顯示到畫面上
            CALL s_desc_get_department_desc(g_rtia_m.rtiasite) RETURNING g_rtia_m.rtiasite_desc
            DISPLAY BY NAME g_rtia_m.rtiasite_desc
            NEXT FIELD rtiasite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.rtiadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiadocdt
            #add-point:ON ACTION controlp INFIELD rtiadocdt name="input.c.rtiadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia035
            #add-point:ON ACTION controlp INFIELD rtia035 name="input.c.rtia035"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtiadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiadocno
            #add-point:ON ACTION controlp INFIELD rtiadocno name="input.c.rtiadocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtiadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004
            LET g_qryparam.arg2 = g_prog_name

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_rtia_m.rtiadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtia_m.rtiadocno TO rtiadocno              #顯示到畫面上

            NEXT FIELD rtiadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia006
            #add-point:ON ACTION controlp INFIELD rtia006 name="input.c.rtia006"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia001
            #add-point:ON ACTION controlp INFIELD rtia001 name="input.c.rtia001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtia001             #給予default值

            #給予arg

            CALL q_mmaq001_6()                                #呼叫開窗

            LET g_rtia_m.rtia001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtia_m.rtia001 TO rtia001              #顯示到畫面上
            CALL ammt450_rtia001_ref()
            NEXT FIELD rtia001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia042
            #add-point:ON ACTION controlp INFIELD rtia042 name="input.c.rtia042"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtia042             #給予default值

            #160705-00042#9 160713 by sakura mark(S)
            #CASE g_prog_name
			   #WHEN 'ammt452'
			   #160705-00042#9 160713 by sakura mark(E)
			   #160705-00042#9 160713 by sakura add(S)
            CASE 
			     WHEN g_prog_name MATCHES 'ammt452'
            #160705-00042#9 160713 by sakura add(E)			   
			      CALL q_mman001_3()
			   OTHERWISE
                  CALL q_mman001_9()                          #呼叫開窗
            END CASE

            LET g_rtia_m.rtia042 = g_qryparam.return1              

            DISPLAY g_rtia_m.rtia042 TO rtia042              #
            CALL s_desc_get_mman_desc(g_rtia_m.rtia042) RETURNING g_rtia_m.rtia042_desc
            DISPLAY BY NAME g_rtia_m.rtia042_desc
            NEXT FIELD rtia042                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia043
            #add-point:ON ACTION controlp INFIELD rtia043 name="input.c.rtia043"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia044
            #add-point:ON ACTION controlp INFIELD rtia044 name="input.c.rtia044"
            #此段落由子樣板a07產生            
            #開窗i段
			   CALL ammt450_controlp_rtia044()   
			   
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtia044               
            LET g_qryparam.arg1 = g_rtia_m.rtiasite
            
            #給予條件
            IF NOT cl_null(g_rtia044_str) THEN
               LET g_rtia044_str = "(",g_rtia044_str,")"
            ELSE
               LET g_rtia044_str = " mmby001=''"
            END IF
            LET g_qryparam.where = g_rtia044_str
               
            CALL q_mmby001_1()          
            LET g_rtia_m.rtia044 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_rtia_m.rtia045 = g_qryparam.return2

            DISPLAY g_rtia_m.rtia044,g_rtia_m.rtia045 TO rtia044,rtia045              #顯示到畫面上
            CALL ammt450_rtia044_ref()
            NEXT FIELD rtia044                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia045
            #add-point:ON ACTION controlp INFIELD rtia045 name="input.c.rtia045"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia041
            #add-point:ON ACTION controlp INFIELD rtia041 name="input.c.rtia041"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtiastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiastus
            #add-point:ON ACTION controlp INFIELD rtiastus name="input.c.rtiastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia007
            #add-point:ON ACTION controlp INFIELD rtia007 name="input.c.rtia007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #160819-00054#14 161003 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtia007   
            LET g_qryparam.arg1 = g_rtia_m.rtia001
            LET g_qryparam.arg2 = g_mmby014
            LET g_qryparam.arg3 = g_mmby015

            CALL q_rtiadocno_5()          
 
            LET g_rtia_m.rtia007 = g_qryparam.return1  
            DISPLAY g_rtia_m.rtia007 TO rtia007    
            
            NEXT FIELD rtia007   
            #160819-00054#14 161003 by lori add---(E)
            #END add-point
 
 
         #Ctrlp:input.c.rtia066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia066
            #add-point:ON ACTION controlp INFIELD rtia066 name="input.c.rtia066"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia046
            #add-point:ON ACTION controlp INFIELD rtia046 name="input.c.rtia046"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia047
            #add-point:ON ACTION controlp INFIELD rtia047 name="input.c.rtia047"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia0471
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia0471
            #add-point:ON ACTION controlp INFIELD rtia0471 name="input.c.rtia0471"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia015
            #add-point:ON ACTION controlp INFIELD rtia015 name="input.c.rtia015"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtiaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiaunit
            #add-point:ON ACTION controlp INFIELD rtiaunit name="input.c.rtiaunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia000
            #add-point:ON ACTION controlp INFIELD rtia000 name="input.c.rtia000"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia026
            #add-point:ON ACTION controlp INFIELD rtia026 name="input.c.rtia026"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia027
            #add-point:ON ACTION controlp INFIELD rtia027 name="input.c.rtia027"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia002
            #add-point:ON ACTION controlp INFIELD rtia002 name="input.c.rtia002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtia002             #給予default值

            #給予arg

            CALL q_pmaa001_7()                                #呼叫開窗

            LET g_rtia_m.rtia002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtia_m.rtia002 TO rtia002              #顯示到畫面上

            NEXT FIELD rtia002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia025
            #add-point:ON ACTION controlp INFIELD rtia025 name="input.c.rtia025"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia032
            #add-point:ON ACTION controlp INFIELD rtia032 name="input.c.rtia032"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia036
            #add-point:ON ACTION controlp INFIELD rtia036 name="input.c.rtia036"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtia036             #給予default值
            LET g_qryparam.default2 = "" #g_rtia_m.pcaal003 #說明
            #給予arg
            LET g_qryparam.arg1 = g_rtia_m.rtiasite


            CALL q_pcaa001_1()                                #呼叫開窗

            LET g_rtia_m.rtia036 = g_qryparam.return1              
            #LET g_rtia_m.pcaal003 = g_qryparam.return2 
            DISPLAY g_rtia_m.rtia036 TO rtia036              #
            #DISPLAY g_rtia_m.pcaal003 TO pcaal003 #說明
            CALL ammt450_rtia036_ref()   #151111-00021#1 20151112 add by beckxie
            NEXT FIELD rtia036                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia037
            #add-point:ON ACTION controlp INFIELD rtia037 name="input.c.rtia037"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtia037             #給予default值
            LET g_qryparam.default2 = "" #g_rtia_m.pcab003 #收銀人員姓名
            #給予arg
            LET g_qryparam.arg1 = g_rtia_m.rtiasite 
            LET g_qryparam.arg2 = g_rtia_m.rtia036

            CALL q_pcab001_1()                                #呼叫開窗

            LET g_rtia_m.rtia037 = g_qryparam.return1              
            #LET g_rtia_m.pcab003 = g_qryparam.return2 
            DISPLAY g_rtia_m.rtia037 TO rtia037              #
            #DISPLAY g_rtia_m.pcab003 TO pcab003 #收銀人員姓名
            CALL ammt450_rtia037_ref()   #151111-00021#1 20151112 add by beckxie
            NEXT FIELD rtia037                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia038
            #add-point:ON ACTION controlp INFIELD rtia038 name="input.c.rtia038"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtia038             #給予default值
            LET g_qryparam.default2 = "" #g_rtia_m.oogd002 #班別說明
            #給予arg
            LET g_qryparam.arg1 = g_rtia_m.rtiasite


            CALL q_oogd001_02()                                #呼叫開窗

            LET g_rtia_m.rtia038 = g_qryparam.return1              
            #LET g_rtia_m.oogd002 = g_qryparam.return2 
            DISPLAY g_rtia_m.rtia038 TO rtia038              #
            #DISPLAY g_rtia_m.oogd002 TO oogd002 #班別說明
            CALL ammt450_rtia038_ref()   #151111-00021#1 20151112 add by beckxie
            NEXT FIELD rtia038                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia039
            #add-point:ON ACTION controlp INFIELD rtia039 name="input.c.rtia039"
            
            #END add-point
 
 
         #Ctrlp:input.c.sum1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sum1
            #add-point:ON ACTION controlp INFIELD sum1 name="input.c.sum1"
            
            #END add-point
 
 
         #Ctrlp:input.c.sum4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sum4
            #add-point:ON ACTION controlp INFIELD sum4 name="input.c.sum4"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rtia_m.rtiadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               LET g_rtia_m.rtiaunit = g_rtia_m.rtiasite
               LET g_rtia_m.rtia000 = g_prog_name
               CALL s_aooi200_gen_docno(g_rtia_m.rtiasite,g_rtia_m.rtiadocno,g_rtia_m.rtiadocdt,g_prog_name) RETURNING l_flag,g_rtia_m.rtiadocno
               IF NOT l_flag THEN
                  NEXT FIELD rtiadocno
               END IF
               LET g_rtia_m.rtia006 = g_rtia_m.rtiadocdt    #150513-00009#1 By pomelo add
               #end add-point
               
               INSERT INTO rtia_t (rtiaent,rtiasite,rtiadocdt,rtia035,rtiadocno,rtia006,rtia001,rtia042, 
                   rtia043,rtia044,rtia045,rtia041,rtiastus,rtia007,rtia066,rtia046,rtia047,rtia014, 
                   rtia015,rtiaunit,rtia000,rtia026,rtia027,rtia002,rtia025,rtia032,rtia036,rtia037, 
                   rtia038,rtia039,rtiaownid,rtiaowndp,rtiacrtid,rtiacrtdp,rtiacrtdt,rtiamodid,rtiamoddt, 
                   rtiacnfid,rtiacnfdt,rtiapstid,rtiapstdt)
               VALUES (g_enterprise,g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtia035,g_rtia_m.rtiadocno, 
                   g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043,g_rtia_m.rtia044, 
                   g_rtia_m.rtia045,g_rtia_m.rtia041,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia066, 
                   g_rtia_m.rtia046,g_rtia_m.rtia047,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit, 
                   g_rtia_m.rtia000,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025, 
                   g_rtia_m.rtia032,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039, 
                   g_rtia_m.rtiaownid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt, 
                   g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid, 
                   g_rtia_m.rtiapstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rtia_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               LET g_rtiadocno_t = g_rtia_m.rtiadocno
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               IF cl_auth_chk_act("open_ammt450_01") THEN 
                  IF NOT cl_null(g_rtia_m.rtiadocno)THEN
                     CALL ammt450_create_temptable()
                     CALL ammt450_01(g_rtia_m.rtiadocno)
                     CALL ammt450_recount_point()
                     CALL s_transaction_end('Y','0') 
                     LET g_action_choice = ""
                  END IF
                  LET g_master_insert = TRUE   #160106-00002#3 20160107 add by beckxie
                  CALL ammt450_b_fill()        #160106-00002#3 20160107 add by beckxie
                  EXIT DIALOG
               END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL ammt450_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL ammt450_b_fill()
                  CALL ammt450_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL ammt450_rtia_t_mask_restore('restore_mask_o')
               
               UPDATE rtia_t SET (rtiasite,rtiadocdt,rtia035,rtiadocno,rtia006,rtia001,rtia042,rtia043, 
                   rtia044,rtia045,rtia041,rtiastus,rtia007,rtia066,rtia046,rtia047,rtia014,rtia015, 
                   rtiaunit,rtia000,rtia026,rtia027,rtia002,rtia025,rtia032,rtia036,rtia037,rtia038, 
                   rtia039,rtiaownid,rtiaowndp,rtiacrtid,rtiacrtdp,rtiacrtdt,rtiamodid,rtiamoddt,rtiacnfid, 
                   rtiacnfdt,rtiapstid,rtiapstdt) = (g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtia035, 
                   g_rtia_m.rtiadocno,g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043, 
                   g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia041,g_rtia_m.rtiastus,g_rtia_m.rtia007, 
                   g_rtia_m.rtia066,g_rtia_m.rtia046,g_rtia_m.rtia047,g_rtia_m.rtia014,g_rtia_m.rtia015, 
                   g_rtia_m.rtiaunit,g_rtia_m.rtia000,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002, 
                   g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038, 
                   g_rtia_m.rtia039,g_rtia_m.rtiaownid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtdp, 
                   g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt, 
                   g_rtia_m.rtiapstid,g_rtia_m.rtiapstdt)
                WHERE rtiaent = g_enterprise AND rtiadocno = g_rtiadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtia_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL ammt450_rtia_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rtia_m_t)
               LET g_log2 = util.JSON.stringify(g_rtia_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="ammt450.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmfe_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmfe_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt450_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mmfe_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL cl_showmsg_init()
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammt450_cl USING g_enterprise,g_rtia_m.rtiadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt450_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt450_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmfe_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmfe_d[l_ac].mmfeseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmfe_d_t.* = g_mmfe_d[l_ac].*  #BACKUP
               LET g_mmfe_d_o.* = g_mmfe_d[l_ac].*  #BACKUP
               CALL ammt450_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL ammt450_set_no_entry_b(l_cmd)
               IF NOT ammt450_lock_b("mmfe_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt450_bcl INTO g_mmfe_d[l_ac].mmfeseq,g_mmfe_d[l_ac].mmfe001,g_mmfe_d[l_ac].mmfe003, 
                      g_mmfe_d[l_ac].mmfe004,g_mmfe_d[l_ac].mmfe005,g_mmfe_d[l_ac].mmfe006,g_mmfe_d[l_ac].mmfe007, 
                      g_mmfe_d[l_ac].mmfe008,g_mmfe_d[l_ac].mmfe009,g_mmfe_d[l_ac].mmfe010,g_mmfe_d[l_ac].mmfe011, 
                      g_mmfe_d[l_ac].mmfe012,g_mmfe_d[l_ac].mmfe013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mmfe_d_t.mmfeseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmfe_d_mask_o[l_ac].* =  g_mmfe_d[l_ac].*
                  CALL ammt450_mmfe_t_mask()
                  LET g_mmfe_d_mask_n[l_ac].* =  g_mmfe_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt450_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmfe_d[l_ac].* TO NULL 
            INITIALIZE g_mmfe_d_t.* TO NULL 
            INITIALIZE g_mmfe_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_mmfe_d_t.* = g_mmfe_d[l_ac].*     #新輸入資料
            LET g_mmfe_d_o.* = g_mmfe_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt450_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt450_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmfe_d[li_reproduce_target].* = g_mmfe_d[li_reproduce].*
 
               LET g_mmfe_d[li_reproduce_target].mmfeseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mmfe_t 
             WHERE mmfeent = g_enterprise AND mmfedocno = g_rtia_m.rtiadocno
 
               AND mmfeseq = g_mmfe_d[l_ac].mmfeseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys[2] = g_mmfe_d[g_detail_idx].mmfeseq
               CALL ammt450_insert_b('mmfe_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mmfe_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmfe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt450_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM rtie_t
                WHERE rtieent = g_enterprise
                  AND rtiedocno = g_rtia_m.rtiadocno
               IF l_cnt >= 1 THEN
                  #此單據已有收款明細，無法進行單據刪除的動作！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00288'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rtia_m.rtiadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mmfe_d_t.mmfeseq
 
            
               #刪除同層單身
               IF NOT ammt450_delete_b('mmfe_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt450_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt450_key_delete_b(gs_keys,'mmfe_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt450_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
 
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt450_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  DELETE FROM rtib_t
                   WHERE rtibent = g_enterprise AND rtibdocno = g_rtia_m.rtiadocno
                     AND rtibseq = g_mmfe_d_t.mmfeseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "rtib_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE  
                  END IF 
                  
                  DELETE FROM xrcd_t
                   WHERE xrcdent = g_enterprise AND xrcddocno = g_rtia_m.rtiadocno
                     AND xrcdseq = g_mmfe_d_t.mmfeseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xrcd_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE  
                  END IF
                  CALL ammt450_recount_point()
               #end add-point
               LET l_count = g_mmfe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmfe_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfeseq
            #add-point:BEFORE FIELD mmfeseq name="input.b.page1.mmfeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfeseq
            
            #add-point:AFTER FIELD mmfeseq name="input.a.page1.mmfeseq"
            #此段落由子樣板a05產生
#            IF  g_rtia_m.rtiadocno IS NOT NULL AND g_mmfe_d[g_detail_idx].mmfeseq IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t OR g_mmfe_d[g_detail_idx].mmfeseq != g_mmfe_d_t.mmfeseq)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmfe_t WHERE "||"mmfeent = '" ||g_enterprise|| "' AND "||"mmfedocno = '"||g_rtia_m.rtiadocno ||"' AND "|| "mmfeseq = '"||g_mmfe_d[g_detail_idx].mmfeseq ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            IF g_mmfe_d[g_detail_idx].mmfeseq != g_mmfe_d_t.mmfeseq THEN
               LET g_mmfe_d[g_detail_idx].mmfeseq = g_mmfe_d_t.mmfeseq
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfeseq
            #add-point:ON CHANGE mmfeseq name="input.g.page1.mmfeseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe001
            
            #add-point:AFTER FIELD mmfe001 name="input.a.page1.mmfe001"
            CALL ammt450_mmfe001_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe001
            #add-point:BEFORE FIELD mmfe001 name="input.b.page1.mmfe001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe001
            #add-point:ON CHANGE mmfe001 name="input.g.page1.mmfe001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe003
            
            #add-point:AFTER FIELD mmfe003 name="input.a.page1.mmfe003"
            CALL s_desc_get_acc_desc('2071',g_mmfe_d[l_ac].mmfe003) RETURNING g_mmfe_d[l_ac].mmfe003_desc
            DISPLAY BY NAME g_mmfe_d[l_ac].mmfe003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe003
            #add-point:BEFORE FIELD mmfe003 name="input.b.page1.mmfe003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe003
            #add-point:ON CHANGE mmfe003 name="input.g.page1.mmfe003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe004
            #add-point:BEFORE FIELD mmfe004 name="input.b.page1.mmfe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe004
            
            #add-point:AFTER FIELD mmfe004 name="input.a.page1.mmfe004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe004
            #add-point:ON CHANGE mmfe004 name="input.g.page1.mmfe004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe005
            #add-point:BEFORE FIELD mmfe005 name="input.b.page1.mmfe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe005
            
            #add-point:AFTER FIELD mmfe005 name="input.a.page1.mmfe005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe005
            #add-point:ON CHANGE mmfe005 name="input.g.page1.mmfe005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmfe_d[l_ac].mmfe006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmfe006
            END IF 
 
 
 
            #add-point:AFTER FIELD mmfe006 name="input.a.page1.mmfe006"
            IF NOT cl_null(g_mmfe_d[l_ac].mmfe006) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe006
            #add-point:BEFORE FIELD mmfe006 name="input.b.page1.mmfe006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe006
            #add-point:ON CHANGE mmfe006 name="input.g.page1.mmfe006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmfe_d[l_ac].mmfe007,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmfe007
            END IF 
 
 
 
            #add-point:AFTER FIELD mmfe007 name="input.a.page1.mmfe007"
            IF NOT cl_null(g_mmfe_d[l_ac].mmfe007) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe007
            #add-point:BEFORE FIELD mmfe007 name="input.b.page1.mmfe007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe007
            #add-point:ON CHANGE mmfe007 name="input.g.page1.mmfe007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmfe_d[l_ac].mmfe008,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmfe008
            END IF 
 
 
 
            #add-point:AFTER FIELD mmfe008 name="input.a.page1.mmfe008"
            IF NOT cl_null(g_mmfe_d[l_ac].mmfe008) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe008
            #add-point:BEFORE FIELD mmfe008 name="input.b.page1.mmfe008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe008
            #add-point:ON CHANGE mmfe008 name="input.g.page1.mmfe008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmfe_d[l_ac].mmfe009,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmfe009
            END IF 
 
 
 
            #add-point:AFTER FIELD mmfe009 name="input.a.page1.mmfe009"
            IF NOT cl_null(g_mmfe_d[l_ac].mmfe009) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe009
            #add-point:BEFORE FIELD mmfe009 name="input.b.page1.mmfe009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe009
            #add-point:ON CHANGE mmfe009 name="input.g.page1.mmfe009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe010
            
            #add-point:AFTER FIELD mmfe010 name="input.a.page1.mmfe010"
            CALL s_desc_get_stock_desc(g_rtia_m.rtiasite,g_mmfe_d[l_ac].mmfe010) RETURNING g_mmfe_d[l_ac].mmfe010_desc
            DISPLAY BY NAME g_mmfe_d[l_ac].mmfe010_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe010
            #add-point:BEFORE FIELD mmfe010 name="input.b.page1.mmfe010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe010
            #add-point:ON CHANGE mmfe010 name="input.g.page1.mmfe010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe011
            #add-point:BEFORE FIELD mmfe011 name="input.b.page1.mmfe011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe011
            
            #add-point:AFTER FIELD mmfe011 name="input.a.page1.mmfe011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe011
            #add-point:ON CHANGE mmfe011 name="input.g.page1.mmfe011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe012
            #add-point:BEFORE FIELD mmfe012 name="input.b.page1.mmfe012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe012
            
            #add-point:AFTER FIELD mmfe012 name="input.a.page1.mmfe012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe012
            #add-point:ON CHANGE mmfe012 name="input.g.page1.mmfe012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe013
            
            #add-point:AFTER FIELD mmfe013 name="input.a.page1.mmfe013"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe013
            #add-point:BEFORE FIELD mmfe013 name="input.b.page1.mmfe013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe013
            #add-point:ON CHANGE mmfe013 name="input.g.page1.mmfe013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmfe013_desc
            #add-point:BEFORE FIELD mmfe013_desc name="input.b.page1.mmfe013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmfe013_desc
            
            #add-point:AFTER FIELD mmfe013_desc name="input.a.page1.mmfe013_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmfe013_desc
            #add-point:ON CHANGE mmfe013_desc name="input.g.page1.mmfe013_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmfeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfeseq
            #add-point:ON ACTION controlp INFIELD mmfeseq name="input.c.page1.mmfeseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe001
            #add-point:ON ACTION controlp INFIELD mmfe001 name="input.c.page1.mmfe001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe003
            #add-point:ON ACTION controlp INFIELD mmfe003 name="input.c.page1.mmfe003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe004
            #add-point:ON ACTION controlp INFIELD mmfe004 name="input.c.page1.mmfe004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe005
            #add-point:ON ACTION controlp INFIELD mmfe005 name="input.c.page1.mmfe005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe006
            #add-point:ON ACTION controlp INFIELD mmfe006 name="input.c.page1.mmfe006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe007
            #add-point:ON ACTION controlp INFIELD mmfe007 name="input.c.page1.mmfe007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe008
            #add-point:ON ACTION controlp INFIELD mmfe008 name="input.c.page1.mmfe008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe009
            #add-point:ON ACTION controlp INFIELD mmfe009 name="input.c.page1.mmfe009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe010
            #add-point:ON ACTION controlp INFIELD mmfe010 name="input.c.page1.mmfe010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe011
            #add-point:ON ACTION controlp INFIELD mmfe011 name="input.c.page1.mmfe011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe012
            #add-point:ON ACTION controlp INFIELD mmfe012 name="input.c.page1.mmfe012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe013
            #add-point:ON ACTION controlp INFIELD mmfe013 name="input.c.page1.mmfe013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmfe013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmfe013_desc
            #add-point:ON ACTION controlp INFIELD mmfe013_desc name="input.c.page1.mmfe013_desc"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmfe_d[l_ac].* = g_mmfe_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt450_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mmfe_d[l_ac].mmfeseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmfe_d[l_ac].* = g_mmfe_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL ammt450_mmfe_t_mask_restore('restore_mask_o')
      
               UPDATE mmfe_t SET (mmfedocno,mmfeseq,mmfe001,mmfe003,mmfe004,mmfe005,mmfe006,mmfe007, 
                   mmfe008,mmfe009,mmfe010,mmfe011,mmfe012,mmfe013) = (g_rtia_m.rtiadocno,g_mmfe_d[l_ac].mmfeseq, 
                   g_mmfe_d[l_ac].mmfe001,g_mmfe_d[l_ac].mmfe003,g_mmfe_d[l_ac].mmfe004,g_mmfe_d[l_ac].mmfe005, 
                   g_mmfe_d[l_ac].mmfe006,g_mmfe_d[l_ac].mmfe007,g_mmfe_d[l_ac].mmfe008,g_mmfe_d[l_ac].mmfe009, 
                   g_mmfe_d[l_ac].mmfe010,g_mmfe_d[l_ac].mmfe011,g_mmfe_d[l_ac].mmfe012,g_mmfe_d[l_ac].mmfe013) 
 
                WHERE mmfeent = g_enterprise AND mmfedocno = g_rtia_m.rtiadocno 
 
                  AND mmfeseq = g_mmfe_d_t.mmfeseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmfe_d[l_ac].* = g_mmfe_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmfe_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmfe_d[l_ac].* = g_mmfe_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmfe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys_bak[1] = g_rtiadocno_t
               LET gs_keys[2] = g_mmfe_d[g_detail_idx].mmfeseq
               LET gs_keys_bak[2] = g_mmfe_d_t.mmfeseq
               CALL ammt450_update_b('mmfe_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL ammt450_mmfe_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mmfe_d[g_detail_idx].mmfeseq = g_mmfe_d_t.mmfeseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rtia_m.rtiadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mmfe_d_t.mmfeseq
 
                  CALL ammt450_key_update_b(gs_keys,'mmfe_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_mmfe_d_t)
               LET g_log2 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_mmfe_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                           FROM rtib_t
                                          WHERE rtibent = g_enterprise
                                            AND rtibdocno = g_rtia_m.rtiadocno)
             WHERE rtiaent = g_enterprise
               AND rtiadocno = g_rtia_m.rtiadocno
            #end add-point
            CALL ammt450_unlock_b("mmfe_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmfe_d[li_reproduce_target].* = g_mmfe_d[li_reproduce].*
 
               LET g_mmfe_d[li_reproduce_target].mmfeseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmfe_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmfe_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_mmfe2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmfe2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt450_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmfe2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            CALL cl_showmsg_init()
            NEXT FIELD rtia001
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmfe2_d[l_ac].* TO NULL 
            INITIALIZE g_mmfe2_d_t.* TO NULL 
            INITIALIZE g_mmfe2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_mmfe2_d[l_ac].rtib020 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_mmfe2_d_t.* = g_mmfe2_d[l_ac].*     #新輸入資料
            LET g_mmfe2_d_o.* = g_mmfe2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt450_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt450_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmfe2_d[li_reproduce_target].* = g_mmfe2_d[li_reproduce].*
 
               LET g_mmfe2_d[li_reproduce_target].rtibseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammt450_cl USING g_enterprise,g_rtia_m.rtiadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt450_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt450_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmfe2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmfe2_d[l_ac].rtibseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmfe2_d_t.* = g_mmfe2_d[l_ac].*  #BACKUP
               LET g_mmfe2_d_o.* = g_mmfe2_d[l_ac].*  #BACKUP
               CALL ammt450_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL ammt450_set_no_entry_b(l_cmd)
               IF NOT ammt450_lock_b("rtib_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt450_bcl2 INTO g_mmfe2_d[l_ac].rtibseq,g_mmfe2_d[l_ac].rtib003,g_mmfe2_d[l_ac].rtib004, 
                      g_mmfe2_d[l_ac].rtib006,g_mmfe2_d[l_ac].rtib008,g_mmfe2_d[l_ac].rtib009,g_mmfe2_d[l_ac].rtib010, 
                      g_mmfe2_d[l_ac].rtib012,g_mmfe2_d[l_ac].rtib013,g_mmfe2_d[l_ac].rtib018,g_mmfe2_d[l_ac].rtib015, 
                      g_mmfe2_d[l_ac].rtib016,g_mmfe2_d[l_ac].rtib019,g_mmfe2_d[l_ac].rtib020,g_mmfe2_d[l_ac].rtib021, 
                      g_mmfe2_d[l_ac].rtib022,g_mmfe2_d[l_ac].rtib025,g_mmfe2_d[l_ac].rtib030
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmfe2_d_mask_o[l_ac].* =  g_mmfe2_d[l_ac].*
                  CALL ammt450_rtib_t_mask()
                  LET g_mmfe2_d_mask_n[l_ac].* =  g_mmfe2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt450_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rtia_m.rtiadocno
               LET gs_keys[gs_keys.getLength()+1] = g_mmfe2_d_t.rtibseq
            
               #刪除同層單身
               IF NOT ammt450_delete_b('rtib_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt450_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt450_key_delete_b(gs_keys,'rtib_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt450_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt450_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_mmfe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmfe2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM rtib_t 
             WHERE rtibent = g_enterprise AND rtibdocno = g_rtia_m.rtiadocno
               AND rtibseq = g_mmfe2_d[l_ac].rtibseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys[2] = g_mmfe2_d[g_detail_idx].rtibseq
               CALL ammt450_insert_b('rtib_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmfe_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt450_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmfe2_d[l_ac].* = g_mmfe2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt450_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmfe2_d[l_ac].* = g_mmfe2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL ammt450_rtib_t_mask_restore('restore_mask_o')
                              
               UPDATE rtib_t SET (rtibdocno,rtibseq,rtib003,rtib004,rtib006,rtib008,rtib009,rtib010, 
                   rtib012,rtib013,rtib018,rtib015,rtib016,rtib019,rtib020,rtib021,rtib022,rtib025,rtib030) = (g_rtia_m.rtiadocno, 
                   g_mmfe2_d[l_ac].rtibseq,g_mmfe2_d[l_ac].rtib003,g_mmfe2_d[l_ac].rtib004,g_mmfe2_d[l_ac].rtib006, 
                   g_mmfe2_d[l_ac].rtib008,g_mmfe2_d[l_ac].rtib009,g_mmfe2_d[l_ac].rtib010,g_mmfe2_d[l_ac].rtib012, 
                   g_mmfe2_d[l_ac].rtib013,g_mmfe2_d[l_ac].rtib018,g_mmfe2_d[l_ac].rtib015,g_mmfe2_d[l_ac].rtib016, 
                   g_mmfe2_d[l_ac].rtib019,g_mmfe2_d[l_ac].rtib020,g_mmfe2_d[l_ac].rtib021,g_mmfe2_d[l_ac].rtib022, 
                   g_mmfe2_d[l_ac].rtib025,g_mmfe2_d[l_ac].rtib030) #自訂欄位頁簽
                WHERE rtibent = g_enterprise AND rtibdocno = g_rtia_m.rtiadocno
                  AND rtibseq = g_mmfe2_d_t.rtibseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmfe2_d[l_ac].* = g_mmfe2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtib_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmfe2_d[l_ac].* = g_mmfe2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys_bak[1] = g_rtiadocno_t
               LET gs_keys[2] = g_mmfe2_d[g_detail_idx].rtibseq
               LET gs_keys_bak[2] = g_mmfe2_d_t.rtibseq
               CALL ammt450_update_b('rtib_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammt450_rtib_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmfe2_d[g_detail_idx].rtibseq = g_mmfe2_d_t.rtibseq 
                  ) THEN
                  LET gs_keys[01] = g_rtia_m.rtiadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mmfe2_d_t.rtibseq
                  CALL ammt450_key_update_b(gs_keys,'rtib_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_mmfe2_d_t)
               LET g_log2 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_mmfe2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtibseq
            #add-point:BEFORE FIELD rtibseq name="input.b.page2.rtibseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtibseq
            
            #add-point:AFTER FIELD rtibseq name="input.a.page2.rtibseq"
            #此段落由子樣板a05產生
            IF  g_rtia_m.rtiadocno IS NOT NULL AND g_mmfe2_d[g_detail_idx].rtibseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t OR g_mmfe2_d[g_detail_idx].rtibseq != g_mmfe2_d_t.rtibseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtib_t WHERE "||"rtibent = '" ||g_enterprise|| "' AND "||"rtibdocno = '"||g_rtia_m.rtiadocno ||"' AND "|| "rtibseq = '"||g_mmfe2_d[g_detail_idx].rtibseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtibseq
            #add-point:ON CHANGE rtibseq name="input.g.page2.rtibseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib003
            #add-point:BEFORE FIELD rtib003 name="input.b.page2.rtib003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib003
            
            #add-point:AFTER FIELD rtib003 name="input.a.page2.rtib003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib003
            #add-point:ON CHANGE rtib003 name="input.g.page2.rtib003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib004
            
            #add-point:AFTER FIELD rtib004 name="input.a.page2.rtib004"
            CALL ammt450_rtib004_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib004
            #add-point:BEFORE FIELD rtib004 name="input.b.page2.rtib004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib004
            #add-point:ON CHANGE rtib004 name="input.g.page2.rtib004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib006
            
            #add-point:AFTER FIELD rtib006 name="input.a.page2.rtib006"
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib006
            #add-point:BEFORE FIELD rtib006 name="input.b.page2.rtib006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib006
            #add-point:ON CHANGE rtib006 name="input.g.page2.rtib006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib008
            #add-point:BEFORE FIELD rtib008 name="input.b.page2.rtib008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib008
            
            #add-point:AFTER FIELD rtib008 name="input.a.page2.rtib008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib008
            #add-point:ON CHANGE rtib008 name="input.g.page2.rtib008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib009
            #add-point:BEFORE FIELD rtib009 name="input.b.page2.rtib009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib009
            
            #add-point:AFTER FIELD rtib009 name="input.a.page2.rtib009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib009
            #add-point:ON CHANGE rtib009 name="input.g.page2.rtib009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib010
            #add-point:BEFORE FIELD rtib010 name="input.b.page2.rtib010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib010
            
            #add-point:AFTER FIELD rtib010 name="input.a.page2.rtib010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib010
            #add-point:ON CHANGE rtib010 name="input.g.page2.rtib010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib012
            #add-point:BEFORE FIELD rtib012 name="input.b.page2.rtib012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib012
            
            #add-point:AFTER FIELD rtib012 name="input.a.page2.rtib012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib012
            #add-point:ON CHANGE rtib012 name="input.g.page2.rtib012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib013
            
            #add-point:AFTER FIELD rtib013 name="input.a.page2.rtib013"



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib013
            #add-point:BEFORE FIELD rtib013 name="input.b.page2.rtib013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib013
            #add-point:ON CHANGE rtib013 name="input.g.page2.rtib013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib018
            
            #add-point:AFTER FIELD rtib018 name="input.a.page2.rtib018"



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib018
            #add-point:BEFORE FIELD rtib018 name="input.b.page2.rtib018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib018
            #add-point:ON CHANGE rtib018 name="input.g.page2.rtib018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib015
            
            #add-point:AFTER FIELD rtib015 name="input.a.page2.rtib015"



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib015
            #add-point:BEFORE FIELD rtib015 name="input.b.page2.rtib015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib015
            #add-point:ON CHANGE rtib015 name="input.g.page2.rtib015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib016
            #add-point:BEFORE FIELD rtib016 name="input.b.page2.rtib016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib016
            
            #add-point:AFTER FIELD rtib016 name="input.a.page2.rtib016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib016
            #add-point:ON CHANGE rtib016 name="input.g.page2.rtib016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib019
            #add-point:BEFORE FIELD rtib019 name="input.b.page2.rtib019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib019
            
            #add-point:AFTER FIELD rtib019 name="input.a.page2.rtib019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib019
            #add-point:ON CHANGE rtib019 name="input.g.page2.rtib019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib020
            #add-point:BEFORE FIELD rtib020 name="input.b.page2.rtib020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib020
            
            #add-point:AFTER FIELD rtib020 name="input.a.page2.rtib020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib020
            #add-point:ON CHANGE rtib020 name="input.g.page2.rtib020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib021
            #add-point:BEFORE FIELD rtib021 name="input.b.page2.rtib021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib021
            
            #add-point:AFTER FIELD rtib021 name="input.a.page2.rtib021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib021
            #add-point:ON CHANGE rtib021 name="input.g.page2.rtib021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib022
            #add-point:BEFORE FIELD rtib022 name="input.b.page2.rtib022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib022
            
            #add-point:AFTER FIELD rtib022 name="input.a.page2.rtib022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib022
            #add-point:ON CHANGE rtib022 name="input.g.page2.rtib022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib025
            
            #add-point:AFTER FIELD rtib025 name="input.a.page2.rtib025"
            CALL s_desc_get_stock_desc(g_rtia_m.rtiasite,g_mmfe2_d[l_ac].rtib025) RETURNING g_mmfe2_d[l_ac].rtib025_desc
            DISPLAY BY NAME g_mmfe2_d[l_ac].rtib025_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib025
            #add-point:BEFORE FIELD rtib025 name="input.b.page2.rtib025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib025
            #add-point:ON CHANGE rtib025 name="input.g.page2.rtib025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib030
            #add-point:BEFORE FIELD rtib030 name="input.b.page2.rtib030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib030
            
            #add-point:AFTER FIELD rtib030 name="input.a.page2.rtib030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib030
            #add-point:ON CHANGE rtib030 name="input.g.page2.rtib030"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.rtibseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtibseq
            #add-point:ON ACTION controlp INFIELD rtibseq name="input.c.page2.rtibseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib003
            #add-point:ON ACTION controlp INFIELD rtib003 name="input.c.page2.rtib003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib004
            #add-point:ON ACTION controlp INFIELD rtib004 name="input.c.page2.rtib004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib006
            #add-point:ON ACTION controlp INFIELD rtib006 name="input.c.page2.rtib006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib008
            #add-point:ON ACTION controlp INFIELD rtib008 name="input.c.page2.rtib008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib009
            #add-point:ON ACTION controlp INFIELD rtib009 name="input.c.page2.rtib009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib010
            #add-point:ON ACTION controlp INFIELD rtib010 name="input.c.page2.rtib010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib012
            #add-point:ON ACTION controlp INFIELD rtib012 name="input.c.page2.rtib012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib013
            #add-point:ON ACTION controlp INFIELD rtib013 name="input.c.page2.rtib013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib018
            #add-point:ON ACTION controlp INFIELD rtib018 name="input.c.page2.rtib018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib015
            #add-point:ON ACTION controlp INFIELD rtib015 name="input.c.page2.rtib015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib016
            #add-point:ON ACTION controlp INFIELD rtib016 name="input.c.page2.rtib016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib019
            #add-point:ON ACTION controlp INFIELD rtib019 name="input.c.page2.rtib019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib020
            #add-point:ON ACTION controlp INFIELD rtib020 name="input.c.page2.rtib020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib021
            #add-point:ON ACTION controlp INFIELD rtib021 name="input.c.page2.rtib021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib022
            #add-point:ON ACTION controlp INFIELD rtib022 name="input.c.page2.rtib022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib025
            #add-point:ON ACTION controlp INFIELD rtib025 name="input.c.page2.rtib025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rtib030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib030
            #add-point:ON ACTION controlp INFIELD rtib030 name="input.c.page2.rtib030"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmfe2_d[l_ac].* = g_mmfe2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt450_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammt450_unlock_b("rtib_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmfe2_d[li_reproduce_target].* = g_mmfe2_d[li_reproduce].*
 
               LET g_mmfe2_d[li_reproduce_target].rtibseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmfe2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmfe2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mmfe3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmfe3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt450_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmfe3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            CALL cl_showmsg_init()
            NEXT FIELD rtia001
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmfe3_d[l_ac].* TO NULL 
            INITIALIZE g_mmfe3_d_t.* TO NULL 
            INITIALIZE g_mmfe3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_mmfe3_d[l_ac].xrcd006 = "N"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_mmfe3_d_t.* = g_mmfe3_d[l_ac].*     #新輸入資料
            LET g_mmfe3_d_o.* = g_mmfe3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt450_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt450_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmfe3_d[li_reproduce_target].* = g_mmfe3_d[li_reproduce].*
 
               LET g_mmfe3_d[li_reproduce_target].xrcdld = NULL
               LET g_mmfe3_d[li_reproduce_target].xrcdseq = NULL
               LET g_mmfe3_d[li_reproduce_target].xrcdseq2 = NULL
               LET g_mmfe3_d[li_reproduce_target].xrcd007 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammt450_cl USING g_enterprise,g_rtia_m.rtiadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt450_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt450_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmfe3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmfe3_d[l_ac].xrcdld IS NOT NULL
               AND g_mmfe3_d[l_ac].xrcdseq IS NOT NULL
               AND g_mmfe3_d[l_ac].xrcdseq2 IS NOT NULL
               AND g_mmfe3_d[l_ac].xrcd007 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmfe3_d_t.* = g_mmfe3_d[l_ac].*  #BACKUP
               LET g_mmfe3_d_o.* = g_mmfe3_d[l_ac].*  #BACKUP
               CALL ammt450_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL ammt450_set_no_entry_b(l_cmd)
               IF NOT ammt450_lock_b("xrcd_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt450_bcl3 INTO g_mmfe3_d[l_ac].xrcd007,g_mmfe3_d[l_ac].xrcdld,g_mmfe3_d[l_ac].xrcdseq, 
                      g_mmfe3_d[l_ac].xrcdseq2,g_mmfe3_d[l_ac].xrcd002,g_mmfe3_d[l_ac].xrcd003,g_mmfe3_d[l_ac].xrcd006, 
                      g_mmfe3_d[l_ac].xrcd004,g_mmfe3_d[l_ac].xrcd104
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmfe3_d_mask_o[l_ac].* =  g_mmfe3_d[l_ac].*
                  CALL ammt450_xrcd_t_mask()
                  LET g_mmfe3_d_mask_n[l_ac].* =  g_mmfe3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt450_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rtia_m.rtiadocno
               LET gs_keys[gs_keys.getLength()+1] = g_mmfe3_d_t.xrcdld
               LET gs_keys[gs_keys.getLength()+1] = g_mmfe3_d_t.xrcdseq
               LET gs_keys[gs_keys.getLength()+1] = g_mmfe3_d_t.xrcdseq2
               LET gs_keys[gs_keys.getLength()+1] = g_mmfe3_d_t.xrcd007
            
               #刪除同層單身
               IF NOT ammt450_delete_b('xrcd_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt450_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt450_key_delete_b(gs_keys,'xrcd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt450_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt450_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_mmfe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmfe3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xrcd_t 
             WHERE xrcdent = g_enterprise AND xrcddocno = g_rtia_m.rtiadocno
               AND xrcdld = g_mmfe3_d[l_ac].xrcdld
               AND xrcdseq = g_mmfe3_d[l_ac].xrcdseq
               AND xrcdseq2 = g_mmfe3_d[l_ac].xrcdseq2
               AND xrcd007 = g_mmfe3_d[l_ac].xrcd007
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys[2] = g_mmfe3_d[g_detail_idx].xrcdld
               LET gs_keys[3] = g_mmfe3_d[g_detail_idx].xrcdseq
               LET gs_keys[4] = g_mmfe3_d[g_detail_idx].xrcdseq2
               LET gs_keys[5] = g_mmfe3_d[g_detail_idx].xrcd007
               CALL ammt450_insert_b('xrcd_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmfe_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt450_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmfe3_d[l_ac].* = g_mmfe3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt450_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmfe3_d[l_ac].* = g_mmfe3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL ammt450_xrcd_t_mask_restore('restore_mask_o')
                              
               UPDATE xrcd_t SET (xrcddocno,xrcd007,xrcdld,xrcdseq,xrcdseq2,xrcd002,xrcd003,xrcd006, 
                   xrcd004,xrcd104) = (g_rtia_m.rtiadocno,g_mmfe3_d[l_ac].xrcd007,g_mmfe3_d[l_ac].xrcdld, 
                   g_mmfe3_d[l_ac].xrcdseq,g_mmfe3_d[l_ac].xrcdseq2,g_mmfe3_d[l_ac].xrcd002,g_mmfe3_d[l_ac].xrcd003, 
                   g_mmfe3_d[l_ac].xrcd006,g_mmfe3_d[l_ac].xrcd004,g_mmfe3_d[l_ac].xrcd104) #自訂欄位頁簽 
 
                WHERE xrcdent = g_enterprise AND xrcddocno = g_rtia_m.rtiadocno
                  AND xrcdld = g_mmfe3_d_t.xrcdld #項次 
                  AND xrcdseq = g_mmfe3_d_t.xrcdseq
                  AND xrcdseq2 = g_mmfe3_d_t.xrcdseq2
                  AND xrcd007 = g_mmfe3_d_t.xrcd007
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmfe3_d[l_ac].* = g_mmfe3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmfe3_d[l_ac].* = g_mmfe3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys_bak[1] = g_rtiadocno_t
               LET gs_keys[2] = g_mmfe3_d[g_detail_idx].xrcdld
               LET gs_keys_bak[2] = g_mmfe3_d_t.xrcdld
               LET gs_keys[3] = g_mmfe3_d[g_detail_idx].xrcdseq
               LET gs_keys_bak[3] = g_mmfe3_d_t.xrcdseq
               LET gs_keys[4] = g_mmfe3_d[g_detail_idx].xrcdseq2
               LET gs_keys_bak[4] = g_mmfe3_d_t.xrcdseq2
               LET gs_keys[5] = g_mmfe3_d[g_detail_idx].xrcd007
               LET gs_keys_bak[5] = g_mmfe3_d_t.xrcd007
               CALL ammt450_update_b('xrcd_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammt450_xrcd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmfe3_d[g_detail_idx].xrcdld = g_mmfe3_d_t.xrcdld 
                  AND g_mmfe3_d[g_detail_idx].xrcdseq = g_mmfe3_d_t.xrcdseq 
                  AND g_mmfe3_d[g_detail_idx].xrcdseq2 = g_mmfe3_d_t.xrcdseq2 
                  AND g_mmfe3_d[g_detail_idx].xrcd007 = g_mmfe3_d_t.xrcd007 
                  ) THEN
                  LET gs_keys[01] = g_rtia_m.rtiadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mmfe3_d_t.xrcdld
                  LET gs_keys[gs_keys.getLength()+1] = g_mmfe3_d_t.xrcdseq
                  LET gs_keys[gs_keys.getLength()+1] = g_mmfe3_d_t.xrcdseq2
                  LET gs_keys[gs_keys.getLength()+1] = g_mmfe3_d_t.xrcd007
                  CALL ammt450_key_update_b(gs_keys,'xrcd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_mmfe3_d_t)
               LET g_log2 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_mmfe3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd007
            #add-point:BEFORE FIELD xrcd007 name="input.b.page3.xrcd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd007
            
            #add-point:AFTER FIELD xrcd007 name="input.a.page3.xrcd007"
            #此段落由子樣板a05產生
            IF  g_rtia_m.rtiadocno IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdld IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t OR g_mmfe3_d[g_detail_idx].xrcdld != g_mmfe3_d_t.xrcdld OR g_mmfe3_d[g_detail_idx].xrcdseq != g_mmfe3_d_t.xrcdseq OR g_mmfe3_d[g_detail_idx].xrcdseq2 != g_mmfe3_d_t.xrcdseq2 OR g_mmfe3_d[g_detail_idx].xrcd007 != g_mmfe3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = '" ||g_enterprise|| "' AND "||"xrcddocno = '"||g_rtia_m.rtiadocno ||"' AND "|| "xrcdld = '"||g_mmfe3_d[g_detail_idx].xrcdld ||"' AND "|| "xrcdseq = '"||g_mmfe3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcdseq2 = '"||g_mmfe3_d[g_detail_idx].xrcdseq2 ||"' AND "|| "xrcd007 = '"||g_mmfe3_d[g_detail_idx].xrcd007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd007
            #add-point:ON CHANGE xrcd007 name="input.g.page3.xrcd007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdld
            #add-point:BEFORE FIELD xrcdld name="input.b.page3.xrcdld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdld
            
            #add-point:AFTER FIELD xrcdld name="input.a.page3.xrcdld"
            #此段落由子樣板a05產生
            IF  g_rtia_m.rtiadocno IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdld IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t OR g_mmfe3_d[g_detail_idx].xrcdld != g_mmfe3_d_t.xrcdld OR g_mmfe3_d[g_detail_idx].xrcdseq != g_mmfe3_d_t.xrcdseq OR g_mmfe3_d[g_detail_idx].xrcdseq2 != g_mmfe3_d_t.xrcdseq2 OR g_mmfe3_d[g_detail_idx].xrcd007 != g_mmfe3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = '" ||g_enterprise|| "' AND "||"xrcddocno = '"||g_rtia_m.rtiadocno ||"' AND "|| "xrcdld = '"||g_mmfe3_d[g_detail_idx].xrcdld ||"' AND "|| "xrcdseq = '"||g_mmfe3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcdseq2 = '"||g_mmfe3_d[g_detail_idx].xrcdseq2 ||"' AND "|| "xrcd007 = '"||g_mmfe3_d[g_detail_idx].xrcd007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdld
            #add-point:ON CHANGE xrcdld name="input.g.page3.xrcdld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq
            #add-point:BEFORE FIELD xrcdseq name="input.b.page3.xrcdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq
            
            #add-point:AFTER FIELD xrcdseq name="input.a.page3.xrcdseq"
            #此段落由子樣板a05產生
            IF  g_rtia_m.rtiadocno IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdld IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t OR g_mmfe3_d[g_detail_idx].xrcdld != g_mmfe3_d_t.xrcdld OR g_mmfe3_d[g_detail_idx].xrcdseq != g_mmfe3_d_t.xrcdseq OR g_mmfe3_d[g_detail_idx].xrcdseq2 != g_mmfe3_d_t.xrcdseq2 OR g_mmfe3_d[g_detail_idx].xrcd007 != g_mmfe3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = '" ||g_enterprise|| "' AND "||"xrcddocno = '"||g_rtia_m.rtiadocno ||"' AND "|| "xrcdld = '"||g_mmfe3_d[g_detail_idx].xrcdld ||"' AND "|| "xrcdseq = '"||g_mmfe3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcdseq2 = '"||g_mmfe3_d[g_detail_idx].xrcdseq2 ||"' AND "|| "xrcd007 = '"||g_mmfe3_d[g_detail_idx].xrcd007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdseq
            #add-point:ON CHANGE xrcdseq name="input.g.page3.xrcdseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq2
            #add-point:BEFORE FIELD xrcdseq2 name="input.b.page3.xrcdseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq2
            
            #add-point:AFTER FIELD xrcdseq2 name="input.a.page3.xrcdseq2"
            #此段落由子樣板a05產生
            IF  g_rtia_m.rtiadocno IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdld IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_mmfe3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t OR g_mmfe3_d[g_detail_idx].xrcdld != g_mmfe3_d_t.xrcdld OR g_mmfe3_d[g_detail_idx].xrcdseq != g_mmfe3_d_t.xrcdseq OR g_mmfe3_d[g_detail_idx].xrcdseq2 != g_mmfe3_d_t.xrcdseq2 OR g_mmfe3_d[g_detail_idx].xrcd007 != g_mmfe3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = '" ||g_enterprise|| "' AND "||"xrcddocno = '"||g_rtia_m.rtiadocno ||"' AND "|| "xrcdld = '"||g_mmfe3_d[g_detail_idx].xrcdld ||"' AND "|| "xrcdseq = '"||g_mmfe3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcdseq2 = '"||g_mmfe3_d[g_detail_idx].xrcdseq2 ||"' AND "|| "xrcd007 = '"||g_mmfe3_d[g_detail_idx].xrcd007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdseq2
            #add-point:ON CHANGE xrcdseq2 name="input.g.page3.xrcdseq2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd002
            
            #add-point:AFTER FIELD xrcd002 name="input.a.page3.xrcd002"
            CALL s_desc_get_tax_desc1(g_rtia_m.rtiasite,g_mmfe3_d[l_ac].xrcd002) RETURNING g_mmfe3_d[l_ac].xrcd002_desc
            DISPLAY BY NAME g_mmfe3_d[l_ac].xrcd002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd002
            #add-point:BEFORE FIELD xrcd002 name="input.b.page3.xrcd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd002
            #add-point:ON CHANGE xrcd002 name="input.g.page3.xrcd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd003
            #add-point:BEFORE FIELD xrcd003 name="input.b.page3.xrcd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd003
            
            #add-point:AFTER FIELD xrcd003 name="input.a.page3.xrcd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd003
            #add-point:ON CHANGE xrcd003 name="input.g.page3.xrcd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd006
            #add-point:BEFORE FIELD xrcd006 name="input.b.page3.xrcd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd006
            
            #add-point:AFTER FIELD xrcd006 name="input.a.page3.xrcd006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd006
            #add-point:ON CHANGE xrcd006 name="input.g.page3.xrcd006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd004
            #add-point:BEFORE FIELD xrcd004 name="input.b.page3.xrcd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd004
            
            #add-point:AFTER FIELD xrcd004 name="input.a.page3.xrcd004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd004
            #add-point:ON CHANGE xrcd004 name="input.g.page3.xrcd004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.xrcd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd007
            #add-point:ON ACTION controlp INFIELD xrcd007 name="input.c.page3.xrcd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcdld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdld
            #add-point:ON ACTION controlp INFIELD xrcdld name="input.c.page3.xrcdld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq
            #add-point:ON ACTION controlp INFIELD xrcdseq name="input.c.page3.xrcdseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcdseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq2
            #add-point:ON ACTION controlp INFIELD xrcdseq2 name="input.c.page3.xrcdseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd002
            #add-point:ON ACTION controlp INFIELD xrcd002 name="input.c.page3.xrcd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd003
            #add-point:ON ACTION controlp INFIELD xrcd003 name="input.c.page3.xrcd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd006
            #add-point:ON ACTION controlp INFIELD xrcd006 name="input.c.page3.xrcd006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd004
            #add-point:ON ACTION controlp INFIELD xrcd004 name="input.c.page3.xrcd004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmfe3_d[l_ac].* = g_mmfe3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt450_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammt450_unlock_b("xrcd_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmfe3_d[li_reproduce_target].* = g_mmfe3_d[li_reproduce].*
 
               LET g_mmfe3_d[li_reproduce_target].xrcdld = NULL
               LET g_mmfe3_d[li_reproduce_target].xrcdseq = NULL
               LET g_mmfe3_d[li_reproduce_target].xrcdseq2 = NULL
               LET g_mmfe3_d[li_reproduce_target].xrcd007 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmfe3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmfe3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mmfe4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmfe4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt450_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmfe4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            CALL cl_showmsg_init()
            NEXT FIELD rtia001
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmfe4_d[l_ac].* TO NULL 
            INITIALIZE g_mmfe4_d_t.* TO NULL 
            INITIALIZE g_mmfe4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_mmfe4_d_t.* = g_mmfe4_d[l_ac].*     #新輸入資料
            LET g_mmfe4_d_o.* = g_mmfe4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt450_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt450_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmfe4_d[li_reproduce_target].* = g_mmfe4_d[li_reproduce].*
 
               LET g_mmfe4_d[li_reproduce_target].rtieseq = NULL
               LET g_mmfe4_d[li_reproduce_target].rtieseq1 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[4] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 4
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammt450_cl USING g_enterprise,g_rtia_m.rtiadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt450_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt450_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmfe4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmfe4_d[l_ac].rtieseq IS NOT NULL
               AND g_mmfe4_d[l_ac].rtieseq1 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmfe4_d_t.* = g_mmfe4_d[l_ac].*  #BACKUP
               LET g_mmfe4_d_o.* = g_mmfe4_d[l_ac].*  #BACKUP
               CALL ammt450_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL ammt450_set_no_entry_b(l_cmd)
               IF NOT ammt450_lock_b("rtie_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt450_bcl4 INTO g_mmfe4_d[l_ac].rtieseq,g_mmfe4_d[l_ac].rtieseq1,g_mmfe4_d[l_ac].rtie001, 
                      g_mmfe4_d[l_ac].rtie002,g_mmfe4_d[l_ac].rtie006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmfe4_d_mask_o[l_ac].* =  g_mmfe4_d[l_ac].*
                  CALL ammt450_rtie_t_mask()
                  LET g_mmfe4_d_mask_n[l_ac].* =  g_mmfe4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt450_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rtia_m.rtiadocno
               LET gs_keys[gs_keys.getLength()+1] = g_mmfe4_d_t.rtieseq
               LET gs_keys[gs_keys.getLength()+1] = g_mmfe4_d_t.rtieseq1
            
               #刪除同層單身
               IF NOT ammt450_delete_b('rtie_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt450_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt450_key_delete_b(gs_keys,'rtie_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt450_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt450_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_mmfe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmfe4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身4新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM rtie_t 
             WHERE rtieent = g_enterprise AND rtiedocno = g_rtia_m.rtiadocno
               AND rtieseq = g_mmfe4_d[l_ac].rtieseq
               AND rtieseq1 = g_mmfe4_d[l_ac].rtieseq1
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys[2] = g_mmfe4_d[g_detail_idx].rtieseq
               LET gs_keys[3] = g_mmfe4_d[g_detail_idx].rtieseq1
               CALL ammt450_insert_b('rtie_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmfe_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt450_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmfe4_d[l_ac].* = g_mmfe4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt450_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmfe4_d[l_ac].* = g_mmfe4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL ammt450_rtie_t_mask_restore('restore_mask_o')
                              
               UPDATE rtie_t SET (rtiedocno,rtieseq,rtieseq1,rtie001,rtie002,rtie006) = (g_rtia_m.rtiadocno, 
                   g_mmfe4_d[l_ac].rtieseq,g_mmfe4_d[l_ac].rtieseq1,g_mmfe4_d[l_ac].rtie001,g_mmfe4_d[l_ac].rtie002, 
                   g_mmfe4_d[l_ac].rtie006) #自訂欄位頁簽
                WHERE rtieent = g_enterprise AND rtiedocno = g_rtia_m.rtiadocno
                  AND rtieseq = g_mmfe4_d_t.rtieseq #項次 
                  AND rtieseq1 = g_mmfe4_d_t.rtieseq1
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmfe4_d[l_ac].* = g_mmfe4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtie_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmfe4_d[l_ac].* = g_mmfe4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys_bak[1] = g_rtiadocno_t
               LET gs_keys[2] = g_mmfe4_d[g_detail_idx].rtieseq
               LET gs_keys_bak[2] = g_mmfe4_d_t.rtieseq
               LET gs_keys[3] = g_mmfe4_d[g_detail_idx].rtieseq1
               LET gs_keys_bak[3] = g_mmfe4_d_t.rtieseq1
               CALL ammt450_update_b('rtie_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammt450_rtie_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmfe4_d[g_detail_idx].rtieseq = g_mmfe4_d_t.rtieseq 
                  AND g_mmfe4_d[g_detail_idx].rtieseq1 = g_mmfe4_d_t.rtieseq1 
                  ) THEN
                  LET gs_keys[01] = g_rtia_m.rtiadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mmfe4_d_t.rtieseq
                  LET gs_keys[gs_keys.getLength()+1] = g_mmfe4_d_t.rtieseq1
                  CALL ammt450_key_update_b(gs_keys,'rtie_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_mmfe4_d_t)
               LET g_log2 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_mmfe4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtieseq
            #add-point:BEFORE FIELD rtieseq name="input.b.page4.rtieseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtieseq
            
            #add-point:AFTER FIELD rtieseq name="input.a.page4.rtieseq"
            #此段落由子樣板a05產生
            IF  g_rtia_m.rtiadocno IS NOT NULL AND g_mmfe4_d[g_detail_idx].rtieseq IS NOT NULL AND g_mmfe4_d[g_detail_idx].rtieseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t OR g_mmfe4_d[g_detail_idx].rtieseq != g_mmfe4_d_t.rtieseq OR g_mmfe4_d[g_detail_idx].rtieseq1 != g_mmfe4_d_t.rtieseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtie_t WHERE "||"rtieent = '" ||g_enterprise|| "' AND "||"rtiedocno = '"||g_rtia_m.rtiadocno ||"' AND "|| "rtieseq = '"||g_mmfe4_d[g_detail_idx].rtieseq ||"' AND "|| "rtieseq1 = '"||g_mmfe4_d[g_detail_idx].rtieseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtieseq
            #add-point:ON CHANGE rtieseq name="input.g.page4.rtieseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtieseq1
            #add-point:BEFORE FIELD rtieseq1 name="input.b.page4.rtieseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtieseq1
            
            #add-point:AFTER FIELD rtieseq1 name="input.a.page4.rtieseq1"
            #此段落由子樣板a05產生
            IF  g_rtia_m.rtiadocno IS NOT NULL AND g_mmfe4_d[g_detail_idx].rtieseq IS NOT NULL AND g_mmfe4_d[g_detail_idx].rtieseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t OR g_mmfe4_d[g_detail_idx].rtieseq != g_mmfe4_d_t.rtieseq OR g_mmfe4_d[g_detail_idx].rtieseq1 != g_mmfe4_d_t.rtieseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtie_t WHERE "||"rtieent = '" ||g_enterprise|| "' AND "||"rtiedocno = '"||g_rtia_m.rtiadocno ||"' AND "|| "rtieseq = '"||g_mmfe4_d[g_detail_idx].rtieseq ||"' AND "|| "rtieseq1 = '"||g_mmfe4_d[g_detail_idx].rtieseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtieseq1
            #add-point:ON CHANGE rtieseq1 name="input.g.page4.rtieseq1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtie001
            #add-point:BEFORE FIELD rtie001 name="input.b.page4.rtie001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtie001
            
            #add-point:AFTER FIELD rtie001 name="input.a.page4.rtie001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtie001
            #add-point:ON CHANGE rtie001 name="input.g.page4.rtie001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtie002
            
            #add-point:AFTER FIELD rtie002 name="input.a.page4.rtie002"
            CALL s_desc_get_ooial_desc(g_mmfe4_d[l_ac].rtie002) RETURNING g_mmfe4_d[l_ac].rtie002_desc
            DISPLAY BY NAME g_mmfe4_d[l_ac].rtie002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtie002
            #add-point:BEFORE FIELD rtie002 name="input.b.page4.rtie002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtie002
            #add-point:ON CHANGE rtie002 name="input.g.page4.rtie002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtie006
            #add-point:BEFORE FIELD rtie006 name="input.b.page4.rtie006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtie006
            
            #add-point:AFTER FIELD rtie006 name="input.a.page4.rtie006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtie006
            #add-point:ON CHANGE rtie006 name="input.g.page4.rtie006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.rtieseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtieseq
            #add-point:ON ACTION controlp INFIELD rtieseq name="input.c.page4.rtieseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.rtieseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtieseq1
            #add-point:ON ACTION controlp INFIELD rtieseq1 name="input.c.page4.rtieseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.rtie001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtie001
            #add-point:ON ACTION controlp INFIELD rtie001 name="input.c.page4.rtie001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.rtie002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtie002
            #add-point:ON ACTION controlp INFIELD rtie002 name="input.c.page4.rtie002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.rtie006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtie006
            #add-point:ON ACTION controlp INFIELD rtie006 name="input.c.page4.rtie006"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmfe4_d[l_ac].* = g_mmfe4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt450_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammt450_unlock_b("rtie_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmfe4_d[li_reproduce_target].* = g_mmfe4_d[li_reproduce].*
 
               LET g_mmfe4_d[li_reproduce_target].rtieseq = NULL
               LET g_mmfe4_d[li_reproduce_target].rtieseq1 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmfe4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmfe4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="ammt450.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD rtiasite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmfeseq
               WHEN "s_detail2"
                  NEXT FIELD rtibseq
 
               WHEN "s_detail3"
                  NEXT FIELD xrcd007
 
               WHEN "s_detail4"
                  NEXT FIELD rtieseq
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD rtiadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmfeseq
               WHEN "s_detail2"
                  NEXT FIELD rtibseq
               WHEN "s_detail3"
                  NEXT FIELD xrcd007
               WHEN "s_detail4"
                  NEXT FIELD rtieseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
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
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION ammt450_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL ammt450_b_fill() #單身填充
      CALL ammt450_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL ammt450_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL ammt450_rtia001_ref()
   #150907-00033#2 20150925 mark by beckxie---S
   #CALL s_desc_get_department_desc(g_rtia_m.rtiasite) RETURNING g_rtia_m.rtiasite_desc
   #DISPLAY BY NAME g_rtia_m.rtiasite_desc
   #CALL s_desc_get_mman_desc(g_rtia_m.rtia042) RETURNING g_rtia_m.rtia042_desc
   #DISPLAY BY NAME g_rtia_m.rtia042_desc
   #CALL ammt450_rtia044_ref()
   #150907-00033#2 20150925 mark by beckxie---E
   CALL ammt450_rtia0461()
   #151111-00021#1 20151112 add by beckxie---S
   CALL ammt450_rtia036_ref()
   CALL ammt450_rtia037_ref()
   CALL ammt450_rtia038_ref()
   #151111-00021#1 20151112 add by beckxie---E
   CALL ammt450_carry_mmby()
   #160705-00042#9 160713 by sakura mark(S)
   #CASE g_prog_name
   #   #積點
   #   WHEN 'ammt450'
   #160705-00042#9 160713 by sakura mark(E)
   #160705-00042#9 160713 by sakura add(S)
   CASE 
      #積點
      WHEN g_prog_name MATCHES 'ammt450'   
   #160705-00042#9 160713 by sakura add(E)
         #兌換後剩餘積點
         #卡積點餘額rtia043-此次兌換積點rtia047
         LET g_rtia_m.rtia0471 = g_rtia_m.rtia043 - g_rtia_m.rtia047
      
      #累計消費額
      #其他兌換
      OTHERWISE
         #兌換後剩餘積點
         #該規則計算總累消 rtia046 - 此次兌換積點rtia047
         LET g_rtia_m.rtia0471 = g_rtia_m.rtia046 - g_rtia_m.rtia047
   END CASE
   #150907-00033#2 20150925 mark by beckxie---S
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_rtia_m.rtiaownid
   #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   #LET g_rtia_m.rtiaownid_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_rtia_m.rtiaownid_desc
   #
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_rtia_m.rtiaowndp
   #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #LET g_rtia_m.rtiaowndp_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_rtia_m.rtiaowndp_desc
   #
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_rtia_m.rtiacrtid
   #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   #LET g_rtia_m.rtiacrtid_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_rtia_m.rtiacrtid_desc
   #
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_rtia_m.rtiacrtdp
   #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #LET g_rtia_m.rtiacrtdp_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_rtia_m.rtiacrtdp_desc
   #
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_rtia_m.rtiamodid
   #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   #LET g_rtia_m.rtiamodid_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_rtia_m.rtiamodid_desc
   #
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_rtia_m.rtiacnfid
   #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   #LET g_rtia_m.rtiacnfid_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_rtia_m.rtiacnfid_desc
   #
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_rtia_m.rtiapstid
   #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   #LET g_rtia_m.rtiapstid_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_rtia_m.rtiapstid_desc
   #150907-00033#2 20150925 mark by beckxie---E
   #end add-point
   
   #遮罩相關處理
   LET g_rtia_m_mask_o.* =  g_rtia_m.*
   CALL ammt450_rtia_t_mask()
   LET g_rtia_m_mask_n.* =  g_rtia_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc,g_rtia_m.rtiadocdt,g_rtia_m.rtia035,g_rtia_m.rtiadocno, 
       g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia001_desc,g_rtia_m.rtia042,g_rtia_m.rtia042_desc, 
       g_rtia_m.rtia043,g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia044_desc,g_rtia_m.mmby006,g_rtia_m.rtia041, 
       g_rtia_m.rtiastus,g_rtia_m.mmby009,g_rtia_m.mmby010,g_rtia_m.mmby011,g_rtia_m.mmby012,g_rtia_m.mmby013, 
       g_rtia_m.rtia007,g_rtia_m.rtia066,g_rtia_m.rtia046,g_rtia_m.rtia0461,g_rtia_m.rtia047,g_rtia_m.rtia0471, 
       g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000,g_rtia_m.rtia026,g_rtia_m.rtia027, 
       g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036,g_rtia_m.rtia036_desc,g_rtia_m.rtia037, 
       g_rtia_m.rtia037_desc,g_rtia_m.rtia038,g_rtia_m.rtia038_desc,g_rtia_m.rtia039,g_rtia_m.isaf009, 
       g_rtia_m.isaf013,g_rtia_m.isaf044,g_rtia_m.isaf202,g_rtia_m.isaf203,g_rtia_m.isaf204,g_rtia_m.isaf201, 
       g_rtia_m.isaf207,g_rtia_m.rtiaownid,g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp,g_rtia_m.rtiaowndp_desc, 
       g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdp_desc,g_rtia_m.rtiacrtdt, 
       g_rtia_m.rtiamodid,g_rtia_m.rtiamodid_desc,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfid_desc, 
       g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstid_desc,g_rtia_m.rtiapstdt,g_rtia_m.sum1, 
       g_rtia_m.sum2,g_rtia_m.sum3,g_rtia_m.sum4
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtia_m.rtiastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
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
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mmfe_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #150907-00033#2 20150925 mark by beckxie---S
      #CALL ammt450_mmfe001_ref()
      #CALL s_desc_get_acc_desc('2071',g_mmfe_d[l_ac].mmfe003) RETURNING g_mmfe_d[l_ac].mmfe003_desc
      #DISPLAY BY NAME g_mmfe_d[l_ac].mmfe003_desc
      #CALL ammt450_mmfe013_ref()
      #150907-00033#2 20150925 mark by beckxie---E
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mmfe2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      #150907-00033#2 20150925 mark by beckxie---S
      #CALL ammt450_rtib004_ref()
      #CALL s_desc_get_unit_desc(g_mmfe2_d[l_ac].rtib013) RETURNING g_mmfe2_d[l_ac].rtib013_desc
      #DISPLAY BY NAME g_mmfe2_d[l_ac].rtib013_desc
      #CALL s_desc_get_unit_desc(g_mmfe2_d[l_ac].rtib015) RETURNING g_mmfe2_d[l_ac].rtib015_desc
      #DISPLAY BY NAME g_mmfe2_d[l_ac].rtib015_desc
      #CALL s_desc_get_unit_desc(g_mmfe2_d[l_ac].rtib018) RETURNING g_mmfe2_d[l_ac].rtib018_desc
      #DISPLAY BY NAME g_mmfe2_d[l_ac].rtib018_desc
      #CALL s_desc_get_stock_desc(g_rtia_m.rtiasite,g_mmfe2_d[l_ac].rtib025) RETURNING g_mmfe2_d[l_ac].rtib025_desc
      #DISPLAY BY NAME g_mmfe2_d[l_ac].rtib025_desc
      #150907-00033#2 20150925 mark by beckxie---E
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mmfe3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      #150907-00033#2 20150925 mark by beckxie---S
      #CALL s_desc_get_tax_desc1(g_rtia_m.rtiasite,g_mmfe3_d[l_ac].xrcd002) RETURNING g_mmfe3_d[l_ac].xrcd002_desc
      #DISPLAY BY NAME g_mmfe3_d[l_ac].xrcd002_desc
      #150907-00033#2 20150925 mark by beckxie---E
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mmfe4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      #150907-00033#2 20150925 mark by beckxie---S
      #CALL s_desc_get_ooial_desc(g_mmfe4_d[l_ac].rtie002) RETURNING g_mmfe4_d[l_ac].rtie002_desc
      #DISPLAY BY NAME g_mmfe4_d[l_ac].rtie002_desc
      #150907-00033#2 20150925 mark by beckxie---E
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL ammt450_detail_show()
 
   #add-point:show段之後 name="show.after"
   LET g_rtia_m.sum1 = ''
   LET g_rtia_m.sum2 = ''
   LET g_rtia_m.sum3 = ''
   LET g_rtia_m.sum4 = ''
   SELECT SUM(rtib012),SUM(rtib008*rtib012),SUM(rtib020),SUM(rtib021)
     INTO g_rtia_m.sum1,g_rtia_m.sum2,g_rtia_m.sum3,g_rtia_m.sum4
     FROM rtib_t
    WHERE rtibent = g_enterprise
      AND rtibdocno = g_rtia_m.rtiadocno
   DISPLAY g_rtia_m.sum1 TO FORMONLY.sum1
   DISPLAY g_rtia_m.sum2 TO FORMONLY.sum2
   DISPLAY g_rtia_m.sum3 TO FORMONLY.sum3
   DISPLAY g_rtia_m.sum4 TO FORMONLY.sum4
   #應收金額=0
   IF cl_null(g_rtia_m.sum4) OR g_rtia_m.sum4 = 0 THEN
      CALL cl_set_act_visible("ammt450_s_pay",FALSE)
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION ammt450_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION ammt450_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rtia_t.rtiadocno 
   DEFINE l_oldno     LIKE rtia_t.rtiadocno 
 
   DEFINE l_master    RECORD LIKE rtia_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mmfe_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rtib_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xrcd_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE rtie_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_doctype       LIKE rtai_t.rtai004
   DEFINE l_insert        LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_rtia_m.rtiadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
    
   LET g_rtia_m.rtiadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtia_m.rtiaownid = g_user
      LET g_rtia_m.rtiaowndp = g_dept
      LET g_rtia_m.rtiacrtid = g_user
      LET g_rtia_m.rtiacrtdp = g_dept 
      LET g_rtia_m.rtiacrtdt = cl_get_current()
      LET g_rtia_m.rtiamodid = g_user
      LET g_rtia_m.rtiamoddt = cl_get_current()
      LET g_rtia_m.rtiastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   CALL s_aooi500_default(g_prog_name,'rtiasite',g_rtia_m.rtiasite)
      RETURNING l_insert,g_rtia_m.rtiasite
   IF l_insert = FALSE THEN
      RETURN
   END IF
   CALL s_aooi500_default(g_prog_name,'rtiaunit',g_rtia_m.rtiasite)
      RETURNING l_insert,g_rtia_m.rtiaunit
   IF l_insert = FALSE THEN
      RETURN
   END IF
   CALL s_desc_get_department_desc(g_rtia_m.rtiasite) RETURNING g_rtia_m.rtiasite_desc
   DISPLAY BY NAME g_rtia_m.rtiasite_desc
   LET g_rtia_m.rtiadocdt = g_today
   LET g_rtia_m.rtia035 = cl_get_time()
   LET g_rtia_m.rtia000 = g_prog_name
   LET g_rtia_m.rtia032 = '1'
   
   #預設單據的單別
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_rtia_m.rtiasite,g_prog_name,'1') 
      RETURNING l_success,l_doctype
      
   LET g_ooef004 = ''
   LET g_ooef015 = ''
   LET g_ooef016 = ''
   LET g_ooef019 = ''
   LET g_ooef108 = ''
   SELECT ooef004,ooef015,ooef016,ooef019,ooef108
     INTO g_ooef004,g_ooef015,g_ooef016,g_ooef019,g_ooef108
     FROM ooef_t
    WHERE ooef001 = g_rtia_m.rtiasite
      AND ooefent = g_enterprise
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_rtia_m.rtiasite
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   LET g_rtia_m_t.* = g_rtia_m.*
   LET g_rtia_m_o.* = g_rtia_m.*
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtia_m.rtiastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
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
 
 
 
   
   #清空key欄位的desc
   
   
   CALL ammt450_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rtia_m.* TO NULL
      INITIALIZE g_mmfe_d TO NULL
      INITIALIZE g_mmfe2_d TO NULL
      INITIALIZE g_mmfe3_d TO NULL
      INITIALIZE g_mmfe4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL ammt450_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt450_set_act_visible()   
   CALL ammt450_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtiaent = " ||g_enterprise|| " AND",
                      " rtiadocno = '", g_rtia_m.rtiadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt450_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL ammt450_idx_chk()
   
   LET g_data_owner = g_rtia_m.rtiaownid      
   LET g_data_dept  = g_rtia_m.rtiaowndp
   
   #功能已完成,通報訊息中心
   CALL ammt450_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION ammt450_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mmfe_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rtib_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xrcd_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE rtie_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE ammt450_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmfe_t
    WHERE mmfeent = g_enterprise AND mmfedocno = g_rtiadocno_t
 
    INTO TEMP ammt450_detail
 
   #將key修正為調整後   
   UPDATE ammt450_detail 
      #更新key欄位
      SET mmfedocno = g_rtia_m.rtiadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mmfe_t SELECT * FROM ammt450_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt450_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtib_t 
    WHERE rtibent = g_enterprise AND rtibdocno = g_rtiadocno_t
 
    INTO TEMP ammt450_detail
 
   #將key修正為調整後   
   UPDATE ammt450_detail SET rtibdocno = g_rtia_m.rtiadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rtib_t SELECT * FROM ammt450_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt450_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrcd_t 
    WHERE xrcdent = g_enterprise AND xrcddocno = g_rtiadocno_t
 
    INTO TEMP ammt450_detail
 
   #將key修正為調整後   
   UPDATE ammt450_detail SET xrcddocno = g_rtia_m.rtiadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xrcd_t SELECT * FROM ammt450_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt450_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtie_t 
    WHERE rtieent = g_enterprise AND rtiedocno = g_rtiadocno_t
 
    INTO TEMP ammt450_detail
 
   #將key修正為調整後   
   UPDATE ammt450_detail SET rtiedocno = g_rtia_m.rtiadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rtie_t SELECT * FROM ammt450_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt450_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammt450_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_cnt           LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_rtia_m.rtiadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN ammt450_cl USING g_enterprise,g_rtia_m.rtiadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt450_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt450_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt450_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtia035,g_rtia_m.rtiadocno,g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043, 
       g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia041,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia066, 
       g_rtia_m.rtia046,g_rtia_m.rtia047,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000, 
       g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036, 
       g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtiaownid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtid, 
       g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid, 
       g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia001_desc, 
       g_rtia_m.rtia042_desc,g_rtia_m.rtia044_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT ammt450_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtia_m_mask_o.* =  g_rtia_m.*
   CALL ammt450_rtia_t_mask()
   LET g_rtia_m_mask_n.* =  g_rtia_m.*
   
   CALL ammt450_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM rtie_t
       WHERE rtieent = g_enterprise
         AND rtiedocno = g_rtia_m.rtiadocno
      IF l_cnt >= 1 THEN
         #此單據已有收款明細，無法進行單據刪除的動作！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00288'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammt450_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
 
      DELETE FROM rtia_t
       WHERE rtiaent = g_enterprise AND rtiadocno = g_rtia_m.rtiadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rtia_m.rtiadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_rtia_m.rtiadocno,g_rtia_m.rtiadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mmfe_t
       WHERE mmfeent = g_enterprise AND mmfedocno = g_rtia_m.rtiadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmfe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      DELETE FROM rtib_t
       WHERE rtibent = g_enterprise AND rtibdocno = g_rtia_m.rtiadocno
         AND rtibseq = g_mmfe_d_t.mmfeseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "rtib_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF   
      
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise AND xrcddocno = g_rtia_m.rtiadocno
         AND xrcdseq = g_mmfe_d_t.mmfeseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "xrcd_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      CALL ammt450_recount_point()
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM rtib_t
       WHERE rtibent = g_enterprise AND
             rtibdocno = g_rtia_m.rtiadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise AND
             xrcddocno = g_rtia_m.rtiadocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
      
      #end add-point
      DELETE FROM rtie_t
       WHERE rtieent = g_enterprise AND
             rtiedocno = g_rtia_m.rtiadocno
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rtia_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE ammt450_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mmfe_d.clear() 
      CALL g_mmfe2_d.clear()       
      CALL g_mmfe3_d.clear()       
      CALL g_mmfe4_d.clear()       
 
     
      CALL ammt450_ui_browser_refresh()  
      #CALL ammt450_ui_headershow()  
      #CALL ammt450_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL ammt450_browser_fill("")
         CALL ammt450_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE ammt450_cl
 
   #功能已完成,通報訊息中心
   CALL ammt450_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="ammt450.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammt450_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mmfe_d.clear()
   CALL g_mmfe2_d.clear()
   CALL g_mmfe3_d.clear()
   CALL g_mmfe4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql =  "SELECT rtib003,rtib004 FROM rtib_t",
                " WHERE rtibent = ",g_enterprise,
                "   AND rtibdocno = '",g_rtia_m.rtiadocno,"'",
                "   AND rtibseq = ?"
   PREPARE ammt450_rtib FROM g_sql
   DECLARE ammt450_rtib_curs CURSOR FOR ammt450_rtib
   #end add-point
   
   #判斷是否填充
   IF ammt450_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmfeseq,mmfe001,mmfe003,mmfe004,mmfe005,mmfe006,mmfe007,mmfe008, 
             mmfe009,mmfe010,mmfe011,mmfe012,mmfe013 ,t1.imaal003 ,t2.oocql004 ,t3.inayl003 FROM mmfe_t", 
                
                     " INNER JOIN rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = mmfedocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=mmfe001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2071' AND t2.oocql002=mmfe003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t3 ON t3.inaylent="||g_enterprise||" AND t3.inayl001=mmfe010 AND t3.inayl002='"||g_dlang||"' ",
 
                     " WHERE mmfeent=? AND mmfedocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmfe_t.mmfeseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt450_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR ammt450_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rtia_m.rtiadocno INTO g_mmfe_d[l_ac].mmfeseq,g_mmfe_d[l_ac].mmfe001, 
          g_mmfe_d[l_ac].mmfe003,g_mmfe_d[l_ac].mmfe004,g_mmfe_d[l_ac].mmfe005,g_mmfe_d[l_ac].mmfe006, 
          g_mmfe_d[l_ac].mmfe007,g_mmfe_d[l_ac].mmfe008,g_mmfe_d[l_ac].mmfe009,g_mmfe_d[l_ac].mmfe010, 
          g_mmfe_d[l_ac].mmfe011,g_mmfe_d[l_ac].mmfe012,g_mmfe_d[l_ac].mmfe013,g_mmfe_d[l_ac].mmfe001_desc, 
          g_mmfe_d[l_ac].mmfe003_desc,g_mmfe_d[l_ac].mmfe010_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL ammt450_mmfe013_ref()   #150907-00033#2 20150925 add by beckxie
         #150907-00033#2 20151013 mark by beckxie---S
         #CALL s_desc_get_acc_desc('2071',g_mmfe_d[l_ac].mmfe003) RETURNING g_mmfe_d[l_ac].mmfe003_desc
         #DISPLAY BY NAME g_mmfe_d[l_ac].mmfe003_desc
         #CALL s_desc_get_stock_desc(g_rtia_m.rtiasite,g_mmfe_d[l_ac].mmfe010) RETURNING g_mmfe_d[l_ac].mmfe010_desc
         #DISPLAY BY NAME g_mmfe_d[l_ac].mmfe010_desc
         #150907-00033#2 20151013 mark by beckxie---E
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF ammt450_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtibseq,rtib003,rtib004,rtib006,rtib008,rtib009,rtib010,rtib012, 
             rtib013,rtib018,rtib015,rtib016,rtib019,rtib020,rtib021,rtib022,rtib025,rtib030 ,t4.imaal003 , 
             t5.oodbl004 ,t6.oocal003 ,t7.oocal003 ,t8.oocal003 ,t9.inayl003 FROM rtib_t",   
                     " INNER JOIN  rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = rtibdocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=rtib004 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oodbl_t t5 ON t5.oodblent="||g_enterprise||" AND t5.oodbl001='2' AND t5.oodbl002=rtib006 AND t5.oodbl003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=rtib013 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=rtib018 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t8 ON t8.oocalent="||g_enterprise||" AND t8.oocal001=rtib015 AND t8.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t9 ON t9.inaylent="||g_enterprise||" AND t9.inayl001=rtib025 AND t9.inayl002='"||g_dlang||"' ",
 
                     " WHERE rtibent=? AND rtibdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtib_t.rtibseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt450_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR ammt450_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_rtia_m.rtiadocno INTO g_mmfe2_d[l_ac].rtibseq,g_mmfe2_d[l_ac].rtib003, 
          g_mmfe2_d[l_ac].rtib004,g_mmfe2_d[l_ac].rtib006,g_mmfe2_d[l_ac].rtib008,g_mmfe2_d[l_ac].rtib009, 
          g_mmfe2_d[l_ac].rtib010,g_mmfe2_d[l_ac].rtib012,g_mmfe2_d[l_ac].rtib013,g_mmfe2_d[l_ac].rtib018, 
          g_mmfe2_d[l_ac].rtib015,g_mmfe2_d[l_ac].rtib016,g_mmfe2_d[l_ac].rtib019,g_mmfe2_d[l_ac].rtib020, 
          g_mmfe2_d[l_ac].rtib021,g_mmfe2_d[l_ac].rtib022,g_mmfe2_d[l_ac].rtib025,g_mmfe2_d[l_ac].rtib030, 
          g_mmfe2_d[l_ac].rtib004_desc,g_mmfe2_d[l_ac].rtib006_desc,g_mmfe2_d[l_ac].rtib013_desc,g_mmfe2_d[l_ac].rtib018_desc, 
          g_mmfe2_d[l_ac].rtib015_desc,g_mmfe2_d[l_ac].rtib025_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL s_desc_get_tax_desc1(g_rtia_m.rtiasite,g_mmfe2_d[l_ac].rtib006) RETURNING g_mmfe2_d[l_ac].rtib006_desc
         DISPLAY BY NAME g_mmfe2_d[l_ac].rtib006_desc
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF ammt450_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrcd007,xrcdld,xrcdseq,xrcdseq2,xrcd002,xrcd003,xrcd006,xrcd004, 
             xrcd104 ,t11.oodbl004 FROM xrcd_t",   
                     " INNER JOIN  rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = xrcddocno ",
 
                     "",
                     
                                    " LEFT JOIN oodbl_t t11 ON t11.oodblent="||g_enterprise||" AND t11.oodbl001='' AND t11.oodbl002=xrcd002 AND t11.oodbl003='"||g_dlang||"' ",
 
                     " WHERE xrcdent=? AND xrcddocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrcd_t.xrcdld,xrcd_t.xrcdseq,xrcd_t.xrcdseq2,xrcd_t.xrcd007"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt450_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR ammt450_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_rtia_m.rtiadocno INTO g_mmfe3_d[l_ac].xrcd007,g_mmfe3_d[l_ac].xrcdld, 
          g_mmfe3_d[l_ac].xrcdseq,g_mmfe3_d[l_ac].xrcdseq2,g_mmfe3_d[l_ac].xrcd002,g_mmfe3_d[l_ac].xrcd003, 
          g_mmfe3_d[l_ac].xrcd006,g_mmfe3_d[l_ac].xrcd004,g_mmfe3_d[l_ac].xrcd104,g_mmfe3_d[l_ac].xrcd002_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         EXECUTE ammt450_rtib_curs USING g_mmfe3_d[l_ac].xrcdseq INTO g_mmfe3_d[l_ac].rtib0031,g_mmfe3_d[l_ac].rtib0041
         CALL ammt450_rtib0041_ref()
         CALL s_desc_get_tax_desc1(g_rtia_m.rtiasite,g_mmfe3_d[l_ac].xrcd002) RETURNING g_mmfe3_d[l_ac].xrcd002_desc
         DISPLAY BY NAME g_mmfe3_d[l_ac].xrcd002_desc
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF ammt450_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtieseq,rtieseq1,rtie001,rtie002,rtie006 ,t13.ooial003 FROM rtie_t", 
                
                     " INNER JOIN  rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = rtiedocno ",
 
                     "",
                     
                                    " LEFT JOIN ooial_t t13 ON t13.ooialent="||g_enterprise||" AND t13.ooial001=rtie002 AND t13.ooial002='"||g_dlang||"' ",
 
                     " WHERE rtieent=? AND rtiedocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtie_t.rtieseq,rtie_t.rtieseq1"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt450_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR ammt450_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_rtia_m.rtiadocno INTO g_mmfe4_d[l_ac].rtieseq,g_mmfe4_d[l_ac].rtieseq1, 
          g_mmfe4_d[l_ac].rtie001,g_mmfe4_d[l_ac].rtie002,g_mmfe4_d[l_ac].rtie006,g_mmfe4_d[l_ac].rtie002_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
         EXECUTE ammt450_rtib_curs USING g_mmfe4_d[l_ac].rtieseq INTO g_mmfe4_d[l_ac].rtib0032,g_mmfe4_d[l_ac].rtib0042
         CALL ammt450_rtib0042_ref()
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_mmfe_d.deleteElement(g_mmfe_d.getLength())
   CALL g_mmfe2_d.deleteElement(g_mmfe2_d.getLength())
   CALL g_mmfe3_d.deleteElement(g_mmfe3_d.getLength())
   CALL g_mmfe4_d.deleteElement(g_mmfe4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE ammt450_pb
   FREE ammt450_pb2
 
   FREE ammt450_pb3
 
   FREE ammt450_pb4
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mmfe_d.getLength()
      LET g_mmfe_d_mask_o[l_ac].* =  g_mmfe_d[l_ac].*
      CALL ammt450_mmfe_t_mask()
      LET g_mmfe_d_mask_n[l_ac].* =  g_mmfe_d[l_ac].*
   END FOR
   
   LET g_mmfe2_d_mask_o.* =  g_mmfe2_d.*
   FOR l_ac = 1 TO g_mmfe2_d.getLength()
      LET g_mmfe2_d_mask_o[l_ac].* =  g_mmfe2_d[l_ac].*
      CALL ammt450_rtib_t_mask()
      LET g_mmfe2_d_mask_n[l_ac].* =  g_mmfe2_d[l_ac].*
   END FOR
   LET g_mmfe3_d_mask_o.* =  g_mmfe3_d.*
   FOR l_ac = 1 TO g_mmfe3_d.getLength()
      LET g_mmfe3_d_mask_o[l_ac].* =  g_mmfe3_d[l_ac].*
      CALL ammt450_xrcd_t_mask()
      LET g_mmfe3_d_mask_n[l_ac].* =  g_mmfe3_d[l_ac].*
   END FOR
   LET g_mmfe4_d_mask_o.* =  g_mmfe4_d.*
   FOR l_ac = 1 TO g_mmfe4_d.getLength()
      LET g_mmfe4_d_mask_o[l_ac].* =  g_mmfe4_d[l_ac].*
      CALL ammt450_rtie_t_mask()
      LET g_mmfe4_d_mask_n[l_ac].* =  g_mmfe4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammt450_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   DEFINE l_cnt       LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM rtie_t
    WHERE rtieent = g_enterprise
      AND rtiedocno = g_rtia_m.rtiadocno
   IF l_cnt >= 1 THEN
      #此單據已有收款明細，無法進行單據刪除的動作！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00288'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
      #end add-point    
      DELETE FROM mmfe_t
       WHERE mmfeent = g_enterprise AND
         mmfedocno = ps_keys_bak[1] AND mmfeseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mmfe_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM rtib_t
       WHERE rtibent = g_enterprise AND
             rtibdocno = ps_keys_bak[1] AND rtibseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mmfe2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise AND
             xrcddocno = ps_keys_bak[1] AND xrcdld = ps_keys_bak[2] AND xrcdseq = ps_keys_bak[3] AND xrcdseq2 = ps_keys_bak[4] AND xrcd007 = ps_keys_bak[5]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_mmfe3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM rtie_t
       WHERE rtieent = g_enterprise AND
             rtiedocno = ps_keys_bak[1] AND rtieseq = ps_keys_bak[2] AND rtieseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_mmfe4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammt450_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO mmfe_t
                  (mmfeent,
                   mmfedocno,
                   mmfeseq
                   ,mmfe001,mmfe003,mmfe004,mmfe005,mmfe006,mmfe007,mmfe008,mmfe009,mmfe010,mmfe011,mmfe012,mmfe013) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmfe_d[g_detail_idx].mmfe001,g_mmfe_d[g_detail_idx].mmfe003,g_mmfe_d[g_detail_idx].mmfe004, 
                       g_mmfe_d[g_detail_idx].mmfe005,g_mmfe_d[g_detail_idx].mmfe006,g_mmfe_d[g_detail_idx].mmfe007, 
                       g_mmfe_d[g_detail_idx].mmfe008,g_mmfe_d[g_detail_idx].mmfe009,g_mmfe_d[g_detail_idx].mmfe010, 
                       g_mmfe_d[g_detail_idx].mmfe011,g_mmfe_d[g_detail_idx].mmfe012,g_mmfe_d[g_detail_idx].mmfe013) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmfe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mmfe_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO rtib_t
                  (rtibent,
                   rtibdocno,
                   rtibseq
                   ,rtib003,rtib004,rtib006,rtib008,rtib009,rtib010,rtib012,rtib013,rtib018,rtib015,rtib016,rtib019,rtib020,rtib021,rtib022,rtib025,rtib030) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmfe2_d[g_detail_idx].rtib003,g_mmfe2_d[g_detail_idx].rtib004,g_mmfe2_d[g_detail_idx].rtib006, 
                       g_mmfe2_d[g_detail_idx].rtib008,g_mmfe2_d[g_detail_idx].rtib009,g_mmfe2_d[g_detail_idx].rtib010, 
                       g_mmfe2_d[g_detail_idx].rtib012,g_mmfe2_d[g_detail_idx].rtib013,g_mmfe2_d[g_detail_idx].rtib018, 
                       g_mmfe2_d[g_detail_idx].rtib015,g_mmfe2_d[g_detail_idx].rtib016,g_mmfe2_d[g_detail_idx].rtib019, 
                       g_mmfe2_d[g_detail_idx].rtib020,g_mmfe2_d[g_detail_idx].rtib021,g_mmfe2_d[g_detail_idx].rtib022, 
                       g_mmfe2_d[g_detail_idx].rtib025,g_mmfe2_d[g_detail_idx].rtib030)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mmfe2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO xrcd_t
                  (xrcdent,
                   xrcddocno,
                   xrcdld,xrcdseq,xrcdseq2,xrcd007
                   ,xrcd002,xrcd003,xrcd006,xrcd004,xrcd104) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_mmfe3_d[g_detail_idx].xrcd002,g_mmfe3_d[g_detail_idx].xrcd003,g_mmfe3_d[g_detail_idx].xrcd006, 
                       g_mmfe3_d[g_detail_idx].xrcd004,g_mmfe3_d[g_detail_idx].xrcd104)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_mmfe3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO rtie_t
                  (rtieent,
                   rtiedocno,
                   rtieseq,rtieseq1
                   ,rtie001,rtie002,rtie006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mmfe4_d[g_detail_idx].rtie001,g_mmfe4_d[g_detail_idx].rtie002,g_mmfe4_d[g_detail_idx].rtie006) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_mmfe4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammt450_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
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
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmfe_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL ammt450_mmfe_t_mask_restore('restore_mask_o')
               
      UPDATE mmfe_t 
         SET (mmfedocno,
              mmfeseq
              ,mmfe001,mmfe003,mmfe004,mmfe005,mmfe006,mmfe007,mmfe008,mmfe009,mmfe010,mmfe011,mmfe012,mmfe013) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmfe_d[g_detail_idx].mmfe001,g_mmfe_d[g_detail_idx].mmfe003,g_mmfe_d[g_detail_idx].mmfe004, 
                  g_mmfe_d[g_detail_idx].mmfe005,g_mmfe_d[g_detail_idx].mmfe006,g_mmfe_d[g_detail_idx].mmfe007, 
                  g_mmfe_d[g_detail_idx].mmfe008,g_mmfe_d[g_detail_idx].mmfe009,g_mmfe_d[g_detail_idx].mmfe010, 
                  g_mmfe_d[g_detail_idx].mmfe011,g_mmfe_d[g_detail_idx].mmfe012,g_mmfe_d[g_detail_idx].mmfe013)  
 
         WHERE mmfeent = g_enterprise AND mmfedocno = ps_keys_bak[1] AND mmfeseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmfe_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmfe_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt450_mmfe_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtib_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL ammt450_rtib_t_mask_restore('restore_mask_o')
               
      UPDATE rtib_t 
         SET (rtibdocno,
              rtibseq
              ,rtib003,rtib004,rtib006,rtib008,rtib009,rtib010,rtib012,rtib013,rtib018,rtib015,rtib016,rtib019,rtib020,rtib021,rtib022,rtib025,rtib030) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmfe2_d[g_detail_idx].rtib003,g_mmfe2_d[g_detail_idx].rtib004,g_mmfe2_d[g_detail_idx].rtib006, 
                  g_mmfe2_d[g_detail_idx].rtib008,g_mmfe2_d[g_detail_idx].rtib009,g_mmfe2_d[g_detail_idx].rtib010, 
                  g_mmfe2_d[g_detail_idx].rtib012,g_mmfe2_d[g_detail_idx].rtib013,g_mmfe2_d[g_detail_idx].rtib018, 
                  g_mmfe2_d[g_detail_idx].rtib015,g_mmfe2_d[g_detail_idx].rtib016,g_mmfe2_d[g_detail_idx].rtib019, 
                  g_mmfe2_d[g_detail_idx].rtib020,g_mmfe2_d[g_detail_idx].rtib021,g_mmfe2_d[g_detail_idx].rtib022, 
                  g_mmfe2_d[g_detail_idx].rtib025,g_mmfe2_d[g_detail_idx].rtib030) 
         WHERE rtibent = g_enterprise AND rtibdocno = ps_keys_bak[1] AND rtibseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtib_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt450_rtib_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xrcd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL ammt450_xrcd_t_mask_restore('restore_mask_o')
               
      UPDATE xrcd_t 
         SET (xrcddocno,
              xrcdld,xrcdseq,xrcdseq2,xrcd007
              ,xrcd002,xrcd003,xrcd006,xrcd004,xrcd104) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_mmfe3_d[g_detail_idx].xrcd002,g_mmfe3_d[g_detail_idx].xrcd003,g_mmfe3_d[g_detail_idx].xrcd006, 
                  g_mmfe3_d[g_detail_idx].xrcd004,g_mmfe3_d[g_detail_idx].xrcd104) 
         WHERE xrcdent = g_enterprise AND xrcddocno = ps_keys_bak[1] AND xrcdld = ps_keys_bak[2] AND xrcdseq = ps_keys_bak[3] AND xrcdseq2 = ps_keys_bak[4] AND xrcd007 = ps_keys_bak[5]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt450_xrcd_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtie_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL ammt450_rtie_t_mask_restore('restore_mask_o')
               
      UPDATE rtie_t 
         SET (rtiedocno,
              rtieseq,rtieseq1
              ,rtie001,rtie002,rtie006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mmfe4_d[g_detail_idx].rtie001,g_mmfe4_d[g_detail_idx].rtie002,g_mmfe4_d[g_detail_idx].rtie006)  
 
         WHERE rtieent = g_enterprise AND rtiedocno = ps_keys_bak[1] AND rtieseq = ps_keys_bak[2] AND rtieseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtie_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt450_rtie_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION ammt450_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION ammt450_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammt450_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL ammt450_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mmfe_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN ammt450_bcl USING g_enterprise,
                                       g_rtia_m.rtiadocno,g_mmfe_d[g_detail_idx].mmfeseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt450_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "rtib_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammt450_bcl2 USING g_enterprise,
                                             g_rtia_m.rtiadocno,g_mmfe2_d[g_detail_idx].rtibseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt450_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "xrcd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammt450_bcl3 USING g_enterprise,
                                             g_rtia_m.rtiadocno,g_mmfe3_d[g_detail_idx].xrcdld,g_mmfe3_d[g_detail_idx].xrcdseq, 
                                                 g_mmfe3_d[g_detail_idx].xrcdseq2,g_mmfe3_d[g_detail_idx].xrcd007 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt450_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "rtie_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammt450_bcl4 USING g_enterprise,
                                             g_rtia_m.rtiadocno,g_mmfe4_d[g_detail_idx].rtieseq,g_mmfe4_d[g_detail_idx].rtieseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt450_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammt450_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt450_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt450_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt450_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt450_bcl4
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION ammt450_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rtiadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rtiadocno",TRUE)
      CALL cl_set_comp_entry("rtiadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("rtiasite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("rtia001",TRUE)
   CALL cl_set_comp_entry("rtia044",TRUE)
   CALL cl_set_comp_entry("rtia046",TRUE)
   CALL cl_set_comp_entry("rtia042",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION ammt450_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rtiadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("rtiasite",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rtiadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rtiadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM mmfe_t
    WHERE mmfeent = g_enterprise
      AND mmfedocno = g_rtia_m.rtiadocno

   #160705-00042#9 160713 by sakura mark(S)
   #CASE g_prog_name
   #   WHEN 'ammt450'
   #160705-00042#9 160713 by sakura mark(E)
   #160705-00042#9 160713 by sakura add(S)
   CASE 
      WHEN g_prog_name MATCHES 'ammt450'
   #160705-00042#9 160713 by sakura add(E)
         CALL cl_set_comp_entry("rtia042",FALSE)
         IF l_cnt >= 1 THEN
            CALL cl_set_comp_entry("rtia001",FALSE)
            CALL cl_set_comp_entry("rtia044",FALSE)
         END IF
         IF cl_null(g_rtia_m.mmby009) THEN
            CALL cl_set_comp_entry("rtia046",FALSE)
         ELSE
            IF g_rtia_m.mmby009 != '2' THEN
               CALL cl_set_comp_entry("rtia046",FALSE)
            END IF
         END IF
         
      #WHEN 'ammt451'                       #160705-00042#9 160713 by sakura mark
      WHEN g_prog_name MATCHES 'ammt451'    #160705-00042#9 160713 by sakura add
         IF NOT cl_null(g_rtia_m.rtia001) THEN
            CALL cl_set_comp_entry("rtia042",FALSE)
         END IF
         IF l_cnt >= 1 THEN
            CALL cl_set_comp_entry("rtia001",FALSE)
            CALL cl_set_comp_entry("rtia042",FALSE)
            CALL cl_set_comp_entry("rtia044",FALSE)
         END IF
         IF cl_null(g_rtia_m.mmby009) THEN
            CALL cl_set_comp_entry("rtia046",FALSE)
         ELSE
            IF g_rtia_m.mmby009 != '2' THEN
               CALL cl_set_comp_entry("rtia046",FALSE)
            END IF
         END IF
         
      #WHEN 'ammt452'                      #160705-00042#9 160713 by sakura mark
      WHEN g_prog_name MATCHES 'ammt452'   #160705-00042#9 160713 by sakura add
         IF NOT cl_null(g_rtia_m.rtia001) THEN
            CALL cl_set_comp_entry("rtia042",FALSE)
         END IF
         IF l_cnt >= 1 THEN
            CALL cl_set_comp_entry("rtia001",FALSE)
            CALL cl_set_comp_entry("rtia042",FALSE)
            CALL cl_set_comp_entry("rtia044",FALSE)
         END IF
   END CASE
   
   #aooi500設定的欄位控卡
   IF NOT s_aooi500_comp_entry(g_prog_name,'rtiasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("rtiasite",FALSE)
   END IF
   IF NOT s_aooi500_comp_entry(g_prog_name,'rtiaunit') THEN
      CALL cl_set_comp_entry("rtiaunit",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammt450_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="ammt450.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammt450_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="ammt450.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION ammt450_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION ammt450_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rtia_m.rtiastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION ammt450_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION ammt450_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammt450_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " rtiadocno = '", g_argv[02], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
         INITIALIZE g_wc2_table4 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "rtia_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmfe_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtib_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "xrcd_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "rtie_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
            IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
            END IF
 
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   #160629-00009#1 160630 by sakura mark(S)
   #LET ls_wc = " rtia000 = '",g_prog_name,"' AND "
   #LET g_wc = " rtia000 = '",g_prog_name,"' "
   #160629-00009#1 160630 by sakura mark(E)
   
   #160629-00009#1 160630 by sakura add(S)
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc," AND rtia000 = '",g_prog_name,"' AND "
      LET g_wc = g_wc," AND rtia000 = '",g_prog_name,"' "
   END IF
   #160629-00009#1 160630 by sakura add(E)   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION ammt450_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_rtia031       LIKE rtia_t.rtia031
   DEFINE l_cnt           LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_rtia_m.rtiastus = 'X' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rtia_m.rtiadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN ammt450_cl USING g_enterprise,g_rtia_m.rtiadocno
   IF STATUS THEN
      CLOSE ammt450_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt450_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE ammt450_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtia035,g_rtia_m.rtiadocno,g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043, 
       g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia041,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia066, 
       g_rtia_m.rtia046,g_rtia_m.rtia047,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000, 
       g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036, 
       g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtiaownid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtid, 
       g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid, 
       g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia001_desc, 
       g_rtia_m.rtia042_desc,g_rtia_m.rtia044_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT ammt450_action_chk() THEN
      CLOSE ammt450_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc,g_rtia_m.rtiadocdt,g_rtia_m.rtia035,g_rtia_m.rtiadocno, 
       g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia001_desc,g_rtia_m.rtia042,g_rtia_m.rtia042_desc, 
       g_rtia_m.rtia043,g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia044_desc,g_rtia_m.mmby006,g_rtia_m.rtia041, 
       g_rtia_m.rtiastus,g_rtia_m.mmby009,g_rtia_m.mmby010,g_rtia_m.mmby011,g_rtia_m.mmby012,g_rtia_m.mmby013, 
       g_rtia_m.rtia007,g_rtia_m.rtia066,g_rtia_m.rtia046,g_rtia_m.rtia0461,g_rtia_m.rtia047,g_rtia_m.rtia0471, 
       g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000,g_rtia_m.rtia026,g_rtia_m.rtia027, 
       g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036,g_rtia_m.rtia036_desc,g_rtia_m.rtia037, 
       g_rtia_m.rtia037_desc,g_rtia_m.rtia038,g_rtia_m.rtia038_desc,g_rtia_m.rtia039,g_rtia_m.isaf009, 
       g_rtia_m.isaf013,g_rtia_m.isaf044,g_rtia_m.isaf202,g_rtia_m.isaf203,g_rtia_m.isaf204,g_rtia_m.isaf201, 
       g_rtia_m.isaf207,g_rtia_m.rtiaownid,g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp,g_rtia_m.rtiaowndp_desc, 
       g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdp_desc,g_rtia_m.rtiacrtdt, 
       g_rtia_m.rtiamodid,g_rtia_m.rtiamodid_desc,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfid_desc, 
       g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstid_desc,g_rtia_m.rtiapstdt,g_rtia_m.sum1, 
       g_rtia_m.sum2,g_rtia_m.sum3,g_rtia_m.sum4
 
   CASE g_rtia_m.rtiastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "Z"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
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
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_rtia_m.rtiastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "S"
               HIDE OPTION "posted"
            WHEN "Z"
               HIDE OPTION "unposted"
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
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
         
      CASE g_rtia_m.rtiastus 
         WHEN "N"
            #160613-00046#1 Modify By Ken 160614(S)
            #CALL cl_set_act_visible("unconfirmed,posted",FALSE)
            CALL cl_set_act_visible("unconfirmed,posted,approved,withdraw,rejection,signing,unposted",FALSE)
            #160613-00046#1 Modify By Ken 160614(E)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
            
         WHEN "X"
            #160613-00046#1 Modify By Ken 160614(S)
            #CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted",FALSE)
            CALL cl_set_act_visible("invalid,unconfirmed,confirmed,posted,unposted,approved,withdraw,rejection,signing",FALSE)
            #160613-00046#1 Modify By Ken 160614(E)

         WHEN "Y"
            #160613-00046#1 Modify By Ken 160614(S)
            #CALL cl_set_act_visible("invalid,confirmed",FALSE)
            CALL cl_set_act_visible("invalid,confirmed,unposted,approved,withdraw,rejection,signing",FALSE)
            #160613-00046#1 Modify By Ken 160614(E)
            
         WHEN "S"
            #160613-00046#1 Modify By Ken 160614(S)
            #CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted,approved,withdraw,rejection,signing",FALSE)
            #160613-00046#1 Modify By Ken 160614(E)
            
         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"     
            CALL cl_set_act_visible("confirmed ",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid,posted",FALSE)
            
         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"   
            CALL cl_set_act_visible("confirmed,unconfirmed,posted",FALSE)
            
         WHEN "D"  
            CALL cl_set_act_visible("confirmed,unconfirmed,posted",FALSE)
            
         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"   
            CALL cl_set_act_visible("withdraw",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted",FALSE)
            
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT ammt450_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt450_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT ammt450_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt450_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unposted
         IF cl_auth_chk_act("unposted") THEN
            LET lc_state = "Z"
            #add-point:action控制 name="statechange.unposted"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "S"
      AND lc_state <> "Z"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_rtia_m.rtiastus = lc_state OR cl_null(lc_state) THEN
      CLOSE ammt450_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_showmsg_init()
   CALL s_transaction_begin()
   OPEN ammt450_cl USING g_enterprise,g_rtia_m.rtiadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN ammt450_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE ammt450_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #未確認改確認(N->Y)
   IF lc_state = 'Y' AND g_rtia_m.rtiastus = 'N' THEN
      CALL s_ammt450_conf_chk(g_rtia_m.rtiadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_showmsg()
         CALL s_transaction_end('N','0')   #160816-00068#4
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00108') THEN
            #IF g_prog_name = 'ammt450' THEN        #160705-00042#9 160713 by sakura mark
            IF g_prog_name MATCHES 'ammt450' THEN   #160705-00042#9 160713 by sakura add
               
               #抓取應收金額
               LET l_rtia031 = ''
               SELECT rtia031 INTO l_rtia031
                 FROM rtia_t
                WHERE rtiaent = g_enterprise
                  AND rtiadocno = g_rtia_m.rtiadocno
               #                     會員卡號          異動來源          異動類別   異動單據編號   
               CALL s_card_point_add(g_rtia_m.rtia001,'1'              ,g_gzcb002 ,g_rtia_m.rtiadocno,
               #                     異動日期   異動組織           消費金額   本次異動積點   需求組織
                                     g_today,   g_rtia_m.rtiasite,l_rtia031,g_rtia_m.rtia047*(-1),g_rtia_m.rtiasite,'','') RETURNING l_success  #150505-00002#1 add '',''
               IF NOT l_success THEN 
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF 
            END IF
            CALL s_ammt450_conf_upd(g_rtia_m.rtiadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         ELSE
            CALL s_transaction_end('Y','0')
            RETURN
         END IF
      END IF
   END IF
   #確認改未確認(Y->N)
   IF lc_state = 'N' AND g_rtia_m.rtiastus = 'Y' THEN
      CALL s_ammt450_unconf_chk(g_rtia_m.rtiadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_showmsg()
         CALL s_transaction_end('N','0')   #160816-00068#4
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00110') THEN
            #IF g_prog_name = 'ammt450' THEN        #160705-00042#9 160713 by sakura mark
            IF g_prog_name MATCHES 'ammt450' THEN   #160705-00042#9 160713 by sakura add
               
               #抓取應收金額
               LET l_rtia031 = ''
               SELECT rtia031 INTO l_rtia031
                 FROM rtia_t
                WHERE rtiaent = g_enterprise
                  AND rtiadocno = g_rtia_m.rtiadocno
               CALL s_card_point_del(g_rtia_m.rtia001,g_gzcb002,g_rtia_m.rtiadocno,g_rtia_m.rtia047*(-1),'','')   #150505-00002#1 add '',''
                 RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            CALL s_ammt450_unconf_upd(g_rtia_m.rtiadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         ELSE
            CALL s_transaction_end('Y','0')
            RETURN
         END IF
      END IF
   END IF
   #未確認改無效(N->X)
   IF lc_state = 'X' AND g_rtia_m.rtiastus = 'N' THEN
      CALL s_ammt450_invalid_chk(g_rtia_m.rtiadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_showmsg()
         CALL s_transaction_end('N','0')   #160816-00068#4
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00109') THEN
            CALL s_ammt450_invalid_upd(g_rtia_m.rtiadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         ELSE
            CALL s_transaction_end('Y','0')
            RETURN
         END IF
      END IF
   END IF
   #確認改過帳(Y->S)
   IF lc_state = 'S' AND g_rtia_m.rtiastus = 'Y' THEN
      CALL s_ammt450_post_chk(g_rtia_m.rtiadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_showmsg()
         CALL s_transaction_end('N','0')   #160816-00068#4
         RETURN
      ELSE
         IF cl_ask_confirm('sub-00360') THEN
            CALL s_ammt450_post_upd(g_rtia_m.rtiadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         ELSE
            CALL s_transaction_end('Y','0')
            RETURN
         END IF
      END IF
   END IF
   #過帳改確認(S->Y)
   IF lc_state = 'Z' AND g_rtia_m.rtiastus = 'S' THEN    #160613-00046#1 Modify By Ken 160614    lc_state = 'Y'改成lc_state = 'Z'
      CALL s_ammt450_unpost_chk(g_rtia_m.rtiadocno) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_showmsg()
         CALL s_transaction_end('N','0')   #160816-00068#4
         RETURN
      ELSE
         IF cl_ask_confirm('sub-00361') THEN
            CALL s_ammt450_unpost_upd(g_rtia_m.rtiadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         ELSE
            CALL s_transaction_end('Y','0')
            RETURN
         END IF
      END IF
   END IF
   
   #end add-point
   
   LET g_rtia_m.rtiamodid = g_user
   LET g_rtia_m.rtiamoddt = cl_get_current()
   LET g_rtia_m.rtiastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rtia_t 
      SET (rtiastus,rtiamodid,rtiamoddt) 
        = (g_rtia_m.rtiastus,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt)     
    WHERE rtiaent = g_enterprise AND rtiadocno = g_rtia_m.rtiadocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
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
    
      #撈取異動後的資料
      EXECUTE ammt450_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
          g_rtia_m.rtia035,g_rtia_m.rtiadocno,g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia042,g_rtia_m.rtia043, 
          g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia041,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia066, 
          g_rtia_m.rtia046,g_rtia_m.rtia047,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000, 
          g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036, 
          g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtiaownid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtid, 
          g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid, 
          g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia001_desc, 
          g_rtia_m.rtia042_desc,g_rtia_m.rtia044_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
          g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp_desc, 
          g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc,g_rtia_m.rtiadocdt,g_rtia_m.rtia035,g_rtia_m.rtiadocno, 
          g_rtia_m.rtia006,g_rtia_m.rtia001,g_rtia_m.rtia001_desc,g_rtia_m.rtia042,g_rtia_m.rtia042_desc, 
          g_rtia_m.rtia043,g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.rtia044_desc,g_rtia_m.mmby006, 
          g_rtia_m.rtia041,g_rtia_m.rtiastus,g_rtia_m.mmby009,g_rtia_m.mmby010,g_rtia_m.mmby011,g_rtia_m.mmby012, 
          g_rtia_m.mmby013,g_rtia_m.rtia007,g_rtia_m.rtia066,g_rtia_m.rtia046,g_rtia_m.rtia0461,g_rtia_m.rtia047, 
          g_rtia_m.rtia0471,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtiaunit,g_rtia_m.rtia000,g_rtia_m.rtia026, 
          g_rtia_m.rtia027,g_rtia_m.rtia002,g_rtia_m.rtia025,g_rtia_m.rtia032,g_rtia_m.rtia036,g_rtia_m.rtia036_desc, 
          g_rtia_m.rtia037,g_rtia_m.rtia037_desc,g_rtia_m.rtia038,g_rtia_m.rtia038_desc,g_rtia_m.rtia039, 
          g_rtia_m.isaf009,g_rtia_m.isaf013,g_rtia_m.isaf044,g_rtia_m.isaf202,g_rtia_m.isaf203,g_rtia_m.isaf204, 
          g_rtia_m.isaf201,g_rtia_m.isaf207,g_rtia_m.rtiaownid,g_rtia_m.rtiaownid_desc,g_rtia_m.rtiaowndp, 
          g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdp_desc, 
          g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamodid_desc,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid, 
          g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstid_desc,g_rtia_m.rtiapstdt, 
          g_rtia_m.sum1,g_rtia_m.sum2,g_rtia_m.sum3,g_rtia_m.sum4
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   IF g_rtia_m.rtiastus = 'N' THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,open_ammt450_01,ammt450_s_pay",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,modify_detail,delete,open_ammt450_01,ammt450_s_pay",FALSE)
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE ammt450_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt450_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt450.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION ammt450_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmfe_d.getLength() THEN
         LET g_detail_idx = g_mmfe_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmfe_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmfe_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mmfe2_d.getLength() THEN
         LET g_detail_idx = g_mmfe2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmfe2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmfe2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_mmfe3_d.getLength() THEN
         LET g_detail_idx = g_mmfe3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmfe3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmfe3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_mmfe4_d.getLength() THEN
         LET g_detail_idx = g_mmfe4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmfe4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmfe4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ammt450_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL ammt450_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION ammt450_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="ammt450.status_show" >}
PRIVATE FUNCTION ammt450_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammt450.mask_functions" >}
&include "erp/amm/ammt450_mask.4gl"
 
{</section>}
 
{<section id="ammt450.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION ammt450_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
   LET g_wc2_table4 = " 1=1"
 
 
   CALL ammt450_show()
   CALL ammt450_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #確認前檢核段
   IF NOT s_ammt450_conf_chk(g_rtia_m.rtiadocno) THEN
      CLOSE ammt450_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_rtia_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mmfe_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_mmfe2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_mmfe3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_mmfe4_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL ammt450_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL ammt450_ui_headershow()
   CALL ammt450_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION ammt450_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL ammt450_ui_headershow()  
   CALL ammt450_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="ammt450.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ammt450_set_pk_array()
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
   LET g_pk_array[1].values = g_rtia_m.rtiadocno
   LET g_pk_array[1].column = 'rtiadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt450.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="ammt450.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION ammt450_msgcentre_notify(lc_state)
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
   CALL ammt450_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rtia_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt450.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION ammt450_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#23 add-S
   SELECT rtiastus  INTO g_rtia_m.rtiastus
     FROM rtia_t
    WHERE rtiaent = g_enterprise
      AND rtiadocno = g_rtia_m.rtiadocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_rtia_m.rtiastus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
        WHEN 'Z'
           LET g_errno = 'sub-01351'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_rtia_m.rtiadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL ammt450_set_act_visible()
        CALL ammt450_set_act_no_visible()
        CALL ammt450_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#23 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt450.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 單頭欄位顯示
# Memo...........:
# Usage..........: CALL ammt450_set_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/03 By Lori   #160819-00054#14
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt450_set_visible()
   CALL cl_set_comp_visible("rtia007,rtia066",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 單頭欄位隱藏
# Memo...........:
# Usage..........: CALL ammt450_set_no_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/03 By Lori   #160819-00054#14
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt450_set_no_visible()
   IF cl_null(g_rtia_m.mmby009) OR g_rtia_m.mmby009 <> '2' THEN
      CALL cl_set_comp_visible("rtia007,rtia066",FALSE)
   END IF
   
   IF cl_null(g_mmby024) OR g_mmby024 <> 'Y' THEN
      CALL cl_set_comp_visible("rtia066",FALSE)
   END IF   
END FUNCTION

PRIVATE FUNCTION ammt450_rtia038_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia038
   LET g_ref_fields[2] = g_rtia_m.rtiasite
   CALL ap_ref_array2(g_ref_fields,"SELECT oogd002 FROM oogd_t WHERE oogdent='"||g_enterprise||"' AND oogd001=? AND oogdsite=? ","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia038_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia038_desc
END FUNCTION
################################################################################
# Descriptions...: 活動規則編號帶出說明
# Memo...........:
# Usage..........: CALL ammt450_rtia044_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/13 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_rtia044_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia044
   LET g_ref_fields[2] = g_rtia_m.rtia045
   CALL ap_ref_array2(g_ref_fields,"SELECT mmbyl004 FROM mmbyl_t WHERE mmbylent='"||g_enterprise||"' AND mmbyl001=? AND mmbyl002=? AND mmbyl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia044_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia044_desc
END FUNCTION
################################################################################
# Descriptions...: 由卡號帶出會員卡資料檔裡的資料
# Memo...........:
# Usage..........: CALL ammt450_carry_mmaq()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_carry_mmaq()
   SELECT mmaq002,mmaq018
     INTO g_rtia_m.rtia042,g_rtia_m.rtia043
     FROM mmaq_t
    WHERE mmaqent = g_enterprise
      AND mmaq001 = g_rtia_m.rtia001
   IF cl_null(g_rtia_m.rtia043) THEN
      LET g_rtia_m.rtia043 = 0
   END IF
   #IF g_prog_name = 'ammt451' OR g_prog_name = 'ammt452' THEN              #160705-00042#9 160713 by sakura mark
   IF g_prog_name MATCHES 'ammt451' OR g_prog_name MATCHES 'ammt452' THEN   #160705-00042#9 160713 by sakura add
      LET g_rtia_m.rtia043 = ''
   END IF
   DISPLAY BY NAME g_rtia_m.rtia042,g_rtia_m.rtia043
END FUNCTION
################################################################################
# Descriptions...: 由規則編號+版本帶出mmby table的欄位
# Memo...........:
# Usage..........: CALL ammt450_carry_mmby()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By pomelo
# Modify.........: 2016/10/03 By lori  增加取得活動規則的開始/結束日期,依業態設定規則
################################################################################
PUBLIC FUNCTION ammt450_carry_mmby()
   DEFINE l_mmby006    LIKE mmby_t.mmby006
   DEFINE l_mmby009    LIKE mmby_t.mmby009
   DEFINE l_mmby010    LIKE mmby_t.mmby010
   DEFINE l_mmby011    LIKE mmby_t.mmby011
   DEFINE l_mmby012    LIKE mmby_t.mmby012
   DEFINE l_mmby013    LIKE mmby_t.mmby013

   LET l_mmby006 = ''
   LET l_mmby009 = ''
   LET l_mmby010 = ''
   LET l_mmby011 = ''
   LET l_mmby012 = ''
   LET l_mmby013 = ''
   
   #160819-00054#14 161003 by lori add---(S)
   LET g_mmby014 = ''
   LET g_mmby015 = ''
   LET g_mmby024 = ''
   #160819-00054#14 161003 by lori add---(E)
   
   SELECT mmby006,mmby009,mmby010,mmby011,mmby012,mmby013,
          mmby014,mmby015,mmby024                                       #160819-00054#14 161003 by lori add
     INTO l_mmby006,l_mmby009,l_mmby010,l_mmby011,l_mmby012,l_mmby013,
          g_mmby014,g_mmby015,g_mmby024                                 #160819-00054#14 161003 by lori add
     FROM mmby_t
    WHERE mmby001 = g_rtia_m.rtia044
      AND mmby002 = g_rtia_m.rtia045
      AND mmbyent = g_enterprise
      AND mmbysite = g_rtia_m.rtiasite
   
   LET g_rtia_m.mmby006 = l_mmby006
   LET g_rtia_m.mmby009 = l_mmby009
   LET g_rtia_m.mmby010 = l_mmby010
   LET g_rtia_m.mmby011 = l_mmby011
   LET g_rtia_m.mmby012 = l_mmby012
   LET g_rtia_m.mmby013 = l_mmby013

   #160819-00054#14 161003 by lori add---(S)
   IF cl_null(g_mmby024) THEN
      LET g_mmby024 = 'N' 
   END IF
   
   IF g_mmby024 = 'N' THEN
      LET g_rtia_m.rtia066 = 'ALL'
   END IF
   #160819-00054#14 161003 by lori add---(E)
   
   DISPLAY BY NAME g_rtia_m.mmby006,g_rtia_m.mmby009,g_rtia_m.mmby010,
                   g_rtia_m.mmby011,g_rtia_m.mmby012,g_rtia_m.mmby013
   
END FUNCTION
################################################################################
# Descriptions...: 兌換資訊欄位撈值與計算
# Memo...........:
# Usage..........: CALL ammt450_exchange_info()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/17 By pomelo
# Modify.........: 2016/10/03 By lori     新增mmci006處理
################################################################################
PUBLIC FUNCTION ammt450_exchange_info()
   DEFINE l_rtia047      LIKE rtia_t.rtia047

   CALL ammt450_get_rtia046(g_rtia_m.rtia044,g_rtia_m.rtia045,g_rtia_m.mmby009)
      RETURNING g_rtia_m.rtia046

   #該規則已兌換份數欄位給值
   CALL ammt450_rtia0461()
   
   #此次兌換積點
   LET l_rtia047 = ''
   SELECT SUM(mmfe007*mmci004) INTO l_rtia047
     FROM mmci_t,rtia_t,mmfe_t
    WHERE rtiaent = mmfeent
      AND rtiadocno = mmfedocno
      AND rtiaent = mmcient
      AND rtia001 = mmci001
      AND rtia042 = mmci002
      AND mmci003 = mmef011
     #AND mmci001 = g_rtia_m.rtia001                           #161004-00003#1  161005 by lori mark
      AND mmci001 = g_rtia_m.rtia044                           #161004-00003#1  161005 by lori add
      AND mmci002 = g_rtia_m.rtia042                           
     #AND mmcistus = 'Y'                                       #161004-00003#1  161005 by lori mark     
      AND mmciacti = 'Y'                                       #161004-00003#1  161005 by lori add
      AND (g_mmby024 = 'N'                                     #160819-00054#14 161003 by lori add
        OR (g_mmby024 = 'Y' AND mmci006 = g_rtia_m.rtia066))   #160819-00054#14 161003 by lori add
   IF cl_null(l_rtia047) THEN
      LET l_rtia047 = 0
   END IF
   LET g_rtia_m.rtia047 = l_rtia047
   
   #160705-00042#9 160713 by sakura mark(S)
   #CASE g_prog_name
   #   #積點
   #   WHEN 'ammt450'
   #160705-00042#9 160713 by sakura mark(E)
   #160705-00042#9 160713 by sakura add(S)
   CASE 
      #積點
      WHEN g_prog_name MATCHES 'ammt450'   
   #160705-00042#9 160713 by sakura add(E)
         #兌換後剩餘積點
         #卡積點餘額rtia043-此次兌換積點rtia047
         LET g_rtia_m.rtia0471 = g_rtia_m.rtia043 - g_rtia_m.rtia047
      
      #累計消費額
      #其他兌換
      OTHERWISE
         #兌換後剩餘積點
         #該規則計算總累消 rtia046 - 此次兌換積點rtia047
         LET g_rtia_m.rtia0471 = g_rtia_m.rtia046 - g_rtia_m.rtia047
   END CASE
   
   DISPLAY BY NAME g_rtia_m.rtia0471
   
END FUNCTION
################################################################################
# Descriptions...: 重新計算此次兌換積點
# Memo...........:
# Usage..........: CALL ammt450_recount_point()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/21 By pomelo
# Modify.........: 2016/10/03 By lori     新增mmci006處理
################################################################################
PUBLIC FUNCTION ammt450_recount_point()
DEFINE l_mmci004        LIKE mmci_t.mmci004
DEFINE l_mmfe007        LIKE mmfe_t.mmfe007
DEFINE l_rtia049        LIKE rtia_t.rtia049    #150513-00009#1 By pomelo add

   LET l_mmci004 = ''
   SELECT SUM(mmci004*mmfe007) INTO l_mmci004
     FROM rtia_t,mmfe_t,mmbo_t,mmci_t
    WHERE rtiaent = g_enterprise
      AND rtiadocno = g_rtia_m.rtiadocno
      AND rtiaent = mmfeent
      AND rtiadocno = mmfedocno
      AND rtiaent = mmboent
      #AND mmbo004 = '4'
      AND mmbo001 = rtia044
      AND mmbo002 = rtia045
      AND mmbostus = 'Y'
      AND mmboent = mmcient
      AND mmbodocno = mmcidocno
      AND mmfe011 = mmci003
      AND (g_mmby024 = 'N'                                     #160819-00054#14 161003 by lori add
        OR (g_mmby024 = 'Y' AND mmci006 = g_rtia_m.rtia066))   #160819-00054#14 161003 by lori add      
   IF cl_null(l_mmci004) THEN
      LET l_mmci004 = 0
   END IF
   
   #150513-00009#1 By pomelo add(S)
   LET l_rtia049 = 0
   SELECT SUM(mmfe006) INTO l_rtia049
     FROM mmfe_t
    WHERE mmfeent = g_enterprise
      AND mmfedocno = g_rtia_m.rtiadocno
   IF cl_null(l_rtia049) THEN
      LET l_rtia049 = 0
   END IF
   #150513-00009#1 By pomelo add(E)
   
   UPDATE rtia_t SET rtia047 = l_mmci004,
                     rtia049 = l_rtia049   #150513-00009#1 By pomelo add
    WHERE rtiaent = g_enterprise
      AND rtiadocno = g_rtia_m.rtiadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Upd rtia"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   LET g_rtia_m.rtia047 = l_mmci004
   #160705-00042#9 160713 by sakura mark(S)
   #CASE g_prog_name
   #   #積點
   #   WHEN 'ammt450'
   #160705-00042#9 160713 by sakura mark(E)
   #160705-00042#9 160713 by sakura add(S)
   CASE 
      #積點
      WHEN g_prog_name MATCHES 'ammt450'
   #160705-00042#9 160713 by sakura add(E)      
         #兌換後剩餘積點
         #卡積點餘額rtia043-此次兌換積點rtia047
         LET g_rtia_m.rtia0471 = g_rtia_m.rtia043 - g_rtia_m.rtia047
         
      #累計消費額
      #其他兌換
      OTHERWISE
         #兌換後剩餘積點
         #該規則計算總累消 rtia046 - 此次兌換積點rtia047
         LET g_rtia_m.rtia0471 = g_rtia_m.rtia046 - g_rtia_m.rtia047
   END CASE
   
   DISPLAY BY NAME g_rtia_m.rtia047,g_rtia_m.rtia0471
   CALL ammt450_rtia0461()
END FUNCTION
################################################################################
# Descriptions...: 建立換贈子程式所需的temp table
# Memo...........:
# Usage..........: CALL ammt450_create_temptable()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_create_temptable()
   DROP TABLE ammt450_tmp
   DROP TABLE ammt450_tmp1
   
   #存放單身可以兌換的資料
   CREATE TEMP TABLE ammt450_tmp(
      mmfeseq    INTEGER, 
      mmfe011    VARCHAR(10), 
      mmfe001    VARCHAR(40), 
      mmfe003    VARCHAR(10), 
      mmfe006    DECIMAL(20,6), 
      mmfe004    VARCHAR(30), 
      mmfe005    VARCHAR(30), 
      mmfe007    DECIMAL(20,6), 
      mmfe010    VARCHAR(10), 
      mmfe012    VARCHAR(10), 
      mmfe013    VARCHAR(40), 
      mmcj011    INTEGER, 
      mmcj012    VARCHAR(10), 
      mmcj007    DECIMAL(20,6))
      
   #存放要兌換的資料
   CREATE TEMP TABLE ammt450_tmp1(
      mmfeseq    INTEGER, 
      mmfe011    VARCHAR(10), 
      mmfe001    VARCHAR(40), 
      mmfe003    VARCHAR(10), 
      mmfe006    DECIMAL(20,6), 
      mmfe004    VARCHAR(30), 
      mmfe005    VARCHAR(30), 
      mmfe007    DECIMAL(20,6), 
      mmfe010    VARCHAR(10), 
      mmfe012    VARCHAR(10), 
      mmfe013    VARCHAR(40), 
      mmcj011    INTEGER, 
      mmcj012    VARCHAR(10), 
      mmcj007    DECIMAL(20,6),
      mmci004    DECIMAL(20,6))
END FUNCTION
################################################################################
# Descriptions...: 抓取客戶慣用幣別與匯率
# Memo...........:
# Usage..........: CALL ammt450_get_client_usual_info()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/24 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_get_client_usual_info()
DEFINE l_mmaq003         LIKE mmaq_t.mmaq003
DEFINE l_mmaf016         LIKE mmaf_t.mmaf016
DEFINE l_ooam005         LIKE ooam_t.ooam005
DEFINE l_gzsz008         LIKE gzsz_t.gzsz008

   LET l_mmaq003 = ''
   #會員編號
   SELECT mmaq003 INTO l_mmaq003
     FROM mmaq_t
    WHERE mmaq001 = g_rtia_m.rtia001
      AND mmaqent = g_enterprise
   
   #大宗客戶編號(mmaf016)
   LET l_mmaf016 = ''
   SELECT mmaf016 INTO l_mmaf016
     FROM mmaf_t
    WHERE mmafent = g_enterprise
      AND mmaf001 = l_mmaq003
      
   IF cl_null(l_mmaf016) THEN
      #散客編號(ooef108)
      LET l_mmaf016 = g_ooef108
   END IF
   LET g_rtia_m.rtia002 = l_mmaf016
   
   #抓取客户慣用幣別
   SELECT pmab083,pmab087
     INTO g_rtia_m.rtia026,g_rtia_m.rtia025
     FROM pmab_t
    WHERE pmabent = g_enterprise
      AND pmabsite = g_rtia_m.rtiasite
      AND pmab001 = l_mmaf016
   
   IF NOT cl_null(g_rtia_m.rtia026) THEN
      #取交易貨幣批量
      LET l_ooam005 = ''
      SELECT ooam005 INTO l_ooam005
       FROM ooam_t
       WHERE ooament = g_enterprise
         AND ooam001 = g_ooef015
         AND ooam003 = g_rtia_m.rtia026
         AND ooam004 = g_rtia_m.rtiadocdt

      #取匯率類型
      LET l_gzsz008 = ''
      SELECT gzsz008 INTO l_gzsz008
        FROM gzsz_t
       WHERE gzsz001 = 'ooab_t'
         AND gzsz002 = 'S-BAS-0010'

      CALL s_aooi160_get_exrate('1',g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtia026,g_ooef016,l_ooam005,l_gzsz008)
         RETURNING g_rtia_m.rtia027
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 商品編號帶出品名
# Memo...........:
# Usage..........: CALL ammt450_rtib004_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/26 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_rtib004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmfe2_d[l_ac].rtib004
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmfe2_d[l_ac].rtib004_desc = '', g_rtn_fields[1] , ''
END FUNCTION

################################################################################
# Descriptions...: 商品編號帶出品名
# Memo...........:
# Usage..........: CALL ammt450_rtib0041_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/26 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_rtib0041_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmfe3_d[l_ac].rtib0041
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmfe3_d[l_ac].rtib0041_desc = '', g_rtn_fields[1] , ''
END FUNCTION

################################################################################
# Descriptions...: 商品編號帶出品名
# Memo...........:
# Usage..........: CALL ammt450_rtib0042_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/26 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_rtib0042_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmfe4_d[l_ac].rtib0042
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmfe4_d[l_ac].rtib0042_desc = '', g_rtn_fields[1] , ''
END FUNCTION

################################################################################
# Descriptions...: 規則編號的開窗條件字串組合
# Memo...........:
# Usage..........: CALL ammt450_controlp_rtia044()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/31 By pomelo
# Modify.........: 2016/08/17 By lori      #換贈規則提供對象:卡種/會員等級/其他屬性一~五,調整相關邏輯
#                  2016/11/04 By lori      #換贈活動規則開窗應過濾活動類型
################################################################################
PUBLIC FUNCTION ammt450_controlp_rtia044()
   DEFINE l_mmby001        LIKE mmby_t.mmby001          
   DEFINE l_str            STRING                  #160729-00077#20 160818 by lori add
   
   #160729-00077#20 160818 by lori add---(S)
   LET l_str = #單據日期在活動開始/結束日期區間
               " '",g_rtia_m.rtiadocdt,"' BETWEEN mmby014 AND mmby015 "

   IF cl_null(g_rtia_m.rtia001) THEN
      LET l_str = l_str,
               " AND mmby019 = '1' AND mmby005 = '",g_rtia_m.rtia042,"' "
   ELSE
      LET l_str = l_str,
               #卡號所屬的卡種/會員等級/會員其他屬性一~五符合活動規則對象(卡種/會員等級/會員其他屬性一~五)
               " AND EXISTS(SELECT 1 ",
               "              FROM (SELECT mmaqent,mmaq002,t1.mmag004 vip_level,t2.mmag004 vip_1,t4.mmag004 vip_2,t4.mmag004 vip_3,t5.mmag004 vip_4,t6.mmag004 vip_5 ",                                                                                        
               "                      FROM mmaq_t ",
               "                           LEFT JOIN mmag_t t1 ON t1.mmagent = mmaqent AND t1.mmag001 = mmaq003 AND t1.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = ",g_enterprise," AND oocq001 = '2049' AND oocq004 = '2024') ",                                                                                                              
               "                           LEFT JOIN mmag_t t2 ON t2.mmagent = mmaqent AND t2.mmag001 = mmaq003 AND t2.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = ",g_enterprise," AND oocq001 = '2049' AND oocq004 = '2026') ",
               "                           LEFT JOIN mmag_t t3 ON t3.mmagent = mmaqent AND t3.mmag001 = mmaq003 AND t3.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = ",g_enterprise," AND oocq001 = '2049' AND oocq004 = '2027') ",   
               "                           LEFT JOIN mmag_t t4 ON t4.mmagent = mmaqent AND t4.mmag001 = mmaq003 AND t4.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = ",g_enterprise," AND oocq001 = '2049' AND oocq004 = '2028') ",   
               "                           LEFT JOIN mmag_t t5 ON t5.mmagent = mmaqent AND t5.mmag001 = mmaq003 AND t5.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = ",g_enterprise," AND oocq001 = '2049' AND oocq004 = '2029') ",   
               "                           LEFT JOIN mmag_t t6 ON t6.mmagent = mmaqent AND t6.mmag001 = mmaq003 AND t6.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = ",g_enterprise," AND oocq001 = '2049' AND oocq004 = '2030') ",                                                                                           
               "                     WHERE mmaqent = mmbyent AND mmaq001 = '",g_rtia_m.rtia001,"') ",                                                          
               "             WHERE mmaqent = mmbyent ",
               "               AND ((mmby019 = '1' AND mmby005 = mmaq002) OR (mmby019 = '2' AND mmby005 = vip_level) ",
               "                 OR (mmby019 = '11' AND mmby005 = vip_1) OR (mmby019 = '12' AND mmby005 = vip_2) ",
               "                 OR (mmby019 = '13' AND mmby005 = vip_3) OR (mmby019 = '14' AND mmby005 = vip_4) OR (mmby019 = '15' AND mmby005 = vip_5))) "
   END IF
   
   LET l_str = l_str,
               #卡號所屬的卡種/會員等級/會員其他屬性一~五符合活動規則對象(卡種/會員等級/會員其他屬性一~五)對應的最新發佈日期的活動規則
               " AND (mmby005,mmby019,mmby016) IN (SELECT mmby005,mmby019,mmby016 FROM ",
               "                                   (SELECT mmby005,mmby019,MAX(mmby016) mmby016 FROM mmby_t ",
               "                                     WHERE mmbyent = ",g_enterprise," AND mmbysite = '",g_rtia_m.rtiasite,"' ",
               "                                       AND mmby004 = '",g_argv[1],"' ",     #161103-00027#1 161104 by lori add:過濾活動類型
               "                                       AND mmbystus = 'Y' AND '",g_rtia_m.rtiadocdt,"' BETWEEN mmby014 AND mmby015 ",
               "                                     GROUP BY mmby005,mmby019)) " 
   #160729-00077#20 160818 by lori add---(E)
   
   LET g_rtia044_str = ""
   
   LET g_sql = "SELECT DISTINCT mmby001 FROM mmby_t",
               " WHERE mmbyent = ",g_enterprise,
               "   AND mmbysite = '",g_rtia_m.rtiasite,"'",
               "   AND mmby004 = '",g_mmbo004,"'",
               "   AND mmby005 = '",g_rtia_m.rtia042,"'",    
               "   AND mmbystus = 'Y' ",
               "   AND ",l_str,          #160729-00077#20 160818 by lori add
               " ORDER BY mmby001 "
   PREPARE ammt450_cp_rtia044 FROM g_sql
   DECLARE ammt450_cp_rtia044_curs CURSOR FOR ammt450_cp_rtia044
   
   LET l_mmby001 = ''
   FOREACH ammt450_cp_rtia044_curs INTO l_mmby001
      DISPLAY "RuleNo. ",l_mmby001
      IF SQLCA.sqlcode THEN
         RETURN
      END IF
      
      #150508-00025#1 150508 By pomelo mark(S)
      #CALL ammt450_chk_rtia044(l_mmby001)
      #IF cl_null(g_errno) THEN
      #150508-00025#1 150508 By pomelo mark(E)
      IF ammt450_chk_rtia044('q',l_mmby001) THEN   #150508-00025#1 150508 By pomelo add   #160729-00077#20 160818 by lori mod:第一個參數值
         IF cl_null(g_rtia044_str) THEN
            LET g_rtia044_str = " (mmby001 ='",l_mmby001,"' AND mmby002='",g_mmby002,"')"
         ELSE
            LET g_rtia044_str = g_rtia044_str," OR (mmby001 ='",l_mmby001,"' AND mmby002='",g_mmby002,"')"
         END IF
      END IF
      
      LET l_mmby001 = ''
      LET g_rtia_m.rtia045 = ''
   END FOREACH
   
   #160729-00077#20 160818 by lori add---(S)
   IF cl_null(g_rtia044_str) THEN
      LET g_rtia044_str = l_str
   ELSE
      LET g_rtia044_str = l_str, " AND ",g_rtia044_str
   END IF   
   #160729-00077#20 160818 by lori add---(E)
END FUNCTION

################################################################################
# Descriptions...: 計算該規則已兌換的份數
# Memo...........:
# Usage..........: CALL ammt450_rtia0461()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_rtia0461()
DEFINE l_mmfe007       LIKE mmfe_t.mmfe007

   LET l_mmfe007 = 0
   SELECT SUM(mmfe007) INTO l_mmfe007
     FROM mmfe_t,rtia_t
    WHERE rtiaent = mmfeent
      AND rtiadocno = mmfedocno
      AND rtia044 = g_rtia_m.rtia044
      AND rtiastus != 'X'
   IF cl_null(l_mmfe007) THEN
      LET l_mmfe007 = 0
   END IF
   LET g_rtia_m.rtia0461 = l_mmfe007
   DISPLAY BY NAME g_rtia_m.rtia0461
END FUNCTION

################################################################################
# Descriptions...: 更改畫面上的欄位顯示名稱
# Memo...........:
# Usage..........: CALL ammt450_change_text()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/02 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_change_text()
DEFINE l_gzze003  LIKE gzze_t.gzze003

   #IF g_prog_name = 'ammt451' OR g_prog_name = 'ammt452' THEN              #160705-00042#9 160713 by sakura mark
   IF g_prog_name MATCHES 'ammt451' OR g_prog_name MATCHES 'ammt452' THEN   #160705-00042#9 160713 by sakura add
      #該規則計算總累消
      LET l_gzze003 = cl_getmsg('amm-00314',g_dlang)
      CALL cl_set_comp_att_text('rtia046',l_gzze003)
      
      #此次兌換金額
      LET l_gzze003 = cl_getmsg('amm-00315',g_dlang)
      CALL cl_set_comp_att_text('rtia047',l_gzze003)
      
      #兌換後剩餘金額
      LET l_gzze003 = cl_getmsg('amm-00316',g_dlang)
      CALL cl_set_comp_att_text('rtia0471',l_gzze003)
      
      #(備註　　)
      LET l_gzze003 = cl_getmsg('amm-00333',g_dlang)
      CALL cl_set_comp_att_text('rtia041',l_gzze003)
   ELSE
      #(備註　　　)
      LET l_gzze003 = cl_getmsg('amm-00332',g_dlang)
      CALL cl_set_comp_att_text('rtia041',l_gzze003)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 確認剩餘積點/金額是否有可兌換的商品
# Memo...........:
# Usage..........: CALL ammt450_chk_exchange(p_mmby010,p_rtia044)
#                  RETURNING r_success
# Input parameter: p_mmyb009   累計方式
#                : p_mmby010   換贈方式
#                : p_rtia044   規則編號
# Return code....: r_success   True/False
# Date & Author..: 2014/04/09 By pomelo
# Modify.........: 2016/10/03 By lori     新增mmci006處理
################################################################################
PUBLIC FUNCTION ammt450_chk_exchange(p_mmby009,p_mmby010,p_rtia044)
DEFINE p_mmby009         LIKE mmby_t.mmby009
DEFINE p_mmby010         LIKE mmby_t.mmby010
DEFINE p_rtia044         LIKE rtia_t.rtia044
DEFINE r_success         LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_mmci003         LIKE mmci_t.mmci003
DEFINE l_mmci004         LIKE mmci_t.mmci004
DEFINE l_sum_mmci004     LIKE mmci_t.mmci004
DEFINE l_rtia043         LIKE rtia_t.rtia043

   LET r_success = TRUE
   LET g_sql = "SELECT mmci003,mmci004",
               "  FROM mmbo_t,mmci_t",
               " WHERE mmboent = mmcient",
               "   AND mmbodocno = mmcidocno",
               "   AND mmbo001 = mmci001",
               "   AND mmboent = ",g_enterprise,
               "   AND mmbostus = 'Y'",
               "   AND mmbo001 = '",p_rtia044,"'",
               "   AND mmbo002 = '",g_rtia_m.rtia045,"'",
               "   AND mmbo004 = '",g_mmbo004,"'",
               "   AND mmciacti = 'Y'",
               "AND ('",g_mmby024,"' = 'N' ",                                          #160819-00054#14 161003 by lori add
               "  OR ('",g_mmby024,"' = 'Y' AND mmci006 = '",g_rtia_m.rtia066,"')) ",  #160819-00054#14 161003 by lori add               
               " ORDER BY mmci003"
   PREPARE ammt450_chk_exchange FROM g_sql
   DECLARE ammt450_chk_exchange_curs CURSOR FOR ammt450_chk_exchange
   
   #160705-00042#9 160713 by sakura mark(S)
   #CASE g_prog_name
   #   WHEN 'ammt450'
   #160705-00042#9 160713 by sakura mark(E)
   #160705-00042#9 160713 by sakura add(S)
   CASE 
      WHEN g_prog_name MATCHES 'ammt450'      
   #160705-00042#9 160713 by sakura add(E)
         LET l_rtia043 = g_rtia_m.rtia043
      OTHERWISE
         CALL ammt450_get_rtia046(p_rtia044,g_rtia_m.rtia045,p_mmby009)
            RETURNING l_rtia043
   END CASE
   
   LET l_cnt = 0
   #160705-00042#9 160713 by sakura mark(S)
   #IF (p_mmby009 <> '3' AND g_prog_name = 'ammt450') OR 
   #   (p_mmby009 <> '2' AND g_prog_name = 'ammt451') OR 
   #   (g_prog_name = 'ammt452') THEN
   #160705-00042#9 160713 by sakura mark(E)
   
   #160705-00042#9 160713 by sakura add(S)
   IF (p_mmby009 <> '3' AND g_prog_name MATCHES 'ammt450') OR 
      (p_mmby009 <> '2' AND g_prog_name MATCHES 'ammt451') OR 
      (g_prog_name MATCHES 'ammt452') THEN
   #160705-00042#9 160713 by sakura add(E)     
      CASE p_mmby010
         #單一兌換比例
         WHEN '1'
            LET l_mmci003 = ''
            LET l_mmci004 = ''
            FOREACH ammt450_chk_exchange_curs INTO l_mmci003,l_mmci004
               IF SQLCA.sqlcode THEN
                  #150508-00025#1 150507 By pomelo add(S)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #150508-00025#1 150507 By pomelo add(E)
                  #LET g_errno = SQLCA.sqlcode   #150508-00025#1 150507 By pomelo mark
                  LET r_success = FALSE
                  RETURN r_success
               END IF
               
               IF l_rtia043 >= l_mmci004 THEN
                  LET l_cnt = l_cnt + 1
               END IF
               
               LET l_mmci003 = ''
               LET l_mmci004 = ''
            END FOREACH
         #分段兌換比例
         WHEN '2'
            LET l_mmci003 = ''
            LET l_mmci004 = ''
            LET l_sum_mmci004 = 0
            FOREACH ammt450_chk_exchange_curs INTO l_mmci003,l_mmci004
               IF SQLCA.sqlcode THEN
                  #150508-00025#1 150507 By pomelo add(S)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #150508-00025#1 150507 By pomelo add(E)
                  #LET g_errno = SQLCA.sqlcode   #150508-00025#1 150507 By pomelo mark
                  LET r_success = FALSE
                  RETURN r_success
               END IF
               
               LET l_sum_mmci004 = l_sum_mmci004 + l_mmci004
               IF l_rtia043 >= l_sum_mmci004 THEN
                  LET l_cnt = l_cnt + 1
               END IF
               
               LET l_mmci003 = ''
               LET l_mmci004 = ''
            END FOREACH
            
         OTHERWISE
            LET r_success = FALSE
            RETURN r_success
      END CASE
      IF l_cnt = 0 THEN
         #此會員的剩餘積點，在此規則編號沒有可以兌換的商品！;請重新輸入！
         #150508-00025#1 150507 By pomelo add(S)
         INITIALIZE g_errparam TO NULL
         #150515-00008#1 150518 By pomelo add(S)
         #IF g_prog_name = 'ammt450' THEN        #160705-00042#9 160713 by sakura mark
         IF g_prog_name MATCHES 'ammt450' THEN   #160705-00042#9 160713 by sakura add
         #150515-00008#1 150518 By pomelo add(E)
            LET g_errparam.code = 'amm-00330'
         #150515-00008#1 150518 By pomelo add(S)
         ELSE
            #此會員的累計消費額，在此規則編號沒有可以兌換的商品！;請重新輸入！
            LET g_errparam.code = 'amm-00452'
         END IF
         #150515-00008#1 150518 By pomelo add(E)
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150508-00025#1 150507 By pomelo add(E)
         #LET g_errno = 'amm-00330'      #150508-00025#1 150507 By pomelo mark
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 卡種編號對其他欄位值清空
# Memo...........:
# Usage..........: CALL ammt450_control_rtia044()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/07 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_control_rtia044()
   LET g_errno = ''
   #請先輸入卡號rtia001
   #IF cl_null(g_rtia_m.rtia001) AND g_prog_name = 'ammt450' THEN        #160705-00042#9 160713 by sakura mark
   IF cl_null(g_rtia_m.rtia001) AND g_prog_name MATCHES 'ammt450' THEN   #160705-00042#9 160713 by sakura add
      LET g_rtia_m.rtia044 = ''
      LET g_rtia_m.rtia045 = ''
      LET g_rtia_m.rtia044_desc = ''
      LET g_rtia_m.mmby006 = ''
      LET g_rtia_m.mmby009 = ''
      LET g_rtia_m.mmby010 = ''
      LET g_rtia_m.mmby011 = ''
      LET g_rtia_m.mmby012 = ''
      LET g_rtia_m.mmby013 = ''
      LET g_rtia_m.rtia046 = ''
      LET g_rtia_m.rtia047 = ''
      LET g_rtia_m.rtia0461 = ''
      LET g_rtia_m.rtia0471 = ''
      DISPLAY BY NAME g_rtia_m.mmby006,g_rtia_m.rtia044_desc,g_rtia_m.rtia0461,g_rtia_m.rtia0471
      LET g_errno = 'amm-00272'
   END IF
   
   #請先輸入卡種編號rtia042
   #IF cl_null(g_rtia_m.rtia042) AND (g_prog_name = 'ammt451' OR g_prog_name = 'ammt452') THEN              #160705-00042#9 160713 by sakura mark
   IF cl_null(g_rtia_m.rtia042) AND (g_prog_name MATCHES 'ammt451' OR g_prog_name MATCHES 'ammt452') THEN   #160705-00042#9 160713 by sakura add
      LET g_rtia_m.rtia044 = ''
      LET g_rtia_m.rtia045 = ''
      LET g_rtia_m.rtia044_desc = ''
      LET g_rtia_m.mmby006 = ''
      LET g_rtia_m.mmby009 = ''
      LET g_rtia_m.mmby010 = ''
      LET g_rtia_m.mmby011 = ''
      LET g_rtia_m.mmby012 = ''
      LET g_rtia_m.mmby013 = ''
      LET g_rtia_m.rtia046 = ''
      LET g_rtia_m.rtia047 = ''
      LET g_rtia_m.rtia0461 = ''
      LET g_rtia_m.rtia0471 = ''
      DISPLAY BY NAME g_rtia_m.mmby006,g_rtia_m.rtia044_desc,g_rtia_m.rtia0461,g_rtia_m.rtia0471
      LET g_errno = 'amm-00310'
   END IF
   
   #規則編號為空
   IF cl_null(g_rtia_m.rtia044) THEN
      LET g_rtia_m.rtia045 = ''
      LET g_rtia_m.mmby006 = ''
      LET g_rtia_m.mmby009 = ''
      LET g_rtia_m.mmby010 = ''
      LET g_rtia_m.mmby011 = ''
      LET g_rtia_m.mmby012 = ''
      LET g_rtia_m.mmby013 = ''
      LET g_rtia_m.rtia046 = ''
      LET g_rtia_m.rtia047 = ''
      LET g_rtia_m.rtia0461 = ''
      LET g_rtia_m.rtia0471 = ''
      DISPLAY BY NAME g_rtia_m.mmby006,g_rtia_m.rtia0461,g_rtia_m.rtia0471
   END IF
END FUNCTION

################################################################################
# Descriptions...: 商品編號帶出說明
# Memo...........:
# Usage..........: CALL ammt450_mmfe001_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/09 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_mmfe001_ref()
   
   IF cl_null(g_mmfe_d[l_ac].mmfe012) THEN
      RETURN
   END IF
   LET g_mmfe_d[l_ac].mmfe001_desc = ''
   CASE g_mmfe_d[l_ac].mmfe012
      #卡
      WHEN 'M'
         SELECT mmanl003 INTO g_mmfe_d[l_ac].mmfe001_desc
           FROM mmanl_t
          WHERE mmanlent = g_enterprise AND mmanl001 = g_mmfe_d[l_ac].mmfe001 AND mmanl002 = g_dlang
      
      #券
      WHEN 'N'
         SELECT gcafl003 INTO g_mmfe_d[l_ac].mmfe001_desc
           FROM gcafl_t
          WHERE gcaflent = g_enterprise AND gcafl001 = g_mmfe_d[l_ac].mmfe001 AND gcafl002 = g_dlang
      #積點 
      WHEN 'O'
         LET g_mmfe_d[l_ac].mmfe013_desc = ''
      
      #送抵現值
      WHEN 'P'
         SELECT imaal003 INTO g_mmfe_d[l_ac].mmfe001_desc
           FROM imaal_t
          WHERE imaalent = g_enterprise AND imaal001 = g_mmfe_d[l_ac].mmfe001 AND imaal002 = g_dlang
          
      OTHERWISE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_mmfe_d[l_ac].mmfe001
         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_mmfe_d[l_ac].mmfe001_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_mmfe_d[l_ac].mmfe001_desc
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 資料編號帶出说明
# Memo...........:
# Usage..........: CALL ammt450_mmfe013_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/09 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_mmfe013_ref()
DEFINE l_oocq001   LIKE oocq_t.oocq001

   IF cl_null(g_mmfe_d[l_ac].mmfe012) THEN
      RETURN
   END IF
   LET l_oocq001 = ''
   CASE g_mmfe_d[l_ac].mmfe012
      WHEN '6'
         LET l_oocq001 = '2000'
      WHEN '7'
         LET l_oocq001 = '2001'
      WHEN '8'
         LET l_oocq001 = '2002'
      WHEN '9'
         LET l_oocq001 = '2003'
      WHEN 'A'
         LET l_oocq001 = '2004'
      WHEN 'B'
         LET l_oocq001 = '2005'
      WHEN 'C'
         LET l_oocq001 = '2006'
      WHEN 'D'
         LET l_oocq001 = '2007'
      WHEN 'E'
         LET l_oocq001 = '2008'
      WHEN 'F'
         LET l_oocq001 = '2009'
      WHEN 'G'
         LET l_oocq001 = '2010'
      WHEN 'H'
         LET l_oocq001 = '2011'
      WHEN 'I'
         LET l_oocq001 = '2012'
      WHEN 'J'
         LET l_oocq001 = '2013'
      WHEN 'K'
         LET l_oocq001 = '2014'
      WHEN 'L'
         LET l_oocq001 = '2015'
   END CASE
   LET g_mmfe_d[l_ac].mmfe013_desc = ''
   CASE g_mmfe_d[l_ac].mmfe012
      WHEN '4'
         SELECT imaal003 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM imaal_t
          WHERE imaalent = g_enterprise AND imaal001 = g_mmfe_d[l_ac].mmfe013 AND imaal002 = g_dlang
      WHEN '5'
         SELECT rtaxl003 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM rtaxl_t
          WHERE rtaxlent = g_enterprise AND rtaxl001 = g_mmfe_d[l_ac].mmfe013 AND rtaxl002 = g_dlang
      WHEN 'M'
         SELECT mmanl003 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM mmanl_t
          WHERE mmanlent = g_enterprise AND mmanl001 = g_mmfe_d[l_ac].mmfe013 AND mmanl002 = g_dlang
      WHEN 'N'
         SELECT gcafl003 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM gcafl_t
          WHERE gcaflent = g_enterprise AND gcafl001 = g_mmfe_d[l_ac].mmfe013 AND gcafl002 = g_dlang
      WHEN 'O'
         LET g_mmfe_d[l_ac].mmfe013_desc = ''
      WHEN 'P'
         SELECT imaal003 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM imaal_t
          WHERE imaalent = g_enterprise AND imaal001 = g_mmfe_d[l_ac].mmfe013 AND imaal002 = g_dlang
      OTHERWISE
         SELECT oocql004 INTO g_mmfe_d[l_ac].mmfe013_desc
           FROM oocql_t
          WHERE oocqlent = g_enterprise AND oocql001 = l_oocq001
            AND oocql002 = g_mmfe_d[l_ac].mmfe013 AND oocql003 = g_dlang
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 取的還可兌換
# Memo...........:
# Usage..........: CALL ammt450_get_rtia046()
#                  RETURNING r_rtia046
# Input parameter: p_rtia044   規則編號
#                : p_rtia045   版本
#                : p_mmby009   累計方式
# Return code....: r_rtia046   贈品兌換該規則計算總積點
# Date & Author..: 2014/05/30 By pomelo
# Modify.........: 2016/10/03 By lori    增加mmby009=2.當日累計消費換贈方式
################################################################################
PUBLIC FUNCTION ammt450_get_rtia046(p_rtia044,p_rtia045,p_mmby009)
   DEFINE p_rtia044      LIKE rtia_t.rtia044
   DEFINE p_rtia045      LIKE rtia_t.rtia045
   DEFINE p_mmby009      LIKE mmby_t.mmby009
   DEFINE r_rtia046      LIKE rtia_t.rtia046
   DEFINE l_mmar009      LIKE mmar_t.mmar009
   DEFINE l_mmfe007      LIKE mmfe_t.mmfe007
   DEFINE l_mmaq018      LIKE mmaq_t.mmaq018
   DEFINE l_mmbo014      LIKE mmbo_t.mmbo014
   DEFINE l_mmbo015      LIKE mmbo_t.mmbo015
   DEFINE l_rtja031      LIKE rtja_t.rtja031
   DEFINE l_mmaq015      LIKE mmaq_t.mmaq015
   DEFINE l_cnt          LIKE type_t.num5       #160819-00054#14 161003 by lori add

   LET r_rtia046 = ''
   #該規則計算總積點欄位給值
   LET l_mmar009 = ''
   CASE p_mmby009
      #當日累計積點
      WHEN '1'
         #160705-00042#9 160713 by sakura mark(S)
         #CASE g_prog_name
         #   WHEN 'ammt450'
         #160705-00042#9 160713 by sakura mark(E)
         #160705-00042#9 160713 by sakura add(S)
         CASE 
            WHEN g_prog_name MATCHES 'ammt450'
         #160705-00042#9 160713 by sakura add(E)            
               SELECT SUM(mmar009) INTO l_mmar009
                 FROM mmar_t
                WHERE mmarent = g_enterprise
                  AND (mmar004 BETWEEN 5 AND 9  OR mmar004 = 'A' OR mmar004 = 'B')
                  AND mmar006 = g_rtia_m.rtiadocdt
               IF cl_null(l_mmar009) THEN
                  LET l_mmar009 = 0
               END IF
               LET r_rtia046 = l_mmar009
            #WHEN 'ammt451'                      #160705-00042#9 160713 by sakura mark
            WHEN g_prog_name MATCHES 'ammt451'   #160705-00042#9 160713 by sakura add
               LET l_rtja031 = ''
               SELECT SUM(rtja031) INTO l_rtja031
                 FROM rtja_t
                WHERE rtjaent = g_enterprise
                  AND rtja034 = g_rtia_m.rtiadocdt
               IF cl_null(l_rtja031) THEN
                  LET l_rtja031 = 0
               END IF
               LET r_rtia046 = l_rtja031
         END CASE
      
      #160819-00054#14 161003 by lori add---(S)      
      #該規則計算總累消   
      WHEN '2'   
         LET r_rtia046 = 0
         IF NOT cl_null(g_rtia_m.rtia007) AND NOT cl_null(g_rtia_m.rtia066) THEN            
            SELECT SUM(rtib021) INTO r_rtia046
              FROM rtib_t
             WHERE rtibent = g_enterprise
               AND rtibdocno = g_rtia_m.rtia007
               AND (g_mmby024 = 'N' 
                 OR (g_mmby024 = 'Y' 
                      AND EXISTS (SELECT 1 FROM rtdx_t,inaa_t 
                                   WHERE rtdxent = rtibent AND rtdxsite = rtibsite AND rtdx001 = rtib004
                                     AND rtdxent = inaaent AND rtdxsite = inaasite AND rtdx044 = inaa001
                                     AND inaa105 = g_rtia_m.rtia066)
                     )) 
            IF cl_null(r_rtia046) THEN
               LET r_rtia046 = 0 
            END IF   
         END IF
      #160819-00054#14 161003 by lori add---(E)   
      
      #指定期間累計積點
      WHEN '3'
         LET l_mmbo014 = ''
         LET l_mmbo015 = ''
         #活動規則+版次找出開始日期與結束日期
         SELECT mmbo014,mmbo015 INTO l_mmbo014,l_mmbo015
           FROM mmbo_t
          WHERE mmboent = g_enterprise
            AND mmbo001 = p_rtia044
            AND mmbo002 = p_rtia045
            #AND mmbo004 = '4'
         #當開始與結束日期都不為空值，加總在這期間內的異動積點
         IF NOT cl_null(l_mmbo014) AND NOT cl_null(l_mmbo015) THEN
            #160705-00042#9 160713 by sakura mark(S)
            #CASE g_prog_name
            #   WHEN 'ammt450'
            #160705-00042#9 160713 by sakura mark(E)
            #160705-00042#9 160713 by sakura add(S)
            CASE 
               WHEN g_prog_name MATCHES 'ammt450'
            #160705-00042#9 160713 by sakura add(E)
                  LET l_mmar009 = 0
                  SELECT SUM(mmar009) INTO l_mmar009
                    FROM mmar_t
                   WHERE mmarent = g_enterprise
                     AND (mmar004 BETWEEN 5 AND 9  OR mmar004 = 'A' OR mmar004 = 'B')
                     AND mmar006 BETWEEN l_mmbo014 AND l_mmbo015
                  LET r_rtia046 = l_mmar009
               
               #WHEN 'ammt451'                      #160705-00042#9 160713 by sakura mark
               WHEN g_prog_name MATCHES 'ammt451'   #160705-00042#9 160713 by sakura add
                  LET l_rtja031 = ''
                  SELECT SUM(rtja031) INTO l_rtja031
                    FROM rtja_t
                   WHERE rtjaent = g_enterprise
                     AND rtja034 BETWEEN l_mmbo014 AND l_mmbo015
                  IF cl_null(l_rtja031) THEN
                     LET l_rtja031 = 0
                  END IF
                  LET r_rtia046 = l_rtja031
            END CASE
         END IF
      #會員卡積點
      WHEN '4'
         #160705-00042#9 160713 by sakura mark(S)
         #CASE g_prog_name
         #   WHEN 'ammt450'
         #160705-00042#9 160713 by sakura mark(E)
         #160705-00042#9 160713 by sakura add(S)
         CASE 
            WHEN g_prog_name MATCHES 'ammt450'            
         #160705-00042#9 160713 by sakura add(E)
               LET r_rtia046 = g_rtia_m.rtia043
            #WHEN 'ammt451'                      #160705-00042#9 160713 by sakura mark
            WHEN g_prog_name MATCHES 'ammt451'   #160705-00042#9 160713 by sakura add
               LET l_mmaq015 = ''
               IF NOT cl_null(g_rtia_m.rtia001) THEN
                  SELECT mmaq015 INTO l_mmaq015
                   FROM mmaq_t
                  WHERE mmaqent = g_enterprise
                    AND mmaq001 = g_rtia_m.rtia001
               END IF
               IF cl_null(l_mmaq015) THEN
                  LET l_mmaq015 = 0
               END IF
               LET r_rtia046 = l_mmaq015
         END CASE
   END CASE
   
   IF cl_null(r_rtia046) THEN
      LET r_rtia046 = 0
   END IF
   
   RETURN r_rtia046
END FUNCTION
################################################################################
# Descriptions...: 規則編號檢查
# Memo...........: 如沒有版本 先找出最大版本 再去檢查資料是否符合條件
# Usage..........: CALL ammt450_chk_rtia044(p_chk+type,p_rtia044)
#                     RETURNING r_success
# Input parameter: p_chk_type   i.維護資料時檢查  q.編輯段開窗時過濾資料
#                  p_rtia044    規則編號
# Return code....: r_success    True/False
# Date & Author..: 2014/03/14 By pomelo
# Modify.........: 2016/08/17 By lori  1.加參數:p_chk_type   
#                                      2.換贈規則提供對象:卡種/會員等級/其他屬性一~五,應分別校驗
#                  2016/11/04 By Lori  活動規則校驗前須先取 g_mmby024 值
################################################################################
PUBLIC FUNCTION ammt450_chk_rtia044(p_chk_type,p_rtia044)
   DEFINE p_chk_type       LIKE type_t.chr1      #160729-00077#20 160817 by lori add
   DEFINE p_rtia044        LIKE rtia_t.rtia044     
   #150508-00025#1 150508 By pomelo add(S)
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_gzcbl004       LIKE gzcbl_t.gzcbl004
   #150508-00025#1 150508 By pomelo add(E)
   DEFINE l_mmck004        LIKE mmck_t.mmck004
   DEFINE l_mmck005        LIKE mmck_t.mmck005
   DEFINE l_mmck006        LIKE mmck_t.mmck006
   DEFINE l_mmck007        LIKE mmck_t.mmck007
   DEFINE l_mmck008        LIKE mmck_t.mmck008
   DEFINE l_mmck009        LIKE mmck_t.mmck009
   DEFINE l_mmby002        LIKE mmby_t.mmby002
   DEFINE l_mmby004        LIKE mmby_t.mmby004
   DEFINE l_mmby005        LIKE mmby_t.mmby005
   DEFINE l_mmby009        LIKE mmby_t.mmby009
   DEFINE l_mmby010        LIKE mmby_t.mmby010
   DEFINE l_mmby011        LIKE mmby_t.mmby011
   DEFINE l_mmby012        LIKE mmby_t.mmby012
   DEFINE l_mmby014        LIKE mmby_t.mmby014
   DEFINE l_mmby015        LIKE mmby_t.mmby015
   DEFINE l_mmby016        DATETIME YEAR TO SECOND
   DEFINE l_mmby019        LIKE mmby_t.mmby019       #規則對象   #160729-00077#20 160817 by lori add
   DEFINE l_max_mmby016    DATETIME YEAR TO SECOND
   DEFINE l_day            LIKE type_t.chr5
   DEFINE l_weekday        LIKE type_t.num5
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   #160729-00077#20 160817 by lori add---(S)
   DEFINE l_vip_level      LIKE mmag_t.mmag004      #會員等級   
   DEFINE l_vip_1          LIKE mmag_t.mmag004      #其他屬性   
   DEFINE l_vip_2          LIKE mmag_t.mmag004      #其他屬性   
   DEFINE l_vip_3          LIKE mmag_t.mmag004      #其他屬性   
   DEFINE l_vip_4          LIKE mmag_t.mmag004      #其他屬性   
   DEFINE l_vip_5          LIKE mmag_t.mmag004      #其他屬性   
   DEFINE l_exeprog        LIKE type_t.chr30
   #160729-00077#20 160817 by lori add---(E)
   
   LET r_success = TRUE   #150508-00025#1 150508 By pomelo add
   #LET g_errno = ''      #150508-00025#1 150508 By pomelo mark

   #161103-00027#1 161104 by lori add---(S)
   IF cl_null(g_mmby024) THEN
      SELECT mmby024 INTO g_mmby024
        FROM mmby_t
       WHERE mmbyent = g_enterprise
         AND mmbysite = g_rtia_m.rtiasite
         AND mmby001 = g_rtia_m.rtia044
   END IF
   #161103-00027#1 161104 by lori add---(E)
   
   #160729-00077#20 160817 by lori add---(S)
   LET l_vip_level = ''
   LET l_vip_1 = ''
   LET l_vip_2 = ''
   LET l_vip_3 = ''
   LET l_vip_4 = ''
   LET l_vip_5 = ''
   LET l_exeprog = ''
   
   SELECT t1.mmag004 vip_level,t2.mmag004 vip_1,t4.mmag004 vip_2,t4.mmag004 vip_3,t5.mmag004 vip_4,t6.mmag004 vip_5
     INTO l_vip_level,l_vip_1,l_vip_2,l_vip_3,l_vip_4,l_vip_5
     FROM mmaq_t 
          LEFT JOIN mmag_t t1 ON t1.mmagent = mmaqent AND t1.mmag001 = mmaq003 AND t1.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2024')                                                                                                                         
          LEFT JOIN mmag_t t2 ON t2.mmagent = mmaqent AND t2.mmag001 = mmaq003 AND t2.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2026') 
          LEFT JOIN mmag_t t3 ON t3.mmagent = mmaqent AND t3.mmag001 = mmaq003 AND t3.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2027')    
          LEFT JOIN mmag_t t4 ON t4.mmagent = mmaqent AND t4.mmag001 = mmaq003 AND t4.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2028')    
          LEFT JOIN mmag_t t5 ON t5.mmagent = mmaqent AND t5.mmag001 = mmaq003 AND t5.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2029')    
          LEFT JOIN mmag_t t6 ON t6.mmagent = mmaqent AND t6.mmag001 = mmaq003 AND t6.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2030') 
    WHERE mmaqent = g_enterprise
       AND mmaq001 = g_rtia_m.rtia001
       
   CASE g_argv[1]
      WHEN '4'   #換贈
         LET l_exeprog = 'ammm353'
      WHEN '5'   #
         LET l_exeprog = 'ammm354'
      WHEN '6'
         LET l_exeprog = 'ammm355'        
   END CASE   
   #160729-00077#20 160817 by lori add---(E)
   
   #如直接輸入規則編號(rtia042)，帶出目前最大的版本
   LET l_mmby002 = ''
   LET g_mmby002 = ''
   LET l_mmby019 = ''                                #160729-00077#20 160817 by lori add
   
   SELECT mmby002,mmby019 INTO l_mmby002,l_mmby019   #160729-00077#20 160817 by lori add:mmby019
     FROM mmby_t
    WHERE mmbyent = g_enterprise
      AND mmbysite = g_rtia_m.rtiasite
      AND mmby001 = p_rtia044
      AND mmbystus = 'Y'
      
   LET g_mmby002 = l_mmby002
   
   IF p_chk_type = 'i' THEN   #160729-00077#20 160817 by lori add
      #此活動規則編號所對應的版本為空，請重新輸入！
      IF cl_null(l_mmby002) THEN   
         #150508-00025#1 150507 By pomelo add(S)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00271'
         #160729-00077#20 160817 by lori mark---(S)
         ##160517-00026#1 160527 by sakura(S)
         #CASE g_argv[1]
         #  WHEN '4'    #換贈
         #    LET g_errparam.replace[1] = cl_get_progname("ammm353",g_lang,"2")
         #    LET g_errparam.exeprog = "ammm353"   
         #  WHEN '5'    #累計消費額
         #    LET g_errparam.replace[1] = cl_get_progname("ammm354",g_lang,"2")
         #    LET g_errparam.exeprog = "ammm354"
         #END CASE
         ##160517-00026#1 160527 by sakura(E)
         #160729-00077#20 160817 by lori mark---(E)
         
         LET g_errparam.replace[1] = cl_get_progname(l_exeprog,g_lang,"2")
         LET g_errparam.exeprog = l_exeprog
         LET g_errparam.EXTEND = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success
         #150508-00025#1 150507 By pomelo add(E) 
         #150508-00025#1 150507 By pomelo mark(S)
         #LET g_errno = 'amm-00271'
         #RETURN 
         #150508-00025#1 150507 By pomelo mark(E)
      END IF
      
      LET g_rtia_m.rtia045 = l_mmby002      
      
      LET l_mmby004 = ''
      LET l_mmby005 = ''
      LET l_mmby009 = ''
      LET l_mmby010 = ''
      LET l_mmby011 = ''
      LET l_mmby012 = ''
      LET l_mmby014 = ''
      LET l_mmby015 = ''
      LET l_mmby016 = ''
      
      SELECT mmby004,mmby005,mmby009,mmby010,mmby011,mmby012,mmby014,mmby015,mmby016
        INTO l_mmby004,l_mmby005,l_mmby009,l_mmby010,l_mmby011,l_mmby012,l_mmby014,l_mmby015,l_mmby016
        FROM mmby_t
       WHERE mmbyent = g_enterprise
         AND mmbystus = 'Y'
         AND mmby001 = p_rtia044
         AND mmbysite = g_rtia_m.rtiasite
      
      #活動類型
      IF l_mmby004 != g_mmbo004 THEN
         #此規則編號的活動類型：%1！
         #150508-00025#1 150507 By pomelo add(S)
         LET l_gzcbl004 = ''
         SELECT gzcbl004 INTO l_gzcbl004
           FROM gzcbl_t
          WHERE gzcbl001 = '6516'
            AND gzcbl002 = l_mmby004
            AND gzcbl003 = g_dlang
         
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00311'
         LET g_errparam.EXTEND = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_gzcbl004
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success
         #150508-00025#1 150507 By pomelo add(E)
         #150508-00025#1 150507 By pomelo mark(S)
         #LET g_errno = 'amm-00311'
         #RETURN
         #150508-00025#1 150507 By pomelo mark(E)
      END IF
      
      #160729-00077#20 160817 by lori add---(S)
      CASE l_mmby019
         WHEN '1'   #卡種,維持原邏輯
            #卡種編號
            #規則編號對應的卡種編號與會員對應的卡種編號不相同，請重新輸入！
            IF l_mmby005 != g_rtia_m.rtia042 THEN
               #150508-00025#1 150507 By pomelo add(S)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00270'
               LET g_errparam.EXTEND = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET r_success = FALSE
               RETURN r_success
               #150508-00025#1 150507 By pomelo add(E) 
               #150508-00025#1 150507 By pomelo mark(S)
               #LET g_errno = 'amm-00270'
               #RETURN 
               #150508-00025#1 150507 By pomelo mark(E)
            END IF
         WHEN '2'   #會員等級
            IF l_mmby005 != l_vip_level THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00769'
               LET g_errparam.exeprog = l_exeprog
               LET g_errparam.replace[1] = l_mmby005
               LET g_errparam.replace[2] = l_vip_level
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET r_success = FALSE
               RETURN r_success
            END IF      
         WHEN '11'   #其他屬性一
            IF l_mmby005 != l_vip_1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00770'
               LET g_errparam.exeprog = l_exeprog
               LET g_errparam.replace[1] = l_mmby005
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET r_success = FALSE
               RETURN r_success
            END IF     
         WHEN '12'   #其他屬性二
            IF l_mmby005 != l_vip_2 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00773'
               LET g_errparam.exeprog = l_exeprog
               LET g_errparam.replace[1] = l_mmby005
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET r_success = FALSE
               RETURN r_success
            END IF
         WHEN '13'   #其他屬性三
            IF l_mmby005 != l_vip_3 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00774'
               LET g_errparam.exeprog = l_exeprog
               LET g_errparam.replace[1] = l_mmby005
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET r_success = FALSE
               RETURN r_success
            END IF 
         WHEN '14'   #其他屬性四
            IF l_mmby005 != l_vip_4 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00775'
               LET g_errparam.exeprog = l_exeprog
               LET g_errparam.replace[1] = l_mmby005
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET r_success = FALSE
               RETURN r_success
            END IF    
         WHEN '15'   #其他屬性五
            IF l_mmby005 != l_vip_5 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00775'
               LET g_errparam.exeprog = l_exeprog
               LET g_errparam.replace[1] = l_mmby005
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET r_success = FALSE
               RETURN r_success
            END IF              
      END CASE      
      #160729-00077#20 160817 by lori add---(E)

      #此卡種編號是否為發布日期最大一筆
      LET l_max_mmby016 = ''
      SELECT MAX(mmby016) INTO l_max_mmby016
        FROM mmby_t 
       WHERE mmbyent = g_enterprise
         AND mmbysite = g_rtia_m.rtiasite
         AND mmbystus = 'Y'
         AND mmby004 = g_mmbo004
        #AND mmby005 = g_rtia_m.rtia042    #160729-00077#20 160817 by lori mark    
        #160729-00077#20 160817 by lori add---(S)
         AND ((g_rtia_m.rtia001 IS NOT NULL 
               AND EXISTS(SELECT 1 
                            FROM (SELECT mmaqent,mmaq002,t1.mmag004 vip_level,t2.mmag004 vip_1,t4.mmag004 vip_2,t4.mmag004 vip_3,t5.mmag004 vip_4,t6.mmag004 vip_5                                                                                         
                                    FROM mmaq_t LEFT JOIN mmag_t t1 ON t1.mmagent = mmaqent AND t1.mmag001 = mmaq003 AND t1.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2024')                                                                                                                        
                                                LEFT JOIN mmag_t t2 ON t2.mmagent = mmaqent AND t2.mmag001 = mmaq003 AND t2.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2026')
                                                LEFT JOIN mmag_t t3 ON t3.mmagent = mmaqent AND t3.mmag001 = mmaq003 AND t3.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2027')   
                                                LEFT JOIN mmag_t t4 ON t4.mmagent = mmaqent AND t4.mmag001 = mmaq003 AND t4.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2028')   
                                                LEFT JOIN mmag_t t5 ON t5.mmagent = mmaqent AND t5.mmag001 = mmaq003 AND t5.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2029')   
                                                LEFT JOIN mmag_t t6 ON t6.mmagent = mmaqent AND t6.mmag001 = mmaq003 AND t6.mmag002 = (SELECT oocq002 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '2049' AND oocq004 = '2030')                                                                                           
                                   WHERE mmaqent = mmbyent AND mmaq001 = g_rtia_m.rtia001)                                                          
                         WHERE mmaqent = mmbyent
                          AND ( (mmby019 = '1'  AND mmby005 = mmaq002) OR (mmby019 = '2' AND mmby005 = vip_level) 
                             OR (mmby019 = '11' AND mmby005 = vip_1)   OR (mmby019 = '12' AND mmby005 = vip_2) 
                             OR (mmby019 = '13' AND mmby005 = vip_3)   OR (mmby019 = '14' AND mmby005 = vip_4) OR (mmby019 = '15' AND mmby005 = vip_5))))     
           OR (g_rtia_m.rtia001 IS NULL AND mmby019 = '1' AND mmby005 = g_rtia_m.rtia042))                  
        #160729-00077#20 160817 by lori add---(E)
       GROUP BY mmby005
       
      IF NOT cl_null(l_mmby016) AND NOT cl_null(l_max_mmby016) THEN
         IF l_mmby016 != l_max_mmby016 THEN
            #150508-00025#1 150507 By pomelo add(S)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00273'
            #160517-00026#1 160527 by sakura(S)
            CASE g_argv[1]
              WHEN '4'    #換贈
                LET g_errparam.replace[1] = cl_get_progname("ammm353",g_lang,"2")
                LET g_errparam.exeprog = "ammm353"
              WHEN '5'    #累計消費額
                LET g_errparam.replace[1] = cl_get_progname("ammm354",g_lang,"2")
                LET g_errparam.exeprog = "ammm354"
            END CASE
            #160517-00026#1 160527 by sakura(E)         
            LET g_errparam.EXTEND = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
               
            LET r_success = FALSE
            RETURN r_success
            #150508-00025#1 150507 By pomelo add(E)
            #150508-00025#1 150507 By pomelo mark(S)
            #LET g_errno = 'amm-00273'
            #RETURN
            #150508-00025#1 150507 By pomelo mark(E)
         END IF
      END IF
      
      #單據日期必須在生效的開始日期與生效的結束日期之間，請重新輸入！
      IF l_mmby014 > g_rtia_m.rtiadocdt AND l_mmby015 < g_rtia_m.rtiadocdt THEN      
         #150508-00025#1 150507 By pomelo add(S)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00268'
         LET g_errparam.EXTEND = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success
         #150508-00025#1 150507 By pomelo add(E)
         #150508-00025#1 150507 By pomelo mark(S)
         #LET g_errno = 'amm-00268'
         #RETURN
         #150508-00025#1 150507 By pomelo mark(E)
      END IF
      
      #IF g_prog_name = 'ammt450' THEN
         #規則兌換限制
         CASE l_mmby011
            #期間限制兌換次數
            WHEN '2'
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM rtia_t
                WHERE rtiaent = g_enterprise
                  AND rtia000 = g_prog_name
                  AND rtia044 = p_rtia044
                  AND rtiastus != 'X'
                  AND rtiadocdt BETWEEN l_mmby014 AND l_mmby015
               IF l_cnt >= l_mmby012 THEN
                  #此會員在活動期間兌換的次數 > 此規則編號的期間限制兌換次數！;請重新輸入！
                  #150508-00025#1 150507 By pomelo add(S) 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00321'
                  LET g_errparam.EXTEND = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET r_success = FALSE
                  RETURN r_success
                  #150508-00025#1 150507 By pomelo add(E)
                  #150508-00025#1 150507 By pomelo mark(S)
                  #LET g_errno = 'amm-00321'
                  #RETURN
                  #150508-00025#1 150507 By pomelo mark(E)
               END IF
            
            #一天限制兌換次數
            WHEN '3'
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM rtia_t
                WHERE rtiaent = g_enterprise
                  AND rtia000 = g_prog_name
                  AND rtia044 = p_rtia044
                  AND rtiastus != 'X'
                  AND rtiadocdt = g_rtia_m.rtiadocdt
               IF l_cnt >= l_mmby012 THEN
                  #此會員在ㄧ天兌換次數 > 此規則編號的一天限制兌換次數！;請重新輸入！
                  #150508-00025#1 150507 By pomelo add(S)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00322'
                  LET g_errparam.EXTEND = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET r_success = FALSE
                  RETURN r_success
                  #150508-00025#1 150507 By pomelo add(E)
                  #150508-00025#1 150507 By pomelo mark(S)
                  #LET g_errno = 'amm-00322'
                  #RETURN
                  #150508-00025#1 150507 By pomelo mark(E)
               END IF
         END CASE
         
         LET l_flag = ''
         CALL ammt450_chk_exchange(l_mmby009,l_mmby010,p_rtia044) RETURNING l_success
         IF NOT l_success THEN
            #150508-00025#1 150507 By pomelo add(S)
            LET r_success = FALSE
            RETURN r_success
            #150508-00025#1 150507 By pomelo add(E)
            #150508-00025#1 150507 By pomelo mark(S)
            #RETURN
            #150508-00025#1 150507 By pomelo mark(E)
         END IF
      #END IF
   END IF   #160729-00077#20 160817 by lori add
   
   LET g_sql = "SELECT mmck004,mmck005,mmck006,mmck007,mmck008,mmck009",
               "  FROM mmbo_t,mmck_t",
               " WHERE mmboent = mmckent",
               "   AND mmbodocno = mmckdocno",
               "   AND mmbo001 = mmck001",
               "   AND mmboent = ",g_enterprise,
               "   AND mmbostus = 'Y'",
               "   AND mmbo001 = '",p_rtia044,"'",
               "   AND mmbo002 = '",g_rtia_m.rtia045,"'",
               "   AND mmbo004 = '",g_mmbo004,"'",
               "   AND mmckstus = 'Y' "
   #160729-00077#20 160817 by lori add---(S)
   IF cl_null(g_rtia_m.rtia001) THEN 
      LET g_sql = g_sql,   
                  " AND mmbo019 = '1' AND mmbo005 = '",g_rtia_m.rtia042,"' "
   ELSE
      LET g_sql = g_sql,   
               "  AND EXISTS(SELECT 1 FROM (SELECT mmaqent,mmaq002,t1.mmag004 vip_level,t2.mmag004 vip_1,t4.mmag004 vip_2,t4.mmag004 vip_3,t5.mmag004 vip_4,t6.mmag004 vip_5  ",                                                                                       
               "                              FROM mmaq_t LEFT JOIN mmag_t t1 ON t1.mmagent = mmaqent AND t1.mmag001 = mmaq003 AND t1.mmag002 = '09' ",                                                                                                                        
               "                                          LEFT JOIN mmag_t t2 ON t2.mmagent = mmaqent AND t2.mmag001 = mmaq003 AND t2.mmag002 = '11' ",
               "                                          LEFT JOIN mmag_t t3 ON t3.mmagent = mmaqent AND t3.mmag001 = mmaq003 AND t3.mmag002 = '12' ",   
               "                                          LEFT JOIN mmag_t t4 ON t4.mmagent = mmaqent AND t4.mmag001 = mmaq003 AND t4.mmag002 = '13' ",   
               "                                          LEFT JOIN mmag_t t5 ON t5.mmagent = mmaqent AND t5.mmag001 = mmaq003 AND t5.mmag002 = '14' ",   
               "                                          LEFT JOIN mmag_t t6 ON t6.mmagent = mmaqent AND t6.mmag001 = mmaq003 AND t6.mmag002 = '15' ",                                                                                           
               "                             WHERE mmaqent = mmbyent AND mmaq001 = '",g_rtia_m.rtia001,"')  ",                                                        
               "            WHERE mmaqent = mmboent ",
               "             AND ((mmbo019 = '1'  AND mmbo005 = mmaq002) OR (mmbo019 = '2' AND mmbo005 = vip_level) ",
               "               OR (mmbo019 = '11' AND mmbo005 = vip_1) OR (mmbo019 = '12' AND mmbo005 = vip_2) ",
               "               OR (mmbo019 = '13' AND mmbo005 = vip_3) OR (mmbo019 = '14' AND mmbo005 = vip_4) OR (mmbo019 = '15' AND mmbo005 = vip_5))) "    
   END IF            
   #160729-00077#20 160817 by lori add---(E)               
   PREPARE ammt450_mmck FROM g_sql
   DECLARE ammt450_mmck_curs CURSOR FOR ammt450_mmck
   
   LET l_day = s_date_get_day(g_rtia_m.rtiadocdt)
   LET l_weekday = WEEKDAY(g_rtia_m.rtiadocdt)

   LET l_mmck004 = ''
   LET l_mmck005 = ''
   LET l_mmck006 = ''
   LET l_mmck007 = ''
   LET l_mmck008 = ''
   LET l_mmck009 = ''
   LET l_flag = 'N'
   LET l_cnt = 0
   FOREACH ammt450_mmck_curs INTO l_mmck004,l_mmck005,l_mmck006,l_mmck007,l_mmck008,l_mmck009
      IF SQLCA.sqlcode THEN
         #150508-00025#1 150507 By pomelo add(S)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.EXTEND = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
         #150508-00025#1 150507 By pomelo add(E)
         #150508-00025#1 150507 By pomelo mark(S)
         #LET g_errno = SQLCA.sqlcode
         #RETURN
         #150508-00025#1 150507 By pomelo mark(E)
      END IF
      LET l_cnt = l_cnt + 1
      #開始日期空白
      IF cl_null(l_mmck004) THEN
         CONTINUE FOREACH
      END IF
      
      #結束日期空白
      IF cl_null(l_mmck005) THEN
         CONTINUE FOREACH
      END IF
      
      #單據日期不存在開始日期與截止日期之中
      IF g_rtia_m.rtiadocdt < l_mmck004 OR g_rtia_m.rtiadocdt > l_mmck005 THEN
         CONTINUE FOREACH
      END IF
      
      #開始時間空白
      IF cl_null(l_mmck006) AND NOT cl_null(l_mmck007) THEN
         #LET g_errno = 'amm-00266'
         CONTINUE FOREACH
      END IF
      
      #結束時間空白
      IF cl_null(l_mmck007) AND NOT cl_null(l_mmck006) THEN
         #LET g_errno = 'amm-00267'
         CONTINUE FOREACH
      END IF
      
      #兌換時間必須在生效的開始時間與生效的結束時間之間，請重新輸入！
      IF NOT cl_null(l_mmck006) AND NOT cl_null(l_mmck007) THEN
         IF l_mmck006 <= g_rtia_m.rtia035 AND l_mmck007 >= g_rtia_m.rtia035 THEN
            LET l_flag = 'Y'
         ELSE
            #LET g_errno = 'amm-00269'
            CONTINUE FOREACH
         END IF
      END IF
      
      #固定日期
      IF NOT cl_null(l_mmck008) THEN
         IF l_mmck008 = l_day THEN
            LET l_flag = 'Y'
         ELSE
            CONTINUE FOREACH
         END IF
      END IF
      
      #固定星期
      IF NOT cl_null(l_mmck009) THEN
         IF l_mmck009 = l_weekday THEN
            LET l_flag = 'Y'
         ELSE
            CONTINUE FOREACH
         END IF
      END IF
      
      IF NOT cl_null(l_mmck004) AND NOT cl_null(l_mmck005) AND cl_null(l_mmck006)
         AND cl_null(l_mmck007) AND cl_null(l_mmck008) AND cl_null(l_mmck009)THEN
         LET l_flag = 'Y'
      END IF
   END FOREACH
   
   #l_cnt >=1 表示有進入foreach 進階段換時間有設定 並且都沒有符合的
   IF l_flag = 'N' AND l_cnt>=1 THEN
      #此單據日期+兌換時間不存在兌換日期時間內，請重新輸入！
      #150508-00025#1 150507 By pomelo add(S)
      IF p_chk_type = 'i' THEN   #160729-00077#20 160820 by lori add
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00307'
         LET g_errparam.EXTEND = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF   #160729-00077#20 160820 by lori add
      
      LET r_success = FALSE
      RETURN r_success
      #150508-00025#1 150507 By pomelo add(E)
      #150508-00025#1 150507 By pomelo mark(S)
      #LET g_errno = 'amm-00307'
      #150508-00025#1 150507 By pomelo mark(E)
   END IF
   
   RETURN r_success  #150508-00025#1 150507 By pomelo add
END FUNCTION

################################################################################
# Descriptions...: 單頭非必填欄位設定
# Memo...........:
# Usage..........: CALL ammt450_set_no_required()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/03 By Lori   #160819-00054#14
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt450_set_no_required()
   CALL cl_set_comp_required("rtia007,rtia066",FALSE)
END FUNCTION

PRIVATE FUNCTION ammt450_rtia037_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia037
   CALL ap_ref_array2(g_ref_fields,"SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? ","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia037_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia037_desc
END FUNCTION
################################################################################
# Descriptions...: 檢查卡號是否已存在未確認贈品換單
# Memo...........:
# Usage..........: CALL ammt450_chk_rtia001()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/14 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_chk_rtia001()
DEFINE l_cnt     LIKE type_t.num5

   LET g_errno = ''
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM rtia_t
    WHERE rtia001 = g_rtia_m.rtia001
      AND rtiastus = 'N'
      AND rtia000 = g_prog_name
      AND rtiadocno != g_rtia_m.rtiadocno
      AND rtiaent = g_enterprise #160905-00007#6 add
   IF l_cnt >=1 THEN
      #此會員卡號已存在未確認贈品換單資料檔中，不可輸入！
      #請查詢[ammt450 累計積點兌換維護作業]後，重新輸入！
      LET g_errno = 'amm-00265'
   END IF
END FUNCTION

################################################################################
# Descriptions...: 單頭必填欄位設定
# Memo...........:
# Usage..........: CALL ammt450_set_required()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/03 By Lori   #160819-00054#14
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt450_set_required()
   IF g_rtia_m.mmby009 = '2' THEN
      CALL cl_set_comp_required("rtia007,rtia066",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 兌換業態combox items設定
# Memo...........:
# Usage..........: CALL ammt450_rtia066_init()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/03 By lori   #160819-00054#14
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt450_rtia066_init()
   DEFINE l_sql         STRING
   DEFINE l_values      STRING
   DEFINE l_items       STRING
   DEFINE l_gzcb002     LIKE gzcb_t.gzcb002
   DEFINE l_cnt         LIKE type_t.num5

   LET l_cnt = 0
   
   IF cl_null(g_rtia_m.rtia044) THEN
      CALL cl_set_combo_scc('rtia066','6201')
      RETURN
   END IF
   
   LET l_sql = "SELECT gzcb002 ",
               "  FROM gzcb_t ",
               " WHERE gzcb001 = '6201' ",
               "   AND gzcb002 IN (SELECT mmci006 ",
               "                     FROM mmci_t,mmbo_t,mmby_t ",
               "                     WHERE mmcient = mmboent AND mmcidocno = mmbodocno ",
               "                      AND mmboent = mmbyent AND mmbo001 = mmby001 AND mmbo002 = mmby002 ",
               "                      AND mmbyent = ",g_enterprise," AND mmbysite = '",g_rtia_m.rtiasite,"' ",
               "                      AND mmby001 = '",g_rtia_m.rtia044,"'  AND mmby002 = '",g_rtia_m.rtia045,"' "
   IF cl_null(g_rtia_m.rtiastus) OR g_rtia_m.rtiastus = 'N' THEN   
      LET l_sql = l_sql,"             AND mmciacti = 'Y' "
   END IF 
   
   IF NOT cl_null(g_rtia_m.rtia007) THEN
      LET l_cnt = ammt450_rtia007_chk()
         
      IF l_cnt > 0 THEN   
         LET l_sql = l_sql,"          AND mmci006 IN (SELECT inaa105 FROM rtib_t,rtdx_t,inaa_t ",
                           "                           WHERE rtibent = rtdxent AND rtibsite = rtdxsite AND rtib004 = rtdx001 ",
                           "                             AND rtdxent = inaaent AND rtdxsite = inaasite AND rtdx044 = inaa001 ",
                           "                             AND rtibent = ",g_enterprise," AND rtibdocno = '",g_rtia_m.rtia007,"') "
      END IF                           
   END IF  

   LET l_sql = l_sql,"             )"

   PREPARE ammt450_rtia066_init_pre FROM l_sql
   DECLARE ammt450_rtia066_init_cur CURSOR FOR ammt450_rtia066_init_pre
   
   LET l_values = ""
   LET l_gzcb002 = ''
   FOREACH ammt450_rtia066_init_cur INTO l_gzcb002
      LET l_values = l_values CLIPPED ,",",l_gzcb002
   END FOREACH
   
   CALL cl_set_combo_scc_part('rtia066','6201',l_values) 
END FUNCTION

################################################################################
# Descriptions...: 取得預設兌換業態
# Memo...........:
# Usage..........: CALL ammt450_rtia066_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/03 By Lori   #160819-00054#14
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt450_rtia066_def()
   
   IF g_rtia_m.mmby009 <> '2' THEN
      RETURN
   END IF
   
   IF g_mmby024 = 'N' THEN
      RETURN
   END IF
   
   SELECT inaa105 INTO g_rtia_m.rtia066 
     FROM rtib_t,rtdx_t,inaa_t
    WHERE rtibent = rtdxent AND rtibsite = rtdxsite AND rtib004 = rtdx001
      AND rtdxent = inaaent AND rtdxsite = inaasite AND rtdx044 = inaa001
      AND rtibent = g_enterprise 
      AND rtibdocno = g_rtia_m.rtia007
      AND rtibseq = (SELECT MIN(rtibseq)        
                       FROM rtib_t,rtdx_t,inaa_t
                      WHERE rtibent = rtdxent AND rtibsite = rtdxsite AND rtib004 = rtdx001
                        AND rtdxent = inaaent AND rtdxsite = inaasite AND rtdx044 = inaa001
                        AND rtibent = g_enterprise AND rtibdocno = g_rtia_m.rtia007 
                        AND inaa105 IN (SELECT mmci006 FROM mmci_t,mmbo_t,mmby_t
                                         WHERE mmcient = mmboent AND mmcidocno = mmbodocno
                                           AND mmboent = mmbyent AND mmbo001 = mmby001 AND mmbo002 = mmby002 
                                           AND mmbyent = g_enterprise AND mmbysite = g_rtia_m.rtiasite
                                           AND mmby001 = g_rtia_m.rtia044 AND mmby002 = g_rtia_m.rtia045
                                           AND mmciacti = 'Y'))

   IF NOT ammt450_rtia007_and_rtia066_chk() THEN
      LET g_rtia_m.rtia066 = NULL
   END IF
                  
   DISPLAY BY NAME g_rtia_m.rtia066   
END FUNCTION

PRIVATE FUNCTION ammt450_rtia036_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtiasite
   LET g_ref_fields[2] = g_rtia_m.rtia036
   CALL ap_ref_array2(g_ref_fields,"SELECT pcaal003 FROM pcaal_t WHERE pcaalent='"||g_enterprise||"' AND pcaalsite=? AND pcaal001=? AND pcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia036_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia036_desc
END FUNCTION

################################################################################
# Descriptions...: 來源單號檢查是否存在於系統中
# Memo...........:
# Usage..........: CALL ammt450_rtia007_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success   檢查正確與否
# Date & Author..: 2016/10/03 By lori   #160819-00054#14
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt450_rtia007_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_cnt = 0
   
   SELECT COUNT(rtjadocno) INTO l_cnt
     FROM rtja_t
    WHERE rtjaent = g_enterprise
      AND rtja033 = g_rtia_m.rtia007  
      AND rtjadocdt BETWEEN g_mmby014 AND g_mmby015  
   
   IF l_cnt = 0 THEN   
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 來源單號與換贈業態校驗,是否重複換贈
# Memo...........:
# Usage..........: CALL ammt450_rtia007_and_rtia066_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success   檢查正確與否
# Date & Author..: 2016/10/03 By lori   #160819-00054#14
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt450_rtia007_and_rtia066_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF cl_null(g_rtia_m.rtia007) OR cl_null(g_rtia_m.rtia066) THEN
      RETURN r_success
   END IF
   
   IF g_mmby024 = 'N' THEN
      LET g_rtia_m.rtia066 = 'ALL'
   END IF
   
   SELECT COUNT(rtiadocno) 
     INTO l_cnt
     FROM rtia_t  
    WHERE rtiaent = g_enterprise
      AND rtiadocno <> g_rtia_m.rtiadocno
      AND rtia000 = g_rtia_m.rtia000
      AND rtia007 = g_rtia_m.rtia007
      AND rtia066 = g_rtia_m.rtia066
      AND rtiastus <> 'X'
   
   IF l_cnt > 0 THEN
      LET r_success = FALSE

      INITIALIZE g_errparam TO NULL
         
      IF g_mmby024 = 'N' THEN
         LET g_errparam.code = 'amm-00791'
         LET g_errparam.replace[1] = g_rtia_m.rtia007
      ELSE
         LET g_errparam.code = 'amm-00790'
         LET g_errparam.replace[1] = g_rtia_m.rtia007
         LET g_errparam.replace[2] = g_rtia_m.rtia066
      END IF
      
      LET g_errparam.popup = TRUE
      CALL cl_err()      
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 卡號帶出說明
# Memo...........:
# Usage..........: CALL ammt450_rtia001_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/13 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt450_rtia001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia001
   CALL ap_ref_array2(g_ref_fields,"SELECT mmaf008 FROM mmaq_t LEFT OUTER JOIN mmaf_t ON mmaq003 = mmaf001 AND mmafent = mmaqent
                                     WHERE mmafent='"||g_enterprise||"' AND mmaq001=? ","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia001_desc
END FUNCTION

 
{</section>}
 
