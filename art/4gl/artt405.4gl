#該程式未解開Section, 採用最新樣板產出!
{<section id="artt405.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0022(2016-06-06 16:04:23), PR版次:0022(2016-09-26 17:38:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000713
#+ Filename...: artt405
#+ Description: 自營商品引進申請作業
#+ Creator....: 06137(2015-06-17 14:33:37)
#+ Modifier...: 08172 -SD/PR- 06137
 
{</section>}
 
{<section id="artt405.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160319-00007#1   2016/03/24  By Ann_Huang    置換庫位編號錯誤訊息
#160318-00025#21  2016/04/20  BY 07900        校验代码重复错误讯息的修改
#160512-00022#3   2016/05/17  BY 07959        控制订货数量为空时，默认给0
#160604-00009#4   2016/06/06  by 08172        最小采购量/采购倍量/最小采购额修改
#160604-00009#54  2016-06-21  BY LANJJ 06540  合同开窗修改
#160623-00028#1   2016/06/24  by 08172        税区别开窗修改，生效、失效日期错误信息修改
#160816-00068#09  2016/08/17  By 08209        調整transaction
#160818-00017#35 2016-08-24 By 08734 删除修改未重新判断状态码
#160905-00007#15 2016/09/05 by 08172 调整系统中无ENT的SQL条件增加ent
#160824-00007#21 2016/09/26 By 06137 修正舊值備份寫法
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
PRIVATE type type_g_rtdu_m        RECORD
       rtdusite LIKE rtdu_t.rtdusite, 
   rtdusite_desc LIKE type_t.chr80, 
   rtdudocdt LIKE rtdu_t.rtdudocdt, 
   rtdudocno LIKE rtdu_t.rtdudocno, 
   rtdu000 LIKE rtdu_t.rtdu000, 
   rtdu001 LIKE rtdu_t.rtdu001, 
   rtdu001_desc LIKE type_t.chr80, 
   rtdu002 LIKE rtdu_t.rtdu002, 
   rtdu003 LIKE rtdu_t.rtdu003, 
   rtdu004 LIKE rtdu_t.rtdu004, 
   rtdu004_desc LIKE type_t.chr80, 
   rtduunit LIKE rtdu_t.rtduunit, 
   stan017 LIKE stan_t.stan017, 
   stan018 LIKE stan_t.stan018, 
   rtdu012 LIKE rtdu_t.rtdu012, 
   rtdu005 LIKE rtdu_t.rtdu005, 
   rtdu005_desc LIKE type_t.chr80, 
   rtdu006 LIKE rtdu_t.rtdu006, 
   rtdu006_desc LIKE type_t.chr80, 
   rtdu007 LIKE rtdu_t.rtdu007, 
   rtdu007_desc LIKE type_t.chr80, 
   rtdu008 LIKE rtdu_t.rtdu008, 
   rtdu008_desc LIKE type_t.chr80, 
   rtdu011 LIKE rtdu_t.rtdu011, 
   rtdu011_desc LIKE type_t.chr80, 
   sum_rtdv020 LIKE type_t.num20_6, 
   sum_rtdv019 LIKE type_t.num20_6, 
   l_stan006 LIKE type_t.chr10, 
   l_stan006_desc LIKE type_t.chr80, 
   l_stan007 LIKE type_t.chr10, 
   l_stan007_desc LIKE type_t.chr80, 
   rtdu009 LIKE rtdu_t.rtdu009, 
   rtdu010 LIKE rtdu_t.rtdu010, 
   rtdustus LIKE rtdu_t.rtdustus, 
   rtduownid LIKE rtdu_t.rtduownid, 
   rtduownid_desc LIKE type_t.chr80, 
   rtduowndp LIKE rtdu_t.rtduowndp, 
   rtduowndp_desc LIKE type_t.chr80, 
   rtducrtid LIKE rtdu_t.rtducrtid, 
   rtducrtid_desc LIKE type_t.chr80, 
   rtducrtdp LIKE rtdu_t.rtducrtdp, 
   rtducrtdp_desc LIKE type_t.chr80, 
   rtducrtdt LIKE rtdu_t.rtducrtdt, 
   rtdumodid LIKE rtdu_t.rtdumodid, 
   rtdumodid_desc LIKE type_t.chr80, 
   rtdumoddt LIKE rtdu_t.rtdumoddt, 
   rtducnfid LIKE rtdu_t.rtducnfid, 
   rtducnfid_desc LIKE type_t.chr80, 
   rtducnfdt LIKE rtdu_t.rtducnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rtdv_d        RECORD
       rtdvseq LIKE rtdv_t.rtdvseq, 
   rtdv002 LIKE rtdv_t.rtdv002, 
   rtdv001 LIKE rtdv_t.rtdv001, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   rtdv018 LIKE rtdv_t.rtdv018, 
   rtdv023 LIKE rtdv_t.rtdv023, 
   rtdv101 LIKE rtdv_t.rtdv101, 
   rtdv024 LIKE rtdv_t.rtdv024, 
   rtdv025 LIKE rtdv_t.rtdv025, 
   rtdv026 LIKE rtdv_t.rtdv026, 
   rtdv102 LIKE rtdv_t.rtdv102, 
   rtdv103 LIKE rtdv_t.rtdv103, 
   rtdv020 LIKE rtdv_t.rtdv020, 
   rtdv021 LIKE rtdv_t.rtdv021, 
   rtdv022 LIKE rtdv_t.rtdv022, 
   rtdv004 LIKE rtdv_t.rtdv004, 
   rtdv004_desc LIKE type_t.chr500, 
   l_oodb006 LIKE type_t.num26_10, 
   l_oodb005 LIKE type_t.chr1, 
   rtdv006 LIKE rtdv_t.rtdv006, 
   rtdv006_desc LIKE type_t.chr500, 
   l_oodb0061 LIKE type_t.num26_10, 
   l_oodb0051 LIKE type_t.chr1, 
   rtdv008 LIKE rtdv_t.rtdv008, 
   rtdv012 LIKE rtdv_t.rtdv012, 
   rtdv009 LIKE rtdv_t.rtdv009, 
   rtdv009_desc LIKE type_t.chr500, 
   rtdv011 LIKE rtdv_t.rtdv011, 
   rtdv033 LIKE rtdv_t.rtdv033, 
   rtdv033_desc LIKE type_t.chr500, 
   rtdv017 LIKE rtdv_t.rtdv017, 
   rtdv019 LIKE rtdv_t.rtdv019, 
   rtdv031 LIKE rtdv_t.rtdv031, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_01_desc LIKE type_t.chr500, 
   rtdv029 LIKE rtdv_t.rtdv029, 
   rtdv029_desc LIKE type_t.chr500, 
   rtdv040 LIKE rtdv_t.rtdv040, 
   rtdv039 LIKE rtdv_t.rtdv039, 
   rtdv003 LIKE rtdv_t.rtdv003, 
   rtdv010 LIKE rtdv_t.rtdv010, 
   rtdv010_desc LIKE type_t.chr500, 
   rtdv013 LIKE rtdv_t.rtdv013, 
   rtdv013_desc LIKE type_t.chr500, 
   rtdv014 LIKE rtdv_t.rtdv014, 
   rtdv015 LIKE rtdv_t.rtdv015, 
   rtdv016 LIKE rtdv_t.rtdv016, 
   rtdv034 LIKE rtdv_t.rtdv034, 
   rtdv035 LIKE rtdv_t.rtdv035, 
   rtdv036 LIKE rtdv_t.rtdv036, 
   rtdv037 LIKE rtdv_t.rtdv037, 
   rtdv038 LIKE rtdv_t.rtdv038, 
   rtdv032 LIKE rtdv_t.rtdv032, 
   rtdv032_desc LIKE type_t.chr500, 
   rtdv027 LIKE rtdv_t.rtdv027, 
   rtdv028 LIKE rtdv_t.rtdv028
       END RECORD
PRIVATE TYPE type_g_rtdv2_d RECORD
       rtdw001 LIKE rtdw_t.rtdw001, 
   rtdw001_desc LIKE type_t.chr500, 
   ooef019 LIKE type_t.chr10, 
   rtdw002 LIKE rtdw_t.rtdw002, 
   rtdw002_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rtdusite LIKE rtdu_t.rtdusite,
   b_rtdusite_desc LIKE type_t.chr80,
      b_rtdudocno LIKE rtdu_t.rtdudocno,
      b_rtdudocdt LIKE rtdu_t.rtdudocdt,
      b_rtdu001 LIKE rtdu_t.rtdu001,
   b_rtdu001_desc LIKE type_t.chr80,
      b_rtdu002 LIKE rtdu_t.rtdu002,
      b_rtdu003 LIKE rtdu_t.rtdu003,
      b_rtdu004 LIKE rtdu_t.rtdu004,
   b_rtdu004_desc LIKE type_t.chr80,
      b_rtdu005 LIKE rtdu_t.rtdu005,
   b_rtdu005_desc LIKE type_t.chr80,
      b_rtdu006 LIKE rtdu_t.rtdu006,
   b_rtdu006_desc LIKE type_t.chr80,
      b_rtdu007 LIKE rtdu_t.rtdu007,
   b_rtdu007_desc LIKE type_t.chr80,
      b_rtdu008 LIKE rtdu_t.rtdu008,
   b_rtdu008_desc LIKE type_t.chr80,
      b_rtdu010 LIKE rtdu_t.rtdu010
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004           LIKE ooef_t.ooef004
DEFINE g_site_flag         LIKE type_t.num5    #141208-00001#14 Add By Ken
DEFINE g_oodb011           LIKE oodb_t.oodb011 #150213-00006#3 2015/02/13 By pomelo add
DEFINE g_rtdv101_flag      LIKE type_t.chr10   #160506-00009#21 Add By Ken 160512 啟用積分超市flag
#end add-point
       
#模組變數(Module Variables)
DEFINE g_rtdu_m          type_g_rtdu_m
DEFINE g_rtdu_m_t        type_g_rtdu_m
DEFINE g_rtdu_m_o        type_g_rtdu_m
DEFINE g_rtdu_m_mask_o   type_g_rtdu_m #轉換遮罩前資料
DEFINE g_rtdu_m_mask_n   type_g_rtdu_m #轉換遮罩後資料
 
   DEFINE g_rtdudocno_t LIKE rtdu_t.rtdudocno
 
 
DEFINE g_rtdv_d          DYNAMIC ARRAY OF type_g_rtdv_d
DEFINE g_rtdv_d_t        type_g_rtdv_d
DEFINE g_rtdv_d_o        type_g_rtdv_d
DEFINE g_rtdv_d_mask_o   DYNAMIC ARRAY OF type_g_rtdv_d #轉換遮罩前資料
DEFINE g_rtdv_d_mask_n   DYNAMIC ARRAY OF type_g_rtdv_d #轉換遮罩後資料
DEFINE g_rtdv2_d          DYNAMIC ARRAY OF type_g_rtdv2_d
DEFINE g_rtdv2_d_t        type_g_rtdv2_d
DEFINE g_rtdv2_d_o        type_g_rtdv2_d
DEFINE g_rtdv2_d_mask_o   DYNAMIC ARRAY OF type_g_rtdv2_d #轉換遮罩前資料
DEFINE g_rtdv2_d_mask_n   DYNAMIC ARRAY OF type_g_rtdv2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
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
 
{<section id="artt405.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   SELECT ooef004 
     INTO g_ooef004 
     FROM ooef_t 
    WHERE ooefent = g_enterprise 
      AND ooef001 = g_site 
      
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/20 By shiun      
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT rtdusite,'',rtdudocdt,rtdudocno,rtdu000,rtdu001,'',rtdu002,rtdu003,rtdu004, 
       '',rtduunit,'','',rtdu012,rtdu005,'',rtdu006,'',rtdu007,'',rtdu008,'',rtdu011,'','','','','', 
       '','',rtdu009,rtdu010,rtdustus,rtduownid,'',rtduowndp,'',rtducrtid,'',rtducrtdp,'',rtducrtdt, 
       rtdumodid,'',rtdumoddt,rtducnfid,'',rtducnfdt", 
                      " FROM rtdu_t",
                      " WHERE rtduent= ? AND rtdudocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt405_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rtdusite,t0.rtdudocdt,t0.rtdudocno,t0.rtdu000,t0.rtdu001,t0.rtdu002, 
       t0.rtdu003,t0.rtdu004,t0.rtduunit,t0.rtdu012,t0.rtdu005,t0.rtdu006,t0.rtdu007,t0.rtdu008,t0.rtdu011, 
       t0.rtdu009,t0.rtdu010,t0.rtdustus,t0.rtduownid,t0.rtduowndp,t0.rtducrtid,t0.rtducrtdp,t0.rtducrtdt, 
       t0.rtdumodid,t0.rtdumoddt,t0.rtducnfid,t0.rtducnfdt,t1.ooefl003 ,t2.pmaal003 ,t3.staal003 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooefl003 ,t7.rtaal003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 ,t12.ooag011 , 
       t13.ooag011",
               " FROM rtdu_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtdusite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.rtdu001 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN staal_t t3 ON t3.staalent="||g_enterprise||" AND t3.staal001=t0.rtdu004 AND t3.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.rtdu005 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.rtdu006  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.rtdu007 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaal_t t7 ON t7.rtaalent="||g_enterprise||" AND t7.rtaal001=t0.rtdu008 AND t7.rtaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.rtduownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.rtduowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.rtducrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.rtducrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.rtdumodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.rtducnfid  ",
 
               " WHERE t0.rtduent = " ||g_enterprise|| " AND t0.rtdudocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artt405_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artt405 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artt405_init()   
 
      #進入選單 Menu (="N")
      CALL artt405_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artt405
      
   END IF 
   
   CLOSE artt405_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add 
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/20 By shiun
   CALL s_artt405_drop_imaa009_tmp()
   CALL s_artt405_drop_rtdx_tmp()
   CALL artt405_drop_temp() RETURNING l_success   #150915-00001#1 150915 by sakura add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artt405.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artt405_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004 #add by geza 20160314
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
      CALL cl_set_combo_scc_part('rtdustus','13','N,Y,D,R,W,A,X')
 
      CALL cl_set_combo_scc('rtdu000','6780') 
   CALL cl_set_combo_scc('rtdu003','6013') 
   CALL cl_set_combo_scc('rtdu012','6014') 
   CALL cl_set_combo_scc('rtdv012','6014') 
   CALL cl_set_combo_scc('rtdv034','2025') 
   CALL cl_set_combo_scc('rtdv035','2028') 
   CALL cl_set_combo_scc('rtdv036','2027') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #LET g_prog = 'artt405' #暫時使用
   CALL cl_set_combo_scc_part('rtdu003','6013','1,2,3')   #160408-00023#1 Add By Ken 160411
   CALL cl_set_combo_scc_part('b_rtdu003','6013','1,2,3')
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   CALL s_life_cycle_display(g_prog,'rtdu009','1')
   CALL s_artt405_create_rtdx_tmp()
   CALL s_artt405_create_imaa009_tmp()
   CALL artt405_create_temp() RETURNING l_success   #150915-00001#1 150915 by sakura add
   #add by geza 20160314(S)
   #栏位名称重新显示
   CALL s_desc_gzcbl004_desc('6899','1') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("rtdv024",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','2') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("rtdv025",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','3') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("rtdv026",l_gzcbl004)
   #add by geza 20160314(E)
   
   #160506-00009#21 Add By Ken 160512(s)
   LET g_rtdv101_flag = cl_get_para(g_enterprise,g_site,"S-CIR-2028")
   IF g_rtdv101_flag = 'N' THEN
      CALL cl_set_comp_visible("rtdv101,rtdv102,rtdv103",FALSE)
   END IF
   #160506-00009#21 Add By Ken 160512(e)   
   #end add-point
   
   #初始化搜尋條件
   CALL artt405_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="artt405.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION artt405_ui_dialog()
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
            CALL artt405_insert()
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
         INITIALIZE g_rtdu_m.* TO NULL
         CALL g_rtdv_d.clear()
         CALL g_rtdv2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artt405_init()
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
               
               CALL artt405_fetch('') # reload data
               LET l_ac = 1
               CALL artt405_ui_detailshow() #Setting the current row 
         
               CALL artt405_idx_chk()
               #NEXT FIELD rtdvseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rtdv_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt405_idx_chk()
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
               CALL artt405_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_rtdv2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt405_idx_chk()
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
               CALL artt405_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL artt405_browser_fill("")
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
               CALL artt405_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL artt405_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL artt405_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL artt405_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL artt405_set_act_visible()   
            CALL artt405_set_act_no_visible()
            IF NOT (g_rtdu_m.rtdudocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rtduent = " ||g_enterprise|| " AND",
                                  " rtdudocno = '", g_rtdu_m.rtdudocno, "' "
 
               #填到對應位置
               CALL artt405_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "rtdu_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtdv_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtdw_t" 
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
               CALL artt405_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "rtdu_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtdv_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtdw_t" 
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
                  CALL artt405_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL artt405_fetch("F")
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
               CALL artt405_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL artt405_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt405_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL artt405_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt405_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL artt405_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt405_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL artt405_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt405_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL artt405_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt405_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_rtdv_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_rtdv2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
               NEXT FIELD rtdvseq
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
               CALL artt405_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL artt405_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL artt405_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL artt405_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/art/artt405_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/art/artt405_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL artt405_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artt405_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_load
            LET g_action_choice="excel_load"
            IF cl_auth_chk_act("excel_load") THEN
               
               #add-point:ON ACTION excel_load name="menu.excel_load"
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_load"
               LET la_param.param[3] = util.JSON.stringify(g_etlparam)

               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_example
            LET g_action_choice="excel_example"
            IF cl_auth_chk_act("excel_example") THEN
               
               #add-point:ON ACTION excel_example name="menu.excel_example"
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_example"
               LET ls_js = util.JSON.stringify( la_param )

               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL artt405_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL artt405_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL artt405_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rtdu_m.rtdudocdt)
 
 
 
         
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
 
{<section id="artt405.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION artt405_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING #141208-00001#14 Add By Ken
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   CALL s_aooi500_sql_where(g_prog,'rtdusite') RETURNING l_where #141208-00001#14 Add By Ken
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
      LET l_sub_sql = " SELECT DISTINCT rtdudocno ",
                      " FROM rtdu_t ",
                      " ",
                      " LEFT JOIN rtdv_t ON rtdvent = rtduent AND rtdudocno = rtdvdocno ", "  ",
                      #add-point:browser_fill段sql(rtdv_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN rtdw_t ON rtdwent = rtduent AND rtdudocno = rtdwdocno", "  ",
                      #add-point:browser_fill段sql(rtdw_t1) name="browser_fill.cnt.join.rtdw_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE rtduent = " ||g_enterprise|| " AND rtdvent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rtdu_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rtdudocno ",
                      " FROM rtdu_t ", 
                      "  ",
                      "  ",
                      " WHERE rtduent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rtdu_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND ", l_where #141208-00001#14 Add By Ken
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
      INITIALIZE g_rtdu_m.* TO NULL
      CALL g_rtdv_d.clear()        
      CALL g_rtdv2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rtdusite,t0.rtdudocno,t0.rtdudocdt,t0.rtdu001,t0.rtdu002,t0.rtdu003,t0.rtdu004,t0.rtdu005,t0.rtdu006,t0.rtdu007,t0.rtdu008,t0.rtdu010 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtdustus,t0.rtdusite,t0.rtdudocno,t0.rtdudocdt,t0.rtdu001,t0.rtdu002, 
          t0.rtdu003,t0.rtdu004,t0.rtdu005,t0.rtdu006,t0.rtdu007,t0.rtdu008,t0.rtdu010,t1.ooefl003 , 
          t2.pmaal003 ,t3.staal003 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.rtaal003 ",
                  " FROM rtdu_t t0",
                  "  ",
                  "  LEFT JOIN rtdv_t ON rtdvent = rtduent AND rtdudocno = rtdvdocno ", "  ", 
                  #add-point:browser_fill段sql(rtdv_t1) name="browser_fill.join.rtdv_t1"
                  
                  #end add-point
                  "  LEFT JOIN rtdw_t ON rtdwent = rtduent AND rtdudocno = rtdwdocno", "  ", 
                  #add-point:browser_fill段sql(rtdw_t1) name="browser_fill.join.rtdw_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtdusite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.rtdu001 AND t2.pmaal001='"||g_dlang||"' ",
               " LEFT JOIN staal_t t3 ON t3.staalent="||g_enterprise||" AND t3.staal001=t0.rtdu004 AND t3.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.rtdu005 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.rtdu006  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.rtdu007 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaal_t t7 ON t7.rtaalent="||g_enterprise||" AND t7.rtaal001=t0.rtdu008 AND t7.rtaal002='"||g_dlang||"' ",
 
                  " WHERE t0.rtduent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rtdu_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtdustus,t0.rtdusite,t0.rtdudocno,t0.rtdudocdt,t0.rtdu001,t0.rtdu002, 
          t0.rtdu003,t0.rtdu004,t0.rtdu005,t0.rtdu006,t0.rtdu007,t0.rtdu008,t0.rtdu010,t1.ooefl003 , 
          t2.pmaal003 ,t3.staal003 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.rtaal003 ",
                  " FROM rtdu_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtdusite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.rtdu001 AND t2.pmaal001='"||g_dlang||"' ",
               " LEFT JOIN staal_t t3 ON t3.staalent="||g_enterprise||" AND t3.staal001=t0.rtdu004 AND t3.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.rtdu005 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.rtdu006  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.rtdu007 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaal_t t7 ON t7.rtaalent="||g_enterprise||" AND t7.rtaal001=t0.rtdu008 AND t7.rtaal002='"||g_dlang||"' ",
 
                  " WHERE t0.rtduent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rtdu_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ", l_where #141208-00001#14 Add By Ken
   LET g_sql = g_sql," AND rtdu002 IS NOT NULL" #geza---add 20150428
   #end add-point
   LET g_sql = g_sql, " ORDER BY rtdudocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtdu_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rtdusite,g_browser[g_cnt].b_rtdudocno, 
          g_browser[g_cnt].b_rtdudocdt,g_browser[g_cnt].b_rtdu001,g_browser[g_cnt].b_rtdu002,g_browser[g_cnt].b_rtdu003, 
          g_browser[g_cnt].b_rtdu004,g_browser[g_cnt].b_rtdu005,g_browser[g_cnt].b_rtdu006,g_browser[g_cnt].b_rtdu007, 
          g_browser[g_cnt].b_rtdu008,g_browser[g_cnt].b_rtdu010,g_browser[g_cnt].b_rtdusite_desc,g_browser[g_cnt].b_rtdu001_desc, 
          g_browser[g_cnt].b_rtdu004_desc,g_browser[g_cnt].b_rtdu005_desc,g_browser[g_cnt].b_rtdu006_desc, 
          g_browser[g_cnt].b_rtdu007_desc,g_browser[g_cnt].b_rtdu008_desc
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
         CALL artt405_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_rtdudocno) THEN
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
   #add by geza 20160316(S)
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt405_set_act_visible()   
   CALL artt405_set_act_no_visible()
   #add by geza 20160316(E)
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION artt405_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rtdu_m.rtdudocno = g_browser[g_current_idx].b_rtdudocno   
 
   EXECUTE artt405_master_referesh USING g_rtdu_m.rtdudocno INTO g_rtdu_m.rtdusite,g_rtdu_m.rtdudocdt, 
       g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000,g_rtdu_m.rtdu001,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004, 
       g_rtdu_m.rtduunit,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008, 
       g_rtdu_m.rtdu011,g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduowndp, 
       g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumoddt, 
       g_rtdu_m.rtducnfid,g_rtdu_m.rtducnfdt,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu004_desc, 
       g_rtdu_m.rtdu005_desc,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008_desc,g_rtdu_m.rtduownid_desc, 
       g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp_desc,g_rtdu_m.rtdumodid_desc, 
       g_rtdu_m.rtducnfid_desc
   
   CALL artt405_rtdu_t_mask()
   CALL artt405_show()
      
END FUNCTION
 
{</section>}
 
{<section id="artt405.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION artt405_ui_detailshow()
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
 
{<section id="artt405.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION artt405_ui_browser_refresh()
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
      IF g_browser[l_i].b_rtdudocno = g_rtdu_m.rtdudocno 
 
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
 
{<section id="artt405.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION artt405_construct()
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
   INITIALIZE g_rtdu_m.* TO NULL
   CALL g_rtdv_d.clear()        
   CALL g_rtdv2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON rtdusite,rtdudocdt,rtdudocno,rtdu000,rtdu001,rtdu002,rtdu003,rtdu004, 
          rtduunit,stan017,stan018,rtdu012,rtdu005,rtdu006,rtdu007,rtdu008,rtdu011,rtdu009,rtdu010,rtdustus, 
          rtduownid,rtduowndp,rtducrtid,rtducrtdp,rtducrtdt,rtdumodid,rtdumoddt,rtducnfid,rtducnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtducrtdt>>----
         AFTER FIELD rtducrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtdumoddt>>----
         AFTER FIELD rtdumoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtducnfdt>>----
         AFTER FIELD rtducnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtdupstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rtdusite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdusite
            #add-point:ON ACTION controlp INFIELD rtdusite name="construct.c.rtdusite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            #141208-00001#14 Add By Ken(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdusite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdusite  #顯示到畫面上
            NEXT FIELD rtdusite                     #返回原欄位
            #141208-00001#14 Add By Ken(S)
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdusite
            #add-point:BEFORE FIELD rtdusite name="construct.b.rtdusite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdusite
            
            #add-point:AFTER FIELD rtdusite name="construct.a.rtdusite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdudocdt
            #add-point:BEFORE FIELD rtdudocdt name="construct.b.rtdudocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdudocdt
            
            #add-point:AFTER FIELD rtdudocdt name="construct.a.rtdudocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdudocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdudocdt
            #add-point:ON ACTION controlp INFIELD rtdudocdt name="construct.c.rtdudocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtdudocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdudocno
            #add-point:ON ACTION controlp INFIELD rtdudocno name="construct.c.rtdudocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'c'      #sakura add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtdu002 IS NOT NULL "
            CALL q_rtdudocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdudocno  #顯示到畫面上

            NEXT FIELD rtdudocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdudocno
            #add-point:BEFORE FIELD rtdudocno name="construct.b.rtdudocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdudocno
            
            #add-point:AFTER FIELD rtdudocno name="construct.a.rtdudocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu000
            #add-point:BEFORE FIELD rtdu000 name="construct.b.rtdu000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu000
            
            #add-point:AFTER FIELD rtdu000 name="construct.a.rtdu000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdu000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu000
            #add-point:ON ACTION controlp INFIELD rtdu000 name="construct.c.rtdu000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtdu001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu001
            #add-point:ON ACTION controlp INFIELD rtdu001 name="construct.c.rtdu001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'c'      #sakura add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pmaa002 IN ('1','3') "
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdu001  #顯示到畫面上

            NEXT FIELD rtdu001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu001
            #add-point:BEFORE FIELD rtdu001 name="construct.b.rtdu001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu001
            
            #add-point:AFTER FIELD rtdu001 name="construct.a.rtdu001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdu002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu002
            #add-point:ON ACTION controlp INFIELD rtdu002 name="construct.c.rtdu002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " stanent = ",g_enterprise #add by geza 20160303 #加上ent条件
            CALL q_stan001_3()                     #呼叫開窗  #lanjj modify q_stan001 to q_stan001_3
            DISPLAY g_qryparam.return1 TO rtdu002  #顯示到畫面上
            NEXT FIELD rtdu002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu002
            #add-point:BEFORE FIELD rtdu002 name="construct.b.rtdu002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu002
            
            #add-point:AFTER FIELD rtdu002 name="construct.a.rtdu002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu003
            #add-point:BEFORE FIELD rtdu003 name="construct.b.rtdu003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu003
            
            #add-point:AFTER FIELD rtdu003 name="construct.a.rtdu003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdu003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu003
            #add-point:ON ACTION controlp INFIELD rtdu003 name="construct.c.rtdu003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtdu004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu004
            #add-point:ON ACTION controlp INFIELD rtdu004 name="construct.c.rtdu004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdu004  #顯示到畫面上
            NEXT FIELD rtdu004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu004
            #add-point:BEFORE FIELD rtdu004 name="construct.b.rtdu004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu004
            
            #add-point:AFTER FIELD rtdu004 name="construct.a.rtdu004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtduunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtduunit
            #add-point:ON ACTION controlp INFIELD rtduunit name="construct.c.rtduunit"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtduunit  #顯示到畫面上
            NEXT FIELD rtduunit                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtduunit
            #add-point:BEFORE FIELD rtduunit name="construct.b.rtduunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtduunit
            
            #add-point:AFTER FIELD rtduunit name="construct.a.rtduunit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stan017
            #add-point:BEFORE FIELD stan017 name="construct.b.stan017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stan017
            
            #add-point:AFTER FIELD stan017 name="construct.a.stan017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stan017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stan017
            #add-point:ON ACTION controlp INFIELD stan017 name="construct.c.stan017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stan018
            #add-point:BEFORE FIELD stan018 name="construct.b.stan018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stan018
            
            #add-point:AFTER FIELD stan018 name="construct.a.stan018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stan018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stan018
            #add-point:ON ACTION controlp INFIELD stan018 name="construct.c.stan018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu012
            #add-point:BEFORE FIELD rtdu012 name="construct.b.rtdu012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu012
            
            #add-point:AFTER FIELD rtdu012 name="construct.a.rtdu012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdu012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu012
            #add-point:ON ACTION controlp INFIELD rtdu012 name="construct.c.rtdu012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtdu005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu005
            #add-point:ON ACTION controlp INFIELD rtdu005 name="construct.c.rtdu005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'c'      #sakura add            
            LET g_qryparam.reqry = FALSE

            IF s_aooi500_setpoint(g_prog,'rtdu005') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdu005',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef303='Y'"
               CALL q_ooef001()   
            END IF

            DISPLAY g_qryparam.return1 TO rtdu005  #顯示到畫面上

            NEXT FIELD rtdu005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu005
            #add-point:BEFORE FIELD rtdu005 name="construct.b.rtdu005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu005
            
            #add-point:AFTER FIELD rtdu005 name="construct.a.rtdu005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdu006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu006
            #add-point:ON ACTION controlp INFIELD rtdu006 name="construct.c.rtdu006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdu006  #顯示到畫面上
            NEXT FIELD rtdu006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu006
            #add-point:BEFORE FIELD rtdu006 name="construct.b.rtdu006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu006
            
            #add-point:AFTER FIELD rtdu006 name="construct.a.rtdu006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdu007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu007
            #add-point:ON ACTION controlp INFIELD rtdu007 name="construct.c.rtdu007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'                 
            LET g_qryparam.reqry = FALSE
            
            IF s_aooi500_setpoint(g_prog,'rtdu007') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdu007',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = "ooef302='Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO rtdu007  #顯示到畫面上
            NEXT FIELD rtdu007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu007
            #add-point:BEFORE FIELD rtdu007 name="construct.b.rtdu007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu007
            
            #add-point:AFTER FIELD rtdu007 name="construct.a.rtdu007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdu008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu008
            #add-point:ON ACTION controlp INFIELD rtdu008 name="construct.c.rtdu008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdu008  #顯示到畫面上
            NEXT FIELD rtdu008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu008
            #add-point:BEFORE FIELD rtdu008 name="construct.b.rtdu008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu008
            
            #add-point:AFTER FIELD rtdu008 name="construct.a.rtdu008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdu011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu011
            #add-point:ON ACTION controlp INFIELD rtdu011 name="construct.c.rtdu011"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef019()                           #呼叫開窗   #160623-00028#1
            CALL q_ooef019_1()                          #呼叫開窗  #160623-00028#1
            DISPLAY g_qryparam.return1 TO rtdu011  #顯示到畫面上
            NEXT FIELD rtdu011                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu011
            #add-point:BEFORE FIELD rtdu011 name="construct.b.rtdu011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu011
            
            #add-point:AFTER FIELD rtdu011 name="construct.a.rtdu011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdu009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu009
            #add-point:ON ACTION controlp INFIELD rtdu009 name="construct.c.rtdu009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdu009  #顯示到畫面上
            NEXT FIELD rtdu009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu009
            #add-point:BEFORE FIELD rtdu009 name="construct.b.rtdu009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu009
            
            #add-point:AFTER FIELD rtdu009 name="construct.a.rtdu009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu010
            #add-point:BEFORE FIELD rtdu010 name="construct.b.rtdu010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu010
            
            #add-point:AFTER FIELD rtdu010 name="construct.a.rtdu010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdu010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu010
            #add-point:ON ACTION controlp INFIELD rtdu010 name="construct.c.rtdu010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdustus
            #add-point:BEFORE FIELD rtdustus name="construct.b.rtdustus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdustus
            
            #add-point:AFTER FIELD rtdustus name="construct.a.rtdustus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtdustus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdustus
            #add-point:ON ACTION controlp INFIELD rtdustus name="construct.c.rtdustus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtduownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtduownid
            #add-point:ON ACTION controlp INFIELD rtduownid name="construct.c.rtduownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtduownid  #顯示到畫面上
            NEXT FIELD rtduownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtduownid
            #add-point:BEFORE FIELD rtduownid name="construct.b.rtduownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtduownid
            
            #add-point:AFTER FIELD rtduownid name="construct.a.rtduownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtduowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtduowndp
            #add-point:ON ACTION controlp INFIELD rtduowndp name="construct.c.rtduowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtduowndp  #顯示到畫面上
            NEXT FIELD rtduowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtduowndp
            #add-point:BEFORE FIELD rtduowndp name="construct.b.rtduowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtduowndp
            
            #add-point:AFTER FIELD rtduowndp name="construct.a.rtduowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtducrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtducrtid
            #add-point:ON ACTION controlp INFIELD rtducrtid name="construct.c.rtducrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtducrtid  #顯示到畫面上
            NEXT FIELD rtducrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtducrtid
            #add-point:BEFORE FIELD rtducrtid name="construct.b.rtducrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtducrtid
            
            #add-point:AFTER FIELD rtducrtid name="construct.a.rtducrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtducrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtducrtdp
            #add-point:ON ACTION controlp INFIELD rtducrtdp name="construct.c.rtducrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtducrtdp  #顯示到畫面上
            NEXT FIELD rtducrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtducrtdp
            #add-point:BEFORE FIELD rtducrtdp name="construct.b.rtducrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtducrtdp
            
            #add-point:AFTER FIELD rtducrtdp name="construct.a.rtducrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtducrtdt
            #add-point:BEFORE FIELD rtducrtdt name="construct.b.rtducrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtdumodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdumodid
            #add-point:ON ACTION controlp INFIELD rtdumodid name="construct.c.rtdumodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdumodid  #顯示到畫面上
            NEXT FIELD rtdumodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdumodid
            #add-point:BEFORE FIELD rtdumodid name="construct.b.rtdumodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdumodid
            
            #add-point:AFTER FIELD rtdumodid name="construct.a.rtdumodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdumoddt
            #add-point:BEFORE FIELD rtdumoddt name="construct.b.rtdumoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtducnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtducnfid
            #add-point:ON ACTION controlp INFIELD rtducnfid name="construct.c.rtducnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtducnfid  #顯示到畫面上
            NEXT FIELD rtducnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtducnfid
            #add-point:BEFORE FIELD rtducnfid name="construct.b.rtducnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtducnfid
            
            #add-point:AFTER FIELD rtducnfid name="construct.a.rtducnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtducnfdt
            #add-point:BEFORE FIELD rtducnfdt name="construct.b.rtducnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rtdvseq,rtdv002,rtdv001,rtdv018,rtdv023,rtdv101,rtdv024,rtdv025,rtdv026, 
          rtdv102,rtdv103,rtdv020,rtdv021,rtdv022,rtdv004,l_oodb006,l_oodb005,rtdv006,l_oodb0061,l_oodb0051, 
          rtdv008,rtdv012,rtdv009,rtdv011,rtdv033,rtdv017,rtdv019,rtdv031,rtdv029,rtdv040,rtdv039,rtdv003, 
          rtdv010,rtdv013,rtdv014,rtdv015,rtdv016,rtdv034,rtdv035,rtdv036,rtdv037,rtdv038,rtdv032,rtdv027, 
          rtdv028
           FROM s_detail1[1].rtdvseq,s_detail1[1].rtdv002,s_detail1[1].rtdv001,s_detail1[1].rtdv018, 
               s_detail1[1].rtdv023,s_detail1[1].rtdv101,s_detail1[1].rtdv024,s_detail1[1].rtdv025,s_detail1[1].rtdv026, 
               s_detail1[1].rtdv102,s_detail1[1].rtdv103,s_detail1[1].rtdv020,s_detail1[1].rtdv021,s_detail1[1].rtdv022, 
               s_detail1[1].rtdv004,s_detail1[1].l_oodb006,s_detail1[1].l_oodb005,s_detail1[1].rtdv006, 
               s_detail1[1].l_oodb0061,s_detail1[1].l_oodb0051,s_detail1[1].rtdv008,s_detail1[1].rtdv012, 
               s_detail1[1].rtdv009,s_detail1[1].rtdv011,s_detail1[1].rtdv033,s_detail1[1].rtdv017,s_detail1[1].rtdv019, 
               s_detail1[1].rtdv031,s_detail1[1].rtdv029,s_detail1[1].rtdv040,s_detail1[1].rtdv039,s_detail1[1].rtdv003, 
               s_detail1[1].rtdv010,s_detail1[1].rtdv013,s_detail1[1].rtdv014,s_detail1[1].rtdv015,s_detail1[1].rtdv016, 
               s_detail1[1].rtdv034,s_detail1[1].rtdv035,s_detail1[1].rtdv036,s_detail1[1].rtdv037,s_detail1[1].rtdv038, 
               s_detail1[1].rtdv032,s_detail1[1].rtdv027,s_detail1[1].rtdv028
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdvseq
            #add-point:BEFORE FIELD rtdvseq name="construct.b.page1.rtdvseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdvseq
            
            #add-point:AFTER FIELD rtdvseq name="construct.a.page1.rtdvseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdvseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdvseq
            #add-point:ON ACTION controlp INFIELD rtdvseq name="construct.c.page1.rtdvseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdv002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv002
            #add-point:ON ACTION controlp INFIELD rtdv002 name="construct.c.page1.rtdv002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'                 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " imay006='Y' "
            CALL q_imay003_2()                           #呼叫開窗

            DISPLAY g_qryparam.return1 TO rtdv002  #顯示到畫面上

            NEXT FIELD rtdv002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv002
            #add-point:BEFORE FIELD rtdv002 name="construct.b.page1.rtdv002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv002
            
            #add-point:AFTER FIELD rtdv002 name="construct.a.page1.rtdv002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv001
            #add-point:ON ACTION controlp INFIELD rtdv001 name="construct.c.page1.rtdv001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " imay006='Y' "
            CALL q_imay001()             #呼叫開窗

            DISPLAY g_qryparam.return1 TO rtdv001  #顯示到畫面上

            NEXT FIELD rtdv001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv001
            #add-point:BEFORE FIELD rtdv001 name="construct.b.page1.rtdv001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv001
            
            #add-point:AFTER FIELD rtdv001 name="construct.a.page1.rtdv001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv018
            #add-point:BEFORE FIELD rtdv018 name="construct.b.page1.rtdv018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv018
            
            #add-point:AFTER FIELD rtdv018 name="construct.a.page1.rtdv018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv018
            #add-point:ON ACTION controlp INFIELD rtdv018 name="construct.c.page1.rtdv018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv023
            #add-point:BEFORE FIELD rtdv023 name="construct.b.page1.rtdv023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv023
            
            #add-point:AFTER FIELD rtdv023 name="construct.a.page1.rtdv023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv023
            #add-point:ON ACTION controlp INFIELD rtdv023 name="construct.c.page1.rtdv023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv101
            #add-point:BEFORE FIELD rtdv101 name="construct.b.page1.rtdv101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv101
            
            #add-point:AFTER FIELD rtdv101 name="construct.a.page1.rtdv101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv101
            #add-point:ON ACTION controlp INFIELD rtdv101 name="construct.c.page1.rtdv101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv024
            #add-point:BEFORE FIELD rtdv024 name="construct.b.page1.rtdv024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv024
            
            #add-point:AFTER FIELD rtdv024 name="construct.a.page1.rtdv024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv024
            #add-point:ON ACTION controlp INFIELD rtdv024 name="construct.c.page1.rtdv024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv025
            #add-point:BEFORE FIELD rtdv025 name="construct.b.page1.rtdv025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv025
            
            #add-point:AFTER FIELD rtdv025 name="construct.a.page1.rtdv025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv025
            #add-point:ON ACTION controlp INFIELD rtdv025 name="construct.c.page1.rtdv025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv026
            #add-point:BEFORE FIELD rtdv026 name="construct.b.page1.rtdv026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv026
            
            #add-point:AFTER FIELD rtdv026 name="construct.a.page1.rtdv026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv026
            #add-point:ON ACTION controlp INFIELD rtdv026 name="construct.c.page1.rtdv026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv102
            #add-point:BEFORE FIELD rtdv102 name="construct.b.page1.rtdv102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv102
            
            #add-point:AFTER FIELD rtdv102 name="construct.a.page1.rtdv102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv102
            #add-point:ON ACTION controlp INFIELD rtdv102 name="construct.c.page1.rtdv102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv103
            #add-point:BEFORE FIELD rtdv103 name="construct.b.page1.rtdv103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv103
            
            #add-point:AFTER FIELD rtdv103 name="construct.a.page1.rtdv103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv103
            #add-point:ON ACTION controlp INFIELD rtdv103 name="construct.c.page1.rtdv103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv020
            #add-point:BEFORE FIELD rtdv020 name="construct.b.page1.rtdv020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv020
            
            #add-point:AFTER FIELD rtdv020 name="construct.a.page1.rtdv020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv020
            #add-point:ON ACTION controlp INFIELD rtdv020 name="construct.c.page1.rtdv020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv021
            #add-point:BEFORE FIELD rtdv021 name="construct.b.page1.rtdv021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv021
            
            #add-point:AFTER FIELD rtdv021 name="construct.a.page1.rtdv021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv021
            #add-point:ON ACTION controlp INFIELD rtdv021 name="construct.c.page1.rtdv021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv022
            #add-point:BEFORE FIELD rtdv022 name="construct.b.page1.rtdv022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv022
            
            #add-point:AFTER FIELD rtdv022 name="construct.a.page1.rtdv022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv022
            #add-point:ON ACTION controlp INFIELD rtdv022 name="construct.c.page1.rtdv022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdv004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv004
            #add-point:ON ACTION controlp INFIELD rtdv004 name="construct.c.page1.rtdv004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            let g_qryparam.where = "oodb004='1' "
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdv004  #顯示到畫面上

            NEXT FIELD rtdv004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv004
            #add-point:BEFORE FIELD rtdv004 name="construct.b.page1.rtdv004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv004
            
            #add-point:AFTER FIELD rtdv004 name="construct.a.page1.rtdv004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_oodb006
            #add-point:BEFORE FIELD l_oodb006 name="construct.b.page1.l_oodb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_oodb006
            
            #add-point:AFTER FIELD l_oodb006 name="construct.a.page1.l_oodb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_oodb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_oodb006
            #add-point:ON ACTION controlp INFIELD l_oodb006 name="construct.c.page1.l_oodb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_oodb005
            #add-point:BEFORE FIELD l_oodb005 name="construct.b.page1.l_oodb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_oodb005
            
            #add-point:AFTER FIELD l_oodb005 name="construct.a.page1.l_oodb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_oodb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_oodb005
            #add-point:ON ACTION controlp INFIELD l_oodb005 name="construct.c.page1.l_oodb005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdv006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv006
            #add-point:ON ACTION controlp INFIELD rtdv006 name="construct.c.page1.rtdv006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'c'      #sakura add            
            LET g_qryparam.reqry = FALSE
            let g_qryparam.where = "oodb004='1' "
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdv006  #顯示到畫面上

            NEXT FIELD rtdv006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv006
            #add-point:BEFORE FIELD rtdv006 name="construct.b.page1.rtdv006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv006
            
            #add-point:AFTER FIELD rtdv006 name="construct.a.page1.rtdv006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_oodb0061
            #add-point:BEFORE FIELD l_oodb0061 name="construct.b.page1.l_oodb0061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_oodb0061
            
            #add-point:AFTER FIELD l_oodb0061 name="construct.a.page1.l_oodb0061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_oodb0061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_oodb0061
            #add-point:ON ACTION controlp INFIELD l_oodb0061 name="construct.c.page1.l_oodb0061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_oodb0051
            #add-point:BEFORE FIELD l_oodb0051 name="construct.b.page1.l_oodb0051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_oodb0051
            
            #add-point:AFTER FIELD l_oodb0051 name="construct.a.page1.l_oodb0051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_oodb0051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_oodb0051
            #add-point:ON ACTION controlp INFIELD l_oodb0051 name="construct.c.page1.l_oodb0051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv008
            #add-point:BEFORE FIELD rtdv008 name="construct.b.page1.rtdv008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv008
            
            #add-point:AFTER FIELD rtdv008 name="construct.a.page1.rtdv008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv008
            #add-point:ON ACTION controlp INFIELD rtdv008 name="construct.c.page1.rtdv008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv012
            #add-point:BEFORE FIELD rtdv012 name="construct.b.page1.rtdv012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv012
            
            #add-point:AFTER FIELD rtdv012 name="construct.a.page1.rtdv012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv012
            #add-point:ON ACTION controlp INFIELD rtdv012 name="construct.c.page1.rtdv012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdv009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv009
            #add-point:ON ACTION controlp INFIELD rtdv009 name="construct.c.page1.rtdv009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdv009  #顯示到畫面上
            NEXT FIELD rtdv009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv009
            #add-point:BEFORE FIELD rtdv009 name="construct.b.page1.rtdv009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv009
            
            #add-point:AFTER FIELD rtdv009 name="construct.a.page1.rtdv009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv011
            #add-point:BEFORE FIELD rtdv011 name="construct.b.page1.rtdv011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv011
            
            #add-point:AFTER FIELD rtdv011 name="construct.a.page1.rtdv011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv011
            #add-point:ON ACTION controlp INFIELD rtdv011 name="construct.c.page1.rtdv011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdv033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv033
            #add-point:ON ACTION controlp INFIELD rtdv033 name="construct.c.page1.rtdv033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdv033  #顯示到畫面上
            NEXT FIELD rtdv033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv033
            #add-point:BEFORE FIELD rtdv033 name="construct.b.page1.rtdv033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv033
            
            #add-point:AFTER FIELD rtdv033 name="construct.a.page1.rtdv033"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv017
            #add-point:BEFORE FIELD rtdv017 name="construct.b.page1.rtdv017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv017
            
            #add-point:AFTER FIELD rtdv017 name="construct.a.page1.rtdv017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv017
            #add-point:ON ACTION controlp INFIELD rtdv017 name="construct.c.page1.rtdv017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv019
            #add-point:BEFORE FIELD rtdv019 name="construct.b.page1.rtdv019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv019
            
            #add-point:AFTER FIELD rtdv019 name="construct.a.page1.rtdv019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv019
            #add-point:ON ACTION controlp INFIELD rtdv019 name="construct.c.page1.rtdv019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv031
            #add-point:BEFORE FIELD rtdv031 name="construct.b.page1.rtdv031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv031
            
            #add-point:AFTER FIELD rtdv031 name="construct.a.page1.rtdv031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv031
            #add-point:ON ACTION controlp INFIELD rtdv031 name="construct.c.page1.rtdv031"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdv029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv029
            #add-point:ON ACTION controlp INFIELD rtdv029 name="construct.c.page1.rtdv029"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdv029  #顯示到畫面上
            NEXT FIELD rtdv029                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv029
            #add-point:BEFORE FIELD rtdv029 name="construct.b.page1.rtdv029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv029
            
            #add-point:AFTER FIELD rtdv029 name="construct.a.page1.rtdv029"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv040
            #add-point:BEFORE FIELD rtdv040 name="construct.b.page1.rtdv040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv040
            
            #add-point:AFTER FIELD rtdv040 name="construct.a.page1.rtdv040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv040
            #add-point:ON ACTION controlp INFIELD rtdv040 name="construct.c.page1.rtdv040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv039
            #add-point:BEFORE FIELD rtdv039 name="construct.b.page1.rtdv039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv039
            
            #add-point:AFTER FIELD rtdv039 name="construct.a.page1.rtdv039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv039
            #add-point:ON ACTION controlp INFIELD rtdv039 name="construct.c.page1.rtdv039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv003
            #add-point:BEFORE FIELD rtdv003 name="construct.b.page1.rtdv003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv003
            
            #add-point:AFTER FIELD rtdv003 name="construct.a.page1.rtdv003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv003
            #add-point:ON ACTION controlp INFIELD rtdv003 name="construct.c.page1.rtdv003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdv010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv010
            #add-point:ON ACTION controlp INFIELD rtdv010 name="construct.c.page1.rtdv010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdv010  #顯示到畫面上
            NEXT FIELD rtdv010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv010
            #add-point:BEFORE FIELD rtdv010 name="construct.b.page1.rtdv010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv010
            
            #add-point:AFTER FIELD rtdv010 name="construct.a.page1.rtdv010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv013
            #add-point:ON ACTION controlp INFIELD rtdv013 name="construct.c.page1.rtdv013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdv013  #顯示到畫面上
            NEXT FIELD rtdv013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv013
            #add-point:BEFORE FIELD rtdv013 name="construct.b.page1.rtdv013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv013
            
            #add-point:AFTER FIELD rtdv013 name="construct.a.page1.rtdv013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv014
            #add-point:BEFORE FIELD rtdv014 name="construct.b.page1.rtdv014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv014
            
            #add-point:AFTER FIELD rtdv014 name="construct.a.page1.rtdv014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv014
            #add-point:ON ACTION controlp INFIELD rtdv014 name="construct.c.page1.rtdv014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv015
            #add-point:BEFORE FIELD rtdv015 name="construct.b.page1.rtdv015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv015
            
            #add-point:AFTER FIELD rtdv015 name="construct.a.page1.rtdv015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv015
            #add-point:ON ACTION controlp INFIELD rtdv015 name="construct.c.page1.rtdv015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv016
            #add-point:BEFORE FIELD rtdv016 name="construct.b.page1.rtdv016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv016
            
            #add-point:AFTER FIELD rtdv016 name="construct.a.page1.rtdv016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv016
            #add-point:ON ACTION controlp INFIELD rtdv016 name="construct.c.page1.rtdv016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv034
            #add-point:BEFORE FIELD rtdv034 name="construct.b.page1.rtdv034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv034
            
            #add-point:AFTER FIELD rtdv034 name="construct.a.page1.rtdv034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv034
            #add-point:ON ACTION controlp INFIELD rtdv034 name="construct.c.page1.rtdv034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv035
            #add-point:BEFORE FIELD rtdv035 name="construct.b.page1.rtdv035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv035
            
            #add-point:AFTER FIELD rtdv035 name="construct.a.page1.rtdv035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv035
            #add-point:ON ACTION controlp INFIELD rtdv035 name="construct.c.page1.rtdv035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv036
            #add-point:BEFORE FIELD rtdv036 name="construct.b.page1.rtdv036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv036
            
            #add-point:AFTER FIELD rtdv036 name="construct.a.page1.rtdv036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv036
            #add-point:ON ACTION controlp INFIELD rtdv036 name="construct.c.page1.rtdv036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv037
            #add-point:BEFORE FIELD rtdv037 name="construct.b.page1.rtdv037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv037
            
            #add-point:AFTER FIELD rtdv037 name="construct.a.page1.rtdv037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv037
            #add-point:ON ACTION controlp INFIELD rtdv037 name="construct.c.page1.rtdv037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv038
            #add-point:BEFORE FIELD rtdv038 name="construct.b.page1.rtdv038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv038
            
            #add-point:AFTER FIELD rtdv038 name="construct.a.page1.rtdv038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv038
            #add-point:ON ACTION controlp INFIELD rtdv038 name="construct.c.page1.rtdv038"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdv032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv032
            #add-point:ON ACTION controlp INFIELD rtdv032 name="construct.c.page1.rtdv032"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdv032  #顯示到畫面上
            NEXT FIELD rtdv032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv032
            #add-point:BEFORE FIELD rtdv032 name="construct.b.page1.rtdv032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv032
            
            #add-point:AFTER FIELD rtdv032 name="construct.a.page1.rtdv032"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv027
            #add-point:BEFORE FIELD rtdv027 name="construct.b.page1.rtdv027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv027
            
            #add-point:AFTER FIELD rtdv027 name="construct.a.page1.rtdv027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv027
            #add-point:ON ACTION controlp INFIELD rtdv027 name="construct.c.page1.rtdv027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv028
            #add-point:BEFORE FIELD rtdv028 name="construct.b.page1.rtdv028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv028
            
            #add-point:AFTER FIELD rtdv028 name="construct.a.page1.rtdv028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdv028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv028
            #add-point:ON ACTION controlp INFIELD rtdv028 name="construct.c.page1.rtdv028"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON rtdw001,rtdw002
           FROM s_detail2[1].rtdw001,s_detail2[1].rtdw002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.rtdw001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdw001
            #add-point:ON ACTION controlp INFIELD rtdw001 name="construct.c.page2.rtdw001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'                  
            LET g_qryparam.reqry = FALSE
            
            CALL q_rtab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdw001  #顯示到畫面上

            NEXT FIELD rtdw001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdw001
            #add-point:BEFORE FIELD rtdw001 name="construct.b.page2.rtdw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdw001
            
            #add-point:AFTER FIELD rtdw001 name="construct.a.page2.rtdw001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdw002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdw002
            #add-point:ON ACTION controlp INFIELD rtdw002 name="construct.c.page2.rtdw002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdw002  #顯示到畫面上
            NEXT FIELD rtdw002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdw002
            #add-point:BEFORE FIELD rtdw002 name="construct.b.page2.rtdw002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdw002
            
            #add-point:AFTER FIELD rtdw002 name="construct.a.page2.rtdw002"
            
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
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "rtdu_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtdv_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtdw_t" 
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
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION artt405_filter()
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
      CONSTRUCT g_wc_filter ON rtdusite,rtdudocno,rtdudocdt,rtdu001,rtdu002,rtdu003,rtdu004,rtdu005, 
          rtdu006,rtdu007,rtdu008,rtdu010
                          FROM s_browse[1].b_rtdusite,s_browse[1].b_rtdudocno,s_browse[1].b_rtdudocdt, 
                              s_browse[1].b_rtdu001,s_browse[1].b_rtdu002,s_browse[1].b_rtdu003,s_browse[1].b_rtdu004, 
                              s_browse[1].b_rtdu005,s_browse[1].b_rtdu006,s_browse[1].b_rtdu007,s_browse[1].b_rtdu008, 
                              s_browse[1].b_rtdu010
 
         BEFORE CONSTRUCT
               DISPLAY artt405_filter_parser('rtdusite') TO s_browse[1].b_rtdusite
            DISPLAY artt405_filter_parser('rtdudocno') TO s_browse[1].b_rtdudocno
            DISPLAY artt405_filter_parser('rtdudocdt') TO s_browse[1].b_rtdudocdt
            DISPLAY artt405_filter_parser('rtdu001') TO s_browse[1].b_rtdu001
            DISPLAY artt405_filter_parser('rtdu002') TO s_browse[1].b_rtdu002
            DISPLAY artt405_filter_parser('rtdu003') TO s_browse[1].b_rtdu003
            DISPLAY artt405_filter_parser('rtdu004') TO s_browse[1].b_rtdu004
            DISPLAY artt405_filter_parser('rtdu005') TO s_browse[1].b_rtdu005
            DISPLAY artt405_filter_parser('rtdu006') TO s_browse[1].b_rtdu006
            DISPLAY artt405_filter_parser('rtdu007') TO s_browse[1].b_rtdu007
            DISPLAY artt405_filter_parser('rtdu008') TO s_browse[1].b_rtdu008
            DISPLAY artt405_filter_parser('rtdu010') TO s_browse[1].b_rtdu010
      
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
 
      CALL artt405_filter_show('rtdusite')
   CALL artt405_filter_show('rtdudocno')
   CALL artt405_filter_show('rtdudocdt')
   CALL artt405_filter_show('rtdu001')
   CALL artt405_filter_show('rtdu002')
   CALL artt405_filter_show('rtdu003')
   CALL artt405_filter_show('rtdu004')
   CALL artt405_filter_show('rtdu005')
   CALL artt405_filter_show('rtdu006')
   CALL artt405_filter_show('rtdu007')
   CALL artt405_filter_show('rtdu008')
   CALL artt405_filter_show('rtdu010')
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION artt405_filter_parser(ps_field)
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
 
{<section id="artt405.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION artt405_filter_show(ps_field)
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
   LET ls_condition = artt405_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION artt405_query()
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
   CALL g_rtdv_d.clear()
   CALL g_rtdv2_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL cl_set_comp_visible("rtdv039",TRUE)  
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL artt405_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL artt405_browser_fill("")
      CALL artt405_fetch("")
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
      CALL artt405_filter_show('rtdusite')
   CALL artt405_filter_show('rtdudocno')
   CALL artt405_filter_show('rtdudocdt')
   CALL artt405_filter_show('rtdu001')
   CALL artt405_filter_show('rtdu002')
   CALL artt405_filter_show('rtdu003')
   CALL artt405_filter_show('rtdu004')
   CALL artt405_filter_show('rtdu005')
   CALL artt405_filter_show('rtdu006')
   CALL artt405_filter_show('rtdu007')
   CALL artt405_filter_show('rtdu008')
   CALL artt405_filter_show('rtdu010')
   CALL artt405_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL artt405_fetch("F") 
      #顯示單身筆數
      CALL artt405_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION artt405_fetch(p_flag)
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
   
   LET g_rtdu_m.rtdudocno = g_browser[g_current_idx].b_rtdudocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE artt405_master_referesh USING g_rtdu_m.rtdudocno INTO g_rtdu_m.rtdusite,g_rtdu_m.rtdudocdt, 
       g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000,g_rtdu_m.rtdu001,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004, 
       g_rtdu_m.rtduunit,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008, 
       g_rtdu_m.rtdu011,g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduowndp, 
       g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumoddt, 
       g_rtdu_m.rtducnfid,g_rtdu_m.rtducnfdt,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu004_desc, 
       g_rtdu_m.rtdu005_desc,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008_desc,g_rtdu_m.rtduownid_desc, 
       g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp_desc,g_rtdu_m.rtdumodid_desc, 
       g_rtdu_m.rtducnfid_desc
   
   #遮罩相關處理
   LET g_rtdu_m_mask_o.* =  g_rtdu_m.*
   CALL artt405_rtdu_t_mask()
   LET g_rtdu_m_mask_n.* =  g_rtdu_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt405_set_act_visible()   
   CALL artt405_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_rtdu_m.rtdustus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   END IF     
   CALL artt405_set_act_visible_b()   
   CALL artt405_set_act_no_visible_b()  
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtdu_m_t.* = g_rtdu_m.*
   LET g_rtdu_m_o.* = g_rtdu_m.*
   
   LET g_data_owner = g_rtdu_m.rtduownid      
   LET g_data_dept  = g_rtdu_m.rtduowndp
   
   #重新顯示   
   CALL artt405_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.insert" >}
#+ 資料新增
PRIVATE FUNCTION artt405_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success     LIKE type_t.num5 #sakura add
   DEFINE l_insert      LIKE type_t.num5 #sakura add  
   #141208-00001#14 Add By Ken(S)
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   #141208-00001#14 Add By Ken(E)
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rtdv_d.clear()   
   CALL g_rtdv2_d.clear()  
 
 
   INITIALIZE g_rtdu_m.* TO NULL             #DEFAULT 設定
   
   LET g_rtdudocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtdu_m.rtduownid = g_user
      LET g_rtdu_m.rtduowndp = g_dept
      LET g_rtdu_m.rtducrtid = g_user
      LET g_rtdu_m.rtducrtdp = g_dept 
      LET g_rtdu_m.rtducrtdt = cl_get_current()
      LET g_rtdu_m.rtdumodid = g_user
      LET g_rtdu_m.rtdumoddt = cl_get_current()
      LET g_rtdu_m.rtdustus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_rtdu_m.rtdu000 = "I"
      LET g_rtdu_m.rtdu012 = "0"
      LET g_rtdu_m.sum_rtdv019 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_rtdu_m_t.* TO NULL
      LET g_rtdu_m.rtdudocdt = g_today
     #sakura---add---str
     #LET g_rtdu_m.rtdu009 = g_site
     #INITIALIZE g_ref_fields TO NULL
     #LET g_ref_fields[1] = g_rtdu_m.rtdu009
     #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     #LET g_rtdu_m.rtdu009_desc = '', g_rtn_fields[1] , ''
     #DISPLAY BY NAME g_rtdu_m.rtdu009_desc
     #LET g_rtdu_m.rtdustus = "N"
     #sakura---mark---str      
      #sakura---add---str
      #LET g_rtdu_m.rtduunit = g_site
     #LET g_site_flag = FALSE #sakura mark
      
      #CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
      #   RETURNING l_success,g_rtdu_m.rtdudocno
      #   
      #CALL s_aooi500_default(g_prog,g_site,g_rtdu_m.rtduunit)
      #   RETURNING l_insert,g_rtdu_m.rtduunit
      #   
      #IF NOT l_insert THEN
      #   RETURN
      #END IF
      #CALL s_desc_get_department_desc(g_rtdu_m.rtduunit) RETURNING g_rtdu_m.rtduunit_desc
      #DISPLAY BY NAME g_rtdu_m.rtduunit_desc
      #sakura---add---str
      
      #141208-00001#14 Add By Ken(S)
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'rtdusite',g_rtdu_m.rtdusite)
         RETURNING l_insert,g_rtdu_m.rtdusite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_rtdu_m.rtduunit = g_rtdu_m.rtdusite
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_rtdu_m.rtdusite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_rtdu_m.rtdudocno = r_doctype
      
      CALL s_desc_get_department_desc(g_rtdu_m.rtdusite) RETURNING g_rtdu_m.rtdusite_desc
      DISPLAY BY NAME g_rtdu_m.rtdusite_desc 
      LET g_rtdu_m_t.*= g_rtdu_m.*
#      LET g_rtdu_m.rtdu009 = s_default_rtda001(g_prog)  #生命周期栏位赋值
      LET g_rtdu_m.rtdu009 = s_life_cycle_default(g_prog,'1') #生命周期栏位赋值
      #税区别赋值
      SELECT ooef019 INTO g_rtdu_m.rtdu011
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_rtdu_m.rtdusite
         
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_rtdu_m.rtdu011
       CALL ap_ref_array2(g_ref_fields,"SELECT DISTINCT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001 = '2' AND ooall003='"||g_dlang||"' AND ooall002=?","") RETURNING g_rtn_fields
       LET g_rtdu_m.rtdu011_desc = g_rtn_fields[1]
       DISPLAY BY NAME g_rtdu_m.rtdu011_desc 
        
      #141208-00001#14 Add By Ken(E)
      LET g_rtdu_m.rtdu006 = g_user #geza  add #150512-00031#1
      
      CALL s_desc_get_person_desc(g_rtdu_m.rtdu006) RETURNING g_rtdu_m.rtdu006_desc
      DISPLAY BY NAME g_rtdu_m.rtdu006_desc  
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rtdu_m_t.* = g_rtdu_m.*
      LET g_rtdu_m_o.* = g_rtdu_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtdu_m.rtdustus 
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
 
 
 
    
      CALL artt405_input("a")
      
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
         INITIALIZE g_rtdu_m.* TO NULL
         INITIALIZE g_rtdv_d TO NULL
         INITIALIZE g_rtdv2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL artt405_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rtdv_d.clear()
      #CALL g_rtdv2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt405_set_act_visible()   
   CALL artt405_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtdudocno_t = g_rtdu_m.rtdudocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtduent = " ||g_enterprise|| " AND",
                      " rtdudocno = '", g_rtdu_m.rtdudocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt405_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE artt405_cl
   
   CALL artt405_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE artt405_master_referesh USING g_rtdu_m.rtdudocno INTO g_rtdu_m.rtdusite,g_rtdu_m.rtdudocdt, 
       g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000,g_rtdu_m.rtdu001,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004, 
       g_rtdu_m.rtduunit,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008, 
       g_rtdu_m.rtdu011,g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduowndp, 
       g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumoddt, 
       g_rtdu_m.rtducnfid,g_rtdu_m.rtducnfdt,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu004_desc, 
       g_rtdu_m.rtdu005_desc,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008_desc,g_rtdu_m.rtduownid_desc, 
       g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp_desc,g_rtdu_m.rtdumodid_desc, 
       g_rtdu_m.rtducnfid_desc
   
   
   #遮罩相關處理
   LET g_rtdu_m_mask_o.* =  g_rtdu_m.*
   CALL artt405_rtdu_t_mask()
   LET g_rtdu_m_mask_n.* =  g_rtdu_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtdu_m.rtdusite,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdudocdt,g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000, 
       g_rtdu_m.rtdu001,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtdu004_desc, 
       g_rtdu_m.rtduunit,g_rtdu_m.stan017,g_rtdu_m.stan018,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu005_desc, 
       g_rtdu_m.rtdu006,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008, 
       g_rtdu_m.rtdu008_desc,g_rtdu_m.rtdu011,g_rtdu_m.rtdu011_desc,g_rtdu_m.sum_rtdv020,g_rtdu_m.sum_rtdv019, 
       g_rtdu_m.l_stan006,g_rtdu_m.l_stan006_desc,g_rtdu_m.l_stan007,g_rtdu_m.l_stan007_desc,g_rtdu_m.rtdu009, 
       g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduownid_desc,g_rtdu_m.rtduowndp, 
       g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdp_desc, 
       g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumodid_desc,g_rtdu_m.rtdumoddt,g_rtdu_m.rtducnfid, 
       g_rtdu_m.rtducnfid_desc,g_rtdu_m.rtducnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rtdu_m.rtduownid      
   LET g_data_dept  = g_rtdu_m.rtduowndp
   
   #功能已完成,通報訊息中心
   CALL artt405_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="artt405.modify" >}
#+ 資料修改
PRIVATE FUNCTION artt405_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_rtdu_m.rtdustus MATCHES "[DR]" THEN 
      LET g_rtdu_m.rtdustus = "N"
   END IF            
      IF g_rtdu_m.rtdustus<>'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "apm-00035"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtdu_m_t.* = g_rtdu_m.*
   LET g_rtdu_m_o.* = g_rtdu_m.*
   
   IF g_rtdu_m.rtdudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rtdudocno_t = g_rtdu_m.rtdudocno
 
   CALL s_transaction_begin()
   
   OPEN artt405_cl USING g_enterprise,g_rtdu_m.rtdudocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt405_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt405_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt405_master_referesh USING g_rtdu_m.rtdudocno INTO g_rtdu_m.rtdusite,g_rtdu_m.rtdudocdt, 
       g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000,g_rtdu_m.rtdu001,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004, 
       g_rtdu_m.rtduunit,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008, 
       g_rtdu_m.rtdu011,g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduowndp, 
       g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumoddt, 
       g_rtdu_m.rtducnfid,g_rtdu_m.rtducnfdt,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu004_desc, 
       g_rtdu_m.rtdu005_desc,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008_desc,g_rtdu_m.rtduownid_desc, 
       g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp_desc,g_rtdu_m.rtdumodid_desc, 
       g_rtdu_m.rtducnfid_desc
   
   #檢查是否允許此動作
   IF NOT artt405_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtdu_m_mask_o.* =  g_rtdu_m.*
   CALL artt405_rtdu_t_mask()
   LET g_rtdu_m_mask_n.* =  g_rtdu_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL artt405_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_rtdudocno_t = g_rtdu_m.rtdudocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rtdu_m.rtdumodid = g_user 
LET g_rtdu_m.rtdumoddt = cl_get_current()
LET g_rtdu_m.rtdumodid_desc = cl_get_username(g_rtdu_m.rtdumodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_rtdu_m.rtdustus MATCHES "[DR]" THEN 
         LET g_rtdu_m.rtdustus = "N"
      END IF       
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL artt405_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rtdu_t SET (rtdumodid,rtdumoddt) = (g_rtdu_m.rtdumodid,g_rtdu_m.rtdumoddt)
          WHERE rtduent = g_enterprise AND rtdudocno = g_rtdudocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rtdu_m.* = g_rtdu_m_t.*
            CALL artt405_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rtdu_m.rtdudocno != g_rtdu_m_t.rtdudocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE rtdv_t SET rtdvdocno = g_rtdu_m.rtdudocno
 
          WHERE rtdvent = g_enterprise AND rtdvdocno = g_rtdu_m_t.rtdudocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtdv_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtdv_t:",SQLERRMESSAGE 
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
         
         UPDATE rtdw_t
            SET rtdwdocno = g_rtdu_m.rtdudocno
 
          WHERE rtdwent = g_enterprise AND
                rtdwdocno = g_rtdudocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtdw_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtdw_t:",SQLERRMESSAGE 
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
   CALL artt405_set_act_visible()   
   CALL artt405_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rtduent = " ||g_enterprise|| " AND",
                      " rtdudocno = '", g_rtdu_m.rtdudocno, "' "
 
   #填到對應位置
   CALL artt405_browser_fill("")
 
   CLOSE artt405_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt405_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="artt405.input" >}
#+ 資料輸入
PRIVATE FUNCTION artt405_input(p_cmd)
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
   DEFINE  l_count1        LIKE type_t.num5
   DEFINE  l_i1            LIKE type_t.num5
   DEFINE  l_rtdw001       LIKE rtdw_t.rtdw001 
   DEFINE  tok             base.stringtokenizer
   DEFINE  l_detail_cnt    LIKE type_t.num5
   DEFINE  l_success       LIKE type_t.num5 
   #DEFINE  l_ac_t          LIKE type_t.num5   #150915-00001#1 150915 by sakura mark
   DEFINE  l_ac_t1          LIKE type_t.num5   #150915-00001#1 150915 by sakura add
   DEFINE  l_errno         LIKE type_t.chr10
   DEFINE  l_rtdv018       LIKE rtdv_t.rtdv018
   DEFINE  l_ooef019       LIKE ooef_t.ooef019
   DEFINE  l_ooef123       LIKE ooef_t.ooef123   #150515-00006#1 150516 by lori522612 mark
   DEFINE  l_where         STRING                #150505-00012#1--add by dongsz
   DEFINE  l_cost          LIKE stao_t.stao012  
   DEFINE  l_sql           STRING                #151113-00003#10 Add By Ken 151127    
   DEFINE  l_sql_tmp       STRING                ##160324-00019#1 Add By Ken 160330
   DEFINE  l_rtdv018_chk   LIKE type_t.chr1      #20151202 dongsz add
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
   DISPLAY BY NAME g_rtdu_m.rtdusite,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdudocdt,g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000, 
       g_rtdu_m.rtdu001,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtdu004_desc, 
       g_rtdu_m.rtduunit,g_rtdu_m.stan017,g_rtdu_m.stan018,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu005_desc, 
       g_rtdu_m.rtdu006,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008, 
       g_rtdu_m.rtdu008_desc,g_rtdu_m.rtdu011,g_rtdu_m.rtdu011_desc,g_rtdu_m.sum_rtdv020,g_rtdu_m.sum_rtdv019, 
       g_rtdu_m.l_stan006,g_rtdu_m.l_stan006_desc,g_rtdu_m.l_stan007,g_rtdu_m.l_stan007_desc,g_rtdu_m.rtdu009, 
       g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduownid_desc,g_rtdu_m.rtduowndp, 
       g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdp_desc, 
       g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumodid_desc,g_rtdu_m.rtdumoddt,g_rtdu_m.rtducnfid, 
       g_rtdu_m.rtducnfid_desc,g_rtdu_m.rtducnfdt
   
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
   LET g_forupd_sql = "SELECT rtdvseq,rtdv002,rtdv001,rtdv018,rtdv023,rtdv101,rtdv024,rtdv025,rtdv026, 
       rtdv102,rtdv103,rtdv020,rtdv021,rtdv022,rtdv004,rtdv006,rtdv008,rtdv012,rtdv009,rtdv011,rtdv033, 
       rtdv017,rtdv019,rtdv031,rtdv029,rtdv040,rtdv039,rtdv003,rtdv010,rtdv013,rtdv014,rtdv015,rtdv016, 
       rtdv034,rtdv035,rtdv036,rtdv037,rtdv038,rtdv032,rtdv027,rtdv028 FROM rtdv_t WHERE rtdvent=? AND  
       rtdvdocno=? AND rtdvseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt405_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT rtdw001,rtdw002 FROM rtdw_t WHERE rtdwent=? AND rtdwdocno=? AND rtdw001=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt405_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL artt405_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #151113-00003#1 Add By Ken 151116(S)
   CALL artt405_set_no_required(p_cmd)
   CALL artt405_set_required(p_cmd)
   #151113-00003#1 Add By Ken 151116(E)
   #end add-point
   CALL artt405_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rtdu_m.rtdusite,g_rtdu_m.rtdudocdt,g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000,g_rtdu_m.rtdu001, 
       g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtduunit,g_rtdu_m.stan017,g_rtdu_m.stan018, 
       g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008,g_rtdu_m.rtdu011, 
       g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   SELECT ooef004 
     INTO g_ooef004 
     FROM ooef_t 
    WHERE ooefent = g_enterprise 
      AND ooef001 = g_site 
      
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="artt405.input.head" >}
      #單頭段
      INPUT BY NAME g_rtdu_m.rtdusite,g_rtdu_m.rtdudocdt,g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000,g_rtdu_m.rtdu001, 
          g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtduunit,g_rtdu_m.stan017,g_rtdu_m.stan018, 
          g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008,g_rtdu_m.rtdu011, 
          g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN artt405_cl USING g_enterprise,g_rtdu_m.rtdudocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt405_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt405_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL artt405_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            #151113-00003#1 Add By Ken 151116(S)
            CALL artt405_set_no_required(p_cmd)
            CALL artt405_set_required(p_cmd)
            #151113-00003#1 Add By Ken 151116(E)            
            #end add-point
            CALL artt405_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdusite
            
            #add-point:AFTER FIELD rtdusite name="input.a.rtdusite"
            #ken---add---str 需求單號：141208-00001 項次：14
            IF NOT cl_null(g_rtdu_m.rtdusite) THEN
               CALL s_aooi500_chk(g_prog,'rtdusite',g_rtdu_m.rtdusite,g_rtdu_m.rtdusite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
            
                  LET g_rtdu_m.rtdusite = g_rtdu_m_t.rtdusite
                  CALL s_desc_get_department_desc(g_rtdu_m.rtdusite)
                     RETURNING g_rtdu_m.rtdusite_desc
                  DISPLAY BY NAME g_rtdu_m.rtdusite,g_rtdu_m.rtdusite_desc
                  NEXT FIELD CURRENT
               END IF
            #sakura---add---str---141009-00031#17
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET g_rtdu_m.rtdusite = g_rtdu_m_t.rtdusite
               CALL s_desc_get_department_desc(g_rtdu_m.rtdusite)
                  RETURNING g_rtdu_m.rtdusite_desc
               DISPLAY BY NAME g_rtdu_m.rtdusite,g_rtdu_m.rtdusite_desc
               NEXT FIELD CURRENT            
            #sakura---add---end---141009-00031#17
            END IF              
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_rtdu_m.rtdusite)
               RETURNING g_rtdu_m.rtdusite_desc
            DISPLAY BY NAME g_rtdu_m.rtdusite,g_rtdu_m.rtdusite_desc
            CALL artt405_set_entry(p_cmd)
            CALL artt405_set_no_entry(p_cmd)            
            #ken---add---end

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdusite
            #add-point:BEFORE FIELD rtdusite name="input.b.rtdusite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdusite
            #add-point:ON CHANGE rtdusite name="input.g.rtdusite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdudocdt
            #add-point:BEFORE FIELD rtdudocdt name="input.b.rtdudocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdudocdt
            
            #add-point:AFTER FIELD rtdudocdt name="input.a.rtdudocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdudocdt
            #add-point:ON CHANGE rtdudocdt name="input.g.rtdudocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdudocno
            #add-point:BEFORE FIELD rtdudocno name="input.b.rtdudocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdudocno
            
            #add-point:AFTER FIELD rtdudocno name="input.a.rtdudocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rtdu_m.rtdudocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_rtdu_m.rtdudocno != g_rtdudocno_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdu_t WHERE "||"rtduent = '" ||g_enterprise|| "' AND "||"rtdudocno = '"||g_rtdu_m.rtdudocno ||"'",'std-00004',0) THEN 
                     LET g_rtdu_m.rtdudocno = g_rtdu_m_t.rtdudocno
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi200_chk_slip(g_rtdu_m.rtdusite,g_ooef004,g_rtdu_m.rtdudocno,g_prog) RETURNING l_success #sakura add
                  IF NOT l_success THEN
                     LET g_rtdu_m.rtdudocno = g_rtdu_m_t.rtdudocno
                     NEXT FIELD rtdudocno
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdudocno
            #add-point:ON CHANGE rtdudocno name="input.g.rtdudocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu000
            #add-point:BEFORE FIELD rtdu000 name="input.b.rtdu000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu000
            
            #add-point:AFTER FIELD rtdu000 name="input.a.rtdu000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu000
            #add-point:ON CHANGE rtdu000 name="input.g.rtdu000"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu001
            
            #add-point:AFTER FIELD rtdu001 name="input.a.rtdu001"
            LET g_rtdu_m.rtdu001_desc = NULL
            DISPLAY BY NAME g_rtdu_m.rtdu001_desc
            IF  NOT cl_null(g_rtdu_m.rtdu001) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_rtdu_m.rtdu001 != g_rtdu_m_t.rtdu001 or g_rtdu_m_t.rtdu001 is null ))) THEN    #160824-00007#21 Mark By ken 160926
               IF g_rtdu_m.rtdu001 != g_rtdu_m_o.rtdu001 OR g_rtdu_m_o.rtdu001 IS NULL THEN   #160824-00007#21 Add By ken 160926
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtdu_m.rtdu001
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pmaa001_4") THEN
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_rtdu_m.rtdu001 = g_rtdu_m_t.rtdu001    #160824-00007#21 Mark By ken 160926
                     LET g_rtdu_m.rtdu001 = g_rtdu_m_o.rtdu001     #160824-00007#21 Add By ken 160926
                     CALL s_desc_get_trading_partner_full_desc(g_rtdu_m.rtdu001)
                        RETURNING g_rtdu_m.rtdu001_desc
                     DISPLAY BY NAME g_rtdu_m.rtdu001_desc
                     NEXT FIELD rtdu001
                  END IF
                  CALL artt405_chk_rtdu001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtdu_m.rtdu001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtdu_m.rtdu001 = g_rtdu_m_t.rtdu001    #160824-00007#21 Mark By ken 160926
                     LET g_rtdu_m.rtdu001 = g_rtdu_m_o.rtdu001     #160824-00007#21 Add By ken 160926                     
                     CALL s_desc_get_trading_partner_full_desc(g_rtdu_m.rtdu001)
                        RETURNING g_rtdu_m.rtdu001_desc
                     DISPLAY BY NAME g_rtdu_m.rtdu001_desc
                     NEXT FIELD rtdu001
                  END IF
                  #判断供应商对应的合同编号正确性并带值  2015/04/22 geza add (S)
                  LET l_cnt = 0
                  SELECT COUNT(*)
                    INTO l_cnt 
                    FROM stan_t
                   WHERE stanent = g_enterprise
                     AND stan005 = g_rtdu_m.rtdu001 
                     AND stanstus = 'Y'
                  IF l_cnt = 1  THEN
                     SELECT stan001
                       INTO g_rtdu_m.rtdu002
                       FROM stan_t
                      WHERE stanent = g_enterprise 
                        AND stan005 = g_rtdu_m.rtdu001
                        AND stanstus = 'Y'  #150831-00003#1 20150831 s983961--ADD
                       CALL artt405_rtdu002()
                       IF NOT cl_null(g_errno) THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.replace[1] = g_rtdu_m.rtdu001   #150831-00003#1 20150831 s983961--ADD
                          LET g_errparam.replace[2] = g_rtdu_m.rtdu002   #150831-00003#1 20150831 s983961--ADD
                          LET g_errparam.code = g_errno
                          #LET g_errparam.extend = g_rtdu_m.rtdu002 #150831-00003#1 20150831 s983961--MARK
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                       
                          #LET g_rtdu_m.rtdu001 = g_rtdu_m_t.rtdu001  #160824-00007#21 Mark By ken 160926
                          #LET g_rtdu_m.rtdu002 = g_rtdu_m_t.rtdu002  #160824-00007#21 Mark By ken 160926
                          LET g_rtdu_m.rtdu001 = g_rtdu_m_o.rtdu001   #160824-00007#21 Add By ken 160926 
                          LET g_rtdu_m.rtdu002 = g_rtdu_m_o.rtdu002   #160824-00007#21 Add By ken 160926                     
                          NEXT FIELD CURRENT
                       END IF
                      
                       #150213-00006#3 2015/02/13 By pomelo add(S)
                       IF NOT cl_null(g_rtdu_m.rtdu008) THEN
                          IF NOT artt405_chk_rtdu008() THEN
                             #LET g_rtdu_m.rtdu001 = g_rtdu_m_t.rtdu001  #160824-00007#21 Mark By ken 160926
                             #LET g_rtdu_m.rtdu002 = g_rtdu_m_t.rtdu002  #160824-00007#21 Mark By ken 160926
                             LET g_rtdu_m.rtdu001 = g_rtdu_m_o.rtdu001   #160824-00007#21 Add By ken 160926 
                             LET g_rtdu_m.rtdu002 = g_rtdu_m_o.rtdu002   #160824-00007#21 Add By ken 160926                             
                             CALL artt405_rtdu008_display()
                             NEXT FIELD CURRENT
                          END IF
                       END IF
                       CALL artt405_rtdu001_init(g_rtdu_m.rtdu001)
                     
                  END IF
                  #判断供应商对应的合同编号正确性并带值  2015/04/22 geza add (Es)                  
               END IF
            END IF
            CALL s_desc_get_trading_partner_full_desc(g_rtdu_m.rtdu001)
               RETURNING g_rtdu_m.rtdu001_desc
            DISPLAY BY NAME g_rtdu_m.rtdu001_desc
            LET g_rtdu_m_o.* = g_rtdu_m.*       #160824-00007#21 Add By ken 160926             


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu001
            #add-point:BEFORE FIELD rtdu001 name="input.b.rtdu001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu001
            #add-point:ON CHANGE rtdu001 name="input.g.rtdu001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu002
            #add-point:BEFORE FIELD rtdu002 name="input.b.rtdu002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu002
            
            #add-point:AFTER FIELD rtdu002 name="input.a.rtdu002"
            LET g_rtdu_m.rtdu003 = NULL
            LET g_rtdu_m.rtdu004 = NULL
            LET g_rtdu_m.rtdu005 = NULL
            LET g_rtdu_m.rtdu004_desc = NULL
            LET g_rtdu_m.rtdu005_desc = NULL
            LET g_rtdu_m.stan017 = NULL
            LET g_rtdu_m.stan018 = NULL
            LET g_rtdu_m.l_stan006 = NULL #sakura add
            LET g_rtdu_m.l_stan006_desc = NULL #sakura add  
            #150213-00006#3 2015/02/13 By pomelo add(S)
            LET g_rtdu_m.l_stan007 = NULL    
            LET g_rtdu_m.l_stan007_desc = NULL   
            DISPLAY BY NAME g_rtdu_m.l_stan007,g_rtdu_m.l_stan007_desc   
            #150213-00006#3 2015/02/13 By pomelo add(E)
            DISPLAY BY NAME  g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtdu005,g_rtdu_m.stan017,g_rtdu_m.stan018
                            ,g_rtdu_m.l_stan006,g_rtdu_m.l_stan006_desc #sakura add    
            IF  NOT cl_null(g_rtdu_m.rtdu002) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_rtdu_m.rtdu002 != g_rtdu_m_t.rtdu002 or g_rtdu_m_t.rtdu002 is null ))) THEN  
               IF g_rtdu_m.rtdu002 != g_rtdu_m_o.rtdu002 OR g_rtdu_m_o.rtdu002 IS NULL THEN  
                  CALL artt405_rtdu002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.replace[1] = g_rtdu_m.rtdu001   #150831-00003#1 20150831 s983961--ADD
                     LET g_errparam.replace[2] = g_rtdu_m.rtdu002   #150831-00003#1 20150831 s983961--ADD
                     LET g_errparam.code = g_errno
                     #LET g_errparam.extend = g_rtdu_m.rtdu002    #150831-00003#1 20150831 s983961--MARK
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtdu_m.rtdu002 = g_rtdu_m_t.rtdu002  #160824-00007#21 Mark By ken 160926
                     LET g_rtdu_m.rtdu002 = g_rtdu_m_o.rtdu002   #160824-00007#21 Add By ken 160926
                     CALL artt405_rtdu002_display(g_rtdu_m.rtdu002)
                     NEXT FIELD rtdu002
                  END IF
                  CALL artt405_chk_rtdu001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtdu_m.rtdu002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtdu_m.rtdu002 = g_rtdu_m_t.rtdu002  #160824-00007#21 Mark By ken 160926
                     LET g_rtdu_m.rtdu002 = g_rtdu_m_o.rtdu002   #160824-00007#21 Add By ken 160926                     
                     CALL artt405_rtdu002_display(g_rtdu_m.rtdu002)
                     NEXT FIELD rtdu002
                  END IF
                  #150213-00006#3 2015/02/13 By pomelo add(S)
                  IF NOT cl_null(g_rtdu_m.rtdu008) THEN
                     IF NOT artt405_chk_rtdu008() THEN
                        #LET g_rtdu_m.rtdu002 = g_rtdu_m_t.rtdu002  #160824-00007#21 Mark By ken 160926
                        LET g_rtdu_m.rtdu002 = g_rtdu_m_o.rtdu002   #160824-00007#21 Add By ken 160926                        
                        CALL artt405_rtdu008_display()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #150213-00006#3 2015/02/13 By pomelo add(E)
               END IF
            END IF
            CALL artt405_rtdu002_display(g_rtdu_m.rtdu002)
            LET g_rtdu_m_o.* = g_rtdu_m.*       #160824-00007#21 Add By ken 160926 
            CALL artt405_set_act_visible_b()   
            CALL artt405_set_act_no_visible_b()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu002
            #add-point:ON CHANGE rtdu002 name="input.g.rtdu002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu003
            #add-point:BEFORE FIELD rtdu003 name="input.b.rtdu003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu003
            
            #add-point:AFTER FIELD rtdu003 name="input.a.rtdu003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu003
            #add-point:ON CHANGE rtdu003 name="input.g.rtdu003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu004
            
            #add-point:AFTER FIELD rtdu004 name="input.a.rtdu004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdu_m.rtdu004
            CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtdu_m.rtdu004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtdu_m.rtdu004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu004
            #add-point:BEFORE FIELD rtdu004 name="input.b.rtdu004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu004
            #add-point:ON CHANGE rtdu004 name="input.g.rtdu004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtduunit
            #add-point:BEFORE FIELD rtduunit name="input.b.rtduunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtduunit
            
            #add-point:AFTER FIELD rtduunit name="input.a.rtduunit"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtduunit
            #add-point:ON CHANGE rtduunit name="input.g.rtduunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stan017
            #add-point:BEFORE FIELD stan017 name="input.b.stan017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stan017
            
            #add-point:AFTER FIELD stan017 name="input.a.stan017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stan017
            #add-point:ON CHANGE stan017 name="input.g.stan017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stan018
            #add-point:BEFORE FIELD stan018 name="input.b.stan018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stan018
            
            #add-point:AFTER FIELD stan018 name="input.a.stan018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stan018
            #add-point:ON CHANGE stan018 name="input.g.stan018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu012
            #add-point:BEFORE FIELD rtdu012 name="input.b.rtdu012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu012
            
            #add-point:AFTER FIELD rtdu012 name="input.a.rtdu012"
            #151113-00003#1 Add By Ken 151116(S)
            CALL artt405_set_entry(p_cmd)  
            CALL artt405_set_no_required(p_cmd)
            CALL artt405_set_required(p_cmd)
            CALL artt405_set_no_entry(p_cmd) 
            #151113-00003#1 Add By Ken 151116(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu012
            #add-point:ON CHANGE rtdu012 name="input.g.rtdu012"
            #151113-00003#1 Add By Ken 151116(S)
            CALL artt405_set_entry(p_cmd)  
            CALL artt405_set_no_required(p_cmd)
            CALL artt405_set_required(p_cmd)
            CALL artt405_set_no_entry(p_cmd) 
            #151113-00003#1 Add By Ken 151116(E)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu005
            
            #add-point:AFTER FIELD rtdu005 name="input.a.rtdu005"
#應用 a17 樣板自動產生(Version:2)
            LET g_rtdu_m.rtdu005_desc = null
            DISPLAY BY NAME g_rtdu_m.rtdu005_desc
            
            IF NOT cl_null(g_rtdu_m.rtdu005) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_rtdu_m.rtdu005 != g_rtdu_m_t.rtdu005 OR g_rtdu_m_t.rtdu005 IS NULL))) THEN     #160824-00007#21 Mark By ken 160926
               IF g_rtdu_m.rtdu005 != g_rtdu_m_o.rtdu005 OR g_rtdu_m_t.rtdu005 IS NULL THEN       #160824-00007#21 Add By ken 160926
                  IF s_aooi500_setpoint(g_prog,'rtdu005') THEN
                     CALL s_aooi500_chk(g_prog,'rtdu005',g_rtdu_m.rtdu005,g_rtdu_m.rtduunit) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_rtdu_m.rtdu005
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                     
                        #LET g_rtdu_m.rtdu005 = g_rtdu_m_t.rtdu005   #160824-00007#21 Mark By ken 160926
                        LET g_rtdu_m.rtdu005 = g_rtdu_m_o.rtdu005    #160824-00007#21 Add By ken 160926
                        CALL s_desc_get_department_desc(g_rtdu_m.rtdu005)
                           RETURNING g_rtdu_m.rtdu005_desc
                        DISPLAY BY NAME g_rtdu_m.rtdu005_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_rtdu_m.rtdu005
                     
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ooef001_34") THEN
                     
                     ELSE
                        #檢查失敗時後續處理
                        #LET g_rtdu_m.rtdu005 = g_rtdu_m_t.rtdu005   #160824-00007#21 Mark By ken 160926
                        LET g_rtdu_m.rtdu005 = g_rtdu_m_o.rtdu005    #160824-00007#21 Add By ken 160926                        
                        CALL s_desc_get_department_desc(g_rtdu_m.rtdu005)
                           RETURNING g_rtdu_m.rtdu005_desc
                        DISPLAY BY NAME g_rtdu_m.rtdu005_desc
                        NEXT FIELD rtdu005
                     END IF
                  END IF
                  #151113-00003#10 Add By Ken 151127(S) 如採購中心不在門店範圍內則新增一筆採購中心到門店範圍               
                  IF p_cmd = 'u' THEN
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt
                       FROM rtdw_t
                      WHERE rtdwent = g_enterprise
                        AND rtdwdocno = g_rtdu_m.rtdudocno
                        AND rtdw001 = g_rtdu_m.rtdu005
                     IF l_cnt = 0 THEN
                        #160324-00019#1 Add By Ken 160330(S)
                        IF g_rtdu_m.rtdu003 = '3' THEN  #經營方式為3:扣率代銷時，預設庫位為非成本庫位
                           LET l_sql_tmp = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                                       " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004,ooef126 "                        
                        ELSE                          #160324-00019#1 Add By Ken 160330 經營方式非3:扣率代銷時，預設庫位為成本庫位
                           LET l_sql_tmp = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                                       " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004,ooef123 "                        
                        END IF   
                        #160324-00019#1 Add By Ken 160330(E)   
                        LET l_sql = l_sql_tmp,
                                    "   FROM ooed_t ",
                                    "        LEFT JOIN ooef_t ON ooedent = ooefent AND ooef001 = ooed004 ", 
                                    "  WHERE ooedent = ",g_enterprise," ",
                                    "    AND ooef019 = '",g_rtdu_m.rtdu011,"' ",  #Add By Ken 150618 加上稅區需與單頭稅區別相同才預帶資料
                                    "    AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                                    "    AND ooed004 = '",g_rtdu_m.rtdu005,"' "  
                        PREPARE artt405_rtdw_pre3 FROM l_sql
                        EXECUTE artt405_rtdw_pre3  
                     END IF                                   
                  END IF
                  #151113-00003#10 Add By Ken 151127(E) 
               END IF
            END IF
            CALL s_desc_get_department_desc(g_rtdu_m.rtdu005)
               RETURNING g_rtdu_m.rtdu005_desc
            DISPLAY BY NAME g_rtdu_m.rtdu005_desc
            LET g_rtdu_m_o.* = g_rtdu_m.*   #160824-00007#21 Add By ken 160926


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu005
            #add-point:BEFORE FIELD rtdu005 name="input.b.rtdu005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu005
            #add-point:ON CHANGE rtdu005 name="input.g.rtdu005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu006
            
            #add-point:AFTER FIELD rtdu006 name="input.a.rtdu006"
            LET g_rtdu_m.rtdu006_desc = NULL
            DISPLAY BY NAME g_rtdu_m.rtdu006_desc
            IF  NOT cl_null(g_rtdu_m.rtdu006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_rtdu_m.rtdu006 != g_rtdu_m_t.rtdu006 OR g_rtdu_m_t.rtdu006 IS NULL))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtdu_m.rtdu006
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#21  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     LET g_rtdu_m.rtdu006 = g_rtdu_m_t.rtdu006
                     CALL s_desc_get_person_desc(g_rtdu_m.rtdu006) RETURNING g_rtdu_m.rtdu006_desc
                     DISPLAY BY NAME g_rtdu_m.rtdu006_desc  
                     NEXT FIELD rtdu006
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_rtdu_m.rtdu006) RETURNING g_rtdu_m.rtdu006_desc
            DISPLAY BY NAME g_rtdu_m.rtdu006_desc  


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu006
            #add-point:BEFORE FIELD rtdu006 name="input.b.rtdu006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu006
            #add-point:ON CHANGE rtdu006 name="input.g.rtdu006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu007
            
            #add-point:AFTER FIELD rtdu007 name="input.a.rtdu007"
                                                            LET g_rtdu_m.rtdu007_desc = NULL
            DISPLAY BY NAME g_rtdu_m.rtdu007_desc
            IF  NOT cl_null(g_rtdu_m.rtdu007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_rtdu_m.rtdu007!= g_rtdu_m_t.rtdu007 OR g_rtdu_m_t.rtdu007 IS NULL))) THEN                                  
                  IF s_aooi500_setpoint(g_prog,'rtdu007') THEN
                     CALL s_aooi500_chk(g_prog,'rtdu007',g_rtdu_m.rtdu007,g_rtdu_m.rtduunit) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_rtdu_m.rtdu007
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                     
                        LET g_rtdu_m.rtdu007 = g_rtdu_m_t.rtdu007
                        CALL s_desc_get_department_desc(g_rtdu_m.rtdu007)
                           RETURNING g_rtdu_m.rtdu007_desc
                        DISPLAY BY NAME g_rtdu_m.rtdu007_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_rtdu_m.rtdu007
                     
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ooef001_33") THEN
                     
                     ELSE
                        #檢查失敗時後續處理
                        LET g_rtdu_m.rtdu007 = g_rtdu_m_t.rtdu007
                        CALL s_desc_get_department_desc(g_rtdu_m.rtdu007)
                           RETURNING g_rtdu_m.rtdu007_desc
                        DISPLAY BY NAME g_rtdu_m.rtdu007_desc
                        NEXT FIELD rtdu007
                     END IF
                  END IF
                  #151113-00003#10 Add By Ken 151127(S)
                  IF p_cmd = 'u' THEN
                     SELECT COUNT(*) INTO l_cnt
                       FROM rtdw_t
                      WHERE rtdwent = g_enterprise
                        AND rtdwdocno = g_rtdu_m.rtdudocno
                        AND rtdw001 = g_rtdu_m.rtdu007
                     IF l_cnt = 0 THEN
                        IF g_rtdu_m.rtdu003 = '3' THEN  #160324-00019#1 Add By Ken 160330 經營方式為3:扣率代銷時，預設庫位為非成本庫位
                           LET l_sql = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                                       " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004,ooef126 ",
                                       "   FROM ooed_t ",
                                       "        LEFT JOIN ooef_t ON ooedent = ooefent AND ooef001 = ooed004 ", 
                                       "  WHERE ooedent = ",g_enterprise," ",
                                       "    AND ooef019 = '",g_rtdu_m.rtdu011,"' ",  
                                       "    AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                                       "    AND ooed004 = '",g_rtdu_m.rtdu007,"' "  
                           PREPARE artt405_rtdw_pre4 FROM l_sql
                           EXECUTE artt405_rtdw_pre4                         
                        ELSE                             #160324-00019#1 Add By Ken 160330 經營方式非3:扣率代銷時，預設庫位為成本庫位
                           LET l_sql = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                                       " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004,ooef123 ",
                                       "   FROM ooed_t ",
                                       "        LEFT JOIN ooef_t ON ooedent = ooefent AND ooef001 = ooed004 ", 
                                       "  WHERE ooedent = ",g_enterprise," ",
                                       "    AND ooef019 = '",g_rtdu_m.rtdu011,"' ",  
                                       "    AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                                       "    AND ooed004 = '",g_rtdu_m.rtdu007,"' "  
                           PREPARE artt405_rtdw_pre41 FROM l_sql
                           EXECUTE artt405_rtdw_pre41     
                        END IF                        
                     END IF
                  END IF   
                  #151113-00003#10 Add By Ken 151127(E)                  
               END IF
            END IF
            CALL s_desc_get_department_desc(g_rtdu_m.rtdu007)
               RETURNING g_rtdu_m.rtdu007_desc
            DISPLAY BY NAME g_rtdu_m.rtdu007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu007
            #add-point:BEFORE FIELD rtdu007 name="input.b.rtdu007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu007
            #add-point:ON CHANGE rtdu007 name="input.g.rtdu007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu008
            
            #add-point:AFTER FIELD rtdu008 name="input.a.rtdu008"
                                                            
#           LET g_rtdu_m.rtdu008_desc = NULL
#           DISPLAY BY NAME g_rtdu_m.rtdu008_desc
#           LET g_rtdu_m.rtdu011 = null
#           LET g_rtdu_m.rtdu011_desc = null
#           DISPLAY BY NAME g_rtdu_m.rtdu011
#           DISPLAY BY NAME g_rtdu_m.rtdu011_desc
            IF  NOT cl_null(g_rtdu_m.rtdu008) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_rtdu_m.rtdu008 != g_rtdu_m_t.rtdu008 or g_rtdu_m_t.rtdu008 is null ))) THEN   #160824-00007#21 Mark By ken 160926
               IF g_rtdu_m.rtdu008 != g_rtdu_m_o.rtdu008 OR g_rtdu_m_o.rtdu008 IS NULL THEN     #160824-00007#21 Add By ken 160926
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtdu_m.rtdu008
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="art-00049:sub-01302|arti201|",cl_get_progname("arti201",g_lang,"2"),"|:EXEPROGarti201"
                  #160318-00025#21  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_rtaa001") THEN
                     
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_rtdu_m.rtdu008 = g_rtdu_m_t.rtdu008  #160824-00007#21 Mark By ken 160926
                     LET g_rtdu_m.rtdu008 = g_rtdu_m_o.rtdu008   #160824-00007#21 Add By ken 160926
                     CALL artt405_rtdu008_display()
                     NEXT FIELD rtdu008
                  END IF
#                  CALL artt405_rtdu008()
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_rtdu_m.rtdu008,g_errno,1)
#                     LET g_rtdu_m.rtdu008 = g_rtdu_m_t.rtdu008
#                     CALL artt405_display_rtdu008()
#                     NEXT FIELD rtdu008
#                  END IF
                  #150213-00006#3 2015/02/13 By pomelo add(S)
                  IF NOT artt405_chk_rtdu008() THEN
                     #LET g_rtdu_m.rtdu008 = g_rtdu_m_t.rtdu008  #160824-00007#21 Mark By ken 160926
                     LET g_rtdu_m.rtdu008 = g_rtdu_m_o.rtdu008   #160824-00007#21 Add By ken 160926                     
                     CALL artt405_rtdu008_display()
                     NEXT FIELD CURRENT
                  END IF
                  #150213-00006#3 2015/02/13 By pomelo add(E)
               END IF
               CALL artt405_rtdu008_display()
            END IF
            CALL artt405_set_entry(p_cmd)
            CALL artt405_set_no_entry(p_cmd)
            LET g_rtdu_m_o.* = g_rtdu_m.*    #160824-00007#21 Add By ken 160926  


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu008
            #add-point:BEFORE FIELD rtdu008 name="input.b.rtdu008"
           IF cl_null(g_rtdu_m.rtdu002) THEN
               #合約編號為空，請先輸入合約編號！
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "art-00482"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD rtdu002
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu008
            #add-point:ON CHANGE rtdu008 name="input.g.rtdu008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu011
            
            #add-point:AFTER FIELD rtdu011 name="input.a.rtdu011"
            #判断税区别是否有效   geza 2015/03/30 
            IF NOT cl_null(g_rtdu_m.rtdu011) THEN 
               LET l_cnt = 0 
               
               SELECT COUNT(*) INTO l_cnt 
                 FROM ooef_t 
                WHERE ooefent = g_enterprise            
                  AND ooef019 = g_rtdu_m.rtdu011
                  AND ooefstus = 'Y'
                  
               IF l_cnt <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "art-00524"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD rtdu011          
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdu_m.rtdu011
            CALL ap_ref_array2(g_ref_fields,"SELECT DISTINCT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001 = '2' AND ooall003='"||g_dlang||"' AND ooall002=?","") RETURNING g_rtn_fields
            LET g_rtdu_m.rtdu011_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_rtdu_m.rtdu011_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu011
            #add-point:BEFORE FIELD rtdu011 name="input.b.rtdu011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu011
            #add-point:ON CHANGE rtdu011 name="input.g.rtdu011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu009
            #add-point:BEFORE FIELD rtdu009 name="input.b.rtdu009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu009
            
            #add-point:AFTER FIELD rtdu009 name="input.a.rtdu009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu009
            #add-point:ON CHANGE rtdu009 name="input.g.rtdu009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdu010
            #add-point:BEFORE FIELD rtdu010 name="input.b.rtdu010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdu010
            
            #add-point:AFTER FIELD rtdu010 name="input.a.rtdu010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdu010
            #add-point:ON CHANGE rtdu010 name="input.g.rtdu010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdustus
            #add-point:BEFORE FIELD rtdustus name="input.b.rtdustus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdustus
            
            #add-point:AFTER FIELD rtdustus name="input.a.rtdustus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdustus
            #add-point:ON CHANGE rtdustus name="input.g.rtdustus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rtdusite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdusite
            #add-point:ON ACTION controlp INFIELD rtdusite name="input.c.rtdusite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #141208-00001#14 Add By Ken(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdu_m.rtdusite             #給予default值

            #給予arg

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdusite',g_rtdu_m.rtdusite,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_rtdu_m.rtdusite = g_qryparam.return1              

            DISPLAY g_rtdu_m.rtdusite TO rtdusite              #

            NEXT FIELD rtdusite                          #返回原欄位
            #141208-00001#14 Add By Ken(S)

            #END add-point
 
 
         #Ctrlp:input.c.rtdudocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdudocdt
            #add-point:ON ACTION controlp INFIELD rtdudocdt name="input.c.rtdudocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtdudocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdudocno
            #add-point:ON ACTION controlp INFIELD rtdudocno name="input.c.rtdudocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdu_m.rtdudocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #參照表編號
            #LET g_qryparam.arg2 = "artt405" #對應程式代號   #160705-00042#5 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#5 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_rtdu_m.rtdudocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtdu_m.rtdudocno TO rtdudocno              #顯示到畫面上

            NEXT FIELD rtdudocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtdu000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu000
            #add-point:ON ACTION controlp INFIELD rtdu000 name="input.c.rtdu000"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtdu001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu001
            #add-point:ON ACTION controlp INFIELD rtdu001 name="input.c.rtdu001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdu_m.rtdu001             #給予default值
            LET g_qryparam.where = "pmaa002 IN ('1','3') "
            IF NOT cl_null(g_rtdu_m.rtdu002) THEN
               LET g_qryparam.where = " pmaa002 IN ('1','3') AND  pmaa001 in (select stan005 from stan_t where stan001='",g_rtdu_m.rtdu002,"' AND stanent='",g_enterprise,"')"
            END IF
            #給予arg

            CALL q_pmaa001()                                #呼叫開窗

            LET g_rtdu_m.rtdu001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtdu_m.rtdu001 TO rtdu001              #顯示到畫面上
            CALL s_desc_get_trading_partner_full_desc(g_rtdu_m.rtdu001)
               RETURNING g_rtdu_m.rtdu001_desc
            DISPLAY BY NAME g_rtdu_m.rtdu001_desc
            NEXT FIELD rtdu001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtdu002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu002
            #add-point:ON ACTION controlp INFIELD rtdu002 name="input.c.rtdu002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'i'                 
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdu_m.rtdu002             #給予default值、
            LET g_qryparam.where = " stanent = ",g_enterprise #add by geza 20160303 #加上ent条件
            IF NOT cl_null(g_rtdu_m.rtdu001) THEN
               #LET g_qryparam.where = " stan005='",g_rtdu_m.rtdu001,"' " #mark by geza 20160303 
               LET g_qryparam.where = g_qryparam.where," AND stan005='",g_rtdu_m.rtdu001,"' " #add by geza 20160303 
            END IF
            #給予arg

            CALL q_stan001_3()                                #呼叫開窗 #lanjj modify q_stan001 to q_stan001_3

            LET g_rtdu_m.rtdu002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtdu_m.rtdu002 TO rtdu002              #顯示到畫面上

            NEXT FIELD rtdu002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtdu003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu003
            #add-point:ON ACTION controlp INFIELD rtdu003 name="input.c.rtdu003"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtdu004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu004
            #add-point:ON ACTION controlp INFIELD rtdu004 name="input.c.rtdu004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdu_m.rtdu004             #給予default值
            #給予arg

            CALL q_staa001()                                #呼叫開窗

            LET g_rtdu_m.rtdu004 = g_qryparam.return1              
            DISPLAY g_rtdu_m.rtdu004 TO rtdu004              #
            NEXT FIELD rtdu004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtduunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtduunit
            #add-point:ON ACTION controlp INFIELD rtduunit name="input.c.rtduunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.stan017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stan017
            #add-point:ON ACTION controlp INFIELD stan017 name="input.c.stan017"
            
            #END add-point
 
 
         #Ctrlp:input.c.stan018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stan018
            #add-point:ON ACTION controlp INFIELD stan018 name="input.c.stan018"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtdu012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu012
            #add-point:ON ACTION controlp INFIELD rtdu012 name="input.c.rtdu012"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtdu005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu005
            #add-point:ON ACTION controlp INFIELD rtdu005 name="input.c.rtdu005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'i'               
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdu_m.rtdu005             #給予default值
            
            IF s_aooi500_setpoint(g_prog,'rtdu005') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdu005',g_rtdu_m.rtduunit,'i') #150308-00001#3 150309 pomelo add 'i'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef303='Y'"
               CALL q_ooef001() 
            END IF

            LET g_rtdu_m.rtdu005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtdu_m.rtdu005 TO rtdu005              #顯示到畫面上
            CALL s_desc_get_department_desc(g_rtdu_m.rtdu005)
               RETURNING g_rtdu_m.rtdu005_desc
            DISPLAY BY NAME g_rtdu_m.rtdu005_desc
            NEXT FIELD rtdu005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtdu006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu006
            #add-point:ON ACTION controlp INFIELD rtdu006 name="input.c.rtdu006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'i'                 
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdu_m.rtdu006             #給予default值
            #給予arg

            CALL q_ooag001_4()                                #呼叫開窗

            LET g_rtdu_m.rtdu006 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtdu_m.rtdu006 TO rtdu006              #顯示到畫面上
            CALL s_desc_get_person_desc(g_rtdu_m.rtdu006) RETURNING g_rtdu_m.rtdu006_desc
            DISPLAY BY NAME g_rtdu_m.rtdu006_desc  
            NEXT FIELD rtdu006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtdu007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu007
            #add-point:ON ACTION controlp INFIELD rtdu007 name="input.c.rtdu007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'i'               
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdu_m.rtdu007             #給予default值

            #給予arg

            IF s_aooi500_setpoint(g_prog,'rtdu007') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdu007',g_rtdu_m.rtdusite,'i') #sakura  #150308-00001#3 150309 pomelo add 'i'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef302='Y' "
               CALL q_ooef001()
            END IF            
            
            LET g_rtdu_m.rtdu007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtdu_m.rtdu007 TO rtdu007              #顯示到畫面上
            CALL s_desc_get_department_desc(g_rtdu_m.rtdu007)
               RETURNING g_rtdu_m.rtdu007_desc
            DISPLAY BY NAME g_rtdu_m.rtdu007_desc
            NEXT FIELD rtdu007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtdu008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu008
            #add-point:ON ACTION controlp INFIELD rtdu008 name="input.c.rtdu008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdu_m.rtdu008             #給予default值

            #給予arg

            CALL q_rtaa001_3()                                #呼叫開窗

            LET g_rtdu_m.rtdu008 = g_qryparam.return1              

            DISPLAY g_rtdu_m.rtdu008 TO rtdu008              #
            CALL artt405_rtdu008_display()
            NEXT FIELD rtdu008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtdu011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu011
            #add-point:ON ACTION controlp INFIELD rtdu011 name="input.c.rtdu011"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdu_m.rtdu011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


#            CALL q_ooef019()                                #呼叫開窗  #160623-00028#1
            CALL q_ooef019_1()                        #呼叫開窗   #160623-00028#1

            LET g_rtdu_m.rtdu011 = g_qryparam.return1              

            DISPLAY g_rtdu_m.rtdu011 TO rtdu011              #
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdu_m.rtdu011
            CALL ap_ref_array2(g_ref_fields,"SELECT DISTINCT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001 = '2' AND ooall003='"||g_dlang||"' AND ooall002=?","") RETURNING g_rtn_fields
            LET g_rtdu_m.rtdu011_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_rtdu_m.rtdu011_desc 
            
            NEXT FIELD rtdu011                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.rtdu009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu009
            #add-point:ON ACTION controlp INFIELD rtdu009 name="input.c.rtdu009"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtdu010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdu010
            #add-point:ON ACTION controlp INFIELD rtdu010 name="input.c.rtdu010"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtdustus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdustus
            #add-point:ON ACTION controlp INFIELD rtdustus name="input.c.rtdustus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rtdu_m.rtdudocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                 IF NOT cl_null(g_rtdu_m.rtdudocno) THEN
                    #CALL s_aooi200_gen_docno(g_site,g_rtdu_m.rtdudocno,g_rtdu_m.rtdudocdt,g_prog) #sakura mark
                     CALL s_aooi200_gen_docno(g_rtdu_m.rtdusite,g_rtdu_m.rtdudocno,g_rtdu_m.rtdudocdt,g_prog) #sakura add
                     RETURNING  g_success,g_rtdu_m.rtdudocno
                     IF g_success<>'1' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "amm-00001"
                        LET g_errparam.extend = g_rtdu_m.rtdudocno
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        NEXT FIELD rtdudocno
                     ELSE
                        IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdu_t WHERE "||"rtduent = '" ||g_enterprise|| "' AND "||"rtdudocno = '"||g_rtdu_m.rtdudocno ||"'",'std-00004',0) THEN 
                           LET g_rtdu_m.rtdudocno = g_rtdu_m_t.rtdudocno
                           NEXT FIELD CURRENT
                        END IF    
                                      
                     END IF
                     LET g_rtdu_m_t.rtdudocno = g_rtdu_m.rtdudocno
                  END IF 
                  LET g_rtdu_m.rtduunit = g_rtdu_m.rtdusite #ken---add 需求單號：141208-00001 項次：14
               #end add-point
               
               INSERT INTO rtdu_t (rtduent,rtdusite,rtdudocdt,rtdudocno,rtdu000,rtdu001,rtdu002,rtdu003, 
                   rtdu004,rtduunit,rtdu012,rtdu005,rtdu006,rtdu007,rtdu008,rtdu011,rtdu009,rtdu010, 
                   rtdustus,rtduownid,rtduowndp,rtducrtid,rtducrtdp,rtducrtdt,rtdumodid,rtdumoddt,rtducnfid, 
                   rtducnfdt)
               VALUES (g_enterprise,g_rtdu_m.rtdusite,g_rtdu_m.rtdudocdt,g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000, 
                   g_rtdu_m.rtdu001,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtduunit, 
                   g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008, 
                   g_rtdu_m.rtdu011,g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid, 
                   g_rtdu_m.rtduowndp,g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid, 
                   g_rtdu_m.rtdumoddt,g_rtdu_m.rtducnfid,g_rtdu_m.rtducnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rtdu_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
                IF p_cmd = 'a' THEN
                   CALL artt405_creat_rtdw001()
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = "g_rtdv2_d"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
               
                      CALL s_transaction_end('N','0')
                      RETURN
                   END IF
                END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL artt405_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL artt405_b_fill()
                  CALL artt405_b_fill2('0')
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
               CALL artt405_rtdu_t_mask_restore('restore_mask_o')
               
               UPDATE rtdu_t SET (rtdusite,rtdudocdt,rtdudocno,rtdu000,rtdu001,rtdu002,rtdu003,rtdu004, 
                   rtduunit,rtdu012,rtdu005,rtdu006,rtdu007,rtdu008,rtdu011,rtdu009,rtdu010,rtdustus, 
                   rtduownid,rtduowndp,rtducrtid,rtducrtdp,rtducrtdt,rtdumodid,rtdumoddt,rtducnfid,rtducnfdt) = (g_rtdu_m.rtdusite, 
                   g_rtdu_m.rtdudocdt,g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000,g_rtdu_m.rtdu001,g_rtdu_m.rtdu002, 
                   g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtduunit,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005, 
                   g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008,g_rtdu_m.rtdu011,g_rtdu_m.rtdu009, 
                   g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduowndp,g_rtdu_m.rtducrtid, 
                   g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumoddt,g_rtdu_m.rtducnfid, 
                   g_rtdu_m.rtducnfdt)
                WHERE rtduent = g_enterprise AND rtdudocno = g_rtdudocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtdu_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL artt405_rtdu_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rtdu_m_t)
               LET g_log2 = util.JSON.stringify(g_rtdu_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rtdudocno_t = g_rtdu_m.rtdudocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="artt405.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rtdv_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtdv_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt405_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rtdv_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL artt405_get_oodb011()      #150213-00006#3 2015/02/13 By pomelo add
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
            OPEN artt405_cl USING g_enterprise,g_rtdu_m.rtdudocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt405_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt405_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rtdv_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rtdv_d[l_ac].rtdvseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtdv_d_t.* = g_rtdv_d[l_ac].*  #BACKUP
               LET g_rtdv_d_o.* = g_rtdv_d[l_ac].*  #BACKUP
               CALL artt405_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
 
               #end add-point  
               CALL artt405_set_no_entry_b(l_cmd)
               IF NOT artt405_lock_b("rtdv_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt405_bcl INTO g_rtdv_d[l_ac].rtdvseq,g_rtdv_d[l_ac].rtdv002,g_rtdv_d[l_ac].rtdv001, 
                      g_rtdv_d[l_ac].rtdv018,g_rtdv_d[l_ac].rtdv023,g_rtdv_d[l_ac].rtdv101,g_rtdv_d[l_ac].rtdv024, 
                      g_rtdv_d[l_ac].rtdv025,g_rtdv_d[l_ac].rtdv026,g_rtdv_d[l_ac].rtdv102,g_rtdv_d[l_ac].rtdv103, 
                      g_rtdv_d[l_ac].rtdv020,g_rtdv_d[l_ac].rtdv021,g_rtdv_d[l_ac].rtdv022,g_rtdv_d[l_ac].rtdv004, 
                      g_rtdv_d[l_ac].rtdv006,g_rtdv_d[l_ac].rtdv008,g_rtdv_d[l_ac].rtdv012,g_rtdv_d[l_ac].rtdv009, 
                      g_rtdv_d[l_ac].rtdv011,g_rtdv_d[l_ac].rtdv033,g_rtdv_d[l_ac].rtdv017,g_rtdv_d[l_ac].rtdv019, 
                      g_rtdv_d[l_ac].rtdv031,g_rtdv_d[l_ac].rtdv029,g_rtdv_d[l_ac].rtdv040,g_rtdv_d[l_ac].rtdv039, 
                      g_rtdv_d[l_ac].rtdv003,g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv013,g_rtdv_d[l_ac].rtdv014, 
                      g_rtdv_d[l_ac].rtdv015,g_rtdv_d[l_ac].rtdv016,g_rtdv_d[l_ac].rtdv034,g_rtdv_d[l_ac].rtdv035, 
                      g_rtdv_d[l_ac].rtdv036,g_rtdv_d[l_ac].rtdv037,g_rtdv_d[l_ac].rtdv038,g_rtdv_d[l_ac].rtdv032, 
                      g_rtdv_d[l_ac].rtdv027,g_rtdv_d[l_ac].rtdv028
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtdv_d_t.rtdvseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtdv_d_mask_o[l_ac].* =  g_rtdv_d[l_ac].*
                  CALL artt405_rtdv_t_mask()
                  LET g_rtdv_d_mask_n[l_ac].* =  g_rtdv_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt405_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #160604-00009#130 add by geza 20160704(S)
            CALL artt405_set_no_required_b(l_cmd)
            CALL artt405_set_required_b(l_cmd)
            #160604-00009#130 add by geza 20160704(S) 
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
            INITIALIZE g_rtdv_d[l_ac].* TO NULL 
            INITIALIZE g_rtdv_d_t.* TO NULL 
            INITIALIZE g_rtdv_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rtdv_d[l_ac].rtdv101 = "0"
      LET g_rtdv_d[l_ac].rtdv102 = "0"
      LET g_rtdv_d[l_ac].rtdv103 = "0"
      LET g_rtdv_d[l_ac].rtdv021 = "N"
      LET g_rtdv_d[l_ac].l_oodb005 = "Y"
      LET g_rtdv_d[l_ac].l_oodb0051 = "Y"
      LET g_rtdv_d[l_ac].rtdv017 = "0"
      LET g_rtdv_d[l_ac].rtdv019 = "0"
      LET g_rtdv_d[l_ac].rtdv031 = "0"
      LET g_rtdv_d[l_ac].rtdv040 = "N"
      LET g_rtdv_d[l_ac].rtdv039 = "0"
      LET g_rtdv_d[l_ac].rtdv003 = "Y"
      LET g_rtdv_d[l_ac].rtdv014 = "1"
      LET g_rtdv_d[l_ac].rtdv015 = "1"
      LET g_rtdv_d[l_ac].rtdv016 = "0"
      LET g_rtdv_d[l_ac].rtdv037 = "0"
      LET g_rtdv_d[l_ac].rtdv038 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #160604-00009#130 add by geza 20160704(S)
            #如果启用积分超市，引进的时候，单位积分给null，必输
            LET g_rtdv101_flag = cl_get_para(g_enterprise,g_rtdu_m.rtdusite,"S-CIR-2028")
            IF g_rtdv101_flag = 'Y' THEN
               LET g_rtdv_d[l_ac].rtdv101 = ""
               LET g_rtdv_d[l_ac].rtdv102 = ""
               LET g_rtdv_d[l_ac].rtdv103 = ""
            END IF
            #160604-00009#130 add by geza 20160704(E)
            #sakura---add---str---141009-00031#17
            #SELECT stan017,stan018,stan006
             SELECT stan017,(CASE WHEN (stan031 IS NOT NULL) THEN stan031 ELSE stan018 END),stan006  #By shi Add 20150701
              INTO g_rtdv_d[l_ac].rtdv027,g_rtdv_d[l_ac].rtdv028,g_rtdv_d[l_ac].rtdv033
              FROM stan_t
             WHERE stanent = g_enterprise
               AND stan001 = g_rtdu_m.rtdu002
               
            CALL s_desc_get_currency_desc(g_rtdv_d[l_ac].rtdv033) RETURNING g_rtdv_d[l_ac].rtdv033_desc
            CALL s_desc_get_person_desc(g_rtdv_d[l_ac].rtdv013) RETURNING g_rtdv_d[l_ac].rtdv013_desc
            #sakura---add---str---141009-00031#17
            
            #150213-00006#3 2015/02/13 By pomelo add(S)
            IF g_oodb011 = '1' THEN
               LET g_rtdv_d[l_ac].rtdv004 = g_rtdu_m.l_stan007    #進項稅別
               LET g_rtdv_d[l_ac].rtdv004_desc = g_rtdu_m.l_stan007_desc
               #150827-00026#1 150831 by sakura mark&add(S)
               #CALL artt405_rtdv005_rtdv030(g_rtdv_d[l_ac].rtdv004)
               CALL artt405_oodb006_oodb005(g_rtdv_d[l_ac].rtdv004)
               #150827-00026#1 150831 by sakura mark&add(E)
               LET g_rtdv_d[l_ac].rtdv006 = g_rtdu_m.l_stan007    #銷項稅別
               LET g_rtdv_d[l_ac].rtdv006_desc = g_rtdu_m.l_stan007_desc
               #150827-00026#1 150831 by sakura mark&add(S)
               #CALL artt405_rtdv007_rtdv030(g_rtdv_d[l_ac].rtdv006)
               CALL artt405_oodb0061_oodb0051(g_rtdv_d[l_ac].rtdv006)
               #150827-00026#1 150831 by sakura mark&add(E)
            END IF
            #150213-00006#3 2015/02/13 By pomelo add(E)
            #150511-00010#1 2015/05/11 By geza add(S)
          
            LET g_rtdv_d[l_ac].rtdv034 = "3"    
            LET g_rtdv_d[l_ac].rtdv035 = "0"
            LET g_rtdv_d[l_ac].rtdv036 = "0"
           
            #150511-00010#1 2015/05/11 By geza add(E)
            
            LET g_rtdv_d[l_ac].rtdv012 = g_rtdu_m.rtdu012  #151113-00003#1 Add By Ken 151116
            #end add-point
            LET g_rtdv_d_t.* = g_rtdv_d[l_ac].*     #新輸入資料
            LET g_rtdv_d_o.* = g_rtdv_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt405_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL artt405_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtdv_d[li_reproduce_target].* = g_rtdv_d[li_reproduce].*
 
               LET g_rtdv_d[li_reproduce_target].rtdvseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET  g_rtdv_d[l_ac].rtdv013 = g_rtdu_m.rtdu006
           #sakura---mark---str---141009-00031#17
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_rtdv_d[l_ac].rtdv013
           #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
           #LET g_rtdv_d[l_ac].rtdv013_desc = '', g_rtn_fields[1] , ''
           #DISPLAY BY NAME g_rtdv_d[l_ac].rtdv013_desc
           #  INTO g_rtdv_d[l_ac].rtdv027,g_rtdv_d[l_ac].rtdv028
           #  FROM stan_t
           # WHERE stan001 = g_rtdu_m.rtdu002 AND stanent = g_enterprise
           #sakura---mark---end---141009-00031#17
#
#            DISPLAY g_rtdv_d[l_ac].rtdv027 TO s_detail1[l_ac].rtdv027
#            DISPLAY g_rtdv_d[l_ac].rtdv028 TO s_detail1[l_ac].rtdv028
            CALL artt405_create_rtdvseq()
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
            SELECT COUNT(1) INTO l_count FROM rtdv_t 
             WHERE rtdvent = g_enterprise AND rtdvdocno = g_rtdu_m.rtdudocno
 
               AND rtdvseq = g_rtdv_d[l_ac].rtdvseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdu_m.rtdudocno
               LET gs_keys[2] = g_rtdv_d[g_detail_idx].rtdvseq
               CALL artt405_insert_b('rtdv_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rtdv_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtdv_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt405_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #CALL artt405_update_rtdv() RETURNING l_success   #20150625 暫時Mark
               #IF l_success = FALSE THEN  
               #   CALL s_transaction_end('N','0')                    
               #   CANCEL INSERT
               #END IF  
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
               LET gs_keys[01] = g_rtdu_m.rtdudocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_rtdv_d_t.rtdvseq
 
            
               #刪除同層單身
               IF NOT artt405_delete_b('rtdv_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt405_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt405_key_delete_b(gs_keys,'rtdv_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt405_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE artt405_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_rtdv_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rtdv_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdvseq
            #add-point:BEFORE FIELD rtdvseq name="input.b.page1.rtdvseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdvseq
            
            #add-point:AFTER FIELD rtdvseq name="input.a.page1.rtdvseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtdu_m.rtdudocno IS NOT NULL AND g_rtdv_d[g_detail_idx].rtdvseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdu_m.rtdudocno != g_rtdudocno_t OR g_rtdv_d[g_detail_idx].rtdvseq != g_rtdv_d_t.rtdvseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdv_t WHERE "||"rtdvent = '" ||g_enterprise|| "' AND "||"rtdvdocno = '"||g_rtdu_m.rtdudocno ||"' AND "|| "rtdvseq = '"||g_rtdv_d[g_detail_idx].rtdvseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdvseq
            #add-point:ON CHANGE rtdvseq name="input.g.page1.rtdvseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv002
            #add-point:BEFORE FIELD rtdv002 name="input.b.page1.rtdv002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv002
            
            #add-point:AFTER FIELD rtdv002 name="input.a.page1.rtdv002"
            CALL artt405_null_rtdv001()
            LET g_rtdv_d[l_ac].rtdv001 = NULL
#            DISPLAY g_rtdv_d[l_ac].rtdv001 TO s_detail1[l_ac].rtdv001
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv002) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_rtdv_d[l_ac].rtdv002 != g_rtdv_d_t.rtdv002 ))) THEN   #160824-00007#21 Mark By ken 160926
               IF g_rtdv_d[l_ac].rtdv002 != g_rtdv_d_o.rtdv002 THEN    #160824-00007#21 Add By ken 160926
                  CALL artt405_rtdv002(g_rtdv_d[l_ac].rtdv002)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtdv_d[l_ac].rtdv002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_t.rtdv002  #160824-00007#21 Mark By ken 160926
                     LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_o.rtdv002   #160824-00007#21 Add By ken 160926
                     CALL artt405_rtdv002_display(g_rtdv_d[l_ac].rtdv002)
                     CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
                     NEXT FIELD rtdv002
                  END IF
                  CALL artt405_rtdv002_display(g_rtdv_d[l_ac].rtdv002)
                  IF NOT cl_null(g_rtdv_d[l_ac].rtdv001) THEN            
                     CALL artt405_unique_rtdv001(g_rtdv_d[l_ac].rtdv001,g_rtdv_d_t.rtdvseq)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_rtdv_d[l_ac].rtdv001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_t.rtdv002  #160824-00007#21 Mark By ken 160926
                        #LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_t.rtdv001  #160824-00007#21 Mark By ken 160926
                        LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_o.rtdv002   #160824-00007#21 Add By ken 160926
                        LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_o.rtdv001   #160824-00007#21 Add By ken 160926            
                        CALL artt405_rtdv002_display(g_rtdv_d[l_ac].rtdv002)
                        CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
                        NEXT FIELD rtdv002
                     END IF
                     CALL artt405_chk_imaa009(g_rtdv_d[l_ac].rtdv001)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_rtdv_d[l_ac].rtdv001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_t.rtdv002  #160824-00007#21 Mark By ken 160926
                        #LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_t.rtdv001  #160824-00007#21 Mark By ken 160926
                        LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_o.rtdv002   #160824-00007#21 Add By ken 160926
                        LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_o.rtdv001   #160824-00007#21 Add By ken 160926                        
                        CALL artt405_rtdv002_display(g_rtdv_d[l_ac].rtdv002)
                        CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
                        NEXT FIELD rtdv002
                     END IF
                     IF g_rtdu_m.rtdu003 = '3' AND (g_rtdv_d_t.rtdv001 IS NULL OR g_rtdv_d_t.rtdv001 = g_rtdv_d[l_ac].rtdv001) THEN
                        #CALL artt405_rtdw039_init() RETURNING l_cost    #20151125 dongsz mark
                        CALL s_astt313_get_stao012(g_rtdu_m.rtdusite,g_rtdu_m.rtdu002,g_rtdv_d[l_ac].rtdv001,g_rtdu_m.rtdudocdt) RETURNING l_cost    #20151125 dongsz add 
                        LET g_rtdv_d[l_ac].rtdv039 = l_cost
                     END IF   
                  END IF
               END IF
            END IF
           
            CALL artt405_rtdv002_display(g_rtdv_d[l_ac].rtdv002)
            CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
            LET g_rtdv_d_t.* = g_rtdv_d[l_ac].*
            LET g_rtdv_d_o.* = g_rtdv_d[l_ac].*   #160824-00007#21 Add By ken 160926
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv002
            #add-point:ON CHANGE rtdv002 name="input.g.page1.rtdv002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv001
            #add-point:BEFORE FIELD rtdv001 name="input.b.page1.rtdv001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv001
            
            #add-point:AFTER FIELD rtdv001 name="input.a.page1.rtdv001"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv001) THEN 
               #IF (l_cmd = 'a' AND  ( g_rtdv_d[l_ac].rtdv001 != g_rtdv_d_t.rtdv001 OR g_rtdv_d_t.rtdv001 IS null)) OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_rtdv_d[l_ac].rtdv001 != g_rtdv_d_t.rtdv001 OR g_rtdv_d_t.rtdv001 IS null))) THEN   #160824-00007#21 Mark By ken 160926
               IF ( g_rtdv_d[l_ac].rtdv001 != g_rtdv_d_o.rtdv001 OR g_rtdv_d_o.rtdv001 IS NULL) OR ( g_rtdv_d[l_ac].rtdv001 != g_rtdv_d_o.rtdv001 OR g_rtdv_d_o.rtdv001 IS NULL) THEN    #160824-00007#21 Add By ken 160926
                  CALL artt405_null_rtdv001()
                  LET g_rtdv_d[l_ac].rtdv002 = NULL
                  DISPLAY g_rtdv_d[l_ac].rtdv002 TO s_detail1[l_ac].rtdv002
                  CALL artt405_rtdv001(g_rtdv_d[l_ac].rtdv001)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtdv_d[l_ac].rtdv001
                     #160318-00005#41 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aimm200'
                           LET g_errparam.replace[2] = cl_get_progname('aimm200',g_lang,"2")
                           LET g_errparam.exeprog = 'aimm200'
                     END CASE
                     #160318-00005#41 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_t.rtdv001  #160824-00007#21 Mark By ken 160926
                     LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_o.rtdv001   #160824-00007#21 Add By ken 160926
                     CALL artt405_rtdv001_display1(g_rtdv_d[l_ac].rtdv001)
                     CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
                     NEXT FIELD rtdv001
                  END IF
                  IF NOT cl_null(g_rtdv_d[l_ac].rtdv001) THEN
                     CALL artt405_unique_rtdv001(g_rtdv_d[l_ac].rtdv001,g_rtdv_d_t.rtdvseq)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtdv_d[l_ac].rtdv001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_t.rtdv001  #160824-00007#21 Mark By ken 160926
                     LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_o.rtdv001   #160824-00007#21 Add By ken 160926                        
                        CALL artt405_rtdv001_display1(g_rtdv_d[l_ac].rtdv001)
                        CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
                        NEXT FIELD rtdv001
                     END IF
                  END IF
                  CALL artt405_rtdv001_display1(g_rtdv_d[l_ac].rtdv001)
                  CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
                  IF g_rtdu_m.rtdu003 = '3' AND (g_rtdv_d_t.rtdv001 IS NULL OR g_rtdv_d_t.rtdv001 = g_rtdv_d[l_ac].rtdv001) THEN
                     #CALL artt405_rtdw039_init() RETURNING l_cost     #20151125 dongsz mark
                     CALL s_astt313_get_stao012(g_rtdu_m.rtdusite,g_rtdu_m.rtdu002,g_rtdv_d[l_ac].rtdv001,g_rtdu_m.rtdudocdt) RETURNING l_cost    #20151125 dongsz add
                     LET g_rtdv_d[l_ac].rtdv039 = l_cost
                  END IF 
               END IF
            END IF
            LET g_rtdv_d_t.* = g_rtdv_d[l_ac].*
            LET g_rtdv_d_o.* = g_rtdv_d[l_ac].*    #160824-00007#21 Add By ken 160926 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv001
            #add-point:ON CHANGE rtdv001 name="input.g.page1.rtdv001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv018
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv018,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD rtdv018
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv018 name="input.a.page1.rtdv018"
            #20151202--dongsz add--s
            #参数E-CIR-0052设置进价是否可以为0
            LET l_rtdv018_chk = cl_get_para(g_enterprise,g_site,'E-CIR-0052')
            IF NOT (l_rtdv018_chk = 'Y' AND g_rtdu_m.rtdu003 = '1') THEN
               IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv018,"0.000","0","","","azz-00079",1) THEN
                  NEXT FIELD rtdv018
               END IF
            END IF
            #20151202--dongsz add--e
            
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv018) THEN 
               IF NOT cl_null(g_rtdv_d[l_ac].rtdv017) AND NOT cl_null(g_rtdv_d[l_ac].rtdv004) THEN 
                  CALL artt405_rtdv019()
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv018
            #add-point:BEFORE FIELD rtdv018 name="input.b.page1.rtdv018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv018
            #add-point:ON CHANGE rtdv018 name="input.g.page1.rtdv018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv023,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtdv023
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv023 name="input.a.page1.rtdv023"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv023) THEN
               LET g_rtdv_d[l_ac].rtdv020 = (g_rtdv_d[l_ac].rtdv023-g_rtdv_d[l_ac].rtdv018)*100/g_rtdv_d[l_ac].rtdv023
               DISPLAY g_rtdv_d[l_ac].rtdv020 TO s_detail1[l_ac].rtdv020
            END IF
            CALL artt405_rtdv023_display()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv023
            #add-point:BEFORE FIELD rtdv023 name="input.b.page1.rtdv023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv023
            #add-point:ON CHANGE rtdv023 name="input.g.page1.rtdv023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv101
            #add-point:BEFORE FIELD rtdv101 name="input.b.page1.rtdv101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv101
            
            #add-point:AFTER FIELD rtdv101 name="input.a.page1.rtdv101"
            #160604-00009#130 add by geza 20160704(S)
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv101) THEN 
               LET g_rtdv_d[l_ac].rtdv102 = g_rtdv_d[l_ac].rtdv101
               LET g_rtdv_d[l_ac].rtdv103 = g_rtdv_d[l_ac].rtdv101
            END IF 
            #160604-00009#130 add by geza 20160704(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv101
            #add-point:ON CHANGE rtdv101 name="input.g.page1.rtdv101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv024
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv024,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtdv024
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv024 name="input.a.page1.rtdv024"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv024) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv024
            #add-point:BEFORE FIELD rtdv024 name="input.b.page1.rtdv024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv024
            #add-point:ON CHANGE rtdv024 name="input.g.page1.rtdv024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv025
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv025,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtdv025
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv025 name="input.a.page1.rtdv025"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv025) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv025
            #add-point:BEFORE FIELD rtdv025 name="input.b.page1.rtdv025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv025
            #add-point:ON CHANGE rtdv025 name="input.g.page1.rtdv025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv026
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv026,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtdv026
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv026 name="input.a.page1.rtdv026"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv026) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv026
            #add-point:BEFORE FIELD rtdv026 name="input.b.page1.rtdv026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv026
            #add-point:ON CHANGE rtdv026 name="input.g.page1.rtdv026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv102
            #add-point:BEFORE FIELD rtdv102 name="input.b.page1.rtdv102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv102
            
            #add-point:AFTER FIELD rtdv102 name="input.a.page1.rtdv102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv102
            #add-point:ON CHANGE rtdv102 name="input.g.page1.rtdv102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv103
            #add-point:BEFORE FIELD rtdv103 name="input.b.page1.rtdv103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv103
            
            #add-point:AFTER FIELD rtdv103 name="input.a.page1.rtdv103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv103
            #add-point:ON CHANGE rtdv103 name="input.g.page1.rtdv103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv020
            #add-point:BEFORE FIELD rtdv020 name="input.b.page1.rtdv020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv020
            
            #add-point:AFTER FIELD rtdv020 name="input.a.page1.rtdv020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv020
            #add-point:ON CHANGE rtdv020 name="input.g.page1.rtdv020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv021
            #add-point:BEFORE FIELD rtdv021 name="input.b.page1.rtdv021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv021
            
            #add-point:AFTER FIELD rtdv021 name="input.a.page1.rtdv021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv021
            #add-point:ON CHANGE rtdv021 name="input.g.page1.rtdv021"
            CALL artt405_set_entry_b(l_cmd)
             
            CALL artt405_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv022,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtdv022
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv022 name="input.a.page1.rtdv022"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv022) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv022
            #add-point:BEFORE FIELD rtdv022 name="input.b.page1.rtdv022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv022
            #add-point:ON CHANGE rtdv022 name="input.g.page1.rtdv022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv004
            
            #add-point:AFTER FIELD rtdv004 name="input.a.page1.rtdv004"
            LET g_rtdv_d[l_ac].rtdv004_desc = NULL
            DISPLAY  g_rtdv_d[l_ac].rtdv004_desc TO s_detail1[l_ac].rtdv004_desc
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv004) THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_rtdv_d[l_ac].rtdv004 != g_rtdv_d_t.rtdv004 ))) THEN  #sakura mark
               IF g_rtdv_d[l_ac].rtdv004 != g_rtdv_d_o.rtdv004 OR cl_null(g_rtdv_d_o.rtdv004) THEN #sakura add
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg2 = g_rtdv_d[l_ac].rtdv004
                  LET g_chkparam.arg1 = g_rtdu_m.rtdu011
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#21  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_oodb002_4") THEN
                     #150827-00026#1 150831 by sakura mark&add(S)
                     #CALL artt405_rtdv005_rtdv030(g_rtdv_d[l_ac].rtdv004) #sakura add
                     CALL artt405_oodb006_oodb005(g_rtdv_d[l_ac].rtdv004)
                     #150827-00026#1 150831 by sakura mark&add(E)
                  ELSE
                     #檢查失敗時後續處理
                     LET g_rtdv_d[l_ac].rtdv004 = g_rtdv_d_t.rtdv004
                     CALL artt405_rtdv004_display(g_rtdv_d[l_ac].rtdv004)
                     NEXT FIELD rtdv004
                  END IF
#                  CALL artt405_rtdv004(g_rtdv_d[l_ac].rtdv004)
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_rtdv_d[l_ac].rtdv004,g_errno,1)
#                     LET g_rtdv_d[l_ac].rtdv004 = g_rtdv_d_t.rtdv004
#                     CALL artt405_display_rtdv004(g_rtdv_d[l_ac].rtdv004)
#                     NEXT FIELD rtdv004
#                  END IF 
                  IF NOT cl_null(g_rtdv_d[l_ac].rtdv017) AND NOT cl_null(g_rtdv_d[l_ac].rtdv018) THEN 
                     CALL artt405_rtdv019()
                  END IF 
               END IF
            ELSE #sakura add
               #150827-00026#1 150831 by sakura mark&add(S)
               #LET g_rtdv_d[l_ac].rtdv005 = '' #sakura add
               #LET g_rtdv_d[l_ac].rtdv030 = '' #sakura add
               LET g_rtdv_d[l_ac].l_oodb006 = ''
               LET g_rtdv_d[l_ac].l_oodb005 = ''
               #150827-00026#1 150831 by sakura mark&add(E)
            END IF
            CALL artt405_rtdv004_display(g_rtdv_d[l_ac].rtdv004)
            LET g_rtdv_d_o.rtdv004 = g_rtdv_d[l_ac].rtdv004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv004
            #add-point:BEFORE FIELD rtdv004 name="input.b.page1.rtdv004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv004
            #add-point:ON CHANGE rtdv004 name="input.g.page1.rtdv004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_oodb006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].l_oodb006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_oodb006
            END IF 
 
 
 
            #add-point:AFTER FIELD l_oodb006 name="input.a.page1.l_oodb006"
            IF NOT cl_null(g_rtdv_d[l_ac].l_oodb006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_oodb006
            #add-point:BEFORE FIELD l_oodb006 name="input.b.page1.l_oodb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_oodb006
            #add-point:ON CHANGE l_oodb006 name="input.g.page1.l_oodb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_oodb005
            #add-point:BEFORE FIELD l_oodb005 name="input.b.page1.l_oodb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_oodb005
            
            #add-point:AFTER FIELD l_oodb005 name="input.a.page1.l_oodb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_oodb005
            #add-point:ON CHANGE l_oodb005 name="input.g.page1.l_oodb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv006
            
            #add-point:AFTER FIELD rtdv006 name="input.a.page1.rtdv006"
            LET g_rtdv_d[l_ac].rtdv006_desc = null
            DISPLAY  g_rtdv_d[l_ac].rtdv006_desc TO s_detail1[l_ac].rtdv006_desc
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv006) THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_rtdv3_d[l_ac].rtdv006 != g_rtdv3_d_t.rtdv006 ))) THEN  #sakura mark
               IF g_rtdv_d[l_ac].rtdv006 != g_rtdv_d_o.rtdv006 OR cl_null(g_rtdv_d_o.rtdv006) THEN #sakura add
                 #sakura---mark--str 
                 #CALL artt405_rtdv004(g_rtdv3_d[l_ac].rtdv006)
                 #IF NOT cl_null(g_errno) THEN
                 #   INITIALIZE g_errparam TO NULL
                 #   LET g_errparam.code = g_errno
                 #   LET g_errparam.extend = g_rtdv3_d[l_ac].rtdv006
                 #   LET g_errparam.popup = TRUE
                 #   CALL cl_err()
                 #
                 #   LET g_rtdv3_d[l_ac].rtdv006 = g_rtdv3_d_t.rtdv006
                 #   CALL artt405_display_rtdv006(g_rtdv3_d[l_ac].rtdv006)
                 #   NEXT FIELD rtdv006
                 #END IF
                 #sakura---mark--end
                 #sakura---add--str
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_rtdu_m.rtdu011
                 LET g_chkparam.arg2 = g_rtdv_d[l_ac].rtdv006
                 #160318-00025#21  by 07900 --add-str
                 LET g_errshow = TRUE #是否開窗                   
                 LET g_chkparam.err_str[1] ="aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                 #160318-00025#21  by 07900 --add-end 
                 IF cl_chk_exist("v_oodb002_4") THEN
                    #150827-00026#1 150831 by sakura mark&add(S)
                    #CALL artt405_rtdv007_rtdv030(g_rtdv_d[l_ac].rtdv006)
                    CALL artt405_oodb0061_oodb0051(g_rtdv_d[l_ac].rtdv006)
                    #150827-00026#1 150831 by sakura mark&add(E)
                 ELSE
                    LET g_rtdv_d[l_ac].rtdv006 = g_rtdv_d_t.rtdv006
                    CALL artt405_rtdv006_display(g_rtdv_d[l_ac].rtdv006)
                    NEXT FIELD rtdv006
                 END IF                   
                 #sakura---add--end
               END IF
            ELSE
               #150827-00026#1 150831 by sakura mark&add(S)
               #LET g_rtdv_d[l_ac].rtdv007 = '' #sakura add
               #LET g_rtdv_d[l_ac].rtdv030 = '' #sakura add
               LET g_rtdv_d[l_ac].l_oodb0061 = ''
               LET g_rtdv_d[l_ac].l_oodb0051 = ''
               #150827-00026#1 150831 by sakura mark&add(E)
            END IF
            CALL artt405_rtdv006_display(g_rtdv_d[l_ac].rtdv006)
            LET g_rtdv_d_o.rtdv006 = g_rtdv_d[l_ac].rtdv006 #sakura add 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv006
            #add-point:BEFORE FIELD rtdv006 name="input.b.page1.rtdv006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv006
            #add-point:ON CHANGE rtdv006 name="input.g.page1.rtdv006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_oodb0061
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].l_oodb0061,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_oodb0061
            END IF 
 
 
 
            #add-point:AFTER FIELD l_oodb0061 name="input.a.page1.l_oodb0061"
            IF NOT cl_null(g_rtdv_d[l_ac].l_oodb0061) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_oodb0061
            #add-point:BEFORE FIELD l_oodb0061 name="input.b.page1.l_oodb0061"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_oodb0061
            #add-point:ON CHANGE l_oodb0061 name="input.g.page1.l_oodb0061"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_oodb0051
            #add-point:BEFORE FIELD l_oodb0051 name="input.b.page1.l_oodb0051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_oodb0051
            
            #add-point:AFTER FIELD l_oodb0051 name="input.a.page1.l_oodb0051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_oodb0051
            #add-point:ON CHANGE l_oodb0051 name="input.g.page1.l_oodb0051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv008
            #add-point:BEFORE FIELD rtdv008 name="input.b.page1.rtdv008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv008
            
            #add-point:AFTER FIELD rtdv008 name="input.a.page1.rtdv008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv008
            #add-point:ON CHANGE rtdv008 name="input.g.page1.rtdv008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv012
            #add-point:BEFORE FIELD rtdv012 name="input.b.page1.rtdv012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv012
            
            #add-point:AFTER FIELD rtdv012 name="input.a.page1.rtdv012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv012
            #add-point:ON CHANGE rtdv012 name="input.g.page1.rtdv012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv009
            
            #add-point:AFTER FIELD rtdv009 name="input.a.page1.rtdv009"
            LET g_rtdv_d[l_ac].rtdv009_desc = null
            DISPLAY  g_rtdv_d[l_ac].rtdv009_desc TO s_detail1[l_ac].rtdv009_desc
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv009) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_rtdv_d[l_ac].rtdv009 != g_rtdv_d_t.rtdv009 ))) THEN   #160824-00007#21 Mark By ken 160926
               IF g_rtdv_d[l_ac].rtdv009 != g_rtdv_d_o.rtdv009 THEN    #160824-00007#21 Add By ken 160926
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtdv_d[l_ac].rtdv009
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#21  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooca001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     #LET g_rtdv_d[l_ac].rtdv009 = g_rtdv_d_t.rtdv009  #160824-00007#21 Mark By ken 160926
                     LET g_rtdv_d[l_ac].rtdv009 = g_rtdv_d_o.rtdv009   #160824-00007#21 Add By ken 160926
                     CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv009)
                        RETURNING g_rtdv_d[l_ac].rtdv009_desc
                     NEXT FIELD rtdv009
                  END IF
               END IF
            END IF
            CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv009)
               RETURNING g_rtdv_d[l_ac].rtdv009_desc
            LET g_rtdv_d_o.* = g_rtdv_d[l_ac].*    #160824-00007#21 Add By ken 160926


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv009
            #add-point:BEFORE FIELD rtdv009 name="input.b.page1.rtdv009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv009
            #add-point:ON CHANGE rtdv009 name="input.g.page1.rtdv009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv011
            #add-point:BEFORE FIELD rtdv011 name="input.b.page1.rtdv011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv011
            
            #add-point:AFTER FIELD rtdv011 name="input.a.page1.rtdv011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv011
            #add-point:ON CHANGE rtdv011 name="input.g.page1.rtdv011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv033
            
            #add-point:AFTER FIELD rtdv033 name="input.a.page1.rtdv033"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdv_d[l_ac].rtdv033
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtdv_d[l_ac].rtdv033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtdv_d[l_ac].rtdv033_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv033
            #add-point:BEFORE FIELD rtdv033 name="input.b.page1.rtdv033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv033
            #add-point:ON CHANGE rtdv033 name="input.g.page1.rtdv033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv017
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv017,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD rtdv017
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv017 name="input.a.page1.rtdv017"
            
            #160512-00022#1   2016/05/17  add(S)
            IF cl_null(g_rtdv_d[l_ac].rtdv017) THEN 
               LET g_rtdv_d[l_ac].rtdv017=0
            END IF
            #160512-00022#1   2016/05/17  add(E)
            
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv017) THEN 
               IF NOT cl_null(g_rtdv_d[l_ac].rtdv018) AND NOT cl_null(g_rtdv_d[l_ac].rtdv004) THEN 
                  CALL artt405_rtdv019()
               END IF
            END IF 
            
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv017
            #add-point:BEFORE FIELD rtdv017 name="input.b.page1.rtdv017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv017
            #add-point:ON CHANGE rtdv017 name="input.g.page1.rtdv017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv019
            #add-point:BEFORE FIELD rtdv019 name="input.b.page1.rtdv019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv019
            
            #add-point:AFTER FIELD rtdv019 name="input.a.page1.rtdv019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv019
            #add-point:ON CHANGE rtdv019 name="input.g.page1.rtdv019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv031
            #add-point:BEFORE FIELD rtdv031 name="input.b.page1.rtdv031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv031
            
            #add-point:AFTER FIELD rtdv031 name="input.a.page1.rtdv031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv031
            #add-point:ON CHANGE rtdv031 name="input.g.page1.rtdv031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv029
            
            #add-point:AFTER FIELD rtdv029 name="input.a.page1.rtdv029"
            LET g_rtdv_d[l_ac].rtdv029_desc = null
            DISPLAY  g_rtdv_d[l_ac].rtdv029_desc TO s_detail1[l_ac].rtdv029_desc
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv029) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_rtdv_d[l_ac].rtdv029 != g_rtdv_d_t.rtdv029 ))) THEN 
               IF g_rtdv_d[l_ac].rtdv029 != g_rtdv_d_o.rtdv029 THEN   #160824-00007#21 Mark By ken 160926
                  CALL artt405_rtdv009(g_rtdv_d[l_ac].rtdv029)        #160824-00007#21 Add By ken 160926
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtdv_d[l_ac].rtdv029
                     #160318-00005#41 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#41 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtdv_d[l_ac].rtdv029 = g_rtdv_d_t.rtdv029   #160824-00007#21 Mark By ken 160926
                     LET g_rtdv_d[l_ac].rtdv029 = g_rtdv_d_o.rtdv029    #160824-00007#21 Add By ken 160926
                     CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv029)
                        RETURNING g_rtdv_d[l_ac].rtdv029_desc
                     NEXT FIELD rtdv029
                  END IF
               END IF
            END IF
            CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv029)
               RETURNING g_rtdv_d[l_ac].rtdv029_desc
            LET g_rtdv_d_o.* = g_rtdv_d[l_ac].*     #160824-00007#21 Add By ken 160926

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv029
            #add-point:BEFORE FIELD rtdv029 name="input.b.page1.rtdv029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv029
            #add-point:ON CHANGE rtdv029 name="input.g.page1.rtdv029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv040
            #add-point:BEFORE FIELD rtdv040 name="input.b.page1.rtdv040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv040
            
            #add-point:AFTER FIELD rtdv040 name="input.a.page1.rtdv040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv040
            #add-point:ON CHANGE rtdv040 name="input.g.page1.rtdv040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv039
            #add-point:BEFORE FIELD rtdv039 name="input.b.page1.rtdv039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv039
            
            #add-point:AFTER FIELD rtdv039 name="input.a.page1.rtdv039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv039
            #add-point:ON CHANGE rtdv039 name="input.g.page1.rtdv039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv003
            #add-point:BEFORE FIELD rtdv003 name="input.b.page1.rtdv003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv003
            
            #add-point:AFTER FIELD rtdv003 name="input.a.page1.rtdv003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv003
            #add-point:ON CHANGE rtdv003 name="input.g.page1.rtdv003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv010
            
            #add-point:AFTER FIELD rtdv010 name="input.a.page1.rtdv010"
            LET g_rtdv_d[l_ac].rtdv010_desc = null
            DISPLAY  g_rtdv_d[l_ac].rtdv010_desc to s_detail1[l_ac].rtdv010_desc
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv010) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_rtdv_d[l_ac].rtdv010 != g_rtdv_d_t.rtdv010 ))) THEN   #160824-00007#21 Mark By ken 160926
               IF g_rtdv_d[l_ac].rtdv010 != g_rtdv_d_o.rtdv010 THEN    #160824-00007#21 Add By ken 160926
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtdv_d[l_ac].rtdv010
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#21  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooca001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     #LET g_rtdv_d[l_ac].rtdv010 = g_rtdv_d_t.rtdv010  #160824-00007#21 Mark By ken 160926
                     LET g_rtdv_d[l_ac].rtdv010 = g_rtdv_d_o.rtdv010   #160824-00007#21 Add By ken 160926
                     CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv010)
                        RETURNING g_rtdv_d[l_ac].rtdv010_desc
                     NEXT FIELD rtdv010
                  END IF
               END IF
            END IF
            CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv010)
               RETURNING g_rtdv_d[l_ac].rtdv010_desc
            LET g_rtdv_d_o.* = g_rtdv_d[l_ac].*    #160824-00007#21 Add By ken 160926

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv010
            #add-point:BEFORE FIELD rtdv010 name="input.b.page1.rtdv010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv010
            #add-point:ON CHANGE rtdv010 name="input.g.page1.rtdv010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv013
            
            #add-point:AFTER FIELD rtdv013 name="input.a.page1.rtdv013"
            LET g_rtdv_d[l_ac].rtdv013_desc = null
            DISPLAY  g_rtdv_d[l_ac].rtdv013_desc to s_detail1[l_ac].rtdv013_desc
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv013) THEN              
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_rtdv_d[l_ac].rtdv013 != g_rtdv_d_t.rtdv013 ))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtdv_d[l_ac].rtdv013
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#21  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     LET g_rtdv_d[l_ac].rtdv013 = g_rtdv_d_t.rtdv013
                     CALL s_desc_get_person_desc(g_rtdv_d[l_ac].rtdv013)
                        RETURNING g_rtdv_d[l_ac].rtdv013_desc
                     NEXT FIELD rtdv013
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_rtdv_d[l_ac].rtdv013)
               RETURNING g_rtdv_d[l_ac].rtdv013_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv013
            #add-point:BEFORE FIELD rtdv013 name="input.b.page1.rtdv013"
            CALL artt405_set_entry_b(l_cmd)             
            CALL artt405_set_no_entry_b(l_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv013
            #add-point:ON CHANGE rtdv013 name="input.g.page1.rtdv013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv014,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtdv014
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv014 name="input.a.page1.rtdv014"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv014) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv014
            #add-point:BEFORE FIELD rtdv014 name="input.b.page1.rtdv014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv014
            #add-point:ON CHANGE rtdv014 name="input.g.page1.rtdv014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv015,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtdv015
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv015 name="input.a.page1.rtdv015"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv015) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv015
            #add-point:BEFORE FIELD rtdv015 name="input.b.page1.rtdv015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv015
            #add-point:ON CHANGE rtdv015 name="input.g.page1.rtdv015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv016,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD rtdv016
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv016 name="input.a.page1.rtdv016"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv016) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv016
            #add-point:BEFORE FIELD rtdv016 name="input.b.page1.rtdv016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv016
            #add-point:ON CHANGE rtdv016 name="input.g.page1.rtdv016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv034
            #add-point:BEFORE FIELD rtdv034 name="input.b.page1.rtdv034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv034
            
            #add-point:AFTER FIELD rtdv034 name="input.a.page1.rtdv034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv034
            #add-point:ON CHANGE rtdv034 name="input.g.page1.rtdv034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv035
            #add-point:BEFORE FIELD rtdv035 name="input.b.page1.rtdv035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv035
            
            #add-point:AFTER FIELD rtdv035 name="input.a.page1.rtdv035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv035
            #add-point:ON CHANGE rtdv035 name="input.g.page1.rtdv035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv036
            #add-point:BEFORE FIELD rtdv036 name="input.b.page1.rtdv036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv036
            
            #add-point:AFTER FIELD rtdv036 name="input.a.page1.rtdv036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv036
            #add-point:ON CHANGE rtdv036 name="input.g.page1.rtdv036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv037
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv037,"0.000","1","100.000","1","azz-00087",1) THEN 
 
               NEXT FIELD rtdv037
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv037 name="input.a.page1.rtdv037"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv037) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv037
            #add-point:BEFORE FIELD rtdv037 name="input.b.page1.rtdv037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv037
            #add-point:ON CHANGE rtdv037 name="input.g.page1.rtdv037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv038
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdv_d[l_ac].rtdv038,"0.000","1","100.000","1","azz-00087",1) THEN 
 
               NEXT FIELD rtdv038
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdv038 name="input.a.page1.rtdv038"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv038) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv038
            #add-point:BEFORE FIELD rtdv038 name="input.b.page1.rtdv038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv038
            #add-point:ON CHANGE rtdv038 name="input.g.page1.rtdv038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv032
            
            #add-point:AFTER FIELD rtdv032 name="input.a.page1.rtdv032"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv032) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_rtdv_d[l_ac].rtdv032 != g_rtdv_d_t.rtdv032 ))) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtdv_d[l_ac].rtdv032
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#21  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooca001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     LET g_rtdv_d[l_ac].rtdv032 = g_rtdv_d_t.rtdv032
                     CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv032)
                        RETURNING g_rtdv_d[l_ac].rtdv032_desc
                     NEXT FIELD rtdv032
                  END IF
               END IF
            END IF
            CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv032)
               RETURNING g_rtdv_d[l_ac].rtdv032_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv032
            #add-point:BEFORE FIELD rtdv032 name="input.b.page1.rtdv032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv032
            #add-point:ON CHANGE rtdv032 name="input.g.page1.rtdv032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv027
            #add-point:BEFORE FIELD rtdv027 name="input.b.page1.rtdv027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv027
            
            #add-point:AFTER FIELD rtdv027 name="input.a.page1.rtdv027"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv027) AND NOT cl_null(g_rtdv_d[l_ac].rtdv028) THEN 
               IF g_rtdv_d[l_ac].rtdv027 > g_rtdv_d[l_ac].rtdv028 THEN
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = "aoo-00122"   #160623-00028#1
                  LET g_errparam.code = "ais-00047"    #160623-00028#1
                  LET g_errparam.extend = g_rtdv_d[l_ac].rtdv027||'-'||g_rtdv_d[l_ac].rtdv028
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtdv_d[l_ac].rtdv027 = g_rtdv_d_t.rtdv027
                  NEXT FIELD rtdv027
               END IF
            END IF
            IF g_rtdv_d[l_ac].rtdv027<g_rtdu_m.stan017 OR g_rtdv_d[l_ac].rtdv027>g_rtdu_m.stan018 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "art-00288"
               LET g_errparam.extend = g_rtdv_d[l_ac].rtdv027
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_rtdv_d[l_ac].rtdv027 = g_rtdv_d_t.rtdv027
               NEXT FIELD rtdv027
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv027
            #add-point:ON CHANGE rtdv027 name="input.g.page1.rtdv027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdv028
            #add-point:BEFORE FIELD rtdv028 name="input.b.page1.rtdv028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdv028
            
            #add-point:AFTER FIELD rtdv028 name="input.a.page1.rtdv028"
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv027) AND NOT cl_null(g_rtdv_d[l_ac].rtdv028) THEN 
               IF g_rtdv_d[l_ac].rtdv027 > g_rtdv_d[l_ac].rtdv028 THEN
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = "aoo-00122"    #160623-00028#1
                  LET g_errparam.code = "ais-00048"     #160623-00028#1
                  LET g_errparam.extend = g_rtdv_d[l_ac].rtdv027||'-'||g_rtdv_d[l_ac].rtdv028
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtdv_d[l_ac].rtdv028 = g_rtdv_d_t.rtdv028
                  NEXT FIELD rtdv028
               END IF
               IF g_rtdv_d[l_ac].rtdv028<g_rtdu_m.stan017 OR g_rtdv_d[l_ac].rtdv028>g_rtdu_m.stan018 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "art-00288"
                  LET g_errparam.extend = g_rtdv_d[l_ac].rtdv028
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtdv_d[l_ac].rtdv028 = g_rtdv_d_t.rtdv028
                  NEXT FIELD rtdv028
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdv028
            #add-point:ON CHANGE rtdv028 name="input.g.page1.rtdv028"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtdvseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdvseq
            #add-point:ON ACTION controlp INFIELD rtdvseq name="input.c.page1.rtdvseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv002
            #add-point:ON ACTION controlp INFIELD rtdv002 name="input.c.page1.rtdv002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'i'                 
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdv_d[l_ac].rtdv002             #給予default值

            #給予arg
            CALL q_imay003_3()                                #呼叫開窗
            LET g_qryparam.where = NULL
            LET g_rtdv_d[l_ac].rtdv002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtdv_d[l_ac].rtdv002 TO rtdv002              #顯示到畫面上

            CALL artt405_null_rtdv001()
            LET g_rtdv_d[l_ac].rtdv001 = NULL
#            DISPLAY g_rtdv_d[l_ac].rtdv001 TO s_detail1[l_ac].rtdv001
            IF NOT cl_null(g_rtdv_d[l_ac].rtdv002) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_rtdv_d[l_ac].rtdv002 != g_rtdv_d_t.rtdv002 ))) THEN   #160824-00007#21 Mark By ken 160926
               IF g_rtdv_d[l_ac].rtdv002 != g_rtdv_d_o.rtdv002 THEN    #160824-00007#21 Add By ken 160926
                  CALL artt405_rtdv002(g_rtdv_d[l_ac].rtdv002)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtdv_d[l_ac].rtdv002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_t.rtdv002   #160824-00007#21 Mark By ken 160926
                     LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_o.rtdv002    #160824-00007#21 Add By ken 160926
                     CALL artt405_rtdv002_display(g_rtdv_d[l_ac].rtdv002)
                     CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
                     NEXT FIELD rtdv002
                  END IF
                  CALL artt405_rtdv002_display(g_rtdv_d[l_ac].rtdv002)
                  IF NOT cl_null(g_rtdv_d[l_ac].rtdv001) THEN            
                     CALL artt405_unique_rtdv001(g_rtdv_d[l_ac].rtdv001,g_rtdv_d_t.rtdvseq)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_rtdv_d[l_ac].rtdv001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_t.rtdv002  #160824-00007#21 Mark By ken 160926
                        #LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_t.rtdv001  #160824-00007#21 Mark By ken 160926
                        LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_o.rtdv002   #160824-00007#21 Add By ken 160926
                        LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_o.rtdv001   #160824-00007#21 Add By ken 160926         
                        CALL artt405_rtdv002_display(g_rtdv_d[l_ac].rtdv002)
                        CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
                        NEXT FIELD rtdv002
                     END IF
                     CALL artt405_chk_imaa009(g_rtdv_d[l_ac].rtdv001)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_rtdv_d[l_ac].rtdv001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_t.rtdv002  #160824-00007#21 Mark By ken 160926
                        #LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_t.rtdv001  #160824-00007#21 Mark By ken 160926
                        LET g_rtdv_d[l_ac].rtdv002 = g_rtdv_d_o.rtdv002   #160824-00007#21 Add By ken 160926
                        LET g_rtdv_d[l_ac].rtdv001 = g_rtdv_d_o.rtdv001   #160824-00007#21 Add By ken 160926                         
                        CALL artt405_rtdv002_display(g_rtdv_d[l_ac].rtdv002)
                        CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
                        NEXT FIELD rtdv002
                     END IF
                     IF g_rtdu_m.rtdu003 = '3' AND (g_rtdv_d_t.rtdv001 IS NULL OR g_rtdv_d_t.rtdv001 = g_rtdv_d[l_ac].rtdv001) THEN
                        #CALL artt405_rtdw039_init() RETURNING l_cost    #20151125 dongsz mark
                        CALL s_astt313_get_stao012(g_rtdu_m.rtdusite,g_rtdu_m.rtdu002,g_rtdv_d[l_ac].rtdv001,g_rtdu_m.rtdudocdt) RETURNING l_cost    #20151125 dongsz add 
                        LET g_rtdv_d[l_ac].rtdv039 = l_cost
                     END IF   
                  END IF
               END IF
            END IF
           
            CALL artt405_rtdv002_display(g_rtdv_d[l_ac].rtdv002)
            CALL artt405_rtdv001_display(g_rtdv_d[l_ac].rtdv001,l_cmd)
            LET g_rtdv_d_t.* = g_rtdv_d[l_ac].*
            LET g_rtdv_d_o.* = g_rtdv_d[l_ac].*    #160824-00007#21 Add By ken 160926 
            
            NEXT FIELD rtdv002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv001
            #add-point:ON ACTION controlp INFIELD rtdv001 name="input.c.page1.rtdv001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'i'                 
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdv_d[l_ac].rtdv001             #給予default值

            #給予arg
            CALL q_imay001()                                #呼叫開窗

            LET g_rtdv_d[l_ac].rtdv001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtdv_d[l_ac].rtdv001 TO rtdv001              #顯示到畫面上

            NEXT FIELD rtdv001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv018
            #add-point:ON ACTION controlp INFIELD rtdv018 name="input.c.page1.rtdv018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv023
            #add-point:ON ACTION controlp INFIELD rtdv023 name="input.c.page1.rtdv023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv101
            #add-point:ON ACTION controlp INFIELD rtdv101 name="input.c.page1.rtdv101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv024
            #add-point:ON ACTION controlp INFIELD rtdv024 name="input.c.page1.rtdv024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv025
            #add-point:ON ACTION controlp INFIELD rtdv025 name="input.c.page1.rtdv025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv026
            #add-point:ON ACTION controlp INFIELD rtdv026 name="input.c.page1.rtdv026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv102
            #add-point:ON ACTION controlp INFIELD rtdv102 name="input.c.page1.rtdv102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv103
            #add-point:ON ACTION controlp INFIELD rtdv103 name="input.c.page1.rtdv103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv020
            #add-point:ON ACTION controlp INFIELD rtdv020 name="input.c.page1.rtdv020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv021
            #add-point:ON ACTION controlp INFIELD rtdv021 name="input.c.page1.rtdv021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv022
            #add-point:ON ACTION controlp INFIELD rtdv022 name="input.c.page1.rtdv022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv004
            #add-point:ON ACTION controlp INFIELD rtdv004 name="input.c.page1.rtdv004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'i'                  
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdv_d[l_ac].rtdv004             #給予default值
            let g_qryparam.where = "oodb004='1' AND oodb001='",g_rtdu_m.rtdu011,"' "
            #給予arg

            CALL q_oodb002()                                #呼叫開窗

            LET g_rtdv_d[l_ac].rtdv004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtdv_d[l_ac].rtdv004 TO rtdv004              #顯示到畫面上
            CALL artt405_rtdv004_display(g_rtdv_d[l_ac].rtdv004)
            #150827-00026#1 150831 by sakura mark&add(S)
            #CALL artt405_rtdv005_rtdv030(g_rtdv_d[l_ac].rtdv004)
            CALL artt405_oodb006_oodb005(g_rtdv_d[l_ac].rtdv004)
            #150827-00026#1 150831 by sakura mark&add(E)
            NEXT FIELD rtdv004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.l_oodb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_oodb006
            #add-point:ON ACTION controlp INFIELD l_oodb006 name="input.c.page1.l_oodb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_oodb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_oodb005
            #add-point:ON ACTION controlp INFIELD l_oodb005 name="input.c.page1.l_oodb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv006
            #add-point:ON ACTION controlp INFIELD rtdv006 name="input.c.page1.rtdv006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdv_d[l_ac].rtdv006             #給予default值
            let g_qryparam.where = "oodb004='1' AND oodb001='",g_rtdu_m.rtdu011,"' "
            #給予arg

            CALL q_oodb002()                                #呼叫開窗
            
            LET g_rtdv_d[l_ac].rtdv006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtdv_d[l_ac].rtdv006 TO rtdv006              #顯示到畫面上
            CALL artt405_rtdv006_display(g_rtdv_d[l_ac].rtdv006)
            #150827-00026#1 150831 by sakura mark&add(S)
            #CALL artt405_rtdv007_rtdv030(g_rtdv_d[l_ac].rtdv006)
            CALL artt405_oodb0061_oodb0051(g_rtdv_d[l_ac].rtdv006)            
            #150827-00026#1 150831 by sakura mark&add(E)
            NEXT FIELD rtdv006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.l_oodb0061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_oodb0061
            #add-point:ON ACTION controlp INFIELD l_oodb0061 name="input.c.page1.l_oodb0061"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_oodb0051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_oodb0051
            #add-point:ON ACTION controlp INFIELD l_oodb0051 name="input.c.page1.l_oodb0051"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv008
            #add-point:ON ACTION controlp INFIELD rtdv008 name="input.c.page1.rtdv008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv012
            #add-point:ON ACTION controlp INFIELD rtdv012 name="input.c.page1.rtdv012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv009
            #add-point:ON ACTION controlp INFIELD rtdv009 name="input.c.page1.rtdv009"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdv_d[l_ac].rtdv009             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_rtdv_d[l_ac].rtdv009 = g_qryparam.return1              

            DISPLAY g_rtdv_d[l_ac].rtdv009 TO rtdv009              #
            CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv009)
               RETURNING g_rtdv_d[l_ac].rtdv009_desc
            NEXT FIELD rtdv009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv011
            #add-point:ON ACTION controlp INFIELD rtdv011 name="input.c.page1.rtdv011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv033
            #add-point:ON ACTION controlp INFIELD rtdv033 name="input.c.page1.rtdv033"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdv_d[l_ac].rtdv033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_aooi001_1()                                #呼叫開窗

            LET g_rtdv_d[l_ac].rtdv033 = g_qryparam.return1              

            DISPLAY g_rtdv_d[l_ac].rtdv033 TO rtdv033              #

            NEXT FIELD rtdv033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv017
            #add-point:ON ACTION controlp INFIELD rtdv017 name="input.c.page1.rtdv017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv019
            #add-point:ON ACTION controlp INFIELD rtdv019 name="input.c.page1.rtdv019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv031
            #add-point:ON ACTION controlp INFIELD rtdv031 name="input.c.page1.rtdv031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv029
            #add-point:ON ACTION controlp INFIELD rtdv029 name="input.c.page1.rtdv029"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdv_d[l_ac].rtdv029             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_rtdv_d[l_ac].rtdv029 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtdv_d[l_ac].rtdv029 TO rtdv029              #顯示到畫面上
            CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv029)
               RETURNING g_rtdv_d[l_ac].rtdv029_desc
            NEXT FIELD rtdv029                          #返回原欄位  


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv040
            #add-point:ON ACTION controlp INFIELD rtdv040 name="input.c.page1.rtdv040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv039
            #add-point:ON ACTION controlp INFIELD rtdv039 name="input.c.page1.rtdv039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv003
            #add-point:ON ACTION controlp INFIELD rtdv003 name="input.c.page1.rtdv003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv010
            #add-point:ON ACTION controlp INFIELD rtdv010 name="input.c.page1.rtdv010"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'i'                  
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdv_d[l_ac].rtdv010             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_rtdv_d[l_ac].rtdv010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtdv_d[l_ac].rtdv010 TO rtdv010              #顯示到畫面上
            CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv010)
               RETURNING g_rtdv_d[l_ac].rtdv010_desc
            NEXT FIELD rtdv010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv013
            #add-point:ON ACTION controlp INFIELD rtdv013 name="input.c.page1.rtdv013"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdv_d[l_ac].rtdv013             #給予default值

            #給予arg

            CALL q_ooag001_4()                                #呼叫開窗

            LET g_rtdv_d[l_ac].rtdv013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtdv_d[l_ac].rtdv013 TO rtdv013              #顯示到畫面上
            CALL s_desc_get_person_desc(g_rtdv_d[l_ac].rtdv013)
               RETURNING g_rtdv_d[l_ac].rtdv013_desc
            NEXT FIELD rtdv013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv014
            #add-point:ON ACTION controlp INFIELD rtdv014 name="input.c.page1.rtdv014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv015
            #add-point:ON ACTION controlp INFIELD rtdv015 name="input.c.page1.rtdv015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv016
            #add-point:ON ACTION controlp INFIELD rtdv016 name="input.c.page1.rtdv016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv034
            #add-point:ON ACTION controlp INFIELD rtdv034 name="input.c.page1.rtdv034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv035
            #add-point:ON ACTION controlp INFIELD rtdv035 name="input.c.page1.rtdv035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv036
            #add-point:ON ACTION controlp INFIELD rtdv036 name="input.c.page1.rtdv036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv037
            #add-point:ON ACTION controlp INFIELD rtdv037 name="input.c.page1.rtdv037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv038
            #add-point:ON ACTION controlp INFIELD rtdv038 name="input.c.page1.rtdv038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv032
            #add-point:ON ACTION controlp INFIELD rtdv032 name="input.c.page1.rtdv032"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdv_d[l_ac].rtdv032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_rtdv_d[l_ac].rtdv032 = g_qryparam.return1              

            DISPLAY g_rtdv_d[l_ac].rtdv032 TO rtdv032              #
            CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv032)
               RETURNING g_rtdv_d[l_ac].rtdv032_desc

            NEXT FIELD rtdv032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv027
            #add-point:ON ACTION controlp INFIELD rtdv027 name="input.c.page1.rtdv027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdv028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdv028
            #add-point:ON ACTION controlp INFIELD rtdv028 name="input.c.page1.rtdv028"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtdv_d[l_ac].* = g_rtdv_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt405_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtdv_d[l_ac].rtdvseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rtdv_d[l_ac].* = g_rtdv_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL artt405_rtdv_t_mask_restore('restore_mask_o')
      
               UPDATE rtdv_t SET (rtdvdocno,rtdvseq,rtdv002,rtdv001,rtdv018,rtdv023,rtdv101,rtdv024, 
                   rtdv025,rtdv026,rtdv102,rtdv103,rtdv020,rtdv021,rtdv022,rtdv004,rtdv006,rtdv008,rtdv012, 
                   rtdv009,rtdv011,rtdv033,rtdv017,rtdv019,rtdv031,rtdv029,rtdv040,rtdv039,rtdv003,rtdv010, 
                   rtdv013,rtdv014,rtdv015,rtdv016,rtdv034,rtdv035,rtdv036,rtdv037,rtdv038,rtdv032,rtdv027, 
                   rtdv028) = (g_rtdu_m.rtdudocno,g_rtdv_d[l_ac].rtdvseq,g_rtdv_d[l_ac].rtdv002,g_rtdv_d[l_ac].rtdv001, 
                   g_rtdv_d[l_ac].rtdv018,g_rtdv_d[l_ac].rtdv023,g_rtdv_d[l_ac].rtdv101,g_rtdv_d[l_ac].rtdv024, 
                   g_rtdv_d[l_ac].rtdv025,g_rtdv_d[l_ac].rtdv026,g_rtdv_d[l_ac].rtdv102,g_rtdv_d[l_ac].rtdv103, 
                   g_rtdv_d[l_ac].rtdv020,g_rtdv_d[l_ac].rtdv021,g_rtdv_d[l_ac].rtdv022,g_rtdv_d[l_ac].rtdv004, 
                   g_rtdv_d[l_ac].rtdv006,g_rtdv_d[l_ac].rtdv008,g_rtdv_d[l_ac].rtdv012,g_rtdv_d[l_ac].rtdv009, 
                   g_rtdv_d[l_ac].rtdv011,g_rtdv_d[l_ac].rtdv033,g_rtdv_d[l_ac].rtdv017,g_rtdv_d[l_ac].rtdv019, 
                   g_rtdv_d[l_ac].rtdv031,g_rtdv_d[l_ac].rtdv029,g_rtdv_d[l_ac].rtdv040,g_rtdv_d[l_ac].rtdv039, 
                   g_rtdv_d[l_ac].rtdv003,g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv013,g_rtdv_d[l_ac].rtdv014, 
                   g_rtdv_d[l_ac].rtdv015,g_rtdv_d[l_ac].rtdv016,g_rtdv_d[l_ac].rtdv034,g_rtdv_d[l_ac].rtdv035, 
                   g_rtdv_d[l_ac].rtdv036,g_rtdv_d[l_ac].rtdv037,g_rtdv_d[l_ac].rtdv038,g_rtdv_d[l_ac].rtdv032, 
                   g_rtdv_d[l_ac].rtdv027,g_rtdv_d[l_ac].rtdv028)
                WHERE rtdvent = g_enterprise AND rtdvdocno = g_rtdu_m.rtdudocno 
 
                  AND rtdvseq = g_rtdv_d_t.rtdvseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rtdv_d[l_ac].* = g_rtdv_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdv_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtdv_d[l_ac].* = g_rtdv_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdv_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdu_m.rtdudocno
               LET gs_keys_bak[1] = g_rtdudocno_t
               LET gs_keys[2] = g_rtdv_d[g_detail_idx].rtdvseq
               LET gs_keys_bak[2] = g_rtdv_d_t.rtdvseq
               CALL artt405_update_b('rtdv_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL artt405_rtdv_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rtdv_d[g_detail_idx].rtdvseq = g_rtdv_d_t.rtdvseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rtdu_m.rtdudocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rtdv_d_t.rtdvseq
 
                  CALL artt405_key_update_b(gs_keys,'rtdv_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtdu_m),util.JSON.stringify(g_rtdv_d_t)
               LET g_log2 = util.JSON.stringify(g_rtdu_m),util.JSON.stringify(g_rtdv_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            CALL artt405_sum_rtdv020()  #add by geza 20160315 #刷新单头金额
            #end add-point
            CALL artt405_unlock_b("rtdv_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            #CALL artt405_b_fill()   #150213-00006#3 2015/02/13 By pomelo add
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rtdv_d[li_reproduce_target].* = g_rtdv_d[li_reproduce].*
 
               LET g_rtdv_d[li_reproduce_target].rtdvseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtdv_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtdv_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_rtdv2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtdv2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt405_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_rtdv2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtdv2_d[l_ac].* TO NULL 
            INITIALIZE g_rtdv2_d_t.* TO NULL 
            INITIALIZE g_rtdv2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_rtdv2_d_t.* = g_rtdv2_d[l_ac].*     #新輸入資料
            LET g_rtdv2_d_o.* = g_rtdv2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt405_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL artt405_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtdv2_d[li_reproduce_target].* = g_rtdv2_d[li_reproduce].*
 
               LET g_rtdv2_d[li_reproduce_target].rtdw001 = NULL
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
            OPEN artt405_cl USING g_enterprise,g_rtdu_m.rtdudocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt405_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt405_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rtdv2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rtdv2_d[l_ac].rtdw001 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_rtdv2_d_t.* = g_rtdv2_d[l_ac].*  #BACKUP
               LET g_rtdv2_d_o.* = g_rtdv2_d[l_ac].*  #BACKUP
               CALL artt405_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               DISPLAY BY NAME g_rtdv2_d[l_ac].rtdw002   #150515-00006#1 150518 by lori522612 add  
               #end add-point  
               CALL artt405_set_no_entry_b(l_cmd)
               IF NOT artt405_lock_b("rtdw_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt405_bcl2 INTO g_rtdv2_d[l_ac].rtdw001,g_rtdv2_d[l_ac].rtdw002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtdv2_d_mask_o[l_ac].* =  g_rtdv2_d[l_ac].*
                  CALL artt405_rtdw_t_mask()
                  LET g_rtdv2_d_mask_n[l_ac].* =  g_rtdv2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt405_show()
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
               LET gs_keys[01] = g_rtdu_m.rtdudocno
               LET gs_keys[gs_keys.getLength()+1] = g_rtdv2_d_t.rtdw001
            
               #刪除同層單身
               IF NOT artt405_delete_b('rtdw_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt405_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt405_key_delete_b(gs_keys,'rtdw_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt405_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE artt405_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_rtdv_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rtdv2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM rtdw_t 
             WHERE rtdwent = g_enterprise AND rtdwdocno = g_rtdu_m.rtdudocno
               AND rtdw001 = g_rtdv2_d[l_ac].rtdw001
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdu_m.rtdudocno
               LET gs_keys[2] = g_rtdv2_d[g_detail_idx].rtdw001
               CALL artt405_insert_b('rtdw_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rtdv_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "rtdw_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt405_b_fill()
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
               LET g_rtdv2_d[l_ac].* = g_rtdv2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt405_bcl2
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
               LET g_rtdv2_d[l_ac].* = g_rtdv2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL artt405_rtdw_t_mask_restore('restore_mask_o')
                              
               UPDATE rtdw_t SET (rtdwdocno,rtdw001,rtdw002) = (g_rtdu_m.rtdudocno,g_rtdv2_d[l_ac].rtdw001, 
                   g_rtdv2_d[l_ac].rtdw002) #自訂欄位頁簽
                WHERE rtdwent = g_enterprise AND rtdwdocno = g_rtdu_m.rtdudocno
                  AND rtdw001 = g_rtdv2_d_t.rtdw001 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rtdv2_d[l_ac].* = g_rtdv2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdw_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtdv2_d[l_ac].* = g_rtdv2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdw_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdu_m.rtdudocno
               LET gs_keys_bak[1] = g_rtdudocno_t
               LET gs_keys[2] = g_rtdv2_d[g_detail_idx].rtdw001
               LET gs_keys_bak[2] = g_rtdv2_d_t.rtdw001
               CALL artt405_update_b('rtdw_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL artt405_rtdw_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_rtdv2_d[g_detail_idx].rtdw001 = g_rtdv2_d_t.rtdw001 
                  ) THEN
                  LET gs_keys[01] = g_rtdu_m.rtdudocno
                  LET gs_keys[gs_keys.getLength()+1] = g_rtdv2_d_t.rtdw001
                  CALL artt405_key_update_b(gs_keys,'rtdw_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtdu_m),util.JSON.stringify(g_rtdv2_d_t)
               LET g_log2 = util.JSON.stringify(g_rtdu_m),util.JSON.stringify(g_rtdv2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdw001
            
            #add-point:AFTER FIELD rtdw001 name="input.a.page2.rtdw001"
            #應用 a05 樣板自動產生(Version:2)
            #150515-00006#1 150516 by lori522612 mark---(S)
            #LET g_rtdv2_d[l_ac].rtdw001_desc = NULL
            #LET g_rtdv2_d[l_ac].ooef019= NULL
            #DISPLAY  g_rtdv2_d[l_ac].rtdw001_desc,g_rtdv2_d[l_ac].ooef019
            #     TO s_detail3[l_ac].rtdw001_desc,s_detail3[l_ac].ooef019
            #
            ##此段落由子樣板a05產生
            ##IF  NOT cl_null(g_rtdu_m.rtdudocno) AND NOT cl_null(g_rtdv2_d[l_ac].rtdw001) AND NOT cl_null(g_rtdu_m.rtdu008) THEN                                        #150505-00012#1--mark by dongsz
            #IF NOT cl_null(g_rtdu_m.rtdudocno) AND NOT cl_null(g_rtdv2_d[l_ac].rtdw001) THEN                                                                            #150505-00012#1--add by dongsz
            #   IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_rtdu_m.rtdudocno != g_rtdudocno_t OR g_rtdv2_d[l_ac].rtdw001 != g_rtdv2_d_t.rtdw001))) THEN    
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdw_t WHERE "||"rtdwent = '" ||g_enterprise|| "' AND "||"rtdwdocno = '"||g_rtdu_m.rtdudocno ||"' AND "|| "rtdw001 = '"||g_rtdv2_d[l_ac].rtdw001 ||"'",'std-00004',0) THEN 
            #         LET g_rtdv2_d[l_ac].rtdw001 = g_rtdv2_d_t.rtdw001                
            #         NEXT FIELD CURRENT
            #      END IF
            #      CALL artt405_rtdw001()
            #      IF NOT cl_null(g_errno) THEN
            #         INITIALIZE g_errparam TO NULL
            #         LET g_errparam.code = g_errno
            #         LET g_errparam.extend = g_rtdv2_d[l_ac].rtdw001
            #         LET g_errparam.popup = TRUE
            #         CALL cl_err()
            #
            #         LET g_rtdv2_d[l_ac].rtdw001 = g_rtdv2_d_t.rtdw001 
            #         CALL artt405_display_rtdw001(g_rtdv2_d[l_ac].rtdw001)
            #         NEXT FIELD rtdw001
            #      END IF
            #   END IF
            #   
            #END IF
            ##判断门店编号是否有效  geza 2015/03/31
            #IF NOT cl_null(g_rtdv2_d[l_ac].rtdw001) THEN 
            #   LET l_cnt = 0 
            #   SELECT COUNT(*) INTO l_cnt FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_rtdv2_d[l_ac].rtdw001
            #   AND ooefstus = 'Y'
            #   IF l_cnt <= 0 THEN 
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = "art-00526"
            #      LET g_errparam.extend = g_rtdv2_d[l_ac].rtdw001
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #
            #      LET g_rtdv2_d[l_ac].rtdw001 = g_rtdv2_d_t.rtdw001      
            #      CALL artt405_display_rtdw001(g_rtdv2_d[l_ac].rtdw001)
            #      NEXT FIELD rtdw001
            #   END IF 
            #END IF
            ##判断门店的税区与当头的税区别是否一致  geza 2015/03/30
            #IF NOT cl_null(g_rtdv2_d[l_ac].rtdw001) THEN 
            #   SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_rtdv2_d[l_ac].rtdw001
            #   AND ooefstus = 'Y'
            #   IF l_ooef019 != g_rtdu_m.rtdu011 THEN 
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = "art-00525"
            #      LET g_errparam.extend = g_rtdv2_d[l_ac].rtdw001
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #
            #      LET g_rtdv2_d[l_ac].rtdw001 = g_rtdv2_d_t.rtdw001  
            #      CALL artt405_display_rtdw001(g_rtdv2_d[l_ac].rtdw001)
            #      NEXT FIELD rtdw001
            #   END IF 
            #END IF
            #
            #CALL artt405_display_rtdw001(g_rtdv2_d[l_ac].rtdw001)
            #150515-00006#1 150516 by lori522612 mark---(E)
            
            #150515-00006#1 150516 by lori522612 add---(S)
            LET g_rtdv2_d[l_ac].rtdw001_desc = ''
            LET g_rtdv2_d[l_ac].ooef019 = ''      
            IF NOT cl_null(g_rtdu_m.rtdudocno) AND NOT cl_null(g_rtdv2_d[l_ac].rtdw001) THEN                                                                            #150505-00012#1--add by dongsz
#               IF g_rtdu_m.rtdudocno != g_rtdudocno_t OR g_rtdv2_d[l_ac].rtdw001 != g_rtdv2_d_o.rtdw001 THEN   #150527-00018#1 150527 by geza mark 
                IF g_rtdu_m.rtdudocno != g_rtdudocno_t OR g_rtdv2_d[l_ac].rtdw001 != g_rtdv2_d_o.rtdw001 OR g_rtdv2_d_o.rtdw001 IS NULL THEN   #150527-00018#1 150527 by geza add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdw_t WHERE rtdwent = '" ||g_enterprise|| "' AND rtdwdocno = '"||g_rtdu_m.rtdudocno ||"' AND  rtdw001 = '"||g_rtdv2_d[l_ac].rtdw001 ||"'",'std-00004',0) THEN 
                     LET g_rtdv2_d[l_ac].rtdw001 = g_rtdv2_d_t.rtdw001                
                     NEXT FIELD CURRENT
                  END IF
                  CALL artt405_rtdw001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtdv2_d[l_ac].rtdw001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_rtdv2_d[l_ac].rtdw001 = g_rtdv2_d_o.rtdw001 
                     CALL artt405_rtdw001_display(g_rtdv2_d[l_ac].rtdw001)
                     NEXT FIELD rtdw001
                  END IF
                  #判断门店编号是否有效  geza 2015/03/31
                  LET l_cnt = 0 
                  SELECT COUNT(*) INTO l_cnt 
                    FROM ooef_t 
                   WHERE ooefent = g_enterprise 
                     AND ooef001 = g_rtdv2_d[l_ac].rtdw001
                     AND ooefstus = 'Y'
                  IF l_cnt <= 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "art-00526"
                     LET g_errparam.extend = g_rtdv2_d[l_ac].rtdw001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_rtdv2_d[l_ac].rtdw001 = g_rtdv2_d_o.rtdw001      
                     CALL artt405_rtdw001_display(g_rtdv2_d[l_ac].rtdw001)
                     NEXT FIELD rtdw001
                  END IF
                  #判断门店的税区与当头的税区别是否一致  geza 2015/03/30
                  SELECT ooef019 INTO l_ooef019 
                    FROM ooef_t 
                   WHERE ooefent = g_enterprise 
                     AND ooef001 = g_rtdv2_d[l_ac].rtdw001
                     AND ooefstus = 'Y'
                     
                  IF l_ooef019 != g_rtdu_m.rtdu011 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "art-00525"
                     LET g_errparam.extend = g_rtdv2_d[l_ac].rtdw001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_rtdv2_d[l_ac].rtdw001 = g_rtdv2_d_o.rtdw001  
                     CALL artt405_rtdw001_display(g_rtdv2_d[l_ac].rtdw001)
                     NEXT FIELD rtdw001
                  END IF 
                  #帶值：庫位
                  LET g_rtdv2_d[l_ac].rtdw002 = artt405_get_ooef123(g_rtdv2_d[l_ac].rtdw001)  
                  LET g_rtdv2_d[l_ac].rtdw002_desc = s_desc_get_stock_desc(g_rtdv2_d[l_ac].rtdw001,g_rtdv2_d[l_ac].rtdw002)   
               END IF
            END IF
            CALL artt405_rtdw001_display(g_rtdv2_d[l_ac].rtdw001)   
             
            LET g_rtdv2_d_o.rtdw001 = g_rtdv2_d[l_ac].rtdw001                           
            LET g_rtdv2_d_o.rtdw002 = g_rtdv2_d[l_ac].rtdw002                           
            #150515-00006#1 150516 by lori522612 add---(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdw001
            #add-point:BEFORE FIELD rtdw001 name="input.b.page2.rtdw001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdw001
            #add-point:ON CHANGE rtdw001 name="input.g.page2.rtdw001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdw002
            
            #add-point:AFTER FIELD rtdw002 name="input.a.page2.rtdw002"
            #150515-00006#1 150516 by lori522612 add---(S)  
            LET g_rtdv2_d[l_ac].rtdw002_desc = ''
            IF NOT cl_null(g_rtdv2_d[l_ac].rtdw002) THEN
               IF g_rtdv2_d[l_ac].rtdw002 != g_rtdv2_d_o.rtdw002 OR g_rtdv2_d_o.rtdw002 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtdv2_d[l_ac].rtdw001
                  LET g_chkparam.arg2 = g_rtdv2_d[l_ac].rtdw002
                  LET g_chkparam.err_str[1] = "aim-00064:art-00154"     #160319-00007#1  --- add
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[2] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     LET g_rtdv2_d[l_ac].rtdw002 = g_rtdv2_d_o.rtdw002
                     LET g_rtdv2_d[l_ac].rtdw002_desc = s_desc_get_stock_desc(g_rtdv2_d[l_ac].rtdw001,g_rtdv2_d[l_ac].rtdw002)            
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #150610-00026#1 150611 add---(S)
               #根據經營方式判斷庫位
               IF NOT s_inaa_chk(g_rtdv2_d[l_ac].rtdw001,g_rtdv2_d[l_ac].rtdw002,g_rtdu_m.rtdu003) THEN
                  LET g_rtdv2_d[l_ac].rtdw002 = g_rtdv2_d_o.rtdw002
                  LET g_rtdv2_d[l_ac].rtdw002_desc = s_desc_get_stock_desc(g_rtdv2_d[l_ac].rtdw001,g_rtdv2_d[l_ac].rtdw002)            
                  NEXT FIELD CURRENT
               END IF               
               #150610-00026#1 150611 add---(E)
            END IF            
            LET g_rtdv2_d[l_ac].rtdw002_desc = s_desc_get_stock_desc(g_rtdv2_d[l_ac].rtdw001,g_rtdv2_d[l_ac].rtdw002)            
            LET g_rtdv2_d_o.rtdw002 = g_rtdv2_d[l_ac].rtdw002
            #150515-00006#1 150516 by lori522612 add---(E)  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdw002
            #add-point:BEFORE FIELD rtdw002 name="input.b.page2.rtdw002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdw002
            #add-point:ON CHANGE rtdw002 name="input.g.page2.rtdw002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.rtdw001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdw001
            #add-point:ON ACTION controlp INFIELD rtdw001 name="input.c.page2.rtdw001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add            
            LET g_qryparam.reqry = FALSE
            #150505-00012#1--add by dongsz--str---
            LET l_where = " SELECT ooed004 FROM ooed_t ",
                          "  WHERE ooedent = ",g_enterprise,                                                        #150613-00063#1 1500614 by lori522612 add
                          "  START WITH ooed005 = '",g_rtdu_m.rtdu005,"' AND ooed001 = '10' ",
                          "    AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                          " CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '10' ",
                          "    AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                          "  UNION ",
                          " SELECT ooed004 FROM ooed_t ",
                          "  WHERE ooedent = ",g_enterprise,                                                        #150613-00063#1 1500614 by lori522612 add           
                          "    AND ooed004 = '",g_rtdu_m.rtdu005,"' "
            #150505-00012#1--add by dongsz--end---
            IF l_cmd = 'u' THEN
               LET g_qryparam.default1 = g_rtdv2_d[l_ac].rtdw001             #給予default值
               #根据单头店群值选择开窗  geza 2015/03/31              
               IF NOT cl_null(g_rtdu_m.rtdu008) THEN 
                  #LET g_qryparam.where = " rtab001='",g_rtdu_m.rtdu008,"' "    #150505-00012#1--mark by dongsz
                  LET g_qryparam.where = " rtab001='",g_rtdu_m.rtdu008,"' AND rtab002 IN (",l_where,") "," AND EXISTS (SELECT 1 FROM stbo_t WHERE  stboent = ",g_enterprise," AND stbo003 = rtab002 AND stbo001 = '",g_rtdu_m.rtdu002,"' ) "  #150505-00012#1--add by dongsz
                     
                  CALL q_rtab002()
               ELSE 
                   #150505-00012#1--mark by dongsz--str---       
#                   IF s_aooi500_setpoint(g_prog,'rtdw001') THEN
#                      LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdw001',g_site,'i') 
#                      LET g_qryparam.where = g_qryparam.where," AND ooef001 IN 
#                      ( SELECT ooef001 FROM ooef_t a WHERE a.ooef001 = ooef001 AND a.ooef019 ='",g_rtdu_m.rtdu011,"' )"
#                      CALL q_ooef001_24()
#                   ELSE
#                      LET g_qryparam.where = " ooef303='Y' AND ooef019 ='",g_rtdu_m.rtdu011,"'"
#                      CALL q_ooef001()   
#                   END IF
                   #150505-00012#1--mark by dongsz--end---
                   #150505-00012#1--add by dongsz--str---
                   LET g_qryparam.where = " ooef019 ='",g_rtdu_m.rtdu011,"' AND ooef001 IN (",l_where,") "," AND EXISTS (SELECT 1 FROM stbo_t WHERE  stboent = ",g_enterprise," AND stbo003 = ooef001 AND stbo001 = '",g_rtdu_m.rtdu002,"' ) " #Add By geza 150630 加上存在于合同中才預帶資料
                   CALL q_ooef001()
                   #150505-00012#1--add by dongsz--end---
               END IF 
                                               #呼叫開窗

               LET g_rtdv2_d[l_ac].rtdw001 = g_qryparam.return1              #將開窗取得的值回傳到變數

               DISPLAY g_rtdv2_d[l_ac].rtdw001 TO rtdw001              #顯示到畫面上
              #LET g_qryparam.where = null #sakura mark
               NEXT FIELD rtdw001                          #返回原欄位
            ELSE
               LET g_qryparam.state= 'c'
               LET g_qryparam.default1 = g_rtdv2_d[l_ac].rtdw001
#               LET g_qryparam.where = " rtab001='",g_rtdu_m.rtdu008,"' "   
               #根据单头店群值选择开窗  geza 2015/03/31 
               IF NOT cl_null(g_rtdu_m.rtdu008) THEN 
                  #LET g_qryparam.where = " rtab001='",g_rtdu_m.rtdu008,"' "   #150505-00012#1--mark by dongsz
                  LET g_qryparam.where = " rtab001='",g_rtdu_m.rtdu008,"' AND rtab002 IN (",l_where,") ", " AND EXISTS (SELECT 1 FROM stbo_t WHERE  stboent = ",g_enterprise," AND stbo003 = rtab002 AND stbo001 = '",g_rtdu_m.rtdu002,"' ) "  #150505-00012#1--add by dongsz
                  CALL q_rtab002()
               ELSE
                  #150505-00012#1--mark by dongsz--str---
#                  IF s_aooi500_setpoint(g_prog,'rtdw001') THEN
#                     LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdw001',g_site,'i') 
#                     LET g_qryparam.where = g_qryparam.where," AND ooef001 IN 
#                     ( SELECT ooef001 FROM ooef_t a WHERE a.ooef001 = ooef001 AND a.ooef019 ='",g_rtdu_m.rtdu011,"' )"
#                     CALL q_ooef001_24()
#                  ELSE
#                     LET g_qryparam.where = " ooef303='Y' AND ooef019 ='",g_rtdu_m.rtdu011,"'"
#                     CALL q_ooef001()   
#                  END IF
                  #150505-00012#1--mark by dongsz--end---
                  #150505-00012#1--add by dongsz--str---
                  LET g_qryparam.where = " ooef019 ='",g_rtdu_m.rtdu011,"' AND ooef001 IN (",l_where,") "," AND EXISTS (SELECT 1 FROM stbo_t WHERE  stboent = ",g_enterprise," AND stbo003 = ooef001 AND stbo001 = '",g_rtdu_m.rtdu002,"' ) "
                  CALL q_ooef001()
                  #150505-00012#1--add by dongsz--end---
               END IF
              #LET g_qryparam.where = null #sakura mark
               LET tok = base.StringTokenizer.createExt(g_qryparam.return1,"|",'',TRUE)
                  LET l_detail_cnt = g_rtdv2_d.getLength()
                  #LET l_ac_t = l_ac   #150915-00001#1 150915 by sakura mark
                  LET l_ac_t1 = l_ac   #150915-00001#1 150915 by sakura add
                  LET l_count = 0
                  WHILE tok.hasMoreTokens()
                      
                     LET l_rtdw001 = tok.nextToken()
                     IF cl_null(l_rtdw001) THEN
                        CONTINUE WHILE
                     END IF
                     IF l_cmd='a' OR
                      (l_cmd='u' AND l_rtdw001!=g_rtdv2_d_t.rtdw001) THEN
                         SELECT COUNT(*) INTO l_count1 
                           FROM rtdw_t
                          WHERE rtdwent= g_enterprise 
                            AND rtdw001 = l_rtdw001
                            AND rtdwdocno = g_rtdu_m.rtdudocno
                        IF l_count1>0 THEN
                           CONTINUE WHILE
                        END IF
                     END IF
                     IF l_cmd='u' AND l_rtdw001=g_rtdv2_d_t.rtdw001 THEN
                        CONTINUE WHILE
                     END IF
#                     INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001)
#                        VALUES(g_enterprise,g_rtdu_m.rtdudocno,l_rtdw001)
#                     IF SQLCA.sqlcode THEN
#                        CALL cl_err("",SQLCA.sqlcode,1)   
#                        NEXT FIELD rtdw001
#                     ELSE
#                        CALL artt405_display_rtdw001(l_rtdw001)
#                     END IF
#                     LET l_i1 = l_i1+1
                     LET l_count = l_count + 1                                        
                     IF l_count > 1 THEN
                        LET l_ac = l_detail_cnt + l_count - 1
                        LET g_rtdv2_d[l_ac].rtdw001 = l_rtdw001
                        
                        #150515-00006#1 150516 by lori522612 mark---(S) 
                        #INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001)
                        #VALUES(g_enterprise,g_rtdu_m.rtdudocno,l_rtdw001)
                        #150515-00006#1 150516 by lori522612 mark---(E) 
                        
                        #150515-00006#1 150516 by lori522612 mark---(S) 
                        LET l_ooef123 = ''
                        LET l_ooef123 = artt405_get_ooef123(l_rtdw001)
                        INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002)
                             VALUES(g_enterprise,g_rtdu_m.rtdudocno,l_rtdw001,l_ooef123)
                        #150515-00006#1 150516 by lori522612 mark---(E) 
                        IF SQLCA.sqlcode THEN                       
                           LET l_count = l_count - 1 
                        ELSE
                           CALL artt405_rtdw001_display(l_rtdw001)
                        END IF
                     ELSE
                        LET g_rtdv2_d[l_ac].rtdw001 = l_rtdw001
                        DISPLAY BY NAME g_rtdv2_d[l_ac].rtdw001
                        LET g_rtdv2_d_t.rtdw001=g_rtdv2_d[l_ac].rtdw001
                        CALL artt405_rtdw001_display(l_rtdw001)
                     END IF
                     #LET l_ac = l_ac_t   #150915-00001#1 150915 by sakura mark
                     LET l_ac = l_ac_t1   #150915-00001#1 150915 by sakura add
                  END WHILE
                  LET g_qryparam.state= 'i'
#                  CALL g_rtdv2_d.deleteElement(l_ac)
#                  LET l_i1=0
#                  CALL artt405_b_fill()
#                  LET g_rtdv2_d_t.*=g_rtdv2_d[l_ac].*
#                  EXIT DIALOG
                  #150505-00012#1--mark by dongsz--str---
#                  IF l_count = 0 THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                  END IF
                  #150505-00012#1--mark by dongsz--end---
            END IF          

            #END add-point
 
 
         #Ctrlp:input.c.page2.rtdw002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdw002
            #add-point:ON ACTION controlp INFIELD rtdw002 name="input.c.page2.rtdw002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdv2_d[l_ac].rtdw002     
            LET g_qryparam.arg1 = g_rtdv2_d[l_ac].rtdw001
            LET g_qryparam.where = s_inaa_ctrlp(g_rtdu_m.rtdu003)   #150610-00026#1 150611 add

            CALL q_inaa001_4()       
            
            LET g_rtdv2_d[l_ac].rtdw002 = g_qryparam.return1 
            LET g_rtdv2_d[l_ac].rtdw002_desc = s_desc_get_stock_desc(g_rtdv2_d[l_ac].rtdw001,g_rtdv2_d[l_ac].rtdw002)            
            DISPLAY BY NAME g_rtdv2_d[l_ac].rtdw002,g_rtdv2_d[l_ac].rtdw002_Desc
            NEXT FIELD rtdw002    


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtdv2_d[l_ac].* = g_rtdv2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt405_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL artt405_unlock_b("rtdw_t","'2'")
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
               LET g_rtdv2_d[li_reproduce_target].* = g_rtdv2_d[li_reproduce].*
 
               LET g_rtdv2_d[li_reproduce_target].rtdw001 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtdv2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtdv2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="artt405.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
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
            NEXT FIELD rtdusite #sakura add
            #end add-point  
            NEXT FIELD rtdudocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rtdvseq
               WHEN "s_detail2"
                  NEXT FIELD rtdw001
 
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
 
{<section id="artt405.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION artt405_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_ooef019 LIKE ooef_t.ooef019
   DEFINE l_stan013 LIKE stan_t.stan013
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL artt405_b_fill() #單身填充
      CALL artt405_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL artt405_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL artt405_sum_rtdv020()
   
   #151113-00003#10 Modify By Ken 151127(S)
   #CALL artt405_rtdu002_display(g_rtdu_m.rtdu002)  
   CALL artt405_rtdu002_display1(g_rtdu_m.rtdu002)
   #151113-00003#10 Modify By Ken 151127(E)
   
   SELECT rtaa003 INTO g_rtdu_m.rtdu011
     FROM rtaa_t
    WHERE rtaaent = g_enterprise
      AND rtaa001 = g_rtdu_m.rtdu008
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtdu_m.rtdu011
   CALL ap_ref_array2(g_ref_fields,"SELECT DISTINCT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001 = '2' AND ooall003='"||g_dlang||"' AND ooall002=?","") RETURNING g_rtn_fields
   LET g_rtdu_m.rtdu011_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_rtdu_m.rtdu011_desc 
   DISPLAY BY NAME g_rtdu_m.rtdu011
   
   
   #151113-00003#10 Mark By Ken 151127(S)  Mark此段(因此段重覆顯示，顯示全部改CALL artt405_rtdu002_display1
   ##150213-00006#3 2015/02/13 By pomelo mark(S)
   ##sakura---add---str
   #LET l_stan013 = ''
   #SELECT stan006,stan007,stan013
   #  INTO g_rtdu_m.l_stan006,g_rtdu_m.l_stan007,l_stan013
   #  FROM stan_t
   # WHERE stanent = g_enterprise
   #   AND stan001 = g_rtdu_m.rtdu002
   ##150213-00006#3 2015/02/13 By pomelo mark(E)
   #CALL artt405_get_stan()   #150213-00006#3 2015/02/13 By pomelo add
   #CALL s_desc_get_currency_desc(g_rtdu_m.l_stan006) RETURNING g_rtdu_m.l_stan006_desc
   #DISPLAY BY NAME g_rtdu_m.l_stan006_desc
   ##sakura---add---end
   ##150213-00006#3 2015/02/13 By pomelo add(S)
   #IF cl_null(g_rtdu_m.rtdu011) THEN
   #   CALL s_desc_get_tax_desc1(l_stan013,g_rtdu_m.l_stan007) RETURNING g_rtdu_m.l_stan007_desc
   #ELSE
   #   CALL s_desc_get_tax_desc(g_rtdu_m.rtdu011,g_rtdu_m.l_stan007) RETURNING g_rtdu_m.l_stan007_desc
   #END IF
   #DISPLAY BY NAME g_rtdu_m.l_stan007_desc
   ##150213-00006#3 2015/02/13 By pomelo add(E) 
   #151113-00003#10 Mark By Ken 151127(E)   
   #end add-point
   
   #遮罩相關處理
   LET g_rtdu_m_mask_o.* =  g_rtdu_m.*
   CALL artt405_rtdu_t_mask()
   LET g_rtdu_m_mask_n.* =  g_rtdu_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtdu_m.rtdusite,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdudocdt,g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000, 
       g_rtdu_m.rtdu001,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtdu004_desc, 
       g_rtdu_m.rtduunit,g_rtdu_m.stan017,g_rtdu_m.stan018,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu005_desc, 
       g_rtdu_m.rtdu006,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008, 
       g_rtdu_m.rtdu008_desc,g_rtdu_m.rtdu011,g_rtdu_m.rtdu011_desc,g_rtdu_m.sum_rtdv020,g_rtdu_m.sum_rtdv019, 
       g_rtdu_m.l_stan006,g_rtdu_m.l_stan006_desc,g_rtdu_m.l_stan007,g_rtdu_m.l_stan007_desc,g_rtdu_m.rtdu009, 
       g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduownid_desc,g_rtdu_m.rtduowndp, 
       g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdp_desc, 
       g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumodid_desc,g_rtdu_m.rtdumoddt,g_rtdu_m.rtducnfid, 
       g_rtdu_m.rtducnfid_desc,g_rtdu_m.rtducnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtdu_m.rtdustus 
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
   FOR l_ac = 1 TO g_rtdv_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      SELECT imaal003,imaal004 
        INTO g_rtdv_d[l_ac].imaal003,g_rtdv_d[l_ac].imaal004
        FROM imaal_t 
       WHERE imaalent = g_enterprise
         AND imaal001 = g_rtdv_d[l_ac].rtdv001 
         AND imaal002 = g_dlang
         
      SELECT imaa009 
        INTO g_rtdv_d[l_ac].imaa009
        FROM imaa_t
       WHERE imaaent = g_enterprise   
         AND imaa001 = g_rtdv_d[l_ac].rtdv001 
     
      SELECT imay004,imay005 
        INTO g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv011
        FROM imay_t 
       WHERE imayent = g_enterprise 
         AND imay001 = g_rtdv_d[l_ac].rtdv001 
         AND imay003 = g_rtdv_d[l_ac].rtdv002   
         
      SELECT rtaxl003 
        INTO g_rtdv_d[l_ac].imaa009_01_desc 
        FROM rtaxl_t 
       WHERE rtaxlent = g_enterprise 
         AND rtaxl001 = g_rtdv_d[l_ac].imaa009 
         AND rtaxl002 = g_dlang
         
      #150827-00026#1 150831 by sakura mark&add(S)
      #SELECT oodb006 INTO g_rtdv_d[l_ac].rtdv007
      SELECT oodb006 INTO g_rtdv_d[l_ac].l_oodb0061
      #150827-00026#1 150831 by sakura mark&add(E)
        FROM oodb_t 
       WHERE oodbent = g_enterprise                      #150613-00063#1 1500614 by lori522612 add
         AND oodb002 = g_rtdv_d[l_ac].rtdv006 
         AND oodb001 = g_rtdu_m.rtdu011 
         AND oodb004 = '1'         
         
      #150213-00006#3 2015/02/13 By pomelo mark(S)
      #SELECT ooef019 INTO l_ooef019 
      #  FROM ooef_t 
      # WHERE ooef001 = g_site   
      #SELECT oodb006 INTO g_rtdv_d[l_ac].rtdv005 
      #  FROM oodb_t 
      # WHERE oodb002 = g_rtdv_d[l_ac].rtdv004 
      #   AND oodb001 = g_rtdu_m.rtaa003 
      #   AND oodb004 = '1'
      #150213-00006#3 2015/02/13 By pomelo mark(E)
     
      DISPLAY g_rtdv_d[l_ac].imaal003,g_rtdv_d[l_ac].imaal004, g_rtdv_d[l_ac].imaa009,g_rtdv_d[l_ac].imaa009_01_desc,
              #150827-00026#1 150831 by sakura mark&add(S)
              #g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv011,g_rtdv_d[l_ac].rtdv007
              g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv011,g_rtdv_d[l_ac].l_oodb0061
              #150827-00026#1 150831 by sakura mark&add(E)
           TO s_detai1[l_ac].imaal003_01,s_detai1[l_ac].imaal004_01,s_detai1[l_ac].imaa009_01,s_detai1[l_ac].imaa009_01_desc,
              #150827-00026#1 150831 by sakura mark&add(S)
              #s_detai1[l_ac].rtdv010,s_detai1[l_ac].rtdv011,s_detai1[l_ac].rtdv007
              s_detai1[l_ac].rtdv010,s_detai1[l_ac].rtdv011,s_detai1[l_ac].l_oodb0061
              #150827-00026#1 150831 by sakura mark&add(E)
       
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtdv_d[l_ac].rtdv004
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"' AND oodbl001='"||g_rtdu_m.rtdu011||"'","") RETURNING g_rtn_fields
      LET g_rtdv_d[l_ac].rtdv004_desc = '', g_rtn_fields[1] , ''
      DISPLAY  g_rtdv_d[l_ac].rtdv004_desc TO s_detail1[l_ac].rtdv004_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtdv_d[l_ac].rtdv006
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"' AND oodbl001='"||g_rtdu_m.rtdu011||"'","") RETURNING g_rtn_fields
      LET g_rtdv_d[l_ac].rtdv006_desc = '', g_rtn_fields[1] , ''
      DISPLAY  g_rtdv_d[l_ac].rtdv006_desc TO s_detail1[l_ac].rtdv006_desc       
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_rtdv2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      CALL artt405_rtdw001_display(g_rtdv2_d[l_ac].rtdw001) 
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL artt405_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artt405.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION artt405_detail_show()
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
 
{<section id="artt405.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION artt405_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rtdu_t.rtdudocno 
   DEFINE l_oldno     LIKE rtdu_t.rtdudocno 
 
   DEFINE l_master    RECORD LIKE rtdu_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rtdv_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rtdw_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success     LIKE type_t.num5   #sakura add  
   DEFINE l_insert      LIKE type_t.num5   #sakura add
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
   
   IF g_rtdu_m.rtdudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rtdudocno_t = g_rtdu_m.rtdudocno
 
    
   LET g_rtdu_m.rtdudocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtdu_m.rtduownid = g_user
      LET g_rtdu_m.rtduowndp = g_dept
      LET g_rtdu_m.rtducrtid = g_user
      LET g_rtdu_m.rtducrtdp = g_dept 
      LET g_rtdu_m.rtducrtdt = cl_get_current()
      LET g_rtdu_m.rtdumodid = g_user
      LET g_rtdu_m.rtdumoddt = cl_get_current()
      LET g_rtdu_m.rtdustus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_rtdu_m.rtducnfid = "" 
   LET g_rtdu_m.rtducnfdt= ""
   LET g_rtdu_m.rtdustus = "N"
   let g_rtdu_m.rtdudocdt = g_today
   
   #141208-00001#14 Add By Ken(S)
   CALL s_aooi500_default(g_prog,'rtdusite',g_rtdu_m.rtdusite)
      RETURNING l_insert,g_rtdu_m.rtdusite
   IF NOT l_insert THEN
      RETURN
   END IF
   
   CALL s_arti200_get_def_doc_type(g_rtdu_m.rtdusite,g_prog,'1')
      RETURNING l_success,g_rtdu_m.rtdudocno
   #141208-00001#14 Add By Ken(E)

   ##sakura---add---str
   #CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
   #   RETURNING l_success,g_rtdu_m.rtdudocno
   #
   #CALL s_aooi500_default(g_prog,g_site,g_rtdu_m.rtduunit)
   #   RETURNING l_insert,g_rtdu_m.rtduunit
   #IF NOT l_insert THEN
   #   RETURN
   #END IF
   ##sakura---add---end
   LET g_rtdu_m.rtdu006 = g_user #geza  add #150512-00031#1
   CALL s_desc_get_person_desc(g_rtdu_m.rtdu006) RETURNING g_rtdu_m.rtdu006_desc
   DISPLAY BY NAME g_rtdu_m.rtdu006_desc     
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtdu_m.rtdustus 
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
   
   
   CALL artt405_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rtdu_m.* TO NULL
      INITIALIZE g_rtdv_d TO NULL
      INITIALIZE g_rtdv2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL artt405_show()
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
   CALL artt405_set_act_visible()   
   CALL artt405_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtdudocno_t = g_rtdu_m.rtdudocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtduent = " ||g_enterprise|| " AND",
                      " rtdudocno = '", g_rtdu_m.rtdudocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt405_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL artt405_idx_chk()
   
   LET g_data_owner = g_rtdu_m.rtduownid      
   LET g_data_dept  = g_rtdu_m.rtduowndp
   
   #功能已完成,通報訊息中心
   CALL artt405_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION artt405_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rtdv_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rtdw_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE artt405_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtdv_t
    WHERE rtdvent = g_enterprise AND rtdvdocno = g_rtdudocno_t
 
    INTO TEMP artt405_detail
 
   #將key修正為調整後   
   UPDATE artt405_detail 
      #更新key欄位
      SET rtdvdocno = g_rtdu_m.rtdudocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rtdv_t SELECT * FROM artt405_detail
   
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
   DROP TABLE artt405_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtdw_t 
    WHERE rtdwent = g_enterprise AND rtdwdocno = g_rtdudocno_t
 
    INTO TEMP artt405_detail
 
   #將key修正為調整後   
   UPDATE artt405_detail SET rtdwdocno = g_rtdu_m.rtdudocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rtdw_t SELECT * FROM artt405_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt405_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rtdudocno_t = g_rtdu_m.rtdudocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="artt405.delete" >}
#+ 資料刪除
PRIVATE FUNCTION artt405_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   #IF g_rtdu_m.rtdustus <> "N" THEN               #151109-00006#12 151223 mark TT.Jessica
   IF g_rtdu_m.rtdustus NOT MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許刪除  #151109-00006#12 151223 add TT.Jessica
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "apm-00034"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_rtdu_m.rtdudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN artt405_cl USING g_enterprise,g_rtdu_m.rtdudocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt405_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt405_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt405_master_referesh USING g_rtdu_m.rtdudocno INTO g_rtdu_m.rtdusite,g_rtdu_m.rtdudocdt, 
       g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000,g_rtdu_m.rtdu001,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004, 
       g_rtdu_m.rtduunit,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008, 
       g_rtdu_m.rtdu011,g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduowndp, 
       g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumoddt, 
       g_rtdu_m.rtducnfid,g_rtdu_m.rtducnfdt,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu004_desc, 
       g_rtdu_m.rtdu005_desc,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008_desc,g_rtdu_m.rtduownid_desc, 
       g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp_desc,g_rtdu_m.rtdumodid_desc, 
       g_rtdu_m.rtducnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT artt405_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtdu_m_mask_o.* =  g_rtdu_m.*
   CALL artt405_rtdu_t_mask()
   LET g_rtdu_m_mask_n.* =  g_rtdu_m.*
   
   CALL artt405_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artt405_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rtdudocno_t = g_rtdu_m.rtdudocno
 
 
      DELETE FROM rtdu_t
       WHERE rtduent = g_enterprise AND rtdudocno = g_rtdu_m.rtdudocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rtdu_m.rtdudocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #141208-00001#14 Add By Ken(S)
      IF NOT s_aooi200_del_docno(g_rtdu_m.rtdudocno,g_rtdu_m.rtdudocdt) THEN 
         CALL s_transaction_end('N','0') RETURN 
      END IF
      #141208-00001#14 Add By Ken(E)
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM rtdv_t
       WHERE rtdvent = g_enterprise AND rtdvdocno = g_rtdu_m.rtdudocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdv_t:",SQLERRMESSAGE 
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
      DELETE FROM rtdw_t
       WHERE rtdwent = g_enterprise AND
             rtdwdocno = g_rtdu_m.rtdudocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdw_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rtdu_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE artt405_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rtdv_d.clear() 
      CALL g_rtdv2_d.clear()       
 
     
      CALL artt405_ui_browser_refresh()  
      #CALL artt405_ui_headershow()  
      #CALL artt405_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL artt405_browser_fill("")
         CALL artt405_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE artt405_cl
 
   #功能已完成,通報訊息中心
   CALL artt405_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="artt405.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artt405_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_rtdv_d.clear()
   CALL g_rtdv2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF artt405_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtdvseq,rtdv002,rtdv001,rtdv018,rtdv023,rtdv101,rtdv024,rtdv025, 
             rtdv026,rtdv102,rtdv103,rtdv020,rtdv021,rtdv022,rtdv004,rtdv006,rtdv008,rtdv012,rtdv009, 
             rtdv011,rtdv033,rtdv017,rtdv019,rtdv031,rtdv029,rtdv040,rtdv039,rtdv003,rtdv010,rtdv013, 
             rtdv014,rtdv015,rtdv016,rtdv034,rtdv035,rtdv036,rtdv037,rtdv038,rtdv032,rtdv027,rtdv028 , 
             t1.oocal003 ,t2.ooail003 ,t3.oocal003 ,t4.oocal003 ,t5.ooag011 ,t6.oocal003 FROM rtdv_t", 
                
                     " INNER JOIN rtdu_t ON rtduent = " ||g_enterprise|| " AND rtdudocno = rtdvdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocal_t t1 ON t1.oocalent="||g_enterprise||" AND t1.oocal001=rtdv009 AND t1.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=rtdv033 AND t2.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=rtdv029 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=rtdv010 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=rtdv013  ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=rtdv032 AND t6.oocal002='"||g_dlang||"' ",
 
                     " WHERE rtdvent=? AND rtdvdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtdv_t.rtdvseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt405_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR artt405_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rtdu_m.rtdudocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rtdu_m.rtdudocno INTO g_rtdv_d[l_ac].rtdvseq,g_rtdv_d[l_ac].rtdv002, 
          g_rtdv_d[l_ac].rtdv001,g_rtdv_d[l_ac].rtdv018,g_rtdv_d[l_ac].rtdv023,g_rtdv_d[l_ac].rtdv101, 
          g_rtdv_d[l_ac].rtdv024,g_rtdv_d[l_ac].rtdv025,g_rtdv_d[l_ac].rtdv026,g_rtdv_d[l_ac].rtdv102, 
          g_rtdv_d[l_ac].rtdv103,g_rtdv_d[l_ac].rtdv020,g_rtdv_d[l_ac].rtdv021,g_rtdv_d[l_ac].rtdv022, 
          g_rtdv_d[l_ac].rtdv004,g_rtdv_d[l_ac].rtdv006,g_rtdv_d[l_ac].rtdv008,g_rtdv_d[l_ac].rtdv012, 
          g_rtdv_d[l_ac].rtdv009,g_rtdv_d[l_ac].rtdv011,g_rtdv_d[l_ac].rtdv033,g_rtdv_d[l_ac].rtdv017, 
          g_rtdv_d[l_ac].rtdv019,g_rtdv_d[l_ac].rtdv031,g_rtdv_d[l_ac].rtdv029,g_rtdv_d[l_ac].rtdv040, 
          g_rtdv_d[l_ac].rtdv039,g_rtdv_d[l_ac].rtdv003,g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv013, 
          g_rtdv_d[l_ac].rtdv014,g_rtdv_d[l_ac].rtdv015,g_rtdv_d[l_ac].rtdv016,g_rtdv_d[l_ac].rtdv034, 
          g_rtdv_d[l_ac].rtdv035,g_rtdv_d[l_ac].rtdv036,g_rtdv_d[l_ac].rtdv037,g_rtdv_d[l_ac].rtdv038, 
          g_rtdv_d[l_ac].rtdv032,g_rtdv_d[l_ac].rtdv027,g_rtdv_d[l_ac].rtdv028,g_rtdv_d[l_ac].rtdv009_desc, 
          g_rtdv_d[l_ac].rtdv033_desc,g_rtdv_d[l_ac].rtdv029_desc,g_rtdv_d[l_ac].rtdv010_desc,g_rtdv_d[l_ac].rtdv013_desc, 
          g_rtdv_d[l_ac].rtdv032_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         SELECT imaal003,imaal004 INTO g_rtdv_d[l_ac].imaal003,g_rtdv_d[l_ac].imaal004
           FROM imaal_t 
          WHERE imaalent = g_enterprise 
            AND imaal001 = g_rtdv_d[l_ac].rtdv001  
            AND imaal002 = g_dlang
            
         SELECT imaa009 INTO  g_rtdv_d[l_ac].imaa009
           FROM imaa_t
          WHERE imaaent = g_enterprise    
            AND imaa001 = g_rtdv_d[l_ac].rtdv001 
            
         SELECT rtaxl003 INTO g_rtdv_d[l_ac].imaa009_01_desc 
           FROM rtaxl_t 
          WHERE rtaxlent = g_enterprise 
            AND rtaxl001 = g_rtdv_d[l_ac].imaa009 
            AND rtaxl002 = g_dlang 
        
         DISPLAY g_rtdv_d[l_ac].imaal003,g_rtdv_d[l_ac].imaal004, g_rtdv_d[l_ac].imaa009,g_rtdv_d[l_ac].imaa009_01_desc,
                 g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv011  
              TO s_detai1[l_ac].imaal003_01,s_detai1[l_ac].imaal004_01,s_detai1[l_ac].imaa009_01,s_detai1[l_ac].imaa009_01_desc,
                 s_detai1[l_ac].rtdv010,s_detai1[l_ac].rtdv011
         #150213-00006#3 2015/02/13 By pomelo add(S) 
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_rtdv_d[l_ac].rtdv004
         CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"' AND oodbl001='"||g_rtdu_m.rtdu011||"'","") RETURNING g_rtn_fields
         LET g_rtdv_d[l_ac].rtdv004_desc = '', g_rtn_fields[1] , ''
         DISPLAY  g_rtdv_d[l_ac].rtdv004_desc TO s_detail1[l_ac].rtdv004_desc
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_rtdv_d[l_ac].rtdv006
         CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"' AND oodbl001='"||g_rtdu_m.rtdu011||"'","") RETURNING g_rtn_fields
         LET g_rtdv_d[l_ac].rtdv006_desc = '', g_rtn_fields[1] , ''
         DISPLAY  g_rtdv_d[l_ac].rtdv006_desc TO s_detail1[l_ac].rtdv006_desc              
         #150213-00006#3 2015/02/13 By pomelo add(E)
         
         #150827-00026#1 150831 by sakura mark&add(S)
         #CALL artt405_rtdv007_rtdv030(g_rtdv_d[l_ac].rtdv006) #取銷項稅率及含稅否
         #CALL artt405_rtdv005_rtdv030(g_rtdv_d[l_ac].rtdv004) #取進項稅率及含稅否
         CALL artt405_oodb0061_oodb0051(g_rtdv_d[l_ac].rtdv006) #取銷項稅率及含稅否
         CALL artt405_oodb006_oodb005(g_rtdv_d[l_ac].rtdv004) #取進項稅率及含稅否
         #150827-00026#1 150831 by sakura mark&add(E)
         CALL s_desc_get_currency_desc(g_rtdv_d[l_ac].rtdv033) RETURNING g_rtdv_d[l_ac].rtdv033_desc
         CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv032) RETURNING g_rtdv_d[l_ac].rtdv032_desc
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
   IF artt405_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtdw001,rtdw002 ,t7.ooefl003 ,t8.inayl003 FROM rtdw_t",   
                     " INNER JOIN  rtdu_t ON rtduent = " ||g_enterprise|| " AND rtdudocno = rtdwdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=rtdw001 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=rtdw002 AND t8.inayl002='"||g_dlang||"' ",
 
                     " WHERE rtdwent=? AND rtdwdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtdw_t.rtdw001"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt405_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR artt405_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_rtdu_m.rtdudocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_rtdu_m.rtdudocno INTO g_rtdv2_d[l_ac].rtdw001,g_rtdv2_d[l_ac].rtdw002, 
          g_rtdv2_d[l_ac].rtdw001_desc,g_rtdv2_d[l_ac].rtdw002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL artt405_rtdw001_display(g_rtdv2_d[l_ac].rtdw001)
         CALL artt405_rtdw002_display()
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
   
   CALL g_rtdv_d.deleteElement(g_rtdv_d.getLength())
   CALL g_rtdv2_d.deleteElement(g_rtdv2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE artt405_pb
   FREE artt405_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtdv_d.getLength()
      LET g_rtdv_d_mask_o[l_ac].* =  g_rtdv_d[l_ac].*
      CALL artt405_rtdv_t_mask()
      LET g_rtdv_d_mask_n[l_ac].* =  g_rtdv_d[l_ac].*
   END FOR
   
   LET g_rtdv2_d_mask_o.* =  g_rtdv2_d.*
   FOR l_ac = 1 TO g_rtdv2_d.getLength()
      LET g_rtdv2_d_mask_o[l_ac].* =  g_rtdv2_d[l_ac].*
      CALL artt405_rtdw_t_mask()
      LET g_rtdv2_d_mask_n[l_ac].* =  g_rtdv2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION artt405_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   LET ls_group = "'3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
    
      DELETE FROM rtdv_t
       WHERE rtdvent = g_enterprise 
         AND rtdvdocno = ps_keys_bak[1] 
         AND rtdvseq = ps_keys_bak[2]
    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
   
      RETURN
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM rtdv_t
       WHERE rtdvent = g_enterprise AND
         rtdvdocno = ps_keys_bak[1] AND rtdvseq = ps_keys_bak[2]
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
         CALL g_rtdv_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      #151113-00003#10 Add By Ken 151127(S)
      IF (g_rtdv2_d[l_ac].rtdw001 = g_rtdu_m.rtdu005) THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ""          
         LET g_errparam.code   = 'art-00723'          
         LET g_errparam.popup  = TRUE 
         LET g_errparam.replace[1] = g_rtdv2_d[l_ac].rtdw001
         LET g_errparam.replace[2] = g_rtdu_m.rtdu005
         CALL cl_err()
         RETURN FALSE         
      END IF
      IF (g_rtdv2_d[l_ac].rtdw001 = g_rtdu_m.rtdu007) THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 'art-00724'
         LET g_errparam.popup  = TRUE 
         LET g_errparam.replace[1] = g_rtdv2_d[l_ac].rtdw001
         LET g_errparam.replace[2] = g_rtdu_m.rtdu007         
         CALL cl_err()
         RETURN FALSE         
      END IF      
      #151113-00003#10 Add By Ken 151127(E)
      #end add-point    
      DELETE FROM rtdw_t
       WHERE rtdwent = g_enterprise AND
             rtdwdocno = ps_keys_bak[1] AND rtdw001 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdw_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rtdv2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt405.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION artt405_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO rtdv_t
                  (rtdvent,
                   rtdvdocno,
                   rtdvseq
                   ,rtdv002,rtdv001,rtdv018,rtdv023,rtdv101,rtdv024,rtdv025,rtdv026,rtdv102,rtdv103,rtdv020,rtdv021,rtdv022,rtdv004,rtdv006,rtdv008,rtdv012,rtdv009,rtdv011,rtdv033,rtdv017,rtdv019,rtdv031,rtdv029,rtdv040,rtdv039,rtdv003,rtdv010,rtdv013,rtdv014,rtdv015,rtdv016,rtdv034,rtdv035,rtdv036,rtdv037,rtdv038,rtdv032,rtdv027,rtdv028) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtdv_d[g_detail_idx].rtdv002,g_rtdv_d[g_detail_idx].rtdv001,g_rtdv_d[g_detail_idx].rtdv018, 
                       g_rtdv_d[g_detail_idx].rtdv023,g_rtdv_d[g_detail_idx].rtdv101,g_rtdv_d[g_detail_idx].rtdv024, 
                       g_rtdv_d[g_detail_idx].rtdv025,g_rtdv_d[g_detail_idx].rtdv026,g_rtdv_d[g_detail_idx].rtdv102, 
                       g_rtdv_d[g_detail_idx].rtdv103,g_rtdv_d[g_detail_idx].rtdv020,g_rtdv_d[g_detail_idx].rtdv021, 
                       g_rtdv_d[g_detail_idx].rtdv022,g_rtdv_d[g_detail_idx].rtdv004,g_rtdv_d[g_detail_idx].rtdv006, 
                       g_rtdv_d[g_detail_idx].rtdv008,g_rtdv_d[g_detail_idx].rtdv012,g_rtdv_d[g_detail_idx].rtdv009, 
                       g_rtdv_d[g_detail_idx].rtdv011,g_rtdv_d[g_detail_idx].rtdv033,g_rtdv_d[g_detail_idx].rtdv017, 
                       g_rtdv_d[g_detail_idx].rtdv019,g_rtdv_d[g_detail_idx].rtdv031,g_rtdv_d[g_detail_idx].rtdv029, 
                       g_rtdv_d[g_detail_idx].rtdv040,g_rtdv_d[g_detail_idx].rtdv039,g_rtdv_d[g_detail_idx].rtdv003, 
                       g_rtdv_d[g_detail_idx].rtdv010,g_rtdv_d[g_detail_idx].rtdv013,g_rtdv_d[g_detail_idx].rtdv014, 
                       g_rtdv_d[g_detail_idx].rtdv015,g_rtdv_d[g_detail_idx].rtdv016,g_rtdv_d[g_detail_idx].rtdv034, 
                       g_rtdv_d[g_detail_idx].rtdv035,g_rtdv_d[g_detail_idx].rtdv036,g_rtdv_d[g_detail_idx].rtdv037, 
                       g_rtdv_d[g_detail_idx].rtdv038,g_rtdv_d[g_detail_idx].rtdv032,g_rtdv_d[g_detail_idx].rtdv027, 
                       g_rtdv_d[g_detail_idx].rtdv028)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdv_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rtdv_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO rtdw_t
                  (rtdwent,
                   rtdwdocno,
                   rtdw001
                   ,rtdw002) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtdv2_d[g_detail_idx].rtdw002)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdw_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rtdv2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="artt405.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION artt405_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtdv_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL artt405_rtdv_t_mask_restore('restore_mask_o')
               
      UPDATE rtdv_t 
         SET (rtdvdocno,
              rtdvseq
              ,rtdv002,rtdv001,rtdv018,rtdv023,rtdv101,rtdv024,rtdv025,rtdv026,rtdv102,rtdv103,rtdv020,rtdv021,rtdv022,rtdv004,rtdv006,rtdv008,rtdv012,rtdv009,rtdv011,rtdv033,rtdv017,rtdv019,rtdv031,rtdv029,rtdv040,rtdv039,rtdv003,rtdv010,rtdv013,rtdv014,rtdv015,rtdv016,rtdv034,rtdv035,rtdv036,rtdv037,rtdv038,rtdv032,rtdv027,rtdv028) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtdv_d[g_detail_idx].rtdv002,g_rtdv_d[g_detail_idx].rtdv001,g_rtdv_d[g_detail_idx].rtdv018, 
                  g_rtdv_d[g_detail_idx].rtdv023,g_rtdv_d[g_detail_idx].rtdv101,g_rtdv_d[g_detail_idx].rtdv024, 
                  g_rtdv_d[g_detail_idx].rtdv025,g_rtdv_d[g_detail_idx].rtdv026,g_rtdv_d[g_detail_idx].rtdv102, 
                  g_rtdv_d[g_detail_idx].rtdv103,g_rtdv_d[g_detail_idx].rtdv020,g_rtdv_d[g_detail_idx].rtdv021, 
                  g_rtdv_d[g_detail_idx].rtdv022,g_rtdv_d[g_detail_idx].rtdv004,g_rtdv_d[g_detail_idx].rtdv006, 
                  g_rtdv_d[g_detail_idx].rtdv008,g_rtdv_d[g_detail_idx].rtdv012,g_rtdv_d[g_detail_idx].rtdv009, 
                  g_rtdv_d[g_detail_idx].rtdv011,g_rtdv_d[g_detail_idx].rtdv033,g_rtdv_d[g_detail_idx].rtdv017, 
                  g_rtdv_d[g_detail_idx].rtdv019,g_rtdv_d[g_detail_idx].rtdv031,g_rtdv_d[g_detail_idx].rtdv029, 
                  g_rtdv_d[g_detail_idx].rtdv040,g_rtdv_d[g_detail_idx].rtdv039,g_rtdv_d[g_detail_idx].rtdv003, 
                  g_rtdv_d[g_detail_idx].rtdv010,g_rtdv_d[g_detail_idx].rtdv013,g_rtdv_d[g_detail_idx].rtdv014, 
                  g_rtdv_d[g_detail_idx].rtdv015,g_rtdv_d[g_detail_idx].rtdv016,g_rtdv_d[g_detail_idx].rtdv034, 
                  g_rtdv_d[g_detail_idx].rtdv035,g_rtdv_d[g_detail_idx].rtdv036,g_rtdv_d[g_detail_idx].rtdv037, 
                  g_rtdv_d[g_detail_idx].rtdv038,g_rtdv_d[g_detail_idx].rtdv032,g_rtdv_d[g_detail_idx].rtdv027, 
                  g_rtdv_d[g_detail_idx].rtdv028) 
         WHERE rtdvent = g_enterprise AND rtdvdocno = ps_keys_bak[1] AND rtdvseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdv_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdv_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt405_rtdv_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtdw_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL artt405_rtdw_t_mask_restore('restore_mask_o')
               
      UPDATE rtdw_t 
         SET (rtdwdocno,
              rtdw001
              ,rtdw002) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtdv2_d[g_detail_idx].rtdw002) 
         WHERE rtdwent = g_enterprise AND rtdwdocno = ps_keys_bak[1] AND rtdw001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdw_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdw_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt405_rtdw_t_mask_restore('restore_mask_n')
 
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
 
{<section id="artt405.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION artt405_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="artt405.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION artt405_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="artt405.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION artt405_lock_b(ps_table,ps_page)
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
   #CALL artt405_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rtdv_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN artt405_bcl USING g_enterprise,
                                       g_rtdu_m.rtdudocno,g_rtdv_d[g_detail_idx].rtdvseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt405_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "rtdw_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artt405_bcl2 USING g_enterprise,
                                             g_rtdu_m.rtdudocno,g_rtdv2_d[g_detail_idx].rtdw001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt405_bcl2:",SQLERRMESSAGE 
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
 
{<section id="artt405.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION artt405_unlock_b(ps_table,ps_page)
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
      CLOSE artt405_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt405_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION artt405_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rtdudocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rtdudocno",TRUE)
      CALL cl_set_comp_entry("rtdudocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      #141208-00001#14 Add By Ken(S)
      CALL cl_set_comp_entry("rtdusite",TRUE)
      CALL cl_set_comp_entry("rtdudocdt",TRUE)
      #141208-00001#14 Add By Ken(E)
      CALL cl_set_comp_entry("rtdu002",TRUE)     #150505-00012#1--add by dongsz
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("rtdu006,rtdu008",TRUE)
   #CALL cl_set_comp_entry("rtduunit",TRUE) #sakura add
   CALL cl_set_comp_entry("rtdu011",TRUE)   
   CALL cl_set_comp_entry("rtdu012",TRUE)   #151113-00003#10 Add By Ken 151127
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION artt405_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_count like type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rtdudocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("rtdu002",FALSE)     #150505-00012#1--add by dongsz   
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rtdudocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rtdudocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   LET l_count = 0
   SELECT COUNT(*) INTO l_count 
     FROM rtdv_t 
    WHERE rtdvent = g_enterprise
      AND rtdvdocno = g_rtdu_m.rtdudocno
   IF l_count >0 THEN
      CALL cl_set_comp_entry("rtdu006",FALSE)
      CALL cl_set_comp_entry("rtdu008",FALSE) #add geza 2015/04/02
      CALL cl_set_comp_entry("rtdu011",FALSE)
   END IF
   
   LET l_count = 0
   SELECT COUNT(*) INTO l_count 
     FROM rtdw_t 
    WHERE rtdwent = g_enterprise
      AND rtdwdocno = g_rtdu_m.rtdudocno      
   IF l_count >0 THEN
      CALL cl_set_comp_entry("rtdu008",FALSE)
      CALL cl_set_comp_entry("rtdu011",FALSE)
   END IF
   
   #141208-00001#14 Add By Ken(S)
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("rtdusite",FALSE)
      CALL cl_set_comp_entry("rtdudocdt",FALSE)
      CALL cl_set_comp_entry("rtdudocno",FALSE)
#      CALL cl_set_comp_entry("rtdu011",FALSE)
      CALL cl_set_comp_entry("rtdu012",FALSE)     #151113-00003#1 Add By Ken 151118
   END IF
   
   IF NOT s_aooi500_comp_entry(g_prog,'rtdusite') OR g_site_flag THEN
      CALL cl_set_comp_entry("rtdusite",FALSE)
   END IF 
   #141208-00001#14 Add By Ken(E)
   

   
   ##sakura---add---str   
   #IF NOT s_aooi500_comp_entry(g_prog,'rtduunit') THEN
   #   CALL cl_set_comp_entry("rtduunit",FALSE)
   #END IF
   ##sakura---add---end
   
   IF NOT cl_null(g_rtdu_m.rtdu008) THEN 
      CALL cl_set_comp_entry("rtdu011",FALSE)   
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION artt405_set_entry_b(p_cmd)
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
   #150213-00006#3 2015/02/13 By pomelo add(S)
   CALL cl_set_comp_entry("rtdv004",TRUE)    #進項稅目
   CALL cl_set_comp_entry("rtdv006",TRUE)    #銷項稅目
   #150213-00006#3 2015/02/13 By pomelo add(E)
   #150512-00031#1 2015/05/13 By geza add(S)
   CALL cl_set_comp_entry("rtdv022",TRUE)    #保证毛利率
   #150512-00031#1 2015/05/13 By geza add(E)
   CALL cl_set_comp_entry("rtdv017",TRUE) #150506-00001#1 150519 by sakura
   CALL cl_set_comp_entry("rtdv013",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="artt405.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION artt405_set_no_entry_b(p_cmd)
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
   #150213-00006#3 2015/02/13 By pomelo add(S)
   IF g_oodb011 = '1' THEN
      CALL cl_set_comp_entry("rtdv004",FALSE)    #進項稅目
      CALL cl_set_comp_entry("rtdv006",FALSE)    #銷項稅目
   END IF
   #150213-00006#3 2015/02/13 By pomelo add(E)
   
   #150512-00031#1 2015/05/13 By geza add(S)
   IF g_rtdv_d[l_ac].rtdv021 = 'N' THEN
      CALL cl_set_comp_entry("rtdv022",FALSE)    #保证毛利率
   END IF
   #150512-00031#1 2015/05/13 By geza add(E)
   
   #150506-00001#2 150519 by sakura---STR
   #作業方式為U:修改時,不開放輸入訂貨數
   IF g_rtdu_m.rtdu000 = 'U' THEN
      CALL cl_set_comp_entry("rtdv017",FALSE)
   END IF   
   #150506-00001#2 150519 by sakura---END
   
   IF NOT cl_null(g_rtdu_m.rtdu006) THEN
      CALL cl_set_comp_entry("rtdv013",FALSE)
   END IF     
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="artt405.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION artt405_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt405.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION artt405_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rtdu_m.rtdustus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt405.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION artt405_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   CALL cl_set_comp_visible("rtdv039",TRUE)    #结算扣率
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt405.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION artt405_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   #150512-00006#1 2015/05/13 By geza add(S)
   IF g_rtdu_m.rtdu003 != '3' THEN
      CALL cl_set_comp_visible("rtdv039",FALSE)    #结算扣率
   END IF
   #150512-00006#1 2015/05/13 By geza add(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt405.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION artt405_default_search()
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
      LET ls_wc = ls_wc, " rtdudocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "rtdu_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtdv_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtdw_t" 
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt405.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION artt405_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_ooaa002      LIKE ooaa_t.ooaa002
   DEFINE l_colname_1    STRING #150402-00005#13 2015/04/23 sakura add
   DEFINE l_colname_2    STRING #150402-00005#13 2015/04/23 sakura add
   DEFINE l_comment_1    STRING #150402-00005#13 2015/04/23 sakura add
   DEFINE l_comment_2    STRING #150402-00005#13 2015/04/23 sakura add
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   #150402-00005#13 2015/04/23 sakura modify---S
   IF g_rtdu_m.rtdustus = 'Y' OR g_rtdu_m.rtdustus = 'X' THEN #確認,作廢狀態
      RETURN
   END IF
   #IF g_rtdu_m.rtdustus = 'X' THEN
   #   RETURN
   #END IF
   #150402-00005#13 2015/04/23 sakura modify---E
   IF g_rtdu_m.rtdustus = 'C' THEN  #結案狀態
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rtdu_m.rtdudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN artt405_cl USING g_enterprise,g_rtdu_m.rtdudocno
   IF STATUS THEN
      CLOSE artt405_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt405_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE artt405_master_referesh USING g_rtdu_m.rtdudocno INTO g_rtdu_m.rtdusite,g_rtdu_m.rtdudocdt, 
       g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000,g_rtdu_m.rtdu001,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004, 
       g_rtdu_m.rtduunit,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008, 
       g_rtdu_m.rtdu011,g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduowndp, 
       g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumoddt, 
       g_rtdu_m.rtducnfid,g_rtdu_m.rtducnfdt,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu004_desc, 
       g_rtdu_m.rtdu005_desc,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008_desc,g_rtdu_m.rtduownid_desc, 
       g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp_desc,g_rtdu_m.rtdumodid_desc, 
       g_rtdu_m.rtducnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT artt405_action_chk() THEN
      CLOSE artt405_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtdu_m.rtdusite,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdudocdt,g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000, 
       g_rtdu_m.rtdu001,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtdu004_desc, 
       g_rtdu_m.rtduunit,g_rtdu_m.stan017,g_rtdu_m.stan018,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu005_desc, 
       g_rtdu_m.rtdu006,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008, 
       g_rtdu_m.rtdu008_desc,g_rtdu_m.rtdu011,g_rtdu_m.rtdu011_desc,g_rtdu_m.sum_rtdv020,g_rtdu_m.sum_rtdv019, 
       g_rtdu_m.l_stan006,g_rtdu_m.l_stan006_desc,g_rtdu_m.l_stan007,g_rtdu_m.l_stan007_desc,g_rtdu_m.rtdu009, 
       g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduownid_desc,g_rtdu_m.rtduowndp, 
       g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdp_desc, 
       g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumodid_desc,g_rtdu_m.rtdumoddt,g_rtdu_m.rtducnfid, 
       g_rtdu_m.rtducnfid_desc,g_rtdu_m.rtducnfdt
 
   CASE g_rtdu_m.rtdustus
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
         CASE g_rtdu_m.rtdustus
            
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
#      CALL cl_set_act_visible("unconfirmed,invalid,confirmed", true)
#      IF g_rtdu_m.rtdustus = 'N' THEN
#         CALL cl_set_act_visible("invalid,confirmed", true)
#         CALL cl_set_act_visible("unconfirmed", FALSE)      
#      END IF
#      IF g_rtdu_m.rtdustus = 'Y' THEN
#         CALL cl_set_act_visible("unconfirmed,invalid,confirmed", FALSE)      
#      END IF
#      IF g_rtdu_m.rtdustus = 'X' THEN
#         CALL cl_set_act_visible("invalid,confirmed,unconfirmed", FALSE)
#      END IF 
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_rtdu_m.rtdustus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)

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
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT artt405_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt405_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT artt405_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt405_cl
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
      g_rtdu_m.rtdustus = lc_state OR cl_null(lc_state) THEN
      CLOSE artt405_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CALL cl_err_collect_init()   #150827-00026#1 150915 by sakura add
   CASE lc_state 
      WHEN 'Y' 
         #CALL cl_err_collect_init()   #150827-00026#1 150915 by sakura mark
        
         SELECT rtdustus INTO  g_rtdu_m.rtdustus 
           FROM rtdu_t 
          WHERE rtduent = g_enterprise  
            AND rtdudocno = g_rtdu_m.rtdudocno      
         CALL s_artt405_conf_chk(g_rtdu_m.rtdudocno,g_rtdu_m.rtdustus) RETURNING l_success#,g_errno #150504-00045#1 150506 sakura mark
         IF l_success THEN
            #IF cl_ask_confirm('lib-00018') THEN   #160106-00002#7 mark by beckxie
            IF cl_ask_confirm('lib-014') THEN      #160106-00002#7 add by beckxie
               ##150402-00005#13 2015/04/23 sakura add---S
               #CALL cl_err_collect_init()
               #取錯誤訊息欄位說明
               #CALL s_azzi902_get_gzzd("artt405","lbl_rtdv001") RETURNING l_colname_1, l_comment_1
               #CALL s_azzi902_get_gzzd("artt405","lbl_rtdw001") RETURNING l_colname_2, l_comment_2
               #LET g_coll_title[1] = l_colname_1 #商品編號               
               #LET g_coll_title[2] = l_colname_2 #門店編號
               #150402-00005#13 2015/04/23 sakura add---E
               CALL s_transaction_begin()   #150827-00026#1 150915 by sakura mark
               CALL s_artt405_conf_upd(g_rtdu_m.rtdudocno) RETURNING l_success
               CALL cl_err_collect_show() #150402-00005#13 2015/04/23 sakura add
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')   
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
               RETURN            
            END IF
         ELSE
            CALL cl_err_collect_show()  #150324-00005#1--Add By Ken 150429
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
            RETURN            
         END IF         
      WHEN 'X'
         SELECT rtdustus INTO  g_rtdu_m.rtdustus 
           FROM rtdu_t 
          WHERE rtduent = g_enterprise 
            AND rtdudocno = g_rtdu_m.rtdudocno
         #CALL s_artt405_void_chk(g_rtdu_m.rtdudocno,g_rtdu_m.rtdustus) RETURNING l_success,g_errno   #150827-00026#1 150915 by sakura mark
         CALL s_artt405_void_chk(g_rtdu_m.rtdudocno,g_rtdu_m.rtdustus) RETURNING l_success            #150827-00026#1 150915 by sakura add
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_artt405_void_upd(g_rtdu_m.rtdudocno) RETURNING l_success
               CALL cl_err_collect_show()   #150827-00026#1 150915 by sakura add
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
               RETURN
            END IF
         ELSE
            #150827-00026#1 150915 by sakura mark(S)
            #INITIALIZE g_errparam TO NULL
            #LET g_errparam.code = g_errno
            #LET g_errparam.extend = g_rtdu_m.rtdudocno
            #LET g_errparam.popup = TRUE
            #CALL cl_err()
            #150827-00026#1 150915 by sakura mark(E)
            CALL cl_err_collect_show()   #150827-00026#1 150915 by sakura add
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
            RETURN    
         END IF
     
   END CASE
   #end add-point
   
   LET g_rtdu_m.rtdumodid = g_user
   LET g_rtdu_m.rtdumoddt = cl_get_current()
   LET g_rtdu_m.rtdustus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rtdu_t 
      SET (rtdustus,rtdumodid,rtdumoddt) 
        = (g_rtdu_m.rtdustus,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumoddt)     
    WHERE rtduent = g_enterprise AND rtdudocno = g_rtdu_m.rtdudocno
 
    
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
      EXECUTE artt405_master_referesh USING g_rtdu_m.rtdudocno INTO g_rtdu_m.rtdusite,g_rtdu_m.rtdudocdt, 
          g_rtdu_m.rtdudocno,g_rtdu_m.rtdu000,g_rtdu_m.rtdu001,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003,g_rtdu_m.rtdu004, 
          g_rtdu_m.rtduunit,g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu006,g_rtdu_m.rtdu007,g_rtdu_m.rtdu008, 
          g_rtdu_m.rtdu011,g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus,g_rtdu_m.rtduownid,g_rtdu_m.rtduowndp, 
          g_rtdu_m.rtducrtid,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid,g_rtdu_m.rtdumoddt, 
          g_rtdu_m.rtducnfid,g_rtdu_m.rtducnfdt,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu004_desc, 
          g_rtdu_m.rtdu005_desc,g_rtdu_m.rtdu006_desc,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008_desc,g_rtdu_m.rtduownid_desc, 
          g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp_desc,g_rtdu_m.rtdumodid_desc, 
          g_rtdu_m.rtducnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rtdu_m.rtdusite,g_rtdu_m.rtdusite_desc,g_rtdu_m.rtdudocdt,g_rtdu_m.rtdudocno, 
          g_rtdu_m.rtdu000,g_rtdu_m.rtdu001,g_rtdu_m.rtdu001_desc,g_rtdu_m.rtdu002,g_rtdu_m.rtdu003, 
          g_rtdu_m.rtdu004,g_rtdu_m.rtdu004_desc,g_rtdu_m.rtduunit,g_rtdu_m.stan017,g_rtdu_m.stan018, 
          g_rtdu_m.rtdu012,g_rtdu_m.rtdu005,g_rtdu_m.rtdu005_desc,g_rtdu_m.rtdu006,g_rtdu_m.rtdu006_desc, 
          g_rtdu_m.rtdu007,g_rtdu_m.rtdu007_desc,g_rtdu_m.rtdu008,g_rtdu_m.rtdu008_desc,g_rtdu_m.rtdu011, 
          g_rtdu_m.rtdu011_desc,g_rtdu_m.sum_rtdv020,g_rtdu_m.sum_rtdv019,g_rtdu_m.l_stan006,g_rtdu_m.l_stan006_desc, 
          g_rtdu_m.l_stan007,g_rtdu_m.l_stan007_desc,g_rtdu_m.rtdu009,g_rtdu_m.rtdu010,g_rtdu_m.rtdustus, 
          g_rtdu_m.rtduownid,g_rtdu_m.rtduownid_desc,g_rtdu_m.rtduowndp,g_rtdu_m.rtduowndp_desc,g_rtdu_m.rtducrtid, 
          g_rtdu_m.rtducrtid_desc,g_rtdu_m.rtducrtdp,g_rtdu_m.rtducrtdp_desc,g_rtdu_m.rtducrtdt,g_rtdu_m.rtdumodid, 
          g_rtdu_m.rtdumodid_desc,g_rtdu_m.rtdumoddt,g_rtdu_m.rtducnfid,g_rtdu_m.rtducnfid_desc,g_rtdu_m.rtducnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   IF g_rtdu_m.rtdustus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   END IF       
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE artt405_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt405_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt405.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION artt405_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rtdv_d.getLength() THEN
         LET g_detail_idx = g_rtdv_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtdv_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtdv_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_rtdv2_d.getLength() THEN
         LET g_detail_idx = g_rtdv2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtdv2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtdv2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt405.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artt405_b_fill2(pi_idx)
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
   
   CALL artt405_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="artt405.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION artt405_fill_chk(ps_idx)
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
 
{<section id="artt405.status_show" >}
PRIVATE FUNCTION artt405_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artt405.mask_functions" >}
&include "erp/art/artt405_mask.4gl"
 
{</section>}
 
{<section id="artt405.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION artt405_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL artt405_show()
   CALL artt405_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_artt405_conf_chk(g_rtdu_m.rtdudocno,g_rtdu_m.rtdustus) RETURNING l_success#,g_errno #150504-00045#1 150506 sakura mark
   IF l_success THEN
            
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_rtdu_m.rtdudocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE artt405_cl
      CALL s_transaction_end('N','0')
      RETURN  FALSE          
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_rtdu_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_rtdv_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_rtdv2_d))
 
 
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
   #CALL artt405_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL artt405_ui_headershow()
   CALL artt405_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION artt405_draw_out()
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
   CALL artt405_ui_headershow()  
   CALL artt405_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="artt405.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION artt405_set_pk_array()
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
   LET g_pk_array[1].values = g_rtdu_m.rtdudocno
   LET g_pk_array[1].column = 'rtdudocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt405.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="artt405.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION artt405_msgcentre_notify(lc_state)
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
   CALL artt405_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rtdu_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt405.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION artt405_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#35 add-S
   SELECT rtdustus  INTO g_rtdu_m.rtdustus
     FROM rtdu_t
    WHERE rtduent = g_enterprise
      AND rtdudocno = g_rtdu_m.rtdudocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_rtdu_m.rtdustus
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
        LET g_errparam.extend = g_rtdu_m.rtdudocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL artt405_set_act_visible()
        CALL artt405_set_act_no_visible()
        CALL artt405_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#35 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt405.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 店群說明及帶稅區別
# Memo...........:
# Usage..........: CALL artt405_rtdu008_display()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/15 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdu008_display()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtdu_m.rtdu008
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtdu_m.rtdu008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtdu_m.rtdu008_desc
      
   SELECT rtaa003 INTO g_rtdu_m.rtdu011
     FROM rtaa_t
    WHERE rtaaent = g_enterprise
      AND rtaa001 = g_rtdu_m.rtdu008      
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtdu_m.rtdu011
   CALL ap_ref_array2(g_ref_fields,"SELECT DISTINCT ooall004 FROM ooall_t WHERE ooall001 = '2' AND ooall003='"||g_dlang||"' AND ooallent='"||g_enterprise||"' AND ooall002=?","") RETURNING g_rtn_fields
   LET g_rtdu_m.rtdu011_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_rtdu_m.rtdu011_desc 
   DISPLAY BY NAME g_rtdu_m.rtdu011
END FUNCTION

################################################################################
# Descriptions...: 銷項稅別說明
# Memo...........:
# Usage..........: CALL artt405_rtdv006_display(p_rtdv006)
# Input parameter: p_rtdv006      銷項稅別
# Return code....: 
# Date & Author..: 2015/06/15 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdv006_display(p_rtdv006)
   DEFINE p_rtdv006  LIKE rtdv_t.rtdv006
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_rtdv006
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"' AND oodbl001='"||g_rtdu_m.rtdu011||"'","") RETURNING g_rtn_fields
   LET g_rtdv_d[l_ac].rtdv006_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_rtdv_d[l_ac].rtdv006_desc TO s_detail1[l_ac].rtdv006_desc
   
   #150827-00026#1 150831 by sakura mark&add(S)   
   #SELECT oodb006 INTO g_rtdv_d[l_ac].rtdv007
   SELECT oodb006 INTO g_rtdv_d[l_ac].l_oodb0061
   #150827-00026#1 150831 by sakura mark&add(E)
     FROM oodb_t
    WHERE oodbent = g_enterprise 
      AND oodb002 = p_rtdv006 
      AND oodb004 = '1'
   #150827-00026#1 150831 by sakura mark&add(S)
   #DISPLAY g_rtdv_d[l_ac].rtdv007 TO s_detail1[l_ac].rtdv007
   DISPLAY g_rtdv_d[l_ac].l_oodb0061 TO s_detail1[l_ac].l_oodb0061
   #150827-00026#1 150831 by sakura mark&add(E)
END FUNCTION

################################################################################
# Descriptions...: 帶出進項稅率,含稅
# Memo...........:
# Usage..........: CALL artt405_oodb006_oodb005(p_rtdv004)
# Input parameter: p_rtdv004   進項稅別
# Return code....: 無
# Date & Author..: 2015/01/20 By Sakura
# Modify.........: 2015/08/31 By Sakura #150827-00026#1修改抓取oodb_t基本資料
################################################################################
PRIVATE FUNCTION artt405_oodb006_oodb005(p_rtdv004)
DEFINE p_rtdv004  LIKE rtdv_t.rtdv004

   SELECT oodb005,oodb006
     #150827-00026#1 150831 by sakura mark&add(S)   
     #INTO g_rtdv_d[l_ac].rtdv030,g_rtdv_d[l_ac].rtdv005
     INTO g_rtdv_d[l_ac].l_oodb005,g_rtdv_d[l_ac].l_oodb006
     #150827-00026#1 150831 by sakura mark&add(E)
      FROM oodb_t
    WHERE oodbent = g_enterprise 
      AND oodb001 = g_rtdu_m.rtdu011    
      AND oodb002 = p_rtdv004 
      AND oodb004 = '1'
   
   #150827-00026#1 150831 by sakura mark&add(S)
   #DISPLAY  g_rtdv_d[l_ac].rtdv005 TO rtdv005
   #DISPLAY  g_rtdv_d[l_ac].rtdv030 TO rtdv030
   DISPLAY  g_rtdv_d[l_ac].l_oodb006 TO l_oodb006
   DISPLAY  g_rtdv_d[l_ac].l_oodb005 TO l_oodb005
   #150827-00026#1 150831 by sakura mark&add(E)
END FUNCTION

################################################################################
# Descriptions...: 帶出銷項稅率,含稅
# Memo...........:
# Usage..........: CALL artt405_oodb0061_oodb0051(p_rtdv006)
# Input parameter: p_rtdv006   銷項稅別
# Return code....: 無
# Date & Author..: 2015/02/05 By Sakura
# Modify.........: 2015/08/31 By Sakura #150827-00026#1修改抓取oodb_t基本資料
################################################################################
PRIVATE FUNCTION artt405_oodb0061_oodb0051(p_rtdv006)
DEFINE p_rtdv006  LIKE rtdv_t.rtdv006

   SELECT oodb005,oodb006
     #150827-00026#1 150831 by sakura mark&add(S)
     #INTO g_rtdv_d[l_ac].l_rtdv030,g_rtdv_d[l_ac].rtdv007
     INTO g_rtdv_d[l_ac].l_oodb0051,g_rtdv_d[l_ac].l_oodb0061
     #150827-00026#1 150831 by sakura mark&add(E)
      FROM oodb_t
    WHERE oodbent = g_enterprise 
      AND oodb001 = g_rtdu_m.rtdu011    
      AND oodb002 = p_rtdv006 
      AND oodb004 = '1'
   
   #150827-00026#1 150831 by sakura mark&add(S)   
   #DISPLAY  g_rtdv_d[l_ac].rtdv007 TO rtdv007
   #DISPLAY  g_rtdv_d[l_ac].l_rtdv030 TO l_rtdv030
   DISPLAY  g_rtdv_d[l_ac].l_oodb0061 TO l_oodb0061
   DISPLAY  g_rtdv_d[l_ac].l_oodb0051 TO l_oodb0051
   #150827-00026#1 150831 by sakura mark&add(E)
END FUNCTION

################################################################################
# Descriptions...: 進項稅別說明
# Memo...........:
# Usage..........: CALL artt405_rtdv004_display(p_rtdv004)
# Input parameter: p_rtdv004      進項稅別
# Return code....: 
# Date & Author..: 2015/06/15 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdv004_display(p_rtdv004)
   DEFINE p_rtdv004  LIKE rtdv_t.rtdv004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_rtdv004
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"' AND oodbl001='"||g_rtdu_m.rtdu011||"'","") RETURNING g_rtn_fields
   LET g_rtdv_d[l_ac].rtdv004_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_rtdv_d[l_ac].rtdv004_desc TO s_detail1[l_ac].rtdv004_desc
END FUNCTION

################################################################################
# Descriptions...: 合約編號檢查
# Memo...........:
# Usage..........: CALL artt405_artt405_rtdu002()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_artt405_rtdu002()
   DEFINE   l_cnt        LIKE type_t.num5
   DEFINE   l_cnt1       LIKE type_t.num5 
   DEFINE   l_stan018    LIKE stan_t.stan018
   DEFINE   l_stan031    LIKE stan_t.stan031 # add by geza 20150629
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   
   SELECT COUNT(*) INTO l_cnt  
     FROM stan_t 
    WHERE stanent = g_enterprise
      AND stan001 = g_rtdu_m.rtdu002
      
   IF l_cnt <= 0 THEN
      LET g_errno = "art-00040"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  
        FROM stan_t 
       WHERE stanent = g_enterprise 
         AND stan001 = g_rtdu_m.rtdu002
         AND stanstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno = "art-00041"
      END IF         
   END IF
   
   IF cl_null(g_errno) THEN
# mark by geza 20150629(S)     
#      SELECT stan018 INTO l_stan018 
#        FROM stan_t 
#       WHERE stanent=g_enterprise
#         AND stan001 = g_rtdu_m.rtdu002
#         
#      IF g_rtdu_m.rtdudocdt>l_stan018 THEN
#         LET g_errno = "art-00042"
#      END IF
# mark by geza 20150629(E)  
      # add by geza 20150629(S)   
      INITIALIZE l_stan018 TO NULL
      INITIALIZE l_stan031 TO NULL
      SELECT stan018,stan031 INTO l_stan018,l_stan031 
        FROM stan_t 
       WHERE stanent = g_enterprise
         AND stan001 = g_rtdu_m.rtdu002
      IF l_stan031 IS NOT NULL THEN
         IF g_rtdu_m.rtdudocdt>l_stan031 THEN
            LET g_errno = "art-00042"
         END IF
      ELSE      
         IF g_rtdu_m.rtdudocdt>l_stan018 THEN
            LET g_errno = "art-00042"
         END IF
      END IF      
   # add by geza 20150629(E)  
   END IF
END FUNCTION

################################################################################
# Descriptions...: 確認供應商與合同供應商必須相同
# Memo...........:
# Usage..........: CALL artt405_chk_rtdu001()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_chk_rtdu001()
DEFINE l_cnt   LIKE type_t.num5
DEFINE l_cnt1  LIKE type_t.num5

   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   
   IF NOT cl_null(g_rtdu_m.rtdu001) AND NOT cl_null(g_rtdu_m.rtdu002) THEN
      SELECT COUNT(*) INTO l_cnt 
        FROM stan_t
       WHERE stanent=g_enterprise 
         AND stan001=g_rtdu_m.rtdu002
         AND stan005=g_rtdu_m.rtdu001
         
      IF l_cnt<=0 THEN
         LET g_errno="art-00289"
      ELSE
         SELECT COUNT(*) INTO l_cnt1 
           FROM stan_t
          WHERE stanent = g_enterprise 
            AND stan001 = g_rtdu_m.rtdu002
            AND stan005 = g_rtdu_m.rtdu001 
            AND stanstus= 'Y' 
            
         IF l_cnt1<=0 THEN
            LET g_errno="art-00290"
         END IF         
      END IF
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 平均銷售差率、總金額計算
# Memo...........:
# Usage..........: CALL artt405_sum_rtdv020()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_sum_rtdv020()
   DEFINE l_sum_rtdv023       LIKE rtdv_t.rtdv023
   DEFINE l_sum_rtdv018       LIKE rtdv_t.rtdv018
   DEFINE l_sum_rtdv019       LIKE rtdv_t.rtdv019
   
   SELECT SUM(NVL(rtdv023,0)),SUM(NVL(rtdv018,0)),SUM(NVL(rtdv019,0)) 
     INTO l_sum_rtdv023,l_sum_rtdv018,l_sum_rtdv019
     FROM rtdv_t
    WHERE rtdvent = g_enterprise 
      AND rtdvdocno = g_rtdu_m.rtdudocno
      
   IF cl_null(l_sum_rtdv023) OR  l_sum_rtdv023 = 0 THEN
      LET l_sum_rtdv023 = 1
   END IF   
   
   LET g_rtdu_m.sum_rtdv020 = ( l_sum_rtdv023- l_sum_rtdv018) *100/l_sum_rtdv023
   LET g_rtdu_m.sum_rtdv019 = l_sum_rtdv019
   DISPLAY BY NAME g_rtdu_m.sum_rtdv020,g_rtdu_m.sum_rtdv019 
   
END FUNCTION

################################################################################
# Descriptions...: 確認店群稅區與合同簽訂法人稅區必須相同
# Memo...........:
# Usage..........: CALL artt405_chk_rtdu008()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/02/13 By pomelo 150213-00006#3
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_chk_rtdu008()
DEFINE r_success             LIKE type_t.num5
DEFINE l_ooef019             LIKE ooef_t.ooef019

   LET r_success = TRUE
   
   LET l_ooef019 = ''
   SELECT ooef019 INTO l_ooef019
     FROM stan_t,ooef_t
    WHERE stanent = ooefent
      AND stan013 = ooef001
      AND stan001 = g_rtdu_m.rtdu002
      AND stanent = g_enterprise
   
   SELECT rtaa003 INTO g_rtdu_m.rtdu011
     FROM rtaa_t
    WHERE rtaa001 = g_rtdu_m.rtdu008
      AND rtaaent = g_enterprise
   
   IF l_ooef019 != g_rtdu_m.rtdu011 OR
      cl_null(l_ooef019) OR
      cl_null(g_rtdu_m.rtdu011) THEN
      #店群的稅區別%1 與 合同簽訂法人的稅區%2 不相同或空白！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "art-00481"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_ooef019
      LET g_errparam.replace[2] = g_rtdu_m.rtdu011
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根据供应商带值
# Memo...........:
# Date & Author..: 2015/04/22 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdu001_init(p_rtdu001)
DEFINE p_rtdu001  LIKE rtdu_t.rtdu001
DEFINE l_stan013  LIKE stan_t.stan013
DEFINE l_cnt     LIKE type_t.num10      
   
   LET l_cnt = 0
   SELECT COUNT(*)
     INTO l_cnt 
     FROM stan_t
    WHERE stanent = g_enterprise
      AND stan005 = p_rtdu001   
      AND stanstus = 'Y'
      
   IF l_cnt != 1  THEN
      RETURN 
   END IF 
   
   LET l_stan013 = ''
   #SELECT stan002,stan009,stan016,stan017,stan018,
   SELECT stan002,stan009,stan016,stan017,(CASE WHEN (stan031 IS NOT NULL) THEN stan031 ELSE stan018 END), #By shi Add 20150701
          stan006,stan007,stan013,stan001
     INTO g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtdu005,g_rtdu_m.stan017,g_rtdu_m.stan018,
          g_rtdu_m.l_stan006,g_rtdu_m.l_stan007,l_stan013,g_rtdu_m.rtdu002
     FROM stan_t
    WHERE stanent = g_enterprise 
      AND stan005 = p_rtdu001 
      AND stanstus = 'Y'   #150831-00003#1 20150831 s983961--ADD
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtdu_m.rtdu005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtdu_m.rtdu005_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_rtdu_m.rtdu005_desc 
   DISPLAY BY NAME  g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtdu005,g_rtdu_m.stan017,g_rtdu_m.stan018,g_rtdu_m.l_stan006 #sakura add stan006
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtdu_m.rtdu004
   CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtdu_m.rtdu004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtdu_m.rtdu004_desc
   
   CALL s_desc_get_currency_desc(g_rtdu_m.l_stan006) RETURNING g_rtdu_m.l_stan006_desc
   DISPLAY BY NAME g_rtdu_m.l_stan006_desc       
  
   IF cl_null(g_rtdu_m.rtdu011) THEN
      CALL s_desc_get_tax_desc1(l_stan013,g_rtdu_m.l_stan007) RETURNING g_rtdu_m.l_stan007_desc
   ELSE
      CALL s_desc_get_tax_desc(g_rtdu_m.rtdu011,g_rtdu_m.l_stan007) RETURNING g_rtdu_m.l_stan007_desc
   END IF
   DISPLAY BY NAME g_rtdu_m.l_stan007,g_rtdu_m.l_stan007_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查供應商是否存在且有效
# Memo...........:
# Usage..........: CALL artt405_rtdu001()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdu001()
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_cnt1  LIKE type_t.num5 
   
   LET g_errno = null
   LET l_cnt = 0
   LET l_cnt1 = 0
   
   SELECT COUNT(*) INTO l_cnt 
     FROM pmaa_t 
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_rtdu_m.rtdu001 AND pmaa002 IN ('2','3')
        
   IF l_cnt <= 0 THEN
      LET g_errno = "apm-00016"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  
        FROM pmaa_t 
       WHERE pmaaent = g_enterprise 
         AND pmaa001 = g_rtdu_m.rtdu001 AND pmaa002 IN ('2','3')
         AND pmaastus ='Y' 
         
      IF l_cnt1 <= 0 THEN
         LET g_errno = "apm-00017"
      END IF         
   END IF
END FUNCTION

################################################################################
# Descriptions...: 檢查合約是否存在且有效
# Memo...........:
# Usage..........: CALL artt405_rtdu002()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........: 2015/06/29 By geza
################################################################################
PRIVATE FUNCTION artt405_rtdu002()
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_cnt1       LIKE type_t.num5 
   DEFINE l_stan018    LIKE stan_t.stan018
   DEFINE l_stan031    LIKE stan_t.stan031 # add by geza 20150629
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   
   SELECT COUNT(*) INTO l_cnt  
     FROM stan_t 
    WHERE stanent = g_enterprise AND stan001 = g_rtdu_m.rtdu002 
    
   IF l_cnt <= 0 THEN
      LET g_errno = "art-00040"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  
        FROM stan_t 
       WHERE stanent = g_enterprise
         AND stan001 = g_rtdu_m.rtdu002        
         #AND stanstus='Y'  #150831-00003#1 20150831 s983961--mark and mod(s)    
         AND (stanstus= 'N' OR stanstus= 'X')
     #IF l_cnt1 <= 0 THEN
      IF l_cnt1 > 0 THEN
         #LET g_errno = "art-00041"  
          LET g_errno = "art-00706"
         #150831-00003#1 20150831 s983961--mark and mod(e) 
      END IF         
   END IF
   IF cl_null(g_errno) THEN
# mark by geza 20150629(S)   
#      SELECT stan018 INTO l_stan018
#        FROM stan_t 
#       WHERE stanent = g_enterprise
#         AND stan001 = g_rtdu_m.rtdu002
#         
#      IF g_rtdu_m.rtdudocdt>l_stan018 THEN
#         LET g_errno = "art-00042"
#      END IF
# mark by geza 20150629(E) 
# add by geza 20150629(S)   
      INITIALIZE l_stan018 TO NULL
      INITIALIZE l_stan031 TO NULL
      SELECT stan018,stan031 INTO l_stan018,l_stan031 
        FROM stan_t 
       WHERE stanent = g_enterprise
         AND stan001 = g_rtdu_m.rtdu002
      IF l_stan031 IS NOT NULL THEN
         IF g_rtdu_m.rtdudocdt>l_stan031 THEN
            LET g_errno = "art-00042"
         END IF
      ELSE      
         IF g_rtdu_m.rtdudocdt>l_stan018 THEN
            LET g_errno = "art-00042"
         END IF
      END IF
      
# add by geza 20150629(E)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 合約編號帶出相關欄位
# Memo...........:
# Usage..........: CALL artt405_rtdu002_display(p_rtdu002)
# Input parameter: p_rtdu002      合約編號
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdu002_display(p_rtdu002)
DEFINE p_rtdu002  LIKE rtdu_t.rtdu002
DEFINE l_stan013  LIKE stan_t.stan013

   LET l_stan013 = ''
   #SELECT stan002,stan009,stan016,stan017,stan018,
   SELECT stan002,stan009,stan016,stan017,(CASE WHEN (stan031 IS NOT NULL) THEN stan031 ELSE stan018 END), #By shi Add 20150701
          stan006,stan007,stan013,stan005
     INTO g_rtdu_m.rtdu003,  g_rtdu_m.rtdu004,  g_rtdu_m.rtdu005,g_rtdu_m.stan017,g_rtdu_m.stan018,
          g_rtdu_m.l_stan006,g_rtdu_m.l_stan007,l_stan013,       g_rtdu_m.rtdu001
     FROM stan_t
    WHERE stanent = g_enterprise 
      AND stan001 = p_rtdu002    
  
  INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtdu_m.rtdu005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtdu_m.rtdu005_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_rtdu_m.rtdu005_desc 
   DISPLAY BY NAME  g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.rtdu005,g_rtdu_m.stan017,g_rtdu_m.stan018,g_rtdu_m.l_stan006 #sakura add stan006
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtdu_m.rtdu004
   CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtdu_m.rtdu004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtdu_m.rtdu004_desc
   
   #sakura---add---str
   CALL s_desc_get_currency_desc(g_rtdu_m.l_stan006) RETURNING g_rtdu_m.l_stan006_desc
   DISPLAY BY NAME g_rtdu_m.l_stan006_desc       
   #sakura---add---end
   
   #150213-00006#3 2015/02/13 By pomelo add(S)
   IF cl_null(g_rtdu_m.rtdu011) THEN
      CALL s_desc_get_tax_desc1(l_stan013,g_rtdu_m.l_stan007) RETURNING g_rtdu_m.l_stan007_desc
   ELSE
      CALL s_desc_get_tax_desc(g_rtdu_m.rtdu011,g_rtdu_m.l_stan007) RETURNING g_rtdu_m.l_stan007_desc
   END IF
   DISPLAY BY NAME g_rtdu_m.l_stan007,g_rtdu_m.l_stan007_desc
   #150213-00006#3 2015/02/13 By pomelo add(E)
   
   CALL s_desc_get_trading_partner_full_desc(g_rtdu_m.rtdu001)
      RETURNING g_rtdu_m.rtdu001_desc
   DISPLAY BY NAME g_rtdu_m.rtdu001_desc
END FUNCTION

################################################################################
# Descriptions...: 商品編號、條碼校驗前先清空相關說明欄位
# Memo...........:
# Usage..........: CALL artt405_null_rtdv001()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_null_rtdv001()
  LET g_rtdv_d[l_ac].imaal003 = NULL
  LET g_rtdv_d[l_ac].imaal004 = NULL
  LET g_rtdv_d[l_ac].imaa009 = NULL
  LET g_rtdv_d[l_ac].imaa009_01_desc = NULL
  LET g_rtdv_d[l_ac].rtdv010 = NULL
  LET g_rtdv_d[l_ac].rtdv011 = NULL
  LET g_rtdv_d[l_ac].rtdv032 = NULL #sakura add
  DISPLAY g_rtdv_d[l_ac].imaal003, g_rtdv_d[l_ac].imaal004, g_rtdv_d[l_ac].imaa009,  g_rtdv_d[l_ac].imaa009_01_desc,
          g_rtdv_d[l_ac].rtdv010,  g_rtdv_d[l_ac].rtdv011,  g_rtdv_d[l_ac].rtdv001,  g_rtdv_d[l_ac].rtdv032 #sakura add rtdv032   
   TO s_detai1[l_ac].imaal003_01, s_detai1[l_ac].imaal004_01, s_detai1[l_ac].imaa009_01, s_detai1[l_ac].imaa009_01_desc,
      s_detai1[l_ac].rtdv010,     s_detai1[l_ac].rtdv011,     s_detail[l_ac].rtdv001,    s_detail[l_ac].rtdv032 #sakura add rtdv032   
END FUNCTION

################################################################################
# Descriptions...: 商品條碼檢查
# Memo...........:
# Usage..........: CALL artt405_rtdv002(p_rtdv002)
# Input parameter: p_rtdv002      商品條碼
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdv002(p_rtdv002)
   DEFINE   l_cnt       LIKE type_t.num5
   DEFINE   l_cnt1      LIKE type_t.num5
   define   p_rtdv002   like rtdv_t.rtdv002   

   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT COUNT(*) INTO l_cnt  
     FROM imay_t,imaa_t 
    WHERE imayent = imaaent
      AND imaa001 = imay001 
      AND imayent = g_enterprise
      AND imay003 = p_rtdv002
      AND imay006 = 'Y'

   IF l_cnt <= 0 THEN
      LET g_errno = "art-00046"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  
        FROM imay_t,imaa_t 
       WHERE imayent = imaaent
         AND imaa001 = imay001 
         AND imayent = g_enterprise
         AND imay003 = p_rtdv002
         AND imaystus='Y' 
         AND imaastus='Y' 
         AND imay006='Y'
         
      IF l_cnt1 <= 0 THEN
         LET g_errno = "art-00047"
      END IF         
   END IF

END FUNCTION

################################################################################
# Descriptions...: 商品編號帶出品名、規格及其他欄位
# Memo...........:
# Usage..........: CALL artt405_rtdv001_display(p_rtdv001,p_cmd)
# Input parameter: p_rtdv001      商品編號
#                : p_cmd          單身輸入狀態
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdv001_display(p_rtdv001,p_cmd)
   DEFINE p_rtdv001   LIKE rtdv_t.rtdv001
   DEFINE p_cmd       LIKE type_t.chr1   
   DEFINE l_ooef019   LIKE ooef_t.ooef019
   DEFINE l_count     LIKE type_t.num5
   DEFINE l_imaa114   LIKE imaa_t.imaa114 #sakura add
   DEFINE l_imaa124   LIKE imaa_t.imaa124   #150213-00006#3 2015/02/13 By pomelo add
   
   SELECT imaal003,imaal004 INTO g_rtdv_d[l_ac].imaal003,g_rtdv_d[l_ac].imaal004
     FROM imaal_t 
    WHERE imaalent = g_enterprise    
      AND imaal001 = p_rtdv001
      AND imaal002 = g_dlang
      
   SELECT imaa009,imaa145 INTO g_rtdv_d[l_ac].imaa009,g_rtdv_d[l_ac].rtdv032 #sakura add rtdv032
     FROM imaa_t
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_rtdv001    
   IF p_cmd = 'a' THEN
      SELECT imaa009,imaa124,imaa123,
             imaa107,imaa115,imaa114,imaa116     #add by geza 20160315 imaa116
        INTO g_rtdv_d[l_ac].imaa009,l_imaa124,g_rtdv_d[l_ac].rtdv008,
             g_rtdv_d[l_ac].rtdv009,g_rtdv_d[l_ac].rtdv018,l_imaa114,g_rtdv_d[l_ac].rtdv023 #sakura add l_imaa114  #add by geza 20160315 rtdv023
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = p_rtdv001 
      
      #150213-00006#3 2015/02/13 By pomelo add(S)
      IF g_oodb011 = '2' THEN
         LET g_rtdv_d[l_ac].rtdv004 = l_imaa124
      #150213-00006#3 2015/02/13 By pomelo add(E)
         SELECT count(*) INTO l_count 
           FROM oodb_t 
          WHERE oodbent = g_enterprise 
            AND oodb002 = g_rtdv_d[l_ac].rtdv004 
            AND oodb004='1'
            AND oodb001 = g_rtdu_m.rtdu011
         IF l_count <= 0 THEN
            LET g_rtdv_d[l_ac].rtdv004 = NULL
         END IF
      END IF   #150213-00006#3 2015/02/13 By pomelo add
           
      SELECT imay004,imay005,imay012 INTO  g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv011,g_rtdv_d[l_ac].rtdv029
        FROM imay_t 
       WHERE imayent = g_enterprise 
         AND imay001 = p_rtdv001 
         AND imay003 = g_rtdv_d[l_ac].rtdv002
      #150827-00026#1 150831 by sakura mark&add(S)
      #DISPLAY g_rtdv_d[l_ac].rtdv004,g_rtdv_d[l_ac].rtdv008,g_rtdv_d[l_ac].rtdv009 ,g_rtdv_d[l_ac].rtdv005,
      DISPLAY g_rtdv_d[l_ac].rtdv004,g_rtdv_d[l_ac].rtdv008,g_rtdv_d[l_ac].rtdv009 ,g_rtdv_d[l_ac].l_oodb006,
      #150827-00026#1 150831 by sakura mark&add(E)
             #g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv011,g_rtdv_d[l_ac].rtdv018 #sakura mark
              g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv011,g_rtdv_d[l_ac].rtdv029 #sakura add
           #150827-00026#1 150831 by sakura mark&add(S)   
           #TO s_detai1[l_ac].rtdv004,s_detai1[l_ac].rtdv008,s_detai1[l_ac].rtdv009,s_detai1[l_ac].rtdv005,
           TO s_detai1[l_ac].rtdv004,s_detai1[l_ac].rtdv008,s_detai1[l_ac].rtdv009,s_detai1[l_ac].l_oodb006,
           #150827-00026#1 150831 by sakura mark&add(E)
             #s_detai1[l_ac].rtdv010,s_detai1[l_ac].rtdv011,s_detai1[l_ac].rtdv018 #sakura mark
              s_detai1[l_ac].rtdv010,s_detai1[l_ac].rtdv011,s_detai1[l_ac].rtdv029 #sakura add
     #sakura---add---str       
      #商品計價幣別=採購幣別,預設帶進價,否則帶0
      IF g_rtdu_m.l_stan006 = l_imaa114 THEN
         DISPLAY g_rtdv_d[l_ac].rtdv018 TO s_detai1[l_ac].rtdv018
         DISPLAY g_rtdv_d[l_ac].rtdv023 TO s_detai1[l_ac].rtdv023 #add by geza 20160315
         LET g_rtdv_d[l_ac].rtdv024 = g_rtdv_d[l_ac].rtdv023
         DISPLAY g_rtdv_d[l_ac].rtdv024 TO s_detai1[l_ac].rtdv024 #add by geza 20160315
         LET g_rtdv_d[l_ac].rtdv025 = g_rtdv_d[l_ac].rtdv023
         DISPLAY g_rtdv_d[l_ac].rtdv025 TO s_detai1[l_ac].rtdv025 #add by geza 20160315
         LET g_rtdv_d[l_ac].rtdv026 = g_rtdv_d[l_ac].rtdv023
         DISPLAY g_rtdv_d[l_ac].rtdv026 TO s_detai1[l_ac].rtdv026 #add by geza 20160315
      ELSE
         LET g_rtdv_d[l_ac].rtdv018 = 0
         DISPLAY g_rtdv_d[l_ac].rtdv018 TO s_detai1[l_ac].rtdv018
         LET g_rtdv_d[l_ac].rtdv023 = 0                           #add by geza 20160315
         DISPLAY g_rtdv_d[l_ac].rtdv023 TO s_detai1[l_ac].rtdv023 #add by geza 20160315
         LET g_rtdv_d[l_ac].rtdv024 = g_rtdv_d[l_ac].rtdv023
         DISPLAY g_rtdv_d[l_ac].rtdv024 TO s_detai1[l_ac].rtdv024 #add by geza 20160315
         LET g_rtdv_d[l_ac].rtdv025 = g_rtdv_d[l_ac].rtdv023
         DISPLAY g_rtdv_d[l_ac].rtdv025 TO s_detai1[l_ac].rtdv025 #add by geza 20160315
         LET g_rtdv_d[l_ac].rtdv026 = g_rtdv_d[l_ac].rtdv023
         DISPLAY g_rtdv_d[l_ac].rtdv026 TO s_detai1[l_ac].rtdv026 #add by geza 20160315
      END IF
     #sakura---add---end
   END IF
   SELECT imay004,imay005,imay012 INTO g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv011,g_rtdv_d[l_ac].rtdv029
     FROM imay_t 
    WHERE imayent = g_enterprise 
      AND imay001 = p_rtdv001 
      AND imay003 = g_rtdv_d[l_ac].rtdv002   
   
   SELECT rtaxl003 INTO g_rtdv_d[l_ac].imaa009_01_desc 
     FROM rtaxl_t 
    WHERE rtaxlent = g_enterprise 
      AND rtaxl001 = g_rtdv_d[l_ac].imaa009 
      AND rtaxl002 = g_dlang
      
   SELECT ooef019 INTO l_ooef019 
     FROM ooef_t 
    WHERE ooefent = g_enterprise 
      AND ooef001 = g_site
      
   #SELECT oodb006 INTO g_rtdv_d[l_ac].rtdv005 FROM oodb_t                                     #sakura mark
   # WHERE oodb002 =  g_rtdv_d[l_ac].rtdv004 AND oodb001 = g_rtdu_m.rtaa003  AND oodb004='1'   #sakura mark
     
   DISPLAY g_rtdv_d[l_ac].imaal003,g_rtdv_d[l_ac].imaal004, g_rtdv_d[l_ac].imaa009,g_rtdv_d[l_ac].imaa009_01_desc,
           g_rtdv_d[l_ac].rtdv010,g_rtdv_d[l_ac].rtdv011,g_rtdv_d[l_ac].rtdv032,g_rtdv_d[l_ac].rtdv029 #sakura add rtdv032   
   TO s_detai1[l_ac].imaal003_01,s_detai1[l_ac].imaal004_01,s_detai1[l_ac].imaa009_01,s_detai1[l_ac].imaa009_01_desc,
      s_detai1[l_ac].rtdv010,s_detai1[l_ac].rtdv011,s_detai1[l_ac].rtdv032,s_detai1[l_ac].rtdv029 #sakura add rtdv032  
   
   CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv029)
      RETURNING g_rtdv_d[l_ac].rtdv029_desc
      
   CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv010)
      RETURNING g_rtdv_d[l_ac].rtdv010_desc
      
   CALL s_desc_get_person_desc(g_rtdv_d[l_ac].rtdv013)
      RETURNING g_rtdv_d[l_ac].rtdv013_desc
      
   CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv009)
      RETURNING g_rtdv_d[l_ac].rtdv009_desc
      
   CALL s_desc_get_unit_desc(g_rtdv_d[l_ac].rtdv032)
      RETURNING g_rtdv_d[l_ac].rtdv032_desc
      
   CALL artt405_rtdv004_display(g_rtdv_d[l_ac].rtdv004)
   #150827-00026#1 150831 by sakura mark&add(S)
   #CALL artt405_rtdv005_rtdv030(g_rtdv_d[l_ac].rtdv004) #sakura add
   CALL artt405_oodb006_oodb005(g_rtdv_d[l_ac].rtdv004)
   #150827-00026#1 150831 by sakura mark&add(E)
END FUNCTION

################################################################################
# Descriptions...: 商品品類欄位檢查
# Memo...........:
# Usage..........: CALL artt405_chk_imaa009(p_rtdv001)
# Input parameter: p_rtdv001      商品編號
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_chk_imaa009(p_rtdv001)
   DEFINE p_rtdv001 LIKE rtdv_t.rtdv001
   DEFINE l_staq003 LIKE staq_t.staq003
   DEFINE l_imaa009 LIKE imaa_t.imaa009
   DEFINE l_count   LIKE type_t.num5
   DEFINE l_sql     STRING
   
   #150915-00001#1 150915 by sakura mark(S)
   #CREATE TEMP TABLE artt405_tmp
   #(
   #   rtax001 VARCHAR(10)
   #);
   #150915-00001#1 150915 by sakura mark(E)
   
   LET l_count = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_count
     FROM staq_t 
    WHERE staqent=g_enterprise
      AND staq001=g_rtdu_m.rtdu002 
   IF l_count <= 0 THEN
      LET g_errno = "art-00120"
      RETURN
   END IF
   LET l_count = 0   
   SELECT imaa009 INTO l_imaa009
     FROM imaa_t 
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_rtdv001

   LET l_sql = "SELECT DISTINCT staq003 FROM staq_t WHERE staq001='",g_rtdu_m.rtdu002,"' ",
               "   AND staqent=",g_enterprise
   PREPARE l_sql_imaa009 FROM l_sql 
   DECLARE l_sql_imaa009_cs CURSOR FOR l_sql_imaa009
   #151027-00016#6 20151202 mark by beckxie---S
   #FOREACH l_sql_imaa009_cs INTO l_staq003
   #   LET l_sql=" INSERT INTO artt405_tmp  SELECT rtax001 FROM (SELECT rtax001,rtax003,rtax005 FROM rtax_t ",  
   #             "  WHERE rtaxent = ",g_enterprise,       #150613-00063#1 1500614 by lori522612 add
   #             "  START WITH rtax003 = '",l_staq003,
   #             "'  CONNECT BY nocycle PRIOR rtax001 = rtax003 ) WHERE rtax005=0 "
   #   PREPARE l_sql_imaa_pre1 FROM l_sql
   #   EXECUTE l_sql_imaa_pre1
   #   LET l_sql="INSERT INTO artt405_tmp ",
   #             "   SELECT rtax001 FROM rtax_t ",
   #             "    WHERE rtaxent = ",g_enterprise,    #150613-00063#1 1500614 by lori522612 add
   #             "      AND rtax001='",l_staq003,"' AND rtax005=0 "
   #   PREPARE l_sql_imaa_pre2 FROM l_sql
   #   EXECUTE l_sql_imaa_pre2
   #         
   #END FOREACH
   #151027-00016#6 20151202 mark by beckxie---E
   #151027-00016#6 20151202  add by beckxie---S
   LET l_sql=" INSERT INTO artt405_tmp  SELECT rtax001 FROM (SELECT rtax001,rtax003,rtax005 FROM rtax_t ",  
             "  WHERE rtaxent = ",g_enterprise,       #150613-00063#1 1500614 by lori522612 add
             "  START WITH rtax003 = ? ",
             "  CONNECT BY nocycle PRIOR rtax001 = rtax003 ) WHERE rtax005=0 "
   PREPARE l_sql_imaa_pre1 FROM l_sql
   LET l_sql=" INSERT INTO artt405_tmp ",
             " SELECT rtax001 FROM rtax_t ",
             "  WHERE rtaxent = ",g_enterprise,    #150613-00063#1 1500614 by lori522612 add
             "    AND rtax001=? AND rtax005=0 "
   PREPARE l_sql_imaa_pre2 FROM l_sql
   FOREACH l_sql_imaa009_cs INTO l_staq003
      EXECUTE l_sql_imaa_pre1 USING l_staq003
      EXECUTE l_sql_imaa_pre2 USING l_staq003
   END FOREACH
   #151027-00016#6 20151202  add by beckxie---E
   SELECT count(*) INTO l_count 
     FROM artt405_tmp
    WHERE rtax001 = l_imaa009      
   IF l_count <= 0 THEN
      LET g_errno = "art-00120"
      RETURN
   ELSE
      RETURN  
   END IF  
END FUNCTION

################################################################################
# Descriptions...: 由商品條碼帶出商品編號
# Memo...........:
# Usage..........: CALL artt405_rtdv002_display(p_rtdv002)
# Input parameter: p_rtdv002      商品條碼
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdv002_display(p_rtdv002)
   DEFINE p_rtdv002   LIKE rtdv_t.rtdv002
   
   SELECT DISTINCT imay001 INTO g_rtdv_d[l_ac].rtdv001 
     FROM imay_t
    WHERE imayent = g_enterprise  
      AND imay003 = p_rtdv002 
      AND rownum = 1
   DISPLAY g_rtdv_d[l_ac].rtdv001 TO  s_detai1[l_ac].rtdv001
END FUNCTION

################################################################################
# Descriptions...: 檢查輸入的商品不可重覆
# Memo...........:
# Usage..........: CALL artt405_unique_rtdv001(p_rtdv001,p_rtdvseq)
# Input parameter: p_rtdv001      商品編號
#                : p_rtdvseq      項次
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_unique_rtdv001(p_rtdv001,p_rtdvseq)
   DEFINE p_rtdv001 LIKE rtdv_t.rtdv001
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE p_rtdvseq LIKE rtdv_t.rtdvseq
   
   LET g_errno = NULL
   LET l_cnt = 0
   IF NOT cl_null(p_rtdvseq) THEN
      SELECT COUNT(*) INTO l_cnt 
        FROM rtdv_t 
       WHERE rtdvent = g_enterprise
         AND rtdvdocno = g_rtdu_m.rtdudocno 
         AND rtdv001 = p_rtdv001 
         AND rtdvseq!= p_rtdvseq
   ELSE      
      SELECT count(*) INTO l_cnt 
        FROM rtdv_t 
       WHERE rtdvent = g_enterprise
         AND rtdvdocno = g_rtdu_m.rtdudocno 
         AND rtdv001 = p_rtdv001
   END IF      
   IF l_cnt >0 THEN
      LET g_errno = "art-00072"
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 由商品編號帶出商品主條碼
# Memo...........:
# Usage..........: CALL artt405_rtdv001_display1(p_rtdv001)
# Input parameter: p_rtdv001      商品編號
#                : 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdv001_display1(p_rtdv001)
   DEFINE p_rtdv001   LIKE rtdv_t.rtdv001
   
   SELECT imay003 INTO g_rtdv_d[l_ac].rtdv002 
     FROM imay_t
    WHERE imayent = g_enterprise
      AND imay001 = p_rtdv001 
      AND imay006 = 'Y' 
      AND rownum = 1
      
   DISPLAY g_rtdv_d[l_ac].rtdv002 TO  s_detai1[l_ac].rtdv002
END FUNCTION

################################################################################
# Descriptions...: 檢查商品是否存在且有效
# Memo...........:
# Usage..........: CALL artt405_rtdv001(p_rtdv001)
# Input parameter: p_rtdv001      商品編號
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdv001(p_rtdv001)
   DEFINE   l_cnt       LIKE type_t.num5
   DEFINE   l_cnt1      LIKE type_t.num5
   DEFINE   p_rtdv001   LIKE rtdv_t.rtdv001   

   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   
   SELECT COUNT(*) INTO l_cnt 
     FROM imaa_t 
    WHERE imaaent = g_enterprise
      AND imaa001 = p_rtdv001 
      
   IF l_cnt <= 0 THEN
      LET g_errno = "art-00016"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  
        FROM imaa_t 
       WHERE imaaent = g_enterprise
         AND imaa001 = p_rtdv001
         AND imaastus= 'Y'
      IF l_cnt1 <= 0 THEN
#         LET g_errno = "art-00050"     #160318-00005#43  mark
         LET g_errno = "sub-01302"     #160318-00005#43  add
      END IF         
   END IF
   IF cl_null(g_errno) THEN
      CALL artt405_chk_imaa009(p_rtdv001)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 檢查單位是否存在、有效
# Memo...........:
# Usage..........: CALL artt405_rtdv009(p_rtdv009)
# Input parameter: p_rtdv009      採購單位
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdv009(p_rtdv009)
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_cnt1      LIKE type_t.num5
   DEFINE p_rtdv009   LIKE rtdv_t.rtdv009   

   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   
   SELECT COUNT(*) INTO l_cnt  
     FROM ooca_t 
    WHERE oocaent = g_enterprise 
      AND ooca001 = p_rtdv009
      
   IF l_cnt <= 0 THEN
      LET g_errno = "aim-00004"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  
        FROM ooca_t 
       WHERE oocaent = g_enterprise 
         AND ooca001 = p_rtdv009
         AND oocastus='Y'
         
      IF l_cnt1 <= 0 THEN
#         LET g_errno = "aim-00005"     #160318-00005#43  mark
         LET g_errno = "sub-01302"     #160318-00005#43  add
      END IF         
   END IF
END FUNCTION

################################################################################
# Descriptions...: 含稅、未稅進價金額計算
# Memo...........:
# Usage..........: CALL artt405_rtdv019()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdv019()
   DEFINE l_count   LIKE rtdv_t.rtdv019   #進價*訂貨數(計稅基礎)
   DEFINE l_xrcd104 LIKE xrcd_t.xrcd104   #原幣稅額        #sakura add
   DEFINE l_xrcd113 LIKE xrcd_t.xrcd113   #本幣未稅金額    #sakura add
   DEFINE l_xrcd114 LIKE xrcd_t.xrcd114   #本幣稅額        #sakura add
   DEFINE l_xrcd115 LIKE xrcd_t.xrcd115   #本幣含稅金額    #sakura add
  #DEFINE l_rtdw001 LIKE rtdw_t.rtdw001   #門店編號        #sakura add     #150504-00005#1 150525 by lori522612 mark
   
   IF cl_null(g_rtdv_d[l_ac].rtdv018) THEN
      LET g_rtdv_d[l_ac].rtdv018 = 0
   END IF
   IF cl_null(g_rtdv_d[l_ac].rtdv017) THEN
      LET g_rtdv_d[l_ac].rtdv017 = 0
   END IF
   ##150504-00005#1 150525 by lori522612 mark and add ---(S)  
   ##sakura---add---str
   ##含稅/未含稅進價轉換
   #
   #DECLARE rtdw001 SCROLL CURSOR FOR
   #   SELECT rtdw001 FROM rtdw_t WHERE rtdwdocno = g_rtdu_m.rtdudocno
   #OPEN rtdw001
   #FETCH FIRST rtdw001 INTO l_rtdw001
   #
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = g_rtdu_m.rtdudocno
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #END IF
   #
   #LET l_count = g_rtdv_d[l_ac].rtdv017 * g_rtdv_d[l_ac].rtdv018
   #CALL s_tax_count(l_rtdw001,g_rtdv_d[l_ac].rtdv004,l_count,g_rtdv_d[l_ac].rtdv017,g_rtdu_m.l_stan006,1)
   #            RETURNING g_rtdv_d[l_ac].rtdv031,l_xrcd104,g_rtdv_d[l_ac].rtdv019,l_xrcd113,l_xrcd114,l_xrcd115
   #DISPLAY g_rtdv_d[l_ac].rtdv031,g_rtdv_d[l_ac].rtdv019 TO s_detail1[l_ac].rtdv031,s_detail1[l_ac].rtdv019           
   ##sakura---add---end
   
   LET l_count = g_rtdv_d[l_ac].rtdv017 * g_rtdv_d[l_ac].rtdv018
   CALL s_tax_count2(g_rtdu_m.rtdusite     ,g_rtdu_m.rtdu011  ,g_rtdv_d[l_ac].rtdv004,l_count,
                     g_rtdv_d[l_ac].rtdv017,g_rtdu_m.l_stan006,1)
               RETURNING g_rtdv_d[l_ac].rtdv031,l_xrcd104,g_rtdv_d[l_ac].rtdv019,l_xrcd113,l_xrcd114,l_xrcd115 
   DISPLAY BY NAME g_rtdv_d[l_ac].rtdv031,g_rtdv_d[l_ac].rtdv019               
   #150504-00005#1 150525 by lori522612 mark and add ---(E)
END FUNCTION

################################################################################
# Descriptions...: 門店編號說明+取稅區欄位
# Memo...........:
# Usage..........: CALL artt405_rtdw001_display(p_rtdw001)
# Input parameter: p_rtdw001      門店編號
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdw001_display(p_rtdw001)
   DEFINE p_rtdw001   LIKE rtdw_t.rtdw001
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_rtdw001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtdv2_d[l_ac].rtdw001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtdv2_d[l_ac].rtdw001_desc
   
   SELECT ooef019 INTO g_rtdv2_d[l_ac].ooef019 
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_rtdv2_d[l_ac].rtdw001 
   DISPLAY  g_rtdv2_d[l_ac].ooef019 TO s_detail2[l_ac].ooef019 
END FUNCTION

################################################################################
# Descriptions...: 取得門店預設收貨倉
# Memo...........:
# Usage..........: CALL artt405_get_ooef123(p_site)
#                  RETURNING r_ooef123
# Input parameter: p_site      門店編號
# Return code....: r_ooef123   預設收貨倉
# Date & Author..: 2015/05/16 By Lori   #150515-00006#1
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_get_ooef123(p_site)
   DEFINE p_site      LIKE ooef_t.ooef001
   DEFINE r_ooef123   LIKE ooef_t.ooef123
   
   LET r_ooef123 = ''
   
   SELECT ooef123 INTO r_ooef123
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_site   
      
   RETURN r_ooef123
END FUNCTION

################################################################################
# Descriptions...: 門店編號欄位檢查
# Memo...........:
# Usage..........: CALL artt405_rtdw001()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdw001()
   DEFINE   l_cnt       LIKE type_t.num5
   DEFINE   l_cnt1      LIKE type_t.num5  
   DEFINE   l_ooef019   LIKE ooef_t.ooef019
   DEFINE   l_sql       STRING      #150505-00012#1--add by dongsz
   
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
       
   #150505-00012#1--mark by dongsz--str---       
#   SELECT COUNT(*) INTO l_cnt  FROM rtab_t WHERE rtabent = g_enterprise AND rtab002 = g_rtdv2_d[l_ac].rtdw001
#      AND rtab001 = g_rtdu_m.rtdu008
#   IF l_cnt <= 0 THEN
#      LET g_errno = "art-00061"
#   ELSE
   #150505-00012#1--mark by dongsz--end---
   SELECT COUNT(*) INTO l_cnt1 
     FROM ooef_t 
    WHERE ooefent = g_enterprise 
      AND ooef001 = g_rtdv2_d[l_ac].rtdw001
      
   IF l_cnt1 <=0 THEN
      LET g_errno = "art-00062"
   ELSE      
      SELECT COUNT(*) INTO l_cnt1 
        FROM ooef_t 
       WHERE ooefent = g_enterprise 
         AND ooef001 = g_rtdv2_d[l_ac].rtdw001
         AND ooefstus = 'Y'
         
      IF l_cnt1<=0 THEN
         LET g_errno = "art-00069"
      ELSE   
         SELECT ooef019 INTO l_ooef019 
           FROM ooef_t 
          WHERE ooefent = g_enterprise 
            AND ooef001 = g_rtdv2_d[l_ac].rtdw001
            AND ooefstus = 'Y'
            
         IF l_ooef019 != g_rtdu_m.rtdu011 THEN 
            LET g_errno = "art-00525"
         END IF             
      END IF 
   END IF
   #150505-00012#1--add by dongsz--str---
   IF cl_null(g_errno) THEN
      #判断是否属于单头采购中心组织树下
      LET l_cnt = 0
      LET l_sql = " SELECT COUNT(*) FROM ooed_t ",
                  "  WHERE ooedent = ",g_enterprise," ",
                  "    AND ooed004 = '",g_rtdv2_d[l_ac].rtdw001,"' ",
                  #"    AND EXISTS (SELECT 1 FROM stbo_t WHERE  stboent = ",g_enterprise," AND stbo003 = ooed004 AND stbo001 = '",g_rtdu_m.rtdu002,"' ) ",      #add by geza 20150630 #mark by geza 20160316
                  "    AND ooed004 IN (SELECT ooed004 FROM ooed_t ",
                  "                     START WITH ooed005 = '",g_rtdu_m.rtdu005,"' AND ooed001 = '10' ",
                  "                       AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                  "                    CONNECT BY nocycle PRIOR ooed004 = ooed005 AND ooed001 = '10' ",
                  "                       AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                  "                     UNION SELECT ooed004 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND ooed004 = '",g_rtdu_m.rtdu005,"') "  #160905-00007#15 by 08172 add ent
      PREPARE sel_ooed_pre FROM l_sql
      EXECUTE sel_ooed_pre INTO l_cnt
      IF l_cnt <= 0 THEN
         LET g_errno = "art-00565"
         RETURN
      END IF
      #add by geza 20160316(S)
      #判断是否属于合同经营门店下
      #门店不等于采购中心和配送中心的时候才判断
      IF g_rtdv2_d[l_ac].rtdw001 <> g_rtdu_m.rtdu005 
         AND ((g_rtdu_m.rtdu007 <> g_rtdv2_d[l_ac].rtdw001 AND g_rtdu_m.rtdu007 IS NOT NULL) OR (g_rtdu_m.rtdu007 IS NULL)) THEN
         LET l_cnt = 0
         LET l_sql = " SELECT COUNT(*) FROM stbo_t ",
                     "  WHERE stboent = ",g_enterprise," ",
                     "    AND stbo003 = '",g_rtdv2_d[l_ac].rtdw001,"' ",
                     "    AND stbo001 = '",g_rtdu_m.rtdu002,"' "
         PREPARE sel_stbo_pre FROM l_sql
         EXECUTE sel_stbo_pre INTO l_cnt
         IF l_cnt <= 0 THEN
            LET g_errno = "art-00750"
            RETURN
         END IF
      END IF   
      #add by geza 20160316(E)
      #店群不为空，则需存在于店群下的门店
      LET l_cnt = 0
      IF NOT cl_null(g_rtdu_m.rtdu008) THEN 
         SELECT COUNT(*) INTO l_cnt
           FROM rtab_t 
          WHERE rtabent = g_enterprise 
            AND rtab002 = g_rtdv2_d[l_ac].rtdw001
            AND rtab001 = g_rtdu_m.rtdu008
         IF l_cnt <= 0 THEN
            LET g_errno = "art-00061"
            RETURN
         END IF
      END IF
   END IF
   
   #150505-00012#1--add by dongsz--end---
   #END IF           #150505-00012#1--mark by dongsz
END FUNCTION

################################################################################
# Descriptions...: 單頭采购中心不為空白時，單身的門店預帶采购中心
# Memo...........:
# Usage..........: CALL artt405_creat_rtdw001()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_creat_rtdw001()
   DEFINE l_sql      STRING
   DEFINE l_sql_tmp  STRING
   DEFINE l_cnt      LIKE type_t.num5    #151113-00003#1 Add By Ken 151116
   
   #150505-00012#1--mark by dongsz--str---
#   LET l_sql=" INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001) SELECT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',rtab002 ",
#             "  FROM rtab_t WHERE rtabent = ",g_enterprise," AND rtab001 = '",g_rtdu_m.rtdu008,"' "
#   PREPARE artt405_rtdw_pre FROM l_sql
#   EXECUTE artt405_rtdw_pre
   #150505-00012#1--mark by dongsz--end---
   #150505-00012#1--add by dongsz--str---
   #店群不为空，则门店编号存在于店群下的组织且存在于单头采购中心的组织树下；
   #店群为空，则门店编号存在于单头采购中心的组织树下
   IF cl_null(g_rtdu_m.rtdu008) THEN
      #150515-00006#1 150516 by lori522612 mark---(S) 
      #LET l_sql = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001) ",
      #            " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004 ",
      #            "   FROM ooed_t ",      
      #            "  WHERE AND ooedent = ",g_enterprise," ",
      #150515-00006#1 150516 by lori522612 mark---(E)
      #150515-00006#1 150516 by lori522612 add---(S)       
      #LET l_sql = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) "
      
      #160324-00019#1 Add By Ken 160330(S)
      IF g_rtdu_m.rtdu003 = '3' THEN  # 經營方式為3:扣率代銷時，預設庫位為非成本庫位
         LET l_sql_tmp = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                         " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004,ooef126 "
      ELSE    # 經營方式非3:扣率代銷時，預設庫位為成本庫位
         LET l_sql_tmp = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                         " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004,ooef123 "
      END IF
      #160324-00019#1 Add By Ken 160330(E)
      LET l_sql = l_sql_tmp ,
                  "   FROM ooed_t ",
                  "        LEFT JOIN ooef_t ON ooedent = ooefent AND ooef001 = ooed004 ", 
      #150515-00006#1 150516 by lori522612 add---(E)              
                  "  WHERE ooedent = ",g_enterprise," ",
                  "    AND EXISTS (SELECT 1 FROM stbo_t WHERE  stboent = ",g_enterprise," AND stbo003 = ooed004 AND stbo001 = '",g_rtdu_m.rtdu002,"' ) ",  #Add By geza 150630 加上存在于合同中才預帶資料
                  "    AND ooef019 = '",g_rtdu_m.rtdu011,"' ",  #Add By Ken 150618 加上稅區需與單頭稅區別相同才預帶資料
                  "    AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                  "    AND ooed004 IN (SELECT ooed004 FROM ooed_t ",
                  "                     START WITH ooed005 = '",g_rtdu_m.rtdu005,"' AND ooed001 = '10' ",
                  "                       AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                  "                    CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '10' ",
                  "                       AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                  "                     UNION SELECT ooed004 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND ooed004 = '",g_rtdu_m.rtdu005,"') " #160905-00007#15 by 08172 add ent
   ELSE           
      #150515-00006#1 150516 by lori522612 mark---(S) 
      #LET l_sql = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001) ",
      #            " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',rtab002 ",
      #            "   FROM rtab_t ",
      #150515-00006#1 150516 by lori522612 mark---(S) 
      #150515-00006#1 150516 by lori522612 add---(S) 
      
      #160324-00019#1 Add By Ken 160330 (S)
      IF g_rtdu_m.rtdu003 = '3' THEN
         LET l_sql_tmp = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                         " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',rtab002,ooef126 "
      ELSE
         LET l_sql_tmp = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                         " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',rtab002,ooef123 "      
      END IF
      #160324-00019#1 Add By Ken 160330 (E)
      LET l_sql = l_sql_tmp , 
                  "   FROM rtab_t ",
                  "        LEFT JOIN ooef_t ON rtabent = ooefent AND ooef001 = rtab002 ", 
      #150515-00006#1 150516 by lori522612 add---(S)      
                  "  WHERE rtabent = ",g_enterprise," AND rtab001 = '",g_rtdu_m.rtdu008,"' ",
                  "    AND EXISTS (SELECT 1 FROM stbo_t WHERE  stboent = ",g_enterprise," AND stbo003 = rtab002 AND stbo001 = '",g_rtdu_m.rtdu002,"' ) ",  #Add By geza 150630 加上存在于合同中才預帶資料
                  "    AND ooef019 = '",g_rtdu_m.rtdu011,"' ",  #Add By Ken 150618 加上稅區需與單頭稅區別相同才預帶資料
                  "    AND rtab002 IN (SELECT ooed004 FROM ooed_t ",
                  "                     START WITH ooed005 = '",g_rtdu_m.rtdu005,"' AND ooed001 = '10' ",
                  "                       AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                  "                    CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001 = '10' ",
                  "                       AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                  "                     UNION SELECT ooed004 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND ooed004 = '",g_rtdu_m.rtdu005,"') " #160905-00007#15 by 08172 add ent
   END IF
   PREPARE artt405_rtdw_pre FROM l_sql
   EXECUTE artt405_rtdw_pre
   #150505-00012#1--add by dongsz--end---
   
   #151113-00003#1 Add By Ken 151116(S) 如採購中心不在門店範圍內則新增一筆採購中心到門店範圍
   LET l_cnt = 0
   IF NOT cl_null(g_rtdu_m.rtdu005) THEN
      SELECT COUNT(1) INTO l_cnt
        FROM rtdw_t
       WHERE rtdwent = g_enterprise
         AND rtdwdocno = g_rtdu_m.rtdudocno
         AND rtdw001 = g_rtdu_m.rtdu005
      IF l_cnt = 0 THEN
         #160324-00019#1 Add By Ken 160330 (S)
         IF g_rtdu_m.rtdu003 = '3' THEN  #經營方式為3:扣率代銷時，預設庫位為非成本庫位
            LET l_sql_tmp = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                     " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004,ooef126 "
         ELSE                            #經營方式非3:扣率代銷時，預設庫位為成本庫位
            LET l_sql_tmp = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                     " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004,ooef123 "         
         END IF
         #160324-00019#1 Add By Ken 160330 (E)
         LET l_sql = l_sql_tmp,
                     "   FROM ooed_t ",
                     "        LEFT JOIN ooef_t ON ooedent = ooefent AND ooef001 = ooed004 ", 
                     "  WHERE ooedent = ",g_enterprise," ",
                     "    AND ooef019 = '",g_rtdu_m.rtdu011,"' ",  #Add By Ken 150618 加上稅區需與單頭稅區別相同才預帶資料
                     "    AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                     "    AND ooed004 = '",g_rtdu_m.rtdu005,"' "  
         PREPARE artt405_rtdw_pre1 FROM l_sql
         EXECUTE artt405_rtdw_pre1                     
      END IF
   END IF
   #151113-00003#1 Add By Ken 151116(E)  
   
   #151113-00003#10 Add By Ken 151127(S)
   LET l_cnt = 0
   IF NOT cl_null(g_rtdu_m.rtdu007) THEN
      SELECT COUNT(*) INTO l_cnt
        FROM rtdw_t
       WHERE rtdwent = g_enterprise
         AND rtdwdocno = g_rtdu_m.rtdudocno
         AND rtdw001 = g_rtdu_m.rtdu007
      IF l_cnt = 0 THEN
         #160324-00019#1 Add By Ken 160330 (S)
         IF g_rtdu_m.rtdu003 = '3' THEN #經營方式為3:扣率代銷時，預設庫位為非成本庫位
            LET l_sql_tmp = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                     " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004,ooef126 "
         ELSE                           #經營方式非3:扣率代銷時，預設庫位為成本庫位
            LET l_sql_tmp = " INSERT INTO rtdw_t(rtdwent,rtdwdocno,rtdw001,rtdw002) ",
                     " SELECT DISTINCT ",g_enterprise,",'",g_rtdu_m.rtdudocno,"',ooed004,ooef123 "         
         END IF         
         #160324-00019#1 Add By Ken 160330 (E)
         
         LET l_sql = l_sql_tmp,
                     "   FROM ooed_t ",
                     "        LEFT JOIN ooef_t ON ooedent = ooefent AND ooef001 = ooed004 ", 
                     "  WHERE ooedent = ",g_enterprise," ",
                     "    AND ooef019 = '",g_rtdu_m.rtdu011,"' ",  
                     "    AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
                     "    AND ooed004 = '",g_rtdu_m.rtdu007,"' "  
         PREPARE artt405_rtdw_pre2 FROM l_sql
         EXECUTE artt405_rtdw_pre2                     
      END IF
   END IF   
   #151113-00003#10 Add By Ken 151127(E)
END FUNCTION

################################################################################
# Descriptions...: 取單頭稅別 稅別應用
# Memo...........: 1:正常稅率2:依料件設定
# Usage..........: CALL artt405_get_oodb011()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/13 By pomelo 150213-00006#3
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_get_oodb011()

   LET g_oodb011 = ''
   SELECT oodb011 INTO g_oodb011
     FROM oodb_t
    WHERE oodbent = g_enterprise 
      AND oodb001 = g_rtdu_m.rtdu011    
      AND oodb002 = g_rtdu_m.l_stan007
      AND oodb004 = '1'
END FUNCTION

################################################################################
# Descriptions...: 取的合約幣別.進項稅別
# Memo...........:
# Usage..........: CALL artt405_get_stan()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/13 By pomelo   150213-00006#3
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_get_stan()
   
   SELECT stan006,stan007
     INTO g_rtdu_m.l_stan006,g_rtdu_m.l_stan007
     FROM stan_t
    WHERE stanent = g_enterprise
      AND stan001 = g_rtdu_m.rtdu002
END FUNCTION

################################################################################
# Descriptions...: 單身項次加1
# Memo...........:
# Usage..........: CALL artt405_create_rtdvseq()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_create_rtdvseq()
   IF (cl_null(g_rtdv_d[l_ac].rtdvseq) OR g_rtdv_d[l_ac].rtdvseq=0) THEN
      SELECT MAX(rtdvseq)+1 INTO g_rtdv_d[l_ac].rtdvseq 
        FROM rtdv_t
       WHERE rtdvent = g_enterprise
         AND rtdvdocno = g_rtdu_m.rtdudocno 
   END IF
   IF (cl_null(g_rtdv_d[l_ac].rtdvseq) OR g_rtdv_d[l_ac].rtdvseq=0) THEN
      LET g_rtdv_d[l_ac].rtdvseq = 1
   END IF
END FUNCTION

################################################################################
# Descriptions...: 會員價1、2、3由售價預帶
# Memo...........:
# Usage..........: CALL artt405_rtdv023_display()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdv023_display()
   IF cl_null(g_rtdv_d[l_ac].rtdv024) OR g_rtdv_d[l_ac].rtdv024 = '0' THEN
      LET g_rtdv_d[l_ac].rtdv024 = g_rtdv_d[l_ac].rtdv023
   END IF
   IF cl_null(g_rtdv_d[l_ac].rtdv025) OR g_rtdv_d[l_ac].rtdv025 = '0' THEN
      LET g_rtdv_d[l_ac].rtdv025 = g_rtdv_d[l_ac].rtdv023
   END IF
   IF cl_null(g_rtdv_d[l_ac].rtdv026) OR g_rtdv_d[l_ac].rtdv026 = '0' THEN
      LET g_rtdv_d[l_ac].rtdv026 = g_rtdv_d[l_ac].rtdv023
   END IF
   DISPLAY  g_rtdv_d[l_ac].rtdv024 TO s_detail1[l_ac].rtdv024
   DISPLAY  g_rtdv_d[l_ac].rtdv025 TO s_detail1[l_ac].rtdv025
   DISPLAY  g_rtdv_d[l_ac].rtdv026 TO s_detail1[l_ac].rtdv026
END FUNCTION

################################################################################
# Descriptions...: 更新單身相關欄位
# Memo...........:
# Usage..........: CALL artt405_update_rtdv()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success     TRUE/FALSE
# Date & Author..: 2015/06/19 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_update_rtdv()
DEFINE  l_rtdv003   LIKE rtdv_t.rtdv003
DEFINE  l_rtdv004   LIKE rtdv_t.rtdv004
DEFINE  l_rtdv005   LIKE rtdv_t.rtdv005
DEFINE  l_rtdv007   LIKE rtdv_t.rtdv007    #150213-00006#3 2015/02/13 By pomelo add
DEFINE  l_rtdv008   LIKE rtdv_t.rtdv008
DEFINE  l_rtdv009   LIKE rtdv_t.rtdv009
DEFINE  l_rtdv013   LIKE rtdv_t.rtdv013
DEFINE  l_rtdv014   LIKE rtdv_t.rtdv014
DEFINE  l_rtdv015   LIKE rtdv_t.rtdv015
DEFINE  l_rtdv018   LIKE rtdv_t.rtdv018
DEFINE  l_ooef019   LIKE ooef_t.ooef019
DEFINE  l_rtdv027   LIKE rtdv_t.rtdv027
DEFINE  l_rtdv028   LIKE rtdv_t.rtdv028
DEFINE  l_rtdv030   LIKE rtdv_t.rtdv030    #150213-00006#3 2015/02/13 By pomelo add
DEFINE  l_rtdv033   LIKE rtdv_t.rtdv033 #sakura add
DEFINE  l_count     LIKE type_t.num5
DEFINE  l_cnt       LIKE type_t.num5    #150213-00006#3 2015/02/13 By pomelo add
DEFINE  l_rtdv006   LIKE rtdv_t.rtdv006
DEFINE  l_rtdv029   LIKE rtdv_t.rtdv029
DEFINE  r_success   LIKE type_t.num5


   LET r_success= TRUE
   LET l_rtdv003 = "Y"
   LET l_rtdv014 = "1"
   LET l_rtdv015 = "1"   
   #SELECT imaa124,imaa123,imaa107,imaa116 INTO l_rtdv004, #sakura mark
   SELECT imaa124,imaa123,imaa107,imaa115 INTO l_rtdv004,l_rtdv008,l_rtdv009,l_rtdv018 #sakura add     
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_rtdv_d[l_ac].rtdv001
   
   #150213-00006#3 2015/02/13 By pomelo add(S)
   IF g_oodb011 = '1' THEN
      LET l_rtdv004 = g_rtdu_m.l_stan007
   ELSE
   #150213-00006#3 2015/02/13 By pomelo add(E)   
      SELECT COUNT(*) INTO l_count  
        FROM oodb_t 
       WHERE oodbent = g_enterprise 
         AND oodb001 = g_rtdu_m.rtdu011  
         AND oodb002 = l_rtdv004
         AND oodb004 = '1'

      IF l_count <= 0 THEN
         LET l_rtdv004 = NULL
      END IF
   END IF   #150213-00006#3 2015/02/13 By pomelo add
   
   #150213-00006#3 2015/02/13 By pomelo mark(S)
   #SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooef001 = g_site  
   #SELECT oodb006 INTO l_rtdv005 FROM oodb_t 
   # WHERE oodb002 =  l_rtdv004 AND oodb001 = g_rtdu_m.rtaa003  AND oodb004='1'
   #150213-00006#3 2015/02/13 By pomelo mark(E)
   #150213-00006#3 2015/02/13 By pomelo add(S)
   SELECT oodb005,oodb006 
     INTO l_rtdv030,l_rtdv005
     FROM oodb_t
    WHERE oodbent = g_enterprise 
      AND oodb001 = g_rtdu_m.rtdu011    
      AND oodb002 = l_rtdv004 
      AND oodb004 = '1'
   IF g_oodb011 = '1' THEN
      LET l_cnt = 0
      #進項稅別
      SELECT COUNT(rtdvseq) INTO l_cnt
        FROM rtdv_t
       WHERE rtdvent = g_enterprise
         AND rtdvseq = g_rtdv_d[l_ac].rtdvseq
         AND COALESCE(rtdv00004,'-1') = '-1'
      IF l_cnt = 0 THEN
         LET l_rtdv007 = l_rtdv005
      END IF
   END IF
   #150213-00006#3 2015/02/13 By pomelo add(E)
   #SELECT stan017,stan018,stan006 #sakura add stan006
    SELECT stan017,(CASE WHEN (stan031 IS NOT NULL) THEN stan031 ELSE stan018 END),stan006  #By shi Add 20150701
     INTO l_rtdv027,l_rtdv028,l_rtdv033 #sakura add l_rtdv033
     FROM stan_t
    WHERE stanent = g_enterprise
      AND stan001 = g_rtdu_m.rtdu002 
      
   LET l_rtdv013=g_rtdu_m.rtdu006
   
   UPDATE rtdv_t SET rtdv003=l_rtdv003,
                     rtdv004=l_rtdv004,
                     #rtdv005=l_rtdv005,     #150827-00026#1 150831 by sakura mark
                     #rtdv007 = l_rtdv007,   #150213-00006#3 2015/02/13 By pomelo add #150506-00017#1  sakura mark
                     rtdv008=l_rtdv008,
                     rtdv009=l_rtdv009,
                     rtdv013=l_rtdv013,
                     rtdv012='1',
                     rtdv014=l_rtdv014,
                     rtdv015=l_rtdv015,
                     rtdv018=l_rtdv018,
                     rtdv027=l_rtdv027,
                     rtdv028=l_rtdv028,
                     rtdv033=l_rtdv033  #sakura add
     WHERE rtdvent=g_enterprise 
       AND rtdvdocno=g_rtdu_m.rtdudocno
       AND rtdvseq=g_rtdv_d[l_ac].rtdvseq
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success=false
      RETURN r_success   
   END IF 
   
   
   
   #150213-00006#3 2015/02/13 By pomelo add(S)
   IF g_oodb011 = '1' THEN
      LET l_rtdv006 = g_rtdu_m.l_stan007
   ELSE
   #150213-00006#3 2015/02/13 By pomelo add(E)
      SELECT imaa124 INTO l_rtdv006
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = g_rtdv_d[l_ac].rtdv001 
          
      SELECT COUNT(*) INTO l_count  
        FROM oodb_t 
       WHERE oodbent = g_enterprise 
         AND oodb001 = g_rtdu_m.rtdu011
         AND oodb002 = l_rtdv006
         AND oodb004='1'         

      IF l_count <= 0 THEN
         LET l_rtdv006 = NULL
      END IF
   END IF     #150213-00006#3 2015/02/13 By pomelo add
   
   SELECT imay012 INTO  l_rtdv029
     FROM imay_t 
    WHERE imayent = g_enterprise 
      AND imay001 = g_rtdv_d[l_ac].rtdv001 
      AND imay003 = g_rtdv_d[l_ac].rtdv002
   
   #150213-00006#3 2015/02/13 By pomelo mark(S)
   #SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooef001 = g_site  
   #SELECT oodb006 INTO l_rtdv007 FROM oodb_t 
   # WHERE oodb002 =  l_rtdv006 AND oodb001 = g_rtdu_m.rtaa003  AND oodb004='1'
   #150213-00006#3 2015/02/13 By pomelo mark(E)
   #150213-00006#3 2015/02/13 By pomelo add(S)
   SELECT oodb005,oodb006 
     INTO l_rtdv030,l_rtdv007
     FROM oodb_t
    WHERE oodbent = g_enterprise 
      AND oodb001 = g_rtdu_m.rtdu011    
      AND oodb002 = l_rtdv006 
      AND oodb004 = '1'
   IF g_oodb011 = '1' THEN
      LET l_cnt = 0
      #進項稅別
      SELECT COUNT(rtdvseq) INTO l_cnt
        FROM rtdv_t
       WHERE rtdvent = g_enterprise
         AND rtdvseq = g_rtdv_d[l_ac].rtdvseq
         AND COALESCE(rtdv00006,'-1') = '-1'
      IF l_cnt = 0 THEN
         LET l_rtdv005 = l_rtdv007
      END IF
   END IF
   #150213-00006#3 2015/02/13 By pomelo add(E)
   UPDATE rtdv_t SET rtdv006=l_rtdv006,
                     rtdv007=l_rtdv007,
                     rtdv029=l_rtdv029,
                    #rtdv005 = l_rtdv005,               #150213-00006#3 2015/02/13 By pomelo add #150506-00017#1  sakura mark
                     rtdv030 = l_rtdv030,               #150213-00006#3 2015/02/13 By pomelo add
                    #rtdv021='Y'                        #150518-00051#1 2015/05/18 By lori mark
                     rtdv021=COALESCE(rtdv021,'N')      #150518-00051#1 2015/05/18 By lori add                   
    WHERE rtdvent=g_enterprise 
      AND rtdvdocno=g_rtdu_m.rtdudocno
      AND rtdvseq=g_rtdv_d[l_ac].rtdvseq
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success=false
      RETURN r_success   
   END IF 
   RETURN r_success  
END FUNCTION

################################################################################
# Descriptions...: 庫位說明
# Memo...........:
# Usage..........: CALL artt405_rtdw002_display()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/06/19 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdw002_display()
   LET g_rtdv2_d[l_ac].rtdw002_desc = s_desc_get_stock_desc(g_rtdv2_d[l_ac].rtdw001,g_rtdv2_d[l_ac].rtdw002)            
   DISPLAY BY NAME g_rtdv2_d[l_ac].rtdw002,g_rtdv2_d[l_ac].rtdw002_Desc  
END FUNCTION

################################################################################
# Descriptions...: 获得结算扣率
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150630 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdw039_init()
DEFINE l_merch        STRING
DEFINE l_sql          STRING 
DEFINE l_sql1         STRING 
DEFINE l_cost         LIKE stao_t.stao012
DEFINE l_stao012      LIKE stao_t.stao012
DEFINE l_stao022      LIKE stao_t.stao022
DEFINE l_stao002      LIKE stao_t.stao002
DEFINE l_stao003      LIKE stao_t.stao003
DEFINE  l_cnt       LIKE type_t.num5
   LET l_cost =''
   LET l_stao003 = cl_get_para(g_enterprise,g_rtdu_m.rtdusite,'E-CIR-0045')
   LET l_sql = "SELECT stao002 FROM stao_t WHERE staoent =",g_enterprise," AND stao001 = '",g_rtdu_m.rtdu002,"' AND stao003 = '",l_stao003,"'"
   PREPARE s_artt405_stao002_pre FROM l_sql
   DECLARE s_artt405_stao002_cs CURSOR FOR s_artt405_stao002_pre
   FOREACH s_artt405_stao002_cs INTO l_stao002
      SELECT stao012,stao022 INTO l_stao012,l_stao022 FROM stao_t WHERE staoent =g_enterprise AND stao001 = g_rtdu_m.rtdu002 AND stao002 = l_stao002
      #IF l_stao022 != 2 OR l_stao022 != 3 THEN
      IF l_stao022 != 2 AND l_stao022 != 3 THEN #20150701 By shi
         LET l_cost = l_stao012
         EXIT FOREACH
      ELSE   
         CALL s_expense_merch_sel(g_rtdu_m.rtdu002,l_stao002) RETURNING l_merch
         LET l_cnt = 0 
        #LET l_sql1 = "SELECT COUNT(*) INTO FROM imaa_t WHERE imaaent =",g_enterprise," AND imaa001 = '",g_rtdv_d[l_ac].rtdv001,"'",l_merch
         LET l_sql1 = "SELECT COUNT(*) FROM imaa_t WHERE imaaent =",g_enterprise," AND imaa001 = '",g_rtdv_d[l_ac].rtdv001,"' AND ",l_merch #20150701 By shi
         PREPARE s_artt405_imaa001_pre FROM l_sql1
         EXECUTE s_artt405_imaa001_pre INTO l_cnt 
         IF l_cnt > 0 THEN
            LET l_cost = l_stao012 
         ELSE
            CONTINUE FOREACH
         END IF
      END IF
   END FOREACH
   IF l_cost IS NULL THEN
      LET l_cost = 0
   END IF
   RETURN l_cost
END FUNCTION

################################################################################
# Descriptions...: 建立tmp table
# Memo...........: 
# Usage..........: CALL artt405_create_temp()
#                  RETURNING r_success
# Return code....: r_success     TRUE/FALSE
# Date & Author..: 2015/09/15 By sakura
# Modify.........: 
################################################################################
PRIVATE FUNCTION artt405_create_temp()
DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT artt405_drop_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE artt405_tmp
   (
      rtax001 VARCHAR(10)
   ) 
   
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create artt405_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除tmp table
# Memo...........:
# Usage..........: CALL artt405_drop_temp()
#                  RETURNING r_success
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/09/15 By sakura
# Modify.........: 
################################################################################
PRIVATE FUNCTION artt405_drop_temp()
DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE artt405_tmp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop artt405_drop_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 控制單頭欄位為必填
# Memo...........:
# Usage..........: artt405_set_required(p_cmd)
# Input parameter: p_cmd          單頭輸入狀態
# Return code....: 無
# Date & Author..: 2015-11-16 By Ken
################################################################################
PRIVATE FUNCTION artt405_set_required(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1 
   
   #151113-00003#1 Add By Ken 151116(S)    
   #採購中心皆為必填                  
   CALL cl_set_comp_required("rtdu005",TRUE)
   
   #採購方式2統採配送、3統採越庫的配送中心為必填
   IF g_rtdu_m.rtdu012 = '2' OR g_rtdu_m.rtdu012 = '3' THEN
      CALL cl_set_comp_required("rtdu007",TRUE)
   END IF 
   #151113-00003#1 Add By Ken 151116(E)
END FUNCTION

################################################################################
# Descriptions...: 控制單頭欄位為非必填
# Memo...........:
# Usage..........: artt405_set_no_required(p_cmd)
# Input parameter: p_cmd          單頭輸入狀態
# Return code....: 無
# Date & Author..: 2015-11-16 By Ken
################################################################################
PRIVATE FUNCTION artt405_set_no_required(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1 
   #151113-00003#1 Add By Ken 151116(S)
   CALL cl_set_comp_required("rtdu005",FALSE)
   CALL cl_set_comp_required("rtdu007",FALSE)
   #151113-00003#1 Add By Ken 151116(E)
END FUNCTION

################################################################################
# Descriptions...: 顯示合約編號相關欄位
# Memo...........:
# Usage..........: CALL artt405_rtdu002_display1(p_rtdu002)
# Input parameter: p_rtdu002      合約編號
# Return code....: 
# Date & Author..: 2015/11/27 By Ken  #151113-00003#10
# Modify.........:
################################################################################
PRIVATE FUNCTION artt405_rtdu002_display1(p_rtdu002)
DEFINE p_rtdu002  LIKE rtdu_t.rtdu002
DEFINE l_stan013  LIKE stan_t.stan013   
   
   LET l_stan013 = ''
   SELECT stan002,stan009,stan017,(CASE WHEN (stan031 IS NOT NULL) THEN stan031 ELSE stan018 END), #By shi Add 20150701
          stan006,stan007,stan013
     INTO g_rtdu_m.rtdu003,  g_rtdu_m.rtdu004,  g_rtdu_m.stan017,g_rtdu_m.stan018,
          g_rtdu_m.l_stan006,g_rtdu_m.l_stan007,l_stan013       
     FROM stan_t
    WHERE stanent = g_enterprise 
      AND stan001 = p_rtdu002    
  
   DISPLAY BY NAME  g_rtdu_m.rtdu003,g_rtdu_m.rtdu004,g_rtdu_m.stan017,g_rtdu_m.stan018,g_rtdu_m.l_stan006 #sakura add stan006  
  
   #採購中心說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtdu_m.rtdu005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtdu_m.rtdu005_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_rtdu_m.rtdu005_desc    
   
   #結算方式說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtdu_m.rtdu004
   CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtdu_m.rtdu004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtdu_m.rtdu004_desc
   
   #合約採購計價幣別說明
   CALL s_desc_get_currency_desc(g_rtdu_m.l_stan006) RETURNING g_rtdu_m.l_stan006_desc
   DISPLAY BY NAME g_rtdu_m.l_stan006_desc       
   
   #合約採購進項稅別說明
   IF cl_null(g_rtdu_m.rtdu011) THEN
      CALL s_desc_get_tax_desc1(l_stan013,g_rtdu_m.l_stan007) RETURNING g_rtdu_m.l_stan007_desc
   ELSE
      CALL s_desc_get_tax_desc(g_rtdu_m.rtdu011,g_rtdu_m.l_stan007) RETURNING g_rtdu_m.l_stan007_desc
   END IF
   DISPLAY BY NAME g_rtdu_m.l_stan007,g_rtdu_m.l_stan007_desc
   
   #供應商說明
   CALL s_desc_get_trading_partner_full_desc(g_rtdu_m.rtdu001)
      RETURNING g_rtdu_m.rtdu001_desc
   DISPLAY BY NAME g_rtdu_m.rtdu001_desc 
END FUNCTION

################################################################################
# Descriptions...: 控制单身欄位為非必填
# Memo...........:
# Usage..........: artt405_set_no_required_b(p_cmd)
# Input parameter: p_cmd          單頭輸入狀態
# Return code....: 無
# Date & Author..: 20160704 by geza
################################################################################
PRIVATE FUNCTION artt405_set_no_required_b(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1 
   CALL cl_set_comp_required("rtdv101",FALSE)
   CALL cl_set_comp_required("rtdv102",FALSE)
   CALL cl_set_comp_required("rtdv103",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 控制单身欄位為必填
# Memo...........:
# Usage..........: artt405_set_required_b(p_cmd)
# Input parameter: p_cmd          單頭輸入狀態
# Return code....: 無
# Date & Author..: 20160704 by geza
################################################################################
PRIVATE FUNCTION artt405_set_required_b(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1 
   #160604-00009#130 add by geza 20160704(S)
   #如果启用积分超市，引进的时候，单位积分给null，必输
   LET g_rtdv101_flag = cl_get_para(g_enterprise,g_rtdu_m.rtdusite,"S-CIR-2028")
   IF g_rtdv101_flag = 'Y' THEN
      CALL cl_set_comp_required("rtdv101",TRUE)
      CALL cl_set_comp_required("rtdv102",TRUE)
      CALL cl_set_comp_required("rtdv103",TRUE)
   END IF
   #160604-00009#130 add by geza 20160704(E)
END FUNCTION

 
{</section>}
 
