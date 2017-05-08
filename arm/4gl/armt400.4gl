#該程式未解開Section, 採用最新樣板產出!
{<section id="armt400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-03-28 16:35:12), PR版次:0011(2017-02-17 16:34:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000058
#+ Filename...: armt400
#+ Description: RMA覆出作業
#+ Creator....: 05423(2015-05-15 11:35:06)
#+ Modifier...: 05423 -SD/PR- 01996
 
{</section>}
 
{<section id="armt400.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160202-00019#3  2016/02/23 BY zhujing  单身新增单价、计价数量、覆出类型、未税金额、含税金额栏位
#150518-00046#5  2016/03/09 By Jessy    增加ACTION_RMA覆出單批次發票開立
#160202-00019#5  2016/04/08 By xianghui 增加制造批序号管理
#160318-00025#21 2016/04/20 BY 07900    校验代码重复错误讯息的修改
#160202-00019#8  2016/07/21 By xianghui 自动生成armt400单身的时候，如果覆出数量跟armt100的点收数量一致，自动产生armt400的批序号资料
#160726-00003#1  2016/08/01 By zhujing  重复提示自动产生单身，计价数量控管
#160812-00017#1  16/08/15   By 06137    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#33 2016/08/25 By lixh     单据类作业修改，删除时需重新检查状态
#160816-00066#3  2016/11/25 By zhujing  录入单身时自动带单别参数【覆出仓E-MFG-0042】
#161124-00048#11 2016/12/19 By zhujing .*整批调整
#160711-00040#28 2017/02/16 By xujing T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                      CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL sub_s_lot
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_rmda_m        RECORD
       rmdadocno LIKE rmda_t.rmdadocno, 
   rmdadocno_desc LIKE type_t.chr80, 
   rmdasite LIKE rmda_t.rmdasite, 
   rmdadocdt LIKE rmda_t.rmdadocdt, 
   rmda001 LIKE rmda_t.rmda001, 
   rmda002 LIKE rmda_t.rmda002, 
   rmda002_desc LIKE type_t.chr80, 
   rmda003 LIKE rmda_t.rmda003, 
   rmda003_desc LIKE type_t.chr80, 
   rmdastus LIKE rmda_t.rmdastus, 
   rmda004 LIKE rmda_t.rmda004, 
   rmda005 LIKE rmda_t.rmda005, 
   rmda005_desc LIKE type_t.chr80, 
   rmda006 LIKE rmda_t.rmda006, 
   rmda006_desc LIKE type_t.chr80, 
   rmda007 LIKE rmda_t.rmda007, 
   rmda007_desc LIKE type_t.chr80, 
   rmda008 LIKE rmda_t.rmda008, 
   rmda008_desc LIKE type_t.chr80, 
   rmda009 LIKE rmda_t.rmda009, 
   rmda010 LIKE rmda_t.rmda010, 
   rmda011 LIKE rmda_t.rmda011, 
   rmda011_desc LIKE type_t.chr80, 
   address LIKE type_t.chr500, 
   rmda012 LIKE rmda_t.rmda012, 
   rmda012_desc LIKE type_t.chr80, 
   rmda013 LIKE rmda_t.rmda013, 
   rmda013_desc LIKE type_t.chr80, 
   rmda014 LIKE rmda_t.rmda014, 
   rmda014_desc LIKE type_t.chr80, 
   rmda015 LIKE rmda_t.rmda015, 
   rmda015_desc LIKE type_t.chr80, 
   rmda016 LIKE rmda_t.rmda016, 
   rmda017 LIKE rmda_t.rmda017, 
   rmda018 LIKE rmda_t.rmda018, 
   rmda018_desc LIKE type_t.chr80, 
   rmda019 LIKE rmda_t.rmda019, 
   rmda019_desc LIKE type_t.chr80, 
   rmdaownid LIKE rmda_t.rmdaownid, 
   rmdaownid_desc LIKE type_t.chr80, 
   rmdaowndp LIKE rmda_t.rmdaowndp, 
   rmdaowndp_desc LIKE type_t.chr80, 
   rmdacrtid LIKE rmda_t.rmdacrtid, 
   rmdacrtid_desc LIKE type_t.chr80, 
   rmdacrtdp LIKE rmda_t.rmdacrtdp, 
   rmdacrtdp_desc LIKE type_t.chr80, 
   rmdacrtdt LIKE rmda_t.rmdacrtdt, 
   rmdamodid LIKE rmda_t.rmdamodid, 
   rmdamodid_desc LIKE type_t.chr80, 
   rmdamoddt LIKE rmda_t.rmdamoddt, 
   rmdacnfid LIKE rmda_t.rmdacnfid, 
   rmdacnfid_desc LIKE type_t.chr80, 
   rmdacnfdt LIKE rmda_t.rmdacnfdt, 
   rmdapstid LIKE rmda_t.rmdapstid, 
   rmdapstid_desc LIKE type_t.chr80, 
   rmdapstdt LIKE rmda_t.rmdapstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rmdb_d        RECORD
       rmdbseq LIKE rmdb_t.rmdbseq, 
   rmdb001 LIKE rmdb_t.rmdb001, 
   rmdb002 LIKE rmdb_t.rmdb002, 
   rmdb003 LIKE rmdb_t.rmdb003, 
   rmdb003_desc LIKE type_t.chr500, 
   rmdb003_desc_1 LIKE type_t.chr500, 
   rmdb004 LIKE rmdb_t.rmdb004, 
   rmdb004_desc LIKE type_t.chr500, 
   rmdb005 LIKE rmdb_t.rmdb005, 
   rmdb014 LIKE rmdb_t.rmdb014, 
   rmdb006 LIKE rmdb_t.rmdb006, 
   rmdb013 LIKE rmdb_t.rmdb013, 
   rmdb015 LIKE rmdb_t.rmdb015, 
   rmdb016 LIKE rmdb_t.rmdb016, 
   rmdb017 LIKE rmdb_t.rmdb017, 
   rmdb012 LIKE rmdb_t.rmdb012, 
   rmdb007 LIKE rmdb_t.rmdb007, 
   rmdb007_desc LIKE type_t.chr500, 
   rmdb008 LIKE rmdb_t.rmdb008, 
   rmdb008_desc LIKE type_t.chr500, 
   rmdb009 LIKE rmdb_t.rmdb009, 
   rmdb010 LIKE rmdb_t.rmdb010, 
   rmdb011 LIKE rmdb_t.rmdb011, 
   rmdbsite LIKE rmdb_t.rmdbsite
       END RECORD
PRIVATE TYPE type_g_rmdb2_d RECORD
       rmdcseq LIKE rmdc_t.rmdcseq, 
   rmdcseq1 LIKE rmdc_t.rmdcseq1, 
   rmdc001 LIKE rmdc_t.rmdc001, 
   rmdc001_desc LIKE type_t.chr500, 
   rmdc001_desc_1 LIKE type_t.chr500, 
   rmdc002 LIKE rmdc_t.rmdc002, 
   rmdc002_desc LIKE type_t.chr500, 
   rmdc003 LIKE rmdc_t.rmdc003, 
   rmdc004 LIKE rmdc_t.rmdc004, 
   rmdc005 LIKE rmdc_t.rmdc005, 
   rmdc005_desc LIKE type_t.chr500, 
   rmdc006 LIKE rmdc_t.rmdc006, 
   rmdc006_desc LIKE type_t.chr500, 
   rmdc007 LIKE rmdc_t.rmdc007, 
   rmdc008 LIKE rmdc_t.rmdc008, 
   rmdcsite LIKE rmdc_t.rmdcsite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rmdadocno LIKE rmda_t.rmdadocno,
      b_rmda001 LIKE rmda_t.rmda001,
      b_rmda002 LIKE rmda_t.rmda002,
   b_rmda002_desc LIKE type_t.chr80,
      b_rmda003 LIKE rmda_t.rmda003,
   b_rmda003_desc LIKE type_t.chr80,
      b_rmda004 LIKE rmda_t.rmda004,
      b_rmda005 LIKE rmda_t.rmda005,
   b_rmda005_desc LIKE type_t.chr80,
      b_rmdasite LIKE rmda_t.rmdasite
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_rmda_m          type_g_rmda_m
DEFINE g_rmda_m_t        type_g_rmda_m
DEFINE g_rmda_m_o        type_g_rmda_m
DEFINE g_rmda_m_mask_o   type_g_rmda_m #轉換遮罩前資料
DEFINE g_rmda_m_mask_n   type_g_rmda_m #轉換遮罩後資料
 
   DEFINE g_rmdadocno_t LIKE rmda_t.rmdadocno
 
 
DEFINE g_rmdb_d          DYNAMIC ARRAY OF type_g_rmdb_d
DEFINE g_rmdb_d_t        type_g_rmdb_d
DEFINE g_rmdb_d_o        type_g_rmdb_d
DEFINE g_rmdb_d_mask_o   DYNAMIC ARRAY OF type_g_rmdb_d #轉換遮罩前資料
DEFINE g_rmdb_d_mask_n   DYNAMIC ARRAY OF type_g_rmdb_d #轉換遮罩後資料
DEFINE g_rmdb2_d          DYNAMIC ARRAY OF type_g_rmdb2_d
DEFINE g_rmdb2_d_t        type_g_rmdb2_d
DEFINE g_rmdb2_d_o        type_g_rmdb2_d
DEFINE g_rmdb2_d_mask_o   DYNAMIC ARRAY OF type_g_rmdb2_d #轉換遮罩前資料
DEFINE g_rmdb2_d_mask_n   DYNAMIC ARRAY OF type_g_rmdb2_d #轉換遮罩後資料
 
 
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
DEFINE g_ask       LIKE type_t.num5       #詢問是否自動產生單身 2016-2-25 zhujing add
#end add-point
 
{</section>}
 
{<section id="armt400.main" >}
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
   CALL cl_ap_init("arm","")
 
   #add-point:作業初始化 name="main.init"
   LET g_errshow = '1'    
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT rmdadocno,'',rmdasite,rmdadocdt,rmda001,rmda002,'',rmda003,'',rmdastus, 
       rmda004,rmda005,'',rmda006,'',rmda007,'',rmda008,'',rmda009,rmda010,rmda011,'','',rmda012,'', 
       rmda013,'',rmda014,'',rmda015,'',rmda016,rmda017,rmda018,'',rmda019,'',rmdaownid,'',rmdaowndp, 
       '',rmdacrtid,'',rmdacrtdp,'',rmdacrtdt,rmdamodid,'',rmdamoddt,rmdacnfid,'',rmdacnfdt,rmdapstid, 
       '',rmdapstdt", 
                      " FROM rmda_t",
                      " WHERE rmdaent= ? AND rmdadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rmdadocno,t0.rmdasite,t0.rmdadocdt,t0.rmda001,t0.rmda002,t0.rmda003, 
       t0.rmdastus,t0.rmda004,t0.rmda005,t0.rmda006,t0.rmda007,t0.rmda008,t0.rmda009,t0.rmda010,t0.rmda011, 
       t0.rmda012,t0.rmda013,t0.rmda014,t0.rmda015,t0.rmda016,t0.rmda017,t0.rmda018,t0.rmda019,t0.rmdaownid, 
       t0.rmdaowndp,t0.rmdacrtid,t0.rmdacrtdp,t0.rmdacrtdt,t0.rmdamodid,t0.rmdamoddt,t0.rmdacnfid,t0.rmdacnfdt, 
       t0.rmdapstid,t0.rmdapstdt,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ,t4.pmaal004 ,t5.pmaal004 ,t6.pmaal004 , 
       t7.oocql004 ,t8.pmaal003 ,t9.xmaol004 ,t10.oocql004 ,t11.ooag011 ,t12.ooefl003 ,t13.ooag011 , 
       t14.ooefl003 ,t15.ooag011 ,t16.ooag011 ,t17.ooag011",
               " FROM rmda_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.rmda002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.rmda003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.rmda005 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.rmda006 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.rmda007 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.rmda008 AND t6.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='263' AND t7.oocql002=t0.rmda012 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t8 ON t8.pmaalent="||g_enterprise||" AND t8.pmaal001=t0.rmda015 AND t8.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN xmaol_t t9 ON t9.xmaolent="||g_enterprise||" AND t9.xmaol001=t0.rmda005 AND t9.xmaol002=t0.rmda018 AND t9.xmaol003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='299' AND t10.oocql002=t0.rmda019 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.rmdaownid  ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=t0.rmdaowndp AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.rmdacrtid  ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent="||g_enterprise||" AND t14.ooefl001=t0.rmdacrtdp AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.rmdamodid  ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.rmdacnfid  ",
               " LEFT JOIN ooag_t t17 ON t17.ooagent="||g_enterprise||" AND t17.ooag001=t0.rmdapstid  ",
 
               " WHERE t0.rmdaent = " ||g_enterprise|| " AND t0.rmdadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   LET g_sql = g_sql," AND rmdasite = '",g_site,"' "           #2016-2-25 zhujing】 add
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   #2016-2-25 zhujing】 add
   #end add-point
   PREPARE armt400_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_armt400 WITH FORM cl_ap_formpath("arm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL armt400_init()   
 
      #進入選單 Menu (="N")
      CALL armt400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_lot_sel_drop_tmp()     #160202-00019#5
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_armt400
      
   END IF 
   
   CLOSE armt400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL armt400_01_drop_temp_table()   #armt400_01   刪除temp_table
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="armt400.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION armt400_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success    LIKE type_t.num5
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
      CALL cl_set_combo_scc_part('rmdastus','13','N,Y,S,Z,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL armt400_01_create_temp_table() RETURNING l_success   #armt400_01   建立temp_table
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("rmdb004,rmdb004_desc",FALSE)
   END IF
   #運輸狀態
   CALL cl_set_combo_scc('rmda019','299')
   #覆出类型       2016-2-23 zhujing add
   CALL cl_set_combo_scc_part('rmdb014','4059','1,3')
   
   #160202-00019#5---add---begin
   CALL cl_set_toolbaritem_visible("s_lot_sel",TRUE)
   CALL cl_ui_replace_sub_window(cl_ap_formpath("sub", "s_lot_s01"), "grid_s_lot", "Table", "s_detail1_s_lot_s01")
   CALL s_lot_sel_create_tmp() 
   #160202-00019#5---add---end   
   #end add-point
   
   #初始化搜尋條件
   CALL armt400_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="armt400.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION armt400_ui_dialog()
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
   #150518-00046#5 --s add
   DEFINE tran_master      RECORD
                    wc     STRING
                           END RECORD
   DEFINE l_tran           STRING
   DEFINE ls_js2           STRING
   DEFINE l_done_isafdocno LIKE type_t.num5
   DEFINE l_done_xrcadocno LIKE type_t.num5
   #150518-00046#5 --e add
   DEFINE l_success        LIKE type_t.num5      #160202-00019#5
   DEFINE l_rmdb001        LIKE rmdb_t.rmdb001   #160202-00019#5
   DEFINE l_rmdb002        LIKE rmdb_t.rmdb002   #160202-00019#5
   DEFINE l_rmdb012        LIKE rmdb_t.rmdb012   #160202-00019#5
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
            CALL armt400_insert()
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
         INITIALIZE g_rmda_m.* TO NULL
         CALL g_rmdb_d.clear()
         CALL g_rmdb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL armt400_init()
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
               
               CALL armt400_fetch('') # reload data
               LET l_ac = 1
               CALL armt400_ui_detailshow() #Setting the current row 
         
               CALL armt400_idx_chk()
               #NEXT FIELD rmdbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rmdb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL armt400_idx_chk()
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
               CALL armt400_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION armt400_call_armt400_01
            LET g_action_choice="armt400_call_armt400_01"
            IF cl_auth_chk_act("armt400_call_armt400_01") THEN
               
               #add-point:ON ACTION armt400_call_armt400_01 name="menu.detail_show.page1.armt400_call_armt400_01"
               CALL armt400_call_armt400_01()
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_rmdb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL armt400_idx_chk()
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
               CALL armt400_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel
            LET g_action_choice="s_lot_sel"
            IF cl_auth_chk_act("s_lot_sel") THEN
               
               #add-point:ON ACTION s_lot_sel name="menu.detail_show.page2.s_lot_sel"
               #160202-00019#5---add---begin
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CONTINUE DIALOG
               END IF
               
               IF g_rmda_m.rmdastus <> 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00035'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CONTINUE DIALOG
               END IF
               IF NOT cl_null(g_rmda_m.rmdadocno) AND NOT cl_null(g_rmdb_d[g_detail_idx].rmdbseq) THEN
                  LET l_success = ''
                  CALL s_transaction_begin()
                  CALL s_transaction_begin()
                  SELECT rmdb001,rmdb002,rmdb012
                    INTO l_rmdb001,l_rmdb002,l_rmdb012                  
                    FROM rmdb_t
                   WHERE rmdbent = g_enterprise
                     AND rmdbdocno = g_rmda_m.rmdadocno
                     AND rmdbseq = g_rmdb2_d[g_detail_idx].rmdcseq
                     
                  CALL s_axmt540_inao_copy(l_rmdb001,l_rmdb002,'2',g_rmdb2_d[g_detail_idx].rmdc008,g_rmdb2_d[g_detail_idx].rmdc005,g_rmdb2_d[g_detail_idx].rmdc006,g_rmdb2_d[g_detail_idx].rmdc007,g_rmda_m.rmdadocno,g_rmdb2_d[g_detail_idx].rmdcseq,g_rmdb2_d[g_detail_idx].rmdcseq1,'1',l_rmdb012,'1') RETURNING l_success

                  CALL s_lot_sel('2','2',g_site,g_rmda_m.rmdadocno,g_rmdb2_d[g_detail_idx].rmdcseq,
                                 g_rmdb2_d[g_detail_idx].rmdcseq1,g_rmdb2_d[g_detail_idx].rmdc001,g_rmdb2_d[g_detail_idx].rmdc002,
                                 g_rmdb2_d[g_detail_idx].rmdc008,g_rmdb2_d[g_detail_idx].rmdc005,g_rmdb2_d[g_detail_idx].rmdc006,g_rmdb2_d[g_detail_idx].rmdc007,
                                 g_rmdb2_d[g_detail_idx].rmdc003,g_rmdb2_d[g_detail_idx].rmdc004,'-1','armt400','','','','','0')
                                RETURNING l_success 
                  IF l_success THEN     
                     CALL s_axmt540_update_inao(g_rmda_m.rmdadocno,g_rmdb2_d[g_detail_idx].rmdcseq,g_rmdb2_d[g_detail_idx].rmdcseq1,l_rmdb001,l_rmdb002,'1','1') RETURNING l_success 
                  END IF  
                  #刪除申請資料                              
                  DELETE FROM inao_t 
                   WHERE inaoent = g_enterprise 
                     AND inaosite = g_site
                     AND inaodocno = g_rmda_m.rmdadocno
                     AND inaoseq = g_rmdb2_d[g_detail_idx].rmdcseq
                     AND inaoseq1 = g_rmdb2_d[g_detail_idx].rmdcseq1
                     AND inao000 = '1'
                     AND inao013 = '-1'                                 
                  IF l_success THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
                  IF NOT cl_null(g_rmda_m.rmdadocno) THEN
                     CALL s_lot_b_fill('1',g_site,'2',g_rmda_m.rmdadocno,'','','-1')
                  END IF                  
               END IF               
               #160202-00019#5---add---end
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION armt400_call_armt400_01
            LET g_action_choice="armt400_call_armt400_01"
            IF cl_auth_chk_act("armt400_call_armt400_01") THEN
               
               #add-point:ON ACTION armt400_call_armt400_01 name="menu.detail_show.page2.armt400_call_armt400_01"
               CALL armt400_call_armt400_01()
               #END add-point
               
            END IF
 
 
 
 
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         SUBDIALOG sub_s_lot.s_lot_display    #160202-00019#5
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL armt400_browser_fill("")
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
               CALL armt400_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL armt400_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL armt400_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL armt400_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL armt400_set_act_visible()   
            CALL armt400_set_act_no_visible()
            IF NOT (g_rmda_m.rmdadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rmdaent = " ||g_enterprise|| " AND",
                                  " rmdadocno = '", g_rmda_m.rmdadocno, "' "
 
               #填到對應位置
               CALL armt400_browser_fill("")
            END IF
         
          
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
                     WHEN la_wc[li_idx].tableid = "rmda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmdb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmdc_t" 
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
               CALL armt400_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "rmda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmdb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmdc_t" 
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
                  CALL armt400_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL armt400_fetch("F")
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
               CALL armt400_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL armt400_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt400_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL armt400_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt400_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL armt400_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt400_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL armt400_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt400_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL armt400_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt400_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_rmdb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_rmdb2_d)
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
               NEXT FIELD rmdbseq
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
               CALL armt400_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL armt400_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL armt400_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL armt400_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc =  " rmdadocno = '",g_rmda_m.rmdadocno,"' AND rmdaent = ",g_enterprise," AND rmdasite = '",g_site,"' "
               #END add-point
               &include "erp/arm/armt400_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc =  " rmdadocno = '",g_rmda_m.rmdadocno,"' AND rmdaent = ",g_enterprise," AND rmdasite = '",g_site,"' "
               #END add-point
               &include "erp/arm/armt400_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL armt400_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL armt400_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aisp340_cmd
            LET g_action_choice="aisp340_cmd"
            IF cl_auth_chk_act("aisp340_cmd") THEN
               
               #add-point:ON ACTION aisp340_cmd name="menu.aisp340_cmd"
               #150518-00046#5 --s add
               #已過帳狀態才可執行-------------------
               SELECT rmdastus INTO g_rmda_m.rmdastus
                 FROM rmda_t 
                WHERE rmdaent = g_enterprise
                  AND rmdadocno = g_rmda_m.rmdadocno
               DISPLAY BY NAME g_rmda_m.rmdastus
               
               IF g_rmda_m.rmdastus <> 'S' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00398'   #請在已過帳狀態下執行該操作！
                  LET g_errparam.extend = g_rmda_m.rmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
                  IF NOT cl_null(g_rmda_m.rmdadocno) THEN
                     #覆出單號不可存在aist310/axrt300-----      
                     #aist310-----
                     LET l_done_isafdocno = 0
                     SELECT COUNT(*) INTO l_done_isafdocno 
                       FROM isaf_t,isag_t 
                      WHERE isagent = isafent     
                        AND isagcomp = isafcomp 
                        AND isagdocno = isafdocno 
                        AND isagent = g_enterprise
                        AND isag002 = g_rmda_m.rmdadocno
                        AND isagstus <> 'X'
                        
                     #axrt300-----
                     LET l_done_xrcadocno = 0
                     SELECT COUNT(*) INTO l_done_xrcadocno 
                       FROM xrca_t,xrcb_t 
                      WHERE xrcaent = xrcbent 
                        AND xrcald = xrcbld 
                        AND xrcadocno = xrcbdocno 
                        AND xrcaent = g_enterprise
                        AND xrcb002 = g_rmda_m.rmdadocno
                        AND xrcastus <> 'X'

                     IF (l_done_isafdocno + l_done_xrcadocno) = 0 THEN
                        LET tran_master.wc  = "rmdadocno = '",g_rmda_m.rmdadocno,"' "
                        LET l_tran = util.JSON.stringify(tran_master)    #打包參數
                        
                        INITIALIZE la_param.* TO NULL
                        LET la_param.prog = 'aisp340'
                        LET la_param.param[1] = l_tran       #把打包的參數 放到cmd_run的第一個參數
                        LET la_param.background = 'N'
                        
                        LET ls_js2 = util.JSON.stringify(la_param)
                        
                        CALL cl_cmdrun_wait(ls_js2)
                     ELSE
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axm-00711'   #已產生帳款單, 不可重覆執行！
                        LET g_errparam.extend = g_rmda_m.rmdadocno
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF
                  END IF
               END IF
               #150518-00046#5 --e add
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL armt400_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL armt400_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL armt400_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rmda_m.rmdadocdt)
 
 
 
         
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
 
{<section id="armt400.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION armt400_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT rmdadocno ",
                      " FROM rmda_t ",
                      " ",
                      " LEFT JOIN rmdb_t ON rmdbent = rmdaent AND rmdadocno = rmdbdocno ", "  ",
                      #add-point:browser_fill段sql(rmdb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN rmdc_t ON rmdcent = rmdaent AND rmdadocno = rmdcdocno", "  ",
                      #add-point:browser_fill段sql(rmdc_t1) name="browser_fill.cnt.join.rmdc_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE rmdaent = " ||g_enterprise|| " AND rmdbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rmda_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rmdadocno ",
                      " FROM rmda_t ", 
                      "  ",
                      "  ",
                      " WHERE rmdaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rmda_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," ORDER BY rmdadocno"
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
      INITIALIZE g_rmda_m.* TO NULL
      CALL g_rmdb_d.clear()        
      CALL g_rmdb2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rmdadocno,t0.rmda001,t0.rmda002,t0.rmda003,t0.rmda004,t0.rmda005,t0.rmdasite Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rmdastus,t0.rmdadocno,t0.rmda001,t0.rmda002,t0.rmda003,t0.rmda004, 
          t0.rmda005,t0.rmdasite,t1.ooag011 ,t2.ooefl003 ,t3.pmaal003 ",
                  " FROM rmda_t t0",
                  "  ",
                  "  LEFT JOIN rmdb_t ON rmdbent = rmdaent AND rmdadocno = rmdbdocno ", "  ", 
                  #add-point:browser_fill段sql(rmdb_t1) name="browser_fill.join.rmdb_t1"
                  
                  #end add-point
                  "  LEFT JOIN rmdc_t ON rmdcent = rmdaent AND rmdadocno = rmdcdocno", "  ", 
                  #add-point:browser_fill段sql(rmdc_t1) name="browser_fill.join.rmdc_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.rmda002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.rmda003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.rmda005 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.rmdaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rmda_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rmdastus,t0.rmdadocno,t0.rmda001,t0.rmda002,t0.rmda003,t0.rmda004, 
          t0.rmda005,t0.rmdasite,t1.ooag011 ,t2.ooefl003 ,t3.pmaal003 ",
                  " FROM rmda_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.rmda002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.rmda003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.rmda005 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.rmdaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rmda_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql, " AND rmdasite = '",g_site,"' "
   #end add-point
   LET g_sql = g_sql, " ORDER BY rmdadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rmda_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rmdadocno,g_browser[g_cnt].b_rmda001, 
          g_browser[g_cnt].b_rmda002,g_browser[g_cnt].b_rmda003,g_browser[g_cnt].b_rmda004,g_browser[g_cnt].b_rmda005, 
          g_browser[g_cnt].b_rmdasite,g_browser[g_cnt].b_rmda002_desc,g_browser[g_cnt].b_rmda003_desc, 
          g_browser[g_cnt].b_rmda005_desc
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
         CALL armt400_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_rmdadocno) THEN
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
 
{<section id="armt400.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION armt400_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rmda_m.rmdadocno = g_browser[g_current_idx].b_rmdadocno   
 
   EXECUTE armt400_master_referesh USING g_rmda_m.rmdadocno INTO g_rmda_m.rmdadocno,g_rmda_m.rmdasite, 
       g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002,g_rmda_m.rmda003,g_rmda_m.rmdastus,g_rmda_m.rmda004, 
       g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010, 
       g_rmda_m.rmda011,g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016, 
       g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019,g_rmda_m.rmdaownid,g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtid, 
       g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
       g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstdt,g_rmda_m.rmda002_desc,g_rmda_m.rmda003_desc, 
       g_rmda_m.rmda005_desc,g_rmda_m.rmda006_desc,g_rmda_m.rmda007_desc,g_rmda_m.rmda008_desc,g_rmda_m.rmda012_desc, 
       g_rmda_m.rmda015_desc,g_rmda_m.rmda018_desc,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp_desc, 
       g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp_desc,g_rmda_m.rmdamodid_desc,g_rmda_m.rmdacnfid_desc, 
       g_rmda_m.rmdapstid_desc
   
   CALL armt400_rmda_t_mask()
   CALL armt400_show()
      
END FUNCTION
 
{</section>}
 
{<section id="armt400.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION armt400_ui_detailshow()
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
 
{<section id="armt400.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION armt400_ui_browser_refresh()
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
      IF g_browser[l_i].b_rmdadocno = g_rmda_m.rmdadocno 
 
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
 
{<section id="armt400.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION armt400_construct()
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
   DEFINE l_gzcb004   LIKE gzcb_t.gzcb004
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_ooef019   LIKE ooef_t.ooef019
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_rmda_m.* TO NULL
   CALL g_rmdb_d.clear()        
   CALL g_rmdb2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON rmdadocno,rmdasite,rmdadocdt,rmda001,rmda002,rmda003,rmdastus,rmda004, 
          rmda005,rmda006,rmda007,rmda008,rmda009,rmda010,rmda011,rmda011_desc,address,rmda012,rmda013, 
          rmda013_desc,rmda014,rmda014_desc,rmda015,rmda016,rmda017,rmda018,rmda019,rmdaownid,rmdaowndp, 
          rmdacrtid,rmdacrtdp,rmdacrtdt,rmdamodid,rmdamoddt,rmdacnfid,rmdacnfdt,rmdapstid,rmdapstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rmdacrtdt>>----
         AFTER FIELD rmdacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rmdamoddt>>----
         AFTER FIELD rmdamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rmdacnfdt>>----
         AFTER FIELD rmdacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rmdapstdt>>----
         AFTER FIELD rmdapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdadocno
            #add-point:ON ACTION controlp INFIELD rmdadocno name="construct.c.rmdadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdadocno  #顯示到畫面上
            NEXT FIELD rmdadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdadocno
            #add-point:BEFORE FIELD rmdadocno name="construct.b.rmdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdadocno
            
            #add-point:AFTER FIELD rmdadocno name="construct.a.rmdadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdasite
            #add-point:BEFORE FIELD rmdasite name="construct.b.rmdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdasite
            
            #add-point:AFTER FIELD rmdasite name="construct.a.rmdasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmdasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdasite
            #add-point:ON ACTION controlp INFIELD rmdasite name="construct.c.rmdasite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdadocdt
            #add-point:BEFORE FIELD rmdadocdt name="construct.b.rmdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdadocdt
            
            #add-point:AFTER FIELD rmdadocdt name="construct.a.rmdadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdadocdt
            #add-point:ON ACTION controlp INFIELD rmdadocdt name="construct.c.rmdadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda001
            #add-point:BEFORE FIELD rmda001 name="construct.b.rmda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda001
            
            #add-point:AFTER FIELD rmda001 name="construct.a.rmda001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda001
            #add-point:ON ACTION controlp INFIELD rmda001 name="construct.c.rmda001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda002
            #add-point:ON ACTION controlp INFIELD rmda002 name="construct.c.rmda002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda002  #顯示到畫面上
            NEXT FIELD rmda002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda002
            #add-point:BEFORE FIELD rmda002 name="construct.b.rmda002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda002
            
            #add-point:AFTER FIELD rmda002 name="construct.a.rmda002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda003
            #add-point:ON ACTION controlp INFIELD rmda003 name="construct.c.rmda003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda003  #顯示到畫面上
            NEXT FIELD rmda003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda003
            #add-point:BEFORE FIELD rmda003 name="construct.b.rmda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda003
            
            #add-point:AFTER FIELD rmda003 name="construct.a.rmda003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdastus
            #add-point:BEFORE FIELD rmdastus name="construct.b.rmdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdastus
            
            #add-point:AFTER FIELD rmdastus name="construct.a.rmdastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdastus
            #add-point:ON ACTION controlp INFIELD rmdastus name="construct.c.rmdastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda004
            #add-point:ON ACTION controlp INFIELD rmda004 name="construct.c.rmda004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmaadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda004  #顯示到畫面上
            NEXT FIELD rmda004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda004
            #add-point:BEFORE FIELD rmda004 name="construct.b.rmda004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda004
            
            #add-point:AFTER FIELD rmda004 name="construct.a.rmda004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda005
            #add-point:ON ACTION controlp INFIELD rmda005 name="construct.c.rmda005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda005  #顯示到畫面上
            NEXT FIELD rmda005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda005
            #add-point:BEFORE FIELD rmda005 name="construct.b.rmda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda005
            
            #add-point:AFTER FIELD rmda005 name="construct.a.rmda005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda006
            #add-point:ON ACTION controlp INFIELD rmda006 name="construct.c.rmda006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = g_site
            CALL q_pmac002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda006  #顯示到畫面上
            NEXT FIELD rmda006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda006
            #add-point:BEFORE FIELD rmda006 name="construct.b.rmda006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda006
            
            #add-point:AFTER FIELD rmda006 name="construct.a.rmda006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda007
            #add-point:ON ACTION controlp INFIELD rmda007 name="construct.c.rmda007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = g_site
            CALL q_pmac002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda007  #顯示到畫面上
            NEXT FIELD rmda007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda007
            #add-point:BEFORE FIELD rmda007 name="construct.b.rmda007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda007
            
            #add-point:AFTER FIELD rmda007 name="construct.a.rmda007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda008
            #add-point:ON ACTION controlp INFIELD rmda008 name="construct.c.rmda008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = g_site
            CALL q_pmac002_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda008  #顯示到畫面上
            NEXT FIELD rmda008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda008
            #add-point:BEFORE FIELD rmda008 name="construct.b.rmda008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda008
            
            #add-point:AFTER FIELD rmda008 name="construct.a.rmda008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda009
            #add-point:BEFORE FIELD rmda009 name="construct.b.rmda009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda009
            
            #add-point:AFTER FIELD rmda009 name="construct.a.rmda009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda009
            #add-point:ON ACTION controlp INFIELD rmda009 name="construct.c.rmda009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda010
            #add-point:BEFORE FIELD rmda010 name="construct.b.rmda010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda010
            
            #add-point:AFTER FIELD rmda010 name="construct.a.rmda010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda010
            #add-point:ON ACTION controlp INFIELD rmda010 name="construct.c.rmda010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmda011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda011
            #add-point:ON ACTION controlp INFIELD rmda011 name="construct.c.rmda011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oofb019_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda011  #顯示到畫面上
            NEXT FIELD rmda011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda011
            #add-point:BEFORE FIELD rmda011 name="construct.b.rmda011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda011
            
            #add-point:AFTER FIELD rmda011 name="construct.a.rmda011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda011_desc
            #add-point:BEFORE FIELD rmda011_desc name="construct.b.rmda011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda011_desc
            
            #add-point:AFTER FIELD rmda011_desc name="construct.a.rmda011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda011_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda011_desc
            #add-point:ON ACTION controlp INFIELD rmda011_desc name="construct.c.rmda011_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD address
            #add-point:BEFORE FIELD address name="construct.b.address"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD address
            
            #add-point:AFTER FIELD address name="construct.a.address"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.address
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD address
            #add-point:ON ACTION controlp INFIELD address name="construct.c.address"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmda012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda012
            #add-point:ON ACTION controlp INFIELD rmda012 name="construct.c.rmda012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '263'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda012  #顯示到畫面上
            NEXT FIELD rmda012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda012
            #add-point:BEFORE FIELD rmda012 name="construct.b.rmda012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda012
            
            #add-point:AFTER FIELD rmda012 name="construct.a.rmda012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda013
            #add-point:ON ACTION controlp INFIELD rmda013 name="construct.c.rmda013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_xmdk023()                           #呼叫開窗
#            CALL q_rmda013()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda013  #顯示到畫面上
            NEXT FIELD rmda013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda013
            #add-point:BEFORE FIELD rmda013 name="construct.b.rmda013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda013
            
            #add-point:AFTER FIELD rmda013 name="construct.a.rmda013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda013_desc
            #add-point:BEFORE FIELD rmda013_desc name="construct.b.rmda013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda013_desc
            
            #add-point:AFTER FIELD rmda013_desc name="construct.a.rmda013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda013_desc
            #add-point:ON ACTION controlp INFIELD rmda013_desc name="construct.c.rmda013_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmda014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda014
            #add-point:ON ACTION controlp INFIELD rmda014 name="construct.c.rmda014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_xmdk024()                           #呼叫開窗
#            CALL q_rmda014()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda014  #顯示到畫面上
            NEXT FIELD rmda014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda014
            #add-point:BEFORE FIELD rmda014 name="construct.b.rmda014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda014
            
            #add-point:AFTER FIELD rmda014 name="construct.a.rmda014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda014_desc
            #add-point:BEFORE FIELD rmda014_desc name="construct.b.rmda014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda014_desc
            
            #add-point:AFTER FIELD rmda014_desc name="construct.a.rmda014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda014_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda014_desc
            #add-point:ON ACTION controlp INFIELD rmda014_desc name="construct.c.rmda014_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmda015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda015
            #add-point:ON ACTION controlp INFIELD rmda015 name="construct.c.rmda015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda015  #顯示到畫面上
            NEXT FIELD rmda015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda015
            #add-point:BEFORE FIELD rmda015 name="construct.b.rmda015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda015
            
            #add-point:AFTER FIELD rmda015 name="construct.a.rmda015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda016
            #add-point:BEFORE FIELD rmda016 name="construct.b.rmda016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda016
            
            #add-point:AFTER FIELD rmda016 name="construct.a.rmda016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda016
            #add-point:ON ACTION controlp INFIELD rmda016 name="construct.c.rmda016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda017
            #add-point:BEFORE FIELD rmda017 name="construct.b.rmda017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda017
            
            #add-point:AFTER FIELD rmda017 name="construct.a.rmda017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda017
            #add-point:ON ACTION controlp INFIELD rmda017 name="construct.c.rmda017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmda018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda018
            #add-point:ON ACTION controlp INFIELD rmda018 name="construct.c.rmda018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmao002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda018  #顯示到畫面上
            NEXT FIELD rmda018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda018
            #add-point:BEFORE FIELD rmda018 name="construct.b.rmda018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda018
            
            #add-point:AFTER FIELD rmda018 name="construct.a.rmda018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda019
            #add-point:BEFORE FIELD rmda019 name="construct.b.rmda019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda019
            
            #add-point:AFTER FIELD rmda019 name="construct.a.rmda019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmda019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda019
            #add-point:ON ACTION controlp INFIELD rmda019 name="construct.c.rmda019"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '299'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmda012  #顯示到畫面上
            NEXT FIELD rmda012                     #返回原欄位
    
            #END add-point
 
 
         #Ctrlp:construct.c.rmdaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdaownid
            #add-point:ON ACTION controlp INFIELD rmdaownid name="construct.c.rmdaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdaownid  #顯示到畫面上
            NEXT FIELD rmdaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdaownid
            #add-point:BEFORE FIELD rmdaownid name="construct.b.rmdaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdaownid
            
            #add-point:AFTER FIELD rmdaownid name="construct.a.rmdaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmdaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdaowndp
            #add-point:ON ACTION controlp INFIELD rmdaowndp name="construct.c.rmdaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdaowndp  #顯示到畫面上
            NEXT FIELD rmdaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdaowndp
            #add-point:BEFORE FIELD rmdaowndp name="construct.b.rmdaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdaowndp
            
            #add-point:AFTER FIELD rmdaowndp name="construct.a.rmdaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmdacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdacrtid
            #add-point:ON ACTION controlp INFIELD rmdacrtid name="construct.c.rmdacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdacrtid  #顯示到畫面上
            NEXT FIELD rmdacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdacrtid
            #add-point:BEFORE FIELD rmdacrtid name="construct.b.rmdacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdacrtid
            
            #add-point:AFTER FIELD rmdacrtid name="construct.a.rmdacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmdacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdacrtdp
            #add-point:ON ACTION controlp INFIELD rmdacrtdp name="construct.c.rmdacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdacrtdp  #顯示到畫面上
            NEXT FIELD rmdacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdacrtdp
            #add-point:BEFORE FIELD rmdacrtdp name="construct.b.rmdacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdacrtdp
            
            #add-point:AFTER FIELD rmdacrtdp name="construct.a.rmdacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdacrtdt
            #add-point:BEFORE FIELD rmdacrtdt name="construct.b.rmdacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmdamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdamodid
            #add-point:ON ACTION controlp INFIELD rmdamodid name="construct.c.rmdamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdamodid  #顯示到畫面上
            NEXT FIELD rmdamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdamodid
            #add-point:BEFORE FIELD rmdamodid name="construct.b.rmdamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdamodid
            
            #add-point:AFTER FIELD rmdamodid name="construct.a.rmdamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdamoddt
            #add-point:BEFORE FIELD rmdamoddt name="construct.b.rmdamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmdacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdacnfid
            #add-point:ON ACTION controlp INFIELD rmdacnfid name="construct.c.rmdacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdacnfid  #顯示到畫面上
            NEXT FIELD rmdacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdacnfid
            #add-point:BEFORE FIELD rmdacnfid name="construct.b.rmdacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdacnfid
            
            #add-point:AFTER FIELD rmdacnfid name="construct.a.rmdacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdacnfdt
            #add-point:BEFORE FIELD rmdacnfdt name="construct.b.rmdacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmdapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdapstid
            #add-point:ON ACTION controlp INFIELD rmdapstid name="construct.c.rmdapstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdapstid  #顯示到畫面上
            NEXT FIELD rmdapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdapstid
            #add-point:BEFORE FIELD rmdapstid name="construct.b.rmdapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdapstid
            
            #add-point:AFTER FIELD rmdapstid name="construct.a.rmdapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdapstdt
            #add-point:BEFORE FIELD rmdapstdt name="construct.b.rmdapstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rmdbseq,rmdb001,rmdb002,rmdb003,rmdb004,rmdb005,rmdb014,rmdb006,rmdb013, 
          rmdb015,rmdb016,rmdb017,rmdb012,rmdb007,rmdb008,rmdb009,rmdb010,rmdb011,rmdbsite
           FROM s_detail1[1].rmdbseq,s_detail1[1].rmdb001,s_detail1[1].rmdb002,s_detail1[1].rmdb003, 
               s_detail1[1].rmdb004,s_detail1[1].rmdb005,s_detail1[1].rmdb014,s_detail1[1].rmdb006,s_detail1[1].rmdb013, 
               s_detail1[1].rmdb015,s_detail1[1].rmdb016,s_detail1[1].rmdb017,s_detail1[1].rmdb012,s_detail1[1].rmdb007, 
               s_detail1[1].rmdb008,s_detail1[1].rmdb009,s_detail1[1].rmdb010,s_detail1[1].rmdb011,s_detail1[1].rmdbsite 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdbseq
            #add-point:BEFORE FIELD rmdbseq name="construct.b.page1.rmdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdbseq
            
            #add-point:AFTER FIELD rmdbseq name="construct.a.page1.rmdbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdbseq
            #add-point:ON ACTION controlp INFIELD rmdbseq name="construct.c.page1.rmdbseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmdb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb001
            #add-point:ON ACTION controlp INFIELD rmdb001 name="construct.c.page1.rmdb001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmabdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdb001  #顯示到畫面上
            NEXT FIELD rmdb001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb001
            #add-point:BEFORE FIELD rmdb001 name="construct.b.page1.rmdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb001
            
            #add-point:AFTER FIELD rmdb001 name="construct.a.page1.rmdb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb002
            #add-point:ON ACTION controlp INFIELD rmdb002 name="construct.c.page1.rmdb002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmabdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdb002  #顯示到畫面上
            NEXT FIELD rmdb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb002
            #add-point:BEFORE FIELD rmdb002 name="construct.b.page1.rmdb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb002
            
            #add-point:AFTER FIELD rmdb002 name="construct.a.page1.rmdb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb003
            #add-point:ON ACTION controlp INFIELD rmdb003 name="construct.c.page1.rmdb003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdb003  #顯示到畫面上
            NEXT FIELD rmdb003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb003
            #add-point:BEFORE FIELD rmdb003 name="construct.b.page1.rmdb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb003
            
            #add-point:AFTER FIELD rmdb003 name="construct.a.page1.rmdb003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb004
            #add-point:BEFORE FIELD rmdb004 name="construct.b.page1.rmdb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb004
            
            #add-point:AFTER FIELD rmdb004 name="construct.a.page1.rmdb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb004
            #add-point:ON ACTION controlp INFIELD rmdb004 name="construct.c.page1.rmdb004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmdb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb005
            #add-point:ON ACTION controlp INFIELD rmdb005 name="construct.c.page1.rmdb005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdb005  #顯示到畫面上
            NEXT FIELD rmdb005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb005
            #add-point:BEFORE FIELD rmdb005 name="construct.b.page1.rmdb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb005
            
            #add-point:AFTER FIELD rmdb005 name="construct.a.page1.rmdb005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb014
            #add-point:BEFORE FIELD rmdb014 name="construct.b.page1.rmdb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb014
            
            #add-point:AFTER FIELD rmdb014 name="construct.a.page1.rmdb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb014
            #add-point:ON ACTION controlp INFIELD rmdb014 name="construct.c.page1.rmdb014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb006
            #add-point:BEFORE FIELD rmdb006 name="construct.b.page1.rmdb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb006
            
            #add-point:AFTER FIELD rmdb006 name="construct.a.page1.rmdb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb006
            #add-point:ON ACTION controlp INFIELD rmdb006 name="construct.c.page1.rmdb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb013
            #add-point:BEFORE FIELD rmdb013 name="construct.b.page1.rmdb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb013
            
            #add-point:AFTER FIELD rmdb013 name="construct.a.page1.rmdb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb013
            #add-point:ON ACTION controlp INFIELD rmdb013 name="construct.c.page1.rmdb013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb015
            #add-point:BEFORE FIELD rmdb015 name="construct.b.page1.rmdb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb015
            
            #add-point:AFTER FIELD rmdb015 name="construct.a.page1.rmdb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb015
            #add-point:ON ACTION controlp INFIELD rmdb015 name="construct.c.page1.rmdb015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb016
            #add-point:BEFORE FIELD rmdb016 name="construct.b.page1.rmdb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb016
            
            #add-point:AFTER FIELD rmdb016 name="construct.a.page1.rmdb016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb016
            #add-point:ON ACTION controlp INFIELD rmdb016 name="construct.c.page1.rmdb016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb017
            #add-point:BEFORE FIELD rmdb017 name="construct.b.page1.rmdb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb017
            
            #add-point:AFTER FIELD rmdb017 name="construct.a.page1.rmdb017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb017
            #add-point:ON ACTION controlp INFIELD rmdb017 name="construct.c.page1.rmdb017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb012
            #add-point:BEFORE FIELD rmdb012 name="construct.b.page1.rmdb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb012
            
            #add-point:AFTER FIELD rmdb012 name="construct.a.page1.rmdb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb012
            #add-point:ON ACTION controlp INFIELD rmdb012 name="construct.c.page1.rmdb012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb007
            #add-point:ON ACTION controlp INFIELD rmdb007 name="construct.c.page1.rmdb007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_17()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdb007  #顯示到畫面上
            NEXT FIELD rmdb007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb007
            #add-point:BEFORE FIELD rmdb007 name="construct.b.page1.rmdb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb007
            
            #add-point:AFTER FIELD rmdb007 name="construct.a.page1.rmdb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb008
            #add-point:ON ACTION controlp INFIELD rmdb008 name="construct.c.page1.rmdb008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdb008  #顯示到畫面上
            NEXT FIELD rmdb008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb008
            #add-point:BEFORE FIELD rmdb008 name="construct.b.page1.rmdb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb008
            
            #add-point:AFTER FIELD rmdb008 name="construct.a.page1.rmdb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb009
            #add-point:ON ACTION controlp INFIELD rmdb009 name="construct.c.page1.rmdb009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inad003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdb009  #顯示到畫面上
            NEXT FIELD rmdb009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb009
            #add-point:BEFORE FIELD rmdb009 name="construct.b.page1.rmdb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb009
            
            #add-point:AFTER FIELD rmdb009 name="construct.a.page1.rmdb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb010
            #add-point:ON ACTION controlp INFIELD rmdb010 name="construct.c.page1.rmdb010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdb010  #顯示到畫面上
            NEXT FIELD rmdb010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb010
            #add-point:BEFORE FIELD rmdb010 name="construct.b.page1.rmdb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb010
            
            #add-point:AFTER FIELD rmdb010 name="construct.a.page1.rmdb010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb011
            #add-point:BEFORE FIELD rmdb011 name="construct.b.page1.rmdb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb011
            
            #add-point:AFTER FIELD rmdb011 name="construct.a.page1.rmdb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb011
            #add-point:ON ACTION controlp INFIELD rmdb011 name="construct.c.page1.rmdb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdbsite
            #add-point:BEFORE FIELD rmdbsite name="construct.b.page1.rmdbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdbsite
            
            #add-point:AFTER FIELD rmdbsite name="construct.a.page1.rmdbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmdbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdbsite
            #add-point:ON ACTION controlp INFIELD rmdbsite name="construct.c.page1.rmdbsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON rmdcseq,rmdcseq1,rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,rmdc006,rmdc007, 
          rmdc008,rmdcsite
           FROM s_detail2[1].rmdcseq,s_detail2[1].rmdcseq1,s_detail2[1].rmdc001,s_detail2[1].rmdc002, 
               s_detail2[1].rmdc003,s_detail2[1].rmdc004,s_detail2[1].rmdc005,s_detail2[1].rmdc006,s_detail2[1].rmdc007, 
               s_detail2[1].rmdc008,s_detail2[1].rmdcsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdcseq
            #add-point:BEFORE FIELD rmdcseq name="construct.b.page2.rmdcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdcseq
            
            #add-point:AFTER FIELD rmdcseq name="construct.a.page2.rmdcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmdcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdcseq
            #add-point:ON ACTION controlp INFIELD rmdcseq name="construct.c.page2.rmdcseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdcseq1
            #add-point:BEFORE FIELD rmdcseq1 name="construct.b.page2.rmdcseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdcseq1
            
            #add-point:AFTER FIELD rmdcseq1 name="construct.a.page2.rmdcseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmdcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdcseq1
            #add-point:ON ACTION controlp INFIELD rmdcseq1 name="construct.c.page2.rmdcseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rmdc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc001
            #add-point:ON ACTION controlp INFIELD rmdc001 name="construct.c.page2.rmdc001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdc001  #顯示到畫面上
            NEXT FIELD rmdc001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc001
            #add-point:BEFORE FIELD rmdc001 name="construct.b.page2.rmdc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc001
            
            #add-point:AFTER FIELD rmdc001 name="construct.a.page2.rmdc001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc002
            #add-point:BEFORE FIELD rmdc002 name="construct.b.page2.rmdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc002
            
            #add-point:AFTER FIELD rmdc002 name="construct.a.page2.rmdc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmdc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc002
            #add-point:ON ACTION controlp INFIELD rmdc002 name="construct.c.page2.rmdc002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rmdc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc003
            #add-point:ON ACTION controlp INFIELD rmdc003 name="construct.c.page2.rmdc003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdc003  #顯示到畫面上
            NEXT FIELD rmdc003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc003
            #add-point:BEFORE FIELD rmdc003 name="construct.b.page2.rmdc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc003
            
            #add-point:AFTER FIELD rmdc003 name="construct.a.page2.rmdc003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc004
            #add-point:BEFORE FIELD rmdc004 name="construct.b.page2.rmdc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc004
            
            #add-point:AFTER FIELD rmdc004 name="construct.a.page2.rmdc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmdc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc004
            #add-point:ON ACTION controlp INFIELD rmdc004 name="construct.c.page2.rmdc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc005
            #add-point:BEFORE FIELD rmdc005 name="construct.b.page2.rmdc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc005
            
            #add-point:AFTER FIELD rmdc005 name="construct.a.page2.rmdc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmdc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc005
            #add-point:ON ACTION controlp INFIELD rmdc005 name="construct.c.page2.rmdc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc006
            #add-point:BEFORE FIELD rmdc006 name="construct.b.page2.rmdc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc006
            
            #add-point:AFTER FIELD rmdc006 name="construct.a.page2.rmdc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmdc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc006
            #add-point:ON ACTION controlp INFIELD rmdc006 name="construct.c.page2.rmdc006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rmdc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc007
            #add-point:ON ACTION controlp INFIELD rmdc007 name="construct.c.page2.rmdc007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inad003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdc007  #顯示到畫面上
            NEXT FIELD rmdc007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc007
            #add-point:BEFORE FIELD rmdc007 name="construct.b.page2.rmdc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc007
            
            #add-point:AFTER FIELD rmdc007 name="construct.a.page2.rmdc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmdc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc008
            #add-point:ON ACTION controlp INFIELD rmdc008 name="construct.c.page2.rmdc008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdc008  #顯示到畫面上
            NEXT FIELD rmdc008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc008
            #add-point:BEFORE FIELD rmdc008 name="construct.b.page2.rmdc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc008
            
            #add-point:AFTER FIELD rmdc008 name="construct.a.page2.rmdc008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdcsite
            #add-point:BEFORE FIELD rmdcsite name="construct.b.page2.rmdcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdcsite
            
            #add-point:AFTER FIELD rmdcsite name="construct.a.page2.rmdcsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmdcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdcsite
            #add-point:ON ACTION controlp INFIELD rmdcsite name="construct.c.page2.rmdcsite"
            
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
                  WHEN la_wc[li_idx].tableid = "rmda_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rmdb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rmdc_t" 
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
 
{<section id="armt400.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION armt400_filter()
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
      CONSTRUCT g_wc_filter ON rmdadocno,rmda001,rmda002,rmda003,rmda004,rmda005,rmdasite
                          FROM s_browse[1].b_rmdadocno,s_browse[1].b_rmda001,s_browse[1].b_rmda002,s_browse[1].b_rmda003, 
                              s_browse[1].b_rmda004,s_browse[1].b_rmda005,s_browse[1].b_rmdasite
 
         BEFORE CONSTRUCT
               DISPLAY armt400_filter_parser('rmdadocno') TO s_browse[1].b_rmdadocno
            DISPLAY armt400_filter_parser('rmda001') TO s_browse[1].b_rmda001
            DISPLAY armt400_filter_parser('rmda002') TO s_browse[1].b_rmda002
            DISPLAY armt400_filter_parser('rmda003') TO s_browse[1].b_rmda003
            DISPLAY armt400_filter_parser('rmda004') TO s_browse[1].b_rmda004
            DISPLAY armt400_filter_parser('rmda005') TO s_browse[1].b_rmda005
            DISPLAY armt400_filter_parser('rmdasite') TO s_browse[1].b_rmdasite
      
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
 
      CALL armt400_filter_show('rmdadocno')
   CALL armt400_filter_show('rmda001')
   CALL armt400_filter_show('rmda002')
   CALL armt400_filter_show('rmda003')
   CALL armt400_filter_show('rmda004')
   CALL armt400_filter_show('rmda005')
   CALL armt400_filter_show('rmdasite')
 
END FUNCTION
 
{</section>}
 
{<section id="armt400.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION armt400_filter_parser(ps_field)
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
 
{<section id="armt400.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION armt400_filter_show(ps_field)
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
   LET ls_condition = armt400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="armt400.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION armt400_query()
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
   CALL g_rmdb_d.clear()
   CALL g_rmdb2_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL s_lot_clear_detail()
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL armt400_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL armt400_browser_fill("")
      CALL armt400_fetch("")
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
      CALL armt400_filter_show('rmdadocno')
   CALL armt400_filter_show('rmda001')
   CALL armt400_filter_show('rmda002')
   CALL armt400_filter_show('rmda003')
   CALL armt400_filter_show('rmda004')
   CALL armt400_filter_show('rmda005')
   CALL armt400_filter_show('rmdasite')
   CALL armt400_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL armt400_fetch("F") 
      #顯示單身筆數
      CALL armt400_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="armt400.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION armt400_fetch(p_flag)
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
   
   LET g_rmda_m.rmdadocno = g_browser[g_current_idx].b_rmdadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE armt400_master_referesh USING g_rmda_m.rmdadocno INTO g_rmda_m.rmdadocno,g_rmda_m.rmdasite, 
       g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002,g_rmda_m.rmda003,g_rmda_m.rmdastus,g_rmda_m.rmda004, 
       g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010, 
       g_rmda_m.rmda011,g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016, 
       g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019,g_rmda_m.rmdaownid,g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtid, 
       g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
       g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstdt,g_rmda_m.rmda002_desc,g_rmda_m.rmda003_desc, 
       g_rmda_m.rmda005_desc,g_rmda_m.rmda006_desc,g_rmda_m.rmda007_desc,g_rmda_m.rmda008_desc,g_rmda_m.rmda012_desc, 
       g_rmda_m.rmda015_desc,g_rmda_m.rmda018_desc,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp_desc, 
       g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp_desc,g_rmda_m.rmdamodid_desc,g_rmda_m.rmdacnfid_desc, 
       g_rmda_m.rmdapstid_desc
   
   #遮罩相關處理
   LET g_rmda_m_mask_o.* =  g_rmda_m.*
   CALL armt400_rmda_t_mask()
   LET g_rmda_m_mask_n.* =  g_rmda_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL armt400_set_act_visible()   
   CALL armt400_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rmda_m_t.* = g_rmda_m.*
   LET g_rmda_m_o.* = g_rmda_m.*
   
   LET g_data_owner = g_rmda_m.rmdaownid      
   LET g_data_dept  = g_rmda_m.rmdaowndp
   
   #重新顯示   
   CALL armt400_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="armt400.insert" >}
#+ 資料新增
PRIVATE FUNCTION armt400_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rmdb_d.clear()   
   CALL g_rmdb2_d.clear()  
 
 
   INITIALIZE g_rmda_m.* TO NULL             #DEFAULT 設定
   
   LET g_rmdadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rmda_m.rmdaownid = g_user
      LET g_rmda_m.rmdaowndp = g_dept
      LET g_rmda_m.rmdacrtid = g_user
      LET g_rmda_m.rmdacrtdp = g_dept 
      LET g_rmda_m.rmdacrtdt = cl_get_current()
      LET g_rmda_m.rmdamodid = g_user
      LET g_rmda_m.rmdamoddt = cl_get_current()
      LET g_rmda_m.rmdastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_rmda_m.rmda009 = "N"
      LET g_rmda_m.rmda010 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_rmda_m.rmdasite = g_site
      LET g_rmda_m.rmdadocdt = g_today
      LET g_rmda_m.rmda001 = g_today
      LET g_rmda_m.rmda009 = 'N'
      LET g_rmda_m.rmda010 = 'N'
      LET g_rmda_m.rmda019 = '1'
      LET g_rmda_m.rmdastus = 'N'
      
      LET g_rmda_m.rmda002 = g_user
      CALL s_desc_get_person_desc(g_rmda_m.rmda002) RETURNING g_rmda_m.rmda002_desc
      DISPLAY BY NAME g_rmda_m.rmda002_desc
      
      LET g_rmda_m.rmda003 = g_dept
      CALL s_desc_get_department_desc(g_rmda_m.rmda003) RETURNING g_rmda_m.rmda003_desc
      DISPLAY BY NAME g_rmda_m.rmda003_desc
      
      INITIALIZE g_rmda_m_t.* TO NULL
      INITIALIZE g_rmda_m_o.* TO NULL
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rmda_m_t.* = g_rmda_m.*
      LET g_rmda_m_o.* = g_rmda_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmda_m.rmdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL armt400_input("a")
      
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
         INITIALIZE g_rmda_m.* TO NULL
         INITIALIZE g_rmdb_d TO NULL
         INITIALIZE g_rmdb2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL armt400_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rmdb_d.clear()
      #CALL g_rmdb2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL armt400_set_act_visible()   
   CALL armt400_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rmdadocno_t = g_rmda_m.rmdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rmdaent = " ||g_enterprise|| " AND",
                      " rmdadocno = '", g_rmda_m.rmdadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL armt400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE armt400_cl
   
   CALL armt400_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE armt400_master_referesh USING g_rmda_m.rmdadocno INTO g_rmda_m.rmdadocno,g_rmda_m.rmdasite, 
       g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002,g_rmda_m.rmda003,g_rmda_m.rmdastus,g_rmda_m.rmda004, 
       g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010, 
       g_rmda_m.rmda011,g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016, 
       g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019,g_rmda_m.rmdaownid,g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtid, 
       g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
       g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstdt,g_rmda_m.rmda002_desc,g_rmda_m.rmda003_desc, 
       g_rmda_m.rmda005_desc,g_rmda_m.rmda006_desc,g_rmda_m.rmda007_desc,g_rmda_m.rmda008_desc,g_rmda_m.rmda012_desc, 
       g_rmda_m.rmda015_desc,g_rmda_m.rmda018_desc,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp_desc, 
       g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp_desc,g_rmda_m.rmdamodid_desc,g_rmda_m.rmdacnfid_desc, 
       g_rmda_m.rmdapstid_desc
   
   
   #遮罩相關處理
   LET g_rmda_m_mask_o.* =  g_rmda_m.*
   CALL armt400_rmda_t_mask()
   LET g_rmda_m_mask_n.* =  g_rmda_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rmda_m.rmdadocno,g_rmda_m.rmdadocno_desc,g_rmda_m.rmdasite,g_rmda_m.rmdadocdt,g_rmda_m.rmda001, 
       g_rmda_m.rmda002,g_rmda_m.rmda002_desc,g_rmda_m.rmda003,g_rmda_m.rmda003_desc,g_rmda_m.rmdastus, 
       g_rmda_m.rmda004,g_rmda_m.rmda005,g_rmda_m.rmda005_desc,g_rmda_m.rmda006,g_rmda_m.rmda006_desc, 
       g_rmda_m.rmda007,g_rmda_m.rmda007_desc,g_rmda_m.rmda008,g_rmda_m.rmda008_desc,g_rmda_m.rmda009, 
       g_rmda_m.rmda010,g_rmda_m.rmda011,g_rmda_m.rmda011_desc,g_rmda_m.address,g_rmda_m.rmda012,g_rmda_m.rmda012_desc, 
       g_rmda_m.rmda013,g_rmda_m.rmda013_desc,g_rmda_m.rmda014,g_rmda_m.rmda014_desc,g_rmda_m.rmda015, 
       g_rmda_m.rmda015_desc,g_rmda_m.rmda016,g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda018_desc, 
       g_rmda_m.rmda019,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid,g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp, 
       g_rmda_m.rmdaowndp_desc,g_rmda_m.rmdacrtid,g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdp_desc, 
       g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamodid_desc,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
       g_rmda_m.rmdacnfid_desc,g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstid_desc,g_rmda_m.rmdapstdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rmda_m.rmdaownid      
   LET g_data_dept  = g_rmda_m.rmdaowndp
   
   #功能已完成,通報訊息中心
   CALL armt400_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="armt400.modify" >}
#+ 資料修改
PRIVATE FUNCTION armt400_modify()
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
   LET g_rmda_m_t.* = g_rmda_m.*
   LET g_rmda_m_o.* = g_rmda_m.*
   
   IF g_rmda_m.rmdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rmdadocno_t = g_rmda_m.rmdadocno
 
   CALL s_transaction_begin()
   
   OPEN armt400_cl USING g_enterprise,g_rmda_m.rmdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt400_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE armt400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE armt400_master_referesh USING g_rmda_m.rmdadocno INTO g_rmda_m.rmdadocno,g_rmda_m.rmdasite, 
       g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002,g_rmda_m.rmda003,g_rmda_m.rmdastus,g_rmda_m.rmda004, 
       g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010, 
       g_rmda_m.rmda011,g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016, 
       g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019,g_rmda_m.rmdaownid,g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtid, 
       g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
       g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstdt,g_rmda_m.rmda002_desc,g_rmda_m.rmda003_desc, 
       g_rmda_m.rmda005_desc,g_rmda_m.rmda006_desc,g_rmda_m.rmda007_desc,g_rmda_m.rmda008_desc,g_rmda_m.rmda012_desc, 
       g_rmda_m.rmda015_desc,g_rmda_m.rmda018_desc,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp_desc, 
       g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp_desc,g_rmda_m.rmdamodid_desc,g_rmda_m.rmdacnfid_desc, 
       g_rmda_m.rmdapstid_desc
   
   #檢查是否允許此動作
   IF NOT armt400_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rmda_m_mask_o.* =  g_rmda_m.*
   CALL armt400_rmda_t_mask()
   LET g_rmda_m_mask_n.* =  g_rmda_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL armt400_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_rmdadocno_t = g_rmda_m.rmdadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rmda_m.rmdamodid = g_user 
LET g_rmda_m.rmdamoddt = cl_get_current()
LET g_rmda_m.rmdamodid_desc = cl_get_username(g_rmda_m.rmdamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL armt400_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rmda_t SET (rmdamodid,rmdamoddt) = (g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt)
          WHERE rmdaent = g_enterprise AND rmdadocno = g_rmdadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rmda_m.* = g_rmda_m_t.*
            CALL armt400_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rmda_m.rmdadocno != g_rmda_m_t.rmdadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE rmdb_t SET rmdbdocno = g_rmda_m.rmdadocno
 
          WHERE rmdbent = g_enterprise AND rmdbdocno = g_rmda_m_t.rmdadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rmdb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmdb_t:",SQLERRMESSAGE 
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
         
         UPDATE rmdc_t
            SET rmdcdocno = g_rmda_m.rmdadocno
 
          WHERE rmdcent = g_enterprise AND
                rmdcdocno = g_rmdadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rmdc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmdc_t:",SQLERRMESSAGE 
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
   CALL armt400_set_act_visible()   
   CALL armt400_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rmdaent = " ||g_enterprise|| " AND",
                      " rmdadocno = '", g_rmda_m.rmdadocno, "' "
 
   #填到對應位置
   CALL armt400_browser_fill("")
 
   CLOSE armt400_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL armt400_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="armt400.input" >}
#+ 資料輸入
PRIVATE FUNCTION armt400_input(p_cmd)
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
   DEFINE l_rollback             LIKE type_t.num5
   DEFINE l_ooef004              LIKE ooef_t.ooef004    #單據別參照表號
   DEFINE l_flag                 LIKE type_t.num5
   DEFINE l_where                STRING                 #單據別過濾sql條件
   DEFINE l_oocq019              LIKE oocq_t.oocq019    #運輸方式
   DEFINE l_imaa005              LIKE imaa_t.imaa005    #產品特徵
   DEFINE l_rmaa005              LIKE rmaa_t.rmaa005    #出貨單號
   DEFINE l_inam              DYNAMIC ARRAY OF RECORD   #紀錄產品特徵
          inam001             LIKE inam_t.inam001,
          inam002             LIKE inam_t.inam002,
          inam004             LIKE inam_t.inam004
   END RECORD
   DEFINE l_rmdbseq              LIKE rmdb_t.rmdbseq
   DEFINE r_success     LIKE type_t.num5

   DEFINE l_num                  LIKE rmdb_t.rmdb006    #覆出數量
   DEFINE l_rmdbseq_backup       LIKE rmdb_t.rmdbseq    #紀錄新增多庫儲批時的項次
   
   DEFINE l_rmdb007  LIKE rmdb_t.rmdb007
   DEFINE l_rmdb008  LIKE rmdb_t.rmdb008
   DEFINE l_rmdb009  LIKE rmdb_t.rmdb009
   DEFINE l_rmdb010  LIKE rmdb_t.rmdb010
   
   DEFINE l_msg                  LIKE type_t.chr10
   DEFINE l_para_data            LIKE type_t.chr80      #接參數用
   DEFINE l_flag1       LIKE type_t.num5           #160816-00066#3 add
   DEFINE l_ooac002     LIKE ooac_t.ooac002        #160816-00066#3 add
   DEFINE l_sql1          STRING            #160711-00040#28 add
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
   DISPLAY BY NAME g_rmda_m.rmdadocno,g_rmda_m.rmdadocno_desc,g_rmda_m.rmdasite,g_rmda_m.rmdadocdt,g_rmda_m.rmda001, 
       g_rmda_m.rmda002,g_rmda_m.rmda002_desc,g_rmda_m.rmda003,g_rmda_m.rmda003_desc,g_rmda_m.rmdastus, 
       g_rmda_m.rmda004,g_rmda_m.rmda005,g_rmda_m.rmda005_desc,g_rmda_m.rmda006,g_rmda_m.rmda006_desc, 
       g_rmda_m.rmda007,g_rmda_m.rmda007_desc,g_rmda_m.rmda008,g_rmda_m.rmda008_desc,g_rmda_m.rmda009, 
       g_rmda_m.rmda010,g_rmda_m.rmda011,g_rmda_m.rmda011_desc,g_rmda_m.address,g_rmda_m.rmda012,g_rmda_m.rmda012_desc, 
       g_rmda_m.rmda013,g_rmda_m.rmda013_desc,g_rmda_m.rmda014,g_rmda_m.rmda014_desc,g_rmda_m.rmda015, 
       g_rmda_m.rmda015_desc,g_rmda_m.rmda016,g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda018_desc, 
       g_rmda_m.rmda019,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid,g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp, 
       g_rmda_m.rmdaowndp_desc,g_rmda_m.rmdacrtid,g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdp_desc, 
       g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamodid_desc,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
       g_rmda_m.rmdacnfid_desc,g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstid_desc,g_rmda_m.rmdapstdt 
 
   
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
   LET g_forupd_sql = "SELECT rmdbseq,rmdb001,rmdb002,rmdb003,rmdb004,rmdb005,rmdb014,rmdb006,rmdb013, 
       rmdb015,rmdb016,rmdb017,rmdb012,rmdb007,rmdb008,rmdb009,rmdb010,rmdb011,rmdbsite FROM rmdb_t  
       WHERE rmdbent=? AND rmdbdocno=? AND rmdbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt400_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT rmdcseq,rmdcseq1,rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,rmdc006,rmdc007, 
       rmdc008,rmdcsite FROM rmdc_t WHERE rmdcent=? AND rmdcdocno=? AND rmdcseq=? AND rmdcseq1=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt400_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL armt400_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL armt400_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rmda_m.rmdadocno,g_rmda_m.rmdasite,g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002, 
       g_rmda_m.rmda003,g_rmda_m.rmdastus,g_rmda_m.rmda004,g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007, 
       g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010,g_rmda_m.rmda011,g_rmda_m.address,g_rmda_m.rmda012, 
       g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016,g_rmda_m.rmda017,g_rmda_m.rmda018, 
       g_rmda_m.rmda019
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_ask = TRUE     ##160726-00003#1 zhujing
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="armt400.input.head" >}
      #單頭段
      INPUT BY NAME g_rmda_m.rmdadocno,g_rmda_m.rmdasite,g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002, 
          g_rmda_m.rmda003,g_rmda_m.rmdastus,g_rmda_m.rmda004,g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007, 
          g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010,g_rmda_m.rmda011,g_rmda_m.address,g_rmda_m.rmda012, 
          g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016,g_rmda_m.rmda017,g_rmda_m.rmda018, 
          g_rmda_m.rmda019 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN armt400_cl USING g_enterprise,g_rmda_m.rmdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt400_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE armt400_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL armt400_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL armt400_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdadocno
            
            #add-point:AFTER FIELD rmdadocno name="input.a.rmdadocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rmda_m.rmdadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rmda_m.rmdadocno != g_rmdadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmda_t WHERE "||"rmdaent = '" ||g_enterprise|| "' AND "||"rmdadocno = '"||g_rmda_m.rmdadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_aooi200_get_slip_desc(g_rmda_m.rmdadocno) RETURNING g_rmda_m.rmdadocno_desc
               DISPLAY BY NAME g_rmda_m.rmdadocno_desc
            END IF

            IF cl_null(g_rmda_m.rmdadocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00324'   #單號欄位不可為空！
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF

            IF g_rmda_m.rmdadocno <> g_rmda_m_o.rmdadocno OR cl_null(g_rmda_m_o.rmdadocno) THEN
               #檢查單別
               IF NOT s_aooi200_chk_slip(g_site,'',g_rmda_m.rmdadocno,g_prog) THEN
                  LET g_rmda_m.rmdadocno = g_rmda_m_o.rmdadocno

                  CALL s_aooi200_get_slip_desc(g_rmda_m.rmdadocno) RETURNING g_rmda_m.rmdadocno_desc
                  DISPLAY BY NAME g_rmda_m.rmdadocno_desc

                  NEXT FIELD CURRENT
               END IF
            END IF
            #160204-00004#4 Add By Ken 160222(S)
            IF NOT cl_null(g_rmda_m.rmdadocno) THEN 
               IF (g_rmda_m.rmdadocno <> g_rmda_m_o.rmdadocno) OR cl_null(g_rmda_m_o.rmdadocno) THEN
                  LET g_rmda_m.rmda004 = ''
                  DISPLAY BY NAME g_rmda_m.rmda004
                  LET g_rmda_m_o.rmda004 = g_rmda_m.rmda004
               END IF
            END IF
            #160204-00004#4 Add By Ken 160222(E)
            LET g_rmda_m_o.rmdadocno = g_rmda_m.rmdadocno
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdadocno
            #add-point:BEFORE FIELD rmdadocno name="input.b.rmdadocno"
            CALL s_aooi200_get_slip_desc(g_rmda_m.rmdadocno) RETURNING g_rmda_m.rmdadocno_desc
            DISPLAY BY NAME g_rmda_m.rmdadocno_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdadocno
            #add-point:ON CHANGE rmdadocno name="input.g.rmdadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdasite
            #add-point:BEFORE FIELD rmdasite name="input.b.rmdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdasite
            
            #add-point:AFTER FIELD rmdasite name="input.a.rmdasite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdasite
            #add-point:ON CHANGE rmdasite name="input.g.rmdasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdadocdt
            #add-point:BEFORE FIELD rmdadocdt name="input.b.rmdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdadocdt
            
            #add-point:AFTER FIELD rmdadocdt name="input.a.rmdadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdadocdt
            #add-point:ON CHANGE rmdadocdt name="input.g.rmdadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda001
            #add-point:BEFORE FIELD rmda001 name="input.b.rmda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda001
            
            #add-point:AFTER FIELD rmda001 name="input.a.rmda001"
            IF NOT cl_null(g_rmda_m.rmda001) THEN
               IF g_rmda_m.rmda001 <> g_rmda_m_o.rmda001 OR cl_null(g_rmda_m_o.rmda001) THEN
                  #151120-00003#1 20151123 mark by beckxie---S
                  #IF NOT armt400_rmdadocdt_rmda001_chk() THEN
                  #   LET g_rmda_m.rmda001 = g_rmda_m_o.rmda001
                  #   NEXT FIELD CURRENT
                  #END IF
                  #151120-00003#1 20151123 mark by beckxie---E
                  CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_para_data
                  IF g_rmda_m.rmda001 <= l_para_data THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00077'   #扣帳日期小於關帳日期，請重新輸入！
                     LET g_errparam.extend = g_rmda_m.rmda001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_rmda_m.rmda001 = g_rmda_m_o.rmda001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_rmda_m_o.rmda001 = g_rmda_m.rmda001   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda001
            #add-point:ON CHANGE rmda001 name="input.g.rmda001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda002
            
            #add-point:AFTER FIELD rmda002 name="input.a.rmda002"
            IF NOT cl_null(g_rmda_m.rmda002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmda_m.rmda002  
               #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#21  by 07900 --add-end                
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  SELECT ooag003 INTO g_rmda_m.rmda003 FROM ooag_t
                   WHERE ooagent = g_enterprise AND ooag001 = g_rmda_m.rmda002
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rmda_m.rmda003
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_rmda_m.rmda003_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_rmda_m.rmda003_desc
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmda_m.rmda002 = g_rmda_m_o.rmda002
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmda_m.rmda002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_rmda_m.rmda002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmda_m.rmda002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda002
            #add-point:BEFORE FIELD rmda002 name="input.b.rmda002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda002
            #add-point:ON CHANGE rmda002 name="input.g.rmda002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda003
            
            #add-point:AFTER FIELD rmda003 name="input.a.rmda003"
            IF NOT cl_null(g_rmda_m.rmda003) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmda_m.rmda003    
               #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#21  by 07900 --add-end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmda_m.rmda003 = g_rmda_m_o.rmda003
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmda_m.rmda003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmda_m.rmda003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmda_m.rmda003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda003
            #add-point:BEFORE FIELD rmda003 name="input.b.rmda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda003
            #add-point:ON CHANGE rmda003 name="input.g.rmda003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdastus
            #add-point:BEFORE FIELD rmdastus name="input.b.rmdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdastus
            
            #add-point:AFTER FIELD rmdastus name="input.a.rmdastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdastus
            #add-point:ON CHANGE rmdastus name="input.g.rmdastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda004
            
            #add-point:AFTER FIELD rmda004 name="input.a.rmda004"
            IF NOT cl_null(g_rmda_m.rmda004) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               #160204-00004#4 Add By Ken 160222(S)
               IF NOT s_aooi210_check_doc(g_site,'',g_rmda_m.rmda004,g_rmda_m.rmdadocno,'4','') THEN
                  LET g_rmda_m.rmda004 = g_rmda_m_o.rmda004
                  NEXT FIELD CURRENT
               END IF
               #160204-00004#4 Add By Ken 160222(E) 
               
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmda_m.rmda004

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rmaadocno_2") THEN
                  #檢查成功時後續處理
                  SELECT rmaa001 INTO g_rmda_m.rmda005 
                    FROM rmaa_t
                   WHERE rmaaent = g_enterprise
                     AND rmaadocno = g_rmda_m.rmda004
                  DISPLAY BY NAME g_rmda_m.rmda005
                  IF NOT cl_null(g_rmda_m.rmda005) THEN
                     IF g_rmda_m.rmda005 <> g_rmda_m_o.rmda005 OR cl_null(g_rmda_m_o.rmda005) THEN
#                        LET g_rmda_m.rmda005 = g_rmda_m_o.rmda005

                        CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda005) RETURNING g_rmda_m.rmda005_desc
                        DISPLAY BY NAME g_rmda_m.rmda005_desc
                        
                        SELECT rmaa005 INTO l_rmaa005
                          FROM rmaa_t
                         WHERE rmaadocno = g_rmda_m.rmda005
                           AND rmaaent = g_enterprise
                           AND rmaasite = g_site
                        IF NOT cl_null(l_rmaa005) THEN
                           SELECT xmdk007,xmdk009,xmdk008,xmdk202,xmdk028,xmdk029,xmdk021,
                                  xmdk022,xmdk023,xmdk024,xmdk020,xmdk025,xmdk026,xmdk027,xmdk038
                             INTO g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010,g_rmda_m.rmda011,
                                  g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016,g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019
                             FROM xmdk_t
                            WHERE xmdkdocno = l_rmaa005
                              AND xmdkent = g_enterprise
                              AND xmdksite = g_site
                        ELSE

                           CALL armt400_rmda005_default()     #自動帶出客戶預設資料
                        
                           #帶出收款客戶            
                           CALL armt400_client_partner(g_rmda_m.rmdadocno,g_rmda_m.rmda005,'1') RETURNING g_rmda_m.rmda007
                           LET g_rmda_m_o.rmda007 = g_rmda_m.rmda007
                           DISPLAY BY NAME g_rmda_m.rmda007
            
                                          
                           #帶出收貨客戶
                           CALL armt400_client_partner(g_rmda_m.rmdadocno,g_rmda_m.rmda005,'2') RETURNING g_rmda_m.rmda006
                           LET g_rmda_m_o.rmda006 = g_rmda_m.rmda006
                           DISPLAY BY NAME g_rmda_m.rmda006
                        
                        
                           #帶出發票客戶
                           CALL armt400_client_partner(g_rmda_m.rmdadocno,g_rmda_m.rmda005,'3') RETURNING g_rmda_m.rmda008
                           LET g_rmda_m_o.rmda008 = g_rmda_m.rmda008
                           DISPLAY BY NAME g_rmda_m.rmda008

                        END IF
                        CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda007) RETURNING g_rmda_m.rmda007_desc
                        DISPLAY BY NAME g_rmda_m.rmda007_desc

                        CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda006) RETURNING g_rmda_m.rmda006_desc
                        DISPLAY BY NAME g_rmda_m.rmda006_desc

                        CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda008) RETURNING g_rmda_m.rmda008_desc
                        DISPLAY BY NAME g_rmda_m.rmda008_desc     
                        
                        CALL s_desc_get_acc_desc('263',g_rmda_m.rmda012) RETURNING g_rmda_m.rmda012_desc    #运输方式说明
                        DISPLAY g_rmda_m.rmda012_desc TO rmda012_desc                                      
                        
                        CALL s_desc_get_acc_desc('299',g_rmda_m.rmda019) RETURNING g_rmda_m.rmda019_desc    #运输状态说明
                        DISPLAY g_rmda_m.rmda019_desc TO rmda019_desc                                      
                     END IF
                  END IF               
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmda_m.rmda004 = g_rmda_m_o.rmda004
                  NEXT FIELD CURRENT
               END IF

            END IF 
            LET g_rmda_m_o.rmda004 = g_rmda_m.rmda004
            CALL armt400_set_entry(p_cmd)
            CALL armt400_set_no_entry(p_cmd)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda004
            #add-point:BEFORE FIELD rmda004 name="input.b.rmda004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda004
            #add-point:ON CHANGE rmda004 name="input.g.rmda004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda005
            
            #add-point:AFTER FIELD rmda005 name="input.a.rmda005"
            IF NOT cl_null(g_rmda_m.rmda005) THEN 
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmda_m.rmda005
               #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
               #160318-00025#21  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_10") THEN

                  CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda005) RETURNING g_rmda_m.rmda005_desc
                  DISPLAY BY NAME g_rmda_m.rmda005_desc

                  IF g_rmda_m.rmda005 <> g_rmda_m_o.rmda005 OR cl_null(g_rmda_m_o.rmda005) THEN
                     CALL armt400_rmda005_default()     #自動帶出客戶預設資料
   
                     #帶出收款客戶            
                     CALL armt400_client_partner(g_rmda_m.rmdadocno,g_rmda_m.rmda005,'1') RETURNING g_rmda_m.rmda007
                     LET g_rmda_m_o.rmda007 = g_rmda_m.rmda007
                     DISPLAY BY NAME g_rmda_m.rmda007
            
                     CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda007) RETURNING g_rmda_m.rmda007_desc
                     DISPLAY BY NAME g_rmda_m.rmda007_desc
                                          
                     #帶出收貨客戶
                     CALL armt400_client_partner(g_rmda_m.rmdadocno,g_rmda_m.rmda005,'2') RETURNING g_rmda_m.rmda006
                     LET g_rmda_m_o.rmda006 = g_rmda_m.rmda006
                     DISPLAY BY NAME g_rmda_m.rmda006
                  
                     CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda006) RETURNING g_rmda_m.rmda006_desc
                     DISPLAY BY NAME g_rmda_m.rmda006_desc
                  
                     #帶出發票客戶
                     CALL armt400_client_partner(g_rmda_m.rmdadocno,g_rmda_m.rmda008,'3') RETURNING g_rmda_m.rmda008
                     LET g_rmda_m_o.rmda008 = g_rmda_m.rmda008
                     DISPLAY BY NAME g_rmda_m.rmda008

                     CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda008) RETURNING g_rmda_m.rmda008_desc
                     DISPLAY BY NAME g_rmda_m.rmda008_desc
                  
                  END IF               
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmda_m.rmda005 = g_rmda_m_o.rmda005
                  CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda005) RETURNING g_rmda_m.rmda005_desc
                  DISPLAY BY NAME g_rmda_m.rmda005_desc
                  NEXT FIELD CURRENT
               
               END IF
            END IF
            LET g_rmda_m_o.rmda005 = g_rmda_m.rmda005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda005
            #add-point:BEFORE FIELD rmda005 name="input.b.rmda005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda005
            #add-point:ON CHANGE rmda005 name="input.g.rmda005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda006
            
            #add-point:AFTER FIELD rmda006 name="input.a.rmda006"
            CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda006) RETURNING g_rmda_m.rmda006_desc
            DISPLAY BY NAME g_rmda_m.rmda006_desc
            
            IF NOT cl_null(g_rmda_m.rmda006) THEN                                                   
               IF g_rmda_m.rmda006 <> g_rmda_m_o.rmda006 OR cl_null(g_rmda_m_o.rmda006) THEN
               
                  IF NOT s_axmt540_client_chk('','2',g_rmda_m.rmda005,g_rmda_m.rmda006) THEN
                     LET g_rmda_m.rmda006 = g_rmda_m_o.rmda006

                     CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda006) RETURNING g_rmda_m.rmda006_desc
                     DISPLAY BY NAME g_rmda_m.rmda006_desc

                     NEXT FIELD CURRENT
                  END IF
                  #檢查送貨地址
                  IF NOT armt400_rmda006_rmda011_chk() THEN
                     LET g_rmda_m.rmda006 = g_rmda_m_o.rmda006

                     CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda006) RETURNING g_rmda_m.rmda006_desc
                     DISPLAY BY NAME g_rmda_m.rmda006_desc

                     NEXT FIELD CURRENT
                  END IF                  
                  
               END IF                              
            END IF 

            LET g_rmda_m_o.rmda006 = g_rmda_m.rmda006

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda006
            #add-point:BEFORE FIELD rmda006 name="input.b.rmda006"
            IF cl_null(g_rmda_m.rmda005) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00145' #請先輸入客戶編號
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               NEXT FIELD rmda005
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda006
            #add-point:ON CHANGE rmda006 name="input.g.rmda006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda007
            
            #add-point:AFTER FIELD rmda007 name="input.a.rmda007"
            #账款客户
            CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda007) RETURNING g_rmda_m.rmda007_desc
            DISPLAY BY NAME g_rmda_m.rmda007_desc

            IF NOT cl_null(g_rmda_m.rmda007) THEN                              
               IF g_rmda_m.rmda007 <> g_rmda_m_o.rmda007 OR cl_null(g_rmda_m_o.rmda007) THEN
               
                  IF NOT s_axmt540_client_chk('','3',g_rmda_m.rmda005,g_rmda_m.rmda007) THEN
                     LET g_rmda_m.rmda007 = g_rmda_m_o.rmda007

                     CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda007) RETURNING g_rmda_m.rmda007_desc
                     DISPLAY BY NAME g_rmda_m.rmda007_desc

                     NEXT FIELD CURRENT
                  END IF
                  
               END IF            
            END IF 

            LET g_rmda_m_o.rmda007 = g_rmda_m.rmda007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda007
            #add-point:BEFORE FIELD rmda007 name="input.b.rmda007"
            IF cl_null(g_rmda_m.rmda005) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00145' #請先輸入客戶編號
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               NEXT FIELD rmda005
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda007
            #add-point:ON CHANGE rmda007 name="input.g.rmda007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda008
            
            #add-point:AFTER FIELD rmda008 name="input.a.rmda008"
            #发票客户
            CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda007) RETURNING g_rmda_m.rmda007_desc
            DISPLAY BY NAME g_rmda_m.rmda007_desc

            IF NOT cl_null(g_rmda_m.rmda007) THEN                              
               IF g_rmda_m.rmda007 <> g_rmda_m_o.rmda007 OR cl_null(g_rmda_m_o.rmda007) THEN
               
                  IF NOT s_axmt540_client_chk('','4',g_rmda_m.rmda005,g_rmda_m.rmda007) THEN
                     LET g_rmda_m.rmda007 = g_rmda_m_o.rmda007

                     CALL s_desc_get_trading_partner_abbr_desc(g_rmda_m.rmda007) RETURNING g_rmda_m.rmda007_desc
                     DISPLAY BY NAME g_rmda_m.rmda007_desc

                     NEXT FIELD CURRENT
                  END IF
                  
               END IF            
            END IF 

            LET g_rmda_m_o.rmda007 = g_rmda_m.rmda007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda008
            #add-point:BEFORE FIELD rmda008 name="input.b.rmda008"
            IF cl_null(g_rmda_m.rmda005) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00145' #請先輸入客戶編號
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               NEXT FIELD rmda005
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda008
            #add-point:ON CHANGE rmda008 name="input.g.rmda008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda009
            #add-point:BEFORE FIELD rmda009 name="input.b.rmda009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda009
            
            #add-point:AFTER FIELD rmda009 name="input.a.rmda009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda009
            #add-point:ON CHANGE rmda009 name="input.g.rmda009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda010
            #add-point:BEFORE FIELD rmda010 name="input.b.rmda010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda010
            
            #add-point:AFTER FIELD rmda010 name="input.a.rmda010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda010
            #add-point:ON CHANGE rmda010 name="input.g.rmda010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda011
            
            #add-point:AFTER FIELD rmda011 name="input.a.rmda011"
            CALL armt400_rmda011_ref()
            IF NOT cl_null(g_rmda_m.rmda011) THEN 
               IF g_rmda_m.rmda011 <> g_rmda_m_o.rmda011 OR cl_null(g_rmda_m_o.rmda011) THEN
               
                  IF NOT armt400_rmda006_rmda011_chk() THEN
                     LET g_rmda_m.rmda011 = g_rmda_m_o.rmda011
                     CALL armt400_rmda011_ref()

                     NEXT FIELD rmda011
                  END IF
               END IF            
            END IF 

            LET g_rmda_m_o.rmda011 = g_rmda_m.rmda011


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda011
            #add-point:BEFORE FIELD rmda011 name="input.b.rmda011"
            IF cl_null(g_rmda_m.rmda006) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00146'  #請先輸入收貨客戶
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()       

               NEXT FIELD rmda006
            END IF     
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda011
            #add-point:ON CHANGE rmda011 name="input.g.rmda011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD address
            #add-point:BEFORE FIELD address name="input.b.address"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD address
            
            #add-point:AFTER FIELD address name="input.a.address"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE address
            #add-point:ON CHANGE address name="input.g.address"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda012
            
            #add-point:AFTER FIELD rmda012 name="input.a.rmda012"
            CALL s_desc_get_acc_desc('263',g_rmda_m.rmda012) RETURNING g_rmda_m.rmda012_desc
            DISPLAY BY NAME g_rmda_m.rmda012_desc

            IF NOT cl_null(g_rmda_m.rmda012) THEN
               IF g_rmda_m.rmda012 <> g_rmda_m_o.rmda012 OR cl_null(g_rmda_m_o.rmda012) THEN
                  
                  IF NOT s_azzi650_chk_exist('263',g_rmda_m.rmda012) THEN
                     LET g_rmda_m.rmda012 = g_rmda_m_o.rmda012
                     LET g_rmda_m.rmda013 = g_rmda_m_o.rmda013
                     LET g_rmda_m.rmda014 = g_rmda_m_o.rmda014
                     CALL s_desc_get_acc_desc('263',g_rmda_m.rmda012) RETURNING g_rmda_m.rmda012_desc
                     DISPLAY BY NAME g_rmda_m.rmda012_desc

                     NEXT FIELD CURRENT
                  END IF
                  
#                  #檢查起運地
#                  IF NOT cl_null(g_rmda_m.rmda013) THEN
#                     IF NOT s_apmi011_check_location(g_rmda_m.rmda012,g_rmda_m.rmda013) THEN
#
#                        LET g_rmda_m.rmda012 = g_rmda_m_o.rmda012
#                        LET g_rmda_m.rmda013 = g_rmda_m_o.rmda013
#                        LET g_rmda_m.rmda014 = g_rmda_m_o.rmda014
#
#                        CALL s_desc_get_acc_desc('263',g_rmda_m.rmda012) RETURNING g_rmda_m.rmda012_desc
#                        DISPLAY BY NAME g_rmda_m.rmda012_desc
#
#                        NEXT FIELD CURRENT
#
#                     END IF
#                  END IF

#                  #檢查目的地
#                  IF NOT cl_null(g_rmda_m.rmda014) THEN
#                     IF NOT s_apmi011_check_location(g_rmda_m.rmda012,g_rmda_m.rmda014) THEN
#
#                        LET g_rmda_m.rmda012 = g_rmda_m_o.rmda012
#                        LET g_rmda_m.rmda013 = g_rmda_m_o.rmda013
#                        LET g_rmda_m.rmda014 = g_rmda_m_o.rmda014
#
#                        CALL s_desc_get_acc_desc('263',g_rmda_m.rmda012) RETURNING g_rmda_m.rmda012_desc
#                        DISPLAY BY NAME g_rmda_m.rmda012_desc
#
#                        NEXT FIELD CURRENT
#
#                     END IF
#                  END IF              
#
               END IF          
            END IF 
            
            LET g_rmda_m_o.rmda012 = g_rmda_m.rmda012


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda012
            #add-point:BEFORE FIELD rmda012 name="input.b.rmda012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda012
            #add-point:ON CHANGE rmda012 name="input.g.rmda012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda013
            
            #add-point:AFTER FIELD rmda013 name="input.a.rmda013"
            CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda013) RETURNING g_rmda_m.rmda013_desc
            DISPLAY BY NAME g_rmda_m.rmda013_desc
            
            IF NOT cl_null(g_rmda_m.rmda013) THEN
               IF g_rmda_m.rmda013 <> g_rmda_m_o.rmda013 OR cl_null(g_rmda_m_o.rmda013) THEN
               
                  IF NOT s_apmi011_check_location(g_rmda_m.rmda012,g_rmda_m.rmda013) THEN
                     LET g_rmda_m.rmda013 = g_rmda_m_o.rmda013
                     
                     CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda013) RETURNING g_rmda_m.rmda013_desc
                     DISPLAY BY NAME g_rmda_m.rmda013_desc
          
                     NEXT FIELD CURRENT
                  END IF
               END IF
           
            END IF 
            
            LET g_rmda_m_o.rmda013 = g_rmda_m.rmda013
            
            #檢查目的地
            IF NOT cl_null(g_rmda_m.rmda014) THEN
               IF NOT s_apmi011_check_location(g_rmda_m.rmda012,g_rmda_m.rmda014) THEN
                  LET g_rmda_m_o.rmda014 = ''
                  NEXT FIELD rmda014
               END IF
            END IF
            
            CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda014) RETURNING g_rmda_m.rmda014_desc
            DISPLAY BY NAME g_rmda_m.rmda014_desc  

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda013
            #add-point:BEFORE FIELD rmda013 name="input.b.rmda013"
            IF cl_null(g_rmda_m.rmda012) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00085'  #請先輸入運輸方式
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               NEXT FIELD rmda012
            END IF  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda013
            #add-point:ON CHANGE rmda013 name="input.g.rmda013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda014
            
            #add-point:AFTER FIELD rmda014 name="input.a.rmda014"
            CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda014) RETURNING g_rmda_m.rmda014_desc
            DISPLAY BY NAME g_rmda_m.rmda014_desc
            
            IF NOT cl_null(g_rmda_m.rmda014) THEN
               IF g_rmda_m.rmda014 <> g_rmda_m_o.rmda014 OR cl_null(g_rmda_m_o.rmda014) THEN
                           
                  IF NOT s_apmi011_check_location(g_rmda_m.rmda012,g_rmda_m.rmda014) THEN
                     LET g_rmda_m.rmda014 = g_rmda_m_o.rmda014
                        
                     CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda014) RETURNING g_rmda_m.rmda014_desc
                     DISPLAY BY NAME g_rmda_m.rmda014_desc
                        
                     NEXT FIELD CURRENT
               
                  END IF
               END IF
            END IF
            
            LET g_rmda_m_o.rmda014 = g_rmda_m.rmda014

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda014
            #add-point:BEFORE FIELD rmda014 name="input.b.rmda014"
            IF cl_null(g_rmda_m.rmda012) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00085'  #請先輸入運輸方式
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               NEXT FIELD rmda012
            END IF  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda014
            #add-point:ON CHANGE rmda014 name="input.g.rmda014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda015
            
            #add-point:AFTER FIELD rmda015 name="input.a.rmda015"
            CALL s_desc_get_trading_partner_full_desc(g_rmda_m.rmda015) RETURNING g_rmda_m.rmda015_desc
            DISPLAY BY NAME g_rmda_m.rmda015_desc

            IF NOT cl_null(g_rmda_m.rmda015) THEN
               IF g_rmda_m.rmda015 <> g_rmda_m_o.rmda015 OR cl_null(g_rmda_m_o.rmda015) THEN

                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rmda_m.rmda015
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pmaa001_1") THEN
                     LET g_rmda_m.rmda015 = g_rmda_m_o.rmda015

                     CALL s_desc_get_trading_partner_full_desc(g_rmda_m.rmda015) RETURNING g_rmda_m.rmda015_desc
                     DISPLAY BY NAME g_rmda_m.rmda015_desc

                     NEXT FIELD CURRENT
                  END IF
               END IF            
            END IF

            LET g_rmda_m_o.rmda015 = g_rmda_m.rmda015

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda015
            #add-point:BEFORE FIELD rmda015 name="input.b.rmda015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda015
            #add-point:ON CHANGE rmda015 name="input.g.rmda015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda016
            #add-point:BEFORE FIELD rmda016 name="input.b.rmda016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda016
            
            #add-point:AFTER FIELD rmda016 name="input.a.rmda016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda016
            #add-point:ON CHANGE rmda016 name="input.g.rmda016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda017
            #add-point:BEFORE FIELD rmda017 name="input.b.rmda017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda017
            
            #add-point:AFTER FIELD rmda017 name="input.a.rmda017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda017
            #add-point:ON CHANGE rmda017 name="input.g.rmda017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda018
            
            #add-point:AFTER FIELD rmda018 name="input.a.rmda018"
            
            LET g_rmda_m.rmda018_desc = ''
            IF NOT cl_null(g_rmda_m.rmda018) THEN
               INITIALIZE g_chkparam.* TO NULL               
               LET g_chkparam.arg1 = g_rmda_m.rmda005
               LET g_chkparam.arg2 = g_rmda_m.rmda018
               IF NOT cl_chk_exist("v_xmao002") THEN
                  LET g_rmda_m.rmda018 = g_rmda_m_t.rmda018
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rmda_m.rmda005
                  LET g_ref_fields[2] = g_rmda_m.rmda018
                  CALL ap_ref_array2(g_ref_fields,"SELECT xmaol004 FROM xmaol_t WHERE xmaolent='"||g_enterprise||"' AND xmaol001=? AND xmaol002=? AND xmaol003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_rmda_m.rmda018_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_rmda_m.rmda018_desc
                  NEXT FIELD CURRENT
               END IF
            END IF              
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda018
            #add-point:BEFORE FIELD rmda018 name="input.b.rmda018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda018
            #add-point:ON CHANGE rmda018 name="input.g.rmda018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmda019
            
            #add-point:AFTER FIELD rmda019 name="input.a.rmda019"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmda_m.rmda019
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='299' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmda_m.rmda019_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmda_m.rmda019_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmda019
            #add-point:BEFORE FIELD rmda019 name="input.b.rmda019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmda019
            #add-point:ON CHANGE rmda019 name="input.g.rmda019"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdadocno
            #add-point:ON ACTION controlp INFIELD rmdadocno name="input.c.rmdadocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmdadocno             #給予default值
            
            LET l_ooef004 = ''
            SELECT ooef004 
              INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise 
               AND ooef001 = g_site 
               AND ooefstus = 'Y'
            #給予arg
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog
            #160711-00040#28 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#28 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_rmda_m.rmdadocno = g_qryparam.return1              
            DISPLAY g_rmda_m.rmdadocno TO rmdadocno              #
            CALL s_aooi200_get_slip_desc(g_rmda_m.rmdadocno) RETURNING g_rmda_m.rmdadocno_desc
            DISPLAY BY NAME g_rmda_m.rmdadocno_desc

            NEXT FIELD rmdadocno                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.rmdasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdasite
            #add-point:ON ACTION controlp INFIELD rmdasite name="input.c.rmdasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdadocdt
            #add-point:ON ACTION controlp INFIELD rmdadocdt name="input.c.rmdadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda001
            #add-point:ON ACTION controlp INFIELD rmda001 name="input.c.rmda001"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda002
            #add-point:ON ACTION controlp INFIELD rmda002 name="input.c.rmda002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda002             #給予default值

            #給予arg
          
            CALL q_ooag001()                                #呼叫開窗

            LET g_rmda_m.rmda002 = g_qryparam.return1              
            DISPLAY g_rmda_m.rmda002 TO rmda002              #
            
            CALL s_desc_get_person_desc(g_rmda_m.rmda002) RETURNING g_rmda_m.rmda002_desc
            DISPLAY BY NAME g_rmda_m.rmda002_desc

            NEXT FIELD rmda002                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.rmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda003
            #add-point:ON ACTION controlp INFIELD rmda003 name="input.c.rmda003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rmda_m.rmda003  #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_rmda_m.rmdadocdt            
            CALL q_ooeg001()                            #呼叫開窗
            LET g_rmda_m.rmda003 = g_qryparam.return1              
            DISPLAY g_rmda_m.rmda003 TO rmda003            
            CALL s_desc_get_department_desc(g_rmda_m.rmda003) RETURNING g_rmda_m.rmda003_desc
            DISPLAY BY NAME g_rmda_m.rmda003_desc            
            NEXT FIELD rmda003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.rmdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdastus
            #add-point:ON ACTION controlp INFIELD rmdastus name="input.c.rmdastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda004
            #add-point:ON ACTION controlp INFIELD rmda004 name="input.c.rmda004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda004             #給予default值
            LET g_qryparam.where = " rmaastus = 'S' "
            #160204-00004#4 Add By Ken 160222(S)
            #組合過濾前後置單據資料SQL
            IF NOT cl_null(g_rmda_m.rmdadocno) THEN
               CALL s_aooi210_get_check_sql(g_site,'',g_rmda_m.rmdadocno,'4','','rmaadocno') RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",l_where
                  CALL q_rmaadocno()
               END IF
            END IF
            #160204-00004#4 Add By Ken 160222(E)            
            #CALL q_rmaadocno()        #160204-00004#4 Mark By Ken 160222                       #呼叫開窗

            LET g_rmda_m.rmda004 = g_qryparam.return1              
            LET g_rmda_m.rmda005 = g_qryparam.return2 
            DISPLAY g_rmda_m.rmda004 TO rmda004              #
            DISPLAY g_rmda_m.rmda005 TO rmda005 #客戶編號
            NEXT FIELD rmda004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda005
            #add-point:ON ACTION controlp INFIELD rmda005 name="input.c.rmda005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda005             #給予default值
            LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                                #呼叫開窗

            LET g_rmda_m.rmda005 = g_qryparam.return1              

            DISPLAY g_rmda_m.rmda005 TO rmda005              #

            NEXT FIELD rmda005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmda006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda006
            #add-point:ON ACTION controlp INFIELD rmda006 name="input.c.rmda006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda006             #給予default值
            LET g_qryparam.default2 = g_rmda_m.rmda006_desc
            #給予arg
            LET g_qryparam.arg1 = g_rmda_m.rmda005 #s
            LET g_qryparam.arg2 = g_site

            CALL q_pmac002_6()                                #呼叫開窗

            LET g_rmda_m.rmda006 = g_qryparam.return1              
            LET g_rmda_m.rmda006_desc = g_qryparam.return2 
            DISPLAY g_rmda_m.rmda006 TO rmda006              #
            DISPLAY g_rmda_m.rmda006_desc TO rmda006_desc
            NEXT FIELD rmda006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmda007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda007
            #add-point:ON ACTION controlp INFIELD rmda007 name="input.c.rmda007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda007             #給予default值
            LET g_qryparam.default2 = g_rmda_m.rmda007_desc
            #給予arg
            LET g_qryparam.arg1 = g_rmda_m.rmda005
            LET g_qryparam.arg2 = g_site

            CALL q_pmac002_5()                                #呼叫開窗

            LET g_rmda_m.rmda007 = g_qryparam.return1              
            LET g_rmda_m.rmda007_desc = g_qryparam.return2 
            DISPLAY g_rmda_m.rmda007 TO rmda007              #
            DISPLAY g_rmda_m.rmda007_desc TO rmda007_desc
            NEXT FIELD rmda007                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.rmda008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda008
            #add-point:ON ACTION controlp INFIELD rmda008 name="input.c.rmda008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda008             #給予default值
            LET g_qryparam.default2 = g_rmda_m.rmda008_desc
            #給予arg
            LET g_qryparam.arg1 = g_rmda_m.rmda005
            LET g_qryparam.arg2 = g_site

            CALL q_pmac002_7()                                #呼叫開窗

            LET g_rmda_m.rmda008 = g_qryparam.return1              
            LET g_rmda_m.rmda008_desc = g_qryparam.return2 
            DISPLAY g_rmda_m.rmda008 TO rmda008              #
            DISPLAY g_rmda_m.rmda008_desc TO pmac002 #交易夥伴編號
            NEXT FIELD rmda008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmda009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda009
            #add-point:ON ACTION controlp INFIELD rmda009 name="input.c.rmda009"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmda010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda010
            #add-point:ON ACTION controlp INFIELD rmda010 name="input.c.rmda010"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmda011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda011
            #add-point:ON ACTION controlp INFIELD rmda011 name="input.c.rmda011"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = s_axmt500_get_pmaa027(g_rmda_m.rmda006)

            CALL q_oofb019_1()                                #呼叫開窗

            LET g_rmda_m.rmda011 = g_qryparam.return1              

            DISPLAY g_rmda_m.rmda011 TO rmda011              #
            CALL armt400_rmda011_ref()
            NEXT FIELD rmda011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.address
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD address
            #add-point:ON ACTION controlp INFIELD address name="input.c.address"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmda012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda012
            #add-point:ON ACTION controlp INFIELD rmda012 name="input.c.rmda012"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda012             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = '263'

            CALL q_oocq002()                                #呼叫開窗

            LET g_rmda_m.rmda012 = g_qryparam.return1              
            DISPLAY g_rmda_m.rmda012 TO rmda012              #
            CALL s_desc_get_acc_desc('263',g_rmda_m.rmda012) RETURNING g_rmda_m.rmda012_desc
            DISPLAY BY NAME g_rmda_m.rmda012_desc
            NEXT FIELD rmda012                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.rmda013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda013
            #add-point:ON ACTION controlp INFIELD rmda013 name="input.c.rmda013"
            IF cl_null(g_rmda_m.rmda012) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00085'  #請先輸入運輸方式
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               NEXT FIELD rmda012
            END IF   
            
            LET l_oocq019 = ''
            SELECT oocq019 INTO l_oocq019
              FROM oocq_t
             WHERE oocqent = g_enterprise
               AND oocq001 = '263'
               AND oocq002 = g_rmda_m.rmda012
            
            CASE
               WHEN l_oocq019 = '1' OR l_oocq019 = '4'      #陸運、海運
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
	               LET g_qryparam.reqry = FALSE

                  LET g_qryparam.default1 = g_rmda_m.rmda013             #給予default值

                  LET g_qryparam.arg1 = '315'
                  CALL q_oocq002()                           #呼叫開窗
                  
                  LET g_rmda_m.rmda013 = g_qryparam.return1        #將開窗取得的值回傳到變數
                  DISPLAY g_rmda_m.rmda013 TO rmda013              #顯示到畫面上
                 
                    
               WHEN l_oocq019 = '2'      #空運
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
	               LET g_qryparam.reqry = FALSE	              
	              
	               LET g_qryparam.default1 = g_rmda_m.rmda013             #給予default值
	              
	               LET g_qryparam.arg1 = '262'
	              
                  CALL q_oocq002()                           #呼叫開窗

                  LET g_rmda_m.rmda013 = g_qryparam.return1        #將開窗取得的值回傳到變數
                  DISPLAY g_rmda_m.rmda013 TO rmda013              #顯示到畫面上
               
               WHEN l_oocq019 = '3'      #其它
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
	               LET g_qryparam.reqry = FALSE
	              
	               LET g_qryparam.default1 = g_rmda_m.rmda013             #給予default值
	              
	               LET g_qryparam.arg1 = '276'
	              
                  CALL q_oocq002()                           #呼叫開窗

                  LET g_rmda_m.rmda013 = g_qryparam.return1        #將開窗取得的值回傳到變數
                  DISPLAY g_rmda_m.rmda013 TO rmda013              #顯示到畫面上
              
            END CASE
            
            CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda013) RETURNING g_rmda_m.rmda013_desc
            DISPLAY BY NAME g_rmda_m.rmda013_desc
            
            NEXT FIELD rmda013     #返回原欄位 
            #END add-point
 
 
         #Ctrlp:input.c.rmda014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda014
            #add-point:ON ACTION controlp INFIELD rmda014 name="input.c.rmda014"
            IF cl_null(g_rmda_m.rmda012) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00085'  #請先輸入運輸方式
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               NEXT FIELD rmda012
            END IF   
            
            LET l_oocq019 = ''
            SELECT oocq019 INTO l_oocq019
              FROM oocq_t
             WHERE oocqent = g_enterprise
               AND oocq001 = '263'
               AND oocq002 = g_rmda_m.rmda012
            
            CASE
               WHEN l_oocq019 = '1' OR l_oocq019 = '4'      #陸運、海運
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
	               LET g_qryparam.reqry = FALSE

                  LET g_qryparam.default1 = g_rmda_m.rmda014             #給予default值

                  LET g_qryparam.arg1 = '315'
                  CALL q_oocq002()                           #呼叫開窗
                  
                  LET g_rmda_m.rmda014 = g_qryparam.return1        #將開窗取得的值回傳到變數
                  DISPLAY g_rmda_m.rmda014 TO rmda014              #顯示到畫面上
                 
                    
               WHEN l_oocq019 = '2'      #空運
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
	               LET g_qryparam.reqry = FALSE	              
	              
	               LET g_qryparam.default1 = g_rmda_m.rmda014             #給予default值
	              
	               LET g_qryparam.arg1 = '262'
	              
                  CALL q_oocq002()                           #呼叫開窗

                  LET g_rmda_m.rmda014 = g_qryparam.return1        #將開窗取得的值回傳到變數
                  DISPLAY g_rmda_m.rmda014 TO rmda014              #顯示到畫面上
               
               WHEN l_oocq019 = '3'      #其它
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
	               LET g_qryparam.reqry = FALSE
	              
	               LET g_qryparam.default1 = g_rmda_m.rmda014             #給予default值
	              
	               LET g_qryparam.arg1 = '276'
	              
                  CALL q_oocq002()                           #呼叫開窗

                  LET g_rmda_m.rmda014 = g_qryparam.return1        #將開窗取得的值回傳到變數
                  DISPLAY g_rmda_m.rmda014 TO rmda014              #顯示到畫面上
              
            END CASE
            
            CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda014) RETURNING g_rmda_m.rmda014_desc
            DISPLAY BY NAME g_rmda_m.rmda014_desc
            
            NEXT FIELD rmda014     #返回原欄位 
            #END add-point
 
 
         #Ctrlp:input.c.rmda015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda015
            #add-point:ON ACTION controlp INFIELD rmda015 name="input.c.rmda015"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda015             #給予default值
            CALL q_pmaa001_3()                                #呼叫開窗

            LET g_rmda_m.rmda015 = g_qryparam.return1              

            DISPLAY g_rmda_m.rmda015 TO rmda015              #
            CALL s_desc_get_trading_partner_full_desc(g_rmda_m.rmda015) RETURNING g_rmda_m.rmda015_desc
            DISPLAY BY NAME g_rmda_m.rmda015_desc
            NEXT FIELD rmda015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmda016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda016
            #add-point:ON ACTION controlp INFIELD rmda016 name="input.c.rmda016"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmda017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda017
            #add-point:ON ACTION controlp INFIELD rmda017 name="input.c.rmda017"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmda018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda018
            #add-point:ON ACTION controlp INFIELD rmda018 name="input.c.rmda018"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda018             #給予default值

            #給予arg
            LET g_qryparam.where = " xmao001 = '",g_rmda_m.rmda005,"'"             
            
            CALL q_xmao002()                                #呼叫開窗

            LET g_rmda_m.rmda018 = g_qryparam.return1              
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmda_m.rmda018
            CALL ap_ref_array2(g_ref_fields,"SELECT xmaol004 FROM xmaol_t WHERE xmaolent='"||g_enterprise||"' AND xmaol001='"||g_rmda_m.rmda005||"' AND xmaol002=? AND xmaol003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmda_m.rmda018_desc = '', g_rtn_fields[1] , ''
            

            DISPLAY g_rmda_m.rmda018 TO rmda018              #
            DISPLAY g_rmda_m.rmda018_desc TO rmda018_desc              #

            NEXT FIELD rmda018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmda019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmda019
            #add-point:ON ACTION controlp INFIELD rmda019 name="input.c.rmda019"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmda_m.rmda019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '299'
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_rmda_m.rmda019 = g_qryparam.return1              
            
            CALL s_desc_get_acc_desc('299',g_rmda_m.rmda019) RETURNING g_rmda_m.rmda019_desc
            
            DISPLAY g_rmda_m.rmda019 TO rmda019              #
            DISPLAY g_rmda_m.rmda019_desc TO rmda019_desc              #

            NEXT FIELD rmda019                        #返回原欄位
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rmda_m.rmdadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #自動產生單號
               CALL s_aooi200_gen_docno(g_site,g_rmda_m.rmdadocno,g_rmda_m.rmdadocdt,g_prog)
               RETURNING l_success,g_rmda_m.rmdadocno
               IF l_success = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_rmda_m.rmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD rmdadocno
               END IF
               DISPLAY BY NAME g_rmda_m.rmdadocno
               
               #end add-point
               
               INSERT INTO rmda_t (rmdaent,rmdadocno,rmdasite,rmdadocdt,rmda001,rmda002,rmda003,rmdastus, 
                   rmda004,rmda005,rmda006,rmda007,rmda008,rmda009,rmda010,rmda011,rmda012,rmda013,rmda014, 
                   rmda015,rmda016,rmda017,rmda018,rmda019,rmdaownid,rmdaowndp,rmdacrtid,rmdacrtdp,rmdacrtdt, 
                   rmdamodid,rmdamoddt,rmdacnfid,rmdacnfdt,rmdapstid,rmdapstdt)
               VALUES (g_enterprise,g_rmda_m.rmdadocno,g_rmda_m.rmdasite,g_rmda_m.rmdadocdt,g_rmda_m.rmda001, 
                   g_rmda_m.rmda002,g_rmda_m.rmda003,g_rmda_m.rmdastus,g_rmda_m.rmda004,g_rmda_m.rmda005, 
                   g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010, 
                   g_rmda_m.rmda011,g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015, 
                   g_rmda_m.rmda016,g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019,g_rmda_m.rmdaownid, 
                   g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtid,g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid, 
                   g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid,g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rmda_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               CALL s_transaction_end('Y','0')     ##160726-00003#1 zhujing 
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #2016-2-25 zhujing add----(S)
#               LET g_ask = TRUE    ##160726-00003#1 zhujing
               IF NOT cl_null(g_rmda_m.rmda004) AND g_ask = TRUE THEN   #RMA单号 ##160726-00003#1 zhujing
                  LET l_msg = 'arm-00045'   #是否由[RMA维护作业(armt100)]自动产生单身资料！
                  IF cl_ask_confirm(l_msg) THEN
                        CALL armt400_auto_insert() RETURNING l_success #自動帶入出通單單身
#                        CALL cl_err_collect_init()
                        IF NOT l_success THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.code   = 'arm-00025' 
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_ask = FALSE       ##160726-00003#1 zhujing
#                           CALL s_transaction_end('N','0')
                        END IF
#                        CALL cl_err_collect_show()
                  END IF
               END IF
                               
#               LET g_ask = FALSE
              
#               IF NOT l_success THEN
#                  CALL s_transaction_end('N','0')    ##160726-00003#1 zhujing
#                  CONTINUE DIALOG
#               END IF                              
               
               CALL armt400_b_fill()
               #2016-2-25 zhujing add----(E)   
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL armt400_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL armt400_b_fill()
                  CALL armt400_b_fill2('0')
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
               CALL armt400_rmda_t_mask_restore('restore_mask_o')
               
               UPDATE rmda_t SET (rmdadocno,rmdasite,rmdadocdt,rmda001,rmda002,rmda003,rmdastus,rmda004, 
                   rmda005,rmda006,rmda007,rmda008,rmda009,rmda010,rmda011,rmda012,rmda013,rmda014,rmda015, 
                   rmda016,rmda017,rmda018,rmda019,rmdaownid,rmdaowndp,rmdacrtid,rmdacrtdp,rmdacrtdt, 
                   rmdamodid,rmdamoddt,rmdacnfid,rmdacnfdt,rmdapstid,rmdapstdt) = (g_rmda_m.rmdadocno, 
                   g_rmda_m.rmdasite,g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002,g_rmda_m.rmda003, 
                   g_rmda_m.rmdastus,g_rmda_m.rmda004,g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007, 
                   g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010,g_rmda_m.rmda011,g_rmda_m.rmda012, 
                   g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016,g_rmda_m.rmda017, 
                   g_rmda_m.rmda018,g_rmda_m.rmda019,g_rmda_m.rmdaownid,g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtid, 
                   g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
                   g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstdt)
                WHERE rmdaent = g_enterprise AND rmdadocno = g_rmdadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rmda_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL armt400_rmda_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rmda_m_t)
               LET g_log2 = util.JSON.stringify(g_rmda_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rmdadocno_t = g_rmda_m.rmdadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="armt400.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rmdb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel
            LET g_action_choice="s_lot_sel"
            IF cl_auth_chk_act("s_lot_sel") THEN
               
               #add-point:ON ACTION s_lot_sel name="input.detail_input.page1.s_lot_sel"
               #160202-00019#5---add---begin
               IF cl_null(g_rmdb_d[l_ac].rmdb007) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00126'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               IF NOT cl_null(g_rmda_m.rmdadocno) AND
                  NOT cl_null(g_rmdb_d[l_ac].rmdbseq) AND
                  NOT cl_null(g_rmdb_d[l_ac].rmdb003) AND g_rmdb_d[l_ac].rmdb012 = 'N' THEN
                  IF NOT cl_null(g_rmdb_d[l_ac].rmdb006) THEN 
                     CALL armt400_inao('1') RETURNING l_success                  
                  END IF                     
               END IF
               #160202-00019#5---add---end
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION armt400_call_armt400_01
            LET g_action_choice="armt400_call_armt400_01"
            IF cl_auth_chk_act("armt400_call_armt400_01") THEN
               
               #add-point:ON ACTION armt400_call_armt400_01 name="input.detail_input.page1.armt400_call_armt400_01"
               CALL armt400_01(g_rmda_m.rmdadocno,
                   g_rmdb_d[g_detail_idx].rmdbseq,g_rmdb_d[g_detail_idx].rmdb003,g_rmdb_d[g_detail_idx].rmdb004,
                   g_rmdb_d[g_detail_idx].rmdb005,g_rmdb_d[g_detail_idx].rmdb006,g_rmdb_d[g_detail_idx].rmdbsite,
                   g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002)      #160202-00019#5
                   RETURNING l_success,l_rollback,l_rmdb007,l_rmdb008,l_rmdb009,l_rmdb010
               
               IF l_rollback THEN  #多庫儲批資料錯誤必須rollback
                  CLOSE armt400_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF

               IF l_success THEN
                  IF NOT cl_null(l_rmdb007) THEN  #只有一筆
                     LET g_rmdb_d[l_ac].rmdb012 = 'N'
                     LET g_rmdb_d[l_ac].rmdb007 = l_rmdb007
                     LET g_rmdb_d[l_ac].rmdb008 = l_rmdb008
                     LET g_rmdb_d[l_ac].rmdb009 = l_rmdb009
                     LET g_rmdb_d[l_ac].rmdb010 = l_rmdb010
                  ELSE
                     LET g_rmdb_d[l_ac].rmdb012 = 'Y'
                     LET g_rmdb_d[l_ac].rmdb007 = ' '
                     LET g_rmdb_d[l_ac].rmdb008 = ' '
                     LET g_rmdb_d[l_ac].rmdb009 = ' '
                     LET g_rmdb_d[l_ac].rmdb010 = ' '
                  END IF
#                  IF NOT cl_null(l_rmdb007) THEN  #只有一筆
#                     LET g_rmdb_d[l_ac].rmdb012 = 'N'
#                     LET g_rmdb_d[l_ac].rmdb007 = l_rmdb007
#                     LET g_rmdb_d[l_ac].rmdb008 = l_rmdb008
#                     LET g_rmdb_d[l_ac].rmdb009 = l_rmdb009
#                     LET g_rmdb_d[l_ac].rmdb010 = l_rmdb010
#                  ELSE
#                     LET g_rmdb_d[l_ac].rmdb012 = 'Y'
#                     LET g_rmdb_d[l_ac].rmdb007 = l_rmdb007
#                     LET g_rmdb_d[l_ac].rmdb008 = l_rmdb008
#                     LET g_rmdb_d[l_ac].rmdb009 = l_rmdb009
#                     LET g_rmdb_d[l_ac].rmdb010 = l_rmdb010
#                  END IF

                  CALL s_desc_get_stock_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007) RETURNING g_rmdb_d[l_ac].rmdb007_desc
                  CALL s_desc_get_locator_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008) RETURNING g_rmdb_d[l_ac].rmdb008_desc
               END IF
               
               LET l_rmdbseq_backup = g_rmdb_d[l_ac].rmdbseq #紀錄產生庫儲批所用的項次
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            LET l_num = 0
            SELECT COUNT(rmdbseq) INTO l_num
              FROM rmdb_t
             WHERE rmdbent = g_enterprise
               AND rmdbsite = g_site
               AND rmdbdocno = g_rmda_m.rmdadocno
            #2016-5-27 zhujing add----(S)
#            LET g_ask = TRUE    ##160726-00003#1 zhujing
            IF NOT cl_null(g_rmda_m.rmda004) AND (l_num = 0 OR cl_null(l_num)) AND g_ask = TRUE THEN   #RMA单号 #160726-00003#1 zhujing
               LET l_msg = 'arm-00045'   #是否由[RMA维护作业(armt100)]自动产生单身资料！
               IF cl_ask_confirm(l_msg) THEN
                     CALL armt400_auto_insert() RETURNING l_success #自動帶入出通單單身
#                     CALL cl_err_collect_init()
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.code   = 'arm-00025' 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_ask = FALSE   ##160726-00003#1 zhujing
#                        CALL s_transaction_end('N','0')
                     END IF
#                     CALL cl_err_collect_show()
               END IF
            END IF
                            
#            LET g_ask = FALSE   ##160726-00003#1 zhujing
            
#            IF NOT l_success THEN     ##160726-00003#1 zhujing
#               CALL s_transaction_end('N','0')
#               CONTINUE DIALOG
#            END IF                              
            
#            CALL armt400_b_fill()
            #2016-5-27 zhujing add----(E)   
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rmdb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL armt400_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rmdb_d.getLength()
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
            OPEN armt400_cl USING g_enterprise,g_rmda_m.rmdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt400_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE armt400_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rmdb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rmdb_d[l_ac].rmdbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rmdb_d_t.* = g_rmdb_d[l_ac].*  #BACKUP
               LET g_rmdb_d_o.* = g_rmdb_d[l_ac].*  #BACKUP
               CALL armt400_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL armt400_set_no_entry_b(l_cmd)
               IF NOT armt400_lock_b("rmdb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH armt400_bcl INTO g_rmdb_d[l_ac].rmdbseq,g_rmdb_d[l_ac].rmdb001,g_rmdb_d[l_ac].rmdb002, 
                      g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb014, 
                      g_rmdb_d[l_ac].rmdb006,g_rmdb_d[l_ac].rmdb013,g_rmdb_d[l_ac].rmdb015,g_rmdb_d[l_ac].rmdb016, 
                      g_rmdb_d[l_ac].rmdb017,g_rmdb_d[l_ac].rmdb012,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008, 
                      g_rmdb_d[l_ac].rmdb009,g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdb011,g_rmdb_d[l_ac].rmdbsite 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rmdb_d_t.rmdbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rmdb_d_mask_o[l_ac].* =  g_rmdb_d[l_ac].*
                  CALL armt400_rmdb_t_mask()
                  LET g_rmdb_d_mask_n[l_ac].* =  g_rmdb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL armt400_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET l_rmdbseq_backup = g_rmdb_d[l_ac].rmdbseq #紀錄產生庫儲批所用的項次
            CALL armt400_detail_action_hidden(l_ac)
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
            INITIALIZE g_rmdb_d[l_ac].* TO NULL 
            INITIALIZE g_rmdb_d_t.* TO NULL 
            INITIALIZE g_rmdb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rmdb_d[l_ac].rmdb014 = "1"
      LET g_rmdb_d[l_ac].rmdb006 = "0"
      LET g_rmdb_d[l_ac].rmdb017 = "0"
      LET g_rmdb_d[l_ac].rmdb012 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_rmdb_d_t.* = g_rmdb_d[l_ac].*     #新輸入資料
            LET g_rmdb_d_o.* = g_rmdb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL armt400_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            LET g_rmdb_d[l_ac].rmdb014 = NULL   #2016-5-30 zhujing add
            IF cl_null(g_rmda_m.rmda004) THEN
               CALL cl_set_comp_entry("rmdb001",TRUE)
            ELSE
               LET g_rmdb_d[l_ac].rmdb001 = g_rmda_m.rmda004
               DISPLAY BY NAME g_rmdb_d[l_ac].rmdb001
               CALL cl_set_comp_entry("rmdb001",FALSE)
            END IF
            #160816-00066#3 add-S
            CALL s_aooi200_get_slip(g_rmda_m.rmdadocno) RETURNING l_flag1,l_ooac002    
            LET g_rmdb_d[l_ac].rmdb007 = cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0042')
            #160816-00066#3 add-E
            #end add-point
            CALL armt400_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rmdb_d[li_reproduce_target].* = g_rmdb_d[li_reproduce].*
 
               LET g_rmdb_d[li_reproduce_target].rmdbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            #預設RMA單號
            IF NOT cl_null(g_rmda_m.rmda004) THEN
               LET g_rmdb_d[l_ac].rmdb001 = g_rmda_m.rmda004
            END IF
            #預設項次
            IF cl_null(g_rmdb_d[l_ac].rmdbseq) THEN
               SELECT MAX(rmdbseq)+1
                 INTO g_rmdb_d[l_ac].rmdbseq
                 FROM rmdb_t
                WHERE rmdbent = g_enterprise
                  AND rmdbsite = g_site
                  AND rmdbdocno = g_rmda_m.rmdadocno 

               IF cl_null(g_rmdb_d[l_ac].rmdbseq) THEN
                 LET g_rmdb_d[l_ac].rmdbseq = 1
               END IF
            END IF
            LET g_rmdb_d[l_ac].rmdbsite = g_site
            LET l_rmdbseq_backup = g_rmdb_d[l_ac].rmdbseq #紀錄產生庫儲批所用的項次
            CALL armt400_detail_action_hidden(l_ac)
            LET g_rmdb_d_t.* = g_rmdb_d[l_ac].*     #新輸入資料
            LET g_rmdb_d_o.* = g_rmdb_d[l_ac].*     #新輸入資料
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
            SELECT COUNT(1) INTO l_count FROM rmdb_t 
             WHERE rmdbent = g_enterprise AND rmdbdocno = g_rmda_m.rmdadocno
 
               AND rmdbseq = g_rmdb_d[l_ac].rmdbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmda_m.rmdadocno
               LET gs_keys[2] = g_rmdb_d[g_detail_idx].rmdbseq
               CALL armt400_insert_b('rmdb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
#               LET l_rmdbseq_backup = g_rmdb_d[l_ac].rmdbseq  #備份單身覆出明細項次
#               IF g_rmdb_d[l_ac].rmdb012 = 'Y' THEN
#                  LET g_rmdb2_d[1].rmdcseq1 = '1'
#                  LET g_rmdb2_d[1].rmdc001 = g_rmdb_d[l_ac].rmdb003
#                  LET g_rmdb2_d[1].rmdc001_desc = g_rmdb_d[l_ac].rmdb003_desc
#                  LET g_rmdb2_d[1].rmdc001_desc_1 = g_rmdb_d[l_ac].rmdb003_desc_1
#                  LET g_rmdb2_d[1].rmdc002 = g_rmdb_d[l_ac].rmdb004
#                  LET g_rmdb2_d[1].rmdc002_desc = g_rmdb_d[l_ac].rmdb004_desc
#                  LET g_rmdb2_d[1].rmdc003 = g_rmdb_d[l_ac].rmdb005
#                  LET g_rmdb2_d[1].rmdc004 = g_rmdb_d[l_ac].rmdb006
#                  LET g_rmdb2_d[1].rmdcsite = g_site
#                  LET g_rmdb2_d[1].rmdc005 = ' '
#                  LET g_rmdb2_d[1].rmdc006 = ' '
#                  LET g_rmdb2_d[1].rmdc007 = ' '
#                  LET g_rmdb2_d[1].rmdc008 = ' '
#                  
#                  INITIALIZE gs_keys TO NULL 
#                  LET g_detail_idx2 = 1
#                  LET gs_keys[1] = g_rmda_m.rmdadocno
#                  LET gs_keys[2] = g_rmdb_d[g_detail_idx].rmdbseq
#                  LET gs_keys[3] = '1'
#                  CALL armt400_insert_b('rmdc_t',gs_keys,"'2'")
#               END IF
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rmdb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmdb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL armt400_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #新增多庫儲批
               CALL armt400_01_rmdc_modify(l_rmdbseq_backup,g_rmda_m.rmdasite,g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,
                                           g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008,
                                           g_rmdb_d[l_ac].rmdb009,g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb006) 
                                           RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
              
#               CALL s_transaction_end('Y','0')    ##160726-00003#1 zhujing
               
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
               CALL s_axmt540_update_inao(g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,'','','','0','1') RETURNING l_success   #160202-00019#5
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
               #刪除多庫儲批
               IF NOT armt400_01_rmdc_delete(g_rmda_m.rmdadocno,l_rmdbseq_backup,'N') THEN                                    
                  CALL s_transaction_end('N','0')
                  CLOSE armt400_bcl
                  CANCEL DELETE                   
               END IF
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rmda_m.rmdadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_rmdb_d_t.rmdbseq
 
            
               #刪除同層單身
               IF NOT armt400_delete_b('rmdb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt400_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT armt400_key_delete_b(gs_keys,'rmdb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt400_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #160202-00019#5---add---begin
               #同步刪除對應的[T:製造批序號庫存異動明細檔]
               DELETE FROM inao_t
                  WHERE inaoent = g_enterprise 
                    AND inaosite = g_site 
                    AND inaodocno = g_rmda_m.rmdadocno
                    AND inaoseq = g_rmdb_d[l_ac].rmdbseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inao_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()           
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF  
               #160202-00019#5---add---end   
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE armt400_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_rmdb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rmdb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdbseq
            #add-point:BEFORE FIELD rmdbseq name="input.b.page1.rmdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdbseq
            
            #add-point:AFTER FIELD rmdbseq name="input.a.page1.rmdbseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rmda_m.rmdadocno IS NOT NULL AND g_rmdb_d[g_detail_idx].rmdbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rmda_m.rmdadocno != g_rmdadocno_t OR g_rmdb_d[g_detail_idx].rmdbseq != g_rmdb_d_t.rmdbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmdb_t WHERE "||"rmdbent = '" ||g_enterprise|| "' AND "||"rmdbdocno = '"||g_rmda_m.rmdadocno ||"' AND "|| "rmdbseq = '"||g_rmdb_d[g_detail_idx].rmdbseq ||"'",'std-00004',0) THEN 
                     LET g_rmdb_d[g_detail_idx].rmdbseq = g_rmdb_d_t.rmdbseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdbseq
            #add-point:ON CHANGE rmdbseq name="input.g.page1.rmdbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb001
            #add-point:BEFORE FIELD rmdb001 name="input.b.page1.rmdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb001
            
            #add-point:AFTER FIELD rmdb001 name="input.a.page1.rmdb001"
            IF NOT cl_null(g_rmdb_d[g_detail_idx].rmdb001) THEN 
            #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               #160204-00004#4 Add By Ken 160222(S)
               IF NOT cl_null(g_rmda_m.rmdadocno) THEN
                  IF NOT s_aooi210_check_doc(g_site,'',g_rmdb_d[g_detail_idx].rmdb001,g_rmda_m.rmdadocno,'4','') THEN
                     LET g_rmdb_d[g_detail_idx].rmdb001 = g_rmdb_d_o.rmdb001
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #160204-00004#4 Add By Ken 160222(E)                
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmdb_d[g_detail_idx].rmdb001
#               IF NOT cl_null(g_rmda_m.rmda005) THEN
                  LET g_chkparam.arg2 = g_rmda_m.rmda005
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_rmaadocno_1") THEN
                     #檢查成功時後續處理
                     IF g_rmdb_d[g_detail_idx].rmdb001 <> g_rmdb_d_o.rmdb001 OR cl_null(g_rmdb_d_o.rmdb001) THEN
                        #刪除多庫儲批
                        IF NOT armt400_01_rmdc_delete(g_rmda_m.rmdadocno,l_rmdbseq_backup,'Y') THEN
                           LET g_rmdb_d[g_detail_idx].rmdb001 = g_rmdb_d_o.rmdb001
                           LET g_rmdb_d[g_detail_idx].rmdb002 = g_rmdb_d_o.rmdb002
                           LET g_rmdb_d[g_detail_idx].rmdb014 = g_rmdb_d_o.rmdb014
                           NEXT FIELD CURRENT
                        ELSE
                           LET g_rmdb_d[g_detail_idx].rmdb012 = 'N'
                           LET g_rmdb_d_o.rmdb012 = g_rmdb_d[g_detail_idx].rmdb012
                        END IF
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_rmdb_d[g_detail_idx].rmdb001 = g_rmdb_d_o.rmdb001
                     NEXT FIELD CURRENT
                  END IF
#               ELSE
#                  IF cl_chk_exist("v_rmaadocno_2") THEN
#                     #檢查成功時後續處理
#                     IF g_rmdb_d[g_detail_idx].rmdb001 <> g_rmdb_d_o.rmdb001 OR cl_null(g_rmdb_d_o.rmdb001) THEN
#                        #刪除多庫儲批
#                        IF NOT armt400_01_rmdc_delete(g_rmda_m.rmdadocno,l_rmdbseq_backup,'Y') THEN
#                           LET g_rmdb_d[g_detail_idx].rmdb001 = g_rmdb_d_o.rmdb001
#                           LET g_rmdb_d[g_detail_idx].rmdb002 = g_rmdb_d_o.rmdb002
#                           NEXT FIELD CURRENT
#                        ELSE
#                           LET g_rmdb_d[g_detail_idx].rmdb012 = 'N'
#                           LET g_rmdb_d_o.rmdb012 = g_rmdb_d[g_detail_idx].rmdb012
#                        END IF
#                     END IF
#                  ELSE
#                     #檢查失敗時後續處理
#                     LET g_rmdb_d[g_detail_idx].rmdb001 = g_rmdb_d_o.rmdb001
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
               LET g_rmdb_d_o.rmdb001 = g_rmdb_d[l_ac].rmdb001
               
               CALL armt400_set_entry_b(l_cmd)
               CALL armt400_set_no_entry_b(l_cmd)
               CALL armt400_detail_action_hidden(l_ac)
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb001
            #add-point:ON CHANGE rmdb001 name="input.g.page1.rmdb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb002
            #add-point:BEFORE FIELD rmdb002 name="input.b.page1.rmdb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb002
            
            #add-point:AFTER FIELD rmdb002 name="input.a.page1.rmdb002"
            #預設訂單單號、訂單項次、訂單項序、分批序。料號、產品特征、單位、申請退貨數量
            IF (NOT cl_null(g_rmdb_d[g_detail_idx].rmdb001) AND NOT cl_null(g_rmdb_d[g_detail_idx].rmdb002) AND cl_null(g_rmdb_d[g_detail_idx].rmdb003))
#               AND ((g_rmdb_d[g_detail_idx].rmdb001<>g_rmdb_d_o.rmdb001 OR g_rmdb_d_o.rmdb001 IS NULL)
               AND (g_rmdb_d[g_detail_idx].rmdb002<>g_rmdb_d_o.rmdb002 OR g_rmdb_d_o.rmdb002 IS NULL) THEN
#               OR (g_rmdb_d[g_detail_idx].rmdb014<>g_rmdb_d_o.rmdb014 OR g_rmdb_d_o.rmdb014 IS NULL)) 
               #刪除多庫儲批
               IF NOT armt400_01_rmdc_delete(g_rmda_m.rmdadocno,l_rmdbseq_backup,'Y') THEN
                  LET g_rmdb_d[g_detail_idx].rmdb001 = g_rmdb_d_o.rmdb001
                  LET g_rmdb_d[g_detail_idx].rmdb002 = g_rmdb_d_o.rmdb002
                  LET g_rmdb_d[g_detail_idx].rmdb014 = g_rmdb_d_o.rmdb014
                  NEXT FIELD CURRENT
               ELSE
                  LET g_rmdb_d[g_detail_idx].rmdb012 = 'N'
                  LET g_rmdb_d_o.rmdb012 = g_rmdb_d[g_detail_idx].rmdb012
               END IF
#               CALL armt400_rmdb_default_insert(g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002)   #2016-2-24 marked by zhujing
               IF NOT cl_null(g_rmdb_d[g_detail_idx].rmdb001) AND NOT cl_null(g_rmdb_d[g_detail_idx].rmdb002) THEN
                  IF NOT cl_null(g_rmdb_d[g_detail_idx].rmdb014) THEN
                     CALL armt400_rmdb_default_insert(g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002,g_rmdb_d[g_detail_idx].rmdb014) #2016-2-24 add by zhujing
                        RETURNING l_success
                  ELSE
                     CALL armt400_rmab_default(g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002) RETURNING l_success
                  END IF
                  IF NOT l_success THEN
                        #賦予舊值
                     LET g_rmdb_d[g_detail_idx].rmdb002 = g_rmdb_d_o.rmdb002
                     LET g_rmdb_d[g_detail_idx].rmdb003 = g_rmdb_d_o.rmdb003
                     LET g_rmdb_d[g_detail_idx].rmdb003_desc = g_rmdb_d_o.rmdb003_desc
                     LET g_rmdb_d[g_detail_idx].rmdb003_desc_1 = g_rmdb_d_o.rmdb003_desc_1
                     LET g_rmdb_d[g_detail_idx].rmdb004 = g_rmdb_d_o.rmdb004
                     LET g_rmdb_d[g_detail_idx].rmdb004_desc = g_rmdb_d_o.rmdb004_desc
                     LET g_rmdb_d[g_detail_idx].rmdb005 = g_rmdb_d_o.rmdb005
                     LET g_rmdb_d[g_detail_idx].rmdb006 = g_rmdb_d_o.rmdb006
                     LET g_rmdb_d[g_detail_idx].rmdb015 = g_rmdb_d_o.rmdb015     #2016-2-24 zhujing add 单价
                     LET g_rmdb_d[g_detail_idx].rmdb013 = g_rmdb_d_o.rmdb013     #2016-2-24 zhujing add 计价数量
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_rmdb_d_o.rmdb002 = g_rmdb_d[g_detail_idx].rmdb002  
            LET g_rmdb_d_o.rmdb003 = g_rmdb_d[g_detail_idx].rmdb003 
            LET g_rmdb_d_o.rmdb003_desc = g_rmdb_d[g_detail_idx].rmdb003_desc
            LET g_rmdb_d_o.rmdb003_desc_1 = g_rmdb_d[g_detail_idx].rmdb003_desc_1
            LET g_rmdb_d_o.rmdb004 = g_rmdb_d[g_detail_idx].rmdb004
            LET g_rmdb_d_o.rmdb004_desc = g_rmdb_d[g_detail_idx].rmdb004_desc
            LET g_rmdb_d_o.rmdb005 = g_rmdb_d[g_detail_idx].rmdb005 
            LET g_rmdb_d_o.rmdb006 = g_rmdb_d[g_detail_idx].rmdb006 
            LET g_rmdb_d_o.rmdb015 = g_rmdb_d[g_detail_idx].rmdb015     #2016-2-24 zhujing add 单价
            LET g_rmdb_d_o.rmdb013 = g_rmdb_d[g_detail_idx].rmdb013     #2016-2-24 zhujing add 计价数量
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb002
            #add-point:ON CHANGE rmdb002 name="input.g.page1.rmdb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb014
            #add-point:BEFORE FIELD rmdb014 name="input.b.page1.rmdb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb014
            
            #add-point:AFTER FIELD rmdb014 name="input.a.page1.rmdb014"
            #2016-2-25 zhujing add---(S)
            IF (NOT cl_null(g_rmdb_d[g_detail_idx].rmdb014)) AND (g_rmdb_d[g_detail_idx].rmdb014<>g_rmdb_d_o.rmdb014 OR g_rmdb_d_o.rmdb014 IS NULL) THEN
               #刪除多庫儲批
               IF NOT armt400_01_rmdc_delete(g_rmda_m.rmdadocno,l_rmdbseq_backup,'Y') THEN
                  LET g_rmdb_d[g_detail_idx].rmdb001 = g_rmdb_d_o.rmdb001
                  LET g_rmdb_d[g_detail_idx].rmdb002 = g_rmdb_d_o.rmdb002
                  LET g_rmdb_d[g_detail_idx].rmdb014 = g_rmdb_d_o.rmdb014
                  NEXT FIELD CURRENT
               ELSE
                  LET g_rmdb_d[g_detail_idx].rmdb012 = 'N'
                  LET g_rmdb_d_o.rmdb012 = g_rmdb_d[g_detail_idx].rmdb012
               END IF
               IF NOT cl_null(g_rmdb_d[g_detail_idx].rmdb001) AND NOT cl_null(g_rmdb_d[g_detail_idx].rmdb002) AND NOT cl_null(g_rmdb_d[g_detail_idx].rmdb014) THEN
                  IF NOT armt400_rmdb006_chk(g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002,g_rmdb_d[g_detail_idx].rmdb014,'1') THEN   #重新计算覆出数量
                     LET g_rmdb_d[g_detail_idx].rmdb006 = g_rmdb_d_o.rmdb006
                     LET g_rmdb_d[g_detail_idx].rmdb015 = g_rmdb_d_o.rmdb015     #2016-2-24 zhujing add 单价
                     LET g_rmdb_d[g_detail_idx].rmdb013 = g_rmdb_d_o.rmdb013     #2016-2-24 zhujing add 计价数量
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #重新带入计价数量，并计算金额
               IF g_rmdb_d[g_detail_idx].rmdb014 = '1' THEN
                  LET g_rmdb_d[g_detail_idx].rmdb013 = g_rmdb_d[g_detail_idx].rmdb006
               ELSE
                  LET g_rmdb_d[g_detail_idx].rmdb013 = 0
               END IF
               CALL armt400_get_money(g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002,g_rmdb_d[g_detail_idx].rmdb013,g_rmdb_d[g_detail_idx].rmdb015) 
                  RETURNING g_rmdb_d[g_detail_idx].rmdb016,g_rmdb_d[g_detail_idx].rmdb017
            END IF
            LET g_rmdb_d_o.rmdb006 = g_rmdb_d[g_detail_idx].rmdb006
            LET g_rmdb_d_o.rmdb015 = g_rmdb_d[g_detail_idx].rmdb015      #2016-2-24 zhujing add 单价
            LET g_rmdb_d_o.rmdb013 = g_rmdb_d[g_detail_idx].rmdb013      #2016-2-24 zhujing add 计价数量
            #2016-2-25 zhujing add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb014
            #add-point:ON CHANGE rmdb014 name="input.g.page1.rmdb014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmdb_d[l_ac].rmdb006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rmdb006
            END IF 
 
 
 
            #add-point:AFTER FIELD rmdb006 name="input.a.page1.rmdb006"
#            IF NOT armt400_rmdb006_chk(g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002) THEN    #2016-2-24 marked by zhujing
            IF NOT armt400_rmdb006_chk(g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002,g_rmdb_d[g_detail_idx].rmdb014,'2') THEN    #2016-2-24 add by zhujing
               LET g_rmdb_d[g_detail_idx].rmdb006 = g_rmdb_d_o.rmdb006
               DISPLAY BY NAME g_rmdb_d[g_detail_idx].rmdb006
               NEXT FIELD CURRENT
            END IF
            #160202-00019#5---add---begin
            IF NOT cl_null(g_rmdb_d[l_ac].rmdb006) THEN
               IF g_rmdb_d[l_ac].rmdb006 <> g_rmdb_d_o.rmdb006 OR cl_null(g_rmdb_d_o.rmdb006) THEN 
                  CALL armt400_inao('1') RETURNING l_success                  
               END IF
            END IF
            #160202-00019#5---add---end
            LET g_rmdb_d_t.rmdb006 = g_rmdb_d[g_detail_idx].rmdb006
            LET g_rmdb_d_o.rmdb006 = g_rmdb_d[g_detail_idx].rmdb006
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb006
            #add-point:BEFORE FIELD rmdb006 name="input.b.page1.rmdb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb006
            #add-point:ON CHANGE rmdb006 name="input.g.page1.rmdb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb013
            #add-point:BEFORE FIELD rmdb013 name="input.b.page1.rmdb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb013
            
            #add-point:AFTER FIELD rmdb013 name="input.a.page1.rmdb013"
            #160726-00003#1 zhujing add -S
            IF NOT cl_ap_chk_range(g_rmdb_d[l_ac].rmdb013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rmdb013
            END IF 
            #160726-00003#1 zhujing add -E
            #2016-2-25 zhujing add---(S)
            IF (NOT cl_null(g_rmdb_d[g_detail_idx].rmdb013)) AND g_rmdb_d[g_detail_idx].rmdb013<>g_rmdb_d_o.rmdb013 THEN
               ##160726-00003#1 zhujing add -S
               IF g_rmdb_d[g_detail_idx].rmdb013 > g_rmdb_d[g_detail_idx].rmdb006 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 'arm-00057'    #计价数量不可大于覆出数量！
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_rmdb_d[g_detail_idx].rmdb013 = g_rmdb_d_o.rmdb013
                  NEXT FIELD CURRENT
               END IF
               ##160726-00003#1 zhujing add -E
               CALL armt400_get_money(g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002,g_rmdb_d[g_detail_idx].rmdb013,g_rmdb_d[g_detail_idx].rmdb015) 
                  RETURNING g_rmdb_d[g_detail_idx].rmdb016,g_rmdb_d[g_detail_idx].rmdb017
            END IF
            LET g_rmdb_d_t.rmdb013 = g_rmdb_d[g_detail_idx].rmdb013
            LET g_rmdb_d_o.rmdb013 = g_rmdb_d[g_detail_idx].rmdb013
            #2016-2-25 zhujing add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb013
            #add-point:ON CHANGE rmdb013 name="input.g.page1.rmdb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb015
            #add-point:BEFORE FIELD rmdb015 name="input.b.page1.rmdb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb015
            
            #add-point:AFTER FIELD rmdb015 name="input.a.page1.rmdb015"
            #160202-00019#3   2016-3-28  BY zhujing  add---(S)
            IF cl_null(g_rmdb_d[g_detail_idx].rmdb015) THEN LET g_rmdb_d[g_detail_idx].rmdb015 = 0 END IF
            IF (g_rmdb_d[g_detail_idx].rmdb015<>g_rmdb_d_o.rmdb015 OR cl_null(g_rmdb_d_o.rmdb015)) THEN
               CALL armt400_get_money(g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002,g_rmdb_d[g_detail_idx].rmdb013,g_rmdb_d[g_detail_idx].rmdb015) 
                  RETURNING g_rmdb_d[g_detail_idx].rmdb016,g_rmdb_d[g_detail_idx].rmdb017
            END IF
            LET g_rmdb_d_t.rmdb015 = g_rmdb_d[g_detail_idx].rmdb015
            LET g_rmdb_d_o.rmdb015 = g_rmdb_d[g_detail_idx].rmdb015
            #160202-00019#3   2016-3-28  BY zhujing  add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb015
            #add-point:ON CHANGE rmdb015 name="input.g.page1.rmdb015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb012
            #add-point:BEFORE FIELD rmdb012 name="input.b.page1.rmdb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb012
            
            #add-point:AFTER FIELD rmdb012 name="input.a.page1.rmdb012"
            LET g_rmdb_d_o.rmdb007 = g_rmdb_d[l_ac].rmdb007
            LET g_rmdb_d_o.rmdb008 = g_rmdb_d[l_ac].rmdb008
            LET g_rmdb_d_o.rmdb009 = g_rmdb_d[l_ac].rmdb009
            LET g_rmdb_d_o.rmdb010 = g_rmdb_d[l_ac].rmdb010               
            LET g_rmdb_d_o.rmdb012 = g_rmdb_d[l_ac].rmdb012

            CALL armt400_set_entry_b(l_cmd)
            CALL armt400_set_no_entry_b(l_cmd)
            IF g_rmdb_d[l_ac].rmdb012 = 'Y' THEN
               CALL cl_set_comp_required("rmdb007",FALSE)
            ELSE
               CALL cl_set_comp_required("rmdb007",TRUE)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb012
            #add-point:ON CHANGE rmdb012 name="input.g.page1.rmdb012"
            #開啟多庫儲批
            IF g_rmdb_d[l_ac].rmdb012 = 'Y' THEN
               CALL armt400_01(g_rmda_m.rmdadocno,
                               g_rmdb_d[g_detail_idx].rmdbseq,g_rmdb_d[g_detail_idx].rmdb003,g_rmdb_d[g_detail_idx].rmdb004,
                               g_rmdb_d[g_detail_idx].rmdb005,g_rmdb_d[g_detail_idx].rmdb006,g_rmdb_d[g_detail_idx].rmdbsite,
                               g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002)   #160202-00019#5
                     RETURNING l_success,l_rollback,l_rmdb007,l_rmdb008,l_rmdb009,l_rmdb010
                   
               IF l_rollback THEN  #多庫儲批資料錯誤必須rollback
                  CLOSE armt400_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF

               IF l_success THEN
                  IF NOT cl_null(l_rmdb007) THEN  #只有一筆
                     LET g_rmdb_d[l_ac].rmdb012 = 'N'
                     LET g_rmdb_d[l_ac].rmdb007 = l_rmdb007
                     LET g_rmdb_d[l_ac].rmdb008 = l_rmdb008
                     LET g_rmdb_d[l_ac].rmdb009 = l_rmdb009
                     LET g_rmdb_d[l_ac].rmdb010 = l_rmdb010
                  ELSE
                     LET g_rmdb_d[l_ac].rmdb012 = 'Y'
                     LET g_rmdb_d[l_ac].rmdb007 = ' '
                     LET g_rmdb_d[l_ac].rmdb008 = ' '
                     LET g_rmdb_d[l_ac].rmdb009 = ' '
                     LET g_rmdb_d[l_ac].rmdb010 = ' '
                  END IF

#               IF l_success THEN
#                  IF NOT cl_null(l_rmdb007) THEN  #只有一筆         
#                     UPDATE rmdb_t
#                        SET rmdb012 = 'N',
#                            rmdb007 = l_rmdb007,
#                            rmdb008 = l_rmdb008,
#                            rmdb009 = l_rmdb009,
#                            rmdb010 = l_rmdb010
#                      WHERE rmdbent = g_enterprise
#                        AND rmdbdocno = g_rmda_m.rmdadocno
#                        AND rmdbseq = g_rmdb_d[g_detail_idx].rmdbseq                     
#                  ELSE
#                     UPDATE rmdb_t
#                        SET rmdb012 = 'Y',
#                            rmdb007 = ' ',
#                            rmdb008 = ' ',
#                            rmdb009 = ' ',
#                            rmdb010 = ' '
#                      WHERE rmdbent = g_enterprise
#                        AND rmdbdocno = g_rmda_m.rmdadocno
#                        AND rmdbseq = g_rmdb_d[g_detail_idx].rmdbseq   
#                  END IF

                  DISPLAY BY NAME g_rmdb_d[l_ac].rmdb007
                  DISPLAY BY NAME g_rmdb_d[l_ac].rmdb008
                  DISPLAY BY NAME g_rmdb_d[l_ac].rmdb009
                  DISPLAY BY NAME g_rmdb_d[l_ac].rmdb010
                  DISPLAY BY NAME g_rmdb_d[l_ac].rmdb012

                  CALL s_desc_get_stock_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007) RETURNING g_rmdb_d[l_ac].rmdb007_desc
                  DISPLAY BY NAME g_rmdb_d[l_ac].rmdb007_desc
                  CALL s_desc_get_locator_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008) RETURNING g_rmdb_d[l_ac].rmdb008_desc
                  DISPLAY BY NAME g_rmdb_d[l_ac].rmdb008_desc
                
               ELSE
                  LET g_rmdb_d[l_ac].rmdb012 = g_rmdb_d_o.rmdb012

                  NEXT FIELD CURRENT
               END IF
               
               LET l_rmdbseq_backup = g_rmdb_d[l_ac].rmdbseq #紀錄產生庫儲批所用的項次

            ELSE
            
               #檢查是否可多庫儲批若為"N"刪除舊值
               IF NOT armt400_01_rmdc_delete(g_rmda_m.rmdadocno,l_rmdbseq_backup,'Y') THEN
                  LET g_rmdb_d[l_ac].rmdb012 = g_rmdb_d_o.rmdb012
               
                  NEXT FIELD CURRENT
               END IF

            END IF
            CALL armt400_set_act_visible_b()
            CALL armt400_set_act_no_visible_b()           
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb007
            
            #add-point:AFTER FIELD rmdb007 name="input.a.page1.rmdb007"
            IF NOT cl_null(g_rmdb_d[l_ac].rmdb007) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmdb_d[l_ac].rmdb007

               #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#21  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inaa001_12") THEN
                  #檢查成功時後續處理
                  #库存量check
                  CALL armt400_rmdb007_chk(g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,
                                           g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb006,
                                           g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008,
                                           g_rmdb_d[l_ac].rmdb009,g_rmdb_d[l_ac].rmdb010) RETURNING r_success
                  IF NOT r_success THEN   #庫存量不足
                     LET g_rmdb_d[l_ac].rmdb007 = g_rmdb_d_t.rmdb007
                     CALL s_desc_get_stock_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007) RETURNING g_rmdb_d[l_ac].rmdb007_desc       
                     NEXT FIELD CURRENT
                  END IF                                        
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmdb_d[l_ac].rmdb007 = g_rmdb_d_t.rmdb007
                  CALL s_desc_get_stock_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007) RETURNING g_rmdb_d[l_ac].rmdb007_desc      
                  NEXT FIELD CURRENT
               END IF
               #160202-00019#5---add---begin
               IF g_rmdb_d[l_ac].rmdb007 <> g_rmdb_d_o.rmdb007 OR cl_null(g_rmdb_d_o.rmdb007) 
                  OR g_rmdb_d[l_ac].rmdb008 <> g_rmdb_d_o.rmdb008 OR g_rmdb_d_o.rmdb008 IS NULL
                  OR g_rmdb_d[l_ac].rmdb009 <> g_rmdb_d_o.rmdb009 OR g_rmdb_d_o.rmdb009 IS NULL THEN
                  CALL armt400_inao('2') RETURNING l_success
                  IF NOT l_success THEN 
                     LET g_rmdb_d[l_ac].rmdb007 = g_rmdb_d_t.rmdb007                            
                     CALL s_desc_get_stock_desc(g_site,g_rmdb_d[l_ac].rmdb007) RETURNING g_rmdb_d[l_ac].rmdb007_desc
                     LET g_rmdb_d[l_ac].rmdb008 = g_rmdb_d_t.rmdb008
                     CALL s_desc_get_locator_desc(g_site,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008) RETURNING g_rmdb_d[l_ac].rmdb008_desc                     
                     LET g_rmdb_d[l_ac].rmdb009 = g_rmdb_d_t.rmdb009
                     NEXT FIELD CURRENT
                  END IF   
               END IF                     
               #160202-00019#5---add---end 
            END IF 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmdb_d[l_ac].rmdb007
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmdb_d[l_ac].rmdb007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmdb_d[l_ac].rmdb007_desc
            
            IF NOT s_axmt540_inaa007_chk(g_rmdb_d[l_ac].rmdb007) THEN
               LET g_rmdb_d[l_ac].rmdb008 = ' '
               #LET g_rmdb_d[l_ac].rmdb008 = g_rmdb_d_t.rmdb008   #160202-00019#5 mark
               CALL s_desc_get_locator_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008) RETURNING g_rmdb_d[l_ac].rmdb008_desc
            END IF
            IF cl_null(g_rmdb_d[l_ac].rmdb007) THEN
               CALL cl_set_comp_entry("rmdb008",FALSE)
            ELSE
               CALL cl_set_comp_entry("rmdb008",TRUE)
            END IF
            LET g_rmdb_d_o.rmdb007 = g_rmdb_d[l_ac].rmdb007   #160202-00019#5
            LET g_rmdb_d_o.rmdb008 = g_rmdb_d[l_ac].rmdb008   #160202-00019#5
            LET g_rmdb_d_o.rmdb009 = g_rmdb_d[l_ac].rmdb009   #160202-00019#5
            LET g_rmdb_d_o.rmdb010 = g_rmdb_d[l_ac].rmdb010   #160202-00019#5
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb007
            #add-point:BEFORE FIELD rmdb007 name="input.b.page1.rmdb007"
            IF g_rmdb_d[l_ac].rmdb012 = 'Y' THEN
               CALL cl_set_comp_required("rmdb007",FALSE)
            ELSE
               CALL cl_set_comp_required("rmdb007",TRUE)
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb007
            #add-point:ON CHANGE rmdb007 name="input.g.page1.rmdb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb008
            
            #add-point:AFTER FIELD rmdb008 name="input.a.page1.rmdb008"
            IF NOT cl_null(g_rmdb_d[l_ac].rmdb008) THEN          
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_rmdb_d[l_ac].rmdb007
               LET g_chkparam.arg3 = g_rmdb_d[l_ac].rmdb008
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inab002_1") THEN
                  #檢查成功時後續處理
                  #库存量check
                  CALL armt400_rmdb007_chk(g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,
                                           g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb006,
                                           g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008,
                                           g_rmdb_d[l_ac].rmdb009,g_rmdb_d[l_ac].rmdb010) RETURNING r_success
                  IF NOT r_success THEN   #庫存量不足
                     LET g_rmdb_d[l_ac].rmdb008 =g_rmdb_d_t.rmdb008 
                     CALL s_desc_get_locator_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008) RETURNING g_rmdb_d[l_ac].rmdb008_desc
                     NEXT FIELD CURRENT
                  END IF                
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmdb_d[l_ac].rmdb008 =g_rmdb_d_t.rmdb008
                  CALL s_desc_get_locator_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008) RETURNING g_rmdb_d[l_ac].rmdb008_desc
                  NEXT FIELD CURRENT
               END IF
              
            END IF 
            #160202-00019#5---add---begin
            IF cl_null(g_rmdb_d[l_ac].rmdb008) THEN
               LET g_rmdb_d[l_ac].rmdb008 = ' '
            END IF
            IF g_rmdb_d[l_ac].rmdb008 IS NOT NULL THEN               
               IF g_rmdb_d[l_ac].rmdb007 <> g_rmdb_d_o.rmdb007 OR cl_null(g_rmdb_d_o.rmdb007) 
                  OR g_rmdb_d[l_ac].rmdb008 <> g_rmdb_d_o.rmdb008 OR g_rmdb_d_o.rmdb008 IS NULL
                  OR g_rmdb_d[l_ac].rmdb009 <> g_rmdb_d_o.rmdb009 OR g_rmdb_d_o.rmdb009 IS NULL THEN
                  CALL armt400_inao('2') RETURNING l_success
                  IF NOT l_success THEN 
                     LET g_rmdb_d[l_ac].rmdb007 = g_rmdb_d_t.rmdb007                            
                     CALL s_desc_get_stock_desc(g_site,g_rmdb_d[l_ac].rmdb007) RETURNING g_rmdb_d[l_ac].rmdb007_desc
                     LET g_rmdb_d[l_ac].rmdb008 = g_rmdb_d_t.rmdb008
                     CALL s_desc_get_locator_desc(g_site,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008) RETURNING g_rmdb_d[l_ac].rmdb008_desc                     
                     LET g_rmdb_d[l_ac].rmdb009 = g_rmdb_d_t.rmdb009
                     NEXT FIELD CURRENT
                  END IF
               END IF                     
            END IF
            #160202-00019#5---add---end              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmdb_d[l_ac].rmdbsite
            LET g_ref_fields[2] = g_rmdb_d[l_ac].rmdb007
            LET g_ref_fields[3] = g_rmdb_d[l_ac].rmdb008
            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite=? AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
            LET g_rmdb_d[l_ac].rmdb008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmdb_d[l_ac].rmdb008_desc
            LET g_rmdb_d_o.rmdb007 = g_rmdb_d[l_ac].rmdb007   #160202-00019#5
            LET g_rmdb_d_o.rmdb008 = g_rmdb_d[l_ac].rmdb008   #160202-00019#5
            LET g_rmdb_d_o.rmdb009 = g_rmdb_d[l_ac].rmdb009   #160202-00019#5
            LET g_rmdb_d_o.rmdb010 = g_rmdb_d[l_ac].rmdb010   #160202-00019#5
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb008
            #add-point:BEFORE FIELD rmdb008 name="input.b.page1.rmdb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb008
            #add-point:ON CHANGE rmdb008 name="input.g.page1.rmdb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb009
            
            #add-point:AFTER FIELD rmdb009 name="input.a.page1.rmdb009"
            IF NOT cl_null(g_rmdb_d[l_ac].rmdb009) THEN             
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_rmdb_d[l_ac].rmdb003
               LET g_chkparam.arg3 = g_rmdb_d[l_ac].rmdb004
               LET g_chkparam.arg4 = g_rmdb_d[l_ac].rmdb009
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inad001_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmdb_d[l_ac].rmdb009 = g_rmdb_d_t.rmdb009
                  NEXT FIELD CURRENT
               END IF
            END IF
             #160202-00019#5---add---begin
            IF cl_null(g_rmdb_d[l_ac].rmdb009) THEN
               LET g_rmdb_d[l_ac].rmdb009 = ' '
            END IF
            IF g_rmdb_d[l_ac].rmdb009 IS NOT NULL THEN               
               IF g_rmdb_d[l_ac].rmdb007 <> g_rmdb_d_o.rmdb007 OR cl_null(g_rmdb_d_o.rmdb007) 
                  OR g_rmdb_d[l_ac].rmdb008 <> g_rmdb_d_o.rmdb008 OR g_rmdb_d_o.rmdb008 IS NULL
                  OR g_rmdb_d[l_ac].rmdb009 <> g_rmdb_d_o.rmdb009 OR g_rmdb_d_o.rmdb009 IS NULL THEN
                  CALL armt400_inao('2') RETURNING l_success
                  IF NOT l_success THEN 
                     LET g_rmdb_d[l_ac].rmdb007 = g_rmdb_d_t.rmdb007                            
                     CALL s_desc_get_stock_desc(g_site,g_rmdb_d[l_ac].rmdb007) RETURNING g_rmdb_d[l_ac].rmdb007_desc
                     LET g_rmdb_d[l_ac].rmdb008 = g_rmdb_d_t.rmdb008
                     CALL s_desc_get_locator_desc(g_site,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008) RETURNING g_rmdb_d[l_ac].rmdb008_desc                     
                     LET g_rmdb_d[l_ac].rmdb009 = g_rmdb_d_t.rmdb009
                     NEXT FIELD CURRENT
                  END IF    
               END IF 
            END IF               
            #160202-00019#5---add---end             
            LET g_rmdb_d_o.rmdb007 = g_rmdb_d[l_ac].rmdb007   #160202-00019#5
            LET g_rmdb_d_o.rmdb008 = g_rmdb_d[l_ac].rmdb008   #160202-00019#5
            LET g_rmdb_d_o.rmdb009 = g_rmdb_d[l_ac].rmdb009   #160202-00019#5
            LET g_rmdb_d_o.rmdb010 = g_rmdb_d[l_ac].rmdb010   #160202-00019#5
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb009
            #add-point:BEFORE FIELD rmdb009 name="input.b.page1.rmdb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb009
            #add-point:ON CHANGE rmdb009 name="input.g.page1.rmdb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb010
            #add-point:BEFORE FIELD rmdb010 name="input.b.page1.rmdb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb010
            
            #add-point:AFTER FIELD rmdb010 name="input.a.page1.rmdb010"
            #160202-00019#5---mod---begin
            IF cl_null(g_rmdb_d[l_ac].rmdb010) THEN
               LET g_rmdb_d[l_ac].rmdb010 = ' '
            END IF
            IF g_rmdb_d[l_ac].rmdb010 IS NOT NULL THEN
               IF g_rmdb_d[l_ac].rmdb010 <> g_rmdb_d_o.rmdb010 OR g_rmdb_d_o.rmdb010 IS NULL THEN
                  CALL armt400_inao('2') RETURNING l_success
                  IF NOT l_success THEN 
                     LET g_rmdb_d[l_ac].rmdb010 = g_rmdb_d_t.rmdb010
                     NEXT FIELD CURRENT
                  END IF   
               END IF                     
            END IF 
            LET g_rmdb_d_o.rmdb010 = g_rmdb_d[l_ac].rmdb010  
            #160202-00019#5---add---end            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb010
            #add-point:ON CHANGE rmdb010 name="input.g.page1.rmdb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb011
            #add-point:BEFORE FIELD rmdb011 name="input.b.page1.rmdb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb011
            
            #add-point:AFTER FIELD rmdb011 name="input.a.page1.rmdb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb011
            #add-point:ON CHANGE rmdb011 name="input.g.page1.rmdb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdbsite
            #add-point:BEFORE FIELD rmdbsite name="input.b.page1.rmdbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdbsite
            
            #add-point:AFTER FIELD rmdbsite name="input.a.page1.rmdbsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdbsite
            #add-point:ON CHANGE rmdbsite name="input.g.page1.rmdbsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rmdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdbseq
            #add-point:ON ACTION controlp INFIELD rmdbseq name="input.c.page1.rmdbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb001
            #add-point:ON ACTION controlp INFIELD rmdb001 name="input.c.page1.rmdb001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_rmda_m.rmda005) THEN
               LET g_qryparam.where = " rmaa001 = '",g_rmda_m.rmda005,"' "
            ELSE
               LET g_qryparam.where = " 1 = 1 "
            END IF

            LET g_qryparam.default1 = g_rmdb_d[l_ac].rmdb001             #給予default值
            LET g_qryparam.default2 = g_rmdb_d[l_ac].rmdb002
            LET g_qryparam.default3 = g_rmdb_d[l_ac].rmdb003
            LET g_qryparam.default4 = g_rmdb_d[l_ac].rmdb003_desc
            LET g_qryparam.default5 = g_rmdb_d[l_ac].rmdb003_desc_1
            LET g_qryparam.default6 = g_rmdb_d[l_ac].rmdb004
            LET g_qryparam.default7 = g_rmdb_d[l_ac].rmdb005
            #給予arg
            LET g_qryparam.arg1 = "" #s
            #160204-00004#4 Add By Ken 160222(S)
            #組合過濾前後置單據資料SQL
            IF NOT cl_null(g_rmda_m.rmdadocno) THEN
               CALL s_aooi210_get_check_sql(g_site,'',g_rmda_m.rmdadocno,'4','','rmabdocno') RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",l_where
                  CALL q_rmabdocno()
               END IF
            END IF
            #160204-00004#4 Add By Ken 160222(E)
            #CALL q_rmabdocno()        #160204-00004#4 Mark By Ken 160222                        #呼叫開窗

            LET g_rmdb_d[l_ac].rmdb001 = g_qryparam.return1              
            LET g_rmdb_d[l_ac].rmdb002 = g_qryparam.return2              
            LET g_rmdb_d[l_ac].rmdb003 = g_qryparam.return3              
            LET g_rmdb_d[l_ac].rmdb003_desc = g_qryparam.return4
            LET g_rmdb_d[l_ac].rmdb003_desc_1 = g_qryparam.return5
            LET g_rmdb_d[l_ac].rmdb004 = g_qryparam.return6              
            LET g_rmdb_d[l_ac].rmdb005 = g_qryparam.return7              
            DISPLAY g_rmdb_d[l_ac].rmdb001 TO rmdb001              #
            DISPLAY g_rmdb_d[l_ac].rmdb002 TO rmdb002
            DISPLAY g_rmdb_d[l_ac].rmdb003 TO rmdb003
            DISPLAY g_rmdb_d[l_ac].rmdb003_desc TO rmdb003_desc
            DISPLAY g_rmdb_d[l_ac].rmdb003_desc_1 TO rmdb003_desc_1
            DISPLAY g_rmdb_d[l_ac].rmdb004 TO rmdb004
            DISPLAY g_rmdb_d[l_ac].rmdb005 TO rmdb005
            NEXT FIELD rmdb001                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb002
            #add-point:ON ACTION controlp INFIELD rmdb002 name="input.c.page1.rmdb002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_rmdb_d[l_ac].rmdb001 ) THEN
               LET g_qryparam.where = ' rmabdocno = ',g_rmdb_d[l_ac].rmdb001 
            END IF
            LET g_qryparam.default1 = g_rmdb_d[l_ac].rmdb001             #給予default值
            LET g_qryparam.default2 = g_rmdb_d[l_ac].rmdb002
            LET g_qryparam.default3 = g_rmdb_d[l_ac].rmdb003
            LET g_qryparam.default4 = g_rmdb_d[l_ac].rmdb003_desc
            LET g_qryparam.default5 = g_rmdb_d[l_ac].rmdb003_desc_1
            LET g_qryparam.default6 = g_rmdb_d[l_ac].rmdb004
            LET g_qryparam.default7 = g_rmdb_d[l_ac].rmdb005
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_rmabdocno()                                #呼叫開窗

            LET g_rmdb_d[l_ac].rmdb001 = g_qryparam.return1              
            LET g_rmdb_d[l_ac].rmdb002 = g_qryparam.return2              
            LET g_rmdb_d[l_ac].rmdb003 = g_qryparam.return3              
            LET g_rmdb_d[l_ac].rmdb003_desc = g_qryparam.return4
            LET g_rmdb_d[l_ac].rmdb003_desc_1 = g_qryparam.return5
            LET g_rmdb_d[l_ac].rmdb004 = g_qryparam.return6              
            LET g_rmdb_d[l_ac].rmdb005 = g_qryparam.return7              
            DISPLAY g_rmdb_d[l_ac].rmdb001 TO rmdb001              #
            DISPLAY g_rmdb_d[l_ac].rmdb002 TO rmdb002
            DISPLAY g_rmdb_d[l_ac].rmdb003 TO rmdb003
            DISPLAY g_rmdb_d[l_ac].rmdb003_desc TO rmdb003_desc
            DISPLAY g_rmdb_d[l_ac].rmdb003_desc_1 TO rmdb003_desc_1
            DISPLAY g_rmdb_d[l_ac].rmdb004 TO rmdb004
            DISPLAY g_rmdb_d[l_ac].rmdb005 TO rmdb005
            NEXT FIELD rmdb002                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb014
            #add-point:ON ACTION controlp INFIELD rmdb014 name="input.c.page1.rmdb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb006
            #add-point:ON ACTION controlp INFIELD rmdb006 name="input.c.page1.rmdb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb013
            #add-point:ON ACTION controlp INFIELD rmdb013 name="input.c.page1.rmdb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb015
            #add-point:ON ACTION controlp INFIELD rmdb015 name="input.c.page1.rmdb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb012
            #add-point:ON ACTION controlp INFIELD rmdb012 name="input.c.page1.rmdb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb007
            #add-point:ON ACTION controlp INFIELD rmdb007 name="input.c.page1.rmdb007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            CALL armt400_rmdb007_rmdb008_rmdb009_rmdb010_qry('1')
            NEXT FIELD rmdb007                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb008
            #add-point:ON ACTION controlp INFIELD rmdb008 name="input.c.page1.rmdb008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            CALL armt400_rmdb007_rmdb008_rmdb009_rmdb010_qry('2')
            NEXT FIELD rmdb008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb009
            #add-point:ON ACTION controlp INFIELD rmdb009 name="input.c.page1.rmdb009"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            CALL armt400_rmdb007_rmdb008_rmdb009_rmdb010_qry('3')
            NEXT FIELD rmdb009                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb010
            #add-point:ON ACTION controlp INFIELD rmdb010 name="input.c.page1.rmdb010"
            CALL armt400_rmdb007_rmdb008_rmdb009_rmdb010_qry('4')
            NEXT FIELD rmdb010
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb011
            #add-point:ON ACTION controlp INFIELD rmdb011 name="input.c.page1.rmdb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdbsite
            #add-point:ON ACTION controlp INFIELD rmdbsite name="input.c.page1.rmdbsite"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rmdb_d[l_ac].* = g_rmdb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE armt400_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rmdb_d[l_ac].rmdbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rmdb_d[l_ac].* = g_rmdb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL armt400_rmdb_t_mask_restore('restore_mask_o')
      
               UPDATE rmdb_t SET (rmdbdocno,rmdbseq,rmdb001,rmdb002,rmdb003,rmdb004,rmdb005,rmdb014, 
                   rmdb006,rmdb013,rmdb015,rmdb016,rmdb017,rmdb012,rmdb007,rmdb008,rmdb009,rmdb010,rmdb011, 
                   rmdbsite) = (g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,g_rmdb_d[l_ac].rmdb001,g_rmdb_d[l_ac].rmdb002, 
                   g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb014, 
                   g_rmdb_d[l_ac].rmdb006,g_rmdb_d[l_ac].rmdb013,g_rmdb_d[l_ac].rmdb015,g_rmdb_d[l_ac].rmdb016, 
                   g_rmdb_d[l_ac].rmdb017,g_rmdb_d[l_ac].rmdb012,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008, 
                   g_rmdb_d[l_ac].rmdb009,g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdb011,g_rmdb_d[l_ac].rmdbsite) 
 
                WHERE rmdbent = g_enterprise AND rmdbdocno = g_rmda_m.rmdadocno 
 
                  AND rmdbseq = g_rmdb_d_t.rmdbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rmdb_d[l_ac].* = g_rmdb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmdb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rmdb_d[l_ac].* = g_rmdb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmdb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmda_m.rmdadocno
               LET gs_keys_bak[1] = g_rmdadocno_t
               LET gs_keys[2] = g_rmdb_d[g_detail_idx].rmdbseq
               LET gs_keys_bak[2] = g_rmdb_d_t.rmdbseq
               CALL armt400_update_b('rmdb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL armt400_rmdb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rmdb_d[g_detail_idx].rmdbseq = g_rmdb_d_t.rmdbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rmda_m.rmdadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rmdb_d_t.rmdbseq
 
                  CALL armt400_key_update_b(gs_keys,'rmdb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rmda_m),util.JSON.stringify(g_rmdb_d_t)
               LET g_log2 = util.JSON.stringify(g_rmda_m),util.JSON.stringify(g_rmdb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #新增多庫儲批
               CALL armt400_01_rmdc_modify(l_rmdbseq_backup,g_rmda_m.rmdasite,g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,
                                           g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008,
                                           g_rmdb_d[l_ac].rmdb009,g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb006) 
                                           RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  LET g_rmdb_d[l_ac].* = g_rmdb_d_t.*
               END IF
#               IF g_rmdb_d[l_ac].rmdb012 = 'N' THEN   #如果多库储批不维护，则将单身资料删去
#                  LET l_cnt = 0
#                  SELECT COUNT(*) INTO l_cnt
#                    FROM rmdc_t
#                   WHERE rmdcdocno = g_rmda_m.rmdadocno AND rmdcseq = g_rmdb_d[g_detail_idx].rmdbseq
#                  IF l_cnt > 0 THEN
#                     DELETE FROM rmdc_t
#                     WHERE rmdcdocno = g_rmda_m.rmdadocno AND rmdcseq = g_rmdb_d[g_detail_idx].rmdbseq
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL 
#                        LET g_errparam.extend = "" 
#                        LET g_errparam.code   = SQLCA.sqlcode 
#                        LET g_errparam.popup  = FALSE 
#                        CALL cl_err()
#                        CALL s_transaction_end('N','0')
#                     END IF
#                  END IF
#               ELSE
#                  UPDATE rmdc_t SET (rmdcdocno,rmdcseq,rmdc001,rmdc002,rmdc003,rmdc004,rmdbsite) 
#                  = (g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,
#                  g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb006,g_rmdb_d[l_ac].rmdbsite)
#                  WHERE rmdcent = g_enterprise AND rmdcdocno = g_rmda_m.rmdadocno 
#                     AND rmdcseq = g_rmdb_d_t.rmdbseq #項次   
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = FALSE 
#                     CALL cl_err()
#                     CALL s_transaction_end('N','0')
#                  END IF
#               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL armt400_unlock_b("rmdb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL armt400_b_fill()
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rmdb_d[li_reproduce_target].* = g_rmdb_d[li_reproduce].*
 
               LET g_rmdb_d[li_reproduce_target].rmdbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rmdb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rmdb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_rmdb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL armt400_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"
            #單身Action隱藏
            CALL armt400_detail_action_hidden(l_ac)
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL armt400_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="armt400.input.other" >}
      
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
            
            #end add-point  
            NEXT FIELD rmdadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rmdbseq
               WHEN "s_detail2"
                  NEXT FIELD rmdcseq
 
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
 
{<section id="armt400.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION armt400_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL armt400_b_fill() #單身填充
      CALL armt400_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL armt400_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL armt400_rmda011_ref()
   CALL s_desc_get_person_desc(g_rmda_m.rmda002) RETURNING g_rmda_m.rmda002_desc
   CALL s_desc_get_department_desc(g_rmda_m.rmda003) RETURNING g_rmda_m.rmda003_desc
   CALL s_desc_get_acc_desc('263',g_rmda_m.rmda012) RETURNING g_rmda_m.rmda012_desc
   DISPLAY BY NAME g_rmda_m.rmda012_desc
   CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda013) RETURNING g_rmda_m.rmda013_desc
   DISPLAY BY NAME g_rmda_m.rmda013_desc
   CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda014) RETURNING g_rmda_m.rmda014_desc
   DISPLAY BY NAME g_rmda_m.rmda014_desc
   CALL s_aooi200_get_slip_desc(g_rmda_m.rmdadocno) RETURNING g_rmda_m.rmdadocno_desc
   DISPLAY BY NAME g_rmda_m.rmdadocno_desc
   #end add-point
   
   #遮罩相關處理
   LET g_rmda_m_mask_o.* =  g_rmda_m.*
   CALL armt400_rmda_t_mask()
   LET g_rmda_m_mask_n.* =  g_rmda_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rmda_m.rmdadocno,g_rmda_m.rmdadocno_desc,g_rmda_m.rmdasite,g_rmda_m.rmdadocdt,g_rmda_m.rmda001, 
       g_rmda_m.rmda002,g_rmda_m.rmda002_desc,g_rmda_m.rmda003,g_rmda_m.rmda003_desc,g_rmda_m.rmdastus, 
       g_rmda_m.rmda004,g_rmda_m.rmda005,g_rmda_m.rmda005_desc,g_rmda_m.rmda006,g_rmda_m.rmda006_desc, 
       g_rmda_m.rmda007,g_rmda_m.rmda007_desc,g_rmda_m.rmda008,g_rmda_m.rmda008_desc,g_rmda_m.rmda009, 
       g_rmda_m.rmda010,g_rmda_m.rmda011,g_rmda_m.rmda011_desc,g_rmda_m.address,g_rmda_m.rmda012,g_rmda_m.rmda012_desc, 
       g_rmda_m.rmda013,g_rmda_m.rmda013_desc,g_rmda_m.rmda014,g_rmda_m.rmda014_desc,g_rmda_m.rmda015, 
       g_rmda_m.rmda015_desc,g_rmda_m.rmda016,g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda018_desc, 
       g_rmda_m.rmda019,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid,g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp, 
       g_rmda_m.rmdaowndp_desc,g_rmda_m.rmdacrtid,g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdp_desc, 
       g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamodid_desc,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
       g_rmda_m.rmdacnfid_desc,g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstid_desc,g_rmda_m.rmdapstdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmda_m.rmdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_rmdb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_rmdb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL armt400_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="armt400.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION armt400_detail_show()
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
 
{<section id="armt400.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION armt400_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rmda_t.rmdadocno 
   DEFINE l_oldno     LIKE rmda_t.rmdadocno 
 
   DEFINE l_master    RECORD LIKE rmda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rmdb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rmdc_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_rmda_m.rmdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rmdadocno_t = g_rmda_m.rmdadocno
 
    
   LET g_rmda_m.rmdadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rmda_m.rmdaownid = g_user
      LET g_rmda_m.rmdaowndp = g_dept
      LET g_rmda_m.rmdacrtid = g_user
      LET g_rmda_m.rmdacrtdp = g_dept 
      LET g_rmda_m.rmdacrtdt = cl_get_current()
      LET g_rmda_m.rmdamodid = g_user
      LET g_rmda_m.rmdamoddt = cl_get_current()
      LET g_rmda_m.rmdastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_rmda_m.rmdacnfid = NULL
   LET g_rmda_m.rmdacnfdt = NULL
   LET g_rmda_m.rmdapstid = NULL
   LET g_rmda_m.rmdapstdt = NULL
   LET g_rmda_m.rmdadocdt = g_today
   LET g_rmda_m.rmda001 = g_today
   LET g_rmda_m.rmda002 = g_user
   LET g_rmda_m.rmda003 = g_dept
   CALL s_desc_get_person_desc(g_rmda_m.rmda002) RETURNING g_rmda_m.rmda002_desc
   CALL s_desc_get_department_desc(g_rmda_m.rmda003) RETURNING g_rmda_m.rmda003_desc
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmda_m.rmdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_rmda_m.rmdadocno_desc = ''
   DISPLAY BY NAME g_rmda_m.rmdadocno_desc
 
   
   CALL armt400_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rmda_m.* TO NULL
      INITIALIZE g_rmdb_d TO NULL
      INITIALIZE g_rmdb2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL armt400_show()
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
   CALL armt400_set_act_visible()   
   CALL armt400_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rmdadocno_t = g_rmda_m.rmdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rmdaent = " ||g_enterprise|| " AND",
                      " rmdadocno = '", g_rmda_m.rmdadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL armt400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL armt400_idx_chk()
   
   LET g_data_owner = g_rmda_m.rmdaownid      
   LET g_data_dept  = g_rmda_m.rmdaowndp
   
   #功能已完成,通報訊息中心
   CALL armt400_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="armt400.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION armt400_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rmdb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rmdc_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_sum      LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_num      LIKE type_t.num5
  
   DEFINE l_sql  STRING 
   #161124-00048#11 mod-S
#   DEFINE l_rmdb RECORD LIKE rmdb_t.*
   DEFINE l_rmdb RECORD  #RMA覆出單單身檔
          rmdbent LIKE rmdb_t.rmdbent, #企业编号
          rmdbsite LIKE rmdb_t.rmdbsite, #营运据点
          rmdbdocno LIKE rmdb_t.rmdbdocno, #单据单号
          rmdbseq LIKE rmdb_t.rmdbseq, #项次
          rmdb001 LIKE rmdb_t.rmdb001, #RMA单号
          rmdb002 LIKE rmdb_t.rmdb002, #RMA项次
          rmdb003 LIKE rmdb_t.rmdb003, #料号
          rmdb004 LIKE rmdb_t.rmdb004, #产品特征
          rmdb005 LIKE rmdb_t.rmdb005, #单位
          rmdb006 LIKE rmdb_t.rmdb006, #覆出数量
          rmdb007 LIKE rmdb_t.rmdb007, #库位
          rmdb008 LIKE rmdb_t.rmdb008, #储位
          rmdb009 LIKE rmdb_t.rmdb009, #批号
          rmdb010 LIKE rmdb_t.rmdb010, #库存特征
          rmdb011 LIKE rmdb_t.rmdb011, #备注
          rmdb012 LIKE rmdb_t.rmdb012, #多库储批出货
          rmdb013 LIKE rmdb_t.rmdb013, #计价数量
          rmdb014 LIKE rmdb_t.rmdb014, #覆出类型
          rmdb015 LIKE rmdb_t.rmdb015, #单价
          rmdb016 LIKE rmdb_t.rmdb016, #税前金额
          rmdb017 LIKE rmdb_t.rmdb017 #含税金额
   END RECORD
   #161124-00048#11 mod-E
   DEFINE l_rmdb001_t LIKE rmdb_t.rmdb001
   DEFINE l_rmdb002_t LIKE rmdb_t.rmdb002
   DEFINE l_rmdb006   LIKE rmdb_t.rmdb006
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE armt400_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rmdb_t
    WHERE rmdbent = g_enterprise AND rmdbdocno = g_rmdadocno_t
 
    INTO TEMP armt400_detail
 
   #將key修正為調整後   
   UPDATE armt400_detail 
      #更新key欄位
      SET rmdbdocno = g_rmda_m.rmdadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   LET l_rmdb001_t = ''
   LET l_rmdb002_t = '' 
   
   LET l_sql = "SELECT * FROM armt400_detail ORDER BY rmdb001,rmdb002,rmdbseq "
   PREPARE armt400_reproduce_pr FROM l_sql
   DECLARE armt400_reproduce_cr CURSOR FOR armt400_reproduce_pr
   FOREACH armt400_reproduce_cr INTO l_rmdb.* 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF   
      IF l_rmdb.rmdb001=l_rmdb001_t AND l_rmdb.rmdb002=l_rmdb002_t THEN    #判断是否为相同的RMA单号+项次
         DELETE FROM armt400_detail 
          WHERE rmdb001 = l_rmdb.rmdb001
            AND rmdb002 = l_rmdb.rmdb002
            AND rmdbseq = l_rmdb.rmdbseq
         CONTINUE FOREACH   
      END IF
      #计算当前RMA单号+项次下是否还有可覆出數量
      #计算已覆出数量
      SELECT SUM(rmdb006) INTO l_sum
        FROM rmdb_t
       WHERE rmdb001 = l_rmdb.rmdb001
         AND rmdb002 = l_rmdb.rmdb002
         AND rmdbent = g_enterprise 
         AND rmdbsite = g_site
 
      IF cl_null(l_sum) THEN
         LET l_sum = 0
      END IF
      #计算可覆出总量
      SELECT (COALESCE(rmab012,0)-COALESCE(rmab015,0)) INTO l_cnt
         FROM rmab_t
         WHERE rmabent = g_enterprise
           AND rmabdocno = l_rmdb.rmdb001
           AND rmabseq = l_rmdb.rmdb002
           AND rmabsite = g_site
      IF cl_null(l_cnt) THEN 
         LET l_cnt = 0
      END IF
      #若可覆出品大于已覆出品，则新增-->更新：计算可覆出数量
      IF l_cnt-l_sum <= 0 THEN 
         DELETE FROM armt400_detail 
          WHERE rmdb001 = l_rmdb.rmdb001
            AND rmdb002 = l_rmdb.rmdb002
            AND rmdbseq = l_rmdb.rmdbseq
         
      ELSE
         LET l_rmdb.rmdb006 = l_cnt - l_sum
         UPDATE armt400_detail
            SET (rmdb006) = (l_rmdb.rmdb006)
          WHERE rmdb001 = l_rmdb.rmdb001
            AND rmdb002 = l_rmdb.rmdb002
            AND rmdbseq = l_rmdb.rmdbseq  
      END IF   
      LET l_rmdb001_t = l_rmdb.rmdb001 
      LET l_rmdb002_t = l_rmdb.rmdb002
   
   END FOREACH 
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rmdb_t SELECT * FROM armt400_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM rmdb_t
    WHERE rmdbent = g_enterprise
      AND rmdbdocno = g_rmda_m.rmdadocno       
   IF l_cnt = 0 THEN 
      CALL cl_ask_pressanykey("arm-00023")   
   END IF
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rmdadocno_t = g_rmda_m.rmdadocno
   CALL armt400_b_fill()
   RETURN  
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE armt400_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rmdc_t 
    WHERE rmdcent = g_enterprise AND rmdcdocno = g_rmdadocno_t
 
    INTO TEMP armt400_detail
 
   #將key修正為調整後   
   UPDATE armt400_detail SET rmdcdocno = g_rmda_m.rmdadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rmdc_t SELECT * FROM armt400_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE armt400_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rmdadocno_t = g_rmda_m.rmdadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="armt400.delete" >}
#+ 資料刪除
PRIVATE FUNCTION armt400_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_success       LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_rmda_m.rmdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN armt400_cl USING g_enterprise,g_rmda_m.rmdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt400_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE armt400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE armt400_master_referesh USING g_rmda_m.rmdadocno INTO g_rmda_m.rmdadocno,g_rmda_m.rmdasite, 
       g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002,g_rmda_m.rmda003,g_rmda_m.rmdastus,g_rmda_m.rmda004, 
       g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010, 
       g_rmda_m.rmda011,g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016, 
       g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019,g_rmda_m.rmdaownid,g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtid, 
       g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
       g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstdt,g_rmda_m.rmda002_desc,g_rmda_m.rmda003_desc, 
       g_rmda_m.rmda005_desc,g_rmda_m.rmda006_desc,g_rmda_m.rmda007_desc,g_rmda_m.rmda008_desc,g_rmda_m.rmda012_desc, 
       g_rmda_m.rmda015_desc,g_rmda_m.rmda018_desc,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp_desc, 
       g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp_desc,g_rmda_m.rmdamodid_desc,g_rmda_m.rmdacnfid_desc, 
       g_rmda_m.rmdapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT armt400_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rmda_m_mask_o.* =  g_rmda_m.*
   CALL armt400_rmda_t_mask()
   LET g_rmda_m_mask_n.* =  g_rmda_m.*
   
   CALL armt400_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL armt400_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rmdadocno_t = g_rmda_m.rmdadocno
 
 
      DELETE FROM rmda_t
       WHERE rmdaent = g_enterprise AND rmdadocno = g_rmda_m.rmdadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rmda_m.rmdadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_rmda_m.rmdadocno,g_rmda_m.rmdadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      CALL s_axmt540_update_inao(g_rmda_m.rmdadocno,'','','','','0','1') RETURNING l_success  #160202-00019#5
      #end add-point
      
      DELETE FROM rmdb_t
       WHERE rmdbent = g_enterprise AND rmdbdocno = g_rmda_m.rmdadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmdb_t:",SQLERRMESSAGE 
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
      DELETE FROM rmdc_t
       WHERE rmdcent = g_enterprise AND
             rmdcdocno = g_rmda_m.rmdadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmdc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      #160202-00019#5---add---begin
      CALL s_axmt540_update_inao(g_rmda_m.rmdadocno,'','','','','0','1') RETURNING l_success
      #同步刪除對應的[T:製造批序號庫存異動明細檔]
      DELETE FROM inao_t
         WHERE inaoent = g_enterprise 
           AND inaosite = g_site 
           AND inaodocno = g_rmda_m.rmdadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF  
      CALL s_lot_clear_detail()  
      #160202-00019#5---add---end 
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rmda_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE armt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rmdb_d.clear() 
      CALL g_rmdb2_d.clear()       
 
     
      CALL armt400_ui_browser_refresh()  
      #CALL armt400_ui_headershow()  
      #CALL armt400_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL armt400_browser_fill("")
         CALL armt400_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE armt400_cl
 
   #功能已完成,通報訊息中心
   CALL armt400_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="armt400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION armt400_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_rmdb_d.clear()
   CALL g_rmdb2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF armt400_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rmdbseq,rmdb001,rmdb002,rmdb003,rmdb004,rmdb005,rmdb014,rmdb006, 
             rmdb013,rmdb015,rmdb016,rmdb017,rmdb012,rmdb007,rmdb008,rmdb009,rmdb010,rmdb011,rmdbsite , 
             t1.imaal003 ,t2.inayl003 ,t3.inab003 FROM rmdb_t",   
                     " INNER JOIN rmda_t ON rmdaent = " ||g_enterprise|| " AND rmdadocno = rmdbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=rmdb003 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t2 ON t2.inaylent="||g_enterprise||" AND t2.inayl001=rmdb007 AND t2.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t3 ON t3.inabent="||g_enterprise||" AND t3.inabsite=rmdbsite AND t3.inab001=rmdb007 AND t3.inab002=rmdb008  ",
 
                     " WHERE rmdbent=? AND rmdbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         LET g_sql = g_sql CLIPPED, " AND rmdbsite = '", g_site CLIPPED,"' "
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rmdb_t.rmdbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE armt400_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR armt400_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rmda_m.rmdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rmda_m.rmdadocno INTO g_rmdb_d[l_ac].rmdbseq,g_rmdb_d[l_ac].rmdb001, 
          g_rmdb_d[l_ac].rmdb002,g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005, 
          g_rmdb_d[l_ac].rmdb014,g_rmdb_d[l_ac].rmdb006,g_rmdb_d[l_ac].rmdb013,g_rmdb_d[l_ac].rmdb015, 
          g_rmdb_d[l_ac].rmdb016,g_rmdb_d[l_ac].rmdb017,g_rmdb_d[l_ac].rmdb012,g_rmdb_d[l_ac].rmdb007, 
          g_rmdb_d[l_ac].rmdb008,g_rmdb_d[l_ac].rmdb009,g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdb011, 
          g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb003_desc,g_rmdb_d[l_ac].rmdb007_desc,g_rmdb_d[l_ac].rmdb008_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #產品特徵
         CALL s_feature_description(g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004) RETURNING l_success,g_rmdb_d[l_ac].rmdb004_desc
         #获取料件品名规格
         CALL s_desc_get_item_desc(g_rmdb_d[l_ac].rmdb003)
            RETURNING g_rmdb_d[l_ac].rmdb003_desc,g_rmdb_d[l_ac].rmdb003_desc_1
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
   IF armt400_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rmdcseq,rmdcseq1,rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,rmdc006, 
             rmdc007,rmdc008,rmdcsite ,t4.imaal003 ,t5.inayl003 ,t6.inab003 FROM rmdc_t",   
                     " INNER JOIN  rmda_t ON rmdaent = " ||g_enterprise|| " AND rmdadocno = rmdcdocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=rmdc001 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t5 ON t5.inaylent="||g_enterprise||" AND t5.inayl001=rmdc005 AND t5.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t6 ON t6.inabent="||g_enterprise||" AND t6.inabsite=rmdcsite AND t6.inab001=rmdc005 AND t6.inab002=rmdc006  ",
 
                     " WHERE rmdcent=? AND rmdcdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         LET g_sql = g_sql CLIPPED, " AND rmdcsite = '", g_site CLIPPED,"' "
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rmdc_t.rmdcseq,rmdc_t.rmdcseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE armt400_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR armt400_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_rmda_m.rmdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_rmda_m.rmdadocno INTO g_rmdb2_d[l_ac].rmdcseq,g_rmdb2_d[l_ac].rmdcseq1, 
          g_rmdb2_d[l_ac].rmdc001,g_rmdb2_d[l_ac].rmdc002,g_rmdb2_d[l_ac].rmdc003,g_rmdb2_d[l_ac].rmdc004, 
          g_rmdb2_d[l_ac].rmdc005,g_rmdb2_d[l_ac].rmdc006,g_rmdb2_d[l_ac].rmdc007,g_rmdb2_d[l_ac].rmdc008, 
          g_rmdb2_d[l_ac].rmdcsite,g_rmdb2_d[l_ac].rmdc001_desc,g_rmdb2_d[l_ac].rmdc005_desc,g_rmdb2_d[l_ac].rmdc006_desc  
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
         CALL s_desc_get_stock_desc(g_site,g_rmdb2_d[l_ac].rmdc005) RETURNING g_rmdb2_d[l_ac].rmdc005_desc
         CALL s_desc_get_locator_desc(g_site,g_rmdb2_d[l_ac].rmdc005,g_rmdb2_d[l_ac].rmdc006) RETURNING g_rmdb2_d[l_ac].rmdc006_desc     
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
   #160202-00019#5
   IF NOT cl_null(g_rmda_m.rmdadocno) THEN 
      CALL s_lot_b_fill('1',g_site,'2',g_rmda_m.rmdadocno,'','','-1')                              
   END IF
   #160202-00019#5
   #end add-point
   
   CALL g_rmdb_d.deleteElement(g_rmdb_d.getLength())
   CALL g_rmdb2_d.deleteElement(g_rmdb2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE armt400_pb
   FREE armt400_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rmdb_d.getLength()
      LET g_rmdb_d_mask_o[l_ac].* =  g_rmdb_d[l_ac].*
      CALL armt400_rmdb_t_mask()
      LET g_rmdb_d_mask_n[l_ac].* =  g_rmdb_d[l_ac].*
   END FOR
   
   LET g_rmdb2_d_mask_o.* =  g_rmdb2_d.*
   FOR l_ac = 1 TO g_rmdb2_d.getLength()
      LET g_rmdb2_d_mask_o[l_ac].* =  g_rmdb2_d[l_ac].*
      CALL armt400_rmdc_t_mask()
      LET g_rmdb2_d_mask_n[l_ac].* =  g_rmdb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="armt400.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION armt400_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM rmdb_t
       WHERE rmdbent = g_enterprise AND
         rmdbdocno = ps_keys_bak[1] AND rmdbseq = ps_keys_bak[2]
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
         CALL g_rmdb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM rmdc_t
       WHERE rmdcent = g_enterprise AND
             rmdcdocno = ps_keys_bak[1] AND rmdcseq = ps_keys_bak[2] AND rmdcseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmdc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rmdb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="armt400.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION armt400_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO rmdb_t
                  (rmdbent,
                   rmdbdocno,
                   rmdbseq
                   ,rmdb001,rmdb002,rmdb003,rmdb004,rmdb005,rmdb014,rmdb006,rmdb013,rmdb015,rmdb016,rmdb017,rmdb012,rmdb007,rmdb008,rmdb009,rmdb010,rmdb011,rmdbsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002,g_rmdb_d[g_detail_idx].rmdb003, 
                       g_rmdb_d[g_detail_idx].rmdb004,g_rmdb_d[g_detail_idx].rmdb005,g_rmdb_d[g_detail_idx].rmdb014, 
                       g_rmdb_d[g_detail_idx].rmdb006,g_rmdb_d[g_detail_idx].rmdb013,g_rmdb_d[g_detail_idx].rmdb015, 
                       g_rmdb_d[g_detail_idx].rmdb016,g_rmdb_d[g_detail_idx].rmdb017,g_rmdb_d[g_detail_idx].rmdb012, 
                       g_rmdb_d[g_detail_idx].rmdb007,g_rmdb_d[g_detail_idx].rmdb008,g_rmdb_d[g_detail_idx].rmdb009, 
                       g_rmdb_d[g_detail_idx].rmdb010,g_rmdb_d[g_detail_idx].rmdb011,g_rmdb_d[g_detail_idx].rmdbsite) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmdb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rmdb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO rmdc_t
                  (rmdcent,
                   rmdcdocno,
                   rmdcseq,rmdcseq1
                   ,rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,rmdc006,rmdc007,rmdc008,rmdcsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_rmdb2_d[g_detail_idx].rmdc001,g_rmdb2_d[g_detail_idx].rmdc002,g_rmdb2_d[g_detail_idx].rmdc003, 
                       g_rmdb2_d[g_detail_idx].rmdc004,g_rmdb2_d[g_detail_idx].rmdc005,g_rmdb2_d[g_detail_idx].rmdc006, 
                       g_rmdb2_d[g_detail_idx].rmdc007,g_rmdb2_d[g_detail_idx].rmdc008,g_rmdb2_d[g_detail_idx].rmdcsite) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmdc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rmdb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="armt400.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION armt400_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rmdb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL armt400_rmdb_t_mask_restore('restore_mask_o')
               
      UPDATE rmdb_t 
         SET (rmdbdocno,
              rmdbseq
              ,rmdb001,rmdb002,rmdb003,rmdb004,rmdb005,rmdb014,rmdb006,rmdb013,rmdb015,rmdb016,rmdb017,rmdb012,rmdb007,rmdb008,rmdb009,rmdb010,rmdb011,rmdbsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002,g_rmdb_d[g_detail_idx].rmdb003, 
                  g_rmdb_d[g_detail_idx].rmdb004,g_rmdb_d[g_detail_idx].rmdb005,g_rmdb_d[g_detail_idx].rmdb014, 
                  g_rmdb_d[g_detail_idx].rmdb006,g_rmdb_d[g_detail_idx].rmdb013,g_rmdb_d[g_detail_idx].rmdb015, 
                  g_rmdb_d[g_detail_idx].rmdb016,g_rmdb_d[g_detail_idx].rmdb017,g_rmdb_d[g_detail_idx].rmdb012, 
                  g_rmdb_d[g_detail_idx].rmdb007,g_rmdb_d[g_detail_idx].rmdb008,g_rmdb_d[g_detail_idx].rmdb009, 
                  g_rmdb_d[g_detail_idx].rmdb010,g_rmdb_d[g_detail_idx].rmdb011,g_rmdb_d[g_detail_idx].rmdbsite)  
 
         WHERE rmdbent = g_enterprise AND rmdbdocno = ps_keys_bak[1] AND rmdbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmdb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmdb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL armt400_rmdb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rmdc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL armt400_rmdc_t_mask_restore('restore_mask_o')
               
      UPDATE rmdc_t 
         SET (rmdcdocno,
              rmdcseq,rmdcseq1
              ,rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,rmdc006,rmdc007,rmdc008,rmdcsite) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_rmdb2_d[g_detail_idx].rmdc001,g_rmdb2_d[g_detail_idx].rmdc002,g_rmdb2_d[g_detail_idx].rmdc003, 
                  g_rmdb2_d[g_detail_idx].rmdc004,g_rmdb2_d[g_detail_idx].rmdc005,g_rmdb2_d[g_detail_idx].rmdc006, 
                  g_rmdb2_d[g_detail_idx].rmdc007,g_rmdb2_d[g_detail_idx].rmdc008,g_rmdb2_d[g_detail_idx].rmdcsite)  
 
         WHERE rmdcent = g_enterprise AND rmdcdocno = ps_keys_bak[1] AND rmdcseq = ps_keys_bak[2] AND rmdcseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmdc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmdc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL armt400_rmdc_t_mask_restore('restore_mask_n')
 
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
 
{<section id="armt400.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION armt400_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="armt400.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION armt400_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="armt400.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION armt400_lock_b(ps_table,ps_page)
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
   #CALL armt400_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rmdb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN armt400_bcl USING g_enterprise,
                                       g_rmda_m.rmdadocno,g_rmdb_d[g_detail_idx].rmdbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "armt400_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "rmdc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN armt400_bcl2 USING g_enterprise,
                                             g_rmda_m.rmdadocno,g_rmdb2_d[g_detail_idx].rmdcseq,g_rmdb2_d[g_detail_idx].rmdcseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "armt400_bcl2:",SQLERRMESSAGE 
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
 
{<section id="armt400.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION armt400_unlock_b(ps_table,ps_page)
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
      CLOSE armt400_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE armt400_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="armt400.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION armt400_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rmdadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rmdadocno",TRUE)
      CALL cl_set_comp_entry("rmdadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("rmda004,rmda005,rmda006,rmda007,rmda008",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="armt400.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION armt400_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt  LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rmdadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rmdadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rmdadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF cl_chk_update_docdt() OR  p_cmd <> 'u' THEN
      CALL cl_set_comp_entry("rmdadocdt",TRUE)
   END IF 
   CALL cl_set_comp_entry("s_detail2",FALSE)
   #RMA单号不为空
   IF NOT cl_null(g_rmda_m.rmda004) THEN
      CALL cl_set_comp_entry("rmda005,rmda006,rmda007,rmda008",FALSE)
   END IF
   #若有单身资料，RMA单号不可修改
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM rmdb_t
    WHERE rmdbent = g_enterprise
      AND rmdbdocno = g_rmda_m.rmdadocno
   IF l_cnt > 0 THEN 
      CALL cl_set_comp_entry("rmda004",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="armt400.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION armt400_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("rmdb007,rmdb008,rmdb009,rmdb010",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="armt400.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION armt400_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_slip     LIKE ooba_t.ooba001
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_imaa005  LIKE imaa_t.imaa005
   DEFINE l_xmdc022  LIKE xmdc_t.xmdc022
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   #若為多庫儲批出貨
   IF g_rmdb_d[l_ac].rmdb012 = 'Y' THEN
      CALL cl_set_comp_entry("rmdb007,rmdb008,rmdb009,rmdb010",FALSE)
   END IF
   
   #庫存批號控管方式
   IF NOT s_axmt540_imaf061_chk(g_rmdb_d[l_ac].rmdb003) THEN
      CALL cl_set_comp_entry("rmdb009",FALSE)
   END IF

   #儲位控管若為5.不使用儲位控管
   IF NOT s_axmt540_inaa007_chk(g_rmdb_d[l_ac].rmdb007) THEN
      CALL cl_set_comp_entry("rmdb008",FALSE)
   END IF

   #判斷料件是否存在產品特徵
   IF NOT cl_null(g_rmdb_d[l_ac].rmdb003) THEN
      CALL s_axmt500_get_imaa005(g_enterprise,g_rmdb_d[l_ac].rmdb003) RETURNING l_imaa005
      IF cl_null(l_imaa005) THEN
         CALL cl_set_comp_entry("rmdb004",FALSE)
      END IF
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="armt400.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION armt400_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail,armt400_call_armt400_01",TRUE)
  
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt400.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION armt400_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rmda_m.rmdastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   IF g_rmda_m.rmdastus NOT MATCHES '[NY]' THEN
      CALL cl_set_act_visible("armt400_call_armt400_01",FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt400.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION armt400_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt400.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION armt400_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt400.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION armt400_default_search()
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
      LET ls_wc = ls_wc, " rmdadocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   IF NOT cl_null(g_argv[02]) THEN        #160816-00066#6 add
      LET ls_wc = ls_wc,g_argv[02]," AND "
   END IF
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
               WHEN la_wc[li_idx].tableid = "rmda_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rmdb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rmdc_t" 
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
 
{<section id="armt400.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION armt400_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_slip          LIKE ooba_t.ooba001
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rmda_m.rmdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN armt400_cl USING g_enterprise,g_rmda_m.rmdadocno
   IF STATUS THEN
      CLOSE armt400_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt400_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE armt400_master_referesh USING g_rmda_m.rmdadocno INTO g_rmda_m.rmdadocno,g_rmda_m.rmdasite, 
       g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002,g_rmda_m.rmda003,g_rmda_m.rmdastus,g_rmda_m.rmda004, 
       g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010, 
       g_rmda_m.rmda011,g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016, 
       g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019,g_rmda_m.rmdaownid,g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtid, 
       g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
       g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstdt,g_rmda_m.rmda002_desc,g_rmda_m.rmda003_desc, 
       g_rmda_m.rmda005_desc,g_rmda_m.rmda006_desc,g_rmda_m.rmda007_desc,g_rmda_m.rmda008_desc,g_rmda_m.rmda012_desc, 
       g_rmda_m.rmda015_desc,g_rmda_m.rmda018_desc,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp_desc, 
       g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp_desc,g_rmda_m.rmdamodid_desc,g_rmda_m.rmdacnfid_desc, 
       g_rmda_m.rmdapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT armt400_action_chk() THEN
      CLOSE armt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rmda_m.rmdadocno,g_rmda_m.rmdadocno_desc,g_rmda_m.rmdasite,g_rmda_m.rmdadocdt,g_rmda_m.rmda001, 
       g_rmda_m.rmda002,g_rmda_m.rmda002_desc,g_rmda_m.rmda003,g_rmda_m.rmda003_desc,g_rmda_m.rmdastus, 
       g_rmda_m.rmda004,g_rmda_m.rmda005,g_rmda_m.rmda005_desc,g_rmda_m.rmda006,g_rmda_m.rmda006_desc, 
       g_rmda_m.rmda007,g_rmda_m.rmda007_desc,g_rmda_m.rmda008,g_rmda_m.rmda008_desc,g_rmda_m.rmda009, 
       g_rmda_m.rmda010,g_rmda_m.rmda011,g_rmda_m.rmda011_desc,g_rmda_m.address,g_rmda_m.rmda012,g_rmda_m.rmda012_desc, 
       g_rmda_m.rmda013,g_rmda_m.rmda013_desc,g_rmda_m.rmda014,g_rmda_m.rmda014_desc,g_rmda_m.rmda015, 
       g_rmda_m.rmda015_desc,g_rmda_m.rmda016,g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda018_desc, 
       g_rmda_m.rmda019,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid,g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp, 
       g_rmda_m.rmdaowndp_desc,g_rmda_m.rmdacrtid,g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdp_desc, 
       g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamodid_desc,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
       g_rmda_m.rmdacnfid_desc,g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstid_desc,g_rmda_m.rmdapstdt 
 
 
   CASE g_rmda_m.rmdastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "Z"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_rmda_m.rmdastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "S"
               HIDE OPTION "posted"
            WHEN "Z"
               HIDE OPTION "unposted"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      #confirmed   確認
      #unconfirmed 取消確認
      #posted      過帳
      #unposted    取消過帳
      #invalid     作廢     
      
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted,invalid,unhold,hold",FALSE)

      CASE g_rmda_m.rmdastus
         WHEN "N"   #未確認
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

         WHEN "X"   #作廢
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN

         WHEN "Y"   #已確認
            CALL cl_set_act_visible("unconfirmed,posted",TRUE)

         WHEN "S"   #已過帳
           CALL cl_set_act_visible("unposted",TRUE)
           
         WHEN "Z"  #扣帳還原
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN
      END CASE   
      #end add-point
      
      
	  
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
            LET lc_state = "Y"
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
      AND lc_state <> "S"
      AND lc_state <> "Z"
      AND lc_state <> "X"
      ) OR 
      g_rmda_m.rmdastus = lc_state OR cl_null(lc_state) THEN
      CLOSE armt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_err_collect_init()
   
   CASE lc_state
      WHEN 'Y'
         IF g_rmda_m.rmdastus = 'N' THEN    #確認
            CALL s_armt400_conf_chk(g_rmda_m.rmdadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
               RETURN
            ELSE
               IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
                  RETURN
               ELSE
                  CALL s_transaction_begin()
                  
                  CALL s_aooi200_get_slip(g_rmda_m.rmdadocno) RETURNING l_success,l_slip
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()
                     RETURN
                  END IF
                  
                  CALL s_armt400_conf_upd(g_rmda_m.rmdadocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()
                     RETURN
                  ELSE
                     #銷退單單別參數設置"自動過帳"
                     IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0083') = 'Y' THEN                  
                        LET lc_state = 'S'
                     END IF
                     CALL s_transaction_end('Y','0')
                  END IF

               END IF
            END IF
         END IF
         
         IF g_rmda_m.rmdastus = 'S' THEN   #取消過帳
            CALL cl_err_collect_init() 
            CALL s_armt400_unpost_chk(g_rmda_m.rmdadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
               RETURN
            ELSE
               IF NOT cl_ask_confirm('sub-00361') THEN  #是否執行取消過帳？
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
                  RETURN
               ELSE
                  CALL s_transaction_begin()
                  CALL s_armt400_unpost_upd(g_rmda_m.rmdadocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
            END IF
         END IF
      WHEN 'X'   #作廢
         CALL s_armt400_invalid_chk(g_rmda_m.rmdadocno) RETURNING l_success
         IF NOT l_success THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00109') THEN  #是否執行作廢？
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_armt400_invalid_upd(g_rmda_m.rmdadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF   
      
      WHEN 'S'  #過帳
         CALL s_armt400_post_chk(g_rmda_m.rmdadocno) RETURNING l_success
         IF NOT l_success THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN
         ELSE
            IF NOT cl_ask_confirm('sub-00360') THEN  #是否執行過帳？
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
               RETURN
            ELSE
               CALL s_transaction_begin()
               IF armt400_rmda001_upd() THEN
                  CALL s_armt400_post_upd(g_rmda_m.rmdadocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
            END IF
         END IF   
      
      WHEN 'N'  #取消確認
         CALL s_armt400_unconf_chk(g_rmda_m.rmdadocno) RETURNING l_success
         IF NOT l_success THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_armt400_unconf_upd(g_rmda_m.rmdadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
              
   END CASE
   
   CALL cl_err_collect_show()
   #end add-point
   
   LET g_rmda_m.rmdamodid = g_user
   LET g_rmda_m.rmdamoddt = cl_get_current()
   LET g_rmda_m.rmdastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rmda_t 
      SET (rmdastus,rmdamodid,rmdamoddt) 
        = (g_rmda_m.rmdastus,g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt)     
    WHERE rmdaent = g_enterprise AND rmdadocno = g_rmda_m.rmdadocno
 
    
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
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE armt400_master_referesh USING g_rmda_m.rmdadocno INTO g_rmda_m.rmdadocno,g_rmda_m.rmdasite, 
          g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002,g_rmda_m.rmda003,g_rmda_m.rmdastus,g_rmda_m.rmda004, 
          g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmda009,g_rmda_m.rmda010, 
          g_rmda_m.rmda011,g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016, 
          g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019,g_rmda_m.rmdaownid,g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtid, 
          g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid, 
          g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstdt,g_rmda_m.rmda002_desc,g_rmda_m.rmda003_desc, 
          g_rmda_m.rmda005_desc,g_rmda_m.rmda006_desc,g_rmda_m.rmda007_desc,g_rmda_m.rmda008_desc,g_rmda_m.rmda012_desc, 
          g_rmda_m.rmda015_desc,g_rmda_m.rmda018_desc,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid_desc, 
          g_rmda_m.rmdaowndp_desc,g_rmda_m.rmdacrtid_desc,g_rmda_m.rmdacrtdp_desc,g_rmda_m.rmdamodid_desc, 
          g_rmda_m.rmdacnfid_desc,g_rmda_m.rmdapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rmda_m.rmdadocno,g_rmda_m.rmdadocno_desc,g_rmda_m.rmdasite,g_rmda_m.rmdadocdt, 
          g_rmda_m.rmda001,g_rmda_m.rmda002,g_rmda_m.rmda002_desc,g_rmda_m.rmda003,g_rmda_m.rmda003_desc, 
          g_rmda_m.rmdastus,g_rmda_m.rmda004,g_rmda_m.rmda005,g_rmda_m.rmda005_desc,g_rmda_m.rmda006, 
          g_rmda_m.rmda006_desc,g_rmda_m.rmda007,g_rmda_m.rmda007_desc,g_rmda_m.rmda008,g_rmda_m.rmda008_desc, 
          g_rmda_m.rmda009,g_rmda_m.rmda010,g_rmda_m.rmda011,g_rmda_m.rmda011_desc,g_rmda_m.address, 
          g_rmda_m.rmda012,g_rmda_m.rmda012_desc,g_rmda_m.rmda013,g_rmda_m.rmda013_desc,g_rmda_m.rmda014, 
          g_rmda_m.rmda014_desc,g_rmda_m.rmda015,g_rmda_m.rmda015_desc,g_rmda_m.rmda016,g_rmda_m.rmda017, 
          g_rmda_m.rmda018,g_rmda_m.rmda018_desc,g_rmda_m.rmda019,g_rmda_m.rmda019_desc,g_rmda_m.rmdaownid, 
          g_rmda_m.rmdaownid_desc,g_rmda_m.rmdaowndp,g_rmda_m.rmdaowndp_desc,g_rmda_m.rmdacrtid,g_rmda_m.rmdacrtid_desc, 
          g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdp_desc,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamodid_desc, 
          g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid,g_rmda_m.rmdacnfid_desc,g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid, 
          g_rmda_m.rmdapstid_desc,g_rmda_m.rmdapstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   CALL armt400_detail_action_hidden(g_detail_idx)
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE armt400_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL armt400_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt400.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION armt400_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rmdb_d.getLength() THEN
         LET g_detail_idx = g_rmdb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rmdb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rmdb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_rmdb2_d.getLength() THEN
         LET g_detail_idx = g_rmdb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rmdb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rmdb2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   CALL armt400_detail_action_hidden(g_detail_idx)

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="armt400.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION armt400_b_fill2(pi_idx)
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
   
   CALL armt400_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="armt400.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION armt400_fill_chk(ps_idx)
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
 
{<section id="armt400.status_show" >}
PRIVATE FUNCTION armt400_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="armt400.mask_functions" >}
&include "erp/arm/armt400_mask.4gl"
 
{</section>}
 
{<section id="armt400.signature" >}
   
 
{</section>}
 
{<section id="armt400.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION armt400_set_pk_array()
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
   LET g_pk_array[1].values = g_rmda_m.rmdadocno
   LET g_pk_array[1].column = 'rmdadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt400.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="armt400.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION armt400_msgcentre_notify(lc_state)
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
   CALL armt400_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rmda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt400.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION armt400_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#33-s
   SELECT rmdastus INTO g_rmda_m.rmdastus FROM rmda_t
    WHERE rmdaent = g_enterprise
      AND rmdasite = g_site
      AND rmdadocno = g_rmda_m.rmdadocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_rmda_m.rmdastus
        WHEN 'W'
           LET g_errno = 'sub-01347'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
        WHEN 'Z'
           LET g_errno = 'sub-00231'           
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_rmda_m.rmdadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL armt400_set_act_visible()
        CALL armt400_set_act_no_visible()
        CALL armt400_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#33-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="armt400.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 根据客户编号带出其他资料
# Memo...........: 自動帶出客戶預設資料
# Usage..........: CALL armt400_rmda005_default()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2015-6-3 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_rmda005_default()
   DEFINE l_rmda       RECORD
      rmda002             LIKE rmda_t.rmda003,   #業務人員   
      rmda003             LIKE rmda_t.rmda004,   #業務部門
      rmda011             LIKE rmda_t.rmda011,   #送貨地址
      rmda012             LIKE rmda_t.rmda012,   #運輸方式
      rmda013             LIKE rmda_t.rmda013,   #交運起點
      rmda014             LIKE rmda_t.rmda014   #交運終點
                       END RECORD

   DEFINE l_success       LIKE type_t.num5

   DEFINE l_search        LIKE type_t.chr1
   DEFINE l_controlno     LIKE ooha_t.ooha001
   DEFINE l_pmaa096       LIKE pmaa_t.pmaa096   #預設業務員  
   DEFINE l_pmaa097       LIKE pmaa_t.pmaa097   #預設業務部門
   

   INITIALIZE l_rmda.* TO NULL
   LET l_search = 'N'

   IF NOT cl_null(g_rmda_m.rmda005) THEN
      LET l_success = ''
      LET l_controlno = ''

      CALL s_control_get_group('2',g_user,g_dept) RETURNING l_success,l_controlno
      #判斷客戶是否有設置訂單控制組客戶預設條件(axmi111)，若有則抓取相關的預設條件      
      IF l_success THEN
         SELECT xmae011,xmae012,xmae013,xmae019,xmae025   
           INTO l_rmda.rmda012,l_rmda.rmda013,l_rmda.rmda014,l_rmda.rmda002,l_rmda.rmda003
           FROM xmae_t
          WHERE xmaeent = g_enterprise
            AND xmae001 = g_rmda_m.rmda005
            AND xmae002 = l_controlno
               
          IF NOT SQLCA.sqlcode THEN   #有找到資料
             LET l_search = 'Y'                
          END IF
      END IF

      IF l_search = 'N' THEN             #改抓客戶據點預設條件(axmm202)資料
         SELECT pmab090,pmab091,pmab092,pmab081,pmab109   
           INTO l_rmda.rmda012,l_rmda.rmda013,l_rmda.rmda014,l_rmda.rmda002,l_rmda.rmda003
           FROM pmab_t
          WHERE pmabent = g_enterprise            
            AND pmabsite = g_site
            AND pmab001 = g_rmda_m.rmda005
      END IF
      
      IF cl_null(l_rmda.rmda002) OR cl_null(l_rmda.rmda003) THEN
         LET l_pmaa096 = ''
         LET l_pmaa097 = ''
         SELECT pmaa096,pmaa097 INTO l_pmaa096,l_pmaa097
           FROM pmaa_t
          WHERE pmaaent = g_enterprise
            AND pmaa001 = g_rmda_m.rmda005
            
         IF cl_null(l_rmda.rmda002) THEN
            LET l_rmda.rmda002 = l_pmaa096
         END IF
         
         IF cl_null(l_rmda.rmda003) THEN
            LET l_rmda.rmda003 = l_pmaa097
         END IF
      END IF 
      
      IF NOT cl_null(l_rmda.rmda002) AND cl_null(l_rmda.rmda003) THEN
         SELECT ooag003 INTO l_rmda.rmda003
           FROM ooag_t 
          WHERE ooagent = g_enterprise 
            AND ooag001 = l_rmda.rmda002
      END IF
      
      IF cl_null(l_rmda.rmda002) THEN
         LET l_rmda.rmda002 = g_user
      END IF
      
      IF cl_null(l_rmda.rmda003) THEN
         LET l_rmda.rmda003 = g_dept
      END IF
      
   END IF
 
   LET g_rmda_m.rmda002 = l_rmda.rmda002
   LET g_rmda_m.rmda003 = l_rmda.rmda003
   LET g_rmda_m.rmda011 = l_rmda.rmda011
   LET g_rmda_m.rmda012 = l_rmda.rmda012
   LET g_rmda_m.rmda013 = l_rmda.rmda013
   LET g_rmda_m.rmda014 = l_rmda.rmda014

   CALL armt400_rmda011_ref()
   CALL s_desc_get_person_desc(g_rmda_m.rmda002) RETURNING g_rmda_m.rmda002_desc
   CALL s_desc_get_department_desc(g_rmda_m.rmda003) RETURNING g_rmda_m.rmda003_desc
   CALL s_desc_get_acc_desc('263',g_rmda_m.rmda012) RETURNING g_rmda_m.rmda012_desc
   DISPLAY BY NAME g_rmda_m.rmda012_desc
   CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda013) RETURNING g_rmda_m.rmda013_desc
   DISPLAY BY NAME g_rmda_m.rmda013_desc
   CALL armt400_location_ref(g_rmda_m.rmda012,g_rmda_m.rmda014) RETURNING g_rmda_m.rmda014_desc
   DISPLAY BY NAME g_rmda_m.rmda014_desc

   LET g_rmda_m_o.* = g_rmda_m.*
   DISPLAY BY NAME g_rmda_m.*

END FUNCTION

################################################################################
# Descriptions...: 查詢交易夥伴資料
# Memo...........:
# Usage..........: CALL armt400_client_partner(p_rmdadocno,p_rmda005,p_type)
#                  RETURNING r_client_par
# Input parameter: p_rmdadocno    單據單號
#                : p_rmda005      客戶
#                : p_type         交易類型(1.收付款對象2.出貨對象)
# Return code....: r_client_par   交易夥伴對象
#                : 
# Date & Author..: 2015-5-22 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_client_partner(p_rmdadocno,p_rmda005,p_type)
   DEFINE p_rmdadocno   LIKE rmda_t.rmdadocno #單據單號
   DEFINE p_rmda005     LIKE rmda_t.rmda005   #客戶
   DEFINE p_type        LIKE pmac_t.pmac003   #交易類型(1.收付款對象,2.出貨對象,3.發票對象)
   
   DEFINE r_client_par  LIKE xmdk_t.xmdk008   #交易夥伴
   
   DEFINE l_sql         STRING   
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_where       STRING 
   DEFINE l_pmac002     LIKE pmac_t.pmac002

   WHENEVER ERROR CONTINUE
   
   LET r_client_par = ''

   IF NOT cl_null(p_rmda005) THEN
      LET l_sql = "SELECT pmac002 FROM pmab_t,pmac_t",
                  " WHERE pmabent = pmacent AND pmacent = ",g_enterprise,
                  "   AND pmac001 = '",p_rmda005,"'",
                  "   AND pmac003 = '",p_type,"'",
                  "   AND pmabsite = '",g_site,"'",
                  "   AND pmab001 = pmac002",
                  " ORDER BY pmac004 DESC,pmac002"
      PREPARE client_pre FROM l_sql
      DECLARE client_cur SCROLL CURSOR FOR client_pre

      LET l_pmac002 = ''
      OPEN client_cur
      FETCH FIRST client_cur INTO l_pmac002
      
      IF cl_null(l_pmac002) THEN  #無設置交易對象夥伴時預設為客戶編號
         LET r_client_par = p_rmda005
      ELSE
         LET r_client_par = l_pmac002
      END IF

   END IF   
   
   RETURN r_client_par
END FUNCTION

################################################################################
# Descriptions...: 校验送货地址
# Memo...........:
# Usage..........: CALL armt400_rmda006_rmda011_chk()
#                  RETURNING 回传参数
# Date & Author..: 2015-5-22 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_rmda006_rmda011_chk()
   DEFINE l_pmaa027       LIKE pmaa_t.pmaa027
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF NOT cl_null(g_rmda_m.rmda006) AND NOT cl_null(g_rmda_m.rmda011) THEN     
                  
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
               
      CALL s_axmt500_get_pmaa027(g_rmda_m.rmda006) RETURNING l_pmaa027
               
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = l_pmaa027
      LET g_chkparam.arg2 = g_rmda_m.rmda011
      #160318-00025#21  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
      #160318-00025#21  by 07900 --add-end                           
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_oofb019") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 获取地址说明
# Memo...........:
# Usage..........: CALL armt400_rmda011_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-5-22 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_rmda011_ref()
   DEFINE l_pmaa027   LIKE pmaa_t.pmaa027  #聯絡對象識別碼
   DEFINE l_success   LIKE type_t.num5       #處理狀態
   DEFINE l_address   STRING                 #地址

   INITIALIZE g_ref_fields TO NULL
   
   CALL s_axmt500_get_pmaa027(g_rmda_m.rmda006) RETURNING l_pmaa027

   LET g_ref_fields[1] = l_pmaa027
   LET g_ref_fields[2] = g_rmda_m.rmda011
   CALL ap_ref_array2(g_ref_fields,"SELECT oofb011 FROM oofb_t 
                                     WHERE oofbent='"||g_enterprise||"' 
                                       AND oofb002 =? AND oofbstus = 'Y' 
                                       AND oofb019 =?","") RETURNING g_rtn_fields
   LET g_rmda_m.rmda011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rmda_m.rmda011_desc
   
   #組合地址
   LET l_address = ''
   IF NOT cl_null(g_rmda_m.rmda006) AND NOT cl_null(g_rmda_m.rmda011) THEN         
      
      IF NOT cl_null(l_pmaa027) THEN
         CALL s_aooi350_get_address(l_pmaa027,g_rmda_m.rmda011,g_dlang) RETURNING l_success,l_address
         IF NOT l_success THEN
            LET l_address = ''
         END IF   
      END IF      
   END IF
   
   LET g_rmda_m.address = l_address
   DISPLAY BY NAME g_rmda_m.address
END FUNCTION

################################################################################
# Descriptions...: 获取运输地址说明
# Memo...........:
# Usage..........: CALL armt400_location_ref(p_transport,p_location)
#                  RETURNING 回传参数
# Date & Author..: 2015-5-22 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_location_ref(p_transport,p_location)
   DEFINE p_transport           LIKE rmda_t.rmda012   #運輸方式
   DEFINE p_location            LIKE rmda_t.rmda013   #地點
   DEFINE r_display             LIKE type_t.chr10
   DEFINE l_oocq019             LIKE oocq_t.oocq019   #運輸方式

   LET r_display = ''
   LET l_oocq019 = ''

   IF cl_null(p_transport) OR
      cl_null(p_location) THEN
      RETURN r_display
   END IF

   SELECT oocq019 INTO l_oocq019
     FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = '263'
      AND oocq002 = p_transport

   CASE
      WHEN l_oocq019 = '1' OR    #陸運
           l_oocq019 = '4'       #其他
           
         DECLARE armt400_location_sel_cs SCROLL CURSOR FOR
            SELECT oockl005 FROM oockl_t
             WHERE oocklent = g_enterprise
               AND oockl003 = p_location
               AND oockl004 = g_dlang
             ORDER BY oockl001,oockl002
         OPEN armt400_location_sel_cs
         FETCH FIRST armt400_location_sel_cs INTO r_display
         RETURN r_display
                    
      WHEN l_oocq019 = '2'     #海運
            
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_location
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='262' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_display = '', g_rtn_fields[1] , ''
         RETURN r_display                                
   
      WHEN l_oocq019 = '3'     #空運

         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_location
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='276' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_display = '', g_rtn_fields[1] , ''
         RETURN r_display
           
   END CASE
   RETURN r_display
END FUNCTION

################################################################################
# Descriptions...: 根據RMA單號、項次,覆出类型帶出料號、產品特征、單位、覆出數量
# Memo...........: 带出单价，并带出覆出的覆出数量
# Usage..........: CALL armt400_rmdb_default_insert(p_rmdb001,p_rmdb002,p_rmdb014)
#                  RETURNING r_success
# Date & Author..: 2015-6-1 By zhujing
# Modify.........: 2016-2-23 BY zhujing
################################################################################
PRIVATE FUNCTION armt400_rmdb_default_insert(p_rmdb001,p_rmdb002,p_rmdb014)
   DEFINE p_rmdb001     LIKE rmdb_t.rmdb001
   DEFINE p_rmdb002     LIKE rmdb_t.rmdb002
   DEFINE p_rmdb014     LIKE rmdb_t.rmdb014
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_sql_rmdb    STRING
   DEFINE l_sql_cnt     STRING
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_sum         LIKE type_t.num5
   DEFINE l_flag1       LIKE type_t.num5           #160816-00066#3 add
   DEFINE l_ooac002     LIKE ooac_t.ooac002        #160816-00066#3 add

   LET r_success = TRUE
   LET g_errno = ''

   LET g_rmdb_d[l_ac].rmdb004 = ''           
   LET g_rmdb_d[l_ac].rmdb005 = ''           
   LET g_rmdb_d[l_ac].rmdb006 = '' 
   LET g_rmdb_d[l_ac].rmdb015 = 0      #2016-2-23 zhujing add
   IF cl_null(p_rmdb014) OR p_rmdb014 = '2' THEN
      LET r_success = FALSE
      RETURN r_success
#      LET g_rmdb_d[l_ac].rmdb014 = '1'    #2016-2-23 zhujing add
#      LET p_rmdb014 = '1'
   ELSE
      LET g_rmdb_d[l_ac].rmdb014 = p_rmdb014    #2016-2-23 zhujing add
   END IF
   #2016-2-23 zhujing mod ------(S)
#   LET l_sql_rmdb = " SELECT DISTINCT rmab009,rmab010,rmab011,(COALESCE(rmab012,0)-COALESCE(rmab015,0)) ",
#                    " FROM rmab_t ",
   LET l_sql_rmdb = " SELECT DISTINCT rmab009,rmab010,rmab011,0,rmbb003 ",
                    " FROM rmab_t LEFT OUTER JOIN rmbb_t ON rmabdocno = rmbbdocno AND rmabseq = rmbbseq AND rmabsite = rmbbsite AND rmabent = rmbbent ",
                    " AND rmbb000 = (SELECT MAX(rmbb000) FROM rmbb_t WHERE rmbbdocno =rmabdocno AND rmabseq = rmbbseq) ",
                    " WHERE rmabdocno = '",p_rmdb001,"' ",
                    "   AND rmabseq = ",p_rmdb002,
                    "   AND rmabent = ",g_enterprise,
                    "   AND rmabsite = '",g_site,"' ",
                    " ORDER BY rmab009,rmab010,rmab011 "
   LET l_sql_cnt = " SELECT COUNT(1) FROM (",l_sql_rmdb,")" 
   LET l_cnt = 0
   PREPARE armt400_rmdb_cnt_pre FROM l_sql_cnt
   EXECUTE armt400_rmdb_cnt_pre INTO l_cnt
   IF cl_null(l_cnt) OR l_cnt = 0 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_rmdb_d[l_ac].rmdb001,"+",g_rmdb_d[l_ac].rmdb002
      LET g_errparam.code   = 'arm-00019' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   PREPARE armt400_rmdb_default_pre FROM l_sql_rmdb
#   EXECUTE armt400_rmdb_default_pre INTO g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb006
   EXECUTE armt400_rmdb_default_pre INTO g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb006,g_rmdb_d[l_ac].rmdb015
   #2016-2-23 zhujing mod ------(E)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF cl_null(g_rmdb_d[l_ac].rmdb015) THEN LET g_rmdb_d[l_ac].rmdb015 = 0  END IF      #2016-3-28 zhujing add
      #計算已覆出數量
      LET l_sum = 0
      #2016-2-24 marked by zhujing
#      SELECT SUM(rmdb006) INTO l_sum
#        FROM rmdb_t
#       WHERE rmdb001 = p_rmdb001
#         AND rmdb002 = p_rmdb002
#         AND rmdbent = g_enterprise
#         AND rmdbsite = g_site
      #2016-2-24 marked by zhujing
      #2016-2-24 add by zhujing-----(S)
      SELECT SUM(rmdb006) INTO l_sum
        FROM rmdb_t LEFT OUTER JOIN rmda_t ON rmdadocno = rmdbdocno AND rmdaent = rmdbent AND rmdasite = rmdbsite
       WHERE rmdb001 = p_rmdb001
         AND rmdb002 = p_rmdb002
         AND rmdbent = g_enterprise 
         AND rmdbsite = g_site
         AND rmdb014 = p_rmdb014
         AND (rmdbdocno <> g_rmda_m.rmdadocno OR rmdbseq <> g_rmdb_d[l_ac].rmdbseq)
         AND rmdastus <> 'X'
      IF cl_null(l_sum) THEN LET l_sum = 0 END IF
      #计算可覆出总量
      LET l_cnt = 0
      SELECT SUM(COALESCE(rmcb007,0)) INTO l_cnt
        FROM rmcb_t LEFT OUTER JOIN rmca_t ON rmcadocno = rmcbdocno AND rmcaent = rmcbent AND rmcasite = rmcbsite
       WHERE rmcbent = g_enterprise
         AND rmcb001 = p_rmdb001
         AND rmcb002 = p_rmdb002
         AND rmcb009 <> '2'
         AND rmcb009 = p_rmdb014
         AND rmcbsite = g_site
         AND rmcastus = 'Y'
       GROUP BY rmcb001,rmcb002
       ORDER BY rmcb001,rmcb002
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      #2016-2-24 add by zhujing-----(E)
      IF cl_null(l_sum) THEN LET l_sum = 0 END IF
      LET g_rmdb_d[l_ac].rmdbseq = l_ac
      LET g_rmdb_d[l_ac].rmdbsite = g_site
      LET g_rmdb_d[l_ac].rmdb001 = p_rmdb001
      LET g_rmdb_d[l_ac].rmdb002 = p_rmdb002
      LET g_rmdb_d[l_ac].rmdb012 = 'N'
#      LET g_rmdb_d[l_ac].rmdb006 = g_rmdb_d[l_ac].rmdb006 - l_sum
      LET g_rmdb_d[l_ac].rmdb006 = l_cnt - l_sum                  #2016-2-24 mod by zhujing
      IF g_rmdb_d[l_ac].rmdb006 < 0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code   = 'arm-00026' 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_rmdb_d[l_ac].rmdb006 = 0
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF g_rmdb_d[l_ac].rmdb006 = 0 THEN                  #2016-5-12 mod by zhujing
#         INITIALIZE g_rmdb_d[l_ac].* TO NULL
#         CALL g_rmdb_d.deleteElement(l_ac)
#         LET l_ac = l_ac-1
#         INITIALIZE g_errparam TO NULL       #2016-5-27 zhujing marked
#         LET g_errparam.code   = 'arm-00025' 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      IF p_rmdb014 = '1' THEN
         LET g_rmdb_d[l_ac].rmdb013 = g_rmdb_d[l_ac].rmdb006         #2016-2-24 mod by zhujing 计价数量预设为覆出数量
         CALL armt400_get_money(p_rmdb001,p_rmdb002,g_rmdb_d[l_ac].rmdb013,g_rmdb_d[l_ac].rmdb015) 
            RETURNING g_rmdb_d[l_ac].rmdb016,g_rmdb_d[l_ac].rmdb017
      ELSE
         LET g_rmdb_d[l_ac].rmdb013 = 0                              #2016-2-24 mod by zhujing 计价数量预设为0
         LET g_rmdb_d[l_ac].rmdb016 = 0
         LET g_rmdb_d[l_ac].rmdb017 = 0
      END IF
      #160816-00066#3 add-S
      CALL s_aooi200_get_slip(g_rmda_m.rmdadocno) RETURNING l_flag1,l_ooac002    
      LET g_rmdb_d[l_ac].rmdb007 = cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0042')
      #160816-00066#3 add-E
      #获取料件品名规格
      CALL s_desc_get_item_desc(g_rmdb_d[l_ac].rmdb003)
         RETURNING g_rmdb_d[l_ac].rmdb003_desc,g_rmdb_d[l_ac].rmdb003_desc_1
      #获取产品特征说明
      CALL s_feature_description(g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004) 
         RETURNING l_success,g_rmdb_d[l_ac].rmdb004_desc
      
      LET g_rmdb_d_o.* = g_rmdb_d[l_ac].*
      
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 開窗查詢庫位、儲位、批號及庫存管理特征
# Memo...........:
# Usage..........: CALL armt400_rmdb007_rmdb008_rmdb009_rmdb010_qry(p_type)
#                  RETURNING 回传参数
# p_type 1.庫位2.儲位3.批號4.庫存管理特徵
# Date & Author..: 2015-6-1 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_rmdb007_rmdb008_rmdb009_rmdb010_qry(p_type)
   DEFINE p_type            LIKE type_t.chr1

   
   #開窗i段
   INITIALIZE g_qryparam.* TO NULL
   LET g_qryparam.state = 'i'
   LET g_qryparam.reqry = FALSE
   
   LET g_qryparam.default1 = g_rmdb_d[l_ac].rmdb007             #給予default值
   LET g_qryparam.default2 = g_rmdb_d[l_ac].rmdb008
   LET g_qryparam.default3 = g_rmdb_d[l_ac].rmdb009
   LET g_qryparam.default4 = g_rmdb_d[l_ac].rmdb010
     
   #給予arg
   LET g_qryparam.arg1 = g_rmdb_d[l_ac].rmdb003
   LET g_qryparam.arg2 = g_rmdb_d[l_ac].rmdb004
     
   LET g_qryparam.where = "inag007 = '",g_rmdb_d[l_ac].rmdb005,"' AND inaa010 = 'N' "

   CALL q_inag004_13()

   #庫位
   LET g_rmdb_d[l_ac].rmdb007 = g_qryparam.return1
   DISPLAY g_rmdb_d[l_ac].rmdb007 TO rmdb007
   CALL s_desc_get_stock_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007) RETURNING g_rmdb_d[l_ac].rmdb007_desc
      
   #儲位
   LET g_rmdb_d[l_ac].rmdb008 = g_qryparam.return2
   DISPLAY g_rmdb_d[l_ac].rmdb008 TO rmdb008
   CALL s_desc_get_locator_desc(g_rmdb_d[l_ac].rmdbsite,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008) RETURNING g_rmdb_d[l_ac].rmdb008_desc
   
   #批號
   LET g_rmdb_d[l_ac].rmdb009 = g_qryparam.return3
   DISPLAY g_rmdb_d[l_ac].rmdb009 TO rmdb009
    
   #庫存管理特徵
   LET g_rmdb_d[l_ac].rmdb010 = g_qryparam.return4
   DISPLAY g_rmdb_d[l_ac].rmdb010 TO rmdb010


END FUNCTION

PRIVATE FUNCTION armt400_rmdadocdt_rmda001_chk()
   DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
   #151120-00003#1 20151123 mark by beckxie---S
   #IF NOT cl_null(g_rmda_m.rmda001) AND NOT cl_null(g_rmda_m.rmdadocdt) THEN
   #   IF g_rmda_m.rmda001 < g_rmda_m.rmdadocdt THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = 'axm-00267'    #扣帳日期不可小於單據日期！
   #      LET g_errparam.extend = ''
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #      
   #      LET r_success = FALSE
   #      RETURN r_success
   #   END IF
   #END IF
   #151120-00003#1 20151123 mark by beckxie---E
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 檢查是否還有可覆出數量
# Memo...........: 根据覆出类型来带出
# Usage..........: CALL armt400_rmdb006_chk(p_rmdb001,p_rmdb002,p_rmdb014,p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-4 By zhujing
# Modify.........: 2016-2-24 BY zhujing
################################################################################
PRIVATE FUNCTION armt400_rmdb006_chk(p_rmdb001,p_rmdb002,p_rmdb014,p_type)
DEFINE p_rmdb001  LIKE rmdb_t.rmdb001
DEFINE p_rmdb002  LIKE rmdb_t.rmdb002
DEFINE p_rmdb014  LIKE rmdb_t.rmdb014
DEFINE p_type     LIKE type_t.chr2     #1.新增，直接带出     2.修改，只检查
DEFINE l_sum      LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5
DEFINE r_success       LIKE type_t.num5

      LET r_success = TRUE
      #计算当前RMA单号+项次下是否还有可覆出數量
      #计算已覆出数量-------2016-2-24 marked by zhujing ----根据覆出类型来带出覆出数量
#      SELECT SUM(rmdb006) INTO l_sum
#        FROM rmdb_t LEFT OUTER JOIN rmda_t ON rmdadocno = rmdbdocno AND rmdaent = rmdbent AND rmdasite = rmdbsite
#       WHERE rmdb001 = p_rmdb001
#         AND rmdb002 = p_rmdb002
#         AND rmdbent = g_enterprise 
#         AND rmdbsite = g_site
#         AND (rmdbdocno <> g_rmda_m.rmdadocno OR rmdbseq <> g_rmdb_d[l_ac].rmdbseq)
#         AND rmdastus <> 'X'
# 
#      IF cl_null(l_sum) THEN
#         LET l_sum = 0
#      END IF
#      #计算可覆出总量
#      SELECT (COALESCE(rmab012,0)-COALESCE(rmab015,0)) INTO l_cnt
#         FROM rmab_t
#         WHERE rmabent = g_enterprise
#           AND rmabdocno = p_rmdb001
#           AND rmabseq = p_rmdb002
#           AND rmabsite = g_site
#      IF cl_null(l_cnt) THEN 
#         LET l_cnt = 0
#      END IF
#      #若可覆出品大于已覆出品，则新增-->更新：计算可覆出数量
#      IF l_cnt-l_sum < g_rmdb_d[l_ac].rmdb006 THEN 
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.code   = 'arm-00026' 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#         LET g_rmdb_d[l_ac].rmdb006 = 0
#         LET r_success = FALSE
#         RETURN r_success
#      END IF
      #计算已覆出数量-------2016-2-24 marked by zhujing ----根据覆出类型来带出覆出数量      
      #2016-2-24 add by zhujing----(S)
      IF cl_null(p_rmdb014) THEN LET p_rmdb014 = '1' END IF
      #已审核的armt300中的rmbc009='1'维修数量rmcb007-armt400中已出货的维修覆出数量rmdb006
      #已审核的armt300中的rmbc009='3'维修数量rmcb007-armt400中已出货的直接覆出数量rmdb006
      #计算已覆出数量
      SELECT SUM(rmdb006) INTO l_sum
        FROM rmdb_t LEFT OUTER JOIN rmda_t ON rmdadocno = rmdbdocno AND rmdaent = rmdbent AND rmdasite = rmdbsite
       WHERE rmdb001 = p_rmdb001
         AND rmdb002 = p_rmdb002
         AND rmdbent = g_enterprise 
         AND rmdbsite = g_site
         AND rmdb014 = p_rmdb014
         AND (rmdbdocno <> g_rmda_m.rmdadocno OR rmdbseq <> g_rmdb_d[l_ac].rmdbseq)
         AND rmdastus <> 'X'
       
      IF cl_null(l_sum) THEN
         LET l_sum = 0
      END IF
      #计算可覆出总量
      SELECT SUM(COALESCE(rmcb007,0)) INTO l_cnt
        FROM rmcb_t LEFT OUTER JOIN rmca_t ON rmcadocno = rmcbdocno AND rmcaent = rmcbent AND rmcasite = rmcbsite
       WHERE rmcbent = g_enterprise
         AND rmcb001 = p_rmdb001
         AND rmcb002 = p_rmdb002
         AND rmcb009 = p_rmdb014
         AND rmcbsite = g_site
         AND rmcastus = 'Y'
       GROUP BY rmcb001,rmcb002
       ORDER BY rmcb001,rmcb002
         
      IF cl_null(l_cnt) THEN 
         LET l_cnt = 0
      END IF
      
      #若可覆出品大于已覆出品，则新增-->更新：计算可覆出数量
      IF l_cnt-l_sum < g_rmdb_d[l_ac].rmdb006 THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code   = 'arm-00026' 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_rmdb_d[l_ac].rmdb006 = 0
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF p_type = '1' THEN
         LET g_rmdb_d[l_ac].rmdb006 = l_cnt - l_sum
      END IF
      #2016-2-24 add by zhujing----(E)
      RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 多库储批资料维护
# Memo...........:
# Usage..........: CALL armt400_call_armt400_01
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-11 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_call_armt400_01()
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_rollback LIKE type_t.num5 
   DEFINE l_rmdb007  LIKE rmdb_t.rmdb007
   DEFINE l_rmdb008  LIKE rmdb_t.rmdb008
   DEFINE l_rmdb009  LIKE rmdb_t.rmdb009
   DEFINE l_rmdb010  LIKE rmdb_t.rmdb010

   CALL s_transaction_begin()
   
   OPEN armt400_cl USING g_enterprise,g_rmda_m.rmdadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN armt400_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE armt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #開啟多庫儲批 p_rmdbdocno,p_rmdbseq,p_rmdb003,p_rmdb004,p_rmdb005,p_rmdb006,p_rmdbsite
   CALL armt400_01(g_rmda_m.rmdadocno,
                   g_rmdb_d[g_detail_idx].rmdbseq,g_rmdb_d[g_detail_idx].rmdb003,g_rmdb_d[g_detail_idx].rmdb004,
                   g_rmdb_d[g_detail_idx].rmdb005,g_rmdb_d[g_detail_idx].rmdb006,g_rmdb_d[g_detail_idx].rmdbsite,
                   g_rmdb_d[g_detail_idx].rmdb001,g_rmdb_d[g_detail_idx].rmdb002)     #160202-00019#5
                   RETURNING l_success,l_rollback,l_rmdb007,l_rmdb008,l_rmdb009,l_rmdb010
                   
   IF l_rollback OR NOT l_success THEN   
      CLOSE armt400_cl
      CALL s_transaction_end('N','0')
      RETURN
      
   ELSE

      IF NOT cl_null(l_rmdb007) THEN  #只有一筆         
         UPDATE rmdb_t
            SET rmdb012 = 'N',
                rmdb007 = l_rmdb007,
                rmdb008 = l_rmdb008,
                rmdb009 = l_rmdb009,
                rmdb010 = l_rmdb010
          WHERE rmdbent = g_enterprise
            AND rmdbdocno = g_rmda_m.rmdadocno
            AND rmdbseq = g_rmdb_d[g_detail_idx].rmdbseq                     
            
      ELSE
      
         UPDATE rmdb_t
            SET rmdb012 = 'Y',
                rmdb007 = ' ',
                rmdb008 = ' ',
                rmdb009 = ' ',
                rmdb010 = ' '
          WHERE rmdbent = g_enterprise
            AND rmdbdocno = g_rmda_m.rmdadocno
            AND rmdbseq = g_rmdb_d[g_detail_idx].rmdbseq   
      END IF
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
     
         CLOSE armt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF

   END IF
   
   CLOSE armt400_cl
   CALL s_transaction_end('Y','0')
   CALL armt400_show()
END FUNCTION

################################################################################
# Descriptions...: 单身action控制
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
PRIVATE FUNCTION armt400_detail_action_hidden(p_ac)
   DEFINE p_ac      LIKE type_t.num5

   DEFINE l_slip     LIKE ooba_t.ooba001
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_onebyone LIKE type_t.chr80
   DEFINE l_rmdb012  LIKE rmdb_t.rmdb012  #多庫儲批
   DEFINE l_rmdb007  LIKE rmdb_t.rmdb007  #庫位
   DEFINE l_rmdb008  LIKE rmdb_t.rmdb008  #單儲位
   DEFINE l_rmdb009  LIKE rmdb_t.rmdb009  #批號
   DEFINE l_rmdb010  LIKE rmdb_t.rmdb010  #庫存管理特徵

   CALL cl_set_act_visible("armt400_call_armt400_01",FALSE)  #多庫儲批
   IF g_rmda_m.rmdastus <> 'X' AND g_rmda_m.rmdastus <> 'S' THEN
   
      IF NOT cl_null(p_ac) AND p_ac > 0 THEN
         CALL cl_set_act_visible("armt400_call_armt400_01",TRUE)
         
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 扣帐日期维护
# Memo...........:
# Usage..........: CALL armt400_rmda001_upd()
#                  RETURNING 回传参数
################################################################################
PRIVATE FUNCTION armt400_rmda001_upd()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_rmdamoddt LIKE inba_t.inbamoddt
   DEFINE l_gzsz008   LIKE gzsz_t.gzsz008
   DEFINE l_forupd_sql STRING

   LET r_success = TRUE
   LET l_gzsz008 = ''
   
   IF g_rmda_m.rmdadocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   SELECT UNIQUE rmdadocno,rmdadocdt,rmda001,rmda003,rmda002,rmda004,rmdastus,rmda005,rmda006,rmda007,rmda008,rmdaownid,rmdaowndp,rmdacrtid,rmdacrtdp,rmdacrtdt,rmdamodid,rmdamoddt,rmdacnfid,rmdacnfdt,rmdapstid,rmdapstdt,
                 rmda009,rmda010,rmda011,rmda012,rmda013,rmda014,rmda015,rmda016,rmda017,rmda018,rmda019
     INTO g_rmda_m.rmdadocno,g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda003,g_rmda_m.rmda002,g_rmda_m.rmda004,g_rmda_m.rmdastus,g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmdaownid,
     g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtid,g_rmda_m.rmdacrtdp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdamodid,g_rmda_m.rmdamoddt,g_rmda_m.rmdacnfid,g_rmda_m.rmdacnfdt,g_rmda_m.rmdapstid,g_rmda_m.rmdapstdt,
     g_rmda_m.rmda009,g_rmda_m.rmda010,g_rmda_m.rmda011,g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016,g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019
     FROM rmda_t
    WHERE rmdaent = g_enterprise AND rmdasite = g_site AND rmdadocno = g_rmda_m.rmdadocno
   
   LET l_forupd_sql = " SELECT rmdadocno,rmdasite,rmdadocdt,rmda001,rmda002,rmda003,rmda004,rmdastus, ",
                      "  rmda005,rmda006,rmda007,rmda008,rmdaownid,rmdacrtdp,rmdaowndp,rmdacrtdt,rmdacrtid, ",
                      "  rmdamodid,rmdacnfdt,rmdamoddt,rmdapstid,rmdacnfid,rmdapstdt,rmda009,rmda010,rmda011, ",
                      "  rmda012,rmda013,rmda014,rmda015,rmda016,rmda017,rmda018,rmda019", 
                      " FROM rmda_t ",
                      " WHERE rmdaent= ? AND rmdadocno=? FOR UPDATE"

   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)                #轉換不同資料庫語法
   LET l_forupd_sql = cl_sql_add_mask(l_forupd_sql)              #遮蔽特定資料
   DECLARE armt400_rmda001_cl CURSOR FROM l_forupd_sql
   
   OPEN armt400_rmda001_cl USING g_enterprise,g_rmda_m.rmdadocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN armt400_rmda001_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE armt400_rmda001_cl
      LET r_success = FALSE
      RETURN r_success
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH armt400_rmda001_cl INTO g_rmda_m.rmdadocno,g_rmda_m.rmdasite,g_rmda_m.rmdadocdt,g_rmda_m.rmda001,g_rmda_m.rmda002,g_rmda_m.rmda003,g_rmda_m.rmda004,g_rmda_m.rmdastus, 
                                 g_rmda_m.rmda005,g_rmda_m.rmda006,g_rmda_m.rmda007,g_rmda_m.rmda008,g_rmda_m.rmdaownid,g_rmda_m.rmdacrtdp,g_rmda_m.rmdaowndp,g_rmda_m.rmdacrtdt,g_rmda_m.rmdacrtid, 
                                 g_rmda_m.rmdamodid,g_rmda_m.rmdacnfdt,g_rmda_m.rmdamoddt,g_rmda_m.rmdapstid,g_rmda_m.rmdacnfid,g_rmda_m.rmdapstdt,
                                 g_rmda_m.rmda009,g_rmda_m.rmda010,g_rmda_m.rmda011,g_rmda_m.rmda012,g_rmda_m.rmda013,g_rmda_m.rmda014,g_rmda_m.rmda015,g_rmda_m.rmda016,g_rmda_m.rmda017,g_rmda_m.rmda018,g_rmda_m.rmda019
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_rmda_m.rmdadocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE armt400_rmda001_cl
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL armt400_show()
   
   INPUT BY NAME g_rmda_m.rmda001 WITHOUT DEFAULTS
             
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            LET r_success = FALSE
            RETURN r_success
         END IF

      AFTER FIELD rmda001
         #維護的日期不可小於庫存關帳日
         LET l_gzsz008 = cl_get_para(g_enterprise,g_site,'S-MFG-0031') 
         IF g_rmda_m.rmda001 <= l_gzsz008 THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'sub-00306'
            LET g_errparam.extend = g_rmda_m.rmda001
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      #維護的日期不可大於現行年月，錯誤訊息「扣帳日期大於會計年度期別，請重新輸入]
      
   END INPUT
   
   IF INT_FLAG OR g_rmda_m.rmda001 IS NULL THEN
      LET INT_FLAG = 0
      CLOSE armt400_rmda001_cl
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET l_rmdamoddt = cl_get_current()

   UPDATE rmda_t SET rmda001 = g_rmda_m.rmda001,
                     rmdamodid = g_user,
                     rmdamoddt = l_rmdamoddt
     WHERE rmdaent = g_enterprise AND rmdasite = g_site AND rmdadocno = g_rmda_m.rmdadocno

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "g_rmda_m"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE armt400_rmda001_cl
      
      LET r_success = FALSE
      RETURN r_success 
   END IF

   CLOSE armt400_rmda001_cl
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 检查是否有可用库存量
################################################################################
PRIVATE FUNCTION armt400_rmdb007_chk(p_rmdb003,p_rmdb004,p_rmdb005,p_rmdb006,p_rmdb007,p_rmdb008,p_rmdb009,p_rmdb010)
DEFINE p_rmdb003     LIKE rmdb_t.rmdb003
DEFINE p_rmdb004     LIKE rmdb_t.rmdb004
DEFINE p_rmdb005     LIKE rmdb_t.rmdb005
DEFINE p_rmdb006     LIKE rmdb_t.rmdb006
DEFINE p_rmdb007     LIKE rmdb_t.rmdb007
DEFINE p_rmdb008     LIKE rmdb_t.rmdb008
DEFINE p_rmdb009     LIKE rmdb_t.rmdb009
DEFINE p_rmdb010     LIKE rmdb_t.rmdb010
DEFINE l_inag008     LIKE inag_t.inag008
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE

   IF cl_null(p_rmdb004) THEN LET p_rmdb004 = ' ' END IF
   IF cl_null(p_rmdb005) THEN LET p_rmdb005 = ' ' END IF
   IF cl_null(p_rmdb006) THEN LET p_rmdb006 = 0 END IF
   IF cl_null(p_rmdb007) THEN LET p_rmdb007 = ' ' END IF
   IF cl_null(p_rmdb008) THEN LET p_rmdb008 = ' ' END IF
   IF cl_null(p_rmdb009) THEN LET p_rmdb009 = ' ' END IF
   IF cl_null(p_rmdb010) THEN LET p_rmdb010 = ' ' END IF
   
   SELECT inag008 INTO l_inag008
     FROM inag_t
    WHERE inag001 = p_rmdb003
      AND inag002 = p_rmdb004
      AND inag003 = p_rmdb010
      AND inag004 = p_rmdb007
      AND inag005 = p_rmdb008
      AND inag006 = p_rmdb009
      AND inag007 = p_rmdb005
      AND inagent = g_enterprise
      AND inagsite = g_site
      AND inag008 > 0
   IF cl_null(l_inag008) OR l_inag008 < p_rmdb006 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00270'      #当前库存量不足！
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 获取未税、含税金额
# Memo...........:
# Usage..........: CALL armt400_get_money(p_rmbadocno,p_rmbbseq,p_rmdb013,p_rmdb015)
#                  RETURNING r_rmdb016,r_rmdb017
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016-2-25 BY zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_get_money(p_rmbadocno,p_rmbbseq,p_rmdb013,p_rmdb015)
DEFINE p_rmbadocno      LIKE rmba_t.rmbadocno   #RMA单号
DEFINE p_rmbbseq        LIKE rmbb_t.rmbbseq     #RMA项次
DEFINE p_rmdb013        LIKE rmdb_t.rmdb013     #计价数量
DEFINE p_rmdb015        LIKE rmdb_t.rmdb015     #单价
DEFINE r_rmdb016        LIKE rmdb_t.rmdb016     #未税金额
DEFINE r_rmdb017        LIKE rmdb_t.rmdb017     #含税金额
DEFINE l_tax            LIKE rmdb_t.rmdb017     #税额
DEFINE l_rmba006        LIKE rmba_t.rmba006     #税别
DEFINE l_rmba010        LIKE rmba_t.rmba010     #币别
DEFINE l_rmba011        LIKE rmba_t.rmba011     #汇率

   LET r_rmdb016 = 0
   LET r_rmdb017 = 0
   IF NOT cl_null(p_rmbadocno) OR NOT cl_null(p_rmbbseq) THEN 
      SELECT rmba006,rmba010,rmba011 INTO l_rmba006,l_rmba010,l_rmba011
        FROM rmba_t
       WHERE rmbadocno = p_rmbadocno
         AND rmbasite = g_site
         AND rmbaent = g_enterprise
       ORDER BY rmba000 DESC
       
      CALL s_axmt500_get_amount(p_rmbadocno,p_rmbbseq,p_rmdb013,p_rmdb015,l_rmba006,l_rmba010,l_rmba011)
         RETURNING r_rmdb016,r_rmdb017,l_tax
      IF cl_null(r_rmdb016) THEN LET r_rmdb016 = 0 END IF
      IF cl_null(r_rmdb017) THEN LET r_rmdb017 = 0 END IF
   END IF

RETURN r_rmdb016,r_rmdb017
END FUNCTION

################################################################################
# Descriptions...: 根据单头RMA单号自动产生单身数据
# Memo...........: 每个单身项次分成覆出类型为‘1’‘3’的两笔
# Usage..........: CALL armt400_auto_insert()
#                  RETURNING r_success
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016-2-25 BY zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_auto_insert()
DEFINE r_success     LIKE type_t.num5
DEFINE l_rmabdocno   LIKE rmab_t.rmabdocno
DEFINE l_rmabseq     LIKE rmab_t.rmabseq
DEFINE l_rmcb009     LIKE rmcb_t.rmcb009
DEFINE l_sql         STRING
DEFINE l_msg         STRING
DEFINE l_success     LIKE type_t.num5
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_no          LIKE type_t.num10 #2016-5-27 zhujing add
DEFINE l_rmac001     LIKE rmac_t.rmac001  ##160202-00019#8


   LET l_sql = " SELECT rmabseq ",
               " FROM rmab_t ",
               " WHERE rmabent = ",g_enterprise,
               "   AND rmabsite = '",g_site,"'",
               "   AND rmabdocno = ?",
               " ORDER BY rmabseq "
   PREPARE default_insert_rmdb_pre FROM l_sql
   DECLARE default_insert_rmdb_cur CURSOR FOR default_insert_rmdb_pre
   LET l_rmabdocno = g_rmda_m.rmda004
#   OPEN default_insert_rmdb_cur USING l_rmabdocno
   LET l_ac = 1
   LET l_no = 0 #2016-5-27 zhujing add
   CALL cl_err_collect_init()
   CALL cl_showmsg_init()
   
   LET r_success = TRUE
   LET l_success = TRUE
   
   FOREACH default_insert_rmdb_cur USING l_rmabdocno INTO l_rmabseq
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg('FOREACH','','',SQLCA.sqlcode,1)
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      #替換錯誤訊息
      CALL cl_getmsg_parm('axm-00218',g_dlang,l_rmabdocno ||'|'|| l_rmabseq) RETURNING l_msg   #單號：%1 項次：%2
      LET g_rmdb_d[l_ac].rmdbseq = l_ac
      LET g_rmdb_d[l_ac].rmdb001 = l_rmabdocno
      LET g_rmdb_d[l_ac].rmdb002 = l_rmabseq
      #判断覆出类型
      LET l_sql = " SELECT rmcb009 ",
                  "   FROM rmcb_t LEFT OUTER JOIN rmca_t ON rmcadocno = rmcbdocno AND rmcaent = rmcbent AND rmcasite = rmcbsite ",
                  "  WHERE rmcb001 = '",l_rmabdocno,"' ",
                  "    AND rmcb002 = ",l_rmabseq,
                  "    AND rmcb007 > 0",
                  "    AND rmcb009 <> '2' ",
                  "    AND rmcastus = 'Y' ",
                  "    AND rmcbent = ",g_enterprise,
                  "    AND rmcbsite ='",g_site,"' "
      PREPARE default_insert_type_pre FROM l_sql
      DECLARE default_insert_type_cur CURSOR FOR default_insert_type_pre
      FOREACH default_insert_type_cur INTO l_rmcb009
         IF SQLCA.sqlcode THEN
            CALL cl_errmsg('FOREACH','','',SQLCA.sqlcode,1)
            LET r_success = FALSE
            EXIT FOREACH
         END IF
#      IF armt400_rmdb_default_insert(l_rmabdocno,l_rmabseq,'1') THEN
         IF armt400_rmdb_default_insert(l_rmabdocno,l_rmabseq,l_rmcb009) THEN
            SELECT COUNT(*) INTO l_cnt
              FROM rmdb_t
             WHERE rmdbent =g_enterprise
               AND rmdbdocno = g_rmda_m.rmdadocno
               AND rmdbseq = g_rmdb_d[l_ac].rmdbseq
               AND rmdb001 = g_rmdb_d[l_ac].rmdb001
               AND rmdb002 = g_rmdb_d[l_ac].rmdb002
               AND rmdb014 = g_rmdb_d[l_ac].rmdb014
            IF l_cnt = 0 OR cl_null(l_cnt) THEN
               INSERT INTO rmdb_t
                        (rmdbent,
                         rmdbdocno,
                         rmdbseq,
                         rmdb001,rmdb002,rmdb003,rmdb004,rmdb005,rmdb014,rmdb006,rmdb013,rmdb015,rmdb016,rmdb017,rmdb012,rmdb007,rmdb008,rmdb009,rmdb010,rmdb011,rmdbsite) 
                  VALUES(g_enterprise,
                         g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,
                         g_rmdb_d[l_ac].rmdb001,g_rmdb_d[l_ac].rmdb002,g_rmdb_d[l_ac].rmdb003, 
                             g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb014, 
                             g_rmdb_d[l_ac].rmdb006,g_rmdb_d[l_ac].rmdb013,g_rmdb_d[l_ac].rmdb015, 
                             g_rmdb_d[l_ac].rmdb016,g_rmdb_d[l_ac].rmdb017,g_rmdb_d[l_ac].rmdb012, 
                             g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008,g_rmdb_d[l_ac].rmdb009, 
                             g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdb011,g_rmdb_d[l_ac].rmdbsite) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rmdb_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  LET r_success = FALSE 
                  RETURN r_success
               END IF
               INSERT INTO rmdc_t
                        (rmdcent,
                         rmdcdocno,
                         rmdcseq,rmdcseq1,
                         rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,rmdc006,rmdc007,rmdc008,rmdcsite) 
                  VALUES(g_enterprise,
                         g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,1,
                         g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005, 
                             g_rmdb_d[l_ac].rmdb006,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008, 
                             g_rmdb_d[l_ac].rmdb009,g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdbsite) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rmdc_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  LET r_success = FALSE 
                  RETURN r_success
               END IF
               LET l_no = l_no + 1  #2016-5-27 zhujing add
               #160202-00019#8---add---s
               #自动产生单身时，如果RMA点收数量之和与覆出数量相等，则覆出单的制造批序号直接根据RMA单的制造批序号产生
               LET l_rmac001 = 0
               SELECT SUM(rmac001) INTO l_rmac001
                 FROM rmac_t
                WHERE rmacent = g_enterprise
                  AND rmacdocno = g_rmdb_d[l_ac].rmdb001
                  AND rmacseq = g_rmdb_d[l_ac].rmdb002
               IF l_rmac001 = g_rmdb_d[l_ac].rmdb006 THEN                   
                  CALL s_axmt540_inao_copy(g_rmdb_d[l_ac].rmdb001,g_rmdb_d[l_ac].rmdb002,'2',g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008,g_rmdb_d[l_ac].rmdb009,g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,'1','1',g_rmdb_d[l_ac].rmdb012,'2') RETURNING l_success
                  
                  IF l_success THEN     
                     CALL s_axmt540_update_inao(g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,'1',g_rmdb_d[l_ac].rmdb001,g_rmdb_d[l_ac].rmdb002,'1','1') RETURNING l_success 
                  END IF  
               END IF               
               #160202-00019#8---add---s
            ELSE
               LET l_success = FALSE
               CALL g_rmdb_d.deleteElement(l_ac)
               CONTINUE FOREACH
            END IF
         ELSE
            LET l_success = FALSE 
            CALL g_rmdb_d.deleteElement(l_ac)
            CONTINUE FOREACH           
         END IF
         LET l_success = TRUE
         LET l_ac = l_ac + 1
      END FOREACH
#      LET l_ac = l_ac + 1
#      LET g_rmdb_d[l_ac].rmdbseq = l_ac
#      LET g_rmdb_d[l_ac].rmdb001 = l_rmabdocno
#      LET g_rmdb_d[l_ac].rmdb002 = l_rmabseq
#      IF armt400_rmdb_default_insert(l_rmabdocno,l_rmabseq,'3') THEN
#         INSERT INTO rmdb_t
#                  (rmdbent,
#                   rmdbdocno,
#                   rmdbseq,
#                   rmdb001,rmdb002,rmdb003,rmdb004,rmdb005,rmdb014,rmdb006,rmdb013,rmdb015,rmdb016,rmdb017,rmdb012,rmdb007,rmdb008,rmdb009,rmdb010,rmdb011,rmdbsite) 
#            VALUES(g_enterprise,
#                   g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,
#                   g_rmdb_d[l_ac].rmdb001,g_rmdb_d[l_ac].rmdb002,g_rmdb_d[l_ac].rmdb003, 
#                       g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb014, 
#                       g_rmdb_d[l_ac].rmdb006,g_rmdb_d[l_ac].rmdb013,g_rmdb_d[l_ac].rmdb015, 
#                       g_rmdb_d[l_ac].rmdb016,g_rmdb_d[l_ac].rmdb017,g_rmdb_d[l_ac].rmdb012, 
#                       g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008,g_rmdb_d[l_ac].rmdb009, 
#                       g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdb011,g_rmdb_d[l_ac].rmdbsite) 
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "rmdb_t" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = FALSE 
#            CALL cl_err()
#            LET r_success = FALSE 
#            RETURN r_success
#         END IF
#         INSERT INTO rmdc_t
#                  (rmdcent,
#                   rmdcdocno,
#                   rmdcseq,rmdcseq1
#                   ,rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,rmdc006,rmdc007,rmdc008,rmdcsite) 
#            VALUES(g_enterprise,
#                   g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,1,
#                   g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005, 
#                       g_rmdb_d[l_ac].rmdb006,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008, 
#                       g_rmdb_d[l_ac].rmdb009,g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdbsite) 
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "rmdc_t" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = FALSE 
#            CALL cl_err()
#            LET r_success = FALSE 
#            RETURN r_success
#         END IF
#      ELSE
#         LET r_success = FALSE 
#         RETURN r_success
#      END IF
#      LET l_ac = l_ac + 1
      
   END FOREACH
   CALL g_rmdb_d.deleteElement(l_ac)
   IF l_success = FALSE OR l_no = 0 THEN  #2016-5-27 zhujing mod
      LET r_success = FALSE
   END IF
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
   
   
   
RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 制造批序号维护
# Date & Author..: 2016/04/13 By xianghui
# Modify.........: 160202-00019#5
################################################################################
PRIVATE FUNCTION armt400_inao(p_type)
DEFINE p_type  LIKE type_t.chr1
DEFINE l_cnt   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(g_rmdb_d[l_ac].rmdb006) AND g_rmdb_d[l_ac].rmdb006 > 0 AND NOT cl_null(g_rmdb_d[l_ac].rmdb007) THEN       
      IF s_lot_batch_number_1n3(g_rmdb_d[l_ac].rmdb003,g_site) THEN
         IF p_type = '2' THEN 
            CALL s_lot_inao_chk(g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,'1','2',g_site) RETURNING l_success,l_cnt
            IF l_cnt > 0 THEN 
               IF l_success  THEN 
                  CALL s_axmt540_update_inao(g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,'1',g_rmdb_d[l_ac].rmdb001,g_rmdb_d[l_ac].rmdb002,'0','1') RETURNING l_success                  
                  #刪除資料                              
                  DELETE FROM inao_t 
                   WHERE inaoent = g_enterprise 
                     AND inaosite = g_site
                     AND inaodocno = g_rmda_m.rmdadocno
                     AND inaoseq = g_rmdb_d[l_ac].rmdbseq
                     AND inaoseq1 = '1'
                     AND inao000 = '2'
                     AND inao013 = '-1'  
               ELSE
                  LET r_success = FALSE
                  RETURN r_success                      
               END IF                 
            END IF         
         END IF   
         
         CALL s_axmt540_inao_copy(g_rmdb_d[l_ac].rmdb001,g_rmdb_d[l_ac].rmdb002,'2',g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008,g_rmdb_d[l_ac].rmdb009,g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,'1','1',g_rmdb_d[l_ac].rmdb012,'1') RETURNING l_success
         
         CALL s_lot_sel('2','2',g_site,g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,'1',g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb010,g_rmdb_d[l_ac].rmdb007,g_rmdb_d[l_ac].rmdb008,g_rmdb_d[l_ac].rmdb009,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb006,'-1','armt400','','','','','0')
                       RETURNING l_success
         IF l_success THEN     
            CALL s_axmt540_update_inao(g_rmda_m.rmdadocno,g_rmdb_d[l_ac].rmdbseq,'1',g_rmdb_d[l_ac].rmdb001,g_rmdb_d[l_ac].rmdb002,'1','1') RETURNING l_success 
         END IF  
         #刪除申請資料                              
         DELETE FROM inao_t 
          WHERE inaoent = g_enterprise 
            AND inaosite = g_site
            AND inaodocno = g_rmda_m.rmdadocno
            AND inaoseq = g_rmdb_d[l_ac].rmdbseq
            AND inaoseq1 = '1'
            AND inao000 = '1'
            AND inao013 = '-1'                                    
      END IF                  
   END IF
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 根据RMA单号项次带出料号信息
# Memo...........:
# Date & Author..: 2016-5-30 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_rmab_default(p_rmdb001,p_rmdb002)
   DEFINE p_rmdb001     LIKE rmdb_t.rmdb001
   DEFINE p_rmdb002     LIKE rmdb_t.rmdb002
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_sql_rmdb    STRING
   DEFINE l_sql_cnt     STRING
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_flag1       LIKE type_t.num5           #160816-00066#3 add
   DEFINE l_ooac002     LIKE ooac_t.ooac002        #160816-00066#3 add

   LET r_success = TRUE
   LET g_errno = ''

   LET g_rmdb_d[l_ac].rmdb004 = ''           
   LET g_rmdb_d[l_ac].rmdb005 = ''           
   LET g_rmdb_d[l_ac].rmdb006 = '' 
   LET g_rmdb_d[l_ac].rmdb015 = 0      
   LET l_sql_rmdb = " SELECT DISTINCT rmab009,rmab010,rmab011,0,rmbb003 ",
                    " FROM rmab_t LEFT OUTER JOIN rmbb_t ON rmabdocno = rmbbdocno AND rmabseq = rmbbseq AND rmabsite = rmbbsite AND rmabent = rmbbent ",
                    " AND rmbb000 = (SELECT MAX(rmbb000) FROM rmbb_t WHERE rmbbdocno =rmabdocno AND rmabseq = rmbbseq) ",
                    " WHERE rmabdocno = '",p_rmdb001,"' ",
                    "   AND rmabseq = ",p_rmdb002,
                    "   AND rmabent = ",g_enterprise,
                    "   AND rmabsite = '",g_site,"' ",
                    " ORDER BY rmab009,rmab010,rmab011 "
   LET l_sql_cnt = " SELECT COUNT(1) FROM (",l_sql_rmdb,")" 
   LET l_cnt = 0
   PREPARE armt400_rmdb_cnt_pre1 FROM l_sql_cnt
   EXECUTE armt400_rmdb_cnt_pre1 INTO l_cnt
   IF cl_null(l_cnt) OR l_cnt = 0 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_rmdb_d[l_ac].rmdb001,"+",g_rmdb_d[l_ac].rmdb002
      LET g_errparam.code   = 'arm-00019' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   PREPARE armt400_rmdb_default_pre1 FROM l_sql_rmdb
#   EXECUTE armt400_rmdb_default_pre INTO g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb006
   EXECUTE armt400_rmdb_default_pre1 INTO g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004,g_rmdb_d[l_ac].rmdb005,g_rmdb_d[l_ac].rmdb006,g_rmdb_d[l_ac].rmdb015
   #2016-2-23 zhujing mod ------(E)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET g_rmdb_d[l_ac].rmdbseq = l_ac
      LET g_rmdb_d[l_ac].rmdbsite = g_site
      LET g_rmdb_d[l_ac].rmdb001 = p_rmdb001
      LET g_rmdb_d[l_ac].rmdb002 = p_rmdb002
      LET g_rmdb_d[l_ac].rmdb012 = 'N'
      #160816-00066#3 add-S
      CALL s_aooi200_get_slip(g_rmda_m.rmdadocno) RETURNING l_flag1,l_ooac002    
      LET g_rmdb_d[l_ac].rmdb007 = cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0042')
      #160816-00066#3 add-E
      #获取料件品名规格
      CALL s_desc_get_item_desc(g_rmdb_d[l_ac].rmdb003)
         RETURNING g_rmdb_d[l_ac].rmdb003_desc,g_rmdb_d[l_ac].rmdb003_desc_1
      #获取产品特征说明
      CALL s_feature_description(g_rmdb_d[l_ac].rmdb003,g_rmdb_d[l_ac].rmdb004) 
         RETURNING l_success,g_rmdb_d[l_ac].rmdb004_desc
      
      LET g_rmdb_d_o.* = g_rmdb_d[l_ac].*
      
   RETURN r_success
END FUNCTION

 
{</section>}
 
