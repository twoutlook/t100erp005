#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-07-20 16:41:01), PR版次:0009(2016-12-28 18:08:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: ammt500
#+ Description: 會員快速發卡維護作業
#+ Creator....: 08172(2016-06-14 09:54:35)
#+ Modifier...: 07142 -SD/PR- 02749
 
{</section>}
 
{<section id="ammt500.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160215-00002#1   2016/02/18 by sakura  新增"電子發票中獎通知方式"欄位
#160318-00005#23  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160604-00009#122 2016/07/01 by 08172   新增库区
#160706-00018#1   2016/07/08 by 08172   新增出纳收款和组织赠送逻辑
#160705-00042#6   2016/07/12 by sakura  查詢程式段q_ooba002_1開窗，呼叫開窗前的g_qryparam.arg若是要傳入程式代號，要改傳入g_prog
#160816-00068#5   2016/08/17 By earl    調整transaction
#160818-00017#23  2016/08/24 By 08742   删除修改未重新判断状态码
#160824-00007#128 2016/10/31 By 06137   修正舊值備份寫法
#161111-00028#1   2016/11/11 BY 02481   标准程式定义采用宣告模式,弃用.*写法
#161216-00004#5   2016/12/28 By lori    s_artt600_conf_chk、s_artt600_post_chk取消宣告匯總錯誤訊息初始化與顯示,
#                                       主程式調用s_ammt500_conf_upd前須自行宣告匯總錯誤訊息初始化與顯示
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
PRIVATE type type_g_mmaa_m        RECORD
       mmaasite LIKE mmaa_t.mmaasite, 
   mmaasite_desc LIKE type_t.chr80, 
   mmaadocdt LIKE mmaa_t.mmaadocdt, 
   mmaadocno LIKE mmaa_t.mmaadocno, 
   mmaa000 LIKE mmaa_t.mmaa000, 
   mmaa001 LIKE mmaa_t.mmaa001, 
   mmaa020 LIKE mmaa_t.mmaa020, 
   mmaa002 LIKE mmaa_t.mmaa002, 
   mmaa019 LIKE mmaa_t.mmaa019, 
   mmaa019_desc LIKE type_t.chr80, 
   mmaa056 LIKE mmaa_t.mmaa056, 
   mmaa052 LIKE mmaa_t.mmaa052, 
   mmaa052_desc LIKE type_t.chr80, 
   mmaa055 LIKE mmaa_t.mmaa055, 
   mmaa061 LIKE mmaa_t.mmaa061, 
   mmaa061_desc LIKE type_t.chr80, 
   mmaa054 LIKE mmaa_t.mmaa054, 
   mmaastus LIKE mmaa_t.mmaastus, 
   mmaa008 LIKE mmaa_t.mmaa008, 
   mmaa009 LIKE mmaa_t.mmaa009, 
   mmaa014 LIKE mmaa_t.mmaa014, 
   mmaa003 LIKE mmaa_t.mmaa003, 
   mmaa015 LIKE mmaa_t.mmaa015, 
   mmaa013 LIKE mmaa_t.mmaa013, 
   mmaa004 LIKE mmaa_t.mmaa004, 
   mmaa010 LIKE mmaa_t.mmaa010, 
   mmaa024 LIKE mmaa_t.mmaa024, 
   mmaa025 LIKE mmaa_t.mmaa025, 
   mmaa026 LIKE mmaa_t.mmaa026, 
   mmaa027 LIKE mmaa_t.mmaa027, 
   mmaa028 LIKE mmaa_t.mmaa028, 
   mmaa012 LIKE mmaa_t.mmaa012, 
   mmaa011 LIKE mmaa_t.mmaa011, 
   mmaa029 LIKE mmaa_t.mmaa029, 
   mmaa034 LIKE mmaa_t.mmaa034, 
   mmaa039 LIKE mmaa_t.mmaa039, 
   mmaa030 LIKE mmaa_t.mmaa030, 
   mmaa035 LIKE mmaa_t.mmaa035, 
   mmaa040 LIKE mmaa_t.mmaa040, 
   mmaa031 LIKE mmaa_t.mmaa031, 
   mmaa036 LIKE mmaa_t.mmaa036, 
   mmaa041 LIKE mmaa_t.mmaa041, 
   mmaa032 LIKE mmaa_t.mmaa032, 
   mmaa037 LIKE mmaa_t.mmaa037, 
   mmaa042 LIKE mmaa_t.mmaa042, 
   mmaa033 LIKE mmaa_t.mmaa033, 
   mmaa038 LIKE mmaa_t.mmaa038, 
   mmaa043 LIKE mmaa_t.mmaa043, 
   mmaa057 LIKE mmaa_t.mmaa057, 
   mmaa057_desc LIKE type_t.chr80, 
   mmaa047 LIKE mmaa_t.mmaa047, 
   mmaa060 LIKE mmaa_t.mmaa060, 
   mmaa059 LIKE mmaa_t.mmaa059, 
   mmaa048 LIKE mmaa_t.mmaa048, 
   mmaa062 LIKE mmaa_t.mmaa062, 
   mmaa062_desc LIKE type_t.chr80, 
   mmaa044 LIKE mmaa_t.mmaa044, 
   mmaa044_desc LIKE type_t.chr80, 
   mmaa049 LIKE mmaa_t.mmaa049, 
   mmaa058 LIKE mmaa_t.mmaa058, 
   mmaa045 LIKE mmaa_t.mmaa045, 
   mmaa050 LIKE mmaa_t.mmaa050, 
   mmaa046 LIKE mmaa_t.mmaa046, 
   mmaa051 LIKE mmaa_t.mmaa051, 
   mmaaownid LIKE mmaa_t.mmaaownid, 
   mmaaownid_desc LIKE type_t.chr80, 
   mmaaowndp LIKE mmaa_t.mmaaowndp, 
   mmaaowndp_desc LIKE type_t.chr80, 
   mmaacrtid LIKE mmaa_t.mmaacrtid, 
   mmaacrtid_desc LIKE type_t.chr80, 
   mmaacrtdp LIKE mmaa_t.mmaacrtdp, 
   mmaacrtdp_desc LIKE type_t.chr80, 
   mmaacrtdt LIKE mmaa_t.mmaacrtdt, 
   mmaamodid LIKE mmaa_t.mmaamodid, 
   mmaamodid_desc LIKE type_t.chr80, 
   mmaamoddt LIKE mmaa_t.mmaamoddt, 
   mmaacnfid LIKE mmaa_t.mmaacnfid, 
   mmaacnfid_desc LIKE type_t.chr80, 
   mmaacnfdt LIKE mmaa_t.mmaacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mmac_d        RECORD
       mmac001 LIKE mmac_t.mmac001, 
   mmac002 LIKE mmac_t.mmac002, 
   mmac002_desc LIKE type_t.chr500, 
   mmac003 LIKE mmac_t.mmac003, 
   mmacacti LIKE mmac_t.mmacacti
       END RECORD
PRIVATE TYPE type_g_mmac2_d RECORD
       mmae001 LIKE mmae_t.mmae001, 
   mmae002 LIKE mmae_t.mmae002, 
   mmae002_desc LIKE type_t.chr500, 
   mmaeacti LIKE mmae_t.mmaeacti
       END RECORD
PRIVATE TYPE type_g_mmac3_d RECORD
       mmad001 LIKE mmad_t.mmad001, 
   mmad002 LIKE mmad_t.mmad002, 
   mmad002_desc LIKE type_t.chr500, 
   mmadacti LIKE mmad_t.mmadacti
       END RECORD
PRIVATE TYPE type_g_mmac4_d RECORD
       mmab001 LIKE mmab_t.mmab001, 
   mmab002 LIKE mmab_t.mmab002, 
   mmab002_desc LIKE type_t.chr500, 
   mmab003 LIKE mmab_t.mmab003, 
   mmab004 LIKE mmab_t.mmab004, 
   mmab004_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mmaasite LIKE mmaa_t.mmaasite,
   b_mmaasite_desc LIKE type_t.chr80,
      b_mmaadocno LIKE mmaa_t.mmaadocno,
      b_mmaa001 LIKE mmaa_t.mmaa001,
      b_mmaa008 LIKE mmaa_t.mmaa008,
      b_mmaa004 LIKE mmaa_t.mmaa004,
      b_mmaa015 LIKE mmaa_t.mmaa015,
      b_mmaa014 LIKE mmaa_t.mmaa014,
      b_mmaa019 LIKE mmaa_t.mmaa019,
   b_mmaa019_desc LIKE type_t.chr80,
      b_mmaa052 LIKE mmaa_t.mmaa052,
   b_mmaa052_desc LIKE type_t.chr80,
      b_mmaa061 LIKE mmaa_t.mmaa061,
   b_mmaa061_desc LIKE type_t.chr80,
      b_mmaa056 LIKE mmaa_t.mmaa056,
      b_mmaa055 LIKE mmaa_t.mmaa055,
      b_mmaa054 LIKE mmaa_t.mmaa054
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_sign                LIKE type_t.chr1
define g_oocq002             like oocq_t.oocq002
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mmaa_m          type_g_mmaa_m
DEFINE g_mmaa_m_t        type_g_mmaa_m
DEFINE g_mmaa_m_o        type_g_mmaa_m
DEFINE g_mmaa_m_mask_o   type_g_mmaa_m #轉換遮罩前資料
DEFINE g_mmaa_m_mask_n   type_g_mmaa_m #轉換遮罩後資料
 
   DEFINE g_mmaadocno_t LIKE mmaa_t.mmaadocno
 
 
DEFINE g_mmac_d          DYNAMIC ARRAY OF type_g_mmac_d
DEFINE g_mmac_d_t        type_g_mmac_d
DEFINE g_mmac_d_o        type_g_mmac_d
DEFINE g_mmac_d_mask_o   DYNAMIC ARRAY OF type_g_mmac_d #轉換遮罩前資料
DEFINE g_mmac_d_mask_n   DYNAMIC ARRAY OF type_g_mmac_d #轉換遮罩後資料
DEFINE g_mmac2_d          DYNAMIC ARRAY OF type_g_mmac2_d
DEFINE g_mmac2_d_t        type_g_mmac2_d
DEFINE g_mmac2_d_o        type_g_mmac2_d
DEFINE g_mmac2_d_mask_o   DYNAMIC ARRAY OF type_g_mmac2_d #轉換遮罩前資料
DEFINE g_mmac2_d_mask_n   DYNAMIC ARRAY OF type_g_mmac2_d #轉換遮罩後資料
DEFINE g_mmac3_d          DYNAMIC ARRAY OF type_g_mmac3_d
DEFINE g_mmac3_d_t        type_g_mmac3_d
DEFINE g_mmac3_d_o        type_g_mmac3_d
DEFINE g_mmac3_d_mask_o   DYNAMIC ARRAY OF type_g_mmac3_d #轉換遮罩前資料
DEFINE g_mmac3_d_mask_n   DYNAMIC ARRAY OF type_g_mmac3_d #轉換遮罩後資料
DEFINE g_mmac4_d          DYNAMIC ARRAY OF type_g_mmac4_d
DEFINE g_mmac4_d_t        type_g_mmac4_d
DEFINE g_mmac4_d_o        type_g_mmac4_d
DEFINE g_mmac4_d_mask_o   DYNAMIC ARRAY OF type_g_mmac4_d #轉換遮罩前資料
DEFINE g_mmac4_d_mask_n   DYNAMIC ARRAY OF type_g_mmac4_d #轉換遮罩後資料
 
 
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
DEFINE g_site_flag   LIKE type_t.num5 #sakura add
#end add-point
 
{</section>}
 
{<section id="ammt500.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化 name="main.init"
   SELECT ooef004 INTO g_ooef004    FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   LET g_sign = 't'
   SELECT ooaa002 INTO g_oocq002 FROM ooaa_t WHERE ooaa001 = 'E-CIR-0004' AND ooaaent=g_enterprise
   IF NOT cl_null(g_argv[2]) THEN
      LET g_actdefault=g_argv[2]
   END IF
   
    CALL s_aooi390_cre_tmp_table() RETURNING l_success  #150520-00041#1
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mmaasite,'',mmaadocdt,mmaadocno,mmaa000,mmaa001,mmaa020,mmaa002,mmaa019, 
       '',mmaa056,mmaa052,'',mmaa055,mmaa061,'',mmaa054,mmaastus,mmaa008,mmaa009,mmaa014,mmaa003,mmaa015, 
       mmaa013,mmaa004,mmaa010,mmaa024,mmaa025,mmaa026,mmaa027,mmaa028,mmaa012,mmaa011,mmaa029,mmaa034, 
       mmaa039,mmaa030,mmaa035,mmaa040,mmaa031,mmaa036,mmaa041,mmaa032,mmaa037,mmaa042,mmaa033,mmaa038, 
       mmaa043,mmaa057,'',mmaa047,mmaa060,mmaa059,mmaa048,mmaa062,'',mmaa044,'',mmaa049,mmaa058,mmaa045, 
       mmaa050,mmaa046,mmaa051,mmaaownid,'',mmaaowndp,'',mmaacrtid,'',mmaacrtdp,'',mmaacrtdt,mmaamodid, 
       '',mmaamoddt,mmaacnfid,'',mmaacnfdt", 
                      " FROM mmaa_t",
                      " WHERE mmaaent= ? AND mmaadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mmaasite,t0.mmaadocdt,t0.mmaadocno,t0.mmaa000,t0.mmaa001,t0.mmaa020, 
       t0.mmaa002,t0.mmaa019,t0.mmaa056,t0.mmaa052,t0.mmaa055,t0.mmaa061,t0.mmaa054,t0.mmaastus,t0.mmaa008, 
       t0.mmaa009,t0.mmaa014,t0.mmaa003,t0.mmaa015,t0.mmaa013,t0.mmaa004,t0.mmaa010,t0.mmaa024,t0.mmaa025, 
       t0.mmaa026,t0.mmaa027,t0.mmaa028,t0.mmaa012,t0.mmaa011,t0.mmaa029,t0.mmaa034,t0.mmaa039,t0.mmaa030, 
       t0.mmaa035,t0.mmaa040,t0.mmaa031,t0.mmaa036,t0.mmaa041,t0.mmaa032,t0.mmaa037,t0.mmaa042,t0.mmaa033, 
       t0.mmaa038,t0.mmaa043,t0.mmaa057,t0.mmaa047,t0.mmaa060,t0.mmaa059,t0.mmaa048,t0.mmaa062,t0.mmaa044, 
       t0.mmaa049,t0.mmaa058,t0.mmaa045,t0.mmaa050,t0.mmaa046,t0.mmaa051,t0.mmaaownid,t0.mmaaowndp,t0.mmaacrtid, 
       t0.mmaacrtdp,t0.mmaacrtdt,t0.mmaamodid,t0.mmaamoddt,t0.mmaacnfid,t0.mmaacnfdt,t1.ooefl003 ,t2.ooag011 , 
       t3.ooefl003 ,t4.pcab003 ,t5.mmbyl004 ,t6.inayl003 ,t7.mmanl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 , 
       t11.ooefl003 ,t12.ooag011 ,t13.ooag011",
               " FROM mmaa_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mmaa019  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mmaa052 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pcab_t t4 ON t4.pcabent="||g_enterprise||" AND t4.pcab001=t0.mmaa061  ",
               " LEFT JOIN mmbyl_t t5 ON t5.mmbylent="||g_enterprise||" AND t5.mmbylsite=t0.mmaasite AND t5.mmbyl001=t0.mmaa057 AND t5.mmbyl003='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t6 ON t6.inaylent="||g_enterprise||" AND t6.inayl001=t0.mmaa062 AND t6.inayl002='"||g_dlang||"' ",
               " LEFT JOIN mmanl_t t7 ON t7.mmanlent="||g_enterprise||" AND t7.mmanl001=t0.mmaa044 AND t7.mmanl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mmaaownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.mmaaowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.mmaacrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.mmaacrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.mmaamodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.mmaacnfid  ",
 
               " WHERE t0.mmaaent = " ||g_enterprise|| " AND t0.mmaadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   #add by geza 20160702(S)
   LET g_sql = " SELECT DISTINCT t0.mmaasite,t0.mmaadocdt,t0.mmaadocno,t0.mmaa000,t0.mmaa001,t0.mmaa020, 
       t0.mmaa002,t0.mmaa019,t0.mmaa056,t0.mmaa052,t0.mmaa055,t0.mmaa061,t0.mmaa054,t0.mmaastus,t0.mmaa008, 
       t0.mmaa009,t0.mmaa014,t0.mmaa003,t0.mmaa015,t0.mmaa013,t0.mmaa004,t0.mmaa010,t0.mmaa024,t0.mmaa025, 
       t0.mmaa026,t0.mmaa027,t0.mmaa028,t0.mmaa012,t0.mmaa011,t0.mmaa029,t0.mmaa034,t0.mmaa039,t0.mmaa030, 
       t0.mmaa035,t0.mmaa040,t0.mmaa031,t0.mmaa036,t0.mmaa041,t0.mmaa032,t0.mmaa037,t0.mmaa042,t0.mmaa033, 
       t0.mmaa038,t0.mmaa043,t0.mmaa057,t0.mmaa047,t0.mmaa060,t0.mmaa059,t0.mmaa048,t0.mmaa062,t0.mmaa044, 
       t0.mmaa049,t0.mmaa058,t0.mmaa045,t0.mmaa050,t0.mmaa046,t0.mmaa051,t0.mmaaownid,t0.mmaaowndp,t0.mmaacrtid, 
       t0.mmaacrtdp,t0.mmaacrtdt,t0.mmaamodid,t0.mmaamoddt,t0.mmaacnfid,t0.mmaacnfdt,t1.ooefl003 ,t2.ooag011 , 
       t3.ooefl003 ,t4.pcab003 ,t5.mmbyl004 ,t6.inayl003 ,t7.mmanl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 , 
       t11.ooefl003 ,t12.ooag011 ,t13.ooag011",
               " FROM mmaa_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.mmaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=t0.mmaa019  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.mmaa052 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pcab_t t4 ON t4.pcabent='"||g_enterprise||"' AND t4.pcab001=t0.mmaa061  ",
               " LEFT JOIN mmbyl_t t5 ON t5.mmbylent='"||g_enterprise||"' AND t5.mmbylsite=t0.mmaaent AND t5.mmbyl001=t0.mmaa057 AND t5.mmbyl003='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t6 ON t6.inaylent='"||g_enterprise||"' AND t6.inayl001=t0.mmaa062 AND t6.inayl002='"||g_dlang||"' ",
               " LEFT JOIN mmanl_t t7 ON t7.mmanlent='"||g_enterprise||"' AND t7.mmanl001=t0.mmaa044 AND t7.mmanl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.mmaaownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=t0.mmaaowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent='"||g_enterprise||"' AND t10.ooag001=t0.mmaacrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent='"||g_enterprise||"' AND t11.ooefl001=t0.mmaacrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent='"||g_enterprise||"' AND t12.ooag001=t0.mmaamodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent='"||g_enterprise||"' AND t13.ooag001=t0.mmaacnfid  ",
 
               " WHERE t0.mmaaent = '" ||g_enterprise|| "' AND t0.mmaadocno = ?"
   #add by geza 20160702(E)
   #end add-point
   PREPARE ammt500_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammt500 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammt500_init()   
 
      #進入選單 Menu (="N")
      CALL ammt500_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammt500
      
   END IF 
   
   CLOSE ammt500_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   CALL s_aooi390_drop_tmp_table()             #150520-00041#1
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ammt500.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ammt500_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add
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
      CALL cl_set_combo_scc_part('mmaastus','13','N,Y,D,R,W,A,X')
 
      CALL cl_set_combo_scc('mmaa000','32') 
   CALL cl_set_combo_scc('mmaa003','6501') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add

   LET g_chkparam.arg1 = g_user
   CALL cl_ref_val("v_ooef006")
   CALL cl_set_comp_entry("mmaastus",false)
   CALL cl_set_combo_scc('mmaa000','6942') 
   LET g_mmaa_m.mmaa019=g_user
   CALL ammt500_mmaa024_scc()
  #CALL ammt500_mmaa025_scc()
  #CALL ammt500_mmaa026_scc()
  #CALL ammt500_mmaa027_scc()
  #CALL ammt500_mmaa028_scc()
   CALL ammt500_vip_acc('mmaa029','2016')
   CALL ammt500_vip_acc('mmaa030','2017')
   CALL ammt500_vip_acc('mmaa031','2018')
   CALL ammt500_vip_acc('mmaa032','2019')
   CALL ammt500_vip_acc('mmaa033','2020')
   CALL ammt500_vip_acc('mmaa034','2021')
   CALL ammt500_vip_acc('mmaa035','2022')
   CALL ammt500_vip_acc('mmaa036','2023')
   CALL ammt500_vip_acc('mmaa038','2024')
   CALL ammt500_vip_acc('mmaa037','2025')
   CALL ammt500_vip_acc('mmaa039','2026')
   CALL ammt500_vip_acc('mmaa040','2027')
   CALL ammt500_vip_acc('mmaa041','2028')
   CALL ammt500_vip_acc('mmaa042','2029')
   CALL ammt500_vip_acc('mmaa043','2030')
   
   CALL cl_set_toolbaritem_visible('update_mmaa001',FALSE)   #160701-00013#1

   #end add-point
   
   #初始化搜尋條件
   CALL ammt500_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="ammt500.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION ammt500_ui_dialog()
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
   DEFINE l_rtia048   LIKE rtia_t.rtia048
   DEFINE l_prog      LIKE rtia_t.rtia000
   DEFINE l_cnt       LIKE type_t.num5   #160706-00018#1
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
            CALL ammt500_insert()
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
         INITIALIZE g_mmaa_m.* TO NULL
         CALL g_mmac_d.clear()
         CALL g_mmac2_d.clear()
         CALL g_mmac3_d.clear()
         CALL g_mmac4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ammt500_init()
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
               
               CALL ammt500_fetch('') # reload data
               LET l_ac = 1
               CALL ammt500_ui_detailshow() #Setting the current row 
         
               CALL ammt500_idx_chk()
               #NEXT FIELD mmac002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mmac_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt500_idx_chk()
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
               CALL ammt500_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_mmac2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt500_idx_chk()
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
               CALL ammt500_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mmac3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt500_idx_chk()
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
               CALL ammt500_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mmac4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt500_idx_chk()
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
               CALL ammt500_idx_chk()
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
            CALL ammt500_browser_fill("")
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
               CALL ammt500_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL ammt500_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL ammt500_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL ammt500_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL ammt500_set_act_visible()   
            CALL ammt500_set_act_no_visible()
            IF NOT (g_mmaa_m.mmaadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mmaaent = " ||g_enterprise|| " AND",
                                  " mmaadocno = '", g_mmaa_m.mmaadocno, "' "
 
               #填到對應位置
               CALL ammt500_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "mmaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmac_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmae_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mmad_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mmab_t" 
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
               CALL ammt500_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "mmaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmac_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmae_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mmad_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mmab_t" 
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
                  CALL ammt500_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammt500_fetch("F")
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
               CALL ammt500_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL ammt500_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt500_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL ammt500_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt500_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL ammt500_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt500_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL ammt500_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt500_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL ammt500_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt500_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mmac_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mmac2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_mmac3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_mmac4_d)
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
               NEXT FIELD mmac002
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
               CALL ammt500_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL ammt500_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION demo
            LET g_action_choice="demo"
            IF cl_auth_chk_act("demo") THEN
               
               #add-point:ON ACTION demo name="menu.demo"
               CALL aooi360_02('6','ammt500',g_mmaa_m.mmaadocno,'','','','','','','','','')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ammt500_pay_detail
            LET g_action_choice="ammt500_pay_detail"
            IF cl_auth_chk_act("ammt500_pay_detail") THEN
               
               #add-point:ON ACTION ammt500_pay_detail name="menu.ammt500_pay_detail"
               CALL s_pay_09(g_mmaa_m.mmaa058)
               LET g_action_choice= ""
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL ammt500_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammt500_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION pay_money
            LET g_action_choice="pay_money"
            IF cl_auth_chk_act("pay_money") THEN
               
               #add-point:ON ACTION pay_money name="menu.pay_money"
               #160706-00018#1 -s by 08172
               IF NOT cl_null(g_mmaa_m.mmaadocno) THEN
                  #160706-00018#1 -s by 08172
                  IF g_mmaa_m.mmaa054 = 'Y' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00599'
                     LET g_errparam.extend = g_mmaa_m.mmaa058
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  ELSE
                  #160706-00018#1 -e by 08172
                     IF g_mmaa_m.mmaastus  = 'N' THEN
                        LET l_cnt = 0
                        SELECT COUNT(*) INTO l_cnt
                          FROM rtif_t
                         WHERE rtifent = g_enterprise
                           AND rtifdocno = g_mmaa_m.mmaa058
                        IF l_cnt > 0 THEN    
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'amm-00484'
                           LET g_errparam.extend = g_mmaa_m.mmaadocno
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           CONTINUE DIALOG
                        ELSE
                           CALL s_transaction_begin()
                           IF g_mmaa_m.mmaa055 = 'N' THEN
                              UPDATE mmaa_t SET mmaa055 = 'Y'
                               WHERE mmaaent = g_enterprise
                                 AND mmaadocno = g_mmaa_m.mmaadocno
                              IF SQLCA.sqlcode THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = SQLCA.sqlcode
                                 LET g_errparam.extend = "update mmaa_t"
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()
                                 CALL s_transaction_end("N","0")
                                 CONTINUE DIALOG
                              END IF
                              UPDATE rtia_t SET rtia053 = 'Y'
                               WHERE rtiaent = g_enterprise
                                 AND rtiadocno = g_mmaa_m.mmaa058
                              IF SQLCA.sqlcode THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = SQLCA.sqlcode
                                 LET g_errparam.extend = "update rtia_t"
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()
                                 CALL s_transaction_end("N","0")
                                 CONTINUE DIALOG
                              END IF                               
                              CALL s_transaction_end("Y","0")                            
                           ELSE                           
                              UPDATE mmaa_t SET mmaa055 = 'N'
                               WHERE mmaaent = g_enterprise
                                 AND mmaadocno = g_mmaa_m.mmaadocno
                              IF SQLCA.sqlcode THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = SQLCA.sqlcode
                                 LET g_errparam.extend = "update mmaa_t"
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()
                                 CALL s_transaction_end("N","0")
                                 CONTINUE DIALOG    
                              END IF
                              UPDATE rtia_t SET rtia053 = 'N'
                               WHERE rtiaent = g_enterprise
                                 AND rtiadocno = g_mmaa_m.mmaa058
                              IF SQLCA.sqlcode THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = SQLCA.sqlcode
                                 LET g_errparam.extend = "update rtia_t"
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()
                                 CALL s_transaction_end("N","0")
                                 CONTINUE DIALOG
                              END IF                               
                              CALL s_transaction_end("Y","0")                            
                           END IF
                        END IF 
                     ELSE   
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "art-00608" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CONTINUE DIALOG 
                     END IF
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "std-00003" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CONTINUE DIALOG             
               END IF
               CALL ammt500_fetch("")
               #160706-00018#1 -s by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amm/ammt500_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amm/ammt500_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ammt500_pay
            LET g_action_choice="ammt500_pay"
            IF cl_auth_chk_act("ammt500_pay") THEN
               
               #add-point:ON ACTION ammt500_pay name="menu.ammt500_pay"
               IF g_mmaa_m.mmaastus = 'X' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00398'
                  LET g_errparam.extend = g_mmaa_m.mmaa058
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
                  #160706-00018#1 -s by 08172
                  IF g_mmaa_m.mmaa054 = 'Y' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00599'
                     LET g_errparam.extend = g_mmaa_m.mmaa058
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                  #160706-00018#1 -e by 08172
                     IF g_mmaa_m.mmaa056 = 'N' OR cl_null(g_mmaa_m.mmaa056) THEN
                        LET l_prog = g_prog
                        IF g_mmaa_m.mmaa000 = '3' THEN
                           LET g_prog = 'ammt425'
                        ELSE
                           LET g_prog = 'ammt405'
                        END IF
                        
                        CALL s_pay('rtia_t',1,g_mmaa_m.mmaa058)
                        LET g_prog = l_prog
                        SELECT rtia048 INTO l_rtia048 FROM rtia_t
                         WHERE rtiaent = g_enterprise
                           AND rtiadocno =  g_mmaa_m.mmaa058
                        IF g_mmaa_m.mmaastus = 'N' AND l_rtia048 = 'Y' THEN     
                           UPDATE mmaa_t SET mmaa056 = 'Y'
                            WHERE mmaaent = g_enterprise
                              AND mmaadocno = g_mmaa_m.mmaadocno
                           LET g_mmaa_m.mmaa056 = 'Y'
                           DISPLAY BY NAME g_mmaa_m.mmaa056
                        END IF
                     ELSE
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'art-00576'
                        LET g_errparam.extend = g_mmaa_m.mmaa058
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF
                  END IF                     
               END IF 
               LET g_action_choice= ""
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammt500_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_mmaa001
            LET g_action_choice="update_mmaa001"
            IF cl_auth_chk_act("update_mmaa001") THEN
               
               #add-point:ON ACTION update_mmaa001 name="menu.update_mmaa001"
               IF g_mmaa_m.mmaastus<>'N'  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00760"
                  LET g_errparam.extend = g_mmaa_m.mmaadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               ELSE
                  CALL cl_set_comp_entry("mmaa001",TRUE)
                  CALL ammt500_update_mmaa001()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammt500_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt500_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt500_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mmaa_m.mmaadocdt)
 
 
 
         
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
 
{<section id="ammt500.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION ammt500_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'mmaasite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where," AND mmaa000 IN ('1','2','3') "
   LET l_wc  = g_wc.trim() 
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT mmaadocno ",
                      " FROM mmaa_t ",
                      " ",
                      " LEFT JOIN mmac_t ON mmacent = mmaaent AND mmaadocno = mmacdocno ", "  ",
                      #add-point:browser_fill段sql(mmac_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN mmae_t ON mmaeent = mmaaent AND mmaadocno = mmaedocno", "  ",
                      #add-point:browser_fill段sql(mmae_t1) name="browser_fill.cnt.join.mmae_t1"
                      
                      #end add-point
 
                      " LEFT JOIN mmad_t ON mmadent = mmaaent AND mmaadocno = mmaddocno", "  ",
                      #add-point:browser_fill段sql(mmad_t1) name="browser_fill.cnt.join.mmad_t1"
                      
                      #end add-point
 
                      " LEFT JOIN mmab_t ON mmabent = mmaaent AND mmaadocno = mmabdocno", "  ",
                      #add-point:browser_fill段sql(mmab_t1) name="browser_fill.cnt.join.mmab_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE mmaaent = " ||g_enterprise|| " AND mmacent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mmaa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mmaadocno ",
                      " FROM mmaa_t ", 
                      "  ",
                      "  ",
                      " WHERE mmaaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mmaa_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
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
      INITIALIZE g_mmaa_m.* TO NULL
      CALL g_mmac_d.clear()        
      CALL g_mmac2_d.clear() 
      CALL g_mmac3_d.clear() 
      CALL g_mmac4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mmaasite,t0.mmaadocno,t0.mmaa001,t0.mmaa008,t0.mmaa004,t0.mmaa015,t0.mmaa014,t0.mmaa019,t0.mmaa052,t0.mmaa061,t0.mmaa056,t0.mmaa055,t0.mmaa054 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmaastus,t0.mmaasite,t0.mmaadocno,t0.mmaa001,t0.mmaa008,t0.mmaa004, 
          t0.mmaa015,t0.mmaa014,t0.mmaa019,t0.mmaa052,t0.mmaa061,t0.mmaa056,t0.mmaa055,t0.mmaa054,t1.ooefl003 , 
          t2.ooag011 ,t3.ooefl003 ,t4.pcab003 ",
                  " FROM mmaa_t t0",
                  "  ",
                  "  LEFT JOIN mmac_t ON mmacent = mmaaent AND mmaadocno = mmacdocno ", "  ", 
                  #add-point:browser_fill段sql(mmac_t1) name="browser_fill.join.mmac_t1"
                  
                  #end add-point
                  "  LEFT JOIN mmae_t ON mmaeent = mmaaent AND mmaadocno = mmaedocno", "  ", 
                  #add-point:browser_fill段sql(mmae_t1) name="browser_fill.join.mmae_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mmad_t ON mmadent = mmaaent AND mmaadocno = mmaddocno", "  ", 
                  #add-point:browser_fill段sql(mmad_t1) name="browser_fill.join.mmad_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mmab_t ON mmabent = mmaaent AND mmaadocno = mmabdocno", "  ", 
                  #add-point:browser_fill段sql(mmab_t1) name="browser_fill.join.mmab_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mmaa019  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mmaa052 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pcab_t t4 ON t4.pcabent="||g_enterprise||" AND t4.pcab001=t0.mmaa061  ",
 
                  " WHERE t0.mmaaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mmaa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmaastus,t0.mmaasite,t0.mmaadocno,t0.mmaa001,t0.mmaa008,t0.mmaa004, 
          t0.mmaa015,t0.mmaa014,t0.mmaa019,t0.mmaa052,t0.mmaa061,t0.mmaa056,t0.mmaa055,t0.mmaa054,t1.ooefl003 , 
          t2.ooag011 ,t3.ooefl003 ,t4.pcab003 ",
                  " FROM mmaa_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mmaa019  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mmaa052 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pcab_t t4 ON t4.pcabent="||g_enterprise||" AND t4.pcab001=t0.mmaa061  ",
 
                  " WHERE t0.mmaaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mmaa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mmaadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmaasite,g_browser[g_cnt].b_mmaadocno, 
          g_browser[g_cnt].b_mmaa001,g_browser[g_cnt].b_mmaa008,g_browser[g_cnt].b_mmaa004,g_browser[g_cnt].b_mmaa015, 
          g_browser[g_cnt].b_mmaa014,g_browser[g_cnt].b_mmaa019,g_browser[g_cnt].b_mmaa052,g_browser[g_cnt].b_mmaa061, 
          g_browser[g_cnt].b_mmaa056,g_browser[g_cnt].b_mmaa055,g_browser[g_cnt].b_mmaa054,g_browser[g_cnt].b_mmaasite_desc, 
          g_browser[g_cnt].b_mmaa019_desc,g_browser[g_cnt].b_mmaa052_desc,g_browser[g_cnt].b_mmaa061_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
         #遮罩相關處理
         CALL ammt500_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
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
   
   IF cl_null(g_browser[g_cnt].b_mmaadocno) THEN
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
 
{<section id="ammt500.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION ammt500_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mmaa_m.mmaadocno = g_browser[g_current_idx].b_mmaadocno   
 
   EXECUTE ammt500_master_referesh USING g_mmaa_m.mmaadocno INTO g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt, 
       g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000,g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019, 
       g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus, 
       g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013, 
       g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027, 
       g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039, 
       g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041, 
       g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043, 
       g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060,g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062, 
       g_mmaa_m.mmaa044,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046, 
       g_mmaa_m.mmaa051,g_mmaa_m.mmaaownid,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaacrtid,g_mmaa_m.mmaacrtdp, 
       g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfdt, 
       g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa061_desc,g_mmaa_m.mmaa057_desc, 
       g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044_desc,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid_desc, 
       g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaacnfid_desc
   
   CALL ammt500_mmaa_t_mask()
   CALL ammt500_show()
      
END FUNCTION
 
{</section>}
 
{<section id="ammt500.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION ammt500_ui_detailshow()
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
 
{<section id="ammt500.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION ammt500_ui_browser_refresh()
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
      IF g_browser[l_i].b_mmaadocno = g_mmaa_m.mmaadocno 
 
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
 
{<section id="ammt500.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammt500_construct()
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
   INITIALIZE g_mmaa_m.* TO NULL
   CALL g_mmac_d.clear()        
   CALL g_mmac2_d.clear() 
   CALL g_mmac3_d.clear() 
   CALL g_mmac4_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON mmaasite,mmaadocdt,mmaadocno,mmaa000,mmaa001,mmaa020,mmaa002,mmaa019, 
          mmaa056,mmaa052,mmaa055,mmaa061,mmaa054,mmaastus,mmaa008,mmaa009,mmaa014,mmaa003,mmaa015,mmaa013, 
          mmaa004,mmaa010,mmaa024,mmaa025,mmaa026,mmaa027,mmaa028,mmaa012,mmaa011,mmaa029,mmaa034,mmaa039, 
          mmaa030,mmaa035,mmaa040,mmaa031,mmaa036,mmaa041,mmaa032,mmaa037,mmaa042,mmaa033,mmaa038,mmaa043, 
          mmaa057,mmaa047,mmaa060,mmaa059,mmaa048,mmaa062,mmaa044,mmaa049,mmaa058,mmaa045,mmaa050,mmaa046, 
          mmaa051,mmaaownid,mmaaowndp,mmaacrtid,mmaacrtdp,mmaacrtdt,mmaamodid,mmaamoddt,mmaacnfid,mmaacnfdt 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmaacrtdt>>----
         AFTER FIELD mmaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mmaamoddt>>----
         AFTER FIELD mmaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmaacnfdt>>----
         AFTER FIELD mmaacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmaapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mmaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaasite
            #add-point:ON ACTION controlp INFIELD mmaasite name="construct.c.mmaasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaasite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO mmaasite  #顯示到畫面上
            NEXT FIELD mmaasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaasite
            #add-point:BEFORE FIELD mmaasite name="construct.b.mmaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaasite
            
            #add-point:AFTER FIELD mmaasite name="construct.a.mmaasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaadocdt
            #add-point:BEFORE FIELD mmaadocdt name="construct.b.mmaadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaadocdt
            
            #add-point:AFTER FIELD mmaadocdt name="construct.a.mmaadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaadocdt
            #add-point:ON ACTION controlp INFIELD mmaadocdt name="construct.c.mmaadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaadocno
            #add-point:ON ACTION controlp INFIELD mmaadocno name="construct.c.mmaadocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " mmaa000 IN ('1','2','3') AND mmaaent='",g_enterprise,"'"
            CALL q_mmaadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaadocno  #顯示到畫面上

            NEXT FIELD mmaadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaadocno
            #add-point:BEFORE FIELD mmaadocno name="construct.b.mmaadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaadocno
            
            #add-point:AFTER FIELD mmaadocno name="construct.a.mmaadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa000
            #add-point:BEFORE FIELD mmaa000 name="construct.b.mmaa000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa000
            
            #add-point:AFTER FIELD mmaa000 name="construct.a.mmaa000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa000
            #add-point:ON ACTION controlp INFIELD mmaa000 name="construct.c.mmaa000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa001
            #add-point:ON ACTION controlp INFIELD mmaa001 name="construct.c.mmaa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa001  #顯示到畫面上

            NEXT FIELD mmaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa001
            #add-point:BEFORE FIELD mmaa001 name="construct.b.mmaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa001
            
            #add-point:AFTER FIELD mmaa001 name="construct.a.mmaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa020
            #add-point:ON ACTION controlp INFIELD mmaa020 name="construct.c.mmaa020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM mmaf_t WHERE mmafent = mmaqent AND mmaq003 = mmaf001 )"
            CALL q_mmbe001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa020  #顯示到畫面上
            NEXT FIELD mmaa020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa020
            #add-point:BEFORE FIELD mmaa020 name="construct.b.mmaa020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa020
            
            #add-point:AFTER FIELD mmaa020 name="construct.a.mmaa020"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa002
            #add-point:BEFORE FIELD mmaa002 name="construct.b.mmaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa002
            
            #add-point:AFTER FIELD mmaa002 name="construct.a.mmaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa002
            #add-point:ON ACTION controlp INFIELD mmaa002 name="construct.c.mmaa002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaa019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa019
            #add-point:ON ACTION controlp INFIELD mmaa019 name="construct.c.mmaa019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO mmaa019  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD mmaa019                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa019
            #add-point:BEFORE FIELD mmaa019 name="construct.b.mmaa019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa019
            
            #add-point:AFTER FIELD mmaa019 name="construct.a.mmaa019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa056
            #add-point:BEFORE FIELD mmaa056 name="construct.b.mmaa056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa056
            
            #add-point:AFTER FIELD mmaa056 name="construct.a.mmaa056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa056
            #add-point:ON ACTION controlp INFIELD mmaa056 name="construct.c.mmaa056"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaa052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa052
            #add-point:ON ACTION controlp INFIELD mmaa052 name="construct.c.mmaa052"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa052  #顯示到畫面上
            NEXT FIELD mmaa052                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa052
            #add-point:BEFORE FIELD mmaa052 name="construct.b.mmaa052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa052
            
            #add-point:AFTER FIELD mmaa052 name="construct.a.mmaa052"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa055
            #add-point:BEFORE FIELD mmaa055 name="construct.b.mmaa055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa055
            
            #add-point:AFTER FIELD mmaa055 name="construct.a.mmaa055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa055
            #add-point:ON ACTION controlp INFIELD mmaa055 name="construct.c.mmaa055"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaa061
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa061
            #add-point:ON ACTION controlp INFIELD mmaa061 name="construct.c.mmaa061"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pcab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa061  #顯示到畫面上
            NEXT FIELD mmaa061                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa061
            #add-point:BEFORE FIELD mmaa061 name="construct.b.mmaa061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa061
            
            #add-point:AFTER FIELD mmaa061 name="construct.a.mmaa061"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa054
            #add-point:BEFORE FIELD mmaa054 name="construct.b.mmaa054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa054
            
            #add-point:AFTER FIELD mmaa054 name="construct.a.mmaa054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa054
            #add-point:ON ACTION controlp INFIELD mmaa054 name="construct.c.mmaa054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaastus
            #add-point:BEFORE FIELD mmaastus name="construct.b.mmaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaastus
            
            #add-point:AFTER FIELD mmaastus name="construct.a.mmaastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaastus
            #add-point:ON ACTION controlp INFIELD mmaastus name="construct.c.mmaastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa008
            #add-point:BEFORE FIELD mmaa008 name="construct.b.mmaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa008
            
            #add-point:AFTER FIELD mmaa008 name="construct.a.mmaa008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa008
            #add-point:ON ACTION controlp INFIELD mmaa008 name="construct.c.mmaa008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa009
            #add-point:BEFORE FIELD mmaa009 name="construct.b.mmaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa009
            
            #add-point:AFTER FIELD mmaa009 name="construct.a.mmaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa009
            #add-point:ON ACTION controlp INFIELD mmaa009 name="construct.c.mmaa009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa014
            #add-point:BEFORE FIELD mmaa014 name="construct.b.mmaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa014
            
            #add-point:AFTER FIELD mmaa014 name="construct.a.mmaa014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa014
            #add-point:ON ACTION controlp INFIELD mmaa014 name="construct.c.mmaa014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa003
            #add-point:BEFORE FIELD mmaa003 name="construct.b.mmaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa003
            
            #add-point:AFTER FIELD mmaa003 name="construct.a.mmaa003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa003
            #add-point:ON ACTION controlp INFIELD mmaa003 name="construct.c.mmaa003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa015
            #add-point:BEFORE FIELD mmaa015 name="construct.b.mmaa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa015
            
            #add-point:AFTER FIELD mmaa015 name="construct.a.mmaa015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa015
            #add-point:ON ACTION controlp INFIELD mmaa015 name="construct.c.mmaa015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa013
            #add-point:BEFORE FIELD mmaa013 name="construct.b.mmaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa013
            
            #add-point:AFTER FIELD mmaa013 name="construct.a.mmaa013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa013
            #add-point:ON ACTION controlp INFIELD mmaa013 name="construct.c.mmaa013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa004
            #add-point:BEFORE FIELD mmaa004 name="construct.b.mmaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa004
            
            #add-point:AFTER FIELD mmaa004 name="construct.a.mmaa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa004
            #add-point:ON ACTION controlp INFIELD mmaa004 name="construct.c.mmaa004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa010
            #add-point:ON ACTION controlp INFIELD mmaa010 name="construct.c.mmaa010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocn002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa010  #顯示到畫面上

            NEXT FIELD mmaa010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa010
            #add-point:BEFORE FIELD mmaa010 name="construct.b.mmaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa010
            
            #add-point:AFTER FIELD mmaa010 name="construct.a.mmaa010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa024
            #add-point:ON ACTION controlp INFIELD mmaa024 name="construct.c.mmaa024"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa024  #顯示到畫面上
            NEXT FIELD mmaa024                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa024
            #add-point:BEFORE FIELD mmaa024 name="construct.b.mmaa024"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa024
            
            #add-point:AFTER FIELD mmaa024 name="construct.a.mmaa024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa025
            #add-point:ON ACTION controlp INFIELD mmaa025 name="construct.c.mmaa025"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooci002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa025  #顯示到畫面上
            NEXT FIELD mmaa025                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa025
            #add-point:BEFORE FIELD mmaa025 name="construct.b.mmaa025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa025
            
            #add-point:AFTER FIELD mmaa025 name="construct.a.mmaa025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa026
            #add-point:ON ACTION controlp INFIELD mmaa026 name="construct.c.mmaa026"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oock003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa026  #顯示到畫面上
            NEXT FIELD mmaa026                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa026
            #add-point:BEFORE FIELD mmaa026 name="construct.b.mmaa026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa026
            
            #add-point:AFTER FIELD mmaa026 name="construct.a.mmaa026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa027
            #add-point:ON ACTION controlp INFIELD mmaa027 name="construct.c.mmaa027"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocm004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa027  #顯示到畫面上
            NEXT FIELD mmaa027                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa027
            #add-point:BEFORE FIELD mmaa027 name="construct.b.mmaa027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa027
            
            #add-point:AFTER FIELD mmaa027 name="construct.a.mmaa027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa028
            #add-point:ON ACTION controlp INFIELD mmaa028 name="construct.c.mmaa028"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooco005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa028  #顯示到畫面上
            NEXT FIELD mmaa028                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa028
            #add-point:BEFORE FIELD mmaa028 name="construct.b.mmaa028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa028
            
            #add-point:AFTER FIELD mmaa028 name="construct.a.mmaa028"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa012
            #add-point:BEFORE FIELD mmaa012 name="construct.b.mmaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa012
            
            #add-point:AFTER FIELD mmaa012 name="construct.a.mmaa012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa012
            #add-point:ON ACTION controlp INFIELD mmaa012 name="construct.c.mmaa012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa011
            #add-point:BEFORE FIELD mmaa011 name="construct.b.mmaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa011
            
            #add-point:AFTER FIELD mmaa011 name="construct.a.mmaa011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa011
            #add-point:ON ACTION controlp INFIELD mmaa011 name="construct.c.mmaa011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaa029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa029
            #add-point:ON ACTION controlp INFIELD mmaa029 name="construct.c.mmaa029"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa029  #顯示到畫面上
            NEXT FIELD mmaa029                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa029
            #add-point:BEFORE FIELD mmaa029 name="construct.b.mmaa029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa029
            
            #add-point:AFTER FIELD mmaa029 name="construct.a.mmaa029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa034
            #add-point:ON ACTION controlp INFIELD mmaa034 name="construct.c.mmaa034"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa034  #顯示到畫面上
            NEXT FIELD mmaa034                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa034
            #add-point:BEFORE FIELD mmaa034 name="construct.b.mmaa034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa034
            
            #add-point:AFTER FIELD mmaa034 name="construct.a.mmaa034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa039
            #add-point:ON ACTION controlp INFIELD mmaa039 name="construct.c.mmaa039"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa039  #顯示到畫面上
            NEXT FIELD mmaa039                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa039
            #add-point:BEFORE FIELD mmaa039 name="construct.b.mmaa039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa039
            
            #add-point:AFTER FIELD mmaa039 name="construct.a.mmaa039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa030
            #add-point:ON ACTION controlp INFIELD mmaa030 name="construct.c.mmaa030"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa030  #顯示到畫面上
            NEXT FIELD mmaa030                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa030
            #add-point:BEFORE FIELD mmaa030 name="construct.b.mmaa030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa030
            
            #add-point:AFTER FIELD mmaa030 name="construct.a.mmaa030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa035
            #add-point:ON ACTION controlp INFIELD mmaa035 name="construct.c.mmaa035"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa035  #顯示到畫面上
            NEXT FIELD mmaa035                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa035
            #add-point:BEFORE FIELD mmaa035 name="construct.b.mmaa035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa035
            
            #add-point:AFTER FIELD mmaa035 name="construct.a.mmaa035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa040
            #add-point:ON ACTION controlp INFIELD mmaa040 name="construct.c.mmaa040"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa040  #顯示到畫面上
            NEXT FIELD mmaa040                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa040
            #add-point:BEFORE FIELD mmaa040 name="construct.b.mmaa040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa040
            
            #add-point:AFTER FIELD mmaa040 name="construct.a.mmaa040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa031
            #add-point:ON ACTION controlp INFIELD mmaa031 name="construct.c.mmaa031"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa031  #顯示到畫面上
            NEXT FIELD mmaa031                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa031
            #add-point:BEFORE FIELD mmaa031 name="construct.b.mmaa031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa031
            
            #add-point:AFTER FIELD mmaa031 name="construct.a.mmaa031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa036
            #add-point:ON ACTION controlp INFIELD mmaa036 name="construct.c.mmaa036"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa036  #顯示到畫面上
            NEXT FIELD mmaa036                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa036
            #add-point:BEFORE FIELD mmaa036 name="construct.b.mmaa036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa036
            
            #add-point:AFTER FIELD mmaa036 name="construct.a.mmaa036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa041
            #add-point:ON ACTION controlp INFIELD mmaa041 name="construct.c.mmaa041"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa041  #顯示到畫面上
            NEXT FIELD mmaa041                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa041
            #add-point:BEFORE FIELD mmaa041 name="construct.b.mmaa041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa041
            
            #add-point:AFTER FIELD mmaa041 name="construct.a.mmaa041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa032
            #add-point:ON ACTION controlp INFIELD mmaa032 name="construct.c.mmaa032"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa032  #顯示到畫面上
            NEXT FIELD mmaa032                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa032
            #add-point:BEFORE FIELD mmaa032 name="construct.b.mmaa032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa032
            
            #add-point:AFTER FIELD mmaa032 name="construct.a.mmaa032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa037
            #add-point:ON ACTION controlp INFIELD mmaa037 name="construct.c.mmaa037"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa037  #顯示到畫面上
            NEXT FIELD mmaa037                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa037
            #add-point:BEFORE FIELD mmaa037 name="construct.b.mmaa037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa037
            
            #add-point:AFTER FIELD mmaa037 name="construct.a.mmaa037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa042
            #add-point:ON ACTION controlp INFIELD mmaa042 name="construct.c.mmaa042"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa042  #顯示到畫面上
            NEXT FIELD mmaa042                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa042
            #add-point:BEFORE FIELD mmaa042 name="construct.b.mmaa042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa042
            
            #add-point:AFTER FIELD mmaa042 name="construct.a.mmaa042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa033
            #add-point:ON ACTION controlp INFIELD mmaa033 name="construct.c.mmaa033"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa033  #顯示到畫面上
            NEXT FIELD mmaa033                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa033
            #add-point:BEFORE FIELD mmaa033 name="construct.b.mmaa033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa033
            
            #add-point:AFTER FIELD mmaa033 name="construct.a.mmaa033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa038
            #add-point:ON ACTION controlp INFIELD mmaa038 name="construct.c.mmaa038"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa038  #顯示到畫面上
            NEXT FIELD mmaa038                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa038
            #add-point:BEFORE FIELD mmaa038 name="construct.b.mmaa038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa038
            
            #add-point:AFTER FIELD mmaa038 name="construct.a.mmaa038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa043
            #add-point:ON ACTION controlp INFIELD mmaa043 name="construct.c.mmaa043"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa043  #顯示到畫面上
            NEXT FIELD mmaa043                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa043
            #add-point:BEFORE FIELD mmaa043 name="construct.b.mmaa043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa043
            
            #add-point:AFTER FIELD mmaa043 name="construct.a.mmaa043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa057
            #add-point:ON ACTION controlp INFIELD mmaa057 name="construct.c.mmaa057"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2' 
            LET g_qryparam.where=" mmby015 >= '",g_today,"'"

            CALL q_mmby001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa057  #顯示到畫面上
            NEXT FIELD mmaa057                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa057
            #add-point:BEFORE FIELD mmaa057 name="construct.b.mmaa057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa057
            
            #add-point:AFTER FIELD mmaa057 name="construct.a.mmaa057"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa047
            #add-point:BEFORE FIELD mmaa047 name="construct.b.mmaa047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa047
            
            #add-point:AFTER FIELD mmaa047 name="construct.a.mmaa047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa047
            #add-point:ON ACTION controlp INFIELD mmaa047 name="construct.c.mmaa047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa060
            #add-point:BEFORE FIELD mmaa060 name="construct.b.mmaa060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa060
            
            #add-point:AFTER FIELD mmaa060 name="construct.a.mmaa060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa060
            #add-point:ON ACTION controlp INFIELD mmaa060 name="construct.c.mmaa060"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaa059
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa059
            #add-point:ON ACTION controlp INFIELD mmaa059 name="construct.c.mmaa059"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa059  #顯示到畫面上
            NEXT FIELD mmaa059                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa059
            #add-point:BEFORE FIELD mmaa059 name="construct.b.mmaa059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa059
            
            #add-point:AFTER FIELD mmaa059 name="construct.a.mmaa059"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa048
            #add-point:BEFORE FIELD mmaa048 name="construct.b.mmaa048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa048
            
            #add-point:AFTER FIELD mmaa048 name="construct.a.mmaa048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa048
            #add-point:ON ACTION controlp INFIELD mmaa048 name="construct.c.mmaa048"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaa062
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa062
            #add-point:ON ACTION controlp INFIELD mmaa062 name="construct.c.mmaa062"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inaa102='6'"
            CALL q_inaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa062  #顯示到畫面上
            NEXT FIELD mmaa062                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa062
            #add-point:BEFORE FIELD mmaa062 name="construct.b.mmaa062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa062
            
            #add-point:AFTER FIELD mmaa062 name="construct.a.mmaa062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa044
            #add-point:ON ACTION controlp INFIELD mmaa044 name="construct.c.mmaa044"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaa044  #顯示到畫面上
            NEXT FIELD mmaa044                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa044
            #add-point:BEFORE FIELD mmaa044 name="construct.b.mmaa044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa044
            
            #add-point:AFTER FIELD mmaa044 name="construct.a.mmaa044"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa049
            #add-point:BEFORE FIELD mmaa049 name="construct.b.mmaa049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa049
            
            #add-point:AFTER FIELD mmaa049 name="construct.a.mmaa049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa049
            #add-point:ON ACTION controlp INFIELD mmaa049 name="construct.c.mmaa049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa058
            #add-point:BEFORE FIELD mmaa058 name="construct.b.mmaa058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa058
            
            #add-point:AFTER FIELD mmaa058 name="construct.a.mmaa058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa058
            #add-point:ON ACTION controlp INFIELD mmaa058 name="construct.c.mmaa058"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa045
            #add-point:BEFORE FIELD mmaa045 name="construct.b.mmaa045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa045
            
            #add-point:AFTER FIELD mmaa045 name="construct.a.mmaa045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa045
            #add-point:ON ACTION controlp INFIELD mmaa045 name="construct.c.mmaa045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa050
            #add-point:BEFORE FIELD mmaa050 name="construct.b.mmaa050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa050
            
            #add-point:AFTER FIELD mmaa050 name="construct.a.mmaa050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa050
            #add-point:ON ACTION controlp INFIELD mmaa050 name="construct.c.mmaa050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa046
            #add-point:BEFORE FIELD mmaa046 name="construct.b.mmaa046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa046
            
            #add-point:AFTER FIELD mmaa046 name="construct.a.mmaa046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa046
            #add-point:ON ACTION controlp INFIELD mmaa046 name="construct.c.mmaa046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa051
            #add-point:BEFORE FIELD mmaa051 name="construct.b.mmaa051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa051
            
            #add-point:AFTER FIELD mmaa051 name="construct.a.mmaa051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaa051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa051
            #add-point:ON ACTION controlp INFIELD mmaa051 name="construct.c.mmaa051"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaaownid
            #add-point:ON ACTION controlp INFIELD mmaaownid name="construct.c.mmaaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaaownid  #顯示到畫面上

            NEXT FIELD mmaaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaaownid
            #add-point:BEFORE FIELD mmaaownid name="construct.b.mmaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaaownid
            
            #add-point:AFTER FIELD mmaaownid name="construct.a.mmaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaaowndp
            #add-point:ON ACTION controlp INFIELD mmaaowndp name="construct.c.mmaaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaaowndp  #顯示到畫面上

            NEXT FIELD mmaaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaaowndp
            #add-point:BEFORE FIELD mmaaowndp name="construct.b.mmaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaaowndp
            
            #add-point:AFTER FIELD mmaaowndp name="construct.a.mmaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaacrtid
            #add-point:ON ACTION controlp INFIELD mmaacrtid name="construct.c.mmaacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaacrtid  #顯示到畫面上

            NEXT FIELD mmaacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaacrtid
            #add-point:BEFORE FIELD mmaacrtid name="construct.b.mmaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaacrtid
            
            #add-point:AFTER FIELD mmaacrtid name="construct.a.mmaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaacrtdp
            #add-point:ON ACTION controlp INFIELD mmaacrtdp name="construct.c.mmaacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaacrtdp  #顯示到畫面上

            NEXT FIELD mmaacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaacrtdp
            #add-point:BEFORE FIELD mmaacrtdp name="construct.b.mmaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaacrtdp
            
            #add-point:AFTER FIELD mmaacrtdp name="construct.a.mmaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaacrtdt
            #add-point:BEFORE FIELD mmaacrtdt name="construct.b.mmaacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaamodid
            #add-point:ON ACTION controlp INFIELD mmaamodid name="construct.c.mmaamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaamodid  #顯示到畫面上

            NEXT FIELD mmaamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaamodid
            #add-point:BEFORE FIELD mmaamodid name="construct.b.mmaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaamodid
            
            #add-point:AFTER FIELD mmaamodid name="construct.a.mmaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaamoddt
            #add-point:BEFORE FIELD mmaamoddt name="construct.b.mmaamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaacnfid
            #add-point:ON ACTION controlp INFIELD mmaacnfid name="construct.c.mmaacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaacnfid  #顯示到畫面上

            NEXT FIELD mmaacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaacnfid
            #add-point:BEFORE FIELD mmaacnfid name="construct.b.mmaacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaacnfid
            
            #add-point:AFTER FIELD mmaacnfid name="construct.a.mmaacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaacnfdt
            #add-point:BEFORE FIELD mmaacnfdt name="construct.b.mmaacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mmac001,mmac002,mmac003,mmacacti
           FROM s_detail1[1].mmac001,s_detail1[1].mmac002,s_detail1[1].mmac003,s_detail1[1].mmacacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmac001
            #add-point:BEFORE FIELD mmac001 name="construct.b.page1.mmac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmac001
            
            #add-point:AFTER FIELD mmac001 name="construct.a.page1.mmac001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmac001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmac001
            #add-point:ON ACTION controlp INFIELD mmac001 name="construct.c.page1.mmac001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmac002
            #add-point:ON ACTION controlp INFIELD mmac002 name="construct.c.page1.mmac002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2050"        #應用分類  #160106-00002#8 20160204 add by beckxie
            #160106-00002#8 20160204 mark by beckxie---S
            #if not cl_null(g_oocq002) then
            #   let g_qryparam.where = "oocq002!='",g_oocq002,"'"
            #end if   
            #160106-00002#8 20160204 mark by beckxie---E
            CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.where = null
            DISPLAY g_qryparam.return1 TO mmac002  #顯示到畫面上

            NEXT FIELD mmac002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmac002
            #add-point:BEFORE FIELD mmac002 name="construct.b.page1.mmac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmac002
            
            #add-point:AFTER FIELD mmac002 name="construct.a.page1.mmac002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmac003
            #add-point:BEFORE FIELD mmac003 name="construct.b.page1.mmac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmac003
            
            #add-point:AFTER FIELD mmac003 name="construct.a.page1.mmac003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmac003
            #add-point:ON ACTION controlp INFIELD mmac003 name="construct.c.page1.mmac003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmacacti
            #add-point:BEFORE FIELD mmacacti name="construct.b.page1.mmacacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmacacti
            
            #add-point:AFTER FIELD mmacacti name="construct.a.page1.mmacacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmacacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmacacti
            #add-point:ON ACTION controlp INFIELD mmacacti name="construct.c.page1.mmacacti"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON mmae001,mmae002,mmaeacti
           FROM s_detail2[1].mmae001,s_detail2[1].mmae002,s_detail2[1].mmaeacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmae001
            #add-point:BEFORE FIELD mmae001 name="construct.b.page2.mmae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmae001
            
            #add-point:AFTER FIELD mmae001 name="construct.a.page2.mmae001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmae001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmae001
            #add-point:ON ACTION controlp INFIELD mmae001 name="construct.c.page2.mmae001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mmae002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmae002
            #add-point:ON ACTION controlp INFIELD mmae002 name="construct.c.page2.mmae002"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmae002  #顯示到畫面上

            NEXT FIELD mmae002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmae002
            #add-point:BEFORE FIELD mmae002 name="construct.b.page2.mmae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmae002
            
            #add-point:AFTER FIELD mmae002 name="construct.a.page2.mmae002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaeacti
            #add-point:BEFORE FIELD mmaeacti name="construct.b.page2.mmaeacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaeacti
            
            #add-point:AFTER FIELD mmaeacti name="construct.a.page2.mmaeacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmaeacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaeacti
            #add-point:ON ACTION controlp INFIELD mmaeacti name="construct.c.page2.mmaeacti"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON mmad001,mmad002,mmadacti
           FROM s_detail3[1].mmad001,s_detail3[1].mmad002,s_detail3[1].mmadacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmad001
            #add-point:BEFORE FIELD mmad001 name="construct.b.page3.mmad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmad001
            
            #add-point:AFTER FIELD mmad001 name="construct.a.page3.mmad001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmad001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmad001
            #add-point:ON ACTION controlp INFIELD mmad001 name="construct.c.page3.mmad001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.mmad002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmad002
            #add-point:ON ACTION controlp INFIELD mmad002 name="construct.c.page3.mmad002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmad002  #顯示到畫面上

            NEXT FIELD mmad002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmad002
            #add-point:BEFORE FIELD mmad002 name="construct.b.page3.mmad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmad002
            
            #add-point:AFTER FIELD mmad002 name="construct.a.page3.mmad002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmadacti
            #add-point:BEFORE FIELD mmadacti name="construct.b.page3.mmadacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmadacti
            
            #add-point:AFTER FIELD mmadacti name="construct.a.page3.mmadacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmadacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmadacti
            #add-point:ON ACTION controlp INFIELD mmadacti name="construct.c.page3.mmadacti"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON mmab001,mmab002,mmab003,mmab004
           FROM s_detail4[1].mmab001,s_detail4[1].mmab002,s_detail4[1].mmab003,s_detail4[1].mmab004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmab001
            #add-point:BEFORE FIELD mmab001 name="construct.b.page4.mmab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmab001
            
            #add-point:AFTER FIELD mmab001 name="construct.a.page4.mmab001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmab001
            #add-point:ON ACTION controlp INFIELD mmab001 name="construct.c.page4.mmab001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.mmab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmab002
            #add-point:ON ACTION controlp INFIELD mmab002 name="construct.c.page4.mmab002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmab002  #顯示到畫面上

            NEXT FIELD mmab002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmab002
            #add-point:BEFORE FIELD mmab002 name="construct.b.page4.mmab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmab002
            
            #add-point:AFTER FIELD mmab002 name="construct.a.page4.mmab002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmab003
            #add-point:BEFORE FIELD mmab003 name="construct.b.page4.mmab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmab003
            
            #add-point:AFTER FIELD mmab003 name="construct.a.page4.mmab003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmab003
            #add-point:ON ACTION controlp INFIELD mmab003 name="construct.c.page4.mmab003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.mmab004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmab004
            #add-point:ON ACTION controlp INFIELD mmab004 name="construct.c.page4.mmab004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmab004  #顯示到畫面上

            NEXT FIELD mmab004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmab004
            #add-point:BEFORE FIELD mmab004 name="construct.b.page4.mmab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmab004
            
            #add-point:AFTER FIELD mmab004 name="construct.a.page4.mmab004"
            
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
                  WHEN la_wc[li_idx].tableid = "mmaa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmac_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmae_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "mmad_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "mmab_t" 
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
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION ammt500_filter()
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
      CONSTRUCT g_wc_filter ON mmaasite,mmaadocno,mmaa001,mmaa008,mmaa004,mmaa015,mmaa014,mmaa019,mmaa052, 
          mmaa061,mmaa056,mmaa055,mmaa054
                          FROM s_browse[1].b_mmaasite,s_browse[1].b_mmaadocno,s_browse[1].b_mmaa001, 
                              s_browse[1].b_mmaa008,s_browse[1].b_mmaa004,s_browse[1].b_mmaa015,s_browse[1].b_mmaa014, 
                              s_browse[1].b_mmaa019,s_browse[1].b_mmaa052,s_browse[1].b_mmaa061,s_browse[1].b_mmaa056, 
                              s_browse[1].b_mmaa055,s_browse[1].b_mmaa054
 
         BEFORE CONSTRUCT
               DISPLAY ammt500_filter_parser('mmaasite') TO s_browse[1].b_mmaasite
            DISPLAY ammt500_filter_parser('mmaadocno') TO s_browse[1].b_mmaadocno
            DISPLAY ammt500_filter_parser('mmaa001') TO s_browse[1].b_mmaa001
            DISPLAY ammt500_filter_parser('mmaa008') TO s_browse[1].b_mmaa008
            DISPLAY ammt500_filter_parser('mmaa004') TO s_browse[1].b_mmaa004
            DISPLAY ammt500_filter_parser('mmaa015') TO s_browse[1].b_mmaa015
            DISPLAY ammt500_filter_parser('mmaa014') TO s_browse[1].b_mmaa014
            DISPLAY ammt500_filter_parser('mmaa019') TO s_browse[1].b_mmaa019
            DISPLAY ammt500_filter_parser('mmaa052') TO s_browse[1].b_mmaa052
            DISPLAY ammt500_filter_parser('mmaa061') TO s_browse[1].b_mmaa061
            DISPLAY ammt500_filter_parser('mmaa056') TO s_browse[1].b_mmaa056
            DISPLAY ammt500_filter_parser('mmaa055') TO s_browse[1].b_mmaa055
            DISPLAY ammt500_filter_parser('mmaa054') TO s_browse[1].b_mmaa054
      
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
 
      CALL ammt500_filter_show('mmaasite')
   CALL ammt500_filter_show('mmaadocno')
   CALL ammt500_filter_show('mmaa001')
   CALL ammt500_filter_show('mmaa008')
   CALL ammt500_filter_show('mmaa004')
   CALL ammt500_filter_show('mmaa015')
   CALL ammt500_filter_show('mmaa014')
   CALL ammt500_filter_show('mmaa019')
   CALL ammt500_filter_show('mmaa052')
   CALL ammt500_filter_show('mmaa061')
   CALL ammt500_filter_show('mmaa056')
   CALL ammt500_filter_show('mmaa055')
   CALL ammt500_filter_show('mmaa054')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION ammt500_filter_parser(ps_field)
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
 
{<section id="ammt500.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION ammt500_filter_show(ps_field)
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
   LET ls_condition = ammt500_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION ammt500_query()
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
   CALL g_mmac_d.clear()
   CALL g_mmac2_d.clear()
   CALL g_mmac3_d.clear()
   CALL g_mmac4_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL ammt500_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL ammt500_browser_fill("")
      CALL ammt500_fetch("")
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
      CALL ammt500_filter_show('mmaasite')
   CALL ammt500_filter_show('mmaadocno')
   CALL ammt500_filter_show('mmaa001')
   CALL ammt500_filter_show('mmaa008')
   CALL ammt500_filter_show('mmaa004')
   CALL ammt500_filter_show('mmaa015')
   CALL ammt500_filter_show('mmaa014')
   CALL ammt500_filter_show('mmaa019')
   CALL ammt500_filter_show('mmaa052')
   CALL ammt500_filter_show('mmaa061')
   CALL ammt500_filter_show('mmaa056')
   CALL ammt500_filter_show('mmaa055')
   CALL ammt500_filter_show('mmaa054')
   CALL ammt500_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL ammt500_fetch("F") 
      #顯示單身筆數
      CALL ammt500_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION ammt500_fetch(p_flag)
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
   
   LET g_mmaa_m.mmaadocno = g_browser[g_current_idx].b_mmaadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE ammt500_master_referesh USING g_mmaa_m.mmaadocno INTO g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt, 
       g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000,g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019, 
       g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus, 
       g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013, 
       g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027, 
       g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039, 
       g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041, 
       g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043, 
       g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060,g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062, 
       g_mmaa_m.mmaa044,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046, 
       g_mmaa_m.mmaa051,g_mmaa_m.mmaaownid,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaacrtid,g_mmaa_m.mmaacrtdp, 
       g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfdt, 
       g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa061_desc,g_mmaa_m.mmaa057_desc, 
       g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044_desc,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid_desc, 
       g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaacnfid_desc
   
   #遮罩相關處理
   LET g_mmaa_m_mask_o.* =  g_mmaa_m.*
   CALL ammt500_mmaa_t_mask()
   LET g_mmaa_m_mask_n.* =  g_mmaa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt500_set_act_visible()   
   CALL ammt500_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_mmaa_m.mmaastus <> "N" THEN
      CALL cl_set_act_visible("delete,modify", FALSE)
   ELSE
      CALL cl_set_act_visible("delete,modify", true)    
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mmaa_m_t.* = g_mmaa_m.*
   LET g_mmaa_m_o.* = g_mmaa_m.*
   
   LET g_data_owner = g_mmaa_m.mmaaownid      
   LET g_data_dept  = g_mmaa_m.mmaaowndp
   
   #重新顯示   
   CALL ammt500_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammt500_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5    #sakura add
   DEFINE l_doctype     LIKE rtai_t.rtai004 #sakura add
   DEFINE l_cnt         LIKE type_t.num5    #160604-00009#122   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mmac_d.clear()   
   CALL g_mmac2_d.clear()  
   CALL g_mmac3_d.clear()  
   CALL g_mmac4_d.clear()  
 
 
   INITIALIZE g_mmaa_m.* TO NULL             #DEFAULT 設定
   
   LET g_mmaadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmaa_m.mmaaownid = g_user
      LET g_mmaa_m.mmaaowndp = g_dept
      LET g_mmaa_m.mmaacrtid = g_user
      LET g_mmaa_m.mmaacrtdp = g_dept 
      LET g_mmaa_m.mmaacrtdt = cl_get_current()
      LET g_mmaa_m.mmaamodid = g_user
      LET g_mmaa_m.mmaamoddt = cl_get_current()
      LET g_mmaa_m.mmaastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mmaa_m.mmaastus = "N"
      LET g_mmaa_m.mmaa060 = "0"
      LET g_mmaa_m.mmaa048 = "0"
      LET g_mmaa_m.mmaa045 = "0"
      LET g_mmaa_m.mmaa050 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      LET g_mmaa_m.mmaadocdt = g_today
#      LET g_mmaa_m.mmaa018 = g_site
#      CALL ammt500_display_mmaa018()
#      LET g_mmaa_m.mmaasite = g_site
      LET g_mmaa_m.mmaa000='1'
      IF g_mmaa_m.mmaa000='1' THEN 
         LET g_mmaa_m.mmaa002=1
      END IF
      CALL s_aooi500_default(g_prog,'mmaasite',g_mmaa_m.mmaasite) RETURNING l_insert,g_mmaa_m.mmaasite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL ammt500_display_mmaasite()
      #sakura---add---str
      #預設單據的單別
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_mmaa_m.mmaasite,g_prog,'1')
         RETURNING l_success,l_doctype
      LET g_mmaa_m.mmaadocno = l_doctype      
      LET g_site_flag = FALSE
      #sakura---add---end
      INITIALIZE g_mmaa_m_t.* TO NULL
      let g_sign = 'a'
      LET g_mmaa_m_t.* = g_mmaa_m.* #sakura add
      LET g_mmaa_m_o.* = g_mmaa_m.* #sakura add  
      LET g_mmaa_m.mmaa019 = g_user #add by geza 150616-00035#27  
      CALL ammt500_display_mmaa019()  #add by geza 150616-00035#27
      SELECT ooag003 INTO g_mmaa_m.mmaa052
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_mmaa_m.mmaa019
      CALL ammt500_display_mmaa052()
       
      #預設收銀員
      SELECT pcab001 INTO g_mmaa_m.mmaa061
        FROM pcab_t,pcac_t
       WHERE pcabent = g_enterprise
         AND pcab002 = g_user
         AND pcacent = pcabent
         AND pcac001 = pcab001
         AND pcac002 = g_mmaa_m.mmaasite
         AND pcacstus = 'Y'
         AND pcabstus = 'Y'
      CALL ammt500_display_mmaa061()
      LET g_mmaa_m.mmaa003 = '1'  #add by geza 20151103 
      LET g_mmaa_m.mmaa054='N' 
      LET g_mmaa_m.mmaa055='N'
      LET g_mmaa_m.mmaa056='N' 
      LET g_mmaa_m.mmaa045=NULL
      LET g_mmaa_m.mmaa048=NULL
      LET g_mmaa_m.mmaa050=NULL
      LET g_mmaa_m.mmaa060=NULL
      
      LET g_mmaa_m.mmaa056='N'  
      CALL ammt500_vip_default()  
      select oofb013,oofb012,oofb014,oofb015,oofb016
        into g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,
             g_mmaa_m.mmaa027
        from oofb_t
        LEFT JOIN ooef_t ON oofbent = ooefent AND ooef012 = oofb002
       where ooefent=g_enterprise  and ooef001=g_mmaa_m.mmaasite  and oofb008='1' and oofb010='Y'
      CALL ammt500_mmaa025_scc()
      CALL ammt500_mmaa026_scc()
      CALL ammt500_mmaa027_scc()
      CALL ammt500_mmaa028_scc()
      #160604-00009#122 -s by 08172
      #预设库区
      LET l_cnt=0
      SELECT COUNT(*) INTO l_cnt
        FROM inaa_t
       WHERE inaaent=g_enterprise
         AND inaasite=g_mmaa_m.mmaasite
         AND inaa102='6'
      IF l_cnt=1 THEN
         SELECT inaa001 INTO g_mmaa_m.mmaa062
           FROM inaa_t
          WHERE inaaent=g_enterprise
            AND inaasite=g_mmaa_m.mmaasite
            AND inaa102='6'
         CALL ammt500_mmaa062_ref()
      END IF
      IF g_mmaa_m.mmaa003 ='1' or  g_mmaa_m.mmaa003 ='2' THEN
         CALL cl_set_comp_required("mmaa004",TRUE)
      ELSE
         CALL cl_set_comp_required("mmaa004",FALSE)            
      END IF
      LET g_mmaa_m.mmaa054 = 'N'
      LET g_mmaa_m.mmaa055 = 'N'
      LET g_mmaa_m.mmaa056 = 'N'
      #160604-00009#122 -e by 08172
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mmaa_m_t.* = g_mmaa_m.*
      LET g_mmaa_m_o.* = g_mmaa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmaa_m.mmaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL ammt500_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      let g_sign = 't'
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
         INITIALIZE g_mmaa_m.* TO NULL
         INITIALIZE g_mmac_d TO NULL
         INITIALIZE g_mmac2_d TO NULL
         INITIALIZE g_mmac3_d TO NULL
         INITIALIZE g_mmac4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL ammt500_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mmac_d.clear()
      #CALL g_mmac2_d.clear()
      #CALL g_mmac3_d.clear()
      #CALL g_mmac4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt500_set_act_visible()   
   CALL ammt500_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmaadocno_t = g_mmaa_m.mmaadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmaaent = " ||g_enterprise|| " AND",
                      " mmaadocno = '", g_mmaa_m.mmaadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt500_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE ammt500_cl
   
   CALL ammt500_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE ammt500_master_referesh USING g_mmaa_m.mmaadocno INTO g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt, 
       g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000,g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019, 
       g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus, 
       g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013, 
       g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027, 
       g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039, 
       g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041, 
       g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043, 
       g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060,g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062, 
       g_mmaa_m.mmaa044,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046, 
       g_mmaa_m.mmaa051,g_mmaa_m.mmaaownid,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaacrtid,g_mmaa_m.mmaacrtdp, 
       g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfdt, 
       g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa061_desc,g_mmaa_m.mmaa057_desc, 
       g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044_desc,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid_desc, 
       g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaacnfid_desc
   
   
   #遮罩相關處理
   LET g_mmaa_m_mask_o.* =  g_mmaa_m.*
   CALL ammt500_mmaa_t_mask()
   LET g_mmaa_m_mask_n.* =  g_mmaa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmaa_m.mmaasite,g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaadocdt,g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000, 
       g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa056, 
       g_mmaa_m.mmaa052,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa061_desc, 
       g_mmaa_m.mmaa054,g_mmaa_m.mmaastus,g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003, 
       g_mmaa_m.mmaa015,g_mmaa_m.mmaa013,g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025, 
       g_mmaa_m.mmaa026,g_mmaa_m.mmaa027,g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029, 
       g_mmaa_m.mmaa034,g_mmaa_m.mmaa039,g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031, 
       g_mmaa_m.mmaa036,g_mmaa_m.mmaa041,g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033, 
       g_mmaa_m.mmaa038,g_mmaa_m.mmaa043,g_mmaa_m.mmaa057,g_mmaa_m.mmaa057_desc,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060, 
       g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062,g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044,g_mmaa_m.mmaa044_desc, 
       g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046,g_mmaa_m.mmaa051, 
       g_mmaa_m.mmaaownid,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid, 
       g_mmaa_m.mmaacrtid_desc,g_mmaa_m.mmaacrtdp,g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid, 
       g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfid_desc,g_mmaa_m.mmaacnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mmaa_m.mmaaownid      
   LET g_data_dept  = g_mmaa_m.mmaaowndp
   
   #功能已完成,通報訊息中心
   CALL ammt500_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammt500_modify()
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
   LET g_mmaa_m_t.* = g_mmaa_m.*
   LET g_mmaa_m_o.* = g_mmaa_m.*
   
   IF g_mmaa_m.mmaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mmaadocno_t = g_mmaa_m.mmaadocno
 
   CALL s_transaction_begin()
   
   OPEN ammt500_cl USING g_enterprise,g_mmaa_m.mmaadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt500_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt500_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt500_master_referesh USING g_mmaa_m.mmaadocno INTO g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt, 
       g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000,g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019, 
       g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus, 
       g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013, 
       g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027, 
       g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039, 
       g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041, 
       g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043, 
       g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060,g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062, 
       g_mmaa_m.mmaa044,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046, 
       g_mmaa_m.mmaa051,g_mmaa_m.mmaaownid,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaacrtid,g_mmaa_m.mmaacrtdp, 
       g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfdt, 
       g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa061_desc,g_mmaa_m.mmaa057_desc, 
       g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044_desc,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid_desc, 
       g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaacnfid_desc
   
   #檢查是否允許此動作
   IF NOT ammt500_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmaa_m_mask_o.* =  g_mmaa_m.*
   CALL ammt500_mmaa_t_mask()
   LET g_mmaa_m_mask_n.* =  g_mmaa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   #检查是否有收款资料
   LET g_cnt = 0
   SELECT COUNT(*) INTO g_cnt
     FROM rtif_t
    WHERE rtifent = g_enterprise
      AND rtifdocno = g_mmaa_m.mmaa058
   IF g_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "art-00397"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
       
      RETURN
   END IF
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
 
 
   
   CALL ammt500_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
 
 
    
   WHILE TRUE
      LET g_mmaadocno_t = g_mmaa_m.mmaadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mmaa_m.mmaamodid = g_user 
LET g_mmaa_m.mmaamoddt = cl_get_current()
LET g_mmaa_m.mmaamodid_desc = cl_get_username(g_mmaa_m.mmaamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      let g_sign = 'u'
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_mmaa_m.mmaastus MATCHES "[DR]" THEN
         LET g_mmaa_m.mmaastus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL ammt500_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      let g_sign = 't'
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mmaa_t SET (mmaamodid,mmaamoddt) = (g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt)
          WHERE mmaaent = g_enterprise AND mmaadocno = g_mmaadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mmaa_m.* = g_mmaa_m_t.*
            CALL ammt500_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mmaa_m.mmaadocno != g_mmaa_m_t.mmaadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mmac_t SET mmacdocno = g_mmaa_m.mmaadocno
 
          WHERE mmacent = g_enterprise AND mmacdocno = g_mmaa_m_t.mmaadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmac_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmac_t:",SQLERRMESSAGE 
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
         
         UPDATE mmae_t
            SET mmaedocno = g_mmaa_m.mmaadocno
 
          WHERE mmaeent = g_enterprise AND
                mmaedocno = g_mmaadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmae_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmae_t:",SQLERRMESSAGE 
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
         
         UPDATE mmad_t
            SET mmaddocno = g_mmaa_m.mmaadocno
 
          WHERE mmadent = g_enterprise AND
                mmaddocno = g_mmaadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmad_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmad_t:",SQLERRMESSAGE 
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
         
         UPDATE mmab_t
            SET mmabdocno = g_mmaa_m.mmaadocno
 
          WHERE mmabent = g_enterprise AND
                mmabdocno = g_mmaadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmab_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmab_t:",SQLERRMESSAGE 
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
   CALL ammt500_set_act_visible()   
   CALL ammt500_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mmaaent = " ||g_enterprise|| " AND",
                      " mmaadocno = '", g_mmaa_m.mmaadocno, "' "
 
   #填到對應位置
   CALL ammt500_browser_fill("")
 
   CLOSE ammt500_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt500_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="ammt500.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammt500_input(p_cmd)
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
   DEFINE  g_mmac004       LIKE mmac_t.mmac004
   DEFINE  g_mmac005       LIKE mmac_t.mmac005
   DEFINE  g_mmac006       LIKE mmac_t.mmac006
   DEFINE  l_flag1         LIKE type_t.num5
   DEFINE  l_flag2         LIKE type_t.num5
   DEFINE  l_m             INT 
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_errno         LIKE type_t.chr10
   DEFINE l_doctype        LIKE rtia_t.rtiadocno
   
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   DEFINE  l_mmaa004       STRING
   DEFINE  l_ooef011       LIKE ooef_t.ooef011
   DEFINE  l_mmaa014       STRING
   DEFINE  l_mmby005       LIKE mmby_t.mmby005
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
   DISPLAY BY NAME g_mmaa_m.mmaasite,g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaadocdt,g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000, 
       g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa056, 
       g_mmaa_m.mmaa052,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa061_desc, 
       g_mmaa_m.mmaa054,g_mmaa_m.mmaastus,g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003, 
       g_mmaa_m.mmaa015,g_mmaa_m.mmaa013,g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025, 
       g_mmaa_m.mmaa026,g_mmaa_m.mmaa027,g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029, 
       g_mmaa_m.mmaa034,g_mmaa_m.mmaa039,g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031, 
       g_mmaa_m.mmaa036,g_mmaa_m.mmaa041,g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033, 
       g_mmaa_m.mmaa038,g_mmaa_m.mmaa043,g_mmaa_m.mmaa057,g_mmaa_m.mmaa057_desc,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060, 
       g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062,g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044,g_mmaa_m.mmaa044_desc, 
       g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046,g_mmaa_m.mmaa051, 
       g_mmaa_m.mmaaownid,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid, 
       g_mmaa_m.mmaacrtid_desc,g_mmaa_m.mmaacrtdp,g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid, 
       g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfid_desc,g_mmaa_m.mmaacnfdt 
 
   
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
   LET g_forupd_sql = "SELECT mmac001,mmac002,mmac003,mmacacti FROM mmac_t WHERE mmacent=? AND mmacdocno=?  
       AND mmac002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt500_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmae001,mmae002,mmaeacti FROM mmae_t WHERE mmaeent=? AND mmaedocno=? AND  
       mmae002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt500_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmad001,mmad002,mmadacti FROM mmad_t WHERE mmadent=? AND mmaddocno=? AND  
       mmad002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt500_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmab001,mmab002,mmab003,mmab004 FROM mmab_t WHERE mmabent=? AND mmabdocno=?  
       AND mmab002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt500_bcl4 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL ammt500_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL ammt500_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt,g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000,g_mmaa_m.mmaa001, 
       g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019,g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa055, 
       g_mmaa_m.mmaa061,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus,g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014, 
       g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013,g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024, 
       g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027,g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011, 
       g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039,g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040, 
       g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041,g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042, 
       g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043,g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060, 
       g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062,g_mmaa_m.mmaa044,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058, 
       g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046,g_mmaa_m.mmaa051
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   let g_errshow=1
   SELECT ooef004 INTO g_ooef004    FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site    
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="ammt500.input.head" >}
      #單頭段
      INPUT BY NAME g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt,g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000,g_mmaa_m.mmaa001, 
          g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019,g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa055, 
          g_mmaa_m.mmaa061,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus,g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014, 
          g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013,g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024, 
          g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027,g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011, 
          g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039,g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040, 
          g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041,g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042, 
          g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043,g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060, 
          g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062,g_mmaa_m.mmaa044,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058, 
          g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046,g_mmaa_m.mmaa051 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN ammt500_cl USING g_enterprise,g_mmaa_m.mmaadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL ammt500_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"

            LET g_mmaadocno_t = g_mmaa_m.mmaadocno
            #end add-point
            CALL ammt500_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaasite
            
            #add-point:AFTER FIELD mmaasite name="input.a.mmaasite"
            IF NOT cl_null(g_mmaa_m.mmaasite) THEN 
#此段落由子樣板a19產生
               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_mmaa_m.mmaasite
#               LET g_chkparam.arg2 = '8'
#               LET g_chkparam.arg3 = g_site
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooed004") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_mmaa_m.mmaasite = g_mmaa_m_t.mmaasite
#                  DISPLAY BY NAME g_mmaa_m.mmaasite
#                  CALL ammt500_display_mmaasite()
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_aooi500_chk(g_prog,'mmaasite',g_mmaa_m.mmaasite,g_mmaa_m.mmaasite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_mmaa_m.mmaasite = g_mmaa_m_t.mmaasite
                  DISPLAY BY NAME g_mmaa_m.mmaasite
                  CALL ammt500_display_mmaasite()
                  NEXT FIELD CURRENT
               END IF
            #sakura---add---str               
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
			   
               LET g_mmaa_m.mmaasite = g_mmaa_m_t.mmaasite
               DISPLAY BY NAME g_mmaa_m.mmaasite
               CALL ammt500_display_mmaasite()
               NEXT FIELD CURRENT			   
            #sakura---add---end	              
#               LET g_mmaa_m.mmaaunit = g_mmaa_m.mmaasite
            END IF
            LET g_site_flag = TRUE #sakura add
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaa_m.mmaasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmaa_m.mmaasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmaa_m.mmaasite_desc
            call ammt500_set_entry(p_cmd)     #sakura add
            call ammt500_set_no_entry(p_cmd)  #sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaasite
            #add-point:BEFORE FIELD mmaasite name="input.b.mmaasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaasite
            #add-point:ON CHANGE mmaasite name="input.g.mmaasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaadocdt
            #add-point:BEFORE FIELD mmaadocdt name="input.b.mmaadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaadocdt
            
            #add-point:AFTER FIELD mmaadocdt name="input.a.mmaadocdt"
            
#            IF cl_null(g_mmaa_m.mmaadocdt) THEN
#               NEXT FIELD mmaadocdt
#            END IF
#            IF cl_null(g_mmaa_m.mmaadocno) THEN
#               NEXT FIELD mmaadocno
#            END IF
#            CALL cl_set_comp_entry("mmaadocdt,mmaadocno",FALSE)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaadocdt
            #add-point:ON CHANGE mmaadocdt name="input.g.mmaadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaadocno
            #add-point:BEFORE FIELD mmaadocno name="input.b.mmaadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaadocno
            
            #add-point:AFTER FIELD mmaadocno name="input.a.mmaadocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmaa_m.mmaadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmaa_m.mmaadocno != g_mmaadocno_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmaa_t WHERE "||"mmaaent = '" ||g_enterprise|| "' AND "||"mmaadocno = '"||g_mmaa_m.mmaadocno ||"'",'std-00004',0) THEN 
                     LET g_mmaa_m.mmaadocno = g_mmaadocno_t
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi200_chk_slip(g_mmaa_m.mmaasite,g_ooef004,g_mmaa_m.mmaadocno,g_prog) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_mmaa_m.mmaadocno = g_mmaadocno_t
                     NEXT FIELD mmaadocno
                  END IF
                  
               END IF
               CALL ammt500_mmaa002()
            END IF
#            NEXT FIELD mmaadocdt


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaadocno
            #add-point:ON CHANGE mmaadocno name="input.g.mmaadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa000
            #add-point:BEFORE FIELD mmaa000 name="input.b.mmaa000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa000
            
            #add-point:AFTER FIELD mmaa000 name="input.a.mmaa000"
            call ammt500_set_entry(p_cmd)
            call ammt500_set_no_entry(p_cmd)
#            IF g_mmaa_m.mmaa000='I' THEN
#               LET g_mmaa_m.mmaa002 = '0'
#               DISPLAY BY NAME g_mmaa_m.mmaa002
#            END IF
#            IF g_mmaa_m.mmaa000 <> g_mmaa_m_o.mmaa000 THEN
#               LET g_mmaa_m.mmaa001 = ''
#            END IF
#            LET g_mmaa_m_o.mmaa000 = g_mmaa_m.mmaa000
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa000
            #add-point:ON CHANGE mmaa000 name="input.g.mmaa000"
            #add by geza 20151014(S)
            CALL ammt500_set_entry(p_cmd)
            CALL ammt500_set_no_entry(p_cmd)
            LET g_mmaa_m.mmaa020 = ''
            #add by geza 20151014(E)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa001
            #add-point:BEFORE FIELD mmaa001 name="input.b.mmaa001"
            IF p_cmd = 'a' AND g_mmaa_m.mmaa000 = '1' AND cl_null(g_mmaa_m.mmaa001) THEN    
               CALL s_aooi390_gen('9') RETURNING l_success,g_mmaa_m.mmaa001,l_oofg_return   #add--2015/05/08 By shiun                  
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa001
            
            #add-point:AFTER FIELD mmaa001 name="input.a.mmaa001"
           
            IF  NOT cl_null(g_mmaa_m.mmaa001) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmaa_m.mmaa001 != g_mmaa_m_t.mmaa001 ))) THEN   #160824-00007#128 Mark By ken 161031
               IF (g_mmaa_m.mmaa001 != g_mmaa_m_o.mmaa001 ) THEN     #160824-00007#128 Add By ken 161031
                  ########################150520-00041#1
                  IF NOT s_aooi390_chk('9',g_mmaa_m.mmaa001) THEN
                     #LET g_mmaa_m.mmaa001 = g_mmaa_m_t.mmaa001   #160824-00007#128 Mark By ken 161031
                     LET g_mmaa_m.mmaa001 = g_mmaa_m_o.mmaa001    #160824-00007#128 Add By ken 161031
                     DISPLAY BY NAME g_mmaa_m.mmaa001
                     NEXT FIELD mmaa001
                  END IF   
                  ########################
                  CALL ammt500_mmaa001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmaa_m.mmaadocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmaa_m.mmaa001 = g_mmaa_m_t.mmaa001   #160824-00007#128 Mark By ken 161031
                     LET g_mmaa_m.mmaa001 = g_mmaa_m_o.mmaa001    #160824-00007#128 Add By ken 161031
                     NEXT FIELD mmaa001
                  END IF
#                  CALL ammt500_delete_mmaa001() RETURNING l_success
#                  IF l_success<>'1' THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_mmaa_m.mmaadocno
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_mmaa_m.mmaa001 = g_mmaa_m_t.mmaa001
#                     NEXT FIELD mmaa001
#                  END IF
#                  CALL ammt500_mmaa002()
#                  #add by geza 20151014(S)
                  IF g_mmaa_m.mmaa000='2' OR g_mmaa_m.mmaa000='3' THEN
                  CALL ammt500_carry_mmaa()
                     IF g_mmaa_m.mmaa020 IS NULL THEN
                         SELECT mmaq001 INTO g_mmaa_m.mmaa020
                           FROM mmaq_t
                          WHERE mmaqent = g_enterprise
                            AND mmaq003 = g_mmaa_m.mmaa001
                            AND rownum = 1 
                     END IF
                  END IF                  
#                  #add by geza 20151014(E)                   
               END IF
            END IF 
            LET g_mmaa_m_o.* = g_mmaa_m.*   #160824-00007#128 Add By ken 161031
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa001
            #add-point:ON CHANGE mmaa001 name="input.g.mmaa001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa020
            
            #add-point:AFTER FIELD mmaa020 name="input.a.mmaa020"
            IF NOT cl_null(g_mmaa_m.mmaa020) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mmaa_m.mmaa020

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mmaq001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               #查出会员编号，带出资料
               #add by geza 20151014(S)
               IF cl_null(g_mmaa_m.mmaa001) THEN
                  SELECT mmaq003 INTO g_mmaa_m.mmaa001
                    FROM mmaq_t
                   WHERE mmaqent = g_enterprise
                     AND mmaq001 = g_mmaa_m.mmaa020 
                  DISPLAY BY NAME g_mmaa_m.mmaa001               
                  CALL ammt500_mmaa001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmaa_m.mmaa001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_mmaa_m.mmaa020 = g_mmaa_m_t.mmaa020
                     LET g_mmaa_m.mmaa001 = g_mmaa_m_t.mmaa001                  
                     NEXT FIELD CURRENT
                  END IF
                  CALL ammt500_carry_mmaa()
               END IF
#               CALL ammt500_delete_mmaa001() RETURNING l_success
#               IF l_success<>'1' THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_mmaa_m.mmaadocno
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  LET g_mmaa_m.mmaa020 = g_mmaa_m_t.mmaa020
#                  LET g_mmaa_m.mmaa001 = g_mmaa_m_t.mmaa001
#                  NEXT FIELD CURRENT
#               END IF
#               CALL ammt500_mmaa002()               
#               #add by geza 20151014(E)
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa020
            #add-point:BEFORE FIELD mmaa020 name="input.b.mmaa020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa020
            #add-point:ON CHANGE mmaa020 name="input.g.mmaa020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmaa_m.mmaa002,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmaa002
            END IF 
 
 
 
            #add-point:AFTER FIELD mmaa002 name="input.a.mmaa002"
            IF NOT cl_null(g_mmaa_m.mmaa002) THEN 
               
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa002
            #add-point:BEFORE FIELD mmaa002 name="input.b.mmaa002"
            IF p_cmd='a' THEN
               CALL ammt500_mmaa002()
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa002
            #add-point:ON CHANGE mmaa002 name="input.g.mmaa002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa019
            
            #add-point:AFTER FIELD mmaa019 name="input.a.mmaa019"
            IF NOT cl_null(g_mmaa_m.mmaa019) THEN 
               CALL ammt500_mmaa019_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mmaa_m.mmaa019 = g_mmaa_m_t.mmaa019
                  CALL ammt500_display_mmaa019()
                  NEXT FIELD mmaa019
               END IF 
            END IF 
            
            CALL ammt500_display_mmaa019()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa019
            #add-point:BEFORE FIELD mmaa019 name="input.b.mmaa019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa019
            #add-point:ON CHANGE mmaa019 name="input.g.mmaa019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa056
            #add-point:BEFORE FIELD mmaa056 name="input.b.mmaa056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa056
            
            #add-point:AFTER FIELD mmaa056 name="input.a.mmaa056"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa056
            #add-point:ON CHANGE mmaa056 name="input.g.mmaa056"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa052
            
            #add-point:AFTER FIELD mmaa052 name="input.a.mmaa052"
            IF NOT cl_null(g_mmaa_m.mmaa052) THEN 
               CALL ammt500_mmaa052_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_mmaa_m.mmaa052 = g_mmaa_m_t.mmaa052
                  CALL ammt500_display_mmaa052()
                  NEXT FIELD mmaa052
               END IF 
            END IF 
            CALL ammt500_display_mmaa052()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa052
            #add-point:BEFORE FIELD mmaa052 name="input.b.mmaa052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa052
            #add-point:ON CHANGE mmaa052 name="input.g.mmaa052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa055
            #add-point:BEFORE FIELD mmaa055 name="input.b.mmaa055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa055
            
            #add-point:AFTER FIELD mmaa055 name="input.a.mmaa055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa055
            #add-point:ON CHANGE mmaa055 name="input.g.mmaa055"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa061
            
            #add-point:AFTER FIELD mmaa061 name="input.a.mmaa061"
            IF NOT cl_null(g_mmaa_m.mmaa061) THEN
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
                
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mmaa_m.mmaa061
               LET g_chkparam.arg2 = g_mmaa_m.mmaasite
                
                
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pcab001_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD mmaa061
               END IF
            END IF
            CALL ammt500_display_mmaa061()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa061
            #add-point:BEFORE FIELD mmaa061 name="input.b.mmaa061"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa061
            #add-point:ON CHANGE mmaa061 name="input.g.mmaa061"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa054
            #add-point:BEFORE FIELD mmaa054 name="input.b.mmaa054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa054
            
            #add-point:AFTER FIELD mmaa054 name="input.a.mmaa054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa054
            #add-point:ON CHANGE mmaa054 name="input.g.mmaa054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaastus
            #add-point:BEFORE FIELD mmaastus name="input.b.mmaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaastus
            
            #add-point:AFTER FIELD mmaastus name="input.a.mmaastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaastus
            #add-point:ON CHANGE mmaastus name="input.g.mmaastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa008
            #add-point:BEFORE FIELD mmaa008 name="input.b.mmaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa008
            
            #add-point:AFTER FIELD mmaa008 name="input.a.mmaa008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa008
            #add-point:ON CHANGE mmaa008 name="input.g.mmaa008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa009
            #add-point:BEFORE FIELD mmaa009 name="input.b.mmaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa009
            
            #add-point:AFTER FIELD mmaa009 name="input.a.mmaa009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa009
            #add-point:ON CHANGE mmaa009 name="input.g.mmaa009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa014
            #add-point:BEFORE FIELD mmaa014 name="input.b.mmaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa014
            
            #add-point:AFTER FIELD mmaa014 name="input.a.mmaa014"
            INITIALIZE l_ooef011 TO NULL
            SELECT ooef011 INTO l_ooef011 
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_mmaa_m.mmaasite
            IF NOT cl_null(g_mmaa_m.mmaa014) THEN
                IF l_ooef011 = 'CN' THEN                        
                   LET l_cnt = 0
                   LET l_mmaa014 = g_mmaa_m.mmaa014
                   LET l_cnt = l_mmaa014.getlength()
                   IF l_cnt != 11 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'amm-00458'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_mmaa_m.mmaa014 = g_mmaa_m_o.mmaa014                        
                      NEXT FIELD mmaa014
                   END IF
                   LET l_cnt = 0
                   #mark by geza 20151103(S)
#                   SELECT COUNT(*) INTO l_cnt 
#                     FROM mmaa_t
#                    WHERE mmaaent = g_enterprise  
#                      AND mmaa014 = g_mmaa_m.mmaa014
                   #mark by geza 20151103(E)  
                   #add by geza 20151103(S)            
                   SELECT COUNT(*) INTO l_cnt 
                     FROM mmaf_t
                    WHERE mmafent = g_enterprise  
                      AND mmaf014 = g_mmaa_m.mmaa014  
                      AND mmaf001 <> g_mmaa_m.mmaa001                      
                   #add by geza 20151103(E)   
                   IF l_cnt > 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'amm-00459'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_mmaa_m.mmaa014 = g_mmaa_m_o.mmaa014                        
                      NEXT FIELD mmaa014
                   END IF
                   
                   FOR l_cnt=1 TO 11 STEP 1
                      IF cl_null(g_mmaa_m.mmaa014[l_cnt,l_cnt]) OR 
                         g_mmaa_m.mmaa014[l_cnt,l_cnt] NOT MATCHES "[0123456789]" THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'amm-00461'
                         LET g_errparam.extend = ''
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         LET g_mmaa_m.mmaa014 = g_mmaa_m_o.mmaa014                        
                         NEXT FIELD mmaa014 
                        
                      END IF
                   END FOR

                END IF 
                IF l_ooef011 = 'TW' THEN               
                   LET l_cnt = 0
                   LET l_mmaa014 = g_mmaa_m.mmaa014
                   LET l_cnt = l_mmaa014.getlength()
                   IF l_cnt != 10 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'amm-00460'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()   
                      LET g_mmaa_m.mmaa014 = g_mmaa_m_o.mmaa014                      
                      NEXT FIELD mmaa014
                   END IF
                   FOR l_cnt=1 TO 10 STEP 1
                      IF cl_null(g_mmaa_m.mmaa014[l_cnt,l_cnt]) OR 
                         g_mmaa_m.mmaa014[l_cnt,l_cnt] NOT MATCHES "[0123456789]" THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'amm-00461'
                         LET g_errparam.extend = ''
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         LET g_mmaa_m.mmaa014 = g_mmaa_m_o.mmaa014                        
                         NEXT FIELD mmaa014 
                        
                      END IF
                   END FOR                   
                END IF
            END IF     
            LET g_mmaa_m_o.* = g_mmaa_m.*   #160824-00007#128 Add By ken 161031         
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa014
            #add-point:ON CHANGE mmaa014 name="input.g.mmaa014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa003
            #add-point:BEFORE FIELD mmaa003 name="input.b.mmaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa003
            
            #add-point:AFTER FIELD mmaa003 name="input.a.mmaa003"
            IF g_mmaa_m.mmaa003 ='1' or  g_mmaa_m.mmaa003 ='2' THEN
               CALL cl_set_comp_required("mmaa004",TRUE)
            ELSE
               CALL cl_set_comp_required("mmaa004",FALSE)            
            END IF
            LET g_mmaa_m_o.* = g_mmaa_m.*   #160824-00007#128 Add By ken 161031
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa003
            #add-point:ON CHANGE mmaa003 name="input.g.mmaa003"
            IF g_mmaa_m.mmaa003 ='1' or  g_mmaa_m.mmaa003 ='2' THEN
               CALL cl_set_comp_required("mmaa004",TRUE)
            ELSE
               CALL cl_set_comp_required("mmaa004",FALSE)            
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa015
            #add-point:BEFORE FIELD mmaa015 name="input.b.mmaa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa015
            
            #add-point:AFTER FIELD mmaa015 name="input.a.mmaa015"
            #add by geza 20151118(S)
            #控管会员出生日期不能小于1900年            
            IF g_mmaa_m.mmaa015 < '1900/01/01' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00491'
               LET g_errparam.extend = g_mmaa_m.mmaa015
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #LET g_mmaa_m.mmaa015 = g_mmaa_m_t.mmaa015  #160824-00007#128 Mark By ken 161031
               LET g_mmaa_m.mmaa015 = g_mmaa_m_o.mmaa015   #160824-00007#128 Add By ken 161031
               NEXT FIELD mmaa015
            END IF             
            #add by geza 20151118(E)  
            LET g_mmaa_m_o.* = g_mmaa_m.*   #160824-00007#128 Add By ken 161031
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa015
            #add-point:ON CHANGE mmaa015 name="input.g.mmaa015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa013
            #add-point:BEFORE FIELD mmaa013 name="input.b.mmaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa013
            
            #add-point:AFTER FIELD mmaa013 name="input.a.mmaa013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa013
            #add-point:ON CHANGE mmaa013 name="input.g.mmaa013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa004
            #add-point:BEFORE FIELD mmaa004 name="input.b.mmaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa004
            
            #add-point:AFTER FIELD mmaa004 name="input.a.mmaa004"
            CALL ammt500_mmaa003()
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_mmaa_m.mmaa004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD mmaa004
            END IF
            
            INITIALIZE l_ooef011 TO NULL 
            SELECT ooef011 INTO l_ooef011 
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_mmaa_m.mmaasite
            IF NOT cl_null(g_mmaa_m.mmaa004) THEN
                IF l_ooef011 = 'CN' THEN                  
                   IF g_mmaa_m.mmaa003 = '1' THEN
                      LET l_cnt = 0
                      LET l_mmaa004 = g_mmaa_m.mmaa004
                      LET l_cnt = l_mmaa004.getlength()
                      IF l_cnt != 15 AND l_cnt != 18 THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'amm-00455'
                         LET g_errparam.extend = ''
                         #LET g_errparam.popup = TRUE  #mark by geza 20151103
                         LET g_errparam.popup = FALSE  #add by geza 20151103
                         CALL cl_err()
                         #LET g_mmaa_m.mmaa004 = g_mmaa_m_o.mmaa004     #mark by geza 20151103                   
                         #NEXT FIELD mmaa004                            #mark by geza 20151103   
                      END IF
                   END IF
                   LET l_cnt = 0
#                   #mark by geza 20151104(S)
#                   SELECT COUNT(*) INTO l_cnt 
#                     FROM mmaa_t
#                    WHERE mmaaent = g_enterprise  
#                      AND mmaa004 = g_mmaa_m.mmaa004
#                   #mark by geza 20151104(E) 
                   #add by geza 20151104(S)
                   SELECT COUNT(*) INTO l_cnt 
                     FROM mmaf_t
                    WHERE mmafent = g_enterprise  
                      AND mmaf004 = g_mmaa_m.mmaa004
                      AND mmaf001 <> g_mmaa_m.mmaa001
                   #add by geza 20151104(E)   
                   IF l_cnt > 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'amm-00456'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_mmaa_m.mmaa004 = g_mmaa_m_o.mmaa004                        
                      NEXT FIELD mmaa004
                   END IF                      
                END IF 
                IF l_ooef011 = 'TW' THEN               
                   IF g_mmaa_m.mmaa003 = '1' THEN
                      LET l_cnt = 0
                      LET l_mmaa004 = g_mmaa_m.mmaa004
                      LET l_cnt = l_mmaa004.getlength()
                      IF l_cnt != 10 THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'amm-00457'
                         LET g_errparam.extend = ''
                         #LET g_errparam.popup = TRUE  #mark by geza 20151103
                         LET g_errparam.popup = FALSE  #add by geza 20151103
                         CALL cl_err()   
                         #LET g_mmaa_m.mmaa004 = g_mmaa_m_o.mmaa004    #mark by geza 20151103                  
                         #NEXT FIELD mmaa004                           #mark by geza 20151103   
                      END IF
                   END IF                      
                END IF
                #add by zn 160604-00009#132 --str
                IF g_mmaa_m.mmaa000='1' THEN 
                   LET l_m = 0
                   SELECT COUNT(*) INTO l_m
                   FROM mmaf_t
                   WHERE mmafent = g_enterprise  
                   AND mmaf004 = g_mmaa_m.mmaa004
                   AND mmaf003 = g_mmaa_m.mmaa003
                   IF l_m>0 THEN 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'anm-03007'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_mmaa_m.mmaa004 = g_mmaa_m_o.mmaa004                        
                      NEXT FIELD mmaa004
                   END IF
                 ELSE
                   LET l_m = 0
                   SELECT COUNT(*) INTO l_m
                   FROM mmaf_t
                   WHERE mmafent = g_enterprise  
                   AND mmaf004 = g_mmaa_m.mmaa004
                   AND mmaf003 = g_mmaa_m.mmaa003
                   AND mmaf001 <> g_mmaa_m.mmaa001
                   IF l_m>0 THEN 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'anm-03007'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_mmaa_m.mmaa004 = g_mmaa_m_o.mmaa004                        
                      NEXT FIELD mmaa004
                   END IF
                END IF
               #add by zn 160604-00009#132 --end                 
               END IF          
               LET g_mmaa_m_o.* = g_mmaa_m.*   #160824-00007#128 Add By ken 161031               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa004
            #add-point:ON CHANGE mmaa004 name="input.g.mmaa004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa010
            #add-point:BEFORE FIELD mmaa010 name="input.b.mmaa010"
           
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa010
            
            #add-point:AFTER FIELD mmaa010 name="input.a.mmaa010"
            IF  NOT cl_null(g_mmaa_m.mmaa010) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmaa_m.mmaa010 != g_mmaa_m_t.mmaa010 OR g_mmaa_m_t.mmaa010 IS NULL))) THEN   #160824-00007#128 Mark By ken 161031
               IF (g_mmaa_m.mmaa010 != g_mmaa_m_o.mmaa010 OR g_mmaa_m_o.mmaa010 IS NULL) THEN    #160824-00007#128 Add By ken 161031
                  CALL ammt500_mmaa010()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmaa_m.mmaa010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmaa_m.mmaa010 = g_mmaa_m_t.mmaa010  #160824-00007#128 Mark By ken 161031
                     LET g_mmaa_m.mmaa010 = g_mmaa_m_o.mmaa010   #160824-00007#128 Add By ken 161031
                     NEXT FIELD mmaa010
                  END IF
                  
               END IF
            END IF 
            LET g_mmaa_m_o.* = g_mmaa_m.*   #160824-00007#128 Add By ken 161031
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa010
            #add-point:ON CHANGE mmaa010 name="input.g.mmaa010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa024
            
            #add-point:AFTER FIELD mmaa024 name="input.a.mmaa024"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa024
            #add-point:BEFORE FIELD mmaa024 name="input.b.mmaa024"
            CALL ammt500_mmaa024_scc() #160506-00009#10 160512 by sakura add
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa024
            #add-point:ON CHANGE mmaa024 name="input.g.mmaa024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa025
            
            #add-point:AFTER FIELD mmaa025 name="input.a.mmaa025"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa025
            #add-point:BEFORE FIELD mmaa025 name="input.b.mmaa025"
            CALL ammt500_mmaa025_scc() #160506-00009#10 160512 by sakura add
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa025
            #add-point:ON CHANGE mmaa025 name="input.g.mmaa025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa026
            
            #add-point:AFTER FIELD mmaa026 name="input.a.mmaa026"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa026
            #add-point:BEFORE FIELD mmaa026 name="input.b.mmaa026"
            CALL ammt500_mmaa026_scc() #160506-00009#10 160512 by sakura add
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa026
            #add-point:ON CHANGE mmaa026 name="input.g.mmaa026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa027
            
            #add-point:AFTER FIELD mmaa027 name="input.a.mmaa027"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa027
            #add-point:BEFORE FIELD mmaa027 name="input.b.mmaa027"
            CALL ammt500_mmaa027_scc() #160506-00009#10 160512 by sakura add
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa027
            #add-point:ON CHANGE mmaa027 name="input.g.mmaa027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa028
            
            #add-point:AFTER FIELD mmaa028 name="input.a.mmaa028"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa028
            #add-point:BEFORE FIELD mmaa028 name="input.b.mmaa028"
            CALL ammt500_mmaa028_scc() #160506-00009#10 160512 by sakura add
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa028
            #add-point:ON CHANGE mmaa028 name="input.g.mmaa028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa012
            #add-point:BEFORE FIELD mmaa012 name="input.b.mmaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa012
            
            #add-point:AFTER FIELD mmaa012 name="input.a.mmaa012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa012
            #add-point:ON CHANGE mmaa012 name="input.g.mmaa012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa011
            #add-point:BEFORE FIELD mmaa011 name="input.b.mmaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa011
            
            #add-point:AFTER FIELD mmaa011 name="input.a.mmaa011"
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa011
            #add-point:ON CHANGE mmaa011 name="input.g.mmaa011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa029
            
            #add-point:AFTER FIELD mmaa029 name="input.a.mmaa029"
            IF NOT cl_null(g_mmaa_m.mmaa029) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2016'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa029
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa029
            #add-point:BEFORE FIELD mmaa029 name="input.b.mmaa029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa029
            #add-point:ON CHANGE mmaa029 name="input.g.mmaa029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa034
            
            #add-point:AFTER FIELD mmaa034 name="input.a.mmaa034"
            IF NOT cl_null(g_mmaa_m.mmaa034) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2021'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa034
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa034
            #add-point:BEFORE FIELD mmaa034 name="input.b.mmaa034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa034
            #add-point:ON CHANGE mmaa034 name="input.g.mmaa034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa039
            
            #add-point:AFTER FIELD mmaa039 name="input.a.mmaa039"
            IF NOT cl_null(g_mmaa_m.mmaa039) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2026' 
               LET g_chkparam.arg2 = g_mmaa_m.mmaa039
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa039
            #add-point:BEFORE FIELD mmaa039 name="input.b.mmaa039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa039
            #add-point:ON CHANGE mmaa039 name="input.g.mmaa039"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa030
            
            #add-point:AFTER FIELD mmaa030 name="input.a.mmaa030"
            IF NOT cl_null(g_mmaa_m.mmaa030) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2017'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa030
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa030
            #add-point:BEFORE FIELD mmaa030 name="input.b.mmaa030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa030
            #add-point:ON CHANGE mmaa030 name="input.g.mmaa030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa035
            
            #add-point:AFTER FIELD mmaa035 name="input.a.mmaa035"
            IF NOT cl_null(g_mmaa_m.mmaa035) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2022'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa035
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa035
            #add-point:BEFORE FIELD mmaa035 name="input.b.mmaa035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa035
            #add-point:ON CHANGE mmaa035 name="input.g.mmaa035"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa040
            
            #add-point:AFTER FIELD mmaa040 name="input.a.mmaa040"
            IF NOT cl_null(g_mmaa_m.mmaa040) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2027'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa040
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa040
            #add-point:BEFORE FIELD mmaa040 name="input.b.mmaa040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa040
            #add-point:ON CHANGE mmaa040 name="input.g.mmaa040"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa031
            
            #add-point:AFTER FIELD mmaa031 name="input.a.mmaa031"
            IF NOT cl_null(g_mmaa_m.mmaa031) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2018'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa031
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa031
            #add-point:BEFORE FIELD mmaa031 name="input.b.mmaa031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa031
            #add-point:ON CHANGE mmaa031 name="input.g.mmaa031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa036
            
            #add-point:AFTER FIELD mmaa036 name="input.a.mmaa036"
            IF NOT cl_null(g_mmaa_m.mmaa036) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2023'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa036
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa036
            #add-point:BEFORE FIELD mmaa036 name="input.b.mmaa036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa036
            #add-point:ON CHANGE mmaa036 name="input.g.mmaa036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa041
            
            #add-point:AFTER FIELD mmaa041 name="input.a.mmaa041"
            IF NOT cl_null(g_mmaa_m.mmaa041) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2028'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa041
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa041
            #add-point:BEFORE FIELD mmaa041 name="input.b.mmaa041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa041
            #add-point:ON CHANGE mmaa041 name="input.g.mmaa041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa032
            
            #add-point:AFTER FIELD mmaa032 name="input.a.mmaa032"
            IF NOT cl_null(g_mmaa_m.mmaa032) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2019'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa032
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa032
            #add-point:BEFORE FIELD mmaa032 name="input.b.mmaa032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa032
            #add-point:ON CHANGE mmaa032 name="input.g.mmaa032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa037
            
            #add-point:AFTER FIELD mmaa037 name="input.a.mmaa037"
            IF NOT cl_null(g_mmaa_m.mmaa037) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2025'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa037
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa037
            #add-point:BEFORE FIELD mmaa037 name="input.b.mmaa037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa037
            #add-point:ON CHANGE mmaa037 name="input.g.mmaa037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa042
            
            #add-point:AFTER FIELD mmaa042 name="input.a.mmaa042"
            IF NOT cl_null(g_mmaa_m.mmaa042) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2019'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa042
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa042
            #add-point:BEFORE FIELD mmaa042 name="input.b.mmaa042"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa042
            #add-point:ON CHANGE mmaa042 name="input.g.mmaa042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa033
            
            #add-point:AFTER FIELD mmaa033 name="input.a.mmaa033"
            IF NOT cl_null(g_mmaa_m.mmaa033) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2020'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa033
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa033
            #add-point:BEFORE FIELD mmaa033 name="input.b.mmaa033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa033
            #add-point:ON CHANGE mmaa033 name="input.g.mmaa033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa038
            
            #add-point:AFTER FIELD mmaa038 name="input.a.mmaa038"
            IF NOT cl_null(g_mmaa_m.mmaa038) THEN 
#應用 a19 樣板自動產生(Version:3)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2024'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa038
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa038
            #add-point:BEFORE FIELD mmaa038 name="input.b.mmaa038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa038
            #add-point:ON CHANGE mmaa038 name="input.g.mmaa038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa043
            
            #add-point:AFTER FIELD mmaa043 name="input.a.mmaa043"
            IF NOT cl_null(g_mmaa_m.mmaa043) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2030'
               LET g_chkparam.arg2 = g_mmaa_m.mmaa043
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_oocq002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa043
            #add-point:BEFORE FIELD mmaa043 name="input.b.mmaa043"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa043
            #add-point:ON CHANGE mmaa043 name="input.g.mmaa043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa057
            
            #add-point:AFTER FIELD mmaa057 name="input.a.mmaa057"
            IF NOT cl_null(g_mmaa_m.mmaa057) THEN
               SELECT COUNT(*) INTO l_n FROM mmby_t
                WHERE mmbyent=g_enterprise
                  AND mmby001=g_mmaa_m.mmaa057
                  AND mmbysite = g_mmaa_m.mmaasite #add by geza 20160702
                  AND mmby004 = '2'
                  AND mmby015>=g_today
               IF l_n=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00761'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_mmaa_m.mmaa057 = g_mmaa_m_t.mmaa057
                  NEXT FIELD mmaa057
               END IF
               IF NOT cl_null(g_mmaa_m.mmaa044) THEN
                  SELECT mmby005 INTO l_mmby005
                    FROM mmby_t 
                   WHERE mmbyent = g_enterprise
                     AND mmby001 = g_mmaa_m.mmaa057
                     AND mmbysite = g_mmaa_m.mmaasite #add by geza 20160702
                  IF l_mmby005 <> g_mmaa_m.mmaa044 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00763'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_mmaa_m.mmaa057 = g_mmaa_m_t.mmaa057
                     NEXT FIELD mmaa057
                  END IF
               END IF
            END IF
            #add by geza 20160702(S)
            #储值规则编号 修改后也要重新计算一次折扣和加值
            IF ((g_mmaa_m.mmaa057 != g_mmaa_m_t.mmaa057 AND NOT cl_null(g_mmaa_m_t.mmaa057) AND NOT cl_null(g_mmaa_m.mmaa057) ) OR
               (g_mmaa_m.mmaa057 IS NULL AND NOT cl_null(g_mmaa_m_t.mmaa057) ) OR (g_mmaa_m_t.mmaa057 IS NULL AND NOT cl_null(g_mmaa_m.mmaa057))) THEN
               IF NOT ammt500_mmaa045_display() THEN 
                  LET g_mmaa_m.mmaa057 = g_mmaa_m_t.mmaa057
                  NEXT FIELD mmaa057
               END IF
            END IF 
            LET g_mmaa_m_t.mmaa057 = g_mmaa_m.mmaa057
            #add by geza 20160702(E)
            CALL ammt500_mmaa057_ref() #add by geza 20160702
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa057
            #add-point:BEFORE FIELD mmaa057 name="input.b.mmaa057"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa057
            #add-point:ON CHANGE mmaa057 name="input.g.mmaa057"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa047
            #add-point:BEFORE FIELD mmaa047 name="input.b.mmaa047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa047
            
            #add-point:AFTER FIELD mmaa047 name="input.a.mmaa047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa047
            #add-point:ON CHANGE mmaa047 name="input.g.mmaa047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa060
            #add-point:BEFORE FIELD mmaa060 name="input.b.mmaa060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa060
            
            #add-point:AFTER FIELD mmaa060 name="input.a.mmaa060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa060
            #add-point:ON CHANGE mmaa060 name="input.g.mmaa060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa059
            #add-point:BEFORE FIELD mmaa059 name="input.b.mmaa059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa059
            
            #add-point:AFTER FIELD mmaa059 name="input.a.mmaa059"
            IF cl_null(g_mmaa_m.mmaa059) THEN
               LET g_mmaa_m.mmaa044=''
               LET g_mmaa_m.mmaa045=''
               LET g_mmaa_m.mmaa046=''
               LET g_mmaa_m.mmaa047=''
               LET g_mmaa_m.mmaa048=''
               LET g_mmaa_m.mmaa049=''
               LET g_mmaa_m.mmaa050=''
               LET g_mmaa_m.mmaa051=''
               LET g_mmaa_m.mmaa060=''
            END IF
            IF NOT cl_null(g_mmaa_m.mmaa059) THEN 
               IF g_mmaa_m.mmaa059 != g_mmaa_m_o.mmaa059 OR cl_null(g_mmaa_m_o.mmaa059) THEN
                  IF g_mmaa_m.mmaa000='3' THEN
                     CALL ammt500_mmaa059_1_chk(g_mmaa_m.mmaa059)
                     IF NOT cl_null(g_errno) THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        LET g_mmaa_m.mmaa059 = g_mmaa_m_t.mmaa059
                        NEXT FIELD mmaa059 
                     END IF 
                  ELSE
                     CALL ammt500_mmaa059_chk(g_mmaa_m.mmaa059)
                     IF NOT cl_null(g_errno) THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        LET g_mmaa_m.mmaa059 = g_mmaa_m_t.mmaa059
                        NEXT FIELD mmaa059
                     END IF
                  END IF
                  IF NOT cl_null(g_mmaa_m.mmaa057) THEN
                     SELECT mmby005 INTO l_mmby005
                       FROM mmby_t 
                      WHERE mmbyent = g_enterprise
                        AND mmby001 = g_mmaa_m.mmaa057
                        AND mmbysite = g_mmaa_m.mmaasite #add by geza 20160702
                     IF l_mmby005 <> g_mmaa_m.mmaa044 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'amm-00763'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_mmaa_m.mmaa059 = g_mmaa_m_t.mmaa059
                        NEXT FIELD mmaa059
                     END IF
                  END IF
                  CALL ammt500_mmaa059_display()
                  IF NOT cl_null(g_mmaa_m.mmaa045) THEN 
                     IF NOT ammt500_mmaa045_display() THEN 
                        LET g_mmaa_m.mmaa059 = g_mmaa_m_t.mmaa059
                        NEXT FIELD mmaa059
                     END IF
                  END IF
                  
               END IF
            END IF
            CALL ammt500_set_entry_mmaa059(l_cmd)
            LET g_mmaa_m_o.mmaa059 = g_mmaa_m.mmaa059
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa059
            #add-point:ON CHANGE mmaa059 name="input.g.mmaa059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa048
            #add-point:BEFORE FIELD mmaa048 name="input.b.mmaa048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa048
            
            #add-point:AFTER FIELD mmaa048 name="input.a.mmaa048"
            IF cl_null(g_mmaa_m.mmaa045) THEN
               LET g_mmaa_m.mmaa045=0
            END IF
            IF cl_null(g_mmaa_m.mmaa048) THEN
               LET g_mmaa_m.mmaa048=0
            END IF
            LET g_mmaa_m.mmaa049=g_mmaa_m.mmaa045+g_mmaa_m.mmaa048
            DISPLAY BY NAME g_mmaa_m.mmaa049
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa048
            #add-point:ON CHANGE mmaa048 name="input.g.mmaa048"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa062
            
            #add-point:AFTER FIELD mmaa062 name="input.a.mmaa062"
            #160604-00009#122 -s by 08172
            IF NOT cl_null(g_mmaa_m.mmaa062) THEN
               CALL ammt500_mmaa062_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_mmaa_m.mmaa062=g_mmaa_m_t.mmaa062
                  CALL ammt500_mmaa062_ref()
               END IF
               CALL ammt500_mmaa062_ref()
            END IF
            #160604-00009#122 -e by 08172


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa062
            #add-point:BEFORE FIELD mmaa062 name="input.b.mmaa062"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa062
            #add-point:ON CHANGE mmaa062 name="input.g.mmaa062"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa044
            
            #add-point:AFTER FIELD mmaa044 name="input.a.mmaa044"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaa_m.mmaa044
            CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmaa_m.mmaa044_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmaa_m.mmaa044_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa044
            #add-point:BEFORE FIELD mmaa044 name="input.b.mmaa044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa044
            #add-point:ON CHANGE mmaa044 name="input.g.mmaa044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa049
            #add-point:BEFORE FIELD mmaa049 name="input.b.mmaa049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa049
            
            #add-point:AFTER FIELD mmaa049 name="input.a.mmaa049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa049
            #add-point:ON CHANGE mmaa049 name="input.g.mmaa049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa058
            #add-point:BEFORE FIELD mmaa058 name="input.b.mmaa058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa058
            
            #add-point:AFTER FIELD mmaa058 name="input.a.mmaa058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa058
            #add-point:ON CHANGE mmaa058 name="input.g.mmaa058"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa045
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmaa_m.mmaa045,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mmaa045
            END IF 
 
 
 
            #add-point:AFTER FIELD mmaa045 name="input.a.mmaa045"
            IF NOT cl_null(g_mmaa_m.mmaa045) THEN
               IF cl_null(g_mmaa_m_o.mmaa045) OR g_mmaa_m_o.mmaa045<>g_mmaa_m.mmaa045 THEN 
                  IF NOT ammt500_mmaa045_display() THEN 
                     LET g_mmaa_m.mmaa045 = g_mmaa_m_t.mmaa045
                     NEXT FIELD mmaa045
                  END IF
               END IF
                  
              #IF cl_null(g_mmaa_m.mmaa046) THEN
              #   LET g_mmaa_m.mmaa046=0
              #END IF
              #IF NOT cl_null(g_mmaa_m.mmaa047) THEN
              #   LET g_mmaa_m.mmaa051=g_mmaa_m.mmaa045-g_mmaa_m.mmaa047+g_mmaa_m.mmaa050
              #END IF
              #LET g_mmaa_m.mmaa047=g_mmaa_m.mmaa045*(1-g_mmaa_m.mmaa046/100)
              #LET g_mmaa_m.mmaa049=g_mmaa_m.mmaa045+g_mmaa_m.mmaa048
              #DISPLAY BY NAME g_mmaa_m.mmaa047,g_mmaa_m.mmaa048,g_mmaa_m.mmaa051
            END IF
            LET g_mmaa_m_o.mmaa045 = g_mmaa_m.mmaa045


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa045
            #add-point:BEFORE FIELD mmaa045 name="input.b.mmaa045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa045
            #add-point:ON CHANGE mmaa045 name="input.g.mmaa045"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa050
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmaa_m.mmaa050,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mmaa050
            END IF 
 
 
 
            #add-point:AFTER FIELD mmaa050 name="input.a.mmaa050"
            IF NOT cl_null(g_mmaa_m.mmaa050) THEN
               LET g_mmaa_m.mmaa051=g_mmaa_m.mmaa045-g_mmaa_m.mmaa047+g_mmaa_m.mmaa050            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa050
            #add-point:BEFORE FIELD mmaa050 name="input.b.mmaa050"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa050
            #add-point:ON CHANGE mmaa050 name="input.g.mmaa050"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa046
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmaa_m.mmaa046,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD mmaa046
            END IF 
 
 
 
            #add-point:AFTER FIELD mmaa046 name="input.a.mmaa046"
            IF NOT cl_null(g_mmaa_m.mmaa046) THEN  
               LET g_mmaa_m.mmaa047=g_mmaa_m.mmaa045*(1-g_mmaa_m.mmaa046/100)
               LET g_mmaa_m.mmaa051=g_mmaa_m.mmaa045-g_mmaa_m.mmaa047+g_mmaa_m.mmaa050
               DISPLAY BY NAME g_mmaa_m.mmaa047,g_mmaa_m.mmaa051               
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa046
            #add-point:BEFORE FIELD mmaa046 name="input.b.mmaa046"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa046
            #add-point:ON CHANGE mmaa046 name="input.g.mmaa046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaa051
            #add-point:BEFORE FIELD mmaa051 name="input.b.mmaa051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaa051
            
            #add-point:AFTER FIELD mmaa051 name="input.a.mmaa051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaa051
            #add-point:ON CHANGE mmaa051 name="input.g.mmaa051"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mmaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaasite
            #add-point:ON ACTION controlp INFIELD mmaasite name="input.c.mmaasite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmaa_m.mmaasite             #給予default值
            LET g_qryparam.default2 = g_mmaa_m.mmaasite_desc #說明(簡稱)
            #給予arg
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = "8" #
#            
#            CALL q_ooed004()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaasite',g_mmaa_m.mmaasite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
            CALL q_ooef001_24()

            LET g_mmaa_m.mmaasite = g_qryparam.return1              
            LET g_mmaa_m.mmaasite_desc = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaasite TO mmaasite              #
            DISPLAY g_mmaa_m.mmaasite_desc TO mmaasite_desc #說明(簡稱)
            NEXT FIELD mmaasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaadocdt
            #add-point:ON ACTION controlp INFIELD mmaadocdt name="input.c.mmaadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaadocno
            #add-point:ON ACTION controlp INFIELD mmaadocno name="input.c.mmaadocno"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmaa_m.mmaadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #參照表編號
            #LET g_qryparam.arg2 = "ammt500" #對應程式代號 #160705-00042#6 160712 by sakura mark
            LET g_qryparam.arg2 = g_prog                  #160705-00042#6 160712 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_mmaa_m.mmaadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmaa_m.mmaadocno TO mmaadocno              #顯示到畫面上

            NEXT FIELD mmaadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmaa000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa000
            #add-point:ON ACTION controlp INFIELD mmaa000 name="input.c.mmaa000"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa001
            #add-point:ON ACTION controlp INFIELD mmaa001 name="input.c.mmaa001"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'            
            IF g_mmaa_m.mmaa000 = '2' OR g_mmaa_m.mmaa000 = '3' THEN
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_mmaa_m.mmaa001             #給予default值
               
               #給予arg
               
               CALL q_mmaf001()                                #呼叫開窗
               
               LET g_mmaa_m.mmaa001 = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_mmaa_m.mmaa001 TO mmaa001              #顯示到畫面上
          
               NEXT FIELD mmaa001               #返回原欄位
            END IF
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa020
            #add-point:ON ACTION controlp INFIELD mmaa020 name="input.c.mmaa020"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.arg1 = g_mmaa_m.mmaasite
            LET g_qryparam.where = " mmaq002 IN(SELECT mmap002 FROM mmap_t WHERE mmapent = '",g_enterprise,"' AND mmap001 = 'ammm320' ",
                                   "             AND (mmap003 = '",g_mmaa_m.mmaasite,"' OR (mmap003 IN(SELECT ooed005 FROM ooed_t ",
                                   "    START WITH ooed004= '",g_mmaa_m.mmaasite,"' AND ooed001 = '8' AND ooedent = '",g_enterprise,"' ",
                                   "      AND ooed006<='",g_today,"' ",
                                   "      AND (ooed007 >='",g_today,"' OR ooed007 IS NULL)",
                                   "  CONNECT BY  NOCYCLE PRIOR ooed005=ooed004 ",
                                   "      AND ooed001='8' AND ooedent = '",g_enterprise,"'",
                                   "      AND ooed006 <='",g_today,"' ",
                                   "      AND (ooed007 >='",g_today,"' OR ooed007 IS NULL)) AND mmap005 = 'Y')) AND mmapstus = 'Y')",
                                   " AND mmaq006 = '1' "
            CALL q_mmaq001_7()
            LET g_mmaa_m.mmaa020 = g_qryparam.return1
            DISPLAY g_mmaa_m.mmaa020 TO mmaa020
            #END add-point
 
 
         #Ctrlp:input.c.mmaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa002
            #add-point:ON ACTION controlp INFIELD mmaa002 name="input.c.mmaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa019
            #add-point:ON ACTION controlp INFIELD mmaa019 name="input.c.mmaa019"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmaa_m.mmaa019             #給予default值           
            #給予arg

            CALL q_ooag001() 
            LET g_mmaa_m.mmaa019 = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            DISPLAY g_mmaa_m.mmaa019 TO mmaa019              #顯示到畫面上
            CALL ammt500_display_mmaa019()
            NEXT FIELD mmaa019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmaa056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa056
            #add-point:ON ACTION controlp INFIELD mmaa056 name="input.c.mmaa056"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa052
            #add-point:ON ACTION controlp INFIELD mmaa052 name="input.c.mmaa052"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa052             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_today #s

 
            CALL q_ooeg001()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa052 = g_qryparam.return1  
            DISPLAY g_mmaa_m.mmaa052 TO mmaa052              #
            CALL ammt500_display_mmaa052()
            NEXT FIELD mmaa052                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa055
            #add-point:ON ACTION controlp INFIELD mmaa055 name="input.c.mmaa055"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa061
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa061
            #add-point:ON ACTION controlp INFIELD mmaa061 name="input.c.mmaa061"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa061             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.pcab003 #收銀人員姓名
            #給予arg
            LET g_qryparam.arg1 = g_mmaa_m.mmaasite #s

 
            CALL q_pcab001_2()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa061 = g_qryparam.return1              
            #LET g_mmaa_m.pcab003 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa061 TO mmaa061              #
            #DISPLAY g_mmaa_m.pcab003 TO pcab003 #收銀人員姓名
            NEXT FIELD mmaa061                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa054
            #add-point:ON ACTION controlp INFIELD mmaa054 name="input.c.mmaa054"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaastus
            #add-point:ON ACTION controlp INFIELD mmaastus name="input.c.mmaastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa008
            #add-point:ON ACTION controlp INFIELD mmaa008 name="input.c.mmaa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa009
            #add-point:ON ACTION controlp INFIELD mmaa009 name="input.c.mmaa009"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa014
            #add-point:ON ACTION controlp INFIELD mmaa014 name="input.c.mmaa014"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa003
            #add-point:ON ACTION controlp INFIELD mmaa003 name="input.c.mmaa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa015
            #add-point:ON ACTION controlp INFIELD mmaa015 name="input.c.mmaa015"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa013
            #add-point:ON ACTION controlp INFIELD mmaa013 name="input.c.mmaa013"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa004
            #add-point:ON ACTION controlp INFIELD mmaa004 name="input.c.mmaa004"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa010
            #add-point:ON ACTION controlp INFIELD mmaa010 name="input.c.mmaa010"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmaa_m.mmaa010             #給予default值

            #給予arg

            CALL q_oocn002()                                #呼叫開窗

            LET g_mmaa_m.mmaa010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmaa_m.mmaa010 TO mmaa010              #顯示到畫面上

            NEXT FIELD mmaa010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmaa024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa024
            #add-point:ON ACTION controlp INFIELD mmaa024 name="input.c.mmaa024"
 
            #END add-point
 
 
         #Ctrlp:input.c.mmaa025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa025
            #add-point:ON ACTION controlp INFIELD mmaa025 name="input.c.mmaa025"
 
            #END add-point
 
 
         #Ctrlp:input.c.mmaa026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa026
            #add-point:ON ACTION controlp INFIELD mmaa026 name="input.c.mmaa026"
 
            #END add-point
 
 
         #Ctrlp:input.c.mmaa027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa027
            #add-point:ON ACTION controlp INFIELD mmaa027 name="input.c.mmaa027"
 
            #END add-point
 
 
         #Ctrlp:input.c.mmaa028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa028
            #add-point:ON ACTION controlp INFIELD mmaa028 name="input.c.mmaa028"
 
            #END add-point
 
 
         #Ctrlp:input.c.mmaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa012
            #add-point:ON ACTION controlp INFIELD mmaa012 name="input.c.mmaa012"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa011
            #add-point:ON ACTION controlp INFIELD mmaa011 name="input.c.mmaa011"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa029
            #add-point:ON ACTION controlp INFIELD mmaa029 name="input.c.mmaa029"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa029             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2016" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa029 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa029 TO mmaa029              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa029                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa034
            #add-point:ON ACTION controlp INFIELD mmaa034 name="input.c.mmaa034"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa034             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2021" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa034 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa034 TO mmaa034              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa034                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa039
            #add-point:ON ACTION controlp INFIELD mmaa039 name="input.c.mmaa039"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa039             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2026" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa039 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa039 TO mmaa039              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa039                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa030
            #add-point:ON ACTION controlp INFIELD mmaa030 name="input.c.mmaa030"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa030             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2017" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa030 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa030 TO mmaa030              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa030                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa035
            #add-point:ON ACTION controlp INFIELD mmaa035 name="input.c.mmaa035"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa035             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2022" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa035 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa035 TO mmaa035              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa035                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa040
            #add-point:ON ACTION controlp INFIELD mmaa040 name="input.c.mmaa040"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa040             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2027" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa040 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa040 TO mmaa040              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa040                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa031
            #add-point:ON ACTION controlp INFIELD mmaa031 name="input.c.mmaa031"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa031             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2018" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa031 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa031 TO mmaa031              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa031                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa036
            #add-point:ON ACTION controlp INFIELD mmaa036 name="input.c.mmaa036"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa036             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2023" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa036 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa036 TO mmaa036              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa036                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa041
            #add-point:ON ACTION controlp INFIELD mmaa041 name="input.c.mmaa041"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa041             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2028" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa041 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa041 TO mmaa041              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa041                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa032
            #add-point:ON ACTION controlp INFIELD mmaa032 name="input.c.mmaa032"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa032             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2019" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa032 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa032 TO mmaa032              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa032                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa037
            #add-point:ON ACTION controlp INFIELD mmaa037 name="input.c.mmaa037"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa037             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2025" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa037 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa037 TO mmaa037              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa037                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa042
            #add-point:ON ACTION controlp INFIELD mmaa042 name="input.c.mmaa042"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa042             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2029" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa042 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa042 TO mmaa042              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa042                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa033
            #add-point:ON ACTION controlp INFIELD mmaa033 name="input.c.mmaa033"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa033             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2020" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa033 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa033 TO mmaa033              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa033                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa038
            #add-point:ON ACTION controlp INFIELD mmaa038 name="input.c.mmaa038"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa038             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2024" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa038 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa038 TO mmaa038              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa038                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa043
            #add-point:ON ACTION controlp INFIELD mmaa043 name="input.c.mmaa043"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa043             #給予default值
            LET g_qryparam.default2 = "" #g_mmaa_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2030" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa043 = g_qryparam.return1              
            #LET g_mmaa_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mmaa_m.mmaa043 TO mmaa043              #
            #DISPLAY g_mmaa_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mmaa043                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa057
            #add-point:ON ACTION controlp INFIELD mmaa057 name="input.c.mmaa057"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa057             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '2' #s
            LET g_qryparam.where=" mmby015 >= '",g_today,"'"
            #add by geza 20160702(S)
            IF g_mmaa_m.mmaasite IS NOT NULL THEN
               LET g_qryparam.where=g_qryparam.where," AND mmbysite = '",g_mmaa_m.mmaasite,"'"
            END IF
            IF g_mmaa_m.mmaa044 IS NOT NULL THEN
               LET g_qryparam.where=g_qryparam.where," AND mmby005 = '",g_mmaa_m.mmaa044,"'"
            END IF
            #add by geza 20160702(E)
            CALL q_mmby001()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa057 = g_qryparam.return1              

            DISPLAY g_mmaa_m.mmaa057 TO mmaa057              #
            CALL ammt500_mmaa057_ref() #add by geza 20160702

            NEXT FIELD mmaa057                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmaa047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa047
            #add-point:ON ACTION controlp INFIELD mmaa047 name="input.c.mmaa047"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa060
            #add-point:ON ACTION controlp INFIELD mmaa060 name="input.c.mmaa060"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa059
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa059
            #add-point:ON ACTION controlp INFIELD mmaa059 name="input.c.mmaa059"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa059             #給予default值
            
            IF NOT cl_null(g_mmaa_m.mmaa057) THEN
               LET g_qryparam.where=" mmaq002 IN (SELECT mmby005 FROM mmby_t WHERE mmbyent='",g_enterprise,"' AND mmby001='",g_mmaa_m.mmaa057,"')"
            END IF
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where="1=1"
            END IF
            IF g_mmaa_m.mmaa000='3' THEN
               LET g_qryparam.where = g_qryparam.where," AND mmaq002 IN(SELECT mmap002 FROM mmap_t WHERE mmapent = '",g_enterprise,"' AND mmap001 = 'ammm320' ",
                                      "             AND (mmap003 = '",g_mmaa_m.mmaasite,"' OR (mmap003 IN(SELECT ooed005 FROM ooed_t ",
                                      "    START WITH ooed004= '",g_mmaa_m.mmaasite,"' AND ooed001 = '8' AND ooedent = '",g_enterprise,"' ",
                                      "      AND ooed006 <='",g_today,"' ",
                                      "      AND (ooed007 >='",g_today,"' OR ooed007 IS NULL)",
                                      "  CONNECT BY  NOCYCLE PRIOR ooed005=ooed004 ",
                                      "      AND ooed001='8' AND ooedent = '",g_enterprise,"'",
                                      "      AND ooed006 <='",g_today,"' ",
                                      "      AND (ooed007 >='",g_today,"' OR ooed007 IS NULL)) AND mmap005 = 'Y')) AND mmapstus = 'Y')",
                                      " AND mmaq006 = '3' AND mmaq007 = 'Y' AND (mmaq005 IS NULL OR mmaq005 >= '",g_today,"')"
            ELSE
               LET g_qryparam.where =g_qryparam.where, " AND mmaq002 IN(SELECT mmap002 FROM mmap_t WHERE mmapent = '",g_enterprise,"' AND mmap001 = 'ammm320' ",
                                      "             AND (mmap003 = '",g_mmaa_m.mmaasite,"' OR (mmap003 IN(SELECT ooed005 FROM ooed_t ",
                                      "    START WITH ooed004= '",g_mmaa_m.mmaasite,"' AND ooed001 = '8' AND ooedent = '",g_enterprise,"' ",
                                      "      AND ooed006<='",g_today,"' ",
                                      "      AND (ooed007 >='",g_today,"' OR ooed007 IS NULL)",
                                      "  CONNECT BY  NOCYCLE PRIOR ooed005=ooed004 ",
                                      "      AND ooed001='8' AND ooedent = '",g_enterprise,"'",
                                      "      AND ooed006 <='",g_today,"' ",
                                      "      AND (ooed007 >='",g_today,"' OR ooed007 IS NULL)) AND mmap005 = 'Y')) AND mmapstus = 'Y')",
                                      " AND mmaq006 = '1' "
            END IF 
            CALL q_mmaq001_7()
 
            LET g_mmaa_m.mmaa059 = g_qryparam.return1              

            DISPLAY g_mmaa_m.mmaa059 TO mmaa059              #

            NEXT FIELD mmaa059                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa048
            #add-point:ON ACTION controlp INFIELD mmaa048 name="input.c.mmaa048"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa062
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa062
            #add-point:ON ACTION controlp INFIELD mmaa062 name="input.c.mmaa062"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mmaa_m.mmaa062             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_mmaa_m.mmaasite #s
            LET g_qryparam.where = " inaa102='6'"

 
            CALL q_inaa001_4()                                #呼叫開窗
 
            LET g_mmaa_m.mmaa062 = g_qryparam.return1              

            DISPLAY g_mmaa_m.mmaa062 TO mmaa062              #
            CALL ammt500_mmaa062_ref()
            NEXT FIELD mmaa062                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mmaa044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa044
            #add-point:ON ACTION controlp INFIELD mmaa044 name="input.c.mmaa044"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa049
            #add-point:ON ACTION controlp INFIELD mmaa049 name="input.c.mmaa049"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa058
            #add-point:ON ACTION controlp INFIELD mmaa058 name="input.c.mmaa058"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa045
            #add-point:ON ACTION controlp INFIELD mmaa045 name="input.c.mmaa045"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa050
            #add-point:ON ACTION controlp INFIELD mmaa050 name="input.c.mmaa050"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa046
            #add-point:ON ACTION controlp INFIELD mmaa046 name="input.c.mmaa046"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaa051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaa051
            #add-point:ON ACTION controlp INFIELD mmaa051 name="input.c.mmaa051"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mmaa_m.mmaadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  CALL s_aooi200_gen_docno(g_mmaa_m.mmaasite,g_mmaa_m.mmaadocno,g_mmaa_m.mmaadocdt,g_prog)
                  RETURNING g_success,g_mmaa_m.mmaadocno
                  IF g_success<>'1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apm-00003"
                     LET g_errparam.extend = g_mmaa_m.mmaadocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmaa_m.mmaadocno = g_mmaa_m_t.mmaadocno
                     NEXT FIELD mmaadocno
                  END IF
                  CALL ammt500_mmaa003()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmaa_m.mmaa004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD mmaa003 
                  END IF
                  CALL cl_set_comp_entry("mmaadocno,mmaadocdt",FALSE)
#                  LET g_mmaa_m.mmaaunit = g_mmaa_m.mmaasite #sakura add
                  
                  #geza 20150619 add --------------(S)
                   CALL s_aooi390_get_auto_no('9',g_mmaa_m.mmaa001) RETURNING l_success,g_mmaa_m.mmaa001
                   IF NOT l_success THEN
                      CALL s_transaction_end('N','0')
                      NEXT FIELD CURRENT
                   END IF
                   #geza 20150619 add --------------(E)
                  
                  CALL s_aooi390_oofi_upd('9',g_mmaa_m.mmaa001) RETURNING l_success   #150520-00041#1
               #end add-point
               
               INSERT INTO mmaa_t (mmaaent,mmaasite,mmaadocdt,mmaadocno,mmaa000,mmaa001,mmaa020,mmaa002, 
                   mmaa019,mmaa056,mmaa052,mmaa055,mmaa061,mmaa054,mmaastus,mmaa008,mmaa009,mmaa014, 
                   mmaa003,mmaa015,mmaa013,mmaa004,mmaa010,mmaa024,mmaa025,mmaa026,mmaa027,mmaa028,mmaa012, 
                   mmaa011,mmaa029,mmaa034,mmaa039,mmaa030,mmaa035,mmaa040,mmaa031,mmaa036,mmaa041,mmaa032, 
                   mmaa037,mmaa042,mmaa033,mmaa038,mmaa043,mmaa057,mmaa047,mmaa060,mmaa059,mmaa048,mmaa062, 
                   mmaa044,mmaa049,mmaa058,mmaa045,mmaa050,mmaa046,mmaa051,mmaaownid,mmaaowndp,mmaacrtid, 
                   mmaacrtdp,mmaacrtdt,mmaamodid,mmaamoddt,mmaacnfid,mmaacnfdt)
               VALUES (g_enterprise,g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt,g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000, 
                   g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019,g_mmaa_m.mmaa056, 
                   g_mmaa_m.mmaa052,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus, 
                   g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003,g_mmaa_m.mmaa015, 
                   g_mmaa_m.mmaa013,g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025, 
                   g_mmaa_m.mmaa026,g_mmaa_m.mmaa027,g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011, 
                   g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039,g_mmaa_m.mmaa030,g_mmaa_m.mmaa035, 
                   g_mmaa_m.mmaa040,g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041,g_mmaa_m.mmaa032, 
                   g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043, 
                   g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060,g_mmaa_m.mmaa059,g_mmaa_m.mmaa048, 
                   g_mmaa_m.mmaa062,g_mmaa_m.mmaa044,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045, 
                   g_mmaa_m.mmaa050,g_mmaa_m.mmaa046,g_mmaa_m.mmaa051,g_mmaa_m.mmaaownid,g_mmaa_m.mmaaowndp, 
                   g_mmaa_m.mmaacrtid,g_mmaa_m.mmaacrtdp,g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt, 
                   g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mmaa_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               #160604-00009#137 -s by 08172
               UPDATE mmaa_t SET mmaaunit=g_mmaa_m.mmaasite
                WHERE mmaaent=g_enterprise
                  AND mmaadocno=g_mmaa_m.mmaadocno
               IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = "g_mmaa_m"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
  
                   CALL s_transaction_end('N','0')
                   NEXT FIELD CURRENT
                END IF
                #160604-00009#137 -e by 08172
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               IF NOT s_ammt500_ins_rtia(g_mmaa_m.mmaadocno) THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               CALL ammt500_insert_mmab002() RETURNING l_flag1
              #CALL ammt500_insert_mmac002() RETURNING l_flag2
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmaa_m.mmaa015 != g_mmaa_m_t.mmaa015 OR g_mmaa_m_t.mmaa015 IS NULL or g_mmaa_m.mmaa015 IS NULL))) THEN 
                  CALL ammt500_insert_mmac002() RETURNING l_flag2
                  CALL ammt500_update_mmac002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmaa_m.mmaa015
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                
                     LET g_mmaa_m.mmaa015 = g_mmaa_m_t.mmaa015
                     NEXT FIELD mmaa015
                  END IF
               END IF
               
               IF NOT s_ammt500_ins_rtia1(g_mmaa_m.mmaadocno) THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF                  
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL ammt500_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL ammt500_b_fill()
                  CALL ammt500_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               LET g_mmaa_m.mmaa051=g_mmaa_m.mmaa045-g_mmaa_m.mmaa047
               DISPLAY BY NAME g_mmaa_m.mmaa051
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               CALL ammt500_mmaa003()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmaa_m.mmaa004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD mmaa003 
               END IF
               
               #mark by geza 20151112(S)
#               #add--2015/07/03 By shiun--(S)               
#               CALL s_aooi390_get_auto_no('9',g_mmaa_m.mmaa001) RETURNING l_success,g_mmaa_m.mmaa001
#               IF NOT l_success THEN
#                  CALL s_transaction_end('N','0')
#                  NEXT FIELD CURRENT
#               END IF
#               CALL s_aooi390_oofi_upd('9',g_mmaa_m.mmaa001) RETURNING l_success
#               #add--2015/07/03 By shiun--(E) 
               #mark by geza 20151112(E)               
               #end add-point
               
               #將遮罩欄位還原
               CALL ammt500_mmaa_t_mask_restore('restore_mask_o')
               
               UPDATE mmaa_t SET (mmaasite,mmaadocdt,mmaadocno,mmaa000,mmaa001,mmaa020,mmaa002,mmaa019, 
                   mmaa056,mmaa052,mmaa055,mmaa061,mmaa054,mmaastus,mmaa008,mmaa009,mmaa014,mmaa003, 
                   mmaa015,mmaa013,mmaa004,mmaa010,mmaa024,mmaa025,mmaa026,mmaa027,mmaa028,mmaa012,mmaa011, 
                   mmaa029,mmaa034,mmaa039,mmaa030,mmaa035,mmaa040,mmaa031,mmaa036,mmaa041,mmaa032,mmaa037, 
                   mmaa042,mmaa033,mmaa038,mmaa043,mmaa057,mmaa047,mmaa060,mmaa059,mmaa048,mmaa062,mmaa044, 
                   mmaa049,mmaa058,mmaa045,mmaa050,mmaa046,mmaa051,mmaaownid,mmaaowndp,mmaacrtid,mmaacrtdp, 
                   mmaacrtdt,mmaamodid,mmaamoddt,mmaacnfid,mmaacnfdt) = (g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt, 
                   g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000,g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002, 
                   g_mmaa_m.mmaa019,g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061, 
                   g_mmaa_m.mmaa054,g_mmaa_m.mmaastus,g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014, 
                   g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013,g_mmaa_m.mmaa004,g_mmaa_m.mmaa010, 
                   g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027,g_mmaa_m.mmaa028, 
                   g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039, 
                   g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031,g_mmaa_m.mmaa036, 
                   g_mmaa_m.mmaa041,g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033, 
                   g_mmaa_m.mmaa038,g_mmaa_m.mmaa043,g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060, 
                   g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062,g_mmaa_m.mmaa044,g_mmaa_m.mmaa049, 
                   g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046,g_mmaa_m.mmaa051, 
                   g_mmaa_m.mmaaownid,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaacrtid,g_mmaa_m.mmaacrtdp,g_mmaa_m.mmaacrtdt, 
                   g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfdt)
                WHERE mmaaent = g_enterprise AND mmaadocno = g_mmaadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mmaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               CALL ammt500_insert_mmab002() RETURNING l_flag1
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmaa_m.mmaa015 != g_mmaa_m_t.mmaa015 OR g_mmaa_m_t.mmaa015 IS NULL or g_mmaa_m.mmaa015 IS NULL))) THEN 
                  CALL ammt500_insert_mmac002() RETURNING l_flag2
                  CALL ammt500_update_mmac002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmaa_m.mmaa015
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               IF NOT s_ammt500_ins_rtia(g_mmaa_m.mmaadocno) THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_ammt500_ins_rtia1(g_mmaa_m.mmaadocno) THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               #160706-00018#1 -s by 08172
               UPDATE rtia_t SET rtia050 = g_mmaa_m.mmaa054 
                WHERE rtiaent = g_enterprise
                  AND rtiadocno = g_mmaa_m.mmaa058
               IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = "update rtia_t"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
  
                   CALL s_transaction_end('N','0')
                   NEXT FIELD CURRENT
                END IF
               #160706-00018#1 -e by 08172
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL ammt500_mmaa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mmaa_m_t)
               LET g_log2 = util.JSON.stringify(g_mmaa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                  
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mmaadocno_t = g_mmaa_m.mmaadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="ammt500.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmac_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmac_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt500_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mmac_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
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
            OPEN ammt500_cl USING g_enterprise,g_mmaa_m.mmaadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmac_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmac_d[l_ac].mmac002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmac_d_t.* = g_mmac_d[l_ac].*  #BACKUP
               LET g_mmac_d_o.* = g_mmac_d[l_ac].*  #BACKUP
               CALL ammt500_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL ammt500_set_no_entry_b(l_cmd)
               IF NOT ammt500_lock_b("mmac_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt500_bcl INTO g_mmac_d[l_ac].mmac001,g_mmac_d[l_ac].mmac002,g_mmac_d[l_ac].mmac003, 
                      g_mmac_d[l_ac].mmacacti
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mmac_d_t.mmac002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmac_d_mask_o[l_ac].* =  g_mmac_d[l_ac].*
                  CALL ammt500_mmac_t_mask()
                  LET g_mmac_d_mask_n[l_ac].* =  g_mmac_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt500_show()
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
            INITIALIZE g_mmac_d[l_ac].* TO NULL 
            INITIALIZE g_mmac_d_t.* TO NULL 
            INITIALIZE g_mmac_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_mmac_d[l_ac].mmacacti = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_mmac_d_t.* = g_mmac_d[l_ac].*     #新輸入資料
            LET g_mmac_d_o.* = g_mmac_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt500_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt500_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmac_d[li_reproduce_target].* = g_mmac_d[li_reproduce].*
 
               LET g_mmac_d[li_reproduce_target].mmac002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET  g_mmac_d[l_ac].mmac001 = g_mmaa_m.mmaa001
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
            SELECT COUNT(1) INTO l_count FROM mmac_t 
             WHERE mmacent = g_enterprise AND mmacdocno = g_mmaa_m.mmaadocno
 
               AND mmac002 = g_mmac_d[l_ac].mmac002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaa_m.mmaadocno
               LET gs_keys[2] = g_mmac_d[g_detail_idx].mmac002
               CALL ammt500_insert_b('mmac_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               UPDATE mmac_t SET mmac004 = g_mmac004,
                                 mmac005 = g_mmac005,
                                 mmac006 = g_mmac006
                          WHERE mmacdocno =  g_mmaa_m.mmaadocno
                            AND mmac002 =  g_mmac_d[l_ac].mmac002
                            AND mmacent = g_enterprise                            
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mmac_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmac_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt500_b_fill()
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
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_mmaa_m.mmaadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mmac_d_t.mmac002
 
            
               #刪除同層單身
               IF NOT ammt500_delete_b('mmac_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt500_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt500_key_delete_b(gs_keys,'mmac_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt500_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt500_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mmac_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmac_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmac001
            #add-point:BEFORE FIELD mmac001 name="input.b.page1.mmac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmac001
            
            #add-point:AFTER FIELD mmac001 name="input.a.page1.mmac001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmac001
            #add-point:ON CHANGE mmac001 name="input.g.page1.mmac001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmac002
            
            #add-point:AFTER FIELD mmac002 name="input.a.page1.mmac002"
            #此段落由子樣板a05產生
            LET g_mmac_d[l_ac].mmac002_desc = NULL
            DISPLAY  g_mmac_d[l_ac].mmac002_desc TO s_detail1[l_ac].mmac002_desc
            IF  NOT cl_null(g_mmaa_m.mmaadocno) AND NOT cl_null(g_mmac_d[l_ac].mmac002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmaa_m.mmaadocno != g_mmaadocno_t OR g_mmac_d[l_ac].mmac002 != g_mmac_d_t.mmac002 or g_mmac_d_t.mmac002 is null))) THEN 
                  if g_mmac_d[l_ac].mmac002=g_oocq002 then
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "amm-00123"
                     LET g_errparam.extend = g_mmac_d[l_ac].mmac002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmac_d[l_ac].mmac002 = g_mmac_d_t.mmac002
                     CALL ammt500_display_mmac002()
                     NEXT FIELD mmac002
                  END IF
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmac_t WHERE "||"mmacent = '" ||g_enterprise|| "' AND "||"mmacdocno = '"||g_mmaa_m.mmaadocno ||"' AND "|| "mmac002 = '"||g_mmac_d[l_ac].mmac002 ||"'",'std-00004',0) THEN 
                     LET g_mmac_d[l_ac].mmac002 = g_mmac_d_t.mmac002
                     CALL ammt500_display_mmac002()
                     NEXT FIELD CURRENT
                  END IF
                  CALL ammt500_mmac002()
                  IF NOT cl_null(g_errno) THEN
                     
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmac_d[l_ac].mmac002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmac_d[l_ac].mmac002 = g_mmac_d_t.mmac002
                     CALL ammt500_display_mmac002()
                     NEXT FIELD mmac002
                  END IF                
                                    
               END IF
            END IF
            CALL ammt500_display_mmac002()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmac002
            #add-point:BEFORE FIELD mmac002 name="input.b.page1.mmac002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmac002
            #add-point:ON CHANGE mmac002 name="input.g.page1.mmac002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmac003
            #add-point:BEFORE FIELD mmac003 name="input.b.page1.mmac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmac003
            
            #add-point:AFTER FIELD mmac003 name="input.a.page1.mmac003"
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmac_d[l_ac].mmac003 != g_mmac_d_t.mmac003 or g_mmac_d_t.mmac003 is null))) THEN   
                  CALL ammt500_mmac003(g_mmac_d[l_ac].mmac003) RETURNING g_mmac004,g_mmac005,g_mmac006
               END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmac003
            #add-point:ON CHANGE mmac003 name="input.g.page1.mmac003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmacacti
            #add-point:BEFORE FIELD mmacacti name="input.b.page1.mmacacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmacacti
            
            #add-point:AFTER FIELD mmacacti name="input.a.page1.mmacacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmacacti
            #add-point:ON CHANGE mmacacti name="input.g.page1.mmacacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmac001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmac001
            #add-point:ON ACTION controlp INFIELD mmac001 name="input.c.page1.mmac001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmac002
            #add-point:ON ACTION controlp INFIELD mmac002 name="input.c.page1.mmac002"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmac_d[l_ac].mmac002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2050" #應用分類
            if not cl_null(g_oocq002) then
               let g_qryparam.where = "oocq002!='",g_oocq002,"'"
            end if
            CALL q_oocq002()                                #呼叫開窗
            let g_qryparam.where = null
            LET g_mmac_d[l_ac].mmac002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmac_d[l_ac].mmac002 TO mmac002              #顯示到畫面上

            NEXT FIELD mmac002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmac003
            #add-point:ON ACTION controlp INFIELD mmac003 name="input.c.page1.mmac003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmacacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmacacti
            #add-point:ON ACTION controlp INFIELD mmacacti name="input.c.page1.mmacacti"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmac_d[l_ac].* = g_mmac_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt500_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mmac_d[l_ac].mmac002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmac_d[l_ac].* = g_mmac_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL ammt500_mmac_t_mask_restore('restore_mask_o')
      
               UPDATE mmac_t SET (mmacdocno,mmac001,mmac002,mmac003,mmacacti) = (g_mmaa_m.mmaadocno, 
                   g_mmac_d[l_ac].mmac001,g_mmac_d[l_ac].mmac002,g_mmac_d[l_ac].mmac003,g_mmac_d[l_ac].mmacacti) 
 
                WHERE mmacent = g_enterprise AND mmacdocno = g_mmaa_m.mmaadocno 
 
                  AND mmac002 = g_mmac_d_t.mmac002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmac_d[l_ac].* = g_mmac_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmac_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmac_d[l_ac].* = g_mmac_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmac_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaa_m.mmaadocno
               LET gs_keys_bak[1] = g_mmaadocno_t
               LET gs_keys[2] = g_mmac_d[g_detail_idx].mmac002
               LET gs_keys_bak[2] = g_mmac_d_t.mmac002
               CALL ammt500_update_b('mmac_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL ammt500_mmac_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mmac_d[g_detail_idx].mmac002 = g_mmac_d_t.mmac002 
 
                  ) THEN
                  LET gs_keys[01] = g_mmaa_m.mmaadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mmac_d_t.mmac002
 
                  CALL ammt500_key_update_b(gs_keys,'mmac_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmaa_m),util.JSON.stringify(g_mmac_d_t)
               LET g_log2 = util.JSON.stringify(g_mmaa_m),util.JSON.stringify(g_mmac_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF g_mmac_d[l_ac].mmac003 != g_mmac_d_t.mmac003 or cl_null(g_mmac_d_t.mmac003)THEN
                  UPDATE mmac_t SET mmac004 = g_mmac004,
                                 mmac005 = g_mmac005,
                                 mmac006 = g_mmac006
                          WHERE mmacdocno =  g_mmaa_m.mmaadocno
                            AND mmac002 =  g_mmac_d[l_ac].mmac002
                            AND mmacent = g_enterprise
                  CALL ammt500_update_mmaa015()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmac_d[l_ac].mmac003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmac_d[l_ac].mmac003 = g_mmac_d_t.mmac003
                     NEXT FIELD mmac003
                  END IF          
               END IF 
               IF g_mmac_d[l_ac].mmac002 != g_mmac_d_t.mmac002 THEN
                  CALL ammt500_update_mmaa015()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmac_d[l_ac].mmac002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmac_d[l_ac].mmac002 = g_mmac_d_t.mmac002
                     CALL ammt500_display_mmac002()
                     NEXT FIELD mmac002
                  END IF           
               END IF               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL ammt500_unlock_b("mmac_t","'1'")
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
               LET g_mmac_d[li_reproduce_target].* = g_mmac_d[li_reproduce].*
 
               LET g_mmac_d[li_reproduce_target].mmac002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmac_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmac_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_mmac2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmac2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt500_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmac2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmac2_d[l_ac].* TO NULL 
            INITIALIZE g_mmac2_d_t.* TO NULL 
            INITIALIZE g_mmac2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_mmac2_d[l_ac].mmaeacti = "Y"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_mmac2_d_t.* = g_mmac2_d[l_ac].*     #新輸入資料
            LET g_mmac2_d_o.* = g_mmac2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt500_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt500_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmac2_d[li_reproduce_target].* = g_mmac2_d[li_reproduce].*
 
               LET g_mmac2_d[li_reproduce_target].mmae002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            LET  g_mmac2_d[l_ac].mmae001 = g_mmaa_m.mmaa001
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
            OPEN ammt500_cl USING g_enterprise,g_mmaa_m.mmaadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmac2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmac2_d[l_ac].mmae002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmac2_d_t.* = g_mmac2_d[l_ac].*  #BACKUP
               LET g_mmac2_d_o.* = g_mmac2_d[l_ac].*  #BACKUP
               CALL ammt500_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL ammt500_set_no_entry_b(l_cmd)
               IF NOT ammt500_lock_b("mmae_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt500_bcl2 INTO g_mmac2_d[l_ac].mmae001,g_mmac2_d[l_ac].mmae002,g_mmac2_d[l_ac].mmaeacti 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmac2_d_mask_o[l_ac].* =  g_mmac2_d[l_ac].*
                  CALL ammt500_mmae_t_mask()
                  LET g_mmac2_d_mask_n[l_ac].* =  g_mmac2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt500_show()
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
               LET gs_keys[01] = g_mmaa_m.mmaadocno
               LET gs_keys[gs_keys.getLength()+1] = g_mmac2_d_t.mmae002
            
               #刪除同層單身
               IF NOT ammt500_delete_b('mmae_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt500_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt500_key_delete_b(gs_keys,'mmae_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt500_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt500_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_mmac_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmac2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mmae_t 
             WHERE mmaeent = g_enterprise AND mmaedocno = g_mmaa_m.mmaadocno
               AND mmae002 = g_mmac2_d[l_ac].mmae002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaa_m.mmaadocno
               LET gs_keys[2] = g_mmac2_d[g_detail_idx].mmae002
               CALL ammt500_insert_b('mmae_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmac_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mmae_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt500_b_fill()
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
               LET g_mmac2_d[l_ac].* = g_mmac2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt500_bcl2
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
               LET g_mmac2_d[l_ac].* = g_mmac2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL ammt500_mmae_t_mask_restore('restore_mask_o')
                              
               UPDATE mmae_t SET (mmaedocno,mmae001,mmae002,mmaeacti) = (g_mmaa_m.mmaadocno,g_mmac2_d[l_ac].mmae001, 
                   g_mmac2_d[l_ac].mmae002,g_mmac2_d[l_ac].mmaeacti) #自訂欄位頁簽
                WHERE mmaeent = g_enterprise AND mmaedocno = g_mmaa_m.mmaadocno
                  AND mmae002 = g_mmac2_d_t.mmae002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmac2_d[l_ac].* = g_mmac2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmae_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmac2_d[l_ac].* = g_mmac2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmae_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaa_m.mmaadocno
               LET gs_keys_bak[1] = g_mmaadocno_t
               LET gs_keys[2] = g_mmac2_d[g_detail_idx].mmae002
               LET gs_keys_bak[2] = g_mmac2_d_t.mmae002
               CALL ammt500_update_b('mmae_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammt500_mmae_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmac2_d[g_detail_idx].mmae002 = g_mmac2_d_t.mmae002 
                  ) THEN
                  LET gs_keys[01] = g_mmaa_m.mmaadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mmac2_d_t.mmae002
                  CALL ammt500_key_update_b(gs_keys,'mmae_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmaa_m),util.JSON.stringify(g_mmac2_d_t)
               LET g_log2 = util.JSON.stringify(g_mmaa_m),util.JSON.stringify(g_mmac2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmae001
            #add-point:BEFORE FIELD mmae001 name="input.b.page2.mmae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmae001
            
            #add-point:AFTER FIELD mmae001 name="input.a.page2.mmae001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmae001
            #add-point:ON CHANGE mmae001 name="input.g.page2.mmae001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmae002
            
            #add-point:AFTER FIELD mmae002 name="input.a.page2.mmae002"
            LET g_mmac2_d[l_ac].mmae002_desc = NULL
            DISPLAY BY NAME g_mmac2_d[l_ac].mmae002_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmaa_m.mmaadocno) AND NOT cl_null(g_mmac2_d[g_detail_idx].mmae002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmaa_m.mmaadocno != g_mmaadocno_t OR g_mmac2_d[g_detail_idx].mmae002 != g_mmac2_d_t.mmae002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmae_t WHERE "||"mmaeent = '" ||g_enterprise|| "' AND "||"mmaedocno = '"||g_mmaa_m.mmaadocno ||"' AND "|| "mmae002 = '"||g_mmac2_d[g_detail_idx].mmae002 ||"'",'std-00004',0) THEN 
                     LET g_mmac2_d[l_ac].mmae002 = g_mmac2_d_t.mmae002
                     CALL ammt500_display_mmae002()
                     NEXT FIELD mmae002
                  END IF
                  CALL ammt500_mmae002('2057',g_mmac2_d[l_ac].mmae002)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmac2_d[l_ac].mmae002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmac2_d[l_ac].mmae002 = g_mmac2_d_t.mmae002
                     CALL ammt500_display_mmae002()
                     NEXT FIELD mmae002
                  END IF
               END IF
            END IF
            CALL ammt500_display_mmae002()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmae002
            #add-point:BEFORE FIELD mmae002 name="input.b.page2.mmae002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmae002
            #add-point:ON CHANGE mmae002 name="input.g.page2.mmae002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaeacti
            #add-point:BEFORE FIELD mmaeacti name="input.b.page2.mmaeacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaeacti
            
            #add-point:AFTER FIELD mmaeacti name="input.a.page2.mmaeacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaeacti
            #add-point:ON CHANGE mmaeacti name="input.g.page2.mmaeacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.mmae001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmae001
            #add-point:ON ACTION controlp INFIELD mmae001 name="input.c.page2.mmae001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmae002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmae002
            #add-point:ON ACTION controlp INFIELD mmae002 name="input.c.page2.mmae002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmac2_d[l_ac].mmae002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2057" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mmac2_d[l_ac].mmae002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmac2_d[l_ac].mmae002 TO mmae002              #顯示到畫面上

            NEXT FIELD mmae002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.mmaeacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaeacti
            #add-point:ON ACTION controlp INFIELD mmaeacti name="input.c.page2.mmaeacti"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmac2_d[l_ac].* = g_mmac2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt500_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammt500_unlock_b("mmae_t","'2'")
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
               LET g_mmac2_d[li_reproduce_target].* = g_mmac2_d[li_reproduce].*
 
               LET g_mmac2_d[li_reproduce_target].mmae002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmac2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmac2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mmac3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmac3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt500_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmac3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmac3_d[l_ac].* TO NULL 
            INITIALIZE g_mmac3_d_t.* TO NULL 
            INITIALIZE g_mmac3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_mmac3_d[l_ac].mmadacti = "Y"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_mmac3_d_t.* = g_mmac3_d[l_ac].*     #新輸入資料
            LET g_mmac3_d_o.* = g_mmac3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt500_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt500_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmac3_d[li_reproduce_target].* = g_mmac3_d[li_reproduce].*
 
               LET g_mmac3_d[li_reproduce_target].mmad002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            LET  g_mmac3_d[l_ac].mmad001 = g_mmaa_m.mmaa001   
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
            OPEN ammt500_cl USING g_enterprise,g_mmaa_m.mmaadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmac3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmac3_d[l_ac].mmad002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmac3_d_t.* = g_mmac3_d[l_ac].*  #BACKUP
               LET g_mmac3_d_o.* = g_mmac3_d[l_ac].*  #BACKUP
               CALL ammt500_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL ammt500_set_no_entry_b(l_cmd)
               IF NOT ammt500_lock_b("mmad_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt500_bcl3 INTO g_mmac3_d[l_ac].mmad001,g_mmac3_d[l_ac].mmad002,g_mmac3_d[l_ac].mmadacti 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmac3_d_mask_o[l_ac].* =  g_mmac3_d[l_ac].*
                  CALL ammt500_mmad_t_mask()
                  LET g_mmac3_d_mask_n[l_ac].* =  g_mmac3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt500_show()
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
               LET gs_keys[01] = g_mmaa_m.mmaadocno
               LET gs_keys[gs_keys.getLength()+1] = g_mmac3_d_t.mmad002
            
               #刪除同層單身
               IF NOT ammt500_delete_b('mmad_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt500_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt500_key_delete_b(gs_keys,'mmad_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt500_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt500_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_mmac_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmac3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mmad_t 
             WHERE mmadent = g_enterprise AND mmaddocno = g_mmaa_m.mmaadocno
               AND mmad002 = g_mmac3_d[l_ac].mmad002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaa_m.mmaadocno
               LET gs_keys[2] = g_mmac3_d[g_detail_idx].mmad002
               CALL ammt500_insert_b('mmad_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmac_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mmad_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt500_b_fill()
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
               LET g_mmac3_d[l_ac].* = g_mmac3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt500_bcl3
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
               LET g_mmac3_d[l_ac].* = g_mmac3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL ammt500_mmad_t_mask_restore('restore_mask_o')
                              
               UPDATE mmad_t SET (mmaddocno,mmad001,mmad002,mmadacti) = (g_mmaa_m.mmaadocno,g_mmac3_d[l_ac].mmad001, 
                   g_mmac3_d[l_ac].mmad002,g_mmac3_d[l_ac].mmadacti) #自訂欄位頁簽
                WHERE mmadent = g_enterprise AND mmaddocno = g_mmaa_m.mmaadocno
                  AND mmad002 = g_mmac3_d_t.mmad002 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmac3_d[l_ac].* = g_mmac3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmad_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmac3_d[l_ac].* = g_mmac3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmad_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaa_m.mmaadocno
               LET gs_keys_bak[1] = g_mmaadocno_t
               LET gs_keys[2] = g_mmac3_d[g_detail_idx].mmad002
               LET gs_keys_bak[2] = g_mmac3_d_t.mmad002
               CALL ammt500_update_b('mmad_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammt500_mmad_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmac3_d[g_detail_idx].mmad002 = g_mmac3_d_t.mmad002 
                  ) THEN
                  LET gs_keys[01] = g_mmaa_m.mmaadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mmac3_d_t.mmad002
                  CALL ammt500_key_update_b(gs_keys,'mmad_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmaa_m),util.JSON.stringify(g_mmac3_d_t)
               LET g_log2 = util.JSON.stringify(g_mmaa_m),util.JSON.stringify(g_mmac3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmad001
            #add-point:BEFORE FIELD mmad001 name="input.b.page3.mmad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmad001
            
            #add-point:AFTER FIELD mmad001 name="input.a.page3.mmad001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmad001
            #add-point:ON CHANGE mmad001 name="input.g.page3.mmad001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmad002
            
            #add-point:AFTER FIELD mmad002 name="input.a.page3.mmad002"
            LET g_mmac3_d[l_ac].mmad002_desc = null
            DISPLAY BY NAME g_mmac3_d[l_ac].mmad002_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmaa_m.mmaadocno) AND NOT cl_null(g_mmac3_d[g_detail_idx].mmad002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmaa_m.mmaadocno != g_mmaadocno_t OR g_mmac3_d[g_detail_idx].mmad002 != g_mmac3_d_t.mmad002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmad_t WHERE "||"mmadent = '" ||g_enterprise|| "' AND "||"mmaddocno = '"||g_mmaa_m.mmaadocno ||"' AND "|| "mmad002 = '"||g_mmac3_d[g_detail_idx].mmad002 ||"'",'std-00004',0) THEN 
                     LET g_mmac3_d[l_ac].mmad002 = g_mmac3_d_t.mmad002
                     NEXT FIELD mmad002
                  END IF
                  CALL ammt500_mmad002('2051',g_mmac3_d[l_ac].mmad002)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmac3_d[l_ac].mmad002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmac3_d[l_ac].mmad002 = g_mmac3_d_t.mmad002
                     CALL ammt500_display_mmad002()
                     NEXT FIELD mmad002
                  END IF
               END IF
            END IF
            CALL ammt500_display_mmad002()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmad002
            #add-point:BEFORE FIELD mmad002 name="input.b.page3.mmad002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmad002
            #add-point:ON CHANGE mmad002 name="input.g.page3.mmad002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmadacti
            #add-point:BEFORE FIELD mmadacti name="input.b.page3.mmadacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmadacti
            
            #add-point:AFTER FIELD mmadacti name="input.a.page3.mmadacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmadacti
            #add-point:ON CHANGE mmadacti name="input.g.page3.mmadacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.mmad001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmad001
            #add-point:ON ACTION controlp INFIELD mmad001 name="input.c.page3.mmad001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmad002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmad002
            #add-point:ON ACTION controlp INFIELD mmad002 name="input.c.page3.mmad002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmac3_d[l_ac].mmad002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2051" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mmac3_d[l_ac].mmad002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmac3_d[l_ac].mmad002 TO mmad002              #顯示到畫面上

            NEXT FIELD mmad002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.mmadacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmadacti
            #add-point:ON ACTION controlp INFIELD mmadacti name="input.c.page3.mmadacti"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmac3_d[l_ac].* = g_mmac3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt500_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammt500_unlock_b("mmad_t","'3'")
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
               LET g_mmac3_d[li_reproduce_target].* = g_mmac3_d[li_reproduce].*
 
               LET g_mmac3_d[li_reproduce_target].mmad002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmac3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmac3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mmac4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmac4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt500_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmac4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmac4_d[l_ac].* TO NULL 
            INITIALIZE g_mmac4_d_t.* TO NULL 
            INITIALIZE g_mmac4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_mmac4_d_t.* = g_mmac4_d[l_ac].*     #新輸入資料
            LET g_mmac4_d_o.* = g_mmac4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt500_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt500_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmac4_d[li_reproduce_target].* = g_mmac4_d[li_reproduce].*
 
               LET g_mmac4_d[li_reproduce_target].mmab002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            LET  g_mmac4_d[l_ac].mmab001 = g_mmaa_m.mmaa001
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
            OPEN ammt500_cl USING g_enterprise,g_mmaa_m.mmaadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmac4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmac4_d[l_ac].mmab002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmac4_d_t.* = g_mmac4_d[l_ac].*  #BACKUP
               LET g_mmac4_d_o.* = g_mmac4_d[l_ac].*  #BACKUP
               CALL ammt500_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL ammt500_set_no_entry_b(l_cmd)
               IF NOT ammt500_lock_b("mmab_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt500_bcl4 INTO g_mmac4_d[l_ac].mmab001,g_mmac4_d[l_ac].mmab002,g_mmac4_d[l_ac].mmab003, 
                      g_mmac4_d[l_ac].mmab004
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmac4_d_mask_o[l_ac].* =  g_mmac4_d[l_ac].*
                  CALL ammt500_mmab_t_mask()
                  LET g_mmac4_d_mask_n[l_ac].* =  g_mmac4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt500_show()
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
               LET gs_keys[01] = g_mmaa_m.mmaadocno
               LET gs_keys[gs_keys.getLength()+1] = g_mmac4_d_t.mmab002
            
               #刪除同層單身
               IF NOT ammt500_delete_b('mmab_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt500_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt500_key_delete_b(gs_keys,'mmab_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt500_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt500_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_mmac_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmac4_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mmab_t 
             WHERE mmabent = g_enterprise AND mmabdocno = g_mmaa_m.mmaadocno
               AND mmab002 = g_mmac4_d[l_ac].mmab002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaa_m.mmaadocno
               LET gs_keys[2] = g_mmac4_d[g_detail_idx].mmab002
               CALL ammt500_insert_b('mmab_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmac_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mmab_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt500_b_fill()
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
               LET g_mmac4_d[l_ac].* = g_mmac4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt500_bcl4
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
               LET g_mmac4_d[l_ac].* = g_mmac4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL ammt500_mmab_t_mask_restore('restore_mask_o')
                              
               UPDATE mmab_t SET (mmabdocno,mmab001,mmab002,mmab003,mmab004) = (g_mmaa_m.mmaadocno,g_mmac4_d[l_ac].mmab001, 
                   g_mmac4_d[l_ac].mmab002,g_mmac4_d[l_ac].mmab003,g_mmac4_d[l_ac].mmab004) #自訂欄位頁簽 
 
                WHERE mmabent = g_enterprise AND mmabdocno = g_mmaa_m.mmaadocno
                  AND mmab002 = g_mmac4_d_t.mmab002 #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmac4_d[l_ac].* = g_mmac4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmab_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmac4_d[l_ac].* = g_mmac4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmaa_m.mmaadocno
               LET gs_keys_bak[1] = g_mmaadocno_t
               LET gs_keys[2] = g_mmac4_d[g_detail_idx].mmab002
               LET gs_keys_bak[2] = g_mmac4_d_t.mmab002
               CALL ammt500_update_b('mmab_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammt500_mmab_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmac4_d[g_detail_idx].mmab002 = g_mmac4_d_t.mmab002 
                  ) THEN
                  LET gs_keys[01] = g_mmaa_m.mmaadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mmac4_d_t.mmab002
                  CALL ammt500_key_update_b(gs_keys,'mmab_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmaa_m),util.JSON.stringify(g_mmac4_d_t)
               LET g_log2 = util.JSON.stringify(g_mmaa_m),util.JSON.stringify(g_mmac4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmab001
            #add-point:BEFORE FIELD mmab001 name="input.b.page4.mmab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmab001
            
            #add-point:AFTER FIELD mmab001 name="input.a.page4.mmab001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmab001
            #add-point:ON CHANGE mmab001 name="input.g.page4.mmab001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmab002
            
            #add-point:AFTER FIELD mmab002 name="input.a.page4.mmab002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmac4_d[l_ac].mmab002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2049' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmac4_d[l_ac].mmab002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmac4_d[l_ac].mmab002_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmaa_m.mmaadocno) AND NOT cl_null(g_mmac4_d[g_detail_idx].mmab002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmaa_m.mmaadocno != g_mmaadocno_t OR g_mmac4_d[g_detail_idx].mmab002 != g_mmac4_d_t.mmab002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmab_t WHERE "||"mmabent = '" ||g_enterprise|| "' AND "||"mmabdocno = '"||g_mmaa_m.mmaadocno ||"' AND "|| "mmab002 = '"||g_mmac4_d[g_detail_idx].mmab002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD mmab002
                  END IF
                  
               END IF
            END IF
  

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmab002
            #add-point:BEFORE FIELD mmab002 name="input.b.page4.mmab002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmab002
            #add-point:ON CHANGE mmab002 name="input.g.page4.mmab002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmab003
            #add-point:BEFORE FIELD mmab003 name="input.b.page4.mmab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmab003
            
            #add-point:AFTER FIELD mmab003 name="input.a.page4.mmab003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmab003
            #add-point:ON CHANGE mmab003 name="input.g.page4.mmab003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmab004
            
            #add-point:AFTER FIELD mmab004 name="input.a.page4.mmab004"
            LET g_mmac4_d[l_ac].mmab004_desc = null
            DISPLAY BY NAME g_mmac4_d[l_ac].mmab004_desc
            IF NOT cl_null(g_mmac4_d[l_ac].mmab004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmac4_d[l_ac].mmab004 != g_mmac4_d_t.mmab004 or g_mmac4_d_t.mmab004 IS NULL))) THEN 
                  CALL ammt500_mmab004(g_mmac4_d[l_ac].mmab003,g_mmac4_d[l_ac].mmab004)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmac4_d[l_ac].mmab004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmac4_d[l_ac].mmab004 = g_mmac4_d_t.mmab004
                     CALL ammt500_display_mmab004()
                     NEXT FIELD mmab004
                  END IF
               END IF
            END IF            
            CALL ammt500_display_mmab004()  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmab004
            #add-point:BEFORE FIELD mmab004 name="input.b.page4.mmab004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmab004
            #add-point:ON CHANGE mmab004 name="input.g.page4.mmab004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.mmab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmab001
            #add-point:ON ACTION controlp INFIELD mmab001 name="input.c.page4.mmab001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmab002
            #add-point:ON ACTION controlp INFIELD mmab002 name="input.c.page4.mmab002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmac4_d[l_ac].mmab002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2049" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mmac4_d[l_ac].mmab002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmac4_d[l_ac].mmab002 TO mmab002              #顯示到畫面上

            NEXT FIELD mmab002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.mmab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmab003
            #add-point:ON ACTION controlp INFIELD mmab003 name="input.c.page4.mmab003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmab004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmab004
            #add-point:ON ACTION controlp INFIELD mmab004 name="input.c.page4.mmab004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmac4_d[l_ac].mmab004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_mmac4_d[l_ac].mmab003 #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mmac4_d[l_ac].mmab004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmac4_d[l_ac].mmab004 TO mmab004              #顯示到畫面上

            NEXT FIELD mmab004                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmac4_d[l_ac].* = g_mmac4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt500_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammt500_unlock_b("mmab_t","'4'")
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
               LET g_mmac4_d[li_reproduce_target].* = g_mmac4_d[li_reproduce].*
 
               LET g_mmac4_d[li_reproduce_target].mmab002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmac4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmac4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="ammt500.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD mmaasite #sakura add
            #end add-point  
            NEXT FIELD mmaadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmac001
               WHEN "s_detail2"
                  NEXT FIELD mmae001
               WHEN "s_detail3"
                  NEXT FIELD mmad001
               WHEN "s_detail4"
                  NEXT FIELD mmab001
 
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
 
{<section id="ammt500.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION ammt500_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL ammt500_b_fill() #單身填充
      CALL ammt500_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL ammt500_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   #add by geza 20160702(S)
   CALL ammt500_mmaa057_ref() #add by geza 20160702
   #add by geza 20160702(E)
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmaa_m.mmaa018
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmaa_m.mmaa018_desc = g_rtn_fields[1] 
#            DISPLAY BY NAME g_mmaa_m.mmaa018_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaa_m.mmaa019
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmaa_m.mmaa019_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_mmaa_m.mmaa019_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmaa_m.mmaa016
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmaa_m.mmaa016_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_mmaa_m.mmaa016_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmaa_m.mmaa017
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmaa_m.mmaa017_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_mmaa_m.mmaa017_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaa_m.mmaaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmaa_m.mmaaownid_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_mmaa_m.mmaaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaa_m.mmaaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmaa_m.mmaaowndp_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_mmaa_m.mmaaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaa_m.mmaacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmaa_m.mmaacrtid_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_mmaa_m.mmaacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaa_m.mmaacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmaa_m.mmaacrtdp_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_mmaa_m.mmaacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaa_m.mmaamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmaa_m.mmaamodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmaa_m.mmaamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaa_m.mmaacnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmaa_m.mmaacnfid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmaa_m.mmaacnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_mmaa_m_mask_o.* =  g_mmaa_m.*
   CALL ammt500_mmaa_t_mask()
   LET g_mmaa_m_mask_n.* =  g_mmaa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmaa_m.mmaasite,g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaadocdt,g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000, 
       g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa056, 
       g_mmaa_m.mmaa052,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa061_desc, 
       g_mmaa_m.mmaa054,g_mmaa_m.mmaastus,g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003, 
       g_mmaa_m.mmaa015,g_mmaa_m.mmaa013,g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025, 
       g_mmaa_m.mmaa026,g_mmaa_m.mmaa027,g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029, 
       g_mmaa_m.mmaa034,g_mmaa_m.mmaa039,g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031, 
       g_mmaa_m.mmaa036,g_mmaa_m.mmaa041,g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033, 
       g_mmaa_m.mmaa038,g_mmaa_m.mmaa043,g_mmaa_m.mmaa057,g_mmaa_m.mmaa057_desc,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060, 
       g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062,g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044,g_mmaa_m.mmaa044_desc, 
       g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046,g_mmaa_m.mmaa051, 
       g_mmaa_m.mmaaownid,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid, 
       g_mmaa_m.mmaacrtid_desc,g_mmaa_m.mmaacrtdp,g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid, 
       g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfid_desc,g_mmaa_m.mmaacnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmaa_m.mmaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mmac_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmac_d[l_ac].mmac002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2050' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmac_d[l_ac].mmac002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmac_d[l_ac].mmac002_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mmac2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmac2_d[l_ac].mmae002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2057' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmac2_d[l_ac].mmae002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmac2_d[l_ac].mmae002_desc
            
            

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mmac3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmac3_d[l_ac].mmad002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2051' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmac3_d[l_ac].mmad002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmac3_d[l_ac].mmad002_desc   

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mmac4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
            

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmac4_d[l_ac].mmab002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2049' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmac4_d[l_ac].mmab002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmac4_d[l_ac].mmab002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmac4_d[l_ac].mmab003
            LET g_ref_fields[2] = g_mmac4_d[l_ac].mmab004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmac4_d[l_ac].mmab004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmac4_d[l_ac].mmab004_desc
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   CALL ammt500_mmaa025_scc()
   CALL ammt500_mmaa026_scc()
   CALL ammt500_mmaa027_scc()
   CALL ammt500_mmaa028_scc()
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL ammt500_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION ammt500_detail_show()
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
 
{<section id="ammt500.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION ammt500_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mmaa_t.mmaadocno 
   DEFINE l_oldno     LIKE mmaa_t.mmaadocno 
 
   DEFINE l_master    RECORD LIKE mmaa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mmac_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mmae_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE mmad_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE mmab_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert      LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5    #sakura add
   DEFINE l_doctype     LIKE rtai_t.rtai004 #sakura add  
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
   
   IF g_mmaa_m.mmaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mmaadocno_t = g_mmaa_m.mmaadocno
 
    
   LET g_mmaa_m.mmaadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmaa_m.mmaaownid = g_user
      LET g_mmaa_m.mmaaowndp = g_dept
      LET g_mmaa_m.mmaacrtid = g_user
      LET g_mmaa_m.mmaacrtdp = g_dept 
      LET g_mmaa_m.mmaacrtdt = cl_get_current()
      LET g_mmaa_m.mmaamodid = g_user
      LET g_mmaa_m.mmaamoddt = cl_get_current()
      LET g_mmaa_m.mmaastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_mmaa_m.mmaadocdt = g_today
   CALL s_aooi500_default(g_prog,'mmaasite',g_mmaa_m.mmaasite) RETURNING l_insert,g_mmaa_m.mmaasite
   IF NOT l_insert THEN
      RETURN
   END IF
   CALL ammt500_display_mmaasite()
   #sakura---add---str
   #預設單據的單別
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_mmaa_m.mmaasite,g_prog,'1')
      RETURNING l_success,l_doctype
   LET g_mmaa_m.mmaadocno = l_doctype
   #sakura---add---end   
   LET g_mmaa_m.mmaa019 = g_user #add by geza 150616-00035#27 
   CALL ammt500_display_mmaa019()  #add by geza 150616-00035#27 
   LET g_mmaa_m.mmaa058=''   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmaa_m.mmaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL ammt500_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mmaa_m.* TO NULL
      INITIALIZE g_mmac_d TO NULL
      INITIALIZE g_mmac2_d TO NULL
      INITIALIZE g_mmac3_d TO NULL
      INITIALIZE g_mmac4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL ammt500_show()
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
   CALL ammt500_set_act_visible()   
   CALL ammt500_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmaadocno_t = g_mmaa_m.mmaadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmaaent = " ||g_enterprise|| " AND",
                      " mmaadocno = '", g_mmaa_m.mmaadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt500_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL ammt500_idx_chk()
   
   LET g_data_owner = g_mmaa_m.mmaaownid      
   LET g_data_dept  = g_mmaa_m.mmaaowndp
   
   #功能已完成,通報訊息中心
   CALL ammt500_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION ammt500_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mmac_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mmae_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE mmad_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE mmab_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE ammt500_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmac_t
    WHERE mmacent = g_enterprise AND mmacdocno = g_mmaadocno_t
 
    INTO TEMP ammt500_detail
 
   #將key修正為調整後   
   UPDATE ammt500_detail 
      #更新key欄位
      SET mmacdocno = g_mmaa_m.mmaadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mmac_t SELECT * FROM ammt500_detail
   
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
   DROP TABLE ammt500_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmae_t 
    WHERE mmaeent = g_enterprise AND mmaedocno = g_mmaadocno_t
 
    INTO TEMP ammt500_detail
 
   #將key修正為調整後   
   UPDATE ammt500_detail SET mmaedocno = g_mmaa_m.mmaadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mmae_t SELECT * FROM ammt500_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt500_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmad_t 
    WHERE mmadent = g_enterprise AND mmaddocno = g_mmaadocno_t
 
    INTO TEMP ammt500_detail
 
   #將key修正為調整後   
   UPDATE ammt500_detail SET mmaddocno = g_mmaa_m.mmaadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mmad_t SELECT * FROM ammt500_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt500_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmab_t 
    WHERE mmabent = g_enterprise AND mmabdocno = g_mmaadocno_t
 
    INTO TEMP ammt500_detail
 
   #將key修正為調整後   
   UPDATE ammt500_detail SET mmabdocno = g_mmaa_m.mmaadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mmab_t SELECT * FROM ammt500_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt500_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mmaadocno_t = g_mmaa_m.mmaadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammt500_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
 
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_mmaa_m.mmaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN ammt500_cl USING g_enterprise,g_mmaa_m.mmaadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt500_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt500_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt500_master_referesh USING g_mmaa_m.mmaadocno INTO g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt, 
       g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000,g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019, 
       g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus, 
       g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013, 
       g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027, 
       g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039, 
       g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041, 
       g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043, 
       g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060,g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062, 
       g_mmaa_m.mmaa044,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046, 
       g_mmaa_m.mmaa051,g_mmaa_m.mmaaownid,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaacrtid,g_mmaa_m.mmaacrtdp, 
       g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfdt, 
       g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa061_desc,g_mmaa_m.mmaa057_desc, 
       g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044_desc,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid_desc, 
       g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT ammt500_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmaa_m_mask_o.* =  g_mmaa_m.*
   CALL ammt500_mmaa_t_mask()
   LET g_mmaa_m_mask_n.* =  g_mmaa_m.*
   
   CALL ammt500_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #检查是否有收款资料
   LET g_cnt = 0
   SELECT COUNT(*) INTO g_cnt
     FROM rtif_t
    WHERE rtifent = g_enterprise
      AND rtifdocno = g_mmaa_m.mmaa058
   IF g_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "art-00397"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
       
      RETURN
   END IF
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      IF NOT cl_null(g_mmaa_m.mmaa058) THEN
         DELETE FROM rtib_t WHERE rtibent = g_enterprise AND rtibdocno = g_mmaa_m.mmaa058
         DELETE FROM rtic_t WHERE rticent = g_enterprise AND rticdocno = g_mmaa_m.mmaa058
         DELETE FROM mmea_t WHERE mmeaent = g_enterprise AND mmeadocno = g_mmaa_m.mmaa058
         DELETE FROM mmed_t WHERE mmedent = g_enterprise AND mmeddocno = g_mmaa_m.mmaa058
         DELETE FROM xrcd_t WHERE xrcdseq2 = 0 AND xrcddocno = g_mmaa_m.mmaa058 AND xrcdent = g_enterprise
         DELETE FROM rtia_t WHERE rtiaent = g_enterprise AND rtiadocno = g_mmaa_m.mmaa058
      END IF
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammt500_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mmaadocno_t = g_mmaa_m.mmaadocno
 
 
      DELETE FROM mmaa_t
       WHERE mmaaent = g_enterprise AND mmaadocno = g_mmaa_m.mmaadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mmaa_m.mmaadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #sakura---add---str
      IF NOT s_aooi200_del_docno(g_mmaa_m.mmaadocno,g_mmaa_m.mmaadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #sakura---add---end
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mmac_t
       WHERE mmacent = g_enterprise AND mmacdocno = g_mmaa_m.mmaadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM mmae_t
       WHERE mmaeent = g_enterprise AND
             mmaedocno = g_mmaa_m.mmaadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmae_t:",SQLERRMESSAGE 
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
      DELETE FROM mmad_t
       WHERE mmadent = g_enterprise AND
             mmaddocno = g_mmaa_m.mmaadocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmad_t:",SQLERRMESSAGE 
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
      DELETE FROM mmab_t
       WHERE mmabent = g_enterprise AND
             mmabdocno = g_mmaa_m.mmaadocno
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
#      IF NOT cl_null(g_mmaa_m.mmaa058) THEN
#         DELETE FROM rtib_t WHERE rtibent = g_enterprise AND rtibdocno = g_mmaa_m.mmaa058
#         DELETE FROM rtic_t WHERE rticent = g_enterprise AND rticdocno = g_mmaa_m.mmaa058
#         DELETE FROM mmea_t WHERE mmeaent = g_enterprise AND mmeadocno = g_mmaa_m.mmaa058
#         DELETE FROM mmed_t WHERE mmedent = g_enterprise AND mmeddocno = g_mmaa_m.mmaa058
#         DELETE FROM xrcd_t WHERE xrcdseq2 = 0 AND xrcddocno = g_mmaa_m.mmaa058 AND xrcdent = g_enterprise
#         DELETE FROM rtia_t WHERE rtiaent = g_enterprise AND rtiadocno = g_mmaa_m.mmaa058
#      END IF
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mmaa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE ammt500_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mmac_d.clear() 
      CALL g_mmac2_d.clear()       
      CALL g_mmac3_d.clear()       
      CALL g_mmac4_d.clear()       
 
     
      CALL ammt500_ui_browser_refresh()  
      #CALL ammt500_ui_headershow()  
      #CALL ammt500_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL ammt500_browser_fill("")
         CALL ammt500_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE ammt500_cl
 
   #功能已完成,通報訊息中心
   CALL ammt500_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="ammt500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammt500_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_oocq002  LIKE oocq_t.oocq002
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mmac_d.clear()
   CALL g_mmac2_d.clear()
   CALL g_mmac3_d.clear()
   CALL g_mmac4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   RETURN
   #end add-point
   
   #判斷是否填充
   IF ammt500_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmac001,mmac002,mmac003,mmacacti ,t1.oocql004 FROM mmac_t",   
              
                     " INNER JOIN mmaa_t ON mmaaent = " ||g_enterprise|| " AND mmaadocno = mmacdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2050' AND t1.oocql002=mmac002 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE mmacent=? AND mmacdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmac_t.mmac002"
         
         #add-point:單身填充控制 name="b_fill.sql"
      SELECT ooaa002 INTO l_oocq002 FROM ooaa_t WHERE ooaa001 = 'E-CIR-0004' AND ooaaent=g_enterprise
      
      LET g_sql = "SELECT  UNIQUE mmac001,mmac002,mmac003,mmacacti ,t1.oocql004 FROM mmac_t",   
                  " INNER JOIN mmaa_t ON mmaadocno = mmacdocno ",
 
                  #"",
                  
                  "",
                                 " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='2050' AND t1.oocql002=mmac002 AND t1.oocql003='"||g_dlang||"' ",
 
                  " WHERE mmacent=? AND mmacdocno=?"
      
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF      
      #mark by geza 20151109(S)
#      IF NOT cl_null(l_oocq002) THEN
#         LET g_sql = g_sql CLIPPED, " AND mmac002<>'",l_oocq002 clipped,"' "
#      END IF
      #mark by geza 20151109(E)
      LET g_sql = g_sql, " ORDER BY mmac_t.mmac002"
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt500_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR ammt500_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mmaa_m.mmaadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mmaa_m.mmaadocno INTO g_mmac_d[l_ac].mmac001,g_mmac_d[l_ac].mmac002, 
          g_mmac_d[l_ac].mmac003,g_mmac_d[l_ac].mmacacti,g_mmac_d[l_ac].mmac002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL ammt500_display_mmac002()  
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
   IF ammt500_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmae001,mmae002,mmaeacti ,t2.oocql004 FROM mmae_t",   
                     " INNER JOIN  mmaa_t ON mmaaent = " ||g_enterprise|| " AND mmaadocno = mmaedocno ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2057' AND t2.oocql002=mmae002 AND t2.oocql003='"||g_dlang||"' ",
 
                     " WHERE mmaeent=? AND mmaedocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmae_t.mmae002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt500_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR ammt500_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_mmaa_m.mmaadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_mmaa_m.mmaadocno INTO g_mmac2_d[l_ac].mmae001,g_mmac2_d[l_ac].mmae002, 
          g_mmac2_d[l_ac].mmaeacti,g_mmac2_d[l_ac].mmae002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL ammt500_display_mmae002()
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
   IF ammt500_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmad001,mmad002,mmadacti ,t3.oocql004 FROM mmad_t",   
                     " INNER JOIN  mmaa_t ON mmaaent = " ||g_enterprise|| " AND mmaadocno = mmaddocno ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2051' AND t3.oocql002=mmad002 AND t3.oocql003='"||g_dlang||"' ",
 
                     " WHERE mmadent=? AND mmaddocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmad_t.mmad002"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt500_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR ammt500_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_mmaa_m.mmaadocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_mmaa_m.mmaadocno INTO g_mmac3_d[l_ac].mmad001,g_mmac3_d[l_ac].mmad002, 
          g_mmac3_d[l_ac].mmadacti,g_mmac3_d[l_ac].mmad002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
      
         CALL ammt500_display_mmad002()
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
   IF ammt500_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmab001,mmab002,mmab003,mmab004 ,t4.oocql004 ,t5.oocql004 FROM mmab_t", 
                
                     " INNER JOIN  mmaa_t ON mmaaent = " ||g_enterprise|| " AND mmaadocno = mmabdocno ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2049' AND t4.oocql002=mmab002 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='2016' AND t5.oocql002=mmab004 AND t5.oocql003='"||g_dlang||"' ",
 
                     " WHERE mmabent=? AND mmabdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmab_t.mmab002"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt500_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR ammt500_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_mmaa_m.mmaadocno   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_mmaa_m.mmaadocno INTO g_mmac4_d[l_ac].mmab001,g_mmac4_d[l_ac].mmab002, 
          g_mmac4_d[l_ac].mmab003,g_mmac4_d[l_ac].mmab004,g_mmac4_d[l_ac].mmab002_desc,g_mmac4_d[l_ac].mmab004_desc  
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
      
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_mmac4_d[l_ac].mmab002
      
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2049' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_mmac4_d[l_ac].mmab002_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_mmac4_d[l_ac].mmab002_desc
         CALL ammt500_display_mmab004()
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
   
   CALL g_mmac_d.deleteElement(g_mmac_d.getLength())
   CALL g_mmac2_d.deleteElement(g_mmac2_d.getLength())
   CALL g_mmac3_d.deleteElement(g_mmac3_d.getLength())
   CALL g_mmac4_d.deleteElement(g_mmac4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE ammt500_pb
   FREE ammt500_pb2
 
   FREE ammt500_pb3
 
   FREE ammt500_pb4
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mmac_d.getLength()
      LET g_mmac_d_mask_o[l_ac].* =  g_mmac_d[l_ac].*
      CALL ammt500_mmac_t_mask()
      LET g_mmac_d_mask_n[l_ac].* =  g_mmac_d[l_ac].*
   END FOR
   
   LET g_mmac2_d_mask_o.* =  g_mmac2_d.*
   FOR l_ac = 1 TO g_mmac2_d.getLength()
      LET g_mmac2_d_mask_o[l_ac].* =  g_mmac2_d[l_ac].*
      CALL ammt500_mmae_t_mask()
      LET g_mmac2_d_mask_n[l_ac].* =  g_mmac2_d[l_ac].*
   END FOR
   LET g_mmac3_d_mask_o.* =  g_mmac3_d.*
   FOR l_ac = 1 TO g_mmac3_d.getLength()
      LET g_mmac3_d_mask_o[l_ac].* =  g_mmac3_d[l_ac].*
      CALL ammt500_mmad_t_mask()
      LET g_mmac3_d_mask_n[l_ac].* =  g_mmac3_d[l_ac].*
   END FOR
   LET g_mmac4_d_mask_o.* =  g_mmac4_d.*
   FOR l_ac = 1 TO g_mmac4_d.getLength()
      LET g_mmac4_d_mask_o[l_ac].* =  g_mmac4_d[l_ac].*
      CALL ammt500_mmab_t_mask()
      LET g_mmac4_d_mask_n[l_ac].* =  g_mmac4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammt500_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM mmac_t
       WHERE mmacent = g_enterprise AND
         mmacdocno = ps_keys_bak[1] AND mmac002 = ps_keys_bak[2]
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
         CALL g_mmac_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM mmae_t
       WHERE mmaeent = g_enterprise AND
             mmaedocno = ps_keys_bak[1] AND mmae002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mmac2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM mmad_t
       WHERE mmadent = g_enterprise AND
             mmaddocno = ps_keys_bak[1] AND mmad002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmad_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_mmac3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM mmab_t
       WHERE mmabent = g_enterprise AND
             mmabdocno = ps_keys_bak[1] AND mmab002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_mmac4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammt500_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mmac_t
                  (mmacent,
                   mmacdocno,
                   mmac002
                   ,mmac001,mmac003,mmacacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmac_d[g_detail_idx].mmac001,g_mmac_d[g_detail_idx].mmac003,g_mmac_d[g_detail_idx].mmacacti) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mmac_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO mmae_t
                  (mmaeent,
                   mmaedocno,
                   mmae002
                   ,mmae001,mmaeacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmac2_d[g_detail_idx].mmae001,g_mmac2_d[g_detail_idx].mmaeacti)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mmac2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO mmad_t
                  (mmadent,
                   mmaddocno,
                   mmad002
                   ,mmad001,mmadacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmac3_d[g_detail_idx].mmad001,g_mmac3_d[g_detail_idx].mmadacti)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmad_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_mmac3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO mmab_t
                  (mmabent,
                   mmabdocno,
                   mmab002
                   ,mmab001,mmab003,mmab004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmac4_d[g_detail_idx].mmab001,g_mmac4_d[g_detail_idx].mmab003,g_mmac4_d[g_detail_idx].mmab004) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_mmac4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammt500_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmac_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL ammt500_mmac_t_mask_restore('restore_mask_o')
               
      UPDATE mmac_t 
         SET (mmacdocno,
              mmac002
              ,mmac001,mmac003,mmacacti) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmac_d[g_detail_idx].mmac001,g_mmac_d[g_detail_idx].mmac003,g_mmac_d[g_detail_idx].mmacacti)  
 
         WHERE mmacent = g_enterprise AND mmacdocno = ps_keys_bak[1] AND mmac002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmac_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmac_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt500_mmac_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmae_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL ammt500_mmae_t_mask_restore('restore_mask_o')
               
      UPDATE mmae_t 
         SET (mmaedocno,
              mmae002
              ,mmae001,mmaeacti) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmac2_d[g_detail_idx].mmae001,g_mmac2_d[g_detail_idx].mmaeacti) 
         WHERE mmaeent = g_enterprise AND mmaedocno = ps_keys_bak[1] AND mmae002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmae_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmae_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt500_mmae_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmad_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL ammt500_mmad_t_mask_restore('restore_mask_o')
               
      UPDATE mmad_t 
         SET (mmaddocno,
              mmad002
              ,mmad001,mmadacti) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmac3_d[g_detail_idx].mmad001,g_mmac3_d[g_detail_idx].mmadacti) 
         WHERE mmadent = g_enterprise AND mmaddocno = ps_keys_bak[1] AND mmad002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmad_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmad_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt500_mmad_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmab_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL ammt500_mmab_t_mask_restore('restore_mask_o')
               
      UPDATE mmab_t 
         SET (mmabdocno,
              mmab002
              ,mmab001,mmab003,mmab004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmac4_d[g_detail_idx].mmab001,g_mmac4_d[g_detail_idx].mmab003,g_mmac4_d[g_detail_idx].mmab004)  
 
         WHERE mmabent = g_enterprise AND mmabdocno = ps_keys_bak[1] AND mmab002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmab_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmab_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt500_mmab_t_mask_restore('restore_mask_n')
 
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
 
{<section id="ammt500.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION ammt500_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="ammt500.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION ammt500_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="ammt500.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammt500_lock_b(ps_table,ps_page)
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
   #CALL ammt500_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mmac_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN ammt500_bcl USING g_enterprise,
                                       g_mmaa_m.mmaadocno,g_mmac_d[g_detail_idx].mmac002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt500_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "mmae_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammt500_bcl2 USING g_enterprise,
                                             g_mmaa_m.mmaadocno,g_mmac2_d[g_detail_idx].mmae002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt500_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "mmad_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammt500_bcl3 USING g_enterprise,
                                             g_mmaa_m.mmaadocno,g_mmac3_d[g_detail_idx].mmad002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt500_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "mmab_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammt500_bcl4 USING g_enterprise,
                                             g_mmaa_m.mmaadocno,g_mmac4_d[g_detail_idx].mmab002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt500_bcl4:",SQLERRMESSAGE 
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
 
{<section id="ammt500.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammt500_unlock_b(ps_table,ps_page)
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
      CLOSE ammt500_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt500_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt500_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt500_bcl4
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION ammt500_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mmaadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mmaadocno",TRUE)
      CALL cl_set_comp_entry("mmaadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mmaadocdt,mmaasite",TRUE) #sakura add
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("mmaaacti",TRUE) 
   #CALL cl_set_comp_entry("mmaasite",TRUE) #sakura mark
   CALL cl_set_comp_entry("mmaa020",TRUE)  #add by geza 20151014
   CALL cl_set_comp_entry("mmaa054",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION ammt500_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mmaadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      #sakura---add---str
       IF p_cmd = 'u' THEN
         CALL cl_set_comp_entry("mmaasite,mmaadocdt,mmaadocno",FALSE)
      END IF   
      #sakura---add---end
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mmaadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mmaadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
  CALL cl_set_comp_entry("mmaaacti",FALSE)
  CALL cl_set_comp_entry("mmaa020",FALSE)  #add by geza 20151014

  #aooi500設定的欄位控卡
  #IF NOT s_aooi500_comp_entry(g_prog,'mmaasite') THEN #sakura mark
   IF NOT s_aooi500_comp_entry(g_prog,'mmaasite') OR g_site_flag THEN #sakura add
      CALL cl_set_comp_entry("mmaasite",FALSE)
   END IF
   IF g_mmaa_m.mmaa000='1' THEN
      CALL cl_set_comp_entry("mmaa020",FALSE)
   ELSE
      CALL cl_set_comp_entry("mmaa001",TRUE)
      CALL cl_set_comp_entry("mmaa020",TRUE)
   END IF
   CALL ammt500_set_entry_mmaa059(p_cmd)
   IF g_mmaa_m.mmaa056='Y' OR g_mmaa_m.mmaa055='Y' THEN
      CALL cl_set_comp_entry("mmaa054",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammt500_set_entry_b(p_cmd)
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
 
{<section id="ammt500.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammt500_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_oocq002 LIKE oocq_t.oocq002
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
 
{<section id="ammt500.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION ammt500_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION ammt500_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_mmaa_m.mmaastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION ammt500_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION ammt500_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammt500_default_search()
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
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " mmaadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "mmaa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmac_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmae_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "mmad_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "mmab_t" 
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt500.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION ammt500_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_mmaa_m.mmaastus = 'Y' OR g_mmaa_m.mmaastus = 'X' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mmaa_m.mmaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN ammt500_cl USING g_enterprise,g_mmaa_m.mmaadocno
   IF STATUS THEN
      CLOSE ammt500_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt500_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE ammt500_master_referesh USING g_mmaa_m.mmaadocno INTO g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt, 
       g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000,g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019, 
       g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus, 
       g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013, 
       g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027, 
       g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039, 
       g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041, 
       g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043, 
       g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060,g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062, 
       g_mmaa_m.mmaa044,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046, 
       g_mmaa_m.mmaa051,g_mmaa_m.mmaaownid,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaacrtid,g_mmaa_m.mmaacrtdp, 
       g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfdt, 
       g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa061_desc,g_mmaa_m.mmaa057_desc, 
       g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044_desc,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid_desc, 
       g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT ammt500_action_chk() THEN
      CLOSE ammt500_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmaa_m.mmaasite,g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaadocdt,g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000, 
       g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa056, 
       g_mmaa_m.mmaa052,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa061_desc, 
       g_mmaa_m.mmaa054,g_mmaa_m.mmaastus,g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003, 
       g_mmaa_m.mmaa015,g_mmaa_m.mmaa013,g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025, 
       g_mmaa_m.mmaa026,g_mmaa_m.mmaa027,g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029, 
       g_mmaa_m.mmaa034,g_mmaa_m.mmaa039,g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031, 
       g_mmaa_m.mmaa036,g_mmaa_m.mmaa041,g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033, 
       g_mmaa_m.mmaa038,g_mmaa_m.mmaa043,g_mmaa_m.mmaa057,g_mmaa_m.mmaa057_desc,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060, 
       g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062,g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044,g_mmaa_m.mmaa044_desc, 
       g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046,g_mmaa_m.mmaa051, 
       g_mmaa_m.mmaaownid,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid, 
       g_mmaa_m.mmaacrtid_desc,g_mmaa_m.mmaacrtdp,g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid, 
       g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfid_desc,g_mmaa_m.mmaacnfdt 
 
 
   CASE g_mmaa_m.mmaastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mmaa_m.mmaastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_mmaa_m.mmaastus  
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "X"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "confirmed"
            CALL s_transaction_end('N','0')   #160816-00068#5 add
            RETURN
         WHEN "Y"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "invalid"
            CALL s_transaction_end('N','0')   #160816-00068#5 add
            RETURN
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT ammt500_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt500_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT ammt500_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt500_cl
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
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
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
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "A"
      AND lc_state <> "X"
      ) OR 
      g_mmaa_m.mmaastus = lc_state OR cl_null(lc_state) THEN
      CLOSE ammt500_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y' 
         SELECT mmaastus INTO  g_mmaa_m.mmaastus FROM mmaa_t WHERE mmaadocno = g_mmaa_m.mmaadocno
            AND mmaaent = g_enterprise        
         CALL s_ammt500_conf_chk(g_mmaa_m.mmaadocno,g_mmaa_m.mmaastus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_ammt300_carry_upd(g_mmaa_m.mmaadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL cl_err_collect_init()   #161216-00004#5 161228 by lori add
                  CALL s_ammt500_conf_upd(g_mmaa_m.mmaadocno) RETURNING l_success
                  CALL cl_err_collect_show()   #161216-00004#5 161228 by lori add
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','1')
                  END IF
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#5 add
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmaa_m.mmaadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#5 add
            RETURN            
         END IF         
      WHEN 'X'
         SELECT mmaastus INTO  g_mmaa_m.mmaastus FROM mmaa_t WHERE mmaadocno = g_mmaa_m.mmaadocno
            AND mmaaent = g_enterprise
         CALL s_ammt500_void_chk(g_mmaa_m.mmaadocno,g_mmaa_m.mmaastus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_ammt500_void_upd(g_mmaa_m.mmaadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#5 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmaa_m.mmaadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#5 add
            RETURN    
         END IF
   END CASE
   #end add-point
   
   LET g_mmaa_m.mmaamodid = g_user
   LET g_mmaa_m.mmaamoddt = cl_get_current()
   LET g_mmaa_m.mmaastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mmaa_t 
      SET (mmaastus,mmaamodid,mmaamoddt) 
        = (g_mmaa_m.mmaastus,g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt)     
    WHERE mmaaent = g_enterprise AND mmaadocno = g_mmaa_m.mmaadocno
 
    
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
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE ammt500_master_referesh USING g_mmaa_m.mmaadocno INTO g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt, 
          g_mmaa_m.mmaadocno,g_mmaa_m.mmaa000,g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019, 
          g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus, 
          g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa014,g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013, 
          g_mmaa_m.mmaa004,g_mmaa_m.mmaa010,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027, 
          g_mmaa_m.mmaa028,g_mmaa_m.mmaa012,g_mmaa_m.mmaa011,g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039, 
          g_mmaa_m.mmaa030,g_mmaa_m.mmaa035,g_mmaa_m.mmaa040,g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041, 
          g_mmaa_m.mmaa032,g_mmaa_m.mmaa037,g_mmaa_m.mmaa042,g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043, 
          g_mmaa_m.mmaa057,g_mmaa_m.mmaa047,g_mmaa_m.mmaa060,g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062, 
          g_mmaa_m.mmaa044,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045,g_mmaa_m.mmaa050,g_mmaa_m.mmaa046, 
          g_mmaa_m.mmaa051,g_mmaa_m.mmaaownid,g_mmaa_m.mmaaowndp,g_mmaa_m.mmaacrtid,g_mmaa_m.mmaacrtdp, 
          g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid,g_mmaa_m.mmaamoddt,g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfdt, 
          g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaa019_desc,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa061_desc,g_mmaa_m.mmaa057_desc, 
          g_mmaa_m.mmaa062_desc,g_mmaa_m.mmaa044_desc,g_mmaa_m.mmaaownid_desc,g_mmaa_m.mmaaowndp_desc, 
          g_mmaa_m.mmaacrtid_desc,g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaacnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mmaa_m.mmaasite,g_mmaa_m.mmaasite_desc,g_mmaa_m.mmaadocdt,g_mmaa_m.mmaadocno, 
          g_mmaa_m.mmaa000,g_mmaa_m.mmaa001,g_mmaa_m.mmaa020,g_mmaa_m.mmaa002,g_mmaa_m.mmaa019,g_mmaa_m.mmaa019_desc, 
          g_mmaa_m.mmaa056,g_mmaa_m.mmaa052,g_mmaa_m.mmaa052_desc,g_mmaa_m.mmaa055,g_mmaa_m.mmaa061, 
          g_mmaa_m.mmaa061_desc,g_mmaa_m.mmaa054,g_mmaa_m.mmaastus,g_mmaa_m.mmaa008,g_mmaa_m.mmaa009, 
          g_mmaa_m.mmaa014,g_mmaa_m.mmaa003,g_mmaa_m.mmaa015,g_mmaa_m.mmaa013,g_mmaa_m.mmaa004,g_mmaa_m.mmaa010, 
          g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,g_mmaa_m.mmaa027,g_mmaa_m.mmaa028,g_mmaa_m.mmaa012, 
          g_mmaa_m.mmaa011,g_mmaa_m.mmaa029,g_mmaa_m.mmaa034,g_mmaa_m.mmaa039,g_mmaa_m.mmaa030,g_mmaa_m.mmaa035, 
          g_mmaa_m.mmaa040,g_mmaa_m.mmaa031,g_mmaa_m.mmaa036,g_mmaa_m.mmaa041,g_mmaa_m.mmaa032,g_mmaa_m.mmaa037, 
          g_mmaa_m.mmaa042,g_mmaa_m.mmaa033,g_mmaa_m.mmaa038,g_mmaa_m.mmaa043,g_mmaa_m.mmaa057,g_mmaa_m.mmaa057_desc, 
          g_mmaa_m.mmaa047,g_mmaa_m.mmaa060,g_mmaa_m.mmaa059,g_mmaa_m.mmaa048,g_mmaa_m.mmaa062,g_mmaa_m.mmaa062_desc, 
          g_mmaa_m.mmaa044,g_mmaa_m.mmaa044_desc,g_mmaa_m.mmaa049,g_mmaa_m.mmaa058,g_mmaa_m.mmaa045, 
          g_mmaa_m.mmaa050,g_mmaa_m.mmaa046,g_mmaa_m.mmaa051,g_mmaa_m.mmaaownid,g_mmaa_m.mmaaownid_desc, 
          g_mmaa_m.mmaaowndp,g_mmaa_m.mmaaowndp_desc,g_mmaa_m.mmaacrtid,g_mmaa_m.mmaacrtid_desc,g_mmaa_m.mmaacrtdp, 
          g_mmaa_m.mmaacrtdp_desc,g_mmaa_m.mmaacrtdt,g_mmaa_m.mmaamodid,g_mmaa_m.mmaamodid_desc,g_mmaa_m.mmaamoddt, 
          g_mmaa_m.mmaacnfid,g_mmaa_m.mmaacnfid_desc,g_mmaa_m.mmaacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE ammt500_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt500_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt500.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION ammt500_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmac_d.getLength() THEN
         LET g_detail_idx = g_mmac_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmac_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmac_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mmac2_d.getLength() THEN
         LET g_detail_idx = g_mmac2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmac2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmac2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_mmac3_d.getLength() THEN
         LET g_detail_idx = g_mmac3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmac3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmac3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_mmac4_d.getLength() THEN
         LET g_detail_idx = g_mmac4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmac4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmac4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ammt500_b_fill2(pi_idx)
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
   
   CALL ammt500_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION ammt500_fill_chk(ps_idx)
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
 
{<section id="ammt500.status_show" >}
PRIVATE FUNCTION ammt500_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammt500.mask_functions" >}
&include "erp/amm/ammt500_mask.4gl"
 
{</section>}
 
{<section id="ammt500.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION ammt500_send()
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
 
 
   CALL ammt500_show()
   CALL ammt500_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_ammt500_conf_chk(g_mmaa_m.mmaadocno,g_mmaa_m.mmaastus) RETURNING g_success,g_errno
   IF NOT g_success THEN
      CLOSE ammt500_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mmaa_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mmac_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_mmac2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_mmac3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_mmac4_d))
 
 
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
   #CALL ammt500_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL ammt500_ui_headershow()
   CALL ammt500_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION ammt500_draw_out()
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
   CALL ammt500_ui_headershow()  
   CALL ammt500_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="ammt500.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ammt500_set_pk_array()
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
   LET g_pk_array[1].values = g_mmaa_m.mmaadocno
   LET g_pk_array[1].column = 'mmaadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt500.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="ammt500.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION ammt500_msgcentre_notify(lc_state)
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
   CALL ammt500_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mmaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt500.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION ammt500_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#23 add-S
   SELECT mmaastus  INTO g_mmaa_m.mmaastus
     FROM mmaa_t
    WHERE mmaaent = g_enterprise
      AND mmaadocno = g_mmaa_m.mmaadocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mmaa_m.mmaastus
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
        LET g_errparam.extend = g_mmaa_m.mmaadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL ammt500_set_act_visible()
        CALL ammt500_set_act_no_visible()
        CALL ammt500_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#23 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt500.other_function" readonly="Y" >}
#+carry detail
PRIVATE FUNCTION ammt500_carry_detail()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_Sql        STRING
   DEFINE l_cnt        LIKE type_t.num5

   LET g_errno = ''
#   IF g_mmaa_m.mmaa000 = 'I' THEN
#      RETURN
#   END IF

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM mmab_t
    WHERE mmabent = g_enterprise
      AND mmabdocno = g_mmaa_m.mmaadocno
   IF l_cnt = 0 THEN
      LET l_sql = " INSERT INTO mmab_t( ",
                  "        mmab002,  mmab003 , mmab004 , ",
                  "        mmabacti , mmabdocno, mmabent ,mmab001)",
                  " SELECT mmag002 , mmag003, mmag004 ,  ",
                  "        mmagstus ,  '",g_mmaa_m.mmaadocno,"',mmagent,mmag001",
                  "   FROM mmag_t ",
                  "  WHERE mmagent = ",g_enterprise," AND mmag001 = '",g_mmaa_m.mmaa001,"'"
      PREPARE ins_mmab_pre FROM l_sql
      EXECUTE ins_mmab_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins mmab_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_errno = SQLCA.sqlcode
      END IF
   END IF

   IF NOT cl_null(g_errno) THEN
      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM mmac_t
    WHERE mmacent = g_enterprise
      AND mmacdocno = g_mmaa_m.mmaadocno
   IF l_cnt = 0 THEN
      LET l_sql = " INSERT INTO mmac_t( ",
                  "        mmac002,  mmac003 , mmac004 ,mmac005,mmac006, ",
                  "        mmacacti , mmacdocno, mmacent ,mmac001)",
                  " SELECT mmah002 , mmah003, mmah004 , mmah005,mmah006, ",
                  "        mmahstus ,  '",g_mmaa_m.mmaadocno,"',mmahent,mmah001",
                  "   FROM mmah_t ",
                  "  WHERE mmahent = ",g_enterprise," AND mmah001 = '",g_mmaa_m.mmaa001,"'"
      PREPARE ins_mmac_pre FROM l_sql
      EXECUTE ins_mmac_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins mmac_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_errno = SQLCA.sqlcode
      END IF
   END IF

   IF NOT cl_null(g_errno) THEN
      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM mmad_t
    WHERE mmadent = g_enterprise
      AND mmaddocno = g_mmaa_m.mmaadocno
      
   IF l_cnt = 0 THEN
      LET l_sql = " INSERT INTO mmad_t( ",
                  "        mmad002, ",
                  "        mmadacti , mmaddocno, mmadent ,mmad001)",
                  " SELECT mmai002 , ",
                  "        mmaistus ,  '",g_mmaa_m.mmaadocno,"',mmaient,mmai001",
                  "   FROM mmai_t ",
                  "  WHERE mmaient = ",g_enterprise," AND mmai001 = '",g_mmaa_m.mmaa001,"'"
      PREPARE ins_mmad_pre FROM l_sql
      EXECUTE ins_mmad_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins mmad_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_errno = SQLCA.sqlcode
      END IF
   END IF

   IF NOT cl_null(g_errno) THEN
      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM mmae_t
    WHERE mmaeent = g_enterprise
      AND mmaedocno = g_mmaa_m.mmaadocno
   IF l_cnt = 0 THEN
      LET l_sql = " INSERT INTO mmae_t( ",
                  "        mmae002,",
                  "        mmaeacti , mmaedocno, mmaeent,mmae001) ",
                  " SELECT mmaj002,",
                  "        mmajstus ,  '",g_mmaa_m.mmaadocno,"',mmajent,mmaj001",
                  "   FROM mmaj_t ",
                  "  WHERE mmajent = ",g_enterprise," AND mmaj001 = '",g_mmaa_m.mmaa001,"'"
      PREPARE ins_mmae_pre FROM l_sql
      EXECUTE ins_mmae_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins mmae_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_errno = SQLCA.sqlcode
      END IF
   END IF

   IF NOT cl_null(g_errno) THEN
      RETURN
   END IF
END FUNCTION
#+ display mmaa019
PRIVATE FUNCTION ammt500_display_mmaa019()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmaa_m.mmaa019
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_mmaa_m.mmaa019_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_mmaa_m.mmaa019_desc
END FUNCTION
#+ chk mmac002
PRIVATE FUNCTION ammt500_mmac002()
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5 
   LET g_errno = null
   SELECT COUNT(*) INTO l_cnt  FROM oocq_t WHERE oocq001='2050' AND oocq002 =g_mmac_d[l_ac].mmac002
      AND oocqent = g_enterprise
   IF l_cnt <= 0 THEN
      LET g_errno = "amm-00121"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM oocq_t WHERE oocq001='2050' AND oocq002 =g_mmac_d[l_ac].mmac002
         AND oocqent = g_enterprise 
         AND oocqstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno = "amm-00117"
      END IF         
   END IF
END FUNCTION
#+ chk mmac003
PRIVATE FUNCTION ammt500_mmac003(p_mmac003)
   DEFINE l_mmac004    LIKE mmac_t.mmac004
   DEFINE l_mmac005    LIKE mmac_t.mmac005
   DEFINE l_mmac006    LIKE mmac_t.mmac006
   DEFINE l_mmac003    STRING
   define p_mmac003    like mmac_t.mmac003
   LET l_mmac004 = NULL
   LET l_mmac005 = NULL
   LET l_mmac006 = NULL
   LET l_mmac003 = p_mmac003
   IF NOT cl_null(p_mmac003) THEN
      LET l_mmac004 = l_mmac003.substring(1,4)
      LET l_mmac005 = l_mmac003.substring(6,7)
      LET l_mmac006 = l_mmac003.substring(9,10)
   END IF
   RETURN l_mmac004,l_mmac005,l_mmac006
END FUNCTION
#+ chk
PRIVATE FUNCTION ammt500_newno(p_newno)
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5
   DEFINE   p_newno LIKE mmaa_t.mmaadocno   
   LET g_errno = null
   SELECT ooef004 INTO g_ooef004    FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   SELECT COUNT(*) INTO l_cnt  FROM ooba_t WHERE ooba001 = g_ooef004 AND ooba002=p_newno
      AND oobaent = g_enterprise       #160604-00009#159  by 08172
      AND ooba005 = 'ammt500'
   IF l_cnt <= 0 THEN
      LET g_errno = "aim-00056"
   ELSE
      SELECT COUNT(*) INTO l_cnt  FROM ooba_t WHERE ooba001 = g_ooef004 AND ooba002=p_newno
      AND ooba005 = 'ammt500' AND oobastus='Y'
      AND oobaent = g_enterprise       #160604-00009#159  by 08172
      IF l_cnt <= 0 THEN
         LET g_errno = "aoo-00102"
      END IF         
   END IF
END FUNCTION
#+ chk mmab004
PRIVATE FUNCTION ammt500_mmab004(p_c,p_mmab004)
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5 
   DEFINE   p_c     LIKE type_t.chr10
   DEFINE   p_mmab004  LIKE mmab_t.mmab004
   LET g_errno = null
   SELECT COUNT(*) INTO l_cnt  FROM oocq_t WHERE oocq001=p_c AND oocq002 =p_mmab004
      AND oocqent = g_enterprise
   IF l_cnt <= 0 THEN
      LET g_errno = "amm-00122"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM oocq_t WHERE oocq001=p_c AND oocq002 =p_mmab004
         AND oocqent = g_enterprise 
         AND oocqstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno = "amm-00118"
      END IF         
   END IF
END FUNCTION
#+ insert
PRIVATE FUNCTION ammt500_insert_mmab002()
   DEFINE l_sql    STRING
   DEFINE l_oocq002    LIKE oocq_t.oocq002
   DEFINE l_oocq004    LIKE oocq_t.oocq004
   DEFINE l_oocqstus   LIKE oocq_t.oocqstus
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_oocq005    LIKE oocq_t.oocq005
   
   LET l_success = TRUE
   DELETE FROM mmab_t WHERE mmabent = g_enterprise AND mmabdocno = g_mmaa_m.mmaadocno
   LET l_sql = "SELECT oocq002,oocq004,oocqstus FROM oocq_t WHERE oocq001 = '2049'  AND oocqstus='Y' AND oocqent = ",g_enterprise clipped,"  ORDER BY oocq001 "
   PREPARE l_sql_pre FROM l_sql
   DECLARE l_sql_sql_cur CURSOR FOR l_sql_pre
   FOREACH l_sql_sql_cur INTO l_oocq002,l_oocq004,l_oocqstus
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "l_sql_sql_cur"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET l_success = FALSE
         RETURN
      END IF
      CASE l_oocq004
         WHEN '2016' LET l_oocq005=g_mmaa_m.mmaa029
         WHEN '2017' LET l_oocq005=g_mmaa_m.mmaa030
         WHEN '2018' LET l_oocq005=g_mmaa_m.mmaa031
         WHEN '2019' LET l_oocq005=g_mmaa_m.mmaa032
         WHEN '2020' LET l_oocq005=g_mmaa_m.mmaa033
         WHEN '2021' LET l_oocq005=g_mmaa_m.mmaa034
         WHEN '2022' LET l_oocq005=g_mmaa_m.mmaa035
         WHEN '2023' LET l_oocq005=g_mmaa_m.mmaa036
         WHEN '2024' LET l_oocq005=g_mmaa_m.mmaa038
         WHEN '2025' LET l_oocq005=g_mmaa_m.mmaa037
         WHEN '2026' LET l_oocq005=g_mmaa_m.mmaa039
         WHEN '2027' LET l_oocq005=g_mmaa_m.mmaa040
         WHEN '2028' LET l_oocq005=g_mmaa_m.mmaa041
         WHEN '2029' LET l_oocq005=g_mmaa_m.mmaa042
         WHEN '2030' LET l_oocq005=g_mmaa_m.mmaa043
         
      END CASE
      INSERT INTO mmab_t(mmabent,mmabdocno,mmab001,mmab002,mmab003,mmab004,mmabacti)
       VALUES (g_enterprise,g_mmaa_m.mmaadocno,g_mmaa_m.mmaa001,l_oocq002,l_oocq004,l_oocq005,l_oocqstus)
#      INSERT INTO mmab_t(mmabent,mmabdocno,mmab001,mmab002,mmab003) VALUES (g_enterprise,g_mmaa_m.mmaadocno,g_mmaa_m.mmaa001,l_oocq002,l_oocq004)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmab_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_success = FALSE
         RETURN   
      END IF      
   END FOREACH
   #add by geza 20150818(S)
   #插入会员等级的时候插入一笔会员等级序号最小的一笔会员等级
   IF g_mmaa_m.mmaa000 = '1' THEN
      UPDATE mmab_t 
      SET mmab004 = (SELECT oocq002 
                       FROM oocq_t 
                      WHERE oocq001 = '2024' 
                        AND oocqstus= 'Y' 
                        AND oocqent = g_enterprise
                        AND rownum =1
                        AND oocq009 = (SELECT MIN(oocq009) 
                                         FROM oocq_t 
                                        WHERE oocq001 = '2024' 
                                          AND oocqstus= 'Y' 
                                          AND oocqent = g_enterprise))
       WHERE mmabent = g_enterprise
         AND mmabdocno = g_mmaa_m.mmaadocno
         AND mmab003 = '2024'
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "update mmab_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()  
         LET l_success = FALSE
         RETURN l_success
      END IF
   END IF
   #add by geza 20150818(E)
   RETURN l_success
END FUNCTION
#+ chk mmaa001
PRIVATE FUNCTION ammt500_mmaa001()
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5 

   LET g_errno = null
   LET l_cnt1 = 0
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt  FROM mmaa_t WHERE mmaa001 =g_mmaa_m.mmaa001 AND mmaaent = g_enterprise
      AND mmaastus = 'N' AND mmaadocno ! = g_mmaa_m.mmaadocno
   IF l_cnt > 0 THEN
      LET g_errno = "amm-00020"
   END IF
   IF g_mmaa_m.mmaa000 = '2' OR g_mmaa_m.mmaa000 = '3' THEN
      
      SELECT COUNT(*) INTO l_cnt1  FROM mmaf_t WHERE mmaf001 =g_mmaa_m.mmaa001 AND mmafent = g_enterprise
    #   AND mmafstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno = "amm-00021"
      END IF         
   END IF
   LET l_cnt1 = 0
   IF g_mmaa_m.mmaa000 = '1' THEN
      
      SELECT COUNT(*) INTO l_cnt1  FROM mmaf_t WHERE mmaf001 =g_mmaa_m.mmaa001 AND mmafent = g_enterprise
    #    AND mmafstus='Y'
      IF l_cnt1 > 0 THEN
         LET g_errno = "amm-00025"
      END IF         
   END IF
   
   
END FUNCTION
#+ create
PRIVATE FUNCTION ammt500_mmaa002()
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_mmafstus    like mmaf_t.mmafstus
   SELECT MAX(mmaa002)+1  INTO g_mmaa_m.mmaa002 FROM mmaa_t WHERE mmaa001 = g_mmaa_m.mmaa001 AND mmaaent = g_enterprise
  #IF cl_null(g_mmaa_m.mmaa002) OR g_mmaa_m.mmaa002=0 THEN #sakur mark
  #   LET g_mmaa_m.mmaa002= 1                              #sakur mark
   IF cl_null(g_mmaa_m.mmaa002) THEN #sakura add
      LET g_mmaa_m.mmaa002= 1        #sakura add
   END IF
   LET g_mmaa_m.mmaa002 = g_mmaa_m.mmaa002 USING "<<<<<<<<<&"
   
   DISPLAY BY NAME g_mmaa_m.mmaa002
END FUNCTION
#+display mmae002
PRIVATE FUNCTION ammt500_display_mmae002()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmac2_d[l_ac].mmae002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2057' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmac2_d[l_ac].mmae002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmac2_d[l_ac].mmae002_desc
END FUNCTION
#+display mmab004
PRIVATE FUNCTION ammt500_display_mmab004()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmac4_d[l_ac].mmab003
   LET g_ref_fields[2] = g_mmac4_d[l_ac].mmab004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmac4_d[l_ac].mmab004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmac4_d[l_ac].mmab004_desc
END FUNCTION
#+ display mmac002
PRIVATE FUNCTION ammt500_display_mmac002()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmac_d[l_ac].mmac002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2050' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmac_d[l_ac].mmac002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmac_d[l_ac].mmac002_desc
END FUNCTION
#+ display mmad002
PRIVATE FUNCTION ammt500_display_mmad002()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmac3_d[l_ac].mmad002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2051' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmac3_d[l_ac].mmad002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmac3_d[l_ac].mmad002_desc
END FUNCTION
#+ chk mmaadocno
PRIVATE FUNCTION ammt500_mmaadocno()
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5 
   LET g_errno = null
   SELECT ooef004 INTO g_ooef004    FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   SELECT COUNT(*) INTO l_cnt  FROM oobl_t WHERE oobl001 = g_ooef004 AND oobl002=g_mmaa_m.mmaadocno
      AND oobl003 = 'ammt500'
      AND ooblent = g_enterprise       #160604-00009#159  by 08172
   IF l_cnt <= 0 THEN
      LET g_errno = "aim-00056"
   ELSE
      SELECT COUNT(*) INTO l_cnt  FROM ooba_t,oobl_t
       WHERE ooba001=oobl001 AND ooba002 = oobl002 AND ooba001 = g_ooef004 AND ooba002=g_mmaa_m.mmaadocno
         AND oobl003 = 'ammt500' AND oobastus='Y'
         AND oobaent =  ooblent AND oobaent = g_enterprise       #160604-00009#159  by 08172
      IF l_cnt <= 0 THEN
         LET g_errno = "aoo-00102"
      END IF         
   END IF 
END FUNCTION
#+ chk mmaa003
PRIVATE FUNCTION ammt500_mmaa003()
   #mark by geza 20151103(S) #证件号码可以为空
   LET g_errno =null
   IF g_mmaa_m.mmaa003 ='1' or  g_mmaa_m.mmaa003 ='2' THEN
      IF cl_null(g_mmaa_m.mmaa004)  THEN
         LET g_errno = "aoo-00052"
      END IF
   END IF
   #mark by geza 20151103(E)
END FUNCTION
#chk mmad002
PRIVATE FUNCTION ammt500_mmad002(p_c,p_mmad002)
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5 
   DEFINE   p_c     LIKE type_t.chr10
   DEFINE   p_mmad002  LIKE mmad_t.mmad002
   LET g_errno = null
   SELECT COUNT(*) INTO l_cnt  FROM oocq_t WHERE oocq001=p_c AND oocq002 =p_mmad002
      AND oocqent = g_enterprise
   IF l_cnt <= 0 THEN
      LET g_errno = "amm-00119"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM oocq_t WHERE oocq001=p_c AND oocq002 =p_mmad002
         AND oocqent = g_enterprise 
         AND oocqstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno = "amm-00115"
      END IF         
   END IF
END FUNCTION
#chk mmae002
PRIVATE FUNCTION ammt500_mmae002(p_c,p_mmae002)
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5 
   DEFINE   p_c     LIKE type_t.chr10
   DEFINE   p_mmae002  LIKE mmae_t.mmae002
   LET g_errno = null
   SELECT COUNT(*) INTO l_cnt  FROM oocq_t WHERE oocq001=p_c AND oocq002 =p_mmae002
      AND oocqent = g_enterprise
   IF l_cnt <= 0 THEN
      LET g_errno = "amm-00120"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM oocq_t WHERE oocq001=p_c AND oocq002 =p_mmae002
         AND oocqent = g_enterprise 
         AND oocqstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno = "amm-00116"
      END IF         
   END IF
END FUNCTION
#insert birthday
PRIVATE FUNCTION ammt500_insert_mmac002()
   DEFINE l_sql    STRING
   DEFINE l_oocq002    LIKE mmac_t.mmac002
   DEFINE l_oocq004    LIKE oocq_t.oocq004
   DEFINE l_mmac004    LIKE mmac_t.mmac004
   DEFINE l_mmac005    LIKE mmac_t.mmac005
   DEFINE l_mmac006    LIKE mmac_t.mmac006
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_n          LIKE type_t.num5   #160128-00001#8 add by yangxf  20160219 
   
   LET l_success = TRUE
   SELECT ooaa002 INTO l_oocq002 FROM ooaa_t WHERE ooaa001 = 'E-CIR-0004' AND ooaaent=g_enterprise
   CALL ammt500_mmac003(g_mmaa_m.mmaa015) RETURNING l_mmac004,l_mmac005,l_mmac006
   #160128-00001#8 add by yangxf  20160219 start
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM mmac_t
    WHERE mmacent = g_enterprise
      AND mmacdocno = g_mmaa_m.mmaadocno
      AND mmac002 = l_oocq002        
   IF l_n > 0 THEN 
      RETURN TRUE
   END IF 
   #160128-00001#8 add by yangxf  20160219 end
   INSERT INTO mmac_t(mmacent,mmacdocno,mmac001,mmac002,mmac003,mmac004,mmac005,mmac006,mmacacti)
   VALUES (g_enterprise,g_mmaa_m.mmaadocno,g_mmaa_m.mmaa001,l_oocq002,g_mmaa_m.mmaa015,l_mmac004,l_mmac005,l_mmac006,'Y')

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "mmac_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_success = FALSE
      RETURN l_success
   ELSE
         
   END IF
   RETURN l_success   
END FUNCTION
#delete mmaa001
PRIVATE FUNCTION ammt500_delete_mmaa001()
   DEFINE l_success  LIKE type_t.num5
   LET g_errno = NULL
   LET l_success = TRUE
   DELETE FROM mmac_t WHERE mmacdocno = g_mmaa_m.mmaadocno AND mmacent = g_enterprise
   IF SQLCA.sqlcode THEN
      LET g_errno = SQLCA.sqlcode
      LET l_success = FALSE
      RETURN l_success
   END IF
   call g_mmac_d.clear()
   DELETE FROM mmab_t WHERE mmabdocno = g_mmaa_m.mmaadocno AND mmabent = g_enterprise
   IF SQLCA.sqlcode THEN
      LET g_errno = SQLCA.sqlcode
      LET l_success = FALSE
      RETURN l_success
   END IF
   call g_mmac4_d.clear()
   DELETE FROM mmad_t WHERE mmaddocno = g_mmaa_m.mmaadocno AND mmadent = g_enterprise
   IF SQLCA.sqlcode THEN
      LET g_errno = SQLCA.sqlcode
      LET l_success = FALSE
      RETURN l_success
   END IF
   call g_mmac3_d.clear()
   DELETE FROM mmae_t WHERE mmaedocno = g_mmaa_m.mmaadocno AND mmaeent = g_enterprise
   IF SQLCA.sqlcode THEN
      LET g_errno = SQLCA.sqlcode
      LET l_success = FALSE
      RETURN l_success
   END IF
   call g_mmac2_d.clear()   
   RETURN l_success   
END FUNCTION
#update mmaa015
PRIVATE FUNCTION ammt500_update_mmaa015()
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_oocq002    LIKE oocq_t.oocq002
   
   LET l_success = TRUE
   LET g_errno = NULL
   SELECT ooaa002 INTO l_oocq002 FROM ooaa_t WHERE ooaa001 = 'E-CIR-0004' AND ooaaent=g_enterprise
   
   IF g_mmac_d[l_ac].mmac002 = l_oocq002 THEN
      UPDATE mmaa_t SET mmaa015 =  g_mmac_d[l_ac].mmac003
       WHERE mmaaent = g_enterprise AND mmaadocno = g_mmaa_m.mmaadocno       
                        
      IF SQLCA.sqlcode THEN
         LET g_errno = SQLCA.sqlcode
      ELSE
         let g_mmaa_m.mmaa015 = g_mmac_d[l_ac].mmac003
      END IF
   END IF
   DISPLAY BY NAME g_mmaa_m.mmaa015
END FUNCTION
#update mmac002
PRIVATE FUNCTION ammt500_update_mmac002()
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_mmac004    LIKE mmac_t.mmac004
   DEFINE l_mmac005    LIKE mmac_t.mmac005
   DEFINE l_mmac006    LIKE mmac_t.mmac006
   define l_oocq002    like oocq_t.oocq002
   
   let g_errno = null
   SELECT ooaa002 INTO l_oocq002 FROM ooaa_t WHERE ooaa001 = 'E-CIR-0004' AND ooaaent=g_enterprise
   CALL ammt500_mmac003(g_mmaa_m.mmaa015) RETURNING l_mmac004,l_mmac005,l_mmac006
   UPDATE mmac_t SET mmac003 =  g_mmaa_m.mmaa015,
                     mmac004 = l_mmac004,
                     mmac005 = l_mmac005,
                     mmac006 = l_mmac006
    WHERE mmacent = g_enterprise AND mmacdocno = g_mmaa_m.mmaadocno
      AND mmac002 = l_oocq002        
                        
   IF SQLCA.sqlcode THEN
      let g_errno = SQLCA.sqlcode
   ELSE
         
   END IF
END FUNCTION
#update mmaa001
PRIVATE FUNCTION ammt500_update_mmaa001()
   DEFINE l_true          LIKE type_t.num5

   LET l_true = TRUE
   CALL s_transaction_begin()
   INPUT BY NAME g_mmaa_m.mmaa001  ATTRIBUTE(WITHOUT DEFAULTS)
   
      AFTER FIELD mmaa001
         IF NOT cl_null(g_mmaa_m.mmaa001) THEN
            IF g_mmaa_m.mmaa001 <> g_mmaa_m_t.mmaa001 OR cl_null(g_mmaa_m_t.mmaa001) THEN
               CALL ammt500_mmaa001()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmaa_m.mmaa001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mmaa_m.mmaa001 = g_mmaa_m_t.mmaa001
                  NEXT FIELD mmaa001
               END IF
            END IF
         END IF
            
      AFTER INPUT 
        UPDATE mmaa_t 
           SET mmaa001 = g_mmaa_m.mmaa001
         WHERE mmaaent = g_enterprise 
           AND mmaadocno = g_mmaa_m.mmaadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_mmaa"
           LET g_errparam.popup = TRUE
           CALL cl_err()
  
           LET l_true = FALSE
        END IF
        UPDATE mmab_t 
           SET mmab001 = g_mmaa_m.mmaa001
         WHERE mmabent = g_enterprise 
           AND mmabdocno = g_mmaa_m.mmaadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_mmab"
           LET g_errparam.popup = TRUE
           CALL cl_err()
  
           LET l_true = FALSE
        END IF           
        UPDATE mmac_t 
           SET mmac001 = g_mmaa_m.mmaa001
         WHERE mmacent = g_enterprise 
           AND mmacdocno = g_mmaa_m.mmaadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_mmac"
           LET g_errparam.popup = TRUE
           CALL cl_err()
  
           LET l_true = FALSE
        END IF        
        UPDATE mmad_t 
           SET mmad001 = g_mmaa_m.mmaa001
         WHERE mmadent = g_enterprise 
           AND mmaddocno = g_mmaa_m.mmaadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_mmad"
           LET g_errparam.popup = TRUE
           CALL cl_err()
  
           LET l_true = FALSE
        END IF 
        UPDATE mmae_t 
           SET mmae001 = g_mmaa_m.mmaa001
         WHERE mmaeent = g_enterprise 
           AND mmaedocno = g_mmaa_m.mmaadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_mmae"
           LET g_errparam.popup = TRUE
           CALL cl_err()
  
           LET l_true = FALSE
        END IF
        
        IF NOT l_true THEN        
           CALL s_transaction_end('N','0')
        ELSE
           CALL s_transaction_end('Y','0')
        END IF        
        EXIT INPUT
   END INPUT
END FUNCTION

################################################################################
#display mmaasite
################################################################################
PRIVATE FUNCTION ammt500_display_mmaasite()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmaa_m.mmaasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmaa_m.mmaasite_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_mmaa_m.mmaasite_desc
END FUNCTION

################################################################################
# Descriptions...: 发卡人员检查
# Date & Author..: 2016/06/15 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt500_mmaa019_chk()
   DEFINE l_ooag003   LIKE ooag_t.ooag003
   DEFINE l_ooagstus  LIKE ooag_t.ooagstus

   LET g_errno = ''
   SELECT ooag003,ooagstus INTO l_ooag003,l_ooagstus
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_mmaa_m.mmaa019
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aim-00069'
      WHEN l_ooagstus <> 'Y'   LET g_errno = 'ais-00018'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      LET g_mmaa_m.mmaa052 = l_ooag003
      CALL ammt500_display_mmaa052()
   ELSE
      LET g_mmaa_m.mmaa052 = ''  
      LET g_mmaa_m.mmaa052_desc = ''
   END IF
   DISPLAY BY NAME g_mmaa_m.mmaa052,g_mmaa_m.mmaa052_desc
END FUNCTION

################################################################################
# Descriptions...: 发卡部门说明
################################################################################
PRIVATE FUNCTION ammt500_display_mmaa052()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmaa_m.mmaa052
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmaa_m.mmaa052_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmaa_m.mmaa052_desc
END FUNCTION

################################################################################
# Descriptions...: 发卡部门检查
# Date & Author..: 2016/06/15 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt500_mmaa052_chk()
   DEFINE l_ooegstus  LIKE ooag_t.ooagstus
   DEFINE l_n         LIKE type_t.num5
   LET g_errno = ''
   SELECT ooegstus INTO l_ooegstus
     FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = g_mmaa_m.mmaa052
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00352'
      WHEN l_ooegstus <> 'Y'   LET g_errno = 'art-00353'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      IF NOT cl_null(g_mmaa_m.mmaa019) THEN
         LET l_n = 0      
         SELECT COUNT(*) INTO l_n
           FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = g_mmaa_m.mmaa019 
            AND ooag003 = g_mmaa_m.mmaa052
         IF l_n = 0 THEN 
            LET g_errno = 'art-00224'
         END IF 
      END IF 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 卡号生效范围检查
# Memo...........:
# Usage..........: ammt500_card(p_card）
# Input parameter: p_card      发卡卡号
# Date & Author..: 2016/06/15 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt500_card(p_card)
   DEFINE l_sql   STRING 
   DEFINE p_card  LIKE mmaq_t.mmaq001
   DEFINE r_no    LIKE type_t.num5
   LET r_no = 0
   LET l_sql = " SELECT COUNT(*) ", 
               "   FROM mmaq_t ",
               "  WHERE mmaqent = '",g_enterprise,"'",
               "    AND mmaq001 = '",p_card,"'",
               "    AND mmaq002 IN (SELECT mmap002 FROM mmap_t WHERE mmapent = '",g_enterprise,"' AND mmap001 = 'ammm320' ",
               "             AND (mmap003 = '",g_mmaa_m.mmaasite,"' OR (mmap003 IN(SELECT ooed005 FROM ooed_t ",
               "    START WITH ooed004= '",g_mmaa_m.mmaasite,"' AND ooed001 = '8' AND ooedent = '",g_enterprise,"' ",
               "      AND ooed006 <='",g_today,"' ",
               "      AND (ooed007 >='",g_today,"' OR ooed007 IS NULL)",
               "  CONNECT BY  NOCYCLE PRIOR ooed005=ooed004 ",
               "      AND ooed001='8' AND ooedent = '",g_enterprise,"'",
               "      AND ooed006 <='",g_today,"' ",
               "      AND (ooed007 >='",g_today,"' OR ooed007 IS NULL)) AND mmap005 = 'Y')) AND mmapstus = 'Y')"
   PREPARE sel_num FROM l_sql
   EXECUTE sel_num INTO r_no
   RETURN r_no
END FUNCTION

################################################################################
# Descriptions...: 会员属性下拉框显示
# Memo...........:
# Usage..........: ammt500_vip_acc(p_field,p_oocq001)
#                  RETURNING r_str
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt500_vip_acc(p_field,p_oocq001)
   DEFINE p_field     LIKE type_t.chr20              #栏位名称
   DEFINE p_oocq001   LIKE oocq_t.oocq001            #应用分类
   DEFINE l_oocq002   LIKE oocq_t.oocq002            #应用分类码
   DEFINE l_oocql004  LIKE oocql_t.oocql004          #说明
   DEFINE l_sql       STRING
   DEFINE cb004          ui.ComboBox
   
   IF cl_null(p_field) OR cl_null(p_oocq001) THEN
      RETURN
   END IF
   LET cb004 = ui.ComboBox.forName(p_field)
   CALL cb004.clear()
   LET l_sql=" SELECT oocq002,oocql004",
               " FROM oocq_t",
               " LEFT JOIN oocql_t ON oocqlent=oocqent AND oocql001=oocq001 AND oocql002=oocq002",
                " AND oocql003='",g_dlang,"'",
              " WHERE oocqent='",g_enterprise,"'",
                " AND oocq001='",p_oocq001,"'",
                " AND oocqstus='Y'"
   PREPARE ammt500_vip_acc_pre FROM l_sql
   DECLARE ammt500_vip_acc_cur CURSOR FOR ammt500_vip_acc_pre
   FOREACH ammt500_vip_acc_cur INTO l_oocq002,l_oocql004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt500_vip_acc_cur:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_oocql004=l_oocq002,'.',l_oocql004
      IF cl_null(l_oocql004) THEN
         CALL cb004.addItem(l_oocq002,l_oocq002)
      ELSE
         CALL cb004.addItem(l_oocq002,l_oocql004)
      END IF
   END FOREACH
END FUNCTION

################################################################################
#根据会员编号带出会员相关信息
################################################################################
PRIVATE FUNCTION ammt500_carry_mmaa()
 # DEFINE  l_mmaf   RECORD LIKE mmaf_t.*  #161111-00028#1--mark
  #161111-00028#1----add----begin--------------
   DEFINE l_mmaf RECORD  #會員基本資料檔-主檔
       mmafent LIKE mmaf_t.mmafent, #企業編號
       mmafunit LIKE mmaf_t.mmafunit, #應用組織
       mmaf001 LIKE mmaf_t.mmaf001, #會員編號
       mmaf002 LIKE mmaf_t.mmaf002, #最新版本
       mmaf003 LIKE mmaf_t.mmaf003, #證件種類
       mmaf004 LIKE mmaf_t.mmaf004, #證件號碼
       mmaf005 LIKE mmaf_t.mmaf005, #會員姓名-姓氏
       mmaf006 LIKE mmaf_t.mmaf006, #會員姓名-中間名
       mmaf007 LIKE mmaf_t.mmaf007, #會員姓名-名字
       mmaf008 LIKE mmaf_t.mmaf008, #會員姓名
       mmaf009 LIKE mmaf_t.mmaf009, #會員暱稱
       mmaf010 LIKE mmaf_t.mmaf010, #會員郵遞區號
       mmaf011 LIKE mmaf_t.mmaf011, #會員地址
       mmaf012 LIKE mmaf_t.mmaf012, #會員E-mail
       mmaf013 LIKE mmaf_t.mmaf013, #會員電話號碼
       mmaf014 LIKE mmaf_t.mmaf014, #會員手機號碼
       mmaf015 LIKE mmaf_t.mmaf015, #會員出生日期
       mmaf016 LIKE mmaf_t.mmaf016, #大宗客戶編號
       mmaf017 LIKE mmaf_t.mmaf017, #員購員工編號
       mmaf018 LIKE mmaf_t.mmaf018, #no use
       mmaf019 LIKE mmaf_t.mmaf019, #申請人員
       mmaf020 LIKE mmaf_t.mmaf020, #會員價值
       mmaf021 LIKE mmaf_t.mmaf021, #會員生命週期
       mmaf022 LIKE mmaf_t.mmaf022, #ABC分類
       mmafstus LIKE mmaf_t.mmafstus, #狀態碼
       mmafownid LIKE mmaf_t.mmafownid, #資料所有者
       mmafowndp LIKE mmaf_t.mmafowndp, #資料所屬部門
       mmafcrtid LIKE mmaf_t.mmafcrtid, #資料建立者
       mmafcrtdp LIKE mmaf_t.mmafcrtdp, #資料建立部門
       mmafcrtdt LIKE mmaf_t.mmafcrtdt, #資料創建日
       mmafmodid LIKE mmaf_t.mmafmodid, #資料修改者
       mmafmoddt LIKE mmaf_t.mmafmoddt, #最近修改日
       mmafcnfid LIKE mmaf_t.mmafcnfid, #資料確認者
       mmafcnfdt LIKE mmaf_t.mmafcnfdt, #資料確認日
       mmaf023 LIKE mmaf_t.mmaf023, #電子發票中獎通知方式
       mmaf024 LIKE mmaf_t.mmaf024, #國家地區編號
       mmaf025 LIKE mmaf_t.mmaf025, #州省編號
       mmaf026 LIKE mmaf_t.mmaf026, #縣市編號
       mmaf027 LIKE mmaf_t.mmaf027, #行政地區編號
       mmaf028 LIKE mmaf_t.mmaf028  #街道編號
       END RECORD
   #161111-00028#1----add----end--------------
   DEFINE  l_mmag004    LIKE mmag_t.mmag004
   DEFINE  l_oocql004   LIKE oocql_t.oocql004
   DEFINE  l_mmaastus   LIKE mmaa_t.mmaastus
   DEFINE  l_n          LIKE type_t.num5
   DEFINE  l_sql        STRING
   DEFINE l_nat_d DYNAMIC ARRAY OF RECORD
      mmag004  LIKE mmag_t.mmag004
   END RECORD
   
   LET l_n=0
   INITIALIZE l_mmaf.* TO NULL
  # SELECT * INTO l_mmaf.*    #161111-00028#1--mark  
  #161111-00028#1----add------begin----------
    SELECT mmafent,mmafunit,mmaf001,mmaf002,mmaf003,mmaf004,mmaf005,mmaf006,mmaf007,mmaf008,mmaf009,mmaf010,mmaf011,
           mmaf012,mmaf013,mmaf014,mmaf015,mmaf016,mmaf017,mmaf018,mmaf019,mmaf020,mmaf021,mmaf022,mmafstus,mmafownid,
           mmafowndp,mmafcrtid,mmafcrtdp,mmafcrtdt,mmafmodid,mmafmoddt,mmafcnfid,mmafcnfdt,mmaf023,mmaf024,mmaf025,mmaf026,
           mmaf027,mmaf028 
      INTO l_mmaf.mmafent,l_mmaf.mmafunit,l_mmaf.mmaf001,l_mmaf.mmaf002,l_mmaf.mmaf003,l_mmaf.mmaf004,l_mmaf.mmaf005,
           l_mmaf.mmaf006,l_mmaf.mmaf007,l_mmaf.mmaf008,l_mmaf.mmaf009,l_mmaf.mmaf010,l_mmaf.mmaf011,l_mmaf.mmaf012,
           l_mmaf.mmaf013,l_mmaf.mmaf014,l_mmaf.mmaf015,l_mmaf.mmaf016,l_mmaf.mmaf017,l_mmaf.mmaf018,l_mmaf.mmaf019,
           l_mmaf.mmaf020,l_mmaf.mmaf021,l_mmaf.mmaf022,l_mmaf.mmafstus,l_mmaf.mmafownid,l_mmaf.mmafowndp,l_mmaf.mmafcrtid,
           l_mmaf.mmafcrtdp,l_mmaf.mmafcrtdt,l_mmaf.mmafmodid,l_mmaf.mmafmoddt,l_mmaf.mmafcnfid,l_mmaf.mmafcnfdt,
           l_mmaf.mmaf023,l_mmaf.mmaf024,l_mmaf.mmaf025,l_mmaf.mmaf026,l_mmaf.mmaf027,l_mmaf.mmaf028
  #161111-00028#1----add------end------------
   FROM mmaf_t WHERE mmafent = g_enterprise
      AND mmaf001 = g_mmaa_m.mmaa001
   LET l_sql=" SELECT mmag004 FROM mmag_t",
              " WHERE mmagent='",g_enterprise,"'",
                " AND mmag001='",g_mmaa_m.mmaa001,"'",
           " ORDER BY mmag003"
   PREPARE ammt500_carry_mmaa_pre FROM l_sql
   DECLARE ammt500_carry_mmaa_cur CURSOR FOR ammt500_carry_mmaa_pre
   FOREACH ammt500_carry_mmaa_cur INTO l_mmag004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt500_carry_mmaa_cur:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_n=l_n+1
      LET l_nat_d[l_n].mmag004=l_mmag004
   END FOREACH      
   LET g_mmaa_m.mmaa003 = l_mmaf.mmaf003
   LET g_mmaa_m.mmaa004 = l_mmaf.mmaf004
   LET g_mmaa_m.mmaa008 = l_mmaf.mmaf008
   LET g_mmaa_m.mmaa009 = l_mmaf.mmaf009
   LET g_mmaa_m.mmaa010 = l_mmaf.mmaf010
   LET g_mmaa_m.mmaa011 = l_mmaf.mmaf011
   LET g_mmaa_m.mmaa012 = l_mmaf.mmaf012
   LET g_mmaa_m.mmaa013 = l_mmaf.mmaf013
   LET g_mmaa_m.mmaa014 = l_mmaf.mmaf014
   LET g_mmaa_m.mmaa015 = l_mmaf.mmaf015
   LET g_mmaa_m.mmaa024 = l_mmaf.mmaf024  
   LET g_mmaa_m.mmaa025 = l_mmaf.mmaf025
   LET g_mmaa_m.mmaa026 = l_mmaf.mmaf026
   LET g_mmaa_m.mmaa027 = l_mmaf.mmaf027
   LET g_mmaa_m.mmaa028 = l_mmaf.mmaf028
   LET g_mmaa_m.mmaa029 = l_nat_d[1].mmag004
   LET g_mmaa_m.mmaa030 = l_nat_d[2].mmag004
   LET g_mmaa_m.mmaa031 = l_nat_d[3].mmag004
   LET g_mmaa_m.mmaa032 = l_nat_d[4].mmag004   
   LET g_mmaa_m.mmaa033 = l_nat_d[5].mmag004
   LET g_mmaa_m.mmaa034 = l_nat_d[6].mmag004
   LET g_mmaa_m.mmaa035 = l_nat_d[7].mmag004
   LET g_mmaa_m.mmaa036 = l_nat_d[8].mmag004
   LET g_mmaa_m.mmaa038 = l_nat_d[9].mmag004
   LET g_mmaa_m.mmaa037 = l_nat_d[10].mmag004
   LET g_mmaa_m.mmaa039 = l_nat_d[11].mmag004
   LET g_mmaa_m.mmaa040 = l_nat_d[12].mmag004
   LET g_mmaa_m.mmaa041 = l_nat_d[13].mmag004
   LET g_mmaa_m.mmaa042 = l_nat_d[14].mmag004
   LET g_mmaa_m.mmaa043 = l_nat_d[15].mmag004
#   LET l_mmaastus = l_mmaf.mmafstus
#   IF l_mmaastus = 'X' THEN
#      LET g_mmaa_m.mmaaacti= 'N'
#   ELSE
#      LET g_mmaa_m.mmaaacti= 'Y'       
#   END IF    
   DISPLAY BY NAME   g_mmaa_m.mmaa003,g_mmaa_m.mmaa004,g_mmaa_m.mmaa008,g_mmaa_m.mmaa009,g_mmaa_m.mmaa010,g_mmaa_m.mmaa011,
   g_mmaa_m.mmaa012,g_mmaa_m.mmaa013,g_mmaa_m.mmaa014,g_mmaa_m.mmaa015,g_mmaa_m.mmaa024,g_mmaa_m.mmaa025,g_mmaa_m.mmaa026,
   g_mmaa_m.mmaa027,g_mmaa_m.mmaa028,g_mmaa_m.mmaa029,g_mmaa_m.mmaa030,g_mmaa_m.mmaa031,g_mmaa_m.mmaa032,g_mmaa_m.mmaa033,
   g_mmaa_m.mmaa034,g_mmaa_m.mmaa035,g_mmaa_m.mmaa036,g_mmaa_m.mmaa037,g_mmaa_m.mmaa038,g_mmaa_m.mmaa039,g_mmaa_m.mmaa040,
   g_mmaa_m.mmaa041,g_mmaa_m.mmaa042,g_mmaa_m.mmaa043
   
END FUNCTION

################################################################################
#chk mmaa010
################################################################################
PRIVATE FUNCTION ammt500_mmaa010()
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5
   DEFINE   l_ooef006  LIKE ooef_t.ooef006
   DEFINE   l_oocn001  LIKE oocn_t.oocn001
   DEFINE   l_oocn003  LIKE oocn_t.oocn003
   DEFINE   l_oocn004  LIKE oocn_t.oocn004
   DEFINE   l_oocn005  LIKE oocn_t.oocn005
   DEFINE   l_oocn006  LIKE oocn_t.oocn006 
   DEFINE   l_oocgl003      LIKE oocgl_t.oocgl003
   DEFINE   l_oocil004      LIKE oocil_t.oocil004
   DEFINE   l_oockl005      LIKE oockl_t.oockl005
   DEFINE   l_oocml006      LIKE oocml_t.oocml006   
   LET g_errno = NULL
   SELECT COUNT(*) INTO l_cnt  FROM oocn_t WHERE oocn002 =g_mmaa_m.mmaa010 AND oocnent = g_enterprise
   IF l_cnt <= 0 THEN
      LET g_errno = "aoo-00151"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM oocn_t WHERE oocn002 =g_mmaa_m.mmaa010 AND oocnent = g_enterprise 
         AND oocnstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno = "aoo-00152"
      END IF         
   END IF
   IF cl_null(g_errno) THEN
      SELECT ooef006 INTO l_ooef006 
        FROM ooef_t WHERE ooef001 = g_site AND ooefent = g_enterprise
      SELECT oocn001,oocn003,oocn004,oocn005,oocn006 INTO l_oocn001,l_oocn003,l_oocn004,l_oocn005,l_oocn006
        FROM oocn_t
       WHERE oocn002 = g_mmaa_m.mmaa010 AND rownum=1
         AND oocnent = g_enterprise      #160604-00009#159   by 08172  
      
      SELECT COALESCE(oockl005,oockl003) INTO l_oockl005 FROM oockl_t 
       WHERE oocklent=g_enterprise
         AND oockl004=g_dlang  AND oockl001=l_oocn001 AND oockl002= l_oocn003
         AND oockl003 = l_oocn004 AND oocklent = g_enterprise

      SELECT COALESCE(oocil004,oocil002) INTO l_oocil004 FROM oocil_t WHERE oocil001 = l_oocn001
         AND oocil002 = l_oocn003 AND oocil003 = g_dlang  AND oocilent = g_enterprise
      
      SELECT COALESCE(oocml006,oocml004) INTO l_oocml006 FROM oocml_t
       WHERE oocml001 = l_oocn001 AND oocml002 = l_oocn003 AND oocml003 = l_oocn004
         AND oocml004 = l_oocn005 AND oocml005 = g_dlang AND oocmlent = g_enterprise
   
      SELECT COALESCE(oocgl003,oocgl001) INTO l_oocgl003 FROM oocgl_t 
       WHERE oocgl001 = l_oocn001 AND oocgl002 = g_dlang AND oocglent = g_enterprise 

      IF cl_null(l_oockl005) THEN LET l_oockl005 = l_oocn004 END IF
      IF cl_null(l_oocil004) THEN LET l_oocil004 = l_oocn003 END IF
      IF cl_null(l_oocml006) THEN LET l_oocml006 = l_oocn005 END IF
      IF cl_null(l_oocgl003) THEN LET l_oocgl003 = l_oocn001 END IF
      IF (g_mmaa_m.mmaa010<>g_mmaa_m_t.mmaa010 or g_mmaa_m_t.mmaa010 is null)  OR  cl_null(g_mmaa_m.mmaa011) THEN
         LET g_mmaa_m.mmaa011 = l_oocgl003 CLIPPED,l_oocil004 CLIPPED,l_oockl005 CLIPPED,l_oocml006 CLIPPED,l_oocn006 CLIPPED
      END IF      
      DISPLAY g_mmaa_m.mmaa011 TO mmaa011
   END IF
END FUNCTION

################################################################################
#creat address
################################################################################
PRIVATE FUNCTION ammt500_address()
   DEFINE  l_oocn002   LIKE oocn_t.oocn002
   DEFINE  l_mmaa011   LIKE mmaa_t.mmaa011
   DEFINE  l_mmaa010   LIKE mmaa_t.mmaa010
   DEFINE  p_sign      LIKE type_t.chr1
   IF g_mmaa_m.mmaastus<>'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "amm-00038"
      LET g_errparam.extend = g_mmaa_m.mmaastus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   CALL s_transaction_begin()
   CALL s_ammt500_conf_chk(g_mmaa_m.mmaadocno,g_mmaa_m.mmaastus) RETURNING g_success,g_errno
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_mmaa_m.mmaadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   CALL ammt300_01(g_mmaa_m.mmaadocno,g_enterprise,g_sign) RETURNING g_errno,l_mmaa010,l_mmaa011   #160506-00009#10 160512 by mark
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_mmaa_m.mmaadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF
   IF NOT cl_null(l_mmaa010) THEN
      LET g_mmaa_m.mmaa010 = l_mmaa010
   END IF
   IF NOT cl_null(l_mmaa011) THEN
      LET g_mmaa_m.mmaa011 = l_mmaa011
   END IF
   CALL s_transaction_end('Y','0')    
   DISPLAY BY NAME g_mmaa_m.mmaa010,g_mmaa_m.mmaa011
END FUNCTION

################################################################################
# 国家地区
################################################################################
PRIVATE FUNCTION ammt500_mmaa024_scc()
   DEFINE l_sql       STRING
   DEFINE l_oocg001   LIKE oocg_t.oocg001
   DEFINE l_oocgl003  LIKE oocgl_t.oocgl003
   DEFINE l_str1      STRING
   DEFINE l_str2      STRING

   LET l_sql = "SELECT DISTINCT oocg001,oocgl003 ",
               "  FROM oocg_t ",
               "  LEFT JOIN oocgl_t ON oocgent = oocglent ",
               "                   AND oocg001 = oocgl001 ",
               "                   AND oocgl002 = '",g_dlang,"' ",
               " WHERE oocgstus = 'Y' ",
               "   AND oocgent = ",g_enterprise,
               " ORDER BY oocg001"

   PREPARE ammt300_mmaa024_prep FROM l_sql
   DECLARE ammt300_mmaa024_curs CURSOR FOR ammt300_mmaa024_prep
   LET l_str1 = NULL
   LET l_str2 = NULL
   FOREACH ammt300_mmaa024_curs INTO l_oocg001,l_oocgl003
      LET l_oocgl003 = l_oocg001,'.',l_oocgl003
      LET l_str1 = l_str1,",",l_oocg001
      LET l_str2 = l_str2,",",l_oocgl003
   END FOREACH

   CALL cl_set_combo_items('mmaa024',l_str1,l_str2)
END FUNCTION

################################################################################
# 州省
################################################################################
PRIVATE FUNCTION ammt500_mmaa025_scc()
   DEFINE l_sql       STRING
   DEFINE l_ooci002   LIKE ooci_t.ooci001
   DEFINE l_oocil004  LIKE oocil_t.oocil003
   DEFINE l_str1      STRING
   DEFINE l_str2      STRING

   LET l_sql = " SELECT DISTINCT ooci002,oocil004 ",
               "   FROM ooci_t  ",
			      "   LEFT JOIN oocil_t ON oocient = oocilent ",
			      "                    AND ooci001 = oocil001 ",
			      "                    AND ooci002 = oocil002 ",
               "                    AND oocil003 = '",g_dlang,"' ",
               "  WHERE oocistus = 'Y' ",
               "    AND oocient = ",g_enterprise

   IF NOT cl_null(g_mmaa_m.mmaa024) THEN          
      LET l_sql = l_sql clipped,"AND ooci001 = '",g_mmaa_m.mmaa024,"'"
   END IF		
   IF cl_null(g_mmaa_m.mmaa024) THEN RETURN END IF   
			   
   PREPARE ammt300_mmaa025_prep FROM l_sql
   DECLARE ammt300_mmaa025_curs CURSOR FOR ammt300_mmaa025_prep
   LET l_str1 = NULL
   LET l_str2 = NULL
   FOREACH ammt300_mmaa025_curs INTO l_ooci002,l_oocil004
      LET l_str1 = l_str1,",",l_ooci002
      LET l_str2 = l_str2,",",l_oocil004
   END FOREACH

   CALL cl_set_combo_items('mmaa025',l_str1,l_str2)
END FUNCTION

################################################################################
# 县市
################################################################################
PRIVATE FUNCTION ammt500_mmaa026_scc()
   DEFINE l_sql       STRING
   DEFINE l_oock003   LIKE oock_t.oock001
   DEFINE l_oockl005  LIKE oockl_t.oockl003
   DEFINE l_str1      STRING
   DEFINE l_str2      STRING

   LET l_sql = " SELECT DISTINCT oock003,oockl005 ",
               "   FROM oock_t ",
			      "   LEFT JOIN oockl_t ON oockent = oocklent ",
			      "                    AND oock001 = oockl001 ",
			      "                    AND oock002 = oockl002 ",
			      "                    AND oock003 = oockl003 ",
               "                    AND oockl004 = '",g_dlang,"' ",
               "  WHERE oockstus = 'Y' ",
			      "    AND oockent = ",g_enterprise
               
   IF NOT cl_null(g_mmaa_m.mmaa024) THEN
      LET l_sql = l_sql clipped," AND oock001 = '",g_mmaa_m.mmaa024,"' "
   END IF
   IF NOT cl_null(g_mmaa_m.mmaa025) THEN
      LET l_sql = l_sql clipped," AND oock002 = '",g_mmaa_m.mmaa025,"' "
   END IF
   IF cl_null(g_mmaa_m.mmaa025) THEN RETURN END IF
			   
   PREPARE ammt300_mmaa026_prep FROM l_sql
   DECLARE ammt300_mmaa026_curs CURSOR FOR ammt300_mmaa026_prep
   LET l_str1 = NULL
   LET l_str2 = NULL
   FOREACH ammt300_mmaa026_curs INTO l_oock003,l_oockl005
      LET l_str1 = l_str1,",",l_oock003
      LET l_str2 = l_str2,",",l_oockl005
   END FOREACH

   CALL cl_set_combo_items('mmaa026',l_str1,l_str2)
END FUNCTION

################################################################################
# 行政地区
################################################################################
PRIVATE FUNCTION ammt500_mmaa027_scc()
   DEFINE l_sql       STRING
   DEFINE l_oocm004   LIKE oocm_t.oocm001
   DEFINE l_oocml006  LIKE oocml_t.oocml003
   DEFINE l_str1      STRING
   DEFINE l_str2      STRING

   LET l_sql = " SELECT DISTINCT oocm004,oocml006 ",
               "   FROM oocm_t ",
               "   LEFT JOIN oocml_t ON oocment = oocmlent ",
               "                    AND oocm001 = oocml001 ",
               "                    AND oocm002 = oocml002 ",
               "                    AND oocm003 = oocml003 ",
               "                    AND oocm004 = oocml004 ",
               "                    AND oocml005 = '",g_dlang,"' ",
               "  WHERE oocmstus = 'Y' ",
               "    AND oocment = ",g_enterprise
               
   IF NOT cl_null(g_mmaa_m.mmaa024) THEN
      LET l_sql = l_sql clipped," AND oocm001 = '",g_mmaa_m.mmaa024,"' "
   END IF                                       
   IF NOT cl_null(g_mmaa_m.mmaa025) THEN        
      LET l_sql = l_sql clipped," AND oocm002 = '",g_mmaa_m.mmaa025,"' "
   END IF                                       
   IF NOT cl_null(g_mmaa_m.mmaa026) THEN        
      LET l_sql = l_sql clipped," AND oocm003 = '",g_mmaa_m.mmaa026,"' "
   END IF
   IF cl_null(g_mmaa_m.mmaa026) THEN RETURN END IF
			   
   PREPARE ammt300_mmaa027_prep FROM l_sql
   DECLARE ammt300_mmaa027_curs CURSOR FOR ammt300_mmaa027_prep
   LET l_str1 = NULL
   LET l_str2 = NULL
   FOREACH ammt300_mmaa027_curs INTO l_oocm004,l_oocml006
      LET l_str1 = l_str1,",",l_oocm004
      LET l_str2 = l_str2,",",l_oocml006
   END FOREACH

   CALL cl_set_combo_items('mmaa027',l_str1,l_str2)
END FUNCTION

################################################################################
#街道
################################################################################
PRIVATE FUNCTION ammt500_mmaa028_scc()
   DEFINE l_sql       STRING
   DEFINE l_ooco005   LIKE ooco_t.ooco005
   DEFINE l_oocol007  LIKE oocol_t.oocol007
   DEFINE l_str1      STRING
   DEFINE l_str2      STRING

   LET l_sql = "SELECT DISTINCT ooco005,oocol007 ",
               "  FROM ooco_t ",
               "  LEFT JOIN oocol_t ON oocoent = oocolent ",
               "                   AND ooco001 = oocol001 ",
               "                   AND ooco002 = oocol002 ",
               "                   AND ooco003 = oocol003 ",
               "                   AND ooco004 = oocol004 ",
               "                   AND ooco005 = oocol005 ",
               "                   AND oocol006 = '",g_dlang,"' ",
               "  WHERE oocostus = 'Y' ",
               "    AND oocoent = ",g_enterprise
               
   IF NOT cl_null(g_mmaa_m.mmaa024) THEN
      LET l_sql = l_sql clipped," AND ooco001 = '",g_mmaa_m.mmaa024,"' "
   END IF
   IF NOT cl_null(g_mmaa_m.mmaa025) THEN
      LET l_sql = l_sql clipped," AND ooco002 = '",g_mmaa_m.mmaa025,"' "
   END IF
   IF NOT cl_null(g_mmaa_m.mmaa026) THEN
      LET l_sql = l_sql clipped," AND ooco003 = '",g_mmaa_m.mmaa026,"' "
   END IF
   IF NOT cl_null(g_mmaa_m.mmaa027) THEN
      LET l_sql = l_sql clipped," AND ooco004 = '",g_mmaa_m.mmaa027,"' "
   END IF 
   IF cl_null(g_mmaa_m.mmaa027) THEN RETURN END IF
			   
   PREPARE ammt300_mmaa028_prep FROM l_sql
   DECLARE ammt300_mmaa028_curs CURSOR FOR ammt300_mmaa028_prep
   LET l_str1 = NULL
   LET l_str2 = NULL
   FOREACH ammt300_mmaa028_curs INTO l_ooco005,l_oocol007
      LET l_str1 = l_str1,",",l_ooco005
      LET l_str2 = l_str2,",",l_oocol007
   END FOREACH

   CALL cl_set_combo_items('mmaa028',l_str1,l_str2)
END FUNCTION

################################################################################
# Descriptions...: 作业方式为1或2时的发卡卡号检查
################################################################################
PRIVATE FUNCTION ammt500_mmaa059_chk(p_card)
   DEFINE p_card      LIKE mmaa_t.mmaa059
   DEFINE l_mmaq006   LIKE mmaq_t.mmaq006
   DEFINE l_mmaq002   LIKE mmaq_t.mmaq002
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_mmanstus  LIKE mman_t.mmanstus
   
   LET g_errno = ''
   #检查卡号属否存在且为1.发行状态
   SELECT mmaq006,mmaq002,mmanstus
     INTO l_mmaq006,g_mmaa_m.mmaa044,l_mmanstus
     FROM mmaq_t,mman_t
    WHERE mmaqent = g_enterprise
      AND mmaq001 = p_card
      AND mmanent = mmaqent
      AND mman001 = mmaq002
      AND mmaqent = g_enterprise      #160604-00009#159   by 08172  
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'amm-00323'
      WHEN l_mmaq006 <> '1'    LET g_errno = 'amm-00324'
      WHEN l_mmanstus <> 'Y'   LET g_errno = 'amm-00418'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      CALL ammt500_card(p_card) RETURNING l_n
      IF l_n = 0 THEN 
         LET g_errno = 'amm-00325'
         RETURN 
      END IF 
   END IF 
END FUNCTION

################################################################################
# 作业方式为3时的发卡卡号检查
################################################################################
PRIVATE FUNCTION ammt500_mmaa059_1_chk(p_card)
   DEFINE p_card      LIKE mmaa_t.mmaa059
   DEFINE l_mmaq006   LIKE mmaq_t.mmaq006
   DEFINE l_mmaq002   LIKE mmaq_t.mmaq002
   DEFINE l_mmaq003   LIKE mmaq_t.mmaq003
   DEFINE l_mmaq009   LIKE mmaq_t.mmaq009
   DEFINE l_mmaq032   LIKE mmaq_t.mmaq032
   DEFINE l_mmaq008   LIKE mmaq_t.mmaq008
   DEFINE l_mmaq005   LIKE mmaq_t.mmaq005
   DEFINE l_mmanstus  LIKE mman_t.mmanstus
   DEFINE l_oodb011   LIKE oodb_t.oodb011
   DEFINE l_mman053   LIKE mman_t.mman053
   DEFINE l_mman054   LIKE mman_t.mman054
   DEFINE l_rtdx014   LIKE rtdx_t.rtdx014
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_mman042   LIKE mman_t.mman042
   DEFINE l_mman043   LIKE mman_t.mman043
   
   LET g_errno = ''
   #检查卡号属否存在且为3.开卡状态
   SELECT mmaq006,mmaq002,mmaq003,mmaq009,mmaq032,mmaq005,mmanstus,mman042,mman043
     INTO l_mmaq006,g_mmaa_m.mmaa044,l_mmaq003,l_mmaq009,l_mmaq032,l_mmaq005,l_mmanstus,l_mman042,l_mman043
     FROM mmaq_t,mman_t
    WHERE mmaqent = g_enterprise
      AND mmanent = mmaqent
      AND mman001 = mmaq002
      AND mmaq001 = p_card
      AND mmaqent = g_enterprise      #160604-00009#159   by 08172  
   CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'amm-00323'
         WHEN l_mmaq006 <> '3'    LET g_errno = 'amm-00335'
         WHEN l_mmaq005 < g_today LET g_errno = 'amm-00336'
         WHEN l_mmanstus <> 'Y'   LET g_errno = 'amm-00418'
         WHEN l_mman042 IS NOT NULL AND l_mman042 = 'N' 
                                  LET g_errno = 'amm-00427'
#         WHEN l_mman043 IS NOT NULL AND l_mman043 = 'N'
#                                  LET g_errno = 'amm-00450'
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      CALL ammt500_card(p_card) RETURNING l_n 
      IF l_n = 0 THEN 
         LET g_errno = 'amm-00325'
         RETURN 
      END IF 
   ELSE 
      RETURN 
   END IF 
   DISPLAY BY NAME g_mmaa_m.mmaa044
END FUNCTION

################################################################################
# Descriptions...: 作业方式为1或2时，卡号带出相关资料
################################################################################
PRIVATE FUNCTION ammt500_mmaa059_display()
   DEFINE l_mman015   LIKE mman_t.mman015   
   DEFINE l_mman006   LIKE mman_t.mman006
   DEFINE l_mman005   LIKE mman_t.mman005
   DEFINE l_mman042   LIKE mman_t.mman042
   DEFINE l_mman053   LIKE mman_t.mman053
   DEFINE l_mman069   LIKE mman_t.mman069
   DEFINE r_success   LIKE type_t.num5
    
   #對應卡種編號/單張購卡金額/卡码总长/固定编号长度/默认储值折扣率/可储值
   SELECT mmaq002,mman011,mman005,mman006,mman048,mman042,mmaq009
     INTO g_mmaa_m.mmaa044,g_mmaa_m.mmaa050,l_mman005,l_mman006,g_mmaa_m.mmaa046,l_mman042,g_mmaa_m.mmaa060
     FROM mman_t,mmaq_t
    WHERE mmaqent = mmanent
      AND mmaq001 = g_mmaa_m.mmaa059
      AND mman001 = mmaq002
      AND mmanent = g_enterprise      #160604-00009#159   by 08172  

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmaa_m.mmaa044
   CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_lang||"'","") RETURNING g_rtn_fields
   LET g_mmaa_m.mmaa044_desc = '', g_rtn_fields[1] , ''
               
   IF l_mman042 = 'N' THEN
      LET g_mmaa_m.mmaa045 = 0
   ELSE
      LET g_mmaa_m.mmaa045 = NULL
   END IF
   LET g_mmaa_m.mmaa046 = 100
   LET g_mmaa_m.mmaa047 = 0
   LET g_mmaa_m.mmaa048 = 0
   LET g_mmaa_m.mmaa049 = 0
   LET g_mmaa_m.mmaa050 = 0
   LET g_mmaa_m.mmaa051 = 0
   IF cl_null(g_mmaa_m.mmaa046) THEN 
      LET g_mmaa_m.mmaa046 = 100
   END IF 
   IF cl_null(g_mmaa_m.mmaa050) OR g_mmaa_m.mmaa000 = '3' THEN 
      LET g_mmaa_m.mmaa050 = 0
   END IF 
   DISPLAY BY NAME  g_mmaa_m.mmaa044,g_mmaa_m.mmaa045,g_mmaa_m.mmaa046,g_mmaa_m.mmaa047,
                    g_mmaa_m.mmaa048,g_mmaa_m.mmaa049,g_mmaa_m.mmaa050,g_mmaa_m.mmaa051,
                    g_mmaa_m.mmaa060,g_mmaa_m.mmaa044_desc
   
END FUNCTION

################################################################################
# Descriptions...: 计算储值加值
################################################################################
PRIVATE FUNCTION ammt500_mmaa045_display()
   DEFINE r_mmed            RECORD                #儲值資訊
             mmed006  LIKE mmed_t.mmed006,     #折扣比率             
             mmed007  LIKE mmed_t.mmed007,     #折扣金額             
             mmed008  LIKE mmed_t.mmed008,     #加值金額             
             mmed009  LIKE mmed_t.mmed009,     #此次儲值成本 
             mmed010  LIKE mmed_t.mmed010,     #儲值後卡內餘額
             mmed011  LIKE mmed_t.mmed011,     #儲值後卡內成本
             mmed012  LIKE mmed_t.mmed012,     #實際應付金額
             mmed015  LIKE mmed_t.mmed015,     #活动规则编号   #160729-00077#5 160823 by lori add
             mmed016  LIKE mmed_t.mmed016      #活动规则版本   #160729-00077#5 160823 by lori add
                         END RECORD
   DEFINE r_success         LIKE type_t.num5      #處理狀態
   DEFINE l_n         LIKE type_t.num10
   DEFINE l_time      LIKE rtia_t.rtia035
   DEFINE l_ooef016   LIKE ooef_t.ooef016
   DEFINE l_mman042   LIKE mman_t.mman042
   
   LET r_success = TRUE
   IF cl_null(g_mmaa_m.mmaa059) OR cl_null(g_mmaa_m.mmaa045) THEN  RETURN r_success END IF 
   SELECT mman042 INTO l_mman042
     FROM mman_t,mmaq_t
    WHERE mmaqent = mmanent
      AND mmaq001 = g_mmaa_m.mmaa059
      AND mman001 = mmaq002
      AND mmanent = g_enterprise      #160604-00009#159   by 08172  
   IF l_mman042 = 'N' THEN
      IF g_mmaa_m.mmaa045 > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00252'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      ELSE
         RETURN r_success
      END IF
   END IF
   
   LET l_time=cl_get_time()
   SELECT ooef016 INTO l_ooef016 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_mmaa_m.mmaasite
      
   #160701-00031#1 160702 by lori mark and add---(S)   
   #CALL s_card_value_cal(g_prog,'2',g_mmaa_m.mmaadocno,g_mmaa_m.mmaa059,g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt,
   #                      l_time,g_mmaa_m.mmaa045,l_ooef016)
   #  RETURNING r_success,r_mmed.*  
   
   CALL s_card_value_cal_ammt500(g_prog          ,'2'             ,g_mmaa_m.mmaasite,g_mmaa_m.mmaadocdt,l_time,
                                 l_ooef016       ,g_mmaa_m.mmaa001,g_mmaa_m.mmaa015 ,g_mmaa_m.mmaa037  ,g_mmaa_m.mmaa038,
                                 g_mmaa_m.mmaa044,g_mmaa_m.mmaa045,g_mmaa_m.mmaa057 ,g_mmaa_m.mmaa059)
     RETURNING r_success,r_mmed.*   
   #160701-00031#1 160702 by lori mark and add---(E)     
   IF NOT r_success THEN 
      RETURN r_success
   END IF
   LET g_mmaa_m.mmaa046 = r_mmed.mmed006
   LET g_mmaa_m.mmaa048 = r_mmed.mmed008     
   LET g_mmaa_m.mmaa047 = g_mmaa_m.mmaa045*(1-g_mmaa_m.mmaa046/100)
   LET g_mmaa_m.mmaa049 = g_mmaa_m.mmaa045+g_mmaa_m.mmaa048
   LET g_mmaa_m.mmaa051 = g_mmaa_m.mmaa045-g_mmaa_m.mmaa047+g_mmaa_m.mmaa050
      
   IF cl_null(g_mmaa_m.mmaa049) THEN 
      LET g_mmaa_m.mmaa049 = 0
   END IF 
   IF cl_null(g_mmaa_m.mmaa051) THEN 
      LET g_mmaa_m.mmaa051 = 0
   END IF 
   DISPLAY BY NAME g_mmaa_m.mmaa045,g_mmaa_m.mmaa046,g_mmaa_m.mmaa047,g_mmaa_m.mmaa048,g_mmaa_m.mmaa049,g_mmaa_m.mmaa051   

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 会员属性默认值
################################################################################
PRIVATE FUNCTION ammt500_vip_default()
   DEFINE l_sql   STRING 
   DEFINE l_oocq004  LIKE oocq_t.oocq004
   DEFINE l_oocq005  LIKE oocq_t.oocq005
   LET l_sql = "SELECT oocq004,oocq005 FROM oocq_t WHERE oocq001 = '2049'  AND oocqstus='Y' AND oocqent = ",g_enterprise clipped,"  ORDER BY oocq004 "
   PREPARE l_sql_pre1 FROM l_sql
   DECLARE l_sql_sql_cur1 CURSOR FOR l_sql_pre1
   FOREACH l_sql_sql_cur1 INTO l_oocq004,l_oocq005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "l_sql_sql_cur1"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
      CASE l_oocq004
         WHEN '2016' LET g_mmaa_m.mmaa029=l_oocq005
         WHEN '2017' LET g_mmaa_m.mmaa030=l_oocq005
         WHEN '2018' LET g_mmaa_m.mmaa031=l_oocq005
         WHEN '2019' LET g_mmaa_m.mmaa032=l_oocq005
         WHEN '2020' LET g_mmaa_m.mmaa033=l_oocq005
         WHEN '2021' LET g_mmaa_m.mmaa034=l_oocq005
         WHEN '2022' LET g_mmaa_m.mmaa035=l_oocq005
         WHEN '2023' LET g_mmaa_m.mmaa036=l_oocq005
         WHEN '2024' LET g_mmaa_m.mmaa038=l_oocq005
         WHEN '2025' LET g_mmaa_m.mmaa037=l_oocq005
         WHEN '2026' LET g_mmaa_m.mmaa039=l_oocq005
         WHEN '2027' LET g_mmaa_m.mmaa040=l_oocq005
         WHEN '2028' LET g_mmaa_m.mmaa041=l_oocq005
         WHEN '2029' LET g_mmaa_m.mmaa042=l_oocq005
         WHEN '2030' LET g_mmaa_m.mmaa043=l_oocq005
         
      END CASE
      DISPLAY BY NAME g_mmaa_m.mmaa029,g_mmaa_m.mmaa030,g_mmaa_m.mmaa031,g_mmaa_m.mmaa032,g_mmaa_m.mmaa033,
                      g_mmaa_m.mmaa034,g_mmaa_m.mmaa035,g_mmaa_m.mmaa036,g_mmaa_m.mmaa038,g_mmaa_m.mmaa037,
                      g_mmaa_m.mmaa039,g_mmaa_m.mmaa040,g_mmaa_m.mmaa041,g_mmaa_m.mmaa042,g_mmaa_m.mmaa043
   END FOREACH
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
PRIVATE FUNCTION ammt500_set_entry_mmaa059(p_cmd)
DEFINE p_cmd       LIKE type_t.chr10
DEFINE l_mman042   LIKE mman_t.mman042

   CALL cl_set_comp_required("mmaa061",TRUE)
   IF g_mmaa_m.mmaa000 = '2' THEN
      CALL cl_set_comp_required("mmaa059",FALSE)
   ELSE
      CALL cl_set_comp_required("mmaa059",TRUE)
   END IF
   CALL cl_set_comp_entry("mmaa044,mmaa047,mmaa049,mmaa051,mmaa060",FALSE)  
   
   CALL cl_set_comp_entry("mmaa045,mmaa046,mmaa048,mmaa050",TRUE)
   IF cl_null(g_mmaa_m.mmaa059) THEN
      CALL cl_set_comp_entry("mmaa045,mmaa046,mmaa048,mmaa050",FALSE)
   ELSE
      SELECT mman042 INTO l_mman042 FROM mman_t
       WHERE mmanent = g_enterprise
         AND mman001 = g_mmaa_m.mmaa044
      IF l_mman042 = 'Y' THEN 
         CALL cl_set_comp_entry("mmaa046,mmaa048",TRUE)
      ELSE
         CALL cl_set_comp_entry("mmaa046,mmaa048",FALSE)
      END IF
      IF g_mmaa_m.mmaa000 = '3' THEN
         CALL cl_set_comp_entry("mmaa050",FALSE)
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
PRIVATE FUNCTION ammt500_display_mmaa061()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmaa_m.mmaa061
   CALL ap_ref_array2(g_ref_fields,"SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? ","") RETURNING g_rtn_fields
   LET g_mmaa_m.mmaa061_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_mmaa_m.mmaa061_desc
END FUNCTION

################################################################################
# Descriptions...: 库区说明
################################################################################
PRIVATE FUNCTION ammt500_mmaa062_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmaa_m.mmaa062
   CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmaa_m.mmaa062_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmaa_m.mmaa062_desc
END FUNCTION

################################################################################
# Descriptions...: 库区检查
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt500_mmaa062_chk()
   DEFINE  l_inaastus  LIKE inaa_t.inaastus
   DEFINE  l_inaa102   LIKE inaa_t.inaa102
   
   LET g_errno = ''
   SELECT inaastus,inaa102 INTO l_inaastus,l_inaa102
     FROM inaa_t
    WHERE inaaent = g_enterprise
      AND inaasite = g_mmaa_m.mmaasite
      AND inaa001 = g_mmaa_m.mmaa062
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00276'
      WHEN l_inaastus <> 'Y'   LET g_errno = 'amm-00412'
      WHEN l_inaa102 <> '6'    LET g_errno = 'amm-00764'
      WHEN l_inaa102 IS NULL   LET g_errno = 'amm-00764'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 规则编号带值
# Date & Author..: 20160702 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt500_mmaa057_ref()
   DEFINE  l_mmby002   LIKE mmby_t.mmby002   
   SELECT MAX(mmby002) INTO l_mmby002
     FROM mmby_t
    WHERE mmbyent = g_enterprise
      AND mmby001 = g_mmaa_m.mmaa057
      AND mmbysite = g_mmaa_m.mmaasite #add by geza 20160702
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmaa_m.mmaa057
   LET g_ref_fields[2] = l_mmby002
   CALL ap_ref_array2(g_ref_fields,"SELECT DISTINCT mmbyl004 FROM mmbyl_t WHERE mmbylent='"||g_enterprise||"' AND mmbyl001=? AND mmbyl002 = ? AND mmbyl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmaa_m.mmaa057_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmaa_m.mmaa057_desc
END FUNCTION

 
{</section>}
 
