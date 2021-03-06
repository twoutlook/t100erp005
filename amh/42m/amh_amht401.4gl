#該程式未解開Section, 採用最新樣板產出!
{<section id="amht401.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2016-08-03 14:31:43), PR版次:0014(2016-08-29 16:01:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: amht401
#+ Description: 商戶預登記維護作業
#+ Creator....: 06814(2016-04-15 11:34:49)
#+ Modifier...: 03247 -SD/PR- 08742
 
{</section>}
 
{<section id="amht401.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160512-00003#7   2016/05/18   by 08172    画面调整和商户带来源单号及栏位检查
#160816-00068#8   2016/08/17   By 08209    調整transaction
#160818-00017#20  2016/08/29   By 08742    删除修改未重新判断状态码
#add by geza 20160628    自动编码调整
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL aoo_aooi350_01
IMPORT FGL aoo_aooi350_02
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../aoo/4gl/aooi350_01.inc"
GLOBALS "../../aoo/4gl/aooi350_02.inc"
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_mhbg_m        RECORD
       mhbgsite LIKE mhbg_t.mhbgsite, 
   mhbgsite_desc LIKE type_t.chr80, 
   mhbgdocdt LIKE mhbg_t.mhbgdocdt, 
   mhbgdocno LIKE mhbg_t.mhbgdocno, 
   mhbg034 LIKE mhbg_t.mhbg034, 
   mhbg001 LIKE mhbg_t.mhbg001, 
   mhbgl003 LIKE mhbgl_t.mhbgl003, 
   mhbg039 LIKE mhbg_t.mhbg039, 
   mhbg039_desc LIKE type_t.chr80, 
   mhbgl004 LIKE mhbgl_t.mhbgl004, 
   mhbgl005 LIKE mhbgl_t.mhbgl005, 
   mhbg018 LIKE mhbg_t.mhbg018, 
   mhbg000 LIKE mhbg_t.mhbg000, 
   mhbgstus LIKE mhbg_t.mhbgstus, 
   mhbg002 LIKE mhbg_t.mhbg002, 
   mhbg003 LIKE mhbg_t.mhbg003, 
   mhbg003_desc LIKE type_t.chr80, 
   mhbg004 LIKE mhbg_t.mhbg004, 
   mhbg004_desc LIKE type_t.chr80, 
   mhbg005 LIKE mhbg_t.mhbg005, 
   mhbg005_desc LIKE type_t.chr80, 
   mhbg006 LIKE mhbg_t.mhbg006, 
   mhbg035 LIKE mhbg_t.mhbg035, 
   mhbg008 LIKE mhbg_t.mhbg008, 
   mhbg007 LIKE mhbg_t.mhbg007, 
   mhbg038 LIKE mhbg_t.mhbg038, 
   mhbg009 LIKE mhbg_t.mhbg009, 
   mhbg010 LIKE mhbg_t.mhbg010, 
   mhbg010_desc LIKE type_t.chr80, 
   mhbg012 LIKE mhbg_t.mhbg012, 
   mhbg013 LIKE mhbg_t.mhbg013, 
   mhbg013_desc LIKE type_t.chr80, 
   mhbg011 LIKE mhbg_t.mhbg011, 
   mhbg014 LIKE mhbg_t.mhbg014, 
   mhbg014_desc LIKE type_t.chr80, 
   mhbg015 LIKE mhbg_t.mhbg015, 
   mhbg015_desc LIKE type_t.chr80, 
   mhbg016 LIKE mhbg_t.mhbg016, 
   mhbg036 LIKE mhbg_t.mhbg036, 
   mhbg017 LIKE mhbg_t.mhbg017, 
   mhbg017_desc LIKE type_t.chr80, 
   mhbg020 LIKE mhbg_t.mhbg020, 
   mhbg037 LIKE mhbg_t.mhbg037, 
   mhbg028 LIKE mhbg_t.mhbg028, 
   mhbg028_desc LIKE type_t.chr80, 
   mhbg029 LIKE mhbg_t.mhbg029, 
   mhbg029_desc LIKE type_t.chr80, 
   mhbg030 LIKE mhbg_t.mhbg030, 
   mhbg031 LIKE mhbg_t.mhbg031, 
   mhbg031_desc LIKE type_t.chr80, 
   mhbg032 LIKE mhbg_t.mhbg032, 
   mhbg032_desc LIKE type_t.chr80, 
   mhbg033 LIKE mhbg_t.mhbg033, 
   mhbg033_desc LIKE type_t.chr80, 
   ooff013 LIKE type_t.chr500, 
   mhbgownid LIKE mhbg_t.mhbgownid, 
   mhbgownid_desc LIKE type_t.chr80, 
   mhbgowndp LIKE mhbg_t.mhbgowndp, 
   mhbgowndp_desc LIKE type_t.chr80, 
   mhbgcrtid LIKE mhbg_t.mhbgcrtid, 
   mhbgcrtid_desc LIKE type_t.chr80, 
   mhbgcrtdp LIKE mhbg_t.mhbgcrtdp, 
   mhbgcrtdp_desc LIKE type_t.chr80, 
   mhbgcrtdt LIKE mhbg_t.mhbgcrtdt, 
   mhbgmodid LIKE mhbg_t.mhbgmodid, 
   mhbgmodid_desc LIKE type_t.chr80, 
   mhbgmoddt LIKE mhbg_t.mhbgmoddt, 
   mhbgcnfid LIKE mhbg_t.mhbgcnfid, 
   mhbgcnfid_desc LIKE type_t.chr80, 
   mhbgcnfdt LIKE mhbg_t.mhbgcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mhbh_d        RECORD
       mhbh001 LIKE mhbh_t.mhbh001, 
   mhbhacti LIKE mhbh_t.mhbhacti, 
   mhbh002 LIKE mhbh_t.mhbh002, 
   mhbh002_desc LIKE type_t.chr500, 
   mhbh003 LIKE mhbh_t.mhbh003, 
   mhbh004 LIKE mhbh_t.mhbh004, 
   mhbh007 LIKE mhbh_t.mhbh007, 
   mhbh008 LIKE mhbh_t.mhbh008
       END RECORD
PRIVATE TYPE type_g_mhbh2_d RECORD
       mhbiacti LIKE mhbi_t.mhbiacti, 
   mhbi001 LIKE mhbi_t.mhbi001, 
   mhbi002 LIKE mhbi_t.mhbi002, 
   mhbi002_desc LIKE type_t.chr500, 
   mhbi003 LIKE mhbi_t.mhbi003, 
   mhbi003_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mhbgsite LIKE mhbg_t.mhbgsite,
   b_mhbgsite_desc LIKE type_t.chr80,
      b_mhbgdocdt LIKE mhbg_t.mhbgdocdt,
      b_mhbgdocno LIKE mhbg_t.mhbgdocno,
      b_mhbg001 LIKE mhbg_t.mhbg001,
   b_mhbg001_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_ooef019             LIKE ooef_t.ooef019
DEFINE g_mhbg037             LIKE mhbg_t.mhbg037
GLOBALS
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i35001      STRING             #聯絡地址QBE條件
   DEFINE g_wc2_i35002      STRING             #通訊方式QBE條件
   DEFINE g_d_idx_i35001    LIKE type_t.num5   #聯絡地址所在筆數
   DEFINE g_d_cnt_i35001    LIKE type_t.num5   #聯絡地址總筆數
   DEFINE g_d_idx_i35002    LIKE type_t.num5   #通訊方式所在筆數
   DEFINE g_d_cnt_i35002    LIKE type_t.num5   #通訊方式總筆數
   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
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
   DEFINE g_oofb_d2         DYNAMIC ARRAY OF type_g_oofb_d
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
   DEFINE g_oofc_d2          DYNAMIC ARRAY OF type_g_oofc_d
END GLOBALS
DEFINE g_site_flag          LIKE type_t.num5
DEFINE g_detail_id          STRING             #紀錄停留在聯絡地址, 通訊方式或不在此兩個Page
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mhbg_m          type_g_mhbg_m
DEFINE g_mhbg_m_t        type_g_mhbg_m
DEFINE g_mhbg_m_o        type_g_mhbg_m
DEFINE g_mhbg_m_mask_o   type_g_mhbg_m #轉換遮罩前資料
DEFINE g_mhbg_m_mask_n   type_g_mhbg_m #轉換遮罩後資料
 
   DEFINE g_mhbgdocno_t LIKE mhbg_t.mhbgdocno
 
 
DEFINE g_mhbh_d          DYNAMIC ARRAY OF type_g_mhbh_d
DEFINE g_mhbh_d_t        type_g_mhbh_d
DEFINE g_mhbh_d_o        type_g_mhbh_d
DEFINE g_mhbh_d_mask_o   DYNAMIC ARRAY OF type_g_mhbh_d #轉換遮罩前資料
DEFINE g_mhbh_d_mask_n   DYNAMIC ARRAY OF type_g_mhbh_d #轉換遮罩後資料
DEFINE g_mhbh2_d          DYNAMIC ARRAY OF type_g_mhbh2_d
DEFINE g_mhbh2_d_t        type_g_mhbh2_d
DEFINE g_mhbh2_d_o        type_g_mhbh2_d
DEFINE g_mhbh2_d_mask_o   DYNAMIC ARRAY OF type_g_mhbh2_d #轉換遮罩前資料
DEFINE g_mhbh2_d_mask_n   DYNAMIC ARRAY OF type_g_mhbh2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      mhbgldocno LIKE mhbgl_t.mhbgldocno,
      mhbgl001 LIKE mhbgl_t.mhbgl001,
      mhbgl003 LIKE mhbgl_t.mhbgl003,
      mhbgl004 LIKE mhbgl_t.mhbgl004,
      mhbgl005 LIKE mhbgl_t.mhbgl005
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
 
 
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
 
{<section id="amht401.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amh","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mhbgsite,'',mhbgdocdt,mhbgdocno,mhbg034,mhbg001,'',mhbg039,'','','',mhbg018, 
       mhbg000,mhbgstus,mhbg002,mhbg003,'',mhbg004,'',mhbg005,'',mhbg006,mhbg035,mhbg008,mhbg007,mhbg038, 
       mhbg009,mhbg010,'',mhbg012,mhbg013,'',mhbg011,mhbg014,'',mhbg015,'',mhbg016,mhbg036,mhbg017,'', 
       mhbg020,mhbg037,mhbg028,'',mhbg029,'',mhbg030,mhbg031,'',mhbg032,'',mhbg033,'','',mhbgownid,'', 
       mhbgowndp,'',mhbgcrtid,'',mhbgcrtdp,'',mhbgcrtdt,mhbgmodid,'',mhbgmoddt,mhbgcnfid,'',mhbgcnfdt", 
        
                      " FROM mhbg_t",
                      " WHERE mhbgent= ? AND mhbgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amht401_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mhbgsite,t0.mhbgdocdt,t0.mhbgdocno,t0.mhbg034,t0.mhbg001,t0.mhbg039, 
       t0.mhbg018,t0.mhbg000,t0.mhbgstus,t0.mhbg002,t0.mhbg003,t0.mhbg004,t0.mhbg005,t0.mhbg006,t0.mhbg035, 
       t0.mhbg008,t0.mhbg007,t0.mhbg038,t0.mhbg009,t0.mhbg010,t0.mhbg012,t0.mhbg013,t0.mhbg011,t0.mhbg014, 
       t0.mhbg015,t0.mhbg016,t0.mhbg036,t0.mhbg017,t0.mhbg020,t0.mhbg037,t0.mhbg028,t0.mhbg029,t0.mhbg030, 
       t0.mhbg031,t0.mhbg032,t0.mhbg033,t0.mhbgownid,t0.mhbgowndp,t0.mhbgcrtid,t0.mhbgcrtdp,t0.mhbgcrtdt, 
       t0.mhbgmodid,t0.mhbgmoddt,t0.mhbgcnfid,t0.mhbgcnfdt,t1.ooefl003 ,t2.oocql004 ,t3.pmaal003 ,t4.oocql004 , 
       t5.oocgl003 ,t6.ooail003 ,t7.ooail003 ,t8.oocql004 ,t9.oocql004 ,t10.oocql004 ,t11.ooail003 , 
       t12.oocql004 ,t13.oocql004 ,t14.ooag011 ,t15.ooefl003 ,t16.ooag011 ,t17.ooefl003 ,t18.ooag011 , 
       t19.ooag011",
               " FROM mhbg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhbgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='251' AND t2.oocql002=t0.mhbg039 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.mhbg003 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='261' AND t4.oocql002=t0.mhbg004 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t5 ON t5.oocglent="||g_enterprise||" AND t5.oocgl001=t0.mhbg005 AND t5.oocgl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t6 ON t6.ooailent="||g_enterprise||" AND t6.ooail001=t0.mhbg010 AND t6.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t7 ON t7.ooailent="||g_enterprise||" AND t7.ooail001=t0.mhbg013 AND t7.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='254' AND t8.oocql002=t0.mhbg014 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='260' AND t9.oocql002=t0.mhbg015 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='250' AND t10.oocql002=t0.mhbg017 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t11 ON t11.ooailent="||g_enterprise||" AND t11.ooail001=t0.mhbg028 AND t11.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='3211' AND t12.oocql002=t0.mhbg032 AND t12.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='3111' AND t13.oocql002=t0.mhbg033 AND t13.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.mhbgownid  ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=t0.mhbgowndp AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.mhbgcrtid  ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=t0.mhbgcrtdp AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=t0.mhbgmodid  ",
               " LEFT JOIN ooag_t t19 ON t19.ooagent="||g_enterprise||" AND t19.ooag001=t0.mhbgcnfid  ",
 
               " WHERE t0.mhbgent = " ||g_enterprise|| " AND t0.mhbgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amht401_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amht401 WITH FORM cl_ap_formpath("amh",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amht401_init()   
 
      #進入選單 Menu (="N")
      CALL amht401_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amht401
      
   END IF 
   
   CLOSE amht401_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   CALL s_aooi390_drop_tmp_table() 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amht401.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amht401_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('mhbgstus','13','N,Y,F,A,D,R,W,X')
 
      CALL cl_set_combo_scc('mhbg002','2015') 
   CALL cl_set_combo_scc('mhbg030','8322') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL s_aooi390_cre_tmp_table() RETURNING l_success
   LET g_ooef019 = '' 
   LET g_ooef004 = ''
   SELECT ooef004,ooef019 INTO g_ooef004,g_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
   CALL s_life_cycle_display(g_prog,'mhbg018','2') #生命週期set_combo
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_01"), "grid_17", "Table", "s_detail1_aooi350_01")
   CALL cl_set_combo_scc('oofb008','9')   #地址類型
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_02"), "grid_18", "Table", "s_detail1_aooi350_02")
   CALL cl_set_combo_scc('oofc008','6')   #通訊類型
   #依作業隱藏單頭
   CALL amht401_set_comp_visible()
   CALL amht401_set_no_required()   #160601-00025#1 20160602 add by beckxie
   CALL amht401_set_required()      #160601-00025#1 20160602 add by beckxie
   #160512-00003#7
   #IF g_argv[1] = '2' THEN
   #   CALL cl_set_comp_required('mhbg028,mhbg029,mhbg030,mhbg031,mhbg032,mhbg033',TRUE)
   #END IF
   #end add-point
   
   #初始化搜尋條件
   CALL amht401_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amht401.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amht401_ui_dialog()
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
            CALL amht401_insert()
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
         INITIALIZE g_mhbg_m.* TO NULL
         CALL g_mhbh_d.clear()
         CALL g_mhbh2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amht401_init()
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
               
               CALL amht401_fetch('') # reload data
               LET l_ac = 1
               CALL amht401_ui_detailshow() #Setting the current row 
         
               CALL amht401_idx_chk()
               #NEXT FIELD mhbh002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mhbh_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amht401_idx_chk()
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
               CALL amht401_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_mhbh2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amht401_idx_chk()
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
               CALL amht401_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         SUBDIALOG aoo_aooi350_01.aooi350_01_display
         SUBDIALOG aoo_aooi350_02.aooi350_02_display
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL amht401_browser_fill("")
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
               CALL amht401_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amht401_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL amht401_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL amht401_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL amht401_set_act_visible()   
            CALL amht401_set_act_no_visible()
            IF NOT (g_mhbg_m.mhbgdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mhbgent = " ||g_enterprise|| " AND",
                                  " mhbgdocno = '", g_mhbg_m.mhbgdocno, "' "
 
               #填到對應位置
               CALL amht401_browser_fill("")
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
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mhbg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mhbh_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mhbi_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL amht401_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mhbg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mhbh_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mhbi_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL amht401_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL amht401_fetch("F")
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
               CALL amht401_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amht401_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht401_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amht401_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht401_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amht401_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht401_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amht401_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht401_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amht401_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht401_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mhbh_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mhbh2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[3] = base.typeInfo.create(g_oofb_d2)
                  LET g_export_id[3]   = "s_detail1_aooi350_01"
                  LET g_export_node[4] = base.typeInfo.create(g_oofc_d2)
                  LET g_export_id[4]   = "s_detail1_aooi350_02"
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
               NEXT FIELD mhbh002
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
               CALL amht401_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amht401_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amht401_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amht401_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amh/amht401_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amh/amht401_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL amht401_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amht401_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aooi350
            LET g_action_choice="open_aooi350"
            IF cl_auth_chk_act("open_aooi350") THEN
               
               #add-point:ON ACTION open_aooi350 name="menu.open_aooi350"
               IF (NOT cl_null(g_mhbg_m.mhbgdocno)) AND (NOT cl_null(g_mhbg_m.mhbg001)) THEN
                  LET la_param.prog = 'apmi100'
                  LET la_param.param[1] = g_mhbg_m.mhbg001
                  LET ls_js = util.JSON.stringify( la_param )     
                  CALL cl_cmdrun(ls_js)
               END IF      
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amht401_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amht401_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amht401_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mhbg_m.mhbgdocdt)
 
 
 
         
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
 
{<section id="amht401.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amht401_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'mhbgsite') RETURNING l_where
   LET g_wc = g_wc ," AND ", l_where
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
      LET l_sub_sql = " SELECT DISTINCT mhbgdocno ",
                      " FROM mhbg_t ",
                      " ",
                      " LEFT JOIN mhbh_t ON mhbhent = mhbgent AND mhbgdocno = mhbhdocno ", "  ",
                      #add-point:browser_fill段sql(mhbh_t1) name="browser_fill.cnt.join.}"
                      " LEFT JOIN oofb_t ON oofbent = mhbgent AND mhbg037 = oofb002", 
                      " LEFT JOIN oofc_t ON oofcent = mhbgent AND mhbg037 = oofc002", 
                      #end add-point
                      " LEFT JOIN mhbi_t ON mhbient = mhbgent AND mhbgdocno = mhbidocno", "  ",
                      #add-point:browser_fill段sql(mhbi_t1) name="browser_fill.cnt.join.mhbi_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN mhbgl_t ON mhbglent = "||g_enterprise||" AND mhbgdocno = mhbgldocno AND mhbg001 = mhbgl001 AND mhbgl002 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE mhbgent = " ||g_enterprise|| " AND mhbhent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mhbg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mhbgdocno ",
                      " FROM mhbg_t ", 
                      "  ",
                      "  LEFT JOIN mhbgl_t ON mhbglent = "||g_enterprise||" AND mhbgdocno = mhbgldocno AND mhbg001 = mhbgl001 AND mhbgl002 = '",g_dlang,"' ",
                      " WHERE mhbgent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mhbg_t")
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
      INITIALIZE g_mhbg_m.* TO NULL
      CALL g_mhbh_d.clear()        
      CALL g_mhbh2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mhbgsite,t0.mhbgdocdt,t0.mhbgdocno,t0.mhbg001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mhbgstus,t0.mhbgsite,t0.mhbgdocdt,t0.mhbgdocno,t0.mhbg001,t1.ooefl003 , 
          t2.mhbgl003 ",
                  " FROM mhbg_t t0",
                  "  ",
                  "  LEFT JOIN mhbh_t ON mhbhent = mhbgent AND mhbgdocno = mhbhdocno ", "  ", 
                  #add-point:browser_fill段sql(mhbh_t1) name="browser_fill.join.mhbh_t1"
                  
                  #end add-point
                  "  LEFT JOIN mhbi_t ON mhbient = mhbgent AND mhbgdocno = mhbidocno", "  ", 
                  #add-point:browser_fill段sql(mhbi_t1) name="browser_fill.join.mhbi_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhbgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbgl_t t2 ON t2.mhbglent="||g_enterprise||" AND t2.mhbgldocno=t0.mhbgdocno AND t2.mhbgl001=t0.mhbg001 AND t2.mhbgl002='"||g_dlang||"' ",
 
                  " WHERE t0.mhbgent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mhbg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mhbgstus,t0.mhbgsite,t0.mhbgdocdt,t0.mhbgdocno,t0.mhbg001,t1.ooefl003 , 
          t2.mhbgl003 ",
                  " FROM mhbg_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhbgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbgl_t t2 ON t2.mhbglent="||g_enterprise||" AND t2.mhbgldocno=t0.mhbgdocno AND t2.mhbgl001=t0.mhbg001 AND t2.mhbgl002='"||g_dlang||"' ",
 
                  " WHERE t0.mhbgent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mhbg_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mhbgdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mhbg_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mhbgsite,g_browser[g_cnt].b_mhbgdocdt, 
          g_browser[g_cnt].b_mhbgdocno,g_browser[g_cnt].b_mhbg001,g_browser[g_cnt].b_mhbgsite_desc,g_browser[g_cnt].b_mhbg001_desc 
 
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
         CALL amht401_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "F"
            LET g_browser[g_cnt].b_statepic = "stus/16/released.png"
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
   
   IF cl_null(g_browser[g_cnt].b_mhbgdocno) THEN
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
 
{<section id="amht401.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amht401_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mhbg_m.mhbgdocno = g_browser[g_current_idx].b_mhbgdocno   
 
   EXECUTE amht401_master_referesh USING g_mhbg_m.mhbgdocno INTO g_mhbg_m.mhbgsite,g_mhbg_m.mhbgdocdt, 
       g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034,g_mhbg_m.mhbg001,g_mhbg_m.mhbg039,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000, 
       g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg015,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg029, 
       g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg032,g_mhbg_m.mhbg033,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgowndp, 
       g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdt,g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt, 
       g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfdt,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbg003_desc, 
       g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg014_desc, 
       g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033_desc, 
       g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp_desc,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp_desc, 
       g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgcnfid_desc
   
   CALL amht401_mhbg_t_mask()
   CALL amht401_show()
      
END FUNCTION
 
{</section>}
 
{<section id="amht401.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amht401_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="amht401.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amht401_ui_browser_refresh()
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
      IF g_browser[l_i].b_mhbgdocno = g_mhbg_m.mhbgdocno 
 
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
 
{<section id="amht401.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amht401_construct()
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
   INITIALIZE g_mhbg_m.* TO NULL
   CALL g_mhbh_d.clear()        
   CALL g_mhbh2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   INITIALIZE g_pmaa027_d TO NULL
   CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON mhbgsite,mhbgdocdt,mhbgdocno,mhbg034,mhbg001,mhbgl003,mhbg039,mhbgl004, 
          mhbgl005,mhbg018,mhbg000,mhbgstus,mhbg002,mhbg003,mhbg004,mhbg005,mhbg006,mhbg035,mhbg008, 
          mhbg007,mhbg038,mhbg009,mhbg010,mhbg012,mhbg013,mhbg011,mhbg014,mhbg015,mhbg016,mhbg036,mhbg017, 
          mhbg020,mhbg037,mhbg028,mhbg029,mhbg030,mhbg031,mhbg032,mhbg033,ooff013,mhbgownid,mhbgowndp, 
          mhbgcrtid,mhbgcrtdp,mhbgcrtdt,mhbgmodid,mhbgmoddt,mhbgcnfid,mhbgcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mhbgcrtdt>>----
         AFTER FIELD mhbgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mhbgmoddt>>----
         AFTER FIELD mhbgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mhbgcnfdt>>----
         AFTER FIELD mhbgcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mhbgpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgsite
            #add-point:BEFORE FIELD mhbgsite name="construct.b.mhbgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgsite
            
            #add-point:AFTER FIELD mhbgsite name="construct.a.mhbgsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgsite
            #add-point:ON ACTION controlp INFIELD mhbgsite name="construct.c.mhbgsite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhbgsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbgsite  #顯示到畫面上
            NEXT FIELD mhbgsite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgdocdt
            #add-point:BEFORE FIELD mhbgdocdt name="construct.b.mhbgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgdocdt
            
            #add-point:AFTER FIELD mhbgdocdt name="construct.a.mhbgdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgdocdt
            #add-point:ON ACTION controlp INFIELD mhbgdocdt name="construct.c.mhbgdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgdocno
            #add-point:BEFORE FIELD mhbgdocno name="construct.b.mhbgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgdocno
            
            #add-point:AFTER FIELD mhbgdocno name="construct.a.mhbgdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgdocno
            #add-point:ON ACTION controlp INFIELD mhbgdocno name="construct.c.mhbgdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160705-00042#1 160711 by sakura mark(S)
            #IF g_argv[1] = '1' THEN
            #   LET g_qryparam.arg1 = "'amht401'"
            #END IF
            #IF g_argv[1] = '2' THEN
            #   LET g_qryparam.arg1 = "'amht402'"
            #END IF
            #160705-00042#1 160711 by sakura mark(E)
            LET g_qryparam.arg1 = g_prog    #160705-00042#1 160711 by sakura add
            
            CALL q_mhbgdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbgdocno  #顯示到畫面上
            NEXT FIELD mhbgdocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg034
            #add-point:BEFORE FIELD mhbg034 name="construct.b.mhbg034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg034
            
            #add-point:AFTER FIELD mhbg034 name="construct.a.mhbg034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg034
            #add-point:ON ACTION controlp INFIELD mhbg034 name="construct.c.mhbg034"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhbg034()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg034  #顯示到畫面上
            NEXT FIELD mhbg034                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg001
            #add-point:BEFORE FIELD mhbg001 name="construct.b.mhbg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg001
            
            #add-point:AFTER FIELD mhbg001 name="construct.a.mhbg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg001
            #add-point:ON ACTION controlp INFIELD mhbg001 name="construct.c.mhbg001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhbgsite',g_site,'c')
            LET g_qryparam.where = cl_str_replace (g_qryparam.where,"ooef001","mhbgsite")
            LET g_qryparam.arg1 = g_prog
            CALL q_mhbg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg001  #顯示到畫面上
            NEXT FIELD mhbg001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgl003
            #add-point:BEFORE FIELD mhbgl003 name="construct.b.mhbgl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgl003
            
            #add-point:AFTER FIELD mhbgl003 name="construct.a.mhbgl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbgl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgl003
            #add-point:ON ACTION controlp INFIELD mhbgl003 name="construct.c.mhbgl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg039
            #add-point:BEFORE FIELD mhbg039 name="construct.b.mhbg039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg039
            
            #add-point:AFTER FIELD mhbg039 name="construct.a.mhbg039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg039
            #add-point:ON ACTION controlp INFIELD mhbg039 name="construct.c.mhbg039"
          INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '251'
            CALL q_oocq002()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg039  #顯示到畫面上
            NEXT FIELD mhbg039                          #返回原欄位
            #END add-point
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgl004
            #add-point:BEFORE FIELD mhbgl004 name="construct.b.mhbgl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgl004
            
            #add-point:AFTER FIELD mhbgl004 name="construct.a.mhbgl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbgl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgl004
            #add-point:ON ACTION controlp INFIELD mhbgl004 name="construct.c.mhbgl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgl005
            #add-point:BEFORE FIELD mhbgl005 name="construct.b.mhbgl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgl005
            
            #add-point:AFTER FIELD mhbgl005 name="construct.a.mhbgl005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbgl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgl005
            #add-point:ON ACTION controlp INFIELD mhbgl005 name="construct.c.mhbgl005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg018
            #add-point:BEFORE FIELD mhbg018 name="construct.b.mhbg018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg018
            
            #add-point:AFTER FIELD mhbg018 name="construct.a.mhbg018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg018
            #add-point:ON ACTION controlp INFIELD mhbg018 name="construct.c.mhbg018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg000
            #add-point:BEFORE FIELD mhbg000 name="construct.b.mhbg000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg000
            
            #add-point:AFTER FIELD mhbg000 name="construct.a.mhbg000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg000
            #add-point:ON ACTION controlp INFIELD mhbg000 name="construct.c.mhbg000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgstus
            #add-point:BEFORE FIELD mhbgstus name="construct.b.mhbgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgstus
            
            #add-point:AFTER FIELD mhbgstus name="construct.a.mhbgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgstus
            #add-point:ON ACTION controlp INFIELD mhbgstus name="construct.c.mhbgstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg002
            #add-point:BEFORE FIELD mhbg002 name="construct.b.mhbg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg002
            
            #add-point:AFTER FIELD mhbg002 name="construct.a.mhbg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg002
            #add-point:ON ACTION controlp INFIELD mhbg002 name="construct.c.mhbg002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg003
            #add-point:ON ACTION controlp INFIELD mhbg003 name="construct.c.mhbg003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_14()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg003  #顯示到畫面上
            NEXT FIELD mhbg003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg003
            #add-point:BEFORE FIELD mhbg003 name="construct.b.mhbg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg003
            
            #add-point:AFTER FIELD mhbg003 name="construct.a.mhbg003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg004
            #add-point:BEFORE FIELD mhbg004 name="construct.b.mhbg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg004
            
            #add-point:AFTER FIELD mhbg004 name="construct.a.mhbg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg004
            #add-point:ON ACTION controlp INFIELD mhbg004 name="construct.c.mhbg004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '261'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg004  #顯示到畫面上
            NEXT FIELD mhbg004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg005
            #add-point:BEFORE FIELD mhbg005 name="construct.b.mhbg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg005
            
            #add-point:AFTER FIELD mhbg005 name="construct.a.mhbg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg005
            #add-point:ON ACTION controlp INFIELD mhbg005 name="construct.c.mhbg005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg005  #顯示到畫面上
            NEXT FIELD mhbg005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg006
            #add-point:BEFORE FIELD mhbg006 name="construct.b.mhbg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg006
            
            #add-point:AFTER FIELD mhbg006 name="construct.a.mhbg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg006
            #add-point:ON ACTION controlp INFIELD mhbg006 name="construct.c.mhbg006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg035
            #add-point:BEFORE FIELD mhbg035 name="construct.b.mhbg035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg035
            
            #add-point:AFTER FIELD mhbg035 name="construct.a.mhbg035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg035
            #add-point:ON ACTION controlp INFIELD mhbg035 name="construct.c.mhbg035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg008
            #add-point:BEFORE FIELD mhbg008 name="construct.b.mhbg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg008
            
            #add-point:AFTER FIELD mhbg008 name="construct.a.mhbg008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg008
            #add-point:ON ACTION controlp INFIELD mhbg008 name="construct.c.mhbg008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg007
            #add-point:BEFORE FIELD mhbg007 name="construct.b.mhbg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg007
            
            #add-point:AFTER FIELD mhbg007 name="construct.a.mhbg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg007
            #add-point:ON ACTION controlp INFIELD mhbg007 name="construct.c.mhbg007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg038
            #add-point:BEFORE FIELD mhbg038 name="construct.b.mhbg038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg038
            
            #add-point:AFTER FIELD mhbg038 name="construct.a.mhbg038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg038
            #add-point:ON ACTION controlp INFIELD mhbg038 name="construct.c.mhbg038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg009
            #add-point:BEFORE FIELD mhbg009 name="construct.b.mhbg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg009
            
            #add-point:AFTER FIELD mhbg009 name="construct.a.mhbg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg009
            #add-point:ON ACTION controlp INFIELD mhbg009 name="construct.c.mhbg009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg010
            #add-point:BEFORE FIELD mhbg010 name="construct.b.mhbg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg010
            
            #add-point:AFTER FIELD mhbg010 name="construct.a.mhbg010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg010
            #add-point:ON ACTION controlp INFIELD mhbg010 name="construct.c.mhbg010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg010  #顯示到畫面上
            NEXT FIELD mhbg010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg012
            #add-point:BEFORE FIELD mhbg012 name="construct.b.mhbg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg012
            
            #add-point:AFTER FIELD mhbg012 name="construct.a.mhbg012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg012
            #add-point:ON ACTION controlp INFIELD mhbg012 name="construct.c.mhbg012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg013
            #add-point:BEFORE FIELD mhbg013 name="construct.b.mhbg013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg013
            
            #add-point:AFTER FIELD mhbg013 name="construct.a.mhbg013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg013
            #add-point:ON ACTION controlp INFIELD mhbg013 name="construct.c.mhbg013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg013  #顯示到畫面上
            NEXT FIELD mhbg013                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg011
            #add-point:BEFORE FIELD mhbg011 name="construct.b.mhbg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg011
            
            #add-point:AFTER FIELD mhbg011 name="construct.a.mhbg011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg011
            #add-point:ON ACTION controlp INFIELD mhbg011 name="construct.c.mhbg011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg014
            #add-point:BEFORE FIELD mhbg014 name="construct.b.mhbg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg014
            
            #add-point:AFTER FIELD mhbg014 name="construct.a.mhbg014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg014
            #add-point:ON ACTION controlp INFIELD mhbg014 name="construct.c.mhbg014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '254'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg014  #顯示到畫面上
            NEXT FIELD mhbg014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg015
            #add-point:BEFORE FIELD mhbg015 name="construct.b.mhbg015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg015
            
            #add-point:AFTER FIELD mhbg015 name="construct.a.mhbg015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg015
            #add-point:ON ACTION controlp INFIELD mhbg015 name="construct.c.mhbg015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '260'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg015  #顯示到畫面上
            NEXT FIELD mhbg015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg016
            #add-point:BEFORE FIELD mhbg016 name="construct.b.mhbg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg016
            
            #add-point:AFTER FIELD mhbg016 name="construct.a.mhbg016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg016
            #add-point:ON ACTION controlp INFIELD mhbg016 name="construct.c.mhbg016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg036
            #add-point:BEFORE FIELD mhbg036 name="construct.b.mhbg036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg036
            
            #add-point:AFTER FIELD mhbg036 name="construct.a.mhbg036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg036
            #add-point:ON ACTION controlp INFIELD mhbg036 name="construct.c.mhbg036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg017
            #add-point:BEFORE FIELD mhbg017 name="construct.b.mhbg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg017
            
            #add-point:AFTER FIELD mhbg017 name="construct.a.mhbg017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg017
            #add-point:ON ACTION controlp INFIELD mhbg017 name="construct.c.mhbg017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '250'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg017  #顯示到畫面上
            NEXT FIELD mhbg017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg020
            #add-point:BEFORE FIELD mhbg020 name="construct.b.mhbg020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg020
            
            #add-point:AFTER FIELD mhbg020 name="construct.a.mhbg020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg020
            #add-point:ON ACTION controlp INFIELD mhbg020 name="construct.c.mhbg020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg037
            #add-point:BEFORE FIELD mhbg037 name="construct.b.mhbg037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg037
            
            #add-point:AFTER FIELD mhbg037 name="construct.a.mhbg037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg037
            #add-point:ON ACTION controlp INFIELD mhbg037 name="construct.c.mhbg037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg028
            #add-point:BEFORE FIELD mhbg028 name="construct.b.mhbg028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg028
            
            #add-point:AFTER FIELD mhbg028 name="construct.a.mhbg028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg028
            #add-point:ON ACTION controlp INFIELD mhbg028 name="construct.c.mhbg028"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg028  #顯示到畫面上
            NEXT FIELD mhbg028                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg029
            #add-point:BEFORE FIELD mhbg029 name="construct.b.mhbg029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg029
            
            #add-point:AFTER FIELD mhbg029 name="construct.a.mhbg029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg029
            #add-point:ON ACTION controlp INFIELD mhbg029 name="construct.c.mhbg029"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg029  #顯示到畫面上
            NEXT FIELD mhbg029                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg030
            #add-point:BEFORE FIELD mhbg030 name="construct.b.mhbg030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg030
            
            #add-point:AFTER FIELD mhbg030 name="construct.a.mhbg030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg030
            #add-point:ON ACTION controlp INFIELD mhbg030 name="construct.c.mhbg030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg031
            #add-point:BEFORE FIELD mhbg031 name="construct.b.mhbg031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg031
            
            #add-point:AFTER FIELD mhbg031 name="construct.a.mhbg031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg031
            #add-point:ON ACTION controlp INFIELD mhbg031 name="construct.c.mhbg031"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_ooef019 #稅區
            LET g_qryparam.arg2 = "1"       #進銷項類型
            CALL q_isac002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg031  #顯示到畫面上
            NEXT FIELD mhbg031                     #返回原欄位
    



            #END add-point
 
 
         #Ctrlp:construct.c.mhbg032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg032
            #add-point:ON ACTION controlp INFIELD mhbg032 name="construct.c.mhbg032"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3211"
            CALL q_oocq002()   
            DISPLAY g_qryparam.return1 TO mhbg032  #顯示到畫面上
            NEXT FIELD mhbg032                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg032
            #add-point:BEFORE FIELD mhbg032 name="construct.b.mhbg032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg032
            
            #add-point:AFTER FIELD mhbg032 name="construct.a.mhbg032"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg033
            #add-point:BEFORE FIELD mhbg033 name="construct.b.mhbg033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg033
            
            #add-point:AFTER FIELD mhbg033 name="construct.a.mhbg033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbg033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg033
            #add-point:ON ACTION controlp INFIELD mhbg033 name="construct.c.mhbg033"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3111"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbg033  #顯示到畫面上
            NEXT FIELD mhbg033                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="construct.b.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="construct.a.ooff013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooff013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="construct.c.ooff013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgownid
            #add-point:ON ACTION controlp INFIELD mhbgownid name="construct.c.mhbgownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbgownid  #顯示到畫面上
            NEXT FIELD mhbgownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgownid
            #add-point:BEFORE FIELD mhbgownid name="construct.b.mhbgownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgownid
            
            #add-point:AFTER FIELD mhbgownid name="construct.a.mhbgownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgowndp
            #add-point:ON ACTION controlp INFIELD mhbgowndp name="construct.c.mhbgowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbgowndp  #顯示到畫面上
            NEXT FIELD mhbgowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgowndp
            #add-point:BEFORE FIELD mhbgowndp name="construct.b.mhbgowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgowndp
            
            #add-point:AFTER FIELD mhbgowndp name="construct.a.mhbgowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgcrtid
            #add-point:ON ACTION controlp INFIELD mhbgcrtid name="construct.c.mhbgcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbgcrtid  #顯示到畫面上
            NEXT FIELD mhbgcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgcrtid
            #add-point:BEFORE FIELD mhbgcrtid name="construct.b.mhbgcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgcrtid
            
            #add-point:AFTER FIELD mhbgcrtid name="construct.a.mhbgcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgcrtdp
            #add-point:ON ACTION controlp INFIELD mhbgcrtdp name="construct.c.mhbgcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbgcrtdp  #顯示到畫面上
            NEXT FIELD mhbgcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgcrtdp
            #add-point:BEFORE FIELD mhbgcrtdp name="construct.b.mhbgcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgcrtdp
            
            #add-point:AFTER FIELD mhbgcrtdp name="construct.a.mhbgcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgcrtdt
            #add-point:BEFORE FIELD mhbgcrtdt name="construct.b.mhbgcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgmodid
            #add-point:ON ACTION controlp INFIELD mhbgmodid name="construct.c.mhbgmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbgmodid  #顯示到畫面上
            NEXT FIELD mhbgmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgmodid
            #add-point:BEFORE FIELD mhbgmodid name="construct.b.mhbgmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgmodid
            
            #add-point:AFTER FIELD mhbgmodid name="construct.a.mhbgmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgmoddt
            #add-point:BEFORE FIELD mhbgmoddt name="construct.b.mhbgmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbgcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgcnfid
            #add-point:ON ACTION controlp INFIELD mhbgcnfid name="construct.c.mhbgcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbgcnfid  #顯示到畫面上
            NEXT FIELD mhbgcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgcnfid
            #add-point:BEFORE FIELD mhbgcnfid name="construct.b.mhbgcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgcnfid
            
            #add-point:AFTER FIELD mhbgcnfid name="construct.a.mhbgcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgcnfdt
            #add-point:BEFORE FIELD mhbgcnfdt name="construct.b.mhbgcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mhbh001,mhbhacti,mhbh002,mhbh003,mhbh004,mhbh007,mhbh008
           FROM s_detail1[1].mhbh001,s_detail1[1].mhbhacti,s_detail1[1].mhbh002,s_detail1[1].mhbh003, 
               s_detail1[1].mhbh004,s_detail1[1].mhbh007,s_detail1[1].mhbh008
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh001
            #add-point:BEFORE FIELD mhbh001 name="construct.b.page1.mhbh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh001
            
            #add-point:AFTER FIELD mhbh001 name="construct.a.page1.mhbh001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbh001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh001
            #add-point:ON ACTION controlp INFIELD mhbh001 name="construct.c.page1.mhbh001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbhacti
            #add-point:BEFORE FIELD mhbhacti name="construct.b.page1.mhbhacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbhacti
            
            #add-point:AFTER FIELD mhbhacti name="construct.a.page1.mhbhacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbhacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbhacti
            #add-point:ON ACTION controlp INFIELD mhbhacti name="construct.c.page1.mhbhacti"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhbh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh002
            #add-point:ON ACTION controlp INFIELD mhbh002 name="construct.c.page1.mhbh002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2036'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbh002  #顯示到畫面上
            NEXT FIELD mhbh002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh002
            #add-point:BEFORE FIELD mhbh002 name="construct.b.page1.mhbh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh002
            
            #add-point:AFTER FIELD mhbh002 name="construct.a.page1.mhbh002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh003
            #add-point:BEFORE FIELD mhbh003 name="construct.b.page1.mhbh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh003
            
            #add-point:AFTER FIELD mhbh003 name="construct.a.page1.mhbh003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh003
            #add-point:ON ACTION controlp INFIELD mhbh003 name="construct.c.page1.mhbh003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh004
            #add-point:BEFORE FIELD mhbh004 name="construct.b.page1.mhbh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh004
            
            #add-point:AFTER FIELD mhbh004 name="construct.a.page1.mhbh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh004
            #add-point:ON ACTION controlp INFIELD mhbh004 name="construct.c.page1.mhbh004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh007
            #add-point:BEFORE FIELD mhbh007 name="construct.b.page1.mhbh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh007
            
            #add-point:AFTER FIELD mhbh007 name="construct.a.page1.mhbh007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh007
            #add-point:ON ACTION controlp INFIELD mhbh007 name="construct.c.page1.mhbh007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh008
            #add-point:BEFORE FIELD mhbh008 name="construct.b.page1.mhbh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh008
            
            #add-point:AFTER FIELD mhbh008 name="construct.a.page1.mhbh008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh008
            #add-point:ON ACTION controlp INFIELD mhbh008 name="construct.c.page1.mhbh008"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON mhbiacti,mhbi001,mhbi002,mhbi003
           FROM s_detail2[1].mhbiacti,s_detail2[1].mhbi001,s_detail2[1].mhbi002,s_detail2[1].mhbi003
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbiacti
            #add-point:BEFORE FIELD mhbiacti name="construct.b.page2.mhbiacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbiacti
            
            #add-point:AFTER FIELD mhbiacti name="construct.a.page2.mhbiacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mhbiacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbiacti
            #add-point:ON ACTION controlp INFIELD mhbiacti name="construct.c.page2.mhbiacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbi001
            #add-point:BEFORE FIELD mhbi001 name="construct.b.page2.mhbi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbi001
            
            #add-point:AFTER FIELD mhbi001 name="construct.a.page2.mhbi001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mhbi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbi001
            #add-point:ON ACTION controlp INFIELD mhbi001 name="construct.c.page2.mhbi001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mhbi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbi002
            #add-point:ON ACTION controlp INFIELD mhbi002 name="construct.c.page2.mhbi002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbi002  #顯示到畫面上
            NEXT FIELD mhbi002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbi002
            #add-point:BEFORE FIELD mhbi002 name="construct.b.page2.mhbi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbi002
            
            #add-point:AFTER FIELD mhbi002 name="construct.a.page2.mhbi002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mhbi003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbi003
            #add-point:ON ACTION controlp INFIELD mhbi003 name="construct.c.page2.mhbi003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbi003  #顯示到畫面上
            NEXT FIELD mhbi003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbi003
            #add-point:BEFORE FIELD mhbi003 name="construct.b.page2.mhbi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbi003
            
            #add-point:AFTER FIELD mhbi003 name="construct.a.page2.mhbi003"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      SUBDIALOG aoo_aooi350_01.aooi350_01_construct
      SUBDIALOG aoo_aooi350_02.aooi350_02_construct  
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
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "mhbg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mhbh_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mhbi_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
 
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
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   IF cl_null(g_wc) THEN
      CASE g_argv[1]
         WHEN '1' 
            LET g_wc = g_wc, " AND mhbg000 = 'amht401' "
         WHEN '2'
            LET g_wc = g_wc, " AND mhbg000 = 'amht402' "
      END CASE   
   ELSE
      CASE g_argv[1]
         WHEN '1' 
            LET g_wc = g_wc, " AND mhbg000 = 'amht401' "
         WHEN '2'
            LET g_wc = g_wc, " AND mhbg000 = 'amht402' "
      END CASE  
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amht401_filter()
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
      CONSTRUCT g_wc_filter ON mhbgsite,mhbgdocdt,mhbgdocno,mhbg001
                          FROM s_browse[1].b_mhbgsite,s_browse[1].b_mhbgdocdt,s_browse[1].b_mhbgdocno, 
                              s_browse[1].b_mhbg001
 
         BEFORE CONSTRUCT
               DISPLAY amht401_filter_parser('mhbgsite') TO s_browse[1].b_mhbgsite
            DISPLAY amht401_filter_parser('mhbgdocdt') TO s_browse[1].b_mhbgdocdt
            DISPLAY amht401_filter_parser('mhbgdocno') TO s_browse[1].b_mhbgdocno
            DISPLAY amht401_filter_parser('mhbg001') TO s_browse[1].b_mhbg001
      
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
 
      CALL amht401_filter_show('mhbgsite')
   CALL amht401_filter_show('mhbgdocdt')
   CALL amht401_filter_show('mhbgdocno')
   CALL amht401_filter_show('mhbg001')
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amht401_filter_parser(ps_field)
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
 
{<section id="amht401.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amht401_filter_show(ps_field)
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
   LET ls_condition = amht401_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amht401_query()
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
   CALL g_mhbh_d.clear()
   CALL g_mhbh2_d.clear()
 
   
   #add-point:query段other name="query.other"
   INITIALIZE g_pmaa027_d TO NULL
   CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL amht401_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amht401_browser_fill("")
      CALL amht401_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL amht401_filter_show('mhbgsite')
   CALL amht401_filter_show('mhbgdocdt')
   CALL amht401_filter_show('mhbgdocno')
   CALL amht401_filter_show('mhbg001')
   CALL amht401_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL amht401_fetch("F") 
      #顯示單身筆數
      CALL amht401_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amht401_fetch(p_flag)
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
   
   LET g_mhbg_m.mhbgdocno = g_browser[g_current_idx].b_mhbgdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amht401_master_referesh USING g_mhbg_m.mhbgdocno INTO g_mhbg_m.mhbgsite,g_mhbg_m.mhbgdocdt, 
       g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034,g_mhbg_m.mhbg001,g_mhbg_m.mhbg039,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000, 
       g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg015,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg029, 
       g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg032,g_mhbg_m.mhbg033,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgowndp, 
       g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdt,g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt, 
       g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfdt,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbg003_desc, 
       g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg014_desc, 
       g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033_desc, 
       g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp_desc,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp_desc, 
       g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgcnfid_desc
   
   #遮罩相關處理
   LET g_mhbg_m_mask_o.* =  g_mhbg_m.*
   CALL amht401_mhbg_t_mask()
   LET g_mhbg_m_mask_n.* =  g_mhbg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amht401_set_act_visible()   
   CALL amht401_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mhbg_m_t.* = g_mhbg_m.*
   LET g_mhbg_m_o.* = g_mhbg_m.*
   
   LET g_data_owner = g_mhbg_m.mhbgownid      
   LET g_data_dept  = g_mhbg_m.mhbgowndp
   
   #重新顯示   
   CALL amht401_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.insert" >}
#+ 資料新增
PRIVATE FUNCTION amht401_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mhbh_d.clear()   
   CALL g_mhbh2_d.clear()  
 
 
   INITIALIZE g_mhbg_m.* TO NULL             #DEFAULT 設定
   
   LET g_mhbgdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   LET g_pmaa027_d = ''
   CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mhbg_m.mhbgownid = g_user
      LET g_mhbg_m.mhbgowndp = g_dept
      LET g_mhbg_m.mhbgcrtid = g_user
      LET g_mhbg_m.mhbgcrtdp = g_dept 
      LET g_mhbg_m.mhbgcrtdt = cl_get_current()
      LET g_mhbg_m.mhbgmodid = g_user
      LET g_mhbg_m.mhbgmoddt = cl_get_current()
      LET g_mhbg_m.mhbgstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mhbg_m.mhbg002 = "1"
      LET g_mhbg_m.mhbg030 = "10"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL s_aooi500_default(g_prog,'mhbgsite',g_mhbg_m.mhbgsite)
         RETURNING l_insert,g_mhbg_m.mhbgsite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      LET g_site_flag = FALSE
      CALL amht401_mhbgsite_ref()
      LET g_mhbg_m.mhbgdocdt = g_today
      LET g_mhbg_m.mhbg020 = g_today
      # LET g_mhbg_m.mhbg039 = '1'
      LET g_mhbg_m.mhbg000 = g_prog
      #預設單據別
      
      CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
         RETURNING l_success,g_mhbg_m.mhbgdocno
      #for 單據別開窗時可以在 營運中心切換時，開出正確的資料
      LET g_ooef004 = ''
      LET g_ooef019 = ''
      SELECT ooef004,ooef019 INTO g_ooef004,g_ooef019 
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      IF cl_null(g_ooef004) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00007'
         LET g_errparam.extend = g_site
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      #商户自动编号用类型=2.交易对象的自动编号，在insert单头前自动编号
      #供應商生命週期預設
      LET g_mhbg_m.mhbg018 = s_life_cycle_default(g_prog,'2')
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mhbg_m_t.* = g_mhbg_m.*
      LET g_mhbg_m_o.* = g_mhbg_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mhbg_m.mhbgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "F"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/released.png")
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
 
 
 
    
      CALL amht401_input("a")
      
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
         INITIALIZE g_mhbg_m.* TO NULL
         INITIALIZE g_mhbh_d TO NULL
         INITIALIZE g_mhbh2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL amht401_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mhbh_d.clear()
      #CALL g_mhbh2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amht401_set_act_visible()   
   CALL amht401_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mhbgdocno_t = g_mhbg_m.mhbgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mhbgent = " ||g_enterprise|| " AND",
                      " mhbgdocno = '", g_mhbg_m.mhbgdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amht401_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE amht401_cl
   
   CALL amht401_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amht401_master_referesh USING g_mhbg_m.mhbgdocno INTO g_mhbg_m.mhbgsite,g_mhbg_m.mhbgdocdt, 
       g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034,g_mhbg_m.mhbg001,g_mhbg_m.mhbg039,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000, 
       g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg015,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg029, 
       g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg032,g_mhbg_m.mhbg033,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgowndp, 
       g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdt,g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt, 
       g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfdt,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbg003_desc, 
       g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg014_desc, 
       g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033_desc, 
       g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp_desc,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp_desc, 
       g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgcnfid_desc
   
   
   #遮罩相關處理
   LET g_mhbg_m_mask_o.* =  g_mhbg_m.*
   CALL amht401_mhbg_t_mask()
   LET g_mhbg_m_mask_n.* =  g_mhbg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mhbg_m.mhbgsite,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbgdocdt,g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034, 
       g_mhbg_m.mhbg001,g_mhbg_m.mhbgl003,g_mhbg_m.mhbg039,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbgl004,g_mhbg_m.mhbgl005, 
       g_mhbg_m.mhbg018,g_mhbg_m.mhbg000,g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg003_desc, 
       g_mhbg_m.mhbg004,g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg011, 
       g_mhbg_m.mhbg014,g_mhbg_m.mhbg014_desc,g_mhbg_m.mhbg015,g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028, 
       g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg029,g_mhbg_m.mhbg029_desc,g_mhbg_m.mhbg030,g_mhbg_m.mhbg031, 
       g_mhbg_m.mhbg031_desc,g_mhbg_m.mhbg032,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033,g_mhbg_m.mhbg033_desc, 
       g_mhbg_m.ooff013,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp,g_mhbg_m.mhbgowndp_desc, 
       g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdp_desc,g_mhbg_m.mhbgcrtdt, 
       g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgmoddt,g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfid_desc, 
       g_mhbg_m.mhbgcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mhbg_m.mhbgownid      
   LET g_data_dept  = g_mhbg_m.mhbgowndp
   
   #功能已完成,通報訊息中心
   CALL amht401_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amht401.modify" >}
#+ 資料修改
PRIVATE FUNCTION amht401_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mhbg_m_t.* = g_mhbg_m.*
   LET g_mhbg_m_o.* = g_mhbg_m.*
   
   IF g_mhbg_m.mhbgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mhbgdocno_t = g_mhbg_m.mhbgdocno
 
   CALL s_transaction_begin()
   
   OPEN amht401_cl USING g_enterprise,g_mhbg_m.mhbgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht401_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amht401_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amht401_master_referesh USING g_mhbg_m.mhbgdocno INTO g_mhbg_m.mhbgsite,g_mhbg_m.mhbgdocdt, 
       g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034,g_mhbg_m.mhbg001,g_mhbg_m.mhbg039,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000, 
       g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg015,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg029, 
       g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg032,g_mhbg_m.mhbg033,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgowndp, 
       g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdt,g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt, 
       g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfdt,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbg003_desc, 
       g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg014_desc, 
       g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033_desc, 
       g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp_desc,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp_desc, 
       g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgcnfid_desc
   
   #檢查是否允許此動作
   IF NOT amht401_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mhbg_m_mask_o.* =  g_mhbg_m.*
   CALL amht401_mhbg_t_mask()
   LET g_mhbg_m_mask_n.* =  g_mhbg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL amht401_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_mhbgdocno_t = g_mhbg_m.mhbgdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mhbg_m.mhbgmodid = g_user 
LET g_mhbg_m.mhbgmoddt = cl_get_current()
LET g_mhbg_m.mhbgmodid_desc = cl_get_username(g_mhbg_m.mhbgmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL amht401_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mhbg_t SET (mhbgmodid,mhbgmoddt) = (g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt)
          WHERE mhbgent = g_enterprise AND mhbgdocno = g_mhbgdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mhbg_m.* = g_mhbg_m_t.*
            CALL amht401_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mhbg_m.mhbgdocno != g_mhbg_m_t.mhbgdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mhbh_t SET mhbhdocno = g_mhbg_m.mhbgdocno
 
          WHERE mhbhent = g_enterprise AND mhbhdocno = g_mhbg_m_t.mhbgdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mhbh_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhbh_t:",SQLERRMESSAGE 
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
         
         UPDATE mhbi_t
            SET mhbidocno = g_mhbg_m.mhbgdocno
 
          WHERE mhbient = g_enterprise AND
                mhbidocno = g_mhbgdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mhbi_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhbi_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amht401_set_act_visible()   
   CALL amht401_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mhbgent = " ||g_enterprise|| " AND",
                      " mhbgdocno = '", g_mhbg_m.mhbgdocno, "' "
 
   #填到對應位置
   CALL amht401_browser_fill("")
 
   CLOSE amht401_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amht401_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="amht401.input" >}
#+ 資料輸入
PRIVATE FUNCTION amht401_input(p_cmd)
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
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_errno                LIKE type_t.chr10
   define l_str                  string 
   DEFINE l_oofg_return          DYNAMIC ARRAY OF RECORD
          oofg019                LIKE oofg_t.oofg019,  #field
          oofg020                LIKE oofg_t.oofg020   #value
                                 END RECORD
   DEFINE l_mhbgdocno            LIKE mhbg_t.mhbgdocno
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
   DISPLAY BY NAME g_mhbg_m.mhbgsite,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbgdocdt,g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034, 
       g_mhbg_m.mhbg001,g_mhbg_m.mhbgl003,g_mhbg_m.mhbg039,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbgl004,g_mhbg_m.mhbgl005, 
       g_mhbg_m.mhbg018,g_mhbg_m.mhbg000,g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg003_desc, 
       g_mhbg_m.mhbg004,g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg011, 
       g_mhbg_m.mhbg014,g_mhbg_m.mhbg014_desc,g_mhbg_m.mhbg015,g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028, 
       g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg029,g_mhbg_m.mhbg029_desc,g_mhbg_m.mhbg030,g_mhbg_m.mhbg031, 
       g_mhbg_m.mhbg031_desc,g_mhbg_m.mhbg032,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033,g_mhbg_m.mhbg033_desc, 
       g_mhbg_m.ooff013,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp,g_mhbg_m.mhbgowndp_desc, 
       g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdp_desc,g_mhbg_m.mhbgcrtdt, 
       g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgmoddt,g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfid_desc, 
       g_mhbg_m.mhbgcnfdt
   
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
   LET g_forupd_sql = "SELECT mhbh001,mhbhacti,mhbh002,mhbh003,mhbh004,mhbh007,mhbh008 FROM mhbh_t WHERE  
       mhbhent=? AND mhbhdocno=? AND mhbh002=? AND mhbh003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amht401_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mhbiacti,mhbi001,mhbi002,mhbi003 FROM mhbi_t WHERE mhbient=? AND mhbidocno=?  
       AND mhbi002=? AND mhbi003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amht401_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amht401_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amht401_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mhbg_m.mhbgsite,g_mhbg_m.mhbgdocdt,g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034,g_mhbg_m.mhbg001, 
       g_mhbg_m.mhbgl003,g_mhbg_m.mhbg039,g_mhbg_m.mhbgl004,g_mhbg_m.mhbgl005,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000, 
       g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg015,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg029, 
       g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg032,g_mhbg_m.mhbg033,g_mhbg_m.ooff013
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amht401.input.head" >}
      #單頭段
      INPUT BY NAME g_mhbg_m.mhbgsite,g_mhbg_m.mhbgdocdt,g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034,g_mhbg_m.mhbg001, 
          g_mhbg_m.mhbgl003,g_mhbg_m.mhbg039,g_mhbg_m.mhbgl004,g_mhbg_m.mhbgl005,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000, 
          g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006, 
          g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
          g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg015,g_mhbg_m.mhbg016, 
          g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg029, 
          g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg032,g_mhbg_m.mhbg033,g_mhbg_m.ooff013 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF (NOT cl_null(g_mhbg_m.mhbgdocno)) AND (NOT cl_null(g_mhbg_m.mhbg001)) THEN
                  CALL n_mhbgl(g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg001)
                  INITIALIZE g_ref_fields TO NULL
                  #INITIALIZE g_rtn_fields TO NULL
                  LET g_ref_fields[1] = g_mhbg_m.mhbgdocno
                  LET g_ref_fields[2] = g_mhbg_m.mhbg001
                  CALL ap_ref_array2(g_ref_fields," SELECT mhbgl003,mhbgl004,mhbgl005 FROM mhbgl_t WHERE mhbglent = '"||g_enterprise||"' AND mhbgldocno = ? AND mhbgl001 = ? AND mhbgl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
                  LET g_mhbg_m.mhbgl003 = g_rtn_fields[1] 
                  LET g_mhbg_m.mhbgl004 = g_rtn_fields[2] 
                  LET g_mhbg_m.mhbgl005 = g_rtn_fields[3] 
                  DISPLAY g_mhbg_m.mhbgl003,g_mhbg_m.mhbgl004,g_mhbg_m.mhbgl005
               END IF  
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN amht401_cl USING g_enterprise,g_mhbg_m.mhbgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amht401_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amht401_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.mhbgldocno = g_mhbg_m.mhbgdocno
LET g_master_multi_table_t.mhbgl001 = g_mhbg_m.mhbg001
LET g_master_multi_table_t.mhbgl003 = g_mhbg_m.mhbgl003
LET g_master_multi_table_t.mhbgl004 = g_mhbg_m.mhbgl004
LET g_master_multi_table_t.mhbgl005 = g_mhbg_m.mhbgl005
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.mhbgldocno = ''
LET g_master_multi_table_t.mhbgl001 = ''
LET g_master_multi_table_t.mhbgl003 = ''
LET g_master_multi_table_t.mhbgl004 = ''
LET g_master_multi_table_t.mhbgl005 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL amht401_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL amht401_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgsite
            
            #add-point:AFTER FIELD mhbgsite name="input.a.mhbgsite"
            LET g_mhbg_m.mhbgsite_desc = NULL
            DISPLAY BY NAME g_mhbg_m.mhbgsite_desc
            IF NOT cl_null(g_mhbg_m.mhbgsite) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mhbg_m.mhbgsite != g_mhbg_m_t.mhbgsite OR g_mhbg_m_t.mhbgsite IS null)) THEN
                  CALL s_aooi500_chk(g_prog,'mhbgsite',g_mhbg_m.mhbgsite,g_site)
                   RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_mhbg_m.mhbgsite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_mhbg_m.mhbgsite = g_mhbg_m_t.mhbgsite
                     CALL amht401_mhbgsite_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL amht401_mhbgsite_ref()
            LET g_site_flag = TRUE
            CALL amht401_set_entry(p_cmd)
            CALL amht401_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgsite
            #add-point:BEFORE FIELD mhbgsite name="input.b.mhbgsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbgsite
            #add-point:ON CHANGE mhbgsite name="input.g.mhbgsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgdocdt
            #add-point:BEFORE FIELD mhbgdocdt name="input.b.mhbgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgdocdt
            
            #add-point:AFTER FIELD mhbgdocdt name="input.a.mhbgdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbgdocdt
            #add-point:ON CHANGE mhbgdocdt name="input.g.mhbgdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgdocno
            #add-point:BEFORE FIELD mhbgdocno name="input.b.mhbgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgdocno
            
            #add-point:AFTER FIELD mhbgdocno name="input.a.mhbgdocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_mhbg_m.mhbgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mhbg_m.mhbgdocno != g_mhbgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhbg_t WHERE "||"mhbgent = '" ||g_enterprise|| "' AND "||"mhbgdocno = '"||g_mhbg_m.mhbgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT s_aooi200_chk_slip(g_site,'',g_mhbg_m.mhbgdocno,g_prog) THEN
               LET g_mhbg_m.mhbgdocno = g_mhbg_m_o.mhbgdocno
               NEXT FIELD CURRENT 
            END IF
            LET g_mhbg_m_o.mhbgdocno = g_mhbg_m.mhbgdocno
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbgdocno
            #add-point:ON CHANGE mhbgdocno name="input.g.mhbgdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg034
            #add-point:BEFORE FIELD mhbg034 name="input.b.mhbg034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg034
            
            #add-point:AFTER FIELD mhbg034 name="input.a.mhbg034"
            IF NOT cl_null(g_mhbg_m.mhbg034) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhbg_m.mhbg034

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mhbg034") THEN
                  #檢查失敗時後續處理
                  LET g_mhbg_m.mhbg034 = g_mhbg_m_o.mhbg034
                  NEXT FIELD CURRENT
               END IF
               CALL amht401_carry()   #160601-00025#1 20160602 add by beckxie
            END IF 
            #CALL amht401_carry()   #160601-00025#1 20160602 mark by beckxie
            #160601-00025#1 20160602 mark by beckxie---S
            #IF g_mhbg_m.mhbg034 != g_mhbg_m_o.mhbg034 OR cl_null(g_mhbg_m_o.mhbg034) THEN
            #   #刪除聯絡地址,通訊資料
            #   CALL s_transaction_begin()
            #   IF NOT cl_null(g_mhbg_m.mhbg037) THEN
            #      IF NOT s_aooi350_del(g_mhbg_m.mhbg037) THEN
            #         INITIALIZE g_errparam TO NULL
            #         LET g_errparam.code = SQLCA.sqlcode
            #         LET g_errparam.extend = "del oofa_t"
            #         LET g_errparam.popup = FALSE
            #         CALL cl_err()
            #   
            #         CALL s_transaction_end('N','0')
            #      ELSE 
            #         CALL s_transaction_end('Y','0')
            #      END IF
            #   END IF
            #   DELETE FROM mhbh_t 
            #   WHERE mhbhent = g_enterprise AND mhbhdocno = g_mhbg_m.mhbgdocno
            #   IF SQLCA.sqlcode THEN
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = SQLCA.sqlcode
            #      LET g_errparam.extend = 'del mhbh_t'
            #      LET g_errparam.popup = FALSE
            #      CALL cl_err()
            #   END IF   
            #   DELETE FROM mhbi_t 
            #   WHERE mhbient = g_enterprise AND mhbidocno = g_mhbg_m.mhbgdocno
            #   IF SQLCA.sqlcode THEN
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = SQLCA.sqlcode
            #      LET g_errparam.extend = 'del mhbi_t'
            #      LET g_errparam.popup = FALSE
            #      CALL cl_err()
            #   END IF 
            #END IF
            #CALL amht401_clear_detail()
            #LET g_mhbg_m_o.mhbg034 = g_mhbg_m.mhbg034
            #160601-00025#1 20160602 mark by beckxie---E
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg034
            #add-point:ON CHANGE mhbg034 name="input.g.mhbg034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg001
            #add-point:BEFORE FIELD mhbg001 name="input.b.mhbg001"
           # IF g_argv[1] ='1' THEN
               IF cl_null(g_mhbg_m.mhbg001) AND p_cmd = 'a' THEN    
                  CALL s_aooi390_gen('2') RETURNING l_success,g_mhbg_m.mhbg001,l_oofg_return
                  DISPLAY BY NAME g_mhbg_m.mhbg001
                  IF g_mhbg_m.mhbg002 = '1' THEN
                     LET g_mhbg_m.mhbg003 = g_mhbg_m.mhbg001
                  END IF
               END IF
           # END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg001
            
            #add-point:AFTER FIELD mhbg001 name="input.a.mhbg001"
            IF g_mhbg_m.mhbg001 != g_mhbg_m_o.mhbg001 OR cl_null(g_mhbg_m_o.mhbg001) THEN
               IF NOT s_aooi390_chk('2',g_mhbg_m.mhbg001) THEN
                     LET g_mhbg_m.mhbg001 = g_mhbg_m_t.mhbg001
                     DISPLAY BY NAME g_mhbg_m.mhbg001
                     NEXT FIELD CURRENT
               END IF
               #160604-00030#1 20160607 add by beckxie---S
               LET l_cnt = 0
               SELECT COUNT (*) INTO l_cnt
                 FROM pmaa_t 
                WHERE pmaaent = g_enterprise 
                  AND pmaa001 = g_mhbg_m.mhbg001 
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'amh-00637'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_mhbg_m.mhbg001 = g_mhbg_m_o.mhbg001
                  NEXT FIELD CURRENT
               END IF
               #160604-00030#1 20160607 add by beckxie---E
               #160604-00009#30 20160613 add by geza---S
               LET l_cnt = 0
               #amht401
               IF g_argv[1] = 1 THEN
                  SELECT COUNT (*) INTO l_cnt
                    FROM mhbg_t 
                   WHERE mhbgent = g_enterprise 
                     AND mhbg000 = 'amht401'
                     AND mhbg001 = g_mhbg_m.mhbg001                  
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'amh-00668'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_mhbg_m.mhbg001 = g_mhbg_m_o.mhbg001
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               #amht402
               IF g_argv[1] = 2 THEN
                  SELECT COUNT (*) INTO l_cnt
                    FROM mhbg_t 
                   WHERE mhbgent = g_enterprise 
                     AND mhbg000 = 'amht402'
                     AND mhbg001 = g_mhbg_m.mhbg001                  
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'amh-00667'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_mhbg_m.mhbg001 = g_mhbg_m_o.mhbg001
                     NEXT FIELD CURRENT
                  END IF
               END IF                 
               #160604-00009#30 20160613 add by geza---E
               
               IF g_argv[1] = '1' THEN
                  SELECT COUNT (*) INTO l_cnt
                    FROM mhbg_t 
                   WHERE mhbgent = g_enterprise AND mhbg000 = g_prog AND mhbg001 = g_mhbg_m.mhbg001 
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'amh-00636'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_mhbg_m.mhbg001 = g_mhbg_m_o.mhbg001
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #160512-00003#7
               IF g_argv[1] = '2' THEN
                  IF NOT cl_null(g_mhbg_m.mhbg001) THEN
                     SELECT COUNT (*) INTO l_cnt
                       FROM mhbg_t 
                      WHERE mhbgent = g_enterprise AND mhbg000 = 'amht401' AND mhbg001 = g_mhbg_m.mhbg001 
                   
                   #160521-00001#1 160521 by lori mark---(S)
                     IF l_cnt = 0 THEN
                       #160601-00025#1 20160601 mark by beckxie---S
                       #INITIALIZE g_errparam TO NULL
                       #LET g_errparam.extend = ''
                       #LET g_errparam.code   = 'amh-00661'
                       #LET g_errparam.popup  = TRUE
                       #CALL cl_err()
                       #LET g_mhbg_m.mhbg001 = g_mhbg_m_o.mhbg001
                       #NEXT FIELD CURRENT
                       #160601-00025#1 20160601 mark by beckxie---E
                  #160521-00001#1 160521 by lori mark---(E)
                  
                     
                     ELSE   #160521-00001#1 160521 by lori add
                        SELECT mhbgdocno INTO l_mhbgdocno FROM mhbg_t
                         WHERE mhbgent = g_enterprise
                           AND mhbg000 = 'amht401'
                           AND mhbg001 = g_mhbg_m.mhbg001
                        
                        LET g_mhbg_m.mhbg034 = l_mhbgdocno
                        DISPLAY BY NAME  g_mhbg_m.mhbg034
                        
                        CALL amht401_carry()
                     END IF              #160521-00001#1 160521 by lori add
                     
                     IF g_mhbg_m.mhbg034 != g_mhbg_m_o.mhbg034 OR cl_null(g_mhbg_m_o.mhbg034) THEN
                        #刪除聯絡地址,通訊資料
                        CALL s_transaction_begin()
                        IF NOT cl_null(g_mhbg_m.mhbg037) THEN
                           IF NOT s_aooi350_del(g_mhbg_m.mhbg037) THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = SQLCA.sqlcode
                              LET g_errparam.extend = "del oofa_t"
                              LET g_errparam.popup = FALSE
                              CALL cl_err()
                        
                              CALL s_transaction_end('N','0')
                           ELSE 
                              CALL s_transaction_end('Y','0')
                           END IF
                        END IF
                        
                        DELETE FROM mhbh_t 
                        WHERE mhbhent = g_enterprise AND mhbhdocno = g_mhbg_m.mhbgdocno
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = 'del mhbh_t'
                           LET g_errparam.popup = FALSE
                           CALL cl_err()
                        END IF   
                        
                        DELETE FROM mhbi_t 
                        WHERE mhbient = g_enterprise AND mhbidocno = g_mhbg_m.mhbgdocno
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = 'del mhbi_t'
                           LET g_errparam.popup = FALSE
                           CALL cl_err()
                        END IF 
                     END IF
                     CALL amht401_clear_detail()
                     LET g_mhbg_m_o.mhbg034 = g_mhbg_m.mhbg034
                     
                  END IF
               END IF
            END IF
            
            LET g_mhbg_m_o.mhbg001 = g_mhbg_m.mhbg001
            CALL amht401_set_entry(p_cmd)
            CALL amht401_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg001
            #add-point:ON CHANGE mhbg001 name="input.g.mhbg001"
            IF g_mhbg_m.mhbg002 = '1' THEN
               LET g_mhbg_m.mhbg003 = g_mhbg_m.mhbg001
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgl003
            #add-point:BEFORE FIELD mhbgl003 name="input.b.mhbgl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgl003
            
            #add-point:AFTER FIELD mhbgl003 name="input.a.mhbgl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbgl003
            #add-point:ON CHANGE mhbgl003 name="input.g.mhbgl003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg039
            
            #add-point:AFTER FIELD mhbg039 name="input.a.mhbg039"
            LET g_mhbg_m.mhbg039_desc = ' '
            DISPLAY BY NAME g_mhbg_m.mhbg039_desc
            IF NOT cl_null(g_mhbg_m.mhbg039) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mhbg_m.mhbg039 != g_mhbg_m_t.mhbg039 OR g_mhbg_m_t.mhbg039 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('251',g_mhbg_m.mhbg039) THEN
                     LET g_mhbg_m.mhbg039 = g_mhbg_m_t.mhbg039
                     CALL amht401_mhbg039_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL amht401_mhbg039_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg039
            #add-point:BEFORE FIELD mhbg039 name="input.b.mhbg039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg039
            #add-point:ON CHANGE mhbg039 name="input.g.mhbg039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgl004
            #add-point:BEFORE FIELD mhbgl004 name="input.b.mhbgl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgl004
            
            #add-point:AFTER FIELD mhbgl004 name="input.a.mhbgl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbgl004
            #add-point:ON CHANGE mhbgl004 name="input.g.mhbgl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgl005
            #add-point:BEFORE FIELD mhbgl005 name="input.b.mhbgl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgl005
            
            #add-point:AFTER FIELD mhbgl005 name="input.a.mhbgl005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbgl005
            #add-point:ON CHANGE mhbgl005 name="input.g.mhbgl005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg018
            #add-point:BEFORE FIELD mhbg018 name="input.b.mhbg018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg018
            
            #add-point:AFTER FIELD mhbg018 name="input.a.mhbg018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg018
            #add-point:ON CHANGE mhbg018 name="input.g.mhbg018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg000
            #add-point:BEFORE FIELD mhbg000 name="input.b.mhbg000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg000
            
            #add-point:AFTER FIELD mhbg000 name="input.a.mhbg000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg000
            #add-point:ON CHANGE mhbg000 name="input.g.mhbg000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbgstus
            #add-point:BEFORE FIELD mhbgstus name="input.b.mhbgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbgstus
            
            #add-point:AFTER FIELD mhbgstus name="input.a.mhbgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbgstus
            #add-point:ON CHANGE mhbgstus name="input.g.mhbgstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg002
            #add-point:BEFORE FIELD mhbg002 name="input.b.mhbg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg002
            
            #add-point:AFTER FIELD mhbg002 name="input.a.mhbg002"
            IF g_mhbg_m.mhbg002 = '1' THEN
               LET g_mhbg_m.mhbg003 = g_mhbg_m.mhbg001
               CALL amht401_mhbg003_ref()
            ELSE
               IF g_mhbg_m.mhbg002 = '3' THEN
                  IF g_mhbg_m.mhbg003 = g_mhbg_m.mhbg001 THEN
                     LET g_mhbg_m.mhbg003 = '' 
                     LET g_mhbg_m.mhbg003_desc = ' '                     
                     DISPLAY BY NAME g_mhbg_m.mhbg003_desc
                  END IF
               ELSE
                  LET g_mhbg_m.mhbg003 = ''
                  LET g_mhbg_m.mhbg003_desc = ' '
                  DISPLAY BY NAME g_mhbg_m.mhbg003_desc                  
               END IF               
            END IF
            CALL amht401_set_entry(p_cmd)
            CALL amht401_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg002
            #add-point:ON CHANGE mhbg002 name="input.g.mhbg002"
            IF g_mhbg_m.mhbg002 = '1' THEN
               LET g_mhbg_m.mhbg003 = g_mhbg_m.mhbg001
               CALL amht401_mhbg003_ref()
            ELSE
               IF g_mhbg_m.mhbg002 = '3' THEN
                  IF g_mhbg_m.mhbg003 = g_mhbg_m.mhbg001 THEN
                     LET g_mhbg_m.mhbg003 = '' 
                     LET g_mhbg_m.mhbg003_desc = ' '                     
                     DISPLAY BY NAME g_mhbg_m.mhbg003_desc
                  END IF
               ELSE
                  LET g_mhbg_m.mhbg003 = ''
                  LET g_mhbg_m.mhbg003_desc = ' '
                  DISPLAY BY NAME g_mhbg_m.mhbg003_desc                  
               END IF               
            END IF
            CALL amht401_set_entry(p_cmd)
            CALL amht401_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg003
            
            #add-point:AFTER FIELD mhbg003 name="input.a.mhbg003"
            LET g_mhbg_m.mhbg003_desc = ' '
            DISPLAY BY NAME g_mhbg_m.mhbg003_desc
            IF NOT cl_null(g_mhbg_m.mhbg003) THEN
               IF g_mhbg_m.mhbg003 != g_mhbg_m_o.mhbg003 OR cl_null(g_mhbg_m_o.mhbg003) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = 1 
                  LET g_chkparam.arg1 = g_mhbg_m.mhbg003
                  IF NOT cl_chk_exist("v_pmaa001_11") THEN
                     LET g_mhbg_m.mhbg003 = g_mhbg_m_o.mhbg003
                     CALL amht401_mhbg003_ref()
                     NEXT FIELD CURRENT                  
                  END IF
               END IF
            END IF
            LET g_mhbg_m_o.mhbg003 = g_mhbg_m.mhbg003
            CALL amht401_mhbg003_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg003
            #add-point:BEFORE FIELD mhbg003 name="input.b.mhbg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg003
            #add-point:ON CHANGE mhbg003 name="input.g.mhbg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg004
            
            #add-point:AFTER FIELD mhbg004 name="input.a.mhbg004"
            LET g_mhbg_m.mhbg004_desc = ' '
            DISPLAY BY NAME g_mhbg_m.mhbg004_desc
            IF NOT cl_null(g_mhbg_m.mhbg004) THEN
               IF g_mhbg_m.mhbg004 != g_mhbg_m_o.mhbg004 OR cl_null(g_mhbg_m_o.mhbg004) THEN
                  IF NOT s_azzi650_chk_exist('261',g_mhbg_m.mhbg004) THEN
                     LET g_mhbg_m.mhbg004 = g_mhbg_m_o.mhbg004
                     CALL amht401_mhbg004_ref()
                     NEXT FIELD CURRENT                  
                  END IF
               END IF
            END IF
            LET g_mhbg_m_o.mhbg004 = g_mhbg_m.mhbg004
            CALL amht401_mhbg004_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg004
            #add-point:BEFORE FIELD mhbg004 name="input.b.mhbg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg004
            #add-point:ON CHANGE mhbg004 name="input.g.mhbg004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg005
            
            #add-point:AFTER FIELD mhbg005 name="input.a.mhbg005"
            IF NOT cl_null(g_mhbg_m.mhbg005) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               IF g_mhbg_m.mhbg005 != g_mhbg_m_o.mhbg005 OR cl_null(g_mhbg_m_o.mhbg005) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mhbg_m.mhbg005
                  
                  LET g_errshow = 1
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_oocg001") THEN
                     #檢查失敗時後續處理
                     LET g_mhbg_m.mhbg005 = g_mhbg_m_o.mhbg005 
                     CALL amht401_mhbg005_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_mhbg_m_o.mhbg005 = g_mhbg_m.mhbg005 
            CALL amht401_mhbg005_ref()    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg005
            #add-point:BEFORE FIELD mhbg005 name="input.b.mhbg005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg005
            #add-point:ON CHANGE mhbg005 name="input.g.mhbg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg006
            #add-point:BEFORE FIELD mhbg006 name="input.b.mhbg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg006
            
            #add-point:AFTER FIELD mhbg006 name="input.a.mhbg006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg006
            #add-point:ON CHANGE mhbg006 name="input.g.mhbg006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg035
            #add-point:BEFORE FIELD mhbg035 name="input.b.mhbg035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg035
            
            #add-point:AFTER FIELD mhbg035 name="input.a.mhbg035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg035
            #add-point:ON CHANGE mhbg035 name="input.g.mhbg035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg008
            #add-point:BEFORE FIELD mhbg008 name="input.b.mhbg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg008
            
            #add-point:AFTER FIELD mhbg008 name="input.a.mhbg008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg008
            #add-point:ON CHANGE mhbg008 name="input.g.mhbg008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg007
            #add-point:BEFORE FIELD mhbg007 name="input.b.mhbg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg007
            
            #add-point:AFTER FIELD mhbg007 name="input.a.mhbg007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg007
            #add-point:ON CHANGE mhbg007 name="input.g.mhbg007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg038
            #add-point:BEFORE FIELD mhbg038 name="input.b.mhbg038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg038
            
            #add-point:AFTER FIELD mhbg038 name="input.a.mhbg038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg038
            #add-point:ON CHANGE mhbg038 name="input.g.mhbg038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg009
            #add-point:BEFORE FIELD mhbg009 name="input.b.mhbg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg009
            
            #add-point:AFTER FIELD mhbg009 name="input.a.mhbg009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg009
            #add-point:ON CHANGE mhbg009 name="input.g.mhbg009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg010
            
            #add-point:AFTER FIELD mhbg010 name="input.a.mhbg010"
            LET g_mhbg_m.mhbg010_desc = ' '
            DISPLAY BY NAME g_mhbg_m.mhbg010_desc
            IF NOT cl_null(g_mhbg_m.mhbg010) THEN
               IF g_mhbg_m.mhbg010 != g_mhbg_m_o.mhbg010 OR cl_null(g_mhbg_m_o.mhbg010) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_mhbg_m.mhbg010
                  #160318-00025#36      2016/04/20 By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)---S
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#36      2016/04/20 By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)---E
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_mhbg_m.mhbg010 = g_mhbg_m_o.mhbg010
                     CALL amht401_mhbg010_ref()
                     NEXT FIELD CURRENT                  
                  END IF
               END IF
            END IF
            LET g_mhbg_m_o.mhbg010 = g_mhbg_m.mhbg010
            CALL amht401_mhbg010_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg010
            #add-point:BEFORE FIELD mhbg010 name="input.b.mhbg010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg010
            #add-point:ON CHANGE mhbg010 name="input.g.mhbg010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg012
            #add-point:BEFORE FIELD mhbg012 name="input.b.mhbg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg012
            
            #add-point:AFTER FIELD mhbg012 name="input.a.mhbg012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg012
            #add-point:ON CHANGE mhbg012 name="input.g.mhbg012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg013
            
            #add-point:AFTER FIELD mhbg013 name="input.a.mhbg013"
            LET g_mhbg_m.mhbg013_desc = ' '
            DISPLAY BY NAME g_mhbg_m.mhbg013_desc
            IF NOT cl_null(g_mhbg_m.mhbg013) THEN
               IF g_mhbg_m.mhbg013 != g_mhbg_m_o.mhbg013 OR cl_null(g_mhbg_m_o.mhbg013) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_mhbg_m.mhbg013
                  #160318-00025#36      2016/04/20 By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)---S
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#36      2016/04/20 By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)---E
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_mhbg_m.mhbg013 = g_mhbg_m_o.mhbg013
                     CALL amht401_mhbg013_ref()
                     NEXT FIELD CURRENT                  
                  END IF
               END IF
            END IF
            LET g_mhbg_m_o.mhbg013 = g_mhbg_m.mhbg013
            CALL amht401_mhbg013_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg013
            #add-point:BEFORE FIELD mhbg013 name="input.b.mhbg013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg013
            #add-point:ON CHANGE mhbg013 name="input.g.mhbg013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg011
            #add-point:BEFORE FIELD mhbg011 name="input.b.mhbg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg011
            
            #add-point:AFTER FIELD mhbg011 name="input.a.mhbg011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg011
            #add-point:ON CHANGE mhbg011 name="input.g.mhbg011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg014
            
            #add-point:AFTER FIELD mhbg014 name="input.a.mhbg014"
            LET g_mhbg_m.mhbg014_desc = ' '
            DISPLAY BY NAME g_mhbg_m.mhbg014_desc
            IF NOT cl_null(g_mhbg_m.mhbg014) THEN
               IF g_mhbg_m.mhbg014 != g_mhbg_m_o.mhbg014 OR cl_null(g_mhbg_m_o.mhbg014) THEN
                  IF NOT s_azzi650_chk_exist('254',g_mhbg_m.mhbg014) THEN
                     LET g_mhbg_m.mhbg014 = g_mhbg_m_o.mhbg014
                     CALL amht401_mhbg014_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mhbg_m_o.mhbg014 = g_mhbg_m.mhbg014
            CALL amht401_mhbg014_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg014
            #add-point:BEFORE FIELD mhbg014 name="input.b.mhbg014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg014
            #add-point:ON CHANGE mhbg014 name="input.g.mhbg014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg015
            
            #add-point:AFTER FIELD mhbg015 name="input.a.mhbg015"
            LET g_mhbg_m.mhbg015_desc = ' '
            DISPLAY BY NAME g_mhbg_m.mhbg015_desc
            IF NOT cl_null(g_mhbg_m.mhbg015) THEN
               IF g_mhbg_m.mhbg015 != g_mhbg_m_o.mhbg015 OR cl_null(g_mhbg_m_o.mhbg015) THEN
                  IF NOT s_azzi650_chk_exist('260',g_mhbg_m.mhbg015) THEN
                     LET g_mhbg_m.mhbg015 = g_mhbg_m_o.mhbg015
                     CALL amht401_mhbg015_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mhbg_m_o.mhbg015 = g_mhbg_m.mhbg015
            CALL amht401_mhbg015_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg015
            #add-point:BEFORE FIELD mhbg015 name="input.b.mhbg015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg015
            #add-point:ON CHANGE mhbg015 name="input.g.mhbg015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg016
            #add-point:BEFORE FIELD mhbg016 name="input.b.mhbg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg016
            
            #add-point:AFTER FIELD mhbg016 name="input.a.mhbg016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg016
            #add-point:ON CHANGE mhbg016 name="input.g.mhbg016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg036
            #add-point:BEFORE FIELD mhbg036 name="input.b.mhbg036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg036
            
            #add-point:AFTER FIELD mhbg036 name="input.a.mhbg036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg036
            #add-point:ON CHANGE mhbg036 name="input.g.mhbg036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg017
            
            #add-point:AFTER FIELD mhbg017 name="input.a.mhbg017"
            LET g_mhbg_m.mhbg017_desc = ' '
            DISPLAY BY NAME g_mhbg_m.mhbg017_desc
            IF NOT cl_null(g_mhbg_m.mhbg017) THEN
               IF g_mhbg_m.mhbg017 != g_mhbg_m_o.mhbg017 OR cl_null(g_mhbg_m_o.mhbg017) THEN
                  IF NOT s_azzi650_chk_exist('250',g_mhbg_m.mhbg017) THEN
                     LET g_mhbg_m.mhbg017 = g_mhbg_m_o.mhbg017
                     CALL amht401_mhbg017_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mhbg_m_o.mhbg017 = g_mhbg_m.mhbg017
            CALL amht401_mhbg017_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg017
            #add-point:BEFORE FIELD mhbg017 name="input.b.mhbg017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg017
            #add-point:ON CHANGE mhbg017 name="input.g.mhbg017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg020
            #add-point:BEFORE FIELD mhbg020 name="input.b.mhbg020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg020
            
            #add-point:AFTER FIELD mhbg020 name="input.a.mhbg020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg020
            #add-point:ON CHANGE mhbg020 name="input.g.mhbg020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg037
            #add-point:BEFORE FIELD mhbg037 name="input.b.mhbg037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg037
            
            #add-point:AFTER FIELD mhbg037 name="input.a.mhbg037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg037
            #add-point:ON CHANGE mhbg037 name="input.g.mhbg037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg028
            
            #add-point:AFTER FIELD mhbg028 name="input.a.mhbg028"
            IF NOT cl_null(g_mhbg_m.mhbg028) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               IF g_mhbg_m.mhbg028 != g_mhbg_m_o.mhbg028 OR cl_null(g_mhbg_m_o.mhbg028) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_mhbg_m.mhbg028
                  #160318-00025#36      2016/04/20 By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)---S
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#36      2016/04/20 By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)---E
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     #檢查成功時後續處理
                     LET g_mhbg_m.mhbg028 = g_mhbg_m_o.mhbg028
                     CALL amht401_mhbg028_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_mhbg_m_o.mhbg028 = g_mhbg_m.mhbg028
            CALL amht401_mhbg028_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg028
            #add-point:BEFORE FIELD mhbg028 name="input.b.mhbg028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg028
            #add-point:ON CHANGE mhbg028 name="input.g.mhbg028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg029
            
            #add-point:AFTER FIELD mhbg029 name="input.a.mhbg029"
            IF NOT cl_null(g_mhbg_m.mhbg029) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               IF g_mhbg_m.mhbg029 != g_mhbg_m_o.mhbg029 OR cl_null(g_mhbg_m_o.mhbg029) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_mhbg_m.mhbg029
                     
                  #呼叫檢查存在並帶值的library
                  LET g_errshow = 1
                  #160318-00025#36      2016/04/20 By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)---S
                  LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#36      2016/04/20 By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)---E
                  IF NOT cl_chk_exist("v_oodb002") THEN
                     #檢查失敗時後續處理
                     LET g_mhbg_m.mhbg029 = g_mhbg_m_o.mhbg029
                     CALL amht401_mhbg029_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_mhbg_m_o.mhbg029 = g_mhbg_m.mhbg029
            CALL amht401_mhbg029_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg029
            #add-point:BEFORE FIELD mhbg029 name="input.b.mhbg029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg029
            #add-point:ON CHANGE mhbg029 name="input.g.mhbg029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg030
            #add-point:BEFORE FIELD mhbg030 name="input.b.mhbg030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg030
            
            #add-point:AFTER FIELD mhbg030 name="input.a.mhbg030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg030
            #add-point:ON CHANGE mhbg030 name="input.g.mhbg030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg031
            
            #add-point:AFTER FIELD mhbg031 name="input.a.mhbg031"
            LET g_mhbg_m.mhbg031_desc = ''
            DISPLAY BY NAME g_mhbg_m.mhbg031_desc
            IF NOT cl_null(g_mhbg_m.mhbg031) THEN 
               IF g_mhbg_m.mhbg031 != g_mhbg_m_o.mhbg031 OR cl_null(g_mhbg_m_o.mhbg031) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooef019
                  LET g_chkparam.arg2 = g_mhbg_m.mhbg031
                  IF NOT cl_chk_exist("v_isac002_1") THEN
                     LET g_mhbg_m.mhbg031 = g_mhbg_m_o.mhbg031
                     CALL s_desc_get_invoice_type_desc1(g_site,g_mhbg_m.mhbg031) RETURNING g_mhbg_m.mhbg031_desc
                     DISPLAY BY NAME g_mhbg_m.mhbg031_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_invoice_type_desc1(g_site,g_mhbg_m.mhbg031) RETURNING g_mhbg_m.mhbg031_desc
            DISPLAY BY NAME g_mhbg_m.mhbg031_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg031
            #add-point:BEFORE FIELD mhbg031 name="input.b.mhbg031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg031
            #add-point:ON CHANGE mhbg031 name="input.g.mhbg031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg032
            
            #add-point:AFTER FIELD mhbg032 name="input.a.mhbg032"
            LET g_mhbg_m.mhbg032_desc = ''
            DISPLAY BY NAME g_mhbg_m.mhbg032_desc
            IF NOT cl_null(g_mhbg_m.mhbg032) THEN 
               IF g_mhbg_m.mhbg032 != g_mhbg_m_o.mhbg032 OR cl_null(g_mhbg_m_o.mhbg032) THEN
                  IF NOT ap_chk_isExist(g_mhbg_m.mhbg032,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3211' AND oocq002 = ? ","sub-01303",'aapi010') THEN#160318-00005#23 mod  "apm-00179",1 ) THEN
                     LET g_mhbg_m.mhbg032 = g_mhbg_m_o.mhbg032
                     CALL amht401_mhbg032_ref()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_mhbg_m.mhbg032,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3211' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'aapi010') THEN#160318-00005#23 mod  #"apm-00180",1 ) THEN
                     LET g_mhbg_m.mhbg032 = g_mhbg_m_o.mhbg032
                     CALL amht401_mhbg032_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mhbg_m_o.mhbg032 = g_mhbg_m.mhbg032
            CALL amht401_mhbg032_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg032
            #add-point:BEFORE FIELD mhbg032 name="input.b.mhbg032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg032
            #add-point:ON CHANGE mhbg032 name="input.g.mhbg032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbg033
            
            #add-point:AFTER FIELD mhbg033 name="input.a.mhbg033"
            LET g_mhbg_m.mhbg033_desc = ''
            DISPLAY BY NAME g_mhbg_m.mhbg033_desc
            IF NOT cl_null(g_mhbg_m.mhbg033) THEN 
               IF g_mhbg_m.mhbg033 != g_mhbg_m_o.mhbg033 OR cl_null(g_mhbg_m_o.mhbg033) THEN
                  IF NOT ap_chk_isExist(g_mhbg_m.mhbg033,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3111' AND oocq002 = ? ","sub-01303",'axri010') THEN #160318-00005#23 mod #"apm-00181",1 ) THEN
                     LET g_mhbg_m.mhbg033 = g_mhbg_m_o.mhbg033
                     CALL amht401_mhbg033_ref()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_mhbg_m.mhbg033,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '3111' AND oocq002 = ? AND oocqstus = 'Y' ","sub-01302",'axri010') THEN#160318-00005#23 mod #"apm-00182",1 ) THEN
                     LET g_mhbg_m.mhbg033 = g_mhbg_m_o.mhbg033
                     CALL amht401_mhbg033_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mhbg_m_o.mhbg033 = g_mhbg_m.mhbg033
            CALL amht401_mhbg033_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbg033
            #add-point:BEFORE FIELD mhbg033 name="input.b.mhbg033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbg033
            #add-point:ON CHANGE mhbg033 name="input.g.mhbg033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="input.b.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="input.a.ooff013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013 name="input.g.ooff013"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mhbgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgsite
            #add-point:ON ACTION controlp INFIELD mhbgsite name="input.c.mhbgsite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbgsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhbgsite',g_site,'i')
            CALL q_ooef001_24()                                #呼叫開窗
 
            LET g_mhbg_m.mhbgsite = g_qryparam.return1              

            DISPLAY g_mhbg_m.mhbgsite TO mhbgsite              #
            CALL amht401_mhbgsite_ref()
            NEXT FIELD mhbgsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mhbgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgdocdt
            #add-point:ON ACTION controlp INFIELD mhbgdocdt name="input.c.mhbgdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgdocno
            #add-point:ON ACTION controlp INFIELD mhbgdocno name="input.c.mhbgdocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbgdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #s
            LET g_qryparam.arg2 = g_prog #s
 
            CALL q_ooba002_1()                                #呼叫開窗
 
            LET g_mhbg_m.mhbgdocno = g_qryparam.return1              

            DISPLAY g_mhbg_m.mhbgdocno TO mhbgdocno              #

            NEXT FIELD mhbgdocno                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbg034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg034
            #add-point:ON ACTION controlp INFIELD mhbg034 name="input.c.mhbg034"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg034             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_mhbg034()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg034 = g_qryparam.return1              

            DISPLAY g_mhbg_m.mhbg034 TO mhbg034              #

            NEXT FIELD mhbg034                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mhbg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg001
            #add-point:ON ACTION controlp INFIELD mhbg001 name="input.c.mhbg001"
            IF g_argv[1] = '2' THEN   #160604-00030#1 20160607 add by beckxie
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i' 
               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhbgsite',g_site,'c')
#               LET g_qryparam.where = cl_str_replace (g_qryparam.where,"ooef001","mhbgsite")
               #160512-00003#7
               LET g_qryparam.where = " mhbgent='",g_enterprise,"'"
               #LET g_qryparam.arg1 = 'amht401'    #160705-00042#1 160711 by sakura mark
               LET g_qryparam.arg1 = g_prog        #160705-00042#1 160711 by sakura add
               CALL q_mhbg001()                           #呼叫開窗
               LET g_mhbg_m.mhbg001 = g_qryparam.return1
               DISPLAY g_mhbg_m.mhbg001 TO mhbg001  #顯示到畫面上
               NEXT FIELD mhbg001                     #返回原欄位
            END IF   #160604-00030#1 20160607 add by beckxie
            #END add-point
 
 
         #Ctrlp:input.c.mhbgl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgl003
            #add-point:ON ACTION controlp INFIELD mhbgl003 name="input.c.mhbgl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg039
            #add-point:ON ACTION controlp INFIELD mhbg039 name="input.c.mhbg039"
           INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhbg_m.mhbg039      #給予default值
            #給予arg
            LET g_qryparam.arg1 = "251" 
            CALL q_oocq002()                                #呼叫開窗
            LET g_mhbg_m.mhbg039 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_mhbg_m.mhbg039 TO mhbg039             #顯示到畫面上
            CALL amht401_mhbg039_ref()
            NEXT FIELD mhbg039 
            #END add-point
 
 
         #Ctrlp:input.c.mhbgl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgl004
            #add-point:ON ACTION controlp INFIELD mhbgl004 name="input.c.mhbgl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbgl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgl005
            #add-point:ON ACTION controlp INFIELD mhbgl005 name="input.c.mhbgl005"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg018
            #add-point:ON ACTION controlp INFIELD mhbg018 name="input.c.mhbg018"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg000
            #add-point:ON ACTION controlp INFIELD mhbg000 name="input.c.mhbg000"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbgstus
            #add-point:ON ACTION controlp INFIELD mhbgstus name="input.c.mhbgstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg002
            #add-point:ON ACTION controlp INFIELD mhbg002 name="input.c.mhbg002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg003
            #add-point:ON ACTION controlp INFIELD mhbg003 name="input.c.mhbg003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pmaa001_14()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg003 = g_qryparam.return1              

            DISPLAY g_mhbg_m.mhbg003 TO mhbg003              #
            CALL amht401_mhbg003_ref()
            NEXT FIELD mhbg003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mhbg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg004
            #add-point:ON ACTION controlp INFIELD mhbg004 name="input.c.mhbg004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg004             #給予default值
            LET g_qryparam.default2 = "" #g_mhbg_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '261'

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg004 = g_qryparam.return1              
            #LET g_mhbg_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mhbg_m.mhbg004 TO mhbg004              #
            #DISPLAY g_mhbg_m.oocq002 TO oocq002 #應用分類碼
            CALL amht401_mhbg004_ref()
            NEXT FIELD mhbg004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mhbg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg005
            #add-point:ON ACTION controlp INFIELD mhbg005 name="input.c.mhbg005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocg001()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg005 = g_qryparam.return1              

            DISPLAY g_mhbg_m.mhbg005 TO mhbg005              #
            CALL amht401_mhbg005_ref()
            NEXT FIELD mhbg005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mhbg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg006
            #add-point:ON ACTION controlp INFIELD mhbg006 name="input.c.mhbg006"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg035
            #add-point:ON ACTION controlp INFIELD mhbg035 name="input.c.mhbg035"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg008
            #add-point:ON ACTION controlp INFIELD mhbg008 name="input.c.mhbg008"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg007
            #add-point:ON ACTION controlp INFIELD mhbg007 name="input.c.mhbg007"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg038
            #add-point:ON ACTION controlp INFIELD mhbg038 name="input.c.mhbg038"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg009
            #add-point:ON ACTION controlp INFIELD mhbg009 name="input.c.mhbg009"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg010
            #add-point:ON ACTION controlp INFIELD mhbg010 name="input.c.mhbg010"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhbg_m.mhbg010        #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                                #呼叫開窗
            LET g_mhbg_m.mhbg010 = g_qryparam.return1         #將開窗取得的值回傳到變數
            DISPLAY g_mhbg_m.mhbg010 TO mhbg010               #顯示到畫面上
            CALL amht401_mhbg010_ref()
            NEXT FIELD mhbg010                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mhbg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg012
            #add-point:ON ACTION controlp INFIELD mhbg012 name="input.c.mhbg012"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg013
            #add-point:ON ACTION controlp INFIELD mhbg013 name="input.c.mhbg013"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhbg_m.mhbg013        #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                                #呼叫開窗
            LET g_mhbg_m.mhbg013 = g_qryparam.return1         #將開窗取得的值回傳到變數
            DISPLAY g_mhbg_m.mhbg013 TO mhbg013               #顯示到畫面上
            CALL amht401_mhbg013_ref()
            NEXT FIELD mhbg013                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mhbg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg011
            #add-point:ON ACTION controlp INFIELD mhbg011 name="input.c.mhbg011"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg014
            #add-point:ON ACTION controlp INFIELD mhbg014 name="input.c.mhbg014"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg014             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "254" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg014 = g_qryparam.return1              
            #LET g_mhbg_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mhbg_m.mhbg014 TO mhbg014              #
            #DISPLAY g_mhbg_m.oocq002 TO oocq002 #應用分類碼
            CALL amht401_mhbg014_ref()
            NEXT FIELD mhbg014                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg015
            #add-point:ON ACTION controlp INFIELD mhbg015 name="input.c.mhbg015"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg015             #給予default值
            LET g_qryparam.default2 = "" #g_mhbg_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "260" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg015 = g_qryparam.return1              
            #LET g_mhbg_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mhbg_m.mhbg015 TO mhbg015              #
            #DISPLAY g_mhbg_m.oocq002 TO oocq002 #應用分類碼
            CALL amht401_mhbg015_ref()
            NEXT FIELD mhbg015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mhbg016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg016
            #add-point:ON ACTION controlp INFIELD mhbg016 name="input.c.mhbg016"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg036
            #add-point:ON ACTION controlp INFIELD mhbg036 name="input.c.mhbg036"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg017
            #add-point:ON ACTION controlp INFIELD mhbg017 name="input.c.mhbg017"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg017             #給予default值
            LET g_qryparam.default2 = "" #g_mhbg_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "250" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg017 = g_qryparam.return1              
            #LET g_mhbg_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mhbg_m.mhbg017 TO mhbg017              #
            #DISPLAY g_mhbg_m.oocq002 TO oocq002 #應用分類碼
            CALL amht401_mhbg017_ref()
            NEXT FIELD mhbg017                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbg020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg020
            #add-point:ON ACTION controlp INFIELD mhbg020 name="input.c.mhbg020"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg037
            #add-point:ON ACTION controlp INFIELD mhbg037 name="input.c.mhbg037"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg028
            #add-point:ON ACTION controlp INFIELD mhbg028 name="input.c.mhbg028"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #s

 
            CALL q_ooaj002_1()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg028 = g_qryparam.return1              

            DISPLAY g_mhbg_m.mhbg028 TO mhbg028              #
            CALL amht401_mhbg028_ref()
            NEXT FIELD mhbg028                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbg029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg029
            #add-point:ON ACTION controlp INFIELD mhbg029 name="input.c.mhbg029"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg029             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oodb002_2()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg029 = g_qryparam.return1              

            DISPLAY g_mhbg_m.mhbg029 TO mhbg029              #
            CALL amht401_mhbg029_ref()
            NEXT FIELD mhbg029                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbg030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg030
            #add-point:ON ACTION controlp INFIELD mhbg030 name="input.c.mhbg030"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbg031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg031
            #add-point:ON ACTION controlp INFIELD mhbg031 name="input.c.mhbg031"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef019
            LET g_qryparam.arg2 = "1"
 
            CALL q_isac002_2()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg031 = g_qryparam.return1              

            DISPLAY g_mhbg_m.mhbg031 TO mhbg031              #
            CALL s_desc_get_invoice_type_desc1(g_site,g_mhbg_m.mhbg031) RETURNING g_mhbg_m.mhbg031_desc
            DISPLAY BY NAME g_mhbg_m.mhbg031_desc
            NEXT FIELD mhbg031                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbg032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg032
            #add-point:ON ACTION controlp INFIELD mhbg032 name="input.c.mhbg032"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3211" #s

 
            CALL q_oocq002()                              #呼叫開窗
 
            LET g_mhbg_m.mhbg032 = g_qryparam.return1              

            DISPLAY g_mhbg_m.mhbg032 TO mhbg032              #
            CALL amht401_mhbg032_ref()
            NEXT FIELD mhbg032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mhbg033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbg033
            #add-point:ON ACTION controlp INFIELD mhbg033 name="input.c.mhbg033"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbg_m.mhbg033             #給予default值
            LET g_qryparam.default2 = "" #g_mhbg_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "3111" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhbg_m.mhbg033 = g_qryparam.return1              
            #LET g_mhbg_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mhbg_m.mhbg033 TO mhbg033              #
            CALL amht401_mhbg033_ref()
            #DISPLAY g_mhbg_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mhbg033                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.ooff013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.ooff013"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mhbg_m.mhbgdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #mark by geza 20160628(S)
#               LET l_str = g_mhbg_m.mhbg001               
#                if l_str.getIndexOf('&',1)>0 then
#                 CALL s_aooi390_gen('2') RETURNING l_success,g_mhbg_m.mhbg001,l_oofg_return
#                  DISPLAY BY NAME g_mhbg_m.mhbg001
#                  IF g_mhbg_m.mhbg002 = '1' THEN
#                     LET g_mhbg_m.mhbg003 = g_mhbg_m.mhbg001
#                  END IF
#              end if 
               #mark by geza 20160628(E)
               #add by geza 20160628(S)
               LET l_str = g_mhbg_m.mhbg001   
               #有设置自动编号的话就重新取值
               LET l_cnt = 0
               SELECT COUNT(distinct oofg001) INTO l_cnt
                 FROM oofg_t
                WHERE oofgent = g_enterprise
                  AND oofg002 = '2'
                  AND oofgstus = 'Y'
               IF l_cnt > 0 THEN
                  IF l_str.getIndexOf('&',1)>0 OR l_str IS NULL THEN
                    CALL s_aooi390_gen('2') RETURNING l_success,g_mhbg_m.mhbg001,l_oofg_return
                  END IF 
               END IF
               #add by geza 20160628(E)
               CALL s_aooi390_get_auto_no('2',g_mhbg_m.mhbg001) RETURNING l_success,g_mhbg_m.mhbg001
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               #自動編碼後若編碼結果與原本不同,更新多語言
               IF g_mhbg_m_o.mhbg001 != g_mhbg_m.mhbg001 AND NOT cl_null(g_mhbg_m_o.mhbg001) THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM mhbgl_t
                   WHERE mhbglent = g_enterprise
                     AND mhbgl001 = g_mhbg_m_o.mhbg001
                  IF l_cnt > 0 THEN
                     UPDATE mhbgl_t SET mhbgl001 = g_mhbg_m.mhbg001
                      WHERE mhbglent = g_enterprise
                        AND mhbgl001 = g_mhbg_m_o.mhbg001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd mhbgl_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  IF g_mhbg_m.mhbg002 = '1' THEN
                     LET g_mhbg_m.mhbg003 = g_mhbg_m.mhbg001
                  END IF 
                  

               END IF
               CALL s_aooi390_oofi_upd('2',g_mhbg_m.mhbg001) RETURNING l_success  
               IF NOT s_aooi200_chk_slip(g_site,'',g_mhbg_m.mhbgdocno,g_prog) THEN
                  LET g_mhbg_m.mhbgdocno = ''
                  NEXT FIELD mhbgdocno 
               END IF
               #add by geza 20160628(S)
               IF g_mhbg_m.mhbg002 = '1' THEN
                  LET g_mhbg_m.mhbg003 = g_mhbg_m.mhbg001
               END IF 
               IF g_mhbg_m.mhbg001 IS NULL OR g_mhbg_m.mhbg001 = ' ' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'amh-00670'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                   
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF 
               #add by geza 20160628(E)
               CALL s_aooi200_gen_docno(g_site,g_mhbg_m.mhbgdocno,g_mhbg_m.mhbgdocdt,g_prog) RETURNING l_success,g_mhbg_m.mhbgdocno
               IF NOT l_success THEN
                  NEXT FIELD mhbgdocno
               END IF
               ##自動編碼後若編碼結果與原本不同,更新多語言
               IF g_mhbg_m_o.mhbgdocno != g_mhbg_m.mhbgdocno AND NOT cl_null(g_mhbg_m_o.mhbgdocno) THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM mhbgl_t
                   WHERE mhbglent = g_enterprise
                     AND mhbgldocno = g_mhbg_m_o.mhbgdocno
                  IF l_cnt > 0 THEN
                     UPDATE mhbgl_t SET mhbgldocno = g_mhbg_m.mhbgdocno
                      WHERE mhbglent = g_enterprise
                        AND mhbgldocno = g_mhbg_m_o.mhbgdocno
                        AND mhbgl002 != g_dlang
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd mhbgl_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
               
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               
               IF cl_null(g_mhbg_m.mhbg037) THEN
                  CALL s_aooi350_ins_oofa('3',g_mhbg_m.mhbgdocno,'') RETURNING l_success,g_mhbg_m.mhbg037
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oofa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD mhbgdocno
                  END IF
                  
               END IF    
               #end add-point
               
               INSERT INTO mhbg_t (mhbgent,mhbgsite,mhbgdocdt,mhbgdocno,mhbg034,mhbg001,mhbg039,mhbg018, 
                   mhbg000,mhbgstus,mhbg002,mhbg003,mhbg004,mhbg005,mhbg006,mhbg035,mhbg008,mhbg007, 
                   mhbg038,mhbg009,mhbg010,mhbg012,mhbg013,mhbg011,mhbg014,mhbg015,mhbg016,mhbg036,mhbg017, 
                   mhbg020,mhbg037,mhbg028,mhbg029,mhbg030,mhbg031,mhbg032,mhbg033,mhbgownid,mhbgowndp, 
                   mhbgcrtid,mhbgcrtdp,mhbgcrtdt,mhbgmodid,mhbgmoddt,mhbgcnfid,mhbgcnfdt)
               VALUES (g_enterprise,g_mhbg_m.mhbgsite,g_mhbg_m.mhbgdocdt,g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034, 
                   g_mhbg_m.mhbg001,g_mhbg_m.mhbg039,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000,g_mhbg_m.mhbgstus, 
                   g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006, 
                   g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009, 
                   g_mhbg_m.mhbg010,g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014, 
                   g_mhbg_m.mhbg015,g_mhbg_m.mhbg016,g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020, 
                   g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg029,g_mhbg_m.mhbg030,g_mhbg_m.mhbg031, 
                   g_mhbg_m.mhbg032,g_mhbg_m.mhbg033,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgowndp,g_mhbg_m.mhbgcrtid, 
                   g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdt,g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt,g_mhbg_m.mhbgcnfid, 
                   g_mhbg_m.mhbgcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mhbg_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               #更新ooff_t 備註
               IF NOT cl_null(g_mhbg_m.mhbgdocno) THEN
                  IF NOT cl_null(g_mhbg_m.ooff013) THEN
                     LET l_success = ''
                     CALL s_aooi360_gen('2',g_mhbg_m.mhbgdocno,'','','','','','','','','','4',g_mhbg_m.ooff013) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  ELSE
                     CALL s_aooi360_del('2',g_mhbg_m.mhbgdocno,'','','','','','','','','','4') RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  END IF
               END IF
               CALL amht401_b_fill()
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_mhbg_m.mhbgdocno = g_master_multi_table_t.mhbgldocno AND
         g_mhbg_m.mhbg001 = g_master_multi_table_t.mhbgl001 AND
         g_mhbg_m.mhbgl003 = g_master_multi_table_t.mhbgl003 AND 
         g_mhbg_m.mhbgl004 = g_master_multi_table_t.mhbgl004 AND 
         g_mhbg_m.mhbgl005 = g_master_multi_table_t.mhbgl005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhbglent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhbg_m.mhbgdocno
            LET l_field_keys[02] = 'mhbgldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mhbgldocno
            LET l_var_keys[03] = g_mhbg_m.mhbg001
            LET l_field_keys[03] = 'mhbgl001'
            LET l_var_keys_bak[03] = g_master_multi_table_t.mhbgl001
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'mhbgl002'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_mhbg_m.mhbgl003
            LET l_fields[01] = 'mhbgl003'
            LET l_vars[02] = g_mhbg_m.mhbgl004
            LET l_fields[02] = 'mhbgl004'
            LET l_vars[03] = g_mhbg_m.mhbgl005
            LET l_fields[03] = 'mhbgl005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhbgl_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               IF g_argv[1] = '2' THEN
                  #若無資料再從oofb_t,oofc_t帶出
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM oofb_t
                   WHERE oofbent = g_enterprise 
                     AND oofb002 = g_mhbg_m.mhbg037
                  IF l_cnt = 0 THEN
                     CALL amht401_carry_b()
                  END IF
               END IF
               CALL amht401_b_fill()
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL amht401_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL amht401_b_fill()
                  CALL amht401_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               IF cl_null(g_mhbg_m.mhbg037) THEN
                  CALL s_aooi350_ins_oofa('3',g_mhbg_m.mhbgdocno,'') RETURNING l_success,g_mhbg_m.mhbg037
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oofa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD mhbgdocno
                  END IF
               END IF
               #更新ooff_t 備註
               IF NOT cl_null(g_mhbg_m.mhbgdocno) THEN
                  IF NOT cl_null(g_mhbg_m.ooff013) THEN
                     LET l_success = ''
                     CALL s_aooi360_gen('2',g_mhbg_m.mhbgdocno,'','','','','','','','','','4',g_mhbg_m.ooff013) RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  ELSE
                     CALL s_aooi360_del('2',g_mhbg_m.mhbgdocno,'','','','','','','','','','4') RETURNING l_success
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ooff_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CONTINUE DIALOG
                     END IF
                  END IF
               END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL amht401_mhbg_t_mask_restore('restore_mask_o')
               
               UPDATE mhbg_t SET (mhbgsite,mhbgdocdt,mhbgdocno,mhbg034,mhbg001,mhbg039,mhbg018,mhbg000, 
                   mhbgstus,mhbg002,mhbg003,mhbg004,mhbg005,mhbg006,mhbg035,mhbg008,mhbg007,mhbg038, 
                   mhbg009,mhbg010,mhbg012,mhbg013,mhbg011,mhbg014,mhbg015,mhbg016,mhbg036,mhbg017,mhbg020, 
                   mhbg037,mhbg028,mhbg029,mhbg030,mhbg031,mhbg032,mhbg033,mhbgownid,mhbgowndp,mhbgcrtid, 
                   mhbgcrtdp,mhbgcrtdt,mhbgmodid,mhbgmoddt,mhbgcnfid,mhbgcnfdt) = (g_mhbg_m.mhbgsite, 
                   g_mhbg_m.mhbgdocdt,g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034,g_mhbg_m.mhbg001,g_mhbg_m.mhbg039, 
                   g_mhbg_m.mhbg018,g_mhbg_m.mhbg000,g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003, 
                   g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006,g_mhbg_m.mhbg035,g_mhbg_m.mhbg008, 
                   g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010,g_mhbg_m.mhbg012, 
                   g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg015,g_mhbg_m.mhbg016, 
                   g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028, 
                   g_mhbg_m.mhbg029,g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg032,g_mhbg_m.mhbg033, 
                   g_mhbg_m.mhbgownid,g_mhbg_m.mhbgowndp,g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdt, 
                   g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt,g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfdt)
                WHERE mhbgent = g_enterprise AND mhbgdocno = g_mhbgdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mhbg_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_mhbg_m.mhbgdocno = g_master_multi_table_t.mhbgldocno AND
         g_mhbg_m.mhbg001 = g_master_multi_table_t.mhbgl001 AND
         g_mhbg_m.mhbgl003 = g_master_multi_table_t.mhbgl003 AND 
         g_mhbg_m.mhbgl004 = g_master_multi_table_t.mhbgl004 AND 
         g_mhbg_m.mhbgl005 = g_master_multi_table_t.mhbgl005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhbglent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhbg_m.mhbgdocno
            LET l_field_keys[02] = 'mhbgldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mhbgldocno
            LET l_var_keys[03] = g_mhbg_m.mhbg001
            LET l_field_keys[03] = 'mhbgl001'
            LET l_var_keys_bak[03] = g_master_multi_table_t.mhbgl001
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'mhbgl002'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_mhbg_m.mhbgl003
            LET l_fields[01] = 'mhbgl003'
            LET l_vars[02] = g_mhbg_m.mhbgl004
            LET l_fields[02] = 'mhbgl004'
            LET l_vars[03] = g_mhbg_m.mhbgl005
            LET l_fields[03] = 'mhbgl005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhbgl_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL amht401_mhbg_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mhbg_m_t)
               LET g_log2 = util.JSON.stringify(g_mhbg_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               IF NOT cl_null(g_mhbg_m.mhbg037) THEN
                  IF g_argv[1] = '2' THEN
                     CALL amht401_carry_b()
                  END IF
                  LET g_pmaa027_d = g_mhbg_m.mhbg037
                  CALL aooi350_01_b_fill(g_pmaa027_d)
                  CALL aooi350_02_b_fill(g_pmaa027_d)
               END IF
               CALL amht401_b_fill()
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mhbgdocno_t = g_mhbg_m.mhbgdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="amht401.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mhbh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mhbh_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amht401_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mhbh_d.getLength()
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
            OPEN amht401_cl USING g_enterprise,g_mhbg_m.mhbgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amht401_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amht401_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mhbh_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mhbh_d[l_ac].mhbh002 IS NOT NULL
               AND g_mhbh_d[l_ac].mhbh003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mhbh_d_t.* = g_mhbh_d[l_ac].*  #BACKUP
               LET g_mhbh_d_o.* = g_mhbh_d[l_ac].*  #BACKUP
               CALL amht401_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL amht401_set_no_entry_b(l_cmd)
               IF NOT amht401_lock_b("mhbh_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amht401_bcl INTO g_mhbh_d[l_ac].mhbh001,g_mhbh_d[l_ac].mhbhacti,g_mhbh_d[l_ac].mhbh002, 
                      g_mhbh_d[l_ac].mhbh003,g_mhbh_d[l_ac].mhbh004,g_mhbh_d[l_ac].mhbh007,g_mhbh_d[l_ac].mhbh008 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mhbh_d_t.mhbh002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mhbh_d_mask_o[l_ac].* =  g_mhbh_d[l_ac].*
                  CALL amht401_mhbh_t_mask()
                  LET g_mhbh_d_mask_n[l_ac].* =  g_mhbh_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amht401_show()
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
            INITIALIZE g_mhbh_d[l_ac].* TO NULL 
            INITIALIZE g_mhbh_d_t.* TO NULL 
            INITIALIZE g_mhbh_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_mhbh_d[l_ac].mhbhacti = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_mhbh_d[l_ac].mhbh001 = g_mhbg_m.mhbg001
            #end add-point
            LET g_mhbh_d_t.* = g_mhbh_d[l_ac].*     #新輸入資料
            LET g_mhbh_d_o.* = g_mhbh_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amht401_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL amht401_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mhbh_d[li_reproduce_target].* = g_mhbh_d[li_reproduce].*
 
               LET g_mhbh_d[li_reproduce_target].mhbh002 = NULL
               LET g_mhbh_d[li_reproduce_target].mhbh003 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM mhbh_t 
             WHERE mhbhent = g_enterprise AND mhbhdocno = g_mhbg_m.mhbgdocno
 
               AND mhbh002 = g_mhbh_d[l_ac].mhbh002
               AND mhbh003 = g_mhbh_d[l_ac].mhbh003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhbg_m.mhbgdocno
               LET gs_keys[2] = g_mhbh_d[g_detail_idx].mhbh002
               LET gs_keys[3] = g_mhbh_d[g_detail_idx].mhbh003
               CALL amht401_insert_b('mhbh_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mhbh_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhbh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amht401_b_fill()
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
               LET gs_keys[01] = g_mhbg_m.mhbgdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mhbh_d_t.mhbh002
               LET gs_keys[gs_keys.getLength()+1] = g_mhbh_d_t.mhbh003
 
            
               #刪除同層單身
               IF NOT amht401_delete_b('mhbh_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amht401_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amht401_key_delete_b(gs_keys,'mhbh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amht401_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE amht401_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mhbh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mhbh_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh001
            #add-point:BEFORE FIELD mhbh001 name="input.b.page1.mhbh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh001
            
            #add-point:AFTER FIELD mhbh001 name="input.a.page1.mhbh001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbh001
            #add-point:ON CHANGE mhbh001 name="input.g.page1.mhbh001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbhacti
            #add-point:BEFORE FIELD mhbhacti name="input.b.page1.mhbhacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbhacti
            
            #add-point:AFTER FIELD mhbhacti name="input.a.page1.mhbhacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbhacti
            #add-point:ON CHANGE mhbhacti name="input.g.page1.mhbhacti"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh002
            
            #add-point:AFTER FIELD mhbh002 name="input.a.page1.mhbh002"
            LET g_mhbh_d[l_ac].mhbh002_desc = ''
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_mhbg_m.mhbgdocno IS NOT NULL AND g_mhbh_d[l_ac].mhbh002 IS NOT NULL AND g_mhbh_d[l_ac].mhbh003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhbg_m.mhbgdocno != g_mhbgdocno_t OR g_mhbh_d[l_ac].mhbh002 != g_mhbh_d_t.mhbh002 OR g_mhbh_d[l_ac].mhbh003 != g_mhbh_d_t.mhbh003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhbh_t WHERE "||"mhbhent = '" ||g_enterprise|| "' AND "||"mhbhdocno = '"||g_mhbg_m.mhbgdocno ||"' AND "|| "mhbh002 = '"||g_mhbh_d[l_ac].mhbh002 ||"' AND "|| "mhbh003 = '"||g_mhbh_d[l_ac].mhbh003 ||"'",'std-00004',0) THEN 
                     LET g_mhbh_d[l_ac].mhbh002 = g_mhbh_d_t.mhbh002
                     CALL amht401_mhbh002_ref()
                     CALL amht401_mhbh004_default()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_mhbh_d[l_ac].mhbh002) THEN
               IF g_mhbh_d[l_ac].mhbh002 != g_mhbh_d_o.mhbh002 OR cl_null(g_mhbh_d_o.mhbh002) THEN
                  IF NOT s_azzi650_chk_exist('2036',g_mhbh_d[l_ac].mhbh002) THEN
                     LET g_mhbh_d[l_ac].mhbh002 = g_mhbh_d_o.mhbh002
                     CALL amht401_mhbh002_ref()
                     CALL amht401_mhbh004_default()
                     NEXT FIELD CURRENT
                  END IF
                  CALL amht401_mhbh002_ref()
                  CALL amht401_mhbh004_default()
               END IF
            END IF
            CALL amht401_mhbh002_ref()
            LET g_mhbh_d_o.mhbh002 = g_mhbh_d[l_ac].mhbh002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh002
            #add-point:BEFORE FIELD mhbh002 name="input.b.page1.mhbh002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbh002
            #add-point:ON CHANGE mhbh002 name="input.g.page1.mhbh002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh003
            #add-point:BEFORE FIELD mhbh003 name="input.b.page1.mhbh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh003
            
            #add-point:AFTER FIELD mhbh003 name="input.a.page1.mhbh003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_mhbg_m.mhbgdocno IS NOT NULL AND g_mhbh_d[l_ac].mhbh002 IS NOT NULL AND g_mhbh_d[l_ac].mhbh003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhbg_m.mhbgdocno != g_mhbgdocno_t OR g_mhbh_d[l_ac].mhbh002 != g_mhbh_d_t.mhbh002 OR g_mhbh_d[l_ac].mhbh003 != g_mhbh_d_t.mhbh003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhbh_t WHERE "||"mhbhent = '" ||g_enterprise|| "' AND "||"mhbhdocno = '"||g_mhbg_m.mhbgdocno ||"' AND "|| "mhbh002 = '"||g_mhbh_d[l_ac].mhbh002 ||"' AND "|| "mhbh003 = '"||g_mhbh_d[l_ac].mhbh003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbh003
            #add-point:ON CHANGE mhbh003 name="input.g.page1.mhbh003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh004
            #add-point:BEFORE FIELD mhbh004 name="input.b.page1.mhbh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh004
            
            #add-point:AFTER FIELD mhbh004 name="input.a.page1.mhbh004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbh004
            #add-point:ON CHANGE mhbh004 name="input.g.page1.mhbh004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh007
            #add-point:BEFORE FIELD mhbh007 name="input.b.page1.mhbh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh007
            
            #add-point:AFTER FIELD mhbh007 name="input.a.page1.mhbh007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbh007
            #add-point:ON CHANGE mhbh007 name="input.g.page1.mhbh007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbh008
            #add-point:BEFORE FIELD mhbh008 name="input.b.page1.mhbh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbh008
            
            #add-point:AFTER FIELD mhbh008 name="input.a.page1.mhbh008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbh008
            #add-point:ON CHANGE mhbh008 name="input.g.page1.mhbh008"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mhbh001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh001
            #add-point:ON ACTION controlp INFIELD mhbh001 name="input.c.page1.mhbh001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbhacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbhacti
            #add-point:ON ACTION controlp INFIELD mhbhacti name="input.c.page1.mhbhacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh002
            #add-point:ON ACTION controlp INFIELD mhbh002 name="input.c.page1.mhbh002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbh_d[l_ac].mhbh002             #給予default值
            LET g_qryparam.default2 = "" #g_mhbh_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2036" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhbh_d[l_ac].mhbh002 = g_qryparam.return1              
            #LET g_mhbh_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_mhbh_d[l_ac].mhbh002 TO mhbh002              #
            #DISPLAY g_mhbh_d[l_ac].oocq002 TO oocq002 #應用分類碼
            CALL amht401_mhbh002_ref()
            NEXT FIELD mhbh002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh003
            #add-point:ON ACTION controlp INFIELD mhbh003 name="input.c.page1.mhbh003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh004
            #add-point:ON ACTION controlp INFIELD mhbh004 name="input.c.page1.mhbh004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh007
            #add-point:ON ACTION controlp INFIELD mhbh007 name="input.c.page1.mhbh007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbh008
            #add-point:ON ACTION controlp INFIELD mhbh008 name="input.c.page1.mhbh008"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mhbh_d[l_ac].* = g_mhbh_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amht401_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mhbh_d[l_ac].mhbh002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mhbh_d[l_ac].* = g_mhbh_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL amht401_mhbh_t_mask_restore('restore_mask_o')
      
               UPDATE mhbh_t SET (mhbhdocno,mhbh001,mhbhacti,mhbh002,mhbh003,mhbh004,mhbh007,mhbh008) = (g_mhbg_m.mhbgdocno, 
                   g_mhbh_d[l_ac].mhbh001,g_mhbh_d[l_ac].mhbhacti,g_mhbh_d[l_ac].mhbh002,g_mhbh_d[l_ac].mhbh003, 
                   g_mhbh_d[l_ac].mhbh004,g_mhbh_d[l_ac].mhbh007,g_mhbh_d[l_ac].mhbh008)
                WHERE mhbhent = g_enterprise AND mhbhdocno = g_mhbg_m.mhbgdocno 
 
                  AND mhbh002 = g_mhbh_d_t.mhbh002 #項次   
                  AND mhbh003 = g_mhbh_d_t.mhbh003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mhbh_d[l_ac].* = g_mhbh_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhbh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mhbh_d[l_ac].* = g_mhbh_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhbh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhbg_m.mhbgdocno
               LET gs_keys_bak[1] = g_mhbgdocno_t
               LET gs_keys[2] = g_mhbh_d[g_detail_idx].mhbh002
               LET gs_keys_bak[2] = g_mhbh_d_t.mhbh002
               LET gs_keys[3] = g_mhbh_d[g_detail_idx].mhbh003
               LET gs_keys_bak[3] = g_mhbh_d_t.mhbh003
               CALL amht401_update_b('mhbh_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL amht401_mhbh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mhbh_d[g_detail_idx].mhbh002 = g_mhbh_d_t.mhbh002 
                  AND g_mhbh_d[g_detail_idx].mhbh003 = g_mhbh_d_t.mhbh003 
 
                  ) THEN
                  LET gs_keys[01] = g_mhbg_m.mhbgdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mhbh_d_t.mhbh002
                  LET gs_keys[gs_keys.getLength()+1] = g_mhbh_d_t.mhbh003
 
                  CALL amht401_key_update_b(gs_keys,'mhbh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mhbg_m),util.JSON.stringify(g_mhbh_d_t)
               LET g_log2 = util.JSON.stringify(g_mhbg_m),util.JSON.stringify(g_mhbh_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL amht401_unlock_b("mhbh_t","'1'")
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
               LET g_mhbh_d[li_reproduce_target].* = g_mhbh_d[li_reproduce].*
 
               LET g_mhbh_d[li_reproduce_target].mhbh002 = NULL
               LET g_mhbh_d[li_reproduce_target].mhbh003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mhbh_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mhbh_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_mhbh2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mhbh2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amht401_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mhbh2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mhbh2_d[l_ac].* TO NULL 
            INITIALIZE g_mhbh2_d_t.* TO NULL 
            INITIALIZE g_mhbh2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_mhbh2_d[l_ac].mhbiacti = "Y"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            LET g_mhbh2_d[l_ac].mhbi001 = g_mhbg_m.mhbg001
            #end add-point
            LET g_mhbh2_d_t.* = g_mhbh2_d[l_ac].*     #新輸入資料
            LET g_mhbh2_d_o.* = g_mhbh2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amht401_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL amht401_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mhbh2_d[li_reproduce_target].* = g_mhbh2_d[li_reproduce].*
 
               LET g_mhbh2_d[li_reproduce_target].mhbi002 = NULL
               LET g_mhbh2_d[li_reproduce_target].mhbi003 = NULL
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
            OPEN amht401_cl USING g_enterprise,g_mhbg_m.mhbgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amht401_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amht401_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mhbh2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mhbh2_d[l_ac].mhbi002 IS NOT NULL
               AND g_mhbh2_d[l_ac].mhbi003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mhbh2_d_t.* = g_mhbh2_d[l_ac].*  #BACKUP
               LET g_mhbh2_d_o.* = g_mhbh2_d[l_ac].*  #BACKUP
               CALL amht401_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL amht401_set_no_entry_b(l_cmd)
               IF NOT amht401_lock_b("mhbi_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amht401_bcl2 INTO g_mhbh2_d[l_ac].mhbiacti,g_mhbh2_d[l_ac].mhbi001,g_mhbh2_d[l_ac].mhbi002, 
                      g_mhbh2_d[l_ac].mhbi003
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mhbh2_d_mask_o[l_ac].* =  g_mhbh2_d[l_ac].*
                  CALL amht401_mhbi_t_mask()
                  LET g_mhbh2_d_mask_n[l_ac].* =  g_mhbh2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amht401_show()
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
               LET gs_keys[01] = g_mhbg_m.mhbgdocno
               LET gs_keys[gs_keys.getLength()+1] = g_mhbh2_d_t.mhbi002
               LET gs_keys[gs_keys.getLength()+1] = g_mhbh2_d_t.mhbi003
            
               #刪除同層單身
               IF NOT amht401_delete_b('mhbi_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amht401_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amht401_key_delete_b(gs_keys,'mhbi_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amht401_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE amht401_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_mhbh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mhbh2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mhbi_t 
             WHERE mhbient = g_enterprise AND mhbidocno = g_mhbg_m.mhbgdocno
               AND mhbi002 = g_mhbh2_d[l_ac].mhbi002
               AND mhbi003 = g_mhbh2_d[l_ac].mhbi003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhbg_m.mhbgdocno
               LET gs_keys[2] = g_mhbh2_d[g_detail_idx].mhbi002
               LET gs_keys[3] = g_mhbh2_d[g_detail_idx].mhbi003
               CALL amht401_insert_b('mhbi_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mhbh_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mhbi_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amht401_b_fill()
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
               LET g_mhbh2_d[l_ac].* = g_mhbh2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amht401_bcl2
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
               LET g_mhbh2_d[l_ac].* = g_mhbh2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL amht401_mhbi_t_mask_restore('restore_mask_o')
                              
               UPDATE mhbi_t SET (mhbidocno,mhbiacti,mhbi001,mhbi002,mhbi003) = (g_mhbg_m.mhbgdocno, 
                   g_mhbh2_d[l_ac].mhbiacti,g_mhbh2_d[l_ac].mhbi001,g_mhbh2_d[l_ac].mhbi002,g_mhbh2_d[l_ac].mhbi003)  
                   #自訂欄位頁簽
                WHERE mhbient = g_enterprise AND mhbidocno = g_mhbg_m.mhbgdocno
                  AND mhbi002 = g_mhbh2_d_t.mhbi002 #項次 
                  AND mhbi003 = g_mhbh2_d_t.mhbi003
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mhbh2_d[l_ac].* = g_mhbh2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhbi_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mhbh2_d[l_ac].* = g_mhbh2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhbi_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhbg_m.mhbgdocno
               LET gs_keys_bak[1] = g_mhbgdocno_t
               LET gs_keys[2] = g_mhbh2_d[g_detail_idx].mhbi002
               LET gs_keys_bak[2] = g_mhbh2_d_t.mhbi002
               LET gs_keys[3] = g_mhbh2_d[g_detail_idx].mhbi003
               LET gs_keys_bak[3] = g_mhbh2_d_t.mhbi003
               CALL amht401_update_b('mhbi_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amht401_mhbi_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mhbh2_d[g_detail_idx].mhbi002 = g_mhbh2_d_t.mhbi002 
                  AND g_mhbh2_d[g_detail_idx].mhbi003 = g_mhbh2_d_t.mhbi003 
                  ) THEN
                  LET gs_keys[01] = g_mhbg_m.mhbgdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mhbh2_d_t.mhbi002
                  LET gs_keys[gs_keys.getLength()+1] = g_mhbh2_d_t.mhbi003
                  CALL amht401_key_update_b(gs_keys,'mhbi_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mhbg_m),util.JSON.stringify(g_mhbh2_d_t)
               LET g_log2 = util.JSON.stringify(g_mhbg_m),util.JSON.stringify(g_mhbh2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbiacti
            #add-point:BEFORE FIELD mhbiacti name="input.b.page2.mhbiacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbiacti
            
            #add-point:AFTER FIELD mhbiacti name="input.a.page2.mhbiacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbiacti
            #add-point:ON CHANGE mhbiacti name="input.g.page2.mhbiacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbi001
            #add-point:BEFORE FIELD mhbi001 name="input.b.page2.mhbi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbi001
            
            #add-point:AFTER FIELD mhbi001 name="input.a.page2.mhbi001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbi001
            #add-point:ON CHANGE mhbi001 name="input.g.page2.mhbi001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbi002
            
            #add-point:AFTER FIELD mhbi002 name="input.a.page2.mhbi002"
            LET g_mhbh2_d[l_ac].mhbi002_desc = ''
            IF NOT cl_null(g_mhbh2_d[l_ac].mhbi002) THEN
               IF g_mhbh2_d[l_ac].mhbi002 != g_mhbh2_d_o.mhbi002 OR cl_null(g_mhbh2_d_o.mhbi002) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhbh2_d[l_ac].mhbi002
                  LET g_chkparam.where = " rtax005 = 0 "
                  IF NOT cl_chk_exist("v_rtax001_5") THEN
                     LET g_mhbh2_d[l_ac].mhbi002 = g_mhbh2_d_o.mhbi002
                     CALL amht401_mhbi002_ref()
                     NEXT FIELD CURRENT                  
                  END IF
               END IF
            END IF
            CALL amht401_mhbi002_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbi002
            #add-point:BEFORE FIELD mhbi002 name="input.b.page2.mhbi002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbi002
            #add-point:ON CHANGE mhbi002 name="input.g.page2.mhbi002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbi003
            
            #add-point:AFTER FIELD mhbi003 name="input.a.page2.mhbi003"
            LET g_mhbh2_d[l_ac].mhbi003_desc = ''
            IF NOT cl_null(g_mhbh2_d[l_ac].mhbi003) THEN
               IF g_mhbh2_d[l_ac].mhbi003 != g_mhbh2_d_o.mhbi003 OR cl_null(g_mhbh2_d_o.mhbi003) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  IF NOT s_azzi650_chk_exist('2002',g_mhbh2_d[l_ac].mhbi003) THEN
                     LET g_mhbh2_d[l_ac].mhbi003 = g_mhbh2_d_o.mhbi003
                     CALL amht401_mhbi003_ref()
                     NEXT FIELD CURRENT                  
                  END IF
               END IF
            END IF
            CALL amht401_mhbi003_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbi003
            #add-point:BEFORE FIELD mhbi003 name="input.b.page2.mhbi003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbi003
            #add-point:ON CHANGE mhbi003 name="input.g.page2.mhbi003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.mhbiacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbiacti
            #add-point:ON ACTION controlp INFIELD mhbiacti name="input.c.page2.mhbiacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mhbi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbi001
            #add-point:ON ACTION controlp INFIELD mhbi001 name="input.c.page2.mhbi001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mhbi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbi002
            #add-point:ON ACTION controlp INFIELD mhbi002 name="input.c.page2.mhbi002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbh2_d[l_ac].mhbi002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_rtax001_2()                                #呼叫開窗
 
            LET g_mhbh2_d[l_ac].mhbi002 = g_qryparam.return1              

            DISPLAY g_mhbh2_d[l_ac].mhbi002 TO mhbi002              #
            CALL amht401_mhbi002_ref()
            NEXT FIELD mhbi002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.mhbi003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbi003
            #add-point:ON ACTION controlp INFIELD mhbi003 name="input.c.page2.mhbi003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbh2_d[l_ac].mhbi003             #給予default值
            LET g_qryparam.default2 = "" #g_mhbh2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2002" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhbh2_d[l_ac].mhbi003 = g_qryparam.return1              
            #LET g_mhbh2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_mhbh2_d[l_ac].mhbi003 TO mhbi003              #
            #DISPLAY g_mhbh2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            CALL amht401_mhbi003_ref()
            NEXT FIELD mhbi003                          #返回原欄位



            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mhbh2_d[l_ac].* = g_mhbh2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amht401_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL amht401_unlock_b("mhbi_t","'2'")
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
               LET g_mhbh2_d[li_reproduce_target].* = g_mhbh2_d[li_reproduce].*
 
               LET g_mhbh2_d[li_reproduce_target].mhbi002 = NULL
               LET g_mhbh2_d[li_reproduce_target].mhbi003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mhbh2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mhbh2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="amht401.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      SUBDIALOG aoo_aooi350_01.aooi350_01_input
      SUBDIALOG aoo_aooi350_02.aooi350_02_input
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD mhbgdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mhbh001
               WHEN "s_detail2"
                  NEXT FIELD mhbiacti
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               WHEN "s_detail1_aooi350_01"
                  NEXT FIELD oofbstus
               WHEN "s_detail1_aooi350_02"
                  NEXT FIELD oofcstus
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amht401_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   SELECT ooff013 INTO g_mhbg_m.ooff013 FROM ooff_t
    WHERE ooffent = g_enterprise 
      AND ooff001 = '2'
      AND ooff002 = g_mhbg_m.mhbgdocno 
      AND ooff012 = '4'
   DISPLAY BY NAME g_mhbg_m.ooff013
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL amht401_b_fill() #單身填充
      CALL amht401_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amht401_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL amht401_mhbg029_ref()
   
   CALL s_desc_get_invoice_type_desc1(g_site,g_mhbg_m.mhbg031) RETURNING g_mhbg_m.mhbg031_desc
   DISPLAY BY NAME g_mhbg_m.mhbg031_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbgdocno
   LET g_ref_fields[2] = g_mhbg_m.mhbg001
   CALL ap_ref_array2(g_ref_fields," SELECT mhbgl003,mhbgl004,mhbgl005 FROM mhbgl_t WHERE mhbglent = '"||g_enterprise||"' AND mhbgldocno = ? AND mhbgl001 = ? AND mhbgl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_mhbg_m.mhbgl003 = g_rtn_fields[1] 
   LET g_mhbg_m.mhbgl004 = g_rtn_fields[2] 
   LET g_mhbg_m.mhbgl005 = g_rtn_fields[3] 
   DISPLAY g_mhbg_m.mhbgl003,g_mhbg_m.mhbgl004,g_mhbg_m.mhbgl005 TO mhbgl003,mhbgl004,mhbgl005
   #end add-point
   
   #遮罩相關處理
   LET g_mhbg_m_mask_o.* =  g_mhbg_m.*
   CALL amht401_mhbg_t_mask()
   LET g_mhbg_m_mask_n.* =  g_mhbg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mhbg_m.mhbgsite,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbgdocdt,g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034, 
       g_mhbg_m.mhbg001,g_mhbg_m.mhbgl003,g_mhbg_m.mhbg039,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbgl004,g_mhbg_m.mhbgl005, 
       g_mhbg_m.mhbg018,g_mhbg_m.mhbg000,g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg003_desc, 
       g_mhbg_m.mhbg004,g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg011, 
       g_mhbg_m.mhbg014,g_mhbg_m.mhbg014_desc,g_mhbg_m.mhbg015,g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028, 
       g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg029,g_mhbg_m.mhbg029_desc,g_mhbg_m.mhbg030,g_mhbg_m.mhbg031, 
       g_mhbg_m.mhbg031_desc,g_mhbg_m.mhbg032,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033,g_mhbg_m.mhbg033_desc, 
       g_mhbg_m.ooff013,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp,g_mhbg_m.mhbgowndp_desc, 
       g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdp_desc,g_mhbg_m.mhbgcrtdt, 
       g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgmoddt,g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfid_desc, 
       g_mhbg_m.mhbgcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mhbg_m.mhbgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "F"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/released.png")
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
   FOR l_ac = 1 TO g_mhbh_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mhbh2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL amht401_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amht401.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION amht401_detail_show()
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
 
{<section id="amht401.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amht401_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mhbg_t.mhbgdocno 
   DEFINE l_oldno     LIKE mhbg_t.mhbgdocno 
 
   DEFINE l_master    RECORD LIKE mhbg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mhbh_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mhbi_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success   LIKE type_t.num5
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
   
   IF g_mhbg_m.mhbgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mhbgdocno_t = g_mhbg_m.mhbgdocno
 
    
   LET g_mhbg_m.mhbgdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mhbg_m.mhbgownid = g_user
      LET g_mhbg_m.mhbgowndp = g_dept
      LET g_mhbg_m.mhbgcrtid = g_user
      LET g_mhbg_m.mhbgcrtdp = g_dept 
      LET g_mhbg_m.mhbgcrtdt = cl_get_current()
      LET g_mhbg_m.mhbgmodid = g_user
      LET g_mhbg_m.mhbgmoddt = cl_get_current()
      LET g_mhbg_m.mhbgstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_mhbg_m.mhbg037 = ''
   #預設單據別
   CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
      RETURNING l_success,g_mhbg_m.mhbgdocno
   CALL g_mhbh_d.clear()
   CALL aooi350_01_clear_detail()   #清空聯絡地址頁籤
   CALL aooi350_02_clear_detail()   #清空通訊方式頁籤
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mhbg_m.mhbgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "F"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/released.png")
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
   
   
   CALL amht401_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mhbg_m.* TO NULL
      INITIALIZE g_mhbh_d TO NULL
      INITIALIZE g_mhbh2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL amht401_show()
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
   CALL amht401_set_act_visible()   
   CALL amht401_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mhbgdocno_t = g_mhbg_m.mhbgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mhbgent = " ||g_enterprise|| " AND",
                      " mhbgdocno = '", g_mhbg_m.mhbgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amht401_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL amht401_idx_chk()
   
   LET g_data_owner = g_mhbg_m.mhbgownid      
   LET g_data_dept  = g_mhbg_m.mhbgowndp
   
   #功能已完成,通報訊息中心
   CALL amht401_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amht401_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mhbh_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mhbi_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amht401_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mhbh_t
    WHERE mhbhent = g_enterprise AND mhbhdocno = g_mhbgdocno_t
 
    INTO TEMP amht401_detail
 
   #將key修正為調整後   
   UPDATE amht401_detail 
      #更新key欄位
      SET mhbhdocno = g_mhbg_m.mhbgdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mhbh_t SELECT * FROM amht401_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   DELETE FROM mhbh_t WHERE mhbhent = g_enterprise AND mhbhdocno = g_mhbg_m.mhbgdocno
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amht401_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mhbi_t 
    WHERE mhbient = g_enterprise AND mhbidocno = g_mhbgdocno_t
 
    INTO TEMP amht401_detail
 
   #將key修正為調整後   
   UPDATE amht401_detail SET mhbidocno = g_mhbg_m.mhbgdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mhbi_t SELECT * FROM amht401_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amht401_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mhbgdocno_t = g_mhbg_m.mhbgdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="amht401.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amht401_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_success        LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_mhbg_m.mhbgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.mhbgldocno = g_mhbg_m.mhbgdocno
LET g_master_multi_table_t.mhbgl001 = g_mhbg_m.mhbg001
LET g_master_multi_table_t.mhbgl003 = g_mhbg_m.mhbgl003
LET g_master_multi_table_t.mhbgl004 = g_mhbg_m.mhbgl004
LET g_master_multi_table_t.mhbgl005 = g_mhbg_m.mhbgl005
 
   
   CALL s_transaction_begin()
 
   OPEN amht401_cl USING g_enterprise,g_mhbg_m.mhbgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht401_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amht401_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amht401_master_referesh USING g_mhbg_m.mhbgdocno INTO g_mhbg_m.mhbgsite,g_mhbg_m.mhbgdocdt, 
       g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034,g_mhbg_m.mhbg001,g_mhbg_m.mhbg039,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000, 
       g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg015,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg029, 
       g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg032,g_mhbg_m.mhbg033,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgowndp, 
       g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdt,g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt, 
       g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfdt,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbg003_desc, 
       g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg014_desc, 
       g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033_desc, 
       g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp_desc,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp_desc, 
       g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT amht401_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mhbg_m_mask_o.* =  g_mhbg_m.*
   CALL amht401_mhbg_t_mask()
   LET g_mhbg_m_mask_n.* =  g_mhbg_m.*
   
   CALL amht401_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amht401_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mhbgdocno_t = g_mhbg_m.mhbgdocno
 
 
      DELETE FROM mhbg_t
       WHERE mhbgent = g_enterprise AND mhbgdocno = g_mhbg_m.mhbgdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mhbg_m.mhbgdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_mhbg_m.mhbgdocno,g_mhbg_m.mhbgdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM mhbgl_t
       WHERE mhbglent = g_enterprise AND mhbgldocno = g_mhbg_m.mhbgdocno
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del mhbgl_t'
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF   
      
      #刪除ooff_t備註
      LET l_success = ''
      CALL s_aooi360_del('2',g_mhbg_m.mhbgdocno,'','','','','','','','','','4') RETURNING l_success
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooff_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #刪除聯絡地址,通訊資料
      IF NOT cl_null(g_mhbg_m.mhbg037) THEN
         IF NOT s_aooi350_del(g_mhbg_m.mhbg037) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "del oofa_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
      
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF 
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mhbh_t
       WHERE mhbhent = g_enterprise AND mhbhdocno = g_mhbg_m.mhbgdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhbh_t:",SQLERRMESSAGE 
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
      DELETE FROM mhbi_t
       WHERE mhbient = g_enterprise AND
             mhbidocno = g_mhbg_m.mhbgdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhbi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mhbg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE amht401_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mhbh_d.clear() 
      CALL g_mhbh2_d.clear()       
 
     
      CALL amht401_ui_browser_refresh()  
      #CALL amht401_ui_headershow()  
      #CALL amht401_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'mhbglent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.mhbgldocno
   LET l_field_keys[02] = 'mhbgldocno'
   LET l_var_keys_bak[03] = g_master_multi_table_t.mhbgl001
   LET l_field_keys[03] = 'mhbgl001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhbgl_t')
 
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL amht401_browser_fill("")
         CALL amht401_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE amht401_cl
 
   #功能已完成,通報訊息中心
   CALL amht401_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amht401.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amht401_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mhbh_d.clear()
   CALL g_mhbh2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   INITIALIZE g_pmaa027_d TO NULL
   CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()
   #end add-point
   
   #判斷是否填充
   IF amht401_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mhbh001,mhbhacti,mhbh002,mhbh003,mhbh004,mhbh007,mhbh008 ,t1.oocql004 FROM mhbh_t", 
                
                     " INNER JOIN mhbg_t ON mhbgent = " ||g_enterprise|| " AND mhbgdocno = mhbhdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2036' AND t1.oocql002=mhbh002 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE mhbhent=? AND mhbhdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mhbh_t.mhbh002,mhbh_t.mhbh003"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amht401_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amht401_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mhbg_m.mhbgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mhbg_m.mhbgdocno INTO g_mhbh_d[l_ac].mhbh001,g_mhbh_d[l_ac].mhbhacti, 
          g_mhbh_d[l_ac].mhbh002,g_mhbh_d[l_ac].mhbh003,g_mhbh_d[l_ac].mhbh004,g_mhbh_d[l_ac].mhbh007, 
          g_mhbh_d[l_ac].mhbh008,g_mhbh_d[l_ac].mhbh002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
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
   IF amht401_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mhbiacti,mhbi001,mhbi002,mhbi003 ,t2.rtaxl003 ,t3.oocql004 FROM mhbi_t", 
                
                     " INNER JOIN  mhbg_t ON mhbgent = " ||g_enterprise|| " AND mhbgdocno = mhbidocno ",
 
                     "",
                     
                                    " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent="||g_enterprise||" AND t2.rtaxl001=mhbi002 AND t2.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2002' AND t3.oocql002=mhbi003 AND t3.oocql003='"||g_dlang||"' ",
 
                     " WHERE mhbient=? AND mhbidocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mhbi_t.mhbi002,mhbi_t.mhbi003"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amht401_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR amht401_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_mhbg_m.mhbgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_mhbg_m.mhbgdocno INTO g_mhbh2_d[l_ac].mhbiacti,g_mhbh2_d[l_ac].mhbi001, 
          g_mhbh2_d[l_ac].mhbi002,g_mhbh2_d[l_ac].mhbi003,g_mhbh2_d[l_ac].mhbi002_desc,g_mhbh2_d[l_ac].mhbi003_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
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
   IF NOT cl_null(g_mhbg_m.mhbg037) THEN
      LET g_pmaa027_d = g_mhbg_m.mhbg037
      CALL aooi350_01_b_fill(g_pmaa027_d)
      CALL aooi350_02_b_fill(g_pmaa027_d)
   END IF  
   #end add-point
   
   CALL g_mhbh_d.deleteElement(g_mhbh_d.getLength())
   CALL g_mhbh2_d.deleteElement(g_mhbh2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE amht401_pb
   FREE amht401_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mhbh_d.getLength()
      LET g_mhbh_d_mask_o[l_ac].* =  g_mhbh_d[l_ac].*
      CALL amht401_mhbh_t_mask()
      LET g_mhbh_d_mask_n[l_ac].* =  g_mhbh_d[l_ac].*
   END FOR
   
   LET g_mhbh2_d_mask_o.* =  g_mhbh2_d.*
   FOR l_ac = 1 TO g_mhbh2_d.getLength()
      LET g_mhbh2_d_mask_o[l_ac].* =  g_mhbh2_d[l_ac].*
      CALL amht401_mhbi_t_mask()
      LET g_mhbh2_d_mask_n[l_ac].* =  g_mhbh2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amht401_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mhbh_t
       WHERE mhbhent = g_enterprise AND
         mhbhdocno = ps_keys_bak[1] AND mhbh002 = ps_keys_bak[2] AND mhbh003 = ps_keys_bak[3]
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
         CALL g_mhbh_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM mhbi_t
       WHERE mhbient = g_enterprise AND
             mhbidocno = ps_keys_bak[1] AND mhbi002 = ps_keys_bak[2] AND mhbi003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhbi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mhbh2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amht401.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amht401_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mhbh_t
                  (mhbhent,
                   mhbhdocno,
                   mhbh002,mhbh003
                   ,mhbh001,mhbhacti,mhbh004,mhbh007,mhbh008) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mhbh_d[g_detail_idx].mhbh001,g_mhbh_d[g_detail_idx].mhbhacti,g_mhbh_d[g_detail_idx].mhbh004, 
                       g_mhbh_d[g_detail_idx].mhbh007,g_mhbh_d[g_detail_idx].mhbh008)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhbh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mhbh_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO mhbi_t
                  (mhbient,
                   mhbidocno,
                   mhbi002,mhbi003
                   ,mhbiacti,mhbi001) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mhbh2_d[g_detail_idx].mhbiacti,g_mhbh2_d[g_detail_idx].mhbi001)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhbi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mhbh2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="amht401.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amht401_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mhbh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL amht401_mhbh_t_mask_restore('restore_mask_o')
               
      UPDATE mhbh_t 
         SET (mhbhdocno,
              mhbh002,mhbh003
              ,mhbh001,mhbhacti,mhbh004,mhbh007,mhbh008) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mhbh_d[g_detail_idx].mhbh001,g_mhbh_d[g_detail_idx].mhbhacti,g_mhbh_d[g_detail_idx].mhbh004, 
                  g_mhbh_d[g_detail_idx].mhbh007,g_mhbh_d[g_detail_idx].mhbh008) 
         WHERE mhbhent = g_enterprise AND mhbhdocno = ps_keys_bak[1] AND mhbh002 = ps_keys_bak[2] AND mhbh003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amht401_mhbh_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mhbi_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL amht401_mhbi_t_mask_restore('restore_mask_o')
               
      UPDATE mhbi_t 
         SET (mhbidocno,
              mhbi002,mhbi003
              ,mhbiacti,mhbi001) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mhbh2_d[g_detail_idx].mhbiacti,g_mhbh2_d[g_detail_idx].mhbi001) 
         WHERE mhbient = g_enterprise AND mhbidocno = ps_keys_bak[1] AND mhbi002 = ps_keys_bak[2] AND mhbi003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbi_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbi_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amht401_mhbi_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amht401.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION amht401_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="amht401.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amht401_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amht401.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amht401_lock_b(ps_table,ps_page)
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
   #CALL amht401_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mhbh_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN amht401_bcl USING g_enterprise,
                                       g_mhbg_m.mhbgdocno,g_mhbh_d[g_detail_idx].mhbh002,g_mhbh_d[g_detail_idx].mhbh003  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amht401_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "mhbi_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amht401_bcl2 USING g_enterprise,
                                             g_mhbg_m.mhbgdocno,g_mhbh2_d[g_detail_idx].mhbi002,g_mhbh2_d[g_detail_idx].mhbi003 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amht401_bcl2:",SQLERRMESSAGE 
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
 
{<section id="amht401.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amht401_unlock_b(ps_table,ps_page)
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
      CLOSE amht401_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE amht401_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amht401_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mhbgdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mhbgdocno",TRUE)
      CALL cl_set_comp_entry("mhbgdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mhbg003",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   IF g_argv[1] <> '2' THEN
     CALL cl_set_comp_required('mhbg030',TRUE)
   END IF
   CALL cl_set_comp_required('mhbg039',TRUE)

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amht401_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mhbgdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mhbgdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mhbgdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_mhbg_m.mhbg002 != '3' THEN
      CALL cl_set_comp_entry("mhbg003",FALSE)
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'mhbgsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("mhbgsite",FALSE)
   END IF
   #CALL cl_set_comp_entry("mhbg001",FALSE) #mark by geza 20160628
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amht401_set_entry_b(p_cmd)
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
 
{<section id="amht401.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amht401_set_no_entry_b(p_cmd)
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
 
{<section id="amht401.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amht401_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht401.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amht401_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_mhbg_m.mhbgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF



   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht401.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amht401_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   #應用 a63 樣板自動產生(Version:2)
   IF g_mhbg_m.mhbgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF



   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht401.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amht401_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht401.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amht401_default_search()
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
      LET ls_wc = ls_wc, " mhbgdocno = '", g_argv[01], "' AND "
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
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "mhbg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mhbh_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mhbi_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
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
   IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) THEN
      CASE g_argv[1]
         WHEN '1'
            LET ls_wc = ls_wc," AND mhbg000 = 'amht401' AND "
            LET g_wc = g_wc," AND mhbg000 = 'amht401' "
         WHEN '2'
            LET ls_wc = ls_wc," AND mhbg000 = 'amht402' AND "
            LET g_wc = g_wc," AND mhbg000 = 'amht401' "
         OTHERWISE
            LET ls_wc = ''
            LET g_wc = " 1=1"  
      END CASE
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION amht401_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   #作廢或發出後,不得修改狀態
   IF g_mhbg_m.mhbgstus = 'X' OR g_mhbg_m.mhbgstus = 'F' THEN
      RETURN
   END IF
   #amht402 狀態:已確認，不得修改狀態
   IF g_argv[1] = '2' AND g_mhbg_m.mhbgstus = 'Y' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mhbg_m.mhbgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN amht401_cl USING g_enterprise,g_mhbg_m.mhbgdocno
   IF STATUS THEN
      CLOSE amht401_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht401_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE amht401_master_referesh USING g_mhbg_m.mhbgdocno INTO g_mhbg_m.mhbgsite,g_mhbg_m.mhbgdocdt, 
       g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034,g_mhbg_m.mhbg001,g_mhbg_m.mhbg039,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000, 
       g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg015,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg029, 
       g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg032,g_mhbg_m.mhbg033,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgowndp, 
       g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdt,g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt, 
       g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfdt,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbg003_desc, 
       g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg014_desc, 
       g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033_desc, 
       g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp_desc,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp_desc, 
       g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT amht401_action_chk() THEN
      CLOSE amht401_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mhbg_m.mhbgsite,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbgdocdt,g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034, 
       g_mhbg_m.mhbg001,g_mhbg_m.mhbgl003,g_mhbg_m.mhbg039,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbgl004,g_mhbg_m.mhbgl005, 
       g_mhbg_m.mhbg018,g_mhbg_m.mhbg000,g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg003_desc, 
       g_mhbg_m.mhbg004,g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg006, 
       g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
       g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg011, 
       g_mhbg_m.mhbg014,g_mhbg_m.mhbg014_desc,g_mhbg_m.mhbg015,g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg016, 
       g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028, 
       g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg029,g_mhbg_m.mhbg029_desc,g_mhbg_m.mhbg030,g_mhbg_m.mhbg031, 
       g_mhbg_m.mhbg031_desc,g_mhbg_m.mhbg032,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033,g_mhbg_m.mhbg033_desc, 
       g_mhbg_m.ooff013,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp,g_mhbg_m.mhbgowndp_desc, 
       g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdp_desc,g_mhbg_m.mhbgcrtdt, 
       g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgmoddt,g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfid_desc, 
       g_mhbg_m.mhbgcnfdt
 
   CASE g_mhbg_m.mhbgstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "F"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/released.png")
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
         CASE g_mhbg_m.mhbgstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "F"
               HIDE OPTION "released"
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
      #open皆改為unconfirmed
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw,released",FALSE)

      CASE g_mhbg_m.mhbgstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)

        #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT amht401_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amht401_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT amht401_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amht401_cl
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
      ON ACTION released
         IF cl_auth_chk_act("released") THEN
            LET lc_state = "F"
            #add-point:action控制 name="statechange.released"
            
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
      AND lc_state <> "F"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_mhbg_m.mhbgstus = lc_state OR cl_null(lc_state) THEN
      CLOSE amht401_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_err_collect_init()
   LET l_success = TRUE
   
   #潛在商戶amht402審核時,寫至交易對象主檔pmaa_t
   IF g_argv[1] = '2' AND lc_state = 'Y' THEN
      CALL s_amht401_conf_chk(g_mhbg_m.mhbgdocno) RETURNING l_success
      IF l_success THEN
            IF cl_ask_confirm('apm-00348') THEN
               CALL s_transaction_begin()
               CALL s_amht401_conf_upd(g_mhbg_m.mhbgdocno) RETURNING l_success
               IF NOT l_success THEN 
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  #s_amht401_conf_upd 後,若審核,將預登記單號回寫為F
                  UPDATE mhbg_t 
                     SET (mhbgstus,mhbgmodid,mhbgmoddt)
                       = ('F',g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt)
                   WHERE mhbgent = g_enterprise AND mhbgdocno = g_mhbg_m.mhbg034 AND mhbgstus = 'Y'
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "update mhbgstus='F'" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                  END IF
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
               RETURN
            END IF
      ELSE
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
         RETURN
      END IF
      
   END IF
   #若取消審核,將預登記單號改為Y
   IF g_argv[1] = '2' AND lc_state = 'N' THEN
      UPDATE mhbg_t 
         SET (mhbgstus,mhbgmodid,mhbgmoddt)
           = ('Y',g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt)
       WHERE mhbgent = g_enterprise AND mhbgdocno = g_mhbg_m.mhbg034 AND mhbgstus = 'F'
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "update mhbgstus='Y'" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = FALSE 
          CALL cl_err()
       END IF
   END IF
   
   IF g_argv[1] = '1' THEN
      LET g_mhbg_m.mhbgcnfid = g_user
      LET g_mhbg_m.mhbgcnfdt = cl_get_current()
      UPDATE mhbg_t 
         SET (mhbgcnfid,mhbgcnfdt) 
           = (g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfdt)     
       WHERE mhbgent = g_enterprise AND mhbgdocno = g_mhbg_m.mhbgdocno
      
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
   END IF
   #end add-point
   
   LET g_mhbg_m.mhbgmodid = g_user
   LET g_mhbg_m.mhbgmoddt = cl_get_current()
   LET g_mhbg_m.mhbgstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mhbg_t 
      SET (mhbgstus,mhbgmodid,mhbgmoddt) 
        = (g_mhbg_m.mhbgstus,g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt)     
    WHERE mhbgent = g_enterprise AND mhbgdocno = g_mhbg_m.mhbgdocno
 
    
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
         WHEN "F"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/released.png")
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
      EXECUTE amht401_master_referesh USING g_mhbg_m.mhbgdocno INTO g_mhbg_m.mhbgsite,g_mhbg_m.mhbgdocdt, 
          g_mhbg_m.mhbgdocno,g_mhbg_m.mhbg034,g_mhbg_m.mhbg001,g_mhbg_m.mhbg039,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000, 
          g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002,g_mhbg_m.mhbg003,g_mhbg_m.mhbg004,g_mhbg_m.mhbg005,g_mhbg_m.mhbg006, 
          g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007,g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010, 
          g_mhbg_m.mhbg012,g_mhbg_m.mhbg013,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg015,g_mhbg_m.mhbg016, 
          g_mhbg_m.mhbg036,g_mhbg_m.mhbg017,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg029, 
          g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg032,g_mhbg_m.mhbg033,g_mhbg_m.mhbgownid,g_mhbg_m.mhbgowndp, 
          g_mhbg_m.mhbgcrtid,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdt,g_mhbg_m.mhbgmodid,g_mhbg_m.mhbgmoddt, 
          g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfdt,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbg039_desc,g_mhbg_m.mhbg003_desc, 
          g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg014_desc, 
          g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg028_desc,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033_desc, 
          g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp_desc,g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp_desc, 
          g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mhbg_m.mhbgsite,g_mhbg_m.mhbgsite_desc,g_mhbg_m.mhbgdocdt,g_mhbg_m.mhbgdocno, 
          g_mhbg_m.mhbg034,g_mhbg_m.mhbg001,g_mhbg_m.mhbgl003,g_mhbg_m.mhbg039,g_mhbg_m.mhbg039_desc, 
          g_mhbg_m.mhbgl004,g_mhbg_m.mhbgl005,g_mhbg_m.mhbg018,g_mhbg_m.mhbg000,g_mhbg_m.mhbgstus,g_mhbg_m.mhbg002, 
          g_mhbg_m.mhbg003,g_mhbg_m.mhbg003_desc,g_mhbg_m.mhbg004,g_mhbg_m.mhbg004_desc,g_mhbg_m.mhbg005, 
          g_mhbg_m.mhbg005_desc,g_mhbg_m.mhbg006,g_mhbg_m.mhbg035,g_mhbg_m.mhbg008,g_mhbg_m.mhbg007, 
          g_mhbg_m.mhbg038,g_mhbg_m.mhbg009,g_mhbg_m.mhbg010,g_mhbg_m.mhbg010_desc,g_mhbg_m.mhbg012, 
          g_mhbg_m.mhbg013,g_mhbg_m.mhbg013_desc,g_mhbg_m.mhbg011,g_mhbg_m.mhbg014,g_mhbg_m.mhbg014_desc, 
          g_mhbg_m.mhbg015,g_mhbg_m.mhbg015_desc,g_mhbg_m.mhbg016,g_mhbg_m.mhbg036,g_mhbg_m.mhbg017, 
          g_mhbg_m.mhbg017_desc,g_mhbg_m.mhbg020,g_mhbg_m.mhbg037,g_mhbg_m.mhbg028,g_mhbg_m.mhbg028_desc, 
          g_mhbg_m.mhbg029,g_mhbg_m.mhbg029_desc,g_mhbg_m.mhbg030,g_mhbg_m.mhbg031,g_mhbg_m.mhbg031_desc, 
          g_mhbg_m.mhbg032,g_mhbg_m.mhbg032_desc,g_mhbg_m.mhbg033,g_mhbg_m.mhbg033_desc,g_mhbg_m.ooff013, 
          g_mhbg_m.mhbgownid,g_mhbg_m.mhbgownid_desc,g_mhbg_m.mhbgowndp,g_mhbg_m.mhbgowndp_desc,g_mhbg_m.mhbgcrtid, 
          g_mhbg_m.mhbgcrtid_desc,g_mhbg_m.mhbgcrtdp,g_mhbg_m.mhbgcrtdp_desc,g_mhbg_m.mhbgcrtdt,g_mhbg_m.mhbgmodid, 
          g_mhbg_m.mhbgmodid_desc,g_mhbg_m.mhbgmoddt,g_mhbg_m.mhbgcnfid,g_mhbg_m.mhbgcnfid_desc,g_mhbg_m.mhbgcnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE amht401_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amht401_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amht401.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amht401_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mhbh_d.getLength() THEN
         LET g_detail_idx = g_mhbh_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mhbh_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mhbh_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mhbh2_d.getLength() THEN
         LET g_detail_idx = g_mhbh2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mhbh2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mhbh2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amht401.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amht401_b_fill2(pi_idx)
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
   
   CALL amht401_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="amht401.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amht401_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amht401.status_show" >}
PRIVATE FUNCTION amht401_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amht401.mask_functions" >}
&include "erp/amh/amht401_mask.4gl"
 
{</section>}
 
{<section id="amht401.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION amht401_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL amht401_show()
   CALL amht401_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mhbg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mhbh_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_mhbh2_d))
 
 
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
   #CALL amht401_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL amht401_ui_headershow()
   CALL amht401_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION amht401_draw_out()
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
   CALL amht401_ui_headershow()  
   CALL amht401_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="amht401.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amht401_set_pk_array()
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
   LET g_pk_array[1].values = g_mhbg_m.mhbgdocno
   LET g_pk_array[1].column = 'mhbgdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amht401.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="amht401.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amht401_msgcentre_notify(lc_state)
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
   CALL amht401_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mhbg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amht401.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION amht401_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#20 add-S
   SELECT mhbgstus  INTO g_mhbg_m.mhbgstus
     FROM mhbg_t
    WHERE mhbgent = g_enterprise
      AND mhbgdocno = g_mhbg_m.mhbgdocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mhbg_m.mhbgstus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'F'
           LET g_errno = 'sub-01343'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_mhbg_m.mhbgdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amht401_set_act_visible()
        CALL amht401_set_act_no_visible()
        CALL amht401_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#20 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amht401.other_function" readonly="Y" >}

PRIVATE FUNCTION amht401_mhbgsite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbgsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbgsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbgsite_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbg003
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg003_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbg004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='261' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg004_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbg005
   CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg005_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg010_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbg010
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg010_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg013_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbg013
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg013_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg014_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbg014
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='254' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg014_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg015_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbg015
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='260' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg015_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg015_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg017_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbg017
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='250' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg017_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg028_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbg028
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg028_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg029_ref()
   DEFINE l_ooef019   LIKE ooef_t.ooef019

   INITIALIZE g_ref_fields TO NULL
   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooef001 = g_site
      AND ooefent = g_enterprise
   IF NOT cl_null(l_ooef019) THEN
      LET g_ref_fields[1] = l_ooef019
      LET g_ref_fields[2] = g_mhbg_m.mhbg029
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_mhbg_m.mhbg029_desc = '', g_rtn_fields[1] , ''
   END IF
   DISPLAY BY NAME g_mhbg_m.mhbg029_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg032_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = '3211'
   LET g_ref_fields[2] = g_mhbg_m.mhbg032
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg032_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg032_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbg033_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = '3111'
   LET g_ref_fields[2] = g_mhbg_m.mhbg033
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg033_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg033_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbh002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbh_d[l_ac].mhbh002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2036' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbh_d[l_ac].mhbh002_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_mhbh_d[l_ac].mhbh002_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbh004_default()
   LET g_mhbh_d[l_ac].mhbh004 = g_mhbh_d[l_ac].mhbh002_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbi002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbh2_d[l_ac].mhbi002
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbh2_d[l_ac].mhbi002_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_mhbh2_d[l_ac].mhbi002_desc
END FUNCTION

PRIVATE FUNCTION amht401_mhbi003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbh2_d[l_ac].mhbi003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbh2_d[l_ac].mhbi003_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_mhbh2_d[l_ac].mhbi003_desc
END FUNCTION

PRIVATE FUNCTION amht401_set_comp_visible()
   IF g_argv[1] = '1' THEN
      CALL cl_set_comp_visible('lbl_mhbg034,mhbg034',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 帶出單頭資料
# Memo...........:
# Usage..........: CALL amht401_carry()
# Input parameter: 
# Return code....: 
# Date & Author..: 20160310 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION amht401_carry()
   LET g_mhbg037 = ''
   SELECT mhbg001,mhbgl003,mhbgl004,mhbgl005,mhbg018,
          mhbg002,mhbg003,mhbg004,mhbg005,mhbg006,
          mhbg035,mhbg008,mhbg007,mhbg009,mhbg010,
          mhbg012,mhbg013,mhbg011,mhbg014,mhbg015,
          mhbg016,mhbg036,mhbg017,mhbg020,mhbg028,
          mhbg029,mhbg030,mhbg031,mhbg032,mhbg033,
          mhbg037,ooff013
     INTO g_mhbg_m.mhbg001,g_mhbg_m.mhbgl003,g_mhbg_m.mhbgl004,g_mhbg_m.mhbgl005,g_mhbg_m.mhbg018,
          g_mhbg_m.mhbg002,g_mhbg_m.mhbg003, g_mhbg_m.mhbg004, g_mhbg_m.mhbg005, g_mhbg_m.mhbg006,
          g_mhbg_m.mhbg035,g_mhbg_m.mhbg008, g_mhbg_m.mhbg007, g_mhbg_m.mhbg009, g_mhbg_m.mhbg010,
          g_mhbg_m.mhbg012,g_mhbg_m.mhbg013, g_mhbg_m.mhbg011, g_mhbg_m.mhbg014, g_mhbg_m.mhbg015,
          g_mhbg_m.mhbg016,g_mhbg_m.mhbg036, g_mhbg_m.mhbg017, g_mhbg_m.mhbg020, g_mhbg_m.mhbg028,
          g_mhbg_m.mhbg029,g_mhbg_m.mhbg030, g_mhbg_m.mhbg031, g_mhbg_m.mhbg032, g_mhbg_m.mhbg033,
          g_mhbg037,g_mhbg_m.ooff013
     FROM mhbg_t 
          LEFT JOIN mhbgl_t ON mhbglent = mhbgent AND mhbgldocno = mhbgdocno 
                           AND mhbgl001 = mhbg001 AND mhbgl002 = g_dlang
          LEFT JOIN ooff_t ON ooffent = mhbgent AND ooff001 = '2' AND ooff002 = mhbgdocno AND ooff012 = '4'
    WHERE mhbgent = g_enterprise AND mhbgdocno = g_mhbg_m.mhbg034 AND mhbg000 = 'amht401'
    
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "amht401_carry:" 
       LET g_errparam.code   = SQLCA.sqlcode 
       LET g_errparam.popup  = TRUE 
       CALL cl_err()
    END IF
END FUNCTION

################################################################################
# Descriptions...: 帶出單身資料
# Memo...........:
# Usage..........: CALL amht401_carry_b()
# Input parameter: 
# Return code....: 
# Date & Author..: 20160310 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION amht401_carry_b()
   DEFINE l_cnt LIKE type_t.num5
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM oofb_t
    WHERE oofbent = g_enterprise 
      AND oofb002 = g_mhbg_m.mhbg037
   IF l_cnt = 0 THEN
      CALL amht401_carry_oofb()
   END IF
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM oofc_t
    WHERE oofcent = g_enterprise 
      AND oofc002 = g_mhbg_m.mhbg037
   IF l_cnt = 0 THEN
      CALL amht401_carry_oofc()
   END IF
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM mhbh_t
    WHERE mhbhent = g_enterprise
      AND mhbhdocno = g_mhbg_m.mhbgdocno
   IF l_cnt = 0 THEN
      CALL amht401_carry_mhbh()
   END IF   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM mhbi_t
    WHERE mhbient = g_enterprise
      AND mhbidocno = g_mhbg_m.mhbgdocno
   IF l_cnt = 0 THEN
      CALL amht401_carry_mhbi()
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 帶出預登記商戶的oofb_t
# Memo...........:
# Usage..........: CALL amht401_carry_oofb()
# Date & Author..: 20160314
# Modify.........:
################################################################################
PRIVATE FUNCTION amht401_carry_oofb()
   DEFINE l_wc        STRING
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_oofb001   LIKE oofb_t.oofb001 #潛在商戶的聯絡地址識別碼
   DEFINE l_oofb001_t LIKE oofb_t.oofb001 #潛在商戶的聯絡地址識別碼
   
   #oofb_t
   LET l_wc = " oofbent = ",g_enterprise
   DECLARE oofb_cl CURSOR FOR
    SELECT oofb001
      FROM oofb_t
     WHERE oofbent = g_enterprise
       AND oofb002 = g_mhbg037
   
   FOREACH oofb_cl INTO l_oofb001_t
                                                      
      LET l_wc = " oofbent = ",g_enterprise
      CALL s_aooi350_get_idno('oofb001','oofb_t',l_wc)
         RETURNING l_success,l_oofb001
      
      DISPLAY "g_mhbg_m.mhbg037:",g_mhbg_m.mhbg037
      DISPLAY "g_mhbg037:",g_mhbg037
      DISPLAY "l_oofb001:",l_oofb001
      
      INSERT INTO oofb_t (oofbstus ,oofbent  ,oofb001  ,oofb002  ,oofb003  ,
                          oofb004  ,oofb005  ,oofb006  ,oofb007  ,oofb008  ,
                          oofb009  ,oofb010  ,oofb011  ,oofb012  ,oofb013  ,
                          oofb014  ,oofb015  ,oofb016  ,oofb017  ,oofb018  ,
                          oofbownid,oofbowndp,oofbcrtid,oofbcrtdp,
                          oofbcrtdt,oofbmodid,oofbmoddt,oofb019  ,
                          oofb020  ,oofb021  ,oofb022  ,oofbud001,oofbud002,
                          oofbud003,oofbud004,oofbud005,oofbud006,oofbud007,
                          oofbud008,oofbud009,oofbud010,oofbud011,oofbud012,
                          oofbud013,oofbud014,oofbud015,oofbud016,oofbud017,
                          oofbud018,oofbud019,oofbud020,oofbud021,oofbud022,
                          oofbud023,oofbud024,oofbud025,oofbud026,oofbud027,
                          oofbud028,oofbud029,oofbud030,oofb023)
      SELECT t2.oofbstus ,t2.oofbent  ,l_oofb001   ,g_mhbg_m.mhbg037,t2.oofb003  ,
             t2.oofb004  ,t2.oofb005  ,t2.oofb006  ,t2.oofb007      ,t2.oofb008  ,
             t2.oofb009  ,t2.oofb010  ,t2.oofb011  ,t2.oofb012      ,t2.oofb013  ,
             t2.oofb014  ,t2.oofb015  ,t2.oofb016  ,t2.oofb017      ,t2.oofb018  ,
             t2.oofbownid,t2.oofbowndp,t2.oofbcrtid,t2.oofbcrtdp    ,
             t2.oofbcrtdt,t2.oofbmodid,t2.oofbmoddt,t2.oofb019      ,
             t2.oofb020  ,t2.oofb021  ,t2.oofb022  ,t2.oofbud001    ,t2.oofbud002,
             t2.oofbud003,t2.oofbud004,t2.oofbud005,t2.oofbud006    ,t2.oofbud007,
             t2.oofbud008,t2.oofbud009,t2.oofbud010,t2.oofbud011    ,t2.oofbud012,
             t2.oofbud013,t2.oofbud014,t2.oofbud015,t2.oofbud016    ,t2.oofbud017,
             t2.oofbud018,t2.oofbud019,t2.oofbud020,t2.oofbud021    ,t2.oofbud022,
             t2.oofbud023,t2.oofbud024,t2.oofbud025,t2.oofbud026    ,t2.oofbud027,
             t2.oofbud028,t2.oofbud029,t2.oofbud030,t2.oofb023
        FROM oofb_t t2
       WHERE t2.oofbent = g_enterprise AND t2.oofb001 = l_oofb001_t  AND t2.oofb002 = g_mhbg037
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amht401_carry_oofb:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 帶出預登記商戶的oofc_t
# Memo...........:
# Usage..........: CALL amht401_carry_oofc()
# Date & Author..: 20160314
# Modify.........:
################################################################################
PRIVATE FUNCTION amht401_carry_oofc()
   DEFINE l_wc        STRING
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_oofc001   LIKE oofc_t.oofc001 #潛在商戶的通訊方式識別碼
   DEFINE l_oofc001_t LIKE oofc_t.oofc001 #潛在商戶的通訊方式識別碼
   #oofc_t
   LET l_wc = " oofcent = ",g_enterprise
   DECLARE oofc_cl CURSOR FOR
    SELECT oofc001
      FROM oofc_t
     WHERE oofcent = g_enterprise
       AND oofc002 = g_mhbg037
 
   FOREACH oofc_cl INTO l_oofc001_t
                                                      
      LET l_wc = " oofcent = ",g_enterprise
      CALL s_aooi350_get_idno('oofc001','oofc_t',l_wc)
         RETURNING l_success,l_oofc001
      
      DISPLAY "g_mhbg_m.mhbg037:",g_mhbg_m.mhbg037
      DISPLAY "g_mhbg037:",g_mhbg037
      DISPLAY "l_oofc001:",l_oofc001
      
      INSERT INTO oofc_t (oofcstus ,oofcent  ,oofc001  ,oofc002  ,oofc003  ,
                          oofc004  ,oofc005  ,oofc006  ,oofc007  ,oofc008  ,
                          oofc009  ,oofc010  ,oofc011  ,oofc012  ,oofc013  ,
                          oofcownid,oofcowndp,oofccrtid,oofccrtdp,oofccrtdt,
                          oofcmodid,oofcmoddt,oofc014  ,oofcud001,oofcud002,
                          oofcud003,oofcud004,oofcud005,oofcud006,oofcud007,
                          oofcud008,oofcud009,oofcud010,oofcud011,oofcud012,
                          oofcud013,oofcud014,oofcud015,oofcud016,oofcud017,
                          oofcud018,oofcud019,oofcud020,oofcud021,oofcud022,
                          oofcud023,oofcud024,oofcud025,oofcud026,oofcud027,
                          oofcud028,oofcud029,oofcud030,oofc015  ,oofc016)
      SELECT t2.oofcstus ,t2.oofcent  ,l_oofc001   ,g_mhbg_m.mhbg037,t2.oofc003  ,
             t2.oofc004  ,t2.oofc005  ,t2.oofc006  ,t2.oofc007      ,t2.oofc008  ,
             t2.oofc009  ,t2.oofc010  ,t2.oofc011  ,t2.oofc012      ,t2.oofc013  ,
             t2.oofcownid,t2.oofcowndp,t2.oofccrtid,t2.oofccrtdp    ,t2.oofccrtdt,
             t2.oofcmodid,t2.oofcmoddt,t2.oofc014  ,t2.oofcud001    ,t2.oofcud002,
             t2.oofcud003,t2.oofcud004,t2.oofcud005,t2.oofcud006    ,t2.oofcud007,
             t2.oofcud008,t2.oofcud009,t2.oofcud010,t2.oofcud011    ,t2.oofcud012,
             t2.oofcud013,t2.oofcud014,t2.oofcud015,t2.oofcud016    ,t2.oofcud017,
             t2.oofcud018,t2.oofcud019,t2.oofcud020,t2.oofcud021    ,t2.oofcud022,
             t2.oofcud023,t2.oofcud024,t2.oofcud025,t2.oofcud026    ,t2.oofcud027,
             t2.oofcud028,t2.oofcud029,t2.oofcud030,t2.oofc015      ,t2.oofc016
        FROM oofc_t t2
       WHERE t2.oofcent = g_enterprise AND t2.oofc001 = l_oofc001_t  AND t2.oofc002 = g_mhbg037
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amht401_carry_oofc:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 帶出預登記商戶的mhbh_t
# Memo...........:
# Usage..........: CALL amht401_carry_mhbh()
# Date & Author..: 20160314
# Modify.........:
################################################################################
PRIVATE FUNCTION amht401_carry_mhbh()
   INSERT INTO mhbh_t (mhbhent  ,mhbhsite ,mhbhunit ,mhbhdocno,mhbh001  ,
                       mhbh002  ,mhbh003  ,mhbh004  ,mhbh005  ,mhbh006  ,
                       mhbh007  ,mhbh008  ,mhbh009  ,mhbhacti ,mhbhud001,
                       mhbhud002,mhbhud003,mhbhud004,mhbhud005,mhbhud006,
                       mhbhud007,mhbhud008,mhbhud009,mhbhud010,mhbhud011,
                       mhbhud012,mhbhud013,mhbhud014,mhbhud015,mhbhud016,
                       mhbhud017,mhbhud018,mhbhud019,mhbhud020,mhbhud021,
                       mhbhud022,mhbhud023,mhbhud024,mhbhud025,mhbhud026,
                       mhbhud027,mhbhud028,mhbhud029,mhbhud030)
   SELECT t2.mhbhent  ,t2.mhbhsite ,t2.mhbhunit ,g_mhbg_m.mhbgdocno,t2.mhbh001  ,
          t2.mhbh002  ,t2.mhbh003  ,t2.mhbh004  ,t2.mhbh005        ,t2.mhbh006  ,
          t2.mhbh007  ,t2.mhbh008  ,t2.mhbh009  ,t2.mhbhacti       ,t2.mhbhud001,
          t2.mhbhud002,t2.mhbhud003,t2.mhbhud004,t2.mhbhud005      ,t2.mhbhud006,
          t2.mhbhud007,t2.mhbhud008,t2.mhbhud009,t2.mhbhud010      ,t2.mhbhud011,
          t2.mhbhud012,t2.mhbhud013,t2.mhbhud014,t2.mhbhud015      ,t2.mhbhud016,
          t2.mhbhud017,t2.mhbhud018,t2.mhbhud019,t2.mhbhud020      ,t2.mhbhud021,
          t2.mhbhud022,t2.mhbhud023,t2.mhbhud024,t2.mhbhud025      ,t2.mhbhud026,
          t2.mhbhud027,t2.mhbhud028,t2.mhbhud029,t2.mhbhud030 
     FROM mhbh_t t2
    WHERE t2.mhbhent = g_enterprise AND t2.mhbhdocno = g_mhbg_m.mhbg034
    IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "amht401_carry_mhbh:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 帶出預登記商戶的mhbi_t
# Memo...........:
# Usage..........: CALL amht401_carry_mhbi()
# Date & Author..: 20160314 By beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION amht401_carry_mhbi()
   INSERT INTO mhbi_t (mhbient  ,mhbidocno,mhbi001  ,mhbi002  ,mhbi003  ,
                       mhbiacti ,mhbiud001,mhbiud002,mhbiud003,mhbiud004,
                       mhbiud005,mhbiud006,mhbiud007,mhbiud008,mhbiud009,
                       mhbiud010,mhbiud011,mhbiud012,mhbiud013,mhbiud014,
                       mhbiud015,mhbiud016,mhbiud017,mhbiud018,mhbiud019,
                       mhbiud020,mhbiud021,mhbiud022,mhbiud023,mhbiud024,
                       mhbiud025,mhbiud026,mhbiud027,mhbiud028,mhbiud029,
                       mhbiud030)
   SELECT t2.mhbient  ,g_mhbg_m.mhbgdocno,t2.mhbi001  ,t2.mhbi002  ,t2.mhbi003  ,
          t2.mhbiacti ,t2.mhbiud001      ,t2.mhbiud002,t2.mhbiud003,t2.mhbiud004,
          t2.mhbiud005,t2.mhbiud006      ,t2.mhbiud007,t2.mhbiud008,t2.mhbiud009,
          t2.mhbiud010,t2.mhbiud011      ,t2.mhbiud012,t2.mhbiud013,t2.mhbiud014,
          t2.mhbiud015,t2.mhbiud016      ,t2.mhbiud017,t2.mhbiud018,t2.mhbiud019,
          t2.mhbiud020,t2.mhbiud021      ,t2.mhbiud022,t2.mhbiud023,t2.mhbiud024,
          t2.mhbiud025,t2.mhbiud026      ,t2.mhbiud027,t2.mhbiud028,t2.mhbiud029,
          t2.mhbiud030
     FROM mhbi_t t2
    WHERE t2.mhbient = g_enterprise AND t2.mhbidocno = g_mhbg_m.mhbg034
    IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "amht401_carry_mhbi:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 清空單身頁籤畫面
# Memo...........:
# Usage..........: amht401_clear_detail()
# Date & Author..: 20160314 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION amht401_clear_detail()
   CALL amht401_b_fill()
   CALL g_mhbh_d.clear()
   CALL g_mhbh2_d.clear()
END FUNCTION

PRIVATE FUNCTION amht401_set_required()
   #mark by geza 20160613 #160604-00009(S)
#   IF g_argv[1] = '2' THEN
#      CALL cl_set_comp_required("mhbg028,mhbg029,mhbg031,mhbg032,mhbg033",TRUE)
#   END IF
   #mark by geza 20160613 #160604-00009(E)
END FUNCTION

PRIVATE FUNCTION amht401_set_no_required()
   CALL cl_set_comp_required("mhbg028,mhbg029,mhbg031,mhbg032,mhbg033",FALSE)
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
PRIVATE FUNCTION amht401_mhbg039_ref()
  INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbg_m.mhbg039
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='251' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbg_m.mhbg039_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbg_m.mhbg039_desc
END FUNCTION

 
{</section>}
 
