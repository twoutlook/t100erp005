#該程式未解開Section, 採用最新樣板產出!
{<section id="amht205.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-07-11 19:21:17), PR版次:0012(2016-10-14 16:09:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: amht205
#+ Description: 鋪位申請作業
#+ Creator....: 06815(2016-03-04 10:10:02)
#+ Modifier...: 06137 -SD/PR- 06814
 
{</section>}
 
{<section id="amht205.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#30  2016/04/08 by 07959   將重複內容的錯誤訊息置換為公用錯誤訊息
#160512-00003#18  2016/05/26 by 07959   1.单身场地的开窗和栏位检查，判断场地存在于当天的site+楼栋下面就好了，去掉楼层和区域的限制条件，因为一个铺位可能跨楼层或者跨区域
#                                       2.U修改的时候，开放管理品类、铺位用途、铺位等级、门牌号、铺位名称、助记码、可以修改
#                                       3.画面微调，门牌号和备注稍微拉大一点，助记码放第一列，管理品类和铺位用途放中间列
#160816-00068#8   2016/08/17 By 08209   調整transaction
#160513-00037#18                        铺位申请作业时，状态不可以修改
#160818-00017#20  2016/08/29 By 08742   删除修改未重新判断状态码
#160824-00007#83  2016/10/14 By 06814   新舊值備份
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
PRIVATE type type_g_mhbc_m        RECORD
       mhbcsite LIKE mhbc_t.mhbcsite, 
   mhbcsite_desc LIKE type_t.chr80, 
   mhbcdocdt LIKE mhbc_t.mhbcdocdt, 
   mhbcdocno LIKE mhbc_t.mhbcdocno, 
   mhbc000 LIKE mhbc_t.mhbc000, 
   mhbc016 LIKE mhbc_t.mhbc016, 
   mhbc001 LIKE mhbc_t.mhbc001, 
   mhbc002 LIKE mhbc_t.mhbc002, 
   mhbcl003 LIKE mhbcl_t.mhbcl003, 
   mhbcl004 LIKE mhbcl_t.mhbcl004, 
   mhbc003 LIKE mhbc_t.mhbc003, 
   mhbc003_desc LIKE type_t.chr80, 
   mhbc004 LIKE mhbc_t.mhbc004, 
   mhbc004_desc LIKE type_t.chr80, 
   mhbc005 LIKE mhbc_t.mhbc005, 
   mhbc005_desc LIKE type_t.chr80, 
   mhbc006 LIKE mhbc_t.mhbc006, 
   mhbc007 LIKE mhbc_t.mhbc007, 
   mhbc008 LIKE mhbc_t.mhbc008, 
   mhbc009 LIKE mhbc_t.mhbc009, 
   mhbc009_desc LIKE type_t.chr80, 
   mhbc010 LIKE mhbc_t.mhbc010, 
   mhbc010_desc LIKE type_t.chr80, 
   mhbc017 LIKE mhbc_t.mhbc017, 
   mhbc017_desc LIKE type_t.chr80, 
   mhbc011 LIKE mhbc_t.mhbc011, 
   mhbc012 LIKE mhbc_t.mhbc012, 
   mhbc013 LIKE mhbc_t.mhbc013, 
   mhbc013_desc LIKE type_t.chr80, 
   mhbc014 LIKE mhbc_t.mhbc014, 
   mhbc014_desc LIKE type_t.chr80, 
   mhbc015 LIKE mhbc_t.mhbc015, 
   mhbcunit LIKE mhbc_t.mhbcunit, 
   mhbcstus LIKE mhbc_t.mhbcstus, 
   mhbcownid LIKE mhbc_t.mhbcownid, 
   mhbcownid_desc LIKE type_t.chr80, 
   mhbcowndp LIKE mhbc_t.mhbcowndp, 
   mhbcowndp_desc LIKE type_t.chr80, 
   mhbccrtid LIKE mhbc_t.mhbccrtid, 
   mhbccrtid_desc LIKE type_t.chr80, 
   mhbccrtdp LIKE mhbc_t.mhbccrtdp, 
   mhbccrtdp_desc LIKE type_t.chr80, 
   mhbccrtdt LIKE mhbc_t.mhbccrtdt, 
   mhbcmodid LIKE mhbc_t.mhbcmodid, 
   mhbcmodid_desc LIKE type_t.chr80, 
   mhbcmoddt LIKE mhbc_t.mhbcmoddt, 
   mhbccnfid LIKE mhbc_t.mhbccnfid, 
   mhbccnfid_desc LIKE type_t.chr80, 
   mhbccnfdt LIKE mhbc_t.mhbccnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mhbd_d        RECORD
       mhbdacti LIKE mhbd_t.mhbdacti, 
   mhbd000 LIKE mhbd_t.mhbd000, 
   mhbd002 LIKE mhbd_t.mhbd002, 
   mhbd002_desc LIKE type_t.chr500, 
   mhbd003 LIKE mhbd_t.mhbd003, 
   mhbd004 LIKE mhbd_t.mhbd004, 
   mhbd004_desc LIKE type_t.chr500, 
   mhbd005 LIKE mhbd_t.mhbd005, 
   mhbd005_desc LIKE type_t.chr500, 
   mhbd006 LIKE mhbd_t.mhbd006, 
   mhbd006_desc LIKE type_t.chr500, 
   mhbd007 LIKE mhbd_t.mhbd007, 
   mhbd008 LIKE mhbd_t.mhbd008, 
   mhbd009 LIKE mhbd_t.mhbd009, 
   mhbdsite LIKE mhbd_t.mhbdsite, 
   mhbd001 LIKE mhbd_t.mhbd001, 
   mhbdunit LIKE mhbd_t.mhbdunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mhbcsite LIKE mhbc_t.mhbcsite,
   b_mhbcsite_desc LIKE type_t.chr80,
      b_mhbcdocno LIKE mhbc_t.mhbcdocno,
      b_mhbcdocdt LIKE mhbc_t.mhbcdocdt,
      b_mhbc000 LIKE mhbc_t.mhbc000,
      b_mhbc013 LIKE mhbc_t.mhbc013,
   b_mhbc013_desc LIKE type_t.chr80,
      b_mhbc014 LIKE mhbc_t.mhbc014,
   b_mhbc014_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_success        LIKE type_t.num5
DEFINE g_site_flag      LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mhbc_m          type_g_mhbc_m
DEFINE g_mhbc_m_t        type_g_mhbc_m
DEFINE g_mhbc_m_o        type_g_mhbc_m
DEFINE g_mhbc_m_mask_o   type_g_mhbc_m #轉換遮罩前資料
DEFINE g_mhbc_m_mask_n   type_g_mhbc_m #轉換遮罩後資料
 
   DEFINE g_mhbcdocno_t LIKE mhbc_t.mhbcdocno
 
 
DEFINE g_mhbd_d          DYNAMIC ARRAY OF type_g_mhbd_d
DEFINE g_mhbd_d_t        type_g_mhbd_d
DEFINE g_mhbd_d_o        type_g_mhbd_d
DEFINE g_mhbd_d_mask_o   DYNAMIC ARRAY OF type_g_mhbd_d #轉換遮罩前資料
DEFINE g_mhbd_d_mask_n   DYNAMIC ARRAY OF type_g_mhbd_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      mhbcldocno LIKE mhbcl_t.mhbcldocno,
      mhbcl001 LIKE mhbcl_t.mhbcl001,
      mhbcl003 LIKE mhbcl_t.mhbcl003,
      mhbcl004 LIKE mhbcl_t.mhbcl004
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
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
 
{<section id="amht205.main" >}
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
   CALL cl_ap_init("amh","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mhbcsite,'',mhbcdocdt,mhbcdocno,mhbc000,mhbc016,mhbc001,mhbc002,'','', 
       mhbc003,'',mhbc004,'',mhbc005,'',mhbc006,mhbc007,mhbc008,mhbc009,'',mhbc010,'',mhbc017,'',mhbc011, 
       mhbc012,mhbc013,'',mhbc014,'',mhbc015,mhbcunit,mhbcstus,mhbcownid,'',mhbcowndp,'',mhbccrtid,'', 
       mhbccrtdp,'',mhbccrtdt,mhbcmodid,'',mhbcmoddt,mhbccnfid,'',mhbccnfdt", 
                      " FROM mhbc_t",
                      " WHERE mhbcent= ? AND mhbcdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amht205_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mhbcsite,t0.mhbcdocdt,t0.mhbcdocno,t0.mhbc000,t0.mhbc016,t0.mhbc001, 
       t0.mhbc002,t0.mhbc003,t0.mhbc004,t0.mhbc005,t0.mhbc006,t0.mhbc007,t0.mhbc008,t0.mhbc009,t0.mhbc010, 
       t0.mhbc017,t0.mhbc011,t0.mhbc012,t0.mhbc013,t0.mhbc014,t0.mhbc015,t0.mhbcunit,t0.mhbcstus,t0.mhbcownid, 
       t0.mhbcowndp,t0.mhbccrtid,t0.mhbccrtdp,t0.mhbccrtdt,t0.mhbcmodid,t0.mhbcmoddt,t0.mhbccnfid,t0.mhbccnfdt, 
       t1.ooefl003 ,t2.mhaal003 ,t3.mhabl004 ,t4.mhacl005 ,t5.rtaxl003 ,t6.oocql004 ,t7.oocql004 ,t8.ooag011 , 
       t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 ,t12.ooag011 ,t13.ooefl003 ,t14.ooag011 ,t15.ooag011", 
 
               " FROM mhbc_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhbcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhaal_t t2 ON t2.mhaalent="||g_enterprise||" AND t2.mhaal001=t0.mhbc003 AND t2.mhaal002='"||g_dlang||"' ",
               " LEFT JOIN mhabl_t t3 ON t3.mhablent="||g_enterprise||" AND t3.mhabl001=t0.mhbc003 AND t3.mhabl002=t0.mhbc004 AND t3.mhabl003='"||g_dlang||"' ",
               " LEFT JOIN mhacl_t t4 ON t4.mhaclent="||g_enterprise||" AND t4.mhacl001=t0.mhbc003 AND t4.mhacl002=t0.mhbc004 AND t4.mhacl003=t0.mhbc005 AND t4.mhacl004='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t5 ON t5.rtaxlent="||g_enterprise||" AND t5.rtaxl001=t0.mhbc009 AND t5.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='2144' AND t6.oocql002=t0.mhbc010 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2145' AND t7.oocql002=t0.mhbc017 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mhbc013  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.mhbc014 AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.mhbcownid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.mhbcowndp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.mhbccrtid  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=t0.mhbccrtdp AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.mhbcmodid  ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.mhbccnfid  ",
 
               " WHERE t0.mhbcent = " ||g_enterprise|| " AND t0.mhbcdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amht205_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amht205 WITH FORM cl_ap_formpath("amh",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amht205_init()   
 
      #進入選單 Menu (="N")
      CALL amht205_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi390_drop_tmp_table()   
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amht205
      
   END IF 
   
   CLOSE amht205_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amht205.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amht205_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('mhbcstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('mhbc000','32') 
   CALL cl_set_combo_scc('mhbc012','6900') 
   CALL cl_set_combo_scc('mhbd000','6901') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL s_aooi390_cre_tmp_table() RETURNING l_success
   CALL cl_set_combo_scc('b_mhbc000','32')
   #160421-00013#4 160428 by sakura add(S)
   CALL s_asti800_set_comp_format("mhbc006",g_site,'2')
   CALL s_asti800_set_comp_format("mhbc007",g_site,'2')
   CALL s_asti800_set_comp_format("mhbc008",g_site,'2')
   CALL s_asti800_set_comp_format("mhbd007",g_site,'2')
   CALL s_asti800_set_comp_format("mhbd008",g_site,'2')
   CALL s_asti800_set_comp_format("mhbd009",g_site,'2')   
   #160421-00013#4 160428 by sakura add(E)   
   #end add-point
   
   #初始化搜尋條件
   CALL amht205_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amht205.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amht205_ui_dialog()
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
            CALL amht205_insert()
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
         INITIALIZE g_mhbc_m.* TO NULL
         CALL g_mhbd_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amht205_init()
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
               
               CALL amht205_fetch('') # reload data
               LET l_ac = 1
               CALL amht205_ui_detailshow() #Setting the current row 
         
               CALL amht205_idx_chk()
               #NEXT FIELD mhbd002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mhbd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amht205_idx_chk()
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
               CALL amht205_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL amht205_browser_fill("")
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
               CALL amht205_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amht205_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL amht205_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL amht205_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL amht205_set_act_visible()   
            CALL amht205_set_act_no_visible()
            IF NOT (g_mhbc_m.mhbcdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mhbcent = " ||g_enterprise|| " AND",
                                  " mhbcdocno = '", g_mhbc_m.mhbcdocno, "' "
 
               #填到對應位置
               CALL amht205_browser_fill("")
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
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mhbc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mhbd_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL amht205_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mhbc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mhbd_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL amht205_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL amht205_fetch("F")
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
               CALL amht205_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amht205_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht205_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amht205_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht205_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amht205_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht205_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amht205_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht205_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amht205_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amht205_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mhbd_d)
                  LET g_export_id[1]   = "s_detail1"
 
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
               NEXT FIELD mhbd002
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
               CALL amht205_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amht205_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amht205_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amht205_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amh/amht205_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amh/amht205_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL amht205_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amht205_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_mhbc013
            LET g_action_choice="prog_mhbc013"
            IF cl_auth_chk_act("prog_mhbc013") THEN
               
               #add-point:ON ACTION prog_mhbc013 name="menu.prog_mhbc013"
               #應用 a45 樣板自動產生(Version:3)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_mhbc_m.mhbc013)
 



               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amht205_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amht205_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amht205_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mhbc_m.mhbcdocdt)
 
 
 
         
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
 
{<section id="amht205.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amht205_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT mhbcdocno ",
                      " FROM mhbc_t ",
                      " ",
                      " LEFT JOIN mhbd_t ON mhbdent = mhbcent AND mhbcdocno = mhbddocno ", "  ",
                      #add-point:browser_fill段sql(mhbd_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN mhbcl_t ON mhbclent = "||g_enterprise||" AND mhbcdocno = mhbcldocno AND mhbc001 = mhbcl001 AND mhbcl002 = '",g_dlang,"' ", 
                      " ", 
 
 
                      " WHERE mhbcent = " ||g_enterprise|| " AND mhbdent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mhbc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mhbcdocno ",
                      " FROM mhbc_t ", 
                      "  ",
                      "  LEFT JOIN mhbcl_t ON mhbclent = "||g_enterprise||" AND mhbcdocno = mhbcldocno AND mhbc001 = mhbcl001 AND mhbcl002 = '",g_dlang,"' ",
                      " WHERE mhbcent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mhbc_t")
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
      INITIALIZE g_mhbc_m.* TO NULL
      CALL g_mhbd_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mhbcsite,t0.mhbcdocno,t0.mhbcdocdt,t0.mhbc000,t0.mhbc013,t0.mhbc014 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mhbcstus,t0.mhbcsite,t0.mhbcdocno,t0.mhbcdocdt,t0.mhbc000,t0.mhbc013, 
          t0.mhbc014,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM mhbc_t t0",
                  "  ",
                  "  LEFT JOIN mhbd_t ON mhbdent = mhbcent AND mhbcdocno = mhbddocno ", "  ", 
                  #add-point:browser_fill段sql(mhbd_t1) name="browser_fill.join.mhbd_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhbcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mhbc013  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mhbc014  ",
 
               " LEFT JOIN mhbcl_t ON mhbclent = "||g_enterprise||" AND mhbcdocno = mhbcldocno AND mhbc001 = mhbcl001 AND mhbcl002 = '",g_dlang,"' ",
                  " WHERE t0.mhbcent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mhbc_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mhbcstus,t0.mhbcsite,t0.mhbcdocno,t0.mhbcdocdt,t0.mhbc000,t0.mhbc013, 
          t0.mhbc014,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM mhbc_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhbcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mhbc013  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mhbc014  ",
 
               " LEFT JOIN mhbcl_t ON mhbclent = "||g_enterprise||" AND mhbcdocno = mhbcldocno AND mhbc001 = mhbcl001 AND mhbcl002 = '",g_dlang,"' ",
                  " WHERE t0.mhbcent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mhbc_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mhbcstus,t0.mhbcsite,t0.mhbcdocno,t0.mhbcdocdt,t0.mhbc000,t0.mhbc013, 
          t0.mhbc014,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM mhbc_t t0",
                  "  ",
                  "  LEFT JOIN mhbd_t ON mhbdent = mhbcent AND mhbcdocno = mhbddocno ", "  ", 
                  #add-point:browser_fill段sql(mhbd_t1) name="browser_fill.join.mhbd_t1"

                  #end add-point
 
 
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.mhbcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=t0.mhbc013  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.mhbc014  AND t3.ooefl002='"||g_dlang||"' ",
 
               " LEFT JOIN mhbcl_t ON mhbclent = '"||g_enterprise||"' AND mhbcdocno = mhbcldocno AND mhbc001 = mhbcl001 AND mhbcl002 = '",g_dlang,"' ",
                  " WHERE t0.mhbcent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mhbc_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mhbcstus,t0.mhbcsite,t0.mhbcdocno,t0.mhbcdocdt,t0.mhbc000,t0.mhbc013, 
          t0.mhbc014,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM mhbc_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.mhbcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=t0.mhbc013  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.mhbc014 AND t3.ooefl002='"||g_dlang||"' ",
 
               " LEFT JOIN mhbcl_t ON mhbclent = '"||g_enterprise||"' AND mhbcdocno = mhbcldocno AND mhbc001 = mhbcl001 AND mhbcl002 = '",g_dlang,"' ",
                  " WHERE t0.mhbcent = '" ||g_enterprise|| "' AND ",l_wc, cl_sql_add_filter("mhbc_t")
   END IF
   #end add-point
   LET g_sql = g_sql, " ORDER BY mhbcdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mhbc_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mhbcsite,g_browser[g_cnt].b_mhbcdocno, 
          g_browser[g_cnt].b_mhbcdocdt,g_browser[g_cnt].b_mhbc000,g_browser[g_cnt].b_mhbc013,g_browser[g_cnt].b_mhbc014, 
          g_browser[g_cnt].b_mhbcsite_desc,g_browser[g_cnt].b_mhbc013_desc,g_browser[g_cnt].b_mhbc014_desc 
 
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
         CALL amht205_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_mhbcdocno) THEN
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
 
{<section id="amht205.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amht205_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mhbc_m.mhbcdocno = g_browser[g_current_idx].b_mhbcdocno   
 
   EXECUTE amht205_master_referesh USING g_mhbc_m.mhbcdocno INTO g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt, 
       g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000,g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbc003, 
       g_mhbc_m.mhbc004,g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009, 
       g_mhbc_m.mhbc010,g_mhbc_m.mhbc017,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc014, 
       g_mhbc_m.mhbc015,g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcowndp,g_mhbc_m.mhbccrtid, 
       g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid, 
       g_mhbc_m.mhbccnfdt,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005_desc, 
       g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014_desc, 
       g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid_desc,g_mhbc_m.mhbccrtdp_desc, 
       g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbccnfid_desc
   
   CALL amht205_mhbc_t_mask()
   CALL amht205_show()
      
END FUNCTION
 
{</section>}
 
{<section id="amht205.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amht205_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="amht205.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amht205_ui_browser_refresh()
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
      IF g_browser[l_i].b_mhbcdocno = g_mhbc_m.mhbcdocno 
 
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
 
{<section id="amht205.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amht205_construct()
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
   INITIALIZE g_mhbc_m.* TO NULL
   CALL g_mhbd_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON mhbcsite,mhbcdocdt,mhbcdocno,mhbc000,mhbc016,mhbc001,mhbc002,mhbcl003, 
          mhbcl004,mhbc003,mhbc004,mhbc005,mhbc006,mhbc007,mhbc008,mhbc009,mhbc010,mhbc017,mhbc011,mhbc012, 
          mhbc013,mhbc014,mhbc015,mhbcstus,mhbcownid,mhbcowndp,mhbccrtid,mhbccrtdp,mhbccrtdt,mhbcmodid, 
          mhbcmoddt,mhbccnfid,mhbccnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mhbccrtdt>>----
         AFTER FIELD mhbccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mhbcmoddt>>----
         AFTER FIELD mhbcmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mhbccnfdt>>----
         AFTER FIELD mhbccnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mhbcpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mhbcsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcsite
            #add-point:ON ACTION controlp INFIELD mhbcsite name="construct.c.mhbcsite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhbcsite',g_site,'ｃ')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbcsite  #顯示到畫面上
            NEXT FIELD mhbcsite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcsite
            #add-point:BEFORE FIELD mhbcsite name="construct.b.mhbcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcsite
            
            #add-point:AFTER FIELD mhbcsite name="construct.a.mhbcsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcdocdt
            #add-point:BEFORE FIELD mhbcdocdt name="construct.b.mhbcdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcdocdt
            
            #add-point:AFTER FIELD mhbcdocdt name="construct.a.mhbcdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbcdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcdocdt
            #add-point:ON ACTION controlp INFIELD mhbcdocdt name="construct.c.mhbcdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcdocno
            #add-point:ON ACTION controlp INFIELD mhbcdocno name="construct.c.mhbcdocno"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhbcdocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbcdocno  #顯示到畫面上
            NEXT FIELD mhbcdocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcdocno
            #add-point:BEFORE FIELD mhbcdocno name="construct.b.mhbcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcdocno
            
            #add-point:AFTER FIELD mhbcdocno name="construct.a.mhbcdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc000
            #add-point:BEFORE FIELD mhbc000 name="construct.b.mhbc000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc000
            
            #add-point:AFTER FIELD mhbc000 name="construct.a.mhbc000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc000
            #add-point:ON ACTION controlp INFIELD mhbc000 name="construct.c.mhbc000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc016
            #add-point:BEFORE FIELD mhbc016 name="construct.b.mhbc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc016
            
            #add-point:AFTER FIELD mhbc016 name="construct.a.mhbc016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc016
            #add-point:ON ACTION controlp INFIELD mhbc016 name="construct.c.mhbc016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc001
            #add-point:ON ACTION controlp INFIELD mhbc001 name="construct.c.mhbc001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhbc001_1()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbc001     #顯示到畫面上
            NEXT FIELD mhbc001                        #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc001
            #add-point:BEFORE FIELD mhbc001 name="construct.b.mhbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc001
            
            #add-point:AFTER FIELD mhbc001 name="construct.a.mhbc001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc002
            #add-point:BEFORE FIELD mhbc002 name="construct.b.mhbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc002
            
            #add-point:AFTER FIELD mhbc002 name="construct.a.mhbc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc002
            #add-point:ON ACTION controlp INFIELD mhbc002 name="construct.c.mhbc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcl003
            #add-point:BEFORE FIELD mhbcl003 name="construct.b.mhbcl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcl003
            
            #add-point:AFTER FIELD mhbcl003 name="construct.a.mhbcl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbcl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcl003
            #add-point:ON ACTION controlp INFIELD mhbcl003 name="construct.c.mhbcl003"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcl004
            #add-point:BEFORE FIELD mhbcl004 name="construct.b.mhbcl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcl004
            
            #add-point:AFTER FIELD mhbcl004 name="construct.a.mhbcl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbcl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcl004
            #add-point:ON ACTION controlp INFIELD mhbcl004 name="construct.c.mhbcl004"
 
            #END add-point
 
 
         #Ctrlp:construct.c.mhbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc003
            #add-point:ON ACTION controlp INFIELD mhbc003 name="construct.c.mhbc003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbc003  #顯示到畫面上
            NEXT FIELD mhbc003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc003
            #add-point:BEFORE FIELD mhbc003 name="construct.b.mhbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc003
            
            #add-point:AFTER FIELD mhbc003 name="construct.a.mhbc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc004
            #add-point:ON ACTION controlp INFIELD mhbc004 name="construct.c.mhbc004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbc004  #顯示到畫面上
            NEXT FIELD mhbc004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc004
            #add-point:BEFORE FIELD mhbc004 name="construct.b.mhbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc004
            
            #add-point:AFTER FIELD mhbc004 name="construct.a.mhbc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc005
            #add-point:ON ACTION controlp INFIELD mhbc005 name="construct.c.mhbc005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhac003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbc005  #顯示到畫面上
            NEXT FIELD mhbc005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc005
            #add-point:BEFORE FIELD mhbc005 name="construct.b.mhbc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc005
            
            #add-point:AFTER FIELD mhbc005 name="construct.a.mhbc005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc006
            #add-point:BEFORE FIELD mhbc006 name="construct.b.mhbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc006
            
            #add-point:AFTER FIELD mhbc006 name="construct.a.mhbc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc006
            #add-point:ON ACTION controlp INFIELD mhbc006 name="construct.c.mhbc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc007
            #add-point:BEFORE FIELD mhbc007 name="construct.b.mhbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc007
            
            #add-point:AFTER FIELD mhbc007 name="construct.a.mhbc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc007
            #add-point:ON ACTION controlp INFIELD mhbc007 name="construct.c.mhbc007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc008
            #add-point:BEFORE FIELD mhbc008 name="construct.b.mhbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc008
            
            #add-point:AFTER FIELD mhbc008 name="construct.a.mhbc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc008
            #add-point:ON ACTION controlp INFIELD mhbc008 name="construct.c.mhbc008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbc009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc009
            #add-point:ON ACTION controlp INFIELD mhbc009 name="construct.c.mhbc009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbc009  #顯示到畫面上
            NEXT FIELD mhbc009                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc009
            #add-point:BEFORE FIELD mhbc009 name="construct.b.mhbc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc009
            
            #add-point:AFTER FIELD mhbc009 name="construct.a.mhbc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc010
            #add-point:ON ACTION controlp INFIELD mhbc010 name="construct.c.mhbc010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2144'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbc010  #顯示到畫面上
            NEXT FIELD mhbc010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc010
            #add-point:BEFORE FIELD mhbc010 name="construct.b.mhbc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc010
            
            #add-point:AFTER FIELD mhbc010 name="construct.a.mhbc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc017
            #add-point:ON ACTION controlp INFIELD mhbc017 name="construct.c.mhbc017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2145'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbc017  #顯示到畫面上
            NEXT FIELD mhbc017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc017
            #add-point:BEFORE FIELD mhbc017 name="construct.b.mhbc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc017
            
            #add-point:AFTER FIELD mhbc017 name="construct.a.mhbc017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc011
            #add-point:BEFORE FIELD mhbc011 name="construct.b.mhbc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc011
            
            #add-point:AFTER FIELD mhbc011 name="construct.a.mhbc011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc011
            #add-point:ON ACTION controlp INFIELD mhbc011 name="construct.c.mhbc011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc012
            #add-point:BEFORE FIELD mhbc012 name="construct.b.mhbc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc012
            
            #add-point:AFTER FIELD mhbc012 name="construct.a.mhbc012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc012
            #add-point:ON ACTION controlp INFIELD mhbc012 name="construct.c.mhbc012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbc013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc013
            #add-point:ON ACTION controlp INFIELD mhbc013 name="construct.c.mhbc013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbc013  #顯示到畫面上
            NEXT FIELD mhbc013                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc013
            #add-point:BEFORE FIELD mhbc013 name="construct.b.mhbc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc013
            
            #add-point:AFTER FIELD mhbc013 name="construct.a.mhbc013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc014
            #add-point:ON ACTION controlp INFIELD mhbc014 name="construct.c.mhbc014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbc014  #顯示到畫面上
            NEXT FIELD mhbc014                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc014
            #add-point:BEFORE FIELD mhbc014 name="construct.b.mhbc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc014
            
            #add-point:AFTER FIELD mhbc014 name="construct.a.mhbc014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc015
            #add-point:BEFORE FIELD mhbc015 name="construct.b.mhbc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc015
            
            #add-point:AFTER FIELD mhbc015 name="construct.a.mhbc015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc015
            #add-point:ON ACTION controlp INFIELD mhbc015 name="construct.c.mhbc015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcstus
            #add-point:BEFORE FIELD mhbcstus name="construct.b.mhbcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcstus
            
            #add-point:AFTER FIELD mhbcstus name="construct.a.mhbcstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcstus
            #add-point:ON ACTION controlp INFIELD mhbcstus name="construct.c.mhbcstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbcownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcownid
            #add-point:ON ACTION controlp INFIELD mhbcownid name="construct.c.mhbcownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbcownid  #顯示到畫面上
            NEXT FIELD mhbcownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcownid
            #add-point:BEFORE FIELD mhbcownid name="construct.b.mhbcownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcownid
            
            #add-point:AFTER FIELD mhbcownid name="construct.a.mhbcownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbcowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcowndp
            #add-point:ON ACTION controlp INFIELD mhbcowndp name="construct.c.mhbcowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbcowndp  #顯示到畫面上
            NEXT FIELD mhbcowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcowndp
            #add-point:BEFORE FIELD mhbcowndp name="construct.b.mhbcowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcowndp
            
            #add-point:AFTER FIELD mhbcowndp name="construct.a.mhbcowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbccrtid
            #add-point:ON ACTION controlp INFIELD mhbccrtid name="construct.c.mhbccrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbccrtid  #顯示到畫面上
            NEXT FIELD mhbccrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbccrtid
            #add-point:BEFORE FIELD mhbccrtid name="construct.b.mhbccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbccrtid
            
            #add-point:AFTER FIELD mhbccrtid name="construct.a.mhbccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhbccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbccrtdp
            #add-point:ON ACTION controlp INFIELD mhbccrtdp name="construct.c.mhbccrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbccrtdp  #顯示到畫面上
            NEXT FIELD mhbccrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbccrtdp
            #add-point:BEFORE FIELD mhbccrtdp name="construct.b.mhbccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbccrtdp
            
            #add-point:AFTER FIELD mhbccrtdp name="construct.a.mhbccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbccrtdt
            #add-point:BEFORE FIELD mhbccrtdt name="construct.b.mhbccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbcmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcmodid
            #add-point:ON ACTION controlp INFIELD mhbcmodid name="construct.c.mhbcmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbcmodid  #顯示到畫面上
            NEXT FIELD mhbcmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcmodid
            #add-point:BEFORE FIELD mhbcmodid name="construct.b.mhbcmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcmodid
            
            #add-point:AFTER FIELD mhbcmodid name="construct.a.mhbcmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcmoddt
            #add-point:BEFORE FIELD mhbcmoddt name="construct.b.mhbcmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mhbccnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbccnfid
            #add-point:ON ACTION controlp INFIELD mhbccnfid name="construct.c.mhbccnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbccnfid  #顯示到畫面上
            NEXT FIELD mhbccnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbccnfid
            #add-point:BEFORE FIELD mhbccnfid name="construct.b.mhbccnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbccnfid
            
            #add-point:AFTER FIELD mhbccnfid name="construct.a.mhbccnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbccnfdt
            #add-point:BEFORE FIELD mhbccnfdt name="construct.b.mhbccnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mhbdacti,mhbd000,mhbd002,mhbd003,mhbd004,mhbd005,mhbd006,mhbd007,mhbd008, 
          mhbd009,mhbdsite,mhbd001,mhbdunit
           FROM s_detail1[1].mhbdacti,s_detail1[1].mhbd000,s_detail1[1].mhbd002,s_detail1[1].mhbd003, 
               s_detail1[1].mhbd004,s_detail1[1].mhbd005,s_detail1[1].mhbd006,s_detail1[1].mhbd007,s_detail1[1].mhbd008, 
               s_detail1[1].mhbd009,s_detail1[1].mhbdsite,s_detail1[1].mhbd001,s_detail1[1].mhbdunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbdacti
            #add-point:BEFORE FIELD mhbdacti name="construct.b.page1.mhbdacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbdacti
            
            #add-point:AFTER FIELD mhbdacti name="construct.a.page1.mhbdacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbdacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbdacti
            #add-point:ON ACTION controlp INFIELD mhbdacti name="construct.c.page1.mhbdacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd000
            #add-point:BEFORE FIELD mhbd000 name="construct.b.page1.mhbd000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd000
            
            #add-point:AFTER FIELD mhbd000 name="construct.a.page1.mhbd000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbd000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd000
            #add-point:ON ACTION controlp INFIELD mhbd000 name="construct.c.page1.mhbd000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhbd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd002
            #add-point:ON ACTION controlp INFIELD mhbd002 name="construct.c.page1.mhbd002"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbd002  #顯示到畫面上
            NEXT FIELD mhbd002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd002
            #add-point:BEFORE FIELD mhbd002 name="construct.b.page1.mhbd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd002
            
            #add-point:AFTER FIELD mhbd002 name="construct.a.page1.mhbd002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd003
            #add-point:BEFORE FIELD mhbd003 name="construct.b.page1.mhbd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd003
            
            #add-point:AFTER FIELD mhbd003 name="construct.a.page1.mhbd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd003
            #add-point:ON ACTION controlp INFIELD mhbd003 name="construct.c.page1.mhbd003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhbd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd004
            #add-point:ON ACTION controlp INFIELD mhbd004 name="construct.c.page1.mhbd004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbd004  #顯示到畫面上
            NEXT FIELD mhbd004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd004
            #add-point:BEFORE FIELD mhbd004 name="construct.b.page1.mhbd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd004
            
            #add-point:AFTER FIELD mhbd004 name="construct.a.page1.mhbd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd005
            #add-point:ON ACTION controlp INFIELD mhbd005 name="construct.c.page1.mhbd005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbd005  #顯示到畫面上
            NEXT FIELD mhbd005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd005
            #add-point:BEFORE FIELD mhbd005 name="construct.b.page1.mhbd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd005
            
            #add-point:AFTER FIELD mhbd005 name="construct.a.page1.mhbd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd006
            #add-point:ON ACTION controlp INFIELD mhbd006 name="construct.c.page1.mhbd006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhac003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbd006  #顯示到畫面上
            NEXT FIELD mhbd006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd006
            #add-point:BEFORE FIELD mhbd006 name="construct.b.page1.mhbd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd006
            
            #add-point:AFTER FIELD mhbd006 name="construct.a.page1.mhbd006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd007
            #add-point:BEFORE FIELD mhbd007 name="construct.b.page1.mhbd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd007
            
            #add-point:AFTER FIELD mhbd007 name="construct.a.page1.mhbd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd007
            #add-point:ON ACTION controlp INFIELD mhbd007 name="construct.c.page1.mhbd007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd008
            #add-point:BEFORE FIELD mhbd008 name="construct.b.page1.mhbd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd008
            
            #add-point:AFTER FIELD mhbd008 name="construct.a.page1.mhbd008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd008
            #add-point:ON ACTION controlp INFIELD mhbd008 name="construct.c.page1.mhbd008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd009
            #add-point:BEFORE FIELD mhbd009 name="construct.b.page1.mhbd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd009
            
            #add-point:AFTER FIELD mhbd009 name="construct.a.page1.mhbd009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd009
            #add-point:ON ACTION controlp INFIELD mhbd009 name="construct.c.page1.mhbd009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbdsite
            #add-point:BEFORE FIELD mhbdsite name="construct.b.page1.mhbdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbdsite
            
            #add-point:AFTER FIELD mhbdsite name="construct.a.page1.mhbdsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbdsite
            #add-point:ON ACTION controlp INFIELD mhbdsite name="construct.c.page1.mhbdsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd001
            #add-point:BEFORE FIELD mhbd001 name="construct.b.page1.mhbd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd001
            
            #add-point:AFTER FIELD mhbd001 name="construct.a.page1.mhbd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd001
            #add-point:ON ACTION controlp INFIELD mhbd001 name="construct.c.page1.mhbd001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbdunit
            #add-point:BEFORE FIELD mhbdunit name="construct.b.page1.mhbdunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbdunit
            
            #add-point:AFTER FIELD mhbdunit name="construct.a.page1.mhbdunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbdunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbdunit
            #add-point:ON ACTION controlp INFIELD mhbdunit name="construct.c.page1.mhbdunit"
            
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
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "mhbc_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mhbd_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
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
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amht205_filter()
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
      CONSTRUCT g_wc_filter ON mhbcsite,mhbcdocno,mhbcdocdt,mhbc000,mhbc013,mhbc014
                          FROM s_browse[1].b_mhbcsite,s_browse[1].b_mhbcdocno,s_browse[1].b_mhbcdocdt, 
                              s_browse[1].b_mhbc000,s_browse[1].b_mhbc013,s_browse[1].b_mhbc014
 
         BEFORE CONSTRUCT
               DISPLAY amht205_filter_parser('mhbcsite') TO s_browse[1].b_mhbcsite
            DISPLAY amht205_filter_parser('mhbcdocno') TO s_browse[1].b_mhbcdocno
            DISPLAY amht205_filter_parser('mhbcdocdt') TO s_browse[1].b_mhbcdocdt
            DISPLAY amht205_filter_parser('mhbc000') TO s_browse[1].b_mhbc000
            DISPLAY amht205_filter_parser('mhbc013') TO s_browse[1].b_mhbc013
            DISPLAY amht205_filter_parser('mhbc014') TO s_browse[1].b_mhbc014
      
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
 
      CALL amht205_filter_show('mhbcsite')
   CALL amht205_filter_show('mhbcdocno')
   CALL amht205_filter_show('mhbcdocdt')
   CALL amht205_filter_show('mhbc000')
   CALL amht205_filter_show('mhbc013')
   CALL amht205_filter_show('mhbc014')
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amht205_filter_parser(ps_field)
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
 
{<section id="amht205.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amht205_filter_show(ps_field)
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
   LET ls_condition = amht205_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amht205_query()
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
   CALL g_mhbd_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL amht205_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amht205_browser_fill("")
      CALL amht205_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL amht205_filter_show('mhbcsite')
   CALL amht205_filter_show('mhbcdocno')
   CALL amht205_filter_show('mhbcdocdt')
   CALL amht205_filter_show('mhbc000')
   CALL amht205_filter_show('mhbc013')
   CALL amht205_filter_show('mhbc014')
   CALL amht205_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL amht205_fetch("F") 
      #顯示單身筆數
      CALL amht205_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amht205_fetch(p_flag)
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
   
   LET g_mhbc_m.mhbcdocno = g_browser[g_current_idx].b_mhbcdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amht205_master_referesh USING g_mhbc_m.mhbcdocno INTO g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt, 
       g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000,g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbc003, 
       g_mhbc_m.mhbc004,g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009, 
       g_mhbc_m.mhbc010,g_mhbc_m.mhbc017,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc014, 
       g_mhbc_m.mhbc015,g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcowndp,g_mhbc_m.mhbccrtid, 
       g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid, 
       g_mhbc_m.mhbccnfdt,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005_desc, 
       g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014_desc, 
       g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid_desc,g_mhbc_m.mhbccrtdp_desc, 
       g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbccnfid_desc
   
   #遮罩相關處理
   LET g_mhbc_m_mask_o.* =  g_mhbc_m.*
   CALL amht205_mhbc_t_mask()
   LET g_mhbc_m_mask_n.* =  g_mhbc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amht205_set_act_visible()   
   CALL amht205_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mhbc_m_t.* = g_mhbc_m.*
   LET g_mhbc_m_o.* = g_mhbc_m.*
   
   LET g_data_owner = g_mhbc_m.mhbcownid      
   LET g_data_dept  = g_mhbc_m.mhbcowndp
   
   #重新顯示   
   CALL amht205_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.insert" >}
#+ 資料新增
PRIVATE FUNCTION amht205_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_doctype  LIKE rtai_t.rtai004
   DEFINE l_insert   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mhbd_d.clear()   
 
 
   INITIALIZE g_mhbc_m.* TO NULL             #DEFAULT 設定
   
   LET g_mhbcdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mhbc_m.mhbcownid = g_user
      LET g_mhbc_m.mhbcowndp = g_dept
      LET g_mhbc_m.mhbccrtid = g_user
      LET g_mhbc_m.mhbccrtdp = g_dept 
      LET g_mhbc_m.mhbccrtdt = cl_get_current()
      LET g_mhbc_m.mhbcmodid = g_user
      LET g_mhbc_m.mhbcmoddt = cl_get_current()
      LET g_mhbc_m.mhbcstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mhbc_m.mhbc000 = "1"
      LET g_mhbc_m.mhbc006 = "0"
      LET g_mhbc_m.mhbc007 = "0"
      LET g_mhbc_m.mhbc008 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      #營運組織
      CALL s_aooi500_default(g_prog,'mhbcsite',g_mhbc_m.mhbcsite)
         RETURNING l_insert,g_mhbc_m.mhbcsite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_mhbc_m.mhbcsite) RETURNING g_mhbc_m.mhbcsite_desc
      DISPLAY BY NAME g_mhbc_m.mhbcsite_desc
      #應用組織
      LET g_mhbc_m.mhbcunit = g_mhbc_m.mhbcsite
      #單據日期
      LET g_mhbc_m.mhbcdocdt = g_today
      
      #單別
      CALL s_arti200_get_def_doc_type(g_mhbc_m.mhbcsite,g_prog,'1') RETURNING l_success,l_doctype         
      LET g_mhbc_m.mhbcdocno = l_doctype
      DISPLAY BY NAME g_mhbc_m.mhbcdocno
      
      ##業務人員
      LET g_mhbc_m.mhbc013 = g_user
      CALL s_desc_get_person_desc(g_mhbc_m.mhbc013) RETURNING g_mhbc_m.mhbc013_desc
      DISPLAY BY NAME g_mhbc_m.mhbc013_desc
      
      #部門
      LET g_mhbc_m.mhbc014 = g_dept
      CALL s_desc_get_department_desc(g_mhbc_m.mhbc014) RETURNING g_mhbc_m.mhbc014_desc
      DISPLAY BY NAME g_mhbc_m.mhbc014_desc
      
      #作業類型
      LET g_mhbc_m.mhbc000 = 'I'
      
      #鋪位狀態
      LET g_mhbc_m.mhbc012 = '1'
      #鋪位版本
      LET g_mhbc_m.mhbc002 = '1'     
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mhbc_m_t.* = g_mhbc_m.*
      LET g_mhbc_m_o.* = g_mhbc_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mhbc_m.mhbcstus 
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
 
 
 
    
      CALL amht205_input("a")
      
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
         INITIALIZE g_mhbc_m.* TO NULL
         INITIALIZE g_mhbd_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL amht205_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mhbd_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amht205_set_act_visible()   
   CALL amht205_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mhbcdocno_t = g_mhbc_m.mhbcdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mhbcent = " ||g_enterprise|| " AND",
                      " mhbcdocno = '", g_mhbc_m.mhbcdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amht205_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE amht205_cl
   
   CALL amht205_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amht205_master_referesh USING g_mhbc_m.mhbcdocno INTO g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt, 
       g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000,g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbc003, 
       g_mhbc_m.mhbc004,g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009, 
       g_mhbc_m.mhbc010,g_mhbc_m.mhbc017,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc014, 
       g_mhbc_m.mhbc015,g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcowndp,g_mhbc_m.mhbccrtid, 
       g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid, 
       g_mhbc_m.mhbccnfdt,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005_desc, 
       g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014_desc, 
       g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid_desc,g_mhbc_m.mhbccrtdp_desc, 
       g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbccnfid_desc
   
   
   #遮罩相關處理
   LET g_mhbc_m_mask_o.* =  g_mhbc_m.*
   CALL amht205_mhbc_t_mask()
   LET g_mhbc_m_mask_n.* =  g_mhbc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mhbc_m.mhbcsite,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbcdocdt,g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000, 
       g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004,g_mhbc_m.mhbc003, 
       g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005,g_mhbc_m.mhbc005_desc, 
       g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009,g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010, 
       g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012, 
       g_mhbc_m.mhbc013,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014,g_mhbc_m.mhbc014_desc,g_mhbc_m.mhbc015, 
       g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp, 
       g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid,g_mhbc_m.mhbccrtid_desc,g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdp_desc, 
       g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid, 
       g_mhbc_m.mhbccnfid_desc,g_mhbc_m.mhbccnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mhbc_m.mhbcownid      
   LET g_data_dept  = g_mhbc_m.mhbcowndp
   
   #功能已完成,通報訊息中心
   CALL amht205_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amht205.modify" >}
#+ 資料修改
PRIVATE FUNCTION amht205_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mhbc_m_t.* = g_mhbc_m.*
   LET g_mhbc_m_o.* = g_mhbc_m.*
   
   IF g_mhbc_m.mhbcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mhbcdocno_t = g_mhbc_m.mhbcdocno
 
   CALL s_transaction_begin()
   
   OPEN amht205_cl USING g_enterprise,g_mhbc_m.mhbcdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht205_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amht205_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amht205_master_referesh USING g_mhbc_m.mhbcdocno INTO g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt, 
       g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000,g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbc003, 
       g_mhbc_m.mhbc004,g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009, 
       g_mhbc_m.mhbc010,g_mhbc_m.mhbc017,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc014, 
       g_mhbc_m.mhbc015,g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcowndp,g_mhbc_m.mhbccrtid, 
       g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid, 
       g_mhbc_m.mhbccnfdt,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005_desc, 
       g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014_desc, 
       g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid_desc,g_mhbc_m.mhbccrtdp_desc, 
       g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbccnfid_desc
   
   #檢查是否允許此動作
   IF NOT amht205_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mhbc_m_mask_o.* =  g_mhbc_m.*
   CALL amht205_mhbc_t_mask()
   LET g_mhbc_m_mask_n.* =  g_mhbc_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL amht205_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_mhbcdocno_t = g_mhbc_m.mhbcdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mhbc_m.mhbcmodid = g_user 
LET g_mhbc_m.mhbcmoddt = cl_get_current()
LET g_mhbc_m.mhbcmodid_desc = cl_get_username(g_mhbc_m.mhbcmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL amht205_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mhbc_t SET (mhbcmodid,mhbcmoddt) = (g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmoddt)
          WHERE mhbcent = g_enterprise AND mhbcdocno = g_mhbcdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mhbc_m.* = g_mhbc_m_t.*
            CALL amht205_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mhbc_m.mhbcdocno != g_mhbc_m_t.mhbcdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mhbd_t SET mhbddocno = g_mhbc_m.mhbcdocno
 
          WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m_t.mhbcdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mhbd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhbd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amht205_set_act_visible()   
   CALL amht205_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mhbcent = " ||g_enterprise|| " AND",
                      " mhbcdocno = '", g_mhbc_m.mhbcdocno, "' "
 
   #填到對應位置
   CALL amht205_browser_fill("")
 
   CLOSE amht205_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amht205_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="amht205.input" >}
#+ 資料輸入
PRIVATE FUNCTION amht205_input(p_cmd)
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
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_cn                  LIKE type_t.num10 
   DEFINE  l_sys                 LIKE type_t.num5 
   DEFINE  l_sql                 STRING   
   DEFINE  l_mhad001             LIKE mhad_t.mhad001
   DEFINE  l_mhad002             LIKE mhad_t.mhad002
   DEFINE  l_mhad003             LIKE mhad_t.mhad003
   DEFINE  l_mhad004             LIKE mhad_t.mhad004
   DEFINE  l_mhad005             LIKE mhad_t.mhad005
   DEFINE  l_mhad006             LIKE mhad_t.mhad006
   DEFINE  l_mhad007             LIKE mhad_t.mhad007
   DEFINE  l_mhad009             LIKE mhad_t.mhad009
   DEFINE  l_mhadstus            LIKE mhad_t.mhadstus  #160604-00009#27 #add by geza 20160622 mhadstus
   DEFINE  l_where               STRING
   DEFINE l_oofg_return   DYNAMIC ARRAY OF RECORD
        oofg019       LIKE oofg_t.oofg019,  #field
        oofg020       LIKE oofg_t.oofg020   #value
                       END RECORD
   DEFINE l_stemstus  LIKE stem_t.stemstus  #add by geza 20160615                    
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
   DISPLAY BY NAME g_mhbc_m.mhbcsite,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbcdocdt,g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000, 
       g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004,g_mhbc_m.mhbc003, 
       g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005,g_mhbc_m.mhbc005_desc, 
       g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009,g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010, 
       g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012, 
       g_mhbc_m.mhbc013,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014,g_mhbc_m.mhbc014_desc,g_mhbc_m.mhbc015, 
       g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp, 
       g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid,g_mhbc_m.mhbccrtid_desc,g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdp_desc, 
       g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid, 
       g_mhbc_m.mhbccnfid_desc,g_mhbc_m.mhbccnfdt
   
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
   LET g_forupd_sql = "SELECT mhbdacti,mhbd000,mhbd002,mhbd003,mhbd004,mhbd005,mhbd006,mhbd007,mhbd008, 
       mhbd009,mhbdsite,mhbd001,mhbdunit FROM mhbd_t WHERE mhbdent=? AND mhbddocno=? AND mhbd002=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amht205_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amht205_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amht205_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt,g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000,g_mhbc_m.mhbc016, 
       g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004,g_mhbc_m.mhbc003,g_mhbc_m.mhbc004, 
       g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009,g_mhbc_m.mhbc010, 
       g_mhbc_m.mhbc017,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc014,g_mhbc_m.mhbc015, 
       g_mhbc_m.mhbcstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amht205.input.head" >}
      #單頭段
      INPUT BY NAME g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt,g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000,g_mhbc_m.mhbc016, 
          g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004,g_mhbc_m.mhbc003,g_mhbc_m.mhbc004, 
          g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009,g_mhbc_m.mhbc010, 
          g_mhbc_m.mhbc017,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc014,g_mhbc_m.mhbc015, 
          g_mhbc_m.mhbcstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_mhbc_m.mhbcdocno) AND NOT cl_null(g_mhbc_m.mhbc001) THEN
                  CALL n_mhbcl(g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mhbc_m.mhbcdocno
                  LET g_ref_fields[2] = g_mhbc_m.mhbc001
                  CALL ap_ref_array2(g_ref_fields," SELECT mhbcl003,mhbcl004 FROM mhbcl_t WHERE mhbclent = '" 
                      ||g_enterprise||"' AND mhbcldocno = ? AND mhbcl001 = ? AND mhbcl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mhbc_m.mhbcl003 = g_rtn_fields[1]
                  LET g_mhbc_m.mhbcl004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004 
               END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN amht205_cl USING g_enterprise,g_mhbc_m.mhbcdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amht205_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amht205_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.mhbcldocno = g_mhbc_m.mhbcdocno
LET g_master_multi_table_t.mhbcl001 = g_mhbc_m.mhbc001
LET g_master_multi_table_t.mhbcl003 = g_mhbc_m.mhbcl003
LET g_master_multi_table_t.mhbcl004 = g_mhbc_m.mhbcl004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.mhbcldocno = ''
LET g_master_multi_table_t.mhbcl001 = ''
LET g_master_multi_table_t.mhbcl003 = ''
LET g_master_multi_table_t.mhbcl004 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL amht205_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
        
            #end add-point
            CALL amht205_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcsite
            
            #add-point:AFTER FIELD mhbcsite name="input.a.mhbcsite"
            LET g_mhbc_m.mhbcsite_desc = ' '
            DISPLAY BY NAME g_mhbc_m.mhbcsite_desc
            IF cl_null(g_mhbc_m.mhbcsite) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'sub-00507'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            ELSE
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mhbc_m.mhbcsite != g_mhbc_m_t.mhbcsite OR g_mhbc_m_t.mhbcsite IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'mhbcsite',g_mhbc_m.mhbcsite,g_mhbc_m.mhbcsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_mhbc_m.mhbcsite = g_mhbc_m_t.mhbcsite
                     LET g_mhbc_m.mhbcunit = g_mhbc_m.mhbcsite   #160824-00007#83 20161014 add by beckxie
                     CALL s_desc_get_department_desc(g_mhbc_m.mhbcsite)
                        RETURNING g_mhbc_m.mhbcsite_desc
                     DISPLAY BY NAME g_mhbc_m.mhbcsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #LET g_site_flag = TRUE
            LET g_mhbc_m_t.mhbcsite = g_mhbc_m.mhbcsite
            CALL s_desc_get_department_desc(g_mhbc_m.mhbcsite)
               RETURNING g_mhbc_m.mhbcsite_desc
            DISPLAY BY NAME g_mhbc_m.mhbcsite_desc
            CALL amht205_set_entry(p_cmd)
            CALL amht205_set_no_entry(p_cmd)
            
            IF NOT cl_null(g_mhbc_m.mhbcsite) THEN
               CALL cl_set_comp_entry("mhbcsite",FALSE) 
            END IF   
            
            LET g_mhbc_m.mhbcunit = g_mhbc_m.mhbcsite
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcsite
            #add-point:BEFORE FIELD mhbcsite name="input.b.mhbcsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbcsite
            #add-point:ON CHANGE mhbcsite name="input.g.mhbcsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcdocdt
            #add-point:BEFORE FIELD mhbcdocdt name="input.b.mhbcdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcdocdt
            
            #add-point:AFTER FIELD mhbcdocdt name="input.a.mhbcdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbcdocdt
            #add-point:ON CHANGE mhbcdocdt name="input.g.mhbcdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcdocno
            #add-point:BEFORE FIELD mhbcdocno name="input.b.mhbcdocno"
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_mhbc_m.mhbcsite
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcdocno
            
            #add-point:AFTER FIELD mhbcdocno name="input.a.mhbcdocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_mhbc_m.mhbcdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mhbc_m.mhbcdocno != g_mhbcdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhbc_t WHERE "||"mhbcent = '" ||g_enterprise|| "' AND "||"mhbcdocno = '"||g_mhbc_m.mhbcdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT s_aooi200_chk_slip(g_mhbc_m.mhbcsite,'',g_mhbc_m.mhbcdocno,g_prog) THEN
                     LET g_mhbc_m.mhbcdocno = g_mhbc_m_t.mhbcdocno 
                     NEXT FIELD CURRENT   
                  END IF
               END IF
            END IF
            LET g_mhbc_m_t.mhbcdocno = g_mhbc_m.mhbcdocno 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbcdocno
            #add-point:ON CHANGE mhbcdocno name="input.g.mhbcdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc000
            #add-point:BEFORE FIELD mhbc000 name="input.b.mhbc000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc000
            
            #add-point:AFTER FIELD mhbc000 name="input.a.mhbc000"
            #add by geza  20160528 #160513-00037#18 (S)
            IF g_mhbc_m.mhbc000 = 'I' THEN 
               LET g_mhbc_m.mhbc012 = '1'
            END IF
            #add by geza  20160528 #160513-00037#18 (E)
            IF g_mhbc_m.mhbc000 = 'U' THEN 
              CALL amht205_mhbc001_ref(g_mhbc_m.mhbc001)
            END IF  

            CALL amht205_set_entry(p_cmd)
            CALL amht205_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc000
            #add-point:ON CHANGE mhbc000 name="input.g.mhbc000"
            #add by geza  20160528 #160513-00037#18 (S)
            LET g_mhbc_m.mhbc001 = ''
            #add by geza  20160528 #160513-00037#18 (E)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc016
            #add-point:BEFORE FIELD mhbc016 name="input.b.mhbc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc016
            
            #add-point:AFTER FIELD mhbc016 name="input.a.mhbc016"
            #add by geza 20160615(S)
            IF NOT cl_null(g_mhbc_m.mhbc016) THEN
                 IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mhbc_m.mhbc016 != g_mhbc_m_o.mhbc016 OR g_mhbc_m_o.mhbc016 IS NULL )) THEN
                    IF g_mhbc_m.mhbc000 = 'U'  THEN                      
                       #判断面积变革单号是否存在
                       LET l_sql = "SELECT stemstus FROM stem_t WHERE stement = ",g_enterprise," AND stemdocno = '",g_mhbc_m.mhbc016,"' AND stem000 = 'astt804' "                           
                       PREPARE astt801_chk_stie200 FROM l_sql 
                       EXECUTE astt801_chk_stie200 INTO l_stemstus
                       IF STATUS = 100 OR cl_null(l_stemstus) THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'ast-00662'
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                        
                          NEXT FIELD CURRENT
                       END IF
                       IF l_stemstus <> 'Y' THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'ast-00661'
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                        
                          NEXT FIELD CURRENT
                       END IF
                       #带出其他栏位
                       SELECT stem002 INTO g_mhbc_m.mhbc001
                         FROM stem_t
                        WHERE stement = g_enterprise
                          AND stemdocno = g_mhbc_m.mhbc016
                       CALL amht205_mhbc001_chk(g_mhbc_m.mhbc001) RETURNING l_success                      
                       IF NOT l_success THEN
                          LET g_mhbc_m.mhbc016 = g_mhbc_m_o.mhbc016
                          LET g_mhbc_m.mhbc001 = g_mhbc_m_o.mhbc001
                          CALL amht205_mhbc001_ref(g_mhbc_m.mhbc001)   
                          CALL amht205_mhbc003_ref()
                          CALL amht205_mhbc004_ref()
                          CALL amht205_mhbc005_ref()                       
                          NEXT FIELD CURRENT
                       END IF   
                       CALL amht205_mhbc001_ref(g_mhbc_m.mhbc001)
                    END IF  
                 END IF
            END IF
            LET g_mhbc_m_o.mhbc001 = g_mhbc_m.mhbc001                         
            LET g_mhbc_m_o.mhbc016 = g_mhbc_m.mhbc016
            #add by geza 20160615(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc016
            #add-point:ON CHANGE mhbc016 name="input.g.mhbc016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc001
            #add-point:BEFORE FIELD mhbc001 name="input.b.mhbc001"
            IF p_cmd = 'a' AND cl_null(g_mhbc_m.mhbc001) AND g_mhbc_m.mhbc000 = 'I' THEN    
               CALL s_aooi390_gen('35') RETURNING l_success,g_mhbc_m.mhbc001,l_oofg_return              
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc001
            
            #add-point:AFTER FIELD mhbc001 name="input.a.mhbc001"
            IF NOT cl_null(g_mhbc_m.mhbc001) THEN
                 IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mhbc_m.mhbc001 != g_mhbc_m_o.mhbc001 OR g_mhbc_m_o.mhbc001 IS NULL )) THEN
                    IF g_mhbc_m.mhbc000 = 'U'  THEN  
                      #add by geza 20160615  
                      IF g_mhbc_m.mhbc001 != g_mhbc_m_o.mhbc001 OR g_mhbc_m_o.mhbc001 IS NULL THEN                 
                         LET g_mhbc_m.mhbc016 = ''  
                      END IF   
                      #add by geza 20160615
                      CALL amht205_mhbc001_chk(g_mhbc_m.mhbc001) RETURNING l_success                      
                      IF NOT l_success THEN
                         LET g_mhbc_m.mhbc001 = g_mhbc_m_o.mhbc001
                         CALL amht205_mhbc001_ref(g_mhbc_m.mhbc001)   
                      #160604-00016#1 20160606 add by beckxie---S
                      CALL amht205_mhbc003_ref()
                      CALL amht205_mhbc004_ref()
                      CALL amht205_mhbc005_ref()
                      #160604-00016#1 20160606 add by beckxie---E                         
                         NEXT FIELD CURRENT
                      END IF
                      CALL amht205_mhbc001_ref(g_mhbc_m.mhbc001)
                      #160604-00016#1 20160606 add by beckxie---S
                      CALL amht205_mhbc003_ref()
                      CALL amht205_mhbc004_ref()
                      CALL amht205_mhbc005_ref()
                      #160604-00016#1 20160606 add by beckxie---E
                      CALL amht205_set_entry(p_cmd)
                      CALL amht205_set_no_entry(p_cmd)                   
                    ELSE
                      #校驗是否重複
                      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhbc_t WHERE "||"mhbcent = '" ||g_enterprise|| "' AND "||"mhbc001 = '"||g_mhbc_m.mhbc001||"'",'std-00004',0) THEN 
                         LET g_mhbc_m.mhbc001 = g_mhbc_m_o.mhbc001
                         NEXT FIELD CURRENT
                      END IF
                      #是否已存在主檔
                      SELECT COUNT(*) INTO l_cnt
                        FROM mhbe_t
                       WHERE mhbeent = g_enterprise
                         AND mhbe001 = g_mhbc_m.mhbc001
                      
                      IF l_cnt > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "amh-00653"
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = g_mhbc_m.mhbc001
                        CALL cl_err()
                        LET g_mhbc_m.mhbc001 = g_mhbc_m_o.mhbc001
                        NEXT FIELD CURRENT
                      END IF   
                      #aooi390自動編碼檢查
                      IF NOT s_aooi390_chk('35',g_mhbc_m.mhbc001) THEN
                         LET g_mhbc_m.mhbc001 = g_mhbc_m_o.mhbc001
                         NEXT FIELD CURRENT
                      END IF  
                    END IF  
                 END IF
            END IF
                                     
            LET g_mhbc_m_o.mhbc001 = g_mhbc_m.mhbc001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc001
            #add-point:ON CHANGE mhbc001 name="input.g.mhbc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc002
            #add-point:BEFORE FIELD mhbc002 name="input.b.mhbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc002
            
            #add-point:AFTER FIELD mhbc002 name="input.a.mhbc002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc002
            #add-point:ON CHANGE mhbc002 name="input.g.mhbc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcl003
            #add-point:BEFORE FIELD mhbcl003 name="input.b.mhbcl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcl003
            
            #add-point:AFTER FIELD mhbcl003 name="input.a.mhbcl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbcl003
            #add-point:ON CHANGE mhbcl003 name="input.g.mhbcl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcl004
            #add-point:BEFORE FIELD mhbcl004 name="input.b.mhbcl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcl004
            
            #add-point:AFTER FIELD mhbcl004 name="input.a.mhbcl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbcl004
            #add-point:ON CHANGE mhbcl004 name="input.g.mhbcl004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc003
            
            #add-point:AFTER FIELD mhbc003 name="input.a.mhbc003"
            LET g_mhbc_m.mhbc003_desc = ''
            DISPLAY BY NAME g_mhbc_m.mhbc003_desc
            IF NOT cl_null(g_mhbc_m.mhbc003) THEN 
               IF g_mhbc_m.mhbc003 != g_mhbc_m_o.mhbc003 OR cl_null(g_mhbc_m_o.mhbc003) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhbc_m.mhbc003
                  LET g_chkparam.arg2 = g_mhbc_m.mhbcsite
                  IF NOT cl_chk_exist("v_mhaa001") THEN
                     LET g_mhbc_m.mhbc003 = g_mhbc_m_o.mhbc003         
                     #160604-00016#1 20160606 mark by beckxie---S
                     #INITIALIZE g_ref_fields TO NULL
                     #LET g_ref_fields[1] = g_mhbc_m.mhbc003
                     #CALL ap_ref_array2(g_ref_fields,"SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                     #LET g_mhbc_m.mhbc003_desc = '', g_rtn_fields[1] , ''
                     #DISPLAY BY NAME g_mhbc_m.mhbc003_desc
                     #160604-00016#1 20160606 mark by beckxie---E
                     CALL amht205_mhbc003_ref()   #160604-00016#1 20160606 add by beckxie
                     NEXT FIELD CURRENT
                  END IF
                  LET g_mhbc_m.mhbc004 = ''
                  LET g_mhbc_m.mhbc004_desc = ''
                  LET g_mhbc_m.mhbc005 = ''
                  LET g_mhbc_m.mhbc005_desc = ''
                  DISPLAY BY NAME g_mhbc_m.mhbc004,g_mhbc_m.mhbc004_desc,
                                  g_mhbc_m.mhbc005,g_mhbc_m.mhbc005_desc
               END IF
            END IF
            #160604-00016#1 20160606 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mhbc_m.mhbc003
            #CALL ap_ref_array2(g_ref_fields,"SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mhbc_m.mhbc003_desc = '', g_rtn_fields[1] , ''        
            #DISPLAY BY NAME g_mhbc_m.mhbc003_desc
            #160604-00016#1 20160606 mark by beckxie---E
            CALL amht205_mhbc003_ref()   #160604-00016#1 20160606 add by beckxie
            LET g_mhbc_m_o.mhbc003 = g_mhbc_m.mhbc003
            LET g_mhbc_m_o.mhbc004 = g_mhbc_m.mhbc004
            LET g_mhbc_m_o.mhbc005 = g_mhbc_m.mhbc005                                  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc003
            #add-point:BEFORE FIELD mhbc003 name="input.b.mhbc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc003
            #add-point:ON CHANGE mhbc003 name="input.g.mhbc003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc004
            
            #add-point:AFTER FIELD mhbc004 name="input.a.mhbc004"
            LET g_mhbc_m.mhbc004_desc = ''
            DISPLAY BY NAME g_mhbc_m.mhbc004_desc
            IF NOT cl_null(g_mhbc_m.mhbc004) THEN 
               IF g_mhbc_m.mhbc004 != g_mhbc_m_o.mhbc004 OR cl_null(g_mhbc_m_o.mhbc004) THEN
                  #應用 a17 樣板自動產生(Version:3)
                  #先從樓棟編號開始維護
                  IF cl_null(g_mhbc_m.mhbc003) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'amh-00645'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_mhbc_m.mhbc004 = g_mhbc_m_o.mhbc004
                     NEXT FIELD mhbc003
                  END IF
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL              
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mhbc_m.mhbc004    
                  LET g_chkparam.arg2 = g_mhbc_m.mhbc003                           
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_mhab002") THEN
                     #檢查失敗時後續處理
                     LET g_mhbc_m.mhbc004 = g_mhbc_m_o.mhbc004
                     #160604-00016#1 20160606 mark by beckxie---S
                     #INITIALIZE g_ref_fields TO NULL
                     #LET g_ref_fields[1] = g_mhbc_m.mhbc003
                     #LET g_ref_fields[2] = g_mhbc_m.mhbc004
                     #CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
                     #LET g_mhbc_m.mhbc004_desc = '', g_rtn_fields[1] , ''
                     #DISPLAY BY NAME g_mhbc_m.mhbc004_desc
                     #160604-00016#1 20160606 mark by beckxie---E
                     CALL amht205_mhbc004_ref()   #160604-00016#1 20160606 add by beckxie
                     NEXT FIELD CURRENT
                  END IF
                  LET g_mhbc_m.mhbc005 = ''
                  LET g_mhbc_m.mhbc005_desc = ''
                  DISPLAY BY NAME g_mhbc_m.mhbc005,g_mhbc_m.mhbc005_desc
               END IF
            END IF 
            #160604-00016#1 20160606 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mhbc_m.mhbc003
            #LET g_ref_fields[2] = g_mhbc_m.mhbc004
            #CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mhbc_m.mhbc004_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mhbc_m.mhbc004_desc
            #160604-00016#1 20160606 mark by beckxie---E
            CALL amht205_mhbc004_ref()   #160604-00016#1 20160606 add by beckxie
            LET g_mhbc_m_o.mhbc004 = g_mhbc_m.mhbc004
            LET g_mhbc_m_o.mhbc005 = g_mhbc_m.mhbc005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc004
            #add-point:BEFORE FIELD mhbc004 name="input.b.mhbc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc004
            #add-point:ON CHANGE mhbc004 name="input.g.mhbc004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc005
            
            #add-point:AFTER FIELD mhbc005 name="input.a.mhbc005"
            LET g_mhbc_m.mhbc005_desc = ''
            DISPLAY BY NAME g_mhbc_m.mhbc005_desc
            IF NOT cl_null(g_mhbc_m.mhbc005) THEN
               IF g_mhbc_m.mhbc005 != g_mhbc_m_o.mhbc005 OR cl_null(g_mhbc_m_o.mhbc005) THEN             
                  #應用 a17 樣板自動產生(Version:3)
                  #先從樓棟編號開始維護
                  IF cl_null(g_mhbc_m.mhbc003) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'amh-00645'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_mhbc_m.mhbc005 = g_mhbc_m_o.mhbc005
                     NEXT FIELD mhbc003
                  END IF
                  #樓棟維護完樓層編號
                  IF cl_null(g_mhbc_m.mhbc004) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'amh-00646'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_mhbc_m.mhbc005 = g_mhbc_m_o.mhbc005
                     NEXT FIELD mhbc004
                  END IF                 
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mhbc_m.mhbc005 
                  LET g_chkparam.arg2 = g_mhbc_m.mhbc003
                  LET g_chkparam.arg3 = g_mhbc_m.mhbc004               
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_mhac003") THEN
                     LET g_mhbc_m.mhbc005 = g_mhbc_m_o.mhbc005
                     #160604-00016#1 20160606 mark by beckxie---S
                     #INITIALIZE g_ref_fields TO NULL
                     #LET g_ref_fields[1] = g_mhbc_m.mhbc003
                     #LET g_ref_fields[2] = g_mhbc_m.mhbc004
                     #LET g_ref_fields[3] = g_mhbc_m.mhbc005
                     #CALL ap_ref_array2(g_ref_fields,"SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND mhacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'","") RETURNING g_rtn_fields
                     #LET g_mhbc_m.mhbc005_desc = '', g_rtn_fields[1] , ''
                     #DISPLAY BY NAME g_mhbc_m.mhbc005_desc
                     #160604-00016#1 20160606 mark by beckxie---E
                     CALL amht205_mhbc005_ref()   #160604-00016#1 20160606 add by beckxie
                     NEXT FIELD CURRENT
                  END IF                        
               END IF
            END IF 
            
            LET g_mhbc_m_o.mhbc005 = g_mhbc_m.mhbc005
            #160604-00016#1 20160606 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mhbc_m.mhbc003
            #LET g_ref_fields[2] = g_mhbc_m.mhbc004
            #LET g_ref_fields[3] = g_mhbc_m.mhbc005
            #CALL ap_ref_array2(g_ref_fields,"SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND mhacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mhbc_m.mhbc005_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mhbc_m.mhbc005_desc
            #160604-00016#1 20160606 mark by beckxie---E
            CALL amht205_mhbc005_ref()   #160604-00016#1 20160606 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc005
            #add-point:BEFORE FIELD mhbc005 name="input.b.mhbc005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc005
            #add-point:ON CHANGE mhbc005 name="input.g.mhbc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc006
            #add-point:BEFORE FIELD mhbc006 name="input.b.mhbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc006
            
            #add-point:AFTER FIELD mhbc006 name="input.a.mhbc006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc006
            #add-point:ON CHANGE mhbc006 name="input.g.mhbc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc007
            #add-point:BEFORE FIELD mhbc007 name="input.b.mhbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc007
            
            #add-point:AFTER FIELD mhbc007 name="input.a.mhbc007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc007
            #add-point:ON CHANGE mhbc007 name="input.g.mhbc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc008
            #add-point:BEFORE FIELD mhbc008 name="input.b.mhbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc008
            
            #add-point:AFTER FIELD mhbc008 name="input.a.mhbc008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc008
            #add-point:ON CHANGE mhbc008 name="input.g.mhbc008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc009
            
            #add-point:AFTER FIELD mhbc009 name="input.a.mhbc009"
            LET g_mhbc_m.mhbc009_desc = ''
            DISPLAY BY NAME g_mhbc_m.mhbc009_desc
            IF NOT cl_null(g_mhbc_m.mhbc009) THEN         
               IF g_mhbc_m.mhbc009 != g_mhbc_m_o.mhbc009 OR cl_null(g_mhbc_m_o.mhbc009) THEN  
                  CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhbc_m.mhbc009
                  LET g_chkparam.arg2 = l_sys
                  IF NOT cl_chk_exist("v_rtax001_2") THEN
                     LET g_mhbc_m.mhbc009 = g_mhbc_m_o.mhbc009
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_mhbc_m.mhbc009
                     CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_mhbc_m.mhbc009_desc = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_mhbc_m.mhbc009_desc  
                     NEXT FIELD CURRENT
                  END IF 
               END IF  
            END IF      
            
            LET g_mhbc_m_o.mhbc009 = g_mhbc_m.mhbc009
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbc_m.mhbc009
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbc_m.mhbc009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbc_m.mhbc009_desc      
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc009
            #add-point:BEFORE FIELD mhbc009 name="input.b.mhbc009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc009
            #add-point:ON CHANGE mhbc009 name="input.g.mhbc009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc010
            
            #add-point:AFTER FIELD mhbc010 name="input.a.mhbc010"
            IF NOT cl_null(g_mhbc_m.mhbc010) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mhbc_m.mhbc010 != g_mhbc_m_o.mhbc010 OR g_mhbc_m_o.mhbc010 IS NULL )) THEN
                  #應用 a17 樣板自動產生(Version:3)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  IF NOT s_azzi650_chk_exist('2144',g_mhbc_m.mhbc010) THEN
                     LET g_mhbc_m.mhbc010 = g_mhbc_m_t.mhbc010               
                     CALL s_desc_get_acc_desc('2144',g_mhbc_m.mhbc010)  RETURNING g_mhbc_m.mhbc010_desc                  
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF 
            CALL s_desc_get_acc_desc('2144',g_mhbc_m.mhbc010)  RETURNING g_mhbc_m.mhbc010_desc                  
            DISPLAY BY NAME g_mhbc_m.mhbc010_desc
            LET g_mhbc_m_t.mhbc010 = g_mhbc_m.mhbc010   

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc010
            #add-point:BEFORE FIELD mhbc010 name="input.b.mhbc010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc010
            #add-point:ON CHANGE mhbc010 name="input.g.mhbc010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc017
            
            #add-point:AFTER FIELD mhbc017 name="input.a.mhbc017"
            IF NOT cl_null(g_mhbc_m.mhbc017) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mhbc_m.mhbc017 != g_mhbc_m_o.mhbc017 OR g_mhbc_m_o.mhbc017 IS NULL )) THEN
                  #應用 a17 樣板自動產生(Version:3)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  IF NOT s_azzi650_chk_exist('2145',g_mhbc_m.mhbc017) THEN
                     LET g_mhbc_m.mhbc017 = g_mhbc_m_t.mhbc017               
                     CALL s_desc_get_acc_desc('2145',g_mhbc_m.mhbc017)  RETURNING g_mhbc_m.mhbc017_desc                  
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF 
            CALL s_desc_get_acc_desc('2145',g_mhbc_m.mhbc017)  RETURNING g_mhbc_m.mhbc017_desc                  
            DISPLAY BY NAME g_mhbc_m.mhbc017_desc
            LET g_mhbc_m_t.mhbc017 = g_mhbc_m.mhbc017              


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc017
            #add-point:BEFORE FIELD mhbc017 name="input.b.mhbc017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc017
            #add-point:ON CHANGE mhbc017 name="input.g.mhbc017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc011
            #add-point:BEFORE FIELD mhbc011 name="input.b.mhbc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc011
            
            #add-point:AFTER FIELD mhbc011 name="input.a.mhbc011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc011
            #add-point:ON CHANGE mhbc011 name="input.g.mhbc011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc012
            #add-point:BEFORE FIELD mhbc012 name="input.b.mhbc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc012
            
            #add-point:AFTER FIELD mhbc012 name="input.a.mhbc012"
            


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc012
            #add-point:ON CHANGE mhbc012 name="input.g.mhbc012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc013
            
            #add-point:AFTER FIELD mhbc013 name="input.a.mhbc013"
            LET g_mhbc_m.mhbc013_desc = ''
            DISPLAY BY NAME g_mhbc_m.mhbc013_desc
            LET g_mhbc_m.mhbc013_desc = ''
            DISPLAY BY NAME g_mhbc_m.mhbc013_desc
            IF NOT cl_null(g_mhbc_m.mhbc013) THEN
               IF g_mhbc_m.mhbc013 != g_mhbc_m_o.mhbc013 OR cl_null(g_mhbc_m_o.mhbc013) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
                  LET g_chkparam.arg1 = g_mhbc_m.mhbc013
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#30  add
                  IF cl_chk_exist("v_ooag001") THEN
                     CALL amht205_mhbc013_def(g_mhbc_m.mhbc013) RETURNING g_mhbc_m.mhbc014
                     CALL s_desc_get_person_desc(g_mhbc_m.mhbc014) RETURNING g_mhbc_m.mhbc014_desc
                     DISPLAY BY NAME g_mhbc_m.mhbc014_desc   
                  ELSE
                     LET g_mhbc_m.mhbc013 = g_mhbc_m_o.mhbc013
                     CALL s_desc_get_person_desc(g_mhbc_m.mhbc013) RETURNING g_mhbc_m.mhbc013_desc
                     DISPLAY BY NAME g_mhbc_m.mhbc013_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_mhbc_m.mhbc013) RETURNING g_mhbc_m.mhbc013_desc
            DISPLAY BY NAME g_mhbc_m.mhbc013_desc
            LET g_mhbc_m_o.mhbc013 = g_mhbc_m.mhbc013
            LET g_mhbc_m_o.mhbc014 = g_mhbc_m.mhbc014
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc013
            #add-point:BEFORE FIELD mhbc013 name="input.b.mhbc013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc013
            #add-point:ON CHANGE mhbc013 name="input.g.mhbc013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc014
            
            #add-point:AFTER FIELD mhbc014 name="input.a.mhbc014"
            LET g_mhbc_m.mhbc014_desc = ''
            DISPLAY BY NAME g_mhbc_m.mhbc014_desc
            IF NOT cl_null(g_mhbc_m.mhbc014) THEN
               IF g_mhbc_m.mhbc014 != g_mhbc_m_o.mhbc014 OR cl_null(g_mhbc_m_o.mhbc014) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
                  LET g_chkparam.arg1 = g_mhbc_m.mhbc014
                  LET g_chkparam.arg2 = g_mhbc_m.mhbcdocdt
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補 #160318-00025#30  add
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_mhbc_m.mhbc014 = g_mhbc_m_t.mhbc014
                     CALL s_desc_get_department_desc(g_mhbc_m.mhbc014) RETURNING g_mhbc_m.mhbc014_desc
                     DISPLAY BY NAME g_mhbc_m.mhbc014_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_mhbc_m.mhbc014) RETURNING g_mhbc_m.mhbc014_desc
            DISPLAY BY NAME g_mhbc_m.mhbc014_desc
            LET g_mhbc_m_o.mhbc014 = g_mhbc_m.mhbc014


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc014
            #add-point:BEFORE FIELD mhbc014 name="input.b.mhbc014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc014
            #add-point:ON CHANGE mhbc014 name="input.g.mhbc014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbc015
            #add-point:BEFORE FIELD mhbc015 name="input.b.mhbc015"
             
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbc015
            
            #add-point:AFTER FIELD mhbc015 name="input.a.mhbc015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbc015
            #add-point:ON CHANGE mhbc015 name="input.g.mhbc015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbcstus
            #add-point:BEFORE FIELD mhbcstus name="input.b.mhbcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbcstus
            
            #add-point:AFTER FIELD mhbcstus name="input.a.mhbcstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbcstus
            #add-point:ON CHANGE mhbcstus name="input.g.mhbcstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mhbcsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcsite
            #add-point:ON ACTION controlp INFIELD mhbcsite name="input.c.mhbcsite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_mhbc_m.mhbcsite             #給予default值
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhbcsite',g_site,'i') 
            #給予arg
            CALL q_ooef001_24()                                #呼叫開窗 
            LET g_mhbc_m.mhbcsite = g_qryparam.return1              
            DISPLAY g_mhbc_m.mhbcsite TO mhbcsite              #

            CALL s_desc_get_department_desc(g_mhbc_m.mhbcsite)
               RETURNING g_mhbc_m.mhbcsite_desc
            DISPLAY BY NAME g_mhbc_m.mhbcsite_desc
            NEXT FIELD mhbcsite

            #END add-point
 
 
         #Ctrlp:input.c.mhbcdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcdocdt
            #add-point:ON ACTION controlp INFIELD mhbcdocdt name="input.c.mhbcdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcdocno
            #add-point:ON ACTION controlp INFIELD mhbcdocno name="input.c.mhbcdocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhbc_m.mhbcdocno
            
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()
            LET g_mhbc_m.mhbcdocno = g_qryparam.return1 
            DISPLAY g_mhbc_m.mhbcdocno TO mhbcdocno
            NEXT FIELD mhbcdocno
            #END add-point
 
 
         #Ctrlp:input.c.mhbc000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc000
            #add-point:ON ACTION controlp INFIELD mhbc000 name="input.c.mhbc000"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc016
            #add-point:ON ACTION controlp INFIELD mhbc016 name="input.c.mhbc016"
            #add by geza 20160615(S)
            IF g_mhbc_m.mhbc000 = 'U' THEN
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i' 
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.where = " stem000='astt804' AND stemstus = 'Y' "
              IF g_mhbc_m.mhbcsite IS NOT NULL THEN
                 LET g_qryparam.where = g_qryparam.where ," AND stemsite='",g_mhbc_m.mhbcsite,"'"
              END IF
              CALL q_stemdocno()                           #呼叫開窗
              LET g_mhbc_m.mhbc016 = g_qryparam.return1 
              DISPLAY g_qryparam.return1 TO mhbc016     #顯示到畫面上
              NEXT FIELD mhbc016                        #返回原欄位
            END IF
            #add by geza 20160615(E)
            #END add-point
 
 
         #Ctrlp:input.c.mhbc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc001
            #add-point:ON ACTION controlp INFIELD mhbc001 name="input.c.mhbc001"
            IF g_mhbc_m.mhbc000 = 'I' THEN
            
            END IF
            
            IF g_mhbc_m.mhbc000 = 'U' THEN
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i' 
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.where = " mhbestus = 'Y' ",
                                     " AND mhbesite = '",g_mhbc_m.mhbcsite,"'" #160604-00009#109 160627 by sakura add
              CALL q_mhbc001_1()                          #呼叫開窗
              LET g_mhbc_m.mhbc001 = g_qryparam.return1 
              DISPLAY g_qryparam.return1 TO mhbc001     #顯示到畫面上
              NEXT FIELD mhbc001                        #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.mhbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc002
            #add-point:ON ACTION controlp INFIELD mhbc002 name="input.c.mhbc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbcl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcl003
            #add-point:ON ACTION controlp INFIELD mhbcl003 name="input.c.mhbcl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbcl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcl004
            #add-point:ON ACTION controlp INFIELD mhbcl004 name="input.c.mhbcl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc003
            #add-point:ON ACTION controlp INFIELD mhbc003 name="input.c.mhbc003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbc_m.mhbc003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_mhaa001()                                #呼叫開窗
 
            LET g_mhbc_m.mhbc003 = g_qryparam.return1              

            DISPLAY g_mhbc_m.mhbc003 TO mhbc003              #

            NEXT FIELD mhbc003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc004
            #add-point:ON ACTION controlp INFIELD mhbc004 name="input.c.mhbc004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbc_m.mhbc004             #給予default值

            #給予arg
            IF NOT cl_null(g_mhbc_m.mhbc003) THEN
               LET g_qryparam.where = " mhab001 ='",g_mhbc_m.mhbc003,"'"
            END IF

 
            CALL q_mhab002()                                #呼叫開窗
 
            LET g_mhbc_m.mhbc004 = g_qryparam.return1              

            DISPLAY g_mhbc_m.mhbc004 TO mhbc004              #

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbc_m.mhbc003
            LET g_ref_fields[2] = g_mhbc_m.mhbc004
            CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbc_m.mhbc004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbc_m.mhbc004_desc       
 
            NEXT FIELD mhbc004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc005
            #add-point:ON ACTION controlp INFIELD mhbc005 name="input.c.mhbc005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            IF cl_null(g_mhbc_m.mhbc003) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amh-00645'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD mhbc003
            END IF
            
            IF cl_null(g_mhbc_m.mhbc004) THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'amh-00646'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              NEXT FIELD mhbc004
            END IF
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhbc_m.mhbc005             #給予default值
            LET g_qryparam.where = "     mhac001 = '",g_mhbc_m.mhbc003,"'",
                                   " AND mhac002 = '",g_mhbc_m.mhbc004,"'"
            CALL q_mhac003()                                #呼叫開窗
 
            LET g_mhbc_m.mhbc005 = g_qryparam.return1              

            DISPLAY g_mhbc_m.mhbc005 TO mhbc005              #

            NEXT FIELD mhbc005                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc006
            #add-point:ON ACTION controlp INFIELD mhbc006 name="input.c.mhbc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc007
            #add-point:ON ACTION controlp INFIELD mhbc007 name="input.c.mhbc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc008
            #add-point:ON ACTION controlp INFIELD mhbc008 name="input.c.mhbc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbc009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc009
            #add-point:ON ACTION controlp INFIELD mhbc009 name="input.c.mhbc009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbc_m.mhbc009             #給予default值

            #給予arg
            CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級
            LET g_qryparam.arg1 = l_sys #

 
            CALL q_rtax001_3()                                #呼叫開窗
 
            LET g_mhbc_m.mhbc009 = g_qryparam.return1              
            DISPLAY g_mhbc_m.mhbc009 TO mhbc009              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbc_m.mhbc009
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbc_m.mhbc009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbc_m.mhbc009_desc            
            NEXT FIELD mhbc009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbc010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc010
            #add-point:ON ACTION controlp INFIELD mhbc010 name="input.c.mhbc010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbc_m.mhbc010             #給予default值
            LET g_qryparam.default2 = "" #g_mhbc_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '2144'
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhbc_m.mhbc010 = g_qryparam.return1              
            #LET g_mhbc_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mhbc_m.mhbc010 TO mhbc010              #
            #DISPLAY g_mhbc_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mhbc010                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbc017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc017
            #add-point:ON ACTION controlp INFIELD mhbc017 name="input.c.mhbc017"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbc_m.mhbc017             #給予default值
            LET g_qryparam.default2 = "" #g_mhbc_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2145" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhbc_m.mhbc017 = g_qryparam.return1              
            #LET g_mhbc_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mhbc_m.mhbc017 TO mhbc017              #
            CALL s_desc_get_acc_desc('2145',g_mhbc_m.mhbc017) RETURNING g_mhbc_m.mhbc017_desc
            DISPLAY BY NAME g_mhbc_m.mhbc017_desc            
            #DISPLAY g_mhbc_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mhbc017                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc011
            #add-point:ON ACTION controlp INFIELD mhbc011 name="input.c.mhbc011"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc012
            #add-point:ON ACTION controlp INFIELD mhbc012 name="input.c.mhbc012"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbc013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc013
            #add-point:ON ACTION controlp INFIELD mhbc013 name="input.c.mhbc013"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbc_m.mhbc013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_mhbc_m.mhbc013 = g_qryparam.return1              

            DISPLAY g_mhbc_m.mhbc013 TO mhbc013              #

            NEXT FIELD mhbc013                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mhbc014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc014
            #add-point:ON ACTION controlp INFIELD mhbc014 name="input.c.mhbc014"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbc_m.mhbc014    #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_mhbc_m.mhbcdocdt                       
            CALL q_ooeg001()                               #呼叫開窗
 
            LET g_mhbc_m.mhbc014 = g_qryparam.return1                     
            DISPLAY g_mhbc_m.mhbc014 TO mhbc014        
            CALL s_desc_get_department_desc(g_mhbc_m.mhbc014)
              RETURNING g_mhbc_m.mhbc014_desc
            DISPLAY BY NAME g_mhbc_m.mhbc014_desc            
            NEXT FIELD mhbc014                             #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mhbc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbc015
            #add-point:ON ACTION controlp INFIELD mhbc015 name="input.c.mhbc015"
            
            #END add-point
 
 
         #Ctrlp:input.c.mhbcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbcstus
            #add-point:ON ACTION controlp INFIELD mhbcstus name="input.c.mhbcstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mhbc_m.mhbcdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #LET g_mhbc_m.mhbcunit = g_mhbc_m.mhbcsite
               CALL s_aooi200_gen_docno(g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocno,g_mhbc_m.mhbcdocdt,g_prog)
                  RETURNING l_success,g_mhbc_m.mhbcdocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_mhbc_m.mhbcdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mhbcdocno           
               END IF
               
               IF g_mhbc_m.mhbc000 = 'I' THEN
                  CALL s_aooi390_get_auto_no('35',g_mhbc_m.mhbc001) RETURNING l_success,g_mhbc_m.mhbc001
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               IF NOT cl_null(g_mhbc_m.mhbc001) AND g_mhbc_m.mhbc000 = 'U' THEN
                  LET l_sql = " SELECT mhbf002,mhbf003,mhbf004,mhbf005,mhbf006,mhbf007,mhbf008,mhbf009,mhbfstus ",
                              "   FROM mhbe_t,mhbf_t ",                                              
                              "  WHERE mhbeent = mhbfent AND mhbe001 = mhbf001 ",
                              "    AND mhbeent = ? AND mhbe001 = ?  "
                  PREPARE amht205_mhbf002 FROM l_sql
                  DECLARE b_fill_mhbf002 CURSOR FOR amht205_mhbf002
                  OPEN b_fill_mhbf002 USING g_enterprise,g_mhbc_m.mhbc001
                  LET l_ac = 1
      
                  FOREACH b_fill_mhbf002 INTO g_mhbd_d[l_ac].mhbd002,g_mhbd_d[l_ac].mhbd003, 
                                              g_mhbd_d[l_ac].mhbd004,g_mhbd_d[l_ac].mhbd005,g_mhbd_d[l_ac].mhbd006,
                                              g_mhbd_d[l_ac].mhbd007,g_mhbd_d[l_ac].mhbd008,g_mhbd_d[l_ac].mhbd009,g_mhbd_d[l_ac].mhbdacti
                  LET l_mhad009 = ''  
                  LET g_mhbd_d[l_ac].mhbd000 = '0'     
                  LET g_mhbd_d[l_ac].mhbd001 = g_mhbc_m.mhbc001
                  LET g_mhbd_d[l_ac].mhbdsite = g_mhbc_m.mhbcsite
                  LET g_mhbd_d[l_ac].mhbdunit = g_mhbc_m.mhbcsite
                  LET g_mhbc_m.mhbcunit = g_mhbc_m.mhbcsite
#                  #mark by geza 20160628(S)
#                  SELECT mhad009,mhad005,mhad006,mhad007,mhadstus INTO l_mhad009,l_mhad005,l_mhad006,l_mhad007,l_mhadstus  #160604-00009#27 #add by geza 20160622 mhadstus
#                    FROM mhad_t     
#                   WHERE mhadent = g_enterprise AND mhad001= g_mhbd_d[l_ac].mhbd004 AND mhad002 = g_mhbd_d[l_ac].mhbd005
#                     AND mhad003 = g_mhbd_d[l_ac].mhbd006 AND mhad004 = g_mhbd_d[l_ac].mhbd002              
#                                        
#                  IF l_mhad009 > g_mhbd_d[l_ac].mhbd003 THEN 
#                    LET g_mhbd_d[l_ac].mhbd000 = '2'            
#                    LET g_mhbd_d[l_ac].mhbd003 = l_mhad009
#                    LET g_mhbd_d[l_ac].mhbd007 = l_mhad005
#                    LET g_mhbd_d[l_ac].mhbd008 = l_mhad006
#                    LET g_mhbd_d[l_ac].mhbd009 = l_mhad007 
#                    #160604-00009#27 #add by geza 20160622(S)
#                    LET g_mhbd_d[l_ac].mhbdacti = l_mhadstus  
#                    IF l_mhadstus = 'N' THEN
#                       LET g_mhbd_d[l_ac].mhbd000 = '3'  
#                    END IF
#                    #160604-00009#27 #add by geza 20160622(E)
#                  END IF                                     
#                  #mark by geza 20160628(E)    
                  #add by geza 20160628(S)
                  #从场地主档带值
                  SELECT mhad001,mhad002,mhad003,mhad009,mhad005,mhad006,mhad007,mhadstus 
                    INTO g_mhbd_d[l_ac].mhbd004,g_mhbd_d[l_ac].mhbd005,
                         l_mhad003,l_mhad009,l_mhad005,
                         l_mhad006,l_mhad007,
                         g_mhbd_d[l_ac].mhbdacti  
                    FROM mhad_t     
                   WHERE mhadent = g_enterprise AND  mhad004 = g_mhbd_d[l_ac].mhbd002              
                  #根据版本/区域 或者 面积有没有变化判断类型                      
                  IF l_mhad009 > g_mhbd_d[l_ac].mhbd003 OR g_mhbd_d[l_ac].mhbd007 <> l_mhad005 OR g_mhbd_d[l_ac].mhbd008 <> l_mhad006 OR g_mhbd_d[l_ac].mhbd009 <> l_mhad007 OR g_mhbd_d[l_ac].mhbd006 <> l_mhad003 THEN 
                    LET g_mhbd_d[l_ac].mhbd000 = '2'            
                  END IF  
                  IF g_mhbd_d[l_ac].mhbdacti = 'N' THEN
                     LET g_mhbd_d[l_ac].mhbd000 = '3'  
                  END IF
                  LET g_mhbd_d[l_ac].mhbd003 = l_mhad009
                  LET g_mhbd_d[l_ac].mhbd007 = l_mhad005
                  LET g_mhbd_d[l_ac].mhbd008 = l_mhad006
                  LET g_mhbd_d[l_ac].mhbd009 = l_mhad007 
                  LET g_mhbd_d[l_ac].mhbd006 = l_mhad003                  
                  #add by geza 20160628(E) 
                  INSERT INTO mhbd_t (mhbdent,mhbdsite,mhbddocno,mhbd000,
                                      mhbd001,mhbd002, mhbd003,  mhbd004, 
                                      mhbd005,mhbd006, mhbd007,  mhbd008,
                                      mhbd009,mhbdacti)
                   VALUES (g_enterprise,           g_mhbc_m.mhbcsite,       g_mhbc_m.mhbcdocno,    g_mhbd_d[l_ac].mhbd000,
                           g_mhbc_m.mhbc001,       g_mhbd_d[l_ac].mhbd002,  g_mhbd_d[l_ac].mhbd003,g_mhbd_d[l_ac].mhbd004,
                           g_mhbd_d[l_ac].mhbd005, g_mhbd_d[l_ac].mhbd006,  g_mhbd_d[l_ac].mhbd007,g_mhbd_d[l_ac].mhbd008,
                           g_mhbd_d[l_ac].mhbd009, g_mhbd_d[l_ac].mhbdacti)                       
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "g_mhbd_d:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_ac = l_ac + 1
                  END FOREACH                 
               END IF           
               IF cl_null(g_mhbc_m.mhbc005) THEN
                  LET g_mhbc_m.mhbc005 = ' '
               END IF    
               
               CALL s_aooi390_oofi_upd('35',g_mhbc_m.mhbc001) RETURNING l_success  #add by 增加編碼功能
               
               #end add-point
               
               INSERT INTO mhbc_t (mhbcent,mhbcsite,mhbcdocdt,mhbcdocno,mhbc000,mhbc016,mhbc001,mhbc002, 
                   mhbc003,mhbc004,mhbc005,mhbc006,mhbc007,mhbc008,mhbc009,mhbc010,mhbc017,mhbc011,mhbc012, 
                   mhbc013,mhbc014,mhbc015,mhbcunit,mhbcstus,mhbcownid,mhbcowndp,mhbccrtid,mhbccrtdp, 
                   mhbccrtdt,mhbcmodid,mhbcmoddt,mhbccnfid,mhbccnfdt)
               VALUES (g_enterprise,g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt,g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000, 
                   g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbc003,g_mhbc_m.mhbc004, 
                   g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009, 
                   g_mhbc_m.mhbc010,g_mhbc_m.mhbc017,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013, 
                   g_mhbc_m.mhbc014,g_mhbc_m.mhbc015,g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid, 
                   g_mhbc_m.mhbcowndp,g_mhbc_m.mhbccrtid,g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid, 
                   g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid,g_mhbc_m.mhbccnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mhbc_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               #INSERT INTO mhbcl_t (mhbclent,mhbcldocno,mhbcl001,mhbcl002,mhbcl003,mhbcl004)
               #VALUES (g_enterprise,g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc001,g_lang,g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004)               
               #IF SQLCA.sqlcode THEN
               #   INITIALIZE g_errparam TO NULL 
               #   LET g_errparam.extend = "g_mhbc_m" 
               #   LET g_errparam.code   = SQLCA.sqlcode 
               #   LET g_errparam.popup  = TRUE 
               #   CALL cl_err()
               #   CALL s_transaction_end('N','0')
               #   NEXT FIELD CURRENT
               #END IF
               #add by geza 20160615 (S)
               UPDATE mhbc_t SET mhbc006 = (SELECT SUM(mhbd007) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3'),
                                 mhbc007 = (SELECT SUM(mhbd008) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3'),
                                 mhbc008 = (SELECT SUM(mhbd009) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3')
                WHERE mhbcent = g_enterprise
                  AND mhbcdocno = g_mhbc_m.mhbcdocno
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00034'
                  LET g_errparam.extend = g_mhbc_m.mhbcdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               DISPLAY BY NAME g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008
               #add by geza 2016015  (E)
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_mhbc_m.mhbcdocno = g_master_multi_table_t.mhbcldocno AND
         g_mhbc_m.mhbc001 = g_master_multi_table_t.mhbcl001 AND
         g_mhbc_m.mhbcl003 = g_master_multi_table_t.mhbcl003 AND 
         g_mhbc_m.mhbcl004 = g_master_multi_table_t.mhbcl004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhbclent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhbc_m.mhbcdocno
            LET l_field_keys[02] = 'mhbcldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mhbcldocno
            LET l_var_keys[03] = g_mhbc_m.mhbc001
            LET l_field_keys[03] = 'mhbcl001'
            LET l_var_keys_bak[03] = g_master_multi_table_t.mhbcl001
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'mhbcl002'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_mhbc_m.mhbcl003
            LET l_fields[01] = 'mhbcl003'
            LET l_vars[02] = g_mhbc_m.mhbcl004
            LET l_fields[02] = 'mhbcl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhbcl_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL amht205_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL amht205_b_fill()
                  CALL amht205_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               IF cl_null(g_mhbc_m.mhbc005) THEN
                  LET g_mhbc_m.mhbc005 = ' '
               END IF    
               #end add-point
               
               #將遮罩欄位還原
               CALL amht205_mhbc_t_mask_restore('restore_mask_o')
               
               UPDATE mhbc_t SET (mhbcsite,mhbcdocdt,mhbcdocno,mhbc000,mhbc016,mhbc001,mhbc002,mhbc003, 
                   mhbc004,mhbc005,mhbc006,mhbc007,mhbc008,mhbc009,mhbc010,mhbc017,mhbc011,mhbc012,mhbc013, 
                   mhbc014,mhbc015,mhbcunit,mhbcstus,mhbcownid,mhbcowndp,mhbccrtid,mhbccrtdp,mhbccrtdt, 
                   mhbcmodid,mhbcmoddt,mhbccnfid,mhbccnfdt) = (g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt, 
                   g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000,g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002, 
                   g_mhbc_m.mhbc003,g_mhbc_m.mhbc004,g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007, 
                   g_mhbc_m.mhbc008,g_mhbc_m.mhbc009,g_mhbc_m.mhbc010,g_mhbc_m.mhbc017,g_mhbc_m.mhbc011, 
                   g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc014,g_mhbc_m.mhbc015,g_mhbc_m.mhbcunit, 
                   g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcowndp,g_mhbc_m.mhbccrtid,g_mhbc_m.mhbccrtdp, 
                   g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid,g_mhbc_m.mhbccnfdt) 
 
                WHERE mhbcent = g_enterprise AND mhbcdocno = g_mhbcdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mhbc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               #UPDATE mhbcl_t SET (mhbclent,mhbcldocno,mhbcl001,mhbcl002,mhbcl003,mhbcl004)
               #= (g_enterprise,g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc001,g_lang,g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004) 
               # WHERE mhbclent = g_enterprise AND mhbcldocno = g_mhbcdocno_t
               # 
               # IF SQLCA.sqlcode THEN
               #   INITIALIZE g_errparam TO NULL 
               #   LET g_errparam.extend = "mhbcl_t" 
               #   LET g_errparam.code   = SQLCA.sqlcode 
               #   LET g_errparam.popup  = TRUE 
               #   CALL cl_err()
               #   CALL s_transaction_end('N','0')
               #   NEXT FIELD CURRENT
               #END IF
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_mhbc_m.mhbcdocno = g_master_multi_table_t.mhbcldocno AND
         g_mhbc_m.mhbc001 = g_master_multi_table_t.mhbcl001 AND
         g_mhbc_m.mhbcl003 = g_master_multi_table_t.mhbcl003 AND 
         g_mhbc_m.mhbcl004 = g_master_multi_table_t.mhbcl004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhbclent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhbc_m.mhbcdocno
            LET l_field_keys[02] = 'mhbcldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mhbcldocno
            LET l_var_keys[03] = g_mhbc_m.mhbc001
            LET l_field_keys[03] = 'mhbcl001'
            LET l_var_keys_bak[03] = g_master_multi_table_t.mhbcl001
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'mhbcl002'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_mhbc_m.mhbcl003
            LET l_fields[01] = 'mhbcl003'
            LET l_vars[02] = g_mhbc_m.mhbcl004
            LET l_fields[02] = 'mhbcl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhbcl_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL amht205_mhbc_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mhbc_m_t)
               LET g_log2 = util.JSON.stringify(g_mhbc_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mhbcdocno_t = g_mhbc_m.mhbcdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="amht205.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mhbd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mhbd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amht205_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mhbd_d.getLength()
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
            OPEN amht205_cl USING g_enterprise,g_mhbc_m.mhbcdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amht205_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amht205_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mhbd_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mhbd_d[l_ac].mhbd002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mhbd_d_t.* = g_mhbd_d[l_ac].*  #BACKUP
               LET g_mhbd_d_o.* = g_mhbd_d[l_ac].*  #BACKUP
               CALL amht205_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
 
               #end add-point  
               CALL amht205_set_no_entry_b(l_cmd)
               IF NOT amht205_lock_b("mhbd_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amht205_bcl INTO g_mhbd_d[l_ac].mhbdacti,g_mhbd_d[l_ac].mhbd000,g_mhbd_d[l_ac].mhbd002, 
                      g_mhbd_d[l_ac].mhbd003,g_mhbd_d[l_ac].mhbd004,g_mhbd_d[l_ac].mhbd005,g_mhbd_d[l_ac].mhbd006, 
                      g_mhbd_d[l_ac].mhbd007,g_mhbd_d[l_ac].mhbd008,g_mhbd_d[l_ac].mhbd009,g_mhbd_d[l_ac].mhbdsite, 
                      g_mhbd_d[l_ac].mhbd001,g_mhbd_d[l_ac].mhbdunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mhbd_d_t.mhbd002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mhbd_d_mask_o[l_ac].* =  g_mhbd_d[l_ac].*
                  CALL amht205_mhbd_t_mask()
                  LET g_mhbd_d_mask_n[l_ac].* =  g_mhbd_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amht205_show()
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
            INITIALIZE g_mhbd_d[l_ac].* TO NULL 
            INITIALIZE g_mhbd_d_t.* TO NULL 
            INITIALIZE g_mhbd_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_mhbd_d[l_ac].mhbdacti = "Y"
      LET g_mhbd_d[l_ac].mhbd003 = "1"
      LET g_mhbd_d[l_ac].mhbd007 = "0"
      LET g_mhbd_d[l_ac].mhbd008 = "0"
      LET g_mhbd_d[l_ac].mhbd009 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_mhbd_d[l_ac].mhbd003 = "1"
            LET g_mhbd_d[l_ac].mhbdacti = "Y"          
            #IF g_mhbc_m.mhbc000 = 'U' THEN
            LET g_mhbd_d[l_ac].mhbd000 = '1'             
            #END IF          
            #IF g_mhbc_m.mhbc000 = 'I' THEN
            #  LET g_mhbd_d[l_ac].mhbd000 = '1'             
            #END IF   
            LET g_mhbd_d[l_ac].mhbdunit = g_mhbc_m.mhbcsite
            LET g_mhbd_d[l_ac].mhbd001 = g_mhbc_m.mhbc001
            LET g_mhbd_d[l_ac].mhbdsite = g_mhbc_m.mhbcsite
            #end add-point
            LET g_mhbd_d_t.* = g_mhbd_d[l_ac].*     #新輸入資料
            LET g_mhbd_d_o.* = g_mhbd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amht205_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL amht205_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mhbd_d[li_reproduce_target].* = g_mhbd_d[li_reproduce].*
 
               LET g_mhbd_d[li_reproduce_target].mhbd002 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM mhbd_t 
             WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno
 
               AND mhbd002 = g_mhbd_d[l_ac].mhbd002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhbc_m.mhbcdocno
               LET gs_keys[2] = g_mhbd_d[g_detail_idx].mhbd002
               CALL amht205_insert_b('mhbd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mhbd_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhbd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amht205_b_fill()
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
               #160604-00009#118 160630 by lori ad---(S)
                IF g_mhbc_m.mhbc000 = 'U' AND g_mhbd_d[l_ac].mhbd000 <> '1' THEN
                  #已存在於鋪位主檔的場地，不可刪除！
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_mhbd_d[l_ac].mhbd002
                  LET g_errparam.code   = "amh-00671"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  CANCEL DELETE
               END IF
               #160604-00009#118 160630 by lori ad---(S)
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
               LET gs_keys[01] = g_mhbc_m.mhbcdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mhbd_d_t.mhbd002
 
            
               #刪除同層單身
               IF NOT amht205_delete_b('mhbd_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amht205_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amht205_key_delete_b(gs_keys,'mhbd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amht205_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE amht205_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mhbd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mhbd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbdacti
            #add-point:BEFORE FIELD mhbdacti name="input.b.page1.mhbdacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbdacti
            
            #add-point:AFTER FIELD mhbdacti name="input.a.page1.mhbdacti"
            IF g_mhbd_d[l_ac].mhbdacti ! = g_mhbd_d_o.mhbdacti OR cl_null(g_mhbd_d_o.mhbdacti) THEN
              
            END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbdacti
            #add-point:ON CHANGE mhbdacti name="input.g.page1.mhbdacti"
            IF g_mhbd_d[l_ac].mhbdacti = 'N' THEN 
              LET g_mhbd_d[l_ac].mhbd000 = '3'
            END IF  
            
            IF g_mhbd_d[l_ac].mhbdacti = 'Y' THEN 
              
               LET l_cn = 0
               SELECT COUNT(mhbf002) INTO l_cn
                 FROM mhbf_t
                WHERE mhbfent = g_enterprise
                  AND mhbf001 = g_mhbc_m.mhbc001
                  AND mhbf002 = g_mhbd_d[l_ac].mhbd002                           
               IF l_cn = 0 THEN
                 #查询铺位主档资料，如果不存在则 类型=1.新增                 
                 LET g_mhbd_d[l_ac].mhbd000 = '1'
               ELSE
                 #版本与场地基本资料相同  则  类型=0.原资料  否则 2.修改 
                 LET l_cn = 0
                 SELECT COUNT(*) INTO l_cn
                   FROM mhad_t
                  WHERE mhadent = g_enterprise
                    AND mhad001 = g_mhbc_m.mhbc003
                    AND mhad002 = g_mhbc_m.mhbc004
                    AND mhad003 = g_mhbc_m.mhbc005
                    AND mhad004 = g_mhbd_d[l_ac].mhbd002
                    AND mhad009 = g_mhbd_d[l_ac].mhbd003                                        
                 IF l_cn = 0 THEN
                   LET g_mhbd_d[l_ac].mhbd000 = '2'
                 ELSE
                   LET g_mhbd_d[l_ac].mhbd000 = '0'                  
                 END IF
                 
               END IF 
               
            END IF  
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd002
            
            #add-point:AFTER FIELD mhbd002 name="input.a.page1.mhbd002"
            #應用 a05 樣板自動產生(Version:3)
            LET g_mhbd_d[l_ac].mhbd002_desc = ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd002_desc
            
            IF NOT cl_null(g_mhbd_d[l_ac].mhbd002) THEN
               IF g_mhbd_d[l_ac].mhbd002 != g_mhbd_d_o.mhbd002 OR cl_null(g_mhbd_d_o.mhbd002) THEN
                  #確認資料無重複
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhbd_t WHERE "||"mhbdent = '" ||g_enterprise|| "' AND "||"mhbddocno = '"||g_mhbc_m.mhbcdocno ||"' AND "|| "mhbd002 = '"||g_mhbd_d[g_detail_idx].mhbd002 ||"'",'std-00004',0) THEN 
                     LET g_mhbd_d[l_ac].mhbd002  = g_mhbd_d_o.mhbd002
                     NEXT FIELD CURRENT
                  END IF           
                  #確認其它單據有無重復
                  LET l_cn = 0
                  SELECT COUNT(*) INTO l_cn
                    FROM mhbc_t,mhbd_t
                   WHERE mhbcent = mhbdent AND mhbcdocno = mhbddocno
                     AND mhbcent = g_enterprise AND mhbcstus = 'N' AND mhbd002 = g_mhbd_d[l_ac].mhbd002
                  IF l_cn > 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = "amh-00639"
                    LET g_errparam.extend = ""
                    LET g_errparam.popup = TRUE
                    LET g_errparam.replace[1] = g_mhbd_d[l_ac].mhbd002
                    CALL cl_err()
                    LET g_mhbd_d[l_ac].mhbd002  = g_mhbd_d_o.mhbd002
                    NEXT FIELD CURRENT
                  END IF          
                  #选择未使用场地
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhbd_d[l_ac].mhbd002
                  LET g_chkparam.arg2 = g_mhbc_m.mhbc003
                  #160512-00003#18  mark(S)
#                  LET g_chkparam.arg3 = g_mhbc_m.mhbc004
#                  IF cl_null(g_mhbc_m.mhbc005) THEN 
#                     LET g_chkparam.arg4 = ''     
#                  ELSE                   
#                     LET g_chkparam.arg4 = g_mhbc_m.mhbc005  
#                  END IF                     
                  #160512-00003#18  mark(E)
                  LET g_chkparam.arg3 = g_mhbc_m.mhbcsite   #160512-00003#18  add
#                  IF NOT cl_chk_exist("v_mhad004_1") THEN  #160512-00003#18  mark
                  IF NOT cl_chk_exist("v_mhad004_2") THEN   #160512-00003#18  add
                    LET g_mhbd_d[l_ac].mhbd002  = g_mhbd_d_o.mhbd002
                    NEXT FIELD CURRENT
                  END IF
                  
                  #帶出資料
                  SELECT mhad001,mhad002,mhad003,mhad004,mhad005,mhad006,mhad007,mhad009
                    INTO l_mhad001,l_mhad002,l_mhad003,l_mhad004,l_mhad005,l_mhad006,l_mhad007,l_mhad009 
                    FROM mhad_t     
                   WHERE mhadent = g_enterprise AND mhadsite = g_mhbc_m.mhbcsite 
                     AND mhad004 = g_mhbd_d[l_ac].mhbd002   
                  
                  LET g_mhbd_d[l_ac].mhbd002 = l_mhad004 
                  LET g_mhbd_d[l_ac].mhbd003 = l_mhad009
                  LET g_mhbd_d[l_ac].mhbd004 = l_mhad001
                  LET g_mhbd_d[l_ac].mhbd005 = l_mhad002
                  LET g_mhbd_d[l_ac].mhbd006 = l_mhad003
                  LET g_mhbd_d[l_ac].mhbd007 = l_mhad005
                  LET g_mhbd_d[l_ac].mhbd008 = l_mhad006
                  LET g_mhbd_d[l_ac].mhbd009 = l_mhad007   
               END IF
            END IF
            #160512-00003#18  mark(S)
#            #場地說明
#            LET g_ref_fields[1] = g_mhbc_m.mhbc003  
#            LET g_ref_fields[2] = g_mhbc_m.mhbc004   
#            IF NOT cl_null(g_mhbc_m.mhbc005) THEN 
#               LET g_ref_fields[3] = g_mhbc_m.mhbc005
#               LET g_ref_fields[4] = g_mhbd_d[l_ac].mhbd002
#               CALL ap_ref_array2(g_ref_fields,"SELECT mhadl006 FROM mhadl_t WHERE mhadlent='"||g_enterprise||"' AND mhadl001=? AND mhadl002=? AND mhadl003=? AND mhadl004=? AND mhadl005='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET g_mhbd_d[l_ac].mhbd002_desc = '', g_rtn_fields[1] , ''
#               DISPLAY BY NAME g_mhbd_d[l_ac].mhbd002_desc
#            ELSE
#               LET g_ref_fields[3] = g_mhbd_d[l_ac].mhbd002
#               CALL ap_ref_array2(g_ref_fields,"SELECT mhadl006 FROM mhadl_t WHERE mhadlent='"||g_enterprise||"' AND mhadl001=? AND mhadl002=? AND mhadl004=? AND mhadl005='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET g_mhbd_d[l_ac].mhbd002_desc = '', g_rtn_fields[1] , ''
#               DISPLAY BY NAME g_mhbd_d[l_ac].mhbd002_desc         
#            END IF     
            #160512-00003#18  mark(E)
            #160512-00003#18  add(S)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbc_m.mhbc003
            LET g_ref_fields[2] = g_mhbd_d[l_ac].mhbd002
            CALL ap_ref_array2(g_ref_fields,"SELECT mhadl006 FROM mhadl_t WHERE mhadlent='"||g_enterprise||"' AND mhadl001=? AND mhadl004=? AND mhadl005='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd002_desc
            #160512-00003#18  add(E)
            #樓棟說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbd_d[l_ac].mhbd004
            CALL ap_ref_array2(g_ref_fields,"SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd004_desc
            #樓層說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbd_d[l_ac].mhbd004
            LET g_ref_fields[2] = g_mhbd_d[l_ac].mhbd005
            CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd005_desc
            #區域說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbd_d[l_ac].mhbd004
            LET g_ref_fields[2] = g_mhbd_d[l_ac].mhbd005
            LET g_ref_fields[3] = g_mhbd_d[l_ac].mhbd006
            CALL ap_ref_array2(g_ref_fields,"SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND mhacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd006_desc
            
            LET g_mhbd_d_o.mhbd002  = g_mhbd_d[l_ac].mhbd002

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd002
            #add-point:BEFORE FIELD mhbd002 name="input.b.page1.mhbd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbd002
            #add-point:ON CHANGE mhbd002 name="input.g.page1.mhbd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd003
            #add-point:BEFORE FIELD mhbd003 name="input.b.page1.mhbd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd003
            
            #add-point:AFTER FIELD mhbd003 name="input.a.page1.mhbd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbd003
            #add-point:ON CHANGE mhbd003 name="input.g.page1.mhbd003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd004
            
            #add-point:AFTER FIELD mhbd004 name="input.a.page1.mhbd004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbd_d[l_ac].mhbd004
            CALL ap_ref_array2(g_ref_fields,"SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd004
            #add-point:BEFORE FIELD mhbd004 name="input.b.page1.mhbd004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbd004
            #add-point:ON CHANGE mhbd004 name="input.g.page1.mhbd004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd005
            
            #add-point:AFTER FIELD mhbd005 name="input.a.page1.mhbd005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbd_d[l_ac].mhbd004
            LET g_ref_fields[2] = g_mhbd_d[l_ac].mhbd005
            CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd005
            #add-point:BEFORE FIELD mhbd005 name="input.b.page1.mhbd005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbd005
            #add-point:ON CHANGE mhbd005 name="input.g.page1.mhbd005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd006
            
            #add-point:AFTER FIELD mhbd006 name="input.a.page1.mhbd006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbd_d[l_ac].mhbd004
            LET g_ref_fields[2] = g_mhbd_d[l_ac].mhbd005
            LET g_ref_fields[3] = g_mhbd_d[l_ac].mhbd006
            CALL ap_ref_array2(g_ref_fields,"SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND mhacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd006
            #add-point:BEFORE FIELD mhbd006 name="input.b.page1.mhbd006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbd006
            #add-point:ON CHANGE mhbd006 name="input.g.page1.mhbd006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd007
            #add-point:BEFORE FIELD mhbd007 name="input.b.page1.mhbd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd007
            
            #add-point:AFTER FIELD mhbd007 name="input.a.page1.mhbd007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbd007
            #add-point:ON CHANGE mhbd007 name="input.g.page1.mhbd007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd008
            #add-point:BEFORE FIELD mhbd008 name="input.b.page1.mhbd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd008
            
            #add-point:AFTER FIELD mhbd008 name="input.a.page1.mhbd008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbd008
            #add-point:ON CHANGE mhbd008 name="input.g.page1.mhbd008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd009
            #add-point:BEFORE FIELD mhbd009 name="input.b.page1.mhbd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd009
            
            #add-point:AFTER FIELD mhbd009 name="input.a.page1.mhbd009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbd009
            #add-point:ON CHANGE mhbd009 name="input.g.page1.mhbd009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbdsite
            #add-point:BEFORE FIELD mhbdsite name="input.b.page1.mhbdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbdsite
            
            #add-point:AFTER FIELD mhbdsite name="input.a.page1.mhbdsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbdsite
            #add-point:ON CHANGE mhbdsite name="input.g.page1.mhbdsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbd001
            #add-point:BEFORE FIELD mhbd001 name="input.b.page1.mhbd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbd001
            
            #add-point:AFTER FIELD mhbd001 name="input.a.page1.mhbd001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbd001
            #add-point:ON CHANGE mhbd001 name="input.g.page1.mhbd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbdunit
            #add-point:BEFORE FIELD mhbdunit name="input.b.page1.mhbdunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbdunit
            
            #add-point:AFTER FIELD mhbdunit name="input.a.page1.mhbdunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbdunit
            #add-point:ON CHANGE mhbdunit name="input.g.page1.mhbdunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mhbdacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbdacti
            #add-point:ON ACTION controlp INFIELD mhbdacti name="input.c.page1.mhbdacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd002
            #add-point:ON ACTION controlp INFIELD mhbd002 name="input.c.page1.mhbd002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段       
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhbd_d[l_ac].mhbd002 
            
            LET l_where = " mhadsite = '",g_mhbc_m.mhbcsite,"'"
            #樓棟
            IF NOT cl_null(g_mhbc_m.mhbc003) THEN
               LET l_where = l_where," AND mhad001 = '",g_mhbc_m.mhbc003,"'"
            END IF
            #160512-00003#18 mark(S)
#            #樓層
#            IF NOT cl_null(g_mhbc_m.mhbc004) THEN
#               LET l_where = l_where," AND mhad002 = '",g_mhbc_m.mhbc004,"'"
#            END IF
#            #區域
#            IF NOT cl_null(g_mhbc_m.mhbc005) THEN
#               LET l_where = l_where," AND mhad003 = '",g_mhbc_m.mhbc005,"'"
#            END IF
            #160512-00003#18 mark(E)
            LET g_qryparam.where = l_where
            CALL q_mhad001()
            LET g_mhbd_d[l_ac].mhbd002  = g_qryparam.return1
            
            DISPLAY g_mhbd_d[l_ac].mhbd002  TO mhbd002
            
            #帶出資料
            SELECT mhad001,mhad002,mhad003,mhad004,mhad005,mhad006,mhad007,mhad009
              INTO l_mhad001,l_mhad002,l_mhad003,l_mhad004,l_mhad005,l_mhad006,l_mhad007,l_mhad009 
              FROM mhad_t     
             WHERE mhadent = g_enterprise AND mhadsite = g_mhbc_m.mhbcsite 
               AND mhad004 = g_mhbd_d[l_ac].mhbd002   
            
            LET g_mhbd_d[l_ac].mhbd003 = l_mhad009
            LET g_mhbd_d[l_ac].mhbd004 = l_mhad001
            LET g_mhbd_d[l_ac].mhbd005 = l_mhad002
            LET g_mhbd_d[l_ac].mhbd006 = l_mhad003
            LET g_mhbd_d[l_ac].mhbd007 = l_mhad005
            LET g_mhbd_d[l_ac].mhbd008 = l_mhad006
            LET g_mhbd_d[l_ac].mhbd009 = l_mhad007   
            #160512-00003#18  mark(S)
#            #場地說明
#            LET g_ref_fields[1] = g_mhbc_m.mhbc003  
#            LET g_ref_fields[2] = g_mhbc_m.mhbc004   
#            IF NOT cl_null(g_mhbc_m.mhbc005) THEN 
#               LET g_ref_fields[3] = g_mhbc_m.mhbc005
#               LET g_ref_fields[4] = g_mhbd_d[l_ac].mhbd002
#               CALL ap_ref_array2(g_ref_fields,"SELECT mhadl006 FROM mhadl_t WHERE mhadlent='"||g_enterprise||"' AND mhadl001=? AND mhadl002=? AND mhadl003=? AND mhadl004=? AND mhadl005='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET g_mhbd_d[l_ac].mhbd002_desc = '', g_rtn_fields[1] , ''
#               DISPLAY BY NAME g_mhbd_d[l_ac].mhbd002_desc
#            ELSE
#               LET g_ref_fields[3] = g_mhbd_d[l_ac].mhbd002
#               CALL ap_ref_array2(g_ref_fields,"SELECT mhadl006 FROM mhadl_t WHERE mhadlent='"||g_enterprise||"' AND mhadl001=? AND mhadl002=? AND mhadl004=? AND mhadl005='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET g_mhbd_d[l_ac].mhbd002_desc = '', g_rtn_fields[1] , ''
#               DISPLAY BY NAME g_mhbd_d[l_ac].mhbd002_desc         
#            END IF
            #160512-00003#18  mark(E)
            #160512-00003#18  add(S)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbc_m.mhbc003
            LET g_ref_fields[2] = g_mhbd_d[l_ac].mhbd002
            CALL ap_ref_array2(g_ref_fields,"SELECT mhadl006 FROM mhadl_t WHERE mhadlent='"||g_enterprise||"' AND mhadl001=? AND mhadl004=? AND mhadl005='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd002_desc
            #160512-00003#18  add(E)
            #樓棟說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbd_d[l_ac].mhbd004
            CALL ap_ref_array2(g_ref_fields,"SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd004_desc
            #樓層說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbd_d[l_ac].mhbd004
            LET g_ref_fields[2] = g_mhbd_d[l_ac].mhbd005
            CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd005_desc
            #區域說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhbd_d[l_ac].mhbd004
            LET g_ref_fields[2] = g_mhbd_d[l_ac].mhbd005
            LET g_ref_fields[3] = g_mhbd_d[l_ac].mhbd006
            CALL ap_ref_array2(g_ref_fields,"SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND mhacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhbd_d[l_ac].mhbd006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhbd_d[l_ac].mhbd006_desc
            
            NEXT FIELD mhbd002

            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd003
            #add-point:ON ACTION controlp INFIELD mhbd003 name="input.c.page1.mhbd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd004
            #add-point:ON ACTION controlp INFIELD mhbd004 name="input.c.page1.mhbd004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd005
            #add-point:ON ACTION controlp INFIELD mhbd005 name="input.c.page1.mhbd005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd006
            #add-point:ON ACTION controlp INFIELD mhbd006 name="input.c.page1.mhbd006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd007
            #add-point:ON ACTION controlp INFIELD mhbd007 name="input.c.page1.mhbd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd008
            #add-point:ON ACTION controlp INFIELD mhbd008 name="input.c.page1.mhbd008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd009
            #add-point:ON ACTION controlp INFIELD mhbd009 name="input.c.page1.mhbd009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbdsite
            #add-point:ON ACTION controlp INFIELD mhbdsite name="input.c.page1.mhbdsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbd001
            #add-point:ON ACTION controlp INFIELD mhbd001 name="input.c.page1.mhbd001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbdunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbdunit
            #add-point:ON ACTION controlp INFIELD mhbdunit name="input.c.page1.mhbdunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mhbd_d[l_ac].* = g_mhbd_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amht205_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mhbd_d[l_ac].mhbd002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mhbd_d[l_ac].* = g_mhbd_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL amht205_mhbd_t_mask_restore('restore_mask_o')
      
               UPDATE mhbd_t SET (mhbddocno,mhbdacti,mhbd000,mhbd002,mhbd003,mhbd004,mhbd005,mhbd006, 
                   mhbd007,mhbd008,mhbd009,mhbdsite,mhbd001,mhbdunit) = (g_mhbc_m.mhbcdocno,g_mhbd_d[l_ac].mhbdacti, 
                   g_mhbd_d[l_ac].mhbd000,g_mhbd_d[l_ac].mhbd002,g_mhbd_d[l_ac].mhbd003,g_mhbd_d[l_ac].mhbd004, 
                   g_mhbd_d[l_ac].mhbd005,g_mhbd_d[l_ac].mhbd006,g_mhbd_d[l_ac].mhbd007,g_mhbd_d[l_ac].mhbd008, 
                   g_mhbd_d[l_ac].mhbd009,g_mhbd_d[l_ac].mhbdsite,g_mhbd_d[l_ac].mhbd001,g_mhbd_d[l_ac].mhbdunit) 
 
                WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno 
 
                  AND mhbd002 = g_mhbd_d_t.mhbd002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mhbd_d[l_ac].* = g_mhbd_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhbd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mhbd_d[l_ac].* = g_mhbd_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhbd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhbc_m.mhbcdocno
               LET gs_keys_bak[1] = g_mhbcdocno_t
               LET gs_keys[2] = g_mhbd_d[g_detail_idx].mhbd002
               LET gs_keys_bak[2] = g_mhbd_d_t.mhbd002
               CALL amht205_update_b('mhbd_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL amht205_mhbd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mhbd_d[g_detail_idx].mhbd002 = g_mhbd_d_t.mhbd002 
 
                  ) THEN
                  LET gs_keys[01] = g_mhbc_m.mhbcdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mhbd_d_t.mhbd002
 
                  CALL amht205_key_update_b(gs_keys,'mhbd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mhbc_m),util.JSON.stringify(g_mhbd_d_t)
               LET g_log2 = util.JSON.stringify(g_mhbc_m),util.JSON.stringify(g_mhbd_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #mark by geza 20160615(S)
#               SELECT SUM(mhbd007),SUM(mhbd008),SUM(mhbd009) INTO g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008
#                 FROM mhbc_t,mhbd_t
#                WHERE mhbcent=mhbdent
#                  AND mhbcdocno=mhbddocno
#                  AND mhbcent=g_enterprise
#                  AND mhbcdocno=g_mhbc_m.mhbcdocno
#                  AND mhbd000 != '3'
               #mark by geza 20160615(S) 
               #add by geza 20160615 (S)
               UPDATE mhbc_t SET mhbc006 = (SELECT SUM(mhbd007) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3'),
                                 mhbc007 = (SELECT SUM(mhbd008) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3'),
                                 mhbc008 = (SELECT SUM(mhbd009) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3')
                WHERE mhbcent = g_enterprise
                  AND mhbcdocno = g_mhbc_m.mhbcdocno
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00034'
                  LET g_errparam.extend = g_mhbc_m.mhbcdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               DISPLAY BY NAME g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008
               #add by geza 2016015  (E)               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #add by geza 20160615 (S)
             UPDATE mhbc_t SET mhbc006 = (SELECT SUM(mhbd007) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3'),
                               mhbc007 = (SELECT SUM(mhbd008) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3'),
                               mhbc008 = (SELECT SUM(mhbd009) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3')
              WHERE mhbcent = g_enterprise
                AND mhbcdocno = g_mhbc_m.mhbcdocno
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'sub-00034'
                LET g_errparam.extend = g_mhbc_m.mhbcdocno
                LET g_errparam.popup = TRUE
                CALL cl_err()
             END IF
             SELECT mhbc006,mhbc007,mhbc008 INTO g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008
               FROM mhbc_t
              WHERE mhbcent=g_enterprise
                AND mhbcdocno=g_mhbc_m.mhbcdocno
             DISPLAY BY NAME g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008
             #add by geza 2016015  (E)      
            #end add-point
            CALL amht205_unlock_b("mhbd_t","'1'")
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
               LET g_mhbd_d[li_reproduce_target].* = g_mhbd_d[li_reproduce].*
 
               LET g_mhbd_d[li_reproduce_target].mhbd002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mhbd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mhbd_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="amht205.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD mhbcsite
            #end add-point  
            NEXT FIELD mhbcdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mhbdacti
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amht205_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL amht205_b_fill() #單身填充
      CALL amht205_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amht205_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbc_m.mhbcdocno
   LET g_ref_fields[2] = g_mhbc_m.mhbc001
   CALL ap_ref_array2(g_ref_fields," SELECT mhbcl003,mhbcl004 FROM mhbcl_t WHERE mhbclent = '"||g_enterprise||"' AND mhbcldocno = ? AND mhbcl001 = ? AND mhbcl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_mhbc_m.mhbcl003 = g_rtn_fields[1] 
   LET g_mhbc_m.mhbcl004 = g_rtn_fields[2] 
   DISPLAY g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004 TO mhbcl003,mhbcl004
   #mark by geza 20160615(S)
#   SELECT SUM(mhbd007),SUM(mhbd008),SUM(mhbd009) INTO g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008
#     FROM mhbc_t,mhbd_t
#    WHERE mhbcent=mhbdent
#      AND mhbcdocno=mhbddocno
#      AND mhbcent=g_enterprise
#      AND mhbcdocno=g_mhbc_m.mhbcdocno
#      AND mhbd000 != '3'
   #mark by geza 20160615(S)   
   #end add-point
   
   #遮罩相關處理
   LET g_mhbc_m_mask_o.* =  g_mhbc_m.*
   CALL amht205_mhbc_t_mask()
   LET g_mhbc_m_mask_n.* =  g_mhbc_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mhbc_m.mhbcsite,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbcdocdt,g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000, 
       g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004,g_mhbc_m.mhbc003, 
       g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005,g_mhbc_m.mhbc005_desc, 
       g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009,g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010, 
       g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012, 
       g_mhbc_m.mhbc013,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014,g_mhbc_m.mhbc014_desc,g_mhbc_m.mhbc015, 
       g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp, 
       g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid,g_mhbc_m.mhbccrtid_desc,g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdp_desc, 
       g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid, 
       g_mhbc_m.mhbccnfid_desc,g_mhbc_m.mhbccnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mhbc_m.mhbcstus 
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
   FOR l_ac = 1 TO g_mhbd_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL amht205_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amht205.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION amht205_detail_show()
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
 
{<section id="amht205.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amht205_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mhbc_t.mhbcdocno 
   DEFINE l_oldno     LIKE mhbc_t.mhbcdocno 
 
   DEFINE l_master    RECORD LIKE mhbc_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mhbd_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_doctype  LIKE rtai_t.rtai004
   DEFINE l_insert   LIKE type_t.num5
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
   
   IF g_mhbc_m.mhbcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mhbcdocno_t = g_mhbc_m.mhbcdocno
 
    
   LET g_mhbc_m.mhbcdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mhbc_m.mhbcownid = g_user
      LET g_mhbc_m.mhbcowndp = g_dept
      LET g_mhbc_m.mhbccrtid = g_user
      LET g_mhbc_m.mhbccrtdp = g_dept 
      LET g_mhbc_m.mhbccrtdt = cl_get_current()
      LET g_mhbc_m.mhbcmodid = g_user
      LET g_mhbc_m.mhbcmoddt = cl_get_current()
      LET g_mhbc_m.mhbcstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #營運組織
   CALL s_aooi500_default(g_prog,'mhbcsite',g_mhbc_m.mhbcsite)
      RETURNING l_insert,g_mhbc_m.mhbcsite
   IF NOT l_insert THEN
      RETURN
   END IF
   CALL s_desc_get_department_desc(g_mhbc_m.mhbcsite) RETURNING g_mhbc_m.mhbcsite_desc
   DISPLAY BY NAME g_mhbc_m.mhbcsite_desc
   
   #單據日期
   LET g_mhbc_m.mhbcdocdt = g_today
   
   #單別
   CALL s_arti200_get_def_doc_type(g_mhbc_m.mhbcsite,g_prog,'1') RETURNING l_success,l_doctype         
   LET g_mhbc_m.mhbcdocno = l_doctype
   DISPLAY BY NAME g_mhbc_m.mhbcdocno
   
   #業務人員
   LET g_mhbc_m.mhbc013 = g_user
   CALL s_desc_get_person_desc(g_mhbc_m.mhbc013) RETURNING g_mhbc_m.mhbc013_desc
   DISPLAY BY NAME g_mhbc_m.mhbc013_desc
   
   #部門
   LET g_mhbc_m.mhbc014 = g_dept
   CALL s_desc_get_department_desc(g_mhbc_m.mhbc014) RETURNING g_mhbc_m.mhbc014_desc
   DISPLAY BY NAME g_mhbc_m.mhbc014_desc
   
   #清除鋪位編號/確認人員/確認日期/單身清空
   LET g_mhbc_m.mhbc001 = NULL
   LET g_mhbc_m.mhbccnfid = NULL
   LET g_mhbc_m.mhbccnfdt = NULL
   INITIALIZE g_mhbd_d TO NULL   
   LET g_site_flag = FALSE
   LET g_mhbc_m_t.* = g_mhbc_m.*
   LET g_mhbc_m_o.* = g_mhbc_m.*
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mhbc_m.mhbcstus 
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
   
   
   CALL amht205_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mhbc_m.* TO NULL
      INITIALIZE g_mhbd_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL amht205_show()
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
   CALL amht205_set_act_visible()   
   CALL amht205_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mhbcdocno_t = g_mhbc_m.mhbcdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mhbcent = " ||g_enterprise|| " AND",
                      " mhbcdocno = '", g_mhbc_m.mhbcdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amht205_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL amht205_idx_chk()
   
   LET g_data_owner = g_mhbc_m.mhbcownid      
   LET g_data_dept  = g_mhbc_m.mhbcowndp
   
   #功能已完成,通報訊息中心
   CALL amht205_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amht205_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mhbd_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amht205_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mhbd_t
    WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbcdocno_t
 
    INTO TEMP amht205_detail
 
   #將key修正為調整後   
   UPDATE amht205_detail 
      #更新key欄位
      SET mhbddocno = g_mhbc_m.mhbcdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mhbd_t SELECT * FROM amht205_detail
   
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
   DROP TABLE amht205_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mhbcdocno_t = g_mhbc_m.mhbcdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="amht205.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amht205_delete()
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
   
   IF g_mhbc_m.mhbcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.mhbcldocno = g_mhbc_m.mhbcdocno
LET g_master_multi_table_t.mhbcl001 = g_mhbc_m.mhbc001
LET g_master_multi_table_t.mhbcl003 = g_mhbc_m.mhbcl003
LET g_master_multi_table_t.mhbcl004 = g_mhbc_m.mhbcl004
 
   
   CALL s_transaction_begin()
 
   OPEN amht205_cl USING g_enterprise,g_mhbc_m.mhbcdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht205_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amht205_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amht205_master_referesh USING g_mhbc_m.mhbcdocno INTO g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt, 
       g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000,g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbc003, 
       g_mhbc_m.mhbc004,g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009, 
       g_mhbc_m.mhbc010,g_mhbc_m.mhbc017,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc014, 
       g_mhbc_m.mhbc015,g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcowndp,g_mhbc_m.mhbccrtid, 
       g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid, 
       g_mhbc_m.mhbccnfdt,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005_desc, 
       g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014_desc, 
       g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid_desc,g_mhbc_m.mhbccrtdp_desc, 
       g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbccnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT amht205_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mhbc_m_mask_o.* =  g_mhbc_m.*
   CALL amht205_mhbc_t_mask()
   LET g_mhbc_m_mask_n.* =  g_mhbc_m.*
   
   CALL amht205_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amht205_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mhbcdocno_t = g_mhbc_m.mhbcdocno
 
 
      DELETE FROM mhbc_t
       WHERE mhbcent = g_enterprise AND mhbcdocno = g_mhbc_m.mhbcdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mhbc_m.mhbcdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_mhbc_m.mhbcdocno,g_mhbc_m.mhbcdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mhbd_t
       WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhbd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mhbc_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE amht205_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mhbd_d.clear() 
 
     
      CALL amht205_ui_browser_refresh()  
      #CALL amht205_ui_headershow()  
      #CALL amht205_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'mhbclent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.mhbcldocno
   LET l_field_keys[02] = 'mhbcldocno'
   LET l_var_keys_bak[03] = g_master_multi_table_t.mhbcl001
   LET l_field_keys[03] = 'mhbcl001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhbcl_t')
 
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL amht205_browser_fill("")
         CALL amht205_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE amht205_cl
 
   #功能已完成,通報訊息中心
   CALL amht205_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amht205.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amht205_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mhbd_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF amht205_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mhbdacti,mhbd000,mhbd002,mhbd003,mhbd004,mhbd005,mhbd006,mhbd007, 
             mhbd008,mhbd009,mhbdsite,mhbd001,mhbdunit ,t1.mhbbl003 ,t2.mhaal003 ,t3.mhabl004 ,t4.mhacl005 FROM mhbd_t", 
                
                     " INNER JOIN mhbc_t ON mhbcent = " ||g_enterprise|| " AND mhbcdocno = mhbddocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN mhbbl_t t1 ON t1.mhbblent="||g_enterprise||" AND t1.mhbbl001=mhbd002 AND t1.mhbbl002='"||g_dlang||"' ",
               " LEFT JOIN mhaal_t t2 ON t2.mhaalent="||g_enterprise||" AND t2.mhaal001=mhbd004 AND t2.mhaal002='"||g_dlang||"' ",
               " LEFT JOIN mhabl_t t3 ON t3.mhablent="||g_enterprise||" AND t3.mhabl001=mhbd004 AND t3.mhabl002=mhbd005 AND t3.mhabl003='"||g_dlang||"' ",
               " LEFT JOIN mhacl_t t4 ON t4.mhaclent="||g_enterprise||" AND t4.mhacl001=mhbd004 AND t4.mhacl002=mhbd005 AND t4.mhacl003=mhbd006 AND t4.mhacl004='"||g_dlang||"' ",
 
                     " WHERE mhbdent=? AND mhbddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         LET g_sql = "SELECT  DISTINCT mhbdacti,   mhbd000,    mhbd002,    mhbd003,     mhbd004,     ",
                     "                 mhbd005,    mhbd006,    mhbd007,    mhbd008,     mhbd009,     ", 
                     "                 mhbdsite,   mhbd001,    mhbdunit,                             ",                              
                     "                 t1.mhadl006,t2.mhaal003,t3.mhabl004,t4.mhacl005 ",
                     "  FROM mhbd_t",   
                     " INNER JOIN mhbc_t ON mhbcdocno = mhbddocno AND mhbcent = mhbdent ",
                     "  LEFT JOIN mhadl_t t1 ON t1.mhadlent='"||g_enterprise||"' AND t1.mhadl001=mhbd004 AND t1.mhadl002=mhbd005 AND t1.mhadl003=mhbd006 AND t1.mhadl004=mhbd002 AND t1.mhadl005='"||g_dlang||"' ",
                     "  LEFT JOIN mhaal_t t2 ON t2.mhaalent='"||g_enterprise||"' AND t2.mhaal001=mhbd004 AND t2.mhaal002='"||g_dlang||"' ",
                     "  LEFT JOIN mhabl_t t3 ON t3.mhablent='"||g_enterprise||"' AND t3.mhabl001=mhbd004 AND t3.mhabl002=mhbd005 AND t3.mhabl003='"||g_dlang||"' ",
                     "  LEFT JOIN mhacl_t t4 ON t4.mhaclent='"||g_enterprise||"' AND t4.mhacl001=mhbd004 AND t4.mhacl002=mhbd005 AND t4.mhacl003=mhbd006 AND t4.mhacl004='"||g_dlang||"' ", 
                     " WHERE mhbdent=? AND mhbddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mhbd_t.mhbd002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         DISPLAY g_sql
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amht205_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amht205_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mhbc_m.mhbcdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mhbc_m.mhbcdocno INTO g_mhbd_d[l_ac].mhbdacti,g_mhbd_d[l_ac].mhbd000, 
          g_mhbd_d[l_ac].mhbd002,g_mhbd_d[l_ac].mhbd003,g_mhbd_d[l_ac].mhbd004,g_mhbd_d[l_ac].mhbd005, 
          g_mhbd_d[l_ac].mhbd006,g_mhbd_d[l_ac].mhbd007,g_mhbd_d[l_ac].mhbd008,g_mhbd_d[l_ac].mhbd009, 
          g_mhbd_d[l_ac].mhbdsite,g_mhbd_d[l_ac].mhbd001,g_mhbd_d[l_ac].mhbdunit,g_mhbd_d[l_ac].mhbd002_desc, 
          g_mhbd_d[l_ac].mhbd004_desc,g_mhbd_d[l_ac].mhbd005_desc,g_mhbd_d[l_ac].mhbd006_desc   #(ver:78) 
 
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
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_mhbd_d.deleteElement(g_mhbd_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE amht205_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mhbd_d.getLength()
      LET g_mhbd_d_mask_o[l_ac].* =  g_mhbd_d[l_ac].*
      CALL amht205_mhbd_t_mask()
      LET g_mhbd_d_mask_n[l_ac].* =  g_mhbd_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amht205_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mhbd_t
       WHERE mhbdent = g_enterprise AND
         mhbddocno = ps_keys_bak[1] AND mhbd002 = ps_keys_bak[2]
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
         CALL g_mhbd_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amht205.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amht205_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mhbd_t
                  (mhbdent,
                   mhbddocno,
                   mhbd002
                   ,mhbdacti,mhbd000,mhbd003,mhbd004,mhbd005,mhbd006,mhbd007,mhbd008,mhbd009,mhbdsite,mhbd001,mhbdunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mhbd_d[g_detail_idx].mhbdacti,g_mhbd_d[g_detail_idx].mhbd000,g_mhbd_d[g_detail_idx].mhbd003, 
                       g_mhbd_d[g_detail_idx].mhbd004,g_mhbd_d[g_detail_idx].mhbd005,g_mhbd_d[g_detail_idx].mhbd006, 
                       g_mhbd_d[g_detail_idx].mhbd007,g_mhbd_d[g_detail_idx].mhbd008,g_mhbd_d[g_detail_idx].mhbd009, 
                       g_mhbd_d[g_detail_idx].mhbdsite,g_mhbd_d[g_detail_idx].mhbd001,g_mhbd_d[g_detail_idx].mhbdunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhbd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mhbd_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      #mark by geza 20160615(S)
#      SELECT SUM(mhbd007),SUM(mhbd008),SUM(mhbd009) INTO g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008
#        FROM mhbc_t,mhbd_t
#       WHERE mhbcent=mhbdent
#         AND mhbcdocno=mhbddocno
#         AND mhbcent=g_enterprise
#         AND mhbcdocno=g_mhbc_m.mhbcdocno
#         AND mhbd000 != '3'
        
#      UPDATE mhbc_t SET mhbc006 = g_mhbc_m.mhbc006,
#                        mhbc007 = g_mhbc_m.mhbc007,
#                        mhbc008 = g_mhbc_m.mhbc008
#       WHERE mhbcent = g_enterprise
#         AND mhbcdocno = g_mhbc_m.mhbcdocno
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'sub-00034'
#         LET g_errparam.extend = g_mhbc_m.mhbcdocno
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      END IF
      #mark by geza 20160615(E)  
      #add by geza 20160615 (S)
      UPDATE mhbc_t SET mhbc006 = (SELECT SUM(mhbd007) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3'),
                        mhbc007 = (SELECT SUM(mhbd008) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3'),
                        mhbc008 = (SELECT SUM(mhbd009) FROM mhbd_t WHERE mhbdent = g_enterprise AND mhbddocno = g_mhbc_m.mhbcdocno AND mhbd000 != '3')
       WHERE mhbcent = g_enterprise
         AND mhbcdocno = g_mhbc_m.mhbcdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = g_mhbc_m.mhbcdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      SELECT mhbc006,mhbc007,mhbc008 INTO g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008
        FROM mhbc_t
       WHERE mhbcent=g_enterprise
         AND mhbcdocno=g_mhbc_m.mhbcdocno
      DISPLAY BY NAME g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008
      #add by geza 2016015  (E)      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="amht205.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amht205_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mhbd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL amht205_mhbd_t_mask_restore('restore_mask_o')
               
      UPDATE mhbd_t 
         SET (mhbddocno,
              mhbd002
              ,mhbdacti,mhbd000,mhbd003,mhbd004,mhbd005,mhbd006,mhbd007,mhbd008,mhbd009,mhbdsite,mhbd001,mhbdunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mhbd_d[g_detail_idx].mhbdacti,g_mhbd_d[g_detail_idx].mhbd000,g_mhbd_d[g_detail_idx].mhbd003, 
                  g_mhbd_d[g_detail_idx].mhbd004,g_mhbd_d[g_detail_idx].mhbd005,g_mhbd_d[g_detail_idx].mhbd006, 
                  g_mhbd_d[g_detail_idx].mhbd007,g_mhbd_d[g_detail_idx].mhbd008,g_mhbd_d[g_detail_idx].mhbd009, 
                  g_mhbd_d[g_detail_idx].mhbdsite,g_mhbd_d[g_detail_idx].mhbd001,g_mhbd_d[g_detail_idx].mhbdunit)  
 
         WHERE mhbdent = g_enterprise AND mhbddocno = ps_keys_bak[1] AND mhbd002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amht205_mhbd_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amht205.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION amht205_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="amht205.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amht205_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amht205.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amht205_lock_b(ps_table,ps_page)
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
   #CALL amht205_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mhbd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN amht205_bcl USING g_enterprise,
                                       g_mhbc_m.mhbcdocno,g_mhbd_d[g_detail_idx].mhbd002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amht205_bcl:",SQLERRMESSAGE 
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
 
{<section id="amht205.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amht205_unlock_b(ps_table,ps_page)
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
      CLOSE amht205_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amht205_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mhbcdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mhbcdocno",TRUE)
      CALL cl_set_comp_entry("mhbcdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mhbcsite",TRUE)
      CALL cl_set_comp_entry("mhbcdocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("mhbc000,mhbc002,mhbcl003,mhbcl004,mhbc003,mhbc004,mhbc005,mhbc006,mhbc007,mhbc008",TRUE)
   #CALL cl_set_comp_entry("mhbc009,mhbc010,mhbc011,mhbc012,mhbc016",TRUE) #mark by geza 20160528 #160513-00037#18
   CALL cl_set_comp_entry("mhbc009,mhbc010,mhbc011,mhbc016",TRUE) #add by geza 20160528 #160513-00037#18
   CALL cl_set_comp_entry("mhbc017",TRUE)  #160506-00009#4 Add By Ken 160506
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amht205_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mhbcdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("mhbcsite",FALSE)
      CALL cl_set_comp_entry("mhbcdocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mhbcdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mhbcdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #營運組織
   IF NOT s_aooi500_comp_entry(g_prog,'mhbcsite') THEN
      CALL cl_set_comp_entry("mhbcsite",FALSE)
   END IF
   
   CALL cl_set_comp_entry("mhbc002,mhbc006,mhbc007,mhbc008",FALSE)
   
   IF g_mhbc_m.mhbc000 = 'U' THEN
   #160512-00003#18  mark(S)
#     CALL cl_set_comp_entry("mhbcl003,mhbcl004,mhbc003,mhbc004,mhbc005",FALSE)
#     CALL cl_set_comp_entry("mhbc009,mhbc010,mhbc011,mhbc012",FALSE)
#     CALL cl_set_comp_entry("mhbc017",FALSE)  #160506-00009#4 Add By Ken 160506
   #160512-00003#18  mark(E)
      #CALL cl_set_comp_entry("mhbc012,mhbc003,mhbc004,mhbc005",FALSE)   #160512-00003#18  add #mark by geza 20160528 #160513-00037#18
      #CALL cl_set_comp_entry("mhbc003,mhbc004,mhbc005",FALSE)    #add by geza 20160528 #160513-00037#18 #mark by geza 20160622 #160513-00037#18
      CALL cl_set_comp_entry("mhbc003,mhbc004",FALSE)    #add by geza 20160622 #160513-00037#18
   END IF  
   
   IF NOT cl_null(g_mhbc_m.mhbc001) THEN
      CALL cl_set_comp_entry("mhbc000",FALSE) 
   END IF    
   
   IF g_mhbc_m.mhbc000 = 'I' THEN
      CALL cl_set_comp_entry("mhbc016",FALSE) 
   END IF    
   
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amht205_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("mhbd002",TRUE)
   CALL cl_set_comp_entry("mhbd000,mhbd002,mhbd003,mhbd004,mhbd005,mhbd006",TRUE)
   CALL cl_set_comp_entry("mhbd007,mhbd008,mhbd009",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="amht205.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amht205_set_no_entry_b(p_cmd)
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
   #沒有面積申請單，就不能修改
   IF cl_null(g_mhbc_m.mhbc016) THEN 
      CALL cl_set_comp_entry("mhbd007,mhbd008,mhbd009",FALSE)
   END IF  
   
   CALL cl_set_comp_entry("mhbd000,mhbd003,mhbd004,mhbd005,mhbd006",FALSE)
   
   #160604-00009#118 160630 by lori add---(S)
   IF g_mhbc_m.mhbc000 = 'U' AND g_mhbd_d[l_ac].mhbd000 <> '1' THEN
      CALL cl_set_comp_entry("mhbd002",FALSE)     
   END IF
   #160604-00009#118 160630 by lori add---(E)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="amht205.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amht205_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
 
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht205.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amht205_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_mhbc_m.mhbcstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht205.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amht205_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht205.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amht205_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amht205.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amht205_default_search()
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
      LET ls_wc = ls_wc, " mhbcdocno = '", g_argv[01], "' AND "
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
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "mhbc_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mhbd_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
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
 
{<section id="amht205.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION amht205_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mhbc_m.mhbcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN amht205_cl USING g_enterprise,g_mhbc_m.mhbcdocno
   IF STATUS THEN
      CLOSE amht205_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht205_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE amht205_master_referesh USING g_mhbc_m.mhbcdocno INTO g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt, 
       g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000,g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbc003, 
       g_mhbc_m.mhbc004,g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009, 
       g_mhbc_m.mhbc010,g_mhbc_m.mhbc017,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc014, 
       g_mhbc_m.mhbc015,g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcowndp,g_mhbc_m.mhbccrtid, 
       g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid, 
       g_mhbc_m.mhbccnfdt,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005_desc, 
       g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014_desc, 
       g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid_desc,g_mhbc_m.mhbccrtdp_desc, 
       g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbccnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT amht205_action_chk() THEN
      CLOSE amht205_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mhbc_m.mhbcsite,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbcdocdt,g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000, 
       g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004,g_mhbc_m.mhbc003, 
       g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005,g_mhbc_m.mhbc005_desc, 
       g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009,g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010, 
       g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012, 
       g_mhbc_m.mhbc013,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014,g_mhbc_m.mhbc014_desc,g_mhbc_m.mhbc015, 
       g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp, 
       g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid,g_mhbc_m.mhbccrtid_desc,g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdp_desc, 
       g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid, 
       g_mhbc_m.mhbccnfid_desc,g_mhbc_m.mhbccnfdt
 
   CASE g_mhbc_m.mhbcstus
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
         CASE g_mhbc_m.mhbcstus
            
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
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      
      CASE g_mhbc_m.mhbcstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "X"
            HIDE OPTION "confirmed"
            HIDE OPTION "unconfirmed"
            CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
            RETURN
         WHEN "Y"            
             CALL cl_set_act_visible("confirmed,unconfirmed,invalid",FALSE)
             CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
             RETURN
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
            IF NOT amht205_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amht205_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT amht205_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amht205_cl
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
      g_mhbc_m.mhbcstus = lc_state OR cl_null(lc_state) THEN
      CLOSE amht205_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()

   OPEN amht205_cl USING g_enterprise,g_mhbc_m.mhbcdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amht205_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE amht205_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL cl_err_collect_init()
   IF lc_state = 'Y' THEN
      IF NOT s_amht205_conf_chk(g_mhbc_m.mhbcdocno,g_mhbc_m.mhbcstus) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
         RETURN
      ELSE 
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
            RETURN
         ELSE
            IF NOT s_amht205_conf_upd(g_mhbc_m.mhbcdocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   
   IF lc_state = 'X' THEN
      IF NOT s_amht205_invalid_chk(g_mhbc_m.mhbcdocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
            RETURN
         ELSE
            IF NOT s_amht205_invalid_upd(g_mhbc_m.mhbcdocno)  THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_mhbc_m.mhbcmodid = g_user
   LET g_mhbc_m.mhbcmoddt = cl_get_current()
   LET g_mhbc_m.mhbcstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mhbc_t 
      SET (mhbcstus,mhbcmodid,mhbcmoddt) 
        = (g_mhbc_m.mhbcstus,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmoddt)     
    WHERE mhbcent = g_enterprise AND mhbcdocno = g_mhbc_m.mhbcdocno
 
    
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
      EXECUTE amht205_master_referesh USING g_mhbc_m.mhbcdocno INTO g_mhbc_m.mhbcsite,g_mhbc_m.mhbcdocdt, 
          g_mhbc_m.mhbcdocno,g_mhbc_m.mhbc000,g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbc003, 
          g_mhbc_m.mhbc004,g_mhbc_m.mhbc005,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009, 
          g_mhbc_m.mhbc010,g_mhbc_m.mhbc017,g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc014, 
          g_mhbc_m.mhbc015,g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid,g_mhbc_m.mhbcowndp, 
          g_mhbc_m.mhbccrtid,g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmoddt, 
          g_mhbc_m.mhbccnfid,g_mhbc_m.mhbccnfdt,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004_desc, 
          g_mhbc_m.mhbc005_desc,g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017_desc,g_mhbc_m.mhbc013_desc, 
          g_mhbc_m.mhbc014_desc,g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid_desc, 
          g_mhbc_m.mhbccrtdp_desc,g_mhbc_m.mhbcmodid_desc,g_mhbc_m.mhbccnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mhbc_m.mhbcsite,g_mhbc_m.mhbcsite_desc,g_mhbc_m.mhbcdocdt,g_mhbc_m.mhbcdocno, 
          g_mhbc_m.mhbc000,g_mhbc_m.mhbc016,g_mhbc_m.mhbc001,g_mhbc_m.mhbc002,g_mhbc_m.mhbcl003,g_mhbc_m.mhbcl004, 
          g_mhbc_m.mhbc003,g_mhbc_m.mhbc003_desc,g_mhbc_m.mhbc004,g_mhbc_m.mhbc004_desc,g_mhbc_m.mhbc005, 
          g_mhbc_m.mhbc005_desc,g_mhbc_m.mhbc006,g_mhbc_m.mhbc007,g_mhbc_m.mhbc008,g_mhbc_m.mhbc009, 
          g_mhbc_m.mhbc009_desc,g_mhbc_m.mhbc010,g_mhbc_m.mhbc010_desc,g_mhbc_m.mhbc017,g_mhbc_m.mhbc017_desc, 
          g_mhbc_m.mhbc011,g_mhbc_m.mhbc012,g_mhbc_m.mhbc013,g_mhbc_m.mhbc013_desc,g_mhbc_m.mhbc014, 
          g_mhbc_m.mhbc014_desc,g_mhbc_m.mhbc015,g_mhbc_m.mhbcunit,g_mhbc_m.mhbcstus,g_mhbc_m.mhbcownid, 
          g_mhbc_m.mhbcownid_desc,g_mhbc_m.mhbcowndp,g_mhbc_m.mhbcowndp_desc,g_mhbc_m.mhbccrtid,g_mhbc_m.mhbccrtid_desc, 
          g_mhbc_m.mhbccrtdp,g_mhbc_m.mhbccrtdp_desc,g_mhbc_m.mhbccrtdt,g_mhbc_m.mhbcmodid,g_mhbc_m.mhbcmodid_desc, 
          g_mhbc_m.mhbcmoddt,g_mhbc_m.mhbccnfid,g_mhbc_m.mhbccnfid_desc,g_mhbc_m.mhbccnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE amht205_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amht205_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amht205.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amht205_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mhbd_d.getLength() THEN
         LET g_detail_idx = g_mhbd_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mhbd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mhbd_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amht205.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amht205_b_fill2(pi_idx)
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
   
   CALL amht205_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="amht205.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amht205_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amht205.status_show" >}
PRIVATE FUNCTION amht205_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amht205.mask_functions" >}
&include "erp/amh/amht205_mask.4gl"
 
{</section>}
 
{<section id="amht205.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION amht205_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL amht205_show()
   CALL amht205_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mhbc_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mhbd_d))
 
 
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
   #CALL amht205_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL amht205_ui_headershow()
   CALL amht205_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION amht205_draw_out()
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
   CALL amht205_ui_headershow()  
   CALL amht205_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="amht205.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amht205_set_pk_array()
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
   LET g_pk_array[1].values = g_mhbc_m.mhbcdocno
   LET g_pk_array[1].column = 'mhbcdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amht205.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="amht205.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amht205_msgcentre_notify(lc_state)
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
   CALL amht205_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mhbc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amht205.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION amht205_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#20 add-S
   SELECT mhbcstus  INTO g_mhbc_m.mhbcstus
     FROM mhbc_t
    WHERE mhbcent = g_enterprise
      AND mhbcdocno = g_mhbc_m.mhbcdocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mhbc_m.mhbcstus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_mhbc_m.mhbcdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amht205_set_act_visible()
        CALL amht205_set_act_no_visible()
        CALL amht205_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#20 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amht205.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取部門
# Memo...........:
# Usage..........: CALL amht205_mhbc013_def(p_ooag001)
#                  RETURNING  r_ooag003
# Input parameter: p_ooag001      員工編號
# Return code....: r_ooag003      部門編號
# Date & Author..: 20160307 By s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION amht205_mhbc013_def(p_ooag001)
DEFINE p_ooag001        LIKE ooag_t.ooag001
DEFINE r_ooag003        LIKE ooag_t.ooag003

   WHENEVER ERROR CONTINUE

   LET r_ooag003 = ''
   SELECT ooag003 INTO r_ooag003
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = p_ooag001

   RETURN r_ooag003
END FUNCTION

################################################################################
# Descriptions...: 鋪位編號帶值
# Memo...........:
# Usage..........: CALL amht205_mhbc001_ref(p_mhbc001)
# Input parameter: p_mhbc001
# Date & Author..: 20160307 By s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION amht205_mhbc001_ref(p_mhbc001)
DEFINE p_mhbc001     LIKE mhbc_t.mhbc001 
DEFINE l_mhbc        RECORD  
       mhbel003      LIKE mhbel_t.mhbel003,
       mhbel004      LIKE mhbel_t.mhbel004,
       mhbc002       LIKE mhbc_t.mhbc002, 
       mhbc003       LIKE mhbc_t.mhbc003,
       mhbc003_desc  LIKE mhaal_t.mhaal003,
       mhbc004       LIKE mhbc_t.mhbc004,
       mhbc004_desc  LIKE mhabl_t.mhabl004,
       mhbc005       LIKE mhbc_t.mhbc005,
       mhbc005_desc  LIKE mhacl_t.mhacl005,
       mhbc006       LIKE mhbc_t.mhbc006,
       mhbc007       LIKE mhbc_t.mhbc007,
       mhbc008       LIKE mhbc_t.mhbc008,
       mhbc009       LIKE mhbc_t.mhbc009,
       mhbc010       LIKE mhbc_t.mhbc010,
       mhbc011       LIKE mhbc_t.mhbc011,
       mhbc012       LIKE mhbc_t.mhbc012,
       mhbc015       LIKE mhbc_t.mhbc015,
       mhbc017       LIKE mhbc_t.mhbc017   #160506-00009#4 Add By Ken 160506
                     END RECORD 
                     
  WHENEVER ERROR CONTINUE
    
  INITIALIZE l_mhbc.* TO NULL
  #鋪位名稱/助記碼
  SELECT mhbel003,mhbel004 INTO l_mhbc.mhbel003,l_mhbc.mhbel004
    FROM mhbel_t
   WHERE mhbelent= g_enterprise
     AND mhbel001 = p_mhbc001
     AND mhbel002 = g_lang
  
  SELECT mhbe002,mhbe003,mhbe004,mhbe005,mhbe006,mhbe007,mhbe008,mhbe009,mhbe010,mhbe011,mhbe012,mhbe015,mhbe017  #160506-00009#4 Add By Ken 160506 新增mhbe017
    INTO l_mhbc.mhbc002,l_mhbc.mhbc003,l_mhbc.mhbc004,l_mhbc.mhbc005,l_mhbc.mhbc006,l_mhbc.mhbc007,
         l_mhbc.mhbc008,l_mhbc.mhbc009,l_mhbc.mhbc010,l_mhbc.mhbc011,l_mhbc.mhbc012,l_mhbc.mhbc015,
         l_mhbc.mhbc017         #160506-00009#4 Add By Ken 160506 新增mhbc017
    FROM mhbe_t
   WHERE mhbeent = g_enterprise
     AND mhbe001 = p_mhbc001   
  #樓棟說明
  IF NOT cl_null(l_mhbc.mhbc003) THEN
    SELECT mhaal003 INTO l_mhbc.mhbc003_desc
      FROM mhaal_t
     WHERE mhaalent = g_enterprise
       AND mhaal001 = l_mhbc.mhbc003
       AND mhaal002 = g_lang
  END IF
  #樓層說明
  IF NOT cl_null(l_mhbc.mhbc004) THEN
     SELECT mhabl004 INTO l_mhbc.mhbc004_desc
      FROM mhabl_t
     WHERE mhablent = g_enterprise
       AND mhabl001 = l_mhbc.mhbc003
       AND mhabl002 = l_mhbc.mhbc004
       AND mhabl003 = g_lang
  END IF 
  #區域說明
  IF NOT cl_null(l_mhbc.mhbc005) THEN
     SELECT mhacl005 INTO l_mhbc.mhbc005_desc
      FROM mhacl_t
     WHERE mhaclent = g_enterprise
       AND mhacl001 = l_mhbc.mhbc003
       AND mhacl002 = l_mhbc.mhbc004
       AND mhacl003 = l_mhbc.mhbc005
       AND mhacl004 = g_lang
  END IF 
    
  #鋪位版本+1
  IF NOT cl_null(l_mhbc.mhbc002) THEN 
     LET l_mhbc.mhbc002 = l_mhbc.mhbc002+1
  END IF  
  
 
  LET g_mhbc_m.mhbc002 = l_mhbc.mhbc002
  LET g_mhbc_m.mhbc003 = l_mhbc.mhbc003
  LET g_mhbc_m.mhbc004 = l_mhbc.mhbc004
  LET g_mhbc_m.mhbc005 = l_mhbc.mhbc005
  LET g_mhbc_m.mhbc006 = l_mhbc.mhbc006
  LET g_mhbc_m.mhbc007 = l_mhbc.mhbc007
  LET g_mhbc_m.mhbc008 = l_mhbc.mhbc008
  LET g_mhbc_m.mhbc009 = l_mhbc.mhbc009
  LET g_mhbc_m.mhbc010 = l_mhbc.mhbc010
  LET g_mhbc_m.mhbc011 = l_mhbc.mhbc011
  LET g_mhbc_m.mhbc012 = l_mhbc.mhbc012
  LET g_mhbc_m.mhbc015 = l_mhbc.mhbc015
  LET g_mhbc_m.mhbc017 = l_mhbc.mhbc017    #160506-00009#4 Add By Ken 160506 新增mhbc017
  LET g_mhbc_m.mhbcl003 = l_mhbc.mhbel003 
  LET g_mhbc_m.mhbcl004 = l_mhbc.mhbel004
  LET g_mhbc_m.mhbc003_desc = l_mhbc.mhbc003_desc
  LET g_mhbc_m.mhbc004_desc = l_mhbc.mhbc004_desc 
  LET g_mhbc_m.mhbc005_desc = l_mhbc.mhbc005_desc 
  
  LET g_mhbc_m.mhbc017_desc = ''  #add by geza 20160615
  #160506-00009#4 Add By Ken 160506(S)
  IF NOT cl_null(l_mhbc.mhbc017) THEN
     CALL s_desc_get_acc_desc('2145',g_mhbc_m.mhbc017) RETURNING g_mhbc_m.mhbc017_desc
     DISPLAY BY NAME g_mhbc_m.mhbc017_desc  
  END IF  
  #160506-00009#4 Add By Ken 160506(E)
  
END FUNCTION

################################################################################
# Descriptions...: 鋪位編號校驗
# Memo...........:
# Usage..........: CALL amht205_mhbc001_chk(p_mhbc001)
#                  RETURNING r_success
# Input parameter: p_mhbc001
# Return code....: r_success
# Date & Author..: 20160307 By s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION amht205_mhbc001_chk(p_mhbc001)
DEFINE p_mhbc001   LIKE mhbc_t.mhbc001
DEFINE r_success   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_mhbesite  LIKE mhbe_t.mhbesite   #160604-00009#109 160627 by sakura add

   LET r_success = TRUE
   LET l_success = ''
   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt
     FROM mhbc_t
    WHERE mhbcstus = 'N'
      AND mhbcent = g_enterprise
      AND mhbc001 = p_mhbc001
   #鋪位申請作業中，已存在鋪位編號為%1的未確認單據
   IF l_cnt > 0 THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = "amh-00629"
     LET g_errparam.popup = TRUE
     LET g_errparam.replace[1] = p_mhbc001
     CALL cl_err()
     LET r_success = FALSE
     RETURN r_success
   END IF
   
   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt
     FROM mhbe_t
    WHERE mhbeent = g_enterprise
      AND mhbe001 = p_mhbc001
   #鋪位編號%1不存在於舖位基本資料檔中
   IF l_cnt = 0 THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = "amh-00630"
     LET g_errparam.popup = TRUE
     LET g_errparam.replace[1] = p_mhbc001
     CALL cl_err()
     LET r_success = FALSE
     RETURN r_success
   END IF

   #160604-00009#109 160627 by sakura add(S)
   LET l_mhbesite = ''
   SELECT mhbesite INTO l_mhbesite
     FROM mhbe_t
    WHERE mhbeent = g_enterprise
      AND mhbe001 = p_mhbc001
   IF l_mhbesite <> g_mhbc_m.mhbcsite THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = "amh-00669"
     LET g_errparam.popup = TRUE
     LET g_errparam.replace[1] = p_mhbc001
     LET g_errparam.replace[2] = l_mhbesite
     LET g_errparam.replace[3] = g_mhbc_m.mhbcsite
     CALL cl_err()
     LET r_success = FALSE
     RETURN r_success      
   END IF
   #160604-00009#109 160627 by sakura add(E)
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION amht205_mhbc003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbc_m.mhbc003
   CALL ap_ref_array2(g_ref_fields,"SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbc_m.mhbc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbc_m.mhbc003_desc
END FUNCTION

PRIVATE FUNCTION amht205_mhbc004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbc_m.mhbc003
   LET g_ref_fields[2] = g_mhbc_m.mhbc004
   CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbc_m.mhbc004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbc_m.mhbc004_desc
END FUNCTION

PRIVATE FUNCTION amht205_mhbc005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbc_m.mhbc003
   LET g_ref_fields[2] = g_mhbc_m.mhbc004
   LET g_ref_fields[3] = g_mhbc_m.mhbc005
   CALL ap_ref_array2(g_ref_fields,"SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND mhacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbc_m.mhbc005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbc_m.mhbc005_desc
END FUNCTION

 
{</section>}
 
