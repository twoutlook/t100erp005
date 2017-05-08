#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt601.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0023(2015-12-31 11:10:54), PR版次:0023(2017-02-20 14:22:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000116
#+ Filename...: aprt601
#+ Description: 採購補差單維護作業
#+ Creator....: 03247(2014-08-14 14:25:34)
#+ Modifier...: 03247 -SD/PR- 09042
 
{</section>}
 
{<section id="aprt601.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
# Modify......: NO.160318-00025#33   2016/04/13   By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160604-00009#92  2016/06/23  by 08172   新增参数判断是否抛转财务单据
#160705-00042#10  2016/07/13  By sakura  程式中寫死g_prog部分改寫MATCHES方式
#160809-00046#2   2016/08/11  by 08172   隐藏原进价栏位
#160816-00068#13  2016/08/22  By 08209   調整transaction
#160818-00017#32  2016/08/30  By 08742   删除修改未重新判断状态码
#161111-00028#2   2016/11/14  BY 02481   标准程式定义采用宣告模式,弃用.*写法
#160824-00007#157 2016/11/25  By 06814   新舊值處理
#170207-00018#7   2016/02/010 By 09042   ROWNUM批量调整
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
PRIVATE type type_g_prga_m        RECORD
       prgasite LIKE prga_t.prgasite, 
   prgasite_desc LIKE type_t.chr80, 
   prgadocdt LIKE prga_t.prgadocdt, 
   prgadocno LIKE prga_t.prgadocno, 
   prga002 LIKE prga_t.prga002, 
   prga003 LIKE prga_t.prga003, 
   prga004 LIKE prga_t.prga004, 
   prga006 LIKE prga_t.prga006, 
   prga006_desc LIKE type_t.chr80, 
   prga013 LIKE prga_t.prga013, 
   prga009 LIKE prga_t.prga009, 
   prga010 LIKE prga_t.prga010, 
   prga016 LIKE prga_t.prga016, 
   prgastus LIKE prga_t.prgastus, 
   prga011 LIKE prga_t.prga011, 
   prga011_desc LIKE type_t.chr80, 
   prga012 LIKE prga_t.prga012, 
   prga012_desc LIKE type_t.chr80, 
   prga001 LIKE prga_t.prga001, 
   prga007 LIKE prga_t.prga007, 
   prga007_desc LIKE type_t.chr80, 
   prga008 LIKE prga_t.prga008, 
   prga008_desc LIKE type_t.chr80, 
   prga005 LIKE prga_t.prga005, 
   prga014 LIKE type_t.num20_6, 
   total LIKE type_t.num20_6, 
   prga015 LIKE prga_t.prga015, 
   prga015_desc LIKE type_t.chr80, 
   prgaunit LIKE prga_t.prgaunit, 
   prgaownid LIKE prga_t.prgaownid, 
   prgaownid_desc LIKE type_t.chr80, 
   prgaowndp LIKE prga_t.prgaowndp, 
   prgaowndp_desc LIKE type_t.chr80, 
   prgacrtid LIKE prga_t.prgacrtid, 
   prgacrtid_desc LIKE type_t.chr80, 
   prgacrtdp LIKE prga_t.prgacrtdp, 
   prgacrtdp_desc LIKE type_t.chr80, 
   prgacrtdt LIKE prga_t.prgacrtdt, 
   prgamodid LIKE prga_t.prgamodid, 
   prgamodid_desc LIKE type_t.chr80, 
   prgamoddt LIKE prga_t.prgamoddt, 
   prgacnfid LIKE prga_t.prgacnfid, 
   prgacnfid_desc LIKE type_t.chr80, 
   prgacnfdt LIKE prga_t.prgacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prgb_d        RECORD
       prgbseq LIKE prgb_t.prgbseq, 
   prgb001 LIKE prgb_t.prgb001, 
   prgb002 LIKE prgb_t.prgb002, 
   prgbsite LIKE prgb_t.prgbsite, 
   prgbsite_desc LIKE type_t.chr500, 
   prgb003 LIKE prgb_t.prgb003, 
   prgb004 LIKE prgb_t.prgb004, 
   prgb005 LIKE prgb_t.prgb005, 
   prgb006 LIKE prgb_t.prgb006, 
   prgb007 LIKE prgb_t.prgb007, 
   prgb007_desc LIKE type_t.chr500, 
   prgb009 LIKE prgb_t.prgb009, 
   prgb008 LIKE prgb_t.prgb008, 
   prgb008_desc LIKE type_t.chr500, 
   prgb008_desc_desc LIKE type_t.chr500, 
   prgb010 LIKE prgb_t.prgb010, 
   prgb011 LIKE prgb_t.prgb011, 
   prgb012 LIKE prgb_t.prgb012, 
   prgb013 LIKE prgb_t.prgb013, 
   prgb013_desc LIKE type_t.chr500, 
   prgb014 LIKE prgb_t.prgb014, 
   prgb015 LIKE prgb_t.prgb015, 
   prgb016 LIKE prgb_t.prgb016, 
   prgb034 LIKE prgb_t.prgb034, 
   prgb017 LIKE prgb_t.prgb017, 
   prgb018 LIKE prgb_t.prgb018, 
   prgb035 LIKE type_t.num20_6, 
   prgb019 LIKE prgb_t.prgb019, 
   prgb020 LIKE prgb_t.prgb020, 
   prgb021 LIKE prgb_t.prgb021, 
   prgb022 LIKE prgb_t.prgb022, 
   prgb023 LIKE prgb_t.prgb023, 
   prgb024 LIKE prgb_t.prgb024, 
   prgb025 LIKE prgb_t.prgb025, 
   prgb026 LIKE prgb_t.prgb026, 
   prgb027 LIKE prgb_t.prgb027, 
   prgb028 LIKE prgb_t.prgb028, 
   prgb029 LIKE prgb_t.prgb029, 
   prgb030 LIKE prgb_t.prgb030, 
   prgb031 LIKE prgb_t.prgb031, 
   prgb032 LIKE prgb_t.prgb032, 
   prgb033 LIKE prgb_t.prgb033, 
   prgbunit LIKE prgb_t.prgbunit
       END RECORD
PRIVATE TYPE type_g_prgb2_d RECORD
       prgcsite LIKE type_t.chr10, 
   prgcunit LIKE type_t.chr10, 
   prgcseq LIKE type_t.num10, 
   prgcseq1 LIKE type_t.num10, 
   prgc001 LIKE type_t.chr10, 
   prgc012 LIKE prgc_t.prgc012, 
   prgc013 LIKE prgc_t.prgc013, 
   prgc014 LIKE prgc_t.prgc014, 
   prgc002 LIKE type_t.chr500, 
   prgc003 LIKE type_t.chr500, 
   prgc004 LIKE type_t.chr30, 
   prgc005 LIKE type_t.chr10, 
   prgc006 LIKE type_t.chr10, 
   prgc007 LIKE type_t.chr30, 
   prgc008 LIKE type_t.chr10, 
   prgc009 LIKE type_t.num20_6, 
   prgc010 LIKE type_t.num20_6, 
   prgc011 LIKE type_t.num20_6
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prgasite LIKE prga_t.prgasite,
   b_prgasite_desc LIKE type_t.chr80,
      b_prgadocdt LIKE prga_t.prgadocdt,
      b_prgadocno LIKE prga_t.prgadocno,
      b_prga001 LIKE prga_t.prga001,
      b_prga002 LIKE prga_t.prga002,
      b_prga003 LIKE prga_t.prga003,
      b_prga004 LIKE prga_t.prga004,
      b_prga005 LIKE prga_t.prga005,
      b_prga006 LIKE prga_t.prga006,
   b_prga006_desc LIKE type_t.chr80,
      b_prga007 LIKE prga_t.prga007,
   b_prga007_desc LIKE type_t.chr80,
      b_prga008 LIKE prga_t.prga008,
   b_prga008_desc LIKE type_t.chr80,
      b_prga009 LIKE prga_t.prga009,
      b_prga010 LIKE prga_t.prga010,
      b_prga011 LIKE prga_t.prga011,
   b_prga011_desc LIKE type_t.chr80,
      b_prga012 LIKE prga_t.prga012,
   b_prga012_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5
DEFINE g_prga001             LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prga_m          type_g_prga_m
DEFINE g_prga_m_t        type_g_prga_m
DEFINE g_prga_m_o        type_g_prga_m
DEFINE g_prga_m_mask_o   type_g_prga_m #轉換遮罩前資料
DEFINE g_prga_m_mask_n   type_g_prga_m #轉換遮罩後資料
 
   DEFINE g_prgadocno_t LIKE prga_t.prgadocno
 
 
DEFINE g_prgb_d          DYNAMIC ARRAY OF type_g_prgb_d
DEFINE g_prgb_d_t        type_g_prgb_d
DEFINE g_prgb_d_o        type_g_prgb_d
DEFINE g_prgb_d_mask_o   DYNAMIC ARRAY OF type_g_prgb_d #轉換遮罩前資料
DEFINE g_prgb_d_mask_n   DYNAMIC ARRAY OF type_g_prgb_d #轉換遮罩後資料
DEFINE g_prgb2_d          DYNAMIC ARRAY OF type_g_prgb2_d
DEFINE g_prgb2_d_t        type_g_prgb2_d
DEFINE g_prgb2_d_o        type_g_prgb2_d
DEFINE g_prgb2_d_mask_o   DYNAMIC ARRAY OF type_g_prgb2_d #轉換遮罩前資料
DEFINE g_prgb2_d_mask_n   DYNAMIC ARRAY OF type_g_prgb2_d #轉換遮罩後資料
 
 
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
#argv[1]   type_t.chr10        #作業類型 
#argv[2]   prga_t.prgadocno    #單號
#end add-point
 
{</section>}
 
{<section id="aprt601.main" >}
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
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT prgasite,'',prgadocdt,prgadocno,prga002,prga003,prga004,prga006,'',prga013, 
       prga009,prga010,prga016,prgastus,prga011,'',prga012,'',prga001,prga007,'',prga008,'',prga005, 
       '','',prga015,'',prgaunit,prgaownid,'',prgaowndp,'',prgacrtid,'',prgacrtdp,'',prgacrtdt,prgamodid, 
       '',prgamoddt,prgacnfid,'',prgacnfdt", 
                      " FROM prga_t",
                      " WHERE prgaent= ? AND prgadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt601_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prgasite,t0.prgadocdt,t0.prgadocno,t0.prga002,t0.prga003,t0.prga004, 
       t0.prga006,t0.prga013,t0.prga009,t0.prga010,t0.prga016,t0.prgastus,t0.prga011,t0.prga012,t0.prga001, 
       t0.prga007,t0.prga008,t0.prga005,t0.prga014,t0.prga015,t0.prgaunit,t0.prgaownid,t0.prgaowndp, 
       t0.prgacrtid,t0.prgacrtdp,t0.prgacrtdt,t0.prgamodid,t0.prgamoddt,t0.prgacnfid,t0.prgacnfdt,t1.ooefl003 , 
       t2.pmaal004 ,t3.ooail003 ,t4.ooag011 ,t5.ooefl003 ,t6.rtaxl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 , 
       t10.ooefl003 ,t11.ooag011 ,t12.ooag011",
               " FROM prga_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prgasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.prga006 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.prga011 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prga007  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prga008 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t6 ON t6.rtaxlent="||g_enterprise||" AND t6.rtaxl001=t0.prga015 AND t6.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.prgaownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.prgaowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.prgacrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.prgacrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.prgamodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.prgacnfid  ",
 
               " WHERE t0.prgaent = " ||g_enterprise|| " AND t0.prgadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt601_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt601 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt601_init()   
 
      #進入選單 Menu (="N")
      CALL aprt601_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt601
      
   END IF 
   
   CLOSE aprt601_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt601.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt601_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add
   DEFINE l_msg     LIKE type_t.chr50     #add by yangxf
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
      CALL cl_set_combo_scc_part('prgastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('prga002','6092') 
   CALL cl_set_combo_scc('prga013','6792') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   CALL cl_set_combo_scc_part('prga002','6092','1,3')  #151013-00001#48 20160108 by yangxf 
   CALL cl_set_combo_scc('prga005','2014')
   CALL cl_set_combo_scc('b_prga001','6730') 
   CALL cl_set_combo_scc('b_prga002','6092')
   CALL cl_set_combo_scc('prgc001','6730') 
#add by yangxf ---start---
   CASE 
       #WHEN g_prog = 'aprt601'        #160705-00042#10 160713 by sakura mark
       WHEN g_prog MATCHES 'aprt601'   #160705-00042#10 160713 by sakura add
            CALL cl_set_combo_scc_part('prga013','6792','1,2')
            CALL cl_set_comp_visible("prgb034,lbl_prga015,prga015",FALSE)
       #WHEN g_prog = 'aprt602'
       WHEN g_prog = 'aprt602'
            CALL cl_set_combo_scc_part('prga013','6792','1,2')
            CALL cl_set_comp_visible("lbl_prga015,prga015",TRUE)
            CALL cl_set_comp_visible("prgb034,prgc012,prgc013,prgc014",FALSE)
       #WHEN g_prog = 'aprt603'        #160705-00042#10 160713 by sakura mark
       WHEN g_prog MATCHES 'aprt603'   #160705-00042#10 160713 by sakura add
            #原进价-->成本价  
            CALL cl_getmsg('apr-00374',g_lang) RETURNING l_msg
            CALL cl_set_comp_att_text("prgb015",l_msg CLIPPED)
            #本次进价-->本次售价
            CALL cl_getmsg('apr-00375',g_lang) RETURNING l_msg
            CALL cl_set_comp_att_text("prgb016",l_msg CLIPPED)
            #CALL cl_set_combo_scc_part('prga013','6792','1,3,4')   #151013-00001#43 dongsz mark
            CALL cl_set_combo_scc_part('prga013','6792','1,2,3,4')   #151013-00001#43 dongsz add
            CALL cl_set_comp_visible("prgb015,prgb034",TRUE)
            CALL cl_set_comp_visible("lbl_prga015,prga015",FALSE)
       #WHEN g_prog = 'aprt701'        #160705-00042#10 160713 by sakura mark
       WHEN g_prog MATCHES 'aprt701'   #160705-00042#10 160713 by sakura add
            #原进价-->原售价
            CALL cl_getmsg('apr-00376',g_lang) RETURNING l_msg
            CALL cl_set_comp_att_text("prgb015",l_msg CLIPPED)
            #本次进价-->本次售价
            CALL cl_getmsg('apr-00375',g_lang) RETURNING l_msg
            CALL cl_set_comp_att_text("prgb016",l_msg CLIPPED)
            CALL cl_set_combo_scc_part('prga013','6792','1,2')
            CALL cl_set_comp_visible("page_3,prgb034",FALSE)
            CALL cl_set_comp_visible("prgb007,prgb007_desc",TRUE)
            CALL cl_set_comp_visible("lbl_prga015,prga015",FALSE)
   END CASE 
#add by yangxf ---end---
   #add by guomy 2015/12/31-----aprt603--EXCEL导入---(S)
   #IF g_prog != 'aprt603'  THEN           #160705-00042#10 160713 by sakura mark   
   IF g_prog NOT MATCHES 'aprt603'  THEN   #160705-00042#10 160713 by sakura add
      CALL cl_set_act_visible_toolbaritem("importfromexcel", FALSE)
      CALL cl_set_act_visible_toolbaritem("downloadtemplet", FALSE)
      CALL cl_set_act_visible_toolbaritem("uploadtemplet", FALSE)
   END IF
   #add by guomy 2015/12/31-----aprt603--EXCEL导入---(E)
   #end add-point
   
   #初始化搜尋條件
   CALL aprt601_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt601.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt601_ui_dialog()
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
            CALL aprt601_insert()
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
         INITIALIZE g_prga_m.* TO NULL
         CALL g_prgb_d.clear()
         CALL g_prgb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt601_init()
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
               
               CALL aprt601_fetch('') # reload data
               LET l_ac = 1
               CALL aprt601_ui_detailshow() #Setting the current row 
         
               CALL aprt601_idx_chk()
               #NEXT FIELD prgbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prgb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt601_idx_chk()
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
               CALL aprt601_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_prgb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt601_idx_chk()
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
               CALL aprt601_idx_chk()
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
            CALL aprt601_browser_fill("")
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
               CALL aprt601_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt601_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt601_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt601_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt601_set_act_visible()   
            CALL aprt601_set_act_no_visible()
            IF NOT (g_prga_m.prgadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prgaent = " ||g_enterprise|| " AND",
                                  " prgadocno = '", g_prga_m.prgadocno, "' "
 
               #填到對應位置
               CALL aprt601_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "prga_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prgb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prgc_t" 
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
               CALL aprt601_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "prga_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prgb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prgc_t" 
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
                  CALL aprt601_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt601_fetch("F")
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
               CALL aprt601_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt601_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt601_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt601_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt601_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt601_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt601_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt601_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt601_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt601_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt601_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prgb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_prgb2_d)
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
               NEXT FIELD prgbseq
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
               CALL aprt601_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt601_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION downloadtemplet
            LET g_action_choice="downloadtemplet"
            IF cl_auth_chk_act("downloadtemplet") THEN
               
               #add-point:ON ACTION downloadtemplet name="menu.downloadtemplet"
               CALL s_excel_templet_download()  #add by guomy 2015/12/31 下载模板
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt601_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt601_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apr/aprt601_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apr/aprt601_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION remarks
            LET g_action_choice="remarks"
            IF cl_auth_chk_act("remarks") THEN
               
               #add-point:ON ACTION remarks name="menu.remarks"
               CALL aooi360_01('6',g_prga_m.prgadocno,'','','','','','','','','')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION importfromexcel
            LET g_action_choice="importfromexcel"
            IF cl_auth_chk_act("importfromexcel") THEN
               
               #add-point:ON ACTION importfromexcel name="menu.importfromexcel"
               CALL s_aprt603_excel(g_prga_m.prgadocno)  #add by guomy 2015/12/31 EXCEL导入
               CALL aprt601_b_fill()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt601_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION uploadtemplet
            LET g_action_choice="uploadtemplet"
            IF cl_auth_chk_act("uploadtemplet") THEN
               
               #add-point:ON ACTION uploadtemplet name="menu.uploadtemplet"
               CALL s_excel_templet_upload()  #add by guomy 2015/12/31 增加上传模板
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt601_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt601_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt601_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prga_m.prgadocdt)
 
 
 
         
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
 
{<section id="aprt601.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt601_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ooef019         LIKE ooef_t.ooef019
   DEFINE l_where           STRING
   DEFINE l_prga001         LIKE prga_t.prga001    #add by yangxf
   
   LET l_prga001 = g_argv[1] #160120-00026# s983961--add
   #add by yangxf ---start---   
   #1.采购补差 2.库存补差 3.销售补差 21.销售补差
   CASE 
      #WHEN g_prog = 'aprt601'        #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt601'   #160705-00042#10 160713 by sakura add
           LET l_prga001 = '1'
      #WHEN g_prog = 'aprt602'        #160705-00042#10 160713 by sakura mark  
      WHEN g_prog MATCHES 'aprt602'   #160705-00042#10 160713 by sakura add
           LET l_prga001 = '2'
      #WHEN g_prog = 'aprt603'        #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt603'   #160705-00042#10 160713 by sakura add
           LET l_prga001 = '3'
      #WHEN g_prog = 'aprt701'        #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt701'   #160705-00042#10 160713 by sakura add
           LET l_prga001 = '21'
   END CASE 
   #add by yangxf ---end------
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
   CALL s_aooi500_sql_where(g_prog,'prgasite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT prgadocno ",
                      " FROM prga_t ",
                      " ",
                      " LEFT JOIN prgb_t ON prgbent = prgaent AND prgadocno = prgbdocno ", "  ",
                      #add-point:browser_fill段sql(prgb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN prgc_t ON prgcent = prgaent AND prgadocno = prgcdocno", "  ",
                      #add-point:browser_fill段sql(prgc_t1) name="browser_fill.cnt.join.prgc_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE prgaent = " ||g_enterprise|| " AND prgbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prga_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prgadocno ",
                      " FROM prga_t ", 
                      "  ",
                      "  ",
                      " WHERE prgaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prga_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
#   LET l_sub_sql = l_sub_sql," AND prga001 = '1' "                  #mark by yangxf 
   LET l_sub_sql = l_sub_sql," AND prga001 = '",l_prga001,"' "       #add by yangxf
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
      INITIALIZE g_prga_m.* TO NULL
      CALL g_prgb_d.clear()        
      CALL g_prgb2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prgasite,t0.prgadocdt,t0.prgadocno,t0.prga001,t0.prga002,t0.prga003,t0.prga004,t0.prga005,t0.prga006,t0.prga007,t0.prga008,t0.prga009,t0.prga010,t0.prga011,t0.prga012 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prgastus,t0.prgasite,t0.prgadocdt,t0.prgadocno,t0.prga001,t0.prga002, 
          t0.prga003,t0.prga004,t0.prga005,t0.prga006,t0.prga007,t0.prga008,t0.prga009,t0.prga010,t0.prga011, 
          t0.prga012,t1.ooefl003 ,t2.pmaal004 ,t3.ooag011 ,t4.ooefl003 ,t5.ooail003 ",
                  " FROM prga_t t0",
                  "  ",
                  "  LEFT JOIN prgb_t ON prgbent = prgaent AND prgadocno = prgbdocno ", "  ", 
                  #add-point:browser_fill段sql(prgb_t1) name="browser_fill.join.prgb_t1"
                  
                  #end add-point
                  "  LEFT JOIN prgc_t ON prgcent = prgaent AND prgadocno = prgcdocno", "  ", 
                  #add-point:browser_fill段sql(prgc_t1) name="browser_fill.join.prgc_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prgasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.prga006 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.prga007  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.prga008 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t5 ON t5.ooailent="||g_enterprise||" AND t5.ooail001=t0.prga011 AND t5.ooail002='"||g_dlang||"' ",
 
                  " WHERE t0.prgaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prga_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prgastus,t0.prgasite,t0.prgadocdt,t0.prgadocno,t0.prga001,t0.prga002, 
          t0.prga003,t0.prga004,t0.prga005,t0.prga006,t0.prga007,t0.prga008,t0.prga009,t0.prga010,t0.prga011, 
          t0.prga012,t1.ooefl003 ,t2.pmaal004 ,t3.ooag011 ,t4.ooefl003 ,t5.ooail003 ",
                  " FROM prga_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prgasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.prga006 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.prga007  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.prga008 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t5 ON t5.ooailent="||g_enterprise||" AND t5.ooail001=t0.prga011 AND t5.ooail002='"||g_dlang||"' ",
 
                  " WHERE t0.prgaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prga_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
#               ,"   AND prga001 = '1' "               #mark by yangxf
#               ,"   AND prga001 = '",l_prga001,"' "    #add by yangxf #mark by geza 20160122
   LET g_sql = g_sql,"   AND prga001 = '",l_prga001,"' " #add by geza 20160122
   #end add-point
   LET g_sql = g_sql, " ORDER BY prgadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prga_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prgasite,g_browser[g_cnt].b_prgadocdt, 
          g_browser[g_cnt].b_prgadocno,g_browser[g_cnt].b_prga001,g_browser[g_cnt].b_prga002,g_browser[g_cnt].b_prga003, 
          g_browser[g_cnt].b_prga004,g_browser[g_cnt].b_prga005,g_browser[g_cnt].b_prga006,g_browser[g_cnt].b_prga007, 
          g_browser[g_cnt].b_prga008,g_browser[g_cnt].b_prga009,g_browser[g_cnt].b_prga010,g_browser[g_cnt].b_prga011, 
          g_browser[g_cnt].b_prga012,g_browser[g_cnt].b_prgasite_desc,g_browser[g_cnt].b_prga006_desc, 
          g_browser[g_cnt].b_prga007_desc,g_browser[g_cnt].b_prga008_desc,g_browser[g_cnt].b_prga011_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      SELECT ooef019 INTO l_ooef019 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_browser[g_cnt].b_prgasite          
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_ooef019
      LET g_ref_fields[2] = g_browser[g_cnt].b_prga012
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_prga012_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_prga012_desc
         #end add-point
      
         #遮罩相關處理
         CALL aprt601_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
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
   
   IF cl_null(g_browser[g_cnt].b_prgadocno) THEN
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
 
{<section id="aprt601.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt601_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prga_m.prgadocno = g_browser[g_current_idx].b_prgadocno   
 
   EXECUTE aprt601_master_referesh USING g_prga_m.prgadocno INTO g_prga_m.prgasite,g_prga_m.prgadocdt, 
       g_prga_m.prgadocno,g_prga_m.prga002,g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013, 
       g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga012, 
       g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.prga015, 
       g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaowndp,g_prga_m.prgacrtid,g_prga_m.prgacrtdp, 
       g_prga_m.prgacrtdt,g_prga_m.prgamodid,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfdt, 
       g_prga_m.prgasite_desc,g_prga_m.prga006_desc,g_prga_m.prga011_desc,g_prga_m.prga007_desc,g_prga_m.prga008_desc, 
       g_prga_m.prga015_desc,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp_desc,g_prga_m.prgacrtid_desc, 
       g_prga_m.prgacrtdp_desc,g_prga_m.prgamodid_desc,g_prga_m.prgacnfid_desc
   
   CALL aprt601_prga_t_mask()
   CALL aprt601_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt601.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt601_ui_detailshow()
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
 
{<section id="aprt601.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt601_ui_browser_refresh()
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
      IF g_browser[l_i].b_prgadocno = g_prga_m.prgadocno 
 
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
 
{<section id="aprt601.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt601_construct()
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
   DEFINE l_sys       LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_prga_m.* TO NULL
   CALL g_prgb_d.clear()        
   CALL g_prgb2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON prgasite,prgadocdt,prgadocno,prga002,prga003,prga004,prga006,prga013, 
          prga009,prga010,prga016,prgastus,prga011,prga012,prga012_desc,prga001,prga007,prga008,prga005, 
          prga014,total,prga015,prgaunit,prgaownid,prgaowndp,prgacrtid,prgacrtdp,prgacrtdt,prgamodid, 
          prgamoddt,prgacnfid,prgacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prgacrtdt>>----
         AFTER FIELD prgacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prgamoddt>>----
         AFTER FIELD prgamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prgacnfdt>>----
         AFTER FIELD prgacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prgapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.prgasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgasite
            #add-point:ON ACTION controlp INFIELD prgasite name="construct.c.prgasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " ooef201 = 'Y' "
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prgasite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prgasite  #顯示到畫面上
            NEXT FIELD prgasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgasite
            #add-point:BEFORE FIELD prgasite name="construct.b.prgasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgasite
            
            #add-point:AFTER FIELD prgasite name="construct.a.prgasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgadocdt
            #add-point:BEFORE FIELD prgadocdt name="construct.b.prgadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgadocdt
            
            #add-point:AFTER FIELD prgadocdt name="construct.a.prgadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prgadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgadocdt
            #add-point:ON ACTION controlp INFIELD prgadocdt name="construct.c.prgadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prgadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgadocno
            #add-point:ON ACTION controlp INFIELD prgadocno name="construct.c.prgadocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_prgadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgadocno  #顯示到畫面上
            NEXT FIELD prgadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgadocno
            #add-point:BEFORE FIELD prgadocno name="construct.b.prgadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgadocno
            
            #add-point:AFTER FIELD prgadocno name="construct.a.prgadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga002
            #add-point:BEFORE FIELD prga002 name="construct.b.prga002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga002
            
            #add-point:AFTER FIELD prga002 name="construct.a.prga002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga002
            #add-point:ON ACTION controlp INFIELD prga002 name="construct.c.prga002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prga003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga003
            #add-point:ON ACTION controlp INFIELD prga003 name="construct.c.prga003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = '1'   #mark by yangxf
            #add by yangxf ----start----
            CASE 
               #WHEN g_prog = 'aprt601'        #160705-00042#10 160713 by sakura mark
               WHEN g_prog MATCHES 'aprt601'   #160705-00042#10 160713 by sakura add
                    LET g_qryparam.arg1 = '1'
               #WHEN g_prog = 'aprt602'        #160705-00042#10 160713 by sakura mark
               WHEN g_prog MATCHES 'aprt602'   #160705-00042#10 160713 by sakura add   
                    LET g_qryparam.arg1 = '2'
               #WHEN g_prog = 'aprt603'        #160705-00042#10 160713 by sakura mark  
               WHEN g_prog MATCHES 'aprt603'   #160705-00042#10 160713 by sakura add
                    LET g_qryparam.arg1 = '3'
               #WHEN g_prog = 'aprt701'        #160705-00042#10 160713 by sakura mark 
               WHEN g_prog MATCHES 'aprt701'   #160705-00042#10 160713 by sakura add
                    LET g_qryparam.arg1 = '21'
            END CASE
            #add by yangxf -----end-----
            CALL q_prga003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prga003  #顯示到畫面上
            NEXT FIELD prga003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga003
            #add-point:BEFORE FIELD prga003 name="construct.b.prga003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga003
            
            #add-point:AFTER FIELD prga003 name="construct.a.prga003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga004
            #add-point:ON ACTION controlp INFIELD prga004 name="construct.c.prga004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #add by yangxf ---start---
            #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark 
            IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
               CALL q_stce001_6()
            ELSE
               CALL q_stan001_2()                           #呼叫開窗
            END IF   #add by yangxf 
            DISPLAY g_qryparam.return1 TO prga004  #顯示到畫面上
            NEXT FIELD prga004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga004
            #add-point:BEFORE FIELD prga004 name="construct.b.prga004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga004
            
            #add-point:AFTER FIELD prga004 name="construct.a.prga004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga006
            #add-point:ON ACTION controlp INFIELD prga006 name="construct.c.prga006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prga006  #顯示到畫面上
            NEXT FIELD prga006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga006
            #add-point:BEFORE FIELD prga006 name="construct.b.prga006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga006
            
            #add-point:AFTER FIELD prga006 name="construct.a.prga006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga013
            #add-point:BEFORE FIELD prga013 name="construct.b.prga013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga013
            
            #add-point:AFTER FIELD prga013 name="construct.a.prga013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga013
            #add-point:ON ACTION controlp INFIELD prga013 name="construct.c.prga013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga009
            #add-point:BEFORE FIELD prga009 name="construct.b.prga009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga009
            
            #add-point:AFTER FIELD prga009 name="construct.a.prga009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga009
            #add-point:ON ACTION controlp INFIELD prga009 name="construct.c.prga009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga010
            #add-point:BEFORE FIELD prga010 name="construct.b.prga010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga010
            
            #add-point:AFTER FIELD prga010 name="construct.a.prga010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga010
            #add-point:ON ACTION controlp INFIELD prga010 name="construct.c.prga010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga016
            #add-point:BEFORE FIELD prga016 name="construct.b.prga016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga016
            
            #add-point:AFTER FIELD prga016 name="construct.a.prga016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga016
            #add-point:ON ACTION controlp INFIELD prga016 name="construct.c.prga016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgastus
            #add-point:BEFORE FIELD prgastus name="construct.b.prgastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgastus
            
            #add-point:AFTER FIELD prgastus name="construct.a.prgastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prgastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgastus
            #add-point:ON ACTION controlp INFIELD prgastus name="construct.c.prgastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prga011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga011
            #add-point:ON ACTION controlp INFIELD prga011 name="construct.c.prga011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prga011  #顯示到畫面上
            NEXT FIELD prga011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga011
            #add-point:BEFORE FIELD prga011 name="construct.b.prga011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga011
            
            #add-point:AFTER FIELD prga011 name="construct.a.prga011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga012
            #add-point:ON ACTION controlp INFIELD prga012 name="construct.c.prga012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prga012  #顯示到畫面上
            NEXT FIELD prga012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga012
            #add-point:BEFORE FIELD prga012 name="construct.b.prga012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga012
            
            #add-point:AFTER FIELD prga012 name="construct.a.prga012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga012_desc
            #add-point:BEFORE FIELD prga012_desc name="construct.b.prga012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga012_desc
            
            #add-point:AFTER FIELD prga012_desc name="construct.a.prga012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga012_desc
            #add-point:ON ACTION controlp INFIELD prga012_desc name="construct.c.prga012_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga001
            #add-point:BEFORE FIELD prga001 name="construct.b.prga001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga001
            
            #add-point:AFTER FIELD prga001 name="construct.a.prga001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga001
            #add-point:ON ACTION controlp INFIELD prga001 name="construct.c.prga001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prga007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga007
            #add-point:ON ACTION controlp INFIELD prga007 name="construct.c.prga007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prga007  #顯示到畫面上
            NEXT FIELD prga007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga007
            #add-point:BEFORE FIELD prga007 name="construct.b.prga007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga007
            
            #add-point:AFTER FIELD prga007 name="construct.a.prga007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga008
            #add-point:ON ACTION controlp INFIELD prga008 name="construct.c.prga008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prga008  #顯示到畫面上
            NEXT FIELD prga008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga008
            #add-point:BEFORE FIELD prga008 name="construct.b.prga008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga008
            
            #add-point:AFTER FIELD prga008 name="construct.a.prga008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga005
            #add-point:BEFORE FIELD prga005 name="construct.b.prga005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga005
            
            #add-point:AFTER FIELD prga005 name="construct.a.prga005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga005
            #add-point:ON ACTION controlp INFIELD prga005 name="construct.c.prga005"


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga014
            #add-point:BEFORE FIELD prga014 name="construct.b.prga014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga014
            
            #add-point:AFTER FIELD prga014 name="construct.a.prga014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga014
            #add-point:ON ACTION controlp INFIELD prga014 name="construct.c.prga014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD total
            #add-point:BEFORE FIELD total name="construct.b.total"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD total
            
            #add-point:AFTER FIELD total name="construct.a.total"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.total
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD total
            #add-point:ON ACTION controlp INFIELD total name="construct.c.total"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga015
            #add-point:BEFORE FIELD prga015 name="construct.b.prga015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga015
            
            #add-point:AFTER FIELD prga015 name="construct.a.prga015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prga015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga015
            #add-point:ON ACTION controlp INFIELD prga015 name="construct.c.prga015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #取得品類管理層級
            CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
            LET g_qryparam.arg1 = l_sys
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prga015  #顯示到畫面上
            NEXT FIELD prga015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgaunit
            #add-point:BEFORE FIELD prgaunit name="construct.b.prgaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgaunit
            
            #add-point:AFTER FIELD prgaunit name="construct.a.prgaunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prgaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgaunit
            #add-point:ON ACTION controlp INFIELD prgaunit name="construct.c.prgaunit"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prgaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgaownid
            #add-point:ON ACTION controlp INFIELD prgaownid name="construct.c.prgaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgaownid  #顯示到畫面上
            NEXT FIELD prgaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgaownid
            #add-point:BEFORE FIELD prgaownid name="construct.b.prgaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgaownid
            
            #add-point:AFTER FIELD prgaownid name="construct.a.prgaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prgaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgaowndp
            #add-point:ON ACTION controlp INFIELD prgaowndp name="construct.c.prgaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgaowndp  #顯示到畫面上
            NEXT FIELD prgaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgaowndp
            #add-point:BEFORE FIELD prgaowndp name="construct.b.prgaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgaowndp
            
            #add-point:AFTER FIELD prgaowndp name="construct.a.prgaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prgacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgacrtid
            #add-point:ON ACTION controlp INFIELD prgacrtid name="construct.c.prgacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgacrtid  #顯示到畫面上
            NEXT FIELD prgacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgacrtid
            #add-point:BEFORE FIELD prgacrtid name="construct.b.prgacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgacrtid
            
            #add-point:AFTER FIELD prgacrtid name="construct.a.prgacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prgacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgacrtdp
            #add-point:ON ACTION controlp INFIELD prgacrtdp name="construct.c.prgacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgacrtdp  #顯示到畫面上
            NEXT FIELD prgacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgacrtdp
            #add-point:BEFORE FIELD prgacrtdp name="construct.b.prgacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgacrtdp
            
            #add-point:AFTER FIELD prgacrtdp name="construct.a.prgacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgacrtdt
            #add-point:BEFORE FIELD prgacrtdt name="construct.b.prgacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prgamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgamodid
            #add-point:ON ACTION controlp INFIELD prgamodid name="construct.c.prgamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgamodid  #顯示到畫面上
            NEXT FIELD prgamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgamodid
            #add-point:BEFORE FIELD prgamodid name="construct.b.prgamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgamodid
            
            #add-point:AFTER FIELD prgamodid name="construct.a.prgamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgamoddt
            #add-point:BEFORE FIELD prgamoddt name="construct.b.prgamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prgacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgacnfid
            #add-point:ON ACTION controlp INFIELD prgacnfid name="construct.c.prgacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgacnfid  #顯示到畫面上
            NEXT FIELD prgacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgacnfid
            #add-point:BEFORE FIELD prgacnfid name="construct.b.prgacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgacnfid
            
            #add-point:AFTER FIELD prgacnfid name="construct.a.prgacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgacnfdt
            #add-point:BEFORE FIELD prgacnfdt name="construct.b.prgacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prgbseq,prgb001,prgb002,prgbsite,prgb003,prgb004,prgb005,prgb006,prgb007, 
          prgb009,prgb008,prgb010,prgb011,prgb012,prgb013,prgb014,prgb015,prgb016,prgb034,prgb017,prgb018, 
          prgb035,prgb019,prgb020,prgb021,prgb022,prgb023,prgb024,prgb025,prgb026,prgb027,prgb028,prgb029, 
          prgb030,prgb031,prgb032,prgb033,prgbunit
           FROM s_detail1[1].prgbseq,s_detail1[1].prgb001,s_detail1[1].prgb002,s_detail1[1].prgbsite, 
               s_detail1[1].prgb003,s_detail1[1].prgb004,s_detail1[1].prgb005,s_detail1[1].prgb006,s_detail1[1].prgb007, 
               s_detail1[1].prgb009,s_detail1[1].prgb008,s_detail1[1].prgb010,s_detail1[1].prgb011,s_detail1[1].prgb012, 
               s_detail1[1].prgb013,s_detail1[1].prgb014,s_detail1[1].prgb015,s_detail1[1].prgb016,s_detail1[1].prgb034, 
               s_detail1[1].prgb017,s_detail1[1].prgb018,s_detail1[1].prgb035,s_detail1[1].prgb019,s_detail1[1].prgb020, 
               s_detail1[1].prgb021,s_detail1[1].prgb022,s_detail1[1].prgb023,s_detail1[1].prgb024,s_detail1[1].prgb025, 
               s_detail1[1].prgb026,s_detail1[1].prgb027,s_detail1[1].prgb028,s_detail1[1].prgb029,s_detail1[1].prgb030, 
               s_detail1[1].prgb031,s_detail1[1].prgb032,s_detail1[1].prgb033,s_detail1[1].prgbunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgbseq
            #add-point:BEFORE FIELD prgbseq name="construct.b.page1.prgbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgbseq
            
            #add-point:AFTER FIELD prgbseq name="construct.a.page1.prgbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgbseq
            #add-point:ON ACTION controlp INFIELD prgbseq name="construct.c.page1.prgbseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb001
            #add-point:BEFORE FIELD prgb001 name="construct.b.page1.prgb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb001
            
            #add-point:AFTER FIELD prgb001 name="construct.a.page1.prgb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb001
            #add-point:ON ACTION controlp INFIELD prgb001 name="construct.c.page1.prgb001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb002
            #add-point:BEFORE FIELD prgb002 name="construct.b.page1.prgb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb002
            
            #add-point:AFTER FIELD prgb002 name="construct.a.page1.prgb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb002
            #add-point:ON ACTION controlp INFIELD prgb002 name="construct.c.page1.prgb002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prgbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgbsite
            #add-point:ON ACTION controlp INFIELD prgbsite name="construct.c.page1.prgbsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = "8"
#            CALL q_ooed004_3()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prgbsite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prgbsite  #顯示到畫面上
            NEXT FIELD prgbsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgbsite
            #add-point:BEFORE FIELD prgbsite name="construct.b.page1.prgbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgbsite
            
            #add-point:AFTER FIELD prgbsite name="construct.a.page1.prgbsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb003
            #add-point:BEFORE FIELD prgb003 name="construct.b.page1.prgb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb003
            
            #add-point:AFTER FIELD prgb003 name="construct.a.page1.prgb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb003
            #add-point:ON ACTION controlp INFIELD prgb003 name="construct.c.page1.prgb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb004
            #add-point:BEFORE FIELD prgb004 name="construct.b.page1.prgb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb004
            
            #add-point:AFTER FIELD prgb004 name="construct.a.page1.prgb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb004
            #add-point:ON ACTION controlp INFIELD prgb004 name="construct.c.page1.prgb004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb005
            #add-point:BEFORE FIELD prgb005 name="construct.b.page1.prgb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb005
            
            #add-point:AFTER FIELD prgb005 name="construct.a.page1.prgb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb005
            #add-point:ON ACTION controlp INFIELD prgb005 name="construct.c.page1.prgb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb006
            #add-point:BEFORE FIELD prgb006 name="construct.b.page1.prgb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb006
            
            #add-point:AFTER FIELD prgb006 name="construct.a.page1.prgb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb006
            #add-point:ON ACTION controlp INFIELD prgb006 name="construct.c.page1.prgb006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prgb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb007
            #add-point:ON ACTION controlp INFIELD prgb007 name="construct.c.page1.prgb007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_18()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgb007  #顯示到畫面上
            NEXT FIELD prgb007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb007
            #add-point:BEFORE FIELD prgb007 name="construct.b.page1.prgb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb007
            
            #add-point:AFTER FIELD prgb007 name="construct.a.page1.prgb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb009
            #add-point:ON ACTION controlp INFIELD prgb009 name="construct.c.page1.prgb009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgb009  #顯示到畫面上
            NEXT FIELD prgb009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb009
            #add-point:BEFORE FIELD prgb009 name="construct.b.page1.prgb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb009
            
            #add-point:AFTER FIELD prgb009 name="construct.a.page1.prgb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb008
            #add-point:ON ACTION controlp INFIELD prgb008 name="construct.c.page1.prgb008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgb008  #顯示到畫面上
            NEXT FIELD prgb008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb008
            #add-point:BEFORE FIELD prgb008 name="construct.b.page1.prgb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb008
            
            #add-point:AFTER FIELD prgb008 name="construct.a.page1.prgb008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb010
            #add-point:BEFORE FIELD prgb010 name="construct.b.page1.prgb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb010
            
            #add-point:AFTER FIELD prgb010 name="construct.a.page1.prgb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb010
            #add-point:ON ACTION controlp INFIELD prgb010 name="construct.c.page1.prgb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb011
            #add-point:BEFORE FIELD prgb011 name="construct.b.page1.prgb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb011
            
            #add-point:AFTER FIELD prgb011 name="construct.a.page1.prgb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb011
            #add-point:ON ACTION controlp INFIELD prgb011 name="construct.c.page1.prgb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb012
            #add-point:BEFORE FIELD prgb012 name="construct.b.page1.prgb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb012
            
            #add-point:AFTER FIELD prgb012 name="construct.a.page1.prgb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb012
            #add-point:ON ACTION controlp INFIELD prgb012 name="construct.c.page1.prgb012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prgb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb013
            #add-point:ON ACTION controlp INFIELD prgb013 name="construct.c.page1.prgb013"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgb013  #顯示到畫面上
            NEXT FIELD prgb013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb013
            #add-point:BEFORE FIELD prgb013 name="construct.b.page1.prgb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb013
            
            #add-point:AFTER FIELD prgb013 name="construct.a.page1.prgb013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb014
            #add-point:BEFORE FIELD prgb014 name="construct.b.page1.prgb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb014
            
            #add-point:AFTER FIELD prgb014 name="construct.a.page1.prgb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb014
            #add-point:ON ACTION controlp INFIELD prgb014 name="construct.c.page1.prgb014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb015
            #add-point:BEFORE FIELD prgb015 name="construct.b.page1.prgb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb015
            
            #add-point:AFTER FIELD prgb015 name="construct.a.page1.prgb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb015
            #add-point:ON ACTION controlp INFIELD prgb015 name="construct.c.page1.prgb015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb016
            #add-point:BEFORE FIELD prgb016 name="construct.b.page1.prgb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb016
            
            #add-point:AFTER FIELD prgb016 name="construct.a.page1.prgb016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb016
            #add-point:ON ACTION controlp INFIELD prgb016 name="construct.c.page1.prgb016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb034
            #add-point:BEFORE FIELD prgb034 name="construct.b.page1.prgb034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb034
            
            #add-point:AFTER FIELD prgb034 name="construct.a.page1.prgb034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb034
            #add-point:ON ACTION controlp INFIELD prgb034 name="construct.c.page1.prgb034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb017
            #add-point:BEFORE FIELD prgb017 name="construct.b.page1.prgb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb017
            
            #add-point:AFTER FIELD prgb017 name="construct.a.page1.prgb017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb017
            #add-point:ON ACTION controlp INFIELD prgb017 name="construct.c.page1.prgb017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb018
            #add-point:BEFORE FIELD prgb018 name="construct.b.page1.prgb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb018
            
            #add-point:AFTER FIELD prgb018 name="construct.a.page1.prgb018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb018
            #add-point:ON ACTION controlp INFIELD prgb018 name="construct.c.page1.prgb018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb035
            #add-point:BEFORE FIELD prgb035 name="construct.b.page1.prgb035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb035
            
            #add-point:AFTER FIELD prgb035 name="construct.a.page1.prgb035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb035
            #add-point:ON ACTION controlp INFIELD prgb035 name="construct.c.page1.prgb035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb019
            #add-point:BEFORE FIELD prgb019 name="construct.b.page1.prgb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb019
            
            #add-point:AFTER FIELD prgb019 name="construct.a.page1.prgb019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb019
            #add-point:ON ACTION controlp INFIELD prgb019 name="construct.c.page1.prgb019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb020
            #add-point:BEFORE FIELD prgb020 name="construct.b.page1.prgb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb020
            
            #add-point:AFTER FIELD prgb020 name="construct.a.page1.prgb020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb020
            #add-point:ON ACTION controlp INFIELD prgb020 name="construct.c.page1.prgb020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb021
            #add-point:BEFORE FIELD prgb021 name="construct.b.page1.prgb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb021
            
            #add-point:AFTER FIELD prgb021 name="construct.a.page1.prgb021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb021
            #add-point:ON ACTION controlp INFIELD prgb021 name="construct.c.page1.prgb021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb022
            #add-point:BEFORE FIELD prgb022 name="construct.b.page1.prgb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb022
            
            #add-point:AFTER FIELD prgb022 name="construct.a.page1.prgb022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb022
            #add-point:ON ACTION controlp INFIELD prgb022 name="construct.c.page1.prgb022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb023
            #add-point:BEFORE FIELD prgb023 name="construct.b.page1.prgb023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb023
            
            #add-point:AFTER FIELD prgb023 name="construct.a.page1.prgb023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb023
            #add-point:ON ACTION controlp INFIELD prgb023 name="construct.c.page1.prgb023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb024
            #add-point:BEFORE FIELD prgb024 name="construct.b.page1.prgb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb024
            
            #add-point:AFTER FIELD prgb024 name="construct.a.page1.prgb024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb024
            #add-point:ON ACTION controlp INFIELD prgb024 name="construct.c.page1.prgb024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb025
            #add-point:BEFORE FIELD prgb025 name="construct.b.page1.prgb025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb025
            
            #add-point:AFTER FIELD prgb025 name="construct.a.page1.prgb025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb025
            #add-point:ON ACTION controlp INFIELD prgb025 name="construct.c.page1.prgb025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb026
            #add-point:BEFORE FIELD prgb026 name="construct.b.page1.prgb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb026
            
            #add-point:AFTER FIELD prgb026 name="construct.a.page1.prgb026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb026
            #add-point:ON ACTION controlp INFIELD prgb026 name="construct.c.page1.prgb026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb027
            #add-point:BEFORE FIELD prgb027 name="construct.b.page1.prgb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb027
            
            #add-point:AFTER FIELD prgb027 name="construct.a.page1.prgb027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb027
            #add-point:ON ACTION controlp INFIELD prgb027 name="construct.c.page1.prgb027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb028
            #add-point:BEFORE FIELD prgb028 name="construct.b.page1.prgb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb028
            
            #add-point:AFTER FIELD prgb028 name="construct.a.page1.prgb028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb028
            #add-point:ON ACTION controlp INFIELD prgb028 name="construct.c.page1.prgb028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb029
            #add-point:BEFORE FIELD prgb029 name="construct.b.page1.prgb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb029
            
            #add-point:AFTER FIELD prgb029 name="construct.a.page1.prgb029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb029
            #add-point:ON ACTION controlp INFIELD prgb029 name="construct.c.page1.prgb029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb030
            #add-point:BEFORE FIELD prgb030 name="construct.b.page1.prgb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb030
            
            #add-point:AFTER FIELD prgb030 name="construct.a.page1.prgb030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb030
            #add-point:ON ACTION controlp INFIELD prgb030 name="construct.c.page1.prgb030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb031
            #add-point:BEFORE FIELD prgb031 name="construct.b.page1.prgb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb031
            
            #add-point:AFTER FIELD prgb031 name="construct.a.page1.prgb031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb031
            #add-point:ON ACTION controlp INFIELD prgb031 name="construct.c.page1.prgb031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb032
            #add-point:BEFORE FIELD prgb032 name="construct.b.page1.prgb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb032
            
            #add-point:AFTER FIELD prgb032 name="construct.a.page1.prgb032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb032
            #add-point:ON ACTION controlp INFIELD prgb032 name="construct.c.page1.prgb032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb033
            #add-point:BEFORE FIELD prgb033 name="construct.b.page1.prgb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb033
            
            #add-point:AFTER FIELD prgb033 name="construct.a.page1.prgb033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb033
            #add-point:ON ACTION controlp INFIELD prgb033 name="construct.c.page1.prgb033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgbunit
            #add-point:BEFORE FIELD prgbunit name="construct.b.page1.prgbunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgbunit
            
            #add-point:AFTER FIELD prgbunit name="construct.a.page1.prgbunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prgbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgbunit
            #add-point:ON ACTION controlp INFIELD prgbunit name="construct.c.page1.prgbunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON prgcsite,prgcunit,prgcseq,prgcseq1,prgc001,prgc012,prgc013,prgc014,prgc002, 
          prgc003,prgc004,prgc005,prgc006,prgc007,prgc008,prgc009,prgc010,prgc011
           FROM s_detail2[1].prgcsite,s_detail2[1].prgcunit,s_detail2[1].prgcseq,s_detail2[1].prgcseq1, 
               s_detail2[1].prgc001,s_detail2[1].prgc012,s_detail2[1].prgc013,s_detail2[1].prgc014,s_detail2[1].prgc002, 
               s_detail2[1].prgc003,s_detail2[1].prgc004,s_detail2[1].prgc005,s_detail2[1].prgc006,s_detail2[1].prgc007, 
               s_detail2[1].prgc008,s_detail2[1].prgc009,s_detail2[1].prgc010,s_detail2[1].prgc011
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.prgcsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgcsite
            #add-point:ON ACTION controlp INFIELD prgcsite name="construct.c.page2.prgcsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgcsite  #顯示到畫面上
            NEXT FIELD prgcsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgcsite
            #add-point:BEFORE FIELD prgcsite name="construct.b.page2.prgcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgcsite
            
            #add-point:AFTER FIELD prgcsite name="construct.a.page2.prgcsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgcunit
            #add-point:BEFORE FIELD prgcunit name="construct.b.page2.prgcunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgcunit
            
            #add-point:AFTER FIELD prgcunit name="construct.a.page2.prgcunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgcunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgcunit
            #add-point:ON ACTION controlp INFIELD prgcunit name="construct.c.page2.prgcunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgcseq
            #add-point:BEFORE FIELD prgcseq name="construct.b.page2.prgcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgcseq
            
            #add-point:AFTER FIELD prgcseq name="construct.a.page2.prgcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgcseq
            #add-point:ON ACTION controlp INFIELD prgcseq name="construct.c.page2.prgcseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgcseq1
            #add-point:BEFORE FIELD prgcseq1 name="construct.b.page2.prgcseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgcseq1
            
            #add-point:AFTER FIELD prgcseq1 name="construct.a.page2.prgcseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgcseq1
            #add-point:ON ACTION controlp INFIELD prgcseq1 name="construct.c.page2.prgcseq1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc001
            #add-point:BEFORE FIELD prgc001 name="construct.b.page2.prgc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc001
            
            #add-point:AFTER FIELD prgc001 name="construct.a.page2.prgc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc001
            #add-point:ON ACTION controlp INFIELD prgc001 name="construct.c.page2.prgc001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.prgc012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc012
            #add-point:ON ACTION controlp INFIELD prgc012 name="construct.c.page2.prgc012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_prgc012()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgc012  #顯示到畫面上
            NEXT FIELD prgc012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc012
            #add-point:BEFORE FIELD prgc012 name="construct.b.page2.prgc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc012
            
            #add-point:AFTER FIELD prgc012 name="construct.a.page2.prgc012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc013
            #add-point:BEFORE FIELD prgc013 name="construct.b.page2.prgc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc013
            
            #add-point:AFTER FIELD prgc013 name="construct.a.page2.prgc013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc013
            #add-point:ON ACTION controlp INFIELD prgc013 name="construct.c.page2.prgc013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc014
            #add-point:BEFORE FIELD prgc014 name="construct.b.page2.prgc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc014
            
            #add-point:AFTER FIELD prgc014 name="construct.a.page2.prgc014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc014
            #add-point:ON ACTION controlp INFIELD prgc014 name="construct.c.page2.prgc014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.prgc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc002
            #add-point:ON ACTION controlp INFIELD prgc002 name="construct.c.page2.prgc002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgc002  #顯示到畫面上
            NEXT FIELD prgc002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc002
            #add-point:BEFORE FIELD prgc002 name="construct.b.page2.prgc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc002
            
            #add-point:AFTER FIELD prgc002 name="construct.a.page2.prgc002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc003
            #add-point:BEFORE FIELD prgc003 name="construct.b.page2.prgc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc003
            
            #add-point:AFTER FIELD prgc003 name="construct.a.page2.prgc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc003
            #add-point:ON ACTION controlp INFIELD prgc003 name="construct.c.page2.prgc003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.prgc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc004
            #add-point:ON ACTION controlp INFIELD prgc004 name="construct.c.page2.prgc004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgc004  #顯示到畫面上
            NEXT FIELD prgc004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc004
            #add-point:BEFORE FIELD prgc004 name="construct.b.page2.prgc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc004
            
            #add-point:AFTER FIELD prgc004 name="construct.a.page2.prgc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc005
            #add-point:ON ACTION controlp INFIELD prgc005 name="construct.c.page2.prgc005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgc005  #顯示到畫面上
            NEXT FIELD prgc005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc005
            #add-point:BEFORE FIELD prgc005 name="construct.b.page2.prgc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc005
            
            #add-point:AFTER FIELD prgc005 name="construct.a.page2.prgc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc006
            #add-point:ON ACTION controlp INFIELD prgc006 name="construct.c.page2.prgc006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgc006  #顯示到畫面上
            NEXT FIELD prgc006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc006
            #add-point:BEFORE FIELD prgc006 name="construct.b.page2.prgc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc006
            
            #add-point:AFTER FIELD prgc006 name="construct.a.page2.prgc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc007
            #add-point:ON ACTION controlp INFIELD prgc007 name="construct.c.page2.prgc007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_11()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgc007  #顯示到畫面上
            NEXT FIELD prgc007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc007
            #add-point:BEFORE FIELD prgc007 name="construct.b.page2.prgc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc007
            
            #add-point:AFTER FIELD prgc007 name="construct.a.page2.prgc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc008
            #add-point:ON ACTION controlp INFIELD prgc008 name="construct.c.page2.prgc008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prgc008  #顯示到畫面上
            NEXT FIELD prgc008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc008
            #add-point:BEFORE FIELD prgc008 name="construct.b.page2.prgc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc008
            
            #add-point:AFTER FIELD prgc008 name="construct.a.page2.prgc008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc009
            #add-point:BEFORE FIELD prgc009 name="construct.b.page2.prgc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc009
            
            #add-point:AFTER FIELD prgc009 name="construct.a.page2.prgc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc009
            #add-point:ON ACTION controlp INFIELD prgc009 name="construct.c.page2.prgc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc010
            #add-point:BEFORE FIELD prgc010 name="construct.b.page2.prgc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc010
            
            #add-point:AFTER FIELD prgc010 name="construct.a.page2.prgc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc010
            #add-point:ON ACTION controlp INFIELD prgc010 name="construct.c.page2.prgc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgc011
            #add-point:BEFORE FIELD prgc011 name="construct.b.page2.prgc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgc011
            
            #add-point:AFTER FIELD prgc011 name="construct.a.page2.prgc011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prgc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgc011
            #add-point:ON ACTION controlp INFIELD prgc011 name="construct.c.page2.prgc011"
            
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
                  WHEN la_wc[li_idx].tableid = "prga_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prgb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prgc_t" 
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
 
{<section id="aprt601.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprt601_filter()
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
      CONSTRUCT g_wc_filter ON prgasite,prgadocdt,prgadocno,prga001,prga002,prga003,prga004,prga005, 
          prga006,prga007,prga008,prga009,prga010,prga011,prga012
                          FROM s_browse[1].b_prgasite,s_browse[1].b_prgadocdt,s_browse[1].b_prgadocno, 
                              s_browse[1].b_prga001,s_browse[1].b_prga002,s_browse[1].b_prga003,s_browse[1].b_prga004, 
                              s_browse[1].b_prga005,s_browse[1].b_prga006,s_browse[1].b_prga007,s_browse[1].b_prga008, 
                              s_browse[1].b_prga009,s_browse[1].b_prga010,s_browse[1].b_prga011,s_browse[1].b_prga012 
 
 
         BEFORE CONSTRUCT
               DISPLAY aprt601_filter_parser('prgasite') TO s_browse[1].b_prgasite
            DISPLAY aprt601_filter_parser('prgadocdt') TO s_browse[1].b_prgadocdt
            DISPLAY aprt601_filter_parser('prgadocno') TO s_browse[1].b_prgadocno
            DISPLAY aprt601_filter_parser('prga001') TO s_browse[1].b_prga001
            DISPLAY aprt601_filter_parser('prga002') TO s_browse[1].b_prga002
            DISPLAY aprt601_filter_parser('prga003') TO s_browse[1].b_prga003
            DISPLAY aprt601_filter_parser('prga004') TO s_browse[1].b_prga004
            DISPLAY aprt601_filter_parser('prga005') TO s_browse[1].b_prga005
            DISPLAY aprt601_filter_parser('prga006') TO s_browse[1].b_prga006
            DISPLAY aprt601_filter_parser('prga007') TO s_browse[1].b_prga007
            DISPLAY aprt601_filter_parser('prga008') TO s_browse[1].b_prga008
            DISPLAY aprt601_filter_parser('prga009') TO s_browse[1].b_prga009
            DISPLAY aprt601_filter_parser('prga010') TO s_browse[1].b_prga010
            DISPLAY aprt601_filter_parser('prga011') TO s_browse[1].b_prga011
            DISPLAY aprt601_filter_parser('prga012') TO s_browse[1].b_prga012
      
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
 
      CALL aprt601_filter_show('prgasite')
   CALL aprt601_filter_show('prgadocdt')
   CALL aprt601_filter_show('prgadocno')
   CALL aprt601_filter_show('prga001')
   CALL aprt601_filter_show('prga002')
   CALL aprt601_filter_show('prga003')
   CALL aprt601_filter_show('prga004')
   CALL aprt601_filter_show('prga005')
   CALL aprt601_filter_show('prga006')
   CALL aprt601_filter_show('prga007')
   CALL aprt601_filter_show('prga008')
   CALL aprt601_filter_show('prga009')
   CALL aprt601_filter_show('prga010')
   CALL aprt601_filter_show('prga011')
   CALL aprt601_filter_show('prga012')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt601.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprt601_filter_parser(ps_field)
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
 
{<section id="aprt601.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprt601_filter_show(ps_field)
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
   LET ls_condition = aprt601_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprt601.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt601_query()
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
   CALL g_prgb_d.clear()
   CALL g_prgb2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt601_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt601_browser_fill("")
      CALL aprt601_fetch("")
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
      CALL aprt601_filter_show('prgasite')
   CALL aprt601_filter_show('prgadocdt')
   CALL aprt601_filter_show('prgadocno')
   CALL aprt601_filter_show('prga001')
   CALL aprt601_filter_show('prga002')
   CALL aprt601_filter_show('prga003')
   CALL aprt601_filter_show('prga004')
   CALL aprt601_filter_show('prga005')
   CALL aprt601_filter_show('prga006')
   CALL aprt601_filter_show('prga007')
   CALL aprt601_filter_show('prga008')
   CALL aprt601_filter_show('prga009')
   CALL aprt601_filter_show('prga010')
   CALL aprt601_filter_show('prga011')
   CALL aprt601_filter_show('prga012')
   CALL aprt601_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt601_fetch("F") 
      #顯示單身筆數
      CALL aprt601_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt601.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt601_fetch(p_flag)
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
   
   LET g_prga_m.prgadocno = g_browser[g_current_idx].b_prgadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt601_master_referesh USING g_prga_m.prgadocno INTO g_prga_m.prgasite,g_prga_m.prgadocdt, 
       g_prga_m.prgadocno,g_prga_m.prga002,g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013, 
       g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga012, 
       g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.prga015, 
       g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaowndp,g_prga_m.prgacrtid,g_prga_m.prgacrtdp, 
       g_prga_m.prgacrtdt,g_prga_m.prgamodid,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfdt, 
       g_prga_m.prgasite_desc,g_prga_m.prga006_desc,g_prga_m.prga011_desc,g_prga_m.prga007_desc,g_prga_m.prga008_desc, 
       g_prga_m.prga015_desc,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp_desc,g_prga_m.prgacrtid_desc, 
       g_prga_m.prgacrtdp_desc,g_prga_m.prgamodid_desc,g_prga_m.prgacnfid_desc
   
   #遮罩相關處理
   LET g_prga_m_mask_o.* =  g_prga_m.*
   CALL aprt601_prga_t_mask()
   LET g_prga_m_mask_n.* =  g_prga_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt601_set_act_visible()   
   CALL aprt601_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #IF g_prga_m.prgastus = 'N' THEN                #151109-00006#7 151223 mark TT.Jessica
   IF g_prga_m.prgastus MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許修改  #151109-00006#7 151223 add TT.Jessica
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF
   #IF g_prog = 'aprt603' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'aprt603' THEN   #160705-00042#10 160713 by sakura add
      IF g_prga_m.prga013 = '2' OR g_prga_m.prga013 = '4' THEN 
         CALL cl_set_comp_visible("prgc012,prgc013",TRUE)
      ELSE
         CALL cl_set_comp_visible("prgc012,prgc013",FALSE)
      END IF 
   END IF 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prga_m_t.* = g_prga_m.*
   LET g_prga_m_o.* = g_prga_m.*
   
   LET g_data_owner = g_prga_m.prgaownid      
   LET g_data_dept  = g_prga_m.prgaowndp
   
   #重新顯示   
   CALL aprt601_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt601.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt601_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prgb_d.clear()   
   CALL g_prgb2_d.clear()  
 
 
   INITIALIZE g_prga_m.* TO NULL             #DEFAULT 設定
   
   LET g_prgadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prga_m.prgaownid = g_user
      LET g_prga_m.prgaowndp = g_dept
      LET g_prga_m.prgacrtid = g_user
      LET g_prga_m.prgacrtdp = g_dept 
      LET g_prga_m.prgacrtdt = cl_get_current()
      LET g_prga_m.prgamodid = g_user
      LET g_prga_m.prgamoddt = cl_get_current()
      LET g_prga_m.prgastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prga_m.prga013 = "1"
      LET g_prga_m.prga016 = "N"
      LET g_prga_m.prga014 = "100"
      LET g_prga_m.total = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
#      LET g_prga_m.prgaunit = g_site
#      LET g_prga_m.prgasite = g_site
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'prgasite',g_prga_m.prgasite)
         RETURNING l_insert,g_prga_m.prgasite
      IF NOT l_insert THEN
         RETURN
      END IF
      #IF g_prog = 'aprt602' THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'aprt602' THEN   #160705-00042#10 160713 by sakura add
         LET g_prga_m.prga013 = "2"
      END IF 
      LET g_prga_m.prgaunit = g_prga_m.prgasite
#      LET g_prga_m.prga001 = '1'     #mark by yangxf
      #add by yangxf ---start---
      #1.采购补差 2.库存补差 3.销售补差 21.销售补差
      CASE 
         #WHEN g_prog = 'aprt601'        #160705-00042#10 160713 by sakura mark
         WHEN g_prog MATCHES 'aprt601'   #160705-00042#10 160713 by sakura add
              LET g_prga_m.prga001 = '1'
         #WHEN g_prog = 'aprt602'        #160705-00042#10 160713 by sakura mark
         WHEN g_prog MATCHES 'aprt602'   #160705-00042#10 160713 by sakura add
              LET g_prga_m.prga001 = '2'
         #WHEN g_prog = 'aprt603'        #160705-00042#10 160713 by sakura mark
         WHEN g_prog MATCHES 'aprt603'   #160705-00042#10 160713 by sakura add
              LET g_prga_m.prga001 = '3'
         #WHEN g_prog = 'aprt701'        #160705-00042#10 160713 by sakura mark
         WHEN g_prog MATCHES 'aprt701'   #160705-00042#10 160713 by sakura add
              LET g_prga_m.prga001 = '21'
      END CASE 
      #add by yangxf ---end------

      LET g_prga_m.prgadocdt = g_today
      LET g_prga_m.prga002 = '1'
      #add by yangxf ---start---
      #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
         LET g_prga_m.prga005 = '1'
      ELSE
      #add by yangxf ---end------
         LET g_prga_m.prga005 = '0'
      END IF    #add by yangxf 
      LET g_prga_m.prga007 = g_user
      LET g_prga_m.prga008 = g_dept
      LET g_prga_m.prga009 = g_today
      LET g_prga_m.prga010 = g_today
      
      #dongsz--add--str---
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prga_m.prgasite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prga_m.prgadocno = r_doctype
      #dongsz--add--end---
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prga_m.prgasite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prga_m.prgasite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prga_m.prgasite_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prga_m.prga007
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_prga_m.prga007_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prga_m.prga007_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prga_m.prga008
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prga_m.prga008_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prga_m.prga008_desc
      
      LET g_prga_m_t.* = g_prga_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prga_m_t.* = g_prga_m.*
      LET g_prga_m_o.* = g_prga_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prga_m.prgastus 
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
 
 
 
    
      CALL aprt601_input("a")
      
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
         INITIALIZE g_prga_m.* TO NULL
         INITIALIZE g_prgb_d TO NULL
         INITIALIZE g_prgb2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt601_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prgb_d.clear()
      #CALL g_prgb2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt601_set_act_visible()   
   CALL aprt601_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prgadocno_t = g_prga_m.prgadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prgaent = " ||g_enterprise|| " AND",
                      " prgadocno = '", g_prga_m.prgadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt601_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt601_cl
   
   CALL aprt601_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt601_master_referesh USING g_prga_m.prgadocno INTO g_prga_m.prgasite,g_prga_m.prgadocdt, 
       g_prga_m.prgadocno,g_prga_m.prga002,g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013, 
       g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga012, 
       g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.prga015, 
       g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaowndp,g_prga_m.prgacrtid,g_prga_m.prgacrtdp, 
       g_prga_m.prgacrtdt,g_prga_m.prgamodid,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfdt, 
       g_prga_m.prgasite_desc,g_prga_m.prga006_desc,g_prga_m.prga011_desc,g_prga_m.prga007_desc,g_prga_m.prga008_desc, 
       g_prga_m.prga015_desc,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp_desc,g_prga_m.prgacrtid_desc, 
       g_prga_m.prgacrtdp_desc,g_prga_m.prgamodid_desc,g_prga_m.prgacnfid_desc
   
   
   #遮罩相關處理
   LET g_prga_m_mask_o.* =  g_prga_m.*
   CALL aprt601_prga_t_mask()
   LET g_prga_m_mask_n.* =  g_prga_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prga_m.prgasite,g_prga_m.prgasite_desc,g_prga_m.prgadocdt,g_prga_m.prgadocno,g_prga_m.prga002, 
       g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga006_desc,g_prga_m.prga013,g_prga_m.prga009, 
       g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga011_desc,g_prga_m.prga012, 
       g_prga_m.prga012_desc,g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga007_desc,g_prga_m.prga008, 
       g_prga_m.prga008_desc,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.total,g_prga_m.prga015,g_prga_m.prga015_desc, 
       g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp,g_prga_m.prgaowndp_desc, 
       g_prga_m.prgacrtid,g_prga_m.prgacrtid_desc,g_prga_m.prgacrtdp,g_prga_m.prgacrtdp_desc,g_prga_m.prgacrtdt, 
       g_prga_m.prgamodid,g_prga_m.prgamodid_desc,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfid_desc, 
       g_prga_m.prgacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prga_m.prgaownid      
   LET g_data_dept  = g_prga_m.prgaowndp
   
   #功能已完成,通報訊息中心
   CALL aprt601_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt601_modify()
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
   LET g_prga_m_t.* = g_prga_m.*
   LET g_prga_m_o.* = g_prga_m.*
   
   IF g_prga_m.prgadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prgadocno_t = g_prga_m.prgadocno
 
   CALL s_transaction_begin()
   
   OPEN aprt601_cl USING g_enterprise,g_prga_m.prgadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt601_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt601_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt601_master_referesh USING g_prga_m.prgadocno INTO g_prga_m.prgasite,g_prga_m.prgadocdt, 
       g_prga_m.prgadocno,g_prga_m.prga002,g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013, 
       g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga012, 
       g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.prga015, 
       g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaowndp,g_prga_m.prgacrtid,g_prga_m.prgacrtdp, 
       g_prga_m.prgacrtdt,g_prga_m.prgamodid,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfdt, 
       g_prga_m.prgasite_desc,g_prga_m.prga006_desc,g_prga_m.prga011_desc,g_prga_m.prga007_desc,g_prga_m.prga008_desc, 
       g_prga_m.prga015_desc,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp_desc,g_prga_m.prgacrtid_desc, 
       g_prga_m.prgacrtdp_desc,g_prga_m.prgamodid_desc,g_prga_m.prgacnfid_desc
   
   #檢查是否允許此動作
   IF NOT aprt601_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prga_m_mask_o.* =  g_prga_m.*
   CALL aprt601_prga_t_mask()
   LET g_prga_m_mask_n.* =  g_prga_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL aprt601_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_prgadocno_t = g_prga_m.prgadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prga_m.prgamodid = g_user 
LET g_prga_m.prgamoddt = cl_get_current()
LET g_prga_m.prgamodid_desc = cl_get_username(g_prga_m.prgamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_prga_m.prgastus MATCHES "[DR]" THEN
         LET g_prga_m.prgastus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt601_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prga_t SET (prgamodid,prgamoddt) = (g_prga_m.prgamodid,g_prga_m.prgamoddt)
          WHERE prgaent = g_enterprise AND prgadocno = g_prgadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prga_m.* = g_prga_m_t.*
            CALL aprt601_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prga_m.prgadocno != g_prga_m_t.prgadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE prgb_t SET prgbdocno = g_prga_m.prgadocno
 
          WHERE prgbent = g_enterprise AND prgbdocno = g_prga_m_t.prgadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prgb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prgb_t:",SQLERRMESSAGE 
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
         
         UPDATE prgc_t
            SET prgcdocno = g_prga_m.prgadocno
 
          WHERE prgcent = g_enterprise AND
                prgcdocno = g_prgadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prgc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prgc_t:",SQLERRMESSAGE 
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
   CALL aprt601_set_act_visible()   
   CALL aprt601_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prgaent = " ||g_enterprise|| " AND",
                      " prgadocno = '", g_prga_m.prgadocno, "' "
 
   #填到對應位置
   CALL aprt601_browser_fill("")
 
   CLOSE aprt601_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt601_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt601.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt601_input(p_cmd)
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
   DEFINE l_ooef004              LIKE ooef_t.ooef004
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_flag                 LIKE type_t.num5
   DEFINE l_errno                LIKE type_t.chr10
   DEFINE l_prgb001              LIKE prgb_t.prgb001    #add by yangxf
   DEFINE l_msg                  LIKE type_t.chr50   #151013-00001#43 dongsz add
   
   #add by yangxf ---start---
   #1.采购补差 2.库存补差 3.销售补差 21.销售补差
   CASE 
      #WHEN g_prog = 'aprt601'       #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt601'  #160705-00042#10 160713 by sakura add
           LET l_prgb001 = '1'
      #WHEN g_prog = 'aprt602'       #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt602'  #160705-00042#10 160713 by sakura add
           LET l_prgb001 = '2'
      #WHEN g_prog = 'aprt603'       #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt603'  #160705-00042#10 160713 by sakura add
           LET l_prgb001 = '3'
      #WHEN g_prog = 'aprt701'       #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt701'  #160705-00042#10 160713 by sakura add
           LET l_prgb001 = '21'
   END CASE 
   #add by yangxf ---end------
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
   DISPLAY BY NAME g_prga_m.prgasite,g_prga_m.prgasite_desc,g_prga_m.prgadocdt,g_prga_m.prgadocno,g_prga_m.prga002, 
       g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga006_desc,g_prga_m.prga013,g_prga_m.prga009, 
       g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga011_desc,g_prga_m.prga012, 
       g_prga_m.prga012_desc,g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga007_desc,g_prga_m.prga008, 
       g_prga_m.prga008_desc,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.total,g_prga_m.prga015,g_prga_m.prga015_desc, 
       g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp,g_prga_m.prgaowndp_desc, 
       g_prga_m.prgacrtid,g_prga_m.prgacrtid_desc,g_prga_m.prgacrtdp,g_prga_m.prgacrtdp_desc,g_prga_m.prgacrtdt, 
       g_prga_m.prgamodid,g_prga_m.prgamodid_desc,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfid_desc, 
       g_prga_m.prgacnfdt
   
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
   LET g_forupd_sql = "SELECT prgbseq,prgb001,prgb002,prgbsite,prgb003,prgb004,prgb005,prgb006,prgb007, 
       prgb009,prgb008,prgb010,prgb011,prgb012,prgb013,prgb014,prgb015,prgb016,prgb034,prgb017,prgb018, 
       prgb035,prgb019,prgb020,prgb021,prgb022,prgb023,prgb024,prgb025,prgb026,prgb027,prgb028,prgb029, 
       prgb030,prgb031,prgb032,prgb033,prgbunit FROM prgb_t WHERE prgbent=? AND prgbdocno=? AND prgbseq=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt601_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prgcsite,prgcunit,prgcseq,prgcseq1,prgc001,prgc012,prgc013,prgc014,prgc002, 
       prgc003,prgc004,prgc005,prgc006,prgc007,prgc008,prgc009,prgc010,prgc011 FROM prgc_t WHERE prgcent=?  
       AND prgcdocno=? AND prgcseq=? AND prgcseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt601_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt601_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aprt601_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prga_m.prgasite,g_prga_m.prgadocdt,g_prga_m.prgadocno,g_prga_m.prga002,g_prga_m.prga003, 
       g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013,g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016, 
       g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga012,g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008, 
       g_prga_m.prga005,g_prga_m.prga014,g_prga_m.total,g_prga_m.prga015,g_prga_m.prgaunit
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprt601.input.head" >}
      #單頭段
      INPUT BY NAME g_prga_m.prgasite,g_prga_m.prgadocdt,g_prga_m.prgadocno,g_prga_m.prga002,g_prga_m.prga003, 
          g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013,g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016, 
          g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga012,g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008, 
          g_prga_m.prga005,g_prga_m.prga014,g_prga_m.total,g_prga_m.prga015,g_prga_m.prgaunit 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt601_cl USING g_enterprise,g_prga_m.prgadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt601_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt601_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt601_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aprt601_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgasite
            
            #add-point:AFTER FIELD prgasite name="input.a.prgasite"
            IF NOT cl_null(g_prga_m.prgasite) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               LET g_errshow = '1'
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_prga_m.prgasite
#
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001_20") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_prga_m.prgasite = g_prga_m_t.prgasite
#                  LET g_prga_m.prgasite_desc = ""
#                  DISPLAY BY NAME g_prga_m.prgasite,g_prga_m.prgasite_desc
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_aooi500_chk(g_prog,'prgasite',g_prga_m.prgasite,g_prga_m.prgasite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prga_m.prgasite = g_prga_m_t.prgasite
                  LET g_prga_m.prgasite_desc = ""
                  DISPLAY BY NAME g_prga_m.prgasite,g_prga_m.prgasite_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            LET g_site_flag = TRUE
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prga_m.prgasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prga_m.prgasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prga_m.prgasite_desc
            CALL aprt601_set_entry(p_cmd)
            CALL aprt601_set_no_entry(p_cmd)


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgasite
            #add-point:BEFORE FIELD prgasite name="input.b.prgasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgasite
            #add-point:ON CHANGE prgasite name="input.g.prgasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgadocdt
            #add-point:BEFORE FIELD prgadocdt name="input.b.prgadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgadocdt
            
            #add-point:AFTER FIELD prgadocdt name="input.a.prgadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgadocdt
            #add-point:ON CHANGE prgadocdt name="input.g.prgadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgadocno
            
            #add-point:AFTER FIELD prgadocno name="input.a.prgadocno"
            IF NOT cl_null(g_prga_m.prgadocno) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               #設定g_chkparam.*的參數
               CALL s_aooi100_sel_ooef004(g_prga_m.prgasite)
                  RETURNING l_success,l_ooef004
               LET g_chkparam.arg1 = l_ooef004
               LET g_chkparam.arg2 = g_prga_m.prgadocno
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooba002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_prga_m.prgadocno = g_prga_m_t.prgadocno
                  DISPLAY BY NAME g_prga_m.prgadocno
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_prga_m.prgadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prga_m.prgadocno != g_prgadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prga_t WHERE "||"prgaent = '" ||g_enterprise|| "' AND "||"prgadocno = '"||g_prga_m.prgadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgadocno
            #add-point:BEFORE FIELD prgadocno name="input.b.prgadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgadocno
            #add-point:ON CHANGE prgadocno name="input.g.prgadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga002
            #add-point:BEFORE FIELD prga002 name="input.b.prga002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga002
            
            #add-point:AFTER FIELD prga002 name="input.a.prga002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga002
            #add-point:ON CHANGE prga002 name="input.g.prga002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga003
            #add-point:BEFORE FIELD prga003 name="input.b.prga003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga003
            
            #add-point:AFTER FIELD prga003 name="input.a.prga003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga003
            #add-point:ON CHANGE prga003 name="input.g.prga003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga004
            
            #add-point:AFTER FIELD prga004 name="input.a.prga004"
            IF NOT cl_null(g_prga_m.prga004) THEN
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prga_m.prga004

                  
               #呼叫檢查存在並帶值的library
               #add by yangxf ---start ---
               #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark 
               IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
                  IF cl_chk_exist("v_stce001_1") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prga_m.prga004 = g_prga_m_t.prga004
                     DISPLAY BY NAME g_prga_m.prga004
                     NEXT FIELD CURRENT
                  END IF
                  SELECT stce009,stce021,stce022
                    INTO g_prga_m.prga006,g_prga_m.prga011,g_prga_m.prga012
                    FROM stce_t
                   WHERE stceent = g_enterprise
                     AND stce001 = g_prga_m.prga004
               ELSE
               #add by yangxf ---end----
                  IF cl_chk_exist("v_stan001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prga_m.prga004 = g_prga_m_t.prga004
                     DISPLAY BY NAME g_prga_m.prga004
                     NEXT FIELD CURRENT
                  END IF
                  SELECT stan005,stan006,stan007
                    INTO g_prga_m.prga006,g_prga_m.prga011,g_prga_m.prga012
                    FROM stan_t
                   WHERE stanent = g_enterprise
                     AND stan001 = g_prga_m.prga004
               END IF   #add by yagnxf 
               DISPLAY BY NAME g_prga_m.prga006,g_prga_m.prga011,g_prga_m.prga012
#               SELECT pmab034 INTO g_prga_m.prga012
#                 FROM pmab_t
#                WHERE pmabent = g_enterprise
#                  AND pmabsite = g_prga_m.prgasite
#                  AND pmab001 = g_prga_m.prga006
#               DISPLAY BY NAME g_prga_m.prga012
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prga_m.prga006
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prga_m.prga006_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prga_m.prga006_desc
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prga_m.prga011
               CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prga_m.prga011_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prga_m.prga011_desc
               
               CALL aprt601_prga012_ref()
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga004
            #add-point:BEFORE FIELD prga004 name="input.b.prga004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga004
            #add-point:ON CHANGE prga004 name="input.g.prga004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga006
            
            #add-point:AFTER FIELD prga006 name="input.a.prga006"
            IF NOT cl_null(g_prga_m.prga006) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prga_m.prga006

                  
               #呼叫檢查存在並帶值的library
               #add by yangxf ---start ---
               #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark 
               IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
                  #160318-00025#33  2016/04/13  BY pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "apm-00638:sub-01302|adbm200|",cl_get_progname("adbm200",g_lang,"2"),"|:EXEPROGadbm200"
                  #160318-00025#33  2016/04/13  BY pengxin  add(E)
                  IF cl_chk_exist("v_pmaa001_17") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prga_m.prga006 = g_prga_m_t.prga006
                     LET g_prga_m.prga006_desc = ""
                     DISPLAY BY NAME g_prga_m.prga006,g_prga_m.prga006_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
               #add by yangxf ---end----
                  IF cl_chk_exist("v_pmaa001_1") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prga_m.prga006 = g_prga_m_t.prga006
                     LET g_prga_m.prga006_desc = ""
                     DISPLAY BY NAME g_prga_m.prga006,g_prga_m.prga006_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF   #add by yangxf 
               IF NOT aprt601_chk_prga006() THEN
                  LET g_prga_m.prga006 = g_prga_m_t.prga006
                  LET g_prga_m.prga006_desc = ""
                  DISPLAY BY NAME g_prga_m.prga006,g_prga_m.prga006_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prga_m.prga006
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prga_m.prga006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prga_m.prga006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga006
            #add-point:BEFORE FIELD prga006 name="input.b.prga006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga006
            #add-point:ON CHANGE prga006 name="input.g.prga006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga013
            #add-point:BEFORE FIELD prga013 name="input.b.prga013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga013
            
            #add-point:AFTER FIELD prga013 name="input.a.prga013"
            #add by yangxf ---start---
            IF g_prga_m.prga013 != g_prga_m_t.prga013 THEN 
               #IF g_prog = 'aprt603' THEN        #160705-00042#10 160713 by sakura mark 
               IF g_prog MATCHES 'aprt603' THEN   #160705-00042#10 160713 by sakura add
                  IF g_prga_m.prga013 = '1' THEN 
                     UPDATE prgb_t SET prgb015 = '',
                                       prgb016 = '',
                                       prgb034 = ''
                      WHERE prgbent = g_enterprise
                        AND prgbdocno = g_prga_m.prgadocno
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "UPD prgb_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               ELSE
                  IF g_prga_m.prga013 = '1' THEN 
                     UPDATE prgb_t SET prgb015 = '',
                                       prgb016 = ''
                      WHERE prgbent = g_enterprise
                        AND prgbdocno = g_prga_m.prgadocno
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "UPD prgb_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               END IF 
            END IF 
            #add by yangxf ---end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga013
            #add-point:ON CHANGE prga013 name="input.g.prga013"
            #add by yangxf ---start---
            #aprt601补差规则 1.数量补差则，隐藏单身原进价与本次进价 、毛利率 3.毛利补差则，本次补差关闭输入状态
            #IF g_prog = 'aprt603' THEN        #160705-00042#10 160713 by sakura mark
            IF g_prog MATCHES 'aprt603' THEN   #160705-00042#10 160713 by sakura add
               IF g_prga_m.prga013 = '1' THEN 
                  CALL cl_set_comp_visible("prgb015,prgb016,prgb034",FALSE)
                  CALL cl_set_comp_entry("prgb017",TRUE)
               ELSE
                  CALL cl_set_comp_visible("prgb015,prgb016,prgb034",TRUE)
                  CALL cl_set_comp_entry("prgb017",FALSE)
               END IF 
               IF g_prga_m.prga013 = '2' OR g_prga_m.prga013 = '4' THEN 
                  CALL cl_set_comp_visible("prgc012,prgc013",TRUE)
               ELSE
                  CALL cl_set_comp_visible("prgc012,prgc013",FALSE)
               END IF
            #aprt601，aprt602，aprt701补差规则 1.数量补差则，隐藏单身原进价与本次进价 2.基准进价则，本次补差关闭输入状态
            ELSE
               IF g_prga_m.prga013 = '1' THEN 
                  CALL cl_set_comp_visible("prgb015,prgb016",FALSE)
                  CALL cl_set_comp_entry("prgb017",TRUE)
               ELSE
                  #160809-00046#2 -s by 08172
#                  CALL cl_set_comp_visible("prgb015,prgb016",TRUE)
                  CALL cl_set_comp_visible("prgb016",TRUE)
                  CALL cl_set_comp_visible("prgb015",FALSE)
                  #160809-00046#2 -e by 08172
                  CALL cl_set_comp_entry("prgb017",FALSE)
               END IF 
            END IF 
            #IF g_prog != 'aprt701' THEN           #160705-00042#10 160713 by sakura mark 
            IF g_prog NOT MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
               CALL cl_set_comp_visible("prgb015",FALSE)
            END IF
            #add by yangxf ---end---
            #151013-00001#43-dongsz add--str
            IF g_prga_m.prga013 = '2' THEN
               #本次售价-->本次进价
               CALL cl_getmsg('apr-00508',g_lang) RETURNING l_msg
               CALL cl_set_comp_att_text("prgb016",l_msg CLIPPED)
            ELSE
               #本次售价
               CALL cl_getmsg('apr-00375',g_lang) RETURNING l_msg
               CALL cl_set_comp_att_text("prgb016",l_msg CLIPPED)
            END IF
            #151013-00001#43-dongsz add--end
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga009
            #add-point:BEFORE FIELD prga009 name="input.b.prga009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga009
            
            #add-point:AFTER FIELD prga009 name="input.a.prga009"
            IF NOT cl_null(g_prga_m.prga009) AND NOT cl_null(g_prga_m.prga010) THEN
               IF g_prga_m.prga010 < g_prga_m.prga009 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "apr-00049" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_prga_m.prga009 = g_prga_m_t.prga009
                  DISPLAY BY NAME g_prga_m.prga009
                  NEXT FIELD prga009
               END IF
            END IF
            #IF g_prog = 'aprt601' OR g_prog = 'aprt603' THEN              #160705-00042#10 160713 by sakura mark
            IF g_prog MATCHES 'aprt601' OR g_prog MATCHES 'aprt603' THEN   #160705-00042#10 160713 by sakura add
               IF g_prga_m.prga009 > g_today THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "apr-00406" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_prga_m.prga009 = g_prga_m_t.prga009
                  DISPLAY BY NAME g_prga_m.prga009
                  NEXT FIELD prga009
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga009
            #add-point:ON CHANGE prga009 name="input.g.prga009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga010
            #add-point:BEFORE FIELD prga010 name="input.b.prga010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga010
            
            #add-point:AFTER FIELD prga010 name="input.a.prga010"
            IF NOT cl_null(g_prga_m.prga010) AND NOT cl_null(g_prga_m.prga009) THEN
               IF g_prga_m.prga010 < g_prga_m.prga009 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "apr-00049" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_prga_m.prga010 = g_prga_m_t.prga010
                  DISPLAY BY NAME g_prga_m.prga010
                  NEXT FIELD prga009
               END IF
            END IF
            #mark by yangxf 20151229 ---start----
            #IF g_prog = 'aprt601' OR g_prog = 'aprt603' THEN 
            #   IF g_prga_m.prga010 > g_today THEN 
            #      INITIALIZE g_errparam TO NULL 
            #      LET g_errparam.extend = "" 
            #      LET g_errparam.code   = "apr-00406" 
            #      LET g_errparam.popup  = TRUE 
            #      CALL cl_err()
            #      LET g_prga_m.prga010 = g_prga_m_t.prga010
            #      DISPLAY BY NAME g_prga_m.prga010
            #      NEXT FIELD prga010
            #   END IF 
            #END IF 
            #mark by yangxf 20151229 ---end----
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga010
            #add-point:ON CHANGE prga010 name="input.g.prga010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga016
            #add-point:BEFORE FIELD prga016 name="input.b.prga016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga016
            
            #add-point:AFTER FIELD prga016 name="input.a.prga016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga016
            #add-point:ON CHANGE prga016 name="input.g.prga016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgastus
            #add-point:BEFORE FIELD prgastus name="input.b.prgastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgastus
            
            #add-point:AFTER FIELD prgastus name="input.a.prgastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgastus
            #add-point:ON CHANGE prgastus name="input.g.prgastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga011
            
            #add-point:AFTER FIELD prga011 name="input.a.prga011"
            IF NOT cl_null(g_prga_m.prga011) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               LET g_errshow = '1'
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prga_m.prgasite
               LET g_chkparam.arg2 = g_prga_m.prga011
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"  #160318-00025#33  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_prga_m.prga011 = g_prga_m_t.prga011
                  LET g_prga_m.prga011_desc = ""
                  DISPLAY BY NAME g_prga_m.prga011,g_prga_m.prga011_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prga_m.prga011
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prga_m.prga011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prga_m.prga011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga011
            #add-point:BEFORE FIELD prga011 name="input.b.prga011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga011
            #add-point:ON CHANGE prga011 name="input.g.prga011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga012
            
            #add-point:AFTER FIELD prga012 name="input.a.prga012"
            IF NOT cl_null(g_prga_m.prga012) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               LET g_errshow = '1'
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prga_m.prgasite
               LET g_chkparam.arg2 = g_prga_m.prga012
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"  #160318-00025#33  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_prga_m.prga012 = g_prga_m_t.prga012
                  LET g_prga_m.prga012_desc = ""
                  DISPLAY BY NAME g_prga_m.prga012,g_prga_m.prga012_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
       
            CALL aprt601_prga012_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga012
            #add-point:BEFORE FIELD prga012 name="input.b.prga012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga012
            #add-point:ON CHANGE prga012 name="input.g.prga012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga001
            #add-point:BEFORE FIELD prga001 name="input.b.prga001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga001
            
            #add-point:AFTER FIELD prga001 name="input.a.prga001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga001
            #add-point:ON CHANGE prga001 name="input.g.prga001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga007
            
            #add-point:AFTER FIELD prga007 name="input.a.prga007"
            IF NOT cl_null(g_prga_m.prga007) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               LET g_errshow = '1'
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prga_m.prga007
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#33  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_prga_m.prga007 = g_prga_m_t.prga007
                  LET g_prga_m.prga007_desc = ""
                  DISPLAY BY NAME g_prga_m.prga007,g_prga_m.prga007_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prga_m.prga007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prga_m.prga007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prga_m.prga007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga007
            #add-point:BEFORE FIELD prga007 name="input.b.prga007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga007
            #add-point:ON CHANGE prga007 name="input.g.prga007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga008
            
            #add-point:AFTER FIELD prga008 name="input.a.prga008"
            IF NOT cl_null(g_prga_m.prga008) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               LET g_errshow = '1'
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prga_m.prga008
               LET g_chkparam.arg2 = g_today
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#33  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_prga_m.prga008 = g_prga_m_t.prga008
                  LET g_prga_m.prga008_desc = ""
                  DISPLAY BY NAME g_prga_m.prga008,g_prga_m.prga008_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prga_m.prga008
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prga_m.prga008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prga_m.prga008_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga008
            #add-point:BEFORE FIELD prga008 name="input.b.prga008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga008
            #add-point:ON CHANGE prga008 name="input.g.prga008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga005
            #add-point:BEFORE FIELD prga005 name="input.b.prga005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga005
            
            #add-point:AFTER FIELD prga005 name="input.a.prga005"
            


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga005
            #add-point:ON CHANGE prga005 name="input.g.prga005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prga_m.prga014,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prga014
            END IF 
 
 
 
            #add-point:AFTER FIELD prga014 name="input.a.prga014"
            IF NOT cl_null(g_prga_m.prga014) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga014
            #add-point:BEFORE FIELD prga014 name="input.b.prga014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga014
            #add-point:ON CHANGE prga014 name="input.g.prga014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD total
            #add-point:BEFORE FIELD total name="input.b.total"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD total
            
            #add-point:AFTER FIELD total name="input.a.total"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE total
            #add-point:ON CHANGE total name="input.g.total"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prga015
            
            #add-point:AFTER FIELD prga015 name="input.a.prga015"
            IF NOT cl_null(g_prga_m.prga015) THEN 
               IF g_prga_m.prga015 != g_prga_m_t.prga015 OR g_prga_m_t.prga015 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  LET g_chkparam.arg1 = g_prga_m.prga015
                  LET g_chkparam.arg2 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
                  LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"  #160318-00025#33  add
                  IF NOT cl_chk_exist("v_rtax001_3") THEN
                     LET g_prga_m.prga015 = g_prga_m_t.prga015
                     CALL s_desc_get_rtaxl003_desc(g_prga_m.prga015) RETURNING g_prga_m.prga015_desc
                     DISPLAY BY NAME g_prga_m.prga015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prga_m.prga015
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prga_m.prga015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prga_m.prga015_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prga015
            #add-point:BEFORE FIELD prga015 name="input.b.prga015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prga015
            #add-point:ON CHANGE prga015 name="input.g.prga015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgaunit
            #add-point:BEFORE FIELD prgaunit name="input.b.prgaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgaunit
            
            #add-point:AFTER FIELD prgaunit name="input.a.prgaunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgaunit
            #add-point:ON CHANGE prgaunit name="input.g.prgaunit"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prgasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgasite
            #add-point:ON ACTION controlp INFIELD prgasite name="input.c.prgasite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prga_m.prgasite             #給予default值
            LET g_qryparam.default2 = g_prga_m.prgasite_desc #說明(簡稱)
            #給予arg
#            LET g_qryparam.where = " ooef201 = 'Y' " #
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prgasite',g_prga_m.prgasite,'i')   #150308-00001#4 150309 by lori522612 add 'i'

            
#            CALL q_ooef001()                                #呼叫開窗
            CALL q_ooef001_24()

            LET g_prga_m.prgasite = g_qryparam.return1              
#            LET g_prga_m.prgasite_desc = g_qryparam.return2 
            DISPLAY g_prga_m.prgasite TO prgasite              #
#            DISPLAY g_prga_m.prgasite_desc TO prgasite_desc #說明(簡稱)
            CALL s_desc_get_department_desc(g_prga_m.prgasite)
               RETURNING g_prga_m.prgasite_desc
            DISPLAY g_prga_m.prgasite_desc TO prgasite_desc
            NEXT FIELD prgasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prgadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgadocdt
            #add-point:ON ACTION controlp INFIELD prgadocdt name="input.c.prgadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.prgadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgadocno
            #add-point:ON ACTION controlp INFIELD prgadocno name="input.c.prgadocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prga_m.prgadocno             #給予default值

            #給予arg
            CALL s_aooi100_sel_ooef004(g_prga_m.prgasite)
               RETURNING l_success,l_ooef004
            LET g_qryparam.arg1 = l_ooef004
#            LET g_qryparam.arg2 = "aprt601" #   #mark by yangxf
            LET g_qryparam.arg2 = g_prog         #add by yangxf
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prga_m.prgadocno = g_qryparam.return1              

            DISPLAY g_prga_m.prgadocno TO prgadocno              #

            NEXT FIELD prgadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prga002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga002
            #add-point:ON ACTION controlp INFIELD prga002 name="input.c.prga002"
            
            #END add-point
 
 
         #Ctrlp:input.c.prga003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga003
            #add-point:ON ACTION controlp INFIELD prga003 name="input.c.prga003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prga004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga004
            #add-point:ON ACTION controlp INFIELD prga004 name="input.c.prga004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prga_m.prga004             #給予default值
            LET g_qryparam.default2 = g_prga_m.prga006 #供應商編號
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #add by yangxf ---start---
            #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark 
            IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
               CALL q_stce001_6()
            ELSE
               CALL q_stan001_2()                           #呼叫開窗
            END IF   #add by yangxf 
            LET g_prga_m.prga004 = g_qryparam.return1              
            LET g_prga_m.prga006 = g_qryparam.return2 
            DISPLAY g_prga_m.prga004 TO prga004              #
            DISPLAY g_prga_m.prga006 TO prga006 #供應商編號
            NEXT FIELD prga004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prga006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga006
            #add-point:ON ACTION controlp INFIELD prga006 name="input.c.prga006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prga_m.prga006             #給予default值
            LET g_qryparam.default2 = g_prga_m.prga006_desc #交易對象簡稱
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_prga_m.prga006 = g_qryparam.return1              
            LET g_prga_m.prga006_desc = g_qryparam.return2 
            DISPLAY g_prga_m.prga006 TO prga006              #
            DISPLAY g_prga_m.prga006_desc TO prga006_desc #交易對象簡稱
            NEXT FIELD prga006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prga013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga013
            #add-point:ON ACTION controlp INFIELD prga013 name="input.c.prga013"
            
            #END add-point
 
 
         #Ctrlp:input.c.prga009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga009
            #add-point:ON ACTION controlp INFIELD prga009 name="input.c.prga009"
            
            #END add-point
 
 
         #Ctrlp:input.c.prga010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga010
            #add-point:ON ACTION controlp INFIELD prga010 name="input.c.prga010"
            
            #END add-point
 
 
         #Ctrlp:input.c.prga016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga016
            #add-point:ON ACTION controlp INFIELD prga016 name="input.c.prga016"
            
            #END add-point
 
 
         #Ctrlp:input.c.prgastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgastus
            #add-point:ON ACTION controlp INFIELD prgastus name="input.c.prgastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.prga011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga011
            #add-point:ON ACTION controlp INFIELD prga011 name="input.c.prga011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prga_m.prga011             #給予default值
            LET g_qryparam.default2 = g_prga_m.prga011_desc #說明
            #給予arg
            LET g_qryparam.arg1 = g_prga_m.prgasite

            
            CALL q_ooaj002_3()                                #呼叫開窗

            LET g_prga_m.prga011 = g_qryparam.return1              
            LET g_prga_m.prga011_desc = g_qryparam.return2 
            DISPLAY g_prga_m.prga011 TO prga011              #
            DISPLAY g_prga_m.prga011_desc TO prga011_desc #說明
            NEXT FIELD prga011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prga012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga012
            #add-point:ON ACTION controlp INFIELD prga012 name="input.c.prga012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prga_m.prga012             #給予default值
            LET g_qryparam.default2 = g_prga_m.prga012_desc #稅別代碼
            #給予arg
            LET g_qryparam.arg1 = g_prga_m.prgasite  #

            
            CALL q_oodb002_8()                                #呼叫開窗

            LET g_prga_m.prga012 = g_qryparam.return1              
            LET g_prga_m.prga012_desc = g_qryparam.return2 
            DISPLAY g_prga_m.prga012 TO prga012              #
            DISPLAY g_prga_m.prga012_desc TO prga012_desc #稅別代碼
            NEXT FIELD prga012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prga001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga001
            #add-point:ON ACTION controlp INFIELD prga001 name="input.c.prga001"
            
            #END add-point
 
 
         #Ctrlp:input.c.prga007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga007
            #add-point:ON ACTION controlp INFIELD prga007 name="input.c.prga007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prga_m.prga007             #給予default值
            LET g_qryparam.default2 = g_prga_m.prga007_desc #歸屬部門
            LET g_qryparam.default3 = g_prga_m.prga008 #說明(簡稱)
            LET g_qryparam.default4 = g_prga_m.prga008_desc #全名
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001_6()                                #呼叫開窗

            LET g_prga_m.prga007 = g_qryparam.return1              
            LET g_prga_m.prga007_desc = g_qryparam.return2 
            LET g_prga_m.prga008 = g_qryparam.return3 
            LET g_prga_m.prga008_desc = g_qryparam.return4 
            DISPLAY g_prga_m.prga007 TO prga007              #
            DISPLAY g_prga_m.prga007_desc TO prga007_desc #歸屬部門
            DISPLAY g_prga_m.prga008 TO prga008 #說明(簡稱)
            DISPLAY g_prga_m.prga008_desc TO prga008_desc #全名
            NEXT FIELD prga007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prga008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga008
            #add-point:ON ACTION controlp INFIELD prga008 name="input.c.prga008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prga_m.prga008             #給予default值
            LET g_qryparam.default2 = g_prga_m.prga008_desc #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today #

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_prga_m.prga008 = g_qryparam.return1              
            LET g_prga_m.prga008_desc = g_qryparam.return2 
            DISPLAY g_prga_m.prga008 TO prga008              #
            DISPLAY g_prga_m.prga008_desc TO prga008_desc #部門編號
            NEXT FIELD prga008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prga005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga005
            #add-point:ON ACTION controlp INFIELD prga005 name="input.c.prga005"


            #END add-point
 
 
         #Ctrlp:input.c.prga014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga014
            #add-point:ON ACTION controlp INFIELD prga014 name="input.c.prga014"
            
            #END add-point
 
 
         #Ctrlp:input.c.total
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD total
            #add-point:ON ACTION controlp INFIELD total name="input.c.total"
            
            #END add-point
 
 
         #Ctrlp:input.c.prga015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prga015
            #add-point:ON ACTION controlp INFIELD prga015 name="input.c.prga015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_prga_m.prga015    #給予default值
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
            CALL q_rtax001_3()                            #呼叫開窗
            LET g_prga_m.prga015 = g_qryparam.return1              
            DISPLAY g_prga_m.prga015 TO prga015         
            CALL s_desc_get_rtaxl003_desc(g_prga_m.prga015) RETURNING g_prga_m.prga015_desc
            DISPLAY BY NAME g_prga_m.prga015_desc            
            NEXT FIELD prga015
            #END add-point
 
 
         #Ctrlp:input.c.prgaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgaunit
            #add-point:ON ACTION controlp INFIELD prgaunit name="input.c.prgaunit"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prga_m.prgadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            #151013-00001#43-dongsz add--str
            IF g_prga_m.prga013 = '2' THEN
               #本次售价-->本次进价
               CALL cl_getmsg('apr-00508',g_lang) RETURNING l_msg
               CALL cl_set_comp_att_text("prgb016",l_msg CLIPPED)
            ELSE
               #本次售价
               CALL cl_getmsg('apr-00375',g_lang) RETURNING l_msg
               CALL cl_set_comp_att_text("prgb016",l_msg CLIPPED)
            END IF
            #151013-00001#43-dongsz add--end
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_prga_m.prgasite,g_prga_m.prgadocno,g_prga_m.prgadocdt,g_prog) RETURNING l_flag,g_prga_m.prgadocno
               IF NOT l_flag THEN
                  NEXT FIELD prgadocno
               END IF 
               #end add-point
               
               INSERT INTO prga_t (prgaent,prgasite,prgadocdt,prgadocno,prga002,prga003,prga004,prga006, 
                   prga013,prga009,prga010,prga016,prgastus,prga011,prga012,prga001,prga007,prga008, 
                   prga005,prga014,prga015,prgaunit,prgaownid,prgaowndp,prgacrtid,prgacrtdp,prgacrtdt, 
                   prgamodid,prgamoddt,prgacnfid,prgacnfdt)
               VALUES (g_enterprise,g_prga_m.prgasite,g_prga_m.prgadocdt,g_prga_m.prgadocno,g_prga_m.prga002, 
                   g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013,g_prga_m.prga009, 
                   g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga012, 
                   g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008,g_prga_m.prga005,g_prga_m.prga014, 
                   g_prga_m.prga015,g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaowndp,g_prga_m.prgacrtid, 
                   g_prga_m.prgacrtdp,g_prga_m.prgacrtdt,g_prga_m.prgamodid,g_prga_m.prgamoddt,g_prga_m.prgacnfid, 
                   g_prga_m.prgacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prga_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aprt601_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt601_b_fill()
                  CALL aprt601_b_fill2('0')
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
               CALL aprt601_prga_t_mask_restore('restore_mask_o')
               
               UPDATE prga_t SET (prgasite,prgadocdt,prgadocno,prga002,prga003,prga004,prga006,prga013, 
                   prga009,prga010,prga016,prgastus,prga011,prga012,prga001,prga007,prga008,prga005, 
                   prga014,prga015,prgaunit,prgaownid,prgaowndp,prgacrtid,prgacrtdp,prgacrtdt,prgamodid, 
                   prgamoddt,prgacnfid,prgacnfdt) = (g_prga_m.prgasite,g_prga_m.prgadocdt,g_prga_m.prgadocno, 
                   g_prga_m.prga002,g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013, 
                   g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011, 
                   g_prga_m.prga012,g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008,g_prga_m.prga005, 
                   g_prga_m.prga014,g_prga_m.prga015,g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaowndp, 
                   g_prga_m.prgacrtid,g_prga_m.prgacrtdp,g_prga_m.prgacrtdt,g_prga_m.prgamodid,g_prga_m.prgamoddt, 
                   g_prga_m.prgacnfid,g_prga_m.prgacnfdt)
                WHERE prgaent = g_enterprise AND prgadocno = g_prgadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prga_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               SELECT COUNT(*) INTO l_n FROM prgb_t
                WHERE prgbent = g_enterprise
                  AND prgbdocno = g_prga_m.prgadocno
               IF l_n > 0 THEN
                  CALL aprt601_upd_prgb() RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aprt601_prga_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prga_m_t)
               LET g_log2 = util.JSON.stringify(g_prga_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prgadocno_t = g_prga_m.prgadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt601.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prgb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prgb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt601_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prgb_d.getLength()
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
            OPEN aprt601_cl USING g_enterprise,g_prga_m.prgadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt601_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt601_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prgb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prgb_d[l_ac].prgbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prgb_d_t.* = g_prgb_d[l_ac].*  #BACKUP
               LET g_prgb_d_o.* = g_prgb_d[l_ac].*  #BACKUP
               CALL aprt601_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aprt601_set_no_entry_b(l_cmd)
               IF NOT aprt601_lock_b("prgb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt601_bcl INTO g_prgb_d[l_ac].prgbseq,g_prgb_d[l_ac].prgb001,g_prgb_d[l_ac].prgb002, 
                      g_prgb_d[l_ac].prgbsite,g_prgb_d[l_ac].prgb003,g_prgb_d[l_ac].prgb004,g_prgb_d[l_ac].prgb005, 
                      g_prgb_d[l_ac].prgb006,g_prgb_d[l_ac].prgb007,g_prgb_d[l_ac].prgb009,g_prgb_d[l_ac].prgb008, 
                      g_prgb_d[l_ac].prgb010,g_prgb_d[l_ac].prgb011,g_prgb_d[l_ac].prgb012,g_prgb_d[l_ac].prgb013, 
                      g_prgb_d[l_ac].prgb014,g_prgb_d[l_ac].prgb015,g_prgb_d[l_ac].prgb016,g_prgb_d[l_ac].prgb034, 
                      g_prgb_d[l_ac].prgb017,g_prgb_d[l_ac].prgb018,g_prgb_d[l_ac].prgb035,g_prgb_d[l_ac].prgb019, 
                      g_prgb_d[l_ac].prgb020,g_prgb_d[l_ac].prgb021,g_prgb_d[l_ac].prgb022,g_prgb_d[l_ac].prgb023, 
                      g_prgb_d[l_ac].prgb024,g_prgb_d[l_ac].prgb025,g_prgb_d[l_ac].prgb026,g_prgb_d[l_ac].prgb027, 
                      g_prgb_d[l_ac].prgb028,g_prgb_d[l_ac].prgb029,g_prgb_d[l_ac].prgb030,g_prgb_d[l_ac].prgb031, 
                      g_prgb_d[l_ac].prgb032,g_prgb_d[l_ac].prgb033,g_prgb_d[l_ac].prgbunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prgb_d_t.prgbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prgb_d_mask_o[l_ac].* =  g_prgb_d[l_ac].*
                  CALL aprt601_prgb_t_mask()
                  LET g_prgb_d_mask_n[l_ac].* =  g_prgb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt601_show()
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
            INITIALIZE g_prgb_d[l_ac].* TO NULL 
            INITIALIZE g_prgb_d_t.* TO NULL 
            INITIALIZE g_prgb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_prgb_d[l_ac].prgb035 = "100"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_prgb_d[l_ac].prgbsite = g_prga_m.prgasite
            IF l_ac > 1 THEN 
               LET g_prgb_d[l_ac].prgbsite = g_prgb_d[l_ac-1].prgbsite
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prgb_d[l_ac].prgbsite
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prgb_d[l_ac].prgbsite_desc = '', g_rtn_fields[1] , ''
            END IF 
            #end add-point
            LET g_prgb_d_t.* = g_prgb_d[l_ac].*     #新輸入資料
            LET g_prgb_d_o.* = g_prgb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt601_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt601_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prgb_d[li_reproduce_target].* = g_prgb_d[li_reproduce].*
 
               LET g_prgb_d[li_reproduce_target].prgbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            CALL aprt601_prga004_prgb() RETURNING l_success
            IF NOT l_success THEN
               INITIALIZE g_prgb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               RETURN
            END IF
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
            SELECT COUNT(1) INTO l_count FROM prgb_t 
             WHERE prgbent = g_enterprise AND prgbdocno = g_prga_m.prgadocno
 
               AND prgbseq = g_prgb_d[l_ac].prgbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prga_m.prgadocno
               LET gs_keys[2] = g_prgb_d[g_detail_idx].prgbseq
               CALL aprt601_insert_b('prgb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prgb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prgb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt601_b_fill()
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
               DELETE FROM prgc_t
                WHERE prgcent = g_enterprise 
                  AND prgcdocno = g_prga_m.prgadocno
                  AND prgcseq = g_prgb_d[l_ac].prgbseq
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
               #删除单身二资料
               DELETE FROM prgc_t
                WHERE prgcent = g_enterprise 
                  AND prgcdocno = g_prga_m.prgadocno
                  AND prgcseq = g_prgb_d[l_ac].prgbseq
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prga_m.prgadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prgb_d_t.prgbseq
 
            
               #刪除同層單身
               IF NOT aprt601_delete_b('prgb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt601_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt601_key_delete_b(gs_keys,'prgb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt601_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt601_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_prgb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prgb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgbseq
            #add-point:BEFORE FIELD prgbseq name="input.b.page1.prgbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgbseq
            
            #add-point:AFTER FIELD prgbseq name="input.a.page1.prgbseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_prga_m.prgadocno IS NOT NULL AND g_prgb_d[g_detail_idx].prgbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prga_m.prgadocno != g_prgadocno_t OR g_prgb_d[g_detail_idx].prgbseq != g_prgb_d_t.prgbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prgb_t WHERE "||"prgbent = '" ||g_enterprise|| "' AND "||"prgbdocno = '"||g_prga_m.prgadocno ||"' AND "|| "prgbseq = '"||g_prgb_d[g_detail_idx].prgbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgbseq
            #add-point:ON CHANGE prgbseq name="input.g.page1.prgbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb001
            #add-point:BEFORE FIELD prgb001 name="input.b.page1.prgb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb001
            
            #add-point:AFTER FIELD prgb001 name="input.a.page1.prgb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb001
            #add-point:ON CHANGE prgb001 name="input.g.page1.prgb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb002
            #add-point:BEFORE FIELD prgb002 name="input.b.page1.prgb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb002
            
            #add-point:AFTER FIELD prgb002 name="input.a.page1.prgb002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb002
            #add-point:ON CHANGE prgb002 name="input.g.page1.prgb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgbsite
            
            #add-point:AFTER FIELD prgbsite name="input.a.page1.prgbsite"
            IF NOT cl_null(g_prgb_d[l_ac].prgbsite) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               LET g_errshow = '1'
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_prgb_d[l_ac].prgbsite
#               LET g_chkparam.arg2 = '8'
#               LET g_chkparam.arg3 = g_prga_m.prgasite
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooed004") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_prgb_d[l_ac].prgbsite = g_prgb_d_t.prgbsite
#                  DISPLAY BY NAME g_prgb_d[l_ac].prgbsite
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_aooi500_chk(g_prog,'prgbsite',g_prgb_d[l_ac].prgbsite,g_prga_m.prgasite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  #LET g_prgb_d[l_ac].prgbsite = g_prgb_d_t.prgbsite   #160824-00007#157 20161125 mark by beckxie
                  #160824-00007#157 20161125 add by beckxie---S
                  LET g_prgb_d[l_ac].prgbsite = g_prgb_d_o.prgbsite   
                  LET g_prgb_d[l_ac].prgbsite_desc = g_prgb_d_o.prgbsite_desc
                  LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                  LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                  #160824-00007#157 20161125 add by beckxie---E
                  LET g_prgb_d[l_ac].prgbsite_desc = ""
                  DISPLAY BY NAME g_prgb_d[l_ac].prgbsite,g_prgb_d[l_ac].prgbsite_desc
                  NEXT FIELD CURRENT
               END IF

               IF NOT cl_null(g_prgb_d[l_ac].prgb008) THEN 
                  #IF (l_cmd = 'a' OR (l_cmd = 'u' AND g_prgb_d[l_ac].prgbsite != g_prgb_d_t.prgbsite)) THEN   #160824-00007#157 20161125 mark by beckxie
                  IF g_prgb_d[l_ac].prgbsite != g_prgb_d_o.prgbsite OR cl_null(g_prgb_d_o.prgbsite) THEN   #160824-00007#157 20161125 add by beckxie
                     #IF g_prog != 'aprt701' THEN           #160705-00042#10 160713 by sakura mark
                     IF g_prog NOT MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
                        IF NOT aprt601_prgb008_chk_1() THEN 
                           #LET g_prgb_d[l_ac].prgbsite = g_prgb_d_t.prgbsite   #160824-00007#157 20161125 mark by beckxie
                           #160824-00007#157 20161125 add by beckxie---S
                           LET g_prgb_d[l_ac].prgbsite = g_prgb_d_o.prgbsite   
                           LET g_prgb_d[l_ac].prgbsite_desc = g_prgb_d_o.prgbsite_desc
                           LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                           LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                           #160824-00007#157 20161125 add by beckxie---E
                           
                           DISPLAY BY NAME g_prgb_d[l_ac].prgbsite
                           NEXT FIELD CURRENT
                        END IF
                     END IF 
                     LET l_n = 0   #add by yangxf
                     SELECT COUNT(*) INTO l_n
                       FROM prgb_t,prga_t
                      WHERE prgaent = prgbent
                        AND prgadocno = prgbdocno
                        AND prgbent = g_enterprise
                        AND prgbsite = g_prgb_d[l_ac].prgbsite
                        AND prgb008 = g_prgb_d[l_ac].prgb008
                        AND prgbdocno = g_prga_m.prgadocno   #add by yangxf
#                        AND prgb001 = '1'        #mark by yangxf
                        AND prgb001 = l_prgb001   #add by yangxf
                        AND prgastus = 'N'
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "apr-00337" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        #LET g_prgb_d[l_ac].prgbsite = g_prgb_d_t.prgbsite   #160824-00007#157 20161125 mark by beckxie
                        #160824-00007#157 20161125 add by beckxie---S
                        LET g_prgb_d[l_ac].prgbsite = g_prgb_d_o.prgbsite   
                        LET g_prgb_d[l_ac].prgbsite_desc = g_prgb_d_o.prgbsite_desc
                        LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                        LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                        #160824-00007#157 20161125 add by beckxie---E
                        DISPLAY BY NAME g_prgb_d[l_ac].prgbsite
                        NEXT FIELD prgbsite
                     END IF
                  END IF 
#                     CALL aprt601_prgb008_inag()   #mark by yangxf 
                  #add by yangxf ---start---
                  #IF g_prog != 'aprt701' THEN       #151013-00001#43 dongsz mark
                  #IF g_prog != 'aprt701' AND NOT ((g_prog = 'aprt601' OR g_prog = 'aprt603') AND g_prga_m.prga010 > g_today) THEN  #151013-00001#43 dongsz add   #160705-00042#10 160713 by sakura mark
                  IF g_prog NOT MATCHES 'aprt701' AND NOT ((g_prog MATCHES 'aprt601' OR g_prog MATCHES 'aprt603') AND g_prga_m.prga010 > g_today) THEN            #160705-00042#10 160713 by sakura add
                     #计算补差
                     CALL s_astp312_get_prgb014('2',g_prga_m.prgadocno,g_prgb_d[l_ac].prgbseq,g_prgb_d[l_ac].prgbsite,g_prgb_d[l_ac].prgb008,
                              g_prgb_d[l_ac].prgb016,g_prgb_d[l_ac].prgb017,g_prgb_d[l_ac].prgb034)
                          RETURNING g_prgb_d[l_ac].prgb014,g_prgb_d[l_ac].prgb018
                     IF g_prgb_d[l_ac].prgb018 <= 0  THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "apr-00339" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        #LET g_prgb_d[l_ac].prgbsite = g_prgb_d_t.prgbsite   #160824-00007#157 20161125 mark by beckxie
                        #160824-00007#157 20161125 add by beckxie---S
                        LET g_prgb_d[l_ac].prgbsite = g_prgb_d_o.prgbsite   
                        LET g_prgb_d[l_ac].prgbsite_desc = g_prgb_d_o.prgbsite_desc
                        LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                        LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                        #160824-00007#157 20161125 add by beckxie---E
                        DISPLAY BY NAME g_prgb_d[l_ac].prgbsite
                        NEXT FIELD prgbsite
                     END IF
                  END IF 
                  #add by yangxf ----end----
               END IF
            END IF
            LET g_prgb_d[l_ac].prgbunit = g_prgb_d[l_ac].prgbsite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prgb_d[l_ac].prgbsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prgb_d[l_ac].prgbsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prgb_d[l_ac].prgbsite_desc

            LET g_prgb_d_o.* = g_prgb_d[l_ac].* #160824-00007#157 20161125 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgbsite
            #add-point:BEFORE FIELD prgbsite name="input.b.page1.prgbsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgbsite
            #add-point:ON CHANGE prgbsite name="input.g.page1.prgbsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb003
            #add-point:BEFORE FIELD prgb003 name="input.b.page1.prgb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb003
            
            #add-point:AFTER FIELD prgb003 name="input.a.page1.prgb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb003
            #add-point:ON CHANGE prgb003 name="input.g.page1.prgb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb004
            #add-point:BEFORE FIELD prgb004 name="input.b.page1.prgb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb004
            
            #add-point:AFTER FIELD prgb004 name="input.a.page1.prgb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb004
            #add-point:ON CHANGE prgb004 name="input.g.page1.prgb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb005
            #add-point:BEFORE FIELD prgb005 name="input.b.page1.prgb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb005
            
            #add-point:AFTER FIELD prgb005 name="input.a.page1.prgb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb005
            #add-point:ON CHANGE prgb005 name="input.g.page1.prgb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb006
            #add-point:BEFORE FIELD prgb006 name="input.b.page1.prgb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb006
            
            #add-point:AFTER FIELD prgb006 name="input.a.page1.prgb006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb006
            #add-point:ON CHANGE prgb006 name="input.g.page1.prgb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb007
            
            #add-point:AFTER FIELD prgb007 name="input.a.page1.prgb007"
            IF NOT cl_null(g_prgb_d[l_ac].prgb007) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prgb_d[l_ac].prgb007
               #160318-00025#33  2016/04/13  BY pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "adb-00285:sub-01302|adbm201|",cl_get_progname("adbm201",g_lang,"2"),"|:EXEPROGadbm201"
               #160318-00025#33  2016/04/13  BY pengxin  add(E)
               IF cl_chk_exist("v_pmaa001_21") THEN
               ELSE
                  #檢查失敗時後續處理
                  LET g_prgb_d[l_ac].prgb007 = g_prgb_d_t.prgb007
                  LET g_prgb_d[l_ac].prgb007_desc = ""
                  DISPLAY BY NAME g_prgb_d[l_ac].prgb007,g_prgb_d[l_ac].prgb007_desc
                  NEXT FIELD CURRENT
               END IF
            
               IF NOT cl_null(g_prga_m.prga006) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM pmaa_t
                   WHERE pmaaent = g_enterprise AND pmaa001 = g_prgb_d[l_ac].prgb007 AND pmaa006 = g_prga_m.prga006
                  IF l_n < 1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00043'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_prgb_d[l_ac].prgb007 = g_prgb_d_t.prgb007
                     LET g_prgb_d[l_ac].prgb007_desc = ""
                     DISPLAY BY NAME g_prgb_d[l_ac].prgb007,g_prgb_d[l_ac].prgb007_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_prgb_d[l_ac].prgb005 = '1'
            ELSE
               LET g_prgb_d[l_ac].prgb005 = '0'
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb007
            #add-point:BEFORE FIELD prgb007 name="input.b.page1.prgb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb007
            #add-point:ON CHANGE prgb007 name="input.g.page1.prgb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb009
            
            #add-point:AFTER FIELD prgb009 name="input.a.page1.prgb009"
            IF NOT cl_null(g_prgb_d[l_ac].prgb009) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prgb_d[l_ac].prgb009

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imay003_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  #LET g_prgb_d[l_ac].prgb009 = g_prgb_d_t.prgb009   #160824-00007#157 20161125 mark by beckxie
                  #160824-00007#157 20161125 add by beckxie---S
                  LET g_prgb_d[l_ac].prgb009 = g_prgb_d_o.prgb009   
                  LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                  LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                  LET g_prgb_d[l_ac].prgb008 = g_prgb_d_o.prgb008
                  LET g_prgb_d[l_ac].prgb013 = g_prgb_d_o.prgb013
                  LET g_prgb_d[l_ac].prgb013_desc = g_prgb_d_o.prgb013_desc
                  LET g_prgb_d[l_ac].prgb008_desc = g_prgb_d_o.prgb008_desc
                  LET g_prgb_d[l_ac].prgb008_desc_desc = g_prgb_d_o.prgb008_desc_desc
                  LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014
                  LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018
                  #160824-00007#157 20161125 add by beckxie---E
                  DISPLAY BY NAME g_prgb_d[l_ac].prgb009
                  NEXT FIELD CURRENT
               END IF
            
               CALL aprt601_prgb009_ref()
               #add by yangxf ---start----
               IF NOT aprt601_prgb008_chk() THEN 
                  #LET g_prgb_d[l_ac].prgb009 = g_prgb_d_t.prgb009   #160824-00007#157 20161125 mark by beckxie
                  #160824-00007#157 20161125 add by beckxie---S
                  LET g_prgb_d[l_ac].prgb009 = g_prgb_d_o.prgb009   
                  LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                  LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                  LET g_prgb_d[l_ac].prgb008 = g_prgb_d_o.prgb008
                  LET g_prgb_d[l_ac].prgb013 = g_prgb_d_o.prgb013
                  LET g_prgb_d[l_ac].prgb013_desc = g_prgb_d_o.prgb013_desc
                  LET g_prgb_d[l_ac].prgb008_desc = g_prgb_d_o.prgb008_desc
                  LET g_prgb_d[l_ac].prgb008_desc_desc = g_prgb_d_o.prgb008_desc_desc
                  LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014
                  LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018
                  #160824-00007#157 20161125 add by beckxie---E
                  DISPLAY BY NAME g_prgb_d[l_ac].prgb009
                  CALL aprt601_prgb009_ref()
                  NEXT FIELD CURRENT
               END IF
               #add by yangxf ---end-----
               IF NOT cl_null(g_prgb_d[l_ac].prgbsite) AND NOT cl_null(g_prgb_d[l_ac].prgb008) THEN  
                  IF (l_cmd = 'a' OR (l_cmd = 'u' AND g_prgb_d[l_ac].prgb009 != g_prgb_d_t.prgb009)) THEN
                     #IF g_prog != 'aprt701' THEN           #160705-00042#10 160713 by sakura mark
                     IF g_prog NOT MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
                        IF NOT aprt601_prgb008_chk_1() THEN 
                           #LET g_prgb_d[l_ac].prgb009 = g_prgb_d_t.prgb009   #160824-00007#157 20161125 mark by beckxie
                           #160824-00007#157 20161125 add by beckxie---S
                           LET g_prgb_d[l_ac].prgb009 = g_prgb_d_o.prgb009   
                           LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                           LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                           LET g_prgb_d[l_ac].prgb008 = g_prgb_d_o.prgb008
                           LET g_prgb_d[l_ac].prgb013 = g_prgb_d_o.prgb013
                           LET g_prgb_d[l_ac].prgb013_desc = g_prgb_d_o.prgb013_desc
                           LET g_prgb_d[l_ac].prgb008_desc = g_prgb_d_o.prgb008_desc
                           LET g_prgb_d[l_ac].prgb008_desc_desc = g_prgb_d_o.prgb008_desc_desc
                           LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014
                           LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018
                           #160824-00007#157 20161125 add by beckxie---E
                           DISPLAY BY NAME g_prgb_d[l_ac].prgb009
                           NEXT FIELD CURRENT
                        END IF
                     END IF 
                     LET l_n = 0   #add by yangxf
                     SELECT COUNT(*) INTO l_n
                       FROM prgb_t,prga_t
                      WHERE prgaent = prgbent
                        AND prgadocno = prgbdocno
                        AND prgbent = g_enterprise
                        AND prgbsite = g_prgb_d[l_ac].prgbsite
                        AND prgb008 = g_prgb_d[l_ac].prgb008
                        AND prgbdocno = g_prga_m.prgadocno   #add by yangxf
#                        AND prgb001 = '1'        #mark by yangxf
                        AND prgb001 = l_prgb001   #add by yangxf
                        AND prgastus = 'N'
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "apr-00337" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        #LET g_prgb_d[l_ac].prgb009 = g_prgb_d_t.prgb009   #160824-00007#157 20161125 mark by beckxie
                        #160824-00007#157 20161125 add by beckxie---S
                        LET g_prgb_d[l_ac].prgb009 = g_prgb_d_o.prgb009   
                        LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                        LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                        LET g_prgb_d[l_ac].prgb008 = g_prgb_d_o.prgb008
                        LET g_prgb_d[l_ac].prgb013 = g_prgb_d_o.prgb013
                        LET g_prgb_d[l_ac].prgb013_desc = g_prgb_d_o.prgb013_desc
                        LET g_prgb_d[l_ac].prgb008_desc = g_prgb_d_o.prgb008_desc
                        LET g_prgb_d[l_ac].prgb008_desc_desc = g_prgb_d_o.prgb008_desc_desc
                        LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014
                        LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018
                        #160824-00007#157 20161125 add by beckxie---E
                        DISPLAY BY NAME g_prgb_d[l_ac].prgb009
                        NEXT FIELD prgb009
                     END IF 
                  END IF 
                  #add by yangxf ---start---
                  #IF g_prog != 'aprt701' THEN     #151013-00001#43 dongsz mark
                  #IF g_prog != 'aprt701' AND NOT ((g_prog = 'aprt601' OR g_prog = 'aprt603') AND g_prga_m.prga010 > g_today) THEN  #151013-00001#43 dongsz add   #160705-00042#10 160713 by sakura mark
                  IF g_prog NOT MATCHES 'aprt701' AND NOT ((g_prog MATCHES 'aprt601' OR g_prog MATCHES 'aprt603') AND g_prga_m.prga010 > g_today) THEN            #160705-00042#10 160713 by sakura add
                     #计算补差
                     CALL s_astp312_get_prgb014('2',g_prga_m.prgadocno,g_prgb_d[l_ac].prgbseq,g_prgb_d[l_ac].prgbsite,g_prgb_d[l_ac].prgb008,
                              g_prgb_d[l_ac].prgb016,g_prgb_d[l_ac].prgb017,g_prgb_d[l_ac].prgb034)
                          RETURNING g_prgb_d[l_ac].prgb014,g_prgb_d[l_ac].prgb018              
                     IF g_prgb_d[l_ac].prgb018 <= 0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "apr-00339" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        #LET g_prgb_d[l_ac].prgb009 = g_prgb_d_t.prgb009   #160824-00007#157 20161125 mark by beckxie
                        #160824-00007#157 20161125 add by beckxie---S
                        LET g_prgb_d[l_ac].prgb009 = g_prgb_d_o.prgb009   
                        LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                        LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                        LET g_prgb_d[l_ac].prgb008 = g_prgb_d_o.prgb008
                        LET g_prgb_d[l_ac].prgb013 = g_prgb_d_o.prgb013
                        LET g_prgb_d[l_ac].prgb013_desc = g_prgb_d_o.prgb013_desc
                        LET g_prgb_d[l_ac].prgb008_desc = g_prgb_d_o.prgb008_desc
                        LET g_prgb_d[l_ac].prgb008_desc_desc = g_prgb_d_o.prgb008_desc_desc
                        LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014
                        LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018
                        #160824-00007#157 20161125 add by beckxie---E
                        DISPLAY BY NAME g_prgb_d[l_ac].prgb009
                        NEXT FIELD prgb009
                     END IF
                  END IF 
                  #add by yangxf ----end----
#                  CALL aprt601_prgb008_inag()                      #mark by yangxf
               END IF
            END IF 
            
            LET g_prgb_d_o.* = g_prgb_d[l_ac].*   #160824-00007#157 20161125 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb009
            #add-point:BEFORE FIELD prgb009 name="input.b.page1.prgb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb009
            #add-point:ON CHANGE prgb009 name="input.g.page1.prgb009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb008
            
            #add-point:AFTER FIELD prgb008 name="input.a.page1.prgb008"
            IF NOT cl_null(g_prgb_d[l_ac].prgb008) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prgb_d[l_ac].prgb008

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_prgb_d[l_ac].prgb008 = g_prgb_d_t.prgb008
                  DISPLAY BY NAME g_prgb_d[l_ac].prgb008
                  NEXT FIELD CURRENT
               END IF
               #add by yangxf ---start----
               IF NOT aprt601_prgb008_chk() THEN 
                  LET g_prgb_d[l_ac].prgb008 = g_prgb_d_t.prgb008
                  DISPLAY BY NAME g_prgb_d[l_ac].prgb008
                  NEXT FIELD CURRENT
               END IF
               #add by yangxf ---end-----
               IF NOT cl_null(g_prgb_d[l_ac].prgbsite) THEN 
                  #IF (l_cmd = 'a' OR (l_cmd = 'u' AND g_prgb_d[l_ac].prgb008 != g_prgb_d_t.prgb008)) THEN   #160824-00007#157 20161125 mark by beckxie
                  IF g_prgb_d[l_ac].prgb008 != g_prgb_d_o.prgb008 OR cl_null(g_prgb_d_o.prgb008) THEN   #160824-00007#157 20161125 add by beckxie
                     #IF g_prog != 'aprt701' THEN           #160705-00042#10 160713 by sakura mark 
                     IF g_prog NOT MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
                        IF NOT aprt601_prgb008_chk_1() THEN 
                           #LET g_prgb_d[l_ac].prgb008 = g_prgb_d_t.prgb008   #160824-00007#157 20161125 mark by beckxie
                           #160824-00007#157 20161125 add by beckxie---S
                           LET g_prgb_d[l_ac].prgb008 = g_prgb_d_o.prgb008   
                           LET g_prgb_d[l_ac].prgb009 = g_prgb_d_o.prgb009
                           LET g_prgb_d[l_ac].prgb013 = g_prgb_d_o.prgb013
                           LET g_prgb_d[l_ac].prgb008_desc = g_prgb_d_o.prgb008_desc
                           LET g_prgb_d[l_ac].prgb008_desc_desc = g_prgb_d_o.prgb008_desc_desc
                           LET g_prgb_d[l_ac].prgb013_desc = g_prgb_d_o.prgb013_desc
                           LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                           LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                           #160824-00007#157 20161125 add by beckxie---E
                           DISPLAY BY NAME g_prgb_d[l_ac].prgb008
                           NEXT FIELD CURRENT
                        END IF
                     END IF 
                     LET l_n = 0    #add by yangxf 
                     SELECT COUNT(*) INTO l_n
                       FROM prgb_t,prga_t
                      WHERE prgaent = prgbent
                        AND prgadocno = prgbdocno
                        AND prgbent = g_enterprise
                        AND prgbsite = g_prgb_d[l_ac].prgbsite
                        AND prgb008 = g_prgb_d[l_ac].prgb008
                        AND prgbdocno = g_prga_m.prgadocno   #add by yangxf
#                        AND prgb001 = '1'        #mark by yangxf
                        AND prgb001 = l_prgb001   #add by yangxf
                        AND prgastus = 'N'
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "apr-00337" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        #LET g_prgb_d[l_ac].prgb008 = g_prgb_d_t.prgb008   #160824-00007#157 20161125 mark by beckxie
                        #160824-00007#157 20161125 add by beckxie---S
                        LET g_prgb_d[l_ac].prgb008 = g_prgb_d_o.prgb008   
                        LET g_prgb_d[l_ac].prgb009 = g_prgb_d_o.prgb009
                        LET g_prgb_d[l_ac].prgb013 = g_prgb_d_o.prgb013
                        LET g_prgb_d[l_ac].prgb008_desc = g_prgb_d_o.prgb008_desc
                        LET g_prgb_d[l_ac].prgb008_desc_desc = g_prgb_d_o.prgb008_desc_desc
                        LET g_prgb_d[l_ac].prgb013_desc = g_prgb_d_o.prgb013_desc
                        LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                        LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                        #160824-00007#157 20161125 add by beckxie---E
                        DISPLAY BY NAME g_prgb_d[l_ac].prgb008
                        NEXT FIELD prgb008
                     END IF
                  END IF 
                  #IF g_prog != 'aprt701' THEN    #151013-00001#43 dongsz mark
                  #IF g_prog != 'aprt701' AND NOT ((g_prog = 'aprt601' OR g_prog = 'aprt603') AND g_prga_m.prga010 > g_today) THEN  #151013-00001#43 dongsz add   #160705-00042#10 160713 by sakura mark
                  IF g_prog NOT MATCHES 'aprt701' AND NOT ((g_prog MATCHES 'aprt601' OR g_prog MATCHES 'aprt603') AND g_prga_m.prga010 > g_today) THEN            #160705-00042#10 160713 by sakura add
                     #add by yangxf ---start---
                     #计算补差
                     CALL s_astp312_get_prgb014('2',g_prga_m.prgadocno,g_prgb_d[l_ac].prgbseq,g_prgb_d[l_ac].prgbsite,g_prgb_d[l_ac].prgb008,
                              g_prgb_d[l_ac].prgb016,g_prgb_d[l_ac].prgb017,g_prgb_d[l_ac].prgb034)
                          RETURNING g_prgb_d[l_ac].prgb014,g_prgb_d[l_ac].prgb018                   
                     IF g_prgb_d[l_ac].prgb018 <= 0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "apr-00339" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        #LET g_prgb_d[l_ac].prgb008 = g_prgb_d_t.prgb008   #160824-00007#157 20161125 mark by beckxie
                        #160824-00007#157 20161125 add by beckxie---S
                        LET g_prgb_d[l_ac].prgb008 = g_prgb_d_o.prgb008   
                        LET g_prgb_d[l_ac].prgb009 = g_prgb_d_o.prgb009
                        LET g_prgb_d[l_ac].prgb013 = g_prgb_d_o.prgb013
                        LET g_prgb_d[l_ac].prgb008_desc = g_prgb_d_o.prgb008_desc
                        LET g_prgb_d[l_ac].prgb008_desc_desc = g_prgb_d_o.prgb008_desc_desc
                        LET g_prgb_d[l_ac].prgb013_desc = g_prgb_d_o.prgb013_desc
                        LET g_prgb_d[l_ac].prgb014 = g_prgb_d_o.prgb014   
                        LET g_prgb_d[l_ac].prgb018 = g_prgb_d_o.prgb018   
                        #160824-00007#157 20161125 add by beckxie---E
                        DISPLAY BY NAME g_prgb_d[l_ac].prgb008
                        NEXT FIELD prgb008
                     END IF
                  END IF 
                  #add by yangxf ----end----
#                  CALL aprt601_prgb008_inag()                    #mark by yangxf
               END IF
               CALL aprt601_prgb008_ref()
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prgb_d[l_ac].prgb008
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prgb_d[l_ac].prgb008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prgb_d[l_ac].prgb008_desc
            
            LET g_prgb_d_o.* = g_prgb_d[l_ac].* #160824-00007#157 20161125 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb008
            #add-point:BEFORE FIELD prgb008 name="input.b.page1.prgb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb008
            #add-point:ON CHANGE prgb008 name="input.g.page1.prgb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb010
            #add-point:BEFORE FIELD prgb010 name="input.b.page1.prgb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb010
            
            #add-point:AFTER FIELD prgb010 name="input.a.page1.prgb010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb010
            #add-point:ON CHANGE prgb010 name="input.g.page1.prgb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb011
            #add-point:BEFORE FIELD prgb011 name="input.b.page1.prgb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb011
            
            #add-point:AFTER FIELD prgb011 name="input.a.page1.prgb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb011
            #add-point:ON CHANGE prgb011 name="input.g.page1.prgb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb012
            #add-point:BEFORE FIELD prgb012 name="input.b.page1.prgb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb012
            
            #add-point:AFTER FIELD prgb012 name="input.a.page1.prgb012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb012
            #add-point:ON CHANGE prgb012 name="input.g.page1.prgb012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb013
            
            #add-point:AFTER FIELD prgb013 name="input.a.page1.prgb013"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prgb_d[l_ac].prgb013
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prgb_d[l_ac].prgb013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prgb_d[l_ac].prgb013_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb013
            #add-point:BEFORE FIELD prgb013 name="input.b.page1.prgb013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb013
            #add-point:ON CHANGE prgb013 name="input.g.page1.prgb013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prgb_d[l_ac].prgb014,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prgb014
            END IF 
 
 
 
            #add-point:AFTER FIELD prgb014 name="input.a.page1.prgb014"
#modify by yangxf ---start---
            #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark
            IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
               IF NOT cl_null(g_prgb_d[l_ac].prgb014) THEN 
                  IF NOT cl_null(g_prgb_d[l_ac].prgb017) THEN
                     LET g_prgb_d[l_ac].prgb018 = g_prgb_d[l_ac].prgb014 * g_prgb_d[l_ac].prgb017
                     DISPLAY BY NAME g_prgb_d[l_ac].prgb018
                  END IF
               END IF 
            END IF 
#modify by yangxf ---end----
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb014
            #add-point:BEFORE FIELD prgb014 name="input.b.page1.prgb014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb014
            #add-point:ON CHANGE prgb014 name="input.g.page1.prgb014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prgb_d[l_ac].prgb015,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prgb015
            END IF 
 
 
 
            #add-point:AFTER FIELD prgb015 name="input.a.page1.prgb015"
            IF NOT cl_null(g_prgb_d[l_ac].prgb015) THEN 
               IF NOT cl_null(g_prgb_d[l_ac].prgb016) THEN
                  LET g_prgb_d[l_ac].prgb017 = g_prgb_d[l_ac].prgb015 - g_prgb_d[l_ac].prgb016
                  DISPLAY BY NAME g_prgb_d[l_ac].prgb017
                  IF g_prgb_d[l_ac].prgb017 < 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "apr-00339" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_prgb_d[l_ac].prgb015 = g_prgb_d_t.prgb015
                     LET g_prgb_d[l_ac].prgb017 = 0
                     DISPLAY BY NAME g_prgb_d[l_ac].prgb015,g_prgb_d[l_ac].prgb017
                     NEXT FIELD prgb015
                  END IF
                  IF NOT cl_null(g_prgb_d[l_ac].prgb014) THEN
                     LET g_prgb_d[l_ac].prgb018 = g_prgb_d[l_ac].prgb014 * g_prgb_d[l_ac].prgb017
                     DISPLAY BY NAME g_prgb_d[l_ac].prgb018
                  END IF
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb015
            #add-point:BEFORE FIELD prgb015 name="input.b.page1.prgb015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb015
            #add-point:ON CHANGE prgb015 name="input.g.page1.prgb015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prgb_d[l_ac].prgb016,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prgb016
            END IF 
 
 
 
            #add-point:AFTER FIELD prgb016 name="input.a.page1.prgb016"
            IF NOT cl_null(g_prgb_d[l_ac].prgb016) THEN
               #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark 
               IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
                  IF NOT cl_null(g_prgb_d[l_ac].prgb015) THEN
                     LET g_prgb_d[l_ac].prgb017 = g_prgb_d[l_ac].prgb015 - g_prgb_d[l_ac].prgb016
                     DISPLAY BY NAME g_prgb_d[l_ac].prgb017
                     IF g_prgb_d[l_ac].prgb017 < 0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "apr-00339" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_prgb_d[l_ac].prgb016 = g_prgb_d_t.prgb016
                        LET g_prgb_d[l_ac].prgb017 = 0
                        DISPLAY BY NAME g_prgb_d[l_ac].prgb016,g_prgb_d[l_ac].prgb017
                        NEXT FIELD prgb016
                     END IF
                     IF NOT cl_null(g_prgb_d[l_ac].prgb014) THEN
                        LET g_prgb_d[l_ac].prgb018 = g_prgb_d[l_ac].prgb014 * g_prgb_d[l_ac].prgb017
                        DISPLAY BY NAME g_prgb_d[l_ac].prgb018
                     END IF
                  END IF
               ELSE
                  #add by yangxf ---start---
                  #计算补差
                  #IF NOT ((g_prog = 'aprt601' OR g_prog = 'aprt603') AND g_prga_m.prga010 > g_today) THEN  #151013-00001#43 dongsz add   #160705-00042#10 160713 by sakura mark
                  IF NOT ((g_prog MATCHES 'aprt601' OR g_prog MATCHES 'aprt603') AND g_prga_m.prga010 > g_today) THEN                     #160705-00042#10 160713 by sakura add
                     CALL s_astp312_get_prgb014('2',g_prga_m.prgadocno,g_prgb_d[l_ac].prgbseq,g_prgb_d[l_ac].prgbsite,g_prgb_d[l_ac].prgb008,
                              g_prgb_d[l_ac].prgb016,g_prgb_d[l_ac].prgb017,g_prgb_d[l_ac].prgb034)
                          RETURNING g_prgb_d[l_ac].prgb014,g_prgb_d[l_ac].prgb018             
                     IF g_prgb_d[l_ac].prgb018 <= 0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "apr-00339" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_prgb_d[l_ac].prgb016 = g_prgb_d_t.prgb016
                        DISPLAY BY NAME g_prgb_d[l_ac].prgb016
                        NEXT FIELD prgb016
                     END IF
                  END IF      #151013-00001#43 dongsz add
               END IF 
                  #add by yangxf ----end----
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb016
            #add-point:BEFORE FIELD prgb016 name="input.b.page1.prgb016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb016
            #add-point:ON CHANGE prgb016 name="input.g.page1.prgb016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb034
            #add-point:BEFORE FIELD prgb034 name="input.b.page1.prgb034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb034
            
            #add-point:AFTER FIELD prgb034 name="input.a.page1.prgb034"
            IF NOT cl_ap_chk_range(g_prgb_d[l_ac].prgb034,"0.00","0","","","azz-00079",1) THEN
               NEXT FIELD prgb034
            END IF 

            #IF NOT cl_null(g_prgb_d[l_ac].prgb034) THEN   #151013-00001#43 dongsz mark
            #IF NOT cl_null(g_prgb_d[l_ac].prgb034) AND NOT ((g_prog = 'aprt601' OR g_prog = 'aprt603') AND g_prga_m.prga010 > g_today) THEN  #151013-00001#43 dongsz add   #160705-00042#10 160713 by sakura mark
            IF NOT cl_null(g_prgb_d[l_ac].prgb034) AND NOT ((g_prog MATCHES 'aprt601' OR g_prog MATCHES 'aprt603') AND g_prga_m.prga010 > g_today) THEN                     #160705-00042#10 160713 by sakura add
#mark by yangxf ---start---
#               IF NOT cl_null(g_prgb_d[l_ac].prgb015) THEN
#                  #本次补差=  成本价/(1-毛利率)-本次售价
#                  LET g_prgb_d[l_ac].prgb017 = g_prgb_d[l_ac].prgb015/(1-g_prgb_d[l_ac].prgb034/100) - g_prgb_d[l_ac].prgb016
#                  DISPLAY BY NAME g_prgb_d[l_ac].prgb017
#                  IF g_prgb_d[l_ac].prgb017 < 0 THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "" 
#                     LET g_errparam.code   = "apr-00339" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     LET g_prgb_d[l_ac].prgb034 = g_prgb_d_t.prgb034
#                     LET g_prgb_d[l_ac].prgb017 = g_prgb_d_t.prgb017
#                     DISPLAY BY NAME g_prgb_d[l_ac].prgb034,g_prgb_d[l_ac].prgb017
#                     NEXT FIELD prgb034
#                  END IF
#                  IF NOT cl_null(g_prgb_d[l_ac].prgb014) THEN
#                     LET g_prgb_d[l_ac].prgb018 = g_prgb_d[l_ac].prgb014 * g_prgb_d[l_ac].prgb017
#                     DISPLAY BY NAME g_prgb_d[l_ac].prgb018
#                  END IF
#               END IF
#mark by yangxf ---end----
                #add by yangxf ---start---
                #计算补差
                CALL s_astp312_get_prgb014('2',g_prga_m.prgadocno,g_prgb_d[l_ac].prgbseq,g_prgb_d[l_ac].prgbsite,g_prgb_d[l_ac].prgb008,
                              g_prgb_d[l_ac].prgb016,g_prgb_d[l_ac].prgb017,g_prgb_d[l_ac].prgb034)
                    RETURNING g_prgb_d[l_ac].prgb014,g_prgb_d[l_ac].prgb018                 
                IF g_prgb_d[l_ac].prgb018 <= 0 THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "" 
                   LET g_errparam.code   = "apr-00339" 
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()
                   LET g_prgb_d[l_ac].prgb034 = g_prgb_d_t.prgb034
                   DISPLAY BY NAME g_prgb_d[l_ac].prgb034
                   NEXT FIELD prgb034
                END IF
                #add by yangxf ----end----
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb034
            #add-point:ON CHANGE prgb034 name="input.g.page1.prgb034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb017
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prgb_d[l_ac].prgb017,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prgb017
            END IF 
 
 
 
            #add-point:AFTER FIELD prgb017 name="input.a.page1.prgb017"
            IF NOT cl_null(g_prgb_d[l_ac].prgb017) THEN
               IF NOT cl_null(g_prgb_d[l_ac].prgb014) THEN
                  LET g_prgb_d[l_ac].prgb018 = g_prgb_d[l_ac].prgb014 * g_prgb_d[l_ac].prgb017
                  IF g_prgb_d[l_ac].prgb018 <= 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "apr-00339" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_prgb_d[l_ac].prgb017 = g_prgb_d_t.prgb017
                     LET g_prgb_d[l_ac].prgb018 = g_prgb_d_t.prgb018
                     NEXT FIELD prgb017
                  END IF
                  DISPLAY BY NAME g_prgb_d[l_ac].prgb018
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb017
            #add-point:BEFORE FIELD prgb017 name="input.b.page1.prgb017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb017
            #add-point:ON CHANGE prgb017 name="input.g.page1.prgb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb018
            #add-point:BEFORE FIELD prgb018 name="input.b.page1.prgb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb018
            
            #add-point:AFTER FIELD prgb018 name="input.a.page1.prgb018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb018
            #add-point:ON CHANGE prgb018 name="input.g.page1.prgb018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb035
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prgb_d[l_ac].prgb035,"0.000","1","100.000","1","azz-00087",1) THEN 
 
               NEXT FIELD prgb035
            END IF 
 
 
 
            #add-point:AFTER FIELD prgb035 name="input.a.page1.prgb035"
            IF NOT cl_null(g_prgb_d[l_ac].prgb035) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb035
            #add-point:BEFORE FIELD prgb035 name="input.b.page1.prgb035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb035
            #add-point:ON CHANGE prgb035 name="input.g.page1.prgb035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb019
            #add-point:BEFORE FIELD prgb019 name="input.b.page1.prgb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb019
            
            #add-point:AFTER FIELD prgb019 name="input.a.page1.prgb019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb019
            #add-point:ON CHANGE prgb019 name="input.g.page1.prgb019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb020
            #add-point:BEFORE FIELD prgb020 name="input.b.page1.prgb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb020
            
            #add-point:AFTER FIELD prgb020 name="input.a.page1.prgb020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb020
            #add-point:ON CHANGE prgb020 name="input.g.page1.prgb020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb021
            #add-point:BEFORE FIELD prgb021 name="input.b.page1.prgb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb021
            
            #add-point:AFTER FIELD prgb021 name="input.a.page1.prgb021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb021
            #add-point:ON CHANGE prgb021 name="input.g.page1.prgb021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb022
            #add-point:BEFORE FIELD prgb022 name="input.b.page1.prgb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb022
            
            #add-point:AFTER FIELD prgb022 name="input.a.page1.prgb022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb022
            #add-point:ON CHANGE prgb022 name="input.g.page1.prgb022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb023
            #add-point:BEFORE FIELD prgb023 name="input.b.page1.prgb023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb023
            
            #add-point:AFTER FIELD prgb023 name="input.a.page1.prgb023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb023
            #add-point:ON CHANGE prgb023 name="input.g.page1.prgb023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb024
            #add-point:BEFORE FIELD prgb024 name="input.b.page1.prgb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb024
            
            #add-point:AFTER FIELD prgb024 name="input.a.page1.prgb024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb024
            #add-point:ON CHANGE prgb024 name="input.g.page1.prgb024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb025
            #add-point:BEFORE FIELD prgb025 name="input.b.page1.prgb025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb025
            
            #add-point:AFTER FIELD prgb025 name="input.a.page1.prgb025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb025
            #add-point:ON CHANGE prgb025 name="input.g.page1.prgb025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb026
            #add-point:BEFORE FIELD prgb026 name="input.b.page1.prgb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb026
            
            #add-point:AFTER FIELD prgb026 name="input.a.page1.prgb026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb026
            #add-point:ON CHANGE prgb026 name="input.g.page1.prgb026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb027
            #add-point:BEFORE FIELD prgb027 name="input.b.page1.prgb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb027
            
            #add-point:AFTER FIELD prgb027 name="input.a.page1.prgb027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb027
            #add-point:ON CHANGE prgb027 name="input.g.page1.prgb027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb028
            #add-point:BEFORE FIELD prgb028 name="input.b.page1.prgb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb028
            
            #add-point:AFTER FIELD prgb028 name="input.a.page1.prgb028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb028
            #add-point:ON CHANGE prgb028 name="input.g.page1.prgb028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb029
            #add-point:BEFORE FIELD prgb029 name="input.b.page1.prgb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb029
            
            #add-point:AFTER FIELD prgb029 name="input.a.page1.prgb029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb029
            #add-point:ON CHANGE prgb029 name="input.g.page1.prgb029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb030
            #add-point:BEFORE FIELD prgb030 name="input.b.page1.prgb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb030
            
            #add-point:AFTER FIELD prgb030 name="input.a.page1.prgb030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb030
            #add-point:ON CHANGE prgb030 name="input.g.page1.prgb030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb031
            #add-point:BEFORE FIELD prgb031 name="input.b.page1.prgb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb031
            
            #add-point:AFTER FIELD prgb031 name="input.a.page1.prgb031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb031
            #add-point:ON CHANGE prgb031 name="input.g.page1.prgb031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb032
            #add-point:BEFORE FIELD prgb032 name="input.b.page1.prgb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb032
            
            #add-point:AFTER FIELD prgb032 name="input.a.page1.prgb032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb032
            #add-point:ON CHANGE prgb032 name="input.g.page1.prgb032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgb033
            #add-point:BEFORE FIELD prgb033 name="input.b.page1.prgb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgb033
            
            #add-point:AFTER FIELD prgb033 name="input.a.page1.prgb033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgb033
            #add-point:ON CHANGE prgb033 name="input.g.page1.prgb033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgbunit
            #add-point:BEFORE FIELD prgbunit name="input.b.page1.prgbunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgbunit
            
            #add-point:AFTER FIELD prgbunit name="input.a.page1.prgbunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgbunit
            #add-point:ON CHANGE prgbunit name="input.g.page1.prgbunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prgbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgbseq
            #add-point:ON ACTION controlp INFIELD prgbseq name="input.c.page1.prgbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb001
            #add-point:ON ACTION controlp INFIELD prgb001 name="input.c.page1.prgb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb002
            #add-point:ON ACTION controlp INFIELD prgb002 name="input.c.page1.prgb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgbsite
            #add-point:ON ACTION controlp INFIELD prgbsite name="input.c.page1.prgbsite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prgb_d[l_ac].prgbsite             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_prga_m.prgasite #
#            LET g_qryparam.arg2 = "8" #
            
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prgbsite',g_prga_m.prgasite,'i')   #150308-00001#4 150309 by lori522612 add 'c'
#            CALL q_ooed004_3()                                #呼叫開窗
            CALL q_ooef001_24()

            LET g_prgb_d[l_ac].prgbsite = g_qryparam.return1
#            LET g_prgb_d[l_ac].prgbsite_desc = g_qryparam.return2            

            DISPLAY g_prgb_d[l_ac].prgbsite TO prgbsite              #
#            DISPLAY g_prgb_d[l_ac].prgbsite_desc TO prgbsite_desc
            CALL s_desc_get_department_desc(g_prgb_d[l_ac].prgbsite)
               RETURNING g_prgb_d[l_ac].prgbsite_desc
            DISPLAY g_prgb_d[l_ac].prgbsite_desc TO prgbsite_desc

            NEXT FIELD prgbsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb003
            #add-point:ON ACTION controlp INFIELD prgb003 name="input.c.page1.prgb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb004
            #add-point:ON ACTION controlp INFIELD prgb004 name="input.c.page1.prgb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb005
            #add-point:ON ACTION controlp INFIELD prgb005 name="input.c.page1.prgb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb006
            #add-point:ON ACTION controlp INFIELD prgb006 name="input.c.page1.prgb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb007
            #add-point:ON ACTION controlp INFIELD prgb007 name="input.c.page1.prgb007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prgb_d[l_ac].prgb007             #給予default值
            LET g_qryparam.default2 = g_prgb_d[l_ac].prgb007_desc #交易對象簡稱
            #給予arg
            LET g_qryparam.arg1 = g_prga_m.prga006
            CALL q_pmaa001_22()
            LET g_prgb_d[l_ac].prgb007 = g_qryparam.return1              
            LET g_prgb_d[l_ac].prgb007_desc = g_qryparam.return2 
            DISPLAY g_prgb_d[l_ac].prgb007 TO prgb007              #
            DISPLAY g_prgb_d[l_ac].prgb007_desc TO prgb007_desc #交易對象簡稱
            NEXT FIELD prgb007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb009
            #add-point:ON ACTION controlp INFIELD prgb009 name="input.c.page1.prgb009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prgb_d[l_ac].prgb009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.WHERE = " imay003 IN(SELECT stas004 FROM stas_t,star_t WHERE starent = stasent AND star001 = stas001",
                                   "                                                AND starent = '",g_enterprise,"'",
                                   "                                                AND starsite = '",g_prgb_d[l_ac].prgbsite,"'",
                                   "                                                AND star003 = '",g_prga_m.prga006,"'",
                                   "                                                AND star004 = '",g_prga_m.prga004,"')"
            
            CALL q_imay003_2()                                #呼叫開窗

            LET g_prgb_d[l_ac].prgb009 = g_qryparam.return1              

            DISPLAY g_prgb_d[l_ac].prgb009 TO prgb009              #

            NEXT FIELD prgb009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb008
            #add-point:ON ACTION controlp INFIELD prgb008 name="input.c.page1.prgb008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prgb_d[l_ac].prgb008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_prgb_d[l_ac].prgbsite
            LET g_qryparam.WHERE = " rtdx001 IN(SELECT stas003 FROM stas_t,star_t WHERE starent = stasent AND star001 = stas001",
                                   "                                                AND starent = '",g_enterprise,"'",
                                   "                                                AND starsite = '",g_prgb_d[l_ac].prgbsite,"'",
                                   "                                                AND star003 = '",g_prga_m.prga006,"'",
                                   "                                                AND star004 = '",g_prga_m.prga004,"')"
            CALL q_rtdx001_1()                                #呼叫開窗

            LET g_prgb_d[l_ac].prgb008 = g_qryparam.return1              

            DISPLAY g_prgb_d[l_ac].prgb008 TO prgb008              #

            NEXT FIELD prgb008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb010
            #add-point:ON ACTION controlp INFIELD prgb010 name="input.c.page1.prgb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb011
            #add-point:ON ACTION controlp INFIELD prgb011 name="input.c.page1.prgb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb012
            #add-point:ON ACTION controlp INFIELD prgb012 name="input.c.page1.prgb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb013
            #add-point:ON ACTION controlp INFIELD prgb013 name="input.c.page1.prgb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb014
            #add-point:ON ACTION controlp INFIELD prgb014 name="input.c.page1.prgb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb015
            #add-point:ON ACTION controlp INFIELD prgb015 name="input.c.page1.prgb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb016
            #add-point:ON ACTION controlp INFIELD prgb016 name="input.c.page1.prgb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb034
            #add-point:ON ACTION controlp INFIELD prgb034 name="input.c.page1.prgb034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb017
            #add-point:ON ACTION controlp INFIELD prgb017 name="input.c.page1.prgb017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb018
            #add-point:ON ACTION controlp INFIELD prgb018 name="input.c.page1.prgb018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb035
            #add-point:ON ACTION controlp INFIELD prgb035 name="input.c.page1.prgb035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb019
            #add-point:ON ACTION controlp INFIELD prgb019 name="input.c.page1.prgb019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb020
            #add-point:ON ACTION controlp INFIELD prgb020 name="input.c.page1.prgb020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb021
            #add-point:ON ACTION controlp INFIELD prgb021 name="input.c.page1.prgb021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb022
            #add-point:ON ACTION controlp INFIELD prgb022 name="input.c.page1.prgb022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb023
            #add-point:ON ACTION controlp INFIELD prgb023 name="input.c.page1.prgb023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb024
            #add-point:ON ACTION controlp INFIELD prgb024 name="input.c.page1.prgb024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb025
            #add-point:ON ACTION controlp INFIELD prgb025 name="input.c.page1.prgb025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb026
            #add-point:ON ACTION controlp INFIELD prgb026 name="input.c.page1.prgb026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb027
            #add-point:ON ACTION controlp INFIELD prgb027 name="input.c.page1.prgb027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb028
            #add-point:ON ACTION controlp INFIELD prgb028 name="input.c.page1.prgb028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb029
            #add-point:ON ACTION controlp INFIELD prgb029 name="input.c.page1.prgb029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb030
            #add-point:ON ACTION controlp INFIELD prgb030 name="input.c.page1.prgb030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb031
            #add-point:ON ACTION controlp INFIELD prgb031 name="input.c.page1.prgb031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb032
            #add-point:ON ACTION controlp INFIELD prgb032 name="input.c.page1.prgb032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgb033
            #add-point:ON ACTION controlp INFIELD prgb033 name="input.c.page1.prgb033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prgbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgbunit
            #add-point:ON ACTION controlp INFIELD prgbunit name="input.c.page1.prgbunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prgb_d[l_ac].* = g_prgb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt601_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prgb_d[l_ac].prgbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prgb_d[l_ac].* = g_prgb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt601_prgb_t_mask_restore('restore_mask_o')
      
               UPDATE prgb_t SET (prgbdocno,prgbseq,prgb001,prgb002,prgbsite,prgb003,prgb004,prgb005, 
                   prgb006,prgb007,prgb009,prgb008,prgb010,prgb011,prgb012,prgb013,prgb014,prgb015,prgb016, 
                   prgb034,prgb017,prgb018,prgb035,prgb019,prgb020,prgb021,prgb022,prgb023,prgb024,prgb025, 
                   prgb026,prgb027,prgb028,prgb029,prgb030,prgb031,prgb032,prgb033,prgbunit) = (g_prga_m.prgadocno, 
                   g_prgb_d[l_ac].prgbseq,g_prgb_d[l_ac].prgb001,g_prgb_d[l_ac].prgb002,g_prgb_d[l_ac].prgbsite, 
                   g_prgb_d[l_ac].prgb003,g_prgb_d[l_ac].prgb004,g_prgb_d[l_ac].prgb005,g_prgb_d[l_ac].prgb006, 
                   g_prgb_d[l_ac].prgb007,g_prgb_d[l_ac].prgb009,g_prgb_d[l_ac].prgb008,g_prgb_d[l_ac].prgb010, 
                   g_prgb_d[l_ac].prgb011,g_prgb_d[l_ac].prgb012,g_prgb_d[l_ac].prgb013,g_prgb_d[l_ac].prgb014, 
                   g_prgb_d[l_ac].prgb015,g_prgb_d[l_ac].prgb016,g_prgb_d[l_ac].prgb034,g_prgb_d[l_ac].prgb017, 
                   g_prgb_d[l_ac].prgb018,g_prgb_d[l_ac].prgb035,g_prgb_d[l_ac].prgb019,g_prgb_d[l_ac].prgb020, 
                   g_prgb_d[l_ac].prgb021,g_prgb_d[l_ac].prgb022,g_prgb_d[l_ac].prgb023,g_prgb_d[l_ac].prgb024, 
                   g_prgb_d[l_ac].prgb025,g_prgb_d[l_ac].prgb026,g_prgb_d[l_ac].prgb027,g_prgb_d[l_ac].prgb028, 
                   g_prgb_d[l_ac].prgb029,g_prgb_d[l_ac].prgb030,g_prgb_d[l_ac].prgb031,g_prgb_d[l_ac].prgb032, 
                   g_prgb_d[l_ac].prgb033,g_prgb_d[l_ac].prgbunit)
                WHERE prgbent = g_enterprise AND prgbdocno = g_prga_m.prgadocno 
 
                  AND prgbseq = g_prgb_d_t.prgbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prgb_d[l_ac].* = g_prgb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prgb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prgb_d[l_ac].* = g_prgb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prgb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prga_m.prgadocno
               LET gs_keys_bak[1] = g_prgadocno_t
               LET gs_keys[2] = g_prgb_d[g_detail_idx].prgbseq
               LET gs_keys_bak[2] = g_prgb_d_t.prgbseq
               CALL aprt601_update_b('prgb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt601_prgb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prgb_d[g_detail_idx].prgbseq = g_prgb_d_t.prgbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_prga_m.prgadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prgb_d_t.prgbseq
 
                  CALL aprt601_key_update_b(gs_keys,'prgb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prga_m),util.JSON.stringify(g_prgb_d_t)
               LET g_log2 = util.JSON.stringify(g_prga_m),util.JSON.stringify(g_prgb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprt601_unlock_b("prgb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            CALL aprt601_show()
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            #add by yangxf ---start---
#            IF NOT aprt601_accept_chk() THEN 
#               NEXT FIELD CURRENT 
#            END IF 
            #add by yangxf ---end---
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prgb_d[li_reproduce_target].* = g_prgb_d[li_reproduce].*
 
               LET g_prgb_d[li_reproduce_target].prgbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prgb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prgb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_prgb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL aprt601_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL aprt601_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="aprt601.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD prgasite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prgbseq
 
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD prgadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prgbseq
               WHEN "s_detail2"
                  NEXT FIELD prgcsite
 
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
   #add by yangxf ---start---
#   IF NOT aprt601_accept_chk() THEN 
#      CALL aprt601_input("u")
#   END IF 
   #add by yangxf ---end---
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aprt601.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt601_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_total   LIKE type_t.num20_6
   DEFINE l_msg     LIKE type_t.chr50   #151013-00001#43 dongsz add
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt601_b_fill() #單身填充
      CALL aprt601_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt601_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL aprt601_prga012_ref()
   #end add-point
   
   #遮罩相關處理
   LET g_prga_m_mask_o.* =  g_prga_m.*
   CALL aprt601_prga_t_mask()
   LET g_prga_m_mask_n.* =  g_prga_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prga_m.prgasite,g_prga_m.prgasite_desc,g_prga_m.prgadocdt,g_prga_m.prgadocno,g_prga_m.prga002, 
       g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga006_desc,g_prga_m.prga013,g_prga_m.prga009, 
       g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga011_desc,g_prga_m.prga012, 
       g_prga_m.prga012_desc,g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga007_desc,g_prga_m.prga008, 
       g_prga_m.prga008_desc,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.total,g_prga_m.prga015,g_prga_m.prga015_desc, 
       g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp,g_prga_m.prgaowndp_desc, 
       g_prga_m.prgacrtid,g_prga_m.prgacrtid_desc,g_prga_m.prgacrtdp,g_prga_m.prgacrtdp_desc,g_prga_m.prgacrtdt, 
       g_prga_m.prgamodid,g_prga_m.prgamodid_desc,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfid_desc, 
       g_prga_m.prgacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prga_m.prgastus 
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
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_prgb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_prgb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt601_detail_show()
 
   #add-point:show段之後 name="show.after"
   SELECT SUM(prgb018) INTO l_total FROM prgb_t
    WHERE prgbent = g_enterprise AND prgbdocno = g_prga_m.prgadocno
   IF cl_null(l_total ) THEN
      LET g_prga_m.total = 0
   END IF
   LET g_prga_m.total = l_total
   DISPLAY BY NAME g_prga_m.total
   #add by yangxf ---start---
   #aprt601补差规则 1.数量补差则，隐藏单身原进价与本次进价 2.基准进价则，本次补差关闭输入状态
   #IF g_prog = 'aprt603' THEN        #160705-00042#10 160713 by sakura mark 
   IF g_prog MATCHES 'aprt603' THEN   #160705-00042#10 160713 by sakura add
      IF g_prga_m.prga013 = '1' THEN 
         CALL cl_set_comp_visible("prgb015,prgb016,prgb034",FALSE)
         CALL cl_set_comp_entry("prgb017",TRUE)
      ELSE
         CALL cl_set_comp_visible("prgb015,prgb016,prgb034",TRUE)
         CALL cl_set_comp_entry("prgb017",FALSE)
      END IF 
   #aprt601，aprt602，aprt701补差规则 1.数量补差则，隐藏单身原进价与本次进价 、毛利率 3.毛利补差则，本次补差关闭输入状态
   ELSE
      IF g_prga_m.prga013 = '1' THEN 
         CALL cl_set_comp_visible("prgb015,prgb016",FALSE)
         CALL cl_set_comp_entry("prgb017",TRUE)
      ELSE
         #160809-00046#2 -s by 08172
#         CALL cl_set_comp_visible("prgb015,prgb016",TRUE)
         CALL cl_set_comp_visible("prgb016",TRUE)
         CALL cl_set_comp_visible("prgb015",FALSE)
         #160809-00046#2 -e by 08172
         CALL cl_set_comp_entry("prgb017",FALSE)
      END IF 
   END IF 
   #add by yangxf ---end---
   #151013-00001#43-dongsz add--str
   IF g_prga_m.prga013 = '2' THEN
      #本次售价-->本次进价
      CALL cl_getmsg('apr-00508',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prgb016",l_msg CLIPPED)
   ELSE
      #本次售价
      CALL cl_getmsg('apr-00375',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prgb016",l_msg CLIPPED)
   END IF
   #151013-00001#43-dongsz add--end
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt601_detail_show()
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
 
{<section id="aprt601.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt601_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prga_t.prgadocno 
   DEFINE l_oldno     LIKE prga_t.prgadocno 
 
   DEFINE l_master    RECORD LIKE prga_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prgb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE prgc_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
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
   
   IF g_prga_m.prgadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prgadocno_t = g_prga_m.prgadocno
 
    
   LET g_prga_m.prgadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prga_m.prgaownid = g_user
      LET g_prga_m.prgaowndp = g_dept
      LET g_prga_m.prgacrtid = g_user
      LET g_prga_m.prgacrtdp = g_dept 
      LET g_prga_m.prgacrtdt = cl_get_current()
      LET g_prga_m.prgamodid = g_user
      LET g_prga_m.prgamoddt = cl_get_current()
      LET g_prga_m.prgastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #dongsz--add--str---
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_prga_m.prgasite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_prga_m.prgadocno = r_doctype
   #dongsz--add--end---
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prga_m.prgastus 
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
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aprt601_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prga_m.* TO NULL
      INITIALIZE g_prgb_d TO NULL
      INITIALIZE g_prgb2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt601_show()
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
   CALL aprt601_set_act_visible()   
   CALL aprt601_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prgadocno_t = g_prga_m.prgadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prgaent = " ||g_enterprise|| " AND",
                      " prgadocno = '", g_prga_m.prgadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt601_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprt601_idx_chk()
   
   LET g_data_owner = g_prga_m.prgaownid      
   LET g_data_dept  = g_prga_m.prgaowndp
   
   #功能已完成,通報訊息中心
   CALL aprt601_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt601.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt601_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prgb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE prgc_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt601_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prgb_t
    WHERE prgbent = g_enterprise AND prgbdocno = g_prgadocno_t
 
    INTO TEMP aprt601_detail
 
   #將key修正為調整後   
   UPDATE aprt601_detail 
      #更新key欄位
      SET prgbdocno = g_prga_m.prgadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prgb_t SELECT * FROM aprt601_detail
   
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
   DROP TABLE aprt601_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prgc_t 
    WHERE prgcent = g_enterprise AND prgcdocno = g_prgadocno_t
 
    INTO TEMP aprt601_detail
 
   #將key修正為調整後   
   UPDATE aprt601_detail SET prgcdocno = g_prga_m.prgadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prgc_t SELECT * FROM aprt601_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprt601_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prgadocno_t = g_prga_m.prgadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt601_delete()
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
   
   IF g_prga_m.prgadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aprt601_cl USING g_enterprise,g_prga_m.prgadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt601_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt601_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt601_master_referesh USING g_prga_m.prgadocno INTO g_prga_m.prgasite,g_prga_m.prgadocdt, 
       g_prga_m.prgadocno,g_prga_m.prga002,g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013, 
       g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga012, 
       g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.prga015, 
       g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaowndp,g_prga_m.prgacrtid,g_prga_m.prgacrtdp, 
       g_prga_m.prgacrtdt,g_prga_m.prgamodid,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfdt, 
       g_prga_m.prgasite_desc,g_prga_m.prga006_desc,g_prga_m.prga011_desc,g_prga_m.prga007_desc,g_prga_m.prga008_desc, 
       g_prga_m.prga015_desc,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp_desc,g_prga_m.prgacrtid_desc, 
       g_prga_m.prgacrtdp_desc,g_prga_m.prgamodid_desc,g_prga_m.prgacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aprt601_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prga_m_mask_o.* =  g_prga_m.*
   CALL aprt601_prga_t_mask()
   LET g_prga_m_mask_n.* =  g_prga_m.*
   
   CALL aprt601_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt601_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prgadocno_t = g_prga_m.prgadocno
 
 
      DELETE FROM prga_t
       WHERE prgaent = g_enterprise AND prgadocno = g_prga_m.prgadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prga_m.prgadocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM prgb_t
       WHERE prgbent = g_enterprise AND prgbdocno = g_prga_m.prgadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prgb_t:",SQLERRMESSAGE 
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
      DELETE FROM prgc_t
       WHERE prgcent = g_enterprise AND
             prgcdocno = g_prga_m.prgadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prgc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prga_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt601_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prgb_d.clear() 
      CALL g_prgb2_d.clear()       
 
     
      CALL aprt601_ui_browser_refresh()  
      #CALL aprt601_ui_headershow()  
      #CALL aprt601_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt601_browser_fill("")
         CALL aprt601_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt601_cl
 
   #功能已完成,通報訊息中心
   CALL aprt601_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt601.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt601_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_prgb001              LIKE prgb_t.prgb001    #add by yangxf
   
   #add by yangxf ---start---
   #1.采购补差 2.库存补差 3.销售补差 21.销售补差
   CASE 
      #WHEN g_prog = 'aprt601'       #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt601'  #160705-00042#10 160713 by sakura add
           LET l_prgb001 = '1'
      #WHEN g_prog = 'aprt602'       #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt602'  #160705-00042#10 160713 by sakura add
           LET l_prgb001 = '2'
      #WHEN g_prog = 'aprt603'       #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt603'  #160705-00042#10 160713 by sakura add
           LET l_prgb001 = '3'
      #WHEN g_prog = 'aprt701'       #160705-00042#10 160713 by sakura mark
      WHEN g_prog MATCHES 'aprt701'  #160705-00042#10 160713 by sakura add
           LET l_prgb001 = '21'
   END CASE 
   #add by yangxf ---end------
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prgb_d.clear()
   CALL g_prgb2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aprt601_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prgbseq,prgb001,prgb002,prgbsite,prgb003,prgb004,prgb005,prgb006, 
             prgb007,prgb009,prgb008,prgb010,prgb011,prgb012,prgb013,prgb014,prgb015,prgb016,prgb034, 
             prgb017,prgb018,prgb035,prgb019,prgb020,prgb021,prgb022,prgb023,prgb024,prgb025,prgb026, 
             prgb027,prgb028,prgb029,prgb030,prgb031,prgb032,prgb033,prgbunit ,t1.ooefl003 ,t2.pmaal004 , 
             t3.imaal003 ,t4.imaal004 ,t5.oocal003 FROM prgb_t",   
                     " INNER JOIN prga_t ON prgaent = " ||g_enterprise|| " AND prgadocno = prgbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=prgbsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=prgb007 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=prgb008 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=prgb008 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=prgb013 AND t5.oocal002='"||g_dlang||"' ",
 
                     " WHERE prgbent=? AND prgbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
#      LET g_sql = g_sql," AND prgb001 = '1' "                  #mark by yangxf
         LET g_sql = g_sql," AND prgb001 = '",l_prgb001,"' "    #add by yangxf
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prgb_t.prgbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt601_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt601_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prga_m.prgadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prga_m.prgadocno INTO g_prgb_d[l_ac].prgbseq,g_prgb_d[l_ac].prgb001, 
          g_prgb_d[l_ac].prgb002,g_prgb_d[l_ac].prgbsite,g_prgb_d[l_ac].prgb003,g_prgb_d[l_ac].prgb004, 
          g_prgb_d[l_ac].prgb005,g_prgb_d[l_ac].prgb006,g_prgb_d[l_ac].prgb007,g_prgb_d[l_ac].prgb009, 
          g_prgb_d[l_ac].prgb008,g_prgb_d[l_ac].prgb010,g_prgb_d[l_ac].prgb011,g_prgb_d[l_ac].prgb012, 
          g_prgb_d[l_ac].prgb013,g_prgb_d[l_ac].prgb014,g_prgb_d[l_ac].prgb015,g_prgb_d[l_ac].prgb016, 
          g_prgb_d[l_ac].prgb034,g_prgb_d[l_ac].prgb017,g_prgb_d[l_ac].prgb018,g_prgb_d[l_ac].prgb035, 
          g_prgb_d[l_ac].prgb019,g_prgb_d[l_ac].prgb020,g_prgb_d[l_ac].prgb021,g_prgb_d[l_ac].prgb022, 
          g_prgb_d[l_ac].prgb023,g_prgb_d[l_ac].prgb024,g_prgb_d[l_ac].prgb025,g_prgb_d[l_ac].prgb026, 
          g_prgb_d[l_ac].prgb027,g_prgb_d[l_ac].prgb028,g_prgb_d[l_ac].prgb029,g_prgb_d[l_ac].prgb030, 
          g_prgb_d[l_ac].prgb031,g_prgb_d[l_ac].prgb032,g_prgb_d[l_ac].prgb033,g_prgb_d[l_ac].prgbunit, 
          g_prgb_d[l_ac].prgbsite_desc,g_prgb_d[l_ac].prgb007_desc,g_prgb_d[l_ac].prgb008_desc,g_prgb_d[l_ac].prgb008_desc_desc, 
          g_prgb_d[l_ac].prgb013_desc   #(ver:78)
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
   IF aprt601_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prgcsite,prgcunit,prgcseq,prgcseq1,prgc001,prgc012,prgc013,prgc014, 
             prgc002,prgc003,prgc004,prgc005,prgc006,prgc007,prgc008,prgc009,prgc010,prgc011  FROM prgc_t", 
                
                     " INNER JOIN  prga_t ON prgaent = " ||g_enterprise|| " AND prgadocno = prgcdocno ",
 
                     "",
                     
                     
                     " WHERE prgcent=? AND prgcdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prgc_t.prgcseq,prgc_t.prgcseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt601_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aprt601_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_prga_m.prgadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_prga_m.prgadocno INTO g_prgb2_d[l_ac].prgcsite,g_prgb2_d[l_ac].prgcunit, 
          g_prgb2_d[l_ac].prgcseq,g_prgb2_d[l_ac].prgcseq1,g_prgb2_d[l_ac].prgc001,g_prgb2_d[l_ac].prgc012, 
          g_prgb2_d[l_ac].prgc013,g_prgb2_d[l_ac].prgc014,g_prgb2_d[l_ac].prgc002,g_prgb2_d[l_ac].prgc003, 
          g_prgb2_d[l_ac].prgc004,g_prgb2_d[l_ac].prgc005,g_prgb2_d[l_ac].prgc006,g_prgb2_d[l_ac].prgc007, 
          g_prgb2_d[l_ac].prgc008,g_prgb2_d[l_ac].prgc009,g_prgb2_d[l_ac].prgc010,g_prgb2_d[l_ac].prgc011  
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
   
   #end add-point
   
   CALL g_prgb_d.deleteElement(g_prgb_d.getLength())
   CALL g_prgb2_d.deleteElement(g_prgb2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt601_pb
   FREE aprt601_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prgb_d.getLength()
      LET g_prgb_d_mask_o[l_ac].* =  g_prgb_d[l_ac].*
      CALL aprt601_prgb_t_mask()
      LET g_prgb_d_mask_n[l_ac].* =  g_prgb_d[l_ac].*
   END FOR
   
   LET g_prgb2_d_mask_o.* =  g_prgb2_d.*
   FOR l_ac = 1 TO g_prgb2_d.getLength()
      LET g_prgb2_d_mask_o[l_ac].* =  g_prgb2_d[l_ac].*
      CALL aprt601_prgc_t_mask()
      LET g_prgb2_d_mask_n[l_ac].* =  g_prgb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt601.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt601_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prgb_t
       WHERE prgbent = g_enterprise AND
         prgbdocno = ps_keys_bak[1] AND prgbseq = ps_keys_bak[2]
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
         CALL g_prgb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM prgc_t
       WHERE prgcent = g_enterprise AND
             prgcdocno = ps_keys_bak[1] AND prgcseq = ps_keys_bak[2] AND prgcseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prgc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_prgb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt601_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prgb_t
                  (prgbent,
                   prgbdocno,
                   prgbseq
                   ,prgb001,prgb002,prgbsite,prgb003,prgb004,prgb005,prgb006,prgb007,prgb009,prgb008,prgb010,prgb011,prgb012,prgb013,prgb014,prgb015,prgb016,prgb034,prgb017,prgb018,prgb035,prgb019,prgb020,prgb021,prgb022,prgb023,prgb024,prgb025,prgb026,prgb027,prgb028,prgb029,prgb030,prgb031,prgb032,prgb033,prgbunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prgb_d[g_detail_idx].prgb001,g_prgb_d[g_detail_idx].prgb002,g_prgb_d[g_detail_idx].prgbsite, 
                       g_prgb_d[g_detail_idx].prgb003,g_prgb_d[g_detail_idx].prgb004,g_prgb_d[g_detail_idx].prgb005, 
                       g_prgb_d[g_detail_idx].prgb006,g_prgb_d[g_detail_idx].prgb007,g_prgb_d[g_detail_idx].prgb009, 
                       g_prgb_d[g_detail_idx].prgb008,g_prgb_d[g_detail_idx].prgb010,g_prgb_d[g_detail_idx].prgb011, 
                       g_prgb_d[g_detail_idx].prgb012,g_prgb_d[g_detail_idx].prgb013,g_prgb_d[g_detail_idx].prgb014, 
                       g_prgb_d[g_detail_idx].prgb015,g_prgb_d[g_detail_idx].prgb016,g_prgb_d[g_detail_idx].prgb034, 
                       g_prgb_d[g_detail_idx].prgb017,g_prgb_d[g_detail_idx].prgb018,g_prgb_d[g_detail_idx].prgb035, 
                       g_prgb_d[g_detail_idx].prgb019,g_prgb_d[g_detail_idx].prgb020,g_prgb_d[g_detail_idx].prgb021, 
                       g_prgb_d[g_detail_idx].prgb022,g_prgb_d[g_detail_idx].prgb023,g_prgb_d[g_detail_idx].prgb024, 
                       g_prgb_d[g_detail_idx].prgb025,g_prgb_d[g_detail_idx].prgb026,g_prgb_d[g_detail_idx].prgb027, 
                       g_prgb_d[g_detail_idx].prgb028,g_prgb_d[g_detail_idx].prgb029,g_prgb_d[g_detail_idx].prgb030, 
                       g_prgb_d[g_detail_idx].prgb031,g_prgb_d[g_detail_idx].prgb032,g_prgb_d[g_detail_idx].prgb033, 
                       g_prgb_d[g_detail_idx].prgbunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prgb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prgb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO prgc_t
                  (prgcent,
                   prgcdocno,
                   prgcseq,prgcseq1
                   ,prgcsite,prgcunit,prgc001,prgc012,prgc013,prgc014,prgc002,prgc003,prgc004,prgc005,prgc006,prgc007,prgc008,prgc009,prgc010,prgc011) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_prgb2_d[g_detail_idx].prgcsite,g_prgb2_d[g_detail_idx].prgcunit,g_prgb2_d[g_detail_idx].prgc001, 
                       g_prgb2_d[g_detail_idx].prgc012,g_prgb2_d[g_detail_idx].prgc013,g_prgb2_d[g_detail_idx].prgc014, 
                       g_prgb2_d[g_detail_idx].prgc002,g_prgb2_d[g_detail_idx].prgc003,g_prgb2_d[g_detail_idx].prgc004, 
                       g_prgb2_d[g_detail_idx].prgc005,g_prgb2_d[g_detail_idx].prgc006,g_prgb2_d[g_detail_idx].prgc007, 
                       g_prgb2_d[g_detail_idx].prgc008,g_prgb2_d[g_detail_idx].prgc009,g_prgb2_d[g_detail_idx].prgc010, 
                       g_prgb2_d[g_detail_idx].prgc011)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prgc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_prgb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt601_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prgb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt601_prgb_t_mask_restore('restore_mask_o')
               
      UPDATE prgb_t 
         SET (prgbdocno,
              prgbseq
              ,prgb001,prgb002,prgbsite,prgb003,prgb004,prgb005,prgb006,prgb007,prgb009,prgb008,prgb010,prgb011,prgb012,prgb013,prgb014,prgb015,prgb016,prgb034,prgb017,prgb018,prgb035,prgb019,prgb020,prgb021,prgb022,prgb023,prgb024,prgb025,prgb026,prgb027,prgb028,prgb029,prgb030,prgb031,prgb032,prgb033,prgbunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prgb_d[g_detail_idx].prgb001,g_prgb_d[g_detail_idx].prgb002,g_prgb_d[g_detail_idx].prgbsite, 
                  g_prgb_d[g_detail_idx].prgb003,g_prgb_d[g_detail_idx].prgb004,g_prgb_d[g_detail_idx].prgb005, 
                  g_prgb_d[g_detail_idx].prgb006,g_prgb_d[g_detail_idx].prgb007,g_prgb_d[g_detail_idx].prgb009, 
                  g_prgb_d[g_detail_idx].prgb008,g_prgb_d[g_detail_idx].prgb010,g_prgb_d[g_detail_idx].prgb011, 
                  g_prgb_d[g_detail_idx].prgb012,g_prgb_d[g_detail_idx].prgb013,g_prgb_d[g_detail_idx].prgb014, 
                  g_prgb_d[g_detail_idx].prgb015,g_prgb_d[g_detail_idx].prgb016,g_prgb_d[g_detail_idx].prgb034, 
                  g_prgb_d[g_detail_idx].prgb017,g_prgb_d[g_detail_idx].prgb018,g_prgb_d[g_detail_idx].prgb035, 
                  g_prgb_d[g_detail_idx].prgb019,g_prgb_d[g_detail_idx].prgb020,g_prgb_d[g_detail_idx].prgb021, 
                  g_prgb_d[g_detail_idx].prgb022,g_prgb_d[g_detail_idx].prgb023,g_prgb_d[g_detail_idx].prgb024, 
                  g_prgb_d[g_detail_idx].prgb025,g_prgb_d[g_detail_idx].prgb026,g_prgb_d[g_detail_idx].prgb027, 
                  g_prgb_d[g_detail_idx].prgb028,g_prgb_d[g_detail_idx].prgb029,g_prgb_d[g_detail_idx].prgb030, 
                  g_prgb_d[g_detail_idx].prgb031,g_prgb_d[g_detail_idx].prgb032,g_prgb_d[g_detail_idx].prgb033, 
                  g_prgb_d[g_detail_idx].prgbunit) 
         WHERE prgbent = g_enterprise AND prgbdocno = ps_keys_bak[1] AND prgbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prgb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prgb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt601_prgb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prgc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprt601_prgc_t_mask_restore('restore_mask_o')
               
      UPDATE prgc_t 
         SET (prgcdocno,
              prgcseq,prgcseq1
              ,prgcsite,prgcunit,prgc001,prgc012,prgc013,prgc014,prgc002,prgc003,prgc004,prgc005,prgc006,prgc007,prgc008,prgc009,prgc010,prgc011) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_prgb2_d[g_detail_idx].prgcsite,g_prgb2_d[g_detail_idx].prgcunit,g_prgb2_d[g_detail_idx].prgc001, 
                  g_prgb2_d[g_detail_idx].prgc012,g_prgb2_d[g_detail_idx].prgc013,g_prgb2_d[g_detail_idx].prgc014, 
                  g_prgb2_d[g_detail_idx].prgc002,g_prgb2_d[g_detail_idx].prgc003,g_prgb2_d[g_detail_idx].prgc004, 
                  g_prgb2_d[g_detail_idx].prgc005,g_prgb2_d[g_detail_idx].prgc006,g_prgb2_d[g_detail_idx].prgc007, 
                  g_prgb2_d[g_detail_idx].prgc008,g_prgb2_d[g_detail_idx].prgc009,g_prgb2_d[g_detail_idx].prgc010, 
                  g_prgb2_d[g_detail_idx].prgc011) 
         WHERE prgcent = g_enterprise AND prgcdocno = ps_keys_bak[1] AND prgcseq = ps_keys_bak[2] AND prgcseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prgc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prgc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt601_prgc_t_mask_restore('restore_mask_n')
 
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
 
{<section id="aprt601.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt601_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt601.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt601_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt601.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt601_lock_b(ps_table,ps_page)
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
   #CALL aprt601_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prgb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt601_bcl USING g_enterprise,
                                       g_prga_m.prgadocno,g_prgb_d[g_detail_idx].prgbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt601_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "prgc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprt601_bcl2 USING g_enterprise,
                                             g_prga_m.prgadocno,g_prgb2_d[g_detail_idx].prgcseq,g_prgb2_d[g_detail_idx].prgcseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt601_bcl2:",SQLERRMESSAGE 
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
 
{<section id="aprt601.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt601_unlock_b(ps_table,ps_page)
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
      CLOSE aprt601_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprt601_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt601.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt601_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("prgadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prgadocno",TRUE)
      CALL cl_set_comp_entry("prgadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("prgasite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("prga004,prga006,prga009,prga010,prga013",TRUE)
   #add by yangxf ---start---
   #aprt601补差规则 1.数量补差则，隐藏单身原进价与本次进价 2.基准进价则，本次补差关闭输入状态
   #IF g_prog = 'aprt603' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'aprt603' THEN   #160705-00042#10 160713 by sakura add
      IF g_prga_m.prga013 = '1' THEN 
         CALL cl_set_comp_visible("prgb015,prgb016,prgb034",FALSE)
         CALL cl_set_comp_entry("prgb017",TRUE)
      END IF 
      IF g_prga_m.prga013 = '3' THEN 
         CALL cl_set_comp_visible("prgb034",TRUE)
         CALL cl_set_comp_entry("prgb015,prgb016,prgb017",FALSE)
      END IF 
      IF g_prga_m.prga013 = '4' THEN 
         CALL cl_set_comp_visible("prgb016",TRUE)
         CALL cl_set_comp_entry("prgb015,prgb034,prgb017",FALSE)
      END IF 
      CALL cl_set_comp_visible("prgb015",FALSE)
   #aprt601，aprt602，aprt701补差规则 1.数量补差则，隐藏单身原进价与本次进价 、毛利率 3.毛利补差则，本次补差关闭输入状态
   ELSE
      IF g_prga_m.prga013 = '1' THEN 
         CALL cl_set_comp_visible("prgb015,prgb016",FALSE)
         CALL cl_set_comp_entry("prgb017",TRUE)
      ELSE
         #160809-00046#2 -s by 08172
#         CALL cl_set_comp_visible("prgb015,prgb016",TRUE)
         CALL cl_set_comp_visible("prgb016",TRUE)
         CALL cl_set_comp_visible("prgb015",FALSE)
         #160809-00046#2 -e by 08172
         CALL cl_set_comp_entry("prgb017",FALSE)
      END IF 
   END IF 
   #IF g_prog = 'aprt603' THEN        #160705-00042#10 160713 by sakura mark 
   IF g_prog MATCHES 'aprt603' THEN   #160705-00042#10 160713 by sakura add
      IF g_prga_m.prga013 = '2' OR g_prga_m.prga013 = '4' THEN 
         CALL cl_set_comp_visible("prgc012,prgc013",TRUE)
      ELSE
         CALL cl_set_comp_visible("prgc012,prgc013",FALSE)
      END IF 
   END IF 
   #add by yangxf ---end---
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt601.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt601_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_n     LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prgadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM prgb_t
       WHERE prgbent = g_enterprise
         AND prgbdocno = g_prga_m.prgadocno
      IF l_n > 0 THEN
         CALL cl_set_comp_entry("prga004,prga006,prga009,prga010,prga013",FALSE)
      END IF   
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("prgadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("prgadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'prgasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prgasite",FALSE)
   END IF
   #IF g_prog = 'aprt602' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'aprt602' THEN   #160705-00042#10 160713 by sakura add
      CALL cl_set_comp_entry("prga009,prga010",FALSE)
   END IF 
   CALL cl_set_comp_entry("prgb015,prgb016,prgb017,prgb034",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt601.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt601_set_entry_b(p_cmd)
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
   #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
      CALL cl_set_comp_entry("prgb014",TRUE)
   END IF 
   #IF g_prog = 'aprt603' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'aprt603' THEN   #160705-00042#10 160713 by sakura add
      IF g_prga_m.prga013 = '2' THEN 
         CALL cl_set_comp_visible("prgc012,prgc013",TRUE)
      ELSE
         CALL cl_set_comp_visible("prgc012,prgc013",FALSE)
      END IF 
   END IF 
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aprt601.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt601_set_no_entry_b(p_cmd)
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
   #add by yangxf ---start---
   #aprt601补差规则 1.数量补差则，隐藏单身原进价与本次进价 2.基准进价则，本次补差关闭输入状态
   #IF g_prog = 'aprt603' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'aprt603' THEN   #160705-00042#10 160713 by sakura add
      IF g_prga_m.prga013 = '1' THEN 
         CALL cl_set_comp_visible("prgb015,prgb016,prgb034",FALSE)
         CALL cl_set_comp_entry("prgb017",TRUE)
      END IF 
      IF g_prga_m.prga013 = '3' THEN 
         CALL cl_set_comp_visible("prgb034",TRUE)
         CALL cl_set_comp_entry("prgb015,prgb016,prgb017",FALSE)
      END IF 
      IF g_prga_m.prga013 = '4' THEN 
         CALL cl_set_comp_visible("prgb016",TRUE)
         CALL cl_set_comp_entry("prgb015,prgb017,prgb034",FALSE)
      END IF 
      #151013-00001#43-dongsz add--str
      IF g_prga_m.prga013 = '2' THEN
         CALL cl_set_comp_entry("prgb016",TRUE)
         CALL cl_set_comp_entry("prgb017,prgb034",FALSE)
      END IF
      #151013-00001#43-dongsz add--end
   #aprt601，aprt602，aprt701补差规则 1.数量补差则，隐藏单身原进价与本次进价 、毛利率 3.毛利补差则，本次补差关闭输入状态
   ELSE
      IF g_prga_m.prga013 = '1' THEN 
         CALL cl_set_comp_visible("prgb015,prgb016",FALSE)
         CALL cl_set_comp_entry("prgb017",TRUE)
      ELSE
         #160809-00046#2 -s by 08172
#         CALL cl_set_comp_visible("prgb015,prgb016",TRUE)
         CALL cl_set_comp_visible("prgb016",TRUE)
         CALL cl_set_comp_visible("prgb015",FALSE)
         #160809-00046#2 -e by 08172
         CALL cl_set_comp_entry("prgb017",FALSE)
      END IF 
   END IF 
   #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark 
   IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
      CALL cl_set_comp_entry("prgb015",TRUE)
   ELSE
      CALL cl_set_comp_visible("prgb015",FALSE)
   END IF 
   CALL cl_set_comp_entry("prgbseq",FALSE)
   #add by yangxf ---end---
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aprt601.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt601_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt601_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prga_m.prgastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt601_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt601_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt601_default_search()
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
      LET ls_wc = ls_wc, " prgadocno = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "prga_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prgb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prgc_t" 
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
 
{<section id="aprt601.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt601_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #add by geza 20160122(S)  
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD       
   DEFINE ls_js        STRING
   DEFINE ls_js1       STRING    
   DEFINE l_comp       LIKE ooef_t.ooef001
   DEFINE g_glaa003    LIKE glaa_t.glaa003
   DEFINE g_glaa024    LIKE glaa_t.glaa024
   DEFINE l_stbasite   LIKE stba_t.stbasite
   DEFINE l_ooba002    LIKE ooba_t.ooba002
   DEFINE l_ooba002_1  LIKE ooba_t.ooba002
   DEFINE g_ld         LIKE apca_t.apcald
   DEFINE l_errno      LIKE type_t.chr100
   DEFINE l_pmdsdocno  LIKE pmds_t.pmdsdocno
   DEFINE l_pmdssite   LIKE pmds_t.pmdssite
   DEFINE l_pmdsdocdt  LIKE pmds_t.pmdsdocdt    
   #add by geza 20160122(E) 
   #add by 08172
   DEFINE   l_ooac002      LIKE ooac_t.ooac002
   DEFINE   l_ooac004      LIKE ooac_t.ooac004
   DEFINE   l_flag1        LIKE type_t.num5 
   #add by 08172
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prga_m.prgadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt601_cl USING g_enterprise,g_prga_m.prgadocno
   IF STATUS THEN
      CLOSE aprt601_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt601_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt601_master_referesh USING g_prga_m.prgadocno INTO g_prga_m.prgasite,g_prga_m.prgadocdt, 
       g_prga_m.prgadocno,g_prga_m.prga002,g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013, 
       g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga012, 
       g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.prga015, 
       g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaowndp,g_prga_m.prgacrtid,g_prga_m.prgacrtdp, 
       g_prga_m.prgacrtdt,g_prga_m.prgamodid,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfdt, 
       g_prga_m.prgasite_desc,g_prga_m.prga006_desc,g_prga_m.prga011_desc,g_prga_m.prga007_desc,g_prga_m.prga008_desc, 
       g_prga_m.prga015_desc,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp_desc,g_prga_m.prgacrtid_desc, 
       g_prga_m.prgacrtdp_desc,g_prga_m.prgamodid_desc,g_prga_m.prgacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aprt601_action_chk() THEN
      CLOSE aprt601_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prga_m.prgasite,g_prga_m.prgasite_desc,g_prga_m.prgadocdt,g_prga_m.prgadocno,g_prga_m.prga002, 
       g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga006_desc,g_prga_m.prga013,g_prga_m.prga009, 
       g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga011_desc,g_prga_m.prga012, 
       g_prga_m.prga012_desc,g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga007_desc,g_prga_m.prga008, 
       g_prga_m.prga008_desc,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.total,g_prga_m.prga015,g_prga_m.prga015_desc, 
       g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp,g_prga_m.prgaowndp_desc, 
       g_prga_m.prgacrtid,g_prga_m.prgacrtid_desc,g_prga_m.prgacrtdp,g_prga_m.prgacrtdp_desc,g_prga_m.prgacrtdt, 
       g_prga_m.prgamodid,g_prga_m.prgamodid_desc,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfid_desc, 
       g_prga_m.prgacnfdt
 
   CASE g_prga_m.prgastus
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
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_prga_m.prgastus
            
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
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_prga_m.prgastus
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
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN
         WHEN "Y"
            HIDE OPTION "invalid"            
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
            IF NOT aprt601_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt601_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt601_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt601_cl
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
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_prga_m.prgastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt601_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE
      WHEN lc_state = 'Y'
         #add by yangxf 20151229---start---
         #刷新单身明细
         CALL aprt601_refresh()
         #add by yangxf 20151229----end---
         CALL s_aprt601_conf_chk(g_prga_m.prgadocno,g_prga_m.prgastus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_aprt601_conf_upd(g_prga_m.prgadocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prga_m.prgadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
                  
                     #add by geza 20160122(S)   
                     #调用aapp131生成aapt320暂估单
                     IF g_prga_m.prga001 = '2' THEN
                        INITIALIZE l_pmdsdocno TO NULL
                        INITIALIZE l_pmdssite  TO NULL 
                        INITIALIZE l_pmdsdocdt TO NULL                
                        SELECT pmdsdocno,pmdssite,pmdsdocdt INTO l_pmdsdocno,l_pmdssite,l_pmdsdocdt
                          FROM pmds_t
                         WHERE pmds201 = g_prga_m.prgadocno
                           AND pmdsent = g_enterprise
                           AND pmds000 = '27'
                        #160604-00009#92 -s by 08172
                        CALL s_aooi200_get_slip(l_pmdsdocno) RETURNING l_flag1,l_ooac002
                        CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-CIR-0066') RETURNING l_ooac004
                        IF l_ooac004='Y' THEN
                        #160604-00009#92 -e by 08172
                        INITIALIZE la_param.* TO NULL 
                        LET la_param.prog = "aapp131"
                        LET la_param.param[1] = 'Y'  
                        LET la_param.param[2] = " stbc004 = '",l_pmdsdocno,"' "
                        LET la_param.param[3] = l_pmdssite 
                        CALL s_fin_orga_get_comp_ld(l_pmdssite) RETURNING l_success,l_errno,l_comp,g_ld
                        LET la_param.param[4] = g_ld
                        LET la_param.param[5] = ''
                        LET la_param.param[6] = ''
                        LET la_param.param[7] = '1'
                        LET la_param.param[8] = '1'   
                        #抓取含发票单别
                        CALL s_ld_sel_glaa(g_ld,'glaa003|glaa024') RETURNING l_success,g_glaa003,g_glaa024
                        # 170207-00018#7  2017/02/10 By 09042 mark(S)
                        #SELECT DISTINCT ooba002 INTO l_ooba002 
                        #  FROM ooba_t 
                        #  LEFT OUTER JOIN ooac_t 
                        #    ON ooacent = oobaent 
                        #   AND ooac001 = ooba001 
                        #   AND ooac002 = ooba002 
                        # WHERE oobaent = g_enterprise
                        #   AND ooba002 IN (SELECT oobl001 
                        #                     FROM oobl_t 
                        #                    WHERE ooblent = g_enterprise
                        #                      AND oobl002 = 'aapt320')
                        #   AND oobastus = 'Y' 
                        #   AND ooba001 =  g_glaa024
                        #   AND ooac003 = 'E-FINC1001' 
                        #   AND ooac004 = 'Y' 
                        #   AND rownum = 1 
                        # ORDER BY ooba002
                        # 170207-00018#7  2017/02/10 By 09042 mark(E)
                        
                        # 170207-00018#7  2017/02/10 By 09042 add(S) 
                        SELECT a.ooba002 INTO l_ooba002
                          FROM ( 
                                SELECT DISTINCT ooba002
                                  FROM ooba_t
                                  LEFT OUTER JOIN ooac_t  
                                    ON ooacent = oobaent
                                   AND ooac001 = ooba001
                                   AND ooac002 = ooba002
                                 WHERE oobaent = g_enterprise
                                   AND ooba002 IN (SELECT oobl001 
                                             FROM oobl_t 
                                            WHERE ooblent = g_enterprise
                                              AND oobl002 = 'aapt320')
                                   AND oobastus = 'Y'
                                   AND ooba001 =  g_glaa024 
                                   AND ooac003 = 'E-FINC1001'
                                   AND ooac004 = 'Y'
                                 ORDER BY ooba002   
                                ) a
                        WHERE rownum = 1;                                                                  
                        # 170207-00018#7  2017/02/10 By 09042 add(E)                          
                        LET la_param.param[9] = l_ooba002
                        #抓取不含发票单别 
                        # 170207-00018#7  2017/02/10 By 09042 mark(S)
                        #SELECT DISTINCT ooba002 INTO l_ooba002_1 
                        #  FROM ooba_t 
                        #  LEFT OUTER JOIN ooac_t 
                        #    ON ooacent = oobaent 
                        #   AND ooac001 = ooba001 
                        #   AND ooac002 = ooba002 
                        # WHERE oobaent = g_enterprise
                        #   AND ooba002 IN (SELECT oobl001 
                        #                     FROM oobl_t 
                        #                    WHERE ooblent = g_enterprise
                        #                      AND oobl002 = 'aapt320')
                        #   AND oobastus = 'Y' 
                        #   AND ooba001 =  g_glaa024
                        #   AND ooac003 = 'E-FINC1001' 
                        #   AND ooac004 = 'N' 
                        #   AND rownum = 1 
                        # ORDER BY ooba002
                        # 170207-00018#7  2017/02/10 By 09042 mark(E)
                        # 170207-00018#7  2017/02/10 By 09042 add(S) 
                        SELECT b.ooba002 INTO l_ooba002_1
                                 FROM ( 
                                       SELECT DISTINCT ooba002
                                         FROM ooba_t
                                         LEFT OUTER JOIN ooac_t  
                                           ON ooacent = oobaent
                                          AND ooac001 = ooba001
                                          AND ooac002 = ooba002
                                        WHERE oobaent = g_enterprise
                                          AND ooba002 IN (SELECT oobl001 
                                                    FROM oobl_t 
                                                   WHERE ooblent = g_enterprise
                                                     AND oobl002 = 'aapt320')
                                          AND oobastus = 'Y'
                                          AND ooba001 =  g_glaa024 
                                          AND ooac003 = 'E-FINC1001'
                                          AND ooac004 = 'N'
                                        ORDER BY ooba002   
                                       ) b
                        WHERE rownum = 1;
                        # 170207-00018#7  2017/02/10 By 09042 add(E)                        
                        LET la_param.param[10] = l_ooba002_1 
                        LET la_param.param[11] = ''   
                        LET la_param.param[12] = l_pmdsdocdt 
                        
                        LET ls_js = util.JSON.stringify(la_param)
                        CALL cl_cmdrun_wait(ls_js)
                     END IF   
                     #add by geza 20160122(E)
                  END IF
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN
         END IF
      WHEN lc_state = 'X'
         CALL s_aprt601_void_chk(g_prga_m.prgadocno,g_prga_m.prgastus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('art-00039') THEN
               CALL s_transaction_begin()
               CALL s_aprt601_void_upd(g_prga_m.prgadocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prga_m.prgadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN
         END IF
      WHEN lc_state = 'N'
         CALL s_aprt601_unconf_chk(g_prga_m.prgadocno,g_prga_m.prgastus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_begin()
               CALL s_aprt601_unconf_upd(g_prga_m.prgadocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prga_m.prgadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN
         END IF
      OTHERWISE
         CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
         RETURN
   END CASE                 {#ADP版次:1#}  
   #end add-point
   
   LET g_prga_m.prgamodid = g_user
   LET g_prga_m.prgamoddt = cl_get_current()
   LET g_prga_m.prgastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prga_t 
      SET (prgastus,prgamodid,prgamoddt) 
        = (g_prga_m.prgastus,g_prga_m.prgamodid,g_prga_m.prgamoddt)     
    WHERE prgaent = g_enterprise AND prgadocno = g_prga_m.prgadocno
 
    
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
      EXECUTE aprt601_master_referesh USING g_prga_m.prgadocno INTO g_prga_m.prgasite,g_prga_m.prgadocdt, 
          g_prga_m.prgadocno,g_prga_m.prga002,g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga013, 
          g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011,g_prga_m.prga012, 
          g_prga_m.prga001,g_prga_m.prga007,g_prga_m.prga008,g_prga_m.prga005,g_prga_m.prga014,g_prga_m.prga015, 
          g_prga_m.prgaunit,g_prga_m.prgaownid,g_prga_m.prgaowndp,g_prga_m.prgacrtid,g_prga_m.prgacrtdp, 
          g_prga_m.prgacrtdt,g_prga_m.prgamodid,g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfdt, 
          g_prga_m.prgasite_desc,g_prga_m.prga006_desc,g_prga_m.prga011_desc,g_prga_m.prga007_desc,g_prga_m.prga008_desc, 
          g_prga_m.prga015_desc,g_prga_m.prgaownid_desc,g_prga_m.prgaowndp_desc,g_prga_m.prgacrtid_desc, 
          g_prga_m.prgacrtdp_desc,g_prga_m.prgamodid_desc,g_prga_m.prgacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prga_m.prgasite,g_prga_m.prgasite_desc,g_prga_m.prgadocdt,g_prga_m.prgadocno, 
          g_prga_m.prga002,g_prga_m.prga003,g_prga_m.prga004,g_prga_m.prga006,g_prga_m.prga006_desc, 
          g_prga_m.prga013,g_prga_m.prga009,g_prga_m.prga010,g_prga_m.prga016,g_prga_m.prgastus,g_prga_m.prga011, 
          g_prga_m.prga011_desc,g_prga_m.prga012,g_prga_m.prga012_desc,g_prga_m.prga001,g_prga_m.prga007, 
          g_prga_m.prga007_desc,g_prga_m.prga008,g_prga_m.prga008_desc,g_prga_m.prga005,g_prga_m.prga014, 
          g_prga_m.total,g_prga_m.prga015,g_prga_m.prga015_desc,g_prga_m.prgaunit,g_prga_m.prgaownid, 
          g_prga_m.prgaownid_desc,g_prga_m.prgaowndp,g_prga_m.prgaowndp_desc,g_prga_m.prgacrtid,g_prga_m.prgacrtid_desc, 
          g_prga_m.prgacrtdp,g_prga_m.prgacrtdp_desc,g_prga_m.prgacrtdt,g_prga_m.prgamodid,g_prga_m.prgamodid_desc, 
          g_prga_m.prgamoddt,g_prga_m.prgacnfid,g_prga_m.prgacnfid_desc,g_prga_m.prgacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aprt601_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt601_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt601.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt601_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prgb_d.getLength() THEN
         LET g_detail_idx = g_prgb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prgb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prgb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_prgb2_d.getLength() THEN
         LET g_detail_idx = g_prgb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prgb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prgb2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt601_b_fill2(pi_idx)
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
   
   CALL aprt601_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt601_fill_chk(ps_idx)
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
 
{<section id="aprt601.status_show" >}
PRIVATE FUNCTION aprt601_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt601.mask_functions" >}
&include "erp/apr/aprt601_mask.4gl"
 
{</section>}
 
{<section id="aprt601.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt601_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.chr2
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL aprt601_show()
   CALL aprt601_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aprt601_conf_chk(g_prga_m.prgadocno,g_prga_m.prgastus) RETURNING l_success
   IF NOT l_success THEN
      CLOSE aprt601_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prga_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prgb_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_prgb2_d))
 
 
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
   #CALL aprt601_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt601_ui_headershow()
   CALL aprt601_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt601_draw_out()
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
   CALL aprt601_ui_headershow()  
   CALL aprt601_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt601.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt601_set_pk_array()
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
   LET g_pk_array[1].values = g_prga_m.prgadocno
   LET g_pk_array[1].column = 'prgadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt601.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt601.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt601_msgcentre_notify(lc_state)
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
   CALL aprt601_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prga_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt601.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt601_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#32 add-S
   SELECT prgastus  INTO g_prga_m.prgastus
     FROM prga_t
    WHERE prgaent = g_enterprise
      AND prgadocno = g_prga_m.prgadocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_prga_m.prgastus
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
        LET g_errparam.extend = g_prga_m.prgadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt601_set_act_visible()
        CALL aprt601_set_act_no_visible()
        CALL aprt601_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#32 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt601.other_function" readonly="Y" >}

################################################################################

################################################################################
PRIVATE FUNCTION aprt601_prga012_ref()
DEFINE l_ooef019      LIKE ooef_t.ooef019

   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_prga_m.prgasite           
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooef019
   LET g_ref_fields[2] = g_prga_m.prga012
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prga_m.prga012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prga_m.prga012_desc
   
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION aprt601_prgb009_ref()
   
   SELECT imay001 INTO g_prgb_d[l_ac].prgb008
     FROM imay_t
    WHERE imayent = g_enterprise
      AND imay003 = g_prgb_d[l_ac].prgb009
   SELECT imaa106,imaal003,imaal004
     INTO g_prgb_d[l_ac].prgb013,g_prgb_d[l_ac].prgb008_desc,g_prgb_d[l_ac].prgb008_desc_desc
     FROM imaa_t LEFT OUTER JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = g_dlang
    WHERE imaaent = g_enterprise
      AND imaa001 = g_prgb_d[l_ac].prgb008
   DISPLAY BY NAME g_prgb_d[l_ac].prgb008,g_prgb_d[l_ac].prgb013,
                   g_prgb_d[l_ac].prgb008_desc,g_prgb_d[l_ac].prgb008_desc_desc
   CALL aprt601_prgb013_ref()
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION aprt601_prgb008_ref()
DEFINE l_n      LIKE type_t.num5

   IF NOT cl_null(g_prgb_d[l_ac].prgb009) THEN
      SELECT COUNT(*) INTO l_n
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = g_prgb_d[l_ac].prgb008
         AND imay003 = g_prgb_d[l_ac].prgb009
      IF l_n > 0 THEN
         RETURN
      END IF
   END IF
   
   SELECT imaa014,imaa106,imaal003,imaal004
     INTO g_prgb_d[l_ac].prgb009,g_prgb_d[l_ac].prgb013,
          g_prgb_d[l_ac].prgb008_desc,g_prgb_d[l_ac].prgb008_desc_desc
     FROM imaa_t LEFT OUTER JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = g_dlang
    WHERE imaaent = g_enterprise
      AND imaa001 = g_prgb_d[l_ac].prgb008

   DISPLAY BY NAME g_prgb_d[l_ac].prgb009,g_prgb_d[l_ac].prgb013,
                   g_prgb_d[l_ac].prgb008_desc,g_prgb_d[l_ac].prgb008_desc_desc
   CALL aprt601_prgb013_ref()
END FUNCTION

################################################################################
# Descriptions...: 根據單頭合約帶值
# Memo...........:
# Usage..........: CALL aprt601_prga004_prgb()
# Date & Author..: 20140819 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_prga004_prgb()
DEFINE r_success      LIKE type_t.num5
DEFINE r_stau004      LIKE stau_t.stau004
DEFINE r_period       LIKE type_t.num5
DEFINE r_period2      LIKE type_t.num5
   
   IF (cl_null(g_prgb_d[l_ac].prgbseq) OR g_prgb_d[l_ac].prgbseq=0) THEN
      SELECT MAX(prgbseq)+1 INTO g_prgb_d[l_ac].prgbseq FROM prgb_t
       WHERE prgbdocno = g_prga_m.prgadocno AND prgbent = g_enterprise
   END IF
   IF (cl_null(g_prgb_d[l_ac].prgbseq) OR g_prgb_d[l_ac].prgbseq=0) THEN
      LET g_prgb_d[l_ac].prgbseq = 1
   END IF
   LET g_prgb_d[l_ac].prgb001 = g_prga_m.prga001
   LET g_prgb_d[l_ac].prgb002 = g_prga_m.prga002
   LET g_prgb_d[l_ac].prgb003 = g_prga_m.prga003
   LET g_prgb_d[l_ac].prgb005 = g_prga_m.prga005
   LET g_prgb_d[l_ac].prgb006 = g_prga_m.prga006
   LET g_prgb_d[l_ac].prgb011 = g_prga_m.prga011
   LET g_prgb_d[l_ac].prgb012 = g_prga_m.prga012
   LET g_prgb_d[l_ac].prgb019 = g_prga_m.prga009
   LET g_prgb_d[l_ac].prgb020 = g_prga_m.prga010
   LET g_prgb_d[l_ac].prgb022 = g_prga_m.prga004

   #add by yangxf ---start---
   #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark 
   IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
      SELECT stce005,stce006,stce007,stce012,stce024,stce025
        INTO g_prgb_d[l_ac].prgb023,g_prgb_d[l_ac].prgb024,g_prgb_d[l_ac].prgb025,g_prgb_d[l_ac].prgb030,g_prgb_d[l_ac].prgb026,g_prgb_d[l_ac].prgb029
        FROM stce_t
       WHERE stceent = g_enterprise
         AND stce001 = g_prga_m.prga004
   ELSE
   #add by yangxf ---end-----
      SELECT stan002,stan009,stan010,stan015
        INTO g_prgb_d[l_ac].prgb023,g_prgb_d[l_ac].prgb024,g_prgb_d[l_ac].prgb025,g_prgb_d[l_ac].prgb026
        FROM stan_t
       WHERE stanent = g_enterprise
         AND stan001 = g_prga_m.prga004
   END IF    #add by yangxf
      
   #計算結算會計期
   CALL s_asti206_get_period(g_prga_m.prga009,g_prga_m.prga010,g_prgb_d[l_ac].prgb026,g_prog)
      RETURNING r_success,r_stau004,r_period,r_period2
   IF NOT r_success THEN
      RETURN FALSE
   ELSE
      LET g_prgb_d[l_ac].prgb021 = r_stau004
      DISPLAY BY NAME g_prgb_d[l_ac].prgb021
   END IF
   
   RETURN TRUE
      
END FUNCTION

################################################################################
# Descriptions...: 更新單身隱藏欄位
# Memo...........:
# Usage..........: CALL aprt601_upd_prgb()
# Date & Author..: 20140819 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_upd_prgb()
DEFINE l_stan002      LIKE stan_t.stan002
DEFINE l_stan009      LIKE stan_t.stan009
DEFINE l_stan010      LIKE stan_t.stan010
DEFINE l_stan015      LIKE stan_t.stan015
DEFINE r_success      LIKE type_t.num5
DEFINE r_stau004      LIKE stau_t.stau004
DEFINE r_period       LIKE type_t.num5
DEFINE r_period2      LIKE type_t.num5
DEFINE l_stce005      LIKE stce_t.stce005    #add by yangxf
DEFINE l_stce006      LIKE stce_t.stce006    #add by yangxf
DEFINE l_stce007      LIKE stce_t.stce007    #add by yangxf
DEFINE l_stce024      LIKE stce_t.stce024    #add by yangxf

   #add by yangxf ---start---
   #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
      SELECT stce005,stce006,stce007,stce024
        INTO l_stce005,l_stce006,l_stce007,l_stce024
        FROM stce_t
       WHERE stceent = g_enterprise
         AND stce001 = g_prga_m.prga004
      #計算結算會計期
      CALL s_asti206_get_period(g_prga_m.prga009,g_prga_m.prga010,l_stce024,g_prog)
         RETURNING r_success,r_stau004,r_period,r_period2
      IF NOT r_success THEN
         RETURN FALSE
      END IF
      
      UPDATE prgb_t SET prgb001 = g_prga_m.prga001,prgb002 = g_prga_m.prga002,
                        prgb003 = g_prga_m.prga003,prgb005 = g_prga_m.prga005,
                        prgb006 = g_prga_m.prga006,prgb011 = g_prga_m.prga011,
                        prgb012 = g_prga_m.prga012,prgb019 = g_prga_m.prga009,
                        prgb020 = g_prga_m.prga010,prgb022 = g_prga_m.prga004,
                        prgb023 = l_stce005,prgb024 = l_stce006,
                        prgb025 = l_stce007,prgb026 = l_stce024,prgb021 = r_stau004
       WHERE prgbent = g_enterprise
         AND prgbdocno = g_prga_m.prgadocno   
   ELSE
   #add by yangxf ----end----
      SELECT stan002,stan009,stan010,stan015
        INTO l_stan002,l_stan009,l_stan010,l_stan015
        FROM stan_t
       WHERE stanent = g_enterprise
         AND stan001 = g_prga_m.prga004
      #計算結算會計期
      CALL s_asti206_get_period(g_prga_m.prga009,g_prga_m.prga010,l_stan015,g_prog)
         RETURNING r_success,r_stau004,r_period,r_period2
      IF NOT r_success THEN
         RETURN FALSE
      END IF
      
      UPDATE prgb_t SET prgb001 = g_prga_m.prga001,prgb002 = g_prga_m.prga002,
                        prgb003 = g_prga_m.prga003,prgb005 = g_prga_m.prga005,
                        prgb006 = g_prga_m.prga006,prgb011 = g_prga_m.prga011,
                        prgb012 = g_prga_m.prga012,prgb019 = g_prga_m.prga009,
                        prgb020 = g_prga_m.prga010,prgb022 = g_prga_m.prga004,
                        prgb023 = l_stan002,prgb024 = l_stan009,
                        prgb025 = l_stan010,prgb026 = l_stan015,prgb021 = r_stau004
       WHERE prgbent = g_enterprise
         AND prgbdocno = g_prga_m.prgadocno
   END IF   #add by yangxf  
   RETURN TRUE

END FUNCTION

################################################################################
# Descriptions...: 帶出庫存數量
# Memo...........:
# Usage..........: CALL aprt601_prgb008_inag()
# Date & Author..: 20140821 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_prgb008_inag()
DEFINE l_imaa143      LIKE imaa_t.imaa143      #add by yangxf
DEFINE l_dbba002      LIKE dbba_t.dbba002      #add by yangxf
DEFINE l_n            LIKE type_t.num5         #add by yangxf
DEFINE r_success      LIKE type_t.num5         #add by yangxf


   IF NOT cl_null(g_prgb_d[l_ac].prgbsite) AND NOT cl_null(g_prgb_d[l_ac].prgb008) THEN
      SELECT SUM(inag009) INTO g_prgb_d[l_ac].prgb014
        FROM inag_t
       WHERE inagent = g_enterprise
         AND inagsite = g_prgb_d[l_ac].prgbsite
         AND inag001 = g_prgb_d[l_ac].prgb008
         AND inag007 = g_prgb_d[l_ac].prgb013
#mark by yangxf ---start---数量栏位必输，不可小于等于零，预设给零会导致数量为零并保存
#      IF cl_null(g_prgb_d[l_ac].prgb014) THEN
#         LET g_prgb_d[l_ac].prgb014 = 0
#      END IF
#mark by yangxf ---end----
   END IF
   #add by yangxf ----start---
   #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark 
   IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
      #抓取銷售範圍資料
      CALL s_astt620_get_salesdata(g_prga_m.prga004,g_prga_m.prgasite,g_prgb_d[l_ac].prgb030,g_prgb_d[l_ac].prgb008)
         RETURNING r_success,g_prgb_d[l_ac].prgb028,g_prgb_d[l_ac].prgb029,g_prgb_d[l_ac].prgb030,g_prgb_d[l_ac].prgb031,g_prgb_d[l_ac].prgb032
      IF NOT r_success THEN
         RETURN
      END IF
   END IF 
   #add by yangxf ----end-----
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION aprt601_prgb013_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prgb_d[l_ac].prgb013
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prgb_d[l_ac].prgb013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prgb_d[l_ac].prgb013_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查供應商與合約編號是否對應
# Memo...........:
# Usage..........: CALL aprt601_chk_prga006()
# Date & Author..: 20140829 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_chk_prga006()
DEFINE l_n       LIKE type_t.num5
   
   LET l_n = 0
   IF NOT cl_null(g_prga_m.prga004) THEN
      #add by yangxf ---start---检查经销商合约
      #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
         SELECT COUNT(*) INTO l_n
           FROM stce_t
          WHERE stceent = g_enterprise
            AND stce001 = g_prga_m.prga004
            AND stce009 = g_prga_m.prga006
         IF l_n < 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_prga_m.prga006
            LET g_errparam.code   = "apr-00343"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
      #检查供应商合约
      ELSE
      #add by yangxf ---end---
         SELECT COUNT(*) INTO l_n
           FROM stan_t
          WHERE stanent = g_enterprise
            AND stan001 = g_prga_m.prga004
            AND stan005 = g_prga_m.prga006
         IF l_n < 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_prga_m.prga006
            LET g_errparam.code   = "apr-00342"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF     #add by yangxf  
   ELSE
      #add by yangxf ---start---带出经销商合约
      #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark 
      IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
         SELECT COUNT(*) INTO l_n
           FROM stce_t
          WHERE stceent = g_enterprise
            AND stce009 = g_prga_m.prga006
            AND stcestus = 'Y'
         IF l_n = 1 THEN
            SELECT stce001 INTO g_prga_m.prga004
              FROM stce_t
             WHERE stceent = g_enterprise
               AND stce009 = g_prga_m.prga006
               AND stcestus = 'Y'
         END IF
      #检查供应商合约
      ELSE
      #add by yangxf ---end---
         SELECT COUNT(*) INTO l_n
           FROM stan_t
          WHERE stanent = g_enterprise
            AND stan005 = g_prga_m.prga006
            AND stanstus = 'Y'
         IF l_n = 1 THEN
            SELECT stan001 INTO g_prga_m.prga004
              FROM stan_t
             WHERE stanent = g_enterprise
               AND stan005 = g_prga_m.prga006
               AND stanstus = 'Y'
         END IF
      END IF     #add by yangxf  
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 检查单身是否存在未维护的栏位
# Memo...........:
# Usage..........: CALL aprt601_accept_chk()
#                  RETURNING r_success
# Input parameter: 无
# Return code....: 正确码
# Date & Author..: 2015/05/10 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_accept_chk()
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   LET l_n = 0
   #检查aprt603单身是否存在未维护的原本价,本次进价,毛利率
   #IF g_prog = 'aprt603' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'aprt603' THEN   #160705-00042#10 160713 by sakura add
      IF g_prga_m.prga013 = '3' THEN 
         SELECT COUNT(*) INTO l_n
           FROM prgb_t 
          WHERE prgbent = g_enterprise
            AND prgbdocno = g_prga_m.prgadocno
            AND (prgb015 IS NULL
             OR prgb016 IS NULL
             OR prgb034 IS NULL)
         IF l_n > 0 THEN
            LET r_success = FALSE 
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = 'apr-00371'
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN r_success
         END IF  
      END IF 
   #检查aprt601，aprt602，aprt701单身是否存在未维护的原本价,本次进价
   ELSE
      IF g_prga_m.prga013 = '2' THEN 
         SELECT COUNT(*) INTO l_n
           FROM prgb_t 
          WHERE prgbent = g_enterprise
            AND prgbdocno = g_prga_m.prgadocno
            AND (prgb015 IS NULL
             OR prgb016 IS NULL)
          IF l_n > 0 THEN
            LET r_success = FALSE 
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            #IF g_prog = 'aprt701' THEN        #160705-00042#10 160713 by sakura mark 
            IF g_prog MATCHES 'aprt701' THEN   #160705-00042#10 160713 by sakura add
               LET g_errparam.code   = 'apr-00373'
            ELSE
               LET g_errparam.code   = 'apr-00372'
            END IF 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN r_success
         END IF  
      END IF 
   END IF 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL astt312_stbi001_chk_1()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_prgb008_chk_1()
DEFINE l_star001   LIKE star_t.star001
DEFINE l_stas018   LIKE stas_t.stas018
DEFINE l_stas019   LIKE stas_t.stas019
DEFINE l_n         LIKE type_t.num5

   IF cl_null(g_prgb_d[l_ac].prgbsite) OR cl_null(g_prgb_d[l_ac].prgb008) THEN 
      RETURN TRUE 
   END IF 
   #根据合同编号+门店抓取采购协议
   SELECT star001 INTO l_star001
     FROM star_t
    WHERE starent = g_enterprise
      AND starsite = g_prgb_d[l_ac].prgbsite
      AND star004 = g_prga_m.prga004
   IF cl_null(l_star001) THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_prgb_d[l_ac].prgbsite
      LET g_errparam.code   = "art-00594"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   LET l_n = 0
   #检查商品是否存在采购协议
   SELECT COUNT(*) INTO l_n
     FROM stas_t
    WHERE stasent = g_enterprise
      AND stas003 = g_prgb_d[l_ac].prgb008
      AND stas001 = l_star001
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_prgb_d[l_ac].prgb008
      LET g_errparam.code   = "art-00595"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF 
   #检查商品生效日期是否在单据日期范围内
   SELECT stas018,stas019
     INTO l_stas018,l_stas019
     FROM stas_t
    WHERE stasent = g_enterprise
      AND stas001 = l_star001
   IF l_stas018 > g_prga_m.prgadocdt OR g_prga_m.prgadocdt > l_stas019 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_prgb_d[l_ac].prgb008
      LET g_errparam.code   = "art-00596"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 根据补差方式抓取对应数量
# Memo...........:
# Usage..........: CALL aprt601_get_prgb014()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_get_prgb014()
DEFINE r_prgb014   LIKE prgb_t.prgb014
DEFINE r_prgb018   LIKE prgb_t.prgb018

   CALL s_astp312_get_prgb014('2',g_prga_m.prgadocno,g_prgb_d[l_ac].prgbseq,g_prgb_d[l_ac].prgbsite,g_prgb_d[l_ac].prgb008,
                              g_prgb_d[l_ac].prgb016,g_prgb_d[l_ac].prgb017,g_prgb_d[l_ac].prgb034)
           RETURNING g_prgb_d[l_ac].prgb014,g_prgb_d[l_ac].prgb018
   IF cl_null(g_prgb_d[l_ac].prgb017) THEN 
      LET g_prgb_d[l_ac].prgb018 = ''
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 根据作业类型新增补差资料明细
# Memo...........:
# Usage..........: CALLaprt601_get_prgb014_1()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_get_prgb014_1()
DEFINE l_sql      STRING 
#DEFINE l_prgc     RECORD LIKE prgc_t.*  #161111-00028#2--MARK
#161111-00028#2----ADD----BEGIN---------
DEFINE l_prgc RECORD  #補差明細表
       prgcent LIKE prgc_t.prgcent, #企業編號
       prgcsite LIKE prgc_t.prgcsite, #營運據點
       prgcunit LIKE prgc_t.prgcunit, #應用執行組織物件
       prgcdocno LIKE prgc_t.prgcdocno, #單號
       prgcseq LIKE prgc_t.prgcseq, #項次
       prgcseq1 LIKE prgc_t.prgcseq1, #項次1
       prgc001 LIKE prgc_t.prgc001, #補差類型
       prgc002 LIKE prgc_t.prgc002, #商品編號
       prgc003 LIKE prgc_t.prgc003, #商品特徵
       prgc004 LIKE prgc_t.prgc004, #庫位管理特徵
       prgc005 LIKE prgc_t.prgc005, #庫區編號
       prgc006 LIKE prgc_t.prgc006, #儲位編號
       prgc007 LIKE prgc_t.prgc007, #批號
       prgc008 LIKE prgc_t.prgc008, #交易單位
       prgc009 LIKE prgc_t.prgc009, #數量
       prgc010 LIKE prgc_t.prgc010, #採購進價/日結成本價
       prgc011 LIKE prgc_t.prgc011, #售價
       prgc012 LIKE prgc_t.prgc012, #來源單號
       prgc013 LIKE prgc_t.prgc013, #來源項次
       prgc014 LIKE prgc_t.prgc014  #來源日期
       END RECORD
#161111-00028#2----ADD----END-----------
DEFINE l_n        LIKE type_t.num5
DEFINE r_prgc009  LIKE prgc_t.prgc009
#20151109 geza add(S)
DEFINE l_ooef017        LIKE ooef_t.ooef017
DEFINE l_glaald         LIKE glaa_t.glaald
DEFINE l_glaa120        LIKE glaa_t.glaa120
DEFINE l_xcbf001        LIKE xcbf_t.xcbf001   
DEFINE l_xcbf003        LIKE xcbf_t.xcbf003    
#20151109 geza add(E)
DEFINE l_flag      LIKE type_t.chr1       #add by geza 20151110
   IF cl_null(g_prgb_d[l_ac].prgbsite) OR cl_null(g_prgb_d[l_ac].prgb008) THEN 
      RETURN ''
   END IF 
   #add by geza 20151109(S)
   #抓取法人對應會計週期參照表
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_prgb_d[l_ac].prgbsite
   SELECT glaald,glaa120 INTO l_glaald,l_glaa120  #20150715 dongsz add glaald,glaa120
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_ooef017
      AND glaa014 = 'Y'
      
   #抓取aoos020设定的成本域
   #启用成本域否
   LET l_flag = cl_get_para(g_enterprise,g_prgb_d[l_ac].prgbsite,'S-FIN-6001') 
   #成本域类型
   LET l_xcbf003 = cl_get_para(g_enterprise,g_prgb_d[l_ac].prgbsite,'S-FIN-6002')
   #20151022--dongsz add--end---
   
   
   #成本域类型
   SELECT xcbf001 INTO l_xcbf001
     FROM xcbf_t 
    WHERE xcbfent = g_enterprise 
      AND xcbfcomp = l_ooef017 
      AND xcbf002 = g_prgb_d[l_ac].prgbsite 
      AND xcbf003 = l_xcbf003
   #add by geza 20151109(E)
   
   #160705-00042#10 160713 by sakura mark(S)
   #CASE g_prog
   #     #采购补差
   #     WHEN 'aprt601'
   #160705-00042#10 160713 by sakura mark(E)
   #160705-00042#10 160713 by sakura add(S)
   CASE 
        #采购补差
        WHEN g_prog MATCHES 'aprt601'
   #160705-00042#10 160713 by sakura add(E)
              #根据开始+结束日期抓取所有的入库单明细
              #                    來源單號/來源項次/來源日期/商品编号/产品特征/库存管理特征/库区/储位/批号/单位/数量/采购进价/售价
              LET l_sql = " SELECT pmdtdocno,pmdtseq,pmdsdocdt,pmdt006,pmdt007,'',pmdt016,pmdt017,pmdt018,pmdt019,pmdt020,pmdt036,'' ",
                          "   FROM pmds_t,pmdt_t ",
                          "  WHERE pmdsent = pmdtent ",
                          "    AND pmdsdocno = pmdtdocno ",
                          "    AND pmdsent = '",g_enterprise,"'",
                          "    AND pmdsdocdt >= '",g_prga_m.prga009,"'",
                          "    AND pmdsdocdt <= '",g_prga_m.prga010,"'",
                          "    AND pmdsstus = 'S' ",
                          "    AND pmds000 IN ('3','4','6') ",
                          "    AND pmdt212 = '",g_prga_m.prga004,"'",
                          "    AND pmdssite = '",g_prgb_d[l_ac].prgbsite,"'",
                          "    AND pmdt006 = '",g_prgb_d[l_ac].prgb008,"'"
        #库存补差
        #WHEN 'aprt602'                 #160705-00042#10 160713 by sakura mark
        WHEN g_prog MATCHES 'aprt602'   #160705-00042#10 160713 by sakura add
              #抓取所有的inag明细
              #                    來源單號/來源項次/來源日期/商品编号/产品特征/库存管理特征/库区/储位/批号/单位/数量/采购进价/售价
              LET l_sql = " SELECT '','','',inag001,inag002,inag003,inag004,inag005,inag006,inag007,inag008,xccu202,'' ",
                          #"   FROM inag_t LEFT JOIN xccu_t ON inag001 = xccu004 AND inag006 = xccu006 AND inagent = xccuent ", #mark by geza 20151110
                          #add by geza 20151109(S)                          
                          "   FROM inag_t  ", #add by geza 20151110
                          "   LEFT OUTER JOIN ooef_t ",
                          "     ON ooefent = inagent AND ooef001 = inagsite  ",
                          #抓取该法人和组织对应成本域类型的成本域编号 
                          "  LEFT OUTER JOIN xcbf_t ",
                          "    ON xcbfent = inagent AND xcbfcomp = ooef017 
                               AND xcbf002 =  CASE '",l_flag,"'   WHEN 'N' THEN ' '
                                                                  WHEN 'Y' THEN 
                                                                  CASE '",l_xcbf003,"' WHEN '1' THEN inagsite
                                                                                       WHEN '2' THEN inag004
                                                                  END                                                                                       
                                              END 
                               AND xcbf003 =  CASE '",l_flag,"'   WHEN 'N' THEN ' '
                                                                  WHEN 'Y' THEN '",l_xcbf003,"'                                                                                      
                                              END ",
                          #关联xccu现在都统一把所有的key都加上  
                          "    LEFT JOIN xccu_t ON inag001 = xccu004 AND inag006 = xccu006 AND inagent = xccuent ",
                          "    AND xcculd = '",l_glaald,"' AND xccu001 = '1' AND xccu003 = '",l_glaa120,"' ",
                          "    AND xccu005 = inag002 AND xccu002 = COALESCE(xcbf001,xccu002) ", 
                          #add by geza 20151109(E)
                          "  WHERE inagent = '",g_enterprise,"'",
                          "    AND inagsite = '",g_prgb_d[l_ac].prgbsite,"'",
                          "    AND inag001 = '",g_prgb_d[l_ac].prgb008,"'",
                          "    AND inag008 > 0 "
             
                
        #销售补差
        #WHEN 'aprt603'                 #160705-00042#10 160713 by sakura mark
        WHEN g_prog MATCHES 'aprt603'   #160705-00042#10 160713 by sakura add
              #根据开始+结束日期抓取所有销售日期明细档
              #                    來源單號/來源項次/來源日期/商品编号/产品特征/库存管理特征/库区/储位/批号/单位/数量/采购进价/售价
              LET l_sql = " SELECT '','',deba002,deba009,'','',deba005,'','',deba020,deba021,deba023,'' ",
                          "   FROM deba_t ",
                          "  WHERE debaent = '",g_enterprise,"'",
                          "    AND debasite = '",g_prgb_d[l_ac].prgbsite,"'",
                          "    AND deba009 = '",g_prgb_d[l_ac].prgb008,"'",
                          "    AND deba002 >= '",g_prga_m.prga009,"'",
                          "    AND deba002 <= '",g_prga_m.prga010,"'"
   END CASE 
   #删除补差资料明细
   DELETE FROM prgc_t WHERE prgcent = g_enterprise AND prgcdocno = g_prga_m.prgadocno AND prgcseq = g_prgb_d[l_ac].prgbseq
   LET l_prgc.prgcent = g_enterprise
   LET l_prgc.prgcsite = g_prgb_d[l_ac].prgbsite
   LET l_prgc.prgcunit = g_prgb_d[l_ac].prgbsite
   LET l_prgc.prgcdocno = g_prga_m.prgadocno
   LET l_prgc.prgcseq = g_prgb_d[l_ac].prgbseq
   LET l_prgc.prgc001 = g_prga_m.prga001
   PREPARE aprt601_sel_pre FROM l_sql
   DECLARE aprt601_sel_cs CURSOR FOR aprt601_sel_pre
   LET l_n = 1
   FOREACH aprt601_sel_cs INTO l_prgc.prgc012,l_prgc.prgc013,l_prgc.prgc014,
                               l_prgc.prgc002,l_prgc.prgc003,l_prgc.prgc004,l_prgc.prgc005,
                               l_prgc.prgc006,l_prgc.prgc007,l_prgc.prgc008,l_prgc.prgc009,
                               l_prgc.prgc010,l_prgc.prgc011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach aprt601_sel_cs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN ''
      END IF
      #IF g_prog = 'aprt602' AND cl_null(l_prgc.prgc010) THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'aprt602' AND cl_null(l_prgc.prgc010) THEN   #160705-00042#10 160713 by sakura add
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_prgc.prgc002
         LET g_errparam.code   = 'apr-00410'    #此商品抓不到成本价 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN ''
      END IF 
      LET l_prgc.prgcseq1 = l_n
    # INSERT INTO prgc_t VALUES(l_prgc.*)  #161111-00028#2--mark
    #161111-00028#2--add---begin------------
      INSERT INTO prgc_t (prgcent,prgcsite,prgcunit,prgcdocno,prgcseq,prgcseq1,prgc001,prgc002,prgc003,
                          prgc004,prgc005,prgc006,prgc007,prgc008,prgc009,prgc010,prgc011,prgc012,prgc013,prgc014)
       VALUES (l_prgc.prgcent,l_prgc.prgcsite,l_prgc.prgcunit,l_prgc.prgcdocno,l_prgc.prgcseq,l_prgc.prgcseq1,
               l_prgc.prgc001,l_prgc.prgc002,l_prgc.prgc003,l_prgc.prgc004,l_prgc.prgc005,l_prgc.prgc006,l_prgc.prgc007,
               l_prgc.prgc008,l_prgc.prgc009,l_prgc.prgc010,l_prgc.prgc011,l_prgc.prgc012,l_prgc.prgc013,l_prgc.prgc014)
    #161111-00028#2--add---end--------------
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT prgc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN ''
      END IF
      LET l_n = l_n + 1
   END FOREACH 
   SELECT SUM(prgc009) INTO r_prgc009
     FROM prgc_t
    WHERE prgcent = g_enterprise
      AND prgcdocno = g_prga_m.prgadocno
      AND prgcseq = g_prgb_d[l_ac].prgbseq
   IF cl_null(r_prgc009) THEN 
      LET r_prgc009 = 0
   END IF 
   RETURN r_prgc009
END FUNCTION

################################################################################
# Descriptions...: 基准进价/毛利率补差
# Memo...........:
# Usage..........: CALL aprt601_get_prgb014_2(p_prga013)
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/18 By yangxf
# Modify.........: 20151229 dongsz add p_prga013
################################################################################
PRIVATE FUNCTION aprt601_get_prgb014_2(p_prga013)
DEFINE p_prga013  LIKE prga_t.prga013      #20151229 dongsz add
DEFINE l_sql      STRING 
#DEFINE l_prgc     RECORD LIKE prgc_t.*  #161111-00028#2--MARK
#161111-00028#2----ADD----BEGIN---------
DEFINE l_prgc RECORD  #補差明細表
       prgcent LIKE prgc_t.prgcent, #企業編號
       prgcsite LIKE prgc_t.prgcsite, #營運據點
       prgcunit LIKE prgc_t.prgcunit, #應用執行組織物件
       prgcdocno LIKE prgc_t.prgcdocno, #單號
       prgcseq LIKE prgc_t.prgcseq, #項次
       prgcseq1 LIKE prgc_t.prgcseq1, #項次1
       prgc001 LIKE prgc_t.prgc001, #補差類型
       prgc002 LIKE prgc_t.prgc002, #商品編號
       prgc003 LIKE prgc_t.prgc003, #商品特徵
       prgc004 LIKE prgc_t.prgc004, #庫位管理特徵
       prgc005 LIKE prgc_t.prgc005, #庫區編號
       prgc006 LIKE prgc_t.prgc006, #儲位編號
       prgc007 LIKE prgc_t.prgc007, #批號
       prgc008 LIKE prgc_t.prgc008, #交易單位
       prgc009 LIKE prgc_t.prgc009, #數量
       prgc010 LIKE prgc_t.prgc010, #採購進價/日結成本價
       prgc011 LIKE prgc_t.prgc011, #售價
       prgc012 LIKE prgc_t.prgc012, #來源單號
       prgc013 LIKE prgc_t.prgc013, #來源項次
       prgc014 LIKE prgc_t.prgc014  #來源日期
       END RECORD
#161111-00028#2----ADD----END-----------
DEFINE l_n        LIKE type_t.num5
DEFINE r_prgc009  LIKE prgc_t.prgc009
DEFINE r_prgb018   LIKE prgb_t.prgb018
#20151109 geza add(S)
DEFINE l_ooef017        LIKE ooef_t.ooef017
DEFINE l_glaald         LIKE glaa_t.glaald
DEFINE l_glaa120        LIKE glaa_t.glaa120
DEFINE l_xcbf001        LIKE xcbf_t.xcbf001   
DEFINE l_xcbf003        LIKE xcbf_t.xcbf003    
#20151109 geza add(E)
DEFINE l_flag      LIKE type_t.chr1       #add by geza 20151110

   IF cl_null(g_prgb_d[l_ac].prgbsite) OR cl_null(g_prgb_d[l_ac].prgb008) THEN 
      RETURN '',''
   END IF 
   
   #add by geza 20151109(S)
   #抓取法人對應會計週期參照表
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_prgb_d[l_ac].prgbsite
   #帐套，成本计算类型
   SELECT glaald,glaa120 INTO l_glaald,l_glaa120  #20150715 dongsz add glaald,glaa120
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_ooef017
      AND glaa014 = 'Y'

   #抓取aoos020设定的成本域
   #启用成本域否
   LET l_flag = cl_get_para(g_enterprise,g_prgb_d[l_ac].prgbsite,'S-FIN-6001') 
   #成本域类型
   LET l_xcbf003 = cl_get_para(g_enterprise,g_prgb_d[l_ac].prgbsite,'S-FIN-6002')
   #20151022--dongsz add--end---
   
   
   #成本域类型
   SELECT xcbf001 INTO l_xcbf001
     FROM xcbf_t 
    WHERE xcbfent = g_enterprise 
      AND xcbfcomp = l_ooef017 
      AND xcbf002 = g_prgb_d[l_ac].prgbsite 
      AND xcbf003 = l_xcbf003
   #add by geza 20151109(E)
   #160705-00042#10 160713 by sakura mark(S)
   #CASE g_prog
   #     #采购补差
   #     WHEN 'aprt601'
   #160705-00042#10 160713 by sakura mark(E)
   #160705-00042#10 160713 by sakura add(S)   
   CASE 
        #采购补差
        WHEN g_prog MATCHES 'aprt601'
   #160705-00042#10 160713 by sakura add(E)
              IF cl_null(g_prgb_d[l_ac].prgb016) THEN 
                 RETURN '',''
              END IF 
              #根据开始+结束日期抓取所有的入库单明细
              #                    來源單號/來源項次/來源日期/商品编号/产品特征/库存管理特征/库区/储位/批号/单位/数量/采购进价/售价
              LET l_sql = " SELECT pmdtdocno,pmdtseq,pmdsdocdt,pmdt006,pmdt007,'',pmdt016,pmdt017,pmdt018,pmdt019,pmdt020,pmdt036,'' ",
                          "   FROM pmds_t,pmdt_t ",
                          "  WHERE pmdsent = pmdtent ",
                          "    AND pmdsdocno = pmdtdocno ",
                          "    AND pmdsent = '",g_enterprise,"'",
                          "    AND pmdsdocdt >= '",g_prga_m.prga009,"'",
                          "    AND pmdsdocdt <= '",g_prga_m.prga010,"'",
                          "    AND pmdsstus = 'S' ",
                          "    AND pmds000 IN ('3','4','6') ",
                          "    AND pmdt212 = '",g_prga_m.prga004,"'",
                          "    AND pmdssite = '",g_prgb_d[l_ac].prgbsite,"'",
                          "    AND pmdt006 = '",g_prgb_d[l_ac].prgb008,"'",
                          "    AND pmdt036 >= '",g_prgb_d[l_ac].prgb016,"'"
        #库存补差
        #WHEN 'aprt602'                 #160705-00042#10 160713 by sakura mark
        WHEN g_prog MATCHES 'aprt602'   #160705-00042#10 160713 by sakura add
              IF cl_null(g_prgb_d[l_ac].prgb016) THEN 
                 RETURN '',''
              END IF 
              #抓取所有的inag明细
              #                    來源單號/來源項次/來源日期/商品编号/产品特征/库存管理特征/库区/储位/批号/单位/数量/采购进价/售价
              LET l_sql = " SELECT '','','',inag001,inag002,inag003,inag004,inag005,inag006,inag007,inag008,xccu202,'' ",
                          "   FROM xccu_t,inag_t ",
                          #mark by geza 20151110(S)
                          "   LEFT OUTER JOIN ooef_t ",
                          "     ON ooefent = inagent AND ooef001 = inagsite  ",
                          #抓取该法人和组织对应成本域类型的成本域编号 
                          "   LEFT OUTER JOIN xcbf_t ",
                          "     ON xcbfent = inagent AND xcbfcomp = ooef017 
                               AND xcbf002 =  CASE '",l_flag,"'   WHEN 'N' THEN ' '
                                                                  WHEN 'Y' THEN 
                                                                  CASE '",l_xcbf003,"' WHEN '1' THEN inagsite
                                                                                       WHEN '2' THEN inag004
                                                                  END                                                                                       
                                              END 
                               AND xcbf003 =  CASE '",l_flag,"'   WHEN 'N' THEN ' '
                                                                  WHEN 'Y' THEN '",l_xcbf003,"'                                                                                      
                                              END ",
                          #mark by geza 20151110(E)                    
                          "  WHERE inagent = '",g_enterprise,"'",
                          "    AND inagsite = '",g_prgb_d[l_ac].prgbsite,"'",
                          "    AND inag001 = '",g_prgb_d[l_ac].prgb008,"'",
                          "    AND inagent = xccuent ",
                          "    AND inag001 = xccu004 ",
                          "    AND inag006 = xccu006 ",
                          "    AND inag008 > 0 ",
                          "    AND xccu202 >= '",g_prgb_d[l_ac].prgb016,"'",
                          #add by geza 20151109(S)
                          #关联xccu现在都统一把所有的key都加上  
                          "    AND xcculd = '",l_glaald,"' AND xccu001 = '1' AND xccu003 = '",l_glaa120,"' ",
                          "    AND xccu005 = inag002 AND xccu002 = COALESCE(xcbf001,xccu002) " 
                          #add by geza 20151109(E)
        #销售补差
        #WHEN 'aprt603'                 #160705-00042#10 160713 by sakura mark
        WHEN g_prog MATCHES 'aprt603'   #160705-00042#10 160713 by sakura add
           #151013-00001#43--dongsz add--str
           IF p_prga013 = '2' THEN
              IF cl_null(g_prgb_d[l_ac].prgb016) THEN 
                 RETURN '',''
              END IF 
              #根据开始+结束日期抓取所有销售明细档
              #   按照补差门店+商品抓销售单多库存批明细里面所有的批次中成本价（xcck）大于本次进价的资料
              LET l_sql = " SELECT rtindocno,rtinseq,rtiadocdt,rtin001,rtin002,rtin010,rtin005, ",
                          "        rtin006,rtin007,rtin008,rtin009,xcck282,rtib010 ",
                          "   FROM rtia_t,rtib_t,rtin_t,xcck_t,inaj_t ",
                          "  WHERE rtiaent = rtibent AND rtiadocno = rtibdocno ",
                          "    AND rtiaent = rtinent AND rtiadocno = rtindocno ",
                          "    AND inajent = rtiaent ",
                          "    AND rtiaent = ",g_enterprise," AND rtiaent = xcckent ",
                          "    AND rtiadocdt >= '",g_prga_m.prga009,"' ",
                          "    AND rtiadocdt <= '",g_prga_m.prga010,"' ",
                          "    AND rtibseq = rtinseq ",
                          "    AND rtinsite = inajsite AND rtinsite = '",g_prgb_d[l_ac].prgbsite,"' ",
                          "    AND inaj001 = rtindocno AND inaj002 = rtinseq ",
                          "    AND inaj003 = rtinseq1 AND inaj005 = rtin001 ",
                          "    AND xccksite = rtinsite AND xcckld = '",l_glaald,"' ",
                          "    AND xcck001 = '1' ",
                          "    AND xcck002 = CASE '",l_flag,"' WHEN 'N' THEN ' ' ",
                          "                                    WHEN 'Y' THEN ",
                          "                                       CASE '",l_xcbf003,"' WHEN '1' THEN rtinsite ",
                          "                                                            WHEN '2' THEN rtin005 ",
                          "                                       END ",                                                                                      
                          "                  END ",
                          "    AND xcck003 = '",l_glaa120,"' ",
                          "    AND xcck004 = extract(year from rtiadocdt) ",
                          "    AND xcck005 = extract(month from rtiadocdt) ",
                          "    AND xcck006 = rtindocno AND xcck007 = rtinseq AND xcck008 = rtinseq1 ",
                          "    AND xcck009 = inaj004 ",
                          "    AND xcck010 = rtin001 AND xcck017 = rtin007 ",
                          "    AND rtin001 = '",g_prgb_d[l_ac].prgb008,"' ",
                          "    AND xcck282 > '",g_prgb_d[l_ac].prgb016,"' "
           ELSE
           #151013-00001#43--dongsz add--end
              IF cl_null(g_prgb_d[l_ac].prgb034) THEN 
                 RETURN '',''
              END IF 
              #根据开始+结束日期抓取所有销售日期明细档
              #                    來源單號/來源項次/來源日期/商品编号/产品特征/库存管理特征/库区/储位/批号/单位/数量/采购进价/售价
              LET l_sql = " SELECT '','',deba002,deba009,'','',deba005,'','',deba020,deba021,deba023,deba024 ",
                          "   FROM deba_t ",
                          "  WHERE debaent = '",g_enterprise,"'",
                          "    AND debasite = '",g_prgb_d[l_ac].prgbsite,"'",
                          "    AND deba009 = '",g_prgb_d[l_ac].prgb008,"'",
                          "    AND deba002 >= '",g_prga_m.prga009,"'",
                          "    AND deba002 <= '",g_prga_m.prga010,"'",
                          "    AND deba028 <= '",g_prgb_d[l_ac].prgb034,"'"
           END IF        #151013-00001#43 dongsz add
   END CASE 
   #删除补差资料明细
   DELETE FROM prgc_t WHERE prgcent = g_enterprise AND prgcdocno = g_prga_m.prgadocno AND prgcseq = g_prgb_d[l_ac].prgbseq
   LET l_prgc.prgcent = g_enterprise
   LET l_prgc.prgcsite = g_prgb_d[l_ac].prgbsite
   LET l_prgc.prgcunit = g_prgb_d[l_ac].prgbsite
   LET l_prgc.prgcdocno = g_prga_m.prgadocno
   LET l_prgc.prgcseq = g_prgb_d[l_ac].prgbseq
   LET l_prgc.prgc001 = g_prga_m.prga001
   PREPARE aprt601_sel_pre2 FROM l_sql
   DECLARE aprt601_sel_cs2 CURSOR FOR aprt601_sel_pre2
   LET l_n = 1
   FOREACH aprt601_sel_cs2 INTO l_prgc.prgc012,l_prgc.prgc013,l_prgc.prgc014,
                                l_prgc.prgc002,l_prgc.prgc003,l_prgc.prgc004,l_prgc.prgc005,
                                l_prgc.prgc006,l_prgc.prgc007,l_prgc.prgc008,l_prgc.prgc009,
                                l_prgc.prgc010,l_prgc.prgc011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach aprt601_sel_cs2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN '',''
      END IF
      #IF g_prog = 'aprt602' AND cl_null(l_prgc.prgc010) THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'aprt602' AND cl_null(l_prgc.prgc010) THEN   #160705-00042#10 160713 by sakura add
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_prgc.prgc002
         LET g_errparam.code   = 'apr-00410'    #此商品抓不到成本价 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN ''
      END IF 
      LET l_prgc.prgcseq1 = l_n
    # INSERT INTO prgc_t VALUES(l_prgc.*)  #161111-00028#2--mark
    #161111-00028#2--add---begin------------
      INSERT INTO prgc_t (prgcent,prgcsite,prgcunit,prgcdocno,prgcseq,prgcseq1,prgc001,prgc002,prgc003,
                          prgc004,prgc005,prgc006,prgc007,prgc008,prgc009,prgc010,prgc011,prgc012,prgc013,prgc014)
       VALUES (l_prgc.prgcent,l_prgc.prgcsite,l_prgc.prgcunit,l_prgc.prgcdocno,l_prgc.prgcseq,l_prgc.prgcseq1,
               l_prgc.prgc001,l_prgc.prgc002,l_prgc.prgc003,l_prgc.prgc004,l_prgc.prgc005,l_prgc.prgc006,l_prgc.prgc007,
               l_prgc.prgc008,l_prgc.prgc009,l_prgc.prgc010,l_prgc.prgc011,l_prgc.prgc012,l_prgc.prgc013,l_prgc.prgc014)
    #161111-00028#2--add---end--------------
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT prgc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN ''
      END IF
      LET l_n = l_n + 1
   END FOREACH
   #计算本次补差数量   
   SELECT SUM(prgc009) INTO r_prgc009
     FROM prgc_t
    WHERE prgcent = g_enterprise
      AND prgcdocno = g_prga_m.prgadocno
      AND prgcseq = g_prgb_d[l_ac].prgbseq
   IF cl_null(r_prgc009) THEN 
      LET r_prgc009 = 0
   END IF 
   #IF g_prog = 'aprt603' THEN      #151013-00001#43 dongsz mark
   #IF g_prog = 'aprt603' AND p_prga013 = '3' THEN       #151013-00001#43 dongsz add   #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'aprt603' AND p_prga013 = '3' THEN                                #160705-00042#10 160713 by sakura add
      #计算本次补差金额    售价-售价*毛利率-原进价=补差进价
      SELECT SUM(COALESCE(prgc011,0)-COALESCE(prgc011,0)*(g_prgb_d[l_ac].prgb034/100)-COALESCE(prgc010,0))
        INTO r_prgb018
        FROM prgc_t
       WHERE prgcent = g_enterprise
         AND prgcdocno = g_prga_m.prgadocno
         AND prgcseq = g_prgb_d[l_ac].prgbseq
   ELSE
      #计算本次补差金额
      SELECT SUM((COALESCE(prgc010,0)-g_prgb_d[l_ac].prgb016)*prgc009) INTO r_prgb018
        FROM prgc_t
       WHERE prgcent = g_enterprise
         AND prgcdocno = g_prga_m.prgadocno
         AND prgcseq = g_prgb_d[l_ac].prgbseq
   END IF 
   IF cl_null(r_prgb018) THEN 
      LET r_prgb018 = 0
   END IF 
   RETURN r_prgc009,r_prgb018
END FUNCTION

################################################################################
# Descriptions...: 销售补差
# Memo...........:
# Usage..........: CALL aprt601_get_prgb014_3()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/18 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_get_prgb014_3()
DEFINE l_sql      STRING 
#DEFINE l_prgc     RECORD LIKE prgc_t.*  #161111-00028#2--MARK
#161111-00028#2----ADD----BEGIN---------
DEFINE l_prgc RECORD  #補差明細表
       prgcent LIKE prgc_t.prgcent, #企業編號
       prgcsite LIKE prgc_t.prgcsite, #營運據點
       prgcunit LIKE prgc_t.prgcunit, #應用執行組織物件
       prgcdocno LIKE prgc_t.prgcdocno, #單號
       prgcseq LIKE prgc_t.prgcseq, #項次
       prgcseq1 LIKE prgc_t.prgcseq1, #項次1
       prgc001 LIKE prgc_t.prgc001, #補差類型
       prgc002 LIKE prgc_t.prgc002, #商品編號
       prgc003 LIKE prgc_t.prgc003, #商品特徵
       prgc004 LIKE prgc_t.prgc004, #庫位管理特徵
       prgc005 LIKE prgc_t.prgc005, #庫區編號
       prgc006 LIKE prgc_t.prgc006, #儲位編號
       prgc007 LIKE prgc_t.prgc007, #批號
       prgc008 LIKE prgc_t.prgc008, #交易單位
       prgc009 LIKE prgc_t.prgc009, #數量
       prgc010 LIKE prgc_t.prgc010, #採購進價/日結成本價
       prgc011 LIKE prgc_t.prgc011, #售價
       prgc012 LIKE prgc_t.prgc012, #來源單號
       prgc013 LIKE prgc_t.prgc013, #來源項次
       prgc014 LIKE prgc_t.prgc014  #來源日期
       END RECORD
#161111-00028#2----ADD----END-----------
DEFINE l_n        LIKE type_t.num5
DEFINE r_prgc009  LIKE prgc_t.prgc009
DEFINE r_prgb018   LIKE prgb_t.prgb018

   IF cl_null(g_prgb_d[l_ac].prgbsite) OR cl_null(g_prgb_d[l_ac].prgb008) OR cl_null(g_prgb_d[l_ac].prgb016) THEN 
      RETURN '',''
   END IF
   #根据开始+结束日期抓取所有销售日期明细档
   #                    來源單號/來源項次/來源日期/商品编号/产品特征/库存管理特征/库区/储位/批号/单位/数量/采购进价/售价
   LET l_sql = " SELECT '','',deba002,deba009,'','',deba005,'','',deba020,deba021,deba023,deba024 ",
               "   FROM deba_t ",
               "  WHERE debaent = '",g_enterprise,"'",
               "    AND debasite = '",g_prgb_d[l_ac].prgbsite,"'",
               "    AND deba009 = '",g_prgb_d[l_ac].prgb008,"'",
               "    AND deba002 >= '",g_prga_m.prga009,"'",
               "    AND deba002 <= '",g_prga_m.prga010,"'",
               "    AND deba024 <= '",g_prgb_d[l_ac].prgb016,"'"
   #删除补差资料明细
   DELETE FROM prgc_t WHERE prgcent = g_enterprise AND prgcdocno = g_prga_m.prgadocno AND prgcseq = g_prgb_d[l_ac].prgbseq
   LET l_prgc.prgcent = g_enterprise
   LET l_prgc.prgcsite = g_prgb_d[l_ac].prgbsite
   LET l_prgc.prgcunit = g_prgb_d[l_ac].prgbsite
   LET l_prgc.prgcdocno = g_prga_m.prgadocno
   LET l_prgc.prgcseq = g_prgb_d[l_ac].prgbseq
   LET l_prgc.prgc001 = g_prga_m.prga001
   PREPARE aprt601_sel_pre3 FROM l_sql
   DECLARE aprt601_sel_cs3 CURSOR FOR aprt601_sel_pre3
   LET l_n = 1
   FOREACH aprt601_sel_cs3 INTO l_prgc.prgc012,l_prgc.prgc013,l_prgc.prgc014,
                                l_prgc.prgc002,l_prgc.prgc003,l_prgc.prgc004,l_prgc.prgc005,
                                l_prgc.prgc006,l_prgc.prgc007,l_prgc.prgc008,l_prgc.prgc009,
                                l_prgc.prgc010,l_prgc.prgc011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach aprt601_sel_cs3" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN '',''
      END IF
      
      LET l_prgc.prgcseq1 = l_n
    # INSERT INTO prgc_t VALUES(l_prgc.*)  #161111-00028#2--mark
    #161111-00028#2--add---begin------------
      INSERT INTO prgc_t (prgcent,prgcsite,prgcunit,prgcdocno,prgcseq,prgcseq1,prgc001,prgc002,prgc003,
                          prgc004,prgc005,prgc006,prgc007,prgc008,prgc009,prgc010,prgc011,prgc012,prgc013,prgc014)
       VALUES (l_prgc.prgcent,l_prgc.prgcsite,l_prgc.prgcunit,l_prgc.prgcdocno,l_prgc.prgcseq,l_prgc.prgcseq1,
               l_prgc.prgc001,l_prgc.prgc002,l_prgc.prgc003,l_prgc.prgc004,l_prgc.prgc005,l_prgc.prgc006,l_prgc.prgc007,
               l_prgc.prgc008,l_prgc.prgc009,l_prgc.prgc010,l_prgc.prgc011,l_prgc.prgc012,l_prgc.prgc013,l_prgc.prgc014)
    #161111-00028#2--add---end--------------
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT prgc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN ''
      END IF
      LET l_n = l_n + 1
   END FOREACH
   #计算本次补差数量   
   SELECT SUM(prgc009) INTO r_prgc009
     FROM prgc_t
    WHERE prgcent = g_enterprise
      AND prgcdocno = g_prga_m.prgadocno
      AND prgcseq = g_prgb_d[l_ac].prgbseq
   IF cl_null(r_prgc009) THEN 
      LET r_prgc009 = 0
   END IF 
   #计算本次补差金额
   SELECT SUM((g_prgb_d[l_ac].prgb016-COALESCE(prgc011,0))*prgc009) INTO r_prgb018
     FROM prgc_t
    WHERE prgcent = g_enterprise
      AND prgcdocno = g_prga_m.prgadocno
      AND prgcseq = g_prgb_d[l_ac].prgbseq
   IF cl_null(r_prgb018) THEN 
      LET r_prgb018 = 0
   END IF 
   RETURN r_prgc009,r_prgb018
END FUNCTION

################################################################################
# Descriptions...: 商品检查
# Memo...........:
# Usage..........: CALL aprt601_prgb008_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/08/01 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_prgb008_chk()
DEFINE l_sys   LIKE type_t.num5
DEFINE l_n     LIKE type_t.num5
DEFINE l_sql   STRING 

   IF cl_null(g_prgb_d[l_ac].prgb008) THEN 
      RETURN 
   END IF 
   #若單頭有指定所屬品類。輸入商品必須存在所屬品類或者其下級
   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
   IF NOT cl_null(g_prga_m.prga015) THEN
      LET l_sql = " SELECT COUNT(imaa001) FROM imaa_t ",
                 "  WHERE imaaent = ",g_enterprise," AND imaa001 = '",g_prgb_d[l_ac].prgb008,"'",
                 "   AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t",
                 "                    WHERE rtaxent = ",g_enterprise," AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                 "                    START WITH rtax003 = '", g_prga_m.prga015,"' ",
                 "                    CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
                 "                    UNION ",
                 "                   SELECT DISTINCT rtax001",
                 "                              FROM rtax_t ",
                 "                             WHERE rtaxent =",g_enterprise,
                 "                               AND rtax004 = ",l_sys,
                 "                               AND rtax005 = 0 ",
                 "                               AND rtaxstus = 'Y' ",
                 "                               AND rtax001 = '",g_prga_m.prga015,"' )"
    
      PREPARE sel_cnt FROM l_sql
      EXECUTE sel_cnt INTO l_n
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00331'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
    
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 刷新单身明细
# Memo...........:
# Usage..........: CALL aprt601_refresh()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/12/29 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt601_refresh()
DEFINE l_sql         STRING 
DEFINE l_n           LIKE type_t.num10
DEFINE r_prgb014     LIKE prgb_t.prgb014
DEFINE r_prgb018     LIKE prgb_t.prgb018
DEFINE l_prgbseq     LIKE prgb_t.prgbseq
DEFINE l_total       LIKE prgb_t.prgb018
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   IF g_prga_m.prga010 > g_today THEN 
      RETURN 
   END IF 
   LET l_n = 0
   #判断单身二是否有资料
   SELECT COUNT(*) INTO l_n
     FROM prgc_t 
    WHERE prgcent = g_enterprise
      AND prgcdocno =  g_prga_m.prgadocno
   IF l_n > 0 THEN 
      RETURN 
   END IF 
   CALL s_transaction_begin()
   LET l_sql = " SELECT DISTINCT prgbseq FROM prgb_t ",
                "  WHERE prgbent = ",g_enterprise," ",
                "    AND prgbdocno = '",g_prga_m.prgadocno,"' "
   PREPARE sel_prgb_pre FROM l_sql
   DECLARE sel_prgb_cs  CURSOR WITH HOLD FOR sel_prgb_pre
   FOREACH sel_prgb_cs  INTO l_prgbseq
      CALL s_astp312_get_prgb014('1',g_prga_m.prgadocno,l_prgbseq,'','','','','') RETURNING r_prgb014,r_prgb018
      UPDATE prgb_t SET prgb014 = r_prgb014,
                        prgb018 = r_prgb018
       WHERE prgbent = g_enterprise
         AND prgbdocno = g_prga_m.prgadocno
         AND prgbseq = l_prgbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD prgb_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   IF NOT r_success THEN 
      CALL s_transaction_end('N','0')
      RETURN 
   ELSE
      CALL s_transaction_end('Y','1')
   END IF 
   CALL aprt601_b_fill()
   SELECT SUM(prgb018) INTO l_total FROM prgb_t
    WHERE prgbent = g_enterprise AND prgbdocno = g_prga_m.prgadocno
   IF cl_null(l_total) THEN
      LET g_prga_m.total = 0
   END IF
   LET g_prga_m.total = l_total
   DISPLAY BY NAME g_prga_m.total
   
END FUNCTION

 
{</section>}
 
