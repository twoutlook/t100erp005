#該程式未解開Section, 採用最新樣板產出!
{<section id="aint911.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0022(2016-07-29 14:09:19), PR版次:0022(2017-02-20 15:29:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000117
#+ Filename...: aint911
#+ Description: 雜項庫存領用維護作業
#+ Creator....: 02749(2015-02-13 08:16:02)
#+ Modifier...: 06814 -SD/PR- 01996
 
{</section>}
 
{<section id="aint911.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151224-00025#2    15/12/25 By catmoon 手動輸入特徵碼同步新增inam_t[料件產品特徵明細檔]
#151125-00007#1    16/01/08 By sakura  增加串查
#160314-00009#3    16/03/16 By zhujing 各程式增加产品特征是否需要自动开窗的程式段处理
#160318-00025#20   16/04/15 BY 07900   校验代码重复错误讯息的修改
#160812-00017#2    16/08/15 By 06814   在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160816-00001#6    16/08/17 By 08742   抓取理由碼改CALL sub
#160818-00017#18   16/08/24 By lixh    单据类作业修改，删除时需重新检查状态
#160711-00040#15   17/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1

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
PRIVATE type type_g_inba_m        RECORD
       inba001 LIKE inba_t.inba001, 
   inbasite LIKE inba_t.inbasite, 
   inbasite_desc LIKE type_t.chr80, 
   inbadocdt LIKE inba_t.inbadocdt, 
   inbadocno LIKE inba_t.inbadocno, 
   inba002 LIKE inba_t.inba002, 
   inba012 LIKE inba_t.inba012, 
   inba014 LIKE inba_t.inba014, 
   inba003 LIKE inba_t.inba003, 
   inba003_desc LIKE type_t.chr80, 
   inba004 LIKE inba_t.inba004, 
   inba004_desc LIKE type_t.chr80, 
   inba013 LIKE inba_t.inba013, 
   inba013_desc LIKE type_t.chr80, 
   inbaunit LIKE inba_t.inbaunit, 
   inbastus LIKE inba_t.inbastus, 
   inba005 LIKE inba_t.inba005, 
   inba006 LIKE inba_t.inba006, 
   inba015 LIKE inba_t.inba015, 
   inba015_desc LIKE type_t.chr80, 
   inba203 LIKE inba_t.inba203, 
   inba203_desc LIKE type_t.chr80, 
   inba205 LIKE inba_t.inba205, 
   inba205_desc LIKE type_t.chr80, 
   inba208 LIKE inba_t.inba208, 
   inba206 LIKE inba_t.inba206, 
   inba206_desc LIKE type_t.chr80, 
   inba207 LIKE inba_t.inba207, 
   inba207_desc LIKE type_t.chr80, 
   inba204 LIKE inba_t.inba204, 
   inba204_desc LIKE type_t.chr80, 
   inba007 LIKE inba_t.inba007, 
   inba007_desc LIKE type_t.chr80, 
   inba008 LIKE inba_t.inba008, 
   inbaownid LIKE inba_t.inbaownid, 
   inbaownid_desc LIKE type_t.chr80, 
   inbaowndp LIKE inba_t.inbaowndp, 
   inbaowndp_desc LIKE type_t.chr80, 
   inbacrtid LIKE inba_t.inbacrtid, 
   inbacrtid_desc LIKE type_t.chr80, 
   inbacrtdp LIKE inba_t.inbacrtdp, 
   inbacrtdp_desc LIKE type_t.chr80, 
   inbacrtdt LIKE inba_t.inbacrtdt, 
   inbamodid LIKE inba_t.inbamodid, 
   inbamodid_desc LIKE type_t.chr80, 
   inbamoddt LIKE inba_t.inbamoddt, 
   inbacnfid LIKE inba_t.inbacnfid, 
   inbacnfid_desc LIKE type_t.chr80, 
   inbacnfdt LIKE inba_t.inbacnfdt, 
   inbapstid LIKE inba_t.inbapstid, 
   inbapstid_desc LIKE type_t.chr80, 
   inbapstdt LIKE inba_t.inbapstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_inbb_d        RECORD
       inbbseq LIKE inbb_t.inbbseq, 
   inbb017 LIKE inbb_t.inbb017, 
   inbb211 LIKE inbb_t.inbb211, 
   inbb212 LIKE inbb_t.inbb212, 
   inbb200 LIKE inbb_t.inbb200, 
   inbb001 LIKE inbb_t.inbb001, 
   inbb001_desc LIKE type_t.chr500, 
   inbb001_desc_desc LIKE type_t.chr500, 
   inbb002 LIKE inbb_t.inbb002, 
   inbb002_desc LIKE type_t.chr500, 
   inbb213 LIKE inbb_t.inbb213, 
   inbb214 LIKE inbb_t.inbb214, 
   inbb214_desc LIKE type_t.chr500, 
   inbb214_desc_desc LIKE type_t.chr500, 
   inbb215 LIKE inbb_t.inbb215, 
   inbb215_desc LIKE type_t.chr500, 
   inbb007 LIKE inbb_t.inbb007, 
   inbb007_desc LIKE type_t.chr500, 
   inbb008 LIKE inbb_t.inbb008, 
   inbb008_desc LIKE type_t.chr500, 
   inbb009 LIKE inbb_t.inbb009, 
   inbb210 LIKE inbb_t.inbb210, 
   inbb003 LIKE inbb_t.inbb003, 
   inbb220 LIKE inbb_t.inbb220, 
   inbb220_desc LIKE type_t.chr500, 
   inbb221 LIKE inbb_t.inbb221, 
   inbb221_desc LIKE type_t.chr500, 
   inbb222 LIKE inbb_t.inbb222, 
   inbb223 LIKE inbb_t.inbb223, 
   inbb201 LIKE inbb_t.inbb201, 
   inbb201_desc LIKE type_t.chr500, 
   inbb202 LIKE inbb_t.inbb202, 
   inbb203 LIKE inbb_t.inbb203, 
   inbb011 LIKE inbb_t.inbb011, 
   inbb012 LIKE inbb_t.inbb012, 
   inbb010 LIKE inbb_t.inbb010, 
   inbb010_desc LIKE type_t.chr500, 
   inbb218 LIKE inbb_t.inbb218, 
   inbb218_desc LIKE type_t.chr500, 
   inbb219 LIKE inbb_t.inbb219, 
   inbb216 LIKE inbb_t.inbb216, 
   inbb216_desc LIKE type_t.chr500, 
   inbb217 LIKE inbb_t.inbb217, 
   inbb224 LIKE inbb_t.inbb224, 
   inbb224_desc LIKE type_t.chr500, 
   inbb225 LIKE inbb_t.inbb225, 
   inbb209 LIKE inbb_t.inbb209, 
   inbb209_desc LIKE type_t.chr500, 
   inbb207 LIKE inbb_t.inbb207, 
   inbb208 LIKE inbb_t.inbb208, 
   inbb205 LIKE inbb_t.inbb205, 
   inbb206 LIKE inbb_t.inbb206, 
   inbb016 LIKE inbb_t.inbb016, 
   inbb016_desc LIKE type_t.chr500, 
   inbb018 LIKE inbb_t.inbb018, 
   inbb0171 LIKE type_t.chr20, 
   inbb020 LIKE inbb_t.inbb020, 
   inbb204 LIKE inbb_t.inbb204, 
   inbb022 LIKE inbb_t.inbb022, 
   inbb021 LIKE inbb_t.inbb021, 
   inbbsite LIKE inbb_t.inbbsite, 
   inbbunit LIKE inbb_t.inbbunit
       END RECORD
PRIVATE TYPE type_g_inbb2_d RECORD
       inbcseq LIKE inbc_t.inbcseq, 
   inbcseq1 LIKE inbc_t.inbcseq1, 
   inbc209 LIKE inbc_t.inbc209, 
   inbc210 LIKE inbc_t.inbc210, 
   inbc200 LIKE inbc_t.inbc200, 
   inbc001 LIKE inbc_t.inbc001, 
   inbc001_desc LIKE type_t.chr500, 
   inbc001_desc_desc LIKE type_t.chr500, 
   inbc002 LIKE inbc_t.inbc002, 
   inbc002_desc LIKE type_t.chr500, 
   inbc005 LIKE inbc_t.inbc005, 
   inbc005_desc LIKE type_t.chr500, 
   inbc006 LIKE inbc_t.inbc006, 
   inbc006_desc LIKE type_t.chr500, 
   inbc007 LIKE inbc_t.inbc007, 
   inbc003 LIKE inbc_t.inbc003, 
   inbc201 LIKE inbc_t.inbc201, 
   inbc201_desc LIKE type_t.chr500, 
   inbc202 LIKE inbc_t.inbc202, 
   inbc009 LIKE inbc_t.inbc009, 
   inbc009_desc LIKE type_t.chr500, 
   inbc010 LIKE inbc_t.inbc010, 
   inbc211 LIKE inbc_t.inbc211, 
   inbc211_desc LIKE type_t.chr500, 
   inbc212 LIKE inbc_t.inbc212, 
   inbc208 LIKE inbc_t.inbc208, 
   inbc208_desc LIKE type_t.chr500, 
   inbc206 LIKE inbc_t.inbc206, 
   inbc207 LIKE inbc_t.inbc207, 
   inbc204 LIKE inbc_t.inbc204, 
   inbc205 LIKE inbc_t.inbc205, 
   inbc011 LIKE inbc_t.inbc011, 
   inbc011_desc LIKE type_t.chr500, 
   inbc015 LIKE inbc_t.inbc015, 
   inbc203 LIKE inbc_t.inbc203, 
   inbc016 LIKE inbc_t.inbc016, 
   inbc017 LIKE inbc_t.inbc017, 
   inbcsite LIKE inbc_t.inbcsite, 
   inbcunit LIKE inbc_t.inbcunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_inbadocno LIKE inba_t.inbadocno,
      b_inbadocdt LIKE inba_t.inbadocdt,
      b_inba002 LIKE inba_t.inba002,
      b_inba003 LIKE inba_t.inba003,
   b_inba003_desc LIKE type_t.chr80,
      b_inba004 LIKE inba_t.inba004,
   b_inba004_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ins_site_flag       LIKE type_t.chr1
DEFINE g_site_str            STRING
DEFINE g_inba007_acc         LIKE gzcb_t.gzcb004
DEFINE g_num_para            LIKE type_t.chr10      #數量控制參數
DEFINE g_pick_para           LIKE type_t.chr10      #在撿量參數
DEFINE g_slip                LIKE ooca_t.ooca002    #單別
DEFINE g_sys                 LIKE type_t.num5       #管理品類層級  #151113-00020#1 151117 By pomelo add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_inba_m          type_g_inba_m
DEFINE g_inba_m_t        type_g_inba_m
DEFINE g_inba_m_o        type_g_inba_m
DEFINE g_inba_m_mask_o   type_g_inba_m #轉換遮罩前資料
DEFINE g_inba_m_mask_n   type_g_inba_m #轉換遮罩後資料
 
   DEFINE g_inbadocno_t LIKE inba_t.inbadocno
 
 
DEFINE g_inbb_d          DYNAMIC ARRAY OF type_g_inbb_d
DEFINE g_inbb_d_t        type_g_inbb_d
DEFINE g_inbb_d_o        type_g_inbb_d
DEFINE g_inbb_d_mask_o   DYNAMIC ARRAY OF type_g_inbb_d #轉換遮罩前資料
DEFINE g_inbb_d_mask_n   DYNAMIC ARRAY OF type_g_inbb_d #轉換遮罩後資料
DEFINE g_inbb2_d          DYNAMIC ARRAY OF type_g_inbb2_d
DEFINE g_inbb2_d_t        type_g_inbb2_d
DEFINE g_inbb2_d_o        type_g_inbb2_d
DEFINE g_inbb2_d_mask_o   DYNAMIC ARRAY OF type_g_inbb2_d #轉換遮罩前資料
DEFINE g_inbb2_d_mask_n   DYNAMIC ARRAY OF type_g_inbb2_d #轉換遮罩後資料
 
 
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
#argv[1]   type_t.chr10   #作業類型
#end add-point
 
{</section>}
 
{<section id="aint911.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   LET g_site_str = 'inbasite'
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
   LET g_inba007_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位二]的欄位值
   #SELECT gzcb004 INTO g_inba007_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog   #160816-00001#6 mark 
   LET g_inba007_acc = s_fin_get_scc_value('24',g_prog,'2')  #160816-00001#6  Add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT inba001,inbasite,'',inbadocdt,inbadocno,inba002,inba012,inba014,inba003, 
       '',inba004,'',inba013,'',inbaunit,inbastus,inba005,inba006,inba015,'',inba203,'',inba205,'',inba208, 
       inba206,'',inba207,'',inba204,'',inba007,'',inba008,inbaownid,'',inbaowndp,'',inbacrtid,'',inbacrtdp, 
       '',inbacrtdt,inbamodid,'',inbamoddt,inbacnfid,'',inbacnfdt,inbapstid,'',inbapstdt", 
                      " FROM inba_t",
                      " WHERE inbaent= ? AND inbadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint911_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.inba001,t0.inbasite,t0.inbadocdt,t0.inbadocno,t0.inba002,t0.inba012, 
       t0.inba014,t0.inba003,t0.inba004,t0.inba013,t0.inbaunit,t0.inbastus,t0.inba005,t0.inba006,t0.inba015, 
       t0.inba203,t0.inba205,t0.inba208,t0.inba206,t0.inba207,t0.inba204,t0.inba007,t0.inba008,t0.inbaownid, 
       t0.inbaowndp,t0.inbacrtid,t0.inbacrtdp,t0.inbacrtdt,t0.inbamodid,t0.inbamoddt,t0.inbacnfid,t0.inbacnfdt, 
       t0.inbapstid,t0.inbapstdt,t2.ooag011 ,t3.ooefl003 ,t4.inayl003 ,t5.rtaxl003 ,t6.ooefl003 ,t7.inayl003 , 
       t8.rtaxl003 ,t9.pmaal004 ,t10.ooag011 ,t11.ooefl003 ,t12.ooag011 ,t13.ooefl003 ,t14.ooag011 , 
       t15.ooag011 ,t16.ooag011",
               " FROM inba_t t0",
                              " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.inba003  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inba004 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t4 ON t4.inaylent="||g_enterprise||" AND t4.inayl001=t0.inba015 AND t4.inayl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t5 ON t5.rtaxlent="||g_enterprise||" AND t5.rtaxl001=t0.inba203 AND t5.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.inba205 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent="||g_enterprise||" AND t7.inayl001=t0.inba206 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t8 ON t8.rtaxlent="||g_enterprise||" AND t8.rtaxl001=t0.inba207 AND t8.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t9 ON t9.pmaalent="||g_enterprise||" AND t9.pmaal001=t0.inba204 AND t9.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.inbaownid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.inbaowndp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.inbacrtid  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=t0.inbacrtdp AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.inbamodid  ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.inbacnfid  ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.inbapstid  ",
 
               " WHERE t0.inbaent = " ||g_enterprise|| " AND t0.inbadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aint911_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint911 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint911_init()   
 
      #進入選單 Menu (="N")
      CALL aint911_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint911
      
   END IF 
   
   CLOSE aint911_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori add
   CALL s_lot_auto_drop_tmp(g_prog)                 #150427-00001#6 150522 By pomelo add
   CALL s_aooi390_drop_tmp_table()                  #150601-00009#5 1500602 by lori add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint911.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint911_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori add 
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
      CALL cl_set_combo_scc_part('inbastus','13','N,S,Y,A,D,R,W,Z,X')
 
      CALL cl_set_combo_scc('inba012','6834') 
   CALL cl_set_combo_scc('inba005','2051') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success                #150308-00001#4 150309 by lori add
   LET g_errshow = 1                                               #校驗訊息彈窗
   
   IF g_argv[1] = '1' THEN
      CALL cl_set_combo_scc_part('inba005','2051','1,2,3,4,5,6,9')           #150415-00006#1 150506 by lori mod 新增顯示 9.   #150629-00016#1 150716 by lori mod 依參數設定顯示
      CALL cl_set_comp_visible("inbb021,inbb204,inbb022",FALSE)              #150507-00001#8 150527 by lori add inbb204
      CALL cl_set_comp_visible("inbc016,inbc203,inbc017",FALSE)              #150507-00001#8 150527 by lori add inbc203
      CALL cl_set_comp_visible("inbb211,inbb212,inbc209,inbc210",FALSE)      #150629-00016#1 150716 by lori add  
   ELSE                                                                      #150629-00016#1 150716 by lori add 
      CALL cl_set_combo_scc_part('inba005','2051','1,2,3,4,5,6,9,11,13')        #150629-00016#1 150716 by lori add 依參數設定顯示 #151130-00008#11 160120 By pomelo add 13
   END IF
   
   CALL aint911_set_act_visible()
   CALL aint911_set_act_no_visible()
   #20160108 add by beckxie---S
   CALL aint911_set_comp_visible_b()
   CALL aint911_set_comp_no_visible_b()
   #20160108 add by beckxie---E
   
   LET l_success = ''                                        #150427-00001#6 150522 By pomelo add
   CALL s_lot_auto_create_tmp(g_prog) RETURNING l_success    #150427-00001#6 150522 By pomelo add
   
   LET l_success = ''                                        #150601-00009#5 1500602 by lori mod
   CALL s_aooi390_cre_tmp_table() RETURNING l_success        #150601-00009#5 1500602 by lori mod
   
   #151113-00020#1 151116 By pomelo add(S)
   #管理品類參數
   LET g_sys = cl_get_para(g_enterprise,"","E-CIR-0001")
   
   #供應商
   IF g_argv[1] MATCHES '[1235678]' THEN
      CALL cl_set_comp_visible("inba204",FALSE)
      CALL cl_set_comp_visible("inba204_desc",FALSE)
   END IF
  
   #部門
   #IF g_argv[1] MATCHES '[1234789]' THEN        #160604-00009#112 Mark By Ken 160628 
   IF g_argv[1] MATCHES '[123478]' THEN          #160604-00009#112 Add By Ken 160628   aint919也顯示部門
      CALL cl_set_comp_visible("inba205",FALSE)
      CALL cl_set_comp_visible("inba205_desc",FALSE)
   END IF
   
   #返回
   IF g_argv[1] MATCHES '[12789]' THEN
      CALL cl_set_comp_visible("inba208",FALSE)
   END IF
   
   #轉入庫位、轉入管理品類
   #轉入商品條碼、轉入商品編號
   IF g_argv[1] MATCHES '[1234569]' THEN
      CALL cl_set_comp_visible("inba206",FALSE)
      CALL cl_set_comp_visible("inba206_desc",FALSE)
      CALL cl_set_comp_visible("inba207",FALSE)
      CALL cl_set_comp_visible("inba207_desc",FALSE)
      CALL cl_set_comp_visible("inbb213",FALSE)
      CALL cl_set_comp_visible("inbb214",FALSE)
      CALL cl_set_comp_visible("inbb214_desc",FALSE)
      CALL cl_set_comp_visible("inbb214_desc_desc",FALSE)
      CALL cl_set_comp_visible("inbb215",FALSE)
      CALL cl_set_comp_visible("inbb215_desc",FALSE)
      CALL cl_set_comp_visible("inbb216",FALSE)
      CALL cl_set_comp_visible("inbb216_desc",FALSE)
      CALL cl_set_comp_visible("inbb218",FALSE)
      CALL cl_set_comp_visible("inbb218_desc",FALSE)
      CALL cl_set_comp_visible("inbb217",FALSE)
      CALL cl_set_comp_visible("inbb219",FALSE)
      CALL cl_set_comp_visible("inbb220",FALSE)
      CALL cl_set_comp_visible("inbb220_desc",FALSE)
      CALL cl_set_comp_visible("inbb221",FALSE)
      CALL cl_set_comp_visible("inbb221_desc",FALSE)
      CALL cl_set_comp_visible("inbb222",FALSE)
      CALL cl_set_comp_visible("inbb223",FALSE)
      CALL cl_set_comp_visible("inbb0171",FALSE)
   ELSE
      CALL cl_set_comp_visible("inbb017",FALSE)
      CALL cl_set_comp_visible("inbb211",FALSE)
      CALL cl_set_comp_visible("inbb212",FALSE)
   END IF
   
   IF g_argv[1] = '8' THEN
      CALL cl_set_combo_scc_part('inba005','2051','1,2,3,4,5,6,9,11,12')
   END IF
   #151113-00020#1 151116 By pomelo add(E)
   #160314-00009#3 zhujing add 2016-3-16---(S)
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("inbb002,inbb002_desc",FALSE)
   END IF
   #160314-00009#3 zhujing add 2016-3-16---(E)
   #end add-point
   
   #初始化搜尋條件
   CALL aint911_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aint911.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aint911_ui_dialog()
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
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_doc      LIKE stba_t.stbadocno     #150827-00013#1 150827 by lori add
   DEFINE l_inqa000  LIKE inqa_t.inqa000       #151125-00007#1
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
            CALL aint911_insert()
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
         INITIALIZE g_inba_m.* TO NULL
         CALL g_inbb_d.clear()
         CALL g_inbb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aint911_init()
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
               
               CALL aint911_fetch('') # reload data
               LET l_ac = 1
               CALL aint911_ui_detailshow() #Setting the current row 
         
               CALL aint911_idx_chk()
               #NEXT FIELD inbbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_inbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint911_idx_chk()
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
               CALL aint911_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               DISPLAY "page:",g_current_page
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_detail_memo
            LET g_action_choice="open_detail_memo"
            IF cl_auth_chk_act("open_detail_memo") THEN
               
               #add-point:ON ACTION open_detail_memo name="menu.detail_show.page1.open_detail_memo"
               IF NOT cl_null(g_inba_m.inbadocno)  THEN
                  CALL aooi360_01('7',g_inba_m.inbadocno,'','','','','','','','','')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  #151125-00007#1(S)
                  BEFORE MENU
                    IF g_detail_idx = 0 THEN
                       HIDE OPTION "prog_aint917"
                       EXIT MENU
                    ELSE
                       IF cl_null(g_inbb_d[g_detail_idx].inbb017) OR g_inba_m.inba001 MATCHES '[23456]' THEN
                          HIDE OPTION "prog_aint917"
                          EXIT MENU                       
                       END IF
                    END IF
                  #151125-00007#1(E)
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aint917
                  LET g_action_choice="prog_aint917"
                  IF cl_auth_chk_act("prog_aint917") THEN
                     
                     #add-point:ON ACTION prog_aint917 name="menu.detail_show.page1_sub.prog_aint917"
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     #151125-00007#1(S)                     
                     INITIALIZE la_param.* TO NULL
                     CASE
                       WHEN g_inba_m.inba001 = '1' #雜項庫存領用維護作業
                         CASE g_inba_m.inba005 
                           WHEN '5' #5:會員卡轉入
                             LET la_param.prog = 'ammt401'
                           WHEN '6' #6:券轉入
                             LET la_param.prog = 'agct401'
                           WHEN '9' #9:產品組合/拆解單轉入
                             SELECT inqa000 INTO l_inqa000
                               FROM inqa_t
                              WHERE inqaent = g_enterprise
                                AND inqadocno = g_inba_m.inba006
                             CASE l_inqa000
                                WHEN '1'   #aint950 
                                   LET la_param.prog = 'aint950'
                                WHEN '2'   #aint951
                                   LET la_param.prog = 'aint951'
                             END CASE
                           WHEN '11' #11:雜項請領單
                             LET la_param.prog = 'aint911'
                           OTHERWISE
                             EXIT DIALOG
                         END CASE
                       WHEN g_inba_m.inba001 = '7' #商品轉碼單維護作業
                         LET la_param.prog = 'aint918'
                       WHEN g_inba_m.inba001 = '8' #商品轉碼單入項維護作業
                         LET la_param.prog = 'aint917'                       
                     END CASE
                     LET la_param.param[1] = g_inbb_d[g_detail_idx].inbb017
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                     #151125-00007#1(E)                     
                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_inbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint911_idx_chk()
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
               CALL aint911_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               DISPLAY "page:",g_current_page
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
            CALL aint911_browser_fill("")
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
               CALL aint911_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aint911_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aint911_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            #151113-00020#1 151119 By pomelo add(S)
            CALL aint911_set_act_visible()
            CALL aint911_set_act_no_visible()
            #151113-00020#1 151119 By pomelo add(E)
            #20160108 add by beckxie---S
            CALL aint911_set_comp_visible_b()
            CALL aint911_set_comp_no_visible_b()
            #20160108 add by beckxie---E
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aint911_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aint911_set_act_visible()   
            CALL aint911_set_act_no_visible()
            IF NOT (g_inba_m.inbadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " inbaent = " ||g_enterprise|| " AND",
                                  " inbadocno = '", g_inba_m.inbadocno, "' "
 
               #填到對應位置
               CALL aint911_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "inba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inbb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inbc_t" 
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
               CALL aint911_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "inba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inbb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inbc_t" 
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
                  CALL aint911_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint911_fetch("F")
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
               CALL aint911_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aint911_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint911_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aint911_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint911_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aint911_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint911_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aint911_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint911_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aint911_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint911_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_inbb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_inbb2_d)
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
               NEXT FIELD inbbseq
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
               CALL aint911_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aint911_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aint911_01
            LET g_action_choice="open_aint911_01"
            IF cl_auth_chk_act("open_aint911_01") THEN
               
               #add-point:ON ACTION open_aint911_01 name="menu.open_aint911_01"
               IF NOT cl_null(g_inba_m.inbadocno) THEN
                  CALL aint911_01(g_argv[1],g_inba_m.inbadocno)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint911_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint911_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_memo
            LET g_action_choice="open_memo"
            IF cl_auth_chk_act("open_memo") THEN
               
               #add-point:ON ACTION open_memo name="menu.open_memo"
               IF NOT cl_null(g_inba_m.inbadocno) THEN
                  CALL aooi360_02('6',g_inba_m.inbadocno,'','','','','','','','','','4')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aint911_01_1
            LET g_action_choice="open_aint911_01_1"
            IF cl_auth_chk_act("open_aint911_01_1") THEN
               
               #add-point:ON ACTION open_aint911_01_1 name="menu.open_aint911_01_1"
               IF NOT cl_null(g_inba_m.inbadocno) THEN
                  CALL aint911_01(g_argv[1],g_inba_m.inbadocno)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = "inbaent = "|| g_enterprise ||" AND inbadocno = '"||g_inba_m.inbadocno||"'"    
               #END add-point
               &include "erp/ain/aint911_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = "inbaent = "|| g_enterprise ||" AND inbadocno = '"||g_inba_m.inbadocno||"'"    
               #END add-point
               &include "erp/ain/aint911_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aint911_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint911_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_astt322
            LET g_action_choice="gen_astt322"
            IF cl_auth_chk_act("gen_astt322") THEN
               
               #add-point:ON ACTION gen_astt322 name="menu.gen_astt322"
               #150629-00016#1  150716 by lori add---(S)
               IF cl_null(g_inba_m.inbadocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = "amm-00129"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF

               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM stba_t
                WHERE stbaent = g_enterprise
                  AND stba007 = g_inba_m.inbadocno
                  AND stbastus <> 'X'
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = "ain-00627"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               
               CALL s_transaction_begin()
               CALL cl_err_collect_init() 
               IF cl_ask_confirm('ain-00621') THEN
                  IF s_expense_aint911(g_inba_m.inbadocno) THEN
                     #150827-00013#1 150827 by lori add---(S)
                     LET l_doc = ''
                     SELECT stbadocno INTO l_doc 
                       FROM stba_t 
                      WHERE stbaent = g_enterprise
                        AND stba007 = g_inba_m.inbadocno 
                     #已產生交款單%1                        
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = "ast-00434"
                     LET g_errparam.replace[1] = l_doc
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #150827-00013#1 150827 by lori add---(E)
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')                  
                  END IF
               END IF
               CALL cl_err_collect_show()
               #150629-00016#1  150716 by lori add---(E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_expense
            LET g_action_choice="gen_expense"
            IF cl_auth_chk_act("gen_expense") THEN
               
               #add-point:ON ACTION gen_expense name="menu.gen_expense"
               #150629-00016#1  150716 by lori add---(S)
               IF cl_null(g_inba_m.inbadocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = "amm-00129"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF

               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM stba_t
                WHERE stbaent = g_enterprise
                  AND stba007 = g_inba_m.inbadocno
                  AND stbastus <> 'X'
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = "ain-00628"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF               
               CALL s_transaction_begin()
               CALL cl_err_collect_init() 
               IF cl_ask_confirm('ain-00620') THEN
                  IF s_expense_aint911(g_inba_m.inbadocno) THEN
                     #150827-00013#1 150827 by lori add---(S)
                     LET l_doc = ''
                     SELECT stbadocno INTO l_doc 
                       FROM stba_t 
                      WHERE stbaent = g_enterprise
                        AND stba007 = g_inba_m.inbadocno 
                        
                     INITIALIZE g_errparam TO NULL
                     CASE g_inba_m.inba012 
                        WHEN '1' 
                           #已產生專櫃費用單%1
                           LET g_errparam.code   = "ast-00432"
                        WHEN '2'
                           #已產生供應商費用單％1
                           LET g_errparam.code   = "ast-00433"                        
                     END CASE                        
                     LET g_errparam.replace[1] = l_doc
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #150827-00013#1 150827 by lori add---(E)                  
                     CALL s_transaction_end('Y','0')
                  ELSE
                     #151104-00002#2 151127 by lori add---(S)
                     INITIALIZE g_errparam TO NULL
                     
                     IF g_inba_m.inba014 = 'Y' THEN
                        #雜項領用/退回單(%1)產生交款單失敗！                
                        LET g_errparam.replace[1] = g_inba_m.inbadocno
                        LET g_errparam.code   = "ast-00513"
                     ELSE   
                        LET g_errparam.replace[1] = g_inba_m.inba013
                        LET g_errparam.replace[2] = g_inba_m.inbadocno
                        
                        CASE g_inba_m.inba012 
                           WHEN '1' 
                              #專櫃(%1)領用/退回單(%2)產生費用單失敗！
                              LET g_errparam.code   = "ast-00512"
                           WHEN '2'
                              #供應商(%1)領用/退回單(%2)產生費用單失敗！
                              LET g_errparam.code   = "ast-00511"                        
                        END CASE   
                     END IF
                     
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()      
                     #151104-00002#2 151127 by lori add---(E)
                  
                     CALL s_transaction_end('N','0')                  
                  END IF
               END IF
               CALL cl_err_collect_show()
               #150629-00016#1  150716 by lori add---(E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_inba003
            LET g_action_choice="prog_inba003"
            IF cl_auth_chk_act("prog_inba003") THEN
               
               #add-point:ON ACTION prog_inba003 name="menu.prog_inba003"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_inba_m.inba003)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_ammt401
            LET g_action_choice="prog_ammt401"
            IF cl_auth_chk_act("prog_ammt401") THEN
               
               #add-point:ON ACTION prog_ammt401 name="menu.prog_ammt401"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               CASE g_inba_m.inba005 
                 WHEN '5' #5:會員卡轉入
                   LET la_param.prog = 'ammt401'
                 WHEN '6' #6:券轉入
                   LET la_param.prog = 'agct401'
                 WHEN '9' #9:產品組合/拆解單轉入
                   SELECT inqa000 INTO l_inqa000
                     FROM inqa_t
                    WHERE inqaent = g_enterprise
                      AND inqadocno = g_inba_m.inba006
                   CASE l_inqa000
                      WHEN '1'   #aint950 
                         LET la_param.prog = 'aint950'
                      WHEN '2'   #aint951
                         LET la_param.prog = 'aint951'
                   END CASE
                 WHEN '11' #11:雜項請領單
                   LET la_param.prog = 'aint911'
                 OTHERWISE
                   EXIT DIALOG
               END CASE
               LET la_param.param[1] = g_inba_m.inba006
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint911_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint911_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint911_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_inba_m.inbadocdt)
 
 
 
         
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
 
{<section id="aint911.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aint911_browser_fill(ps_page_action)
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
   LET g_wc = g_wc, " AND inba001 = '",g_argv[01],"' "
   
   CALL s_aooi500_sql_where(g_prog,g_site_str) RETURNING l_where
   LET g_wc = g_wc, " AND ", l_where
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
      LET l_sub_sql = " SELECT DISTINCT inbadocno ",
                      " FROM inba_t ",
                      " ",
                      " LEFT JOIN inbb_t ON inbbent = inbaent AND inbadocno = inbbdocno ", "  ",
                      #add-point:browser_fill段sql(inbb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN inbc_t ON inbcent = inbaent AND inbadocno = inbcdocno", "  ",
                      #add-point:browser_fill段sql(inbc_t1) name="browser_fill.cnt.join.inbc_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE inbaent = " ||g_enterprise|| " AND inbbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("inba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT inbadocno ",
                      " FROM inba_t ", 
                      "  ",
                      "  ",
                      " WHERE inbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("inba_t")
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
      INITIALIZE g_inba_m.* TO NULL
      CALL g_inbb_d.clear()        
      CALL g_inbb2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.inbadocno,t0.inbadocdt,t0.inba002,t0.inba003,t0.inba004 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inbastus,t0.inbadocno,t0.inbadocdt,t0.inba002,t0.inba003,t0.inba004, 
          t1.ooag011 ,t2.ooefl003 ",
                  " FROM inba_t t0",
                  "  ",
                  "  LEFT JOIN inbb_t ON inbbent = inbaent AND inbadocno = inbbdocno ", "  ", 
                  #add-point:browser_fill段sql(inbb_t1) name="browser_fill.join.inbb_t1"
                  
                  #end add-point
                  "  LEFT JOIN inbc_t ON inbcent = inbaent AND inbadocno = inbcdocno", "  ", 
                  #add-point:browser_fill段sql(inbc_t1) name="browser_fill.join.inbc_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.inba003  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inba004 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.inbaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("inba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inbastus,t0.inbadocno,t0.inbadocdt,t0.inba002,t0.inba003,t0.inba004, 
          t1.ooag011 ,t2.ooefl003 ",
                  " FROM inba_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.inba003  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inba004 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.inbaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("inba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY inbadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"inba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_inbadocno,g_browser[g_cnt].b_inbadocdt, 
          g_browser[g_cnt].b_inba002,g_browser[g_cnt].b_inba003,g_browser[g_cnt].b_inba004,g_browser[g_cnt].b_inba003_desc, 
          g_browser[g_cnt].b_inba004_desc
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
         CALL aint911_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
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
   
   IF cl_null(g_browser[g_cnt].b_inbadocno) THEN
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
 
{<section id="aint911.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aint911_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_inba_m.inbadocno = g_browser[g_current_idx].b_inbadocno   
 
   EXECUTE aint911_master_referesh USING g_inba_m.inbadocno INTO g_inba_m.inba001,g_inba_m.inbasite, 
       g_inba_m.inbadocdt,g_inba_m.inbadocno,g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003, 
       g_inba_m.inba004,g_inba_m.inba013,g_inba_m.inbaunit,g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006, 
       g_inba_m.inba015,g_inba_m.inba203,g_inba_m.inba205,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba207, 
       g_inba_m.inba204,g_inba_m.inba007,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaowndp,g_inba_m.inbacrtid, 
       g_inba_m.inbacrtdp,g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
       g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstdt,g_inba_m.inba003_desc,g_inba_m.inba004_desc, 
       g_inba_m.inba015_desc,g_inba_m.inba203_desc,g_inba_m.inba205_desc,g_inba_m.inba206_desc,g_inba_m.inba207_desc, 
       g_inba_m.inba204_desc,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid_desc, 
       g_inba_m.inbacrtdp_desc,g_inba_m.inbamodid_desc,g_inba_m.inbacnfid_desc,g_inba_m.inbapstid_desc 
 
   
   CALL aint911_inba_t_mask()
   CALL aint911_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aint911.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aint911_ui_detailshow()
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
 
{<section id="aint911.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint911_ui_browser_refresh()
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
      IF g_browser[l_i].b_inbadocno = g_inba_m.inbadocno 
 
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
 
{<section id="aint911.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint911_construct()
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
   INITIALIZE g_inba_m.* TO NULL
   CALL g_inbb_d.clear()        
   CALL g_inbb2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON inba001,inbasite,inbadocdt,inbadocno,inba002,inba012,inba014,inba003, 
          inba004,inba013,inba013_desc,inbaunit,inbastus,inba005,inba006,inba015,inba203,inba205,inba208, 
          inba206,inba207,inba204,inba007,inba007_desc,inba008,inbaownid,inbaowndp,inbacrtid,inbacrtdp, 
          inbacrtdt,inbamodid,inbamoddt,inbacnfid,inbacnfdt,inbapstid,inbapstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<inbacrtdt>>----
         AFTER FIELD inbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<inbamoddt>>----
         AFTER FIELD inbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inbacnfdt>>----
         AFTER FIELD inbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inbapstdt>>----
         AFTER FIELD inbapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba001
            #add-point:BEFORE FIELD inba001 name="construct.b.inba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba001
            
            #add-point:AFTER FIELD inba001 name="construct.a.inba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba001
            #add-point:ON ACTION controlp INFIELD inba001 name="construct.c.inba001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbasite
            #add-point:ON ACTION controlp INFIELD inbasite name="construct.c.inbasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,g_site_str,g_site,'c')   #150308-00001#4 150309 by lori add 'c'
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbasite  #顯示到畫面上
            NEXT FIELD inbasite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbasite
            #add-point:BEFORE FIELD inbasite name="construct.b.inbasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbasite
            
            #add-point:AFTER FIELD inbasite name="construct.a.inbasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbadocdt
            #add-point:BEFORE FIELD inbadocdt name="construct.b.inbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbadocdt
            
            #add-point:AFTER FIELD inbadocdt name="construct.a.inbadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbadocdt
            #add-point:ON ACTION controlp INFIELD inbadocdt name="construct.c.inbadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbadocno
            #add-point:ON ACTION controlp INFIELD inbadocno name="construct.c.inbadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbadocno  #顯示到畫面上
            NEXT FIELD inbadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbadocno
            #add-point:BEFORE FIELD inbadocno name="construct.b.inbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbadocno
            
            #add-point:AFTER FIELD inbadocno name="construct.a.inbadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba002
            #add-point:BEFORE FIELD inba002 name="construct.b.inba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba002
            
            #add-point:AFTER FIELD inba002 name="construct.a.inba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba002
            #add-point:ON ACTION controlp INFIELD inba002 name="construct.c.inba002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba012
            #add-point:BEFORE FIELD inba012 name="construct.b.inba012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba012
            
            #add-point:AFTER FIELD inba012 name="construct.a.inba012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba012
            #add-point:ON ACTION controlp INFIELD inba012 name="construct.c.inba012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba014
            #add-point:BEFORE FIELD inba014 name="construct.b.inba014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba014
            
            #add-point:AFTER FIELD inba014 name="construct.a.inba014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba014
            #add-point:ON ACTION controlp INFIELD inba014 name="construct.c.inba014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba003
            #add-point:ON ACTION controlp INFIELD inba003 name="construct.c.inba003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                      
            DISPLAY g_qryparam.return1 TO inba003 
            NEXT FIELD inba003                   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba003
            #add-point:BEFORE FIELD inba003 name="construct.b.inba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba003
            
            #add-point:AFTER FIELD inba003 name="construct.a.inba003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba004
            #add-point:ON ACTION controlp INFIELD inba004 name="construct.c.inba004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                       
            DISPLAY g_qryparam.return1 TO inba004
            NEXT FIELD inba004                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba004
            #add-point:BEFORE FIELD inba004 name="construct.b.inba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba004
            
            #add-point:AFTER FIELD inba004 name="construct.a.inba004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba013
            #add-point:BEFORE FIELD inba013 name="construct.b.inba013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba013
            
            #add-point:AFTER FIELD inba013 name="construct.a.inba013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba013
            #add-point:ON ACTION controlp INFIELD inba013 name="construct.c.inba013"
            #150629-00016#1 150716 by lori---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_inba_m.inba013
            CALL q_inba013()                     
            DISPLAY g_qryparam.return1 TO inba013  
            NEXT FIELD inba013  
            #150629-00016#1 150716 by lori---(E)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba013_desc
            #add-point:BEFORE FIELD inba013_desc name="construct.b.inba013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba013_desc
            
            #add-point:AFTER FIELD inba013_desc name="construct.a.inba013_desc"
                   #返回原欄位
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba013_desc
            #add-point:ON ACTION controlp INFIELD inba013_desc name="construct.c.inba013_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbaunit
            #add-point:BEFORE FIELD inbaunit name="construct.b.inbaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbaunit
            
            #add-point:AFTER FIELD inbaunit name="construct.a.inbaunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbaunit
            #add-point:ON ACTION controlp INFIELD inbaunit name="construct.c.inbaunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbastus
            #add-point:BEFORE FIELD inbastus name="construct.b.inbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbastus
            
            #add-point:AFTER FIELD inbastus name="construct.a.inbastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbastus
            #add-point:ON ACTION controlp INFIELD inbastus name="construct.c.inbastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba005
            #add-point:BEFORE FIELD inba005 name="construct.b.inba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba005
            
            #add-point:AFTER FIELD inba005 name="construct.a.inba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba005
            #add-point:ON ACTION controlp INFIELD inba005 name="construct.c.inba005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba006
            #add-point:BEFORE FIELD inba006 name="construct.b.inba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba006
            
            #add-point:AFTER FIELD inba006 name="construct.a.inba006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba006
            #add-point:ON ACTION controlp INFIELD inba006 name="construct.c.inba006"
 
            #END add-point
 
 
         #Ctrlp:construct.c.inba015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba015
            #add-point:ON ACTION controlp INFIELD inba015 name="construct.c.inba015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inba015  #顯示到畫面上
            NEXT FIELD inba015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba015
            #add-point:BEFORE FIELD inba015 name="construct.b.inba015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba015
            
            #add-point:AFTER FIELD inba015 name="construct.a.inba015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba203
            #add-point:ON ACTION controlp INFIELD inba203 name="construct.c.inba203"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inba203  #顯示到畫面上
            NEXT FIELD inba203                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba203
            #add-point:BEFORE FIELD inba203 name="construct.b.inba203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba203
            
            #add-point:AFTER FIELD inba203 name="construct.a.inba203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba205
            #add-point:ON ACTION controlp INFIELD inba205 name="construct.c.inba205"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO inba205  #顯示到畫面上
            NEXT FIELD inba205                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba205
            #add-point:BEFORE FIELD inba205 name="construct.b.inba205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba205
            
            #add-point:AFTER FIELD inba205 name="construct.a.inba205"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba208
            #add-point:BEFORE FIELD inba208 name="construct.b.inba208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba208
            
            #add-point:AFTER FIELD inba208 name="construct.a.inba208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba208
            #add-point:ON ACTION controlp INFIELD inba208 name="construct.c.inba208"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inba206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba206
            #add-point:ON ACTION controlp INFIELD inba206 name="construct.c.inba206"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inba206  #顯示到畫面上
            NEXT FIELD inba206                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba206
            #add-point:BEFORE FIELD inba206 name="construct.b.inba206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba206
            
            #add-point:AFTER FIELD inba206 name="construct.a.inba206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba207
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba207
            #add-point:ON ACTION controlp INFIELD inba207 name="construct.c.inba207"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inba207  #顯示到畫面上
            NEXT FIELD inba207                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba207
            #add-point:BEFORE FIELD inba207 name="construct.b.inba207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba207
            
            #add-point:AFTER FIELD inba207 name="construct.a.inba207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba204
            #add-point:ON ACTION controlp INFIELD inba204 name="construct.c.inba204"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inba204  #顯示到畫面上
            NEXT FIELD inba204                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba204
            #add-point:BEFORE FIELD inba204 name="construct.b.inba204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba204
            
            #add-point:AFTER FIELD inba204 name="construct.a.inba204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba007
            #add-point:ON ACTION controlp INFIELD inba007 name="construct.c.inba007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_inba007_acc
            CALL q_oocq002()                          
            DISPLAY g_qryparam.return1 TO inba007 
            NEXT FIELD inba007                     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba007
            #add-point:BEFORE FIELD inba007 name="construct.b.inba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba007
            
            #add-point:AFTER FIELD inba007 name="construct.a.inba007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba007_desc
            #add-point:BEFORE FIELD inba007_desc name="construct.b.inba007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba007_desc
            
            #add-point:AFTER FIELD inba007_desc name="construct.a.inba007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba007_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba007_desc
            #add-point:ON ACTION controlp INFIELD inba007_desc name="construct.c.inba007_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba008
            #add-point:BEFORE FIELD inba008 name="construct.b.inba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba008
            
            #add-point:AFTER FIELD inba008 name="construct.a.inba008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba008
            #add-point:ON ACTION controlp INFIELD inba008 name="construct.c.inba008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbaownid
            #add-point:ON ACTION controlp INFIELD inbaownid name="construct.c.inbaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbaownid  #顯示到畫面上
            NEXT FIELD inbaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbaownid
            #add-point:BEFORE FIELD inbaownid name="construct.b.inbaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbaownid
            
            #add-point:AFTER FIELD inbaownid name="construct.a.inbaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbaowndp
            #add-point:ON ACTION controlp INFIELD inbaowndp name="construct.c.inbaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbaowndp  #顯示到畫面上
            NEXT FIELD inbaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbaowndp
            #add-point:BEFORE FIELD inbaowndp name="construct.b.inbaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbaowndp
            
            #add-point:AFTER FIELD inbaowndp name="construct.a.inbaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbacrtid
            #add-point:ON ACTION controlp INFIELD inbacrtid name="construct.c.inbacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbacrtid  #顯示到畫面上
            NEXT FIELD inbacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbacrtid
            #add-point:BEFORE FIELD inbacrtid name="construct.b.inbacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbacrtid
            
            #add-point:AFTER FIELD inbacrtid name="construct.a.inbacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbacrtdp
            #add-point:ON ACTION controlp INFIELD inbacrtdp name="construct.c.inbacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbacrtdp  #顯示到畫面上
            NEXT FIELD inbacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbacrtdp
            #add-point:BEFORE FIELD inbacrtdp name="construct.b.inbacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbacrtdp
            
            #add-point:AFTER FIELD inbacrtdp name="construct.a.inbacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbacrtdt
            #add-point:BEFORE FIELD inbacrtdt name="construct.b.inbacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbamodid
            #add-point:ON ACTION controlp INFIELD inbamodid name="construct.c.inbamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbamodid  #顯示到畫面上
            NEXT FIELD inbamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbamodid
            #add-point:BEFORE FIELD inbamodid name="construct.b.inbamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbamodid
            
            #add-point:AFTER FIELD inbamodid name="construct.a.inbamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbamoddt
            #add-point:BEFORE FIELD inbamoddt name="construct.b.inbamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbacnfid
            #add-point:ON ACTION controlp INFIELD inbacnfid name="construct.c.inbacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbacnfid  #顯示到畫面上
            NEXT FIELD inbacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbacnfid
            #add-point:BEFORE FIELD inbacnfid name="construct.b.inbacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbacnfid
            
            #add-point:AFTER FIELD inbacnfid name="construct.a.inbacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbacnfdt
            #add-point:BEFORE FIELD inbacnfdt name="construct.b.inbacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbapstid
            #add-point:ON ACTION controlp INFIELD inbapstid name="construct.c.inbapstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbapstid  #顯示到畫面上
            NEXT FIELD inbapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbapstid
            #add-point:BEFORE FIELD inbapstid name="construct.b.inbapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbapstid
            
            #add-point:AFTER FIELD inbapstid name="construct.a.inbapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbapstdt
            #add-point:BEFORE FIELD inbapstdt name="construct.b.inbapstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON inbbseq,inbb017,inbb211,inbb212,inbb200,inbb001,inbb002,inbb002_desc, 
          inbb213,inbb214,inbb215,inbb007,inbb008,inbb009,inbb210,inbb003,inbb220,inbb221,inbb222,inbb223, 
          inbb201,inbb202,inbb203,inbb011,inbb012,inbb010,inbb218,inbb219,inbb216,inbb217,inbb209,inbb207, 
          inbb208,inbb205,inbb206,inbb016,inbb016_desc,inbb018,inbb0171,inbb020,inbb204,inbb022,inbb021, 
          inbbsite,inbbunit
           FROM s_detail1[1].inbbseq,s_detail1[1].inbb017,s_detail1[1].inbb211,s_detail1[1].inbb212, 
               s_detail1[1].inbb200,s_detail1[1].inbb001,s_detail1[1].inbb002,s_detail1[1].inbb002_desc, 
               s_detail1[1].inbb213,s_detail1[1].inbb214,s_detail1[1].inbb215,s_detail1[1].inbb007,s_detail1[1].inbb008, 
               s_detail1[1].inbb009,s_detail1[1].inbb210,s_detail1[1].inbb003,s_detail1[1].inbb220,s_detail1[1].inbb221, 
               s_detail1[1].inbb222,s_detail1[1].inbb223,s_detail1[1].inbb201,s_detail1[1].inbb202,s_detail1[1].inbb203, 
               s_detail1[1].inbb011,s_detail1[1].inbb012,s_detail1[1].inbb010,s_detail1[1].inbb218,s_detail1[1].inbb219, 
               s_detail1[1].inbb216,s_detail1[1].inbb217,s_detail1[1].inbb209,s_detail1[1].inbb207,s_detail1[1].inbb208, 
               s_detail1[1].inbb205,s_detail1[1].inbb206,s_detail1[1].inbb016,s_detail1[1].inbb016_desc, 
               s_detail1[1].inbb018,s_detail1[1].inbb0171,s_detail1[1].inbb020,s_detail1[1].inbb204, 
               s_detail1[1].inbb022,s_detail1[1].inbb021,s_detail1[1].inbbsite,s_detail1[1].inbbunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbbseq
            #add-point:BEFORE FIELD inbbseq name="construct.b.page1.inbbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbbseq
            
            #add-point:AFTER FIELD inbbseq name="construct.a.page1.inbbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbbseq
            #add-point:ON ACTION controlp INFIELD inbbseq name="construct.c.page1.inbbseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb017
            #add-point:BEFORE FIELD inbb017 name="construct.b.page1.inbb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb017
            
            #add-point:AFTER FIELD inbb017 name="construct.a.page1.inbb017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb017
            #add-point:ON ACTION controlp INFIELD inbb017 name="construct.c.page1.inbb017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb211
            #add-point:BEFORE FIELD inbb211 name="construct.b.page1.inbb211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb211
            
            #add-point:AFTER FIELD inbb211 name="construct.a.page1.inbb211"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb211
            #add-point:ON ACTION controlp INFIELD inbb211 name="construct.c.page1.inbb211"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb212
            #add-point:BEFORE FIELD inbb212 name="construct.b.page1.inbb212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb212
            
            #add-point:AFTER FIELD inbb212 name="construct.a.page1.inbb212"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb212
            #add-point:ON ACTION controlp INFIELD inbb212 name="construct.c.page1.inbb212"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbb200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb200
            #add-point:ON ACTION controlp INFIELD inbb200 name="construct.c.page1.inbb200"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_6()                         
            DISPLAY g_qryparam.return1 TO inbb200  
            NEXT FIELD inbb200                     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb200
            #add-point:BEFORE FIELD inbb200 name="construct.b.page1.inbb200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb200
            
            #add-point:AFTER FIELD inbb200 name="construct.a.page1.inbb200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb001
            #add-point:ON ACTION controlp INFIELD inbb001 name="construct.c.page1.inbb001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'ALL'
            CALL q_imaf001_18()                        
            DISPLAY g_qryparam.return1 TO inbb001  
            NEXT FIELD inbb001                     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb001
            #add-point:BEFORE FIELD inbb001 name="construct.b.page1.inbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb001
            
            #add-point:AFTER FIELD inbb001 name="construct.a.page1.inbb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb002
            #add-point:ON ACTION controlp INFIELD inbb002 name="construct.c.page1.inbb002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inbb002()                        
            DISPLAY g_qryparam.return1 TO inbb002  
            NEXT FIELD inbb002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb002
            #add-point:BEFORE FIELD inbb002 name="construct.b.page1.inbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb002
            
            #add-point:AFTER FIELD inbb002 name="construct.a.page1.inbb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb002_desc
            #add-point:BEFORE FIELD inbb002_desc name="construct.b.page1.inbb002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb002_desc
            
            #add-point:AFTER FIELD inbb002_desc name="construct.a.page1.inbb002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb002_desc
            #add-point:ON ACTION controlp INFIELD inbb002_desc name="construct.c.page1.inbb002_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbb213
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb213
            #add-point:ON ACTION controlp INFIELD inbb213 name="construct.c.page1.inbb213"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbb213  #顯示到畫面上
            NEXT FIELD inbb213                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb213
            #add-point:BEFORE FIELD inbb213 name="construct.b.page1.inbb213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb213
            
            #add-point:AFTER FIELD inbb213 name="construct.a.page1.inbb213"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb214
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb214
            #add-point:ON ACTION controlp INFIELD inbb214 name="construct.c.page1.inbb214"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'ALL'
            CALL q_imaf001_18()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbb214  #顯示到畫面上
            NEXT FIELD inbb214                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb214
            #add-point:BEFORE FIELD inbb214 name="construct.b.page1.inbb214"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb214
            
            #add-point:AFTER FIELD inbb214 name="construct.a.page1.inbb214"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb215
            #add-point:BEFORE FIELD inbb215 name="construct.b.page1.inbb215"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb215
            
            #add-point:AFTER FIELD inbb215 name="construct.a.page1.inbb215"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb215
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb215
            #add-point:ON ACTION controlp INFIELD inbb215 name="construct.c.page1.inbb215"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb007
            #add-point:ON ACTION controlp INFIELD inbb007 name="construct.c.page1.inbb007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbb007  #顯示到畫面上
            NEXT FIELD inbb007                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb007
            #add-point:BEFORE FIELD inbb007 name="construct.b.page1.inbb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb007
            
            #add-point:AFTER FIELD inbb007 name="construct.a.page1.inbb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb008
            #add-point:ON ACTION controlp INFIELD inbb008 name="construct.c.page1.inbb008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbb008  #顯示到畫面上
            NEXT FIELD inbb008 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb008
            #add-point:BEFORE FIELD inbb008 name="construct.b.page1.inbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb008
            
            #add-point:AFTER FIELD inbb008 name="construct.a.page1.inbb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb009
            #add-point:ON ACTION controlp INFIELD inbb009 name="construct.c.page1.inbb009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            #150324-00007#1 20150413 By pmoelo mark(S)
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_inag004_13()                           #呼叫開窗
            #DISPLAY g_qryparam.return1 TO inbb009  #顯示到畫面上
            #NEXT FIELD inbb009                     #返回原欄位
            #150324-00007#1 20150413 By pmoelo mark(E)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb009
            #add-point:BEFORE FIELD inbb009 name="construct.b.page1.inbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb009
            
            #add-point:AFTER FIELD inbb009 name="construct.a.page1.inbb009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb210
            #add-point:BEFORE FIELD inbb210 name="construct.b.page1.inbb210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb210
            
            #add-point:AFTER FIELD inbb210 name="construct.a.page1.inbb210"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb210
            #add-point:ON ACTION controlp INFIELD inbb210 name="construct.c.page1.inbb210"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb003
            #add-point:BEFORE FIELD inbb003 name="construct.b.page1.inbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb003
            
            #add-point:AFTER FIELD inbb003 name="construct.a.page1.inbb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb003
            #add-point:ON ACTION controlp INFIELD inbb003 name="construct.c.page1.inbb003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbb220
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb220
            #add-point:ON ACTION controlp INFIELD inbb220 name="construct.c.page1.inbb220"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbb220  #顯示到畫面上
            NEXT FIELD inbb220                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb220
            #add-point:BEFORE FIELD inbb220 name="construct.b.page1.inbb220"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb220
            
            #add-point:AFTER FIELD inbb220 name="construct.a.page1.inbb220"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb221
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb221
            #add-point:ON ACTION controlp INFIELD inbb221 name="construct.c.page1.inbb221"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbb221  #顯示到畫面上
            NEXT FIELD inbb221                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb221
            #add-point:BEFORE FIELD inbb221 name="construct.b.page1.inbb221"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb221
            
            #add-point:AFTER FIELD inbb221 name="construct.a.page1.inbb221"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb222
            #add-point:BEFORE FIELD inbb222 name="construct.b.page1.inbb222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb222
            
            #add-point:AFTER FIELD inbb222 name="construct.a.page1.inbb222"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb222
            #add-point:ON ACTION controlp INFIELD inbb222 name="construct.c.page1.inbb222"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb223
            #add-point:BEFORE FIELD inbb223 name="construct.b.page1.inbb223"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb223
            
            #add-point:AFTER FIELD inbb223 name="construct.a.page1.inbb223"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb223
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb223
            #add-point:ON ACTION controlp INFIELD inbb223 name="construct.c.page1.inbb223"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbb201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb201
            #add-point:ON ACTION controlp INFIELD inbb201 name="construct.c.page1.inbb201"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                         
            DISPLAY g_qryparam.return1 TO inbb0201
            NEXT FIELD inbb201
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb201
            #add-point:BEFORE FIELD inbb201 name="construct.b.page1.inbb201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb201
            
            #add-point:AFTER FIELD inbb201 name="construct.a.page1.inbb201"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb202
            #add-point:BEFORE FIELD inbb202 name="construct.b.page1.inbb202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb202
            
            #add-point:AFTER FIELD inbb202 name="construct.a.page1.inbb202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb202
            #add-point:ON ACTION controlp INFIELD inbb202 name="construct.c.page1.inbb202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb203
            #add-point:BEFORE FIELD inbb203 name="construct.b.page1.inbb203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb203
            
            #add-point:AFTER FIELD inbb203 name="construct.a.page1.inbb203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb203
            #add-point:ON ACTION controlp INFIELD inbb203 name="construct.c.page1.inbb203"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb011
            #add-point:BEFORE FIELD inbb011 name="construct.b.page1.inbb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb011
            
            #add-point:AFTER FIELD inbb011 name="construct.a.page1.inbb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb011
            #add-point:ON ACTION controlp INFIELD inbb011 name="construct.c.page1.inbb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb012
            #add-point:BEFORE FIELD inbb012 name="construct.b.page1.inbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb012
            
            #add-point:AFTER FIELD inbb012 name="construct.a.page1.inbb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb012
            #add-point:ON ACTION controlp INFIELD inbb012 name="construct.c.page1.inbb012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb010
            #add-point:ON ACTION controlp INFIELD inbb010 name="construct.c.page1.inbb010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                         
            DISPLAY g_qryparam.return1 TO inbb010 
            NEXT FIELD inbb010          
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb010
            #add-point:BEFORE FIELD inbb010 name="construct.b.page1.inbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb010
            
            #add-point:AFTER FIELD inbb010 name="construct.a.page1.inbb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb218
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb218
            #add-point:ON ACTION controlp INFIELD inbb218 name="construct.c.page1.inbb218"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbb218  #顯示到畫面上
            NEXT FIELD inbb218                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb218
            #add-point:BEFORE FIELD inbb218 name="construct.b.page1.inbb218"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb218
            
            #add-point:AFTER FIELD inbb218 name="construct.a.page1.inbb218"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb219
            #add-point:BEFORE FIELD inbb219 name="construct.b.page1.inbb219"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb219
            
            #add-point:AFTER FIELD inbb219 name="construct.a.page1.inbb219"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb219
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb219
            #add-point:ON ACTION controlp INFIELD inbb219 name="construct.c.page1.inbb219"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbb216
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb216
            #add-point:ON ACTION controlp INFIELD inbb216 name="construct.c.page1.inbb216"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbb216  #顯示到畫面上
            NEXT FIELD inbb216                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb216
            #add-point:BEFORE FIELD inbb216 name="construct.b.page1.inbb216"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb216
            
            #add-point:AFTER FIELD inbb216 name="construct.a.page1.inbb216"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb217
            #add-point:BEFORE FIELD inbb217 name="construct.b.page1.inbb217"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb217
            
            #add-point:AFTER FIELD inbb217 name="construct.a.page1.inbb217"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb217
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb217
            #add-point:ON ACTION controlp INFIELD inbb217 name="construct.c.page1.inbb217"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbb209
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb209
            #add-point:ON ACTION controlp INFIELD inbb209 name="construct.c.page1.inbb209"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                       
            DISPLAY g_qryparam.return1 TO inbb209  
            NEXT FIELD inbb209 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb209
            #add-point:BEFORE FIELD inbb209 name="construct.b.page1.inbb209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb209
            
            #add-point:AFTER FIELD inbb209 name="construct.a.page1.inbb209"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb207
            #add-point:BEFORE FIELD inbb207 name="construct.b.page1.inbb207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb207
            
            #add-point:AFTER FIELD inbb207 name="construct.a.page1.inbb207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb207
            #add-point:ON ACTION controlp INFIELD inbb207 name="construct.c.page1.inbb207"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb208
            #add-point:BEFORE FIELD inbb208 name="construct.b.page1.inbb208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb208
            
            #add-point:AFTER FIELD inbb208 name="construct.a.page1.inbb208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb208
            #add-point:ON ACTION controlp INFIELD inbb208 name="construct.c.page1.inbb208"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb205
            #add-point:BEFORE FIELD inbb205 name="construct.b.page1.inbb205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb205
            
            #add-point:AFTER FIELD inbb205 name="construct.a.page1.inbb205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb205
            #add-point:ON ACTION controlp INFIELD inbb205 name="construct.c.page1.inbb205"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb206
            #add-point:BEFORE FIELD inbb206 name="construct.b.page1.inbb206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb206
            
            #add-point:AFTER FIELD inbb206 name="construct.a.page1.inbb206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb206
            #add-point:ON ACTION controlp INFIELD inbb206 name="construct.c.page1.inbb206"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb016
            #add-point:ON ACTION controlp INFIELD inbb016 name="construct.c.page1.inbb016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_inba007_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbb016  #顯示到畫面上
            NEXT FIELD inbb016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb016
            #add-point:BEFORE FIELD inbb016 name="construct.b.page1.inbb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb016
            
            #add-point:AFTER FIELD inbb016 name="construct.a.page1.inbb016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb016_desc
            #add-point:BEFORE FIELD inbb016_desc name="construct.b.page1.inbb016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb016_desc
            
            #add-point:AFTER FIELD inbb016_desc name="construct.a.page1.inbb016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb016_desc
            #add-point:ON ACTION controlp INFIELD inbb016_desc name="construct.c.page1.inbb016_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb018
            #add-point:BEFORE FIELD inbb018 name="construct.b.page1.inbb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb018
            
            #add-point:AFTER FIELD inbb018 name="construct.a.page1.inbb018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb018
            #add-point:ON ACTION controlp INFIELD inbb018 name="construct.c.page1.inbb018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb0171
            #add-point:BEFORE FIELD inbb0171 name="construct.b.page1.inbb0171"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb0171
            
            #add-point:AFTER FIELD inbb0171 name="construct.a.page1.inbb0171"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb0171
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb0171
            #add-point:ON ACTION controlp INFIELD inbb0171 name="construct.c.page1.inbb0171"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb020
            #add-point:BEFORE FIELD inbb020 name="construct.b.page1.inbb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb020
            
            #add-point:AFTER FIELD inbb020 name="construct.a.page1.inbb020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb020
            #add-point:ON ACTION controlp INFIELD inbb020 name="construct.c.page1.inbb020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb204
            #add-point:BEFORE FIELD inbb204 name="construct.b.page1.inbb204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb204
            
            #add-point:AFTER FIELD inbb204 name="construct.a.page1.inbb204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb204
            #add-point:ON ACTION controlp INFIELD inbb204 name="construct.c.page1.inbb204"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb022
            #add-point:BEFORE FIELD inbb022 name="construct.b.page1.inbb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb022
            
            #add-point:AFTER FIELD inbb022 name="construct.a.page1.inbb022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb022
            #add-point:ON ACTION controlp INFIELD inbb022 name="construct.c.page1.inbb022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb021
            #add-point:BEFORE FIELD inbb021 name="construct.b.page1.inbb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb021
            
            #add-point:AFTER FIELD inbb021 name="construct.a.page1.inbb021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb021
            #add-point:ON ACTION controlp INFIELD inbb021 name="construct.c.page1.inbb021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbbsite
            #add-point:BEFORE FIELD inbbsite name="construct.b.page1.inbbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbbsite
            
            #add-point:AFTER FIELD inbbsite name="construct.a.page1.inbbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbbsite
            #add-point:ON ACTION controlp INFIELD inbbsite name="construct.c.page1.inbbsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbbunit
            #add-point:BEFORE FIELD inbbunit name="construct.b.page1.inbbunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbbunit
            
            #add-point:AFTER FIELD inbbunit name="construct.a.page1.inbbunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbbunit
            #add-point:ON ACTION controlp INFIELD inbbunit name="construct.c.page1.inbbunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON inbcseq,inbcseq1,inbc209,inbc210,inbc200,inbc001,inbc002,inbc002_desc, 
          inbc005,inbc006,inbc006_desc,inbc007,inbc003,inbc201,inbc202,inbc009,inbc010,inbc208,inbc206, 
          inbc207,inbc204,inbc205,inbc011,inbc015,inbc203,inbc016,inbc017,inbcsite,inbcunit
           FROM s_detail2[1].inbcseq,s_detail2[1].inbcseq1,s_detail2[1].inbc209,s_detail2[1].inbc210, 
               s_detail2[1].inbc200,s_detail2[1].inbc001,s_detail2[1].inbc002,s_detail2[1].inbc002_desc, 
               s_detail2[1].inbc005,s_detail2[1].inbc006,s_detail2[1].inbc006_desc,s_detail2[1].inbc007, 
               s_detail2[1].inbc003,s_detail2[1].inbc201,s_detail2[1].inbc202,s_detail2[1].inbc009,s_detail2[1].inbc010, 
               s_detail2[1].inbc208,s_detail2[1].inbc206,s_detail2[1].inbc207,s_detail2[1].inbc204,s_detail2[1].inbc205, 
               s_detail2[1].inbc011,s_detail2[1].inbc015,s_detail2[1].inbc203,s_detail2[1].inbc016,s_detail2[1].inbc017, 
               s_detail2[1].inbcsite,s_detail2[1].inbcunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcseq
            #add-point:BEFORE FIELD inbcseq name="construct.b.page2.inbcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcseq
            
            #add-point:AFTER FIELD inbcseq name="construct.a.page2.inbcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcseq
            #add-point:ON ACTION controlp INFIELD inbcseq name="construct.c.page2.inbcseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcseq1
            #add-point:BEFORE FIELD inbcseq1 name="construct.b.page2.inbcseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcseq1
            
            #add-point:AFTER FIELD inbcseq1 name="construct.a.page2.inbcseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcseq1
            #add-point:ON ACTION controlp INFIELD inbcseq1 name="construct.c.page2.inbcseq1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc209
            #add-point:BEFORE FIELD inbc209 name="construct.b.page2.inbc209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc209
            
            #add-point:AFTER FIELD inbc209 name="construct.a.page2.inbc209"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc209
            #add-point:ON ACTION controlp INFIELD inbc209 name="construct.c.page2.inbc209"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc210
            #add-point:BEFORE FIELD inbc210 name="construct.b.page2.inbc210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc210
            
            #add-point:AFTER FIELD inbc210 name="construct.a.page2.inbc210"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc210
            #add-point:ON ACTION controlp INFIELD inbc210 name="construct.c.page2.inbc210"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc200
            #add-point:BEFORE FIELD inbc200 name="construct.b.page2.inbc200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc200
            
            #add-point:AFTER FIELD inbc200 name="construct.a.page2.inbc200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc200
            #add-point:ON ACTION controlp INFIELD inbc200 name="construct.c.page2.inbc200"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc001
            #add-point:BEFORE FIELD inbc001 name="construct.b.page2.inbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc001
            
            #add-point:AFTER FIELD inbc001 name="construct.a.page2.inbc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc001
            #add-point:ON ACTION controlp INFIELD inbc001 name="construct.c.page2.inbc001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc002
            #add-point:BEFORE FIELD inbc002 name="construct.b.page2.inbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc002
            
            #add-point:AFTER FIELD inbc002 name="construct.a.page2.inbc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc002
            #add-point:ON ACTION controlp INFIELD inbc002 name="construct.c.page2.inbc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc002_desc
            #add-point:BEFORE FIELD inbc002_desc name="construct.b.page2.inbc002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc002_desc
            
            #add-point:AFTER FIELD inbc002_desc name="construct.a.page2.inbc002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc002_desc
            #add-point:ON ACTION controlp INFIELD inbc002_desc name="construct.c.page2.inbc002_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc005
            #add-point:BEFORE FIELD inbc005 name="construct.b.page2.inbc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc005
            
            #add-point:AFTER FIELD inbc005 name="construct.a.page2.inbc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc005
            #add-point:ON ACTION controlp INFIELD inbc005 name="construct.c.page2.inbc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc006
            #add-point:BEFORE FIELD inbc006 name="construct.b.page2.inbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc006
            
            #add-point:AFTER FIELD inbc006 name="construct.a.page2.inbc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc006
            #add-point:ON ACTION controlp INFIELD inbc006 name="construct.c.page2.inbc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc006_desc
            #add-point:BEFORE FIELD inbc006_desc name="construct.b.page2.inbc006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc006_desc
            
            #add-point:AFTER FIELD inbc006_desc name="construct.a.page2.inbc006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc006_desc
            #add-point:ON ACTION controlp INFIELD inbc006_desc name="construct.c.page2.inbc006_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.inbc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc007
            #add-point:ON ACTION controlp INFIELD inbc007 name="construct.c.page2.inbc007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            #150324-00007#1 20150413 By pmoelo mark(S)
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_inag004_13()                           #呼叫開窗
            #DISPLAY g_qryparam.return1 TO inbc007  #顯示到畫面上
            #NEXT FIELD inbc007                     #返回原欄位
            #150324-00007#1 20150413 By pmoelo mark(E)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc007
            #add-point:BEFORE FIELD inbc007 name="construct.b.page2.inbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc007
            
            #add-point:AFTER FIELD inbc007 name="construct.a.page2.inbc007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc003
            #add-point:BEFORE FIELD inbc003 name="construct.b.page2.inbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc003
            
            #add-point:AFTER FIELD inbc003 name="construct.a.page2.inbc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc003
            #add-point:ON ACTION controlp INFIELD inbc003 name="construct.c.page2.inbc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc201
            #add-point:BEFORE FIELD inbc201 name="construct.b.page2.inbc201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc201
            
            #add-point:AFTER FIELD inbc201 name="construct.a.page2.inbc201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc201
            #add-point:ON ACTION controlp INFIELD inbc201 name="construct.c.page2.inbc201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc202
            #add-point:BEFORE FIELD inbc202 name="construct.b.page2.inbc202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc202
            
            #add-point:AFTER FIELD inbc202 name="construct.a.page2.inbc202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc202
            #add-point:ON ACTION controlp INFIELD inbc202 name="construct.c.page2.inbc202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc009
            #add-point:BEFORE FIELD inbc009 name="construct.b.page2.inbc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc009
            
            #add-point:AFTER FIELD inbc009 name="construct.a.page2.inbc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc009
            #add-point:ON ACTION controlp INFIELD inbc009 name="construct.c.page2.inbc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc010
            #add-point:BEFORE FIELD inbc010 name="construct.b.page2.inbc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc010
            
            #add-point:AFTER FIELD inbc010 name="construct.a.page2.inbc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc010
            #add-point:ON ACTION controlp INFIELD inbc010 name="construct.c.page2.inbc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc208
            #add-point:BEFORE FIELD inbc208 name="construct.b.page2.inbc208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc208
            
            #add-point:AFTER FIELD inbc208 name="construct.a.page2.inbc208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc208
            #add-point:ON ACTION controlp INFIELD inbc208 name="construct.c.page2.inbc208"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc206
            #add-point:BEFORE FIELD inbc206 name="construct.b.page2.inbc206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc206
            
            #add-point:AFTER FIELD inbc206 name="construct.a.page2.inbc206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc206
            #add-point:ON ACTION controlp INFIELD inbc206 name="construct.c.page2.inbc206"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc207
            #add-point:BEFORE FIELD inbc207 name="construct.b.page2.inbc207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc207
            
            #add-point:AFTER FIELD inbc207 name="construct.a.page2.inbc207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc207
            #add-point:ON ACTION controlp INFIELD inbc207 name="construct.c.page2.inbc207"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc204
            #add-point:BEFORE FIELD inbc204 name="construct.b.page2.inbc204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc204
            
            #add-point:AFTER FIELD inbc204 name="construct.a.page2.inbc204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc204
            #add-point:ON ACTION controlp INFIELD inbc204 name="construct.c.page2.inbc204"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc205
            #add-point:BEFORE FIELD inbc205 name="construct.b.page2.inbc205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc205
            
            #add-point:AFTER FIELD inbc205 name="construct.a.page2.inbc205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc205
            #add-point:ON ACTION controlp INFIELD inbc205 name="construct.c.page2.inbc205"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc011
            #add-point:BEFORE FIELD inbc011 name="construct.b.page2.inbc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc011
            
            #add-point:AFTER FIELD inbc011 name="construct.a.page2.inbc011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc011
            #add-point:ON ACTION controlp INFIELD inbc011 name="construct.c.page2.inbc011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc015
            #add-point:BEFORE FIELD inbc015 name="construct.b.page2.inbc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc015
            
            #add-point:AFTER FIELD inbc015 name="construct.a.page2.inbc015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc015
            #add-point:ON ACTION controlp INFIELD inbc015 name="construct.c.page2.inbc015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc203
            #add-point:BEFORE FIELD inbc203 name="construct.b.page2.inbc203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc203
            
            #add-point:AFTER FIELD inbc203 name="construct.a.page2.inbc203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc203
            #add-point:ON ACTION controlp INFIELD inbc203 name="construct.c.page2.inbc203"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc016
            #add-point:BEFORE FIELD inbc016 name="construct.b.page2.inbc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc016
            
            #add-point:AFTER FIELD inbc016 name="construct.a.page2.inbc016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc016
            #add-point:ON ACTION controlp INFIELD inbc016 name="construct.c.page2.inbc016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc017
            #add-point:BEFORE FIELD inbc017 name="construct.b.page2.inbc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc017
            
            #add-point:AFTER FIELD inbc017 name="construct.a.page2.inbc017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc017
            #add-point:ON ACTION controlp INFIELD inbc017 name="construct.c.page2.inbc017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcsite
            #add-point:BEFORE FIELD inbcsite name="construct.b.page2.inbcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcsite
            
            #add-point:AFTER FIELD inbcsite name="construct.a.page2.inbcsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcsite
            #add-point:ON ACTION controlp INFIELD inbcsite name="construct.c.page2.inbcsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcunit
            #add-point:BEFORE FIELD inbcunit name="construct.b.page2.inbcunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcunit
            
            #add-point:AFTER FIELD inbcunit name="construct.a.page2.inbcunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbcunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcunit
            #add-point:ON ACTION controlp INFIELD inbcunit name="construct.c.page2.inbcunit"
            
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
                  WHEN la_wc[li_idx].tableid = "inba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "inbb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "inbc_t" 
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
 
{<section id="aint911.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint911_filter()
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
      CONSTRUCT g_wc_filter ON inbadocno,inbadocdt,inba002,inba003,inba004
                          FROM s_browse[1].b_inbadocno,s_browse[1].b_inbadocdt,s_browse[1].b_inba002, 
                              s_browse[1].b_inba003,s_browse[1].b_inba004
 
         BEFORE CONSTRUCT
               DISPLAY aint911_filter_parser('inbadocno') TO s_browse[1].b_inbadocno
            DISPLAY aint911_filter_parser('inbadocdt') TO s_browse[1].b_inbadocdt
            DISPLAY aint911_filter_parser('inba002') TO s_browse[1].b_inba002
            DISPLAY aint911_filter_parser('inba003') TO s_browse[1].b_inba003
            DISPLAY aint911_filter_parser('inba004') TO s_browse[1].b_inba004
      
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
 
      CALL aint911_filter_show('inbadocno')
   CALL aint911_filter_show('inbadocdt')
   CALL aint911_filter_show('inba002')
   CALL aint911_filter_show('inba003')
   CALL aint911_filter_show('inba004')
 
END FUNCTION
 
{</section>}
 
{<section id="aint911.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint911_filter_parser(ps_field)
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
 
{<section id="aint911.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint911_filter_show(ps_field)
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
   LET ls_condition = aint911_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint911.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint911_query()
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
   CALL g_inbb_d.clear()
   CALL g_inbb2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aint911_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint911_browser_fill("")
      CALL aint911_fetch("")
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
      CALL aint911_filter_show('inbadocno')
   CALL aint911_filter_show('inbadocdt')
   CALL aint911_filter_show('inba002')
   CALL aint911_filter_show('inba003')
   CALL aint911_filter_show('inba004')
   CALL aint911_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aint911_fetch("F") 
      #顯示單身筆數
      CALL aint911_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint911.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint911_fetch(p_flag)
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
   
   LET g_inba_m.inbadocno = g_browser[g_current_idx].b_inbadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aint911_master_referesh USING g_inba_m.inbadocno INTO g_inba_m.inba001,g_inba_m.inbasite, 
       g_inba_m.inbadocdt,g_inba_m.inbadocno,g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003, 
       g_inba_m.inba004,g_inba_m.inba013,g_inba_m.inbaunit,g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006, 
       g_inba_m.inba015,g_inba_m.inba203,g_inba_m.inba205,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba207, 
       g_inba_m.inba204,g_inba_m.inba007,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaowndp,g_inba_m.inbacrtid, 
       g_inba_m.inbacrtdp,g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
       g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstdt,g_inba_m.inba003_desc,g_inba_m.inba004_desc, 
       g_inba_m.inba015_desc,g_inba_m.inba203_desc,g_inba_m.inba205_desc,g_inba_m.inba206_desc,g_inba_m.inba207_desc, 
       g_inba_m.inba204_desc,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid_desc, 
       g_inba_m.inbacrtdp_desc,g_inba_m.inbamodid_desc,g_inba_m.inbacnfid_desc,g_inba_m.inbapstid_desc 
 
   
   #遮罩相關處理
   LET g_inba_m_mask_o.* =  g_inba_m.*
   CALL aint911_inba_t_mask()
   LET g_inba_m_mask_n.* =  g_inba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint911_set_act_visible()   
   CALL aint911_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #20160108 add by beckxie---S
   CALL aint911_set_comp_visible_b()
   CALL aint911_set_comp_no_visible_b()
   #20160108 add by beckxie---E
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_inba_m_t.* = g_inba_m.*
   LET g_inba_m_o.* = g_inba_m.*
   
   LET g_data_owner = g_inba_m.inbaownid      
   LET g_data_dept  = g_inba_m.inbaowndp
   
   #重新顯示   
   CALL aint911_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint911.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint911_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_inbb_d.clear()   
   CALL g_inbb2_d.clear()  
 
 
   INITIALIZE g_inba_m.* TO NULL             #DEFAULT 設定
   
   LET g_inbadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inba_m.inbaownid = g_user
      LET g_inba_m.inbaowndp = g_dept
      LET g_inba_m.inbacrtid = g_user
      LET g_inba_m.inbacrtdp = g_dept 
      LET g_inba_m.inbacrtdt = cl_get_current()
      LET g_inba_m.inbamodid = g_user
      LET g_inba_m.inbamoddt = cl_get_current()
      LET g_inba_m.inbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_inba_m.inba012 = "3"
      LET g_inba_m.inba014 = "N"
      LET g_inba_m.inba005 = "1"
      LET g_inba_m.inba208 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      #營運組織
      LET g_ins_site_flag = NULL
      CALL s_aooi500_default(g_prog,g_site_str,g_inba_m.inbasite)
         RETURNING l_insert,g_inba_m.inbasite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      #預設單別
      CALL s_arti200_get_def_doc_type(g_inba_m.inbasite,g_prog,'1')
         RETURNING l_success,g_inba_m.inbadocno 
      
      LET g_inba_m.inbadocdt = g_today   #單據日期
      LET g_inba_m.inba001 = g_argv[1]   #單據類型
      LET g_inba_m.inba002 = g_today     #扣帳日期   
      LET g_inba_m.inba003 = g_user      #申請人員
      LET g_inba_m.inba004 = g_dept      #申請部門
      LET g_inba_m.inba005 = '1'         #來源資料類型
      
      #160604-00009#112 Add By Ken 160628(S)  aint919領用部門  預設申請部門
      IF g_argv[1] MATCHES '[59]' THEN               #160604-00009#140 add by ken 160711 加5為aint915也預設
         LET g_inba_m.inba205 = g_dept      #申請部門
         LET g_inba_m.inba205_desc = s_desc_get_department_desc(g_inba_m.inba205)
      END IF
      #160604-00009#112 Add By Ken 160628(E)  aint919領用部門  預設申請部門
     
      #151104-00002#3 151125 by lori add---(S)
      #來源資料類型,費用對象
      IF g_argv[1] MATCHES '[12356789]' THEN    #領用/退回/報損/行政/贈品/轉碼/轉碼入項/供應商商品入庫
            LET g_inba_m.inba012 = '3'          #來源資料類型=內部領用單
            LET g_inba_m.inba013 = g_dept       #費用對象預設為申請部門   #150629-00016#1 add
      END IF      
      
      IF g_argv[1] MATCHES '[4]' THEN           #供應商
            LET g_inba_m.inba012 = '1'          #來源資料類型=供應商領用        
      END IF    
      #151104-00002#3 151125 by lori add---(E)
      
      LET g_inba_m.inbasite_desc = s_desc_get_department_desc(g_inba_m.inbasite)  
      LET g_inba_m.inba003_desc = s_desc_get_person_desc(g_inba_m.inba003)   
      LET g_inba_m.inba004_desc = s_desc_get_department_desc(g_inba_m.inba004) 
      LET g_inba_m.inba013_desc = s_desc_get_department_desc(g_inba_m.inba013)      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_inba_m_t.* = g_inba_m.*
      LET g_inba_m_o.* = g_inba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inba_m.inbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aint911_input("a")
      
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
         INITIALIZE g_inba_m.* TO NULL
         INITIALIZE g_inbb_d TO NULL
         INITIALIZE g_inbb2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aint911_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_inbb_d.clear()
      #CALL g_inbb2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint911_set_act_visible()   
   CALL aint911_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inbadocno_t = g_inba_m.inbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " inbaent = " ||g_enterprise|| " AND",
                      " inbadocno = '", g_inba_m.inbadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint911_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aint911_cl
   
   CALL aint911_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint911_master_referesh USING g_inba_m.inbadocno INTO g_inba_m.inba001,g_inba_m.inbasite, 
       g_inba_m.inbadocdt,g_inba_m.inbadocno,g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003, 
       g_inba_m.inba004,g_inba_m.inba013,g_inba_m.inbaunit,g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006, 
       g_inba_m.inba015,g_inba_m.inba203,g_inba_m.inba205,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba207, 
       g_inba_m.inba204,g_inba_m.inba007,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaowndp,g_inba_m.inbacrtid, 
       g_inba_m.inbacrtdp,g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
       g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstdt,g_inba_m.inba003_desc,g_inba_m.inba004_desc, 
       g_inba_m.inba015_desc,g_inba_m.inba203_desc,g_inba_m.inba205_desc,g_inba_m.inba206_desc,g_inba_m.inba207_desc, 
       g_inba_m.inba204_desc,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid_desc, 
       g_inba_m.inbacrtdp_desc,g_inba_m.inbamodid_desc,g_inba_m.inbacnfid_desc,g_inba_m.inbapstid_desc 
 
   
   
   #遮罩相關處理
   LET g_inba_m_mask_o.* =  g_inba_m.*
   CALL aint911_inba_t_mask()
   LET g_inba_m_mask_n.* =  g_inba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inba_m.inba001,g_inba_m.inbasite,g_inba_m.inbasite_desc,g_inba_m.inbadocdt,g_inba_m.inbadocno, 
       g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003,g_inba_m.inba003_desc,g_inba_m.inba004, 
       g_inba_m.inba004_desc,g_inba_m.inba013,g_inba_m.inba013_desc,g_inba_m.inbaunit,g_inba_m.inbastus, 
       g_inba_m.inba005,g_inba_m.inba006,g_inba_m.inba015,g_inba_m.inba015_desc,g_inba_m.inba203,g_inba_m.inba203_desc, 
       g_inba_m.inba205,g_inba_m.inba205_desc,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba206_desc, 
       g_inba_m.inba207,g_inba_m.inba207_desc,g_inba_m.inba204,g_inba_m.inba204_desc,g_inba_m.inba007, 
       g_inba_m.inba007_desc,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp, 
       g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid,g_inba_m.inbacrtid_desc,g_inba_m.inbacrtdp,g_inba_m.inbacrtdp_desc, 
       g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamodid_desc,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
       g_inba_m.inbacnfid_desc,g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstid_desc,g_inba_m.inbapstdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_inba_m.inbaownid      
   LET g_data_dept  = g_inba_m.inbaowndp
   
   #功能已完成,通報訊息中心
   CALL aint911_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint911.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint911_modify()
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
   LET g_inba_m_t.* = g_inba_m.*
   LET g_inba_m_o.* = g_inba_m.*
   
   IF g_inba_m.inbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_inbadocno_t = g_inba_m.inbadocno
 
   CALL s_transaction_begin()
   
   OPEN aint911_cl USING g_enterprise,g_inba_m.inbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint911_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint911_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint911_master_referesh USING g_inba_m.inbadocno INTO g_inba_m.inba001,g_inba_m.inbasite, 
       g_inba_m.inbadocdt,g_inba_m.inbadocno,g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003, 
       g_inba_m.inba004,g_inba_m.inba013,g_inba_m.inbaunit,g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006, 
       g_inba_m.inba015,g_inba_m.inba203,g_inba_m.inba205,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba207, 
       g_inba_m.inba204,g_inba_m.inba007,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaowndp,g_inba_m.inbacrtid, 
       g_inba_m.inbacrtdp,g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
       g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstdt,g_inba_m.inba003_desc,g_inba_m.inba004_desc, 
       g_inba_m.inba015_desc,g_inba_m.inba203_desc,g_inba_m.inba205_desc,g_inba_m.inba206_desc,g_inba_m.inba207_desc, 
       g_inba_m.inba204_desc,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid_desc, 
       g_inba_m.inbacrtdp_desc,g_inba_m.inbamodid_desc,g_inba_m.inbacnfid_desc,g_inba_m.inbapstid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aint911_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inba_m_mask_o.* =  g_inba_m.*
   CALL aint911_inba_t_mask()
   LET g_inba_m_mask_n.* =  g_inba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL aint911_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_inbadocno_t = g_inba_m.inbadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_inba_m.inbamodid = g_user 
LET g_inba_m.inbamoddt = cl_get_current()
LET g_inba_m.inbamodid_desc = cl_get_username(g_inba_m.inbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #xianghui  150427  add---(S)
      IF g_inba_m.inbastus MATCHES "[DR]" THEN 
         LET g_inba_m.inbastus = "N"
      END IF
      #xianghui  150427  add---(E)
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aint911_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE inba_t SET (inbamodid,inbamoddt) = (g_inba_m.inbamodid,g_inba_m.inbamoddt)
          WHERE inbaent = g_enterprise AND inbadocno = g_inbadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_inba_m.* = g_inba_m_t.*
            CALL aint911_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_inba_m.inbadocno != g_inba_m_t.inbadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE inbb_t SET inbbdocno = g_inba_m.inbadocno
 
          WHERE inbbent = g_enterprise AND inbbdocno = g_inba_m_t.inbadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "inbb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbb_t:",SQLERRMESSAGE 
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
         
         UPDATE inbc_t
            SET inbcdocno = g_inba_m.inbadocno
 
          WHERE inbcent = g_enterprise AND
                inbcdocno = g_inbadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "inbc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
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
   CALL aint911_set_act_visible()   
   CALL aint911_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " inbaent = " ||g_enterprise|| " AND",
                      " inbadocno = '", g_inba_m.inbadocno, "' "
 
   #填到對應位置
   CALL aint911_browser_fill("")
 
   CLOSE aint911_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint911_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aint911.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint911_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               STRING
   DEFINE  l_para_data           LIKE type_t.chr80              #接參數用
   DEFINE  l_seq                 LIKE type_t.num5               
   DEFINE l_imaa005              LIKE imaa_t.imaa005            #特徵組
   DEFINE l_imaa006              LIKE imaa_t.imaa006            #基礎單位  
   DEFINE l_imaf055              LIKE imaf_t.imaf055            #庫存管理特徵
   DEFINE l_imaf061              LIKE imaf_t.imaf061            #庫存批號控管方式
   DEFINE l_imaf091              LIKE imaf_t.imaf091            #預設庫位
   DEFINE l_imaf092              LIKE imaf_t.imaf092            #預設儲位  
   DEFINE  l_inam                     DYNAMIC ARRAY OF RECORD   #記錄產品特徵
              inam001                 LIKE inam_t.inam001,
              inam002                 LIKE inam_t.inam002,
              inam004                 LIKE inam_t.inam004
                                   END RECORD
   DEFINE l_flag                 LIKE type_t.num5 
   DEFINE l_ooef004              LIKE ooef_t.ooef004   
   DEFINE l_inbb022              LIKE inbb_t.inbb022   #150507-00001#8 150527 by lori add
   DEFINE l_set_entry            LIKE type_t.num5      #150629-00016#1 150803 by lori add  
   DEFINE l_type                 LIKE type_t.num5      #150629-00016#1 150803 by lori add
   #151113-00020#1 151117 By pomelo add(S)
   DEFINE l_where                STRING
   #151113-00020#1 151117 By pomelo add(E)
   DEFINE l_inag008              LIKE inag_t.inag008   #160604-00009#140 Add By Ken 160725
   DEFINE  l_sql1                STRING     #160711-00040#15 add
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
   DISPLAY BY NAME g_inba_m.inba001,g_inba_m.inbasite,g_inba_m.inbasite_desc,g_inba_m.inbadocdt,g_inba_m.inbadocno, 
       g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003,g_inba_m.inba003_desc,g_inba_m.inba004, 
       g_inba_m.inba004_desc,g_inba_m.inba013,g_inba_m.inba013_desc,g_inba_m.inbaunit,g_inba_m.inbastus, 
       g_inba_m.inba005,g_inba_m.inba006,g_inba_m.inba015,g_inba_m.inba015_desc,g_inba_m.inba203,g_inba_m.inba203_desc, 
       g_inba_m.inba205,g_inba_m.inba205_desc,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba206_desc, 
       g_inba_m.inba207,g_inba_m.inba207_desc,g_inba_m.inba204,g_inba_m.inba204_desc,g_inba_m.inba007, 
       g_inba_m.inba007_desc,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp, 
       g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid,g_inba_m.inbacrtid_desc,g_inba_m.inbacrtdp,g_inba_m.inbacrtdp_desc, 
       g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamodid_desc,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
       g_inba_m.inbacnfid_desc,g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstid_desc,g_inba_m.inbapstdt 
 
   
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
   LET g_forupd_sql = "SELECT inbbseq,inbb017,inbb211,inbb212,inbb200,inbb001,inbb002,inbb213,inbb214, 
       inbb215,inbb007,inbb008,inbb009,inbb210,inbb003,inbb220,inbb221,inbb222,inbb223,inbb201,inbb202, 
       inbb203,inbb011,inbb012,inbb010,inbb218,inbb219,inbb216,inbb217,inbb224,inbb225,inbb209,inbb207, 
       inbb208,inbb205,inbb206,inbb016,inbb018,inbb020,inbb204,inbb022,inbb021,inbbsite,inbbunit FROM  
       inbb_t WHERE inbbent=? AND inbbdocno=? AND inbbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint911_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT inbcseq,inbcseq1,inbc209,inbc210,inbc200,inbc001,inbc002,inbc005,inbc006, 
       inbc007,inbc003,inbc201,inbc202,inbc009,inbc010,inbc211,inbc212,inbc208,inbc206,inbc207,inbc204, 
       inbc205,inbc011,inbc015,inbc203,inbc016,inbc017,inbcsite,inbcunit FROM inbc_t WHERE inbcent=?  
       AND inbcdocno=? AND inbcseq=? AND inbcseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint911_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aint911_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #151111-00021#3 Add By Ken 151202(S)
   CALL aint911_set_no_required()   
   CALL aint911_set_required()      
   #151111-00021#3 Add By Ken 151202(S)
   #end add-point
   CALL aint911_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_inba_m.inba001,g_inba_m.inbasite,g_inba_m.inbadocdt,g_inba_m.inbadocno,g_inba_m.inba002, 
       g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003,g_inba_m.inba004,g_inba_m.inba013,g_inba_m.inbaunit, 
       g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006,g_inba_m.inba015,g_inba_m.inba203,g_inba_m.inba205, 
       g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba207,g_inba_m.inba204,g_inba_m.inba007,g_inba_m.inba008 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aint911.input.head" >}
      #單頭段
      INPUT BY NAME g_inba_m.inba001,g_inba_m.inbasite,g_inba_m.inbadocdt,g_inba_m.inbadocno,g_inba_m.inba002, 
          g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003,g_inba_m.inba004,g_inba_m.inba013,g_inba_m.inbaunit, 
          g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006,g_inba_m.inba015,g_inba_m.inba203,g_inba_m.inba205, 
          g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba207,g_inba_m.inba204,g_inba_m.inba007,g_inba_m.inba008  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aint911_cl USING g_enterprise,g_inba_m.inbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint911_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint911_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aint911_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF NOT cl_null(g_inba_m.inbadocno) THEN 
               CALL aint911_get_slip_para()
            END IF
           
            CALL aint911_set_no_required()   #150629-00016#1 150716 by lori
            CALL aint911_set_required()      #150629-00016#1 150716 by lori
            #end add-point
            CALL aint911_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba001
            #add-point:BEFORE FIELD inba001 name="input.b.inba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba001
            
            #add-point:AFTER FIELD inba001 name="input.a.inba001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba001
            #add-point:ON CHANGE inba001 name="input.g.inba001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbasite
            
            #add-point:AFTER FIELD inbasite name="input.a.inbasite"
            LET g_inba_m.inbasite_desc = ' '
            DISPLAY BY NAME g_inba_m.inbasite_desc
            IF NOT cl_null(g_inba_m.inbasite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_inba_m.inbasite != g_inba_m_t.inbasite OR g_inba_m_t.inbasite IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,g_site_str,g_inba_m.inbasite,g_inba_m.inbasite )
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()                  
                     
                     LET g_inba_m.inbasite = g_inba_m_t.inbasite
                     LET g_inba_m.inbasite_desc = s_desc_get_department_desc(g_inba_m.inbasite)
                     DISPLAY BY NAME g_inba_m.inbasite,g_inba_m.inbasite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_arti200_get_def_doc_type(g_inba_m.inbasite,g_prog,'1')
                     RETURNING l_success,g_inba_m.inbadocno
                  DISPLAY BY NAME g_inba_m.inbadocno             
                  
                  CALL aint911_get_slip_para()
                  LET g_ins_site_flag = 'Y'                  
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "sub-00507"
               LET g_errparam.popup  = TRUE
               CALL cl_err()             
               NEXT FIELD CURRENT
            END IF
            LET g_inba_m.inbasite_desc = s_desc_get_department_desc(g_inba_m.inbasite)
            DISPLAY BY NAME g_inba_m.inbasite_desc
            
            CALL aint911_set_entry(p_cmd)
            #151111-00021#3 Add By Ken 151202(S)            
            CALL aint911_set_no_required()   
            CALL aint911_set_required()                 
            #151111-00021#3 Add By Ken 151202(E)
            CALL aint911_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbasite
            #add-point:BEFORE FIELD inbasite name="input.b.inbasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbasite
            #add-point:ON CHANGE inbasite name="input.g.inbasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbadocdt
            #add-point:BEFORE FIELD inbadocdt name="input.b.inbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbadocdt
            
            #add-point:AFTER FIELD inbadocdt name="input.a.inbadocdt"
            LET g_inba_m_t.inbadocdt = g_inba_m.inbadocdt
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbadocdt
            #add-point:ON CHANGE inbadocdt name="input.g.inbadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbadocno
            #add-point:BEFORE FIELD inbadocno name="input.b.inbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbadocno
            
            #add-point:AFTER FIELD inbadocno name="input.a.inbadocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_inba_m.inbadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inba_m.inbadocno != g_inbadocno_t )) THEN 
               #   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inba_t WHERE "||"inbaent = '" ||g_enterprise|| "' AND "||"inbadocno = '"||g_inba_m.inbadocno ||"'",'std-00004',0) THEN 
               #      NEXT FIELD CURRENT
               #   END IF
                  IF NOT s_aooi200_chk_slip(g_inba_m.inbasite,'',g_inba_m.inbadocno,g_prog) THEN
                     LET g_inba_m.inbadocno = g_inbadocno_t
                     NEXT FIELD CURRENT
                  END IF
                  CALL aint911_get_slip_para()             
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbadocno
            #add-point:ON CHANGE inbadocno name="input.g.inbadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba002
            #add-point:BEFORE FIELD inba002 name="input.b.inba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba002
            
            #add-point:AFTER FIELD inba002 name="input.a.inba002"
            IF NOT cl_null(g_inba_m.inba002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_inba_m.inba002 != g_inba_m_t.inba002 OR g_inba_m_t.inba002 IS NULL )) THEN
                  #151120-00003#1 20151126 mark by beckxie---S
                  #IF g_inba_m.inba002 < g_inba_m.inbadocdt THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = 'axm-00267'   #扣帳日期不可小於單據日期！
                  #   LET g_errparam.extend = g_inba_m.inba002
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #
                  #   LET g_inba_m.inba002 = g_inba_m_t.inba002
                  #   NEXT FIELD CURRENT
                  #END IF
                  #151120-00003#1 20151126 mark by beckxie---E
                  
                  #庫存關帳日期
                  CALL cl_get_para(g_enterprise,g_inba_m.inbasite,'S-MFG-0031') RETURNING l_para_data
                  IF g_inba_m.inba002 <= l_para_data THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00077'   #扣帳日期小於關帳日期，請重新輸入！
                     LET g_errparam.extend = g_inba_m.inba002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_inba_m.inba002 = g_inba_m_t.inba002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba002
            #add-point:ON CHANGE inba002 name="input.g.inba002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba012
            #add-point:BEFORE FIELD inba012 name="input.b.inba012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba012
            
            #add-point:AFTER FIELD inba012 name="input.a.inba012"
            #150629-00016#1 150716 by lori---(S)
            IF cl_null(g_inba_m.inba012) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "ain-00611" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()            
               NEXT FIELD inba012
            ELSE
               IF cl_null(g_inba_m_o.inba012) OR g_inba_m.inba012 != g_inba_m_o.inba012 THEN
                  LET g_inba_m.inba013 = NULL
                  LET g_inba_m.inba013_desc = NULL
                  DISPLAY BY NAME g_inba_m.inba013,g_inba_m.inba013_desc
               END IF
            END IF
            
            CALL aint911_set_no_required()  
            CALL aint911_set_required()

            LET g_inba_m_o.inba012  = g_inba_m.inba012
            LET g_inba_m_o.inba013  = g_inba_m.inba013
            #150629-00016#1 150716 by lori---(E)
     
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba012
            #add-point:ON CHANGE inba012 name="input.g.inba012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba014
            #add-point:BEFORE FIELD inba014 name="input.b.inba014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba014
            
            #add-point:AFTER FIELD inba014 name="input.a.inba014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba014
            #add-point:ON CHANGE inba014 name="input.g.inba014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba003
            
            #add-point:AFTER FIELD inba003 name="input.a.inba003"
            LET g_inba_m.inba003_desc = ''
            LET g_inba_m.inba004_desc = ''
            DISPLAY BY NAME g_inba_m.inba003_desc,g_inba_m.inba004_desc
            IF NOT cl_null(g_inba_m.inba003) THEN
               IF g_inba_m.inba003 != g_inba_m_o.inba003 OR g_inba_m_o.inba003 IS NULL THEN   #150427-00012#3  150507 by lori mod
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inba_m.inba003
                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#20  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_inba_m.inba003 = g_inba_m_o.inba003
                     LET g_inba_m.inba004 = g_inba_m_o.inba004
                     LET g_inba_m.inba003_desc = s_desc_get_person_desc(g_inba_m.inba003) 
                     LET g_inba_m.inba004_desc = s_desc_get_department_desc(g_inba_m.inba004)  
                     DISPLAY BY NAME g_inba_m.inba003,g_inba_m.inba003_desc,  
                                     g_inba_m.inba004,g_inba_m.inba004_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #帶值：所屬部門   
               SELECT ooag003 INTO g_inba_m.inba004
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_inba_m.inba003   
               #160604-00009#140 Add BY Ken 160712(S)
               IF g_argv[1] MATCHES '[59]' THEN   #aint915,aint919才預帶
                  LET g_inba_m.inba013 = g_inba_m.inba004
                  LET g_inba_m.inba205 = g_inba_m.inba004
               END IF
               #160604-00009#140 Add BY Ken 160712(E)
            ELSE
               LET g_inba_m.inba004 = ''
            END IF
            LET g_inba_m.inba003_desc = s_desc_get_person_desc(g_inba_m.inba003) 
            LET g_inba_m.inba004_desc = s_desc_get_department_desc(g_inba_m.inba004)
            #160604-00009#140 Add BY Ken 160712(S)            
            LET g_inba_m.inba205_desc = s_desc_get_department_desc(g_inba_m.inba205)  
            LET g_inba_m.inba013_desc = s_desc_get_department_desc(g_inba_m.inba013)  
            DISPLAY BY NAME g_inba_m.inba013_desc,g_inba_m.inba205_desc 
            #160604-00009#140 Add BY Ken 160712(E)
            DISPLAY BY NAME g_inba_m.inba003_desc,g_inba_m.inba004_desc   
            
            LET g_inba_m_o.inba003 = g_inba_m.inba003
            LET g_inba_m_o.inba004 = g_inba_m.inba004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba003
            #add-point:BEFORE FIELD inba003 name="input.b.inba003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba003
            #add-point:ON CHANGE inba003 name="input.g.inba003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba004
            
            #add-point:AFTER FIELD inba004 name="input.a.inba004"
            LET g_inba_m.inba004_desc = ''
            DISPLAY BY NAME g_inba_m.inba004_desc   
            IF NOT cl_null(g_inba_m.inba004) THEN
               IF g_inba_m.inba004 != g_inba_m_o.inba004 OR g_inba_m_o.inba004 IS NULL THEN   #150427-00012#3  150507 by lori mod
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inba_m.inba004
                  IF cl_null(g_inba_m.inbadocdt) THEN
                     LET g_chkparam.arg2 = g_today
                  ELSE
                     LET g_chkparam.arg2 = g_inba_m.inbadocdt
                  END IF
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#19  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_inba_m.inba004 = g_inba_m_o.inba004
                     LET g_inba_m.inba004_desc = s_desc_get_department_desc(g_inba_m.inba004)  
                     DISPLAY BY NAME g_inba_m.inba004_desc                       
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_inba_m.inba004_desc = s_desc_get_department_desc(g_inba_m.inba004)       
            DISPLAY BY NAME g_inba_m.inba004_desc   
            
            LET g_inba_m_o.inba004 = g_inba_m.inba004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba004
            #add-point:BEFORE FIELD inba004 name="input.b.inba004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba004
            #add-point:ON CHANGE inba004 name="input.g.inba004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba013
            
            #add-point:AFTER FIELD inba013 name="input.a.inba013"
            #150629-00016#1 150716 by lori---(S)
            LET g_inba_m.inba013_desc = ' '
            DISPLAY BY NAME g_inba_m.inba013_desc
            IF NOT cl_null(g_inba_m.inba013) THEN
               IF cl_null(g_inba_m_o.inba013) OR g_inba_m.inba013 != g_inba_m_o.inba013 THEN
                  CASE g_inba_m.inba012
                     WHEN '1'   #供應商 
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_inba_m.inba013
                        IF NOT cl_chk_exist("v_pmaa001_1") THEN
                           LET g_inba_m.inba013 = g_inba_m_o.inba013
                           #150827-00013#1 by lori mark and add---(S)
                           #LET g_inba_m.inba013_desc = s_desc_get_trading_partner_abbr_desc(g_inba_m.inba013)    
                           #DISPLAY BY NAME g_inba_m.inba013  #Mark Ken XXXXXX 151203
                           CALL aint911_inba013_ref()
                           #150827-00013#1 by lori mark and add---(E)
                           NEXT FIELD CURRENT
                        END IF         

                        LET l_cnt = 0
                        SELECT COUNT(*) INTO l_cnt
                          FROM stan_t
                         WHERE stanent = g_enterprise
                           AND stan005 = g_inba_m.inba013
                          #AND stan002 = '1'                      #151104-00002#3 151125 by lori mark
                           AND stan029 NOT IN ('1','7')
                           AND stanstus = 'Y'
                           AND EXISTS(SELECT 1 FROM stbo_t
                                       WHERE stboent = stanent
                                         AND stbo001 = stan001
                                         AND stbo003 = g_inba_m.inbasite)
                        IF l_cnt = 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code       = "ain-00625"
                           LET g_errparam.replace[1] = g_inba_m.inba013
                           LET g_errparam.popup      = TRUE
                           CALL cl_err()

                           LET g_inba_m.inba013 = g_inba_m_o.inba013
                           #150827-00013#1 by lori mark and add---(S)
                           #LET g_inba_m.inba013_desc = s_desc_get_trading_partner_abbr_desc(g_inba_m.inba013)    
                           #DISPLAY BY NAME g_inba_m.inba013  #Mark Ken XXXXXX 151203
                           CALL aint911_inba013_ref()
                           #150827-00013#1 by lori mark and add---(E)
                           NEXT FIELD CURRENT
                        END IF
                        
                        #151104-00002#3 151125 by lori---(S)
                        LET g_inba_m.inba204 = g_inba_m.inba013
                        CALL s_desc_get_trading_partner_abbr_desc(g_inba_m.inba204) RETURNING g_inba_m.inba204_desc
                        DISPLAY BY NAME g_inba_m.inba204,g_inba_m.inba204_desc
                        
                        LET g_inba_m_o.inba204 = g_inba_m.inba204
                        #151104-00002#3 151125 by lori---(S)
                        
                     WHEN '2'   #專櫃     
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_inba_m.inbasite
                        LET g_chkparam.arg2 = g_inba_m.inba013
                        IF NOT cl_chk_exist("v_mhae001_1") THEN
                           LET g_inba_m.inba013 = g_inba_m_o.inba013                     
                           #150827-00013#1 by lori mark and add---(S)
                           #LET g_inba_m.inba013_desc = s_desc_get_trading_partner_abbr_desc(g_inba_m.inba013)    
                           #DISPLAY BY NAME g_inba_m.inba013  #Mark Ken XXXXXX 151203
                           CALL aint911_inba013_ref()
                           #150827-00013#1 by lori mark and add---(E)
                           NEXT FIELD CURRENT
                        END IF   
                        
                        LET l_cnt = 0
                        SELECT COUNT(*) INTO l_cnt
                          FROM stfa_t
                         WHERE stfaent = g_enterprise
                           AND stfa005 = g_inba_m.inba013
                           AND stfa004 NOT IN ('1','7')
                           AND stfastus = 'Y'
                        IF l_cnt = 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code       = "ain-00626"
                           LET g_errparam.replace[1] = g_inba_m.inba013
                           LET g_errparam.popup      = TRUE
                           CALL cl_err()

                           LET g_inba_m.inba013 = g_inba_m_o.inba013
                           #150827-00013#1 by lori mark and add---(S)
                           #LET g_inba_m.inba013_desc = s_desc_get_trading_partner_abbr_desc(g_inba_m.inba013)    
                           #DISPLAY BY NAME g_inba_m.inba013  #Mark Ken XXXXXX 151203
                           CALL aint911_inba013_ref()
                           #150827-00013#1 by lori mark and add---(E)
                           NEXT FIELD CURRENT
                        END IF
                        
                     WHEN '3'   #內部員工 
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_inba_m.inba013
                        IF cl_null(g_inba_m.inbadocdt) THEN
                           LET g_chkparam.arg2 = g_today
                        ELSE
                           LET g_chkparam.arg2 = g_inba_m.inbadocdt
                        END IF
                        #160318-00025#19  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                        #160318-00025#19  by 07900 --add-end
                        IF NOT cl_chk_exist("v_ooeg001") THEN
                           LET g_inba_m.inba013 = g_inba_m_o.inba013
                           #150827-00013#1 by lori mark and add---(S)
                           #LET g_inba_m.inba013_desc = s_desc_get_trading_partner_abbr_desc(g_inba_m.inba013)    
                           #DISPLAY BY NAME g_inba_m.inba013  #Mark Ken XXXXXX 151203
                           CALL aint911_inba013_ref()
                           #150827-00013#1 by lori mark and add---(E)
                           NEXT FIELD CURRENT
                        END IF     
                  END CASE
                  
                  DISPLAY BY NAME g_inba_m.inba013,g_inba_m.inba013_desc   
               END IF
            END IF
            CALL aint911_inba013_ref()
            
            LET g_inba_m_o.inba013 = g_inba_m.inba013 
            #150629-00016#1 150716 by lori---(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba013
            #add-point:BEFORE FIELD inba013 name="input.b.inba013"
            #150629-00016#1 150716 by lori---(S)
            IF cl_null(g_inba_m.inba012) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "ain-00611" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()            
               NEXT FIELD inba012
            END IF
            #150629-00016#1 150716 by lori---(E)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba013
            #add-point:ON CHANGE inba013 name="input.g.inba013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbaunit
            #add-point:BEFORE FIELD inbaunit name="input.b.inbaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbaunit
            
            #add-point:AFTER FIELD inbaunit name="input.a.inbaunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbaunit
            #add-point:ON CHANGE inbaunit name="input.g.inbaunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbastus
            #add-point:BEFORE FIELD inbastus name="input.b.inbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbastus
            
            #add-point:AFTER FIELD inbastus name="input.a.inbastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbastus
            #add-point:ON CHANGE inbastus name="input.g.inbastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba005
            #add-point:BEFORE FIELD inba005 name="input.b.inba005"
            #150629-00016#1 150716 by lori add---(S)
            IF g_argv[1] = '2' THEN
               CALL cl_set_combo_scc_part('inba005','2051','1,11')
            END IF   
            #150629-00016#1 150716 by lori add---(E) 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba005
            
            #add-point:AFTER FIELD inba005 name="input.a.inba005"
            #150629-00016#1 150716 by lori add---(S)
            CALL aint911_set_entry(p_cmd)
            #151111-00021#3 Add By Ken 151202(S)
            CALL aint911_set_no_required()   
            CALL aint911_set_required()      
            #151111-00021#3 Add By Ken 151202(E)
            CALL aint911_set_no_entry(p_cmd)
            #150629-00016#1 150716 by lori add---(E)             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba005
            #add-point:ON CHANGE inba005 name="input.g.inba005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba006
            #add-point:BEFORE FIELD inba006 name="input.b.inba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba006
            
            #add-point:AFTER FIELD inba006 name="input.a.inba006"
            #150629-00016#1  150715 by lori add---(S)
            IF g_argv[1] = '2' THEN
               IF NOT cl_null(g_inba_m.inba006) THEN
                  #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_inba_m.inba006 != g_inba_m_t.inba006 OR g_inba_m_t.inba006 IS NULL )) THEN   ##150827-00013#1 by lori mark
                  IF g_inba_m.inba006 != g_inba_m_o.inba006 OR cl_null(g_inba_m_o.inba006) THEN    #150827-00013#1 by lori add
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_inba_m.inbasite
                    #LET g_chkparam.arg2 = g_inba_m.inbadocno    #150827-00013#1 by lori mark
                     LET g_chkparam.arg2 = g_inba_m.inba006      #150827-00013#1 by lori add
                    #IF NOT cl_chk_exist("v_inbadocno_1") THEN   #150827-00013#1 by lori mark
                     #160318-00025#20  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="ain-00655:sub-01318|aint911|",cl_get_progname("aint911",g_lang,"2"),"|:EXEPROGaint911"
                     #160318-00025#20  by 07900 --add-end
                     IF NOT cl_chk_exist("v_inbadocno_6") THEN   #150827-00013#1 by lori add
                        LET g_inba_m.inba006 = g_inba_m_o.inba006
                        NEXT FIELD CURRENT
                     END IF
                     
                     CALL aint911_inba006_default()   #150827-00013#1 by lori add
                  END IF
               END IF
            END IF 
            
            #150827-00013#1 by lori add---(S)
            LET g_inba_m_o.inba006 = g_inba_m.inba006
            LET g_inba_m_o.inba007 = g_inba_m.inba007
            LET g_inba_m_o.inba012 = g_inba_m.inba012
            LET g_inba_m_o.inba013 = g_inba_m.inba013
            LET g_inba_m_o.inba014 = g_inba_m.inba014
            #150827-00013#1 by lori add---(E)
            #150629-00016#1  150715 by lori add---(E)            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba006
            #add-point:ON CHANGE inba006 name="input.g.inba006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba015
            
            #add-point:AFTER FIELD inba015 name="input.a.inba015"
            LET g_inba_m.inba015_desc = ' '
            DISPLAY BY NAME g_inba_m.inba015_desc            
            IF NOT cl_null(g_inba_m.inba015) THEN
               IF g_inba_m.inba015 != g_inba_m_o.inba015 OR g_inba_m_o.inba015 IS NULL THEN
                  LET l_success = ''
                  INITIALIZE g_chkparam.* TO NULL
                  #151113-00020#1 151119 By pomelo add(S)
                  IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
                     LET l_type = '1'
                  ELSE
                     LET l_type = '2'
                  END IF
                  CASE l_type
                  #151113-00020#1 151119 By pomelo add(E)
                  #CASE g_argv[1]    #151113-00020#1 151119 By pomelo mark
                     WHEN '1' 
                        LET g_chkparam.arg1 = g_inba_m.inbasite
                        LET g_chkparam.arg2 = g_inba_m.inba015
                        #160318-00025#20  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                        #160318-00025#20  by 07900 --add-end
                        IF NOT cl_chk_exist("v_inaa001") THEN
                           LET l_success = FALSE
                        END IF
                     WHEN '2'
                        LET g_chkparam.arg1 = g_inba_m.inba015
                        #160318-00025#20  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                        #160318-00025#20  by 07900 --add-end
                        IF NOT cl_chk_exist("v_inaa001_9") THEN
                           LET l_success = FALSE
                        END IF
                  END CASE
                  
                  IF NOT l_success THEN
                     LET g_inba_m.inba015 = g_inba_m_o.inba015
                     CALL s_desc_get_stock_desc(g_site,g_inba_m.inba015) RETURNING g_inba_m.inba015_desc
                     DISPLAY BY NAME g_inba_m.inba015_desc   
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_inba_m.inba015_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inba_m.inba015)
            DISPLAY BY NAME g_inba_m.inba015_desc   
            LET g_inba_m_o.inba015 = g_inba_m.inba015
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba015
            #add-point:BEFORE FIELD inba015 name="input.b.inba015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba015
            #add-point:ON CHANGE inba015 name="input.g.inba015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba203
            
            #add-point:AFTER FIELD inba203 name="input.a.inba203"
            LET g_inba_m.inba203_desc = ' '
            DISPLAY BY NAME g_inba_m.inba203_desc
            IF NOT cl_null(g_inba_m.inba203) THEN
               IF g_inba_m.inba203_desc != g_inba_m_o.inba203 OR cl_null(g_inba_m_o.inba203) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inba_m.inba203
                  LET g_chkparam.arg2 = g_sys
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_rtax001_2") THEN
                     LET g_inba_m.inba203 = g_inba_m_o.inba203
                     LET g_inba_m.inba203_desc = s_desc_get_rtaxl003_desc(g_inba_m.inba203)
                     DISPLAY BY NAME g_inba_m.inba203_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_inba_m_o.inba203 = g_inba_m.inba203
            LET g_inba_m.inba203_desc = s_desc_get_rtaxl003_desc(g_inba_m.inba203)
            DISPLAY BY NAME g_inba_m.inba203_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba203
            #add-point:BEFORE FIELD inba203 name="input.b.inba203"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba203
            #add-point:ON CHANGE inba203 name="input.g.inba203"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba205
            
            #add-point:AFTER FIELD inba205 name="input.a.inba205"
            IF NOT cl_null(g_inba_m.inba205) THEN
               IF g_inba_m.inba205 != g_inba_m_o.inba205 OR cl_null(g_inba_m_o.inba205) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inba_m.inba205
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_inba_m.inba205 = g_inba_m_o.inba205
                     CALL s_desc_get_department_desc(g_inba_m.inba205)
                        RETURNING g_inba_m.inba205_desc
                     DISPLAY BY NAME g_inba_m.inba205_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_inba_m_o.inba205 = g_inba_m.inba205
            CALL s_desc_get_department_desc(g_inba_m.inba205)
               RETURNING g_inba_m.inba205_desc
            DISPLAY BY NAME g_inba_m.inba205_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba205
            #add-point:BEFORE FIELD inba205 name="input.b.inba205"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba205
            #add-point:ON CHANGE inba205 name="input.g.inba205"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba208
            #add-point:BEFORE FIELD inba208 name="input.b.inba208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba208
            
            #add-point:AFTER FIELD inba208 name="input.a.inba208"
            #151113-00020#1 151117 By pomelo add(S)
            IF NOT cl_null(g_inba_m.inba208) THEN
               IF g_inba_m.inba208 != g_inba_m_o.inba208 OR cl_null(g_inba_m_o.inba208) THEN
                  LET g_inba_m.inba015 = ''
                  LET g_inba_m.inba015_desc = ''
                  DISPLAY BY NAME g_inba_m.inba015,g_inba_m.inba015_desc
               END IF
            END IF
            #151113-00020#1 151117 By pomelo add(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba208
            #add-point:ON CHANGE inba208 name="input.g.inba208"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba206
            
            #add-point:AFTER FIELD inba206 name="input.a.inba206"
            LET g_inba_m.inba206_desc = ' '
            DISPLAY BY NAME g_inba_m.inba206_desc
            IF NOT cl_null(g_inba_m.inba206) THEN
               IF g_inba_m.inba206 != g_inba_m_o.inba206 OR cl_null(g_inba_m_o.inba206) THEN
                  LET l_success = ''
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inba_m.inbasite
                  LET g_chkparam.arg2 = g_inba_m.inba206
                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#20  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     LET g_inba_m.inba206 = g_inba_m_o.inba206
                     CALL s_desc_get_stock_desc(g_inba_m.inbasite,g_inba_m.inba206)
                        RETURNING g_inba_m.inba206_desc
                     DISPLAY BY NAME g_inba_m.inba206_desc
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
            END IF
            LET g_inba_m_o.inba206 = g_inba_m.inba206
            LET g_inba_m.inba206_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inba_m.inba206)
            DISPLAY BY NAME g_inba_m.inba206_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba206
            #add-point:BEFORE FIELD inba206 name="input.b.inba206"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba206
            #add-point:ON CHANGE inba206 name="input.g.inba206"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba207
            
            #add-point:AFTER FIELD inba207 name="input.a.inba207"
            LET g_inba_m.inba207_desc = ' '
            DISPLAY BY NAME g_inba_m.inba207_desc
            IF NOT cl_null(g_inba_m.inba207) THEN
               IF g_inba_m.inba207 != g_inba_m_o.inba207 OR cl_null(g_inba_m_o.inba207) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inba_m.inba207
                  LET g_chkparam.arg2 = g_sys
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_rtax001_2") THEN
                     LET g_inba_m.inba207 = g_inba_m_o.inba207
                     CALL s_desc_get_rtaxl003_desc(g_inba_m.inba207)
                        RETURNING g_inba_m.inba207_desc
                     DISPLAY BY NAME g_inba_m.inba207_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_inba_m_o.inba207 = g_inba_m.inba207
            CALL s_desc_get_rtaxl003_desc(g_inba_m.inba207)
               RETURNING g_inba_m.inba207_desc
            DISPLAY BY NAME g_inba_m.inba207_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba207
            #add-point:BEFORE FIELD inba207 name="input.b.inba207"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba207
            #add-point:ON CHANGE inba207 name="input.g.inba207"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba204
            
            #add-point:AFTER FIELD inba204 name="input.a.inba204"
            IF NOT cl_null(g_inba_m.inba204) THEN
               IF g_inba_m.inba204 != g_inba_m_o.inba204 OR cl_null(g_inba_m_o.inba204) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inba_m.inba204
                  IF NOT cl_chk_exist("v_pmaa001_1") THEN
                     LET g_inba_m.inba204 = g_inba_m_o.inba204
                     CALL s_desc_get_trading_partner_abbr_desc(g_inba_m.inba204)
                        RETURNING g_inba_m.inba204_desc
                     DISPLAY BY NAME g_inba_m.inba204_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_inba_m_o.inba204 = g_inba_m.inba204
            CALL s_desc_get_trading_partner_abbr_desc(g_inba_m.inba204)
               RETURNING g_inba_m.inba204_desc
            DISPLAY BY NAME g_inba_m.inba204_desc
            
            #160801-00022#1 20160801 mark by beckxie---S
            #單頭供應商輸入後，不更新回費用對象
            ##151104-00002#3 151125 by lori---(S)
            #LET g_inba_m.inba013 = g_inba_m.inba204
            #CALL s_desc_get_trading_partner_abbr_desc(g_inba_m.inba013) RETURNING g_inba_m.inba013_desc
            #DISPLAY BY NAME g_inba_m.inba013,g_inba_m.inba013_desc
            #
            #LET g_inba_m_o.inba013 = g_inba_m.inba013
            ##151104-00002#3 151125 by lori---(S)
            #160801-00022#1 20160801 mark by beckxie---E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba204
            #add-point:BEFORE FIELD inba204 name="input.b.inba204"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba204
            #add-point:ON CHANGE inba204 name="input.g.inba204"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba007
            
            #add-point:AFTER FIELD inba007 name="input.a.inba007"
            LET g_inba_m.inba007_desc = ''
            DISPLAY BY NAME g_inba_m.inba007_desc
            IF NOT cl_null(g_inba_m.inba007) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_inba_m.inba007 != g_inba_m_t.inba007 OR g_inba_m_t.inba007 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist(g_inba007_acc,g_inba_m.inba007) THEN
                     LET g_inba_m.inba007 = g_inba_m_t.inba007
                     LET g_inba_m.inba007_desc = s_desc_get_acc_desc(g_inba007_acc,g_inba_m.inba007)
                     DISPLAY BY NAME g_inba_m.inba007,g_inba_m.inba007_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_inba_m.inba007_desc = s_desc_get_acc_desc(g_inba007_acc,g_inba_m.inba007)
            DISPLAY BY NAME g_inba_m.inba007_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba007
            #add-point:BEFORE FIELD inba007 name="input.b.inba007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba007
            #add-point:ON CHANGE inba007 name="input.g.inba007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba008
            #add-point:BEFORE FIELD inba008 name="input.b.inba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba008
            
            #add-point:AFTER FIELD inba008 name="input.a.inba008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inba008
            #add-point:ON CHANGE inba008 name="input.g.inba008"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.inba001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba001
            #add-point:ON ACTION controlp INFIELD inba001 name="input.c.inba001"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbasite
            #add-point:ON ACTION controlp INFIELD inbasite name="input.c.inbasite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inba_m.inbasite         
            LET g_qryparam.where = s_aooi500_q_where(g_prog,g_site_str,g_inba_m.inbasite,'i')   #150308-00001#4 150309 by lori add 'i'

            CALL q_ooef001_24()                               
            LET g_inba_m.inbasite = g_qryparam.return1       
            LET g_inba_m.inbasite_desc = s_desc_get_department_desc(g_inba_m.inbasite)
            DISPLAY BY NAME g_inba_m.inbasite ,g_inba_m.inbasite_desc
            
            NEXT FIELD inbasite 
            #END add-point
 
 
         #Ctrlp:input.c.inbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbadocdt
            #add-point:ON ACTION controlp INFIELD inbadocdt name="input.c.inbadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbadocno
            #add-point:ON ACTION controlp INFIELD inbadocno name="input.c.inbadocno"
            LET l_ooef004 = ''
            SELECT ooef004 
              INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise 
               AND ooef001 = g_inba_m.inbasite
               AND ooefstus = 'Y'
               
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inba_m.inbadocno             #給予default值
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog
            #160711-00040#15 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#15 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_inba_m.inbadocno = g_qryparam.return1              

            DISPLAY g_inba_m.inbadocno TO inbadocno              #

            NEXT FIELD inbadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba002
            #add-point:ON ACTION controlp INFIELD inba002 name="input.c.inba002"
            
            #END add-point
 
 
         #Ctrlp:input.c.inba012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba012
            #add-point:ON ACTION controlp INFIELD inba012 name="input.c.inba012"
            
            #END add-point
 
 
         #Ctrlp:input.c.inba014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba014
            #add-point:ON ACTION controlp INFIELD inba014 name="input.c.inba014"
            
            #END add-point
 
 
         #Ctrlp:input.c.inba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba003
            #add-point:ON ACTION controlp INFIELD inba003 name="input.c.inba003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inba_m.inba003  
            CALL q_ooag001()                                
            LET g_inba_m.inba003 = g_qryparam.return1              

            #說明欄位
            LET g_inba_m.inba003_desc = s_desc_get_person_desc(g_inba_m.inba003)             
            DISPLAY BY NAME g_inba_m.inba003,g_inba_m.inba003_desc 
            #160604-00009#76 20160622 add by beckxie---S
            #帶值：所屬部門
            SELECT ooag003 INTO g_inba_m.inba004
              FROM ooag_t
             WHERE ooagent = g_enterprise
               AND ooag001 = g_inba_m.inba003
            LET g_inba_m.inba004_desc = s_desc_get_department_desc(g_inba_m.inba004)
            DISPLAY BY NAME g_inba_m.inba004,g_inba_m.inba004_desc 
            #160604-00009#76 20160622 add by beckxie---E
            NEXT FIELD inba003    
            #END add-point
 
 
         #Ctrlp:input.c.inba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba004
            #add-point:ON ACTION controlp INFIELD inba004 name="input.c.inba004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inba_m.inba004 
            IF cl_null(g_inba_m.inbadocdt) THEN
               LET g_qryparam.arg1 = g_today
            ELSE            
               LET g_qryparam.arg1 = g_inba_m.inbadocdt
            END IF

            CALL q_ooeg001()                              
            
            LET g_inba_m.inba004 = g_qryparam.return1      
            LET g_inba_m.inba004_desc = s_desc_get_department_desc(g_inba_m.inba004)  
            DISPLAY BY NAME g_inba_m.inba004,g_inba_m.inba004_desc 
            
            NEXT FIELD inba004     
            #END add-point
 
 
         #Ctrlp:input.c.inba013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba013
            #add-point:ON ACTION controlp INFIELD inba013 name="input.c.inba013"
            #150629-00016#1 150716 by lori---(S)
            INITIALIZE g_qryparam.* TO NULL   #160801-00022#1 20160801 add by beckxie
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inba_m.inba013
                  
            CASE g_inba_m.inba012
               WHEN '1'   #供應商
                  CALL q_pmaa001_10()                             
                  LET g_inba_m.inba013 = g_qryparam.return1   
                  LET g_inba_m.inba013_desc = s_desc_get_trading_partner_abbr_desc(g_inba_m.inba013)
                  
               WHEN '2'   #專櫃                  
                  LET g_qryparam.arg1 = g_inba_m.inbasite 
                  
                  CALL q_mhae001_2()                             
                  LET g_inba_m.inba013 = g_qryparam.return1   
                  LET g_inba_m.inba013_desc = s_desc_get_counter_desc(g_inba_m.inba013)
                  
               WHEN '3'   #內部員工                  
                  #CALL q_mhae001_2()                             #151117 by lori mark
                  #151117 by lori add(S)
                  IF cl_null(g_inba_m.inbadocdt) THEN
                     LET g_qryparam.arg1 = g_today
                  ELSE
                     LET g_qryparam.arg1 = g_inba_m.inbadocdt
                  END IF
                  CALL q_ooeg001()
                  #151117 by lori add(E)
                  LET g_inba_m.inba013 = g_qryparam.return1   
                  LET g_inba_m.inba013_desc = s_desc_get_department_desc(g_inba_m.inba013)
            END CASE

            DISPLAY g_inba_m.inba013 TO inba013              
            DISPLAY g_inba_m.inba013_desc TO inba013_desc
                  
            NEXT FIELD inba013  
            #150629-00016#1 150716 by lori---(E)
            #END add-point
 
 
         #Ctrlp:input.c.inbaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbaunit
            #add-point:ON ACTION controlp INFIELD inbaunit name="input.c.inbaunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbastus
            #add-point:ON ACTION controlp INFIELD inbastus name="input.c.inbastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.inba005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba005
            #add-point:ON ACTION controlp INFIELD inba005 name="input.c.inba005"
            
            #END add-point
 
 
         #Ctrlp:input.c.inba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba006
            #add-point:ON ACTION controlp INFIELD inba006 name="input.c.inba006"
            #150629-00016#1 150716 by lori---(S)
            IF g_inba_m.inba005 = '11' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_inba_m.inba006  
               LET g_qryparam.arg1 = g_inba_m.inbasite
               LET g_qryparam.arg2 = '1'
               CALL q_inbadocno_8()                              
               
               LET g_inba_m.inba006 = g_qryparam.return1              
               DISPLAY BY NAME g_inba_m.inba006  
               
               NEXT FIELD inba006
            END IF   
            #150629-00016#1 150716 by lori---(E)
            #END add-point
 
 
         #Ctrlp:input.c.inba015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba015
            #add-point:ON ACTION controlp INFIELD inba015 name="input.c.inba015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inba_m.inba015        #給予default值
            LET g_qryparam.arg1 = g_inba_m.inbasite
            #151113-00020#1 151119 By pomelo add(S)
            IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
               LET l_type = '1'
            ELSE
               LET l_type = '2'
            END IF
            IF l_type = '2' THEN
            #151113-00020#1 151119 By pomelo add(E)
            #IF g_argv[1] = '2' THEN     #151113-00020#1 151119 By pomelo mark
               LET g_qryparam.where = "inaa016 = 'N'"
            END IF
            CALL q_inaa001_6()                                #呼叫開窗
            LET g_inba_m.inba015 = g_qryparam.return1              
            DISPLAY g_inba_m.inba015 TO inba015
            LET g_inba_m.inba015_desc = s_desc_get_stock_desc('',g_inba_m.inba015)
            DISPLAY BY NAME g_inba_m.inba015_desc
            NEXT FIELD inba015                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.inba203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba203
            #add-point:ON ACTION controlp INFIELD inba203 name="input.c.inba203"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inba_m.inba203
            
            LET g_qryparam.arg1 = g_sys
            CALL q_rtax001_3()
            LET g_inba_m.inba203 = g_qryparam.return1 
            DISPLAY g_inba_m.inba203 TO inba203
            CALL s_desc_get_rtaxl003_desc(g_inba_m.inba203)
               RETURNING g_inba_m.inba203_desc
            DISPLAY BY NAME g_inba_m.inba203_desc
            NEXT FIELD inba203
            #END add-point
 
 
         #Ctrlp:input.c.inba205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba205
            #add-point:ON ACTION controlp INFIELD inba205 name="input.c.inba205"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inba_m.inba205
            
            LET g_qryparam.arg1 = g_inba_m.inbadocdt
            CALL q_ooeg001()
            LET g_inba_m.inba205 = g_qryparam.return1
            DISPLAY g_inba_m.inba205 TO inba205
            CALL s_desc_get_department_desc(g_inba_m.inba205)
               RETURNING g_inba_m.inba205_desc
            DISPLAY BY NAME g_inba_m.inba205_desc
            NEXT FIELD inba205
            #END add-point
 
 
         #Ctrlp:input.c.inba208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba208
            #add-point:ON ACTION controlp INFIELD inba208 name="input.c.inba208"
            
            #END add-point
 
 
         #Ctrlp:input.c.inba206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba206
            #add-point:ON ACTION controlp INFIELD inba206 name="input.c.inba206"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inba_m.inba206
            
            LET g_qryparam.arg1 = g_inba_m.inbasite
            CALL q_inaa001_6()

            LET g_inba_m.inba206 = g_qryparam.return1
            DISPLAY g_inba_m.inba206 TO inba206
            LET g_inba_m.inba206_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inba_m.inba206)
            DISPLAY BY NAME g_inba_m.inba206_desc
            NEXT FIELD inba206
            #END add-point
 
 
         #Ctrlp:input.c.inba207
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba207
            #add-point:ON ACTION controlp INFIELD inba207 name="input.c.inba207"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inba_m.inba207
            
            LET g_qryparam.arg1 = g_sys
            CALL q_rtax001_3()
            
            LET g_inba_m.inba207 = g_qryparam.return1
            DISPLAY g_inba_m.inba207 TO inba207
            CALL s_desc_get_rtaxl003_desc(g_inba_m.inba207)
               RETURNING g_inba_m.inba207_desc
            DISPLAY BY NAME g_inba_m.inba207_desc
            NEXT FIELD inba207
            #END add-point
 
 
         #Ctrlp:input.c.inba204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba204
            #add-point:ON ACTION controlp INFIELD inba204 name="input.c.inba204"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inba_m.inba204
            CALL q_pmaa001_3()
            
            LET g_inba_m.inba204 = g_qryparam.return1              
            DISPLAY g_inba_m.inba204 TO inba204
            CALL s_desc_get_trading_partner_abbr_desc(g_inba_m.inba204)
               RETURNING g_inba_m.inba204_desc
            DISPLAY BY NAME g_inba_m.inba204_desc
            NEXT FIELD inba204
            #END add-point
 
 
         #Ctrlp:input.c.inba007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba007
            #add-point:ON ACTION controlp INFIELD inba007 name="input.c.inba007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inba_m.inba007  
            LET g_qryparam.arg1 = g_inba007_acc
            CALL q_oocq002()                              

            LET g_inba_m.inba007 = g_qryparam.return1              
            LET g_inba_m.inba007_desc = s_desc_get_acc_desc(g_inba007_acc,g_inba_m.inba007)
            DISPLAY BY NAME g_inba_m.inba007,g_inba_m.inba007_desc         
           
            NEXT FIELD inba007                          
            #END add-point
 
 
         #Ctrlp:input.c.inba008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba008
            #add-point:ON ACTION controlp INFIELD inba008 name="input.c.inba008"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_inba_m.inbadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_inba_m.inbasite,g_inba_m.inbadocno,g_inba_m.inbadocdt,g_prog) 
                    RETURNING l_success,g_inba_m.inbadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_inba_m.inbadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  
                  NEXT FIELD inbadocno
               END IF
               
               LET g_inba_m.inbaunit = g_inba_m.inbasite
               #end add-point
               
               INSERT INTO inba_t (inbaent,inba001,inbasite,inbadocdt,inbadocno,inba002,inba012,inba014, 
                   inba003,inba004,inba013,inbaunit,inbastus,inba005,inba006,inba015,inba203,inba205, 
                   inba208,inba206,inba207,inba204,inba007,inba008,inbaownid,inbaowndp,inbacrtid,inbacrtdp, 
                   inbacrtdt,inbamodid,inbamoddt,inbacnfid,inbacnfdt,inbapstid,inbapstdt)
               VALUES (g_enterprise,g_inba_m.inba001,g_inba_m.inbasite,g_inba_m.inbadocdt,g_inba_m.inbadocno, 
                   g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003,g_inba_m.inba004, 
                   g_inba_m.inba013,g_inba_m.inbaunit,g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006, 
                   g_inba_m.inba015,g_inba_m.inba203,g_inba_m.inba205,g_inba_m.inba208,g_inba_m.inba206, 
                   g_inba_m.inba207,g_inba_m.inba204,g_inba_m.inba007,g_inba_m.inba008,g_inba_m.inbaownid, 
                   g_inba_m.inbaowndp,g_inba_m.inbacrtid,g_inba_m.inbacrtdp,g_inba_m.inbacrtdt,g_inba_m.inbamodid, 
                   g_inba_m.inbamoddt,g_inba_m.inbacnfid,g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_inba_m:",SQLERRMESSAGE 
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
                  CALL aint911_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aint911_b_fill()
                  CALL aint911_b_fill2('0')
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
               CALL aint911_inba_t_mask_restore('restore_mask_o')
               
               UPDATE inba_t SET (inba001,inbasite,inbadocdt,inbadocno,inba002,inba012,inba014,inba003, 
                   inba004,inba013,inbaunit,inbastus,inba005,inba006,inba015,inba203,inba205,inba208, 
                   inba206,inba207,inba204,inba007,inba008,inbaownid,inbaowndp,inbacrtid,inbacrtdp,inbacrtdt, 
                   inbamodid,inbamoddt,inbacnfid,inbacnfdt,inbapstid,inbapstdt) = (g_inba_m.inba001, 
                   g_inba_m.inbasite,g_inba_m.inbadocdt,g_inba_m.inbadocno,g_inba_m.inba002,g_inba_m.inba012, 
                   g_inba_m.inba014,g_inba_m.inba003,g_inba_m.inba004,g_inba_m.inba013,g_inba_m.inbaunit, 
                   g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006,g_inba_m.inba015,g_inba_m.inba203, 
                   g_inba_m.inba205,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba207,g_inba_m.inba204, 
                   g_inba_m.inba007,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaowndp,g_inba_m.inbacrtid, 
                   g_inba_m.inbacrtdp,g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
                   g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstdt)
                WHERE inbaent = g_enterprise AND inbadocno = g_inbadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aint911_inba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_inba_m_t)
               LET g_log2 = util.JSON.stringify(g_inba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               ##160604-00009#94 Add By Ken 160627(S)
               #IF g_argv[1] = '5' THEN
               #   LET l_cnt = 0
               #   SELECT COUNT(inbbseq) INTO l_cnt
               #     FROM inbb_t
               #    WHERE inbbent = g_enterprise
               #      AND inbbdocno = g_inba_m.inbadocno
               #   IF l_cnt = 0 THEN
               #      IF cl_ask_confirm('agc-00112') THEN
               #         CALL aint911_02('1',g_inba_m.inbadocno,g_inba_m.inbasite)
               #         CALL aint911_b_fill()
               #         LET INT_FLAG = 0
               #      END IF 
               #   END IF
               #END IF                     
               ##160604-00009#94 Add By Ken 160627(E)      
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_inbadocno_t = g_inba_m.inbadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aint911.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_inbb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_detail_memo
            LET g_action_choice="open_detail_memo"
            IF cl_auth_chk_act("open_detail_memo") THEN
               
               #add-point:ON ACTION open_detail_memo name="input.detail_input.page1.open_detail_memo"
               IF NOT cl_null(g_inba_m.inbadocno)  THEN
                  CALL aooi360_01('7',g_inba_m.inbadocno,'','','','','','','','','')
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #150827-00013#1 140827 by lori mark and add---(S)
            ##150629-00016#1 150817 by lori add---(S)
            #IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
            #   LET l_success = ''
            #   CALL aint911_auto_gen_detail() RETURNING l_success
            #END IF      
            ##150629-00016#1 150817 by lori add---(E)  

            LET l_cnt = 0 
            SELECT COUNT(*) INTO l_cnt
              FROM inbb_t
             WHERE inbbent = g_enterprise
               AND inbbdocno = g_inba_m.inbadocno             
            IF g_argv[1] = '2' AND NOT cl_null(g_inba_m.inba006) AND l_cnt = 0 THEN
               LET l_success = ''
               CALL aint911_auto_gen_detail() RETURNING l_success
            END IF
            #150827-00013#1 140827 by lori mark and add---(E)            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint911_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_inbb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            #160604-00009#94 Add By Ken 160627(S)
            IF g_argv[1] = '5' THEN
               LET l_cnt = 0
               SELECT COUNT(inbbseq) INTO l_cnt
                 FROM inbb_t
                WHERE inbbent = g_enterprise
                  AND inbbdocno = g_inba_m.inbadocno
               IF l_cnt = 0 THEN
                  IF cl_ask_confirm('agc-00112') THEN
                     CALL aint911_02('1',g_inba_m.inbadocno,g_inba_m.inbasite)
                     CALL aint911_b_fill()
                     LET INT_FLAG = 0
                  END IF 
               END IF
            END IF                     
            #160604-00009#94 Add By Ken 160627(E)               
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
            OPEN aint911_cl USING g_enterprise,g_inba_m.inbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint911_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint911_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_inbb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_inbb_d[l_ac].inbbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inbb_d_t.* = g_inbb_d[l_ac].*  #BACKUP
               LET g_inbb_d_o.* = g_inbb_d[l_ac].*  #BACKUP
               CALL aint911_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aint911_set_no_entry_b(l_cmd)
               IF NOT aint911_lock_b("inbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint911_bcl INTO g_inbb_d[l_ac].inbbseq,g_inbb_d[l_ac].inbb017,g_inbb_d[l_ac].inbb211, 
                      g_inbb_d[l_ac].inbb212,g_inbb_d[l_ac].inbb200,g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002, 
                      g_inbb_d[l_ac].inbb213,g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb215,g_inbb_d[l_ac].inbb007, 
                      g_inbb_d[l_ac].inbb008,g_inbb_d[l_ac].inbb009,g_inbb_d[l_ac].inbb210,g_inbb_d[l_ac].inbb003, 
                      g_inbb_d[l_ac].inbb220,g_inbb_d[l_ac].inbb221,g_inbb_d[l_ac].inbb222,g_inbb_d[l_ac].inbb223, 
                      g_inbb_d[l_ac].inbb201,g_inbb_d[l_ac].inbb202,g_inbb_d[l_ac].inbb203,g_inbb_d[l_ac].inbb011, 
                      g_inbb_d[l_ac].inbb012,g_inbb_d[l_ac].inbb010,g_inbb_d[l_ac].inbb218,g_inbb_d[l_ac].inbb219, 
                      g_inbb_d[l_ac].inbb216,g_inbb_d[l_ac].inbb217,g_inbb_d[l_ac].inbb224,g_inbb_d[l_ac].inbb225, 
                      g_inbb_d[l_ac].inbb209,g_inbb_d[l_ac].inbb207,g_inbb_d[l_ac].inbb208,g_inbb_d[l_ac].inbb205, 
                      g_inbb_d[l_ac].inbb206,g_inbb_d[l_ac].inbb016,g_inbb_d[l_ac].inbb018,g_inbb_d[l_ac].inbb020, 
                      g_inbb_d[l_ac].inbb204,g_inbb_d[l_ac].inbb022,g_inbb_d[l_ac].inbb021,g_inbb_d[l_ac].inbbsite, 
                      g_inbb_d[l_ac].inbbunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inbb_d_t.inbbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inbb_d_mask_o[l_ac].* =  g_inbb_d[l_ac].*
                  CALL aint911_inbb_t_mask()
                  LET g_inbb_d_mask_n[l_ac].* =  g_inbb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint911_show()
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
            INITIALIZE g_inbb_d[l_ac].* TO NULL 
            INITIALIZE g_inbb_d_t.* TO NULL 
            INITIALIZE g_inbb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_inbb_d[l_ac].inbb210 = "0"
      LET g_inbb_d[l_ac].inbb223 = "0"
      LET g_inbb_d[l_ac].inbb203 = "0"
      LET g_inbb_d[l_ac].inbb012 = "0"
      LET g_inbb_d[l_ac].inbb219 = "0"
      LET g_inbb_d[l_ac].inbb225 = "0"
      LET g_inbb_d[l_ac].inbb207 = "0"
      LET g_inbb_d[l_ac].inbb208 = "0"
      LET g_inbb_d[l_ac].inbb205 = "0"
      LET g_inbb_d[l_ac].inbb206 = "0"
      LET g_inbb_d[l_ac].inbb018 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #項次
            SELECT MAX(inbbseq) INTO l_seq
              FROM inbb_t
             WHERE inbbent = g_enterprise
               AND inbbdocno = g_inba_m.inbadocno
            IF cl_null(l_seq) THEN
               LET l_seq = 0
            END IF
            
            LET g_inbb_d[l_ac].inbbseq = l_seq + 1
                       
            LET g_inbb_d[l_ac].inbbsite = g_inba_m.inbasite    #營運據點
            LET g_inbb_d[l_ac].inbbunit = g_inba_m.inbasite    #應用組織
            #150507-00001#8 150527 by lori add---(S)
            LET g_inbb_d[l_ac].inbb204 =  g_inba_m.inbadocdt   #製造日期   
            #151113-00020#1 151119 By pomelo add(S)
            IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
               LET l_type = '1'
            ELSE
               LET l_type = '2'
            END IF
            IF l_type = '1' THEN
            #151113-00020#1 151119 By pomelo add(E)
            #IF g_argv[1] = '1' THEN       #151113-00020#1 151119 By pomelo mark
               LET g_inbb_d[l_ac].inbb022 =  g_inba_m.inbadocdt   #有效日期 
            END IF   
            #150507-00001#8 150527 by lori add---(E)   
            
            #150710-00012#1 150713 By benson --- S
            LET g_inbb_d[l_ac].inbb007 = g_inba_m.inba015  
            LET g_inbb_d[l_ac].inbb007_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007)              
            LET g_inbb_d[l_ac].inbb016 = g_inba_m.inba007  
            LET g_inbb_d[l_ac].inbb016_desc = s_desc_get_acc_desc(g_inba007_acc,g_inbb_d[l_ac].inbb016)
            #150710-00012#1 150713 By benson --- E
            
            CALL aint911_inbb209_default()                  #150629-00016#1 150716 by lori add
            LET g_inbb_d[l_ac].inbb017 = g_inba_m.inba006   #150629-00016#1 150716 by lori add
            
            #151113-00020#1 151116 By pomelo add(S)
            #轉入庫位
            IF NOT cl_null(g_inba_m.inba206) THEN
               LET g_inbb_d[l_ac].inbb220 = g_inba_m.inba206
               LET g_inbb_d[l_ac].inbb220_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb220)              
            END IF
            #151113-00020#1 151116 By pomelo add(E)
            #end add-point
            LET g_inbb_d_t.* = g_inbb_d[l_ac].*     #新輸入資料
            LET g_inbb_d_o.* = g_inbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint911_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aint911_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inbb_d[li_reproduce_target].* = g_inbb_d[li_reproduce].*
 
               LET g_inbb_d[li_reproduce_target].inbbseq = NULL
 
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
            IF cl_null(g_inbb_d[l_ac].inbb002) THEN   LET g_inbb_d[l_ac].inbb002 = ' '   END IF
            IF cl_null(g_inbb_d[l_ac].inbb003) THEN   LET g_inbb_d[l_ac].inbb003 = ' '   END IF
            IF cl_null(g_inbb_d[l_ac].inbb008) THEN   LET g_inbb_d[l_ac].inbb008 = ' '   END IF
            IF cl_null(g_inbb_d[l_ac].inbb009) THEN   LET g_inbb_d[l_ac].inbb009 = ' '   END IF
            
            #150507-00001#8 150527 by lori add---(S)
            #有效日期 
            IF cl_null(g_inbb_d[l_ac].inbb022) THEN
               LET g_inbb_d[l_ac].inbb022 =  g_inbb_d[l_ac].inbb204   
            END IF   
            #150507-00001#8 150527 by lori add---(E)
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM inbb_t 
             WHERE inbbent = g_enterprise AND inbbdocno = g_inba_m.inbadocno
 
               AND inbbseq = g_inbb_d[l_ac].inbbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inba_m.inbadocno
               LET gs_keys[2] = g_inbb_d[g_detail_idx].inbbseq
               CALL aint911_insert_b('inbb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_inbb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint911_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #新增一筆資料後需同步新增一筆[T:雜項庫存異動庫儲批明細檔]
               #151130-00008#11 160120 By pomelo mark(S)
               IF NOT aint911_ins_inbc() THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               #151130-00008#11 160120 By pomelo mark(E)
               #151130-00008#11 160120 By pomelo add(S)
               #IF NOT s_aint911_ins_inbc('1',g_inba_m.inbadocno,g_inbb_d[l_ac].inbbseq) THEN
               #   CALL s_transaction_end('N','0')
               #   CANCEL INSERT
               #END IF
               #151130-00008#11 160120 By pomelo add(E)
               CALL aint911_b_fill()
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
               LET gs_keys[01] = g_inba_m.inbadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_inbb_d_t.inbbseq
 
            
               #刪除同層單身
               IF NOT aint911_delete_b('inbb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint911_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint911_key_delete_b(gs_keys,'inbb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint911_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aint911_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               #同步刪除對應的[T:雜項庫存異動庫儲批明細檔]與[T:製造批序號庫存異動明細檔]
               IF NOT aint911_del_inbc() THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               #end add-point
               LET l_count = g_inbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_inbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbbseq
            #add-point:BEFORE FIELD inbbseq name="input.b.page1.inbbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbbseq
            
            #add-point:AFTER FIELD inbbseq name="input.a.page1.inbbseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_inba_m.inbadocno IS NOT NULL AND g_inbb_d[g_detail_idx].inbbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inba_m.inbadocno != g_inbadocno_t OR g_inbb_d[g_detail_idx].inbbseq != g_inbb_d_t.inbbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbb_t WHERE "||"inbbent = '" ||g_enterprise|| "' AND "||"inbbdocno = '"||g_inba_m.inbadocno ||"' AND "|| "inbbseq = '"||g_inbb_d[g_detail_idx].inbbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbbseq
            #add-point:ON CHANGE inbbseq name="input.g.page1.inbbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb017
            #add-point:BEFORE FIELD inbb017 name="input.b.page1.inbb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb017
            
            #add-point:AFTER FIELD inbb017 name="input.a.page1.inbb017"
            #150629-00016#1  150715 by lori add---(S)
            IF g_argv[1] = '2' THEN
               IF NOT cl_null(g_inbb_d[l_ac].inbb017) THEN
                  IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_inbb_d[l_ac].inbb017 != g_inbb_d_o.inbb017 OR g_inbb_d_o.inbb017 IS NULL )) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_inba_m.inbasite
                     LET g_chkparam.arg2 = g_inbb_d[l_ac].inbb017
                      #160318-00025#20  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="ais-00082:sub-01311|aint301|",cl_get_progname("aint301",g_lang,"2"),"|:EXEPROGaint301"
                     #160318-00025#20  by 07900 --add-end
                     IF NOT cl_chk_exist("v_inbadocno_1") THEN
                        LET g_inbb_d[l_ac].inbb017 = g_inbb_d_o.inbb017
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF 
            
            LET g_inbb_d_o.inbb017 = g_inbb_d[l_ac].inbb017
            #150629-00016#1  150715 by lori add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb017
            #add-point:ON CHANGE inbb017 name="input.g.page1.inbb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb211
            #add-point:BEFORE FIELD inbb211 name="input.b.page1.inbb211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb211
            
            #add-point:AFTER FIELD inbb211 name="input.a.page1.inbb211"
            #150629-00016#1 150818 by lori---(S)
            IF NOT cl_null(g_inbb_d[l_ac].inbb211) THEN
               IF g_inbb_d[l_ac].inbb211 <> g_inbb_d_o.inbb211 OR cl_null(g_inbb_d[l_ac].inbb211) THEN
                  IF NOT aint911_detail_source_chk(1) THEN
                     LET g_inbb_d[l_ac].inbb211 = g_inbb_d_o.inbb211
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF
            
            LET g_inbb_d_o.inbb211 = g_inbb_d[l_ac].inbb211
            #150629-00016#1 150818 by lori---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb211
            #add-point:ON CHANGE inbb211 name="input.g.page1.inbb211"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb212
            #add-point:BEFORE FIELD inbb212 name="input.b.page1.inbb212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb212
            
            #add-point:AFTER FIELD inbb212 name="input.a.page1.inbb212"
            #150629-00016#1 150818 by lori---(S)
            IF NOT cl_null(g_inbb_d[l_ac].inbb212) THEN
               IF g_inbb_d[l_ac].inbb212 <> g_inbb_d_o.inbb212 OR cl_null(g_inbb_d[l_ac].inbb212) THEN
                  IF NOT aint911_detail_source_chk(2) THEN
                     LET g_inbb_d[l_ac].inbb212 = g_inbb_d_o.inbb212
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF
            
            LET g_inbb_d_o.inbb212 = g_inbb_d[l_ac].inbb212
            #150629-00016#1 150818 by lori---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb212
            #add-point:ON CHANGE inbb212 name="input.g.page1.inbb212"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb200
            
            #add-point:AFTER FIELD inbb200 name="input.a.page1.inbb200"
            LET l_imaa005 = ''
            LET l_imaa006 = ''
            LET l_imaf055 = ''
            LET l_imaf061 = ''
            LET l_imaf091 = ''
            LET l_imaf092 = '' 
            
            LET g_inbb_d[l_ac].inbb001_desc = ''
            LET g_inbb_d[l_ac].inbb001_desc_desc = ''
            
            IF NOT cl_null(g_inbb_d[l_ac].inbb200) THEN
               IF g_inbb_d[l_ac].inbb200 != g_inbb_d_o.inbb200 OR cl_null(g_inbb_d_o.inbb200) THEN   #150427-00012#3  150507 by lori mod
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inbb_d[l_ac].inbb200
                  IF NOT cl_chk_exist("v_imay003_1") THEN
                     LET g_inbb_d[l_ac].inbb200 = g_inbb_d_o.inbb200
                     CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb001) RETURNING g_inbb_d[l_ac].inbb001_desc,g_inbb_d[l_ac].inbb001_desc_desc
                     
                     NEXT FIELD CURRENT
                  END IF

                 #150629-00016#1 150818 by lori---(S)
                 IF NOT aint911_detail_source_chk(3) THEN
                    LET g_inbb_d[l_ac].inbb200 = g_inbb_d_o.inbb200
                    NEXT FIELD CURRENT
                 END IF
                 #150629-00016#1 150818 by lori---(E)
            
                  CALL s_apmt840_get_imay001(g_inbb_d[l_ac].inbb200) RETURNING g_inbb_d[l_ac].inbb001 
                  
                  IF NOT cl_null(g_inbb_d[l_ac].inbb001) THEN
                     IF g_inbb_d[l_ac].inbb001 != g_inbb_d_o.inbb001 OR cl_null(g_inbb_d_o.inbb001) THEN
                        IF NOT aint911_inbb001_chk(g_inbb_d[l_ac].inbb001) THEN
                          LET g_inbb_d[l_ac].inbb200 = g_inbb_d_o.inbb200
                          LET g_inbb_d[l_ac].inbb001 = g_inbb_d_o.inbb001
                          CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb001) 
                             RETURNING g_inbb_d[l_ac].inbb001_desc,g_inbb_d[l_ac].inbb001_desc_desc    
                          
                          CALL aint911_inbb001_clear()
                          NEXT FIELD CURRENT                        
                        END IF   
                        #商品新舊值不同時,產品特徵/庫/儲/批/有效日
                        LET  g_inbb_d[l_ac].inbb002 = ''
                        LET  g_inbb_d[l_ac].inbb007 = ''
                        LET  g_inbb_d[l_ac].inbb008 = ''
                        LET  g_inbb_d[l_ac].inbb009 = ''
                        LET  g_inbb_d[l_ac].inbb022 = ''     #150507-00001#8 150527 by lori add                      
                     END IF 
                     
                     #150507-00001#8 150527 by lori add---(S)
                     IF NOT cl_null(g_inbb_d[l_ac].inbb204) THEN
                        LET l_success = '' 
                        LET l_inbb022 = ''
                        CALL s_lot_out_effdate(g_inba_m.inbasite,
                                               g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,
                                               g_inbb_d[l_ac].inbb204,g_inbb_d[l_ac].inbb009)
                          RETURNING l_success,l_inbb022 
                        IF l_success THEN
                           LET  g_inbb_d[l_ac].inbb022 = l_inbb022
                        ELSE
                           LET g_inbb_d[l_ac].inbb022 = g_inbb_d_o.inbb022
                           NEXT FIELD CURRENT
                        END IF 
                     END IF 
                     #150507-00001#8 150527 by lori add---(E)                   
                     CALL aint911_inbb201_default()
                     CALL s_aint911_get_prod_info(g_inbb_d[l_ac].inbb001)
                        RETURNING l_imaa005,l_imaa006,l_imaf055,l_imaf061,l_imaf091,l_imaf092 
                  
                     CALL aint911_inbb001_default(g_inbb_d[l_ac].inbb001)
                     
                     CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb001) 
                        RETURNING g_inbb_d[l_ac].inbb001_desc,g_inbb_d[l_ac].inbb001_desc_desc                      
                  
                     CALL aint911_inbb207_default()   #150629-00016#1 150716 by lori add
                     CALL aint911_inbb205_default()   #150629-00016#1 150716 by lori add
                  END IF                     
               END IF            
            END IF

            CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb001) 
               RETURNING g_inbb_d[l_ac].inbb001_desc,g_inbb_d[l_ac].inbb001_desc_desc 
                        
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_required_b()
            CALL aint911_set_required_b()
            CALL aint911_set_no_entry_b(l_cmd)
            
            LET g_inbb_d_o.inbb200 = g_inbb_d[l_ac].inbb200
            LET g_inbb_d_o.inbb001 = g_inbb_d[l_ac].inbb001
            LET g_inbb_d_o.inbb022 = g_inbb_d[l_ac].inbb022   #150507-00001#8 150527 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb200
            #add-point:BEFORE FIELD inbb200 name="input.b.page1.inbb200"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb200
            #add-point:ON CHANGE inbb200 name="input.g.page1.inbb200"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb001
            
            #add-point:AFTER FIELD inbb001 name="input.a.page1.inbb001"
            LET l_imaa005 = ''
            LET l_imaa006 = ''
            LET l_imaf055 = ''
            LET l_imaf061 = ''
            LET l_imaf091 = ''
            LET l_imaf092 = '' 
            
            LET g_inbb_d[l_ac].inbb001_desc = ''
            LET g_inbb_d[l_ac].inbb001_desc_desc = ''
            
            IF NOT cl_null(g_inbb_d[l_ac].inbb001) THEN
               IF g_inbb_d[l_ac].inbb001 != g_inbb_d_o.inbb001 OR cl_null(g_inbb_d_o.inbb001) THEN   #150427-00012#3  150507 by lori mod
                  IF NOT aint911_inbb001_chk(g_inbb_d[l_ac].inbb001) THEN
                     LET g_inbb_d[l_ac].inbb001 = g_inbb_d_o.inbb001
                     CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb001) 
                        RETURNING g_inbb_d[l_ac].inbb001_desc,g_inbb_d[l_ac].inbb001_desc_desc 
                     
                     NEXT FIELD CURRENT                   
                  END IF
                  
                  #商品新舊值不同時,產品特徵/庫/儲/批/有效日
                  CALL aint911_inbb001_clear()
                  LET  g_inbb_d[l_ac].inbb022 = ''   #150507-00001#8 150527 by lori add


                  CALL aint911_inbb201_default()
                  
                  #150507-00001#8 150527 by lori add---(S)
                  IF NOT cl_null(g_inbb_d[l_ac].inbb204) THEN
                     LET l_success = '' 
                     LET l_inbb022 = ''
                     CALL s_lot_out_effdate(g_inba_m.inbasite,
                                            g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,
                                            g_inbb_d[l_ac].inbb204,g_inbb_d[l_ac].inbb009)
                       RETURNING l_success,l_inbb022 
                     IF l_success THEN
                        LET  g_inbb_d[l_ac].inbb022 = l_inbb022
                     ELSE
                        LET g_inbb_d[l_ac].inbb022 = g_inbb_d_o.inbb022
                        NEXT FIELD CURRENT
                     END IF 
                  END IF 
                  #150507-00001#8 150527 by lori add---(E)  
                  
                  CALL aint911_inbb001_default(g_inbb_d[l_ac].inbb001)
                  CALL aint911_inbb207_default()   #150629-00016#1 150716 by lori add
                  CALL aint911_inbb205_default()   #150629-00016#1 150716 by lori add
               END IF 
            END IF
            CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb001) 
               RETURNING g_inbb_d[l_ac].inbb001_desc,g_inbb_d[l_ac].inbb001_desc_desc           
                            
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_required_b()
            CALL aint911_set_required_b()
            CALL aint911_set_no_entry_b(l_cmd)
            
            LET g_inbb_d_o.inbb200 = g_inbb_d[l_ac].inbb200
            LET g_inbb_d_o.inbb001 = g_inbb_d[l_ac].inbb001
            LET g_inbb_d_o.inbb022 = g_inbb_d[l_ac].inbb022   #150507-00001#8 150527 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb001
            #add-point:BEFORE FIELD inbb001 name="input.b.page1.inbb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb001
            #add-point:ON CHANGE inbb001 name="input.g.page1.inbb001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb002
            
            #add-point:AFTER FIELD inbb002 name="input.a.page1.inbb002"
            LET g_inbb_d[l_ac].inbb002_desc = ''
            IF NOT cl_null(g_inbb_d[l_ac].inbb002) THEN
               IF g_inbb_d[l_ac].inbb002 != g_inbb_d_o.inbb002 OR g_inbb_d_o.inbb002 IS NULL THEN   #150427-00012#3  150507 by lori mod
                  IF NOT s_feature_check(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002) THEN
                     LET g_inbb_d[l_ac].inbb002 = g_inbb_d_o.inbb002
                     CALL s_feature_description(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002) 
                        RETURNING l_success,g_inbb_d[l_ac].inbb002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#2--add--start--
                  IF NOT s_feature_direct_input(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,g_inbb_d_o.inbb002,g_inba_m.inbadocno,g_inba_m.inbasite) THEN
                     NEXT FIELD CURRENT
                  END IF 
                  #151224-00025#2--add--end----
               
                  IF l_cmd = 'a' AND NOT cl_null(g_inbb_d[l_ac].inbb011) THEN
                     IF NOT cl_null(g_inbb_d[l_ac].inbb010) AND NOT cl_null(g_inbb_d[l_ac].inbb201) THEN
                        CALL s_aooi250_convert_qty(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb010,g_inbb_d[l_ac].inbb201,g_inbb_d[l_ac].inbb011)
                           RETURNING l_success,g_inbb_d[l_ac].inbb202
                        CALL s_aooi250_take_decimals(g_inbb_d[l_ac].inbb201,g_inbb_d[l_ac].inbb202)
                           RETURNING l_success,g_inbb_d[l_ac].inbb202                  
                     END IF   
                  END IF
                  
                  CALL aint911_inbb207_default()   #150629-00016#1 150716 by lori add
               END IF
            END IF
            
            CALL s_feature_description(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002) 
               RETURNING l_success,g_inbb_d[l_ac].inbb002_desc
               
            LET g_inbb_d_o.inbb002 = g_inbb_d[l_ac].inbb002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb002
            #add-point:BEFORE FIELD inbb002 name="input.b.page1.inbb002"
            IF cl_null(g_inbb_d[l_ac].inbb001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "ain-00489"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               NEXT FIELD inbb001
            END IF
            #160314-00009#3   add by zhujing 2016-3-16-----(S)
            IF s_feature_auto_chk(g_inbb_d[l_ac].inbb001) AND cl_null(g_inbb_d[l_ac].inbb002) THEN
               CALL s_feature_single(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,g_site,'') RETURNING l_success,g_inbb_d[l_ac].inbb002
               DISPLAY BY NAME g_inbb_d[l_ac].inbb002
               CALL s_feature_description(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002) 
                  RETURNING l_success,g_inbb_d[l_ac].inbb002_desc
            END IF
            #160314-00009#3   add by zhujing 2016-3-16-----(E)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb002
            #add-point:ON CHANGE inbb002 name="input.g.page1.inbb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb002_desc
            #add-point:BEFORE FIELD inbb002_desc name="input.b.page1.inbb002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb002_desc
            
            #add-point:AFTER FIELD inbb002_desc name="input.a.page1.inbb002_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb002_desc
            #add-point:ON CHANGE inbb002_desc name="input.g.page1.inbb002_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb213
            
            #add-point:AFTER FIELD inbb213 name="input.a.page1.inbb213"
            LET g_inbb_d[l_ac].inbb214_desc = ''
            LET g_inbb_d[l_ac].inbb214_desc_desc = ''
            
            IF NOT cl_null(g_inbb_d[l_ac].inbb213) THEN
               IF g_inbb_d[l_ac].inbb213 != g_inbb_d_o.inbb213 OR cl_null(g_inbb_d_o.inbb213) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inbb_d[l_ac].inbb213
                  IF NOT cl_chk_exist("v_imay003_1") THEN
                     LET g_inbb_d[l_ac].inbb213 = g_inbb_d_o.inbb213
                     CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb214)
                        RETURNING g_inbb_d[l_ac].inbb214_desc,g_inbb_d[l_ac].inbb214_desc_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_apmt840_get_imay001(g_inbb_d[l_ac].inbb213)
                     RETURNING g_inbb_d[l_ac].inbb214 
                  
                  IF NOT cl_null(g_inbb_d[l_ac].inbb214) THEN
                     IF g_inbb_d[l_ac].inbb214 != g_inbb_d_o.inbb214 OR cl_null(g_inbb_d_o.inbb214) THEN
                        IF NOT aint911_inbb214_chk(g_inbb_d[l_ac].inbb214) THEN
                          LET g_inbb_d[l_ac].inbb213 = g_inbb_d_o.inbb213
                          LET g_inbb_d[l_ac].inbb214 = g_inbb_d_o.inbb214
                          CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb214) 
                             RETURNING g_inbb_d[l_ac].inbb214_desc,g_inbb_d[l_ac].inbb214_desc_desc
                          NEXT FIELD CURRENT                        
                        END IF                      
                     END IF
                     CALL aint911_inbb214_def()
                  END IF
               END IF            
            END IF

            CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb214) 
               RETURNING g_inbb_d[l_ac].inbb214_desc,g_inbb_d[l_ac].inbb214_desc_desc 
            
            LET g_inbb_d_o.inbb213 = g_inbb_d[l_ac].inbb213
            LET g_inbb_d_o.inbb214 = g_inbb_d[l_ac].inbb214
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb213
            #add-point:BEFORE FIELD inbb213 name="input.b.page1.inbb213"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb213
            #add-point:ON CHANGE inbb213 name="input.g.page1.inbb213"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb214
            
            #add-point:AFTER FIELD inbb214 name="input.a.page1.inbb214"
            LET g_inbb_d[l_ac].inbb214_desc = ''
            LET g_inbb_d[l_ac].inbb214_desc_desc = ''
            
            IF NOT cl_null(g_inbb_d[l_ac].inbb214) THEN
               IF g_inbb_d[l_ac].inbb214 != g_inbb_d_o.inbb214 OR cl_null(g_inbb_d_o.inbb214) THEN
                  IF NOT aint911_inbb214_chk(g_inbb_d[l_ac].inbb214) THEN
                    LET g_inbb_d[l_ac].inbb213 = g_inbb_d_o.inbb213
                    LET g_inbb_d[l_ac].inbb214 = g_inbb_d_o.inbb214
                    CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb214) 
                       RETURNING g_inbb_d[l_ac].inbb214_desc,g_inbb_d[l_ac].inbb214_desc_desc
                    NEXT FIELD CURRENT                        
                  END IF   
                  CALL aint911_inbb214_def()
               END IF
            END IF
            CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb214) 
               RETURNING g_inbb_d[l_ac].inbb214_desc,g_inbb_d[l_ac].inbb214_desc_desc
            
            LET g_inbb_d_o.inbb213 = g_inbb_d[l_ac].inbb213
            LET g_inbb_d_o.inbb214 = g_inbb_d[l_ac].inbb214
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb214
            #add-point:BEFORE FIELD inbb214 name="input.b.page1.inbb214"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb214
            #add-point:ON CHANGE inbb214 name="input.g.page1.inbb214"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb215
            
            #add-point:AFTER FIELD inbb215 name="input.a.page1.inbb215"
            LET g_inbb_d[l_ac].inbb215_desc = ''
            IF NOT cl_null(g_inbb_d[l_ac].inbb215) THEN
               IF g_inbb_d[l_ac].inbb215 != g_inbb_d_o.inbb215 OR cl_nulL(g_inbb_d_o.inbb215) THEN
                  IF NOT s_feature_check(g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb215) THEN
                     LET g_inbb_d[l_ac].inbb215 = g_inbb_d_o.inbb215
                     CALL s_feature_description(g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb215) 
                        RETURNING l_success,g_inbb_d[l_ac].inbb215_desc
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#2--add--start--
                  IF NOT s_feature_direct_input(g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb215,g_inbb_d_o.inbb215,g_inba_m.inbadocno,g_inba_m.inbasite) THEN
                     NEXT FIELD CURRENT
                  END IF 
                  #151224-00025#2--add--end----
               END IF
            END IF
            
            CALL s_feature_description(g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb215) 
               RETURNING l_success,g_inbb_d[l_ac].inbb215_desc
               
            LET g_inbb_d_o.inbb215 = g_inbb_d[l_ac].inbb215
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb215
            #add-point:BEFORE FIELD inbb215 name="input.b.page1.inbb215"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb215
            #add-point:ON CHANGE inbb215 name="input.g.page1.inbb215"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb007
            
            #add-point:AFTER FIELD inbb007 name="input.a.page1.inbb007"
            LET g_inbb_d[l_ac].inbb007_desc = ' '
            
            IF NOT cl_null(g_inbb_d[l_ac].inbb007) THEN
               IF g_inbb_d[l_ac].inbb007 != g_inbb_d_o.inbb007 OR g_inbb_d_o.inbb007 IS NULL THEN   #150427-00012#3  150507 by lori mod   
                  LET l_success = ''
                  INITIALIZE g_chkparam.* TO NULL
                  #151113-00020#1 151119 By pomelo add(S)
                  IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
                     LET l_type = '1'
                  ELSE
                     LET l_type = '2'
                  END IF
                  CASE l_type
                  #151113-00020#1 151119 By pomelo add(E)
                  #CASE g_argv[1]       #151113-00020#1 151119 By pomelo mark
                     WHEN '1' 
                        LET g_chkparam.arg1 = g_inba_m.inbasite
                        LET g_chkparam.arg2 = g_inbb_d[l_ac].inbb007
                        #160318-00025#20  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                        #160318-00025#20  by 07900 --add-end
                        IF NOT cl_chk_exist("v_inaa001") THEN
                           LET l_success = FALSE
                        ELSE
                           #150324-00007#1 20150413 By pmoelo mark(S)
                           #IF aint911_inag_chk() THEN
                           #   LET l_success = FALSE
                           #END IF
                           #150324-00007#1 20150413 By pmoelo mark(E)
                        END IF
                     WHEN '2'
                        LET g_chkparam.arg1 = g_inbb_d[l_ac].inbb007
                        #160318-00025#20  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                        #160318-00025#20  by 07900 --add-end
                        IF NOT cl_chk_exist("v_inaa001_9") THEN
                           LET l_success = FALSE
                        END IF
                  END CASE
                  
                  IF NOT l_success THEN
                     LET g_inbb_d[l_ac].inbb007 = g_inbb_d_o.inbb007
                     CALL s_desc_get_stock_desc(g_site,g_inbb_d[l_ac].inbb007) RETURNING g_inbb_d[l_ac].inbb007_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150324-00007#1 20150413 By pmoelo mark(S)
                  #IF g_inbb_d[l_ac].inbb007 != g_inbb_d_o.inbb007 OR g_inbb_d_o.inbb007 IS NULL THEN
                  #   LET g_inbb_d[l_ac].inbb008 = ' '
                  #   LET g_inbb_d[l_ac].inbb009 = ' '
                  #END IF
                  #150324-00007#1 20150413 By pmoelo mark(E)
                  
                  #IF g_argv[1] = '1' AND l_cmd = 'u' THEN   #151113-00020#1 151119 By pomelo mark
                  IF l_type = '1' AND l_cmd = 'u' THEN       #151113-00020#1 151119 By pomelo add(S)
                     LET g_inbb_d[l_ac].inbb008 = ' '
                     LET g_inbb_d[l_ac].inbb008_desc = ' '
                     LET g_inbb_d[l_ac].inbb009 = ' '
                  END IF
                  
                  CALL aint911_inbb207_default()   #150629-00016#1 150716 by lori add
               END IF
            END IF
            
            LET g_inbb_d[l_ac].inbb007_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007)
            
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_entry_b(l_cmd)
            
            LET g_inbb_d_o.inbb007 = g_inbb_d[l_ac].inbb007
            LET g_inbb_d_o.inbb008 = g_inbb_d[l_ac].inbb008
            LET g_inbb_d_o.inbb009 = g_inbb_d[l_ac].inbb009
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb007
            #add-point:BEFORE FIELD inbb007 name="input.b.page1.inbb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb007
            #add-point:ON CHANGE inbb007 name="input.g.page1.inbb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb008
            
            #add-point:AFTER FIELD inbb008 name="input.a.page1.inbb008"
            LET g_inbb_d[l_ac].inbb008_desc = ' '
            IF NOT cl_null(g_inbb_d[l_ac].inbb008) THEN
               IF g_inbb_d[l_ac].inbb008 != g_inbb_d_o.inbb008 OR g_inbb_d_o.inbb008 IS NULL THEN   #150427-00012#3  150507 by lori mod
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inba_m.inbasite
                  LET g_chkparam.arg2 = g_inbb_d[l_ac].inbb007
                  LET g_chkparam.arg3 = g_inbb_d[l_ac].inbb008
                   #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#20  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET g_inbb_d[l_ac].inbb008 = g_inbb_d_o.inbb008
                     LET g_inbb_d[l_ac].inbb008_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008)
                     NEXT FIELD CURRENT
                  END IF
                  
                  #151113-00020#1 151119 By pomelo add(S)
                  IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
                     LET l_type = '1'
                  ELSE
                     LET l_type = '2'
                  END IF
                  CASE l_type
                  #151113-00020#1 151119 By pomelo add(E)
                  #CASE g_argv[1]     #雜發時需庫存明細有東西才可以發料 151113-00020#1 151119 By pomelo mark
                     WHEN '1' 
                        #150324-00007#1 20150413 By pmoelo mark(S)
                        #IF NOT aint911_inag_chk() THEN
                        #   LET g_inbb_d[l_ac].inbb008 = g_inbb_d_o.inbb008
                        #   LET g_inbb_d[l_ac].inbb008_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008)
                        #   NEXT FIELD CURRENT                  
                        #END IF
                        #150324-00007#1 20150413 By pmoelo mark(S)
                     WHEN '2'        #雜收時若輸入的庫位+儲位不存在[T:儲位資料檔]時，則呼叫應用元件判斷是否需要新增儲位基本資料
                        IF NOT s_aini002_ins_inab(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'ain-00282'
                           LET g_errparam.extend = "inab_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_inbb_d[l_ac].inbb008 = g_inbb_d_o.inbb008
                           CALL s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008) RETURNING g_inbb_d[l_ac].inbb008_desc
                           NEXT FIELD CURRENT
                        END IF
                  END CASE 
                  
                  #150324-00007#1 20150413 By pmoelo mark(S)
                  #IF g_inbb_d[l_ac].inbb008 != g_inbb_d_t.inbb008 OR g_inbb_d_t.inbb008 IS NULL THEN
                  #   LET g_inbb_d[l_ac].inbb009 = ' '
                  #END IF
                  #150324-00007#1 20150413 By pmoelo mark(E)
                                    
                  #IF g_argv[1] = '1' AND l_cmd = 'u' THEN   #151113-00020#1 151119 By pomelo mark
                  IF l_type = '1' AND l_cmd = 'u' THEN       #151113-00020#1 151119 By pomelo add
                     LET g_inbb_d[l_ac].inbb009 = ' '
                  END IF
                  
               END IF
            END IF
            
            LET g_inbb_d[l_ac].inbb008_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008)
            
            LET g_inbb_d_o.inbb008 = g_inbb_d[l_ac].inbb008
            LET g_inbb_d_o.inbb009 = g_inbb_d[l_ac].inbb009
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb008
            #add-point:BEFORE FIELD inbb008 name="input.b.page1.inbb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb008
            #add-point:ON CHANGE inbb008 name="input.g.page1.inbb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb009
            #add-point:BEFORE FIELD inbb009 name="input.b.page1.inbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb009
            
            #add-point:AFTER FIELD inbb009 name="input.a.page1.inbb009"
            #160106-00002#1 20160107 add by beckxie---S
            #批號
            LET l_cnt = 0
            SELECT COUNT (imaa001) INTO l_cnt
              FROM imaa_t, imaf_t
             WHERE imaaent = imafent 
               AND imaa001 = imaf001 
               AND imaaent = g_enterprise
               AND imaa001 = g_inbb_d[l_ac].inbb001
               AND imafsite= g_inba_m.inbasite
               AND imaf061 = '1'
               AND imaf062 = 'N'
            
            IF l_cnt > 0 AND cl_null(g_inbb_d[l_ac].inbb009) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00719'
               LET g_errparam.EXTEND = ''
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = g_inbb_d[l_ac].inbb001
               CALL cl_err()
               NEXT FIELD inbb009
            END IF
            #160106-00002#1 20160107 add by beckxie---E
            IF NOT cl_null(g_inbb_d[l_ac].inbb009) THEN
               IF g_inbb_d[l_ac].inbb009 != g_inbb_d_o.inbb009 OR g_inbb_d_o.inbb009 IS NULL THEN
                  #150507-00001#8 150527 by lori add---(S)
                  #151113-00020#1 151119 By pomelo add(S)
                  IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
                     LET l_type = '1'
                  ELSE
                     LET l_type = '2'
                  END IF
                  IF l_type = '2' THEN
                  #151113-00020#1 151119 By pomelo add(E)
                  #IF g_argv[1] = '2' THEN   #151113-00020#1 151119 By pomelo mark
                     IF NOT cl_null(g_inbb_d[l_ac].inbb001) THEN
                        LET l_success = '' 
                        LET l_inbb022 = ''
                        IF NOT cl_null(g_inbb_d[l_ac].inbb204) THEN
                           CALL s_lot_out_effdate(g_inba_m.inbasite,
                                                  g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,
                                                  g_inbb_d[l_ac].inbb204,g_inbb_d[l_ac].inbb009)
                             RETURNING l_success,l_inbb022 
                           IF l_success THEN
                              LET  g_inbb_d[l_ac].inbb022 = l_inbb022
                           ELSE
                              LET g_inbb_d[l_ac].inbb009 = g_inbb_d_o.inbb009
                              NEXT FIELD CURRENT                           
                           END IF
                        END IF  
                     END IF   
                  END IF   
                  #150507-00001#8 150527 by lori add---(E)
                  
                  CALL aint911_inbb207_default()   #150629-00016#1 150716 by lori add
               END IF
            ELSE
               LET g_inbb_d[l_ac].inbb009 = ' '
            END IF
            
            #150507-00001#8 150527 by lori add---(S)
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_required_b()
            CALL aint911_set_required_b()
            CALL aint911_set_no_entry_b(l_cmd)
            #150507-00001#8 150527 by lori add---(E)
            
            LET g_inbb_d_o.inbb009 = g_inbb_d[l_ac].inbb009
            LET g_inbb_d_o.inbb022 = g_inbb_d[l_ac].inbb022   #150507-00001#8 150527 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb009
            #add-point:ON CHANGE inbb009 name="input.g.page1.inbb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb210
            #add-point:BEFORE FIELD inbb210 name="input.b.page1.inbb210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb210
            
            #add-point:AFTER FIELD inbb210 name="input.a.page1.inbb210"
            ##150814 by lori add---(S) 
            IF NOT cl_null(g_inbb_d[l_ac].inbb210) OR cl_null(g_inbb_d_o.inbb210) THEN
               IF g_inbb_d[l_ac].inbb210 != g_inbb_d_o.inbb210 OR cl_null(g_inbb_d_o.inbb210) THEN
                  LET g_inbb_d[l_ac].inbb207   = g_inbb_d[l_ac].inbb210
                  LET g_inbb_d[l_ac].inbb208   = g_inbb_d[l_ac].inbb210 * g_inbb_d[l_ac].inbb011   
               END IF
            ELSE
               LET  g_inbb_d[l_ac].inbb210 = 0
            END IF

            LET g_inbb_d_o.inbb210 = g_inbb_d[l_ac].inbb210
            ##150814 by lori add---(E) 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb210
            #add-point:ON CHANGE inbb210 name="input.g.page1.inbb210"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb003
            #add-point:BEFORE FIELD inbb003 name="input.b.page1.inbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb003
            
            #add-point:AFTER FIELD inbb003 name="input.a.page1.inbb003"
            #150629-00016#1 150716 by lori add---(S)
            IF NOT cl_null(g_inbb_d[l_ac].inbb003) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_inbb_d[l_ac].inbb003 != g_inbb_d_t.inbb003 OR g_inbb_d_t.inbb003 IS NULL )) THEN
                  CALL aint911_inbb207_default()
               END IF
            END IF 
            #150629-00016#1 150716 by lori add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb003
            #add-point:ON CHANGE inbb003 name="input.g.page1.inbb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb220
            
            #add-point:AFTER FIELD inbb220 name="input.a.page1.inbb220"
            LET g_inbb_d[l_ac].inbb220_desc = ' '
            DISPLAY BY NAME g_inbb_d[l_ac].inbb220_desc
            IF NOT cl_null(g_inbb_d[l_ac].inbb220) THEN
               IF g_inbb_d[l_ac].inbb220 != g_inbb_d_o.inbb220 OR cl_null(g_inbb_d_o.inbb220) THEN   #150427-00012#3  150507 by lori mod   
                  LET l_success = ''
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inbb_d[l_ac].inbb220
                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#20  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_9") THEN
				         LET g_inbb_d[l_ac].inbb220 = g_inbb_d_o.inbb220
                     CALL s_desc_get_stock_desc(g_site,g_inbb_d[l_ac].inbb220)
                        RETURNING g_inbb_d[l_ac].inbb220_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL aint911_inbb207_default()
               END IF
            END IF
            
            LET g_inbb_d[l_ac].inbb220_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb220)
            
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_entry_b(l_cmd)
            
            LET g_inbb_d_o.inbb220 = g_inbb_d[l_ac].inbb220
            LET g_inbb_d_o.inbb221 = g_inbb_d[l_ac].inbb221
            LET g_inbb_d_o.inbb222 = g_inbb_d[l_ac].inbb222
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb220
            #add-point:BEFORE FIELD inbb220 name="input.b.page1.inbb220"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb220
            #add-point:ON CHANGE inbb220 name="input.g.page1.inbb220"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb221
            
            #add-point:AFTER FIELD inbb221 name="input.a.page1.inbb221"
            LET g_inbb_d[l_ac].inbb221_desc = ' '
            IF NOT cl_null(g_inbb_d[l_ac].inbb221) THEN
               IF g_inbb_d[l_ac].inbb221 != g_inbb_d_o.inbb221 OR cl_null(g_inbb_d_o.inbb221) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inba_m.inbasite
                  LET g_chkparam.arg2 = g_inbb_d[l_ac].inbb220
                  LET g_chkparam.arg3 = g_inbb_d[l_ac].inbb221
                   #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#20  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET g_inbb_d[l_ac].inbb221 = g_inbb_d_o.inbb221
                     LET g_inbb_d[l_ac].inbb221_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb220,g_inbb_d[l_ac].inbb221)
                     NEXT FIELD CURRENT
                  END IF
                  
				      IF NOT s_aini002_ins_inab(g_inba_m.inbasite,g_inbb_d[l_ac].inbb220,g_inbb_d[l_ac].inbb221) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00282'
                     LET g_errparam.extend = "inab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_inbb_d[l_ac].inbb221 = g_inbb_d_o.inbb221
                     CALL s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb220,g_inbb_d[l_ac].inbb221) RETURNING g_inbb_d[l_ac].inbb221_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_inbb_d[l_ac].inbb221_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb220,g_inbb_d[l_ac].inbb221)
            
            LET g_inbb_d_o.inbb221 = g_inbb_d[l_ac].inbb221
            LET g_inbb_d_o.inbb222 = g_inbb_d[l_ac].inbb222
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb221
            #add-point:BEFORE FIELD inbb221 name="input.b.page1.inbb221"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb221
            #add-point:ON CHANGE inbb221 name="input.g.page1.inbb221"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb222
            #add-point:BEFORE FIELD inbb222 name="input.b.page1.inbb222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb222
            
            #add-point:AFTER FIELD inbb222 name="input.a.page1.inbb222"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb222
            #add-point:ON CHANGE inbb222 name="input.g.page1.inbb222"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb223
            #add-point:BEFORE FIELD inbb223 name="input.b.page1.inbb223"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb223
            
            #add-point:AFTER FIELD inbb223 name="input.a.page1.inbb223"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb223
            #add-point:ON CHANGE inbb223 name="input.g.page1.inbb223"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb201
            
            #add-point:AFTER FIELD inbb201 name="input.a.page1.inbb201"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb201
            #add-point:BEFORE FIELD inbb201 name="input.b.page1.inbb201"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb201
            #add-point:ON CHANGE inbb201 name="input.g.page1.inbb201"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb202
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inbb_d[l_ac].inbb202,"0","0","","","azz-00079",1) THEN
               NEXT FIELD inbb202
            END IF 
 
 
 
            #add-point:AFTER FIELD inbb202 name="input.a.page1.inbb202"
            IF NOT cl_null(g_inbb_d[l_ac].inbb202) THEN
               IF g_inbb_d[l_ac].inbb202 != g_inbb_d_o.inbb202 OR g_inbb_d_o.inbb202 IS NULL THEN   #150427-00012#3  150507 by lori mod
                 IF NOT cl_null(g_inbb_d[l_ac].inbb010) AND NOT cl_null(g_inbb_d[l_ac].inbb201) THEN
                    IF NOT aint911_qty_convert(1) THEN
                       LET g_inbb_d[l_ac].inbb202 = g_inbb_d_o.inbb202
                       LET g_inbb_d[l_ac].inbb011 = g_inbb_d_o.inbb011
                    #151103-00009#2 Mark By Ken 151111(S)
                    #ELSE
                    #   IF NOT aint911_inbb011_chk() THEN
                    #      LET g_inbb_d[l_ac].inbb202 = g_inbb_d_o.inbb202
                    #      LET g_inbb_d[l_ac].inbb011 = g_inbb_d_o.inbb011
                    #      NEXT FIELD CURRENT                 
                    #   END IF
                    #   LET g_inbb_d[l_ac].inbb012 = g_inbb_d[l_ac].inbb011                       
                    #151103-00009#2 Mark By Ken 151111(E)
                    END IF  
                    #160604-00009#140 Add By Ken 160725(S)
                    IF g_argv[1] = '5' THEN
                       IF g_inbb_d[l_ac].inbb011 > 0 THEN               
                          #160831-00061#1 Mark BY ken 160901(S)
                          #CALL aint911_get_inag008() RETURNING l_success,l_inag008
                          #IF l_success THEN
                          #   IF NOT aint911_num_chk(g_inbb_d[l_ac].inbb011,l_inag008) THEN
                          #      LET g_inbb_d[l_ac].inbb202 = g_inbb_d_o.inbb202
                          #      LET g_inbb_d[l_ac].inbb011 = g_inbb_d_o.inbb011                 
                          #      NEXT FIELD CURRENT
                          #   END IF
                          #END IF
                          #160831-00061#1 Mark BY ken 160901(E)
                          #160831-00061#1 Add BY ken 160901(S)
                          CALL s_aint911_get_inag008(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,g_inbb_d[l_ac].inbb003,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008,g_inbb_d[l_ac].inbb009) RETURNING l_inag008
                          IF NOT s_aint911_num_chk(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb011,l_inag008) THEN
                             LET g_inbb_d[l_ac].inbb202 = g_inbb_d_o.inbb202
                             LET g_inbb_d[l_ac].inbb011 = g_inbb_d_o.inbb011                 
                             NEXT FIELD CURRENT
                          END IF                          
                          #160831-00061#1 Add BY ken 160901(E)
                       END IF
                    END IF
                    #160604-00009#140 Add By Ken 160725(E)                    
                 END IF
                 LET g_inbb_d[l_ac].inbb203 = g_inbb_d[l_ac].inbb202                 
               END IF
               
            END IF
                        
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_entry_b(l_cmd)
            
            LET g_inbb_d_o.inbb202 = g_inbb_d[l_ac].inbb202
            LET g_inbb_d_o.inbb203 = g_inbb_d[l_ac].inbb203
            LET g_inbb_d_o.inbb011 = g_inbb_d[l_ac].inbb011
            LET g_inbb_d_o.inbb012 = g_inbb_d[l_ac].inbb012
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb202
            #add-point:BEFORE FIELD inbb202 name="input.b.page1.inbb202"
            IF cl_null(g_slip) OR cl_null(g_num_para) THEN
               CALL aint911_get_slip_para()
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb202
            #add-point:ON CHANGE inbb202 name="input.g.page1.inbb202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb203
            #add-point:BEFORE FIELD inbb203 name="input.b.page1.inbb203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb203
            
            #add-point:AFTER FIELD inbb203 name="input.a.page1.inbb203"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb203
            #add-point:ON CHANGE inbb203 name="input.g.page1.inbb203"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inbb_d[l_ac].inbb011,"0","0","","","azz-00079",1) THEN
               NEXT FIELD inbb011
            END IF 
 
 
 
            #add-point:AFTER FIELD inbb011 name="input.a.page1.inbb011"
            IF NOT cl_null(g_inbb_d[l_ac].inbb011) THEN
               IF g_inbb_d[l_ac].inbb011 != g_inbb_d_o.inbb011 OR g_inbb_d_o.inbb011 IS NULL THEN   #150427-00012#3  150507 by lori mod
                 #151103-00009#2 Mark By Ken 151111(S)
                 #IF NOT aint911_inbb011_chk() THEN
                 #   LET g_inbb_d[l_ac].inbb202 = g_inbb_d_o.inbb202
                 #   LET g_inbb_d[l_ac].inbb011 = g_inbb_d_o.inbb011
                 #   NEXT FIELD CURRENT                 
                 #END IF
                 #151103-00009#2 Mark By Ken 151111(E)
                 IF NOT cl_null(g_inbb_d[l_ac].inbb010) AND NOT cl_null(g_inbb_d[l_ac].inbb201) THEN
                    IF NOT aint911_qty_convert(2) THEN
                       LET g_inbb_d[l_ac].inbb011 = g_inbb_d_o.inbb011
                    END IF
                    LET g_inbb_d[l_ac].inbb203 = g_inbb_d[l_ac].inbb202
                 END IF  
               END IF
               #LET g_inbb_d[l_ac].inbb012 = g_inbb_d[l_ac].inbb011   #151113-00020#1 151117 By pomelo mark
               #151111-00021#3 Add By Ken 151203(S) 申請數量轉成計價數量
               IF NOT cl_null(g_inbb_d[l_ac].inbb010) AND NOT cl_null(g_inbb_d[l_ac].inbb224) THEN
                  IF NOT aint911_qty_convert(3) THEN
                     LET g_inbb_d[l_ac].inbb011 = g_inbb_d_o.inbb011
                  END IF
                  #LET g_inbb_d[l_ac].inbb203 = g_inbb_d[l_ac].inbb202
               END IF   
               #151111-00021#3 Add By Ken 151203(E) 
               #160604-00009#140 Add By Ken 160725(S)
               IF g_argv[1] = '5' THEN
                  IF g_inbb_d[l_ac].inbb011 > 0 THEN               
                     #160831-00061#1 Mark BY ken 160901(S)
                     #CALL aint911_get_inag008() RETURNING l_success,l_inag008
                     #IF l_success THEN
                     #   IF NOT aint911_num_chk(g_inbb_d[l_ac].inbb011,l_inag008) THEN
                     #      LET g_inbb_d[l_ac].inbb202 = g_inbb_d_o.inbb202
                     #      LET g_inbb_d[l_ac].inbb011 = g_inbb_d_o.inbb011                 
                     #      NEXT FIELD CURRENT
                     #   END IF
                     #END IF
                     #160831-00061#1 Mark BY ken 160901(E)
                     #160831-00061#1 Add BY ken 160901(S)
                     CALL s_aint911_get_inag008(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,g_inbb_d[l_ac].inbb003,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008,g_inbb_d[l_ac].inbb009) RETURNING l_inag008
                     IF NOT s_aint911_num_chk(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb011,l_inag008) THEN
                        LET g_inbb_d[l_ac].inbb202 = g_inbb_d_o.inbb202
                        LET g_inbb_d[l_ac].inbb011 = g_inbb_d_o.inbb011                 
                        NEXT FIELD CURRENT
                     END IF                          
                     #160831-00061#1 Add BY ken 160901(E)                     
                  END IF
               END IF
               #160604-00009#140 Add By Ken 160725(E)                
            END IF
            
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_entry_b(l_cmd)
            
            LET g_inbb_d_o.inbb011 = g_inbb_d[l_ac].inbb011
            LET g_inbb_d_o.inbb012 = g_inbb_d[l_ac].inbb012
            LET g_inbb_d_o.inbb202 = g_inbb_d[l_ac].inbb202
            LET g_inbb_d_o.inbb203 = g_inbb_d[l_ac].inbb203
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb011
            #add-point:BEFORE FIELD inbb011 name="input.b.page1.inbb011"
            IF cl_null(g_slip) OR cl_null(g_num_para) THEN
               CALL aint911_get_slip_para()
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb011
            #add-point:ON CHANGE inbb011 name="input.g.page1.inbb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb012
            #add-point:BEFORE FIELD inbb012 name="input.b.page1.inbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb012
            
            #add-point:AFTER FIELD inbb012 name="input.a.page1.inbb012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb012
            #add-point:ON CHANGE inbb012 name="input.g.page1.inbb012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb010
            
            #add-point:AFTER FIELD inbb010 name="input.a.page1.inbb010"
            LET g_inbb_d[l_ac].inbb010_desc = ' '
            IF NOT cl_null(g_inbb_d[l_ac].inbb010) THEN 
               IF g_inbb_d[l_ac].inbb010 != g_inbb_d_o.inbb010 OR g_inbb_d_o.inbb010 IS NULL THEN   #150427-00012#3  150507 by lori mod
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inbb_d[l_ac].inbb010
                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#20  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_inbb_d[l_ac].inbb010 = g_inbb_d_o.inbb010
                     LET g_inbb_d[l_ac].inbb010_desc = s_desc_get_unit_desc(g_inbb_d[l_ac].inbb010)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_inbb_d[l_ac].inbb010_desc = s_desc_get_unit_desc(g_inbb_d[l_ac].inbb010)
            
            LET g_inbb_d_o.inbb010 = g_inbb_d[l_ac].inbb010
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb010
            #add-point:BEFORE FIELD inbb010 name="input.b.page1.inbb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb010
            #add-point:ON CHANGE inbb010 name="input.g.page1.inbb010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb218
            
            #add-point:AFTER FIELD inbb218 name="input.a.page1.inbb218"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb218
            #add-point:BEFORE FIELD inbb218 name="input.b.page1.inbb218"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb218
            #add-point:ON CHANGE inbb218 name="input.g.page1.inbb218"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb219
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inbb_d[l_ac].inbb219,"0","0","","","azz-00079",1) THEN
               NEXT FIELD inbb219
            END IF 
 
 
 
            #add-point:AFTER FIELD inbb219 name="input.a.page1.inbb219"
            IF NOT cl_null(g_inbb_d[l_ac].inbb219) THEN
               IF g_inbb_d_o.inbb219 != g_inbb_d[l_ac].inbb219 OR cl_null(g_inbb_d_o.inbb219) THEN
                  IF NOT aint911_turn_num_change(1) THEN
                     LET g_inbb_d[l_ac].inbb217 = g_inbb_d_o.inbb217
                     LET g_inbb_d[l_ac].inbb219 = g_inbb_d_o.inbb219
                  END IF
               END IF
            END IF
            LET g_inbb_d_o.inbb217 = g_inbb_d[l_ac].inbb217
            LET g_inbb_d_o.inbb219 = g_inbb_d[l_ac].inbb219
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb219
            #add-point:BEFORE FIELD inbb219 name="input.b.page1.inbb219"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb219
            #add-point:ON CHANGE inbb219 name="input.g.page1.inbb219"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb216
            
            #add-point:AFTER FIELD inbb216 name="input.a.page1.inbb216"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb216
            #add-point:BEFORE FIELD inbb216 name="input.b.page1.inbb216"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb216
            #add-point:ON CHANGE inbb216 name="input.g.page1.inbb216"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb217
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inbb_d[l_ac].inbb217,"0","0","","","azz-00079",1) THEN
               NEXT FIELD inbb217
            END IF 
 
 
 
            #add-point:AFTER FIELD inbb217 name="input.a.page1.inbb217"
            IF NOT cl_null(g_inbb_d[l_ac].inbb217) THEN
               IF g_inbb_d_o.inbb217 != g_inbb_d[l_ac].inbb217 OR cl_null(g_inbb_d_o.inbb217) THEN
                  IF NOT aint911_turn_num_change(2) THEN
                     LET g_inbb_d[l_ac].inbb217 = g_inbb_d_o.inbb217
                     LET g_inbb_d[l_ac].inbb219 = g_inbb_d_o.inbb219
                  END IF
               END IF
            END IF
            LET g_inbb_d_o.inbb217 = g_inbb_d[l_ac].inbb217
            LET g_inbb_d_o.inbb219 = g_inbb_d[l_ac].inbb219
            CALL aint911_set_entry_b(l_cmd)
            CALL aint911_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb217
            #add-point:BEFORE FIELD inbb217 name="input.b.page1.inbb217"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb217
            #add-point:ON CHANGE inbb217 name="input.g.page1.inbb217"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb209
            
            #add-point:AFTER FIELD inbb209 name="input.a.page1.inbb209"
            LET g_inbb_d[l_ac].inbb209_desc = ''
            IF NOT cl_null(g_inbb_d[l_ac].inbb209) THEN
               IF g_inbb_d[l_ac].inbb209 != g_inbb_d_o.inbb209 OR g_inbb_d_o.inbb209 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inbb_d[l_ac].inbb209
                  IF NOT cl_chk_exist("v_stae001") THEN
                     LET g_inbb_d[l_ac].inbb209 = g_inbb_d_o.inbb209
                     LET g_inbb_d[l_ac].inbb209_desc = aint911_inbb209_ref(g_inbb_d[l_ac].inbb209)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_inbb_d[l_ac].inbb209_desc = aint911_inbb209_ref(g_inbb_d[l_ac].inbb209)
            LET g_inbb_d_o.inbb209 = g_inbb_d[l_ac].inbb209
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb209
            #add-point:BEFORE FIELD inbb209 name="input.b.page1.inbb209"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb209
            #add-point:ON CHANGE inbb209 name="input.g.page1.inbb209"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb207
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inbb_d[l_ac].inbb207,"0","1","","","azz-00079",1) THEN
               NEXT FIELD inbb207
            END IF 
 
 
 
            #add-point:AFTER FIELD inbb207 name="input.a.page1.inbb207"
            #160728-00018#1 20160729 add by beckxie---S
            IF NOT cl_null(g_inbb_d[l_ac].inbb207) AND NOT cl_null(g_inbb_d[l_ac].inbb012) THEN
               LET g_inbb_d[l_ac].inbb208 = g_inbb_d[l_ac].inbb207 * g_inbb_d[l_ac].inbb012
            END IF
            #160728-00018#1 20160729 add by beckxie---E

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb207
            #add-point:BEFORE FIELD inbb207 name="input.b.page1.inbb207"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb207
            #add-point:ON CHANGE inbb207 name="input.g.page1.inbb207"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb208
            #add-point:BEFORE FIELD inbb208 name="input.b.page1.inbb208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb208
            
            #add-point:AFTER FIELD inbb208 name="input.a.page1.inbb208"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb208
            #add-point:ON CHANGE inbb208 name="input.g.page1.inbb208"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb205
            #add-point:BEFORE FIELD inbb205 name="input.b.page1.inbb205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb205
            
            #add-point:AFTER FIELD inbb205 name="input.a.page1.inbb205"
            #150629-00016#1 150716 by lori---(S)
            IF NOT cl_null(g_inbb_d[l_ac].inbb205) THEN
               IF g_inbb_d[l_ac].inbb205 != g_inbb_d_o.inbb205 OR g_inbb_d_o.inbb205 IS NULL THEN
                  IF NOT cl_null(g_inbb_d[l_ac].inbb012) THEN
                     LET g_inbb_d[l_ac].inbb206 = g_inbb_d[l_ac].inbb205 * g_inbb_d[l_ac].inbb012
                  END IF
               END IF
            END IF
            #150629-00016#1 150716 by lori---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb205
            #add-point:ON CHANGE inbb205 name="input.g.page1.inbb205"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb016
            
            #add-point:AFTER FIELD inbb016 name="input.a.page1.inbb016"
            LET g_inbb_d[l_ac].inbb016_desc = ' '
            IF NOT cl_null(g_inbb_d[l_ac].inbb016) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_inbb_d[l_ac].inbb016 != g_inbb_d_t.inbb016 OR g_inbb_d_t.inbb016 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist(g_inba007_acc,g_inbb_d[l_ac].inbb016) THEN
                     LET g_inbb_d[l_ac].inbb016 = g_inbb_d_t.inbb016
                     LET g_inbb_d[l_ac].inbb016_desc = s_desc_get_acc_desc(g_inba007_acc,g_inbb_d[l_ac].inbb016)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_inbb_d[l_ac].inbb016_desc = s_desc_get_acc_desc(g_inba007_acc,g_inbb_d[l_ac].inbb016)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb016
            #add-point:BEFORE FIELD inbb016 name="input.b.page1.inbb016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb016
            #add-point:ON CHANGE inbb016 name="input.g.page1.inbb016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb016_desc
            #add-point:BEFORE FIELD inbb016_desc name="input.b.page1.inbb016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb016_desc
            
            #add-point:AFTER FIELD inbb016_desc name="input.a.page1.inbb016_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb016_desc
            #add-point:ON CHANGE inbb016_desc name="input.g.page1.inbb016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb018
            #add-point:BEFORE FIELD inbb018 name="input.b.page1.inbb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb018
            
            #add-point:AFTER FIELD inbb018 name="input.a.page1.inbb018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb018
            #add-point:ON CHANGE inbb018 name="input.g.page1.inbb018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb020
            #add-point:BEFORE FIELD inbb020 name="input.b.page1.inbb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb020
            
            #add-point:AFTER FIELD inbb020 name="input.a.page1.inbb020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb020
            #add-point:ON CHANGE inbb020 name="input.g.page1.inbb020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb204
            #add-point:BEFORE FIELD inbb204 name="input.b.page1.inbb204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb204
            
            #add-point:AFTER FIELD inbb204 name="input.a.page1.inbb204"
            #150507-00001#8 150527 by lori add---(S)
            IF NOT cl_null(g_inbb_d[l_ac].inbb204) THEN
               IF g_inbb_d[l_ac].inbb204 != g_inbb_d_o.inbb204 OR cl_null(g_inbb_d_o.inbb204) THEN
                  IF NOT cl_null(g_inbb_d[l_ac].inbb001) THEN
                     LET l_success = '' 
                     LET l_inbb022 = ''
                     CALL s_lot_out_effdate(g_inba_m.inbasite,
                                            g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,
                                            g_inbb_d[l_ac].inbb204,g_inbb_d[l_ac].inbb009)
                       RETURNING l_success,l_inbb022 
                     IF l_success THEN
                        LET  g_inbb_d[l_ac].inbb022 = l_inbb022
                     ELSE
                        LET g_inbb_d[l_ac].inbb204 = g_inbb_d_o.inbb204
                        NEXT FIELD CURRENT
                     END IF 
                  END IF   
               END IF
               
            END IF
            
            LET g_inbb_d_o.inbb204 = g_inbb_d[l_ac].inbb204
            LET g_inbb_d_o.inbb022 = g_inbb_d[l_ac].inbb022
            #150507-00001#8 150527 by lori add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb204
            #add-point:ON CHANGE inbb204 name="input.g.page1.inbb204"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb022
            #add-point:BEFORE FIELD inbb022 name="input.b.page1.inbb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb022
            
            #add-point:AFTER FIELD inbb022 name="input.a.page1.inbb022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb022
            #add-point:ON CHANGE inbb022 name="input.g.page1.inbb022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbb021
            #add-point:BEFORE FIELD inbb021 name="input.b.page1.inbb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbb021
            
            #add-point:AFTER FIELD inbb021 name="input.a.page1.inbb021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbb021
            #add-point:ON CHANGE inbb021 name="input.g.page1.inbb021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbbsite
            #add-point:BEFORE FIELD inbbsite name="input.b.page1.inbbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbbsite
            
            #add-point:AFTER FIELD inbbsite name="input.a.page1.inbbsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbbsite
            #add-point:ON CHANGE inbbsite name="input.g.page1.inbbsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbbunit
            #add-point:BEFORE FIELD inbbunit name="input.b.page1.inbbunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbbunit
            
            #add-point:AFTER FIELD inbbunit name="input.a.page1.inbbunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbbunit
            #add-point:ON CHANGE inbbunit name="input.g.page1.inbbunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbbseq
            #add-point:ON ACTION controlp INFIELD inbbseq name="input.c.page1.inbbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb017
            #add-point:ON ACTION controlp INFIELD inbb017 name="input.c.page1.inbb017"
            #150629-00016#1 150716 by lori---(S)
            IF g_inba_m.inba005 = '11' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_inbb_d[l_ac].inbb017  
               LET g_qryparam.arg1 = g_inba_m.inbasite
               LET g_qryparam.arg2 = '1'
               CALL q_inbadocno_8()                              
               
               LET g_inbb_d[l_ac].inbb017 = g_qryparam.return1              
               DISPLAY BY NAME g_inbb_d[l_ac].inbb017
               
               NEXT FIELD inbb017
            END IF   
            #150629-00016#1 150716 by lori---(E)
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb211
            #add-point:ON ACTION controlp INFIELD inbb211 name="input.c.page1.inbb211"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb212
            #add-point:ON ACTION controlp INFIELD inbb212 name="input.c.page1.inbb212"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb200
            #add-point:ON ACTION controlp INFIELD inbb200 name="input.c.page1.inbb200"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inbb_d[l_ac].inbb200
            #151113-00020#1 151117 By pomelo add(S)
            LET l_where = " AND 1=1"
            IF g_argv[1] = '7' THEN
               LET l_where = "  ANd rtdx003 = '1'"
            END IF
            #151113-00020#1 151117 By pomelo add(E)
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM rtdx_t",
                                   "          WHERE rtdxent = ",g_enterprise,
                                   "            AND rtdxsite = '",g_inba_m.inbasite,"'",
                                   "            AND rtdx001 = imaa001",
                                   l_where,                              #151113-00020#1 151117 By pomelo add
                                   "            AND rtdxstus = 'Y')"
            #151113-00020#1 151117 By pomelo add(S)
            IF NOT cl_null(g_inba_m.inba203) THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND EXISTS(SELECT 1 FROM rtaw_t",
                                      "             WHERE imaaent = rtawent",
                                      "               AND imaa009 = rtaw002",
                                      "               AND rtaw001 = '",g_inba_m.inba203,"'",
                                      "               AND rtaw003 = ",g_sys,")"
            END IF
            #151113-00020#1 151117 By pomelo add(E)
            CALL q_imay003_6()                                
            LET g_inbb_d[l_ac].inbb200 = g_qryparam.return1  
            DISPLAY g_inbb_d[l_ac].inbb200 TO inbb200         
            
            NEXT FIELD inbb200                         
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb001
            #add-point:ON ACTION controlp INFIELD inbb001 name="input.c.page1.inbb001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inbb_d[l_ac].inbb001 

            #IF g_argv[1] = '1' THEN    #151113-00020#1 151117 By pomelo mark
               #150324-00007#1 20150413 By pmoelo mark(S)
               #LET g_qryparam.arg1 = g_inba_m.inbasite
               #LET g_qryparam.arg2 = g_inbb_d[l_ac].inbb001 
               #LET g_qryparam.arg3 = g_inbb_d[l_ac].inbb002
               #LET g_qryparam.arg4 = g_inbb_d[l_ac].inbb003
               #LET g_qryparam.arg5 = g_inbb_d[l_ac].inbb007
               #
               #CALL q_inag001_4()
               #LET g_inbb_d[l_ac].inbb001 = g_qryparam.return1 
               #LET g_inbb_d[l_ac].inbb002 = g_qryparam.return2
               #LET g_inbb_d[l_ac].inbb003 = g_qryparam.return3
               #LET g_inbb_d[l_ac].inbb007 = g_qryparam.return7
               #150324-00007#1 20150413 By pmoelo mark(E)
               #150324-00007#1 20150413 By pmoelo add(S)
               LET g_qryparam.arg1 = 'ALL'
               LET g_qryparam.arg2 = g_inba_m.inbasite
               #CALL q_imaf001_18()   #151113-00020#1 151117 By pomelo mark
               
               #151113-00020#1 151117 By pomelo add(S)
               IF NOT cl_null(g_inba_m.inba203) THEN
                  LET g_qryparam.where = " EXISTS(SELECT 1 FROM rtaw_t",
                                         "         WHERE imaaent = rtawent",
                                         "           AND imaa009 = rtaw002",
                                         "           AND rtaw001 = '",g_inba_m.inba203,"'",
                                         "           AND rtaw003 = ",g_sys,")"
               END IF
               
               #160604-00009#140 Add By Ken 160711(S)
               IF g_argv[1] = '9' AND NOT cl_null(g_inba_m.inba204) THEN
                  LET g_qryparam.where = " EXISTS(SELECT 1 FROM ",
                                         "            (SELECT * FROM star_t,stas_t WHERE starent=stasent AND star001=stas001) ",
                                         "        WHERE star003 = '",g_inba_m.inba204,"' AND imafent = starent AND imaf001 = stas003 ) "
               END IF               
               #160604-00009#140 Add By Ken 160711(E)
               
               IF g_argv[1] = '7' THEN
                  CALL q_imaf001_20()
               ELSE
                  CALL q_imaf001_18()
               END IF
               #151113-00020#1 151117 By pomelo add(E)
               LET g_inbb_d[l_ac].inbb001 = g_qryparam.return1
               #150324-00007#1 20150413 By pmoelo add(E)
               CALL s_feature_description(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002) 
                  RETURNING l_success,g_inbb_d[l_ac].inbb002_desc
               LET g_inbb_d[l_ac].inbb007_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007)   
            #151113-00020#1 151117 By pomelo mark(S)
            #ELSE
            #   LET g_qryparam.arg1 = 'ALL'
            #   LET g_qryparam.arg2 = g_inba_m.inbasite
            #   
            #   CALL q_imaf001_18()
            #   LET g_inbb_d[l_ac].inbb001 = g_qryparam.return1               
            #END IF
            #151113-00020#1 151117 By pomelo mark(E)
            
            CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb001) 
               RETURNING g_inbb_d[l_ac].inbb001_desc,g_inbb_d[l_ac].inbb001_desc_desc
            DISPLAY BY NAME g_inbb_d[l_ac].inbb001,
                            g_inbb_d[l_ac].inbb001_desc,g_inbb_d[l_ac].inbb001_desc_desc            
            NEXT FIELD inbb001                 
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb002
            #add-point:ON ACTION controlp INFIELD inbb002 name="input.c.page1.inbb002"
            #取得料件產品特徵
            LET l_imaa005 = ''
            SELECT imaa005 INTO l_imaa005
              FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = g_inbb_d[l_ac].inbb001
               AND imaastus = 'Y'               
            IF NOT cl_null(l_imaa005) THEN
               #150324-00007#1 20150413 By pmoelo mark(S)
               #IF g_argv[1] = '1' THEN
               #   LET g_qryparam.arg1 = g_inba_m.inbasite
               #   LET g_qryparam.arg2 = g_inbb_d[l_ac].inbb001 
               #   LET g_qryparam.arg3 = g_inbb_d[l_ac].inbb002
               #   LET g_qryparam.arg4 = g_inbb_d[l_ac].inbb003
               #   LET g_qryparam.arg5 = g_inbb_d[l_ac].inbb007
               #   
               #   CALL q_inag001_4()
               #   LET g_inbb_d[l_ac].inbb001 = g_qryparam.return1 
               #   LET g_inbb_d[l_ac].inbb002 = g_qryparam.return2
               #   LET g_inbb_d[l_ac].inbb003 = g_qryparam.return3
               #   LET g_inbb_d[l_ac].inbb007 = g_qryparam.return7
               #   
               #   CALL s_feature_description(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002) 
               #      RETURNING l_success,g_inbb_d[l_ac].inbb002_desc
               #   LET g_inbb_d[l_ac].inbb007_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007)
               #   LET g_inbb_d[l_ac].inbb008_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008)                    
               #ELSE
               #150324-00007#1 20150413 By pmoelo mark(E)
                  IF l_cmd = 'a' THEN
                     CALL l_inam.clear()
                     CALL s_feature(l_cmd,g_inbb_d[l_ac].inbb001,'','',g_site,g_inba_m.inbadocno) RETURNING l_success,l_inam
                     LET g_inbb_d[l_ac].inbb002 = l_inam[1].inam002
                     LET g_inbb_d[l_ac].inbb011 = l_inam[1].inam004 
                  END IF
                  IF l_cmd = 'u' THEN
                     CALL s_feature_single(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,g_site,g_inba_m.inbadocno)
                        RETURNING l_success,g_inbb_d[l_ac].inbb002
                  END IF
               #END IF   150324-00007#1 20150413 By pmoelo mark
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb002_desc
            #add-point:ON ACTION controlp INFIELD inbb002_desc name="input.c.page1.inbb002_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb213
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb213
            #add-point:ON ACTION controlp INFIELD inbb213 name="input.c.page1.inbb213"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inbb_d[l_ac].inbb213
            
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM rtdx_t",
                                   "          WHERE rtdxent = ",g_enterprise,
                                   "            AND rtdxsite = '",g_inba_m.inbasite,"'",
                                   "            AND rtdx001 = imaa001",
                                   "            AND rtdx003 = '1'",
                                   "            AND rtdxstus = 'Y')"
            IF NOT cl_null(g_inba_m.inba207) THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND EXISTS(SELECT 1 FROM rtaw_t",
                                      "             WHERE imaaent = rtawent",
                                      "               AND imaa009 = rtaw002",
                                      "               AND rtaw001 = '",g_inba_m.inba207,"'",
                                      "               AND rtaw003 = ",g_sys,")"
            END IF
            CALL q_imay003_6()
            LET g_inbb_d[l_ac].inbb213 = g_qryparam.return1
            DISPLAY g_inbb_d[l_ac].inbb213 TO inbb213
            NEXT FIELD inbb213
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb214
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb214
            #add-point:ON ACTION controlp INFIELD inbb214 name="input.c.page1.inbb214"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inbb_d[l_ac].inbb214
            
            
            LET g_qryparam.arg1 = 'ALL'
            LET g_qryparam.arg2 = g_inba_m.inbasite
            IF NOT cl_null(g_inba_m.inba207) THEN
               LET g_qryparam.where = " EXISTS(SELECT 1 FROM rtaw_t",
                                      "         WHERE imaaent = rtawent",
                                      "           AND imaa009 = rtaw002",
                                      "           AND rtaw001 = '",g_inba_m.inba207,"'",
                                      "           AND rtaw003 = ",g_sys,")"
            END IF
            CALL q_imaf001_20()
            
            LET g_inbb_d[l_ac].inbb214 = g_qryparam.return1
            DISPLAY g_inbb_d[l_ac].inbb214 TO inbb214
            CALL s_desc_get_item_desc(g_inbb_d[l_ac].inbb214) 
               RETURNING g_inbb_d[l_ac].inbb214_desc,g_inbb_d[l_ac].inbb214_desc_desc
            DISPLAY BY NAME g_inbb_d[l_ac].inbb214_desc,g_inbb_d[l_ac].inbb214_desc_desc
            NEXT FIELD inbb214
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb215
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb215
            #add-point:ON ACTION controlp INFIELD inbb215 name="input.c.page1.inbb215"
            #取得料件產品特徵
            LET l_imaa005 = ''
            SELECT imaa005 INTO l_imaa005
              FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = g_inbb_d[l_ac].inbb214
               AND imaastus = 'Y'               
            IF NOT cl_null(l_imaa005) THEN
               IF l_cmd = 'a' THEN
                  CALL l_inam.clear()
                  CALL s_feature(l_cmd,g_inbb_d[l_ac].inbb214,'','',g_site,g_inba_m.inbadocno) RETURNING l_success,l_inam
                  LET g_inbb_d[l_ac].inbb215 = l_inam[1].inam002
                  LET g_inbb_d[l_ac].inbb217 = l_inam[1].inam004 
               END IF
               IF l_cmd = 'u' THEN
                  CALL s_feature_single(g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb215,g_site,g_inba_m.inbadocno)
                     RETURNING l_success,g_inbb_d[l_ac].inbb215
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb007
            #add-point:ON ACTION controlp INFIELD inbb007 name="input.c.page1.inbb007"
            #150324-00007#1 20150413 By pmoelo mark(S)
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_inbb_d[l_ac].inbb007 
            #LET g_qryparam.default2 = g_inbb_d[l_ac].inbb008
            #LET g_qryparam.default3 = g_inbb_d[l_ac].inbb009
            #LET g_qryparam.default4 = g_inbb_d[l_ac].inbb003            
            #LET g_qryparam.arg1 = g_inba_m.inbasite
            #LET g_qryparam.arg2 = g_inbb_d[l_ac].inbb001 
            #LET g_qryparam.arg3 = g_inbb_d[l_ac].inbb002
            #LET g_qryparam.arg4 = g_inbb_d[l_ac].inbb003
            #LET g_qryparam.arg5 = g_inbb_d[l_ac].inbb007
            #
            #CALL q_inag001_4()
            #LET g_inbb_d[l_ac].inbb001 = g_qryparam.return1 
            #LET g_inbb_d[l_ac].inbb002 = g_qryparam.return2
            #LET g_inbb_d[l_ac].inbb003 = g_qryparam.return3
            #LET g_inbb_d[l_ac].inbb007 = g_qryparam.return7
            #CALL s_feature_description(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002) 
            #   RETURNING l_success,g_inbb_d[l_ac].inbb002_desc
            #150324-00007#1 20150413 By pmoelo mark(E)            
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inbb_d[l_ac].inbb007          

            ##若是雜項庫存發料作業時，輸入的料件+產品特徵+庫存管理特徵+庫位必須存在[T:庫存明細檔]中
            #151113-00020#1 151119 By pomelo add(S)
            IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
               LET l_type = '1'
            ELSE
               LET l_type = '2'
            END IF
            IF l_type = '1' THEN
            #151113-00020#1 151119 By pomelo add(E)
            #IF g_argv[1] = '1' THEN    #151113-00020#1 151119 By pomelo mark
               #150324-00007#1 20150413 By pmoelo add(S)
               LET g_qryparam.default2 = g_inbb_d[l_ac].inbb008
               LET g_qryparam.default3 = g_inbb_d[l_ac].inbb009
               LET g_qryparam.default4 = g_inbb_d[l_ac].inbb003
               LET g_qryparam.arg1 = g_inba_m.inbasite        #營運據點
               LET g_qryparam.arg2 = g_inbb_d[l_ac].inbb001   #商品編號
               #產品特徵
               IF cl_null(g_inbb_d[l_ac].inbb002) THEN
                  LET g_inbb_d[l_ac].inbb002 = ' '
               END IF
               LET g_qryparam.arg3 = g_inbb_d[l_ac].inbb002
               #庫存管理特徵
               IF cl_null(g_inbb_d[l_ac].inbb003) THEN
                  LET g_qryparam.arg4 = ''
               ELSE
                  LET g_qryparam.arg4 = g_inbb_d[l_ac].inbb003
               END IF
               LET g_qryparam.arg5 = ''                       #庫位
               #儲位
               IF cl_null(g_inbb_d[l_ac].inbb008) THEN
                  LET g_qryparam.arg6 = ''
               ELSE
                  LET g_qryparam.arg6 = g_inbb_d[l_ac].inbb008
               END IF
               #批號
               IF cl_null(g_inbb_d[l_ac].inbb009) THEN
                  LET g_qryparam.arg7 = ''
               ELSE
                  LET g_qryparam.arg7 = g_inbb_d[l_ac].inbb009
               END IF
               #150324-00007#1 20150413 By pmoelo add(E)
               
               #150629-00016#1 150803 by lori add---(S)
               LET l_success = ''
               LET l_set_entry = ''
               #IF g_argv[1] = '1' THEN    #151113-00020#1 151119 By pomelo mark
               IF l_type = '1' THEN        #151113-00020#1 151119 By pomelo add
                  LET l_type = -1
               ELSE
                  LET l_type = 1
               END IF
               
               CALL s_lot_out_entry(l_type,g_inba_m.inbadocno,g_inba_m.inbasite,g_inbb_d[l_ac].inbb001) 
                  RETURNING l_success,l_set_entry
               
               IF l_success AND l_set_entry = FALSE THEN 
                  CALL q_inag004_20()
                  LET g_inbb_d[l_ac].inbb007 = g_qryparam.return1   #庫位
                  LET g_inbb_d[l_ac].inbb008 = g_qryparam.return2   #儲位
                  LET g_inbb_d[l_ac].inbb003 = g_qryparam.return3   #庫存管理特徵               
               ELSE
               #150629-00016#1 150803 by lori add---(E)
                  #150324-00007#1 20150413 By pmoelo add(S)
                  CALL q_inag004_18()
                  LET g_inbb_d[l_ac].inbb007 = g_qryparam.return1 
                  LET g_inbb_d[l_ac].inbb008 = g_qryparam.return2
                  LET g_inbb_d[l_ac].inbb009 = g_qryparam.return3
                  LET g_inbb_d[l_ac].inbb003 = g_qryparam.return4
                  #150324-00007#1 20150413 By pmoelo add(E)
               END IF   #150629-00016#1 150803 by lori add
               
               LET g_inbb_d[l_ac].inbb007_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007) 
               LET g_inbb_d[l_ac].inbb008_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008)               
               DISPLAY g_inbb_d[l_ac].inbb007 TO inbb007
               DISPLAY g_inbb_d[l_ac].inbb008 TO inbb008
               DISPLAY g_inbb_d[l_ac].inbb009 TO inbb009
               DISPLAY g_inbb_d[l_ac].inbb003 TO inbb003
               DISPLAY g_inbb_d[l_ac].inbb007_desc TO inbb007_desc
               DISPLAY g_inbb_d[l_ac].inbb008_desc TO inbb008_desc
            ELSE
               CALL q_inaa001_1()  
               LET g_inbb_d[l_ac].inbb007 = g_qryparam.return1 
               LET g_inbb_d[l_ac].inbb007_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007) 
               DISPLAY g_inbb_d[l_ac].inbb007 TO inbb007
               DISPLAY g_inbb_d[l_ac].inbb008 TO inbb008
               DISPLAY g_inbb_d[l_ac].inbb007_desc TO inbb007_desc               
            END IF
        
            NEXT FIELD inbb007         
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb008
            #add-point:ON ACTION controlp INFIELD inbb008 name="input.c.page1.inbb008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #151113-00020#1 151119 By pomelo add(S)
            IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
               LET l_type = '1'
            ELSE
               LET l_type = '2'
            END IF
            IF l_type = '1' THEN
            #151113-00020#1 151119 By pomelo add(E)
            #IF g_argv[1] = '1' THEN   #151113-00020#1 151119 By pomelo mark
               LET g_qryparam.default1 = g_inbb_d[l_ac].inbb007
               LET g_qryparam.default2 = g_inbb_d[l_ac].inbb008
               LET g_qryparam.default3 = g_inbb_d[l_ac].inbb009
               LET g_qryparam.default4 = g_inbb_d[l_ac].inbb003
               LET g_qryparam.arg1 = g_inba_m.inbasite        #營運據點
               LET g_qryparam.arg2 = g_inbb_d[l_ac].inbb001   #商品編號
               #產品特徵
               IF cl_null(g_inbb_d[l_ac].inbb002) THEN
                  LET g_inbb_d[l_ac].inbb002 = ' '
               END IF
               LET g_qryparam.arg3 = g_inbb_d[l_ac].inbb002
               #庫存管理特徵
               IF cl_null(g_inbb_d[l_ac].inbb003) THEN
                  LET g_qryparam.arg4 = ''
               ELSE
                  LET g_qryparam.arg4 = g_inbb_d[l_ac].inbb003
               END IF
               LET g_qryparam.arg5 = g_inbb_d[l_ac].inbb007   #庫位
               
               #儲位
               LET g_qryparam.arg6 = ''
               
               #批號
               IF cl_null(g_inbb_d[l_ac].inbb009) THEN
                  LET g_qryparam.arg7 = ''
               ELSE
                  LET g_qryparam.arg7 = g_inbb_d[l_ac].inbb009
               END IF
               #150324-00007#1 20150413 By pmoelo add(E)
               
               #150629-00016#1 150803 by lori add---(S)
               LET l_success = ''
               LET l_set_entry = ''
               #IF g_argv[1] = '1' THEN    #151113-00020#1 151119 By pomelo mark
               IF l_type = '1' THEN        #151113-00020#1 151119 By pomelo add
                  LET l_type = -1
               ELSE
                  LET l_type = 1
               END IF
               
               CALL s_lot_out_entry(l_type,g_inba_m.inbadocno,g_inba_m.inbasite,g_inbb_d[l_ac].inbb001) 
                  RETURNING l_success,l_set_entry
               
               IF l_success AND l_set_entry = FALSE THEN 
                  CALL q_inag004_20()
                  LET g_inbb_d[l_ac].inbb007 = g_qryparam.return1   #庫位
                  LET g_inbb_d[l_ac].inbb008 = g_qryparam.return2   #儲位
                  LET g_inbb_d[l_ac].inbb003 = g_qryparam.return3   #庫存管理特徵               
               ELSE
               #150629-00016#1 150803 by lori add---(E)               
                  #150324-00007#1 20150413 By pmoelo add(S)
                  CALL q_inag004_18()
                  LET g_inbb_d[l_ac].inbb007 = g_qryparam.return1 
                  LET g_inbb_d[l_ac].inbb008 = g_qryparam.return2
                  LET g_inbb_d[l_ac].inbb009 = g_qryparam.return3
                  LET g_inbb_d[l_ac].inbb003 = g_qryparam.return4
                  #150324-00007#1 20150413 By pmoelo add(E)
               END IF   #150629-00016#1 150803 by lori add   
            ELSE
               LET g_qryparam.default1 = g_inbb_d[l_ac].inbb008 
               LET g_qryparam.arg1 = g_inbb_d[l_ac].inbb007                   
               CALL q_inab002_3()                                
               LET g_inbb_d[l_ac].inbb008 = g_qryparam.return1            
            END IF
            
            LET g_inbb_d[l_ac].inbb008_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008) 
            DISPLAY g_inbb_d[l_ac].inbb008 TO inbb008
            DISPLAY g_inbb_d[l_ac].inbb008_desc TO inbb008_desc
            NEXT FIELD inbb008                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb009
            #add-point:ON ACTION controlp INFIELD inbb009 name="input.c.page1.inbb009"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #150324-00007#1 20150413 By pmoelo mark(S)
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            #
            #LET g_qryparam.default1 = g_inbb_d[l_ac].inbb009             #給予default值
            #LET g_qryparam.default2 = "" #g_inbb_d[l_ac].inag004 #庫位編號
            #LET g_qryparam.default3 = "" #g_inbb_d[l_ac].inag005 #儲位編號
            #LET g_qryparam.default4 = "" #g_inbb_d[l_ac].inag006 #批號
            ##給予arg
            #LET g_qryparam.arg1 = "" #s
            #LET g_qryparam.arg2 = "" #s
            #
            #CALL q_inag004_13()                                #呼叫開窗
            #
            #LET g_inbb_d[l_ac].inbb009 = g_qryparam.return1              
            ##LET g_inbb_d[l_ac].inag004 = g_qryparam.return2 
            ##LET g_inbb_d[l_ac].inag005 = g_qryparam.return3 
            ##LET g_inbb_d[l_ac].inag006 = g_qryparam.return4 
            #DISPLAY g_inbb_d[l_ac].inbb009 TO inbb009              #
            ##DISPLAY g_inbb_d[l_ac].inag004 TO inag004 #庫位編號
            ##DISPLAY g_inbb_d[l_ac].inag005 TO inag005 #儲位編號
            ##DISPLAY g_inbb_d[l_ac].inag006 TO inag006 #批號
            #NEXT FIELD inbb009                          #返回原欄位
            #150324-00007#1 20150413 By pmoelo mark(E)
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb210
            #add-point:ON ACTION controlp INFIELD inbb210 name="input.c.page1.inbb210"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb003
            #add-point:ON ACTION controlp INFIELD inbb003 name="input.c.page1.inbb003"
            #150324-00007#1 20150413 By pmoelo mark(S)
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_inbb_d[l_ac].inbb003 
            #
            ###若是雜項庫存發料作業時，輸入的料件+產品特徵+庫存管理特徵+庫位必須存在[T:庫存明細檔]中
            #IF g_argv[1] = '1' THEN
            #   LET g_qryparam.arg1 = g_inba_m.inbasite
            #   LET g_qryparam.arg2 = g_inbb_d[l_ac].inbb001 
            #   LET g_qryparam.arg3 = g_inbb_d[l_ac].inbb002
            #   LET g_qryparam.arg4 = g_inbb_d[l_ac].inbb003
            #   LET g_qryparam.arg5 = g_inbb_d[l_ac].inbb007
            #   
            #   CALL q_inag001_4()
            #   LET g_inbb_d[l_ac].inbb001 = g_qryparam.return1 
            #   LET g_inbb_d[l_ac].inbb002 = g_qryparam.return2
            #   LET g_inbb_d[l_ac].inbb003 = g_qryparam.return3
            #   LET g_inbb_d[l_ac].inbb007 = g_qryparam.return7
            #   
            #   CALL s_feature_description(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002) 
            #      RETURNING l_success,g_inbb_d[l_ac].inbb002_desc
            #   LET g_inbb_d[l_ac].inbb007_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007) 
            #   LET g_inbb_d[l_ac].inbb008_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008)               
            #ELSE
            #END IF
            #
            #NEXT FIELD inbb003
            #150324-00007#1 20150413 By pmoelo mark(E)
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb220
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb220
            #add-point:ON ACTION controlp INFIELD inbb220 name="input.c.page1.inbb220"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inbb_d[l_ac].inbb220 
            
            CALL q_inaa001_1()
            LET g_inbb_d[l_ac].inbb220 = g_qryparam.return1    
            DISPLAY g_inbb_d[l_ac].inbb220 TO inbb220
            LET g_inbb_d[l_ac].inbb220_desc = s_desc_get_stock_desc('',g_inbb_d[l_ac].inbb220)
            NEXT FIELD inbb220
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb221
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb221
            #add-point:ON ACTION controlp INFIELD inbb221 name="input.c.page1.inbb221"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inbb_d[l_ac].inbb221
            
            LET g_qryparam.arg1 = g_inbb_d[l_ac].inbb220
            CALL q_inab002_3()
            
            LET g_inbb_d[l_ac].inbb221 = g_qryparam.return1
            DISPLAY g_inbb_d[l_ac].inbb221 TO inbb221
            LET g_inbb_d[l_ac].inbb221_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb220,g_inbb_d[l_ac].inbb221)
            NEXT FIELD inbb221
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb222
            #add-point:ON ACTION controlp INFIELD inbb222 name="input.c.page1.inbb222"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb223
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb223
            #add-point:ON ACTION controlp INFIELD inbb223 name="input.c.page1.inbb223"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb201
            #add-point:ON ACTION controlp INFIELD inbb201 name="input.c.page1.inbb201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb202
            #add-point:ON ACTION controlp INFIELD inbb202 name="input.c.page1.inbb202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb203
            #add-point:ON ACTION controlp INFIELD inbb203 name="input.c.page1.inbb203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb011
            #add-point:ON ACTION controlp INFIELD inbb011 name="input.c.page1.inbb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb012
            #add-point:ON ACTION controlp INFIELD inbb012 name="input.c.page1.inbb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb010
            #add-point:ON ACTION controlp INFIELD inbb010 name="input.c.page1.inbb010"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inbb_d[l_ac].inbb010           

            CALL q_ooca001_1()                  

            LET g_inbb_d[l_ac].inbb010 = g_qryparam.return1              
            LET g_inbb_d[l_ac].inbb010_desc = s_desc_get_unit_desc(g_inbb_d[l_ac].inbb010)
            
            NEXT FIELD inbb010                          
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb218
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb218
            #add-point:ON ACTION controlp INFIELD inbb218 name="input.c.page1.inbb218"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb219
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb219
            #add-point:ON ACTION controlp INFIELD inbb219 name="input.c.page1.inbb219"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb216
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb216
            #add-point:ON ACTION controlp INFIELD inbb216 name="input.c.page1.inbb216"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb217
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb217
            #add-point:ON ACTION controlp INFIELD inbb217 name="input.c.page1.inbb217"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb209
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb209
            #add-point:ON ACTION controlp INFIELD inbb209 name="input.c.page1.inbb209"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbb_d[l_ac].inbb209 
            
            CALL q_stae001()                                #呼叫開窗

            LET g_inbb_d[l_ac].inbb209  = g_qryparam.return1             
            LET g_inbb_d[l_ac].inbb209_desc  = aint911_inbb209_ref(g_inbb_d[l_ac].inbb209) 
            DISPLAY BY NAME g_inbb_d[l_ac].inbb209,g_inbb_d[l_ac].inbb209_desc         
            NEXT FIELD inbb209 
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb207
            #add-point:ON ACTION controlp INFIELD inbb207 name="input.c.page1.inbb207"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb208
            #add-point:ON ACTION controlp INFIELD inbb208 name="input.c.page1.inbb208"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb205
            #add-point:ON ACTION controlp INFIELD inbb205 name="input.c.page1.inbb205"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb016
            #add-point:ON ACTION controlp INFIELD inbb016 name="input.c.page1.inbb016"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inbb_d[l_ac].inbb016  
            LET g_qryparam.arg1 = g_inba007_acc
            CALL q_oocq002()                              

            LET g_inbb_d[l_ac].inbb016 = g_qryparam.return1              
            LET g_inbb_d[l_ac].inbb016_desc = s_desc_get_acc_desc(g_inba007_acc,g_inbb_d[l_ac].inbb016)
            DISPLAY BY NAME g_inbb_d[l_ac].inbb016,g_inbb_d[l_ac].inbb016_desc
            NEXT FIELD inbb016
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb016_desc
            #add-point:ON ACTION controlp INFIELD inbb016_desc name="input.c.page1.inbb016_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb018
            #add-point:ON ACTION controlp INFIELD inbb018 name="input.c.page1.inbb018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb020
            #add-point:ON ACTION controlp INFIELD inbb020 name="input.c.page1.inbb020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb204
            #add-point:ON ACTION controlp INFIELD inbb204 name="input.c.page1.inbb204"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb022
            #add-point:ON ACTION controlp INFIELD inbb022 name="input.c.page1.inbb022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbb021
            #add-point:ON ACTION controlp INFIELD inbb021 name="input.c.page1.inbb021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbbsite
            #add-point:ON ACTION controlp INFIELD inbbsite name="input.c.page1.inbbsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbbunit
            #add-point:ON ACTION controlp INFIELD inbbunit name="input.c.page1.inbbunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_inbb_d[l_ac].* = g_inbb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint911_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inbb_d[l_ac].inbbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_inbb_d[l_ac].* = g_inbb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF cl_null(g_inbb_d[l_ac].inbb002) THEN   LET g_inbb_d[l_ac].inbb002 = ' '   END IF
               IF cl_null(g_inbb_d[l_ac].inbb003) THEN   LET g_inbb_d[l_ac].inbb003 = ' '   END IF
               IF cl_null(g_inbb_d[l_ac].inbb008) THEN   LET g_inbb_d[l_ac].inbb008 = ' '   END IF
               IF cl_null(g_inbb_d[l_ac].inbb009) THEN   LET g_inbb_d[l_ac].inbb009 = ' '   END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aint911_inbb_t_mask_restore('restore_mask_o')
      
               UPDATE inbb_t SET (inbbdocno,inbbseq,inbb017,inbb211,inbb212,inbb200,inbb001,inbb002, 
                   inbb213,inbb214,inbb215,inbb007,inbb008,inbb009,inbb210,inbb003,inbb220,inbb221,inbb222, 
                   inbb223,inbb201,inbb202,inbb203,inbb011,inbb012,inbb010,inbb218,inbb219,inbb216,inbb217, 
                   inbb224,inbb225,inbb209,inbb207,inbb208,inbb205,inbb206,inbb016,inbb018,inbb020,inbb204, 
                   inbb022,inbb021,inbbsite,inbbunit) = (g_inba_m.inbadocno,g_inbb_d[l_ac].inbbseq,g_inbb_d[l_ac].inbb017, 
                   g_inbb_d[l_ac].inbb211,g_inbb_d[l_ac].inbb212,g_inbb_d[l_ac].inbb200,g_inbb_d[l_ac].inbb001, 
                   g_inbb_d[l_ac].inbb002,g_inbb_d[l_ac].inbb213,g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb215, 
                   g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008,g_inbb_d[l_ac].inbb009,g_inbb_d[l_ac].inbb210, 
                   g_inbb_d[l_ac].inbb003,g_inbb_d[l_ac].inbb220,g_inbb_d[l_ac].inbb221,g_inbb_d[l_ac].inbb222, 
                   g_inbb_d[l_ac].inbb223,g_inbb_d[l_ac].inbb201,g_inbb_d[l_ac].inbb202,g_inbb_d[l_ac].inbb203, 
                   g_inbb_d[l_ac].inbb011,g_inbb_d[l_ac].inbb012,g_inbb_d[l_ac].inbb010,g_inbb_d[l_ac].inbb218, 
                   g_inbb_d[l_ac].inbb219,g_inbb_d[l_ac].inbb216,g_inbb_d[l_ac].inbb217,g_inbb_d[l_ac].inbb224, 
                   g_inbb_d[l_ac].inbb225,g_inbb_d[l_ac].inbb209,g_inbb_d[l_ac].inbb207,g_inbb_d[l_ac].inbb208, 
                   g_inbb_d[l_ac].inbb205,g_inbb_d[l_ac].inbb206,g_inbb_d[l_ac].inbb016,g_inbb_d[l_ac].inbb018, 
                   g_inbb_d[l_ac].inbb020,g_inbb_d[l_ac].inbb204,g_inbb_d[l_ac].inbb022,g_inbb_d[l_ac].inbb021, 
                   g_inbb_d[l_ac].inbbsite,g_inbb_d[l_ac].inbbunit)
                WHERE inbbent = g_enterprise AND inbbdocno = g_inba_m.inbadocno 
 
                  AND inbbseq = g_inbb_d_t.inbbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_inbb_d[l_ac].* = g_inbb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inbb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inbb_d[l_ac].* = g_inbb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inba_m.inbadocno
               LET gs_keys_bak[1] = g_inbadocno_t
               LET gs_keys[2] = g_inbb_d[g_detail_idx].inbbseq
               LET gs_keys_bak[2] = g_inbb_d_t.inbbseq
               CALL aint911_update_b('inbb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aint911_inbb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_inbb_d[g_detail_idx].inbbseq = g_inbb_d_t.inbbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_inba_m.inbadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_inbb_d_t.inbbseq
 
                  CALL aint911_key_update_b(gs_keys,'inbb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_inba_m),util.JSON.stringify(g_inbb_d_t)
               LET g_log2 = util.JSON.stringify(g_inba_m),util.JSON.stringify(g_inbb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF NOT aint911_upd_inbc() THEN
                  LET g_inbb_d[l_ac].* = g_inbb_d_o.*
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL aint911_b_fill()
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aint911_unlock_b("inbb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL aint911_b_fill()   #151207-00021#2 Add By Ken 151208 修正切換頁面時重新顯示資料
            DISPLAY "page:",g_current_page
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_inbb_d[li_reproduce_target].* = g_inbb_d[li_reproduce].*
 
               LET g_inbb_d[li_reproduce_target].inbbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inbb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inbb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_inbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL aint911_idx_chk()
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
            CALL aint911_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="aint911.input.other" >}
      
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
            NEXT FIELD inbasite
            #end add-point  
            NEXT FIELD inbadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD inbbseq
               WHEN "s_detail2"
                  NEXT FIELD inbcseq
 
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
 
{<section id="aint911.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aint911_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aint911_b_fill() #單身填充
      CALL aint911_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint911_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET g_inba_m.inba007_desc = s_desc_get_acc_desc(g_inba007_acc,g_inba_m.inba007)
   CALL aint911_inba013_ref()   #150827-00013#1 by loei add
   #end add-point
   
   #遮罩相關處理
   LET g_inba_m_mask_o.* =  g_inba_m.*
   CALL aint911_inba_t_mask()
   LET g_inba_m_mask_n.* =  g_inba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_inba_m.inba001,g_inba_m.inbasite,g_inba_m.inbasite_desc,g_inba_m.inbadocdt,g_inba_m.inbadocno, 
       g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003,g_inba_m.inba003_desc,g_inba_m.inba004, 
       g_inba_m.inba004_desc,g_inba_m.inba013,g_inba_m.inba013_desc,g_inba_m.inbaunit,g_inba_m.inbastus, 
       g_inba_m.inba005,g_inba_m.inba006,g_inba_m.inba015,g_inba_m.inba015_desc,g_inba_m.inba203,g_inba_m.inba203_desc, 
       g_inba_m.inba205,g_inba_m.inba205_desc,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba206_desc, 
       g_inba_m.inba207,g_inba_m.inba207_desc,g_inba_m.inba204,g_inba_m.inba204_desc,g_inba_m.inba007, 
       g_inba_m.inba007_desc,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp, 
       g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid,g_inba_m.inbacrtid_desc,g_inba_m.inbacrtdp,g_inba_m.inbacrtdp_desc, 
       g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamodid_desc,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
       g_inba_m.inbacnfid_desc,g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstid_desc,g_inba_m.inbapstdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inba_m.inbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_inbb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_inbb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aint911_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aint911.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aint911_detail_show()
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
 
{<section id="aint911.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint911_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE inba_t.inbadocno 
   DEFINE l_oldno     LIKE inba_t.inbadocno 
 
   DEFINE l_master    RECORD LIKE inba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE inbb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE inbc_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert    LIKE type_t.num5
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
   
   IF g_inba_m.inbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_inbadocno_t = g_inba_m.inbadocno
 
    
   LET g_inba_m.inbadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inba_m.inbaownid = g_user
      LET g_inba_m.inbaowndp = g_dept
      LET g_inba_m.inbacrtid = g_user
      LET g_inba_m.inbacrtdp = g_dept 
      LET g_inba_m.inbacrtdt = cl_get_current()
      LET g_inba_m.inbamodid = g_user
      LET g_inba_m.inbamoddt = cl_get_current()
      LET g_inba_m.inbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #營運組織
   CALL s_aooi500_default(g_prog,g_site_str,g_inba_m.inbasite)
      RETURNING l_insert,g_inba_m.inbasite
   IF l_insert = FALSE THEN
      RETURN
   END IF
   #預設單別
   CALL s_arti200_get_def_doc_type(g_inba_m.inbasite,g_prog,'1')
      RETURNING l_success,g_inba_m.inbadocno 
   
   LET g_inba_m.inbadocdt = g_today   #單據日期
   LET g_inba_m.inba001 = g_argv[1]   #單據類型
   LET g_inba_m.inba002 = g_today     #扣帳日期   
   LET g_inba_m.inba003 = g_user      #申請人員
   LET g_inba_m.inba004 = g_dept      #申請部門
   LET g_inba_m.inba005 = '1'         #來源資料類型
   
   LET g_inba_m.inbasite_desc = s_desc_get_department_desc(g_inba_m.inbasite)  
   LET g_inba_m.inba003_desc = s_desc_get_person_desc(g_inba_m.inba003)   
   LET g_inba_m.inba004_desc = s_desc_get_department_desc(g_inba_m.inba004) 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inba_m.inbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aint911_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_inba_m.* TO NULL
      INITIALIZE g_inbb_d TO NULL
      INITIALIZE g_inbb2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aint911_show()
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
   CALL aint911_set_act_visible()   
   CALL aint911_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inbadocno_t = g_inba_m.inbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " inbaent = " ||g_enterprise|| " AND",
                      " inbadocno = '", g_inba_m.inbadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint911_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aint911_idx_chk()
   
   LET g_data_owner = g_inba_m.inbaownid      
   LET g_data_dept  = g_inba_m.inbaowndp
   
   #功能已完成,通報訊息中心
   CALL aint911_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aint911.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aint911_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE inbb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE inbc_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aint911_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM inbb_t
    WHERE inbbent = g_enterprise AND inbbdocno = g_inbadocno_t
 
    INTO TEMP aint911_detail
 
   #將key修正為調整後   
   UPDATE aint911_detail 
      #更新key欄位
      SET inbbdocno = g_inba_m.inbadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO inbb_t SELECT * FROM aint911_detail
   
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
   DROP TABLE aint911_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM inbc_t 
    WHERE inbcent = g_enterprise AND inbcdocno = g_inbadocno_t
 
    INTO TEMP aint911_detail
 
   #將key修正為調整後   
   UPDATE aint911_detail SET inbcdocno = g_inba_m.inbadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO inbc_t SELECT * FROM aint911_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aint911_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_inbadocno_t = g_inba_m.inbadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint911.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint911_delete()
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
   
   IF g_inba_m.inbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aint911_cl USING g_enterprise,g_inba_m.inbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint911_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint911_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint911_master_referesh USING g_inba_m.inbadocno INTO g_inba_m.inba001,g_inba_m.inbasite, 
       g_inba_m.inbadocdt,g_inba_m.inbadocno,g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003, 
       g_inba_m.inba004,g_inba_m.inba013,g_inba_m.inbaunit,g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006, 
       g_inba_m.inba015,g_inba_m.inba203,g_inba_m.inba205,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba207, 
       g_inba_m.inba204,g_inba_m.inba007,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaowndp,g_inba_m.inbacrtid, 
       g_inba_m.inbacrtdp,g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
       g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstdt,g_inba_m.inba003_desc,g_inba_m.inba004_desc, 
       g_inba_m.inba015_desc,g_inba_m.inba203_desc,g_inba_m.inba205_desc,g_inba_m.inba206_desc,g_inba_m.inba207_desc, 
       g_inba_m.inba204_desc,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid_desc, 
       g_inba_m.inbacrtdp_desc,g_inba_m.inbamodid_desc,g_inba_m.inbacnfid_desc,g_inba_m.inbapstid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aint911_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inba_m_mask_o.* =  g_inba_m.*
   CALL aint911_inba_t_mask()
   LET g_inba_m_mask_n.* =  g_inba_m.*
   
   CALL aint911_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint911_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_inbadocno_t = g_inba_m.inbadocno
 
 
      DELETE FROM inba_t
       WHERE inbaent = g_enterprise AND inbadocno = g_inba_m.inbadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_inba_m.inbadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_inba_m.inbadocno,g_inba_m.inbadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM inbb_t
       WHERE inbbent = g_enterprise AND inbbdocno = g_inba_m.inbadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbb_t:",SQLERRMESSAGE 
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
      DELETE FROM inbc_t
       WHERE inbcent = g_enterprise AND
             inbcdocno = g_inba_m.inbadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_inba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aint911_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_inbb_d.clear() 
      CALL g_inbb2_d.clear()       
 
     
      CALL aint911_ui_browser_refresh()  
      #CALL aint911_ui_headershow()  
      #CALL aint911_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aint911_browser_fill("")
         CALL aint911_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint911_cl
 
   #功能已完成,通報訊息中心
   CALL aint911_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aint911.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint911_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success  LIKE type_t.num5     #151113-00020#1 151117 By pomelo add
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_inbb_d.clear()
   CALL g_inbb2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aint911_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT inbbseq,inbb017,inbb211,inbb212,inbb200,inbb001,inbb002,inbb213, 
             inbb214,inbb215,inbb007,inbb008,inbb009,inbb210,inbb003,inbb220,inbb221,inbb222,inbb223, 
             inbb201,inbb202,inbb203,inbb011,inbb012,inbb010,inbb218,inbb219,inbb216,inbb217,inbb224, 
             inbb225,inbb209,inbb207,inbb208,inbb205,inbb206,inbb016,inbb018,inbb020,inbb204,inbb022, 
             inbb021,inbbsite,inbbunit ,t1.imaal003 ,t2.imaal004 ,t3.imaal003 ,t4.imaal004 ,t5.inayl003 , 
             t6.inab003 ,t7.inayl003 ,t8.inab003 ,t9.oocal003 ,t10.oocal003 ,t11.oocal003 ,t12.oocal003 , 
             t13.oocal003 ,t14.stael003 FROM inbb_t",   
                     " INNER JOIN inba_t ON inbaent = " ||g_enterprise|| " AND inbadocno = inbbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=inbb001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=inbb001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=inbb214 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=inbb214 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t5 ON t5.inaylent="||g_enterprise||" AND t5.inayl001=inbb007 AND t5.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t6 ON t6.inabent="||g_enterprise||" AND t6.inabsite=inbbsite AND t6.inab001=inbb007 AND t6.inab002=inbb008  ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent="||g_enterprise||" AND t7.inayl001=inbb220 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t8 ON t8.inabent="||g_enterprise||" AND t8.inabsite=inbbsite AND t8.inab001=inbb220 AND t8.inab002=inbb221  ",
               " LEFT JOIN oocal_t t9 ON t9.oocalent="||g_enterprise||" AND t9.oocal001=inbb201 AND t9.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t10 ON t10.oocalent="||g_enterprise||" AND t10.oocal001=inbb010 AND t10.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t11 ON t11.oocalent="||g_enterprise||" AND t11.oocal001=inbb218 AND t11.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t12 ON t12.oocalent="||g_enterprise||" AND t12.oocal001=inbb216 AND t12.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t13 ON t13.oocalent="||g_enterprise||" AND t13.oocal001=inbb224 AND t13.oocal002='"||g_dlang||"' ",
               " LEFT JOIN stael_t t14 ON t14.staelent="||g_enterprise||" AND t14.stael001=inbb209 AND t14.stael002='"||g_dlang||"' ",
 
                     " WHERE inbbent=? AND inbbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY inbb_t.inbbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint911_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aint911_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_inba_m.inbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_inba_m.inbadocno INTO g_inbb_d[l_ac].inbbseq,g_inbb_d[l_ac].inbb017, 
          g_inbb_d[l_ac].inbb211,g_inbb_d[l_ac].inbb212,g_inbb_d[l_ac].inbb200,g_inbb_d[l_ac].inbb001, 
          g_inbb_d[l_ac].inbb002,g_inbb_d[l_ac].inbb213,g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb215, 
          g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008,g_inbb_d[l_ac].inbb009,g_inbb_d[l_ac].inbb210, 
          g_inbb_d[l_ac].inbb003,g_inbb_d[l_ac].inbb220,g_inbb_d[l_ac].inbb221,g_inbb_d[l_ac].inbb222, 
          g_inbb_d[l_ac].inbb223,g_inbb_d[l_ac].inbb201,g_inbb_d[l_ac].inbb202,g_inbb_d[l_ac].inbb203, 
          g_inbb_d[l_ac].inbb011,g_inbb_d[l_ac].inbb012,g_inbb_d[l_ac].inbb010,g_inbb_d[l_ac].inbb218, 
          g_inbb_d[l_ac].inbb219,g_inbb_d[l_ac].inbb216,g_inbb_d[l_ac].inbb217,g_inbb_d[l_ac].inbb224, 
          g_inbb_d[l_ac].inbb225,g_inbb_d[l_ac].inbb209,g_inbb_d[l_ac].inbb207,g_inbb_d[l_ac].inbb208, 
          g_inbb_d[l_ac].inbb205,g_inbb_d[l_ac].inbb206,g_inbb_d[l_ac].inbb016,g_inbb_d[l_ac].inbb018, 
          g_inbb_d[l_ac].inbb020,g_inbb_d[l_ac].inbb204,g_inbb_d[l_ac].inbb022,g_inbb_d[l_ac].inbb021, 
          g_inbb_d[l_ac].inbbsite,g_inbb_d[l_ac].inbbunit,g_inbb_d[l_ac].inbb001_desc,g_inbb_d[l_ac].inbb001_desc_desc, 
          g_inbb_d[l_ac].inbb214_desc,g_inbb_d[l_ac].inbb214_desc_desc,g_inbb_d[l_ac].inbb007_desc,g_inbb_d[l_ac].inbb008_desc, 
          g_inbb_d[l_ac].inbb220_desc,g_inbb_d[l_ac].inbb221_desc,g_inbb_d[l_ac].inbb201_desc,g_inbb_d[l_ac].inbb010_desc, 
          g_inbb_d[l_ac].inbb218_desc,g_inbb_d[l_ac].inbb216_desc,g_inbb_d[l_ac].inbb224_desc,g_inbb_d[l_ac].inbb209_desc  
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
         LET g_inbb_d[l_ac].inbb016_desc = s_desc_get_acc_desc(g_inba007_acc,g_inbb_d[l_ac].inbb016)
         
         #151113-00020#1 151117 By pomelo add(S)
         IF NOT cl_null(g_inbb_d[l_ac].inbb002) THEN
            CALL s_feature_description(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002) 
               RETURNING l_success,g_inbb_d[l_ac].inbb002_desc
         END IF
         IF NOT cl_null(g_inbb_d[l_ac].inbb215) THEN
            CALL s_feature_description(g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb215) 
               RETURNING l_success,g_inbb_d[l_ac].inbb215_desc
         END IF
         LET g_inbb_d[l_ac].inbb0171 = g_inbb_d[l_ac].inbb017
         #151113-00020#1 151117 By pomelo add(E)
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
   IF aint911_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT inbcseq,inbcseq1,inbc209,inbc210,inbc200,inbc001,inbc002,inbc005, 
             inbc006,inbc007,inbc003,inbc201,inbc202,inbc009,inbc010,inbc211,inbc212,inbc208,inbc206, 
             inbc207,inbc204,inbc205,inbc011,inbc015,inbc203,inbc016,inbc017,inbcsite,inbcunit ,t15.imaal003 , 
             t16.imaal004 ,t17.inayl003 ,t18.oocal003 ,t19.oocal003 ,t20.oocal003 ,t21.stael003 ,t22.oocal003 FROM inbc_t", 
                
                     " INNER JOIN  inba_t ON inbaent = " ||g_enterprise|| " AND inbadocno = inbcdocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t15 ON t15.imaalent="||g_enterprise||" AND t15.imaal001=inbc001 AND t15.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t16 ON t16.imaalent="||g_enterprise||" AND t16.imaal001=inbc001 AND t16.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t17 ON t17.inaylent="||g_enterprise||" AND t17.inayl001=inbc005 AND t17.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t18 ON t18.oocalent="||g_enterprise||" AND t18.oocal001=inbc201 AND t18.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t19 ON t19.oocalent="||g_enterprise||" AND t19.oocal001=inbc009 AND t19.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t20 ON t20.oocalent="||g_enterprise||" AND t20.oocal001=inbc211 AND t20.oocal002='"||g_dlang||"' ",
               " LEFT JOIN stael_t t21 ON t21.staelent="||g_enterprise||" AND t21.stael001=inbc208 AND t21.stael002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t22 ON t22.oocalent="||g_enterprise||" AND t22.oocal001=inbc011 AND t22.oocal002='"||g_dlang||"' ",
 
                     " WHERE inbcent=? AND inbcdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY inbc_t.inbcseq,inbc_t.inbcseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint911_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aint911_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_inba_m.inbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_inba_m.inbadocno INTO g_inbb2_d[l_ac].inbcseq,g_inbb2_d[l_ac].inbcseq1, 
          g_inbb2_d[l_ac].inbc209,g_inbb2_d[l_ac].inbc210,g_inbb2_d[l_ac].inbc200,g_inbb2_d[l_ac].inbc001, 
          g_inbb2_d[l_ac].inbc002,g_inbb2_d[l_ac].inbc005,g_inbb2_d[l_ac].inbc006,g_inbb2_d[l_ac].inbc007, 
          g_inbb2_d[l_ac].inbc003,g_inbb2_d[l_ac].inbc201,g_inbb2_d[l_ac].inbc202,g_inbb2_d[l_ac].inbc009, 
          g_inbb2_d[l_ac].inbc010,g_inbb2_d[l_ac].inbc211,g_inbb2_d[l_ac].inbc212,g_inbb2_d[l_ac].inbc208, 
          g_inbb2_d[l_ac].inbc206,g_inbb2_d[l_ac].inbc207,g_inbb2_d[l_ac].inbc204,g_inbb2_d[l_ac].inbc205, 
          g_inbb2_d[l_ac].inbc011,g_inbb2_d[l_ac].inbc015,g_inbb2_d[l_ac].inbc203,g_inbb2_d[l_ac].inbc016, 
          g_inbb2_d[l_ac].inbc017,g_inbb2_d[l_ac].inbcsite,g_inbb2_d[l_ac].inbcunit,g_inbb2_d[l_ac].inbc001_desc, 
          g_inbb2_d[l_ac].inbc001_desc_desc,g_inbb2_d[l_ac].inbc005_desc,g_inbb2_d[l_ac].inbc201_desc, 
          g_inbb2_d[l_ac].inbc009_desc,g_inbb2_d[l_ac].inbc211_desc,g_inbb2_d[l_ac].inbc208_desc,g_inbb2_d[l_ac].inbc011_desc  
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
         #151113-00020#1 151117 By pomelo add(S)
         IF g_argv[1] = '7' THEN
            LET g_inbb2_d[l_ac].inbc202 = g_inbb2_d[l_ac].inbc202 * (-1)
            LET g_inbb2_d[l_ac].inbc010 = g_inbb2_d[l_ac].inbc010 * (-1)
         END IF
         #151113-00020#1 151117 By pomelo add(E)
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
   
   CALL g_inbb_d.deleteElement(g_inbb_d.getLength())
   CALL g_inbb2_d.deleteElement(g_inbb2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aint911_pb
   FREE aint911_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_inbb_d.getLength()
      LET g_inbb_d_mask_o[l_ac].* =  g_inbb_d[l_ac].*
      CALL aint911_inbb_t_mask()
      LET g_inbb_d_mask_n[l_ac].* =  g_inbb_d[l_ac].*
   END FOR
   
   LET g_inbb2_d_mask_o.* =  g_inbb2_d.*
   FOR l_ac = 1 TO g_inbb2_d.getLength()
      LET g_inbb2_d_mask_o[l_ac].* =  g_inbb2_d[l_ac].*
      CALL aint911_inbc_t_mask()
      LET g_inbb2_d_mask_n[l_ac].* =  g_inbb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aint911.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint911_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   DEFINE l_log       STRING  #Add By Ken 151208 測Log
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
 
      #end add-point    
      DELETE FROM inbb_t
       WHERE inbbent = g_enterprise AND
         inbbdocno = ps_keys_bak[1] AND inbbseq = ps_keys_bak[2]
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
         CALL g_inbb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM inbc_t
       WHERE inbcent = g_enterprise AND
             inbcdocno = ps_keys_bak[1] AND inbcseq = ps_keys_bak[2] AND inbcseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_inbb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint911.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint911_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_success   LIKE type_t.num5    #150820-00008#1 150820 by lori add
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      #150820-00008#1 150820 by lori add---(S) 
      LET l_success = ''
         
      #IF g_argv[1] = '2' THEN   #151113-00020#1 151116 By pomelo mark
      #151113-00020#1 151116 By pomelo add(S)
      IF g_argv[1] MATCHES '[29]' OR (g_argv[1] MATCHES '[3456]' AND
         NOT cl_null(g_inba_m.inba208) AND g_inba_m.inba208 = 'Y') THEN
      #151113-00020#1 151116 By pomelo add(E)
         IF cl_null(g_inbb_d[g_detail_idx].inbb009) THEN
            CALL s_lot_out_get_batch_no(g_inbb_d[g_detail_idx].inbb001)
               RETURNING l_success,g_inbb_d[g_detail_idx].inbb009
         END IF   
      END IF    
      #150820-00008#1 150820 by lori add---(E)
      #end add-point 
      INSERT INTO inbb_t
                  (inbbent,
                   inbbdocno,
                   inbbseq
                   ,inbb017,inbb211,inbb212,inbb200,inbb001,inbb002,inbb213,inbb214,inbb215,inbb007,inbb008,inbb009,inbb210,inbb003,inbb220,inbb221,inbb222,inbb223,inbb201,inbb202,inbb203,inbb011,inbb012,inbb010,inbb218,inbb219,inbb216,inbb217,inbb224,inbb225,inbb209,inbb207,inbb208,inbb205,inbb206,inbb016,inbb018,inbb020,inbb204,inbb022,inbb021,inbbsite,inbbunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_inbb_d[g_detail_idx].inbb017,g_inbb_d[g_detail_idx].inbb211,g_inbb_d[g_detail_idx].inbb212, 
                       g_inbb_d[g_detail_idx].inbb200,g_inbb_d[g_detail_idx].inbb001,g_inbb_d[g_detail_idx].inbb002, 
                       g_inbb_d[g_detail_idx].inbb213,g_inbb_d[g_detail_idx].inbb214,g_inbb_d[g_detail_idx].inbb215, 
                       g_inbb_d[g_detail_idx].inbb007,g_inbb_d[g_detail_idx].inbb008,g_inbb_d[g_detail_idx].inbb009, 
                       g_inbb_d[g_detail_idx].inbb210,g_inbb_d[g_detail_idx].inbb003,g_inbb_d[g_detail_idx].inbb220, 
                       g_inbb_d[g_detail_idx].inbb221,g_inbb_d[g_detail_idx].inbb222,g_inbb_d[g_detail_idx].inbb223, 
                       g_inbb_d[g_detail_idx].inbb201,g_inbb_d[g_detail_idx].inbb202,g_inbb_d[g_detail_idx].inbb203, 
                       g_inbb_d[g_detail_idx].inbb011,g_inbb_d[g_detail_idx].inbb012,g_inbb_d[g_detail_idx].inbb010, 
                       g_inbb_d[g_detail_idx].inbb218,g_inbb_d[g_detail_idx].inbb219,g_inbb_d[g_detail_idx].inbb216, 
                       g_inbb_d[g_detail_idx].inbb217,g_inbb_d[g_detail_idx].inbb224,g_inbb_d[g_detail_idx].inbb225, 
                       g_inbb_d[g_detail_idx].inbb209,g_inbb_d[g_detail_idx].inbb207,g_inbb_d[g_detail_idx].inbb208, 
                       g_inbb_d[g_detail_idx].inbb205,g_inbb_d[g_detail_idx].inbb206,g_inbb_d[g_detail_idx].inbb016, 
                       g_inbb_d[g_detail_idx].inbb018,g_inbb_d[g_detail_idx].inbb020,g_inbb_d[g_detail_idx].inbb204, 
                       g_inbb_d[g_detail_idx].inbb022,g_inbb_d[g_detail_idx].inbb021,g_inbb_d[g_detail_idx].inbbsite, 
                       g_inbb_d[g_detail_idx].inbbunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_inbb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO inbc_t
                  (inbcent,
                   inbcdocno,
                   inbcseq,inbcseq1
                   ,inbc209,inbc210,inbc200,inbc001,inbc002,inbc005,inbc006,inbc007,inbc003,inbc201,inbc202,inbc009,inbc010,inbc211,inbc212,inbc208,inbc206,inbc207,inbc204,inbc205,inbc011,inbc015,inbc203,inbc016,inbc017,inbcsite,inbcunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_inbb2_d[g_detail_idx].inbc209,g_inbb2_d[g_detail_idx].inbc210,g_inbb2_d[g_detail_idx].inbc200, 
                       g_inbb2_d[g_detail_idx].inbc001,g_inbb2_d[g_detail_idx].inbc002,g_inbb2_d[g_detail_idx].inbc005, 
                       g_inbb2_d[g_detail_idx].inbc006,g_inbb2_d[g_detail_idx].inbc007,g_inbb2_d[g_detail_idx].inbc003, 
                       g_inbb2_d[g_detail_idx].inbc201,g_inbb2_d[g_detail_idx].inbc202,g_inbb2_d[g_detail_idx].inbc009, 
                       g_inbb2_d[g_detail_idx].inbc010,g_inbb2_d[g_detail_idx].inbc211,g_inbb2_d[g_detail_idx].inbc212, 
                       g_inbb2_d[g_detail_idx].inbc208,g_inbb2_d[g_detail_idx].inbc206,g_inbb2_d[g_detail_idx].inbc207, 
                       g_inbb2_d[g_detail_idx].inbc204,g_inbb2_d[g_detail_idx].inbc205,g_inbb2_d[g_detail_idx].inbc011, 
                       g_inbb2_d[g_detail_idx].inbc015,g_inbb2_d[g_detail_idx].inbc203,g_inbb2_d[g_detail_idx].inbc016, 
                       g_inbb2_d[g_detail_idx].inbc017,g_inbb2_d[g_detail_idx].inbcsite,g_inbb2_d[g_detail_idx].inbcunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_inbb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aint911.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint911_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inbb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aint911_inbb_t_mask_restore('restore_mask_o')
               
      UPDATE inbb_t 
         SET (inbbdocno,
              inbbseq
              ,inbb017,inbb211,inbb212,inbb200,inbb001,inbb002,inbb213,inbb214,inbb215,inbb007,inbb008,inbb009,inbb210,inbb003,inbb220,inbb221,inbb222,inbb223,inbb201,inbb202,inbb203,inbb011,inbb012,inbb010,inbb218,inbb219,inbb216,inbb217,inbb224,inbb225,inbb209,inbb207,inbb208,inbb205,inbb206,inbb016,inbb018,inbb020,inbb204,inbb022,inbb021,inbbsite,inbbunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_inbb_d[g_detail_idx].inbb017,g_inbb_d[g_detail_idx].inbb211,g_inbb_d[g_detail_idx].inbb212, 
                  g_inbb_d[g_detail_idx].inbb200,g_inbb_d[g_detail_idx].inbb001,g_inbb_d[g_detail_idx].inbb002, 
                  g_inbb_d[g_detail_idx].inbb213,g_inbb_d[g_detail_idx].inbb214,g_inbb_d[g_detail_idx].inbb215, 
                  g_inbb_d[g_detail_idx].inbb007,g_inbb_d[g_detail_idx].inbb008,g_inbb_d[g_detail_idx].inbb009, 
                  g_inbb_d[g_detail_idx].inbb210,g_inbb_d[g_detail_idx].inbb003,g_inbb_d[g_detail_idx].inbb220, 
                  g_inbb_d[g_detail_idx].inbb221,g_inbb_d[g_detail_idx].inbb222,g_inbb_d[g_detail_idx].inbb223, 
                  g_inbb_d[g_detail_idx].inbb201,g_inbb_d[g_detail_idx].inbb202,g_inbb_d[g_detail_idx].inbb203, 
                  g_inbb_d[g_detail_idx].inbb011,g_inbb_d[g_detail_idx].inbb012,g_inbb_d[g_detail_idx].inbb010, 
                  g_inbb_d[g_detail_idx].inbb218,g_inbb_d[g_detail_idx].inbb219,g_inbb_d[g_detail_idx].inbb216, 
                  g_inbb_d[g_detail_idx].inbb217,g_inbb_d[g_detail_idx].inbb224,g_inbb_d[g_detail_idx].inbb225, 
                  g_inbb_d[g_detail_idx].inbb209,g_inbb_d[g_detail_idx].inbb207,g_inbb_d[g_detail_idx].inbb208, 
                  g_inbb_d[g_detail_idx].inbb205,g_inbb_d[g_detail_idx].inbb206,g_inbb_d[g_detail_idx].inbb016, 
                  g_inbb_d[g_detail_idx].inbb018,g_inbb_d[g_detail_idx].inbb020,g_inbb_d[g_detail_idx].inbb204, 
                  g_inbb_d[g_detail_idx].inbb022,g_inbb_d[g_detail_idx].inbb021,g_inbb_d[g_detail_idx].inbbsite, 
                  g_inbb_d[g_detail_idx].inbbunit) 
         WHERE inbbent = g_enterprise AND inbbdocno = ps_keys_bak[1] AND inbbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint911_inbb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inbc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aint911_inbc_t_mask_restore('restore_mask_o')
               
      UPDATE inbc_t 
         SET (inbcdocno,
              inbcseq,inbcseq1
              ,inbc209,inbc210,inbc200,inbc001,inbc002,inbc005,inbc006,inbc007,inbc003,inbc201,inbc202,inbc009,inbc010,inbc211,inbc212,inbc208,inbc206,inbc207,inbc204,inbc205,inbc011,inbc015,inbc203,inbc016,inbc017,inbcsite,inbcunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_inbb2_d[g_detail_idx].inbc209,g_inbb2_d[g_detail_idx].inbc210,g_inbb2_d[g_detail_idx].inbc200, 
                  g_inbb2_d[g_detail_idx].inbc001,g_inbb2_d[g_detail_idx].inbc002,g_inbb2_d[g_detail_idx].inbc005, 
                  g_inbb2_d[g_detail_idx].inbc006,g_inbb2_d[g_detail_idx].inbc007,g_inbb2_d[g_detail_idx].inbc003, 
                  g_inbb2_d[g_detail_idx].inbc201,g_inbb2_d[g_detail_idx].inbc202,g_inbb2_d[g_detail_idx].inbc009, 
                  g_inbb2_d[g_detail_idx].inbc010,g_inbb2_d[g_detail_idx].inbc211,g_inbb2_d[g_detail_idx].inbc212, 
                  g_inbb2_d[g_detail_idx].inbc208,g_inbb2_d[g_detail_idx].inbc206,g_inbb2_d[g_detail_idx].inbc207, 
                  g_inbb2_d[g_detail_idx].inbc204,g_inbb2_d[g_detail_idx].inbc205,g_inbb2_d[g_detail_idx].inbc011, 
                  g_inbb2_d[g_detail_idx].inbc015,g_inbb2_d[g_detail_idx].inbc203,g_inbb2_d[g_detail_idx].inbc016, 
                  g_inbb2_d[g_detail_idx].inbc017,g_inbb2_d[g_detail_idx].inbcsite,g_inbb2_d[g_detail_idx].inbcunit)  
 
         WHERE inbcent = g_enterprise AND inbcdocno = ps_keys_bak[1] AND inbcseq = ps_keys_bak[2] AND inbcseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint911_inbc_t_mask_restore('restore_mask_n')
 
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
 
{<section id="aint911.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aint911_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aint911.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aint911_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aint911.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint911_lock_b(ps_table,ps_page)
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
   #CALL aint911_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "inbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint911_bcl USING g_enterprise,
                                       g_inba_m.inbadocno,g_inbb_d[g_detail_idx].inbbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint911_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "inbc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aint911_bcl2 USING g_enterprise,
                                             g_inba_m.inbadocno,g_inbb2_d[g_detail_idx].inbcseq,g_inbb2_d[g_detail_idx].inbcseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint911_bcl2:",SQLERRMESSAGE 
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
 
{<section id="aint911.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint911_unlock_b(ps_table,ps_page)
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
      CLOSE aint911_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aint911_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aint911.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint911_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("inbadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("inbadocno",TRUE)
      CALL cl_set_comp_entry("inbadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("inbadocdt,inbasite",TRUE)
   CALL cl_set_comp_entry("inba005,inba006",TRUE)              #150629-00016#1 150716 by lori add
   CALL cl_set_comp_entry("inba015",TRUE)                      #150826-00026#9 150831 by lori add
   #151113-00020#1 151117 By pomelo add(S)
   CALL cl_set_comp_entry("inba012",TRUE)    #領用類型
   CALL cl_set_comp_entry("inba203",TRUE)    #管理品類
   CALL cl_set_comp_entry("inba204",TRUE)    #供應商
   CALL cl_set_comp_entry("inba206",TRUE)    #轉入庫位
   CALL cl_set_comp_entry("inba207",TRUE)    #轉入管理品類
   CALL cl_set_comp_entry("inba208",TRUE)    #返回
   #151113-00020#1 151117 By pomelo add(E)
   CALL cl_set_comp_entry("inba012",TRUE)   #151111-00021#3 Add By Ken 151202
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint911.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint911_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("inbadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
 
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("inbadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("inbadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF (NOT s_aooi500_comp_entry(g_prog,g_site_str) OR g_ins_site_flag = 'Y') THEN
      CALL cl_set_comp_entry("inbasite",FALSE)
   END IF
   
   #150629-00016#1 150716 by lori add---(S)
   IF g_argv[1] = '1' THEN
      CALL cl_set_comp_entry("inba005,inba006",FALSE) 
   ELSE
      IF g_inba_m.inba005 = '1' THEN
         CALL cl_set_comp_entry("inba006",FALSE) 
      END IF
   END IF   
   #150629-00016#1 150716 by lori add---(E)  

   #150826-00026#9 150831 by lori add---(S)
   LET l_cnt = 0
   SELECT COUNT(inbbseq) INTO l_cnt
     FROM inbb_t
    WHERE inbbent = g_enterprise
      AND inbbdocno = g_inba_m.inbadocno
   IF l_cnt >= 1 THEN     
      CALL cl_set_comp_entry("inba015",FALSE)
      #151113-00020#1 151117 By pomelo add(S)
      CALL cl_set_comp_entry("inba203",FALSE)    #管理品類
      CALL cl_set_comp_entry("inba204",FALSE)    #供應商
      CALL cl_set_comp_entry("inba206",FALSE)    #轉入庫位
      CALL cl_set_comp_entry("inba207",FALSE)    #轉入管理品類
      CALL cl_set_comp_entry("inba208",FALSE)    #返回
      #151113-00020#1 151117 By pomelo add(E)
   END IF
   #150826-00026#9 150831 by lori add---(E)   
   
   #151113-00020#1 151117 By pomelo add(S)
   IF g_argv[1] MATCHES '[45]' THEN
      CALL cl_set_comp_entry("inba012",FALSE)    #領用類型
   END IF
   #151113-00020#1 151117 By pomelo add(E)
   
   #151113-00020#2 160111 By pomelo add(S)
   IF g_argv[1] MATCHES '[345679]' THEN
      CALL cl_set_comp_entry("inba005",FALSE)
   END IF
   #151113-00020#2 160111 By pomelo add(E)
   
   #151111-00021#3 Add By Ken 151202(S)
   IF g_inbb_d.getLength() > 0 THEN
      CALL cl_set_comp_entry("inba012",FALSE)
   END IF
   #151111-00021#3 Add By Ken 151202(E)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint911.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint911_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("inbb002,inbb003,inbb008,inbb009",TRUE)
   CALL cl_set_comp_entry("inbb202",TRUE)
   CALL cl_set_comp_entry("inbb022",TRUE)                   #150507-00001#8 150527 by lori add
   CALL cl_set_comp_entry("inbb007",TRUE)                   #150710-00012#1 150713 by benson 
   CALL cl_set_comp_entry("inbb017,inbb211,inbb212",TRUE)   #150629-00016#1 150716 by lori add 
   CALL cl_set_comp_entry("inbb205,inbb206",TRUE)           #150629-00016#1 150716 by lori add
   CALL cl_set_comp_entry("inbb210",TRUE)                   ##150814 by lori add
   #151113-00020#1 151117 By pomelo add(S)
   CALL cl_set_comp_entry("inbb219",TRUE)   #轉入包裝數量
   CALL cl_set_comp_entry("inbb220",TRUE)   #轉入庫位
   #151113-00020#1 151117 By pomelo add(E)
   CALL cl_set_comp_entry("inbb207",TRUE)                   #160728-00018#1 20160729 add by beckxie
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aint911.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint911_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaa005         LIKE imaa_t.imaa005   #特徵組
   DEFINE l_imaa006         LIKE imaa_t.imaa006   #基礎單位  
   DEFINE l_imaf055         LIKE imaf_t.imaf055   #庫存管理特徵
   DEFINE l_imaf061         LIKE imaf_t.imaf061   #庫存批號控管方式
   DEFINE l_imaf091         LIKE imaf_t.imaf091   #預設庫位
   DEFINE l_imaf092         LIKE imaf_t.imaf092   #預設儲位
   DEFINE l_inaa007         LIKE inaa_t.inaa007   #儲位管控方式
   DEFINE l_success         LIKE type_t.num5      #150427-00001#5 150514 by lori add
   DEFINE l_set_entry       LIKE type_t.num5      #150427-00001#5 150514 by lori add 
   DEFINE l_type            LIKE type_t.num5      #150427-00001#5 150514 by lori add 
   
   LET l_imaa005 = ''
   LET l_imaa006 = ''
   LET l_imaf055 = ''
   LET l_imaf061 = ''
   LET l_imaf091 = ''
   LET l_imaf092 = ''
   LET l_inaa007 = ''
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF l_ac > 0 THEN
      #儲位管控
      IF NOT cl_null(g_inbb_d[l_ac].inbb008) THEN
         
         LET l_inaa007 = s_aint911_get_store_info(g_inbb_d[l_ac].inbb007)
         IF l_inaa007 = '5' THEN
            CALL cl_set_comp_entry("inbb008",FALSE)
         END IF      
      END IF
         
      IF NOT cl_null(g_inbb_d[l_ac].inbb001) THEN
         CALL s_aint911_get_prod_info(g_inbb_d[l_ac].inbb001)
            RETURNING l_imaa005,l_imaa006,l_imaf055,l_imaf061,l_imaf091,l_imaf092 
         
         #產品特徵
         IF cl_null(l_imaa005) THEN
            CALL cl_set_comp_entry("inbb002",FALSE)
         END IF
         #庫存管理特徵
         IF l_imaf055 = '2' THEN   
            CALL cl_set_comp_entry("inbb003",FALSE)
         END IF
         
         #150427-00001#5 150514 by lori add---(S)   
         #批號
         LET l_success = ''  
         LET l_set_entry = ''
         
         #160512-00006#1 20160513 mark by beckxie---S
         #151113-00020#1 151119 By pomelo add(S)
         #IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
         #   LET l_type = '1'
         #ELSE
         #   LET l_type = '2'
         #END IF
         #IF l_type = '1' THEN
         ##151113-00020#1 151119 By pomelo add(E)
         ##IF g_argv[1] = '1' THEN      #151113-00020#1 151119 By pomelo mark
         #   LET l_type = -1
         #ELSE
         #   LET l_type = 1
         #END IF
         #160512-00006#1 20160513 mark by beckxie---E
         #160512-00006#1 20160513 add by beckxie---S
         #出/入庫 l_type:  1:入庫   -1:出庫
         CASE
            WHEN g_argv[1] MATCHES '[17]'
               LET l_type = -1
            WHEN (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') 
               LET l_type = -1
            OTHERWISE
               LET l_type = 1
         END CASE
         #160512-00006#1 20160513 add by beckxie---E
         CALL s_lot_out_entry(l_type,g_inba_m.inbadocno,g_inba_m.inbasite,g_inbb_d[l_ac].inbb001) 
            RETURNING l_success,l_set_entry
         IF l_success THEN
            CALL cl_set_comp_entry("inbb009",l_set_entry) 
         END IF
         #150427-00001#5 150514 by lori add---(E) 

         #150507-00001#8 150527 by lori add---(S)
         #有效日期
         LET l_success = ''  
         LET l_set_entry = ''
         
         IF g_inbb_d[l_ac].inbb009 IS NOT NULL THEN
            CALL s_lot_out_effdate_entry(g_inba_m.inbasite,g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,g_inbb_d[l_ac].inbb009)
               RETURNING l_success,l_set_entry
            IF l_success THEN
               CALL cl_set_comp_entry("inbb022",l_set_entry) 
            END IF 
         END IF            
         #150507-00001#8 150527 by lori add---(E)         
      END IF
   
      #有申請數量時，不可維護包裝數量
      IF g_inbb_d[l_ac].inbb011 > 0 THEN
         CALL cl_set_comp_entry("inbb202",FALSE)
      END IF

      #150629-00016#1 150716 by lori add---(S)
      #來源單據項次/項序
      IF g_argv[1] = '1' THEN
         CALL cl_set_comp_entry("inbb017,inbb211,inbb212",FALSE)    
      ELSE
         IF g_inba_m.inba005 = '1' THEN
            CALL cl_set_comp_entry("inbb017,inbb211,inbb212",FALSE)    
         ELSE
            IF NOT cl_null(g_inba_m.inba006) THEN
               CALL cl_set_comp_entry("inbb017",FALSE)   
            END IF
         END IF
      END IF
      #150629-00016#1 150716 by lori add---(E)
      
      #151113-00020#1 151117 By pomelo add(S)
      IF g_argv[1] = '7' THEN
         #轉入儲位管控
         IF NOT cl_null(g_inbb_d[l_ac].inbb220) THEN
            LET l_inaa007 = ''
            LET l_inaa007 = s_aint911_get_store_info(g_inbb_d[l_ac].inbb220)
            IF l_inaa007 = '5' THEN
               CALL cl_set_comp_entry("inbb221",FALSE)
            END IF      
         END IF
         
         IF NOT cl_null(g_inbb_d[l_ac].inbb214) THEN
            CALL s_aint911_get_prod_info(g_inbb_d[l_ac].inbb214)
               RETURNING l_imaa005,l_imaa006,l_imaf055,l_imaf061,l_imaf091,l_imaf092 
            
            #轉入產品特徵
            IF cl_null(l_imaa005) THEN
               CALL cl_set_comp_entry("inbb215",FALSE)
            END IF
            
            #轉入批號
            LET l_success = ''  
            LET l_set_entry = ''
            
            CALL s_lot_out_entry('1',g_inba_m.inbadocno,g_inba_m.inbasite,g_inbb_d[l_ac].inbb214) 
               RETURNING l_success,l_set_entry
            IF l_success THEN
               CALL cl_set_comp_entry("inbb222",l_set_entry) 
            END IF  
         END IF
         
         #轉入包裝數量
         IF NOT cl_null(g_inbb_d[l_ac].inbb217) THEN
            CALL cl_set_comp_entry("inbb219",FALSE)
         END IF
      END IF
      #151113-00020#1 151117 By pomelo add(E)
    END IF
    
   #150710-00012#1 150713 by benson --- S
   IF NOT cl_null(g_inba_m.inba015) THEN
      CALL cl_set_comp_entry("inbb007",FALSE) 
   END IF      
   #150710-00012#1 150713 by benson --- E

   #150629-00016#1 150716 by lori add---(S)
   IF g_inba_m.inba012 = '3' THEN
      CALL cl_set_comp_entry("inbb205,inbb206",FALSE)  
   END IF      
   #150629-00016#1 150716 by lori add---(E)
   
   ##150814 by lori add---(S)
   #成本單價,進價
   #IF g_argv[1] MATCHES "[1]" THEN   #151113-00020#1 151117 By pomelo mark
   IF g_argv[1] MATCHES "[135678]" THEN      #151113-00020#1 151117 By pomelo add
      CALL cl_set_comp_entry("inbb210",FALSE)
   END IF
   ##150814 by lori add---(E)
   
   #151113-00020#1 151117 By pomelo add(S)
   #轉入庫位
   IF NOT cl_null(g_inba_m.inba206) THEN
      CALL cl_set_comp_entry("inbb220",FALSE)
   END IF
   #151113-00020#1 151117 By pomelo add(E)
   
   #160728-00018#1 20160729 add by beckxie---S
   #aint919供應商雜收成本單價開放可修改
   IF g_argv[1] !='9' THEN
      CALL cl_set_comp_entry("inbb207",FALSE)
   END IF
   #160728-00018#1 20160729 add by beckxie---E
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aint911.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint911_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("signing,withdraw",TRUE)
   CALL cl_set_act_visible("unconfirmed,posted,unposted,invalid,confirmed",TRUE)
   CALL cl_set_toolbaritem_visible("open_aint911_01,open_aint911_01_1",TRUE)
   CALL cl_set_act_visible("gen_astt322,gen_expense",TRUE)   #150629-00016#1  150716 by lori add
   #160324-00013#2 20160429 add by beckxie---S
   CALL cl_set_act_visible("open_aint911_01_1",TRUE)
   #160324-00013#2 20160429 add by beckxie---E
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint911.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint911_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_type       LIKE type_t.chr10    #151113-00020#1 151119 By pomelo add
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_inba_m.inbastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   CASE g_inba_m.inbastus
      WHEN "N"
         CALL cl_set_act_visible("unconfirmed,posted,unposted",FALSE)
         IF cl_bpm_chk() THEN   #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("confirmed,posted,unposted",FALSE)
         END IF
      WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
         CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted",FALSE) 
         IF cl_bpm_chk() THEN   #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted",FALSE)
         END IF         
      WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
         CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted",FALSE)
         IF cl_bpm_chk() THEN   #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted",FALSE)
         END IF         
      WHEN "S"
         CALL cl_set_act_visible("unconfirmed,posted,invalid,confirmed",FALSE)
         IF cl_bpm_chk() THEN   #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("confirmed,unconfirmed,posted",FALSE)
         END IF
      WHEN "X"
         CALL cl_set_act_visible("unconfirmed,posted,invalid,confirmed,unposted",FALSE)
      WHEN "Y"
         CALL cl_set_act_visible("invalid,confirmed,unposted",FALSE)
         #160324-00013#2 20160429 add by beckxie---S
         IF g_argv[1] = '1' THEN
            CALL cl_set_act_visible("open_aint911_01_1",FALSE)
         END IF
         #160324-00013#2 20160429 add by beckxie---E
      WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
         CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted,unposted",FALSE)      
      WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
          CALL cl_set_act_visible("unconfirmed,invalid,posted,unposted",FALSE)
   END CASE

   IF NOT cl_bpm_chk() THEN   #不需提交至BPM時
      CALL cl_set_act_visible("signing,withdraw",FALSE)
   END IF
   
   #151113-00020#1 151119 By pomelo add(S)
   IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
      LET l_type = '1'
   ELSE
      LET l_type = '2'
   END IF
   CASE l_type
   #151113-00020#1 151119 By pomelo add(E)
   #CASE g_argv[1]    #151113-00020#1 151119 By pomelo mark
      WHEN '1'
         CALL cl_set_toolbaritem_visible("open_aint911_01_1",FALSE)
      WHEN '2'   
         CALL cl_set_toolbaritem_visible("open_aint911_01",FALSE)
   END CASE
   
   #150415-00006#1 150506 by lori add---(S)
   IF g_inba_m.inba005 = '9' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)              
   END IF            
   #150415-00006#1 150506 by lori add---(E)

   #150629-00016#1  150716 by lori add---(S)
   IF g_inba_m.inbastus <> 'S' THEN
      CALL cl_set_act_visible("gen_astt322,gen_expense",FALSE)  
   ELSE
      IF g_inba_m.inba014 = 'Y' THEN
         CALL cl_set_act_visible("gen_expense",FALSE) 
      ELSE
         CALL cl_set_act_visible("gen_astt322",FALSE)  
         IF g_inba_m.inba012 = '3' THEN
            CALL cl_set_act_visible("gen_expense",FALSE)  
         END IF
      END IF
   END IF   
   #150629-00016#1  150716 by lori add---(E)
   
   #151113-00020#1 151119 By pomelo add(S)
   IF g_argv[1] MATCHES '[3456789]' THEN
      CALL cl_set_act_visible("gen_astt322",TRUE)
      CALL cl_set_act_visible("gen_expense",TRUE)
   END IF
   IF g_argv[1] = '8' THEN
      CALL cl_set_act_visible("insert",FALSE)               #新增
      CALL cl_set_act_visible("modify",FALSE)               #修改
      CALL cl_set_act_visible("delete",FALSE)               #刪除
      CALL cl_set_act_visible("modify_detail",FALSE)        #修改單身
      CALL cl_set_act_visible("reproduce",FALSE)            #複製  
      CALL cl_set_act_visible("statechange",FALSE)          #狀態
      CALL cl_set_toolbaritem_visible("open_aint911_01",FALSE)
      CALL cl_set_toolbaritem_visible("open_aint911_01_1",FALSE)
      CALL cl_set_toolbaritem_visible("open_memo",FALSE)
      CALL cl_set_toolbaritem_visible("open_detail_memo",FALSE)
   END IF
   
   IF g_argv[1] = '7' THEN
      CALL cl_set_toolbaritem_visible("open_aint911_01",FALSE)
      CALL cl_set_toolbaritem_visible("open_aint911_01_1",FALSE)
   END IF
   #151113-00020#1 151119 By pomelo add(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint911.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aint911_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint911.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aint911_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint911.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint911_default_search()
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
      LET ls_wc = ls_wc, " inbadocno = '", g_argv[02], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #LET ls_wc = ls_wc, " inba001 = '",g_argv[01],"' AND "   #150827-00013#1 by lori mark
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
               WHEN la_wc[li_idx].tableid = "inba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "inbb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "inbc_t" 
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
   #150827-00013#1 150827 by lori add---(S)
   IF NOT g_wc.getIndexOf(" 1=2", 1) THEN
      LET ls_wc = ls_wc, " inba001 = '",g_argv[01],"' "
   END IF
   #150827-00013#1 150827 by lori add---(E)
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint911.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint911_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_expense_flag   LIKE type_t.chr1        #150629-00016#1 150716 by lori add
   DEFINE l_cnt            LIKE type_t.num5        #150629-00016#1 150716 by lori add
   DEFINE l_doc            LIKE stba_t.stbadocno   #150629-00016#1  150716 by lori add
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_inba_m.inbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aint911_cl USING g_enterprise,g_inba_m.inbadocno
   IF STATUS THEN
      CLOSE aint911_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint911_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint911_master_referesh USING g_inba_m.inbadocno INTO g_inba_m.inba001,g_inba_m.inbasite, 
       g_inba_m.inbadocdt,g_inba_m.inbadocno,g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003, 
       g_inba_m.inba004,g_inba_m.inba013,g_inba_m.inbaunit,g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006, 
       g_inba_m.inba015,g_inba_m.inba203,g_inba_m.inba205,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba207, 
       g_inba_m.inba204,g_inba_m.inba007,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaowndp,g_inba_m.inbacrtid, 
       g_inba_m.inbacrtdp,g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
       g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstdt,g_inba_m.inba003_desc,g_inba_m.inba004_desc, 
       g_inba_m.inba015_desc,g_inba_m.inba203_desc,g_inba_m.inba205_desc,g_inba_m.inba206_desc,g_inba_m.inba207_desc, 
       g_inba_m.inba204_desc,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid_desc, 
       g_inba_m.inbacrtdp_desc,g_inba_m.inbamodid_desc,g_inba_m.inbacnfid_desc,g_inba_m.inbapstid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aint911_action_chk() THEN
      CLOSE aint911_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inba_m.inba001,g_inba_m.inbasite,g_inba_m.inbasite_desc,g_inba_m.inbadocdt,g_inba_m.inbadocno, 
       g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003,g_inba_m.inba003_desc,g_inba_m.inba004, 
       g_inba_m.inba004_desc,g_inba_m.inba013,g_inba_m.inba013_desc,g_inba_m.inbaunit,g_inba_m.inbastus, 
       g_inba_m.inba005,g_inba_m.inba006,g_inba_m.inba015,g_inba_m.inba015_desc,g_inba_m.inba203,g_inba_m.inba203_desc, 
       g_inba_m.inba205,g_inba_m.inba205_desc,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba206_desc, 
       g_inba_m.inba207,g_inba_m.inba207_desc,g_inba_m.inba204,g_inba_m.inba204_desc,g_inba_m.inba007, 
       g_inba_m.inba007_desc,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp, 
       g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid,g_inba_m.inbacrtid_desc,g_inba_m.inbacrtdp,g_inba_m.inbacrtdp_desc, 
       g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamodid_desc,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
       g_inba_m.inbacnfid_desc,g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstid_desc,g_inba_m.inbapstdt 
 
 
   CASE g_inba_m.inbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
         CASE g_inba_m.inbastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "S"
               HIDE OPTION "posted"
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
            WHEN "Z"
               HIDE OPTION "unposted"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL aint911_set_act_visible()
      CALL aint911_set_act_no_visible()
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aint911_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint911_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aint911_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint911_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #150415-00006#1 150506 by lori add---(S)
            IF g_inba_m.inba005 = '9' THEN
               #資料來源為「9.商品組合拆解單」，不可異動！
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inba_m.inbadocno
               LET g_errparam.code   = 'ain-00550'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()     
               CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
               RETURN               
            END IF            
            #150415-00006#1 150506 by lori add---(E)
            
            CALL s_transaction_begin()
            IF NOT cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL cl_err_collect_init() 
               IF NOT s_aint911_unconf(g_inba_m.inbadocno) THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
                  CALL aint911_b_fill()
               END IF
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            #150415-00006#1 150506 by lori add---(S)
            IF g_inba_m.inba005 = '9' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inba_m.inbadocno
               LET g_errparam.code   = 'ain-00550'
               LET g_errparam.popup  = TRUE 
               CALL cl_err() 
               CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
               RETURN               
            END IF            
            #150415-00006#1 150506 by lori add---(E)             
            CALL s_transaction_begin()
            IF NOT cl_ask_confirm('sub-00232') THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               IF aint911_post_input() THEN
                  CALL cl_err_collect_init() 
                  IF NOT s_aint911_posted(g_inba_m.inbadocno) THEN
                     CALL cl_err_collect_show()
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                     CALL cl_err_collect_show()
                  END IF
               ELSE
                  CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
                  RETURN
               END IF
            END IF
            #150629-00016#1  150716 by lori add---(S)
            IF g_inba_m.inba014 = 'Y' THEN
               IF cl_ask_confirm('ain-00621') THEN
                  LET l_expense_flag = 'Y'
               END IF   
            ELSE
               IF g_inba_m.inba012 <> '3' THEN
                 IF cl_ask_confirm('ain-00620') THEN
                    LET l_expense_flag = 'Y'
                 END IF
               END IF
            END IF
            
            IF l_expense_flag = 'Y' THEN
               CALL s_transaction_begin()
               CALL cl_err_collect_init() 
               IF s_expense_aint911(g_inba_m.inbadocno) THEN
                  #150827-00013#1 150827 by lori add---(S)
                  LET l_doc = ''
                  SELECT stbadocno INTO l_doc 
                    FROM stba_t 
                   WHERE stbaent = g_enterprise
                     AND stba007 = g_inba_m.inbadocno 
                     
                  INITIALIZE g_errparam TO NULL
                  
                  IF g_inba_m.inba014 = 'Y' THEN
                     #已產生交款單%1                 
                     LET g_errparam.code   = "ast-00434"
                  ELSE   
                     CASE g_inba_m.inba012 
                        WHEN '1' 
                           #已產生專櫃費用單%1
                           LET g_errparam.code   = "ast-00432"
                        WHEN '2'
                           #已產生供應商費用單％1
                           LET g_errparam.code   = "ast-00433"                        
                     END CASE   
                  END IF
                  
                  LET g_errparam.replace[1] = l_doc
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  #150827-00013#1 150827 by lori add---(E)                
                  CALL s_transaction_end('Y','0')
               ELSE
                  #151104-00002#2 151127 by lori add---(S)
                  INITIALIZE g_errparam TO NULL
                  
                  IF g_inba_m.inba014 = 'Y' THEN
                     #雜項領用/退回單(%1)產生交款單失敗！                
                     LET g_errparam.replace[1] = g_inba_m.inbadocno
                     LET g_errparam.code   = "ast-00513"
                  ELSE   
                     LET g_errparam.replace[1] = g_inba_m.inba013
                     LET g_errparam.replace[2] = g_inba_m.inbadocno
                     
                     CASE g_inba_m.inba012 
                        WHEN '1' 
                           #專櫃(%1)領用/退回單(%2)產生費用單失敗！
                           LET g_errparam.code   = "ast-00512"
                        WHEN '2'
                           #供應商(%1)領用/退回單(%2)產生費用單失敗！
                           LET g_errparam.code   = "ast-00511"                        
                     END CASE   
                  END IF
                  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()      
                  #151104-00002#2 151127 by lori add---(E)
                  
                  CALL s_transaction_end('N','0')                  
               END IF
               CALL cl_err_collect_show()
            END IF
            #150629-00016#1  150716 by lori add---(E)
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #150415-00006#1 150506 by lori add---(S)
            IF g_inba_m.inba005 = '9' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inba_m.inbadocno
               LET g_errparam.code   = 'ain-00550'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()  
               CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
               RETURN               
            END IF            
            #150415-00006#1 150506 by lori add---(E)
            
            #150820-000081 150820 by lori add---(S)
            CALL s_transaction_begin()
            IF NOT aint911_before_conf_chk() THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF    
            CALL s_transaction_end('Y','0')            
            #150820-000081 150820 by lori add---(E)
            
            CALL s_transaction_begin()
            IF NOT cl_ask_confirm('aim-00108') THEN               
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL cl_err_collect_init() 
               IF NOT s_aint911_conf(g_inba_m.inbadocno) THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
                  CALL aint911_b_fill()
               END IF               
            END IF   
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
      ON ACTION unposted
         IF cl_auth_chk_act("unposted") THEN
            LET lc_state = "Z"
            #add-point:action控制 name="statechange.unposted"
            LET lc_state = "Y"
            #150415-00006#1 150506 by lori add---(S)
            IF g_inba_m.inba005 = '9' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inba_m.inbadocno
               LET g_errparam.code   = 'ain-00550'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()     
               CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
               RETURN               
            END IF            
            #150415-00006#1 150506 by lori add---(E) 
            
            #150629-00016#1 150716 by lori---(S)
            LET l_cnt = 0 
            SELECT COUNT(*) INTO l_cnt
              FROM stba_t 
             WHERE stbaent = g_enterprise
               AND stba007 = g_inba_m.inbadocno
               AND stbastus <> 'X'
            IF l_cnt > 0 THEN
               #已有產生費用單或交款單﹐不可扣帳還原！
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inba_m.inbadocno
               LET g_errparam.code   = 'ain-00624'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()     
               CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
               RETURN                  
            END IF            
            #150629-00016#1 150716 by lori---(E)
            
            CALL s_transaction_begin()
            IF NOT cl_ask_confirm('sub-00233') THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL cl_err_collect_init() 
               IF NOT s_aint911_unposted(g_inba_m.inbadocno) THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
               END IF
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            #150415-00006#1 150506 by lori add---(S)
            IF g_inba_m.inba005 = '9' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inba_m.inbadocno
               LET g_errparam.code   = 'ain-00550'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
               RETURN               
            END IF            
            #150415-00006#1 150506 by lori add---(E)             
            CALL s_transaction_begin()
            IF NOT cl_ask_confirm('aim-00109') THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL cl_err_collect_init() 
               IF NOT s_aint911_invalid(g_inba_m.inbadocno) THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
               END IF
            END IF
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
 
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "S"
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "Z"
      AND lc_state <> "X"
      ) OR 
      g_inba_m.inbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aint911_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_inba_m.inbamodid = g_user
   LET g_inba_m.inbamoddt = cl_get_current()
   LET g_inba_m.inbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE inba_t 
      SET (inbastus,inbamodid,inbamoddt) 
        = (g_inba_m.inbastus,g_inba_m.inbamodid,g_inba_m.inbamoddt)     
    WHERE inbaent = g_enterprise AND inbadocno = g_inba_m.inbadocno
 
    
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aint911_master_referesh USING g_inba_m.inbadocno INTO g_inba_m.inba001,g_inba_m.inbasite, 
          g_inba_m.inbadocdt,g_inba_m.inbadocno,g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003, 
          g_inba_m.inba004,g_inba_m.inba013,g_inba_m.inbaunit,g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006, 
          g_inba_m.inba015,g_inba_m.inba203,g_inba_m.inba205,g_inba_m.inba208,g_inba_m.inba206,g_inba_m.inba207, 
          g_inba_m.inba204,g_inba_m.inba007,g_inba_m.inba008,g_inba_m.inbaownid,g_inba_m.inbaowndp,g_inba_m.inbacrtid, 
          g_inba_m.inbacrtdp,g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamoddt,g_inba_m.inbacnfid, 
          g_inba_m.inbacnfdt,g_inba_m.inbapstid,g_inba_m.inbapstdt,g_inba_m.inba003_desc,g_inba_m.inba004_desc, 
          g_inba_m.inba015_desc,g_inba_m.inba203_desc,g_inba_m.inba205_desc,g_inba_m.inba206_desc,g_inba_m.inba207_desc, 
          g_inba_m.inba204_desc,g_inba_m.inbaownid_desc,g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid_desc, 
          g_inba_m.inbacrtdp_desc,g_inba_m.inbamodid_desc,g_inba_m.inbacnfid_desc,g_inba_m.inbapstid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_inba_m.inba001,g_inba_m.inbasite,g_inba_m.inbasite_desc,g_inba_m.inbadocdt,g_inba_m.inbadocno, 
          g_inba_m.inba002,g_inba_m.inba012,g_inba_m.inba014,g_inba_m.inba003,g_inba_m.inba003_desc, 
          g_inba_m.inba004,g_inba_m.inba004_desc,g_inba_m.inba013,g_inba_m.inba013_desc,g_inba_m.inbaunit, 
          g_inba_m.inbastus,g_inba_m.inba005,g_inba_m.inba006,g_inba_m.inba015,g_inba_m.inba015_desc, 
          g_inba_m.inba203,g_inba_m.inba203_desc,g_inba_m.inba205,g_inba_m.inba205_desc,g_inba_m.inba208, 
          g_inba_m.inba206,g_inba_m.inba206_desc,g_inba_m.inba207,g_inba_m.inba207_desc,g_inba_m.inba204, 
          g_inba_m.inba204_desc,g_inba_m.inba007,g_inba_m.inba007_desc,g_inba_m.inba008,g_inba_m.inbaownid, 
          g_inba_m.inbaownid_desc,g_inba_m.inbaowndp,g_inba_m.inbaowndp_desc,g_inba_m.inbacrtid,g_inba_m.inbacrtid_desc, 
          g_inba_m.inbacrtdp,g_inba_m.inbacrtdp_desc,g_inba_m.inbacrtdt,g_inba_m.inbamodid,g_inba_m.inbamodid_desc, 
          g_inba_m.inbamoddt,g_inba_m.inbacnfid,g_inba_m.inbacnfid_desc,g_inba_m.inbacnfdt,g_inba_m.inbapstid, 
          g_inba_m.inbapstid_desc,g_inba_m.inbapstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   CALL aint911_b_fill()    #151113-00020#1 151119 By pomelo add
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aint911_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint911_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint911.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aint911_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_inbb_d.getLength() THEN
         LET g_detail_idx = g_inbb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_inbb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_inbb2_d.getLength() THEN
         LET g_detail_idx = g_inbb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inbb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_inbb2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint911.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aint911_b_fill2(pi_idx)
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
   
   CALL aint911_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aint911.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aint911_fill_chk(ps_idx)
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
 
{<section id="aint911.status_show" >}
PRIVATE FUNCTION aint911_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint911.mask_functions" >}
&include "erp/ain/aint911_mask.4gl"
 
{</section>}
 
{<section id="aint911.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aint911_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success    LIKE type_t.num5   #xianghui  150427  add
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL aint911_show()
   CALL aint911_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #xianghui  150427  add---(S)
   LET l_success = ''
   CALL s_aint911_conf_chk(g_inba_m.inbadocno) RETURNING l_success
   IF NOT l_success THEN
      RETURN l_success
   END IF
   #xianghui  150427  add---(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_inba_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_inbb_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_inbb2_d))
 
 
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
   #CALL aint911_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aint911_ui_headershow()
   CALL aint911_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aint911_draw_out()
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
   CALL aint911_ui_headershow()  
   CALL aint911_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aint911.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint911_set_pk_array()
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
   LET g_pk_array[1].values = g_inba_m.inbadocno
   LET g_pk_array[1].column = 'inbadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint911.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aint911.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint911_msgcentre_notify(lc_state)
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
   CALL aint911_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_inba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint911.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint911_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#18-s
   SELECT inbastus INTO g_inba_m.inbastus FROM inba_t
    WHERE inbaent = g_enterprise
      AND inbasite = g_site
      AND inbadocno = g_inba_m.inbadocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
      LET g_errno = NULL
      CASE g_inba_m.inbastus
         WHEN 'W'
            LET g_errno = 'sub-01347'
         WHEN 'X'
            LET g_errno = 'sub-00229'
         WHEN 'Y'
            LET g_errno = 'sub-00178'
         WHEN 'S'
            LET g_errno = 'sub-00230'
         WHEN 'Z'    #扣帳還原
            LET g_errno = 'sub-00231'           
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_inba_m.inbadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aint911_set_act_visible()
        CALL aint911_set_act_no_visible()
        CALL aint911_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#18-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint911.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 設定單頭必填欄位控制
# Memo...........:
# Usage..........: CALL aint911_set_required()
# Date & Author..: 2015/07/16 By Lori   #150629-00016#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_set_required()
   IF g_argv[1] = '2' AND g_inba_m.inba005 = '11' THEN
      CALL cl_set_comp_required("inba006",TRUE)
   END IF
   
   CASE g_inba_m.inba012
      WHEN '1'   #供應商領用
         CALL cl_set_comp_required("inba013",TRUE)
      WHEN '2'   #專櫃領用
         CALL cl_set_comp_required("inba013",TRUE)
      WHEN '3'   #內部員工領用
         CALL cl_set_comp_required("inba003,inba004",TRUE)
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 設定單頭非必填欄位控制
# Memo...........:
# Usage..........: CALL aint911_set_no_required()
# Date & Author..: 2015/07/16 By Lori   #150629-00016#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_set_no_required()
   CALL cl_set_comp_required("inba006",FALSE)
   CALL cl_set_comp_required("inba003,inba004,inba013",FALSE)   
END FUNCTION

################################################################################
# Descriptions...: 商品設定必填欄位控制
# Memo...........:
# Usage..........: CALL aint911_set_required_b()
# Date & Author..: 2015/02/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_set_required_b()
   DEFINE l_imaa005         LIKE imaa_t.imaa005   #特徵組
   DEFINE l_imaa006         LIKE imaa_t.imaa006   #基礎單位  
   DEFINE l_imaf055         LIKE imaf_t.imaf055   #庫存管理特徵
   DEFINE l_imaf061         LIKE imaf_t.imaf061   #庫存批號控管方式
   DEFINE l_imaf091         LIKE imaf_t.imaf091   #預設庫位
   DEFINE l_imaf092         LIKE imaf_t.imaf092   #預設儲位
   DEFINE l_success         LIKE type_t.num5      #150427-00001#5 150514 by lori add
   DEFINE l_set_required    LIKE type_t.num5      #150427-00001#5 150514 by lori add
   DEFINE l_type            LIKE type_t.chr10     #151113-00020#1 151119 By pomelo add
   
   #150427-00001#5 150514 by lori add---(S)
   IF l_ac > 0 THEN
      LET l_imaa005 = ''
      LET l_imaa006 = ''
      LET l_imaf055 = ''
      LET l_imaf061 = ''
      LET l_imaf091 = ''
      LET l_imaf092 = ''
   
      IF NOT cl_null(g_inbb_d[l_ac].inbb001) THEN
         CALL s_aint911_get_prod_info(g_inbb_d[l_ac].inbb001)
            RETURNING l_imaa005,l_imaa006,l_imaf055,l_imaf061,l_imaf091,l_imaf092 
         
         IF NOT cl_null(l_imaa005) THEN
            CALL cl_set_comp_required("inbb002",TRUE)
         END IF
         
         #IF cl_null(l_imaf056) = 'N' THEN
         #   CALL cl_set_comp_required("inbb003",TRUE)
         #END IF 
         
         #150427-00001#5 150514 by lori add---(S)
         #批號
         LET l_success = ''     
         LET l_set_required = '' 
         
         CALL s_lot_out_required(g_inbb_d[l_ac].inbb001) RETURNING l_success,l_set_required
         IF l_success THEN
            CALL cl_set_comp_required("inbb009",l_set_required)
         END IF         
         #150427-00001#5 150514 by lori add---(E)
         
         #150507-00001#8 150527 by lori add---(S)
         #製造日期,有效日期
         #151113-00020#1 151119 By pomelo add(S)
         IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
            LET l_type = '1'
         ELSE
            LET l_type = '2'
         END IF
         IF l_type = '2' THEN
         #151113-00020#1 151119 By pomelo add(E)
         #IF g_argv[1] = '2' THEN   #151113-00020#1 151119 By pomelo mark
            LET l_success = ''
            LET l_set_required = ''
            CALL cl_set_comp_required("inbb204",TRUE)
            
            IF NOT cl_null(g_inbb_d[l_ac].inbb009) THEN
               CALL s_lot_out_effdate_required(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb009) RETURNING l_success,l_set_required
               IF l_success THEN
                  CALL cl_set_comp_required("inbb022",l_set_required)
               END IF
            END IF               
         END IF
         #150507-00001#8 150527 by lori add---(E)        
      END IF
   END IF
   #150427-00001#5 150514 by lori add---(E)
   
   #150629-00016#1 150716 by lori---(S)
   IF g_argv[1] = '2' AND g_inba_m.inba005 = '11' THEN
      CALL cl_set_comp_required("inbb211,inbb212",TRUE)
   END IF
   #150629-00016#1 150716 by lori---(E)
   
   #150827-00013#1 150827 by lori---(S)
   IF g_inba_m.inba012 MATCHES "[12]" THEN
      CALL cl_set_comp_required("inbb209",TRUE)
   END IF
   #150827-00013#1 150827 by lori---(E)
   
END FUNCTION

################################################################################
# Descriptions...: 商品設定必填欄位控制
# Memo...........:
# Usage..........: CALL aint911_set_no_required_b()
# Date & Author..: 2015/02/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_set_no_required_b()
   CALL cl_set_comp_required("inbb002",FALSE)
   #CALL cl_set_comp_required("inbb003",FALSE)
   CALL cl_set_comp_required("inbb009",FALSE)
   CALL cl_set_comp_required("inbb204,inbb022",FALSE)       #150507-00001#8 150527 by lori add  
   CALL cl_set_comp_required("inbb211,inbb212",FALSE)       #150629-00016#1 150716 by lori add
   CALL cl_set_comp_required("inbb209",FALSE)               #150827-00013#1 150827 by lori add 
END FUNCTION

################################################################################
# Descriptions...: 商品編號相關資料預設值
# Memo...........:
# Usage..........: CALL aint911_inbb001_default(p_inbb001)
# Date & Author..: 2015/2/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb001_default(p_inbb001)
   DEFINE p_inbb001   LIKE inbb_t.inbb001
   DEFINE l_imaa005   LIKE imaa_t.imaa005   #特徵組
   DEFINE l_imaa006   LIKE imaa_t.imaa006   #基礎單位  
   DEFINE l_imaf055   LIKE imaf_t.imaf055   #庫存管理特徵
   DEFINE l_imaf061   LIKE imaf_t.imaf061   #庫存批號控管方式
   DEFINE l_imaf091   LIKE imaf_t.imaf091   #預設庫位
   DEFINE l_imaf092   LIKE imaf_t.imaf092   #預設儲位
   DEFINE l_success   LIKE type_t.num5      #151111-00021#3 Add By Ken 151201
   
   LET l_imaa005 = ''
   LET l_imaa006 = ''
   LET l_imaf055 = ''
   LET l_imaf061 = ''
   LET l_imaf091 = ''
   LET l_imaf092 = ''   
   
   IF NOT cl_null(p_inbb001) THEN
      IF cl_null(g_inbb_d[l_ac].inbb200) THEN
         SELECT imaa014 INTO g_inbb_d[l_ac].inbb200
           FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = p_inbb001
      END IF
      
      CALL s_aint911_get_prod_info(p_inbb001)
         RETURNING l_imaa005,l_imaa006,l_imaf055,l_imaf061,l_imaf091,l_imaf092 
      #庫存管理特徵
      #LET g_inbb_d[l_ac].inbb003 = l_imaf055     150324-00007#1 20150413 By pmoelo mark
      #單位
      LET g_inbb_d[l_ac].inbb010 = l_imaa006
      LET g_inbb_d[l_ac].inbb010_desc = s_desc_get_unit_desc(g_inbb_d[l_ac].inbb010)
     
      #150710-00012#1 150713 By benson --- S
      #增加判斷 如果單頭有值時,則用單頭庫位帶值
      IF NOT cl_null(g_inba_m.inba015) THEN         
         LET g_inbb_d[l_ac].inbb007 = g_inba_m.inba015   #庫位        
         LET g_inbb_d[l_ac].inbb008 = ''                 #儲位
      ELSE                 
         LET g_inbb_d[l_ac].inbb007 = l_imaf091          #庫位         
         LET g_inbb_d[l_ac].inbb008 = l_imaf092          #儲位
      END IF
      #150710-00012#1 150713 By benson --- E
      LET g_inbb_d[l_ac].inbb007_desc = s_desc_get_stock_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007)
      LET g_inbb_d[l_ac].inbb008_desc = s_desc_get_locator_desc(g_inba_m.inbasite,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008)
      
      #包裝單位
      CALL aint911_inbb201_default()
      
      #151111-00021#3 Add By Ken 151201(S)
      #計價單位
      CALL s_aint911_get_inbb224('ALL',g_inba_m.inba012,g_inbb_d[l_ac].inbb001)  #160120-00001#1 Add By Ken 160120
         RETURNING l_success,g_inbb_d[l_ac].inbb224
      IF l_success THEN
         LET g_inbb_d[l_ac].inbb224_desc = s_desc_get_unit_desc(g_inbb_d[l_ac].inbb224)
      END IF
      #151111-00021#3 Add By Ken 151201(E)
   
      LET g_inbb_d_o.inbb003 = g_inbb_d[l_ac].inbb003 
      LET g_inbb_d_o.inbb010 = g_inbb_d[l_ac].inbb010 
      LET g_inbb_d_o.inbb007 = g_inbb_d[l_ac].inbb007 
      LET g_inbb_d_o.inbb008 = g_inbb_d[l_ac].inbb008        
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 包裝單位與包裝數量
# Memo...........:
# Usage..........: CALL aint911_inbb201_default()
# Date & Author..: 2015/02/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb201_default()
   DEFINE l_inbb200   LIKE inbb_t.inbb200
   #150915-00010#1 150915 By pomelo add(S)
   DEFINE l_rtdx034   LIKE rtdx_t.rtdx034
   DEFINE l_success   LIKE type_t.num5
   #150915-00010#1 150915 By pomelo add(E)
   #160728-00018#1 20160728 add by beckxie---S
   DEFINE l_price     LIKE stas_t.stas010   #進價
   DEFINE l_stas020   LIKE stas_t.stas020   #稅別
   DEFINE l_ooef016   LIKE ooef_t.ooef016   #幣別
   DEFINE l_xcaz010   LIKE xcaz_t.xcaz010   #成本含稅否
   DEFINE l_xrcd103   LIKE xrcd_t.xrcd103   #未稅價
   DEFINE l_nouse_1   LIKE xrcd_t.xrcd104
   DEFINE l_nouse_2   LIKE xrcd_t.xrcd105
   DEFINE l_nouse_3   LIKE xrcd_t.xrcd113
   DEFINE l_nouse_4   LIKE xrcd_t.xrcd114
   DEFINE l_nouse_5   LIKE xrcd_t.xrcd115
   #160728-00018#1 20160728 add by beckxie---E
   
   LET l_inbb200 = ''
   IF NOT cl_null(g_inbb_d[l_ac].inbb001) THEN
      CALL s_apmt840_get_rtdx(g_inba_m.inbasite,g_inbb_d[l_ac].inbb001)
         RETURNING l_inbb200,g_inbb_d[l_ac].inbb201 
      
      IF cl_null(g_inbb_d[l_ac].inbb200) THEN
         LET g_inbb_d[l_ac].inbb200 = l_inbb200
      END IF   

      LET g_inbb_d[l_ac].inbb201_desc = s_desc_get_unit_desc(g_inbb_d[l_ac].inbb201)
      
      LET g_inbb_d_o.inbb200 = g_inbb_d[l_ac].inbb200
      LET g_inbb_d_o.inbb201 = g_inbb_d[l_ac].inbb201 
      
      #150915-00010#1 150915 By pomelo mark(S)
      ##150710-00012#1 150713 by benson --- S
      #SELECT rtdx034 INTO g_inbb_d[l_ac].inbb210 
      #  FROM rtdx_t
      # WHERE rtdxent = g_enterprise
      #   AND rtdxsite = g_inba_m.inbasite
      #   AND rtdx001 = g_inbb_d[l_ac].inbb001      
      ##150710-00012#1 150713 by benson --- E
      #150915-00010#1 150915 By pomelo mark(E)
      
      #150915-00010#1 150915 By pomelo add(S)
      #160728-00018#1 20160728 add by beckxie---S
      #若為aint919,取協議中的進價or促銷進價,再依成本計算含稅否(xcaz010),
      IF g_argv[1] = '9' THEN 
         LET l_success = ''
         LET l_stas020 = ''
         LET l_price = ''
         #取協議中的價格&稅別
         CALL s_cost_price_get_stas(g_inba_m.inbasite,g_inba_m.inba204,'',g_inbb_d[l_ac].inbb001,g_inba_m.inbadocdt) 
              RETURNING l_success,l_stas020,l_price
         IF l_success THEN
            LET g_inbb_d[l_ac].inbb210 = l_price
         END IF
         #取此據點的成本是否含稅
         CALL s_cost_price_xcaz010(g_inba_m.inbasite) RETURNING l_success,l_xcaz010
         #若此據點成本不含稅,將此含稅價換算為未稅價
         IF l_success AND l_xcaz010 = 'N' AND (NOT cl_null(g_inbb_d[l_ac].inbb210)) THEN
            SELECT ooef016 INTO l_ooef016
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_inba_m.inbasite
               
            CALL s_cost_price_count(g_inba_m.inbasite,l_stas020,g_inbb_d[l_ac].inbb210,1,l_ooef016,1) 
                 RETURNING l_xrcd103,l_nouse_1,l_nouse_2,l_nouse_3,l_nouse_4,l_nouse_5
            IF NOT cl_null(l_xrcd103) THEN
               LET g_inbb_d[l_ac].inbb210 = l_xrcd103
            END IF
            DISPLAY " l_xrcd103,",l_xrcd103
            DISPLAY " l_nouse_1,",l_nouse_1
            DISPLAY " l_nouse_2,",l_nouse_2
            DISPLAY " l_nouse_3,",l_nouse_3
            DISPLAY " l_nouse_4,",l_nouse_4
            DISPLAY " l_nouse_5,",l_nouse_5
         END IF
      ELSE
      #160728-00018#1 20160728 add by beckxie---E
         LET l_success = ''
         LET l_rtdx034 = ''
         CALL s_cost_rtdx(g_inba_m.inbasite,g_inbb_d[l_ac].inbb001,g_today,'')
            RETURNING l_success,l_rtdx034
         IF l_success THEN
            LET g_inbb_d[l_ac].inbb210 = l_rtdx034
         END IF
      #150915-00010#1 150915 By pomelo add(E)
      END IF   #160728-00018#1 20160728 add by beckxie
   END IF
END FUNCTION

################################################################################
# Descriptions...: 領用單價預設值
# Memo...........:
# Usage..........: CALL aint911_inbb205_default()
# Date & Author..: 2015/07/16 By Lori   #150629-00016#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb205_default()
   IF g_inba_m.inba012 = '3' THEN
      RETURN
   END IF
   
   IF cl_null(g_inbb_d[l_ac].inbb001) THEN
      RETURN
   END IF
   
   SELECT rtdx016 INTO g_inbb_d[l_ac].inbb205
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = g_inba_m.inbasite
      AND rtdx001 = g_inbb_d[l_ac].inbb001 

   IF NOT cl_null(g_inbb_d[l_ac].inbb205) AND NOT cl_null(g_inbb_d[l_ac].inbb012) THEN
      LET g_inbb_d[l_ac].inbb206 = g_inbb_d[l_ac].inbb205 * g_inbb_d[l_ac].inbb012
   END IF
END FUNCTION

################################################################################
# Descriptions...: 成本單價預設值
# Memo...........:
# Usage..........: CALL aint911_inbb207_default()
# Date & Author..: 2015/07/16 By Lori   #150629-00016#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb207_default()
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_cost      LIKE type_t.num20_6
   DEFINE l_slip_no   LIKE inba_t.inbadocno
   
   
   LET l_cost = 0
   LET l_slip_no = ''
   
   IF g_inba_m.inba012 <> '3' THEN
      RETURN
   END IF
   
   IF g_argv[1] = '1' THEN
      IF cl_null(g_inbb_d[l_ac].inbb001) OR g_inbb_d[l_ac].inbb002 IS NULL OR 
         cl_null(g_inbb_d[l_ac].inbb007) OR g_inbb_d[l_ac].inbb009 IS NULL OR
         g_inbb_d[l_ac].inbb003 IS NULL THEN
      ELSE
      
      
         CALL s_cost_price_get_item_cost(g_inba_m.inbasite,'','','','',                                                                     #营运中心编号,帐套,本位币顺序,成本计算类型,会计年度
                                         '',g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb009,    #会计期别,料件编号,产品特征,仓库,批号           
                                         g_inbb_d[l_ac].inbb003,'')                                                                         #库存管理特征,币种
            RETURNING l_success, l_cost
      END IF      
   ELSE
      IF (cl_null(g_inba_m.inba006) AND cl_null(g_inbb_d[l_ac].inbb017)) OR cl_null(g_inbb_d[l_ac].inbb211) OR cl_null(g_inbb_d[l_ac].inbb212) THEN
      ELSE
         IF NOT cl_null(g_inba_m.inba006) THEN
            LET l_slip_no = g_inba_m.inba006
         ELSE
            IF NOT cl_null(g_inbb_d[l_ac].inbb017) THEN 
               LET l_slip_no = g_inbb_d[l_ac].inbb017
            END IF         
         END IF
         
         SELECT inbc206 
           INTO l_cost
           FROM inbc_t
          WHERE inbcent = g_enterprise
            AND inbcdocno = l_slip_no
            AND inbcseq = g_inbb_d[l_ac].inbb211
            AND inbcseq1 = g_inbb_d[l_ac].inbb212  
      END IF            
   END IF
   
   IF cl_null(l_cost) OR l_cost = 0 THEN
      LET l_cost = g_inbb_d[l_ac].inbb210 
   END IF
   
   LET g_inbb_d[l_ac].inbb207 = l_cost 
   IF NOT cl_null(g_inbb_d[l_ac].inbb207) AND NOT cl_null(g_inbb_d[l_ac].inbb012) THEN
      LET g_inbb_d[l_ac].inbb208 = g_inbb_d[l_ac].inbb207 * g_inbb_d[l_ac].inbb012
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 費用編號預設值
# Memo...........:
# Usage..........: CALL aint911_inbb209_default()
# Date & Author..: 2015/07/16 By Lori   #150629-00016#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb209_default()
   SELECT stav002 INTO g_inbb_d[l_ac].inbb209
     FROM stav_t
    WHERE stavent = g_enterprise
      AND stav001 = g_prog

   LET g_inbb_d[l_ac].inbb209_desc = aint911_inbb209_ref(g_inbb_d[l_ac].inbb209)
   LET g_inbb_d_o.inbb209 = g_inbb_d[l_ac].inbb209
END FUNCTION

################################################################################
# Descriptions...: 商品編號校驗
# Memo...........:
# Usage..........: CALL aint911_inbb001_chk(p_inbb001)
#                  RETURNING r_success
# Input parameter: p_inbb001
# Return code....: r_success
# Date & Author..: 2015/02/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb001_chk(p_inbb001)
   DEFINE p_inbb001   LIKE inbb_t.inbb001
   DEFINE r_success   LIKE type_t.num5
   #151113-00020#1 151117 By pomelo add(S)
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_sql       STRING
   #151113-00020#1 151117 By pomelo add(E)
   
   LET r_success = TRUE
                 
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_inbb001
   LET g_chkparam.arg2 = 'ALL'
   #150820-00008#1 150820 by lori mark and add---(S)                  
   IF cl_get_para(g_enterprise,"","E-CIR-0017") = 'Y' THEN
      LET g_chkparam.err_str[1] = "aim-00001:ain-00636"   #160719-00017#1 160725 by lori add
      LET g_chkparam.err_str[2] = "aim-00101:ain-00636"   #160719-00017#1 160725 by lori mod
   ELSE
      LET g_chkparam.err_str[1] = "aim-00001:ain-00635"   #160719-00017#1 160725 by lori add
      LET g_chkparam.err_str[2] = "aim-00101:ain-00635"   #160719-00017#1 160725 by lori mod 
   END IF   
   
   #IF cl_chk_exist("v_imaf001_15") THEN     
   IF cl_chk_exist("v_imaa001") THEN        
   #150820-00008#1 150820 by lori mark and add---(E)
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = p_inbb001
      LET g_chkparam.arg2 = g_inba_m.inbasite
      IF NOT cl_chk_exist("v_rtdx001") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #IF NOT aint911_inag_chk() THEN
      #   LET r_success = FALSE
      #   RETURN r_success      
      #END IF
      
      #160604-00009#140 Add By Ken 160711(S)
      IF g_argv[1] = '9' AND NOT cl_null(g_inba_m.inba204) THEN
         LET l_sql = " SELECT COUNT(imaa001)",
                     "   FROM imaa_t ",
                     "  WHERE imaaent = ",g_enterprise,
                     "    AND imaa001 = '",p_inbb001,"'",
                     "    AND EXISTS (SELECT starent,star003,stas003 ",
                     "                  FROM (SELECT starent,star003,stas003 FROM star_t,stas_t ",
                     "                         WHERE starent = stasent ",
                     "                           AND star001 = stas001 )",
                     "                 WHERE imaaent = starent ",
                     "                   AND imaa001 = stas003 ",
                     "                   AND star003 = '",g_inba_m.inba204,"'",
                     "                   AND stas003 = '",p_inbb001,"')"
         PREPARE aint911_inba204_cnt FROM l_sql
         EXECUTE aint911_inba204_cnt INTO l_cnt
          
         IF l_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = 'ain-00766'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF       
      END IF
      #160604-00009#140 Add By Ken 160711(E)
      
      #151113-00020#1 151117 By pomelo add(S)
      #當單頭管理品類有輸入，需控管商品必須在此品類下
      IF NOT cl_null(g_inba_m.inba203) THEN
         LET l_cnt = 0
         LET l_sql = " SELECT COUNT(imaa001)",
                     "   FROM imaa_t ",
                     "  WHERE imaaent = ",g_enterprise,
                     "    AND imaa001 = '",p_inbb001,"'",
                     "    AND EXISTS (SELECT 1",
                     "                  FROM rtax_t",
                     "                 WHERE rtaxent = imaaent",
                     "                   AND rtax001 = imaa009",
                     "                   AND rtaxstus = 'Y'",
                     "                 START WITH rtaxent = imaaent",
                     "                   AND rtax001 = '",g_inba_m.inba203,"'",
                     "               CONNECT BY NOCYCLE PRIOR rtax001 = rtax003",
                     "                   AND rtaxent = imaaent)"
         PREPARE aint911_inba203_cnt FROM l_sql
         EXECUTE aint911_inba203_cnt INTO l_cnt
          
         IF l_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = 'ain-00680'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF           
      END IF
      #151113-00020#1 151117 By pomelo add(E)
   ELSE
      LET r_success = FALSE
      RETURN r_success
   END IF

   #150629-00016#1 150818 by lori---(S)
   IF NOT aint911_detail_source_chk(4) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #150629-00016#1 150818 by lori---(E)
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查數量
# Memo...........:
# Usage..........: CALL aint911_inbb011_chk()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/02/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb011_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_type      LIKE type_t.chr10   #151113-00020#1 151119 By pomelo add
   
   LET r_success = TRUE
   
   #依據單據別參數控管判斷是否允許輸入小於0
   IF g_num_para = 'N' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'ain-00020'
       LET g_errparam.extend = g_inbb_d[l_ac].inbb011
       LET g_errparam.popup = TRUE
       CALL cl_err()

       LET r_success = FALSE
       RETURN r_success          
   END IF
   
   #151113-00020#1 151119 By pomelo add(S)
   IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
      LET l_type = '1'
   ELSE
      LET l_type = '2'
   END IF
   IF l_type = '1' THEN
   #151113-00020#1 151119 By pomelo add(E)
   #IF g_argv[1] = '1' THEN    #151113-00020#1 151119 By pomelo mark
      #出庫單據考慮在揀量
      #檢核目前庫存量-已在揀量後是否還足夠進行發料，若不夠則show錯誤訊息告知
      IF g_pick_para = 'Y' THEN
         LET l_success = ''
         LET l_flag = ''
         CALL s_inventory_check_inan(g_inba_m.inbasite,
                                     g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,g_inbb_d[l_ac].inbb003,
                                     g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008,g_inbb_d[l_ac].inbb009,
                                     g_inbb_d[l_ac].inbb010,g_inbb_d[l_ac].inbb011,g_inba_m.inbadocno,
                                     g_inbb_d[l_ac].inbbseq,'0','','') #160408-00035#9-add-'',''
              RETURNING l_success,l_flag
         IF NOT l_success OR l_flag = 0 THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF 
      #當申請數量是打負數時代表是出庫行為，檢核庫存量是否足夠
      IF g_inbb_d[l_ac].inbb011 < 0 THEN
         LET l_success = ''
         LET l_flag = ''
         CALL s_inventory_check_inag008('-1',
                                        g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,g_inbb_d[l_ac].inbb003,
                                        g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008,g_inbb_d[l_ac].inbb009,
                                        g_inbb_d[l_ac].inbb011*(-1),g_inba_m.inbadocno,g_inbb_d[l_ac].inbbseq,
                                        '0',g_inbb_d[l_ac].inbb010,'')
              RETURNING l_success,l_flag
         IF NOT l_success THEN      
            LET r_success = FALSE
            RETURN r_success
         ELSE
            IF l_flag = 0 THEN      #庫存量足夠否
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00270'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
         
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
      END IF
   END IF
   
   RETURN r_success                          
END FUNCTION

################################################################################
# Descriptions...: 清除商品編號的帶值欄位
# Memo...........:
# Usage..........: CALL aint911_inbb001_clear()
# Date & Author..: 2015/2/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb001_clear()
   LET g_inbb_d[l_ac].inbb002 = ''
   LET g_inbb_d[l_ac].inbb002_desc = ''
   LET g_inbb_d[l_ac].inbb003 = ''
   LET g_inbb_d[l_ac].inbb010 = ''
   LET g_inbb_d[l_ac].inbb010_desc = ''
   LET g_inbb_d[l_ac].inbb007 = ''
   LET g_inbb_d[l_ac].inbb007_desc = ''
   LET g_inbb_d[l_ac].inbb008 = ''
   LET g_inbb_d[l_ac].inbb008_desc = ''
   LET g_inbb_d[l_ac].inbb200 = ''
   LET g_inbb_d[l_ac].inbb201 = ''
   LET g_inbb_d[l_ac].inbb201_desc = ''
END FUNCTION

################################################################################
# Descriptions...: 數量轉換
# Memo...........:
# Usage..........: CALL aint911_qty_convert(p_type)
#                  RETURNING r_success
# Input parameter: p_type     轉換方式:1.包裝數轉交易數,2.交易數轉包裝數
# Return code....: r_success  
# Date & Author..: 2015/2/13 By Lori
# Modify.........: #151111-00021#3 Add By Ken 151202加3.交易數轉成計價數量
################################################################################
PRIVATE FUNCTION aint911_qty_convert(p_type)
   DEFINE p_type      LIKE type_t.num5
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5

   LET r_success = TRUE
   
   CASE p_type
      WHEN 1
         IF NOT cl_null(g_inbb_d[l_ac].inbb010) AND NOT cl_null(g_inbb_d[l_ac].inbb201) AND NOT cl_null(g_inbb_d[l_ac].inbb202) THEN
            CALL s_aooi250_convert_qty(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb201,g_inbb_d[l_ac].inbb010,g_inbb_d[l_ac].inbb202)
               RETURNING l_success,g_inbb_d[l_ac].inbb011
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF 
            
            CALL s_aooi250_take_decimals(g_inbb_d[l_ac].inbb010,g_inbb_d[l_ac].inbb011)
               RETURNING l_success,g_inbb_d[l_ac].inbb011                    
            #LET g_inbb_d[l_ac].inbb012 = g_inbb_d[l_ac].inbb011  #151113-00020#1 151117 By pomelo mark
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF                                        
         END IF
         
      WHEN 2
         IF NOT cl_null(g_inbb_d[l_ac].inbb010) AND NOT cl_null(g_inbb_d[l_ac].inbb011) AND NOT cl_null(g_inbb_d[l_ac].inbb201) THEN
            CALL s_aooi250_convert_qty(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb010,g_inbb_d[l_ac].inbb201,g_inbb_d[l_ac].inbb011)
               RETURNING l_success,g_inbb_d[l_ac].inbb202
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF 
            
            CALL s_aooi250_take_decimals(g_inbb_d[l_ac].inbb201,g_inbb_d[l_ac].inbb202)
               RETURNING l_success,g_inbb_d[l_ac].inbb202                   
            LET g_inbb_d[l_ac].inbb203 = g_inbb_d[l_ac].inbb202
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF                                        
         END IF
      #151111-00021#3 Add By Ken 151202(S)   
      WHEN 3  #交易數轉成計價數量
         IF NOT cl_null(g_inbb_d[l_ac].inbb010) AND NOT cl_null(g_inbb_d[l_ac].inbb011) AND NOT cl_null(g_inbb_d[l_ac].inbb224) THEN
            CALL s_aooi250_convert_qty(g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb010,g_inbb_d[l_ac].inbb224,g_inbb_d[l_ac].inbb011)
               RETURNING l_success,g_inbb_d[l_ac].inbb225
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF 
            
            CALL s_aooi250_take_decimals(g_inbb_d[l_ac].inbb224,g_inbb_d[l_ac].inbb225)
               RETURNING l_success,g_inbb_d[l_ac].inbb225                   
            #LET g_inbb_d[l_ac].inbb203 = g_inbb_d[l_ac].inbb202
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF                                        
         END IF            
      #151111-00021#3 Add By Ken 151202(E)
   END CASE
   
   LET g_inbb_d[l_ac].inbb012 = g_inbb_d[l_ac].inbb011  #151113-00020#1 151117 By pomelo add
   
   #150629-00016#1 150716 by lori---(S)
   IF NOT cl_null(g_inbb_d[l_ac].inbb207) AND NOT cl_null(g_inbb_d[l_ac].inbb012) THEN
      LET g_inbb_d[l_ac].inbb208 = g_inbb_d[l_ac].inbb207 * g_inbb_d[l_ac].inbb012
   END IF
   
   IF NOT cl_null(g_inbb_d[l_ac].inbb205) AND NOT cl_null(g_inbb_d[l_ac].inbb012) THEN
      LET g_inbb_d[l_ac].inbb206 = g_inbb_d[l_ac].inbb205 * g_inbb_d[l_ac].inbb012
   END IF
   #150629-00016#1 150716 by lori---(E)
   
   #151113-00020#1 151119 By pomelo add(S)
   #當為商品轉碼單時，輸入轉出數量，須帶入轉入數量
   IF g_inba_m.inba001 = '7' THEN
      LET g_inbb_d[l_ac].inbb217 = g_inbb_d[l_ac].inbb012
      IF NOT aint911_turn_num_change(2) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   #151113-00020#1 151119 By pomelo add(E)
   
   RETURN r_success            
END FUNCTION

################################################################################
# Descriptions...: 取單別參數
# Memo...........: 1.允許數量可輸入負值
#                  2.在撿量
# Usage..........: CALL aint911_get_slip_para()
# Date & Author..: 2015/02/27 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_get_slip_para()
   DEFINE l_flag      LIKE type_t.num5
   
   LET g_num_para = ''
   LET g_pick_para = ''
   LET g_slip = ''
   LET l_flag = ''  
   
   CALL s_aooi200_get_slip(g_inba_m.inbadocno) RETURNING l_flag,g_slip
   #允許數量可輸入負值
   LET g_num_para = cl_get_doc_para(g_enterprise,g_inba_m.inbasite,g_slip,'D-BAS-0058')
   #出庫單據考慮在揀量
   LET g_pick_para = cl_get_doc_para(g_enterprise,g_inba_m.inbasite,g_slip,'D-BAS-0070')
END FUNCTION

################################################################################
# Descriptions...: 出貨單過帳Input
# Memo...........:
# Usage..........: CALL aint911_post_input()
#                  RETURNING r_success
# Return code....: r_success   處理狀況
# Date & Author..: 2015/02/27 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_post_input()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_para_data     LIKE type_t.chr80          #接參數用
   
   LET r_success = TRUE
   
   INPUT BY NAME g_inba_m.inba002 ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE INPUT
         IF cl_null(g_inba_m.inba002) THEN
            LET g_inba_m.inba002 = g_today
         END IF
         DISPLAY BY NAME g_inba_m.inba002
         LET g_inba_m_t.inba002 = g_inba_m.inba002

      AFTER FIELD inba002
         IF NOT cl_null(g_inba_m.inba002) THEN
            #151120-00003#1 20151126 mark by beckxie---S
            #IF g_inba_m.inba002 < g_inba_m.inbadocdt THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'axm-00267'   #扣帳日期不可小於單據日期！
            #   LET g_errparam.extend = g_inba_m.inba002
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #
            #   LET g_inba_m.inba002 = g_inba_m_t.inba002
            #   DISPLAY BY NAME g_inba_m.inba002
            #   NEXT FIELD CURRENT
            #END IF
            #151120-00003#1 20151126 mark by beckxie---E
            
            #151130-00019#1 20151203  add by beckxie---S
            IF g_inba_m.inba002 > g_today THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-01042'   #扣帳日期不可大於系統日期！
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_inba_m.inba002 = g_inba_m_t.inba002
               DISPLAY g_inba_m.inba002 TO inba002
               NEXT FIELD CURRENT
            END IF
            #151130-00019#1 20151203  add by beckxie---E            
            
            CALL cl_get_para(g_enterprise,g_inba_m.inbasite,'S-MFG-0031') RETURNING l_para_data
            IF g_inba_m.inba002 <= l_para_data THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00077'   #扣帳日期小於關帳日期，請重新輸入！
               LET g_errparam.extend = g_inba_m.inba002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_inba_m.inba002 = g_inba_m_t.inba002
               #DISPLAY BY NAME g_inba_m.inba002  #Mark Ken XXXXXX 151203
               NEXT FIELD CURRENT
            END IF
            #151005-00003#1 過帳前檢查參數&上月份盤點流程是否完成 20151021 add by beckxie---S
            IF NOT s_beforeinv_chk(g_inba_m.inbasite,g_inba_m.inba002) THEN
               NEXT FIELD CURRENT
            END IF
            #151005-00003#1 過帳前檢查參數&上月份盤點流程是否完成 20151021 add by beckxie---E
         END IF
            
     AFTER INPUT
         IF INT_FLAG THEN
            EXIT INPUT
         END IF

         ON ACTION accept
            ACCEPT INPUT

         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT INPUT

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT INPUT

         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT INPUT

   END INPUT

   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET r_success = FALSE
      RETURN r_success
   END IF

   UPDATE inba_t
      SET inba002 = g_inba_m.inba002
    WHERE inbaent = g_enterprise
      AND inbadocno = g_inba_m.inbadocno    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF
  
   RETURN r_success  
END FUNCTION

################################################################################
# Descriptions...: 檢查庫存明細
# Memo...........:
# Usage..........: CALL aint911_inag_chk()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/02/27 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inag_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_type      LIKE type_t.chr10   #151113-00020#1 151119 By pomelo add
   
   LET r_success = TRUE
   
   #151113-00020#1 151119 By pomelo add(S)
   IF g_argv[1] = '[17]' OR (g_argv[1] MATCHES '[3456]' AND g_inba_m.inba208 = 'N') THEN
      LET l_type = '1'
   ELSE
      LET l_type = '2'
   END IF
   IF l_type = '1' THEN
   #151113-00020#1 151119 By pomelo add(E)
   #IF g_argv[1] = '1' THEN    #151113-00020#1 151119 By pomelo mark
      IF l_ac > 0 THEN
         #商品編號
         IF NOT cl_null(g_inbb_d[l_ac].inbb001) THEN
            #檢查商品有無庫存
            LET l_success = ''
            CALL s_aint911_inag_chk(g_inba_m.inbasite,
                                    g_inbb_d[l_ac].inbb001,g_inbb_d[l_ac].inbb002,g_inbb_d[l_ac].inbb003,
                                    g_inbb_d[l_ac].inbb007,g_inbb_d[l_ac].inbb008,g_inbb_d[l_ac].inbb009,
                                    g_inbb_d[l_ac].inbb010) RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF            
         END IF
         #產品特徵
         IF cl_null(g_inbb_d[l_ac].inbb002) THEN
            LET g_inbb_d[l_ac].inbb002  =' '
         END IF
         #庫存管理特徵
         IF cl_null(g_inbb_d[l_ac].inbb003) THEN
            LET g_inbb_d[l_ac].inbb003 = ' '
         END IF
         #庫位
         IF NOT cl_null(g_inbb_d[l_ac].inbb007) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_inba_m.inbasite
            LET g_chkparam.arg2 = g_inbb_d[l_ac].inbb001
            LET g_chkparam.arg3 = g_inbb_d[l_ac].inbb002
            LET g_chkparam.arg4 = g_inbb_d[l_ac].inbb003
            LET g_chkparam.arg5 = g_inbb_d[l_ac].inbb007
            IF NOT cl_chk_exist("v_inag004") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF         
         ELSE
            RETURN r_success
         END IF
         #儲位
         IF NOT cl_null(g_inbb_d[l_ac].inbb007) AND 
            NOT cl_null(g_inbb_d[l_ac].inbb008) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_inba_m.inbasite
            LET g_chkparam.arg2 = g_inbb_d[l_ac].inbb001
            LET g_chkparam.arg3 = g_inbb_d[l_ac].inbb002
            LET g_chkparam.arg4 = g_inbb_d[l_ac].inbb003
            LET g_chkparam.arg5 = g_inbb_d[l_ac].inbb007
            LET g_chkparam.arg6 = g_inbb_d[l_ac].inbb008
            IF NOT cl_chk_exist("v_inag005") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF         
         ELSE
            RETURN r_success
         END IF         
         #批號
         IF NOT cl_null(g_inbb_d[l_ac].inbb007) AND 
            NOT cl_null(g_inbb_d[l_ac].inbb008) AND 
            NOT cl_null(g_inbb_d[l_ac].inbb009) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_inba_m.inbasite
            LET g_chkparam.arg2 = g_inbb_d[l_ac].inbb001
            LET g_chkparam.arg3 = g_inbb_d[l_ac].inbb002
            LET g_chkparam.arg4 = g_inbb_d[l_ac].inbb003
            LET g_chkparam.arg5 = g_inbb_d[l_ac].inbb007
            LET g_chkparam.arg6 = g_inbb_d[l_ac].inbb008
            LET g_chkparam.arg7 = g_inbb_d[l_ac].inbb009
            IF NOT cl_chk_exist("v_inag009") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF         
         ELSE
            RETURN r_success
         END IF          
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增inbc_t資料
# Memo...........:
# Usage..........: CALL aint911_ins_inbc()
#                     RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/02/27 By Lori
# Modify.........: 2015/06/02 By Lori 入項作業, 新增inbc_t前依商品批號管控設定判斷有無需要自動編號
# Modify.........: 2015/08/20 By Lori 入項作業, 改於新增 inbb_t前依商品批號管控設定判斷有無需要自動編號
#                : 2016/01/19 By pomelo 移至s_aint911_ins_inbc #151130-00008#11
################################################################################
PRIVATE FUNCTION aint911_ins_inbc()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5      #150601-00009#5 1500602 by lori add
   DEFINE l_inbc007    LIKE inbc_t.inbc007   #150601-00009#5 1500602 by lori add
   
   LET r_success = TRUE

   #150820-00008#1 150820 by lori mark---(S) 
   ##150601-00009#5 150602 by lori add---(S)
   #LET l_success = ''
   #LET l_inbc007 = ''
   #   
   #IF g_argv[1] = '2' THEN
   #   IF cl_null(g_inbb_d[g_detail_idx].inbb009) THEN
   #      CALL s_lot_out_get_batch_no(g_inbb_d[g_detail_idx].inbb001)
   #         RETURNING l_success,l_inbc007
   #      IF l_success = FALSE THEN
   #         LET r_success = FALSE
   #         RETURN
   #      END IF
   #   ELSE 
   #      LET l_inbc007 = g_inbb_d[g_detail_idx].inbb009
   #   END IF   
   #ELSE
   #   LET l_inbc007 = g_inbb_d[g_detail_idx].inbb009
   #END IF   
   ##150601-00009#5 150602 by lori add---(E)  
   #150820-00008#1 150820 by lori mark---(E)  
   
   INSERT INTO inbc_t
               (inbcent  , inbcsite,inbcunit,   #企業編號,營運據點,應用組織
                inbcdocno,inbcseq  ,inbcseq1,   #單據編號,項次,項序
                inbc001  ,inbc002  ,inbc003 ,   #料件編號,產品特徵,庫存管理特徵
                inbc005  ,inbc006  ,inbc007 ,   #庫位,儲位,批號
                inbc009  ,inbc010  ,inbc016 ,   #交易單位,數量,有效日期
                inbc017  ,inbc200  ,inbc201 ,   #存貨備註,商品條碼,包裝單位
                inbc202  ,inbc203  ,            #包裝數量,製造日期                      #150507-00001#8 150527 by lori add inbc203
                inbc204  ,inbc205  ,inbc206 ,   #領用/退回單價,領用/退回金額,成本單價    #150629-00016#1 150716 by lori add
                inbc207  ,inbc208  ,inbc209 ,   #成本金額,費用編號,來源單據項次          #150629-00016#1 150716 by lori add
                inbc210  ,                      #來源單據項序                           #150629-00016#1 150716 by lori add
                inbc211  ,inbc212 )             #計價單位、計價數量                     #151111-00021#3 Add By Ken 151203  
                
         VALUES(g_enterprise      ,g_inba_m.inbasite     ,g_inba_m.inbaunit,                                     #企業編號,營運據點,應用組織
                g_inba_m.inbadocno,g_inbb_d[l_ac].inbbseq,1,                                                     #單據編號,項次,項序
                g_inbb_d[g_detail_idx].inbb001,g_inbb_d[g_detail_idx].inbb002,g_inbb_d[g_detail_idx].inbb003,    #料件編號,產品特徵,庫存管理特徵
                g_inbb_d[g_detail_idx].inbb007,g_inbb_d[g_detail_idx].inbb008,g_inbb_d[g_detail_idx].inbb009,    #庫位,限定儲位,限定批號                 #150601-00009#5 1500602 by lori mod inbb009->l_inbc007  #150903-00013#1 150903 by lori l_inbc->inbb009
                g_inbb_d[g_detail_idx].inbb010,g_inbb_d[g_detail_idx].inbb011,g_inbb_d[g_detail_idx].inbb022,    #交易單位,申請數量,有效日期                  
                g_inbb_d[g_detail_idx].inbb021,g_inbb_d[g_detail_idx].inbb200,g_inbb_d[g_detail_idx].inbb201,    #存貨備註,商品條碼,包裝單位
                g_inbb_d[g_detail_idx].inbb202,g_inbb_d[g_detail_idx].inbb204,                                   #申請包裝數量,實際包裝數量,製造日期      #150507-00001#8 150527 by lori add inbb204
                g_inbb_d[g_detail_idx].inbb205,g_inbb_d[g_detail_idx].inbb206,g_inbb_d[g_detail_idx].inbb207,    #領用/退回單價,領用/退回金額,成本單價    #150629-00016#1 150716 by lori add
                g_inbb_d[g_detail_idx].inbb208,g_inbb_d[g_detail_idx].inbb209,g_inbb_d[g_detail_idx].inbb211,    #成本金額,費用編號,來源單據項次          #150629-00016#1 150716 by lori add
                g_inbb_d[g_detail_idx].inbb212,                                                                  #來源單據項序                          #150629-00016#1 150716 by lori add
                g_inbb_d[g_detail_idx].inbb224,g_inbb_d[g_detail_idx].inbb225 )                                  #計價單位、計價數量                     #151111-00021#3 Add By Ken 151203
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Insert inbc_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
    
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 更新inbc_t資料
# Memo...........:
# Usage..........: CALL aint911_upd_inbc()
#                     RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/02/27 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_upd_inbc()
   DEFINE r_success LIKE type_t.num5
   DEFINE l_cnt     LIKE type_t.num5
   
   LET r_success = TRUE
   
   #1.修改領用/退回明細時，若對應的出庫/入庫明細只有一筆資料，則需將資料更新至所有對應的[T:雜項庫存異動庫儲批明細檔]
   LET l_cnt = 0 
   
   SELECT COUNT(*) INTO l_cnt
     FROM inbc_t
    WHERE inbcent = g_enterprise 
      AND inbcsite = g_inba_m.inbasite
      AND inbcdocno = g_inba_m.inbadocno
      AND inbcseq = g_inbb_d_o.inbbseq 
      AND inbcseq1 = 1

   IF l_cnt = 1 THEN
      UPDATE inbc_t
         SET inbcseq  = g_inbb_d[l_ac].inbbseq,   #項次
             inbc001  = g_inbb_d[g_detail_idx].inbb001,   #料件編號
             inbc002  = g_inbb_d[g_detail_idx].inbb002,   #產品特徵
             inbc003  = g_inbb_d[g_detail_idx].inbb003,   #庫存管理特徵
             inbc005  = g_inbb_d[g_detail_idx].inbb007,   #庫位
             inbc006  = g_inbb_d[g_detail_idx].inbb008,   #儲位
             inbc007  = g_inbb_d[g_detail_idx].inbb009,   #批號
             inbc009  = g_inbb_d[g_detail_idx].inbb010,   #交易單位
             inbc010  = g_inbb_d[g_detail_idx].inbb011,   #數量
             inbc016  = g_inbb_d[g_detail_idx].inbb022,   #有效日期
             inbc200  = g_inbb_d[g_detail_idx].inbb200,   #商品條碼
             inbc201  = g_inbb_d[g_detail_idx].inbb201,   #包裝單位
             inbc202  = g_inbb_d[g_detail_idx].inbb202,   #包裝數量
             inbc203  = g_inbb_d[g_detail_idx].inbb204,   #製造日期         #150507-00001#8 150527 by lori add
             inbc204  = g_inbb_d[g_detail_idx].inbb205,   #領用/退回單價    #150629-00016#1 150716 by lori add   
             inbc205  = g_inbb_d[g_detail_idx].inbb206,   #領用/退回金額    #150629-00016#1 150716 by lori add   
             inbc206  = g_inbb_d[g_detail_idx].inbb207,   #成本單價         #150629-00016#1 150716 by lori add   
             inbc207  = g_inbb_d[g_detail_idx].inbb208,   #成本金額         #150629-00016#1 150716 by lori add   
             inbc208  = g_inbb_d[g_detail_idx].inbb209,   #費用編號         #150629-00016#1 150716 by lori add   
             inbc209  = g_inbb_d[g_detail_idx].inbb211,   #來源單據項次     #150629-00016#1 150716 by lori add   
             inbc210  = g_inbb_d[g_detail_idx].inbb212    #來源單據項序     #150629-00016#1 150716 by lori add   
       WHERE inbcent = g_enterprise 
         AND inbcsite = g_inba_m.inbasite
         AND inbcdocno = g_inba_m.inbadocno
         AND inbcseq = g_inbb_d_o.inbbseq 
         AND inbcseq1 = 1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Insert inbc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
       
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #2.若有修改到存貨備註時，需開窗詢問是否同步更新[T:雜項庫存異動庫儲批明細檔].[C:存貨備註]
   IF ((g_inbb_d[g_detail_idx].inbb021 != g_inbb_d_o.inbb021) OR ((NOT cl_null(g_inbb_d[g_detail_idx].inbb021)) AND cl_null(g_inbb_d_o.inbb021)) OR ((NOT cl_null(g_inbb_d_o.inbb021)) AND cl_null(g_inbb_d[g_detail_idx].inbb021))) THEN
      IF cl_ask_confirm('ain-00021') THEN
         UPDATE inbc_t 
            SET inbc017 = g_inbb_d[g_detail_idx].inbb021
           WHERE inbcent = g_enterprise 
             AND inbcsite = g_inba_m.inbasite
             AND inbcdocno = g_inba_m.inbadocno
             AND inbcseq = g_inbb_d_o.inbbseq 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
   
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END IF
   
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 刪除inbc_t資料
# Memo...........:
# Usage..........: CALL aint911_del_inbc()
#                     RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/02/27 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_del_inbc()
   DEFINE r_success  LIKE type_t.num5

   LET r_success = TRUE
   DELETE FROM inbc_t
       WHERE inbcent = g_enterprise 
         AND inbcsite = g_inba_m.inbasite
         AND inbcdocno = g_inba_m.inbadocno
         AND inbcseq = g_inbb_d_o.inbbseq #項次
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取費用说明
# Memo...........:
# Usage..........: CALL aint911_inbb209_ref(p_inbb209)
#                  RETURNING r_stael003
# Input parameter: p_inbb209   費用編號
# Return code....: r_stael003  費用說明
# Date & Author..: 2015/02/13 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb209_ref(p_inbb209)
   DEFINE p_inbb209   LIKE inbb_t.inbb209
   DEFINE r_stael003  LIKE stael_t.stael003
   
   LET r_stael003 = ''
   
   SELECT stael003 INTO r_stael003
     FROM stael_t
    WHERE staelent = g_enterprise
      AND stael001 = p_inbb209
      AND stael002 = g_dlang
      
   RETURN r_stael003
END FUNCTION

################################################################################
# Descriptions...: 退回單單頭有輸入來源單號時,自動產生單身
# Memo...........:
# Usage..........: CALL aint911_auto_gen_detail()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success   處理結果  
# Date & Author..: 2015/08/17 By Lori   #150629-00016#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_auto_gen_detail()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_cnt = 0
   
   IF g_argv[1] = '1' THEN
      RETURN r_success
   END IF
   
   IF cl_null(g_inba_m.inba006) THEN
      RETURN r_success
   END IF
   
   SELECT COUNT(*) INTO l_cnt
     FROM inbb_t 
    WHERE inbbent = g_enterprise
      AND inbbdocno = g_inba_m.inbadocno
    
   IF l_cnt = 0 THEN
      IF cl_ask_confirm('ain-00186') THEN
         INSERT INTO inbb_t(inbbent,inbbsite,inbbunit,inbbdocno,inbbseq,
                            inbb001,inbb002 ,inbb003,inbb004,inbb007,
                            inbb008,inbb009 ,inbb010,inbb011,inbb012,
                            inbb013,inbb014 ,inbb015,inbb016,inbb017,
                            inbb018,inbb019 ,inbb020,inbb021,inbb022,
                            inbb200,inbb201 ,inbb202,inbb203,inbb204,
                            inbb023,inbb024 ,inbb025,inbb205,inbb206,
                            inbb207,inbb208 ,inbb209,inbb210,inbb211,
                            inbb212)
              SELECT g_enterprise,g_inba_m.inbasite,g_inba_m.inbaunit,g_inba_m.inbadocno,inbbseq,
                     inbb001     ,inbb002          ,inbb003          ,inbb004            ,inbb007,
                     inbb008     ,inbb009          ,inbb010          ,inbb011            ,inbb012,
                     inbb013     ,inbb014          ,inbb015          ,inbb016            ,inbb017,
                     inbb018     ,inbb019          ,inbb020          ,inbb021            ,inbb022,
                     inbb200     ,inbb201          ,inbb202          ,inbb203            ,inbb204,
                     inbb023     ,inbb024          ,inbb025          ,inbb205            ,inbb206,
                     inbb207     ,inbb208          ,inbb209          ,inbb210            ,1,
                     1
                FROM inbb_t
               WHERE inbbent = g_enterprise
                 AND inbbdocno = g_inba_m.inba006
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Insert inbb_t Error:"
            LET g_errparam.popup = FALSE
            CALL cl_err()
         
            LET r_success = FALSE
            RETURN r_success
         END IF 
         
         INSERT INTO inbc_t(inbcent,inbcsite,inbcdocno,inbcseq,inbcseq1,
                            inbc001,inbc002 ,inbc003  ,inbc004,inbc005,
                            inbc006,inbc007 ,inbc009  ,inbc010,inbc011,
                            inbc015,inbc016 ,inbc017  ,inbc018,inbc019,
                            inbc020,inbc200 ,inbc201  ,inbc202,inbc203,
                            inbc021,inbc022 ,inbc023  ,inbc204,inbc205,
                            inbc206,inbc207 ,inbc208  ,inbc209,inbc210,
                            inbcunit)
              SELECT g_enterprise,g_inba_m.inbasite,g_inba_m.inbadocno,inbcseq,inbcseq1,
                     inbc001     ,inbc002          ,inbc003           ,inbc004,inbc005,
                     inbc006     ,inbc007          ,inbc009           ,inbc010,inbc011,
                     inbc015     ,inbc016          ,inbc017           ,inbc018,inbc019,
                     inbc020     ,inbc200          ,inbc201           ,inbc202,inbc203,
                     inbc021     ,inbc022          ,inbc023           ,inbc204,inbc205,
                     inbc206     ,inbc207          ,inbc208           ,inbc209,inbc210,
                     g_inba_m.inbaunit 
                FROM inbc_t
               WHERE inbcent = g_enterprise
                 AND inbcdocno = g_inba_m.inba006   
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Insert inbc_t Error:"
            LET g_errparam.popup = FALSE
            CALL cl_err()
         
            LET r_success = FALSE
            RETURN r_success
         END IF                  
         
         CALL aint911_b_fill()
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: aint912來源單據=雜項領用單時,檢查項次/條碼/商品是否存在於來源單
# Memo...........:
# Usage..........: CALL aint911_detail_source_chk(p_type)
#                  RETURNING r_success
# Input parameter: p_type      檢查項目:1.項次 2.項序 3.商品條碼 4.商品編號
# Return code....: r_success   檢核結果
# Date & Author..: 2015/08/17 By Lori   #150629-00016#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_detail_source_chk(p_type)
   DEFINE p_type       LIKE type_t.num5
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_err        LIKE type_t.chr30
   DEFINE l_slip_no    STRING
   DEFINE l_prog_name  LIKE type_t.chr500
   
   LET r_success = TRUE
   LET l_cnt = 0
   LET l_err = ''
   LET l_prog_name = ''
   
   IF l_ac = 0 THEN
      RETURN r_success
   END IF
   
   IF NOT cl_null(g_inba_m.inba006) OR NOT cl_null(g_inbb_d[l_ac].inbb017) THEN
      IF NOT cl_null(g_inba_m.inba006) THEN
         LET l_slip_no = g_inba_m.inba006
      ELSE
         LET l_slip_no = g_inbb_d[l_ac].inbb017
      END IF  
      
      LET l_sql = "SELECT COUNT(*) ",
                  "  FROM inbb_t,inbc_t ",
                  " WHERE inbcent = inbbent ",
                  "   AND inbcdocno = inbcdocno ",
                  "   AND inbcseq = inbbseq ",        
                  "   AND inbcent = ",g_enterprise,
                  "   AND inbcdocno = COALESCE('",l_slip_no,"') ",
                  "   AND inbcseq = COALESCE(",g_inbb_d[l_ac].inbb211,",inbcseq) ",      
                  "   AND inbcseq1 = COALESCE(",g_inbb_d[l_ac].inbb212,",inbcseq1) ",
                  "   AND inbb001 = COALESCE('",g_inbb_d[l_ac].inbb001,"',inbb001) ",    
                  "   AND inbb200 = COALESCE('",g_inbb_d[l_ac].inbb200,"',inbb200) "
      PREPARE aint911_detail_chk FROM l_sql                  
      EXECUTE aint911_detail_chk INTO l_cnt
      IF l_cnt = 0 THEN
          SELECT gzzal003
            INTO l_prog_name
            FROM gzzal_t
           WHERE gzzal_t = 'aint911'
             AND gzzal002 = g_dlang     
          
          LET l_prog_name = "aint911",l_prog_name

          INITIALIZE g_errparam TO NULL
          CASE p_type
             WHEN 1   #項次
                LET l_err = 'ain-00631'   #輸入的來源項次(%1)不存在於來源單號(%2)中！
                LET g_errparam.replace[1] = g_inbb_d[l_ac].inbb211
                LET g_errparam.replace[2] = l_slip_no
                LET g_errparam.replace[3] = l_prog_name
             WHEN 2   #項序
                LET l_err = 'ain-00632'   #輸入的來源項次(%1)+項序(%2)不存在於來源單號(%3)中！
                LET g_errparam.replace[1] = g_inbb_d[l_ac].inbb211
                LET g_errparam.replace[2] = g_inbb_d[l_ac].inbb212
                LET g_errparam.replace[3] = l_slip_no
                LET g_errparam.replace[4] = l_prog_name                
             WHEN 3   #商品條碼
                LET l_err = 'ain-00633'   #輸入的商品條碼(%1)不存在於來源單號(%2)中！
                LET g_errparam.replace[1] = g_inbb_d[l_ac].inbb200
                LET g_errparam.replace[2] = l_slip_no
                LET g_errparam.replace[3] = l_prog_name                
             WHEN 4   #商品編號
                LET l_err = 'ain-00634'   #輸入的商品編號(%1)不存在於來源單號(%2)中！
                LET g_errparam.replace[1] = g_inbb_d[l_ac].inbb001
                LET g_errparam.replace[2] = l_slip_no
                LET g_errparam.replace[3] = l_prog_name                
          END CASE
          
          LET g_errparam.code = l_err
          LET g_errparam.popup = FALSE
          CALL cl_err()
         
          LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單據確認前處理:1.檢查是否有批號自動沖減,但無批號的商品,若有則重取批號
# Memo...........:
# Usage..........: CALL aint911_before_conf_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: success
# Date & Author..: 2015/08/20 By Lori   #150820-00008#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_before_conf_chk()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5   
   DEFINE l_sql           STRING
   DEFINE l_inbcseq       LIKE inbc_t.inbcseq
   DEFINE l_inbcseq1      LIKE inbc_t.inbcseq
   DEFINE l_inbc001       LIKE inbc_t.inbc001
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_inbc007       LIKE inbc_t.inbc007
   DEFINE l_err_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_err_cnt = 0
   
   #IF g_argv[1] <> '2' THEN   #151113-00020#1 151118 By pomelo mark
   #151113-00020#1 151118 By pomelo add(S)
   IF g_argv[1] = '1' OR (g_argv[1] MATCHES '[3456]' AND
         NOT cl_null(g_inba_m.inba208) AND g_inba_m.inba208 = 'N') THEN
      RETURN r_success
   END IF
   #151113-00020#1 151118 By pomelo add(E)
   
   LET l_sql = "SELECT t1.inbcseq,t1.inbcseq1,t1.inbc001, ",
               "       (SELECT COUNT(t2.inbcseq) FROM inbc_t t2 ",
               "         WHERE t2.inbcent = t1.inbcent ",
               "           AND t2.inbcdocno = t1.inbcdocno ",
               "           AND t2.inbcseq = t1.inbcseq) ",
               "  FROM inbc_t t1 ",
               " WHERE t1.inbcent = ",g_enterprise,
               "   AND t1.inbcdocno = '",g_inba_m.inbadocno,"' ",
               "   AND t1.inbc007 IS NULL "
   PREPARE aint911_sel_inbc_pre FROM l_sql
   DECLARE aint911_sel_inbc_cur CURSOR FOR aint911_sel_inbc_pre
   
   FOREACH aint911_sel_inbc_cur INTO l_inbcseq,l_inbcseq1,l_inbc001,l_cnt 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "aint911_sel_inbc_cur Error:"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      
      LET l_err_cnt = l_err_cnt + 1
   END IF    
         LET l_success = ''
         LET l_inbc007  = ''
         CALL s_lot_out_get_batch_no(g_inbb_d[g_detail_idx].inbb001)
            RETURNING l_success,l_inbc007

         IF l_inbc007 IS NOT NULL THEN
            UPDATE inbc_t
               SET inbc007 = l_inbc007
             WHERE inbcent = g_enterprise
               AND inbcdocno = g_inba_m.inbadocno
               AND inbcseq = l_inbcseq
               AND inbcseq1 = l_inbcseq1
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Update inbc_t Error:"
               LET g_errparam.popup = FALSE
               CALL cl_err()
               
               LET l_err_cnt = l_err_cnt + 1
               EXIT FOREACH
            END IF 
            
            IF l_cnt = 1 THEN
               UPDATE inbb_t
                  SET inbb009 = l_inbc007
                WHERE inbbent = g_enterprise
                  AND inbbdocno = g_inba_m.inbadocno
                  AND inbbseq = l_inbcseq   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "Update inbb_t Error:"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  
                  LET l_err_cnt = l_err_cnt + 1
                  EXIT FOREACH
               END IF                
            END IF
         END IF
   END FOREACH
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   ELSE
      CALL aint911_b_fill()   
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取費用對象說明
# Memo...........:
# Usage..........: CALL aint911_inba013_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 150827 By Lori   #150827-00013#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inba013_ref()
   CASE g_inba_m.inba012
      WHEN '1'   #供應商 
         LET g_inba_m.inba013_desc = s_desc_get_trading_partner_abbr_desc(g_inba_m.inba013) 
      WHEN '2'   #專櫃     
         LET g_inba_m.inba013_desc = s_desc_get_counter_desc(g_inba_m.inba013)
      WHEN '3'   #內部員工 
         LET g_inba_m.inba013_desc = s_desc_get_department_desc(g_inba_m.inba013)
   END CASE
   
   DISPLAY BY NAME g_inba_m.inba013_desc   
END FUNCTION

################################################################################
# Descriptions...: aint912依據來源單號帶出來源單訊息
# Memo...........:
# Usage..........: CALL aint911_inba006_default()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/08/27 By Lori   #150827-00013#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inba006_default()
   
   IF g_argv[1] <> '2' THEN
      RETURN
   END IF
   
   IF cl_null(g_inba_m.inba006) THEN
      RETURN
   END IF
   
   SELECT inba007,inba012,inba013,inba014
     INTO g_inba_m.inba007,g_inba_m.inba012,g_inba_m.inba013,g_inba_m.inba014
     FROM inba_t 
    WHERE inbaent = g_enterprise
      AND inbadocno = g_inba_m.inba006 
      
   DISPLAY BY NAME g_inba_m.inba007,g_inba_m.inba012,g_inba_m.inba013,g_inba_m.inba014
   CALL aint911_inba013_ref()   
   
   LET g_inba_m_o.inba006 = g_inba_m.inba006
   LET g_inba_m_o.inba007 = g_inba_m.inba007
   LET g_inba_m_o.inba012 = g_inba_m.inba012
   LET g_inba_m_o.inba013 = g_inba_m.inba013
   LET g_inba_m_o.inba014 = g_inba_m.inba014
END FUNCTION

################################################################################
# Descriptions...: 轉入商品編號校驗
# Memo...........:
# Usage..........: CALL aint911_inbb214_chk(p_inbb214)
#                  RETURNING r_success
# Input parameter: p_inbb214      轉入商品編號
# Return code....: r_success      True/False
# Date & Author..: 2015/11/17 By pomelo #151113-00020#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb214_chk(p_inbb214)
DEFINE p_inbb214         LIKE inbb_t.inbb214
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_imaa006         LIKE imaa_t.imaa006
DEFINE l_inbb010         LIKE inbb_t.inbb010
   
   LET r_success = TRUE
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_inbb214
   LET g_chkparam.arg2 = 'ALL'
   IF cl_get_para(g_enterprise,"","E-CIR-0017") = 'Y' THEN
      LET g_chkparam.err_str[1] = "aim-00101:ain-00636"  
   ELSE
      LET g_chkparam.err_str[1] = "aim-00101:ain-00635"  
   END IF
   
   IF NOT cl_chk_exist("v_imaa001") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_inbb214
   LET g_chkparam.arg2 = g_inba_m.inbasite
   IF NOT cl_chk_exist("v_rtdx001_10") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
      
   IF NOT cl_null(g_inba_m.inba207) THEN
      LET l_cnt = 0
      LET l_sql = " SELECT COUNT(imaa001)",
                  "   FROM imaa_t ",
                  "  WHERE imaaent = ",g_enterprise,
                  "    AND imaa001 = '",p_inbb214,"'",
                  "    AND EXISTS (SELECT 1",
                  "                  FROM rtax_t",
                  "                 WHERE rtaxent = imaaent",
                  "                   AND rtax001 = imaa009",
                  "                   AND rtaxstus = 'Y'",
                  "                 START WITH rtaxent = imaaent",
                  "                   AND rtax001 = '",g_inba_m.inba207,"'",
                  "               CONNECT BY NOCYCLE PRIOR rtax001 = rtax003",
                  "                   AND rtaxent = imaaent)"
      PREPARE aint911_inba207_cnt FROM l_sql
      EXECUTE aint911_inba207_cnt INTO l_cnt                
        
       IF l_cnt = 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = ''
          LET g_errparam.code   = 'ain-00680'
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF           
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 轉入商品帶出預設值
# Memo...........:
# Usage..........: CALL aint911_inbb214_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/11/17 By pomelo #151113-00020#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_inbb214_def()
DEFINE l_inbb200         LIKE inbb_t.inbb200
DEFINE l_rtdx034         LIKE rtdx_t.rtdx034
DEFINE l_success         LIKE type_t.num5

   CALL s_apmt840_get_rtdx(g_inba_m.inbasite,g_inbb_d[l_ac].inbb214)
      RETURNING l_inbb200,g_inbb_d[l_ac].inbb218 
   
   IF cl_null(g_inbb_d[l_ac].inbb213) THEN
      LET g_inbb_d[l_ac].inbb213 = l_inbb200
   END IF
   
   SELECT imaa104 INTO g_inbb_d[l_ac].inbb216
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_inbb_d[l_ac].inbb214
      
   #轉入包裝單位
   CALL s_desc_get_unit_desc(g_inbb_d[l_ac].inbb218)
      RETURNING g_inbb_d[l_ac].inbb218_desc
   
   #轉入單位
   CALL s_desc_get_unit_desc(g_inbb_d[l_ac].inbb216)
      RETURNING g_inbb_d[l_ac].inbb216_desc
      
   LET l_success = ''
   LET l_rtdx034 = ''
   CALL s_cost_rtdx(g_inba_m.inbasite,g_inbb_d[l_ac].inbb214,g_today,'')
      RETURNING l_success,l_rtdx034
   IF l_success THEN
      LET g_inbb_d[l_ac].inbb223 = l_rtdx034
   END IF
END FUNCTION

################################################################################
# Descriptions...: 轉入包裝單位與轉入單位數量轉換
# Memo...........:
# Usage..........: CALL aint911_turn_num_change(p_type)
#                :    RETURNING r_success
# Input parameter: p_type         1.轉入包裝單位轉轉入單位
#                                 2.轉入單位轉轉入包裝單位
# Return code....: r_success      True/False
# Date & Author..: 2015/11/17 By pomelo #151113-00020#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_turn_num_change(p_type)
DEFINE p_type            LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5

   LET r_success = TRUE
   
   CASE p_type
      WHEN 1
         IF NOT cl_null(g_inbb_d[l_ac].inbb216) AND NOT cl_null(g_inbb_d[l_ac].inbb218) AND NOT cl_null(g_inbb_d[l_ac].inbb219) THEN
            CALL s_aooi250_convert_qty(g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb218,g_inbb_d[l_ac].inbb216,g_inbb_d[l_ac].inbb219)
               RETURNING l_success,g_inbb_d[l_ac].inbb217
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF 
         END IF
         
      WHEN 2
         IF NOT cl_null(g_inbb_d[l_ac].inbb216) AND NOT cl_null(g_inbb_d[l_ac].inbb218) AND NOT cl_null(g_inbb_d[l_ac].inbb217) THEN
            CALL s_aooi250_convert_qty(g_inbb_d[l_ac].inbb214,g_inbb_d[l_ac].inbb216,g_inbb_d[l_ac].inbb218,g_inbb_d[l_ac].inbb217)
               RETURNING l_success,g_inbb_d[l_ac].inbb219
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF                                  
         END IF       
   END CASE
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION aint911_set_comp_visible_b()
   #20160108 add by beckxie---S
   CALL cl_set_comp_visible("inbb017,inbb211,inbb212",TRUE)
   #20160108 add by beckxie---E
   
   CALL cl_set_comp_visible("inbb205,inbb206,inbc204,inbc205",TRUE)   #160728-00018#1 20160729 add by beckxie
END FUNCTION

PRIVATE FUNCTION aint911_set_comp_no_visible_b()
   #20160108 add by beckxie---S
   #aint912 單頭有挑選來源類型有挑 11. 時, 單身隱藏  來源單號--lori
   IF g_argv[1]='2' AND g_inba_m.inba005 ='11' THEN 
       CALL cl_set_comp_visible("inbb017,inbb211,inbb212",FALSE)
   END IF
   #20160108 add by beckxie---E
   #160728-00018#1 20160729 add by beckxie---S
   #雜收單領用單價隱藏(雜收作業領用單價都隱藏，含多庫儲批明細) aint912 aint919
   IF g_argv[1]='2' OR g_argv[1]='9' THEN
      CALL cl_set_comp_visible("inbb205,inbb206,inbc204,inbc205",FALSE)
   END IF
   #160728-00018#1 20160729 add by beckxie---E
END FUNCTION

################################################################################
# Descriptions...: 如果aoos010参数E-CIR-0055设置为N，录入数量的时候，判断，不能大于库存数量
# Memo...........:
# Usage..........: CALL aint911_num_chk(p_inbb011,p_inag009)
#                  RETURNING r_success
# Input parameter: p_inbb011      領用數量
#                : p_inag009      庫存數量
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/07/25 By Ken      #160604-00009#140 Add By Ken 160725
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_num_chk(p_inbb011,p_inag009)
DEFINE p_inbb011        LIKE inbb_t.inbb011
DEFINE p_inag009        LIKE inag_t.inag009
DEFINE l_qty_sys        LIKE type_t.chr1        #雜項領用允許負庫存   
DEFINE r_success        LIKE type_t.num5

   CALL cl_get_para(g_enterprise,"","E-CIR-0055") RETURNING l_qty_sys 

   LET r_success = TRUE
   
   IF cl_null(p_inbb011) THEN
      LET p_inbb011 = 0
   END IF
   
   IF cl_null(p_inag009) THEN
      LET p_inag009 = 0
   END IF   
   
   IF l_qty_sys = 'N' AND (p_inbb011 > p_inag009 ) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00765'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_inbb011
      LET g_errparam.replace[2] = p_inag009     
      CALL cl_err()       
      LET r_success = FALSE
   END IF   
   
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 取得商品的庫存數量
# Memo...........:
# Usage..........: CALL aint911_get_inag008()
#                  RETURNING r_success,r_inag008
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
#                : r_inag008      庫存數量
# Date & Author..: 2016/7/25 By Ken     #160604-00009#140 Add By Ken 160725
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_get_inag008()
DEFINE l_inag001            LIKE inag_t.inag001
DEFINE l_inag002            LIKE inag_t.inag002
DEFINE l_inag003            LIKE inag_t.inag003
DEFINE l_inag004            LIKE inag_t.inag004
DEFINE l_inag005            LIKE inag_t.inag005
DEFINE l_inag006            LIKE inag_t.inag006
DEFINE l_inag007            LIKE inag_t.inag007
DEFINE l_unit               LIKE inag_t.inag007
DEFINE l_success            LIKE type_t.num5
DEFINE r_success            LIKE type_t.num5
DEFINE r_inag008            LIKE inag_t.inag008

   LET r_success = TRUE
   LET r_inag008 = 0
      
   #取庫存單位
   SELECT imaa104 INTO l_unit
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_inbb_d[l_ac].inbb001

   #產品特徵
   IF cl_null(g_inbb_d[l_ac].inbb002) THEN
      LET l_inag002 = ' '
   ELSE 
      LET l_inag002 = g_inbb_d[l_ac].inbb002
   END IF
   
   #庫存管理特徵
   IF cl_null(g_inbb_d[l_ac].inbb003) THEN
      LET l_inag003 = ' '
   ELSE 
      LET l_inag003 = g_inbb_d[l_ac].inbb003
   END IF   
   
   #庫位
   IF cl_null(g_inbb_d[l_ac].inbb007) THEN
      LET l_inag004 = ' '
   ELSE
      LET l_inag004 = g_inbb_d[l_ac].inbb007
   END IF
   
   #儲位
   IF cl_null(g_inbb_d[l_ac].inbb008) THEN
      LET l_inag005 = ' '
   ELSE
      LET l_inag005 = g_inbb_d[l_ac].inbb008
   END IF   
   
   #批號
   IF cl_null(g_inbb_d[l_ac].inbb009) THEN
      LET l_inag006 = ' '
   ELSE
      LET l_inag006 = g_inbb_d[l_ac].inbb009
   END IF      
   
   #單位
   IF cl_null(l_unit) THEN
      LET l_inag007 = ' '
   ELSE
      LET l_inag007 = l_unit
   END IF     
   
   SELECT SUM(inag008) INTO r_inag008
     FROM inag_t
    WHERE inagent = g_enterprise
      AND inag001 = g_inbb_d[l_ac].inbb001
      AND inag002 = l_inag002
      AND inag003 = l_inag003
      AND inag004 = l_inag004
      AND inag005 = l_inag005
      AND inag006 = l_inag006
      AND inag007 = l_inag007
   
   RETURN r_success,r_inag008
END FUNCTION

 
{</section>}
 
