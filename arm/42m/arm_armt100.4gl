#該程式未解開Section, 採用最新樣板產出!
{<section id="armt100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2017-02-23 16:56:26), PR版次:0014(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: armt100
#+ Description: RMA維護作業
#+ Creator....: 05423(2015-05-06 17:19:41)
#+ Modifier...: 05795 -SD/PR- 00000
 
{</section>}
 
{<section id="armt100.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160202-00019#1  2016-02-18 BY zhujing 1.单别增加两个参数：E-MFG-0009序号必输（Y/N）、E-MFG-0010序号与系统批序号勾稽（Y/N） 2.单身增加序号、生产日期、有效日期
#160318-00005#42 2016-03-24 BY pengxin 修正azzi920重复定义之错误讯息
#160318-00025#21 2016-04-19 BY 07900   校验代码重复错误讯息的修改
#160202-00019#7  2016-07-20 By zhujing 1.输入的序号对到多个项次时，出货单号开窗仅开出该序号的出货单号项次。
#                                      2.同时修改下“制造批号只关联了序号，要加一下出货单号的关联”这个问题，不然带出的批号不对
#                                      3.序号空白，直接输入出货单号时会弹窗输入批序号，弹窗输入完毕时，不会将序号自动带入序号栏位，应该为如果申请数量是1就自动带出序号栏位的值。。 如果申请数量大于1就不管
#160812-00017#1 16/08/15 By 06137    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#46 2016-08-22 By zhujing 删除修改未重新判断状态码
#160905-00007#14 2016/09/05 By 07900   调整系统中无ENT的SQL条件增加ent
#160816-00066#1  2016/11/10 By zhujing 1.参数E-MFG-0040=Y时，控制出货单号、项次必输
#                                        参数E-MFG-0040=N时，出货单号、项次可以空白，直接输入料号
#                                      2.整单操作增加action“整批点收”，仅单据已审核状态时可执行
#                                        点此action将库位（抓单别参数E-MFG-0041）、点收日期（g_today）、点收人员（g_user）更新至单身对应栏位
#                                      3.增加栏位保固日期、保固内（勾选项）
#                                        E-MFG-0040=Y时，依出货日期+imaf117+imaf118带出保固日期和保固内预设值
#                                        E-MFG-0040=N时，保固日期预设空白，保固内预设为N
#161124-00048#11  2016/12/19 By zhujing .*整批调整
#160824-00007#354 2017/01/09 By 06814    新舊值寫法調整
#170120-00054#1   2017/01/20 By zhujing  调整系统中无ENT的SQL条件增加ent
#160711-00040#28  2017/02/16 By xujing T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                      CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#170222-00004#1   2017/02/23 By dujuan  單身資料更新時，料件無批序號資料仍更新inao_t，出現錯誤而更新失敗
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
PRIVATE type type_g_rmaa_m        RECORD
       rmaadocno LIKE rmaa_t.rmaadocno, 
   rmaadocno_desc LIKE type_t.chr80, 
   rmaa001 LIKE rmaa_t.rmaa001, 
   rmaa001_desc LIKE type_t.chr80, 
   rmaasite LIKE rmaa_t.rmaasite, 
   rmaadocdt LIKE rmaa_t.rmaadocdt, 
   rmaa008 LIKE rmaa_t.rmaa008, 
   rmaa002 LIKE rmaa_t.rmaa002, 
   rmaa002_desc LIKE type_t.chr80, 
   rmaa003 LIKE rmaa_t.rmaa003, 
   rmaa003_desc LIKE type_t.chr80, 
   rmaastus LIKE rmaa_t.rmaastus, 
   rmaa004 LIKE rmaa_t.rmaa004, 
   rmaa005 LIKE rmaa_t.rmaa005, 
   rmaa006 LIKE rmaa_t.rmaa006, 
   rmaa007 LIKE rmaa_t.rmaa007, 
   rmaaownid LIKE rmaa_t.rmaaownid, 
   rmaaownid_desc LIKE type_t.chr80, 
   rmaaowndp LIKE rmaa_t.rmaaowndp, 
   rmaaowndp_desc LIKE type_t.chr80, 
   rmaacrtid LIKE rmaa_t.rmaacrtid, 
   rmaacrtid_desc LIKE type_t.chr80, 
   rmaacrtdp LIKE rmaa_t.rmaacrtdp, 
   rmaacrtdp_desc LIKE type_t.chr80, 
   rmaacrtdt LIKE rmaa_t.rmaacrtdt, 
   rmaamodid LIKE rmaa_t.rmaamodid, 
   rmaamodid_desc LIKE type_t.chr80, 
   rmaamoddt LIKE rmaa_t.rmaamoddt, 
   rmaacnfid LIKE rmaa_t.rmaacnfid, 
   rmaacnfid_desc LIKE type_t.chr80, 
   rmaacnfdt LIKE rmaa_t.rmaacnfdt, 
   rmaapstid LIKE rmaa_t.rmaapstid, 
   rmaapstid_desc LIKE type_t.chr80, 
   rmaapstdt LIKE rmaa_t.rmaapstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rmab_d        RECORD
       rmabseq LIKE rmab_t.rmabseq, 
   rmab018 LIKE rmab_t.rmab018, 
   rmab019 LIKE rmab_t.rmab019, 
   rmab020 LIKE rmab_t.rmab020, 
   rmab001 LIKE rmab_t.rmab001, 
   rmab002 LIKE rmab_t.rmab002, 
   rmab003 LIKE rmab_t.rmab003, 
   rmab004 LIKE rmab_t.rmab004, 
   rmab005 LIKE rmab_t.rmab005, 
   rmab006 LIKE rmab_t.rmab006, 
   rmab007 LIKE rmab_t.rmab007, 
   rmab008 LIKE rmab_t.rmab008, 
   rmab009 LIKE rmab_t.rmab009, 
   rmab009_desc LIKE type_t.chr500, 
   rmab009_desc_1 LIKE type_t.chr500, 
   rmab010 LIKE rmab_t.rmab010, 
   rmab010_desc LIKE type_t.chr500, 
   rmab011 LIKE rmab_t.rmab011, 
   rmab011_desc LIKE type_t.chr500, 
   rmab021 LIKE rmab_t.rmab021, 
   rmab022 LIKE rmab_t.rmab022, 
   rmab012 LIKE rmab_t.rmab012, 
   rmab013 LIKE rmab_t.rmab013, 
   rmab014 LIKE rmab_t.rmab014, 
   rmab015 LIKE rmab_t.rmab015, 
   rmab016 LIKE rmab_t.rmab016, 
   rmab017 LIKE rmab_t.rmab017, 
   rmabsite LIKE rmab_t.rmabsite
       END RECORD
PRIVATE TYPE type_g_rmab2_d RECORD
       rmacseq LIKE rmac_t.rmacseq, 
   rmacseq1 LIKE rmac_t.rmacseq1, 
   l_rmab009 LIKE type_t.chr500, 
   l_rmab009_desc LIKE type_t.chr500, 
   l_rmab009_desc_1 LIKE type_t.chr500, 
   l_rmab010 LIKE type_t.chr500, 
   l_rmab010_desc LIKE type_t.chr500, 
   l_rmab011 LIKE type_t.chr10, 
   l_rmab011_desc LIKE type_t.chr500, 
   rmac001 LIKE rmac_t.rmac001, 
   rmac002 LIKE rmac_t.rmac002, 
   rmac002_desc LIKE type_t.chr500, 
   rmac003 LIKE rmac_t.rmac003, 
   rmac003_desc LIKE type_t.chr500, 
   rmac004 LIKE rmac_t.rmac004, 
   rmac005 LIKE rmac_t.rmac005, 
   rmac006 LIKE rmac_t.rmac006, 
   rmac007 LIKE rmac_t.rmac007, 
   rmac007_desc LIKE type_t.chr500, 
   rmacsite LIKE rmac_t.rmacsite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rmaadocno LIKE rmaa_t.rmaadocno,
      b_rmaadocdt LIKE rmaa_t.rmaadocdt,
      b_rmaa002 LIKE rmaa_t.rmaa002,
   b_rmaa002_desc LIKE type_t.chr80,
      b_rmaa003 LIKE rmaa_t.rmaa003,
   b_rmaa003_desc LIKE type_t.chr80,
      b_rmaa001 LIKE rmaa_t.rmaa001,
   b_rmaa001_desc LIKE type_t.chr80,
      b_rmaa004 LIKE rmaa_t.rmaa004,
      b_rmaa005 LIKE rmaa_t.rmaa005,
      b_rmaa006 LIKE rmaa_t.rmaa006,
      b_rmaasite LIKE rmaa_t.rmaasite
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_open                LIKE type_t.chr2              #開啟退品點收維護
TYPE type_g_inao_d2        RECORD                          #2016-4-6 zhujing add--添加制造批序号
    inaoseq_1       LIKE inao_t.inaoseq,
    inaoseq1_1      LIKE inao_t.inaoseq1,
    inaoseq2_1      LIKE inao_t.inaoseq2,
    inao001_1       LIKE inao_t.inao001,
    inao001_1_desc  LIKE imaal_t.imaal003,
    inao001_1_desc2 LIKE imaal_t.imaal004,
    inao008_1       LIKE inao_t.inao008,
    inao009_1       LIKE inao_t.inao009,
    inao010_1       LIKE inao_t.inao010,
    inao012_1       LIKE inao_t.inao012
END RECORD 
DEFINE g_inao_d2         DYNAMIC ARRAY OF type_g_inao_d2
TYPE type_g_inao_d        RECORD
    inao000           LIKE inao_t.inao000, 
    inao013           LIKE inao_t.inao013, 
    inaodocno         LIKE inao_t.inaodocno, 
    inaoseq           LIKE inao_t.inaoseq, 
    inaoseq1          LIKE inao_t.inaoseq1, 
    inaoseq2          LIKE inao_t.inaoseq2, 
    inao001           LIKE inao_t.inao001, 
    inao001_desc      LIKE type_t.chr500,
    inao001_desc_desc LIKE type_t.chr500,
    inao008           LIKE inao_t.inao008, 
    inao009           LIKE inao_t.inao009, 
    inao012           LIKE inao_t.inao012, 
    inao010           LIKE inao_t.inao010,
    inao011           LIKE inao_t.inao011
                  END RECORD
DEFINE g_inao_d          DYNAMIC ARRAY OF type_g_inao_d    
DEFINE g_inao_d_t        type_g_inao_d
DEFINE g_rec_b3              LIKE type_t.num5 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_rmaa_m          type_g_rmaa_m
DEFINE g_rmaa_m_t        type_g_rmaa_m
DEFINE g_rmaa_m_o        type_g_rmaa_m
DEFINE g_rmaa_m_mask_o   type_g_rmaa_m #轉換遮罩前資料
DEFINE g_rmaa_m_mask_n   type_g_rmaa_m #轉換遮罩後資料
 
   DEFINE g_rmaadocno_t LIKE rmaa_t.rmaadocno
 
 
DEFINE g_rmab_d          DYNAMIC ARRAY OF type_g_rmab_d
DEFINE g_rmab_d_t        type_g_rmab_d
DEFINE g_rmab_d_o        type_g_rmab_d
DEFINE g_rmab_d_mask_o   DYNAMIC ARRAY OF type_g_rmab_d #轉換遮罩前資料
DEFINE g_rmab_d_mask_n   DYNAMIC ARRAY OF type_g_rmab_d #轉換遮罩後資料
DEFINE g_rmab2_d          DYNAMIC ARRAY OF type_g_rmab2_d
DEFINE g_rmab2_d_t        type_g_rmab2_d
DEFINE g_rmab2_d_o        type_g_rmab2_d
DEFINE g_rmab2_d_mask_o   DYNAMIC ARRAY OF type_g_rmab2_d #轉換遮罩前資料
DEFINE g_rmab2_d_mask_n   DYNAMIC ARRAY OF type_g_rmab2_d #轉換遮罩後資料
 
 
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
 
{<section id="armt100.main" >}
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
   LET g_forupd_sql = " SELECT rmaadocno,'',rmaa001,'',rmaasite,rmaadocdt,rmaa008,rmaa002,'',rmaa003, 
       '',rmaastus,rmaa004,rmaa005,rmaa006,rmaa007,rmaaownid,'',rmaaowndp,'',rmaacrtid,'',rmaacrtdp, 
       '',rmaacrtdt,rmaamodid,'',rmaamoddt,rmaacnfid,'',rmaacnfdt,rmaapstid,'',rmaapstdt", 
                      " FROM rmaa_t",
                      " WHERE rmaaent= ? AND rmaadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rmaadocno,t0.rmaa001,t0.rmaasite,t0.rmaadocdt,t0.rmaa008,t0.rmaa002, 
       t0.rmaa003,t0.rmaastus,t0.rmaa004,t0.rmaa005,t0.rmaa006,t0.rmaa007,t0.rmaaownid,t0.rmaaowndp, 
       t0.rmaacrtid,t0.rmaacrtdp,t0.rmaacrtdt,t0.rmaamodid,t0.rmaamoddt,t0.rmaacnfid,t0.rmaacnfdt,t0.rmaapstid, 
       t0.rmaapstdt,t1.pmaal004 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 , 
       t8.ooag011 ,t9.ooag011 ,t10.ooag011",
               " FROM rmaa_t t0",
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.rmaa001 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rmaa002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rmaa003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.rmaaownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.rmaaowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.rmaacrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.rmaacrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.rmaamodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.rmaacnfid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.rmaapstid  ",
 
               " WHERE t0.rmaaent = " ||g_enterprise|| " AND t0.rmaadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE armt100_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_armt100 WITH FORM cl_ap_formpath("arm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL armt100_init()   
 
      #進入選單 Menu (="N")
      CALL armt100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_lot_ins_drop_tmp()     #160816-00066#1 add
      CALL s_lot_sel_drop_tmp()     #160202-00019#1
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_armt100
      
   END IF 
   
   CLOSE armt100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="armt100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION armt100_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('rmaastus','13','N,Y,S,Z,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("rmab010,rmab010_desc,l_rmab010,l_rmab010_desc",FALSE)
   END IF
   CALL cl_set_comp_entry("rmacseq1,rmac001,rmac002,rmac003,rmac004,rmac005,rmac006,rmac007",FALSE)
   #2016-4-6 zhujing add---(S)
   CALL cl_ui_replace_sub_window(cl_ap_formpath("sub", "s_lot_s01"), "grid_s_lot", "Table", "s_detail1_s_lot_s01")
   CALL s_lot_ins_create_tmp()
   CALL s_lot_sel_create_tmp()
   CALL cl_set_toolbaritem_visible("s_lot_sel",TRUE)
   CALL cl_set_toolbaritem_visible("s_lot_ins",TRUE)  #160816-00066#1 add
   #2016-4-6 zhujing add---(E)
   #end add-point
   
   #初始化搜尋條件
   CALL armt100_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="armt100.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION armt100_ui_dialog()
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
   DEFINE l_success        LIKE type_t.num5  #2016-4-6 zhujing add
   DEFINE l_flag1                LIKE type_t.num5           #160816-00066#1 add
   DEFINE l_ooac002              LIKE ooac_t.ooac002        #160816-00066#1 add
   DEFINE l_amount               LIKE rmab_t.rmab012        #160816-00066#1 add
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
            CALL armt100_insert()
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
         INITIALIZE g_rmaa_m.* TO NULL
         CALL g_rmab_d.clear()
         CALL g_rmab2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL armt100_init()
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
               
               CALL armt100_fetch('') # reload data
               LET l_ac = 1
               CALL armt100_ui_detailshow() #Setting the current row 
         
               CALL armt100_idx_chk()
               #NEXT FIELD rmabseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rmab_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL armt100_idx_chk()
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
               CALL armt100_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               #160816-00066#1 add-S
               CALL armt100_set_act_visible()
               CALL armt100_set_act_no_visible()
               CALL armt100_set_act_visible_b()
               CALL armt100_set_act_no_visible_b()
#               IF NOT cl_null(g_rmaa_m.rmaadocno) THEN
#                  CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_flag1,l_ooac002
#                  #若不与出货单勾稽，则手动录入制造批序号资料
#                  IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'Y' THEN     
#                     CALL cl_set_act_visible("s_lot_ins",FALSE)
#                     CALL cl_set_act_visible("s_lot_sel,s_lot_sel1",TRUE)
#                  ELSE
#                     CALL cl_set_act_visible("s_lot_ins,s_lot_sel",TRUE)
#                     CALL cl_set_act_visible("s_lot_sel1",FALSE)
#                  END IF
#               END IF
               #160816-00066#1 add-E
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel1
            LET g_action_choice="s_lot_sel1"
            IF cl_auth_chk_act("s_lot_sel1") THEN
               
               #add-point:ON ACTION s_lot_sel1 name="menu.detail_show.page1.s_lot_sel1"
               #160202-00019#1 zhujing add 申请资料
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'      #单身缺少资料，不可维护！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
#               
#               IF g_rmaa_m.rmaastus <> 'N' THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'apm-00035'
#                  LET g_errparam.extend = ""
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  EXIT DIALOG
#               END IF
               
               IF g_rmab_d[g_detail_idx].rmab018 IS NOT NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'arm-00054'      #该资料已自动产生制造批序号资料，不可执行该动作！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               
                
               IF NOT cl_null(g_rmaa_m.rmaadocno) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmabseq) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab009) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab011) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab012) AND
                  NOT cl_null(g_rmaa_m.rmaa002) THEN
                  LET l_success = ''
                  IF s_lot_batch_number_1n3(g_rmab_d[l_ac].rmab009,g_site) THEN
                     CALL s_transaction_begin()
#                     CALL s_axmt540_inao_copy(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'2','','','','',g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,g_rmab2_d[g_detail_idx].rmacseq1,'1','N','1') RETURNING l_success                                    
                     IF armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'0') THEN
                        #160816-00066#1 mod-S   
#                        CALL s_lot_sel('2','1',g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab2_d[g_detail_idx].rmac005,
#                                       g_rmab2_d[g_detail_idx].rmac002,g_rmab2_d[g_detail_idx].rmac003,g_rmab2_d[g_detail_idx].rmac004,g_rmab_d[g_detail_idx].rmab011,g_rmab_d[g_detail_idx].rmab012,'1','armt100','',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'',1)
#                           RETURNING l_success  
                        CALL s_lot_sel('2','1',g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab2_d[1].rmac005,
                                       g_rmab2_d[1].rmac002,g_rmab2_d[1].rmac003,g_rmab2_d[1].rmac004,g_rmab_d[g_detail_idx].rmab011,g_rmab_d[g_detail_idx].rmab012,'1','armt100','',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'',1)
                           RETURNING l_success   
                        #160816-00066#1 mod-E 
                                                
#                        IF l_success THEN   #2016-5-13 zhujing mod
                        CALL armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'1') RETURNING l_success  
                        #160202-00019#7 add-S 若只有一个申请数量，则显示序号到栏位中
                        IF g_rmab_d[l_ac].rmab012 = '1' THEN
                           CALL armt100_get_inao009(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq) RETURNING g_rmab_d[g_detail_idx].rmab018,g_rmab_d[g_detail_idx].rmab019,g_rmab_d[g_detail_idx].rmab020
                        END IF
                        #160202-00019#7 add-E
#                        END IF
                     END IF
#                     #刪除申請資料                              
#                     DELETE FROM inao_t 
#                      WHERE inaoent = g_enterprise 
#                        AND inaosite = g_site
#                        AND inaodocno = g_rmaa_m.rmaadocno
#                        AND inaoseq = g_rmab_d[g_detail_idx].rmabseq
#                        AND inaoseq1 = g_rmab2_d[g_detail_idx].rmacseq1
#                        AND inao000 = '1'
#                        AND inao013 = '1'
                        
                     IF l_success THEN
                        CALL s_transaction_end('Y','0')
                        IF NOT armt100_ins_inao_2(g_rmab_d[g_detail_idx].rmabseq) THEN
                           NEXT FIELD CURRENT
                        END IF
                        CALL armt100_inao_fill2() 
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                     IF NOT cl_null(g_rmaa_m.rmaadocno) THEN
                        CALL s_lot_b_fill('1',g_site,'1',g_rmaa_m.rmaadocno,'','','1')
                     END IF    
                  END IF
                  LET g_current_row = g_current_idx #目前指標  
               END IF
               #160202-00019#1 zhujing add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_ins
            LET g_action_choice="s_lot_ins"
            IF cl_auth_chk_act("s_lot_ins") THEN
               
               #add-point:ON ACTION s_lot_ins name="menu.detail_show.page1.s_lot_ins"
               #160816-00066#1 add-S   
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'         #单身缺少资料，不可维护！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF g_rmab_d[g_detail_idx].rmab018 IS NOT NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'arm-00054'      #该资料已自动产生制造批序号资料，不可执行该动作！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
                
               IF NOT cl_null(g_rmaa_m.rmaadocno) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmabseq) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab009) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab011) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab012) AND
                  NOT cl_null(g_rmaa_m.rmaa002) THEN
                  LET l_success = ''
                  LET l_amount = ''
                  IF s_lot_batch_number_1n3(g_rmab_d[g_detail_idx].rmab009,g_site) THEN
                     CALL s_transaction_begin()
                     CALL s_lot_ins(g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab_d[g_detail_idx].rmab011,g_rmab_d[g_detail_idx].rmab012,'1',g_rmaa_m.rmaa002,'1','',
                                    g_rmab2_d[1].rmac002,g_rmab2_d[1].rmac003,g_rmab2_d[1].rmac004,g_rmab2_d[g_detail_idx].rmac005)
                          RETURNING l_success,l_amount
                     IF l_success THEN
                        IF NOT armt100_ins_inao_2(g_rmab_d[g_detail_idx].rmabseq) THEN
                           CALL s_transaction_end('N','0')   
                           EXIT DIALOG
                        END IF
                        IF g_rmab_d[g_detail_idx].rmab012 <> l_amount THEN
                           IF cl_ask_confirm('ain-00249') THEN    #该笔资料的数量与制造批序号总数不同，是否更新资料数量为序号总数？
                               
                              UPDATE rmab_t SET rmab012 = l_amount,
                                                inbb013 = l_amount
                               WHERE rmabent = g_enterprise AND rmabsite = g_site
                                 AND rmabdocno = g_rmaa_m.rmaadocno AND rmabseq = g_rmab_d[g_detail_idx].rmabseq
                              IF SQLCA.sqlcode THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = SQLCA.sqlcode
                                 LET g_errparam.extend = "rmab_t"
                                 LET g_errparam.popup = FALSE
                                 CALL cl_err()
                              ELSE
                                 LET g_rmab_d[g_detail_idx].rmab012 = l_amount
                                 LET g_rmab_d[g_detail_idx].rmab013 = l_amount
                                 UPDATE rmac_t SET rmac001 = l_amount
                                  WHERE rmacent = g_enterprise AND rmacsite = g_site
                                    AND rmacdocno = g_rmaa_m.rmaadocno AND rmacseq = g_rmab_d[g_detail_idx].rmabseq  
                                    AND rmacseq1 = 1
                                 IF SQLCA.sqlcode THEN
                                    INITIALIZE g_errparam TO NULL
                                    LET g_errparam.code = SQLCA.sqlcode
                                    LET g_errparam.extend = "rmac_t"
                                    LET g_errparam.popup = FALSE
                                    CALL cl_err()
                                 ELSE
                                    DELETE FROM rmac_t 
                                     WHERE rmacent = g_enterprise AND rmacsite = g_site
                                       AND rmacdocno = g_rmaa_m.rmaadocno AND rmacseq = g_rmab_d[g_detail_idx].rmabseq  
                                       AND rmacseq1 <> 1
                                    IF SQLCA.sqlcode THEN
                                       INITIALIZE g_errparam TO NULL
                                       LET g_errparam.code = SQLCA.sqlcode
                                       LET g_errparam.extend = "rmab_t"
                                       LET g_errparam.popup = FALSE
                                       CALL cl_err()
                                    ELSE
                                       LET g_rmab2_d[1].rmac001 = l_amount    
                                    END IF
                                 END IF
                              END IF
                           END IF
                        END IF
                        CALL armt100_inao_fill2()        
                        CALL s_transaction_end('Y','0')  
                     ELSE
                        CALL s_transaction_end('N','0')   
                     END IF
                  END IF
               END IF
               #160816-00066#1 add-E
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_rmab2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL armt100_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               CALL armt100_b_fill2('2')
               #160816-00066#1 add-S
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               #160816-00066#1 add-E
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
               CALL armt100_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               #160816-00066#1 add-S
               CALL armt100_set_act_visible()
               CALL armt100_set_act_no_visible()
               CALL armt100_set_act_visible_b()
               CALL armt100_set_act_no_visible_b()
               #160816-00066#1 add-E
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel
            LET g_action_choice="s_lot_sel"
            IF cl_auth_chk_act("s_lot_sel") THEN
               
               #add-point:ON ACTION s_lot_sel name="menu.detail_show.page2.s_lot_sel"
               #160202-00019#1 zhujing add 申请资料
               IF cl_null(g_detail_idx2) OR g_detail_idx2 = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               
               IF g_rmaa_m.rmaastus <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00035'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               
               IF g_rmab_d[g_detail_idx].rmab018 IS NOT NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'arm-00054'      #该资料已自动产生制造批序号资料，不可执行该动作！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               
                
               IF NOT cl_null(g_rmaa_m.rmaadocno) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmabseq) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab009) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab011) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab012) AND
                  NOT cl_null(g_rmaa_m.rmaa002) THEN
                  LET l_success = ''
                  IF s_lot_batch_number_1n3(g_rmab_d[g_detail_idx].rmab009,g_site) THEN
                     CALL s_transaction_begin()
                     IF armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'2') THEN
                        #160816-00066#1 mod-S
#                        CALL s_lot_sel('2','2',g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab2_d[g_detail_idx].rmac005,
#                                      g_rmab2_d[g_detail_idx].rmac002,g_rmab2_d[g_detail_idx].rmac003,g_rmab2_d[g_detail_idx].rmac004,g_rmab_d[g_detail_idx].rmab011,g_rmab2_d[g_detail_idx].rmac001,'1','armt100','','','','',0)
                        CALL s_lot_sel('2','2',g_site,g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx].rmacseq,g_rmab2_d[g_detail_idx].rmacseq1,g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab2_d[g_detail_idx2].rmac005,
                                      g_rmab2_d[g_detail_idx2].rmac002,g_rmab2_d[g_detail_idx2].rmac003,g_rmab2_d[g_detail_idx2].rmac004,g_rmab_d[g_detail_idx2].rmab011,g_rmab2_d[g_detail_idx2].rmac001,'1','armt100','','','','',0)
                           RETURNING l_success                              
                        #160816-00066#1 mod-E
                        IF l_success THEN   #2016-5-13 zhujing mod 
                           CALL armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'3') RETURNING l_success
                           IF NOT armt100_ins_inao_2(g_rmab_d[g_detail_idx].rmabseq) THEN
                              NEXT FIELD CURRENT
                           END IF
                           CALL armt100_inao_fill2() 
                        ELSE
                           CALL armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'3') RETURNING l_success
                        END IF
                     END IF
#                     #刪除申請資料                              
#                     DELETE FROM inao_t 
#                      WHERE inaoent = g_enterprise 
#                        AND inaosite = g_site
#                        AND inaodocno = g_rmaa_m.rmaadocno
#                        AND inaoseq = g_rmab_d[g_detail_idx].rmabseq
#                        AND inaoseq1 = g_rmab2_d[g_detail_idx].rmacseq1
#                        AND inao000 = '1'
#                        AND inao013 = '1'
                        
                     IF l_success THEN
                        CALL s_transaction_end('Y','0')
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                     IF NOT cl_null(g_rmaa_m.rmaadocno) THEN
                        CALL s_lot_b_fill('1',g_site,'2',g_rmaa_m.rmaadocno,'','','1')
                     END IF
                  END IF
                  LET g_current_row = g_current_idx #目前指標  
               END IF
               #160202-00019#1 zhujing add
               #END add-point
               
            END IF
 
 
 
 
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_inao_d2 TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) #page4   #160202-00019#1 zhujing add
    
            BEFORE ROW
               CALL armt100_idx_chk()
            #   LET l_ac4 = DIALOG.getCurrentRow("s_detail3")
            #   LET g_detail_idx = l_ac4
            #   

            BEFORE DISPLAY
               CALL armt100_idx_chk()
            #   CALL FGL_SET_ARR_CURR(g_detail_idx)
            #   LET l_ac4 = DIALOG.getCurrentRow("s_detail3")
               CALL cl_set_act_visible("s_lot_ins,s_lot_sel,s_lot_sel1",FALSE)
               LET g_current_page = 3
 
         END DISPLAY         
         
         SUBDIALOG sub_s_lot.s_lot_display      #160202-00019#1 zhujing add
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL armt100_browser_fill("")
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
               CALL armt100_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL armt100_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL armt100_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL armt100_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL armt100_set_act_visible()   
            CALL armt100_set_act_no_visible()
            IF NOT (g_rmaa_m.rmaadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rmaaent = " ||g_enterprise|| " AND",
                                  " rmaadocno = '", g_rmaa_m.rmaadocno, "' "
 
               #填到對應位置
               CALL armt100_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "rmaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmab_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmac_t" 
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
               CALL armt100_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "rmaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmab_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmac_t" 
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
                  CALL armt100_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL armt100_fetch("F")
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
               CALL armt100_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL armt100_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt100_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL armt100_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt100_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL armt100_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt100_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL armt100_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt100_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL armt100_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt100_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_rmab_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_rmab2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #2016-4-11 zhujing add
                  LET g_export_node[3] = base.typeInfo.create(g_inao_d)
                  LET g_export_id[3]   = "s_detail1_s_lot_s01"            
                  LET g_export_node[4] = base.typeInfo.create(g_inao_d2)
                  LET g_export_id[4]   = "s_detail3"               
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
               NEXT FIELD rmabseq
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
               CALL armt100_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL armt100_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION count_batch
            LET g_action_choice="count_batch"
            IF cl_auth_chk_act("count_batch") THEN
               
               #add-point:ON ACTION count_batch name="menu.count_batch"
               #160816-00066#1 add-S
               CALL armt100_count_batch()
               CALL armt100_show()
               #160816-00066#1 add-E
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL armt100_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL armt100_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " rmaadocno = '",g_rmaa_m.rmaadocno,"' AND rmaaent = ",g_enterprise," AND rmaasite = '",g_site,"' "
               #END add-point
               &include "erp/arm/armt100_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " rmaadocno = '",g_rmaa_m.rmaadocno,"' AND rmaaent = ",g_enterprise," AND rmaasite = '",g_site,"' "
               #END add-point
               &include "erp/arm/armt100_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL armt100_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION count
            LET g_action_choice="count"
            IF cl_auth_chk_act("count") THEN
               
               #add-point:ON ACTION count name="menu.count"
               LET g_open = 'Y'
               CALL armt100_rmac001_upd()
               LET g_open = 'N'
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL armt100_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_rmaa002
            LET g_action_choice="prog_rmaa002"
            IF cl_auth_chk_act("prog_rmaa002") THEN
               
               #add-point:ON ACTION prog_rmaa002 name="menu.prog_rmaa002"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_rmaa_m.rmaa002)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_rmaa005
            LET g_action_choice="prog_rmaa005"
            IF cl_auth_chk_act("prog_rmaa005") THEN
               
               #add-point:ON ACTION prog_rmaa005 name="menu.prog_rmaa005"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
#               INITIALIZE la_param.* TO NULL
#               LET la_param.prog     = 'axmt540'
#               LET la_param.param[1] = g_rmaa_m.rmaa005
#
#               LET ls_js = util.JSON.stringify(la_param)
#               CALL cl_cmdrun_wait(ls_js)
               CALL armt100_qrystr(g_rmaa_m.rmaa005)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_rmaa006
            LET g_action_choice="prog_rmaa006"
            IF cl_auth_chk_act("prog_rmaa006") THEN
               
               #add-point:ON ACTION prog_rmaa006 name="menu.prog_rmaa006"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
#               INITIALIZE la_param.* TO NULL
#               LET la_param.prog     = 'axmt500'
#               LET la_param.param[1] = g_rmaa_m.rmaa006
#
#               LET ls_js = util.JSON.stringify(la_param)
#               CALL cl_cmdrun_wait(ls_js)
               CALL armt100_qrystr(g_rmaa_m.rmaa006)


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL armt100_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL armt100_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL armt100_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rmaa_m.rmaadocdt)
 
 
 
         
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
 
{<section id="armt100.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION armt100_browser_fill(ps_page_action)
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
   IF cl_null(g_wc) THEN
      LET g_wc = " rmaasite = '",g_site,"' "
   ELSE
      LET g_wc = g_wc," AND rmaasite = '",g_site,"' "
   END IF
   
   LET l_wc  = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT rmaadocno ",
                      " FROM rmaa_t ",
                      " ",
                      " LEFT JOIN rmab_t ON rmabent = rmaaent AND rmaadocno = rmabdocno ", "  ",
                      #add-point:browser_fill段sql(rmab_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN rmac_t ON rmacent = rmaaent AND rmaadocno = rmacdocno", "  ",
                      #add-point:browser_fill段sql(rmac_t1) name="browser_fill.cnt.join.rmac_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE rmaaent = " ||g_enterprise|| " AND rmabent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rmaa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rmaadocno ",
                      " FROM rmaa_t ", 
                      "  ",
                      "  ",
                      " WHERE rmaaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rmaa_t")
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
      INITIALIZE g_rmaa_m.* TO NULL
      CALL g_rmab_d.clear()        
      CALL g_rmab2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rmaadocno,t0.rmaadocdt,t0.rmaa002,t0.rmaa003,t0.rmaa001,t0.rmaa004,t0.rmaa005,t0.rmaa006,t0.rmaasite Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rmaastus,t0.rmaadocno,t0.rmaadocdt,t0.rmaa002,t0.rmaa003,t0.rmaa001, 
          t0.rmaa004,t0.rmaa005,t0.rmaa006,t0.rmaasite,t1.ooag011 ,t2.ooefl003 ,t3.pmaal003 ",
                  " FROM rmaa_t t0",
                  "  ",
                  "  LEFT JOIN rmab_t ON rmabent = rmaaent AND rmaadocno = rmabdocno ", "  ", 
                  #add-point:browser_fill段sql(rmab_t1) name="browser_fill.join.rmab_t1"
                  
                  #end add-point
                  "  LEFT JOIN rmac_t ON rmacent = rmaaent AND rmaadocno = rmacdocno", "  ", 
                  #add-point:browser_fill段sql(rmac_t1) name="browser_fill.join.rmac_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.rmaa002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.rmaa003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.rmaa001 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.rmaaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rmaa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rmaastus,t0.rmaadocno,t0.rmaadocdt,t0.rmaa002,t0.rmaa003,t0.rmaa001, 
          t0.rmaa004,t0.rmaa005,t0.rmaa006,t0.rmaasite,t1.ooag011 ,t2.ooefl003 ,t3.pmaal003 ",
                  " FROM rmaa_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.rmaa002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.rmaa003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.rmaa001 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.rmaaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rmaa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY rmaadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rmaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rmaadocno,g_browser[g_cnt].b_rmaadocdt, 
          g_browser[g_cnt].b_rmaa002,g_browser[g_cnt].b_rmaa003,g_browser[g_cnt].b_rmaa001,g_browser[g_cnt].b_rmaa004, 
          g_browser[g_cnt].b_rmaa005,g_browser[g_cnt].b_rmaa006,g_browser[g_cnt].b_rmaasite,g_browser[g_cnt].b_rmaa002_desc, 
          g_browser[g_cnt].b_rmaa003_desc,g_browser[g_cnt].b_rmaa001_desc
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
         CALL armt100_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_rmaadocno) THEN
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
   #160816-00066#1 add-S
   CALL armt100_set_act_visible()
   CALL armt100_set_act_no_visible()
   CALL armt100_set_act_visible_b()
   CALL armt100_set_act_no_visible_b()
   #160816-00066#1 add-E
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="armt100.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION armt100_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rmaa_m.rmaadocno = g_browser[g_current_idx].b_rmaadocno   
 
   EXECUTE armt100_master_referesh USING g_rmaa_m.rmaadocno INTO g_rmaa_m.rmaadocno,g_rmaa_m.rmaa001, 
       g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaastus, 
       g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaowndp, 
       g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt, 
       g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstdt,g_rmaa_m.rmaa001_desc, 
       g_rmaa_m.rmaa002_desc,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp_desc,g_rmaa_m.rmaacrtid_desc, 
       g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaacnfid_desc,g_rmaa_m.rmaapstid_desc 
 
   
   CALL armt100_rmaa_t_mask()
   CALL armt100_show()
      
END FUNCTION
 
{</section>}
 
{<section id="armt100.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION armt100_ui_detailshow()
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
 
{<section id="armt100.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION armt100_ui_browser_refresh()
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
      IF g_browser[l_i].b_rmaadocno = g_rmaa_m.rmaadocno 
 
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
 
{<section id="armt100.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION armt100_construct()
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
   INITIALIZE g_rmaa_m.* TO NULL
   CALL g_rmab_d.clear()        
   CALL g_rmab2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON rmaadocno,rmaa001,rmaasite,rmaadocdt,rmaa008,rmaa002,rmaa003,rmaastus, 
          rmaa004,rmaa005,rmaa006,rmaa007,rmaaownid,rmaaowndp,rmaacrtid,rmaacrtdp,rmaacrtdt,rmaamodid, 
          rmaamoddt,rmaacnfid,rmaacnfdt,rmaapstid,rmaapstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rmaacrtdt>>----
         AFTER FIELD rmaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rmaamoddt>>----
         AFTER FIELD rmaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rmaacnfdt>>----
         AFTER FIELD rmaacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rmaapstdt>>----
         AFTER FIELD rmaapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rmaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaadocno
            #add-point:ON ACTION controlp INFIELD rmaadocno name="construct.c.rmaadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmaadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaadocno  #顯示到畫面上
            NEXT FIELD rmaadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaadocno
            #add-point:BEFORE FIELD rmaadocno name="construct.b.rmaadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaadocno
            
            #add-point:AFTER FIELD rmaadocno name="construct.a.rmaadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa001
            #add-point:ON ACTION controlp INFIELD rmaa001 name="construct.c.rmaa001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaa001  #顯示到畫面上
            NEXT FIELD rmaa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa001
            #add-point:BEFORE FIELD rmaa001 name="construct.b.rmaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa001
            
            #add-point:AFTER FIELD rmaa001 name="construct.a.rmaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaasite
            #add-point:BEFORE FIELD rmaasite name="construct.b.rmaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaasite
            
            #add-point:AFTER FIELD rmaasite name="construct.a.rmaasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaasite
            #add-point:ON ACTION controlp INFIELD rmaasite name="construct.c.rmaasite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaadocdt
            #add-point:BEFORE FIELD rmaadocdt name="construct.b.rmaadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaadocdt
            
            #add-point:AFTER FIELD rmaadocdt name="construct.a.rmaadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaadocdt
            #add-point:ON ACTION controlp INFIELD rmaadocdt name="construct.c.rmaadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa008
            #add-point:BEFORE FIELD rmaa008 name="construct.b.rmaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa008
            
            #add-point:AFTER FIELD rmaa008 name="construct.a.rmaa008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa008
            #add-point:ON ACTION controlp INFIELD rmaa008 name="construct.c.rmaa008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa002
            #add-point:ON ACTION controlp INFIELD rmaa002 name="construct.c.rmaa002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaa002  #顯示到畫面上
            NEXT FIELD rmaa002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa002
            #add-point:BEFORE FIELD rmaa002 name="construct.b.rmaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa002
            
            #add-point:AFTER FIELD rmaa002 name="construct.a.rmaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa003
            #add-point:ON ACTION controlp INFIELD rmaa003 name="construct.c.rmaa003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaa003  #顯示到畫面上
            NEXT FIELD rmaa003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa003
            #add-point:BEFORE FIELD rmaa003 name="construct.b.rmaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa003
            
            #add-point:AFTER FIELD rmaa003 name="construct.a.rmaa003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaastus
            #add-point:BEFORE FIELD rmaastus name="construct.b.rmaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaastus
            
            #add-point:AFTER FIELD rmaastus name="construct.a.rmaastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaastus
            #add-point:ON ACTION controlp INFIELD rmaastus name="construct.c.rmaastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmaa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa004
            #add-point:ON ACTION controlp INFIELD rmaa004 name="construct.c.rmaa004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmfodocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaa004  #顯示到畫面上
            NEXT FIELD rmaa004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa004
            #add-point:BEFORE FIELD rmaa004 name="construct.b.rmaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa004
            
            #add-point:AFTER FIELD rmaa004 name="construct.a.rmaa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa005
            #add-point:ON ACTION controlp INFIELD rmaa005 name="construct.c.rmaa005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdkdocno_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaa005  #顯示到畫面上
            NEXT FIELD rmaa005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa005
            #add-point:BEFORE FIELD rmaa005 name="construct.b.rmaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa005
            
            #add-point:AFTER FIELD rmaa005 name="construct.a.rmaa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa006
            #add-point:ON ACTION controlp INFIELD rmaa006 name="construct.c.rmaa006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xmdasite = '",g_site,"' " 
            CALL q_xmdadocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaa006  #顯示到畫面上
            NEXT FIELD rmaa006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa006
            #add-point:BEFORE FIELD rmaa006 name="construct.b.rmaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa006
            
            #add-point:AFTER FIELD rmaa006 name="construct.a.rmaa006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa007
            #add-point:BEFORE FIELD rmaa007 name="construct.b.rmaa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa007
            
            #add-point:AFTER FIELD rmaa007 name="construct.a.rmaa007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa007
            #add-point:ON ACTION controlp INFIELD rmaa007 name="construct.c.rmaa007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaaownid
            #add-point:ON ACTION controlp INFIELD rmaaownid name="construct.c.rmaaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaaownid  #顯示到畫面上
            NEXT FIELD rmaaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaaownid
            #add-point:BEFORE FIELD rmaaownid name="construct.b.rmaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaaownid
            
            #add-point:AFTER FIELD rmaaownid name="construct.a.rmaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaaowndp
            #add-point:ON ACTION controlp INFIELD rmaaowndp name="construct.c.rmaaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaaowndp  #顯示到畫面上
            NEXT FIELD rmaaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaaowndp
            #add-point:BEFORE FIELD rmaaowndp name="construct.b.rmaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaaowndp
            
            #add-point:AFTER FIELD rmaaowndp name="construct.a.rmaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaacrtid
            #add-point:ON ACTION controlp INFIELD rmaacrtid name="construct.c.rmaacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaacrtid  #顯示到畫面上
            NEXT FIELD rmaacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaacrtid
            #add-point:BEFORE FIELD rmaacrtid name="construct.b.rmaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaacrtid
            
            #add-point:AFTER FIELD rmaacrtid name="construct.a.rmaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaacrtdp
            #add-point:ON ACTION controlp INFIELD rmaacrtdp name="construct.c.rmaacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaacrtdp  #顯示到畫面上
            NEXT FIELD rmaacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaacrtdp
            #add-point:BEFORE FIELD rmaacrtdp name="construct.b.rmaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaacrtdp
            
            #add-point:AFTER FIELD rmaacrtdp name="construct.a.rmaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaacrtdt
            #add-point:BEFORE FIELD rmaacrtdt name="construct.b.rmaacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaamodid
            #add-point:ON ACTION controlp INFIELD rmaamodid name="construct.c.rmaamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaamodid  #顯示到畫面上
            NEXT FIELD rmaamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaamodid
            #add-point:BEFORE FIELD rmaamodid name="construct.b.rmaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaamodid
            
            #add-point:AFTER FIELD rmaamodid name="construct.a.rmaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaamoddt
            #add-point:BEFORE FIELD rmaamoddt name="construct.b.rmaamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmaacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaacnfid
            #add-point:ON ACTION controlp INFIELD rmaacnfid name="construct.c.rmaacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaacnfid  #顯示到畫面上
            NEXT FIELD rmaacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaacnfid
            #add-point:BEFORE FIELD rmaacnfid name="construct.b.rmaacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaacnfid
            
            #add-point:AFTER FIELD rmaacnfid name="construct.a.rmaacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaacnfdt
            #add-point:BEFORE FIELD rmaacnfdt name="construct.b.rmaacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmaapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaapstid
            #add-point:ON ACTION controlp INFIELD rmaapstid name="construct.c.rmaapstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmaapstid  #顯示到畫面上
            NEXT FIELD rmaapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaapstid
            #add-point:BEFORE FIELD rmaapstid name="construct.b.rmaapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaapstid
            
            #add-point:AFTER FIELD rmaapstid name="construct.a.rmaapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaapstdt
            #add-point:BEFORE FIELD rmaapstdt name="construct.b.rmaapstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rmabseq,rmab018,rmab019,rmab020,rmab001,rmab002,rmab003,rmab004,rmab005, 
          rmab006,rmab007,rmab008,rmab009,rmab010,rmab011,rmab021,rmab022,rmab012,rmab013,rmab014,rmab015, 
          rmab016,rmab017,rmabsite
           FROM s_detail1[1].rmabseq,s_detail1[1].rmab018,s_detail1[1].rmab019,s_detail1[1].rmab020, 
               s_detail1[1].rmab001,s_detail1[1].rmab002,s_detail1[1].rmab003,s_detail1[1].rmab004,s_detail1[1].rmab005, 
               s_detail1[1].rmab006,s_detail1[1].rmab007,s_detail1[1].rmab008,s_detail1[1].rmab009,s_detail1[1].rmab010, 
               s_detail1[1].rmab011,s_detail1[1].rmab021,s_detail1[1].rmab022,s_detail1[1].rmab012,s_detail1[1].rmab013, 
               s_detail1[1].rmab014,s_detail1[1].rmab015,s_detail1[1].rmab016,s_detail1[1].rmab017,s_detail1[1].rmabsite 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmabseq
            #add-point:BEFORE FIELD rmabseq name="construct.b.page1.rmabseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmabseq
            
            #add-point:AFTER FIELD rmabseq name="construct.a.page1.rmabseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmabseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmabseq
            #add-point:ON ACTION controlp INFIELD rmabseq name="construct.c.page1.rmabseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmab018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab018
            #add-point:ON ACTION controlp INFIELD rmab018 name="construct.c.page1.rmab018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inao009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmab018  #顯示到畫面上
            NEXT FIELD rmab018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab018
            #add-point:BEFORE FIELD rmab018 name="construct.b.page1.rmab018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab018
            
            #add-point:AFTER FIELD rmab018 name="construct.a.page1.rmab018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab019
            #add-point:BEFORE FIELD rmab019 name="construct.b.page1.rmab019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab019
            
            #add-point:AFTER FIELD rmab019 name="construct.a.page1.rmab019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab019
            #add-point:ON ACTION controlp INFIELD rmab019 name="construct.c.page1.rmab019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab020
            #add-point:BEFORE FIELD rmab020 name="construct.b.page1.rmab020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab020
            
            #add-point:AFTER FIELD rmab020 name="construct.a.page1.rmab020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab020
            #add-point:ON ACTION controlp INFIELD rmab020 name="construct.c.page1.rmab020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab001
            #add-point:ON ACTION controlp INFIELD rmab001 name="construct.c.page1.rmab001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmfodocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmab001  #顯示到畫面上
            NEXT FIELD rmab001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab001
            #add-point:BEFORE FIELD rmab001 name="construct.b.page1.rmab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab001
            
            #add-point:AFTER FIELD rmab001 name="construct.a.page1.rmab001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab002
            #add-point:BEFORE FIELD rmab002 name="construct.b.page1.rmab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab002
            
            #add-point:AFTER FIELD rmab002 name="construct.a.page1.rmab002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab002
            #add-point:ON ACTION controlp INFIELD rmab002 name="construct.c.page1.rmab002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmab003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab003
            #add-point:ON ACTION controlp INFIELD rmab003 name="construct.c.page1.rmab003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdldocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmab003  #顯示到畫面上
            NEXT FIELD rmab003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab003
            #add-point:BEFORE FIELD rmab003 name="construct.b.page1.rmab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab003
            
            #add-point:AFTER FIELD rmab003 name="construct.a.page1.rmab003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab004
            #add-point:BEFORE FIELD rmab004 name="construct.b.page1.rmab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab004
            
            #add-point:AFTER FIELD rmab004 name="construct.a.page1.rmab004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab004
            #add-point:ON ACTION controlp INFIELD rmab004 name="construct.c.page1.rmab004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab005
            #add-point:ON ACTION controlp INFIELD rmab005 name="construct.c.page1.rmab005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xmdasite = '",g_site,"' " 
            CALL q_xmdadocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmab005  #顯示到畫面上
            NEXT FIELD rmab005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab005
            #add-point:BEFORE FIELD rmab005 name="construct.b.page1.rmab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab005
            
            #add-point:AFTER FIELD rmab005 name="construct.a.page1.rmab005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab006
            #add-point:BEFORE FIELD rmab006 name="construct.b.page1.rmab006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab006
            
            #add-point:AFTER FIELD rmab006 name="construct.a.page1.rmab006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab006
            #add-point:ON ACTION controlp INFIELD rmab006 name="construct.c.page1.rmab006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab007
            #add-point:BEFORE FIELD rmab007 name="construct.b.page1.rmab007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab007
            
            #add-point:AFTER FIELD rmab007 name="construct.a.page1.rmab007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab007
            #add-point:ON ACTION controlp INFIELD rmab007 name="construct.c.page1.rmab007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab008
            #add-point:BEFORE FIELD rmab008 name="construct.b.page1.rmab008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab008
            
            #add-point:AFTER FIELD rmab008 name="construct.a.page1.rmab008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab008
            #add-point:ON ACTION controlp INFIELD rmab008 name="construct.c.page1.rmab008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rmab009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab009
            #add-point:ON ACTION controlp INFIELD rmab009 name="construct.c.page1.rmab009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmab009  #顯示到畫面上
            NEXT FIELD rmab009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab009
            #add-point:BEFORE FIELD rmab009 name="construct.b.page1.rmab009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab009
            
            #add-point:AFTER FIELD rmab009 name="construct.a.page1.rmab009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab010
            #add-point:ON ACTION controlp INFIELD rmab010 name="construct.c.page1.rmab010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdl009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmab010  #顯示到畫面上
            NEXT FIELD rmab010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab010
            #add-point:BEFORE FIELD rmab010 name="construct.b.page1.rmab010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab010
            
            #add-point:AFTER FIELD rmab010 name="construct.a.page1.rmab010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab011
            #add-point:ON ACTION controlp INFIELD rmab011 name="construct.c.page1.rmab011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmab011  #顯示到畫面上
            NEXT FIELD rmab011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab011
            #add-point:BEFORE FIELD rmab011 name="construct.b.page1.rmab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab011
            
            #add-point:AFTER FIELD rmab011 name="construct.a.page1.rmab011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab021
            #add-point:BEFORE FIELD rmab021 name="construct.b.page1.rmab021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab021
            
            #add-point:AFTER FIELD rmab021 name="construct.a.page1.rmab021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab021
            #add-point:ON ACTION controlp INFIELD rmab021 name="construct.c.page1.rmab021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab022
            #add-point:BEFORE FIELD rmab022 name="construct.b.page1.rmab022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab022
            
            #add-point:AFTER FIELD rmab022 name="construct.a.page1.rmab022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab022
            #add-point:ON ACTION controlp INFIELD rmab022 name="construct.c.page1.rmab022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab012
            #add-point:BEFORE FIELD rmab012 name="construct.b.page1.rmab012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab012
            
            #add-point:AFTER FIELD rmab012 name="construct.a.page1.rmab012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab012
            #add-point:ON ACTION controlp INFIELD rmab012 name="construct.c.page1.rmab012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab013
            #add-point:BEFORE FIELD rmab013 name="construct.b.page1.rmab013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab013
            
            #add-point:AFTER FIELD rmab013 name="construct.a.page1.rmab013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab013
            #add-point:ON ACTION controlp INFIELD rmab013 name="construct.c.page1.rmab013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab014
            #add-point:BEFORE FIELD rmab014 name="construct.b.page1.rmab014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab014
            
            #add-point:AFTER FIELD rmab014 name="construct.a.page1.rmab014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab014
            #add-point:ON ACTION controlp INFIELD rmab014 name="construct.c.page1.rmab014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab015
            #add-point:BEFORE FIELD rmab015 name="construct.b.page1.rmab015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab015
            
            #add-point:AFTER FIELD rmab015 name="construct.a.page1.rmab015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab015
            #add-point:ON ACTION controlp INFIELD rmab015 name="construct.c.page1.rmab015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab016
            #add-point:BEFORE FIELD rmab016 name="construct.b.page1.rmab016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab016
            
            #add-point:AFTER FIELD rmab016 name="construct.a.page1.rmab016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab016
            #add-point:ON ACTION controlp INFIELD rmab016 name="construct.c.page1.rmab016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab017
            #add-point:BEFORE FIELD rmab017 name="construct.b.page1.rmab017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab017
            
            #add-point:AFTER FIELD rmab017 name="construct.a.page1.rmab017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab017
            #add-point:ON ACTION controlp INFIELD rmab017 name="construct.c.page1.rmab017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmabsite
            #add-point:BEFORE FIELD rmabsite name="construct.b.page1.rmabsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmabsite
            
            #add-point:AFTER FIELD rmabsite name="construct.a.page1.rmabsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmabsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmabsite
            #add-point:ON ACTION controlp INFIELD rmabsite name="construct.c.page1.rmabsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON rmacseq,rmacseq1,l_rmab009,l_rmab010,l_rmab011,rmac001,rmac002,rmac003, 
          rmac004,rmac005,rmac006,rmac007,rmacsite
           FROM s_detail2[1].rmacseq,s_detail2[1].rmacseq1,s_detail2[1].l_rmab009,s_detail2[1].l_rmab010, 
               s_detail2[1].l_rmab011,s_detail2[1].rmac001,s_detail2[1].rmac002,s_detail2[1].rmac003, 
               s_detail2[1].rmac004,s_detail2[1].rmac005,s_detail2[1].rmac006,s_detail2[1].rmac007,s_detail2[1].rmacsite 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmacseq
            #add-point:BEFORE FIELD rmacseq name="construct.b.page2.rmacseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmacseq
            
            #add-point:AFTER FIELD rmacseq name="construct.a.page2.rmacseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmacseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmacseq
            #add-point:ON ACTION controlp INFIELD rmacseq name="construct.c.page2.rmacseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmacseq1
            #add-point:BEFORE FIELD rmacseq1 name="construct.b.page2.rmacseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmacseq1
            
            #add-point:AFTER FIELD rmacseq1 name="construct.a.page2.rmacseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmacseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmacseq1
            #add-point:ON ACTION controlp INFIELD rmacseq1 name="construct.c.page2.rmacseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.l_rmab009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rmab009
            #add-point:ON ACTION controlp INFIELD l_rmab009 name="construct.c.page2.l_rmab009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_rmab009  #顯示到畫面上
            NEXT FIELD l_rmab009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rmab009
            #add-point:BEFORE FIELD l_rmab009 name="construct.b.page2.l_rmab009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rmab009
            
            #add-point:AFTER FIELD l_rmab009 name="construct.a.page2.l_rmab009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_rmab010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rmab010
            #add-point:ON ACTION controlp INFIELD l_rmab010 name="construct.c.page2.l_rmab010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdl009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_rmab010  #顯示到畫面上
            NEXT FIELD l_rmab010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rmab010
            #add-point:BEFORE FIELD l_rmab010 name="construct.b.page2.l_rmab010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rmab010
            
            #add-point:AFTER FIELD l_rmab010 name="construct.a.page2.l_rmab010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_rmab011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rmab011
            #add-point:ON ACTION controlp INFIELD l_rmab011 name="construct.c.page2.l_rmab011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_rmab011  #顯示到畫面上
            NEXT FIELD l_rmab011                     #返回原欄位
           


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rmab011
            #add-point:BEFORE FIELD l_rmab011 name="construct.b.page2.l_rmab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rmab011
            
            #add-point:AFTER FIELD l_rmab011 name="construct.a.page2.l_rmab011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmac001
            #add-point:BEFORE FIELD rmac001 name="construct.b.page2.rmac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmac001
            
            #add-point:AFTER FIELD rmac001 name="construct.a.page2.rmac001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmac001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmac001
            #add-point:ON ACTION controlp INFIELD rmac001 name="construct.c.page2.rmac001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rmac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmac002
            #add-point:ON ACTION controlp INFIELD rmac002 name="construct.c.page2.rmac002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_17()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmac002  #顯示到畫面上
            NEXT FIELD rmac002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmac002
            #add-point:BEFORE FIELD rmac002 name="construct.b.page2.rmac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmac002
            
            #add-point:AFTER FIELD rmac002 name="construct.a.page2.rmac002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmac003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmac003
            #add-point:ON ACTION controlp INFIELD rmac003 name="construct.c.page2.rmac003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmac003  #顯示到畫面上
            NEXT FIELD rmac003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmac003
            #add-point:BEFORE FIELD rmac003 name="construct.b.page2.rmac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmac003
            
            #add-point:AFTER FIELD rmac003 name="construct.a.page2.rmac003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmac004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmac004
            #add-point:ON ACTION controlp INFIELD rmac004 name="construct.c.page2.rmac004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_inad003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmac004  #顯示到畫面上
            NEXT FIELD rmac004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmac004
            #add-point:BEFORE FIELD rmac004 name="construct.b.page2.rmac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmac004
            
            #add-point:AFTER FIELD rmac004 name="construct.a.page2.rmac004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmac005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmac005
            #add-point:ON ACTION controlp INFIELD rmac005 name="construct.c.page2.rmac005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmac005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmac005  #顯示到畫面上
            NEXT FIELD rmac005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmac005
            #add-point:BEFORE FIELD rmac005 name="construct.b.page2.rmac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmac005
            
            #add-point:AFTER FIELD rmac005 name="construct.a.page2.rmac005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmac006
            #add-point:BEFORE FIELD rmac006 name="construct.b.page2.rmac006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmac006
            
            #add-point:AFTER FIELD rmac006 name="construct.a.page2.rmac006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmac006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmac006
            #add-point:ON ACTION controlp INFIELD rmac006 name="construct.c.page2.rmac006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rmac007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmac007
            #add-point:ON ACTION controlp INFIELD rmac007 name="construct.c.page2.rmac007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmac007  #顯示到畫面上
            NEXT FIELD rmac007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmac007
            #add-point:BEFORE FIELD rmac007 name="construct.b.page2.rmac007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmac007
            
            #add-point:AFTER FIELD rmac007 name="construct.a.page2.rmac007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmacsite
            #add-point:BEFORE FIELD rmacsite name="construct.b.page2.rmacsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmacsite
            
            #add-point:AFTER FIELD rmacsite name="construct.a.page2.rmacsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmacsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmacsite
            #add-point:ON ACTION controlp INFIELD rmacsite name="construct.c.page2.rmacsite"
            
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
                  WHEN la_wc[li_idx].tableid = "rmaa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rmab_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rmac_t" 
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
 
{<section id="armt100.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION armt100_filter()
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
      CONSTRUCT g_wc_filter ON rmaadocno,rmaadocdt,rmaa002,rmaa003,rmaa001,rmaa004,rmaa005,rmaa006,rmaasite 
 
                          FROM s_browse[1].b_rmaadocno,s_browse[1].b_rmaadocdt,s_browse[1].b_rmaa002, 
                              s_browse[1].b_rmaa003,s_browse[1].b_rmaa001,s_browse[1].b_rmaa004,s_browse[1].b_rmaa005, 
                              s_browse[1].b_rmaa006,s_browse[1].b_rmaasite
 
         BEFORE CONSTRUCT
               DISPLAY armt100_filter_parser('rmaadocno') TO s_browse[1].b_rmaadocno
            DISPLAY armt100_filter_parser('rmaadocdt') TO s_browse[1].b_rmaadocdt
            DISPLAY armt100_filter_parser('rmaa002') TO s_browse[1].b_rmaa002
            DISPLAY armt100_filter_parser('rmaa003') TO s_browse[1].b_rmaa003
            DISPLAY armt100_filter_parser('rmaa001') TO s_browse[1].b_rmaa001
            DISPLAY armt100_filter_parser('rmaa004') TO s_browse[1].b_rmaa004
            DISPLAY armt100_filter_parser('rmaa005') TO s_browse[1].b_rmaa005
            DISPLAY armt100_filter_parser('rmaa006') TO s_browse[1].b_rmaa006
            DISPLAY armt100_filter_parser('rmaasite') TO s_browse[1].b_rmaasite
      
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
 
      CALL armt100_filter_show('rmaadocno')
   CALL armt100_filter_show('rmaadocdt')
   CALL armt100_filter_show('rmaa002')
   CALL armt100_filter_show('rmaa003')
   CALL armt100_filter_show('rmaa001')
   CALL armt100_filter_show('rmaa004')
   CALL armt100_filter_show('rmaa005')
   CALL armt100_filter_show('rmaa006')
   CALL armt100_filter_show('rmaasite')
 
END FUNCTION
 
{</section>}
 
{<section id="armt100.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION armt100_filter_parser(ps_field)
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
 
{<section id="armt100.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION armt100_filter_show(ps_field)
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
   LET ls_condition = armt100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="armt100.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION armt100_query()
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
   CALL g_rmab_d.clear()
   CALL g_rmab2_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL s_lot_clear_detail()
   CALL g_inao_d2.clear()
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL armt100_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL armt100_browser_fill("")
      CALL armt100_fetch("")
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
      CALL armt100_filter_show('rmaadocno')
   CALL armt100_filter_show('rmaadocdt')
   CALL armt100_filter_show('rmaa002')
   CALL armt100_filter_show('rmaa003')
   CALL armt100_filter_show('rmaa001')
   CALL armt100_filter_show('rmaa004')
   CALL armt100_filter_show('rmaa005')
   CALL armt100_filter_show('rmaa006')
   CALL armt100_filter_show('rmaasite')
   CALL armt100_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL armt100_fetch("F") 
      #顯示單身筆數
      CALL armt100_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="armt100.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION armt100_fetch(p_flag)
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
   
   LET g_rmaa_m.rmaadocno = g_browser[g_current_idx].b_rmaadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE armt100_master_referesh USING g_rmaa_m.rmaadocno INTO g_rmaa_m.rmaadocno,g_rmaa_m.rmaa001, 
       g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaastus, 
       g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaowndp, 
       g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt, 
       g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstdt,g_rmaa_m.rmaa001_desc, 
       g_rmaa_m.rmaa002_desc,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp_desc,g_rmaa_m.rmaacrtid_desc, 
       g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaacnfid_desc,g_rmaa_m.rmaapstid_desc 
 
   
   #遮罩相關處理
   LET g_rmaa_m_mask_o.* =  g_rmaa_m.*
   CALL armt100_rmaa_t_mask()
   LET g_rmaa_m_mask_n.* =  g_rmaa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL armt100_set_act_visible()   
   CALL armt100_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rmaa_m_t.* = g_rmaa_m.*
   LET g_rmaa_m_o.* = g_rmaa_m.*
   
   LET g_data_owner = g_rmaa_m.rmaaownid      
   LET g_data_dept  = g_rmaa_m.rmaaowndp
   
   #重新顯示   
   CALL armt100_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="armt100.insert" >}
#+ 資料新增
PRIVATE FUNCTION armt100_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rmab_d.clear()   
   CALL g_rmab2_d.clear()  
 
 
   INITIALIZE g_rmaa_m.* TO NULL             #DEFAULT 設定
   
   LET g_rmaadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   #2016-4-11 zhujing add
   CALL g_inao_d.clear()
   CALL g_inao_d2.clear()
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rmaa_m.rmaaownid = g_user
      LET g_rmaa_m.rmaaowndp = g_dept
      LET g_rmaa_m.rmaacrtid = g_user
      LET g_rmaa_m.rmaacrtdp = g_dept 
      LET g_rmaa_m.rmaacrtdt = cl_get_current()
      LET g_rmaa_m.rmaamodid = g_user
      LET g_rmaa_m.rmaamoddt = cl_get_current()
      LET g_rmaa_m.rmaastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
            
      LET g_rmaa_m.rmaasite = g_site
      LET g_rmaa_m.rmaadocdt = g_today
      LET g_rmaa_m.rmaa008 = g_today
      LET g_rmaa_m.rmaa002 = g_user
      LET g_rmaa_m.rmaastus = 'N'
      LET g_rmaa_m.rmaa003 = g_dept
      
      CALL s_desc_get_person_desc(g_rmaa_m.rmaa002) RETURNING g_rmaa_m.rmaa002_desc
      DISPLAY BY NAME g_rmaa_m.rmaa002_desc
      CALL s_desc_get_department_desc(g_rmaa_m.rmaa003) RETURNING g_rmaa_m.rmaa003_desc
      DISPLAY BY NAME g_rmaa_m.rmaa003_desc
      
      INITIALIZE g_rmaa_m_t.* TO NULL
      INITIALIZE g_rmaa_m_o.* TO NULL
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rmaa_m_t.* = g_rmaa_m.*
      LET g_rmaa_m_o.* = g_rmaa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmaa_m.rmaastus 
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
 
 
 
    
      CALL armt100_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      CALL armt100_show()
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
         INITIALIZE g_rmaa_m.* TO NULL
         INITIALIZE g_rmab_d TO NULL
         INITIALIZE g_rmab2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL armt100_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rmab_d.clear()
      #CALL g_rmab2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL armt100_set_act_visible()   
   CALL armt100_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rmaadocno_t = g_rmaa_m.rmaadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rmaaent = " ||g_enterprise|| " AND",
                      " rmaadocno = '", g_rmaa_m.rmaadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL armt100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE armt100_cl
   
   CALL armt100_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE armt100_master_referesh USING g_rmaa_m.rmaadocno INTO g_rmaa_m.rmaadocno,g_rmaa_m.rmaa001, 
       g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaastus, 
       g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaowndp, 
       g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt, 
       g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstdt,g_rmaa_m.rmaa001_desc, 
       g_rmaa_m.rmaa002_desc,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp_desc,g_rmaa_m.rmaacrtid_desc, 
       g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaacnfid_desc,g_rmaa_m.rmaapstid_desc 
 
   
   
   #遮罩相關處理
   LET g_rmaa_m_mask_o.* =  g_rmaa_m.*
   CALL armt100_rmaa_t_mask()
   LET g_rmaa_m_mask_n.* =  g_rmaa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rmaa_m.rmaadocno,g_rmaa_m.rmaadocno_desc,g_rmaa_m.rmaa001,g_rmaa_m.rmaa001_desc, 
       g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa002_desc, 
       g_rmaa_m.rmaa003,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaastus,g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006, 
       g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp,g_rmaa_m.rmaaowndp_desc, 
       g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtid_desc,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaacrtdt, 
       g_rmaa_m.rmaamodid,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaamoddt,g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfid_desc, 
       g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstid_desc,g_rmaa_m.rmaapstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rmaa_m.rmaaownid      
   LET g_data_dept  = g_rmaa_m.rmaaowndp
   
   #功能已完成,通報訊息中心
   CALL armt100_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="armt100.modify" >}
#+ 資料修改
PRIVATE FUNCTION armt100_modify()
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
   LET g_rmaa_m_t.* = g_rmaa_m.*
   LET g_rmaa_m_o.* = g_rmaa_m.*
   
   IF g_rmaa_m.rmaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rmaadocno_t = g_rmaa_m.rmaadocno
 
   CALL s_transaction_begin()
   
   OPEN armt100_cl USING g_enterprise,g_rmaa_m.rmaadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt100_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE armt100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE armt100_master_referesh USING g_rmaa_m.rmaadocno INTO g_rmaa_m.rmaadocno,g_rmaa_m.rmaa001, 
       g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaastus, 
       g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaowndp, 
       g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt, 
       g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstdt,g_rmaa_m.rmaa001_desc, 
       g_rmaa_m.rmaa002_desc,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp_desc,g_rmaa_m.rmaacrtid_desc, 
       g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaacnfid_desc,g_rmaa_m.rmaapstid_desc 
 
   
   #檢查是否允許此動作
   IF NOT armt100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rmaa_m_mask_o.* =  g_rmaa_m.*
   CALL armt100_rmaa_t_mask()
   LET g_rmaa_m_mask_n.* =  g_rmaa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL armt100_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_rmaadocno_t = g_rmaa_m.rmaadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rmaa_m.rmaamodid = g_user 
LET g_rmaa_m.rmaamoddt = cl_get_current()
LET g_rmaa_m.rmaamodid_desc = cl_get_username(g_rmaa_m.rmaamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL armt100_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rmaa_t SET (rmaamodid,rmaamoddt) = (g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt)
          WHERE rmaaent = g_enterprise AND rmaadocno = g_rmaadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rmaa_m.* = g_rmaa_m_t.*
            CALL armt100_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rmaa_m.rmaadocno != g_rmaa_m_t.rmaadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE rmab_t SET rmabdocno = g_rmaa_m.rmaadocno
 
          WHERE rmabent = g_enterprise AND rmabdocno = g_rmaa_m_t.rmaadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rmab_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmab_t:",SQLERRMESSAGE 
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
         
         UPDATE rmac_t
            SET rmacdocno = g_rmaa_m.rmaadocno
 
          WHERE rmacent = g_enterprise AND
                rmacdocno = g_rmaadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rmac_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmac_t:",SQLERRMESSAGE 
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
   CALL armt100_set_act_visible()   
   CALL armt100_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rmaaent = " ||g_enterprise|| " AND",
                      " rmaadocno = '", g_rmaa_m.rmaadocno, "' "
 
   #填到對應位置
   CALL armt100_browser_fill("")
 
   CLOSE armt100_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL armt100_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="armt100.input" >}
#+ 資料輸入
PRIVATE FUNCTION armt100_input(p_cmd)
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
   DEFINE l_ooef004              LIKE ooef_t.ooef004    #單據別參照表號
   DEFINE l_num                  LIKE type_t.num10
   DEFINE l_rmabseq_backup       LIKE rmab_t.rmabseq    #紀錄新增退品明細時的項次
   DEFINE l_where                STRING                 #單據別過濾sql條件
   DEFINE l_open                 LIKE type_t.chr2       #記錄是否開啟退品點收
   DEFINE l_no                   LIKE type_t.num10      #查看是否有多个项序
   DEFINE l_para_data            LIKE type_t.chr80      #接參數用
   DEFINE l_err                  LIKE type_t.chr20
   DEFINE l_rmab012              LIKE rmab_t.rmab012
   DEFINE l_imaf055              LIKE imaf_t.imaf055    #库存管理特征是否维护
   DEFINE l_flag1                LIKE type_t.num5
   DEFINE l_ooac002              LIKE ooac_t.ooac002
   DEFINE l_start    LIKE type_t.num5
   DEFINE l_length   LIKE type_t.num5
   DEFINE l_imaf071        LIKE imaf_t.imaf071           #判断是否需要维护制造批序号 2016-4-6 zhujing add
   DEFINE l_imaf081        LIKE imaf_t.imaf081           #判断是否需要维护制造批序号 2016-4-6 zhujing add
   DEFINE r_success        LIKE type_t.num5              #判断是否需要维护制造批序号 2016-4-6 zhujing add
   DEFINE l_amount         LIKE inbb_t.inbb011
   DEFINE l_flag                 LIKE type_t.chr10       #判断是否重新带入序号值 2016-7-22 zhujing add
   DEFINE l_rmab018        LIKE rmab_t.rmab018           #判断是否重新带入序号值 2016-7-22 zhujing add
   #160816-00066#1 add-S
   DEFINE  l_imaa005       LIKE imaa_t.imaa005       #特徵類別
   DEFINE  l_inam          DYNAMIC ARRAY OF RECORD   #記錄產品特徵
              inam001      LIKE inam_t.inam001,
              inam002      LIKE inam_t.inam002,
              inam004      LIKE inam_t.inam004
                        END RECORD
   DEFINE l_date           LIKE rmab_t.rmab021
   #160816-00066#1 add-E
   DEFINE l_sql1          STRING            #160711-00040#28 add
   DEFINE l_n1                   LIKE type_t.num10 #170222-00004#1-----add---检查inao是否有数据
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
   DISPLAY BY NAME g_rmaa_m.rmaadocno,g_rmaa_m.rmaadocno_desc,g_rmaa_m.rmaa001,g_rmaa_m.rmaa001_desc, 
       g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa002_desc, 
       g_rmaa_m.rmaa003,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaastus,g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006, 
       g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp,g_rmaa_m.rmaaowndp_desc, 
       g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtid_desc,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaacrtdt, 
       g_rmaa_m.rmaamodid,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaamoddt,g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfid_desc, 
       g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstid_desc,g_rmaa_m.rmaapstdt
   
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
   LET g_forupd_sql = "SELECT rmabseq,rmab018,rmab019,rmab020,rmab001,rmab002,rmab003,rmab004,rmab005, 
       rmab006,rmab007,rmab008,rmab009,rmab010,rmab011,rmab021,rmab022,rmab012,rmab013,rmab014,rmab015, 
       rmab016,rmab017,rmabsite FROM rmab_t WHERE rmabent=? AND rmabdocno=? AND rmabseq=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt100_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT rmacseq,rmacseq1,rmac001,rmac002,rmac003,rmac004,rmac005,rmac006,rmac007, 
       rmacsite FROM rmac_t WHERE rmacent=? AND rmacdocno=? AND rmacseq=? AND rmacseq1=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt100_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL armt100_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   IF g_open = 'Y' THEN
      LET l_allow_insert = FALSE
      LET l_allow_delete = FALSE
   ELSE
      LET l_allow_insert = TRUE
      LET l_allow_delete = TRUE
   END IF
   #end add-point
   CALL armt100_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rmaa_m.rmaadocno,g_rmaa_m.rmaa001,g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008, 
       g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaastus,g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa007 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
#   LET l_open = 'N'
   CALL cl_set_comp_entry("s_detail2",FALSE)
   IF p_cmd = 'u' THEN
      LET l_num = 0
      SELECT COUNT(*) INTO l_num
        FROM rmab_t
       WHERE rmabdocno = g_rmaa_m.rmaadocno
         AND rmabent = g_enterprise
         AND rmabsite = g_site
      IF cl_null(l_num) OR l_num = 0 THEN
         CALL cl_set_comp_entry("rmaa005,rmaa006",TRUE)
      ELSE
         CALL cl_set_comp_entry("rmaa005,rmaa006",FALSE)
      END IF
   END IF
   CALL armt100_set_no_required()         #160202-00019#1 2016-2-18 zhujing add
   CALL armt100_set_required()            #160202-00019#1 2016-2-18 zhujing add
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="armt100.input.head" >}
      #單頭段
      INPUT BY NAME g_rmaa_m.rmaadocno,g_rmaa_m.rmaa001,g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008, 
          g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaastus,g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa007  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN armt100_cl USING g_enterprise,g_rmaa_m.rmaadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE armt100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL armt100_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL armt100_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaadocno
            
            #add-point:AFTER FIELD rmaadocno name="input.a.rmaadocno"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rmaa_m.rmaadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rmaa_m.rmaadocno != g_rmaadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmaa_t WHERE "||"rmaaent = '" ||g_enterprise|| "' AND "||"rmaadocno = '"||g_rmaa_m.rmaadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_aooi200_get_slip_desc(g_rmaa_m.rmaadocno) RETURNING g_rmaa_m.rmaadocno_desc
               DISPLAY BY NAME g_rmaa_m.rmaadocno_desc
            END IF

            IF cl_null(g_rmaa_m.rmaadocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00324'   #單號欄位不可為空！
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF

            IF g_rmaa_m.rmaadocno <> g_rmaa_m_o.rmaadocno OR cl_null(g_rmaa_m_o.rmaadocno) THEN
               #檢查單別
               IF NOT s_aooi200_chk_slip(g_site,'',g_rmaa_m.rmaadocno,g_prog) THEN
                  LET g_rmaa_m.rmaadocno = g_rmaa_m_o.rmaadocno

                  CALL s_aooi200_get_slip_desc(g_rmaa_m.rmaadocno) RETURNING g_rmaa_m.rmaadocno_desc
                  DISPLAY BY NAME g_rmaa_m.rmaadocno_desc

                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_rmaa_m_o.rmaadocno = g_rmaa_m.rmaadocno
            CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_flag1,l_ooac002
            IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0009') = 'Y' THEN
               CALL cl_set_comp_required("rmab018",TRUE)
            ELSE
               CALL cl_set_comp_required("rmab018",FALSE)
            END IF
            #160816-00066#1 add-S E-MFG-0040=Y时，控制出货单号、项次必输,否则可直接录入料号
            IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'Y' THEN
               CALL cl_set_comp_required("rmaa005,rmab003,rmab004",TRUE)
               CALL cl_set_comp_entry("rmab009,rmab010,rmab011",FALSE)
            ELSE
               CALL cl_set_comp_required("rmaa005,rmab003,rmab004",FALSE)
               CALL cl_set_comp_entry("rmab009,rmab010,rmab011",TRUE)
            END IF
            #160816-00066#1 add-E 
#            IF l_cmd_t = 'r' THEN
#               FOR l_num = 1 TO g_rmab_d.getLength()   
#                  LET g_rmab_d[l_num].rmab012 = l_num
#                  IF NOT armt100_rmab_default_insert(g_rmab_d[l_num].rmab003,g_rmab_d[l_num].rmab004) THEN
#                     LET g_rmab_d[l_num].rmab012 = '0' 
#                  END IF
#                  IF g_rmab_d[l_num].rmab012 = '0' OR cl_null(g_rmab_d[l_num].rmab012) THEN
#                     CALL g_rmab_d.deleteElement(l_num)
#                     LET l_num = l_num-1
#                  END IF
#                  IF g_rmab_d.getLength() = '0' THEN
#                     EXIT FOR
#                  END IF
#               END FOR
#            END IF
#            LET g_rmaa_m.rmaa002 = g_user
#            LET g_rmaa_m.rmaa003 = g_dept
#            LET g_rmaa_m.rmaadocdt = g_today
#            LET g_rmaa_m.rmaa008 = g_today
#            DISPLAY g_rmaa_m.rmaa002 TO rmaa002
#            DISPLAY g_rmaa_m.rmaa003 TO rmaa003
#            DISPLAY g_rmaa_m.rmaadocdt TO rmaadocdt
#            DISPLAY g_rmaa_m.rmaa008 TO rmaa008
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaadocno
            #add-point:BEFORE FIELD rmaadocno name="input.b.rmaadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaadocno
            #add-point:ON CHANGE rmaadocno name="input.g.rmaadocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa001
            
            #add-point:AFTER FIELD rmaa001 name="input.a.rmaa001"
            
            IF NOT cl_null(g_rmaa_m.rmaa001) THEN 
               
               CALL s_desc_get_trading_partner_abbr_desc(g_rmaa_m.rmaa001) RETURNING g_rmaa_m.rmaa001_desc
               DISPLAY BY NAME g_rmaa_m.rmaa001_desc
               
               IF NOT s_axmt540_client_chk(g_rmaa_m.rmaadocno,'1',g_rmaa_m.rmaa001,'') THEN
                  LET g_rmaa_m.rmaa001 = g_rmaa_m_o.rmaa001
                  CALL s_desc_get_trading_partner_abbr_desc(g_rmaa_m.rmaa001) RETURNING g_rmaa_m.rmaa001_desc
                  DISPLAY BY NAME g_rmaa_m.rmaa001_desc
                  NEXT FIELD CURRENT
#               ELSE
#                  SELECT    CASE 
#                  WHEN (pmaastus <>'Y') THEN 'apm-00201' 
#                  WHEN (NOT EXISTS ( SELECT pmab001 FROM pmab_t WHERE pmabent = pmaaent AND pmabsite = g_site AND pmab001 = pmaa001)) THEN 'ais-00055' 
#                  ELSE '1' END INTO l_err
#                  FROM pmaa_t
#                  WHERE pmaa001 = g_rmaa_m.rmaa001 AND pmaaent = g_enterprise AND (pmaa002 = '2' OR pmaa002 ='3') AND 1=1 
#                  
#                  IF l_err = '1' THEN
#               
#                  ELSE
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "" 
#                     LET g_errparam.code = l_err
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_rmaa_m.rmaa001 = g_rmaa_m_o.rmaa001
#                     CALL s_desc_get_trading_partner_abbr_desc(g_rmaa_m.rmaa001) RETURNING g_rmaa_m.rmaa001_desc
#                     DISPLAY BY NAME g_rmaa_m.rmaa001_desc
#                     NEXT FIELD CURRENT
#                  END IF
               END IF
            ELSE
               LET g_rmaa_m.rmaa001_desc = NULL
               DISPLAY g_rmaa_m.rmaa001_desc TO rmaa001_desc

            END IF 
            
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa001
            #add-point:BEFORE FIELD rmaa001 name="input.b.rmaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaa001
            #add-point:ON CHANGE rmaa001 name="input.g.rmaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaasite
            #add-point:BEFORE FIELD rmaasite name="input.b.rmaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaasite
            
            #add-point:AFTER FIELD rmaasite name="input.a.rmaasite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaasite
            #add-point:ON CHANGE rmaasite name="input.g.rmaasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaadocdt
            #add-point:BEFORE FIELD rmaadocdt name="input.b.rmaadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaadocdt
            
            #add-point:AFTER FIELD rmaadocdt name="input.a.rmaadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaadocdt
            #add-point:ON CHANGE rmaadocdt name="input.g.rmaadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa008
            #add-point:BEFORE FIELD rmaa008 name="input.b.rmaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa008
            
            #add-point:AFTER FIELD rmaa008 name="input.a.rmaa008"
            IF NOT cl_null(g_rmaa_m.rmaa008) THEN
               IF g_rmaa_m.rmaa008 <> g_rmaa_m_o.rmaa008 OR cl_null(g_rmaa_m_o.rmaa008) THEN
                  #151120-00003#1 20151123 mark by beckxie---S
                  #IF NOT armt100_rmaadocdt_rmaa008_chk() THEN
                  #   LET g_rmaa_m.rmaa008 = g_rmaa_m_o.rmaa008
                  #   NEXT FIELD CURRENT
                  #END IF
                  #151120-00003#1 20151123 mark by beckxie---E
                  CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_para_data
                  IF g_rmaa_m.rmaa008 <= l_para_data THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00077'   #扣帳日期小於關帳日期，請重新輸入！
                     LET g_errparam.extend = g_rmaa_m.rmaa008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_rmaa_m.rmaa008 = g_rmaa_m_o.rmaa008
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_rmaa_m_o.rmaa008 = g_rmaa_m.rmaa008   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaa008
            #add-point:ON CHANGE rmaa008 name="input.g.rmaa008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa002
            
            #add-point:AFTER FIELD rmaa002 name="input.a.rmaa002"
            CALL s_desc_get_person_desc(g_rmaa_m.rmaa002) RETURNING g_rmaa_m.rmaa002_desc
            DISPLAY BY NAME g_rmaa_m.rmaa002_desc
            IF NOT cl_null(g_rmaa_m.rmaa002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               IF NOT s_employee_chk(g_rmaa_m.rmaa002) THEN
                     LET g_rmaa_m.rmaa002 = g_rmaa_m_o.rmaa002

                     CALL s_desc_get_person_desc(g_rmaa_m.rmaa002) RETURNING g_rmaa_m.rmaa002_desc
                     DISPLAY BY NAME g_rmaa_m.rmaa002_desc

                     NEXT FIELD CURRENT
                  END IF            
               
                  #帶出歸屬部門ooag003
                  SELECT ooag003 INTO g_rmaa_m.rmaa003
                    FROM ooag_t
                   WHERE ooagent = g_enterprise
                     AND ooag001 = g_rmaa_m.rmaa002
               
                  LET g_rmaa_m_o.rmaa003 = g_rmaa_m.rmaa003
                  DISPLAY BY NAME g_rmaa_m.rmaa003

                  CALL s_desc_get_department_desc(g_rmaa_m.rmaa003) RETURNING g_rmaa_m.rmaa003_desc
                  DISPLAY BY NAME g_rmaa_m.rmaa003_desc


            END IF 
#            LET g_rmaa_m.rmaa002 = g_rmaa_m_o.rmaa002


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa002
            #add-point:BEFORE FIELD rmaa002 name="input.b.rmaa002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaa002
            #add-point:ON CHANGE rmaa002 name="input.g.rmaa002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa003
            
            #add-point:AFTER FIELD rmaa003 name="input.a.rmaa003"
            CALL s_desc_get_department_desc(g_rmaa_m.rmaa003) RETURNING g_rmaa_m.rmaa003_desc
            DISPLAY BY NAME g_rmaa_m.rmaa003_desc

            IF NOT cl_null(g_rmaa_m.rmaa003) THEN 
               IF g_rmaa_m.rmaa003 <> g_rmaa_m_o.rmaa003 OR cl_null(g_rmaa_m_o.rmaa003) THEN

                  IF NOT s_department_chk(g_rmaa_m.rmaa003,g_rmaa_m.rmaadocdt) THEN
                     LET g_rmaa_m.rmaa003 = g_rmaa_m_o.rmaa003

                     CALL s_desc_get_department_desc(g_rmaa_m.rmaa003) RETURNING g_rmaa_m.rmaa003_desc
                     DISPLAY BY NAME g_rmaa_m.rmaa003_desc

                     NEXT FIELD CURRENT
                  END IF               
               END IF
            END IF 

#            LET g_rmaa_m_o.rmaa003 = g_rmaa_m.rmaa003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa003
            #add-point:BEFORE FIELD rmaa003 name="input.b.rmaa003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaa003
            #add-point:ON CHANGE rmaa003 name="input.g.rmaa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaastus
            #add-point:BEFORE FIELD rmaastus name="input.b.rmaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaastus
            
            #add-point:AFTER FIELD rmaastus name="input.a.rmaastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaastus
            #add-point:ON CHANGE rmaastus name="input.g.rmaastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa004
            #add-point:BEFORE FIELD rmaa004 name="input.b.rmaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa004
            
            #add-point:AFTER FIELD rmaa004 name="input.a.rmaa004"
            IF NOT cl_null(g_rmab_d[1].rmabseq) AND g_rmaa_m.rmaa004 <> g_rmaa_m_t.rmaa004 THEN
               #160204-00004#4 Add By Ken 160222(S)
               IF NOT s_aooi210_check_doc(g_site,'',g_rmaa_m.rmaa004,g_rmaa_m.rmaadocno,'4','') THEN
                  LET g_rmaa_m.rmaa004 = g_rmaa_m_t.rmaa004
                  NEXT FIELD CURRENT
               END IF
               #160204-00004#4 Add By Ken 160222(E)               
               
               IF NOT cl_ask_confirm('arm-00032') THEN      #更改客诉单号将会清除单身资料，是否确定更改？
                  LET g_rmaa_m.rmaa004 = g_rmaa_m_t.rmaa004
                  DISPLAY g_rmaa_m.rmaa004 TO rmaa004
                  RETURN
               ELSE
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_rmaa_m.rmaadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rmab_d_t.rmabseq
 
            
                  #刪除同層單身
                  IF NOT armt100_delete_b('rmab_t',gs_keys,"'1'") THEN
                     CALL s_transaction_end('N','0')
                  END IF
       
                  #刪除下層單身
                  IF NOT armt100_key_delete_b(gs_keys,'rmab_t') THEN
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL armt100_b_fill()
               END IF
            END IF
            #判斷是否已審核
            IF NOT cl_null(g_rmaa_m.rmaa004) THEN 
            #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmaa_m.rmaa004
               LET g_chkparam.arg2 = g_rmaa_m.rmaa001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xmfodocno") THEN  #已確認的客訴單號 
                  #檢查成功時後續處理
                  #检查是否有其他RMA单维护过此客诉单号
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM rmab_t
                   WHERE rmab001 = g_rmaa_m.rmaa004
                     AND rmabent = g_enterprise
                     AND rmabsite = g_site
                     AND rmabdocno <> g_rmaa_m.rmaadocno
                  IF l_cnt <> 0 OR cl_null(l_cnt) THEN
                     #檢查失敗時後續處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'arm-00034'   #此客诉单已有存在的RMA单！
                     LET g_errparam.extend = g_rmaa_m.rmaa004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_rmaa_m.rmaa004 = g_rmaa_m_t.rmaa004
                     DISPLAY g_rmaa_m.rmaa004 TO rmaa004
                     LET g_rmaa_m.rmaa005 = g_rmaa_m_t.rmaa005
                     DISPLAY g_rmaa_m.rmaa005 TO rmaa005
                     LET g_rmaa_m.rmaa006 = g_rmaa_m_t.rmaa006
                     DISPLAY g_rmaa_m.rmaa006 TO rmaa006
                     NEXT FIELD CURRENT
                  ELSE
                     SELECT xmfo006,xmfo008 INTO g_rmaa_m.rmaa005,g_rmaa_m.rmaa006
                       FROM xmfo_t
                      WHERE xmfoent = g_enterprise
                        AND xmfosite = g_site
                        AND xmfodocno = g_rmaa_m.rmaa004
                     LET l_ac = 1
                     CALL armt100_rmaa004_default(g_rmaa_m.rmaa004)
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmaa_m.rmaa004 = g_rmaa_m_t.rmaa004
                  DISPLAY g_rmaa_m.rmaa004 TO rmaa004
                  LET g_rmaa_m.rmaa005 = g_rmaa_m_t.rmaa005
                  DISPLAY g_rmaa_m.rmaa005 TO rmaa005
                  LET g_rmaa_m.rmaa006 = g_rmaa_m_t.rmaa006
                  DISPLAY g_rmaa_m.rmaa006 TO rmaa006
                  NEXT FIELD CURRENT
               END IF
               CALL cl_set_comp_entry("rmaa005,rmaa006",FALSE)
            ELSE 
               LET g_rmaa_m.rmaa006 = NULL
               DISPLAY g_rmaa_m.rmaa006 TO rmaa006
               CALL cl_set_comp_entry("rmaa005,rmaa006",TRUE)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaa004
            #add-point:ON CHANGE rmaa004 name="input.g.rmaa004"
            IF NOT cl_null(g_rmab_d[1].rmabseq) AND g_rmaa_m.rmaa004 <> g_rmaa_m_t.rmaa004 THEN
               IF NOT cl_ask_confirm('arm-00032') THEN      #更改客诉单号将会清除单身资料，是否确定更改？
                  LET g_rmaa_m.rmaa004 = g_rmaa_m_t.rmaa004
                  DISPLAY g_rmaa_m.rmaa004 TO rmaa004
                  RETURN
               ELSE
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_rmaa_m.rmaadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rmab_d_t.rmabseq
 
            
                  #刪除同層單身
                  IF NOT armt100_delete_b('rmab_t',gs_keys,"'1'") THEN
                     CALL s_transaction_end('N','0')
                  END IF
       
                  #刪除下層單身
                  IF NOT armt100_key_delete_b(gs_keys,'rmab_t') THEN
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL armt100_b_fill()
               END IF
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa005
            
            #add-point:AFTER FIELD rmaa005 name="input.a.rmaa005"
            #判斷是否已過帳
            IF NOT cl_null(g_rmaa_m.rmaa005) THEN 
            #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               #160204-00004#4 Add By Ken 160222(S)
               IF NOT s_aooi210_check_doc(g_site,'',g_rmaa_m.rmaa005,g_rmaa_m.rmaadocno,'4','') THEN
                  LET g_rmaa_m.rmaa005 = g_rmaa_m_t.rmaa005
                  NEXT FIELD CURRENT
               END IF
               #160204-00004#4 Add By Ken 160222(S)                
               
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmaa_m.rmaa005
               LET g_chkparam.arg2 = g_rmaa_m.rmaa001
               #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="ais-00109:sub-01311|axmt540|",cl_get_progname("axmt540",g_lang,"2"),"|:EXEPROGaxmt540"
               #160318-00025#21  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xmdkdocno_6") THEN  #已過帳狀態的出貨單   
                  #檢查成功時後續處理
                  SELECT xmdk006 INTO g_rmaa_m.rmaa006
                    FROM xmdk_t
                   WHERE xmdkent = g_enterprise
                     AND xmdkdocno = g_rmaa_m.rmaa005
                     AND xmdksite = g_site
                  DISPLAY g_rmaa_m.rmaa006 TO rmaa006
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmaa_m.rmaa005 = g_rmaa_m_t.rmaa005
                  DISPLAY g_rmaa_m.rmaa005 TO rmaa005
                  LET g_rmaa_m.rmaa006 = g_rmaa_m_t.rmaa006
                  DISPLAY g_rmaa_m.rmaa006 TO rmaa006
                  NEXT FIELD CURRENT
               END IF
            ELSE 
               LET g_rmaa_m.rmaa006 = NULL
               DISPLAY g_rmaa_m.rmaa006 TO rmaa006
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa005
            #add-point:BEFORE FIELD rmaa005 name="input.b.rmaa005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaa005
            #add-point:ON CHANGE rmaa005 name="input.g.rmaa005"
            IF NOT cl_null(g_rmab_d[1].rmabseq) AND g_rmaa_m.rmaa005 <> g_rmaa_m_t.rmaa005 THEN
               IF NOT cl_ask_confirm('arm-00017') THEN
                  LET g_rmaa_m.rmaa005 = g_rmaa_m_t.rmaa005
                  DISPLAY g_rmaa_m.rmaa005 TO rmaa005
                  RETURN
               ELSE
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_rmaa_m.rmaadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rmab_d_t.rmabseq
 
            
                  #刪除同層單身
                  IF NOT armt100_delete_b('rmab_t',gs_keys,"'1'") THEN
                     CALL s_transaction_end('N','0')
                  END IF
       
                  #刪除下層單身
                  IF NOT armt100_key_delete_b(gs_keys,'rmab_t') THEN
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL armt100_b_fill()
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmaa007
            #add-point:BEFORE FIELD rmaa007 name="input.b.rmaa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmaa007
            
            #add-point:AFTER FIELD rmaa007 name="input.a.rmaa007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmaa007
            #add-point:ON CHANGE rmaa007 name="input.g.rmaa007"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rmaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaadocno
            #add-point:ON ACTION controlp INFIELD rmaadocno name="input.c.rmaadocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmaa_m.rmaadocno             #給予default值

            #給予arg
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
             
            LET g_qryparam.arg1 = l_ooef004        #參照表號
            #LET g_qryparam.arg2 = 'armt100'           #程式代號   #160705-00042#6 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#6 160711 by sakura add
             #160711-00040#28 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#28 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_rmaa_m.rmaadocno = g_qryparam.return1              

            DISPLAY g_rmaa_m.rmaadocno TO rmaadocno              #
            
            CALL s_aooi200_get_slip_desc(g_rmaa_m.rmaadocno) RETURNING g_rmaa_m.rmaadocno_desc
            DISPLAY BY NAME g_rmaa_m.rmaadocno_desc
            
            NEXT FIELD rmaadocno                          #返回原欄位
         

            #END add-point
 
 
         #Ctrlp:input.c.rmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa001
            #add-point:ON ACTION controlp INFIELD rmaa001 name="input.c.rmaa001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmaa_m.rmaa001             #給予default值
            CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,g_rmaa_m.rmaadocno) RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = l_where
            END IF

            #給予arg
            LET g_qryparam.arg1 = g_site #s


            CALL q_pmaa001_6()                                #呼叫開窗

            LET g_rmaa_m.rmaa001 = g_qryparam.return1              

            DISPLAY g_rmaa_m.rmaa001 TO rmaa001              #

            NEXT FIELD rmaa001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmaasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaasite
            #add-point:ON ACTION controlp INFIELD rmaasite name="input.c.rmaasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaadocdt
            #add-point:ON ACTION controlp INFIELD rmaadocdt name="input.c.rmaadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa008
            #add-point:ON ACTION controlp INFIELD rmaa008 name="input.c.rmaa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa002
            #add-point:ON ACTION controlp INFIELD rmaa002 name="input.c.rmaa002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmaa_m.rmaa002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_rmaa_m.rmaa002 = g_qryparam.return1              

            DISPLAY g_rmaa_m.rmaa002 TO rmaa002              #

            CALL s_desc_get_person_desc(g_rmaa_m.rmaa002) RETURNING g_rmaa_m.rmaa002_desc
            DISPLAY BY NAME g_rmaa_m.rmaa002_desc
            
            NEXT FIELD rmaa002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa003
            #add-point:ON ACTION controlp INFIELD rmaa003 name="input.c.rmaa003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmaa_m.rmaa003             #給予default值

            #給予arg
            IF NOT cl_null(g_rmaa_m.rmaadocdt) THEN
               LET g_qryparam.arg1 = g_rmaa_m.rmaadocdt
            ELSE
               LET g_qryparam.arg1 = g_today
            END IF


            CALL q_ooeg001()                                #呼叫開窗

            LET g_rmaa_m.rmaa003 = g_qryparam.return1              

            DISPLAY g_rmaa_m.rmaa003 TO rmaa003              #

            CALL s_desc_get_department_desc(g_rmaa_m.rmaa003) RETURNING g_rmaa_m.rmaa003_desc
            DISPLAY BY NAME g_rmaa_m.rmaa003_desc
            
            NEXT FIELD rmaa003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaastus
            #add-point:ON ACTION controlp INFIELD rmaastus name="input.c.rmaastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmaa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa004
            #add-point:ON ACTION controlp INFIELD rmaa004 name="input.c.rmaa004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmaa_m.rmaa004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1" #s
            LET g_qryparam.where = " xmfostus = 'Y' AND xmfo005 = '",g_rmaa_m.rmaa001,"' "
            #160204-00004#4 Add By Ken 160222(S)
            #組合過濾前後置單據資料SQL
            CALL s_aooi210_get_check_sql(g_site,'',g_rmaa_m.rmaadocno,'4','','xmfodocno') RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_where
               CALL q_xmfodocno_1()
            END IF
            #160204-00004#4 Add By Ken 160222(E)
            #CALL q_xmfodocno_1()           #160204-00004#4 Mark By Ken 160222                     #呼叫開窗

            LET g_rmaa_m.rmaa004 = g_qryparam.return1              
            LET g_rmaa_m.rmaa005 = g_qryparam.return2              
            LET g_rmaa_m.rmaa006 = g_qryparam.return3              

            DISPLAY g_rmaa_m.rmaa004 TO rmaa004              #
            DISPLAY g_rmaa_m.rmaa005 TO rmaa005              #
            DISPLAY g_rmaa_m.rmaa006 TO rmaa006              #

            NEXT FIELD rmaa004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa005
            #add-point:ON ACTION controlp INFIELD rmaa005 name="input.c.rmaa005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmaa_m.rmaa005             #給予default值
            IF NOT cl_null(g_rmaa_m.rmaa001) THEN
               LET g_qryparam.where = " xmdk007 = '",g_rmaa_m.rmaa001,"' AND xmdk000 IN ('1','2','3') "
            ELSE
               LET g_qryparam.where = " xmdk000 IN ('1','2','3') "
            END IF
            #給予arg
            LET g_qryparam.arg1 = "S" #已過帳狀態的出貨單

            #160204-00004#4 Add By Ken 160222(S)
            #組合過濾前後置單據資料SQL
            CALL s_aooi210_get_check_sql(g_site,'',g_rmaa_m.rmaadocno,'4','','xmdkdocno') RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_where
               CALL q_xmdkdocno_3()
            END IF
            #160204-00004#4 Add By Ken 160222(E) 
            #CALL q_xmdkdocno_3()            #160204-00004#4 Mark By Ken 160222                    #呼叫開窗  

            LET g_rmaa_m.rmaa005 = g_qryparam.return1              

            DISPLAY g_rmaa_m.rmaa005 TO rmaa005              #
            
            #帶出訂單單號：預設出貨單單頭訂單號xmdk006
            SELECT xmdk006 INTO g_rmaa_m.rmaa006
              FROM xmdk_t
             WHERE xmdkdocno = g_rmaa_m.rmaa005
               AND xmdkent = g_enterprise
               AND xmdksite = g_site
            DISPLAY g_rmaa_m.rmaa006 TO rmaa006

            NEXT FIELD rmaa005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmaa007
            #add-point:ON ACTION controlp INFIELD rmaa007 name="input.c.rmaa007"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rmaa_m.rmaadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #自動產生單號
               CALL s_aooi200_gen_docno(g_site,g_rmaa_m.rmaadocno,g_rmaa_m.rmaadocdt,g_prog)
               RETURNING l_success,g_rmaa_m.rmaadocno
               IF l_success = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_rmaa_m.rmaadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD rmaadocno
               END IF
               DISPLAY BY NAME g_rmaa_m.rmaadocno
               
               #end add-point
               
               INSERT INTO rmaa_t (rmaaent,rmaadocno,rmaa001,rmaasite,rmaadocdt,rmaa008,rmaa002,rmaa003, 
                   rmaastus,rmaa004,rmaa005,rmaa006,rmaa007,rmaaownid,rmaaowndp,rmaacrtid,rmaacrtdp, 
                   rmaacrtdt,rmaamodid,rmaamoddt,rmaacnfid,rmaacnfdt,rmaapstid,rmaapstdt)
               VALUES (g_enterprise,g_rmaa_m.rmaadocno,g_rmaa_m.rmaa001,g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt, 
                   g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaastus,g_rmaa_m.rmaa004, 
                   g_rmaa_m.rmaa005,g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaowndp, 
                   g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt, 
                   g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rmaa_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               IF NOT cl_null(g_rmaa_m.rmaa004) THEN
                  INITIALIZE gs_keys TO NULL 
                  LET g_detail_idx = 1
                  LET gs_keys[1] = g_rmaa_m.rmaadocno
                  LET gs_keys[2] = g_rmab_d[g_detail_idx].rmabseq
                  LET gs_keys[3] = '1'
                  CALL armt100_insert_b('rmab_t',gs_keys,"'1'")
                  LET g_detail_idx2 = 1
                  LET l_ac = 1
                  LET g_rmab2_d[g_detail_idx2].rmacseq = g_rmab_d[l_ac].rmabseq
                  LET g_rmab2_d[g_detail_idx2].rmacseq1 = '1'
                  LET g_rmab2_d[g_detail_idx2].l_rmab009 = g_rmab_d[l_ac].rmab009
                  LET g_rmab2_d[g_detail_idx2].l_rmab009_desc = g_rmab_d[l_ac].rmab009_desc
                  LET g_rmab2_d[g_detail_idx2].l_rmab009_desc_1 = g_rmab_d[l_ac].rmab009_desc_1
                  LET g_rmab2_d[g_detail_idx2].l_rmab010 = g_rmab_d[l_ac].rmab010
                  LET g_rmab2_d[g_detail_idx2].l_rmab010_desc = g_rmab_d[l_ac].rmab010_desc
                  LET g_rmab2_d[g_detail_idx2].l_rmab011 = g_rmab_d[l_ac].rmab011
                  LET g_rmab2_d[g_detail_idx2].l_rmab011_desc = g_rmab_d[l_ac].rmab011_desc
                  LET g_rmab2_d[g_detail_idx2].rmac001 = g_rmab_d[l_ac].rmab013
                  LET g_rmab2_d[g_detail_idx2].rmac002 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac003 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac004 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac005 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac006 = g_today
                  LET g_rmab2_d[g_detail_idx2].rmac007 = g_user
                  LET g_rmab2_d[g_detail_idx2].rmacsite = g_site
                  CALL s_desc_get_person_desc(g_rmab2_d[g_detail_idx2].rmac007) RETURNING g_rmab2_d[g_detail_idx2].rmac007_desc
                  INITIALIZE gs_keys TO NULL 
                  LET g_detail_idx = g_detail_idx2
                  LET gs_keys[1] = g_rmaa_m.rmaadocno
                  LET gs_keys[2] = g_rmab_d[l_ac].rmabseq
                  LET gs_keys[3] = '1'
                  CALL armt100_insert_b('rmac_t',gs_keys,"'2'")
               END IF
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL cl_set_comp_entry("s_detail2",FALSE)
               END IF               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL armt100_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL armt100_b_fill()
                  CALL armt100_b_fill2('0')
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
               CALL armt100_rmaa_t_mask_restore('restore_mask_o')
               
               UPDATE rmaa_t SET (rmaadocno,rmaa001,rmaasite,rmaadocdt,rmaa008,rmaa002,rmaa003,rmaastus, 
                   rmaa004,rmaa005,rmaa006,rmaa007,rmaaownid,rmaaowndp,rmaacrtid,rmaacrtdp,rmaacrtdt, 
                   rmaamodid,rmaamoddt,rmaacnfid,rmaacnfdt,rmaapstid,rmaapstdt) = (g_rmaa_m.rmaadocno, 
                   g_rmaa_m.rmaa001,g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002, 
                   g_rmaa_m.rmaa003,g_rmaa_m.rmaastus,g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006, 
                   g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaowndp,g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtdp, 
                   g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt,g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfdt, 
                   g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstdt)
                WHERE rmaaent = g_enterprise AND rmaadocno = g_rmaadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rmaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               IF NOT cl_null(g_rmaa_m.rmaa004) AND g_rmaa_m.rmaa004 <> g_rmaa_m_t.rmaa004 THEN
                  INITIALIZE gs_keys TO NULL 
                  LET g_detail_idx = 1
                  LET gs_keys[1] = g_rmaa_m.rmaadocno
                  LET gs_keys[2] = g_rmab_d[g_detail_idx].rmabseq
                  LET gs_keys[3] = '1'
                  CALL armt100_insert_b('rmab_t',gs_keys,"'1'")
                  LET g_detail_idx2 = 1
                  LET l_ac = 1
                  LET g_rmab2_d[g_detail_idx2].rmacseq = g_rmab_d[l_ac].rmabseq
                  LET g_rmab2_d[g_detail_idx2].rmacseq1 = '1'
                  LET g_rmab2_d[g_detail_idx2].l_rmab009 = g_rmab_d[l_ac].rmab009
                  LET g_rmab2_d[g_detail_idx2].l_rmab009_desc = g_rmab_d[l_ac].rmab009_desc
                  LET g_rmab2_d[g_detail_idx2].l_rmab009_desc_1 = g_rmab_d[l_ac].rmab009_desc_1
                  LET g_rmab2_d[g_detail_idx2].l_rmab010 = g_rmab_d[l_ac].rmab010
                  LET g_rmab2_d[g_detail_idx2].l_rmab010_desc = g_rmab_d[l_ac].rmab010_desc
                  LET g_rmab2_d[g_detail_idx2].l_rmab011 = g_rmab_d[l_ac].rmab011
                  LET g_rmab2_d[g_detail_idx2].l_rmab011_desc = g_rmab_d[l_ac].rmab011_desc
                  LET g_rmab2_d[g_detail_idx2].rmac001 = g_rmab_d[l_ac].rmab013
                  LET g_rmab2_d[g_detail_idx2].rmac002 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac003 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac004 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac005 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac006 = g_today
                  LET g_rmab2_d[g_detail_idx2].rmac007 = g_user
                  LET g_rmab2_d[g_detail_idx2].rmacsite = g_site
                  CALL s_desc_get_person_desc(g_rmab2_d[g_detail_idx2].rmac007) RETURNING g_rmab2_d[g_detail_idx2].rmac007_desc
                  INITIALIZE gs_keys TO NULL 
                  LET g_detail_idx = g_detail_idx2
                  LET gs_keys[1] = g_rmaa_m.rmaadocno
                  LET gs_keys[2] = g_rmab_d[l_ac].rmabseq
                  LET gs_keys[3] = '1'
                  CALL armt100_insert_b('rmac_t',gs_keys,"'2'")
               END IF
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL armt100_rmaa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rmaa_m_t)
               LET g_log2 = util.JSON.stringify(g_rmaa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rmaadocno_t = g_rmaa_m.rmaadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="armt100.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rmab_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel1
            LET g_action_choice="s_lot_sel1"
            IF cl_auth_chk_act("s_lot_sel1") THEN
               
               #add-point:ON ACTION s_lot_sel1 name="input.detail_input.page1.s_lot_sel1"
               #160202-00019#1 zhujing add 申请资料
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               
               IF g_rmaa_m.rmaastus <> 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00035'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               
               IF g_rmab_d[g_detail_idx].rmab018 IS NOT NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'arm-00054'      #该资料已自动产生制造批序号资料，不可执行该动作！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               
                
               IF NOT cl_null(g_rmaa_m.rmaadocno) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmabseq) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab009) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab011) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab012) AND
                  NOT cl_null(g_rmaa_m.rmaa002) THEN
                  LET l_success = ''
                  IF s_lot_batch_number_1n3(g_rmab_d[l_ac].rmab009,g_site) THEN
                     CALL s_transaction_begin()
#                     CALL s_axmt540_inao_copy(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'2','','','','',g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,g_rmab2_d[g_detail_idx].rmacseq1,'1','N','1') RETURNING l_success                                    
                     IF armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'0') THEN
                        #160816-00066#1 mod-S
#                        CALL s_lot_sel('2','1',g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab2_d[g_detail_idx].rmac005,
#                                       g_rmab2_d[g_detail_idx].rmac002,g_rmab2_d[g_detail_idx].rmac003,g_rmab2_d[g_detail_idx].rmac004,g_rmab_d[g_detail_idx].rmab011,g_rmab_d[g_detail_idx].rmab012,'1','armt100','',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'',1)
                        CALL s_lot_sel('2','1',g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab2_d[1].rmac005,
                                       g_rmab2_d[1].rmac002,g_rmab2_d[1].rmac003,g_rmab2_d[1].rmac004,g_rmab_d[g_detail_idx].rmab011,g_rmab_d[g_detail_idx].rmab012,'1','armt100','',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'',1)
                           RETURNING l_success   
                        #160816-00066#1 mod-S
#                        IF l_success THEN #2016-5-13 zhujing mod  
                        CALL armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'1') RETURNING l_success  
                        #160202-00019#7 add-S 若只有一个申请数量，则显示序号到栏位中
                        IF g_rmab_d[l_ac].rmab012 = '1' THEN
                           CALL armt100_get_inao009(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq) RETURNING g_rmab_d[g_detail_idx].rmab018,g_rmab_d[g_detail_idx].rmab019,g_rmab_d[g_detail_idx].rmab020
                        END IF
                        #160202-00019#7 add-E
#                        END IF                                             
                     END IF
#                     IF l_success THEN   
#                        CALL s_axmt540_update_inao(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,g_rmab2_d[g_detail_idx].rmacseq1,g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,'-1','2') RETURNING l_success  
#                     END IF
#                     #刪除申請資料                              
#                     DELETE FROM inao_t 
#                      WHERE inaoent = g_enterprise 
#                        AND inaosite = g_site
#                        AND inaodocno = g_rmaa_m.rmaadocno
#                        AND inaoseq = g_rmab_d[g_detail_idx].rmabseq
#                        AND inaoseq1 = g_rmab2_d[g_detail_idx].rmacseq1
#                        AND inao000 = '1'
#                        AND inao013 = '1'
                        
                     IF l_success THEN
                        CALL s_transaction_end('Y','0')
                        IF NOT armt100_ins_inao_2(g_rmab_d[g_detail_idx].rmabseq) THEN
                           NEXT FIELD CURRENT
                        END IF
                        CALL armt100_inao_fill2() 
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                     IF NOT cl_null(g_rmaa_m.rmaadocno) THEN
                        CALL s_lot_b_fill('1',g_site,'1',g_rmaa_m.rmaadocno,'','','1')
                     END IF    
                  END IF
                  LET g_current_row = g_current_idx #目前指標  
               END IF
               #160202-00019#1 zhujing add
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_ins
            LET g_action_choice="s_lot_ins"
            IF cl_auth_chk_act("s_lot_ins") THEN
               
               #add-point:ON ACTION s_lot_ins name="input.detail_input.page1.s_lot_ins"
               #160816-00066#1 add-S   
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'         #单身缺少资料，不可维护！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF g_rmab_d[g_detail_idx].rmab018 IS NOT NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'arm-00054'      #该资料已自动产生制造批序号资料，不可执行该动作！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
                
               IF NOT cl_null(g_rmaa_m.rmaadocno) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmabseq) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab009) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab011) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab012) AND
                  NOT cl_null(g_rmaa_m.rmaa002) THEN
                  LET l_success = ''
                  LET l_amount = ''
                  IF s_lot_batch_number_1n3(g_rmab_d[g_detail_idx].rmab009,g_site) THEN
                     CALL s_transaction_begin()
                     CALL s_lot_ins(g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab_d[g_detail_idx].rmab011,g_rmab_d[g_detail_idx].rmab012,'1',g_rmaa_m.rmaa002,'1','',
                                    g_rmab2_d[1].rmac002,g_rmab2_d[1].rmac003,g_rmab2_d[1].rmac004,g_rmab2_d[g_detail_idx].rmac005)
                          RETURNING l_success,l_amount
                     IF l_success THEN
                        IF NOT armt100_ins_inao_2(g_rmab_d[g_detail_idx].rmabseq) THEN
                           CALL s_transaction_end('N','0')   
                           EXIT DIALOG
                        END IF
                        IF g_rmab_d[g_detail_idx].rmab012 <> l_amount THEN
                           IF cl_ask_confirm('ain-00249') THEN    #该笔资料的数量与制造批序号总数不同，是否更新资料数量为序号总数？
                               
                              UPDATE rmab_t SET rmab012 = l_amount,
                                                inbb013 = l_amount
                               WHERE rmabent = g_enterprise AND rmabsite = g_site
                                 AND rmabdocno = g_rmaa_m.rmaadocno AND rmabseq = g_rmab_d[g_detail_idx].rmabseq
                              IF SQLCA.sqlcode THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = SQLCA.sqlcode
                                 LET g_errparam.extend = "rmab_t"
                                 LET g_errparam.popup = FALSE
                                 CALL cl_err()
                              ELSE
                                 LET g_rmab_d[g_detail_idx].rmab012 = l_amount
                                 LET g_rmab_d[g_detail_idx].rmab013 = l_amount
                                 UPDATE rmac_t SET rmac001 = l_amount
                                  WHERE rmacent = g_enterprise AND rmacsite = g_site
                                    AND rmacdocno = g_rmaa_m.rmaadocno AND rmacseq = g_rmab_d[g_detail_idx].rmabseq  
                                    AND rmacseq1 = 1
                                 IF SQLCA.sqlcode THEN
                                    INITIALIZE g_errparam TO NULL
                                    LET g_errparam.code = SQLCA.sqlcode
                                    LET g_errparam.extend = "rmac_t"
                                    LET g_errparam.popup = FALSE
                                    CALL cl_err()
                                 ELSE
                                    DELETE FROM rmac_t 
                                     WHERE rmacent = g_enterprise AND rmacsite = g_site
                                       AND rmacdocno = g_rmaa_m.rmaadocno AND rmacseq = g_rmab_d[g_detail_idx].rmabseq  
                                       AND rmacseq1 <> 1
                                    IF SQLCA.sqlcode THEN
                                       INITIALIZE g_errparam TO NULL
                                       LET g_errparam.code = SQLCA.sqlcode
                                       LET g_errparam.extend = "rmab_t"
                                       LET g_errparam.popup = FALSE
                                       CALL cl_err()
                                    ELSE
                                       LET g_rmab2_d[1].rmac001 = l_amount    
                                    END IF
                                 END IF
                              END IF
                           END IF
                        END IF
                        CALL armt100_inao_fill2()        
                        CALL s_transaction_end('Y','0')  
                     ELSE
                        CALL s_transaction_end('N','0')   
                     END IF
                  END IF
               END IF
               #160816-00066#1 add-E
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            LET l_num = 0
            SELECT COUNT(rmabseq) INTO l_num
              FROM rmab_t
             WHERE rmabent = g_enterprise
               AND rmabdocno = g_rmaa_m.rmaadocno
            IF cl_null(g_rmaa_m.rmaa004) THEN
#               CALL cl_set_comp_entry("rmabseq,rmab001,rmab003,rmab004,rmab005,rmab006,rmab007,rmab012",TRUE)
               CALL cl_set_comp_entry("rmabseq,rmab001,rmab003,rmab004,rmab012",TRUE)
               CALL cl_set_comp_entry("s_detail1",TRUE)
               CALL cl_set_act_visible("delete,insert",TRUE)
               CALL cl_set_act_visible("modify_detail",TRUE)
            ELSE
               CALL cl_set_comp_entry("rmabseq,rmab001,rmab003,rmab004,rmab005,rmab006,rmab007,rmab008,rmab012",FALSE)
               CALL cl_set_comp_entry("s_detail1",FALSE)
               CALL cl_set_act_visible("delete,insert",FALSE)
               CALL cl_set_act_visible("modify_detail",FALSE)
            END IF
            
            #2016-4-11 zhujing add
            CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_flag1,l_ooac002
            IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0009') = 'Y' THEN
#            IF cl_get_doc_para(g_enterprise,g_site,g_rmaa_m.rmaadocno,'E-MFG-0009') = 'Y' THEN
               CALL cl_set_comp_required("rmab018",TRUE)
            ELSE
               CALL cl_set_comp_required("rmab018",FALSE)
            END IF            
            #2016-4-11 zhujing add
            
            #160816-00066#1 add-S E-MFG-0040=Y时，控制出货单号、项次必输
#            CALL armt100_set_act_visible_b()
#            CALL armt100_set_act_no_visible_b()
            IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'Y' THEN
               CALL cl_set_comp_required("rmaa005,rmab003,rmab004",TRUE)
               CALL cl_set_comp_entry("rmab009,rmab010,rmab011",FALSE)
               CALL cl_set_act_visible('s_lot_ins',FALSE)
               CALL cl_set_act_visible('s_lot_sel1',TRUE)
            ELSE
               CALL cl_set_comp_required("rmaa005,rmab003,rmab004",FALSE)
               CALL cl_set_comp_entry("rmab009,rmab010,rmab011",TRUE)
               CALL cl_set_act_visible('s_lot_ins',TRUE)
               CALL cl_set_act_visible('s_lot_sel1',FALSE)
            END IF
            #160816-00066#1 add-E 
#            IF g_rmaa_m.rmaastus MATCHES '[YXS]' THEN
#               CALL cl_set_comp_entry("s_detail1",FALSE) 
#               CALL cl_set_comp_entry("s_detail2",FALSE) 
#               EXIT DIALOG
#            END IF
#            IF g_open = 'Y' THEN
#               CALL cl_set_act_visible("delete,insert",TRUE)
#               CALL cl_set_act_visible("modify_detail",TRUE)
#               CALL cl_set_comp_entry("s_detail1",FALSE) 
#            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rmab_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL armt100_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rmab_d.getLength()
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
            OPEN armt100_cl USING g_enterprise,g_rmaa_m.rmaadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt100_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE armt100_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rmab_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rmab_d[l_ac].rmabseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rmab_d_t.* = g_rmab_d[l_ac].*  #BACKUP
               LET g_rmab_d_o.* = g_rmab_d[l_ac].*  #BACKUP
               CALL armt100_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL armt100_set_no_entry_b(l_cmd)
               IF NOT armt100_lock_b("rmab_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH armt100_bcl INTO g_rmab_d[l_ac].rmabseq,g_rmab_d[l_ac].rmab018,g_rmab_d[l_ac].rmab019, 
                      g_rmab_d[l_ac].rmab020,g_rmab_d[l_ac].rmab001,g_rmab_d[l_ac].rmab002,g_rmab_d[l_ac].rmab003, 
                      g_rmab_d[l_ac].rmab004,g_rmab_d[l_ac].rmab005,g_rmab_d[l_ac].rmab006,g_rmab_d[l_ac].rmab007, 
                      g_rmab_d[l_ac].rmab008,g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010,g_rmab_d[l_ac].rmab011, 
                      g_rmab_d[l_ac].rmab021,g_rmab_d[l_ac].rmab022,g_rmab_d[l_ac].rmab012,g_rmab_d[l_ac].rmab013, 
                      g_rmab_d[l_ac].rmab014,g_rmab_d[l_ac].rmab015,g_rmab_d[l_ac].rmab016,g_rmab_d[l_ac].rmab017, 
                      g_rmab_d[l_ac].rmabsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rmab_d_t.rmabseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rmab_d_mask_o[l_ac].* =  g_rmab_d[l_ac].*
                  CALL armt100_rmab_t_mask()
                  LET g_rmab_d_mask_n[l_ac].* =  g_rmab_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL armt100_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET l_rmabseq_backup = g_rmab_d[l_ac].rmabseq  #備份退品明細項次
            IF l_cmd = 'a' THEN
               INITIALIZE g_rmab_d_t.* TO NULL 
               INITIALIZE g_rmab_d_o.* TO NULL             
            END IF
            IF NOT cl_null(g_rmab_d[l_ac].rmab018) THEN
               CALL cl_set_comp_entry("rmab001,rmab003,rmab004,rmab005,rmab006,rmab007,rmab008,rmab009,rmab019,rmab020",FALSE)
               CALL cl_set_comp_entry("rmab010,rmab011",FALSE) #160816-00066#1 add
            ELSE
               CALL cl_set_comp_entry("rmab001,rmab003,rmab004",TRUE)
            END IF
            #160816-00066#1 add-S E-MFG-0040=Y时，控制出货单号、项次必输,否则可直接录入料号
            IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'Y' THEN
               CALL cl_set_comp_required("rmaa005,rmab003,rmab004",TRUE)
               CALL cl_set_comp_entry("rmab009,rmab010,rmab011",FALSE)
            ELSE
               CALL cl_set_comp_required("rmaa005,rmab003,rmab004",FALSE)
               CALL cl_set_comp_entry("rmab009,rmab010,rmab011",TRUE)
            END IF
            #160816-00066#1 add-E 
            CALL armt100_set_no_required()         #160202-00019#1 2016-2-18 zhujing add
            CALL armt100_set_required()            #160202-00019#1 2016-2-18 zhujing add
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
            INITIALIZE g_rmab_d[l_ac].* TO NULL 
            INITIALIZE g_rmab_d_t.* TO NULL 
            INITIALIZE g_rmab_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rmab_d[l_ac].rmab018 = "0"
      LET g_rmab_d[l_ac].rmab012 = "0"
      LET g_rmab_d[l_ac].rmab013 = "0"
      LET g_rmab_d[l_ac].rmab014 = "0"
      LET g_rmab_d[l_ac].rmab015 = "0"
      LET g_rmab_d[l_ac].rmab016 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_rmab_d[l_ac].rmab018 = NULL
            #end add-point
            LET g_rmab_d_t.* = g_rmab_d[l_ac].*     #新輸入資料
            LET g_rmab_d_o.* = g_rmab_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL armt100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            #160816-00066#1 add-S
            LET g_rmab_d[l_ac].rmab021 = NULL
            LET g_rmab_d[l_ac].rmab022 = 'N'
            #160816-00066#1 add-E
            IF l_cmd_t = 'r' THEN
               FOR l_num = 1 TO g_rmab_d.getLength()   
                  LET g_rmab_d[l_num].rmab012 = l_num
                  IF NOT armt100_rmab_default_insert(g_rmab_d[l_num].rmab003,g_rmab_d[l_num].rmab004) THEN
                     LET g_rmab_d[l_num].rmab012 = '0' 
                  END IF
                  IF g_rmab_d[l_num].rmab012 = '0' OR cl_null(g_rmab_d[l_num].rmab012) THEN
                     CALL g_rmab_d.deleteElement(l_num)
                     LET l_num = l_num-1
                  END IF
                  IF g_rmab_d.getLength() = '0' THEN
                     EXIT FOR
                  END IF
               END FOR
            END IF
            IF cl_null(g_rmaa_m.rmaa004) THEN
               CALL cl_set_comp_entry("rmab001,rmab003,rmab004",TRUE)
#               CALL cl_set_comp_entry("rmab001,rmab003,rmab004,rmab005,rmab006,rmab007",TRUE)
               CALL cl_set_comp_entry("s_detail1",TRUE)
               CALL cl_set_act_visible("delete,insert",TRUE)
               CALL cl_set_act_visible("modify_detail",TRUE)
            ELSE
               CALL armt100_rmaa004_default(g_rmaa_m.rmaa004)
               LET g_rmab_d[l_ac].rmab001 = g_rmaa_m.rmaa004
               LET g_rmab_d[l_ac].rmab003 = g_rmaa_m.rmaa005
               LET g_rmab_d[l_ac].rmab005 = g_rmaa_m.rmaa006
               DISPLAY BY NAME g_rmab_d[l_ac].rmab001
               DISPLAY BY NAME g_rmab_d[l_ac].rmab003
               DISPLAY BY NAME g_rmab_d[l_ac].rmab005
               CALL cl_set_comp_entry("rmab001,rmab003,rmab004,rmab005,rmab006,rmab007,rmab008",FALSE)
               CALL cl_set_comp_entry("s_detail1",FALSE)
               CALL cl_set_act_visible("delete,insert",FALSE)
               CALL cl_set_act_visible("modify_detail",FALSE)
               EXIT DIALOG
            END IF
            IF cl_null(g_rmaa_m.rmaa005) THEN
               CALL cl_set_comp_entry("rmab003",TRUE)
            ELSE
               LET g_rmab_d[l_ac].rmab003 = g_rmaa_m.rmaa005
               DISPLAY BY NAME g_rmab_d[l_ac].rmab003
               CALL cl_set_comp_entry("rmab003",FALSE)
            END IF
            #end add-point
            CALL armt100_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rmab_d[li_reproduce_target].* = g_rmab_d[li_reproduce].*
 
               LET g_rmab_d[li_reproduce_target].rmabseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            #預設客訴單號-----(S)
            #客訴單未建立，邏輯待添加 TO BE ADDED
#            IF NOT cl_null(g_rmaa_m.rmaa004) THEN
#               LET g_rmab_d[l_ac].rmab001 = g_rmaa_m.rmaa004
#            END IF
            #預設客訴單號-----(E)
            
            #預設出貨單號
#            IF NOT cl_null(g_rmaa_m.rmaa005) THEN
#               LET g_rmab_d[l_ac].rmab003 = g_rmaa_m.rmaa005
#               #預設訂單單號
#               IF NOT cl_null(g_rmaa_m.rmaa006) THEN
#                   SELECT xmdl004 INTO g_rmab_d[g_detail_idx].rmab004
#                    FROM xmdl_t
#                   WHERE xmdldocno = g_rmaa_m.rmaa005
#                     AND xmdlent = g_enterprise
#                     AND xmdlsite = g_site
#                     AND xmdl003 = g_rmaa_m.rmaa006
#                  LET g_rmab_d[l_ac].rmab005 = g_rmaa_m.rmaa006
#               END IF
#            END IF
            #預設項次
            IF cl_null(g_rmab_d[l_ac].rmabseq) THEN
               SELECT MAX(rmabseq)+1
                 INTO g_rmab_d[l_ac].rmabseq
                 FROM rmab_t
                WHERE rmabent = g_enterprise
                  AND rmabdocno = g_rmaa_m.rmaadocno 

               IF cl_null(g_rmab_d[l_ac].rmabseq) THEN
                 LET g_rmab_d[l_ac].rmabseq = 1
               END IF
            END IF
            LET g_rmab_d[l_ac].rmabsite = g_site
            LET g_rmab_d_t.rmabseq = g_rmab_d[l_ac].rmabseq
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
            SELECT COUNT(1) INTO l_count FROM rmab_t 
             WHERE rmabent = g_enterprise AND rmabdocno = g_rmaa_m.rmaadocno
 
               AND rmabseq = g_rmab_d[l_ac].rmabseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
 
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmaa_m.rmaadocno
               LET gs_keys[2] = g_rmab_d[g_detail_idx].rmabseq
               CALL armt100_insert_b('rmab_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               LET l_rmabseq_backup = g_rmab_d[l_ac].rmabseq  #備份退品明細項次
               IF g_detail_idx2 = 0 OR cl_null(g_detail_idx2) THEN
                  LET g_detail_idx2 = 1
               END IF
               IF armt100_del_rmac() THEN
                  
                  LET g_rmab2_d[g_detail_idx2].rmacseq = g_rmab_d[l_ac].rmabseq
                  LET g_rmab2_d[g_detail_idx2].rmacseq1 = '1'
                  LET g_rmab2_d[g_detail_idx2].l_rmab009 = g_rmab_d[l_ac].rmab009
                  LET g_rmab2_d[g_detail_idx2].l_rmab009_desc = g_rmab_d[l_ac].rmab009_desc
                  LET g_rmab2_d[g_detail_idx2].l_rmab009_desc_1 = g_rmab_d[l_ac].rmab009_desc_1
                  LET g_rmab2_d[g_detail_idx2].l_rmab010 = g_rmab_d[l_ac].rmab010
                  LET g_rmab2_d[g_detail_idx2].l_rmab010_desc = g_rmab_d[l_ac].rmab010_desc
                  LET g_rmab2_d[g_detail_idx2].l_rmab011 = g_rmab_d[l_ac].rmab011
                  LET g_rmab2_d[g_detail_idx2].l_rmab011_desc = g_rmab_d[l_ac].rmab011_desc
                  LET g_rmab2_d[g_detail_idx2].rmac001 = g_rmab_d[l_ac].rmab013
                  LET g_rmab2_d[g_detail_idx2].rmac002 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac003 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac004 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac005 = ' '
                  LET g_rmab2_d[g_detail_idx2].rmac006 = g_today
                  LET g_rmab2_d[g_detail_idx2].rmac007 = g_user
                  LET g_rmab2_d[g_detail_idx2].rmacsite = g_site
                  CALL s_desc_get_person_desc(g_rmab2_d[g_detail_idx2].rmac007) RETURNING g_rmab2_d[g_detail_idx2].rmac007_desc
                  INITIALIZE gs_keys TO NULL 
                  LET g_detail_idx = g_detail_idx2
                  LET gs_keys[1] = g_rmaa_m.rmaadocno
                  LET gs_keys[2] = g_rmab_d[l_ac].rmabseq
                  LET gs_keys[3] = '1'
                  CALL armt100_insert_b('rmac_t',gs_keys,"'2'")
               END IF
               
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rmab_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmab_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL armt100_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               CALL armt100_b_fill()
               CALL armt100_inao_fill2()     #2016-4-15 zhujing add
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
               LET gs_keys[01] = g_rmaa_m.rmaadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_rmab_d_t.rmabseq
 
            
               #刪除同層單身
               IF NOT armt100_delete_b('rmab_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt100_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT armt100_key_delete_b(gs_keys,'rmab_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt100_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #160202-00019#1---add---begin
               #同步刪除對應的[T:製造批序號庫存異動明細檔]
               CALL armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'0') RETURNING l_success  
               
               DELETE FROM inao_t
                  WHERE inaoent = g_enterprise 
                    AND inaosite = g_site 
                    AND inaodocno = g_rmaa_m.rmaadocno
                    AND inaoseq = g_rmab_d[l_ac].rmabseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inao_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()           
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF  
               #160202-00019#1---add---end   
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE armt100_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               INITIALIZE g_rmab_d_t.* TO NULL 
               INITIALIZE g_rmab_d_o.* TO NULL 
               #add rmac_delete
               #add inao_delete
               #end add-point
               LET l_count = g_rmab_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
#               CALL armt100_b_fill()
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rmab_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmabseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmab_d[l_ac].rmabseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD rmabseq
            END IF 
 
 
 
            #add-point:AFTER FIELD rmabseq name="input.a.page1.rmabseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rmaa_m.rmaadocno IS NOT NULL AND g_rmab_d[g_detail_idx].rmabseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rmaa_m.rmaadocno != g_rmaadocno_t OR g_rmab_d[g_detail_idx].rmabseq != g_rmab_d_t.rmabseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmab_t WHERE "||"rmabent = '" ||g_enterprise|| "' AND "||"rmabdocno = '"||g_rmaa_m.rmaadocno ||"' AND "|| "rmabseq = '"||g_rmab_d[g_detail_idx].rmabseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmabseq
            #add-point:BEFORE FIELD rmabseq name="input.b.page1.rmabseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmabseq
            #add-point:ON CHANGE rmabseq name="input.g.page1.rmabseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab018
            #add-point:BEFORE FIELD rmab018 name="input.b.page1.rmab018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab018
            
            #add-point:AFTER FIELD rmab018 name="input.a.page1.rmab018"
            #160202-00019#1 2016-2-18 zhujing add---(S)
            IF NOT cl_null(g_rmab_d[g_detail_idx].rmab018) AND (g_rmab_d[g_detail_idx].rmab018 <> g_rmab_d_t.rmab018 OR cl_null(g_rmab_d_t.rmab018)) THEN
               #若E-MFG-0010=Y，需检查输入序号存在于aini011中，依输入序号带出以下值
               CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_flag1,l_ooac002
               IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0010') = 'Y' THEN 
                  LET l_cnt = 0
                  CALL armt100_get_slip_locate() RETURNING l_start,l_length
                  SELECT COUNT(*) INTO l_cnt FROM inao_t WHERE inaoent = g_enterprise AND inaosite = g_site AND inao009 = g_rmab_d[g_detail_idx].rmab018
#                  AND substr(inaodocno,l_start,l_length) IN (SELECT oobx001 FROM oobx_t WHERE oobxent = g_enterprise AND oobx003 = 'axmt540')
                  IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'arm-00043'   #该序号不存在于[料件制造批序号数据维护作业(aini011)]中，请查询后重新输入！
                     LET g_errparam.extend = g_rmab_d[g_detail_idx].rmab018
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_rmab_d[g_detail_idx].rmab018 = g_rmab_d_o.rmab018
                     NEXT FIELD CURRENT
                  END IF
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt 
                  FROM (
                  SELECT DISTINCT inaodocno,inaoseq FROM inao_t WHERE inaoent = g_enterprise AND inaosite = g_site AND inao009 = g_rmab_d[g_detail_idx].rmab018
                  AND substr(inaodocno,l_start,l_length) IN (SELECT oobx001 FROM oobx_t WHERE oobxent = g_enterprise AND oobx003 = 'axmt540'))
                  IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'arm-00046'   #该序号没有对应的出货单号！
                     LET g_errparam.extend = g_rmab_d[g_detail_idx].rmab018
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_rmab_d[g_detail_idx].rmab018 = g_rmab_d_o.rmab018
                     NEXT FIELD CURRENT
                  END IF
                  IF l_cnt = 1 THEN
                     #依输入序号带出以下值（带出的值不可修改）：料号、客诉单、出货单号、项次、订单号、订单项次项序、生产日期、有效日期
                     #rmab009,rmab001,rmab003,rmab004,rmab005,rmab006,rmab007,rmab019,rmab020
                     IF armt100_rmab018_default(g_rmab_d[g_detail_idx].rmab018) THEN
                        CALL cl_set_comp_entry("rmab001,rmab003,rmab004,rmab005,rmab006,rmab007,rmab008,rmab009,rmab019,rmab020",FALSE)
                        CALL cl_set_comp_entry("rmab010,rmab011",FALSE) #160816-00066#1 add
                        #160816-00066#1 add-S E-MFG-0040=Y时，控制出货单号、项次必输,否则可直接录入料号
                        IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'Y' THEN
                           CALL cl_set_comp_required("rmaa005,rmab003,rmab004",TRUE)
                           CALL cl_set_comp_entry("rmab009,rmab010,rmab011",FALSE)
                        ELSE
                           CALL cl_set_comp_required("rmaa005,rmab003,rmab004",FALSE)
                           CALL cl_set_comp_entry("rmab009,rmab010,rmab011",TRUE)
                        END IF
                        #160816-00066#1 add-E 
                        NEXT FIELD rmab012
                     ELSE
                        LET g_rmab_d[g_detail_idx].rmab018 = g_rmab_d_o.rmab018
                        LET g_rmab_d[g_detail_idx].* = g_rmab_d_o.*
                        LET g_rmab_d[g_detail_idx].rmabseq = g_rmab_d_t.rmabseq
                        NEXT FIELD CURRENT 
                     END IF
                  ELSE
#                     CALL cl_set_comp_entry("rmab001,rmab003,rmab004,rmab005,rmab006,rmab007,rmab009,rmab019,rmab020",TRUE)
                     CALL cl_set_comp_entry("rmab001,rmab003,rmab004,rmab009,rmab019,rmab020",TRUE)
                     CALL cl_set_comp_entry("rmab010,rmab011",TRUE) #160816-00066#1 add
                     #160816-00066#1 add-S E-MFG-0040=Y时，控制出货单号、项次必输,否则可直接录入料号
                     IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'Y' THEN
                        CALL cl_set_comp_required("rmaa005,rmab003,rmab004",TRUE)
                        CALL cl_set_comp_entry("rmab009,rmab010,rmab011",FALSE)
                     ELSE
                        CALL cl_set_comp_required("rmaa005,rmab003,rmab004",FALSE)
                        CALL cl_set_comp_entry("rmab009,rmab010,rmab011",TRUE)
                     END IF
                     #160816-00066#1 add-E 
                  END IF
               END IF
            END IF
            #160202-00019#1 2016-2-18 zhujing add---(E)
#            IF (g_rmab_d[g_detail_idx].rmab018 <> g_rmab_d_t.rmab018 OR cl_null(g_rmab_d[g_detail_idx].rmab018) OR cl_null(g_rmab_d_t.rmab018)) AND g_rmab_d[l_ac].rmab012 = 1 THEN
#               LET g_rmab_d[l_ac].rmab018 = armt100_get_inao009(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq)
#               LET g_rmab_d_t.rmab018 = g_rmab_d[l_ac].rmab018
#            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab018
            #add-point:ON CHANGE rmab018 name="input.g.page1.rmab018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab001
            #add-point:BEFORE FIELD rmab001 name="input.b.page1.rmab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab001
            
            #add-point:AFTER FIELD rmab001 name="input.a.page1.rmab001"
            IF NOT cl_null(g_rmab_d[g_detail_idx].rmab001) THEN 
            #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmab_d[g_detail_idx].rmab001
               LET g_chkparam.arg2 = g_rmaa_m.rmaa001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xmfodocno") THEN  #已過帳狀態的出貨單   
                  #檢查成功時後續處理
                  CALL armt100_rmaa004_default(g_rmab_d[g_detail_idx].rmab001)
                  IF NOT cl_null(g_rmab_d[g_detail_idx].rmab001) THEN
                     CALL cl_set_comp_entry("rmab012",FALSE)
                  ELSE
                     CALL cl_set_comp_entry("rmab012",TRUE)
                  END IF
#                  IF NOT cl_null(g_rmab_d[g_detail_idx].rmab012) AND NOT cl_null(g_rmab_d[g_detail_idx].rmab001) THEN
#                     IF NOT armt100_rmab012_chk(g_rmab_d[g_detail_idx].rmab001,'') THEN      #檢查申請退貨數量-->有客訴單則檢查客訴數量
#                        LET g_rmab_d[g_detail_idx].rmab012 = g_rmab_d_o.rmab012
#                        NEXT FIELD rmab012
#                     END IF
#                  END IF
                ELSE
                  LET g_rmab_d[g_detail_idx].rmab001 = g_rmab_d_o.rmab001            
                  NEXT FIELD CURRENT
                END IF
                                
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab001
            #add-point:ON CHANGE rmab001 name="input.g.page1.rmab001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab002
            #add-point:BEFORE FIELD rmab002 name="input.b.page1.rmab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab002
            
            #add-point:AFTER FIELD rmab002 name="input.a.page1.rmab002"
            IF NOT cl_null(g_rmab_d[g_detail_idx].rmab001) AND NOT cl_null(g_rmab_d[g_detail_idx].rmab002) THEN 
               IF NOT armt100_rmab002_chk(g_rmab_d[g_detail_idx].rmab001,g_rmab_d[g_detail_idx].rmab002) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'arm-00041'   #该客诉单+项次不存在[客诉单维护作业(axmt700)]!
                  LET g_errparam.extend = g_rmaa_m.rmaa008
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rmab_d[g_detail_idx].rmab002 = g_rmab_d_o.rmab002
                  NEXT FIELD CURRENT
               ELSE
                  
               END IF
                                
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab002
            #add-point:ON CHANGE rmab002 name="input.g.page1.rmab002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab003
            
            #add-point:AFTER FIELD rmab003 name="input.a.page1.rmab003"
            #判斷是否已過帳
            IF NOT cl_null(g_rmab_d[g_detail_idx].rmab003) THEN 
            #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmab_d[g_detail_idx].rmab003
               LET g_chkparam.arg2 = g_rmaa_m.rmaa001
               #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="ais-00109:sub-01311|axmt540|",cl_get_progname("axmt540",g_lang,"2"),"|:EXEPROGaxmt540"
               #160318-00025#21  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xmdkdocno_6") THEN  #已過帳狀態的出貨單   
                  #檢查成功時後續處理
                  IF NOT cl_null(g_rmaa_m.rmaa005) AND g_rmaa_m.rmaa005 <>g_rmab_d[g_detail_idx].rmab003 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "axm-00520"   #單身來源單號不可與單頭不同！
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_rmab_d[g_detail_idx].rmab003 = g_rmab_d_o.rmab003            
                     NEXT FIELD rmab003
                  END IF
                  IF NOT cl_null(g_rmab_d[g_detail_idx].rmab012) AND NOT cl_null(g_rmab_d[g_detail_idx].rmab004) AND NOT cl_null(g_rmab_d[g_detail_idx].rmab003) THEN
                     IF NOT armt100_rmab012_chk(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004) THEN
                        LET g_rmab_d[g_detail_idx].rmab012 = g_rmab_d_o.rmab012
                        NEXT FIELD rmab012
                     END IF
                  END IF
                ELSE
                  LET g_rmab_d[g_detail_idx].rmab003 = g_rmab_d_o.rmab003            
                  NEXT FIELD rmab003
                END IF
#               IF NOT cl_null(g_rmaa_m.rmaa006) AND NOT cl_null(g_rmaa_m.rmaa005) THEN
#                  SELECT xmdl004 INTO g_rmab_d[g_detail_idx].rmab004
#                    FROM xmdl_t
#                   WHERE xmdldocno = g_rmaa_m.rmaa005
#                     AND xmdlent = g_enterprise
#                     AND xmdlsite = g_site
#                     AND xmdl003 = g_rmaa_m.rmaa006
#               END IF
               #預設訂單單號、訂單項次、訂單項序、分批序。料號、產品特征、單位、申請退貨數量
               IF (NOT cl_null(g_rmab_d[g_detail_idx].rmab003) AND NOT cl_null(g_rmab_d[g_detail_idx].rmab004) AND cl_null(g_rmab_d[g_detail_idx].rmab005))
                  AND (g_rmab_d[g_detail_idx].rmab003<>g_rmab_d_o.rmab003 OR cl_null(g_rmab_d_o.rmab003)
                  OR g_rmab_d[g_detail_idx].rmab004<>g_rmab_d_o.rmab004 OR cl_null(g_rmab_d_o.rmab004)) THEN
                  CALL armt100_rmab_default_insert(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004) 
                     RETURNING l_success
                  IF NOT l_success THEN
                     #賦予舊值
                     LET g_rmab_d[g_detail_idx].rmab005 = g_rmab_d_o.rmab005
                     LET g_rmab_d[g_detail_idx].rmab006 = g_rmab_d_o.rmab006
                     LET g_rmab_d[g_detail_idx].rmab007 = g_rmab_d_o.rmab007
                     LET g_rmab_d[g_detail_idx].rmab008 = g_rmab_d_o.rmab008
                     LET g_rmab_d[g_detail_idx].rmab009 = g_rmab_d_o.rmab009
                     LET g_rmab_d[g_detail_idx].rmab009_desc = g_rmab_d_o.rmab009_desc
                     LET g_rmab_d[g_detail_idx].rmab009_desc_1 = g_rmab_d_o.rmab009_desc_1
                     LET g_rmab_d[g_detail_idx].rmab010 = g_rmab_d_o.rmab010
                     LET g_rmab_d[g_detail_idx].rmab010_desc = g_rmab_d_o.rmab010_desc
                     LET g_rmab_d[g_detail_idx].rmab011 = g_rmab_d_o.rmab011
                     LET g_rmab_d[g_detail_idx].rmab011_desc = g_rmab_d_o.rmab011_desc
                     LET g_rmab_d[g_detail_idx].rmab012 = g_rmab_d_o.rmab012
                     LET g_rmab_d[g_detail_idx].rmab013 = g_rmab_d_o.rmab013
                  END IF
               END IF
                  
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab003
            #add-point:BEFORE FIELD rmab003 name="input.b.page1.rmab003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab003
            #add-point:ON CHANGE rmab003 name="input.g.page1.rmab003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmab_d[l_ac].rmab004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD rmab004
            END IF 
 
 
 
            #add-point:AFTER FIELD rmab004 name="input.a.page1.rmab004"
            #預設訂單單號、訂單項次、訂單項序、分批序。料號、產品特征、單位、申請退貨數量
            IF (NOT cl_null(g_rmab_d[g_detail_idx].rmab003) AND NOT cl_null(g_rmab_d[g_detail_idx].rmab004))# AND cl_null(g_rmab_d[g_detail_idx].rmab005))
               AND (g_rmab_d[g_detail_idx].rmab003<>g_rmab_d_o.rmab003 OR cl_null(g_rmab_d_o.rmab003) 
               OR g_rmab_d[g_detail_idx].rmab004<>g_rmab_d_o.rmab004 OR cl_null(g_rmab_d_o.rmab004)) THEN
               IF NOT armt100_rmab004_chk(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004) THEN
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'axm-00208'   #此来源单号下无此项次,请检查！       #160318-00005#42  mark
                  LET g_errparam.code = 'sub-01306'      #160318-00005#42  add
                  LET g_errparam.extend = g_rmaa_m.rmaa008
                  #160318-00005#42 --s add
                  LET g_errparam.replace[1] = 'axmt540'
                  LET g_errparam.replace[2] = cl_get_progname('axmt540',g_lang,"2")
                  LET g_errparam.exeprog = 'axmt540'
                  #160318-00005#42 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rmab_d[g_detail_idx].rmab004 = g_rmab_d_o.rmab004
                  NEXT FIELD CURRENT
               ELSE
                  CALL armt100_rmab_default_insert(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004) 
                     RETURNING l_success
                  IF NOT l_success THEN
                     #賦予舊值
                     LET g_rmab_d[g_detail_idx].rmab005 = g_rmab_d_o.rmab005
                     LET g_rmab_d[g_detail_idx].rmab006 = g_rmab_d_o.rmab006
                     LET g_rmab_d[g_detail_idx].rmab007 = g_rmab_d_o.rmab007
                     LET g_rmab_d[g_detail_idx].rmab008 = g_rmab_d_o.rmab008
                     LET g_rmab_d[g_detail_idx].rmab009 = g_rmab_d_o.rmab009
                     LET g_rmab_d[g_detail_idx].rmab009_desc = g_rmab_d_o.rmab009_desc
                     LET g_rmab_d[g_detail_idx].rmab009_desc_1 = g_rmab_d_o.rmab009_desc_1
                     LET g_rmab_d[g_detail_idx].rmab010 = g_rmab_d_o.rmab010
                     LET g_rmab_d[g_detail_idx].rmab010_desc = g_rmab_d_o.rmab010_desc
                     LET g_rmab_d[g_detail_idx].rmab011 = g_rmab_d_o.rmab011
                     LET g_rmab_d[g_detail_idx].rmab011_desc = g_rmab_d_o.rmab011_desc
                     LET g_rmab_d[g_detail_idx].rmab012 = g_rmab_d_o.rmab012
                     LET g_rmab_d[g_detail_idx].rmab013 = g_rmab_d_o.rmab013
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab004
            #add-point:BEFORE FIELD rmab004 name="input.b.page1.rmab004"
#            IF NOT cl_null(g_rmaa_m.rmaa006) AND NOT cl_null(g_rmaa_m.rmaa005) THEN
#               SELECT xmdl004 INTO g_rmab_d[g_detail_idx].rmab004
#                 FROM xmdl_t
#                WHERE xmdldocno = g_rmaa_m.rmaa005
#                  AND xmdlent = g_enterprise
#                  AND xmdlsite = g_site
#                  AND xmdl003 = g_rmaa_m.rmaa006
#            END IF
            #預設訂單單號、訂單項次、訂單項序、分批序。料號、產品特征、單位、申請退貨數量
            IF (NOT cl_null(g_rmab_d[g_detail_idx].rmab003) AND NOT cl_null(g_rmab_d[g_detail_idx].rmab004) AND cl_null(g_rmab_d[g_detail_idx].rmab005))
               AND (g_rmab_d[g_detail_idx].rmab003<>g_rmab_d_o.rmab003 OR cl_null(g_rmab_d_o.rmab003) 
               OR g_rmab_d[g_detail_idx].rmab004<>g_rmab_d_o.rmab004 OR cl_null(g_rmab_d_o.rmab004)) THEN
               CALL armt100_rmab_default_insert(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004) 
                  RETURNING l_success
               IF NOT l_success THEN
                  #賦予舊值
                  LET g_rmab_d[g_detail_idx].rmab005 = g_rmab_d_o.rmab005
                  LET g_rmab_d[g_detail_idx].rmab006 = g_rmab_d_o.rmab006
                  LET g_rmab_d[g_detail_idx].rmab007 = g_rmab_d_o.rmab007
                  LET g_rmab_d[g_detail_idx].rmab008 = g_rmab_d_o.rmab008
                  LET g_rmab_d[g_detail_idx].rmab009 = g_rmab_d_o.rmab009
                  LET g_rmab_d[g_detail_idx].rmab009_desc = g_rmab_d_o.rmab009_desc
                  LET g_rmab_d[g_detail_idx].rmab009_desc_1 = g_rmab_d_o.rmab009_desc_1
                  LET g_rmab_d[g_detail_idx].rmab010 = g_rmab_d_o.rmab010
                  LET g_rmab_d[g_detail_idx].rmab010_desc = g_rmab_d_o.rmab010_desc
                  LET g_rmab_d[g_detail_idx].rmab011 = g_rmab_d_o.rmab011
                  LET g_rmab_d[g_detail_idx].rmab011_desc = g_rmab_d_o.rmab011_desc
                  LET g_rmab_d[g_detail_idx].rmab012 = g_rmab_d_o.rmab012
                  LET g_rmab_d[g_detail_idx].rmab013 = g_rmab_d_o.rmab013
               END IF
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab004
            #add-point:ON CHANGE rmab004 name="input.g.page1.rmab004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab009
            
            #add-point:AFTER FIELD rmab009 name="input.a.page1.rmab009"
            IF NOT cl_null(g_rmab_d[l_ac].rmab009) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmab_d[l_ac].rmab009

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaf001_1") THEN
                  #檢查成功時後續處理
                  #160816-00066#1 若料号调整，则清空批序号，重新新增
                  IF g_rmab_d[l_ac].rmab009 <> g_rmab_d_t.rmab009 OR cl_null(g_rmab_d_t.rmab009) THEN
                     IF armt100_del_inao(g_rmaa_m.rmaadocno,g_rmab_d[l_ac].rmabseq) THEN
                        LET g_rmab_d_t.rmab009 = g_rmab_d[l_ac].rmab009
                        LET g_rmab_d_t.rmab012 = -1                
                        IF NOT cl_null(g_rmab_d[l_ac].rmab018) THEN
                           LET g_rmab_d[l_ac].rmab018 = NULL
                           LET g_rmab_d[l_ac].rmab019 = NULL
                           LET g_rmab_d[l_ac].rmab020 = NULL
                        END IF
                     ELSE
                        LET g_rmab_d[l_ac].rmab009 = g_rmab_d_t.rmab009
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               
            END IF 
            LET l_imaa005 = ''
            SELECT imaa005 INTO l_imaa005
              FROM imaa_t
             WHERE imaa001 = g_rmab_d[l_ac].rmab009
               AND imaaent = g_enterprise
            CALL l_inam.clear()
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN
               IF NOT cl_null(l_imaa005) THEN
                  CALL cl_set_comp_entry("rmab010",TRUE)
                  IF l_cmd = 'a' THEN     
                     IF s_feature_auto_chk(g_rmab_d[l_ac].rmab009) AND cl_null(g_rmab_d[l_ac].rmab010) THEN #160314-00009#9 
                        CALL s_feature(l_cmd,g_rmab_d[l_ac].rmab009,'','',g_site,g_rmaa_m.rmaadocno) RETURNING l_success,l_inam
                        LET g_rmab_d[l_ac].rmab010 = l_inam[1].inam002
                        LET g_rmab_d[l_ac].rmab012 = l_inam[1].inam004
                        DISPLAY BY NAME g_rmab_d[l_ac].rmab010,g_rmab_d[l_ac].rmab012 
                     END IF
                  END IF
               ELSE
                  CALL cl_set_comp_entry("rmab010",FALSE)
                  LET g_rmab_d[l_ac].rmab010 = ' '
                  LET g_rmab_d[l_ac].rmab010_desc = ''
               END IF
            ELSE
               LET g_rmab_d[l_ac].rmab010 = ' '
               LET g_rmab_d[l_ac].rmab010_desc = ''
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmab_d[l_ac].rmab009
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent="||g_enterprise||" AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmab_d[l_ac].rmab009_desc = '', g_rtn_fields[1] , ''
            LET g_rmab_d[l_ac].rmab009_desc_1 = '',g_rtn_fields[2], ''
            DISPLAY BY NAME g_rmab_d[l_ac].rmab009_desc
            DISPLAY BY NAME g_rmab_d[l_ac].rmab009_desc_1


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab009
            #add-point:BEFORE FIELD rmab009 name="input.b.page1.rmab009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab009
            #add-point:ON CHANGE rmab009 name="input.g.page1.rmab009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab010
            
            #add-point:AFTER FIELD rmab010 name="input.a.page1.rmab010"
            #160816-00066#1 add-S
            CALL s_feature_description(g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010) RETURNING l_success,g_rmab_d[l_ac].rmab010_desc
            DISPLAY BY NAME g_rmab_d[l_ac].rmab010_desc
            IF NOT cl_null(g_rmab_d[l_ac].rmab010) THEN
               IF NOT s_feature_check(g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010) THEN
                  LET g_rmab_d[l_ac].rmab010 = g_rmab_d_t.rmab010
                  CALL s_feature_description(g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010) RETURNING l_success,g_rmab_d[l_ac].rmab010_desc
                  DISPLAY BY NAME g_rmab_d[l_ac].rmab010_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_feature_direct_input(g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010,g_rmab_d_t.rmab010,g_rmaa_m.rmaadocno,g_rmaa_m.rmaasite) THEN
                  NEXT FIELD CURRENT
               END IF
               #160816-00066#1 若料号调整，则清空批序号，重新新增
               IF g_rmab_d[l_ac].rmab010 <> g_rmab_d_t.rmab010 OR cl_null(g_rmab_d_t.rmab010) THEN
                  IF armt100_del_inao(g_rmaa_m.rmaadocno,g_rmab_d[l_ac].rmabseq) THEN
                     LET g_rmab_d_t.rmab010 = g_rmab_d[l_ac].rmab010
                     LET g_rmab_d_t.rmab012 = -1       
                     IF NOT cl_null(g_rmab_d[l_ac].rmab018) THEN
                        LET g_rmab_d[l_ac].rmab018 = NULL
                        LET g_rmab_d[l_ac].rmab019 = NULL
                        LET g_rmab_d[l_ac].rmab020 = NULL
                     END IF              
                  ELSE
                     LET g_rmab_d[l_ac].rmab010 = g_rmab_d_t.rmab010
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #160816-00066#1 add-E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab010
            #add-point:BEFORE FIELD rmab010 name="input.b.page1.rmab010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab010
            #add-point:ON CHANGE rmab010 name="input.g.page1.rmab010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab011
            
            #add-point:AFTER FIELD rmab011 name="input.a.page1.rmab011"
            IF NOT cl_null(g_rmab_d[l_ac].rmab011) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmab_d[l_ac].rmab009
               LET g_chkparam.arg2 = g_rmab_d[l_ac].rmab011

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imao002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmab_d[l_ac].rmab011 = g_rmab_d_t.rmab011
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rmab_d[l_ac].rmab011
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent="||g_enterprise||" AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_rmab_d[l_ac].rmab011_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_rmab_d[l_ac].rmab011_desc
                  NEXT FIELD CURRENT
               END IF
 


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmab_d[l_ac].rmab011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent="||g_enterprise||" AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmab_d[l_ac].rmab011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmab_d[l_ac].rmab011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab011
            #add-point:BEFORE FIELD rmab011 name="input.b.page1.rmab011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab011
            #add-point:ON CHANGE rmab011 name="input.g.page1.rmab011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab021
            #add-point:BEFORE FIELD rmab021 name="input.b.page1.rmab021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab021
            
            #add-point:AFTER FIELD rmab021 name="input.a.page1.rmab021"
            LET l_date = cl_get_current()
            IF cl_null(g_rmab_d[g_detail_idx].rmab021) OR g_rmab_d[g_detail_idx].rmab021 < l_date THEN
               LET g_rmab_d[g_detail_idx].rmab022 = 'N'
            ELSE
               LET g_rmab_d[g_detail_idx].rmab022 = 'Y'
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab021
            #add-point:ON CHANGE rmab021 name="input.g.page1.rmab021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab022
            #add-point:BEFORE FIELD rmab022 name="input.b.page1.rmab022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab022
            
            #add-point:AFTER FIELD rmab022 name="input.a.page1.rmab022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab022
            #add-point:ON CHANGE rmab022 name="input.g.page1.rmab022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmab_d[l_ac].rmab012,"1","1","","","azz-00079",1) THEN
               NEXT FIELD rmab012
            END IF 
 
 
 
            #add-point:AFTER FIELD rmab012 name="input.a.page1.rmab012"
            #检查申请退货数量是否正确
#            IF armt100_rmab012_chk(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004)  THEN #2016-4-6 zhujing mod
            #160202-00019#7 add-S
            #若序号必输，则不能维护大于1的数量
            IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0009') = 'Y' AND g_rmab_d[l_ac].rmab012 > 1 THEN
               #序号必须维护，故申请数量不得大于1！
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'arm-00056'      
               LET g_errparam.extend = g_rmab_d[l_ac].rmab012
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #160202-00019#7 add-S
            #IF (g_rmab_d[l_ac].rmab012 <> g_rmab_d_t.rmab012 OR g_rmab_d_t.rmab012 IS NULL) THEN   #修改过   #160824-00007#354 20170109 mark by beckxie
            IF (g_rmab_d[l_ac].rmab012 <> g_rmab_d_o.rmab012 OR cl_null(g_rmab_d_o.rmab012)) THEN   #修改过   #160824-00007#354 20170109 add by beckxie
               IF armt100_rmab012_chk(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004) THEN
                  DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
                  DISPLAY g_rmab_d[l_ac].rmab009 TO rmab009
                  DISPLAY g_rmab_d[l_ac].rmab009_desc TO rmab009_desc
                  DISPLAY g_rmab_d[l_ac].rmab009_desc_1 TO rmab009_desc_1
                  DISPLAY g_rmab_d[l_ac].rmab010 TO rmab010
                  DISPLAY g_rmab_d[l_ac].rmab010_desc TO rmab010_desc
                  DISPLAY g_rmab_d[l_ac].rmab011 TO rmab011
                  DISPLAY g_rmab_d[l_ac].rmab011_desc TO rmab011_desc
                  #預設點收數量為申請退貨數量
                  #IF NOT cl_null(g_rmab_d[g_detail_idx].rmab012) OR g_rmab_d[g_detail_idx].rmab012<> g_rmab_d_t.rmab012 THEN   #160824-00007#354 20170109 mark by beckxie
                  IF NOT cl_null(g_rmab_d[g_detail_idx].rmab012) OR g_rmab_d[g_detail_idx].rmab012<> g_rmab_d_o.rmab012 THEN   #160824-00007#354 20170109 add by beckxie
                     LET g_rmab_d[g_detail_idx].rmab013 = g_rmab_d[g_detail_idx].rmab012
                  END IF
                  #2016-4-6 zhujing add---(S)
                  #如果维护了序号、且控管需要维护制造批序号，则更新至inao
                  #IF (l_cmd = 'a' OR g_rmab_d[g_detail_idx].rmab012<> g_rmab_d_t.rmab012 OR cl_null(g_rmab_d_t.rmab012)) THEN   #160824-00007#354 20170109 mark by beckxie
                  IF (l_cmd = 'a' OR g_rmab_d[g_detail_idx].rmab012<> g_rmab_d_o.rmab012 OR cl_null(g_rmab_d_o.rmab012)) THEN   #160824-00007#354 20170109 add by beckxie
                     IF NOT cl_null(g_rmab_d[g_detail_idx].rmab018) THEN
                        CALL armt100_ins_inao_1() RETURNING l_success
                        IF NOT armt100_ins_inao_2(g_rmab_d[g_detail_idx].rmabseq) THEN
                           NEXT FIELD CURRENT
                        END IF
                        CALL armt100_inao_fill2() 
                     ELSE  
                        IF s_lot_batch_number_1n3(g_rmab_d[l_ac].rmab009,g_site) THEN
                           IF g_rmab_d[g_detail_idx].rmab012 > 0 THEN
                           #160816-00066#1 add-S 不与出货单勾稽，则数量自行维护，不控管
                              CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_flag1,l_ooac002    
                              IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'N' THEN   
                                 CALL s_lot_ins(g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab_d[g_detail_idx].rmab011,g_rmab_d[g_detail_idx].rmab012,'1',g_rmaa_m.rmaa002,'1','',
                                             g_rmab2_d[1].rmac002,g_rmab2_d[1].rmac003,g_rmab2_d[1].rmac004,g_rmab2_d[g_detail_idx].rmac005)
                                   RETURNING l_success,l_amount
                                 IF l_success THEN
                                    IF NOT armt100_ins_inao_2(g_rmab_d[g_detail_idx].rmabseq) THEN
                                       NEXT FIELD CURRENT
                                    END IF
                                    IF g_rmab_d[g_detail_idx].rmab012 <> l_amount THEN
                                       IF cl_ask_confirm('ain-00249') THEN    #该笔资料的数量与制造批序号总数不同，是否更新资料数量为序号总数？
                                           
                                          UPDATE rmab_t SET rmab012 = l_amount,
                                                            inbb013 = l_amount
                                           WHERE rmabent = g_enterprise AND rmabsite = g_site
                                             AND rmabdocno = g_rmaa_m.rmaadocno AND rmabseq = g_rmab_d[g_detail_idx].rmabseq
                                          IF SQLCA.sqlcode THEN
                                             INITIALIZE g_errparam TO NULL
                                             LET g_errparam.code = SQLCA.sqlcode
                                             LET g_errparam.extend = "rmab_t"
                                             LET g_errparam.popup = FALSE
                                             CALL cl_err()
                                          ELSE
                                             LET g_rmab_d[g_detail_idx].rmab012 = l_amount
                                             LET g_rmab_d[g_detail_idx].rmab013 = l_amount
                                             UPDATE rmac_t SET rmac001 = l_amount
                                              WHERE rmacent = g_enterprise AND rmacsite = g_site
                                                AND rmacdocno = g_rmaa_m.rmaadocno AND rmacseq = g_rmab_d[g_detail_idx].rmabseq  
                                                AND rmacseq1 = 1
                                             IF SQLCA.sqlcode THEN
                                                INITIALIZE g_errparam TO NULL
                                                LET g_errparam.code = SQLCA.sqlcode
                                                LET g_errparam.extend = "rmac_t"
                                                LET g_errparam.popup = FALSE
                                                CALL cl_err()
                                             ELSE
                                                DELETE FROM rmac_t 
                                                 WHERE rmacent = g_enterprise AND rmacsite = g_site
                                                   AND rmacdocno = g_rmaa_m.rmaadocno AND rmacseq = g_rmab_d[g_detail_idx].rmabseq  
                                                   AND rmacseq1 <> 1
                                                IF SQLCA.sqlcode THEN
                                                   INITIALIZE g_errparam TO NULL
                                                   LET g_errparam.code = SQLCA.sqlcode
                                                   LET g_errparam.extend = "rmab_t"
                                                   LET g_errparam.popup = FALSE
                                                   CALL cl_err()
                                                ELSE
                                                   LET g_rmab2_d[1].rmac001 = l_amount    
                                                END IF
                                             END IF
                                          END IF
                                       END IF
                                    END IF
                                    CALL armt100_inao_fill2()
                                 ELSE
                                    NEXT FIELD CURRENT
                                 END IF
                              ELSE
                              #160816-00066#1 add-E
#                              CALL s_axmt540_inao_copy(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'2','','','','',g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1','1','N','1') RETURNING l_success                                    
                                 IF armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'0') THEN
                                    CALL s_lot_sel('2','1',g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab2_d[g_detail_idx].rmac005,
                                                g_rmab2_d[g_detail_idx].rmac002,g_rmab2_d[g_detail_idx].rmac003,g_rmab2_d[g_detail_idx].rmac004,g_rmab_d[g_detail_idx].rmab011,g_rmab_d[g_detail_idx].rmab012,'1','armt100','',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'',1)
                                    RETURNING l_success  
                                    #160824-00007#354 20170109 mark by beckxie---S
                                    #IF NOT l_success AND g_rmab_d[l_ac].rmab012 <> g_rmab_d_t.rmab012 THEN   
                                       #LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
                                    #160824-00007#354 20170109 mark by beckxie---E
                                    #160824-00007#354 20170109 add by beckxie---S
                                    IF NOT l_success AND g_rmab_d[l_ac].rmab012 <> g_rmab_d_o.rmab012 THEN   
                                       LET g_rmab_d[l_ac].rmab012 = g_rmab_d_o.rmab012
                                    #160824-00007#354 20170109 add by beckxie---E
                                       LET g_rmab_d[l_ac].rmab013 = g_rmab_d[l_ac].rmab012
                                       DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012    
                                       DISPLAY g_rmab_d[l_ac].rmab013 TO rmab013 
                                    END IF
                                    CALL armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'1') RETURNING l_success  
                                    IF l_success THEN    #2016-5-13 zhujing mod 
                                       IF NOT armt100_ins_inao_2(g_rmab_d[g_detail_idx].rmabseq) THEN
                                          NEXT FIELD CURRENT
                                       END IF
                                       CALL armt100_inao_fill2()                            
                                    END IF
                                    #160202-00019#7 add-S 若只有一个申请数量，则显示序号到栏位中
                                    IF g_rmab_d[l_ac].rmab012 = '1' THEN
                                       CALL armt100_get_inao009(g_rmaa_m.rmaadocno,g_rmab_d[l_ac].rmabseq) RETURNING g_rmab_d[l_ac].rmab018,g_rmab_d[l_ac].rmab019,g_rmab_d[l_ac].rmab020
                                    END IF
                                    #160202-00019#7 add-E
                                 END IF
                              END IF 
                           END IF                           
                        END IF
                     END IF
                  END IF
                  #160824-00007#354 20170109 mark by beckxie---S
                  #LET g_rmab_d_t.rmab012 = g_rmab_d[l_ac].rmab012
                  #LET g_rmab_d_t.rmab013 = g_rmab_d[l_ac].rmab012 
                  #160824-00007#354 20170109 mark by beckxie---E
                  #160824-00007#354 20170109 add by beckxie---S
                  LET g_rmab_d_o.rmab012 = g_rmab_d[l_ac].rmab012
                  LET g_rmab_d_o.rmab013 = g_rmab_d[l_ac].rmab012 
                  #160824-00007#354 20170109 add by beckxie---E
                  #2016-4-6 zhujing add---(E)
               ELSE 
                  #LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012   #160824-00007#354 20170109 mark by beckxie
                  LET g_rmab_d[l_ac].rmab012 = g_rmab_d_o.rmab012   #160824-00007#354 20170109 add by beckxie
                  LET g_rmab_d[l_ac].rmab013 = g_rmab_d[l_ac].rmab012
                  DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012    
                  DISPLAY g_rmab_d[l_ac].rmab013 TO rmab013 
                  NEXT FIELD CURRENT               
               END IF
            END IF
            #160202-00019#7 add-S 若只有一个申请数量，则显示序号到栏位中
            IF g_rmab_d[l_ac].rmab012 = '1' THEN
               CALL armt100_get_inao009(g_rmaa_m.rmaadocno,g_rmab_d[l_ac].rmabseq) RETURNING g_rmab_d[l_ac].rmab018,g_rmab_d[l_ac].rmab019,g_rmab_d[l_ac].rmab020
               
#               IF l_rmab018 <> g_rmab_d_t.rmab018 OR g_rmab_d_t.rmab018 IS NULL THEN
#                  LET l_flag = 'rmab012'
#                  NEXT FIELD rmab018
#               END IF
            END IF
            #160202-00019#7 add-E
            
            LET g_rmab_d_o.* = g_rmab_d[l_ac].*   #160824-00007#354 20170109 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab012
            #add-point:BEFORE FIELD rmab012 name="input.b.page1.rmab012"
            IF NOT cl_null(g_rmab_d[g_detail_idx].rmab001) THEN
               CALL cl_set_comp_entry("rmab012",FALSE)
            ELSE
               CALL cl_set_comp_entry("rmab012",TRUE)
            END IF
            #检查是否有相同出货单号的申请退货数量
#            IF NOT cl_null(g_rmab_d[g_detail_idx].rmab012) AND NOT cl_null(g_rmab_d[g_detail_idx].rmab003) AND NOT cl_null(g_rmab_d[g_detail_idx].rmab004) THEN
#               IF NOT armt100_rmab012_chk(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004) THEN
#                  LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
#                  LET g_rmab_d[l_ac].rmab013 = g_rmab_d[l_ac].rmab012
#                  DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012    
#                  DISPLAY g_rmab_d[l_ac].rmab013 TO rmab013 
#                  NEXT FIELD CURRENT   
#               ELSE
#                  CALL armt100_rmab_default_insert(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004) RETURNING l_success
#                  IF NOT l_success THEN
#                     LET g_rmab_d[g_detail_idx].rmab012 = g_rmab_d_t.rmab012
#                     DISPLAY g_rmab_d[g_detail_idx].rmab012 TO rmab012
#                     LET g_rmab_d[g_detail_idx].rmab013 = g_rmab_d[l_ac].rmab012
#                     DISPLAY g_rmab_d[g_detail_idx].rmab013 TO rmab013
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#               LET l_rmab012 = 0
#               SELECT SUM(rmab012) INTO l_rmab012 FROM rmab_t 
#               LEFT OUTER JOIN rmaa_t ON rmabdocno = rmaadocno AND rmabsite = rmaasite AND rmabent = rmaaent
#               WHERE rmab003 = g_rmab_d[g_detail_idx].rmab003 AND rmab004 = g_rmab_d[g_detail_idx].rmab004
#               AND rmabent = g_enterprise AND rmabsite = g_site AND rmaastus <> 'X'
#               AND ((rmabseq<>g_rmab_d[g_detail_idx].rmabseq AND rmabdocno = g_rmaa_m.rmaadocno) 
#               OR ( rmabdocno <> g_rmaa_m.rmaadocno))            #除去自己
#               #根据出货单+项次获取可退品量
#               IF cl_null(l_rmab012) THEN LET l_rmab012 = 0 END IF
#               IF l_rmab012 > g_rmab_d[g_detail_idx].rmab012 THEN
#                  #报错已无可退退品
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   = "arm-00015"   #已无可退退品
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  LET g_rmab_d[g_detail_idx].rmab012 = 0
#                  DISPLAY g_rmab_d[g_detail_idx].rmab012 TO rmab012
#                  NEXT FIELD CURRENT
#               ELSE
#                  LET g_rmab_d[g_detail_idx].rmab012 = g_rmab_d[g_detail_idx].rmab012 - l_rmab012
#                  DISPLAY g_rmab_d[g_detail_idx].rmab012 TO rmab012
#               END IF
#            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab012
            #add-point:ON CHANGE rmab012 name="input.g.page1.rmab012"
#            IF g_rmab_d[g_detail_idx].rmab012 <> g_rmab_d_o.rmab012 THEN
#               IF armt100_rmab012_chk(g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004) THEN
#               
#                  DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
#                  DISPLAY g_rmab_d[l_ac].rmab009 TO rmab009
#                  DISPLAY g_rmab_d[l_ac].rmab009_desc TO rmab009_desc
#                  DISPLAY g_rmab_d[l_ac].rmab009_desc_1 TO rmab009_desc_1
#                  DISPLAY g_rmab_d[l_ac].rmab010 TO rmab010
#                  DISPLAY g_rmab_d[l_ac].rmab010_desc TO rmab010_desc
#                  DISPLAY g_rmab_d[l_ac].rmab011 TO rmab011
#                  DISPLAY g_rmab_d[l_ac].rmab011_desc TO rmab011_desc
#                  #預設點收數量為申請退貨數量
#                  IF NOT cl_null(g_rmab_d[g_detail_idx].rmab012) OR g_rmab_d[g_detail_idx].rmab012<> g_rmab_d_o.rmab012 THEN
#                     LET g_rmab_d[g_detail_idx].rmab013 = g_rmab_d[g_detail_idx].rmab012
#                  END IF
#               ELSE 
#                  LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
#                  LET g_rmab_d[g_detail_idx].rmab013 = g_rmab_d[g_detail_idx].rmab012
#                  DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012    
#                  DISPLAY g_rmab_d[l_ac].rmab013 TO rmab013    
#                  NEXT FIELD CURRENT               
#               END IF
#            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab017
            #add-point:BEFORE FIELD rmab017 name="input.b.page1.rmab017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab017
            
            #add-point:AFTER FIELD rmab017 name="input.a.page1.rmab017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab017
            #add-point:ON CHANGE rmab017 name="input.g.page1.rmab017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmabsite
            #add-point:BEFORE FIELD rmabsite name="input.b.page1.rmabsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmabsite
            
            #add-point:AFTER FIELD rmabsite name="input.a.page1.rmabsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmabsite
            #add-point:ON CHANGE rmabsite name="input.g.page1.rmabsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rmabseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmabseq
            #add-point:ON ACTION controlp INFIELD rmabseq name="input.c.page1.rmabseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab018
            #add-point:ON ACTION controlp INFIELD rmab018 name="input.c.page1.rmab018"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_rmaa_m.rmaa005) THEN
               LET g_qryparam.where = " inaodocno = '",g_rmaa_m.rmaa005,"' "
            END IF
            LET g_qryparam.default1 = g_rmab_d[l_ac].rmab018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_inao009()                                #呼叫開窗
 
            LET g_rmab_d[l_ac].rmab018 = g_qryparam.return1              

            DISPLAY g_rmab_d[l_ac].rmab018 TO rmab018              #

            NEXT FIELD rmab018                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab001
            #add-point:ON ACTION controlp INFIELD rmab001 name="input.c.page1.rmab001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmab_d[l_ac].rmab001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " xmfostus = 'Y' AND xmfo005 = '",g_rmaa_m.rmaa001,"' AND xmfo016 = '1' "
            CALL q_xmfodocno()                                #呼叫開窗

            LET g_rmab_d[l_ac].rmab001 = g_qryparam.return1              

            DISPLAY g_rmab_d[l_ac].rmab001 TO rmab001              #
            CALL armt100_rmaa004_default(g_rmab_d[l_ac].rmab001)

            NEXT FIELD rmab001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab002
            #add-point:ON ACTION controlp INFIELD rmab002 name="input.c.page1.rmab002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab003
            #add-point:ON ACTION controlp INFIELD rmab003 name="input.c.page1.rmab003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmab_d[l_ac].rmab003             #給予default值
            LET g_qryparam.default2 = "" #g_rmab_d[l_ac].imaal004 #規格
            LET g_qryparam.default3 = "" #g_rmab_d[l_ac].xmdldocno #單據編號
            LET g_qryparam.default4 = "" #g_rmab_d[l_ac].xmdlseq #項次
            LET g_qryparam.default5 = "" #g_rmab_d[l_ac].xmdl003 #訂單單號
            LET g_qryparam.default6 = "" #g_rmab_d[l_ac].xmdl004 #訂單項次
            LET g_qryparam.default7 = "" #g_rmab_d[l_ac].xmdl005 #訂單項序
            LET g_qryparam.default8 = "" #g_rmab_d[l_ac].xmdl006 #訂單分批序
            LET g_qryparam.default9 = "" #g_rmab_d[l_ac].xmdl008 #料件編號
            LET g_qryparam.default10 = "" #g_rmab_d[l_ac].xmdl009 #產品特徵
            #給予arg
            LET g_qryparam.arg1 = g_rmaa_m.rmaa001 #收款客戶
            #160202-00019#7 add-S 只带出符合当前序号的出货单资料
            IF NOT cl_null(g_rmab_d[l_ac].rmab018) THEN
               LET g_qryparam.where = " xmdlsite = '",g_site,"' AND xmdlent = ",g_enterprise," AND EXISTS(SELECT 1 FROM inao_t WHERE inaodocno = xmdldocno AND inaoseq = xmdlseq AND inao009 = '",g_rmab_d[l_ac].rmab018,"')"
            ELSE
               LET g_qryparam.where = " xmdlsite = '",g_site,"' AND xmdlent = ",g_enterprise," "
            END IF
            IF NOT cl_null(g_rmaa_m.rmaa005) THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND xmdldocno = '",g_rmaa_m.rmaa005,"' "
            END IF
            #160202-00019#7 add-E

            CALL q_xmdldocno()                                #呼叫開窗

            LET g_rmab_d[l_ac].rmab003 = g_qryparam.return1          #出貨單號            
            LET g_rmab_d[l_ac].rmab004 = g_qryparam.return2          #出貨項次
            LET g_rmab_d[l_ac].rmab005 = g_qryparam.return3          #訂單單號
            LET g_rmab_d[l_ac].rmab006 = g_qryparam.return4          #訂單項次
            LET g_rmab_d[l_ac].rmab007 = g_qryparam.return5          #訂單項序
            LET g_rmab_d[l_ac].rmab008 = g_qryparam.return6          #分批序
            LET g_rmab_d[l_ac].rmab009 = g_qryparam.return7          #料號
            LET g_rmab_d[l_ac].rmab010 = g_qryparam.return8         #產品特征
            LET g_rmab_d[l_ac].rmab011 = g_qryparam.return9         #產品特征
            LET g_rmab_d[l_ac].rmab012 = g_qryparam.return10         #產品特征
            CALL s_desc_get_item_desc(g_rmab_d[l_ac].rmab009)RETURNING g_rmab_d[l_ac].rmab009_desc,g_rmab_d[l_ac].rmab009_desc_1
            CALL s_feature_description(g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010) 
               RETURNING l_success,g_rmab_d[l_ac].rmab010_desc 
            CALL s_desc_get_unit_desc(g_rmab_d[l_ac].rmab011) RETURNING g_rmab_d[l_ac].rmab011_desc
            
            DISPLAY g_rmab_d[l_ac].rmab003 TO rmab003              
            DISPLAY g_rmab_d[l_ac].rmab004 TO rmab004       
            DISPLAY g_rmab_d[l_ac].rmab005 TO rmab005              
            DISPLAY g_rmab_d[l_ac].rmab006 TO rmab006              
            DISPLAY g_rmab_d[l_ac].rmab007 TO rmab007
            DISPLAY g_rmab_d[l_ac].rmab008 TO rmab008
            DISPLAY g_rmab_d[l_ac].rmab009 TO rmab009
            DISPLAY g_rmab_d[l_ac].rmab009_desc TO rmab009_desc
            DISPLAY g_rmab_d[l_ac].rmab009_desc_1 TO rmab009_desc_1
            DISPLAY g_rmab_d[l_ac].rmab010 TO rmab010
            DISPLAY g_rmab_d[l_ac].rmab010_desc TO rmab010_desc
            DISPLAY g_rmab_d[l_ac].rmab011 TO rmab011
            DISPLAY g_rmab_d[l_ac].rmab011_desc TO rmab011_desc
            NEXT FIELD rmab003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab004
            #add-point:ON ACTION controlp INFIELD rmab004 name="input.c.page1.rmab004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab009
            #add-point:ON ACTION controlp INFIELD rmab009 name="input.c.page1.rmab009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rmab_d[l_ac].rmab009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_imaf001_15()                                #呼叫開窗
 
            LET g_rmab_d[l_ac].rmab009 = g_qryparam.return1              

            DISPLAY g_rmab_d[l_ac].rmab009 TO rmab009              #

            NEXT FIELD rmab009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab010
            #add-point:ON ACTION controlp INFIELD rmab010 name="input.c.page1.rmab010"
            #160816-00066#1 add-S
            #取得料件產品特徵
            LET l_imaa005 = ''
            SELECT imaa005 INTO l_imaa005
              FROM imaa_t
             WHERE imaa001 = g_rmab_d[l_ac].rmab009
               AND imaaent = g_enterprise
               
            IF NOT cl_null(l_imaa005) THEN
               IF l_cmd = 'a' THEN            
                  CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_rmab_d[l_ac].rmab009,'','',g_site,g_rmaa_m.rmaadocno) RETURNING l_success,l_inam
                  LET g_rmab_d[l_ac].rmab010 = l_inam[1].inam002
                  LET g_rmab_d[l_ac].rmab012 = l_inam[1].inam004
                  LET g_rmab_d[l_ac].rmab013 = l_inam[1].inam004
                  DISPLAY BY NAME g_rmab_d[l_ac].rmab010,g_rmab_d[l_ac].rmab012,g_rmab_d[l_ac].rmab013
               END IF
               IF l_cmd = 'u' THEN
                  CALL s_feature_single(g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010,g_site,g_rmaa_m.rmaadocno)
                     RETURNING l_success,g_rmab_d[l_ac].rmab010
                  DISPLAY BY NAME g_rmab_d[l_ac].rmab010
               END IF
            END IF                 
            #160816-00066#1 add-E
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab011
            #add-point:ON ACTION controlp INFIELD rmab011 name="input.c.page1.rmab011"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rmab_d[l_ac].rmab011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_rmab_d[l_ac].rmab011 = g_qryparam.return1              

            DISPLAY g_rmab_d[l_ac].rmab011 TO rmab011              #

            NEXT FIELD rmab011                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab021
            #add-point:ON ACTION controlp INFIELD rmab021 name="input.c.page1.rmab021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab022
            #add-point:ON ACTION controlp INFIELD rmab022 name="input.c.page1.rmab022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab012
            #add-point:ON ACTION controlp INFIELD rmab012 name="input.c.page1.rmab012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab017
            #add-point:ON ACTION controlp INFIELD rmab017 name="input.c.page1.rmab017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmabsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmabsite
            #add-point:ON ACTION controlp INFIELD rmabsite name="input.c.page1.rmabsite"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rmab_d[l_ac].* = g_rmab_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE armt100_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rmab_d[l_ac].rmabseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rmab_d[l_ac].* = g_rmab_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #判断申请数量与序号
               IF (g_rmab_d[g_detail_idx].rmab018 <> g_rmab_d_t.rmab018 OR cl_null(g_rmab_d[g_detail_idx].rmab018) OR cl_null(g_rmab_d_t.rmab018)) AND g_rmab_d[l_ac].rmab012 = 1 THEN
#                  LET g_rmab_d[l_ac].rmab018 = armt100_get_inao009(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq)
                  CALL armt100_get_inao009(g_rmaa_m.rmaadocno,g_rmab_d[l_ac].rmabseq) RETURNING g_rmab_d[l_ac].rmab018,g_rmab_d[l_ac].rmab019,g_rmab_d[l_ac].rmab020
                  LET g_rmab_d_t.rmab018 = g_rmab_d[l_ac].rmab018
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL armt100_rmab_t_mask_restore('restore_mask_o')
      
               UPDATE rmab_t SET (rmabdocno,rmabseq,rmab018,rmab019,rmab020,rmab001,rmab002,rmab003, 
                   rmab004,rmab005,rmab006,rmab007,rmab008,rmab009,rmab010,rmab011,rmab021,rmab022,rmab012, 
                   rmab013,rmab014,rmab015,rmab016,rmab017,rmabsite) = (g_rmaa_m.rmaadocno,g_rmab_d[l_ac].rmabseq, 
                   g_rmab_d[l_ac].rmab018,g_rmab_d[l_ac].rmab019,g_rmab_d[l_ac].rmab020,g_rmab_d[l_ac].rmab001, 
                   g_rmab_d[l_ac].rmab002,g_rmab_d[l_ac].rmab003,g_rmab_d[l_ac].rmab004,g_rmab_d[l_ac].rmab005, 
                   g_rmab_d[l_ac].rmab006,g_rmab_d[l_ac].rmab007,g_rmab_d[l_ac].rmab008,g_rmab_d[l_ac].rmab009, 
                   g_rmab_d[l_ac].rmab010,g_rmab_d[l_ac].rmab011,g_rmab_d[l_ac].rmab021,g_rmab_d[l_ac].rmab022, 
                   g_rmab_d[l_ac].rmab012,g_rmab_d[l_ac].rmab013,g_rmab_d[l_ac].rmab014,g_rmab_d[l_ac].rmab015, 
                   g_rmab_d[l_ac].rmab016,g_rmab_d[l_ac].rmab017,g_rmab_d[l_ac].rmabsite)
                WHERE rmabent = g_enterprise AND rmabdocno = g_rmaa_m.rmaadocno 
 
                  AND rmabseq = g_rmab_d_t.rmabseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               #1118 zhujing marked
#               LET l_no = 0
#               SELECT MAX(rmacseq1) INTO l_no
#               FROM rmac_t
#               WHERE rmacent = g_enterprise AND rmacdocno = g_rmaa_m.rmaadocno 
#                 AND rmacseq = g_rmab_d_t.rmabseq
#               #2016-5-16 zhujing add(S)
#               IF l_no = 0 OR cl_null(l_no) THEN
##                  #2016-5-26 zhujing mod-S
##                  INSERT INTO rmac_t (rmacent,rmacsite,rmacdocno,rmacseq,rmacseq1,rmac001,rmac007)
##                     VALUES(g_enterprise,g_site,g_rmaa_m.rmaadocno,g_rmab_d_t.rmabseq,'1',0,g_user)
#                  INSERT INTO rmac_t (rmacent,rmacsite,rmacdocno,rmacseq,rmacseq1,rmac001,rmac007,rmac002,rmac003,rmac004,rmac005)
#                     VALUES(g_enterprise,g_site,g_rmaa_m.rmaadocno,g_rmab_d_t.rmabseq,'1',0,g_user,' ',' ',' ',' ')
#                  #2016-5-26 zhujing mod-E
#               END IF
#               #2016-5-16 zhujing add(E)
#               UPDATE rmac_t SET rmacseq = g_rmab_d[l_ac].rmabseq,
#                                 rmac001 = g_rmab_d[l_ac].rmab013,
#                                 rmac006 = g_today,
#                                 rmac007 = g_user,
#                                 rmacsite = g_site
#               #自訂欄位頁簽
#               WHERE rmacent = g_enterprise AND rmacdocno = g_rmaa_m.rmaadocno 
#                   AND rmacseq = g_rmab_d_t.rmabseq
#                   AND rmacseq1 = 1
#               
#               IF l_no > 1 THEN                     
#                  DELETE FROM rmac_t
#                  WHERE rmacent = g_enterprise AND rmacdocno = g_rmaa_m.rmaadocno 
#                    AND rmacseq = g_rmab_d_t.rmabseq
#                    AND rmacseq1 <> 1
#               END IF
#               #2016-5-16 zhujing add(S) 回写至inao_t
#                UPDATE inao_t SET (inaosite,inaoseq)
#                      = (g_rmab_d[l_ac].rmabsite,g_rmab_d[l_ac].rmabseq)  
#                      #自訂欄位頁簽
#                WHERE inaoent = g_enterprise AND inaodocno = g_rmaa_m.rmaadocno
#                  AND inaoseq = g_rmab_d_t.rmabseq
#                IF SQLCA.sqlcode THEN
#                   INITIALIZE g_errparam TO NULL 
#                   LET g_errparam.extend = "inao_t" 
#                   LET g_errparam.code   = SQLCA.sqlcode 
#                   LET g_errparam.popup  = TRUE 
#                   CALL cl_err()                   
#                   CALL s_transaction_end('N','0')
#                   LET g_rmab_d[l_ac].* = g_rmab_d_t.*  
#                END IF
#                #2016-5-16 zhujing add(E)
               #1118 zhujing marked-E
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rmab_d[l_ac].* = g_rmab_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmab_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rmab_d[l_ac].* = g_rmab_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmaa_m.rmaadocno
               LET gs_keys_bak[1] = g_rmaadocno_t
               LET gs_keys[2] = g_rmab_d[g_detail_idx].rmabseq
               LET gs_keys_bak[2] = g_rmab_d_t.rmabseq
               CALL armt100_update_b('rmab_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL armt100_rmab_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rmab_d[g_detail_idx].rmabseq = g_rmab_d_t.rmabseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rmaa_m.rmaadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rmab_d_t.rmabseq
 
                  CALL armt100_key_update_b(gs_keys,'rmab_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rmaa_m),util.JSON.stringify(g_rmab_d_t)
               LET g_log2 = util.JSON.stringify(g_rmaa_m),util.JSON.stringify(g_rmab_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #1118 zhujing add-S
               LET l_no = 0
               SELECT MAX(rmacseq1) INTO l_no
               FROM rmac_t
               WHERE rmacent = g_enterprise AND rmacdocno = g_rmaa_m.rmaadocno 
                 AND rmacseq = g_rmab_d_t.rmabseq
               #2016-5-16 zhujing add(S)
               IF l_no = 0 OR cl_null(l_no) THEN
#                  #2016-5-26 zhujing mod-S
#                  INSERT INTO rmac_t (rmacent,rmacsite,rmacdocno,rmacseq,rmacseq1,rmac001,rmac007)
#                     VALUES(g_enterprise,g_site,g_rmaa_m.rmaadocno,g_rmab_d_t.rmabseq,'1',0,g_user)
                  INSERT INTO rmac_t (rmacent,rmacsite,rmacdocno,rmacseq,rmacseq1,rmac001,rmac007,rmac002,rmac003,rmac004,rmac005)
                     VALUES(g_enterprise,g_site,g_rmaa_m.rmaadocno,g_rmab_d_t.rmabseq,'1',0,g_user,' ',' ',' ',' ')
                  #2016-5-26 zhujing mod-E
               END IF
               #2016-5-16 zhujing add(E)
               UPDATE rmac_t SET rmacseq = g_rmab_d[l_ac].rmabseq,
                                 rmac001 = g_rmab_d[l_ac].rmab013,
                                 rmac006 = g_today,
                                 rmac007 = g_user,
                                 rmacsite = g_site
               #自訂欄位頁簽
               WHERE rmacent = g_enterprise AND rmacdocno = g_rmaa_m.rmaadocno 
                   AND rmacseq = g_rmab_d_t.rmabseq
                   AND rmacseq1 = 1
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rmab_d[l_ac].* = g_rmab_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmac_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     LET g_rmab_d[l_ac].* = g_rmab_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmac_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
               END CASE
               
               IF l_no > 1 THEN                     
                  DELETE FROM rmac_t
                  WHERE rmacent = g_enterprise AND rmacdocno = g_rmaa_m.rmaadocno 
                    AND rmacseq = g_rmab_d_t.rmabseq
                    AND rmacseq1 <> 1
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmac_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  END IF
               END IF
               
               #170222-00004-----add---str
               SELECT COUNT(*) INTO l_n1 FROM inao_t
               WHERE inaoent = g_enterprise AND inaodocno = g_rmaa_m.rmaadocno
                  AND inaoseq = g_rmab_d_t.rmabseq
               IF l_n1 > 0 THEN 
               #170222-00004-----add---end
               
               #2016-5-16 zhujing add(S) 回写至inao_t
                UPDATE inao_t SET (inaosite,inaoseq)
                      = (g_rmab_d[l_ac].rmabsite,g_rmab_d[l_ac].rmabseq)  
                      #自訂欄位頁簽
                WHERE inaoent = g_enterprise AND inaodocno = g_rmaa_m.rmaadocno
                  AND inaoseq = g_rmab_d_t.rmabseq
                CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rmab_d[l_ac].* = g_rmab_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inao_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     LET g_rmab_d[l_ac].* = g_rmab_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inao_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                END CASE
                #2016-5-16 zhujing add(E)
                END IF #170222-00004-----add
               #1118 zhujing add-E
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL armt100_unlock_b("rmab_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL armt100_b_fill()
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rmab_d[li_reproduce_target].* = g_rmab_d[li_reproduce].*
 
               LET g_rmab_d[li_reproduce_target].rmabseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rmab_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rmab_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_rmab2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL armt100_idx_chk()
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
            CALL armt100_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="armt100.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_inao_d2 TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) #page4 
    
            BEFORE ROW
               CALL armt100_idx_chk()
            #   LET l_ac4 = DIALOG.getCurrentRow("s_detail3")
            #   LET g_detail_idx = l_ac3
            #   

            BEFORE DISPLAY
            #   CALL FGL_SET_ARR_CURR(g_detail_idx)
            #   LET l_ac4 = DIALOG.getCurrentRow("s_detail3")
               CALL armt100_idx_chk()
               LET g_current_page = 3
 
         END DISPLAY
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF g_open = 'Y' THEN
            NEXT FIELD rmac001
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD rmaadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rmabseq
               WHEN "s_detail2"
                  NEXT FIELD rmacseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         LET  g_open = 'N'
         CALL cl_set_act_visible("delete,insert,modify_detail",TRUE)
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
 
{<section id="armt100.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION armt100_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL armt100_b_fill() #單身填充
      CALL armt100_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL armt100_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_aooi200_get_slip_desc(g_rmaa_m.rmaadocno) RETURNING g_rmaa_m.rmaadocno_desc
   DISPLAY BY NAME g_rmaa_m.rmaadocno_desc
   #end add-point
   
   #遮罩相關處理
   LET g_rmaa_m_mask_o.* =  g_rmaa_m.*
   CALL armt100_rmaa_t_mask()
   LET g_rmaa_m_mask_n.* =  g_rmaa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rmaa_m.rmaadocno,g_rmaa_m.rmaadocno_desc,g_rmaa_m.rmaa001,g_rmaa_m.rmaa001_desc, 
       g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa002_desc, 
       g_rmaa_m.rmaa003,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaastus,g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006, 
       g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp,g_rmaa_m.rmaaowndp_desc, 
       g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtid_desc,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaacrtdt, 
       g_rmaa_m.rmaamodid,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaamoddt,g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfid_desc, 
       g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstid_desc,g_rmaa_m.rmaapstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmaa_m.rmaastus 
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
   FOR l_ac = 1 TO g_rmab_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_rmab2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL armt100_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL armt100_inao_fill2()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="armt100.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION armt100_detail_show()
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
 
{<section id="armt100.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION armt100_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rmaa_t.rmaadocno 
   DEFINE l_oldno     LIKE rmaa_t.rmaadocno 
 
   DEFINE l_master    RECORD LIKE rmaa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rmab_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rmac_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_rmaa_m.rmaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rmaadocno_t = g_rmaa_m.rmaadocno
 
    
   LET g_rmaa_m.rmaadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rmaa_m.rmaaownid = g_user
      LET g_rmaa_m.rmaaowndp = g_dept
      LET g_rmaa_m.rmaacrtid = g_user
      LET g_rmaa_m.rmaacrtdp = g_dept 
      LET g_rmaa_m.rmaacrtdt = cl_get_current()
      LET g_rmaa_m.rmaamodid = g_user
      LET g_rmaa_m.rmaamoddt = cl_get_current()
      LET g_rmaa_m.rmaastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_rmaa_m.rmaacnfid = NULL
   LET g_rmaa_m.rmaacnfdt = NULL
   LET g_rmaa_m.rmaapstid = NULL
   LET g_rmaa_m.rmaapstdt = NULL
   LET g_rmaa_m.rmaadocdt = g_today
   LET g_rmaa_m.rmaa008 = g_today
   LET g_rmaa_m.rmaa002 = g_user
   LET g_rmaa_m.rmaa003 = g_dept
   CALL s_desc_get_person_desc(g_rmaa_m.rmaa002) RETURNING g_rmaa_m.rmaa002_desc
   CALL s_desc_get_department_desc(g_rmaa_m.rmaa003) RETURNING g_rmaa_m.rmaa003_desc
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmaa_m.rmaastus 
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
      LET g_rmaa_m.rmaadocno_desc = ''
   DISPLAY BY NAME g_rmaa_m.rmaadocno_desc
 
   
   CALL armt100_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rmaa_m.* TO NULL
      INITIALIZE g_rmab_d TO NULL
      INITIALIZE g_rmab2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL armt100_show()
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
   CALL armt100_set_act_visible()   
   CALL armt100_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rmaadocno_t = g_rmaa_m.rmaadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rmaaent = " ||g_enterprise|| " AND",
                      " rmaadocno = '", g_rmaa_m.rmaadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL armt100_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL armt100_idx_chk()
   
   LET g_data_owner = g_rmaa_m.rmaaownid      
   LET g_data_dept  = g_rmaa_m.rmaaowndp
   
   #功能已完成,通報訊息中心
   CALL armt100_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="armt100.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION armt100_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rmab_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rmac_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_sum      LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_num      LIKE type_t.num5
   DEFINE l_xmdk002  LIKE xmdk_t.xmdk002
   
   DEFINE l_sql  STRING 
   #161124-00048#11 mod-S
#   DEFINE l_rmab RECORD LIKE rmab_t.*
   DEFINE l_rmab RECORD  #RMA維護單身檔
          rmabent LIKE rmab_t.rmabent, #企业编号
          rmabsite LIKE rmab_t.rmabsite, #营运据点
          rmabdocno LIKE rmab_t.rmabdocno, #单据单号
          rmabseq LIKE rmab_t.rmabseq, #项次
          rmab001 LIKE rmab_t.rmab001, #客诉单号
          rmab002 LIKE rmab_t.rmab002, #客诉项次
          rmab003 LIKE rmab_t.rmab003, #出货单号
          rmab004 LIKE rmab_t.rmab004, #出货项次
          rmab005 LIKE rmab_t.rmab005, #订单单号
          rmab006 LIKE rmab_t.rmab006, #订单项次
          rmab007 LIKE rmab_t.rmab007, #订单项序
          rmab008 LIKE rmab_t.rmab008, #订单分批序
          rmab009 LIKE rmab_t.rmab009, #料号
          rmab010 LIKE rmab_t.rmab010, #产品特征
          rmab011 LIKE rmab_t.rmab011, #单位
          rmab012 LIKE rmab_t.rmab012, #申请退货数量
          rmab013 LIKE rmab_t.rmab013, #点收数量
          rmab014 LIKE rmab_t.rmab014, #已转维修数量
          rmab015 LIKE rmab_t.rmab015, #已转销退数量
          rmab016 LIKE rmab_t.rmab016, #覆出数量
          rmab017 LIKE rmab_t.rmab017, #备注
          rmab018 LIKE rmab_t.rmab018, #序号
          rmab019 LIKE rmab_t.rmab019, #生产日期
          rmab020 LIKE rmab_t.rmab020, #有效日期
          rmab021 LIKE rmab_t.rmab021, #保固日期
          rmab022 LIKE rmab_t.rmab022  #保固内
   END RECORD
   #161124-00048#11 mod-E
   DEFINE l_rmab003_t LIKE rmab_t.rmab003
   DEFINE l_rmab004_t LIKE rmab_t.rmab004
   DEFINE l_rmab012 LIKE rmab_t.rmab012
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE armt100_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   
#   LET l_cnt = 0
#   IF NOT cl_null(g_rmaa_m.rmaa005) THEN
#      SELECT xmdk002 INTO l_xmdk002
#        FROM xmdk_t 
#       WHERE xmdkent = g_enterprise
#         AND xmdksite = g_site
#         AND xmdkdocno = g_rmaa_m.rmaa005
#         SELECT SUM(rmab012) INTO l_sum
#           FROM rmab_t
#          WHERE rmab003 = g_rmaa_m.rmaa005
#            AND rmabent = g_enterprise 
#            AND rmabsite = g_site
#   END IF
#   IF cl_null(l_sum) THEN
#      LET l_sum = 0
#   END IF
#   IF l_xmdk002 ='3' THEN
#      SELECT SUM(COALESCE(xmdl035,0)) INTO l_cnt
#      FROM xmdl_t
#      WHERE xmdlent = g_enterprise
#      AND xmdldocno = g_rmaa_m.rmaa005
#   ELSE
#      SELECT SUM((COALESCE(xmdl056,0))-(COALESCE(xmdl037,0))) INTO l_cnt
#      FROM xmdl_t
#      WHERE xmdlent = g_enterprise
#      AND xmdldocno = g_rmaa_m.rmaa005
#   END IF
#   
#   IF cl_null(l_cnt) THEN 
#      LET l_cnt = 0
#   END IF
#   IF l_cnt > l_sum THEN
#      IF cl_ask_confirm('ain-00186') THEN
#         CALL armt100_auto_gene_detail() 
#      END IF 
#      CALL armt100_b_fill()
#   ELSE
#      DELETE FROM armt100_detail 
#       WHERE rmab001 = l_rmcb.rmcb001
#         AND rmab002 = l_rmcb.rmcb002
#         AND rmab003 = l_rmcb.rmcb003
#         AND rmabseq = l_rmcb.rmcbseq
#   END IF                                                           
#   RETURN
  
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rmab_t
    WHERE rmabent = g_enterprise AND rmabdocno = g_rmaadocno_t
 
    INTO TEMP armt100_detail
 
   #將key修正為調整後   
   UPDATE armt100_detail 
      #更新key欄位
      SET rmabdocno = g_rmaa_m.rmaadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   LET l_rmab003_t = ''
   LET l_rmab004_t = '' 
   
   LET l_sql = "SELECT * FROM armt100_detail ORDER BY rmab003,rmab004,rmabseq "
   PREPARE armt100_reproduce_pr FROM l_sql
   DECLARE armt100_reproduce_cr CURSOR FOR armt100_reproduce_pr
   FOREACH armt100_reproduce_cr INTO l_rmab.* 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF   
      IF l_rmab.rmab003=l_rmab003_t AND l_rmab.rmab004=l_rmab004_t THEN    #判断是否为相同的出货单号+项次
         DELETE FROM armt100_detail 
          WHERE rmab003 = l_rmab.rmab003
            AND rmab004 = l_rmab.rmab004
            AND rmabseq = l_rmab.rmabseq
         CONTINUE FOREACH   
      END IF
      #计算当前出货单号+项次下是否还有可退品
      #抓取可退品计算方式
      SELECT xmdk002 INTO l_xmdk002
        FROM xmdk_t 
       WHERE xmdkent = g_enterprise
         AND xmdksite = g_site
         AND xmdkdocno = l_rmab.rmab003
      #计算已退品数量
      SELECT SUM(rmab012) INTO l_sum
        FROM rmab_t
       WHERE rmab003 = l_rmab.rmab003
         AND rmabent = g_enterprise 
         AND rmabsite = g_site
 
      IF cl_null(l_sum) THEN
         LET l_sum = 0
      END IF
      #计算可退品总量
      IF l_xmdk002 ='3' THEN
         SELECT SUM(COALESCE(xmdl035,0)) INTO l_cnt
         FROM xmdl_t
         WHERE xmdlent = g_enterprise
         AND xmdldocno = l_rmab.rmab003
      ELSE
         SELECT SUM((COALESCE(xmdl056,0))-(COALESCE(xmdl037,0))) INTO l_cnt
         FROM xmdl_t
         WHERE xmdlent = g_enterprise
         AND xmdldocno = l_rmab.rmab003
      END IF
      
      IF cl_null(l_cnt) THEN 
         LET l_cnt = 0
      END IF
      #若可退品大于已退品，则新增-->更新：计算可退数量
#      IF l_cnt > l_sum THEN
#         IF cl_ask_confirm('ain-00186') THEN
#            CALL armt100_auto_gene_detail() 
#         END IF 
#         CALL armt100_b_fill()
#      END IF
      IF l_cnt-l_sum <= 0 THEN 
         DELETE FROM armt100_detail 
          WHERE rmab003 = l_rmab.rmab003
            AND rmab004 = l_rmab.rmab004
            AND rmabseq = l_rmab.rmabseq
         
      ELSE
         LET l_rmab.rmab012 = l_cnt - l_sum
         UPDATE armt100_detail
            SET (rmab012,rmab013,rmab014,rmab015,rmab016) = (l_rmab.rmab012,0,0,0,0)
          WHERE rmab003 = l_rmab.rmab003
            AND rmab004 = l_rmab.rmab004
            AND rmabseq = l_rmab.rmabseq  
      END IF   
      LET l_rmab003_t = l_rmab.rmab003 
      LET l_rmab004_t = l_rmab.rmab004
   
   END FOREACH 
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rmab_t SELECT * FROM armt100_detail
   
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
     FROM rmab_t
    WHERE rmabent = g_enterprise
      AND rmabdocno = g_rmaa_m.rmaadocno       
   IF l_cnt = 0 THEN 
      CALL cl_ask_pressanykey("arm-00022")   
   ELSE
      FOR l_num = 1 TO l_cnt
         #2016-5-26 zhujing mod-S
#         INSERT INTO rmac_t (rmacent,rmacsite,rmacdocno,rmacseq,rmacseq1,rmac001,rmac007)
#         VALUES(g_enterprise,g_site,g_rmaa_m.rmaadocno,g_rmab_d[l_num].rmabseq,'1',0,g_user)
         INSERT INTO rmac_t (rmacent,rmacsite,rmacdocno,rmacseq,rmacseq1,rmac001,rmac007,rmac002,rmac003,rmac004,rmac005)
         VALUES(g_enterprise,g_site,g_rmaa_m.rmaadocno,g_rmab_d[l_num].rmabseq,'1',0,g_user,' ',' ',' ',' ')
         #2016-5-26 zhujing mod-E
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert rmac_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END FOR
   END IF
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rmaadocno_t = g_rmaa_m.rmaadocno
   CALL armt100_b_fill()
   RETURN  
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE armt100_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rmac_t 
    WHERE rmacent = g_enterprise AND rmacdocno = g_rmaadocno_t
 
    INTO TEMP armt100_detail
 
   #將key修正為調整後   
   UPDATE armt100_detail SET rmacdocno = g_rmaa_m.rmaadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rmac_t SELECT * FROM armt100_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
 
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE armt100_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rmaadocno_t = g_rmaa_m.rmaadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="armt100.delete" >}
#+ 資料刪除
PRIVATE FUNCTION armt100_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_sql           STRING
   DEFINE  l_rmabseq       LIKE rmab_t.rmabseq
   DEFINE  l_rmab003       LIKE rmab_t.rmab003
   DEFINE  l_rmab004       LIKE rmab_t.rmab004
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_rmaa_m.rmaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN armt100_cl USING g_enterprise,g_rmaa_m.rmaadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt100_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE armt100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE armt100_master_referesh USING g_rmaa_m.rmaadocno INTO g_rmaa_m.rmaadocno,g_rmaa_m.rmaa001, 
       g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaastus, 
       g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaowndp, 
       g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt, 
       g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstdt,g_rmaa_m.rmaa001_desc, 
       g_rmaa_m.rmaa002_desc,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp_desc,g_rmaa_m.rmaacrtid_desc, 
       g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaacnfid_desc,g_rmaa_m.rmaapstid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT armt100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rmaa_m_mask_o.* =  g_rmaa_m.*
   CALL armt100_rmaa_t_mask()
   LET g_rmaa_m_mask_n.* =  g_rmaa_m.*
   
   CALL armt100_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL armt100_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rmaadocno_t = g_rmaa_m.rmaadocno
 
 
      DELETE FROM rmaa_t
       WHERE rmaaent = g_enterprise AND rmaadocno = g_rmaa_m.rmaadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rmaa_m.rmaadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_rmaa_m.rmaadocno,g_rmaa_m.rmaadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #同步刪除對應的[T:製造批序號庫存異動明細檔]
      LET l_sql = " SELECT rmabseq,rmab003,rmab004 ",
                  " FROM rmab_t ",
                  " WHERE rmabdocno = '",g_rmaa_m.rmaadocno,"' ",
                  "   AND rmabent = ",g_enterprise
      PREPARE armt100_inao_del_pre FROM l_sql 
      DECLARE armt100_inao_del_cur CURSOR FOR armt100_inao_del_pre
      FOREACH armt100_inao_del_cur INTO l_rmabseq,l_rmab003,l_rmab004         
         CALL armt100_update_inao(g_rmaa_m.rmaadocno,l_rmabseq,'1',l_rmab003,l_rmab004,'0') RETURNING l_success  
#      CALL armt100_update_inao(g_rmaa_m.rmaadocno,'','','','','0') RETURNING l_success  
      END FOREACH
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM rmab_t
       WHERE rmabent = g_enterprise AND rmabdocno = g_rmaa_m.rmaadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmab_t:",SQLERRMESSAGE 
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
      DELETE FROM rmac_t
       WHERE rmacent = g_enterprise AND
             rmacdocno = g_rmaa_m.rmaadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      #zhujing add
      
      DELETE FROM inao_t
         WHERE inaoent = g_enterprise 
           AND inaosite = g_site 
           AND inaodocno = g_rmaa_m.rmaadocno
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
      #zhujing add
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rmaa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE armt100_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rmab_d.clear() 
      CALL g_rmab2_d.clear()       
 
     
      CALL armt100_ui_browser_refresh()  
      #CALL armt100_ui_headershow()  
      #CALL armt100_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      #2016-4-11 zhujing add
      CALL g_inao_d.clear()
      CALL g_inao_d2.clear()
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL armt100_browser_fill("")
         CALL armt100_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE armt100_cl
 
   #功能已完成,通報訊息中心
   CALL armt100_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="armt100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION armt100_b_fill()
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
   CALL g_rmab_d.clear()
   CALL g_rmab2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF armt100_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rmabseq,rmab018,rmab019,rmab020,rmab001,rmab002,rmab003,rmab004, 
             rmab005,rmab006,rmab007,rmab008,rmab009,rmab010,rmab011,rmab021,rmab022,rmab012,rmab013, 
             rmab014,rmab015,rmab016,rmab017,rmabsite ,t1.imaal003 ,t2.oocal003 FROM rmab_t",   
                     " INNER JOIN rmaa_t ON rmaaent = " ||g_enterprise|| " AND rmaadocno = rmabdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=rmab009 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=rmab011 AND t2.oocal002='"||g_dlang||"' ",
 
                     " WHERE rmabent=? AND rmabdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         LET g_sql = g_sql CLIPPED, " AND rmabsite = '", g_site CLIPPED,"' "
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rmab_t.rmabseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE armt100_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR armt100_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rmaa_m.rmaadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rmaa_m.rmaadocno INTO g_rmab_d[l_ac].rmabseq,g_rmab_d[l_ac].rmab018, 
          g_rmab_d[l_ac].rmab019,g_rmab_d[l_ac].rmab020,g_rmab_d[l_ac].rmab001,g_rmab_d[l_ac].rmab002, 
          g_rmab_d[l_ac].rmab003,g_rmab_d[l_ac].rmab004,g_rmab_d[l_ac].rmab005,g_rmab_d[l_ac].rmab006, 
          g_rmab_d[l_ac].rmab007,g_rmab_d[l_ac].rmab008,g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010, 
          g_rmab_d[l_ac].rmab011,g_rmab_d[l_ac].rmab021,g_rmab_d[l_ac].rmab022,g_rmab_d[l_ac].rmab012, 
          g_rmab_d[l_ac].rmab013,g_rmab_d[l_ac].rmab014,g_rmab_d[l_ac].rmab015,g_rmab_d[l_ac].rmab016, 
          g_rmab_d[l_ac].rmab017,g_rmab_d[l_ac].rmabsite,g_rmab_d[l_ac].rmab009_desc,g_rmab_d[l_ac].rmab011_desc  
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
         CALL s_feature_description(g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010) RETURNING l_success,g_rmab_d[l_ac].rmab010_desc
         #获取料件品名规格
         CALL s_desc_get_item_desc(g_rmab_d[l_ac].rmab009)
            RETURNING g_rmab_d[l_ac].rmab009_desc,g_rmab_d[l_ac].rmab009_desc_1
         #获取单位说明
         CALL s_desc_get_unit_desc(g_rmab_d[l_ac].rmab011) RETURNING g_rmab_d[l_ac].rmab011_desc
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
   IF armt100_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rmacseq,rmacseq1,rmac001,rmac002,rmac003,rmac004,rmac005,rmac006, 
             rmac007,rmacsite ,t5.inayl003 ,t6.inab003 ,t7.ooag011 FROM rmac_t",   
                     " INNER JOIN  rmaa_t ON rmaaent = " ||g_enterprise|| " AND rmaadocno = rmacdocno ",
 
                     "",
                     
                                    " LEFT JOIN inayl_t t5 ON t5.inaylent="||g_enterprise||" AND t5.inayl001=rmac002 AND t5.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t6 ON t6.inabent="||g_enterprise||" AND t6.inabsite=rmacsite AND t6.inab001=rmac002 AND t6.inab002=rmac003  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=rmac007  ",
 
                     " WHERE rmacent=? AND rmacdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         LET g_sql = g_sql CLIPPED, " AND rmacsite = '", g_site CLIPPED,"' "
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rmac_t.rmacseq,rmac_t.rmacseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE armt100_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR armt100_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_rmaa_m.rmaadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_rmaa_m.rmaadocno INTO g_rmab2_d[l_ac].rmacseq,g_rmab2_d[l_ac].rmacseq1, 
          g_rmab2_d[l_ac].rmac001,g_rmab2_d[l_ac].rmac002,g_rmab2_d[l_ac].rmac003,g_rmab2_d[l_ac].rmac004, 
          g_rmab2_d[l_ac].rmac005,g_rmab2_d[l_ac].rmac006,g_rmab2_d[l_ac].rmac007,g_rmab2_d[l_ac].rmacsite, 
          g_rmab2_d[l_ac].rmac002_desc,g_rmab2_d[l_ac].rmac003_desc,g_rmab2_d[l_ac].rmac007_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         SELECT rmab009,rmab010,rmab011 INTO g_rmab2_d[l_ac].l_rmab009,g_rmab2_d[l_ac].l_rmab010,g_rmab2_d[l_ac].l_rmab011
         FROM rmab_t WHERE rmabdocno = g_rmaa_m.rmaadocno AND rmabsite = g_site AND rmabent = g_enterprise AND rmabseq = g_rmab2_d[l_ac].rmacseq
         #產品特徵
         CALL s_feature_description(g_rmab2_d[l_ac].l_rmab009,g_rmab2_d[l_ac].l_rmab010) RETURNING l_success,g_rmab2_d[l_ac].l_rmab010_desc
         #获取料件品名规格
         CALL s_desc_get_item_desc(g_rmab2_d[l_ac].l_rmab009)
            RETURNING g_rmab2_d[l_ac].l_rmab009_desc,g_rmab2_d[l_ac].l_rmab009_desc_1
         #获取单位说明
         CALL s_desc_get_unit_desc(g_rmab2_d[l_ac].l_rmab011) RETURNING g_rmab2_d[l_ac].l_rmab011_desc
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
   IF NOT cl_null(g_rmaa_m.rmaadocno) THEN
      CALL s_lot_b_fill('1',g_site,'1',g_rmaa_m.rmaadocno,'','','1')
      CALL armt100_inao_fill2()
   END IF
   #end add-point
   
   CALL g_rmab_d.deleteElement(g_rmab_d.getLength())
   CALL g_rmab2_d.deleteElement(g_rmab2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE armt100_pb
   FREE armt100_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rmab_d.getLength()
      LET g_rmab_d_mask_o[l_ac].* =  g_rmab_d[l_ac].*
      CALL armt100_rmab_t_mask()
      LET g_rmab_d_mask_n[l_ac].* =  g_rmab_d[l_ac].*
   END FOR
   
   LET g_rmab2_d_mask_o.* =  g_rmab2_d.*
   FOR l_ac = 1 TO g_rmab2_d.getLength()
      LET g_rmab2_d_mask_o[l_ac].* =  g_rmab2_d[l_ac].*
      CALL armt100_rmac_t_mask()
      LET g_rmab2_d_mask_n[l_ac].* =  g_rmab2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="armt100.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION armt100_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM rmab_t
       WHERE rmabent = g_enterprise AND
         rmabdocno = ps_keys_bak[1] AND rmabseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      DELETE FROM rmac_t
       WHERE rmacent = g_enterprise AND
         rmacdocno = ps_keys_bak[1] AND rmacseq = ps_keys_bak[2]
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
         CALL g_rmab_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM rmac_t
       WHERE rmacent = g_enterprise AND
             rmacdocno = ps_keys_bak[1] AND rmacseq = ps_keys_bak[2] AND rmacseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rmab2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
#      CALL armt100_b_fill()
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="armt100.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION armt100_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO rmab_t
                  (rmabent,
                   rmabdocno,
                   rmabseq
                   ,rmab018,rmab019,rmab020,rmab001,rmab002,rmab003,rmab004,rmab005,rmab006,rmab007,rmab008,rmab009,rmab010,rmab011,rmab021,rmab022,rmab012,rmab013,rmab014,rmab015,rmab016,rmab017,rmabsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rmab_d[g_detail_idx].rmab018,g_rmab_d[g_detail_idx].rmab019,g_rmab_d[g_detail_idx].rmab020, 
                       g_rmab_d[g_detail_idx].rmab001,g_rmab_d[g_detail_idx].rmab002,g_rmab_d[g_detail_idx].rmab003, 
                       g_rmab_d[g_detail_idx].rmab004,g_rmab_d[g_detail_idx].rmab005,g_rmab_d[g_detail_idx].rmab006, 
                       g_rmab_d[g_detail_idx].rmab007,g_rmab_d[g_detail_idx].rmab008,g_rmab_d[g_detail_idx].rmab009, 
                       g_rmab_d[g_detail_idx].rmab010,g_rmab_d[g_detail_idx].rmab011,g_rmab_d[g_detail_idx].rmab021, 
                       g_rmab_d[g_detail_idx].rmab022,g_rmab_d[g_detail_idx].rmab012,g_rmab_d[g_detail_idx].rmab013, 
                       g_rmab_d[g_detail_idx].rmab014,g_rmab_d[g_detail_idx].rmab015,g_rmab_d[g_detail_idx].rmab016, 
                       g_rmab_d[g_detail_idx].rmab017,g_rmab_d[g_detail_idx].rmabsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rmab_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      LET g_detail_idx = g_detail_idx2
      #end add-point 
      INSERT INTO rmac_t
                  (rmacent,
                   rmacdocno,
                   rmacseq,rmacseq1
                   ,rmac001,rmac002,rmac003,rmac004,rmac005,rmac006,rmac007,rmacsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_rmab2_d[g_detail_idx].rmac001,g_rmab2_d[g_detail_idx].rmac002,g_rmab2_d[g_detail_idx].rmac003, 
                       g_rmab2_d[g_detail_idx].rmac004,g_rmab2_d[g_detail_idx].rmac005,g_rmab2_d[g_detail_idx].rmac006, 
                       g_rmab2_d[g_detail_idx].rmac007,g_rmab2_d[g_detail_idx].rmacsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rmab2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="armt100.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION armt100_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rmab_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL armt100_rmab_t_mask_restore('restore_mask_o')
               
      UPDATE rmab_t 
         SET (rmabdocno,
              rmabseq
              ,rmab018,rmab019,rmab020,rmab001,rmab002,rmab003,rmab004,rmab005,rmab006,rmab007,rmab008,rmab009,rmab010,rmab011,rmab021,rmab022,rmab012,rmab013,rmab014,rmab015,rmab016,rmab017,rmabsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rmab_d[g_detail_idx].rmab018,g_rmab_d[g_detail_idx].rmab019,g_rmab_d[g_detail_idx].rmab020, 
                  g_rmab_d[g_detail_idx].rmab001,g_rmab_d[g_detail_idx].rmab002,g_rmab_d[g_detail_idx].rmab003, 
                  g_rmab_d[g_detail_idx].rmab004,g_rmab_d[g_detail_idx].rmab005,g_rmab_d[g_detail_idx].rmab006, 
                  g_rmab_d[g_detail_idx].rmab007,g_rmab_d[g_detail_idx].rmab008,g_rmab_d[g_detail_idx].rmab009, 
                  g_rmab_d[g_detail_idx].rmab010,g_rmab_d[g_detail_idx].rmab011,g_rmab_d[g_detail_idx].rmab021, 
                  g_rmab_d[g_detail_idx].rmab022,g_rmab_d[g_detail_idx].rmab012,g_rmab_d[g_detail_idx].rmab013, 
                  g_rmab_d[g_detail_idx].rmab014,g_rmab_d[g_detail_idx].rmab015,g_rmab_d[g_detail_idx].rmab016, 
                  g_rmab_d[g_detail_idx].rmab017,g_rmab_d[g_detail_idx].rmabsite) 
         WHERE rmabent = g_enterprise AND rmabdocno = ps_keys_bak[1] AND rmabseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmab_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmab_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL armt100_rmab_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rmac_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL armt100_rmac_t_mask_restore('restore_mask_o')
               
      UPDATE rmac_t 
         SET (rmacdocno,
              rmacseq,rmacseq1
              ,rmac001,rmac002,rmac003,rmac004,rmac005,rmac006,rmac007,rmacsite) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_rmab2_d[g_detail_idx].rmac001,g_rmab2_d[g_detail_idx].rmac002,g_rmab2_d[g_detail_idx].rmac003, 
                  g_rmab2_d[g_detail_idx].rmac004,g_rmab2_d[g_detail_idx].rmac005,g_rmab2_d[g_detail_idx].rmac006, 
                  g_rmab2_d[g_detail_idx].rmac007,g_rmab2_d[g_detail_idx].rmacsite) 
         WHERE rmacent = g_enterprise AND rmacdocno = ps_keys_bak[1] AND rmacseq = ps_keys_bak[2] AND rmacseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmac_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmac_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL armt100_rmac_t_mask_restore('restore_mask_n')
 
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
 
{<section id="armt100.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION armt100_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="armt100.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION armt100_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="armt100.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION armt100_lock_b(ps_table,ps_page)
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
   #CALL armt100_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rmab_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN armt100_bcl USING g_enterprise,
                                       g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "armt100_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "rmac_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN armt100_bcl2 USING g_enterprise,
                                             g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx].rmacseq,g_rmab2_d[g_detail_idx].rmacseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "armt100_bcl2:",SQLERRMESSAGE 
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
 
{<section id="armt100.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION armt100_unlock_b(ps_table,ps_page)
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
      CLOSE armt100_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE armt100_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="armt100.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION armt100_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rmaadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rmaadocno",TRUE)
      CALL cl_set_comp_entry("rmaadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("rmaa001",TRUE)
   IF cl_null(g_rmaa_m.rmaa004) THEN
      CALL cl_set_comp_entry("rmaa005,rmaa006",TRUE)
      CALL cl_set_comp_entry("s_detail1",TRUE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="armt100.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION armt100_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_num   LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   CALL armt100_detail_count() RETURNING l_num
   IF cl_null(l_num) THEN LET l_num = 0 END IF
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rmaadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rmaadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rmaadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_rmaa_m.rmaadocno) AND l_num = 0 THEN
      CALL cl_set_comp_entry("rmaa001",FALSE)
   END IF
   IF NOT cl_null(g_rmaa_m.rmaa004) THEN
      CALL cl_set_comp_entry("rmaa005,rmaa006",FALSE)
      CALL cl_set_comp_entry("s_detail1",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="armt100.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION armt100_set_entry_b(p_cmd)
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
 
{<section id="armt100.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION armt100_set_no_entry_b(p_cmd)
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
   #单头有出货单号，单身出货单号不可更改
   IF NOT cl_null(g_rmaa_m.rmaa005) THEN
      CALL cl_set_comp_entry("rmab003",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="armt100.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION armt100_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt100.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION armt100_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
 
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rmaa_m.rmaastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail,s_lot_sel1", FALSE)      #2016-4-11 zhujing mod
      
   END IF
   CALL cl_set_act_visible("count,s_lot_sel,insert,modify,delete,modify_detail",TRUE)      
   CASE g_rmaa_m.rmaastus
      WHEN 'N'   #未確認
         CALL cl_set_act_visible("count,s_lot_sel",FALSE)         
         CALL cl_set_act_visible("count_batch",FALSE)     #160816-00066#1 ADD
         CALL cl_set_act_visible("insert,modify,delete,modify_detail",TRUE)       
      WHEN 'S'   #已扣帳
         CALL cl_set_act_visible("count,s_lot_sel,modify,delete,modify_detail",FALSE)         
         CALL cl_set_act_visible("count_batch,s_lot_ins",FALSE)     #160816-00066#1 ADD
         
#      WHEN 'D'   #抽單
#         CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
#         CALL cl_set_act_visible("axmt540_produce_axmt580",FALSE)         
#
#      WHEN 'R'   #已拒絕     

      WHEN 'Y'   #已確認
         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
         CALL cl_set_act_visible("count,s_lot_sel",TRUE)
         CALL cl_set_act_visible("count_batch",TRUE)     #160816-00066#1 ADD

#      WHEN 'H'   #留置
#         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)

      WHEN 'X'   #作廢
         CALL cl_set_act_visible("count_batch,s_lot_ins",FALSE)     #160816-00066#1 ADD
         CALL cl_set_act_visible("count,s_lot_sel,modify,delete,modify_detail",FALSE)
         
#      WHEN 'W'   #送簽中
#         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
#         
#      WHEN 'A'   #已核准
#         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)    
#
   END CASE
   CALL cl_set_act_visible("s_lot_sel,s_lot_sel1",FALSE) #160816-00066#1 ADD
   CALL cl_set_act_visible("s_lot_ins",FALSE)            #160816-00066#1 ADD
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt100.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION armt100_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
#   CALL cl_set_act_visible("s_lot_sel,s_lot_sel1",TRUE) #2016-4-11 zhujing add
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt100.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION armt100_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   DEFINE l_flag1                LIKE type_t.num5           #160816-00066#1 add
   DEFINE l_ooac002              LIKE ooac_t.ooac002        #160816-00066#1 add
   #160816-00066#1 add-S
   IF NOT cl_null(g_rmaa_m.rmaadocno) THEN
      CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_flag1,l_ooac002
   END IF
   IF l_ac = 0 OR cl_null(l_ac) THEN
      RETURN
   END IF
   IF l_ac > g_rmab_d.getLength() THEN
      RETURN 
   END IF
   CALL cl_set_act_visible("s_lot_sel,s_lot_sel1,s_lot_ins",TRUE) #160816-00066#1 ADD
   #160816-00066#1 add-E
   CASE g_rmaa_m.rmaastus
      WHEN 'N'   #未確認
         CALL cl_set_act_visible("count,s_lot_sel",FALSE)         
         CALL cl_set_act_visible("insert,modify,delete,modify_detail",TRUE)      
         #160816-00066#1 add-S
         IF l_flag1 = 'N' THEN
            CALL cl_set_act_visible("s_lot_ins",TRUE)          
            CALL cl_set_act_visible("s_lot_sel1",FALSE)          
         ELSE
            CALL cl_set_act_visible("s_lot_ins",FALSE)          
            CALL cl_set_act_visible("s_lot_sel1",TRUE)          
         END IF
         #160816-00066#1 add-E
      WHEN 'S'   #已扣帳
         CALL cl_set_act_visible("count,s_lot_sel,modify,delete,modify_detail",FALSE)         
         CALL cl_set_act_visible("s_lot_ins,s_lot_sel1",FALSE)          #160816-00066#1 ADD
#      WHEN 'D'   #抽單
#         CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
#         CALL cl_set_act_visible("axmt540_produce_axmt580",FALSE)         
#
#      WHEN 'R'   #已拒絕     

      WHEN 'Y'   #已確認
         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
         CALL cl_set_act_visible("count,s_lot_sel,modify_detail",TRUE)
         CALL cl_set_act_visible("s_lot_ins,s_lot_sel1",FALSE)          #160816-00066#1 ADD

#      WHEN 'H'   #留置
#         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)

      WHEN 'X'   #作廢
         CALL cl_set_act_visible("count,s_lot_sel,modify,delete,modify_detail",FALSE)
         CALL cl_set_act_visible("s_lot_ins,s_lot_sel1",FALSE)          #160816-00066#1 ADD
         
#      WHEN 'W'   #送簽中
#         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
#         
#      WHEN 'A'   #已核准
#         CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)    
#
   END CASE
   #160816-00066#1 add-E
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt100.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION armt100_default_search()
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
      LET ls_wc = ls_wc, " rmaadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "rmaa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rmab_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rmac_t" 
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
 
{<section id="armt100.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION armt100_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_slip          LIKE ooba_t.ooba001
   DEFINE  l_sql           STRING               #2016-5-16 zhujing add
   DEFINE  l_rmabseq       LIKE rmab_t.rmabseq  #2016-5-16 zhujing add
   DEFINE  l_rmab003       LIKE rmab_t.rmab003  #2016-5-16 zhujing add
   DEFINE  l_rmab004       LIKE rmab_t.rmab004  #2016-5-16 zhujing add
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rmaa_m.rmaadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN armt100_cl USING g_enterprise,g_rmaa_m.rmaadocno
   IF STATUS THEN
      CLOSE armt100_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt100_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE armt100_master_referesh USING g_rmaa_m.rmaadocno INTO g_rmaa_m.rmaadocno,g_rmaa_m.rmaa001, 
       g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaastus, 
       g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaowndp, 
       g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt, 
       g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstdt,g_rmaa_m.rmaa001_desc, 
       g_rmaa_m.rmaa002_desc,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp_desc,g_rmaa_m.rmaacrtid_desc, 
       g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaacnfid_desc,g_rmaa_m.rmaapstid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT armt100_action_chk() THEN
      CLOSE armt100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rmaa_m.rmaadocno,g_rmaa_m.rmaadocno_desc,g_rmaa_m.rmaa001,g_rmaa_m.rmaa001_desc, 
       g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa002_desc, 
       g_rmaa_m.rmaa003,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaastus,g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006, 
       g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp,g_rmaa_m.rmaaowndp_desc, 
       g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtid_desc,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaacrtdt, 
       g_rmaa_m.rmaamodid,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaamoddt,g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfid_desc, 
       g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstid_desc,g_rmaa_m.rmaapstdt
 
   CASE g_rmaa_m.rmaastus
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
         CASE g_rmaa_m.rmaastus
            
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
      #unhold      取消留置
      #hold        留置      
      
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted,invalid,unhold,hold",FALSE)

      CASE g_rmaa_m.rmaastus
         WHEN "N"   #未確認
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

         WHEN "X"   #作廢
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN

         WHEN "Y"   #已確認
            CALL cl_set_act_visible("unconfirmed,posted",TRUE)

         WHEN "S"   #已過帳
           CALL cl_set_act_visible("unposted",TRUE)
#           
#         WHEN "Z"  #扣帳還原
#            RETURN
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
      g_rmaa_m.rmaastus = lc_state OR cl_null(lc_state) THEN
      CLOSE armt100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_err_collect_init()
   
   CASE lc_state
      WHEN 'Y'
         IF g_rmaa_m.rmaastus = 'N' THEN    #確認
            CALL s_armt100_conf_chk(g_rmaa_m.rmaadocno) RETURNING l_success
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
                  
                  CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_success,l_slip
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()
                     CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
                     RETURN
                  END IF
                  
                  CALL s_armt100_conf_upd(g_rmaa_m.rmaadocno) RETURNING l_success
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
         
         IF g_rmaa_m.rmaastus = 'S' THEN   #取消過帳
            CALL s_armt100_unpost_chk(g_rmaa_m.rmaadocno) RETURNING l_success
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
                  CALL s_armt100_unpost_upd(g_rmaa_m.rmaadocno) RETURNING l_success
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
         CALL s_armt100_invalid_chk(g_rmaa_m.rmaadocno) RETURNING l_success
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
               CALL s_armt100_invalid_upd(g_rmaa_m.rmaadocno) RETURNING l_success
               #2016-4-12 zhujing add
               IF l_success THEN
                  #2016-5-16 zhujing add(S)               
#                  CALL armt100_update_inao(g_rmaa_m.rmaadocno,'','','','','0') RETURNING l_success  
                  #同步刪除對應的[T:製造批序號庫存異動明細檔]
                  LET l_sql = " SELECT rmabseq,rmab003,rmab004 ",
                              " FROM rmab_t ",
                              " WHERE rmabdocno = '",g_rmaa_m.rmaadocno,"' ",
                              "   AND rmabent = ",g_enterprise
                  PREPARE armt100_inao_del_pre1 FROM l_sql 
                  DECLARE armt100_inao_del_cur1 CURSOR FOR armt100_inao_del_pre1
                  FOREACH armt100_inao_del_cur1 INTO l_rmabseq,l_rmab003,l_rmab004         
                     CALL armt100_update_inao(g_rmaa_m.rmaadocno,l_rmabseq,'1',l_rmab003,l_rmab004,'0') RETURNING l_success  
                  END FOREACH
                  #2016-5-16 zhujing add(E)               
               END IF
               #2016-4-12 zhujing add
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
         CALL s_armt100_post_chk(g_rmaa_m.rmaadocno) RETURNING l_success
         IF NOT l_success THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
            RETURN
         ELSE
            IF NOT cl_ask_confirm('sub-00232') THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               IF armt100_rmaa008_upd() THEN
                  CALL cl_err_collect_init() 
                  IF NOT s_armt100_post_upd(g_rmaa_m.rmaadocno) THEN
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
                  CALL cl_err_collect_show()
               ELSE
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               END IF
            END IF         
         END IF
      
      WHEN 'N'  #取消確認
         CALL s_armt100_unconf_chk(g_rmaa_m.rmaadocno) RETURNING l_success
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
               CALL s_armt100_unconf_upd(g_rmaa_m.rmaadocno) RETURNING l_success
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
   
   LET g_rmaa_m.rmaamodid = g_user
   LET g_rmaa_m.rmaamoddt = cl_get_current()
   LET g_rmaa_m.rmaastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rmaa_t 
      SET (rmaastus,rmaamodid,rmaamoddt) 
        = (g_rmaa_m.rmaastus,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt)     
    WHERE rmaaent = g_enterprise AND rmaadocno = g_rmaa_m.rmaadocno
 
    
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
      EXECUTE armt100_master_referesh USING g_rmaa_m.rmaadocno INTO g_rmaa_m.rmaadocno,g_rmaa_m.rmaa001, 
          g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaastus, 
          g_rmaa_m.rmaa004,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaowndp, 
          g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt, 
          g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstdt,g_rmaa_m.rmaa001_desc, 
          g_rmaa_m.rmaa002_desc,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp_desc, 
          g_rmaa_m.rmaacrtid_desc,g_rmaa_m.rmaacrtdp_desc,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaacnfid_desc, 
          g_rmaa_m.rmaapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rmaa_m.rmaadocno,g_rmaa_m.rmaadocno_desc,g_rmaa_m.rmaa001,g_rmaa_m.rmaa001_desc, 
          g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa008,g_rmaa_m.rmaa002,g_rmaa_m.rmaa002_desc, 
          g_rmaa_m.rmaa003,g_rmaa_m.rmaa003_desc,g_rmaa_m.rmaastus,g_rmaa_m.rmaa004,g_rmaa_m.rmaa005, 
          g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaaownid,g_rmaa_m.rmaaownid_desc,g_rmaa_m.rmaaowndp, 
          g_rmaa_m.rmaaowndp_desc,g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtid_desc,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdp_desc, 
          g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamodid_desc,g_rmaa_m.rmaamoddt,g_rmaa_m.rmaacnfid, 
          g_rmaa_m.rmaacnfid_desc,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstid_desc,g_rmaa_m.rmaapstdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE armt100_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL armt100_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt100.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION armt100_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rmab_d.getLength() THEN
         LET g_detail_idx = g_rmab_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rmab_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rmab_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_rmab2_d.getLength() THEN
         LET g_detail_idx = g_rmab2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rmab2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rmab2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="armt100.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION armt100_b_fill2(pi_idx)
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
   
   CALL armt100_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="armt100.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION armt100_fill_chk(ps_idx)
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
 
{<section id="armt100.status_show" >}
PRIVATE FUNCTION armt100_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="armt100.mask_functions" >}
&include "erp/arm/armt100_mask.4gl"
 
{</section>}
 
{<section id="armt100.signature" >}
   
 
{</section>}
 
{<section id="armt100.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION armt100_set_pk_array()
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
   LET g_pk_array[1].values = g_rmaa_m.rmaadocno
   LET g_pk_array[1].column = 'rmaadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt100.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="armt100.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION armt100_msgcentre_notify(lc_state)
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
   CALL armt100_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rmaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt100.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION armt100_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#46 add-S
   SELECT rmaastus  INTO g_rmaa_m.rmaastus
     FROM rmaa_t
    WHERE rmaaent = g_enterprise
      AND rmaadocno = g_rmaa_m.rmaadocno
      
   
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
      LET g_errno = NULL
      CASE g_rmaa_m.rmaastus
#        WHEN 'A'
#           LET g_errno = 'sub-00180'
        WHEN 'W'
           LET g_errno = 'sub-01347'
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
        LET g_errparam.extend = g_rmaa_m.rmaadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL armt100_set_act_visible()
        CALL armt100_set_act_no_visible()
        CALL armt100_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#46 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="armt100.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 串查單號
# Memo...........:
# Usage..........: CALL axmt540_qrystr(p_docno)
# Input parameter: p_docno   查詢單號
# Date & Author..: 2015-5-7 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_qrystr(p_docno)
   DEFINE p_docno LIKE rmaa_t.rmaadocno
   DEFINE l_slip     LIKE oobal_t.oobal002
   DEFINE l_prog     LIKE oobx_t.oobx004
   DEFINE l_success  LIKE type_t.num5
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   #抓取單據別
   LET l_slip = ''
   LET l_prog = ''
   IF NOT cl_null(p_docno) THEN
      CALL s_aooi200_get_slip(p_docno) RETURNING l_success,l_slip
      IF NOT cl_null(l_slip) THEN
         #抓取程式名稱
         SELECT oobx004 INTO l_prog
           FROM oobx_t
          WHERE oobxent = g_enterprise
            AND oobx001 = l_slip
      END IF
      IF NOT cl_null(l_prog) THEN
         INITIALIZE la_param.* TO NULL
         LET la_param.prog     = l_prog
         LET la_param.param[1] = p_docno
         LET ls_js = util.JSON.stringify(la_param)
         CALL cl_cmdrun_wait(ls_js)
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 根據出貨單號、項次帶出訂單單號、訂單項次、訂單項序、分批序、料件編號、品名、規格、產品特征、單位、數量
# Memo...........: 可退品数量加上已覆出的数量
# Memo...........: 由序号直接带出，设定数量为1，且退品未被退（覆出量=已退品）
# Usage..........: CALL armt100_rmab_default_insert(p_rmab003,p_rmab004)
#                  RETURNING r_success
# Input parameter: p_rmab003   出貨單號
#                : p_rmab004   出貨項次
# Return code....: r_success   
# Date & Author..: 2015-5-8 By zhujing
# Modify.........: 2016-3-24 By zhujing 
################################################################################
PRIVATE FUNCTION armt100_rmab_default_insert(p_rmab003,p_rmab004)
   DEFINE p_rmab003     LIKE rmab_t.rmab003
   DEFINE p_rmab004     LIKE rmab_t.rmab004
   DEFINE l_xmdk002     LIKE xmdk_t.xmdk002
   DEFINE l_xmdl035     LIKE xmdl_t.xmdl035
   DEFINE l_xmdl037     LIKE xmdl_t.xmdl037
   DEFINE l_xmdl056     LIKE xmdl_t.xmdl056
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_sql_rmab    STRING
   DEFINE l_rmab012     LIKE rmab_t.rmab012
   DEFINE l_rmab016     LIKE rmab_t.rmab016        #2016-3-24 zhujing add-计算退品量时加上已覆出的
   DEFINE l_date        LIKE rmab_t.rmab021        #160816-00066#1 add
   DEFINE l_date2       LIKE rmab_t.rmab021        #160816-00066#1 add
   DEFINE l_imaf117     LIKE imaf_t.imaf117        #160816-00066#1 add
   DEFINE l_imaf118     LIKE imaf_t.imaf118        #160816-00066#1 add
   DEFINE l_flag1       LIKE type_t.num5           #160816-00066#1 add
   DEFINE l_ooac002     LIKE ooac_t.ooac002        #160816-00066#1 add
   
   LET r_success = TRUE
   LET g_errno = ''
   
   #160816-00066#1 add-S 不与出货单勾稽，则数量自行维护，不控管
   CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_flag1,l_ooac002    
#   IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'N' THEN   
#      RETURN r_success   
#   END IF
   #160816-00066#1 add-E
   IF cl_null(p_rmab003) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF cl_null(p_rmab004) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   

   IF cl_null(g_rmab_d[l_ac].rmab005) THEN      #訂單單號
      LET g_rmab_d[l_ac].rmab006 = ''           #訂單項次
      LET g_rmab_d[l_ac].rmab007 = ''           #訂單項序
      LET g_rmab_d[l_ac].rmab008 = ''           #分批序
   END IF

   IF cl_null(g_rmab_d[l_ac].rmab006) THEN
      LET g_rmab_d[l_ac].rmab007 = ''
      LET g_rmab_d[l_ac].rmab008 = ''
   END IF

   IF cl_null(g_rmab_d[l_ac].rmab007) THEN
      LET g_rmab_d[l_ac].rmab008 = ''
   END IF
   
#   SELECT xmdk002 INTO l_xmdk002           #160816-00066#1 marked
   SELECT xmdk002,xmdkdocdt INTO l_xmdk002,l_date    #160816-00066#1 add
     FROM xmdk_t 
    WHERE xmdkent = g_enterprise
      AND xmdksite = g_site
      AND xmdkdocno = p_rmab003
      
   LET l_sql_rmab = " SELECT xmdl003,xmdl004,xmdl005,xmdl006,xmdl008,xmdl009,xmdl017,xmdl018,COALESCE(xmdl035,0),COALESCE(xmdl037,0),COALESCE(xmdl056,0) ",
                    " FROM xmdl_t ",
                    " WHERE xmdldocno = '",p_rmab003,"' ",
                    "   AND xmdlseq = ",p_rmab004,
                    "   AND xmdlent = ",g_enterprise,
                    "   AND xmdlsite = '",g_site,"' "
                    
#   IF NOT cl_null(g_rmaa_m.rmaa006) THEN
#      LET l_sql_rmab = l_sql_rmab CLIPPED," AND xmdl003 = '",g_rmaa_m.rmaa006,"' "
#   END IF
   LET l_sql_rmab = l_sql_rmab CLIPPED," ORDER BY xmdl003,xmdl004,xmdl005,xmdl006 "
   PREPARE armt100_rmab_default_pre FROM l_sql_rmab
   EXECUTE armt100_rmab_default_pre INTO g_rmab_d[l_ac].rmab005,g_rmab_d[l_ac].rmab006,g_rmab_d[l_ac].rmab007,
         g_rmab_d[l_ac].rmab008,g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010,g_rmab_d[l_ac].rmab011,g_rmab_d[l_ac].rmab012,
         l_xmdl035,l_xmdl037,l_xmdl056         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #160816-00066#1 add-S
      IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'Y' THEN
         SELECT NVL(imaf117,0),NVL(imaf118,0) INTO l_imaf117,l_imaf118
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = g_rmab_d[l_ac].rmab009
         #imaf117保證(固)月數
         #imaf118保證(固)天數
         LET g_rmab_d[l_ac].rmab021 = s_date_get_date(l_date,l_imaf117,l_imaf118)
         LET l_date2 = cl_get_current()
         IF g_rmab_d[l_ac].rmab021 < l_date2 THEN
            LET g_rmab_d[l_ac].rmab022 = 'N'
         ELSE
            LET g_rmab_d[l_ac].rmab022 = 'Y'
         END IF
      ELSE
         LET g_rmab_d[l_ac].rmab021 = NULL
         LET g_rmab_d[l_ac].rmab022 = 'N'
         LET g_rmab_d[l_ac].rmab012 = 0
      END IF
      #160816-00066#1 add-E
#      LET g_rmab_d[l_ac].rmabseq = l_ac
      LET g_rmab_d[l_ac].rmabsite = g_site
      LET g_rmab_d[l_ac].rmab001 = g_rmab_d_o.rmab001
      LET g_rmab_d[l_ac].rmab003 = p_rmab003
      LET g_rmab_d[l_ac].rmab004 = p_rmab004
      LET g_rmab_d[l_ac].rmab012 = 0
      #160816-00066#1 add-S
      IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'Y' THEN
      #160816-00066#1 add-E
      #出货性质为3.签收单则直接带入签收量
      #其他出货性质：检验合格量-已销退量
      IF l_xmdk002 = '3' THEN
         LET g_rmab_d[l_ac].rmab012 = l_xmdl035
      ELSE         
         LET g_rmab_d[l_ac].rmab012 = l_xmdl056 - l_xmdl037
      END IF
     
      #检查是否有其他非作废退货量，若有，减去
      #2016-3-24 zhujing mod-若有已覆出量，则加上
      IF NOT cl_null(g_rmaa_m.rmaa006) THEN
#         SELECT SUM(rmab012) INTO l_rmab012 FROM rmab_t 
         SELECT SUM(rmab012),SUM(rmab016) INTO l_rmab012,l_rmab016 FROM rmab_t   #2016-3-24 zhujing mod
         LEFT OUTER JOIN rmaa_t ON rmabdocno = rmaadocno AND rmabsite = rmaasite AND rmabent = rmaaent
         WHERE rmab003 = g_rmab_d[l_ac].rmab003 AND rmab004 = g_rmab_d[l_ac].rmab004 AND rmab005 = g_rmaa_m.rmaa006
         AND rmabent = g_enterprise AND rmabsite = g_site AND rmaastus <> 'X'
         AND ((rmabseq<>g_rmab_d[l_ac].rmabseq AND rmabdocno = g_rmaa_m.rmaadocno) 
         OR ( rmabdocno <> g_rmaa_m.rmaadocno))            #除去自己
      ELSE
#         SELECT SUM(rmab012) INTO l_rmab012 FROM rmab_t 
         SELECT SUM(rmab012),SUM(rmab016) INTO l_rmab012,l_rmab016 FROM rmab_t   #2016-3-24 zhujing mod
         LEFT OUTER JOIN rmaa_t ON rmabdocno = rmaadocno AND rmabsite = rmaasite AND rmabent = rmaaent
         WHERE rmab003 = g_rmab_d[l_ac].rmab003 AND rmab004 = g_rmab_d[l_ac].rmab004
         AND rmabent = g_enterprise AND rmabsite = g_site AND rmaastus <> 'X'
         AND ((rmabseq<>g_rmab_d[l_ac].rmabseq AND rmabdocno = g_rmaa_m.rmaadocno) 
         OR ( rmabdocno <> g_rmaa_m.rmaadocno))            #除去自己
      END IF
            
      IF cl_null(l_rmab012) THEN LET l_rmab012 = 0 END IF
      IF cl_null(l_rmab016) THEN LET l_rmab016 = 0 END IF               #2016-3-24 zhujing add
      LET g_rmab_d[l_ac].rmab012 = g_rmab_d[l_ac].rmab012 + l_rmab016   #2016-3-24 zhujing add
      
      IF l_rmab012 > g_rmab_d[l_ac].rmab012 AND g_rmab_d[l_ac].rmab012 <> 0 THEN
         #报错已无可退退品
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "arm-00015"   #申请退品数量大于可退数量
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
         DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
         
      ELSE
         LET g_rmab_d[l_ac].rmab012 = g_rmab_d[l_ac].rmab012 - l_rmab012
         #2016-3-24 zhujing add-由序号直接带出----(S)
         IF NOT cl_null(g_rmab_d[l_ac].rmab018) THEN
            #检查出货单+项次是否有可退量，若有，是否大于由序号带出的1,若小于1则给出货单+项次带出的值
            IF g_rmab_d[l_ac].rmab012 >= 1 THEN
            #检查是否有退品记录，覆出记录，两者值是否相等，若相等，则退品给值1
               SELECT SUM(rmab012),SUM(rmab016) INTO l_rmab012,l_rmab016 FROM rmab_t  
               LEFT OUTER JOIN rmaa_t ON rmabdocno = rmaadocno AND rmabsite = rmaasite AND rmabent = rmaaent
               WHERE rmabent = g_enterprise AND rmabsite = g_site AND rmaastus <> 'X' AND rmab018 = g_rmab_d[l_ac].rmab018
               AND ((rmabseq<>g_rmab_d[l_ac].rmabseq AND rmabdocno = g_rmaa_m.rmaadocno) 
               OR ( rmabdocno <> g_rmaa_m.rmaadocno))            #除去自己
               IF cl_null(l_rmab012) THEN LET l_rmab012 = 0 END IF
               IF cl_null(l_rmab016) THEN LET l_rmab016 = 0 END IF
               IF l_rmab012 = l_rmab016 THEN    #相等，则可退
                  LET g_rmab_d[l_ac].rmab012 = 1
               ELSE
                  #报错已无可退退品
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "arm-00049"   #相同序号的料件不可重复退货!
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
                  LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
                  DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
                  RETURN r_success
               END IF
            ELSE
            #报错已无可退退品
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "arm-00048"   #该序号的料件可退货量已不足，不可申请退货！
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
               LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
               DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
               RETURN r_success
            END IF
         END IF
         #2016-3-24 zhujing add-由序号直接带出----(E)
         DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
         
      END IF
      #160816-00066#1 add-S
      END IF
      #160816-00066#1 add-E
      LET g_rmab_d[l_ac].rmab013 = g_rmab_d[l_ac].rmab012
      LET g_rmab_d[l_ac].rmab014 = 0
      LET g_rmab_d[l_ac].rmab015 = 0
      LET g_rmab_d[l_ac].rmab016 = 0
      #获取料件品名规格
      CALL s_desc_get_item_desc(g_rmab_d[l_ac].rmab009)
         RETURNING g_rmab_d[l_ac].rmab009_desc,g_rmab_d[l_ac].rmab009_desc_1
      #获取产品特征说明
      CALL s_feature_description(g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010) 
         RETURNING l_success,g_rmab_d[l_ac].rmab010_desc
      #获取单位说明   
      CALL s_desc_get_unit_desc(g_rmab_d[l_ac].rmab011) RETURNING g_rmab_d[l_ac].rmab011_desc
      
      LET g_rmab_d_o.* = g_rmab_d[l_ac].*
      DISPLAY g_rmab_d[l_ac].rmab009 TO rmab009
      DISPLAY g_rmab_d[l_ac].rmab009_desc TO rmab009_desc
      DISPLAY g_rmab_d[l_ac].rmab009_desc_1 TO rmab009_desc_1
      DISPLAY g_rmab_d[l_ac].rmab010 TO rmab010
      DISPLAY g_rmab_d[l_ac].rmab010_desc TO rmab010_desc
      DISPLAY g_rmab_d[l_ac].rmab011 TO rmab011
      DISPLAY g_rmab_d[l_ac].rmab011_desc TO rmab011_desc
#      IF NOT armt100_rmab012_chk(p_rmab003,p_rmab004) THEN
#         LET r_success = FALSE
#         LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
#         LET g_rmab_d[l_ac].rmab013 = g_rmab_d[l_ac].rmab012
#         DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
#         DISPLAY g_rmab_d[l_ac].rmab013 TO rmab013
#         RETURN r_success
#      ELSE
#         LET g_rmab_d[l_ac].rmab013 = g_rmab_d[l_ac].rmab012
#         DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
#         DISPLAY g_rmab_d[l_ac].rmab013 TO rmab013
#      END IF
#      INITIALIZE gs_keys TO NULL 
#      LET gs_keys[1] = g_rmaa_m.rmaadocno
#      LET gs_keys[2] = g_rmab_d[l_ac].rmabseq
#      LET g_detail_idx = l_ac
#      CALL armt100_insert_b('rmab_t',gs_keys,"'1'")
#      
#      LET g_rmab2_d[1].rmacseq1 = '1'
#      LET g_rmab2_d[1].rmac001 = g_rmab_d[g_detail_idx].rmab013
#      LET g_rmab2_d[1].rmac002 = ' '
#      LET g_rmab2_d[1].rmac003 = ' '
#      LET g_rmab2_d[1].rmac004 = ' '
#      LET g_rmab2_d[1].rmac005 = ' '
#      LET g_rmab2_d[1].rmac006 = g_today
#      LET g_rmab2_d[1].rmac007 = g_user
#      CALL s_desc_get_person_desc(g_rmab2_d[1].rmac007) RETURNING g_rmab2_d[1].rmac007_desc
#      INITIALIZE gs_keys TO NULL 
#      LET g_detail_idx2 = 1
#      LET gs_keys[1] = g_rmaa_m.rmaadocno
#      LET gs_keys[2] = g_rmab_d[g_detail_idx].rmabseq
#      LET gs_keys[3] = '1'
#      CALL armt100_insert_b('rmac_t',gs_keys,"'2'")
      
#      LET l_ac = l_ac + 1   
#   
#   END FOREACH

   RETURN r_success
   
END FUNCTION

PRIVATE FUNCTION armt100_rmaadocdt_rmaa008_chk()
   DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
   #151120-00003#1 20151123 mark by beckxie---S
   #IF NOT cl_null(g_rmaa_m.rmaa008) AND NOT cl_null(g_rmaa_m.rmaadocdt) THEN
   #   IF g_rmaa_m.rmaa008 < g_rmaa_m.rmaadocdt THEN
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
# Descriptions...: 检查申请退品数量
################################################################################
PRIVATE FUNCTION armt100_rmab012_chk(p_rmab003,p_rmab004)
   DEFINE p_rmab003     LIKE rmab_t.rmab003
   DEFINE p_rmab004     LIKE rmab_t.rmab004
   DEFINE l_xmdk002     LIKE xmdk_t.xmdk002
   DEFINE l_xmdl035     LIKE xmdl_t.xmdl035
   DEFINE l_xmdl037     LIKE xmdl_t.xmdl037
   DEFINE l_xmdl056     LIKE xmdl_t.xmdl056
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_sql_rmab    STRING
   DEFINE l_rmab012     LIKE rmab_t.rmab012
   DEFINE l_rmab012_t   LIKE rmab_t.rmab012
   DEFINE l_rmab016     LIKE rmab_t.rmab016        #2016-3-24 zhujing add
   DEFINE l_flag1       LIKE type_t.num5           #160816-00066#1 add
   DEFINE l_ooac002     LIKE ooac_t.ooac002        #160816-00066#1 add

   LET r_success = TRUE
   LET g_errno = ''
   
   #160816-00066#1 add-S 不与出货单勾稽，则数量自行维护，不控管
   CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_flag1,l_ooac002    
   IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'N' THEN   
      RETURN r_success   
   END IF
   #160816-00066#1 add-E
   
   IF cl_null(p_rmab003) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF cl_null(p_rmab004) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_rmab012_t = 0
   #有客訴單
   IF NOT cl_null(g_rmab_d[l_ac].rmab001) THEN
      SELECT xmfo014 INTO l_rmab012_t
        FROM xmfo_t
       WHERE xmfoent = g_enterprise
         AND xmfosite = g_site
         AND xmfodocno = g_rmab_d[l_ac].rmab001
   ELSE
      #無客訴單
      SELECT xmdk002 INTO l_xmdk002
        FROM xmdk_t 
       WHERE xmdkent = g_enterprise
         AND xmdksite = g_site
         AND xmdkdocno = p_rmab003
         
   
      LET l_sql_rmab = " SELECT COALESCE(xmdl035,0),COALESCE(xmdl037,0),COALESCE(xmdl056,0) ",
                       " FROM xmdl_t ",
                       " WHERE xmdldocno = '",p_rmab003,"' ",
                       "   AND xmdlseq = ",p_rmab004,
                       "   AND xmdlent = ",g_enterprise,
                       "   AND xmdlsite = '",g_site,"' "
      PREPARE armt100_rmab_default_pre2 FROM l_sql_rmab
      EXECUTE armt100_rmab_default_pre2 INTO l_xmdl035,l_xmdl037,l_xmdl056         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
   
         #出货性质为3.签收单则直接带入签收量
         #其他出货性质：检验合格量-已销退量
         IF l_xmdk002 = '3' THEN
            LET l_rmab012_t = l_xmdl035
         ELSE         
            LET l_rmab012_t = l_xmdl056 - l_xmdl037
         END IF
      END IF
      #检查是否有其他非作废退货量，若有，减去
      LET l_rmab012 = 0
      IF NOT cl_null(g_rmab_d[l_ac].rmab001) THEN
#         SELECT SUM(rmab012) INTO l_rmab012     #2016-3-24 zhujing
         SELECT SUM(rmab012),SUM(rmab016) INTO l_rmab012,l_rmab016     #2016-3-24 zhujing mod
           FROM rmab_t 
                LEFT OUTER JOIN rmaa_t ON rmabdocno = rmaadocno AND rmabsite = rmaasite AND rmabent = rmaaent
          WHERE rmab003 = g_rmab_d[l_ac].rmab003 AND rmab004 = g_rmab_d[l_ac].rmab004
            AND rmabent = g_enterprise AND rmabsite = g_site AND rmaastus <> 'X' AND rmab001 = g_rmab_d[l_ac].rmab001
            AND ((rmabseq<>g_rmab_d[l_ac].rmabseq AND rmabdocno = g_rmaa_m.rmaadocno) 
            OR ( rmabdocno <> g_rmaa_m.rmaadocno))            #除去自己
      ELSE
#         SELECT SUM(rmab012) INTO l_rmab012     #2016-3-24 zhujing
         SELECT SUM(rmab012),SUM(rmab016) INTO l_rmab012,l_rmab016     #2016-3-24 zhujing mod
           FROM rmab_t 
                LEFT OUTER JOIN rmaa_t ON rmabdocno = rmaadocno AND rmabsite = rmaasite AND rmabent = rmaaent
          WHERE rmab003 = g_rmab_d[l_ac].rmab003 AND rmab004 = g_rmab_d[l_ac].rmab004
            AND rmabent = g_enterprise AND rmabsite = g_site AND rmaastus <> 'X'
            AND ((rmabseq<>g_rmab_d[l_ac].rmabseq AND rmabdocno = g_rmaa_m.rmaadocno) 
            OR ( rmabdocno <> g_rmaa_m.rmaadocno))            #除去自己
      END IF
         
      IF cl_null(g_rmab_d[l_ac].rmab012) THEN LET g_rmab_d[l_ac].rmab012 = 0  END IF
      IF cl_null(l_rmab012) THEN LET l_rmab012 = 0 END IF
      IF cl_null(l_rmab016) THEN LET l_rmab016 = 0 END IF               #2016-3-24 zhujing add
#      IF l_rmab012_t < g_rmab_d[l_ac].rmab012 + l_rmab012 AND g_rmab_d[l_ac].rmab012 <> 0 THEN             #2016-3-24 zhujing marked
      IF l_rmab012_t < g_rmab_d[l_ac].rmab012 + l_rmab012 - l_rmab016 AND g_rmab_d[l_ac].rmab012 <> 0 THEN  #2016-3-24 zhujing mod
         #报错已无可退退品
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "arm-00015"   #申请退品数量大于可退数量
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
         LET r_success = FALSE
      ELSE
         #2016-3-24 zhujing add-由序号直接带出----(S)
         IF NOT cl_null(g_rmab_d[l_ac].rmab018) THEN
            #检查出货单+项次是否有可退量，若有，是否大于由序号带出的1,若小于1则给出货单+项次带出的值
            IF g_rmab_d[l_ac].rmab012 >= 1 THEN
            #检查是否有退品记录，覆出记录，两者值是否相等，若相等，则退品给值1
               SELECT SUM(rmab012),SUM(rmab016) INTO l_rmab012,l_rmab016 FROM rmab_t  
               LEFT OUTER JOIN rmaa_t ON rmabdocno = rmaadocno AND rmabsite = rmaasite AND rmabent = rmaaent
               WHERE rmabent = g_enterprise AND rmabsite = g_site AND rmaastus <> 'X' AND rmab018 = g_rmab_d[l_ac].rmab018
               AND ((rmabseq<>g_rmab_d[l_ac].rmabseq AND rmabdocno = g_rmaa_m.rmaadocno) 
               OR ( rmabdocno <> g_rmaa_m.rmaadocno))            #除去自己
               IF cl_null(l_rmab012) THEN LET l_rmab012 = 0 END IF
               IF cl_null(l_rmab016) THEN LET l_rmab016 = 0 END IF
               IF l_rmab012 = l_rmab016 THEN    #相等，则可退
                  IF g_rmab_d[l_ac].rmab012 > 1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'arm-00047'   #该序号的料件申请退货数量只能为1!
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_rmab_d[l_ac].rmab012 = 1
                  END IF
               ELSE
                  #报错已无可退退品
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "arm-00049"   #相同序号的料件不可重复退货!
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
                  LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
                  DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "arm-00048"   #该序号的料件可退货量已不足，不可申请退货！
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
               LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
               DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
               RETURN r_success
            END IF
         END IF
         #2016-3-24 zhujing add-由序号直接带出----(E)
               
      END IF
      LET g_rmab_d[l_ac].rmab013 = g_rmab_d[l_ac].rmab012
      LET g_rmab_d[l_ac].rmab014 = 0
      LET g_rmab_d[l_ac].rmab015 = 0
      LET g_rmab_d[l_ac].rmab016 = 0
#      LET g_rmab_d_o.* = g_rmab_d[l_ac].*


   RETURN r_success
END FUNCTION

PRIVATE FUNCTION armt100_rmaa008_upd()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_rmaamoddt LIKE inba_t.inbamoddt
   DEFINE l_gzsz008   LIKE gzsz_t.gzsz008
   DEFINE l_forupd_sql STRING

   LET r_success = TRUE
   LET l_gzsz008 = ''
   
   IF g_rmaa_m.rmaadocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   SELECT UNIQUE rmaadocno,rmaadocdt,rmaa001,rmaa003,rmaa002,rmaa004,rmaastus,rmaa005,rmaa006,rmaa007,rmaa008,rmaaownid,rmaaowndp,rmaacrtid,rmaacrtdp,rmaacrtdt,rmaamodid,rmaamoddt,rmaacnfid,rmaacnfdt,rmaapstid,rmaapstdt
     INTO g_rmaa_m.rmaadocno,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa001,g_rmaa_m.rmaa003,g_rmaa_m.rmaa002,g_rmaa_m.rmaa004,g_rmaa_m.rmaastus,g_rmaa_m.rmaa005,g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaa008,g_rmaa_m.rmaaownid,
     g_rmaa_m.rmaaowndp,g_rmaa_m.rmaacrtid,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaamodid,g_rmaa_m.rmaamoddt,g_rmaa_m.rmaacnfid,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaapstdt
     FROM rmaa_t
    WHERE rmaaent = g_enterprise AND rmaasite = g_site AND rmaadocno = g_rmaa_m.rmaadocno
   
   LET l_forupd_sql = " SELECT rmaadocno,rmaasite,rmaadocdt,rmaa001,rmaa002,rmaa003,rmaa004,rmaastus, ",
                      "  rmaa005,rmaa006,rmaa007,rmaa008,rmaaownid,rmaacrtdp,rmaaowndp,rmaacrtdt,rmaacrtid, ",
                      "  rmaamodid,rmaacnfdt,rmaamoddt,rmaapstid,rmaacnfid,rmaapstdt", 
                      " FROM rmaa_t ",
                      " WHERE rmaaent= ? AND rmaadocno=? FOR UPDATE"

   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)                #轉換不同資料庫語法
   LET l_forupd_sql = cl_sql_add_mask(l_forupd_sql)              #遮蔽特定資料
   DECLARE armt100_rmaa008_cl CURSOR FROM l_forupd_sql
   
   OPEN armt100_rmaa008_cl USING g_enterprise,g_rmaa_m.rmaadocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN armt100_rmaa008_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE armt100_rmaa008_cl
      LET r_success = FALSE
      RETURN r_success
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH armt100_rmaa008_cl INTO g_rmaa_m.rmaadocno,g_rmaa_m.rmaasite,g_rmaa_m.rmaadocdt,g_rmaa_m.rmaa001,g_rmaa_m.rmaa002,g_rmaa_m.rmaa003,g_rmaa_m.rmaa004,g_rmaa_m.rmaastus, 
                                 g_rmaa_m.rmaa005,g_rmaa_m.rmaa006,g_rmaa_m.rmaa007,g_rmaa_m.rmaa008,g_rmaa_m.rmaaownid,g_rmaa_m.rmaacrtdp,g_rmaa_m.rmaaowndp,g_rmaa_m.rmaacrtdt,g_rmaa_m.rmaacrtid, 
                                 g_rmaa_m.rmaamodid,g_rmaa_m.rmaacnfdt,g_rmaa_m.rmaamoddt,g_rmaa_m.rmaapstid,g_rmaa_m.rmaacnfid,g_rmaa_m.rmaapstdt
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_rmaa_m.rmaadocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE armt100_rmaa008_cl
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL armt100_show()
   
   INPUT BY NAME g_rmaa_m.rmaa008 WITHOUT DEFAULTS
             
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            LET r_success = FALSE
            RETURN r_success
         END IF

      AFTER FIELD rmaa008
         #維護的日期不可小於庫存關帳日
         LET l_gzsz008 = cl_get_para(g_enterprise,g_site,'S-MFG-0031') 
         IF g_rmaa_m.rmaa008 <= l_gzsz008 THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'sub-00306'
            LET g_errparam.extend = g_rmaa_m.rmaa008
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      #維護的日期不可大於現行年月，錯誤訊息「扣帳日期大於會計年度期別，請重新輸入]
      
   END INPUT
   
   IF INT_FLAG OR g_rmaa_m.rmaa008 IS NULL THEN
      LET INT_FLAG = 0
      CLOSE armt100_rmaa008_cl
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET l_rmaamoddt = cl_get_current()

   UPDATE rmaa_t SET rmaa008 = g_rmaa_m.rmaa008,
                     rmaamodid = g_user,
                     rmaamoddt = l_rmaamoddt
     WHERE rmaaent = g_enterprise AND rmaasite = g_site AND rmaadocno = g_rmaa_m.rmaadocno

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "g_rmaa_m"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE armt100_rmaa008_cl
      
      LET r_success = FALSE
      RETURN r_success 
   END IF

   CLOSE armt100_rmaa008_cl
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 检查项次是否存在
################################################################################
PRIVATE FUNCTION armt100_rmab004_chk(p_rmab003,p_rmab004)
   DEFINE p_rmab003     LIKE rmab_t.rmab003
   DEFINE p_rmab004     LIKE rmab_t.rmab004
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   LET r_success = TRUE
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM xmdl_t 
     WHERE xmdldocno = p_rmab003
       AND xmdlseq = p_rmab004
       AND xmdlent = g_enterprise
       AND xmdlsite = g_site
   IF l_cnt = 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 自動產生單身
################################################################################
PRIVATE FUNCTION armt100_auto_gene_detail()
DEFINE   l_sql    STRING
#161124-00048#11 mod-S
#DEFINE   l_xmdl   RECORD LIKE xmdl_t.*
#DEFINE   l_rmab   RECORD LIKE rmab_t.*
DEFINE l_rmab RECORD  #RMA維護單身檔
       rmabent LIKE rmab_t.rmabent, #企业编号
       rmabsite LIKE rmab_t.rmabsite, #营运据点
       rmabdocno LIKE rmab_t.rmabdocno, #单据单号
       rmabseq LIKE rmab_t.rmabseq, #项次
       rmab001 LIKE rmab_t.rmab001, #客诉单号
       rmab002 LIKE rmab_t.rmab002, #客诉项次
       rmab003 LIKE rmab_t.rmab003, #出货单号
       rmab004 LIKE rmab_t.rmab004, #出货项次
       rmab005 LIKE rmab_t.rmab005, #订单单号
       rmab006 LIKE rmab_t.rmab006, #订单项次
       rmab007 LIKE rmab_t.rmab007, #订单项序
       rmab008 LIKE rmab_t.rmab008, #订单分批序
       rmab009 LIKE rmab_t.rmab009, #料号
       rmab010 LIKE rmab_t.rmab010, #产品特征
       rmab011 LIKE rmab_t.rmab011, #单位
       rmab012 LIKE rmab_t.rmab012, #申请退货数量
       rmab013 LIKE rmab_t.rmab013, #点收数量
       rmab014 LIKE rmab_t.rmab014, #已转维修数量
       rmab015 LIKE rmab_t.rmab015, #已转销退数量
       rmab016 LIKE rmab_t.rmab016, #覆出数量
       rmab017 LIKE rmab_t.rmab017, #备注
       rmab018 LIKE rmab_t.rmab018, #序号
       rmab019 LIKE rmab_t.rmab019, #生产日期
       rmab020 LIKE rmab_t.rmab020, #有效日期
       rmab021 LIKE rmab_t.rmab021, #保固日期
       rmab022 LIKE rmab_t.rmab022  #保固内
END RECORD
DEFINE l_xmdl RECORD  #出貨/簽收/銷退單單身明細檔
       xmdlent LIKE xmdl_t.xmdlent, #企业编号
       xmdlsite LIKE xmdl_t.xmdlsite, #营运据点
       xmdldocno LIKE xmdl_t.xmdldocno, #单据编号
       xmdlseq LIKE xmdl_t.xmdlseq, #项次
       xmdl001 LIKE xmdl_t.xmdl001, #出通单号
       xmdl002 LIKE xmdl_t.xmdl002, #出通项次
       xmdl003 LIKE xmdl_t.xmdl003, #订单单号
       xmdl004 LIKE xmdl_t.xmdl004, #订单项次
       xmdl005 LIKE xmdl_t.xmdl005, #订单项序
       xmdl006 LIKE xmdl_t.xmdl006, #订单分批序
       xmdl007 LIKE xmdl_t.xmdl007, #子件特性
       xmdl008 LIKE xmdl_t.xmdl008, #料件编号
       xmdl009 LIKE xmdl_t.xmdl009, #产品特征
       xmdl010 LIKE xmdl_t.xmdl010, #包装容器
       xmdl011 LIKE xmdl_t.xmdl011, #作业编号
       xmdl012 LIKE xmdl_t.xmdl012, #作业序
       xmdl013 LIKE xmdl_t.xmdl013, #多库储批出货
       xmdl014 LIKE xmdl_t.xmdl014, #库位
       xmdl015 LIKE xmdl_t.xmdl015, #储位
       xmdl016 LIKE xmdl_t.xmdl016, #批号
       xmdl017 LIKE xmdl_t.xmdl017, #出货单位
       xmdl018 LIKE xmdl_t.xmdl018, #数量
       xmdl019 LIKE xmdl_t.xmdl019, #参考单位
       xmdl020 LIKE xmdl_t.xmdl020, #参考数量
       xmdl021 LIKE xmdl_t.xmdl021, #计价单位
       xmdl022 LIKE xmdl_t.xmdl022, #计价数量
       xmdl023 LIKE xmdl_t.xmdl023, #检验否
       xmdl024 LIKE xmdl_t.xmdl024, #单价
       xmdl025 LIKE xmdl_t.xmdl025, #税种
       xmdl026 LIKE xmdl_t.xmdl026, #税率
       xmdl027 LIKE xmdl_t.xmdl027, #税前金额
       xmdl028 LIKE xmdl_t.xmdl028, #含税金额
       xmdl029 LIKE xmdl_t.xmdl029, #税额
       xmdl030 LIKE xmdl_t.xmdl030, #项目编号
       xmdl031 LIKE xmdl_t.xmdl031, #WBS编号
       xmdl032 LIKE xmdl_t.xmdl032, #活动编号
       xmdl033 LIKE xmdl_t.xmdl033, #客户料号
       xmdl034 LIKE xmdl_t.xmdl034, #QPA
       xmdl035 LIKE xmdl_t.xmdl035, #已签收量
       xmdl036 LIKE xmdl_t.xmdl036, #已签退量
       xmdl037 LIKE xmdl_t.xmdl037, #已销退量
       xmdl038 LIKE xmdl_t.xmdl038, #主账套已立账数量
       xmdl039 LIKE xmdl_t.xmdl039, #账套二已立账数量
       xmdl040 LIKE xmdl_t.xmdl040, #账套三已立账数量
       xmdl041 LIKE xmdl_t.xmdl041, #保税否
       xmdl042 LIKE xmdl_t.xmdl042, #取价来源
       xmdl043 LIKE xmdl_t.xmdl043, #价格来源参考单号
       xmdl044 LIKE xmdl_t.xmdl044, #价格来源参考项次
       xmdl045 LIKE xmdl_t.xmdl045, #取出价格
       xmdl046 LIKE xmdl_t.xmdl046, #价差比
       xmdl047 LIKE xmdl_t.xmdl047, #已开发票数量
       xmdl048 LIKE xmdl_t.xmdl048, #发票编号
       xmdl049 LIKE xmdl_t.xmdl049, #发票号码
       xmdl050 LIKE xmdl_t.xmdl050, #理由码
       xmdl051 LIKE xmdl_t.xmdl051, #备注
       xmdl052 LIKE xmdl_t.xmdl052, #库存管理特征
       xmdl053 LIKE xmdl_t.xmdl053, #主账套暂估数量
       xmdl054 LIKE xmdl_t.xmdl054, #账套二暂估数量
       xmdl055 LIKE xmdl_t.xmdl055, #账套三暂估数量
       xmdl081 LIKE xmdl_t.xmdl081, #签退数量(签收、签退单使用)
       xmdl082 LIKE xmdl_t.xmdl082, #签退参考数量(签收、签退单使用)
       xmdl083 LIKE xmdl_t.xmdl083, #签退计价数量(签收、签退单使用)
       xmdl084 LIKE xmdl_t.xmdl084, #签退理由码(签收、签退单使用)
       xmdl085 LIKE xmdl_t.xmdl085, #订单开立据点
       xmdl086 LIKE xmdl_t.xmdl086, #订单多角性质
       xmdl087 LIKE xmdl_t.xmdl087, #需自立应收否
       xmdl088 LIKE xmdl_t.xmdl088, #多角流程编号
       xmdl089 LIKE xmdl_t.xmdl089, #QC单号
       xmdl090 LIKE xmdl_t.xmdl090, #判定项次
       xmdl091 LIKE xmdl_t.xmdl091, #判定结果
       xmdl092 LIKE xmdl_t.xmdl092, #借货还量数量
       xmdl093 LIKE xmdl_t.xmdl093, #借货还量参考数量
       xmdl200 LIKE xmdl_t.xmdl200, #销售渠道
       xmdl201 LIKE xmdl_t.xmdl201, #产品组编码
       xmdl202 LIKE xmdl_t.xmdl202, #销售范围编码
       xmdl203 LIKE xmdl_t.xmdl203, #销售办公室
       xmdl204 LIKE xmdl_t.xmdl204, #出货包装单位
       xmdl205 LIKE xmdl_t.xmdl205, #出货包装数量
       xmdl206 LIKE xmdl_t.xmdl206, #签退包装数量
       xmdl207 LIKE xmdl_t.xmdl207, #库存锁定等级
       xmdl208 LIKE xmdl_t.xmdl208, #标准价
       xmdl209 LIKE xmdl_t.xmdl209, #促销价
       xmdl210 LIKE xmdl_t.xmdl210, #交易价
       xmdl211 LIKE xmdl_t.xmdl211, #折价金额
       xmdl212 LIKE xmdl_t.xmdl212, #销售组织
       xmdl213 LIKE xmdl_t.xmdl213, #销售人员
       xmdl214 LIKE xmdl_t.xmdl214, #销售部门
       xmdl215 LIKE xmdl_t.xmdl215, #合同编号
       xmdl216 LIKE xmdl_t.xmdl216, #经营方式
       xmdl217 LIKE xmdl_t.xmdl217, #结算类型
       xmdl218 LIKE xmdl_t.xmdl218, #结算方式
       xmdl219 LIKE xmdl_t.xmdl219, #交易类型
       xmdl220 LIKE xmdl_t.xmdl220, #寄销已核销数量
       xmdl222 LIKE xmdl_t.xmdl222, #地区编号
       xmdl223 LIKE xmdl_t.xmdl223, #县市编号
       xmdl224 LIKE xmdl_t.xmdl224, #省区编号
       xmdl225 LIKE xmdl_t.xmdl225, #区域编号
       xmdl226 LIKE xmdl_t.xmdl226, #商品条码
       xmdlunit LIKE xmdl_t.xmdlunit, #应用组织
       xmdlorga LIKE xmdl_t.xmdlorga, #账务组织
       xmdl056 LIKE xmdl_t.xmdl056, #检验合格量
       xmdl094 LIKE xmdl_t.xmdl094, #来源单号(销退)
       xmdl095 LIKE xmdl_t.xmdl095, #项次(销退)
       xmdl227 LIKE xmdl_t.xmdl227, #现金折扣单号
       xmdl228 LIKE xmdl_t.xmdl228, #现金折扣单项次
       xmdl057 LIKE xmdl_t.xmdl057, #有效日期
       xmdl058 LIKE xmdl_t.xmdl058, #制造日期
       xmdl096 LIKE xmdl_t.xmdl096, #来源项次
       xmdl059 LIKE xmdl_t.xmdl059, #客户退货量
       xmdl060 LIKE xmdl_t.xmdl060  #放行状态
END RECORD
#161124-00048#11 mod-E
DEFINE   l_i      LIKE type_t.num5
DEFINE   l_cnt    LIKE type_t.num5
DEFINE   l_sum    LIKE type_t.num5
DEFINE   l_seq    LIKE type_t.num5
DEFINE   r_success   LIKE type_t.num5
DEFINE   l_xmdk002   LIKE xmdk_t.xmdk002
DEFINE   l_xmdlseq   LIKE xmdl_t.xmdlseq
   
   SELECT xmdk002 INTO l_xmdk002
     FROM xmdk_t 
    WHERE xmdkent = g_enterprise
      AND xmdksite = g_site
      AND xmdkdocno = g_rmaa_m.rmaa005
      SELECT MAX(xmdlseq) INTO l_xmdlseq
        FROM xmdl_t 
       WHERE xmdlent = g_enterprise
         AND xmdlsite = g_site
         AND xmdldocno = g_rmaa_m.rmaa005
   
   LET l_i = 0
   FOR l_seq = 1 TO l_xmdlseq
#      IF NOT cl_null(g_rmaa_m.rmaa006) THEN
#         SELECT SUM(rmab012) INTO l_sum
#           FROM rmab_t
#          WHERE rmab003 = g_rmaa_m.rmaa005
#            AND rmab004 = l_seq
#            AND rmab005 = g_rmaa_m.rmaa006
#            AND rmabent = g_enterprise 
#            AND rmabsite = g_site
#      ELSE
         SELECT SUM(rmab012) INTO l_sum
           FROM rmab_t
          WHERE rmab003 = g_rmaa_m.rmaa005
            AND rmab004 = l_seq
            AND rmabent = g_enterprise 
            AND rmabsite = g_site
#      END IF
      IF cl_null(l_sum) THEN
         LET l_sum = 0
      END IF
      LET l_cnt = 0
      IF l_xmdk002 ='3' THEN
#         IF NOT cl_null(g_rmaa_m.rmaa006) THEN
#            SELECT SUM(COALESCE(xmdl035,0)) INTO l_cnt FROM xmdl_t
#             WHERE xmdlseq = l_seq
#               AND xmdlsite = g_site
#               AND xmdlent = g_enterprise
#               AND xmdldocno = g_rmaa_m.rmaa005 
#               AND xmdl003 = g_rmaa_m.rmaa006 
#         ELSE
            SELECT SUM(COALESCE(xmdl035,0)) INTO l_cnt FROM xmdl_t
             WHERE xmdlseq = l_seq
               AND xmdlsite = g_site
               AND xmdlent = g_enterprise
               AND xmdldocno = g_rmaa_m.rmaa005 
#         END IF
#         LET l_sql = " SELECT COUNT(*) FROM xmdl_t,xmdk_t ",
#                  "  WHERE xmdkent = xmdlent ",
#                  "    AND xmdkdocno = xmdldocno",
#                  "    AND xmdlseq = ",l_seq,
#                  "    AND xmdkstus = 'Y'",
#                  "    AND xmdlent = '",g_enterprise,"'",
#                  "    AND xmdldocno = '",g_rmaa_m.rmaa005,"'",
#                  "    AND SUM(COALESCE(xmdl035,0)) < ",l_sum ," "
      ELSE
#         IF NOT cl_null(g_rmaa_m.rmaa006) THEN
#            SELECT SUM((COALESCE(xmdl056,0))-(COALESCE(xmdl037,0))) INTO l_cnt FROM xmdl_t
#             WHERE xmdlseq = l_seq
#               AND xmdlsite = g_site
#               AND xmdlent = g_enterprise
#               AND xmdldocno = g_rmaa_m.rmaa005
#               AND xmdl003 = g_rmaa_m.rmaa006 
#         ELSE
            SELECT SUM((COALESCE(xmdl056,0))-(COALESCE(xmdl037,0))) INTO l_cnt FROM xmdl_t
             WHERE xmdlseq = l_seq
               AND xmdlsite = g_site
               AND xmdlent = g_enterprise
               AND xmdldocno = g_rmaa_m.rmaa005
#         END IF
#         LET l_sql = " SELECT COUNT(*) FROM xmdl_t,xmdk_t ",
#                  "  WHERE xmdkent = xmdlent ",
#                  "    AND xmdkdocno = xmdldocno",
#                  "    AND xmdlseq = ",l_seq,
#                  "    AND xmdkstus = 'Y'",
#                  "    AND xmdlent = '",g_enterprise,"'",
#                  "    AND xmdldocno = '",g_rmaa_m.rmaa005,"'",
#                  "    AND SUM((COALESCE(xmdl056,0))-(COALESCE(xmdl037,0))) < ",l_sum ," "
      END IF
      IF l_cnt > l_sum THEN
         LET l_i = l_i + 1
         LET l_ac = l_i
         CALL armt100_rmab_default_insert(g_rmaa_m.rmaa005,l_seq) RETURNING r_success
         IF NOT r_success THEN
            LET l_i = l_i - 1
         ELSE
            INSERT INTO rmab_t (rmabent,rmabsite,rmabdocno,rmabseq,rmab001,rmab002,rmab003,rmab004,rmab005,rmab006,rmab007,rmab008,
                          rmab009,rmab010,rmab011,rmab012,rmab013,rmab014,rmab015,rmab016,rmab017)
                   VALUES(g_enterprise,g_site,g_rmaa_m.rmaadocno,l_i,g_rmab_d[l_ac].rmab001,g_rmab_d[l_ac].rmab002,g_rmab_d[l_ac].rmab003,g_rmab_d[l_ac].rmab004,
                          g_rmab_d[l_ac].rmab005,g_rmab_d[l_ac].rmab006,g_rmab_d[l_ac].rmab007,g_rmab_d[l_ac].rmab008,g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010,g_rmab_d[l_ac].rmab011,
                          g_rmab_d[l_ac].rmab012,g_rmab_d[l_ac].rmab013,g_rmab_d[l_ac].rmab014,g_rmab_d[l_ac].rmab015,g_rmab_d[l_ac].rmab016,NULL)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert rmab_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT FOR
            ELSE
#               INSERT INTO rmac_t (rmacent,rmacsite,rmacdocno,rmacseq,rmacseq1,rmac001,rmac007)
#                   VALUES(g_enterprise,g_site,g_rmaa_m.rmaadocno,l_i,'1',g_rmab_d[l_ac].rmab013,g_user)
               INSERT INTO rmac_t (rmacent,rmacsite,rmacdocno,rmacseq,rmacseq1,rmac001,rmac007,rmac002,rmac003,rmac004,rmac005)          #2016-5-26 zhujing mod
                   VALUES(g_enterprise,g_site,g_rmaa_m.rmaadocno,l_i,'1',g_rmab_d[l_ac].rmab013,g_user,' ',' ',' ',' ')
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'insert rmac_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT FOR
               END IF
            END IF      
         END IF
      END IF
   END FOR
  
END FUNCTION

################################################################################
# Descriptions...: 退品點收
################################################################################
PRIVATE FUNCTION armt100_rmac001_upd()
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_num                  LIKE type_t.num10
   DEFINE l_no                   LIKE type_t.num10      #查看是否有多个项序
   DEFINE l_imaf055              LIKE imaf_t.imaf055    #库存管理特征是否维护
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_cmd         LIKE type_t.chr1
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE l_insert               BOOLEAN
   DEFINE l_count                LIKE type_t.num10
   DEFINE l_rmab013     LIKE rmab_t.rmab013  #已点收数量
   DEFINE l_rmab012     LIKE rmab_t.rmab013  #申请数量
   DEFINE r_success        LIKE type_t.num5              #判断是否需要维护制造批序号 2016-4-6 zhujing add
   
   #當前在查詢方案頁簽時，直接返回，否則程式可能會當出
   IF g_main_hidden THEN
      RETURN
   END IF
   IF g_rmaa_m.rmaadocno IS NULL THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF

   CALL armt100_show()
   
   IF g_open = 'N' THEN
      RETURN
   END IF
   CALL cl_set_act_visible("delete,insert",TRUE)
   CALL cl_set_act_visible("modify_detail",TRUE)
   CALL cl_set_comp_entry("l_rmab009,l_rmab010,l_rmab011",FALSE)
   CALL cl_set_comp_entry("rmacseq,rmacseq1,rmac001,rmac002,rmac003,rmac004,rmac005,rmac006,rmac007",TRUE)
   LET l_num = 0
   INITIALIZE l_imaf055 TO NULL
   SELECT imaf055 INTO l_imaf055 FROM imaf_t WHERE imaf001 = g_rmab_d[g_detail_idx].rmab009 AND imafent = g_enterprise AND imafsite = g_site
   IF l_imaf055 = '2' THEN
      CALL cl_set_comp_entry("rmac005",FALSE)
   END IF
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_rmab2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = TRUE, #此頁面insert功能由產生器控制, 手動之設定無效! 
                 DELETE ROW = TRUE,
                 APPEND ROW = TRUE)
         
         ON ACTION s_lot_sel
            LET g_action_choice="s_lot_sel"
            IF cl_auth_chk_act("s_lot_sel") THEN
               
               #add-point:ON ACTION s_lot_sel name="menu.detail_show.page2.s_lot_sel"
               #160202-00019#1 zhujing add 申请资料
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
                              
               IF g_rmab_d[g_detail_idx].rmab018 IS NOT NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'arm-00054'      #该资料已自动产生制造批序号资料，不可执行该动作！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               
                
               IF NOT cl_null(g_rmaa_m.rmaadocno) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmabseq) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab009) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab011) AND
                  NOT cl_null(g_rmab_d[g_detail_idx].rmab012) AND
                  NOT cl_null(g_rmaa_m.rmaa002) THEN
                  LET l_success = ''
                  IF s_lot_batch_number_1n3(g_rmab_d[g_detail_idx].rmab009,g_site) THEN
                     CALL s_transaction_begin()
                     IF armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'2') THEN
                        #160816-00066#1 mod-S
#                        CALL s_lot_sel('2','2',g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab2_d[g_detail_idx].rmac005,
#                                      g_rmab2_d[g_detail_idx].rmac002,g_rmab2_d[g_detail_idx].rmac003,g_rmab2_d[g_detail_idx].rmac004,g_rmab_d[g_detail_idx].rmab011,g_rmab2_d[g_detail_idx].rmac001,'1','armt100','','','','',0)
                        CALL s_lot_sel('2','2',g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab2_d[g_detail_idx2].rmac005,
                                      g_rmab2_d[g_detail_idx2].rmac002,g_rmab2_d[g_detail_idx2].rmac003,g_rmab2_d[g_detail_idx2].rmac004,g_rmab_d[g_detail_idx].rmab011,g_rmab2_d[g_detail_idx2].rmac001,'1','armt100','','','','',0)
                        #160816-00066#1 mod-E
                           RETURNING l_success                              
                        CALL armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'3') RETURNING l_success
                        IF l_success THEN   
                           IF NOT armt100_ins_inao_2(g_rmab2_d[g_detail_idx2].rmacseq) THEN
                              NEXT FIELD CURRENT
                           END IF
                           CALL armt100_inao_fill2() 
                        END IF
                     END IF
                     IF l_success THEN
                        CALL s_transaction_end('Y','0')
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                     IF NOT cl_null(g_rmaa_m.rmaadocno) THEN
                        CALL s_lot_b_fill('1',g_site,'2',g_rmaa_m.rmaadocno,'','','1')
                     END IF
                  END IF
                  LET g_current_row = g_current_idx #目前指標  
               END IF
               #160202-00019#1 zhujing add
            END IF
            
         BEFORE INPUT
           
            CALL armt100_b_fill()
            LET g_rec_b = g_rmab2_d.getLength()
            NEXT FIELD rmac001
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rmab2_d[l_ac].* TO NULL 
            INITIALIZE g_rmab2_d_t.* TO NULL 
            INITIALIZE g_rmab2_d_o.* TO NULL 
            LET g_rmab2_d[l_ac].rmac006 = g_today  
            LET g_rmab2_d[l_ac].rmac007 = g_user
            LET g_rmab2_d[l_ac].rmacsite = g_site
            #预设项次
            IF cl_null(g_rmab2_d[l_ac].rmacseq) THEN
              LET g_rmab2_d[l_ac].rmacseq = 1
            END IF
            IF NOT cl_null(g_rmab2_d[l_ac].rmacseq) THEN
               IF cl_null(g_rmab2_d[l_ac].rmacseq1) THEN
                 SELECT MAX(rmacseq1)+1
                    INTO g_rmab2_d[l_ac].rmacseq1
                    FROM rmac_t
                   WHERE rmacent = g_enterprise
                     AND rmacdocno = g_rmaa_m.rmaadocno
                     AND rmacseq = g_rmab2_d[l_ac].rmacseq
               END IF
               CALL armt100_rmac_default_insert()
              
               #料件未维护库存管理特征，则不用输入库存管理特征
               LET l_num = 0
               INITIALIZE l_imaf055 TO NULL
               SELECT imaf055 INTO l_imaf055 FROM imaf_t WHERE imaf001 = g_rmab2_d[l_ac].l_rmab009 AND imafent = g_enterprise AND imafsite = g_site
               IF l_imaf055 = '2' THEN
                  CALL cl_set_comp_entry("rmac005",FALSE)
               END IF
               IF s_lot_batch_number_1n3(g_rmab2_d[l_ac].l_rmab009,g_site)  THEN
                  #新增时，若点收数量大于0，则开启制造批序号维护
                  IF g_rmab2_d[g_detail_idx2].rmac001 = 0 THEN
                     #刪除实际資料                              
                     DELETE FROM inao_t 
                      WHERE inaoent = g_enterprise 
                        AND inaosite = g_site
                        AND inaodocno = g_rmaa_m.rmaadocno
                        AND inaoseq = g_rmab_d[g_detail_idx2].rmabseq
                        AND inaoseq1 = g_rmab2_d[g_detail_idx2].rmacseq1
                        AND inao000 = '2'
                        AND inao013 = '1'
                  END IF
                  
                  IF g_rmab2_d[g_detail_idx2].rmac001 > 0 THEN
                     IF NOT cl_null(g_rmab_d[g_detail_idx].rmab018) THEN
                        IF NOT armt100_ins_inao_2(g_rmab2_d[g_detail_idx2].rmacseq) THEN
                           NEXT FIELD CURRENT
                        END IF
                        CALL armt100_inao_fill2() 
                     ELSE
                        IF armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'2') THEN
                           CALL s_lot_sel('2','2',g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmab_d[g_detail_idx].rmab009,g_rmab_d[g_detail_idx].rmab010,g_rmab2_d[g_detail_idx2].rmac005,
                                          g_rmab2_d[g_detail_idx2].rmac002,g_rmab2_d[g_detail_idx2].rmac003,g_rmab2_d[g_detail_idx2].rmac004,g_rmab_d[g_detail_idx].rmab011,g_rmab2_d[g_detail_idx2].rmac001,'1','armt100','','','','',0)
                              RETURNING l_success   
#                           IF l_success THEN   #2016-5-13 zhujing marked
                              CALL armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'3') RETURNING l_success
#                           END IF
                        END IF
                     END IF
                  END IF
               END IF
               CALL armt100_inao_fill2() 
            END IF
            
            #end add-point
            LET g_rmab2_d_t.* = g_rmab2_d[l_ac].*     #新輸入資料
            LET g_rmab2_d_o.* = g_rmab2_d[l_ac].*     #新輸入資料
#            LET g_rmab2_d_t.rmac001 = NULL
#            LET g_rmab2_d_o.rmac001 = NULL
            CALL cl_show_fld_cont()
            CALL armt100_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            IF cl_null(g_open) THEN
               LET g_open = 'N'
            END IF
            
            #end add-point
            CALL armt100_set_no_entry_b(l_cmd)
            #add-point:modify段before insert

            #end add-point  
            
         BEFORE ROW     
            CALL s_transaction_begin()
            LET g_rec_b = g_rmab2_d.getLength()
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
#            LET g_current_page = 2
#            LET g_rmab2_d[l_ac].rmac006 = g_today  
#            LET g_rmab2_d[l_ac].rmac007 = g_user
#            LET g_rmab2_d[l_ac].rmacsite = g_site
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            OPEN armt100_cl USING g_enterprise,g_rmaa_m.rmaadocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt100_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE armt100_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_rmab2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rmab2_d[l_ac].rmacseq IS NOT NULL
               AND g_rmab2_d[l_ac].rmacseq1 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_rmab2_d_t.* = g_rmab2_d[l_ac].*  #BACKUP
               LET g_rmab2_d_o.* = g_rmab2_d[l_ac].*  #BACKUP

            ELSE
               LET l_cmd = 'a'
            END IF
            IF l_cmd = 'a' THEN
               INITIALIZE g_rmab_d_t.* TO NULL 
               INITIALIZE g_rmab_d_o.* TO NULL             
            END IF
            
        BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d)

               #end add-point
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前

               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rmaa_m.rmaadocno
               LET gs_keys[gs_keys.getLength()+1] = g_rmab2_d_t.rmacseq
               LET gs_keys[gs_keys.getLength()+1] = g_rmab2_d_t.rmacseq1
            
               #刪除同層單身
               IF NOT armt100_delete_b('rmac_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt100_bcl
                  CANCEL DELETE
               END IF
    
#               #刪除下層單身
#               IF NOT armt100_key_delete_b(gs_keys,'rmac_t') THEN
#                  CALL s_transaction_end('N','0')
#                  CLOSE armt100_bcl
#                  CANCEL DELETE
#               END IF
               
               #刪除多語言
               
              
              #add-point:單身2刪除中
              #回写点收数量（重新计算）
              SELECT SUM(rmac001) INTO l_num
                 FROM rmac_t
                WHERE rmacdocno = g_rmaa_m.rmaadocno
                  AND rmacseq = g_rmab2_d_t.rmacseq
#                  AND rmacseq1 <> g_rmab2_d_t.rmacseq1
                  AND rmacent = g_enterprise 
                  AND rmacsite = g_site
               IF cl_null(l_num) THEN LET l_num = 0 END IF
#               UPDATE rmab_t SET (rmab013) = (g_rmab2_d[l_ac].rmac001+l_num)  
               UPDATE rmab_t SET (rmab013) = (l_num)  
               WHERE rmabent = g_enterprise AND rmabdocno = g_rmaa_m.rmaadocno
               AND rmabseq = g_rmab2_d_t.rmacseq #項次 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rmab_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                   
                  CALL s_transaction_end('N','0')
                  LET g_rmab2_d[l_ac].* = g_rmab2_d_t.*             
               END IF
               #160202-00019#1---add---begin
               #清空inao025的值，并刪除实际資料   
               IF armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab2_d_t.rmacseq,g_rmab2_d_t.rmacseq1,g_rmaa_m.rmaadocno,g_rmab2_d_t.rmacseq,'2') THEN
                  DELETE FROM inao_t 
                   WHERE inaoent = g_enterprise 
                     AND inaosite = g_site
                     AND inaodocno = g_rmaa_m.rmaadocno
                     AND inaoseq = g_rmab2_d_t.rmacseq
                     AND inaoseq1 = g_rmab2_d_t.rmacseq1
                     AND inao000 = '2'
                     AND inao013 = '1'
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inao_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()           
                     CALL s_transaction_end('N','0')
                     CANCEL DELETE
                  END IF  
               END IF
               #160202-00019#1---add---end   
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE armt100_bcl
               LET g_rec_b = g_rec_b-1
               
               #add-point:單身2刪除後

               #end add-point
               LET l_count = g_rmab_d.getLength()
               
               #add-point:單身刪除後(<>d)
#               CALL armt100_b_fill()
               #end add-point
            END IF 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rmab2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM rmac_t 
             WHERE rmacent = g_enterprise AND rmacdocno = g_rmaa_m.rmaadocno
               AND rmacseq = g_rmab2_d[l_ac].rmacseq
               AND rmacseq1 = g_rmab2_d[l_ac].rmacseq1
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmaa_m.rmaadocno
               LET gs_keys[2] = g_rmab2_d[g_detail_idx2].rmacseq
               LET gs_keys[3] = g_rmab2_d[g_detail_idx2].rmacseq1
               CALL armt100_insert_b('rmac_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_rmab_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmac_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL armt100_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後
               #回写点收数量（重新计算）
               SELECT SUM(rmac001) INTO l_num
                  FROM rmac_t
                 WHERE rmacdocno = g_rmaa_m.rmaadocno
                   AND rmacseq = g_rmab2_d[l_ac].rmacseq #項次
#                   AND rmacseq1 <> g_rmab2_d[l_ac].rmacseq1 #項序
                   AND rmacent = g_enterprise 
                   AND rmacsite = g_site
#                IF cl_null(l_num) THEN LET l_num = 0 END IF
#                UPDATE rmab_t SET (rmab013) = (g_rmab2_d[l_ac].rmac001+l_num)  
                #2016-5-16 zhujing add(S) 回写至inao_t
                IF g_rmab2_d_t.rmacseq<>g_rmab2_d[l_ac].rmacseq OR g_rmab2_d_t.rmacseq1<>g_rmab2_d[l_ac].rmacseq1 
                   OR g_rmab2_d_t.rmac002<>g_rmab2_d[l_ac].rmac002 OR cl_null(g_rmab2_d_t.rmac002)
                   OR g_rmab2_d_t.rmac003<>g_rmab2_d[l_ac].rmac003 OR cl_null(g_rmab2_d_t.rmac003)
                   OR g_rmab2_d_t.rmac004<>g_rmab2_d[l_ac].rmac004 OR cl_null(g_rmab2_d_t.rmac004)
                   OR g_rmab2_d_t.rmac005<>g_rmab2_d[l_ac].rmac005 OR cl_null(g_rmab2_d_t.rmac005) THEN
                   UPDATE inao_t SET (inaosite,inaoseq,inaoseq1,inao003,inao005,inao006,inao007)
                         = (g_rmab2_d[l_ac].rmacsite,g_rmab2_d[l_ac].rmacseq,g_rmab2_d[l_ac].rmacseq1,g_rmab2_d[l_ac].rmac005,g_rmab2_d[l_ac].rmac002,g_rmab2_d[l_ac].rmac003,g_rmab2_d[l_ac].rmac004)  
                         #自訂欄位頁簽
                   WHERE inaoent = g_enterprise AND inaodocno = g_rmaa_m.rmaadocno
                        AND inaoseq = g_rmab2_d_t.rmacseq #項次 
                        AND inaoseq1 = g_rmab2_d_t.rmacseq1
                        AND inao000 = '2'
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = "inao_t" 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()                   
                      CALL s_transaction_end('N','0')
                      LET g_rmab2_d[l_ac].* = g_rmab2_d_t.*  
                   END IF
                END IF
                #2016-5-16 zhujing add(E)
                UPDATE rmab_t SET (rmab013) = (l_num)  
                WHERE rmabent = g_enterprise AND rmabdocno = g_rmaa_m.rmaadocno
                AND rmabseq = g_rmab2_d[l_ac].rmacseq #項次 
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "rmab_t" 
                   LET g_errparam.code   = SQLCA.sqlcode 
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()                   
                   CALL s_transaction_end('N','0')
                   LET g_rmab2_d[l_ac].* = g_rmab2_d_t.*  
                ELSE
                  CALL s_transaction_end('Y','0')
                END IF   
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
         AFTER FIELD rmacseq
            #預設項序
            IF NOT cl_null(g_rmab2_d[l_ac].rmacseq) OR g_rmab2_d[l_ac].rmacseq <> g_rmab2_d_t.rmacseq THEN
               SELECT COUNT(*) INTO l_num
                 FROM rmab_t
                WHERE rmabent = g_enterprise
                  AND rmabdocno = g_rmaa_m.rmaadocno
                  AND rmabseq = g_rmab2_d[l_ac].rmacseq
               IF l_num < 1 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "arm-00019" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_rmab2_d[l_ac].rmacseq = g_rmab2_d_t.rmacseq
                  DISPLAY g_rmab2_d[l_ac].rmacseq TO rmacseq
                  NEXT FIELD CURRENT
               END IF               
               IF cl_null(g_rmab2_d[l_ac].rmacseq1) OR g_rmab2_d[l_ac].rmacseq <> g_rmab2_d_t.rmacseq THEN
                  SELECT MAX(rmacseq1)+1
                    INTO g_rmab2_d[l_ac].rmacseq1
                    FROM rmac_t
                   WHERE rmacent = g_enterprise
                     AND rmacdocno = g_rmaa_m.rmaadocno
                     AND rmacseq = g_rmab2_d[l_ac].rmacseq
                  IF cl_null(g_rmab2_d[l_ac].rmacseq1) THEN
                    LET g_rmab2_d[l_ac].rmacseq1 = 1
                  END IF
                  CALL armt100_rmac_default_insert()
                  #料件未维护库存管理特征，则不用输入库存管理特征
                  LET l_num = 0
                  INITIALIZE l_imaf055 TO NULL
                  SELECT imaf055 INTO l_imaf055 FROM imaf_t WHERE imaf001 = g_rmab2_d[l_ac].l_rmab009 AND imafent = g_enterprise AND imafsite = g_site
                  IF l_imaf055 = '2' THEN
                     CALL cl_set_comp_entry("rmac005",FALSE)
                  END IF

               END IF
            ELSE
               LET g_rmab2_d[l_ac].rmacseq = g_rmab2_d_t.rmacseq
               NEXT FIELD CURRENT
            END IF
            
         BEFORE FIELD rmacseq
         
         ON CHANGE rmacseq
         
         AFTER FIELD rmacseq1
            #確認資料無重複
            IF cl_null(g_rmab2_d_t.rmacseq1) OR (NOT cl_null(g_rmab2_d_t.rmacseq1) AND g_rmab2_d[l_ac].rmacseq1 <> g_rmab2_d_t.rmacseq1) THEN
               SELECT COUNT(*)
                 INTO l_num
                 FROM rmac_t
                WHERE rmacent = g_enterprise
                  AND rmacdocno = g_rmaa_m.rmaadocno
                  AND rmacseq = g_rmab2_d[l_ac].rmacseq
                  AND rmacseq1 = g_rmab2_d[l_ac].rmacseq1
               IF l_num>0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "std-00004" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_rmab2_d[l_ac].rmacseq1 = g_rmab2_d_t.rmacseq1
                  DISPLAY g_rmab2_d[l_ac].rmacseq1 TO rmacseq1
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         BEFORE FIELD rmacseq1
         ON CHANGE rmacseq1         
         
         AFTER FIELD rmac001
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmab2_d[l_ac].rmac001,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rmac001
            END IF 
 
 
            #add-point:AFTER FIELD rmac001
            #點收數量合計不可大於對應項次的申請退貨數量
            LET l_num = 0
            SELECT SUM(COALESCE(rmac001,0)) INTO l_num
            FROM rmac_t
            WHERE rmacdocno = g_rmaa_m.rmaadocno
              AND rmacent = g_enterprise
              AND rmacsite = g_site
              AND rmacseq = g_rmab2_d[l_ac].rmacseq
              AND rmacseq1 <> g_rmab2_d[l_ac].rmacseq1
            IF cl_null(l_num) THEN
               LET l_num = 0
            END IF
            LET l_num = l_num + g_rmab2_d[l_ac].rmac001
            SELECT COALESCE(rmab012,0),COALESCE(rmab013,0) INTO l_rmab012,l_rmab013
              FROM rmab_t
             WHERE rmabdocno = g_rmaa_m.rmaadocno
              AND rmabent = g_enterprise
              AND rmabsite = g_site
              AND rmabseq = g_rmab2_d[l_ac].rmacseq
            IF l_num > l_rmab012 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "arm-00003" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rmab2_d[l_ac].rmac001 = g_rmab2_d_t.rmac001
               DISPLAY g_rmab2_d[l_ac].rmac001 TO rmac001
               NEXT FIELD CURRENT
            END IF
            #zhujing add-2016-4-11
            #若料件設置要做製造批序號管理時，新增時維護完數量時自動開啟批序號維護作業維護相關資料
            IF s_lot_batch_number_1n3(g_rmab2_d[g_detail_idx2].l_rmab009,g_site) AND ((g_rmab2_d[g_detail_idx2].rmac001<> g_rmab2_d_t.rmac001 OR g_rmab2_d_t.rmac001 IS NULL)  
               OR NOT armt100_inao_chk(g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmab2_d[g_detail_idx2].rmac001,'2')) THEN
               IF g_rmab2_d[g_detail_idx2].rmac001 = 0 THEN
                  #刪除实际資料                              
                  DELETE FROM inao_t 
                   WHERE inaoent = g_enterprise 
                     AND inaosite = g_site
                     AND inaodocno = g_rmaa_m.rmaadocno
                     AND inaoseq = g_rmab2_d[g_detail_idx2].rmacseq
                     AND inaoseq1 = g_rmab2_d[g_detail_idx2].rmacseq1
                     AND inao000 = '2'
                     AND inao013 = '1'
               END IF
               
               IF g_rmab2_d[g_detail_idx2].rmac001 > 0 THEN
                  IF NOT cl_null(g_rmab_d[g_detail_idx].rmab018) THEN
                     IF NOT armt100_ins_inao_2(g_rmab2_d[g_detail_idx2].rmacseq) THEN
                        NEXT FIELD CURRENT
                     END IF
                     CALL armt100_inao_fill2() 
                  ELSE
                     IF armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,'2') THEN
                        CALL s_lot_sel('2','2',g_site,g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmab2_d[g_detail_idx2].l_rmab009,g_rmab2_d[g_detail_idx2].l_rmab010,g_rmab2_d[g_detail_idx2].rmac005,
                                       g_rmab2_d[g_detail_idx2].rmac002,g_rmab2_d[g_detail_idx2].rmac003,g_rmab2_d[g_detail_idx2].rmac004,g_rmab2_d[g_detail_idx2].l_rmab011,g_rmab2_d[g_detail_idx2].rmac001,'1','armt100','','','','',0)
                           RETURNING l_success 
                        IF NOT l_success AND g_rmab2_d_t.rmac001 <> g_rmab2_d[g_detail_idx2].rmac001 THEN
                           LET g_rmab2_d[g_detail_idx2].rmac001 = g_rmab2_d_t.rmac001
                           DISPLAY g_rmab2_d[g_detail_idx2].rmac001 TO rmac001
                        END IF                           
   #                     IF l_success THEN #2016-5-13 zhujing marked
                           CALL armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,g_rmab2_d[g_detail_idx2].rmacseq1,g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,'3') RETURNING l_success
   #                     END IF
                     END IF
                  END IF
               END IF
               CALL armt100_inao_fill2() 
               #zhujing add-2016-4-11
            END IF
            LET g_rmab2_d_o.rmac001 = g_rmab2_d[g_detail_idx2].rmac001  #zhujing add-2016-5-17
            LET g_rmab2_d_t.rmac001 = g_rmab2_d[g_detail_idx2].rmac001  #zhujing add-2016-5-17
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rmac001
            #add-point:BEFORE FIELD rmac001

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rmac001
            #add-point:ON CHANGE rmac001

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rmac002
            
            #add-point:AFTER FIELD rmac002
            IF NOT cl_null(g_rmab2_d[l_ac].rmac002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmab2_d[l_ac].rmac002

                #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#21  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inaa001_20") THEN
                  #檢查成功時後續處理
                  IF g_rmab2_d[l_ac].rmac002 <> g_rmab2_d_t.rmac002 THEN
                     CALL s_desc_get_stock_desc(g_rmab2_d[l_ac].rmacsite,g_rmab2_d[l_ac].rmac002) RETURNING g_rmab2_d[l_ac].rmac002_desc
                     DISPLAY BY NAME g_rmab2_d[l_ac].rmac002_desc
#                     LET g_rmab2_d[l_ac].rmac003 = NULL       #2016-7-20 zhujing mod 无值给空格
                     LET g_rmab2_d[l_ac].rmac003 = ' '
                     LET g_rmab2_d[l_ac].rmac003_desc = NULL
                     #2016-4-6 zhujing add
                     IF s_lot_batch_number_1n3(g_rmab2_d[l_ac].l_rmab009,g_site) THEN 
                        IF g_rmab2_d[l_ac].rmac002 != g_rmab2_d_o.rmac002 OR g_rmab2_d_o.rmac002 IS NULL OR
                           g_rmab2_d[l_ac].rmac003 != g_rmab2_d_o.rmac003 OR g_rmab2_d_o.rmac003 IS NULL OR
                           g_rmab2_d[l_ac].rmac004 != g_rmab2_d_o.rmac004 OR g_rmab2_d_o.rmac004 IS NULL THEN  #變更倉庫
                           CALL s_lot_upd_inao(g_rmaa_m.rmaadocno,g_rmab_d[l_ac].rmabseq,g_rmab2_d[l_ac].rmacseq1,'2',g_rmab2_d[l_ac].rmac002,g_rmab2_d[l_ac].rmac003,g_rmab2_d[l_ac].rmac004,'',g_rmab2_d[l_ac].rmac005) 
                              RETURNING r_success 
                           IF NOT r_success THEN
                              NEXT FIELD CURRENT
                           END IF    
                        END IF 
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmab2_d[l_ac].rmac002 = g_rmab2_d_t.rmac002
                  LET g_rmab2_d[l_ac].rmac003 = g_rmab2_d_t.rmac003
                  DISPLAY BY NAME g_rmab2_d[l_ac].rmac002
                  DISPLAY BY NAME g_rmab2_d[l_ac].rmac003
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmab2_d[l_ac].rmac002
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmab2_d[l_ac].rmac002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmab2_d[l_ac].rmac002_desc
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rmac002
            #add-point:BEFORE FIELD rmac002
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rmac002
            #add-point:ON CHANGE rmac002

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rmac003
            
            #add-point:AFTER FIELD rmac003
            IF NOT cl_null(g_rmab2_d[l_ac].rmac003) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_rmab2_d[l_ac].rmac002
               LET g_chkparam.arg3 = g_rmab2_d[l_ac].rmac003
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inab002_1") THEN
                  #檢查成功時後續處理
                  #2016-4-6 zhujing add
                  IF s_lot_batch_number_1n3(g_rmab2_d[l_ac].l_rmab009,g_site) THEN 
                     IF g_rmab2_d[l_ac].rmac002 != g_rmab2_d_o.rmac002 OR g_rmab2_d_o.rmac002 IS NULL OR
                        g_rmab2_d[l_ac].rmac003 != g_rmab2_d_o.rmac003 OR g_rmab2_d_o.rmac003 IS NULL OR
                        g_rmab2_d[l_ac].rmac004 != g_rmab2_d_o.rmac004 OR g_rmab2_d_o.rmac004 IS NULL THEN  #變更倉庫
                        CALL s_lot_upd_inao(g_rmaa_m.rmaadocno,g_rmab_d[l_ac].rmabseq,g_rmab2_d[l_ac].rmacseq1,'2',g_rmab2_d[l_ac].rmac002,g_rmab2_d[l_ac].rmac003,g_rmab2_d[l_ac].rmac004,'',g_rmab2_d[l_ac].rmac005) 
                           RETURNING r_success 
                        IF NOT r_success THEN
                           NEXT FIELD CURRENT
                        END IF    
                     END IF 
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmab2_d[l_ac].rmac003 = g_rmab2_d_t.rmac003
                  DISPLAY BY NAME g_rmab2_d[l_ac].rmac003
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmab2_d[l_ac].rmacsite
            LET g_ref_fields[2] = g_rmab2_d[l_ac].rmac002
            LET g_ref_fields[3] = g_rmab2_d[l_ac].rmac003
            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite=? AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
            LET g_rmab2_d[l_ac].rmac003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmab2_d[l_ac].rmac003_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rmac003
            #add-point:BEFORE FIELD rmac003

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rmac003
            #add-point:ON CHANGE rmac003

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rmac004
            
            #add-point:AFTER FIELD rmac004
            IF NOT cl_null(g_rmab2_d[l_ac].rmac004) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site     #營運據點
               LET g_chkparam.arg2 = g_rmab2_d[l_ac].l_rmab009    #料號  
               LET g_chkparam.arg3 = g_rmab2_d[l_ac].l_rmab010  #產品特征
               LET g_chkparam.arg4 = g_rmab2_d[l_ac].rmac004   #批號
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inad001_1") THEN
                  #檢查成功時後續處理
                  #2016-4-6 zhujing add
                  IF s_lot_batch_number_1n3(g_rmab2_d[l_ac].l_rmab009,g_site) THEN 
                     IF g_rmab2_d[l_ac].rmac002 != g_rmab2_d_o.rmac002 OR g_rmab2_d_o.rmac002 IS NULL OR
                        g_rmab2_d[l_ac].rmac003 != g_rmab2_d_o.rmac003 OR g_rmab2_d_o.rmac003 IS NULL OR
                        g_rmab2_d[l_ac].rmac004 != g_rmab2_d_o.rmac004 OR g_rmab2_d_o.rmac004 IS NULL THEN  #變更倉庫
                        CALL s_lot_upd_inao(g_rmaa_m.rmaadocno,g_rmab_d[l_ac].rmabseq,g_rmab2_d[l_ac].rmacseq1,'2',g_rmab2_d[l_ac].rmac002,g_rmab2_d[l_ac].rmac003,g_rmab2_d[l_ac].rmac004,'',g_rmab2_d[l_ac].rmac005) 
                           RETURNING r_success 
                        IF NOT r_success THEN
                           NEXT FIELD CURRENT
                        END IF    
                     END IF 
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmab2_d[l_ac].rmac004 = g_rmab2_d_t.rmac004
                  DISPLAY BY NAME g_rmab2_d[l_ac].rmac004
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rmac004
            #add-point:BEFORE FIELD rmac004

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rmac004
            #add-point:ON CHANGE rmac004

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rmac005
            #add-point:BEFORE FIELD rmac005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rmac005
            
            #add-point:AFTER FIELD rmac005

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rmac005
            #add-point:ON CHANGE rmac005

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rmac006
            #add-point:BEFORE FIELD rmac006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rmac006
            
            #add-point:AFTER FIELD rmac006

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rmac006
            #add-point:ON CHANGE rmac006

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rmac007
            
            #add-point:AFTER FIELD rmac007
            IF NOT cl_null(g_rmab2_d[l_ac].rmac007) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmab2_d[l_ac].rmac007

                #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#21  by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmab2_d[l_ac].rmac007 = g_rmab2_d_t.rmac007
                  DISPLAY BY NAME g_rmab2_d[l_ac].rmac007
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmab2_d[l_ac].rmac007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_rmab2_d[l_ac].rmac007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmab2_d[l_ac].rmac007_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rmac007
            #add-point:BEFORE FIELD rmac007

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rmac007
            #add-point:ON CHANGE rmac007

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rmacsite
            #add-point:BEFORE FIELD rmacsite

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rmacsite
            
            #add-point:AFTER FIELD rmacsite

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rmacsite
            #add-point:ON CHANGE rmacsite

            #END add-point 
 
 
                  #Ctrlp:input.c.page2.rmac001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rmac001
            #add-point:ON ACTION controlp INFIELD rmac001

            #END add-point
 
         #Ctrlp:input.c.page2.rmac002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rmac002
            #add-point:ON ACTION controlp INFIELD rmac002
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmab2_d[l_ac].rmac002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_inaa001_17()                                #呼叫開窗

            LET g_rmab2_d[l_ac].rmac002 = g_qryparam.return1              

            DISPLAY g_rmab2_d[l_ac].rmac002 TO rmac002              #

            NEXT FIELD rmac002                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page2.rmac003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rmac003
            #add-point:ON ACTION controlp INFIELD rmac003
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmab2_d[l_ac].rmac003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s
            LET g_qryparam.arg3 = "" #s
            LET g_qryparam.arg4 = "" #s

            LET g_qryparam.where = " inab001 = '",g_rmab2_d[l_ac].rmac002,"' "
            CALL q_inab002()

            LET g_rmab2_d[l_ac].rmac003 = g_qryparam.return1              

            DISPLAY g_rmab2_d[l_ac].rmac003 TO rmac003              #

            NEXT FIELD rmac003                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page2.rmac004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rmac004
            #add-point:ON ACTION controlp INFIELD rmac004
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmab2_d[l_ac].rmac004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s
            LET g_qryparam.arg3 = "" #s
            LET g_qryparam.arg4 = "" #s
            LET g_qryparam.arg5 = "" #s
            LET g_qryparam.arg6 = "" #s

            CALL q_inad003()                                #呼叫開窗

            LET g_rmab2_d[l_ac].rmac004 = g_qryparam.return1              

            DISPLAY g_rmab2_d[l_ac].rmac004 TO rmac004              #

            NEXT FIELD rmac004                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page2.rmac005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rmac005
            #add-point:ON ACTION controlp INFIELD rmac005

            #END add-point
 
         #Ctrlp:input.c.page2.rmac006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rmac006
            #add-point:ON ACTION controlp INFIELD rmac006

            #END add-point
 
         #Ctrlp:input.c.page2.rmac007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rmac007
            #add-point:ON ACTION controlp INFIELD rmac007
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmab2_d[l_ac].rmac007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_rmab2_d[l_ac].rmac007 = g_qryparam.return1              

            DISPLAY g_rmab2_d[l_ac].rmac007 TO rmac007              #

            NEXT FIELD rmac007                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page2.rmacsite
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rmacsite
            #add-point:ON ACTION controlp INFIELD rmacsite

            #END add-point
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_rmab2_d[l_ac].* = g_rmab2_d_t.*
               CLOSE armt100_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            UPDATE rmac_t SET (rmacsite,rmacseq,rmacseq1,rmac001,rmac002,rmac003,rmac004,rmac005, 
                   rmac006,rmac007) = (g_rmab2_d[l_ac].rmacsite,g_rmab2_d[l_ac].rmacseq,g_rmab2_d[l_ac].rmacseq1,g_rmab2_d[l_ac].rmac001,g_rmab2_d[l_ac].rmac002,g_rmab2_d[l_ac].rmac003,g_rmab2_d[l_ac].rmac004, 
                   g_rmab2_d[l_ac].rmac005,g_today,g_user)  
                   #自訂欄位頁簽
            WHERE rmacent = g_enterprise AND rmacdocno = g_rmaa_m.rmaadocno
                  AND rmacseq = g_rmab2_d_t.rmacseq #項次 
                  AND rmacseq1 = g_rmab2_d_t.rmacseq1
            IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "rmac_t" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()                   
                CALL s_transaction_end('N','0')
                LET g_rmab2_d[l_ac].* = g_rmab2_d_t.*  
             END IF
             #2016-5-16 zhujing add(S) 回写至inao_t
             UPDATE inao_t SET (inaosite,inaoseq,inaoseq1,inao003,inao005,inao006,inao007)
                   = (g_rmab2_d[l_ac].rmacsite,g_rmab2_d[l_ac].rmacseq,g_rmab2_d[l_ac].rmacseq1,g_rmab2_d[l_ac].rmac005,g_rmab2_d[l_ac].rmac002,g_rmab2_d[l_ac].rmac003,g_rmab2_d[l_ac].rmac004)  
                   #自訂欄位頁簽
             WHERE inaoent = g_enterprise AND inaodocno = g_rmaa_m.rmaadocno
                  AND inaoseq = g_rmab2_d_t.rmacseq #項次 
                  AND inaoseq1 = g_rmab2_d_t.rmacseq1
                  AND inao000 = '2'
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "inao_t" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()                   
                CALL s_transaction_end('N','0')
                LET g_rmab2_d[l_ac].* = g_rmab2_d_t.*  
             END IF
             #2016-5-16 zhujing add(E)
             
             #回写至rmab_t
             IF NOT cl_null(g_rmab2_d[l_ac].rmac001) AND g_rmab2_d[l_ac].rmac001<>g_rmab2_d_t.rmac001 THEN
                SELECT SUM(rmac001) INTO l_num
                  FROM rmac_t
                 WHERE rmacdocno = g_rmaa_m.rmaadocno
                   AND rmacseq = g_rmab2_d[l_ac].rmacseq #項次
                   AND rmacseq1 <> g_rmab2_d[l_ac].rmacseq1 #項次
                   AND rmacent = g_enterprise 
                   AND rmacsite = g_site
                IF cl_null(l_num) THEN LET l_num = 0 END IF
                UPDATE rmab_t SET (rmab013) = (g_rmab2_d[l_ac].rmac001+l_num)  
#                UPDATE rmab_t SET (rmab013) = (l_num)  
                WHERE rmabent = g_enterprise AND rmabdocno = g_rmaa_m.rmaadocno
                AND rmabseq = g_rmab2_d_t.rmacseq #項次 
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "rmab_t" 
                   LET g_errparam.code   = SQLCA.sqlcode 
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()                   
                   CALL s_transaction_end('N','0')
                   LET g_rmab2_d[l_ac].* = g_rmab2_d_t.*  
                END IF
             END IF
             
         AFTER ROW
            CLOSE armt100_bcl2
            #其他table進行unlock
            CALL armt100_unlock_b("rmab_t","'1'")
            CALL armt100_unlock_b("rmac_t","'2'")
            CALL s_transaction_end('Y','0')
         
      END INPUT
      ON ACTION accept    
         ACCEPT DIALOG
         
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
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
   CALL cl_set_comp_entry("rmacseq,rmacseq1,rmac001,rmac002,rmac003,rmac004,rmac005,rmac006,rmac007",FALSE)
   CALL armt100_set_act_visible()   
   CALL armt100_set_act_no_visible()
   
   CLOSE armt100_cl
   LET INT_FLAG = FALSE
   CALL armt100_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 点收档自动带值
# Memo...........:
# Usage..........: CALL armt100_rmac_default_insert()
#                  RETURNING 回传参数
################################################################################
PRIVATE FUNCTION armt100_rmac_default_insert()
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_sql_rmab    STRING
   DEFINE l_rmab013     LIKE rmab_t.rmab013  #已点收数量
   DEFINE l_rmab012     LIKE rmab_t.rmab013  #申请数量
   
   SELECT rmab009,rmab010,rmab011,rmab012 INTO g_rmab2_d[l_ac].l_rmab009,g_rmab2_d[l_ac].l_rmab010,g_rmab2_d[l_ac].l_rmab011,l_rmab012
     FROM rmab_t
    WHERE rmabdocno = g_rmaa_m.rmaadocno
      AND rmabent = g_enterprise
      AND rmabsite = g_site
      AND rmabseq = g_rmab2_d[l_ac].rmacseq
   #获取料件品名规格
   CALL s_desc_get_item_desc(g_rmab2_d[l_ac].l_rmab009)
      RETURNING g_rmab2_d[l_ac].l_rmab009_desc,g_rmab2_d[l_ac].l_rmab009_desc_1
   #获取产品特征说明
   CALL s_feature_description(g_rmab2_d[l_ac].l_rmab009,g_rmab2_d[l_ac].l_rmab010) 
      RETURNING l_success,g_rmab2_d[l_ac].l_rmab010_desc
   #获取单位说明   
   CALL s_desc_get_unit_desc(g_rmab2_d[l_ac].l_rmab011) RETURNING g_rmab2_d[l_ac].l_rmab011_desc
   #自动带出点收数量:申请数量-已点收数量
   SELECT SUM(COALESCE(rmac001,0)) INTO l_rmab013
     FROM rmac_t
    WHERE rmacdocno = g_rmaa_m.rmaadocno
      AND rmacent = g_enterprise
      AND rmacsite = g_site
      AND rmacseq = g_rmab2_d[l_ac].rmacseq
   IF cl_null(l_rmab013) THEN
      LET l_rmab013 = 0
   END IF
   IF l_rmab012 > l_rmab013 THEN
      LET g_rmab2_d[l_ac].rmac001 = l_rmab012 - l_rmab013
   ELSE
      LET g_rmab2_d[l_ac].rmac001 = 0
   END IF
   LET g_rmab2_d[l_ac].rmac006 = g_today
   LET g_rmab2_d[l_ac].rmac007 = g_user
   CALL s_desc_get_person_desc(g_rmab2_d[g_detail_idx2].rmac007) RETURNING g_rmab2_d[l_ac].rmac007_desc
   #2016-5-26 zhujing add-S 库储批预设空格
   LET g_rmab2_d[l_ac].rmac002 = ' '
   LET g_rmab2_d[l_ac].rmac003 = ' '
   LET g_rmab2_d[l_ac].rmac004 = ' '
   LET g_rmab2_d[l_ac].rmac005 = ' '
   #2016-5-26 zhujing add-E
   DISPLAY BY NAME g_rmab2_d[l_ac].rmacseq1
   DISPLAY BY NAME g_rmab2_d[l_ac].rmac001
   DISPLAY BY NAME g_rmab2_d[l_ac].l_rmab009
   DISPLAY BY NAME g_rmab2_d[l_ac].l_rmab009_desc
   DISPLAY BY NAME g_rmab2_d[l_ac].l_rmab009_desc_1
   DISPLAY BY NAME g_rmab2_d[l_ac].l_rmab010
   DISPLAY BY NAME g_rmab2_d[l_ac].l_rmab010_desc
   DISPLAY BY NAME g_rmab2_d[l_ac].rmac006 
   DISPLAY BY NAME g_rmab2_d[l_ac].rmac007
   DISPLAY BY NAME g_rmab2_d[l_ac].rmac007_desc    
END FUNCTION

################################################################################
# Descriptions...: 根據客訴單帶出單身信息
# Memo...........:
# Usage..........: CALL armt100_rmaa004_default(p_rmaa004)
# Date & Author..: 2015-9-15 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_rmaa004_default(p_rmaa004)
DEFINE p_rmaa004  LIKE rmaa_t.rmaa004
DEFINE l_rmab012  LIKE rmab_t.rmab012
DEFINE r_success  LIKE type_t.num5
DEFINE l_success  LIKE type_t.num5

   IF NOT cl_null(g_rmaa_m.rmaa004) THEN
      LET g_rmab_d[l_ac].rmabseq = 1
      LET g_rmab_d[l_ac].rmab001 = p_rmaa004
      LET g_rmab_d[l_ac].rmab012 = "0"
      LET g_rmab_d[l_ac].rmab013 = "0"
      LET g_rmab_d[l_ac].rmab014 = "0"
      LET g_rmab_d[l_ac].rmab015 = "0"
      LET g_rmab_d[l_ac].rmab016 = "0"
      LET g_rmab_d[l_ac].rmabsite = g_site
   END IF
   #根據客訴單號，帶出出貨單號，項次，訂單單號，項次，項序，分批序，料號，產品特征，數量，單位
   SELECT xmfo006,xmfo007,xmfo008,xmfo009,xmfo010,xmfo011,xmfo012,xmfo013,xmfo014,xmfo015
     INTO g_rmab_d[l_ac].rmab003,g_rmab_d[l_ac].rmab004,g_rmab_d[l_ac].rmab005,g_rmab_d[l_ac].rmab006,g_rmab_d[l_ac].rmab007,
          g_rmab_d[l_ac].rmab008,g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010,g_rmab_d[l_ac].rmab012,g_rmab_d[l_ac].rmab011
     FROM xmfo_t
    WHERE xmfodocno = p_rmaa004
      AND xmfoent = g_enterprise
      AND xmfosite = g_site
      AND xmfostus = 'Y'
      AND xmfo016 = '1'
      
   #检查是否有其他非作废退货量，若有，减去
   SELECT SUM(rmab012) INTO l_rmab012 
     FROM rmab_t 
          LEFT OUTER JOIN rmaa_t ON rmabdocno = rmaadocno AND rmabsite = rmaasite AND rmabent = rmaaent
    WHERE rmab001 = g_rmab_d[l_ac].rmab001 
      AND rmabent = g_enterprise AND rmabsite = g_site AND rmaastus <> 'X' AND rmab001 = p_rmaa004
      AND ((rmabseq<>g_rmab_d[l_ac].rmabseq) 
      OR ( rmabdocno <> g_rmaa_m.rmaadocno)) 
            
   IF cl_null(l_rmab012) THEN LET l_rmab012 = 0 END IF
   IF l_rmab012 > g_rmab_d[l_ac].rmab012 AND g_rmab_d[l_ac].rmab012 <> 0 THEN
      #报错已无可退退品
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "arm-00015"   #申请退品数量大于可退数量
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      LET g_rmab_d[l_ac].rmab012 = g_rmab_d_t.rmab012
      DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
         
   ELSE
      LET g_rmab_d[l_ac].rmab012 = g_rmab_d[l_ac].rmab012 - l_rmab012
      DISPLAY g_rmab_d[l_ac].rmab012 TO rmab012
   END IF
      
   #获取料件品名规格
   CALL s_desc_get_item_desc(g_rmab_d[l_ac].rmab009)
      RETURNING g_rmab_d[l_ac].rmab009_desc,g_rmab_d[l_ac].rmab009_desc_1
   #获取产品特征说明
   CALL s_feature_description(g_rmab_d[l_ac].rmab009,g_rmab_d[l_ac].rmab010) 
      RETURNING l_success,g_rmab_d[l_ac].rmab010_desc
   #获取单位说明   
   CALL s_desc_get_unit_desc(g_rmab_d[l_ac].rmab011) RETURNING g_rmab_d[l_ac].rmab011_desc
   
END FUNCTION

################################################################################
# Descriptions...: 檢查客訴項次是否存在
# Memo...........:
# Usage..........: CALL armt100_rmab002_chk(p_rmab001,p_rmab002)
#                  RETURNING r_success
# Date & Author..: 2015-9-15 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_rmab002_chk(p_rmab001,p_rmab002)
   DEFINE p_rmab001     LIKE rmab_t.rmab001
   DEFINE p_rmab002     LIKE rmab_t.rmab002
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   LET r_success = TRUE
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM xmfo_t LEFT OUTER JOIN xmfp_t ON xmfpdocno = xmfodocno AND xmfpent = xmfoent
     WHERE xmfodocno = p_rmab001
       AND xmfpseq = p_rmab002
       AND xmfoent = g_enterprise
       AND xmfosite = g_site
   IF l_cnt = 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
#获取单身行数
################################################################################
PRIVATE FUNCTION armt100_detail_count()
   DEFINE r_numseq     LIKE type_t.num5
   
   LET r_numseq = 0
   
   IF NOT cl_null(g_rmaa_m.rmaadocno) THEN         
      SELECT COUNT(rmabseq)
        INTO r_numseq
        FROM rmaa_t
       WHERE rmaaent = g_enterprise
         AND rmaadocno = g_rmaa_m.rmaadocno
   END IF
   
   RETURN r_numseq
END FUNCTION

################################################################################
# Descriptions...: 设定序号栏位必输
# Memo...........: 160202-00019#1
# Usage..........: CALL armt100_set_required()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016-2-18 zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_set_required()
DEFINE l_para     LIKE type_t.chr80
DEFINE l_flag1    LIKE type_t.num5
DEFINE l_ooac002  LIKE ooac_t.ooac002
   #序号依据参数E-MFG-0009判断是否必输
   IF NOT cl_null(g_rmaa_m.rmaadocno) THEN
      CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_flag1,l_ooac002
      CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0009') RETURNING l_para    
      IF l_para = 'Y' THEN
         CALL cl_set_comp_required("rmab018",TRUE)
      END IF
      #160816-00066#1 add-S E-MFG-0040=Y时，控制出货单号、项次必输
      IF cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0040') = 'Y' THEN
         CALL cl_set_comp_required("rmaa005,rmab003,rmab004",TRUE)
      END IF
      #160816-00066#1 add-E 
      
   END IF
    
END FUNCTION

################################################################################
# Descriptions...: 设定序号栏位不必输
# Memo...........: 160202-00019#1
# Usage..........: CALL armt100_set_no_required()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016-2-18 zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_set_no_required()
   
   CALL cl_set_comp_required("rmab018",FALSE)
   CALL cl_set_comp_required("rmaa005,rmab003,rmab004",FALSE)     #160816-00066#1 add
END FUNCTION

################################################################################
# Descriptions...: 根据序号自动带出对应数据
# Memo...........: 160202-00019#1
# Date & Author..: 2016-2-18 zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_rmab018_default(p_rmab018)
DEFINE p_rmab018  LIKE rmab_t.rmab018
DEFINE l_rmab001  LIKE rmab_t.rmab001  #客诉单
DEFINE l_rmab003  LIKE rmab_t.rmab003  #出货单
DEFINE l_rmab004  LIKE rmab_t.rmab004  #项次
DEFINE l_rmab019  LIKE rmab_t.rmab019  #生产日期
DEFINE l_rmab020  LIKE rmab_t.rmab020  #有效日期
DEFINE r_success  LIKE type_t.num5
DEFINE l_start    LIKE type_t.num5
DEFINE l_length   LIKE type_t.num5
DEFINE l_xmdk007  LIKE xmdk_t.xmdk007  #客户编号
DEFINE l_xmdkstus LIKE xmdk_t.xmdkstus #状态

#若有多笔则不带出，若带出值与单头不一致，则提示修改单头或单身
   LET r_success = TRUE
   IF NOT cl_null(p_rmab018) THEN
      LET l_rmab001 = NULL
      LET l_rmab003 = NULL
      LET l_rmab004 = NULL
      LET l_rmab019 = NULL
      LET l_rmab020 = NULL
   ELSE
      LET r_success = FALSE
      RETURN r_success
   END IF
   CALL armt100_get_slip_locate() RETURNING l_start,l_length
   #依输入序号带出以下值（带出的值不可修改）：料号、客诉单、出货单号、项次、订单号、订单项次项序、生产日期、有效日期
   #rmab009,rmab001,rmab003,rmab004,rmab005,rmab006,rmab007,rmab019,rmab020
   SELECT inaodocno,inaoseq,inao010,inao011 
     INTO l_rmab003,l_rmab004,l_rmab019,l_rmab020
     FROM inao_t
    WHERE inaoent = g_enterprise
      AND inaosite = g_site
      AND inao009 = p_rmab018
      AND substr(inaodocno,l_start,l_length) IN 
      (SELECT oobx001 FROM oobx_t WHERE oobxent = g_enterprise AND oobx003 = 'axmt540')
      
   #检查客户编号是否一致：
   SELECT xmdk007,xmdkstus INTO l_xmdk007,l_xmdkstus
     FROM xmdk_t
    WHERE xmdkdocno = l_rmab003
      AND xmdksite = g_site
      AND xmdkent = g_enterprise
   IF cl_null(l_xmdk007) OR l_xmdk007 <> g_rmaa_m.rmaa001 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "arm-00050"   #该序号对应的出货单客户编号与单头客户编号不一致！
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   IF l_xmdkstus <> 'S' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "arm-00051"   #该序号对应的出货单未过账！
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
      
#   SELECT inae005,inae006,inae010,inae011 
#     INTO l_rmab003,l_rmab004,l_rmab019,l_rmab020
#     FROM inae_t
#    WHERE inaeent = g_enterprise
#      AND inaesite = g_site
#      AND inae003 = p_rmab018
#      AND substr(inae005,l_start,l_length) IN 
#      (SELECT oobx001 FROM oobx_t WHERE oobxent = g_enterprise AND oobx003 = 'axmt540')
   IF NOT cl_null(l_rmab003) THEN
      IF NOT cl_null(g_rmaa_m.rmaa005) AND l_rmab003 <> g_rmaa_m.rmaa005 THEN
         #报错此序号对应的出货单与单头出货单不同，调整单头出货单或者单身序号。
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "arm-00044"   #该序号对应的出货单号与单头出货单号不一致！
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF NOT armt100_rmab_default_insert(l_rmab003,l_rmab004) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET g_rmab_d[l_ac].rmab019 = l_rmab019
         LET g_rmab_d[l_ac].rmab020 = l_rmab020
      END IF
   END IF
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 获取单别截取位置
# Memo...........: 160202-00019#1
# Date & Author..: 2016-2-19 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_get_slip_locate()
DEFINE l_para        LIKE type_t.num5
DEFINE r_start       LIKE type_t.num5
DEFINE r_length      LIKE type_t.num5
   
   LET l_para = 0
   LET r_start = 0
   LET r_length = 0
   LET r_length = cl_get_para(g_enterprise,'','E-COM-0001')
   IF cl_get_para(g_enterprise,'','E-COM-0008') = '1' THEN    #据点+单别
      IF cl_get_para(g_enterprise,'','E-COM-0002') = 'Y' THEN
         LET r_start = cl_get_para(g_enterprise,'','E-COM-0003') + 2
      ELSE
         LET r_start = cl_get_para(g_enterprise,'','E-COM-0003') + 1
      END IF
   ELSE
      LET r_start = 1
   END IF

RETURN r_start,r_length
END FUNCTION

################################################################################
# Descriptions...: 有序号的资料新增到制造批序号申请档
# Memo...........: 
# Usage..........: CALL armt100_ins_inao_1()
#                  RETURNING r_success
# Date & Author..: 2016-3-31 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_ins_inao_1()
DEFINE  l_sql       STRING
DEFINE  r_success   LIKE type_t.num5
DEFINE  l_inao001   LIKE inao_t.inao001
DEFINE  l_inao002   LIKE inao_t.inao002
DEFINE  l_inao008   LIKE inao_t.inao008
DEFINE  l_inao009   LIKE inao_t.inao009
DEFINE  l_inao010   LIKE inao_t.inao010
DEFINE  l_inao011   LIKE inao_t.inao011
DEFINE  l_inao012   LIKE inao_t.inao012

   LET r_success = TRUE
   #有序号资料，根据序号抓取制造批号
   IF cl_null(g_rmab_d[g_detail_idx].rmab018) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_inao001 = NULL
   LET l_inao002 = NULL
   LET l_inao008 = NULL
   LET l_inao009 = NULL
   LET l_inao010 = NULL
   LET l_inao011 = NULL
   LET l_inao012 = NULL
     
   SELECT DISTINCT inao001,inao002,inao008,inao009,inao010,inao011,inao012
     INTO l_inao001,l_inao002,l_inao008,l_inao009,l_inao010,l_inao011,l_inao012
     FROM inao_t
    WHERE inaosite = g_site
      AND inao009 = g_rmab_d[g_detail_idx].rmab018
      AND inaodocno = g_rmab_d[g_detail_idx].rmab003     #2016-7-13 zhujing add
      AND inaoent = g_enterprise    #160905-00007#14  add          
      
   #先刪除申请資料
   DELETE FROM inao_t 
    WHERE inaodocno = g_rmaa_m.rmaadocno
      AND inaosite = g_site
      AND inaoseq = g_rmab_d[g_detail_idx].rmabseq
      AND inao000 = '1'
      AND inaoent = g_enterprise    #160905-00007#14  add          
      
   IF NOT armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'0') THEN
      LET r_success = FALSE               
   END IF        
   INSERT INTO inao_t (inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,inao006,
                       inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014,inao025)
               VALUES (g_enterprise,g_site,g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1','1','1',
                       l_inao001,l_inao002,'','','','','',l_inao008,
                       l_inao009,l_inao010,l_inao011,l_inao012,'1',g_rmab_d[g_detail_idx].rmab011,0)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "inao_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET r_success = FALSE               
   END IF  
   IF NOT armt100_update_inao(g_rmaa_m.rmaadocno,g_rmab_d[g_detail_idx].rmabseq,'1',g_rmab_d[g_detail_idx].rmab003,g_rmab_d[g_detail_idx].rmab004,'1') THEN
      LET r_success = FALSE               
   END IF
 
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 产生申请资料的同时产生实际资料
# Date & Author..: 2016-4-11 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_ins_inao_2(l_seq)
DEFINE  l_sql       STRING
DEFINE  l_seq       LIKE rmab_t.rmabseq
#161124-00048#11 mod-S
#DEFINE  l_inao      RECORD LIKE inao_t.*
DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
       inaoent LIKE inao_t.inaoent, #企业编号
       inaosite LIKE inao_t.inaosite, #营运据点
       inaodocno LIKE inao_t.inaodocno, #单号
       inaoseq LIKE inao_t.inaoseq, #项次
       inaoseq1 LIKE inao_t.inaoseq1, #项序
       inaoseq2 LIKE inao_t.inaoseq2, #序号
       inao000 LIKE inao_t.inao000, #数据类型
       inao001 LIKE inao_t.inao001, #料件编号
       inao002 LIKE inao_t.inao002, #产品特征
       inao003 LIKE inao_t.inao003, #库存管理特征
       inao004 LIKE inao_t.inao004, #包装容器编号
       inao005 LIKE inao_t.inao005, #库位
       inao006 LIKE inao_t.inao006, #储位
       inao007 LIKE inao_t.inao007, #批号
       inao008 LIKE inao_t.inao008, #制造批号
       inao009 LIKE inao_t.inao009, #制造序号
       inao010 LIKE inao_t.inao010, #制造日期
       inao011 LIKE inao_t.inao011, #有效日期
       inao012 LIKE inao_t.inao012, #数量
       inao013 LIKE inao_t.inao013, #出入库码
       inao014 LIKE inao_t.inao014, #库存单位
       inao020 LIKE inao_t.inao020, #检验合格量
       inao021 LIKE inao_t.inao021, #已入库/出货/签收量
       inao022 LIKE inao_t.inao022, #已验退/签退量
       inao023 LIKE inao_t.inao023, #已仓退/销退量
       inao024 LIKE inao_t.inao024, #已转QC量
       inao025 LIKE inao_t.inao025  #已退品量
END RECORD
#161124-00048#11 mod-E
DEFINE  r_success   LIKE type_t.num5

   #先刪除實際資料
   DELETE FROM inao_t 
    WHERE inaodocno = g_rmaa_m.rmaadocno
      AND inaosite = g_site
      AND inaoseq = l_seq  #g_rmab2_d[g_detail_idx2].rmacseq
      AND inao000 = '2'
      AND inaoent = g_enterprise    #160905-00007#14  add          
            
   #161124-00048#11 mod-S
#   LET l_sql = "SELECT * FROM inao_t ",
   LET l_sql = "SELECT inaoent,inaosite,inaodocno,inaoseq,inaoseq1,",
               "       inaoseq2,inao000,inao001,inao002,inao003,",
               "       inao004,inao005,inao006,inao007,inao008,",
               "       inao009,inao010,inao011,inao012,inao013,",
               "       inao014,inao020,inao021,inao022,inao023,",
               "       inao024,inao025 ",
               "FROM inao_t ",
   #161124-00048#11 mod-E
               " WHERE inaodocno = '",g_rmaa_m.rmaadocno,"'",
               "   AND inaoseq = ",l_seq, #,g_rmab2_d[g_detail_idx2].rmacseq,
               "   AND inao000 = '1' ",
               "   AND inaoent = ",g_enterprise    #170120-00054#1 add
               
   PREPARE armt100_inao_pre FROM l_sql
   DECLARE armt100_inao_ins CURSOR FOR armt100_inao_pre  
   
   LET r_success = TRUE
   
   FOREACH armt100_inao_ins INTO l_inao.*
   
      UPDATE inao_t SET inao025 = l_inao.inao012
       WHERE inaoent = g_enterprise
         AND inaodocno = g_rmaa_m.rmaadocno
         AND inaoseq = l_inao.inaoseq
         AND inaoseq1 = l_inao.inaoseq1
         AND inaoseq2 = l_inao.inaoseq2
         AND inao000 = '1'
         AND inao013 = l_inao.inao013
         
      LET l_inao.inao000 = '2'
      LET l_inao.inaoseq1 = 1
      
      INSERT INTO inao_t (inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,inao006,
                          inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014,inao020,inao021,inao022,inao023,inao024)
                  VALUES (g_enterprise,g_site,g_rmaa_m.rmaadocno,l_seq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,
#                  VALUES (g_enterprise,g_site,g_rmaa_m.rmaadocno,g_rmab2_d[g_detail_idx2].rmacseq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,
                          l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
                          l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,l_inao.inao014,l_inao.inao020,l_inao.inao021,
                          l_inao.inao022,l_inao.inao023,l_inao.inao024)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         LET r_success = FALSE               
      END IF   

   END FOREACH
 
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 点收实际单身
# Date & Author..: 2016-4-11 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_inao_fill2()
DEFINE l_ac1       LIKE type_t.num5

   CALL g_inao_d2.clear()
   
   
   LET g_sql = "SELECT  UNIQUE inaoseq,inaoseq1,inaoseq2,inao001,'','',inao008,inao009,inao010,inao012 ",
               "  FROM inao_t ",
               " INNER JOIN rmab_t ON rmabdocno = inaodocno AND rmabent = inaoent AND rmabsite = inaosite ",

               " WHERE inaoent=? AND inaosite=? AND inaodocno=? AND inao000 = '2'"
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND inaoseq IN ( SELECT rmabseq FROM rmab_t WHERE rmabent='",g_enterprise,"' AND rmabsite='",g_site,"' AND rmabdocno='",g_rmaa_m.rmaadocno,"' AND ", g_wc2_table1 CLIPPED, " ) "
   END IF

   LET g_sql = g_sql, " ORDER BY inaoseq,inaoseq1,inaoseq2"

   
   PREPARE armt100_inao_pb2 FROM g_sql
   DECLARE inao_b_fill_cs2 CURSOR FOR armt100_inao_pb2
 
   LET g_cnt = l_ac1
   LET l_ac1 = 1
 
   OPEN inao_b_fill_cs2 USING g_enterprise, g_site,g_rmaa_m.rmaadocno

                                            
   FOREACH inao_b_fill_cs2 INTO g_inao_d2[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      #add-point:b_fill段資料填充
      CALL s_desc_get_item_desc(g_inao_d2[l_ac1].inao001_1)
         RETURNING g_inao_d2[l_ac1].inao001_1_desc,g_inao_d2[l_ac1].inao001_1_desc2
      DISPLAY BY NAME g_inao_d2[l_ac1].inao001_1_desc,g_inao_d2[l_ac1].inao001_1_desc2
      
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   

   
   CALL g_inao_d2.deleteElement(g_inao_d2.getLength())

   
   LET g_rec_b3 = g_inao_d2.getLength()
   LET l_ac1 = g_cnt
   LET g_cnt = 0  
   
   FREE armt100_inao_pb2
END FUNCTION

################################################################################
# Descriptions...: 回写制造批序号已退品量
# Memo...........: CALL armt100_update_inao(p_docno,p_seq,p_seq1,p_from_docno,p_from_seq,p_type)
#                  RETURNING r_success
# Input parameter: p_docno   單號
#                : p_seq     項次
#                : p_seq1    項序
#                : p_from_docno 來源單號
#                : p_from_seq   來源項次
#                : p_type       加減項 
#                               0,1 出货单加减
#                               2,3 RMA单加减
# Date & Author..: 2016-4-12 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_update_inao(p_docno,p_seq,p_seq1,p_from_docno,p_from_seq,p_type)
DEFINE p_docno  LIKE xmdk_t.xmdkdocno,
       p_seq    LIKE xmdm_t.xmdmseq,
       p_seq1   LIKE xmdm_t.xmdmseq1,
       p_from_docno LIKE xmdl_t.xmdl001,
       p_from_seq   LIKE xmdl_t.xmdl002,
       p_type       LIKE type_t.chr1,
       r_success LIKE type_t.num5
#161124-00048#11 mod-S
#DEFINE  l_inao      RECORD LIKE inao_t.*
DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
       inaoent LIKE inao_t.inaoent, #企业编号
       inaosite LIKE inao_t.inaosite, #营运据点
       inaodocno LIKE inao_t.inaodocno, #单号
       inaoseq LIKE inao_t.inaoseq, #项次
       inaoseq1 LIKE inao_t.inaoseq1, #项序
       inaoseq2 LIKE inao_t.inaoseq2, #序号
       inao000 LIKE inao_t.inao000, #数据类型
       inao001 LIKE inao_t.inao001, #料件编号
       inao002 LIKE inao_t.inao002, #产品特征
       inao003 LIKE inao_t.inao003, #库存管理特征
       inao004 LIKE inao_t.inao004, #包装容器编号
       inao005 LIKE inao_t.inao005, #库位
       inao006 LIKE inao_t.inao006, #储位
       inao007 LIKE inao_t.inao007, #批号
       inao008 LIKE inao_t.inao008, #制造批号
       inao009 LIKE inao_t.inao009, #制造序号
       inao010 LIKE inao_t.inao010, #制造日期
       inao011 LIKE inao_t.inao011, #有效日期
       inao012 LIKE inao_t.inao012, #数量
       inao013 LIKE inao_t.inao013, #出入库码
       inao014 LIKE inao_t.inao014, #库存单位
       inao020 LIKE inao_t.inao020, #检验合格量
       inao021 LIKE inao_t.inao021, #已入库/出货/签收量
       inao022 LIKE inao_t.inao022, #已验退/签退量
       inao023 LIKE inao_t.inao023, #已仓退/销退量
       inao024 LIKE inao_t.inao024, #已转QC量
       inao025 LIKE inao_t.inao025  #已退品量
END RECORD
#161124-00048#11 mod-E     
DEFINE l_sql    STRING
DEFINE l_xmdl001 LIKE xmdl_t.xmdl001
DEFINE l_xmdl002 LIKE xmdl_t.xmdl002
DEFINE l_inaoseq1 LIKE inao_t.inaoseq1
DEFINE l_inaoseq2 LIKE inao_t.inaoseq2
DEFINE l_inao008  LIKE inao_t.inao008
DEFINE l_inao009  LIKE inao_t.inao009

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
     
   #抓取当前单据制造批序号资料
   #161124-00048#11 mod-S
#   LET l_sql = "SELECT * FROM inao_t ",
   LET l_sql = "SELECT inaoent,inaosite,inaodocno,inaoseq,inaoseq1,",
               "       inaoseq2,inao000,inao001,inao002,inao003,",
               "       inao004,inao005,inao006,inao007,inao008,",
               "       inao009,inao010,inao011,inao012,inao013,",
               "       inao014,inao020,inao021,inao022,inao023,",
               "       inao024,inao025 ",
               "FROM inao_t ",
   #161124-00048#11 mod-E
               "  WHERE inaoent = '",g_enterprise,"'",
               "    AND inaosite = '",g_site,"'",
               "    AND inaodocno = '",p_docno,"'",
               "    AND inao000 = '1' "
   IF NOT cl_null(p_seq) THEN                
      LET l_sql = l_sql,"    AND inaoseq = ",p_seq
   END IF
#   IF NOT cl_null(p_seq1) THEN                
#      LET l_sql = l_sql,"    AND inaoseq1 = ",p_seq1
#   END IF   
   PREPARE armt100_inao_upd_pre FROM l_sql
   DECLARE armt100_inao_upd_cur CURSOR FOR armt100_inao_upd_pre    

   #根据当前制造批序号资料抓取来源单据的inao资料
   #来源资料的项序与当前资料的项序不一样,所以用制造批号和制造序号抓取
   LET l_sql = " SELECT DISTINCT inao008,inao009 FROM inao_t ",
               "  WHERE inaoent = '",g_enterprise,"'",
               "    AND inaosite = '",g_site,"'",
               "    AND inaodocno = ?",
               "    AND inaoseq = ?",
               "    AND inaoseq1 = ?",    #2016-5-16 zhujing
               "    AND inao000 = '2' ",
               "    AND inao008 = ? ",
               "    AND inao009 = ? " 
   PREPARE armt100_inao_upd_pre1 FROM l_sql
   DECLARE armt100_inao_upd_cur1 CURSOR FOR armt100_inao_upd_pre1 
   
   LET l_sql = " SELECT DISTINCT inao008,inao009 FROM inao_t ",
               "  WHERE inaoent = '",g_enterprise,"'",
               "    AND inaosite = '",g_site,"'",
               "    AND inaodocno = ?",
               "    AND inaoseq = ?",
               "    AND inao000 = '2' ",
               "    AND inao008 = ? ",
               "    AND inao009 = ? " 
   PREPARE armt100_inao_upd_pre2 FROM l_sql
   DECLARE armt100_inao_upd_cur2 CURSOR FOR armt100_inao_upd_pre2 
   
   LET l_sql = "SELECT DISTINCT inaoseq1,inaoseq2",            
               "  FROM inao_t ",
               " WHERE inaoent = '",g_enterprise,"'",
               "   AND inaodocno = ?",
               "   AND inaoseq = ?", 
               "   AND inao001 = ?",
               "   AND inao002 = ?",
               "   AND inao008 = ?",
               "   AND inao009 = ?"
#               "   AND inao000 = 1" #2016-5-16 zhujing add
#               "   AND rownum = 1"
   IF p_type = '0' OR p_type = '1' THEN
      LET l_sql = l_sql,"   AND inao000 = 2" #2016-5-16 zhujing add
   ELSE
      LET l_sql = l_sql,"   AND inao000 = 1" #2016-5-16 zhujing add
   END IF
   IF p_type = '1' OR p_type = '3' THEN
      LET l_sql = l_sql," AND (inao012-inao025 > 0 OR inao025 IS NULL) "
   ELSE
      LET l_sql = l_sql," AND inao025 > 0 "
   END IF
   LET l_sql = l_sql," ORDER BY inaoseq1,inaoseq2"
   
   PREPARE armt100_inao_upd_pre4 FROM l_sql 

   FOREACH armt100_inao_upd_cur INTO l_inao.*
      IF SQLCA.sqlcode THEN  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'foreach inao_t'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH 
      END IF   
      IF cl_null(p_from_docno) OR cl_null(p_from_seq) THEN 
         SELECT rmab003,rmab004 INTO p_from_docno,p_from_seq
           FROM rmab_t
          WHERE rmabent = g_enterprise
            AND rmabdocno = l_inao.inaodocno
            AND rmabseq = l_inao.inaoseq            
      END IF
#      FOREACH armt100_inao_upd_cur1 USING p_from_docno,p_from_seq,l_inao.inao008,l_inao.inao009
      IF p_type = '1' OR p_type = '0' THEN
         FOREACH armt100_inao_upd_cur2 USING p_from_docno,p_from_seq,l_inao.inao008,l_inao.inao009
                                         INTO l_inao008,l_inao009
            IF SQLCA.sqlcode THEN  
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'foreach inao_t'
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               EXIT FOREACH 
            END IF             
   
            EXECUTE armt100_inao_upd_pre4 USING p_from_docno,p_from_seq,l_inao.inao001,
                                                  l_inao.inao002,l_inao008,l_inao009 
                                             INTO l_inaoseq1,l_inaoseq2
            IF p_type = '1' OR p_type = '3' THEN
               LET l_sql = " UPDATE inao_t SET inao025 = COALESCE(inao025,0) + ",l_inao.inao012
            ELSE   
               LET l_sql = " UPDATE inao_t SET inao025 = COALESCE(inao025,0) - ",l_inao.inao012
            END IF
            LET l_sql = l_sql," WHERE inaoent = '",g_enterprise,"'",
                              "   AND inaodocno = '",p_from_docno,"'",
                              "   AND inaoseq = ",p_from_seq,
                              "   AND inaoseq1 = ? ",
                              "   AND inaoseq2 = ? "
            #2016-5-16 zhujing add(S)
            IF p_type = '3' OR p_type = '4' THEN
               LET l_sql = l_sql CLIPPED," AND inao000 = 1 "
            END IF
            #2016-5-16 zhujing add(E)
            PREPARE armt100_inao_upd_pre5 FROM l_sql                         
            EXECUTE armt100_inao_upd_pre5 USING l_inaoseq1,l_inaoseq2                  
            IF SQLCA.sqlcode THEN  
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'upd inao_t'
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               EXIT FOREACH 
            END IF  
         END FOREACH          
      ELSE
         FOREACH armt100_inao_upd_cur1 USING p_from_docno,p_from_seq,p_seq1,l_inao.inao008,l_inao.inao009
                                         INTO l_inao008,l_inao009
            IF SQLCA.sqlcode THEN  
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'foreach inao_t'
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               EXIT FOREACH 
            END IF             
   
            EXECUTE armt100_inao_upd_pre4 USING p_from_docno,p_from_seq,l_inao.inao001,
                                                  l_inao.inao002,l_inao008,l_inao009 
                                             INTO l_inaoseq1,l_inaoseq2
            IF p_type = '1' OR p_type = '3' THEN
               LET l_sql = " UPDATE inao_t SET inao025 = COALESCE(inao025,0) + ",l_inao.inao012
            ELSE   
               LET l_sql = " UPDATE inao_t SET inao025 = COALESCE(inao025,0) - ",l_inao.inao012
            END IF
            LET l_sql = l_sql," WHERE inaoent = '",g_enterprise,"'",
                              "   AND inaodocno = '",p_from_docno,"'",
                              "   AND inaoseq = ",p_from_seq,
                              "   AND inaoseq1 = ? ",
                              "   AND inaoseq2 = ? "
            #2016-5-16 zhujing add(S)
            IF p_type = '3' OR p_type = '4' THEN
               LET l_sql = l_sql CLIPPED," AND inao000 = 1 "
            END IF
            #2016-5-16 zhujing add(E)
            PREPARE armt100_inao_upd_pre6 FROM l_sql                         
            EXECUTE armt100_inao_upd_pre6 USING l_inaoseq1,l_inaoseq2                  
            IF SQLCA.sqlcode THEN  
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'upd inao_t'
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               EXIT FOREACH 
            END IF  
         END FOREACH
      END IF         
   END FOREACH

   
   RETURN r_success   
END FUNCTION
#2016-4-14 By zhujing
PRIVATE FUNCTION armt100_del_rmac()
DEFINE r_success  LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5

       LET r_success = TRUE
       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt FROM rmac_t 
        WHERE rmacent = g_enterprise
          AND rmacdocno = g_rmaa_m.rmaadocno
          AND rmacseq = g_rmab_d_t.rmabseq #項次
       IF l_cnt > 0 THEN   
          DELETE FROM rmac_t
              WHERE rmacent = g_enterprise AND rmacsite = g_site 
                AND rmacdocno = g_rmaa_m.rmaadocno 
                AND rmacseq = g_rmab_d_t.rmabseq #項次
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
      RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 判断是否维护了点收的制造批序号资料
# Memo...........:
# Usage..........: CALL armt100_inao_chk()
#                  RETURNING r_success
# Date & Author..: 2016-5-18 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_inao_chk(p_docno,p_seq,p_seq1,p_num,p_type)
DEFINE p_docno    LIKE rmaa_t.rmaadocno
DEFINE p_seq      LIKE rmac_t.rmacseq
DEFINE p_seq1     LIKE rmac_t.rmacseq1
DEFINE p_num      LIKE type_t.num10
DEFINE p_type     LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num10
DEFINE r_success  LIKE type_t.num5

   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_cnt
     FROM inao_t
    WHERE inaodocno = p_docno
      AND inaoseq = p_seq
      AND inaoseq1 = p_seq1
      AND inao000 = p_type
      AND inaoent = g_enterprise
   IF cl_null(l_cnt) OR l_cnt = 0 OR l_cnt < p_num THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根据单号，项次抓取序号
# Memo...........: 数量为1时，仅对应一个序号
# Usage..........: CALL armt100_get_inao009(p_rmaadocno,p_rmabseq)
#                  RETURNING r_inao009
# Date & Author..: 2016-7-20 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt100_get_inao009(p_rmaadocno,p_rmabseq)
DEFINE p_rmaadocno      LIKE rmaa_t.rmaadocno
DEFINE p_rmabseq        LIKE rmab_t.rmabseq
DEFINE l_cnt            LIKE type_t.num5
DEFINE r_inao009        LIKE inao_t.inao009
DEFINE r_inao010        LIKE inao_t.inao010
DEFINE r_inao011        LIKE inao_t.inao011
   
   LET r_inao009 = NULL 
   LET r_inao010 = NULL    #160816-00066#1 add
   LET r_inao011 = NULL    #160816-00066#1 add
   IF cl_null(p_rmaadocno) OR cl_null(p_rmabseq) THEN
      RETURN r_inao009
   END IF
   SELECT COUNT(inao009) INTO l_cnt
      FROM inao_t 
    WHERE inaodocno = p_rmaadocno
      AND inaoseq = p_rmabseq
      AND inaoent = g_enterprise
      AND inao000 = '1'
   IF l_cnt <> 1 OR cl_null(l_cnt) THEN
   ELSE
      SELECT DISTINCT inao009,inao010,inao011 INTO r_inao009,r_inao010,r_inao011
        FROM inao_t 
       WHERE inaodocno = p_rmaadocno
         AND inaoseq = p_rmabseq
         AND inaoent = g_enterprise
         AND inao000 = '1'
   END IF
      
   RETURN  r_inao009,r_inao010,r_inao011
END FUNCTION

################################################################################
# Descriptions...: 整批点收
# Memo...........:
# Usage..........: 
#                  
# Date & Author..: 2016-11-11 By zhujing
# Modify.........: #160816-00066#1 ADD
################################################################################
PRIVATE FUNCTION armt100_count_batch()
DEFINE l_location    LIKE rmac_t.rmac002
DEFINE l_date        LIKE rmac_t.rmac006
DEFINE l_flag1       LIKE type_t.num5           #160816-00066#1 add
DEFINE l_ooac002     LIKE ooac_t.ooac002        #160816-00066#1 add
   
   #當前在查詢方案頁簽時，直接返回，否則程式可能會當出
   IF g_main_hidden THEN
      RETURN
   END IF
   IF g_rmaa_m.rmaadocno IS NULL THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   CALL s_aooi200_get_slip(g_rmaa_m.rmaadocno) RETURNING l_flag1,l_ooac002    
   LET l_date = cl_get_current()
   LET l_location = cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-MFG-0041')
   CALL s_transaction_begin()
   UPDATE rmac_t 
      SET rmac002 = l_location,
          rmac007 = g_user,
          rmac006 = l_date
    WHERE rmacdocno = g_rmaa_m.rmaadocno
      AND rmacsite = g_site
      AND rmacent = g_enterprise
   CASE
      WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmac_t" 
         LET g_errparam.code   = "std-00009" 
         LET g_errparam.popup  = TRUE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         
      WHEN SQLCA.sqlcode #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmac_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         
      OTHERWISE
         CALL s_transaction_end('Y','0')
         CALL cl_ask_confirm3("std-00012","")
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 料号资料变化时，删去制造批序号资料
################################################################################
PRIVATE FUNCTION armt100_del_inao(p_docno,p_seq)
DEFINE p_docno    LIKE inao_t.inaodocno
DEFINE p_seq      LIKE inao_t.inaoseq
DEFINE r_success  LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5

   LET r_success = TRUE
   IF cl_null(p_docno) OR cl_null(p_seq) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   SELECT COUNT(1) INTO l_cnt
     FROM inao_t
    WHERE inaoent = g_enterprise 
      AND inaosite = g_site 
      AND inaodocno = p_docno
      AND inaoseq = p_seq
   IF l_cnt = 0 OR cl_null(l_cnt) THEN
      RETURN r_success
   END IF
   
   DELETE FROM inao_t
    WHERE inaoent = g_enterprise 
      AND inaosite = g_site 
      AND inaodocno = p_docno
      AND inaoseq = p_seq
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "inao_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()           
#      CANCEL DELETE
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
