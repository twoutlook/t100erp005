#該程式未解開Section, 採用最新樣板產出!
{<section id="aint330.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0057(2016-11-17 14:35:28), PR版次:0057(2017-02-20 14:00:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000621
#+ Filename...: aint330
#+ Description: 一階段調撥作業
#+ Creator....: 01534(2014-04-18 11:46:56)
#+ Modifier...: 07024 -SD/PR- 01996
 
{</section>}
 
{<section id="aint330.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151202-00009#1 15/12/02 By Polly          刪除單據後，需刪除最大號
#151224-00025#1 15/12/25 By tsungyung      手動輸入特徵碼沒有同步新增inam_t[料件產品特徵明細檔](整批修改)
#160120-00006#1 16/01/27 By lixh           仓库为NULL不调用CALL s_control_chk_doc() 进行检验
#160202-00004#1 16/02/02 By lixh           1：自动产生单身时数量给值没有区分检验方式 
###############################            2：单头来源单号没有输入值时，营运据点和检验方式栏位需要开启输入 
###############################            3：拨入仓库在申请单没有指定需要开启输入
#160126-00024#1 16/02/25 By lixh           來源類別為差異調整的單據不可做更改！
#160311-00006#1 16/03/11 By lixh           查询时，【来源类别】栏位的4-8选项不显示，这些是流通的
#160302-00019#1 16/03/11 By lixh           参考单位使用=N,单身未显示indd104参考单位，但是在拨出申请量后面显示了indd104_desc栏位及资料
#160314-00008#1 16/03/14 By catmoon        批/序號3:不控管時,修改儲位/批號時沒有更新到inao_t
#160316-00007#2 16/03/16 By lixh           制造批序号相关程式请加上对库存管理特征的处理
#160314-00009#9 16/03/25 By zhujing        各程式增加产品特征是否需要自动开窗的程式段处理
#160318-00005#22 16/03/30 by 07675         將重複內容的錯誤訊息置換為公用錯誤訊息
#160413-00011#4 16/04/13 By zhujing        效能优化
#160318-00025#19 16/04/19 BY 07900         校验代码重复错误讯息的修改
#160315-00005#1  16/04/21 By lixh          复制段拨入合格量和拨出合格量调整
#160429-00006#1  16/04/29 By lixh          料件单一单位时拨出单位不可维护，默认库存单位
#160510-00019#14 16/05/25 By zhujing       效能优化添加，改为子查询
#160519-00022#2  16/06/30 By xianghui      添加批号控管
#160705-00042#7  16/07/15 By 02159         把gzcb002=固定寫死的作業代號改成g_prog,然後gzcb_t要多JOIN gzzz_t
#160519-00008#4  16/07/25 By lixh          单据上库存管理特征栏位需依料件设定控管
#160801-00001#1  16/08/02 By catmoon       新增狀態下選放棄，出現參數錯誤
#160804-00013#1  16/08/10 By lixh          料件有设置产品特征,不输入产品特征也可以过账成功 
#160812-00017#2  16/08/15 By 06814         在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160523-00030#1  16/08/31 by 02097         增加aint330_02
#160905-00007#5  20160905 by geza          sql加上ent条件
#160902-00036#1  2016/09/19 By lixh        aint330的來源類別新增一下拉選項-報廢申請單
#160921-00014#1  2016/10/11 By lixh        增加來源為aint310的邏輯處理
#161013-00028#1  2016/10/13 By lixh        申请数量为负数，增加对应的库存扣帐&制造批序号逻辑
#160831-00070#7  2016/10/14 By 06814       整單操作新增掃碼輸入
#161019-00017#8  2016/10/21 By zhujing     据点组织开窗资料整批调整
#161019-00017#3  2016/10/21 By lixh        据点组织开窗资料整批调整
#161006-00018#4  2016/11/15 By lixh        增加参数D-MFG-0085(來源單據指定庫儲後，是否允許修改)
#161007-00012#2  2016/11/15 By dorislai    1.撥出/入庫位，任一個為VMI庫存，則庫存管理特徵必輸
#                                          2.撥出/入庫位，僅能選擇VMI存貨庫位、非VMIN庫位 (排除VMI結算庫位)
#                                          3.撥出/撥入庫位，任一個為VMI庫位時，則不控卡"成本庫位否"是否一致(ain-00490)
#                                          4.修正ain-00490沒有給替代值(%1.%2)
#161116-00011#1  2016/11/16 By lixh        调整过账段报错时机&报错形式
#161110-00036#1  2016/11/18 By lixh        1.明細操作裡的[產生調撥單身子]修正為[調撥單身整批產生]
#..........................................2.開啟的aint330_02_s01改为开启aint330_s01
#161108-00002#1  2016/12/01 By Ann_Huang   調整過帳還原按鈕需能有權限控卡功能
#161124-00048#5  2016/12/12 By 08734       星号整批调整
#160824-00007#282  16/12/29 By lori        修正舊值備份寫法
#161229-00002#1  2016/01/11 By lixh        起运地，到达地l_oocq019 = '1' OR '4' 有效性检查的是运输城市维护作业(apmi015) oocq001 = '315'
#161230-00001#1  2017/01/11 By 02040       單身整批產生後，回到主畫面，未將儲位說明帶出來
#160604-00034#4  2017/02/06 By lixh        單據的單據日期及過帳日期應依aoos020裡"進銷存單據日期控管方式"、"進銷存過帳日期控管方式"處理,
#                                          如參數設定為"不可修改"時，則新增、修改時，都不可異動該欄位資料
#160711-00040#15 2017/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1

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
PRIVATE type type_g_indc_m        RECORD
       indcdocno LIKE indc_t.indcdocno, 
   indcdocdt LIKE indc_t.indcdocdt, 
   indc004 LIKE indc_t.indc004, 
   indc004_desc LIKE type_t.chr80, 
   indcsite LIKE indc_t.indcsite, 
   indcdocno_desc LIKE type_t.chr80, 
   indc022 LIKE indc_t.indc022, 
   indc101 LIKE indc_t.indc101, 
   indc101_desc LIKE type_t.chr80, 
   indcstus LIKE indc_t.indcstus, 
   indc002 LIKE indc_t.indc002, 
   indc003 LIKE indc_t.indc003, 
   indc006 LIKE indc_t.indc006, 
   indc006_desc LIKE type_t.chr80, 
   indc151 LIKE indc_t.indc151, 
   indc151_desc LIKE type_t.chr80, 
   indc102 LIKE indc_t.indc102, 
   indc103 LIKE indc_t.indc103, 
   indc104 LIKE indc_t.indc104, 
   indc009 LIKE indc_t.indc009, 
   indc008 LIKE indc_t.indc008, 
   indc105 LIKE indc_t.indc105, 
   indc105_desc LIKE type_t.chr80, 
   l_indc105_desc LIKE type_t.chr500, 
   indc106 LIKE indc_t.indc106, 
   indc106_desc LIKE type_t.chr80, 
   indc107 LIKE indc_t.indc107, 
   indc107_desc LIKE type_t.chr80, 
   indc108 LIKE indc_t.indc108, 
   indc108_desc LIKE type_t.chr80, 
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
   indcpstid LIKE indc_t.indcpstid, 
   indcpstid_desc LIKE type_t.chr80, 
   indcmoddt LIKE indc_t.indcmoddt, 
   indcpstdt LIKE indc_t.indcpstdt, 
   indccnfid LIKE indc_t.indccnfid, 
   indccnfid_desc LIKE type_t.chr80, 
   indccnfdt LIKE indc_t.indccnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_indd_d        RECORD
       inddsite LIKE indd_t.inddsite, 
   inddseq LIKE indd_t.inddseq, 
   indd101 LIKE indd_t.indd101, 
   indd001 LIKE indd_t.indd001, 
   indd002 LIKE indd_t.indd002, 
   indd002_desc LIKE type_t.chr500, 
   indd002_desc_desc LIKE type_t.chr500, 
   indd004 LIKE indd_t.indd004, 
   indd004_desc LIKE type_t.chr500, 
   indd022 LIKE indd_t.indd022, 
   indd022_desc LIKE type_t.chr500, 
   indd023 LIKE indd_t.indd023, 
   indd023_desc LIKE type_t.chr500, 
   indd024 LIKE indd_t.indd024, 
   indd102 LIKE indd_t.indd102, 
   indd006 LIKE indd_t.indd006, 
   indd006_desc LIKE type_t.chr500, 
   indd103 LIKE indd_t.indd103, 
   indd021 LIKE indd_t.indd021, 
   indd104 LIKE indd_t.indd104, 
   indd104_desc LIKE type_t.chr500, 
   indd105 LIKE indd_t.indd105, 
   indd106 LIKE indd_t.indd106, 
   indd151 LIKE indd_t.indd151, 
   indd151_desc LIKE type_t.chr500, 
   indd032 LIKE indd_t.indd032, 
   indd032_desc LIKE type_t.chr500, 
   indd033 LIKE indd_t.indd033, 
   indd033_desc LIKE type_t.chr500, 
   indd041 LIKE indd_t.indd041, 
   indd041_desc LIKE type_t.chr500, 
   indd031 LIKE indd_t.indd031, 
   indd109 LIKE indd_t.indd109, 
   indd040 LIKE indd_t.indd040, 
   indd042 LIKE indd_t.indd042, 
   indd042_desc LIKE type_t.chr500, 
   indd043 LIKE indd_t.indd043, 
   indd043_desc LIKE type_t.chr500, 
   indd044 LIKE indd_t.indd044, 
   indd044_desc LIKE type_t.chr500, 
   indd152 LIKE indd_t.indd152
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_indcdocno LIKE indc_t.indcdocno,
      b_indcdocdt LIKE indc_t.indcdocdt,
      b_indc022 LIKE indc_t.indc022,
      b_indc004 LIKE indc_t.indc004,
   b_indc004_desc LIKE type_t.chr80,
      b_indc101 LIKE indc_t.indc101,
   b_indc101_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_oofa001             LIKE oofa_t.oofa001
DEFINE g_acc                 LIKE gzcb_t.gzcb004
#mark by lixh 20160113 151106-00018/17
# TYPE type_g_inao_d        RECORD
#   inao000         LIKE inao_t.inao000,
#   inao013         LIKE inao_t.inao013,
#   inaodocno       LIKE inao_t.inaodocno,   
#   inaoseq         LIKE inao_t.inaoseq,
#   inaoseq1        LIKE inao_t.inaoseq1,
#   inaoseq2        LIKE inao_t.inaoseq2,
#   inao001         LIKE inao_t.inao001,
#   inao001_desc    LIKE imaal_t.imaal003,
#   inao001_desc_desc  LIKE imaal_t.imaal004,
#   inao008         LIKE inao_t.inao008,
#   inao009         LIKE inao_t.inao009,
#   inao012         LIKE inao_t.inao012,
#   inao010         LIKE inao_t.inao010,
#   inao011         LIKE inao_t.inao011   
#       END RECORD      
#DEFINE g_inao_d    DYNAMIC ARRAY OF type_g_inao_d 
#mark by lixh 20160113 151106-00018/17
DEFINE g_rec_b1        LIKE type_t.num5
DEFINE g_oocq019_t     LIKE oocq_t.oocq019 
GLOBALS
#add by lixh 20160113 151106-00018/17
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
#add by lixh 20160113 151106-00018/17
   DEFINE g_d_idx_display   LIKE type_t.num5   #製造批序號明細所在筆數
   DEFINE g_d_cnt_display   LIKE type_t.num5   #製造批序號明細總筆數
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數 
   DEFINE g_inao_d    DYNAMIC ARRAY OF type_g_inao_d     #add by lixh 20160113 151106-00018/17
   DEFINE g_inao_d_t        type_g_inao_d
END GLOBALS
#161007-00012#2-s-add
DEFINE  g_para_in_1    LIKE type_t.chr80  #VMI存貨庫位Tag(撥入倉)
DEFINE  g_para_in_2    LIKE type_t.chr80  #VMI結算庫位Tag(撥入倉)
DEFINE  g_para_out_1   LIKE type_t.chr80  #VMI存貨庫位Tag(撥出倉)
DEFINE  g_para_out_2   LIKE type_t.chr80  #VMI結算庫位Tag(撥出倉)
DEFINE  g_indd022_type LIKE type_t.num5
DEFINE  g_indd032_type LIKE type_t.num5
#161007-00012#2-e-add
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
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
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
 
{<section id="aint330.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   #獲取當前營運據點的聯絡對象識別碼

   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT indcdocno,indcdocdt,indc004,'',indcsite,'',indc022,indc101,'',indcstus, 
       indc002,indc003,indc006,'',indc151,'',indc102,indc103,indc104,indc009,indc008,indc105,'','',indc106, 
       '',indc107,'',indc108,'',indcownid,'',indcowndp,'',indccrtid,'',indccrtdp,'',indccrtdt,indcmodid, 
       '',indcpstid,'',indcmoddt,indcpstdt,indccnfid,'',indccnfdt", 
                      " FROM indc_t",
                      " WHERE indcent= ? AND indcdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint330_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.indcdocno,t0.indcdocdt,t0.indc004,t0.indcsite,t0.indc022,t0.indc101, 
       t0.indcstus,t0.indc002,t0.indc003,t0.indc006,t0.indc151,t0.indc102,t0.indc103,t0.indc104,t0.indc009, 
       t0.indc008,t0.indc105,t0.indc106,t0.indc107,t0.indc108,t0.indcownid,t0.indcowndp,t0.indccrtid, 
       t0.indccrtdp,t0.indccrtdt,t0.indcmodid,t0.indcpstid,t0.indcmoddt,t0.indcpstdt,t0.indccnfid,t0.indccnfdt, 
       t1.ooag011 ,t2.ooefl003 ,t3.ooefl003 ,t4.oocql004 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 , 
       t9.ooag011 ,t10.ooag011 ,t11.ooag011",
               " FROM indc_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.indc004  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.indc101 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.indc006 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='263' AND t4.oocql002=t0.indc106 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.indcownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.indcowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.indccrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.indccrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.indcmodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.indcpstid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.indccnfid  ",
 
               " WHERE t0.indcent = " ||g_enterprise|| " AND t0.indcdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   #160510-00019#14 add-S
   LET g_sql = " SELECT DISTINCT t0.indcdocno,t0.indcdocdt,t0.indc004,t0.indcsite,t0.indc022,t0.indc101, 
       t0.indcstus,t0.indc002,t0.indc003,t0.indc006,t0.indc151,t0.indc102,t0.indc103,t0.indc104,t0.indc009, 
       t0.indc008,t0.indc105,t0.indc106,t0.indc107,t0.indc108,t0.indcownid,t0.indcowndp,t0.indccrtid, 
       t0.indccrtdp,t0.indccrtdt,t0.indcmodid,t0.indcpstid,t0.indcmoddt,t0.indcpstdt,t0.indccnfid,t0.indccnfdt, 
       (SELECT ooag011 FROM ooag_t WHERE ooag001 = t0.indc004 AND ooagent = ",g_enterprise,") t1_ooag011 ,
       (SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = t0.indc101 AND ooeflent = ",g_enterprise ," AND ooefl002 = '",g_dlang,"') t2_ooefl003 ,
       (SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = t0.indc006 AND ooeflent = ",g_enterprise ," AND ooefl002 = '",g_dlang,"') t3_ooefl003 ,
       (SELECT oocql004 FROM oocql_t WHERE oocql001 = '263' AND oocql002 = t0.indc106 AND oocqlent = ",g_enterprise," AND oocql003 = '",g_dlang,"') t4_oocql004 ,
       (SELECT ooag011 FROM ooag_t WHERE ooag001 = t0.indcownid AND ooagent = ",g_enterprise,") t5_ooag011 ,
       (SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = t0.indcowndp AND ooeflent = ",g_enterprise ," AND ooefl002 = '",g_dlang,"') t6_ooefl003 ,
       (SELECT ooag011 FROM ooag_t WHERE ooag001 = t0.indccrtid AND ooagent = ",g_enterprise,") t7_ooag011 ,
       (SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = t0.indccrtdp AND ooeflent = ",g_enterprise ," AND ooefl002 = '",g_dlang,"') t8_ooefl003 ,
       (SELECT ooag011 FROM ooag_t WHERE ooag001 = t0.indcmodid AND ooagent = ",g_enterprise,") t9_ooag011 ,
       (SELECT ooag011 FROM ooag_t WHERE ooag001 = t0.indcpstid AND ooagent = ",g_enterprise,") t10_ooag011 ,
       (SELECT ooag011 FROM ooag_t WHERE ooag001 = t0.indccnfid AND ooagent = ",g_enterprise,") t11_ooag011 ",
       " FROM indc_t t0",
       " WHERE t0.indcent = '" ||g_enterprise|| "' AND t0.indcdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #160510-00019#14 add-E
   #end add-point
   PREPARE aint330_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint330 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint330_init()   
 
      #進入選單 Menu (="N")
      CALL aint330_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_lot_sel_drop_tmp()
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint330
      
   END IF 
   
   CLOSE aint330_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint330.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint330_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('indcstus','13','N,Y,S,C,O,P,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('indc102','2081','1,2')
   CALL cl_set_combo_scc_part('indc002','6016','1,2,3,9,10')   #160311-00006#1 add by lixh 20160311
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint330'                               
   SELECT gzcb004 INTO g_acc FROM gzcb_t,gzzz_t WHERE gzcb001 = '24' AND gzcb002 = gzzz006 AND gzzz001 = g_prog   #160705-00042#7 160715 by sakura mark
   CALL aint330_get_ooef004() RETURNING g_ooef004                                                                 #160705-00042#7 160715 by sakura add
   LET g_oofa001 = ''
   SELECT oofa001 INTO g_oofa001 FROM oofa_t 
    WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_indc_m.indc006  
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN   
#      CALL cl_set_comp_visible("indd104,indd104_desc,indd105,indd106,indd109",FALSE)
      CALL cl_set_comp_visible("indd104,indd105,indd106,indd109,indd104_desc",FALSE)   #160302-00019#1 add by lixh 20160311 
   END IF 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN   
      CALL cl_set_comp_visible("indd004,indd004_desc",FALSE)
   END IF  
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN   #add by lixh 20150722
      CALL cl_set_comp_visible("indd004,indd004_desc",TRUE)
   END IF      
#   IF cl_null(g_indd_d[l_ac].indd104) THEN
#      CALL cl_set_comp_visible("indd105",FALSE)
#   END IF   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("sub", "s_lot_s01"), "grid_s_lot", "Table", "s_detail1_s_lot_s01") 
   CALL s_lot_sel_create_tmp()   
   #end add-point
   
   #初始化搜尋條件
   CALL aint330_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aint330.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aint330_ui_dialog()
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
   DEFINE l_imaf071  LIKE imaf_t.imaf071
   DEFINE l_imaf081  LIKE imaf_t.imaf081
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_sum_inao012         LIKE inao_t.inao012
   DEFINE l_imaf053  LIKE imaf_t.imaf053
   DEFINE l_imaf054  LIKE imaf_t.imaf054   
   DEFINE l_n        LIKE type_t.num5                  #160831-00070#7 20161014 add by beckxie
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
            CALL aint330_insert()
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
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aint330_init()
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
               
               CALL aint330_fetch('') # reload data
               LET l_ac = 1
               CALL aint330_ui_detailshow() #Setting the current row 
         
               CALL aint330_idx_chk()
               #NEXT FIELD inddseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_indd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint330_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
#               CALL aint330_b_fill_pxh()
               CALL s_lot_b_fill('1',g_site,'2',g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,'-1')
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
               CALL aint330_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel
            LET g_action_choice="s_lot_sel"
            IF cl_auth_chk_act("s_lot_sel") THEN
               
               #add-point:ON ACTION s_lot_sel name="menu.detail_show.page1.s_lot_sel"
               #add by lixh 20150921
               IF NOT cl_null(g_detail_idx) AND g_indc_m.indcstus = 'N' THEN
#                  SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t   ##160413-00011#4 2016-4-13 zhujing mod
                  SELECT imaf071,imaf081,imaf0,imaf054 INTO l_imaf071,l_imaf081,l_imaf053,l_imaf054 FROM imaf_t   ##160413-00011#4 2016-4-13 zhujing add
                   WHERE imafent = g_enterprise
                     AND imafsite = g_site
                     AND imaf001 = g_indd_d[g_detail_idx].indd002
                  IF l_imaf071 = '1' OR l_imaf081 = '1' THEN  
                     LET l_success = ''
                     CALL s_transaction_begin()      
                     IF g_indd_d[g_detail_idx].indd103 > 0 THEN    #161013-00028#1                  
                        CALL s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[g_detail_idx].inddseq,0,g_indd_d[g_detail_idx].indd002,g_indd_d[g_detail_idx].indd004,    
                                         g_indd_d[g_detail_idx].indd102,g_indd_d[g_detail_idx].indd022,g_indd_d[g_detail_idx].indd023,g_indd_d[g_detail_idx].indd024,g_indd_d[g_detail_idx].indd006,
                                         g_indd_d[g_detail_idx].indd103,'-1','aint330',g_site,'','','','0') 
                             RETURNING l_success  
                     END IF   #161013-00028#1
                     #161013-00028#1-S
                     IF g_indd_d[g_detail_idx].indd103 < 0 THEN
                        CALL s_aint330_lot_sel('1','2',g_indc_m.indc006,g_indc_m.indcdocno,g_indd_d[g_detail_idx].inddseq,0,g_indd_d[g_detail_idx].indd002,g_indd_d[g_detail_idx].indd004,    
                                         g_indd_d[g_detail_idx].indd102,g_indd_d[g_detail_idx].indd022,g_indd_d[g_detail_idx].indd023,g_indd_d[g_detail_idx].indd024,g_indd_d[g_detail_idx].indd006,
                                         g_indd_d[g_detail_idx].indd103,'-1','aint330',g_site,g_indd_d[g_detail_idx].indd032,g_indd_d[g_detail_idx].indd033)                                                                                       
                           RETURNING l_success
                     END IF
                     #161013-00028#1-E
                     LET l_sum_inao012 = 0   
                     SELECT SUM(inao012) INTO l_sum_inao012 FROM inao_t
                      WHERE inaoent = g_enterprise
                        AND inaodocno = g_indc_m.indcdocno
                        AND inaoseq = g_indd_d[g_detail_idx].inddseq
                        AND inao000 = '2'
                        AND inao013 = '-1'
                     ##160413-00011#4 2016-4-13 zhujing marked---(S)
                     #add by lixh 20151022
#                     SELECT imaf053,imaf054 INTO l_imaf053,l_imaf054 FROM imaf_t
#                      WHERE imafent = g_enterprise
#                        AND imafsite = g_site
#                        AND imaf001 = g_indd_d[g_detail_idx].indd002
                     ##160413-00011#4 2016-4-13 zhujing marked---(E)
                     IF l_imaf054 = 'N' THEN
                           CALL s_aooi250_convert_qty(g_indd_d[g_detail_idx].indd002,l_imaf053,
                                                      g_indd_d[g_detail_idx].indd006,l_sum_inao012) 
                                RETURNING l_success,l_sum_inao012                                                      
                     END IF                     
                     #add by lixh 20151022
                     IF g_indd_d[g_detail_idx].indd103 <> l_sum_inao012 THEN
                        IF cl_ask_confirm('ain-00249') THEN
                           LET g_indd_d[g_detail_idx].indd103 = l_sum_inao012 
                           CALL s_aooi250_convert_qty(g_indd_d[g_detail_idx].indd002,g_indd_d[g_detail_idx].indd006,
                                                      g_indd_d[g_detail_idx].indd104,g_indd_d[g_detail_idx].indd103)
                                                      
                            RETURNING l_success,g_indd_d[g_detail_idx].indd105  
                           
                           IF g_indc_m.indc102 = '1' THEN
                              LET g_indd_d[g_detail_idx].indd021 = g_indd_d[g_detail_idx].indd103
                              LET g_indd_d[g_detail_idx].indd031 = g_indd_d[g_detail_idx].indd103
                              CALL s_aooi250_convert_qty(g_indd_d[g_detail_idx].indd002,g_indd_d[g_detail_idx].indd006,
                                                         g_indd_d[g_detail_idx].indd104,g_indd_d[g_detail_idx].indd021)
                                                         
                               RETURNING l_success,g_indd_d[g_detail_idx].indd106                                 
                           ELSE
                              LET g_indd_d[g_detail_idx].indd021 = 0
                              LET g_indd_d[g_detail_idx].indd031 = 0
                              LET g_indd_d[g_detail_idx].indd106 = 0
                           END IF  
                           UPDATE indd_t SET indd103 = g_indd_d[g_detail_idx].indd103,
                                             indd105 = g_indd_d[g_detail_idx].indd105, 
                                             indd021 = g_indd_d[g_detail_idx].indd021,
                                             indd106 = g_indd_d[g_detail_idx].indd106,
                                             indd031 = g_indd_d[g_detail_idx].indd031 
                            WHERE inddent = g_enterprise
                              AND indddocno = g_indc_m.indcdocno
                              AND inddseq = g_indd_d[g_detail_idx].inddseq
                              
                        END IF
                     END IF
                     IF l_success THEN
                        CALL s_transaction_end('Y','0')
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF                            
                        
                  END IF
               END IF 
               #add by lixh 20150921               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aint320
                  LET g_action_choice="prog_aint320"
                  IF cl_auth_chk_act("prog_aint320") THEN
                     
                     #add-point:ON ACTION prog_aint320 name="menu.detail_show.page1_sub.prog_aint320"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)

                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aint320'
                     LET la_param.param[1] = g_indd_d[l_ac].indd101
                    
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)

                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         SUBDIALOG sub_s_lot.s_lot_display         
#         DISPLAY ARRAY g_inao_d TO grid_s_lot.* ATTRIBUTES(COUNT=g_rec_b1) #page1                                     
#            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("grid_s_lot")
#               LET l_ac = g_detail_idx
#               DISPLAY g_detail_idx TO FORMONLY.idx
#
#            BEFORE DISPLAY
#               CALL FGL_SET_ARR_CURR(g_detail_idx)
#               LET l_ac = DIALOG.getCurrentRow("grid_s_lot")
#               DISPLAY g_rec_b1 TO FORMONLY.cnt               
#         END DISPLAY    
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aint330_browser_fill("")
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
               CALL aint330_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aint330_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aint330_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            #add by lixh 20150814
            IF g_indc_m.indc102 <> '2' OR g_indc_m.indcstus <> 'O' THEN  #撥出方確認
               CALL cl_set_act_visible("gen_qc",FALSE)
            END IF
            IF g_indc_m.indc102 = '2' AND g_indc_m.indcstus = 'O' THEN  #撥出方確認
               CALL cl_set_act_visible("gen_qc",TRUE)
            END IF  
            #add by lixh 20150814
            #add by lixh 20150921
            IF g_indc_m.indcstus <> 'N' THEN
               CALL cl_set_act_visible("s_lot_sel", FALSE)
            ELSE
               CALL cl_set_act_visible("s_lot_sel", TRUE)              
            END IF
            #add by lixh 20150921
            NEXT FIELD inddseq
            ON ACTION s_lot
               IF NOT cl_null(g_detail_idx) AND g_detail_idx <> 0 THEN
                  #CALL s_lot_b_fill('1',g_site,'1',g_indc_m.indcdocno,g_indd_d[l_ac].indd002,0,'-1')  #mark by lixh 20150901
                  CALL s_lot_b_fill('1',g_site,'2',g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,'-1')   #add by lixh 20150901
               END IF    
               LET lb_first = FALSE
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aint330_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aint330_set_act_visible()   
            CALL aint330_set_act_no_visible()
            IF NOT (g_indc_m.indcdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " indcent = " ||g_enterprise|| " AND",
                                  " indcdocno = '", g_indc_m.indcdocno, "' "
 
               #填到對應位置
               CALL aint330_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "indc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "indd_t" 
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
               CALL aint330_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "indc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "indd_t" 
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
                  CALL aint330_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint330_fetch("F")
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
               CALL aint330_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aint330_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint330_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aint330_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint330_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aint330_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint330_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aint330_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint330_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aint330_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint330_idx_chk()
          
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
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[2] = base.typeInfo.create(g_inao_d)
                  LET g_export_id[2]   = "s_detail1_s_lot_s01"               
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
               CALL aint330_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aint330_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint330_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint330_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " indcent = ",g_enterprise," AND indcdocno ='",g_indc_m.indcdocno,"'"
               #END add-point
               &include "erp/ain/aint330_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " indcent = ",g_enterprise," AND indcdocno ='",g_indc_m.indcdocno,"'"
               #END add-point
               &include "erp/ain/aint330_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION qc_query
            LET g_action_choice="qc_query"
            IF cl_auth_chk_act("qc_query") THEN
               
               #add-point:ON ACTION qc_query name="menu.qc_query"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aqct300'
               LET la_param.param[1] = ''
               LET la_param.param[2] = ''
               LET la_param.param[3] = g_indc_m.indcdocno
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aint330_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint330_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_qc
            LET g_action_choice="gen_qc"
            IF cl_auth_chk_act("gen_qc") THEN
               
               #add-point:ON ACTION gen_qc name="menu.gen_qc"
               IF g_indc_m.indc102 = '2' AND g_indc_m.indcstus = 'O' THEN  #撥出方確認
                  CALL aint330_01(g_indc_m.indcdocno)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION scan_barcode
            LET g_action_choice="scan_barcode"
            IF cl_auth_chk_act("scan_barcode") THEN
               
               #add-point:ON ACTION scan_barcode name="menu.scan_barcode"
               #160831-00070#7 20161014 add by beckxie---S
               #1.檢查單頭無資料或資料狀態不為未確認！不可使用此功能！
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM indc_t
                WHERE indcent = g_enterprise
                  AND indcdocno = g_indc_m.indcdocno
                  AND indcstus = 'N'
               IF l_n < 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asl-00022'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               
               
               
               #2.來源類別必須為 [1.手動輸入] 或 [2.調撥申請]，才可以使用此功能！
               IF g_indc_m.indc002 != '1' AND g_indc_m.indc002 != '2' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00797'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               
               
               #3.必填欄位檢查
               CALL cl_err_collect_init()
               IF NOT aint330_scan_chk_reqf() THEN
                  CALL cl_err_collect_show()
                  CONTINUE DIALOG
               END IF
               CALL cl_err_collect_show()
               
               #4.寫入掃碼temp table,並開窗掃碼
               CALL s_scancode_aint330_ins_tmp(g_indc_m.indcdocno)
               CALL aint330_b_fill()
               CALL aint330_show()
               #160831-00070#7 20161014 add by beckxie---E
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_indc004
            LET g_action_choice="prog_indc004"
            IF cl_auth_chk_act("prog_indc004") THEN
               
               #add-point:ON ACTION prog_indc004 name="menu.prog_indc004"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_indc_m.indc004)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_indc003
            LET g_action_choice="prog_indc003"
            IF cl_auth_chk_act("prog_indc003") THEN
               
               #add-point:ON ACTION prog_indc003 name="menu.prog_indc003"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               
               INITIALIZE la_param.* TO NULL
               IF g_indc_m.indc002 <> '10' THEN  #160902-00036#1
                  LET la_param.prog     = 'aint320'
               END IF  #160902-00036#1
               #160902-00036#1-s
               IF g_indc_m.indc002 = '10' THEN
                  LET la_param.prog     = 'aint310'
               END IF
               #160902-00036#1-e               
               LET la_param.param[1] = g_indc_m.indc003

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint330_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint330_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint330_set_pk_array()
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
 
{<section id="aint330.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aint330_browser_fill(ps_page_action)
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
   LET l_wc = l_wc," AND indc000 = '1' AND indcsite = '",g_site,"'"
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT indcdocno ",
                      " FROM indc_t ",
                      " ",
                      " LEFT JOIN indd_t ON inddent = indcent AND indcdocno = indddocno ", "  ",
                      #add-point:browser_fill段sql(indd_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
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
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1 =1"
   END IF
   LET g_wc = g_wc," AND indc000 = '1' AND indcsite = '",g_site,"'"
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
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.indcdocno,t0.indcdocdt,t0.indc022,t0.indc004,t0.indc101 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.indcstus,t0.indcdocno,t0.indcdocdt,t0.indc022,t0.indc004,t0.indc101, 
          t1.ooag011 ,t2.ooefl003 ",
                  " FROM indc_t t0",
                  "  ",
                  "  LEFT JOIN indd_t ON inddent = indcent AND indcdocno = indddocno ", "  ", 
                  #add-point:browser_fill段sql(indd_t1) name="browser_fill.join.indd_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.indc004  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.indc101 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.indcent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("indc_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.indcstus,t0.indcdocno,t0.indcdocdt,t0.indc022,t0.indc004,t0.indc101, 
          t1.ooag011 ,t2.ooefl003 ",
                  " FROM indc_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.indc004  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.indc101 AND t2.ooefl002='"||g_dlang||"' ",
 
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
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_indcdocno,g_browser[g_cnt].b_indcdocdt, 
          g_browser[g_cnt].b_indc022,g_browser[g_cnt].b_indc004,g_browser[g_cnt].b_indc101,g_browser[g_cnt].b_indc004_desc, 
          g_browser[g_cnt].b_indc101_desc
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
         CALL aint330_browser_mask()
      
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
   CALL aint330_set_act_visible()   
   CALL aint330_set_act_no_visible()
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aint330_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_indc_m.indcdocno = g_browser[g_current_idx].b_indcdocno   
 
   EXECUTE aint330_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcdocno,g_indc_m.indcdocdt, 
       g_indc_m.indc004,g_indc_m.indcsite,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002, 
       g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc151,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104, 
       g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc106,g_indc_m.indc107,g_indc_m.indc108, 
       g_indc_m.indcownid,g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt, 
       g_indc_m.indcmodid,g_indc_m.indcpstid,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid, 
       g_indc_m.indccnfdt,g_indc_m.indc004_desc,g_indc_m.indc101_desc,g_indc_m.indc006_desc,g_indc_m.indc106_desc, 
       g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc, 
       g_indc_m.indcmodid_desc,g_indc_m.indcpstid_desc,g_indc_m.indccnfid_desc
   
   CALL aint330_indc_t_mask()
   CALL aint330_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aint330.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aint330_ui_detailshow()
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
 
{<section id="aint330.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint330_ui_browser_refresh()
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
 
{<section id="aint330.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint330_construct()
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
   INITIALIZE g_indc_m.* TO NULL
   CALL g_indd_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON indcdocno,indcdocdt,indc004,indcsite,indc022,indc101,indcstus,indc002, 
          indc003,indc006,indc151,indc102,indc103,indc104,indc009,indc008,indc105,indc106,indc107,indc108, 
          indcownid,indcowndp,indccrtid,indccrtdp,indccrtdt,indcmodid,indcpstid,indcmoddt,indcpstdt, 
          indccnfid,indccnfdt
 
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
         AFTER FIELD indcpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.indcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcdocno
            #add-point:ON ACTION controlp INFIELD indcdocno name="construct.c.indcdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_indcdocno_2()                           #呼叫開窗
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
            
 
 
         #Ctrlp:construct.c.indcsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcsite
            #add-point:ON ACTION controlp INFIELD indcsite name="construct.c.indcsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_4()      #161019-00017#3
            CALL q_ooef001_1()      #161019-00017#3                   
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
 
 
         #Ctrlp:construct.c.indc101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc101
            #add-point:ON ACTION controlp INFIELD indc101 name="construct.c.indc101"
            #此段落由子樣板a08產生
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
            CALL q_indc003_1()                           #呼叫開窗
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
            
 
 
         #Ctrlp:construct.c.indc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc006
            #add-point:ON ACTION controlp INFIELD indc006 name="construct.c.indc006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001_12()                    #呼叫開窗    #161019-00017#8 marked
            CALL q_ooef001_1()                    #呼叫開窗    #161019-00017#8 add
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
            
 
 
         #Ctrlp:construct.c.indc151
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc151
            #add-point:ON ACTION controlp INFIELD indc151 name="construct.c.indc151"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc151  #顯示到畫面上
            NEXT FIELD indc151                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc151
            #add-point:BEFORE FIELD indc151 name="construct.b.indc151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc151
            
            #add-point:AFTER FIELD indc151 name="construct.a.indc151"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc102
            #add-point:BEFORE FIELD indc102 name="construct.b.indc102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc102
            
            #add-point:AFTER FIELD indc102 name="construct.a.indc102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc102
            #add-point:ON ACTION controlp INFIELD indc102 name="construct.c.indc102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc103
            #add-point:BEFORE FIELD indc103 name="construct.b.indc103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc103
            
            #add-point:AFTER FIELD indc103 name="construct.a.indc103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc103
            #add-point:ON ACTION controlp INFIELD indc103 name="construct.c.indc103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc104
            #add-point:BEFORE FIELD indc104 name="construct.b.indc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc104
            
            #add-point:AFTER FIELD indc104 name="construct.a.indc104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc104
            #add-point:ON ACTION controlp INFIELD indc104 name="construct.c.indc104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc009
            #add-point:BEFORE FIELD indc009 name="construct.b.indc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc009
            
            #add-point:AFTER FIELD indc009 name="construct.a.indc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc009
            #add-point:ON ACTION controlp INFIELD indc009 name="construct.c.indc009"
            
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
 
 
         #Ctrlp:construct.c.indc105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc105
            #add-point:ON ACTION controlp INFIELD indc105 name="construct.c.indc105"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_oofa001
            CALL q_indc105()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc105  #顯示到畫面上
            NEXT FIELD indc105                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc105
            #add-point:BEFORE FIELD indc105 name="construct.b.indc105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc105
            
            #add-point:AFTER FIELD indc105 name="construct.a.indc105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc106
            #add-point:ON ACTION controlp INFIELD indc106 name="construct.c.indc106"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '263'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc106  #顯示到畫面上
            NEXT FIELD indc106                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc106
            #add-point:BEFORE FIELD indc106 name="construct.b.indc106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc106
            
            #add-point:AFTER FIELD indc106 name="construct.a.indc106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc107
            #add-point:ON ACTION controlp INFIELD indc107 name="construct.c.indc107"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_indc107()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc107  #顯示到畫面上
            NEXT FIELD indc107                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc107
            #add-point:BEFORE FIELD indc107 name="construct.b.indc107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc107
            
            #add-point:AFTER FIELD indc107 name="construct.a.indc107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indc108
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc108
            #add-point:ON ACTION controlp INFIELD indc108 name="construct.c.indc108"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_indc108()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indc108  #顯示到畫面上
            NEXT FIELD indc108                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc108
            #add-point:BEFORE FIELD indc108 name="construct.b.indc108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc108
            
            #add-point:AFTER FIELD indc108 name="construct.a.indc108"
            
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
            
 
 
         #Ctrlp:construct.c.indcpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcpstid
            #add-point:ON ACTION controlp INFIELD indcpstid name="construct.c.indcpstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indcpstid  #顯示到畫面上
            NEXT FIELD indcpstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcpstid
            #add-point:BEFORE FIELD indcpstid name="construct.b.indcpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcpstid
            
            #add-point:AFTER FIELD indcpstid name="construct.a.indcpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcmoddt
            #add-point:BEFORE FIELD indcmoddt name="construct.b.indcmoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcpstdt
            #add-point:BEFORE FIELD indcpstdt name="construct.b.indcpstdt"
            
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
      CONSTRUCT g_wc2_table1 ON inddsite,inddseq,indd101,indd001,indd002,indd004,indd022,indd023,indd024, 
          indd102,indd006,indd103,indd021,indd104,indd105,indd106,indd151,indd032,indd033,indd041,indd031, 
          indd109,indd040,indd042,indd043,indd044,indd152
           FROM s_detail1[1].inddsite,s_detail1[1].inddseq,s_detail1[1].indd101,s_detail1[1].indd001, 
               s_detail1[1].indd002,s_detail1[1].indd004,s_detail1[1].indd022,s_detail1[1].indd023,s_detail1[1].indd024, 
               s_detail1[1].indd102,s_detail1[1].indd006,s_detail1[1].indd103,s_detail1[1].indd021,s_detail1[1].indd104, 
               s_detail1[1].indd105,s_detail1[1].indd106,s_detail1[1].indd151,s_detail1[1].indd032,s_detail1[1].indd033, 
               s_detail1[1].indd041,s_detail1[1].indd031,s_detail1[1].indd109,s_detail1[1].indd040,s_detail1[1].indd042, 
               s_detail1[1].indd043,s_detail1[1].indd044,s_detail1[1].indd152
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
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
 
 
         #Ctrlp:construct.c.page1.indd101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd101
            #add-point:ON ACTION controlp INFIELD indd101 name="construct.c.page1.indd101"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_indc003_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd101  #顯示到畫面上
            NEXT FIELD indd101                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd101
            #add-point:BEFORE FIELD indd101 name="construct.b.page1.indd101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd101
            
            #add-point:AFTER FIELD indd101 name="construct.a.page1.indd101"
            
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
 
 
         #Ctrlp:construct.c.page1.indd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd002
            #add-point:ON ACTION controlp INFIELD indd002 name="construct.c.page1.indd002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
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
            
 
 
         #Ctrlp:construct.c.page1.indd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd004
            #add-point:ON ACTION controlp INFIELD indd004 name="construct.c.page1.indd004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd004  #顯示到畫面上
            NEXT FIELD indd004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd004
            #add-point:BEFORE FIELD indd004 name="construct.b.page1.indd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd004
            
            #add-point:AFTER FIELD indd004 name="construct.a.page1.indd004"
            
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
            LET g_qryparam.arg1 = g_site            
            CALL q_inaa001_4()                           #呼叫開窗
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
            CALL q_inab002_1()                           #呼叫開窗
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
            CALL q_inag006_5()                     #呼叫開窗
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
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003()                           #呼叫開窗
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
         BEFORE FIELD indd103
            #add-point:BEFORE FIELD indd103 name="construct.b.page1.indd103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd103
            
            #add-point:AFTER FIELD indd103 name="construct.a.page1.indd103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd103
            #add-point:ON ACTION controlp INFIELD indd103 name="construct.c.page1.indd103"
            
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
 
 
         #Ctrlp:construct.c.page1.indd104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd104
            #add-point:ON ACTION controlp INFIELD indd104 name="construct.c.page1.indd104"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd104  #顯示到畫面上
            NEXT FIELD indd104                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd104
            #add-point:BEFORE FIELD indd104 name="construct.b.page1.indd104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd104
            
            #add-point:AFTER FIELD indd104 name="construct.a.page1.indd104"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd105
            #add-point:BEFORE FIELD indd105 name="construct.b.page1.indd105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd105
            
            #add-point:AFTER FIELD indd105 name="construct.a.page1.indd105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd105
            #add-point:ON ACTION controlp INFIELD indd105 name="construct.c.page1.indd105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd106
            #add-point:BEFORE FIELD indd106 name="construct.b.page1.indd106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd106
            
            #add-point:AFTER FIELD indd106 name="construct.a.page1.indd106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd106
            #add-point:ON ACTION controlp INFIELD indd106 name="construct.c.page1.indd106"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.indd151
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd151
            #add-point:ON ACTION controlp INFIELD indd151 name="construct.c.page1.indd151"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd151  #顯示到畫面上
            NEXT FIELD indd151                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd151
            #add-point:BEFORE FIELD indd151 name="construct.b.page1.indd151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd151
            
            #add-point:AFTER FIELD indd151 name="construct.a.page1.indd151"
            
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
#            LET g_qryparam.arg1 = g_indc_m.indc006
            CALL q_inaa001_13()                           #呼叫開窗
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
#            LET g_qryparam.arg1 = g_indc_m.indc006
            CALL q_inab002_4()                     #呼叫開窗
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
            
 
 
         #Ctrlp:construct.c.page1.indd041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd041
            #add-point:ON ACTION controlp INFIELD indd041 name="construct.c.page1.indd041"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd041  #顯示到畫面上
            NEXT FIELD indd041                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd041
            #add-point:BEFORE FIELD indd041 name="construct.b.page1.indd041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd041
            
            #add-point:AFTER FIELD indd041 name="construct.a.page1.indd041"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd109
            #add-point:BEFORE FIELD indd109 name="construct.b.page1.indd109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd109
            
            #add-point:AFTER FIELD indd109 name="construct.a.page1.indd109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd109
            #add-point:ON ACTION controlp INFIELD indd109 name="construct.c.page1.indd109"
            
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
 
 
         #Ctrlp:construct.c.page1.indd042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd042
            #add-point:ON ACTION controlp INFIELD indd042 name="construct.c.page1.indd042"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd042  #顯示到畫面上
            NEXT FIELD indd042                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd042
            #add-point:BEFORE FIELD indd042 name="construct.b.page1.indd042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd042
            
            #add-point:AFTER FIELD indd042 name="construct.a.page1.indd042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd043
            #add-point:ON ACTION controlp INFIELD indd043 name="construct.c.page1.indd043"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd043  #顯示到畫面上
            NEXT FIELD indd043                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd043
            #add-point:BEFORE FIELD indd043 name="construct.b.page1.indd043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd043
            
            #add-point:AFTER FIELD indd043 name="construct.a.page1.indd043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd044
            #add-point:ON ACTION controlp INFIELD indd044 name="construct.c.page1.indd044"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbm002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indd044  #顯示到畫面上
            NEXT FIELD indd044                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd044
            #add-point:BEFORE FIELD indd044 name="construct.b.page1.indd044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd044
            
            #add-point:AFTER FIELD indd044 name="construct.a.page1.indd044"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd152
            #add-point:BEFORE FIELD indd152 name="construct.b.page1.indd152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd152
            
            #add-point:AFTER FIELD indd152 name="construct.a.page1.indd152"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indd152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd152
            #add-point:ON ACTION controlp INFIELD indd152 name="construct.c.page1.indd152"
            
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
                  WHEN la_wc[li_idx].tableid = "indc_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "indd_t" 
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
   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF
   LET g_wc = g_wc," AND indc000 = '1' AND indcsite = '",g_site,"'"
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint330_filter()
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
      CONSTRUCT g_wc_filter ON indcdocno,indcdocdt,indc022,indc004,indc101
                          FROM s_browse[1].b_indcdocno,s_browse[1].b_indcdocdt,s_browse[1].b_indc022, 
                              s_browse[1].b_indc004,s_browse[1].b_indc101
 
         BEFORE CONSTRUCT
               DISPLAY aint330_filter_parser('indcdocno') TO s_browse[1].b_indcdocno
            DISPLAY aint330_filter_parser('indcdocdt') TO s_browse[1].b_indcdocdt
            DISPLAY aint330_filter_parser('indc022') TO s_browse[1].b_indc022
            DISPLAY aint330_filter_parser('indc004') TO s_browse[1].b_indc004
            DISPLAY aint330_filter_parser('indc101') TO s_browse[1].b_indc101
      
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
 
      CALL aint330_filter_show('indcdocno')
   CALL aint330_filter_show('indcdocdt')
   CALL aint330_filter_show('indc022')
   CALL aint330_filter_show('indc004')
   CALL aint330_filter_show('indc101')
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint330_filter_parser(ps_field)
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
 
{<section id="aint330.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint330_filter_show(ps_field)
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
   LET ls_condition = aint330_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint330_query()
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
 
   
   #add-point:query段other name="query.other"
   #CALL cl_set_combo_scc('indc002','6016')  #160311-00006#1 mark by lixh 20160311
   CALL cl_set_combo_scc_part('indc002','6016','1,2,3,9,10')   #160311-00006#1 add by lixh 20160311   #160902-00036#1
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aint330_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint330_browser_fill("")
      CALL aint330_fetch("")
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
      CALL aint330_filter_show('indcdocno')
   CALL aint330_filter_show('indcdocdt')
   CALL aint330_filter_show('indc022')
   CALL aint330_filter_show('indc004')
   CALL aint330_filter_show('indc101')
   CALL aint330_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aint330_fetch("F") 
      #顯示單身筆數
      CALL aint330_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint330_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_ooba002  LIKE ooba_t.ooba002
   DEFINE l_ooac004  LIKE ooac_t.ooac004
   DEFINE r_success  LIKE type_t.num5
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
   EXECUTE aint330_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcdocno,g_indc_m.indcdocdt, 
       g_indc_m.indc004,g_indc_m.indcsite,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002, 
       g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc151,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104, 
       g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc106,g_indc_m.indc107,g_indc_m.indc108, 
       g_indc_m.indcownid,g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt, 
       g_indc_m.indcmodid,g_indc_m.indcpstid,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid, 
       g_indc_m.indccnfdt,g_indc_m.indc004_desc,g_indc_m.indc101_desc,g_indc_m.indc006_desc,g_indc_m.indc106_desc, 
       g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc, 
       g_indc_m.indcmodid_desc,g_indc_m.indcpstid_desc,g_indc_m.indccnfid_desc
   
   #遮罩相關處理
   LET g_indc_m_mask_o.* =  g_indc_m.*
   CALL aint330_indc_t_mask()
   LET g_indc_m_mask_n.* =  g_indc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint330_set_act_visible()   
   CALL aint330_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_indc_m.indcstus = 'N' THEN
      CALL cl_set_act_visible("modify", TRUE)
   ELSE
      CALL cl_set_act_visible("modify", FALSE)   
   END IF 
#   CALL s_aooi200_get_slip(g_indc_m.indcdocno) RETURNING r_success,l_ooba002   
#   LET l_ooac004 = ''
#   SELECT ooac004 INTO l_ooac004 FROM ooac_t
#    WHERE ooacent = g_enterprise
#      AND ooac001 = g_ooef004
#      AND ooac002 = l_ooba002
#      AND ooac003 = 'S-BAS-0028' 
#   IF l_ooac004 <> 'Y' THEN   #參考單位
#      CALL cl_set_comp_visible("indd104,indd104_desc,indd105,indd106,indd109",FALSE)
#   ELSE
#      CALL cl_set_comp_visible("indd104,indd104_desc,indd105,indd106,indd109",TRUE)   
#   END IF   
#   LET l_ooac004 = ''
#   SELECT ooac004 INTO l_ooac004 FROM ooac_t
#    WHERE ooacent = g_enterprise
#      AND ooac001 = g_ooef004
#      AND ooac002 = l_ooba002
#      AND ooac003 = 'S-BAS-0036' 
#   IF l_ooac004 <> 'Y' THEN   #產品特征
#      CALL cl_set_comp_visible("indd004",FALSE)
#   ELSE
#      CALL cl_set_comp_visible("indd004",TRUE)   
#   END IF     
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN   
      CALL cl_set_comp_visible("indd104,indd104_desc,indd105,indd106,indd109",FALSE)
   END IF 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN   
      CALL cl_set_comp_visible("indd004",FALSE)
   END IF       
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   IF g_indc_m.indc102 <> '2' OR g_indc_m.indcstus <> 'O' THEN  #撥出方確認
      CALL cl_set_act_visible("gen_qc",FALSE)
   END IF
   IF g_indc_m.indc102 = '2' AND g_indc_m.indcstus = 'O' THEN  #撥出方確認
      CALL cl_set_act_visible("gen_qc",TRUE)
   END IF
   #add by lixh 20150921
   IF g_indc_m.indcstus <> 'N' THEN
      CALL cl_set_act_visible("s_lot_sel", FALSE)
   ELSE
      CALL cl_set_act_visible("s_lot_sel", TRUE)              
   END IF
   #add by lixh 20150921   
   
   #add by lixh 20151231
   IF g_indc_m.indc102 = '2' THEN
      CALL cl_set_act_visible("gen_qc,qc_query",TRUE)
   ELSE   
      CALL cl_set_act_visible("gen_qc,qc_query",FALSE)
   END IF
   #add by lixh 20151231
   
   #end add-point
   
   #保存單頭舊值
   LET g_indc_m_t.* = g_indc_m.*
   LET g_indc_m_o.* = g_indc_m.*
   
   LET g_data_owner = g_indc_m.indcownid      
   LET g_data_dept  = g_indc_m.indcowndp
   
   #重新顯示   
   CALL aint330_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint330_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE   l_success     LIKE type_t.num5
   DEFINE   l_flag        LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_indd_d.clear()   
 
 
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
            LET g_indc_m.indcstus = "N"
      LET g_indc_m.indc002 = "1"
      LET g_indc_m.indc102 = "1"
      LET g_indc_m.indc103 = "N"
      LET g_indc_m.indc104 = "N"
      LET g_indc_m.indc009 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL cl_set_combo_scc_part('indc002','6016','1,2')  
      CALL cl_set_combo_scc_part('indc102','2081','1,2')
      LET g_indc_m.indcdocdt = g_today
      LET g_indc_m.indc004 = g_user
      LET g_indc_m.indc101 = g_dept    
      LET g_indc_m.indc006 = g_site
      LET g_indc_m.indcsite = g_site
      LET g_indc_m.indc022 = g_today    #add by lixh 20150305
      IF NOT cl_null(g_indc_m.indcdocno) THEN  #add by lixh 20150330    
         CALL s_control_chk_doc('1',g_indc_m.indcdocno,'5',g_user,g_dept,'','') RETURNING l_success,l_flag #add by lixh 20150330
         IF l_success THEN   #add by lixh 20150330
            IF l_flag THEN
               LET g_indc_m.indc004 = g_user
               LET g_indc_m.indc101 = g_dept
            END IF
         END IF   #add by lixh 20150330
      END IF      
      LET g_oocq019_t = ''      
      CALL s_desc_get_person_desc(g_indc_m.indc004) RETURNING g_indc_m.indc004_desc
      DISPLAY BY NAME g_indc_m.indc004_desc   
      CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
      DISPLAY BY NAME g_indc_m.indc101_desc 
      CALL s_desc_get_department_desc(g_indc_m.indc006) RETURNING g_indc_m.indc006_desc
      DISPLAY BY NAME g_indc_m.indc006_desc       
      LET g_oofa001 = ''
      SELECT oofa001 INTO g_oofa001 FROM oofa_t 
       WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_indc_m.indc006        
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
 
 
 
    
      CALL aint330_input("a")
      
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
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aint330_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_indd_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint330_set_act_visible()   
   CALL aint330_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_indcdocno_t = g_indc_m.indcdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " indcent = " ||g_enterprise|| " AND",
                      " indcdocno = '", g_indc_m.indcdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint330_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aint330_cl
   
   CALL aint330_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint330_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcdocno,g_indc_m.indcdocdt, 
       g_indc_m.indc004,g_indc_m.indcsite,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002, 
       g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc151,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104, 
       g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc106,g_indc_m.indc107,g_indc_m.indc108, 
       g_indc_m.indcownid,g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt, 
       g_indc_m.indcmodid,g_indc_m.indcpstid,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid, 
       g_indc_m.indccnfdt,g_indc_m.indc004_desc,g_indc_m.indc101_desc,g_indc_m.indc006_desc,g_indc_m.indc106_desc, 
       g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc, 
       g_indc_m.indcmodid_desc,g_indc_m.indcpstid_desc,g_indc_m.indccnfid_desc
   
   
   #遮罩相關處理
   LET g_indc_m_mask_o.* =  g_indc_m.*
   CALL aint330_indc_t_mask()
   LET g_indc_m_mask_n.* =  g_indc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_indc_m.indcdocno,g_indc_m.indcdocdt,g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indcsite, 
       g_indc_m.indcdocno_desc,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indc101_desc,g_indc_m.indcstus, 
       g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc006_desc,g_indc_m.indc151,g_indc_m.indc151_desc, 
       g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104,g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105, 
       g_indc_m.indc105_desc,g_indc_m.l_indc105_desc,g_indc_m.indc106,g_indc_m.indc106_desc,g_indc_m.indc107, 
       g_indc_m.indc107_desc,g_indc_m.indc108,g_indc_m.indc108_desc,g_indc_m.indcownid,g_indc_m.indcownid_desc, 
       g_indc_m.indcowndp,g_indc_m.indcowndp_desc,g_indc_m.indccrtid,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp, 
       g_indc_m.indccrtdp_desc,g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcmodid_desc,g_indc_m.indcpstid, 
       g_indc_m.indcpstid_desc,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid,g_indc_m.indccnfid_desc, 
       g_indc_m.indccnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_indc_m.indcownid      
   LET g_data_dept  = g_indc_m.indcowndp
   
   #功能已完成,通報訊息中心
   CALL aint330_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint330.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint330_modify()
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
   
   OPEN aint330_cl USING g_enterprise,g_indc_m.indcdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint330_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint330_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint330_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcdocno,g_indc_m.indcdocdt, 
       g_indc_m.indc004,g_indc_m.indcsite,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002, 
       g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc151,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104, 
       g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc106,g_indc_m.indc107,g_indc_m.indc108, 
       g_indc_m.indcownid,g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt, 
       g_indc_m.indcmodid,g_indc_m.indcpstid,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid, 
       g_indc_m.indccnfdt,g_indc_m.indc004_desc,g_indc_m.indc101_desc,g_indc_m.indc006_desc,g_indc_m.indc106_desc, 
       g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc, 
       g_indc_m.indcmodid_desc,g_indc_m.indcpstid_desc,g_indc_m.indccnfid_desc
   
   #檢查是否允許此動作
   IF NOT aint330_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_indc_m_mask_o.* =  g_indc_m.*
   CALL aint330_indc_t_mask()
   LET g_indc_m_mask_n.* =  g_indc_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   IF g_indc_m.indcstus <> 'N' THEN
      RETURN
   END IF  
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aint330_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_indcdocno_t = g_indc_m.indcdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_indc_m.indcmodid = g_user 
LET g_indc_m.indcmoddt = cl_get_current()
LET g_indc_m.indcmodid_desc = cl_get_username(g_indc_m.indcmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_indc_m.indcstus MATCHES "[DR]" THEN 
         LET g_indc_m.indcstus = "N"
      END IF

      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aint330_input("u")
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
            CALL aint330_show()
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
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint330_set_act_visible()   
   CALL aint330_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " indcent = " ||g_enterprise|| " AND",
                      " indcdocno = '", g_indc_m.indcdocno, "' "
 
   #填到對應位置
   CALL aint330_browser_fill("")
 
   CLOSE aint330_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint330_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aint330.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint330_input(p_cmd)
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
   DEFINE  r_success             LIKE type_t.num5
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_oocq019             LIKE oocq_t.oocq019
   DEFINE  r_address             STRING   
   DEFINE  l_ooba002             LIKE ooba_t.ooba002
   DEFINE  l_ooac004             LIKE ooac_t.ooac004  
   DEFINE  l_inaa007             LIKE inaa_t.inaa007  
   DEFINE  l_imaf053             LIKE imaf_t.imaf053
   DEFINE  l_imaf054             LIKE imaf_t.imaf054   
   DEFINE  l_ooac002             LIKE ooac_t.ooac002
   DEFINE  l_flag1               LIKE type_t.num5   
   DEFINE  l_imaf101             LIKE imaf_t.imaf101
   DEFINE  l_imaf102             LIKE imaf_t.imaf102  
   DEFINE  l_indd103             LIKE indd_t.indd103  
   DEFINE  l_msg                 STRING
   DEFINE  l_msg1                STRING    
   DEFINE  l_num                 LIKE type_t.num10   
   DEFINE  l_inaa010             LIKE inaa_t.inaa010
   DEFINE  l_qty1                LIKE indd_t.indd031
   DEFINE  l_qty2                LIKE indd_t.indd031    
   DEFINE  l_date                LIKE indc_t.indc022
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_imaf071             LIKE imaf_t.imaf071
   DEFINE  l_imaf081             LIKE imaf_t.imaf081
   DEFINE  l_sum_inao012         LIKE inao_t.inao012
   DEFINE  l_where               STRING  #160204-00004#5 20160223 s983961--add
   DEFINE  l_imaf061             LIKE imaf_t.imaf061  #160519-00022#2
   DEFINE  l_imaf055             LIKE imaf_t.imaf055
   DEFINE  l_chr                 LIKE type_t.chr1     #160523-00030#1
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
   DISPLAY BY NAME g_indc_m.indcdocno,g_indc_m.indcdocdt,g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indcsite, 
       g_indc_m.indcdocno_desc,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indc101_desc,g_indc_m.indcstus, 
       g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc006_desc,g_indc_m.indc151,g_indc_m.indc151_desc, 
       g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104,g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105, 
       g_indc_m.indc105_desc,g_indc_m.l_indc105_desc,g_indc_m.indc106,g_indc_m.indc106_desc,g_indc_m.indc107, 
       g_indc_m.indc107_desc,g_indc_m.indc108,g_indc_m.indc108_desc,g_indc_m.indcownid,g_indc_m.indcownid_desc, 
       g_indc_m.indcowndp,g_indc_m.indcowndp_desc,g_indc_m.indccrtid,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp, 
       g_indc_m.indccrtdp_desc,g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcmodid_desc,g_indc_m.indcpstid, 
       g_indc_m.indcpstid_desc,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid,g_indc_m.indccnfid_desc, 
       g_indc_m.indccnfdt
   
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
   LET g_forupd_sql = "SELECT inddsite,inddseq,indd101,indd001,indd002,indd004,indd022,indd023,indd024, 
       indd102,indd006,indd103,indd021,indd104,indd105,indd106,indd151,indd032,indd033,indd041,indd031, 
       indd109,indd040,indd042,indd043,indd044,indd152 FROM indd_t WHERE inddent=? AND indddocno=? AND  
       inddseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint330_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aint330_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   CALL aint330_set_no_required()
   CALL aint330_set_required()
   #end add-point
   CALL aint330_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_indc_m.indcdocno,g_indc_m.indcdocdt,g_indc_m.indc004,g_indc_m.indcsite,g_indc_m.indc022, 
       g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc151, 
       g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104,g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105, 
       g_indc_m.l_indc105_desc,g_indc_m.indc106,g_indc_m.indc107,g_indc_m.indc108,g_indc_m.indcpstid, 
       g_indc_m.indcpstdt
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   #160902-00036#1-S
   IF p_cmd = 'a' THEN
      CALL cl_set_combo_scc_part('indc002','6016','1,2')
   ELSE
      CALL cl_set_combo_scc_part('indc002','6016','1,2,10') 
   END IF  
   #160902-00036#1-E   
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aint330.input.head" >}
      #單頭段
      INPUT BY NAME g_indc_m.indcdocno,g_indc_m.indcdocdt,g_indc_m.indc004,g_indc_m.indcsite,g_indc_m.indc022, 
          g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc151, 
          g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104,g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105, 
          g_indc_m.l_indc105_desc,g_indc_m.indc106,g_indc_m.indc107,g_indc_m.indc108,g_indc_m.indcpstid, 
          g_indc_m.indcpstdt 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aint330_cl USING g_enterprise,g_indc_m.indcdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint330_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint330_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aint330_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            LET g_indc_m_t.* = g_indc_m.*
            IF p_cmd = 'u' THEN
               SELECT oocq019 INTO g_oocq019_t
                 FROM oocq_t WHERE oocq001='263' AND oocq002= g_indc_m.indc106
                  AND oocqent = g_enterprise #add by geza 20160905 #160905-00007#5                    
            END IF
            #end add-point
            CALL aint330_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcdocno
            
            #add-point:AFTER FIELD indcdocno name="input.a.indcdocno"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_indc_m.indcdocno) THEN 
               CALL s_aooi200_get_slip_desc(g_indc_m.indcdocno) RETURNING g_indc_m.indcdocno_desc
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_indc_m.indcdocno != g_indcdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM indc_t WHERE "||"indcent = '" ||g_enterprise|| "' AND "||"indcdocno = '"||g_indc_m.indcdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               IF g_indc_m.indcdocno <> g_indc_m_o.indcdocno OR cl_null(g_indc_m_o.indcdocno) THEN   #160824-00007#282 161229 by lori add
                  IF NOT s_aooi200_chk_slip(g_site,'',g_indc_m.indcdocno,g_code) THEN
                    #160824-00007#282 161229 by lori mod---(S)
                    #LET g_indc_m.indcdocno = g_indcdocno_t
                     LET g_indc_m.indcdocno = g_indc_m_o.indcdocno
                     DISPLAY BY NAME g_indc_m.indcdocno
                    #160824-00007#282 161229 by lori mod---(E)
                    
                     CALL s_aooi200_get_slip_desc(g_indc_m.indcdocno) RETURNING g_indc_m.indcdocno_desc
                     DISPLAY BY NAME g_indc_m.indcdocno_desc                    
                     NEXT FIELD CURRENT
                  END IF 
#   CALL s_aooi200_get_slip(g_indc_m.indcdocno) RETURNING r_success,l_ooba002   
#   LET l_ooac004 = ''
#   SELECT ooac004 INTO l_ooac004 FROM ooac_t
#    WHERE ooacent = g_enterprise
#      AND ooac001 = g_ooef004
#      AND ooac002 = l_ooba002
#      AND ooac003 = 'S-BAS-0028' 

#   IF l_ooac004 <> 'Y' THEN   #參考單位
#      CALL cl_set_comp_visible("indd104,indd104_desc,indd105,indd106,indd109",FALSE)
#   ELSE
#      CALL cl_set_comp_visible("indd104,indd104_desc,indd105,indd106,indd109",TRUE)   
#   END IF   
#
#   LET l_ooac004 = ''
#   SELECT ooac004 INTO l_ooac004 FROM ooac_t
#    WHERE ooacent = g_enterprise
#      AND ooac001 = g_ooef004
#      AND ooac002 = l_ooba002
#      AND ooac003 = 'S-BAS-0036' 
#   IF l_ooac004 <> 'Y' THEN   #產品特征
#      CALL cl_set_comp_visible("indd004",FALSE)
#   ELSE
#      CALL cl_set_comp_visible("indd004",TRUE)   
#   END IF        
                  IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN   
#                     CALL cl_set_comp_visible("indd104,indd104_desc,indd105,indd106,indd109",FALSE)
                     CALL cl_set_comp_visible("indd104,indd105,indd106,indd109",FALSE)
                  END IF 
                  IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN   
                     CALL cl_set_comp_visible("indd004",FALSE)
                  END IF  
                  
                  CALL s_aooi200_get_slip(g_indc_m.indcdocno) RETURNING l_flag1,l_ooac002
                  CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-BAS-0081') RETURNING l_ooac004
                  IF l_ooac004 = 'Y' THEN
                     LET g_indc_m.indc002 = '2'
                  END IF
                  IF l_ooac004 = 'N' THEN
                     LET g_indc_m.indc002 = '1'
                  END IF   
                  
                  #add by lixh 20150330 
                  CALL s_control_chk_doc('1',g_indc_m.indcdocno,'5',g_user,g_dept,'','') RETURNING l_success,l_flag 
                  IF l_success THEN   
                     IF l_flag THEN
                        LET g_indc_m.indc004 = g_user
                        LET g_indc_m.indc101 = g_dept
                     END IF
                  END IF   
                  #add by lixh 20150330 
                  
                  CALL aint330_get_col_default()   #取得欄位預設值     #161007-00002#1 add
                  
                  CALL aint330_set_entry(p_cmd)
                  CALL aint330_set_no_required()
                  CALL aint330_set_required()                
                  CALL aint330_set_no_entry(p_cmd)        
                  
                  #160204-00004#5 20160222 s983961--add(s)
                  IF (g_indc_m.indcdocno != g_indc_m_o.indcdocno) OR cl_null(g_indc_m_o.indcdocno) THEN
                    LET g_indc_m.indc003 = ''
                    DISPLAY g_indc_m.indc003     
                  END IF                                      
                  #160204-00004#5 20160222 s983961--add(e) 
               END IF   #160824-00007#282 161229 by lori add   
            END IF

            LET g_indc_m_o.indcdocno = g_indc_m.indcdocno  #160204-00004#5 20160222 s983961--add
            
            #160824-00007#282 161229 by lori add---(S)
            LET g_indc_m_o.indc002 = g_indc_m.indc002
            LET g_indc_m_o.indc004 = g_indc_m.indc004
            LET g_indc_m_o.indc101 = g_indc_m.indc101
            #160824-00007#282 161229 by lori add---(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcdocno
            #add-point:BEFORE FIELD indcdocno name="input.b.indcdocno"
            CALL aint330_set_entry(p_cmd)
            CALL aint330_set_no_required()
            CALL aint330_set_required()            
            CALL aint330_set_no_entry(p_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indcdocno
            #add-point:ON CHANGE indcdocno name="input.g.indcdocno"
            
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc004
            
            #add-point:AFTER FIELD indc004 name="input.a.indc004"
            CALL s_desc_get_person_desc(g_indc_m.indc004) RETURNING g_indc_m.indc004_desc
            DISPLAY BY NAME g_indc_m.indc004_desc            
            IF NOT cl_null(g_indc_m.indc004) THEN 
               IF g_indc_m.indc004 <> g_indc_m_o.indc004 OR cl_null(g_indc_m_o.indc004) THEN   #160824-00007#282 161229 by lori add
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_indc_m.indc004
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#19  by 07900 --add-end  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                    #160824-00007#282 161229 by lori mod---(S)
                    #LET g_indc_m.indc004 = g_indc_m_t.indc004
                     LET g_indc_m.indc004 = g_indc_m_o.indc004
                     DISPLAY BY NAME g_indc_m.indc004
                    #160824-00007#282 161229 by lori mod---(E) 
                     CALL s_desc_get_person_desc(g_indc_m.indc004) RETURNING g_indc_m.indc004_desc
                     DISPLAY BY NAME g_indc_m.indc004_desc                  
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_control_chk_doc('1',g_indc_m.indcdocno,'5',g_indc_m.indc004,g_indc_m.indc101,'','') RETURNING l_success,l_flag #add by lixh 20150330
                  IF l_success THEN
                     IF NOT l_flag THEN
                       #160824-00007#282 161229 by lori mod---(S)
                       #LET g_indc_m.indc004 = g_indc_m_t.indc004
                        LET g_indc_m.indc004 = g_indc_m_o.indc004
                        DISPLAY BY NAME g_indc_m.indc004
                       #160824-00007#282 161229 by lori mod---(E) 
                        CALL s_desc_get_person_desc(g_indc_m.indc004) RETURNING g_indc_m.indc004_desc
                        DISPLAY BY NAME g_indc_m.indc004_desc
                        NEXT FIELD CURRENT                     
                     END IF
                  ELSE
                    #160824-00007#282 161229 by lori mod---(S)
                    #LET g_indc_m.indc004 = g_indc_m_t.indc004
                     LET g_indc_m.indc004 = g_indc_m_o.indc004
                     DISPLAY BY NAME g_indc_m.indc004
                    #160824-00007#282 161229 by lori mod---(E) 
                     CALL s_desc_get_person_desc(g_indc_m.indc004) RETURNING g_indc_m.indc004_desc
                     DISPLAY BY NAME g_indc_m.indc004_desc  
                     NEXT FIELD CURRENT                  
                  END IF
               END IF   #160824-00007#282 161229 by lori add   
            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indc004
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_indc_m.indc004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indc004_desc

            LET g_indc_m_o.indc004 = g_indc_m.indc004   #160824-00007#282 161229 by lori add 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc004
            #add-point:BEFORE FIELD indc004 name="input.b.indc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc004
            #add-point:ON CHANGE indc004 name="input.g.indc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indcsite
            #add-point:BEFORE FIELD indcsite name="input.b.indcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indcsite
            
            #add-point:AFTER FIELD indcsite name="input.a.indcsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indcsite
            #add-point:ON CHANGE indcsite name="input.g.indcsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc022
            #add-point:BEFORE FIELD indc022 name="input.b.indc022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc022
            
            #add-point:AFTER FIELD indc022 name="input.a.indc022"
            IF cl_null(g_indc_m.indc022) THEN
                NEXT FIELD indc022
            END IF     
            IF g_indc_m.indc022 <> g_indc_m_o.indc022 OR cl_null(g_indc_m_o.indc022) THEN   #160824-00007#282 161229 by lori add            
               IF NOT cl_null(g_indc_m.indc022) AND NOT cl_null(g_site) THEN
                  #檢查年度不小於成本關賬日期的年度
#                  CALL cl_get_para(g_enterprise,l_indc005,'S-FIN-6012') RETURNING l_date
               
                  CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_date
                  IF g_indc_m.indc022 < l_date THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00225'
                     LET g_errparam.extend = l_date
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                    #160824-00007#282 161229 by lori mod---(S)
                    #LET g_indc_m.indc022 = g_indc_m_t.indc022
                     LET g_indc_m.indc022 = g_indc_m_o.indc022
                     DISPLAY BY NAME g_indc_m.indc022
                    #160824-00007#282 161229 by lori mod---(E) 
                    
                     NEXT FIELD indc022
                  END IF
               END IF  
            END IF   #160824-00007#282 161229 by lori add  

            LET g_indc_m_o.indc022 = g_indc_m.indc022   #160824-00007#282 161229 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc022
            #add-point:ON CHANGE indc022 name="input.g.indc022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc101
            
            #add-point:AFTER FIELD indc101 name="input.a.indc101"
            CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
            DISPLAY BY NAME g_indc_m.indc101_desc            
            IF NOT cl_null(g_indc_m.indc101) THEN 
               IF g_indc_m.indc101 <> g_indc_m_o.indc101 OR cl_null(g_indc_m_o.indc101) THEN   #160824-00007#282 161229 by lori add
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
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
                    #160824-00007#282 161229 by lori mod---(S)
                    #LET g_indc_m.indc101 = g_indc_m_t.indc101
                     LET g_indc_m.indc101 = g_indc_m_o.indc101
                     DISPLAY BY NAME g_indc_m.indc101
                    #160824-00007#282 161229 by lori mod---(E)
                     CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
                     DISPLAY BY NAME g_indc_m.indc101_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_control_chk_doc('1',g_indc_m.indcdocno,'5',g_indc_m.indc004,g_indc_m.indc101,'','') RETURNING l_success,l_flag #add by lixh 20150330
                  IF l_success THEN
                     IF NOT l_flag THEN
                       #160824-00007#282 161229 by lori mod---(S)
                       #LET g_indc_m.indc101 = g_indc_m_t.indc101
                        LET g_indc_m.indc101 = g_indc_m_o.indc101
                        DISPLAY BY NAME g_indc_m.indc101
                       #160824-00007#282 161229 by lori mod---(E)
                        CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
                        DISPLAY BY NAME g_indc_m.indc101_desc                  
                        NEXT FIELD CURRENT                 
                     END IF
                  ELSE
                    #160824-00007#282 161229 by lori mod---(S)
                    #LET g_indc_m.indc101 = g_indc_m_t.indc101
                     LET g_indc_m.indc101 = g_indc_m_o.indc101
                     DISPLAY BY NAME g_indc_m.indc101
                    #160824-00007#282 161229 by lori mod---(E)
                     CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
                     DISPLAY BY NAME g_indc_m.indc101_desc                  
                     NEXT FIELD CURRENT                          
                  END IF                
               END IF   #160824-00007#282 161229 by lori add
            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indc101
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_indc_m.indc101_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indc101_desc

            LET g_indc_m_o.indc101 = g_indc_m.indc101   #160824-00007#282 161229 by lori add
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc002
            #add-point:BEFORE FIELD indc002 name="input.b.indc002"
            CALL aint330_set_entry(p_cmd)
            CALL aint330_set_no_required()
            CALL aint330_set_required()            
            CALL aint330_set_no_entry(p_cmd)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc002
            
            #add-point:AFTER FIELD indc002 name="input.a.indc002"
            IF NOT cl_null(g_indc_m.indc002) THEN
               IF g_indc_m.indc002 <> g_indc_m_o.indc002 OR cl_null(g_indc_m_o.indc002) THEN   #160824-00007#282 161229 by lori add
#                  IF NOT s_azzi650_chk_exist('6016',g_indc_m.indc002) THEN
#                     LET g_indc_m.indc002 = g_indc_m_t.indc002
#                     NEXT FIELD CURRENT
#                  END IF 
                  SELECT COUNT(ooac001) INTO l_cnt FROM ooac_t
                   WHERE ooacent = g_enterprise
                     AND ooac001 = g_ooef004
                     AND ooac002 = g_indc_m.indc002
                     AND ooac003 = 'D-BAS-0081'
                     AND ooac004 = 'Y'
                  IF l_cnt > 0 THEN 
                     LET g_indc_m.indc002 = '2'
                  END IF 
               END IF   #160824-00007#282 161229 by lori add                  
            END IF  
            CALL aint330_set_entry(p_cmd) 
            CALL aint330_set_no_required()
            CALL aint330_set_required()            
            CALL aint330_set_no_entry(p_cmd) 

            LET g_indc_m_o.indc002 = g_indc_m.indc002   #160824-00007#282 161229 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc002
            #add-point:ON CHANGE indc002 name="input.g.indc002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc003
            
            #add-point:AFTER FIELD indc003 name="input.a.indc003"
            IF NOT cl_null(g_indc_m.indc003) THEN 
               IF g_indc_m.indc003 <> g_indc_m_o.indc003 OR cl_null(g_indc_m_o.indc003) THEN   #160824-00007#282 161229 by lori add
                  #160204-00004#5 20160222 s983961--add(s)
                  IF NOT cl_null(g_indc_m.indcdocno) THEN 
                     IF NOT s_aooi210_check_doc(g_site,'', g_indc_m.indc003 , g_indc_m.indcdocno ,'4','') THEN
                       #LET g_indc_m.indc003 = g_indc_m_t.indc003   #160824-00007#282 161229 by lori mark
                        LET g_indc_m.indc003 = g_indc_m_o.indc003   #160824-00007#282 161229 by lori add
                        DISPLAY BY NAME g_indc_m.indc003
                        
                        NEXT FIELD CURRENT               
                     END IF
                  END IF
                  #160204-00004#5 20160222 s983961--add(e)                
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_indc_m.indc003
                  LET g_chkparam.arg2 = g_site
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_indadocno") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理                  
                    #LET g_indc_m.indc003 = g_indc_m_t.indc003   #160824-00007#282 161229 by lori mark
                     LET g_indc_m.indc003 = g_indc_m_o.indc003   #160824-00007#282 161229 by lori add
                     NEXT FIELD CURRENT                  
                  END IF
                  IF g_indc_m.indc002 = '2' THEN
                     CALL aint330_default_indc()               
                  END IF
                  LET g_oofa001 = ''
                  SELECT oofa001 INTO g_oofa001 FROM oofa_t 
                   WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_indc_m.indc006  
               END IF   #160824-00007#282 161229 by lori add                   
            END IF 
            #160202-00004#1 add by lixh 20160202
            CALL aint330_set_entry(p_cmd)
            CALL aint330_set_no_entry(p_cmd)
            #160202-00004#1 add by lixh 20160202
            
            LET g_indc_m_o.indc003 = g_indc_m.indc003   #160824-00007#282 161229 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc003
            #add-point:BEFORE FIELD indc003 name="input.b.indc003"
            CALL aint330_set_entry(p_cmd)
            CALL aint330_set_no_required()
            CALL aint330_set_required()
            CALL aint330_set_no_entry(p_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc003
            #add-point:ON CHANGE indc003 name="input.g.indc003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc006
            
            #add-point:AFTER FIELD indc006 name="input.a.indc006"
            CALL aint330_indc006_ref()
            IF NOT cl_null(g_indc_m.indc006) THEN 
               IF g_indc_m.indc006 <> g_indc_m_o.indc006 OR cl_null(g_indc_m_o.indc006) THEN   #160824-00007#282 161229 by lori mod
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_indc_m.indc006
                   #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#19  by 07900 --add-end     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooef001_13") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                    #160824-00007#282 161229 by lori mod---(S) 
                    #LET g_indc_m.indc006 = g_indc_m_t.indc006
                     LET g_indc_m.indc006 = g_indc_m_o.indc006
                     DISPLAY BY NAME g_indc_m.indc006
                    #160824-00007#282 161229 by lori mod---(E)
                     CALL aint330_indc006_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aint330_indc006_ref()
                  LET g_oofa001 = ''
                  SELECT oofa001 INTO g_oofa001 FROM oofa_t 
                   WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_indc_m.indc006
                END IF   #160824-00007#282 161229 by lori add
            END IF 

            LET g_indc_m_o.indc006 = g_indc_m.indc006   #160824-00007#282 161229 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc006
            #add-point:BEFORE FIELD indc006 name="input.b.indc006"
            CALL aint330_set_entry(p_cmd)
            CALL aint330_set_no_entry(p_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc006
            #add-point:ON CHANGE indc006 name="input.g.indc006"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc151
            
            #add-point:AFTER FIELD indc151 name="input.a.indc151"
            CALL aint330_indc151_ref()
            IF NOT cl_null(g_indc_m.indc151) THEN 
               IF g_indc_m.indc151 <> g_indc_m_o.indc151 OR cl_null(g_indc_m_o.indc151) THEN   #160824-00007#282 161229 by lori add
#此段落由子樣板a19產生
                 #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                 INITIALIZE g_chkparam.* TO NULL
#                 
#                 #設定g_chkparam.*的參數
#                 LET g_chkparam.arg1 = g_acc
#                 LET g_chkparam.arg2 = g_indc_m.indc151
#                    
#                 #呼叫檢查存在並帶值的library
#                 IF cl_chk_exist("v_oocq002_1") THEN
#                    #檢查成功時後續處理
#                    #LET  = g_chkparam.return1
#                    #DISPLAY BY NAME 
#                 ELSE
#                    #檢查失敗時後續處理
#                    LET g_indc_m.indc151 = g_indc_m_t.indc151
#                    CALL aint330_indd151_ref()                  
#                    NEXT FIELD CURRENT
#                 END IF
                  IF NOT s_azzi650_chk_exist(g_acc,g_indc_m.indc151) THEN
                    #160824-00007#282 161229 by lori mod---(S) 
                    #LET g_indc_m.indc151 = g_indc_m_t.indc151
                     LET g_indc_m.indc151 = g_indc_m_o.indc151
                     DISPLAY BY NAME g_indc_m.indc151
                    #160824-00007#282 161229 by lori mod---(E) 
                     CALL aint330_indc151_ref()
                     NEXT FIELD CURRENT
                  END IF                
                  CALL aint330_indc151_ref()
               END IF   #160824-00007#282 161229 by lori add
            END IF 

            LET g_indc_m_o.indc151 = g_indc_m.indc151   #160824-00007#282 161229 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc151
            #add-point:BEFORE FIELD indc151 name="input.b.indc151"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc151
            #add-point:ON CHANGE indc151 name="input.g.indc151"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc102
            #add-point:BEFORE FIELD indc102 name="input.b.indc102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc102
            
            #add-point:AFTER FIELD indc102 name="input.a.indc102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc102
            #add-point:ON CHANGE indc102 name="input.g.indc102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc103
            #add-point:BEFORE FIELD indc103 name="input.b.indc103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc103
            
            #add-point:AFTER FIELD indc103 name="input.a.indc103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc103
            #add-point:ON CHANGE indc103 name="input.g.indc103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc104
            #add-point:BEFORE FIELD indc104 name="input.b.indc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc104
            
            #add-point:AFTER FIELD indc104 name="input.a.indc104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc104
            #add-point:ON CHANGE indc104 name="input.g.indc104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc009
            #add-point:BEFORE FIELD indc009 name="input.b.indc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc009
            
            #add-point:AFTER FIELD indc009 name="input.a.indc009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc009
            #add-point:ON CHANGE indc009 name="input.g.indc009"
            
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc105
            
            #add-point:AFTER FIELD indc105 name="input.a.indc105"
            CALL aint330_indc105_ref()
            IF NOT cl_null(g_indc_m.indc105) THEN 
               IF g_indc_m.indc105 <> g_indc_m_o.indc105 OR cl_null(g_indc_m_o.indc105) THEN   #160824-00007#282 161229 by lori add
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_oofa001
                  LET g_chkparam.arg2 = g_indc_m.indc105
                   #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
                  #160318-00025#19  by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_oofb019_5") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                    #160824-00007#282 161229 by lori mod---(S) 
                    #LET g_indc_m.indc105 = g_indc_m_t.indc105
                     LET g_indc_m.indc105 = g_indc_m_o.indc105
                     DISPLAY BY NAME g_indc_m.indc105
                    #160824-00007#282 161229 by lori mod---(E)  
                     CALL aint330_indc105_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi350_get_address(g_oofa001,g_indc_m.indc105,g_lang)RETURNING r_success,r_address
                  IF r_success THEN
                     LET g_indc_m.l_indc105_desc = r_address   
                     DISPLAY BY NAME g_indc_m.l_indc105_desc                     
                  END IF                 
                  CALL aint330_indc105_ref()
               END IF   #160824-00007#282 161229 by lori add   
            END IF 
            
            LET g_indc_m_o.indc105 = g_indc_m.indc105   #160824-00007#282 161229 by lori add  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc105
            #add-point:BEFORE FIELD indc105 name="input.b.indc105"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc105
            #add-point:ON CHANGE indc105 name="input.g.indc105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc105_desc
            #add-point:BEFORE FIELD indc105_desc name="input.b.indc105_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc105_desc
            
            #add-point:AFTER FIELD indc105_desc name="input.a.indc105_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc105_desc
            #add-point:ON CHANGE indc105_desc name="input.g.indc105_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_indc105_desc
            #add-point:BEFORE FIELD l_indc105_desc name="input.b.l_indc105_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_indc105_desc
            
            #add-point:AFTER FIELD l_indc105_desc name="input.a.l_indc105_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_indc105_desc
            #add-point:ON CHANGE l_indc105_desc name="input.g.l_indc105_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc106
            
            #add-point:AFTER FIELD indc106 name="input.a.indc106"
            CALL aint330_indc106_ref()
            IF NOT cl_null(g_indc_m.indc106) THEN 
               IF g_indc_m.indc106 <> g_indc_m_o.indc106 OR g_indc_m_o.indc106 IS NULL THEN   #160824-00007#282 161229 by lori add
#此段落由子樣板a19產生
                 #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                 INITIALIZE g_chkparam.* TO NULL
#                 
#                 #設定g_chkparam.*的參數
#                 LET g_chkparam.arg2 = '參數2'
#                    
#                 #呼叫檢查存在並帶值的library
#                 IF cl_chk_exist("v_oocq002_1") THEN
#                    #檢查成功時後續處理
#                    #LET  = g_chkparam.return1
#                    #DISPLAY BY NAME 
#                 ELSE
#                    #檢查失敗時後續處理
#                    NEXT FIELD CURRENT
#                 END IF
                  IF NOT s_azzi650_chk_exist('263',g_indc_m.indc106) THEN
                    #160824-00007#282 161229 by lori mod---(S)
                    #LET g_indc_m.indc106 = g_indc_m_t.indc006
                     LET g_indc_m.indc106 = g_indc_m_o.indc106
                     DISPLAY BY NAME g_indc_m.indc106
                    #160824-00007#282 161229 by lori mod---(E) 
                     CALL aint330_indc106_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aint330_indc106_ref()   
                  
                 #IF g_indc_m.indc106 <> g_indc_m_t.indc106 OR g_indc_m_t.indc106 IS NULL THEN   #160824-00007#282 161229 by lori mark
                     SELECT oocq019 INTO l_oocq019
                       FROM oocq_t WHERE oocq001='263' AND oocq002= g_indc_m.indc106 
                        AND oocqent = g_enterprise #add by geza 20160905 #160905-00007#5                      
                     IF g_oocq019_t <> l_oocq019 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'ain-00260'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                 
                           LET g_indc_m.indc107 = ''
                           LET g_indc_m.indc107_desc = ''
                           DISPLAY BY NAME g_indc_m.indc107,g_indc_m.indc107_desc    
                           LET g_indc_m.indc108 = ''
                           LET g_indc_m.indc108_desc = ''
                           DISPLAY BY NAME g_indc_m.indc108,g_indc_m.indc108_desc                        
                     END IF                       
                     IF NOT cl_null(g_indc_m.indc107) THEN 
#                        CALL aint330_location_chk(g_indc_m.indc107,l_oocq019)
#                        IF NOT cl_null(g_errno) THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = g_errno
#                           LET g_errparam.extend = g_indc_m.indc107
#                           LET g_errparam.popup = TRUE
#                           CALL cl_err()
#                
#                           LET g_indc_m.indc107 = ''
#                           LET g_indc_m.indc107_desc = ''
#                           DISPLAY BY NAME g_indc_m.indc107,g_indc_m.indc107_desc                        
#                           NEXT FIELD indc107
#                        END IF      
                         CALL s_apmi011_check_location(g_indc_m.indc106,g_indc_m.indc107) RETURNING r_success
                         IF NOT r_success THEN
                            LET g_indc_m.indc107 = ''
                            LET g_indc_m.indc107_desc = ''
                            DISPLAY BY NAME g_indc_m.indc107,g_indc_m.indc107_desc  
                            NEXT FIELD indc107
                         END IF 
                     END IF
                     IF NOT cl_null(g_indc_m.indc108) THEN  
#                        CALL aint330_location_chk(g_indc_m.indc108,l_oocq019)
#                        IF NOT cl_null(g_errno) THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = g_errno
#                           LET g_errparam.extend = g_indc_m.indc108
#                           LET g_errparam.popup = TRUE
#                           CALL cl_err()
#                
#                           LET g_indc_m.indc108 = ''
#                           LET g_indc_m.indc108_desc = ''
#                           DISPLAY BY NAME g_indc_m.indc108,g_indc_m.indc108_desc
#                           NEXT FIELD indc108
#                        END IF   
                         CALL s_apmi011_check_location(g_indc_m.indc106,g_indc_m.indc108) RETURNING r_success
                         IF NOT r_success THEN   
                            LET g_indc_m.indc108 = ''
                            LET g_indc_m.indc108_desc = ''
                            DISPLAY BY NAME g_indc_m.indc108,g_indc_m.indc108_desc                      
                            NEXT FIELD indc108
                         END IF
                     END IF 
                     LET g_oocq019_t = l_oocq019                   
                 #END IF   #160824-00007#282 161229 by lori mark
               END IF      #160824-00007#282 161229 by lori add     
            END IF 

            #160824-00007#282 161229 by lori add---(S)
            LET g_indc_m_o.indc106 = g_indc_m.indc106 
            LET g_indc_m_o.indc107 = g_indc_m.indc107 
            LET g_indc_m_o.indc108 = g_indc_m.indc108 
            #160824-00007#282 161229 by lori add---(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc106
            #add-point:BEFORE FIELD indc106 name="input.b.indc106"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc106
            #add-point:ON CHANGE indc106 name="input.g.indc106"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc107
            
            #add-point:AFTER FIELD indc107 name="input.a.indc107"
#            CALL aint330_indc107_desc(g_indc_m.indc107) RETURNING g_indc_m.indc107_desc
#            DISPLAY BY NAME g_indc_m.indc107_desc
            CALL s_apmi011_location_ref(g_indc_m.indc106,g_indc_m.indc107) RETURNING g_indc_m.indc107_desc
            DISPLAY BY NAME g_indc_m.indc107,g_indc_m.indc107_desc
            IF NOT cl_null(g_indc_m.indc106) THEN  #運輸類型
#               CALL aint330_location_chk(g_indc_m.indc107,l_oocq019)
#
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_indc_m.indc107
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  LET g_indc_m.indc107 = g_indc_m_t.indc107
#                  CALL aint330_indc107_desc(g_indc_m.indc107) RETURNING g_indc_m.indc107_desc
#                  DISPLAY BY NAME g_indc_m.indc107_desc
#                  NEXT FIELD CURRENT
#               END IF
                CALL s_apmi011_check_location(g_indc_m.indc106,g_indc_m.indc107) RETURNING r_success
                IF NOT r_success THEN
                   LET g_indc_m.indc107 = g_indc_m_t.indc107
                   CALL s_apmi011_location_ref(g_indc_m.indc106,g_indc_m.indc107) RETURNING g_indc_m.indc107_desc
                   DISPLAY BY NAME g_indc_m.indc107,g_indc_m.indc107_desc                   
                   NEXT FIELD indc107
                END IF 
            ELSE
               IF NOT cl_null(g_indc_m.indc107) OR NOT cl_null(g_indc_m.indc108) THEN               
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00085'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #請先輸入運輸方式
                  NEXT FIELD indc106
               END IF
            END IF
            CALL s_apmi011_location_ref(g_indc_m.indc106,g_indc_m.indc107) RETURNING g_indc_m.indc107_desc
            DISPLAY BY NAME g_indc_m.indc107,g_indc_m.indc107_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc107
            #add-point:BEFORE FIELD indc107 name="input.b.indc107"
#            IF cl_null(g_indc_m.indc106) THEN  #運輸類型 
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'axm-00085'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               #請先輸入運輸方式   
#               NEXT FIELD indc106
#            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc107
            #add-point:ON CHANGE indc107 name="input.g.indc107"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indc108
            
            #add-point:AFTER FIELD indc108 name="input.a.indc108"
#            CALL aint330_indc107_desc(g_indc_m.indc108) RETURNING g_indc_m.indc108_desc
#            DISPLAY BY NAME g_indc_m.indc108_desc
            CALL s_apmi011_location_ref(g_indc_m.indc106,g_indc_m.indc108) RETURNING g_indc_m.indc108_desc
            DISPLAY BY NAME g_indc_m.indc108,g_indc_m.indc108_desc 
            IF NOT cl_null(g_indc_m.indc107) THEN
               IF NOT cl_null(g_indc_m.indc106) THEN               #運輸類型
#                  CALL aint330_location_chk(g_indc_m.indc108,l_oocq019)
#
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_indc_m.indc108
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_indc_m.indc108 = g_indc_m_t.indc108
#                     CALL aint330_indc107_desc(g_indc_m.indc108) RETURNING g_indc_m.indc108_desc
#                     DISPLAY BY NAME g_indc_m.indc108_desc                     
#                     NEXT FIELD CURRENT
#                  END IF
                  CALL s_apmi011_check_location(g_indc_m.indc106,g_indc_m.indc108) RETURNING r_success
                  IF NOT r_success THEN
                     LET g_indc_m.indc108 = g_indc_m_t.indc108
                     CALL s_apmi011_location_ref(g_indc_m.indc106,g_indc_m.indc108) RETURNING g_indc_m.indc108_desc
                     DISPLAY BY NAME g_indc_m.indc108,g_indc_m.indc108_desc
                     NEXT FIELD indc107
                  END IF 
               ELSE
                  IF NOT cl_null(g_indc_m.indc107) OR NOT cl_null(g_indc_m.indc108) THEN      
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00085'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #請先輸入運輸方式
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_apmi011_location_ref(g_indc_m.indc106,g_indc_m.indc108) RETURNING g_indc_m.indc108_desc
            DISPLAY BY NAME g_indc_m.indc108,g_indc_m.indc108_desc           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indc108
            #add-point:BEFORE FIELD indc108 name="input.b.indc108"
#            IF cl_null(g_indc_m.indc106) THEN  #運輸類型 
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'axm-00085'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#   #請先輸入運輸方式   
#               NEXT FIELD indc106
#            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indc108
            #add-point:ON CHANGE indc108 name="input.g.indc108"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.indcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcdocno
            #add-point:ON ACTION controlp INFIELD indcdocno name="input.c.indcdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            CALL aint330_get_ooef004() RETURNING g_ooef004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indcdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004
            #160705-00001 by whitney modify start
            #LET g_qryparam.arg2 = "aint330" #
            LET g_qryparam.arg2 = g_prog
            #160705-00001 by whitney modify end
            #160711-00040#15 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#15 add(e)
            CALL q_ooba002_8()                                #呼叫開窗

            LET g_indc_m.indcdocno = g_qryparam.return1              

            DISPLAY g_indc_m.indcdocno TO indcdocno              #

            NEXT FIELD indcdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indcdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcdocdt
            #add-point:ON ACTION controlp INFIELD indcdocdt name="input.c.indcdocdt"
            
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
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_indc_m.indc004 = g_qryparam.return1              

            DISPLAY g_indc_m.indc004 TO indc004              #

            NEXT FIELD indc004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcsite
            #add-point:ON ACTION controlp INFIELD indcsite name="input.c.indcsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc022
            #add-point:ON ACTION controlp INFIELD indc022 name="input.c.indc022"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc101
            #add-point:ON ACTION controlp INFIELD indc101 name="input.c.indc101"
            #此段落由子樣板a07產生            
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

            NEXT FIELD indc101                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indcstus
            #add-point:ON ACTION controlp INFIELD indcstus name="input.c.indcstus"
            
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
            #160204-00004#5 20160223 s983961--add(s)
            IF NOT cl_null(g_indc_m.indcdocno) THEN
               LET l_success = ''
               LET l_where = ''
               CALL s_aooi210_get_check_sql(g_site,'', g_indc_m.indcdocno ,'4','','indadocno') RETURNING l_success,l_where
               IF l_success AND NOT cl_null(l_where) THEN
                  LET g_qryparam.where = l_where
                  CALL q_indadocno_3()                                #呼叫開窗
               END IF
            END IF
            #160204-00004#5 20160223 s983961--add(e)            
            #CALL q_indadocno_3()                                #呼叫開窗  #160204-00004#5 20160223 s983961--mark

            LET g_indc_m.indc003 = g_qryparam.return1              

            DISPLAY g_indc_m.indc003 TO indc003              #

            NEXT FIELD indc003                          #返回原欄位


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
            
#            CALL q_ooef001_12()                            #呼叫開窗    #161019-00017#8 marked
            CALL q_ooef001_1()                            #呼叫開窗    #161019-00017#8 add

            LET g_indc_m.indc006 = g_qryparam.return1              

            DISPLAY g_indc_m.indc006 TO indc006              #

            NEXT FIELD indc006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc151
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc151
            #add-point:ON ACTION controlp INFIELD indc151 name="input.c.indc151"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indc151             #給予default值
            LET g_qryparam.default2 = "" #g_indc_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = g_acc
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_indc_m.indc151 = g_qryparam.return1              
            DISPLAY g_indc_m.indc151 TO indc151              #
            NEXT FIELD indc151                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc102
            #add-point:ON ACTION controlp INFIELD indc102 name="input.c.indc102"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc103
            #add-point:ON ACTION controlp INFIELD indc103 name="input.c.indc103"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc104
            #add-point:ON ACTION controlp INFIELD indc104 name="input.c.indc104"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc009
            #add-point:ON ACTION controlp INFIELD indc009 name="input.c.indc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc008
            #add-point:ON ACTION controlp INFIELD indc008 name="input.c.indc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc105
            #add-point:ON ACTION controlp INFIELD indc105 name="input.c.indc105"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indc105             #給予default值
#            LET g_qryparam.where = " oofb008 = '2' "    
            #給予arg
            LET g_qryparam.arg1 = g_oofa001            
            CALL q_oofb019_3()                                     #呼叫開窗

            LET g_indc_m.indc105 = g_qryparam.return1              

            DISPLAY g_indc_m.indc105 TO indc105              #

            NEXT FIELD indc105                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc105_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc105_desc
            #add-point:ON ACTION controlp INFIELD indc105_desc name="input.c.indc105_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_indc105_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_indc105_desc
            #add-point:ON ACTION controlp INFIELD l_indc105_desc name="input.c.l_indc105_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.indc106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc106
            #add-point:ON ACTION controlp INFIELD indc106 name="input.c.indc106"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indc_m.indc106             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "263" 

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_indc_m.indc106 = g_qryparam.return1              

            DISPLAY g_indc_m.indc106 TO indc106              #

            NEXT FIELD indc106                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indc107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc107
            #add-point:ON ACTION controlp INFIELD indc107 name="input.c.indc107"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indc_m.indc107

            IF NOT cl_null(g_indc_m.indc107) THEN
               SELECT oocq019 INTO l_oocq019
                 FROM oocq_t WHERE oocq001='263' AND oocq002= g_indc_m.indc107
                  AND oocqent = g_enterprise #add by geza 20160905 #160905-00007#5                   
            END IF

            IF NOT cl_null(l_oocq019) THEN  #運輸類型
               CASE
                  WHEN l_oocq019 ='1' OR l_oocq019='4'
                     #CALL q_oock004()    161229-00002#1
                     #161229-00002#1-S
                     LET g_qryparam.arg1 = "315"
                     CALL q_oocq002()
                     #161229-00002#1-E

                  WHEN l_oocq019 ='2'
                     CALL q_oocq002_10()

                  WHEN l_oocq019 ='3'
                     CALL q_oocq002_12()

               END CASE
            END IF


            LET g_indc_m.indc107 = g_qryparam.return1              #將開窗取得的值回傳到變數       
            DISPLAY g_indc_m.indc107 TO indc107
            NEXT FIELD indc107
            #END add-point
 
 
         #Ctrlp:input.c.indc108
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indc108
            #add-point:ON ACTION controlp INFIELD indc108 name="input.c.indc108"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indc_m.indc108

            IF NOT cl_null(g_indc_m.indc108) THEN
               SELECT oocq019 INTO l_oocq019
                 FROM oocq_t WHERE oocq001='263' AND oocq002= g_indc_m.indc108
                  AND oocqent = g_enterprise #add by geza 20160905 #160905-00007#5                  
            END IF

            IF NOT cl_null(l_oocq019) THEN  #運輸類型
               CASE
                  WHEN l_oocq019 ='1' OR l_oocq019='4'
                     #CALL q_oock004()    161229-00002#1
                     #161229-00002#1-S
                     LET g_qryparam.arg1 = "315"
                     CALL q_oocq002()
                     #161229-00002#1-E

                  WHEN l_oocq019 ='2'
                     CALL q_oocq002_10()

                  WHEN l_oocq019 ='3'
                     CALL q_oocq002_12()

               END CASE
            END IF


            LET g_indc_m.indc108 = g_qryparam.return1              #將開窗取得的值回傳到變數       
            DISPLAY g_indc_m.indc108 TO indc108
            NEXT FIELD indc108
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
               CALL s_aooi200_gen_docno(g_site,g_indc_m.indcdocno,g_indc_m.indcdocdt,g_prog) 
                    RETURNING r_success,g_indc_m.indcdocno
                       
               IF NOT r_success THEN 
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF  
               #end add-point
               
               INSERT INTO indc_t (indcent,indcdocno,indcdocdt,indc004,indcsite,indc022,indc101,indcstus, 
                   indc002,indc003,indc006,indc151,indc102,indc103,indc104,indc009,indc008,indc105,indc106, 
                   indc107,indc108,indcownid,indcowndp,indccrtid,indccrtdp,indccrtdt,indcmodid,indcpstid, 
                   indcmoddt,indcpstdt,indccnfid,indccnfdt)
               VALUES (g_enterprise,g_indc_m.indcdocno,g_indc_m.indcdocdt,g_indc_m.indc004,g_indc_m.indcsite, 
                   g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002,g_indc_m.indc003, 
                   g_indc_m.indc006,g_indc_m.indc151,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104, 
                   g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc106,g_indc_m.indc107, 
                   g_indc_m.indc108,g_indc_m.indcownid,g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp, 
                   g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcpstid,g_indc_m.indcmoddt,g_indc_m.indcpstdt, 
                   g_indc_m.indccnfid,g_indc_m.indccnfdt) 
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
               UPDATE indc_t SET indc000 = '1',
                                 indc005 = g_site,
                                 indcsite = g_site
                WHERE indcent = g_enterprise
                  AND indcdocno = g_indc_m.indcdocno
               IF SQLCA.sqlerrd[3] = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_indc_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG                  
               END IF               
               IF g_indc_m.indc002 = '2' THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM indb_t
                   WHERE indbent = g_enterprise
                     AND indbdocno = g_indc_m.indc003
                     AND (indb008 > indb011 OR indb011 IS NULL)
                     AND indb008 > 0   #161013-00028#1
                  IF cl_null(l_cnt) THEN 
                     LET l_cnt = 0
                  END IF
                  #161013-00028#1-S
                  IF l_cnt = 0 THEN
                     SELECT COUNT(*) INTO l_cnt FROM indb_t
                      WHERE indbent = g_enterprise
                        AND indbdocno = g_indc_m.indc003
                        AND (indb008 < indb011 OR indb011 IS NULL)
                        AND indb008 < 0       
                     IF cl_null(l_cnt) THEN 
                        LET l_cnt = 0
                     END IF                        
                  END IF
                  #161013-00028#1-E
                  IF l_cnt > 0 THEN
                     IF cl_ask_confirm('ain-00186') THEN
                        CALL aint330_auto_gene_detail() 
                     END IF 
                     CALL aint330_b_fill()
                  END IF                                                           
               END IF
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aint330_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aint330_b_fill()
                  CALL aint330_b_fill2('0')
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
               CALL aint330_indc_t_mask_restore('restore_mask_o')
               
               UPDATE indc_t SET (indcdocno,indcdocdt,indc004,indcsite,indc022,indc101,indcstus,indc002, 
                   indc003,indc006,indc151,indc102,indc103,indc104,indc009,indc008,indc105,indc106,indc107, 
                   indc108,indcownid,indcowndp,indccrtid,indccrtdp,indccrtdt,indcmodid,indcpstid,indcmoddt, 
                   indcpstdt,indccnfid,indccnfdt) = (g_indc_m.indcdocno,g_indc_m.indcdocdt,g_indc_m.indc004, 
                   g_indc_m.indcsite,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002, 
                   g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc151,g_indc_m.indc102,g_indc_m.indc103, 
                   g_indc_m.indc104,g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc106, 
                   g_indc_m.indc107,g_indc_m.indc108,g_indc_m.indcownid,g_indc_m.indcowndp,g_indc_m.indccrtid, 
                   g_indc_m.indccrtdp,g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcpstid,g_indc_m.indcmoddt, 
                   g_indc_m.indcpstdt,g_indc_m.indccnfid,g_indc_m.indccnfdt)
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
               CALL aint330_indc_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aint330.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_indd_d FROM s_detail1.*
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
               #add by lixh 20150921

               IF NOT cl_null(l_ac) AND g_indc_m.indcstus = 'N' THEN
#                  SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t ##160413-00011#4 2016-4-13 zhujing mod
                  SELECT imaf071,imaf081,imaf053,imaf054 INTO l_imaf071,l_imaf081,l_imaf053,l_imaf054 FROM imaf_t ##160413-00011#4 2016-4-13 zhujing add
                   WHERE imafent = g_enterprise
                     AND imafsite = g_site
                     AND imaf001 = g_indd_d[l_ac].indd002
                  IF l_imaf071 = '1' OR l_imaf081 = '1' THEN  
                     LET l_success = ''  
                     IF g_indd_d[g_detail_idx].indd103 > 0 THEN   #161013-00028#1                  
                        CALL s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                         g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                         g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') 
                             RETURNING l_success  
                     END IF    #161013-00028#1                      
                     #161013-00028#1-S
                     IF g_indd_d[g_detail_idx].indd103 < 0 THEN
                        CALL s_aint330_lot_sel('1','2',g_indc_m.indc006,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                         g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                         g_indd_d[l_ac].indd103,'-1','aint330',g_site,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033)                                                                                       
                           RETURNING l_success 
                     END IF
                     #161013-00028#1-E                          
                     LET l_sum_inao012 = 0   
                     SELECT SUM(inao012) INTO l_sum_inao012 FROM inao_t
                      WHERE inaoent = g_enterprise
                        AND inaodocno = g_indc_m.indcdocno
                        AND inaoseq = g_indd_d[l_ac].inddseq
                        AND inao000 = '2'
                        AND inao013 = '-1'
                     ##160413-00011#4 2016-4-13 zhujing marked---(S)
                     #add by lixh 20151022
#                     SELECT imaf053,imaf054 INTO l_imaf053,l_imaf054 FROM imaf_t
#                      WHERE imafent = g_enterprise
#                        AND imafsite = g_site
#                        AND imaf001 = g_indd_d[g_detail_idx].indd002
                     ##160413-00011#4 2016-4-13 zhujing marked---(E)
                     IF l_imaf054 = 'N' THEN
                           CALL s_aooi250_convert_qty(g_indd_d[g_detail_idx].indd002,l_imaf053,
                                                      g_indd_d[g_detail_idx].indd006,l_sum_inao012) 
                                RETURNING l_success,l_sum_inao012                                                      
                     END IF                     
                     #add by lixh 20151022                        
                     IF g_indd_d[l_ac].indd103 <> l_sum_inao012 THEN
                        IF cl_ask_confirm('ain-00249') THEN
                           LET g_indd_d[l_ac].indd103 = l_sum_inao012 
                           CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,
                                                      g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd103)
                                                      
                            RETURNING l_success,g_indd_d[l_ac].indd105  
                           
                           IF g_indc_m.indc102 = '1' THEN
                              LET g_indd_d[l_ac].indd021 = g_indd_d[l_ac].indd103
                              LET g_indd_d[l_ac].indd031 = g_indd_d[l_ac].indd103
                              CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,
                                                         g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd021)
                                                         
                               RETURNING l_success,g_indd_d[l_ac].indd106                                 
                           ELSE
                              LET g_indd_d[l_ac].indd021 = 0
                              LET g_indd_d[l_ac].indd031 = 0
                              LET g_indd_d[l_ac].indd106 = 0
                           END IF  
                           UPDATE indd_t SET indd103 = g_indd_d[l_ac].indd103,
                                             indd105 = g_indd_d[l_ac].indd105, 
                                             indd021 = g_indd_d[l_ac].indd021,
                                             indd106 = g_indd_d[l_ac].indd106,
                                             indd031 = g_indd_d[l_ac].indd031 
                            WHERE inddent = g_enterprise
                              AND indddocno = g_indc_m.indcdocno
                              AND inddseq = g_indd_d[l_ac].inddseq
                              
                        END IF 
                     END IF                        
                  END IF
               END IF 
               #add by lixh 20150921    
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aint330_02
            LET g_action_choice="open_aint330_02"
            IF cl_auth_chk_act("open_aint330_02") THEN
               
               #add-point:ON ACTION open_aint330_02 name="input.detail_input.page1.open_aint330_02"
               #160523-00030#1-s
               CALL aint330_open_aint330_02() RETURNING l_success,l_chr
               IF NOT l_success THEN
                  CALL aint330_02(g_indc_m.indcdocno,l_chr)
                  CALL aint330_b_fill()
                  LET INT_FLAG = 0
                  EXIT DIALOG
               END IF
               #160523-00030#1-e
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #161007-00012#2-s-add
            LET g_para_in_1 = cl_get_para(g_enterprise,g_indc_m.indc006,'S-BAS-0043')  #VMI存貨庫位Tag(撥入倉)
            LET g_para_in_2 = cl_get_para(g_enterprise,g_indc_m.indc006,'S-BAS-0044')  #VMI結算庫位Tag(撥入倉)    
            LET g_para_out_1 = cl_get_para(g_enterprise,g_site,'S-BAS-0043')           #VMI存貨庫位Tag(撥出倉)
            LET g_para_out_2 = cl_get_para(g_enterprise,g_site,'S-BAS-0044')           #VMI結算庫位Tag(撥出倉) 
            #161007-00012#2-e-add
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_indd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint330_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_indd_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            #160523-00030#1-s
            SELECT count(1) INTO l_cnt
              FROM indd_t,indc_t
             WHERE indcent = inddent
               AND indcdocno = indddocno
               AND indcent = g_enterprise 
               AND indcdocno = g_indc_m.indcdocno 
            IF l_cnt  = 0 AND g_indc_m.indc002 = '1' THEN
               CALL aint330_open_aint330_02() RETURNING l_success,l_chr
               IF NOT l_success THEN
                  CALL aint330_02(g_indc_m.indcdocno,l_chr)
                  CALL aint330_b_fill()
                  LET INT_FLAG = 0
                  EXIT DIALOG
               END IF
            END IF
            #160523-00030#1-e
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
            OPEN aint330_cl USING g_enterprise,g_indc_m.indcdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint330_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint330_cl
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
               CALL aint330_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               CALL aint330_set_no_required_b()
               CALL aint330_set_required_b()
               #161007-00012#2-s-add
               LET g_indd022_type = ''
               LET g_indd032_type = ''
               IF NOT cl_null(g_indd_d[l_ac].indd022) THEN
                  CALL s_aint320_vmi_type(g_site,g_indd_d[l_ac].indd022) RETURNING g_indd022_type  
               END IF
               IF NOT cl_null(g_indd_d[l_ac].indd032) THEN
                  CALL s_aint320_vmi_type(g_indc_m.indc006,g_indd_d[l_ac].indd032) RETURNING g_indd032_type  
               END IF
               #161007-00012#2-e-add
               #end add-point  
               CALL aint330_set_no_entry_b(l_cmd)
               IF NOT aint330_lock_b("indd_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint330_bcl INTO g_indd_d[l_ac].inddsite,g_indd_d[l_ac].inddseq,g_indd_d[l_ac].indd101, 
                      g_indd_d[l_ac].indd001,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd022, 
                      g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd006, 
                      g_indd_d[l_ac].indd103,g_indd_d[l_ac].indd021,g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd105, 
                      g_indd_d[l_ac].indd106,g_indd_d[l_ac].indd151,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033, 
                      g_indd_d[l_ac].indd041,g_indd_d[l_ac].indd031,g_indd_d[l_ac].indd109,g_indd_d[l_ac].indd040, 
                      g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd043,g_indd_d[l_ac].indd044,g_indd_d[l_ac].indd152 
 
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
                  CALL aint330_indd_t_mask()
                  LET g_indd_d_mask_n[l_ac].* =  g_indd_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint330_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd = 'a' THEN
               INITIALIZE g_indd_d_t.* TO NULL 
               INITIALIZE g_indd_d_o.* TO NULL             
            END IF
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
                  LET g_indd_d[l_ac].indd103 = "0"
      LET g_indd_d[l_ac].indd021 = "0"
      LET g_indd_d[l_ac].indd105 = "0"
      LET g_indd_d[l_ac].indd106 = "0"
      LET g_indd_d[l_ac].indd031 = "0"
      LET g_indd_d[l_ac].indd109 = "0"
      LET g_indd_d[l_ac].indd040 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #LET g_indd_d[l_ac].indd004 = ' '   #add by lixh 20150619  #160804-00013#1 #mark
            #end add-point
            LET g_indd_d_t.* = g_indd_d[l_ac].*     #新輸入資料
            LET g_indd_d_o.* = g_indd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint330_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            #160519-00008#4-s
            CALL aint330_set_no_required_b()
            CALL aint330_set_required_b()
            #160519-00008#4-e
            #end add-point
            CALL aint330_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_indd_d[li_reproduce_target].* = g_indd_d[li_reproduce].*
 
               LET g_indd_d[li_reproduce_target].inddseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF l_ac > 1 THEN
               LET g_indd_d[l_ac].indd151 = g_indd_d[l_ac-1].indd151
            END IF 
            IF cl_null(g_indd_d[l_ac].indd151) THEN         
               LET g_indd_d[l_ac].indd151 = g_indc_m.indc151
            END IF   
            CALL aint330_indd151_ref()
            LET g_indd_d[l_ac].inddsite = g_site
            IF cl_null(g_indd_d[l_ac].inddseq) THEN
               SELECT MAX(inddseq+1) INTO g_indd_d[l_ac].inddseq FROM indd_t
                WHERE inddent = g_enterprise
                  AND indddocno = g_indc_m.indcdocno
               IF cl_null(g_indd_d[l_ac].inddseq) THEN 
                  LET g_indd_d[l_ac].inddseq = 1
               END IF                  
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
            SELECT COUNT(1) INTO l_count FROM indd_t 
             WHERE inddent = g_enterprise AND indddocno = g_indc_m.indcdocno
 
               AND inddseq = g_indd_d[l_ac].inddseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_indc_m.indcdocno
               LET gs_keys[2] = g_indd_d[g_detail_idx].inddseq
               CALL aint330_insert_b('indd_t',gs_keys,"'1'")
                           
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
               #CALL aint330_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               CALL s_lot_b_fill('1',g_site,'2',g_indc_m.indcdocno,g_indd_d[g_detail_idx].inddseq,0,'-1')   #add by lixh 20150901
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
               LET gs_keys[01] = g_indc_m.indcdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_indd_d_t.inddseq
 
            
               #刪除同層單身
               IF NOT aint330_delete_b('indd_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint330_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint330_key_delete_b(gs_keys,'indd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint330_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aint330_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  INITIALIZE g_indd_d_t.* TO NULL 
                  INITIALIZE g_indd_d_o.* TO NULL                   
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
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM indd_t WHERE "||"inddent = '" ||g_enterprise|| "' AND "||"indddocno = '"||g_indc_m.indcdocno ||"' AND "|| "inddseq = '"||g_indd_d[g_detail_idx].inddseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inddseq
            #add-point:BEFORE FIELD inddseq name="input.b.page1.inddseq"
            #add by lixh 20141231(S)
#            LET l_insert = TRUE
#            LET l_n = ARR_COUNT()
#            LET l_cmd = 'a'
#            INITIALIZE g_indd_d[l_ac].* TO NULL 
#            INITIALIZE g_indd_d_t.* TO NULL 
#            INITIALIZE g_indd_d_o.* TO NULL 
#            #公用欄位給值(單身)
#            
#            #自定義預設值
#                  LET g_indd_d[l_ac].indd040 = "N"
# 
#            #add-point:modify段before備份
#
#            #end add-point
#            LET g_indd_d_t.* = g_indd_d[l_ac].*     #新輸入資料
#            LET g_indd_d_o.* = g_indd_d[l_ac].*     #新輸入資料
#            CALL cl_show_fld_cont()
#            CALL aint330_set_entry_b(l_cmd)
#            #add-point:modify段after_set_entry_b
#
#            #end add-point
#            CALL aint330_set_no_entry_b(l_cmd)
#            IF lb_reproduce THEN
#               LET lb_reproduce = FALSE
#               LET g_indd_d[li_reproduce_target].* = g_indd_d[li_reproduce].*
# 
#               LET g_indd_d[li_reproduce_target].inddseq = NULL
# 
#            END IF            
            #add by lixh 20141231(E)
            
            IF cl_null(g_indd_d[l_ac].inddseq) THEN
               SELECT MAX(inddseq+1) INTO g_indd_d[l_ac].inddseq FROM indd_t
                WHERE inddent = g_enterprise
                  AND indddocno = g_indc_m.indcdocno
               IF cl_null(g_indd_d[l_ac].inddseq) THEN 
                  LET g_indd_d[l_ac].inddseq = 1
               END IF                  
            END IF
            
            #add by lixh 20141231(S)
#            IF l_ac > 1 THEN
#               LET g_indd_d[l_ac].indd151 = g_indd_d[l_ac-1].indd151
#            END IF 
#            IF cl_null(g_indd_d[l_ac].indd151) THEN         
#               LET g_indd_d[l_ac].indd151 = g_indc_m.indc151
#            END IF   
#            CALL aint330_indd151_ref()
#            LET g_indd_d[l_ac].inddsite = g_site 
            #add by lixh 20141231(E)            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inddseq
            #add-point:ON CHANGE inddseq name="input.g.page1.inddseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd101
            
            #add-point:AFTER FIELD indd101 name="input.a.page1.indd101"
            IF NOT cl_null(g_indd_d[l_ac].indd101) THEN 
               IF g_indc_m.indc002 = '2' THEN  #160921-00014#1
                  #160204-00004#5 20160222 s983961--add(s)
                  IF NOT cl_null(g_indc_m.indcdocno) THEN 
                     IF NOT s_aooi210_check_doc(g_site,'', g_indd_d[l_ac].indd101 , g_indc_m.indcdocno ,'4','') THEN
                        LET g_indd_d[l_ac].indd101 = g_indd_d_t.indd101
                
                        NEXT FIELD CURRENT               
                     END IF
                  END IF
                  #160204-00004#5 20160222 s983961--add(e)
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_indd_d[l_ac].indd101
                  LET g_chkparam.arg2 = g_site
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_indadocno") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_indd_d[l_ac].indd101 = g_indd_d_t.indd101  
                     NEXT FIELD CURRENT                  
                  END IF 
               END IF  #160921-00014#1
               #160921-00014#1-S
               IF g_indc_m.indc002 = '10' THEN  #報廢申請轉入
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_indd_d[l_ac].indd101
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inbidocno") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_indd_d[l_ac].indd101 = g_indd_d_t.indd101  
                     NEXT FIELD CURRENT                  
                  END IF               
                  
                  IF g_indd_d[l_ac].indd101 <> g_indc_m.indc003 THEN
                     LET g_indd_d[l_ac].indd101 = g_indd_d_t.indd101                 
                     NEXT FIELD CURRENT                     
                  END IF

               END IF
               #160921-00014#1-E
               IF NOT aint330_indd001_chk() THEN
                  LET g_indd_d[l_ac].indd101 = g_indd_d_t.indd101 
                  NEXT FIELD CURRENT                     
               END IF               
               IF NOT aint330_indd101_chk() THEN
                  LET g_indd_d[l_ac].indd101 = g_indd_d_t.indd101                 
                  NEXT FIELD CURRENT   
               END IF
               CALL aint330_indd101_default()
            END IF 
     
            #161006-00018#4-S
            CALL aint330_set_entry_b(l_cmd)           
            CALL aint330_set_no_required_b()
            CALL aint330_set_required_b()           
            CALL aint330_set_no_entry_b(l_cmd)
            #161006-00018#4-E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd101
            #add-point:BEFORE FIELD indd101 name="input.b.page1.indd101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd101
            #add-point:ON CHANGE indd101 name="input.g.page1.indd101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd001
            #add-point:BEFORE FIELD indd001 name="input.b.page1.indd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd001
            
            #add-point:AFTER FIELD indd001 name="input.a.page1.indd001"
            IF NOT cl_null(g_indd_d[l_ac].indd001) THEN 
               IF NOT aint330_indd001_chk() THEN
                  LET g_indd_d[l_ac].indd001 = g_indd_d_t.indd001 
                  NEXT FIELD CURRENT                     
               END IF
               CALL aint330_indd101_default()            
            END IF   
            #161006-00018#4-S
            CALL aint330_set_entry_b(l_cmd)           
            CALL aint330_set_no_required_b()
            CALL aint330_set_required_b()           
            CALL aint330_set_no_entry_b(l_cmd)
            #161006-00018#4-E               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd001
            #add-point:ON CHANGE indd001 name="input.g.page1.indd001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd002
            
            #add-point:AFTER FIELD indd002 name="input.a.page1.indd002"
#            LET g_indd_d[l_ac].indd002_desc = ' '
#            LET g_indd_d[l_ac].indd002_desc_1 = ' '
#            DISPLAY BY NAME g_indd_d[l_ac].indd002_desc,g_indd_d[l_ac].indd002_desc_1  
#            CALL aint330_indd002_ref()
            IF NOT cl_null(g_indd_d[l_ac].indd002) THEN
            #150320---earl---mod---s            
#               #此段落由子樣板a19產生
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#
#               LET g_chkparam.arg1 = g_indd_d[l_ac].indd002    
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_imaf001_1") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002  
#                  CALL aint330_indd002_ref()                  
#                  NEXT FIELD CURRENT
#               END IF
#               IF NOT aint330_indd002_chk() THEN
#                  NEXT FIELD indd002
#               END IF

                INITIALIZE g_chkparam.* TO NULL
                #設定g_chkparam.*的參數
                LET g_chkparam.arg1 = g_indd_d[l_ac].indd002
                LET g_chkparam.arg2 = g_indc_m.indc009
                
                #呼叫檢查存在並帶值的library
                IF NOT cl_chk_exist("v_imaf001_18") THEN
                   LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002  
                   CALL aint330_indd002_ref()                  
                   NEXT FIELD CURRENT
                END IF
            #150320---earl---mod---e
              
             #檢查產品生命週期  
               CALL s_control_chk_doc('4',g_indc_m.indcdocno,g_indd_d[l_ac].indd002,'','','','') RETURNING r_success,l_flag     
               IF r_success THEN
                  IF NOT l_flag THEN
                     LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002 
                     CALL aint330_indd002_ref() 
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002 
                  CALL aint330_indd002_ref() 
                  NEXT FIELD CURRENT
               END IF   
               #檢查產品分類               
               CALL s_control_chk_doc('5',g_indc_m.indcdocno,g_indd_d[l_ac].indd002,'','','','') RETURNING r_success,l_flag     
               IF r_success THEN
                  IF NOT l_flag THEN
                     LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002 
                     CALL aint330_indd002_ref() 
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002  
                  CALL aint330_indd002_ref() 
                  NEXT FIELD CURRENT
               END IF
              #pengu 141231在AFTER ROW時在統一檢查               
              # IF NOT aint330_inag_chk(g_site,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024) THEN
              #    LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002  
              #    CALL aint330_indd002_ref() 
              #    NEXT FIELD indd002                 
              # END IF
#               IF NOT aint330_inag008_chk() THEN
##                  LET g_indd_d[l_ac].indd002 = g_indd_d_t.indd002  
##                  CALL aint330_indd002_ref() 
##                  NEXT FIELD indd002                     
#               END IF                
               CALL aint330_indd002_ref()
               CALL aint330_set_entry_b(l_cmd)
               CALL aint330_set_no_required_b()
               CALL aint330_set_required_b()                
               CALL aint330_set_no_entry_b(l_cmd)  
              #輸入的單位是否存在料件主檔設置的允許使用的單位#   
               IF NOT aint330_imao_chk() THEN
               #清空庫存單位
                  LET g_indd_d[l_ac].indd006 = ''
                  LET g_indd_d[l_ac].indd006_desc = ''
               END IF                    
            END IF 
            LET g_indd_d_o.indd002 = g_indd_d[l_ac].indd002        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd002
            #add-point:BEFORE FIELD indd002 name="input.b.page1.indd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd002
            #add-point:ON CHANGE indd002 name="input.g.page1.indd002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd004
            
            #add-point:AFTER FIELD indd004 name="input.a.page1.indd004"
            CALL s_feature_description(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004)
                 RETURNING r_success,g_indd_d[l_ac].indd004_desc 
                 
            IF NOT cl_null(g_indd_d[l_ac].indd004) THEN    #add by lixh 20151109
               IF NOT s_feature_check(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004) THEN  
                  LET g_indd_d[l_ac].indd004 = g_indd_d_t.indd004 
                  CALL s_feature_description(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004)
                       RETURNING r_success,g_indd_d[l_ac].indd004_desc             
                  NEXT FIELD CURRENT            
               END IF  
               #151224-00025#1 tsungyung --- add start ---
               IF NOT s_feature_direct_input(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d_t.indd004,g_indc_m.indcdocno,g_indc_m.indcsite) THEN
                  NEXT FIELD CURRENT
               END IF       
               #151224-00025#1 tsungyung --- add end   ---                  
            END IF      #add by lixh 20151109     
            
           #pengu 141231在AFTER ROW時在統一檢查   
           # IF NOT aint330_inag_chk(g_site,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024) THEN
           #    LET g_indd_d[l_ac].indd004 = g_indd_d_t.indd004 
           #    CALL s_feature_description(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004)
           #         RETURNING r_success,g_indd_d[l_ac].indd004_desc                
           #    NEXT FIELD indd004                 
           # END IF
#            IF NOT aint330_inag008_chk() THEN
##               LET g_indd_d[l_ac].indd004 = g_indd_d_t.indd004 
##               CALL s_feature_description(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004)
##                    RETURNING r_success,g_indd_d[l_ac].indd004_desc                
##               NEXT FIELD indd004     
#            END IF  
            CALL s_feature_description(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004)
                 RETURNING r_success,g_indd_d[l_ac].indd004_desc             
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd004
            #add-point:BEFORE FIELD indd004 name="input.b.page1.indd004"
#            IF cl_null(g_indd_d[l_ac].indd004) THEN #160314-00009#9 16/03/25 zhujing marked              
            IF cl_null(g_indd_d[l_ac].indd004) AND s_feature_auto_chk(g_indd_d[l_ac].indd002) THEN    #160314-00009#9 16/03/25 zhujing mod
               CALL s_feature_single(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,'ALL','') 
                    RETURNING r_success,g_indd_d[l_ac].indd004
               #160804-00013#1-s mark     
#               IF cl_null(g_indd_d[l_ac].indd004) THEN 
#                  LET g_indd_d[l_ac].indd004 = ' '
#               END IF   
               #160804-00013#1-e mark               
               DISPLAY g_indd_d[l_ac].indd004 TO indd004
            ELSE
               CALL s_feature_description(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004)
                    RETURNING r_success,g_indd_d[l_ac].indd004_desc             
            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd004
            #add-point:ON CHANGE indd004 name="input.g.page1.indd004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd022
            
            #add-point:AFTER FIELD indd022 name="input.a.page1.indd022"
            CALL aint330_indd022_ref()
            LET g_indd022_type = ''  #161007-00012#2-add
            IF NOT cl_null(g_indd_d[l_ac].indd022) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_indd_d[l_ac].indd022
               #160318-00025#19  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#19  by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022 
                  LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023
                  LET g_indd_d[l_ac].indd024 = g_indd_d_o.indd024                  
                  CALL aint330_indd022_ref()
                  NEXT FIELD CURRENT
               END IF
               #161007-00012#2-s-add
               CALL s_aint320_vmi_type(g_site,g_indd_d[l_ac].indd022) RETURNING g_indd022_type  
               IF g_indd022_type = '2' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code = 'ain-00841'  #庫位：%1，為結算倉，不可輸入！
                  LET g_errparam.replace[1] = g_indd_d[l_ac].indd022
                  LET g_errparam.popup = TRUE
                  LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022 
                  LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023
                  LET g_indd_d[l_ac].indd024 = g_indd_d_o.indd024 
                  CALL cl_err()         
                  NEXT FIELD CURRENT
               END IF
               #161007-00012#2-e-add
               #add by lixh 20150225
               IF NOT aint330_inaa010_chk() THEN
                  LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022 
                  LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023
                  LET g_indd_d[l_ac].indd024 = g_indd_d_o.indd024
                  CALL aint330_indd022_ref()
                  NEXT FIELD indd022                               
               END IF
               #add by lixh 20150225
               
               #add by lixh 20151206               
               IF NOT cl_null(g_indd_d[l_ac].indd022) AND NOT cl_null(g_indd_d[l_ac].indd023)  THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM inab_t
                   WHERE inabent = g_enterprise
                     AND inabsite = g_site
                     AND inab001 = g_indd_d[l_ac].indd022
                     AND inab002 = g_indd_d[l_ac].indd023
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     LET g_indd_d[l_ac].indd023 = ' '                            
                  END IF                                              
               END IF
               #add by lixh 20151206  
                  
               CALL s_control_chk_doc('6',g_indc_m.indcdocno,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,'','','') RETURNING r_success,l_flag
               IF r_success THEN
                  IF NOT l_flag THEN 
                     LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022 
                     LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023
                     LET g_indd_d[l_ac].indd024 = g_indd_d_o.indd024                     
                     CALL aint330_indd022_ref()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022 
                  LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023
                  LET g_indd_d[l_ac].indd024 = g_indd_d_o.indd024
                  CALL aint330_indd022_ref()
                  NEXT FIELD CURRENT
               END IF                
              #add by lixh 20151119
              #IF s_lot_batch_number(g_indd_d[l_ac].indd002,g_site) THEN     #160314-00008#1 mark
               IF s_lot_batch_number_1n3(g_indd_d[l_ac].indd002,g_site) THEN #160314-00008#1 add
                  IF g_indd_d[l_ac].indd022 <> g_indd_d_o.indd022 OR g_indd_d_o.indd022 IS NULL OR
                     g_indd_d[l_ac].indd023 <> g_indd_d_o.indd023 OR g_indd_d_o.indd023 IS NULL OR 
                     g_indd_d[l_ac].indd024 <> g_indd_d_o.indd024 OR g_indd_d_o.indd024 IS NULL THEN
                     IF g_indd_d[l_ac].indd103 > 0 THEN  #161013-00028#1
                        CALL s_lot_inao_chk(g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,'2',g_site) RETURNING l_success,l_cnt
                        IF l_cnt > 0 THEN
                           IF l_success THEN
                              DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_indc_m.indcdocno 
                                                   AND inaoseq = g_indd_d[l_ac].inddseq
                              IF NOT s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                               g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                               g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') THEN     
                                                                                       
                                 NEXT FIELD indd022
                              END IF 
                           ELSE
                              LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022 
                              LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023
                              LET g_indd_d[l_ac].indd024 = g_indd_d_o.indd024                             
                           END IF
                        ELSE
                           IF NOT s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                            g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                            g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') THEN                                                       
                                             
                              NEXT FIELD indd022
                           END IF                                         
                        END IF
                     END IF #161013-00028#1
                     #161013-00028#1-s
                     IF g_indd_d[l_ac].indd103 < 0 THEN
                        CALL s_lot_upd_inao(g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,'0',' ',g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_site,g_indd_d[l_ac].indd102)  
                             RETURNING r_success 
                        IF NOT r_success THEN
                           NEXT FIELD CURRENT
                        END IF   
                     END IF                        
                     #161013-00028#1-e
                 END IF 
              END IF                
              #add by lixh 20151119              
              #pengu 141231在AFTER ROW時在統一檢查    
              # IF NOT aint330_inag_chk(g_site,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024) THEN
              #    LET g_indd_d[l_ac].indd022 = g_indd_d_t.indd022  
              #    CALL aint330_indd022_ref() 
              #    NEXT FIELD indd022                 
              # END IF  
#               IF NOT aint330_inag008_chk() THEN
##                  IF NOT cl_null(g_indd_d[l_ac].indd101) THEN
##                     NEXT FIELD indd103
##                  ELSE
##                     LET g_indd_d[l_ac].indd022 = g_indd_d_t.indd022  
##                     CALL aint330_indd022_ref() 
##                     NEXT FIELD indd022   
##                  END IF                     
#               END IF   
               CALL aint330_indd022_ref()
            END IF 
            CALL aint330_set_entry_b(l_cmd)
            #160519-00008#4-s
            CALL aint330_set_no_required_b()
            CALL aint330_set_required_b()
            #160519-00008#4-e            
            CALL aint330_set_no_entry_b(l_cmd)
            LET g_indd_d_o.indd022 = g_indd_d[l_ac].indd022 
            LET g_indd_d_o.indd023 = g_indd_d[l_ac].indd023
            LET g_indd_d_o.indd024 = g_indd_d[l_ac].indd024
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
            #add by lixh 20151206
            IF g_indd_d[l_ac].indd023 IS NULL THEN
               LET g_indd_d[l_ac].indd023 = ' '
            END IF
            #add by lixh 20151206
            CALL aint330_indd023_ref()
            
            #IF NOT cl_null(g_indd_d[l_ac].indd023) THEN 
            IF g_indd_d[l_ac].indd023 IS NOT NULL THEN    #add by lixh 20151206
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               SELECT inaa007 INTO l_inaa007 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_site
                  AND inaa001 = g_indd_d[l_ac].indd022        
               IF l_inaa007 = '1' THEN                
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_indd_d[l_ac].indd022
                  LET g_chkparam.arg3 = g_indd_d[l_ac].indd023
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#19  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inab002") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023 
                     LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022 
                     LET g_indd_d[l_ac].indd024 = g_indd_d_o.indd024  
                     CALL aint330_indd023_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
                              
               IF NOT cl_null(g_indd_d[l_ac].indd022) THEN  #160120-00006#1 add by 20160127
                  CALL s_control_chk_doc('6',g_indc_m.indcdocno,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,'','','') RETURNING r_success,l_flag
                  IF r_success THEN
                     IF NOT l_flag THEN
                        LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023 
                        LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022 
                        LET g_indd_d[l_ac].indd024 = g_indd_d_o.indd024   
                        CALL aint330_indd023_ref()
                        NEXT FIELD indd023
                     END IF
                  ELSE
                     LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023 
                     LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022 
                     LET g_indd_d[l_ac].indd024 = g_indd_d_o.indd024                   
                     CALL aint330_indd023_ref()
                     NEXT FIELD indd023
                  END IF  
               END IF #160120-00006#1 add by 20160127
               
              #add by lixh 20151119
              #IF s_lot_batch_number(g_indd_d[l_ac].indd002,g_site) THEN     #160314-00008#1 mark
               IF s_lot_batch_number_1n3(g_indd_d[l_ac].indd002,g_site) THEN #160314-00008#1 add
                  IF g_indd_d[l_ac].indd022 <> g_indd_d_o.indd022 OR g_indd_d_o.indd022 IS NULL OR
                     g_indd_d[l_ac].indd023 <> g_indd_d_o.indd023 OR g_indd_d_o.indd023 IS NULL OR 
                     g_indd_d[l_ac].indd024 <> g_indd_d_o.indd024 OR g_indd_d_o.indd024 IS NULL THEN
                     IF g_indd_d[l_ac].indd103 > 0 THEN  #161013-00028#1
                        CALL s_lot_inao_chk(g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,'2',g_site) RETURNING l_success,l_cnt
                        IF l_cnt > 0 THEN
                           IF l_success THEN
                              DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_indc_m.indcdocno 
                                                   AND inaoseq = g_indd_d[l_ac].inddseq
                              IF NOT s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                               g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                               g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') THEN                                                       
                                                
                                 NEXT FIELD indd023
                              END IF
                           ELSE
                              LET g_indd_d[l_ac].indd023 = g_indd_d_o.indd023 
                              LET g_indd_d[l_ac].indd022 = g_indd_d_o.indd022 
                              LET g_indd_d[l_ac].indd024 = g_indd_d_o.indd024                    
                           END IF
                        ELSE
                           IF NOT s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                            g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                            g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') THEN                                                       
                                             
                              NEXT FIELD indd023
                           END IF                  
                        END IF
                     END IF    #161013-00028#1
                     #161013-00028#1-s
                     IF g_indd_d[l_ac].indd103 < 0 THEN
                        CALL s_lot_upd_inao(g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,'0',' ',g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_site,g_indd_d[l_ac].indd102)  
                             RETURNING r_success 
                        IF NOT r_success THEN
                           NEXT FIELD CURRENT
                        END IF   
                     END IF                        
                     #161013-00028#1-e                     
                  END IF 
               END IF               
              #add by lixh 20151119   

              #pengu 141231在AFTER ROW時在統一檢查                  
              # IF NOT aint330_inag_chk(g_site,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024) THEN
              #    LET  g_indd_d[l_ac].indd023 = g_indd_d_t.indd023 
              #    CALL aint330_indd023_ref()
              #    NEXT FIELD indd023                  
              # END IF
#               IF NOT aint330_inag008_chk() THEN
##                  LET  g_indd_d[l_ac].indd023 = g_indd_d_t.indd023 
##                  CALL aint330_indd023_ref()
##                  NEXT FIELD indd023         
#               END IF                 
            END IF 
            LET g_indd_d_o.indd023 = g_indd_d[l_ac].indd023 
            LET g_indd_d_o.indd022 = g_indd_d[l_ac].indd022
            LET g_indd_d_o.indd024 = g_indd_d[l_ac].indd024
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

            #160519-00022#2---mod---e
            #add by lixh 20151206
            SELECT imaf061 
              INTO l_imaf061
              FROM imaf_t  
             WHERE imafent = g_enterprise
               AND imafsite = g_site
               AND imaf001 = g_indd_d[l_ac].indd002
            IF cl_null(g_indd_d[l_ac].indd024) THEN   
               IF l_imaf061 = '1' THEN
                  LET g_indd_d[l_ac].indd024 = ''
               ELSE
                  LET g_indd_d[l_ac].indd024 = ' '
               END IF
            END IF               
            #IF g_indd_d[l_ac].indd024 IS NULL THEN
            #   LET g_indd_d[l_ac].indd024 = ' '
            #END IF
            #add by lixh 20151206
            #160519-00022#2---mod---e
            #IF NOT cl_null(g_indd_d[l_ac].indd024) THEN 
            IF g_indd_d[l_ac].indd024 IS NOT NULL THEN      #add by lixh 20151206 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

                  
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_inai006") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
              #pengu 141231在AFTER ROW時在統一檢查   
              # IF NOT aint330_inag_chk(g_site,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024) THEN
              #    LET g_indd_d[l_ac].indd024 = g_indd_d_t.indd024  
              #    NEXT FIELD indd024                 
              # END IF 
#               IF NOT aint330_inag008_chk() THEN
##                  LET g_indd_d[l_ac].indd024 = g_indd_d_t.indd024  
##                  NEXT FIELD indd024  
#               END IF    
              #add by lixh 20151119
              #IF s_lot_batch_number(g_indd_d[l_ac].indd002,g_site) THEN     #160314-00008#1 mark
               IF s_lot_batch_number_1n3(g_indd_d[l_ac].indd002,g_site) THEN #160314-00008#1 add
                  IF g_indd_d[l_ac].indd022 <> g_indd_d_o.indd022 OR g_indd_d_o.indd022 IS NULL OR
                     g_indd_d[l_ac].indd023 <> g_indd_d_o.indd023 OR g_indd_d_o.indd023 IS NULL OR 
                     g_indd_d[l_ac].indd024 <> g_indd_d_o.indd024 OR g_indd_d_o.indd024 IS NULL THEN              
                     IF g_indd_d[l_ac].indd103 > 0 THEN #161013-00028#1  
                        CALL s_lot_inao_chk(g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,'2',g_site) RETURNING l_success,l_cnt
                        IF l_cnt > 0 THEN
                           IF l_success THEN
                              DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_indc_m.indcdocno 
                                                   AND inaoseq = g_indd_d[l_ac].inddseq
                              IF NOT s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                               g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                               g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') THEN                                                       
                                                
                                 NEXT FIELD indd024
                              END IF 
                           ELSE
                              LET g_indd_d_o.indd024 = g_indd_d[l_ac].indd024
                              LET g_indd_d_o.indd022 = g_indd_d[l_ac].indd022
                              LET g_indd_d_o.indd023 = g_indd_d[l_ac].indd023
                           END IF
                        ELSE
                           IF NOT s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                            g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                            g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') THEN                                                       
                                             
                              NEXT FIELD indd024  
                           END IF                           
                        END IF  
                     END IF       #161013-00028#1               
                     #161013-00028#1-s
                     IF g_indd_d[l_ac].indd103 < 0 THEN
                        CALL s_lot_upd_inao(g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,'0',' ',g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_site,g_indd_d[l_ac].indd102)  
                             RETURNING r_success 
                        IF NOT r_success THEN
                           NEXT FIELD CURRENT
                        END IF   
                     END IF                        
                     #161013-00028#1-e                       
                  END IF
              END IF                  
              #add by lixh 20151119                         
            END IF 
            LET g_indd_d_o.indd024 = g_indd_d[l_ac].indd024
            LET g_indd_d_o.indd022 = g_indd_d[l_ac].indd022
            LET g_indd_d_o.indd023 = g_indd_d[l_ac].indd023            
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
              #pengu 141231在AFTER ROW時在統一檢查    
              # IF NOT aint330_inag_chk(g_site,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024) THEN
              #    LET g_indd_d[l_ac].indd102 = g_indd_d_t.indd102  
              #    NEXT FIELD indd102                 
              # END IF
#               IF NOT aint330_inag008_chk() THEN
##                  LET g_indd_d[l_ac].indd102 = g_indd_d_t.indd102   
##                  NEXT FIELD indd102     
#               END IF  
            #160316-00007#2
            #160519-00008#4-s
            SELECT imaf055 INTO l_imaf055 FROM imaf_t
             WHERE imafent = g_enterprise
               AND imafsite = g_site
               AND imaf001 = g_indd_d[l_ac].indd002
            IF l_imaf055 <> '1' THEN   
            #160519-00008#4-e   
               #161007-00012#2-s-mod  #原先僅考慮，aimm212的庫存管理特徵，多加一條件，若出/入倉，任一為VMI倉，則庫存管理特徵為必輸(不能塞空白)            
               #IF g_indd_d[l_ac].indd102 IS NULL THEN
               #   LET g_indd_d[l_ac].indd102 = ' '
               #END IF
               IF cl_null(g_indd_d[l_ac].indd102) THEN 
                  #若撥出/入庫位，若兩個都非VMI存貨倉，補空白
                  IF g_indd022_type = '0' AND g_indd032_type = '0' THEN
                     LET g_indd_d[l_ac].indd102 = ' '
                  ELSE
                     LET g_indd_d[l_ac].indd102 = ''
                  END IF
               END IF     
               #161007-00012#2-e-mod
            END IF  #160519-00008#4
            IF s_lot_batch_number_1n3(g_indd_d[l_ac].indd002,g_site) THEN
               IF g_indd_d[l_ac].indd102 <> g_indd_d_o.indd102 OR g_indd_d_o.indd102 IS NULL THEN
                  CALL s_lot_inao_chk(g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,'2',g_site) RETURNING l_success,l_cnt
                  IF l_cnt > 0 THEN
                     IF l_success THEN
                        DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_indc_m.indcdocno 
                                             AND inaoseq = g_indd_d[l_ac].inddseq
                        IF NOT s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                         g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                         g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') THEN     
                                                                                 
                           NEXT FIELD indd102
                        END IF 
                     ELSE
                        LET g_indd_d[l_ac].indd102 = g_indd_d_o.indd102                           
                     END IF
                  ELSE
                     IF NOT s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                      g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                      g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') THEN                                                       
                                       
                        NEXT FIELD indd102
                     END IF                                         
                  END IF
               END IF                  
            END IF
            LET g_indd_d_o.indd102 = g_indd_d[l_ac].indd102       
            #160316-00007#2
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd102
            #add-point:ON CHANGE indd102 name="input.g.page1.indd102"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd006
            
            #add-point:AFTER FIELD indd006 name="input.a.page1.indd006"
            CALL aint330_indd006_ref() 
            IF NOT cl_null(g_indd_d[l_ac].indd006) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_indd_d[l_ac].indd006
               #160318-00025#19  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#19  by 07900 --add-end                
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_indd_d[l_ac].indd006 = g_indd_d_t.indd006
                  CALL aint330_indd006_ref()                  
                  NEXT FIELD indd006
               END IF
               IF NOT aint330_imao_chk() THEN
                  LET g_indd_d[l_ac].indd006 = g_indd_d_t.indd006
                  CALL aint330_indd006_ref()                
                  NEXT FIELD indd006
               END IF
              #pengu 141231在AFTER ROW時在統一檢查   
              # IF NOT aint330_inag_chk(g_site,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024) THEN
              #    LET g_indd_d[l_ac].indd006 = g_indd_d_t.indd006
              #    CALL aint330_indd006_ref()                      
              #    NEXT FIELD indd006
              # END IF
#               IF NOT aint330_inag008_chk() THEN
##                  LET g_indd_d[l_ac].indd006 = g_indd_d_t.indd006
##                  CALL aint330_indd006_ref()                      
##                  NEXT FIELD indd006  
#               END IF   
               #add by lixh 20150226
               IF NOT cl_null(g_indd_d[l_ac].indd041) THEN 
                  CALL s_aimi190_get_convert1(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd041)
                    RETURNING r_success,l_qty1,l_qty2                       
                  IF NOT r_success THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_indd_d[l_ac].indd006
                     LET g_errparam.code   = 'ain-00500' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                  
                     LET g_indd_d[l_ac].indd006 = g_indd_d_t.indd006
                     CALL aint330_indd006_ref()                  
                     NEXT FIELD indd006                  
                  END IF    
               END IF               
               #add by lixh 20150226  
               CALL aint330_unit_convert()
            END IF 



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
         BEFORE FIELD indd103
            #add-point:BEFORE FIELD indd103 name="input.b.page1.indd103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd103
            
            #add-point:AFTER FIELD indd103 name="input.a.page1.indd103"
            #160921-00014#1-S            
            IF g_indd_d[l_ac].indd103 = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = g_indd_d[l_ac].indd103
               LET g_errparam.code   = "ain-00019"
               LET g_errparam.popup  = FALSE
               CALL cl_err() 
               LET g_indd_d[l_ac].indd103 = g_indd_d_t.indd103            
               NEXT FIELD indd103
            END IF
            IF g_indc_m.indc102 <> '1' THEN
               IF g_indd_d[l_ac].indd103 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_indd_d[l_ac].indd103
                  LET g_errparam.code   = "ain-00803"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err() 
                  LET g_indd_d[l_ac].indd103 = g_indd_d_t.indd103
                  NEXT FIELD indd103                  
               END IF
               IF NOT cl_ap_chk_range(g_indd_d[l_ac].indd103,"0","0","","","azz-00079",1) THEN
                  NEXT FIELD indd103
               END IF            
            END IF
            #160921-00014#1-E
            IF NOT cl_null(g_indd_d[l_ac].indd103) THEN             
               IF NOT aint330_indd103_chk() THEN
                  LET g_indd_d[l_ac].indd103 = g_indd_d_t.indd103
                  NEXT FIELD indd103
               END IF    
              #pengu 141231在AFTER ROW時在統一檢查    
              # IF NOT aint330_inag_chk(g_site,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024) THEN
              #    LET g_indd_d[l_ac].indd103 = g_indd_d_t.indd103 
              #    NEXT FIELD indd103            
              # END IF 
#               IF NOT aint330_inag008_chk() THEN
##                  LET g_indd_d[l_ac].indd103 = g_indd_d_t.indd103
##                  NEXT FIELD indd103
#               END IF     
               SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102 FROM imaf_t
                WHERE imafent = g_enterprise
                  AND imafsite = g_site
                  AND imaf001 = g_indd_d[l_ac].indd002
               IF cl_null(l_imaf101) THEN LET l_imaf101 = 0 END IF
               IF cl_null(l_imaf102) THEN LET l_imaf102 = 0 END IF               
               IF g_indd_d[l_ac].indd103 < l_imaf102 THEN        
                  CALL cl_getmsg('ain-00387',g_lang) RETURNING l_msg
                  CALL cl_getmsg('ain-00339',g_lang) RETURNING l_msg1
                  LET l_msg = l_msg,l_imaf102,"  ",l_msg1                  
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'ain-00339'
#                  LET g_errparam.extend = g_indd_d[l_ac].indd103
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()       
#                  LET g_indd_d[l_ac].indd103 = g_indd_d_t.indd103 
#                  NEXT FIELD indd103   
                  IF cl_ask_promp(l_msg) THEN
                     LET g_indd_d[l_ac].indd103 = l_imaf102
                  END IF
               END IF
               IF l_imaf101 <> 0 THEN 
                  LET l_num = g_indd_d[l_ac].indd103/l_imaf101
                  IF g_indd_d[l_ac].indd103 - l_num * l_imaf101 <> 0 THEN
                     CALL cl_getmsg('ain-00387',g_lang) RETURNING l_msg
                     IF g_indd_d[l_ac].indd103 - l_num * l_imaf101 > 0 THEN
                        LET l_indd103 = (l_num+1)*l_imaf101
                     ELSE
                        LET l_indd103 = l_num * l_imaf101 
                     END IF
                     IF l_indd103 < l_imaf102 THEN
                        LET l_indd103 = l_imaf102
                     END IF
                     LET l_msg = ''
                     LET l_msg1 = ''
                     CALL cl_getmsg('ain-00387',g_lang) RETURNING l_msg
                     CALL cl_getmsg('ain-00340',g_lang) RETURNING l_msg1
                     LET l_msg = l_msg,l_indd103," ",l_msg1 
                     IF cl_ask_promp(l_msg) THEN
                        LET g_indd_d[l_ac].indd103 = l_indd103
                     END IF                        
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'ain-00340'
#                     LET g_errparam.extend = g_indd_d[l_ac].indd103
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()       
#                     LET g_indd_d[l_ac].indd103 = g_indd_d_t.indd103             
#                     NEXT FIELD indd103                  
                  END IF
               END IF  
               CALL aint330_unit_convert()
               #IF aint330_pxh_chk() AND (g_indd_d[l_ac].indd103 <> g_indd_d_t.indd103 OR g_indd_d_o.indd103 IS NULL) THEN  #161006-00018#4-S
               #161006-00018#4-S
               IF s_lot_batch_number_1n3(g_indd_d[l_ac].indd002,g_site) THEN  
                  IF g_indd_d[l_ac].indd103 <> g_indd_d_o.indd103 OR g_indd_d_o.indd103 IS NULL THEN
               #161006-00018#4-E   
#                  SELECT imaf053 INTO l_imaf053 F ROM imaf_t WHERE imafent = g_enterprise 
#                                                              AND imafsite = g_site 
#                                                              AND imaf001 = g_indd_d[l_ac].indd002

#                  IF NOT s_lot_sel('1','1',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,  #mark by lixh 20150831            
                     #161013-00028#1-s
                     #调拨的方向改变，先删除批序号资料
                     IF (g_indd_d[l_ac].indd103 > 0 AND g_indd_d_o.indd103 < 0) OR
                        (g_indd_d[l_ac].indd103 < 0 AND g_indd_d_o.indd103 > 0) THEN
                        DELETE FROM inao_t WHERE inaoent = g_enterprise
                                             AND inaodocno = g_indc_m.indcdocno
                                             AND inaoseq = g_indd_d[l_ac].inddseq
                     END IF   
                     #161013-00028#1-e
                     IF g_indd_d[l_ac].indd103 > 0 THEN  #161013-00028#1
                        IF NOT s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                         g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                         g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') THEN                                                                                        
                           NEXT FIELD indd103
                        END IF  
                     END IF  #161013-00028#1
                     #161013-00028#1-S
                     IF g_indd_d[l_ac].indd103 < 0 THEN
                        IF NOT s_aint330_lot_sel('1','2',g_indc_m.indc006,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                         g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                         g_indd_d[l_ac].indd031,'-1','aint330',g_site,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) THEN                                                                                        
                           NEXT FIELD indd103
                        END IF
                     END IF
                     #161013-00028#1-E
                  #161006-00018#4-S   
                  ELSE   
                     IF s_lot_batch_number(g_indd_d[l_ac].indd002,g_site) THEN  
                        LET l_cnt = 0                        
                        SELECT COUNT(1) INTO l_cnt FROM inao_t 
                         WHERE inaoent = g_enterprise
                           AND inaodocno = g_indc_m.indcdocno
                           AND inaoseq = g_indd_d[l_ac].inddseq
                           AND inaoseq1 = 0
                        IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
                        IF l_cnt = 0 THEN  
                           IF g_indd_d[l_ac].indd103 > 0 THEN  
                              IF NOT s_lot_sel('1','2',g_site,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                               g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                               g_indd_d[l_ac].indd103,'-1','aint330',g_site,'','','','0') THEN                                                                                        
                                 NEXT FIELD indd103
                              END IF  
                           END IF  
                         
                           IF g_indd_d[l_ac].indd103 < 0 THEN
                              IF NOT s_aint330_lot_sel('1','2',g_indc_m.indc006,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                               g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                               g_indd_d[l_ac].indd031,'-1','aint330',g_site,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) THEN                                                                                        
                                 NEXT FIELD indd103
                              END IF
                           END IF
                        END IF
                     END IF
                  END IF    
                  #161006-00018#4-E
               END IF 

            END IF 
            LET g_indd_d_o.indd103 = g_indd_d[l_ac].indd103

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd103
            #add-point:ON CHANGE indd103 name="input.g.page1.indd103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indd_d[l_ac].indd021,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD indd021
            END IF 
 
 
 
            #add-point:AFTER FIELD indd021 name="input.a.page1.indd021"
            IF NOT cl_null(g_indd_d[l_ac].indd021) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd021
            #add-point:BEFORE FIELD indd021 name="input.b.page1.indd021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd021
            #add-point:ON CHANGE indd021 name="input.g.page1.indd021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd104
            
            #add-point:AFTER FIELD indd104 name="input.a.page1.indd104"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indd_d[l_ac].indd104
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indd_d[l_ac].indd104_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indd_d[l_ac].indd104_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd104
            #add-point:BEFORE FIELD indd104 name="input.b.page1.indd104"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd104
            #add-point:ON CHANGE indd104 name="input.g.page1.indd104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd105
            #add-point:BEFORE FIELD indd105 name="input.b.page1.indd105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd105
            
            #add-point:AFTER FIELD indd105 name="input.a.page1.indd105"
            IF g_indc_m.indc102 = '1' THEN   #add by lixh 20150519
               LET g_indd_d[l_ac].indd106 = g_indd_d[l_ac].indd105
               LET g_indd_d[l_ac].indd109 = g_indd_d[l_ac].indd105
            END IF #add by lixh 20150519 
            #add by lixh 20150519
            IF g_indc_m.indc102 = '2' THEN
               LET g_indd_d[l_ac].indd106 = 0
               LET g_indd_d[l_ac].indd109 = 0
            END IF 
            #add by lixh 20150519            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd105
            #add-point:ON CHANGE indd105 name="input.g.page1.indd105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd106
            #add-point:BEFORE FIELD indd106 name="input.b.page1.indd106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd106
            
            #add-point:AFTER FIELD indd106 name="input.a.page1.indd106"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd106
            #add-point:ON CHANGE indd106 name="input.g.page1.indd106"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd151
            
            #add-point:AFTER FIELD indd151 name="input.a.page1.indd151"
            CALL aint330_indd151_ref()  
            IF NOT cl_null(g_indd_d[l_ac].indd151) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_acc
               LET g_chkparam.arg2 = g_indd_d[l_ac].indd151
               #160318-00025#19  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               #160318-00025#19  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_indd_d[l_ac].indd151 = g_indd_d_t.indd151
                  CALL aint330_indd151_ref()                   
                  NEXT FIELD CURRENT
               END IF           
               CALL aint330_indd151_ref()  
            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indd_d[l_ac].indd151
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? ","") RETURNING g_rtn_fields
#            LET g_indd_d[l_ac].indd151_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indd_d[l_ac].indd151_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd151
            #add-point:BEFORE FIELD indd151 name="input.b.page1.indd151"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd151
            #add-point:ON CHANGE indd151 name="input.g.page1.indd151"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd032
            
            #add-point:AFTER FIELD indd032 name="input.a.page1.indd032"
            CALL aint330_indd032_ref()
            LET g_indd032_type = ''  #161007-00012#2-add
            IF NOT cl_null(g_indd_d[l_ac].indd032) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_indc_m.indc006
               LET g_chkparam.arg2 = g_indd_d[l_ac].indd032
               #160318-00025#19  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#19  by 07900 --add-end                    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_inaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_indd_d[l_ac].indd032 = g_indd_d_t.indd032
                  CALL aint330_indd032_ref()
                  NEXT FIELD indd032   
               END IF
               #161007-00012#2-s-add
               CALL s_aint320_vmi_type(g_indc_m.indc006,g_indd_d[l_ac].indd032) RETURNING g_indd032_type  
               IF g_indd032_type = '2' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code = 'ain-00841'  #庫位：%1，為結算倉，不可輸入！
                  LET g_errparam.replace[1] = g_indd_d[l_ac].indd032
                  LET g_errparam.popup = TRUE
                  LET g_indd_d[l_ac].indd032 = g_indd_d_t.indd032
                  CALL cl_err()         
                  NEXT FIELD CURRENT
               END IF
               #161007-00012#2-e-add
               #add by lixh 20150225
               IF NOT aint330_inaa010_chk() THEN
                  LET g_indd_d[l_ac].indd032 = g_indd_d_t.indd032 
                  CALL aint330_indd032_ref()
                  NEXT FIELD indd032                               
               END IF
               #add by lixh 20150225               
               CALL s_control_chk_doc('7',g_indc_m.indcdocno,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,'','','') RETURNING r_success,l_flag
               IF r_success THEN
                  IF NOT l_flag THEN
                     LET  g_indd_d[l_ac].indd032 = g_indd_d_t.indd032 
                     CALL aint330_indd032_ref()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  LET g_indd_d[l_ac].indd032 = g_indd_d_t.indd032
                  CALL aint330_indd032_ref()
                  NEXT FIELD CURRENT
               END IF  
               #161013-00028#1-s
               IF s_lot_batch_number_1n3(g_indd_d[l_ac].indd002,g_site) THEN 
                  IF g_indd_d[l_ac].indd032 <> g_indd_d_o.indd032 OR g_indd_d_o.indd032 IS NULL OR
                     g_indd_d[l_ac].indd033 <> g_indd_d_o.indd033 OR g_indd_d_o.indd033 IS NULL THEN              
                     IF g_indd_d[l_ac].indd103 < 0 THEN #161013-00028#1  
                        CALL s_lot_inao_chk(g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,'2',g_site) RETURNING l_success,l_cnt
                        IF l_cnt > 0 THEN
                           IF l_success THEN
                              DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_indc_m.indcdocno 
                                                   AND inaoseq = g_indd_d[l_ac].inddseq
                              IF NOT s_aint330_lot_sel('1','2',g_indc_m.indc006,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                               g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                               g_indd_d[l_ac].indd031,'-1','aint330',g_site,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) THEN                                                                                        
                                 NEXT FIELD indd032
                              END IF
                           ELSE
                              LET g_indd_d_o.indd032 = g_indd_d[l_ac].indd032
                              LET g_indd_d_o.indd033 = g_indd_d[l_ac].indd033
                           END IF
                        ELSE
                           IF NOT s_aint330_lot_sel('1','2',g_indc_m.indc006,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                            g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                            g_indd_d[l_ac].indd031,'-1','aint330',g_site,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) THEN                                                                                        
                              NEXT FIELD indd032
                           END IF                         
                        END IF  
                     END IF                                         
                  END IF
               END IF       
               #161013-00028#1-e                
               CALL aint330_set_entry_b(l_cmd)
               CALL aint330_set_no_required()
               CALL aint330_set_required()
               CALL aint330_set_no_entry_b(l_cmd)      
               CALL aint330_indd032_ref()            
            END IF 

            CALL aint330_set_entry_b(l_cmd)
            #160519-00008#4-s
            CALL aint330_set_no_required_b()
            CALL aint330_set_required_b()
            #160519-00008#4-e            
            CALL aint330_set_no_entry_b(l_cmd)

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
            CALL aint330_indd033_ref()
            IF NOT cl_null(g_indd_d[l_ac].indd033) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               SELECT inaa007 INTO l_inaa007 FROM inaa_t
                WHERE inaaent = g_enterprise
                  AND inaasite = g_indc_m.indc006
                  AND inaa001 = g_indd_d[l_ac].indd032        
               IF l_inaa007 = '1' THEN                  
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_indc_m.indc006
                  LET g_chkparam.arg2 = g_indd_d[l_ac].indd032
                  LET g_chkparam.arg3 = g_indd_d[l_ac].indd033
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#19  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inab002") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET  g_indd_d[l_ac].indd033 = g_indd_d_t.indd033 
                     CALL aint330_indd033_ref()
                     NEXT FIELD indd033
                  END IF
               END IF
               CALL s_control_chk_doc('7',g_indc_m.indcdocno,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,'','','') RETURNING r_success,l_flag
               IF r_success THEN
                  IF NOT l_flag THEN
                     LET  g_indd_d[l_ac].indd033 = g_indd_d_t.indd033 
                     CALL aint330_indd033_ref()
                     NEXT FIELD indd033
                  END IF
               ELSE
                  LET  g_indd_d[l_ac].indd033 = g_indd_d_t.indd033 
                  CALL aint330_indd033_ref()
                  NEXT FIELD indd033
               END IF   

               #161013-00028#1-s
               IF s_lot_batch_number_1n3(g_indd_d[l_ac].indd002,g_site) THEN 
                  IF g_indd_d[l_ac].indd032 <> g_indd_d_o.indd032 OR g_indd_d_o.indd032 IS NULL OR
                     g_indd_d[l_ac].indd033 <> g_indd_d_o.indd033 OR g_indd_d_o.indd033 IS NULL THEN              
                     IF g_indd_d[l_ac].indd103 < 0 THEN #161013-00028#1  
                        CALL s_lot_inao_chk(g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,'2',g_site) RETURNING l_success,l_cnt
                        IF l_cnt > 0 THEN
                           IF l_success THEN
                              DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaodocno = g_indc_m.indcdocno 
                                                   AND inaoseq = g_indd_d[l_ac].inddseq
                              IF NOT s_aint330_lot_sel('1','2',g_indc_m.indc006,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                               g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                               g_indd_d[l_ac].indd031,'-1','aint330',g_site,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) THEN                                                                                        
                                 NEXT FIELD indd032
                              END IF
                           ELSE
                              LET g_indd_d_o.indd032 = g_indd_d[l_ac].indd032
                              LET g_indd_d_o.indd033 = g_indd_d[l_ac].indd033
                           END IF
                        ELSE
                           IF NOT s_aint330_lot_sel('1','2',g_indc_m.indc006,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,    
                                            g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd006,
                                            g_indd_d[l_ac].indd031,'-1','aint330',g_site,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) THEN                                                                                        
                              NEXT FIELD indd032
                           END IF                         
                        END IF  
                     END IF                                         
                  END IF
               END IF                
               #161013-00028#1-e 
#               IF NOT aint330_inag_chk(g_site,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,g_indd_d[l_ac].indd024) THEN
#                  LET  g_indd_d[l_ac].indd033 = g_indd_d_t.indd033 
#                  CALL aint330_indd033_ref()
#                  NEXT FIELD indd033                  
#               END IF               
               CALL aint330_indd033_ref()             
            END IF 



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
         AFTER FIELD indd041
            
            #add-point:AFTER FIELD indd041 name="input.a.page1.indd041"
            IF NOT cl_null(g_indd_d[l_ac].indd041) AND
               NOT cl_null(g_indd_d[l_ac].indd002) THEN
               
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
              
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_indd_d[l_ac].indd002
               LET g_chkparam.arg2 = g_indd_d[l_ac].indd041
              
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imao002") THEN
                  LET g_indd_d[l_ac].indd041 = g_indd_d_t.indd041
                  NEXT FIELD CURRENT
               END IF            
               #add by lixh 20150226
               IF NOT cl_null(g_indd_d[l_ac].indd006) THEN 
                  CALL s_aimi190_get_convert1(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd041,g_indd_d[l_ac].indd006)
                    RETURNING r_success,l_qty1,l_qty2                       
                  IF NOT r_success THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_indd_d[l_ac].indd041
                     LET g_errparam.code   = 'ain-00500' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                  
                     LET g_indd_d[l_ac].indd041 = g_indd_d_t.indd041
                     CALL aint330_indd041_ref()                  
                     NEXT FIELD indd041                  
                  END IF    
               END IF               
               #add by lixh 20150226
            END IF

            CALL aint330_unit_convert()
            
            LET g_indd_d_o.indd041 = g_indd_d[l_ac].indd041
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd041
            #add-point:BEFORE FIELD indd041 name="input.b.page1.indd041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd041
            #add-point:ON CHANGE indd041 name="input.g.page1.indd041"
            
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
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd031
            #add-point:BEFORE FIELD indd031 name="input.b.page1.indd031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd031
            #add-point:ON CHANGE indd031 name="input.g.page1.indd031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd109
            #add-point:BEFORE FIELD indd109 name="input.b.page1.indd109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd109
            
            #add-point:AFTER FIELD indd109 name="input.a.page1.indd109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd109
            #add-point:ON CHANGE indd109 name="input.g.page1.indd109"
            
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd042
            
            #add-point:AFTER FIELD indd042 name="input.a.page1.indd042"
            CALL s_desc_get_project_desc(g_indd_d[l_ac].indd042) RETURNING g_indd_d[l_ac].indd042_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd042_desc
            
            IF NOT cl_null(g_indd_d[l_ac].indd042) THEN 
               IF g_indd_d[l_ac].indd042 != g_indd_d_o.indd042 OR cl_null(g_indd_d_o.indd042) THEN
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_indd_d[l_ac].indd042
                   #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
                  #160318-00025#19  by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pjba001") THEN
                     #檢查成功時後續處理
                     LET g_indd_d[l_ac].indd042 = g_indd_d_o.indd042
                     CALL s_desc_get_project_desc(g_indd_d[l_ac].indd042) RETURNING g_indd_d[l_ac].indd042_desc
                     DISPLAY BY NAME g_indd_d[l_ac].indd042_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_indd_d[l_ac].indd043 = ''
                  LET g_indd_d[l_ac].indd043_desc = ''
                  LET g_indd_d[l_ac].indd044 = ''
                  LET g_indd_d[l_ac].indd044_desc = ''
               END IF
            END IF 
            LET g_indd_d_o.indd042 = g_indd_d[l_ac].indd042
            CALL aint330_set_entry_b(l_cmd)
            #160519-00008#4-s
            CALL aint330_set_no_required_b()
            CALL aint330_set_required_b()
            #160519-00008#4-e            
            CALL aint330_set_no_entry_b(l_cmd)
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd042
            #add-point:BEFORE FIELD indd042 name="input.b.page1.indd042"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd042
            #add-point:ON CHANGE indd042 name="input.g.page1.indd042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd043
            
            #add-point:AFTER FIELD indd043 name="input.a.page1.indd043"
            CALL s_desc_get_wbs_desc(g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd043) RETURNING g_indd_d[l_ac].indd043_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd043_desc
            
            IF NOT cl_null(g_indd_d[l_ac].indd043) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_indd_d[l_ac].indd042
               LET g_chkparam.arg2 = g_indd_d[l_ac].indd043
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pjbb002") THEN
                  #檢查失敗時後續處理
                  LET g_indd_d[l_ac].indd043 = g_indd_d_t.indd043
                  CALL s_desc_get_wbs_desc(g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd043) RETURNING g_indd_d[l_ac].indd043_desc
                  DISPLAY BY NAME g_indd_d[l_ac].indd043_desc
                  NEXT FIELD CURRENT
               END IF

            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd043
            #add-point:BEFORE FIELD indd043 name="input.b.page1.indd043"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd043
            #add-point:ON CHANGE indd043 name="input.g.page1.indd043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd044
            
            #add-point:AFTER FIELD indd044 name="input.a.page1.indd044"
            CALL s_desc_get_activity_desc(g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd044) RETURNING g_indd_d[l_ac].indd044_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd044_desc
            
            IF NOT cl_null(g_indd_d[l_ac].indd044) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_indd_d[l_ac].indd042
               LET g_chkparam.arg2 = g_indd_d[l_ac].indd044
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pjbm002") THEN
                  #檢查失敗時後續處理
                  LET g_indd_d[l_ac].indd044 = g_indd_d_t.indd044
                  CALL s_desc_get_activity_desc(g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd044) RETURNING g_indd_d[l_ac].indd044_desc
                  DISPLAY BY NAME g_indd_d[l_ac].indd044_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd044
            #add-point:BEFORE FIELD indd044 name="input.b.page1.indd044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd044
            #add-point:ON CHANGE indd044 name="input.g.page1.indd044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indd152
            #add-point:BEFORE FIELD indd152 name="input.b.page1.indd152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indd152
            
            #add-point:AFTER FIELD indd152 name="input.a.page1.indd152"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indd152
            #add-point:ON CHANGE indd152 name="input.g.page1.indd152"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inddsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inddsite
            #add-point:ON ACTION controlp INFIELD inddsite name="input.c.page1.inddsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inddseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inddseq
            #add-point:ON ACTION controlp INFIELD inddseq name="input.c.page1.inddseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd101
            #add-point:ON ACTION controlp INFIELD indd101 name="input.c.page1.indd101"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd101             #給予default值            
            #160204-00004#5 20160223 s983961--add(s)
            IF NOT cl_null(g_indc_m.indcdocno) AND g_indc_m.indc002 = '2' THEN
               LET l_success = ''
               LET l_where = ''
               CALL s_aooi210_get_check_sql(g_site,'', g_indc_m.indcdocno ,'4','','indadocno') RETURNING l_success,l_where
               IF l_success AND NOT cl_null(l_where) THEN
                  LET g_qryparam.where = l_where
                  CALL q_indadocno_3()                                #呼叫開窗
               END IF
            END IF
            #160204-00004#5 20160223 s983961--add(e)         
            #CALL q_indadocno_3()                                #呼叫開窗  #160204-00004#5 20160223 s983961--mark
            #160921-00014#1-s
            IF NOT cl_null(g_indc_m.indcdocno) AND g_indc_m.indc002 = '10' THEN  #報廢申請轉入
               CALL q_inbidocno_1()                                #呼叫開窗              
            END IF            
            #160921-00014#1-e
            LET g_indd_d[l_ac].indd101 = g_qryparam.return1              

            DISPLAY g_indd_d[l_ac].indd101 TO indd101              #

            NEXT FIELD indd101                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd001
            #add-point:ON ACTION controlp INFIELD indd001 name="input.c.page1.indd001"
            
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

#            LET g_qryparam.where = " 1=1"       
#            IF NOT cl_null(g_indd_d[l_ac].indd004) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_indd_d[l_ac].indd004,"'"
#            END IF
#            IF NOT cl_null(g_indd_d[l_ac].indd102) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_indd_d[l_ac].indd102,"'"
#            END IF  
#            IF NOT cl_null(g_indd_d[l_ac].indd022) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_indd_d[l_ac].indd022,"'"
#            END IF 
#            IF NOT cl_null(g_indd_d[l_ac].indd023) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_indd_d[l_ac].indd023,"'"
#            END IF   
#            IF NOT cl_null(g_indd_d[l_ac].indd024) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_indd_d[l_ac].indd024,"'"
#            END IF    
#            IF NOT cl_null(g_indd_d[l_ac].indd006) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_indd_d[l_ac].indd006,"'"
#            END IF             
#            #給予arg
#
#            CALL q_inag001()
            LET g_qryparam.arg1 = g_site              #撥出營運據點
            LET g_qryparam.arg2 = g_indc_m.indc006　　#撥入營運據點

            #150320---earl---add---s
            IF g_indc_m.indc009 = 'Y' THEN
               LET g_qryparam.where = " imaf054 = 'N' "
            END IF
            #150320---earl---add---e

            CALL q_imaf001_14()                                #呼叫開窗

            LET g_indd_d[l_ac].indd002 = g_qryparam.return1              

            DISPLAY g_indd_d[l_ac].indd002 TO indd002              #

            NEXT FIELD indd002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd004
            #add-point:ON ACTION controlp INFIELD indd004 name="input.c.page1.indd004"
#            IF l_cmd = 'u' THEN   
               LET g_indd_d_t.indd004 = g_indd_d[l_ac].indd004
               CALL s_feature_single(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,'ALL','') 
                  RETURNING r_success,g_indd_d[l_ac].indd004
               IF cl_null(g_indd_d[l_ac].indd004) THEN 
                  LET g_indd_d[l_ac].indd004 = g_indd_d_t.indd004
               END IF   
               DISPLAY g_indd_d[l_ac].indd004 TO indd004
#            END IF  
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
            LET g_qryparam.default2 = g_indd_d[l_ac].indd023
            LET g_qryparam.default3 = g_indd_d[l_ac].indd024
            LET g_qryparam.default4 = g_indd_d[l_ac].indd102
            LET g_qryparam.where = " 1=1"  
#            IF NOT cl_null(g_indd_d[l_ac].indd002) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_indd_d[l_ac].indd002,"'"
#            END IF       
#            IF NOT cl_null(g_indd_d[l_ac].indd004) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_indd_d[l_ac].indd004,"'"
#            END IF
            LET g_qryparam.arg1 = g_indd_d[l_ac].indd002
            LET g_qryparam.arg2 = g_indd_d[l_ac].indd004
            IF NOT cl_null(g_indd_d[l_ac].indd102) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_indd_d[l_ac].indd102,"'"
            END IF  
            #161007-00012#2-s-mod 多是否為VMI倉的判斷
            ##add by lixh 20150225 
            #IF NOT cl_null(g_indd_d[l_ac].indd032) THEN
            #   SELECT inaa010 INTO l_inaa010 FROM inaa_t
            #    WHERE inaaent = g_enterprise
            #      AND inaasite = g_indc_m.indc006
            #      AND inaa001 = g_indd_d[l_ac].indd032
            #   LET g_qryparam.where = g_qryparam.where," AND inaa010 = '",l_inaa010,"'"    
            #END IF
            ##add by lixh 20150225  
            LET l_inaa010 = ''
            #---撥出倉有值，且非VMI倉，多需篩選，成本庫否的值相等
            IF NOT cl_null(g_indd_d[l_ac].indd032) THEN
               IF g_indd032_type = '0' THEN  #非VMI倉
                  SELECT inaa010 INTO l_inaa010 FROM inaa_t
                   WHERE inaaent = g_enterprise
                     AND inaasite = g_indc_m.indc006
                     AND inaa001 = g_indd_d[l_ac].indd032
                  LET g_qryparam.where = g_qryparam.where," AND ((inaa010 = '",l_inaa010,"'"   
               END IF                  
            END IF
            #--出庫倉是"非VMI倉－>排除結算倉的部分 ； 出庫倉是"VMI倉" －>存貨倉+成本庫位相同的
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND NOT EXISTS (SELECT inac001 FROM inac_t ",
                                                            "                  WHERE inacent='",g_enterprise,"' AND inacsite='",g_site,"' AND inaa001=inac001 AND inac003='",g_para_out_2,"') "
            IF NOT cl_null(l_inaa010) THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," ) OR EXISTS (SELECT inac001 FROM inac_t ",
                                                               "             WHERE inacent='",g_enterprise,"' AND inacsite='",g_site,"' AND inaa001=inac001 AND inac003='",g_para_out_1,"')) "
            END IF
            #161007-00012#2-e-mod

           #pengu 141231 開窗不要限定儲位、批號條件
           # IF NOT cl_null(g_indd_d[l_ac].indd023) THEN
           #    LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_indd_d[l_ac].indd023,"'"
           # END IF   
           # IF NOT cl_null(g_indd_d[l_ac].indd024) THEN
           #    LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_indd_d[l_ac].indd024,"'"
           # END IF    
           # IF NOT cl_null(g_indd_d[l_ac].indd006) THEN
           #    LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_indd_d[l_ac].indd006,"'"
           # END IF               
        
#            CALL q_inag004_12()                               #呼叫開窗
            CALL q_inag004_13() 

            LET g_indd_d[l_ac].indd022 = g_qryparam.return1              
            LET g_indd_d[l_ac].indd023 = g_qryparam.return2 
            LET g_indd_d[l_ac].indd024 = g_qryparam.return3 
            LET g_indd_d[l_ac].indd102 = g_qryparam.return4 
            
            DISPLAY g_indd_d[l_ac].indd022 TO indd022              #
            DISPLAY g_indd_d[l_ac].indd023 TO indd023
            DISPLAY g_indd_d[l_ac].indd024 TO indd024
            DISPLAY g_indd_d[l_ac].indd102 TO indd102 
            
            NEXT FIELD indd022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd023
            #add-point:ON ACTION controlp INFIELD indd023 name="input.c.page1.indd023"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd022             #給予default值
            LET g_qryparam.default2 = g_indd_d[l_ac].indd023
            LET g_qryparam.default3 = g_indd_d[l_ac].indd024
            LET g_qryparam.default4 = g_indd_d[l_ac].indd102
                       
            LET g_qryparam.where = " 1=1"  
#            IF NOT cl_null(g_indd_d[l_ac].indd002) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_indd_d[l_ac].indd002,"'"
#            END IF       
#            IF NOT cl_null(g_indd_d[l_ac].indd004) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_indd_d[l_ac].indd004,"'"
#            END IF
            LET g_qryparam.arg1 = g_indd_d[l_ac].indd002
            LET g_qryparam.arg2 = g_indd_d[l_ac].indd004
            IF NOT cl_null(g_indd_d[l_ac].indd102) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_indd_d[l_ac].indd102,"'"
            END IF  
            IF NOT cl_null(g_indd_d[l_ac].indd022) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_indd_d[l_ac].indd022,"'"
            END IF 
           #pengu 141231 開窗不要限定批號條件 
           # IF NOT cl_null(g_indd_d[l_ac].indd024) THEN
           #    LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_indd_d[l_ac].indd024,"'"
           # END IF    
           # IF NOT cl_null(g_indd_d[l_ac].indd006) THEN
           #    LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_indd_d[l_ac].indd006,"'"
           # END IF   
            #161007-00012#2-s-add
            #--出庫倉是"非VMI倉－>排除結算倉的部分 ； 出庫倉是"VMI倉" －>存貨倉+成本庫位相同的
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND NOT EXISTS (SELECT inac001 FROM inac_t ",
                                                            "                  WHERE inacent='",g_enterprise,"' AND inacsite='",g_site,"' AND inag004=inac001 AND inac003='",g_para_out_2,"') "
            #161007-00012#2-e-add
            CALL q_inag004_13()                              #呼叫開窗

            LET g_indd_d[l_ac].indd022 = g_qryparam.return1              
            LET g_indd_d[l_ac].indd023 = g_qryparam.return2 
            LET g_indd_d[l_ac].indd024 = g_qryparam.return3 
            LET g_indd_d[l_ac].indd102 = g_qryparam.return4
            
            DISPLAY g_indd_d[l_ac].indd022 TO indd022              #
            DISPLAY g_indd_d[l_ac].indd023 TO indd023
            DISPLAY g_indd_d[l_ac].indd024 TO indd024
            DISPLAY g_indd_d[l_ac].indd102 TO indd102
            
            NEXT FIELD indd023                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd024
            #add-point:ON ACTION controlp INFIELD indd024 name="input.c.page1.indd024"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd022             #給予default值
            LET g_qryparam.default2 = g_indd_d[l_ac].indd023
            LET g_qryparam.default3 = g_indd_d[l_ac].indd024
            LET g_qryparam.default4 = g_indd_d[l_ac].indd102
            
            LET g_qryparam.where = " 1=1"  
#            IF NOT cl_null(g_indd_d[l_ac].indd002) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_indd_d[l_ac].indd002,"'"
#            END IF       
#            IF NOT cl_null(g_indd_d[l_ac].indd004) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_indd_d[l_ac].indd004,"'"
#            END IF
            LET g_qryparam.arg1 = g_indd_d[l_ac].indd002
            LET g_qryparam.arg2 = g_indd_d[l_ac].indd004
            IF NOT cl_null(g_indd_d[l_ac].indd102) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_indd_d[l_ac].indd102,"'"
            END IF  
            IF NOT cl_null(g_indd_d[l_ac].indd022) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_indd_d[l_ac].indd022,"'"
            END IF 
            IF NOT cl_null(g_indd_d[l_ac].indd023) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_indd_d[l_ac].indd023,"'"
            END IF   
            IF NOT cl_null(g_indd_d[l_ac].indd006) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_indd_d[l_ac].indd006,"'"
            END IF    
            #161007-00012#2-s-add
            #--出庫倉是"非VMI倉－>排除結算倉的部分 ； 出庫倉是"VMI倉" －>存貨倉+成本庫位相同的
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND NOT EXISTS (SELECT inac001 FROM inac_t ",
                                                            "                  WHERE inacent='",g_enterprise,"' AND inacsite='",g_site,"' AND inag004=inac001 AND inac003='",g_para_out_2,"') "
            #161007-00012#2-e-add
            CALL q_inag004_13()                              #呼叫開窗

            LET g_indd_d[l_ac].indd022 = g_qryparam.return1              
            LET g_indd_d[l_ac].indd023 = g_qryparam.return2 
            LET g_indd_d[l_ac].indd024 = g_qryparam.return3 
            LET g_indd_d[l_ac].indd102 = g_qryparam.return4
            
            DISPLAY g_indd_d[l_ac].indd022 TO indd022              #
            DISPLAY g_indd_d[l_ac].indd023 TO indd023
            DISPLAY g_indd_d[l_ac].indd024 TO indd024
            DISPLAY g_indd_d[l_ac].indd102 TO indd102
            
            NEXT FIELD indd024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd102
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd102
            #add-point:ON ACTION controlp INFIELD indd102 name="input.c.page1.indd102"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

#            LET g_qryparam.default1 = g_indd_d[l_ac].indd102             #給予default值
#            LET g_qryparam.where = " 1=1"  
#            IF NOT cl_null(g_indd_d[l_ac].indd002) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_indd_d[l_ac].indd002,"'"
#            END IF       
#            IF NOT cl_null(g_indd_d[l_ac].indd004) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_indd_d[l_ac].indd004,"'"
#            END IF
#            IF NOT cl_null(g_indd_d[l_ac].indd022) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_indd_d[l_ac].indd022,"'"
#            END IF 
#            IF NOT cl_null(g_indd_d[l_ac].indd023) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_indd_d[l_ac].indd023,"'"
#            END IF   
#            IF NOT cl_null(g_indd_d[l_ac].indd024) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_indd_d[l_ac].indd024,"'"
#            END IF    
#            IF NOT cl_null(g_indd_d[l_ac].indd006) THEN
#               LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_indd_d[l_ac].indd006,"'"
#            END IF    
#            CALL q_inag003_1()                                #呼叫開窗
#
#            LET g_indd_d[l_ac].indd102 = g_qryparam.return1              
#
#            DISPLAY g_indd_d[l_ac].indd102 TO indd102             #
            LET g_qryparam.default1 = g_indd_d[l_ac].indd022             #給予default值
            LET g_qryparam.default2 = g_indd_d[l_ac].indd023
            LET g_qryparam.default3 = g_indd_d[l_ac].indd024
            LET g_qryparam.default4 = g_indd_d[l_ac].indd102
            LET g_qryparam.where = " 1=1"  
            LET g_qryparam.arg1 = g_indd_d[l_ac].indd002
            LET g_qryparam.arg2 = g_indd_d[l_ac].indd004
            IF NOT cl_null(g_indd_d[l_ac].indd102) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_indd_d[l_ac].indd102,"'"
            END IF  
            IF NOT cl_null(g_indd_d[l_ac].indd023) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_indd_d[l_ac].indd023,"'"
            END IF   
            IF NOT cl_null(g_indd_d[l_ac].indd024) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_indd_d[l_ac].indd024,"'"
            END IF    
            IF NOT cl_null(g_indd_d[l_ac].indd006) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag007 = '",g_indd_d[l_ac].indd006,"'"
            END IF               
        
            CALL q_inag004_13()     #2014/12/09 by stellar add

            LET g_indd_d[l_ac].indd022 = g_qryparam.return1              
            LET g_indd_d[l_ac].indd023 = g_qryparam.return2 
            LET g_indd_d[l_ac].indd024 = g_qryparam.return3 
            LET g_indd_d[l_ac].indd102 = g_qryparam.return4  
            
            DISPLAY g_indd_d[l_ac].indd022 TO indd022              #
            DISPLAY g_indd_d[l_ac].indd023 TO indd023
            DISPLAY g_indd_d[l_ac].indd024 TO indd024
            DISPLAY g_indd_d[l_ac].indd102 TO indd102

            NEXT FIELD indd102                          #返回原欄位            
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

            LET g_qryparam.where = " 1=1"  
            IF NOT cl_null(g_indd_d[l_ac].indd002) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_indd_d[l_ac].indd002,"'"
            END IF       
            IF NOT cl_null(g_indd_d[l_ac].indd004) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag002 = '",g_indd_d[l_ac].indd004,"'"
            END IF
            IF NOT cl_null(g_indd_d[l_ac].indd102) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag003 = '",g_indd_d[l_ac].indd102,"'"
            END IF  
            IF NOT cl_null(g_indd_d[l_ac].indd022) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_indd_d[l_ac].indd022,"'"
            END IF 
            IF NOT cl_null(g_indd_d[l_ac].indd023) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_indd_d[l_ac].indd023,"'"
            END IF   
            IF NOT cl_null(g_indd_d[l_ac].indd024) THEN
               LET g_qryparam.where = g_qryparam.where," AND inag006 = '",g_indd_d[l_ac].indd024,"'"
            END IF    

            
            CALL q_inag007()                                #呼叫開窗

            LET g_indd_d[l_ac].indd006 = g_qryparam.return1              

            DISPLAY g_indd_d[l_ac].indd006 TO indd006              #

            NEXT FIELD indd006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd103
            #add-point:ON ACTION controlp INFIELD indd103 name="input.c.page1.indd103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd021
            #add-point:ON ACTION controlp INFIELD indd021 name="input.c.page1.indd021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd104
            #add-point:ON ACTION controlp INFIELD indd104 name="input.c.page1.indd104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd105
            #add-point:ON ACTION controlp INFIELD indd105 name="input.c.page1.indd105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd106
            #add-point:ON ACTION controlp INFIELD indd106 name="input.c.page1.indd106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd151
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd151
            #add-point:ON ACTION controlp INFIELD indd151 name="input.c.page1.indd151"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd151             #給予default值
            LET g_qryparam.default2 = "" #g_indd_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = g_acc

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_indd_d[l_ac].indd151 = g_qryparam.return1              
            #LET g_indd_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_indd_d[l_ac].indd151 TO indd151              #
            #DISPLAY g_indd_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD indd151                          #返回原欄位


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
            #161007-00012#2-s-mod 多是否為VMI倉的判斷
            ##add by lixh 20150225
            #IF NOT cl_null(g_indd_d[l_ac].indd022) THEN
            #   SELECT inaa010 INTO l_inaa010 FROM inaa_t
            #    WHERE inaaent = g_enterprise
            #      AND inaasite = g_site
            #      AND inaa001 = g_indd_d[l_ac].indd022                  
            #   LET g_qryparam.where = " inaa010 = '",l_inaa010,"'"
            #END IF
            ##add by lixh 20150225 
            LET l_inaa010 = ''
            LET g_qryparam.where = " 1=1 "
            IF NOT cl_null(g_indd_d[l_ac].indd022) THEN
               IF g_indd022_type = '0' THEN  #非VMI倉
                  SELECT inaa010 INTO l_inaa010 FROM inaa_t
                   WHERE inaaent = g_enterprise
                     AND inaasite = g_site
                     AND inaa001 = g_indd_d[l_ac].indd022
                  LET g_qryparam.where = " ((inaa010 = '",l_inaa010,"'"
               END IF
            END IF
            #--入庫倉是"非VMI倉－>排除結算倉的部分 ； 入庫倉是"VMI倉" －>存貨倉+成本庫位相同的
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND NOT EXISTS (SELECT inac001 FROM inac_t ",
                                                            "                  WHERE inacent='",g_enterprise,"' AND inacsite='",g_indc_m.indc006,"' AND inaa001=inac001 AND inac003='",g_para_in_2,"') "
            IF NOT cl_null(l_inaa010) THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," ) OR EXISTS (SELECT inac001 FROM inac_t ",
                                                               "             WHERE inacent='",g_enterprise,"' AND inacsite='",g_indc_m.indc006,"' AND inaa001=inac001 AND inac003='",g_para_in_1,"')) "
            END IF
            #161007-00012#2-e-mod
            CALL q_inaa001_4()                                #呼叫開窗

            LET g_indd_d[l_ac].indd032 = g_qryparam.return1              

            DISPLAY g_indd_d[l_ac].indd032 TO indd032              #

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
            LET g_qryparam.arg1 = g_indc_m.indc006
            LET g_qryparam.arg2 = g_indd_d[l_ac].indd032
            
            CALL q_inab002_6()                                #呼叫開窗

            LET g_indd_d[l_ac].indd033 = g_qryparam.return1              

            DISPLAY g_indd_d[l_ac].indd033 TO indd033              #

            NEXT FIELD indd033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd041
            #add-point:ON ACTION controlp INFIELD indd041 name="input.c.page1.indd041"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd041             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_indd_d[l_ac].indd002


            CALL q_imao002()                                #呼叫開窗

            LET g_indd_d[l_ac].indd041 = g_qryparam.return1              

            DISPLAY g_indd_d[l_ac].indd041 TO indd041              #

            NEXT FIELD indd041                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd031
            #add-point:ON ACTION controlp INFIELD indd031 name="input.c.page1.indd031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd109
            #add-point:ON ACTION controlp INFIELD indd109 name="input.c.page1.indd109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd040
            #add-point:ON ACTION controlp INFIELD indd040 name="input.c.page1.indd040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indd042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd042
            #add-point:ON ACTION controlp INFIELD indd042 name="input.c.page1.indd042"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd042             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pjba001()                                #呼叫開窗

            LET g_indd_d[l_ac].indd042 = g_qryparam.return1              

            DISPLAY g_indd_d[l_ac].indd042 TO indd042              #
            CALL s_desc_get_project_desc(g_indd_d[l_ac].indd042) RETURNING g_indd_d[l_ac].indd042_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd042_desc

            NEXT FIELD indd042                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd043
            #add-point:ON ACTION controlp INFIELD indd043 name="input.c.page1.indd043"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd043             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_indd_d[l_ac].indd042 #s


            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_indd_d[l_ac].indd043 = g_qryparam.return1              

            DISPLAY g_indd_d[l_ac].indd043 TO indd043              #
            CALL s_desc_get_wbs_desc(g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd043) RETURNING g_indd_d[l_ac].indd043_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd043_desc

            NEXT FIELD indd043                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd044
            #add-point:ON ACTION controlp INFIELD indd044 name="input.c.page1.indd044"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indd_d[l_ac].indd044             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_indd_d[l_ac].indd042 #s


            CALL q_pjbm002()                                #呼叫開窗

            LET g_indd_d[l_ac].indd044 = g_qryparam.return1              

            DISPLAY g_indd_d[l_ac].indd044 TO indd044              #
            CALL s_desc_get_activity_desc(g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd044) RETURNING g_indd_d[l_ac].indd044_desc
            DISPLAY BY NAME g_indd_d[l_ac].indd044_desc

            NEXT FIELD indd044                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indd152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indd152
            #add-point:ON ACTION controlp INFIELD indd152 name="input.c.page1.indd152"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_indd_d[l_ac].* = g_indd_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint330_bcl
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
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aint330_indd_t_mask_restore('restore_mask_o')
      
               UPDATE indd_t SET (indddocno,inddsite,inddseq,indd101,indd001,indd002,indd004,indd022, 
                   indd023,indd024,indd102,indd006,indd103,indd021,indd104,indd105,indd106,indd151,indd032, 
                   indd033,indd041,indd031,indd109,indd040,indd042,indd043,indd044,indd152) = (g_indc_m.indcdocno, 
                   g_indd_d[l_ac].inddsite,g_indd_d[l_ac].inddseq,g_indd_d[l_ac].indd101,g_indd_d[l_ac].indd001, 
                   g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023, 
                   g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103, 
                   g_indd_d[l_ac].indd021,g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd105,g_indd_d[l_ac].indd106, 
                   g_indd_d[l_ac].indd151,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033,g_indd_d[l_ac].indd041, 
                   g_indd_d[l_ac].indd031,g_indd_d[l_ac].indd109,g_indd_d[l_ac].indd040,g_indd_d[l_ac].indd042, 
                   g_indd_d[l_ac].indd043,g_indd_d[l_ac].indd044,g_indd_d[l_ac].indd152)
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
               CALL aint330_update_b('indd_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aint330_indd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_indd_d[g_detail_idx].inddseq = g_indd_d_t.inddseq 
 
                  ) THEN
                  LET gs_keys[01] = g_indc_m.indcdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_indd_d_t.inddseq
 
                  CALL aint330_key_update_b(gs_keys,'indd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_indc_m),util.JSON.stringify(g_indd_d_t)
               LET g_log2 = util.JSON.stringify(g_indc_m),util.JSON.stringify(g_indd_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               UPDATE indd_t SET indd034 = g_indd_d[g_detail_idx].indd024,                              
                                 indc107 = g_indd_d[g_detail_idx].indd103,
                                 indc108 = g_indd_d[g_detail_idx].indd105
                                 
                WHERE inddent = g_enterprise AND indddocno = g_indc_m.indcdocno 
 
                  AND inddseq = g_indd_d_t.inddseq #項次    
                  
               CALL s_lot_b_fill('1',g_site,'2',g_indc_m.indcdocno,g_indd_d_t.inddseq,0,'-1')   #add by lixh 20150901   

               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            IF l_cmd = 'u' AND l_ac > 0 AND cl_null(g_indd_d[l_ac].indd022) AND NOT cl_null(g_indd_d[l_ac].inddseq) THEN
               NEXT FIELD indd022
            END IF 
            #pengu 141231  在after row檢查撥出庫位、儲位、批號合理性
#             IF NOT aint330_inag_chk(g_site,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024) THEN
#                NEXT FIELD indd022
#             END IF
             IF cl_null(g_indd_d[l_ac].inddseq) THEN
                CALL g_indd_d.deleteElement(g_indd_d.getLength())     
#                LET l_ac = l_ac - 1                
             END IF
            #end add-point
            CALL aint330_unlock_b("indd_t","'1'")
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
      
 
      
 
 
 
 
{</section>}
 
{<section id="aint330.input.other" >}
      
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
            
            #end add-point  
            NEXT FIELD indcdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD inddsite
 
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
 
{<section id="aint330.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aint330_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE r_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aint330_b_fill() #單身填充
      CALL aint330_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint330_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
           LET g_oofa001 = ''
           SELECT oofa001 INTO g_oofa001 FROM oofa_t 
            WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_indc_m.indc006              
            CALL s_aooi200_get_slip_desc(g_indc_m.indcdocno) RETURNING g_indc_m.indcdocno_desc
#            CALL aint330_indc107_desc(g_indc_m.indc107) RETURNING g_indc_m.indc107_desc         
#            CALL aint330_indc107_desc(g_indc_m.indc108) RETURNING g_indc_m.indc108_desc
            CALL s_apmi011_location_ref(g_indc_m.indc106,g_indc_m.indc107) RETURNING g_indc_m.indc107_desc
            CALL s_apmi011_location_ref(g_indc_m.indc106,g_indc_m.indc108) RETURNING g_indc_m.indc108_desc
            CALL aint330_indc151_ref()
#            CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
#            DISPLAY BY NAME g_indc_m.indc101_desc  
            IF NOT cl_null(g_indc_m.indc105) THEN
               CALL s_aooi350_get_address(g_oofa001,g_indc_m.indc105,g_lang)RETURNING r_success,g_indc_m.l_indc105_desc 
            END IF               
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indc004
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_indc_m.indc004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indc004_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indc006
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_indc_m.indc006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indc006_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofa001
            LET g_ref_fields[2] = g_indc_m.indc105
            CALL ap_ref_array2(g_ref_fields,"SELECT oofb011 FROM oofb_t WHERE oofbent='"||g_enterprise||"' AND oofb002=?  AND oofb019 = ? ","") RETURNING g_rtn_fields
            LET g_indc_m.indc105_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indc_m.indc105_desc            

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indc106
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_indc_m.indc106_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indc_m.indc106_desc
            
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
   CALL aint330_indc_t_mask()
   LET g_indc_m_mask_n.* =  g_indc_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_indc_m.indcdocno,g_indc_m.indcdocdt,g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indcsite, 
       g_indc_m.indcdocno_desc,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indc101_desc,g_indc_m.indcstus, 
       g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc006_desc,g_indc_m.indc151,g_indc_m.indc151_desc, 
       g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104,g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105, 
       g_indc_m.indc105_desc,g_indc_m.l_indc105_desc,g_indc_m.indc106,g_indc_m.indc106_desc,g_indc_m.indc107, 
       g_indc_m.indc107_desc,g_indc_m.indc108,g_indc_m.indc108_desc,g_indc_m.indcownid,g_indc_m.indcownid_desc, 
       g_indc_m.indcowndp,g_indc_m.indcowndp_desc,g_indc_m.indccrtid,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp, 
       g_indc_m.indccrtdp_desc,g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcmodid_desc,g_indc_m.indcpstid, 
       g_indc_m.indcpstid_desc,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid,g_indc_m.indccnfid_desc, 
       g_indc_m.indccnfdt
   
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

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indd_d[l_ac].indd002
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_indd_d[l_ac].indd002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indd_d[l_ac].indd002_desc
#            CALL aint330_indd022_ref()
#            CALL aint330_indd104_ref()
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indd_d[l_ac].indd022
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_indd_d[l_ac].indd022_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indd_d[l_ac].indd022_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indd_d[l_ac].indd022
#            LET g_ref_fields[2] = g_indd_d[l_ac].indd023
#            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
#            LET g_indd_d[l_ac].indd023_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indd_d[l_ac].indd023_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indd_d[l_ac].indd006
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_indd_d[l_ac].indd006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indd_d[l_ac].indd006_desc
            
            CALL aint330_indd032_ref()
            CALL aint330_indd033_ref()
            CALL aint330_indd151_ref()
            CALL s_feature_description(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004)
                 RETURNING r_success,g_indd_d[l_ac].indd004_desc 
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aint330_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aint330.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aint330_detail_show()
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
 
{<section id="aint330.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint330_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE indc_t.indcdocno 
   DEFINE l_oldno     LIKE indc_t.indcdocno 
 
   DEFINE l_master    RECORD LIKE indc_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE indd_t.* #此變數樣板目前無使用
 
 
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
   LET g_indc_m.indccnfid = ''
   LET g_indc_m.indccnfdt = ''
   LET g_indc_m.indcpstid = ''
   LET g_indc_m.indcpstdt = '' 
   LET g_indc_m.indc022 = ''   
      LET g_indc_m.indcdocdt = g_today
      LET g_indc_m.indc004 = g_user
      LET g_indc_m.indc101 = g_dept    
 
      CALL s_desc_get_person_desc(g_indc_m.indc004) RETURNING g_indc_m.indc004_desc
      DISPLAY BY NAME g_indc_m.indc004_desc   
      CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
      DISPLAY BY NAME g_indc_m.indc101_desc 
     
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
      LET g_indc_m.indcdocno_desc = ''
   DISPLAY BY NAME g_indc_m.indcdocno_desc
 
   
   CALL aint330_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_indc_m.* TO NULL
      INITIALIZE g_indd_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aint330_show()
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
   CALL aint330_set_act_visible()   
   CALL aint330_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_indcdocno_t = g_indc_m.indcdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " indcent = " ||g_enterprise|| " AND",
                      " indcdocno = '", g_indc_m.indcdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint330_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aint330_idx_chk()
   
   LET g_data_owner = g_indc_m.indcownid      
   LET g_data_dept  = g_indc_m.indcowndp
   
   #功能已完成,通報訊息中心
   CALL aint330_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aint330_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE indd_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   CALL g_indd_d.clear()    #g_indd_d 單頭及單身   
   IF g_indc_m.indc002 = '2' THEN
      RETURN
   END IF  
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aint330_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
 
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM indd_t
    WHERE inddent = g_enterprise AND indddocno = g_indcdocno_t
 
    INTO TEMP aint330_detail
 
   #將key修正為調整後   
   UPDATE aint330_detail 
      #更新key欄位
      SET indddocno = g_indc_m.indcdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   #160315-00005#1
   UPDATE aint330_detail 
      #更新key欄位
      SET indd021 = indd103,
          indd031 = indd103,
          indd110 = 0,
          indd112 = 0 
   #160315-00005#1   
   
   #add by lixh 20150616
   IF g_indc_m.indc102 = '2' THEN
      UPDATE aint330_detail 
         #更新key欄位
         SET indd021 = 0,
             indd031 = 0         
   END IF
   IF g_indc_m.indc102 = '3' THEN
      UPDATE aint330_detail 
         #更新key欄位
         SET indd031 = 0    
   END IF 
   #add by lixh 20150616   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO indd_t SELECT * FROM aint330_detail
   
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
   DROP TABLE aint330_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_indcdocno_t = g_indc_m.indcdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint330.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint330_delete()
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
 
   OPEN aint330_cl USING g_enterprise,g_indc_m.indcdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint330_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint330_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint330_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcdocno,g_indc_m.indcdocdt, 
       g_indc_m.indc004,g_indc_m.indcsite,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002, 
       g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc151,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104, 
       g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc106,g_indc_m.indc107,g_indc_m.indc108, 
       g_indc_m.indcownid,g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt, 
       g_indc_m.indcmodid,g_indc_m.indcpstid,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid, 
       g_indc_m.indccnfdt,g_indc_m.indc004_desc,g_indc_m.indc101_desc,g_indc_m.indc006_desc,g_indc_m.indc106_desc, 
       g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc, 
       g_indc_m.indcmodid_desc,g_indc_m.indcpstid_desc,g_indc_m.indccnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aint330_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_indc_m_mask_o.* =  g_indc_m.*
   CALL aint330_indc_t_mask()
   LET g_indc_m_mask_n.* =  g_indc_m.*
   
   CALL aint330_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   IF g_indc_m.indcstus <> 'N' THEN
      RETURN 
   END IF
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint330_set_pk_array()
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
      #add by lixh 20150911
      DELETE FROM inao_t 
       WHERE inaoent = g_enterprise
         AND inaosite = g_site
         AND inaodocno = g_indc_m.indcdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inao_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF           
      #add by lixh 20150911
      
      IF g_indc_m.indc002 = '10' THEN  #報廢申請單
         UPDATE inbi_t SET inbi009 = ''
          WHERE inbient = g_enterprise
            AND inbidocno = g_indc_m.indc003
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "inbi_t" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = FALSE 
           CALL cl_err()
           CALL s_transaction_end('N','0')
           RETURN
        END IF             
     END IF     
     #151202-00009#1 ---add--(s) 
      IF NOT s_aooi200_del_docno(g_indc_m.indcdocno,g_indc_m.indcdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN 
      END IF       
     #151202-00009#1 ---add--(E)  

      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_indc_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aint330_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_indd_d.clear() 
 
     
      CALL aint330_ui_browser_refresh()  
      #CALL aint330_ui_headershow()  
      #CALL aint330_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aint330_browser_fill("")
         CALL aint330_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint330_cl
 
   #功能已完成,通報訊息中心
   CALL aint330_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aint330.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint330_b_fill()
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
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aint330_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT inddsite,inddseq,indd101,indd001,indd002,indd004,indd022,indd023, 
             indd024,indd102,indd006,indd103,indd021,indd104,indd105,indd106,indd151,indd032,indd033, 
             indd041,indd031,indd109,indd040,indd042,indd043,indd044,indd152 ,t1.imaal003 ,t2.imaal004 , 
             t3.inayl003 ,t4.inab003 ,t5.oocal003 ,t6.oocal003 ,t7.inayl003 ,t8.oocal003 ,t9.pjbal003 , 
             t10.pjbbl004 ,t11.pjbml004 FROM indd_t",   
                     " INNER JOIN indc_t ON indcent = " ||g_enterprise|| " AND indcdocno = indddocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=indd002 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=indd002 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t3 ON t3.inaylent="||g_enterprise||" AND t3.inayl001=indd022 AND t3.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t4 ON t4.inabent="||g_enterprise||" AND t4.inabsite=inddsite AND t4.inab001=indd022 AND t4.inab002=indd023  ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=indd006 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=indd104 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent="||g_enterprise||" AND t7.inayl001=indd032 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t8 ON t8.oocalent="||g_enterprise||" AND t8.oocal001=indd041 AND t8.oocal002='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t9 ON t9.pjbalent="||g_enterprise||" AND t9.pjbal001=indd042 AND t9.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t10 ON t10.pjbblent="||g_enterprise||" AND t10.pjbbl001=indd042 AND t10.pjbbl002=indd043 AND t10.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN pjbml_t t11 ON t11.pjbmlent="||g_enterprise||" AND t11.pjbml001=indd042 AND t11.pjbml002=indd044 AND t11.pjbml003='"||g_dlang||"' ",
 
                     " WHERE inddent=? AND indddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         #160510-00019#14 add-S
         LET g_sql = "SELECT  DISTINCT inddsite,inddseq,indd101,indd001,indd002,indd004,indd022,indd023, 
             indd024,indd102,indd006,indd103,indd021,indd104,indd105,indd106,indd151,indd032,indd033, 
             indd041,indd031,indd109,indd040,indd042,indd043,indd044,indd152 ,
             (SELECT imaal003 FROM imaal_t WHERE imaal001 = indd002 AND imaalent = ",g_enterprise," AND imaal002 = '",g_dlang,"') t1_imaal003 ,
             (SELECT imaal004 FROM imaal_t WHERE imaal001 = indd002 AND imaalent = ",g_enterprise," AND imaal002 = '",g_dlang,"') t1_imaal004 ,
             (SELECT inayl003 FROM inayl_t WHERE inayl001 = indd022 AND inaylent = ",g_enterprise," AND inayl002 = '",g_dlang,"') t2_inayl003 ,
             (SELECT inab003 FROM inab_t WHERE inab001 = indd022 AND inab002 = indd023 AND inabent = inddent AND inabsite = inddsite) t3_inab003 ,
             (SELECT oocal003 FROM oocal_t WHERE oocal001 = indd006 AND oocalent = ",g_enterprise," AND oocal002 = '",g_dlang,"') t4_oocal003 ,
             (SELECT oocal003 FROM oocal_t WHERE oocal001 = indd104 AND oocalent = ",g_enterprise," AND oocal002 = '",g_dlang,"') t5_oocal003 ,
             (SELECT inayl003 FROM inayl_t WHERE inayl001 = indd032 AND inaylent = ",g_enterprise," AND inayl002 = '",g_dlang,"') t6_inayl003 ,
             (SELECT oocal003 FROM oocal_t WHERE oocal001 = indd041 AND oocalent = ",g_enterprise," AND oocal002 = '",g_dlang,"') t7_oocal003 ,
             (SELECT pjbal003 FROM pjbal_t WHERE pjbal001 = indd042 AND pjbalent = ",g_enterprise," AND pjbal002 = '",g_dlang,"') t8_pjbal003 , 
             (SELECT pjbbl004 FROM pjbbl_t WHERE pjbbl001 = indd042 AND pjbbl002 = indd043 AND pjbblent = ",g_enterprise," AND pjbbl003 = '",g_dlang,"') t9_pjbbl004 ,
             (SELECT pjbml004 FROM pjbml_t WHERE pjbml001 = indd042 AND pjbml002 = indd044 AND pjbmlent = ",g_enterprise," AND pjbml003 = '",g_dlang,"') t10_pjbml004 
             FROM indd_t",   
                     " INNER JOIN indc_t ON indcent = '" ||g_enterprise|| "' AND indcdocno = indddocno ",
                     " WHERE inddent=? AND indddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #160510-00019#14 add-E
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY indd_t.inddseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint330_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aint330_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_indc_m.indcdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_indc_m.indcdocno INTO g_indd_d[l_ac].inddsite,g_indd_d[l_ac].inddseq, 
          g_indd_d[l_ac].indd101,g_indd_d[l_ac].indd001,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004, 
          g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,g_indd_d[l_ac].indd102, 
          g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103,g_indd_d[l_ac].indd021,g_indd_d[l_ac].indd104, 
          g_indd_d[l_ac].indd105,g_indd_d[l_ac].indd106,g_indd_d[l_ac].indd151,g_indd_d[l_ac].indd032, 
          g_indd_d[l_ac].indd033,g_indd_d[l_ac].indd041,g_indd_d[l_ac].indd031,g_indd_d[l_ac].indd109, 
          g_indd_d[l_ac].indd040,g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd043,g_indd_d[l_ac].indd044, 
          g_indd_d[l_ac].indd152,g_indd_d[l_ac].indd002_desc,g_indd_d[l_ac].indd002_desc_desc,g_indd_d[l_ac].indd022_desc, 
          g_indd_d[l_ac].indd023_desc,g_indd_d[l_ac].indd006_desc,g_indd_d[l_ac].indd104_desc,g_indd_d[l_ac].indd032_desc, 
          g_indd_d[l_ac].indd041_desc,g_indd_d[l_ac].indd042_desc,g_indd_d[l_ac].indd043_desc,g_indd_d[l_ac].indd044_desc  
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
         ##160413-00011#4 2016-4-14 zhujing mark
#         CALL s_desc_get_project_desc(g_indd_d[l_ac].indd042) RETURNING g_indd_d[l_ac].indd042_desc
#         DISPLAY BY NAME g_indd_d[l_ac].indd042_desc
#
#         CALL s_desc_get_wbs_desc(g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd043) RETURNING g_indd_d[l_ac].indd043_desc
#         DISPLAY BY NAME g_indd_d[l_ac].indd043_desc
#
#         CALL s_desc_get_activity_desc(g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd044) RETURNING g_indd_d[l_ac].indd044_desc
#         DISPLAY BY NAME g_indd_d[l_ac].indd044_desc
#         CALL s_lot_b_fill('1',g_site,'2',g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,0,'-1')
         ##160413-00011#4 2016-4-14 zhujing mark
         CALL aint330_indd033_ref()   #161230-00001#1 add
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
   IF NOT cl_null(g_indc_m.indcdocno) THEN #160801-00001#1 add
      CALL s_lot_b_fill('1',g_site,'2',g_indc_m.indcdocno,'','','-1')   ##160413-00011#4 2016-4-14 zhujing add
   END IF                                  #160801-00001#1 add
   #end add-point
   
   CALL g_indd_d.deleteElement(g_indd_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aint330_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_indd_d.getLength()
      LET g_indd_d_mask_o[l_ac].* =  g_indd_d[l_ac].*
      CALL aint330_indd_t_mask()
      LET g_indd_d_mask_n[l_ac].* =  g_indd_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint330_delete_b(ps_table,ps_keys_bak,ps_page)
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
      IF g_indc_m.indcstus <> 'N' THEN
         RETURN
      END IF
      #end add-point    
      DELETE FROM indd_t
       WHERE inddent = g_enterprise AND
         indddocno = ps_keys_bak[1] AND inddseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      #add by lixh 20150911            
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      DELETE FROM inao_t WHERE inaoent = g_enterprise
                           AND inaodocno = ps_keys_bak[1]
                           AND inaoseq = ps_keys_bak[2]
      #add by lixh 20150911
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
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint330.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint330_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_indd107   LIKE indd_t.indd107
   DEFINE r_success   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      #add by lixh 20150619
      IF g_indd_d[g_detail_idx].indd004 IS NULL THEN
         LET g_indd_d[g_detail_idx].indd004 = ' '
      END IF
      #add by lixh 20150619
      #end add-point 
      INSERT INTO indd_t
                  (inddent,
                   indddocno,
                   inddseq
                   ,inddsite,indd101,indd001,indd002,indd004,indd022,indd023,indd024,indd102,indd006,indd103,indd021,indd104,indd105,indd106,indd151,indd032,indd033,indd041,indd031,indd109,indd040,indd042,indd043,indd044,indd152) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_indd_d[g_detail_idx].inddsite,g_indd_d[g_detail_idx].indd101,g_indd_d[g_detail_idx].indd001, 
                       g_indd_d[g_detail_idx].indd002,g_indd_d[g_detail_idx].indd004,g_indd_d[g_detail_idx].indd022, 
                       g_indd_d[g_detail_idx].indd023,g_indd_d[g_detail_idx].indd024,g_indd_d[g_detail_idx].indd102, 
                       g_indd_d[g_detail_idx].indd006,g_indd_d[g_detail_idx].indd103,g_indd_d[g_detail_idx].indd021, 
                       g_indd_d[g_detail_idx].indd104,g_indd_d[g_detail_idx].indd105,g_indd_d[g_detail_idx].indd106, 
                       g_indd_d[g_detail_idx].indd151,g_indd_d[g_detail_idx].indd032,g_indd_d[g_detail_idx].indd033, 
                       g_indd_d[g_detail_idx].indd041,g_indd_d[g_detail_idx].indd031,g_indd_d[g_detail_idx].indd109, 
                       g_indd_d[g_detail_idx].indd040,g_indd_d[g_detail_idx].indd042,g_indd_d[g_detail_idx].indd043, 
                       g_indd_d[g_detail_idx].indd044,g_indd_d[g_detail_idx].indd152)
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
     #add by lixh 20150616 
      CALL s_aooi250_convert_qty(g_indd_d[g_detail_idx].indd002,g_indd_d[g_detail_idx].indd006,
                                 g_indd_d[g_detail_idx].indd041,g_indd_d[g_detail_idx].indd103)
           RETURNING r_success,l_indd107 
     #add by lixh 20150616            
      UPDATE indd_t SET indd110 = 0,
                        indd112 = 0,
                        indd034 = g_indd_d[g_detail_idx].indd024,
                        inddsite = g_site,
                        indd107 = l_indd107,
                        indd108 = g_indd_d[g_detail_idx].indd105
       WHERE inddent = g_enterprise
         AND indddocno = ps_keys[1]
         AND inddseq = ps_keys[2]    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "indd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF    
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aint330.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint330_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
      CALL aint330_indd_t_mask_restore('restore_mask_o')
               
      UPDATE indd_t 
         SET (indddocno,
              inddseq
              ,inddsite,indd101,indd001,indd002,indd004,indd022,indd023,indd024,indd102,indd006,indd103,indd021,indd104,indd105,indd106,indd151,indd032,indd033,indd041,indd031,indd109,indd040,indd042,indd043,indd044,indd152) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_indd_d[g_detail_idx].inddsite,g_indd_d[g_detail_idx].indd101,g_indd_d[g_detail_idx].indd001, 
                  g_indd_d[g_detail_idx].indd002,g_indd_d[g_detail_idx].indd004,g_indd_d[g_detail_idx].indd022, 
                  g_indd_d[g_detail_idx].indd023,g_indd_d[g_detail_idx].indd024,g_indd_d[g_detail_idx].indd102, 
                  g_indd_d[g_detail_idx].indd006,g_indd_d[g_detail_idx].indd103,g_indd_d[g_detail_idx].indd021, 
                  g_indd_d[g_detail_idx].indd104,g_indd_d[g_detail_idx].indd105,g_indd_d[g_detail_idx].indd106, 
                  g_indd_d[g_detail_idx].indd151,g_indd_d[g_detail_idx].indd032,g_indd_d[g_detail_idx].indd033, 
                  g_indd_d[g_detail_idx].indd041,g_indd_d[g_detail_idx].indd031,g_indd_d[g_detail_idx].indd109, 
                  g_indd_d[g_detail_idx].indd040,g_indd_d[g_detail_idx].indd042,g_indd_d[g_detail_idx].indd043, 
                  g_indd_d[g_detail_idx].indd044,g_indd_d[g_detail_idx].indd152) 
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
      CALL aint330_indd_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aint330.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aint330_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aint330.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aint330_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aint330.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint330_lock_b(ps_table,ps_page)
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
   #CALL aint330_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "indd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint330_bcl USING g_enterprise,
                                       g_indc_m.indcdocno,g_indd_d[g_detail_idx].inddseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint330_bcl:",SQLERRMESSAGE 
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
 
{<section id="aint330.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint330_unlock_b(ps_table,ps_page)
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
      CLOSE aint330_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint330_set_entry(p_cmd)
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
      CALL cl_set_comp_entry("indc003",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
#   IF g_indc_m.indc002 = '2' THEN 
#      CALL cl_set_comp_entry("indc003",TRUE)
#   END IF  
   CALL cl_set_comp_entry("indc003",TRUE)
   CALL cl_set_comp_entry("indc006,indc151,indc102,indc103,indc104,indc105,indc106,indc107,indc108",TRUE)
   CALL cl_set_comp_entry("indc009",TRUE)   #150323---earl---add
   CALL cl_set_comp_entry("indc002",TRUE)
   CALL cl_set_comp_entry("indcdocdt",TRUE)  #160604-00034#4 add
   CALL cl_set_comp_entry("indc022",TRUE)    #160604-00034#4 add
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint330_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE r_success   LIKE type_t.num5                  #回传参数1 回传成功否，标识单号检查是否成功 TRUE/FALSE
   DEFINE l_ooba002   LIKE ooba_t.ooba002 
   DEFINE l_fields    STRING     #161007-00002#1 add   
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
      CALL cl_set_comp_entry("indc003",FALSE)
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
   #161007-00002#1 by wuxja add  --begin--
   IF NOT cl_null(g_indc_m.indcdocno) THEN
      LET l_fields = s_aooi200_get_doc_fields(g_site,'1',g_indc_m.indcdocno)
      CALL cl_set_comp_entry(l_fields,FALSE)
   END IF
   #161007-00002#1 by wuxja add  --end--
#   IF g_indc_m.indc002 <> '2' THEN 
#      CALL cl_set_comp_entry("indc003",FALSE)
#   END IF  
   CALL aint330_get_ooef004() RETURNING g_ooef004
   IF NOT cl_null(g_indc_m.indcdocno) THEN   #add by lixh 20150317
      CALL s_aooi200_get_slip(g_indc_m.indcdocno) RETURNING r_success,l_ooba002
      SELECT COUNT(ooac001) INTO l_cnt FROM ooac_t
       WHERE ooacent = g_enterprise
         AND ooac001 = g_ooef004
         AND ooac002 = l_ooba002
         AND ooac003 = 'D-BAS-0081'
         AND ooac004 = 'Y'
      IF l_cnt > 0 THEN 
         LET g_indc_m.indc002 = '2'
         CALL cl_set_comp_entry("indc002",FALSE)
      END IF 
   END IF   #add by lixh 20150317
   #IF g_indc_m.indc002 = '2' THEN  #160202-00004#1 mark by lixh 20160202
   IF g_indc_m.indc002 = '2' AND NOT cl_null(g_indc_m.indc003) THEN  #160202-00004#1 add by lixh 20160202
      CALL cl_set_comp_entry("indc006,indc151,indc102,indc103,indc104,indc105,indc106,indc107,indc108",FALSE) 
      CALL cl_set_comp_entry("indc009",FALSE)   #150323---earl---add
   END IF  
   IF g_indc_m.indc002 <> '2' THEN 
      CALL cl_set_comp_entry("indc003",FALSE)
   END IF     
   #單身有資料時，來源單號不可以修改   
   SELECT COUNT(*) INTO l_cnt FROM indd_t
    WHERE inddent = g_enterprise
      AND indddocno = g_indc_m.indcdocno
   IF l_cnt > 0 THEN 
      CALL cl_set_comp_entry("indc003,indc006",FALSE)  
   END IF  
#   CALL cl_set_comp_entry("indc022",FALSE) 
   #160604-00034#4-S
   IF NOT cl_chk_update_pstdt() THEN
      CALL cl_set_comp_entry("indc022",FALSE)
   END IF
   #160604-00034#4-E
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint330.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint330_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("indd101,indd001,indd002,indd102,indd022,indd023,indd024,indd006,indd032,indd033",TRUE)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN   
      CALL cl_set_comp_visible("indd004,indd004_desc",TRUE)
   END IF 
   CALL cl_set_comp_entry("indd004",TRUE)    #add by lixh 20150722   
   
   CALL cl_set_comp_entry("indd042,indd043,indd044",TRUE)  #add by lixiang 2015/10/30
   CALL cl_set_comp_required("indd024",FALSE)  #160519-00022#2 add  
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aint330.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint330_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_indb101  LIKE indb_t.indb101
   DEFINE l_indb102  LIKE indb_t.indb102
   DEFINE l_indb103  LIKE indb_t.indb103
   DEFINE l_indb104  LIKE indb_t.indb104
   DEFINE l_imaf055  LIKE imaf_t.imaf055
   DEFINE l_imaa005  LIKE imaa_t.imaa005
   DEFINE l_inaa007  LIKE inaa_t.inaa007
   DEFINE l_pjaa013  LIKE pjaa_t.pjaa013  
   DEFINE l_indb107  LIKE indb_t.indb107
   DEFINE l_indb108  LIKE indb_t.indb108
   DEFINE l_imaf054  LIKE imaf_t.imaf054  #160429-00006#1
   DEFINE l_imaf061  LIKE imaf_t.imaf061  #160519-00022#2
#161006-00018#4-S
   DEFINE l_ooac002  LIKE ooac_t.ooac002
   DEFINE l_ooac004  LIKE ooac_t.ooac004 
   DEFINE l_flag     LIKE type_t.num5
#161006-00018#4-E  
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"

   IF g_indc_m.indc002 = '2' THEN 
   
   #160202-00004#1 add by lixh 20160202
      IF NOT cl_null(g_indd_d[l_ac].indd101) THEN
         LET l_indb107 = ' '
         LET l_indb108 = ' '
         SELECT indb107,indb108 INTO l_indb107,l_indb108 FROM indb_t
          WHERE indbent = g_enterprise
            AND indbdocno = g_indd_d[l_ac].indd101
            AND indbseq = g_indd_d[l_ac].indd001
         #161006-00018#4-S
         CALL s_aooi200_get_slip(g_indc_m.indcdocno) RETURNING l_flag,l_ooac002
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004
         IF l_ooac004 = 'N' THEN
            IF NOT cl_null(l_indb107) THEN
               CALL cl_set_comp_entry("indd032",FALSE)
            END IF   
            IF NOT cl_null(l_indb108) THEN
               CALL cl_set_comp_entry("indd033",FALSE)
            END IF              
         END IF         
         #161006-00018#4-E
         #161006-00018#4-S mark          
#         IF NOT cl_null(l_indb107) THEN 
#            CALL cl_set_comp_entry("indd032,indd033",FALSE)  
#         END IF  
         #161006-00018#4-E mark             
      END IF      
   #160202-00004#1 add by lixh 20160202
   
#      CALL cl_set_comp_entry("indd002,indd004,indd102,indd022,indd023,indd024,indd006,indd032,indd033",FALSE)      
#      CALL cl_set_comp_entry("indd002,indd004,indd006,indd032,indd033",FALSE)   #160202-00004#1 mark by lixh 20160202
      CALL cl_set_comp_entry("indd002,indd004,indd006",FALSE)   #160202-00004#1 add by lixh 20160202 
   END IF
   
   #160921-00014#1-S
   IF g_indc_m.indc002 = '10' THEN
      CALL cl_set_comp_entry("indd002,indd004,indd006",FALSE)
      IF l_ac > 0 AND NOT cl_null(g_indd_d[l_ac].indd101) AND NOT cl_null(g_indd_d[l_ac].indd001) THEN  
         CALL cl_set_comp_entry("indd102,indd022,indd023,indd024",FALSE)          
      END IF      
   END IF
   #160921-00014#1-E
   
   IF g_indc_m.indc002 = '1' THEN 
      CALL cl_set_comp_entry("indd101,indd001",FALSE)
   END IF
   IF g_indc_m.indc002 = '2' AND l_ac > 0 AND NOT cl_null(g_indd_d[l_ac].indd101) AND NOT cl_null(g_indd_d[l_ac].indd001) THEN 
      SELECT indb101,indb102,indb103,indb104 INTO l_indb101,l_indb102,l_indb103,l_indb104 FROM indb_t
       WHERE indbent = g_enterprise
         AND indbdocno = g_indd_d[l_ac].indd101
         AND indbseq = g_indd_d[l_ac].indd001
      IF NOT cl_null(l_indb101) THEN 
         CALL cl_set_comp_entry("indd102",FALSE)
      END IF   
      #161006-00018#4-S mark
#      IF NOT cl_null(l_indb102) THEN 
#         CALL cl_set_comp_entry("indd022",FALSE)
#      END IF
#      IF NOT cl_null(l_indb103) THEN 
#         CALL cl_set_comp_entry("indd023",FALSE)
#      END IF 
#      IF NOT cl_null(l_indb104) THEN 
#         CALL cl_set_comp_entry("indd024",FALSE)
#      END IF 
      #161006-00018#4-E mark
      #161006-00018#4-S
      CALL s_aooi200_get_slip(g_indc_m.indcdocno) RETURNING l_flag,l_ooac002
      CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004
      IF l_ooac004 = 'N' THEN
         IF NOT cl_null(l_indb102) THEN
            CALL cl_set_comp_entry("indd022",FALSE)
         END IF 
         IF NOT cl_null(l_indb103) THEN
            CALL cl_set_comp_entry("indd023",FALSE)
         END IF  
         IF NOT cl_null(l_indb104) THEN
            CALL cl_set_comp_entry("indd024",FALSE)
         END IF          
      END IF         
      #161006-00018#4-E
   END IF
   IF NOT cl_null(g_indd_d[l_ac].indd002) AND l_ac > 0 THEN
      ##160413-00011#4 2016-4-13 zhujing mod
#      SELECT imaf055 INTO l_imaf055 FROM imaf_t
#       WHERE imafent = g_enterprise
#         AND imafsite = g_site
#         AND imaf001 = g_indd_d[l_ac].indd002
      SELECT imaa005,imaf055,imaf054,imaf061 
        INTO l_imaa005,l_imaf055,l_imaf054,l_imaf061   #160429-00006#1 #160519-00022#2 add imaf061
        FROM imaa_t LEFT OUTER JOIN imaf_t ON imafent = imaaent AND imaf001 = imaa001 AND imafsite = g_site
       WHERE imaaent = g_enterprise
         AND imaa001 = g_indd_d[l_ac].indd002
      ##160413-00011#4 2016-4-13 zhujing mod
      IF cl_null(l_imaf055) OR l_imaf055 = '2' THEN
         CALL cl_set_comp_entry("indd102",FALSE) 
         LET g_indd_d[l_ac].indd102 = ''   #160519-00008#4
      END IF   
      #160429-00006#1
      IF l_imaf054 = 'N' THEN
         CALL cl_set_comp_entry("indd006",FALSE) 
      END IF 
      #160429-00006#1      
      ##160413-00011#4 2016-4-13 zhujing marked---(S)
   #料件是否做產品特徵管理
#      SELECT imaa005 INTO l_imaa005 FROM imaa_t
#       WHERE imaaent = g_enterprise
#         AND imaa001 = g_indd_d[l_ac].indd002
      ##160413-00011#4 2016-4-13 zhujing marked---(E)
      IF cl_null(l_imaa005) THEN
         CALL cl_set_comp_entry("indd004",FALSE) 
      END IF 
      #160519-00022#2---add---s
      CASE l_imaf061
         WHEN '1'
            CALL cl_set_comp_required("indd024",TRUE)
         WHEN '2'
            CALL cl_set_comp_entry("indd024",FALSE)
      END CASE
      #160519-00022#2---add---e      
   END IF   
   IF NOT cl_null(g_indd_d[l_ac].indd032) AND l_ac > 0 THEN
      SELECT inaa007 INTO l_inaa007 FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaasite = g_indc_m.indc006
         AND inaa001 = g_indd_d[l_ac].indd032
      IF l_inaa007 = '5' THEN
         CALL cl_set_comp_entry("indd033",FALSE) 
         LET g_indd_d[l_ac].indd033 = ' '       #add by lixh 20150310
      END IF      
   END IF   
   IF NOT cl_null(g_indd_d[l_ac].indd022) AND l_ac > 0 THEN
      SELECT inaa007 INTO l_inaa007 FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaasite = g_site
         AND inaa001 = g_indd_d[l_ac].indd022
      IF l_inaa007 = '5' THEN
         CALL cl_set_comp_entry("indd023",FALSE) 
         LET g_indd_d[l_ac].indd023 = ' '       #add by lixh 20150310
      END IF      
   END IF     
   
   #有專案代號且"專案庫存控管"="Y"時，自動將專案代號帶入庫存管理特徵欄位中，不可修改
   IF NOT cl_null(g_indd_d[l_ac].indd042) THEN
      SELECT pjaa013 INTO l_pjaa013 FROM pjaa_t,pjba_t 
         WHERE pjaaent = pjbaent AND pjaa001 = pjba000 AND pjaaent = g_enterprise AND pjba001 = g_indd_d[l_ac].indd042
      IF l_pjaa013 = 'Y' THEN
         LET g_indd_d[l_ac].indd102 = g_indd_d[l_ac].indd042
         CALL cl_set_comp_entry("indd102",FALSE)
      END IF
   END IF
   
   #add by lixiang 2015/10/30---begin---
   #如有來源單號，不能修改專案編號、WBS、活動編號
   IF NOT cl_null(g_indd_d[l_ac].indd101) THEN
      CALL cl_set_comp_entry("indd042,indd043,indd044",FALSE)
   END IF
   #add by lixiang 2015/10/30---end----
   

   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aint330.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint330_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("s_lot_sel",TRUE)  #add by lixh 20150921
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint330.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint330_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_indc_m.indcstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   IF g_indc_m.indcstus <> 'N' THEN
      CALL cl_set_act_visible("s_lot_sel", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint330.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aint330_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint330.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aint330_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint330.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint330_default_search()
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
      LET ls_wc = ls_wc, " indcdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "indc_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "indd_t" 
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
 
{<section id="aint330.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint330_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_indc005   LIKE indc_t.indc005
   DEFINE l_date      LIKE indc_t.indc022
   DEFINE l_time      DATETIME YEAR TO SECOND
   DEFINE l_flag      LIKE type_t.chr1        #160604-00034#5                                 
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
#   IF g_indc_m.indcstus = 'X' THEN
#      RETURN
#   END IF   
   IF g_indc_m.indcstus MATCHES '[XYC]'  THEN
      RETURN 
   END IF
   
   #160126-00024#1 add by lixh 20160224  
   IF g_indc_m.indc002 = '3' THEN     
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "ain-00738" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()   
      RETURN
   END IF
   #160126-00024#1 add by lixh 20160224 
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
   
   OPEN aint330_cl USING g_enterprise,g_indc_m.indcdocno
   IF STATUS THEN
      CLOSE aint330_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint330_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint330_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcdocno,g_indc_m.indcdocdt, 
       g_indc_m.indc004,g_indc_m.indcsite,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002, 
       g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc151,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104, 
       g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc106,g_indc_m.indc107,g_indc_m.indc108, 
       g_indc_m.indcownid,g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt, 
       g_indc_m.indcmodid,g_indc_m.indcpstid,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid, 
       g_indc_m.indccnfdt,g_indc_m.indc004_desc,g_indc_m.indc101_desc,g_indc_m.indc006_desc,g_indc_m.indc106_desc, 
       g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc, 
       g_indc_m.indcmodid_desc,g_indc_m.indcpstid_desc,g_indc_m.indccnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aint330_action_chk() THEN
      CLOSE aint330_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_indc_m.indcdocno,g_indc_m.indcdocdt,g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indcsite, 
       g_indc_m.indcdocno_desc,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indc101_desc,g_indc_m.indcstus, 
       g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc006_desc,g_indc_m.indc151,g_indc_m.indc151_desc, 
       g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104,g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105, 
       g_indc_m.indc105_desc,g_indc_m.l_indc105_desc,g_indc_m.indc106,g_indc_m.indc106_desc,g_indc_m.indc107, 
       g_indc_m.indc107_desc,g_indc_m.indc108,g_indc_m.indc108_desc,g_indc_m.indcownid,g_indc_m.indcownid_desc, 
       g_indc_m.indcowndp,g_indc_m.indcowndp_desc,g_indc_m.indccrtid,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp, 
       g_indc_m.indccrtdp_desc,g_indc_m.indccrtdt,g_indc_m.indcmodid,g_indc_m.indcmodid_desc,g_indc_m.indcpstid, 
       g_indc_m.indcpstid_desc,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid,g_indc_m.indccnfid_desc, 
       g_indc_m.indccnfdt
 
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
#         CALL cl_set_act_visible("confirmed,closed,confirm_transfer_in", FALSE)
#         CALL cl_set_act_visible("unconfirmed,invalid,confirm_transfer_out,posted",TRUE)
#         CASE g_indc_m.indcstus
#            WHEN "N"
#               CALL cl_set_act_visible("unconfirmed,posted",FALSE)
#
#            WHEN "X"
#               CALL cl_set_act_visible("invalid,confirm_transfer_out,posted",FALSE)
#               
#            WHEN "O"
#               CALL cl_set_act_visible("confirm_transfer_out,invalid",FALSE)
#               
#            WHEN "S"
#               CALL cl_set_act_visible("invalid,unconfirmed,posted",FALSE)  
#                             
#         END CASE     

         CALL cl_set_act_visible("confirmed,closed,confirm_transfer_in", FALSE)
         CALL cl_set_act_visible("unconfirmed,invalid,confirm_transfer_out,posted,unposted",TRUE)
         CALL cl_set_act_visible("signing,withdraw",FALSE)
         CASE g_indc_m.indcstus
            WHEN "N"
               CALL cl_set_act_visible("unconfirmed,posted,unposted",FALSE)
               #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                   CALL cl_set_act_visible("signing",TRUE)
                   CALL cl_set_act_visible("confirmed",FALSE)
               END IF

            WHEN "X"
               CALL cl_set_act_visible("invalid,confirm_transfer_out,unconfirmed,posted,unposted",FALSE)
               
            WHEN "O"
               CALL cl_set_act_visible("confirm_transfer_out,invalid,unposted",FALSE)
               
            WHEN "S"
               CALL cl_set_act_visible("invalid,unconfirmed,posted,confirm_transfer_out",FALSE)  

            WHEN "Y"   
               CALL cl_set_act_visible("unconfirmed,invalid,confirm_transfer_out,posted,unposted",FALSE)
            WHEN "P"
               CALL cl_set_act_visible("unconfirmed,invalid,confirm_transfer_out,posted,unposted",FALSE)
            WHEN "C"    
               CALL cl_set_act_visible("unconfirmed,invalid,confirm_transfer_out,posted,unposted",FALSE)
            
            WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
          
            WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE) 
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
            IF NOT aint330_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint330_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aint330_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint330_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"

            CALL s_transaction_begin()
            IF NOT cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
               RETURN
            ELSE
               CALL cl_err_collect_init()
               IF NOT s_aint330_unconf_chk(g_indc_m.indcdocno) THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  IF NOT s_aint330_unconf_upd(g_indc_m.indcdocno) THEN
                     CALL cl_err_collect_show()
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
            END IF         
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
#         CALL s_transaction_begin()
            IF NOT cl_ask_confirm('sub-00232') THEN
               CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
               RETURN
            ELSE
               CALL cl_err_collect_init()
               IF NOT s_aint330_post_chk(g_indc_m.indcdocno) THEN
                  CALL cl_err_collect_show()
#                  CALL s_transaction_end('N','0')
                  CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
                  RETURN
               ELSE
                  CALL cl_err_collect_show()   #160406-00024#1
                  
                  SELECT indc005 INTO l_indc005 FROM indc_t
                   WHERE indcent = g_enterprise
                     AND indcdocno = g_indc_m.indcdocno
                  CALL cl_set_comp_entry("indc022",TRUE) 
                  #160604-00034#4-S
                  LET l_flag = 'N' 
                  IF NOT cl_chk_update_pstdt() THEN
                     CALL cl_set_comp_entry("indc022",FALSE)
                     LET g_indc_m.indc022 = g_today
                     DISPLAY BY NAME g_indc_m.indc022
                     LET l_flag = 'Y'
                  END IF    
                  IF l_flag = 'N' THEN                 
                  #160604-00034#4-E                 
                  DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
                     INPUT BY NAME g_indc_m.indc022
                            ATTRIBUTE(WITHOUT DEFAULTS)    
                         BEFORE INPUT
                            LET l_time = cl_get_current()
#                            LET g_indc_m.indc022 = l_time
                            IF cl_null(g_indc_m.indc022) THEN
                               LET g_indc_m.indc022 = g_today
                            END IF   
                            DISPLAY BY NAME g_indc_m.indc022
                            
                         AFTER FIELD indc022
                            IF cl_null(g_indc_m.indc022) THEN
                                NEXT FIELD indc022
                            END IF   
                            IF NOT cl_null(g_indc_m.indc022) AND NOT cl_null(l_indc005) THEN
                               #檢查年度不小於成本關賬日期的年度
#                               CALL cl_get_para(g_enterprise,l_indc005,'S-FIN-6012') RETURNING l_date
                               CALL cl_get_para(g_enterprise,l_indc005,'S-MFG-0031') RETURNING l_date
                               IF g_indc_m.indc022 < l_date THEN
                                  INITIALIZE g_errparam TO NULL
                                  LET g_errparam.code = 'ain-00225'
                                  LET g_errparam.extend = l_date
                                  LET g_errparam.popup = TRUE
                                  CALL cl_err()
                                  LET g_indc_m.indc022 = g_indc_m_t.indc022
                                  NEXT FIELD indc022
                               END IF
                            END IF                   
                        END INPUT                     
                     BEFORE DIALOG      
                        ON ACTION accept
                           ACCEPT DIALOG
                    
                        ON ACTION cancel
                           LET INT_FLAG = 1
                           LET g_indc_m.indc022 = ''
                           EXIT DIALOG       
                  END DIALOG 
                  END IF   #160604-00034#4
                  DISPLAY BY NAME g_indc_m.indc022
                  IF INT_FLAG THEN
                     CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
                     RETURN 
                  END IF   
                  CALL s_transaction_begin()
                  CALL cl_err_collect_init()   #160406-00024#1
                  UPDATE indc_t SET indc022 = g_indc_m.indc022
                   WHERE indcent = g_enterprise
                     AND indcdocno = g_indc_m.indcdocno
                  IF NOT s_aint330_post_upd(g_indc_m.indcdocno,g_indc_m.indc022,g_prog) THEN
                     CALL cl_err_collect_show()
                     CALL s_transaction_end('N','0')
                     LET g_indc_m.indc022 = ''
                     DISPLAY BY NAME g_indc_m.indc022
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
               CALL cl_err_collect_show()  #161116-00011#1 
            END IF 
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
         #作廢
         CALL s_transaction_begin()
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
            RETURN
         ELSE
            IF NOT s_aint330_void_chk(g_indc_m.indcdocno) THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               IF NOT s_aint330_void_upd(g_indc_m.indcdocno) THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      ON ACTION unposted
         IF cl_auth_chk_act("unposted") THEN    #161108-00002#1 add
            LET lc_state = 'O'
         END IF     #161108-00002#1 add
         EXIT MENU  #161108-00002#1 add
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
      CLOSE aint330_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
      IF lc_state = 'O' AND g_indc_m.indcstus = 'N' THEN
         CALL s_transaction_begin()
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
            RETURN
         ELSE
            CALL cl_err_collect_init()
            IF NOT s_aint330_conf_chk(g_indc_m.indcdocno) THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')              
               RETURN
            ELSE
               IF NOT s_aint330_conf_upd(g_indc_m.indcdocno) THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF
      IF lc_state = 'O' AND g_indc_m.indcstus = 'S' THEN
         CALL s_transaction_begin()
         IF NOT cl_ask_confirm('sub-00233') THEN
            CALL s_transaction_end('N','0')   #160812-00017#2 20160815 add by beckxie
            RETURN
         ELSE
            CALL cl_err_collect_init()
            IF NOT s_aint330_unpost_chk(g_indc_m.indcdocno) THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               IF NOT s_aint330_unpost_upd(g_indc_m.indcdocno) THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF    
      END IF    
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
      EXECUTE aint330_master_referesh USING g_indc_m.indcdocno INTO g_indc_m.indcdocno,g_indc_m.indcdocdt, 
          g_indc_m.indc004,g_indc_m.indcsite,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indcstus,g_indc_m.indc002, 
          g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc151,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104, 
          g_indc_m.indc009,g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc106,g_indc_m.indc107,g_indc_m.indc108, 
          g_indc_m.indcownid,g_indc_m.indcowndp,g_indc_m.indccrtid,g_indc_m.indccrtdp,g_indc_m.indccrtdt, 
          g_indc_m.indcmodid,g_indc_m.indcpstid,g_indc_m.indcmoddt,g_indc_m.indcpstdt,g_indc_m.indccnfid, 
          g_indc_m.indccnfdt,g_indc_m.indc004_desc,g_indc_m.indc101_desc,g_indc_m.indc006_desc,g_indc_m.indc106_desc, 
          g_indc_m.indcownid_desc,g_indc_m.indcowndp_desc,g_indc_m.indccrtid_desc,g_indc_m.indccrtdp_desc, 
          g_indc_m.indcmodid_desc,g_indc_m.indcpstid_desc,g_indc_m.indccnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_indc_m.indcdocno,g_indc_m.indcdocdt,g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indcsite, 
          g_indc_m.indcdocno_desc,g_indc_m.indc022,g_indc_m.indc101,g_indc_m.indc101_desc,g_indc_m.indcstus, 
          g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc006_desc,g_indc_m.indc151, 
          g_indc_m.indc151_desc,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104,g_indc_m.indc009, 
          g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc105_desc,g_indc_m.l_indc105_desc,g_indc_m.indc106, 
          g_indc_m.indc106_desc,g_indc_m.indc107,g_indc_m.indc107_desc,g_indc_m.indc108,g_indc_m.indc108_desc, 
          g_indc_m.indcownid,g_indc_m.indcownid_desc,g_indc_m.indcowndp,g_indc_m.indcowndp_desc,g_indc_m.indccrtid, 
          g_indc_m.indccrtid_desc,g_indc_m.indccrtdp,g_indc_m.indccrtdp_desc,g_indc_m.indccrtdt,g_indc_m.indcmodid, 
          g_indc_m.indcmodid_desc,g_indc_m.indcpstid,g_indc_m.indcpstid_desc,g_indc_m.indcmoddt,g_indc_m.indcpstdt, 
          g_indc_m.indccnfid,g_indc_m.indccnfid_desc,g_indc_m.indccnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   #add by lixh 20151109
   IF g_indc_m.indc102 <> '2' OR g_indc_m.indcstus <> 'O' THEN  #撥出方確認
      CALL cl_set_act_visible("gen_qc",FALSE)
   END IF
   IF g_indc_m.indc102 = '2' AND g_indc_m.indcstus = 'O' THEN  #撥出方確認
      CALL cl_set_act_visible("gen_qc",TRUE)
   END IF
   #add by lixh 20151109
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aint330_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint330_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint330.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aint330_idx_chk()
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
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint330.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aint330_b_fill2(pi_idx)
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
   
   CALL aint330_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aint330.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aint330_fill_chk(ps_idx)
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
 
{<section id="aint330.status_show" >}
PRIVATE FUNCTION aint330_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint330.mask_functions" >}
&include "erp/ain/aint330_mask.4gl"
 
{</section>}
 
{<section id="aint330.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aint330_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aint330_show()
   CALL aint330_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   IF s_aint330_conf_chk(g_indc_m.indcdocno) THEN 
      RETURN
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_indc_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_indd_d))
 
 
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
   #CALL aint330_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aint330_ui_headershow()
   CALL aint330_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aint330_draw_out()
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
   CALL aint330_ui_headershow()  
   CALL aint330_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aint330.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint330_set_pk_array()
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
 
{<section id="aint330.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aint330.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint330_msgcentre_notify(lc_state)
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
   CALL aint330_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_indc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint330.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint330_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint330.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 单别预设
# Memo...........:
# Usage..........: CALL aint330_get_col_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 20161012 By wuxja  #161007-00002#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_get_col_default()
   LET g_indc_m.indcdocdt = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indcdocdt',g_indc_m.indcdocdt)
   LET g_indc_m.indc004 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc004',g_indc_m.indc004)
   LET g_indc_m.indc022 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc022',g_indc_m.indc022)
   LET g_indc_m.indc101 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc101',g_indc_m.indc101)
   LET g_indc_m.indc002 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc002',g_indc_m.indc002)
   LET g_indc_m.indc003 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc003',g_indc_m.indc003)   
   LET g_indc_m.indc006 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc006',g_indc_m.indc006)
   LET g_indc_m.indc151 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc151',g_indc_m.indc151)
   LET g_indc_m.indc102 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc102',g_indc_m.indc102)  
   LET g_indc_m.indc103 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc103',g_indc_m.indc103)
   LET g_indc_m.indc104 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc104',g_indc_m.indc104)
   LET g_indc_m.indc009 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc009',g_indc_m.indc009)
   LET g_indc_m.indc008 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc008',g_indc_m.indc008)
   LET g_indc_m.indc105 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc105',g_indc_m.indc105)
   LET g_indc_m.indc106 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc106',g_indc_m.indc106)
   LET g_indc_m.indc107 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc107',g_indc_m.indc107)
   LET g_indc_m.indc108 = s_aooi200_get_doc_default(g_site,'1',g_indc_m.indcdocno,'indc108',g_indc_m.indc108)
   
   IF NOT cl_null(g_indc_m.indc004) THEN
      CALL s_desc_get_person_desc(g_indc_m.indc004) RETURNING g_indc_m.indc004_desc
   END IF
   
   IF NOT cl_null(g_indc_m.indc101) THEN
      CALL s_desc_get_department_desc(g_indc_m.indc101) RETURNING g_indc_m.indc101_desc
   END IF
   
   IF NOT cl_null(g_indc_m.indc006) THEN
      CALL aint330_indc006_ref()
   END IF
   
   IF NOT cl_null(g_indc_m.indc151) THEN
      CALL aint330_indc151_ref()
   END IF
   
   IF NOT cl_null(g_indc_m.indc105) THEN
      CALL aint330_indc105_ref()
   END IF
   
   IF NOT cl_null(g_indc_m.indc106) THEN
      CALL aint330_indc106_ref()
      
      IF NOT cl_null(g_indc_m.indc107) THEN 
         CALL s_apmi011_location_ref(g_indc_m.indc106,g_indc_m.indc107) RETURNING g_indc_m.indc107_desc
      END IF
      
      IF NOT cl_null(g_indc_m.indc108) THEN  
         CALL s_apmi011_location_ref(g_indc_m.indc106,g_indc_m.indc108) RETURNING g_indc_m.indc108_desc
      END IF
   END IF
   
   DISPLAY BY NAME g_indc_m.indcdocdt,g_indc_m.indc004,g_indc_m.indc004_desc,g_indc_m.indc022,
       g_indc_m.indc101,g_indc_m.indc101_desc,g_indc_m.indc002,g_indc_m.indc003,g_indc_m.indc006,g_indc_m.indc006_desc,
       g_indc_m.indc151,g_indc_m.indc151_desc,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104,g_indc_m.indc009,
       g_indc_m.indc008,g_indc_m.indc105,g_indc_m.indc105_desc,g_indc_m.l_indc105_desc,g_indc_m.indc106,g_indc_m.indc106_desc,
       g_indc_m.indc107,g_indc_m.indc107_desc,g_indc_m.indc108,g_indc_m.indc108_desc
       
   #160824-00007#282 161229 by lori add---(S)
   LET g_indc_m_o.indcdocdt = g_indc_m.indcdocdt
   LET g_indc_m_o.indc004   = g_indc_m.indc004  
   LET g_indc_m_o.indc022   = g_indc_m.indc022  
   LET g_indc_m_o.indc101   = g_indc_m.indc101  
   LET g_indc_m_o.indc002   = g_indc_m.indc002  
   LET g_indc_m_o.indc003   = g_indc_m.indc003  
   LET g_indc_m_o.indc006   = g_indc_m.indc006  
   LET g_indc_m_o.indc151   = g_indc_m.indc151  
   LET g_indc_m_o.indc102   = g_indc_m.indc102  
   LET g_indc_m_o.indc103   = g_indc_m.indc103  
   LET g_indc_m_o.indc104   = g_indc_m.indc104  
   LET g_indc_m_o.indc009   = g_indc_m.indc009  
   LET g_indc_m_o.indc008   = g_indc_m.indc008  
   LET g_indc_m_o.indc105   = g_indc_m.indc105  
   LET g_indc_m_o.indc106   = g_indc_m.indc106  
   LET g_indc_m_o.indc107   = g_indc_m.indc107  
   LET g_indc_m_o.indc108   = g_indc_m.indc108  
   #160824-00007#282 161229 by lori add---(E)
END FUNCTION

################################################################################
# Descriptions...: 成本性質是否一致
# Memo...........:
# Usage..........: CALL aint330_inaa010_chk()
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_inaa010_chk()
DEFINE  r_success    LIKE type_t.num5
DEFINE  l_inaa010    LIKE inaa_t.inaa010
DEFINE  l_inaa010_1  LIKE inaa_t.inaa010
DEFINE  l_chk        LIKE type_t.num5     #161007-00012#2-add

   LET r_success = TRUE
   LET l_inaa010 = ''
   LET l_inaa010_1 = ''
   LET l_chk = TRUE #161007-00012#2-add
   
   #撥出營運據點
   IF NOT cl_null(g_indd_d[l_ac].indd022) THEN
      SELECT inaa010 INTO l_inaa010 FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaasite = g_site
         AND inaa001 = g_indd_d[l_ac].indd022
   END IF 
   ##撥入營運據點
   IF NOT cl_null(g_indd_d[l_ac].indd032) THEN
      SELECT inaa010 INTO l_inaa010_1 FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaasite = g_indc_m.indc006
         AND inaa001 = g_indd_d[l_ac].indd032
   END IF  
   #161007-00012#2-s-mod 撥出/入庫位，任一為VMI倉，不控卡都要是 成本庫
   #IF NOT cl_null(l_inaa010) AND NOT cl_null(l_inaa010_1) THEN
   #   IF l_inaa010 <> l_inaa010_1 THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = 'ain-00490'
   #      LET g_errparam.extend = ''
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()         
   #      LET r_success = FALSE
   #   END IF
   #END IF
   IF NOT cl_null(g_indd_d[l_ac].indd022) AND NOT cl_null(g_indd_d[l_ac].indd032) THEN
      IF g_indd022_type <> 0 OR g_indd032_type <> 0 THEN
         LET l_chk = FALSE
      END IF
   END IF
   IF NOT cl_null(l_inaa010) AND NOT cl_null(l_inaa010_1) AND l_chk THEN
      IF l_inaa010 <> l_inaa010_1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00490'
         LET g_errparam.replace[1] = g_indd_d[l_ac].inddseq
         LET g_errparam.replace[2] = g_indd_d[l_ac].indd002
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()         
         LET r_success = FALSE
      END IF
   END IF
   #161007-00012#2-e-mod
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 帶出說明
# Memo...........:
# Usage..........: CALL aint330_indc107_desc(p_indc107)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indc107_desc(p_indc107)
DEFINE p_indc107      LIKE indc_t.indc107
DEFINE p_oocq019      LIKE oocq_t.oocq019
DEFINE r_indc107_desc LIKE oockl_t.oockl005

   IF NOT cl_null(g_indc_m.indc106) THEN
      SELECT oocq019 INTO p_oocq019
        FROM oocq_t WHERE oocq001='263' AND oocq002= g_indc_m.indc106
         AND oocqent = g_enterprise #add by geza 20160905 #160905-00007#5         
   END IF

   IF NOT cl_null(p_oocq019) THEN
      CASE
         WHEN p_oocq019 ='1' OR p_oocq019 ='4'
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = p_indc107
           CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET r_indc107_desc = '', g_rtn_fields[1] , ''
           RETURN r_indc107_desc

         WHEN p_oocq019 ='2'
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = p_indc107
           CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql001 = '262' AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET r_indc107_desc = '', g_rtn_fields[1] , ''
           RETURN r_indc107_desc

         WHEN p_oocq019 ='3'
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = p_indc107
           CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql001 = '276' AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET r_indc107_desc = '', g_rtn_fields[1] , ''
           RETURN r_indc107_desc
      END CASE
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_indc107
      CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl003=? AND oocql001 = '262' AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_indc107_desc = '', g_rtn_fields[1] , ''
      RETURN r_indc107_desc
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_indd041_ref()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd041_ref()
   CALL s_desc_get_unit_desc(g_indd_d[l_ac].indd041) RETURNING g_indd_d[l_ac].indd041_desc
   DISPLAY BY NAME g_indd_d[l_ac].indd041,g_indd_d[l_ac].indd041_desc 
END FUNCTION

################################################################################
# Descriptions...: #160523-00030#1
# Memo...........:
# Date & Author..: 16/08/22 By 02097(Belle)
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_open_aint330_02()
DEFINE lwin_curr     ui.Window
DEFINE lfrm_curr     ui.Form
DEFINE ls_path       STRING
DEFINE l_soure_type       LIKE type_t.chr1

   #OPEN WINDOW w_aint330_02_s01 WITH FORM cl_ap_formpath("ain","aint330_02_s01")  #161110-00036#1
   OPEN WINDOW w_aint330_s01 WITH FORM cl_ap_formpath("ain","aint330_s01")         #161110-00036#1 
   CALL cl_ui_init()     #161110-00036#1   
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_openwin.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   
   LET INT_FLAG  = FALSE
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)      
             
      INPUT BY NAME l_soure_type
            ATTRIBUTE(WITHOUT DEFAULTS)
            
         BEFORE INPUT
            CALL cl_set_combo_scc('l_soure_type','4080')
            LET l_soure_type = '1'
            DISPLAY BY NAME l_soure_type                     
         
      END INPUT
      
      BEFORE DIALOG
         
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
         
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
   END DIALOG   
  
   #CLOSE WINDOW w_aint330_02_s01  #161110-00036#1 MARK
   CLOSE WINDOW w_aint330_s01      #161110-00036#1
   
   RETURN INT_FLAG,l_soure_type
   
END FUNCTION

################################################################################
# Descriptions...: 掃碼前必填欄位檢查
# Memo...........:
# Usage..........: CALL aint330_scan_chk_reqf()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success TRUE/FALSE
# Date & Author..: #160831-00070#7 20161014 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_scan_chk_reqf()
   DEFINE r_success LIKE type_t.num5 
   LET r_success = TRUE
   
   IF cl_null(g_indc_m.indcdocno) THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00796'
      LET g_errparam.extend = ''
      LET g_errparam.replace[1] = s_get_field_name('aint330','indcdocno')#欄位名稱
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   IF cl_null(g_indc_m.indc002) THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00796'
      LET g_errparam.extend = ''
      LET g_errparam.replace[1] = s_get_field_name('aint330','indc002')#欄位名稱
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   IF cl_null(g_indc_m.indc004) THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00796'
      LET g_errparam.extend = ''
      LET g_errparam.replace[1] = s_get_field_name('aint330','indc004')#欄位名稱
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   IF cl_null(g_indc_m.indc006) THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00796'
      LET g_errparam.extend = ''
      LET g_errparam.replace[1] = s_get_field_name('aint330','indc006')#欄位名稱
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   IF cl_null(g_indc_m.indc101) THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00796'
      LET g_errparam.extend = ''
      LET g_errparam.replace[1] = s_get_field_name('aint330','indc101')#欄位名稱
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   IF cl_null(g_indc_m.indc102) THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00796'
      LET g_errparam.extend = ''
      LET g_errparam.replace[1] = s_get_field_name('aint330','indc102')#欄位名稱
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   IF cl_null(g_indc_m.indc103) THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00796'
      LET g_errparam.extend = ''
      LET g_errparam.replace[1] = s_get_field_name('aint330','indc103')#欄位名稱
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   IF cl_null(g_indc_m.indc104) THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00796'
      LET g_errparam.extend = ''
      LET g_errparam.replace[1] = s_get_field_name('aint330','indc104')#欄位名稱
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   IF cl_null(g_indc_m.indc009) THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00796'
      LET g_errparam.extend = ''
      LET g_errparam.replace[1] = s_get_field_name('aint330','indc009')#欄位名稱
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   IF cl_null(g_indc_m.indcstus) THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00796'
      LET g_errparam.extend = ''
      LET g_errparam.replace[1] = s_get_field_name('aint330','indcstus')#欄位名稱
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 獲取參照表號
# Memo...........:
# Usage..........: CALL aint330_get_ooef004()
#                  RETURNING l_ooef004
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_get_ooef004()
DEFINE  l_ooef004    LIKE ooef_t.ooef004
   SELECT ooef004 INTO l_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   RETURN l_ooef004   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_location_chk(p_location,p_oocq019)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_location_chk(p_location,p_oocq019)
   DEFINE p_location            LIKE type_t.chr10     #地點
   DEFINE l_n                   LIKE type_t.num5
   DEFINE l_stus                LIKE type_t.chr10
   DEFINE p_oocq019             LIKE oocq_t.oocq019

   LET g_errno = ''
   LET l_n = 0
   LET l_stus = ''

   CASE
      WHEN p_oocq019 ='1' OR   #1:陸運
           p_oocq019 ='4'      #4:其它    
         LET l_n=0
         SELECT COUNT(oock003) INTO l_n
           FROM oock_t
          WHERE oockent = g_enterprise
            AND oock003 = p_location
            AND oockstus = 'Y'

             #輸入資料不存在 縣市資料檔 中！
          IF l_n = 0 THEN LET g_errno = 'aoo-00015' RETURN END IF

      WHEN p_oocq019 ='2'      #2:海運
         SELECT oocqstus INTO l_stus
           FROM oocq_t
          WHERE oocqent = g_enterprise
            AND oocq001 = '262'
            AND oocq002 = p_location

         CASE
            WHEN SQLCA.sqlcode = 100
               LET g_errno = 'sub-01303'  #160318-00005#22 mod 'axm-00032'
            WHEN l_stus <> 'Y'
               LET g_errno = 'sub-01302'  #160318-00005#22 mod 'axm-00033'
            OTHERWISE
               LET g_errno = SQLCA.sqlcode USING '------'
         END CASE

      WHEN p_oocq019 ='3'      #3:空運                     
         SELECT oocqstus INTO l_stus
           FROM oocq_t
          WHERE oocqent = g_enterprise
            AND oocq001 = '276'
            AND oocq002 = p_location

         CASE
            WHEN SQLCA.sqlcode = 100
               LET g_errno = 'sub-01303'  #160318-00005#22 mod 'axm-00086'
            WHEN l_stus <> 'Y'
               LET g_errno = 'sub-01302'  #160318-00005#22 mod 'axm-00087'
            OTHERWISE
               LET g_errno = SQLCA.sqlcode USING '------'
         END CASE

   END CASE
   RETURN
END FUNCTION

################################################################################
# Descriptions...: 是否自動產生單身
# Memo...........:
# Usage..........: CALL aint330_auto_gene_detail()
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_auto_gene_detail()
DEFINE   l_sql    STRING
#DEFINE   l_indb   RECORD LIKE indb_t.*  #161124-00048#5  16/12/12 By 08734 mark
#161124-00048#5  16/12/12 By 08734 add(S)
DEFINE l_indb RECORD  #調撥申請單單身明細檔
       indbent LIKE indb_t.indbent, #企业编号
       indbsite LIKE indb_t.indbsite, #营运据点
       indbunit LIKE indb_t.indbunit, #应用组织
       indbdocno LIKE indb_t.indbdocno, #单号
       indbseq LIKE indb_t.indbseq, #项次
       indb001 LIKE indb_t.indb001, #商品编号
       indb002 LIKE indb_t.indb002, #商品条码
       indb003 LIKE indb_t.indb003, #产品特征
       indb004 LIKE indb_t.indb004, #库存单位
       indb005 LIKE indb_t.indb005, #包装单位
       indb006 LIKE indb_t.indb006, #件装数
       indb007 LIKE indb_t.indb007, #调拨申请件数
       indb008 LIKE indb_t.indb008, #调拨申请数量
       indb009 LIKE indb_t.indb009, #核准件数
       indb010 LIKE indb_t.indb010, #核准数量
       indb011 LIKE indb_t.indb011, #拨出数量
       indb012 LIKE indb_t.indb012, #拨入数量
       indb013 LIKE indb_t.indb013, #备注
       indb101 LIKE indb_t.indb101, #限定库存管理特征
       indb102 LIKE indb_t.indb102, #限定拨出库位
       indb103 LIKE indb_t.indb103, #限定拨出储位
       indb104 LIKE indb_t.indb104, #限定拨出批号
       indb105 LIKE indb_t.indb105, #参考单位
       indb106 LIKE indb_t.indb106, #参考数量
       indb107 LIKE indb_t.indb107, #拨入库位
       indb108 LIKE indb_t.indb108, #拨入储位
       indb151 LIKE indb_t.indb151, #理由码
       indbud001 LIKE indb_t.indbud001, #自定义字段(文本)001
       indbud002 LIKE indb_t.indbud002, #自定义字段(文本)002
       indbud003 LIKE indb_t.indbud003, #自定义字段(文本)003
       indbud004 LIKE indb_t.indbud004, #自定义字段(文本)004
       indbud005 LIKE indb_t.indbud005, #自定义字段(文本)005
       indbud006 LIKE indb_t.indbud006, #自定义字段(文本)006
       indbud007 LIKE indb_t.indbud007, #自定义字段(文本)007
       indbud008 LIKE indb_t.indbud008, #自定义字段(文本)008
       indbud009 LIKE indb_t.indbud009, #自定义字段(文本)009
       indbud010 LIKE indb_t.indbud010, #自定义字段(文本)010
       indbud011 LIKE indb_t.indbud011, #自定义字段(数字)011
       indbud012 LIKE indb_t.indbud012, #自定义字段(数字)012
       indbud013 LIKE indb_t.indbud013, #自定义字段(数字)013
       indbud014 LIKE indb_t.indbud014, #自定义字段(数字)014
       indbud015 LIKE indb_t.indbud015, #自定义字段(数字)015
       indbud016 LIKE indb_t.indbud016, #自定义字段(数字)016
       indbud017 LIKE indb_t.indbud017, #自定义字段(数字)017
       indbud018 LIKE indb_t.indbud018, #自定义字段(数字)018
       indbud019 LIKE indb_t.indbud019, #自定义字段(数字)019
       indbud020 LIKE indb_t.indbud020, #自定义字段(数字)020
       indbud021 LIKE indb_t.indbud021, #自定义字段(日期时间)021
       indbud022 LIKE indb_t.indbud022, #自定义字段(日期时间)022
       indbud023 LIKE indb_t.indbud023, #自定义字段(日期时间)023
       indbud024 LIKE indb_t.indbud024, #自定义字段(日期时间)024
       indbud025 LIKE indb_t.indbud025, #自定义字段(日期时间)025
       indbud026 LIKE indb_t.indbud026, #自定义字段(日期时间)026
       indbud027 LIKE indb_t.indbud027, #自定义字段(日期时间)027
       indbud028 LIKE indb_t.indbud028, #自定义字段(日期时间)028
       indbud029 LIKE indb_t.indbud029, #自定义字段(日期时间)029
       indbud030 LIKE indb_t.indbud030, #自定义字段(日期时间)030
       indb014 LIKE indb_t.indb014, #拨入单位
       indb015 LIKE indb_t.indb015, #项目编号
       indb016 LIKE indb_t.indb016, #WBS
       indb017 LIKE indb_t.indb017 #活动编号
END RECORD
#161124-00048#5  16/12/12 By 08734 add(E)
#DEFINE   l_indd   RECORD LIKE indd_t.*  #161124-00048#5  16/12/12 By 08734 mark
#161124-00048#5  16/12/12 By 08734 add(S)
DEFINE l_indd RECORD  #調撥單單身明細檔
       inddent LIKE indd_t.inddent, #企業編號
       inddsite LIKE indd_t.inddsite, #營運據點
       inddunit LIKE indd_t.inddunit, #應用組織
       indddocno LIKE indd_t.indddocno, #調撥單號
       inddseq LIKE indd_t.inddseq, #項次
       indd001 LIKE indd_t.indd001, #來源項次
       indd002 LIKE indd_t.indd002, #商品編號
       indd003 LIKE indd_t.indd003, #商品條碼
       indd004 LIKE indd_t.indd004, #產品特徵
       indd005 LIKE indd_t.indd005, #經營方式
       indd006 LIKE indd_t.indd006, #庫存單位
       indd007 LIKE indd_t.indd007, #包裝單位
       indd008 LIKE indd_t.indd008, #件裝數
       indd009 LIKE indd_t.indd009, #預調撥量
       indd020 LIKE indd_t.indd020, #撥出件數
       indd021 LIKE indd_t.indd021, #撥出數量
       indd022 LIKE indd_t.indd022, #撥出庫位
       indd023 LIKE indd_t.indd023, #撥出儲位
       indd024 LIKE indd_t.indd024, #撥出批號
       indd030 LIKE indd_t.indd030, #撥入件數
       indd031 LIKE indd_t.indd031, #撥入數量
       indd032 LIKE indd_t.indd032, #撥入庫位
       indd033 LIKE indd_t.indd033, #撥入儲位
       indd034 LIKE indd_t.indd034, #撥入批號
       indd040 LIKE indd_t.indd040, #結案否
       indd101 LIKE indd_t.indd101, #來源單號
       indd102 LIKE indd_t.indd102, #庫存管理特徵
       indd103 LIKE indd_t.indd103, #撥出申請量
       indd104 LIKE indd_t.indd104, #參考單位
       indd105 LIKE indd_t.indd105, #撥出申請參考數量
       indd106 LIKE indd_t.indd106, #撥出合格參考數量
       indd107 LIKE indd_t.indd107, #撥入申請數量
       indd108 LIKE indd_t.indd108, #撥入申請參考數量
       indd109 LIKE indd_t.indd109, #撥入合格參考數量
       indd110 LIKE indd_t.indd110, #差異量
       indd111 LIKE indd_t.indd111, #差異原因
       indd112 LIKE indd_t.indd112, #差異已調整量
       indd151 LIKE indd_t.indd151, #調撥理由
       indd152 LIKE indd_t.indd152, #備註
       inddud001 LIKE indd_t.inddud001, #自定義欄位(文字)001
       inddud002 LIKE indd_t.inddud002, #自定義欄位(文字)002
       inddud003 LIKE indd_t.inddud003, #自定義欄位(文字)003
       inddud004 LIKE indd_t.inddud004, #自定義欄位(文字)004
       inddud005 LIKE indd_t.inddud005, #自定義欄位(文字)005
       inddud006 LIKE indd_t.inddud006, #自定義欄位(文字)006
       inddud007 LIKE indd_t.inddud007, #自定義欄位(文字)007
       inddud008 LIKE indd_t.inddud008, #自定義欄位(文字)008
       inddud009 LIKE indd_t.inddud009, #自定義欄位(文字)009
       inddud010 LIKE indd_t.inddud010, #自定義欄位(文字)010
       inddud011 LIKE indd_t.inddud011, #自定義欄位(數字)011
       inddud012 LIKE indd_t.inddud012, #自定義欄位(數字)012
       inddud013 LIKE indd_t.inddud013, #自定義欄位(數字)013
       inddud014 LIKE indd_t.inddud014, #自定義欄位(數字)014
       inddud015 LIKE indd_t.inddud015, #自定義欄位(數字)015
       inddud016 LIKE indd_t.inddud016, #自定義欄位(數字)016
       inddud017 LIKE indd_t.inddud017, #自定義欄位(數字)017
       inddud018 LIKE indd_t.inddud018, #自定義欄位(數字)018
       inddud019 LIKE indd_t.inddud019, #自定義欄位(數字)019
       inddud020 LIKE indd_t.inddud020, #自定義欄位(數字)020
       inddud021 LIKE indd_t.inddud021, #自定義欄位(日期時間)021
       inddud022 LIKE indd_t.inddud022, #自定義欄位(日期時間)022
       inddud023 LIKE indd_t.inddud023, #自定義欄位(日期時間)023
       inddud024 LIKE indd_t.inddud024, #自定義欄位(日期時間)024
       inddud025 LIKE indd_t.inddud025, #自定義欄位(日期時間)025
       inddud026 LIKE indd_t.inddud026, #自定義欄位(日期時間)026
       inddud027 LIKE indd_t.inddud027, #自定義欄位(日期時間)027
       inddud028 LIKE indd_t.inddud028, #自定義欄位(日期時間)028
       inddud029 LIKE indd_t.inddud029, #自定義欄位(日期時間)029
       inddud030 LIKE indd_t.inddud030, #自定義欄位(日期時間)030
       indd041 LIKE indd_t.indd041, #撥入單位
       indd042 LIKE indd_t.indd042, #專案編號
       indd043 LIKE indd_t.indd043, #WBS
       indd044 LIKE indd_t.indd044, #活動編號
       indd010 LIKE indd_t.indd010, #多庫儲否
       indd025 LIKE indd_t.indd025, #撥出組織庫存數量
       indd035 LIKE indd_t.indd035, #撥入組織庫存數量
       indd045 LIKE indd_t.indd045, #預估單價
       indd046 LIKE indd_t.indd046, #預估金額
       indd047 LIKE indd_t.indd047, #來源需求單號
       indd048 LIKE indd_t.indd048 #來源需求項次
END RECORD
#161124-00048#5  16/12/12 By 08734 add(E)
DEFINE   l_i      LIKE type_t.num5
DEFINE   l_indd103  LIKE indd_t.indd103
DEFINE   l_indd105  LIKE indd_t.indd105
DEFINE   r_success  LIKE type_t.num5
DEFINE   r_rate     LIKE inaj_t.inaj014
   
   #LET l_sql = " SELECT * FROM indb_t,inda_t ",   #161124-00048#5  16/12/12 By 08734 mark
   LET l_sql = " SELECT indbent,indbsite,indbunit,indbdocno,indbseq,indb001,indb002,indb003,indb004,indb005,indb006,indb007,",
               "indb008,indb009,indb010,indb011,indb012,indb013,indb101,indb102,indb103,indb104,indb105,indb106,indb107,indb108,",
               "indb151,indbud001,indbud002,indbud003,indbud004,indbud005,indbud006,indbud007,indbud008,indbud009,indbud010,",
               "indbud011,indbud012,indbud013,indbud014,indbud015,indbud016,indbud017,indbud018,indbud019,indbud020,indbud021,",
               "indbud022,indbud023,indbud024,indbud025,indbud026,indbud027,indbud028,indbud029,indbud030,indb014,indb015,indb016,",
               "indb017,indaent,indasite,indaunit,indadocno,indadocdt,inda001,inda002,inda003,inda004,inda005,inda006,indaownid,",
               "indaowndp,indacrtid,indacrtdp,indacrtdt,indamodid,indamoddt,indacnfid,indacnfdt,indastus,inda101,inda102,inda103,",
               "inda104,inda105,inda106,inda107,inda108,inda109,inda151,inda007 FROM indb_t,inda_t ",  #161124-00048#5  16/12/12 By 08734 add
               "  WHERE indaent = indbent ",
               "    AND indadocno = indbdocno",
               "    AND indastus = 'Y'",
               "    AND indbent = '",g_enterprise,"'",
               "    AND indbdocno = '",g_indc_m.indc003,"'",
               #"    AND (indb008 > indb011 OR indb011 IS NULL)"   #161013-00028#1
               "    AND ((indb008 > indb011 AND indb008 > 0) OR (indb008 < indb011 AND indb008 < 0) OR indb011 IS NULL)"  #161013-00028#1
   PREPARE aint330_indb_pre FROM l_sql
   DECLARE aint330_indb_cur CURSOR FOR aint330_indb_pre 
   CALL g_indd_d.clear()    #g_indd_d 單頭及單身  
   LET l_i = 1 
   FOREACH aint330_indb_cur INTO l_indb.*
      LET l_indd.indd101 = g_indc_m.indc003
      LET l_indd.indd001 = l_indb.indbseq
      LET l_indd.indd002 = l_indb.indb001
      LET l_indd.indd004 = l_indb.indb003
      LET l_indd.indd102 = l_indb.indb101
      LET l_indd.indd022 = l_indb.indb102
      LET l_indd.indd023 = l_indb.indb103
      LET l_indd.indd024 = l_indb.indb104
      LET l_indd.indd006 = l_indb.indb005
      LET l_indd.indd104 = l_indb.indb105
      
      LET l_indd.indd042 = l_indb.indb015
      LET l_indd.indd043 = l_indb.indb016
      LET l_indd.indd044 = l_indb.indb017
      
      SELECT SUM(indd103) INTO l_indd103 FROM indd_t,indc_t
       WHERE inddent = indcent
         AND indddocno = indcdocno
         AND inddsite = indcsite
         AND inddent = g_enterprise
         AND indd101 = g_indc_m.indc003
         AND indd001 = l_indb.indbseq
         AND (indddocno <> g_indc_m.indcdocno OR (indddocno = g_indc_m.indcdocno AND inddseq <> l_i))
         AND (indcstus = 'N' OR indcstus = 'O')
         AND indc000 = '1'
      IF cl_null(l_indd103) THEN LET l_indd103 = 0 END IF
      IF cl_null(l_indb.indb011) THEN LET l_indb.indb011 = 0 END IF
      LET l_indd.indd103 = l_indb.indb008 - l_indb.indb011 - l_indd103
      CALL aint330_unit_round(l_indd.indd006,l_indd.indd103) RETURNING l_indd.indd103
      IF l_indd.indd103 = 0 THEN
         CONTINUE FOREACH
      END IF
      LET l_indd.indd021 = l_indd.indd103
#      LET l_indd.indd107 = l_indd.indd103
      #add by lixh 20150616
      LET l_indd.indd041 = l_indb.indb014
      CALL s_aooi250_convert_qty(l_indd.indd002,l_indd.indd006,l_indd.indd041,l_indd.indd103)      
           RETURNING r_success,l_indd.indd107
      #add by lixh 20150616     
#      LET l_indd.indd031 = l_indd.indd103
      
      IF NOT cl_null(l_indd.indd104) AND NOT cl_null(l_indd.indd006) AND NOT cl_null(l_indd.indd103) THEN
#         CALL s_aimi190_get_convert(l_indd.indd002,l_indd.indd006,l_indd.indd104) 
#              RETURNING r_success,r_rate   #xj mod
         CALL s_aooi250_convert_qty(l_indd.indd002,l_indd.indd006,l_indd.indd104,l_indd.indd103)      
             RETURNING r_success,l_indd.indd105       
         IF r_success THEN           
#            LET l_indd.indd105 = l_indd.indd103 * r_rate  #xj mod
            CALL aint330_unit_round(l_indd.indd104,l_indd.indd105) RETURNING l_indd.indd105  
            LET l_indd.indd106 = l_indd.indd105
            LET l_indd.indd108 = l_indd.indd105
            LET l_indd.indd109 = l_indd.indd105     
         END IF            
      END IF   
      
      LET l_indd.indd151 = l_indb.indb151
      LET l_indd.indd032 = l_indb.indb107
      LET l_indd.indd033 = l_indb.indb108
      LET l_indd.indd034 = l_indd.indd024
      LET l_indd.indd152 = l_indb.indb013
      LET l_indd.indd040 = 'N'
      LET l_indd.indd041 = l_indb.indb014
      #add by lixh 20150327
      #單位轉換
      CALL s_aooi250_convert_qty(l_indd.indd002,l_indd.indd006,l_indd.indd041,l_indd.indd103)      
           RETURNING r_success,l_indd.indd031   
      #add by lixh 20150327     
      #add by lixh 20150619
      IF g_detail_idx <> 0 AND NOT cl_null(g_detail_idx) THEN
         IF g_indd_d[g_detail_idx].indd004 IS NULL THEN
            LET g_indd_d[g_detail_idx].indd004 = ' '
         END IF
      END IF
      IF l_indd.indd004 IS NULL THEN
         LET l_indd.indd004 = ' '
      END IF
      #add by lixh 20150619 

      #160202-00004#1 add by lixh 20160201
      IF g_indc_m.indc102 = '2' THEN    #撥出方檢驗
         LET l_indd.indd021 = 0
         LET l_indd.indd031 = 0
         LET l_indd.indd106 = 0
         LET l_indd.indd109 = 0
      END IF
      #160202-00004#1 add by lixh 20160201
      
      INSERT INTO indd_t (inddent,inddsite,indddocno,inddseq,indd101,indd001,indd002,indd004,indd102,indd022,indd023,indd024,indd006,
                          indd103,indd021,indd104,indd105,indd106,indd151,indd032,indd033,indd034,indd031,indd107,indd108,indd109,indd152,indd040,indd110,indd112,indd041,
                          indd042,indd043,indd044)
                   VALUES(g_enterprise,g_site,g_indc_m.indcdocno,l_i,l_indd.indd101,l_indd.indd001,l_indd.indd002,l_indd.indd004,
                          l_indd.indd102,l_indd.indd022,l_indd.indd023,l_indd.indd024,l_indd.indd006,l_indd.indd103,l_indd.indd021,
                          l_indd.indd104,l_indd.indd105,l_indd.indd106,l_indd.indd151,l_indd.indd032,l_indd.indd033,l_indd.indd034,
                          l_indd.indd031,l_indd.indd107,l_indd.indd108,l_indd.indd109,l_indd.indd152,l_indd.indd040,0,0,l_indd.indd041,
                          l_indd.indd042,l_indd.indd043,l_indd.indd044)
                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert indd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF      
      LET l_i = l_i + 1                  
   END FOREACH   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_set_required()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_set_required()
   IF g_indc_m.indc002 = '2' THEN
#      CALL cl_set_comp_required('indc003',TRUE)
      CALL cl_set_comp_required('indc003',FALSE)   #add by lixh 20150422
   END IF    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_set_no_required()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_set_no_required()
   CALL cl_set_comp_required('indc003',FALSE)
END FUNCTION

################################################################################
# Descriptions...: 帶出申請單默認值
# Memo...........:
# Usage..........: CALL aint330_default_indc()
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_default_indc()
   LET g_indc_m.indc006 = ''
   LET g_indc_m.indc151 = ''
   LET g_indc_m.indc102 = ''
   LET g_indc_m.indc103 = ''
   LET g_indc_m.indc104 = ''
   LET g_indc_m.indc105 = ''
   LET g_indc_m.indc106 = ''
   LET g_indc_m.indc107 = ''
   LET g_indc_m.indc108 = ''
   LET g_indc_m.indc009 = ''  #150320---earl---add
   SELECT inda004,inda151,inda102,inda103,inda104,
          inda105,inda106,inda107,inda108,
          inda007   #150320---earl---add
     INTO g_indc_m.indc006,g_indc_m.indc151,g_indc_m.indc102,g_indc_m.indc103,g_indc_m.indc104,
          g_indc_m.indc105,g_indc_m.indc106,g_indc_m.indc107,g_indc_m.indc108,
          g_indc_m.indc009   #150320---earl---add
     FROM inda_t
    WHERE indaent = g_enterprise
      AND indadocno = g_indc_m.indc003  
   CALL aint330_indc151_ref()      
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_indd101_default()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd101_default()
DEFINE  l_indd103      LIKE indd_t.indd103 
DEFINE  l_indb011      LIKE indb_t.indb011 
DEFINE  l_indb106      LIKE indb_t.indb106 
DEFINE  l_indb008      LIKE indb_t.indb008
DEFINE  r_rate         LIKE inaj_t.inaj014
DEFINE  r_success      LIKE type_t.num5
#160921-00014#1-s
DEFINE  l_inbj009   LIKE inbj_t.inbj009
DEFINE  l_inbj010   LIKE inbj_t.inbj010
DEFINE  s_indd103   LIKE indd_t.indd103
#160921-00014#1-e
   IF l_ac > 0 THEN
      IF NOT cl_null(g_indd_d[l_ac].indd101) AND NOT cl_null(g_indd_d[l_ac].indd001) THEN
         IF g_indc_m.indc002 = '2' THEN   #160921-00014#1
            SELECT indb001,indb003,indb101,indb102,indb103,indb104,indb005,indb008,indb105,indb106,indb151,indb107,indb108,indb011,indb014
              INTO g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,
                   g_indd_d[l_ac].indd006,l_indb008,g_indd_d[l_ac].indd104,l_indb106,g_indd_d[l_ac].indd151,g_indd_d[l_ac].indd032,
                   g_indd_d[l_ac].indd033,l_indb011,g_indd_d[l_ac].indd041
              FROM indb_t
             WHERE indbent = g_enterprise
               AND indbdocno = g_indd_d[l_ac].indd101
               AND indbseq = g_indd_d[l_ac].indd001  
            CALL s_desc_get_unit_desc(g_indd_d[l_ac].indd041) RETURNING g_indd_d[l_ac].indd041_desc     
            DISPLAY BY NAME g_indd_d[l_ac].indd041,g_indd_d[l_ac].indd041_desc    
            SELECT SUM(indd103) INTO l_indd103 FROM indd_t,indc_t
             WHERE indcent = inddent
               AND indcdocno = indddocno
               AND inddent = g_enterprise
               AND inddsite = g_site
               AND indd101 = g_indd_d[l_ac].indd101
               AND indd001 = g_indd_d[l_ac].indd001   
               AND (indddocno <> g_indc_m.indcdocno OR (indddocno = g_indc_m.indcdocno AND inddseq <> g_indd_d[l_ac].inddseq))
               AND (indcstus = 'O' OR indcstus = 'N')   
               AND indc000 = '1'            
            IF cl_null(l_indd103) THEN LET l_indd103 = 0 END IF
            IF cl_null(l_indb011) THEN LET l_indb011 = 0 END IF   
            LET g_indd_d[l_ac].indd103 = l_indb008 - l_indb011 -l_indd103
            IF g_indd_d[l_ac].indd103 = l_indb008 THEN
               LET g_indd_d[l_ac].indd105 = l_indb106
               LET g_indd_d[l_ac].indd106 = l_indb106
               LET g_indd_d[l_ac].indd109 = l_indb106
               LET g_indd_d[l_ac].indd021 = g_indd_d[l_ac].indd103
               LET g_indd_d[l_ac].indd031 = g_indd_d[l_ac].indd103
            END IF 
         END IF      #160921-00014#1
         
         #160921-00014#1-s
         IF g_indc_m.indc002 = '10' THEN  #報廢申請
            SELECT inbj001,inbj002,inbj003,inbj005,inbj006,inbj007,inbj008,inbj011,inbj019,inbj020,inbj021,inbj009,inbj010
              INTO g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,
                   g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd042,g_indd_d[l_ac].indd043,g_indd_d[l_ac].indd044,l_inbj009,l_inbj010
              FROM inbj_t     
             WHERE inbjent = g_enterprise
               AND inbjdocno = g_indd_d[l_ac].indd101
               AND inbjseq = g_indd_d[l_ac].indd001               
                   
            LET g_indd_d[l_ac].indd040 = 'N'
            LET g_indd_d[l_ac].indd041 = g_indd_d[l_ac].indd006
            #申請數量
            SELECT SUM(indd103) INTO s_indd103 FROM indd_t
             WHERE inddent = g_enterprise
               AND indd101 = g_indd_d[l_ac].indd101
               AND indd001 = g_indd_d[l_ac].indd001
               AND ((indddocno = g_indc_m.indcdocno AND inddseq <> g_indd_d[l_ac].inddseq) OR indddocno <> g_indc_m.indcdocno)
            IF cl_null(s_indd103)  THEN LET s_indd103 = 0 END IF
            IF g_indd_d[l_ac].indd103 = 0 OR cl_null(g_indd_d[l_ac].indd103) THEN
               LET g_indd_d[l_ac].indd103 = l_inbj009 - l_inbj010 - s_indd103     
            END IF               
         END IF
         #160921-00014#1-e 
         
         CALL aint330_unit_round(g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103) RETURNING g_indd_d[l_ac].indd103 
         LET g_indd_d[l_ac].indd021 = g_indd_d[l_ac].indd103
         LET g_indd_d[l_ac].indd031 = g_indd_d[l_ac].indd103 
         IF NOT cl_null(g_indd_d[l_ac].indd104) AND NOT cl_null(g_indd_d[l_ac].indd006) AND NOT cl_null(g_indd_d[l_ac].indd103) THEN         
#         CALL s_aimi190_get_convert(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd104) 
#              RETURNING r_success,r_rate          #xj mod
         CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd103)
            RETURNING r_success,g_indd_d[l_ac].indd105
#         LET g_indd_d[l_ac].indd105 = g_indd_d[l_ac].indd103 * r_rate  #xj mod
         CALL aint330_unit_round(g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd105) RETURNING g_indd_d[l_ac].indd105
         LET g_indd_d[l_ac].indd106 = g_indd_d[l_ac].indd105
         LET g_indd_d[l_ac].indd109 = g_indd_d[l_ac].indd105   
         END IF  
         IF cl_null(g_indd_d[l_ac].indd022) AND cl_null(g_indd_d[l_ac].indd023) AND g_indc_m.indc002 = '2' THEN
            SELECT imaf091,imaf092 INTO g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023 FROM imaf_t
             WHERE imafent = g_enterprise
               AND imafsite = g_site
               AND imaf001 = g_indd_d[l_ac].indd002
            CALL aint330_indd022_ref()  
            CALL aint330_indd023_ref()               
         END IF
         CALL s_desc_get_item_desc(g_indd_d[l_ac].indd002) 
              RETURNING g_indd_d[l_ac].indd002_desc,g_indd_d[l_ac].indd002_desc_desc #add by lixh 20150210 
         CALL aint330_indd006_ref()              
         CALL aint330_indd022_ref()  #add by lixh 20150210
         CALL aint330_indd023_ref()  #add by lixh 20150210  
         CALL aint330_indd006_ref()
         CALL aint330_indd151_ref()
         CALL aint330_indd032_ref()  
         CALL aint330_indd033_ref()  
         CALL aint330_indd041_ref()             
      END IF
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 檢查來源單號單頭欄位值是否與調撥單單頭一致
# Memo...........:
# Usage..........: CALL aint330_indd101_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd101_chk()
DEFINE  l_cnt        LIKE type_t.num5  
DEFINE  l_inda004    LIKE inda_t.inda004
DEFINE  l_inda102    LIKE inda_t.inda102
DEFINE  l_inda103    LIKE inda_t.inda103
DEFINE  l_inda104    LIKE inda_t.inda104
DEFINE  l_indd101    LIKE indd_t.indd101
DEFINE  l_inda007    LIKE inda_t.inda007
DEFINE  l_sql        STRING 
   LET l_cnt = 0
   IF cl_null(g_indd_d[l_ac].indd101) THEN
      RETURN FALSE
   END IF 
   IF g_indc_m.indc002 = '2' THEN  #160921-00014#1
   IF NOT cl_null(g_indc_m.indc003) THEN  #add by lixh 20150422
      LET l_sql = " SELECT COUNT(*) FROM inda_t ",
                  "  WHERE indaent = '",g_enterprise,"'",
                  "    AND indadocno = '",g_indd_d[l_ac].indd101,"'",
                  "    AND inda109 = '1' "
      IF g_indc_m.indc006 IS NOT NULL THEN
         LET l_sql = l_sql," AND inda004 = '",g_indc_m.indc006,"'"
      END IF
      IF g_indc_m.indc102 IS NOT NULL THEN
         LET l_sql = l_sql," AND inda102 = '",g_indc_m.indc102,"'"
      END IF 
      IF g_indc_m.indc103 IS NOT NULL THEN
         LET l_sql = l_sql," AND inda103 = '",g_indc_m.indc103,"'"
      END IF    
      IF g_indc_m.indc104 IS NOT NULL THEN
         LET l_sql = l_sql," AND inda104 = '",g_indc_m.indc104,"'"
      END IF   
 #mark by lixh 20150422      
#      IF g_indc_m.indc105 IS NOT NULL THEN
#         LET l_sql = l_sql," AND inda105 = '",g_indc_m.indc105,"'"
#      END IF   
#      IF g_indc_m.indc106 IS NOT NULL THEN
#         LET l_sql = l_sql," AND inda106 = '",g_indc_m.indc106,"'"
#      END IF  
#      IF g_indc_m.indc107 IS NOT NULL THEN
#         LET l_sql = l_sql," AND inda107 = '",g_indc_m.indc107,"'"
#      END IF    
#      IF g_indc_m.indc108 IS NOT NULL THEN
#         LET l_sql = l_sql," AND inda108 = '",g_indc_m.indc108,"'"
#      END IF
 #mark by lixh 20150422
      #150323---earl---add---s
      IF g_indc_m.indc009 IS NOT NULL THEN
         LET l_sql = l_sql," AND inda007 = '",g_indc_m.indc009,"'"
      END IF   
      #150323---earl---add---e

#   SELECT COUNT(*) INTO l_cnt FROM inda_t
#    WHERE indaent = g_enterprise
#      AND indadocno = g_indd_d[l_ac].indd101
#      AND inda004 = g_indc_m.indc006
#      AND inda102 = g_indc_m.indc102
#      AND inda103 = g_indc_m.indc103
#      AND inda104 = g_indc_m.indc104
#      AND inda105 = g_indc_m.indc105
#      AND inda106 = g_indc_m.indc106
#      AND inda107 = g_indc_m.indc107
#      AND inda108 = g_indc_m.indc108
     PREPARE sel_inda_pre FROM l_sql
     LET l_cnt = 0
     EXECUTE sel_inda_pre INTO l_cnt
     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
     IF l_cnt = 0 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'ain-00192'
        LET g_errparam.extend = g_indd_d[l_ac].indd101
        LET g_errparam.popup = TRUE
        CALL cl_err()
    
        RETURN FALSE
     END IF 
  #END IF   #add by lixh 20150422  
   ELSE
#add by lixh 20150422 
      LET l_sql = " SELECT COUNT(*) FROM inda_t ",
                  "  WHERE indaent = '",g_enterprise,"'",
                  "    AND indadocno = '",g_indd_d[l_ac].indd101,"'",  
                  "    AND inda109 = '1'"
      SELECT DISTINCT indd101 INTO l_indd101 FROM indd_t  
       WHERE inddent = g_enterprise
         AND inddsite = g_site
         AND indddocno = g_indc_m.indcdocno
         AND (indddocno = g_indc_m.indcdocno AND inddseq <> g_indd_d[l_ac].inddseq)
      IF NOT cl_null(l_indd101) THEN
         SELECT inda004,inda102,inda103,inda104,inda007 INTO l_inda004,l_inda102,l_inda103,l_inda104,l_inda007 FROM inda_t
          WHERE indaent = g_enterprise
            AND indadocno = l_indd101
         
#      LET l_sql = " SELECT COUNT(*) FROM inda_t ",
#                  "  WHERE indaent = '",g_enterprise,"'",
#                  "    AND indadocno = '",g_indd_d[l_ac].indd101,"'"
         IF l_inda004 IS NOT NULL THEN
            LET l_sql = l_sql," AND inda004 = '",l_inda004,"'"
         END IF
         IF l_inda102 IS NOT NULL THEN
            LET l_sql = l_sql," AND inda102 = '",l_inda102,"'"
         END IF 
         IF l_inda103 IS NOT NULL THEN
            LET l_sql = l_sql," AND inda103 = '",l_inda103,"'"
         END IF    
         IF l_inda104 IS NOT NULL THEN
            LET l_sql = l_sql," AND inda104 = '",l_inda104,"'"
         END IF       
         IF l_inda007 IS NOT NULL THEN
            LET l_sql = l_sql," AND inda007 = '",l_inda007,"'"
         END IF      
#      PREPARE sel_inda_pre01 FROM l_sql
#      LET l_cnt = 0
#      EXECUTE sel_inda_pre01 INTO l_cnt
#      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
#      IF l_cnt = 0 THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'ain-00192'
#         LET g_errparam.extend = g_indd_d[l_ac].indd101
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#     
#         RETURN FALSE
#      END IF 
   #add by lixh 20160108 151225-00013/1   
      ELSE
         IF g_indc_m.indc006 IS NOT NULL THEN
            LET l_sql = l_sql," AND inda004 = '",g_indc_m.indc006,"'"
         END IF
         IF g_indc_m.indc102 IS NOT NULL THEN
            LET l_sql = l_sql," AND inda102 = '",g_indc_m.indc102,"'"
         END IF    
   #add by lixh 20160108 151225-00013/1       
      END IF
   #add by lixh 20160108 151225-00013/1  
      PREPARE sel_inda_pre01 FROM l_sql
      LET l_cnt = 0
      EXECUTE sel_inda_pre01 INTO l_cnt
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00192'
         LET g_errparam.extend = g_indd_d[l_ac].indd101
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         RETURN FALSE
      END IF  
   END IF
   #add by lixh 20160108 151225-00013/1        
#add by lixh 20150422 
   END IF #160921-00014#1
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 檢查項次是否能輸入
# Memo...........:
# Usage..........: CALL aint330_indd001_chk()
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd001_chk()
DEFINE  l_cnt       LIKE type_t.num5
#160921-00014#1-s
DEFINE  l_inbj009   LIKE inbj_t.inbj009
DEFINE  l_inbj010   LIKE inbj_t.inbj010
DEFINE  s_indd103   LIKE indd_t.indd103
DEFINE  l_indd103   LIKE indd_t.indd103
#160921-00014#1-e

   IF cl_null(g_indd_d[l_ac].indd101) OR cl_null(g_indd_d[l_ac].indd001) THEN
      RETURN TRUE
   END IF
   LET l_cnt = 0
   IF g_indc_m.indc002 = '2' THEN  #160921-00014#1
      SELECT COUNT(1) INTO l_cnt FROM indb_t
       WHERE indbent = g_enterprise
         AND indbdocno = g_indd_d[l_ac].indd101
         AND indbseq = g_indd_d[l_ac].indd001
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00193'
         LET g_errparam.extend = g_indd_d[l_ac].indd001
         LET g_errparam.popup = TRUE
         CALL cl_err()
     
         RETURN FALSE
      END IF   
      LET l_cnt = 0      
      SELECT COUNT(1) INTO l_cnt FROM indb_t
       WHERE indbent = g_enterprise
         AND indbdocno = g_indd_d[l_ac].indd101
         AND indbseq = g_indd_d[l_ac].indd001
         AND (indb008 > indb011 OR indb011 IS NULL)
         AND indb008 > 0
      #161013-00028#1-S
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         SELECT COUNT(1) INTO l_cnt FROM indb_t
          WHERE indbent = g_enterprise
            AND indbdocno = g_indd_d[l_ac].indd101
            AND indbseq = g_indd_d[l_ac].indd001
            AND (indb008 < indb011 OR indb011 IS NULL)
            AND indb008 < 0
      END IF         
      #161013-00028#1-E
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00194'
         LET g_errparam.extend = g_indd_d[l_ac].indd001
         LET g_errparam.popup = TRUE
         CALL cl_err()
     
         RETURN FALSE
      END IF   
   END IF  #160921-00014#1
   
   #160921-00014#1-S
   IF g_indc_m.indc002 = '10' THEN   
      SELECT COUNT(1) INTO l_cnt FROM inbi_t
       WHERE inbient = g_enterprise
         AND inbisite = g_site
         AND inbidocno = g_indd_d[l_ac].indd101
         AND inbistus = 'S'
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00800'
         LET g_errparam.extend = g_indd_d[l_ac].indd001
         LET g_errparam.popup = TRUE
         CALL cl_err()     
         RETURN FALSE                   
      END IF 

      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_indd_d[l_ac].indd101
      LET g_chkparam.arg2 = g_indd_d[l_ac].indd001
         
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_inbjseq_1") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
      ELSE
         #檢查失敗時後續處理
         RETURN FALSE                  
      END IF               
                   
      #申請數量
      SELECT SUM(indd103) INTO s_indd103 FROM indd_t
       WHERE inddent = g_enterprise
         AND indd101 = g_indd_d[l_ac].indd101
         AND indd001 = g_indd_d[l_ac].indd001
         AND ((indddocno = g_indc_m.indcdocno AND inddseq <> g_indd_d[l_ac].inddseq) OR indddocno <> g_indc_m.indcdocno)
      IF cl_null(s_indd103)  THEN LET s_indd103 = 0 END IF
      SELECT inbj009,inbj010 INTO l_inbj009,l_inbj010 FROM inbj_t
       WHERE inbjent = g_enterprise
         AND inbjdocno = g_indd_d[l_ac].indd101
         AND inbjseq = g_indd_d[l_ac].indd001     
      LET l_indd103 = l_inbj009 - l_inbj010 - s_indd103 
      IF l_indd103 < = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00801'
         LET g_errparam.extend = g_indd_d[l_ac].indd101
         LET g_errparam.popup = TRUE
         CALL cl_err()     
         RETURN FALSE       
      END IF      
   END IF
   #160921-00014#1-E
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 帶出品名、規格、庫存單位
# Memo...........:
# Usage..........: CALL aint330_indd002_ref()
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd002_ref()
DEFINE l_imaf091   LIKE imaf_t.imaf091
DEFINE l_imaf092   LIKE imaf_t.imaf092
DEFINE l_indb102   LIKE indb_t.indb102
DEFINE l_indb103   LIKE indb_t.indb103

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_indd_d[l_ac].indd002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_indd_d[l_ac].indd002_desc = '', g_rtn_fields[1] , ''
   LET g_indd_d[l_ac].indd002_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_indd_d[l_ac].indd002_desc
   DISPLAY BY NAME g_indd_d[l_ac].indd002_desc_desc
   IF cl_null(g_indd_d[l_ac].indd002) THEN
      LET g_indd_d[l_ac].indd104 = ''
      LET g_indd_d[l_ac].indd104_desc = ''
      LET g_indd_d[l_ac].indd006 = '' 
      LET g_indd_d[l_ac].indd006_desc = ''   
      LET g_indd_d[l_ac].indd041 = ''       #add by lixh 20150108
      LET g_indd_d[l_ac].indd041_desc = ''       
   END IF   
   IF g_indd_d[l_ac].indd002 <> g_indd_d_o.indd002 OR g_indd_d_o.indd002 IS NULL THEN               
      SELECT imaf015,imaf053,imaf091,imaf092 INTO g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd006,l_imaf091,l_imaf092 FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_indd_d[l_ac].indd002
      LET g_indd_d[l_ac].indd041 = g_indd_d[l_ac].indd006
      CALL aint330_indd041_ref()        
      CALL aint330_indd006_ref()
      CALL aint330_indd104_ref()   
      
      IF g_indc_m.indc002 = '1' THEN
         LET g_indd_d[l_ac].indd022 = l_imaf091
         LET g_indd_d[l_ac].indd023 = l_imaf092
      END IF 
      IF g_indc_m.indc002 = '2' THEN
         SELECT indb102,indb103 INTO l_indb102,l_indb103 FROM indb_t
          WHERE indbent = g_enterprise
            AND indbdocno = g_indd_d[l_ac].indd101
            AND indbseq = g_indd_d[l_ac].indd001 
         IF cl_null(l_indb102) THEN 
            LET g_indd_d[l_ac].indd022 = l_imaf091
            LET g_indd_d[l_ac].indd023 = l_imaf092
         END IF         
      END IF
      CALL aint330_indd022_ref()
      CALL aint330_indd023_ref()                   
      DISPLAY BY NAME g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd041   
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_indd022_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd022_ref()
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_site
#            LET g_ref_fields[2] = g_indd_d[l_ac].indd022
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite = ? AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_indd_d[l_ac].indd022_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indd_d[l_ac].indd022_desc
   CALL s_desc_get_stock_desc(g_site,g_indd_d[l_ac].indd022) RETURNING g_indd_d[l_ac].indd022_desc
   DISPLAY BY NAME g_indd_d[l_ac].indd022_desc
END FUNCTION

################################################################################
# Descriptions...: 帶出理由碼說明
# Memo...........:
# Usage..........: CALL aint330_indd151_ref()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd151_ref()
            LET g_indd_d[l_ac].indd151_desc = ''
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_acc        
            LET g_ref_fields[2] = g_indd_d[l_ac].indd151
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = ? AND oocql002=? ","") RETURNING g_rtn_fields
            LET g_indd_d[l_ac].indd151_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indd_d[l_ac].indd151_desc
END FUNCTION

################################################################################
# Descriptions...: 帶出理由碼說明
# Memo...........:
# Usage..........: CALL aint330_indc151_ref()
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indc151_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_acc        
            LET g_ref_fields[2] = g_indc_m.indc151
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = ? AND oocql002=? ","") RETURNING g_rtn_fields
            LET g_indc_m.indc151_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indc_m.indc151_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_indc106_ref()
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indc106_ref()

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indc_m.indc106
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indc_m.indc106_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indc_m.indc106_desc
END FUNCTION

################################################################################
# Descriptions...: 地址說明
# Memo...........:
# Usage..........: CALL aint330_indc105_ref()
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indc105_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofa001
            LET g_ref_fields[2] = g_indc_m.indc105
            CALL ap_ref_array2(g_ref_fields,"SELECT oofb011 FROM oofb_t WHERE oofbent='"||g_enterprise||"' AND oofb002=?  AND oofb019 = ? ","") RETURNING g_rtn_fields
            LET g_indc_m.indc105_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indc_m.indc105_desc
END FUNCTION

################################################################################
# Descriptions...: 帶出據點名稱
# Memo...........:
# Usage..........: CALL aint330_indc006_ref()
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indc006_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indc_m.indc006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indc_m.indc006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indc_m.indc006_desc
END FUNCTION

################################################################################
# Descriptions...: 倉庫名稱
# Memo...........:
# Usage..........: CALL aint330_indd023_ref()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd023_ref()

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_site
#            LET g_ref_fields[2] = g_indd_d[l_ac].indd022
#            LET g_ref_fields[3] = g_indd_d[l_ac].indd023
#            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite = ? AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
#            LET g_indd_d[l_ac].indd023_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indd_d[l_ac].indd023_desc
   IF NOT cl_null(g_indd_d[l_ac].indd023) THEN
      CALL s_desc_get_locator_desc(g_site,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023) RETURNING g_indd_d[l_ac].indd023_desc
      DISPLAY BY NAME g_indd_d[l_ac].indd023_desc
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_inag_chk(p_site,p_inag004,p_inag005,p_inag006)
#                  RETURNING TRUE/FLASE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_inag_chk(p_site,p_inag004,p_inag005,p_inag006)
DEFINE p_site       LIKE inag_t.inagsite
DEFINE p_inag004    LIKE inag_t.inag004
DEFINE p_inag005    LIKE inag_t.inag005
DEFINE p_inag006    LIKE inag_t.inag006
DEFINE l_n          LIKE type_t.num5
DEFINE l_sql        STRING

   LET l_sql = "SELECT COUNT(*) FROM inag_t WHERE inagent = ",g_enterprise,
               " AND inagsite='",p_site,"' "
   IF NOT cl_null(g_indd_d[l_ac].indd002) THEN
      LET l_sql = l_sql," AND inag001 = '",g_indd_d[l_ac].indd002,"'"
   END IF
#   IF g_indd_d[l_ac].indd004 IS NOT NULL THEN
   IF NOT cl_null(g_indd_d[l_ac].indd004) THEN
      LET l_sql = l_sql," AND inag002 = '",g_indd_d[l_ac].indd004,"'"
   END IF  
#   IF g_indd_d[l_ac].indd102 IS NOT NULL THEN
   IF NOT cl_null(g_indd_d[l_ac].indd102) THEN
      LET l_sql = l_sql," AND inag003 = '",g_indd_d[l_ac].indd102,"'"
   END IF    
   IF NOT cl_null(p_inag004) THEN
      LET l_sql = l_sql," AND inag004 = '",p_inag004,"'"
   END IF   
#   IF p_inag005 IS NOT NULL THEN
   IF NOT cl_null(p_inag005) THEN
      LET l_sql = l_sql," AND inag005 = '",p_inag005,"'"
   END IF  
   IF p_inag006 IS NOT NULL THEN
      LET l_sql = l_sql," AND inag006 = '",p_inag006,"'"
   END IF   
  #庫存多單位管理
   IF NOT cl_null(g_indd_d[l_ac].indd006) THEN
      LET l_sql = l_sql," AND inag007 = '",g_indd_d[l_ac].indd006,"'"
   END IF   
   PREPARE sel_inag_pre FROM l_sql
   LET l_n = 0
   EXECUTE sel_inag_pre INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00119'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF       
   LET l_sql = l_sql," AND inag008 > 0 "
   PREPARE sel_inag_pre2 FROM l_sql
   LET l_n = 0
   EXECUTE sel_inag_pre2 INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00120'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF      
   RETURN TRUE 
END FUNCTION

################################################################################
# Descriptions...: 單位说明
# Memo...........:
# Usage..........: CALL aint330_indd006_ref()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd006_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indd_d[l_ac].indd006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indd_d[l_ac].indd006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indd_d[l_ac].indd006_desc
END FUNCTION

################################################################################
# Descriptions...: 料件交易單位檢查
# Memo...........:
# Usage..........: CALL aint330_imao_chk()
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_imao_chk()
DEFINE l_cnt     LIKE type_t.num5   
   IF cl_null(g_indd_d[l_ac].indd002) OR cl_null(g_indd_d[l_ac].indd006) THEN 
      RETURN TRUE
   END IF
   SELECT COUNT(*) INTO l_cnt FROM imao_t
    WHERE imaoent = g_enterprise
      AND imao001 = g_indd_d[l_ac].indd002
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      RETURN TRUE
   END IF
   IF l_cnt <> 0 THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM imao_t
       WHERE imaoent = g_enterprise
         AND imao001 = g_indd_d[l_ac].indd002
         AND imao002 = g_indd_d[l_ac].indd006  
     IF l_cnt < 1 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'ain-00233'
        LET g_errparam.extend = g_indd_d[l_ac].indd006
        LET g_errparam.popup = TRUE
        CALL cl_err()

        RETURN FALSE
     END IF     
   END IF   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 倉庫说明
# Memo...........:
# Usage..........: CALL aint330_indd032_ref()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd032_ref()
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indc006
#            LET g_ref_fields[2] = g_indd_d[l_ac].indd032
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite = ? AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_indd_d[l_ac].indd032_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indd_d[l_ac].indd032_desc

   CALL s_desc_get_stock_desc(g_indc_m.indc006,g_indd_d[l_ac].indd032) RETURNING g_indd_d[l_ac].indd032_desc
   DISPLAY BY NAME g_indd_d[l_ac].indd032_desc
END FUNCTION

################################################################################
# Descriptions...: 儲位说明
# Memo...........:
# Usage..........: CALL aint330_indd033_ref()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd033_ref()
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_indc_m.indc006
#            LET g_ref_fields[2] = g_indd_d[l_ac].indd032
#            LET g_ref_fields[3] = g_indd_d[l_ac].indd033
#            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite = ? AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
#            LET g_indd_d[l_ac].indd033_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_indd_d[l_ac].indd033_desc
   IF NOT cl_null(g_indd_d[l_ac].indd033) THEN
      CALL s_desc_get_locator_desc(g_indc_m.indc006,g_indd_d[l_ac].indd032,g_indd_d[l_ac].indd033) RETURNING g_indd_d[l_ac].indd033_desc
      DISPLAY BY NAME g_indd_d[l_ac].indd033_desc   
   END IF
END FUNCTION

################################################################################
# Descriptions...: 單位取位
# Memo...........:
# Usage..........: CALL aint330_unit_round(p_indd006,p_indd103))
#                  RETURNING r_indd103
# Input parameter: p_indd006   單位
#                : p_indd103   數量
# Return code....: r_indd103   數量
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_unit_round(p_indd006,p_indd103)

DEFINE p_indd006   LIKE indd_t.indd006
DEFINE p_indd103   LIKE indd_t.indd103
DEFINE l_success   LIKE type_t.num5
DEFINE l_ooca002   LIKE ooca_t.ooca002      #小数位数
DEFINE l_ooca004   LIKE ooca_t.ooca004      #舍入类型 
DEFINE r_indd103   LIKE indd_t.indd103      #數量

       LET l_success = NULL
       LET l_ooca002 = 0
       LET l_ooca004 = NULL
       LET r_indd103 = 0
       
       IF cl_null(p_indd006) OR cl_null(p_indd103) THEN
          RETURN p_indd103
       END IF
       
       #抓取单位档中的小数位数和舍入类型
       IF NOT cl_null(p_indd006) THEN
          CALL s_aooi250_get_msg(p_indd006) RETURNING l_success,l_ooca002,l_ooca004
          IF l_success THEN
             IF NOT cl_null(p_indd103) THEN
                CALL s_num_round(l_ooca004,p_indd103,l_ooca002) RETURNING r_indd103
                RETURN r_indd103
             END IF
          END IF
       END IF
       RETURN r_indd103
END FUNCTION

################################################################################
# Descriptions...: 單位取位和參考單位之間的換算
# Memo...........:
# Usage..........: CALL aint330_unit_convert()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_unit_convert()
DEFINE   r_success   LIKE type_t.num5
DEFINE   r_rate      LIKE inaj_t.inaj014
#              #單位取位
#               CALL aint330_unit_round(g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103) RETURNING g_indd_d[l_ac].indd103
#               LET g_indd_d[l_ac].indd021 = g_indd_d[l_ac].indd103
##               LET g_indd_d[l_ac].indd107 = g_indd_d[l_ac].indd103
#               LET g_indd_d[l_ac].indd031 = g_indd_d[l_ac].indd103
#            IF ((g_indd_d[l_ac].indd103 <> g_indd_d_t.indd103 OR g_indd_d_t.indd103 IS NULL) OR
#                (g_indd_d[l_ac].indd006 <> g_indd_d_t.indd006 OR g_indd_d_t.indd006 IS NULL)) AND NOT cl_null(g_indd_d[l_ac].indd104) THEN
#               
##               CALL s_aimi190_get_convert(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd104) 
##                    RETURNING r_success,r_rate  #xj mod
#               CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd103)
#                  RETURNING r_success,g_indd_d[l_ac].indd105
#               IF r_success THEN
##                  LET g_indd_d[l_ac].indd105 = g_indd_d[l_ac].indd103 * r_rate  #xj mod
#                  CALL aint330_unit_round(g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd105) RETURNING g_indd_d[l_ac].indd105
#                  LET g_indd_d[l_ac].indd106 = g_indd_d[l_ac].indd105
##                 LET g_indd_d[l_ac].indd108 = g_indd_d[l_ac].indd105
#                  LET g_indd_d[l_ac].indd109 = g_indd_d[l_ac].indd105    
#               END IF  
#            END IF               
   #單位取位
   CALL aint330_unit_round(g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103) RETURNING g_indd_d[l_ac].indd103
   IF g_indc_m.indc102 = '1' THEN
      LET g_indd_d[l_ac].indd021 = g_indd_d[l_ac].indd103
   ELSE
      LET g_indd_d[l_ac].indd021 = 0
   END IF   
#   LET g_indd_d[l_ac].indd107 = g_indd_d[l_ac].indd103

   #撥入數量換算
   #LET g_indd_d[l_ac].indd031 = g_indd_d[l_ac].indd103
   IF NOT cl_null(g_indd_d[l_ac].indd002) AND
      NOT cl_null(g_indd_d[l_ac].indd006) AND
      NOT cl_null(g_indd_d[l_ac].indd041) AND
      NOT cl_null(g_indd_d[l_ac].indd103) THEN
      CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,
                                 g_indd_d[l_ac].indd041,g_indd_d[l_ac].indd103)
      RETURNING r_success,g_indd_d[l_ac].indd031         
   ELSE
      LET g_indd_d[l_ac].indd031 = 0
   END IF
   IF g_indc_m.indc102 <> '1' THEN
      LET g_indd_d[l_ac].indd031 = 0
   END IF  
               
   IF ((g_indd_d[l_ac].indd103 <> g_indd_d_t.indd103 OR g_indd_d_t.indd103 IS NULL) OR
       (g_indd_d[l_ac].indd006 <> g_indd_d_t.indd006 OR g_indd_d_t.indd006 IS NULL)) AND NOT cl_null(g_indd_d[l_ac].indd104) THEN
      IF NOT cl_null(g_indd_d[l_ac].indd006) AND NOT cl_null(g_indd_d[l_ac].indd104) AND NOT cl_null(g_indd_d[l_ac].indd103) THEN
         CALL s_aooi250_convert_qty(g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd103)
              RETURNING r_success,g_indd_d[l_ac].indd105                 
         IF r_success THEN
            CALL aint330_unit_round(g_indd_d[l_ac].indd104,g_indd_d[l_ac].indd105) RETURNING g_indd_d[l_ac].indd105
            IF g_indc_m.indc102 = '1' THEN  #add by lixh 20150113
               LET g_indd_d[l_ac].indd106 = g_indd_d[l_ac].indd105
               LET g_indd_d[l_ac].indd109 = g_indd_d[l_ac].indd105    
            ELSE
               LET g_indd_d[l_ac].indd106 = 0
               LET g_indd_d[l_ac].indd109 = 0        
            END IF
         END IF  
      END IF
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 數量檢查
# Memo...........:
# Usage..........: CALL aint330_indd103_chk()
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd103_chk()
DEFINE  l_indd103   LIKE indd_t.indd103
DEFINE  l_indb008   LIKE indb_t.indb008
DEFINE  l_indb011   LIKE indb_t.indb011
DEFINE  l_success   LIKE type_t.num5
DEFINE  l_flag      LIKE type_t.num5
DEFINE  l_ooba002   LIKE ooba_t.ooba002
#160921-00014#1-s
DEFINE  l_inbj009   LIKE inbj_t.inbj009
DEFINE  l_inbj010   LIKE inbj_t.inbj010
DEFINE  s_indd103   LIKE indd_t.indd103
#160921-00014#1-e

   IF g_indc_m.indc002 = '2' THEN #160921-00014#1 
      CALL s_aooi200_get_slip(g_indc_m.indcdocno) RETURNING l_success,l_ooba002
      IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0089') = 'Y' THEN
         IF NOT cl_null(g_indd_d[l_ac].indd101) AND NOT cl_null(g_indd_d[l_ac].indd001) THEN
            #已等打調撥單未過帳的量
            SELECT SUM(indd103) INTO l_indd103 FROM indd_t,indc_t
             WHERE indcent = inddent
               AND indcdocno = indddocno
               AND inddent = g_enterprise
               AND indd101 = g_indd_d[l_ac].indd101
               AND indd001 = g_indd_d[l_ac].indd001
               AND inddsite = g_site
               AND (indddocno <> g_indc_m.indcdocno
                OR (indddocno = g_indc_m.indcdocno AND inddseq <> g_indd_d[l_ac].inddseq))
               AND (indcstus = 'N' OR indcstus = 'O')
               AND indc000 = '1'  
            IF cl_null(l_indd103) THEN LET l_indd103 = 0 END IF
            SELECT indb008,indb011 INTO l_indb008,l_indb011 FROM indb_t 
             WHERE indbent = g_enterprise      
               AND indbdocno = g_indd_d[l_ac].indd101       
               AND indbseq = g_indd_d[l_ac].indd001
            IF cl_null(l_indb008) THEN
               LET l_indb008 = 0
            END IF
            IF cl_null(l_indb011) THEN
               LET l_indb011 = 0
            END IF      
            #調撥量不可大於調撥申請量-已撥出量-已等打調撥單未過帳的量
            IF l_indb008 > 0 THEN  #161013-00028#1
               IF g_indd_d[l_ac].indd103 > l_indb008 - l_indb011 - l_indd103  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00234'
                  LET g_errparam.extend = g_indd_d[l_ac].indd103
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            
                  RETURN FALSE
               END IF 
            #161013-00028#1-S   
            END IF      
            IF l_indb008 < 0 THEN
               IF g_indd_d[l_ac].indd103 < l_indb008 - l_indb011 - l_indd103  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00234'
                  LET g_errparam.extend = g_indd_d[l_ac].indd103
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            
                  RETURN FALSE
               END IF 
            END IF 
            #161013-00028#1-E            
         END IF
         LET l_success = ''
         LET l_flag = ''   
         IF NOT cl_null(g_indd_d[l_ac].indd022) THEN     
            CALL s_inventory_check_inan(g_site,g_indd_d[l_ac].indd002,g_indd_d[l_ac].indd004,g_indd_d[l_ac].indd102,g_indd_d[l_ac].indd022,g_indd_d[l_ac].indd023,g_indd_d[l_ac].indd024,
                                        g_indd_d[l_ac].indd006,g_indd_d[l_ac].indd103,g_indc_m.indcdocno,g_indd_d[l_ac].inddseq,'0','','')  #160408-00035#9-add-'',''
                 RETURNING l_success,l_flag
            IF NOT l_success THEN 
               RETURN FALSE
            END IF
            IF l_flag = 0 THEN
               RETURN FALSE
            END IF    
         END IF   
      END IF   
   END IF  #160921-00014#1
   #160921-00014#1-S
   IF g_indc_m.indc002 = '10' THEN
      #申請數量
      SELECT SUM(indd103) INTO s_indd103 FROM indd_t
       WHERE inddent = g_enterprise
         AND indd101 = g_indd_d[l_ac].indd101
         AND indd001 = g_indd_d[l_ac].indd001
         AND ((indddocno = g_indc_m.indcdocno AND inddseq <> g_indd_d[l_ac].inddseq) OR indddocno <> g_indc_m.indcdocno)
      IF cl_null(s_indd103)  THEN LET s_indd103 = 0 END IF
      SELECT inbj009,inbj010 INTO l_inbj009,l_inbj010 FROM inbj_t
       WHERE inbjent = g_enterprise
         AND inbjdocno = g_indd_d[l_ac].indd101
         AND inbjseq = g_indd_d[l_ac].indd001     
      IF g_indd_d[l_ac].indd103 > l_inbj009 - l_inbj010 - s_indd103 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00802'
         LET g_errparam.extend = g_indd_d[l_ac].indd101
         LET g_errparam.popup = TRUE
         CALL cl_err()     
         RETURN FALSE       
      END IF      
   END IF 
   #160921-00014#1-E
   RETURN TRUE 
END FUNCTION

################################################################################
# Descriptions...: 撥出據點料號必須也存在與撥入據點
# Memo...........:
# Usage..........: CALL aint330_indd002_chk()
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd002_chk()
DEFINE  l_cnt    LIKE type_t.num5   
   LET l_cnt = 0
   IF l_ac > 0 AND NOT cl_null(g_indd_d[l_ac].indd002) AND NOT cl_null(g_indc_m.indc006) AND g_indc_m.indc006 <> g_site THEN 
      SELECT COUNT(*) INTO l_cnt FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_indc_m.indc006
         AND imaf001 = g_indd_d[l_ac].indd002
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt < 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00256'
         LET g_errparam.extend = g_indd_d[l_ac].indd002
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 庫存明細數量檢查
# Memo...........:
# Usage..........: CALL aint330_inag008_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_inag008_chk()
DEFINE l_inag008 LIKE inag_t.inag008
DEFINE l_sql      STRING
DEFINE l_imaf055  LIKE imaf_t.imaf055

   LET l_inag008 = 0
   IF NOT cl_null(g_indd_d[l_ac].indd103) AND NOT cl_null(g_indd_d[l_ac].indd002) AND NOT cl_null(g_indd_d[l_ac].indd022) AND NOT cl_null(g_indd_d[l_ac].indd006) THEN
      IF g_indd_d[l_ac].indd004 IS NULL THEN
         LET g_indd_d[l_ac].indd004 = ' '
      END IF
      #160519-00008#4-s
      SELECT imaf055 INTO l_imaf055 FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_indd_d[l_ac].indd002
      IF l_imaf055 <> '1' THEN
         IF g_indd_d[l_ac].indd102 IS NULL THEN
            LET g_indd_d[l_ac].indd102 = ' '
         END IF      
      END IF      
#      IF g_indd_d[l_ac].indd102 IS NULL THEN
#         LET g_indd_d[l_ac].indd102 = ' '
#      END IF
      #160519-00008#4-e
      IF g_indd_d[l_ac].indd023 IS NULL THEN
         LET g_indd_d[l_ac].indd023 = ' '
      END IF
      IF g_indd_d[l_ac].indd024 IS NULL THEN
         LET g_indd_d[l_ac].indd024 = ' '
      END IF
      LET l_sql = "SELECT inag008 FROM inag_t WHERE inagent = '",g_enterprise,"'",
                   "  AND inagsite = '",g_site,"' AND inag001 = '",g_indd_d[l_ac].indd002,"'",
                   "  AND inag004 = '",g_indd_d[l_ac].indd022,"'",
                   "  AND inag002 = '",g_indd_d[l_ac].indd004,"'",
                   "  AND inag003 = '",g_indd_d[l_ac].indd102,"' AND inag005 = '",g_indd_d[l_ac].indd023,"'",
                   "  AND inag006 = '",g_indd_d[l_ac].indd024,"' AND inag007 = '",g_indd_d[l_ac].indd006,"'"
      
      PREPARE sel_inag008_prep FROM l_sql
      EXECUTE sel_inag008_prep INTO l_inag008
      IF cl_null(l_inag008) THEN LET l_inag008 = 0 END IF
      IF g_indd_d[l_ac].indd103 > l_inag008 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00184'
         LET g_errparam.extend = g_indd_d[l_ac].indd103||" > "||l_inag008
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_indd104_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_indd104_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_indd_d[l_ac].indd104
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_indd_d[l_ac].indd104_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_indd_d[l_ac].indd104_desc
END FUNCTION

################################################################################
# Descriptions...: 批序號檢查
# Memo...........:
# Usage..........: CALL aint330_pxh_chk()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_pxh_chk()
DEFINE l_n LIKE type_t.num5
   LET l_n = 0
#   SELECT COUNT(*) INTO l_n FROM imaf_t
#    WHERE imafent = g_enterprise AND imafsite = g_site
#      AND imaf001 = g_indd_d[l_ac].indd002 AND (imaf071 = '1' OR imaf071 = '3')
#      AND (imaf081 = '1' OR imaf081 = '3')
#   IF l_n = 0 THEN
#      RETURN FALSE
#   END IF
#
#   LET l_n = 0
#   SELECT COUNT(*) INTO l_n FROM inai_t
#    WHERE inaient = g_enterprise AND inaisite = g_site
#      AND inai001 = g_indd_d[l_ac].indd002 AND inai002 = g_indd_d[l_ac].indd004
#      AND inai003 = g_indd_d[l_ac].indd102 AND inai004 = g_indd_d[l_ac].indd022
#      AND inai005 = g_indd_d[l_ac].indd023 AND inai006 = g_indd_d[l_ac].indd024
#      AND inai010 > 0

   #add by lixh 20150827
   SELECT COUNT(1) INTO l_n FROM imaf_t
    WHERE imafent = g_enterprise AND imafsite = g_site
      AND imaf001 = g_indd_d[l_ac].indd002 AND (imaf071 = '1' OR imaf081 = '1')
   #add by lixh 20150827
   
   IF l_n = 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 抓取批序號資料
# Memo...........:
# Usage..........: CALL aint330_b_fill_pxh()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_b_fill_pxh()
DEFINE l_ac1    LIKE type_t.num5
DEFINE l_sql    STRING   
   LET l_sql = " SELECT inao000,inao013,inaodocno,inaoseq,inaoseq1,inaoseq2,inao001,inao008,inao009,inao012,inao010,inao011,t1.imaal003,t1.imaal004 FROM inao_t ",
               "   LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=inao001 AND t1.imaal002='"||g_dlang||"' ",
               "  WHERE inaoent = '",g_enterprise,"'",
               "    AND inaosite = '",g_site,"'",
               "    AND inaodocno = '",g_indc_m.indcdocno,"'" ,     
               "    AND inaoseq = '",g_indd_d[l_ac].inddseq,"'"


   PREPARE aint330_pxh_pb FROM l_sql
   DECLARE pxh_fill_cs CURSOR FOR aint330_pxh_pb
   LET l_ac1 = 1   
   FOREACH pxh_fill_cs INTO g_inao_d[l_ac1].inao000,g_inao_d[l_ac1].inao013,g_inao_d[l_ac1].inaodocno,g_inao_d[l_ac1].inaoseq,g_inao_d[l_ac1].inaoseq1,g_inao_d[l_ac1].inaoseq2,g_inao_d[l_ac1].inao001,g_inao_d[l_ac1].inao008,
                            g_inao_d[l_ac1].inao009,g_inao_d[l_ac1].inao012,g_inao_d[l_ac1].inao010,g_inao_d[l_ac1].inao011,g_inao_d[l_ac1].inao001_desc,g_inao_d[l_ac1].inao001_desc_desc
                            
      IF SQLCA.sqlcode THEN
         EXIT FOREACH
      END IF      
      LET l_ac1 = l_ac1 + 1                      
   END FOREACH                            
   CALL g_inao_d.deleteElement(g_inao_d.getLength())               
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_set_no_required_b()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_set_no_required_b()
   CALL cl_set_comp_required('indd102',FALSE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint330_set_required_b()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint330_set_required_b()
DEFINE  l_imaf055   LIKE imaf_t.imaf055

   IF l_ac <> 0 THEN
      
      SELECT imaf055 INTO l_imaf055 FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_indd_d[l_ac].indd002
      #161007-00012#2-s-mod
      #有兩種情況，庫存管理特徵需必輸
      #(1)aimm212的庫存管理特徵碼選1.必須有庫存管理特徵  (2)撥出/入庫位，任一為VMI存貨倉
      #IF l_imaf055 = '1' THEN   
      #   CALL cl_set_comp_required('indd102',TRUE)
      #END IF   
      IF l_imaf055 = '1' THEN   
         CALL cl_set_comp_required('indd102',TRUE)
         IF cl_null(g_indd_d[l_ac].indd102) THEN
            LET g_indd_d[l_ac].indd102 = ''
         END IF
      ELSE
         #撥出/入庫位
         IF g_indd022_type = '1' OR g_indd032_type = '1' THEN
            CALL cl_set_comp_required('indd102',TRUE)
            IF cl_null(g_indd_d[l_ac].indd102) THEN
               LET g_indd_d[l_ac].indd102 = ''
            END IF
         ELSE
            IF cl_null(g_indd_d[l_ac].indd102) THEN
               LET g_indd_d[l_ac].indd102 = ' '
            END IF
         END IF
      END IF
      #161007-00012#2-e-mod
      
   END IF
END FUNCTION

 
{</section>}
 
