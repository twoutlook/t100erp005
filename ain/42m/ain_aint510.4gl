#該程式未解開Section, 採用最新樣板產出!
{<section id="aint510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0035(2017-02-09 15:07:44), PR版次:0035(2017-02-20 17:32:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000347
#+ Filename...: aint510
#+ Description: 調撥單維護作業
#+ Creator....: 01726(2014-03-05 14:12:00)
#+ Modifier...: 08172 -SD/PR- 01996
 
{</section>}
 
{<section id="aint510.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160329-00005#1  20160329 by sakura  替換v_inaa001校驗錯誤碼
#160318-00025#19 20160414 BY 07900   校验代码重复错误讯息的修改
#160929-00012#1  20161010 by 06189   aint512拨出审核的调用s_ainp512
#160824-00007#30 20161017 by 06814   新舊值調整
#161017-00029#5  20161018 by 08172   aint511根据条码带产品特征，产品特征带条码
#161017-00029#6  20161018 by 08172   aint513根据条码带产品特征，产品特征带条码
#161017-00029#8  20161019 by 08172   aint511新增产品条码开窗
#161017-00029#9  20161019 by 08172   aint513新增产品条码开窗
#161024-00023#7  20161028 by 06137   aint513新增产生拣货装箱单功能
#161027-00055#5  20161029 by 08172   aint511单身新增配送中心和可用库存的显示
#161109-00078#6  20161114 by 06137   作废或删除时，IF来源类型=4.配送单 and 单身第一笔需求单号indd047、需求项次indd048已存在非作废状态下的装箱单身.需求单号inbp011、需求项次inbp012，则更新配送单抛单否[indj021]=N，条件（indd047=indj001 and indd048=indj002）
#161128-00041#1  20161129 by 06189   aint513拨出审核的调用s_ainp513
#161017-00051#19 20161205 by 06814   1.修正單身不能下查詢條件的BUG
#                                    2.補上單身查詢:來源需求單號&產品特徵
#161124-00039#1  20161206 by geza    使用inax计算可用库存
#161213-00022#1  20161213 by 08172   #aint513产生拣货装箱单按钮写入装箱单头的需求对象inbm001改为拨出组织indc005
#161216-00033#1  20161216 by geza    aint511单身季节应该取imaa133 ，并且增加说明栏位；大类改成去该条明细商品对应品类的一级品类，对应说明栏位逻辑做对应改动；
#161217-00002#1  20161220 by 06137   1.aooi200单据别里增加参数：是否需要审核，默认N,
#                                    2.aint513状态码开放已审核状态，单据性质indc000=1.一阶段调拨且状态为未审核 且是否需要审核参数为Y时，可更新状态为已审核，已审核状态单据不可再进行编辑、删除，单据性质indc000=1.一阶段调拨且状态为已审核时，可更新状态为未审核;
#                                    3.一阶段调拨增加产生拣货装箱单功能，详见分镜
#161214-00003#1  20161228 by 06137   5区DSCNJ   开启作业新增一笔资料，审核后立即在拨入组织点击产生捡货装箱单功能钮，报错ain-00814,确定后画面被刷新为空白
#161230-00027#1  20161230 by 06137   aint513产生拣货装箱单时，写inbm003来源类型字段时。逻辑调整为：         
#                                    if 单据性质[ind000]=2.两阶段调拨单
#                                       inbm003来源单据类型:'6.门店仓退单'
#                                    if 单据性质[ind000]=1.一阶段调拨单
#                                       inbm003来源单据类型:'9.一阶段仓退单'
#161228-00033#5  20170106 by sakura  為了客戶DB種類的相容性:rownum寫法的改寫
#170116-00018#11 20170117 by 08172   aint511去掉单身配送中心、配送中心说明、配送仓可用库存字段与相关逻辑
#170122-00004#1  2017/01/23   by geza    调整系统中无ENT的SQL条件增加ent
#160711-00040#15 2017/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql
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
PRIVATE type type_g_indc_m        RECORD
       indcsite LIKE indc_t.indcsite, 
   indcsite_desc LIKE type_t.chr80, 
   indcdocdt LIKE indc_t.indcdocdt, 
   indcdocno LIKE indc_t.indcdocno, 
   indc001 LIKE indc_t.indc001, 
   indc004 LIKE indc_t.indc004, 
   indc004_desc LIKE type_t.chr80, 
   indc101 LIKE indc_t.indc101, 
   indc101_desc LIKE type_t.chr80, 
   indcunit LIKE indc_t.indcunit, 
   indc199 LIKE indc_t.indc199, 
   indc000 LIKE indc_t.indc000, 
   indc202 LIKE indc_t.indc202, 
   indc002 LIKE indc_t.indc002, 
   indc003 LIKE indc_t.indc003, 
   indc026 LIKE indc_t.indc026, 
   indc025 LIKE indc_t.indc025, 
   indc200 LIKE indc_t.indc200, 
   indc200_desc LIKE type_t.chr80, 
   indc201 LIKE indc_t.indc201, 
   indc201_desc LIKE type_t.chr80, 
   indc005 LIKE indc_t.indc005, 
   indc005_desc LIKE type_t.chr80, 
   indc006 LIKE indc_t.indc006, 
   indc006_desc LIKE type_t.chr80, 
   indc007 LIKE indc_t.indc007, 
   indc007_desc LIKE type_t.chr80, 
   indc008 LIKE indc_t.indc008, 
   indcstus LIKE indc_t.indcstus, 
   indc021 LIKE indc_t.indc021, 
   indc021_desc LIKE type_t.chr80, 
   indc022 LIKE indc_t.indc022, 
   indc023 LIKE indc_t.indc023, 
   indc023_desc LIKE type_t.chr80, 
   indc024 LIKE indc_t.indc024, 
   indcownid LIKE indc_t.indcownid, 
   indcownid_desc LIKE type_t.chr80, 
   indcowndp LIKE indc_t.indcowndp, 
   indcowndp_desc LIKE type_t.chr80, 
   indccrtid LIKE indc_t.indccrtid, 
   indccrtid_desc LIKE type_t.chr80, 
   indccrtdp LIKE indc_t.indccrtdp, 
   indccrtdp_desc LIKE type_t.chr80, 
   indccrtdt LIKE indc_t.indccrtdt, 
   indcmodid LIKE indc_t.indcmodid, 
   indcmodid_desc LIKE type_t.chr80, 
   indcmoddt LIKE indc_t.indcmoddt, 
   indccnfid LIKE indc_t.indccnfid, 
   indccnfid_desc LIKE type_t.chr80, 
   indccnfdt LIKE indc_t.indccnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_indd_d        RECORD
       inddsite LIKE indd_t.inddsite, 
   inddunit LIKE indd_t.inddunit, 
   inddseq LIKE indd_t.inddseq, 
   indd001 LIKE indd_t.indd001, 
   indd047 LIKE indd_t.indd047, 
   indd048 LIKE indd_t.indd048, 
   indd003 LIKE indd_t.indd003, 
   indd002 LIKE indd_t.indd002, 
   indd002_desc LIKE type_t.chr500, 
   indd002_desc_desc LIKE type_t.chr500, 
   indd004 LIKE indd_t.indd004, 
   imaa154 LIKE type_t.chr500, 
   imaa133 LIKE type_t.chr500, 
   imaa133_desc LIKE type_t.chr500, 
   imaa156 LIKE type_t.chr500, 
   imaa132 LIKE type_t.chr500, 
   imaa132_desc LIKE type_t.chr500, 
   rtaw001 LIKE type_t.chr500, 
   imaa128_desc LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr500, 
   imaa009_desc LIKE type_t.chr500, 
   imaa157 LIKE type_t.chr500, 
   rtdx029 LIKE type_t.chr500, 
   rtdx029_desc LIKE type_t.chr500, 
   inag009 LIKE type_t.chr500, 
   indd006 LIKE indd_t.indd006, 
   indd006_desc LIKE type_t.chr500, 
   indd005 LIKE indd_t.indd005, 
   indd007 LIKE indd_t.indd007, 
   indd007_desc LIKE type_t.chr500, 
   indd008 LIKE indd_t.indd008, 
   indd009 LIKE indd_t.indd009, 
   indd020 LIKE indd_t.indd020, 
   indd021 LIKE indd_t.indd021, 
   indd045 LIKE indd_t.indd045, 
   indd046 LIKE indd_t.indd046, 
   indd010 LIKE indd_t.indd010, 
   indd022 LIKE indd_t.indd022, 
   indd022_desc LIKE type_t.chr500, 
   indd023 LIKE indd_t.indd023, 
   indd023_desc LIKE type_t.chr500, 
   indd024 LIKE indd_t.indd024, 
   indd102 LIKE indd_t.indd102, 
   indd025 LIKE indd_t.indd025, 
   indd030 LIKE indd_t.indd030, 
   indd031 LIKE indd_t.indd031, 
   indd032 LIKE indd_t.indd032, 
   indd032_desc LIKE type_t.chr500, 
   indd033 LIKE indd_t.indd033, 
   indd033_desc LIKE type_t.chr500, 
   indd034 LIKE indd_t.indd034, 
   indd035 LIKE indd_t.indd035, 
   indd040 LIKE indd_t.indd040, 
   indd101 LIKE indd_t.indd101
       END RECORD
PRIVATE TYPE type_g_indd2_d RECORD
       indlseq LIKE indl_t.indlseq, 
   indlseq1 LIKE indl_t.indlseq1, 
   indl001 LIKE indl_t.indl001, 
   indl002 LIKE indl_t.indl002, 
   indl002_desc LIKE type_t.chr500, 
   indl002_desc_desc LIKE type_t.chr500, 
   indl003 LIKE indl_t.indl003, 
   indl004 LIKE indl_t.indl004, 
   indl004_desc LIKE type_t.chr500, 
   indl005 LIKE indl_t.indl005, 
   indl005_desc LIKE type_t.chr500, 
   indl022 LIKE indl_t.indl022, 
   indl022_desc LIKE type_t.chr500, 
   indl023 LIKE indl_t.indl023, 
   indl023_desc LIKE type_t.chr500, 
   indl024 LIKE indl_t.indl024, 
   indl101 LIKE indl_t.indl101, 
   indl020 LIKE indl_t.indl020, 
   indl021 LIKE indl_t.indl021, 
   indl102 LIKE indl_t.indl102, 
   indl103 LIKE indl_t.indl103, 
   indl032 LIKE indl_t.indl032, 
   indl032_desc LIKE type_t.chr500, 
   indl033 LIKE indl_t.indl033, 
   indl033_desc LIKE type_t.chr500, 
   indl034 LIKE indl_t.indl034, 
   indl030 LIKE indl_t.indl030, 
   indl031 LIKE indl_t.indl031
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_indcsite LIKE indc_t.indcsite,
   b_indcsite_desc LIKE type_t.chr80,
      b_indcdocdt LIKE indc_t.indcdocdt,
      b_indcdocno LIKE indc_t.indcdocno,
      b_indc001 LIKE indc_t.indc001,
      b_indc004 LIKE indc_t.indc004,
   b_indc004_desc LIKE type_t.chr80,
      b_indcunit LIKE indc_t.indcunit,
      b_indc002 LIKE indc_t.indc002,
      b_indc003 LIKE indc_t.indc003,
      b_indc005 LIKE indc_t.indc005,
   b_indc005_desc LIKE type_t.chr80,
      b_indc006 LIKE indc_t.indc006,
   b_indc006_desc LIKE type_t.chr80,
      b_indc007 LIKE indc_t.indc007,
   b_indc007_desc LIKE type_t.chr80,
      b_indc021 LIKE indc_t.indc021,
   b_indc021_desc LIKE type_t.chr80,
      b_indc022 LIKE indc_t.indc022,
      b_indc023 LIKE indc_t.indc023,
   b_indc023_desc LIKE type_t.chr80,
      b_indc024 LIKE indc_t.indc024,
      b_indc008 LIKE indc_t.indc008
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_detail_flag     LIKE type_t.chr1
#end add-point
       
#模組變數(Module Variables)
DEFINE g_indc_m          type_g_indc_m
DEFINE g_indc_m_t        type_g_indc_m
DEFINE g_indc_m_o        type_g_indc_m
DEFINE g_indc_m_mask_o   type_g_indc_m #轉換遮罩前資料
DEFINE g_indc_m_mask_n   type_g_indc_m #轉換遮罩後資料
 
   DEFINE g_indcdocno_t LIKE indc_t.indcdocno
 
 
DEFINE g_indd_d          DYNAMIC ARRAY OF type_g_indd_d
DEFINE g_indd_d_t        type_g_indd_d
DEFINE g_indd_d_o        type_g_indd_d
DEFINE g_indd_d_mask_o   DYNAMIC ARRAY OF type_g_indd_d #轉換遮罩前資料
DEFINE g_indd_d_mask_n   DYNAMIC ARRAY OF type_g_indd_d #轉換遮罩後資料
DEFINE g_indd2_d          DYNAMIC ARRAY OF type_g_indd2_d
DEFINE g_indd2_d_t        type_g_indd2_d
DEFINE g_indd2_d_o        type_g_indd2_d
DEFINE g_indd2_d_mask_o   DYNAMIC ARRAY OF type_g_indd2_d #轉換遮罩前資料
DEFINE g_indd2_d_mask_n   DYNAMIC ARRAY OF type_g_indd2_d #轉換遮罩後資料
 
 
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
 
{<section id="aint510.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309            
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
            
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
            
   #end add-point
   LET g_forupd_sql = " SELECT indcsite,'',indcdocdt,indcdocno,indc001,indc004,'',indc101,'',indcunit, 
       indc199,indc000,indc202,indc002,indc003,indc026,indc025,indc200,'',indc201,'',indc005,'',indc006, 
       '',indc007,'',indc008,indcstus,indc021,'',indc022,indc023,'',indc024,indcownid,'',indcowndp,'', 
       indccrtid,'',indccrtdp,'',indccrtdt,indcmodid,'',indcmoddt,indccnfid,'',indccnfdt", 
                      " FROM indc_t",
                      " WHERE indcent= ? AND indcdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
            
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.indcsite,t0.indcdocdt,t0.indcdocno,t0.indc001,t0.indc004,t0.indc101, 
       t0.indcunit,t0.indc199,t0.indc000,t0.indc202,t0.indc002,t0.indc003,t0.indc026,t0.indc025,t0.indc200, 
       t0.indc201,t0.indc005,t0.indc006,t0.indc007,t0.indc008,t0.indcstus,t0.indc021,t0.indc022,t0.indc023, 
       t0.indc024,t0.indcownid,t0.indcowndp,t0.indccrtid,t0.indccrtdp,t0.indccrtdt,t0.indcmodid,t0.indcmoddt, 
       t0.indccnfid,t0.indccnfdt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.inayl003 ,t5.inayl003 ,t6.ooefl003 , 
       t7.ooefl003 ,t8.inayl003 ,t9.ooag011 ,t10.ooag011 ,t11.ooag011 ,t12.ooefl003 ,t13.ooag011 ,t14.ooefl003 , 
       t15.ooag011 ,t16.ooag011",
               " FROM indc_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.indcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.indc004  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.indc101 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t4 ON t4.inaylent="||g_enterprise||" AND t4.inayl001=t0.indc200 AND t4.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t5 ON t5.inaylent="||g_enterprise||" AND t5.inayl001=t0.indc201 AND t5.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.indc005 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.indc006 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=t0.indc007 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.indc021  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.indc023  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.indcownid  ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=t0.indcowndp AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.indccrtid  ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent="||g_enterprise||" AND t14.ooefl001=t0.indccrtdp AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.indcmodid  ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.indccnfid  ",
 
               " WHERE t0.indcent = " ||g_enterprise|| " AND t0.indcdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aint510_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                        
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint510 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint510_init()   
 
      #進入選單 Menu (="N")
      CALL aint510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                        
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint510
      
   END IF 
   
   CLOSE aint510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309  
   ##150427-00001#9 150630 By pomelo add(S)
   CALL s_lot_auto_drop_tmp(g_prog)
   CALL s_aooi390_drop_tmp_table()
   ##150427-00001#9 150630 By pomelo add(E)   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint510.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint510_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sys1        LIKE type_t.chr80       #组织间调拨是否启用在途
   DEFINE l_sys2        LIKE type_t.chr80       #组织内调拨是否启用在途
   DEFINE l_sys3        LIKE type_t.chr80       #在途仓归属 1.拨出 2.拨入
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309   
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
      CALL cl_set_combo_scc_part('indcstus','13','N,Y,S,C,O,P,A,D,R,W,X')
 
      CALL cl_set_combo_scc('indc199','6762') 
   CALL cl_set_combo_scc('indc000','2082') 
   CALL cl_set_combo_scc('indc202','6888') 
   CALL cl_set_combo_scc('indc026','6971') 
   CALL cl_set_combo_scc('indd005','6013') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = '1'
   #CALL cl_set_combo_scc_part('indcstus','13','N,X,C,O,P') #mark by geza 20160919 #160909-00069#5
   CALL cl_set_combo_scc_part('indcstus','13','N,X,C,O,P,Y') #add by geza 20160919 #160909-00069#5
   CALL cl_set_combo_scc('b_indc002','6016') 
   #取参数
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys1
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0014') RETURNING l_sys2
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0015') RETURNING l_sys3
   IF l_sys1 = 'N' AND l_sys2 = 'N' THEN
      CALL cl_set_comp_visible("indc007,indc007_desc,b_indc007",FALSE)
   ELSE
      CALL cl_set_comp_visible("indc007,indc007_desc,b_indc007",TRUE)
   END IF
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309
   ##150427-00001#9 150630 By pomelo add(S)
   CALL s_lot_auto_create_tmp(g_prog) RETURNING l_success
   LET l_success = ''
   CALL s_aooi390_cre_tmp_table() RETURNING l_success
   ##150427-00001#9 150630 By pomelo add(E) 
   
   #151204-00007#10 151228 By pomelo add(S)
   #操作類型
   IF g_argv[1] MATCHES '[123]' THEN
      CALL cl_set_comp_visible("indc202",FALSE)
   ELSE
      CALL cl_set_comp_visible("indc202",TRUE)
   END IF
   CASE g_argv[1]
      WHEN '4'    #門店移倉單
         CALL cl_set_combo_scc_part("indc202",'6888','1,2,6')
      WHEN '5'    #門店生鮮移倉單
         CALL cl_set_combo_scc_part("indc202",'6888','3')
      WHEN '6'    #贈品移倉單
         CALL cl_set_combo_scc_part("indc202",'6888','4,5')
   END CASE
   IF g_argv[1] != '5' THEN
      CALL cl_set_comp_visible("lbl_dummy01",FALSE)
      CALL cl_set_comp_visible("lbl_dummy02",FALSE)
   END IF
   #151204-00007#10 151228 By pomelo add(E)
   
   #根據不同的參數，toolbar選擇顯示或隱藏
   CALL aint510_act_visible_init()  #161024-00023#7 Add By Ken 161028
   
   #end add-point
   
   #初始化搜尋條件
   CALL aint510_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aint510.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aint510_ui_dialog()
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
   DEFINE l_pmds000  LIKE pmds_t.pmds000   #150807-00002#1 1508/17 by sakura
   DEFINE l_cnt      LIKE type_t.num5      #150127-00004#16 151026 By pomelo
   DEFINE l_success  LIKE type_t.num5      #161024-00023#7  161028 By Ken
   #161217-00002#1 Add By Ken 161220(S)
   DEFINE l_slip        LIKE ooba_t.ooba002      #單據別   
   DEFINE l_gzcb002     LIKE gzcb_t.gzcb002
   DEFINE l_n           LIKE type_t.num10
   #161217-00002#1 Add By Ken 161220(E)   
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
            CALL aint510_insert()
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
         INITIALIZE g_indc_m.* TO NULL
         CALL g_indd_d.clear()
         CALL g_indd2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aint510_init()
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
               
               CALL aint510_fetch('') # reload data
               LET l_ac = 1
               CALL aint510_ui_detailshow() #Setting the current row 
         
               CALL aint510_idx_chk()
               #NEXT FIELD inddseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_indd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint510_idx_chk()
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
               CALL aint510_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                                                            
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aint510_01
            LET g_action_choice="open_aint510_01"
            IF cl_auth_chk_act("open_aint510_01") THEN
               
               #add-point:ON ACTION open_aint510_01 name="menu.detail_show.page1.open_aint510_01"
               
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                                                
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_indd2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint510_idx_chk()
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
               CALL aint510_idx_chk()
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
            CALL aint510_browser_fill("")
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
               CALL aint510_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aint510_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aint510_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL aint510_set_act_visible()   
            CALL aint510_set_act_no_visible()                 
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aint510_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aint510_set_act_visible()   
            CALL aint510_set_act_no_visible()
            IF NOT (g_indc_m.indcdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " indcent = " ||g_enterprise|| " AND",
                                  " indcdocno = '", g_indc_m.indcdocno, "' "
 
               #填到對應位置
               CALL aint510_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "indc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "indd_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "indl_t" 
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
               CALL aint510_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "indc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "indd_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "indl_t" 
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
                  CALL aint510_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint510_fetch("F")
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
               CALL aint510_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aint510_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint510_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aint510_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint510_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aint510_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint510_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aint510_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint510_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aint510_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint510_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_indd_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_indd2_d)
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
               NEXT FIELD inddseq
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
               CALL aint510_modify()
               #add-point:ON ACTION modify name="menu.modify"
                                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aint510_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_aint701
            LET g_action_choice="gen_aint701"
            IF cl_auth_chk_act("gen_aint701") THEN
               
               #add-point:ON ACTION gen_aint701 name="menu.gen_aint701"
               #161024-00023#7 Add By Ken 161028(S)
               IF g_indc_m.indcdocno IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00003"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #EXIT DIALOG   #161214-00003#1 Mark By ken 1612228
                  CONTINUE DIALOG   #161214-00003#1 Add By ken 1612228
               END IF  
               IF NOT ((g_indc_m.indcstus = 'O' AND g_indc_m.indc000 ='3') 
               OR  (g_indc_m.indc000 = '1' AND g_indc_m.indcstus = 'Y'))THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ain-00814"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #EXIT DIALOG   #161214-00003#1 Mark By ken 1612228
                  CONTINUE DIALOG   #161214-00003#1 Add By ken 1612228
               END IF
               IF g_argv[1] = '3' THEN   
                  #161217-00002#1 Add By Ken 161221(S)
                  #當一階段調撥且一階段調撥是否需要確認='Y'時 需檢查是否存在裝箱單
                  # 取出單號的單別
                  LET l_success = ''
                  LET l_slip = ''
                  CALL s_aooi200_get_slip(g_indc_m.indcdocno)
                     RETURNING l_success,l_slip
                  
                  # 取單別參數 一階段調撥是否需要確認
                  LET l_gzcb002 = ''
                  CALL cl_get_doc_para(g_enterprise,g_indc_m.indcsite,l_slip,'D-CIR-0006')
                     RETURNING l_gzcb002                                       
                  #檢查是否存在aint701
                  IF (l_gzcb002 = 'Y') AND (g_indc_m.indc000 = '1') THEN
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt
                       FROM inbm_t
                      WHERE inbment = g_enterprise
                        AND inbm004 = g_indc_m.indcdocno
                        AND inbmstus != 'X'                  
                  ELSE
                  #161217-00002#1 Add By Ken 161221(E) 
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt
                       FROM inbm_t
                      WHERE inbment = g_enterprise
                        AND inbm004 = g_indc_m.indc001
                        AND inbmstus != 'X'
                  END IF
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00805'  
                     LET g_errparam.extend = g_indc_m.indcdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()  
                     #EXIT DIALOG   #161214-00003#1 Mark By ken 1612228
                     CONTINUE DIALOG   #161214-00003#1 Add By ken 1612228                   
                  END IF 

                  CALL s_transaction_begin()
                  CALL cl_err_collect_init() 
                  CALL aint510_ins_inbm(g_indc_m.indcdocno) RETURNING l_success
                  CALL cl_err_collect_show()
                  IF l_success THEN
                     CALL s_transaction_end('Y','1')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF                                     
               END IF                
               #161024-00023#7 Add By Ken 161028(E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint510_delete()
               #add-point:ON ACTION delete name="menu.delete"
                                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint510_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " indcent = '",g_enterprise,"' AND indcdocno = '",g_indc_m.indcdocno,"' " #sakura ad                                             
               #END add-point
               &include "erp/ain/aint510_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " indcent = '",g_enterprise,"' AND indcdocno = '",g_indc_m.indcdocno,"' " #sakura ad                                             
               #END add-point
               &include "erp/ain/aint510_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aint510_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint510_query()
               #add-point:ON ACTION query name="menu.query"
                                                            
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_indc004
            LET g_action_choice="prog_indc004"
            IF cl_auth_chk_act("prog_indc004") THEN
               
               #add-point:ON ACTION prog_indc004 name="menu.prog_indc004"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_indc_m.indc004)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_aint500
            LET g_action_choice="prog_aint500"
            IF cl_auth_chk_act("prog_aint500") THEN
               
               #add-point:ON ACTION prog_aint500 name="menu.prog_aint500"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               #150807-00002#1 1508/17 by sakura add(S)
               CASE g_indc_m.indc002
                  WHEN '2'
                     LET la_param.prog     = 'aint500'
                  WHEN '3'
                     LET la_param.prog     = 'aint520'                  
                  WHEN '4'
                     LET la_param.prog     = 'aint700'                  
                  WHEN '5'
                     LET l_pmds000 = ''
                     SELECT pmds000 INTO l_pmds000 
                       FROM pmds_t
                      WHERE pmdsent = g_enterprise
                        AND pmdsdocno = g_indc_m.indc003
                     CASE l_pmds000
                        WHEN '3'
                           LET la_param.prog     = 'apmt862'   #採購收貨入庫
                        WHEN '4'
                           LET la_param.prog     = 'apmt863'   #無採購收貨入庫
                        WHEN '6'
                           LET la_param.prog     = 'apmt880'   #採購入庫
                        OTHERWISE
                           EXIT DIALOG
                     END CASE
                  WHEN '6'
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt
                       FROM indm_t
                      WHERE indment = g_enterprise
                        AND indmdocno = g_indc_m.indc003
                     IF l_cnt = 1 THEN
                        LET la_param.prog     = 'aint530'
                     ELSE
                        LET la_param.prog     = 'aint510'
                     END IF
                  OTHERWISE
                     EXIT DIALOG
               END CASE
               #150807-00002#1 1508/17 by sakura add(E)
               LET la_param.param[1] = g_indc_m.indc003

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint510_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint510_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint510_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_indc_m.indcdocdt)
 
 
 
         
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
 
{<section id="aint510.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aint510_browser_fill(ps_page_action)
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
   LET l_wc = l_wc CLIPPED," AND indcsite = '",g_site,"' "
   LET g_wc = g_wc CLIPPED," AND indcsite = '",g_site,"' "
   
   #150127-00004#13 15/03/17 By pomelo add(s)
   CASE g_argv[1]
      WHEN '1'    #調撥
         LET l_wc = l_wc CLIPPED," AND indc199 = '1'"
         LET g_wc = g_wc CLIPPED," AND indc199 = '1'"
         
      WHEN '2'    #配送
         LET l_wc = l_wc CLIPPED," AND indc199 = '2'"
         LET g_wc = g_wc CLIPPED," AND indc199 = '2'"
         
      WHEN '3'    #倉退
        #mod by tangyi 161010-str-161010-00006#1
         #LET l_wc = l_wc CLIPPED," AND indc199 = '3'"
         #LET g_wc = g_wc CLIPPED," AND indc199 = '3'"
         LET l_wc = l_wc CLIPPED," AND indc199 in ('3','7')"
         LET g_wc = g_wc CLIPPED," AND indc199 in ('3','7')"
        #mod by tangyi 161010-end 
         
      #151204-00007#10 151228 By pomelo add(S)
      WHEN '4'    #普通商品移倉
         LET l_wc = l_wc CLIPPED," AND indc199 = '4'"
         LET g_wc = g_wc CLIPPED," AND indc199 = '4'"
         
      WHEN '5'    #生鮮商品移倉
         LET l_wc = l_wc CLIPPED," AND indc199 = '5'"
         LET g_wc = g_wc CLIPPED," AND indc199 = '5'"
         
      WHEN '6'    #贈品商品移倉
         LET l_wc = l_wc CLIPPED," AND indc199 = '6'"
         LET g_wc = g_wc CLIPPED," AND indc199 = '6'"
      #151204-00007#10 151228 By pomelo add(E)
   END CASE
   #150127-00004#13 15/03/17 By pomelo add(e)
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT indcdocno ",
                      " FROM indc_t ",
                      " ",
                      " LEFT JOIN indd_t ON inddent = indcent AND indcdocno = indddocno ", "  ",
                      #add-point:browser_fill段sql(indd_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN indl_t ON indlent = indcent AND indcdocno = indldocno", "  ",
                      #add-point:browser_fill段sql(indl_t1) name="browser_fill.cnt.join.indl_t1"
                      " LEFT JOIN imaa_t ON imaaent = inddent AND indd002 = imaa001 ", #161216-00033#1 20161216 add by geza
                      " LEFT JOIN rtaw_t ON rtawent = inddent AND rtaw002 = imaa009 AND rtaw003 = '1' ", #161216-00033#1 20161216 add by geza
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE indcent = " ||g_enterprise|| " AND inddent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("indc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT indcdocno ",
                      " FROM indc_t ", 
                      "  ",
                      "  ",
                      " WHERE indcent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("indc_t")
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
      INITIALIZE g_indc_m.* TO NULL
      CALL g_indd_d.clear()        
      CALL g_indd2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.indcsite,t0.indcdocdt,t0.indcdocno,t0.indc001,t0.indc004,t0.indcunit,t0.indc002,t0.indc003,t0.indc005,t0.indc006,t0.indc007,t0.indc021,t0.indc022,t0.indc023,t0.indc024,t0.indc008 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.indcstus,t0.indcsite,t0.indcdocdt,t0.indcdocno,t0.indc001,t0.indc004, 
          t0.indcunit,t0.indc002,t0.indc003,t0.indc005,t0.indc006,t0.indc007,t0.indc021,t0.indc022,t0.indc023, 
          t0.indc024,t0.indc008,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooefl003 ,t5.inayl003 ,t6.ooag011 , 
          t7.ooag011 ",
                  " FROM indc_t t0",
                  "  ",
                  "  LEFT JOIN indd_t ON inddent = indcent AND indcdocno = indddocno ", "  ", 
                  #add-point:browser_fill段sql(indd_t1) name="browser_fill.join.indd_t1"
                  
                  #end add-point
                  "  LEFT JOIN indl_t ON indlent = indcent AND indcdocno = indldocno", "  ", 
                  #add-point:browser_fill段sql(indl_t1) name="browser_fill.join.indl_t1"
                  " LEFT JOIN imaa_t ON imaaent = inddent AND indd002 = imaa001 ", "  ", #161216-00033#1 20161216 add by geza
                  " LEFT JOIN rtaw_t ON rtawent = inddent AND rtaw002 = imaa009 AND rtaw003 = '1' ",  #161216-00033#1 20161216 add by geza
                      
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.indcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.indc004  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.indc005 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.indc006 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t5 ON t5.inaylent="||g_enterprise||" AND t5.inayl001=t0.indc007 AND t5.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.indc021  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.indc023  ",
 
                  " WHERE t0.indcent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("indc_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.indcstus,t0.indcsite,t0.indcdocdt,t0.indcdocno,t0.indc001,t0.indc004, 
          t0.indcunit,t0.indc002,t0.indc003,t0.indc005,t0.indc006,t0.indc007,t0.indc021,t0.indc022,t0.indc023, 
          t0.indc024,t0.indc008,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooefl003 ,t5.inayl003 ,t6.ooag011 , 
          t7.ooag011 ",
                  " FROM indc_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.indcsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.indc004  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.indc005 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.indc006 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t5 ON t5.inaylent="||g_enterprise||" AND t5.inayl001=t0.indc007 AND t5.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.indc021  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.indc023  ",
 
                  " WHERE t0.indcent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("indc_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY indcdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
            
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"indc_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
            
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_indcsite,g_browser[g_cnt].b_indcdocdt, 
          g_browser[g_cnt].b_indcdocno,g_browser[g_cnt].b_indc001,g_browser[g_cnt].b_indc004,g_browser[g_cnt].b_indcunit, 
          g_browser[g_cnt].b_indc002,g_browser[g_cnt].b_indc003,g_browser[g_cnt].b_indc005,g_browser[g_cnt].b_indc006, 
          g_browser[g_cnt].b_indc007,g_browser[g_cnt].b_indc021,g_browser[g_cnt].b_indc022,g_browser[g_cnt].b_indc023, 
          g_browser[g_cnt].b_indc024,g_browser[g_cnt].b_indc008,g_browser[g_cnt].b_indcsite_desc,g_browser[g_cnt].b_indc004_desc, 
          g_browser[g_cnt].b_indc005_desc,g_browser[g_cnt].b_indc006_desc,g_browser[g_cnt].b_indc007_desc, 
          g_browser[g_cnt].b_indc021_desc,g_browser[g_cnt].b_indc023_desc
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
         CALL aint510_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
         WHEN "C"
            LET g_browser[g_cnt].b_statepic = "stus/16/closed.png"
         WHEN "O"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirm_transfer_out.png"
         WHEN "P"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirm_transfer_in.png"
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
   
   IF cl_null(g_browser[g_cnt].b_indcdocno) THEN
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
 
{<section id="aint510.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aint510_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
            
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_indc_m.indcdocno = g_browser[g_current_idx].b_indcdocno   
 
   EXECUTE aint510_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcsite,g_indc_m.indcdocdt, 
       g_indc_m.indcdocno,g_indc_m.indc001,g_indc_m.indc004,g_indc_m.indc101,g_indc_m.indcunit,g_indc_m.indc199, 
       g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026,g_indc_m.indc025, 
       g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc007,g_indc_m.indc008, 
       g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024,g_indc_m.indcownid, 
       g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt,g_indc_m.indcmodid, 
       g_indc_m.indcmoddt,g_indc_m.indccnfid,g_indc_m.indccnfdt,g_indc_m.indcsite_desc,g_indc_m.indc004_desc, 
       g_indc_m.indc101_desc,g_indc_m.indc200_desc,g_indc_m.indc201_desc,g_indc_m.indc005_desc,g_indc_m.indc006_desc, 
       g_indc_m.indc007_desc,g_indc_m.indc021_desc,g_indc_m.indc023_desc,g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc, 
       g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc,g_indc_m.indcmodid_desc,g_indc_m.indccnfid_desc 
 
   
   CALL aint510_indc_t_mask()
   CALL aint510_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aint510.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aint510_ui_detailshow()
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
 
{<section id="aint510.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint510_ui_browser_refresh()
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
      IF g_browser[l_i].b_indcdocno = g_indc_m.indcdocno 
 
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
 
{<section id="aint510.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint510_construct()
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
   DEFINE l_sys1        LIKE type_t.chr80       #组织间调拨是否启用在途
   DEFINE l_sys2        LIKE type_t.chr80       #组织内调拨是否启用在途
   DEFINE l_sys3        LIKE type_t.chr80       #在途仓归属 1.拨出 2.拨入
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_indc_m.* TO NULL
   CALL g_indd_d.clear()        
   CALL g_indd2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL aint510_set_combo('q')
   #取参数
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys1
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0014') RETURNING l_sys2
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0015') RETURNING l_sys3
   IF l_sys1 = 'N' AND l_sys2 = 'N' THEN
      CALL cl_set_comp_visible("indc007,indc007_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("indc007,indc007_desc",TRUE)
   END IF
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON indcsite,indcdocdt,indcdocno,indc001,indc004,indc101,indcunit,indc199, 
          indc000,indc202,indc002,indc003,indc026,indc025,indc200,indc201,indc005,indc006,indc007,indc008, 
          indcstus,indc021,indc022,indc023,indc024,indcownid,indcowndp,indccrtid,indccrtdp,indccrtdt, 
          indcmodid,indcmoddt,indccnfid,indccnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                                                
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<indccrtdt>>----
         AFTER FIELD indccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<indcmoddt>>----
         AFTER FIELD indcmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<indccnfdt>>----
         AFTER FIELD indccnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<indcpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.indcsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcsite
            #add-point:ON ACTION controlp INFIELD indcsite name="construct.c.indcsite"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indcsite  #顯示到畫面上

            NEXT FIELD indcsite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcsite
            #add-point:BEFORE FIELD indcsite name="construct.b.indcsite"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcsite
            
            #add-point:AFTER FIELD indcsite name="construct.a.indcsite"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcdocdt
            #add-point:BEFORE FIELD indcdocdt name="construct.b.indcdocdt"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcdocdt
            
            #add-point:AFTER FIELD indcdocdt name="construct.a.indcdocdt"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indcdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcdocdt
            #add-point:ON ACTION controlp INFIELD indcdocdt name="construct.c.indcdocdt"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcdocno
            #add-point:ON ACTION controlp INFIELD indcdocno name="construct.c.indcdocno"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " indcsite = '",g_site,"' "
            CALL q_indcdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indcdocno  #顯示到畫面上

            NEXT FIELD indcdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcdocno
            #add-point:BEFORE FIELD indcdocno name="construct.b.indcdocno"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcdocno
            
            #add-point:AFTER FIELD indcdocno name="construct.a.indcdocno"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc001
            #add-point:ON ACTION controlp INFIELD indc001 name="construct.c.indc001"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_indc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc001  #顯示到畫面上

            NEXT FIELD indc001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc001
            #add-point:BEFORE FIELD indc001 name="construct.b.indc001"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc001
            
            #add-point:AFTER FIELD indc001 name="construct.a.indc001"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc004
            #add-point:ON ACTION controlp INFIELD indc004 name="construct.c.indc004"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc004  #顯示到畫面上

            NEXT FIELD indc004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc004
            #add-point:BEFORE FIELD indc004 name="construct.b.indc004"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc004
            
            #add-point:AFTER FIELD indc004 name="construct.a.indc004"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc101
            #add-point:ON ACTION controlp INFIELD indc101 name="construct.c.indc101"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc101  #顯示到畫面上            
            NEXT FIELD indc101                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc101
            #add-point:BEFORE FIELD indc101 name="construct.b.indc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc101
            
            #add-point:AFTER FIELD indc101 name="construct.a.indc101"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcunit
            #add-point:BEFORE FIELD indcunit name="construct.b.indcunit"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcunit
            
            #add-point:AFTER FIELD indcunit name="construct.a.indcunit"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indcunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcunit
            #add-point:ON ACTION controlp INFIELD indcunit name="construct.c.indcunit"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc199
            #add-point:BEFORE FIELD indc199 name="construct.b.indc199"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc199
            
            #add-point:AFTER FIELD indc199 name="construct.a.indc199"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc199
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc199
            #add-point:ON ACTION controlp INFIELD indc199 name="construct.c.indc199"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc000
            #add-point:BEFORE FIELD indc000 name="construct.b.indc000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc000
            
            #add-point:AFTER FIELD indc000 name="construct.a.indc000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc000
            #add-point:ON ACTION controlp INFIELD indc000 name="construct.c.indc000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc202
            #add-point:BEFORE FIELD indc202 name="construct.b.indc202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc202
            
            #add-point:AFTER FIELD indc202 name="construct.a.indc202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc202
            #add-point:ON ACTION controlp INFIELD indc202 name="construct.c.indc202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc002
            #add-point:BEFORE FIELD indc002 name="construct.b.indc002"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc002
            
            #add-point:AFTER FIELD indc002 name="construct.a.indc002"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc002
            #add-point:ON ACTION controlp INFIELD indc002 name="construct.c.indc002"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc003
            #add-point:ON ACTION controlp INFIELD indc003 name="construct.c.indc003"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #150127-00004#13 15/03/17 By pomelo add-----------(S)
			   CASE g_argv[1]
			      WHEN '1'   #aint511
			         LET g_qryparam.where = " indc199 = '1'"
			      WHEN '2'   #aint511
			         LET g_qryparam.where = " indc199 = '2'"
			      WHEN '3'   #aint513
			         LET g_qryparam.where = " indc199 = '3'"
			   END CASE
			   #150127-00004#13 15/03/17 By pomelo add-----------(E)
            CALL q_indc003()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc003  #顯示到畫面上

            NEXT FIELD indc003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc003
            #add-point:BEFORE FIELD indc003 name="construct.b.indc003"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc003
            
            #add-point:AFTER FIELD indc003 name="construct.a.indc003"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc026
            #add-point:BEFORE FIELD indc026 name="construct.b.indc026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc026
            
            #add-point:AFTER FIELD indc026 name="construct.a.indc026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc026
            #add-point:ON ACTION controlp INFIELD indc026 name="construct.c.indc026"
            
            #END add-point
 
 
         #Ctrlp:construct.c.indc025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc025
            #add-point:ON ACTION controlp INFIELD indc025 name="construct.c.indc025"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CASE g_argv[1]
			      WHEN '1'   #aint511
			         LET g_qryparam.where = " indc199 = '1'"
			      WHEN '2'   #aint511
			         LET g_qryparam.where = " indc199 = '2'"
			      WHEN '3'   #aint513
			         LET g_qryparam.where = " indc199 = '3'"
			   END CASE
            CALL q_indc025()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc025  #顯示到畫面上
            NEXT FIELD indc025                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc025
            #add-point:BEFORE FIELD indc025 name="construct.b.indc025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc025
            
            #add-point:AFTER FIELD indc025 name="construct.a.indc025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc200
            #add-point:ON ACTION controlp INFIELD indc200 name="construct.c.indc200"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc200  #顯示到畫面上
            NEXT FIELD indc200                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc200
            #add-point:BEFORE FIELD indc200 name="construct.b.indc200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc200
            
            #add-point:AFTER FIELD indc200 name="construct.a.indc200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc201
            #add-point:ON ACTION controlp INFIELD indc201 name="construct.c.indc201"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc201  #顯示到畫面上
            NEXT FIELD indc201                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc201
            #add-point:BEFORE FIELD indc201 name="construct.b.indc201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc201
            
            #add-point:AFTER FIELD indc201 name="construct.a.indc201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc005
            #add-point:ON ACTION controlp INFIELD indc005 name="construct.c.indc005"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc005  #顯示到畫面上

            NEXT FIELD indc005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc005
            #add-point:BEFORE FIELD indc005 name="construct.b.indc005"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc005
            
            #add-point:AFTER FIELD indc005 name="construct.a.indc005"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc006
            #add-point:ON ACTION controlp INFIELD indc006 name="construct.c.indc006"
                                                            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc006  #顯示到畫面上
            NEXT FIELD indc006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc006
            #add-point:BEFORE FIELD indc006 name="construct.b.indc006"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc006
            
            #add-point:AFTER FIELD indc006 name="construct.a.indc006"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc007
            #add-point:ON ACTION controlp INFIELD indc007 name="construct.c.indc007"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc007  #顯示到畫面上
            NEXT FIELD indc007                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc007
            #add-point:BEFORE FIELD indc007 name="construct.b.indc007"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc007
            
            #add-point:AFTER FIELD indc007 name="construct.a.indc007"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc008
            #add-point:BEFORE FIELD indc008 name="construct.b.indc008"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc008
            
            #add-point:AFTER FIELD indc008 name="construct.a.indc008"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc008
            #add-point:ON ACTION controlp INFIELD indc008 name="construct.c.indc008"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcstus
            #add-point:BEFORE FIELD indcstus name="construct.b.indcstus"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcstus
            
            #add-point:AFTER FIELD indcstus name="construct.a.indcstus"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcstus
            #add-point:ON ACTION controlp INFIELD indcstus name="construct.c.indcstus"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indc021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc021
            #add-point:ON ACTION controlp INFIELD indc021 name="construct.c.indc021"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc021  #顯示到畫面上

            NEXT FIELD indc021                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc021
            #add-point:BEFORE FIELD indc021 name="construct.b.indc021"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc021
            
            #add-point:AFTER FIELD indc021 name="construct.a.indc021"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc022
            #add-point:BEFORE FIELD indc022 name="construct.b.indc022"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc022
            
            #add-point:AFTER FIELD indc022 name="construct.a.indc022"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc022
            #add-point:ON ACTION controlp INFIELD indc022 name="construct.c.indc022"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indc023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc023
            #add-point:ON ACTION controlp INFIELD indc023 name="construct.c.indc023"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc023  #顯示到畫面上

            NEXT FIELD indc023                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc023
            #add-point:BEFORE FIELD indc023 name="construct.b.indc023"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc023
            
            #add-point:AFTER FIELD indc023 name="construct.a.indc023"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc024
            #add-point:BEFORE FIELD indc024 name="construct.b.indc024"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc024
            
            #add-point:AFTER FIELD indc024 name="construct.a.indc024"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc024
            #add-point:ON ACTION controlp INFIELD indc024 name="construct.c.indc024"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indcownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcownid
            #add-point:ON ACTION controlp INFIELD indcownid name="construct.c.indcownid"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indcownid  #顯示到畫面上

            NEXT FIELD indcownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcownid
            #add-point:BEFORE FIELD indcownid name="construct.b.indcownid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcownid
            
            #add-point:AFTER FIELD indcownid name="construct.a.indcownid"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indcowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcowndp
            #add-point:ON ACTION controlp INFIELD indcowndp name="construct.c.indcowndp"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indcowndp  #顯示到畫面上

            NEXT FIELD indcowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcowndp
            #add-point:BEFORE FIELD indcowndp name="construct.b.indcowndp"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcowndp
            
            #add-point:AFTER FIELD indcowndp name="construct.a.indcowndp"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indccrtid
            #add-point:ON ACTION controlp INFIELD indccrtid name="construct.c.indccrtid"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indccrtid  #顯示到畫面上

            NEXT FIELD indccrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indccrtid
            #add-point:BEFORE FIELD indccrtid name="construct.b.indccrtid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indccrtid
            
            #add-point:AFTER FIELD indccrtid name="construct.a.indccrtid"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indccrtdp
            #add-point:ON ACTION controlp INFIELD indccrtdp name="construct.c.indccrtdp"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indccrtdp  #顯示到畫面上

            NEXT FIELD indccrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indccrtdp
            #add-point:BEFORE FIELD indccrtdp name="construct.b.indccrtdp"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indccrtdp
            
            #add-point:AFTER FIELD indccrtdp name="construct.a.indccrtdp"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indccrtdt
            #add-point:BEFORE FIELD indccrtdt name="construct.b.indccrtdt"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indcmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcmodid
            #add-point:ON ACTION controlp INFIELD indcmodid name="construct.c.indcmodid"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indcmodid  #顯示到畫面上

            NEXT FIELD indcmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcmodid
            #add-point:BEFORE FIELD indcmodid name="construct.b.indcmodid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcmodid
            
            #add-point:AFTER FIELD indcmodid name="construct.a.indcmodid"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcmoddt
            #add-point:BEFORE FIELD indcmoddt name="construct.b.indcmoddt"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indccnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indccnfid
            #add-point:ON ACTION controlp INFIELD indccnfid name="construct.c.indccnfid"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indccnfid  #顯示到畫面上

            NEXT FIELD indccnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indccnfid
            #add-point:BEFORE FIELD indccnfid name="construct.b.indccnfid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indccnfid
            
            #add-point:AFTER FIELD indccnfid name="construct.a.indccnfid"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indccnfdt
            #add-point:BEFORE FIELD indccnfdt name="construct.b.indccnfdt"
                                                
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON inddsite,inddunit,inddseq,indd001,indd047,indd048,indd003,indd002,indd004, 
          imaa154,imaa133,imaa156,imaa132,imaa132_desc,rtaw001,imaa128_desc,imaa009,imaa009_desc,imaa157, 
          indd006,indd005,indd007,indd008,indd009,indd020,indd021,indd045,indd046,indd010,indd022,indd023, 
          indd024,indd102,indd025,indd030,indd031,indd032,indd033,indd034,indd035,indd040,indd101
           FROM s_detail1[1].inddsite,s_detail1[1].inddunit,s_detail1[1].inddseq,s_detail1[1].indd001, 
               s_detail1[1].indd047,s_detail1[1].indd048,s_detail1[1].indd003,s_detail1[1].indd002,s_detail1[1].indd004, 
               s_detail1[1].imaa154,s_detail1[1].imaa133,s_detail1[1].imaa156,s_detail1[1].imaa132,s_detail1[1].imaa132_desc, 
               s_detail1[1].rtaw001,s_detail1[1].imaa128_desc,s_detail1[1].imaa009,s_detail1[1].imaa009_desc, 
               s_detail1[1].imaa157,s_detail1[1].indd006,s_detail1[1].indd005,s_detail1[1].indd007,s_detail1[1].indd008, 
               s_detail1[1].indd009,s_detail1[1].indd020,s_detail1[1].indd021,s_detail1[1].indd045,s_detail1[1].indd046, 
               s_detail1[1].indd010,s_detail1[1].indd022,s_detail1[1].indd023,s_detail1[1].indd024,s_detail1[1].indd102, 
               s_detail1[1].indd025,s_detail1[1].indd030,s_detail1[1].indd031,s_detail1[1].indd032,s_detail1[1].indd033, 
               s_detail1[1].indd034,s_detail1[1].indd035,s_detail1[1].indd040,s_detail1[1].indd101
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            DISPLAY '' TO s_detail1[1].inddsite   #161017-00051#19 20161205 add by beckxie                      
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inddsite
            #add-point:BEFORE FIELD inddsite name="construct.b.page1.inddsite"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inddsite
            
            #add-point:AFTER FIELD inddsite name="construct.a.page1.inddsite"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inddsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inddsite
            #add-point:ON ACTION controlp INFIELD inddsite name="construct.c.page1.inddsite"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inddunit
            #add-point:BEFORE FIELD inddunit name="construct.b.page1.inddunit"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inddunit
            
            #add-point:AFTER FIELD inddunit name="construct.a.page1.inddunit"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inddunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inddunit
            #add-point:ON ACTION controlp INFIELD inddunit name="construct.c.page1.inddunit"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inddseq
            #add-point:BEFORE FIELD inddseq name="construct.b.page1.inddseq"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inddseq
            
            #add-point:AFTER FIELD inddseq name="construct.a.page1.inddseq"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inddseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inddseq
            #add-point:ON ACTION controlp INFIELD inddseq name="construct.c.page1.inddseq"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd001
            #add-point:BEFORE FIELD indd001 name="construct.b.page1.indd001"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd001
            
            #add-point:AFTER FIELD indd001 name="construct.a.page1.indd001"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd001
            #add-point:ON ACTION controlp INFIELD indd001 name="construct.c.page1.indd001"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd047
            #add-point:BEFORE FIELD indd047 name="construct.b.page1.indd047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd047
            
            #add-point:AFTER FIELD indd047 name="construct.a.page1.indd047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd047
            #add-point:ON ACTION controlp INFIELD indd047 name="construct.c.page1.indd047"
            #161017-00051#19 20161205 add by beckxie---S
            
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #150127-00004#13 15/03/17 By pomelo add-----------(S)
			   CASE g_argv[1]
			      WHEN '1'   #aint511
			         LET g_qryparam.where = " indc199 = '1'"
			      WHEN '2'   #aint511
			         LET g_qryparam.where = " indc199 = '2'"
			      WHEN '3'   #aint513
			         LET g_qryparam.where = " indc199 = '3'"
			   END CASE
			   #150127-00004#13 15/03/17 By pomelo add-----------(E)
            CALL q_indc003()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd047  #顯示到畫面上

            NEXT FIELD indd047                     #返回原欄位
            
            #161017-00051#19 20161205 add by beckxie---E
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd048
            #add-point:BEFORE FIELD indd048 name="construct.b.page1.indd048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd048
            
            #add-point:AFTER FIELD indd048 name="construct.a.page1.indd048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd048
            #add-point:ON ACTION controlp INFIELD indd048 name="construct.c.page1.indd048"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.indd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd003
            #add-point:ON ACTION controlp INFIELD indd003 name="construct.c.page1.indd003"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd003  #顯示到畫面上

            NEXT FIELD indd003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd003
            #add-point:BEFORE FIELD indd003 name="construct.b.page1.indd003"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd003
            
            #add-point:AFTER FIELD indd003 name="construct.a.page1.indd003"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd002
            #add-point:ON ACTION controlp INFIELD indd002 name="construct.c.page1.indd002"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imay001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd002  #顯示到畫面上

            NEXT FIELD indd002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd002
            #add-point:BEFORE FIELD indd002 name="construct.b.page1.indd002"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd002
            
            #add-point:AFTER FIELD indd002 name="construct.a.page1.indd002"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd004
            #add-point:BEFORE FIELD indd004 name="construct.b.page1.indd004"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd004
            
            #add-point:AFTER FIELD indd004 name="construct.a.page1.indd004"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd004
            #add-point:ON ACTION controlp INFIELD indd004 name="construct.c.page1.indd004"
            #161017-00051#19 20161205 add by beckxie---S
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_indj005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd004  #顯示到畫面上

            NEXT FIELD indd004                     #返回原欄位

            #161017-00051#19 20161205 add by beckxie---E
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa154
            #add-point:BEFORE FIELD imaa154 name="construct.b.page1.imaa154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa154
            
            #add-point:AFTER FIELD imaa154 name="construct.a.page1.imaa154"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa154
            #add-point:ON ACTION controlp INFIELD imaa154 name="construct.c.page1.imaa154"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa133
            #add-point:BEFORE FIELD imaa133 name="construct.b.page1.imaa133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa133
            
            #add-point:AFTER FIELD imaa133 name="construct.a.page1.imaa133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa133
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa133
            #add-point:ON ACTION controlp INFIELD imaa133 name="construct.c.page1.imaa133"
            #161216-00033#1 20161216 add by geza---S
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2007" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa133  #顯示到畫面上

            NEXT FIELD imaa133       
            #161216-00033#1 20161216 add by geza---S   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa156
            #add-point:BEFORE FIELD imaa156 name="construct.b.page1.imaa156"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa156
            
            #add-point:AFTER FIELD imaa156 name="construct.a.page1.imaa156"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa156
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa156
            #add-point:ON ACTION controlp INFIELD imaa156 name="construct.c.page1.imaa156"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa132
            #add-point:BEFORE FIELD imaa132 name="construct.b.page1.imaa132"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa132
            
            #add-point:AFTER FIELD imaa132 name="construct.a.page1.imaa132"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa132
            #add-point:ON ACTION controlp INFIELD imaa132 name="construct.c.page1.imaa132"
            #161017-00051#19 20161205 add by beckxie---S
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaa132()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa132  #顯示到畫面上

            NEXT FIELD imaa132                     #返回原欄位

            #161017-00051#19 20161205 add by beckxie---E
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa132_desc
            #add-point:BEFORE FIELD imaa132_desc name="construct.b.page1.imaa132_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa132_desc
            
            #add-point:AFTER FIELD imaa132_desc name="construct.a.page1.imaa132_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa132_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa132_desc
            #add-point:ON ACTION controlp INFIELD imaa132_desc name="construct.c.page1.imaa132_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaw001
            #add-point:BEFORE FIELD rtaw001 name="construct.b.page1.rtaw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaw001
            
            #add-point:AFTER FIELD rtaw001 name="construct.a.page1.rtaw001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtaw001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaw001
            #add-point:ON ACTION controlp INFIELD rtaw001 name="construct.c.page1.rtaw001"
            #161216-00033#1 20161216 add by geza---S
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_rtax001_3()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaw001  #顯示到畫面上

            NEXT FIELD rtaw001
            #161216-00033#1 20161216 add by geza---S            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa128_desc
            #add-point:BEFORE FIELD imaa128_desc name="construct.b.page1.imaa128_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa128_desc
            
            #add-point:AFTER FIELD imaa128_desc name="construct.a.page1.imaa128_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa128_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa128_desc
            #add-point:ON ACTION controlp INFIELD imaa128_desc name="construct.c.page1.imaa128_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="construct.b.page1.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="construct.a.page1.imaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.page1.imaa009"
                        #161017-00051#19 20161205 add by beckxie---S
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaa009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

            NEXT FIELD imaa009                     #返回原欄位

            #161017-00051#19 20161205 add by beckxie---E
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009_desc
            #add-point:BEFORE FIELD imaa009_desc name="construct.b.page1.imaa009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009_desc
            
            #add-point:AFTER FIELD imaa009_desc name="construct.a.page1.imaa009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009_desc
            #add-point:ON ACTION controlp INFIELD imaa009_desc name="construct.c.page1.imaa009_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa157
            #add-point:BEFORE FIELD imaa157 name="construct.b.page1.imaa157"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa157
            
            #add-point:AFTER FIELD imaa157 name="construct.a.page1.imaa157"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa157
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa157
            #add-point:ON ACTION controlp INFIELD imaa157 name="construct.c.page1.imaa157"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.indd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd006
            #add-point:ON ACTION controlp INFIELD indd006 name="construct.c.page1.indd006"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd006  #顯示到畫面上

            NEXT FIELD indd006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd006
            #add-point:BEFORE FIELD indd006 name="construct.b.page1.indd006"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd006
            
            #add-point:AFTER FIELD indd006 name="construct.a.page1.indd006"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd005
            #add-point:BEFORE FIELD indd005 name="construct.b.page1.indd005"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd005
            
            #add-point:AFTER FIELD indd005 name="construct.a.page1.indd005"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd005
            #add-point:ON ACTION controlp INFIELD indd005 name="construct.c.page1.indd005"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.page1.indd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd007
            #add-point:ON ACTION controlp INFIELD indd007 name="construct.c.page1.indd007"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd007  #顯示到畫面上

            NEXT FIELD indd007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd007
            #add-point:BEFORE FIELD indd007 name="construct.b.page1.indd007"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd007
            
            #add-point:AFTER FIELD indd007 name="construct.a.page1.indd007"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd008
            #add-point:BEFORE FIELD indd008 name="construct.b.page1.indd008"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd008
            
            #add-point:AFTER FIELD indd008 name="construct.a.page1.indd008"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd008
            #add-point:ON ACTION controlp INFIELD indd008 name="construct.c.page1.indd008"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd009
            #add-point:BEFORE FIELD indd009 name="construct.b.page1.indd009"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd009
            
            #add-point:AFTER FIELD indd009 name="construct.a.page1.indd009"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd009
            #add-point:ON ACTION controlp INFIELD indd009 name="construct.c.page1.indd009"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd020
            #add-point:BEFORE FIELD indd020 name="construct.b.page1.indd020"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd020
            
            #add-point:AFTER FIELD indd020 name="construct.a.page1.indd020"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd020
            #add-point:ON ACTION controlp INFIELD indd020 name="construct.c.page1.indd020"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd021
            #add-point:BEFORE FIELD indd021 name="construct.b.page1.indd021"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd021
            
            #add-point:AFTER FIELD indd021 name="construct.a.page1.indd021"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd021
            #add-point:ON ACTION controlp INFIELD indd021 name="construct.c.page1.indd021"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd045
            #add-point:BEFORE FIELD indd045 name="construct.b.page1.indd045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd045
            
            #add-point:AFTER FIELD indd045 name="construct.a.page1.indd045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd045
            #add-point:ON ACTION controlp INFIELD indd045 name="construct.c.page1.indd045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd046
            #add-point:BEFORE FIELD indd046 name="construct.b.page1.indd046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd046
            
            #add-point:AFTER FIELD indd046 name="construct.a.page1.indd046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd046
            #add-point:ON ACTION controlp INFIELD indd046 name="construct.c.page1.indd046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd010
            #add-point:BEFORE FIELD indd010 name="construct.b.page1.indd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd010
            
            #add-point:AFTER FIELD indd010 name="construct.a.page1.indd010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd010
            #add-point:ON ACTION controlp INFIELD indd010 name="construct.c.page1.indd010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.indd022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd022
            #add-point:ON ACTION controlp INFIELD indd022 name="construct.c.page1.indd022"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd022  #顯示到畫面上

            NEXT FIELD indd022                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd022
            #add-point:BEFORE FIELD indd022 name="construct.b.page1.indd022"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd022
            
            #add-point:AFTER FIELD indd022 name="construct.a.page1.indd022"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd023
            #add-point:ON ACTION controlp INFIELD indd023 name="construct.c.page1.indd023"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_indd023()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd023  #顯示到畫面上

            NEXT FIELD indd023                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd023
            #add-point:BEFORE FIELD indd023 name="construct.b.page1.indd023"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd023
            
            #add-point:AFTER FIELD indd023 name="construct.a.page1.indd023"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd024
            #add-point:ON ACTION controlp INFIELD indd024 name="construct.c.page1.indd024"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inai006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd024  #顯示到畫面上

            NEXT FIELD indd024                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd024
            #add-point:BEFORE FIELD indd024 name="construct.b.page1.indd024"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd024
            
            #add-point:AFTER FIELD indd024 name="construct.a.page1.indd024"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd102
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd102
            #add-point:ON ACTION controlp INFIELD indd102 name="construct.c.page1.indd102"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_18()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd102  #顯示到畫面上
            NEXT FIELD indd102                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd102
            #add-point:BEFORE FIELD indd102 name="construct.b.page1.indd102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd102
            
            #add-point:AFTER FIELD indd102 name="construct.a.page1.indd102"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd025
            #add-point:BEFORE FIELD indd025 name="construct.b.page1.indd025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd025
            
            #add-point:AFTER FIELD indd025 name="construct.a.page1.indd025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd025
            #add-point:ON ACTION controlp INFIELD indd025 name="construct.c.page1.indd025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd030
            #add-point:BEFORE FIELD indd030 name="construct.b.page1.indd030"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd030
            
            #add-point:AFTER FIELD indd030 name="construct.a.page1.indd030"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd030
            #add-point:ON ACTION controlp INFIELD indd030 name="construct.c.page1.indd030"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd031
            #add-point:BEFORE FIELD indd031 name="construct.b.page1.indd031"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd031
            
            #add-point:AFTER FIELD indd031 name="construct.a.page1.indd031"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd031
            #add-point:ON ACTION controlp INFIELD indd031 name="construct.c.page1.indd031"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.page1.indd032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd032
            #add-point:ON ACTION controlp INFIELD indd032 name="construct.c.page1.indd032"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd032  #顯示到畫面上

            NEXT FIELD indd032                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd032
            #add-point:BEFORE FIELD indd032 name="construct.b.page1.indd032"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd032
            
            #add-point:AFTER FIELD indd032 name="construct.a.page1.indd032"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd033
            #add-point:ON ACTION controlp INFIELD indd033 name="construct.c.page1.indd033"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_indd033()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd033  #顯示到畫面上

            NEXT FIELD indd033                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd033
            #add-point:BEFORE FIELD indd033 name="construct.b.page1.indd033"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd033
            
            #add-point:AFTER FIELD indd033 name="construct.a.page1.indd033"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd034
            #add-point:ON ACTION controlp INFIELD indd034 name="construct.c.page1.indd034"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inai006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd034  #顯示到畫面上

            NEXT FIELD indd034                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd034
            #add-point:BEFORE FIELD indd034 name="construct.b.page1.indd034"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd034
            
            #add-point:AFTER FIELD indd034 name="construct.a.page1.indd034"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd035
            #add-point:BEFORE FIELD indd035 name="construct.b.page1.indd035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd035
            
            #add-point:AFTER FIELD indd035 name="construct.a.page1.indd035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd035
            #add-point:ON ACTION controlp INFIELD indd035 name="construct.c.page1.indd035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd040
            #add-point:BEFORE FIELD indd040 name="construct.b.page1.indd040"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd040
            
            #add-point:AFTER FIELD indd040 name="construct.a.page1.indd040"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd040
            #add-point:ON ACTION controlp INFIELD indd040 name="construct.c.page1.indd040"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd101
            #add-point:BEFORE FIELD indd101 name="construct.b.page1.indd101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd101
            
            #add-point:AFTER FIELD indd101 name="construct.a.page1.indd101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd101
            #add-point:ON ACTION controlp INFIELD indd101 name="construct.c.page1.indd101"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON indlseq,indlseq1,indl001,indl002,indl003,indl004,indl005,indl022,indl023, 
          indl024,indl101,indl020,indl021,indl102,indl103,indl032,indl033,indl034,indl030,indl031
           FROM s_detail2[1].indlseq,s_detail2[1].indlseq1,s_detail2[1].indl001,s_detail2[1].indl002, 
               s_detail2[1].indl003,s_detail2[1].indl004,s_detail2[1].indl005,s_detail2[1].indl022,s_detail2[1].indl023, 
               s_detail2[1].indl024,s_detail2[1].indl101,s_detail2[1].indl020,s_detail2[1].indl021,s_detail2[1].indl102, 
               s_detail2[1].indl103,s_detail2[1].indl032,s_detail2[1].indl033,s_detail2[1].indl034,s_detail2[1].indl030, 
               s_detail2[1].indl031
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indlseq
            #add-point:BEFORE FIELD indlseq name="construct.b.page2.indlseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indlseq
            
            #add-point:AFTER FIELD indlseq name="construct.a.page2.indlseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indlseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indlseq
            #add-point:ON ACTION controlp INFIELD indlseq name="construct.c.page2.indlseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indlseq1
            #add-point:BEFORE FIELD indlseq1 name="construct.b.page2.indlseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indlseq1
            
            #add-point:AFTER FIELD indlseq1 name="construct.a.page2.indlseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indlseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indlseq1
            #add-point:ON ACTION controlp INFIELD indlseq1 name="construct.c.page2.indlseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.indl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl001
            #add-point:ON ACTION controlp INFIELD indl001 name="construct.c.page2.indl001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indl001  #顯示到畫面上
            NEXT FIELD indl001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl001
            #add-point:BEFORE FIELD indl001 name="construct.b.page2.indl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl001
            
            #add-point:AFTER FIELD indl001 name="construct.a.page2.indl001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl002
            #add-point:BEFORE FIELD indl002 name="construct.b.page2.indl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl002
            
            #add-point:AFTER FIELD indl002 name="construct.a.page2.indl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl002
            #add-point:ON ACTION controlp INFIELD indl002 name="construct.c.page2.indl002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indl002  #顯示到畫面上
            NEXT FIELD indl002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl003
            #add-point:BEFORE FIELD indl003 name="construct.b.page2.indl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl003
            
            #add-point:AFTER FIELD indl003 name="construct.a.page2.indl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl003
            #add-point:ON ACTION controlp INFIELD indl003 name="construct.c.page2.indl003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.indl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl004
            #add-point:ON ACTION controlp INFIELD indl004 name="construct.c.page2.indl004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indl004  #顯示到畫面上
            NEXT FIELD indl004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl004
            #add-point:BEFORE FIELD indl004 name="construct.b.page2.indl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl004
            
            #add-point:AFTER FIELD indl004 name="construct.a.page2.indl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl005
            #add-point:ON ACTION controlp INFIELD indl005 name="construct.c.page2.indl005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indl005  #顯示到畫面上
            NEXT FIELD indl005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl005
            #add-point:BEFORE FIELD indl005 name="construct.b.page2.indl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl005
            
            #add-point:AFTER FIELD indl005 name="construct.a.page2.indl005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl022
            #add-point:ON ACTION controlp INFIELD indl022 name="construct.c.page2.indl022"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indl022  #顯示到畫面上
            NEXT FIELD indl022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl022
            #add-point:BEFORE FIELD indl022 name="construct.b.page2.indl022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl022
            
            #add-point:AFTER FIELD indl022 name="construct.a.page2.indl022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl023
            #add-point:ON ACTION controlp INFIELD indl023 name="construct.c.page2.indl023"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indl023  #顯示到畫面上
            NEXT FIELD indl023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl023
            #add-point:BEFORE FIELD indl023 name="construct.b.page2.indl023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl023
            
            #add-point:AFTER FIELD indl023 name="construct.a.page2.indl023"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl024
            #add-point:BEFORE FIELD indl024 name="construct.b.page2.indl024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl024
            
            #add-point:AFTER FIELD indl024 name="construct.a.page2.indl024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl024
            #add-point:ON ACTION controlp INFIELD indl024 name="construct.c.page2.indl024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl101
            #add-point:BEFORE FIELD indl101 name="construct.b.page2.indl101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl101
            
            #add-point:AFTER FIELD indl101 name="construct.a.page2.indl101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl101
            #add-point:ON ACTION controlp INFIELD indl101 name="construct.c.page2.indl101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl020
            #add-point:BEFORE FIELD indl020 name="construct.b.page2.indl020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl020
            
            #add-point:AFTER FIELD indl020 name="construct.a.page2.indl020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl020
            #add-point:ON ACTION controlp INFIELD indl020 name="construct.c.page2.indl020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl021
            #add-point:BEFORE FIELD indl021 name="construct.b.page2.indl021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl021
            
            #add-point:AFTER FIELD indl021 name="construct.a.page2.indl021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl021
            #add-point:ON ACTION controlp INFIELD indl021 name="construct.c.page2.indl021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl102
            #add-point:BEFORE FIELD indl102 name="construct.b.page2.indl102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl102
            
            #add-point:AFTER FIELD indl102 name="construct.a.page2.indl102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl102
            #add-point:ON ACTION controlp INFIELD indl102 name="construct.c.page2.indl102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl103
            #add-point:BEFORE FIELD indl103 name="construct.b.page2.indl103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl103
            
            #add-point:AFTER FIELD indl103 name="construct.a.page2.indl103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl103
            #add-point:ON ACTION controlp INFIELD indl103 name="construct.c.page2.indl103"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.indl032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl032
            #add-point:ON ACTION controlp INFIELD indl032 name="construct.c.page2.indl032"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indl032  #顯示到畫面上
            NEXT FIELD indl032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl032
            #add-point:BEFORE FIELD indl032 name="construct.b.page2.indl032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl032
            
            #add-point:AFTER FIELD indl032 name="construct.a.page2.indl032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl033
            #add-point:ON ACTION controlp INFIELD indl033 name="construct.c.page2.indl033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indl033  #顯示到畫面上
            NEXT FIELD indl033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl033
            #add-point:BEFORE FIELD indl033 name="construct.b.page2.indl033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl033
            
            #add-point:AFTER FIELD indl033 name="construct.a.page2.indl033"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl034
            #add-point:BEFORE FIELD indl034 name="construct.b.page2.indl034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl034
            
            #add-point:AFTER FIELD indl034 name="construct.a.page2.indl034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl034
            #add-point:ON ACTION controlp INFIELD indl034 name="construct.c.page2.indl034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl030
            #add-point:BEFORE FIELD indl030 name="construct.b.page2.indl030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl030
            
            #add-point:AFTER FIELD indl030 name="construct.a.page2.indl030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl030
            #add-point:ON ACTION controlp INFIELD indl030 name="construct.c.page2.indl030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indl031
            #add-point:BEFORE FIELD indl031 name="construct.b.page2.indl031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indl031
            
            #add-point:AFTER FIELD indl031 name="construct.a.page2.indl031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indl031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indl031
            #add-point:ON ACTION controlp INFIELD indl031 name="construct.c.page2.indl031"
            
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
                  WHEN la_wc[li_idx].tableid = "indc_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "indd_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "indl_t" 
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
 
{<section id="aint510.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint510_filter()
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
      CONSTRUCT g_wc_filter ON indcsite,indcdocdt,indcdocno,indc001,indc004,indcunit,indc002,indc003, 
          indc005,indc006,indc007,indc021,indc022,indc023,indc024,indc008
                          FROM s_browse[1].b_indcsite,s_browse[1].b_indcdocdt,s_browse[1].b_indcdocno, 
                              s_browse[1].b_indc001,s_browse[1].b_indc004,s_browse[1].b_indcunit,s_browse[1].b_indc002, 
                              s_browse[1].b_indc003,s_browse[1].b_indc005,s_browse[1].b_indc006,s_browse[1].b_indc007, 
                              s_browse[1].b_indc021,s_browse[1].b_indc022,s_browse[1].b_indc023,s_browse[1].b_indc024, 
                              s_browse[1].b_indc008
 
         BEFORE CONSTRUCT
               DISPLAY aint510_filter_parser('indcsite') TO s_browse[1].b_indcsite
            DISPLAY aint510_filter_parser('indcdocdt') TO s_browse[1].b_indcdocdt
            DISPLAY aint510_filter_parser('indcdocno') TO s_browse[1].b_indcdocno
            DISPLAY aint510_filter_parser('indc001') TO s_browse[1].b_indc001
            DISPLAY aint510_filter_parser('indc004') TO s_browse[1].b_indc004
            DISPLAY aint510_filter_parser('indcunit') TO s_browse[1].b_indcunit
            DISPLAY aint510_filter_parser('indc002') TO s_browse[1].b_indc002
            DISPLAY aint510_filter_parser('indc003') TO s_browse[1].b_indc003
            DISPLAY aint510_filter_parser('indc005') TO s_browse[1].b_indc005
            DISPLAY aint510_filter_parser('indc006') TO s_browse[1].b_indc006
            DISPLAY aint510_filter_parser('indc007') TO s_browse[1].b_indc007
            DISPLAY aint510_filter_parser('indc021') TO s_browse[1].b_indc021
            DISPLAY aint510_filter_parser('indc022') TO s_browse[1].b_indc022
            DISPLAY aint510_filter_parser('indc023') TO s_browse[1].b_indc023
            DISPLAY aint510_filter_parser('indc024') TO s_browse[1].b_indc024
            DISPLAY aint510_filter_parser('indc008') TO s_browse[1].b_indc008
      
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
 
      CALL aint510_filter_show('indcsite')
   CALL aint510_filter_show('indcdocdt')
   CALL aint510_filter_show('indcdocno')
   CALL aint510_filter_show('indc001')
   CALL aint510_filter_show('indc004')
   CALL aint510_filter_show('indcunit')
   CALL aint510_filter_show('indc002')
   CALL aint510_filter_show('indc003')
   CALL aint510_filter_show('indc005')
   CALL aint510_filter_show('indc006')
   CALL aint510_filter_show('indc007')
   CALL aint510_filter_show('indc021')
   CALL aint510_filter_show('indc022')
   CALL aint510_filter_show('indc023')
   CALL aint510_filter_show('indc024')
   CALL aint510_filter_show('indc008')
 
END FUNCTION
 
{</section>}
 
{<section id="aint510.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint510_filter_parser(ps_field)
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
 
{<section id="aint510.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint510_filter_show(ps_field)
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
   LET ls_condition = aint510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint510.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint510_query()
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
   CALL g_indd_d.clear()
   CALL g_indd2_d.clear()
 
   
   #add-point:query段other name="query.other"
            
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aint510_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint510_browser_fill("")
      CALL aint510_fetch("")
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
      CALL aint510_filter_show('indcsite')
   CALL aint510_filter_show('indcdocdt')
   CALL aint510_filter_show('indcdocno')
   CALL aint510_filter_show('indc001')
   CALL aint510_filter_show('indc004')
   CALL aint510_filter_show('indcunit')
   CALL aint510_filter_show('indc002')
   CALL aint510_filter_show('indc003')
   CALL aint510_filter_show('indc005')
   CALL aint510_filter_show('indc006')
   CALL aint510_filter_show('indc007')
   CALL aint510_filter_show('indc021')
   CALL aint510_filter_show('indc022')
   CALL aint510_filter_show('indc023')
   CALL aint510_filter_show('indc024')
   CALL aint510_filter_show('indc008')
   CALL aint510_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aint510_fetch("F") 
      #顯示單身筆數
      CALL aint510_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint510.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint510_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_sys1        LIKE type_t.chr80       #组织间调拨是否启用在途
   DEFINE l_sys2        LIKE type_t.chr80       #组织内调拨是否启用在途
   DEFINE l_sys3        LIKE type_t.chr80       #在途仓归属 1.拨出 2.拨入
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
   
   LET g_indc_m.indcdocno = g_browser[g_current_idx].b_indcdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aint510_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcsite,g_indc_m.indcdocdt, 
       g_indc_m.indcdocno,g_indc_m.indc001,g_indc_m.indc004,g_indc_m.indc101,g_indc_m.indcunit,g_indc_m.indc199, 
       g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026,g_indc_m.indc025, 
       g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc007,g_indc_m.indc008, 
       g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024,g_indc_m.indcownid, 
       g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt,g_indc_m.indcmodid, 
       g_indc_m.indcmoddt,g_indc_m.indccnfid,g_indc_m.indccnfdt,g_indc_m.indcsite_desc,g_indc_m.indc004_desc, 
       g_indc_m.indc101_desc,g_indc_m.indc200_desc,g_indc_m.indc201_desc,g_indc_m.indc005_desc,g_indc_m.indc006_desc, 
       g_indc_m.indc007_desc,g_indc_m.indc021_desc,g_indc_m.indc023_desc,g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc, 
       g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc,g_indc_m.indcmodid_desc,g_indc_m.indccnfid_desc 
 
   
   #遮罩相關處理
   LET g_indc_m_mask_o.* =  g_indc_m.*
   CALL aint510_indc_t_mask()
   LET g_indc_m_mask_n.* =  g_indc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint510_set_act_visible()   
   CALL aint510_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   IF g_indc_m.indcstus = 'C' OR g_indc_m.indcstus = 'O' OR g_indc_m.indcstus = 'P' OR g_indc_m.indcstus = 'X' THEN
#      CALL cl_set_act_visible("modify,delete", FALSE)
#      IF g_indc_m.indcstus <> 'O' THEN
#         CALL cl_set_act_visible("modify_detail", FALSE)
#      ELSE
#         IF g_site <> g_indc_m.indc006 THEN
#            CALL cl_set_act_visible("modify,modify_detail", FALSE)
#         ELSE
#            CALL cl_set_act_visible("modify,modify_detail", TRUE)
#         END IF
#      END IF
#   ELSE
#      IF g_site = g_indc_m.indcsite THEN
#         CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
#      ELSE
#         CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
#      END IF
#   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   CALL cl_set_comp_visible("indc007,indc007_desc",TRUE)
   IF NOT cl_null(g_indc_m.indc005) AND NOT cl_null(g_indc_m.indc006) THEN
      #取参数
      CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys1
      CALL cl_get_para(g_enterprise,g_site,'E-BAS-0014') RETURNING l_sys2
      CALL cl_get_para(g_enterprise,g_site,'E-BAS-0015') RETURNING l_sys3
      IF g_indc_m.indc005 <> g_indc_m.indc006 THEN
         IF cl_null(l_sys1) OR l_sys1 <> 'Y' THEN
            CALL cl_set_comp_visible("indc007,indc007_desc",FALSE)
         END IF
      ELSE
         IF cl_null(l_sys2) OR l_sys2 <> 'Y' THEN
            CALL cl_set_comp_visible("indc007,indc007_desc",FALSE)
         END IF
      END IF
   ELSE
      CALL cl_set_comp_visible("indc007,indc007_desc",FALSE)
   END IF
   #151204-00007#10 160125 By pomelo add(S)
   IF g_argv[01] = '0' THEN
      IF g_indc_m.indc199 MATCHES '[123]' THEN
         CALL cl_set_comp_visible("indc202",FALSE)
      ELSE
         CALL cl_set_comp_visible("indc202",TRUE)
      END IF
   END IF
   #151204-00007#10 160125 By pomelo add(E)
   #end add-point
   
   #保存單頭舊值
   LET g_indc_m_t.* = g_indc_m.*
   LET g_indc_m_o.* = g_indc_m.*
   
   LET g_data_owner = g_indc_m.indcownid      
   LET g_data_dept  = g_indc_m.indcowndp
   
   #重新顯示   
   CALL aint510_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint510.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint510_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_indd_d.clear()   
   CALL g_indd2_d.clear()  
 
 
   INITIALIZE g_indc_m.* TO NULL             #DEFAULT 設定
   
   LET g_indcdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_indc_m.indcownid = g_user
      LET g_indc_m.indcowndp = g_dept
      LET g_indc_m.indccrtid = g_user
      LET g_indc_m.indccrtdp = g_dept 
      LET g_indc_m.indccrtdt = cl_get_current()
      LET g_indc_m.indcmodid = g_user
      LET g_indc_m.indcmoddt = cl_get_current()
      LET g_indc_m.indcstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_indc_m.indc002 = "1"
      LET g_indc_m.indcstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      #150127-00004#13 15/03/17 By pomelo add(S)
      #調撥性質
      CASE g_argv[1]
         WHEN '1'  #調撥
            LET g_indc_m.indc199 = '1'
         WHEN '2'  #配送
            LET g_indc_m.indc199 = '2'
            LET g_indc_m.indc002 = '4'
         WHEN '3'  #倉退
            LET g_indc_m.indc199 = '3'
            #LET g_indc_m.indc002 = '6'   #151225-00011#1 151231 By pomelo mark
            LET g_indc_m.indc002 = '1'    #151225-00011#1 151231 By pomelo add
         #151204-00007#10 151228 By pomelo add(S)
         WHEN '4'  #普通商品移倉
            LET g_indc_m.indc199 = '4'
            LET g_indc_m.indc202 = '1'
         WHEN '5'  #生鮮商品移倉
            LET g_indc_m.indc199 = '5'
            LET g_indc_m.indc202 = '3'
         WHEN '6'  #贈品商品移倉
            LET g_indc_m.indc199 = '6'
            LET g_indc_m.indc202 = '4'
         #151204-00007#10 151228 By pomelo add(E)
      END CASE
      #150127-00004#13 15/03/17 By pomelo add(E)
      LET g_indc_m.indcsite  = g_site
      LET g_indc_m.indcunit  = g_site
      LET g_indc_m.indcdocdt = g_today
      LET g_indc_m.indc004   = g_user
      #LET g_indc_m.indc005   = g_site  #161108-00059#1  16/11/11 mark by sunxh
      CALL s_desc_get_department_desc(g_indc_m.indcsite) RETURNING g_indc_m.indcsite_desc
      DISPLAY BY NAME g_indc_m.indcsite_desc
      CALL aint510_indc004_ref()
      CALL s_desc_get_department_desc(g_indc_m.indc005) RETURNING g_indc_m.indc005_desc
      DISPLAY BY NAME g_indc_m.indc005_desc
      #sakura---add---str
      LET g_indc_m.indc101 = g_dept 
      CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
      DISPLAY BY NAME g_indc_m.indc101_desc 
      #sakura---add---end      
      
      #150707-00027#3 150707 By pomelo add(S)
      LET g_indc_m.indc006 = g_indc_m.indc005    #160225-00007#1 160225 By pomelo add
      CALL aint510_indc007_init()
      #LET g_indc_m.indc006 = g_indc_m.indc005   #160225-00007#1 160225 By pomelo mark
      LET g_indc_m.indc006_desc = g_indc_m.indc005_desc
      CALL s_desc_get_stock_desc('',g_indc_m.indc007)
         RETURNING g_indc_m.indc007_desc
      DISPLAY BY NAME g_indc_m.indc006,g_indc_m.indc006_desc,g_indc_m.indc007_desc
      #150707-00027#3 150707 By pomelo add(E)
      
      #161027-00058#1  by huicl 20161030 -str-
#      LET g_indc_m.indc200   = g_site
#      LET g_indc_m.indc201   = g_site
#      DISPLAY BY NAME g_indc_m.indc200,g_indc_m.indc201
      #161027-00058#1  by huicl 20161030 -end-
      
      #预设单别
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_indc_m.indcsite,g_prog,'1') RETURNING r_success,r_doctype
      LET g_indc_m.indcdocno = r_doctype
      
      INITIALIZE g_indc_m_t.* LIKE indc_t.*
      INITIALIZE g_indc_m_o.* TO NULL
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_indc_m_t.* = g_indc_m.*
      LET g_indc_m_o.* = g_indc_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_indc_m.indcstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "O"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_out.png")
         WHEN "P"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_in.png")
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
 
 
 
    
      CALL aint510_input("a")
      
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
         INITIALIZE g_indc_m.* TO NULL
         INITIALIZE g_indd_d TO NULL
         INITIALIZE g_indd2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aint510_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_indd_d.clear()
      #CALL g_indd2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint510_set_act_visible()   
   CALL aint510_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_indcdocno_t = g_indc_m.indcdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " indcent = " ||g_enterprise|| " AND",
                      " indcdocno = '", g_indc_m.indcdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint510_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aint510_cl
   
   CALL aint510_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint510_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcsite,g_indc_m.indcdocdt, 
       g_indc_m.indcdocno,g_indc_m.indc001,g_indc_m.indc004,g_indc_m.indc101,g_indc_m.indcunit,g_indc_m.indc199, 
       g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026,g_indc_m.indc025, 
       g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc007,g_indc_m.indc008, 
       g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024,g_indc_m.indcownid, 
       g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt,g_indc_m.indcmodid, 
       g_indc_m.indcmoddt,g_indc_m.indccnfid,g_indc_m.indccnfdt,g_indc_m.indcsite_desc,g_indc_m.indc004_desc, 
       g_indc_m.indc101_desc,g_indc_m.indc200_desc,g_indc_m.indc201_desc,g_indc_m.indc005_desc,g_indc_m.indc006_desc, 
       g_indc_m.indc007_desc,g_indc_m.indc021_desc,g_indc_m.indc023_desc,g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc, 
       g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc,g_indc_m.indcmodid_desc,g_indc_m.indccnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_indc_m_mask_o.* =  g_indc_m.*
   CALL aint510_indc_t_mask()
   LET g_indc_m_mask_n.* =  g_indc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_indc_m.indcsite,g_indc_m.indcsite_desc,g_indc_m.indcdocdt,g_indc_m.indcdocno,g_indc_m.indc001, 
       g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indc101,g_indc_m.indc101_desc,g_indc_m.indcunit, 
       g_indc_m.indc199,g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026, 
       g_indc_m.indc025,g_indc_m.indc200,g_indc_m.indc200_desc,g_indc_m.indc201,g_indc_m.indc201_desc, 
       g_indc_m.indc005,g_indc_m.indc005_desc,g_indc_m.indc006,g_indc_m.indc006_desc,g_indc_m.indc007, 
       g_indc_m.indc007_desc,g_indc_m.indc008,g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc021_desc, 
       g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc023_desc,g_indc_m.indc024,g_indc_m.indcownid,g_indc_m.indcownid_desc, 
       g_indc_m.indcowndp,g_indc_m.indcowndp_desc,g_indc_m.indccrtid,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp, 
       g_indc_m.indccrtdp_desc,g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcmodid_desc,g_indc_m.indcmoddt, 
       g_indc_m.indccnfid,g_indc_m.indccnfid_desc,g_indc_m.indccnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_indc_m.indcownid      
   LET g_data_dept  = g_indc_m.indcowndp
   
   #功能已完成,通報訊息中心
   CALL aint510_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint510.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint510_modify()
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
   LET g_indc_m_t.* = g_indc_m.*
   LET g_indc_m_o.* = g_indc_m.*
   
   IF g_indc_m.indcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_indcdocno_t = g_indc_m.indcdocno
 
   CALL s_transaction_begin()
   
   OPEN aint510_cl USING g_enterprise,g_indc_m.indcdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint510_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcsite,g_indc_m.indcdocdt, 
       g_indc_m.indcdocno,g_indc_m.indc001,g_indc_m.indc004,g_indc_m.indc101,g_indc_m.indcunit,g_indc_m.indc199, 
       g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026,g_indc_m.indc025, 
       g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc007,g_indc_m.indc008, 
       g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024,g_indc_m.indcownid, 
       g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt,g_indc_m.indcmodid, 
       g_indc_m.indcmoddt,g_indc_m.indccnfid,g_indc_m.indccnfdt,g_indc_m.indcsite_desc,g_indc_m.indc004_desc, 
       g_indc_m.indc101_desc,g_indc_m.indc200_desc,g_indc_m.indc201_desc,g_indc_m.indc005_desc,g_indc_m.indc006_desc, 
       g_indc_m.indc007_desc,g_indc_m.indc021_desc,g_indc_m.indc023_desc,g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc, 
       g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc,g_indc_m.indcmodid_desc,g_indc_m.indccnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aint510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_indc_m_mask_o.* =  g_indc_m.*
   CALL aint510_indc_t_mask()
   LET g_indc_m_mask_n.* =  g_indc_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL aint510_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_indcdocno_t = g_indc_m.indcdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_indc_m.indcmodid = g_user 
LET g_indc_m.indcmoddt = cl_get_current()
LET g_indc_m.indcmodid_desc = cl_get_username(g_indc_m.indcmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
                        
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aint510_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                        
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE indc_t SET (indcmodid,indcmoddt) = (g_indc_m.indcmodid,g_indc_m.indcmoddt)
          WHERE indcent = g_enterprise AND indcdocno = g_indcdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_indc_m.* = g_indc_m_t.*
            CALL aint510_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_indc_m.indcdocno != g_indc_m_t.indcdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                                    
         #end add-point
         
         #更新單身key值
         UPDATE indd_t SET indddocno = g_indc_m.indcdocno
 
          WHERE inddent = g_enterprise AND indddocno = g_indc_m_t.indcdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                                    
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "indd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
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
         
         UPDATE indl_t
            SET indldocno = g_indc_m.indcdocno
 
          WHERE indlent = g_enterprise AND
                indldocno = g_indcdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "indl_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "indl_t:",SQLERRMESSAGE 
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
   CALL aint510_set_act_visible()   
   CALL aint510_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " indcent = " ||g_enterprise|| " AND",
                      " indcdocno = '", g_indc_m.indcdocno, "' "
 
   #填到對應位置
   CALL aint510_browser_fill("")
 
   CLOSE aint510_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint510_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aint510.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint510_input(p_cmd)
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
   DEFINE  l_rate                LIKE inaj_t.inaj014
   DEFINE  l_sys1                LIKE type_t.chr80       #组织间调拨是否启用在途
   DEFINE  l_sys2                LIKE type_t.chr80       #组织内调拨是否启用在途
   DEFINE  l_sys3                LIKE type_t.chr80       #在途仓归属 1.拨出 2.拨入
   DEFINE  l_set_entry           LIKE type_t.num5
   DEFINE  l_where               STRING                  #150127-00004#17 151021 By pomelo add
   #151225-00011#10 151229 By pomelo add(S)
   DEFINE  l_sys                 LIKE type_t.num5
   DEFINE  l_inaa106             LIKE inaa_t.inaa106
   #151225-00011#10 151229 By pomelo add(E)
   DEFINE  l_imaf055             LIKE imaf_t.imaf055     #160218-00008#1 160219 pomelo add(S)
   #161017-00029#8 -s by 08172
   DEFINE  l_imaa005            LIKE imaa_t.imaa005     
   DEFINE  l_inam       DYNAMIC ARRAY OF RECORD   #記錄產品特徵
           inam001      LIKE inam_t.inam001,
           inam002      LIKE inam_t.inam002,
           inam004      LIKE inam_t.inam004
                        END RECORD
   DEFINE  l_inddseq    LIKE indd_t.inddseq
   #記錄產品特徵多筆輸入時RECORD
   DEFINE  l_indd       RECORD
           inddent      LIKE indd_t.inddent,
           inddsite     LIKE indd_t.inddsite,
           inddunit     LIKE indd_t.inddunit,  
           indddocno    LIKE indd_t.indddocno, #调拨单号
           inddseq      LIKE indd_t.inddseq,   #项次
           indd001      LIKE indd_t.indd001,   #来源项次
           indd002      LIKE indd_t.indd002,   #商品编号
           indd003      LIKE indd_t.indd003,   #商品条码
           indd004      LIKE indd_t.indd004,   #产品特征
           indd005      LIKE indd_t.indd005,   #经营方式
           indd006      LIKE indd_t.indd006,   #库存单位
           indd007      LIKE indd_t.indd007,   #包装单位
           indd008      LIKE indd_t.indd008,   #件装数
           indd009      LIKE indd_t.indd009,   #预调拨量
           indd020      LIKE indd_t.indd020,   #拨出件数
           indd021      LIKE indd_t.indd021,   #拨出数量
           indd022      LIKE indd_t.indd022,   #拨出库位
           indd023      LIKE indd_t.indd023,   #拨出储位
           indd024      LIKE indd_t.indd024,   #拨出批号
           indd030      LIKE indd_t.indd030,   #拨入件数
           indd031      LIKE indd_t.indd031,   #拨入数量
           indd032      LIKE indd_t.indd032,   #拨入库位
           indd033      LIKE indd_t.indd033,   #拨入储位
           indd034      LIKE indd_t.indd034,   #拨入批号
           indd040      LIKE indd_t.indd040,   #结案否
           indd101      LIKE indd_t.indd101,   #来源单号
           indd102      LIKE indd_t.indd102,   #库存管理特征
           indd103      LIKE indd_t.indd103,   #拨出申请量
           indd104      LIKE indd_t.indd104,   #参考单位
           indd105      LIKE indd_t.indd105,   #拨出申请参考数量
           indd106      LIKE indd_t.indd106,   #拨出合格参考数量
           indd107      LIKE indd_t.indd107,   #拨入申请数量
           indd108      LIKE indd_t.indd108,   #拨入申请参考数量
           indd109      LIKE indd_t.indd109,   #拨入合格参考数量
           indd110      LIKE indd_t.indd110,   #差异量
           indd111      LIKE indd_t.indd111,   #差异原因
           indd112      LIKE indd_t.indd112,   #差异已调整量
           indd151      LIKE indd_t.indd151,   #调拨理由
           indd152      LIKE indd_t.indd152,   #备注
           indd041      LIKE indd_t.indd041,   #拨入单位
           indd042      LIKE indd_t.indd042,   #项目编号
           indd043      LIKE indd_t.indd043,   #WBS
           indd044      LIKE indd_t.indd044,   #活动编号
           indd010      LIKE indd_t.indd010,   #多库储否
           indd025      LIKE indd_t.indd025,   #拨出组织库存数量
           indd035      LIKE indd_t.indd035,   #拨入组织库存数量
           indd045      LIKE indd_t.indd045,   #预估单价
           indd046      LIKE indd_t.indd046,   #预估金额
           indd047      LIKE indd_t.indd047,   #来源需求单号
           indd048      LIKE indd_t.indd048    #来源需求项次
                        END RECORD
   DEFINE  l_num                   LIKE type_t.num10  #161108-00059#1 2016/11/15 add by sunxh
   #161017-00029#8 -e by 08172
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
   DISPLAY BY NAME g_indc_m.indcsite,g_indc_m.indcsite_desc,g_indc_m.indcdocdt,g_indc_m.indcdocno,g_indc_m.indc001, 
       g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indc101,g_indc_m.indc101_desc,g_indc_m.indcunit, 
       g_indc_m.indc199,g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026, 
       g_indc_m.indc025,g_indc_m.indc200,g_indc_m.indc200_desc,g_indc_m.indc201,g_indc_m.indc201_desc, 
       g_indc_m.indc005,g_indc_m.indc005_desc,g_indc_m.indc006,g_indc_m.indc006_desc,g_indc_m.indc007, 
       g_indc_m.indc007_desc,g_indc_m.indc008,g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc021_desc, 
       g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc023_desc,g_indc_m.indc024,g_indc_m.indcownid,g_indc_m.indcownid_desc, 
       g_indc_m.indcowndp,g_indc_m.indcowndp_desc,g_indc_m.indccrtid,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp, 
       g_indc_m.indccrtdp_desc,g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcmodid_desc,g_indc_m.indcmoddt, 
       g_indc_m.indccnfid,g_indc_m.indccnfid_desc,g_indc_m.indccnfdt
   
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
   LET g_forupd_sql = "SELECT inddsite,inddunit,inddseq,indd001,indd047,indd048,indd003,indd002,indd004, 
       indd006,indd005,indd007,indd008,indd009,indd020,indd021,indd045,indd046,indd010,indd022,indd023, 
       indd024,indd102,indd025,indd030,indd031,indd032,indd033,indd034,indd035,indd040,indd101 FROM  
       indd_t WHERE inddent=? AND indddocno=? AND inddseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
            
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint510_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT indlseq,indlseq1,indl001,indl002,indl003,indl004,indl005,indl022,indl023, 
       indl024,indl101,indl020,indl021,indl102,indl103,indl032,indl033,indl034,indl030,indl031 FROM  
       indl_t WHERE indlent=? AND indldocno=? AND indlseq=? AND indlseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint510_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
            
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aint510_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
            
   #end add-point
   CALL aint510_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_indc_m.indcsite,g_indc_m.indcdocdt,g_indc_m.indcdocno,g_indc_m.indc001,g_indc_m.indc004, 
       g_indc_m.indc101,g_indc_m.indcunit,g_indc_m.indc199,g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002, 
       g_indc_m.indc003,g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc007, 
       g_indc_m.indc008,g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   CALL aint510_set_combo(p_cmd)
   IF g_indc_m.indc002 = '2' AND NOT cl_null(g_indc_m.indc003) THEN
      LET l_allow_delete = FALSE
      LET l_allow_insert = FALSE
   END IF
   IF g_site = g_indc_m.indc006 AND g_indc_m.indcstus = 'O' THEN
      LET l_allow_delete = FALSE
      LET l_allow_insert = FALSE
   END IF
   #150127-00004#13 15/03/17 By pomelo add(S)
   IF g_indc_m.indc002 = '4' OR g_indc_m.indc002 = '5' THEN
      LET l_allow_delete = FALSE
      LET l_allow_insert = FALSE
   END IF
   #150127-00004#13 15/03/17 By pomelo add(E)
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aint510.input.head" >}
      #單頭段
      INPUT BY NAME g_indc_m.indcsite,g_indc_m.indcdocdt,g_indc_m.indcdocno,g_indc_m.indc001,g_indc_m.indc004, 
          g_indc_m.indc101,g_indc_m.indcunit,g_indc_m.indc199,g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002, 
          g_indc_m.indc003,g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc007, 
          g_indc_m.indc008,g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aint510_cl USING g_enterprise,g_indc_m.indcdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aint510_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF NOT cl_null(g_detail_flag) AND g_detail_flag = '2' THEN
               LET g_detail_flag = '1'
               NEXT FIELD indd022
            END IF
            #end add-point
            CALL aint510_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcsite
            
            #add-point:AFTER FIELD indcsite name="input.a.indcsite"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcsite
            #add-point:BEFORE FIELD indcsite name="input.b.indcsite"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indcsite
            #add-point:ON CHANGE indcsite name="input.g.indcsite"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcdocdt
            #add-point:BEFORE FIELD indcdocdt name="input.b.indcdocdt"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcdocdt
            
            #add-point:AFTER FIELD indcdocdt name="input.a.indcdocdt"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indcdocdt
            #add-point:ON CHANGE indcdocdt name="input.g.indcdocdt"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcdocno
            #add-point:BEFORE FIELD indcdocno name="input.b.indcdocno"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcdocno
            
            #add-point:AFTER FIELD indcdocno name="input.a.indcdocno"
            IF p_cmd = 'a' AND NOT cl_null(g_indc_m.indcdocno) THEN 
               IF NOT s_aooi200_chk_slip(g_site,'',g_indc_m.indcdocno,g_prog) THEN
                  LET g_indc_m.indcdocno = g_indc_m_t.indcdocno
                  DISPLAY BY NAME g_indc_m.indcdocno
                  NEXT FIELD CURRENT
               END IF
            END IF
            IF NOT cl_null(g_indc_m.indcdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_indc_m.indcdocno != g_indcdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM indc_t WHERE "||"indcent = '" ||g_enterprise|| "' AND "||"indcdocno = '"||g_indc_m.indcdocno ||"'",'std-00004',0) THEN 
                     LET g_indc_m.indcdocno = g_indc_m_t.indcdocno
                     DISPLAY BY NAME g_indc_m.indcdocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #160204-00004#5 20160222 s983961--add(s)
               IF (g_indc_m.indcdocno != g_indc_m_o.indcdocno) OR cl_null(g_indc_m_o.indcdocno) THEN
                 LET g_indc_m.indc003 = ''
                 LET g_indc_m_o.indc003 = ''
                 DISPLAY g_indc_m.indc003      
               END IF                                      
               #160204-00004#5 20160222 s983961--add(e) 
            END IF
            
            LET g_indc_m_o.indcdocno = g_indc_m.indcdocno   #160204-00004#5 20160222 s983961--add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indcdocno
            #add-point:ON CHANGE indcdocno name="input.g.indcdocno"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc001
            #add-point:BEFORE FIELD indc001 name="input.b.indc001"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc001
            
            #add-point:AFTER FIELD indc001 name="input.a.indc001"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc001
            #add-point:ON CHANGE indc001 name="input.g.indc001"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc004
            
            #add-point:AFTER FIELD indc004 name="input.a.indc004"
                                                LET g_indc_m.indc004_desc = ''
            DISPLAY BY NAME g_indc_m.indc004_desc
            IF NOT cl_null(g_indc_m.indc004) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_indc_m.indc004
               #160318-00025#18  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#18  by 07900 --add-end
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_indc_m.indc004 = g_indc_m_t.indc004
                  DISPLAY BY NAME g_indc_m.indc004
                  CALL aint510_indc004_ref()
                  NEXT FIELD CURRENT
               END IF
            #sakura---add---str
               SELECT ooag003 INTO g_indc_m.indc101 FROM ooag_t 
                 WHERE ooagent = g_enterprise AND ooag001 = g_indc_m.indc004
               DISPLAY BY NAME g_indc_m.indc101
               CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
               DISPLAY BY NAME g_indc_m.indc101_desc
            #sakura---add---end               
            END IF 
            CALL aint510_indc004_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc004
            #add-point:BEFORE FIELD indc004 name="input.b.indc004"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc004
            #add-point:ON CHANGE indc004 name="input.g.indc004"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc101
            
            #add-point:AFTER FIELD indc101 name="input.a.indc101"
            CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
            DISPLAY BY NAME g_indc_m.indc101_desc
            IF NOT cl_null(g_indc_m.indc101) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_indc_m.indc101
               LET g_chkparam.arg2 = g_today              
               #160318-00025#19  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#19  by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_indc_m.indc101 = g_indc_m_t.indc101
                  CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
                  DISPLAY BY NAME g_indc_m.indc101_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
               DISPLAY BY NAME g_indc_m.indc101_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc101
            #add-point:BEFORE FIELD indc101 name="input.b.indc101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc101
            #add-point:ON CHANGE indc101 name="input.g.indc101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcunit
            #add-point:BEFORE FIELD indcunit name="input.b.indcunit"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcunit
            
            #add-point:AFTER FIELD indcunit name="input.a.indcunit"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indcunit
            #add-point:ON CHANGE indcunit name="input.g.indcunit"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc199
            #add-point:BEFORE FIELD indc199 name="input.b.indc199"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc199
            
            #add-point:AFTER FIELD indc199 name="input.a.indc199"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc199
            #add-point:ON CHANGE indc199 name="input.g.indc199"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc000
            #add-point:BEFORE FIELD indc000 name="input.b.indc000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc000
            
            #add-point:AFTER FIELD indc000 name="input.a.indc000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc000
            #add-point:ON CHANGE indc000 name="input.g.indc000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc202
            #add-point:BEFORE FIELD indc202 name="input.b.indc202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc202
            
            #add-point:AFTER FIELD indc202 name="input.a.indc202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc202
            #add-point:ON CHANGE indc202 name="input.g.indc202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc002
            #add-point:BEFORE FIELD indc002 name="input.b.indc002"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc002
            
            #add-point:AFTER FIELD indc002 name="input.a.indc002"
            #151225-00011#1 151231 By pomelo add(S)
            IF NOT cl_null(g_indc_m.indc002) THEN
               IF g_indc_m.indc002 != g_indc_m_o.indc002 OR cl_null(g_indc_m_o.indc002) THEN
                  IF g_indc_m.indc002 MATCHES '[678]' THEN
                     LET g_indc_m.indc005 = ''
                     LET g_indc_m.indc005_desc = ''
                     LET g_indc_m.indc006 = ''
                     LET g_indc_m.indc006_desc = ''
                     LET g_indc_m.indc200 = ''
                     LET g_indc_m.indc200_desc = ''
                     LET g_indc_m.indc201 = ''
                     LET g_indc_m.indc201_desc = ''
                     LET g_indc_m.indc007 = ''
                     LET g_indc_m.indc007_desc = ''
                     DISPLAY BY NAME g_indc_m.indc005, g_indc_m.indc005_desc,
                                     g_indc_m.indc006, g_indc_m.indc006_desc,
                                     g_indc_m.indc200, g_indc_m.indc200_desc,
                                     g_indc_m.indc201, g_indc_m.indc201_desc,
                                     g_indc_m.indc007, g_indc_m.indc007_desc
                  END IF
               END IF
            END IF
            #151225-00011#1 151231 By pomelo add(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc002
            #add-point:ON CHANGE indc002 name="input.g.indc002"
            CALL aint510_set_entry(p_cmd)
            CALL aint510_set_no_entry(p_cmd)
            IF g_indc_m.indc002 = '1' THEN
               LET g_indc_m.indc003 = ''
               DISPLAY BY NAME g_indc_m.indc003
            END IF
            #151225-00011#1 151231 By pomelo add(S)
            IF g_indc_m.indc002 MATCHES '[678]' THEN
               LET g_indc_m.indc003 = ''
               DISPLAY BY NAME g_indc_m.indc003
            END IF
            #151225-00011#1 151231 By pomelo add(E)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc003
            #add-point:BEFORE FIELD indc003 name="input.b.indc003"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc003
            
            #add-point:AFTER FIELD indc003 name="input.a.indc003"
            IF NOT cl_null(g_indc_m.indc003) THEN               
               IF g_indc_m.indc003 <> g_indc_m_o.indc003 OR cl_null(g_indc_m_o.indc003) THEN
                  #160204-00004#5 20160222 s983961--add(s)
                  IF NOT cl_null(g_indc_m.indcdocno) THEN 
                     IF NOT s_aooi210_check_doc(g_site,'', g_indc_m.indc003 , g_indc_m.indcdocno ,'4','') THEN
                        LET g_indc_m.indc003 = g_indc_m_o.indc003
                        DISPLAY BY NAME g_indc_m.indc003
                        
                        NEXT FIELD CURRENT               
                     END IF
                  END IF
                  #160204-00004#5 20160222 s983961--add(e) 
                  CALL aint510_indc003_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_indc_m.indc003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_indc_m.indc003 = g_indc_m_o.indc003
                     DISPLAY BY NAME g_indc_m.indc003
                     CALL aint510_indc003_init()
                     NEXT FIELD indc003
                  END IF
                  CALL aint510_indc003_init()
               END IF
            END IF
            CALL aint510_set_entry(p_cmd)
            CALL aint510_set_no_entry(p_cmd)
            LET g_indc_m_o.indc003 = g_indc_m.indc003
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc003
            #add-point:ON CHANGE indc003 name="input.g.indc003"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc200
            
            #add-point:AFTER FIELD indc200 name="input.a.indc200"
            LET g_indc_m.indc200_desc = ''
            DISPLAY BY NAME g_indc_m.indc200_desc
            IF NOT cl_null(g_indc_m.indc200) THEN
               IF g_indc_m.indc200 != g_indc_m_o.indc200 OR cl_null(g_indc_m_o.indc200) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #161108-00059#1  16/11/15 by sunxh(S)
                  IF NOT cl_null(g_indc_m.indc005) THEN 
                     LET g_chkparam.arg1 = g_indc_m.indc005
                     LET g_chkparam.arg2 = g_indc_m.indc200
                     LET g_chkparam.err_str[1] = "aim-00064:art-00154"   #160329-00005#1 add
                     #160318-00025#19  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[2] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_inaa001") THEN
                        LET g_indc_m.indc200 = g_indc_m_o.indc200
                        CALL s_desc_get_stock_desc('',g_indc_m.indc200)
                           RETURNING g_indc_m.indc200_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
                  #161108-00059#1  16/11/15 by sunxh(E)
#                  LET g_chkparam.arg1 = g_indc_m.indc005
#                  LET g_chkparam.arg2 = g_indc_m.indc200
#                  LET g_chkparam.err_str[1] = "aim-00064:art-00154"   #160329-00005#1 add
#                  #160318-00025#19  by 07900 --add-str
#                  LET g_errshow = TRUE #是否開窗                   
#                  LET g_chkparam.err_str[2] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#19  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
#                  IF NOT cl_chk_exist("v_inaa001") THEN
#                     LET g_indc_m.indc200 = g_indc_m_o.indc200
#                     CALL s_desc_get_stock_desc('',g_indc_m.indc200)
#                        RETURNING g_indc_m.indc200_desc
#                     NEXT FIELD CURRENT
#                  END IF
                  
                  #150127-00004#17 151021 By pomelo add(S)
                  CALL aint510_depot_cost_chk('2','1',g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc007)
                     RETURNING l_success,l_where
                  IF NOT l_success THEN
                     LET g_indc_m.indc200 = g_indc_m_o.indc200
                     CALL s_desc_get_stock_desc('',g_indc_m.indc200)
                        RETURNING g_indc_m.indc200_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150127-00004#17 151021 By pomelo add(S)
                  
                  #151204-00007#10 151228 By pomelo add(S)
                  IF NOT aint510_depot_chk(-1,g_indc_m.indc200) THEN
                     LET g_indc_m.indc200 = g_indc_m_o.indc200
                     CALL s_desc_get_stock_desc('',g_indc_m.indc200)
                        RETURNING g_indc_m.indc200_desc
                     NEXT FIELD CURRENT
                  END IF
                  #151204-00007#10 151228 By pomelo add(E)
                  #161108-00059#1  16/11/11 by sunxh(S)
                  LET l_num = 0
                  SELECT count(inaasite) INTO l_num
                    FROM inaa_t
                   WHERE inaa001 = g_indc_m.indc200
                     AND inaaent = g_enterprise
                  IF l_num = 1 THEN 
                     IF cl_null(g_indc_m.indc005) THEN
                        SELECT inaasite INTO g_indc_m.indc005
                          FROM inaa_t
                         WHERE inaa001 = g_indc_m.indc200
                           AND inaaent = g_enterprise
                        CALL s_desc_get_department_desc(g_indc_m.indc005) RETURNING g_indc_m.indc005_desc
                        DISPLAY BY NAME g_indc_m.indc005,g_indc_m.indc005_desc
                     END IF
                     IF NOT cl_null(g_indc_m.indc005) THEN
                        IF g_indc_m.indc005 != g_indc_m_o.indc005 OR cl_null(g_indc_m_o.indc005) THEN
                           CALL aint510_indc007_init()
                           CALL aint510_indc007_ref()
                        END IF 
                     END IF 
                  END IF 
                  #161108-00059#1  16/11/11 by sunxh(E)
               END IF
            END IF
            CALL s_desc_get_stock_desc('',g_indc_m.indc200)
               RETURNING g_indc_m.indc200_desc
            DISPLAY BY NAME g_indc_m.indc200_desc
            CALL aint510_set_entry(p_cmd)
            CALL aint510_set_no_entry(p_cmd)
            LET g_indc_m_o.indc200 = g_indc_m.indc200
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc200
            #add-point:BEFORE FIELD indc200 name="input.b.indc200"
           
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc200
            #add-point:ON CHANGE indc200 name="input.g.indc200"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc201
            
            #add-point:AFTER FIELD indc201 name="input.a.indc201"
            LET g_indc_m.indc201_desc = ''
            DISPLAY BY NAME g_indc_m.indc201_desc
            IF NOT cl_null(g_indc_m.indc201) THEN
               IF g_indc_m.indc201 != g_indc_m_o.indc201 OR cl_null(g_indc_m_o.indc201) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #161108-00059#1  16/11/15 by sunxh(S)
                  IF NOT cl_null(g_indc_m.indc006) THEN 
                     LET g_chkparam.arg1 = g_indc_m.indc006
                     LET g_chkparam.arg2 = g_indc_m.indc201
                     LET g_chkparam.err_str[1] = "aim-00064:art-00154"   #160329-00005#1 add
                     #160318-00025#19  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[2] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                     #160318-00025#19  by 07900 --add-end 
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_inaa001") THEN
                        LET g_indc_m.indc201 = g_indc_m_o.indc201
                        CALL s_desc_get_stock_desc('',g_indc_m.indc201)
                           RETURNING g_indc_m.indc201_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #161108-00059#1  16/11/15 by sunxh(S)
                  #150127-00004#17 151021 By pomelo add(S)
                  CALL aint510_depot_cost_chk('2','2',g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc007)
                     RETURNING l_success,l_where
                  IF NOT l_success THEN
                     LET g_indc_m.indc201 = g_indc_m_o.indc201
                     CALL s_desc_get_stock_desc('',g_indc_m.indc201)
                        RETURNING g_indc_m.indc201_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150127-00004#17 151021 By pomelo add(S)
                  
                  #151204-00007#10 151228 By pomelo add(S)
                  IF NOT aint510_depot_chk(1,g_indc_m.indc201) THEN
                     LET g_indc_m.indc201 = g_indc_m_o.indc201
                     CALL s_desc_get_stock_desc('',g_indc_m.indc201)
                        RETURNING g_indc_m.indc201_desc
                     NEXT FIELD CURRENT
                  END IF
                  #151204-00007#10 151228 By pomelo add(E)
                  #161108-00059#1  16/11/11 by sunxh(S)
                  LET l_num = 0
                  SELECT count(inaasite) INTO l_num
                    FROM inaa_t
                   WHERE inaa001 = g_indc_m.indc201
                     AND inaaent = g_enterprise
                  IF l_num=1 THEN 
                     IF cl_null(g_indc_m.indc006) THEN
                        SELECT inaasite INTO g_indc_m.indc006
                          FROM inaa_t
                         WHERE inaa001 = g_indc_m.indc201
                           AND inaaent = g_enterprise
                        CALL s_desc_get_department_desc(g_indc_m.indc006) RETURNING g_indc_m.indc006_desc
                        DISPLAY BY NAME g_indc_m.indc006,g_indc_m.indc006_desc
                     END IF
                     IF NOT cl_null(g_indc_m.indc006) THEN
                        IF g_indc_m.indc006 != g_indc_m_o.indc006 OR cl_null(g_indc_m_o.indc006) THEN
                           CALL aint510_indc007_init()
                           CALL aint510_indc007_ref()
                        END IF 
                     END IF 
                  END IF 
                  #161108-00059#1  16/11/11 by sunxh(E)
               END IF
            END IF
            CALL s_desc_get_stock_desc('',g_indc_m.indc201)
               RETURNING g_indc_m.indc201_desc
            DISPLAY BY NAME g_indc_m.indc201_desc
            CALL aint510_set_entry(p_cmd)
            CALL aint510_set_no_entry(p_cmd)
            LET g_indc_m_o.indc201 = g_indc_m.indc201
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc201
            #add-point:BEFORE FIELD indc201 name="input.b.indc201"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc201
            #add-point:ON CHANGE indc201 name="input.g.indc201"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc005
            
            #add-point:AFTER FIELD indc005 name="input.a.indc005"
            LET g_indc_m.indc005_desc = ''
            DISPLAY BY NAME g_indc_m.indc005_desc
            IF NOT cl_null(g_indc_m.indc005) THEN
               IF g_indc_m.indc005 != g_indc_m_o.indc005 OR cl_null(g_indc_m_o.indc005) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = '1'
                  LET g_chkparam.arg1 = g_indc_m.indc005
                  LET g_chkparam.arg2 = '8'
                  LET g_chkparam.arg3 = g_site
                  IF NOT cl_chk_exist("v_ooed004") THEN
                     LET g_indc_m.indc005 = g_indc_m_o.indc005
                     CALL s_desc_get_department_desc(g_indc_m.indc005) RETURNING g_indc_m.indc005_desc
                     DISPLAY BY NAME g_indc_m.indc005,g_indc_m.indc005_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #IF cl_null(g_indc_m.indc007) THEN #160225-00007#1 160225 By pomelo mark
                     CALL aint510_indc007_init()
                     CALL aint510_indc007_ref()
                  #END IF   #160225-00007#1 160225 By pomelo mark
                  #161108-00059#1 161124 add by sunxh(S)
                  LET l_n=0
                  IF NOT cl_null(g_indc_m.indc200) THEN 
                     SELECT count(*) into l_n FROM inaa_t 
                      WHERE inaaunit=g_indc_m.indc005 
                        AND inaa001=g_indc_m.indc200
                        AND inaaent = g_enterprise #add by geza 20170123 #170122-00004#1
                     IF l_n = 0 THEN 
                        #150707-00027#3 By pomelo add(S)
                        LET g_indc_m.indc200 = ''
                        LET g_indc_m.indc200_desc = ''
                        DISPLAY BY NAME g_indc_m.indc200,g_indc_m.indc200_desc
                        #150707-00027#3 By pomelo add(E)  
                     END IF                        
                  END IF
                  #161108-00059#1 161124 add by sunxh(E)
                  
                                  
               END IF
            END IF            
            #161108-00059#1 2016/11/11 add by sunxh(S)
            IF cl_null(g_indc_m.indc200) THEN
               SELECT ooef123 INTO g_indc_m.indc200
                 FROM ooef_t
                WHERE ooef001= g_indc_m.indc005
                  AND ooefent= g_enterprise
               CALL s_desc_get_stock_desc('',g_indc_m.indc200)
                  RETURNING g_indc_m.indc200_desc
               DISPLAY BY NAME g_indc_m.indc200_desc
            END IF 
            #161108-00059#1 2016/11/11 add by sunxh (E)            
            CALL s_desc_get_department_desc(g_indc_m.indc005) RETURNING g_indc_m.indc005_desc
            DISPLAY BY NAME g_indc_m.indc005_desc
            CALL aint510_set_entry(p_cmd)
            CALL aint510_set_no_entry(p_cmd)
            #150707-00027#3 By pomelo add(S)
            LET g_indc_m_o.indc200 = g_indc_m.indc200
            LET g_indc_m_o.indc005 = g_indc_m.indc005
            #150707-00027#3 By pomelo add(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc005
            #add-point:BEFORE FIELD indc005 name="input.b.indc005"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc005
            #add-point:ON CHANGE indc005 name="input.g.indc005"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc006
            
            #add-point:AFTER FIELD indc006 name="input.a.indc006"
            LET g_indc_m.indc006_desc = ''
            DISPLAY BY NAME g_indc_m.indc006_desc
            IF NOT cl_null(g_indc_m.indc006) THEN
               IF g_indc_m.indc006 != g_indc_m_o.indc006 OR cl_null(g_indc_m_o.indc006) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = '1'
                  LET g_chkparam.arg1 = g_indc_m.indc006
                  IF NOT cl_chk_exist("v_ooef001_20") THEN
                     LET g_indc_m.indc006 = g_indc_m_o.indc006
                     CALL s_desc_get_department_desc(g_indc_m.indc006) RETURNING g_indc_m.indc006_desc
                     DISPLAY BY NAME g_indc_m.indc006,g_indc_m.indc006_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF cl_null(g_indc_m.indc007) THEN  #160225-00007#1 160225 By pomelo mark
                     CALL aint510_indc007_init()
                     CALL aint510_indc007_ref()
                  #END IF #160225-00007#1 160225 By pomelo mark
                  #161108-00059#1 161124 add by sunxh(S)
                  LET l_n=0
                  IF NOT cl_null(g_indc_m.indc201) THEN 
                     SELECT count(*) into l_n FROM inaa_t 
                      WHERE inaaunit=g_indc_m.indc006 
                        AND inaa001=g_indc_m.indc201
                        AND inaaent = g_enterprise #add by geza 20170123 #170122-00004#1
                     IF l_n = 0 THEN 
                        #150707-00027#3 By pomelo add(S)                  
                        LET g_indc_m.indc201 = ''
                        LET g_indc_m.indc201_desc = ''
                        DISPLAY BY NAME g_indc_m.indc201,g_indc_m.indc201_desc
                        #150707-00027#3 By pomelo add(E)
                     END IF                        
                  END IF
                  #161108-00059#1 161124 add by sunxh(E)
               END IF
            END IF
            #161108-00059#1 2016/11/11 add by sunxh(S)
            IF cl_null(g_indc_m.indc201) THEN
               SELECT ooef124 INTO g_indc_m.indc201
                 FROM ooef_t
                WHERE ooef001= g_indc_m.indc006
                  AND ooefent= g_enterprise
               CALL s_desc_get_stock_desc('',g_indc_m.indc200)
                  RETURNING g_indc_m.indc200_desc
               DISPLAY BY NAME g_indc_m.indc200_desc
            END IF 
            #161108-00059#1 2016/11/11 add by sunxh(E)
            CALL s_desc_get_department_desc(g_indc_m.indc006) RETURNING g_indc_m.indc006_desc
            DISPLAY BY NAME g_indc_m.indc006_desc
            CALL aint510_set_entry(p_cmd)
            CALL aint510_set_no_entry(p_cmd)
            #150707-00027#3 By pomelo add(S)
            LET g_indc_m_o.indc201 = g_indc_m.indc201
            LET g_indc_m_o.indc006 = g_indc_m.indc006
            #150707-00027#3 By pomelo add(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc006
            #add-point:BEFORE FIELD indc006 name="input.b.indc006"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc006
            #add-point:ON CHANGE indc006 name="input.g.indc006"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc007
            
            #add-point:AFTER FIELD indc007 name="input.a.indc007"
            LET g_indc_m.indc007_desc = ''
            DISPLAY BY NAME g_indc_m.indc007_desc
            IF NOT cl_null(g_indc_m.indc007) THEN
               IF g_indc_m.indc007 != g_indc_m_o.indc007 OR cl_null(g_indc_m_o.indc007) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = '1'
                  #取参数
                  CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys1
                  CALL cl_get_para(g_enterprise,g_site,'E-BAS-0014') RETURNING l_sys2
                  CALL cl_get_para(g_enterprise,g_site,'E-BAS-0015') RETURNING l_sys3
                  IF l_sys3 = '1' THEN
                     LET g_chkparam.arg1 = g_indc_m.indc005
                  ELSE
                     LET g_chkparam.arg1 = g_indc_m.indc006
                  END IF
                  LET g_chkparam.arg2 = g_indc_m.indc007
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_13") THEN
                     LET g_indc_m.indc007 = g_indc_m_o.indc007
                     DISPLAY BY NAME g_indc_m.indc007
                     CALL aint510_indc007_ref()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #150127-00004#17 151021 By pomelo add(S)
                  CALL aint510_depot_cost_chk('2','3',g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc007)
                     RETURNING l_success,l_where
                  IF NOT l_success THEN
                     LET g_indc_m.indc007 = g_indc_m_o.indc007
                     DISPLAY BY NAME g_indc_m.indc007
                     CALL aint510_indc007_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #150127-00004#17 151021 By pomelo add(S)
               END IF
            END IF 
            CALL aint510_indc007_ref()
            LET g_indc_m_o.indc007 = g_indc_m.indc007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc007
            #add-point:BEFORE FIELD indc007 name="input.b.indc007"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc007
            #add-point:ON CHANGE indc007 name="input.g.indc007"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc008
            #add-point:BEFORE FIELD indc008 name="input.b.indc008"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc008
            
            #add-point:AFTER FIELD indc008 name="input.a.indc008"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc008
            #add-point:ON CHANGE indc008 name="input.g.indc008"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcstus
            #add-point:BEFORE FIELD indcstus name="input.b.indcstus"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcstus
            
            #add-point:AFTER FIELD indcstus name="input.a.indcstus"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indcstus
            #add-point:ON CHANGE indcstus name="input.g.indcstus"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc021
            
            #add-point:AFTER FIELD indc021 name="input.a.indc021"
                                    CALL aint510_indc021_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc021
            #add-point:BEFORE FIELD indc021 name="input.b.indc021"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc021
            #add-point:ON CHANGE indc021 name="input.g.indc021"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc022
            #add-point:BEFORE FIELD indc022 name="input.b.indc022"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc022
            
            #add-point:AFTER FIELD indc022 name="input.a.indc022"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc022
            #add-point:ON CHANGE indc022 name="input.g.indc022"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc023
            
            #add-point:AFTER FIELD indc023 name="input.a.indc023"
                                    CALL aint510_indc023_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc023
            #add-point:BEFORE FIELD indc023 name="input.b.indc023"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc023
            #add-point:ON CHANGE indc023 name="input.g.indc023"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc024
            #add-point:BEFORE FIELD indc024 name="input.b.indc024"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc024
            
            #add-point:AFTER FIELD indc024 name="input.a.indc024"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc024
            #add-point:ON CHANGE indc024 name="input.g.indc024"
                                                
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.indcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcsite
            #add-point:ON ACTION controlp INFIELD indcsite name="input.c.indcsite"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.indcdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcdocdt
            #add-point:ON ACTION controlp INFIELD indcdocdt name="input.c.indcdocdt"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.indcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcdocno
            #add-point:ON ACTION controlp INFIELD indcdocno name="input.c.indcdocno"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indcdocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = g_prog
            #160711-00040#15 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#15 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_indc_m.indcdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indc_m.indcdocno TO indcdocno              #顯示到畫面上

            NEXT FIELD indcdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc001
            #add-point:ON ACTION controlp INFIELD indc001 name="input.c.indc001"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.indc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc004
            #add-point:ON ACTION controlp INFIELD indc004 name="input.c.indc004"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indc004             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_indc_m.indc004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indc_m.indc004 TO indc004              #顯示到畫面上
            
            CALL aint510_indc004_ref()

            NEXT FIELD indc004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc101
            #add-point:ON ACTION controlp INFIELD indc101 name="input.c.indc101"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indc_m.indc101             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                                #呼叫開窗
            LET g_indc_m.indc101 = g_qryparam.return1              
            DISPLAY g_indc_m.indc101 TO indc101              #
            CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
            DISPLAY BY NAME g_indc_m.indc101_desc
            NEXT FIELD indc101


            #END add-point
 
 
         #Ctrlp:input.c.indcunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcunit
            #add-point:ON ACTION controlp INFIELD indcunit name="input.c.indcunit"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.indc199
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc199
            #add-point:ON ACTION controlp INFIELD indc199 name="input.c.indc199"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc000
            #add-point:ON ACTION controlp INFIELD indc000 name="input.c.indc000"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc202
            #add-point:ON ACTION controlp INFIELD indc202 name="input.c.indc202"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc002
            #add-point:ON ACTION controlp INFIELD indc002 name="input.c.indc002"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.indc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc003
            #add-point:ON ACTION controlp INFIELD indc003 name="input.c.indc003"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indc_m.indc003             #給予default值
            #151225-00011#1 151230 By pomelo mark(S)
            #IF g_indc_m.indc002 = '2' THEN             #150127-00004#13 15/03/17 By pomelo add
			   #   LET g_qryparam.where = "     indastus = 'T' AND inda003 = '",g_indc_m.indcsite,"' ",
            #                          " AND NOT EXISTS (SELECT 1 ",
            #                          "                   FROM indc_t ",
            #                          "                  WHERE indcent = '",g_enterprise,"' ",
            #                          "                    AND indc002 = '2' AND indcstus <> 'X' AND indc003 = indadocno) "
            #
            #   CALL q_indadocno()                          #呼叫開窗
            ##150127-00004#13 15/03/17 By pomelo add-----------(S)
			   #ELSE
			   #   CALL q_indcdocno_7()
			   #END IF
			   ##150127-00004#13 15/03/17 By pomelo add-----------(E)
			   #151225-00011#1 151230 By pomelo mark(E)
			   #151225-00011#1 151230 By pomelo add(S)
			   CASE g_indc_m.indc002
			      WHEN '2' #調撥申請單
			         LET g_qryparam.where = "     inda003 = '",g_indc_m.indcsite,"' ",
			                                " AND indastus = 'T'",
                                         " AND NOT EXISTS (SELECT 1 ",
                                         "                   FROM indc_t ",
                                         "                  WHERE indcent = ",g_enterprise,
                                         "                    AND indc002 = '2'",
                                         "                    AND indcstus <> 'X'",
                                         "                    AND indc003 = indadocno) "
                  #160204-00004#5 20160223 s983961--add(s)
                  IF NOT cl_null(g_indc_m.indcdocno) THEN
                     LET l_success = ''
                     LET l_where = ''
                     CALL s_aooi210_get_check_sql(g_site,'', g_indc_m.indcdocno ,'4','','indadocno') RETURNING l_success,l_where
                     IF l_success AND NOT cl_null(l_where) THEN
                        LET g_qryparam.where = g_qryparam.where," AND ",l_where
                        CALL q_indadocno()                                #呼叫開窗
                     END IF
                  END IF
                  #160204-00004#5 20160223 s983961--add(e)                           
                  #CALL q_indadocno()   #160204-00004#5 20160223 s983961--mark
                  
               WHEN '6'  #退貨申請單
                  LET g_qryparam.arg1 = g_indc_m.indcsite
                  #160204-00004#5 20160223 s983961--add(s)
                  IF NOT cl_null(g_indc_m.indcdocno) THEN
                     LET l_success = ''
                     LET l_where = ''
                     CALL s_aooi210_get_check_sql(g_site,'', g_indc_m.indcdocno ,'4','','indmdocno') RETURNING l_success,l_where
                     IF l_success AND NOT cl_null(l_where) THEN
                        LET g_qryparam.where = l_where
                        CALL q_indmdocno_2()                                #呼叫開窗
                     END IF
                  END IF
                  #160204-00004#5 20160223 s983961--add(e)         
                  #CALL q_indmdocno_2()  #160204-00004#5 20160223 s983961--mark
               WHEN '7'  #配送調撥單
                  LET g_qryparam.arg1 = '2'
                  #160204-00004#5 20160223 s983961--add(s)
                  IF NOT cl_null(g_indc_m.indcdocno) THEN
                     LET l_success = ''
                     LET l_where = ''
                     CALL s_aooi210_get_check_sql(g_site,'', g_indc_m.indcdocno ,'4','','indcdocno') RETURNING l_success,l_where
                     IF l_success AND NOT cl_null(l_where) THEN
                        LET g_qryparam.where = l_where
                        CALL q_indcdocno_7()                                #呼叫開窗
                     END IF
                  END IF
                  #160204-00004#5 20160223 s983961--add(e)  
                  #CALL q_indcdocno_7()  #160204-00004#5 20160223 s983961--mark
               WHEN '8'  #調撥單
                  LET g_qryparam.arg1 = '1'
                  #160204-00004#5 20160223 s983961--add(s)
                  IF NOT cl_null(g_indc_m.indcdocno) THEN
                     LET l_success = ''
                     LET l_where = ''
                     CALL s_aooi210_get_check_sql(g_site,'', g_indc_m.indcdocno ,'4','','indcdocno') RETURNING l_success,l_where
                     IF l_success AND NOT cl_null(l_where) THEN
                        LET g_qryparam.where = l_where
                        CALL q_indcdocno_7()                                #呼叫開窗
                     END IF
                  END IF
                  #160204-00004#5 20160223 s983961--add(e)  
                  #CALL q_indcdocno_7()  #160204-00004#5 20160223 s983961--mark
            END CASE
			   #151225-00011#1 151230 By pomelo add(E)
            LET g_indc_m.indc003 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_indc_m.indc003 TO indc003         #顯示到畫面上
            NEXT FIELD indc003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.indc200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc200
            #add-point:ON ACTION controlp INFIELD indc200 name="input.c.indc200"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indc_m.indc200
            
            LET g_qryparam.arg1 = g_indc_m.indc005
            
            #150127-00004#17 151021 By pomelo add(S)
            CALL aint510_depot_cost_chk('3','1',g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc007)
               RETURNING l_success,l_where
            LET g_qryparam.where = l_where
            #150127-00004#17 151021 By pomelo add(E)
            #151204-00007#10 151228 By pomelo add(S)
            LET g_qryparam.where = aint510_depot_where(-1),
                                   " AND ",l_where
            #151204-00007#10 151228 By pomelo add(E)
#            LET g_qryparam.arg1 = g_indc_m.indc005
            #161108-00059#1 16/11/11 by sunxh mod(S)            
#            CALL q_inaa001_4()
            IF cl_null(g_indc_m.indc005) THEN 
               LET g_qryparam.where =  g_qryparam.where," AND inaasite in(
                      SELECT DISTINCT  OOED004 
                        FROM OOED_T
                        LEFT OUTER JOIN OOEFL_T ON OOEFLENT = OOEDENT
                         AND OOEFL001 = OOED004
                         AND OOEFL002 = '",g_dlang,"'
                       WHERE OOEDENT =  '",g_enterprise,"'
                         AND OOED001 = '8'
                         AND OOED006 <= '",g_today,"'
                         AND (OOED007 >= '",g_today,"' OR OOED007 IS NULL)
                         AND OOED004 IN
                            (SELECT OOED004
                               FROM OOED_T
                              START WITH OOED005 = '",g_site,"'
                                AND OOED001 = '8'
                                AND OOED006 <= '",g_today,"'
                                AND (OOED007 >= '",g_today,"' OR OOED007 IS NULL)
                            CONNECT BY NOCYCLE PRIOR OOED004 = OOED005
                                AND OOED001 = '8'
                                AND OOED006 <= '",g_today,"'
                                AND (OOED007 >= '",g_today,"' OR OOED007 IS NULL)
                              UNION
                             SELECT OOED004 FROM OOED_T WHERE OOED004 = '",g_site,"' AND ooedent = ",g_enterprise," ))" #add by geza 20170123 #170122-00004#11 ooedent 
               CALL q_inaa001_14()
            ELSE 
               LET g_qryparam.arg1 = g_indc_m.indc005
               CALL q_inaa001_4()
            END IF 
            #161108-00059#1 16/11/11 by sunxh mod(E)
            LET g_indc_m.indc200 = g_qryparam.return1
            DISPLAY g_indc_m.indc200 TO indc200
            CALL s_desc_get_stock_desc('',g_indc_m.indc200)
               RETURNING g_indc_m.indc200_desc
            DISPLAY BY NAME g_indc_m.indc200_desc
            NEXT FIELD indc200
            #END add-point
 
 
         #Ctrlp:input.c.indc201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc201
            #add-point:ON ACTION controlp INFIELD indc201 name="input.c.indc201"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indc_m.indc201             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_indc_m.indc006  #161108-00059#1 16/11/11 by sunxh mark
            
            #150127-00004#17 151021 By pomelo add(S)
            CALL aint510_depot_cost_chk('3','2',g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc007)
               RETURNING l_success,l_where
            LET g_qryparam.where = l_where
            #150127-00004#17 151021 By pomelo add(E)
            
            #151204-00007#10 151228 By pomelo add(S)
            LET g_qryparam.where = aint510_depot_where(1),
                                   " AND ",l_where
            #151204-00007#10 151228 By pomelo add(E)
            
            #161108-00059#1 16/11/11 by sunxh mod(S)            
#            CALL q_inaa001_4()
            IF cl_null(g_indc_m.indc006) THEN 
               LET g_qryparam.where =  g_qryparam.where," AND inaasite in(
                      SELECT DISTINCT OOED004 
                        FROM OOED_T
                        LEFT OUTER JOIN OOEFL_T ON OOEFLENT = OOEDENT
                         AND OOEFL001 = OOED004
                         AND OOEFL002 = '",g_dlang,"'
                       WHERE OOEDENT =  '",g_enterprise,"'
                         AND OOED001 = '8'
                         AND OOED006 <= '",g_today,"'
                         AND (OOED007 >= '",g_today,"' OR OOED007 IS NULL)
                         AND OOED004 IN
                            (SELECT OOED004
                               FROM OOED_T
                              START WITH OOED005 = '",g_site,"'
                                AND OOED001 = '8'
                                AND OOED006 <= '",g_today,"'
                                AND (OOED007 >= '",g_today,"' OR OOED007 IS NULL)
                            CONNECT BY NOCYCLE PRIOR OOED004 = OOED005
                                AND OOED001 = '8'
                                AND OOED006 <= '",g_today,"'
                                AND (OOED007 >= '",g_today,"' OR OOED007 IS NULL)
                              UNION
                             SELECT OOED004 FROM OOED_T WHERE OOED004 = '",g_site,"' AND ooedent = ",g_enterprise," ))"   #add by geza 20170123 #170122-00004#11 ooedent 
               CALL q_inaa001_14()
            ELSE 
               LET g_qryparam.arg1 = g_indc_m.indc006
               CALL q_inaa001_4()
            END IF 
            #161108-00059#1 16/11/11 by sunxh mod(E)
            LET g_indc_m.indc201 = g_qryparam.return1
            DISPLAY g_indc_m.indc201 TO indc201
            CALL s_desc_get_stock_desc('',g_indc_m.indc201)
               RETURNING g_indc_m.indc201_desc
            DISPLAY BY NAME g_indc_m.indc201_desc
            NEXT FIELD indc201
            #END add-point
 
 
         #Ctrlp:input.c.indc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc005
            #add-point:ON ACTION controlp INFIELD indc005 name="input.c.indc005"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indc005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #
            LET g_qryparam.arg2 = "8" #

            CALL q_ooed004()                                #呼叫開窗

            LET g_indc_m.indc005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indc_m.indc005 TO indc005              #顯示到畫面上
            CALL s_desc_get_department_desc(g_indc_m.indc005) RETURNING g_indc_m.indc005_desc
            DISPLAY BY NAME g_indc_m.indc005_desc
            NEXT FIELD indc005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc006
            #add-point:ON ACTION controlp INFIELD indc006 name="input.c.indc006"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indc006             #給予default值

			   LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                                #呼叫開窗

            LET g_indc_m.indc006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indc_m.indc006 TO indc006              #顯示到畫面上
            
            CALL s_desc_get_department_desc(g_indc_m.indc006) RETURNING g_indc_m.indc006_desc
            DISPLAY BY NAME g_indc_m.indc006_desc
            NEXT FIELD indc006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc007
            #add-point:ON ACTION controlp INFIELD indc007 name="input.c.indc007"
            #此段落由子樣板a07產生            
            #開窗i段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indc_m.indc007             #給予default值

            #給予arg
            #取参数
            CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys1
            CALL cl_get_para(g_enterprise,g_site,'E-BAS-0014') RETURNING l_sys2
            CALL cl_get_para(g_enterprise,g_site,'E-BAS-0015') RETURNING l_sys3
            IF l_sys3 = '1' THEN
			      LET g_qryparam.arg1 = g_indc_m.indc005
            ELSE
			      LET g_qryparam.arg1 = g_indc_m.indc006
            END IF
            
            #150127-00004#17 151021 By pomelo add(S)
            CALL aint510_depot_cost_chk('3','3',g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc007)
               RETURNING l_success,l_where
            LET g_qryparam.where = l_where
            #150127-00004#17 151021 By pomelo add(E)
            
            CALL q_inaa001_4()                                #呼叫開窗

            LET g_indc_m.indc007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indc_m.indc007 TO indc007              #顯示到畫面上
            
            CALL aint510_indc007_ref()

            NEXT FIELD indc007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc008
            #add-point:ON ACTION controlp INFIELD indc008 name="input.c.indc008"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.indcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcstus
            #add-point:ON ACTION controlp INFIELD indcstus name="input.c.indcstus"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.indc021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc021
            #add-point:ON ACTION controlp INFIELD indc021 name="input.c.indc021"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indc021             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_indc_m.indc021 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indc_m.indc021 TO indc021              #顯示到畫面上
            
            CALL aint510_indc021_ref()

            NEXT FIELD indc021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc022
            #add-point:ON ACTION controlp INFIELD indc022 name="input.c.indc022"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.indc023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc023
            #add-point:ON ACTION controlp INFIELD indc023 name="input.c.indc023"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indc023             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_indc_m.indc023 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indc_m.indc023 TO indc023              #顯示到畫面上
            
            CALL aint510_indc023_ref()

            NEXT FIELD indc023                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc024
            #add-point:ON ACTION controlp INFIELD indc024 name="input.c.indc024"
                                                
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_indc_m.indcdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                              
               CALL s_aooi200_gen_docno(g_site,g_indc_m.indcdocno,g_indc_m.indcdocdt,g_prog) RETURNING l_success,g_indc_m.indcdocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_indc_m.indcdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD indcdocno
               END IF
               
               #160126-00003#2 s983961--add(s)
               IF g_indc_m.indc005 != g_indc_m.indc006 THEN               
                 LET l_sys1 = ''               
                 CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys1
                 IF l_sys1 = 'Y' THEN
                   IF cl_null(g_indc_m.indc007) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00465' #當參數設定啟用在途管理時,在途倉不可為空!
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                   
                     NEXT FIELD indc007
                   END IF
                 END IF  
               END IF  

               IF g_indc_m.indc005 = g_indc_m.indc006 THEN
                 LET l_sys2 = ''
                 CALL cl_get_para(g_enterprise,g_site,'E-BAS-0014') RETURNING l_sys2
                 IF l_sys2 = 'Y' THEN
                   IF cl_null(g_indc_m.indc007) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00465' #當參數設定啟用在途管理時,在途倉不可為空!
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                   
                     NEXT FIELD indc007
                   END IF
                 END IF  
               END IF               
               #160126-00003#2 s983961--add(e)
               
               IF NOT cl_null(g_indc_m.indc007) THEN
                  LET g_indc_m.indc000 = '2'
               ELSE
                  LET g_indc_m.indc000 = '1'
               END IF         
               #end add-point
               
               INSERT INTO indc_t (indcent,indcsite,indcdocdt,indcdocno,indc001,indc004,indc101,indcunit, 
                   indc199,indc000,indc202,indc002,indc003,indc026,indc025,indc200,indc201,indc005,indc006, 
                   indc007,indc008,indcstus,indc021,indc022,indc023,indc024,indcownid,indcowndp,indccrtid, 
                   indccrtdp,indccrtdt,indcmodid,indcmoddt,indccnfid,indccnfdt)
               VALUES (g_enterprise,g_indc_m.indcsite,g_indc_m.indcdocdt,g_indc_m.indcdocno,g_indc_m.indc001, 
                   g_indc_m.indc004,g_indc_m.indc101,g_indc_m.indcunit,g_indc_m.indc199,g_indc_m.indc000, 
                   g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026,g_indc_m.indc025, 
                   g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc007, 
                   g_indc_m.indc008,g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023, 
                   g_indc_m.indc024,g_indc_m.indcownid,g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp, 
                   g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcmoddt,g_indc_m.indccnfid,g_indc_m.indccnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_indc_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
                                                            
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #150127-00004#13 15/03/17 By pomelo mark(S)
               #IF g_indc_m.indc002 = '2' AND NOT cl_null(g_indc_m.indc003) THEN
               #   CALL aint510_detail_init()
               #150127-00004#13 15/03/17 By pomelo mark(E)
               #150127-00004#13 15/03/17 By pomelo add(S)
               IF NOT cl_null(g_indc_m.indc003) THEN
                  IF NOT aint510_detail_init() THEN
               #150127-00004#13 15/03/17 By pomelo add(E)
                     LET l_allow_insert = FALSE
                     LET l_allow_delete = FALSE
                     LET g_detail_flag = '2'
                     #CALL aint510_input('u')
                     LET g_detail_flag = '1'
                     EXIT DIALOG
                  END IF                   #150127-00004#13 15/03/17 By pomelo add
               END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aint510_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aint510_b_fill()
                  CALL aint510_b_fill2('0')
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
               CALL aint510_indc_t_mask_restore('restore_mask_o')
               
               UPDATE indc_t SET (indcsite,indcdocdt,indcdocno,indc001,indc004,indc101,indcunit,indc199, 
                   indc000,indc202,indc002,indc003,indc026,indc025,indc200,indc201,indc005,indc006,indc007, 
                   indc008,indcstus,indc021,indc022,indc023,indc024,indcownid,indcowndp,indccrtid,indccrtdp, 
                   indccrtdt,indcmodid,indcmoddt,indccnfid,indccnfdt) = (g_indc_m.indcsite,g_indc_m.indcdocdt, 
                   g_indc_m.indcdocno,g_indc_m.indc001,g_indc_m.indc004,g_indc_m.indc101,g_indc_m.indcunit, 
                   g_indc_m.indc199,g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003, 
                   g_indc_m.indc026,g_indc_m.indc025,g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005, 
                   g_indc_m.indc006,g_indc_m.indc007,g_indc_m.indc008,g_indc_m.indcstus,g_indc_m.indc021, 
                   g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024,g_indc_m.indcownid,g_indc_m.indcowndp, 
                   g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcmoddt, 
                   g_indc_m.indccnfid,g_indc_m.indccnfdt)
                WHERE indcent = g_enterprise AND indcdocno = g_indcdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "indc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                                                            
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aint510_indc_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_indc_m_t)
               LET g_log2 = util.JSON.stringify(g_indc_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                                            
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_indcdocno_t = g_indc_m.indcdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aint510.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_indd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_indd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint510_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_indd_d.getLength()
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
            OPEN aint510_cl USING g_enterprise,g_indc_m.indcdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_indd_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_indd_d[l_ac].inddseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_indd_d_t.* = g_indd_d[l_ac].*  #BACKUP
               LET g_indd_d_o.* = g_indd_d[l_ac].*  #BACKUP
               CALL aint510_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                                                            
               #end add-point  
               CALL aint510_set_no_entry_b(l_cmd)
               IF NOT aint510_lock_b("indd_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint510_bcl INTO g_indd_d[l_ac].inddsite,g_indd_d[l_ac].inddunit,g_indd_d[l_ac].inddseq, 
                      g_indd_d[l_ac].indd001,g_indd_d[l_ac].indd047,g_indd_d[l_ac].indd048,g_indd_d[l_ac].indd003, 
                      g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd005, 
                      g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd008,g_indd_d[l_ac].indd009,g_indd_d[l_ac].indd020, 
                      g_indd_d[l_ac].indd021,g_indd_d[l_ac].indd045,g_indd_d[l_ac].indd046,g_indd_d[l_ac].indd010, 
                      g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd102, 
                      g_indd_d[l_ac].indd025,g_indd_d[l_ac].indd030,g_indd_d[l_ac].indd031,g_indd_d[l_ac].indd032, 
                      g_indd_d[l_ac].indd033,g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd035,g_indd_d[l_ac].indd040, 
                      g_indd_d[l_ac].indd101
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_indd_d_t.inddseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_indd_d_mask_o[l_ac].* =  g_indd_d[l_ac].*
                  CALL aint510_indd_t_mask()
                  LET g_indd_d_mask_n[l_ac].* =  g_indd_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint510_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET g_indd_d_o.* = g_indd_d[l_ac].*
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
            INITIALIZE g_indd_d[l_ac].* TO NULL 
            INITIALIZE g_indd_d_t.* TO NULL 
            INITIALIZE g_indd_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_indd_d[l_ac].indd005 = "1"
      LET g_indd_d[l_ac].indd008 = "0"
      LET g_indd_d[l_ac].indd009 = "0"
      LET g_indd_d[l_ac].indd045 = "0"
      LET g_indd_d[l_ac].indd046 = "0"
      LET g_indd_d[l_ac].indd010 = "N"
      LET g_indd_d[l_ac].indd025 = "0"
      LET g_indd_d[l_ac].indd035 = "0"
      LET g_indd_d[l_ac].indd040 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #150707-00027#3 150707 By pomelo add(S)
            IF NOT cl_null(g_indc_m.indc200) THEN
               LET g_indd_d[l_ac].indd022 = g_indc_m.indc200
               CALL s_desc_get_stock_desc('',g_indd_d[l_ac].indd022)
                  RETURNING g_indd_d[l_ac].indd022_desc
            END IF
            IF NOT cl_null(g_indc_m.indc201) THEN
               LET g_indd_d[l_ac].indd032 = g_indc_m.indc201
               CALL s_desc_get_stock_desc('',g_indd_d[l_ac].indd032)
                  RETURNING g_indd_d[l_ac].indd032_desc
            END IF
            #150707-00027#3 150707 By pomelo add(E)
            #end add-point
            LET g_indd_d_t.* = g_indd_d[l_ac].*     #新輸入資料
            LET g_indd_d_o.* = g_indd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint510_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                                
            #end add-point
            CALL aint510_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_indd_d[li_reproduce_target].* = g_indd_d[li_reproduce].*
 
               LET g_indd_d[li_reproduce_target].inddseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            CALL aint510_inddseq_init()    
            LET g_indd_d[l_ac].inddsite = g_indc_m.indcsite
            LET g_indd_d[l_ac].inddunit = g_indc_m.indcunit
            LET g_indd_d_o.* = g_indd_d[l_ac].*
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
            #161017-00029#8 -s by 08172
            #料件有使用產品特徴則不可空白
            IF g_prog MATCHES "aint511" OR g_prog MATCHES "aint513" THEN
               LET l_imaa005 = ''
               CALL aint510_get_imaa005(g_indd_d[l_ac].indd002) RETURNING l_imaa005
               IF NOT cl_null(l_imaa005) THEN
                  IF cl_null(g_indd_d[l_ac].indd004) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00124'
                     LET g_errparam.extend = g_indc_m.indcdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD indd004               
                  END IF
               ELSE 
                  IF cl_null(g_indd_d[l_ac].indd004) THEN
                     LET g_indd_d[l_ac].indd004 = ' ' 
                  END IF          
               END IF
            END IF
            #161017-00029#8 -e by 08172            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM indd_t 
             WHERE inddent = g_enterprise AND indddocno = g_indc_m.indcdocno
 
               AND inddseq = g_indd_d[l_ac].inddseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               #150519-00025#1 150520 BY pomelo add(S)
               IF NOT aint510_in_out_chk() THEN
                  NEXT FIELD indd032
               END IF
               #150519-00025#1 150520 BY pomelo add(E)                                 
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_indc_m.indcdocno
               LET gs_keys[2] = g_indd_d[g_detail_idx].inddseq
               CALL aint510_insert_b('indd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                                                            
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_indd_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint510_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #150624-00017#1 2015/06/29 By pomelo add(S)
               IF NOT s_aint510_gen_indl(g_indd_d[l_ac].inddsite, g_indd_d[l_ac].inddunit, g_indc_m.indcdocno,     g_indd_d[l_ac].inddseq,
                                         g_indd_d[l_ac].indd003,  g_indd_d[l_ac].indd002,  g_indd_d[l_ac].indd004, g_indd_d[l_ac].indd007,
                                         g_indd_d[l_ac].indd006,  g_indd_d[l_ac].indd020,  g_indd_d[l_ac].indd021, g_indd_d[l_ac].indd022,
                                         g_indd_d[l_ac].indd023,  g_indd_d[l_ac].indd024,  g_indd_d[l_ac].indd030, g_indd_d[l_ac].indd031,
                                         g_indd_d[l_ac].indd032,  g_indd_d[l_ac].indd033,  g_indd_d[l_ac].indd034, g_indd_d[l_ac].indd102,
                                         #g_indd_d[l_ac].indd010) THEN  #151204-00007#5 151215 By pomelo mark
                                         g_indd_d[l_ac].indd010,  g_indd_d[l_ac].indd045,  g_indd_d[l_ac].indd046) THEN    #151204-00007#5 151215 By pomelo add
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF
               #161017-00029#8 -s by 08172
               #如果产品特征对应多笔新增到单身
               IF g_prog MATCHES "aint511" OR g_prog MATCHES "aint513" THEN
                  INITIALIZE l_indd.* TO NULL               
                  SELECT inddent, inddsite,inddunit, indddocno, 
                         inddseq, indd001, indd002,  indd003,
                         indd004, indd005, indd006,  indd007,
                         indd008, indd009, indd020,  indd021,         
                         indd022, indd023, indd024,  indd030,         
                         indd031, indd032, indd033,  indd034,         
                         indd040, indd101, indd102,  indd103,         
                         indd104, indd105, indd106,  indd107,         
                         indd108, indd109, indd110,  indd111,         
                         indd112, indd151, indd152,  indd041,
                         indd042, indd043, indd044,  indd010,
                         indd025, indd035, indd045,  indd046,
                         indd047, indd048
                   INTO  l_indd.inddent, l_indd.inddsite,l_indd.inddunit, l_indd.indddocno,
                         l_indd.inddseq, l_indd.indd001, l_indd.indd002,  l_indd.indd003,
                         l_indd.indd004, l_indd.indd005, l_indd.indd006,  l_indd.indd007,
                         l_indd.indd008, l_indd.indd009, l_indd.indd020,  l_indd.indd021,  
                         l_indd.indd022, l_indd.indd023, l_indd.indd024,  l_indd.indd030,  
                         l_indd.indd031, l_indd.indd032, l_indd.indd033,  l_indd.indd034,  
                         l_indd.indd040, l_indd.indd101, l_indd.indd102,  l_indd.indd103,  
                         l_indd.indd104, l_indd.indd105, l_indd.indd106,  l_indd.indd107,  
                         l_indd.indd108, l_indd.indd109, l_indd.indd110,  l_indd.indd111,  
                         l_indd.indd112, l_indd.indd151, l_indd.indd152,  l_indd.indd041,
                         l_indd.indd042, l_indd.indd043, l_indd.indd044,  l_indd.indd010,
                         l_indd.indd025, l_indd.indd035, l_indd.indd045,  l_indd.indd046,
                         l_indd.indd047, l_indd.indd048
                    FROM indd_t 
                   WHERE inddent = g_enterprise
                     AND indddocno = g_indc_m.indcdocno
                     AND inddseq = g_indd_d[l_ac].inddseq
                     
                  IF l_inam.getLength() > 1 THEN  #因為第一筆資料已呈現在畫面並寫入DB, 從第二筆開始處理           
                     LET l_inddseq = ''
                     SELECT MAX(inddseq) INTO l_inddseq
                       FROM indd_t
                      WHERE inddent   = g_enterprise
                        AND indddocno = g_indc_m.indcdocno
                     
                     FOR l_i = 2 TO l_inam.getLength() 
                        IF cl_null(l_inddseq) OR l_inddseq = 0 THEN
                           LET l_inddseq = 1
                        ELSE
                           LET l_inddseq = l_inddseq + 1             
                        END IF                   
                        LET l_indd.indd004 = l_inam[l_i].inam002
                        LET l_indd.indd021 = l_inam[l_i].inam004
                        
                        #带出商品条码
                        IF NOT cl_null(l_indd.indd004) AND NOT cl_null(l_indd.indd002) THEN
                           INITIALIZE l_indd.indd003 TO NULL
                           #161228-00033#5 by sakura mark(S)
                           #SELECT imay003 INTO l_indd.indd003
                           #  FROM imay_t
                           # WHERE imayent = g_enterprise
                           #   AND imay001 = l_indd.indd002
                           #   AND imay019 = l_indd.indd004
                           #   AND imaystus = 'Y'
                           #   AND ROWNUM = 1
                           #161228-00033#5 by sakura mark(E)
                           #161228-00033#5 by sakura add(S)
                           LET g_sql = "SELECT imay003 ",
                                       "  FROM imay_t ",
                                       " WHERE imayent = ",g_enterprise,
                                       "   AND imay001 = '",l_indd.indd002,"'",
                                       "   AND imay019 = '",l_indd.indd004,"'",
                                       "   AND imaystus = 'Y' "
                           PREPARE aint510_sel_imay003_pre FROM g_sql
                           DECLARE aint510_sel_imay003_cur SCROLL CURSOR FOR aint510_sel_imay003_pre   
                           OPEN aint510_sel_imay003_cur
                           FETCH FIRST aint510_sel_imay003_cur INTO l_indd.indd003
                           CLOSE aint510_sel_imay003_cur               
                           FREE  aint510_sel_imay003_pre                           
                           #161228-00033#5 by sakura add(E)
                           IF cl_null(l_indd.indd003) THEN
                              SELECT imay003 INTO l_indd.indd003
                                FROM imay_t
                               WHERE imayent = g_enterprise
                                 AND imay001 = l_indd.indd002
                                 AND imay006 = 'Y'
                                 AND imaystus = 'Y'
                           END IF
                        END IF
                        #撥出組織庫存數量
                        CALL s_aint510_get_inag009(g_indc_m.indc005,g_indd_d[l_ac].indd002,l_indd.indd004,
                                                 g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,
                                                 g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006)            
                                       RETURNING l_indd.indd025
                        #撥入組織庫存數量
                        CALL s_aint510_get_inag009(g_indc_m.indc006,g_indd_d[l_ac].indd002,l_indd.indd004,
                                                 g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,
                                                 g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd006)            
                                       RETURNING l_indd.indd035     
                        #單位間的轉換數量
                        IF NOT cl_null(l_indd.indd021) THEN
                           CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,l_indd.indd021)
                                     RETURNING l_success,l_indd.indd020
                        END IF
                        LET l_indd.indd046 = l_indd.indd045 * l_indd.indd021
                        LET l_indd.indd030 = l_indd.indd020
                        LET l_indd.indd031 = l_indd.indd021
                        IF g_indc_m.indc002 = '1' THEN
                           LET l_indd.indd009 = l_indd.indd021
                        END IF
                        
                        INSERT INTO indd_t (inddent, inddsite,inddunit, indddocno, 
                                            inddseq, indd001, indd002,  indd003,
                                            indd004, indd005, indd006,  indd007,
                                            indd008, indd009, indd020,  indd021,         
                                            indd022, indd023, indd024,  indd030,         
                                            indd031, indd032, indd033,  indd034,         
                                            indd040, indd101, indd102,  indd103,         
                                            indd104, indd105, indd106,  indd107,         
                                            indd108, indd109, indd110,  indd111,         
                                            indd112, indd151, indd152,  indd041,
                                            indd042, indd043, indd044,  indd010,
                                            indd025, indd035, indd045,  indd046,
                                            indd047, indd048)
                            VALUES(l_indd.inddent, l_indd.inddsite,l_indd.inddunit, l_indd.indddocno,
                                   l_inddseq,      l_indd.indd001, l_indd.indd002,  l_indd.indd003,
                                   l_indd.indd004, l_indd.indd005, l_indd.indd006,  l_indd.indd007,
                                   l_indd.indd008, l_indd.indd009, l_indd.indd020,  l_indd.indd021,  
                                   l_indd.indd022, l_indd.indd023, l_indd.indd024,  l_indd.indd030,  
                                   l_indd.indd031, l_indd.indd032, l_indd.indd033,  l_indd.indd034,  
                                   l_indd.indd040, l_indd.indd101, l_indd.indd102,  l_indd.indd103,  
                                   l_indd.indd104, l_indd.indd105, l_indd.indd106,  l_indd.indd107,  
                                   l_indd.indd108, l_indd.indd109, l_indd.indd110,  l_indd.indd111,  
                                   l_indd.indd112, l_indd.indd151, l_indd.indd152,  l_indd.indd041,
                                   l_indd.indd042, l_indd.indd043, l_indd.indd044,  l_indd.indd010,
                                   l_indd.indd025, l_indd.indd035, l_indd.indd045,  l_indd.indd046,
                                   l_indd.indd047, l_indd.indd048)
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "indd_t"
                           LET g_errparam.popup = FALSE
                           CALL cl_err()
                        END IF
                        CALL s_aint510_gen_indl(l_indd.inddsite, l_indd.inddunit, l_indd.indddocno, l_inddseq,
                                                l_indd.indd003,  l_indd.indd002,  l_indd.indd004,   l_indd.indd007,
                                                l_indd.indd006,  l_indd.indd020,  l_indd.indd021,   l_indd.indd022,
                                                l_indd.indd023,  l_indd.indd024,  l_indd.indd030,   l_indd.indd031,
                                                l_indd.indd032,  l_indd.indd033,  l_indd.indd034,   l_indd.indd102,
                                                l_indd.indd010,  l_indd.indd045,  l_indd.indd046) RETURNING l_success
                        IF NOT l_success THEN
                           EXIT FOR
                        END IF                        
                     END FOR
                     LET g_rec_b = l_inam.getLength() - 1                  
                     CALL l_inam.clear() 
                  END IF
               END IF
               #161017-00029#8 -e by 08172
               CALL aint510_b_fill()               
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
               ##150728 By pomelo add(S)
               #更新自動編碼最大流水號檔
               IF NOT cl_null(g_indd_d[l_ac].indd024) THEN
                  IF NOT s_aooi390_oofi_del('6',g_indd_d[l_ac].indd024) THEN
                     CANCEL DELETE
                  END IF
               END IF
               ##150728 By pomelo add(E)
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_indc_m.indcdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_indd_d_t.inddseq
 
            
               #刪除同層單身
               IF NOT aint510_delete_b('indd_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint510_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint510_key_delete_b(gs_keys,'indd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint510_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               ##150728 By pomelo add(S)
               DELETE FROM indl_t
                WHERE indlent = g_enterprise
                  AND indldocno = g_indc_m.indcdocno
                  AND indlseq = g_indd_d_t.inddseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "indl_T"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               ##150728 By pomelo add(E)
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aint510_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                                                                        
               #end add-point
               LET l_count = g_indd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                                                
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_indd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inddsite
            #add-point:BEFORE FIELD inddsite name="input.b.page1.inddsite"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inddsite
            
            #add-point:AFTER FIELD inddsite name="input.a.page1.inddsite"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inddsite
            #add-point:ON CHANGE inddsite name="input.g.page1.inddsite"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inddunit
            #add-point:BEFORE FIELD inddunit name="input.b.page1.inddunit"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inddunit
            
            #add-point:AFTER FIELD inddunit name="input.a.page1.inddunit"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inddunit
            #add-point:ON CHANGE inddunit name="input.g.page1.inddunit"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inddseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indd_d[l_ac].inddseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD inddseq
            END IF 
 
 
 
            #add-point:AFTER FIELD inddseq name="input.a.page1.inddseq"
                                                
            IF NOT cl_null(g_indd_d[l_ac].inddseq) THEN 
            END IF 

            #此段落由子樣板a05產生
            IF  g_indc_m.indcdocno IS NOT NULL AND g_indd_d[g_detail_idx].inddseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_indc_m.indcdocno != g_indcdocno_t OR g_indd_d[g_detail_idx].inddseq != g_indd_d_t.inddseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM indd_t WHERE "||"inddent = '" ||g_enterprise|| "' AND "||"indddocno = '"||g_indc_m.indcdocno ||"' AND "|| "inddseq = '"||g_indd_d[g_detail_idx].inddseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inddseq
            #add-point:BEFORE FIELD inddseq name="input.b.page1.inddseq"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inddseq
            #add-point:ON CHANGE inddseq name="input.g.page1.inddseq"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd001
            #add-point:BEFORE FIELD indd001 name="input.b.page1.indd001"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd001
            
            #add-point:AFTER FIELD indd001 name="input.a.page1.indd001"
            #150127-00004#13 15/03/17 By pomelo add(S)
            IF NOT cl_null(g_indd_d[l_ac].indd001) THEN
               IF g_indd_d[l_ac].indd001 != g_indd_d_o.indd001 OR cl_null(g_indd_d_o.indd001) THEN
                  IF NOT aint510_chk_indd001() THEN
                     LET g_indd_d[l_ac].indd001 = g_indd_d_o.indd001
                     NEXT FIELD CURRENT
                  END IF
                  CALL aint510_indd001_default()
               END IF
            END IF
            LET g_indd_d_o.* = g_indd_d[l_ac].*
            CALL aint510_set_entry_b(l_cmd)
            CALL aint510_set_no_entry_b(l_cmd)
            #150127-00004#13 15/03/17 By pomelo add(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd001
            #add-point:ON CHANGE indd001 name="input.g.page1.indd001"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd047
            #add-point:BEFORE FIELD indd047 name="input.b.page1.indd047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd047
            
            #add-point:AFTER FIELD indd047 name="input.a.page1.indd047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd047
            #add-point:ON CHANGE indd047 name="input.g.page1.indd047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd048
            #add-point:BEFORE FIELD indd048 name="input.b.page1.indd048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd048
            
            #add-point:AFTER FIELD indd048 name="input.a.page1.indd048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd048
            #add-point:ON CHANGE indd048 name="input.g.page1.indd048"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd003
            
            #add-point:AFTER FIELD indd003 name="input.a.page1.indd003"
            IF NOT cl_null(g_indd_d[l_ac].indd003) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_indd_d[l_ac].indd003
               IF NOT cl_chk_exist("v_imay003_1") THEN
                  #LET g_indd_d[l_ac].indd003 = g_indd_d_t.indd003   #160824-00007#30 20161017 mark by beckxie
                  LET g_indd_d[l_ac].indd003 = g_indd_d_o.indd003   #160824-00007#30 20161017 add by beckxie
                  DISPLAY BY NAME g_indd_d[l_ac].indd003
                  NEXT FIELD CURRENT
               END IF
               #151204-00007#10 151228 By pomelo mark(S)
               #CALL aint510_indd003_chk()
               #IF NOT cl_null(g_errno) THEN
               #   INITIALIZE g_errparam TO NULL
               #   LET g_errparam.code = g_errno
               #   LET g_errparam.extend = g_indd_d[l_ac].indd003
               #   LET g_errparam.popup = TRUE
               #   CALL cl_err()
               #151204-00007#10 151228 By pomelo mark(E)
               IF NOT aint510_indd003_chk() THEN   #151204-00007#10 151228 By pomelo add
                  #LET g_indd_d[l_ac].indd003 = g_indd_d_t.indd003   #160824-00007#30 20161017 mark by beckxie
                  #160824-00007#30 20161017 add by beckxie---S
                  LET g_indd_d[l_ac].indd003 = g_indd_d_o.indd003
                  CALL aint510_indd003_init()
                  CALL aint510_indd002_init()
                  #160824-00007#30 20161017 add by beckxie---E
                  DISPLAY BY NAME g_indd_d[l_ac].indd003
                  NEXT FIELD CURRENT
               END IF
               #161017-00029#8 -s by 08172
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_indd_d[l_ac].indd003 != g_indd_d_t.indd003 OR g_indd_d_t.indd003 IS NULL)) THEN
#                  IF cl_null(g_indd_d_o.indd003) OR g_indd_d_o.indd003 != g_indd_d[l_ac].indd003 THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (cl_null(g_indd_d_o.indd003) OR g_indd_d_o.indd003 != g_indd_d[l_ac].indd003)) THEN
               #161017-00029#8 -e by 08172
                     CALL aint510_indd003_init()
                     CALL aint510_indd002_init()   #160503-00010#1 20160512 add by beckxie
#                  END IF
               END IF
            END IF 
            LET g_indd_d_o.* = g_indd_d[l_ac].*
            #160218-00008#1 160219 pomelo add(S)
            CALL aint510_set_entry_b(l_cmd)
            CALL aint510_set_no_entry_b(l_cmd)
            #160218-00008#1 160219 pomelo add(E)
            #161017-00029#8 -s by 08172
            #撥出組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc005,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,
                                     g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd025
            #撥入組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc006,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,
                                     g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd035 
            #161017-00029#8 -e by 08172
            #170116-00018#11 -s 20160117 mark by 08172
            #161027-00055#5 -s by 08172 add 20161029
#            IF g_indc_m.indc005 IS NOT NULL AND g_indd_d[l_ac].indd002 IS NOT NULL  THEN
#               SELECT rtdx029 INTO g_indd_d[l_ac].rtdx029
#                 FROM rtdx_t 
#                WHERE rtdxent = g_enterprise
#                  AND rtdx001 = g_indd_d[l_ac].indd002
#                  AND rtdxsite = g_indc_m.indc005
#                  AND rtdxstus = 'Y'
#               SELECT ooefl003 INTO g_indd_d[l_ac].rtdx029_desc
#                 FROM ooefl_t 
#                WHERE ooeflent = g_enterprise
#                  AND ooefl001 = g_indc_m.indc005         
#                  AND ooefl002 = g_lang          
#            END IF 
#            IF g_indd_d[l_ac].rtdx029 IS NOT NULL AND g_indd_d[l_ac].indd002 IS NOT NULL AND g_indd_d[l_ac].indd003 IS NOT NULL THEN                   
#               #CALL aint510_inag009_count(g_indd_d[l_ac].indd002,g_indd_d[l_ac].rtdx029,g_indd_d[l_ac].indd004) RETURNING g_indd_d[l_ac].inag009 #mark by geza 201611206 161124-00039#1
#               CALL aint510_inag009_count(g_indd_d[l_ac].indd002,g_indd_d[l_ac].rtdx029,g_indd_d[l_ac].indd004,'') RETURNING g_indd_d[l_ac].inag009 #add by geza 201611206 161124-00039#1
#            ELSE
#               LET g_indd_d[l_ac].inag009 = 0           
#            END IF   
            #161027-00055#5 -e by 08172 add 20161029           
            #170116-00018#11 -e 20160117 mark by 08172
            #No:161030----------------begin      #add by stcshy 161030
            CALL aint510_get_imaa(g_indd_d[l_ac].indd002) 
               #RETURNING g_indd_d[l_ac].imaa154,g_indd_d[l_ac].imaa155,g_indd_d[l_ac].imaa156,g_indd_d[l_ac].imaa132,g_indd_d[l_ac].imaa128,g_indd_d[l_ac].imaa009,g_indd_d[l_ac].imaa157 #mark by geza 20161216 #161216-00033#1
               RETURNING g_indd_d[l_ac].imaa154,g_indd_d[l_ac].imaa133,g_indd_d[l_ac].imaa156,g_indd_d[l_ac].imaa132,g_indd_d[l_ac].rtaw001,g_indd_d[l_ac].imaa009,g_indd_d[l_ac].imaa157 #add by geza 20161216 #161216-00033#1
            CALL s_desc_get_rtaxl003_desc(g_indd_d[l_ac].imaa009) RETURNING g_indd_d[l_ac].imaa009_desc
            CALL s_desc_get_rtaxl003_desc(g_indd_d[l_ac].rtaw001) RETURNING g_indd_d[l_ac].imaa128_desc #add by geza 20161216 #161216-00033#1
            CALL s_desc_get_acc_desc('2007',g_indd_d[l_ac].imaa133) RETURNING g_indd_d[l_ac].imaa133_desc #add by geza 20161216 #161216-00033#1
            #CALL s_desc_get_acc_desc('2004',g_indd_d[l_ac].imaa128) RETURNING g_indd_d[l_ac].imaa128_desc #mark by geza 20161216 #161216-00033#1        
            CALL s_desc_get_acc_desc('2006',g_indd_d[l_ac].imaa132) RETURNING g_indd_d[l_ac].imaa132_desc
            #No:161030------------------end

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd003
            #add-point:BEFORE FIELD indd003 name="input.b.page1.indd003"
            LET g_indd_d_o.* = g_indd_d[l_ac].*  #161017-00029#8 BY 08172                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd003
            #add-point:ON CHANGE indd003 name="input.g.page1.indd003"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd002
            
            #add-point:AFTER FIELD indd002 name="input.a.page1.indd002"
                                                LET g_indd_d[l_ac].indd002_desc = ''
            DISPLAY BY NAME g_indd_d[l_ac].indd002_desc
            IF NOT cl_null(g_indd_d[l_ac].indd002) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_indd_d[l_ac].indd002
               LET g_chkparam.arg2 = g_indc_m.indc005
               IF NOT cl_chk_exist("v_rtdx001_1") THEN
                  LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002
                  DISPLAY BY NAME g_indd_d[l_ac].indd002
                  CALL aint510_indd002_ref()
                  NEXT FIELD CURRENT
               END IF
#151013-00001#28---mark---begin-----by-huangrh               
#               CALL aint510_indc002_chk() 
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_indd_d[l_ac].indd002
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002
#                  DISPLAY BY NAME g_indd_d[l_ac].indd002
#                  CALL aint510_indd002_ref()
#                  NEXT FIELD CURRENT
#               END IF
#151013-00001#28---mark---end-----by-huangrh                 
               #150616-00035#11--add by dongsz--str---
               IF NOT cl_null(g_indd_d[l_ac].indd032) THEN
                  #IF NOT aint510_chk_indd002_indd032() THEN 151204-00007#10 151228 By pomelo mark
                  IF NOT aint510_chk_indd002_indd032(g_indd_d[l_ac].indd002) THEN #151204-00007#10 151228 By pomelo add
                     #LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002   #160824-00007#30 20161017 mark by beckxie
                     LET g_indd_d[l_ac].indd002 = g_indd_d_o.indd002   #160824-00007#30 20161017 add by beckxie
                     DISPLAY BY NAME g_indd_d[l_ac].indd002
                     CALL aint510_indd002_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #150616-00035#11--add by dongsz--end---
               #161017-00029#8 -s by 08172
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_indd_d[l_ac].indd002 != g_indd_d_t.indd002 OR g_indd_d_t.indd002 IS NULL)) THEN
#                  IF cl_null(g_indd_d_o.indd002) OR g_indd_d_o.indd002 != g_indd_d[l_ac].indd002 OR cl_null(g_indd_d[l_ac].indd003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (cl_null(g_indd_d_o.indd002) OR g_indd_d_o.indd002 != g_indd_d[l_ac].indd002 OR cl_null(g_indd_d[l_ac].indd003))) THEN
               #161017-00029#8 -e by 08172
                     CALL aint510_indd002_init()
                     IF NOT cl_null(g_indd_d[l_ac].indd003) THEN
                        #151013-00001#28---add--begin-----by-huangrh  
                        #151204-00007#10 151228 By pomelo mark(S)
                        #CALL aint510_indd003_chk()
                        #IF NOT cl_null(g_errno) THEN
                        #   INITIALIZE g_errparam TO NULL
                        #   LET g_errparam.code = g_errno
                        #   LET g_errparam.extend = g_indd_d[l_ac].indd002
                        #   LET g_errparam.popup = TRUE
                        #   CALL cl_err()
                        #151204-00007#10 151228 By pomelo mark(E)
                        IF NOT aint510_indd003_chk() THEN   #151204-00007#10 151228 By pomelo add
                           #LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002   #160824-00007#30 20161017 mark by beckxie
                           LET g_indd_d[l_ac].indd002 = g_indd_d_o.indd002   #160824-00007#30 20161017 add by beckxie
                           DISPLAY BY NAME g_indd_d[l_ac].indd002
                           NEXT FIELD CURRENT
                        END IF       
                        #151013-00001#28---add--end-----by-huangrh   
                        CALL aint510_indd003_init()
                     END IF
#                  END IF    #161017-00029#8  by 08172
               END IF
            END IF 
            #150709-00019#1 Add By Ken 150710(S)
            #撥出組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc005,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,
                                     g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd025
            #撥入組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc006,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,
                                     g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd035                           
            #150709-00019#1 Add By Ken 150710(E)             
            CALL aint510_indd002_ref()
            LET g_indd_d_o.* = g_indd_d[l_ac].*
            #160218-00008#1 160219 pomelo add(S)
            CALL aint510_set_entry_b(l_cmd)
            CALL aint510_set_no_entry_b(l_cmd)
            #160218-00008#1 160219 pomelo add(E)
            #170116-00018#11 -s 20160117 mark by 08172
            #161027-00055#5 -s by 08172 add 20161029
#            IF g_indc_m.indc005 IS NOT NULL AND g_indd_d[l_ac].indd002 IS NOT NULL  THEN
#               SELECT rtdx029 INTO g_indd_d[l_ac].rtdx029
#                 FROM rtdx_t 
#                WHERE rtdxent = g_enterprise
#                  AND rtdx001 = g_indd_d[l_ac].indd002
#                  AND rtdxsite = g_indc_m.indc005
#                  AND rtdxstus = 'Y'
#               SELECT ooefl003 INTO g_indd_d[l_ac].rtdx029_desc
#                 FROM ooefl_t 
#                WHERE ooeflent = g_enterprise
#                  AND ooefl001 = g_indc_m.indc005         
#                  AND ooefl002 = g_lang          
#            END IF 
#            IF g_indd_d[l_ac].rtdx029 IS NOT NULL AND g_indd_d[l_ac].indd002 IS NOT NULL AND g_indd_d[l_ac].indd003 IS NOT NULL THEN                   
#               #CALL aint510_inag009_count(g_indd_d[l_ac].indd002,g_indd_d[l_ac].rtdx029,g_indd_d[l_ac].indd004) RETURNING g_indd_d[l_ac].inag009 #mark by geza 201611206 161124-00039#1
#               CALL aint510_inag009_count(g_indd_d[l_ac].indd002,g_indd_d[l_ac].rtdx029,g_indd_d[l_ac].indd004,'') RETURNING g_indd_d[l_ac].inag009 #add by geza 201611206 161124-00039#1
#          
#            ELSE
#               LET g_indd_d[l_ac].inag009 = 0           
#            END IF   
            #161027-00055#5 -e by 08172 add 20161029
            #170116-00018#11 -e 20160117 mark by 08172
            #add by geza 20161216 #161216-00033#1(S)            
            CALL aint510_get_imaa(g_indd_d[l_ac].indd002) 
            RETURNING g_indd_d[l_ac].imaa154,g_indd_d[l_ac].imaa133,g_indd_d[l_ac].imaa156,g_indd_d[l_ac].imaa132,g_indd_d[l_ac].rtaw001,g_indd_d[l_ac].imaa009,g_indd_d[l_ac].imaa157 #add by geza 20161216 #161216-00033#1
            
            CALL s_desc_get_rtaxl003_desc(g_indd_d[l_ac].imaa009) RETURNING g_indd_d[l_ac].imaa009_desc
            CALL s_desc_get_rtaxl003_desc(g_indd_d[l_ac].rtaw001) RETURNING g_indd_d[l_ac].imaa128_desc #add by geza 20161216 #161216-00033#1
            CALL s_desc_get_acc_desc('2007',g_indd_d[l_ac].imaa133) RETURNING g_indd_d[l_ac].imaa133_desc #add by geza 20161216 #161216-00033#1
            CALL s_desc_get_acc_desc('2006',g_indd_d[l_ac].imaa132) RETURNING g_indd_d[l_ac].imaa132_desc 
            #add by geza 20161216 #161216-00033#1(E)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd002
            #add-point:BEFORE FIELD indd002 name="input.b.page1.indd002"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd002
            #add-point:ON CHANGE indd002 name="input.g.page1.indd002"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd004
            #add-point:BEFORE FIELD indd004 name="input.b.page1.indd004"
            #161017-00029#8 -s by 08172
            IF g_prog MATCHES "aint511" OR g_prog MATCHES "aint513" THEN
               IF cl_get_para(g_enterprise,g_indd_d[l_ac].inddsite,'S-BAS-0036') = 'Y' THEN 
                  IF s_feature_auto_chk(g_indd_d[l_ac].indd002) AND cl_null(g_indd_d[l_ac].indd004) THEN   
                     CALL l_inam.clear()            
                     CALL s_feature(l_cmd,g_indd_d[l_ac].indd002,'','',g_indd_d[l_ac].inddsite,g_indc_m.indcdocno) RETURNING l_success,l_inam
                     LET g_indd_d[l_ac].indd004 = l_inam[1].inam002
                     LET g_indd_d[l_ac].indd021 = l_inam[1].inam004
                     #單位間的轉換數量
                     IF cl_null(g_indd_d[l_ac].indd021) THEN
                        LET g_indd_d[l_ac].indd021 = 0
                     END IF
                     CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd021)
                            RETURNING l_success,g_indd_d[l_ac].indd020
                     
                     #撥出組織庫存數量
                     CALL s_aint510_get_inag009(g_indc_m.indc005,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                              g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,
                                              g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006)            
                                    RETURNING g_indd_d[l_ac].indd025
                     #撥入組織庫存數量
                     CALL s_aint510_get_inag009(g_indc_m.indc006,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                              g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,
                                              g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd006)            
                                    RETURNING g_indd_d[l_ac].indd035
                  LET g_indd_d[l_ac].indd046 = g_indd_d[l_ac].indd045 * g_indd_d[l_ac].indd021
                  LET g_indd_d[l_ac].indd030 = g_indd_d[l_ac].indd020
                  LET g_indd_d[l_ac].indd031 = g_indd_d[l_ac].indd021
                  IF g_indc_m.indc002 = '1' THEN
                     LET g_indd_d[l_ac].indd009 = g_indd_d[l_ac].indd021
                  END IF
                  END IF
               END IF
            END IF               
            #161017-00029#8 -e by 08172            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd004
            
            #add-point:AFTER FIELD indd004 name="input.a.page1.indd004"
            #161017-00029#8 -s by 08172
            IF g_prog MATCHES "aint511" OR g_prog MATCHES "aint513" THEN
               IF NOT cl_null(g_indd_d[l_ac].indd004) THEN 
                  IF g_indd_d[l_ac].indd004 != g_indd_d_o.indd004 OR g_indd_d_o.indd004 IS NULL THEN 
                     IF NOT s_feature_check(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004) THEN
                        LET g_indd_d[l_ac].indd004 = g_indd_d_o.indd004
                        LET g_indd_d[l_ac].indd021 = g_indd_d_o.indd021 
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT s_feature_direct_input(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d_o.indd004,g_indc_m.indcdocno,g_indc_m.indcsite) THEN
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  IF NOT cl_null(l_imaa005) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  'sub-00124'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_indd_d[l_ac].indd004 = ' '
                  END IF
               END IF
            END IF
            #161017-00029#8 -e by 08172
            #150709-00019#1 Add By Ken 150710(S)
            #撥出組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc005,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,
                                     g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd025
            #撥入組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc006,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,
                                     g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd035                           
            #150709-00019#1 Add By Ken 150710(E) 
            #161017-00029#5 -s by 08172
            IF g_prog MATCHES "aint511" OR g_prog MATCHES "aint513" THEN
               IF NOT cl_null(g_indd_d[l_ac].indd004) AND NOT cl_null(g_indd_d[l_ac].indd002) THEN
                  INITIALIZE g_indd_d[l_ac].indd003 TO NULL
                  #161228-00033#5 by sakura mark(S)
                  #SELECT imay003 INTO g_indd_d[l_ac].indd003
                  #  FROM imay_t
                  # WHERE imayent = g_enterprise
                  #   AND imay001 = g_indd_d[l_ac].indd002
                  #   AND imay019 = g_indd_d[l_ac].indd004
                  #   AND imaystus = 'Y'
                  #   AND ROWNUM = 1
                  #161228-00033#5 by sakura mark(E)
                  #161228-00033#5 by sakura add(S)
                  LET g_sql = "SELECT imay003 ",
                              "  FROM imay_t ",
                              " WHERE imayent = ",g_enterprise,
                              "   AND imay001 = '",g_indd_d[l_ac].indd002,"'",
                              "   AND imay019 = '",g_indd_d[l_ac].indd004,"'",
                              "   AND imaystus = 'Y' "
                  PREPARE aint510_sel_imay003_pre1 FROM g_sql
                  DECLARE aint510_sel_imay003_cur1 SCROLL CURSOR FOR aint510_sel_imay003_pre1   
                  OPEN aint510_sel_imay003_cur1
                  FETCH FIRST aint510_sel_imay003_cur1 INTO g_indd_d[l_ac].indd003
                  CLOSE aint510_sel_imay003_cur1               
                  FREE  aint510_sel_imay003_pre1                           
                  #161228-00033#5 by sakura add(E)                     
                  IF cl_null(g_indd_d[l_ac].indd003) THEN
                     SELECT imay003 INTO g_indd_d[l_ac].indd003
                       FROM imay_t
                      WHERE imayent = g_enterprise
                        AND imay001 = g_indd_d[l_ac].indd002
                        AND imay006 = 'Y'
                        AND imaystus = 'Y'
                  END IF
                  DISPLAY BY NAME g_indd_d[l_ac].indd003
               END IF
            END IF
            #161017-00029#5 -e by 08172            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd004
            #add-point:ON CHANGE indd004 name="input.g.page1.indd004"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa154
            #add-point:BEFORE FIELD imaa154 name="input.b.page1.imaa154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa154
            
            #add-point:AFTER FIELD imaa154 name="input.a.page1.imaa154"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa154
            #add-point:ON CHANGE imaa154 name="input.g.page1.imaa154"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa133
            
            #add-point:AFTER FIELD imaa133 name="input.a.page1.imaa133"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indd_d[l_ac].imaa133
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='2007' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indd_d[l_ac].imaa133_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indd_d[l_ac].imaa133_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa133
            #add-point:BEFORE FIELD imaa133 name="input.b.page1.imaa133"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa133
            #add-point:ON CHANGE imaa133 name="input.g.page1.imaa133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa156
            #add-point:BEFORE FIELD imaa156 name="input.b.page1.imaa156"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa156
            
            #add-point:AFTER FIELD imaa156 name="input.a.page1.imaa156"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa156
            #add-point:ON CHANGE imaa156 name="input.g.page1.imaa156"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa132
            
            #add-point:AFTER FIELD imaa132 name="input.a.page1.imaa132"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa132
            #add-point:BEFORE FIELD imaa132 name="input.b.page1.imaa132"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa132
            #add-point:ON CHANGE imaa132 name="input.g.page1.imaa132"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa132_desc
            #add-point:BEFORE FIELD imaa132_desc name="input.b.page1.imaa132_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa132_desc
            
            #add-point:AFTER FIELD imaa132_desc name="input.a.page1.imaa132_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa132_desc
            #add-point:ON CHANGE imaa132_desc name="input.g.page1.imaa132_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaw001
            #add-point:BEFORE FIELD rtaw001 name="input.b.page1.rtaw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaw001
            
            #add-point:AFTER FIELD rtaw001 name="input.a.page1.rtaw001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaw001
            #add-point:ON CHANGE rtaw001 name="input.g.page1.rtaw001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa128_desc
            #add-point:BEFORE FIELD imaa128_desc name="input.b.page1.imaa128_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa128_desc
            
            #add-point:AFTER FIELD imaa128_desc name="input.a.page1.imaa128_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa128_desc
            #add-point:ON CHANGE imaa128_desc name="input.g.page1.imaa128_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="input.a.page1.imaa009"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="input.b.page1.imaa009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa009
            #add-point:ON CHANGE imaa009 name="input.g.page1.imaa009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009_desc
            #add-point:BEFORE FIELD imaa009_desc name="input.b.page1.imaa009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009_desc
            
            #add-point:AFTER FIELD imaa009_desc name="input.a.page1.imaa009_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa009_desc
            #add-point:ON CHANGE imaa009_desc name="input.g.page1.imaa009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa157
            #add-point:BEFORE FIELD imaa157 name="input.b.page1.imaa157"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa157
            
            #add-point:AFTER FIELD imaa157 name="input.a.page1.imaa157"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa157
            #add-point:ON CHANGE imaa157 name="input.g.page1.imaa157"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd006
            
            #add-point:AFTER FIELD indd006 name="input.a.page1.indd006"
            LET g_indd_d[l_ac].indd006_desc = ''
            DISPLAY BY NAME g_indd_d[l_ac].indd006_desc
            IF NOT cl_null(g_indd_d[l_ac].indd006) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_indd_d[l_ac].indd006
               #160318-00025#18  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#18  by 07900 --add-end
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_indd_d[l_ac].indd006 = g_indd_d_t.indd006
                  DISPLAY BY NAME g_indd_d[l_ac].indd006
                  CALL aint510_indd006_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL aint510_indd006_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd006
            #add-point:BEFORE FIELD indd006 name="input.b.page1.indd006"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd006
            #add-point:ON CHANGE indd006 name="input.g.page1.indd006"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd005
            #add-point:BEFORE FIELD indd005 name="input.b.page1.indd005"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd005
            
            #add-point:AFTER FIELD indd005 name="input.a.page1.indd005"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd005
            #add-point:ON CHANGE indd005 name="input.g.page1.indd005"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd007
            
            #add-point:AFTER FIELD indd007 name="input.a.page1.indd007"
            LET g_indd_d[l_ac].indd007_desc = ''
            DISPLAY BY NAME g_indd_d[l_ac].indd007_desc
            IF NOT cl_null(g_indd_d[l_ac].indd007) THEN
               IF g_indd_d[l_ac].indd007 != g_indd_d_o.indd007 OR cl_null(g_indd_d_o.indd007) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indd_d[l_ac].indd007
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#18  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_indd_d[l_ac].indd007 = g_indd_d_t.indd007
                     DISPLAY BY NAME g_indd_d[l_ac].indd007
                     CALL aint510_indd007_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aint510_outnum_change('1')
               END IF
            END IF
            CALL aint510_indd007_ref()
            LET g_indd_d_o.* = g_indd_d[l_ac].*
            CALL aint510_set_entry_b(l_cmd)
            CALL aint510_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd007
            #add-point:BEFORE FIELD indd007 name="input.b.page1.indd007"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd007
            #add-point:ON CHANGE indd007 name="input.g.page1.indd007"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd008
            #add-point:BEFORE FIELD indd008 name="input.b.page1.indd008"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd008
            
            #add-point:AFTER FIELD indd008 name="input.a.page1.indd008"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd008
            #add-point:ON CHANGE indd008 name="input.g.page1.indd008"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd009
            #add-point:BEFORE FIELD indd009 name="input.b.page1.indd009"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd009
            
            #add-point:AFTER FIELD indd009 name="input.a.page1.indd009"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd009
            #add-point:ON CHANGE indd009 name="input.g.page1.indd009"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indd_d[l_ac].indd020,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD indd020
            END IF 
 
 
 
            #add-point:AFTER FIELD indd020 name="input.a.page1.indd020"
            IF NOT cl_null(g_indd_d[l_ac].indd020) THEN 
               IF g_indd_d[l_ac].indd020 != g_indd_d_o.indd020 OR cl_null(g_indd_d_o.indd020) THEN
                  IF g_indc_m.indc002 = '2' AND NOT cl_null(g_indd_d[l_ac].indd009) THEN
                     IF g_indd_d[l_ac].indd020 > g_indd_d[l_ac].indd009 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ain-00157'
                        LET g_errparam.extend = g_indd_d[l_ac].indd020
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_indd_d[l_ac].indd020 = g_indd_d_o.indd020
                        DISPLAY BY NAME g_indd_d[l_ac].indd020
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL aint510_outnum_change('2')
                  #150127-00004#13 15/03/17 By pomelo add(S)
                  #倉退
                  IF g_indc_m.indc002 = '6' THEN
                     IF NOT aint510_chk_indd020() THEN
                        LET g_indd_d[l_ac].indd020 = g_indd_d_o.indd020
                        LET g_indd_d[l_ac].indd021 = g_indd_d_o.indd021
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #150127-00004#13 15/03/17 By pomelo add(E)
               END IF
            END IF 
            LET g_indd_d[l_ac].indd030 = g_indd_d[l_ac].indd020
            LET g_indd_d[l_ac].indd031 = g_indd_d[l_ac].indd021
            IF g_indc_m.indc002 = '1' THEN
               LET g_indd_d[l_ac].indd009 = g_indd_d[l_ac].indd021
            END IF
            LET g_indd_d_o.* = g_indd_d[l_ac].*
            CALL aint510_set_entry_b(l_cmd)
            CALL aint510_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd020
            #add-point:BEFORE FIELD indd020 name="input.b.page1.indd020"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd020
            #add-point:ON CHANGE indd020 name="input.g.page1.indd020"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indd_d[l_ac].indd021,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD indd021
            END IF 
 
 
 
            #add-point:AFTER FIELD indd021 name="input.a.page1.indd021"
                                                
            IF NOT cl_null(g_indd_d[l_ac].indd021) THEN 
               IF cl_null(g_indd_d_o.indd021) OR g_indd_d[l_ac].indd021 != g_indd_d_o.indd021 THEN
                  IF g_indc_m.indc002 = '2' AND NOT cl_null(g_indd_d[l_ac].indd009) THEN
                     IF g_indd_d[l_ac].indd021 > g_indd_d[l_ac].indd009 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ain-00157'
                        LET g_errparam.extend = g_indd_d[l_ac].indd021
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_indd_d[l_ac].indd021 = g_indd_d_o.indd021
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  #150127-00004#13 15/03/17 By pomelo add(S)
                  #倉退
                  IF g_indc_m.indc002 = '6' THEN
                     IF NOT aint510_chk_indd020() THEN
                        LET g_indd_d[l_ac].indd021 = g_indd_d_o.indd021
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #150127-00004#13 15/03/17 By pomelo add(E)
                  CALL aint510_outnum_change('1')
               END IF
            END IF 
            LET g_indd_d[l_ac].indd030 = g_indd_d[l_ac].indd020
            LET g_indd_d[l_ac].indd031 = g_indd_d[l_ac].indd021
            IF g_indc_m.indc002 = '1' THEN
               LET g_indd_d[l_ac].indd009 = g_indd_d[l_ac].indd021
            END IF
            LET g_indd_d_o.* = g_indd_d[l_ac].*
            CALL aint510_set_entry_b(l_cmd)
            CALL aint510_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd021
            #add-point:BEFORE FIELD indd021 name="input.b.page1.indd021"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd021
            #add-point:ON CHANGE indd021 name="input.g.page1.indd021"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd045
            #add-point:BEFORE FIELD indd045 name="input.b.page1.indd045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd045
            
            #add-point:AFTER FIELD indd045 name="input.a.page1.indd045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd045
            #add-point:ON CHANGE indd045 name="input.g.page1.indd045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd046
            #add-point:BEFORE FIELD indd046 name="input.b.page1.indd046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd046
            
            #add-point:AFTER FIELD indd046 name="input.a.page1.indd046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd046
            #add-point:ON CHANGE indd046 name="input.g.page1.indd046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd010
            #add-point:BEFORE FIELD indd010 name="input.b.page1.indd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd010
            
            #add-point:AFTER FIELD indd010 name="input.a.page1.indd010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd010
            #add-point:ON CHANGE indd010 name="input.g.page1.indd010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd022
            
            #add-point:AFTER FIELD indd022 name="input.a.page1.indd022"
            LET g_indd_d[l_ac].indd022_desc = ''
            DISPLAY BY NAME g_indd_d[l_ac].indd022_desc
            #150324-00007#1 2015/04/10 By pomelo mark(S)
            #IF NOT cl_null(g_indd_d[l_ac].indd022) THEN 
            #   INITIALIZE g_chkparam.* TO NULL
            #   LET g_errshow = '1'
            #   LET g_chkparam.arg1 = g_indc_m.indc005
            #   LET g_chkparam.arg2 = g_indd_d[l_ac].indd022
            #   IF NOT cl_chk_exist("v_inaa001") THEN
            #      LET g_indd_d[l_ac].indd022 = g_indd_d_t.indd022
            #      DISPLAY BY NAME g_indd_d[l_ac].indd022
            #      CALL aint510_indd022_ref()
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF 
            #150324-00007#1 2015/04/10 By pomelo mark(E)
            #150324-00007#1 2015/04/10 By pomelo add(S)
            IF NOT cl_null(g_indd_d[l_ac].indd022) THEN 
               IF g_indd_d[l_ac].indd022 != g_indd_d_o.indd022 OR cl_null(g_indd_d_o.indd022) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indc_m.indc005
                  LET g_chkparam.arg2 = g_indd_d[l_ac].indd022
                  LET g_chkparam.err_str[1] = "aim-00064:art-00154"   #160329-00005#1 add
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[2] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#19  by 07900 --add-end
                  IF cl_chk_exist("v_inaa001") THEN
                     
                     #150127-00004#17 151021 By pomelo add(S)
                     CALL aint510_depot_cost_chk('2','1',g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd032,g_indc_m.indc007)
                        RETURNING l_success,l_where
                     IF NOT l_success THEN
                        LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022
                        CALL aint510_indd022_ref()
                        NEXT FIELD CURRENT
                     END IF
                     #150127-00004#17 151021 By pomelo add(S)
                     
                     #儲位
                     IF NOT cl_null(g_indd_d[l_ac].indd023) THEN
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_indc_m.indc005
                        LET g_chkparam.arg2 = g_indd_d[l_ac].indd022
                        LET g_chkparam.arg3 = g_indd_d[l_ac].indd023
                        #160318-00025#19  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                        #160318-00025#19  by 07900 --add-end
                        IF NOT cl_chk_exist("v_inab002") THEN
                           LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022   #庫位
                           LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023   #儲位
                           CALL aint510_indd022_ref()
                           CALL aint510_indd023_ref()
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022   #庫位
                     LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023   #儲位
                     CALL aint510_indd022_ref()
                     CALL aint510_indd023_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_indd_d_o.indd022 = g_indd_d[l_ac].indd022   #庫位
            LET g_indd_d_o.indd023 = g_indd_d[l_ac].indd023   #儲位
            #150709-00019#1 Add By Ken 150710(S)
            CALL s_aint510_get_inag009(g_indc_m.indc005,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,
                                     g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd025
            #150709-00019#1 Add By Ken 150710(E)            
            CALL aint510_indd023_ref()
            #150324-00007#1 2015/04/10 By pomelo add(E)
            CALL aint510_indd022_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd022
            #add-point:BEFORE FIELD indd022 name="input.b.page1.indd022"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd022
            #add-point:ON CHANGE indd022 name="input.g.page1.indd022"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd023
            
            #add-point:AFTER FIELD indd023 name="input.a.page1.indd023"
            LET g_indd_d[l_ac].indd023_desc = ''
            DISPLAY BY NAME g_indd_d[l_ac].indd023_desc
            #150324-00007#1 2015/04/10 By pomelo mark(S)
            #IF NOT cl_null(g_indd_d[l_ac].indd023) THEN 
            #   INITIALIZE g_chkparam.* TO NULL
            #   LET g_errshow = '1'
            #   LET g_chkparam.arg1 = g_indc_m.indc005
            #   LET g_chkparam.arg2 = g_indd_d[l_ac].indd022
            #   LET g_chkparam.arg3 = g_indd_d[l_ac].indd023
            #   IF NOT cl_chk_exist("v_inab002") THEN
            #      LET g_indd_d[l_ac].indd023 = g_indd_d_t.indd023
            #      DISPLAY BY NAME g_indd_d[l_ac].indd023
            #      CALL aint510_indd023_ref()
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF
            #150324-00007#1 2015/04/10 By pomelo mark(E)
            #150324-00007#1 2015/04/10 By pomelo add(S)
            IF NOT cl_null(g_indd_d[l_ac].indd023) THEN 
               IF g_indd_d[l_ac].indd023 != g_indd_d_o.indd023 OR cl_null(g_indd_d_o.indd023) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_indc_m.indc005
                  LET g_chkparam.arg2 = g_indd_d[l_ac].indd022
                  LET g_chkparam.arg3 = g_indd_d[l_ac].indd023
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inab002") THEN
                     LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023
                     CALL aint510_indd023_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #150709-00019#1 Add By Ken 150710(S)
            CALL s_aint510_get_inag009(g_indc_m.indc005,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,
                                     g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd025
            #150709-00019#1 Add By Ken 150710(E)            
            LET g_indd_d_o.indd023 = g_indd_d[l_ac].indd023   #儲位
            #150324-00007#1 2015/04/10 By pomelo add(E)
            CALL aint510_indd023_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd023
            #add-point:BEFORE FIELD indd023 name="input.b.page1.indd023"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd023
            #add-point:ON CHANGE indd023 name="input.g.page1.indd023"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd024
            #add-point:BEFORE FIELD indd024 name="input.b.page1.indd024"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd024
            
            #add-point:AFTER FIELD indd024 name="input.a.page1.indd024"
            #150324-00007#1 2015/04/10 By pomelo mark(S)
            #IF NOT cl_null(g_indd_d[l_ac].indd024) THEN 
            #   INITIALIZE g_chkparam.* TO NULL
            #   LET g_errshow = '1'
            #   LET g_chkparam.arg1 = g_indd_d[l_ac].indd024
            #   IF NOT cl_chk_exist("v_inai006") THEN
            #      LET g_indd_d[l_ac].indd024 = g_indd_d[l_ac].indd024
            #      DISPLAY BY NAME g_indd_d[l_ac].indd024
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF 
            #150324-00007#1 2015/04/10 By pomelo mark(E)

            #150709-00019#1 Add By Ken 150710(S)
            CALL s_aint510_get_inag009(g_indc_m.indc005,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,
                                     g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd025
            #150709-00019#1 Add By Ken 150710(E)
            LET g_indd_d[l_ac].indd034=g_indd_d[l_ac].indd024  #150619-00012#1 15/06/22 by sakura 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd024
            #add-point:ON CHANGE indd024 name="input.g.page1.indd024"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd102
            #add-point:BEFORE FIELD indd102 name="input.b.page1.indd102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd102
            
            #add-point:AFTER FIELD indd102 name="input.a.page1.indd102"
            #150709-00019#1 Add By Ken 150710(S)
            #撥出組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc005,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,
                                     g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd025
            #撥入組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc006,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,
                                     g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd035                           
            #150709-00019#1 Add By Ken 150710(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd102
            #add-point:ON CHANGE indd102 name="input.g.page1.indd102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd025
            #add-point:BEFORE FIELD indd025 name="input.b.page1.indd025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd025
            
            #add-point:AFTER FIELD indd025 name="input.a.page1.indd025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd025
            #add-point:ON CHANGE indd025 name="input.g.page1.indd025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd030
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indd_d[l_ac].indd030,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD indd030
            END IF 
 
 
 
            #add-point:AFTER FIELD indd030 name="input.a.page1.indd030"
                                                
            IF NOT cl_null(g_indd_d[l_ac].indd030) THEN
               IF cl_null(g_indd_d_o.indd030) OR g_indd_d[l_ac].indd030 != g_indd_d_o.indd030 THEN
                  IF g_indd_d[l_ac].indd020 < g_indd_d[l_ac].indd030 THEN
                     #撥入件數不可以大於撥出件數
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00072'
                     LET g_errparam.extend = g_indd_d[l_ac].indd030
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_indd_d[l_ac].indd030 = g_indd_d_o.indd030
                     NEXT FIELD CURRENT
                  END IF
                  CALL aint510_innum_change('2')
               END IF
            END IF 
            LET g_indd_d_o.* = g_indd_d[l_ac].*
            CALL aint510_set_entry_b(l_cmd)
            CALL aint510_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd030
            #add-point:BEFORE FIELD indd030 name="input.b.page1.indd030"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd030
            #add-point:ON CHANGE indd030 name="input.g.page1.indd030"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indd_d[l_ac].indd031,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD indd031
            END IF 
 
 
 
            #add-point:AFTER FIELD indd031 name="input.a.page1.indd031"
                                                
            IF NOT cl_null(g_indd_d[l_ac].indd031) THEN 
               IF cl_null(g_indd_d_o.indd031) OR g_indd_d[l_ac].indd031 != g_indd_d_o.indd031 THEN
                  IF g_indd_d[l_ac].indd021 < g_indd_d[l_ac].indd031 AND NOT cl_null(g_indd_d[l_ac].indd021) THEN
                     #撥入數量不可大於撥出數量
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ain-00073'
                        LET g_errparam.extend = g_indd_d[l_ac].indd031
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_indd_d[l_ac].indd031 = g_indd_d_o.indd031
                        DISPLAY BY NAME g_indd_d[l_ac].indd031
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL aint510_innum_change('1')
               END IF
            END IF 
            LET g_indd_d_o.* = g_indd_d[l_ac].*
            CALL aint510_set_entry_b(l_cmd)
            CALL aint510_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd031
            #add-point:BEFORE FIELD indd031 name="input.b.page1.indd031"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd031
            #add-point:ON CHANGE indd031 name="input.g.page1.indd031"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd032
            
            #add-point:AFTER FIELD indd032 name="input.a.page1.indd032"
            LET g_indd_d[l_ac].indd032_desc = ''
            DISPLAY BY NAME g_indd_d[l_ac].indd032_desc
            IF NOT cl_null(g_indd_d[l_ac].indd032) THEN 
               IF g_indd_d[l_ac].indd032 != g_indd_d_o.indd032 OR cl_null(g_indd_d_o.indd032) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = '1'
                  LET g_chkparam.arg1 = g_indc_m.indc006
                  LET g_chkparam.arg2 = g_indd_d[l_ac].indd032
                  LET g_chkparam.err_str[1] = "aim-00064:art-00154"   #160329-00005#1 add
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[2] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     LET g_indd_d[l_ac].indd032 = g_indd_d_o.indd032
                     DISPLAY BY NAME g_indd_d[l_ac].indd032
                     CALL aint510_indd032_ref()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #150127-00004#17 151021 By pomelo add(S)
                  CALL aint510_depot_cost_chk('2','2',g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd032,g_indc_m.indc007)
                     RETURNING l_success,l_where
                  IF NOT l_success THEN
                     LET g_indd_d[l_ac].indd032 = g_indd_d_o.indd032
                     CALL aint510_indd032_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #150127-00004#17 151021 By pomelo add(S)
                  
                  #150616-00035#11--add by dongsz--str---
                  IF NOT cl_null(g_indd_d[l_ac].indd002) THEN
                     #IF NOT aint510_chk_indd002_indd032() THEN  151204-00007#10 151228 By pomelo mark
                     IF NOT aint510_chk_indd002_indd032(g_indd_d[l_ac].indd002) THEN #151204-00007#10 151228 By pomelo add
                        LET g_indd_d[l_ac].indd032 = g_indd_d_o.indd032
                        DISPLAY BY NAME g_indd_d[l_ac].indd032
                        CALL aint510_indd032_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #150616-00035#11--add by dongsz--end---
               END IF
            END IF 
            #150709-00019#1 Add By Ken 150710(S)
            #撥入組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc006,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,
                                     g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd035                           
            #150709-00019#1 Add By Ken 150710(E)            
            CALL aint510_indd032_ref()
            LET g_indd_d_o.indd032 = g_indd_d[l_ac].indd032
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd032
            #add-point:BEFORE FIELD indd032 name="input.b.page1.indd032"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd032
            #add-point:ON CHANGE indd032 name="input.g.page1.indd032"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd033
            
            #add-point:AFTER FIELD indd033 name="input.a.page1.indd033"
            LET g_indd_d[l_ac].indd033_desc = ''
            DISPLAY BY NAME g_indd_d[l_ac].indd033_desc
            IF NOT cl_null(g_indd_d[l_ac].indd033) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_indc_m.indc006
               LET g_chkparam.arg2 = g_indd_d[l_ac].indd032
               LET g_chkparam.arg3 = g_indd_d[l_ac].indd033
               #160318-00025#19  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
               #160318-00025#19  by 07900 --add-end
               IF NOT cl_chk_exist("v_inab002") THEN
                  LET g_indd_d[l_ac].indd033 = g_indd_d_t.indd033
                  DISPLAY BY NAME g_indd_d[l_ac].indd033
                  CALL aint510_indd033_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #150709-00019#1 Add By Ken 150710(S)
            #撥入組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc006,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,
                                     g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd035                           
            #150709-00019#1 Add By Ken 150710(E)            
            CALL aint510_indd033_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd033
            #add-point:BEFORE FIELD indd033 name="input.b.page1.indd033"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd033
            #add-point:ON CHANGE indd033 name="input.g.page1.indd033"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd034
            
            #add-point:AFTER FIELD indd034 name="input.a.page1.indd034"
                                                
            IF NOT cl_null(g_indd_d[l_ac].indd034) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_indd_d[l_ac].indd034
               IF NOT cl_chk_exist("v_inai006") THEN
                  LET g_indd_d[l_ac].indd034 = g_indd_d_t.indd034
                  DISPLAY BY NAME g_indd_d[l_ac].indd034
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #150709-00019#1 Add By Ken 150710(S)
            #撥入組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc006,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,
                                     g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,
                                     g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd006)            
                           RETURNING g_indd_d[l_ac].indd035                           
            #150709-00019#1 Add By Ken 150710(E)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd034
            #add-point:BEFORE FIELD indd034 name="input.b.page1.indd034"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd034
            #add-point:ON CHANGE indd034 name="input.g.page1.indd034"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd035
            #add-point:BEFORE FIELD indd035 name="input.b.page1.indd035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd035
            
            #add-point:AFTER FIELD indd035 name="input.a.page1.indd035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd035
            #add-point:ON CHANGE indd035 name="input.g.page1.indd035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd040
            #add-point:BEFORE FIELD indd040 name="input.b.page1.indd040"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd040
            
            #add-point:AFTER FIELD indd040 name="input.a.page1.indd040"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd040
            #add-point:ON CHANGE indd040 name="input.g.page1.indd040"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd101
            #add-point:BEFORE FIELD indd101 name="input.b.page1.indd101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd101
            
            #add-point:AFTER FIELD indd101 name="input.a.page1.indd101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd101
            #add-point:ON CHANGE indd101 name="input.g.page1.indd101"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inddsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inddsite
            #add-point:ON ACTION controlp INFIELD inddsite name="input.c.page1.inddsite"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.inddunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inddunit
            #add-point:ON ACTION controlp INFIELD inddunit name="input.c.page1.inddunit"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.inddseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inddseq
            #add-point:ON ACTION controlp INFIELD inddseq name="input.c.page1.inddseq"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd001
            #add-point:ON ACTION controlp INFIELD indd001 name="input.c.page1.indd001"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd047
            #add-point:ON ACTION controlp INFIELD indd047 name="input.c.page1.indd047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd048
            #add-point:ON ACTION controlp INFIELD indd048 name="input.c.page1.indd048"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd003
            #add-point:ON ACTION controlp INFIELD indd003 name="input.c.page1.indd003"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd003             #給予default值

            #給予arg
			LET g_qryparam.where = "     imay001 IN (SELECT rtdx001 ",
			                       "                   FROM rtdx_t ",
			                       "                  WHERE rtdxent = '",g_enterprise,"' ",
			                       "                    AND rtdxsite = '",g_indc_m.indc005,"' ",
			                       "                    AND rtdxstus = 'Y') "
#151013-00001#28---mark---begin--			                       
#			                       " AND imay001 IN (SELECT rtdx001 ",
#			                       "                   FROM rtdx_t ",
#			                       "                  WHERE rtdxent = '",g_enterprise,"' ",
#			                       "                    AND rtdxsite = '",g_indc_m.indc006,"' ",
#			                       "                    AND rtdxstus = 'Y') "
#151013-00001#28---mark---end--	
            #151225-00011#10 151229 By pomelo add(S)
            IF NOT cl_null(g_indd_d[l_ac].indd032) AND g_indc_m.indc199 = '5' THEN
               LET l_inaa106 = ''
               SELECT inaa106 INTO l_inaa106
                 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_indc_m.indc006
                  AND inaa001 = g_indd_d[l_ac].indd032
               #取得品類管理層級
               CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_sys
               
               #管理品類篩選               
               LET g_qryparam.where = g_qryparam.where CLIPPED,
                                      " AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t ",
                                      "                   WHERE rtaxent =",g_enterprise,
                                      "                     AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                                      "                   START WITH rtax001 = '",l_inaa106,"' ",
                                      "                   CONNECT BY NOCYCLE PRIOR rtax001 = rtax003)"
            END IF
            #151225-00011#10 151229 By pomelo add(E)
            CALL q_imay003_3()                                #呼叫開窗

            LET g_indd_d[l_ac].indd003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indd_d[l_ac].indd003 TO indd003              #顯示到畫面上
            
            CALL aint510_indd003_init()

            NEXT FIELD indd003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd002
            #add-point:ON ACTION controlp INFIELD indd002 name="input.c.page1.indd002"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd002             #給予default值

            #151225-00011#10 151229 By pomelo add(S)
            IF NOT cl_null(g_indd_d[l_ac].indd032) AND g_indc_m.indc199 = '5' THEN
               LET l_inaa106 = ''
               SELECT inaa106 INTO l_inaa106
                 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_indc_m.indc006
                  AND inaa001 = g_indd_d[l_ac].indd032
               #取得品類管理層級
               CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_sys
               
               LET g_qryparam.arg1 = 'ALL'
               LET g_qryparam.arg2 = g_indc_m.indc005
               #管理品類篩選               
               LET g_qryparam.where = g_qryparam.where CLIPPED,
                                      " imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t ",
                                      "               WHERE rtaxent =",g_enterprise,
                                      "                 AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                                      "               START WITH rtax001 = '",l_inaa106,"' ",
                                      "               CONNECT BY NOCYCLE PRIOR rtax001 = rtax003)"
               CALL q_imaf001_18()
            ELSE
            #151225-00011#10 151229 By pomelo add(E)
               #給予arg
   			   LET g_qryparam.arg1 = g_indc_m.indc005
   #151013-00001#28---mark---begin--				
   #			LET g_qryparam.where = "     rtdx001 IN (SELECT rtdx001 ",
   #			                       "                   FROM rtdx_t ",
   #			                       "                  WHERE rtdxent = '",g_enterprise,"' ",
   #			                       "                    AND rtdxsite = '",g_indc_m.indc006,"' ",
   #			                       "                    AND rtdxstus = 'Y') "
   #151013-00001#28---mark---end--				                       
   
               CALL q_rtdx001_1()                                #呼叫開窗
            END IF   #151225-00011#10 151229 By pomelo add
            LET g_indd_d[l_ac].indd002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indd_d[l_ac].indd002 TO indd002              #顯示到畫面上
            
            CALL aint510_indd002_init()
            IF NOT cl_null(g_indd_d[l_ac].indd003) THEN
               CALL aint510_indd003_init()
            END IF
            
            CALL aint510_indd002_ref()

            NEXT FIELD indd002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd004
            #add-point:ON ACTION controlp INFIELD indd004 name="input.c.page1.indd004"
            #161017-00029#8 -s by 08172
            IF g_prog MATCHES "aint511" OR g_prog MATCHES "aint513" THEN
               LET l_imaa005 = ''
               CALL aint510_get_imaa005(g_indd_d[l_ac].indd002) RETURNING l_imaa005
                  
               IF NOT cl_null(l_imaa005) THEN
                  IF l_cmd = 'a' THEN            
                     CALL l_inam.clear()            
                     CALL s_feature(l_cmd,g_indd_d[l_ac].indd002,'','',g_site,g_indc_m.indcdocno) 
                        RETURNING l_success,l_inam
                     LET g_indd_d[l_ac].indd004 = l_inam[1].inam002
                     LET g_indd_d[l_ac].indd021 = l_inam[1].inam004
                     
                     #單位間的轉換數量
                     CALL aint510_outnum_change('1')
                     
                  END IF
                  IF l_cmd = 'u' THEN
                     CALL s_feature_single(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_site,g_indc_m.indcdocno)
                        RETURNING l_success,g_indd_d[l_ac].indd004
                  END IF
               END IF
            END IF               
            #161017-00029#8 -e by 08172            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa154
            #add-point:ON ACTION controlp INFIELD imaa154 name="input.c.page1.imaa154"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa133
            #add-point:ON ACTION controlp INFIELD imaa133 name="input.c.page1.imaa133"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa156
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa156
            #add-point:ON ACTION controlp INFIELD imaa156 name="input.c.page1.imaa156"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa132
            #add-point:ON ACTION controlp INFIELD imaa132 name="input.c.page1.imaa132"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa132_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa132_desc
            #add-point:ON ACTION controlp INFIELD imaa132_desc name="input.c.page1.imaa132_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtaw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaw001
            #add-point:ON ACTION controlp INFIELD rtaw001 name="input.c.page1.rtaw001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa128_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa128_desc
            #add-point:ON ACTION controlp INFIELD imaa128_desc name="input.c.page1.imaa128_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="input.c.page1.imaa009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009_desc
            #add-point:ON ACTION controlp INFIELD imaa009_desc name="input.c.page1.imaa009_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa157
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa157
            #add-point:ON ACTION controlp INFIELD imaa157 name="input.c.page1.imaa157"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd006
            #add-point:ON ACTION controlp INFIELD indd006 name="input.c.page1.indd006"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd006             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_indd_d[l_ac].indd006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indd_d[l_ac].indd006 TO indd006              #顯示到畫面上
            
            CALL aint510_indd006_ref()

            NEXT FIELD indd006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd005
            #add-point:ON ACTION controlp INFIELD indd005 name="input.c.page1.indd005"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd007
            #add-point:ON ACTION controlp INFIELD indd007 name="input.c.page1.indd007"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd007             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_indd_d[l_ac].indd007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indd_d[l_ac].indd007 TO indd007              #顯示到畫面上
            
            CALL aint510_indd007_ref()

            NEXT FIELD indd007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd008
            #add-point:ON ACTION controlp INFIELD indd008 name="input.c.page1.indd008"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd009
            #add-point:ON ACTION controlp INFIELD indd009 name="input.c.page1.indd009"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd020
            #add-point:ON ACTION controlp INFIELD indd020 name="input.c.page1.indd020"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd021
            #add-point:ON ACTION controlp INFIELD indd021 name="input.c.page1.indd021"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd045
            #add-point:ON ACTION controlp INFIELD indd045 name="input.c.page1.indd045"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd046
            #add-point:ON ACTION controlp INFIELD indd046 name="input.c.page1.indd046"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd010
            #add-point:ON ACTION controlp INFIELD indd010 name="input.c.page1.indd010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd022
            #add-point:ON ACTION controlp INFIELD indd022 name="input.c.page1.indd022"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indd_d[l_ac].indd022             #給予default值

            #150324-00007#1 2015/04/10 By pomelo mark(S)
            ##給予arg
            #LET g_qryparam.arg1 = g_indc_m.indc005
            #CALL q_inaa001_4()                                #呼叫開窗
            #LET g_indd_d[l_ac].indd022 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #DISPLAY g_indd_d[l_ac].indd022 TO indd022              #顯示到畫面上            
            #150324-00007#1 2015/04/10 By pomelo mark(E)
            
            #160218-00008#1 160219 pomelo add(S)
            LET l_imaf055 = ''
            SELECT imaf055 INTO l_imaf055
              FROM imaf_t
             WHERE imafent = g_enterprise
               AND imafsite = 'ALL'
               AND imaf001 = g_indd_d[l_ac].indd002
            #160218-00008#1 160219 pomelo add(E)
            #150707-00027#3 By pomelo add(S)
            #撥出批號
            LET l_success = ''
            LET l_set_entry = ''
            CALL s_lot_out_entry('-1',g_indc_m.indcdocno,g_indc_m.indcsite,g_indd_d[l_ac].indd002)
                RETURNING l_success,l_set_entry
            IF l_success AND l_set_entry = FALSE THEN
               LET g_qryparam.default2 = g_indd_d[l_ac].indd023
               LET g_qryparam.default3 = g_indd_d[l_ac].indd102
               LET g_qryparam.arg1 = g_indc_m.indc005         #撥出據點
               LET g_qryparam.arg2 = g_indd_d[l_ac].indd002   #商品編號
               #產品特徵
               IF cl_null(g_indd_d[l_ac].indd004) THEN
                  LET g_indd_d[l_ac].indd004 = ' '
               END IF
               LET g_qryparam.arg3 = g_indd_d[l_ac].indd004
               
               #庫存管理特徵
               IF cl_null(g_indd_d[l_ac].indd102) THEN
                  LET g_qryparam.arg4 = ''
               ELSE
                  LET g_qryparam.arg4 = g_indd_d[l_ac].indd102
               END IF
               #160218-00008#1 160219 pomelo add(S)
               IF l_imaf055 = '2' THEN
                  LET g_qryparam.arg4 = ' '
               END IF
               #160218-00008#1 160219 pomelo add(E)
               
               LET g_qryparam.arg5 = ''   #庫位
               
               #儲位
               IF cl_null(g_indd_d[l_ac].indd023) THEN
                  LET g_qryparam.arg6 = ''
               ELSE
                  LET g_qryparam.arg6 = g_indd_d[l_ac].indd023
               END IF
               
               #150127-00004#17 151021 By pomelo add(S)
               CALL aint510_depot_cost_chk('3','1',g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd032,g_indc_m.indc007)
                  RETURNING l_success,l_where
               #LET g_qryparam.where = l_where  #151204-00007#10 151228 By pomelo mark
               #150127-00004#17 151021 By pomelo add(E)
               
               #151204-00007#10 151228 By pomelo add(S)
               LET g_qryparam.where = aint510_depot_where(-1),
                                      " AND ",l_where
               #151204-00007#10 151228 By pomelo add(E)
               
               #160218-00008#1 160219 pomelo add(S)
               CASE l_imaf055
                  WHEN '1'   #必須庫存管理特徵
                     LET g_qryparam.where = g_qryparam.where," AND inag003 <> ' '"
                  WHEN '2'   #不可庫存管理特徵
                     LET g_qryparam.where = g_qryparam.where," AND inag003 = ' '"
               END CASE
               #160218-00008#1 160219 pomelo add(E)
               
               CALL q_inag004_20()
               LET g_indd_d[l_ac].indd022 = g_qryparam.return1   #庫位
               LET g_indd_d[l_ac].indd023 = g_qryparam.return2   #儲位
               LET g_indd_d[l_ac].indd102 = g_qryparam.return3   #庫存管理特徵
               DISPLAY g_indd_d[l_ac].indd022 TO indd022
               DISPLAY g_indd_d[l_ac].indd023 TO indd023
               DISPLAY g_indd_d[l_ac].indd102 TO indd102
            ELSE
            #150707-00027#3 By pomelo add(E)
            
               #150324-00007#1 2015/04/10 By pomelo add(S)
               LET g_qryparam.default2 = g_indd_d[l_ac].indd023
               LET g_qryparam.default3 = g_indd_d[l_ac].indd024
               LET g_qryparam.default4 = g_indd_d[l_ac].indd102
               LET g_qryparam.arg1 = g_indc_m.indc005         #撥出據點
               LET g_qryparam.arg2 = g_indd_d[l_ac].indd002   #商品編號
               #產品特徵
               IF cl_null(g_indd_d[l_ac].indd004) THEN
                  LET g_indd_d[l_ac].indd004 = ' '
               END IF
               LET g_qryparam.arg3 = g_indd_d[l_ac].indd004
               
               #庫存管理特徵
               IF cl_null(g_indd_d[l_ac].indd102) THEN
                  LET g_qryparam.arg4 = ''
               ELSE
                  LET g_qryparam.arg4 = g_indd_d[l_ac].indd102
               END IF
               #160218-00008#1 160219 pomelo add(S)
               IF l_imaf055 = '2' THEN
                  LET g_qryparam.arg4 = ' '
               END IF
               #160218-00008#1 160219 pomelo add(E)
               
               LET g_qryparam.arg5 = ''   #庫位
               
               #儲位
               IF cl_null(g_indd_d[l_ac].indd023) THEN
                  LET g_qryparam.arg6 = ''
               ELSE
                  LET g_qryparam.arg6 = g_indd_d[l_ac].indd023
               END IF
               
               #批號
               IF cl_null(g_indd_d[l_ac].indd024) THEN
                  LET g_qryparam.arg7 = ''
               ELSE
                  LET g_qryparam.arg7 = g_indd_d[l_ac].indd024
               END IF  
               
               #150127-00004#17 151021 By pomelo add(S)
               CALL aint510_depot_cost_chk('3','1',g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd032,g_indc_m.indc007)
                  RETURNING l_success,l_where
               #LET g_qryparam.where = l_where         #151204-00007#10 151228 By pomelo mark
               #150127-00004#17 151021 By pomelo add(E)
               
               #151204-00007#10 151228 By pomelo add(S)
               LET g_qryparam.where = aint510_depot_where(-1),
                                      " AND ",l_where
               #151204-00007#10 151228 By pomelo add(E)
               
               #160218-00008#1 160219 pomelo add(S)
               CASE l_imaf055
                  WHEN '1'   #必須庫存管理特徵
                     LET g_qryparam.where = g_qryparam.where," AND inag003 <> ' '"
                  WHEN '2'   #不可庫存管理特徵
                     LET g_qryparam.where = g_qryparam.where," AND inag003 = ' '"
               END CASE
               #160218-00008#1 160219 pomelo add(E)
               
               CALL q_inag004_18()
               LET g_indd_d[l_ac].indd022 = g_qryparam.return1   #庫位
               LET g_indd_d[l_ac].indd023 = g_qryparam.return2   #儲位
               LET g_indd_d[l_ac].indd024 = g_qryparam.return3   #批號
               LET g_indd_d[l_ac].indd102 = g_qryparam.return4   #庫存管理特徵
               LET g_indd_d[l_ac].indd034 = g_indd_d[l_ac].indd024   #撥入批號Default 撥出批號 #150619-00012#1 15/06/22 by sakura
               DISPLAY g_indd_d[l_ac].indd022 TO indd022
               DISPLAY g_indd_d[l_ac].indd023 TO indd023
               DISPLAY g_indd_d[l_ac].indd024 TO indd024
               DISPLAY g_indd_d[l_ac].indd102 TO indd102
            END IF    #150707-00027#3 By pomelo add
            #儲位
            CALL s_desc_get_locator_desc(g_indc_m.indc005,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023)
               RETURNING g_indd_d[l_ac].indd023_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd023_desc
            #150324-00007#1 2015/04/10 By pomelo add(E)
            CALL aint510_indd022_ref()
            NEXT FIELD indd022                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd023
            #add-point:ON ACTION controlp INFIELD indd023 name="input.c.page1.indd023"
            #此段落由子樣板a07產生            
            #開窗i段
            #150324-00007#1 2015/04/10 By pomelo mark(S)
			   #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
			   #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_indd_d[l_ac].indd023             #給予default值
            #
            ##給予arg
            #LET g_qryparam.arg1 = g_indc_m.indc005 #
            #LET g_qryparam.arg2 = g_indd_d[l_ac].indd022 #
            #
            #CALL q_inab002_6()                                #呼叫開窗
            #
            #LET g_indd_d[l_ac].indd023 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #
            #DISPLAY g_indd_d[l_ac].indd023 TO indd023              #顯示到畫面上
            #150324-00007#1 2015/04/10 By pomelo mark(E)
            
            #160218-00008#1 160219 pomelo add(S)
            LET l_imaf055 = ''
            SELECT imaf055 INTO l_imaf055
              FROM imaf_t
             WHERE imafent = g_enterprise
               AND imafsite = 'ALL'
               AND imaf001 = g_indd_d[l_ac].indd002
            #160218-00008#1 160219 pomelo add(E)
            
            #150324-00007#1 2015/04/10 By pomelo add(S)
            #撥出批號
            LET l_success = ''
            LET l_set_entry = ''
            CALL s_lot_out_entry('-1',g_indc_m.indcdocno,g_indc_m.indcsite,g_indd_d[l_ac].indd002)
                RETURNING l_success,l_set_entry
            IF l_success AND l_set_entry = FALSE THEN
               LET g_qryparam.default1 = g_indd_d[l_ac].indd022
               LET g_qryparam.default2 = g_indd_d[l_ac].indd023
               LET g_qryparam.default3 = g_indd_d[l_ac].indd102
               LET g_qryparam.arg1 = g_indc_m.indc005         #撥出據點
               LET g_qryparam.arg2 = g_indd_d[l_ac].indd002   #商品編號
               #產品特徵
               IF cl_null(g_indd_d[l_ac].indd004) THEN
                  LET g_indd_d[l_ac].indd004 = ' '
               END IF
               LET g_qryparam.arg3 = g_indd_d[l_ac].indd004
               
               #庫存管理特徵
               IF cl_null(g_indd_d[l_ac].indd102) THEN
                  LET g_qryparam.arg4 = ''
               ELSE
                  LET g_qryparam.arg4 = g_indd_d[l_ac].indd102
               END IF
               
               LET g_qryparam.arg5 = g_indd_d[l_ac].indd022   #庫位
               
               #儲位
               LET g_qryparam.arg6 = ''
               
               #160218-00008#1 160219 pomelo add(S)
               CASE l_imaf055
                  WHEN '1'   #必須庫存管理特徵
                     LET g_qryparam.where = " inag003 <> ' '"
                  WHEN '2'   #不可庫存管理特徵
                     LET g_qryparam.where = " inag003 = ' '"
               END CASE
               #160218-00008#1 160219 pomelo add(E)
               
               CALL q_inag004_20()
               LET g_indd_d[l_ac].indd022 = g_qryparam.return1   #庫位
               LET g_indd_d[l_ac].indd023 = g_qryparam.return2   #儲位
               LET g_indd_d[l_ac].indd102 = g_qryparam.return3   #庫存管理特徵
               DISPLAY g_indd_d[l_ac].indd022 TO indd022
               DISPLAY g_indd_d[l_ac].indd023 TO indd023
               DISPLAY g_indd_d[l_ac].indd102 TO indd102
            ELSE
            #150707-00027#3 By pomelo add(E)
               LET g_qryparam.default1 = g_indd_d[l_ac].indd022
               LET g_qryparam.default2 = g_indd_d[l_ac].indd023
               LET g_qryparam.default3 = g_indd_d[l_ac].indd024
               LET g_qryparam.default4 = g_indd_d[l_ac].indd102
               LET g_qryparam.arg1 = g_indc_m.indc005         #撥出據點
               LET g_qryparam.arg2 = g_indd_d[l_ac].indd002   #商品編號
               #產品特徵
               IF cl_null(g_indd_d[l_ac].indd004) THEN
                  LET g_indd_d[l_ac].indd004 = ' '
               END IF
               LET g_qryparam.arg3 = g_indd_d[l_ac].indd004
               
               #庫存管理特徵
               IF cl_null(g_indd_d[l_ac].indd102) THEN
                  LET g_qryparam.arg4 = ''
               ELSE
                  LET g_qryparam.arg4 = g_indd_d[l_ac].indd102
               END IF
               
               LET g_qryparam.arg5 = g_indd_d[l_ac].indd022   #庫位
               
               #儲位
               LET g_qryparam.arg6 = ''
               
               #批號
               IF cl_null(g_indd_d[l_ac].indd024) THEN
                  LET g_qryparam.arg7 = ''
               ELSE
                  LET g_qryparam.arg7 = g_indd_d[l_ac].indd024
               END IF  
               
               #160218-00008#1 160219 pomelo add(S)
               CASE l_imaf055
                  WHEN '1'   #必須庫存管理特徵
                     LET g_qryparam.where = " inag003 <> ' '"
                  WHEN '2'   #不可庫存管理特徵
                     LET g_qryparam.where = " inag003 = ' '"
               END CASE
               #160218-00008#1 160219 pomelo add(E)
               
               CALL q_inag004_18()
               LET g_indd_d[l_ac].indd022 = g_qryparam.return1   #庫位
               LET g_indd_d[l_ac].indd023 = g_qryparam.return2   #儲位
               LET g_indd_d[l_ac].indd024 = g_qryparam.return3   #批號
               LET g_indd_d[l_ac].indd102 = g_qryparam.return4   #庫存管理特徵
               LET g_indd_d[l_ac].indd034 = g_indd_d[l_ac].indd024   #撥入批號Default 撥出批號 #150619-00012#1 15/06/22 by sakura
               DISPLAY g_indd_d[l_ac].indd022 TO indd022
               DISPLAY g_indd_d[l_ac].indd023 TO indd023
               DISPLAY g_indd_d[l_ac].indd024 TO indd024
               DISPLAY g_indd_d[l_ac].indd102 TO indd102
            END IF  #150707-00027#3 By pomelo add
            #庫位
            CALL s_desc_get_stock_desc('',g_indd_d[l_ac].indd022)
               RETURNING g_indd_d[l_ac].indd022_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd022_desc
            #150324-00007#1 2015/04/10 By pomelo add(E)
            CALL aint510_indd023_ref()
            NEXT FIELD indd023                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd024
            #add-point:ON ACTION controlp INFIELD indd024 name="input.c.page1.indd024"
            #此段落由子樣板a07產生            
            #開窗i段
            #150324-00007#1 2015/04/10 By pomelo mark(S)
			   #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
			   #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_indd_d[l_ac].indd024             #給予default值
            ##給予arg
            #CALL q_inai006()                                #呼叫開窗
            #LET g_indd_d[l_ac].indd024 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #DISPLAY g_indd_d[l_ac].indd024 TO indd024              #顯示到畫面上
            #NEXT FIELD indd024                          #返回原欄位
            #150324-00007#1 2015/04/10 By pomelo mark(E)
            
            #160218-00008#1 160219 pomelo add(S)
            LET l_imaf055 = ''
            SELECT imaf055 INTO l_imaf055
              FROM imaf_t
             WHERE imafent = g_enterprise
               AND imafsite = 'ALL'
               AND imaf001 = g_indd_d[l_ac].indd002
            #160218-00008#1 160219 pomelo add(E)
            
            ##160218-00008#1 160219 pomelo add(S)
            #撥出批號
            LET l_success = ''
            LET l_set_entry = ''
            CALL s_lot_out_entry('-1',g_indc_m.indcdocno,g_indc_m.indcsite,g_indd_d[l_ac].indd002)
                RETURNING l_success,l_set_entry
            IF l_success AND l_set_entry = TRUE THEN
               LET g_qryparam.default1 = g_indd_d[l_ac].indd022
               LET g_qryparam.default2 = g_indd_d[l_ac].indd023
               LET g_qryparam.default3 = g_indd_d[l_ac].indd024
               LET g_qryparam.default4 = g_indd_d[l_ac].indd102
               LET g_qryparam.arg1 = g_indc_m.indc005         #撥出據點
               LET g_qryparam.arg2 = g_indd_d[l_ac].indd002   #商品編號
               #產品特徵
               IF cl_null(g_indd_d[l_ac].indd004) THEN
                  LET g_indd_d[l_ac].indd004 = ' '
               END IF
               LET g_qryparam.arg3 = g_indd_d[l_ac].indd004
               
               #庫存管理特徵
               IF cl_null(g_indd_d[l_ac].indd102) THEN
                  LET g_qryparam.arg4 = ''
               ELSE
                  LET g_qryparam.arg4 = g_indd_d[l_ac].indd102
               END IF
               
               LET g_qryparam.arg5 = g_indd_d[l_ac].indd022   #庫位
               
               #儲位
               IF cl_null(g_indd_d[l_ac].indd023) THEN
                  LET g_qryparam.arg6 = ''
               ELSE
                  LET g_qryparam.arg6 = g_indd_d[l_ac].indd023
               END IF
               
               #批號
               LET g_qryparam.arg7 = ''
               
               CASE l_imaf055
                  WHEN '1'   #必須庫存管理特徵
                     LET g_qryparam.where = " inag003 <> ' '"
                  WHEN '2'   #不可庫存管理特徵
                     LET g_qryparam.where = " inag003 = ' '"
               END CASE
               
               CALL q_inag004_18()
               LET g_indd_d[l_ac].indd022 = g_qryparam.return1   #庫位
               LET g_indd_d[l_ac].indd023 = g_qryparam.return2   #儲位
               LET g_indd_d[l_ac].indd024 = g_qryparam.return3   #撥出批號
               LET g_indd_d[l_ac].indd102 = g_qryparam.return4   #庫存管理特徵
               LET g_indd_d[l_ac].indd034 = g_qryparam.return3   #撥入批號
               DISPLAY BY NAME g_indd_d[l_ac].indd022, g_indd_d[l_ac].indd023,
                               g_indd_d[l_ac].indd024, g_indd_d[l_ac].indd102,
                               g_indd_d[l_ac].indd034
            END IF
            #庫位
            CALL s_desc_get_stock_desc('',g_indd_d[l_ac].indd022)
               RETURNING g_indd_d[l_ac].indd022_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd022_desc
            CALL aint510_indd023_ref()
            NEXT FIELD indd024
            #160218-00008#1 160219 pomelo add(E)
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd102
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd102
            #add-point:ON ACTION controlp INFIELD indd102 name="input.c.page1.indd102"
            #160218-00008#1 160219 pomelo add(E)
            #撥出批號
            LET l_success = ''
            LET l_set_entry = ''
            CALL s_lot_out_entry('-1',g_indc_m.indcdocno,g_indc_m.indcsite,g_indd_d[l_ac].indd002)
                RETURNING l_success,l_set_entry
            IF l_success AND l_set_entry = FALSE THEN
               LET g_qryparam.default1 = g_indd_d[l_ac].indd022
               LET g_qryparam.default2 = g_indd_d[l_ac].indd023
               LET g_qryparam.default3 = g_indd_d[l_ac].indd102
               LET g_qryparam.arg1 = g_indc_m.indc005         #撥出據點
               LET g_qryparam.arg2 = g_indd_d[l_ac].indd002   #商品編號
               #產品特徵
               IF cl_null(g_indd_d[l_ac].indd004) THEN
                  LET g_indd_d[l_ac].indd004 = ' '
               END IF
               LET g_qryparam.arg3 = g_indd_d[l_ac].indd004
               
               #庫存管理特徵
               LET g_qryparam.arg4 = ''
               
               LET g_qryparam.arg5 = g_indd_d[l_ac].indd022   #庫位
               
               #儲位
               IF cl_null(g_indd_d[l_ac].indd023) THEN
                  LET g_qryparam.arg6 = ''
               ELSE
                  LET g_qryparam.arg6 = g_indd_d[l_ac].indd023
               END IF
               
               CALL q_inag004_20()
               LET g_indd_d[l_ac].indd022 = g_qryparam.return1   #庫位
               LET g_indd_d[l_ac].indd023 = g_qryparam.return2   #儲位
               LET g_indd_d[l_ac].indd102 = g_qryparam.return3   #庫存管理特徵
               DISPLAY g_indd_d[l_ac].indd022 TO indd022
               DISPLAY g_indd_d[l_ac].indd023 TO indd023
               DISPLAY g_indd_d[l_ac].indd102 TO indd102
            ELSE
               LET g_qryparam.default1 = g_indd_d[l_ac].indd022
               LET g_qryparam.default2 = g_indd_d[l_ac].indd023
               LET g_qryparam.default3 = g_indd_d[l_ac].indd024
               LET g_qryparam.default4 = g_indd_d[l_ac].indd102
               LET g_qryparam.arg1 = g_indc_m.indc005         #撥出據點
               LET g_qryparam.arg2 = g_indd_d[l_ac].indd002   #商品編號
               #產品特徵
               IF cl_null(g_indd_d[l_ac].indd004) THEN
                  LET g_indd_d[l_ac].indd004 = ' '
               END IF
               LET g_qryparam.arg3 = g_indd_d[l_ac].indd004
               
               #庫存管理特徵
               LET g_qryparam.arg4 = ''
               
               LET g_qryparam.arg5 = g_indd_d[l_ac].indd022   #庫位
               
               #儲位
               IF cl_null(g_indd_d[l_ac].indd023) THEN
                  LET g_qryparam.arg6 = ''
               ELSE
                  LET g_qryparam.arg6 = g_indd_d[l_ac].indd023
               END IF
               
               #批號
               IF cl_null(g_indd_d[l_ac].indd024) THEN
                  LET g_qryparam.arg7 = ''
               ELSE
                  LET g_qryparam.arg7 = g_indd_d[l_ac].indd024
               END IF  
               CALL q_inag004_18()
               LET g_indd_d[l_ac].indd022 = g_qryparam.return1   #庫位
               LET g_indd_d[l_ac].indd023 = g_qryparam.return2   #儲位
               LET g_indd_d[l_ac].indd024 = g_qryparam.return3   #撥出批號
               LET g_indd_d[l_ac].indd102 = g_qryparam.return4   #庫存管理特徵
               LET g_indd_d[l_ac].indd034 = g_qryparam.return3   #撥入批號
               DISPLAY g_indd_d[l_ac].indd022 TO indd022
               DISPLAY g_indd_d[l_ac].indd023 TO indd023
               DISPLAY g_indd_d[l_ac].indd024 TO indd024
               DISPLAY g_indd_d[l_ac].indd102 TO indd102
            END IF
            #庫位
            CALL s_desc_get_stock_desc('',g_indd_d[l_ac].indd022)
               RETURNING g_indd_d[l_ac].indd022_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd022_desc
            CALL aint510_indd023_ref()
            NEXT FIELD indd023                          #返回原欄位
            #160218-00008#1 160219 pomelo add(E)
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd025
            #add-point:ON ACTION controlp INFIELD indd025 name="input.c.page1.indd025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd030
            #add-point:ON ACTION controlp INFIELD indd030 name="input.c.page1.indd030"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd031
            #add-point:ON ACTION controlp INFIELD indd031 name="input.c.page1.indd031"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd032
            #add-point:ON ACTION controlp INFIELD indd032 name="input.c.page1.indd032"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_indc_m.indc006
            
            #150127-00004#17 151021 By pomelo add(S)
            CALL aint510_depot_cost_chk('3','2',g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd032,g_indc_m.indc007)
               RETURNING l_success,l_where
            #LET g_qryparam.where = l_where             #151204-00007#10 151228 By pomelo mark
            #150127-00004#17 151021 By pomelo add(E)
            
            #151204-00007#10 151228 By pomelo add(S)
            LET g_qryparam.where = aint510_depot_where(1),
                                   " AND ",l_where
            IF NOT cl_null(g_indd_d[l_ac].indd002) AND NOT cl_null(g_indc_m.indc202) THEN
               LET l_sys = cl_get_para(g_enterprise,'','E-CIR-0001')
               LET l_inaa106 = ''
               SELECT imaa009 INTO l_inaa106
                 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_indd_d[l_ac].indd002
               LET g_qryparam.where = g_qryparam.where,
                                      " AND EXISTS (SELECT 1",
                                      "               FROM rtax_t",
                                      "              WHERE rtaxent = ",g_enterprise,
                                      "                AND rtax004 >= '",l_sys,"'",
                                      "                AND rtaxstus = 'Y'",
                                      "                AND inaaent = rtaxent",
                                      "                AND inaa106 = rtax001",
                                      "         START WITH rtax001 = '",l_inaa106,"'",
                                      "         CONNECT BY NOCYCLE PRIOR rtax003 = rtax001)"
            END IF
            #151204-00007#10 151228 By pomelo add(E)
            
            CALL q_inaa001_4()                                #呼叫開窗

            LET g_indd_d[l_ac].indd032 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indd_d[l_ac].indd032 TO indd032              #顯示到畫面上
            
            CALL aint510_indd032_ref()

            NEXT FIELD indd032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd033
            #add-point:ON ACTION controlp INFIELD indd033 name="input.c.page1.indd033"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_indc_m.indc006 #
            LET g_qryparam.arg2 = g_indd_d[l_ac].indd032 #

            CALL q_inab002_6()                                #呼叫開窗

            LET g_indd_d[l_ac].indd033 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indd_d[l_ac].indd033 TO indd033              #顯示到畫面上
            
            CALL aint510_indd033_ref()

            NEXT FIELD indd033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd034
            #add-point:ON ACTION controlp INFIELD indd034 name="input.c.page1.indd034"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd034             #給予default值

            #給予arg

            CALL q_inai006()                                #呼叫開窗

            LET g_indd_d[l_ac].indd034 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indd_d[l_ac].indd034 TO indd034              #顯示到畫面上

            NEXT FIELD indd034                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd035
            #add-point:ON ACTION controlp INFIELD indd035 name="input.c.page1.indd035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd040
            #add-point:ON ACTION controlp INFIELD indd040 name="input.c.page1.indd040"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd101
            #add-point:ON ACTION controlp INFIELD indd101 name="input.c.page1.indd101"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_indd_d[l_ac].* = g_indd_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint510_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_indd_d[l_ac].inddseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_indd_d[l_ac].* = g_indd_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #150519-00025#1 150520 BY pomelo add(S)
               IF NOT aint510_in_out_chk() THEN
                  NEXT FIELD indd032
               END IF
               #150519-00025#1 150520 BY pomelo add(E)   
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aint510_indd_t_mask_restore('restore_mask_o')
      
               UPDATE indd_t SET (indddocno,inddsite,inddunit,inddseq,indd001,indd047,indd048,indd003, 
                   indd002,indd004,indd006,indd005,indd007,indd008,indd009,indd020,indd021,indd045,indd046, 
                   indd010,indd022,indd023,indd024,indd102,indd025,indd030,indd031,indd032,indd033,indd034, 
                   indd035,indd040,indd101) = (g_indc_m.indcdocno,g_indd_d[l_ac].inddsite,g_indd_d[l_ac].inddunit, 
                   g_indd_d[l_ac].inddseq,g_indd_d[l_ac].indd001,g_indd_d[l_ac].indd047,g_indd_d[l_ac].indd048, 
                   g_indd_d[l_ac].indd003,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd006, 
                   g_indd_d[l_ac].indd005,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd008,g_indd_d[l_ac].indd009, 
                   g_indd_d[l_ac].indd020,g_indd_d[l_ac].indd021,g_indd_d[l_ac].indd045,g_indd_d[l_ac].indd046, 
                   g_indd_d[l_ac].indd010,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024, 
                   g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd025,g_indd_d[l_ac].indd030,g_indd_d[l_ac].indd031, 
                   g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd035, 
                   g_indd_d[l_ac].indd040,g_indd_d[l_ac].indd101)
                WHERE inddent = g_enterprise AND indddocno = g_indc_m.indcdocno 
 
                  AND inddseq = g_indd_d_t.inddseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                                                            
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_indd_d[l_ac].* = g_indd_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "indd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_indd_d[l_ac].* = g_indd_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_indc_m.indcdocno
               LET gs_keys_bak[1] = g_indcdocno_t
               LET gs_keys[2] = g_indd_d[g_detail_idx].inddseq
               LET gs_keys_bak[2] = g_indd_d_t.inddseq
               CALL aint510_update_b('indd_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aint510_indd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_indd_d[g_detail_idx].inddseq = g_indd_d_t.inddseq 
 
                  ) THEN
                  LET gs_keys[01] = g_indc_m.indcdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_indd_d_t.inddseq
 
                  CALL aint510_key_update_b(gs_keys,'indd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_indc_m),util.JSON.stringify(g_indd_d_t)
               LET g_log2 = util.JSON.stringify(g_indc_m),util.JSON.stringify(g_indd_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #150624-00017#1 2015/06/29 By pomelo add(S)
               IF NOT s_aint510_gen_indl(g_indd_d[l_ac].inddsite, g_indd_d[l_ac].inddunit, g_indc_m.indcdocno,     g_indd_d[l_ac].inddseq,
                                         g_indd_d[l_ac].indd003,  g_indd_d[l_ac].indd002,  g_indd_d[l_ac].indd004, g_indd_d[l_ac].indd007,
                                         g_indd_d[l_ac].indd006,  g_indd_d[l_ac].indd020,  g_indd_d[l_ac].indd021, g_indd_d[l_ac].indd022,
                                         g_indd_d[l_ac].indd023,  g_indd_d[l_ac].indd024,  g_indd_d[l_ac].indd030, g_indd_d[l_ac].indd031,
                                         g_indd_d[l_ac].indd032,  g_indd_d[l_ac].indd033,  g_indd_d[l_ac].indd034, g_indd_d[l_ac].indd102,
                                         #g_indd_d[l_ac].indd010) THEN   #151204-00007#5 151215 By pomelo mark
                                         g_indd_d[l_ac].indd010,  g_indd_d[l_ac].indd045,  g_indd_d[l_ac].indd046) THEN    #151204-00007#5 151215 By pomelo add
                  CALL s_transaction_end('N','0')
               END IF
               #CALL aint510_b_fill()  #160202-00002#1 160309 By pomelo mark
               #150624-00017#1 2015/06/29 By pomelo add(E)
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aint510_unlock_b("indd_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            CALL aint510_b_fill()   #160202-00002#1 160309 By pomelo add
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
                                                
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_indd_d[li_reproduce_target].* = g_indd_d[li_reproduce].*
 
               LET g_indd_d[li_reproduce_target].inddseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_indd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_indd_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_indd2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL aint510_idx_chk()
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
            CALL aint510_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="aint510.input.other" >}
      
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
            NEXT FIELD indcdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD inddsite
               WHEN "s_detail2"
                  NEXT FIELD indlseq
 
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
 
{<section id="aint510.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aint510_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
            
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   CALL aint510_set_combo('q')
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aint510_b_fill() #單身填充
      CALL aint510_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint510_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc #sakura add         

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indcownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_indc_m.indcownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indcownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indcowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_indc_m.indcowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indcowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indccrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_indc_m.indccrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indccrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indccrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_indc_m.indccrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indccrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indcmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_indc_m.indcmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indcmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indccnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_indc_m.indccnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indccnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_indc_m_mask_o.* =  g_indc_m.*
   CALL aint510_indc_t_mask()
   LET g_indc_m_mask_n.* =  g_indc_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_indc_m.indcsite,g_indc_m.indcsite_desc,g_indc_m.indcdocdt,g_indc_m.indcdocno,g_indc_m.indc001, 
       g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indc101,g_indc_m.indc101_desc,g_indc_m.indcunit, 
       g_indc_m.indc199,g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026, 
       g_indc_m.indc025,g_indc_m.indc200,g_indc_m.indc200_desc,g_indc_m.indc201,g_indc_m.indc201_desc, 
       g_indc_m.indc005,g_indc_m.indc005_desc,g_indc_m.indc006,g_indc_m.indc006_desc,g_indc_m.indc007, 
       g_indc_m.indc007_desc,g_indc_m.indc008,g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc021_desc, 
       g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc023_desc,g_indc_m.indc024,g_indc_m.indcownid,g_indc_m.indcownid_desc, 
       g_indc_m.indcowndp,g_indc_m.indcowndp_desc,g_indc_m.indccrtid,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp, 
       g_indc_m.indccrtdp_desc,g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcmodid_desc,g_indc_m.indcmoddt, 
       g_indc_m.indccnfid,g_indc_m.indccnfid_desc,g_indc_m.indccnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_indc_m.indcstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "O"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_out.png")
         WHEN "P"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_in.png")
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
   FOR l_ac = 1 TO g_indd_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
                        
#      CALL aint510_indd002_ref()
#
#      CALL aint510_indd006_ref()
#
#      CALL aint510_indd007_ref()
#
#      CALL aint510_indd022_ref()
#
#      CALL aint510_indd023_ref()
#
#      CALL aint510_indd032_ref()
#
#      CALL aint510_indd033_ref()

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_indd2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
            
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aint510_detail_show()
 
   #add-point:show段之後 name="show.after"
            
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aint510.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aint510_detail_show()
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
 
{<section id="aint510.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint510_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE indc_t.indcdocno 
   DEFINE l_oldno     LIKE indc_t.indcdocno 
 
   DEFINE l_master    RECORD LIKE indc_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE indd_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE indl_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_indc_m.indcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_indcdocno_t = g_indc_m.indcdocno
 
    
   LET g_indc_m.indcdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_indc_m.indcownid = g_user
      LET g_indc_m.indcowndp = g_dept
      LET g_indc_m.indccrtid = g_user
      LET g_indc_m.indccrtdp = g_dept 
      LET g_indc_m.indccrtdt = cl_get_current()
      LET g_indc_m.indcmodid = g_user
      LET g_indc_m.indcmoddt = cl_get_current()
      LET g_indc_m.indcstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_indc_m.indcstus = 'N'
   LET g_indc_m.indcsite  = g_site
   LET g_indc_m.indcunit  = g_site
   LET g_indc_m.indcdocdt = g_today
   LET g_indc_m.indc001   = ''
   LET g_indc_m.indc002   = '1'
   LET g_indc_m.indc003   = ''
   LET g_indc_m.indc004   = g_user
   LET g_indc_m.indc005   = g_site
   LET g_indc_m.indc021   = ''
   LET g_indc_m.indc022   = ''
   LET g_indc_m.indc023   = ''
   LET g_indc_m.indc024   = ''
   LET g_indc_m.indccnfid = ''
   LET g_indc_m.indccnfdt = ''
   CALL s_desc_get_department_desc(g_indc_m.indcsite) RETURNING g_indc_m.indcsite_desc
   DISPLAY BY NAME g_indc_m.indcsite_desc
   CALL aint510_indc004_ref()
   CALL s_desc_get_department_desc(g_indc_m.indc005) RETURNING g_indc_m.indc005_desc
   DISPLAY BY NAME g_indc_m.indc005_desc
   CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc #sakura add
   DISPLAY BY NAME g_indc_m.indc101_desc                                             #sakura add 
   
   #预设单别
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_indc_m.indcsite,g_prog,'1') RETURNING r_success,r_doctype
   LET g_indc_m.indcdocno = r_doctype
   
   INITIALIZE g_indc_m_t.* LIKE indc_t.*
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_indc_m.indcstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "O"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_out.png")
         WHEN "P"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_in.png")
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
   
   
   CALL aint510_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_indc_m.* TO NULL
      INITIALIZE g_indd_d TO NULL
      INITIALIZE g_indd2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aint510_show()
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
   CALL aint510_set_act_visible()   
   CALL aint510_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_indcdocno_t = g_indc_m.indcdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " indcent = " ||g_enterprise|| " AND",
                      " indcdocno = '", g_indc_m.indcdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint510_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
            
   #end add-point
   
   CALL aint510_idx_chk()
   
   LET g_data_owner = g_indc_m.indcownid      
   LET g_data_dept  = g_indc_m.indcowndp
   
   #功能已完成,通報訊息中心
   CALL aint510_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aint510.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aint510_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE indd_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE indl_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   #151117-00016#1 Add By Ken 151118(S)
   DEFINE l_indd002     LIKE indd_t.indd002   
   DEFINE l_indd004     LIKE indd_t.indd004
   DEFINE l_indd102     LIKE indd_t.indd102
   DEFINE l_indd022     LIKE indd_t.indd022
   DEFINE l_indd023     LIKE indd_t.indd023
   DEFINE l_indd024     LIKE indd_t.indd024
   DEFINE l_indd006     LIKE indd_t.indd006
   DEFINE l_indd032     LIKE indd_t.indd032
   DEFINE l_indd033     LIKE indd_t.indd033
   DEFINE l_indd034     LIKE indd_t.indd034
   DEFINE l_indd025     LIKE indd_t.indd025
   DEFINE l_indd035     LIKE indd_t.indd035
   DEFINE l_inddseq     LIKE indd_t.inddseq
   #151117-00016#1 Add By Ken 151118(E)
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aint510_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
            
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM indd_t
    WHERE inddent = g_enterprise AND indddocno = g_indcdocno_t
 
    INTO TEMP aint510_detail
 
   #將key修正為調整後   
   UPDATE aint510_detail 
      #更新key欄位
      SET indddocno = g_indc_m.indcdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
 
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO indd_t SELECT * FROM aint510_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   UPDATE indd_t SET indd001 = '',indd040 = 'N',indd010 = 'N'    #151117-00016#1 Add By Ken 151118 加上多庫儲批=N
    WHERE inddent = g_enterprise AND indddocno = g_indc_m.indcdocno
   
   #151117-00016#1 Add By Ken 151118(S)     走批號自動沖減且商品走自動沖減，批號欄位需要清空
   IF s_aint510_chk_lot('u',g_indc_m.indcsite,g_indc_m.indcdocno) THEN
      LET ls_sql = "SELECT indd002 FROM indd_t ",
                   " WHERE inddent = ",g_enterprise,
                   "   AND indddocno = '",g_indc_m.indcdocno,"'"
      PREPARE aint511_indd002_pre FROM ls_sql
      DECLARE aint511_indd002_cur CURSOR FOR aint511_indd002_pre
      FOREACH aint511_indd002_cur INTO l_indd002
         IF s_aint510_chk_imaf061('ALL',l_indd002) THEN
            UPDATE indd_t SET indd024 = '',indd034 = ''
             WHERE inddent = g_enterprise 
               AND indddocno = g_indc_m.indcdocno
               AND indd002 = l_indd002
         END IF      
      END FOREACH
   END IF
   
   
   LET ls_sql = "SELECT indd002,indd004,indd102,indd022,indd023, ",
                "       indd024,indd006,indd032,indd033,indd034, ",
                "       inddseq ",
                "  FROM indd_t ",
                " WHERE inddent = ",g_enterprise,
                "   AND indddocno = '",g_indc_m.indcdocno,"'"
   PREPARE aint511_indd002_pre1 FROM ls_sql
   DECLARE aint511_indd002_cur1 CURSOR FOR aint511_indd002_pre1
   FOREACH aint511_indd002_cur1 INTO l_indd002,l_indd004,l_indd102,l_indd022,l_indd023,
                                     l_indd024,l_indd006,l_indd032,l_indd033,l_indd034,
                                     l_inddseq
      #撥出組織庫存數量
      CALL s_aint510_get_inag009(g_indc_m.indc005,l_indd002,l_indd004,l_indd102,l_indd022,
                                 l_indd023,       l_indd024,l_indd006)            
                     RETURNING l_indd025
      #撥入組織庫存數量
      CALL s_aint510_get_inag009(g_indc_m.indc006,l_indd002,l_indd004,l_indd102,l_indd032,
                                 l_indd033,       l_indd034,l_indd006)            
                     RETURNING l_indd035                           
      UPDATE indd_t SET indd025 = l_indd025,indd035 = l_indd035
       WHERE inddent = g_enterprise 
         AND indddocno = g_indc_m.indcdocno
         AND inddseq = l_inddseq      
   END FOREACH       
   #151117-00016#1 Add By Ken 151118(E)   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aint510_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
            
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   #151117-00016#1 Add By Ken 151118(S) 重新產生多庫儲批資料
   INSERT INTO indl_t(indlent, indlsite, indlunit, indldocno,
                      indlseq, indlseq1, indl001,  indl002,
                      indl003, indl004,  indl005,  indl020,
                      indl021, indl022,  indl023,  indl024,
                      indl030, indl031,  indl032,  indl033,
                      indl034, indl101)
   SELECT inddent, inddsite, inddunit, indddocno,
          inddseq, 1,        indd003,  indd002,
          indd004, indd007,  indd006,  indd020,
          indd021, indd022,  indd023,  indd024,
          indd030, indd031,  indd032,  indd033,
          indd034, indd102
     FROM indd_t
    WHERE inddent = g_enterprise
      AND indddocno = g_indc_m.indcdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins indl_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   CALL s_transaction_end('Y','0')   
   LET g_indcdocno_t = g_indc_m.indcdocno         
   RETURN
   #151117-00016#1 Add By Ken 151118(E) 
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM indl_t 
    WHERE indlent = g_enterprise AND indldocno = g_indcdocno_t
 
    INTO TEMP aint510_detail
 
   #將key修正為調整後   
   UPDATE aint510_detail SET indldocno = g_indc_m.indcdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO indl_t SELECT * FROM aint510_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
 
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aint510_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_indcdocno_t = g_indc_m.indcdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint510.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint510_delete()
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
   
   IF g_indc_m.indcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aint510_cl USING g_enterprise,g_indc_m.indcdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint510_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcsite,g_indc_m.indcdocdt, 
       g_indc_m.indcdocno,g_indc_m.indc001,g_indc_m.indc004,g_indc_m.indc101,g_indc_m.indcunit,g_indc_m.indc199, 
       g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026,g_indc_m.indc025, 
       g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc007,g_indc_m.indc008, 
       g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024,g_indc_m.indcownid, 
       g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt,g_indc_m.indcmodid, 
       g_indc_m.indcmoddt,g_indc_m.indccnfid,g_indc_m.indccnfdt,g_indc_m.indcsite_desc,g_indc_m.indc004_desc, 
       g_indc_m.indc101_desc,g_indc_m.indc200_desc,g_indc_m.indc201_desc,g_indc_m.indc005_desc,g_indc_m.indc006_desc, 
       g_indc_m.indc007_desc,g_indc_m.indc021_desc,g_indc_m.indc023_desc,g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc, 
       g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc,g_indc_m.indcmodid_desc,g_indc_m.indccnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aint510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_indc_m_mask_o.* =  g_indc_m.*
   CALL aint510_indc_t_mask()
   LET g_indc_m_mask_n.* =  g_indc_m.*
   
   CALL aint510_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      #161109-00078#6 Add By Ken 161114(S)
      IF NOT s_aint510_indj021_upd(g_indc_m.indcdocno) THEN
         CALL s_transaction_end('N','0')
         RETURN      
      END IF
      #161109-00078#6 Add By Ken 161114(E)
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint510_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_indcdocno_t = g_indc_m.indcdocno
 
 
      DELETE FROM indc_t
       WHERE indcent = g_enterprise AND indcdocno = g_indc_m.indcdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                        
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_indc_m.indcdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #150127-00004#13 15/03/17 By pomelo add(S)
      IF NOT s_aooi200_del_docno(g_indc_m.indcdocno,g_indc_m.indcdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #150127-00004#13 15/03/17 By pomelo add(E)
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
 
      #end add-point
      
      DELETE FROM indd_t
       WHERE inddent = g_enterprise AND indddocno = g_indc_m.indcdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                        
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
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
      DELETE FROM indl_t
       WHERE indlent = g_enterprise AND
             indldocno = g_indc_m.indcdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_indc_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aint510_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_indd_d.clear() 
      CALL g_indd2_d.clear()       
 
     
      CALL aint510_ui_browser_refresh()  
      #CALL aint510_ui_headershow()  
      #CALL aint510_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aint510_browser_fill("")
         CALL aint510_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint510_cl
 
   #功能已完成,通報訊息中心
   CALL aint510_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aint510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint510_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
            
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_indd_d.clear()
   CALL g_indd2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
            
   #end add-point
   
   #判斷是否填充
   IF aint510_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT inddsite,inddunit,inddseq,indd001,indd047,indd048,indd003,indd002, 
             indd004,indd006,indd005,indd007,indd008,indd009,indd020,indd021,indd045,indd046,indd010, 
             indd022,indd023,indd024,indd102,indd025,indd030,indd031,indd032,indd033,indd034,indd035, 
             indd040,indd101 ,t1.imaal003 ,t2.imaal004 ,t4.oocal003 ,t5.oocal003 ,t6.inayl003 ,t7.inayl003 , 
             t8.inab003 FROM indd_t",   
                     " INNER JOIN indc_t ON indcent = " ||g_enterprise|| " AND indcdocno = indddocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=indd002 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=indd002 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=indd006 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=indd007 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t6 ON t6.inaylent="||g_enterprise||" AND t6.inayl001=indd022 AND t6.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent="||g_enterprise||" AND t7.inayl001=indd032 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t8 ON t8.inabent="||g_enterprise||" AND t8.inabsite=inddsite AND t8.inab001=indd032 AND t8.inab002=indd033  ",
 
                     " WHERE inddent=? AND indddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         #161216-00033#1 20161216 add by geza(S)
         LET g_sql = "SELECT  DISTINCT inddsite,inddunit,inddseq,indd001,indd047,indd048,indd003,indd002, 
             indd004,indd006,indd005,indd007,indd008,indd009,indd020,indd021,indd045,indd046,indd010, 
             indd022,indd023,indd024,indd102,indd025,indd030,indd031,indd032,indd033,indd034,indd035, 
             indd040,indd101 ,t1.imaal003 ,t2.imaal004 ,t4.oocal003 ,t5.oocal003 ,t6.inayl003 ,t7.inayl003 , 
             t8.inab003 FROM indd_t",   
                     " INNER JOIN indc_t ON indcent = " ||g_enterprise|| " AND indcdocno = indddocno ",
                      " LEFT JOIN imaa_t ON imaaent = inddent AND indd002 = imaa001 ", 
                      " LEFT JOIN rtaw_t ON rtawent = inddent AND rtaw002 = imaa009 AND rtaw003 = '1' ",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=indd002 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=indd002 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=indd006 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=indd007 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t6 ON t6.inaylent="||g_enterprise||" AND t6.inayl001=indd022 AND t6.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent="||g_enterprise||" AND t7.inayl001=indd032 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t8 ON t8.inabent="||g_enterprise||" AND t8.inabsite=inddsite AND t8.inab001=indd032 AND t8.inab002=indd033  ",
 
                     " WHERE inddent=? AND indddocno=?"         
 
         #161216-00033#1 20161216 add by geza(E)
                                    
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY indd_t.inddseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
                        
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint510_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aint510_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_indc_m.indcdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_indc_m.indcdocno INTO g_indd_d[l_ac].inddsite,g_indd_d[l_ac].inddunit, 
          g_indd_d[l_ac].inddseq,g_indd_d[l_ac].indd001,g_indd_d[l_ac].indd047,g_indd_d[l_ac].indd048, 
          g_indd_d[l_ac].indd003,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd006, 
          g_indd_d[l_ac].indd005,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd008,g_indd_d[l_ac].indd009, 
          g_indd_d[l_ac].indd020,g_indd_d[l_ac].indd021,g_indd_d[l_ac].indd045,g_indd_d[l_ac].indd046, 
          g_indd_d[l_ac].indd010,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024, 
          g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd025,g_indd_d[l_ac].indd030,g_indd_d[l_ac].indd031, 
          g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,g_indd_d[l_ac].indd034,g_indd_d[l_ac].indd035, 
          g_indd_d[l_ac].indd040,g_indd_d[l_ac].indd101,g_indd_d[l_ac].indd002_desc,g_indd_d[l_ac].indd002_desc_desc, 
          g_indd_d[l_ac].indd006_desc,g_indd_d[l_ac].indd007_desc,g_indd_d[l_ac].indd022_desc,g_indd_d[l_ac].indd032_desc, 
          g_indd_d[l_ac].indd033_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #儲位
         CALL aint510_indd023_ref()
         CALL aint510_indd033_ref()
         #170116-00018#11 -s 20160117 mark by 08172
         #161027-00055#5 -s by 08172 add 20161029
#         IF g_indc_m.indc005 IS NOT NULL AND g_indd_d[l_ac].indd002 IS NOT NULL  THEN
#            SELECT rtdx029 INTO g_indd_d[l_ac].rtdx029
#              FROM rtdx_t 
#             WHERE rtdxent = g_enterprise
#               AND rtdx001 = g_indd_d[l_ac].indd002
#               AND rtdxsite = g_indc_m.indc005
#               AND rtdxstus = 'Y'
#            SELECT ooefl003 INTO g_indd_d[l_ac].rtdx029_desc
#              FROM ooefl_t 
#             WHERE ooeflent = g_enterprise
#               AND ooefl001 = g_indc_m.indc005         
#               AND ooefl002 = g_lang          
#         END IF 
#         IF g_indd_d[l_ac].rtdx029 IS NOT NULL AND g_indd_d[l_ac].indd002 IS NOT NULL AND g_indd_d[l_ac].indd003 IS NOT NULL THEN                   
#            #CALL aint510_inag009_count(g_indd_d[l_ac].indd002,g_indd_d[l_ac].rtdx029,g_indd_d[l_ac].indd004) RETURNING g_indd_d[l_ac].inag009 #mark by geza 201611206 161124-00039#1
#            CALL aint510_inag009_count(g_indd_d[l_ac].indd002,g_indd_d[l_ac].rtdx029,g_indd_d[l_ac].indd004,'') RETURNING g_indd_d[l_ac].inag009 #add by geza 201611206 161124-00039#1
#          
#         ELSE
#            LET g_indd_d[l_ac].inag009 = 0           
#         END IF   
         #161027-00055#5 -e by 08172 add 20161029       
         #170116-00018#11 -e 20160117 mark by 08172
         #No:161030----------------begin      #add by stcshy 161030
         CALL aint510_get_imaa(g_indd_d[l_ac].indd002) 
            #RETURNING g_indd_d[l_ac].imaa154,g_indd_d[l_ac].imaa155,g_indd_d[l_ac].imaa156,g_indd_d[l_ac].imaa132,g_indd_d[l_ac].imaa128,g_indd_d[l_ac].imaa009,g_indd_d[l_ac].imaa157 #mark by geza 20161216 #161216-00033#1
            RETURNING g_indd_d[l_ac].imaa154,g_indd_d[l_ac].imaa133,g_indd_d[l_ac].imaa156,g_indd_d[l_ac].imaa132,g_indd_d[l_ac].rtaw001,g_indd_d[l_ac].imaa009,g_indd_d[l_ac].imaa157 #add by geza 20161216 #161216-00033#1
            
         CALL s_desc_get_rtaxl003_desc(g_indd_d[l_ac].imaa009) RETURNING g_indd_d[l_ac].imaa009_desc
         CALL s_desc_get_rtaxl003_desc(g_indd_d[l_ac].rtaw001) RETURNING g_indd_d[l_ac].imaa128_desc #add by geza 20161216 #161216-00033#1
         CALL s_desc_get_acc_desc('2007',g_indd_d[l_ac].imaa133) RETURNING g_indd_d[l_ac].imaa133_desc #add by geza 20161216 #161216-00033#1
         #CALL s_desc_get_acc_desc('2004',g_indd_d[l_ac].imaa128) RETURNING g_indd_d[l_ac].imaa128_desc #mark by geza 20161216 #161216-00033#1
         CALL s_desc_get_acc_desc('2006',g_indd_d[l_ac].imaa132) RETURNING g_indd_d[l_ac].imaa132_desc
         #No:161030------------------end


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
   IF aint510_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT indlseq,indlseq1,indl001,indl002,indl003,indl004,indl005,indl022, 
             indl023,indl024,indl101,indl020,indl021,indl102,indl103,indl032,indl033,indl034,indl030, 
             indl031 ,t10.imaal004 ,t11.oocal003 ,t12.oocal003 ,t13.inayl003 ,t14.inayl003 FROM indl_t", 
                
                     " INNER JOIN  indc_t ON indcent = " ||g_enterprise|| " AND indcdocno = indldocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t10 ON t10.imaalent="||g_enterprise||" AND t10.imaal001=indl002 AND t10.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t11 ON t11.oocalent="||g_enterprise||" AND t11.oocal001=indl004 AND t11.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t12 ON t12.oocalent="||g_enterprise||" AND t12.oocal001=indl005 AND t12.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t13 ON t13.inaylent="||g_enterprise||" AND t13.inayl001=indl022 AND t13.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t14 ON t14.inaylent="||g_enterprise||" AND t14.inayl001=indl032 AND t14.inayl002='"||g_dlang||"' ",
 
                     " WHERE indlent=? AND indldocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY indl_t.indlseq,indl_t.indlseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint510_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aint510_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_indc_m.indcdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_indc_m.indcdocno INTO g_indd2_d[l_ac].indlseq,g_indd2_d[l_ac].indlseq1, 
          g_indd2_d[l_ac].indl001,g_indd2_d[l_ac].indl002,g_indd2_d[l_ac].indl003,g_indd2_d[l_ac].indl004, 
          g_indd2_d[l_ac].indl005,g_indd2_d[l_ac].indl022,g_indd2_d[l_ac].indl023,g_indd2_d[l_ac].indl024, 
          g_indd2_d[l_ac].indl101,g_indd2_d[l_ac].indl020,g_indd2_d[l_ac].indl021,g_indd2_d[l_ac].indl102, 
          g_indd2_d[l_ac].indl103,g_indd2_d[l_ac].indl032,g_indd2_d[l_ac].indl033,g_indd2_d[l_ac].indl034, 
          g_indd2_d[l_ac].indl030,g_indd2_d[l_ac].indl031,g_indd2_d[l_ac].indl002_desc_desc,g_indd2_d[l_ac].indl004_desc, 
          g_indd2_d[l_ac].indl005_desc,g_indd2_d[l_ac].indl022_desc,g_indd2_d[l_ac].indl032_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         #商品編號
         CALL s_desc_get_item_desc(g_indd2_d[l_ac].indl002)
            RETURNING g_indd2_d[l_ac].indl002_desc,g_indd2_d[l_ac].indl002_desc_desc
         
         #包裝單位
         CALL s_desc_get_unit_desc(g_indd2_d[l_ac].indl004)
            RETURNING g_indd2_d[l_ac].indl004_desc
         
         #庫存單位
         CALL s_desc_get_unit_desc(g_indd2_d[l_ac].indl005)
            RETURNING g_indd2_d[l_ac].indl005_desc
            
         #撥出庫位
         CALL s_desc_get_stock_desc('',g_indd2_d[l_ac].indl022)
            RETURNING g_indd2_d[l_ac].indl022_desc
         
         #撥出儲位
         CALL s_desc_get_locator_desc(g_indc_m.indc005,g_indd2_d[l_ac].indl022,g_indd2_d[l_ac].indl023)
            RETURNING g_indd2_d[l_ac].indl023_desc
         
         #撥入庫位
         CALL s_desc_get_stock_desc('',g_indd2_d[l_ac].indl032)
            RETURNING g_indd2_d[l_ac].indl032_desc
         
         #撥入儲位
         CALL s_desc_get_locator_desc(g_indc_m.indc006,g_indd2_d[l_ac].indl032,g_indd2_d[l_ac].indl033)
            RETURNING g_indd2_d[l_ac].indl033_desc
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
   
   CALL g_indd_d.deleteElement(g_indd_d.getLength())
   CALL g_indd2_d.deleteElement(g_indd2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aint510_pb
   FREE aint510_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_indd_d.getLength()
      LET g_indd_d_mask_o[l_ac].* =  g_indd_d[l_ac].*
      CALL aint510_indd_t_mask()
      LET g_indd_d_mask_n[l_ac].* =  g_indd_d[l_ac].*
   END FOR
   
   LET g_indd2_d_mask_o.* =  g_indd2_d.*
   FOR l_ac = 1 TO g_indd2_d.getLength()
      LET g_indd2_d_mask_o[l_ac].* =  g_indd2_d[l_ac].*
      CALL aint510_indl_t_mask()
      LET g_indd2_d_mask_n[l_ac].* =  g_indd2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aint510.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint510_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM indd_t
       WHERE inddent = g_enterprise AND
         indddocno = ps_keys_bak[1] AND inddseq = ps_keys_bak[2]
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
         CALL g_indd_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM indl_t
       WHERE indlent = g_enterprise AND
             indldocno = ps_keys_bak[1] AND indlseq = ps_keys_bak[2] AND indlseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_indd2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
            
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint510.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint510_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO indd_t
                  (inddent,
                   indddocno,
                   inddseq
                   ,inddsite,inddunit,indd001,indd047,indd048,indd003,indd002,indd004,indd006,indd005,indd007,indd008,indd009,indd020,indd021,indd045,indd046,indd010,indd022,indd023,indd024,indd102,indd025,indd030,indd031,indd032,indd033,indd034,indd035,indd040,indd101) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_indd_d[g_detail_idx].inddsite,g_indd_d[g_detail_idx].inddunit,g_indd_d[g_detail_idx].indd001, 
                       g_indd_d[g_detail_idx].indd047,g_indd_d[g_detail_idx].indd048,g_indd_d[g_detail_idx].indd003, 
                       g_indd_d[g_detail_idx].indd002,g_indd_d[g_detail_idx].indd004,g_indd_d[g_detail_idx].indd006, 
                       g_indd_d[g_detail_idx].indd005,g_indd_d[g_detail_idx].indd007,g_indd_d[g_detail_idx].indd008, 
                       g_indd_d[g_detail_idx].indd009,g_indd_d[g_detail_idx].indd020,g_indd_d[g_detail_idx].indd021, 
                       g_indd_d[g_detail_idx].indd045,g_indd_d[g_detail_idx].indd046,g_indd_d[g_detail_idx].indd010, 
                       g_indd_d[g_detail_idx].indd022,g_indd_d[g_detail_idx].indd023,g_indd_d[g_detail_idx].indd024, 
                       g_indd_d[g_detail_idx].indd102,g_indd_d[g_detail_idx].indd025,g_indd_d[g_detail_idx].indd030, 
                       g_indd_d[g_detail_idx].indd031,g_indd_d[g_detail_idx].indd032,g_indd_d[g_detail_idx].indd033, 
                       g_indd_d[g_detail_idx].indd034,g_indd_d[g_detail_idx].indd035,g_indd_d[g_detail_idx].indd040, 
                       g_indd_d[g_detail_idx].indd101)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                        
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_indd_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                        
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO indl_t
                  (indlent,
                   indldocno,
                   indlseq,indlseq1
                   ,indl001,indl002,indl003,indl004,indl005,indl022,indl023,indl024,indl101,indl020,indl021,indl102,indl103,indl032,indl033,indl034,indl030,indl031) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_indd2_d[g_detail_idx].indl001,g_indd2_d[g_detail_idx].indl002,g_indd2_d[g_detail_idx].indl003, 
                       g_indd2_d[g_detail_idx].indl004,g_indd2_d[g_detail_idx].indl005,g_indd2_d[g_detail_idx].indl022, 
                       g_indd2_d[g_detail_idx].indl023,g_indd2_d[g_detail_idx].indl024,g_indd2_d[g_detail_idx].indl101, 
                       g_indd2_d[g_detail_idx].indl020,g_indd2_d[g_detail_idx].indl021,g_indd2_d[g_detail_idx].indl102, 
                       g_indd2_d[g_detail_idx].indl103,g_indd2_d[g_detail_idx].indl032,g_indd2_d[g_detail_idx].indl033, 
                       g_indd2_d[g_detail_idx].indl034,g_indd2_d[g_detail_idx].indl030,g_indd2_d[g_detail_idx].indl031) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_indd2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
            
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aint510.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint510_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "indd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                        
      #end add-point 
      
      #將遮罩欄位還原
      CALL aint510_indd_t_mask_restore('restore_mask_o')
               
      UPDATE indd_t 
         SET (indddocno,
              inddseq
              ,inddsite,inddunit,indd001,indd047,indd048,indd003,indd002,indd004,indd006,indd005,indd007,indd008,indd009,indd020,indd021,indd045,indd046,indd010,indd022,indd023,indd024,indd102,indd025,indd030,indd031,indd032,indd033,indd034,indd035,indd040,indd101) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_indd_d[g_detail_idx].inddsite,g_indd_d[g_detail_idx].inddunit,g_indd_d[g_detail_idx].indd001, 
                  g_indd_d[g_detail_idx].indd047,g_indd_d[g_detail_idx].indd048,g_indd_d[g_detail_idx].indd003, 
                  g_indd_d[g_detail_idx].indd002,g_indd_d[g_detail_idx].indd004,g_indd_d[g_detail_idx].indd006, 
                  g_indd_d[g_detail_idx].indd005,g_indd_d[g_detail_idx].indd007,g_indd_d[g_detail_idx].indd008, 
                  g_indd_d[g_detail_idx].indd009,g_indd_d[g_detail_idx].indd020,g_indd_d[g_detail_idx].indd021, 
                  g_indd_d[g_detail_idx].indd045,g_indd_d[g_detail_idx].indd046,g_indd_d[g_detail_idx].indd010, 
                  g_indd_d[g_detail_idx].indd022,g_indd_d[g_detail_idx].indd023,g_indd_d[g_detail_idx].indd024, 
                  g_indd_d[g_detail_idx].indd102,g_indd_d[g_detail_idx].indd025,g_indd_d[g_detail_idx].indd030, 
                  g_indd_d[g_detail_idx].indd031,g_indd_d[g_detail_idx].indd032,g_indd_d[g_detail_idx].indd033, 
                  g_indd_d[g_detail_idx].indd034,g_indd_d[g_detail_idx].indd035,g_indd_d[g_detail_idx].indd040, 
                  g_indd_d[g_detail_idx].indd101) 
         WHERE inddent = g_enterprise AND indddocno = ps_keys_bak[1] AND inddseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
                        
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint510_indd_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
                        
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "indl_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aint510_indl_t_mask_restore('restore_mask_o')
               
      UPDATE indl_t 
         SET (indldocno,
              indlseq,indlseq1
              ,indl001,indl002,indl003,indl004,indl005,indl022,indl023,indl024,indl101,indl020,indl021,indl102,indl103,indl032,indl033,indl034,indl030,indl031) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_indd2_d[g_detail_idx].indl001,g_indd2_d[g_detail_idx].indl002,g_indd2_d[g_detail_idx].indl003, 
                  g_indd2_d[g_detail_idx].indl004,g_indd2_d[g_detail_idx].indl005,g_indd2_d[g_detail_idx].indl022, 
                  g_indd2_d[g_detail_idx].indl023,g_indd2_d[g_detail_idx].indl024,g_indd2_d[g_detail_idx].indl101, 
                  g_indd2_d[g_detail_idx].indl020,g_indd2_d[g_detail_idx].indl021,g_indd2_d[g_detail_idx].indl102, 
                  g_indd2_d[g_detail_idx].indl103,g_indd2_d[g_detail_idx].indl032,g_indd2_d[g_detail_idx].indl033, 
                  g_indd2_d[g_detail_idx].indl034,g_indd2_d[g_detail_idx].indl030,g_indd2_d[g_detail_idx].indl031)  
 
         WHERE indlent = g_enterprise AND indldocno = ps_keys_bak[1] AND indlseq = ps_keys_bak[2] AND indlseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint510_indl_t_mask_restore('restore_mask_n')
 
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
 
{<section id="aint510.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aint510_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aint510.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aint510_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aint510.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint510_lock_b(ps_table,ps_page)
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
   #CALL aint510_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "indd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint510_bcl USING g_enterprise,
                                       g_indc_m.indcdocno,g_indd_d[g_detail_idx].inddseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint510_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "indl_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aint510_bcl2 USING g_enterprise,
                                             g_indc_m.indcdocno,g_indd2_d[g_detail_idx].indlseq,g_indd2_d[g_detail_idx].indlseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint510_bcl2:",SQLERRMESSAGE 
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
 
{<section id="aint510.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint510_unlock_b(ps_table,ps_page)
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
      CLOSE aint510_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aint510_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
            
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aint510.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint510_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
            
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("indcdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("indcdocno",TRUE)
      CALL cl_set_comp_entry("indcdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
                        
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("indcdocdt",TRUE)
   CALL cl_set_comp_entry("indc002",TRUE)
   CALL cl_set_comp_entry("indc003",TRUE)
   CALL cl_set_comp_entry("indc004",TRUE)
   CALL cl_set_comp_entry("indc006",TRUE)
   CALL cl_set_comp_entry("indc007",TRUE)
   CALL cl_set_comp_entry("indc008",TRUE)
   CALL cl_set_comp_visible("indc007,indc007_desc",TRUE)
   CALL cl_set_comp_entry("indc101",TRUE)         #150127-00004#13 15/03/17 By pomelo add
   CALL cl_set_comp_required("indc003",FALSE)
   #150707-00027#3 150707 By pomelo add(S)
   CALL cl_set_comp_entry("indc200",TRUE)
   CALL cl_set_comp_entry("indc201",TRUE)
   #150707-00027#3 150707 By pomelo add(E)
   
   CALL cl_set_comp_entry("indc202",TRUE)    #151204-00007#10 151228 By pomelo add
   CALL cl_set_comp_entry("indc005",TRUE)    #151225-00011#1 151230 By pomelo add
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint510.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint510_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_sys1        LIKE type_t.chr80       #组织间调拨是否启用在途
   DEFINE l_sys2        LIKE type_t.chr80       #组织内调拨是否启用在途
   DEFINE l_sys3        LIKE type_t.chr80       #在途仓归属 1.拨出 2.拨入
   DEFINE l_cnt         LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("indcdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
                        
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("indcdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("indcdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_indc_m.indc002 = '1' OR g_indc_m.indc002 = '4' THEN
      CALL cl_set_comp_required("indc003",FALSE)
      CALL cl_set_comp_entry("indc003",FALSE)
   END IF
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt
     FROM indd_t
    WHERE inddent = g_enterprise
      AND indddocno = g_indc_m.indcdocno
   IF l_cnt > 0 THEN
      CALL cl_set_comp_entry("indc002,indc003",FALSE)
      #150707-00027#3 150707 By pomelo add(S)
      CALL cl_set_comp_entry("indc200",FALSE)
      CALL cl_set_comp_entry("indc201",FALSE)
      #150707-00027#3 150707 By pomelo add(E)
      CALL cl_set_comp_entry("indc202",FALSE)    #151204-00007#10 151228 By pomelo add
   END IF
   #151225-00011#1 151230 By pomelo mark(S)
   #IF g_indc_m.indc002 = '2' OR g_indc_m.indc002 = '6' THEN
   #   CALL cl_set_comp_required("indc003",TRUE)
   #   CALL cl_set_comp_entry("indc006",FALSE)
   #END IF
   #151225-00011#1 151230 By pomelo mark(E)
   IF NOT cl_null(g_indc_m.indc005) AND NOT cl_null(g_indc_m.indc006) THEN
      #取参数
      CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys1
      CALL cl_get_para(g_enterprise,g_site,'E-BAS-0014') RETURNING l_sys2
      CALL cl_get_para(g_enterprise,g_site,'E-BAS-0015') RETURNING l_sys3
      IF g_indc_m.indc005 <> g_indc_m.indc006 THEN
         IF cl_null(l_sys1) OR l_sys1 <> 'Y' THEN
            CALL cl_set_comp_entry("indc007",FALSE)
            CALL cl_set_comp_visible("indc007,indc007_desc",FALSE)
            LET g_indc_m.indc007 = ''
            DISPLAY BY NAME g_indc_m.indc007
         END IF
      ELSE
         IF cl_null(l_sys2) OR l_sys2 <> 'Y' THEN
            CALL cl_set_comp_entry("indc007",FALSE)
            CALL cl_set_comp_visible("indc007,indc007_desc",FALSE)
            LET g_indc_m.indc007 = ''
            DISPLAY BY NAME g_indc_m.indc007
         END IF
      END IF
   ELSE
      CALL cl_set_comp_entry("indc007",FALSE)
      CALL cl_set_comp_visible("indc007,indc007_desc",FALSE)
      LET g_indc_m.indc007 = ''
      DISPLAY BY NAME g_indc_m.indc007
   END IF
   #拨入审核时关闭单头栏位
   #IF g_site = g_indc_m.indc006 AND g_indc_m.indcstus = 'O' THEN #mark by geza 20160919 #160909-00069#5
   IF g_site = g_indc_m.indc006 AND ( g_indc_m.indcstus = 'O' OR g_indc_m.indcstus = 'Y' ) THEN #add by geza 20160919 #160909-00069#5
      CALL cl_set_comp_entry("indcdocno,indcdocdt,indc002,indc003,indc004,indc006,indc007,indc008",FALSE)
   END IF
   
   #150127-00004#13 15/03/17 By pomelo add(S)
   #當來源類別 = 4.配送或5.統採
   IF g_indc_m.indc002 = '4' OR g_indc_m.indc002 = '5' THEN
      CALL cl_set_comp_entry("indc006",FALSE)    #撥入組織
      CALL cl_set_comp_entry("indc004",FALSE)    #調撥人員
      CALL cl_set_comp_entry("indc101",FALSE)    #調撥部門
   END IF
   #151225-00011#1 151230 By pomelo add(S)
   ##當調撥性質 = 3.倉退
   #IF g_indc_m.indc199 = '3' THEN
   #   CALL cl_set_comp_entry("indc002",FALSE)   #來源類別
   #END IF
   #151225-00011#1 151230 By pomelo add(S)
   
   #150127-00004#13 15/03/17 By pomelo add(E)
   
   #151225-00011#1 151230 By pomelo mark(S)
   #150127-00004#13 15/10/22 By pomelo add(S)
   #IF g_indc_m.indc002 = '6' AND NOT cl_null(g_indc_m.indc003) THEN
   #   CALL cl_set_comp_entry("indc005",FALSE)   #撥出組織
   #END IF
   #150127-00004#13 15/10/22 By pomelo add(E)
   #151225-00011#1 151230 By pomelo mark(E)
   
   #151225-00011#1 151230 By pomelo add(S)
   CASE g_indc_m.indc002
      WHEN '2'   #調撥申請單
         CALL cl_set_comp_entry("indc006",FALSE)   #撥入組織
         CALL cl_set_comp_required("indc003",TRUE) #來源單號
         
      WHEN '6'   #退貨申請單
         CALL cl_set_comp_entry("indc005",FALSE)   #撥出組織
         CALL cl_set_comp_entry("indc200",FALSE)   #撥出庫位
         CALL cl_set_comp_required("indc003",TRUE) #來源單號
         
      WHEN '7'   #配送調撥單
         CALL cl_set_comp_entry("indc005",FALSE)   #撥出組織
         CALL cl_set_comp_entry("indc006",FALSE)   #撥入組織
         CALL cl_set_comp_entry("indc200",FALSE)   #撥出庫位
         CALL cl_set_comp_required("indc003",TRUE) #來源單號
      
      WHEN '8'   #調撥單
         CALL cl_set_comp_entry("indc005",FALSE)   #撥出組織
         CALL cl_set_comp_entry("indc006",FALSE)   #撥入組織
         CALL cl_set_comp_entry("indc200",FALSE)   #撥出庫位
         CALL cl_set_comp_required("indc003",TRUE) #來源單號
   END CASE
   #151225-00011#1 151230 By pomelo add(E)
   
   #151204-00007#10 151228 By pomelo add(S)
   IF g_argv[1] MATCHES '[456]' THEN
      CALL cl_set_comp_entry("indc002",FALSE)    #來源類別
      CALL cl_set_comp_entry("indc005",FALSE)    #撥出組織
      CALL cl_set_comp_entry("indc006",FALSE)    #撥入組織
   END IF
   IF g_argv[1] = '5' THEN
      CALL cl_set_comp_entry("indc202",FALSE)    #操作類型
   END IF
   #151204-00007#10 151228 By pomelo add(E)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint510.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint510_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("inddseq,indd002,indd003,indd007,indd020,indd021,indd022,indd023,indd024",TRUE)
   CALL cl_set_comp_entry("indd030,indd031,indd032,indd033,indd034",TRUE)
   CALL cl_set_comp_entry("indd001",TRUE)   #150127-00004#13 15/03/17 By pomelo add
   #150324-00007#1 2015/04/10 By pomelo add(S)
   CALL cl_set_comp_entry("indd004",TRUE)   #產品特徵
   CALL cl_set_comp_entry("indd102",TRUE)   #庫存管理特徵
   #150324-00007#1 2015/04/10 By pomelo add(E)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aint510.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint510_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   #150624-00017#1 150630 By pomelo add(S)
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_set_entry LIKE type_t.num5
   DEFINE l_imaa005   LIKE imaa_t.imaa005
   DEFINE l_set_required   LIKE type_t.num5   #151225-00011#1 160104 By pomelo add
   #150624-00017#1 150630 By pomelo add(E)
   DEFINE l_imaf055   LIKE imaf_t.imaf055     #160218-00008#1 160219 pomelo add
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF g_indc_m.indcstus = 'N' THEN
      #CALL cl_set_comp_entry("indd030,indd031",FALSE)
      #150127-00004#13 15/03/17 By pomelo add(S)
      #當來源類別 = 4.配送或5.統採
      IF g_indc_m.indc002 = '4' OR g_indc_m.indc002 = '5' THEN
         CALL cl_set_comp_entry("inddseq,indd002,indd003,indd007,indd020,indd021,indd022,indd023,indd024",FALSE)
         #150324-00007#1 2015/04/10 By pomelo add(S)
         CALL cl_set_comp_entry("indd004",FALSE)   #產品特徵
         CALL cl_set_comp_entry("indd102",FALSE)   #庫存管理特徵
         #150324-00007#1 2015/04/10 By pomelo add(E)
      END IF
      #150127-00004#13 15/03/17 By pomelo add(E)
   END IF
   #IF g_indc_m.indcstus = 'O' THEN #mark by geza 20160919 #160909-00069#5
   IF g_indc_m.indcstus = 'O' OR g_indc_m.indcstus = 'Y' THEN #add by geza 20160919 #160909-00069#5
      CALL cl_set_comp_entry("inddseq,indd002,indd003,indd007,indd020,indd021,indd022,indd023,indd024",FALSE)
      #150324-00007#1 2015/04/10 By pomelo add(S)
      CALL cl_set_comp_entry("indd004",FALSE)   #產品特徵
      CALL cl_set_comp_entry("indd102",FALSE)   #庫存管理特徵
      #150324-00007#1 2015/04/10 By pomelo add(E)
   END IF
   IF g_indc_m.indc002 = '2' THEN
      CALL cl_set_comp_entry("inddseq,indd002,indd003,indd007",FALSE)
   END IF
   #150127-00004#13 15/03/17 By pomelo add(S)
   #當調撥性質 = 2配送或3倉退，來源類別不可以維護
   #IF g_argv[1] = '2' OR g_argv[1] = '3' THEN   #151204-00007#5 160105 By pomelo mark
   IF g_argv[1] MATCHES '[23]' AND g_indc_m.indc002 != '1' THEN #151204-00007#5 160105 By pomelo add
      CALL cl_set_comp_entry("indd002",FALSE)
   END IF
   
   #當來源類別 = 6
   #  由來源單據帶出相關欄位，不可以修改
   #當來源類別 != 6，來源項次不可空白
   #IF g_indc_m.indc002 = '6' THEN           #151225-00011#1 151231 By pomelo mark
   IF g_indc_m.indc002 MATCHES '[678]' THEN  #151225-00011#1 151231 By pomelo add
      CALL cl_set_comp_entry("indd002",FALSE)   #商品編號
      CALL cl_set_comp_entry("indd003",FALSE)   #商品條碼
      CALL cl_set_comp_entry("indd004",FALSE)   #產品特徵
      CALL cl_set_comp_entry("indd007",FALSE)   #包裝單位
      CALL cl_set_comp_entry("indd022",FALSE)   #撥出庫位
      CALL cl_set_comp_entry("indd023",FALSE)   #撥出儲位
      CALL cl_set_comp_entry("indd024",FALSE)   #撥出批號
   ELSE
      CALL cl_set_comp_entry("indd001",FALSE)
   END IF
   
   #當撥出數量有值，撥出包裝數量就不可以維護
   IF NOT cl_null(g_indd_d[l_ac].indd021) THEN
      CALL cl_set_comp_entry("indd020",FALSE)
   END IF
   #當撥入數量有值，撥入包裝數量就不可以維護
   IF NOT cl_null(g_indd_d[l_ac].indd031) THEN
      CALL cl_set_comp_entry("indd030",FALSE)
   END IF
   #150127-00004#13 15/03/17 By pomelo add(E)
   
   #150624-00017#1 150630 By pomelo add(S)
   #當料件有使用產品特徵功能時此欄位才可輸入
   LET l_imaa005  = ''
   SELECT imaa005 INTO l_imaa005
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_indd_d[l_ac].indd002
   IF cl_null(l_imaa005) THEN
      CALL cl_set_comp_entry("indd004",FALSE)
   END IF
   
   #撥出批號
   LET l_success = ''
   LET l_set_entry = ''
   CALL s_lot_out_entry('-1',g_indc_m.indcdocno,g_indc_m.indcsite,g_indd_d[l_ac].indd002)
       RETURNING l_success,l_set_entry
   IF l_success THEN
      CALL cl_set_comp_entry("indd024",l_set_entry)
   END IF
   
   #撥入批號
   LET l_success = ''
   LET l_set_entry = ''
   CALL s_lot_out_entry('1',g_indc_m.indcdocno,g_indc_m.indcsite,g_indd_d[l_ac].indd002)
       RETURNING l_success,l_set_entry
   IF l_success THEN
      CALL cl_set_comp_entry("indd034",l_set_entry)
   END IF
   #150624-00017#1 150630 By pomelo add(S)
   
   #151225-00011#1 160104 By pomelo add(S)
   CALL s_lot_out_required(g_indd_d[l_ac].indd002)
      RETURNING l_success,l_set_required
   IF l_success THEN
      CALL cl_set_comp_required("indd024",l_set_required)
      CALL cl_set_comp_required("indd034",l_set_required)
   END IF
   #151225-00011#1 160104 By pomelo add(E)
   
   #150707-00027#3 150707 By pomelo add(S)
   IF NOT cl_null(g_indc_m.indc200) THEN
      CALL cl_set_comp_entry("indd022",FALSE)
   END IF
   IF NOT cl_null(g_indc_m.indc201) THEN
      CALL cl_set_comp_entry("indd032",FALSE)
   END IF
   #150707-00027#3 150707 By pomelo add(E)
   
   #150820-00014#1 150820 By pomelo add(S)
   IF g_indc_m.indc000 = '1' THEN
      CALL cl_set_comp_entry("indd030",FALSE)    #撥入包裝數量
      CALL cl_set_comp_entry("indd031",FALSE)    #撥入數量
   END IF
   #150820-00014#1 150820 By pomelo add(E)
   
   #160218-00008#1 160219 pomelo add(S)
   LET l_imaf055 = ''
   SELECT imaf055 INTO l_imaf055
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = 'ALL'
      AND imaf001 = g_indd_d[l_ac].indd002
   IF l_imaf055 = '2' THEN
      CALL cl_set_comp_entry("indd102",FALSE)
      LET g_indd_d[l_ac].indd102 = ' '
   END IF
   #160218-00008#1 160219 pomelo add(E)

   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aint510.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint510_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   IF g_argv[1] != 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint510.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint510_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_indc_m.indcstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   IF g_indc_m.indcstus = 'C' OR g_indc_m.indcstus = 'O' OR g_indc_m.indcstus = 'P' OR g_indc_m.indcstus = 'X' THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
      IF g_indc_m.indcstus <> 'O' THEN
         CALL cl_set_act_visible("modify,modify_detail", FALSE)
      ELSE
         IF g_site <> g_indc_m.indc006 THEN
            CALL cl_set_act_visible("modify,modify_detail", FALSE)
         ELSE
            CALL cl_set_act_visible("modify,modify_detail", TRUE)
         END IF
      END IF
   ELSE
      IF g_site = g_indc_m.indcsite THEN
         CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
      ELSE
         CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
      END IF
   END IF
   
   #150127-00004#13 15/03/17 By pomelo add(S)
   #當為aint510調撥單維護作業，只可以查詢
   CASE g_argv[1]
      WHEN '0'
         CALL cl_set_act_visible("insert",FALSE)               #新增
         CALL cl_set_act_visible("modify",FALSE)               #修改
         CALL cl_set_act_visible("delete",FALSE)               #刪除
         CALL cl_set_act_visible("modify_detail",FALSE)        #修改單身
         CALL cl_set_act_visible("reproduce",FALSE)            #複製
         CALL cl_set_act_visible("statechange",FALSE)          #狀態
      WHEN '2'
         CALL cl_set_act_visible("insert",FALSE)               #新增
         CALL cl_set_act_visible("reproduce",FALSE)            #複製
   END CASE
   #150127-00004#13 15/03/17 By pomelo add(E)
   #add by geza 20160919 #160909-00069#5(S)
   #aint512为审核状态的时候，只能修改
   IF g_argv[1] = '2' AND g_indc_m.indcstus = 'Y' THEN
      CALL cl_set_act_visible("delete",FALSE)   
   END IF
   #add by geza 20160919 #160909-00069#5(E)
   
   #161217-00002#1 Add By Ken 161221(S)
   IF g_indc_m.indc000 = '1' AND g_indc_m.indcstus = 'Y' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)   
   END IF   
   #161217-00002#1 Add By Ken 161221(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint510.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aint510_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint510.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aint510_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint510.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint510_default_search()
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
      LET ls_wc = ls_wc, " indcdocno = '", g_argv[02], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #150615-00010#1 20160315 s983961--add(s)
   IF NOT cl_null(g_argv[03]) THEN
     LET ls_wc = ls_wc , g_argv[03], " AND "
   END IF
   #150615-00010#1 20160315 s983961--add(e)
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
               WHEN la_wc[li_idx].tableid = "indc_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "indd_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "indl_t" 
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
   #給予批次串程式使用
   #150615-00010#1 20160315 s983961--mark(s)
   #IF NOT cl_null(g_argv[3]) THEN
   #   LET g_wc = " ",g_argv[3]
   #END IF
   #150615-00010#1 20160315 s983961--mark(e)
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint510.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint510_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_errno       LIKE type_t.chr10
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_sys         LIKE type_t.chr80       #是否启用pos_b2b
   DEFINE lc_state_o    LIKE type_t.chr5        #备份lc_state
   DEFINE l_indcstus_o  LIKE type_t.chr5        #备份indcstus
   DEFINE p_cnt         LIKE type_t.num10 
   DEFINE l_wc          STRING
   #161217-00002#1 Add By Ken 161220(S)
   DEFINE l_slip        LIKE ooba_t.ooba002      #單據別   
   DEFINE l_gzcb002     LIKE gzcb_t.gzcb002
   DEFINE l_n           LIKE type_t.num10
   #161217-00002#1 Add By Ken 161220(E)
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_indc_m.indcstus = 'X' OR g_indc_m.indcstus = 'C' THEN
      RETURN
   END IF
   IF (g_site <> g_indc_m.indc006 OR g_indc_m.indc000 = '2') AND g_indc_m.indcstus = 'P' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_indc_m.indcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aint510_cl USING g_enterprise,g_indc_m.indcdocno
   IF STATUS THEN
      CLOSE aint510_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint510_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint510_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcsite,g_indc_m.indcdocdt, 
       g_indc_m.indcdocno,g_indc_m.indc001,g_indc_m.indc004,g_indc_m.indc101,g_indc_m.indcunit,g_indc_m.indc199, 
       g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026,g_indc_m.indc025, 
       g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc007,g_indc_m.indc008, 
       g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024,g_indc_m.indcownid, 
       g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt,g_indc_m.indcmodid, 
       g_indc_m.indcmoddt,g_indc_m.indccnfid,g_indc_m.indccnfdt,g_indc_m.indcsite_desc,g_indc_m.indc004_desc, 
       g_indc_m.indc101_desc,g_indc_m.indc200_desc,g_indc_m.indc201_desc,g_indc_m.indc005_desc,g_indc_m.indc006_desc, 
       g_indc_m.indc007_desc,g_indc_m.indc021_desc,g_indc_m.indc023_desc,g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc, 
       g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc,g_indc_m.indcmodid_desc,g_indc_m.indccnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aint510_action_chk() THEN
      CLOSE aint510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_indc_m.indcsite,g_indc_m.indcsite_desc,g_indc_m.indcdocdt,g_indc_m.indcdocno,g_indc_m.indc001, 
       g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indc101,g_indc_m.indc101_desc,g_indc_m.indcunit, 
       g_indc_m.indc199,g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026, 
       g_indc_m.indc025,g_indc_m.indc200,g_indc_m.indc200_desc,g_indc_m.indc201,g_indc_m.indc201_desc, 
       g_indc_m.indc005,g_indc_m.indc005_desc,g_indc_m.indc006,g_indc_m.indc006_desc,g_indc_m.indc007, 
       g_indc_m.indc007_desc,g_indc_m.indc008,g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc021_desc, 
       g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc023_desc,g_indc_m.indc024,g_indc_m.indcownid,g_indc_m.indcownid_desc, 
       g_indc_m.indcowndp,g_indc_m.indcowndp_desc,g_indc_m.indccrtid,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp, 
       g_indc_m.indccrtdp_desc,g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcmodid_desc,g_indc_m.indcmoddt, 
       g_indc_m.indccnfid,g_indc_m.indccnfid_desc,g_indc_m.indccnfdt
 
   CASE g_indc_m.indcstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "C"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
      WHEN "O"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_out.png")
      WHEN "P"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_in.png")
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
         CASE g_indc_m.indcstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "S"
               HIDE OPTION "posted"
            WHEN "C"
               HIDE OPTION "closed"
            WHEN "O"
               HIDE OPTION "confirm_transfer_out"
            WHEN "P"
               HIDE OPTION "confirm_transfer_in"
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
         #161217-00002#1 Add By Ken 161220(S)
         # 取出單號的單別
         LET l_success = ''
         LET l_slip = ''
         CALL s_aooi200_get_slip(g_indc_m.indcdocno)
            RETURNING l_success,l_slip
         
         # 取單別參數 一階段調撥是否需要確認
         LET l_gzcb002 = ''
         CALL cl_get_doc_para(g_enterprise,g_indc_m.indcsite,l_slip,'D-CIR-0006')
            RETURNING l_gzcb002         
         #161217-00002#1 Add By Ken 161220(E)
         CALL cl_set_act_visible("signing,withdraw,closed",FALSE)   #160303-00028#11 160310 By pomelo add
         CALL cl_set_act_visible("confirmed,posted,unposted",FALSE)
         CASE g_indc_m.indcstus
            #add by geza 20160919 #160909-00069#5(S)
            WHEN 'Y'
               CALL cl_set_act_visible("confirm_transfer_in,closed,invalid",FALSE)                              
            #add by geza 20160919 #160909-00069#5(E)
            WHEN 'N'
               #161217-00002#1 Add By Ken 161220(S)
               IF (l_gzcb002 = 'Y') AND (g_indc_m.indc000 = '1') THEN
                  CALL cl_set_act_visible("confirmed",TRUE)
                  CALL cl_set_act_visible("confirm_transfer_out",FALSE)
               END IF
               #161217-00002#1 Add By Ken 161220(E)
               CALL cl_set_act_visible("unconfirmed,confirm_transfer_in,closed",FALSE)
               IF g_site <> g_indc_m.indc005 OR g_indc_m.indc000 = '3' THEN
                  CALL cl_set_act_visible("confirm_transfer_out,invalid",FALSE)
               END IF
               #160303-00028#11 160310 By pomelo add(S)
               #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                   CALL cl_set_act_visible("signing",TRUE)
                   CALL cl_set_act_visible("confirm_transfer_out",FALSE)
               END IF
               #160303-00028#11 160310 By pomelo add(E)
            WHEN 'O'
               CALL cl_set_act_visible("closed,invalid",FALSE)
               IF g_site <> g_indc_m.indc006 OR g_indc_m.indc000 = '2' THEN
                  CALL cl_set_act_visible("confirm_transfer_in",FALSE)
               END IF
               IF g_site <> g_indc_m.indc005 OR g_indc_m.indc000 = '3' THEN
                  CALL cl_set_act_visible("unconfirmed",FALSE)
               END IF
               #160303-00028#11 160310 By pomelo add(S)
               #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                   CALL cl_set_act_visible("signing",TRUE)
                   CALL cl_set_act_visible("confirm_transfer_in",FALSE)
               END IF
               #160303-00028#11 160310 By pomelo add(E)
            WHEN 'P'
               CALL cl_set_act_visible("unconfirmed,closed,invalid",FALSE)
               IF g_site <> g_indc_m.indc006 OR g_indc_m.indc000 = '2' THEN
                  CALL cl_set_act_visible("confirm_transfer_out",FALSE)
               END IF
            
            #160303-00028#11 160310 By pomelo add(S)
            WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               CALL cl_set_act_visible("closed",FALSE)
               CALL cl_set_act_visible("invalid",FALSE)
               CALL cl_set_act_visible("unconfirmed",FALSE)
               CALL cl_set_act_visible("confirm_transfer_out",FALSE)
               CALL cl_set_act_visible("confirm_transfer_in,",FALSE)
            
            WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               CALL cl_set_act_visible("closed",FALSE)
               CALL cl_set_act_visible("invalid",FALSE)
               CALL cl_set_act_visible("unconfirmed",FALSE)
               CALL cl_set_act_visible("confirm_transfer_out",FALSE)
               CALL cl_set_act_visible("confirm_transfer_in,",FALSE)
             
            WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
                CALL cl_set_act_visible("withdraw",TRUE)
                CALL cl_set_act_visible("closed",FALSE)
                CALL cl_set_act_visible("invalid",FALSE)
                CALL cl_set_act_visible("unconfirmed",FALSE)
                CALL cl_set_act_visible("confirm_transfer_out",FALSE)
                CALL cl_set_act_visible("confirm_transfer_in,",FALSE)
            
            WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
                #一階、兩階段調撥
                IF g_site = g_indc_m.indc005 AND g_indc_m.indc000 MATCHES '[12]' THEN
                   CALL cl_set_act_visible("confirm_transfer_in",FALSE)
                   CALL cl_set_act_visible("confirm_transfer_out",TRUE)
                END IF
                #調撥撥入單
                IF g_site = g_indc_m.indc006 AND g_indc_m.indc000 = '3' THEN
                   CALL cl_set_act_visible("confirm_transfer_in",TRUE)
                   CALL cl_set_act_visible("confirm_transfer_out",FALSE)
                END IF                
                CALL cl_set_act_visible("closed",FALSE)
                CALL cl_set_act_visible("invalid",FALSE)
                CALL cl_set_act_visible("unconfirmed",FALSE)
            #160303-00028#11 160310 By pomelo add(E)
         END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aint510_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint510_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aint510_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint510_cl
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
      ON ACTION closed
         IF cl_auth_chk_act("closed") THEN
            LET lc_state = "C"
            #add-point:action控制 name="statechange.closed"
                                    
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirm_transfer_out
         IF cl_auth_chk_act("confirm_transfer_out") THEN
            LET lc_state = "O"
            #add-point:action控制 name="statechange.confirm_transfer_out"
                                    
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirm_transfer_in
         IF cl_auth_chk_act("confirm_transfer_in") THEN
            LET lc_state = "P"
            #add-point:action控制 name="statechange.confirm_transfer_in"
                                    
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
      AND lc_state <> "C"
      AND lc_state <> "O"
      AND lc_state <> "P"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_indc_m.indcstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aint510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET lc_state_o = lc_state  #add by geza 20161010
   LET l_indcstus_o = g_indc_m.indcstus #add by geza 20161010
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   #add by geza 20160919 #160909-00069#5(S)
   #状态是Y的
   #状态码为Y.已审核，则取消审核只更新状态码为N未审核，不做库存异动等其他处理，拨出审核调用拨出拨出审核元件处理，
   IF lc_state = 'N' AND g_indc_m.indcstus = 'Y' THEN
      #161217-00002#1 Add By Ken 161221(S)
      #當一階段調撥且一階段調撥是否需要確認='Y'時 需檢查是否存在裝箱單
      IF (l_gzcb002 = 'Y') AND (g_indc_m.indc000 = '1') THEN
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n
           FROM inbm_t
          WHERE inbment = g_enterprise
            AND inbm004 = g_indc_m.indcdocno
            AND inbmstus != 'X'
         IF l_n > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00823'
            LET g_errparam.extend = g_indc_m.indcdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF        
      END IF
      #161217-00002#1 Add By Ken 161221(E)      
      
      UPDATE indc_t SET indcstus = 'N'     
       WHERE indcent = g_enterprise 
         AND indcdocno = g_indc_m.indcdocno         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      END IF
      LET l_success = TRUE
   END IF    
   #状态码为Y.已审核,拨出审核调用拨出拨出审核元件处理，
   IF lc_state = 'O' AND g_indc_m.indcstus = 'Y' THEN
      CALL s_aint510_outconf_chk(g_indc_m.indcdocno,g_indc_m.indcstus) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('ain-00111') THEN #是否执行拨出确认
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL cl_err_collect_show()   #151130-00019#1 20151203 add by beckxie
            IF NOT aint510_conf_input('o') THEN
               CALL s_transaction_end('N','0')
               #CALL cl_err_collect_show()   #151130-00019#1 20151203 mark by beckxie
               RETURN
            END IF
            CALL cl_err_collect_init()   #151130-00019#1 20151203 add by beckxie
            CALL s_aint510_outconf_upd(g_indc_m.indcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               IF cl_null(g_indc_m.indc007) THEN
                  LET lc_state = 'C'
               END IF
            END IF
         END IF
      END IF
   END IF       
   #add by geza 20160919 #160909-00069#5(E)
   
   #撥出確認
   IF lc_state = 'O' AND g_indc_m.indcstus = 'N' THEN
      CALL s_aint510_outconf_chk(g_indc_m.indcdocno,g_indc_m.indcstus) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('ain-00111') THEN #是否执行拨出确认
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL cl_err_collect_show()   #151130-00019#1 20151203 add by beckxie
            IF NOT aint510_conf_input('o') THEN
               CALL s_transaction_end('N','0')
               #CALL cl_err_collect_show()   #151130-00019#1 20151203 mark by beckxie
               RETURN
            END IF
            CALL cl_err_collect_init()   #151130-00019#1 20151203 add by beckxie
            CALL s_aint510_outconf_upd(g_indc_m.indcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               IF cl_null(g_indc_m.indc007) THEN
                  LET lc_state = 'C'
               END IF
            END IF
         END IF
      END IF
   END IF
   
   #撥入確認
   IF lc_state = 'P' AND g_indc_m.indcstus = 'O' THEN
      CALL s_aint510_inconf_chk(g_indc_m.indcdocno,g_indc_m.indcstus)
         RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('ain-00112') THEN #是否执行拨入确认
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL cl_err_collect_show()   #151130-00019#1 20151203 add by beckxie
            IF NOT aint510_conf_input('i') THEN
               CALL s_transaction_end('N','0')
               #CALL cl_err_collect_show()   #151130-00019#1 20151203 mark by beckxie
               RETURN
            END IF
            CALL cl_err_collect_init()   #151130-00019#1 20151203 add by beckxie
            CALL s_aint510_inconf_upd(g_indc_m.indcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               SELECT COUNT(1) INTO l_cnt FROM indd_t WHERE inddent = g_enterprise AND indddocno = g_indc_m.indcdocno AND indd021 <> indd031
               IF l_cnt = 0 THEN
                  LET lc_state = 'C'
               END IF
            END IF
         END IF
      END IF
   END IF
   
   #取消撥出確認
   IF lc_state = 'N' AND g_indc_m.indcstus = 'O' THEN
      CALL s_aint510_unoutconf_chk(g_indc_m.indcdocno,g_indc_m.indcstus)
         RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('ain-00113') THEN #是否执行取消拨出确认
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_aint510_unoutconf_upd(g_indc_m.indcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            END IF
         END IF
      END IF
   END IF
   #取消撥入確認
   IF lc_state = 'O' AND g_indc_m.indcstus = 'P' THEN
      CALL s_aint510_uninconf_chk(g_indc_m.indcdocno,g_indc_m.indcstus)
         RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('ain-00114') THEN #是否执行取消拨入确认
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_aint510_uninconf_upd(g_indc_m.indcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            END IF
         END IF
      END IF
   END IF
   
   #作廢
   IF lc_state = 'X' THEN
      CALL s_aint510_void_chk(g_indc_m.indcdocno,g_indc_m.indcstus)
         RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN #是否执行作废
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_aint510_void_upd(g_indc_m.indcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               #161109-00078#6 Add By Ken 161114(S)
               IF NOT s_aint510_indj021_upd(g_indc_m.indcdocno) THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN               
               END IF
               #161109-00078#6 Add By Ken 161114(E)
            END IF
         END IF
      END IF
   END IF
   
   #161217-00002#1 Add By Ken 161220(S)
   #確認
   IF lc_state = 'Y' THEN
      CALL s_aint510_conf_chk(g_indc_m.indcdocno,g_indc_m.indcstus)
         RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN #是否执行作废
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_aint510_conf_upd(g_indc_m.indcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            END IF
         END IF
      END IF
   END IF   
   #161217-00002#1 Add By Ken 161220(E)
   
   CALL cl_err_collect_show()
   
   #刷新显示对应调拨单号
   INITIALIZE g_indc_m.indc001,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024 TO NULL
   SELECT indc001,indc021,indc022,indc023,indc024 
     INTO g_indc_m.indc001,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024
     FROM indc_t
    WHERE indcent = g_enterprise AND indcdocno = g_indc_m.indcdocno
   DISPLAY BY NAME g_indc_m.indc001,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024
   #end add-point
   
   LET g_indc_m.indcmodid = g_user
   LET g_indc_m.indcmoddt = cl_get_current()
   LET g_indc_m.indcstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE indc_t 
      SET (indcstus,indcmodid,indcmoddt) 
        = (g_indc_m.indcstus,g_indc_m.indcmodid,g_indc_m.indcmoddt)     
    WHERE indcent = g_enterprise AND indcdocno = g_indc_m.indcdocno
 
    
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
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "O"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_out.png")
         WHEN "P"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_in.png")
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
      EXECUTE aint510_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcsite,g_indc_m.indcdocdt, 
          g_indc_m.indcdocno,g_indc_m.indc001,g_indc_m.indc004,g_indc_m.indc101,g_indc_m.indcunit,g_indc_m.indc199, 
          g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc026,g_indc_m.indc025, 
          g_indc_m.indc200,g_indc_m.indc201,g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc007,g_indc_m.indc008, 
          g_indc_m.indcstus,g_indc_m.indc021,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc024,g_indc_m.indcownid, 
          g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt,g_indc_m.indcmodid, 
          g_indc_m.indcmoddt,g_indc_m.indccnfid,g_indc_m.indccnfdt,g_indc_m.indcsite_desc,g_indc_m.indc004_desc, 
          g_indc_m.indc101_desc,g_indc_m.indc200_desc,g_indc_m.indc201_desc,g_indc_m.indc005_desc,g_indc_m.indc006_desc, 
          g_indc_m.indc007_desc,g_indc_m.indc021_desc,g_indc_m.indc023_desc,g_indc_m.indcownid_desc, 
          g_indc_m.indcowndp_desc,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc,g_indc_m.indcmodid_desc, 
          g_indc_m.indccnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_indc_m.indcsite,g_indc_m.indcsite_desc,g_indc_m.indcdocdt,g_indc_m.indcdocno, 
          g_indc_m.indc001,g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indc101,g_indc_m.indc101_desc, 
          g_indc_m.indcunit,g_indc_m.indc199,g_indc_m.indc000,g_indc_m.indc202,g_indc_m.indc002,g_indc_m.indc003, 
          g_indc_m.indc026,g_indc_m.indc025,g_indc_m.indc200,g_indc_m.indc200_desc,g_indc_m.indc201, 
          g_indc_m.indc201_desc,g_indc_m.indc005,g_indc_m.indc005_desc,g_indc_m.indc006,g_indc_m.indc006_desc, 
          g_indc_m.indc007,g_indc_m.indc007_desc,g_indc_m.indc008,g_indc_m.indcstus,g_indc_m.indc021, 
          g_indc_m.indc021_desc,g_indc_m.indc022,g_indc_m.indc023,g_indc_m.indc023_desc,g_indc_m.indc024, 
          g_indc_m.indcownid,g_indc_m.indcownid_desc,g_indc_m.indcowndp,g_indc_m.indcowndp_desc,g_indc_m.indccrtid, 
          g_indc_m.indccrtid_desc,g_indc_m.indccrtdp,g_indc_m.indccrtdp_desc,g_indc_m.indccrtdt,g_indc_m.indcmodid, 
          g_indc_m.indcmodid_desc,g_indc_m.indcmoddt,g_indc_m.indccnfid,g_indc_m.indccnfid_desc,g_indc_m.indccnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   IF NOT l_success THEN
      CALL s_transaction_end('N','1')
   ELSE      
      CALL s_transaction_end('Y','1')
   END IF
   #add by geza 20161010 160929-00012#1(S)
   #aint512拨出审核的调用s_ainp512
   IF g_indc_m.indc199 = '2' THEN
      CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys 
      IF l_sys = 'Y' THEN
         IF lc_state_o = 'O' AND l_indcstus_o MATCHES "[NY]"  THEN
            LET l_wc = " indcdocno = '",g_indc_m.indcdocno,"' "
            CALL s_ainp512_send(l_wc)  RETURNING l_success,p_cnt 
         END IF
      END IF
   END IF
   #add by geza 20161010 160929-00012#1(E) 
   #add by geza 20161010 160929-00012#1(S)
   #aint513拨入审核的调用s_ainp513
   IF g_indc_m.indc199 = '3' OR g_indc_m.indc199 = '7' THEN
      CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys 
      IF l_sys = 'Y' THEN
         IF lc_state_o = 'P' AND l_indcstus_o  = 'O'  THEN
            LET l_wc = " indcdocno = '",g_indc_m.indcdocno,"' "
            CALL s_ainp513_send(l_wc)  RETURNING l_success,p_cnt 
         END IF
      END IF
   END IF
   #add by geza 20161010 160929-00012#1(E) 
   CALL aint510_b_fill()      #150528-00016#1 150608 By pomelo add
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
            
   #end add-point  
 
   CLOSE aint510_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint510_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint510.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aint510_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
            
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_indd_d.getLength() THEN
         LET g_detail_idx = g_indd_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_indd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_indd_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_indd2_d.getLength() THEN
         LET g_detail_idx = g_indd2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_indd2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_indd2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
            
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint510.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aint510_b_fill2(pi_idx)
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
   
   CALL aint510_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aint510.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aint510_fill_chk(ps_idx)
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
 
{<section id="aint510.status_show" >}
PRIVATE FUNCTION aint510_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint510.mask_functions" >}
&include "erp/ain/aint510_mask.4gl"
 
{</section>}
 
{<section id="aint510.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aint510_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL aint510_show()
   CALL aint510_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #160303-00028#11 160310 By pomelo add(S)
   IF g_site = g_indc_m.indc005 AND g_indc_m.indc000 MATCHES '[12]' THEN
      IF NOT s_aint510_outconf_chk(g_indc_m.indcdocno,g_indc_m.indcstus) THEN
         CLOSE aint510_cl
         CALL s_transaction_end('N','0')
         RETURN FALSE
      END IF
   END IF
   IF g_site = g_indc_m.indc006 AND g_indc_m.indc000 = '3' THEN
      IF NOT s_aint510_inconf_chk(g_indc_m.indcdocno,g_indc_m.indcstus) THEN
         CLOSE aint510_cl
         CALL s_transaction_end('N','0')
         RETURN FALSE
      END IF
   END IF
   #160303-00028#11 160310 By pomelo add(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_indc_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_indd_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_indd2_d))
 
 
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
   #CALL aint510_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aint510_ui_headershow()
   CALL aint510_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aint510_draw_out()
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
   CALL aint510_ui_headershow()  
   CALL aint510_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aint510.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint510_set_pk_array()
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
   LET g_pk_array[1].values = g_indc_m.indcdocno
   LET g_pk_array[1].column = 'indcdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint510.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aint510.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint510_msgcentre_notify(lc_state)
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
   CALL aint510_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_indc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint510.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint510_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint510.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION aint510_indc004_ref()
   CALL s_desc_get_person_desc(g_indc_m.indc004) RETURNING g_indc_m.indc004_desc
   DISPLAY BY NAME g_indc_m.indc004_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_indc007_ref()
   
   CALL s_desc_get_stock_desc(g_site,g_indc_m.indc007) RETURNING g_indc_m.indc007_desc
   DISPLAY BY NAME g_indc_m.indc007_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_indc021_ref()
   
   CALL s_desc_get_person_desc(g_indc_m.indc021) RETURNING g_indc_m.indc021_desc
   DISPLAY BY NAME g_indc_m.indc021_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_indc023_ref()
   
   CALL s_desc_get_person_desc(g_indc_m.indc023) RETURNING g_indc_m.indc023_desc
   DISPLAY BY NAME g_indc_m.indc023_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_indd002_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_indd_d[l_ac].indd002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_indd_d[l_ac].indd002_desc = '', g_rtn_fields[1] , ''
   LET g_indd_d[l_ac].indd002_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_indd_d[l_ac].indd002_desc
   DISPLAY BY NAME g_indd_d[l_ac].indd002_desc_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_indd006_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_indd_d[l_ac].indd006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_indd_d[l_ac].indd006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_indd_d[l_ac].indd006_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_indd007_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_indd_d[l_ac].indd007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_indd_d[l_ac].indd007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_indd_d[l_ac].indd007_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_indd022_ref()
   
   CALL s_desc_get_stock_desc(g_site,g_indd_d[l_ac].indd022) RETURNING g_indd_d[l_ac].indd022_desc
   DISPLAY BY NAME g_indd_d[l_ac].indd022_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_indd023_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_indd_d[l_ac].indd022
   LET g_ref_fields[2] = g_indd_d[l_ac].indd023
   CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_indc_m.indc005||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
   LET g_indd_d[l_ac].indd023_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_indd_d[l_ac].indd023_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_indd032_ref()
   
   CALL s_desc_get_stock_desc(g_site,g_indd_d[l_ac].indd032) RETURNING g_indd_d[l_ac].indd032_desc
   DISPLAY BY NAME g_indd_d[l_ac].indd032_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_indd033_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_indd_d[l_ac].indd032
   LET g_ref_fields[2] = g_indd_d[l_ac].indd033
   CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_indc_m.indc006||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
   LET g_indd_d[l_ac].indd033_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_indd_d[l_ac].indd033_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_set_combo(p_cmd)
DEFINE p_cmd      LIKE type_t.chr1
DEFINE l_values   STRING
DEFINE l_items    STRING
DEFINE l_gzcb002  LIKE gzcb_t.gzcb002
DEFINE l_gzcbl004 LIKE gzcbl_t.gzcbl004
DEFINE l_sql      STRING

   LET l_values = NULL
   LET l_items = NULL
   LET l_gzcb002 = NULL
   LET l_gzcbl004 = NULL
   LET l_sql = "SELECT gzcb002,gzcbl004 ",
               "  FROM gzcb_t,gzcbl_t ",
               " WHERE gzcb001 = gzcbl001 ",
               "   AND gzcb002 = gzcbl002 AND gzcb001 = '6016' AND gzcbl003 = '",g_dlang,"' "
   #150127-00004#13 15/03/17 By pomelo add(S)
   CASE g_argv[1]
      WHEN '0'    #aint510
         LET l_sql = l_sql, " ORDER BY gzcb001 "
      WHEN '1'    #aint511
         CASE p_cmd
            WHEN 'a' #新增
               LET l_sql = l_sql CLIPPED,
                     "   AND gzcb002 IN ('1','2') ",
                     " ORDER BY gzcb001 "
            WHEN 'u' #修改
               LET l_sql = l_sql CLIPPED,
                     "   AND gzcb002 IN ('1','2','5') ",
                     " ORDER BY gzcb001 "
            WHEN 'q' #查询
               LET l_sql = l_sql CLIPPED,
                     "   AND gzcb002 IN ('1','2','3','5') ",
                     " ORDER BY gzcb001 "
         END CASE
      WHEN '2'    #aint512
         LET l_sql = l_sql CLIPPED,
                     "   AND gzcb002 IN ('4') ",
                     " ORDER BY gzcb001 "
      WHEN '3'    #aint513
         LET l_sql = l_sql CLIPPED,
                     #"   AND gzcb002 IN ('6') ",            #151225-00011#1 151230 By pomelo mark
                     "   AND gzcb002 IN ('1','6','7','8')",  #151225-00011#1 151230 By pomelo add
                     " ORDER BY gzcb001 "
   END CASE
   #150127-00004#13 15/03/17 By pomelo add(E)
   #150127-00004#13 15/03/17 By pomelo mark(S)   
   #CASE p_cmd
   #   WHEN 'a' #新增
   #      LET l_sql = l_sql CLIPPED,
   #            "   AND gzcb002 IN ('1','2') ",
   #            " ORDER BY gzcb001 "
   #   WHEN 'u' #修改
   #      LET l_sql = l_sql CLIPPED,
   #            "   AND gzcb002 IN ('1','2','4','5','6') ",     #150302-00004#7 150316 By pomelo add '5'
   #            " ORDER BY gzcb001 "
   #   WHEN 'q' #查询
   #      LET l_sql = l_sql CLIPPED,
   #            "   AND gzcb002 IN ('1','2','3','4','5','6') ", #150302-00004#7 150316 By pomelo add '4','5'
   #            " ORDER BY gzcb001 "
   #END CASE
   #150127-00004#13 15/03/17 By pomelo mark(E)
   PREPARE aint510_set_combo_pre FROM l_sql
   DECLARE aint510_set_combo_cs CURSOR FOR aint510_set_combo_pre
   FOREACH aint510_set_combo_cs INTO l_gzcb002,l_gzcbl004
      LET l_values = l_values CLIPPED ,",",l_gzcb002
      LET l_items  = l_items CLIPPED ,",",l_gzcb002 CLIPPED,':',l_gzcbl004
   END FOREACH
   CALL cl_set_combo_items("indc002",l_values,l_items)
END FUNCTION
#+
PRIVATE FUNCTION aint510_inddseq_init()
   
   SELECT MAX(inddseq)+1 INTO g_indd_d[l_ac].inddseq
     FROM indd_t
    WHERE inddent = g_enterprise AND indddocno = g_indc_m.indcdocno
   IF cl_null(g_indd_d[l_ac].inddseq) THEN
      LET g_indd_d[l_ac].inddseq = 1
   END IF
END FUNCTION
#+
PRIVATE FUNCTION aint510_indd003_chk()
DEFINE l_rtdxstus   LIKE rtdx_t.rtdxstus
DEFINE l_rtdx003    LIKE rtdx_t.rtdx003
DEFINE l_rtdx003_2  LIKE rtdx_t.rtdx003
#151204-00007#10 151228 By pomelo add(S)
DEFINE r_success    LIKE type_t.num5
DEFINE l_imaa001    LIKE imaa_t.imaa001
#151204-00007#10 151228 By pomelo add(E)

   INITIALIZE g_errno TO NULL
   #151204-00007#10 151228 By pomelo add(S)
   LET r_success = TRUE
   
   LET l_imaa001 = ''
   SELECT imay001 INTO l_imaa001
     FROM imay_t 
    WHERE imayent = g_enterprise 
      AND imay003 = g_indd_d[l_ac].indd003
   #151204-00007#10 151228 By pomelo add(E)
   
   SELECT rtdxstus,rtdx003 INTO l_rtdxstus,l_rtdx003 #151013-00001#28---add-rtdx003
     FROM rtdx_t
    #151204-00007#10 151228 By pomelo add(S)
    WHERE rtdxent = g_enterprise
      AND rtdx001 = l_imaa001
    #151204-00007#10 151228 By pomelo add(E)
   #151204-00007#10 151228 By pomelo mark(S)
   #WHERE rtdxent = g_enterprise AND rtdx001 = (SELECT imay001 
   #                                              FROM imay_t 
   #                                             WHERE imayent = g_enterprise 
   #                                               AND imay003 = g_indd_d[l_ac].indd003)
   #151204-00007#10 151228 By pomelo add(E)
      AND rtdxsite = g_indc_m.indc005
   CASE
      #WHEN SQLCA.sqlcode = 100 LET g_errno = 'ain-00067' #錄入條碼對應的料號不存在於撥出組織的門店商品清單中
      #WHEN l_rtdxstus != 'Y'   LET g_errno = 'ain-00068' #錄入條碼對應的料號在撥出組織的門店商品清單中已無效
      #WHEN l_rtdx003 = '3'     LET g_errno = 'ain-00687' #撥出組織的門店商品為扣率代銷，不可以調撥。 #151013-00001#28---add
      #151204-00007#10 151228 By pomelo add(S)
      WHEN SQLCA.sqlcode = 100
         #錄入條碼對應的料號不存在於撥出組織的門店商品清單中
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ain-00067"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      WHEN l_rtdxstus != 'Y'
         #錄入條碼對應的料號在撥出組織的門店商品清單中已無效
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ain-00068"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      WHEN l_rtdx003 = '3'
         #撥出組織的門店商品為扣率代銷，不可以調撥。
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ain-00687"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      #151204-00007#10 151228 By pomelo add(E)
   END CASE
   
#151013-00001#28---add---begin-----by huangrh---- 
   #撥出和撥入組織的商品的經營方式要一致。
   IF cl_null(g_errno) THEN
      LET l_rtdx003_2=''
      SELECT rtdx003 INTO l_rtdx003_2
        FROM rtdx_t
       #151204-00007#10 151228 By pomelo add(S)
       WHERE rtdxent = g_enterprise
         AND rtdx001 = l_imaa001
       #151204-00007#10 151228 By pomelo add(E)
      #151204-00007#10 151228 By pomelo mark(S)
      #WHERE rtdxent = g_enterprise AND rtdx001 = (SELECT imay001 
      #                                              FROM imay_t 
      #                                             WHERE imayent = g_enterprise 
      #                                               AND imay003 = g_indd_d[l_ac].indd003)
      #151204-00007#10 151228 By pomelo mark(E)
         AND rtdxsite = g_indc_m.indc006
       #若撥入組織門店清單存在此商品，則要求撥出和撥入組織的商品的經營方式要一致。       
       IF NOT cl_null(l_rtdx003_2) AND l_rtdx003<>l_rtdx003_2 THEN
          #LET g_errno = 'ain-00688'    #151204-00007#10 151228 By pomelo mark
          #151204-00007#10 151228 By pomelo add(S)
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = "ain-00688"
          LET g_errparam.extend = ""
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
          #151204-00007#10 151228 By pomelo add(E)
       END IF  
   END IF
#151013-00001#28---add---end-----by huangrh----   
#151013-00001#28---mark---begin-----by huangrh----
#   IF cl_null(g_errno) THEN
#      SELECT rtdxstus INTO l_rtdxstus
#        FROM rtdx_t
#       WHERE rtdxent = g_enterprise AND rtdx001 = (SELECT imay001 
#                                                     FROM imay_t 
#                                                    WHERE imayent = g_enterprise 
#                                                      AND imay003 = g_indd_d[l_ac].indd003)
#         AND rtdxsite = g_indc_m.indc006
#      CASE
#         WHEN SQLCA.sqlcode = 100 LET g_errno = 'ain-00069' #錄入條碼對應的料號不存在於撥出組織的門店商品清單中
#         WHEN l_rtdxstus != 'Y'   LET g_errno = 'ain-00070' #錄入條碼對應的料號在撥出組織的門店商品清單中已無效
#      END CASE
#   END IF
#151013-00001#28---mark---end-----by huangrh----   
   
   #151204-00007#10 151228 By pomelo add(S)
   IF NOT aint510_chk_indd002_indd032(l_imaa001) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
   #151204-00007#10 151228 By pomelo add(E)
END FUNCTION
#=
PRIVATE FUNCTION aint510_indd003_init()
   
   IF cl_null(g_indd_d[l_ac].indd003) THEN
      INITIALIZE g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd005,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd008
              TO NULL
      RETURN
   END IF
   
   INITIALIZE g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd005,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd008
           TO NULL
              
   SELECT imay001,imay014,imay004,imay005 
     INTO g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd008
     FROM imay_t
    WHERE imayent = g_enterprise AND imay003 = g_indd_d[l_ac].indd003 AND imaystus = 'Y'
    
   SELECT rtdx003 INTO g_indd_d[l_ac].indd005
     FROM rtdx_t
    WHERE rtdxent = g_enterprise AND rtdxsite = g_indc_m.indc005 AND rtdx001 = g_indd_d[l_ac].indd002
    
   DISPLAY BY NAME g_indd_d[l_ac].indd002,
                   g_indd_d[l_ac].indd005,
                   g_indd_d[l_ac].indd006,
                   g_indd_d[l_ac].indd007,
                   g_indd_d[l_ac].indd008
                   
   CALL aint510_indd002_ref()
   CALL aint510_indd006_ref()
   CALL aint510_indd007_ref()
   #161017-00029#5 -s by 08172
   IF g_prog MATCHES "aint511" OR g_prog MATCHES "aint513" THEN
      INITIALIZE g_indd_d[l_ac].indd004 TO NULL
      SELECT imay019 INTO g_indd_d[l_ac].indd004
        FROM imay_t 
       WHERE imayent = g_enterprise
         AND imay003 = g_indd_d[l_ac].indd003
         AND imaystus = 'Y'
      DISPLAY BY NAME g_indd_d[l_ac].indd004      
   END IF
   #161017-00029#5 -e by 08172
   
END FUNCTION
#+
PRIVATE FUNCTION aint510_indc002_chk()
DEFINE l_rtdxstus   LIKE rtdx_t.rtdxstus

   INITIALIZE g_errno TO NULL
   
   SELECT rtdxstus INTO l_rtdxstus
     FROM rtdx_t
    WHERE rtdxent = g_enterprise AND rtdx001 = g_indd_d[l_ac].indd002
      AND rtdxsite = g_indc_m.indc006
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'ain-00065' #錄入的資料不存在於撥入組織的門店商品清單中,請至artq400中查詢后重新錄入
      WHEN l_rtdxstus != 'Y'   LET g_errno = 'ain-00066' #錄入的資料在門店商品清單中已無效,請至artq400中查詢后重新錄入
   END CASE
   
END FUNCTION
#+
PRIVATE FUNCTION aint510_indd002_init()
   DEFINE l_n   LIKE type_t.num5   #161017-00029#8  by 08172
   IF cl_null(g_indd_d[l_ac].indd002) THEN
      INITIALIZE g_indd_d[l_ac].indd003,g_indd_d[l_ac].indd005,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd008
              TO NULL
      RETURN
   END IF
   
#   INITIALIZE g_indd_d[l_ac].indd003,g_indd_d[l_ac].indd005,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd008
#           TO NULL     #161017-00029#8 by 08172
   
   INITIALIZE g_indd_d[l_ac].indd005,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd008 TO NULL
   SELECT imaa104,imaa104,1 
     INTO g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd008
     FROM imaa_t
    WHERE imaaent = g_enterprise AND imaa001 = g_indd_d[l_ac].indd002 AND imaastus = 'Y'
    
   SELECT rtdx003,rtdx052   #151204-00007#5 151215 By pomelo add rtdx052
     INTO g_indd_d[l_ac].indd005,g_indd_d[l_ac].indd045 #151204-00007#5 151215 By pomelo add indd045
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = g_indc_m.indc005
      AND rtdx001 = g_indd_d[l_ac].indd002
    
   CALL aint510_indd002_ref()
   CALL aint510_indd006_ref()
   CALL aint510_indd007_ref()
   
   #161017-00029#8 -s by 08172
   SELECT COUNT(1) INTO l_n
     FROM imay_t
    WHERE imayent = g_enterprise AND imay001 = g_indd_d[l_ac].indd002 AND imay003 = g_indd_d[l_ac].indd003 AND imaystus = 'Y'
   IF l_n = 0 THEN
   #161017-00029#8 -e by 08172
      INITIALIZE g_indd_d[l_ac].indd003 TO NULL
      SELECT imay003 INTO g_indd_d[l_ac].indd003
        FROM imay_t
       WHERE imayent = g_enterprise AND imay001 = g_indd_d[l_ac].indd002 AND imay006 = 'Y' AND imaystus = 'Y'
   END IF   #161017-00029#8  by 08172
   DISPLAY BY NAME g_indd_d[l_ac].indd003,
                   g_indd_d[l_ac].indd005,
                   g_indd_d[l_ac].indd006,
                   g_indd_d[l_ac].indd007,
                   g_indd_d[l_ac].indd008
                   
   #151204-00007#5 151215 By pomelo add(S)
   IF cl_null(g_indd_d[l_ac].indd045) THEN
      LET g_indd_d[l_ac].indd045 = 0
   END IF
   IF cl_null(g_indd_d[l_ac].indd021) THEN
      LET g_indd_d[l_ac].indd046 = 0
   ELSE
      LET g_indd_d[l_ac].indd046 = g_indd_d[l_ac].indd045 * g_indd_d[l_ac].indd021
   END IF
   DISPLAY BY NAME g_indd_d[l_ac].indd045,g_indd_d[l_ac].indd046
   #151204-00007#5 151215 By pomelo add(E)
END FUNCTION
#+
PRIVATE FUNCTION aint510_indc007_init()
DEFINE l_sys1        LIKE type_t.chr80       #组织间调拨是否启用在途
DEFINE l_sys2        LIKE type_t.chr80       #组织内调拨是否启用在途
DEFINE l_sys3        LIKE type_t.chr80       #在途仓归属 1.拨出 2.拨入
#150127-00004#17 151021 By pomelo add(S)
DEFINE l_ooef125     LIKE ooef_t.ooef125     #在途成本倉
DEFINE l_ooef128     LIKE ooef_t.ooef128     #在途非成本倉
DEFINE l_inaa010     LIKE inaa_t.inaa010     #成本性質
DEFINE l_sql         STRING
#150127-00004#17 151021 By pomelo add(E)

   #160225-00007#1 160225 By pomelo mark(S)
   #IF cl_null(g_indc_m.indc005) OR cl_null(g_indc_m.indc006) THEN
   #   RETURN
   #END IF
   #160225-00007#1 160225 By pomelo mark(E)

   #取参数
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0013') RETURNING l_sys1
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0014') RETURNING l_sys2
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0015') RETURNING l_sys3

   IF g_indc_m.indc005 <> g_indc_m.indc006 THEN
      IF cl_null(l_sys1) OR l_sys1 <> 'Y' THEN
         RETURN
      END IF
   ELSE
      IF cl_null(l_sys2) OR l_sys2 <> 'Y' THEN
         RETURN
      END IF
   END IF
   
   #150127-00004#17 151021 By pomelo mark(S)
   #CASE l_sys3
   #   WHEN '1'
   #      SELECT ooef125 INTO g_indc_m.indc007
   #        FROM ooef_t
   #       WHERE ooefent = g_enterprise AND ooef001 = g_indc_m.indc005
   #   WHEN '2'
   #      SELECT ooef125 INTO g_indc_m.indc007
   #        FROM ooef_t
   #       WHERE ooefent = g_enterprise AND ooef001 = g_indc_m.indc006
   #END CASE   
   #150127-00004#17 151021 By pomelo mark(E)
   
   #150127-00004#17 151021 By pomelo add(S)
   LET l_sql = "SELECT inaa010",
               "  FROM inaa_t",
               " WHERE inaaent = ",g_enterprise,
               "   AND inaasite = ?",
               "   AND inaa001 = ?"
   PREPARE aint510_get_inaa010 FROM l_sql
   
   LET l_inaa010 = ''
   IF cl_null(g_indc_m.indc200) THEN
      IF cl_null(g_indc_m.indc201) THEN
         LET l_inaa010 = 'Y'
      ELSE
         #撥出倉庫
         EXECUTE aint510_get_inaa010 USING g_indc_m.indc006,g_indc_m.indc201
            INTO l_inaa010
      END IF
   ELSE
      #撥入倉庫
      EXECUTE aint510_get_inaa010 USING g_indc_m.indc005,g_indc_m.indc200
         INTO l_inaa010
   END IF
   
   LET l_sql = "SELECT ooef125,ooef128",
               "  FROM ooef_t",
               " WHERE ooefent = ",g_enterprise,
               "   AND ooef001 = ?"
   PREPARE aint510_get_ooef FROM l_sql
   
   LET l_ooef125 = ''
   LET l_ooef128 = ''
   CASE l_sys3
      WHEN '1'
         EXECUTE aint510_get_ooef USING g_indc_m.indc005
            INTO l_ooef125,l_ooef128
      WHEN '2'
         EXECUTE aint510_get_ooef USING g_indc_m.indc006
            INTO l_ooef125,l_ooef128
   END CASE
   
   CASE l_inaa010
      WHEN 'Y'
         LET g_indc_m.indc007 = l_ooef125
      WHEN 'N'
         LET g_indc_m.indc007 = l_ooef128
   END CASE
   #150127-00004#17 151021 By pomelo add(E)

   
   DISPLAY BY NAME g_indc_m.indc007
END FUNCTION
#+
PRIVATE FUNCTION aint510_indc003_init()
   
   IF g_indc_m.indc199 = '1' THEN     #150127-00004#13 15/03/17 By pomelo add
      IF g_indc_m.indc002 = '2' AND NOT cl_null(g_indc_m.indc003) THEN
         SELECT inda003,inda004,inda006 INTO g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc008
           FROM inda_t
          WHERE indaent = g_enterprise AND indadocno = g_indc_m.indc003
      ELSE
         INITIALIZE g_indc_m.indc006,g_indc_m.indc008 TO NULL
         #LET g_indc_m.indc005 = g_site #161108-00059#1  16/11/11 mark by sunxh(S)
      END IF
   #150127-00004#13 15/03/17 By pomelo add(S)
   #151225-00011#1 151231 By pomelo mark(S)
   #ELSE
   #   IF g_indc_m.indc002 = '6' THEN
   #      SELECT indc005,indc006
   #        INTO g_indc_m.indc006, g_indc_m.indc005
   #        FROM indc_t
   #       WHERE indcent = g_enterprise
   #         AND indcdocno = g_indc_m.indc003
   #   END IF
   #151225-00011#1 151231 By pomelo mark(E)
   END IF
   #150127-00004#13 15/03/17 By pomelo add(E)
   
   #151225-00011#1 151231 By pomelo add(S)
   CASE g_indc_m.indc002
      WHEN '6'   #退貨申請單
         SELECT indmsite INTO g_indc_m.indc005
           FROM indm_t
          WHERE indment = g_enterprise
            AND indmdocno = g_indc_m.indc003
            
      OTHERWISE
         IF g_indc_m.indc002 MATCHES '[78]' THEN
            SELECT indc006,indc005,indc201,indc200
              INTO g_indc_m.indc005, g_indc_m.indc006, g_indc_m.indc200, g_indc_m.indc201
              FROM indc_t
             WHERE indcent = g_enterprise
               AND indcdocno = g_indc_m.indc003
            
            LET g_indc_m.indc200_desc = s_desc_get_stock_desc('',g_indc_m.indc200)
            LET g_indc_m.indc201_desc = s_desc_get_stock_desc('',g_indc_m.indc201)
            DISPLAY BY NAME g_indc_m.indc200, g_indc_m.indc200_desc,
                            g_indc_m.indc201, g_indc_m.indc201_desc
         END IF
   END CASE
   #151225-00011#1 151231 By pomelo add(E)
   
   CALL aint510_indc007_init()
   DISPLAY BY NAME g_indc_m.indc005,g_indc_m.indc006,g_indc_m.indc008
   CALL s_desc_get_department_desc(g_indc_m.indc005) RETURNING g_indc_m.indc005_desc
   DISPLAY BY NAME g_indc_m.indc005_desc
   CALL s_desc_get_department_desc(g_indc_m.indc006) RETURNING g_indc_m.indc006_desc
   DISPLAY BY NAME g_indc_m.indc006_desc
END FUNCTION
#+
PRIVATE FUNCTION aint510_detail_init()
#150127-00004#13 15/03/17 By pomelo add(S)
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_sum             LIKE indd_t.indd021
DEFINE l_success         LIKE type_t.num5
DEFINE l_indd            RECORD
       inddent           LIKE indd_t.inddent,     #企業編號
       inddsite          LIKE indd_t.inddsite,    #營運據點
       inddunit          LIKE indd_t.inddunit,    #應用組織
       indddocno         LIKE indd_t.indddocno,   #調撥單號
       inddseq           LIKE indd_t.inddseq,     #項次
       indd001           LIKE indd_t.indd001,     #來源項次
       indd002           LIKE indd_t.indd002,     #商品編號
       indd003           LIKE indd_t.indd003,     #商品條碼
       indd004           LIKE indd_t.indd004,     #產品特徵
       indd005           LIKE indd_t.indd005,     #經營方式
       indd006           LIKE indd_t.indd006,     #庫存單位
       indd007           LIKE indd_t.indd007,     #包裝單位
       indd008           LIKE indd_t.indd008,     #件裝數
       indd009           LIKE indd_t.indd009,     #預調撥量
       indd010           LIKE indd_t.indd010,     #多庫儲批否
       indd020           LIKE indd_t.indd020,     #撥出件數
       indd021           LIKE indd_t.indd021,     #撥出數量
       indd022           LIKE indd_t.indd022,     #撥出庫位
       indd023           LIKE indd_t.indd023,     #撥出儲位
       indd024           LIKE indd_t.indd024,     #撥出批號
       indd025           LIKE indd_t.indd025,     #撥出庫存數量
       indd030           LIKE indd_t.indd030,     #撥入件數
       indd031           LIKE indd_t.indd031,     #撥入數量
       indd032           LIKE indd_t.indd032,     #撥入庫位
       indd033           LIKE indd_t.indd033,     #撥入儲位
       indd034           LIKE indd_t.indd034,     #撥入批號
       indd035           LIKE indd_t.indd035,     #撥入庫存數量
       indd040           LIKE indd_t.indd040,     #結案否
       #151204-00007#5 151215 By pomelo add(S)
       indd045           LIKE indd_t.indd045,     #預估單價
       indd046           LIKE indd_t.indd046,     #預估金額
       #151204-00007#5 151215 By pomelo add(E)
       indd101           LIKE indd_t.indd101,     #來源單號
       indd102           LIKE indd_t.indd102      #庫存管理特徵
                         END RECORD
   DEFINE l_inddseq      LIKE indd_t.inddseq
   DEFINE l_indd002      LIKE indd_t.indd002
   DEFINE l_indd004      LIKE indd_t.indd004
   DEFINE l_indd006      LIKE indd_t.indd006
   DEFINE l_indd102      LIKE indd_t.indd102
   DEFINE l_indd022      LIKE indd_t.indd022
   DEFINE l_indd023      LIKE indd_t.indd023
   DEFINE l_indd024      LIKE indd_t.indd024
   DEFINE l_indd032      LIKE indd_t.indd032
   DEFINE l_indd033      LIKE indd_t.indd033
   DEFINE l_indd034      LIKE indd_t.indd034
   DEFINE l_indd025      LIKE indd_t.indd025
   DEFINE l_indd035      LIKE indd_t.indd035
   #151204-00007#5 151215 By pomelo add(S)
   DEFINE l_indd021      LIKE indd_t.indd021      #撥出數量
   DEFINE l_indd045      LIKE indd_t.indd045      #預估單價
   DEFINE l_indd046      LIKE indd_t.indd046      #預估金額
   #151204-00007#5 151215 By pomelo add(E)
   #151225-00011#1 151230 By pomelo add(S)
   DEFINE l_indn         RECORD
          indndocno      LIKE indn_t.indndocno,   #單據編號
          indnseq        LIKE indn_t.indnseq,     #項次
          indn001        LIKE indn_t.indn001,     #商品編號
          indn002        LIKE indn_t.indn002,     #商品主條碼
          indn003        LIKE indn_t.indn003,     #產品特徵
          indn004        LIKE indn_t.indn004,     #庫區
          indn005        LIKE indn_t.indn005,     #庫區
          indn006        LIKE indn_t.indn006,     #批號
          indn007        LIKE indn_t.indn007,     #退貨單位
          indn008        LIKE indn_t.indn008,     #包裝單位
          indn009        LIKE indn_t.indn009,     #件裝數
          indn012        LIKE indn_t.indn012,     #核准包裝數量
          indn013        LIKE indn_t.indn013,     #核准退貨數量
          indn021        LIKE indn_t.indn021,     #理由碼
          rtdx003        LIKE rtdx_t.rtdx003,     #經營方式
          imaa104        LIKE imaa_t.imaa104      #庫存單位
                         END RECORD
   #151225-00011#1 151230 By pomelo add(E)
 
   LET r_success = TRUE
   #151204-00007#5 151215 By pomelo add(S)
   LET l_sql = "SELECT rtdx052",
               "  FROM rtdx_t",
               " WHERE rtdxent = ",g_enterprise,
               "   AND rtdxsite = '",g_indc_m.indc005,"'",
               "   AND rtdx001 = ?"
   PREPARE aint510_detail_init_sel_rtdx052 FROM l_sql
   #151204-00007#5 151215 By pomelo add(E)
   IF g_indc_m.indc199 = '1' THEN
   #150127-00004#13 15/03/17 By pomelo add(E)
      IF g_indc_m.indc002 = '2' AND NOT cl_null(g_indc_m.indc003) THEN  
         INSERT INTO indd_t (inddent,    #企業編號
                             inddsite,   #營運據點
                             inddunit,   #應用組織
                             indddocno,  #調撥單號
                             inddseq,    #項次
                             indd001,    #來源項次
                             indd002,    #商品編號
                             indd003,    #商品條碼
                             indd004,    #產品特徵
                             indd005,    #經營方式
                             indd006,    #庫存單位
                             indd007,    #包裝單位
                             indd008,    #件裝數
                             indd009,    #預調撥量
                             indd010,    #多庫儲批否
                             indd020,    #撥出件數
                             indd021,    #撥出數量
                             indd022,    #撥出庫位
                             indd023,    #撥出儲位
                             indd024,    #撥出批號
                             indd030,    #撥入件數
                             indd031,    #撥入數量
                             indd032,    #撥入庫位
                             indd033,    #撥入儲位
                             indd034,    #撥入批號
                             indd040     #結案否
                             )
         SELECT g_enterprise,            #企業編號
                g_indc_m.indcsite,       #營運據點
                g_indc_m.indcunit,       #應用組織
                g_indc_m.indcdocno,      #調撥單號
                ROWNUM,                  #項次    
                indbseq,                 #來源項次
                indb001,                 #商品編號
                indb002,                 #商品條碼
                indb003,                 #產品特徵
                rtdx003,                 #經營方式
                indb004,                 #庫存單位
                indb005,                 #包裝單位
                indb006,                 #件裝數  
                indb010,                 #預調撥量
                'N',                     #多庫儲批否
                indb009,                 #撥出件數
                indb010,                 #撥出數量
                g_indc_m.indc200,        #撥出庫位
                '',                      #撥出儲位
                '',                      #撥出批號
                indb009,                 #撥入件數
                indb010,                 #撥入數量
                g_indc_m.indc201,        #撥入庫位
                '',                      #撥入儲位
                '',                      #撥入批號
                'N'                      #結案否  
           FROM indb_t LEFT OUTER JOIN rtdx_t ON (rtdxent = indbent AND rtdxsite = g_indc_m.indcsite AND rtdx001 = indb001)
          WHERE indbent = g_enterprise AND indbdocno = g_indc_m.indc003
         
         #151204-00007#5 151215 By pomelo mark(S)
         #INSERT INTO indl_t(indlent, indlsite, indlunit, indldocno,
         #                   indlseq, indlseq1, indl001,  indl002,
         #                   indl003, indl004,  indl005,  indl020,
         #                   indl021, indl022,  indl023,  indl024,
         #                   indl030, indl031,  indl032,  indl033,
         #                   indl034, indl101)
         #SELECT inddent, inddsite, inddunit, indddocno,
         #       inddseq, 1,        indd003,  indd002,
         #       indd004, indd007,  indd006,  indd020,
         #       indd021, indd022,  indd023,  indd024,
         #       indd030, indd031,  indd032,  indd033,
         #       indd034, indd102
         #  FROM indd_t
         # WHERE inddent = g_enterprise
         #   AND indddocno = g_indc_m.indcdocno
         #IF SQLCA.sqlcode THEN
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.code = SQLCA.sqlcode
         #   LET g_errparam.extend = "Ins indl_t"
         #   LET g_errparam.popup = TRUE
         #   CALL cl_err()
         #   LET r_success = FALSE
         #   RETURN r_success
         #END IF
         #151204-00007#5 151215 By pomelo mark(E)
         
         #150709-00019#1 Add By Ken 150710(S)
         #151204-00007#5 151215 By pomelo mark(S)
         #LET l_sql = "Update indd_t SET indd025 = ?,indd035 = ? ",
         #            " WHERE inddent = ? ",
         #            "   AND indddocno = ? ",
         #            "   AND inddseq = ? "
         #151204-00007#5 151215 By pomelo add(S)
         LET l_sql = "UPDATE indd_t",
                     "   SET indd025 = ?,",
                     "       indd035 = ?,",
                     "       indd045 = ?,",
                     "       indd046 = ?",
                     " WHERE inddent = ",g_enterprise,
                     "   AND indddocno = '",g_indc_m.indcdocno,"'",
                     "   AND inddseq = ? "
         #151204-00007#5 151215 By pomelo add(E)
         PREPARE aint510_upd_inag009_pre FROM l_sql            
                  
         LET l_sql = "SELECT inddseq,indd002,indd004,indd006,indd102, ",
                     "       indd022,indd023,indd024,indd032,indd033, ",
                     "       indd034,indd021",    #151204-00007#5 151215 By pomelo add indd021
                     "  FROM indd_t ",
                     " WHERE inddent = ? ",
                     "   AND indddocno = ? "
         PREPARE aint510_get_inag009_pre FROM l_sql            
         DECLARE aint510_get_inag009_cs CURSOR FOR aint510_get_inag009_pre
         FOREACH aint510_get_inag009_cs USING g_enterprise,g_indc_m.indcdocno
                                      INTO l_inddseq,l_indd002,l_indd004,l_indd006,l_indd102, 
                                           l_indd022,l_indd023,l_indd024,l_indd032,l_indd033,
                                           l_indd034,l_indd021    #151204-00007#5 151215 By pomelo add indd021
            #撥出組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc005,l_indd002,l_indd004,l_indd102,
                                       l_indd022,l_indd023,l_indd024,l_indd006)            
                           RETURNING l_indd025
            #撥入組織庫存數量
            CALL s_aint510_get_inag009(g_indc_m.indc006,l_indd002,l_indd004,l_indd102,
                                       l_indd032,l_indd033,l_indd034,l_indd006)            
                           RETURNING l_indd035                     
            #151204-00007#5 151215 By pomelo mark(S)
            #EXECUTE aint510_upd_inag009_pre USING l_indd025,l_indd035,g_enterprise,g_indc_m.indcdocno,l_inddseq
            #151204-00007#5 151215 By pomelo mark(E)
            #151204-00007#5 151215 By pomelo add(S)
            LET l_indd045 = 0
            LET l_indd046 = 0
            EXECUTE aint510_detail_init_sel_rtdx052
              USING l_indd002
               INTO l_indd045
            IF cl_null(l_indd045) THEN
               LET l_indd045 = 0
            END IF
            LET l_indd046 = l_indd045 * l_indd021
            EXECUTE aint510_upd_inag009_pre
              USING l_indd025, l_indd035, l_indd045, l_indd046, l_inddseq
            #151204-00007#5 151215 By pomelo add(E)
         END FOREACH                                        
         
         #151204-00007#5 151215 By pomelo add(S)
         INSERT INTO indl_t(indlent, indlsite, indlunit, indldocno,
                            indlseq, indlseq1, indl001,  indl002,
                            indl003, indl004,  indl005,  indl020,
                            indl021, indl022,  indl023,  indl024,
                            indl030, indl031,  indl032,  indl033,
                            indl034, indl101,  indl102,  indl103)
         SELECT inddent, inddsite, inddunit, indddocno,
                inddseq, 1,        indd003,  indd002,
                indd004, indd007,  indd006,  indd020,
                indd021, indd022,  indd023,  indd024,
                indd030, indd031,  indd032,  indd033,
                indd034, indd102,  indd045,  indd046
           FROM indd_t
          WHERE inddent = g_enterprise
            AND indddocno = g_indc_m.indcdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Ins indl_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         #151204-00007#5 151215 By pomelo add(E)
                          
         #150709-00019#1 Add By Ken 150710(E)           
      END IF
      CALL aint510_b_fill()
   #150127-00004#13 15/03/17 By pomelo add(S)
   ELSE
      #151225-00011#1 151230 By pomelo add(S)
      LET l_sql = "SELECT COALESCE(MAX(inddseq),0)+1",
                  "  FROM indd_t",
                  " WHERE inddent =",g_enterprise,
                  "   AND indddocno = '",g_indc_m.indcdocno,"'"
      PREPARE aint510_gen_deatil_inddseq FROM l_sql
      #151225-00011#1 151230 By pomelo add(E)
      #IF g_indc_m.indc002 = '6' AND NOT cl_null(g_indc_m.indc003) THEN
      IF g_indc_m.indc002 MATCHES '[78]' AND NOT cl_null(g_indc_m.indc003) THEN  #151225-00011#1 151230 By pomelo add
         LET l_sql = "SELECT inddseq, indd002, indd003, indd004, rtdx003,",
                     "       indd006, indd007, indd008, indd031, indd030,",
                     "       indd031, indd032, indd033, indd034, indddocno,",
                     "       indd102",
                     "  FROM indd_t",
                     "  LEFT OUTER JOIN rtdx_t ON rtdxent = inddent",
                     "                        AND rtdxsite = '",g_indc_m.indcsite,"'",
                     "                        AND rtdx001 = indd002",
                     " WHERE inddent = ",g_enterprise,
                     "   AND indddocno = '",g_indc_m.indc003,"'"
         PREPARE aint510_gen_detail_pre FROM l_sql
         DECLARE aint510_gen_detail_cs CURSOR FOR aint510_gen_detail_pre
         
         #151225-00011#1 151230 By pomelo mark(S)
         #LET l_sql = "SELECT COALESCE(MAX(inddseq),0)+1",
         #            "  FROM indd_t",
         #            " WHERE inddent =",g_enterprise,
         #            "   AND indddocno = '",g_indc_m.indcdocno,"'"
         #PREPARE aint510_gen_deatil_inddseq FROM l_sql
         #151225-00011#1 151230 By pomelo mark(E)
         
         LET l_sql = "SELECT COALESCE(SUM(indd021),0)",
                     "  FROM indc_t,indd_t",
                     " WHERE indcent = inddent",
                     "   AND indcdocno = indddocno",
                     "   AND indcent = ",g_enterprise,
                     "   AND indc003 = '",g_indc_m.indc003,"'",
                     "   AND indcdocno != 'X'",
                     "   AND inddseq = ?",
                     "   AND indcsite = '",g_indc_m.indcsite,"'"
         PREPARE aint510_sum_indd021 FROM l_sql
         
         FOREACH aint510_gen_detail_cs
            INTO l_indd.indd001, l_indd.indd002, l_indd.indd003, l_indd.indd004, l_indd.indd005,
                 l_indd.indd006, l_indd.indd007, l_indd.indd008, l_indd.indd009, l_indd.indd020,
                 l_indd.indd021, l_indd.indd022, l_indd.indd023, l_indd.indd024, l_indd.indd101,
                 l_indd.indd102
            
            LET l_indd.inddent = g_enterprise
            LET l_indd.inddsite = g_indc_m.indcsite
            LET l_indd.inddunit = g_indc_m.indcunit
            LET l_indd.indddocno = g_indc_m.indcdocno
            
            #項次
            EXECUTE aint510_gen_deatil_inddseq INTO l_indd.inddseq
            
            #已轉倉退非作廢數量加總
            LET l_sum = 0
            EXECUTE aint510_sum_indd021 USING l_indd.indd001
               INTO l_sum
            
            LET l_indd.indd010 = 'N'
            LET l_indd.indd021 = l_indd.indd021 - l_sum
            LET l_indd.indd009 = l_indd.indd021
            LET l_indd.indd032 = g_indc_m.indc201
            LET l_indd.indd040 = 'N'
            
            #庫存轉包裝單位
            CALL s_aooi250_convert_qty(l_indd.indd002,l_indd.indd006,l_indd.indd007,l_indd.indd021)
               RETURNING l_success,l_indd.indd020
               
            #151204-00007#5 151215 By pomelo add(S)
            EXECUTE aint510_detail_init_sel_rtdx052
              USING l_indd.indd002
               INTO l_indd.indd045
            IF cl_null(l_indd.indd045) THEN
               LET l_indd.indd045 = 0
            END IF
            LET l_indd.indd046 = l_indd.indd045 * l_indd.indd021
            #151204-00007#5 151215 By pomelo add(E)
            
            #151225-00011#1 151230 By pomelo add(S)
            LET l_indd.indd024 = ' '
            LET l_indd.indd030 = l_indd.indd020
            LET l_indd.indd031 = l_indd.indd021
            LET l_indd.indd034 = ' '
            #撥出組織庫存數量
            LET l_indd.indd025 = s_aint510_get_inag009(g_indc_m.indc005, l_indd.indd002, l_indd.indd004, l_indd.indd102,
                                                       l_indd.indd022,   l_indd.indd023, l_indd.indd024, l_indd.indd006)
            #撥入組織庫存數量
            LET l_indd.indd035 = s_aint510_get_inag009(g_indc_m.indc006, l_indd.indd002, l_indd.indd004, l_indd.indd102,
                                                       l_indd.indd032,   l_indd.indd033, l_indd.indd034, l_indd.indd006)
            #151225-00011#1 151230 By pomelo add(E)
               
            INSERT INTO indd_t(inddent, inddsite, inddunit, indddocno,
                               inddseq, indd001,  indd002,  indd003,
                               indd004, indd005,  indd006,  indd007,
                               indd008, indd009,  indd020,  indd021,
                               indd022, indd023,  indd024,  indd030,
                               indd031, indd032,  indd033,  indd034,
                               indd040, indd101,  indd010,  indd045,
                               indd046, indd025,  indd035)  #151225-00011#1 151230 By pomelo add indd025,indd035
               VALUES(l_indd.inddent, l_indd.inddsite, l_indd.inddunit, l_indd.indddocno,
                      l_indd.inddseq, l_indd.indd001,  l_indd.indd002,  l_indd.indd003,
                      l_indd.indd004, l_indd.indd005,  l_indd.indd006,  l_indd.indd007,
                      l_indd.indd008, l_indd.indd009,  l_indd.indd020,  l_indd.indd021,
                      l_indd.indd022, l_indd.indd023,  l_indd.indd024,  l_indd.indd030,
                      l_indd.indd031, l_indd.indd032,  l_indd.indd033,  l_indd.indd034,
                      l_indd.indd040, l_indd.indd101,  l_indd.indd010,  l_indd.indd045,
                      l_indd.indd046, l_indd.indd025,  l_indd.indd035)  #151225-00011#1 151230 By pomelo add indd025,indd035
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins indd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
            
            IF NOT s_aint510_gen_indl(l_indd.inddsite, l_indd.inddunit, g_indc_m.indcdocno, l_indd.inddseq,
                                      l_indd.indd003,  l_indd.indd002,  l_indd.indd004,     l_indd.indd007,
                                      l_indd.indd006,  l_indd.indd020,  l_indd.indd021,     l_indd.indd022,
                                      l_indd.indd023,  l_indd.indd024,  l_indd.indd030,     l_indd.indd031,
                                      l_indd.indd032,  l_indd.indd033,  l_indd.indd034,     l_indd.indd102,
                                      #l_indd.indd010) THEN   #151204-00007#5 151215 By pomelo mark
                                      l_indd.indd010,  l_indd.indd045,  l_indd.indd046) THEN    #151204-00007#5 151215 By pomelo add
               LET r_success = FALSE
               RETURN r_success
            END IF            
         END FOREACH
      END IF
      
      #151225-00011#1 151230 By pomelo add(S)
      IF g_indc_m.indc002 = '6' AND NOT cl_null(g_indc_m.indc003) THEN
         LET l_sql = "SELECT indndocno, indnseq, indn001, indn002,",
                     "       indn003,   indn004, indn005, indn006,",
                     "       indn007,   indn008, indn009, indn012,",
                     "       indn013,   indn021, rtdx003, imaa104",
                     "  FROM imaa_t,indn_t",
                     "  LEFT OUTER JOIN rtdx_t ON rtdxent = indnent",
                     "                        AND rtdxsite = indnsite",
                     "                        AND rtdx001 = indn001",
                     " WHERE indnent = imaaent",
                     "   AND indn001 = imaa001",
                     "   AND indnent = ",g_enterprise,
                     "   AND indndocno = '",g_indc_m.indc003,"'",
                     "   AND indn013 > 0",
                     "   AND indn018 IN ('2','3')",
                     "   AND indn019 = '",g_indc_m.indc006,"'",
                     " ORDER BY indnseq"
         PREPARE aint510_gen_detail_from_aint530_pre FROM l_sql
         DECLARE aint510_gen_detail_from_aint530_cs CURSOR FOR aint510_gen_detail_from_aint530_pre
         
         FOREACH aint510_gen_detail_from_aint530_cs
            INTO l_indn.indndocno, l_indn.indnseq, l_indn.indn001, l_indn.indn002,
                 l_indn.indn003,   l_indn.indn004, l_indn.indn005, l_indn.indn006,
                 l_indn.indn007,   l_indn.indn008, l_indn.indn009, l_indn.indn012,
                 l_indn.indn013,   l_indn.indn021, l_indn.rtdx003, l_indn.imaa104
            
            LET l_indd.inddent = g_enterprise            #企業編號
            LET l_indd.inddsite = g_indc_m.indcsite      #營運據點
            LET l_indd.inddunit = g_indc_m.indcunit      #應用組織
            LET l_indd.indddocno = g_indc_m.indcdocno    #調撥單號
            
            #項次
            EXECUTE aint510_gen_deatil_inddseq INTO l_indd.inddseq
            
            LET l_indd.indd001 = l_indn.indnseq          #來源項次
            LET l_indd.indd002 = l_indn.indn001          #商品編號
            LET l_indd.indd003 = l_indn.indn002          #商品條碼
            LET l_indd.indd004 = l_indn.indn003          #產品特徵
            LET l_indd.indd005 = l_indn.rtdx003          #經營方式
            LET l_indd.indd006 = l_indn.imaa104          #庫存單位
            LET l_indd.indd007 = l_indn.indn008          #包裝單位
            LET l_indd.indd008 = l_indn.indn009          #件裝數
            #預調撥量
            #退貨單位轉庫存單位
            CALL s_aooi250_convert_qty(l_indd.indd002,l_indd.indd006,l_indn.indn007,l_indn.indn013)
               RETURNING l_success,l_indd.indd009
            LET l_indd.indd010 = 'N'                     #多庫儲批否
            LET l_indd.indd020 = l_indd.indd009          #撥出件數
            LET l_indd.indd021 = l_indd.indd009          #撥出數量
            LET l_indd.indd022 = l_indn.indn004          #撥出庫位
            LET l_indd.indd023 = l_indn.indn005          #撥出儲位
            LET l_indd.indd024 = ' '                     #撥出批號
            LET l_indd.indd030 = ''                      #撥入件數
            LET l_indd.indd031 = ''                      #撥入數量
            LET l_indd.indd032 = ''                      #撥入庫位
            LET l_indd.indd033 = ''                      #撥入儲位
            LET l_indd.indd034 = ' '                     #撥入批號
            LET l_indd.indd040 = 'N'                     #結案否
            
            #預估單價
            EXECUTE aint510_detail_init_sel_rtdx052
              USING l_indd.indd002
               INTO l_indd.indd045
            IF cl_null(l_indd.indd045) THEN
               LET l_indd.indd045 = 0
            END IF
            
            #預估金額
            LET l_indd.indd046 = l_indd.indd045 * l_indd.indd021
            
            LET l_indd.indd101 = l_indn.indndocno        #來源單號
            LET l_indd.indd102 = ' '                     #庫存管理特徵
            
            
            #撥出組織庫存數量
            LET l_indd.indd025 = s_aint510_get_inag009(g_indc_m.indc005, l_indd.indd002, l_indd.indd004, l_indd.indd102,
                                                       l_indd.indd022,   l_indd.indd023, l_indd.indd024, l_indd.indd006)
            #撥入組織庫存數量
            LET l_indd.indd035 = s_aint510_get_inag009(g_indc_m.indc006, l_indd.indd002, l_indd.indd004, l_indd.indd102,
                                                       l_indd.indd032,   l_indd.indd033, l_indd.indd034, l_indd.indd006)
               
            INSERT INTO indd_t(inddent, inddsite, inddunit, indddocno,
                               inddseq, indd001,  indd002,  indd003,
                               indd004, indd005,  indd006,  indd007,
                               indd008, indd009,  indd020,  indd021,
                               indd022, indd023,  indd024,  indd025,
                               indd030, indd031,  indd032,  indd033,
                               indd034, indd035,  indd040,  indd101,
                               indd010, indd045,  indd046)
               VALUES(l_indd.inddent, l_indd.inddsite, l_indd.inddunit, l_indd.indddocno,
                      l_indd.inddseq, l_indd.indd001,  l_indd.indd002,  l_indd.indd003,
                      l_indd.indd004, l_indd.indd005,  l_indd.indd006,  l_indd.indd007,
                      l_indd.indd008, l_indd.indd009,  l_indd.indd020,  l_indd.indd021,
                      l_indd.indd022, l_indd.indd023,  l_indd.indd024,  l_indd.indd025,
                      l_indd.indd030, l_indd.indd031,  l_indd.indd032,  l_indd.indd033,
                      l_indd.indd034, l_indd.indd035,  l_indd.indd040,  l_indd.indd101,
                      l_indd.indd010, l_indd.indd045,  l_indd.indd046)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Ins indd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
            
            IF NOT s_aint510_gen_indl(l_indd.inddsite, l_indd.inddunit, g_indc_m.indcdocno, l_indd.inddseq,
                                      l_indd.indd003,  l_indd.indd002,  l_indd.indd004,     l_indd.indd007,
                                      l_indd.indd006,  l_indd.indd020,  l_indd.indd021,     l_indd.indd022,
                                      l_indd.indd023,  l_indd.indd024,  l_indd.indd030,     l_indd.indd031,
                                      l_indd.indd032,  l_indd.indd033,  l_indd.indd034,     l_indd.indd102,
                                      l_indd.indd010,  l_indd.indd045,  l_indd.indd046) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
         END FOREACH
      END IF
      #151225-00011#1 151230 By pomelo add(E)
      CALL aint510_b_fill()
   END IF
   
   RETURN r_success
   #150127-00004#13 15/03/17 By pomelo add(E)
   
END FUNCTION
#+
PRIVATE FUNCTION aint510_indc003_chk()
DEFINE l_inda003    LIKE inda_t.inda003      #撥出組織
DEFINE l_indastus   LIKE inda_t.indastus     #狀態碼
DEFINE l_cnt        LIKE type_t.num5
#150127-00004#13 15/03/17 By pomelo add(S)
DEFINE l_indc       RECORD
       indcstus     LIKE indc_t.indcstus,    #狀態碼
       indc000      LIKE indc_t.indc000,     #單據性質
       indc006      LIKE indc_t.indc006,     #撥入組織
       indc199      LIKE indc_t.indc199      #調撥性質
                    END RECORD
#150127-00004#13 15/03/17 By pomelo add(E)
#151225-00011#1 151230 By pomelo add(S)
DEFINE l_indm       RECORD
       indmsite     LIKE indm_t.indmsite,    #營運組織
       indmstus     LIKE indm_t.indmstus     #狀態碼
                    END RECORD
#151225-00011#1 151230 By pomelo add(E)

   INITIALIZE g_errno TO NULL
   #來源類型 = 2.調撥申請
   IF g_indc_m.indc002 = '2' THEN               #150127-00004#13 15/03/17 By pomelo add
      SELECT inda003,indastus INTO l_inda003,l_indastus
        FROM inda_t
       WHERE indaent = g_enterprise AND indadocno = g_indc_m.indc003
      CASE
         WHEN SQLCA.sqlcode = 100 LET g_errno = 'ain-00151' #该调拨申请单不存在 -- 请至调拨申请单维护作业[aint500]查询后重新输入
         WHEN l_indastus = 'N'    LET g_errno = 'ain-00152' #该调拨申请单未确认 -- 请至调拨申请单维护作业[aint500]查询后重新输入
         WHEN l_indastus = 'X'    LET g_errno = 'ain-00153' #该调拨申请单已作废 -- 请至调拨申请单维护作业[aint500]查询后重新输入
         WHEN l_indastus = 'C'    LET g_errno = 'ain-00154' #该调拨申请单已结案 -- 请至调拨申请单维护作业[aint500]查询后重新输入
         WHEN l_indastus = 'Y'    LET g_errno = 'ain-00212' #该调拨申请单未核准 -- 请至调拨申请单维护作业[aint500]查询后重新输入
         WHEN l_inda003 <> g_indc_m.indcsite LET g_errno = 'ain-00155' #此調撥申請單的撥出組織非當前所屬組織,不可執行調撥
      END CASE
      
      IF cl_null(g_errno) THEN
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt
           FROM indc_t 
          WHERE indcent = g_enterprise AND indc002 = '2' AND indc003 = g_indc_m.indc003 AND indcstus <> 'X'
         IF l_cnt > 0 THEN
            LET g_errno = 'ain-00156' #此申請單已執行過調撥,不可重複執行調撥
         END IF
      END IF
   #150127-00004#13 15/03/17 By pomelo add(S)
   ELSE
      #151225-00011#1 151230 By pomelo add(S)
      IF g_indc_m.indc002 = '6' THEN
         INITIALIZE l_indm.* TO NULL
         SELECT indmsite, indmstus
           INTO l_indm.indmsite, l_indm.indmstus
           FROM indm_t
          WHERE indment = g_enterprise
            AND indmdocno = g_indc_m.indc003
         
         CASE
            WHEN SQLCA.sqlcode = 100
               #此退貨申請單號不存在！
               LET g_errno = 'ain-00708'
               RETURN
            WHEN l_indm.indmsite != g_indc_m.indcsite
               #此退貨申請單號狀態碼!=T.上層組織核准！
               LET g_errno = 'ain-00710'
               RETURN
            WHEN l_indm.indmstus != 'T'
               #此退貨申請單號的營運組織，並非當前所屬組織！
               LET g_errno = 'ain-00709'
               RETURN
         END CASE
         
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt
           FROM indn_t
          WHERE indnent = g_enterprise
            AND indndocno = g_indc_m.indc003
            AND indn018 IN ('2','3')
            AND indn013 > 0
         IF l_cnt = 0 THEN
            #此退貨申請單沒有任何一筆採購類型 = 2.統採配送 或 3.統採越庫 且 核准數量大於0！
            LET g_errno = 'ain-00711'
            RETURN
         END IF
      ELSE
      #151225-00011#1 151230 By pomelo add(E)
         INITIALIZE l_indc.* TO NULL
         SELECT indcstus,indc000,indc006,indc199
           INTO l_indc.indcstus,l_indc.indc000,l_indc.indc006,l_indc.indc199
           FROM indc_t
          WHERE indcent = g_enterprise
            AND indcdocno = g_indc_m.indc003
         
         CASE
            WHEN SQLCA.sqlcode = 100
               #輸入的調撥撥不存在！
               #請查詢[aint510調撥單維護作業]後，重新輸入！
               LET g_errno = 'ain-00518'
            WHEN l_indc.indcstus = 'N'
               #輸入的調撥單狀態=N.未確認！
               #請查詢[aint510調撥單維護作業]後，重新輸入！
               LET g_errno = 'ain-00519'
            WHEN l_indc.indcstus = 'X'
               #輸入的調撥單狀態=X.作廢！
               #請查詢[aint510調撥單維護作業]後，重新輸入！
               LET g_errno = 'ain-00520'
            WHEN l_indc.indcstus = 'O'
               #輸入的調撥單狀態=O.撥出確認！
               #請查詢[aint510調撥單維護作業]後，重新輸入！
               LET g_errno = 'ain-00521'
            WHEN l_indc.indc006 <> g_indc_m.indcsite
               #此調撥單號的撥入組織，並非當前所屬組織！
               #請查詢[aint510調撥單維護作業]後，重新輸入！
               LET g_errno = 'ain-00522'
            #151225-00011#1 151230 By pomelo mark(S)
            #WHEN l_indc.indc000 != '3'
            #   #此調撥單號的單據性質<>3.調撥撥入單！
            #   #請查詢[aint510調撥單維護作業]後，重新輸入！
            #   LET g_errno = 'ain-00523'
            #151225-00011#1 151230 By pomelo mark(E)
            #151225-00011#1 151230 By pomelo add(S)
            WHEN l_indc.indc000 = '2'
               #此調撥單號的單據性質不為[1.一階段調撥單或3.調撥撥入單]！
               LET g_errno = 'ain-00523'
            #151225-00011#1 151230 By pomelo add(E)
            WHEN l_indc.indc199 = '3'
               #此調撥單的調撥性質 = 3.倉退
               #請查詢[aint510調撥單維護作業]後，重新輸入！
               LET g_errno = 'ain-00524'
            #151225-00011#1 151230 By pomelo add(S)
            WHEN g_indc_m.indc002 = '7' AND l_indc.indc199 != '2'
               #來源類別 = 7.配送調撥單，輸入的來源單號調撥性質 != 2.配送！
               LET g_errno = 'ain-00716'
            WHEN g_indc_m.indc002 = '8' AND l_indc.indc199 != '1'
               #來源類別 = 8.調撥單，輸入來源單號調撥性質 != 1.調撥！
               LET g_errno = 'ain-00717'
            #151225-00011#1 151230 By pomelo add(E)
         END CASE
      END IF      #151225-00011#1 151230 By pomelo add
      
      IF cl_null(g_errno) THEN
         LET l_cnt = 0
         SELECT COUNT(indcdocno) INTO l_cnt
           FROM indc_t 
          WHERE indcent = g_enterprise
            #AND indc002 = '6'        #151225-00011#1 151230 By pomelo mark
            AND indc003 = g_indc_m.indc003
            AND indc199 = '3'
            AND indcstus <> 'X'
            AND indcstus <> 'C'
         IF l_cnt >= 1 THEN
            #此調撥單號已經存在一張非作廢且非結案的調撥倉退單中！
            #請查詢[aint510調撥單維護作業]後，重新輸入！
            LET g_errno = 'ain-00525'
         END IF
      END IF
   END IF
   #150127-00004#13 15/03/17 By pomelo add(E)
END FUNCTION
#+
PRIVATE FUNCTION aint510_conf_input(p_type)
DEFINE p_type       LIKE type_t.chr1   #确认类型 o.拨出确认 i.拨入确认
DEFINE r_success    LIKE type_t.num5
DEFINE l_para_data  LIKE type_t.chr80  #接參數用

   LET r_success = TRUE

   CASE p_type
      WHEN 'o'
         CALL cl_set_comp_entry("indc022",TRUE)
         CALL cl_set_comp_required("indc022",TRUE)
         INPUT BY NAME g_indc_m.indc022 ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT
               IF cl_null(g_indc_m.indc022) THEN
                  LET g_indc_m.indc022 = g_today
               END IF
               DISPLAY BY NAME g_indc_m.indc022
         
            AFTER FIELD indc022
               IF NOT cl_null(g_indc_m.indc022) THEN
                  IF g_indc_m.indc022 < g_indc_m.indcdocdt THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00324'   #
                     LET g_errparam.extend = g_indc_m.indc022
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_indc_m.indc022 = g_indc_m_t.indc022
                     NEXT FIELD CURRENT     
                  END IF
                 #151130-00019#1 20151203  add by beckxie---S
                 IF g_indc_m.indc022 > g_today THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'apm-01045'   #撥出日期不可大於系統日期！
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_indc_m.indc022 = g_indc_m_t.indc022
                    DISPLAY g_indc_m.indc022 TO indc022
                    NEXT FIELD CURRENT    
                 END IF
                 #151130-00019#1 20151203  add by beckxie---E
                 #CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_para_data
                 #IF g_indc_m.indc022 <= l_para_data THEN
                 #   INITIALIZE g_errparam TO NULL
                 #   LET g_errparam.code = 'ain-00325'   #
                 #   LET g_errparam.extend = g_indc_m.indc022
                 #   LET g_errparam.popup = TRUE
                 #   CALL cl_err()
                 #   LET g_indc_m.indc022 = g_indc_m_t.indc022
                 #   NEXT FIELD CURRENT
                 #END IF
                  #151005-00003#1 過帳前檢查參數&上月份盤點流程是否完成 20151021 add by beckxie---S
                  #CALL cl_err_collect_show()
                  IF NOT s_beforeinv_chk(g_indc_m.indc005,g_indc_m.indc022) THEN
                     NEXT FIELD CURRENT
                  END IF
                  #151005-00003#1 過帳前檢查參數&上月份盤點流程是否完成 20151021 add by beckxie---E
                  #关账日期检查 1.库存关账 2.成本关账
                  IF NOT s_date_chk_close(g_indc_m.indc022,'1') THEN
                     LET g_indc_m.indc022 = g_indc_m_t.indc022
                     NEXT FIELD CURRENT
                  END IF
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
      WHEN 'i'
         CALL cl_set_comp_entry("indc024",TRUE)
         CALL cl_set_comp_required("indc024",TRUE)
         INPUT BY NAME g_indc_m.indc024 ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT
               IF cl_null(g_indc_m.indc024) THEN
                  LET g_indc_m.indc024 = g_today
               END IF
               DISPLAY BY NAME g_indc_m.indc024
         
            AFTER FIELD indc024
               IF NOT cl_null(g_indc_m.indc024) THEN
                  IF g_indc_m.indc024 < g_indc_m.indcdocdt THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00326'   #
                     LET g_errparam.extend = g_indc_m.indc024
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_indc_m.indc024 = g_indc_m_t.indc024
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF g_indc_m.indc024 < g_indc_m.indc022 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00327'   #
                     LET g_errparam.extend = g_indc_m.indc024
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_indc_m.indc024 = g_indc_m_t.indc024
                     NEXT FIELD CURRENT
                  END IF
                 #151130-00019#1 20151203  add by beckxie---S
                 IF g_indc_m.indc024 > g_today THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'apm-01046'   #撥入日期不可大於系統日期！
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_indc_m.indc024 = g_indc_m_t.indc024
                    DISPLAY g_indc_m.indc024 TO indc024
                    NEXT FIELD CURRENT
                 END IF
                 #151130-00019#1 20151203  add by beckxie---E
                 #CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_para_data
                 #IF g_indc_m.indc024 <= l_para_data THEN
                 #   INITIALIZE g_errparam TO NULL
                 #   LET g_errparam.code = 'ain-00328'   #
                 #   LET g_errparam.extend = g_indc_m.indc024
                 #   LET g_errparam.popup = TRUE
                 #   CALL cl_err()
                 #   LET g_indc_m.indc024 = g_indc_m_t.indc024
                 #   NEXT FIELD CURRENT
                 #END IF
                  #151005-00003#1 過帳前檢查參數&上月份盤點流程是否完成 20151021 add by beckxie---S
                  IF NOT s_beforeinv_chk(g_indc_m.indc006,g_indc_m.indc024) THEN
                     NEXT FIELD CURRENT
                  END IF
                  #151005-00003#1 過帳前檢查參數&上月份盤點流程是否完成 20151021 add by beckxie---E
                  #关账日期检查 1.库存关账 2.成本关账
                  IF NOT s_date_chk_close(g_indc_m.indc024,'1') THEN
                     LET g_indc_m.indc024 = g_indc_m_t.indc024
                     NEXT FIELD CURRENT
                  END IF
                  
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
   END CASE

   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      CALL cl_set_comp_entry("indc022,indc024",FALSE)
      CALL cl_set_comp_required("indc022,indc024",FALSE)
      LET r_success = FALSE
      RETURN r_success
   END IF

   CASE p_type
      WHEN 'o'
         UPDATE indc_t
            SET indc022 = g_indc_m.indc022
          WHERE indcent = g_enterprise AND indcdocno = g_indc_m.indcdocno
      WHEN 'i'
         UPDATE indc_t
            SET indc024 = g_indc_m.indc024
          WHERE indcent = g_enterprise AND indcdocno = g_indc_m.indcdocno
   END CASE

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE indc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL cl_set_comp_entry("indc022,indc024",FALSE)
      CALL cl_set_comp_required("indc022,indc024",FALSE)
      LET r_success = FALSE
      RETURN r_success
   END IF
  
   CALL cl_set_comp_entry("indc022,indc024",FALSE)
   CALL cl_set_comp_required("indc022,indc024",FALSE)
   RETURN r_success  
END FUNCTION

################################################################################
# Descriptions...: 撥出數量的轉換
# Memo...........:
# Usage..........: CALL aint510_outnum_change(p_type)
# Input parameter: p_type         1.庫存轉包裝單位
#                :                2.包裝轉庫存單位
# Return code....: 無
# Date & Author..: 2015/03/17 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_outnum_change(p_type)
DEFINE p_type       LIKE type_t.chr1
DEFINE l_success    LIKE type_t.num5

   IF p_type = '1' THEN
      IF NOT cl_null(g_indd_d[l_ac].indd021) THEN
         #庫存轉包裝單位
         CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd021)
            RETURNING l_success,g_indd_d[l_ac].indd020
      END IF
   ELSE
      IF NOT cl_null(g_indd_d[l_ac].indd020) THEN
         #包裝轉庫存單位
         CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd020)
            RETURNING l_success,g_indd_d[l_ac].indd021
      END IF
   END IF
   
   #151204-00007#5 151215 By pomelo add(S)
   LET g_indd_d[l_ac].indd046 = g_indd_d[l_ac].indd045 * g_indd_d[l_ac].indd021
   #151204-00007#5 151215 By pomelo add(E)
END FUNCTION
################################################################################
# Descriptions...: 撥出數量的轉換
# Memo...........:
# Usage..........: CALL aint510_innum_change(p_type)
# Input parameter: p_type         1.庫存轉包裝單位
#                :                2.包裝轉庫存單位
# Return code....: 無
# Date & Author..: 2015/03/17 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_innum_change(p_type)
DEFINE p_type       LIKE type_t.chr1
DEFINE l_success    LIKE type_t.num5

   IF p_type = '1' THEN
      IF NOT cl_null(g_indd_d[l_ac].indd031) THEN
         #庫存轉包裝單位
         CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd031)
            RETURNING l_success,g_indd_d[l_ac].indd030
      END IF
   ELSE
      IF NOT cl_null(g_indd_d[l_ac].indd030) THEN
         #包裝轉庫存單位
         CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd007,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd030)
            RETURNING l_success,g_indd_d[l_ac].indd031
      END IF
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 檢查輸入的來源項次是否正確
# Memo...........:
# Usage..........: CALL aint510_chk_indd001
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/03/18 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_chk_indd001()
DEFINE r_success         LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5
#151225-00011#1 151231 By pomelo add(S)
DEFINE l_indn            RECORD
       indn013           LIKE indn_t.indn013,   #核准數量
       indn018           LIKE indn_t.indn018,   #經營方式
       indn019           LIKE indn_t.indn019    #配送中心
                         END RECORD
#151225-00011#1 151231 By pomelo add(E)

   LET r_success = TRUE
   
   IF g_indc_m.indc002 MATCHES '[78]' THEN   #151225-00011#1 151231 By pomelo add
      LET l_cnt = 0
      SELECT COUNT(inddseq) INTO l_cnt
        FROM indd_t
       WHERE inddent = g_enterprise
         AND indddocno = g_indc_m.indc003
         AND inddseq = g_indd_d[l_ac].indd001
      IF l_cnt = 0 THEN
         #輸入的來源項次並不存在來源單號中！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ain-00526"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_cnt = 0
      SELECT COUNT(inddseq) INTO l_cnt
        FROM indc_t,indd_t
       WHERE indcent = inddent
         AND indcdocno = indddocno
         AND indcent = g_enterprise
         AND indc003 = g_indc_m.indc003
         AND indd001 = g_indd_d[l_ac].indd001
         AND indc199 = '3'
         AND indcstus != 'X'
         AND indcstus != 'C'
      IF l_cnt >= 1 THEN
         #輸入的來源項次已經存在非作廢且非結案的倉退單！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ain-00527"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_cnt = 0
      SELECT COUNT(a.inddseq) INTO l_cnt
        FROM indc_t,indd_t a
        LEFT OUTER JOIN (SELECT inddent, indd101, indd001, COALESCE(SUM(indd021),0) sumindd021
                           FROM indc_t, indd_t
                          WHERE indcent = inddent
                            AND indcdocno = indddocno
                            AND indcent = g_enterprise
                            AND indc199 = '3'
                            AND indcstus != 'X'
                            AND NOT(indddocno = COALESCE(g_indc_m.indcdocno,'-1')
                            AND     inddseq = COALESCE(g_indd_d[l_ac].inddseq,-1))
                          GROUP BY  inddent, indd101, indd001) d
             ON d.inddent = a.inddent
            AND d.indd101 = a.indd101
            AND d.indd001 = a.indd001
       WHERE indcent = a.inddent
         AND indcdocno = a.indddocno
         AND indcent = g_enterprise
         AND indcdocno = g_indc_m.indc003
         AND a.inddseq = g_indd_d[l_ac].indd001
         AND 0 < indd031 - COALESCE(d.sumindd021,0)
      IF l_cnt = 0 THEN
         #輸入的來源項次沒有倉退的數量！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ain-00528"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   #151225-00011#1 151231 By pomelo add(S)
   ELSE
      INITIALIZE l_indn.* TO NULL
      SELECT indn013, indn018, indn019
        INTO l_indn.indn013, l_indn.indn018, l_indn.indn019
        FROM indn_t
       WHERE indnent = g_enterprise
         AND indndocno = g_indc_m.indc003
         AND indnseq = g_indd_d[l_ac].indd001
      CASE
         WHEN SQLCA.sqlcode = 100
            #輸入的來源項次%1並不存在來源單號%2中！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "ain-00712"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_indd_d[l_ac].indd001
            LET g_errparam.replace[2] = g_indc_m.indc003
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
            
         WHEN l_indn.indn018 = '0' OR l_indn.indn018 = '1'
            #輸入的來源項次%1，採購類型 = 0.自訂貨 或 1.統採直送！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "ain-00713"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_indd_d[l_ac].indd001
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
            
         WHEN l_indn.indn013 <= 0
            #輸入的來源項次%1， 核准數量小於等於0！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "ain-00714"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_indd_d[l_ac].indd001
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
            
         WHEN l_indn.indn019 != g_indc_m.indc006
            #輸入的來源項次%1，配送中心%2與單頭的撥入組織%3不一致！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "ain-00715"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_indd_d[l_ac].indd001
            LET g_errparam.replace[2] = l_indn.indn019
            LET g_errparam.replace[3] = g_indc_m.indc006
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
      END CASE
      
   END IF
   #151225-00011#1 151231 By pomelo add(E)
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 依據輸入的來源項次，帶出相關欄位值
# Memo...........:
# Usage..........: CALL aint510_indd001_default()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/03/18 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_indd001_default()
   #151225-00011#1 151231 By pomelo add(S)
DEFINE l_success        LIKE type_t.num5
DEFINE l_indn           RECORD
       indn007          LIKE indn_t.indn007,
       indn013          LIKE indn_t.indn013
                        END RECORD
 
   IF g_indc_m.indc002 = '6' THEN
      INITIALIZE l_indn.* TO NULL
      SELECT indndocno, indn001, indn002, indn003,
             indn004,   indn005, indn007, indn008,
             indn009,   indn012, indn013, rtdx003,
             imaa104,   rtdx052
        INTO g_indd_d[l_ac].indd101, g_indd_d[l_ac].indd002, g_indd_d[l_ac].indd003, g_indd_d[l_ac].indd004,
             g_indd_d[l_ac].indd022, g_indd_d[l_ac].indd023, l_indn.indn007,         g_indd_d[l_ac].indd007,  
             g_indd_d[l_ac].indd008, g_indd_d[l_ac].indd020, l_indn.indn013,         g_indd_d[l_ac].indd005,
             g_indd_d[l_ac].indd006, g_indd_d[l_ac].indd045
        FROM imaa_t,indn_t
        LEFT OUTER JOIN rtdx_t ON rtdxent = indnent
                              AND rtdxsite = indnsite
                              AND rtdx001 = indn001
       WHERE indnent = imaaent
         AND indn001 = imaa001
         AND indnent = g_enterprise
         AND indndocno = g_indc_m.indc003
         AND indnseq = g_indd_d[l_ac].indd001
         AND indn013 > 0
         AND indn018 IN ('2','3')
         AND indn019 = g_indc_m.indc006
         
         #預調撥量
         #退貨單位轉庫存單位
         CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,l_indn.indn007,l_indn.indn013)
            RETURNING l_success,g_indd_d[l_ac].indd009
         
         #撥出數量
         LET g_indd_d[l_ac].indd021 = g_indd_d[l_ac].indd009
   ELSE
   #151225-00011#1 151231 By pomelo add(E)
      SELECT indd002, indd003, indd004, rtdx003,
             indd006, indd007, indd008, indd031, indd030,
             indd031, indd032, indd033, indd034, indddocno,
             rtdx052  #151204-00007#5 151215 By pomelo
        INTO g_indd_d[l_ac].indd002, g_indd_d[l_ac].indd003, g_indd_d[l_ac].indd004, g_indd_d[l_ac].indd005,
             g_indd_d[l_ac].indd006, g_indd_d[l_ac].indd007, g_indd_d[l_ac].indd008, g_indd_d[l_ac].indd009, g_indd_d[l_ac].indd020,
             g_indd_d[l_ac].indd021, g_indd_d[l_ac].indd022, g_indd_d[l_ac].indd023, g_indd_d[l_ac].indd024, g_indd_d[l_ac].indd101,
             g_indd_d[l_ac].indd045  #151204-00007#5 151215 By pomelo
        FROM indd_t
        LEFT OUTER JOIN rtdx_t ON rtdxent = inddent
                              AND rtdxsite = g_indc_m.indcsite
                              AND rtdx001 = indd002
       WHERE inddent = g_enterprise
         AND indddocno = g_indc_m.indc003
         AND inddseq = g_indd_d[l_ac].indd001
   #151225-00011#1 151231 By pomelo add(S)
   END IF
   #撥出組織庫存數量
   LET g_indd_d[l_ac].indd025 = s_aint510_get_inag009(g_indc_m.indc005,       g_indd_d[l_ac].indd002, g_indd_d[l_ac].indd004,
                                                      g_indd_d[l_ac].indd102, g_indd_d[l_ac].indd022, g_indd_d[l_ac].indd023,
                                                      g_indd_d[l_ac].indd024, g_indd_d[l_ac].indd006)
   #撥入組織庫存數量
   LET g_indd_d[l_ac].indd035 = s_aint510_get_inag009(g_indc_m.indc006,       g_indd_d[l_ac].indd002, g_indd_d[l_ac].indd004,
                                                      g_indd_d[l_ac].indd102, g_indd_d[l_ac].indd032, g_indd_d[l_ac].indd033,
                                                      g_indd_d[l_ac].indd034, g_indd_d[l_ac].indd006)
   #151225-00011#1 151231 By pomelo add(E)
   
   CALL aint510_indd002_ref()
   CALL aint510_indd006_ref()
   CALL aint510_indd007_ref()
   CALL aint510_indd022_ref()
   CALL aint510_indd023_ref()
   
   #151204-00007#5 151215 By pomelo add(S)
   IF cl_null(g_indd_d[l_ac].indd045) THEN
      LET g_indd_d[l_ac].indd045 = 0
   END IF
   LET g_indd_d[l_ac].indd046 = g_indd_d[l_ac].indd045 * g_indd_d[l_ac].indd021
   DISPLAY BY NAME g_indd_d[l_ac].indd045,g_indd_d[l_ac].indd046
   #151204-00007#5 151215 By pomelo add(S)
END FUNCTION

################################################################################
# Descriptions...: 檢查撥出數量是否正確
# Memo...........:
# Usage..........: CALL aint510_chk_indd020()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/03/18 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_chk_indd020()
DEFINE r_success        LIKE type_t.num5
DEFINE l_indd031        LIKE indd_t.indd031    #原調撥單撥入數量
DEFINE l_sum_indd021    LIKE indd_t.indd021    #已經轉倉退單的撥出數量加總
DEFINE l_num            LIKE indd_t.indd021    #可打的數量
DEFINE l_sql            STRING

   LET r_success = TRUE
   
   LET l_indd031 = ''
   #抓取原單據的撥入數量
   SELECT indd031 INTO l_indd031
     FROM indd_t
    WHERE inddent = g_enterprise
      AND indddocno = g_indc_m.indc003
      AND inddseq = g_indd_d[l_ac].indd001

   #已經轉倉退單的撥出數量加總
   LET l_sum_indd021 = 0
   LET l_sql = "SELECT COALESCE(SUM(indd021),0)",
               "  FROM indc_t,indd_t",
               " WHERE indcent = inddent",
               "   AND indcdocno = indddocno",
               "   AND indcent = ",g_enterprise,
               "   AND indc003 = '",g_indc_m.indc003,"'",
               "   AND indd001 = ",g_indd_d[l_ac].indd001,
               "   AND NOT (indcdocno = COALESCE('",g_indc_m.indcdocno,"','-1')",
               "   AND      inddseq = COALESCE(",g_indd_d[l_ac].inddseq,",-1))",
               "   AND indcstus != 'X'",
               "   AND indcsite = '",g_indc_m.indcsite,"'"
   PREPARE aint510_chk_sumindd021 FROM l_sql
   EXECUTE aint510_chk_sumindd021 INTO l_sum_indd021
   
   LET l_num = l_indd031 - l_sum_indd021
   
   IF l_num < g_indd_d[l_ac].indd021 THEN
      #輸入的數量大於(來源單據+來源項次的撥入數量-加總非作廢倉退的撥出數量)！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ain-00529"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 判斷商品有無須進行批號的輸入管控
# Memo...........:
# Usage..........: CALL aint510_imaf061_chk()
#                  RETURNING r_success
# Return code....: r_success 
# Date & Author..: 2015/04/13 By Lori   #150324-00006#15
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_imaf061_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_imaf061   LIKE imaf_t.imaf061
   DEFINE l_imaf062   LIKE imaf_t.imaf062   #150619-00012#1 15/06/22 by sakura
   DEFINE l_imaf063   LIKE imaf_t.imaf063   #150619-00012#1 15/06/22 by sakura 
   DEFINE l_imaf064   LIKE imaf_t.imaf064   #150619-00012#1 15/06/22 by sakura
   DEFINE l_imaf114   LIKE imaf_t.imaf114   
   DEFINE l_imaf115   LIKE imaf_t.imaf115
   DEFINE l_imaf116   LIKE imaf_t.imaf116
   DEFINE l_imaf122   LIKE imaf_t.imaf122
   
   LET r_success = TRUE
   LET l_imaf061 = ''
   
   IF l_ac > 0 THEN
      #150619-00012#1 15/06/22 by sakura-(s)
      #LET l_imaf061 = s_artt300_get_imbf061(g_indd_d[l_ac].indd002)
      CALL s_artt300_get_imbf061(g_indc_m.indcdocno,g_indd_d[l_ac].indd002)
           RETURNING l_imaf061,l_imaf062,l_imaf063,l_imaf064,
                     l_imaf114,l_imaf115,l_imaf116,l_imaf122
           
      #150619-00012#1 15/06/22 by sakura-(e)
      IF l_imaf061 = '2' THEN   #[T:料件據點進銷存檔].[C:批號控管]=1或3時才可輸入         
         LET r_success = FALSE
      END IF
          
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 撥入/撥出 庫位、儲位、批號
# Memo...........:
# Usage..........: CALL aint510_in_out_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/05/20 By pomelo 150519-00025#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_in_out_chk()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   IF g_indc_m.indc005 = g_indc_m.indc006 THEN
      #撥出儲位
      IF cl_null(g_indd_d[l_ac].indd023) THEN
         LET g_indd_d[l_ac].indd023 = ' '
      END IF
      #撥出批號
      IF cl_null(g_indd_d[l_ac].indd024) THEN
         LET g_indd_d[l_ac].indd024 = ' '
      END IF
      #撥入儲位
      IF cl_null(g_indd_d[l_ac].indd033) THEN
         LET g_indd_d[l_ac].indd033 = ' '
      END IF
      #撥出批號
      IF cl_null(g_indd_d[l_ac].indd034) THEN
         LET g_indd_d[l_ac].indd034 = ' '
      END IF
      IF g_indd_d[l_ac].indd022 = g_indd_d[l_ac].indd032 AND
         g_indd_d[l_ac].indd023 = g_indd_d[l_ac].indd033 AND 
         g_indd_d[l_ac].indd024 = g_indd_d[l_ac].indd034 THEN
         #撥出組織且撥入組織相同時，撥出庫位、撥出儲位、撥出批號 不可以 等於撥入庫位、撥入儲位、撥入批號！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00552'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 控管店內調撥時生鮮商品不可調撥到非生鮮庫區
# Memo...........:
# Usage..........: CALL aint510_chk_indd002_indd032()
# Date & Author..: 20150623 By dongsz
# Modify.........: 151228 151204-00007#10 By pomelo add p_indd002
################################################################################
PRIVATE FUNCTION aint510_chk_indd002_indd032(p_indd002)
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_sql      STRING
#151204-00007#10 151228 By pomelo add(S)
DEFINE p_indd002  LIKE indd_t.indd002
DEFINE l_inaa106  LIKE inaa_t.inaa106
DEFINE l_sys      LIKE type_t.num5
#151204-00007#10 151228 By pomelo add(E)

   IF g_indc_m.indc005 = g_indc_m.indc006 THEN
      LET l_cnt = 0
      LET l_sql = " SELECT COUNT(1) FROM imaa_t ",
                  "  WHERE imaaent = ",g_enterprise," ",
                  #"    AND imaa001 = '",g_indd_d[l_ac].indd002,"' ", #151204-00007#10 151228 By pomelo mark
                  "    AND imaa001 = '",p_indd002,"' ", #151204-00007#10 151228 By pomelo add
                  "    AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t ",
                  "                    START WITH rtax003 IN (SELECT prbs001 FROM prbs_t WHERE prbsent = ",g_enterprise," AND prbsstus = 'Y') ",
                  "                    CONNECT BY nocycle PRIOR rtax001 = rtax003 ",
                  "                    UNION SELECT prbs001 FROM prbs_t WHERE prbsent = ",g_enterprise," AND prbsstus = 'Y') "
      PREPARE sel_cnt_pre1 FROM l_sql
      EXECUTE sel_cnt_pre1 INTO l_cnt
      IF l_cnt > 0 THEN
         LET l_cnt = 0
         IF NOT cl_null(g_indd_d[l_ac].indd032) THEN   #160506-00006#1 20160512 add by beckxie
            LET l_sql = " SELECT COUNT(1) FROM inaa_t ",
                        "  WHERE inaaent = ",g_enterprise," ",
                        "    AND inaasite = '",g_indc_m.indc005,"' ",
                        "    AND inaa001 = '",g_indd_d[l_ac].indd032,"' ",
                        "    AND inaa106 IN (SELECT DISTINCT rtax001 FROM rtax_t ",
                        "                    START WITH rtax003 IN (SELECT prbs001 FROM prbs_t WHERE prbsent = ",g_enterprise," AND prbsstus = 'Y') ",
                        "                    CONNECT BY nocycle PRIOR rtax001 = rtax003 ",
                        "                    UNION SELECT prbs001 FROM prbs_t WHERE prbsent = ",g_enterprise," AND prbsstus = 'Y') "
            PREPARE sel_cnt_pre2 FROM l_sql
            EXECUTE sel_cnt_pre2 INTO l_cnt
            IF l_cnt < 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00571'
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF   #160506-00006#1 20160512 add by beckxie
      END IF
   END IF
   
   #151204-00007#10 151228 By pomelo add(S)
   IF g_indc_m.indc202 = '3' AND NOT cl_null(p_indd002) AND
      NOT cl_null(g_indd_d[l_ac].indd032) THEN
      
      LET l_inaa106 = ''
      SELECT inaa106 INTO l_inaa106
        FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaasite = g_indc_m.indc006
         AND inaa001 = g_indd_d[l_ac].indd032
      
      LET l_sys = cl_get_para(g_enterprise,'','E-CIR-0001')
      LET l_sql = " SELECT COUNT(1)",
                  "  FROM imaa_t ",
                  " WHERE imaaent = ",g_enterprise,
                  "   AND imaa001 = '",p_indd002,"'",
                  "   AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t",
                  "                    WHERE rtaxent = ",g_enterprise,
                  "                      AND rtax004 >='",l_sys,"'",
                  "                      AND rtaxstus = 'Y'",
                  "                    START WITH rtax001 = '",l_inaa106,"' ",
                  "                    CONNECT BY NOCYCLE PRIOR rtax001 = rtax003)"
      PREPARE aint510_chk_indd002_indd032 FROM l_sql
      EXECUTE aint510_chk_indd002_indd032 INTO l_cnt
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00705'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   #151204-00007#10 151228 By pomelo add(E)
   
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 倉庫成本倉否檢查
# Memo...........:
# Usage..........: CALL aint510_depot_cost_chk(p_chk,p_type,p_out_depot,p_in_depot,p_indc007)
#                  RETURNING r_success
# Input parameter: p_chk          1.預設 2.校驗 3.開窗
#                : p_type         1.撥出倉庫 2.撥入倉庫 3.在途倉
#                : p_out_depot    撥出倉庫
#                : p_in_depot     撥入倉庫
#                : p_indc007      在途倉
# Return code....: r_success      True/False
#                : r_where        條件
# Date & Author..: 2015/10/20 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_depot_cost_chk(p_chk,p_type,p_out_depot,p_in_depot,p_indc007)
DEFINE p_chk             LIKE type_t.chr1
DEFINE p_type            LIKE type_t.chr1
DEFINE p_out_depot       LIKE indc_t.indc200
DEFINE p_in_depot        LIKE indc_t.indc201
DEFINE p_indc007         LIKE indc_t.indc007
DEFINE r_success         LIKE type_t.num5
DEFINE r_where           STRING
DEFINE l_sql             STRING
DEFINE l_out_inaa010     LIKE inaa_t.inaa010
DEFINE l_in_inaa010      LIKE inaa_t.inaa010
DEFINE l_inaa010         LIKE inaa_t.inaa010
DEFINE l_sys3            LIKE type_t.chr80       #在途倉歸屬1.撥出 2.撥入

   LET r_success = TRUE
   LET r_where = " 1=1"
   LET l_sql = "SELECT COALESCE(inaa010,'1')",
               "  FROM inaa_t",
               " WHERE inaaent = ",g_enterprise,
               "   AND inaasite = ?",
               "   AND inaa001 = ?"
   PREPARE aint510_depot_cost_chk FROM l_sql
   
   CALL cl_get_para(g_enterprise,g_site,'E-BAS-0015') RETURNING l_sys3
   
   LET l_inaa010 = ''
   LET l_out_inaa010 = ''
   LET l_in_inaa010 = ''
   CASE p_type
      WHEN '1'    #撥出倉庫
         IF cl_null(p_in_depot) AND cl_null(p_indc007) THEN
            RETURN r_success,r_where
         END IF
         
         IF p_chk MATCHES '[12]' THEN
            EXECUTE aint510_depot_cost_chk USING g_indc_m.indc005,p_out_depot
               INTO l_out_inaa010
         END IF
         
         CASE
            WHEN NOT cl_null(p_in_depot)    #撥入倉庫
               EXECUTE aint510_depot_cost_chk USING g_indc_m.indc006,p_in_depot
                  INTO l_in_inaa010
                  
               #類型 = 3.開窗時，回傳條件
               IF p_chk = '3' THEN
                  LET r_where = " inaa010 = '",l_in_inaa010,"'"
                  RETURN r_success,r_where
               END IF
               
               IF l_out_inaa010 != l_in_inaa010 THEN
                  IF p_chk = '2' THEN
                     #撥出倉庫%1與撥出倉庫%2的成本性質不一致！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00662'
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = p_out_depot
                     LET g_errparam.replace[2] = p_in_depot
                     CALL cl_err()
                  END IF
                  LET r_success = FALSE
                  RETURN r_success,r_where
               END IF
               
            WHEN NOT cl_null(p_indc007)     #在途倉
               IF l_sys3 = '1' THEN
                  EXECUTE aint510_depot_cost_chk USING g_indc_m.indc005,p_indc007
                     INTO l_inaa010
               ELSE
                  EXECUTE aint510_depot_cost_chk USING g_indc_m.indc006,p_indc007
                     INTO l_inaa010
               END IF
                  
               #類型 = 3.開窗時，回傳條件
               IF p_chk = '3' THEN
                  LET r_where = " inaa010 = '",l_inaa010,"'"
                  RETURN r_success,r_where
               END IF
                  
               IF l_out_inaa010 != l_inaa010 THEN
                  IF p_chk = '2' THEN
                     #撥出倉庫%1與在途倉%2的成本性質不一致！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00662'
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = p_out_depot
                     LET g_errparam.replace[2] = p_indc007
                     CALL cl_err()
                  END IF
                  LET r_success = FALSE
                  RETURN r_success,r_where
               END IF
         END CASE
            
      WHEN '2'    #撥入倉庫
         IF cl_null(p_out_depot) AND cl_null(p_indc007) THEN
            RETURN r_success,r_where
         END IF
         
         IF p_chk MATCHES '[12]' THEN
            EXECUTE aint510_depot_cost_chk USING g_indc_m.indc006,p_in_depot
               INTO l_in_inaa010
         END IF
            
         CASE
            WHEN NOT cl_null(p_out_depot)    #撥出倉庫
               EXECUTE aint510_depot_cost_chk USING g_indc_m.indc005,p_out_depot
                  INTO l_out_inaa010
                  
               #類型 = 3.開窗時，回傳條件
               IF p_chk = '3' THEN
                  LET r_where = " inaa010 = '",l_out_inaa010,"'"
                  RETURN r_success,r_where
               END IF
                  
               IF l_out_inaa010 != l_in_inaa010 THEN
                  IF p_chk = '2' THEN
                     #撥出倉庫%1與撥出倉庫%2的成本性質不一致！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00662'
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = p_out_depot
                     LET g_errparam.replace[2] = p_in_depot
                     CALL cl_err()
                  END IF
                  LET r_success = FALSE
                  RETURN r_success,r_where
               END IF
               
            WHEN NOT cl_null(p_indc007)     #在途倉
               IF l_sys3 = '1' THEN
                  EXECUTE aint510_depot_cost_chk USING g_indc_m.indc005,p_indc007
                     INTO l_inaa010
               ELSE
                  EXECUTE aint510_depot_cost_chk USING g_indc_m.indc006,p_indc007
                     INTO l_inaa010
               END IF
                  
               #類型 = 3.開窗時，回傳條件
               IF p_chk = '3' THEN
                  LET r_where = " inaa010 = '",l_inaa010,"'"
                  RETURN r_success,r_where
               END IF
                  
               IF l_in_inaa010 != l_inaa010 THEN
                  IF p_chk = '2' THEN
                     #撥入倉庫%1與在途倉%2的成本性質不一致！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00664'
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = p_in_depot
                     LET g_errparam.replace[2] = p_indc007
                     CALL cl_err()
                  END IF
                  LET r_success = FALSE
                  RETURN r_success,r_where
               END IF
         END CASE
      
      WHEN '3'    #在途倉
         IF cl_null(p_out_depot) AND cl_null(p_in_depot) THEN
            RETURN r_success,r_where
         END IF
         
         IF p_chk MATCHES '[12]' THEN
            IF l_sys3 = '1' THEN
               EXECUTE aint510_depot_cost_chk USING g_indc_m.indc005,p_indc007
                  INTO l_inaa010
            ELSE
               EXECUTE aint510_depot_cost_chk USING g_indc_m.indc006,p_indc007
                  INTO l_inaa010
            END IF
         END IF
         
         CASE
            WHEN NOT cl_null(p_out_depot)    #撥出倉庫
               EXECUTE aint510_depot_cost_chk USING g_indc_m.indc005,p_out_depot
                  INTO l_out_inaa010
               
               #類型 = 3.開窗時，回傳條件
               IF p_chk = '3' THEN
                  LET r_where = " inaa010 = '",l_out_inaa010,"'"
                  RETURN r_success,r_where
               END IF
                  
               IF l_out_inaa010 != l_inaa010 THEN
                  IF p_chk = '2' THEN
                     #撥出倉庫%1與在途倉%2的成本性質不一致！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00663'
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = p_out_depot
                     LET g_errparam.replace[2] = p_indc007
                     CALL cl_err()
                  END IF
                  LET r_success = FALSE
                  RETURN r_success,r_where
               END IF
               
            WHEN NOT cl_null(p_in_depot)     #撥入倉庫
               EXECUTE aint510_depot_cost_chk USING g_indc_m.indc006,p_in_depot
                  INTO l_in_inaa010
                  
               #類型 = 3.開窗時，回傳條件
               IF p_chk = '3' THEN
                  LET r_where = " inaa010 = '",l_inaa010,"'"
                  RETURN r_success,r_where
               END IF
                  
               IF l_in_inaa010 != l_inaa010 THEN
                  IF p_chk = '2' THEN
                     #撥入倉庫%1與在途倉%2的成本性質不一致！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00664'
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = p_in_depot
                     LET g_errparam.replace[2] = p_indc007
                     CALL cl_err()
                  END IF
                  LET r_success = FALSE
                  RETURN r_success,r_where
               END IF
         END CASE
   END CASE
   
   RETURN r_success,r_where
END FUNCTION

################################################################################
# Descriptions...: 倉庫預設
# Memo...........:
# Usage..........: CALL aint510_depot_def(p_type,p_indd022,p_indd032,p_indc007)
#                  RETURNING r_inaa001
# Input parameter: p_type         出/入項 出：-1 入：1
#                : p_indd022      撥出倉庫
#                : p_indd032      撥入倉庫
#                : P_indc007      在途倉
# Return code....: r_inaa001      倉庫
# Date & Author..: 2015/12/28 By pomelo  #151204-00007#10
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_depot_def(p_type,p_indd022,p_indd032,p_indc007)
DEFINE p_type            LIKE type_t.num5        #出/入項
DEFINE p_indd022         LIKE indd_t.indd022     #撥出倉庫
DEFINE p_indd032         LIKE indd_t.indd032     #撥入倉庫
DEFINE p_indc007         LIKE indc_t.indc007     #在途倉
DEFINE r_inaa001         LIKE inaa_t.inaa001     #倉庫
DEFINE l_where           STRING
DEFINE l_success         LIKE type_t.num5
DEFINE l_def             STRING
DEFINE l_type            LIKE type_t.chr1
DEFINE l_sql             STRING
DEFINE l_site            LIKE ooef_t.ooef001

   LET r_inaa001 = ''
   
   LET l_where = aint510_depot_where(p_type)
   
   LET l_site = ''
   CASE p_type
      WHEN '-1' #撥出倉
         LET l_type = '1'
         LET l_site = g_indc_m.indc005
      WHEN '1'  #撥入倉
         LET l_type = '2'
         LET l_site = g_indc_m.indc006
      WHEN '0'  #在途倉
         LET l_type = '3'
   END CASE
   
   LET l_success = ''
   CALL aint510_depot_cost_chk('3',l_type,p_indd022,p_indd032,p_indc007)
      RETURNING l_success,l_def
   LET l_where = l_where, " AND ",l_def
   
   IF cl_null(l_where) THEN
      RETURN r_inaa001
   END IF
   
   LET l_sql = "SELECT inaa001",
               "  FROM inaa_t",
               " WHERE inaaent =",g_enterprise,
               "   AND inaasite = '",l_site,"'",
               "   AND ",l_where,
               " ORDER BY inaa001"
   PREPARE aint510_depot_def_pre FROM l_sql
   DECLARE aint510_depot_def_cs SCROLL CURSOR FOR aint510_depot_def_pre
   OPEN aint510_depot_def_cs
   FETCH FIRST aint510_depot_def_cs INTO r_inaa001
   CLOSE aint510_depot_def_cs
   
   RETURN r_inaa001
END FUNCTION

################################################################################
# Descriptions...: 倉庫條件
# Memo...........:
# Usage..........: CALL aint510_depot_where(p_type)
#                  RETURNING r_inaa001
# Input parameter: p_type         出/入項 出：-1 入：1
# Return code....: r_inaa001      倉庫
# Date & Author..: 2015/12/28 By pomelo  #151204-00007#10
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_depot_where(p_type)
DEFINE p_type            LIKE type_t.num5
DEFINE r_where           STRING

   LET r_where = " 1=1"
   
   CASE g_indc_m.indc202
      WHEN '1'    #倉庫入賣場
         IF p_type = '1' THEN
            LET r_where = "     inaa140 = '1'",
                          " AND inaa106 IS NULL"
         ELSE
            LET r_where = " inaa140 = '2'"
         END IF
         
      WHEN '2'    #賣場入倉庫
         IF p_type = '1' THEN
            LET r_where = " inaa140 = '2'"
         ELSE
            LET r_where = "     inaa140 = '1'",
                          " AND inaa106 IS NULL"
         END IF
         
      WHEN '3'    #生鮮移倉
         IF p_type = '1' THEN
            LET r_where = "     inaa140 = '1'",
                          " AND inaa106 IS NOT NULL"
         ELSE
            LET r_where = " inaa140 IN ('1','2')"
         END IF
         
      WHEN '4'    #贈品移倉
         IF p_type = '1' THEN
            LET r_where = " inaa140 = '4'"
         ELSE
            LET r_where = " inaa140 IN ('1','2')"
         END IF
      
      WHEN '5'    #贈品退回
         IF p_type = '1' THEN
            LET r_where = " inaa140 IN ('1','2')"
         ELSE
            LET r_where = " inaa140 = '4'"
         END IF
         
      WHEN '6'   #倉庫間的調撥
          LET r_where = " inaa140 = '2'"
         
      OTHERWISE
         RETURN r_where
   END CASE
   
   RETURN r_where
   
END FUNCTION

################################################################################
# Descriptions...: 確認倉庫是否正確
# Memo...........:
# Usage..........: CALL aint510_depot_chk(p_type,p_inaa001)
#                  RETURNING r_inaa001
# Input parameter: p_type         出/入項 出：-1 入：1
#                : p_inaa001      倉庫
# Return code....: r_success      True/False
# Date & Author..: 2015/12/28 By pomelo  #151204-00007#10
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_depot_chk(p_type,p_inaa001)
DEFINE p_type            LIKE type_t.num5
DEFINE p_inaa001         LIKE inaa_t.inaa001
DEFINE r_success         LIKE type_t.num5
DEFINE l_errno           LIKE type_t.chr10
DEFINE l_sql             STRING
DEFINE l_inaa            RECORD
       inaa106           LIKE inaa_t.inaa106,    #品類
       inaa140           LIKE inaa_t.inaa140     #庫區特殊屬性
                         END RECORD
                         
   LET r_success = TRUE
   LET l_errno = ''
   
   IF g_argv[1] MATCHES '[123]' THEN
      RETURN r_success
   END IF
   
   INITIALIZE l_inaa.* TO NULL
   LET l_sql = "SELECT inaa106,inaa140",
               "  FROM inaa_t",
               " WHERE inaaent = ",g_enterprise,
               "   AND inaa001 = '",p_inaa001,"'"
   IF p_type = '-1' THEN
      LET l_sql = l_sql," AND inaasite = '",g_indc_m.indc005,"'"
   ELSE
      LET l_sql = l_sql," AND inaasite = '",g_indc_m.indc006,"'"
   END IF
   PREPARE s_aint510_depot_chk FROM l_sql
   EXECUTE s_aint510_depot_chk INTO l_inaa.inaa106,l_inaa.inaa140
   
   CASE g_indc_m.indc202
      WHEN '1'    #倉庫入賣場
         IF p_type = '1' THEN
            IF l_inaa.inaa140 != '1' OR cl_null(l_inaa.inaa140) THEN
               #此倉庫的庫存特殊屬性不等於1.賣場！
               LET l_errno = 'ain-00699'
            END IF
            
            IF NOT cl_null(l_inaa.inaa106) THEN
               #此倉庫品類不為空，代表倉庫為生鮮倉！
               LET l_errno = 'ain-00704'
            END IF
         ELSE
            IF l_inaa.inaa140 != '2' OR cl_null(l_inaa.inaa140) THEN
               #此倉庫的庫存特殊屬性不等於2.倉庫！
               LET l_errno = 'ain-00700'
            END IF
         END IF
         
      WHEN '2'    #賣場入倉庫
         IF p_type = '1' THEN
            IF l_inaa.inaa140 != '2' OR cl_null(l_inaa.inaa140) THEN
               #此倉庫的庫存特殊屬性不等於2.倉庫！
               LET l_errno = 'ain-00700'
            END IF
         ELSE
            IF l_inaa.inaa140 != '1' OR cl_null(l_inaa.inaa140) THEN
               #此倉庫的庫存特殊屬性不等於1.賣場！
               LET l_errno = 'ain-00699'
            END IF
            
            IF NOT cl_null(l_inaa.inaa106) THEN
               #此倉庫品類不為空，代表倉庫為生鮮倉！
               LET l_errno = 'ain-00704'
            END IF
         END IF
         
      WHEN '3'    #生鮮移倉
         IF p_type = '1' THEN
            IF l_inaa.inaa140 != '1' OR cl_null(l_inaa.inaa140) THEN
               #此倉庫的庫存特殊屬性不等於1.賣場！
               LET l_errno = 'ain-00699'
            END IF
            IF cl_null(l_inaa.inaa106) THEN
               #生鮮庫區不允許調入賣場庫區！此倉庫的品類為空，代表倉庫為非生鮮倉！
               LET l_errno = 'ain-00702'
            END IF
         ELSE
            IF l_inaa.inaa140 NOT MATCHES '[12]' OR cl_null(l_inaa.inaa140) THEN
               #此倉庫的庫存特殊屬性不等於1.賣場或2.倉庫！
               LET l_errno = 'ain-00703'
            END IF
         END IF
         
      WHEN '4'    #贈品移倉
         IF p_type = '1' THEN
            IF l_inaa.inaa140 != '4' OR cl_null(l_inaa.inaa140) THEN
               #此倉庫的庫存特殊屬性不等於4.贈品倉！
               LET l_errno = 'ain-00701'
            END IF
         ELSE
            IF l_inaa.inaa140 NOT MATCHES '[12]' OR cl_null(l_inaa.inaa140) THEN
               #此倉庫的庫存特殊屬性不等於1.賣場或2.倉庫！
               LET l_errno = 'ain-00703'
            END IF
            
            IF NOT cl_null(l_inaa.inaa106) AND l_inaa.inaa140 = '1' THEN
               #此倉庫品類不為空，代表倉庫為生鮮倉！
               LET l_errno = 'ain-00704'
            END IF
         END IF
      
      WHEN '5'    #贈品退回
         IF p_type = '1' THEN
            IF l_inaa.inaa140 NOT MATCHES '[12]' OR cl_null(l_inaa.inaa140) THEN
               #此倉庫的庫存特殊屬性不等於1.賣場或2.倉庫！
               LET l_errno = 'ain-00703'
            END IF
            
            IF NOT cl_null(l_inaa.inaa106) AND l_inaa.inaa140 = '1' THEN
               #此倉庫品類不為空，代表倉庫為生鮮倉！
               LET l_errno = 'ain-00704'
            END IF
         ELSE
            IF l_inaa.inaa140 != '4' OR cl_null(l_inaa.inaa140) THEN
               #此倉庫的庫存特殊屬性不等於4.贈品倉！
               LET l_errno = 'ain-00701'
            END IF
         END IF
      
      WHEN '6'   #倉庫間的調撥
         IF l_inaa.inaa140 != '2' OR cl_null(l_inaa.inaa140) THEN
            #此倉庫的庫存特殊屬性不等於2.倉庫！
            LET l_errno = 'ain-00700'
         END IF
   END CASE
   
   IF NOT cl_null(l_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得產品特徵類別
# Memo...........:
# Usage..........: CALL aint510_get_imaa005(p_imaa001)
#                  RETURNING r_imaa005
# Input parameter: p_imaa001   商品編號
# Return code....: r_imaa005   產品特徵類別
# Date & Author..: #161017-00029#8 2016/10/19 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_get_imaa005(p_imaa001)
   DEFINE p_imaa001      LIKE imaa_t.imaa001
   DEFINE r_imaa005      LIKE imaa_t.imaa005

   LET r_imaa005 = ''
   SELECT imaa005 INTO r_imaa005 
     FROM imaa_t 
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_imaa001
      
   RETURN r_imaa005
END FUNCTION

################################################################################
# Descriptions...: 產生裝箱單主檔、明細
# Memo...........:
# Usage..........: CALL aint510_ins_inbm(p_indcdocno)
#                  RETURNING r_success
# Input parameter: p_indcdocno    單號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/10/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_ins_inbm(p_indcdocno)
DEFINE p_indcdocno      LIKE indc_t.indcdocno
DEFINE l_sql            STRING
DEFINE l_indcsite       LIKE indc_t.indcsite
DEFINE l_indcdocno      LIKE indc_t.indcdocno
DEFINE l_indc000        LIKE indc_t.indc000   #161217-00002#1 Add By Ken 161220
DEFINE l_indc006        LIKE indc_t.indc006
DEFINE l_indc005        LIKE indc_t.indc005 #add by 08172 #161213-00022#1
DEFINE l_indc001        LIKE indc_t.indc001
DEFINE l_indc008        LIKE indc_t.indc008 #161108-00059#1 2016/11/16 by sunxh/yany
DEFINE l_indddocno      LIKE indd_t.indddocno
DEFINE l_inddseq        LIKE indd_t.inddseq
DEFINE l_indd002        LIKE indd_t.indd002
DEFINE l_indd003        LIKE indd_t.indd003
DEFINE l_indd004        LIKE indd_t.indd004
DEFINE l_indd006        LIKE indd_t.indd006
DEFINE l_indd021        LIKE indd_t.indd021
DEFINE l_inbm           RECORD
       inbment          LIKE inbm_t.inbment,
       inbmsite         LIKE inbm_t.inbmsite,
       inbmunit         LIKE inbm_t.inbmunit,
       inbmdocno        LIKE inbm_t.inbmdocno,
       inbmdocdt        LIKE inbm_t.inbmdocdt,
       inbm001          LIKE inbm_t.inbm001,
       inbm002          LIKE inbm_t.inbm002,
       inbm003          LIKE inbm_t.inbm003,
       inbm004          LIKE inbm_t.inbm004,
       inbm005          LIKE inbm_t.inbm005,
       inbm006          LIKE inbm_t.inbm006,
       inbm007          LIKE inbm_t.inbm007,
       inbm008          LIKE inbm_t.inbm008,
       inbmstus         LIKE inbm_t.inbmstus,
       inbmownid        LIKE inbm_t.inbmownid,
       inbmowndp        LIKE inbm_t.inbmowndp,
       inbmcrtid        LIKE inbm_t.inbmcrtid,
       inbmcrtdp        LIKE inbm_t.inbmcrtdp,
       inbmcrtdt        LIKE inbm_t.inbmcrtdt
                        END RECORD
DEFINE l_inbp           RECORD
       inbpent          LIKE inbp_t.inbpent, 
       inbpsite         LIKE inbp_t.inbpsite, 
       inbpdocno        LIKE inbp_t.inbpdocno, 
       inbpseq          LIKE inbp_t.inbpseq, 
       inbp001          LIKE inbp_t.inbp001, 
       inbp002          LIKE inbp_t.inbp002, 
       inbp003          LIKE inbp_t.inbp003, 
       inbp004          LIKE inbp_t.inbp004, 
       inbp005          LIKE inbp_t.inbp005, 
       inbp006          LIKE inbp_t.inbp006, 
       inbp007          LIKE inbp_t.inbp007, 
       inbp008          LIKE inbp_t.inbp008, 
       inbp009          LIKE inbp_t.inbp009, 
       inbp010          LIKE inbp_t.inbp010, 
       inbp011          LIKE inbp_t.inbp011, 
       inbp012          LIKE inbp_t.inbp012
                        END RECORD   
DEFINE l_slip           STRING      #單別 
DEFINE l_success        LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   INITIALIZE l_inbm.* TO NULL
   INITIALIZE l_inbp.* TO NULL

   #161217-00002#1 Add By Ken 161221(S)
   SELECT indc000 INTO l_indc000
     FROM indc_t 
    WHERE indcent = g_enterprise
      AND indcdocno = p_indcdocno
   
   IF l_indc000 = '1' THEN    #一階段調撥時，不用撥入單號找撥出單號
      LET l_indcdocno = p_indcdocno
   ELSE
   #161217-00002#1 Add By Ken 161221(E)   
      #先用撥入單號找出撥出單號
      SELECT indcdocno INTO l_indcdocno
        FROM indc_t 
       WHERE indcent = g_enterprise
         AND indc001 = p_indcdocno
         AND indc000 = '2'
         AND indcstus != 'X'
   END IF
      
   #明細資料SQL
   LET l_sql = " SELECT indddocno,inddseq,indd002,indd003,indd004,indd006,indd021 ",
               "   FROM indd_t ",
               "  WHERE inddent = ",g_enterprise,
               "    AND indddocno = '",l_indcdocno, "' "
   PREPARE aint510_indd_sel_pre FROM l_sql
   DECLARE aint510_indd_sel_cur CURSOR FOR aint510_indd_sel_pre 

   #明細項次+1
   LET l_sql = " SELECT MAX(inbpseq)+1 ",
               "   FROM inbp_t ",
               "  WHERE inbpent = ",g_enterprise,
               "    AND inbpdocno = ? "
   PREPARE aint510_inbpseq_sel FROM l_sql 
     
#   LET l_sql = " SELECT indcsite,indc006,indc001 ",
    LET l_sql = " SELECT indcsite,indc006,indc001,indc008,indc005, ",  #161108-00059#1 2016/11/16 by sunxh/yany #add by 08172 #161213-00022#1 indc005
                "        indc000 ",  #161217-00002#1 Add By Ken 161220
                "   FROM indc_t ",
                "  WHERE indcent = ", g_enterprise ,
                "    AND indcdocno = '",l_indcdocno,"'"
   PREPARE aint510_indc_sel_pre FROM l_sql
   DECLARE aint510_indc_sel_cur CURSOR FOR aint510_indc_sel_pre
#   FOREACH aint510_indc_sel_cur INTO l_indcsite,l_indc006,l_indc001
   FOREACH aint510_indc_sel_cur INTO l_indcsite,l_indc006,l_indc001,l_indc008,l_indc005, #add by 08172 #161213-00022#1
                                     l_indc000   #161217-00002#1 Add By Ken 161220
     #取單別
     LET l_success = ''
     CALL s_arti200_get_def_doc_type(g_site,'aint701','2')
        RETURNING l_success,l_slip
     IF l_success = FALSE THEN
        LET r_success = FALSE
        EXIT FOREACH
     END IF 

     #取單號
     LET l_success = ''
     CALL s_aooi200_gen_docno(g_site,l_slip,g_today,'aint701')
        RETURNING l_success,l_inbm.inbmdocno
     IF l_success = FALSE THEN        
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'apm-00003'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET r_success = FALSE
        EXIT FOREACH
     END IF 
               
     LET l_inbm.inbment    = g_enterprise
     LET l_inbm.inbmdocdt  = g_today    
     LET l_inbm.inbmsite   = l_indc006          #营运据点
     LET l_inbm.inbmunit   = l_indcsite         #配送中心    
     #LET l_inbm.inbm001    = l_indc006          #需求对象 #mark by 08172 #161213-00022#1
     LET l_inbm.inbm001    = l_indc005          #需求对象 #add by 08172 #161213-00022#1
     LET l_inbm.inbm002    = ''                 #需求单号
     #161217-00002#1 Add By Ken 161220(S)
     #CASE WHEN l_indc000 = '3'   #161230-00027#1 Mark By Ken 161230
     CASE WHEN l_indc000 = '2'    #161230-00027#1 Add By Ken 161230
         LET l_inbm.inbm003    = '6'                #来源单据类型:6.门店仓退单
          WHEN l_indc000 = '1'
         LET l_inbm.inbm003    = '9'                #来源单据类型:9.一阶段仓退单
     END CASE 
     #161217-00002#1 Add By Ken 161220(E)
     LET l_inbm.inbm004    = l_indcdocno        #来源单号:調撥單號(撥出單號)
     LET l_inbm.inbm005    = g_user             #装箱人员
     LET l_inbm.inbm006    = g_dept             #装箱部门
#     LET l_inbm.inbm007    = ''                 #備註
     LET l_inbm.inbm007    = l_indc008          #備註  #161108-00059#1 2016/11/16 by sunxh/yany
     LET l_inbm.inbm008    = '1'                #需求对象类型1.内部组织     
     LET l_inbm.inbmstus   = 'N'
     LET l_inbm.inbmownid  = g_user              #資料所有者 
     LET l_inbm.inbmowndp  = g_dept              #資料所屬部門
     LET l_inbm.inbmcrtid  = g_user              #資料建立者 
     LET l_inbm.inbmcrtdp  = g_dept              #資料建立部門
     LET l_inbm.inbmcrtdt  = cl_get_current()    #資料創建日     
     
     INSERT INTO inbm_t(inbment,  inbmdocno, inbmsite, inbmunit, inbmdocdt, 
                        inbm001,  inbm002,   inbm003,  inbm004,  inbm005, 
                        inbm006,  inbm007,   inbm008,  
                        inbmownid,inbmowndp, inbmcrtid,inbmcrtdp,inbmcrtdt,
                        inbmstus)                      
           VALUES(l_inbm.inbment,  l_inbm.inbmdocno, l_inbm.inbmsite, l_inbm.inbmunit, l_inbm.inbmdocdt, 
                  l_inbm.inbm001,  l_inbm.inbm002,   l_inbm.inbm003,  l_inbm.inbm004,  l_inbm.inbm005, 
                  l_inbm.inbm006,  l_inbm.inbm007,   l_inbm.inbm008,  
                  l_inbm.inbmownid,l_inbm.inbmowndp, l_inbm.inbmcrtid,l_inbm.inbmcrtdp,l_inbm.inbmcrtdt,
                  l_inbm.inbmstus)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert inbm_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH         
      END IF                 
      
      #寫明細資料
      FOREACH aint510_indd_sel_cur INTO l_indddocno,l_inddseq,l_indd002,l_indd003,l_indd004,l_indd006,l_indd021
         LET l_inbp.inbpent   = g_enterprise
         LET l_inbp.inbpsite  = l_inbm.inbmsite
         LET l_inbp.inbpdocno = l_inbm.inbmdocno
         EXECUTE aint510_inbpseq_sel USING l_inbm.inbmdocno INTO l_inbp.inbpseq
         IF cl_null(l_inbp.inbpseq) THEN
            LET l_inbp.inbpseq = 1
         END IF
         #LET l_inbp.inbp001   = '6'  #161217-00002#1 Mark By Ken 161220
         LET l_inbp.inbp001   = l_inbm.inbm003  #161217-00002#1 Add By Ken 161220
         LET l_inbp.inbp002   = l_indcdocno
         LET l_inbp.inbp003   = l_inddseq
         LET l_inbp.inbp004   = l_indd003
         LET l_inbp.inbp005   = l_indd002
         LET l_inbp.inbp006   = l_indd004
         LET l_inbp.inbp007   = l_indd006
         LET l_inbp.inbp008   = l_indd021
         LET l_inbp.inbp009   = 0

         INSERT INTO inbp_t(inbpent,  inbpdocno, inbpsite, inbpseq,  inbp001,  inbp002,   
                            inbp003,  inbp004,   inbp005,  inbp006,  inbp007,   
                            inbp008,  inbp009)                      
               VALUES(l_inbp.inbpent,  l_inbp.inbpdocno, l_inbp.inbpsite, l_inbp.inbpseq,   l_inbp.inbp001,  l_inbp.inbp002,   
                      l_inbp.inbp003,  l_inbp.inbp004,   l_inbp.inbp005,  l_inbp.inbp006,  l_inbp.inbp007,   
                      l_inbp.inbp008,  l_inbp.inbp009)                      
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'Insert inbp_t'
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET r_success = FALSE
             EXIT FOREACH         
          END IF   
      END FOREACH                 
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根據不同的參數，顯示不同的toolbar
# Memo...........:
# Usage..........: CALL aint510_act_visible_init()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/28 By Ken
# Modify.........: #161024-00023#7
################################################################################
PRIVATE FUNCTION aint510_act_visible_init()
   IF g_argv[1] = '3' THEN
      CALL cl_set_toolbaritem_visible("gen_aint701",TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible("gen_aint701",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 配送仓可用库存计算
# Memo...........:
# Usage..........: CALL adbt500_inag009_count(p_imaa001,p_site,p_imay012,p_inag003)
#                  RETURNING 回传参数
# Input parameter: p_imaa001 料号
#                : p_site    配送中心
#                : p_imay012 产品特征
#                : p_inag003 库存管理特征
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: #161027-00055#5 20161029 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_inag009_count(p_imaa001,p_site,p_imay012,p_inag003)
   DEFINE p_imaa001             LIKE imaa_t.imaa001     #料号
   DEFINE p_site                LIKE pmda_t.pmdasite    #组织
   DEFINE p_imay012             LIKE imay_t.imay012     #产品特征
   DEFINE l_amount              LIKE inag_t.inag009     #数量   
   DEFINE l_inag009             LIKE inag_t.inag009     #数量 
   DEFINE p_inag003             LIKE inag_t.inag003     #库存管理特征 
   DEFINE p_inag004             LIKE inag_t.inag004     #库位
   DEFINE p_inag007             LIKE inag_t.inag007     #库存单位
   DEFINE l_inaasite            LIKE inaa_t.inaasite
   #add by geza 20161208 #161124-00039#1(S)
   CALL s_aint700_adbi261_inv_scope_def(p_site,p_imaa001,g_indc_m.indc005,'Y')         
               RETURNING l_inaasite,p_inag004 
   #抓库存单位
   LET p_inag007 =''
   SELECT imaa104 INTO p_inag007
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = p_imaa001 
   #add by geza 20161208 #161124-00039#1(E)
   
   LET l_amount = 0
   SELECT SUM(inag009) INTO l_amount
     FROM inag_t
    WHERE inagent = g_enterprise
      AND inag001 = p_imaa001
      AND inag002 = p_imay012
      AND inag004 = p_inag004 #add by geza 201611206 161124-00039#1
      AND inag007 = p_inag007 #add by geza 201611206 161124-00039#1
      AND inagsite = p_site
      #AND EXISTS (SELECT 1 FROM inaa_t WHERE inagent = inaaent AND inaasite = p_site AND inaa001 = inag004 AND inaa008 = 'Y' AND inaastus = 'Y' ) #mark by geza 20161208 #161124-00039#1
      
   #CALL s_get_inag009_valid(p_site,p_imaa001,p_imay012,l_amount,'2') RETURNING l_inag009  #mark by geza 201611206 161124-00039#1
   CALL s_get_inag009_valid(g_indc_m.indc005,p_imaa001,p_imay012,l_amount,'2',p_inag003,p_inag004,p_inag007,p_site) RETURNING l_inag009 #add by geza 20161208 #161124-00039#1
      
   
   RETURN  l_inag009  
END FUNCTION

################################################################################
# Descriptions...: 取得年份、季节、性别、上下装、大类、中类、吊牌价
# Memo...........:
# Usage..........: CALL aint510_get_imaa(p_imaa001)
#                  RETURNING r_imaa154,r_imaa155,r_imaa156,r_imaa132,r_imaa128,r_imaa009,r_imaa157
# Input parameter: p_imaa001      商品編號
# Return code....: r_imaa154      年份
#                  r_imaa155      季节
#                  r_imaa156      性别
#                  r_imaa132      上下装
#                  r_imaa128      大类
#                  r_imaa009      中类
#                  r_imaa157      吊牌价
# Date & Author..: 2016-10-30 By stcshy
# Modify.........:
################################################################################
PRIVATE FUNCTION aint510_get_imaa(p_imaa001)
DEFINE p_imaa001          LIKE imaa_t.imaa001
DEFINE r_imaa154          LIKE imaa_t.imaa154
DEFINE r_imaa155          LIKE imaa_t.imaa155
DEFINE r_imaa156          LIKE imaa_t.imaa156
DEFINE r_imaa132          LIKE imaa_t.imaa132
DEFINE r_imaa128          LIKE imaa_t.imaa128
DEFINE r_imaa009          LIKE imaa_t.imaa009
DEFINE r_imaa157          LIKE imaa_t.imaa157
DEFINE r_imaa133          LIKE imaa_t.imaa133 #add by geza 20161216 #161216-00033#1
DEFINE r_rtaw001          LIKE rtaw_t.rtaw001 #add by geza 20161216 #161216-00033#1
   LET r_imaa154=NULL
   #LET r_imaa155=NULL #mark by geza 20161216 #161216-00033#1
   LET r_imaa133=NULL #add by geza 20161216 #161216-00033#1
   LET r_imaa156=NULL
   LET r_imaa132=NULL
   #LET r_imaa128=NULL #mark by geza 20161216 #161216-00033#1
   LET r_rtaw001=NULL #add by geza 20161216 #161216-00033#1   
   LET r_imaa009=NULL
   LET r_imaa157=NULL

   #SELECT imaa154,imaa155,imaa156,imaa132,imaa128,imaa009,imaa157 INTO r_imaa154,r_imaa155,r_imaa156,r_imaa132,r_imaa128,r_imaa009,r_imaa157 FROM imaa_t #mark by geza 20161216 #161216-00033#1 
   SELECT imaa154,imaa133,imaa156,imaa132,imaa009,imaa157 INTO r_imaa154,r_imaa133,r_imaa156,r_imaa132,r_imaa009,r_imaa157 FROM imaa_t  #add by geza 20161216 #161216-00033#1
    WHERE imaaent = g_enterprise AND imaa001 = p_imaa001
  
   #抓取大類
   SELECT rtaw001 INTO r_rtaw001
     FROM rtaw_t 
    WHERE rtawent = g_enterprise
      AND rtaw003 = '1'
      AND rtaw002 = r_imaa009
   #RETURN r_imaa154,r_imaa155,r_imaa156,r_imaa132,r_imaa128,r_imaa009,r_imaa157 #mark by geza 20161216 #161216-00033#1
   RETURN r_imaa154,r_imaa133,r_imaa156,r_imaa132,r_rtaw001,r_imaa009,r_imaa157 #add by geza 20161216 #161216-00033#1
   
END FUNCTION

 
{</section>}
 
