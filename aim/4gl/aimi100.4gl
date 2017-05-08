#該程式未解開Section, 採用最新樣板產出!
{<section id="aimi100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-06-24 15:21:27), PR版次:0013(2016-12-07 13:50:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000431
#+ Filename...: aimi100
#+ Description: 料件主分群維護作業
#+ Creator....: 02482(2013-07-22 15:36:22)
#+ Modifier...: 02295 -SD/PR- 08734
 
{</section>}
 
{<section id="aimi100.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#19  2016/03/29  by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#17  2016/04/11  By 07900    校验代码的重复错误讯息修改
#160617-00009#1   2016/06/21  By lixiang  增加WMS分群栏位的检核
#160620-00023#1   2016/06/24  By xianghui 单头基础单位部位空时，才新增允许使用单位的资料
#160712-00010#1   2016/07/22  By lixh  s_aimi092_chk_eigenvalue() 增加料号/类型传参
#161124-00048#2   2016/12/07  By 08734    星号整批调整
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
PRIVATE type type_g_imca_m        RECORD
       imca001 LIKE imca_t.imca001, 
   imca001_desc LIKE type_t.chr80, 
   imca004 LIKE imca_t.imca004, 
   imca005 LIKE imca_t.imca005, 
   imca005_desc LIKE type_t.chr80, 
   imca006 LIKE imca_t.imca006, 
   imca006_desc LIKE type_t.chr80, 
   imca010 LIKE imca_t.imca010, 
   imca010_desc LIKE type_t.chr80, 
   imca201 LIKE imca_t.imca201, 
   imca201_desc LIKE type_t.chr80, 
   imca202 LIKE imca_t.imca202, 
   imca202_desc LIKE type_t.chr80, 
   imca203 LIKE imca_t.imca203, 
   imca203_desc LIKE type_t.chr80, 
   imca204 LIKE imca_t.imca204, 
   imca204_desc LIKE type_t.chr80, 
   imca205 LIKE imca_t.imca205, 
   imca205_desc LIKE type_t.chr80, 
   imca206 LIKE imca_t.imca206, 
   imca206_desc LIKE type_t.chr80, 
   imca207 LIKE imca_t.imca207, 
   imca207_desc LIKE type_t.chr80, 
   imca208 LIKE imca_t.imca208, 
   imca208_desc LIKE type_t.chr80, 
   imcastus LIKE imca_t.imcastus, 
   imca126 LIKE imca_t.imca126, 
   imca126_desc LIKE type_t.chr80, 
   imca127 LIKE imca_t.imca127, 
   imca127_desc LIKE type_t.chr80, 
   imca131 LIKE imca_t.imca131, 
   imca131_desc LIKE type_t.chr80, 
   imca128 LIKE imca_t.imca128, 
   imca128_desc LIKE type_t.chr80, 
   imca129 LIKE imca_t.imca129, 
   imca129_desc LIKE type_t.chr80, 
   imca130 LIKE imca_t.imca130, 
   imca132 LIKE imca_t.imca132, 
   imca132_desc LIKE type_t.chr80, 
   imca133 LIKE imca_t.imca133, 
   imca133_desc LIKE type_t.chr80, 
   imca134 LIKE imca_t.imca134, 
   imca134_desc LIKE type_t.chr80, 
   imca135 LIKE imca_t.imca135, 
   imca135_desc LIKE type_t.chr80, 
   imca136 LIKE imca_t.imca136, 
   imca136_desc LIKE type_t.chr80, 
   imca137 LIKE imca_t.imca137, 
   imca137_desc LIKE type_t.chr80, 
   imca138 LIKE imca_t.imca138, 
   imca138_desc LIKE type_t.chr80, 
   imca139 LIKE imca_t.imca139, 
   imca139_desc LIKE type_t.chr80, 
   imca140 LIKE imca_t.imca140, 
   imca140_desc LIKE type_t.chr80, 
   imca141 LIKE imca_t.imca141, 
   imca141_desc LIKE type_t.chr80, 
   imcaownid LIKE imca_t.imcaownid, 
   imcaownid_desc LIKE type_t.chr80, 
   imcaowndp LIKE imca_t.imcaowndp, 
   imcaowndp_desc LIKE type_t.chr80, 
   imcacrtid LIKE imca_t.imcacrtid, 
   imcacrtid_desc LIKE type_t.chr80, 
   imcacrtdp LIKE imca_t.imcacrtdp, 
   imcacrtdp_desc LIKE type_t.chr80, 
   imcacrtdt LIKE imca_t.imcacrtdt, 
   imcamodid LIKE imca_t.imcamodid, 
   imcamodid_desc LIKE type_t.chr80, 
   imcamoddt LIKE imca_t.imcamoddt, 
   imca011 LIKE imca_t.imca011, 
   imca012 LIKE imca_t.imca012, 
   imca013 LIKE imca_t.imca013, 
   imca014 LIKE imca_t.imca014, 
   imca018 LIKE imca_t.imca018, 
   imca018_desc LIKE type_t.chr80, 
   imca022 LIKE imca_t.imca022, 
   imca022_desc LIKE type_t.chr80, 
   imca024 LIKE imca_t.imca024, 
   imca026 LIKE imca_t.imca026, 
   imca027 LIKE imca_t.imca027, 
   imca029 LIKE imca_t.imca029, 
   imca029_desc LIKE type_t.chr80, 
   imca030 LIKE imca_t.imca030, 
   imca032 LIKE imca_t.imca032, 
   imca032_desc LIKE type_t.chr80, 
   imca033 LIKE imca_t.imca033, 
   imca036 LIKE imca_t.imca036, 
   imca037 LIKE imca_t.imca037, 
   imca038 LIKE imca_t.imca038, 
   imca043 LIKE imca_t.imca043, 
   imca041 LIKE imca_t.imca041, 
   imca042 LIKE imca_t.imca042, 
   imca044 LIKE imca_t.imca044, 
   imca122 LIKE imca_t.imca122, 
   imca122_desc LIKE type_t.chr80, 
   imca045 LIKE imca_t.imca045, 
   imca045_desc LIKE type_t.chr80, 
   imca123 LIKE imca_t.imca123, 
   imca003 LIKE imca_t.imca003
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_imcj_d        RECORD
       imcj002 LIKE imcj_t.imcj002, 
   imcj002_desc LIKE type_t.chr500, 
   imcj003 LIKE imcj_t.imcj003, 
   imcj003_desc LIKE type_t.chr500, 
   imcj004 LIKE imcj_t.imcj004, 
   imcj005 LIKE imcj_t.imcj005, 
   imcj005_desc LIKE type_t.chr500, 
   imcj006 LIKE imcj_t.imcj006, 
   imcj006_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_imcj2_d RECORD
       imcn002 LIKE imcn_t.imcn002, 
   imcn002_desc LIKE type_t.chr500, 
   imcn003 LIKE imcn_t.imcn003, 
   imcn003_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_imcj3_d RECORD
       imcl002 LIKE imcl_t.imcl002, 
   oocql004 LIKE type_t.chr500, 
   oocq005 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_imcj4_d RECORD
       imcm002 LIKE imcm_t.imcm002, 
   imcm005 LIKE imcm_t.imcm005, 
   imcm003 LIKE imcm_t.imcm003, 
   imcm006 LIKE imcm_t.imcm006, 
   imcm004 LIKE imcm_t.imcm004
       END RECORD
PRIVATE TYPE type_g_imcj5_d RECORD
       imco002 LIKE imco_t.imco002, 
   imco002_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_imca001 LIKE imca_t.imca001,
   b_oocql004 LIKE oocql_t.oocql004,
      b_imca004 LIKE imca_t.imca004,
      b_imca005 LIKE imca_t.imca005,
   b_imca005_desc LIKE type_t.chr80,
      b_imca006 LIKE imca_t.imca006,
   b_imca006_desc LIKE type_t.chr80,
      b_imca010 LIKE imca_t.imca010,
   b_imca010_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_success           LIKE type_t.num5
DEFINE l_errno             LIKE gzze_t.gzze001
DEFINE l_imeb005           LIKE imeb_t.imeb005
#end add-point
       
#模組變數(Module Variables)
DEFINE g_imca_m          type_g_imca_m
DEFINE g_imca_m_t        type_g_imca_m
DEFINE g_imca_m_o        type_g_imca_m
DEFINE g_imca_m_mask_o   type_g_imca_m #轉換遮罩前資料
DEFINE g_imca_m_mask_n   type_g_imca_m #轉換遮罩後資料
 
   DEFINE g_imca001_t LIKE imca_t.imca001
 
 
DEFINE g_imcj_d          DYNAMIC ARRAY OF type_g_imcj_d
DEFINE g_imcj_d_t        type_g_imcj_d
DEFINE g_imcj_d_o        type_g_imcj_d
DEFINE g_imcj_d_mask_o   DYNAMIC ARRAY OF type_g_imcj_d #轉換遮罩前資料
DEFINE g_imcj_d_mask_n   DYNAMIC ARRAY OF type_g_imcj_d #轉換遮罩後資料
DEFINE g_imcj2_d          DYNAMIC ARRAY OF type_g_imcj2_d
DEFINE g_imcj2_d_t        type_g_imcj2_d
DEFINE g_imcj2_d_o        type_g_imcj2_d
DEFINE g_imcj2_d_mask_o   DYNAMIC ARRAY OF type_g_imcj2_d #轉換遮罩前資料
DEFINE g_imcj2_d_mask_n   DYNAMIC ARRAY OF type_g_imcj2_d #轉換遮罩後資料
DEFINE g_imcj3_d          DYNAMIC ARRAY OF type_g_imcj3_d
DEFINE g_imcj3_d_t        type_g_imcj3_d
DEFINE g_imcj3_d_o        type_g_imcj3_d
DEFINE g_imcj3_d_mask_o   DYNAMIC ARRAY OF type_g_imcj3_d #轉換遮罩前資料
DEFINE g_imcj3_d_mask_n   DYNAMIC ARRAY OF type_g_imcj3_d #轉換遮罩後資料
DEFINE g_imcj4_d          DYNAMIC ARRAY OF type_g_imcj4_d
DEFINE g_imcj4_d_t        type_g_imcj4_d
DEFINE g_imcj4_d_o        type_g_imcj4_d
DEFINE g_imcj4_d_mask_o   DYNAMIC ARRAY OF type_g_imcj4_d #轉換遮罩前資料
DEFINE g_imcj4_d_mask_n   DYNAMIC ARRAY OF type_g_imcj4_d #轉換遮罩後資料
DEFINE g_imcj5_d          DYNAMIC ARRAY OF type_g_imcj5_d
DEFINE g_imcj5_d_t        type_g_imcj5_d
DEFINE g_imcj5_d_o        type_g_imcj5_d
DEFINE g_imcj5_d_mask_o   DYNAMIC ARRAY OF type_g_imcj5_d #轉換遮罩前資料
DEFINE g_imcj5_d_mask_n   DYNAMIC ARRAY OF type_g_imcj5_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
DEFINE g_wc2_table5   STRING
 
 
 
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
 
{<section id="aimi100.main" >}
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
   CALL cl_ap_init("aim","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imca001,'',imca004,imca005,'',imca006,'',imca010,'',imca201,'',imca202, 
       '',imca203,'',imca204,'',imca205,'',imca206,'',imca207,'',imca208,'',imcastus,imca126,'',imca127, 
       '',imca131,'',imca128,'',imca129,'',imca130,imca132,'',imca133,'',imca134,'',imca135,'',imca136, 
       '',imca137,'',imca138,'',imca139,'',imca140,'',imca141,'',imcaownid,'',imcaowndp,'',imcacrtid, 
       '',imcacrtdp,'',imcacrtdt,imcamodid,'',imcamoddt,imca011,imca012,imca013,imca014,imca018,'',imca022, 
       '',imca024,imca026,imca027,imca029,'',imca030,imca032,'',imca033,imca036,imca037,imca038,imca043, 
       imca041,imca042,imca044,imca122,'',imca045,'',imca123,imca003", 
                      " FROM imca_t",
                      " WHERE imcaent= ? AND imca001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imca001,t0.imca004,t0.imca005,t0.imca006,t0.imca010,t0.imca201,t0.imca202, 
       t0.imca203,t0.imca204,t0.imca205,t0.imca206,t0.imca207,t0.imca208,t0.imcastus,t0.imca126,t0.imca127, 
       t0.imca131,t0.imca128,t0.imca129,t0.imca130,t0.imca132,t0.imca133,t0.imca134,t0.imca135,t0.imca136, 
       t0.imca137,t0.imca138,t0.imca139,t0.imca140,t0.imca141,t0.imcaownid,t0.imcaowndp,t0.imcacrtid, 
       t0.imcacrtdp,t0.imcacrtdt,t0.imcamodid,t0.imcamoddt,t0.imca011,t0.imca012,t0.imca013,t0.imca014, 
       t0.imca018,t0.imca022,t0.imca024,t0.imca026,t0.imca027,t0.imca029,t0.imca030,t0.imca032,t0.imca033, 
       t0.imca036,t0.imca037,t0.imca038,t0.imca043,t0.imca041,t0.imca042,t0.imca044,t0.imca122,t0.imca045, 
       t0.imca123,t0.imca003,t1.oocql004 ,t2.imeal003 ,t3.oocal003 ,t4.oocql004 ,t5.oocql004 ,t6.oocql004 , 
       t7.oocql004 ,t8.oocql004 ,t9.oocql004 ,t10.oocql004 ,t11.oocql004 ,t12.oocql004 ,t13.oocql004 , 
       t14.oocql004 ,t15.oocql004 ,t16.oocql004 ,t17.oocql004 ,t18.oocql004 ,t19.oocql004 ,t20.oocql004 , 
       t21.oocql004 ,t22.oocql004 ,t23.oocql004 ,t24.oocql004 ,t25.oocql004 ,t26.oocql004 ,t27.oocql004 , 
       t28.ooag011 ,t29.ooefl003 ,t30.ooag011 ,t31.ooefl003 ,t32.ooag011 ,t33.oocal003 ,t34.oocal003 , 
       t35.oocal003 ,t36.oocal003 ,t37.oocql004 ,t38.oocgl003",
               " FROM imca_t t0",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='200' AND t1.oocql002=t0.imca001 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t2 ON t2.imealent="||g_enterprise||" AND t2.imeal001=t0.imca005 AND t2.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.imca006 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='210' AND t4.oocql002=t0.imca010 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='201' AND t5.oocql002=t0.imca201 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='202' AND t6.oocql002=t0.imca202 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='203' AND t7.oocql002=t0.imca203 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='204' AND t8.oocql002=t0.imca204 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='205' AND t9.oocql002=t0.imca205 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='206' AND t10.oocql002=t0.imca206 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t11 ON t11.oocqlent="||g_enterprise||" AND t11.oocql001='207' AND t11.oocql002=t0.imca207 AND t11.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='229' AND t12.oocql002=t0.imca208 AND t12.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='2002' AND t13.oocql002=t0.imca126 AND t13.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t14 ON t14.oocqlent="||g_enterprise||" AND t14.oocql001='2003' AND t14.oocql002=t0.imca127 AND t14.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t15 ON t15.oocqlent="||g_enterprise||" AND t15.oocql001='2001' AND t15.oocql002=t0.imca131 AND t15.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t16 ON t16.oocqlent="||g_enterprise||" AND t16.oocql001='2004' AND t16.oocql002=t0.imca128 AND t16.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t17 ON t17.oocqlent="||g_enterprise||" AND t17.oocql001='2005' AND t17.oocql002=t0.imca129 AND t17.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t18 ON t18.oocqlent="||g_enterprise||" AND t18.oocql001='2006' AND t18.oocql002=t0.imca132 AND t18.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t19 ON t19.oocqlent="||g_enterprise||" AND t19.oocql001='2007' AND t19.oocql002=t0.imca133 AND t19.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t20 ON t20.oocqlent="||g_enterprise||" AND t20.oocql001='2008' AND t20.oocql002=t0.imca134 AND t20.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t21 ON t21.oocqlent="||g_enterprise||" AND t21.oocql001='2009' AND t21.oocql002=t0.imca135 AND t21.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t22 ON t22.oocqlent="||g_enterprise||" AND t22.oocql001='2010' AND t22.oocql002=t0.imca136 AND t22.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t23 ON t23.oocqlent="||g_enterprise||" AND t23.oocql001='2011' AND t23.oocql002=t0.imca137 AND t23.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t24 ON t24.oocqlent="||g_enterprise||" AND t24.oocql001='2012' AND t24.oocql002=t0.imca138 AND t24.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t25 ON t25.oocqlent="||g_enterprise||" AND t25.oocql001='2013' AND t25.oocql002=t0.imca139 AND t25.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t26 ON t26.oocqlent="||g_enterprise||" AND t26.oocql001='2014' AND t26.oocql002=t0.imca140 AND t26.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t27 ON t27.oocqlent="||g_enterprise||" AND t27.oocql001='2015' AND t27.oocql002=t0.imca141 AND t27.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t28 ON t28.ooagent="||g_enterprise||" AND t28.ooag001=t0.imcaownid  ",
               " LEFT JOIN ooefl_t t29 ON t29.ooeflent="||g_enterprise||" AND t29.ooefl001=t0.imcaowndp AND t29.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t30 ON t30.ooagent="||g_enterprise||" AND t30.ooag001=t0.imcacrtid  ",
               " LEFT JOIN ooefl_t t31 ON t31.ooeflent="||g_enterprise||" AND t31.ooefl001=t0.imcacrtdp AND t31.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t32 ON t32.ooagent="||g_enterprise||" AND t32.ooag001=t0.imcamodid  ",
               " LEFT JOIN oocal_t t33 ON t33.oocalent="||g_enterprise||" AND t33.oocal001=t0.imca018 AND t33.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t34 ON t34.oocalent="||g_enterprise||" AND t34.oocal001=t0.imca022 AND t34.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t35 ON t35.oocalent="||g_enterprise||" AND t35.oocal001=t0.imca029 AND t35.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t36 ON t36.oocalent="||g_enterprise||" AND t36.oocal001=t0.imca032 AND t36.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t37 ON t37.oocqlent="||g_enterprise||" AND t37.oocql001='2000' AND t37.oocql002=t0.imca122 AND t37.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t38 ON t38.oocglent="||g_enterprise||" AND t38.oocgl001=t0.imca045 AND t38.oocgl002='"||g_dlang||"' ",
 
               " WHERE t0.imcaent = " ||g_enterprise|| " AND t0.imca001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimi100_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimi100 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimi100_init()   
 
      #進入選單 Menu (="N")
      CALL aimi100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimi100
      
   END IF 
   
   CLOSE aimi100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimi100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimi100_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
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
   LET g_detail_idx_list[5] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('imcastus','17','N,Y')
 
      CALL cl_set_combo_scc('imca004','1001') 
   CALL cl_set_combo_scc('imca011','1002') 
   CALL cl_set_combo_scc('imca044','1004') 
   CALL cl_set_combo_scc('imcm002','1006') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("'5',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("b_imca004",1001)
   CALL cl_set_combo_scc("imca004",1001)
   CALL cl_set_combo_scc("imca011",1002)
   CALL cl_set_combo_scc("imca044",1004)
   CALL cl_set_combo_scc("imcm002",1006)
   #end add-point
   
   #初始化搜尋條件
   CALL aimi100_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aimi100.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aimi100_ui_dialog()
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
            CALL aimi100_insert()
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
         INITIALIZE g_imca_m.* TO NULL
         CALL g_imcj_d.clear()
         CALL g_imcj2_d.clear()
         CALL g_imcj3_d.clear()
         CALL g_imcj4_d.clear()
         CALL g_imcj5_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aimi100_init()
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
               
               CALL aimi100_fetch('') # reload data
               LET l_ac = 1
               CALL aimi100_ui_detailshow() #Setting the current row 
         
               CALL aimi100_idx_chk()
               #NEXT FIELD imcj002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_imcj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimi100_idx_chk()
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
               CALL aimi100_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_imcj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimi100_idx_chk()
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
               CALL aimi100_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_imcj3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimi100_idx_chk()
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
               CALL aimi100_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_imcj4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimi100_idx_chk()
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
               CALL aimi100_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_imcj5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimi100_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("'5',",l_ac)
               
               #add-point:page5, before row動作 name="ui_dialog.body5.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
               #顯示單身筆數
               CALL aimi100_idx_chk()
               #add-point:page5自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_5)
            
         
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aimi100_browser_fill("")
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
               CALL aimi100_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aimi100_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aimi100_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL gfrm_curr.ensureFieldVisible("imca_t.imca011")
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aimi100_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aimi100_set_act_visible()   
            CALL aimi100_set_act_no_visible()
            IF NOT (g_imca_m.imca001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " imcaent = " ||g_enterprise|| " AND",
                                  " imca001 = '", g_imca_m.imca001, "' "
 
               #填到對應位置
               CALL aimi100_browser_fill("")
            END IF
         
          
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
 
               INITIALIZE g_wc2_table5 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "imca_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imcj_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imcn_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imcl_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imcm_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imco_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
 
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
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aimi100_browser_fill("F")   #browser_fill()會將notice區塊清空
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
 
               INITIALIZE g_wc2_table5 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "imca_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imcj_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imcn_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imcl_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imcm_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imco_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
 
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
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimi100_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimi100_fetch("F")
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
               CALL aimi100_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aimi100_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimi100_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aimi100_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimi100_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aimi100_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimi100_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aimi100_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimi100_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aimi100_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimi100_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_imcj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_imcj2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_imcj3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_imcj4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_imcj5_d)
                  LET g_export_id[5]   = "s_detail5"
 
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
               NEXT FIELD imcj002
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
               CALL aimi100_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aimi100_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimi100_delete()
               #add-point:ON ACTION delete name="menu.delete"
               CALL gfrm_curr.ensureFieldVisible("imca_t.imca011")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimi100_insert()
               #add-point:ON ACTION insert name="menu.insert"
               CALL gfrm_curr.ensureFieldVisible("imca_t.imca011")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL gfrm_curr.ensureFieldVisible("imca_t.imca011")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL gfrm_curr.ensureFieldVisible("imca_t.imca011")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aimi100_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               CALL gfrm_curr.ensureFieldVisible("imca_t.imca011")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi100_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.ensureFieldVisible("imca_t.imca011")
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi100_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi100_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi100_set_pk_array()
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
 
{<section id="aimi100.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aimi100_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
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
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT imca001 ",
                      " FROM imca_t ",
                      " ",
                      " LEFT JOIN imcj_t ON imcjent = imcaent AND imca001 = imcj001 ", "  ",
                      #add-point:browser_fill段sql(imcj_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN imcn_t ON imcnent = imcaent AND imca001 = imcn001", "  ",
                      #add-point:browser_fill段sql(imcn_t1) name="browser_fill.cnt.join.imcn_t1"
                      
                      #end add-point
 
                      " LEFT JOIN imcl_t ON imclent = imcaent AND imca001 = imcl001", "  ",
                      #add-point:browser_fill段sql(imcl_t1) name="browser_fill.cnt.join.imcl_t1"
                      
                      #end add-point
 
                      " LEFT JOIN imcm_t ON imcment = imcaent AND imca001 = imcm001", "  ",
                      #add-point:browser_fill段sql(imcm_t1) name="browser_fill.cnt.join.imcm_t1"
                      
                      #end add-point
 
                      " LEFT JOIN imco_t ON imcoent = imcaent AND imca001 = imco001", "  ",
                      #add-point:browser_fill段sql(imco_t1) name="browser_fill.cnt.join.imco_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE imcaent = " ||g_enterprise|| " AND imcjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("imca_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT imca001 ",
                      " FROM imca_t ", 
                      "  ",
                      "  ",
                      " WHERE imcaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("imca_t")
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
      INITIALIZE g_imca_m.* TO NULL
      CALL g_imcj_d.clear()        
      CALL g_imcj2_d.clear() 
      CALL g_imcj3_d.clear() 
      CALL g_imcj4_d.clear() 
      CALL g_imcj5_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.imca001,t0.imca004,t0.imca005,t0.imca006,t0.imca010 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imcastus,t0.imca001,t0.imca004,t0.imca005,t0.imca006,t0.imca010, 
          t1.imeal003 ,t2.oocal003 ,t3.oocql004 ",
                  " FROM imca_t t0",
                  "  ",
                  "  LEFT JOIN imcj_t ON imcjent = imcaent AND imca001 = imcj001 ", "  ", 
                  #add-point:browser_fill段sql(imcj_t1) name="browser_fill.join.imcj_t1"
                  
                  #end add-point
                  "  LEFT JOIN imcn_t ON imcnent = imcaent AND imca001 = imcn001", "  ", 
                  #add-point:browser_fill段sql(imcn_t1) name="browser_fill.join.imcn_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN imcl_t ON imclent = imcaent AND imca001 = imcl001", "  ", 
                  #add-point:browser_fill段sql(imcl_t1) name="browser_fill.join.imcl_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN imcm_t ON imcment = imcaent AND imca001 = imcm001", "  ", 
                  #add-point:browser_fill段sql(imcm_t1) name="browser_fill.join.imcm_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN imco_t ON imcoent = imcaent AND imca001 = imco001", "  ", 
                  #add-point:browser_fill段sql(imco_t1) name="browser_fill.join.imco_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN imeal_t t1 ON t1.imealent="||g_enterprise||" AND t1.imeal001=t0.imca005 AND t1.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=t0.imca006 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='210' AND t3.oocql002=t0.imca010 AND t3.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.imcaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("imca_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imcastus,t0.imca001,t0.imca004,t0.imca005,t0.imca006,t0.imca010, 
          t1.imeal003 ,t2.oocal003 ,t3.oocql004 ",
                  " FROM imca_t t0",
                  "  ",
                                 " LEFT JOIN imeal_t t1 ON t1.imealent="||g_enterprise||" AND t1.imeal001=t0.imca005 AND t1.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=t0.imca006 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='210' AND t3.oocql002=t0.imca010 AND t3.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.imcaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("imca_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY imca001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"imca_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imca001,g_browser[g_cnt].b_imca004, 
          g_browser[g_cnt].b_imca005,g_browser[g_cnt].b_imca006,g_browser[g_cnt].b_imca010,g_browser[g_cnt].b_imca005_desc, 
          g_browser[g_cnt].b_imca006_desc,g_browser[g_cnt].b_imca010_desc
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
      LET g_ref_fields[1] = g_browser[g_cnt].b_imca001
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_oocql004= g_rtn_fields[1]
      DISPLAY BY NAME g_browser[g_cnt].b_oocql004
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_imca006
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_imca006_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_browser[g_cnt].b_imca006_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_imca010
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_imca010_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_browser[g_cnt].b_imca010_desc
         #end add-point
      
         #遮罩相關處理
         CALL aimi100_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_imca001) THEN
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
 
{<section id="aimi100.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aimi100_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_imca_m.imca001 = g_browser[g_current_idx].b_imca001   
 
   EXECUTE aimi100_master_referesh USING g_imca_m.imca001 INTO g_imca_m.imca001,g_imca_m.imca004,g_imca_m.imca005, 
       g_imca_m.imca006,g_imca_m.imca010,g_imca_m.imca201,g_imca_m.imca202,g_imca_m.imca203,g_imca_m.imca204, 
       g_imca_m.imca205,g_imca_m.imca206,g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus,g_imca_m.imca126, 
       g_imca_m.imca127,g_imca_m.imca131,g_imca_m.imca128,g_imca_m.imca129,g_imca_m.imca130,g_imca_m.imca132, 
       g_imca_m.imca133,g_imca_m.imca134,g_imca_m.imca135,g_imca_m.imca136,g_imca_m.imca137,g_imca_m.imca138, 
       g_imca_m.imca139,g_imca_m.imca140,g_imca_m.imca141,g_imca_m.imcaownid,g_imca_m.imcaowndp,g_imca_m.imcacrtid, 
       g_imca_m.imcacrtdp,g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamoddt,g_imca_m.imca011, 
       g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca022,g_imca_m.imca024, 
       g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca033, 
       g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042, 
       g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045,g_imca_m.imca123,g_imca_m.imca003,g_imca_m.imca001_desc, 
       g_imca_m.imca005_desc,g_imca_m.imca006_desc,g_imca_m.imca010_desc,g_imca_m.imca201_desc,g_imca_m.imca202_desc, 
       g_imca_m.imca203_desc,g_imca_m.imca204_desc,g_imca_m.imca205_desc,g_imca_m.imca206_desc,g_imca_m.imca207_desc, 
       g_imca_m.imca208_desc,g_imca_m.imca126_desc,g_imca_m.imca127_desc,g_imca_m.imca131_desc,g_imca_m.imca128_desc, 
       g_imca_m.imca129_desc,g_imca_m.imca132_desc,g_imca_m.imca133_desc,g_imca_m.imca134_desc,g_imca_m.imca135_desc, 
       g_imca_m.imca136_desc,g_imca_m.imca137_desc,g_imca_m.imca138_desc,g_imca_m.imca139_desc,g_imca_m.imca140_desc, 
       g_imca_m.imca141_desc,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid_desc, 
       g_imca_m.imcacrtdp_desc,g_imca_m.imcamodid_desc,g_imca_m.imca018_desc,g_imca_m.imca022_desc,g_imca_m.imca029_desc, 
       g_imca_m.imca032_desc,g_imca_m.imca122_desc,g_imca_m.imca045_desc
   
   CALL aimi100_imca_t_mask()
   CALL aimi100_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aimi100.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aimi100_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimi100_ui_browser_refresh()
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
      IF g_browser[l_i].b_imca001 = g_imca_m.imca001 
 
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
 
{<section id="aimi100.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimi100_construct()
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
   INITIALIZE g_imca_m.* TO NULL
   CALL g_imcj_d.clear()        
   CALL g_imcj2_d.clear() 
   CALL g_imcj3_d.clear() 
   CALL g_imcj4_d.clear() 
   CALL g_imcj5_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
   INITIALIZE g_wc2_table5 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON imca001,imca004,imca005,imca006,imca010,imca201,imca202,imca203,imca204, 
          imca205,imca206,imca207,imca208,imcastus,imca126,imca127,imca131,imca128,imca129,imca130,imca132, 
          imca133,imca134,imca135,imca136,imca137,imca138,imca139,imca140,imca141,imcaownid,imcaowndp, 
          imcacrtid,imcacrtdp,imcacrtdt,imcamodid,imcamoddt,imca011,imca012,imca013,imca014,imca018, 
          imca022,imca024,imca026,imca027,imca029,imca030,imca032,imca033,imca036,imca037,imca038,imca043, 
          imca041,imca042,imca044,imca122,imca045,imca123,imca003
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imcacrtdt>>----
         AFTER FIELD imcacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imcamoddt>>----
         AFTER FIELD imcamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imcacnfdt>>----
         
         #----<<imcapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.imca001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca001
            #add-point:ON ACTION controlp INFIELD imca001 name="construct.c.imca001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "200" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca001  #顯示到畫面上

            NEXT FIELD imca001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca001
            #add-point:BEFORE FIELD imca001 name="construct.b.imca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca001
            
            #add-point:AFTER FIELD imca001 name="construct.a.imca001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca004
            #add-point:BEFORE FIELD imca004 name="construct.b.imca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca004
            
            #add-point:AFTER FIELD imca004 name="construct.a.imca004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca004
            #add-point:ON ACTION controlp INFIELD imca004 name="construct.c.imca004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imca005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca005
            #add-point:ON ACTION controlp INFIELD imca005 name="construct.c.imca005"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = "221"   #2014/12/01 by stellar
            CALL q_imea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca005  #顯示到畫面上

            NEXT FIELD imca005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca005
            #add-point:BEFORE FIELD imca005 name="construct.b.imca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca005
            
            #add-point:AFTER FIELD imca005 name="construct.a.imca005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca006
            #add-point:ON ACTION controlp INFIELD imca006 name="construct.c.imca006"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca006  #顯示到畫面上

            NEXT FIELD imca006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca006
            #add-point:BEFORE FIELD imca006 name="construct.b.imca006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca006
            
            #add-point:AFTER FIELD imca006 name="construct.a.imca006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca010
            #add-point:ON ACTION controlp INFIELD imca010 name="construct.c.imca010"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "210" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca010  #顯示到畫面上

            NEXT FIELD imca010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca010
            #add-point:BEFORE FIELD imca010 name="construct.b.imca010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca010
            
            #add-point:AFTER FIELD imca010 name="construct.a.imca010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca201
            #add-point:ON ACTION controlp INFIELD imca201 name="construct.c.imca201"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "imccsite = 'ALL' "
            CALL q_imcc051_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca201  #顯示到畫面上
            LET g_qryparam.where = ""
             
            NEXT FIELD imca201                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca201
            #add-point:BEFORE FIELD imca201 name="construct.b.imca201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca201
            
            #add-point:AFTER FIELD imca201 name="construct.a.imca201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca202
            #add-point:ON ACTION controlp INFIELD imca202 name="construct.c.imca202"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "imcdsite = 'ALL' "
            CALL q_imcd111_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca202  #顯示到畫面上
            LET g_qryparam.where = ""

            NEXT FIELD imca202                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca202
            #add-point:BEFORE FIELD imca202 name="construct.b.imca202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca202
            
            #add-point:AFTER FIELD imca202 name="construct.a.imca202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca203
            #add-point:ON ACTION controlp INFIELD imca203 name="construct.c.imca203"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "imcesite = 'ALL' "
            CALL q_imce141_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca203  #顯示到畫面上
            LET g_qryparam.where = ""

            NEXT FIELD imca203                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca203
            #add-point:BEFORE FIELD imca203 name="construct.b.imca203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca203
            
            #add-point:AFTER FIELD imca203 name="construct.a.imca203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca204
            #add-point:ON ACTION controlp INFIELD imca204 name="construct.c.imca204"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "imcfsite = 'ALL' "
            CALL q_imcf011_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca204  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca204                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca204
            #add-point:BEFORE FIELD imca204 name="construct.b.imca204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca204
            
            #add-point:AFTER FIELD imca204 name="construct.a.imca204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca205
            #add-point:ON ACTION controlp INFIELD imca205 name="construct.c.imca205"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "imcgsite = 'ALL' "
            CALL q_imcg111_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca205  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca205                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca205
            #add-point:BEFORE FIELD imca205 name="construct.b.imca205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca205
            
            #add-point:AFTER FIELD imca205 name="construct.a.imca205"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca206
            #add-point:BEFORE FIELD imca206 name="construct.b.imca206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca206
            
            #add-point:AFTER FIELD imca206 name="construct.a.imca206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca206
            #add-point:ON ACTION controlp INFIELD imca206 name="construct.c.imca206"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "imchsite = 'ALL' "
            CALL q_imch011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca206  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca206  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca207
            #add-point:BEFORE FIELD imca207 name="construct.b.imca207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca207
            
            #add-point:AFTER FIELD imca207 name="construct.a.imca207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca207
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca207
            #add-point:ON ACTION controlp INFIELD imca207 name="construct.c.imca207"
            #160617-00009#1---s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = " 207 "
            CALL q_oocq002()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca207        #顯示到畫面上 
            NEXT FIELD imca207                           #返回原欄位
            #160617-00009#1---e---
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca208
            #add-point:BEFORE FIELD imca208 name="construct.b.imca208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca208
            
            #add-point:AFTER FIELD imca208 name="construct.a.imca208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca208
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca208
            #add-point:ON ACTION controlp INFIELD imca208 name="construct.c.imca208"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "imccsite = 'ALL' "
            CALL q_imcp011()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca208        #顯示到畫面上 
            NEXT FIELD imca208                           #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcastus
            #add-point:BEFORE FIELD imcastus name="construct.b.imcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcastus
            
            #add-point:AFTER FIELD imcastus name="construct.a.imcastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcastus
            #add-point:ON ACTION controlp INFIELD imcastus name="construct.c.imcastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imca126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca126
            #add-point:ON ACTION controlp INFIELD imca126 name="construct.c.imca126"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2002" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca126  #顯示到畫面上

            NEXT FIELD imca126                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca126
            #add-point:BEFORE FIELD imca126 name="construct.b.imca126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca126
            
            #add-point:AFTER FIELD imca126 name="construct.a.imca126"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca127
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca127
            #add-point:ON ACTION controlp INFIELD imca127 name="construct.c.imca127"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2003" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca127  #顯示到畫面上

            NEXT FIELD imca127                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca127
            #add-point:BEFORE FIELD imca127 name="construct.b.imca127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca127
            
            #add-point:AFTER FIELD imca127 name="construct.a.imca127"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca131
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca131
            #add-point:ON ACTION controlp INFIELD imca131 name="construct.c.imca131"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2001" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca131  #顯示到畫面上

            NEXT FIELD imca131                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca131
            #add-point:BEFORE FIELD imca131 name="construct.b.imca131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca131
            
            #add-point:AFTER FIELD imca131 name="construct.a.imca131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca128
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca128
            #add-point:ON ACTION controlp INFIELD imca128 name="construct.c.imca128"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2004" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca128  #顯示到畫面上

            NEXT FIELD imca128                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca128
            #add-point:BEFORE FIELD imca128 name="construct.b.imca128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca128
            
            #add-point:AFTER FIELD imca128 name="construct.a.imca128"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca129
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca129
            #add-point:ON ACTION controlp INFIELD imca129 name="construct.c.imca129"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2005" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca129  #顯示到畫面上

            NEXT FIELD imca129                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca129
            #add-point:BEFORE FIELD imca129 name="construct.b.imca129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca129
            
            #add-point:AFTER FIELD imca129 name="construct.a.imca129"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca130
            #add-point:BEFORE FIELD imca130 name="construct.b.imca130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca130
            
            #add-point:AFTER FIELD imca130 name="construct.a.imca130"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca130
            #add-point:ON ACTION controlp INFIELD imca130 name="construct.c.imca130"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imca132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca132
            #add-point:ON ACTION controlp INFIELD imca132 name="construct.c.imca132"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2006" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca132  #顯示到畫面上

            NEXT FIELD imca132                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca132
            #add-point:BEFORE FIELD imca132 name="construct.b.imca132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca132
            
            #add-point:AFTER FIELD imca132 name="construct.a.imca132"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca133
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca133
            #add-point:ON ACTION controlp INFIELD imca133 name="construct.c.imca133"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2007" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca133  #顯示到畫面上

            NEXT FIELD imca133                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca133
            #add-point:BEFORE FIELD imca133 name="construct.b.imca133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca133
            
            #add-point:AFTER FIELD imca133 name="construct.a.imca133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca134
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca134
            #add-point:ON ACTION controlp INFIELD imca134 name="construct.c.imca134"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2008" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca134  #顯示到畫面上

            NEXT FIELD imca134                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca134
            #add-point:BEFORE FIELD imca134 name="construct.b.imca134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca134
            
            #add-point:AFTER FIELD imca134 name="construct.a.imca134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca135
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca135
            #add-point:ON ACTION controlp INFIELD imca135 name="construct.c.imca135"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2009" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca135  #顯示到畫面上

            NEXT FIELD imca135                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca135
            #add-point:BEFORE FIELD imca135 name="construct.b.imca135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca135
            
            #add-point:AFTER FIELD imca135 name="construct.a.imca135"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca136
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca136
            #add-point:ON ACTION controlp INFIELD imca136 name="construct.c.imca136"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2010" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca136  #顯示到畫面上

            NEXT FIELD imca136                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca136
            #add-point:BEFORE FIELD imca136 name="construct.b.imca136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca136
            
            #add-point:AFTER FIELD imca136 name="construct.a.imca136"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca137
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca137
            #add-point:ON ACTION controlp INFIELD imca137 name="construct.c.imca137"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2011"#應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca137  #顯示到畫面上

            NEXT FIELD imca137                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca137
            #add-point:BEFORE FIELD imca137 name="construct.b.imca137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca137
            
            #add-point:AFTER FIELD imca137 name="construct.a.imca137"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca138
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca138
            #add-point:ON ACTION controlp INFIELD imca138 name="construct.c.imca138"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2012" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca138  #顯示到畫面上

            NEXT FIELD imca138                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca138
            #add-point:BEFORE FIELD imca138 name="construct.b.imca138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca138
            
            #add-point:AFTER FIELD imca138 name="construct.a.imca138"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca139
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca139
            #add-point:ON ACTION controlp INFIELD imca139 name="construct.c.imca139"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2013" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca139  #顯示到畫面上

            NEXT FIELD imca139                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca139
            #add-point:BEFORE FIELD imca139 name="construct.b.imca139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca139
            
            #add-point:AFTER FIELD imca139 name="construct.a.imca139"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca140
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca140
            #add-point:ON ACTION controlp INFIELD imca140 name="construct.c.imca140"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2014" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca140  #顯示到畫面上

            NEXT FIELD imca140                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca140
            #add-point:BEFORE FIELD imca140 name="construct.b.imca140"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca140
            
            #add-point:AFTER FIELD imca140 name="construct.a.imca140"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca141
            #add-point:ON ACTION controlp INFIELD imca141 name="construct.c.imca141"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2015" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca141  #顯示到畫面上

            NEXT FIELD imca141                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca141
            #add-point:BEFORE FIELD imca141 name="construct.b.imca141"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca141
            
            #add-point:AFTER FIELD imca141 name="construct.a.imca141"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcaownid
            #add-point:ON ACTION controlp INFIELD imcaownid name="construct.c.imcaownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcaownid  #顯示到畫面上

            NEXT FIELD imcaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcaownid
            #add-point:BEFORE FIELD imcaownid name="construct.b.imcaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcaownid
            
            #add-point:AFTER FIELD imcaownid name="construct.a.imcaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcaowndp
            #add-point:ON ACTION controlp INFIELD imcaowndp name="construct.c.imcaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcaowndp  #顯示到畫面上

            NEXT FIELD imcaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcaowndp
            #add-point:BEFORE FIELD imcaowndp name="construct.b.imcaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcaowndp
            
            #add-point:AFTER FIELD imcaowndp name="construct.a.imcaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcacrtid
            #add-point:ON ACTION controlp INFIELD imcacrtid name="construct.c.imcacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcacrtid  #顯示到畫面上

            NEXT FIELD imcacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcacrtid
            #add-point:BEFORE FIELD imcacrtid name="construct.b.imcacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcacrtid
            
            #add-point:AFTER FIELD imcacrtid name="construct.a.imcacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcacrtdp
            #add-point:ON ACTION controlp INFIELD imcacrtdp name="construct.c.imcacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcacrtdp  #顯示到畫面上

            NEXT FIELD imcacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcacrtdp
            #add-point:BEFORE FIELD imcacrtdp name="construct.b.imcacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcacrtdp
            
            #add-point:AFTER FIELD imcacrtdp name="construct.a.imcacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcacrtdt
            #add-point:BEFORE FIELD imcacrtdt name="construct.b.imcacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcamodid
            #add-point:ON ACTION controlp INFIELD imcamodid name="construct.c.imcamodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcamodid  #顯示到畫面上

            NEXT FIELD imcamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcamodid
            #add-point:BEFORE FIELD imcamodid name="construct.b.imcamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcamodid
            
            #add-point:AFTER FIELD imcamodid name="construct.a.imcamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcamoddt
            #add-point:BEFORE FIELD imcamoddt name="construct.b.imcamoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca011
            #add-point:BEFORE FIELD imca011 name="construct.b.imca011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca011
            
            #add-point:AFTER FIELD imca011 name="construct.a.imca011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca011
            #add-point:ON ACTION controlp INFIELD imca011 name="construct.c.imca011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca012
            #add-point:BEFORE FIELD imca012 name="construct.b.imca012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca012
            
            #add-point:AFTER FIELD imca012 name="construct.a.imca012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca012
            #add-point:ON ACTION controlp INFIELD imca012 name="construct.c.imca012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca013
            #add-point:BEFORE FIELD imca013 name="construct.b.imca013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca013
            
            #add-point:AFTER FIELD imca013 name="construct.a.imca013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca013
            #add-point:ON ACTION controlp INFIELD imca013 name="construct.c.imca013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca014
            #add-point:BEFORE FIELD imca014 name="construct.b.imca014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca014
            
            #add-point:AFTER FIELD imca014 name="construct.a.imca014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca014
            #add-point:ON ACTION controlp INFIELD imca014 name="construct.c.imca014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imca018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca018
            #add-point:ON ACTION controlp INFIELD imca018 name="construct.c.imca018"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '3' "
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca018  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca018                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca018
            #add-point:BEFORE FIELD imca018 name="construct.b.imca018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca018
            
            #add-point:AFTER FIELD imca018 name="construct.a.imca018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca022
            #add-point:ON ACTION controlp INFIELD imca022 name="construct.c.imca022"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '2' "
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca022  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca022                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca022
            #add-point:BEFORE FIELD imca022 name="construct.b.imca022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca022
            
            #add-point:AFTER FIELD imca022 name="construct.a.imca022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca024
            #add-point:BEFORE FIELD imca024 name="construct.b.imca024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca024
            
            #add-point:AFTER FIELD imca024 name="construct.a.imca024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca024
            #add-point:ON ACTION controlp INFIELD imca024 name="construct.c.imca024"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca024  #顯示到畫面上

            NEXT FIELD imca024                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca026
            #add-point:BEFORE FIELD imca026 name="construct.b.imca026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca026
            
            #add-point:AFTER FIELD imca026 name="construct.a.imca026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca026
            #add-point:ON ACTION controlp INFIELD imca026 name="construct.c.imca026"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca026  #顯示到畫面上

            NEXT FIELD imca026                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca027
            #add-point:BEFORE FIELD imca027 name="construct.b.imca027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca027
            
            #add-point:AFTER FIELD imca027 name="construct.a.imca027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca027
            #add-point:ON ACTION controlp INFIELD imca027 name="construct.c.imca027"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imca029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca029
            #add-point:ON ACTION controlp INFIELD imca029 name="construct.c.imca029"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '5' "
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca029  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca029                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca029
            #add-point:BEFORE FIELD imca029 name="construct.b.imca029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca029
            
            #add-point:AFTER FIELD imca029 name="construct.a.imca029"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca030
            #add-point:BEFORE FIELD imca030 name="construct.b.imca030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca030
            
            #add-point:AFTER FIELD imca030 name="construct.a.imca030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca030
            #add-point:ON ACTION controlp INFIELD imca030 name="construct.c.imca030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imca032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca032
            #add-point:ON ACTION controlp INFIELD imca032 name="construct.c.imca032"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '3' "
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca032  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca032                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca032
            #add-point:BEFORE FIELD imca032 name="construct.b.imca032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca032
            
            #add-point:AFTER FIELD imca032 name="construct.a.imca032"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca033
            #add-point:BEFORE FIELD imca033 name="construct.b.imca033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca033
            
            #add-point:AFTER FIELD imca033 name="construct.a.imca033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca033
            #add-point:ON ACTION controlp INFIELD imca033 name="construct.c.imca033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca036
            #add-point:BEFORE FIELD imca036 name="construct.b.imca036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca036
            
            #add-point:AFTER FIELD imca036 name="construct.a.imca036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca036
            #add-point:ON ACTION controlp INFIELD imca036 name="construct.c.imca036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca037
            #add-point:BEFORE FIELD imca037 name="construct.b.imca037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca037
            
            #add-point:AFTER FIELD imca037 name="construct.a.imca037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca037
            #add-point:ON ACTION controlp INFIELD imca037 name="construct.c.imca037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca038
            #add-point:BEFORE FIELD imca038 name="construct.b.imca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca038
            
            #add-point:AFTER FIELD imca038 name="construct.a.imca038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca038
            #add-point:ON ACTION controlp INFIELD imca038 name="construct.c.imca038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca043
            #add-point:BEFORE FIELD imca043 name="construct.b.imca043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca043
            
            #add-point:AFTER FIELD imca043 name="construct.a.imca043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca043
            #add-point:ON ACTION controlp INFIELD imca043 name="construct.c.imca043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca041
            #add-point:BEFORE FIELD imca041 name="construct.b.imca041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca041
            
            #add-point:AFTER FIELD imca041 name="construct.a.imca041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca041
            #add-point:ON ACTION controlp INFIELD imca041 name="construct.c.imca041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca042
            #add-point:BEFORE FIELD imca042 name="construct.b.imca042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca042
            
            #add-point:AFTER FIELD imca042 name="construct.a.imca042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca042
            #add-point:ON ACTION controlp INFIELD imca042 name="construct.c.imca042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca044
            #add-point:BEFORE FIELD imca044 name="construct.b.imca044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca044
            
            #add-point:AFTER FIELD imca044 name="construct.a.imca044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca044
            #add-point:ON ACTION controlp INFIELD imca044 name="construct.c.imca044"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imca122
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca122
            #add-point:ON ACTION controlp INFIELD imca122 name="construct.c.imca122"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2000"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca122  #顯示到畫面上

            NEXT FIELD imca122                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca122
            #add-point:BEFORE FIELD imca122 name="construct.b.imca122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca122
            
            #add-point:AFTER FIELD imca122 name="construct.a.imca122"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca045
            #add-point:ON ACTION controlp INFIELD imca045 name="construct.c.imca045"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imca045  #顯示到畫面上

            NEXT FIELD imca045                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca045
            #add-point:BEFORE FIELD imca045 name="construct.b.imca045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca045
            
            #add-point:AFTER FIELD imca045 name="construct.a.imca045"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca123
            #add-point:BEFORE FIELD imca123 name="construct.b.imca123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca123
            
            #add-point:AFTER FIELD imca123 name="construct.a.imca123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca123
            #add-point:ON ACTION controlp INFIELD imca123 name="construct.c.imca123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca003
            #add-point:BEFORE FIELD imca003 name="construct.b.imca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca003
            
            #add-point:AFTER FIELD imca003 name="construct.a.imca003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca003
            #add-point:ON ACTION controlp INFIELD imca003 name="construct.c.imca003"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON imcj002,imcj003,imcj004,imcj005,imcj006
           FROM s_detail1[1].imcj002,s_detail1[1].imcj003,s_detail1[1].imcj004,s_detail1[1].imcj005, 
               s_detail1[1].imcj006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.imcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcj002
            #add-point:ON ACTION controlp INFIELD imcj002 name="construct.c.page1.imcj002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "270" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcj002  #顯示到畫面上

            NEXT FIELD imcj002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcj002
            #add-point:BEFORE FIELD imcj002 name="construct.b.page1.imcj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcj002
            
            #add-point:AFTER FIELD imcj002 name="construct.a.page1.imcj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imcj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcj003
            #add-point:ON ACTION controlp INFIELD imcj003 name="construct.c.page1.imcj003"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "271" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcj003  #顯示到畫面上

            NEXT FIELD imcj003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcj003
            #add-point:BEFORE FIELD imcj003 name="construct.b.page1.imcj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcj003
            
            #add-point:AFTER FIELD imcj003 name="construct.a.page1.imcj003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcj004
            #add-point:BEFORE FIELD imcj004 name="construct.b.page1.imcj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcj004
            
            #add-point:AFTER FIELD imcj004 name="construct.a.page1.imcj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imcj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcj004
            #add-point:ON ACTION controlp INFIELD imcj004 name="construct.c.page1.imcj004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imcj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcj005
            #add-point:ON ACTION controlp INFIELD imcj005 name="construct.c.page1.imcj005"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcj005  #顯示到畫面上

            NEXT FIELD imcj005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcj005
            #add-point:BEFORE FIELD imcj005 name="construct.b.page1.imcj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcj005
            
            #add-point:AFTER FIELD imcj005 name="construct.a.page1.imcj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imcj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcj006
            #add-point:ON ACTION controlp INFIELD imcj006 name="construct.c.page1.imcj006"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "272" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcj006  #顯示到畫面上

            NEXT FIELD imcj006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcj006
            #add-point:BEFORE FIELD imcj006 name="construct.b.page1.imcj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcj006
            
            #add-point:AFTER FIELD imcj006 name="construct.a.page1.imcj006"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON imcn002,imcn003
           FROM s_detail2[1].imcn002,s_detail2[1].imcn003
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.imcn002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcn002
            #add-point:ON ACTION controlp INFIELD imcn002 name="construct.c.page2.imcn002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imeb004_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcn002  #顯示到畫面上
   
            NEXT FIELD imcn002                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcn002
            #add-point:BEFORE FIELD imcn002 name="construct.b.page2.imcn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcn002
            
            #add-point:AFTER FIELD imcn002 name="construct.a.page2.imcn002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imcn003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcn003
            #add-point:ON ACTION controlp INFIELD imcn003 name="construct.c.page2.imcn003"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imec003_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcn003  #顯示到畫面上
            NEXT FIELD imcn003                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcn003
            #add-point:BEFORE FIELD imcn003 name="construct.b.page2.imcn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcn003
            
            #add-point:AFTER FIELD imcn003 name="construct.a.page2.imcn003"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON imcl002
           FROM s_detail3[1].imcl002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page3.imcl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcl002
            #add-point:ON ACTION controlp INFIELD imcl002 name="construct.c.page3.imcl002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "213" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcl002  #顯示到畫面上

            NEXT FIELD imcl002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcl002
            #add-point:BEFORE FIELD imcl002 name="construct.b.page3.imcl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcl002
            
            #add-point:AFTER FIELD imcl002 name="construct.a.page3.imcl002"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON imcm002,imcm005,imcm003,imcm006
           FROM s_detail4[1].imcm002,s_detail4[1].imcm005,s_detail4[1].imcm003,s_detail4[1].imcm006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcm002
            #add-point:BEFORE FIELD imcm002 name="construct.b.page4.imcm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcm002
            
            #add-point:AFTER FIELD imcm002 name="construct.a.page4.imcm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.imcm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcm002
            #add-point:ON ACTION controlp INFIELD imcm002 name="construct.c.page4.imcm002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcm005
            #add-point:BEFORE FIELD imcm005 name="construct.b.page4.imcm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcm005
            
            #add-point:AFTER FIELD imcm005 name="construct.a.page4.imcm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.imcm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcm005
            #add-point:ON ACTION controlp INFIELD imcm005 name="construct.c.page4.imcm005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcm003
            #add-point:BEFORE FIELD imcm003 name="construct.b.page4.imcm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcm003
            
            #add-point:AFTER FIELD imcm003 name="construct.a.page4.imcm003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.imcm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcm003
            #add-point:ON ACTION controlp INFIELD imcm003 name="construct.c.page4.imcm003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcm006
            #add-point:BEFORE FIELD imcm006 name="construct.b.page4.imcm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcm006
            
            #add-point:AFTER FIELD imcm006 name="construct.a.page4.imcm006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.imcm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcm006
            #add-point:ON ACTION controlp INFIELD imcm006 name="construct.c.page4.imcm006"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table5 ON imco002
           FROM s_detail5[1].imco002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body5.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 5)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page5.imco002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imco002
            #add-point:ON ACTION controlp INFIELD imco002 name="construct.c.page5.imco002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imco002  #顯示到畫面上

            NEXT FIELD imco002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imco002
            #add-point:BEFORE FIELD imco002 name="construct.b.page5.imco002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imco002
            
            #add-point:AFTER FIELD imco002 name="construct.a.page5.imco002"
            
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
 
            INITIALIZE g_wc2_table5 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "imca_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imcj_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imcn_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "imcl_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "imcm_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "imco_t" 
                     LET g_wc2_table5 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimi100_filter()
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
      CONSTRUCT g_wc_filter ON imca001,imca004,imca005,imca006,imca010
                          FROM s_browse[1].b_imca001,s_browse[1].b_imca004,s_browse[1].b_imca005,s_browse[1].b_imca006, 
                              s_browse[1].b_imca010
 
         BEFORE CONSTRUCT
               DISPLAY aimi100_filter_parser('imca001') TO s_browse[1].b_imca001
            DISPLAY aimi100_filter_parser('imca004') TO s_browse[1].b_imca004
            DISPLAY aimi100_filter_parser('imca005') TO s_browse[1].b_imca005
            DISPLAY aimi100_filter_parser('imca006') TO s_browse[1].b_imca006
            DISPLAY aimi100_filter_parser('imca010') TO s_browse[1].b_imca010
      
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
 
      CALL aimi100_filter_show('imca001')
   CALL aimi100_filter_show('imca004')
   CALL aimi100_filter_show('imca005')
   CALL aimi100_filter_show('imca006')
   CALL aimi100_filter_show('imca010')
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimi100_filter_parser(ps_field)
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
 
{<section id="aimi100.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimi100_filter_show(ps_field)
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
   LET ls_condition = aimi100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimi100_query()
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
   CALL g_imcj_d.clear()
   CALL g_imcj2_d.clear()
   CALL g_imcj3_d.clear()
   CALL g_imcj4_d.clear()
   CALL g_imcj5_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aimi100_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimi100_browser_fill("")
      CALL aimi100_fetch("")
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
   LET g_detail_idx_list[5] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aimi100_filter_show('imca001')
   CALL aimi100_filter_show('imca004')
   CALL aimi100_filter_show('imca005')
   CALL aimi100_filter_show('imca006')
   CALL aimi100_filter_show('imca010')
   CALL aimi100_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aimi100_fetch("F") 
      #顯示單身筆數
      CALL aimi100_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimi100_fetch(p_flag)
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
   
   LET g_imca_m.imca001 = g_browser[g_current_idx].b_imca001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aimi100_master_referesh USING g_imca_m.imca001 INTO g_imca_m.imca001,g_imca_m.imca004,g_imca_m.imca005, 
       g_imca_m.imca006,g_imca_m.imca010,g_imca_m.imca201,g_imca_m.imca202,g_imca_m.imca203,g_imca_m.imca204, 
       g_imca_m.imca205,g_imca_m.imca206,g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus,g_imca_m.imca126, 
       g_imca_m.imca127,g_imca_m.imca131,g_imca_m.imca128,g_imca_m.imca129,g_imca_m.imca130,g_imca_m.imca132, 
       g_imca_m.imca133,g_imca_m.imca134,g_imca_m.imca135,g_imca_m.imca136,g_imca_m.imca137,g_imca_m.imca138, 
       g_imca_m.imca139,g_imca_m.imca140,g_imca_m.imca141,g_imca_m.imcaownid,g_imca_m.imcaowndp,g_imca_m.imcacrtid, 
       g_imca_m.imcacrtdp,g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamoddt,g_imca_m.imca011, 
       g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca022,g_imca_m.imca024, 
       g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca033, 
       g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042, 
       g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045,g_imca_m.imca123,g_imca_m.imca003,g_imca_m.imca001_desc, 
       g_imca_m.imca005_desc,g_imca_m.imca006_desc,g_imca_m.imca010_desc,g_imca_m.imca201_desc,g_imca_m.imca202_desc, 
       g_imca_m.imca203_desc,g_imca_m.imca204_desc,g_imca_m.imca205_desc,g_imca_m.imca206_desc,g_imca_m.imca207_desc, 
       g_imca_m.imca208_desc,g_imca_m.imca126_desc,g_imca_m.imca127_desc,g_imca_m.imca131_desc,g_imca_m.imca128_desc, 
       g_imca_m.imca129_desc,g_imca_m.imca132_desc,g_imca_m.imca133_desc,g_imca_m.imca134_desc,g_imca_m.imca135_desc, 
       g_imca_m.imca136_desc,g_imca_m.imca137_desc,g_imca_m.imca138_desc,g_imca_m.imca139_desc,g_imca_m.imca140_desc, 
       g_imca_m.imca141_desc,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid_desc, 
       g_imca_m.imcacrtdp_desc,g_imca_m.imcamodid_desc,g_imca_m.imca018_desc,g_imca_m.imca022_desc,g_imca_m.imca029_desc, 
       g_imca_m.imca032_desc,g_imca_m.imca122_desc,g_imca_m.imca045_desc
   
   #遮罩相關處理
   LET g_imca_m_mask_o.* =  g_imca_m.*
   CALL aimi100_imca_t_mask()
   LET g_imca_m_mask_n.* =  g_imca_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimi100_set_act_visible()   
   CALL aimi100_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_imca_m.imcastus = 'N'  THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete", TRUE)
   END IF  
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_imca_m_t.* = g_imca_m.*
   LET g_imca_m_o.* = g_imca_m.*
   
   LET g_data_owner = g_imca_m.imcaownid      
   LET g_data_dept  = g_imca_m.imcaowndp
   
   #重新顯示   
   CALL aimi100_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimi100_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_imcj_d.clear()   
   CALL g_imcj2_d.clear()  
   CALL g_imcj3_d.clear()  
   CALL g_imcj4_d.clear()  
   CALL g_imcj5_d.clear()  
 
 
   INITIALIZE g_imca_m.* TO NULL             #DEFAULT 設定
   
   LET g_imca001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imca_m.imcaownid = g_user
      LET g_imca_m.imcaowndp = g_dept
      LET g_imca_m.imcacrtid = g_user
      LET g_imca_m.imcacrtdp = g_dept 
      LET g_imca_m.imcacrtdt = cl_get_current()
      LET g_imca_m.imcamodid = g_user
      LET g_imca_m.imcamoddt = cl_get_current()
      LET g_imca_m.imcastus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imca_m.imca004 = "M"
      LET g_imca_m.imcastus = "Y"
      LET g_imca_m.imca011 = "0"
      LET g_imca_m.imca012 = "Y"
      LET g_imca_m.imca027 = "N"
      LET g_imca_m.imca030 = "0"
      LET g_imca_m.imca033 = "0"
      LET g_imca_m.imca036 = "N"
      LET g_imca_m.imca037 = "N"
      LET g_imca_m.imca038 = "N"
      LET g_imca_m.imca043 = "N"
      LET g_imca_m.imca044 = "3"
      LET g_imca_m.imca003 = "99"
 
  
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_imca_m_t.* TO NULL
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_imca_m_t.* = g_imca_m.*
      LET g_imca_m_o.* = g_imca_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imca_m.imcastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL aimi100_input("a")
      
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
         INITIALIZE g_imca_m.* TO NULL
         INITIALIZE g_imcj_d TO NULL
         INITIALIZE g_imcj2_d TO NULL
         INITIALIZE g_imcj3_d TO NULL
         INITIALIZE g_imcj4_d TO NULL
         INITIALIZE g_imcj5_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aimi100_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_imcj_d.clear()
      #CALL g_imcj2_d.clear()
      #CALL g_imcj3_d.clear()
      #CALL g_imcj4_d.clear()
      #CALL g_imcj5_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimi100_set_act_visible()   
   CALL aimi100_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imca001_t = g_imca_m.imca001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imcaent = " ||g_enterprise|| " AND",
                      " imca001 = '", g_imca_m.imca001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aimi100_cl
   
   CALL aimi100_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimi100_master_referesh USING g_imca_m.imca001 INTO g_imca_m.imca001,g_imca_m.imca004,g_imca_m.imca005, 
       g_imca_m.imca006,g_imca_m.imca010,g_imca_m.imca201,g_imca_m.imca202,g_imca_m.imca203,g_imca_m.imca204, 
       g_imca_m.imca205,g_imca_m.imca206,g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus,g_imca_m.imca126, 
       g_imca_m.imca127,g_imca_m.imca131,g_imca_m.imca128,g_imca_m.imca129,g_imca_m.imca130,g_imca_m.imca132, 
       g_imca_m.imca133,g_imca_m.imca134,g_imca_m.imca135,g_imca_m.imca136,g_imca_m.imca137,g_imca_m.imca138, 
       g_imca_m.imca139,g_imca_m.imca140,g_imca_m.imca141,g_imca_m.imcaownid,g_imca_m.imcaowndp,g_imca_m.imcacrtid, 
       g_imca_m.imcacrtdp,g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamoddt,g_imca_m.imca011, 
       g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca022,g_imca_m.imca024, 
       g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca033, 
       g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042, 
       g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045,g_imca_m.imca123,g_imca_m.imca003,g_imca_m.imca001_desc, 
       g_imca_m.imca005_desc,g_imca_m.imca006_desc,g_imca_m.imca010_desc,g_imca_m.imca201_desc,g_imca_m.imca202_desc, 
       g_imca_m.imca203_desc,g_imca_m.imca204_desc,g_imca_m.imca205_desc,g_imca_m.imca206_desc,g_imca_m.imca207_desc, 
       g_imca_m.imca208_desc,g_imca_m.imca126_desc,g_imca_m.imca127_desc,g_imca_m.imca131_desc,g_imca_m.imca128_desc, 
       g_imca_m.imca129_desc,g_imca_m.imca132_desc,g_imca_m.imca133_desc,g_imca_m.imca134_desc,g_imca_m.imca135_desc, 
       g_imca_m.imca136_desc,g_imca_m.imca137_desc,g_imca_m.imca138_desc,g_imca_m.imca139_desc,g_imca_m.imca140_desc, 
       g_imca_m.imca141_desc,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid_desc, 
       g_imca_m.imcacrtdp_desc,g_imca_m.imcamodid_desc,g_imca_m.imca018_desc,g_imca_m.imca022_desc,g_imca_m.imca029_desc, 
       g_imca_m.imca032_desc,g_imca_m.imca122_desc,g_imca_m.imca045_desc
   
   
   #遮罩相關處理
   LET g_imca_m_mask_o.* =  g_imca_m.*
   CALL aimi100_imca_t_mask()
   LET g_imca_m_mask_n.* =  g_imca_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imca_m.imca001,g_imca_m.imca001_desc,g_imca_m.imca004,g_imca_m.imca005,g_imca_m.imca005_desc, 
       g_imca_m.imca006,g_imca_m.imca006_desc,g_imca_m.imca010,g_imca_m.imca010_desc,g_imca_m.imca201, 
       g_imca_m.imca201_desc,g_imca_m.imca202,g_imca_m.imca202_desc,g_imca_m.imca203,g_imca_m.imca203_desc, 
       g_imca_m.imca204,g_imca_m.imca204_desc,g_imca_m.imca205,g_imca_m.imca205_desc,g_imca_m.imca206, 
       g_imca_m.imca206_desc,g_imca_m.imca207,g_imca_m.imca207_desc,g_imca_m.imca208,g_imca_m.imca208_desc, 
       g_imca_m.imcastus,g_imca_m.imca126,g_imca_m.imca126_desc,g_imca_m.imca127,g_imca_m.imca127_desc, 
       g_imca_m.imca131,g_imca_m.imca131_desc,g_imca_m.imca128,g_imca_m.imca128_desc,g_imca_m.imca129, 
       g_imca_m.imca129_desc,g_imca_m.imca130,g_imca_m.imca132,g_imca_m.imca132_desc,g_imca_m.imca133, 
       g_imca_m.imca133_desc,g_imca_m.imca134,g_imca_m.imca134_desc,g_imca_m.imca135,g_imca_m.imca135_desc, 
       g_imca_m.imca136,g_imca_m.imca136_desc,g_imca_m.imca137,g_imca_m.imca137_desc,g_imca_m.imca138, 
       g_imca_m.imca138_desc,g_imca_m.imca139,g_imca_m.imca139_desc,g_imca_m.imca140,g_imca_m.imca140_desc, 
       g_imca_m.imca141,g_imca_m.imca141_desc,g_imca_m.imcaownid,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp, 
       g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid,g_imca_m.imcacrtid_desc,g_imca_m.imcacrtdp,g_imca_m.imcacrtdp_desc, 
       g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamodid_desc,g_imca_m.imcamoddt,g_imca_m.imca011, 
       g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca018_desc,g_imca_m.imca022, 
       g_imca_m.imca022_desc,g_imca_m.imca024,g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca029_desc, 
       g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca032_desc,g_imca_m.imca033,g_imca_m.imca036,g_imca_m.imca037, 
       g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042,g_imca_m.imca044,g_imca_m.imca122, 
       g_imca_m.imca122_desc,g_imca_m.imca045,g_imca_m.imca045_desc,g_imca_m.imca123,g_imca_m.imca003 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_imca_m.imcaownid      
   LET g_data_dept  = g_imca_m.imcaowndp
   
   #功能已完成,通報訊息中心
   CALL aimi100_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimi100_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
   DEFINE l_wc2_table5   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_imca_m_t.* = g_imca_m.*
   LET g_imca_m_o.* = g_imca_m.*
   
   IF g_imca_m.imca001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_imca001_t = g_imca_m.imca001
 
   CALL s_transaction_begin()
   
   OPEN aimi100_cl USING g_enterprise,g_imca_m.imca001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi100_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aimi100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi100_master_referesh USING g_imca_m.imca001 INTO g_imca_m.imca001,g_imca_m.imca004,g_imca_m.imca005, 
       g_imca_m.imca006,g_imca_m.imca010,g_imca_m.imca201,g_imca_m.imca202,g_imca_m.imca203,g_imca_m.imca204, 
       g_imca_m.imca205,g_imca_m.imca206,g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus,g_imca_m.imca126, 
       g_imca_m.imca127,g_imca_m.imca131,g_imca_m.imca128,g_imca_m.imca129,g_imca_m.imca130,g_imca_m.imca132, 
       g_imca_m.imca133,g_imca_m.imca134,g_imca_m.imca135,g_imca_m.imca136,g_imca_m.imca137,g_imca_m.imca138, 
       g_imca_m.imca139,g_imca_m.imca140,g_imca_m.imca141,g_imca_m.imcaownid,g_imca_m.imcaowndp,g_imca_m.imcacrtid, 
       g_imca_m.imcacrtdp,g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamoddt,g_imca_m.imca011, 
       g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca022,g_imca_m.imca024, 
       g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca033, 
       g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042, 
       g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045,g_imca_m.imca123,g_imca_m.imca003,g_imca_m.imca001_desc, 
       g_imca_m.imca005_desc,g_imca_m.imca006_desc,g_imca_m.imca010_desc,g_imca_m.imca201_desc,g_imca_m.imca202_desc, 
       g_imca_m.imca203_desc,g_imca_m.imca204_desc,g_imca_m.imca205_desc,g_imca_m.imca206_desc,g_imca_m.imca207_desc, 
       g_imca_m.imca208_desc,g_imca_m.imca126_desc,g_imca_m.imca127_desc,g_imca_m.imca131_desc,g_imca_m.imca128_desc, 
       g_imca_m.imca129_desc,g_imca_m.imca132_desc,g_imca_m.imca133_desc,g_imca_m.imca134_desc,g_imca_m.imca135_desc, 
       g_imca_m.imca136_desc,g_imca_m.imca137_desc,g_imca_m.imca138_desc,g_imca_m.imca139_desc,g_imca_m.imca140_desc, 
       g_imca_m.imca141_desc,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid_desc, 
       g_imca_m.imcacrtdp_desc,g_imca_m.imcamodid_desc,g_imca_m.imca018_desc,g_imca_m.imca022_desc,g_imca_m.imca029_desc, 
       g_imca_m.imca032_desc,g_imca_m.imca122_desc,g_imca_m.imca045_desc
   
   #檢查是否允許此動作
   IF NOT aimi100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imca_m_mask_o.* =  g_imca_m.*
   CALL aimi100_imca_t_mask()
   LET g_imca_m_mask_n.* =  g_imca_m.*
   
   
   
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
 
   #LET l_wc2_table5 = g_wc2_table5
   #LET l_wc2_table5 = " 1=1"
 
 
 
   
   CALL aimi100_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
   #LET  g_wc2_table5 = l_wc2_table5 
 
 
 
    
   WHILE TRUE
      LET g_imca001_t = g_imca_m.imca001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_imca_m.imcamodid = g_user 
LET g_imca_m.imcamoddt = cl_get_current()
LET g_imca_m.imcamodid_desc = cl_get_username(g_imca_m.imcamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aimi100_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE imca_t SET (imcamodid,imcamoddt) = (g_imca_m.imcamodid,g_imca_m.imcamoddt)
          WHERE imcaent = g_enterprise AND imca001 = g_imca001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_imca_m.* = g_imca_m_t.*
            CALL aimi100_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_imca_m.imca001 != g_imca_m_t.imca001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE imcj_t SET imcj001 = g_imca_m.imca001
 
          WHERE imcjent = g_enterprise AND imcj001 = g_imca_m_t.imca001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imcj_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imcj_t:",SQLERRMESSAGE 
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
         
         UPDATE imcn_t
            SET imcn001 = g_imca_m.imca001
 
          WHERE imcnent = g_enterprise AND
                imcn001 = g_imca001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imcn_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imcn_t:",SQLERRMESSAGE 
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
         
         UPDATE imcl_t
            SET imcl001 = g_imca_m.imca001
 
          WHERE imclent = g_enterprise AND
                imcl001 = g_imca001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imcl_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imcl_t:",SQLERRMESSAGE 
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
         
         UPDATE imcm_t
            SET imcm001 = g_imca_m.imca001
 
          WHERE imcment = g_enterprise AND
                imcm001 = g_imca001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imcm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imcm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update5"
         
         #end add-point
         
         UPDATE imco_t
            SET imco001 = g_imca_m.imca001
 
          WHERE imcoent = g_enterprise AND
                imco001 = g_imca001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update5"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imco_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imco_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update5"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimi100_set_act_visible()   
   CALL aimi100_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imcaent = " ||g_enterprise|| " AND",
                      " imca001 = '", g_imca_m.imca001, "' "
 
   #填到對應位置
   CALL aimi100_browser_fill("")
 
   CLOSE aimi100_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi100_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aimi100.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimi100_input(p_cmd)
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
   DISPLAY BY NAME g_imca_m.imca001,g_imca_m.imca001_desc,g_imca_m.imca004,g_imca_m.imca005,g_imca_m.imca005_desc, 
       g_imca_m.imca006,g_imca_m.imca006_desc,g_imca_m.imca010,g_imca_m.imca010_desc,g_imca_m.imca201, 
       g_imca_m.imca201_desc,g_imca_m.imca202,g_imca_m.imca202_desc,g_imca_m.imca203,g_imca_m.imca203_desc, 
       g_imca_m.imca204,g_imca_m.imca204_desc,g_imca_m.imca205,g_imca_m.imca205_desc,g_imca_m.imca206, 
       g_imca_m.imca206_desc,g_imca_m.imca207,g_imca_m.imca207_desc,g_imca_m.imca208,g_imca_m.imca208_desc, 
       g_imca_m.imcastus,g_imca_m.imca126,g_imca_m.imca126_desc,g_imca_m.imca127,g_imca_m.imca127_desc, 
       g_imca_m.imca131,g_imca_m.imca131_desc,g_imca_m.imca128,g_imca_m.imca128_desc,g_imca_m.imca129, 
       g_imca_m.imca129_desc,g_imca_m.imca130,g_imca_m.imca132,g_imca_m.imca132_desc,g_imca_m.imca133, 
       g_imca_m.imca133_desc,g_imca_m.imca134,g_imca_m.imca134_desc,g_imca_m.imca135,g_imca_m.imca135_desc, 
       g_imca_m.imca136,g_imca_m.imca136_desc,g_imca_m.imca137,g_imca_m.imca137_desc,g_imca_m.imca138, 
       g_imca_m.imca138_desc,g_imca_m.imca139,g_imca_m.imca139_desc,g_imca_m.imca140,g_imca_m.imca140_desc, 
       g_imca_m.imca141,g_imca_m.imca141_desc,g_imca_m.imcaownid,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp, 
       g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid,g_imca_m.imcacrtid_desc,g_imca_m.imcacrtdp,g_imca_m.imcacrtdp_desc, 
       g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamodid_desc,g_imca_m.imcamoddt,g_imca_m.imca011, 
       g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca018_desc,g_imca_m.imca022, 
       g_imca_m.imca022_desc,g_imca_m.imca024,g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca029_desc, 
       g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca032_desc,g_imca_m.imca033,g_imca_m.imca036,g_imca_m.imca037, 
       g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042,g_imca_m.imca044,g_imca_m.imca122, 
       g_imca_m.imca122_desc,g_imca_m.imca045,g_imca_m.imca045_desc,g_imca_m.imca123,g_imca_m.imca003 
 
   
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
   LET g_forupd_sql = "SELECT imcj002,imcj003,imcj004,imcj005,imcj006 FROM imcj_t WHERE imcjent=? AND  
       imcj001=? AND imcj002=? AND imcj003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi100_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT imcn002,imcn003 FROM imcn_t WHERE imcnent=? AND imcn001=? AND imcn002=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi100_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT imcl002 FROM imcl_t WHERE imclent=? AND imcl001=? AND imcl002=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi100_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT imcm002,imcm005,imcm003,imcm006,imcm004 FROM imcm_t WHERE imcment=? AND  
       imcm001=? AND imcm002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi100_bcl4 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql5"
   
   #end add-point    
   LET g_forupd_sql = "SELECT imco002 FROM imco_t WHERE imcoent=? AND imco001=? AND imco002=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql5"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi100_bcl5 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aimi100_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   LET g_errshow = 1 
   #end add-point
   CALL aimi100_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_imca_m.imca001,g_imca_m.imca004,g_imca_m.imca005,g_imca_m.imca006,g_imca_m.imca010, 
       g_imca_m.imca201,g_imca_m.imca202,g_imca_m.imca203,g_imca_m.imca204,g_imca_m.imca205,g_imca_m.imca206, 
       g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus,g_imca_m.imca126,g_imca_m.imca127,g_imca_m.imca131, 
       g_imca_m.imca128,g_imca_m.imca129,g_imca_m.imca130,g_imca_m.imca132,g_imca_m.imca133,g_imca_m.imca134, 
       g_imca_m.imca135,g_imca_m.imca136,g_imca_m.imca137,g_imca_m.imca138,g_imca_m.imca139,g_imca_m.imca140, 
       g_imca_m.imca141,g_imca_m.imca011,g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018, 
       g_imca_m.imca022,g_imca_m.imca024,g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca030, 
       g_imca_m.imca032,g_imca_m.imca033,g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043, 
       g_imca_m.imca041,g_imca_m.imca042,g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045,g_imca_m.imca123, 
       g_imca_m.imca003
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aimi100.input.head" >}
      #單頭段
      INPUT BY NAME g_imca_m.imca001,g_imca_m.imca004,g_imca_m.imca005,g_imca_m.imca006,g_imca_m.imca010, 
          g_imca_m.imca201,g_imca_m.imca202,g_imca_m.imca203,g_imca_m.imca204,g_imca_m.imca205,g_imca_m.imca206, 
          g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus,g_imca_m.imca126,g_imca_m.imca127,g_imca_m.imca131, 
          g_imca_m.imca128,g_imca_m.imca129,g_imca_m.imca130,g_imca_m.imca132,g_imca_m.imca133,g_imca_m.imca134, 
          g_imca_m.imca135,g_imca_m.imca136,g_imca_m.imca137,g_imca_m.imca138,g_imca_m.imca139,g_imca_m.imca140, 
          g_imca_m.imca141,g_imca_m.imca011,g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018, 
          g_imca_m.imca022,g_imca_m.imca024,g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca030, 
          g_imca_m.imca032,g_imca_m.imca033,g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043, 
          g_imca_m.imca041,g_imca_m.imca042,g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045,g_imca_m.imca123, 
          g_imca_m.imca003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aimi100_cl USING g_enterprise,g_imca_m.imca001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimi100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimi100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aimi100_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF p_cmd = 'a' THEN
               LET g_imca_m.imca001 = ''
               LET g_imca_m.imca001_desc = ''
               DISPLAY BY NAME g_imca_m.imca001,g_imca_m.imca001_desc
               LET g_imca_m.imcamodid = NULL
               LET g_imca_m.imcamodid_desc = NULL
               LET g_imca_m.imcamoddt = NULL
               LET g_imca_m.imcastus = "Y"
               DISPLAY BY NAME g_imca_m.imcamodid,g_imca_m.imcamodid_desc,g_imca_m.imcamoddt,g_imca_m.imcastus
            END IF
            #end add-point
            CALL aimi100_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca001
            
            #add-point:AFTER FIELD imca001 name="input.a.imca001"
            #此段落由子樣板a05產生
            DISPLAY "" TO imca001_desc
            IF NOT cl_null(g_imca_m.imca001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imca_m.imca001 != g_imca001_t ))) THEN 
                  IF NOT ap_chk_notDup(g_imca_m.imca001,"SELECT COUNT(*) FROM imca_t WHERE "||"imcaent = '" ||g_enterprise|| "' AND "||"imca001 = '"||g_imca_m.imca001 ||"'",'std-00004',0) THEN 
                     LET g_imca_m.imca001 = g_imca001_t
                     CALL aimi100_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT s_azzi650_chk_exist('200',g_imca_m.imca001) THEN
                  LET g_imca_m.imca001 = g_imca001_t
                  CALL aimi100_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL aimi100_desc()
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca001
            #add-point:BEFORE FIELD imca001 name="input.b.imca001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca001
            #add-point:ON CHANGE imca001 name="input.g.imca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca004
            #add-point:BEFORE FIELD imca004 name="input.b.imca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca004
            
            #add-point:AFTER FIELD imca004 name="input.a.imca004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca004
            #add-point:ON CHANGE imca004 name="input.g.imca004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca005
            
            #add-point:AFTER FIELD imca005 name="input.a.imca005"
            DISPLAY "" TO imca005_desc
            IF NOT cl_null(g_imca_m.imca005) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imca_m.imca005
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00159:sub-01302|aimi092|",cl_get_progname("aimi092",g_lang,"2"),"|:EXEPROGaimi092"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imea001") THEN
                   LET g_imca_m.imca005 = g_imca_m_t.imca005 
                  CALL aimi100_desc()
                  NEXT FIELD imca005
               END IF
            END IF
            CALL aimi100_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca005
            #add-point:BEFORE FIELD imca005 name="input.b.imca005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca005
            #add-point:ON CHANGE imca005 name="input.g.imca005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca006
            
            #add-point:AFTER FIELD imca006 name="input.a.imca006"
            DISPLAY "" TO imca006_desc
            IF NOT cl_null(g_imca_m.imca006) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imca_m.imca006
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_imca_m.imca006 = g_imca_m_t.imca006 
                  CALL aimi100_desc()
                  NEXT FIELD imca006
               END IF
            END IF
            
            CALL aimi100_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca006
            #add-point:BEFORE FIELD imca006 name="input.b.imca006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca006
            #add-point:ON CHANGE imca006 name="input.g.imca006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca010
            
            #add-point:AFTER FIELD imca010 name="input.a.imca010"
            DISPLAY "" TO imca010_desc
            IF NOT cl_null(g_imca_m.imca010) THEN 
               IF NOT s_azzi650_chk_exist('210',g_imca_m.imca010) THEN
                  LET g_imca_m.imca010 = g_imca_m_t.imca010
                  CALL aimi100_desc()
                  NEXT FIELD imca010
               END IF
            END IF
            CALL aimi100_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca010
            #add-point:BEFORE FIELD imca010 name="input.b.imca010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca010
            #add-point:ON CHANGE imca010 name="input.g.imca010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca201
            
            #add-point:AFTER FIELD imca201 name="input.a.imca201"
          
            DISPLAY "" TO imca201_desc
            IF NOT cl_null(g_imca_m.imca201) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imca_m.imca201
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00045:sub-01302|aimi102|",cl_get_progname("aimi102",g_lang,"2"),"|:EXEPROGaimi102"
               #160318-00025#17  by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imcc051") THEN
                  LET g_imca_m.imca201 = g_imca_m_t.imca201 
                  CALL aimi100_desc()
                  NEXT FIELD imca201
               END IF
            END IF
            CALL aimi100_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca201
            #add-point:BEFORE FIELD imca201 name="input.b.imca201"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca201
            #add-point:ON CHANGE imca201 name="input.g.imca201"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca202
            
            #add-point:AFTER FIELD imca202 name="input.a.imca202"
            DISPLAY "" TO imca202_desc
            IF NOT cl_null(g_imca_m.imca202) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imca_m.imca202
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00053:sub-01302|aimi103|",cl_get_progname("aimi103",g_lang,"2"),"|:EXEPROGaimi103"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imcd111") THEN
                  LET g_imca_m.imca202 = g_imca_m_t.imca202 
                  CALL aimi100_desc()
                  NEXT FIELD imca202
               END IF
            END IF
            
            CALL aimi100_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca202
            #add-point:BEFORE FIELD imca202 name="input.b.imca202"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca202
            #add-point:ON CHANGE imca202 name="input.g.imca202"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca203
            
            #add-point:AFTER FIELD imca203 name="input.a.imca203"
            DISPLAY "" TO imca203_desc
            IF NOT cl_null(g_imca_m.imca203) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imca_m.imca203
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00049:sub-01302|aimi104|",cl_get_progname("aimi104",g_lang,"2"),"|:EXEPROGaimi104"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imce141") THEN
                  LET g_imca_m.imca203 = g_imca_m_t.imca203 
                  CALL aimi100_desc()
                  NEXT FIELD imca203
               END IF
            END IF
            
            CALL aimi100_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca203
            #add-point:BEFORE FIELD imca203 name="input.b.imca203"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca203
            #add-point:ON CHANGE imca203 name="input.g.imca203"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca204
            
            #add-point:AFTER FIELD imca204 name="input.a.imca204"
            DISPLAY "" TO imca204_desc
            IF NOT cl_null(g_imca_m.imca204) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imca_m.imca204
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00051:sub-01302|aimi105|",cl_get_progname("aimi105",g_lang,"2"),"|:EXEPROGaimi105"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imcf011") THEN
                  LET g_imca_m.imca204 = g_imca_m_t.imca204
                  CALL aimi100_desc()
                  NEXT FIELD imca204
               END IF
            END IF
            CALL aimi100_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca204
            #add-point:BEFORE FIELD imca204 name="input.b.imca204"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca204
            #add-point:ON CHANGE imca204 name="input.g.imca204"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca205
            
            #add-point:AFTER FIELD imca205 name="input.a.imca205"
            DISPLAY "" TO imca205_desc
            IF NOT cl_null(g_imca_m.imca205) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imca_m.imca205
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00043:sub-01302|aimi106|",cl_get_progname("aimi106",g_lang,"2"),"|:EXEPROGaimi106"
               #160318-00025#17  by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imcg111") THEN
                  LET g_imca_m.imca205 = g_imca_m_t.imca205 
                  CALL aimi100_desc()
                  NEXT FIELD imca205
               END IF
            END IF
            CALL aimi100_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca205
            #add-point:BEFORE FIELD imca205 name="input.b.imca205"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca205
            #add-point:ON CHANGE imca205 name="input.g.imca205"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca206
            
            #add-point:AFTER FIELD imca206 name="input.a.imca206"
            LET g_imca_m.imca206_desc = ''
            DISPLAY BY NAME g_imca_m.imca206_desc
            IF NOT cl_null(g_imca_m.imca206) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_imca_m.imca206
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00221:sub-01302|aimi107|",cl_get_progname("aimi107",g_lang,"2"),"|:EXEPROGaimi107"
               #160318-00025#17  by 07900 --add-end
               IF NOT cl_chk_exist("v_imch011") THEN
                  LET g_imca_m.imca206 = g_imca_m_t.imca206
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_acc_desc('206',g_imca_m.imca206) RETURNING g_imca_m.imca206_desc
            DISPLAY BY NAME g_imca_m.imca206_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca206
            #add-point:BEFORE FIELD imca206 name="input.b.imca206"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca206
            #add-point:ON CHANGE imca206 name="input.g.imca206"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca207
            
            #add-point:AFTER FIELD imca207 name="input.a.imca207"
            CALL s_desc_get_acc_desc('207',g_imca_m.imca207) RETURNING g_imca_m.imca207_desc
            DISPLAY BY NAME g_imca_m.imca207_desc
            #160617-00009#1---s---
            IF NOT cl_null(g_imca_m.imca207) THEN
               IF NOT s_azzi650_chk_exist('207',g_imca_m.imca207) THEN
                  LET g_imca_m.imca207 = g_imca_m_t.imca207
                  CALL s_desc_get_acc_desc('207',g_imca_m.imca207) RETURNING g_imca_m.imca207_desc
                  DISPLAY BY NAME g_imca_m.imca207_desc
                  NEXT FIELD imca207
               END IF
            END IF
            #160617-00009#1----e--- 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca207
            #add-point:BEFORE FIELD imca207 name="input.b.imca207"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca207
            #add-point:ON CHANGE imca207 name="input.g.imca207"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca208
            
            #add-point:AFTER FIELD imca208 name="input.a.imca208"
            LET g_imca_m.imca208_desc = ''
            DISPLAY BY NAME g_imca_m.imca208_desc
            IF NOT cl_null(g_imca_m.imca208) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_imca_m.imca208
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00221:sub-01302|aimi107|",cl_get_progname("aimi107",g_lang,"2"),"|:EXEPROGaimi107"
               #160318-00025#17  by 07900 --add-end
               IF NOT cl_chk_exist("v_imcp011") THEN
                  LET g_imca_m.imca208 = g_imca_m_t.imca208
                  NEXT FIELD CURRENT
               END IF
            END IF           
            CALL s_desc_get_acc_desc('229',g_imca_m.imca208) RETURNING g_imca_m.imca208_desc
            DISPLAY BY NAME g_imca_m.imca208_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca208
            #add-point:BEFORE FIELD imca208 name="input.b.imca208"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca208
            #add-point:ON CHANGE imca208 name="input.g.imca208"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcastus
            #add-point:BEFORE FIELD imcastus name="input.b.imcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcastus
            
            #add-point:AFTER FIELD imcastus name="input.a.imcastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcastus
            #add-point:ON CHANGE imcastus name="input.g.imcastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca126
            
            #add-point:AFTER FIELD imca126 name="input.a.imca126"
            CALL aimi100_oocql004_desc('2002',g_imca_m.imca126) RETURNING g_imca_m.imca126_desc
            DISPLAY BY NAME g_imca_m.imca126_desc            
            IF NOT cl_null(g_imca_m.imca126) THEN 
               IF NOT s_azzi650_chk_exist('2002',g_imca_m.imca126) THEN
                  LET g_imca_m.imca126 = g_imca_m_t.imca126 
                  NEXT FIELD imca126
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca126
            #add-point:BEFORE FIELD imca126 name="input.b.imca126"
            CALL aimi100_oocql004_desc('2002',g_imca_m.imca126) RETURNING g_imca_m.imca126_desc
            DISPLAY BY NAME g_imca_m.imca126_desc 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca126
            #add-point:ON CHANGE imca126 name="input.g.imca126"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca127
            
            #add-point:AFTER FIELD imca127 name="input.a.imca127"
            CALL aimi100_oocql004_desc('2003',g_imca_m.imca127) RETURNING g_imca_m.imca127_desc
            DISPLAY BY NAME g_imca_m.imca127_desc             
            IF NOT cl_null(g_imca_m.imca127) THEN 
               IF NOT s_azzi650_chk_exist('2003',g_imca_m.imca127) THEN
                  LET g_imca_m.imca127 = g_imca_m_t.imca127 
                  NEXT FIELD imca127
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca127
            #add-point:BEFORE FIELD imca127 name="input.b.imca127"
            CALL aimi100_oocql004_desc('2003',g_imca_m.imca127) RETURNING g_imca_m.imca127_desc
            DISPLAY BY NAME g_imca_m.imca127_desc 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca127
            #add-point:ON CHANGE imca127 name="input.g.imca127"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca131
            
            #add-point:AFTER FIELD imca131 name="input.a.imca131"
            CALL aimi100_oocql004_desc('2001',g_imca_m.imca131) RETURNING g_imca_m.imca131_desc
            DISPLAY BY NAME g_imca_m.imca131_desc             
            IF NOT cl_null(g_imca_m.imca131) THEN 
               IF NOT s_azzi650_chk_exist('2001',g_imca_m.imca131) THEN
                  LET g_imca_m.imca131 = g_imca_m_t.imca131 
                  NEXT FIELD imca131
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca131
            #add-point:BEFORE FIELD imca131 name="input.b.imca131"
            CALL aimi100_oocql004_desc('2001',g_imca_m.imca131) RETURNING g_imca_m.imca131_desc
            DISPLAY BY NAME g_imca_m.imca131_desc  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca131
            #add-point:ON CHANGE imca131 name="input.g.imca131"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca128
            
            #add-point:AFTER FIELD imca128 name="input.a.imca128"
            CALL aimi100_oocql004_desc('2004',g_imca_m.imca128) RETURNING g_imca_m.imca128_desc
            DISPLAY BY NAME g_imca_m.imca128_desc              
            IF NOT cl_null(g_imca_m.imca128) THEN 
               IF NOT s_azzi650_chk_exist('2004',g_imca_m.imca128) THEN
                  LET g_imca_m.imca128 = g_imca_m_t.imca128 
                  NEXT FIELD imca128
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca128
            #add-point:BEFORE FIELD imca128 name="input.b.imca128"
            CALL aimi100_oocql004_desc('2004',g_imca_m.imca128) RETURNING g_imca_m.imca128_desc
            DISPLAY BY NAME g_imca_m.imca128_desc  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca128
            #add-point:ON CHANGE imca128 name="input.g.imca128"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca129
            
            #add-point:AFTER FIELD imca129 name="input.a.imca129"
            CALL aimi100_oocql004_desc('2005',g_imca_m.imca129) RETURNING g_imca_m.imca129_desc
            DISPLAY BY NAME g_imca_m.imca129_desc  
            IF NOT cl_null(g_imca_m.imca129) THEN  
               IF NOT s_azzi650_chk_exist('2005',g_imca_m.imca129) THEN
                  LET g_imca_m.imca129 = g_imca_m_t.imca129 
                  NEXT FIELD imca129
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca129
            #add-point:BEFORE FIELD imca129 name="input.b.imca129"
            CALL aimi100_oocql004_desc('2005',g_imca_m.imca129) RETURNING g_imca_m.imca129_desc
            DISPLAY BY NAME g_imca_m.imca129_desc  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca129
            #add-point:ON CHANGE imca129 name="input.g.imca129"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca130
            #add-point:BEFORE FIELD imca130 name="input.b.imca130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca130
            
            #add-point:AFTER FIELD imca130 name="input.a.imca130"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca130
            #add-point:ON CHANGE imca130 name="input.g.imca130"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca132
            
            #add-point:AFTER FIELD imca132 name="input.a.imca132"
            CALL aimi100_oocql004_desc('2006',g_imca_m.imca132) RETURNING g_imca_m.imca132_desc
            DISPLAY BY NAME g_imca_m.imca132_desc              
            IF NOT cl_null(g_imca_m.imca132) THEN 
               IF NOT s_azzi650_chk_exist('2006',g_imca_m.imca132) THEN
                  LET g_imca_m.imca132 = g_imca_m_t.imca132 
                  NEXT FIELD imca132
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca132
            #add-point:BEFORE FIELD imca132 name="input.b.imca132"
            CALL aimi100_oocql004_desc('2006',g_imca_m.imca132) RETURNING g_imca_m.imca132_desc
            DISPLAY BY NAME g_imca_m.imca132_desc  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca132
            #add-point:ON CHANGE imca132 name="input.g.imca132"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca133
            
            #add-point:AFTER FIELD imca133 name="input.a.imca133"
            CALL aimi100_oocql004_desc('2007',g_imca_m.imca133) RETURNING g_imca_m.imca133_desc
            DISPLAY BY NAME g_imca_m.imca133_desc              
            IF NOT cl_null(g_imca_m.imca133) THEN 
               IF NOT s_azzi650_chk_exist('2007',g_imca_m.imca133) THEN
                  LET g_imca_m.imca133 = g_imca_m_t.imca133
                  NEXT FIELD imca133
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca133
            #add-point:BEFORE FIELD imca133 name="input.b.imca133"
            CALL aimi100_oocql004_desc('2007',g_imca_m.imca133) RETURNING g_imca_m.imca133_desc
            DISPLAY BY NAME g_imca_m.imca133_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca133
            #add-point:ON CHANGE imca133 name="input.g.imca133"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca134
            
            #add-point:AFTER FIELD imca134 name="input.a.imca134"
            CALL aimi100_oocql004_desc('2008',g_imca_m.imca134) RETURNING g_imca_m.imca134_desc
            DISPLAY BY NAME g_imca_m.imca134_desc            
            IF NOT cl_null(g_imca_m.imca134) THEN 
               IF NOT s_azzi650_chk_exist('2008',g_imca_m.imca134) THEN
                  LET g_imca_m.imca134 = g_imca_m_t.imca134
                  NEXT FIELD imca134
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca134
            #add-point:BEFORE FIELD imca134 name="input.b.imca134"
            CALL aimi100_oocql004_desc('2008',g_imca_m.imca134) RETURNING g_imca_m.imca134_desc
            DISPLAY BY NAME g_imca_m.imca134_desc  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca134
            #add-point:ON CHANGE imca134 name="input.g.imca134"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca135
            
            #add-point:AFTER FIELD imca135 name="input.a.imca135"
            CALL aimi100_oocql004_desc('2009',g_imca_m.imca135) RETURNING g_imca_m.imca135_desc
            DISPLAY BY NAME g_imca_m.imca135_desc              
            IF NOT cl_null(g_imca_m.imca135) THEN 
               IF NOT s_azzi650_chk_exist('2009',g_imca_m.imca135) THEN
                  LET g_imca_m.imca135 = g_imca_m_t.imca135 
                  NEXT FIELD imca135
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca135
            #add-point:BEFORE FIELD imca135 name="input.b.imca135"
            CALL aimi100_oocql004_desc('2009',g_imca_m.imca135) RETURNING g_imca_m.imca135_desc
            DISPLAY BY NAME g_imca_m.imca135_desc  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca135
            #add-point:ON CHANGE imca135 name="input.g.imca135"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca136
            
            #add-point:AFTER FIELD imca136 name="input.a.imca136"
            CALL aimi100_oocql004_desc('2010',g_imca_m.imca136) RETURNING g_imca_m.imca136_desc
            DISPLAY BY NAME g_imca_m.imca136_desc              
            IF NOT cl_null(g_imca_m.imca136) THEN 
               IF NOT s_azzi650_chk_exist('2010',g_imca_m.imca136) THEN
                  LET g_imca_m.imca136 = g_imca_m_t.imca136
                  NEXT FIELD imca136
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca136
            #add-point:BEFORE FIELD imca136 name="input.b.imca136"
            CALL aimi100_oocql004_desc('2010',g_imca_m.imca136) RETURNING g_imca_m.imca136_desc
            DISPLAY BY NAME g_imca_m.imca136_desc 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca136
            #add-point:ON CHANGE imca136 name="input.g.imca136"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca137
            
            #add-point:AFTER FIELD imca137 name="input.a.imca137"
            CALL aimi100_oocql004_desc('2011',g_imca_m.imca137) RETURNING g_imca_m.imca137_desc
            DISPLAY BY NAME g_imca_m.imca137_desc             
            IF NOT cl_null(g_imca_m.imca137) THEN 
               IF NOT s_azzi650_chk_exist('2011',g_imca_m.imca137) THEN
                  LET g_imca_m.imca137 = g_imca_m_t.imca137
                  NEXT FIELD imca137
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca137
            #add-point:BEFORE FIELD imca137 name="input.b.imca137"
            CALL aimi100_oocql004_desc('2011',g_imca_m.imca137) RETURNING g_imca_m.imca137_desc
            DISPLAY BY NAME g_imca_m.imca137_desc 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca137
            #add-point:ON CHANGE imca137 name="input.g.imca137"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca138
            
            #add-point:AFTER FIELD imca138 name="input.a.imca138"
            CALL aimi100_oocql004_desc('2012',g_imca_m.imca138) RETURNING g_imca_m.imca138_desc
            DISPLAY BY NAME g_imca_m.imca138_desc             
            IF NOT cl_null(g_imca_m.imca138) THEN 
               IF NOT s_azzi650_chk_exist('2012',g_imca_m.imca138) THEN
                  LET g_imca_m.imca138 = g_imca_m_t.imca138
                  NEXT FIELD imca138
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca138
            #add-point:BEFORE FIELD imca138 name="input.b.imca138"
            CALL aimi100_oocql004_desc('2012',g_imca_m.imca138) RETURNING g_imca_m.imca138_desc
            DISPLAY BY NAME g_imca_m.imca138_desc 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca138
            #add-point:ON CHANGE imca138 name="input.g.imca138"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca139
            
            #add-point:AFTER FIELD imca139 name="input.a.imca139"
            CALL aimi100_oocql004_desc('2013',g_imca_m.imca139) RETURNING g_imca_m.imca139_desc
            DISPLAY BY NAME g_imca_m.imca139_desc             
            IF NOT cl_null(g_imca_m.imca139) THEN 
               IF NOT s_azzi650_chk_exist('2013',g_imca_m.imca139) THEN
                  LET g_imca_m.imca139 = g_imca_m_t.imca139
                  NEXT FIELD imca139
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca139
            #add-point:BEFORE FIELD imca139 name="input.b.imca139"
            CALL aimi100_oocql004_desc('2013',g_imca_m.imca139) RETURNING g_imca_m.imca139_desc
            DISPLAY BY NAME g_imca_m.imca139_desc  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca139
            #add-point:ON CHANGE imca139 name="input.g.imca139"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca140
            
            #add-point:AFTER FIELD imca140 name="input.a.imca140"
            CALL aimi100_oocql004_desc('2014',g_imca_m.imca140) RETURNING g_imca_m.imca140_desc
            DISPLAY BY NAME g_imca_m.imca140_desc              
            IF NOT cl_null(g_imca_m.imca140) THEN 
               IF NOT s_azzi650_chk_exist('2014',g_imca_m.imca140) THEN
                  LET g_imca_m.imca140 = g_imca_m_t.imca140
                  NEXT FIELD imca140
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca140
            #add-point:BEFORE FIELD imca140 name="input.b.imca140"
            CALL aimi100_oocql004_desc('2014',g_imca_m.imca140) RETURNING g_imca_m.imca140_desc
            DISPLAY BY NAME g_imca_m.imca140_desc 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca140
            #add-point:ON CHANGE imca140 name="input.g.imca140"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca141
            
            #add-point:AFTER FIELD imca141 name="input.a.imca141"
            CALL aimi100_oocql004_desc('2015',g_imca_m.imca141) RETURNING g_imca_m.imca141_desc
            DISPLAY BY NAME g_imca_m.imca141_desc             
            IF NOT cl_null(g_imca_m.imca141) THEN 
               IF NOT s_azzi650_chk_exist('2015',g_imca_m.imca141) THEN
                  LET g_imca_m.imca141 = g_imca_m_t.imca141
                  NEXT FIELD imca141
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca141
            #add-point:BEFORE FIELD imca141 name="input.b.imca141"
            CALL aimi100_oocql004_desc('2015',g_imca_m.imca141) RETURNING g_imca_m.imca141_desc
            DISPLAY BY NAME g_imca_m.imca141_desc  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca141
            #add-point:ON CHANGE imca141 name="input.g.imca141"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca011
            #add-point:BEFORE FIELD imca011 name="input.b.imca011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca011
            
            #add-point:AFTER FIELD imca011 name="input.a.imca011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca011
            #add-point:ON CHANGE imca011 name="input.g.imca011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca012
            #add-point:BEFORE FIELD imca012 name="input.b.imca012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca012
            
            #add-point:AFTER FIELD imca012 name="input.a.imca012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca012
            #add-point:ON CHANGE imca012 name="input.g.imca012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca013
            #add-point:BEFORE FIELD imca013 name="input.b.imca013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca013
            
            #add-point:AFTER FIELD imca013 name="input.a.imca013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca013
            #add-point:ON CHANGE imca013 name="input.g.imca013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca014
            #add-point:BEFORE FIELD imca014 name="input.b.imca014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca014
            
            #add-point:AFTER FIELD imca014 name="input.a.imca014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca014
            #add-point:ON CHANGE imca014 name="input.g.imca014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca018
            
            #add-point:AFTER FIELD imca018 name="input.a.imca018"
            
            DISPLAY "" TO imca018_desc
            IF NOT cl_null(g_imca_m.imca018) THEN 
               CALL aimi100_chk_ooca003(g_imca_m.imca018,'3')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imca_m.imca018
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imca_m.imca018 = g_imca_m_t.imca018 
                  CALL aimi100_desc()
                  NEXT FIELD imca018
               END IF
            END IF
            
            CALL aimi100_desc()
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca018
            #add-point:BEFORE FIELD imca018 name="input.b.imca018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca018
            #add-point:ON CHANGE imca018 name="input.g.imca018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca022
            
            #add-point:AFTER FIELD imca022 name="input.a.imca022"
            DISPLAY "" TO imca022_desc
            IF NOT cl_null(g_imca_m.imca022) THEN 
               CALL aimi100_chk_ooca003(g_imca_m.imca022,'2')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imca_m.imca022
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imca_m.imca022 = g_imca_m_t.imca022 
                  CALL aimi100_desc()
                  NEXT FIELD imca022
               END IF
            END IF
            
            CALL aimi100_desc()
            SELECT ooca006,ooca007 INTO g_imca_m.imca024,g_imca_m.imca026
              FROM ooca_t
             WHERE ooca001 = g_imca_m.imca022
               AND oocaent = g_enterprise
            DISPLAY BY NAME g_imca_m.imca024,g_imca_m.imca026

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca022
            #add-point:BEFORE FIELD imca022 name="input.b.imca022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca022
            #add-point:ON CHANGE imca022 name="input.g.imca022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca024
            #add-point:BEFORE FIELD imca024 name="input.b.imca024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca024
            
            #add-point:AFTER FIELD imca024 name="input.a.imca024"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca024
            #add-point:ON CHANGE imca024 name="input.g.imca024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca026
            #add-point:BEFORE FIELD imca026 name="input.b.imca026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca026
            
            #add-point:AFTER FIELD imca026 name="input.a.imca026"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca026
            #add-point:ON CHANGE imca026 name="input.g.imca026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca027
            #add-point:BEFORE FIELD imca027 name="input.b.imca027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca027
            
            #add-point:AFTER FIELD imca027 name="input.a.imca027"
            CALL aimi100_set_entry(p_cmd)
            CALL aimi100_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca027
            #add-point:ON CHANGE imca027 name="input.g.imca027"
            CALL aimi100_set_entry(p_cmd)
            CALL aimi100_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca029
            
            #add-point:AFTER FIELD imca029 name="input.a.imca029"
            DISPLAY "" TO imca029_desc
            IF NOT cl_null(g_imca_m.imca029) THEN
               CALL aimi100_chk_ooca003(g_imca_m.imca029,'5')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imca_m.imca029
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imca_m.imca029 = g_imca_m_t.imca029 
                  CALL aimi100_desc()
                  NEXT FIELD imca029
               END IF
            END IF
            
            
            CALL aimi100_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca029
            #add-point:BEFORE FIELD imca029 name="input.b.imca029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca029
            #add-point:ON CHANGE imca029 name="input.g.imca029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca030
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imca_m.imca030,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD imca030
            END IF 
 
 
 
            #add-point:AFTER FIELD imca030 name="input.a.imca030"
#            IF NOT cl_null(g_imca_m.imca030) THEN
#               IF g_imca_m.imca030 >100 OR g_imca_m.imca030 <0 THEN
#                  CALL cl_err(g_imca_m.imca030,'aim-00011',1)
#                  LET g_imca_m.imca030 = g_imca_m_t.imca030 
#                  NEXT FIELD imca030
#               END IF
#            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca030
            #add-point:BEFORE FIELD imca030 name="input.b.imca030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca030
            #add-point:ON CHANGE imca030 name="input.g.imca030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca032
            
            #add-point:AFTER FIELD imca032 name="input.a.imca032"
            DISPLAY "" TO imca032_desc
            IF NOT cl_null(g_imca_m.imca032) THEN
               CALL aimi100_chk_ooca003(g_imca_m.imca032,'3')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imca_m.imca032
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imca_m.imca032=g_imca_m_t.imca032
                  CALL aimi100_desc()
                  NEXT FIELD imca032
               END IF
            END IF
            
            
            CALL aimi100_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca032
            #add-point:BEFORE FIELD imca032 name="input.b.imca032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca032
            #add-point:ON CHANGE imca032 name="input.g.imca032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca033
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imca_m.imca033,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD imca033
            END IF 
 
 
 
            #add-point:AFTER FIELD imca033 name="input.a.imca033"
#            IF NOT cl_null(g_imca_m.imca033) THEN
#               IF g_imca_m.imca033 >100 OR g_imca_m.imca033 <0 THEN
#                  CALL cl_err(g_imca_m.imca033,'aim-00011',1)
#                  LET g_imca_m.imca033 = g_imca_m_t.imca033
#                  NEXT FIELD imca033
#               END IF
#            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca033
            #add-point:BEFORE FIELD imca033 name="input.b.imca033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca033
            #add-point:ON CHANGE imca033 name="input.g.imca033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca036
            #add-point:BEFORE FIELD imca036 name="input.b.imca036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca036
            
            #add-point:AFTER FIELD imca036 name="input.a.imca036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca036
            #add-point:ON CHANGE imca036 name="input.g.imca036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca037
            #add-point:BEFORE FIELD imca037 name="input.b.imca037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca037
            
            #add-point:AFTER FIELD imca037 name="input.a.imca037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca037
            #add-point:ON CHANGE imca037 name="input.g.imca037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca038
            #add-point:BEFORE FIELD imca038 name="input.b.imca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca038
            
            #add-point:AFTER FIELD imca038 name="input.a.imca038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca038
            #add-point:ON CHANGE imca038 name="input.g.imca038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca043
            #add-point:BEFORE FIELD imca043 name="input.b.imca043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca043
            
            #add-point:AFTER FIELD imca043 name="input.a.imca043"
        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca043
            #add-point:ON CHANGE imca043 name="input.g.imca043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca041
            #add-point:BEFORE FIELD imca041 name="input.b.imca041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca041
            
            #add-point:AFTER FIELD imca041 name="input.a.imca041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca041
            #add-point:ON CHANGE imca041 name="input.g.imca041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca042
            #add-point:BEFORE FIELD imca042 name="input.b.imca042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca042
            
            #add-point:AFTER FIELD imca042 name="input.a.imca042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca042
            #add-point:ON CHANGE imca042 name="input.g.imca042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca044
            #add-point:BEFORE FIELD imca044 name="input.b.imca044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca044
            
            #add-point:AFTER FIELD imca044 name="input.a.imca044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca044
            #add-point:ON CHANGE imca044 name="input.g.imca044"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca122
            
            #add-point:AFTER FIELD imca122 name="input.a.imca122"
            DISPLAY "" TO imca122_desc
            IF NOT cl_null(g_imca_m.imca122) THEN 
               IF NOT s_azzi650_chk_exist('2000',g_imca_m.imca122) THEN
                  LET g_imca_m.imca122 = g_imca_m_t.imca122 
                  CALL aimi100_desc()
                  NEXT FIELD imca122
               END IF
            END IF
            CALL aimi100_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca122
            #add-point:BEFORE FIELD imca122 name="input.b.imca122"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca122
            #add-point:ON CHANGE imca122 name="input.g.imca122"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca045
            
            #add-point:AFTER FIELD imca045 name="input.a.imca045"
            DISPLAY "" TO imca045_desc
            IF NOT cl_null(g_imca_m.imca045) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imca_m.imca045

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oocg001") THEN
                  LET g_imca_m.imca045= g_imca_m_t.imca045
                  CALL aimi100_desc()
                  NEXT FIELD imca045
               END IF
            END IF

            CALL aimi100_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca045
            #add-point:BEFORE FIELD imca045 name="input.b.imca045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca045
            #add-point:ON CHANGE imca045 name="input.g.imca045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca123
            #add-point:BEFORE FIELD imca123 name="input.b.imca123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca123
            
            #add-point:AFTER FIELD imca123 name="input.a.imca123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca123
            #add-point:ON CHANGE imca123 name="input.g.imca123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imca003
            #add-point:BEFORE FIELD imca003 name="input.b.imca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imca003
            
            #add-point:AFTER FIELD imca003 name="input.a.imca003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imca003
            #add-point:ON CHANGE imca003 name="input.g.imca003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imca001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca001
            #add-point:ON ACTION controlp INFIELD imca001 name="input.c.imca001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "200" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "

            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca001 TO imca001              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca004
            #add-point:ON ACTION controlp INFIELD imca004 name="input.c.imca004"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca005
            #add-point:ON ACTION controlp INFIELD imca005 name="input.c.imca005"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca005             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = "221"   #2014/12/01 by stellar mark

            CALL q_imea001()                                #呼叫開窗

            LET g_imca_m.imca005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca005 TO imca005              #顯示到畫面上
            CALL aimi100_desc()
            NEXT FIELD imca005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca006
            #add-point:ON ACTION controlp INFIELD imca006 name="input.c.imca006"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca006             #給予default值

            #給予arg
            LET g_qryparam.where = "oocastus = 'Y' "
            CALL q_ooca001()                                #呼叫開窗

            LET g_imca_m.imca006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca006 TO imca006              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca010
            #add-point:ON ACTION controlp INFIELD imca010 name="input.c.imca010"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "210" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca010 TO imca010              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca201
            #add-point:ON ACTION controlp INFIELD imca201 name="input.c.imca201"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca201             #給予default值
            LET g_qryparam.default2 = "" #g_imca_m.oocq002 #應用分類碼

            #給予arg
            LET g_qryparam.where = "imccsite = 'ALL' "
            CALL q_imcc051_1()                                #呼叫開窗

            LET g_imca_m.imca201 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_imca_m.oocq002 = g_qryparam.return2 #應用分類碼

            DISPLAY g_imca_m.imca201 TO imca201              #顯示到畫面上
            #DISPLAY g_imca_m.oocq002 TO oocq002 #應用分類碼
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca201                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca202
            #add-point:ON ACTION controlp INFIELD imca202 name="input.c.imca202"
            #此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca202             #給予default值

            #給予arg
            LET g_qryparam.where = "imcdsite= 'ALL' "
            CALL q_imcd111_1()                                #呼叫開窗

            LET g_imca_m.imca202 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca202 TO imca202              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca202                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca203
            #add-point:ON ACTION controlp INFIELD imca203 name="input.c.imca203"
            #此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca203             #給予default值

            #給予arg
            LET g_qryparam.where = "imcesite= 'ALL' "
            CALL q_imce141_1()                                #呼叫開窗

            LET g_imca_m.imca203 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca203 TO imca203              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca203                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca204
            #add-point:ON ACTION controlp INFIELD imca204 name="input.c.imca204"
            #此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca204             #給予default值

            #給予arg
            LET g_qryparam.where = "imcfsite = 'ALL' "
            CALL q_imcf011_1()                                #呼叫開窗
  
            LET g_imca_m.imca204 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca204 TO imca204              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca204                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca205
            #add-point:ON ACTION controlp INFIELD imca205 name="input.c.imca205"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca205             #給予default值

            #給予arg
            LET g_qryparam.where = "imcgsite = 'ALL' "
            CALL q_imcg111_1()                                #呼叫開窗

            LET g_imca_m.imca205 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca205 TO imca205              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca205                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca206
            #add-point:ON ACTION controlp INFIELD imca206 name="input.c.imca206"
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca206            #給予default值

            #給予arg
            LET g_qryparam.where = "imchsite = 'ALL' "
            CALL q_imch011()                                #呼叫開窗

            LET g_imca_m.imca206 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca206 TO imca206              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca206  
            #END add-point
 
 
         #Ctrlp:input.c.imca207
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca207
            #add-point:ON ACTION controlp INFIELD imca207 name="input.c.imca207"
            #160617-00009#1---s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'            
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imca_m.imca207            
            LET g_qryparam.arg1 = "207"
            CALL q_oocq002()                                       
            LET g_imca_m.imca207 = g_qryparam.return1              
            DISPLAY g_imca_m.imca207 TO imca207                    
            CALL s_desc_get_acc_desc('207',g_imca_m.imca207) RETURNING g_imca_m.imca207_desc
            DISPLAY BY NAME g_imca_m.imca207_desc
            NEXT FIELD imca207          
            #160617-00009#1---e---
            #END add-point
 
 
         #Ctrlp:input.c.imca208
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca208
            #add-point:ON ACTION controlp INFIELD imca208 name="input.c.imca208"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'            
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imca_m.imca208            
            LET g_qryparam.where = "imcpsite = 'ALL' "
            CALL q_imcp011()                                       
            LET g_imca_m.imca208 = g_qryparam.return1              
            DISPLAY g_imca_m.imca208 TO imca208                    
            CALL s_desc_get_acc_desc('229',g_imca_m.imca208) RETURNING g_imca_m.imca208_desc
            DISPLAY BY NAME g_imca_m.imca208_desc
            NEXT FIELD imca208             
            #END add-point
 
 
         #Ctrlp:input.c.imcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcastus
            #add-point:ON ACTION controlp INFIELD imcastus name="input.c.imcastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca126
            #add-point:ON ACTION controlp INFIELD imca126 name="input.c.imca126"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca126             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2002" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca126 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca126 TO imca126              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca126                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca127
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca127
            #add-point:ON ACTION controlp INFIELD imca127 name="input.c.imca127"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca127             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2003" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca127 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca127 TO imca127              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca127                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca131
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca131
            #add-point:ON ACTION controlp INFIELD imca131 name="input.c.imca131"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca131             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2001" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca131 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca131 TO imca131              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca131                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca128
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca128
            #add-point:ON ACTION controlp INFIELD imca128 name="input.c.imca128"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca128             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2004" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca128 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca128 TO imca128              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca128                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca129
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca129
            #add-point:ON ACTION controlp INFIELD imca129 name="input.c.imca129"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca129             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2005" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca129 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca129 TO imca129              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca129                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca130
            #add-point:ON ACTION controlp INFIELD imca130 name="input.c.imca130"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca132
            #add-point:ON ACTION controlp INFIELD imca132 name="input.c.imca132"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca132             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2006" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca132 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca132 TO imca132              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca132                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca133
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca133
            #add-point:ON ACTION controlp INFIELD imca133 name="input.c.imca133"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca133             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2007" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca133 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca133 TO imca133              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca133                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca134
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca134
            #add-point:ON ACTION controlp INFIELD imca134 name="input.c.imca134"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca134             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2008" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca134 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca134 TO imca134              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca134                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca135
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca135
            #add-point:ON ACTION controlp INFIELD imca135 name="input.c.imca135"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca135             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2009" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca135 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca135 TO imca135              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca135                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca136
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca136
            #add-point:ON ACTION controlp INFIELD imca136 name="input.c.imca136"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca136             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2010" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca136 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca136 TO imca136              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca136                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca137
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca137
            #add-point:ON ACTION controlp INFIELD imca137 name="input.c.imca137"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca137             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2011" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca137 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca137 TO imca137              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca137                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca138
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca138
            #add-point:ON ACTION controlp INFIELD imca138 name="input.c.imca138"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca138             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2012" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca138 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca138 TO imca138              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca138                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca139
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca139
            #add-point:ON ACTION controlp INFIELD imca139 name="input.c.imca139"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca139             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2013" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca139 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca139 TO imca139              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca139                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca140
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca140
            #add-point:ON ACTION controlp INFIELD imca140 name="input.c.imca140"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca140             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2014" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca140 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca140 TO imca140              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca140                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca141
            #add-point:ON ACTION controlp INFIELD imca141 name="input.c.imca141"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca141             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2015" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca141 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca141 TO imca141              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca141                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca011
            #add-point:ON ACTION controlp INFIELD imca011 name="input.c.imca011"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca012
            #add-point:ON ACTION controlp INFIELD imca012 name="input.c.imca012"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca013
            #add-point:ON ACTION controlp INFIELD imca013 name="input.c.imca013"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca014
            #add-point:ON ACTION controlp INFIELD imca014 name="input.c.imca014"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca018
            #add-point:ON ACTION controlp INFIELD imca018 name="input.c.imca018"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca018             #給予default值

            #給予arg
            LET g_qryparam.where = "oocastus = 'Y' AND ooca003 = '3' "
            CALL q_ooca001()                                #呼叫開窗

            LET g_imca_m.imca018 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca018 TO imca018              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca022
            #add-point:ON ACTION controlp INFIELD imca022 name="input.c.imca022"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca022             #給予default值
            LET g_qryparam.where = "oocastus = 'Y' AND ooca003 = '2' "
            #給予arg

            CALL q_ooca001()                                #呼叫開窗

            LET g_imca_m.imca022 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca022 TO imca022              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca024
            #add-point:ON ACTION controlp INFIELD imca024 name="input.c.imca024"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca024             #給予default值

            #給予arg
            CALL q_ooca001()                                #呼叫開窗

            LET g_imca_m.imca024 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca024 TO imca024              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca026
            #add-point:ON ACTION controlp INFIELD imca026 name="input.c.imca026"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca026             #給予default值

            #給予arg
            CALL q_ooca001()                                #呼叫開窗

            LET g_imca_m.imca026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca026 TO imca026              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imca026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca027
            #add-point:ON ACTION controlp INFIELD imca027 name="input.c.imca027"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca029
            #add-point:ON ACTION controlp INFIELD imca029 name="input.c.imca029"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca029             #給予default值

            #給予arg
            LET g_qryparam.where = "oocastus = 'Y' AND ooca003 = '5' "
            CALL q_ooca001()                                #呼叫開窗

            LET g_imca_m.imca029 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca029 TO imca029              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca030
            #add-point:ON ACTION controlp INFIELD imca030 name="input.c.imca030"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca032
            #add-point:ON ACTION controlp INFIELD imca032 name="input.c.imca032"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca032             #給予default值

            #給予arg
            LET g_qryparam.where = "oocastus = 'Y' AND ooca003 = '3' "
            CALL q_ooca001()                                #呼叫開窗

            LET g_imca_m.imca032 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca032 TO imca032              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca033
            #add-point:ON ACTION controlp INFIELD imca033 name="input.c.imca033"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca036
            #add-point:ON ACTION controlp INFIELD imca036 name="input.c.imca036"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca037
            #add-point:ON ACTION controlp INFIELD imca037 name="input.c.imca037"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca038
            #add-point:ON ACTION controlp INFIELD imca038 name="input.c.imca038"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca043
            #add-point:ON ACTION controlp INFIELD imca043 name="input.c.imca043"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca041
            #add-point:ON ACTION controlp INFIELD imca041 name="input.c.imca041"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca042
            #add-point:ON ACTION controlp INFIELD imca042 name="input.c.imca042"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca044
            #add-point:ON ACTION controlp INFIELD imca044 name="input.c.imca044"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca122
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca122
            #add-point:ON ACTION controlp INFIELD imca122 name="input.c.imca122"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca122             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2000" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_imca_m.imca122 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca122 TO imca122              #顯示到畫面上
            CALL aimi100_desc()
            NEXT FIELD imca122                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca045
            #add-point:ON ACTION controlp INFIELD imca045 name="input.c.imca045"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imca_m.imca045             #給予default值

            #給予arg
            LET g_qryparam.where = "oocgstus = 'Y' "
            CALL q_oocg001()                                #呼叫開窗

            LET g_imca_m.imca045 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imca_m.imca045 TO imca045              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_desc()
            NEXT FIELD imca045                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imca123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca123
            #add-point:ON ACTION controlp INFIELD imca123 name="input.c.imca123"
            
            #END add-point
 
 
         #Ctrlp:input.c.imca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imca003
            #add-point:ON ACTION controlp INFIELD imca003 name="input.c.imca003"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_imca_m.imca001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO imca_t (imcaent,imca001,imca004,imca005,imca006,imca010,imca201,imca202,imca203, 
                   imca204,imca205,imca206,imca207,imca208,imcastus,imca126,imca127,imca131,imca128, 
                   imca129,imca130,imca132,imca133,imca134,imca135,imca136,imca137,imca138,imca139,imca140, 
                   imca141,imcaownid,imcaowndp,imcacrtid,imcacrtdp,imcacrtdt,imcamodid,imcamoddt,imca011, 
                   imca012,imca013,imca014,imca018,imca022,imca024,imca026,imca027,imca029,imca030,imca032, 
                   imca033,imca036,imca037,imca038,imca043,imca041,imca042,imca044,imca122,imca045,imca123, 
                   imca003)
               VALUES (g_enterprise,g_imca_m.imca001,g_imca_m.imca004,g_imca_m.imca005,g_imca_m.imca006, 
                   g_imca_m.imca010,g_imca_m.imca201,g_imca_m.imca202,g_imca_m.imca203,g_imca_m.imca204, 
                   g_imca_m.imca205,g_imca_m.imca206,g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus, 
                   g_imca_m.imca126,g_imca_m.imca127,g_imca_m.imca131,g_imca_m.imca128,g_imca_m.imca129, 
                   g_imca_m.imca130,g_imca_m.imca132,g_imca_m.imca133,g_imca_m.imca134,g_imca_m.imca135, 
                   g_imca_m.imca136,g_imca_m.imca137,g_imca_m.imca138,g_imca_m.imca139,g_imca_m.imca140, 
                   g_imca_m.imca141,g_imca_m.imcaownid,g_imca_m.imcaowndp,g_imca_m.imcacrtid,g_imca_m.imcacrtdp, 
                   g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamoddt,g_imca_m.imca011,g_imca_m.imca012, 
                   g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca022,g_imca_m.imca024, 
                   g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca030,g_imca_m.imca032, 
                   g_imca_m.imca033,g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043, 
                   g_imca_m.imca041,g_imca_m.imca042,g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045, 
                   g_imca_m.imca123,g_imca_m.imca003) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_imca_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
                  #INS imcn_t料件主分群特徵檔
                  IF NOT cl_null(g_imca_m.imca005) THEN
                     CALL aimi100_ins_imcn() RETURNING l_success
                     IF NOT l_success  THEN
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF
                  END IF
                  
                  IF NOT cl_null(g_imca_m.imca006) THEN  #160620-00023#1 add
                     INSERT INTO imco_t(imcoent,imco001,imco002)
                                 VALUES(g_enterprise,g_imca_m.imca001,g_imca_m.imca006)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ins imco_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  END IF #160620-00023#1 add
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aimi100_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aimi100_b_fill()
                  CALL aimi100_b_fill2('0')
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
               CALL aimi100_imca_t_mask_restore('restore_mask_o')
               
               UPDATE imca_t SET (imca001,imca004,imca005,imca006,imca010,imca201,imca202,imca203,imca204, 
                   imca205,imca206,imca207,imca208,imcastus,imca126,imca127,imca131,imca128,imca129, 
                   imca130,imca132,imca133,imca134,imca135,imca136,imca137,imca138,imca139,imca140,imca141, 
                   imcaownid,imcaowndp,imcacrtid,imcacrtdp,imcacrtdt,imcamodid,imcamoddt,imca011,imca012, 
                   imca013,imca014,imca018,imca022,imca024,imca026,imca027,imca029,imca030,imca032,imca033, 
                   imca036,imca037,imca038,imca043,imca041,imca042,imca044,imca122,imca045,imca123,imca003) = (g_imca_m.imca001, 
                   g_imca_m.imca004,g_imca_m.imca005,g_imca_m.imca006,g_imca_m.imca010,g_imca_m.imca201, 
                   g_imca_m.imca202,g_imca_m.imca203,g_imca_m.imca204,g_imca_m.imca205,g_imca_m.imca206, 
                   g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus,g_imca_m.imca126,g_imca_m.imca127, 
                   g_imca_m.imca131,g_imca_m.imca128,g_imca_m.imca129,g_imca_m.imca130,g_imca_m.imca132, 
                   g_imca_m.imca133,g_imca_m.imca134,g_imca_m.imca135,g_imca_m.imca136,g_imca_m.imca137, 
                   g_imca_m.imca138,g_imca_m.imca139,g_imca_m.imca140,g_imca_m.imca141,g_imca_m.imcaownid, 
                   g_imca_m.imcaowndp,g_imca_m.imcacrtid,g_imca_m.imcacrtdp,g_imca_m.imcacrtdt,g_imca_m.imcamodid, 
                   g_imca_m.imcamoddt,g_imca_m.imca011,g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014, 
                   g_imca_m.imca018,g_imca_m.imca022,g_imca_m.imca024,g_imca_m.imca026,g_imca_m.imca027, 
                   g_imca_m.imca029,g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca033,g_imca_m.imca036, 
                   g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042, 
                   g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045,g_imca_m.imca123,g_imca_m.imca003) 
 
                WHERE imcaent = g_enterprise AND imca001 = g_imca001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "imca_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aimi100_imca_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_imca_m_t)
               LET g_log2 = util.JSON.stringify(g_imca_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               IF NOT cl_null(g_imca_m.imca005) THEN
                  CALL aimi100_ins_imcn() RETURNING l_success
                  IF NOT l_success  THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
               END IF
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_imca001_t = g_imca_m.imca001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aimi100.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_imcj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imcj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimi100_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_imcj_d.getLength()
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
            OPEN aimi100_cl USING g_enterprise,g_imca_m.imca001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimi100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimi100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imcj_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imcj_d[l_ac].imcj002 IS NOT NULL
               AND g_imcj_d[l_ac].imcj003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_imcj_d_t.* = g_imcj_d[l_ac].*  #BACKUP
               LET g_imcj_d_o.* = g_imcj_d[l_ac].*  #BACKUP
               CALL aimi100_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aimi100_set_no_entry_b(l_cmd)
               IF NOT aimi100_lock_b("imcj_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimi100_bcl INTO g_imcj_d[l_ac].imcj002,g_imcj_d[l_ac].imcj003,g_imcj_d[l_ac].imcj004, 
                      g_imcj_d[l_ac].imcj005,g_imcj_d[l_ac].imcj006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_imcj_d_t.imcj002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imcj_d_mask_o[l_ac].* =  g_imcj_d[l_ac].*
                  CALL aimi100_imcj_t_mask()
                  LET g_imcj_d_mask_n[l_ac].* =  g_imcj_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimi100_show()
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
            INITIALIZE g_imcj_d[l_ac].* TO NULL 
            INITIALIZE g_imcj_d_t.* TO NULL 
            INITIALIZE g_imcj_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_imcj_d_t.* = g_imcj_d[l_ac].*     #新輸入資料
            LET g_imcj_d_o.* = g_imcj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimi100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aimi100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imcj_d[li_reproduce_target].* = g_imcj_d[li_reproduce].*
 
               LET g_imcj_d[li_reproduce_target].imcj002 = NULL
               LET g_imcj_d[li_reproduce_target].imcj003 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM imcj_t 
             WHERE imcjent = g_enterprise AND imcj001 = g_imca_m.imca001
 
               AND imcj002 = g_imcj_d[l_ac].imcj002
               AND imcj003 = g_imcj_d[l_ac].imcj003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imca_m.imca001
               LET gs_keys[2] = g_imcj_d[g_detail_idx].imcj002
               LET gs_keys[3] = g_imcj_d[g_detail_idx].imcj003
               CALL aimi100_insert_b('imcj_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_imcj_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imcj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimi100_b_fill()
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
               LET gs_keys[01] = g_imca_m.imca001
 
               LET gs_keys[gs_keys.getLength()+1] = g_imcj_d_t.imcj002
               LET gs_keys[gs_keys.getLength()+1] = g_imcj_d_t.imcj003
 
            
               #刪除同層單身
               IF NOT aimi100_delete_b('imcj_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi100_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimi100_key_delete_b(gs_keys,'imcj_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi100_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aimi100_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_imcj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imcj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcj002
            
            #add-point:AFTER FIELD imcj002 name="input.a.page1.imcj002"
            #此段落由子樣板a05產生
            DISPLAY "" TO s_detail1[l_ac].imcj002_desc 
            IF  NOT cl_null(g_imca_m.imca001) AND NOT cl_null(g_imcj_d[l_ac].imcj002) AND NOT cl_null(g_imcj_d[l_ac].imcj003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imca_m.imca001 != g_imca001_t OR g_imcj_d[l_ac].imcj002 != g_imcj_d_t.imcj002 OR g_imcj_d[l_ac].imcj003 != g_imcj_d_t.imcj003))) THEN 
                  IF NOT ap_chk_notDup(g_imcj_d[l_ac].imcj002,"SELECT COUNT(*) FROM imcj_t WHERE "||"imcjent = '" ||g_enterprise|| "' AND "||"imcj001 = '"||g_imca_m.imca001 ||"' AND "|| "imcj002 = '"||g_imcj_d[l_ac].imcj002 ||"' AND "|| "imcj003 = '"||g_imcj_d[l_ac].imcj003 ||"'",'std-00004',0) THEN 
                     LET g_imcj_d[l_ac].imcj002 = g_imcj_d_t.imcj002
                     CALL aimi100_imcj_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
  
            IF NOT cl_null(g_imcj_d[l_ac].imcj002) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_imcj_d[l_ac].imcj002 != g_imcj_d_t.imcj002) THEN 
                  IF NOT s_azzi650_chk_exist('270',g_imcj_d[l_ac].imcj002) THEN
                     LET g_imcj_d[l_ac].imcj002 = g_imcj_d_t.imcj002
                     CALL aimi100_imcj_desc()
                     NEXT FIELD imcj002
                  END IF
               END IF
            END IF
            CALL aimi100_imcj_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcj002
            #add-point:BEFORE FIELD imcj002 name="input.b.page1.imcj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcj002
            #add-point:ON CHANGE imcj002 name="input.g.page1.imcj002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcj003
            
            #add-point:AFTER FIELD imcj003 name="input.a.page1.imcj003"
            #此段落由子樣板a05產生
            DISPLAY "" TO s_detail1[l_ac].imcj003_desc 
            IF NOT cl_null(g_imca_m.imca001) AND NOT cl_null(g_imcj_d[l_ac].imcj002) AND NOT cl_null(g_imcj_d[l_ac].imcj003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imca_m.imca001 != g_imca001_t OR g_imcj_d[l_ac].imcj002 != g_imcj_d_t.imcj002 OR g_imcj_d[l_ac].imcj003 != g_imcj_d_t.imcj003))) THEN 
                  IF NOT ap_chk_notDup(g_imcj_d[l_ac].imcj003,"SELECT COUNT(*) FROM imcj_t WHERE "||"imcjent = '" ||g_enterprise|| "' AND "||"imcj001 = '"||g_imca_m.imca001 ||"' AND "|| "imcj002 = '"||g_imcj_d[l_ac].imcj002 ||"' AND "|| "imcj003 = '"||g_imcj_d[l_ac].imcj003 ||"'",'std-00004',0) THEN 
                     LET g_imcj_d[l_ac].imcj003 = g_imcj_d_t.imcj003
                     CALL aimi100_imcj_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_imcj_d[l_ac].imcj003) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_imcj_d[l_ac].imcj003 != g_imcj_d_t.imcj003) THEN
                  IF NOT s_azzi650_chk_exist('271',g_imcj_d[l_ac].imcj003) THEN
                     LET g_imcj_d[l_ac].imcj003 = g_imcj_d_t.imcj003
                     CALL aimi100_imcj_desc()
                     NEXT FIELD imcj003
                  END IF               
               END IF
            END IF
            CALL aimi100_imcj_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcj003
            #add-point:BEFORE FIELD imcj003 name="input.b.page1.imcj003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcj003
            #add-point:ON CHANGE imcj003 name="input.g.page1.imcj003"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcj004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcj_d[l_ac].imcj004,"0","1","","","azz-00079",1) THEN
               NEXT FIELD imcj004
            END IF 
 
 
 
            #add-point:AFTER FIELD imcj004 name="input.a.page1.imcj004"
            IF NOT cl_null(g_imcj_d[l_ac].imcj004) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcj004
            #add-point:BEFORE FIELD imcj004 name="input.b.page1.imcj004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcj004
            #add-point:ON CHANGE imcj004 name="input.g.page1.imcj004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcj005
            
            #add-point:AFTER FIELD imcj005 name="input.a.page1.imcj005"
            DISPLAY "" TO s_detail1[l_ac].imcj005_desc 
            IF NOT cl_null(g_imcj_d[l_ac].imcj005) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imcj_d[l_ac].imcj005
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_imcj_d[l_ac].imcj005 = g_imcj_d_t.imcj005  
                  CALL aimi100_imcj_desc()
                  NEXT FIELD imcj005
               END IF
            END IF
            CALL aimi100_imcj_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcj005
            #add-point:BEFORE FIELD imcj005 name="input.b.page1.imcj005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcj005
            #add-point:ON CHANGE imcj005 name="input.g.page1.imcj005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcj006
            
            #add-point:AFTER FIELD imcj006 name="input.a.page1.imcj006"
            DISPLAY "" TO s_detail1[l_ac].imcj006_desc 
            IF NOT cl_null(g_imcj_d[l_ac].imcj006) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_imcj_d[l_ac].imcj006 != g_imcj_d_t.imcj006) THEN 
                  IF NOT s_azzi650_chk_exist('272',g_imcj_d[l_ac].imcj006) THEN
                     LET g_imcj_d[l_ac].imcj006 = g_imcj_d_t.imcj006
                     CALL aimi100_imcj_desc()
                     NEXT FIELD imcj006
                  END IF
               END IF
            END IF
            CALL aimi100_imcj_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcj006
            #add-point:BEFORE FIELD imcj006 name="input.b.page1.imcj006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcj006
            #add-point:ON CHANGE imcj006 name="input.g.page1.imcj006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.imcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcj002
            #add-point:ON ACTION controlp INFIELD imcj002 name="input.c.page1.imcj002"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcj_d[l_ac].imcj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "270" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imcj_d[l_ac].imcj002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcj_d[l_ac].imcj002 TO imcj002              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_imcj_desc()
            NEXT FIELD imcj002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imcj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcj003
            #add-point:ON ACTION controlp INFIELD imcj003 name="input.c.page1.imcj003"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcj_d[l_ac].imcj003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "271" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imcj_d[l_ac].imcj003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcj_d[l_ac].imcj003 TO imcj003              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_imcj_desc()
            NEXT FIELD imcj003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imcj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcj004
            #add-point:ON ACTION controlp INFIELD imcj004 name="input.c.page1.imcj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imcj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcj005
            #add-point:ON ACTION controlp INFIELD imcj005 name="input.c.page1.imcj005"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcj_d[l_ac].imcj005             #給予default值

            #給予arg
            LET g_qryparam.where = "oocastus = 'Y' "
            CALL q_ooca001()                                #呼叫開窗

            LET g_imcj_d[l_ac].imcj005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcj_d[l_ac].imcj005 TO imcj005              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_imcj_desc()
            NEXT FIELD imcj005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imcj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcj006
            #add-point:ON ACTION controlp INFIELD imcj006 name="input.c.page1.imcj006"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcj_d[l_ac].imcj006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "272" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imcj_d[l_ac].imcj006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcj_d[l_ac].imcj006 TO imcj006              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_imcj_desc()
            NEXT FIELD imcj006                          #返回原欄位


            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imcj_d[l_ac].* = g_imcj_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimi100_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_imcj_d[l_ac].imcj002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_imcj_d[l_ac].* = g_imcj_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aimi100_imcj_t_mask_restore('restore_mask_o')
      
               UPDATE imcj_t SET (imcj001,imcj002,imcj003,imcj004,imcj005,imcj006) = (g_imca_m.imca001, 
                   g_imcj_d[l_ac].imcj002,g_imcj_d[l_ac].imcj003,g_imcj_d[l_ac].imcj004,g_imcj_d[l_ac].imcj005, 
                   g_imcj_d[l_ac].imcj006)
                WHERE imcjent = g_enterprise AND imcj001 = g_imca_m.imca001 
 
                  AND imcj002 = g_imcj_d_t.imcj002 #項次   
                  AND imcj003 = g_imcj_d_t.imcj003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imcj_d[l_ac].* = g_imcj_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imcj_d[l_ac].* = g_imcj_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imca_m.imca001
               LET gs_keys_bak[1] = g_imca001_t
               LET gs_keys[2] = g_imcj_d[g_detail_idx].imcj002
               LET gs_keys_bak[2] = g_imcj_d_t.imcj002
               LET gs_keys[3] = g_imcj_d[g_detail_idx].imcj003
               LET gs_keys_bak[3] = g_imcj_d_t.imcj003
               CALL aimi100_update_b('imcj_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aimi100_imcj_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_imcj_d[g_detail_idx].imcj002 = g_imcj_d_t.imcj002 
                  AND g_imcj_d[g_detail_idx].imcj003 = g_imcj_d_t.imcj003 
 
                  ) THEN
                  LET gs_keys[01] = g_imca_m.imca001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_imcj_d_t.imcj002
                  LET gs_keys[gs_keys.getLength()+1] = g_imcj_d_t.imcj003
 
                  CALL aimi100_key_update_b(gs_keys,'imcj_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imca_m),util.JSON.stringify(g_imcj_d_t)
               LET g_log2 = util.JSON.stringify(g_imca_m),util.JSON.stringify(g_imcj_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aimi100_unlock_b("imcj_t","'1'")
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
               LET g_imcj_d[li_reproduce_target].* = g_imcj_d[li_reproduce].*
 
               LET g_imcj_d[li_reproduce_target].imcj002 = NULL
               LET g_imcj_d[li_reproduce_target].imcj003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_imcj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imcj_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_imcj2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imcj2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimi100_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imcj2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            IF cl_null(g_imca_m.imca005) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aim-00163'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD imca005
            END IF
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imcj2_d[l_ac].* TO NULL 
            INITIALIZE g_imcj2_d_t.* TO NULL 
            INITIALIZE g_imcj2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_imcj2_d_t.* = g_imcj2_d[l_ac].*     #新輸入資料
            LET g_imcj2_d_o.* = g_imcj2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimi100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aimi100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imcj2_d[li_reproduce_target].* = g_imcj2_d[li_reproduce].*
 
               LET g_imcj2_d[li_reproduce_target].imcn002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            IF cl_null(g_imca_m.imca005) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aim-00163'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD imca005
            END IF
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
            OPEN aimi100_cl USING g_enterprise,g_imca_m.imca001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimi100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimi100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imcj2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imcj2_d[l_ac].imcn002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imcj2_d_t.* = g_imcj2_d[l_ac].*  #BACKUP
               LET g_imcj2_d_o.* = g_imcj2_d[l_ac].*  #BACKUP
               CALL aimi100_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aimi100_set_no_entry_b(l_cmd)
               IF NOT aimi100_lock_b("imcn_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimi100_bcl2 INTO g_imcj2_d[l_ac].imcn002,g_imcj2_d[l_ac].imcn003
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imcj2_d_mask_o[l_ac].* =  g_imcj2_d[l_ac].*
                  CALL aimi100_imcn_t_mask()
                  LET g_imcj2_d_mask_n[l_ac].* =  g_imcj2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimi100_show()
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
               LET gs_keys[01] = g_imca_m.imca001
               LET gs_keys[gs_keys.getLength()+1] = g_imcj2_d_t.imcn002
            
               #刪除同層單身
               IF NOT aimi100_delete_b('imcn_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi100_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimi100_key_delete_b(gs_keys,'imcn_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi100_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aimi100_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_imcj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imcj2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM imcn_t 
             WHERE imcnent = g_enterprise AND imcn001 = g_imca_m.imca001
               AND imcn002 = g_imcj2_d[l_ac].imcn002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imca_m.imca001
               LET gs_keys[2] = g_imcj2_d[g_detail_idx].imcn002
               CALL aimi100_insert_b('imcn_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_imcj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imcn_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimi100_b_fill()
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
               LET g_imcj2_d[l_ac].* = g_imcj2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimi100_bcl2
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
               LET g_imcj2_d[l_ac].* = g_imcj2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aimi100_imcn_t_mask_restore('restore_mask_o')
                              
               UPDATE imcn_t SET (imcn001,imcn002,imcn003) = (g_imca_m.imca001,g_imcj2_d[l_ac].imcn002, 
                   g_imcj2_d[l_ac].imcn003) #自訂欄位頁簽
                WHERE imcnent = g_enterprise AND imcn001 = g_imca_m.imca001
                  AND imcn002 = g_imcj2_d_t.imcn002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imcj2_d[l_ac].* = g_imcj2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcn_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imcj2_d[l_ac].* = g_imcj2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcn_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imca_m.imca001
               LET gs_keys_bak[1] = g_imca001_t
               LET gs_keys[2] = g_imcj2_d[g_detail_idx].imcn002
               LET gs_keys_bak[2] = g_imcj2_d_t.imcn002
               CALL aimi100_update_b('imcn_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aimi100_imcn_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imcj2_d[g_detail_idx].imcn002 = g_imcj2_d_t.imcn002 
                  ) THEN
                  LET gs_keys[01] = g_imca_m.imca001
                  LET gs_keys[gs_keys.getLength()+1] = g_imcj2_d_t.imcn002
                  CALL aimi100_key_update_b(gs_keys,'imcn_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imca_m),util.JSON.stringify(g_imcj2_d_t)
               LET g_log2 = util.JSON.stringify(g_imca_m),util.JSON.stringify(g_imcj2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcn002
            
            #add-point:AFTER FIELD imcn002 name="input.a.page2.imcn002"
            #此段落由子樣板a05產生
            DISPLAY "" TO s_detail2[l_ac].imcn002_desc
            IF NOT cl_null(g_imca_m.imca001) AND NOT cl_null(g_imcj2_d[l_ac].imcn002)  THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imca_m.imca001 != g_imca001_t OR g_imcj2_d[l_ac].imcn002 != g_imcj2_d_t.imcn002 ))) THEN 
                  IF NOT ap_chk_notDup(g_imcj2_d[l_ac].imcn002,"SELECT COUNT(*) FROM imcn_t WHERE "||"imcnent = '" ||g_enterprise|| "' AND "||"imcn001 = '"||g_imca_m.imca001 ||"' AND "|| "imcn002 = '"||g_imcj2_d[l_ac].imcn002 ||"' ",'std-00004',0) THEN 
                     LET g_imcj2_d[l_ac].imcn002 = g_imcj2_d_t.imcn002 
                     CALL aimi100_imcn_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_imcj2_d[l_ac].imcn002) THEN 
               CALL aimi100_imcn_desc()
               IF NOT ap_chk_isExist(g_imcj2_d[l_ac].imcn002,"SELECT COUNT(*) FROM imeb_t WHERE imebent = '" ||g_enterprise||"' AND imeb001 = '" ||g_imca_m.imca005||"' AND imeb003 = '1' AND imeb004 = ? ","aim-00158",1) THEN
                  LET g_imcj2_d[l_ac].imcn002 = g_imcj2_d_t.imcn002 
                  CALL aimi100_imcn_desc()
                  NEXT FIELD imcn002
               END IF
               IF NOT cl_null(g_imcj2_d[l_ac].imcn002) AND NOT cl_null(g_imcj2_d[l_ac].imcn003) THEN
                  LET l_errno = ''
                  CALL s_aimi092_chk_eigenvalue(g_imca_m.imca005,g_imcj2_d[l_ac].imcn002,g_imcj2_d[l_ac].imcn003,'','1') RETURNING l_success,l_errno,g_imcj2_d[l_ac].imcn003  #160712-00010#1
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_imcj2_d[l_ac].imcn002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imcj2_d[l_ac].imcn002 = g_imcj2_d_t.imcn002 
                     CALL aimi100_imcn_desc()
                     NEXT FIELD imcn002
                  END IF
               END IF
               IF l_cmd = 'a' THEN
                  CALL aimi100_def_imcn003()
               END IF
               CALL aimi100_set_entry_b(l_cmd)
               CALL aimi100_set_no_entry_b(l_cmd)
            END IF
            CALL aimi100_imcn_desc()
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcn002
            #add-point:BEFORE FIELD imcn002 name="input.b.page2.imcn002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcn002
            #add-point:ON CHANGE imcn002 name="input.g.page2.imcn002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcn003
            
            #add-point:AFTER FIELD imcn003 name="input.a.page2.imcn003"
            DISPLAY "" TO s_detail2[l_ac].imcn003_desc
            IF NOT cl_null(g_imcj2_d[l_ac].imcn002) AND NOT cl_null(g_imcj2_d[l_ac].imcn003) THEN
               LET l_errno = ''
               CALL s_aimi092_chk_eigenvalue(g_imca_m.imca005,g_imcj2_d[l_ac].imcn002,g_imcj2_d[l_ac].imcn003,'','1') RETURNING l_success,l_errno,g_imcj2_d[l_ac].imcn003  #160712-00010#1
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_imcj2_d[l_ac].imcn003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imcj2_d[l_ac].imcn003 = g_imcj2_d_t.imcn003
                  CALL aimi100_imcn_desc()
                  NEXT FIELD imcn003
               END IF
               
            END IF
            CALL aimi100_imcn_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcn003
            #add-point:BEFORE FIELD imcn003 name="input.b.page2.imcn003"
            CALL aimi100_display_imeb()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcn003
            #add-point:ON CHANGE imcn003 name="input.g.page2.imcn003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.imcn002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcn002
            #add-point:ON ACTION controlp INFIELD imcn002 name="input.c.page2.imcn002"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT cl_null(g_imca_m.imca005) THEN  
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_imcj2_d[l_ac].imcn002   
               #給予arg
               LET g_qryparam.arg1 = g_imca_m.imca005 #特征组别
               CALL q_imeb004()                                #呼叫開窗
      
               LET g_imcj2_d[l_ac].imcn002 = g_qryparam.return1              #將開窗取得的值回傳到變數
      
               DISPLAY g_imcj2_d[l_ac].imcn002 TO imcn002              #顯示到畫面上
               NEXT FIELD imcn002                          #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page2.imcn003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcn003
            #add-point:ON ACTION controlp INFIELD imcn003 name="input.c.page2.imcn003"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT cl_null(g_imca_m.imca005) AND NOT cl_null(g_imcj2_d[l_ac].imcn002) THEN
               LET l_imeb005 = ""
               SELECT imeb005 INTO l_imeb005
                 FROM imeb_t
                WHERE imebent = g_enterprise
                  AND imeb001 = g_imca_m.imca005
                  AND imeb004 = g_imcj2_d[l_ac].imcn002
               IF l_imeb005 = '2' THEN
                  LET g_qryparam.reqry = FALSE       
                  LET g_qryparam.default1 = g_imcj2_d[l_ac].imcn003             #給予default值       
                  #給予arg
                  LET g_qryparam.arg1 = g_imca_m.imca005 #特徵群組代碼
                  LET g_qryparam.arg2 = g_imcj2_d[l_ac].imcn002 #特徵類型       
                  CALL q_imec003()                                #呼叫開窗       
                  LET g_imcj2_d[l_ac].imcn003 = g_qryparam.return1              #將開窗取得的值回傳到變數
                  DISPLAY g_imcj2_d[l_ac].imcn003 TO imcn003              #顯示到畫面上       
                  CALL aimi100_imcn_desc()
                  NEXT FIELD imcn003                          #返回原欄位
               END IF
            END IF


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imcj2_d[l_ac].* = g_imcj2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimi100_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aimi100_unlock_b("imcn_t","'2'")
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
               LET g_imcj2_d[li_reproduce_target].* = g_imcj2_d[li_reproduce].*
 
               LET g_imcj2_d[li_reproduce_target].imcn002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imcj2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imcj2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_imcj3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imcj3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimi100_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imcj3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imcj3_d[l_ac].* TO NULL 
            INITIALIZE g_imcj3_d_t.* TO NULL 
            INITIALIZE g_imcj3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_imcj3_d_t.* = g_imcj3_d[l_ac].*     #新輸入資料
            LET g_imcj3_d_o.* = g_imcj3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimi100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aimi100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imcj3_d[li_reproduce_target].* = g_imcj3_d[li_reproduce].*
 
               LET g_imcj3_d[li_reproduce_target].imcl002 = NULL
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
            OPEN aimi100_cl USING g_enterprise,g_imca_m.imca001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimi100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimi100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imcj3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imcj3_d[l_ac].imcl002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imcj3_d_t.* = g_imcj3_d[l_ac].*  #BACKUP
               LET g_imcj3_d_o.* = g_imcj3_d[l_ac].*  #BACKUP
               CALL aimi100_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aimi100_set_no_entry_b(l_cmd)
               IF NOT aimi100_lock_b("imcl_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimi100_bcl3 INTO g_imcj3_d[l_ac].imcl002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imcj3_d_mask_o[l_ac].* =  g_imcj3_d[l_ac].*
                  CALL aimi100_imcl_t_mask()
                  LET g_imcj3_d_mask_n[l_ac].* =  g_imcj3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimi100_show()
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
               LET gs_keys[01] = g_imca_m.imca001
               LET gs_keys[gs_keys.getLength()+1] = g_imcj3_d_t.imcl002
            
               #刪除同層單身
               IF NOT aimi100_delete_b('imcl_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi100_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimi100_key_delete_b(gs_keys,'imcl_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi100_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aimi100_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_imcj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imcj3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM imcl_t 
             WHERE imclent = g_enterprise AND imcl001 = g_imca_m.imca001
               AND imcl002 = g_imcj3_d[l_ac].imcl002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imca_m.imca001
               LET gs_keys[2] = g_imcj3_d[g_detail_idx].imcl002
               CALL aimi100_insert_b('imcl_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_imcj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imcl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimi100_b_fill()
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
               LET g_imcj3_d[l_ac].* = g_imcj3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimi100_bcl3
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
               LET g_imcj3_d[l_ac].* = g_imcj3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aimi100_imcl_t_mask_restore('restore_mask_o')
                              
               UPDATE imcl_t SET (imcl001,imcl002) = (g_imca_m.imca001,g_imcj3_d[l_ac].imcl002) #自訂欄位頁簽 
 
                WHERE imclent = g_enterprise AND imcl001 = g_imca_m.imca001
                  AND imcl002 = g_imcj3_d_t.imcl002 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imcj3_d[l_ac].* = g_imcj3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcl_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imcj3_d[l_ac].* = g_imcj3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcl_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imca_m.imca001
               LET gs_keys_bak[1] = g_imca001_t
               LET gs_keys[2] = g_imcj3_d[g_detail_idx].imcl002
               LET gs_keys_bak[2] = g_imcj3_d_t.imcl002
               CALL aimi100_update_b('imcl_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aimi100_imcl_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imcj3_d[g_detail_idx].imcl002 = g_imcj3_d_t.imcl002 
                  ) THEN
                  LET gs_keys[01] = g_imca_m.imca001
                  LET gs_keys[gs_keys.getLength()+1] = g_imcj3_d_t.imcl002
                  CALL aimi100_key_update_b(gs_keys,'imcl_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imca_m),util.JSON.stringify(g_imcj3_d_t)
               LET g_log2 = util.JSON.stringify(g_imca_m),util.JSON.stringify(g_imcj3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcl002
            #add-point:BEFORE FIELD imcl002 name="input.b.page3.imcl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcl002
            
            #add-point:AFTER FIELD imcl002 name="input.a.page3.imcl002"
            #此段落由子樣板a05產生
            DISPLAY "" TO s_detail3[l_ac].imcl002_desc
            IF  NOT cl_null(g_imca_m.imca001) AND NOT cl_null(g_imcj3_d[l_ac].imcl002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imca_m.imca001 != g_imca001_t OR g_imcj3_d[l_ac].imcl002 != g_imcj3_d_t.imcl002))) THEN 
                  IF NOT ap_chk_notDup(g_imcj3_d[l_ac].imcl002,"SELECT COUNT(*) FROM imcl_t WHERE "||"imclent = '" ||g_enterprise|| "' AND "||"imcl001 = '"||g_imca_m.imca001 ||"' AND "|| "imcl002 = '"||g_imcj3_d[l_ac].imcl002 ||"'",'std-00004',0) THEN
                     LET g_imcj3_d[l_ac].imcl002 = g_imcj3_d_t.imcl002
                     CALL aimi100_imcl_desc()                  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_imcj3_d[l_ac].imcl002) THEN 
               CALL aimi100_imcl_desc()
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_imcj3_d[l_ac].imcl002 != g_imcj3_d_t.imcl002 ) THEN 
                  IF NOT s_azzi650_chk_exist('213',g_imcj3_d[l_ac].imcl002) THEN
                     LET g_imcj3_d[l_ac].imcl002 = g_imcj3_d_t.imcl002
                     CALL aimi100_imcl_desc()
                     NEXT FIELD imcl002
                  END IF
               END IF
            END IF
            CALL aimi100_imcl_desc()

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcl002
            #add-point:ON CHANGE imcl002 name="input.g.page3.imcl002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.imcl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcl002
            #add-point:ON ACTION controlp INFIELD imcl002 name="input.c.page3.imcl002"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcj3_d[l_ac].imcl002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "213" #應用分類
            LET g_qryparam.where = "oocqstus = 'Y' "
            CALL q_oocq002()                                #呼叫開窗

            LET g_imcj3_d[l_ac].imcl002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcj3_d[l_ac].imcl002 TO imcl002              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimi100_imcl_desc()
            NEXT FIELD imcl002                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imcj3_d[l_ac].* = g_imcj3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimi100_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aimi100_unlock_b("imcl_t","'3'")
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
               LET g_imcj3_d[li_reproduce_target].* = g_imcj3_d[li_reproduce].*
 
               LET g_imcj3_d[li_reproduce_target].imcl002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imcj3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imcj3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_imcj4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imcj4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimi100_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imcj4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imcj4_d[l_ac].* TO NULL 
            INITIALIZE g_imcj4_d_t.* TO NULL 
            INITIALIZE g_imcj4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_imcj4_d_t.* = g_imcj4_d[l_ac].*     #新輸入資料
            LET g_imcj4_d_o.* = g_imcj4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimi100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL aimi100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imcj4_d[li_reproduce_target].* = g_imcj4_d[li_reproduce].*
 
               LET g_imcj4_d[li_reproduce_target].imcm002 = NULL
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
            OPEN aimi100_cl USING g_enterprise,g_imca_m.imca001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimi100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimi100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imcj4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imcj4_d[l_ac].imcm002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imcj4_d_t.* = g_imcj4_d[l_ac].*  #BACKUP
               LET g_imcj4_d_o.* = g_imcj4_d[l_ac].*  #BACKUP
               CALL aimi100_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL aimi100_set_no_entry_b(l_cmd)
               IF NOT aimi100_lock_b("imcm_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimi100_bcl4 INTO g_imcj4_d[l_ac].imcm002,g_imcj4_d[l_ac].imcm005,g_imcj4_d[l_ac].imcm003, 
                      g_imcj4_d[l_ac].imcm006,g_imcj4_d[l_ac].imcm004
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imcj4_d_mask_o[l_ac].* =  g_imcj4_d[l_ac].*
                  CALL aimi100_imcm_t_mask()
                  LET g_imcj4_d_mask_n[l_ac].* =  g_imcj4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimi100_show()
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
               LET gs_keys[01] = g_imca_m.imca001
               LET gs_keys[gs_keys.getLength()+1] = g_imcj4_d_t.imcm002
            
               #刪除同層單身
               IF NOT aimi100_delete_b('imcm_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi100_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimi100_key_delete_b(gs_keys,'imcm_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi100_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aimi100_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_imcj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imcj4_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM imcm_t 
             WHERE imcment = g_enterprise AND imcm001 = g_imca_m.imca001
               AND imcm002 = g_imcj4_d[l_ac].imcm002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imca_m.imca001
               LET gs_keys[2] = g_imcj4_d[g_detail_idx].imcm002
               CALL aimi100_insert_b('imcm_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_imcj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imcm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimi100_b_fill()
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
               LET g_imcj4_d[l_ac].* = g_imcj4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimi100_bcl4
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
               LET g_imcj4_d[l_ac].* = g_imcj4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL aimi100_imcm_t_mask_restore('restore_mask_o')
                              
               UPDATE imcm_t SET (imcm001,imcm002,imcm005,imcm003,imcm006,imcm004) = (g_imca_m.imca001, 
                   g_imcj4_d[l_ac].imcm002,g_imcj4_d[l_ac].imcm005,g_imcj4_d[l_ac].imcm003,g_imcj4_d[l_ac].imcm006, 
                   g_imcj4_d[l_ac].imcm004) #自訂欄位頁簽
                WHERE imcment = g_enterprise AND imcm001 = g_imca_m.imca001
                  AND imcm002 = g_imcj4_d_t.imcm002 #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imcj4_d[l_ac].* = g_imcj4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imcj4_d[l_ac].* = g_imcj4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcm_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imca_m.imca001
               LET gs_keys_bak[1] = g_imca001_t
               LET gs_keys[2] = g_imcj4_d[g_detail_idx].imcm002
               LET gs_keys_bak[2] = g_imcj4_d_t.imcm002
               CALL aimi100_update_b('imcm_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aimi100_imcm_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imcj4_d[g_detail_idx].imcm002 = g_imcj4_d_t.imcm002 
                  ) THEN
                  LET gs_keys[01] = g_imca_m.imca001
                  LET gs_keys[gs_keys.getLength()+1] = g_imcj4_d_t.imcm002
                  CALL aimi100_key_update_b(gs_keys,'imcm_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imca_m),util.JSON.stringify(g_imcj4_d_t)
               LET g_log2 = util.JSON.stringify(g_imca_m),util.JSON.stringify(g_imcj4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcm002
            #add-point:BEFORE FIELD imcm002 name="input.b.page4.imcm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcm002
            
            #add-point:AFTER FIELD imcm002 name="input.a.page4.imcm002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_imca_m.imca001) AND NOT cl_null(g_imcj4_d[l_ac].imcm002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imca_m.imca001 != g_imca001_t OR g_imcj4_d[l_ac].imcm002 != g_imcj4_d_t.imcm002))) THEN 
                  IF NOT ap_chk_notDup(g_imcj4_d[l_ac].imcm002,"SELECT COUNT(*) FROM imcm_t WHERE "||"imcment = '" ||g_enterprise|| "' AND "||"imcm001 = '"||g_imca_m.imca001 ||"' AND "|| "imcm002 = '"||g_imcj4_d[l_ac].imcm002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcm002
            #add-point:ON CHANGE imcm002 name="input.g.page4.imcm002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcm005
            #add-point:BEFORE FIELD imcm005 name="input.b.page4.imcm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcm005
            
            #add-point:AFTER FIELD imcm005 name="input.a.page4.imcm005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcm005
            #add-point:ON CHANGE imcm005 name="input.g.page4.imcm005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcm003
            #add-point:BEFORE FIELD imcm003 name="input.b.page4.imcm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcm003
            
            #add-point:AFTER FIELD imcm003 name="input.a.page4.imcm003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcm003
            #add-point:ON CHANGE imcm003 name="input.g.page4.imcm003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcm006
            #add-point:BEFORE FIELD imcm006 name="input.b.page4.imcm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcm006
            
            #add-point:AFTER FIELD imcm006 name="input.a.page4.imcm006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcm006
            #add-point:ON CHANGE imcm006 name="input.g.page4.imcm006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.imcm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcm002
            #add-point:ON ACTION controlp INFIELD imcm002 name="input.c.page4.imcm002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.imcm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcm005
            #add-point:ON ACTION controlp INFIELD imcm005 name="input.c.page4.imcm005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.imcm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcm003
            #add-point:ON ACTION controlp INFIELD imcm003 name="input.c.page4.imcm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.imcm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcm006
            #add-point:ON ACTION controlp INFIELD imcm006 name="input.c.page4.imcm006"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imcj4_d[l_ac].* = g_imcj4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimi100_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aimi100_unlock_b("imcm_t","'4'")
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
               LET g_imcj4_d[li_reproduce_target].* = g_imcj4_d[li_reproduce].*
 
               LET g_imcj4_d[li_reproduce_target].imcm002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imcj4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imcj4_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_imcj5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body5.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imcj5_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimi100_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imcj5_d.getLength()
            #add-point:資料輸入前 name="input.body5.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imcj5_d[l_ac].* TO NULL 
            INITIALIZE g_imcj5_d_t.* TO NULL 
            INITIALIZE g_imcj5_d_o.* TO NULL 
            #公用欄位給值(單身5)
            
            #自定義預設值(單身5)
            
            #add-point:modify段before備份 name="input.body5.insert.before_bak"
            
            #end add-point
            LET g_imcj5_d_t.* = g_imcj5_d[l_ac].*     #新輸入資料
            LET g_imcj5_d_o.* = g_imcj5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimi100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body5.insert.after_set_entry_b"
            
            #end add-point
            CALL aimi100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imcj5_d[li_reproduce_target].* = g_imcj5_d[li_reproduce].*
 
               LET g_imcj5_d[li_reproduce_target].imco002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body5.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body5.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[5] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 5
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aimi100_cl USING g_enterprise,g_imca_m.imca001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimi100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimi100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imcj5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imcj5_d[l_ac].imco002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imcj5_d_t.* = g_imcj5_d[l_ac].*  #BACKUP
               LET g_imcj5_d_o.* = g_imcj5_d[l_ac].*  #BACKUP
               CALL aimi100_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body5.after_set_entry_b"
               
               #end add-point  
               CALL aimi100_set_no_entry_b(l_cmd)
               IF NOT aimi100_lock_b("imco_t","'5'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimi100_bcl5 INTO g_imcj5_d[l_ac].imco002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imcj5_d_mask_o[l_ac].* =  g_imcj5_d[l_ac].*
                  CALL aimi100_imco_t_mask()
                  LET g_imcj5_d_mask_n[l_ac].* =  g_imcj5_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimi100_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body5.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body5.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body5.b_delete_ask"
               
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
               
               #add-point:單身5刪除前 name="input.body5.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_imca_m.imca001
               LET gs_keys[gs_keys.getLength()+1] = g_imcj5_d_t.imco002
            
               #刪除同層單身
               IF NOT aimi100_delete_b('imco_t',gs_keys,"'5'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi100_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimi100_key_delete_b(gs_keys,'imco_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimi100_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身5刪除中 name="input.body5.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aimi100_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身5刪除後 name="input.body5.a_delete"
               
               #end add-point
               LET l_count = g_imcj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body5.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imcj5_d.getLength() + 1) THEN
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
               
            #add-point:單身5新增前 name="input.body5.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM imco_t 
             WHERE imcoent = g_enterprise AND imco001 = g_imca_m.imca001
               AND imco002 = g_imcj5_d[l_ac].imco002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身5新增前 name="input.body5.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imca_m.imca001
               LET gs_keys[2] = g_imcj5_d[g_detail_idx].imco002
               CALL aimi100_insert_b('imco_t',gs_keys,"'5'")
                           
               #add-point:單身新增後5 name="input.body5.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_imcj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imco_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimi100_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body5.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imcj5_d[l_ac].* = g_imcj5_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimi100_bcl5
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
               LET g_imcj5_d[l_ac].* = g_imcj5_d_t.*
            ELSE
               #add-point:單身page5修改前 name="input.body5.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身5)
               
               
               #將遮罩欄位還原
               CALL aimi100_imco_t_mask_restore('restore_mask_o')
                              
               UPDATE imco_t SET (imco001,imco002) = (g_imca_m.imca001,g_imcj5_d[l_ac].imco002) #自訂欄位頁簽 
 
                WHERE imcoent = g_enterprise AND imco001 = g_imca_m.imca001
                  AND imco002 = g_imcj5_d_t.imco002 #項次 
                  
               #add-point:單身page5修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imcj5_d[l_ac].* = g_imcj5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imco_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imcj5_d[l_ac].* = g_imcj5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imco_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imca_m.imca001
               LET gs_keys_bak[1] = g_imca001_t
               LET gs_keys[2] = g_imcj5_d[g_detail_idx].imco002
               LET gs_keys_bak[2] = g_imcj5_d_t.imco002
               CALL aimi100_update_b('imco_t',gs_keys,gs_keys_bak,"'5'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aimi100_imco_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imcj5_d[g_detail_idx].imco002 = g_imcj5_d_t.imco002 
                  ) THEN
                  LET gs_keys[01] = g_imca_m.imca001
                  LET gs_keys[gs_keys.getLength()+1] = g_imcj5_d_t.imco002
                  CALL aimi100_key_update_b(gs_keys,'imco_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imca_m),util.JSON.stringify(g_imcj5_d_t)
               LET g_log2 = util.JSON.stringify(g_imca_m),util.JSON.stringify(g_imcj5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page5修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imco002
            
            #add-point:AFTER FIELD imco002 name="input.a.page5.imco002"
            #此段落由子樣板a05產生
            CALL aimi100_imco_desc()
            IF g_imcj5_d[l_ac].imco002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_imcj5_d[l_ac].imco002 != g_imcj5_d_t.imco002) THEN 
                  IF NOT ap_chk_notDup(g_imcj5_d[l_ac].imco002,"SELECT COUNT(*) FROM imco_t WHERE "||"imcoent = '" ||g_enterprise|| "' AND "||"imco001 = '"||g_imca_m.imca001 ||"' AND "|| "imco002 = '"||g_imcj5_d[l_ac].imco002 ||"'",'std-00004',0) THEN 
                     LET g_imcj5_d[l_ac].imco002 = g_imcj5_d_t.imco002
                     CALL aimi100_imco_desc()
                     NEXT FIELD imco002
                  END IF
               END IF
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imcj5_d[l_ac].imco002
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_imcj5_d[l_ac].imco002 = g_imcj5_d_t.imco002
                  CALL aimi100_imco_desc()
                  NEXT FIELD imco002
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imco002
            #add-point:BEFORE FIELD imco002 name="input.b.page5.imco002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imco002
            #add-point:ON CHANGE imco002 name="input.g.page5.imco002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.imco002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imco002
            #add-point:ON ACTION controlp INFIELD imco002 name="input.c.page5.imco002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcj5_d[l_ac].imco002             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imcj5_d[l_ac].imco002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcj5_d[l_ac].imco002 TO imco002              #顯示到畫面上
            CALL aimi100_imco_desc()
            NEXT FIELD imco002                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page5 after_row name="input.body5.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imcj5_d[l_ac].* = g_imcj5_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimi100_bcl5
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aimi100_unlock_b("imco_t","'5'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page5 after_row2 name="input.body5.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body5.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_imcj5_d[li_reproduce_target].* = g_imcj5_d[li_reproduce].*
 
               LET g_imcj5_d[li_reproduce_target].imco002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imcj5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imcj5_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aimi100.input.other" >}
      
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
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue("'5',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD imca001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imcj002
               WHEN "s_detail2"
                  NEXT FIELD imcn002
               WHEN "s_detail3"
                  NEXT FIELD imcl002
               WHEN "s_detail4"
                  NEXT FIELD imcm002
               WHEN "s_detail5"
                  NEXT FIELD imco002
 
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
         LET g_detail_idx_list[5] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
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
         LET g_detail_idx_list[5] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aimi100_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
 
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aimi100_b_fill() #單身填充
      CALL aimi100_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aimi100_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imca_m.imcaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imca_m.imcaownid_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imca_m.imcaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imca_m.imcaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imca_m.imcaowndp_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imca_m.imcaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imca_m.imcacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imca_m.imcacrtid_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imca_m.imcacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imca_m.imcacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imca_m.imcacrtdp_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imca_m.imcacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imca_m.imcamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imca_m.imcamodid_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imca_m.imcamodid_desc

            #CALL aimi100_desc()

   #end add-point
   
   #遮罩相關處理
   LET g_imca_m_mask_o.* =  g_imca_m.*
   CALL aimi100_imca_t_mask()
   LET g_imca_m_mask_n.* =  g_imca_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imca_m.imca001,g_imca_m.imca001_desc,g_imca_m.imca004,g_imca_m.imca005,g_imca_m.imca005_desc, 
       g_imca_m.imca006,g_imca_m.imca006_desc,g_imca_m.imca010,g_imca_m.imca010_desc,g_imca_m.imca201, 
       g_imca_m.imca201_desc,g_imca_m.imca202,g_imca_m.imca202_desc,g_imca_m.imca203,g_imca_m.imca203_desc, 
       g_imca_m.imca204,g_imca_m.imca204_desc,g_imca_m.imca205,g_imca_m.imca205_desc,g_imca_m.imca206, 
       g_imca_m.imca206_desc,g_imca_m.imca207,g_imca_m.imca207_desc,g_imca_m.imca208,g_imca_m.imca208_desc, 
       g_imca_m.imcastus,g_imca_m.imca126,g_imca_m.imca126_desc,g_imca_m.imca127,g_imca_m.imca127_desc, 
       g_imca_m.imca131,g_imca_m.imca131_desc,g_imca_m.imca128,g_imca_m.imca128_desc,g_imca_m.imca129, 
       g_imca_m.imca129_desc,g_imca_m.imca130,g_imca_m.imca132,g_imca_m.imca132_desc,g_imca_m.imca133, 
       g_imca_m.imca133_desc,g_imca_m.imca134,g_imca_m.imca134_desc,g_imca_m.imca135,g_imca_m.imca135_desc, 
       g_imca_m.imca136,g_imca_m.imca136_desc,g_imca_m.imca137,g_imca_m.imca137_desc,g_imca_m.imca138, 
       g_imca_m.imca138_desc,g_imca_m.imca139,g_imca_m.imca139_desc,g_imca_m.imca140,g_imca_m.imca140_desc, 
       g_imca_m.imca141,g_imca_m.imca141_desc,g_imca_m.imcaownid,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp, 
       g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid,g_imca_m.imcacrtid_desc,g_imca_m.imcacrtdp,g_imca_m.imcacrtdp_desc, 
       g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamodid_desc,g_imca_m.imcamoddt,g_imca_m.imca011, 
       g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca018_desc,g_imca_m.imca022, 
       g_imca_m.imca022_desc,g_imca_m.imca024,g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca029_desc, 
       g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca032_desc,g_imca_m.imca033,g_imca_m.imca036,g_imca_m.imca037, 
       g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042,g_imca_m.imca044,g_imca_m.imca122, 
       g_imca_m.imca122_desc,g_imca_m.imca045,g_imca_m.imca045_desc,g_imca_m.imca123,g_imca_m.imca003 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imca_m.imcastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_imcj_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #CALL aimi100_imcj_desc()

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_imcj2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      #CALL aimi100_imcn_desc()
      #xianghui-mod-b
#      IF cl_null(g_imcj2_d[l_ac].imcn003) THEN    
#         LET  g_imcj2_d[l_ac].imcn003_desc = ""
#      ELSE           
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_imcj2_d[l_ac].imcn003
#         CALL ap_ref_array2(g_ref_fields,"SELECT imecl005 FROM imecl_t WHERE imeclent='"||g_enterprise||"' AND imecl001= '"||g_imca_m.imca005||"' AND imecl003 = ? AND imecl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_imcj2_d[l_ac].imcn003_desc = g_rtn_fields[1]
#      END IF
#      DISPLAY g_imcj2_d[l_ac].imcn003_desc TO s_detail2[l_ac].imcn003_desc
      CALL aimi100_imcn003_desc()
      #xianghui-mod-e
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_imcj3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      CALL aimi100_imcl_desc()
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_imcj4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_imcj5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
      #CALL aimi100_imco_desc()
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aimi100_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aimi100_detail_show()
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
 
{<section id="aimi100.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimi100_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE imca_t.imca001 
   DEFINE l_oldno     LIKE imca_t.imca001 
 
   DEFINE l_master    RECORD LIKE imca_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE imcj_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE imcn_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE imcl_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE imcm_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE imco_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
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
   
   IF g_imca_m.imca001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_imca001_t = g_imca_m.imca001
 
    
   LET g_imca_m.imca001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imca_m.imcaownid = g_user
      LET g_imca_m.imcaowndp = g_dept
      LET g_imca_m.imcacrtid = g_user
      LET g_imca_m.imcacrtdp = g_dept 
      LET g_imca_m.imcacrtdt = cl_get_current()
      LET g_imca_m.imcamodid = g_user
      LET g_imca_m.imcamoddt = cl_get_current()
      LET g_imca_m.imcastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imca_m.imcastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_imca_m.imca001_desc = ''
   DISPLAY BY NAME g_imca_m.imca001_desc
 
   
   CALL aimi100_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_imca_m.* TO NULL
      INITIALIZE g_imcj_d TO NULL
      INITIALIZE g_imcj2_d TO NULL
      INITIALIZE g_imcj3_d TO NULL
      INITIALIZE g_imcj4_d TO NULL
      INITIALIZE g_imcj5_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aimi100_show()
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
   CALL aimi100_set_act_visible()   
   CALL aimi100_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imca001_t = g_imca_m.imca001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imcaent = " ||g_enterprise|| " AND",
                      " imca001 = '", g_imca_m.imca001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aimi100_idx_chk()
   
   LET g_data_owner = g_imca_m.imcaownid      
   LET g_data_dept  = g_imca_m.imcaowndp
   
   #功能已完成,通報訊息中心
   CALL aimi100_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aimi100_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE imcj_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE imcn_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE imcl_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE imcm_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE imco_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aimi100_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imcj_t
    WHERE imcjent = g_enterprise AND imcj001 = g_imca001_t
 
    INTO TEMP aimi100_detail
 
   #將key修正為調整後   
   UPDATE aimi100_detail 
      #更新key欄位
      SET imcj001 = g_imca_m.imca001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO imcj_t SELECT * FROM aimi100_detail
   
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
   DROP TABLE aimi100_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imcn_t 
    WHERE imcnent = g_enterprise AND imcn001 = g_imca001_t
 
    INTO TEMP aimi100_detail
 
   #將key修正為調整後   
   UPDATE aimi100_detail SET imcn001 = g_imca_m.imca001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imcn_t SELECT * FROM aimi100_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aimi100_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imcl_t 
    WHERE imclent = g_enterprise AND imcl001 = g_imca001_t
 
    INTO TEMP aimi100_detail
 
   #將key修正為調整後   
   UPDATE aimi100_detail SET imcl001 = g_imca_m.imca001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imcl_t SELECT * FROM aimi100_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aimi100_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imcm_t 
    WHERE imcment = g_enterprise AND imcm001 = g_imca001_t
 
    INTO TEMP aimi100_detail
 
   #將key修正為調整後   
   UPDATE aimi100_detail SET imcm001 = g_imca_m.imca001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imcm_t SELECT * FROM aimi100_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aimi100_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table5.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imco_t 
    WHERE imcoent = g_enterprise AND imco001 = g_imca001_t
 
    INTO TEMP aimi100_detail
 
   #將key修正為調整後   
   UPDATE aimi100_detail SET imco001 = g_imca_m.imca001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table5.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imco_t SELECT * FROM aimi100_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table5.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aimi100_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table5.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_imca001_t = g_imca_m.imca001
 
   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aimi100_delete()
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
   
   IF g_imca_m.imca001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aimi100_cl USING g_enterprise,g_imca_m.imca001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi100_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aimi100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi100_master_referesh USING g_imca_m.imca001 INTO g_imca_m.imca001,g_imca_m.imca004,g_imca_m.imca005, 
       g_imca_m.imca006,g_imca_m.imca010,g_imca_m.imca201,g_imca_m.imca202,g_imca_m.imca203,g_imca_m.imca204, 
       g_imca_m.imca205,g_imca_m.imca206,g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus,g_imca_m.imca126, 
       g_imca_m.imca127,g_imca_m.imca131,g_imca_m.imca128,g_imca_m.imca129,g_imca_m.imca130,g_imca_m.imca132, 
       g_imca_m.imca133,g_imca_m.imca134,g_imca_m.imca135,g_imca_m.imca136,g_imca_m.imca137,g_imca_m.imca138, 
       g_imca_m.imca139,g_imca_m.imca140,g_imca_m.imca141,g_imca_m.imcaownid,g_imca_m.imcaowndp,g_imca_m.imcacrtid, 
       g_imca_m.imcacrtdp,g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamoddt,g_imca_m.imca011, 
       g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca022,g_imca_m.imca024, 
       g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca033, 
       g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042, 
       g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045,g_imca_m.imca123,g_imca_m.imca003,g_imca_m.imca001_desc, 
       g_imca_m.imca005_desc,g_imca_m.imca006_desc,g_imca_m.imca010_desc,g_imca_m.imca201_desc,g_imca_m.imca202_desc, 
       g_imca_m.imca203_desc,g_imca_m.imca204_desc,g_imca_m.imca205_desc,g_imca_m.imca206_desc,g_imca_m.imca207_desc, 
       g_imca_m.imca208_desc,g_imca_m.imca126_desc,g_imca_m.imca127_desc,g_imca_m.imca131_desc,g_imca_m.imca128_desc, 
       g_imca_m.imca129_desc,g_imca_m.imca132_desc,g_imca_m.imca133_desc,g_imca_m.imca134_desc,g_imca_m.imca135_desc, 
       g_imca_m.imca136_desc,g_imca_m.imca137_desc,g_imca_m.imca138_desc,g_imca_m.imca139_desc,g_imca_m.imca140_desc, 
       g_imca_m.imca141_desc,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid_desc, 
       g_imca_m.imcacrtdp_desc,g_imca_m.imcamodid_desc,g_imca_m.imca018_desc,g_imca_m.imca022_desc,g_imca_m.imca029_desc, 
       g_imca_m.imca032_desc,g_imca_m.imca122_desc,g_imca_m.imca045_desc
   
   
   #檢查是否允許此動作
   IF NOT aimi100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imca_m_mask_o.* =  g_imca_m.*
   CALL aimi100_imca_t_mask()
   LET g_imca_m_mask_n.* =  g_imca_m.*
   
   CALL aimi100_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimi100_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_imca001_t = g_imca_m.imca001
 
 
      DELETE FROM imca_t
       WHERE imcaent = g_enterprise AND imca001 = g_imca_m.imca001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_imca_m.imca001,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM imcj_t
       WHERE imcjent = g_enterprise AND imcj001 = g_imca_m.imca001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcj_t:",SQLERRMESSAGE 
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
      DELETE FROM imcn_t
       WHERE imcnent = g_enterprise AND
             imcn001 = g_imca_m.imca001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcn_t:",SQLERRMESSAGE 
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
      DELETE FROM imcl_t
       WHERE imclent = g_enterprise AND
             imcl001 = g_imca_m.imca001
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcl_t:",SQLERRMESSAGE 
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
      DELETE FROM imcm_t
       WHERE imcment = g_enterprise AND
             imcm001 = g_imca_m.imca001
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete5"
      
      #end add-point
      DELETE FROM imco_t
       WHERE imcoent = g_enterprise AND
             imco001 = g_imca_m.imca001
      #add-point:單身刪除中 name="delete.body.m_delete5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imco_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete5"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imca_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aimi100_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_imcj_d.clear() 
      CALL g_imcj2_d.clear()       
      CALL g_imcj3_d.clear()       
      CALL g_imcj4_d.clear()       
      CALL g_imcj5_d.clear()       
 
     
      CALL aimi100_ui_browser_refresh()  
      #CALL aimi100_ui_headershow()  
      #CALL aimi100_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aimi100_browser_fill("")
         CALL aimi100_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimi100_cl
 
   #功能已完成,通報訊息中心
   CALL aimi100_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aimi100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aimi100_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_imcj_d.clear()
   CALL g_imcj2_d.clear()
   CALL g_imcj3_d.clear()
   CALL g_imcj4_d.clear()
   CALL g_imcj5_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aimi100_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imcj002,imcj003,imcj004,imcj005,imcj006 ,t1.oocql004 ,t2.oocql004 , 
             t3.oocal003 ,t4.oocql004 FROM imcj_t",   
                     " INNER JOIN imca_t ON imcaent = " ||g_enterprise|| " AND imca001 = imcj001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='270' AND t1.oocql002=imcj002 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='271' AND t2.oocql002=imcj003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=imcj005 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='272' AND t4.oocql002=imcj006 AND t4.oocql003='"||g_dlang||"' ",
 
                     " WHERE imcjent=? AND imcj001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imcj_t.imcj002,imcj_t.imcj003"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimi100_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aimi100_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_imca_m.imca001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_imca_m.imca001 INTO g_imcj_d[l_ac].imcj002,g_imcj_d[l_ac].imcj003, 
          g_imcj_d[l_ac].imcj004,g_imcj_d[l_ac].imcj005,g_imcj_d[l_ac].imcj006,g_imcj_d[l_ac].imcj002_desc, 
          g_imcj_d[l_ac].imcj003_desc,g_imcj_d[l_ac].imcj005_desc,g_imcj_d[l_ac].imcj006_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL aimi100_imcj_desc()
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
   IF aimi100_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imcn002,imcn003 ,t5.oocql004 FROM imcn_t",   
                     " INNER JOIN  imca_t ON imcaent = " ||g_enterprise|| " AND imca001 = imcn001 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='273' AND t5.oocql002=imcn002 AND t5.oocql003='"||g_dlang||"' ",
 
                     " WHERE imcnent=? AND imcn001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imcn_t.imcn002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimi100_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aimi100_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_imca_m.imca001   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_imca_m.imca001 INTO g_imcj2_d[l_ac].imcn002,g_imcj2_d[l_ac].imcn003, 
          g_imcj2_d[l_ac].imcn002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL aimi100_imcn_desc()
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
   IF aimi100_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imcl002  FROM imcl_t",   
                     " INNER JOIN  imca_t ON imcaent = " ||g_enterprise|| " AND imca001 = imcl001 ",
 
                     "",
                     
                     
                     " WHERE imclent=? AND imcl001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imcl_t.imcl002"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimi100_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aimi100_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_imca_m.imca001   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_imca_m.imca001 INTO g_imcj3_d[l_ac].imcl002   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         CALL aimi100_imcl_desc()
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
   IF aimi100_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imcm002,imcm005,imcm003,imcm006,imcm004  FROM imcm_t",   
                     " INNER JOIN  imca_t ON imcaent = " ||g_enterprise|| " AND imca001 = imcm001 ",
 
                     "",
                     
                     
                     " WHERE imcment=? AND imcm001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imcm_t.imcm002"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimi100_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR aimi100_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_imca_m.imca001   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_imca_m.imca001 INTO g_imcj4_d[l_ac].imcm002,g_imcj4_d[l_ac].imcm005, 
          g_imcj4_d[l_ac].imcm003,g_imcj4_d[l_ac].imcm006,g_imcj4_d[l_ac].imcm004   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
         
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
   IF aimi100_fill_chk(5) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body5.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imco002 ,t6.oocal003 FROM imco_t",   
                     " INNER JOIN  imca_t ON imcaent = " ||g_enterprise|| " AND imca001 = imco001 ",
 
                     "",
                     
                                    " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=imco002 AND t6.oocal002='"||g_dlang||"' ",
 
                     " WHERE imcoent=? AND imco001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body5.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table5) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imco_t.imco002"
         
         #add-point:單身填充控制 name="b_fill.sql5"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimi100_pb5 FROM g_sql
         DECLARE b_fill_cs5 CURSOR FOR aimi100_pb5
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs5 USING g_enterprise,g_imca_m.imca001   #(ver:78)
                                               
      FOREACH b_fill_cs5 USING g_enterprise,g_imca_m.imca001 INTO g_imcj5_d[l_ac].imco002,g_imcj5_d[l_ac].imco002_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill5.fill"
         CALL aimi100_imco_desc()
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
   
   CALL g_imcj_d.deleteElement(g_imcj_d.getLength())
   CALL g_imcj2_d.deleteElement(g_imcj2_d.getLength())
   CALL g_imcj3_d.deleteElement(g_imcj3_d.getLength())
   CALL g_imcj4_d.deleteElement(g_imcj4_d.getLength())
   CALL g_imcj5_d.deleteElement(g_imcj5_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aimi100_pb
   FREE aimi100_pb2
 
   FREE aimi100_pb3
 
   FREE aimi100_pb4
 
   FREE aimi100_pb5
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_imcj_d.getLength()
      LET g_imcj_d_mask_o[l_ac].* =  g_imcj_d[l_ac].*
      CALL aimi100_imcj_t_mask()
      LET g_imcj_d_mask_n[l_ac].* =  g_imcj_d[l_ac].*
   END FOR
   
   LET g_imcj2_d_mask_o.* =  g_imcj2_d.*
   FOR l_ac = 1 TO g_imcj2_d.getLength()
      LET g_imcj2_d_mask_o[l_ac].* =  g_imcj2_d[l_ac].*
      CALL aimi100_imcn_t_mask()
      LET g_imcj2_d_mask_n[l_ac].* =  g_imcj2_d[l_ac].*
   END FOR
   LET g_imcj3_d_mask_o.* =  g_imcj3_d.*
   FOR l_ac = 1 TO g_imcj3_d.getLength()
      LET g_imcj3_d_mask_o[l_ac].* =  g_imcj3_d[l_ac].*
      CALL aimi100_imcl_t_mask()
      LET g_imcj3_d_mask_n[l_ac].* =  g_imcj3_d[l_ac].*
   END FOR
   LET g_imcj4_d_mask_o.* =  g_imcj4_d.*
   FOR l_ac = 1 TO g_imcj4_d.getLength()
      LET g_imcj4_d_mask_o[l_ac].* =  g_imcj4_d[l_ac].*
      CALL aimi100_imcm_t_mask()
      LET g_imcj4_d_mask_n[l_ac].* =  g_imcj4_d[l_ac].*
   END FOR
   LET g_imcj5_d_mask_o.* =  g_imcj5_d.*
   FOR l_ac = 1 TO g_imcj5_d.getLength()
      LET g_imcj5_d_mask_o[l_ac].* =  g_imcj5_d[l_ac].*
      CALL aimi100_imco_t_mask()
      LET g_imcj5_d_mask_n[l_ac].* =  g_imcj5_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aimi100_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM imcj_t
       WHERE imcjent = g_enterprise AND
         imcj001 = ps_keys_bak[1] AND imcj002 = ps_keys_bak[2] AND imcj003 = ps_keys_bak[3]
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
         CALL g_imcj_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM imcn_t
       WHERE imcnent = g_enterprise AND
             imcn001 = ps_keys_bak[1] AND imcn002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_imcj2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM imcl_t
       WHERE imclent = g_enterprise AND
             imcl001 = ps_keys_bak[1] AND imcl002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_imcj3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM imcm_t
       WHERE imcment = g_enterprise AND
             imcm001 = ps_keys_bak[1] AND imcm002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_imcj4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete5"
      
      #end add-point    
      DELETE FROM imco_t
       WHERE imcoent = g_enterprise AND
             imco001 = ps_keys_bak[1] AND imco002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete5"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imco_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_imcj5_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete5"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aimi100_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO imcj_t
                  (imcjent,
                   imcj001,
                   imcj002,imcj003
                   ,imcj004,imcj005,imcj006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_imcj_d[g_detail_idx].imcj004,g_imcj_d[g_detail_idx].imcj005,g_imcj_d[g_detail_idx].imcj006) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_imcj_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO imcn_t
                  (imcnent,
                   imcn001,
                   imcn002
                   ,imcn003) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imcj2_d[g_detail_idx].imcn003)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_imcj2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO imcl_t
                  (imclent,
                   imcl001,
                   imcl002
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_imcj3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO imcm_t
                  (imcment,
                   imcm001,
                   imcm002
                   ,imcm005,imcm003,imcm006,imcm004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imcj4_d[g_detail_idx].imcm005,g_imcj4_d[g_detail_idx].imcm003,g_imcj4_d[g_detail_idx].imcm006, 
                       g_imcj4_d[g_detail_idx].imcm004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_imcj4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert5"
      
      #end add-point 
      INSERT INTO imco_t
                  (imcoent,
                   imco001,
                   imco002
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imco_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_imcj5_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert5"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aimi100_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imcj_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aimi100_imcj_t_mask_restore('restore_mask_o')
               
      UPDATE imcj_t 
         SET (imcj001,
              imcj002,imcj003
              ,imcj004,imcj005,imcj006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_imcj_d[g_detail_idx].imcj004,g_imcj_d[g_detail_idx].imcj005,g_imcj_d[g_detail_idx].imcj006)  
 
         WHERE imcjent = g_enterprise AND imcj001 = ps_keys_bak[1] AND imcj002 = ps_keys_bak[2] AND imcj003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imcj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imcj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimi100_imcj_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imcn_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aimi100_imcn_t_mask_restore('restore_mask_o')
               
      UPDATE imcn_t 
         SET (imcn001,
              imcn002
              ,imcn003) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imcj2_d[g_detail_idx].imcn003) 
         WHERE imcnent = g_enterprise AND imcn001 = ps_keys_bak[1] AND imcn002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imcn_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imcn_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimi100_imcn_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imcl_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aimi100_imcl_t_mask_restore('restore_mask_o')
               
      UPDATE imcl_t 
         SET (imcl001,
              imcl002
              ) 
              = 
             (ps_keys[1],ps_keys[2]
              ) 
         WHERE imclent = g_enterprise AND imcl001 = ps_keys_bak[1] AND imcl002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imcl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imcl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimi100_imcl_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imcm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aimi100_imcm_t_mask_restore('restore_mask_o')
               
      UPDATE imcm_t 
         SET (imcm001,
              imcm002
              ,imcm005,imcm003,imcm006,imcm004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imcj4_d[g_detail_idx].imcm005,g_imcj4_d[g_detail_idx].imcm003,g_imcj4_d[g_detail_idx].imcm006, 
                  g_imcj4_d[g_detail_idx].imcm004) 
         WHERE imcment = g_enterprise AND imcm001 = ps_keys_bak[1] AND imcm002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imcm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imcm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimi100_imcm_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imco_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update5"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aimi100_imco_t_mask_restore('restore_mask_o')
               
      UPDATE imco_t 
         SET (imco001,
              imco002
              ) 
              = 
             (ps_keys[1],ps_keys[2]
              ) 
         WHERE imcoent = g_enterprise AND imco001 = ps_keys_bak[1] AND imco002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update5"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imco_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imco_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimi100_imco_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update5"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aimi100_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aimi100.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aimi100_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aimi100.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aimi100_lock_b(ps_table,ps_page)
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
   #CALL aimi100_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "imcj_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aimi100_bcl USING g_enterprise,
                                       g_imca_m.imca001,g_imcj_d[g_detail_idx].imcj002,g_imcj_d[g_detail_idx].imcj003  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimi100_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "imcn_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aimi100_bcl2 USING g_enterprise,
                                             g_imca_m.imca001,g_imcj2_d[g_detail_idx].imcn002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimi100_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "imcl_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aimi100_bcl3 USING g_enterprise,
                                             g_imca_m.imca001,g_imcj3_d[g_detail_idx].imcl002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimi100_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "imcm_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aimi100_bcl4 USING g_enterprise,
                                             g_imca_m.imca001,g_imcj4_d[g_detail_idx].imcm002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimi100_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'5',"
   #僅鎖定自身table
   LET ls_group = "imco_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aimi100_bcl5 USING g_enterprise,
                                             g_imca_m.imca001,g_imcj5_d[g_detail_idx].imco002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimi100_bcl5:",SQLERRMESSAGE 
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
 
{<section id="aimi100.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aimi100_unlock_b(ps_table,ps_page)
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
      CLOSE aimi100_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aimi100_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aimi100_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aimi100_bcl4
   END IF
 
   LET ls_group = "'5',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aimi100_bcl5
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimi100_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("imca001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("imca029",TRUE)
   CALL cl_set_comp_entry("imca030",TRUE)
   CALL cl_set_comp_entry("imca032",TRUE)
   CALL cl_set_comp_entry("imca033",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimi100_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imca001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_imca_m.imca027 = 'N' THEN
      CALL cl_set_comp_entry("imca029",FALSE)
      CALL cl_set_comp_entry("imca030",FALSE)
      CALL cl_set_comp_entry("imca032",FALSE)
      CALL cl_set_comp_entry("imca033",FALSE)
      LET g_imca_m.imca029 = ""
      LET g_imca_m.imca030 = ""
      LET g_imca_m.imca032 = ""
      LET g_imca_m.imca033 = ""
      DISPLAY g_imca_m.imca029
      DISPLAY g_imca_m.imca030
      DISPLAY g_imca_m.imca032
      DISPLAY g_imca_m.imca033
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aimi100_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("imcn003",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aimi100.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aimi100_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imeb005     LIKE imeb_t.imeb005
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
#   SELECT imeb005 INTO l_imeb005
#     FROM imeb_t
#    WHERE imebent = g_enterprise
#      AND imeb001 = g_imca_m.imca005
#      AND imeb003 = '1'
#      AND imeb004 = g_imcj2_d[l_ac].imcn002
#   IF l_imeb005 = '4' THEN
#      CALL cl_set_comp_entry("imcn003",FALSE)
#   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aimi100.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimi100_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimi100_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aimi100_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aimi100_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimi100_default_search()
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
      LET ls_wc = ls_wc, " imca001 = '", g_argv[01], "' AND "
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
 
         INITIALIZE g_wc2_table5 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "imca_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imcj_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imcn_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "imcl_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "imcm_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "imco_t" 
                  LET g_wc2_table5 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
            OR NOT cl_null(g_wc2_table5)
 
 
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
 
            IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
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
 
{<section id="aimi100.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aimi100_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_imca_m.imca001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aimi100_cl USING g_enterprise,g_imca_m.imca001
   IF STATUS THEN
      CLOSE aimi100_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi100_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aimi100_master_referesh USING g_imca_m.imca001 INTO g_imca_m.imca001,g_imca_m.imca004,g_imca_m.imca005, 
       g_imca_m.imca006,g_imca_m.imca010,g_imca_m.imca201,g_imca_m.imca202,g_imca_m.imca203,g_imca_m.imca204, 
       g_imca_m.imca205,g_imca_m.imca206,g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus,g_imca_m.imca126, 
       g_imca_m.imca127,g_imca_m.imca131,g_imca_m.imca128,g_imca_m.imca129,g_imca_m.imca130,g_imca_m.imca132, 
       g_imca_m.imca133,g_imca_m.imca134,g_imca_m.imca135,g_imca_m.imca136,g_imca_m.imca137,g_imca_m.imca138, 
       g_imca_m.imca139,g_imca_m.imca140,g_imca_m.imca141,g_imca_m.imcaownid,g_imca_m.imcaowndp,g_imca_m.imcacrtid, 
       g_imca_m.imcacrtdp,g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamoddt,g_imca_m.imca011, 
       g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca022,g_imca_m.imca024, 
       g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca033, 
       g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042, 
       g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045,g_imca_m.imca123,g_imca_m.imca003,g_imca_m.imca001_desc, 
       g_imca_m.imca005_desc,g_imca_m.imca006_desc,g_imca_m.imca010_desc,g_imca_m.imca201_desc,g_imca_m.imca202_desc, 
       g_imca_m.imca203_desc,g_imca_m.imca204_desc,g_imca_m.imca205_desc,g_imca_m.imca206_desc,g_imca_m.imca207_desc, 
       g_imca_m.imca208_desc,g_imca_m.imca126_desc,g_imca_m.imca127_desc,g_imca_m.imca131_desc,g_imca_m.imca128_desc, 
       g_imca_m.imca129_desc,g_imca_m.imca132_desc,g_imca_m.imca133_desc,g_imca_m.imca134_desc,g_imca_m.imca135_desc, 
       g_imca_m.imca136_desc,g_imca_m.imca137_desc,g_imca_m.imca138_desc,g_imca_m.imca139_desc,g_imca_m.imca140_desc, 
       g_imca_m.imca141_desc,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid_desc, 
       g_imca_m.imcacrtdp_desc,g_imca_m.imcamodid_desc,g_imca_m.imca018_desc,g_imca_m.imca022_desc,g_imca_m.imca029_desc, 
       g_imca_m.imca032_desc,g_imca_m.imca122_desc,g_imca_m.imca045_desc
   
 
   #檢查是否允許此動作
   IF NOT aimi100_action_chk() THEN
      CLOSE aimi100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imca_m.imca001,g_imca_m.imca001_desc,g_imca_m.imca004,g_imca_m.imca005,g_imca_m.imca005_desc, 
       g_imca_m.imca006,g_imca_m.imca006_desc,g_imca_m.imca010,g_imca_m.imca010_desc,g_imca_m.imca201, 
       g_imca_m.imca201_desc,g_imca_m.imca202,g_imca_m.imca202_desc,g_imca_m.imca203,g_imca_m.imca203_desc, 
       g_imca_m.imca204,g_imca_m.imca204_desc,g_imca_m.imca205,g_imca_m.imca205_desc,g_imca_m.imca206, 
       g_imca_m.imca206_desc,g_imca_m.imca207,g_imca_m.imca207_desc,g_imca_m.imca208,g_imca_m.imca208_desc, 
       g_imca_m.imcastus,g_imca_m.imca126,g_imca_m.imca126_desc,g_imca_m.imca127,g_imca_m.imca127_desc, 
       g_imca_m.imca131,g_imca_m.imca131_desc,g_imca_m.imca128,g_imca_m.imca128_desc,g_imca_m.imca129, 
       g_imca_m.imca129_desc,g_imca_m.imca130,g_imca_m.imca132,g_imca_m.imca132_desc,g_imca_m.imca133, 
       g_imca_m.imca133_desc,g_imca_m.imca134,g_imca_m.imca134_desc,g_imca_m.imca135,g_imca_m.imca135_desc, 
       g_imca_m.imca136,g_imca_m.imca136_desc,g_imca_m.imca137,g_imca_m.imca137_desc,g_imca_m.imca138, 
       g_imca_m.imca138_desc,g_imca_m.imca139,g_imca_m.imca139_desc,g_imca_m.imca140,g_imca_m.imca140_desc, 
       g_imca_m.imca141,g_imca_m.imca141_desc,g_imca_m.imcaownid,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp, 
       g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid,g_imca_m.imcacrtid_desc,g_imca_m.imcacrtdp,g_imca_m.imcacrtdp_desc, 
       g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamodid_desc,g_imca_m.imcamoddt,g_imca_m.imca011, 
       g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca018_desc,g_imca_m.imca022, 
       g_imca_m.imca022_desc,g_imca_m.imca024,g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca029_desc, 
       g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca032_desc,g_imca_m.imca033,g_imca_m.imca036,g_imca_m.imca037, 
       g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041,g_imca_m.imca042,g_imca_m.imca044,g_imca_m.imca122, 
       g_imca_m.imca122_desc,g_imca_m.imca045,g_imca_m.imca045_desc,g_imca_m.imca123,g_imca_m.imca003 
 
 
   CASE g_imca_m.imcastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_imca_m.imcastus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_imca_m.imcastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aimi100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_imca_m.imcamodid = g_user
   LET g_imca_m.imcamoddt = cl_get_current()
   LET g_imca_m.imcastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE imca_t 
      SET (imcastus,imcamodid,imcamoddt) 
        = (g_imca_m.imcastus,g_imca_m.imcamodid,g_imca_m.imcamoddt)     
    WHERE imcaent = g_enterprise AND imca001 = g_imca_m.imca001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aimi100_master_referesh USING g_imca_m.imca001 INTO g_imca_m.imca001,g_imca_m.imca004, 
          g_imca_m.imca005,g_imca_m.imca006,g_imca_m.imca010,g_imca_m.imca201,g_imca_m.imca202,g_imca_m.imca203, 
          g_imca_m.imca204,g_imca_m.imca205,g_imca_m.imca206,g_imca_m.imca207,g_imca_m.imca208,g_imca_m.imcastus, 
          g_imca_m.imca126,g_imca_m.imca127,g_imca_m.imca131,g_imca_m.imca128,g_imca_m.imca129,g_imca_m.imca130, 
          g_imca_m.imca132,g_imca_m.imca133,g_imca_m.imca134,g_imca_m.imca135,g_imca_m.imca136,g_imca_m.imca137, 
          g_imca_m.imca138,g_imca_m.imca139,g_imca_m.imca140,g_imca_m.imca141,g_imca_m.imcaownid,g_imca_m.imcaowndp, 
          g_imca_m.imcacrtid,g_imca_m.imcacrtdp,g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamoddt, 
          g_imca_m.imca011,g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca022, 
          g_imca_m.imca024,g_imca_m.imca026,g_imca_m.imca027,g_imca_m.imca029,g_imca_m.imca030,g_imca_m.imca032, 
          g_imca_m.imca033,g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041, 
          g_imca_m.imca042,g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca045,g_imca_m.imca123,g_imca_m.imca003, 
          g_imca_m.imca001_desc,g_imca_m.imca005_desc,g_imca_m.imca006_desc,g_imca_m.imca010_desc,g_imca_m.imca201_desc, 
          g_imca_m.imca202_desc,g_imca_m.imca203_desc,g_imca_m.imca204_desc,g_imca_m.imca205_desc,g_imca_m.imca206_desc, 
          g_imca_m.imca207_desc,g_imca_m.imca208_desc,g_imca_m.imca126_desc,g_imca_m.imca127_desc,g_imca_m.imca131_desc, 
          g_imca_m.imca128_desc,g_imca_m.imca129_desc,g_imca_m.imca132_desc,g_imca_m.imca133_desc,g_imca_m.imca134_desc, 
          g_imca_m.imca135_desc,g_imca_m.imca136_desc,g_imca_m.imca137_desc,g_imca_m.imca138_desc,g_imca_m.imca139_desc, 
          g_imca_m.imca140_desc,g_imca_m.imca141_desc,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp_desc, 
          g_imca_m.imcacrtid_desc,g_imca_m.imcacrtdp_desc,g_imca_m.imcamodid_desc,g_imca_m.imca018_desc, 
          g_imca_m.imca022_desc,g_imca_m.imca029_desc,g_imca_m.imca032_desc,g_imca_m.imca122_desc,g_imca_m.imca045_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_imca_m.imca001,g_imca_m.imca001_desc,g_imca_m.imca004,g_imca_m.imca005,g_imca_m.imca005_desc, 
          g_imca_m.imca006,g_imca_m.imca006_desc,g_imca_m.imca010,g_imca_m.imca010_desc,g_imca_m.imca201, 
          g_imca_m.imca201_desc,g_imca_m.imca202,g_imca_m.imca202_desc,g_imca_m.imca203,g_imca_m.imca203_desc, 
          g_imca_m.imca204,g_imca_m.imca204_desc,g_imca_m.imca205,g_imca_m.imca205_desc,g_imca_m.imca206, 
          g_imca_m.imca206_desc,g_imca_m.imca207,g_imca_m.imca207_desc,g_imca_m.imca208,g_imca_m.imca208_desc, 
          g_imca_m.imcastus,g_imca_m.imca126,g_imca_m.imca126_desc,g_imca_m.imca127,g_imca_m.imca127_desc, 
          g_imca_m.imca131,g_imca_m.imca131_desc,g_imca_m.imca128,g_imca_m.imca128_desc,g_imca_m.imca129, 
          g_imca_m.imca129_desc,g_imca_m.imca130,g_imca_m.imca132,g_imca_m.imca132_desc,g_imca_m.imca133, 
          g_imca_m.imca133_desc,g_imca_m.imca134,g_imca_m.imca134_desc,g_imca_m.imca135,g_imca_m.imca135_desc, 
          g_imca_m.imca136,g_imca_m.imca136_desc,g_imca_m.imca137,g_imca_m.imca137_desc,g_imca_m.imca138, 
          g_imca_m.imca138_desc,g_imca_m.imca139,g_imca_m.imca139_desc,g_imca_m.imca140,g_imca_m.imca140_desc, 
          g_imca_m.imca141,g_imca_m.imca141_desc,g_imca_m.imcaownid,g_imca_m.imcaownid_desc,g_imca_m.imcaowndp, 
          g_imca_m.imcaowndp_desc,g_imca_m.imcacrtid,g_imca_m.imcacrtid_desc,g_imca_m.imcacrtdp,g_imca_m.imcacrtdp_desc, 
          g_imca_m.imcacrtdt,g_imca_m.imcamodid,g_imca_m.imcamodid_desc,g_imca_m.imcamoddt,g_imca_m.imca011, 
          g_imca_m.imca012,g_imca_m.imca013,g_imca_m.imca014,g_imca_m.imca018,g_imca_m.imca018_desc, 
          g_imca_m.imca022,g_imca_m.imca022_desc,g_imca_m.imca024,g_imca_m.imca026,g_imca_m.imca027, 
          g_imca_m.imca029,g_imca_m.imca029_desc,g_imca_m.imca030,g_imca_m.imca032,g_imca_m.imca032_desc, 
          g_imca_m.imca033,g_imca_m.imca036,g_imca_m.imca037,g_imca_m.imca038,g_imca_m.imca043,g_imca_m.imca041, 
          g_imca_m.imca042,g_imca_m.imca044,g_imca_m.imca122,g_imca_m.imca122_desc,g_imca_m.imca045, 
          g_imca_m.imca045_desc,g_imca_m.imca123,g_imca_m.imca003
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aimi100_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi100_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi100.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aimi100_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_imcj_d.getLength() THEN
         LET g_detail_idx = g_imcj_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imcj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imcj_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_imcj2_d.getLength() THEN
         LET g_detail_idx = g_imcj2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imcj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imcj2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_imcj3_d.getLength() THEN
         LET g_detail_idx = g_imcj3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imcj3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imcj3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_imcj4_d.getLength() THEN
         LET g_detail_idx = g_imcj4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imcj4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imcj4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_imcj5_d.getLength() THEN
         LET g_detail_idx = g_imcj5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imcj5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imcj5_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aimi100_b_fill2(pi_idx)
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
   
   CALL aimi100_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aimi100_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1')  AND 
      (cl_null(g_wc2_table5) OR g_wc2_table5.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aimi100.status_show" >}
PRIVATE FUNCTION aimi100_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimi100.mask_functions" >}
&include "erp/aim/aimi100_mask.4gl"
 
{</section>}
 
{<section id="aimi100.signature" >}
   
 
{</section>}
 
{<section id="aimi100.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimi100_set_pk_array()
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
   LET g_pk_array[1].values = g_imca_m.imca001
   LET g_pk_array[1].column = 'imca001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi100.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aimi100.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimi100_msgcentre_notify(lc_state)
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
   CALL aimi100_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imca_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi100.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimi100_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimi100.other_function" readonly="Y" >}
#imcn單身欄位帶值
PRIVATE FUNCTION aimi100_imcn_desc()
               
    IF cl_null(g_imcj2_d[l_ac].imcn002) THEN    
       LET  g_imcj2_d[l_ac].imcn002_desc = ""
    ELSE           
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_imcj2_d[l_ac].imcn002
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '273' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_imcj2_d[l_ac].imcn002_desc = g_rtn_fields[1]
    END IF
    DISPLAY g_imcj2_d[l_ac].imcn002_desc TO s_detail2[l_ac].imcn002_desc
    #xianghui-mod-b
    CALL aimi100_imcn003_desc()
#    IF cl_null(g_imcj2_d[l_ac].imcn003) THEN    
#       LET  g_imcj2_d[l_ac].imcn003_desc = ""
#    ELSE           
#       INITIALIZE g_ref_fields TO NULL
#       LET g_ref_fields[1] = g_imcj2_d[l_ac].imcn003
#       CALL ap_ref_array2(g_ref_fields,"SELECT imecl005 FROM imecl_t WHERE imeclent='"||g_enterprise||"' AND imecl001= '"||g_imca_m.imca005||"' AND imecl003 = ? AND imecl004='"||g_dlang||"'","") RETURNING g_rtn_fields
#       LET g_imcj2_d[l_ac].imcn003_desc = g_rtn_fields[1]
#    END IF
#    DISPLAY g_imcj2_d[l_ac].imcn003_desc TO s_detail2[l_ac].imcn003_desc
   #xianghui-mod-e
END FUNCTION
#銷售分群碼檢查
PRIVATE FUNCTION aimi100_chk_imcd()
DEFINE l_n       LIKE type_t.num5
   
    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM imcd_t
     WHERE imcd111 = g_imca_m.imca202
       AND imcdsite = 'ALL'
       AND imcdent = g_enterprise
    IF l_n = 0 THEN
       LET g_errno = 'aim-00052'
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM imcd_t
        WHERE imcd111 = g_imca_m.imca202
          AND imcdent = g_enterprise
          AND imcdsite = 'ALL'
          AND imcdstus = 'Y'
       IF l_n = 0 THEN
          LET g_errno =  'sub-01302'  #160318-00005#19 mod 'aim-00053'
       END IF
    END IF
END FUNCTION
# 庫存分群碼檢查
PRIVATE FUNCTION aimi100_chk_imcc()
DEFINE l_n       LIKE type_t.num5
   
    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM imcc_t
     WHERE imcc051 = g_imca_m.imca201
       AND imccsite = 'ALL'
       AND imccent = g_enterprise
    IF l_n = 0 THEN
       LET g_errno = 'aim-00044'
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM imcc_t
        WHERE imcc051 = g_imca_m.imca201
          AND imccsite = 'ALL'
          AND imccent = g_enterprise
          AND imccstus = 'Y'
       IF l_n = 0 THEN
          LET g_errno =  'sub-01302'  #160318-00005#19 mod 'aim-00045'
       END IF
    END IF
END FUNCTION
#參考欄位顯示
PRIVATE FUNCTION aimi100_desc()
   
   IF cl_null(g_imca_m.imca005) THEN
      LET g_imca_m.imca005_desc = ""
   ELSE      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca005
      CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca005_desc = g_rtn_fields[1]
   END IF
   DISPLAY BY NAME g_imca_m.imca005_desc  
   
   IF cl_null(g_imca_m.imca001) THEN
      LET g_imca_m.imca001_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca001
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca001_desc = g_rtn_fields[1]
           
   END IF
   DISPLAY BY NAME g_imca_m.imca001_desc
   
   IF cl_null(g_imca_m.imca006) THEN
      LET g_imca_m.imca006_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca006
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca006_desc = g_rtn_fields[1]
   END IF
   DISPLAY BY NAME g_imca_m.imca006_desc
   
   IF cl_null(g_imca_m.imca010) THEN
      LET g_imca_m.imca010_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca010
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca010_desc = g_rtn_fields[1]
   END IF
   DISPLAY BY NAME g_imca_m.imca010_desc
   
   IF cl_null(g_imca_m.imca205) THEN
      LET g_imca_m.imca205_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca205
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '205' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca205_desc = g_rtn_fields[1] 
   END IF
   DISPLAY BY NAME g_imca_m.imca205_desc
   
   IF cl_null(g_imca_m.imca206) THEN
      LET g_imca_m.imca206_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca206
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca206_desc =  g_rtn_fields[1]
   END IF
   DISPLAY BY NAME g_imca_m.imca206_desc
   
   IF cl_null(g_imca_m.imca207) THEN
      LET g_imca_m.imca207_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca207
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '207' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca207_desc = g_rtn_fields[1] 
   END IF
   DISPLAY BY NAME g_imca_m.imca207_desc
   
   IF cl_null(g_imca_m.imca201) THEN
      LET g_imca_m.imca201_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca201
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '201' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca201_desc = g_rtn_fields[1] 
   END IF
   DISPLAY BY NAME g_imca_m.imca201_desc
   
   IF cl_null(g_imca_m.imca202) THEN
      LET g_imca_m.imca202_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca202
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '202' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca202_desc = g_rtn_fields[1] 
   END IF
   DISPLAY BY NAME g_imca_m.imca202_desc
   
   IF cl_null(g_imca_m.imca203) THEN
      LET g_imca_m.imca203_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca203
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '203' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca203_desc = g_rtn_fields[1]
   END IF
   DISPLAY BY NAME g_imca_m.imca203_desc
   
   IF cl_null(g_imca_m.imca204) THEN
      LET g_imca_m.imca204_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca204
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '204' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca204_desc = g_rtn_fields[1]
   END IF
   DISPLAY BY NAME g_imca_m.imca204_desc
   
   IF cl_null(g_imca_m.imca018) THEN
      LET g_imca_m.imca018_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca018
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca018_desc =  g_rtn_fields[1]
   END IF
   DISPLAY BY NAME g_imca_m.imca018_desc
   
   IF cl_null(g_imca_m.imca022) THEN
      LET g_imca_m.imca022_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca022
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca022_desc = g_rtn_fields[1] 
   END IF
   DISPLAY BY NAME g_imca_m.imca022_desc
  
   IF cl_null(g_imca_m.imca029) THEN
      LET g_imca_m.imca029_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca029
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca029_desc = g_rtn_fields[1] 
   END IF
   DISPLAY BY NAME g_imca_m.imca029_desc
   
   IF cl_null(g_imca_m.imca032) THEN
      LET g_imca_m.imca032_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca032
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca032_desc =  g_rtn_fields[1] 
   END IF
   DISPLAY BY NAME g_imca_m.imca032_desc
   
   IF cl_null(g_imca_m.imca045) THEN
      LET g_imca_m.imca045_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca045
      CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca045_desc =  g_rtn_fields[1] 
   END IF
   DISPLAY BY NAME g_imca_m.imca045_desc
   
   IF cl_null(g_imca_m.imca122) THEN
      LET g_imca_m.imca122_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imca_m.imca122
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2000' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imca_m.imca122_desc = g_rtn_fields[1]
   END IF
   DISPLAY BY NAME g_imca_m.imca122_desc
END FUNCTION
#imcl單身欄位帶值
PRIVATE FUNCTION aimi100_imcl_desc()
    
    IF cl_null(g_imcj3_d[l_ac].imcl002) THEN    
       LET g_imcj3_d[l_ac].oocql004 = ""
       LET g_imcj3_d[l_ac].oocq005 = ""
    ELSE           
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_imcj3_d[l_ac].imcl002
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '213' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_imcj3_d[l_ac].oocql004 = g_rtn_fields[1]
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_imcj3_d[l_ac].imcl002
       CALL ap_ref_array2(g_ref_fields,"SELECT oocq005 FROM oocq_t WHERE oocqent='"||g_enterprise||"' AND oocq001= '213' AND oocq002=? ","") RETURNING g_rtn_fields
       LET g_imcj3_d[l_ac].oocq005 = g_rtn_fields[1]
    END IF
    DISPLAY g_imcj3_d[l_ac].oocql004 TO s_detail3[l_ac].oocql004
    DISPLAY g_imcj3_d[l_ac].oocq005 TO s_detail3[l_ac].oocq005
END FUNCTION
#成份與物質單身參考欄位顯示
PRIVATE FUNCTION aimi100_imcj_desc()
   IF cl_null(g_imcj_d[l_ac].imcj002) THEN    
      LET  g_imcj_d[l_ac].imcj002_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imcj_d[l_ac].imcj002
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '270' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imcj_d[l_ac].imcj002_desc = g_rtn_fields[1]
   END IF   
   DISPLAY  g_imcj_d[l_ac].imcj002_desc TO s_detail1[l_ac].imcj002_desc
   
   IF cl_null(g_imcj_d[l_ac].imcj003) THEN    
      LET  g_imcj_d[l_ac].imcj003_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imcj_d[l_ac].imcj003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '271' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imcj_d[l_ac].imcj003_desc = g_rtn_fields[1]
   END IF
   DISPLAY  g_imcj_d[l_ac].imcj003_desc TO s_detail1[l_ac].imcj003_desc
   
   IF cl_null(g_imcj_d[l_ac].imcj005) THEN    
      LET  g_imcj_d[l_ac].imcj005_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imcj_d[l_ac].imcj005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imcj_d[l_ac].imcj005_desc = g_rtn_fields[1]
   END IF
   DISPLAY  g_imcj_d[l_ac].imcj005_desc TO s_detail1[l_ac].imcj005_desc
   
   IF cl_null(g_imcj_d[l_ac].imcj006) THEN    
      LET  g_imcj_d[l_ac].imcj006_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imcj_d[l_ac].imcj006
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '272' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imcj_d[l_ac].imcj006_desc = g_rtn_fields[1]
   END IF
   DISPLAY  g_imcj_d[l_ac].imcj006_desc TO s_detail1[l_ac].imcj006_desc
END FUNCTION
# 国家地区检查
PRIVATE FUNCTION aimi100_chk_oocg()
DEFINE l_n       LIKE type_t.num5

    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM oocg_t
     WHERE oocg001 = g_imca_m.imca045
       AND oocgent = g_enterprise
    IF l_n = 0 THEN
       LET g_errno = 'aoo-00013'
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM oocg_t
        WHERE oocg001 = g_imca_m.imca045
          AND oocgent = g_enterprise
          AND oocgstus = 'Y'
       IF l_n = 0 THEN
          LET g_errno =  'sub-01302'  #160318-00005#19 mod 'aoo-00035'
       END IF
    END IF
END FUNCTION
# 生管分群碼檢查
PRIVATE FUNCTION aimi100_chk_imcf()
DEFINE l_n       LIKE type_t.num5
   
    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM imcf_t
     WHERE imcf011 = g_imca_m.imca204
       AND imcfsite = 'ALL'
       AND imcfent = g_enterprise
    IF l_n = 0 THEN
       LET g_errno = 'aim-00050'
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM imcf_t
        WHERE imcf011 = g_imca_m.imca204
          AND imcfent = g_enterprise
          AND imcfsite = 'ALL'
          AND imcfstus = 'Y'
       IF l_n = 0 THEN
          LET g_errno =  'sub-01302'  #160318-00005#19 mod 'aim-00051'
       END IF
    END IF
END FUNCTION
# 採購分群碼檢查
PRIVATE FUNCTION aimi100_chk_imce()
DEFINE l_n       LIKE type_t.num5
   
    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM imce_t
     WHERE imce141 = g_imca_m.imca203
       AND imcesite = 'ALL'
       AND imceent = g_enterprise
    IF l_n = 0 THEN
       LET g_errno = 'aim-00048'
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM imce_t
        WHERE imce141 = g_imca_m.imca203
          AND imceent = g_enterprise
          AND imcesite = 'ALL'
          AND imcestus = 'Y'
       IF l_n = 0 THEN
          LET g_errno =  'sub-01302'  #160318-00005#19 mod 'aim-00049'
       END IF
    END IF
END FUNCTION
# 單位存在有效否檢查
PRIVATE FUNCTION aimi100_chk_ooca(p_ooca001)
DEFINE p_ooca001      LIKE ooca_t.ooca001
    DEFINE l_n            LIKE type_t.num5
    
    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM ooca_t
     WHERE ooca001 = p_ooca001
       AND oocaent = g_enterprise
    IF l_n = 0 THEN
       LET g_errno = 'aim-00004'
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM ooca_t
        WHERE ooca001 = p_ooca001
          AND oocaent = g_enterprise
          AND oocastus = 'Y'
       IF l_n = 0 THEN
          LET g_errno =  'sub-01302'  #160318-00005#19 mod 'aim-00005'
       END IF
    END IF
END FUNCTION
# 品管分群碼檢查
PRIVATE FUNCTION aimi100_chk_imcg()
DEFINE l_n       LIKE type_t.num5
   
    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM imcg_t
     WHERE imcg111 = g_imca_m.imca205
       AND imcgsite = 'ALL'
       AND imcgent = g_enterprise
    IF l_n = 0 THEN
       LET g_errno = 'aim-00042'
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM imcg_t
        WHERE imcg111 = g_imca_m.imca205
          AND imcgent = g_enterprise
          AND imcgsite = 'ALL'
          AND imcgstus = 'Y'
       IF l_n = 0 THEN
          LET g_errno =  'sub-01302'  #160318-00005#19 mod 'aim-00043'
       END IF
    END IF
END FUNCTION
################################################################################
# Descriptions...: 新增料件主分群特徵檔
# Memo...........:
# Usage..........: CALL aimi100_ins_imcn()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success
# Date & Author..: 2013/11/01 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi100_ins_imcn()
DEFINE l_sql            STRING
DEFINE r_success        LIKE type_t.num5
#DEFINE l_imeb           RECORD LIKE imeb_t.*  #161124-00048#2   2016/12/07 By 08734 mark
#161124-00048#2   2016/12/07 By 08734 add(S)
DEFINE l_imeb RECORD  #料件特徵群組單身檔
       imebent LIKE imeb_t.imebent, #企业编号
       imeb001 LIKE imeb_t.imeb001, #特征群组编号
       imeb002 LIKE imeb_t.imeb002, #项次
       imeb003 LIKE imeb_t.imeb003, #归属层级
       imeb004 LIKE imeb_t.imeb004, #类型
       imeb005 LIKE imeb_t.imeb005, #赋值方式
       imeb006 LIKE imeb_t.imeb006, #属性类型
       imeb007 LIKE imeb_t.imeb007, #码长
       imeb008 LIKE imeb_t.imeb008, #小数字数
       imeb009 LIKE imeb_t.imeb009, #默认值
       imeb010 LIKE imeb_t.imeb010, #最小限制
       imeb011 LIKE imeb_t.imeb011, #最大限制
       imeb012 LIKE imeb_t.imeb012, #二维录入
       imeb013 LIKE imeb_t.imeb013 #限定数据源
END RECORD
#161124-00048#2   2016/12/07 By 08734 add(E)
#DEFINE l_imcn           RECORD LIKE imcn_t.*  #161124-00048#2   2016/12/07 By 08734 mark
#161124-00048#2   2016/12/07 By 08734 add(S)
DEFINE l_imcn RECORD  #料件主分群特徵檔
       imcnent LIKE imcn_t.imcnent, #企业编号
       imcn001 LIKE imcn_t.imcn001, #主分群码
       imcn002 LIKE imcn_t.imcn002, #特征类型
       imcn003 LIKE imcn_t.imcn003 #特征值
END RECORD
#161124-00048#2   2016/12/07 By 08734 add(E)
DEFINE l_n              LIKE type_t.num5

   LET r_success = TRUE
   INITIALIZE l_imeb.* TO NULL
   DELETE FROM imcn_t WHERE imcnent = g_enterprise AND imcn001 = g_imca_m.imca001
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #LET l_sql = " SELECT * FROM imeb_t",  #161124-00048#2   2016/12/07 By 08734 mark
   LET l_sql = " SELECT imebent,imeb001,imeb002,imeb003,imeb004,imeb005,imeb006,imeb007,imeb008,imeb009,imeb010,imeb011,imeb012,imeb013 FROM imeb_t",  #161124-00048#2   2016/12/07 By 08734 add  
               "  WHERE imebent = '",g_enterprise,"'",
               "    AND imeb001 = '",g_imca_m.imca005,"'",
               "    AND imeb003 = '1' "
   PREPARE aimi100_sel_imeb_p FROM l_sql
   DECLARE aimi100_sel_imeb_c CURSOR FOR aimi100_sel_imeb_p
   FOREACH aimi100_sel_imeb_c INTO l_imeb.*
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      INITIALIZE l_imcn.* TO NULL
      LET l_imcn.imcnent = g_enterprise
      LET l_imcn.imcn001 = g_imca_m.imca001
      LET l_imcn.imcn002 = l_imeb.imeb004
      LET l_imcn.imcn003 = l_imeb.imeb009
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM imcn_t
       WHERE imcnent = l_imcn.imcnent
         AND imcn001 = l_imcn.imcn001
         AND imcn002 = l_imcn.imcn002
      IF l_n = 0 THEN
         #INSERT INTO imcn_t VALUES(l_imcn.*)  #161124-00048#2   2016/12/07 By 08734 mark
         INSERT INTO imcn_t(imcnent,imcn001,imcn002,imcn003) 
           VALUES(l_imcn.imcnent,l_imcn.imcn001,l_imcn.imcn002,l_imcn.imcn003)  #161124-00048#2   2016/12/07 By 08734 add
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      ELSE
         UPDATE imcn_t SET imcn003 = l_imcn.imcn003
          WHERE imcnent = l_imcn.imcnent
            AND imcn001 = l_imcn.imcn001
            AND imcn002 = l_imcn.imcn002
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END FOREACH
   
   CALL aimi100_b_fill()
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...:特徵值賦值
# Memo...........:
# Usage..........: CALL aimi100_def_imcn003()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/01 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi100_def_imcn003()
   SELECT imeb009 INTO g_imcj2_d[l_ac].imcn003
     FROM imeb_t
    WHERE imebent = g_enterprise
      AND imeb001 = g_imca_m.imca005
      AND imeb003 = '1'
      AND imeb004 = g_imcj2_d[l_ac].imcn002
   DISPLAY BY NAME g_imcj2_d[l_ac].imcn003
END FUNCTION
# 單位存在有效否檢查
PRIVATE FUNCTION aimi100_chk_ooca003(p_ooca001,p_ooca003)
DEFINE p_ooca001      LIKE ooca_t.ooca001
DEFINE p_ooca003      LIKE ooca_t.ooca003
DEFINE l_n            LIKE type_t.num5
    
    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM ooca_t
     WHERE ooca001 = p_ooca001
       AND oocaent = g_enterprise
       AND ooca003 = p_ooca003
    IF l_n = 0 THEN
       LET g_errno = 'aim-00183'
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM ooca_t
        WHERE ooca001 = p_ooca001
          AND oocaent = g_enterprise
          AND ooca003 = p_ooca003
          AND oocastus = 'Y'
       IF l_n = 0 THEN
          LET g_errno = 'aim-00184'
       END IF
    END IF
END FUNCTION
################################################################################
# Descriptions...: 顯示對應aimi092的資料
# Memo...........:
# Usage..........: CALL aimi100_display_imeb()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/12/27 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi100_display_imeb()
DEFINE l_imeb005_1          LIKE imeb_t.imeb005
DEFINE l_imeb007_1          LIKE imeb_t.imeb007
DEFINE l_imeb008_1          LIKE imeb_t.imeb008
DEFINE l_imeb010_1          LIKE imeb_t.imeb010
DEFINE l_imeb011_1          LIKE imeb_t.imeb011
DEFINE l_gzze003            LIKE gzze_t.gzze003
DEFINE l_gzze003_1          LIKE gzze_t.gzze003
DEFINE l_gzze003_2          LIKE gzze_t.gzze003
DEFINE l_msg                STRING
DEFINE l_imeb005            STRING
DEFINE l_imeb007            STRING
DEFINE l_imeb008            STRING
DEFINE l_imeb010            STRING
DEFINE l_imeb011            STRING

   LET l_imeb005 = ''
   LET l_imeb007 = ''
   LET l_imeb008 = ''
   LET l_imeb010 = ''
   LET l_imeb011 = ''
   SELECT imeb005,imeb007,imeb008,imeb010,imeb011 INTO l_imeb005_1,l_imeb007_1,l_imeb008_1,l_imeb010_1,l_imeb011_1
     FROM imeb_t
    WHERE imebent = g_enterprise
      AND imeb001 = g_imca_m.imca005
      AND imeb004 = g_imcj2_d[l_ac].imcn002
   LET l_imeb005 = l_imeb005_1
   LET l_imeb007 = l_imeb007_1
   LET l_imeb008 = l_imeb008_1
   LET l_imeb010 = l_imeb010_1
   LET l_imeb011 = l_imeb011_1
   IF l_imeb005 = '1' THEN
      LET l_msg =''
      LET l_gzze003 = ''
      LET l_gzze003_1 = ''
      SELECT gzze003 INTO l_gzze003
        FROM gzze_t
       WHERE gzze001 = 'aim-00197'
         AND gzze002 = g_dlang
      SELECT gzze003 INTO l_gzze003_1
        FROM gzze_t
       WHERE gzze001 = 'aim-00198'
         AND gzze002 = g_dlang   
      LET l_msg = l_gzze003,l_imeb007,',',l_gzze003_1,l_imeb008
      ERROR l_msg
   END IF
   IF l_imeb005 = '3' THEN
      LET l_msg =''
      LET l_gzze003_2 = ''
      SELECT gzze003 INTO l_gzze003_2
        FROM gzze_t
       WHERE gzze001 = 'aim-00199'
         AND gzze002 = g_dlang
      LET l_msg = l_gzze003_2,l_imeb010,'~',l_imeb011
      ERROR l_msg
   END IF
END FUNCTION
################################################################################
# Descriptions...: imco單身欄位帶值
# Memo...........:
# Usage..........: CALL aimi100_imco_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/01/24 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimi100_imco_desc()
    IF cl_null(g_imcj5_d[l_ac].imco002) THEN    
       LET g_imcj5_d[l_ac].imco002_desc = ""
    ELSE           
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_imcj5_d[l_ac].imco002
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001= ? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_imcj5_d[l_ac].imco002_desc = g_rtn_fields[1]
    END IF
    DISPLAY g_imcj5_d[l_ac].imco002_desc TO s_detail5[l_ac].imco002_desc
END FUNCTION

PRIVATE FUNCTION aimi100_oocql004_desc(p_oocql001,p_oocql002)
DEFINE p_oocql001   LIKE oocql_t.oocql001,
       p_oocql002   LIKE oocql_t.oocql002,
       r_oocql004   LIKE oocql_t.oocql004
       
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocql001
   LET g_ref_fields[2] = p_oocql002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 =? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_oocql004 = g_rtn_fields[1]     
   RETURN r_oocql004   
END FUNCTION

PRIVATE FUNCTION aimi100_imcn003_desc()
DEFINE l_imeb002  LIKE imeb_t.imeb002 


    IF cl_null(g_imcj2_d[l_ac].imcn003) THEN    
       LET  g_imcj2_d[l_ac].imcn003_desc = ""
    ELSE 
       SELECT imeb002 INTO l_imeb002 
         FROM imeb_t
        WHERE imebent = g_enterprise
          AND imeb001 = g_imca_m.imca005
          AND imeb004 = g_imcj2_d[l_ac].imcn002    
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_imcj2_d[l_ac].imcn003
       CALL ap_ref_array2(g_ref_fields,"SELECT imecl005 FROM imecl_t WHERE imeclent='"||g_enterprise||"' AND imecl001= '"||g_imca_m.imca005||"' AND imecl002="||l_imeb002||" AND imecl003 = ? AND imecl004='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_imcj2_d[l_ac].imcn003_desc = g_rtn_fields[1]
    END IF
    DISPLAY g_imcj2_d[l_ac].imcn003_desc TO s_detail2[l_ac].imcn003_desc
END FUNCTION

 
{</section>}
 
