#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0041(2017-02-08 10:52:14), PR版次:0041(2017-02-21 13:57:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000506
#+ Filename...: apmt400
#+ Description: 請購單維護作業
#+ Creator....: 02294(2013-12-02 16:11:17)
#+ Modifier...: 05423 -SD/PR- 08734
 
{</section>}
 
{<section id="apmt400.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151210-00002#1     15/12/21 By Polly   來源為訂單時需控卡不可大於訂購量
#151224-00025#2     15/12/25 By catmoon 手動輸入特徵碼同步新增inam_t[料件產品特徵明細檔]
#160106-00006#1     16/02/01 By lixiang 预算科目为空时，不进行预算金额的检核
#151217-00005#1     16/02/01 By lixiang 1.单价为必要输入栏位勾选后，单身的参考单价栏位必输
#                                       2.变更单头税别，币别等栏位后，重新计算单身金额
#150603-00016#1     16/02/01 By lixiang 变更单头税别后，更新单身税率，已并入151217-00005#1调整
#160223-00004#1     16/02/24 By lixiang 根據單別參數，預帶預設庫位的值，aooi200抓值優先順序：預設欄位>應用參數
#160314-00009#3     16/03/16 By zhujing 各程式增加产品特征是否需要自动开窗的程式段处理
#160407-00023#1     16/04/07 By Dido    取消開啟時全選處理,此將影響 azzi000 無法依據查詢方案查詢
#160318-00025#16    16/04/12 BY 07900   校验代码重复错误讯息的修改
#130802-00004#158    16/04/28 By lixiang 請購單單身資料批次產生功能
#160107-00011#1     16/04/28 By lixiang 請購單單身資料批次產生功能(并入#130802-00004#158 處理)
#160505-00003#1     16/05/05 By lixiang  调整调用整批产生子作业的代码段位置，否则自行新增时，部分栏位无预设值
#160711-00041#1     16/07/12 By lixiang 单据日期栏位有参数控制是否可开启，取消原先在修改状态下直接关闭日期栏位的控制
#160728-00008#1     16/07/29 By lixiang 审核段出错时，资料会被锁住没有及时释放出来
#160804-00021#1     16/08/04 By lixiang  审核后，产生单身按钮不可再执行
#160815-00031#1     16/08/16 By lixiang  料件類別為"E"的，卡備註要必輸,其余都非必
#160816-00001#8     2016/08/19  By 08734  抓取理由碼改CALL sub
#160731-00042#1     2016/08/25  By lixiang （#160731-00444#1）整批产生后，请购单单身无内容时，不再弹出整批产生单身的选择
#160818-00017#26    2016/08/29  By lixiang 单据类作业修改，删除时需重新检查状态
#160727-00025#9     2016/09/01  By lixiang 工單轉請購時，須檢核不可超過工單總應發數量
#160920-00035#1     2016/09/30  By lixiang 請購單、採購單若是由APS轉入，在修改請/採購單時，要更新回APS的表
#160831-00002#1     2016/10/12  By 06948   修正留置/結案代碼相同時，若單身項次為留置，代碼說明顯示結案的代碼說明。
#161019-00017#2     2016/10/20  By lixh    组织类型调整 q_ooef001 => q_ooef001_1
#160920-00035#1     2016/10/24  By lixiang 請購單、採購單若是由APS轉入，在修改請/採購單時，要更新回APS的表
#161124-00048#9     2016/12/19  By zhujing .*整批调整
#161205-00025#1     2016/12/22  By lixiang     效能优化
#161220-00059#6     2016/12/23  by 08172   同apmt830要货单共用单据类型的SCC，要货单新增的SCC选项TJ-已提交，在apmt830中需隐藏不可显示与使用。
#160824-00007#339   2017/01/06  By 06137   修正舊值備份寫法
#161031-00025#8     2017/02/07  By zhujing 1.將aooi360_01以嵌入的方式，用頁籤放在apmt400單頭多帳期頁籤與異動資訊頁籤中間
#                                            要可修改
#                                            控制類型 =3:內部資訊傳遞 取消不要了
#                                            項次固定寫入0
#                                          2.原apmt400的備註action，改為確認後可執行，直接修改單頭新的"備註"頁籤
#                                          3.apmt400單身最後面增加顯示"長備註"欄位，一樣抓取aooi360的備註顯示
#                                            項次 = 單身項次
#                                            控制類型 = 列印在後
#170213-00038#3     2017/02/17  By 08734   新增预算细项和产品特征开窗,修改运送方式栏位,收货时段栏位,留置原因栏位,理由码栏位,交易条件栏位开窗 
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL aoo_aooi360_01   #161031-00025#8 add
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_pmda_m        RECORD
       pmdasite LIKE type_t.chr10, 
   pmdadocno LIKE pmda_t.pmdadocno, 
   pmda001 LIKE pmda_t.pmda001, 
   pmdadocno_desc LIKE type_t.chr80, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   pmda002 LIKE pmda_t.pmda002, 
   pmda002_desc LIKE type_t.chr80, 
   pmda003 LIKE pmda_t.pmda003, 
   pmda003_desc LIKE type_t.chr80, 
   pmdastus LIKE pmda_t.pmdastus, 
   pmda004 LIKE pmda_t.pmda004, 
   pmda010 LIKE pmda_t.pmda010, 
   pmda010_desc LIKE type_t.chr80, 
   pmda011 LIKE pmda_t.pmda011, 
   pmda012 LIKE pmda_t.pmda012, 
   pmda005 LIKE pmda_t.pmda005, 
   pmda005_desc LIKE type_t.chr80, 
   ooan005 LIKE type_t.num26_10, 
   pmda008 LIKE pmda_t.pmda008, 
   pmda009 LIKE pmda_t.pmda009, 
   pmda007 LIKE pmda_t.pmda007, 
   pmda007_desc LIKE type_t.chr80, 
   pmda021 LIKE pmda_t.pmda021, 
   pmda021_desc LIKE type_t.chr80, 
   pmda020 LIKE pmda_t.pmda020, 
   pmda006 LIKE pmda_t.pmda006, 
   pmda023 LIKE pmda_t.pmda023, 
   pmda023_desc LIKE type_t.chr80, 
   pmda022 LIKE pmda_t.pmda022, 
   pmda024 LIKE pmda_t.pmda024, 
   pmda024_desc LIKE type_t.chr80, 
   oofb017 LIKE type_t.chr500, 
   pmda025 LIKE pmda_t.pmda025, 
   pmda025_desc LIKE type_t.chr80, 
   oofb017_1 LIKE type_t.chr500, 
   pmdaownid LIKE pmda_t.pmdaownid, 
   pmdaownid_desc LIKE type_t.chr80, 
   pmdaowndp LIKE pmda_t.pmdaowndp, 
   pmdaowndp_desc LIKE type_t.chr80, 
   pmdacrtid LIKE pmda_t.pmdacrtid, 
   pmdacrtid_desc LIKE type_t.chr80, 
   pmdacrtdp LIKE pmda_t.pmdacrtdp, 
   pmdacrtdp_desc LIKE type_t.chr80, 
   pmdacrtdt LIKE pmda_t.pmdacrtdt, 
   pmdamodid LIKE pmda_t.pmdamodid, 
   pmdamodid_desc LIKE type_t.chr80, 
   pmdamoddt LIKE pmda_t.pmdamoddt, 
   pmdacnfid LIKE pmda_t.pmdacnfid, 
   pmdacnfid_desc LIKE type_t.chr80, 
   pmdacnfdt LIKE pmda_t.pmdacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmdb_d        RECORD
       pmdbsite LIKE type_t.chr10, 
   pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdb001 LIKE pmdb_t.pmdb001, 
   pmdb002 LIKE pmdb_t.pmdb002, 
   pmdb003 LIKE pmdb_t.pmdb003, 
   pmdb052 LIKE pmdb_t.pmdb052, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   pmdb004_desc LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   pmdb005 LIKE pmdb_t.pmdb005, 
   pmdb005_desc LIKE type_t.chr500, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb007_desc LIKE type_t.chr500, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   pmdb009 LIKE pmdb_t.pmdb009, 
   pmdb009_desc LIKE type_t.chr500, 
   pmdb008 LIKE pmdb_t.pmdb008, 
   pmdb011 LIKE pmdb_t.pmdb011, 
   pmdb011_desc LIKE type_t.chr500, 
   pmdb010 LIKE pmdb_t.pmdb010, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb048 LIKE pmdb_t.pmdb048, 
   pmdb048_desc LIKE type_t.chr500, 
   pmdb031 LIKE pmdb_t.pmdb031, 
   pmdb031_desc LIKE type_t.chr500, 
   pmdb050 LIKE pmdb_t.pmdb050, 
   pmdb032 LIKE pmdb_t.pmdb032, 
   pmdb051 LIKE pmdb_t.pmdb051, 
   pmdb051_desc LIKE type_t.chr500, 
   pmdb033 LIKE pmdb_t.pmdb033, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   ooff013 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_pmdb2_d RECORD
       pmdbseq LIKE pmdb_t.pmdbseq, 
   imaal001 LIKE imaal_t.imaal001, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   pmdb012 LIKE pmdb_t.pmdb012, 
   pmdb012_desc LIKE type_t.chr500, 
   pmdb014 LIKE pmdb_t.pmdb014, 
   pmdb015 LIKE pmdb_t.pmdb015, 
   pmdb015_desc LIKE type_t.chr500, 
   pmdb016 LIKE pmdb_t.pmdb016, 
   pmdb016_desc LIKE type_t.chr500, 
   pmdb017 LIKE pmdb_t.pmdb017, 
   pmdb017_desc LIKE type_t.chr500, 
   pmdb018 LIKE pmdb_t.pmdb018, 
   pmdb019 LIKE pmdb_t.pmdb019, 
   pmdb020 LIKE pmdb_t.pmdb020, 
   pmdb021 LIKE pmdb_t.pmdb021, 
   pmdb034 LIKE pmdb_t.pmdb034, 
   pmdb034_desc LIKE type_t.chr500, 
   pmdb035 LIKE pmdb_t.pmdb035, 
   pmdb035_desc LIKE type_t.chr500, 
   pmdb036 LIKE pmdb_t.pmdb036, 
   pmdb036_desc LIKE type_t.chr500, 
   pmdb053 LIKE pmdb_t.pmdb053, 
   pmdb053_desc LIKE type_t.chr500, 
   pmdb037 LIKE pmdb_t.pmdb037, 
   pmdb037_desc LIKE type_t.chr500, 
   pmdb038 LIKE pmdb_t.pmdb038, 
   pmdb038_desc LIKE type_t.chr500, 
   pmdb039 LIKE pmdb_t.pmdb039, 
   pmdb039_desc LIKE type_t.chr500, 
   pmdb054 LIKE pmdb_t.pmdb054, 
   pmdb041 LIKE pmdb_t.pmdb041, 
   pmdb042 LIKE pmdb_t.pmdb042, 
   pmdb043 LIKE pmdb_t.pmdb043, 
   pmdb044 LIKE pmdb_t.pmdb044, 
   pmdb045 LIKE pmdb_t.pmdb045, 
   pmdb046 LIKE pmdb_t.pmdb046, 
   pmdb046_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pmdadocno LIKE pmda_t.pmdadocno,
      b_pmdadocdt LIKE pmda_t.pmdadocdt,
      b_pmda001 LIKE pmda_t.pmda001,
      b_pmda002 LIKE pmda_t.pmda002,
   b_pmda002_desc LIKE type_t.chr80,
      b_pmda003 LIKE pmda_t.pmda003,
   b_pmda003_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_acc          LIKE gzcb_t.gzcb007  
DEFINE g_flag         LIKE type_t.num5
DEFINE g_imaf144      LIKE imaf_t.imaf144 
#ming 20150821 add ---------------------------(S) 
DEFINE g_oofa001      LIKE oofa_t.oofa001
#ming 20150821 add ---------------------------(E) 
#161031-00025#8---s
GLOBALS
TYPE type_g_ooff_d        RECORD
       ooff001 LIKE ooff_t.ooff001, 
   ooff002 LIKE ooff_t.ooff002, 
   ooff004 LIKE ooff_t.ooff004, 
   ooff005 LIKE ooff_t.ooff005, 
   ooff006 LIKE ooff_t.ooff006, 
   ooff007 LIKE ooff_t.ooff007, 
   ooff008 LIKE ooff_t.ooff008, 
   ooff009 LIKE ooff_t.ooff009, 
   ooff010 LIKE ooff_t.ooff010, 
   ooff011 LIKE ooff_t.ooff011, 
   ooff003 LIKE ooff_t.ooff003, 
   ooff012 LIKE ooff_t.ooff012, 
   ooff013 LIKE ooff_t.ooff013, 
   ooff014 LIKE ooff_t.ooff014
       END RECORD
 
DEFINE g_ooff_d4          DYNAMIC ARRAY OF type_g_ooff_d

DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
DEFINE g_wc2_i36001      STRING             #备注单身QBE條件
DEFINE g_d_idx_i36001    LIKE type_t.num5   #备注单身所在筆數
DEFINE g_d_cnt_i36001    LIKE type_t.num5   #备注单身總筆數
DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
DEFINE g_ooff001_d       LIKE ooff_t.ooff001
DEFINE g_ooff002_d       LIKE ooff_t.ooff002
DEFINE g_ooff003_d       LIKE ooff_t.ooff003
DEFINE g_ooff004_d       LIKE ooff_t.ooff004
DEFINE g_ooff005_d       LIKE ooff_t.ooff005
DEFINE g_ooff006_d       LIKE ooff_t.ooff006
DEFINE g_ooff007_d       LIKE ooff_t.ooff007
DEFINE g_ooff008_d       LIKE ooff_t.ooff008
DEFINE g_ooff009_d       LIKE ooff_t.ooff009
DEFINE g_ooff010_d       LIKE ooff_t.ooff010
DEFINE g_ooff011_d       LIKE ooff_t.ooff011
END GLOBALS
DEFINE g_detail_id          STRING           #紀錄停留在哪個Page
#161031-00025#8---e
#end add-point
       
#模組變數(Module Variables)
DEFINE g_pmda_m          type_g_pmda_m
DEFINE g_pmda_m_t        type_g_pmda_m
DEFINE g_pmda_m_o        type_g_pmda_m
DEFINE g_pmda_m_mask_o   type_g_pmda_m #轉換遮罩前資料
DEFINE g_pmda_m_mask_n   type_g_pmda_m #轉換遮罩後資料
 
   DEFINE g_pmdadocno_t LIKE pmda_t.pmdadocno
 
 
DEFINE g_pmdb_d          DYNAMIC ARRAY OF type_g_pmdb_d
DEFINE g_pmdb_d_t        type_g_pmdb_d
DEFINE g_pmdb_d_o        type_g_pmdb_d
DEFINE g_pmdb_d_mask_o   DYNAMIC ARRAY OF type_g_pmdb_d #轉換遮罩前資料
DEFINE g_pmdb_d_mask_n   DYNAMIC ARRAY OF type_g_pmdb_d #轉換遮罩後資料
DEFINE g_pmdb2_d          DYNAMIC ARRAY OF type_g_pmdb2_d
DEFINE g_pmdb2_d_t        type_g_pmdb2_d
DEFINE g_pmdb2_d_o        type_g_pmdb2_d
DEFINE g_pmdb2_d_mask_o   DYNAMIC ARRAY OF type_g_pmdb2_d #轉換遮罩前資料
DEFINE g_pmdb2_d_mask_n   DYNAMIC ARRAY OF type_g_pmdb2_d #轉換遮罩後資料
 
 
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
 
{<section id="apmt400.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   #ming 20150821 add ------------------------(S) 
   #獲取當前營運據點的聯絡對象識別碼 
   LET g_oofa001 = ''
   SELECT oofa001 INTO g_oofa001
     FROM oofa_t
    WHERE oofaent = g_enterprise
      AND oofa002 = '1'
      AND oofa003 = g_site
   #ming 20150821 add ------------------------(E) 
   
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
  # SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog  #160816-00001#8  2016/08/19  By 08734 Mark
   LET g_acc = s_fin_get_scc_value('24',g_prog,'2')  #160816-00001#8  2016/08/19  By 08734 add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT '',pmdadocno,pmda001,'',pmdadocdt,pmda002,'',pmda003,'',pmdastus,pmda004, 
       pmda010,'',pmda011,pmda012,pmda005,'','',pmda008,pmda009,pmda007,'',pmda021,'',pmda020,pmda006, 
       pmda023,'',pmda022,pmda024,'','',pmda025,'','',pmdaownid,'',pmdaowndp,'',pmdacrtid,'',pmdacrtdp, 
       '',pmdacrtdt,pmdamodid,'',pmdamoddt,pmdacnfid,'',pmdacnfdt", 
                      " FROM pmda_t",
                      " WHERE pmdaent= ? AND pmdadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   LET g_forupd_sql = "SELECT pmdasite,pmdadocno,pmda001,'',pmdadocdt,'',pmda002,'','',pmda003,'',pmdastus, ",
                      " pmda004,pmda010,'',pmda011,pmda012,pmda005,'','',pmda008,pmda009,pmda007,'',pmda021,'',pmda020, ",
                      " pmda006,pmda022,pmdaownid,'',pmdaowndp,'',pmdacrtid,'',pmdacrtdp,'',pmdacrtdt,pmdamodid,'',pmdamoddt, ",
                      " pmdacnfid,'',pmdacnfdt FROM pmda_t WHERE pmdaent= ? AND pmdadocno=? FOR UPDATE"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmdasite,t0.pmdadocno,t0.pmda001,t0.pmdadocdt,t0.pmda002,t0.pmda003, 
       t0.pmdastus,t0.pmda004,t0.pmda010,t0.pmda011,t0.pmda012,t0.pmda005,t0.pmda008,t0.pmda009,t0.pmda007, 
       t0.pmda021,t0.pmda020,t0.pmda006,t0.pmda023,t0.pmda022,t0.pmda024,t0.pmda025,t0.pmdaownid,t0.pmdaowndp, 
       t0.pmdacrtid,t0.pmdacrtdp,t0.pmdacrtdt,t0.pmdamodid,t0.pmdamoddt,t0.pmdacnfid,t0.pmdacnfdt,t1.ooag011 , 
       t2.ooefl003 ,t3.ooail003 ,t4.ooefl003 ,t5.oocql004 ,t6.oocql004 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 , 
       t10.ooefl003 ,t11.ooag011 ,t12.ooag011",
               " FROM pmda_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmda002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmda003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.pmda005 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.pmda007 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='263' AND t5.oocql002=t0.pmda021 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='317' AND t6.oocql002=t0.pmda023 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.pmdaownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.pmdaowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.pmdacrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.pmdacrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.pmdamodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.pmdacnfid  ",
 
               " WHERE t0.pmdaent = " ||g_enterprise|| " AND t0.pmdadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmt400_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmt400 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmt400_init()   
 
      #進入選單 Menu (="N")
      CALL apmt400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmt400
      
   END IF 
   
   CLOSE apmt400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL apmt400_01_drop_tmp() #130802-00004#158 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmt400.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmt400_init()
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
      CALL cl_set_combo_scc_part('pmdastus','13','Y,N,TJ,C,A,D,R,W,UH,H,X')
 
      CALL cl_set_combo_scc('pmdb032','2035') 
   CALL cl_set_combo_scc('pmdb033','2036') 
   CALL cl_set_combo_scc('pmdb014','2037') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #161031-00025#8----s
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi360_01"), "grid_memo", "Table", "s_detail1_aooi360_01")
   CALL cl_set_combo_scc_part('ooff012','11','1,2,4')
   CALL cl_set_comp_visible("ooff003",FALSE)
   #161031-00025#8---e
   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("pmdb008,pmdb009,pmdb009_desc",FALSE)
   END IF
   
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pmdb005,pmdb005_desc",FALSE)
   END IF
   
   #整體參數未使用採購計價單位
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" THEN  
      CALL cl_set_comp_visible("pmdb011,pmdb011_desc,pmdb010",FALSE)
   END IF
   
   CALL cl_set_comp_visible("pmdb012,pmdb012_desc",FALSE)
   
   CALL apmt400_01_create_tmp()  #130802-00004#158 add
   CALL cl_set_combo_scc_part('pmdastus','13','Y,N,C,A,D,R,W,UH,H,X')   #161220-00059#6  by 08172
   #end add-point
   
   #初始化搜尋條件
   CALL apmt400_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmt400.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmt400_ui_dialog()
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
            CALL apmt400_insert()
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
         INITIALIZE g_pmda_m.* TO NULL
         CALL g_pmdb_d.clear()
         CALL g_pmdb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmt400_init()
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
               
               CALL apmt400_fetch('') # reload data
               LET l_ac = 1
               CALL apmt400_ui_detailshow() #Setting the current row 
         
               CALL apmt400_idx_chk()
               #NEXT FIELD pmdbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_pmdb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt400_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL apmt400_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_pmdb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt400_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL apmt400_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #单头备注显示
         SUBDIALOG aoo_aooi360_01.aooi360_01_display     #161031-00025#8 add     
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL apmt400_browser_fill("")
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
               CALL apmt400_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmt400_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apmt400_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         #161031-00025#8---s
         ON ACTION remarks_page
            LET g_detail_id = "remarks_page"
            NEXT FIELD ooff012
         #161031-00025#8---e
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apmt400_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apmt400_set_act_visible()   
            CALL apmt400_set_act_no_visible()
            IF NOT (g_pmda_m.pmdadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pmdaent = " ||g_enterprise|| " AND",
                                  " pmdadocno = '", g_pmda_m.pmdadocno, "' "
 
               #填到對應位置
               CALL apmt400_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "pmda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmdb_t" 
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
               CALL apmt400_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "pmda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmdb_t" 
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
                  CALL apmt400_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmt400_fetch("F")
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
               CALL apmt400_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apmt400_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt400_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmt400_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt400_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmt400_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt400_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmt400_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt400_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmt400_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt400_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_pmdb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_pmdb2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #161031-00025#8---s
                  LET g_export_node[3] = base.typeInfo.create(g_ooff_d4)
                  LET g_export_id[3]   = "s_detail1_aooi360_01"
                  #161031-00025#8---e                  
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
               NEXT FIELD pmdbseq
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
               CALL apmt400_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmt400_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmt400_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmt400_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #CALL apmr400_g01("pmdaent ="|| g_enterprise ||" AND pmdadocno ='"|| g_pmda_m.pmdadocno||"'")
               LET g_rep_wc = "pmdaent ="|| g_enterprise ||" AND pmdadocno ='"|| g_pmda_m.pmdadocno||"'"
               #END add-point
               &include "erp/apm/apmt400_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #CALL apmr400_g01("pmdaent ="|| g_enterprise ||" AND pmdadocno ='"|| g_pmda_m.pmdadocno||"'")
               LET g_rep_wc = "pmdaent ="|| g_enterprise ||" AND pmdadocno ='"|| g_pmda_m.pmdadocno||"'"
               #END add-point
               &include "erp/apm/apmt400_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmt400_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmt400_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION memo
            LET g_action_choice="memo"
            IF cl_auth_chk_act("memo") THEN
               
               #add-point:ON ACTION memo name="menu.memo"
               #161031-00025#8---s
#               CALL aooi360_02('6','apmt400',g_pmda_m.pmdadocno,'','','','','','','','','')
               IF NOT cl_null(g_pmda_m.pmdadocno) THEN
                  CALL apmt400_memos()
               END IF
               #161031-00025#8---e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION apmt400_01
            LET g_action_choice="apmt400_01"
            IF cl_auth_chk_act("apmt400_01") THEN
               
               #add-point:ON ACTION apmt400_01 name="menu.apmt400_01"
               #130802-00004#158--add---begin---
               CALL s_transaction_begin()
               IF NOT apmt400_01(g_pmda_m.pmdadocno) THEN
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')      
               END IF
               CALL apmt400_b_fill()    
               #130802-00004#158--add---end---               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_pmda002
            LET g_action_choice="prog_pmda002"
            IF cl_auth_chk_act("prog_pmda002") THEN
               
               #add-point:ON ACTION prog_pmda002 name="menu.prog_pmda002"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_pmda_m.pmda002)


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmt400_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmt400_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmt400_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_pmda_m.pmdadocdt)
 
 
 
         
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
 
{<section id="apmt400.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmt400_browser_fill(ps_page_action)
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
   #161031-00025#8---s
   IF cl_null(g_add_browse) THEN
      CALL aooi360_01_clear_detail()   #清除备注单身
   END IF
   #161031-00025#8---e
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
      LET g_wc = " pmdasite = '",g_site,"' "
   ELSE
      LET g_wc = g_wc , " AND pmdasite = '",g_site,"' "
   END IF
   LET l_wc  = g_wc.trim() 
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT pmdadocno ",
                      " FROM pmda_t ",
                      " ",
                      " LEFT JOIN pmdb_t ON pmdbent = pmdaent AND pmdadocno = pmdbdocno ", "  ",
                      #add-point:browser_fill段sql(pmdb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE pmdaent = " ||g_enterprise|| " AND pmdbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmda_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pmdadocno ",
                      " FROM pmda_t ", 
                      "  ",
                      "  ",
                      " WHERE pmdaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pmda_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #161031-00025#8---s
   IF NOT cl_null(g_wc2_i36001) AND g_wc2_i36001 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND pmdadocno IN ( SELECT ooff003 FROM ooff_t WHERE ooffent = ",g_enterprise," AND ooff001 = '6' AND ooff003= 0 AND ",g_wc2_i36001 CLIPPED ,")"
   END IF
   #161031-00025#8---e
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
      INITIALIZE g_pmda_m.* TO NULL
      CALL g_pmdb_d.clear()        
      CALL g_pmdb2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmdadocno,t0.pmdadocdt,t0.pmda001,t0.pmda002,t0.pmda003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmdastus,t0.pmdadocno,t0.pmdadocdt,t0.pmda001,t0.pmda002,t0.pmda003, 
          t1.ooag011 ,t2.ooefl003 ",
                  " FROM pmda_t t0",
                  "  ",
                  "  LEFT JOIN pmdb_t ON pmdbent = pmdaent AND pmdadocno = pmdbdocno ", "  ", 
                  #add-point:browser_fill段sql(pmdb_t1) name="browser_fill.join.pmdb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmda002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmda003 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.pmdaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pmda_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmdastus,t0.pmdadocno,t0.pmdadocdt,t0.pmda001,t0.pmda002,t0.pmda003, 
          t1.ooag011 ,t2.ooefl003 ",
                  " FROM pmda_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmda002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmda003 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.pmdaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pmda_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY pmdadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmda_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmdadocno,g_browser[g_cnt].b_pmdadocdt, 
          g_browser[g_cnt].b_pmda001,g_browser[g_cnt].b_pmda002,g_browser[g_cnt].b_pmda003,g_browser[g_cnt].b_pmda002_desc, 
          g_browser[g_cnt].b_pmda003_desc
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
         CALL apmt400_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "TJ"
            LET g_browser[g_cnt].b_statepic = "stus/16/committed.png"
         WHEN "C"
            LET g_browser[g_cnt].b_statepic = "stus/16/closed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "UH"
            LET g_browser[g_cnt].b_statepic = "stus/16/unhold.png"
         WHEN "H"
            LET g_browser[g_cnt].b_statepic = "stus/16/hold.png"
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
   
   IF cl_null(g_browser[g_cnt].b_pmdadocno) THEN
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
 
{<section id="apmt400.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmt400_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmda_m.pmdadocno = g_browser[g_current_idx].b_pmdadocno   
 
   EXECUTE apmt400_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmdadocno, 
       g_pmda_m.pmda001,g_pmda_m.pmdadocdt,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004, 
       g_pmda_m.pmda010,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008,g_pmda_m.pmda009, 
       g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda022, 
       g_pmda_m.pmda024,g_pmda_m.pmda025,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp, 
       g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda005_desc,g_pmda_m.pmda007_desc,g_pmda_m.pmda021_desc, 
       g_pmda_m.pmda023_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid_desc, 
       g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc
   
   CALL apmt400_pmda_t_mask()
   CALL apmt400_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apmt400.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmt400_ui_detailshow()
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
 
{<section id="apmt400.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmt400_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmdadocno = g_pmda_m.pmdadocno 
 
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
 
{<section id="apmt400.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmt400_construct()
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
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.num5   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#8
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_pmda_m.* TO NULL
   CALL g_pmdb_d.clear()        
   CALL g_pmdb2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON pmdasite,pmdadocno,pmda001,pmdadocno_desc,pmdadocdt,pmda002,pmda003, 
          pmdastus,pmda004,pmda010,pmda011,pmda012,pmda005,pmda008,pmda009,pmda007,pmda021,pmda020,pmda006, 
          pmda023,pmda022,pmda024,pmda025,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,pmdacrtdt,pmdamodid, 
          pmdamoddt,pmdacnfid,pmdacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmdacrtdt>>----
         AFTER FIELD pmdacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmdamoddt>>----
         AFTER FIELD pmdamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmdacnfdt>>----
         AFTER FIELD pmdacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmdapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdasite
            #add-point:BEFORE FIELD pmdasite name="construct.b.pmdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdasite
            
            #add-point:AFTER FIELD pmdasite name="construct.a.pmdasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdasite
            #add-point:ON ACTION controlp INFIELD pmdasite name="construct.c.pmdasite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdadocno
            #add-point:ON ACTION controlp INFIELD pmdadocno name="construct.c.pmdadocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdadocno  #顯示到畫面上

            NEXT FIELD pmdadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdadocno
            #add-point:BEFORE FIELD pmdadocno name="construct.b.pmdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdadocno
            
            #add-point:AFTER FIELD pmdadocno name="construct.a.pmdadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda001
            #add-point:BEFORE FIELD pmda001 name="construct.b.pmda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda001
            
            #add-point:AFTER FIELD pmda001 name="construct.a.pmda001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda001
            #add-point:ON ACTION controlp INFIELD pmda001 name="construct.c.pmda001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdadocno_desc
            #add-point:BEFORE FIELD pmdadocno_desc name="construct.b.pmdadocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdadocno_desc
            
            #add-point:AFTER FIELD pmdadocno_desc name="construct.a.pmdadocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdadocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdadocno_desc
            #add-point:ON ACTION controlp INFIELD pmdadocno_desc name="construct.c.pmdadocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdadocdt
            #add-point:BEFORE FIELD pmdadocdt name="construct.b.pmdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdadocdt
            
            #add-point:AFTER FIELD pmdadocdt name="construct.a.pmdadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdadocdt
            #add-point:ON ACTION controlp INFIELD pmdadocdt name="construct.c.pmdadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda002
            #add-point:ON ACTION controlp INFIELD pmda002 name="construct.c.pmda002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda002  #顯示到畫面上

            NEXT FIELD pmda002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda002
            #add-point:BEFORE FIELD pmda002 name="construct.b.pmda002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda002
            
            #add-point:AFTER FIELD pmda002 name="construct.a.pmda002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda003
            #add-point:ON ACTION controlp INFIELD pmda003 name="construct.c.pmda003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda003  #顯示到畫面上

            NEXT FIELD pmda003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda003
            #add-point:BEFORE FIELD pmda003 name="construct.b.pmda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda003
            
            #add-point:AFTER FIELD pmda003 name="construct.a.pmda003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdastus
            #add-point:BEFORE FIELD pmdastus name="construct.b.pmdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdastus
            
            #add-point:AFTER FIELD pmdastus name="construct.a.pmdastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdastus
            #add-point:ON ACTION controlp INFIELD pmdastus name="construct.c.pmdastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda004
            #add-point:BEFORE FIELD pmda004 name="construct.b.pmda004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda004
            
            #add-point:AFTER FIELD pmda004 name="construct.a.pmda004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda004
            #add-point:ON ACTION controlp INFIELD pmda004 name="construct.c.pmda004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmda010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda010
            #add-point:ON ACTION controlp INFIELD pmda010 name="construct.c.pmda010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oodb002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda010  #顯示到畫面上

            NEXT FIELD pmda010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda010
            #add-point:BEFORE FIELD pmda010 name="construct.b.pmda010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda010
            
            #add-point:AFTER FIELD pmda010 name="construct.a.pmda010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda011
            #add-point:BEFORE FIELD pmda011 name="construct.b.pmda011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda011
            
            #add-point:AFTER FIELD pmda011 name="construct.a.pmda011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda011
            #add-point:ON ACTION controlp INFIELD pmda011 name="construct.c.pmda011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda012
            #add-point:BEFORE FIELD pmda012 name="construct.b.pmda012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda012
            
            #add-point:AFTER FIELD pmda012 name="construct.a.pmda012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda012
            #add-point:ON ACTION controlp INFIELD pmda012 name="construct.c.pmda012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda005
            #add-point:ON ACTION controlp INFIELD pmda005 name="construct.c.pmda005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda005  #顯示到畫面上

            NEXT FIELD pmda005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda005
            #add-point:BEFORE FIELD pmda005 name="construct.b.pmda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda005
            
            #add-point:AFTER FIELD pmda005 name="construct.a.pmda005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda008
            #add-point:BEFORE FIELD pmda008 name="construct.b.pmda008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda008
            
            #add-point:AFTER FIELD pmda008 name="construct.a.pmda008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda008
            #add-point:ON ACTION controlp INFIELD pmda008 name="construct.c.pmda008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda009
            #add-point:BEFORE FIELD pmda009 name="construct.b.pmda009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda009
            
            #add-point:AFTER FIELD pmda009 name="construct.a.pmda009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda009
            #add-point:ON ACTION controlp INFIELD pmda009 name="construct.c.pmda009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmda007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda007
            #add-point:ON ACTION controlp INFIELD pmda007 name="construct.c.pmda007"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda007  #顯示到畫面上

            NEXT FIELD pmda007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda007
            #add-point:BEFORE FIELD pmda007 name="construct.b.pmda007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda007
            
            #add-point:AFTER FIELD pmda007 name="construct.a.pmda007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda021
            #add-point:ON ACTION controlp INFIELD pmda021 name="construct.c.pmda021"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = "263"  #170213-00038#3 mark
          #  CALL q_oocq002()                           #呼叫開窗  #170213-00038#3 mark
          CALL q_oocq002_263()   #170213-00038#3 add
            DISPLAY g_qryparam.return1 TO pmda021  #顯示到畫面上

            NEXT FIELD pmda021                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda021
            #add-point:BEFORE FIELD pmda021 name="construct.b.pmda021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda021
            
            #add-point:AFTER FIELD pmda021 name="construct.a.pmda021"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda020
            #add-point:BEFORE FIELD pmda020 name="construct.b.pmda020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda020
            
            #add-point:AFTER FIELD pmda020 name="construct.a.pmda020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda020
            #add-point:ON ACTION controlp INFIELD pmda020 name="construct.c.pmda020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda006
            #add-point:BEFORE FIELD pmda006 name="construct.b.pmda006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda006
            
            #add-point:AFTER FIELD pmda006 name="construct.a.pmda006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda006
            #add-point:ON ACTION controlp INFIELD pmda006 name="construct.c.pmda006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmda023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda023
            #add-point:ON ACTION controlp INFIELD pmda023 name="construct.c.pmda023"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = "317"  #170213-00038#3 mark
            #CALL q_oocq002()                           #呼叫開窗  #170213-00038#3 mark
            CALL q_oocq002_317()   #170213-00038#3 add
            DISPLAY g_qryparam.return1 TO pmda023  #顯示到畫面上
            NEXT FIELD pmda023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda023
            #add-point:BEFORE FIELD pmda023 name="construct.b.pmda023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda023
            
            #add-point:AFTER FIELD pmda023 name="construct.a.pmda023"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda022
            #add-point:BEFORE FIELD pmda022 name="construct.b.pmda022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda022
            
            #add-point:AFTER FIELD pmda022 name="construct.a.pmda022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda022
            #add-point:ON ACTION controlp INFIELD pmda022 name="construct.c.pmda022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmda024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda024
            #add-point:ON ACTION controlp INFIELD pmda024 name="construct.c.pmda024"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE 
            #ming 20150821 add --------------------(S) 
            LET g_qryparam.where = " oofb008 = '3' "     #出貨地址   
            #ming 20150821 add --------------------(E) 
            CALL q_oofb019_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda024  #顯示到畫面上
            NEXT FIELD pmda024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda024
            #add-point:BEFORE FIELD pmda024 name="construct.b.pmda024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda024
            
            #add-point:AFTER FIELD pmda024 name="construct.a.pmda024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda025
            #add-point:ON ACTION controlp INFIELD pmda025 name="construct.c.pmda025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE 
            #ming 20150821 add -----------------------------(S) 
            LET g_qryparam.where = " oofb008 = '5' "     #發票地址  
            #ming 20150821 add -----------------------------(E) 
            CALL q_oofb019_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda025  #顯示到畫面上
            NEXT FIELD pmda025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda025
            #add-point:BEFORE FIELD pmda025 name="construct.b.pmda025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda025
            
            #add-point:AFTER FIELD pmda025 name="construct.a.pmda025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdaownid
            #add-point:ON ACTION controlp INFIELD pmdaownid name="construct.c.pmdaownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdaownid  #顯示到畫面上

            NEXT FIELD pmdaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdaownid
            #add-point:BEFORE FIELD pmdaownid name="construct.b.pmdaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdaownid
            
            #add-point:AFTER FIELD pmdaownid name="construct.a.pmdaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdaowndp
            #add-point:ON ACTION controlp INFIELD pmdaowndp name="construct.c.pmdaowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdaowndp  #顯示到畫面上

            NEXT FIELD pmdaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdaowndp
            #add-point:BEFORE FIELD pmdaowndp name="construct.b.pmdaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdaowndp
            
            #add-point:AFTER FIELD pmdaowndp name="construct.a.pmdaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdacrtid
            #add-point:ON ACTION controlp INFIELD pmdacrtid name="construct.c.pmdacrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdacrtid  #顯示到畫面上

            NEXT FIELD pmdacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdacrtid
            #add-point:BEFORE FIELD pmdacrtid name="construct.b.pmdacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdacrtid
            
            #add-point:AFTER FIELD pmdacrtid name="construct.a.pmdacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdacrtdp
            #add-point:ON ACTION controlp INFIELD pmdacrtdp name="construct.c.pmdacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdacrtdp  #顯示到畫面上

            NEXT FIELD pmdacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdacrtdp
            #add-point:BEFORE FIELD pmdacrtdp name="construct.b.pmdacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdacrtdp
            
            #add-point:AFTER FIELD pmdacrtdp name="construct.a.pmdacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdacrtdt
            #add-point:BEFORE FIELD pmdacrtdt name="construct.b.pmdacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdamodid
            #add-point:ON ACTION controlp INFIELD pmdamodid name="construct.c.pmdamodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdamodid  #顯示到畫面上

            NEXT FIELD pmdamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdamodid
            #add-point:BEFORE FIELD pmdamodid name="construct.b.pmdamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdamodid
            
            #add-point:AFTER FIELD pmdamodid name="construct.a.pmdamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdamoddt
            #add-point:BEFORE FIELD pmdamoddt name="construct.b.pmdamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdacnfid
            #add-point:ON ACTION controlp INFIELD pmdacnfid name="construct.c.pmdacnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdacnfid  #顯示到畫面上

            NEXT FIELD pmdacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdacnfid
            #add-point:BEFORE FIELD pmdacnfid name="construct.b.pmdacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdacnfid
            
            #add-point:AFTER FIELD pmdacnfid name="construct.a.pmdacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdacnfdt
            #add-point:BEFORE FIELD pmdacnfdt name="construct.b.pmdacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pmdbsite,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb052,pmdb004,pmdb005,pmdb007, 
          pmdb006,pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050,pmdb032,pmdb051,pmdb033, 
          pmdb049,ooff013,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb034, 
          pmdb035,pmdb036,pmdb053,pmdb053_desc,pmdb037,pmdb038,pmdb039,pmdb054,pmdb041,pmdb042,pmdb043, 
          pmdb044,pmdb045,pmdb046
           FROM s_detail1[1].pmdbsite,s_detail1[1].pmdbseq,s_detail1[1].pmdb001,s_detail1[1].pmdb002, 
               s_detail1[1].pmdb003,s_detail1[1].pmdb052,s_detail1[1].pmdb004,s_detail1[1].pmdb005,s_detail1[1].pmdb007, 
               s_detail1[1].pmdb006,s_detail1[1].pmdb009,s_detail1[1].pmdb008,s_detail1[1].pmdb011,s_detail1[1].pmdb010, 
               s_detail1[1].pmdb030,s_detail1[1].pmdb048,s_detail1[1].pmdb031,s_detail1[1].pmdb050,s_detail1[1].pmdb032, 
               s_detail1[1].pmdb051,s_detail1[1].pmdb033,s_detail1[1].pmdb049,s_detail1[1].ooff013,s_detail2[1].pmdb012, 
               s_detail2[1].pmdb014,s_detail2[1].pmdb015,s_detail2[1].pmdb016,s_detail2[1].pmdb017,s_detail2[1].pmdb018, 
               s_detail2[1].pmdb019,s_detail2[1].pmdb020,s_detail2[1].pmdb021,s_detail2[1].pmdb034,s_detail2[1].pmdb035, 
               s_detail2[1].pmdb036,s_detail2[1].pmdb053,s_detail2[1].pmdb053_desc,s_detail2[1].pmdb037, 
               s_detail2[1].pmdb038,s_detail2[1].pmdb039,s_detail2[1].pmdb054,s_detail2[1].pmdb041,s_detail2[1].pmdb042, 
               s_detail2[1].pmdb043,s_detail2[1].pmdb044,s_detail2[1].pmdb045,s_detail2[1].pmdb046
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdbsite
            #add-point:BEFORE FIELD pmdbsite name="construct.b.page1.pmdbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdbsite
            
            #add-point:AFTER FIELD pmdbsite name="construct.a.page1.pmdbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdbsite
            #add-point:ON ACTION controlp INFIELD pmdbsite name="construct.c.page1.pmdbsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdbseq
            #add-point:BEFORE FIELD pmdbseq name="construct.b.page1.pmdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdbseq
            
            #add-point:AFTER FIELD pmdbseq name="construct.a.page1.pmdbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdbseq
            #add-point:ON ACTION controlp INFIELD pmdbseq name="construct.c.page1.pmdbseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb001
            #add-point:BEFORE FIELD pmdb001 name="construct.b.page1.pmdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb001
            
            #add-point:AFTER FIELD pmdb001 name="construct.a.page1.pmdb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb001
            #add-point:ON ACTION controlp INFIELD pmdb001 name="construct.c.page1.pmdb001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb002
            #add-point:BEFORE FIELD pmdb002 name="construct.b.page1.pmdb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb002
            
            #add-point:AFTER FIELD pmdb002 name="construct.a.page1.pmdb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb002
            #add-point:ON ACTION controlp INFIELD pmdb002 name="construct.c.page1.pmdb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb003
            #add-point:BEFORE FIELD pmdb003 name="construct.b.page1.pmdb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb003
            
            #add-point:AFTER FIELD pmdb003 name="construct.a.page1.pmdb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb003
            #add-point:ON ACTION controlp INFIELD pmdb003 name="construct.c.page1.pmdb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb052
            #add-point:BEFORE FIELD pmdb052 name="construct.b.page1.pmdb052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb052
            
            #add-point:AFTER FIELD pmdb052 name="construct.a.page1.pmdb052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb052
            #add-point:ON ACTION controlp INFIELD pmdb052 name="construct.c.page1.pmdb052"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb004
            #add-point:ON ACTION controlp INFIELD pmdb004 name="construct.c.page1.pmdb004"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		    	LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "1=1 "
            
            LET l_sql = ''
            CALL s_control_get_sql("imaa001",'6','3',g_user,g_dept) RETURNING l_success,l_sql
            IF l_success THEN
               IF cl_null(l_sql) THEN
                  LET l_sql = " 1=1"
               END IF
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
            END IF
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb004  #顯示到畫面上

            NEXT FIELD pmdb004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb004
            #add-point:BEFORE FIELD pmdb004 name="construct.b.page1.pmdb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb004
            
            #add-point:AFTER FIELD pmdb004 name="construct.a.page1.pmdb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb005
            #add-point:BEFORE FIELD pmdb005 name="construct.b.page1.pmdb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb005
            
            #add-point:AFTER FIELD pmdb005 name="construct.a.page1.pmdb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb005
            #add-point:ON ACTION controlp INFIELD pmdb005 name="construct.c.page1.pmdb005"
            #170213-00038#3  2017/02/17  By 08734 add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmdb005()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb005  #顯示到畫面上
            NEXT FIELD pmdb005
            #170213-00038#3  2017/02/17  By 08734 add(E)
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb007
            #add-point:ON ACTION controlp INFIELD pmdb007 name="construct.c.page1.pmdb007"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb007  #顯示到畫面上

            NEXT FIELD pmdb007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb007
            #add-point:BEFORE FIELD pmdb007 name="construct.b.page1.pmdb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb007
            
            #add-point:AFTER FIELD pmdb007 name="construct.a.page1.pmdb007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb006
            #add-point:BEFORE FIELD pmdb006 name="construct.b.page1.pmdb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb006
            
            #add-point:AFTER FIELD pmdb006 name="construct.a.page1.pmdb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb006
            #add-point:ON ACTION controlp INFIELD pmdb006 name="construct.c.page1.pmdb006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb009
            #add-point:ON ACTION controlp INFIELD pmdb009 name="construct.c.page1.pmdb009"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb009  #顯示到畫面上

            NEXT FIELD pmdb009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb009
            #add-point:BEFORE FIELD pmdb009 name="construct.b.page1.pmdb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb009
            
            #add-point:AFTER FIELD pmdb009 name="construct.a.page1.pmdb009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb008
            #add-point:BEFORE FIELD pmdb008 name="construct.b.page1.pmdb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb008
            
            #add-point:AFTER FIELD pmdb008 name="construct.a.page1.pmdb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb008
            #add-point:ON ACTION controlp INFIELD pmdb008 name="construct.c.page1.pmdb008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb011
            #add-point:ON ACTION controlp INFIELD pmdb011 name="construct.c.page1.pmdb011"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb011  #顯示到畫面上

            NEXT FIELD pmdb011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb011
            #add-point:BEFORE FIELD pmdb011 name="construct.b.page1.pmdb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb011
            
            #add-point:AFTER FIELD pmdb011 name="construct.a.page1.pmdb011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb010
            #add-point:BEFORE FIELD pmdb010 name="construct.b.page1.pmdb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb010
            
            #add-point:AFTER FIELD pmdb010 name="construct.a.page1.pmdb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb010
            #add-point:ON ACTION controlp INFIELD pmdb010 name="construct.c.page1.pmdb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb030
            #add-point:BEFORE FIELD pmdb030 name="construct.b.page1.pmdb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb030
            
            #add-point:AFTER FIELD pmdb030 name="construct.a.page1.pmdb030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb030
            #add-point:ON ACTION controlp INFIELD pmdb030 name="construct.c.page1.pmdb030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb048
            #add-point:ON ACTION controlp INFIELD pmdb048 name="construct.c.page1.pmdb048"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = "274"  #170213-00038#3 mark
         #   CALL q_oocq002()                           #呼叫開窗  #170213-00038#3 mark
            CALL q_oocq002_274()  #170213-00038#3 add
            DISPLAY g_qryparam.return1 TO pmdb048  #顯示到畫面上

            NEXT FIELD pmdb048                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb048
            #add-point:BEFORE FIELD pmdb048 name="construct.b.page1.pmdb048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb048
            
            #add-point:AFTER FIELD pmdb048 name="construct.a.page1.pmdb048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb031
            #add-point:ON ACTION controlp INFIELD pmdb031 name="construct.c.page1.pmdb031"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = g_acc  #170213-00038#3 mark 
            #CALL q_oocq002()                           #呼叫開窗 #170213-00038#3 mark
            CALL q_oocq002_265()  #170213-00038#3 add
            DISPLAY g_qryparam.return1 TO pmdb031  #顯示到畫面上

            NEXT FIELD pmdb031                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb031
            #add-point:BEFORE FIELD pmdb031 name="construct.b.page1.pmdb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb031
            
            #add-point:AFTER FIELD pmdb031 name="construct.a.page1.pmdb031"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb050
            #add-point:BEFORE FIELD pmdb050 name="construct.b.page1.pmdb050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb050
            
            #add-point:AFTER FIELD pmdb050 name="construct.a.page1.pmdb050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb050
            #add-point:ON ACTION controlp INFIELD pmdb050 name="construct.c.page1.pmdb050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb032
            #add-point:BEFORE FIELD pmdb032 name="construct.b.page1.pmdb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb032
            
            #add-point:AFTER FIELD pmdb032 name="construct.a.page1.pmdb032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb032
            #add-point:ON ACTION controlp INFIELD pmdb032 name="construct.c.page1.pmdb032"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb051
            #add-point:ON ACTION controlp INFIELD pmdb051 name="construct.c.page1.pmdb051"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = "('258','317')"
            CALL q_oocq002_23()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb051  #顯示到畫面上

            NEXT FIELD pmdb051                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb051
            #add-point:BEFORE FIELD pmdb051 name="construct.b.page1.pmdb051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb051
            
            #add-point:AFTER FIELD pmdb051 name="construct.a.page1.pmdb051"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb033
            #add-point:BEFORE FIELD pmdb033 name="construct.b.page1.pmdb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb033
            
            #add-point:AFTER FIELD pmdb033 name="construct.a.page1.pmdb033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb033
            #add-point:ON ACTION controlp INFIELD pmdb033 name="construct.c.page1.pmdb033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb049
            #add-point:BEFORE FIELD pmdb049 name="construct.b.page1.pmdb049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb049
            
            #add-point:AFTER FIELD pmdb049 name="construct.a.page1.pmdb049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb049
            #add-point:ON ACTION controlp INFIELD pmdb049 name="construct.c.page1.pmdb049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="construct.b.page1.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="construct.a.page1.ooff013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooff013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="construct.c.page1.ooff013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pmdb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb012
            #add-point:ON ACTION controlp INFIELD pmdb012 name="construct.c.page2.pmdb012"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaf001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb012  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO imaal003 #品名 

            NEXT FIELD pmdb012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb012
            #add-point:BEFORE FIELD pmdb012 name="construct.b.page2.pmdb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb012
            
            #add-point:AFTER FIELD pmdb012 name="construct.a.page2.pmdb012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb014
            #add-point:BEFORE FIELD pmdb014 name="construct.b.page2.pmdb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb014
            
            #add-point:AFTER FIELD pmdb014 name="construct.a.page2.pmdb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb014
            #add-point:ON ACTION controlp INFIELD pmdb014 name="construct.c.page2.pmdb014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pmdb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb015
            #add-point:ON ACTION controlp INFIELD pmdb015 name="construct.c.page2.pmdb015"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb015  #顯示到畫面上

            NEXT FIELD pmdb015                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb015
            #add-point:BEFORE FIELD pmdb015 name="construct.b.page2.pmdb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb015
            
            #add-point:AFTER FIELD pmdb015 name="construct.a.page2.pmdb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb016
            #add-point:ON ACTION controlp INFIELD pmdb016 name="construct.c.page2.pmdb016"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooib002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb016  #顯示到畫面上

            NEXT FIELD pmdb016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb016
            #add-point:BEFORE FIELD pmdb016 name="construct.b.page2.pmdb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb016
            
            #add-point:AFTER FIELD pmdb016 name="construct.a.page2.pmdb016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb017
            #add-point:ON ACTION controlp INFIELD pmdb017 name="construct.c.page2.pmdb017"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = "238"   #170213-00038#3 mark
            #CALL q_oocq002()                           #呼叫開窗   #170213-00038#3 mark
            CALL q_oocq002_238()  #170213-00038#3 add
            DISPLAY g_qryparam.return1 TO pmdb017  #顯示到畫面上

            NEXT FIELD pmdb017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb017
            #add-point:BEFORE FIELD pmdb017 name="construct.b.page2.pmdb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb017
            
            #add-point:AFTER FIELD pmdb017 name="construct.a.page2.pmdb017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb018
            #add-point:BEFORE FIELD pmdb018 name="construct.b.page2.pmdb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb018
            
            #add-point:AFTER FIELD pmdb018 name="construct.a.page2.pmdb018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb018
            #add-point:ON ACTION controlp INFIELD pmdb018 name="construct.c.page2.pmdb018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb019
            #add-point:BEFORE FIELD pmdb019 name="construct.b.page2.pmdb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb019
            
            #add-point:AFTER FIELD pmdb019 name="construct.a.page2.pmdb019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb019
            #add-point:ON ACTION controlp INFIELD pmdb019 name="construct.c.page2.pmdb019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb020
            #add-point:BEFORE FIELD pmdb020 name="construct.b.page2.pmdb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb020
            
            #add-point:AFTER FIELD pmdb020 name="construct.a.page2.pmdb020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb020
            #add-point:ON ACTION controlp INFIELD pmdb020 name="construct.c.page2.pmdb020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb021
            #add-point:BEFORE FIELD pmdb021 name="construct.b.page2.pmdb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb021
            
            #add-point:AFTER FIELD pmdb021 name="construct.a.page2.pmdb021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb021
            #add-point:ON ACTION controlp INFIELD pmdb021 name="construct.c.page2.pmdb021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pmdb034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb034
            #add-point:ON ACTION controlp INFIELD pmdb034 name="construct.c.page2.pmdb034"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb034  #顯示到畫面上
            NEXT FIELD pmdb034                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb034
            #add-point:BEFORE FIELD pmdb034 name="construct.b.page2.pmdb034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb034
            
            #add-point:AFTER FIELD pmdb034 name="construct.a.page2.pmdb034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb035
            #add-point:ON ACTION controlp INFIELD pmdb035 name="construct.c.page2.pmdb035"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb035  #顯示到畫面上
            NEXT FIELD pmdb035                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb035
            #add-point:BEFORE FIELD pmdb035 name="construct.b.page2.pmdb035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb035
            
            #add-point:AFTER FIELD pmdb035 name="construct.a.page2.pmdb035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb036
            #add-point:ON ACTION controlp INFIELD pmdb036 name="construct.c.page2.pmdb036"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbm002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb036  #顯示到畫面上
            NEXT FIELD pmdb036                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb036
            #add-point:BEFORE FIELD pmdb036 name="construct.b.page2.pmdb036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb036
            
            #add-point:AFTER FIELD pmdb036 name="construct.a.page2.pmdb036"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb053
            #add-point:BEFORE FIELD pmdb053 name="construct.b.page2.pmdb053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb053
            
            #add-point:AFTER FIELD pmdb053 name="construct.a.page2.pmdb053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb053
            #add-point:ON ACTION controlp INFIELD pmdb053 name="construct.c.page2.pmdb053"
            #170213-00038#3  2017/02/17  By 08734 add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgbd007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb053  #顯示到畫面上
            NEXT FIELD pmdb053
            #170213-00038#3  2017/02/17  By 08734 add(E)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb053_desc
            #add-point:BEFORE FIELD pmdb053_desc name="construct.b.page2.pmdb053_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb053_desc
            
            #add-point:AFTER FIELD pmdb053_desc name="construct.a.page2.pmdb053_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb053_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb053_desc
            #add-point:ON ACTION controlp INFIELD pmdb053_desc name="construct.c.page2.pmdb053_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pmdb037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb037
            #add-point:ON ACTION controlp INFIELD pmdb037 name="construct.c.page2.pmdb037"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161019-00017#2
            CALL q_ooef001_1()   #161019-00017#2
            DISPLAY g_qryparam.return1 TO pmdb037  #顯示到畫面上

            NEXT FIELD pmdb037                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb037
            #add-point:BEFORE FIELD pmdb037 name="construct.b.page2.pmdb037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb037
            
            #add-point:AFTER FIELD pmdb037 name="construct.a.page2.pmdb037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb038
            #add-point:ON ACTION controlp INFIELD pmdb038 name="construct.c.page2.pmdb038"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb038  #顯示到畫面上

            NEXT FIELD pmdb038                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb038
            #add-point:BEFORE FIELD pmdb038 name="construct.b.page2.pmdb038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb038
            
            #add-point:AFTER FIELD pmdb038 name="construct.a.page2.pmdb038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb039
            #add-point:ON ACTION controlp INFIELD pmdb039 name="construct.c.page2.pmdb039"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inab002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb039  #顯示到畫面上

            NEXT FIELD pmdb039                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb039
            #add-point:BEFORE FIELD pmdb039 name="construct.b.page2.pmdb039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb039
            
            #add-point:AFTER FIELD pmdb039 name="construct.a.page2.pmdb039"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb054
            #add-point:BEFORE FIELD pmdb054 name="construct.b.page2.pmdb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb054
            
            #add-point:AFTER FIELD pmdb054 name="construct.a.page2.pmdb054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb054
            #add-point:ON ACTION controlp INFIELD pmdb054 name="construct.c.page2.pmdb054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb041
            #add-point:BEFORE FIELD pmdb041 name="construct.b.page2.pmdb041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb041
            
            #add-point:AFTER FIELD pmdb041 name="construct.a.page2.pmdb041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb041
            #add-point:ON ACTION controlp INFIELD pmdb041 name="construct.c.page2.pmdb041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb042
            #add-point:BEFORE FIELD pmdb042 name="construct.b.page2.pmdb042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb042
            
            #add-point:AFTER FIELD pmdb042 name="construct.a.page2.pmdb042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb042
            #add-point:ON ACTION controlp INFIELD pmdb042 name="construct.c.page2.pmdb042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb043
            #add-point:BEFORE FIELD pmdb043 name="construct.b.page2.pmdb043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb043
            
            #add-point:AFTER FIELD pmdb043 name="construct.a.page2.pmdb043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb043
            #add-point:ON ACTION controlp INFIELD pmdb043 name="construct.c.page2.pmdb043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb044
            #add-point:BEFORE FIELD pmdb044 name="construct.b.page2.pmdb044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb044
            
            #add-point:AFTER FIELD pmdb044 name="construct.a.page2.pmdb044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb044
            #add-point:ON ACTION controlp INFIELD pmdb044 name="construct.c.page2.pmdb044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb045
            #add-point:BEFORE FIELD pmdb045 name="construct.b.page2.pmdb045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb045
            
            #add-point:AFTER FIELD pmdb045 name="construct.a.page2.pmdb045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.pmdb045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb045
            #add-point:ON ACTION controlp INFIELD pmdb045 name="construct.c.page2.pmdb045"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.pmdb046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb046
            #add-point:ON ACTION controlp INFIELD pmdb046 name="construct.c.page2.pmdb046"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb046  #顯示到畫面上

            NEXT FIELD pmdb046                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb046
            #add-point:BEFORE FIELD pmdb046 name="construct.b.page2.pmdb046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb046
            
            #add-point:AFTER FIELD pmdb046 name="construct.a.page2.pmdb046"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      SUBDIALOG aoo_aooi360_01.aooi360_01_construct   #备注单身  #161031-00025#8
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         LET g_pmdb_d[1].pmdbseq = ""
         DISPLAY ARRAY g_pmdb_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         LET g_pmdb2_d[1].pmdbseq = ""
         DISPLAY ARRAY g_pmdb2_d TO s_detail2.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
                  WHEN la_wc[li_idx].tableid = "pmda_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pmdb_t" 
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
 
{<section id="apmt400.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apmt400_filter()
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
      CONSTRUCT g_wc_filter ON pmdadocno,pmdadocdt,pmda001,pmda002,pmda003
                          FROM s_browse[1].b_pmdadocno,s_browse[1].b_pmdadocdt,s_browse[1].b_pmda001, 
                              s_browse[1].b_pmda002,s_browse[1].b_pmda003
 
         BEFORE CONSTRUCT
               DISPLAY apmt400_filter_parser('pmdadocno') TO s_browse[1].b_pmdadocno
            DISPLAY apmt400_filter_parser('pmdadocdt') TO s_browse[1].b_pmdadocdt
            DISPLAY apmt400_filter_parser('pmda001') TO s_browse[1].b_pmda001
            DISPLAY apmt400_filter_parser('pmda002') TO s_browse[1].b_pmda002
            DISPLAY apmt400_filter_parser('pmda003') TO s_browse[1].b_pmda003
      
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
 
      CALL apmt400_filter_show('pmdadocno')
   CALL apmt400_filter_show('pmdadocdt')
   CALL apmt400_filter_show('pmda001')
   CALL apmt400_filter_show('pmda002')
   CALL apmt400_filter_show('pmda003')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apmt400_filter_parser(ps_field)
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
 
{<section id="apmt400.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apmt400_filter_show(ps_field)
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
   LET ls_condition = apmt400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmt400_query()
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
   CALL g_pmdb_d.clear()
   CALL g_pmdb2_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#8
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apmt400_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmt400_browser_fill("")
      CALL apmt400_fetch("")
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
      CALL apmt400_filter_show('pmdadocno')
   CALL apmt400_filter_show('pmdadocdt')
   CALL apmt400_filter_show('pmda001')
   CALL apmt400_filter_show('pmda002')
   CALL apmt400_filter_show('pmda003')
   CALL apmt400_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apmt400_fetch("F") 
      #顯示單身筆數
      CALL apmt400_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmt400_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_flag     LIKE type_t.num5 
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
   
   LET g_pmda_m.pmdadocno = g_browser[g_current_idx].b_pmdadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmt400_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmdadocno, 
       g_pmda_m.pmda001,g_pmda_m.pmdadocdt,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004, 
       g_pmda_m.pmda010,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008,g_pmda_m.pmda009, 
       g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda022, 
       g_pmda_m.pmda024,g_pmda_m.pmda025,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp, 
       g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda005_desc,g_pmda_m.pmda007_desc,g_pmda_m.pmda021_desc, 
       g_pmda_m.pmda023_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid_desc, 
       g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc
   
   #遮罩相關處理
   LET g_pmda_m_mask_o.* =  g_pmda_m.*
   CALL apmt400_pmda_t_mask()
   LET g_pmda_m_mask_n.* =  g_pmda_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt400_set_act_visible()   
   CALL apmt400_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #判斷當下的營運據點是否在控制組限制的營運據點範圍內，若不在限制內則不允許新增請購單
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   
   CALL s_control_chk_group('5','3',g_user,g_dept,g_site,'','','','') RETURNING l_success,l_flag
   IF l_success THEN   #處理狀態為FALSE，則隱藏新增按鈕
      IF NOT l_flag THEN  #不在控制組範圍內
         CALL cl_set_act_visible("insert", FALSE)
      END IF
   ELSE
      CALL cl_set_act_visible("insert", FALSE)
   END IF
   
   IF g_pmda_m.pmdastus NOT MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   
   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
       CALL cl_set_act_visible("bpm_status",FALSE)
   END IF

   #end add-point
   
   #保存單頭舊值
   LET g_pmda_m_t.* = g_pmda_m.*
   LET g_pmda_m_o.* = g_pmda_m.*
   
   LET g_data_owner = g_pmda_m.pmdaownid      
   LET g_data_dept  = g_pmda_m.pmdaowndp
   
   #重新顯示   
   CALL apmt400_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmt400_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pmdb_d.clear()   
   CALL g_pmdb2_d.clear()  
 
 
   INITIALIZE g_pmda_m.* TO NULL             #DEFAULT 設定
   
   LET g_pmdadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#8
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmda_m.pmdaownid = g_user
      LET g_pmda_m.pmdaowndp = g_dept
      LET g_pmda_m.pmdacrtid = g_user
      LET g_pmda_m.pmdacrtdp = g_dept 
      LET g_pmda_m.pmdacrtdt = cl_get_current()
      LET g_pmda_m.pmdamodid = g_user
      LET g_pmda_m.pmdamoddt = cl_get_current()
      LET g_pmda_m.pmdastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmda_m.pmda001 = "0"
      LET g_pmda_m.pmdastus = "N"
      LET g_pmda_m.pmda004 = "N"
      LET g_pmda_m.pmda012 = "N"
      LET g_pmda_m.pmda008 = "0"
      LET g_pmda_m.pmda009 = "0"
      LET g_pmda_m.pmda020 = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_pmda_m.pmdasite = g_site
      
      LET g_pmda_m.pmdadocdt = g_today
      LET g_pmda_m.pmda002 = g_user
      LET g_pmda_m.pmda003 = g_dept
      CALL apmt400_pmda002_ref(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
      DISPLAY BY NAME g_pmda_m.pmda002_desc
      
      CALL apmt400_pmda003_ref(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
      DISPLAY BY NAME g_pmda_m.pmda003_desc
      
      LET g_pmda_m.pmda007 = g_pmda_m.pmda003
      CALL apmt400_pmda003_ref(g_pmda_m.pmda007) RETURNING g_pmda_m.pmda007_desc
      DISPLAY BY NAME g_pmda_m.pmda007_desc
      
      INITIALIZE g_pmda_m_t.* TO NULL
      LET g_pmda_m_t.* = g_pmda_m.*
      #161031-00025#8---s
      LET g_ooff001_d = '6'   #6.單據單頭備註
      LET g_ooff002_d = g_prog
      LET g_ooff003_d = ''    #单号
      LET g_ooff004_d = 0     #项次
      LET g_ooff005_d = ' '
      LET g_ooff006_d = ' '
      LET g_ooff007_d = ' '
      LET g_ooff008_d = ' '
      LET g_ooff009_d = ' '
      LET g_ooff010_d = ' '
      LET g_ooff011_d = ' '
      #161031-00025#8---e
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_pmda_m_t.* = g_pmda_m.*
      LET g_pmda_m_o.* = g_pmda_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmda_m.pmdastus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "TJ"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/committed.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL apmt400_input("a")
      
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
         INITIALIZE g_pmda_m.* TO NULL
         INITIALIZE g_pmdb_d TO NULL
         INITIALIZE g_pmdb2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apmt400_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pmdb_d.clear()
      #CALL g_pmdb2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt400_set_act_visible()   
   CALL apmt400_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmdaent = " ||g_enterprise|| " AND",
                      " pmdadocno = '", g_pmda_m.pmdadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apmt400_cl
   
   CALL apmt400_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmt400_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmdadocno, 
       g_pmda_m.pmda001,g_pmda_m.pmdadocdt,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004, 
       g_pmda_m.pmda010,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008,g_pmda_m.pmda009, 
       g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda022, 
       g_pmda_m.pmda024,g_pmda_m.pmda025,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp, 
       g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda005_desc,g_pmda_m.pmda007_desc,g_pmda_m.pmda021_desc, 
       g_pmda_m.pmda023_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid_desc, 
       g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc
   
   
   #遮罩相關處理
   LET g_pmda_m_mask_o.* =  g_pmda_m.*
   CALL apmt400_pmda_t_mask()
   LET g_pmda_m_mask_n.* =  g_pmda_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocno_desc,g_pmda_m.pmdadocdt, 
       g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmda003,g_pmda_m.pmda003_desc,g_pmda_m.pmdastus, 
       g_pmda_m.pmda004,g_pmda_m.pmda010,g_pmda_m.pmda010_desc,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005, 
       g_pmda_m.pmda005_desc,g_pmda_m.ooan005,g_pmda_m.pmda008,g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda007_desc, 
       g_pmda_m.pmda021,g_pmda_m.pmda021_desc,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda023_desc, 
       g_pmda_m.pmda022,g_pmda_m.pmda024,g_pmda_m.pmda024_desc,g_pmda_m.oofb017,g_pmda_m.pmda025,g_pmda_m.pmda025_desc, 
       g_pmda_m.oofb017_1,g_pmda_m.pmdaownid,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp,g_pmda_m.pmdaowndp_desc, 
       g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdacrtdt, 
       g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfid_desc, 
       g_pmda_m.pmdacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pmda_m.pmdaownid      
   LET g_data_dept  = g_pmda_m.pmdaowndp
   
   #功能已完成,通報訊息中心
   CALL apmt400_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmt400_modify()
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
   LET g_pmda_m_t.* = g_pmda_m.*
   LET g_pmda_m_o.* = g_pmda_m.*
   
   IF g_pmda_m.pmdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
   CALL s_transaction_begin()
   
   OPEN apmt400_cl USING g_enterprise,g_pmda_m.pmdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt400_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt400_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmdadocno, 
       g_pmda_m.pmda001,g_pmda_m.pmdadocdt,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004, 
       g_pmda_m.pmda010,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008,g_pmda_m.pmda009, 
       g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda022, 
       g_pmda_m.pmda024,g_pmda_m.pmda025,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp, 
       g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda005_desc,g_pmda_m.pmda007_desc,g_pmda_m.pmda021_desc, 
       g_pmda_m.pmda023_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid_desc, 
       g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc
   
   #檢查是否允許此動作
   IF NOT apmt400_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmda_m_mask_o.* =  g_pmda_m.*
   CALL apmt400_pmda_t_mask()
   LET g_pmda_m_mask_n.* =  g_pmda_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL apmt400_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_pmda_m.pmdamodid = g_user 
LET g_pmda_m.pmdamoddt = cl_get_current()
LET g_pmda_m.pmdamodid_desc = cl_get_username(g_pmda_m.pmdamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_pmda_m.pmdastus MATCHES '[DR]' THEN 
         LET g_pmda_m.pmdastus = "N"
      END IF

      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apmt400_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE pmda_t SET (pmdamodid,pmdamoddt) = (g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt)
          WHERE pmdaent = g_enterprise AND pmdadocno = g_pmdadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_pmda_m.* = g_pmda_m_t.*
            CALL apmt400_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_pmda_m.pmdadocno != g_pmda_m_t.pmdadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE pmdb_t SET pmdbdocno = g_pmda_m.pmdadocno
 
          WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m_t.pmdadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmdb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdb_t:",SQLERRMESSAGE 
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
   CALL apmt400_set_act_visible()   
   CALL apmt400_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmdaent = " ||g_enterprise|| " AND",
                      " pmdadocno = '", g_pmda_m.pmdadocno, "' "
 
   #填到對應位置
   CALL apmt400_browser_fill("")
 
   CLOSE apmt400_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt400_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apmt400.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmt400_input(p_cmd)
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
   DEFINE  l_ooef004       LIKE ooef_t.ooef004
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_ooef016       LIKE ooef_t.ooef016
   DEFINE  l_rate          LIKE inaj_t.inaj014
   DEFINE  l_imaf171       LIKE imaf_t.imaf171
   DEFINE  l_imaf172       LIKE imaf_t.imaf172
   DEFINE  l_imaf173       LIKE imaf_t.imaf173
   DEFINE  l_imaf174       LIKE imaf_t.imaf174
   DEFINE  l_imaf175       LIKE imaf_t.imaf175
   DEFINE  l_time1         LIKE imaf_t.imaf171
   DEFINE  l_time2         LIKE imaf_t.imaf171
   DEFINE  l_ooba002       LIKE ooba_t.ooba002
   DEFINE  l_ooba015       LIKE ooba_t.ooba015
   DEFINE  l_ooba014       LIKE ooba_t.ooba014
   DEFINE  l_pmda008       LIKE pmda_t.pmda008
   DEFINE  l_pmda009       LIKE pmda_t.pmda009
   DEFINE  l_flag          LIKE type_t.num5
   DEFINE  l_sql           STRING
   DEFINE  l_sql1          STRING
   DEFINE  l_sql2          STRING
   DEFINE  l_oodb011       LIKE oodb_t.oodb011
   DEFINE  l_xrcd104       LIKE xrcd_t.xrcd104
   DEFINE  l_xrcd113       LIKE xrcd_t.xrcd113
   DEFINE  l_xrcd114       LIKE xrcd_t.xrcd114
   DEFINE  l_xrcd115       LIKE xrcd_t.xrcd115
   DEFINE  l_inam          DYNAMIC ARRAY OF RECORD   #記錄產品特徵
              inam001      LIKE inam_t.inam001,
              inam002      LIKE inam_t.inam002,
              inam004      LIKE inam_t.inam004
                        END RECORD
   DEFINE l_imaa005        LIKE imaa_t.imaa005
   #161124-00048#9 mod-S
#   DEFINE l_pmdb           RECORD LIKE pmdb_t.* 
   DEFINE l_pmdb RECORD  #請購單明細檔
          pmdbent LIKE pmdb_t.pmdbent, #企业编号
          pmdbsite LIKE pmdb_t.pmdbsite, #营运据点
          pmdbdocno LIKE pmdb_t.pmdbdocno, #请购单号
          pmdbseq LIKE pmdb_t.pmdbseq, #项次
          pmdb001 LIKE pmdb_t.pmdb001, #来源单号
          pmdb002 LIKE pmdb_t.pmdb002, #来源项次
          pmdb003 LIKE pmdb_t.pmdb003, #来源项序
          pmdb004 LIKE pmdb_t.pmdb004, #料件编号
          pmdb005 LIKE pmdb_t.pmdb005, #产品特征
          pmdb006 LIKE pmdb_t.pmdb006, #需求数量
          pmdb007 LIKE pmdb_t.pmdb007, #单位
          pmdb008 LIKE pmdb_t.pmdb008, #参考数量
          pmdb009 LIKE pmdb_t.pmdb009, #参考单位
          pmdb010 LIKE pmdb_t.pmdb010, #计价数量
          pmdb011 LIKE pmdb_t.pmdb011, #计价单位
          pmdb012 LIKE pmdb_t.pmdb012, #包装容器
          pmdb014 LIKE pmdb_t.pmdb014, #供应商选择
          pmdb015 LIKE pmdb_t.pmdb015, #供应商编号
          pmdb016 LIKE pmdb_t.pmdb016, #付款条件
          pmdb017 LIKE pmdb_t.pmdb017, #交易条件
          pmdb018 LIKE pmdb_t.pmdb018, #税率
          pmdb019 LIKE pmdb_t.pmdb019, #参考单价
          pmdb020 LIKE pmdb_t.pmdb020, #参考税前金额
          pmdb021 LIKE pmdb_t.pmdb021, #参考含税金额
          pmdb030 LIKE pmdb_t.pmdb030, #需求日期
          pmdb031 LIKE pmdb_t.pmdb031, #理由码
          pmdb032 LIKE pmdb_t.pmdb032, #行状态
          pmdb033 LIKE pmdb_t.pmdb033, #紧急度
          pmdb034 LIKE pmdb_t.pmdb034, #项目编号
          pmdb035 LIKE pmdb_t.pmdb035, #WBS
          pmdb036 LIKE pmdb_t.pmdb036, #活动编号
          pmdb037 LIKE pmdb_t.pmdb037, #收货据点
          pmdb038 LIKE pmdb_t.pmdb038, #收货库位
          pmdb039 LIKE pmdb_t.pmdb039, #收货储位
          pmdb040 LIKE pmdb_t.pmdb040, #no use
          pmdb041 LIKE pmdb_t.pmdb041, #允许部份交货
          pmdb042 LIKE pmdb_t.pmdb042, #允许提前交货
          pmdb043 LIKE pmdb_t.pmdb043, #保税
          pmdb044 LIKE pmdb_t.pmdb044, #纳入APS
          pmdb045 LIKE pmdb_t.pmdb045, #交期冻结否
          pmdb046 LIKE pmdb_t.pmdb046, #费用部门
          pmdb048 LIKE pmdb_t.pmdb048, #收货时段
          pmdb049 LIKE pmdb_t.pmdb049, #已转采购量
          pmdb050 LIKE pmdb_t.pmdb050, #备注
          pmdb051 LIKE pmdb_t.pmdb051, #结案/留置理由码
          pmdb200 LIKE pmdb_t.pmdb200, #商品条码
          pmdb201 LIKE pmdb_t.pmdb201, #包装单位
          pmdb202 LIKE pmdb_t.pmdb202, #件装数
          pmdb203 LIKE pmdb_t.pmdb203, #配送中心
          pmdb204 LIKE pmdb_t.pmdb204, #配送仓库
          pmdb205 LIKE pmdb_t.pmdb205, #采购中心
          pmdb206 LIKE pmdb_t.pmdb206, #采购员
          pmdb207 LIKE pmdb_t.pmdb207, #采购方式
          pmdb208 LIKE pmdb_t.pmdb208, #经营方式
          pmdb209 LIKE pmdb_t.pmdb209, #结算方式
          pmdb210 LIKE pmdb_t.pmdb210, #促销开始日
          pmdb211 LIKE pmdb_t.pmdb211, #促销结束日
          pmdb212 LIKE pmdb_t.pmdb212, #要货件数
          pmdb250 LIKE pmdb_t.pmdb250, #合理库存
          pmdb251 LIKE pmdb_t.pmdb251, #最高库存
          pmdb252 LIKE pmdb_t.pmdb252, #现有库存
          pmdb253 LIKE pmdb_t.pmdb253, #入库在途量
          pmdb254 LIKE pmdb_t.pmdb254, #前一周销量
          pmdb255 LIKE pmdb_t.pmdb255, #前二周销量
          pmdb256 LIKE pmdb_t.pmdb256, #前三周销量
          pmdb257 LIKE pmdb_t.pmdb257, #前四周销量
          pmdb258 LIKE pmdb_t.pmdb258, #要货在途量
          pmdb259 LIKE pmdb_t.pmdb259, #周平均销量
          pmdb900 LIKE pmdb_t.pmdb900, #保留字段str
          pmdb999 LIKE pmdb_t.pmdb999, #保留字段end
          pmdb260 LIKE pmdb_t.pmdb260, #收货部门
          pmdb052 LIKE pmdb_t.pmdb052, #来源分批序
          pmdb227 LIKE pmdb_t.pmdb227, #补货规格说明
          pmdb053 LIKE pmdb_t.pmdb053, #预算细项
          pmdb213 LIKE pmdb_t.pmdb213, #参考进价
          pmdb054 LIKE pmdb_t.pmdb054, #库存管理特征
          pmdb214 LIKE pmdb_t.pmdb214 #需求时间
   END RECORD
   #161124-00048#9 mod-S
   DEFINE l_pmdbseq        LIKE pmdb_t.pmdbseq
   DEFINE l_seq            LIKE pmdb_t.pmdbseq
   DEFINE l_slip           LIKE pmda_t.pmdadocno   #2015/08/19 by stellar
   DEFINE l_insert1        LIKE type_t.num5        #2015/08/19 by stellar
   DEFINE l_errno          LIKE gzze_t.gzze001     #2015/08/19 by stellar
   DEFINE l_bgaf016        LIKE bgaf_t.bgaf016     #2015/08/19 by stellar
   DEFINE l_pmdb053        LIKE pmdb_t.pmdb053     #2015/08/19 by stellar
   DEFINE l_pmdb053_desc   LIKE type_t.chr80       #2015/08/19 by stellar
   DEFINE l_pmdb006        LIKE pmdb_t.pmdb006
   DEFINE l_pmdb007        LIKE pmdb_t.pmdb007
   DEFINE l_cy_pmdb006     LIKE pmdb_t.pmdb006
   DEFINE l_pjbd006        LIKE pjbd_t.pjbd006
   
   #151217-00005#1---add--begin--
   DEFINE l_pmdb019        LIKE pmdb_t.pmdb019
   DEFINE l_pmdb010        LIKE pmdb_t.pmdb010
   DEFINE l_pmdb011        LIKE pmdb_t.pmdb011
   DEFINE l_pmdb020        LIKE pmdb_t.pmdb020
   DEFINE l_pmdb021        LIKE pmdb_t.pmdb021
   #151217-00005#1---add--end--
   
   DEFINE l_oobx003        LIKE oobx_t.oobx003   #160727-00025#9
   #160920-00035#1---s
   DEFINE l_pspcsite       LIKE pspc_t.pspcsite
   DEFINE l_pspc001        LIKE pspc_t.pspc001
   DEFINE l_pspc002        LIKE pspc_t.pspc002
   DEFINE l_pspc004        LIKE pspc_t.pspc004
   DEFINE l_pspc061        LIKE pspc_t.pspc061
   #160920-00035#1--e
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
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocno_desc,g_pmda_m.pmdadocdt, 
       g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmda003,g_pmda_m.pmda003_desc,g_pmda_m.pmdastus, 
       g_pmda_m.pmda004,g_pmda_m.pmda010,g_pmda_m.pmda010_desc,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005, 
       g_pmda_m.pmda005_desc,g_pmda_m.ooan005,g_pmda_m.pmda008,g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda007_desc, 
       g_pmda_m.pmda021,g_pmda_m.pmda021_desc,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda023_desc, 
       g_pmda_m.pmda022,g_pmda_m.pmda024,g_pmda_m.pmda024_desc,g_pmda_m.oofb017,g_pmda_m.pmda025,g_pmda_m.pmda025_desc, 
       g_pmda_m.oofb017_1,g_pmda_m.pmdaownid,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp,g_pmda_m.pmdaowndp_desc, 
       g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdacrtdt, 
       g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfid_desc, 
       g_pmda_m.pmdacnfdt
   
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
   LET g_forupd_sql = "SELECT pmdbsite,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb052,pmdb004,pmdb005,pmdb007, 
       pmdb006,pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050,pmdb032,pmdb051,pmdb033, 
       pmdb049,pmdbseq,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb034, 
       pmdb035,pmdb036,pmdb053,pmdb037,pmdb038,pmdb039,pmdb054,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045, 
       pmdb046 FROM pmdb_t WHERE pmdbent=? AND pmdbdocno=? AND pmdbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
 
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt400_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmt400_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   CALL apmt400_set_no_required()
   CALL apmt400_set_required()
   #將單身輸入權限放入共用變數給嵌入的子程式用, 若子程式要自己控管, 還是可以從子程式中覆蓋掉值
   #161031-00025#8---s
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #161031-00025#8---e
   #end add-point
   CALL apmt400_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocdt,g_pmda_m.pmda002, 
       g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004,g_pmda_m.pmda010,g_pmda_m.pmda011,g_pmda_m.pmda012, 
       g_pmda_m.pmda005,g_pmda_m.pmda008,g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020, 
       g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda022,g_pmda_m.pmda024,g_pmda_m.pmda025
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
   
   #LET g_flag = FALSE   #161205-00025#1
   CALL apmt400_set_entry(p_cmd)
   CALL apmt400_set_no_required()
   CALL apmt400_set_required()
   CALL apmt400_set_no_entry(p_cmd)
   
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apmt400.input.head" >}
      #單頭段
      INPUT BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocdt,g_pmda_m.pmda002, 
          g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004,g_pmda_m.pmda010,g_pmda_m.pmda011,g_pmda_m.pmda012, 
          g_pmda_m.pmda005,g_pmda_m.pmda008,g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020, 
          g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda022,g_pmda_m.pmda024,g_pmda_m.pmda025 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apmt400_cl USING g_enterprise,g_pmda_m.pmdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt400_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt400_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apmt400_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF l_cmd_t = 'r' THEN
               CALL apmt400_reproduce_init()
            END IF
            #end add-point
            CALL apmt400_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdasite
            #add-point:BEFORE FIELD pmdasite name="input.b.pmdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdasite
            
            #add-point:AFTER FIELD pmdasite name="input.a.pmdasite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdasite
            #add-point:ON CHANGE pmdasite name="input.g.pmdasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdadocno
            
            #add-point:AFTER FIELD pmdadocno name="input.a.pmdadocno"
            CALL s_aooi200_get_slip_desc(g_pmda_m.pmdadocno) RETURNING g_pmda_m.pmdadocno_desc
            DISPLAY BY NAME g_pmda_m.pmdadocno_desc
            
            IF  NOT cl_null(g_pmda_m.pmdadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmda_m.pmdadocno != g_pmdadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmda_t WHERE "||"pmdaent = '" ||g_enterprise|| "' AND "||"pmdadocno = '"||g_pmda_m.pmdadocno ||"'",'std-00004',0) THEN 
                     LET g_pmda_m.pmdadocno = g_pmda_m_t.pmdadocno
                     CALL s_aooi200_get_slip_desc(g_pmda_m.pmdadocno) RETURNING g_pmda_m.pmdadocno_desc
                     DISPLAY BY NAME g_pmda_m.pmdadocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢核輸入的單據別是否可以被key人員對應的控制組使用
                  CALL s_control_chk_doc('1',g_pmda_m.pmdadocno,'3',g_user,g_dept,'','') RETURNING l_success,l_flag
                  IF l_success THEN
                     IF NOT l_flag THEN
                        #CALL cl_err(g_pmda_m.pmdadocno,'apm-00254',1)
                        LET g_pmda_m.pmdadocno = g_pmda_m_t.pmdadocno
                        CALL s_aooi200_get_slip_desc(g_pmda_m.pmdadocno) RETURNING g_pmda_m.pmdadocno_desc
                        DISPLAY BY NAME g_pmda_m.pmdadocno_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     LET g_pmda_m.pmdadocno = g_pmda_m_t.pmdadocno
                     CALL s_aooi200_get_slip_desc(g_pmda_m.pmdadocno) RETURNING g_pmda_m.pmdadocno_desc
                     DISPLAY BY NAME g_pmda_m.pmdadocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #依據輸入的單別抓取單別的[C:預算控管]參數值，預設給pmda006(預算控管)
                  CALL cl_get_doc_para(g_enterprise,g_site,g_pmda_m.pmdadocno,'D-COM-0002') RETURNING g_pmda_m.pmda006
                  IF cl_null(g_pmda_m.pmda006) THEN
                     LET g_pmda_m.pmda006 = 'N'
                  END IF
                  
                  DISPLAY BY NAME g_pmda_m.pmda006
                  
                  IF NOT s_aooi200_chk_slip(g_site,'',g_pmda_m.pmdadocno,g_prog) THEN
                     LET g_pmda_m.pmdadocno = g_pmda_m_t.pmdadocno
                     CALL s_aooi200_get_slip_desc(g_pmda_m.pmdadocno) RETURNING g_pmda_m.pmdadocno_desc
                     DISPLAY BY NAME g_pmda_m.pmdadocno_desc
                     NEXT FIELD CURRENT   
                  END IF
               END IF
               CALL apmt400_get_col_default()
               CALL apmt400_set_entry(p_cmd)
               CALL apmt400_set_no_required()
               CALL apmt400_set_required()
               CALL apmt400_set_no_entry(p_cmd)
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdadocno
            #add-point:BEFORE FIELD pmdadocno name="input.b.pmdadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdadocno
            #add-point:ON CHANGE pmdadocno name="input.g.pmdadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda001
            #add-point:BEFORE FIELD pmda001 name="input.b.pmda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda001
            
            #add-point:AFTER FIELD pmda001 name="input.a.pmda001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda001
            #add-point:ON CHANGE pmda001 name="input.g.pmda001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdadocdt
            #add-point:BEFORE FIELD pmdadocdt name="input.b.pmdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdadocdt
            
            #add-point:AFTER FIELD pmdadocdt name="input.a.pmdadocdt"
            #IF NOT cl_null(g_pmda_m.pmdadocdt) THEN
            #   CALL s_aooi200_gen_docno(g_site,g_pmda_m.pmdadocno,g_pmda_m.pmdadocdt,g_prog) RETURNING l_success,g_pmda_m.pmdadocno
            #   IF NOT l_success THEN
            #      CALL cl_err(g_pmda_m.pmdadocno,'apm-00003',1)
            #      LET g_pmda_m.pmdadocdt = g_pmda_m_t.pmdadocdt
            #      DISPLAY g_pmda_m.pmdadocdt TO pmdadocdt
            #      NEXT FIELD pmdadocno           
            #   END IF
            #ELSE
            #   NEXT FIELD pmdadocdt
            #END IF
            #LET g_flag = TRUE  #成功自动编号，关闭单据编号，日期栏位
            #CALL apmt400_set_entry(p_cmd)
            #CALL apmt400_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdadocdt
            #add-point:ON CHANGE pmdadocdt name="input.g.pmdadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda002
            
            #add-point:AFTER FIELD pmda002 name="input.a.pmda002"
            CALL apmt400_pmda002_ref(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
            DISPLAY BY NAME g_pmda_m.pmda002_desc
                     
            IF NOT cl_null(g_pmda_m.pmda002) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmda_m.pmda002 != g_pmda_m_t.pmda002 OR cl_null(g_pmda_m_t.pmda002))) THEN   #160824-00007#339 Add By Ken 170106
               IF (g_pmda_m.pmda002 != g_pmda_m_o.pmda002 OR cl_null(g_pmda_m_o.pmda002)) THEN    #160824-00007#339 Mark By Ken 170106
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmda_m.pmda002
   
                    #160318-00025#16  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#16  by 07900 --add-end  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                     SELECT ooag003 INTO g_pmda_m.pmda003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_pmda_m.pmda002
                     CALL apmt400_pmda003_ref(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
                     DISPLAY BY NAME g_pmda_m.pmda003_desc   
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_pmda_m.pmda002 = g_pmda_m_t.pmda002   #160824-00007#339 Mark By Ken 170106
                     LET g_pmda_m.pmda002 = g_pmda_m_o.pmda002    #160824-00007#339 Add By Ken 170106
                     CALL apmt400_pmda002_ref(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
                     DISPLAY BY NAME g_pmda_m.pmda002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            LET g_pmda_m_o.* = g_pmda_m.*   #160824-00007#339 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda002
            #add-point:BEFORE FIELD pmda002 name="input.b.pmda002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda002
            #add-point:ON CHANGE pmda002 name="input.g.pmda002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda003
            
            #add-point:AFTER FIELD pmda003 name="input.a.pmda003"
            CALL apmt400_pmda003_ref(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
            DISPLAY BY NAME g_pmda_m.pmda003_desc 
            
            IF NOT cl_null(g_pmda_m.pmda003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmda_m.pmda003
               LET g_chkparam.arg2 = g_pmda_m.pmdadocdt

               #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#16 by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  #LET g_pmda_m.pmda003 = g_pmda_m_t.pmda003  #160824-00007#339 Mark By Ken 170106
                  LET g_pmda_m.pmda003 = g_pmda_m_o.pmda003   #160824-00007#339 Add By Ken 170106
                  CALL apmt400_pmda003_ref(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
                  DISPLAY BY NAME g_pmda_m.pmda003_desc 
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            LET g_pmda_m_o.* = g_pmda_m.*   #160824-00007#339 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda003
            #add-point:BEFORE FIELD pmda003 name="input.b.pmda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda003
            #add-point:ON CHANGE pmda003 name="input.g.pmda003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdastus
            #add-point:BEFORE FIELD pmdastus name="input.b.pmdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdastus
            
            #add-point:AFTER FIELD pmdastus name="input.a.pmdastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdastus
            #add-point:ON CHANGE pmdastus name="input.g.pmdastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda004
            #add-point:BEFORE FIELD pmda004 name="input.b.pmda004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda004
            
            #add-point:AFTER FIELD pmda004 name="input.a.pmda004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda004
            #add-point:ON CHANGE pmda004 name="input.g.pmda004"
            CALL apmt400_set_entry(p_cmd)
            CALL apmt400_set_no_required()
            CALL apmt400_set_required()
            CALL apmt400_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda010
            
            #add-point:AFTER FIELD pmda010 name="input.a.pmda010"
            CALL apmt400_pmda010_ref(g_pmda_m.pmda010) RETURNING g_pmda_m.pmda010_desc
            DISPLAY BY NAME g_pmda_m.pmda010_desc
            
            IF NOT cl_null(g_pmda_m.pmda010) THEN 

               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_pmda_m.pmda010
               #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
               #160318-00025#16 by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002") THEN
                  #檢查成功時後續處理
                  #根據稅別帶出稅率、含稅否等
                  CALL s_tax_chk(g_site,g_pmda_m.pmda010)
                      RETURNING l_success,g_pmda_m.pmda010_desc,g_pmda_m.pmda012,g_pmda_m.pmda011,l_oodb011
                  DISPLAY BY NAME g_pmda_m.pmda012,g_pmda_m.pmda011   
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmda_m.pmda010 = g_pmda_m_t.pmda010
                  CALL apmt400_pmda010_ref(g_pmda_m.pmda010) RETURNING g_pmda_m.pmda010_desc
                  DISPLAY BY NAME g_pmda_m.pmda010_desc
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_pmda_m.pmda011 = ''
               LET g_pmda_m.pmda012 = 'N'
               DISPLAY BY NAME g_pmda_m.pmda011,g_pmda_m.pmda012
            END IF 

            IF ((NOT cl_null(g_pmda_m.pmda010) AND (g_pmda_m.pmda010 != g_pmda_m_t.pmda010 OR cl_null(g_pmda_m_t.pmda010))) 
               OR (cl_null(g_pmda_m.pmda010) AND NOT cl_null(g_pmda_m_t.pmda010))) THEN
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda010
            #add-point:BEFORE FIELD pmda010 name="input.b.pmda010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda010
            #add-point:ON CHANGE pmda010 name="input.g.pmda010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda011
            #add-point:BEFORE FIELD pmda011 name="input.b.pmda011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda011
            
            #add-point:AFTER FIELD pmda011 name="input.a.pmda011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda011
            #add-point:ON CHANGE pmda011 name="input.g.pmda011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda012
            #add-point:BEFORE FIELD pmda012 name="input.b.pmda012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda012
            
            #add-point:AFTER FIELD pmda012 name="input.a.pmda012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda012
            #add-point:ON CHANGE pmda012 name="input.g.pmda012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda005
            
            #add-point:AFTER FIELD pmda005 name="input.a.pmda005"
            CALL apmt400_pmda005_ref(g_pmda_m.pmda005) RETURNING g_pmda_m.pmda005_desc
            DISPLAY BY NAME g_pmda_m.pmda005_desc
            IF NOT cl_null(g_pmda_m.pmda005) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_pmda_m.pmda005

                #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#16 by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002") THEN
                  #檢查成功時後續處理
                  LET l_ooef016 = ''
                  SELECT ooef016 INTO l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
                  CALL s_aooi160_get_exrate('1',g_site,g_today,g_pmda_m.pmda005,l_ooef016,0,'11') RETURNING g_pmda_m.ooan005
                  DISPLAY BY NAME g_pmda_m.ooan005
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmda_m.pmda005 = g_pmda_m_t.pmda005
                  CALL apmt400_pmda005_ref(g_pmda_m.pmda005) RETURNING g_pmda_m.pmda005_desc
                  DISPLAY BY NAME g_pmda_m.pmda005_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda005
            #add-point:BEFORE FIELD pmda005 name="input.b.pmda005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda005
            #add-point:ON CHANGE pmda005 name="input.g.pmda005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda008
            #add-point:BEFORE FIELD pmda008 name="input.b.pmda008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda008
            
            #add-point:AFTER FIELD pmda008 name="input.a.pmda008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda008
            #add-point:ON CHANGE pmda008 name="input.g.pmda008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda009
            #add-point:BEFORE FIELD pmda009 name="input.b.pmda009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda009
            
            #add-point:AFTER FIELD pmda009 name="input.a.pmda009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda009
            #add-point:ON CHANGE pmda009 name="input.g.pmda009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda007
            
            #add-point:AFTER FIELD pmda007 name="input.a.pmda007"
            CALL apmt400_pmda003_ref(g_pmda_m.pmda007) RETURNING g_pmda_m.pmda007_desc
            DISPLAY BY NAME g_pmda_m.pmda007_desc
            
            IF NOT cl_null(g_pmda_m.pmda007) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmda_m.pmda007
               LET g_chkparam.arg2 = g_pmda_m.pmdadocdt

               #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#16 by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pmda_m.pmda007 = g_pmda_m_t.pmda007
                  CALL apmt400_pmda003_ref(g_pmda_m.pmda007) RETURNING g_pmda_m.pmda007_desc
                  DISPLAY BY NAME g_pmda_m.pmda007_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda007
            #add-point:BEFORE FIELD pmda007 name="input.b.pmda007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda007
            #add-point:ON CHANGE pmda007 name="input.g.pmda007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda021
            
            #add-point:AFTER FIELD pmda021 name="input.a.pmda021"
            CALL apmt400_pmda021_ref(g_pmda_m.pmda021) RETURNING g_pmda_m.pmda021_desc
            DISPLAY BY NAME g_pmda_m.pmda021_desc
            
            IF NOT cl_null(g_pmda_m.pmda021) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmda_m.pmda021

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_263") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pmda_m.pmda021 = g_pmda_m_t.pmda021
                  CALL apmt400_pmda021_ref(g_pmda_m.pmda021) RETURNING g_pmda_m.pmda021_desc
                  DISPLAY BY NAME g_pmda_m.pmda021_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda021
            #add-point:BEFORE FIELD pmda021 name="input.b.pmda021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda021
            #add-point:ON CHANGE pmda021 name="input.g.pmda021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda020
            #add-point:BEFORE FIELD pmda020 name="input.b.pmda020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda020
            
            #add-point:AFTER FIELD pmda020 name="input.a.pmda020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda020
            #add-point:ON CHANGE pmda020 name="input.g.pmda020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda006
            #add-point:BEFORE FIELD pmda006 name="input.b.pmda006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda006
            
            #add-point:AFTER FIELD pmda006 name="input.a.pmda006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda006
            #add-point:ON CHANGE pmda006 name="input.g.pmda006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda023
            
            #add-point:AFTER FIELD pmda023 name="input.a.pmda023"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmda_m.pmda023
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='317' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmda_m.pmda023_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmda_m.pmda023_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda023
            #add-point:BEFORE FIELD pmda023 name="input.b.pmda023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda023
            #add-point:ON CHANGE pmda023 name="input.g.pmda023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda022
            #add-point:BEFORE FIELD pmda022 name="input.b.pmda022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda022
            
            #add-point:AFTER FIELD pmda022 name="input.a.pmda022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda022
            #add-point:ON CHANGE pmda022 name="input.g.pmda022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda024
            
            #add-point:AFTER FIELD pmda024 name="input.a.pmda024"
            #ming 20150821 add -------------------------------(S) 
            CALL apmt400_pmda024_ref(g_pmda_m.pmda024)
                 RETURNING g_pmda_m.pmda024_desc
            DISPLAY BY NAME g_pmda_m.pmda024_desc
            #ming 20150821 add -------------------------------(E) 
            
            IF NOT cl_null(g_pmda_m.pmda024) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_oofa001
               LET g_chkparam.arg2 = g_pmda_m.pmda024
               #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
               #160318-00025#16 by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oofb019_1") THEN
                  #檢查成功時後續處理 
                  #呼叫地址組合應用元件，將組合好的聯絡地址顯示在下方 
               ELSE
                  #檢查失敗時後續處理 
                  #ming 20150821 add ----------------------(S) 
                  LET g_pmda_m.pmda024 = g_pmda_m_t.pmda024
                  CALL apmt400_pmda024_ref(g_pmda_m.pmda024)
                       RETURNING g_pmda_m.pmda024_desc
                  DISPLAY BY NAME g_pmda_m.pmda024_desc
                  #ming 20150821 add ----------------------(E) 
                  NEXT FIELD CURRENT
               END IF


            END IF 

            #ming 20150821 add ---------------------------------(S) 
            #呼叫地址組合應用元件 
            IF NOT cl_null(g_pmda_m.pmda024) THEN
               CALL s_aooi350_get_address(g_oofa001,g_pmda_m.pmda024,g_lang)
                    RETURNING l_success,g_pmda_m.oofb017
            END IF
            DISPLAY BY NAME g_pmda_m.oofb017
            #ming 20150821 add ---------------------------------(E) 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda024
            #add-point:BEFORE FIELD pmda024 name="input.b.pmda024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda024
            #add-point:ON CHANGE pmda024 name="input.g.pmda024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda025
            
            #add-point:AFTER FIELD pmda025 name="input.a.pmda025"
            #ming 20150821 add ---------------------------------(S) 
            CALL apmt400_pmda025_ref(g_pmda_m.pmda025)
                 RETURNING g_pmda_m.pmda025_desc
            DISPLAY BY NAME g_pmda_m.pmda025_desc
            #ming 20150821 add ---------------------------------(E) 
            
            IF NOT cl_null(g_pmda_m.pmda025) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_oofa001
               LET g_chkparam.arg2 = g_pmda_m.pmda025
               #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="anm-00025:sub-01302|aooi350|",cl_get_progname("aooi350",g_lang,"2"),"|:EXEPROGaooi350"
               #160318-00025#16 by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oofb019_2") THEN
                  #檢查成功時後續處理 
                  #呼叫地址組合應用元件，將組合好的聯絡地址顯示在下方 
               ELSE
                  #檢查失敗時後續處理 
                  #ming 20150821 add ----------------------------(S) 
                  LET g_pmda_m.pmda025 = g_pmda_m_t.pmda025
                  CALL apmt400_pmda025_ref(g_pmda_m.pmda025)
                       RETURNING g_pmda_m.pmda025_desc
                  DISPLAY BY NAME g_pmda_m.pmda025_desc
                  #ming 20150821 add ----------------------------(E) 
                  NEXT FIELD CURRENT
               END IF


            END IF 

            #ming 20150821 add -----------------------------------(S) 
            #呼叫地址組合應用元件 
            IF NOT cl_null(g_pmda_m.pmda025) THEN
               CALL s_aooi350_get_address(g_oofa001,g_pmda_m.pmda025,g_lang)
                    RETURNING l_success,g_pmda_m.oofb017_1
            END IF
            DISPLAY BY NAME g_pmda_m.oofb017_1
            #ming 20150821 add -----------------------------------(E) 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda025
            #add-point:BEFORE FIELD pmda025 name="input.b.pmda025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda025
            #add-point:ON CHANGE pmda025 name="input.g.pmda025"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmdasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdasite
            #add-point:ON ACTION controlp INFIELD pmdasite name="input.c.pmdasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdadocno
            #add-point:ON ACTION controlp INFIELD pmdadocno name="input.c.pmdadocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmdadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = g_prog #

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_pmda_m.pmdadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmda_m.pmdadocno TO pmdadocno              #顯示到畫面上
            CALL s_aooi200_get_slip_desc(g_pmda_m.pmdadocno) RETURNING g_pmda_m.pmdadocno_desc
            DISPLAY BY NAME g_pmda_m.pmdadocno_desc

            NEXT FIELD pmdadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda001
            #add-point:ON ACTION controlp INFIELD pmda001 name="input.c.pmda001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdadocdt
            #add-point:ON ACTION controlp INFIELD pmdadocdt name="input.c.pmdadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda002
            #add-point:ON ACTION controlp INFIELD pmda002 name="input.c.pmda002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda002             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_pmda_m.pmda002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmda_m.pmda002 TO pmda002              #顯示到畫面上
            CALL apmt400_pmda002_ref(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
            DISPLAY BY NAME g_pmda_m.pmda002_desc

            NEXT FIELD pmda002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda003
            #add-point:ON ACTION controlp INFIELD pmda003 name="input.c.pmda003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmda_m.pmdadocdt #

            CALL q_ooeg001()                                #呼叫開窗

            LET g_pmda_m.pmda003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmda_m.pmda003 TO pmda003              #顯示到畫面上
            CALL apmt400_pmda003_ref(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
            DISPLAY BY NAME g_pmda_m.pmda003_desc

            NEXT FIELD pmda003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdastus
            #add-point:ON ACTION controlp INFIELD pmdastus name="input.c.pmdastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda004
            #add-point:ON ACTION controlp INFIELD pmda004 name="input.c.pmda004"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda010
            #add-point:ON ACTION controlp INFIELD pmda010 name="input.c.pmda010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda010             #給予default值

            #給予arg

            CALL q_oodb002_2()                                #呼叫開窗

            LET g_pmda_m.pmda010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmda_m.pmda010 TO pmda010              #顯示到畫面上
            CALL apmt400_pmda010_ref(g_pmda_m.pmda010) RETURNING g_pmda_m.pmda010_desc
            DISPLAY BY NAME g_pmda_m.pmda010_desc

            NEXT FIELD pmda010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmda011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda011
            #add-point:ON ACTION controlp INFIELD pmda011 name="input.c.pmda011"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda012
            #add-point:ON ACTION controlp INFIELD pmda012 name="input.c.pmda012"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda005
            #add-point:ON ACTION controlp INFIELD pmda005 name="input.c.pmda005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #

            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_pmda_m.pmda005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmda_m.pmda005 TO pmda005              #顯示到畫面上
            CALL apmt400_pmda005_ref(g_pmda_m.pmda005) RETURNING g_pmda_m.pmda005_desc
            DISPLAY BY NAME g_pmda_m.pmda005_desc

            NEXT FIELD pmda005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmda008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda008
            #add-point:ON ACTION controlp INFIELD pmda008 name="input.c.pmda008"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda009
            #add-point:ON ACTION controlp INFIELD pmda009 name="input.c.pmda009"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda007
            #add-point:ON ACTION controlp INFIELD pmda007 name="input.c.pmda007"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmda_m.pmdadocdt

            CALL q_ooeg001()                                #呼叫開窗

            LET g_pmda_m.pmda007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmda_m.pmda007 TO pmda007              #顯示到畫面上
            CALL apmt400_pmda003_ref(g_pmda_m.pmda007) RETURNING g_pmda_m.pmda007_desc
            DISPLAY BY NAME g_pmda_m.pmda007_desc

            NEXT FIELD pmda007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmda021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda021
            #add-point:ON ACTION controlp INFIELD pmda021 name="input.c.pmda021"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda021             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "263" #  #170213-00038#3 mark

            #CALL q_oocq002()                                #呼叫開窗  #170213-00038#3 mark
            CALL q_oocq002_263()  #170213-00038#3 add

            LET g_pmda_m.pmda021 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmda_m.pmda021 TO pmda021              #顯示到畫面上
            CALL apmt400_pmda021_ref(g_pmda_m.pmda021) RETURNING g_pmda_m.pmda021_desc
            DISPLAY BY NAME g_pmda_m.pmda021_desc

            NEXT FIELD pmda021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmda020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda020
            #add-point:ON ACTION controlp INFIELD pmda020 name="input.c.pmda020"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda006
            #add-point:ON ACTION controlp INFIELD pmda006 name="input.c.pmda006"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda023
            #add-point:ON ACTION controlp INFIELD pmda023 name="input.c.pmda023"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda023             #給予default值
            LET g_qryparam.default2 = "" #g_pmda_m.oocq002 #應用分類碼
            #給予arg
            #LET g_qryparam.arg1 = "317" #s  #170213-00038#3 mark


            #CALL q_oocq002()                                #呼叫開窗  #170213-00038#3 mark
            CALL q_oocq002_317()  #170213-00038#3 add

            LET g_pmda_m.pmda023 = g_qryparam.return1              
            #LET g_pmda_m.oocq002 = g_qryparam.return2 
            DISPLAY g_pmda_m.pmda023 TO pmda023              #
            #DISPLAY g_pmda_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD pmda023                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmda022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda022
            #add-point:ON ACTION controlp INFIELD pmda022 name="input.c.pmda022"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda024
            #add-point:ON ACTION controlp INFIELD pmda024 name="input.c.pmda024"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda024             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_oofa001
            LET g_qryparam.where = " oofb008 = '3' "     #出貨地址   


            CALL q_oofb019_1()                                #呼叫開窗

            LET g_pmda_m.pmda024 = g_qryparam.return1              

            DISPLAY g_pmda_m.pmda024 TO pmda024              # 
            
            #ming 20150821 add -------------------------------(S) 
            CALL apmt400_pmda024_ref(g_pmda_m.pmda024)
                 RETURNING g_pmda_m.pmda024_desc
            DISPLAY BY NAME g_pmda_m.pmda024_desc

            #呼叫地址組合應用元件 
            IF NOT cl_null(g_pmda_m.pmda024) THEN
               CALL s_aooi350_get_address(g_oofa001,g_pmda_m.pmda024,g_lang)
                    RETURNING l_success,g_pmda_m.oofb017
            END IF
            DISPLAY BY NAME g_pmda_m.oofb017
            #ming 20150821 add -------------------------------(E) 

            NEXT FIELD pmda024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmda025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda025
            #add-point:ON ACTION controlp INFIELD pmda025 name="input.c.pmda025"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda025             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_oofa001

            LET g_qryparam.where = " oofb008 = '5' "     #發票地址  


            CALL q_oofb019_1()                                #呼叫開窗

            LET g_pmda_m.pmda025 = g_qryparam.return1              

            DISPLAY g_pmda_m.pmda025 TO pmda025              # 
            
            #ming 20150821 add ------------------------------------(S) 
            CALL apmt400_pmda025_ref(g_pmda_m.pmda025)
                 RETURNING g_pmda_m.pmda025_desc
            DISPLAY BY NAME g_pmda_m.pmda025_desc

            #呼叫地址組合應用元件 
            IF NOT cl_null(g_pmda_m.pmda025) THEN
               CALL s_aooi350_get_address(g_oofa001,g_pmda_m.pmda025,g_lang)
                    RETURNING l_success,g_pmda_m.oofb017_1
            END IF
            DISPLAY BY NAME g_pmda_m.oofb017_1
            #ming 20150821 add ------------------------------------(E) 

            NEXT FIELD pmda025                          #返回原欄位


            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pmda_m.pmdadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_pmda_m.pmdadocno,g_pmda_m.pmdadocdt,g_prog) RETURNING l_success,g_pmda_m.pmdadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_pmda_m.pmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdadocno           
               END IF
               #end add-point
               
               INSERT INTO pmda_t (pmdaent,pmdasite,pmdadocno,pmda001,pmdadocdt,pmda002,pmda003,pmdastus, 
                   pmda004,pmda010,pmda011,pmda012,pmda005,pmda008,pmda009,pmda007,pmda021,pmda020,pmda006, 
                   pmda023,pmda022,pmda024,pmda025,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,pmdacrtdt, 
                   pmdamodid,pmdamoddt,pmdacnfid,pmdacnfdt)
               VALUES (g_enterprise,g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocdt, 
                   g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004,g_pmda_m.pmda010, 
                   g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008,g_pmda_m.pmda009, 
                   g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023, 
                   g_pmda_m.pmda022,g_pmda_m.pmda024,g_pmda_m.pmda025,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp, 
                   g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
                   g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_pmda_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               LET g_ooff003_d = g_pmda_m.pmdadocno   #161031-00025#8
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apmt400_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apmt400_b_fill()
                  CALL apmt400_b_fill2('0')
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
               CALL apmt400_pmda_t_mask_restore('restore_mask_o')
               
               UPDATE pmda_t SET (pmdasite,pmdadocno,pmda001,pmdadocdt,pmda002,pmda003,pmdastus,pmda004, 
                   pmda010,pmda011,pmda012,pmda005,pmda008,pmda009,pmda007,pmda021,pmda020,pmda006,pmda023, 
                   pmda022,pmda024,pmda025,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,pmdacrtdt,pmdamodid, 
                   pmdamoddt,pmdacnfid,pmdacnfdt) = (g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001, 
                   g_pmda_m.pmdadocdt,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004, 
                   g_pmda_m.pmda010,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008, 
                   g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020,g_pmda_m.pmda006, 
                   g_pmda_m.pmda023,g_pmda_m.pmda022,g_pmda_m.pmda024,g_pmda_m.pmda025,g_pmda_m.pmdaownid, 
                   g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid, 
                   g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt)
                WHERE pmdaent = g_enterprise AND pmdadocno = g_pmdadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pmda_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               #2015/08/20 by stellar add ----- (S)
               CALL s_apmt400_stus_abg1(g_pmda_m.pmdadocno,'U')
                    RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               #2015/02/20 by stellar add ----- (E)
               
               #151217-00005#1---add--begin--
               #若單頭修改了幣別、稅率等，則重新計算單身金額
               IF (g_pmda_m.pmda010 != g_pmda_m_t.pmda010 OR g_pmda_m.pmda012 != g_pmda_m_t.pmda012 OR cl_null(g_pmda_m_t.pmda012)) OR
                  (g_pmda_m.pmda011 != g_pmda_m_t.pmda011 OR cl_null(g_pmda_m_t.pmda011)) OR
                  (g_pmda_m.pmda005 != g_pmda_m_t.pmda005 OR cl_null(g_pmda_m_t.pmda005)) THEN
                  
                  DECLARE pmdb_upd_cs CURSOR FOR
                     SELECT pmdbseq,pmdb019,pmdb006,pmdb007,pmdb010,pmdb011 FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
                  FOREACH pmdb_upd_cs INTO l_pmdbseq,l_pmdb019,l_pmdb006,l_pmdb007,l_pmdb010,l_pmdb011
                     
                     IF cl_null(l_pmdb010) OR cl_null(l_pmdb011) THEN   #計價數量
                        LET l_pmdb010 = l_pmdb006
                        LET l_pmdb011 = l_pmdb007
                     END IF
                     CALL apmt400_get_amount(l_pmdbseq,l_pmdb006,l_pmdb019,g_pmda_m.pmda010)
                        RETURNING l_pmdb020,l_pmdb021
                     UPDATE pmdb_t SET pmdb010 = l_pmdb010,
                                       pmdb011 = l_pmdb011,
                                       pmdb018 = g_pmda_m.pmda011,
                                       pmdb020 = l_pmdb020,
                                       pmdb021 = l_pmdb021
                         WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno AND pmdbseq = l_pmdbseq
                     
                  END FOREACH
                  CALL apmt400_b_fill()
               END IF
               #151217-00005#1---add---end----
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL apmt400_pmda_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_pmda_m_t)
               LET g_log2 = util.JSON.stringify(g_pmda_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apmt400.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmdb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION apmt400_01
            LET g_action_choice="apmt400_01"
            IF cl_auth_chk_act("apmt400_01") THEN
               
               #add-point:ON ACTION apmt400_01 name="input.detail_input.page1.apmt400_01"
               #130802-00004#158--add---begin---
               CALL s_transaction_begin()
               IF apmt400_01(g_pmda_m.pmdadocno) THEN
                  CALL apmt400_b_fill()
                  LET g_rec_b = g_pmdb_d.getLength()
                  IF g_rec_b > 0 THEN
                     CALL s_transaction_end('Y','0')
                     LET g_flag = TRUE
                     EXIT DIALOG
                  ELSE
                     CALL s_transaction_end('N','0')
                     LET g_flag = FALSE
                     NEXT FIELD pmdb004
                  END IF
               ELSE
                  CALL s_transaction_end('N','0')
                  LET g_flag = FALSE
                  NEXT FIELD pmdb004
               END IF
               #130802-00004#158--add---end---
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmdb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt400_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmdb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            CALL apmt400_b_fill()
            LET l_insert1 = FALSE   #2015/08/19 by stellar add
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
            OPEN apmt400_cl USING g_enterprise,g_pmda_m.pmdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt400_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt400_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmdb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmdb_d[l_ac].pmdbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmdb_d_t.* = g_pmdb_d[l_ac].*  #BACKUP
               LET g_pmdb_d_o.* = g_pmdb_d[l_ac].*  #BACKUP
               CALL apmt400_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               CALL apmt400_set_no_required_b()
               CALL apmt400_set_required_b()
               #end add-point  
               CALL apmt400_set_no_entry_b(l_cmd)
               IF NOT apmt400_lock_b("pmdb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt400_bcl INTO g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb001, 
                      g_pmdb_d[l_ac].pmdb002,g_pmdb_d[l_ac].pmdb003,g_pmdb_d[l_ac].pmdb052,g_pmdb_d[l_ac].pmdb004, 
                      g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb009, 
                      g_pmdb_d[l_ac].pmdb008,g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb010,g_pmdb_d[l_ac].pmdb030, 
                      g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb031,g_pmdb_d[l_ac].pmdb050,g_pmdb_d[l_ac].pmdb032, 
                      g_pmdb_d[l_ac].pmdb051,g_pmdb_d[l_ac].pmdb033,g_pmdb_d[l_ac].pmdb049,g_pmdb2_d[l_ac].pmdbseq, 
                      g_pmdb2_d[l_ac].pmdb012,g_pmdb2_d[l_ac].pmdb014,g_pmdb2_d[l_ac].pmdb015,g_pmdb2_d[l_ac].pmdb016, 
                      g_pmdb2_d[l_ac].pmdb017,g_pmdb2_d[l_ac].pmdb018,g_pmdb2_d[l_ac].pmdb019,g_pmdb2_d[l_ac].pmdb020, 
                      g_pmdb2_d[l_ac].pmdb021,g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb035,g_pmdb2_d[l_ac].pmdb036, 
                      g_pmdb2_d[l_ac].pmdb053,g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039, 
                      g_pmdb2_d[l_ac].pmdb054,g_pmdb2_d[l_ac].pmdb041,g_pmdb2_d[l_ac].pmdb042,g_pmdb2_d[l_ac].pmdb043, 
                      g_pmdb2_d[l_ac].pmdb044,g_pmdb2_d[l_ac].pmdb045,g_pmdb2_d[l_ac].pmdb046
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pmdb_d_t.pmdbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmdb_d_mask_o[l_ac].* =  g_pmdb_d[l_ac].*
                  CALL apmt400_pmdb_t_mask()
                  LET g_pmdb_d_mask_n[l_ac].* =  g_pmdb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmt400_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd = 'u' THEN
               LET g_pmdb_d_o.* = g_pmdb_d[l_ac].*
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
            INITIALIZE g_pmdb_d[l_ac].* TO NULL 
            INITIALIZE g_pmdb_d_t.* TO NULL 
            INITIALIZE g_pmdb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_pmdb_d[l_ac].pmdb052 = "0"
      LET g_pmdb_d[l_ac].pmdb006 = "0"
      LET g_pmdb_d[l_ac].pmdb008 = "0"
      LET g_pmdb_d[l_ac].pmdb010 = "0"
      LET g_pmdb_d[l_ac].pmdb032 = "1"
      LET g_pmdb_d[l_ac].pmdb033 = "1"
      LET g_pmdb_d[l_ac].pmdb049 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_pmdb_d_t.* = g_pmdb_d[l_ac].*     #新輸入資料
            LET g_pmdb_d_o.* = g_pmdb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmt400_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            CALL apmt400_set_no_required_b()
            CALL apmt400_set_required_b()
            #end add-point
            CALL apmt400_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmdb_d[li_reproduce_target].* = g_pmdb_d[li_reproduce].*
               LET g_pmdb2_d[li_reproduce_target].* = g_pmdb2_d[li_reproduce].*
 
               LET g_pmdb_d[li_reproduce_target].pmdbseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            #160505-00003#1--mark---begin----
            ##130802-00004#158--add---begin---
            #SELECT COUNT(*) INTO l_n FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno  
            #IF l_n = 0 OR cl_null(l_n) THEN
            #   CALL s_transaction_begin()
            #   IF apmt400_01(g_pmda_m.pmdadocno) THEN
            #      CALL apmt400_b_fill()
            #      LET g_rec_b = g_pmdb_d.getLength()
            #      IF g_rec_b > l_n THEN
            #         CALL s_transaction_end('Y','0')
            #         LET g_flag = TRUE
            #         EXIT DIALOG
            #      ELSE
            #         CALL s_transaction_end('N','0')
            #         LET g_flag = FALSE
            #         NEXT FIELD pmdb004
            #      END IF
            #   ELSE
            #      CALL s_transaction_end('N','0')
            #      LET g_flag = FALSE
            #      NEXT FIELD pmdb004
            #   END IF
            #END IF
            ##130802-00004#158--add---end---
            #160505-00003#1--mark---end---
            
            SELECT MAX(pmdbseq)+1 INTO g_pmdb_d[l_ac].pmdbseq FROM pmdb_t
              WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
            IF cl_null(g_pmdb_d[l_ac].pmdbseq) OR g_pmdb_d[l_ac].pmdbseq = 0 THEN
               LET g_pmdb_d[l_ac].pmdbseq = 1
            END IF
            #第二單身的項次編號等欄位賦值
            LET g_pmdb2_d[l_ac].pmdbseq = g_pmdb_d[l_ac].pmdbseq
            
            LET g_pmdb_d[l_ac].pmdbsite = g_site
            #LET g_pmdb_d[l_ac].pmdb005 = ' '
            
            LET g_pmdb2_d[l_ac].pmdb037 = g_site
            CALL apmt400_pmdb037_ref(g_pmdb2_d[l_ac].pmdb037) RETURNING g_pmdb2_d[l_ac].pmdb037_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb037_desc
            
            LET g_pmdb2_d[l_ac].pmdb014 = "1"
            LET g_pmdb2_d[l_ac].pmdb019 = "0"
            LET g_pmdb2_d[l_ac].pmdb041 = "Y"
            LET g_pmdb2_d[l_ac].pmdb042 = "Y"
            LET g_pmdb2_d[l_ac].pmdb043 = "N"
            LET g_pmdb2_d[l_ac].pmdb044 = "Y"
            LET g_pmdb2_d[l_ac].pmdb045 = "Y"
            
            ##在新增訂單單身時，若已經有上一筆資料時，則需求日期、收貨時段、理由碼、庫位、儲位等欄位則預設上一筆資料
            #LET l_seq = g_pmdb_d[l_ac].pmdbseq -1
            #IF l_seq > 0 THEN
            #   SELECT pmdb030,pmdb048,pmdb031,pmdb038,pmdb039 
            #       INTO g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb031,g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039
            #      FROM pmdb_t WHERE pmdbent= g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno AND pmdbseq = l_seq
            #      
            #   #LET g_pmdb_d[l_ac].pmdb030 = g_pmdb_d[l_seq-1].pmdb030
            #   #LET g_pmdb_d[l_ac].pmdb048 = g_pmdb_d[l_seq-1].pmdb048
            #   #LET g_pmdb_d[l_ac].pmdb031 = g_pmdb_d[l_seq-1].pmdb031
            #   #LET g_pmdb2_d[l_ac].pmdb038 = g_pmdb2_d[l_seq-1].pmdb038
            #   #LET g_pmdb2_d[l_ac].pmdb039 = g_pmdb2_d[l_seq-1].pmdb039
            #   
            #   CALL apmt400_pmdb031_ref(g_pmdb_d[l_ac].pmdb031) RETURNING g_pmdb_d[l_ac].pmdb031_desc
            #   DISPLAY BY NAME g_pmdb_d[l_ac].pmdb031_desc
            #
            #   CALL apmt400_pmdb038_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038) RETURNING g_pmdb2_d[l_ac].pmdb038_desc
            #   DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb038_desc
            #   
            #   CALL apmt400_pmdb039_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039) RETURNING g_pmdb2_d[l_ac].pmdb039_desc
            #   DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb039_desc
            #END IF
            #dorislai-20150824-add----(S)
            #預帶預設庫位的值，aooi200抓值優先順序：預設欄位>應用參數
            IF cl_null(g_pmdb2_d[l_ac].pmdb038) THEN
               #預設欄位
               CALL s_aooi200_get_slip(g_pmda_m.pmdadocno) RETURNING l_success,l_slip
               IF l_success THEN
                  CALL s_aooi200_get_doc_default(g_site,'1',l_slip,'pmdb038',g_pmdb2_d[l_ac].pmdb038) RETURNING g_pmdb2_d[l_ac].pmdb038
                  #應用參數
                  IF cl_null(g_pmdb2_d[l_ac].pmdb038) THEN
                     CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0076') RETURNING g_pmdb2_d[l_ac].pmdb038
                  END IF
               END IF          
            END IF
            #dorislai-20150824-add----(E)
            CALL apmt400_pmdb_init()   #單身欄位初始化
            
            LET g_pmdb_d_t.* = g_pmdb_d[l_ac].*
            LET g_pmdb_d_o.* = g_pmdb_d[l_ac].*
            
            #160505-00003#1--add---begin----
            #130802-00004#158--add---begin---
            SELECT COUNT(*) INTO l_n FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno  
            IF l_n = 0 OR cl_null(l_n) THEN
               CALL s_transaction_begin()
               IF apmt400_01(g_pmda_m.pmdadocno) THEN
                  #CALL apmt400_b_fill()         #161205-00025#1
                  #LET g_rec_b = g_pmdb_d.getLength()  #161205-00025#1
                  #160731-00042#1---s
                  LET l_n = 0 
                  SELECT COUNT(1) INTO l_n FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
                  IF l_n > 0 THEN
                  #IF g_rec_b > l_n THEN
                  #160731-00042#1---e
                     CALL s_transaction_end('Y','0')
                     LET g_flag = TRUE
                     EXIT DIALOG
                  ELSE
                     CALL s_transaction_end('N','0')
                     LET g_flag = FALSE
                     NEXT FIELD pmdb004
                  END IF
               ELSE
                  CALL s_transaction_end('N','0')
                  LET g_flag = FALSE
                  NEXT FIELD pmdb004
               END IF
            END IF
            #130802-00004#158--add---end---
            #160505-00003#1--add---end---
            
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
            SELECT COUNT(1) INTO l_count FROM pmdb_t 
             WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
 
               AND pmdbseq = g_pmdb_d[l_ac].pmdbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               #整體參數未使用採購計價單位,則賦值當前的採購單位和數量
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" THEN  
                  LET g_pmdb_d[l_ac].pmdb011 = g_pmdb_d[l_ac].pmdb007
                  LET g_pmdb_d[l_ac].pmdb010 = g_pmdb_d[l_ac].pmdb006
               END IF
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmda_m.pmdadocno
               LET gs_keys[2] = g_pmdb_d[g_detail_idx].pmdbseq
               CALL apmt400_insert_b('pmdb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #161031-00025#8---s
               IF NOT cl_null(g_pmdb_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,'','','','','','','','1',g_pmdb_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#8---e
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_pmdb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmt400_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #將其他產品特徵資料寫入DB,並新增[T:雜項庫存異動庫儲批明細檔]
               LET l_pmdbseq = NULL
               
               INITIALIZE l_pmdb.* TO NULL               
               SELECT pmdbent,pmdbsite,pmdbdocno,pmdb001,pmdb002,pmdb003,pmdb004,pmdb005,pmdb007,pmdb006,
                      pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050,pmdb032,pmdb051,pmdb033,
                      pmdb049,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb034,
                      pmdb035,pmdb036,pmdb037,pmdb038,pmdb039,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb046 
                INTO l_pmdb.pmdbent,l_pmdb.pmdbsite,l_pmdb.pmdbdocno,l_pmdb.pmdb001,l_pmdb.pmdb002, 
                     l_pmdb.pmdb003,l_pmdb.pmdb004,l_pmdb.pmdb005,l_pmdb.pmdb007,l_pmdb.pmdb006,l_pmdb.pmdb009, 
                     l_pmdb.pmdb008,l_pmdb.pmdb011,l_pmdb.pmdb010,l_pmdb.pmdb030,l_pmdb.pmdb048,l_pmdb.pmdb031, 
                     l_pmdb.pmdb050,l_pmdb.pmdb032,l_pmdb.pmdb051,l_pmdb.pmdb033,l_pmdb.pmdb049,l_pmdb.pmdb012, 
                     l_pmdb.pmdb014,l_pmdb.pmdb015,l_pmdb.pmdb016,l_pmdb.pmdb017,l_pmdb.pmdb018,l_pmdb.pmdb019, 
                     l_pmdb.pmdb020,l_pmdb.pmdb021,l_pmdb.pmdb034,l_pmdb.pmdb035,l_pmdb.pmdb036,l_pmdb.pmdb037,
                     l_pmdb.pmdb038,l_pmdb.pmdb039,
                     l_pmdb.pmdb041,l_pmdb.pmdb042,l_pmdb.pmdb043,l_pmdb.pmdb044,l_pmdb.pmdb045,l_pmdb.pmdb046
                 FROM pmdb_t 
                WHERE pmdbent = g_enterprise
                  AND pmdbsite = g_site
                  AND pmdbdocno = g_pmda_m.pmdadocno
                  AND pmdbseq = g_pmdb_d[l_ac].pmdbseq
               
               IF l_inam.getLength() > 1 THEN  #因為第一筆資料已呈現在畫面並寫入DB, 從第二筆開始處理           
                  IF cl_null(l_pmdbseq) THEN   
                     SELECT MAX(pmdbseq) INTO l_pmdbseq
                       FROM pmdb_t
                      WHERE pmdbent   = g_enterprise
                        AND pmdbsite  = g_site
                        AND pmdbdocno = g_pmda_m.pmdadocno                     
                  END IF 
                  
                  FOR l_i = 2 TO l_inam.getLength() 
                     IF cl_null(l_pmdbseq) OR l_pmdbseq = 0 THEN
                        LET l_pmdbseq = 1
                     ELSE
                        LET l_pmdbseq = l_pmdbseq + 1             
                     END IF 

                     #計算參考數量
                     IF (NOT cl_null(l_pmdb.pmdb004)) AND (NOT cl_null(l_pmdb.pmdb009)) AND (NOT cl_null(l_pmdb.pmdb007)) THEN
                        #CALL s_aimi190_get_convert(l_pmdb.pmdb004,l_pmdb.pmdb007,l_pmdb.pmdb009) RETURNING l_success,l_rate
                        #LET l_pmdb.pmdb008 = l_inam[l_i].inam004 * l_rate
                        CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_pmdb.pmdb007,l_pmdb.pmdb009,l_inam[l_i].inam004)
                                  RETURNING l_success,l_pmdb.pmdb008
                        IF NOT cl_null(l_pmdb.pmdb008) THEN
                           CALL apmt400_unit_round(l_pmdb.pmdb011,l_pmdb.pmdb008) RETURNING l_pmdb.pmdb008
                        END IF
                     END IF
               
                     #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
                     #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
                     IF (cl_get_para(g_enterprise,g_site,'S-BAS-0019')) = "Y" AND (NOT cl_null(l_pmdb.pmdb004)) AND (NOT cl_null(l_pmdb.pmdb011)) AND (NOT cl_null(l_pmdb.pmdb007)) THEN  #體參數使用採購計價單位
                        #CALL s_aimi190_get_convert(l_pmdb.pmdb004,l_pmdb.pmdb007,l_pmdb.pmdb011) RETURNING l_success,l_rate
                        #LET l_pmdb.pmdb010 = l_inam[l_i].inam004 * l_rate
                        CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_pmdb.pmdb007,l_pmdb.pmdb011,l_inam[l_i].inam004)
                                  RETURNING l_success,l_pmdb.pmdb010
                        IF NOT cl_null(l_pmdb.pmdb010) THEN
                           CALL apmt400_unit_round(l_pmdb.pmdb011,l_pmdb.pmdb010) RETURNING l_pmdb.pmdb010
                        END IF 
                     END IF
                     IF cl_null(l_pmdb.pmdb011) OR cl_null(l_pmdb.pmdb010) THEN
                        LET l_pmdb.pmdb010 = l_pmdb.pmdb006
                        LET l_pmdb.pmdb011 = l_pmdb.pmdb007
                     END IF
                     
                     INSERT INTO pmdb_t 
                           (pmdbent,pmdbsite,pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb004,pmdb005,pmdb007,pmdb006,
                            pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050,pmdb032,pmdb051,pmdb033,
                            pmdb049,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb034,
                            pmdb035,pmdb036,pmdb037,pmdb038,pmdb039,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb046) 
                          VALUES(l_pmdb.pmdbent,l_pmdb.pmdbsite,l_pmdb.pmdbdocno,l_pmdbseq,l_pmdb.pmdb001,l_pmdb.pmdb002, 
                                 l_pmdb.pmdb003,l_pmdb.pmdb004,l_inam[l_i].inam002,l_pmdb.pmdb007,l_inam[l_i].inam004,l_pmdb.pmdb009, 
                                 l_pmdb.pmdb008,l_pmdb.pmdb011,l_pmdb.pmdb010,l_pmdb.pmdb030,l_pmdb.pmdb048,l_pmdb.pmdb031, 
                                 l_pmdb.pmdb050,l_pmdb.pmdb032,l_pmdb.pmdb051,l_pmdb.pmdb033,l_pmdb.pmdb049,l_pmdb.pmdb012, 
                                 l_pmdb.pmdb014,l_pmdb.pmdb015,l_pmdb.pmdb016,l_pmdb.pmdb017,l_pmdb.pmdb018,l_pmdb.pmdb019, 
                                 l_pmdb.pmdb020,l_pmdb.pmdb021,l_pmdb.pmdb034,l_pmdb.pmdb035,l_pmdb.pmdb036,l_pmdb.pmdb037,
                                 l_pmdb.pmdb038,l_pmdb.pmdb039,
                                 l_pmdb.pmdb041,l_pmdb.pmdb042,l_pmdb.pmdb043,l_pmdb.pmdb044,l_pmdb.pmdb045,l_pmdb.pmdb046) 
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmdb_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()

                     END IF
                     #161031-00025#8---s
                     IF NOT cl_null(g_pmdb_d[l_ac].ooff013) THEN
                        CALL s_aooi360_gen('7',g_prog,g_pmda_m.pmdadocno,l_pmdbseq,'','','','','','','','1',g_pmdb_d[l_ac].ooff013) RETURNING l_success
                     END IF
                     #161031-00025#8---e
                  END FOR
                  CALL apmt400_b_fill()
                  LET g_rec_b = l_inam.getLength() - 1
               END IF
               
               #2015/08/19 by stellar add ----- (S)
               LET l_insert1 = TRUE
               CALL s_aooi200_get_slip(g_pmda_m.pmdadocno) 
                    RETURNING l_success,l_slip
               IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'Y' THEN
                  IF cl_null(g_pmdb2_d[l_ac].pmdb053) THEN
                     NEXT FIELD pmdb053
                  ELSE
                     CALL s_apmt400_stus_abg(g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,'I')
                          RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = l_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        CALL s_transaction_end('N','0')
                     END IF
                     LET l_insert1 = FALSE
                  END IF
               END IF
               #2015/08/19 by stellar add ----- (E)
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
               #2015/08/20 by stellar add ----- (S)
               CALL s_apmt400_stus_abg(g_pmda_m.pmdadocno,g_pmdb_d_t.pmdbseq,'D')
                    RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CLOSE apmt400_bcl
                  CANCEL DELETE
               END IF
               #2015/08/20 by stellar add ----- (E)
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_pmda_m.pmdadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_pmdb_d_t.pmdbseq
 
            
               #刪除同層單身
               IF NOT apmt400_delete_b('pmdb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt400_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmt400_key_delete_b(gs_keys,'pmdb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt400_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #160920-00035#1---s
               DECLARE aps_upd2 CURSOR FOR 
                 SELECT DISTINCT pspcsite,pspc001,pspc002,pspc004,pspc061 FROM pspc_t
                   WHERE pspcent = g_enterprise AND pspc004 = g_pmdb_d[l_ac].pmdb001 
                     AND pspc050 = g_pmdb_d[l_ac].pmdb004 AND pspc051 = g_pmdb_d[l_ac].pmdb005
                     AND pspc055 = g_pmda_m.pmdadocno AND pspc056 = g_pmdb_d[l_ac].pmdbseq
               FOREACH aps_upd2 INTO l_pspcsite,l_pspc001,l_pspc002,l_pspc004,l_pspc061
                  IF l_pspc061 > g_pmdb_d[l_ac].pmdb006 THEN
                     UPDATE pspc_t SET pspc061 = pspc061 - g_pmdb_d[l_ac].pmdb006
                        WHERE pspcent = g_enterprise AND pspcsite = l_pspcsite AND pspc001 = l_pspc001
                          AND pspc004 = l_pspc004
                  ELSE
                     UPDATE pspc_t SET pspc055 = '',
                                       pspc056 = '',
                                       pspc061 = 0
                        WHERE pspcent = g_enterprise AND pspcsite = l_pspcsite AND pspc001 = l_pspc001
                          AND pspc004 = l_pspc004
                  END IF
               END FOREACH
               #160920-00035#1--e
               #161031-00025#8---s
               CALL s_aooi360_del('7',g_prog,g_pmda_m.pmdadocno,g_pmdb_d_t.pmdbseq,'','','','','','','','1') RETURNING l_success
               #161031-00025#8---e    
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apmt400_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_pmdb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmdb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdbsite
            #add-point:BEFORE FIELD pmdbsite name="input.b.page1.pmdbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdbsite
            
            #add-point:AFTER FIELD pmdbsite name="input.a.page1.pmdbsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdbsite
            #add-point:ON CHANGE pmdbsite name="input.g.page1.pmdbsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdbseq
            #add-point:BEFORE FIELD pmdbseq name="input.b.page1.pmdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdbseq
            
            #add-point:AFTER FIELD pmdbseq name="input.a.page1.pmdbseq"
            #此段落由子樣板a05產生
            IF  g_pmda_m.pmdadocno IS NOT NULL AND g_pmdb_d[l_ac].pmdbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmda_m.pmdadocno != g_pmdadocno_t OR g_pmdb_d[l_ac].pmdbseq != g_pmdb_d_t.pmdbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdb_t WHERE "||"pmdbent = '" ||g_enterprise|| "' AND "||"pmdbdocno = '"||g_pmda_m.pmdadocno ||"' AND "|| "pmdbseq = '"||g_pmdb_d[l_ac].pmdbseq ||"'",'std-00004',0) THEN 
                     LET g_pmdb_d[l_ac].pmdbseq = g_pmdb_d_t.pmdbseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #第二單身的項次編號等欄位賦值
            LET g_pmdb2_d[l_ac].pmdbseq = g_pmdb_d[l_ac].pmdbseq
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdbseq
            #add-point:ON CHANGE pmdbseq name="input.g.page1.pmdbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb001
            #add-point:BEFORE FIELD pmdb001 name="input.b.page1.pmdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb001
            
            #add-point:AFTER FIELD pmdb001 name="input.a.page1.pmdb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb001
            #add-point:ON CHANGE pmdb001 name="input.g.page1.pmdb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb002
            #add-point:BEFORE FIELD pmdb002 name="input.b.page1.pmdb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb002
            
            #add-point:AFTER FIELD pmdb002 name="input.a.page1.pmdb002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb002
            #add-point:ON CHANGE pmdb002 name="input.g.page1.pmdb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb003
            #add-point:BEFORE FIELD pmdb003 name="input.b.page1.pmdb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb003
            
            #add-point:AFTER FIELD pmdb003 name="input.a.page1.pmdb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb003
            #add-point:ON CHANGE pmdb003 name="input.g.page1.pmdb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb052
            #add-point:BEFORE FIELD pmdb052 name="input.b.page1.pmdb052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb052
            
            #add-point:AFTER FIELD pmdb052 name="input.a.page1.pmdb052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb052
            #add-point:ON CHANGE pmdb052 name="input.g.page1.pmdb052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb004
            
            #add-point:AFTER FIELD pmdb004 name="input.a.page1.pmdb004"
            CALL apmt400_pmdb004_ref(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb004 != g_pmdb_d_o.pmdb004 OR cl_null(g_pmdb_d_o.pmdb004))) THEN                  
                  IF NOT apmt400_pmdb004_chk(g_pmdb_d[l_ac].pmdb004) THEN
                     LET g_pmdb_d[l_ac].pmdb004 = g_pmdb_d_o.pmdb004
                     CALL apmt400_pmdb004_ref(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004
                     DISPLAY BY NAME g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004
                     NEXT FIELD CURRENT    
                  ELSE
                     LET l_imaa005 = ''
                     CALL apmt400_get_imaa005(g_enterprise,g_pmdb_d[l_ac].pmdb004) RETURNING l_imaa005
                     IF cl_null(l_imaa005) THEN
                        LET g_pmdb_d[l_ac].pmdb005 = ' '  #產品特徵
                     ELSE
                        LET g_pmdb_d[l_ac].pmdb005 = ''  #產品特徵
                     END IF
                     
                     #採購單位、參考單位、收貨時段、慣用包裝容器
                     LET g_pmdb_d[l_ac].pmdb007 = ''
                     LET g_pmdb_d[l_ac].pmdb009 = ''
                     LET g_pmdb_d[l_ac].pmdb048 = ''
                     LET g_pmdb2_d[l_ac].pmdb012 = ''
                     SELECT imaf143,imaf015,imaf176,imaf157 INTO g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb048,g_pmdb2_d[l_ac].pmdb012
                        FROM imaf_t
                        WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdb_d[l_ac].pmdb004
                        
                     ##在新增訂單單身時，若已經有上一筆資料時，則需求日期、收貨時段、理由碼、庫位、儲位等欄位則預設上一筆資料
                     #IF l_cmd = 'a' AND l_ac > 1 AND cl_null(g_pmdb_d[l_ac].pmdb048) THEN
                     #   LET g_pmdb_d[l_ac].pmdb048 = g_pmdb_d[l_seq-1].pmdb048
                     #END IF
                    
                     CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc
                     CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb009) RETURNING g_pmdb_d[l_ac].pmdb009_desc
                     CALL apmt400_pmdb048_ref(g_pmdb_d[l_ac].pmdb048) RETURNING g_pmdb_d[l_ac].pmdb048_desc
                     CALL apmt400_pmdb012_ref(g_pmdb2_d[l_ac].pmdb012) RETURNING g_pmdb2_d[l_ac].pmdb012_desc
                     DISPLAY BY NAME g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb048,g_pmdb2_d[l_ac].pmdb012,
                                     g_pmdb_d[l_ac].pmdb007_desc,g_pmdb_d[l_ac].pmdb009_desc,g_pmdb_d[l_ac].pmdb048_desc,g_pmdb2_d[l_ac].pmdb012_desc
                     
                     IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
                        SELECT imaf144 INTO g_pmdb_d[l_ac].pmdb011 FROM imaf_t
                           WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdb_d[l_ac].pmdb004
                        CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb011) RETURNING g_pmdb_d[l_ac].pmdb011_desc
                        DISPLAY BY NAME g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb011_desc                        
                     END IF
                    
                  END IF
               END IF
            END IF
            LET g_pmdb_d_o.pmdb004 = g_pmdb_d[l_ac].pmdb004
            
            CALL apmt400_set_entry_b(l_cmd)
            CALL apmt400_set_no_required_b()
            CALL apmt400_set_required_b()
            CALL apmt400_set_no_entry_b(l_cmd)
            
            #第二單身的料件編號等欄位賦值
            LET g_pmdb2_d[l_ac].imaal001 = g_pmdb_d[l_ac].pmdb004
            LET g_pmdb2_d[l_ac].imaal003 = g_pmdb_d[l_ac].pmdb004_desc
            LET g_pmdb2_d[l_ac].imaal004 = g_pmdb_d[l_ac].imaal004
            
            #160314-00009#3   marked by zhujing 2016-3-16-----(S)
#            LET l_imaa005 = ''
#            CALL apmt400_get_imaa005(g_enterprise,g_pmdb_d[l_ac].pmdb004) RETURNING l_imaa005#               
            CALL l_inam.clear()     
#            IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' AND NOT cl_null(l_imaa005) THEN
            #160314-00009#3   marked by zhujing 2016-3-16-----(E)
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' AND s_feature_auto_chk(g_pmdb_d[l_ac].pmdb004) AND cl_null(g_pmdb_d[l_ac].pmdb005) THEN  #160314-00009#3   mod by zhujing 2016-3-16
            
               IF l_cmd = 'a' THEN            
                  #CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_pmdb_d[l_ac].pmdb004,'','',g_site,g_pmda_m.pmdadocno) RETURNING l_success,l_inam
                  LET g_pmdb_d[l_ac].pmdb005 = l_inam[1].inam002
                  LET g_pmdb_d[l_ac].pmdb006 = l_inam[1].inam004
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb006
                  
                  #計算參考數量
                  IF (NOT cl_null(g_pmdb_d[l_ac].pmdb004)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb009)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb007)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb006)) THEN
                     #CALL s_aimi190_get_convert(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009) RETURNING l_success,l_rate
                     #LET g_pmdb_d[l_ac].pmdb008 = g_pmdb_d[l_ac].pmdb006 * l_rate
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb006)
                          RETURNING l_success,g_pmdb_d[l_ac].pmdb008
                     IF NOT cl_null(g_pmdb_d[l_ac].pmdb008) THEN
                        CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb008) RETURNING g_pmdb_d[l_ac].pmdb008
                     END IF
                  END IF
               
                  #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
                  #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
                  IF (cl_get_para(g_enterprise,g_site,'S-BAS-0019')) = "Y" AND (NOT cl_null(g_pmdb_d[l_ac].pmdb004)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb011)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb007)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb006)) THEN  #體參數使用採購計價單位
                     #CALL s_aimi190_get_convert(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb011) RETURNING l_success,l_rate
                     #LET g_pmdb_d[l_ac].pmdb010 = g_pmdb_d[l_ac].pmdb006 * l_rate
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb006)
                          RETURNING l_success,g_pmdb_d[l_ac].pmdb010
                     IF NOT cl_null(g_pmdb_d[l_ac].pmdb010) THEN
                        CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb010) RETURNING g_pmdb_d[l_ac].pmdb010
                     END IF 
                  END IF
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb008,g_pmdb_d[l_ac].pmdb010
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb004
            #add-point:BEFORE FIELD pmdb004 name="input.b.page1.pmdb004"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb004
            #add-point:ON CHANGE pmdb004 name="input.g.page1.pmdb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb005
            
            #add-point:AFTER FIELD pmdb005 name="input.a.page1.pmdb005"
            CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005_desc 
            IF g_pmdb_d[l_ac].pmdb005 IS NOT NULL THEN
               IF NOT s_feature_check(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) THEN
                  LET g_pmdb_d[l_ac].pmdb005 = g_pmdb_d_t.pmdb005
                  CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005_desc
                  NEXT FIELD CURRENT
               END IF
               #151224-00025#2--add--start--
               IF NOT s_feature_direct_input(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d_t.pmdb005,g_pmda_m.pmdadocno,g_pmda_m.pmdasite) THEN
                  NEXT FIELD CURRENT
               END IF 
               #151224-00025#2--add--end----
               #檢核料件AVL控管點(imaa044)設置
               IF NOT s_apmt400_item_avl_chk(g_pmda_m.pmdadocdt,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb2_d[l_ac].pmdb015,g_pmdb_d[l_ac].pmdb006) THEN  #add by lixiang 2015/10/15 pmdb006
                  LET g_pmdb_d[l_ac].pmdb005 = g_pmdb_d_t.pmdb005
                  CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005_desc
                  NEXT FIELD CURRENT
               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb005
            #add-point:BEFORE FIELD pmdb005 name="input.b.page1.pmdb005"
            #160314-00009#3   add by zhujing 2016-3-16-----(S)
#            IF NOT cl_null(g_pmdb_d[l_ac].pmdb004) AND cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN
#               IF s_feature_auto_chk(g_pmdb_d[l_ac].pmdb004) AND cl_null(g_pmdb_d[l_ac].pmdb005) THEN
#                  CALL s_feature_single(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_site,'') RETURNING l_success,g_pmdb_d[l_ac].pmdb005
#                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005
#                  CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) 
#                     RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
#               END IF
#            END IF
            #160314-00009#3   add by zhujing 2016-3-16-----(E)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb005
            #add-point:ON CHANGE pmdb005 name="input.g.page1.pmdb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb007
            
            #add-point:AFTER FIELD pmdb007 name="input.a.page1.pmdb007"
            CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb007_desc
            
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb007) THEN 
               IF NOT apmt400_unit_chk(g_pmdb_d[l_ac].pmdb007) THEN
                  LET g_pmdb_d[l_ac].pmdb007 = g_pmdb_d_t.pmdb007
                  CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb007_desc
                  NEXT FIELD CURRENT
               ELSE
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb006) THEN
                     CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb006) RETURNING g_pmdb_d[l_ac].pmdb006
                     DISPLAY BY NAME g_pmdb_d[l_ac].pmdb006
                     
                     #計算參考數量
                     IF NOT cl_null(g_pmdb_d[l_ac].pmdb009) THEN
                        #CALL s_aimi190_get_convert(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009) RETURNING l_success,l_rate
                        #LET g_pmdb_d[l_ac].pmdb008 = g_pmdb_d[l_ac].pmdb006 * l_rate
                        CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb006)
                          RETURNING l_success,g_pmdb_d[l_ac].pmdb008
                        IF NOT cl_null(g_pmdb_d[l_ac].pmdb008) THEN
                           CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb008) RETURNING g_pmdb_d[l_ac].pmdb008
                           DISPLAY BY NAME g_pmdb_d[l_ac].pmdb008
                        END IF
                     END IF
               
                     #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
                     #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
                     IF (cl_get_para(g_enterprise,g_site,'S-BAS-0019')) = "Y" AND (NOT cl_null(g_pmdb_d[l_ac].pmdb011)) AND (NOT cl_null(g_imaf144)) THEN  #體參數使用採購計價單位
                        #CALL s_aimi190_get_convert(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb011) RETURNING l_success,l_rate
                        #LET g_pmdb_d[l_ac].pmdb010 = g_pmdb_d[l_ac].pmdb006 * l_rate
                        CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb006)
                          RETURNING l_success,g_pmdb_d[l_ac].pmdb010
                        IF NOT cl_null(g_pmdb_d[l_ac].pmdb010) THEN
                           CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb010) RETURNING g_pmdb_d[l_ac].pmdb010
                           DISPLAY BY NAME g_pmdb_d[l_ac].pmdb010
                        END IF 
                     ELSE
                        LET g_pmdb_d[l_ac].pmdb010 = g_pmdb_d[l_ac].pmdb006
                        LET g_pmdb_d[l_ac].pmdb011 = g_pmdb_d[l_ac].pmdb007
                     END IF
                     
                     IF l_cmd = 'u' OR (g_pmdb_d[l_ac].pmdb006 <> 0 AND NOT cl_null(g_pmdb_d_o.pmdb006)) THEN  #150505 by whitney 150504-00013#6 add
                        CALL apmt400_pmdb006_chk()
                     END IF  #150505 by whitney 150504-00013#6 add
                  END IF                     
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb007
            #add-point:BEFORE FIELD pmdb007 name="input.b.page1.pmdb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb007
            #add-point:ON CHANGE pmdb007 name="input.g.page1.pmdb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdb_d[l_ac].pmdb006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdb006
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdb006 name="input.a.page1.pmdb006"
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb006) THEN 
               IF NOT cl_null(g_pmdb_d[l_ac].pmdb007) THEN
                  CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb006) RETURNING g_pmdb_d[l_ac].pmdb006
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb006
                  
                  #add by lixiang 2015/10/15---begin----
                  #檢核料件AVL控管點(imaa044)設置
                  IF NOT s_apmt400_item_avl_chk(g_pmda_m.pmdadocdt,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb2_d[l_ac].pmdb015,g_pmdb_d[l_ac].pmdb006) THEN
                     LET g_pmdb_d[l_ac].pmdb006 = g_pmdb_d_t.pmdb006
                     NEXT FIELD CURRENT
                  END IF
                  #add by lixiang 2015/10/15---end----
                  #160727-00025#9--s
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb001) THEN
                     #判断单据来源,通过oobx003单据性质来判断
                     CALL s_aooi200_get_slip(g_pmdb_d[l_ac].pmdb001) RETURNING l_flag,l_slip
                     LET l_oobx003 = ''
                     SELECT oobx003 INTO l_oobx003 FROM oobx_t
                         WHERE oobxent = g_enterprise AND oobx001 = l_slip
                     CASE l_oobx003
                        WHEN "axmt500"
                     #160727-00025#9--e
                           #--151210-00002#1--polly--add--(s)
                           #如來源為訂單，需控卡不可大於訂購量
                           IF NOT apmt400_order_chk() THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'apm-01056'
                              LET g_errparam.extend = g_pmda_m.pmdadocno
                              LET g_errparam.popup = TRUE
                              CALL cl_err()              
                              LET g_pmdb_d[l_ac].pmdb006 = g_pmdb_d_t.pmdb006
                              NEXT FIELD CURRENT                  
                           END IF
                           #--151210-00002#1--polly--add--(e)
                  #160727-00025#9--s
                        WHEN "asft300"
                           #来源是工单時，須檢核不可超過工單總應發數量
                           IF NOT apmt400_work_order_chk() THEN     
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'apm-01125'
                              LET g_errparam.extend = g_pmda_m.pmdadocno
                              LET g_errparam.popup = TRUE
                              CALL cl_err()                                
                              LET g_pmdb_d[l_ac].pmdb006 = g_pmdb_d_t.pmdb006
                              NEXT FIELD CURRENT                  
                           END IF
                        WHEN "asft304"
                           #来源是工单時，須檢核不可超過工單總應發數量
                           IF NOT apmt400_work_order_chk() THEN     
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'apm-01125'
                              LET g_errparam.extend = g_pmda_m.pmdadocno
                              LET g_errparam.popup = TRUE
                              CALL cl_err()                                
                              LET g_pmdb_d[l_ac].pmdb006 = g_pmdb_d_t.pmdb006
                              NEXT FIELD CURRENT                  
                           END IF
                     END CASE
                  END IF
                  #160727-00025#9--e
                  
                  #計算參考數量
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb009) THEN
                     #CALL s_aimi190_get_convert(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009) RETURNING l_success,l_rate
                     #LET g_pmdb_d[l_ac].pmdb008 = g_pmdb_d[l_ac].pmdb006 * l_rate
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb006)
                          RETURNING l_success,g_pmdb_d[l_ac].pmdb008
                     IF NOT cl_null(g_pmdb_d[l_ac].pmdb008) THEN
                        CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb008) RETURNING g_pmdb_d[l_ac].pmdb008
                        DISPLAY BY NAME g_pmdb_d[l_ac].pmdb008
                     END IF
                  END IF
                  
                  #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
                  #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
                  IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" AND (NOT cl_null(g_pmdb_d[l_ac].pmdb011)) AND (NOT cl_null(g_imaf144)) THEN  #體參數使用採購計價單位
                     #CALL s_aimi190_get_convert(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb011) RETURNING l_success,l_rate
                     #LET g_pmdb_d[l_ac].pmdb010 = g_pmdb_d[l_ac].pmdb006 * l_rate
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb006)
                          RETURNING l_success,g_pmdb_d[l_ac].pmdb010
                     IF NOT cl_null(g_pmdb_d[l_ac].pmdb010) THEN
                        CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb010) RETURNING g_pmdb_d[l_ac].pmdb010
                        DISPLAY BY NAME g_pmdb_d[l_ac].pmdb010
                     END IF
                  ELSE
                     LET g_pmdb_d[l_ac].pmdb010 = g_pmdb_d[l_ac].pmdb006
                     LET g_pmdb_d[l_ac].pmdb011 = g_pmdb_d[l_ac].pmdb007
                  END IF
                  
                  IF (NOT cl_null(g_pmda_m.pmda010)) AND (NOT cl_null(g_pmdb2_d[l_ac].pmdb019)) THEN
                     #計算未稅金額、含稅金額
                     CALL apmt400_get_amount(g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb006,g_pmdb2_d[l_ac].pmdb019,g_pmda_m.pmda010)
                       RETURNING g_pmdb2_d[l_ac].pmdb020,g_pmdb2_d[l_ac].pmdb021
                     DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb020,g_pmdb2_d[l_ac].pmdb021
                     
                     #2015/08/19 by stellar add ----- (S)
                     CALL apmt400_detail_abg('4')
                          RETURNING l_success,l_errno,l_bgaf016,l_pmdb053,l_pmdb053_desc
                     IF NOT l_success THEN
                        CASE l_errno
                           WHEN 'abg-00103'
                                CASE l_bgaf016
                                   WHEN '1'
                                   WHEN '2'
                                        INITIALIZE g_errparam TO NULL
                                        LET g_errparam.code = l_errno
                                        LET g_errparam.extend = ''
                                        LET g_errparam.popup = TRUE
                                        CALL cl_err()
                                   WHEN '3'
                                        INITIALIZE g_errparam TO NULL
                                        LET g_errparam.code = l_errno
                                        LET g_errparam.extend = ''
                                        LET g_errparam.popup = TRUE
                                        CALL cl_err()
                                        NEXT FIELD CURRENT
                                END CASE
                           WHEN 'abg-00104'
                                INITIALIZE g_errparam TO NULL
                                LET g_errparam.code = l_errno
                                LET g_errparam.extend = ''
                                LET g_errparam.popup = TRUE
                                CALL cl_err()
                           OTHERWISE
                                INITIALIZE g_errparam TO NULL
                                LET g_errparam.code = l_errno
                                LET g_errparam.extend = ''
                                LET g_errparam.popup = TRUE
                                CALL cl_err()
                                NEXT FIELD CURRENT
                        END CASE
                     END IF
                     #2015/08/19 by stellar add ----- (E) 
                  END IF
                  
                  CALL apmt400_pmdb006_chk()                  
               END IF
               #LET g_pmdb_d_t.pmdb006 = g_pmdb_d[l_ac].pmdb006   #160920-00035#1
               LET g_pmdb_d_o.pmdb006 = g_pmdb_d[l_ac].pmdb006   #160920-00035#1
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb006
            #add-point:BEFORE FIELD pmdb006 name="input.b.page1.pmdb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb006
            #add-point:ON CHANGE pmdb006 name="input.g.page1.pmdb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb009
            
            #add-point:AFTER FIELD pmdb009 name="input.a.page1.pmdb009"
            CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb009) RETURNING g_pmdb_d[l_ac].pmdb009_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb009_desc
            
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb009) THEN 
               IF NOT apmt400_unit_chk(g_pmdb_d[l_ac].pmdb009) THEN
                  LET g_pmdb_d[l_ac].pmdb009 = g_pmdb_d_t.pmdb009
                  CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb009) RETURNING g_pmdb_d[l_ac].pmdb009_desc
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb009_desc
                  NEXT FIELD CURRENT
               ELSE
                  IF (NOT cl_null(g_pmdb_d[l_ac].pmdb006)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb007)) THEN
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb006)
                          RETURNING l_success,g_pmdb_d[l_ac].pmdb008
                  END IF
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb008) THEN
                     CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb008) RETURNING g_pmdb_d[l_ac].pmdb008
                     DISPLAY BY NAME g_pmdb_d[l_ac].pmdb008
                  END IF                     
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb009
            #add-point:BEFORE FIELD pmdb009 name="input.b.page1.pmdb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb009
            #add-point:ON CHANGE pmdb009 name="input.g.page1.pmdb009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdb_d[l_ac].pmdb008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmdb008
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdb008 name="input.a.page1.pmdb008"
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb008) THEN 
               IF NOT cl_null(g_pmdb_d[l_ac].pmdb009) THEN
                  CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb008) RETURNING g_pmdb_d[l_ac].pmdb008
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb008
               END IF 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb008
            #add-point:BEFORE FIELD pmdb008 name="input.b.page1.pmdb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb008
            #add-point:ON CHANGE pmdb008 name="input.g.page1.pmdb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb011
            
            #add-point:AFTER FIELD pmdb011 name="input.a.page1.pmdb011"
            CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb011) RETURNING g_pmdb_d[l_ac].pmdb011_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb011_desc
            
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb011) THEN 
               IF NOT apmt400_unit_chk(g_pmdb_d[l_ac].pmdb011) THEN
                  LET g_pmdb_d[l_ac].pmdb011 = g_pmdb_d_t.pmdb011
                  CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb011) RETURNING g_pmdb_d[l_ac].pmdb011_desc
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb011_desc
                  NEXT FIELD CURRENT
               ELSE
                  IF (NOT cl_null(g_pmdb_d[l_ac].pmdb006)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb007)) THEN
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb006)
                          RETURNING l_success,g_pmdb_d[l_ac].pmdb010
                  END IF
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb010) THEN
                     CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb010) RETURNING g_pmdb_d[l_ac].pmdb010
                     DISPLAY BY NAME g_pmdb_d[l_ac].pmdb010
                  END IF                     
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb011
            #add-point:BEFORE FIELD pmdb011 name="input.b.page1.pmdb011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb011
            #add-point:ON CHANGE pmdb011 name="input.g.page1.pmdb011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdb_d[l_ac].pmdb010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmdb010
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdb010 name="input.a.page1.pmdb010"
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb010) THEN 
               IF NOT cl_null(g_pmdb_d[l_ac].pmdb011) THEN
                  CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb010) RETURNING g_pmdb_d[l_ac].pmdb010
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb010
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb010
            #add-point:BEFORE FIELD pmdb010 name="input.b.page1.pmdb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb010
            #add-point:ON CHANGE pmdb010 name="input.g.page1.pmdb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb030
            #add-point:BEFORE FIELD pmdb030 name="input.b.page1.pmdb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb030
            
            #add-point:AFTER FIELD pmdb030 name="input.a.page1.pmdb030"
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb030) THEN
               LET l_imaf171 = 0
               LET l_imaf172 = 0
               LET l_imaf173 = 0
               LET l_imaf174 = 0
               LET l_imaf175 = 0
               LET l_time1 = 0
               LET l_time2 = 0
               
               SELECT imaf171,imaf172,imaf173,imaf174,imaf175 INTO l_imaf171,l_imaf172,l_imaf173,l_imaf174,l_imaf175
                 FROM imaf_t 
                 WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdb_d[l_ac].pmdb004
               LET l_time1 = g_pmdb_d[l_ac].pmdb030 - g_today         #需求日期 - g_today
               LET l_time2 = l_imaf171+l_imaf172+l_imaf173+l_imaf174  #[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數
               
               #1.若輸入的需求日期 - g_today >[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數時，則[C:緊急度] = '1'(一般)
               IF l_time1 >= l_time2 THEN
                  LET g_pmdb_d[l_ac].pmdb033 = '1'
               END IF
               
               #2.若輸入的需求日期 - g_today <[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數，
               #   且需求日期 - g_today >[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '2'(緊急)
               IF l_time1 < l_time2 AND l_time1 >= l_imaf175 THEN
                  LET g_pmdb_d[l_ac].pmdb033 = '2'
               END IF
               
               #3.若輸入的需求日期 - g_today <[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '3'(特急)
               IF l_time1 < l_imaf175 THEN
                  LET g_pmdb_d[l_ac].pmdb033 = '3'
               END IF
               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb030
            #add-point:ON CHANGE pmdb030 name="input.g.page1.pmdb030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb048
            
            #add-point:AFTER FIELD pmdb048 name="input.a.page1.pmdb048"
            CALL apmt400_pmdb048_ref(g_pmdb_d[l_ac].pmdb048) RETURNING g_pmdb_d[l_ac].pmdb048_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb048_desc
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb048) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdb_d[l_ac].pmdb048

                #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="apm-00233:sub-01302|aooi715|",cl_get_progname("aooi715",g_lang,"2"),"|:EXEPROGaooi715"
               LET g_chkparam.err_str[2] ="apm-00232:sub-01303|aooi715|",cl_get_progname("aooi715",g_lang,"2"),"|:EXEPROGaooi715"
               #160318-00025#16 by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_274") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pmdb_d[l_ac].pmdb048 = g_pmdb_d_t.pmdb048
                  CALL apmt400_pmdb048_ref(g_pmdb_d[l_ac].pmdb048) RETURNING g_pmdb_d[l_ac].pmdb048_desc
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb048_desc
                  NEXT FIELD CURRENT
               END IF       
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb048
            #add-point:BEFORE FIELD pmdb048 name="input.b.page1.pmdb048"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb048
            #add-point:ON CHANGE pmdb048 name="input.g.page1.pmdb048"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb031
            
            #add-point:AFTER FIELD pmdb031 name="input.a.page1.pmdb031"
            CALL apmt400_pmdb031_ref(g_pmdb_d[l_ac].pmdb031) RETURNING g_pmdb_d[l_ac].pmdb031_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb031_desc
            
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb031) THEN
               IF NOT apmt400_pmdb031_chk(g_pmdb_d[l_ac].pmdb031) THEN
                  LET g_pmdb_d[l_ac].pmdb031 = g_pmdb_d_t.pmdb031
                  CALL apmt400_pmdb031_ref(g_pmdb_d[l_ac].pmdb031) RETURNING g_pmdb_d[l_ac].pmdb031_desc
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb031_desc
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb031
            #add-point:BEFORE FIELD pmdb031 name="input.b.page1.pmdb031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb031
            #add-point:ON CHANGE pmdb031 name="input.g.page1.pmdb031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb050
            #add-point:BEFORE FIELD pmdb050 name="input.b.page1.pmdb050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb050
            
            #add-point:AFTER FIELD pmdb050 name="input.a.page1.pmdb050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb050
            #add-point:ON CHANGE pmdb050 name="input.g.page1.pmdb050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb032
            #add-point:BEFORE FIELD pmdb032 name="input.b.page1.pmdb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb032
            
            #add-point:AFTER FIELD pmdb032 name="input.a.page1.pmdb032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb032
            #add-point:ON CHANGE pmdb032 name="input.g.page1.pmdb032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb051
            
            #add-point:AFTER FIELD pmdb051 name="input.a.page1.pmdb051"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb051
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='265' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdb_d[l_ac].pmdb051_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb051_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb051
            #add-point:BEFORE FIELD pmdb051 name="input.b.page1.pmdb051"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb051
            #add-point:ON CHANGE pmdb051 name="input.g.page1.pmdb051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb033
            #add-point:BEFORE FIELD pmdb033 name="input.b.page1.pmdb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb033
            
            #add-point:AFTER FIELD pmdb033 name="input.a.page1.pmdb033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb033
            #add-point:ON CHANGE pmdb033 name="input.g.page1.pmdb033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb049
            #add-point:BEFORE FIELD pmdb049 name="input.b.page1.pmdb049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb049
            
            #add-point:AFTER FIELD pmdb049 name="input.a.page1.pmdb049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb049
            #add-point:ON CHANGE pmdb049 name="input.g.page1.pmdb049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="input.b.page1.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="input.a.page1.ooff013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013 name="input.g.page1.ooff013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmdbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdbsite
            #add-point:ON ACTION controlp INFIELD pmdbsite name="input.c.page1.pmdbsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdbseq
            #add-point:ON ACTION controlp INFIELD pmdbseq name="input.c.page1.pmdbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb001
            #add-point:ON ACTION controlp INFIELD pmdb001 name="input.c.page1.pmdb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb002
            #add-point:ON ACTION controlp INFIELD pmdb002 name="input.c.page1.pmdb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb003
            #add-point:ON ACTION controlp INFIELD pmdb003 name="input.c.page1.pmdb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb052
            #add-point:ON ACTION controlp INFIELD pmdb052 name="input.c.page1.pmdb052"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb004
            #add-point:ON ACTION controlp INFIELD pmdb004 name="input.c.page1.pmdb004"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE
			
            LET g_qryparam.where = "1=1 "
            
            LET l_sql = ''
            #CALL s_control_get_sql("imaa001",'6','3',g_user,g_dept) RETURNING l_success,l_sql
            #IF l_success THEN
            #   LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
            #END IF
            #
            #LET l_sql1 = ''
            #CALL s_control_get_doc_sql("imaf016",g_pmda_m.pmdadocno,'4') RETURNING l_success,l_sql1
            #IF l_success THEN
            #   LET g_qryparam.where = g_qryparam.where ," AND ",l_sql1
            #END IF
            #
            #LET l_sql2 = ''
            #CALL s_control_get_doc_sql("imaa009",g_pmda_m.pmdadocno,'5') RETURNING l_success,l_sql2
            CALL s_control_get_item_sql('3',g_site,g_user,g_dept,g_pmda_m.pmdadocno) RETURNING l_success,l_sql
            IF l_success THEN
               IF cl_null(l_sql) THEN
                  LET l_sql = " 1=1"
               END IF
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
            END IF
            
            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb004             #給予default值

            #給予arg

            CALL q_imaf001_15()                                #呼叫開窗

            LET g_pmdb_d[l_ac].pmdb004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb_d[l_ac].pmdb004 TO pmdb004              #顯示到畫面上
            CALL apmt400_pmdb004_ref(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004

            NEXT FIELD pmdb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb005
            #add-point:ON ACTION controlp INFIELD pmdb005 name="input.c.page1.pmdb005"
            LET l_imaa005 = ''
            CALL apmt400_get_imaa005(g_enterprise,g_pmdb_d[l_ac].pmdb004) RETURNING l_imaa005
               
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' AND NOT cl_null(l_imaa005) THEN
               IF l_cmd = 'a' THEN            
                  CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_pmdb_d[l_ac].pmdb004,'','',g_site,g_pmda_m.pmdadocno) RETURNING l_success,l_inam
                  LET g_pmdb_d[l_ac].pmdb005 = l_inam[1].inam002
                  LET g_pmdb_d[l_ac].pmdb006 = l_inam[1].inam004
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb006
                  
                  #計算參考數量
                  IF (NOT cl_null(g_pmdb_d[l_ac].pmdb004)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb009)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb007)) THEN
                     #CALL s_aimi190_get_convert(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009) RETURNING l_success,l_rate
                     #LET g_pmdb_d[l_ac].pmdb008 = g_pmdb_d[l_ac].pmdb006 * l_rate
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb006)
                          RETURNING l_success,g_pmdb_d[l_ac].pmdb008
                     IF NOT cl_null(g_pmdb_d[l_ac].pmdb008) THEN
                        CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb008) RETURNING g_pmdb_d[l_ac].pmdb008
                     END IF
                  END IF
               
                  #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
                  #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
                  IF (cl_get_para(g_enterprise,g_site,'S-BAS-0019')) = "Y" AND (NOT cl_null(g_pmdb_d[l_ac].pmdb004)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb011)) AND (NOT cl_null(g_pmdb_d[l_ac].pmdb007)) THEN  #體參數使用採購計價單位
                     #CALL s_aimi190_get_convert(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb011) RETURNING l_success,l_rate
                     #LET g_pmdb_d[l_ac].pmdb010 = g_pmdb_d[l_ac].pmdb006 * l_rate
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb006)
                          RETURNING l_success,g_pmdb_d[l_ac].pmdb010
                     IF NOT cl_null(g_pmdb_d[l_ac].pmdb010) THEN
                        CALL apmt400_unit_round(g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb010) RETURNING g_pmdb_d[l_ac].pmdb010
                     END IF 
                  END IF
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb008,g_pmdb_d[l_ac].pmdb010
                  
               END IF
               IF l_cmd = 'u' THEN
                  CALL s_feature_single(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_site,g_pmda_m.pmdadocno)
                     RETURNING l_success,g_pmdb_d[l_ac].pmdb005
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005
                  CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005_desc
               END IF
            END IF   
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb007
            #add-point:ON ACTION controlp INFIELD pmdb007 name="input.c.page1.pmdb007"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdb_d[l_ac].pmdb004
            CALL q_imao002()                                #呼叫開窗

            LET g_pmdb_d[l_ac].pmdb007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb_d[l_ac].pmdb007 TO pmdb007              #顯示到畫面上
            CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb007_desc

            NEXT FIELD pmdb007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb006
            #add-point:ON ACTION controlp INFIELD pmdb006 name="input.c.page1.pmdb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb009
            #add-point:ON ACTION controlp INFIELD pmdb009 name="input.c.page1.pmdb009"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb009             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_pmdb_d[l_ac].pmdb009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb_d[l_ac].pmdb009 TO pmdb009              #顯示到畫面上
            CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb009) RETURNING g_pmdb_d[l_ac].pmdb009_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb009_desc

            NEXT FIELD pmdb009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb008
            #add-point:ON ACTION controlp INFIELD pmdb008 name="input.c.page1.pmdb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb011
            #add-point:ON ACTION controlp INFIELD pmdb011 name="input.c.page1.pmdb011"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdb_d[l_ac].pmdb004
            CALL q_imao002()
            
            LET g_pmdb_d[l_ac].pmdb011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb_d[l_ac].pmdb011 TO pmdb011              #顯示到畫面上
            CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb011) RETURNING g_pmdb_d[l_ac].pmdb011_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb011_desc

            NEXT FIELD pmdb011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb010
            #add-point:ON ACTION controlp INFIELD pmdb010 name="input.c.page1.pmdb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb030
            #add-point:ON ACTION controlp INFIELD pmdb030 name="input.c.page1.pmdb030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb048
            #add-point:ON ACTION controlp INFIELD pmdb048 name="input.c.page1.pmdb048"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb048             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "274" #   #170213-00038#3 mark

            #CALL q_oocq002()                                #呼叫開窗  #170213-00038#3 mark
            CALL q_oocq002_274()  #170213-00038#3 add

            LET g_pmdb_d[l_ac].pmdb048 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb_d[l_ac].pmdb048 TO pmdb048              #顯示到畫面上
            CALL apmt400_pmdb048_ref(g_pmdb_d[l_ac].pmdb048) RETURNING g_pmdb_d[l_ac].pmdb048_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb048_desc    

            NEXT FIELD pmdb048                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb031
            #add-point:ON ACTION controlp INFIELD pmdb031 name="input.c.page1.pmdb031"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			#根據單據別加上限制理由碼的條件
			#獲取單據別
			LET l_ooba002 = ''
			CALL s_aooi200_get_slip(g_pmda_m.pmdadocno) RETURNING l_success,l_ooba002

			LET l_n = 0
			SELECT COUNT(oobi003) INTO l_n FROM ooba_t,oobi_t WHERE oobaent=oobient AND ooba001=oobi001 AND ooba002=oobi002 
                 AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = l_ooba002
			IF l_n > 0 THEN
			   #判斷是正向列表還是負向列表
			   LET l_ooba015 = ''
			   SELECT ooba015 INTO l_ooba015 FROM ooba_t
			     WHERE oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = l_ooba002
               #正向列表
               IF l_ooba015 = '1' THEN
                  LET g_qryparam.where = " oocq002 IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",l_ooba002,"')"
               END IF
               
               #負向列表
               IF l_ooba015 = '2' THEN
                  LET g_qryparam.where = " oocq002 NOT IN (SELECT oobi003 FROM oobi_t WHERE oobient = '",g_enterprise,"' AND oobi001 = '",l_ooef004,"' AND oobi002 = '",l_ooba002,"')"
               END IF
            END IF

            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb031             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = g_acc #  #170213-00038#3 mark

            #CALL q_oocq002()                              #呼叫開窗  #170213-00038#3 mark
            CALL q_oocq002_265()  #170213-00038#3 add

            LET g_pmdb_d[l_ac].pmdb031 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb_d[l_ac].pmdb031 TO pmdb031              #顯示到畫面上
            CALL apmt400_pmdb031_ref(g_pmdb_d[l_ac].pmdb031) RETURNING g_pmdb_d[l_ac].pmdb031_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb031_desc

            NEXT FIELD pmdb031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb050
            #add-point:ON ACTION controlp INFIELD pmdb050 name="input.c.page1.pmdb050"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb032
            #add-point:ON ACTION controlp INFIELD pmdb032 name="input.c.page1.pmdb032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb051
            #add-point:ON ACTION controlp INFIELD pmdb051 name="input.c.page1.pmdb051"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb033
            #add-point:ON ACTION controlp INFIELD pmdb033 name="input.c.page1.pmdb033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb049
            #add-point:ON ACTION controlp INFIELD pmdb049 name="input.c.page1.pmdb049"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooff013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.page1.ooff013"
            #161031-00025#8 add-S
            IF NOT cl_null(g_pmda_m.pmdadocno) AND l_ac > 0 THEN
#               CALL aooi360_01('7',g_prog,g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,'','','','','','','')
               CALL aooi360_02('7',g_prog,g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,'','','','','','','','1')
               CALL s_aooi360_sel('7',g_prog,g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,'','','','','','','','1') RETURNING l_success,g_pmdb_d[l_ac].ooff013
               
               LET g_ooff001_d = '6'   #6.單據單頭備註
               LET g_ooff002_d = g_prog
               LET g_ooff003_d = g_pmda_m.pmdadocno   #单号
               LET g_ooff004_d = 0     #项次
               LET g_ooff005_d = ' '
               LET g_ooff006_d = ' '
               LET g_ooff007_d = ' '
               LET g_ooff008_d = ' '
               LET g_ooff009_d = ' '
               LET g_ooff010_d = ' '
               LET g_ooff011_d = ' '
               CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身 
            END IF
            #161031-00025#8 add-E
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmt400_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmdb_d[l_ac].pmdbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #整體參數未使用採購計價單位,則賦值當前的採購單位和數量
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" OR cl_null(g_imaf144) THEN
                  LET g_pmdb_d[l_ac].pmdb011 = g_pmdb_d[l_ac].pmdb007
                  LET g_pmdb_d[l_ac].pmdb010 = g_pmdb_d[l_ac].pmdb006
               END IF
               #add by lixh 20151013
               IF NOT cl_null(g_pmdb2_d[g_detail_idx].pmdb034) THEN
                  SELECT pmdb006,pmdb007 INTO l_pmdb006,l_pmdb007 FROM pmdb_t
                   WHERE pmdbent = g_enterprise
                     AND pmdbdocno = g_pmda_m.pmdadocno
                     AND pmdbseq = g_pmdb_d_t.pmdbseq
                  IF NOT cl_null(l_pmdb007) AND NOT cl_null(g_pmdb_d[l_ac].pmdb007) THEN
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,l_pmdb007,g_pmdb_d[l_ac].pmdb007,l_pmdb006)  #add by lixh 20151028
                          RETURNING l_success,l_pmdb006  
                  END IF                       
                  LET l_cy_pmdb006 = g_pmdb_d[l_ac].pmdb006 - l_pmdb006 
                  IF l_cy_pmdb006 <> 0 THEN
                  #add by lixh 20151023
                     #單位換算
                     SELECT pjbd006 INTO l_pjbd006 FROM pjbd_t
                      WHERE pjbdent = g_enterprise
                        AND pjbd001 = g_pmdb2_d[g_detail_idx].pmdb034
                        AND pjbd002 = g_pmdb2_d[g_detail_idx].pmdb035
                        AND pjbd003 = g_pmdb_d[l_ac].pmdb002  
                        
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,l_pjbd006,l_cy_pmdb006) 
                             RETURNING l_success,l_cy_pmdb006                 
                  #add by lixh 20151023
                     UPDATE pjbd_t SET pjbd011 = pjbd011 + l_cy_pmdb006
                      WHERE pjbdent = g_enterprise
                        AND pjbd001 = g_pmdb2_d[g_detail_idx].pmdb034
                        AND pjbd002 = g_pmdb2_d[g_detail_idx].pmdb035
                        AND pjbd003 = g_pmdb_d[l_ac].pmdb002
                        
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "pjbd_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()                   
                        CALL s_transaction_end('N','0')
                        LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*    
                     END IF                        
                  END IF   
               END IF
               #add by lixh 20151013               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apmt400_pmdb_t_mask_restore('restore_mask_o')
      
               UPDATE pmdb_t SET (pmdbdocno,pmdbsite,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb052,pmdb004, 
                   pmdb005,pmdb007,pmdb006,pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050, 
                   pmdb032,pmdb051,pmdb033,pmdb049,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019, 
                   pmdb020,pmdb021,pmdb034,pmdb035,pmdb036,pmdb053,pmdb037,pmdb038,pmdb039,pmdb054,pmdb041, 
                   pmdb042,pmdb043,pmdb044,pmdb045,pmdb046) = (g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbsite, 
                   g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb001,g_pmdb_d[l_ac].pmdb002,g_pmdb_d[l_ac].pmdb003, 
                   g_pmdb_d[l_ac].pmdb052,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb007, 
                   g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb008,g_pmdb_d[l_ac].pmdb011, 
                   g_pmdb_d[l_ac].pmdb010,g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb031, 
                   g_pmdb_d[l_ac].pmdb050,g_pmdb_d[l_ac].pmdb032,g_pmdb_d[l_ac].pmdb051,g_pmdb_d[l_ac].pmdb033, 
                   g_pmdb_d[l_ac].pmdb049,g_pmdb2_d[l_ac].pmdb012,g_pmdb2_d[l_ac].pmdb014,g_pmdb2_d[l_ac].pmdb015, 
                   g_pmdb2_d[l_ac].pmdb016,g_pmdb2_d[l_ac].pmdb017,g_pmdb2_d[l_ac].pmdb018,g_pmdb2_d[l_ac].pmdb019, 
                   g_pmdb2_d[l_ac].pmdb020,g_pmdb2_d[l_ac].pmdb021,g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb035, 
                   g_pmdb2_d[l_ac].pmdb036,g_pmdb2_d[l_ac].pmdb053,g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038, 
                   g_pmdb2_d[l_ac].pmdb039,g_pmdb2_d[l_ac].pmdb054,g_pmdb2_d[l_ac].pmdb041,g_pmdb2_d[l_ac].pmdb042, 
                   g_pmdb2_d[l_ac].pmdb043,g_pmdb2_d[l_ac].pmdb044,g_pmdb2_d[l_ac].pmdb045,g_pmdb2_d[l_ac].pmdb046) 
 
                WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno 
 
                  AND pmdbseq = g_pmdb_d_t.pmdbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmda_m.pmdadocno
               LET gs_keys_bak[1] = g_pmdadocno_t
               LET gs_keys[2] = g_pmdb_d[g_detail_idx].pmdbseq
               LET gs_keys_bak[2] = g_pmdb_d_t.pmdbseq
               CALL apmt400_update_b('pmdb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apmt400_pmdb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pmdb_d[g_detail_idx].pmdbseq = g_pmdb_d_t.pmdbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_pmda_m.pmdadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmdb_d_t.pmdbseq
 
                  CALL apmt400_key_update_b(gs_keys,'pmdb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmda_m),util.JSON.stringify(g_pmdb_d_t)
               LET g_log2 = util.JSON.stringify(g_pmda_m),util.JSON.stringify(g_pmdb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #2015/08/20 by stellar add ----- (S)
               CALL s_apmt400_stus_abg(g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,'U')
                    RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*
               END IF
               #2015/08/20 by stellar add ----- (E)   

               #160920-00035#1---s
               #修改来源单号
               IF (NOT cl_null(g_pmdb_d[l_ac].pmdb001)) AND ((g_pmdb_d[l_ac].pmdb001 <> g_pmdb_d_t.pmdb001 AND NOT cl_null(g_pmdb_d_t.pmdb001)) 
                                                              OR (g_pmdb_d[l_ac].pmdb006 <> g_pmdb_d_t.pmdb006)) THEN
                  SELECT DISTINCT pspcsite,pspc001,pspc002,pspc004,pspc061 
                       INTO l_pspcsite,l_pspc001,l_pspc002,l_pspc004,l_pspc061
                      FROM pspc_t
                    WHERE pspcent = g_enterprise AND pspc004 = g_pmdb_d_t.pmdb001
                      AND pspc050 = g_pmdb_d[l_ac].pmdb004 AND pspc051 = g_pmdb_d[l_ac].pmdb005
                      AND pspc055 = g_pmda_m.pmdadocno AND pspc056 = g_pmdb_d[l_ac].pmdbseq
                  IF l_pspc061 > g_pmdb_d_t.pmdb006 THEN
                     UPDATE pspc_t SET pspc061 = pspc061 - g_pmdb_d_t.pmdb006
                        WHERE pspcent = g_enterprise AND pspcsite = l_pspcsite AND pspc001 = l_pspc001
                          AND pspc004 = l_pspc004
                  ELSE
                     UPDATE pspc_t SET pspc055 = '',
                                       pspc056 = '',
                                       pspc061 = 0
                        WHERE pspcent = g_enterprise AND pspcsite = l_pspcsite AND pspc001 = l_pspc001
                          AND pspc004 = l_pspc004
                  END IF
                  UPDATE pspc_t SET pspc061 = pspc061 + g_pmdb_d[l_ac].pmdb006
                     WHERE pspcent = g_enterprise AND pspc004 = g_pmdb_d[l_ac].pmdb001
                      AND pspc050 = g_pmdb_d[l_ac].pmdb004 AND pspc051 = g_pmdb_d[l_ac].pmdb005
                      AND pspc055 = g_pmda_m.pmdadocno AND pspc056 = g_pmdb_d[l_ac].pmdbseq
               END IF
               IF (cl_null(g_pmdb_d[l_ac].pmdb001)) AND (NOT cl_null(g_pmdb_d_t.pmdb001)) THEN
                  SELECT DISTINCT pspcsite,pspc001,pspc002,pspc004,pspc061 
                       INTO l_pspcsite,l_pspc001,l_pspc002,l_pspc004,l_pspc061
                      FROM pspc_t
                    WHERE pspcent = g_enterprise AND pspc004 = g_pmdb_d_t.pmdb001
                      AND pspc050 = g_pmdb_d[l_ac].pmdb004 AND pspc051 = g_pmdb_d[l_ac].pmdb005
                      AND pspc055 = g_pmda_m.pmdadocno AND pspc056 = g_pmdb_d[l_ac].pmdbseq
                  IF l_pspc061 > g_pmdb_d_t.pmdb006 THEN
                     UPDATE pspc_t SET pspc061 = pspc061 - g_pmdb_d_t.pmdb006
                        WHERE pspcent = g_enterprise AND pspcsite = l_pspcsite AND pspc001 = l_pspc001
                          AND pspc004 = l_pspc004
                  ELSE
                     UPDATE pspc_t SET pspc055 = '',
                                       pspc056 = '',
                                       pspc061 = 0
                        WHERE pspcent = g_enterprise AND pspcsite = l_pspcsite AND pspc001 = l_pspc001
                          AND pspc004 = l_pspc004
                  END IF
               END IF
               IF (NOT cl_null(g_pmdb_d[l_ac].pmdb001)) AND (cl_null(g_pmdb_d_t.pmdb001)) THEN
                  UPDATE pspc_t SET pspc061 = pspc061 + g_pmdb_d[l_ac].pmdb006
                     WHERE pspcent = g_enterprise AND pspc004 = g_pmdb_d[l_ac].pmdb001
                      AND pspc050 = g_pmdb_d[l_ac].pmdb004 AND pspc051 = g_pmdb_d[l_ac].pmdb005
                      AND pspc055 = g_pmda_m.pmdadocno AND pspc056 = g_pmdb_d[l_ac].pmdbseq
               END IF
               
               #160920-00035#1---e
               #161031-00025#8---s
               CALL s_aooi360_del('7',g_prog,g_pmda_m.pmdadocno,g_pmdb_d_t.pmdbseq,'','','','','','','','1') RETURNING l_success
               IF NOT cl_null(g_pmdb_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,'','','','','','','','1',g_pmdb_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#8---e
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
 
            #end add-point
            CALL apmt400_unlock_b("pmdb_t","'1'")
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
               LET g_pmdb_d[li_reproduce_target].* = g_pmdb_d[li_reproduce].*
               LET g_pmdb2_d[li_reproduce_target].* = g_pmdb2_d[li_reproduce].*
 
               LET g_pmdb_d[li_reproduce_target].pmdbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmdb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmdb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_pmdb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            
            CALL apmt400_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_pmdb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            CALL FGL_SET_ARR_CURR(g_detail_idx)   #2015/08/19 by stellar
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmdb2_d[l_ac].* TO NULL 
            INITIALIZE g_pmdb2_d_t.* TO NULL 
            INITIALIZE g_pmdb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_pmdb2_d[l_ac].pmdb014 = "1"
      LET g_pmdb2_d[l_ac].pmdb019 = "0"
      LET g_pmdb2_d[l_ac].pmdb020 = "0"
      LET g_pmdb2_d[l_ac].pmdb021 = "0"
      LET g_pmdb2_d[l_ac].pmdb041 = "Y"
      LET g_pmdb2_d[l_ac].pmdb042 = "Y"
      LET g_pmdb2_d[l_ac].pmdb043 = "N"
      LET g_pmdb2_d[l_ac].pmdb044 = "Y"
      LET g_pmdb2_d[l_ac].pmdb045 = "Y"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_pmdb2_d_t.* = g_pmdb2_d[l_ac].*     #新輸入資料
            LET g_pmdb2_d_o.* = g_pmdb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmt400_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            CALL apmt400_set_no_required_b()
            CALL apmt400_set_required_b()
            #end add-point
            CALL apmt400_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmdb_d[li_reproduce_target].* = g_pmdb_d[li_reproduce].*
               LET g_pmdb2_d[li_reproduce_target].* = g_pmdb2_d[li_reproduce].*
 
               LET g_pmdb2_d[li_reproduce_target].pmdbseq = NULL
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
            OPEN apmt400_cl USING g_enterprise,g_pmda_m.pmdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt400_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt400_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmdb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmdb2_d[l_ac].pmdbseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_pmdb2_d_t.* = g_pmdb2_d[l_ac].*  #BACKUP
               LET g_pmdb2_d_o.* = g_pmdb2_d[l_ac].*  #BACKUP
               CALL apmt400_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL apmt400_set_no_entry_b(l_cmd)
               IF NOT apmt400_lock_b("pmdb_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt400_bcl INTO g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb001, 
                      g_pmdb_d[l_ac].pmdb002,g_pmdb_d[l_ac].pmdb003,g_pmdb_d[l_ac].pmdb052,g_pmdb_d[l_ac].pmdb004, 
                      g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb009, 
                      g_pmdb_d[l_ac].pmdb008,g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb010,g_pmdb_d[l_ac].pmdb030, 
                      g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb031,g_pmdb_d[l_ac].pmdb050,g_pmdb_d[l_ac].pmdb032, 
                      g_pmdb_d[l_ac].pmdb051,g_pmdb_d[l_ac].pmdb033,g_pmdb_d[l_ac].pmdb049,g_pmdb2_d[l_ac].pmdbseq, 
                      g_pmdb2_d[l_ac].pmdb012,g_pmdb2_d[l_ac].pmdb014,g_pmdb2_d[l_ac].pmdb015,g_pmdb2_d[l_ac].pmdb016, 
                      g_pmdb2_d[l_ac].pmdb017,g_pmdb2_d[l_ac].pmdb018,g_pmdb2_d[l_ac].pmdb019,g_pmdb2_d[l_ac].pmdb020, 
                      g_pmdb2_d[l_ac].pmdb021,g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb035,g_pmdb2_d[l_ac].pmdb036, 
                      g_pmdb2_d[l_ac].pmdb053,g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039, 
                      g_pmdb2_d[l_ac].pmdb054,g_pmdb2_d[l_ac].pmdb041,g_pmdb2_d[l_ac].pmdb042,g_pmdb2_d[l_ac].pmdb043, 
                      g_pmdb2_d[l_ac].pmdb044,g_pmdb2_d[l_ac].pmdb045,g_pmdb2_d[l_ac].pmdb046
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmdb2_d_mask_o[l_ac].* =  g_pmdb2_d[l_ac].*
                  CALL apmt400_pmdb_t_mask()
                  LET g_pmdb2_d_mask_n[l_ac].* =  g_pmdb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmt400_show()
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
               LET gs_keys[01] = g_pmda_m.pmdadocno
               LET gs_keys[gs_keys.getLength()+1] = g_pmdb2_d_t.pmdbseq
            
               #刪除同層單身
               IF NOT apmt400_delete_b('pmdb_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt400_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmt400_key_delete_b(gs_keys,'pmdb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt400_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE apmt400_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_pmdb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmdb2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM pmdb_t 
             WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
               AND pmdbseq = g_pmdb2_d[l_ac].pmdbseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmda_m.pmdadocno
               LET gs_keys[2] = g_pmdb2_d[g_detail_idx].pmdbseq
               CALL apmt400_insert_b('pmdb_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_pmdb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "pmdb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmt400_b_fill()
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
               LET g_pmdb2_d[l_ac].* = g_pmdb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmt400_bcl
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
               LET g_pmdb2_d[l_ac].* = g_pmdb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL apmt400_pmdb_t_mask_restore('restore_mask_o')
                              
               UPDATE pmdb_t SET (pmdbdocno,pmdbsite,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb052,pmdb004, 
                   pmdb005,pmdb007,pmdb006,pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050, 
                   pmdb032,pmdb051,pmdb033,pmdb049,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019, 
                   pmdb020,pmdb021,pmdb034,pmdb035,pmdb036,pmdb053,pmdb037,pmdb038,pmdb039,pmdb054,pmdb041, 
                   pmdb042,pmdb043,pmdb044,pmdb045,pmdb046) = (g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbsite, 
                   g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb001,g_pmdb_d[l_ac].pmdb002,g_pmdb_d[l_ac].pmdb003, 
                   g_pmdb_d[l_ac].pmdb052,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb007, 
                   g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb008,g_pmdb_d[l_ac].pmdb011, 
                   g_pmdb_d[l_ac].pmdb010,g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb031, 
                   g_pmdb_d[l_ac].pmdb050,g_pmdb_d[l_ac].pmdb032,g_pmdb_d[l_ac].pmdb051,g_pmdb_d[l_ac].pmdb033, 
                   g_pmdb_d[l_ac].pmdb049,g_pmdb2_d[l_ac].pmdb012,g_pmdb2_d[l_ac].pmdb014,g_pmdb2_d[l_ac].pmdb015, 
                   g_pmdb2_d[l_ac].pmdb016,g_pmdb2_d[l_ac].pmdb017,g_pmdb2_d[l_ac].pmdb018,g_pmdb2_d[l_ac].pmdb019, 
                   g_pmdb2_d[l_ac].pmdb020,g_pmdb2_d[l_ac].pmdb021,g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb035, 
                   g_pmdb2_d[l_ac].pmdb036,g_pmdb2_d[l_ac].pmdb053,g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038, 
                   g_pmdb2_d[l_ac].pmdb039,g_pmdb2_d[l_ac].pmdb054,g_pmdb2_d[l_ac].pmdb041,g_pmdb2_d[l_ac].pmdb042, 
                   g_pmdb2_d[l_ac].pmdb043,g_pmdb2_d[l_ac].pmdb044,g_pmdb2_d[l_ac].pmdb045,g_pmdb2_d[l_ac].pmdb046)  
                   #自訂欄位頁簽
                WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
                  AND pmdbseq = g_pmdb2_d_t.pmdbseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmdb2_d[l_ac].* = g_pmdb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmdb2_d[l_ac].* = g_pmdb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmda_m.pmdadocno
               LET gs_keys_bak[1] = g_pmdadocno_t
               LET gs_keys[2] = g_pmdb2_d[g_detail_idx].pmdbseq
               LET gs_keys_bak[2] = g_pmdb2_d_t.pmdbseq
               CALL apmt400_update_b('pmdb_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apmt400_pmdb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_pmdb2_d[g_detail_idx].pmdbseq = g_pmdb2_d_t.pmdbseq 
                  ) THEN
                  LET gs_keys[01] = g_pmda_m.pmdadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_pmdb2_d_t.pmdbseq
                  CALL apmt400_key_update_b(gs_keys,'pmdb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmda_m),util.JSON.stringify(g_pmdb2_d_t)
               LET g_log2 = util.JSON.stringify(g_pmda_m),util.JSON.stringify(g_pmdb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               ##更新单头栏位金额合计
               #LET l_pmda008 = 0
               #LET l_pmda009 = 0
               #SELECT SUM(pmdb020),SUM(pmdb021) INTO l_pmda008,l_pmda009 FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
               #UPDATE pmda_t SET pmda008 = l_pmda008,pmda009 = l_pmda009
               #   WHERE pmdaent = g_enterprise AND pmdadocno = g_pmda_m.pmdadocno
               #IF SQLCA.sqlcode THEN
               #   CALL cl_err("pmda_t",SQLCA.sqlcode,1)  
               #   CALL s_transaction_end('N','0')
               #   LET g_pmdb2_d[l_ac].* = g_pmdb2_d_t.*   
               #END IF

               #2015/08/20 by stellar add ----- (S)
               LET l_success = TRUE
               IF l_insert1 THEN
                  CALL s_apmt400_stus_abg(g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,'I')
                       RETURNING l_success,l_errno
                  LET l_insert1 = FALSE
               ELSE
                  CALL s_apmt400_stus_abg(g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,'U')
                       RETURNING l_success,l_errno
               END IF
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  LET g_pmdb2_d[l_ac].* = g_pmdb2_d_t.*
               END IF
               #2015/08/20 by stellar add ----- (E)
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb012
            
            #add-point:AFTER FIELD pmdb012 name="input.a.page2.pmdb012"
            CALL apmt400_pmdb012_ref(g_pmdb2_d[l_ac].pmdb012) RETURNING g_pmdb2_d[l_ac].pmdb012_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb012_desc
            
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb012) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdb2_d[l_ac].pmdb012
               #160318-00025#16  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#16  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001_3") THEN
                  #檢查成功時後續處理
                  IF cl_chk_exist("v_imaf001_2") THEN
                  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_pmdb2_d[l_ac].pmdb012 = g_pmdb2_d_t.pmdb012
                     CALL apmt400_pmdb012_ref(g_pmdb2_d[l_ac].pmdb012) RETURNING g_pmdb2_d[l_ac].pmdb012_desc
                     DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb012_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmdb2_d[l_ac].pmdb012 = g_pmdb2_d_t.pmdb012
                  CALL apmt400_pmdb012_ref(g_pmdb2_d[l_ac].pmdb012) RETURNING g_pmdb2_d[l_ac].pmdb012_desc
                  DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb012_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb012
            #add-point:BEFORE FIELD pmdb012 name="input.b.page2.pmdb012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb012
            #add-point:ON CHANGE pmdb012 name="input.g.page2.pmdb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb014
            #add-point:BEFORE FIELD pmdb014 name="input.b.page2.pmdb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb014
            
            #add-point:AFTER FIELD pmdb014 name="input.a.page2.pmdb014"
            CALL apmt400_set_entry_b(l_cmd)
            CALL apmt400_set_no_required_b()
            CALL apmt400_set_required_b()
            CALL apmt400_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb014
            #add-point:ON CHANGE pmdb014 name="input.g.page2.pmdb014"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb015
            
            #add-point:AFTER FIELD pmdb015 name="input.a.page2.pmdb015"
            CALL apmt400_pmdb015_ref(g_pmdb2_d[l_ac].pmdb015) RETURNING g_pmdb2_d[l_ac].pmdb015_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb015_desc
            
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb015) THEN 
               IF NOT apmt400_pmdb015_chk(g_pmdb2_d[l_ac].pmdb015) THEN
                  #檢查失敗時後續處理
                  LET g_pmdb2_d[l_ac].pmdb015 = g_pmdb2_d_t.pmdb015
                  CALL apmt400_pmdb015_ref(g_pmdb2_d[l_ac].pmdb015) RETURNING g_pmdb2_d[l_ac].pmdb015_desc
                  DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb015_desc
                  NEXT FIELD CURRENT
               ELSE
                  LET g_pmdb2_d[l_ac].pmdb016 = ''
                  LET g_pmdb2_d[l_ac].pmdb017 = ''
                  LET g_pmdb2_d[l_ac].pmdb041 = ''
                  LET g_pmdb2_d[l_ac].pmdb042 = ''
                  SELECT pmab037,pmab053,pmab049,pmab051 INTO g_pmdb2_d[l_ac].pmdb016,g_pmdb2_d[l_ac].pmdb017,g_pmdb2_d[l_ac].pmdb041,g_pmdb2_d[l_ac].pmdb042
                     FROM pmab_t
                     WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = g_pmdb2_d[l_ac].pmdb015
                  CALL apmt400_pmdb016_ref(g_pmdb2_d[l_ac].pmdb016) RETURNING g_pmdb2_d[l_ac].pmdb016_desc
                  CALL apmt400_pmdb017_ref(g_pmdb2_d[l_ac].pmdb017) RETURNING g_pmdb2_d[l_ac].pmdb017_desc
                  DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb016,g_pmdb2_d[l_ac].pmdb016_desc,g_pmdb2_d[l_ac].pmdb017,g_pmdb2_d[l_ac].pmdb017_desc,g_pmdb2_d[l_ac].pmdb041,g_pmdb2_d[l_ac].pmdb042
                  
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb015
            #add-point:BEFORE FIELD pmdb015 name="input.b.page2.pmdb015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb015
            #add-point:ON CHANGE pmdb015 name="input.g.page2.pmdb015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb016
            
            #add-point:AFTER FIELD pmdb016 name="input.a.page2.pmdb016"
            CALL apmt400_pmdb016_ref(g_pmdb2_d[l_ac].pmdb016) RETURNING g_pmdb2_d[l_ac].pmdb016_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb016_desc
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb016) THEN 
               IF NOT apmt400_pmdb016_chk(g_pmdb2_d[l_ac].pmdb015,g_pmdb2_d[l_ac].pmdb016) THEN
                  LET g_pmdb2_d[l_ac].pmdb016 = g_pmdb2_d_t.pmdb016
                  CALL apmt400_pmdb016_ref(g_pmdb2_d[l_ac].pmdb016) RETURNING g_pmdb2_d[l_ac].pmdb016_desc
                  DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb016_desc
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb016
            #add-point:BEFORE FIELD pmdb016 name="input.b.page2.pmdb016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb016
            #add-point:ON CHANGE pmdb016 name="input.g.page2.pmdb016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb017
            
            #add-point:AFTER FIELD pmdb017 name="input.a.page2.pmdb017"
            CALL apmt400_pmdb017_ref(g_pmdb2_d[l_ac].pmdb017) RETURNING g_pmdb2_d[l_ac].pmdb017_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb017_desc
            
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb017) THEN 

               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdb2_d[l_ac].pmdb017
               #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="apm-00070:sub-01302|apmi012|",cl_get_progname("apmi012",g_lang,"2"),"|:EXEPROGapmi012"
               LET g_chkparam.err_str[2] ="apm-00069:sub-01303|apmi012|",cl_get_progname("apmi012",g_lang,"2"),"|:EXEPROGapmi012"
               #160318-00025#16 by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_238") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_pmdb2_d[l_ac].pmdb017 = g_pmdb2_d_t.pmdb017
                  CALL apmt400_pmdb017_ref(g_pmdb2_d[l_ac].pmdb017) RETURNING g_pmdb2_d[l_ac].pmdb017_desc
                  DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb017_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb017
            #add-point:BEFORE FIELD pmdb017 name="input.b.page2.pmdb017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb017
            #add-point:ON CHANGE pmdb017 name="input.g.page2.pmdb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb018
            #add-point:BEFORE FIELD pmdb018 name="input.b.page2.pmdb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb018
            
            #add-point:AFTER FIELD pmdb018 name="input.a.page2.pmdb018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb018
            #add-point:ON CHANGE pmdb018 name="input.g.page2.pmdb018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdb2_d[l_ac].pmdb019,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmdb019
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdb019 name="input.a.page2.pmdb019"
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb019) THEN 
               #IF l_cmd = 'a' OR (g_pmdb2_d[l_ac].pmdb019 != g_pmdb2_d_t.pmdb019 OR cl_null(g_pmdb2_d_t.pmdb019)) THEN   #160824-00007#339 Mark By Ken 170106
               IF (g_pmdb2_d[l_ac].pmdb019 != g_pmdb2_d_o.pmdb019 OR cl_null(g_pmdb2_d_o.pmdb019)) THEN   #160824-00007#339 Add By Ken 170106
                  #根據幣別對單價進行取位
                  CALL s_curr_round(g_site,g_pmda_m.pmda005,g_pmdb2_d[l_ac].pmdb019,'1') RETURNING g_pmdb2_d[l_ac].pmdb019
                  #CALL apmt400_money_amount()
               END IF
               IF NOT cl_null(g_pmda_m.pmda010) THEN
                  #計算未稅金額、含稅金額
                  CALL apmt400_get_amount(g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb006,g_pmdb2_d[l_ac].pmdb019,g_pmda_m.pmda010)
                    RETURNING g_pmdb2_d[l_ac].pmdb020,g_pmdb2_d[l_ac].pmdb021
                  DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb020,g_pmdb2_d[l_ac].pmdb021
                  
                  #2015/08/19 by stellar add ----- (S)
                  CALL apmt400_detail_abg('4')
                       RETURNING l_success,l_errno,l_bgaf016,l_pmdb053,l_pmdb053_desc
                  IF NOT l_success THEN
                     CASE l_errno
                        WHEN 'abg-00103'
                             CASE l_bgaf016
                                WHEN '1'
                                WHEN '2'
                                     INITIALIZE g_errparam TO NULL
                                     LET g_errparam.code = l_errno
                                     LET g_errparam.extend = ''
                                     LET g_errparam.popup = TRUE
                                     CALL cl_err()
                                WHEN '3'
                                     INITIALIZE g_errparam TO NULL
                                     LET g_errparam.code = l_errno
                                     LET g_errparam.extend = ''
                                     LET g_errparam.popup = TRUE
                                     CALL cl_err()
                                     NEXT FIELD CURRENT
                             END CASE
                        WHEN 'abg-00104'
                             INITIALIZE g_errparam TO NULL
                             LET g_errparam.code = l_errno
                             LET g_errparam.extend = ''
                             LET g_errparam.popup = TRUE
                             CALL cl_err()
                        OTHERWISE
                             INITIALIZE g_errparam TO NULL
                             LET g_errparam.code = l_errno
                             LET g_errparam.extend = ''
                             LET g_errparam.popup = TRUE
                             CALL cl_err()
                             NEXT FIELD CURRENT
                     END CASE
                  END IF
                  #2015/08/19 by stellar add ----- (E)
               END IF
            END IF 
            LET g_pmdb2_d_o.* = g_pmdb2_d[l_ac].*   #160824-00007#339 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb019
            #add-point:BEFORE FIELD pmdb019 name="input.b.page2.pmdb019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb019
            #add-point:ON CHANGE pmdb019 name="input.g.page2.pmdb019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb020
            #add-point:BEFORE FIELD pmdb020 name="input.b.page2.pmdb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb020
            
            #add-point:AFTER FIELD pmdb020 name="input.a.page2.pmdb020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb020
            #add-point:ON CHANGE pmdb020 name="input.g.page2.pmdb020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb021
            #add-point:BEFORE FIELD pmdb021 name="input.b.page2.pmdb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb021
            
            #add-point:AFTER FIELD pmdb021 name="input.a.page2.pmdb021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb021
            #add-point:ON CHANGE pmdb021 name="input.g.page2.pmdb021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb034
            
            #add-point:AFTER FIELD pmdb034 name="input.a.page2.pmdb034"
            CALL s_desc_get_project_desc(g_pmdb2_d[l_ac].pmdb034) RETURNING g_pmdb2_d[l_ac].pmdb034_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb034_desc
            
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb034) THEN 
               IF g_pmdb2_d[l_ac].pmdb034 != g_pmdb2_d_o.pmdb034 OR cl_null(g_pmdb2_d_o.pmdb034) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmdb2_d[l_ac].pmdb034
                  #160318-00025#16 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
                 #160318-00025#16 by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pjba001") THEN
                     #檢查失敗時後續處理
                     LET g_pmdb2_d[l_ac].pmdb034 = g_pmdb2_d_o.pmdb034
                     CALL s_desc_get_project_desc(g_pmdb2_d[l_ac].pmdb034) RETURNING g_pmdb2_d[l_ac].pmdb034_desc
                     DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb034_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_pmdb2_d[l_ac].pmdb035 = ''
                  LET g_pmdb2_d[l_ac].pmdb035_desc = ''
                  LET g_pmdb2_d[l_ac].pmdb036 = ''
                  LET g_pmdb2_d[l_ac].pmdb036_desc = ''
               END IF
            END IF 
            LET g_pmdb2_d_o.pmdb034 = g_pmdb2_d[l_ac].pmdb034

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb034
            #add-point:BEFORE FIELD pmdb034 name="input.b.page2.pmdb034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb034
            #add-point:ON CHANGE pmdb034 name="input.g.page2.pmdb034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb035
            
            #add-point:AFTER FIELD pmdb035 name="input.a.page2.pmdb035"
            CALL s_desc_get_wbs_desc(g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb035) RETURNING g_pmdb2_d[l_ac].pmdb035_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb035_desc
            
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb035) THEN 
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdb2_d[l_ac].pmdb034
               LET g_chkparam.arg2 = g_pmdb2_d[l_ac].pmdb035
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pjbb002") THEN
                  #檢查失敗時後續處理
                  LET g_pmdb2_d[l_ac].pmdb035 = g_pmdb2_d_t.pmdb035
                  CALL s_desc_get_wbs_desc(g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb035) RETURNING g_pmdb2_d[l_ac].pmdb035_desc
                  DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb035_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb035
            #add-point:BEFORE FIELD pmdb035 name="input.b.page2.pmdb035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb035
            #add-point:ON CHANGE pmdb035 name="input.g.page2.pmdb035"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb036
            
            #add-point:AFTER FIELD pmdb036 name="input.a.page2.pmdb036"
            CALL s_desc_get_activity_desc(g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb036) RETURNING g_pmdb2_d[l_ac].pmdb036_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb036_desc
            
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb036) THEN 
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdb2_d[l_ac].pmdb034
               LET g_chkparam.arg2 = g_pmdb2_d[l_ac].pmdb036
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pjbm002") THEN
                  #檢查失敗時後續處理
                  LET g_pmdb2_d[l_ac].pmdb036 = g_pmdb2_d_t.pmdb036
                  CALL s_desc_get_activity_desc(g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb036) RETURNING g_pmdb2_d[l_ac].pmdb036_desc
                  DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb036_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb036
            #add-point:BEFORE FIELD pmdb036 name="input.b.page2.pmdb036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb036
            #add-point:ON CHANGE pmdb036 name="input.g.page2.pmdb036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb053
            
            #add-point:AFTER FIELD pmdb053 name="input.a.page2.pmdb053"
            #2015/08/19 by stellar add ----- (S)
            LET g_pmdb2_d[l_ac].pmdb053_desc = ''
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb053_desc
            
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb053) THEN
               CALL apmt400_detail_abg('2')
                    RETURNING l_success,l_errno,l_bgaf016,l_pmdb053,l_pmdb053_desc
               LET g_pmdb2_d[l_ac].pmdb053_desc = l_pmdb053_desc
               DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb053_desc
               
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmdb2_d[l_ac].pmdb053
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_pmdb2_d[l_ac].pmdb053 = g_pmdb2_d_t.pmdb053
                  CALL apmt400_detail_abg('3')
                       RETURNING l_success,l_errno,l_bgaf016,l_pmdb053,l_pmdb053_desc
                  LET g_pmdb2_d[l_ac].pmdb053_desc = l_pmdb053_desc
                  DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb053,g_pmdb2_d[l_ac].pmdb053_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #2015/08/19 by stellar add ----- (E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb053
            #add-point:BEFORE FIELD pmdb053 name="input.b.page2.pmdb053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb053
            #add-point:ON CHANGE pmdb053 name="input.g.page2.pmdb053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb053_desc
            #add-point:BEFORE FIELD pmdb053_desc name="input.b.page2.pmdb053_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb053_desc
            
            #add-point:AFTER FIELD pmdb053_desc name="input.a.page2.pmdb053_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb053_desc
            #add-point:ON CHANGE pmdb053_desc name="input.g.page2.pmdb053_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb037
            
            #add-point:AFTER FIELD pmdb037 name="input.a.page2.pmdb037"
            CALL apmt400_pmdb037_ref(g_pmdb2_d[l_ac].pmdb037) RETURNING g_pmdb2_d[l_ac].pmdb037_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb037_desc
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb037) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdb2_d[l_ac].pmdb037 != g_pmdb2_d_t.pmdb037 OR cl_null(g_pmdb2_d_t.pmdb037))) THEN   #160824-00007#339 Mark By Ken 170106
               IF (g_pmdb2_d[l_ac].pmdb037 != g_pmdb2_d_o.pmdb037 OR cl_null(g_pmdb2_d_o.pmdb037)) THEN   #160824-00007#339 Add By Ken 170106
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmdb2_d[l_ac].pmdb037
   
                   #160318-00025#16 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#16 by 07900 --add-end  
                  #呼叫檢查存在並帶值的library
                  #IF cl_chk_exist("v_ooef001") THEN     #161019-00017#2
                  IF cl_chk_exist("v_ooef001_13") THEN   #161019-00017#2
                     #檢查成功時後續處理
                     #檢查庫位、儲位是否在該營運據點下 
                     IF NOT cl_null(g_pmdb2_d[l_ac].pmdb038) THEN
                        IF NOT apmt400_pmdb038_chk() THEN
                           NEXT FIELD pmdb038
                        ELSE
                           IF NOT cl_null(g_pmdb2_d[l_ac].pmdb039) THEN
                              IF NOT apmt400_pmdb039_chk() THEN
                                 NEXT FIELD pmdb039
                              END IF
                            END IF
                        END IF
                     END IF  
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_pmdb2_d[l_ac].pmdb037 = g_pmdb2_d_t.pmdb037  #160824-00007#339 Mark By Ken 170106
                     LET g_pmdb2_d[l_ac].pmdb037 = g_pmdb2_d_o.pmdb037   #160824-00007#339 Add By Ken 170106
                     CALL apmt400_pmdb037_ref(g_pmdb2_d[l_ac].pmdb037) RETURNING g_pmdb2_d[l_ac].pmdb037_desc
                     DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb037_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_pmdb2_d[l_ac].pmdb038 = ''
               LET g_pmdb2_d[l_ac].pmdb038_desc = ''
               LET g_pmdb2_d[l_ac].pmdb039 = ''
               LET g_pmdb2_d[l_ac].pmdb039_desc = ''
               #160223-00004#1---add---begin---
               #預帶預設庫位的值，aooi200抓值優先順序：預設欄位>應用參數
               IF cl_null(g_pmdb2_d[l_ac].pmdb038) THEN
                  #預設欄位
                  CALL s_aooi200_get_slip(g_pmda_m.pmdadocno) RETURNING l_success,l_slip
                  IF l_success THEN
                     CALL s_aooi200_get_doc_default(g_site,'1',l_slip,'pmdb038',g_pmdb2_d[l_ac].pmdb038) RETURNING g_pmdb2_d[l_ac].pmdb038
                     #應用參數
                     IF cl_null(g_pmdb2_d[l_ac].pmdb038) THEN
                        CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0076') RETURNING g_pmdb2_d[l_ac].pmdb038
                     END IF
                  END IF          
               END IF
               #160223-00004#1---add---end---
               DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb038_desc,g_pmdb2_d[l_ac].pmdb039,g_pmdb2_d[l_ac].pmdb039_desc
            END IF
            CALL apmt400_set_entry_b(l_cmd)
            CALL apmt400_set_no_required_b()
            CALL apmt400_set_required_b()
            CALL apmt400_set_no_entry_b(l_cmd) 
            LET g_pmdb2_d_o.* = g_pmdb2_d[l_ac].*   #160824-00007#339 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb037
            #add-point:BEFORE FIELD pmdb037 name="input.b.page2.pmdb037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb037
            #add-point:ON CHANGE pmdb037 name="input.g.page2.pmdb037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb038
            
            #add-point:AFTER FIELD pmdb038 name="input.a.page2.pmdb038"
            CALL apmt400_pmdb038_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038) RETURNING g_pmdb2_d[l_ac].pmdb038_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb038_desc
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb038) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdb2_d[l_ac].pmdb038 != g_pmdb2_d_t.pmdb038 OR cl_null(g_pmdb2_d_t.pmdb038))) THEN   #160824-00007#339 Mark By Ken 170106
               IF (g_pmdb2_d[l_ac].pmdb038 != g_pmdb2_d_o.pmdb038 OR cl_null(g_pmdb2_d_o.pmdb038)) THEN   #160824-00007#339 Add By Ken 170106
                  IF NOT apmt400_pmdb038_chk() THEN
                     #檢查失敗時後續處理
                     #LET g_pmdb2_d[l_ac].pmdb038 = g_pmdb2_d_t.pmdb038  #160824-00007#339 Mark By Ken 170106
                     LET g_pmdb2_d[l_ac].pmdb038 = g_pmdb2_d_o.pmdb038   #160824-00007#339 Add By Ken 170106
                     CALL apmt400_pmdb038_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038) RETURNING g_pmdb2_d[l_ac].pmdb038_desc
                     DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb038_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #判斷當前儲位是否在該庫位編號下
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb039) THEN
               IF NOT apmt400_pmdb039_chk() THEN
                 #檢查失敗時後續處理
                 #LET g_pmdb2_d[l_ac].pmdb038 = g_pmdb2_d_t.pmdb038  #160824-00007#339 Mark By Ken 170106
                 LET g_pmdb2_d[l_ac].pmdb038 = g_pmdb2_d_o.pmdb038   #160824-00007#339 Add By Ken 170106                 
                 CALL apmt400_pmdb038_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038) RETURNING g_pmdb2_d[l_ac].pmdb038_desc
                 DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb038_desc
                 NEXT FIELD CURRENT
               END IF
            END IF
            LET g_pmdb2_d_o.* = g_pmdb2_d[l_ac].*   #160824-00007#339 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb038
            #add-point:BEFORE FIELD pmdb038 name="input.b.page2.pmdb038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb038
            #add-point:ON CHANGE pmdb038 name="input.g.page2.pmdb038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb039
            
            #add-point:AFTER FIELD pmdb039 name="input.a.page2.pmdb039"
            CALL apmt400_pmdb039_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039) RETURNING g_pmdb2_d[l_ac].pmdb039_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb039_desc
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb039) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdb2_d[l_ac].pmdb039 != g_pmdb2_d_t.pmdb039 OR cl_null(g_pmdb2_d_t.pmdb039))) THEN   #160824-00007#339 Mark By Ken 170106
               IF (g_pmdb2_d[l_ac].pmdb039 != g_pmdb2_d_o.pmdb039 OR cl_null(g_pmdb2_d_o.pmdb039)) THEN    #160824-00007#339 Add By Ken 170106
                  IF NOT apmt400_pmdb039_chk() THEN
                     #檢查失敗時後續處理
                     #LET g_pmdb2_d[l_ac].pmdb039 = g_pmdb2_d_t.pmdb039  #160824-00007#339 Mark By Ken 170106
                     LET g_pmdb2_d[l_ac].pmdb039 = g_pmdb2_d_o.pmdb039   #160824-00007#339 Add By Ken 170106
                     CALL apmt400_pmdb039_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039) RETURNING g_pmdb2_d[l_ac].pmdb039_desc
                     DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb039_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_pmdb2_d_o.* = g_pmdb2_d[l_ac].*   #160824-00007#339 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb039
            #add-point:BEFORE FIELD pmdb039 name="input.b.page2.pmdb039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb039
            #add-point:ON CHANGE pmdb039 name="input.g.page2.pmdb039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb054
            #add-point:BEFORE FIELD pmdb054 name="input.b.page2.pmdb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb054
            
            #add-point:AFTER FIELD pmdb054 name="input.a.page2.pmdb054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb054
            #add-point:ON CHANGE pmdb054 name="input.g.page2.pmdb054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb041
            #add-point:BEFORE FIELD pmdb041 name="input.b.page2.pmdb041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb041
            
            #add-point:AFTER FIELD pmdb041 name="input.a.page2.pmdb041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb041
            #add-point:ON CHANGE pmdb041 name="input.g.page2.pmdb041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb042
            #add-point:BEFORE FIELD pmdb042 name="input.b.page2.pmdb042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb042
            
            #add-point:AFTER FIELD pmdb042 name="input.a.page2.pmdb042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb042
            #add-point:ON CHANGE pmdb042 name="input.g.page2.pmdb042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb043
            #add-point:BEFORE FIELD pmdb043 name="input.b.page2.pmdb043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb043
            
            #add-point:AFTER FIELD pmdb043 name="input.a.page2.pmdb043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb043
            #add-point:ON CHANGE pmdb043 name="input.g.page2.pmdb043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb044
            #add-point:BEFORE FIELD pmdb044 name="input.b.page2.pmdb044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb044
            
            #add-point:AFTER FIELD pmdb044 name="input.a.page2.pmdb044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb044
            #add-point:ON CHANGE pmdb044 name="input.g.page2.pmdb044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb045
            #add-point:BEFORE FIELD pmdb045 name="input.b.page2.pmdb045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb045
            
            #add-point:AFTER FIELD pmdb045 name="input.a.page2.pmdb045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb045
            #add-point:ON CHANGE pmdb045 name="input.g.page2.pmdb045"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb046
            
            #add-point:AFTER FIELD pmdb046 name="input.a.page2.pmdb046"
            CALL apmt400_pmda003_ref(g_pmdb2_d[l_ac].pmdb046) RETURNING g_pmdb2_d[l_ac].pmdb046_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb046_desc 

            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb046) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdb2_d[l_ac].pmdb046
               LET g_chkparam.arg2 = g_pmda_m.pmdadocdt

                #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#16 by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pmdb2_d[l_ac].pmdb046 = g_pmdb2_d_t.pmdb046
                  CALL apmt400_pmda003_ref(g_pmdb2_d[l_ac].pmdb046) RETURNING g_pmdb2_d[l_ac].pmdb046_desc
                  DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb046_desc 
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb046
            #add-point:BEFORE FIELD pmdb046 name="input.b.page2.pmdb046"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb046
            #add-point:ON CHANGE pmdb046 name="input.g.page2.pmdb046"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.pmdb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb012
            #add-point:ON ACTION controlp INFIELD pmdb012 name="input.c.page2.pmdb012"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb012             #給予default值
            
            #給予arg

            CALL q_imaf001_5()                                #呼叫開窗

            LET g_pmdb2_d[l_ac].pmdb012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            DISPLAY g_pmdb2_d[l_ac].pmdb012 TO pmdb012              #顯示到畫面上
            CALL apmt400_pmdb012_ref(g_pmdb2_d[l_ac].pmdb012) RETURNING g_pmdb2_d[l_ac].pmdb012_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb012_desc
                     
            #DISPLAY g_pmdb2_d[l_ac].imaal003 TO imaal003 #品名

            NEXT FIELD pmdb012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb014
            #add-point:ON ACTION controlp INFIELD pmdb014 name="input.c.page2.pmdb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb015
            #add-point:ON ACTION controlp INFIELD pmdb015 name="input.c.page2.pmdb015"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "1=1 "
			
			   LET l_sql = ''
            #CALL s_control_get_sql("pmaa001",'4','3',g_user,g_dept) RETURNING l_success,l_sql
            #IF l_success THEN
            #   LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
            #END IF
            #
            #LET l_sql = ''
            #CALL s_control_get_doc_sql("pmaa083",g_pmda_m.pmdadocno,'2') RETURNING l_success,l_sql
            CALL s_control_get_supplier_sql('3',g_site,g_user,g_dept,g_pmda_m.pmdadocno) RETURNING l_success,l_sql
            IF l_success THEN
               IF cl_null(l_sql) THEN
                  LET l_sql = " 1=1"
               END IF
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
            END IF

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb015             #給予default值

            #給予arg

            CALL q_pmaa001_3()                                #呼叫開窗

            LET g_pmdb2_d[l_ac].pmdb015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb2_d[l_ac].pmdb015 TO pmdb015              #顯示到畫面上
            CALL apmt400_pmdb015_ref(g_pmdb2_d[l_ac].pmdb015) RETURNING g_pmdb2_d[l_ac].pmdb015_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb015_desc

            NEXT FIELD pmdb015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb016
            #add-point:ON ACTION controlp INFIELD pmdb016 name="input.c.page2.pmdb016"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb016             #給予default值
            IF NOT cl_null(g_pmdb2_d[l_ac].pmdb015) THEN
               #給予arg
               LET g_qryparam.arg1 = g_pmdb2_d[l_ac].pmdb015 #
               CALL q_pmad002_2()                                #呼叫開窗
            ELSE
               CALL q_ooib002_1()
            END IF

            LET g_pmdb2_d[l_ac].pmdb016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb2_d[l_ac].pmdb016 TO pmdb016              #顯示到畫面上
            CALL apmt400_pmdb016_ref(g_pmdb2_d[l_ac].pmdb016) RETURNING g_pmdb2_d[l_ac].pmdb016_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb016_desc

            NEXT FIELD pmdb016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb017
            #add-point:ON ACTION controlp INFIELD pmdb017 name="input.c.page2.pmdb017"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb017             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "238" #   #170213-00038#3 mark

            #CALL q_oocq002()                                #呼叫開窗   #170213-00038#3 mark
            CALL q_oocq002_238()  #170213-00038#3 add

            LET g_pmdb2_d[l_ac].pmdb017 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb2_d[l_ac].pmdb017 TO pmdb017              #顯示到畫面上
            CALL apmt400_pmdb017_ref(g_pmdb2_d[l_ac].pmdb017) RETURNING g_pmdb2_d[l_ac].pmdb017_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb017_desc

            NEXT FIELD pmdb017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb018
            #add-point:ON ACTION controlp INFIELD pmdb018 name="input.c.page2.pmdb018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb019
            #add-point:ON ACTION controlp INFIELD pmdb019 name="input.c.page2.pmdb019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb020
            #add-point:ON ACTION controlp INFIELD pmdb020 name="input.c.page2.pmdb020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb021
            #add-point:ON ACTION controlp INFIELD pmdb021 name="input.c.page2.pmdb021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb034
            #add-point:ON ACTION controlp INFIELD pmdb034 name="input.c.page2.pmdb034"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb034             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pjba001()                                #呼叫開窗

            LET g_pmdb2_d[l_ac].pmdb034 = g_qryparam.return1              

            DISPLAY g_pmdb2_d[l_ac].pmdb034 TO pmdb034              #
            CALL s_desc_get_project_desc(g_pmdb2_d[l_ac].pmdb034) RETURNING g_pmdb2_d[l_ac].pmdb034_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb034_desc
         
            NEXT FIELD pmdb034                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb035
            #add-point:ON ACTION controlp INFIELD pmdb035 name="input.c.page2.pmdb035"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb035             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdb2_d[l_ac].pmdb034  #s


            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_pmdb2_d[l_ac].pmdb035 = g_qryparam.return1              

            DISPLAY g_pmdb2_d[l_ac].pmdb035 TO pmdb035              #
            CALL s_desc_get_wbs_desc(g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb035) RETURNING g_pmdb2_d[l_ac].pmdb035_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb035_desc
         
            NEXT FIELD pmdb035                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb036
            #add-point:ON ACTION controlp INFIELD pmdb036 name="input.c.page2.pmdb036"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb036             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdb2_d[l_ac].pmdb034  #s


            CALL q_pjbm002()                                #呼叫開窗

            LET g_pmdb2_d[l_ac].pmdb036 = g_qryparam.return1              

            DISPLAY g_pmdb2_d[l_ac].pmdb036 TO pmdb036              #
            CALL s_desc_get_activity_desc(g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb036) RETURNING g_pmdb2_d[l_ac].pmdb036_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb036_desc

            NEXT FIELD pmdb036                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb053
            #add-point:ON ACTION controlp INFIELD pmdb053 name="input.c.page2.pmdb053"
            #2015/08/19 by stellar add ----- (S)
            CALL apmt400_detail_abg('1')
                 RETURNING l_success,l_errno,l_bgaf016,l_pmdb053,l_pmdb053_desc
            LET g_pmdb2_d[l_ac].pmdb053 = l_pmdb053
            LET g_pmdb2_d[l_ac].pmdb053_desc = l_pmdb053_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb053,g_pmdb2_d[l_ac].pmdb053_desc
            #2015/08/19 by stellar add ----- (E)
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb053_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb053_desc
            #add-point:ON ACTION controlp INFIELD pmdb053_desc name="input.c.page2.pmdb053_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb037
            #add-point:ON ACTION controlp INFIELD pmdb037 name="input.c.page2.pmdb037"
#此段落由子樣板a07產生            
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb037             #給予default值

            #給予arg

            #CALL q_ooef001()    #161019-00017#2
            CALL q_ooef001_1()  #161019-00017#2

            LET g_pmdb2_d[l_ac].pmdb037 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL apmt400_pmdb037_ref(g_pmdb2_d[l_ac].pmdb037) RETURNING g_pmdb2_d[l_ac].pmdb037_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb037_desc

            DISPLAY g_pmdb2_d[l_ac].pmdb037 TO pmdb037              #顯示到畫面上

            NEXT FIELD pmdb037                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb038
            #add-point:ON ACTION controlp INFIELD pmdb038 name="input.c.page2.pmdb038"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb038             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdb2_d[l_ac].pmdb037 #

            CALL q_inaa001_6()                                #呼叫開窗

            LET g_pmdb2_d[l_ac].pmdb038 = g_qryparam.return1              #將開窗取得的值回傳到變數

            CALL apmt400_pmdb038_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038) RETURNING g_pmdb2_d[l_ac].pmdb038_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb038_desc

            DISPLAY g_pmdb2_d[l_ac].pmdb038 TO pmdb038              #顯示到畫面上

            NEXT FIELD pmdb038                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb039
            #add-point:ON ACTION controlp INFIELD pmdb039 name="input.c.page2.pmdb039"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb039             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdb2_d[l_ac].pmdb037 #
            LET g_qryparam.arg2 = g_pmdb2_d[l_ac].pmdb038 #

            CALL q_inab002_6()                                #呼叫開窗

            LET g_pmdb2_d[l_ac].pmdb039 = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            CALL apmt400_pmdb039_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039) RETURNING g_pmdb2_d[l_ac].pmdb039_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb039_desc

            DISPLAY g_pmdb2_d[l_ac].pmdb039 TO pmdb039              #顯示到畫面上

            NEXT FIELD pmdb039                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb054
            #add-point:ON ACTION controlp INFIELD pmdb054 name="input.c.page2.pmdb054"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb041
            #add-point:ON ACTION controlp INFIELD pmdb041 name="input.c.page2.pmdb041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb042
            #add-point:ON ACTION controlp INFIELD pmdb042 name="input.c.page2.pmdb042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb043
            #add-point:ON ACTION controlp INFIELD pmdb043 name="input.c.page2.pmdb043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb044
            #add-point:ON ACTION controlp INFIELD pmdb044 name="input.c.page2.pmdb044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb045
            #add-point:ON ACTION controlp INFIELD pmdb045 name="input.c.page2.pmdb045"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.pmdb046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb046
            #add-point:ON ACTION controlp INFIELD pmdb046 name="input.c.page2.pmdb046"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac].pmdb046             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmda_m.pmdadocdt #

            CALL q_ooeg001()                                #呼叫開窗

            LET g_pmdb2_d[l_ac].pmdb046 = g_qryparam.return1              #將開窗取得的值回傳到變數

            CALL apmt400_pmda003_ref(g_pmdb2_d[l_ac].pmdb046) RETURNING g_pmdb2_d[l_ac].pmdb046_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb046_desc

            DISPLAY g_pmdb2_d[l_ac].pmdb046 TO pmdb046              #顯示到畫面上

            NEXT FIELD pmdb046                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            #2015/08/20 by stellar add ----- (S)
            IF l_insert1 THEN
               CALL s_aooi200_get_slip(g_pmda_m.pmdadocno) 
                    RETURNING l_success,l_slip
               IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'Y' THEN
                  IF cl_null(g_pmdb2_d[l_ac].pmdb053) THEN
                     NEXT FIELD pmdb053
                  END IF
               END IF
            END IF 
            #2015/08/20 by stellar add ----- (E)
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pmdb2_d[l_ac].* = g_pmdb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmt400_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL apmt400_unlock_b("pmdb_t","'2'")
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
               LET g_pmdb_d[li_reproduce_target].* = g_pmdb_d[li_reproduce].*
               LET g_pmdb2_d[li_reproduce_target].* = g_pmdb2_d[li_reproduce].*
 
               LET g_pmdb2_d[li_reproduce_target].pmdbseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmdb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmdb2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="apmt400.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      SUBDIALOG aoo_aooi360_01.aooi360_01_input   #备注单身  #161031-00025#8
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #130802-00004#158--add---begin---
         IF g_flag THEN
            LET g_flag = FALSE
            NEXT FIELD pmdb004
         END IF 
         #130802-00004#158--add---end---
         LET g_flag = FALSE   #161205-00025#1
         #161031-00025#8---s
         #為了修改功能doubleClick可以直接進入單身, 需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi360_01"
                  NEXT FIELD ooff012     
            END CASE
         END IF
         #161031-00025#8---e
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD pmdadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmdbsite
               WHEN "s_detail2"
                  NEXT FIELD pmdbseq_2
 
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
         #2015/08/19 by stellar add ----- (S)
         IF l_insert1 THEN
            CALL s_aooi200_get_slip(g_pmda_m.pmdadocno) 
                 RETURNING l_success,l_slip
            IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'Y' THEN
               IF cl_null(g_pmdb2_d[l_ac].pmdb053) THEN
                  NEXT FIELD pmdb053
               END IF
            END IF
         END IF
         #2015/08/19 by stellar add ----- (E)
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
         #2015/08/19 by stellar add ----- (S)
         IF l_insert1 THEN
            CALL s_aooi200_get_slip(g_pmda_m.pmdadocno) 
                 RETURNING l_success,l_slip
            IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'Y' THEN
               IF cl_null(g_pmdb2_d[l_ac].pmdb053) THEN
                  NEXT FIELD pmdb053
               END IF
            END IF
         END IF
         #2015/08/19 by stellar add ----- (E)
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         #2015/08/19 by stellar add ----- (S)
         IF l_insert1 THEN
            CALL s_aooi200_get_slip(g_pmda_m.pmdadocno) 
                 RETURNING l_success,l_slip
            IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'Y' THEN
               IF cl_null(g_pmdb2_d[l_ac].pmdb053) THEN
                  NEXT FIELD pmdb053
               END IF
            END IF
         END IF
         #2015/08/19 by stellar add ----- (E)
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
   #130802-00004#158--add---begin---
   IF g_flag THEN
      CALL apmt400_input('u')
   END IF
   #130802-00004#158--add---end---
   
   #重新計算整單的未稅、含稅總金額
   IF NOT cl_null(g_pmda_m.pmdadocno) THEN  #不是點退出的情況下
      CALL s_transaction_begin()
      CALL s_tax_recount_tmp()
      CALL s_tax_recount(g_pmda_m.pmdadocno)
        RETURNING g_pmda_m.pmda008,l_xrcd104,g_pmda_m.pmda009,l_xrcd113,l_xrcd114,l_xrcd115
      UPDATE pmda_t SET pmda008 = g_pmda_m.pmda008,
                        pmda009 = g_pmda_m.pmda009
          WHERE pmdaent = g_enterprise AND pmdadocno = g_pmda_m.pmdadocno
      IF SQLCA.sqlcode THEN
         CALL s_transaction_end('N','0')
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
   END IF
   CALL apmt400_b_fill()
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmt400_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_ooef016  LIKE ooef_t.ooef016
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_ooba002   LIKE ooba_t.ooba002
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apmt400_b_fill() #單身填充
      CALL apmt400_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmt400_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            IF NOT cl_null(g_pmda_m.pmdadocno) THEN
               CALL s_aooi200_get_slip(g_pmda_m.pmdadocno) RETURNING l_success,l_ooba002
               CALL s_aooi200_get_slip_desc(l_ooba002) RETURNING g_pmda_m.pmdadocno_desc
               DISPLAY BY NAME g_pmda_m.pmdadocno_desc
            END IF
            
            CALL apmt400_pmda002_ref(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
            DISPLAY BY NAME g_pmda_m.pmda002_desc
            #
            #CALL apmt400_pmda003_ref(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
            #DISPLAY BY NAME g_pmda_m.pmda003_desc
            
            CALL apmt400_pmda010_ref(g_pmda_m.pmda010) RETURNING g_pmda_m.pmda010_desc
            DISPLAY BY NAME g_pmda_m.pmda010_desc
            
            #CALL apmt400_pmda005_ref(g_pmda_m.pmda005) RETURNING g_pmda_m.pmda005_desc
            #DISPLAY BY NAME g_pmda_m.pmda005_desc
            
            LET g_pmda_m.ooan005 = ''
            IF NOT cl_null(g_pmda_m.pmda005) THEN
               LET l_ooef016 = ''
               SELECT ooef016 INTO l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
               CALL s_aooi160_get_exrate('1',g_site,g_today,g_pmda_m.pmda005,l_ooef016,0,'11') RETURNING g_pmda_m.ooan005
            END IF
            DISPLAY BY NAME g_pmda_m.ooan005            
            
            #CALL apmt400_pmda003_ref(g_pmda_m.pmda007) RETURNING g_pmda_m.pmda007_desc
            #DISPLAY BY NAME g_pmda_m.pmda007_desc
            #
            #CALL apmt400_pmda021_ref(g_pmda_m.pmda021) RETURNING g_pmda_m.pmda021_desc
            #DISPLAY BY NAME g_pmda_m.pmda021_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmda_m.pmdaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmda_m.pmdaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmda_m.pmdaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmda_m.pmdaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmda_m.pmdaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmda_m.pmdaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmda_m.pmdacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmda_m.pmdacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmda_m.pmdacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmda_m.pmdacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmda_m.pmdacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmda_m.pmdacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmda_m.pmdamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmda_m.pmdamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmda_m.pmdamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmda_m.pmdacnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmda_m.pmdacnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmda_m.pmdacnfid_desc

   #ming 20150821 add ---------------------------------(S) 
   CALL apmt400_pmda024_ref(g_pmda_m.pmda024) RETURNING g_pmda_m.pmda024_desc
   DISPLAY BY NAME g_pmda_m.pmda024_desc

   LET g_pmda_m.oofb017 = ''
   LET g_pmda_m.oofb017_1 = ''
   IF NOT cl_null(g_pmda_m.pmda024) THEN
      CALL s_aooi350_get_address(g_oofa001,g_pmda_m.pmda024,g_lang)
           RETURNING l_success,g_pmda_m.oofb017
   END IF
   DISPLAY BY NAME g_pmda_m.oofb017

   CALL apmt400_pmda025_ref(g_pmda_m.pmda025) RETURNING g_pmda_m.pmda025_desc
   DISPLAY BY NAME g_pmda_m.pmda025_desc

   IF NOT cl_null(g_pmda_m.pmda025) THEN
      CALL s_aooi350_get_address(g_oofa001,g_pmda_m.pmda025,g_lang)
           RETURNING l_success,g_pmda_m.oofb017_1
   END IF
   DISPLAY BY NAME g_pmda_m.oofb017_1
   #ming 20150821 add ---------------------------------(E) 
   #end add-point
   
   #遮罩相關處理
   LET g_pmda_m_mask_o.* =  g_pmda_m.*
   CALL apmt400_pmda_t_mask()
   LET g_pmda_m_mask_n.* =  g_pmda_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocno_desc,g_pmda_m.pmdadocdt, 
       g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmda003,g_pmda_m.pmda003_desc,g_pmda_m.pmdastus, 
       g_pmda_m.pmda004,g_pmda_m.pmda010,g_pmda_m.pmda010_desc,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005, 
       g_pmda_m.pmda005_desc,g_pmda_m.ooan005,g_pmda_m.pmda008,g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda007_desc, 
       g_pmda_m.pmda021,g_pmda_m.pmda021_desc,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda023_desc, 
       g_pmda_m.pmda022,g_pmda_m.pmda024,g_pmda_m.pmda024_desc,g_pmda_m.oofb017,g_pmda_m.pmda025,g_pmda_m.pmda025_desc, 
       g_pmda_m.oofb017_1,g_pmda_m.pmdaownid,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp,g_pmda_m.pmdaowndp_desc, 
       g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdacrtdt, 
       g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfid_desc, 
       g_pmda_m.pmdacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmda_m.pmdastus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "TJ"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/committed.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pmdb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            CALL apmt400_pmdb004_ref(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004

            #CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc
            #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb007_desc
            #
            #CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb009) RETURNING g_pmdb_d[l_ac].pmdb009_desc
            #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb009_desc
            #
            #CALL apmt400_unit_ref(g_pmdb_d[l_ac].pmdb011) RETURNING g_pmdb_d[l_ac].pmdb011_desc
            #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb011_desc
            #
            #CALL apmt400_pmdb048_ref(g_pmdb_d[l_ac].pmdb048) RETURNING g_pmdb_d[l_ac].pmdb048_desc
            #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb048_desc

            CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005_desc
            
            CALL apmt400_pmdb031_ref(g_pmdb_d[l_ac].pmdb031) RETURNING g_pmdb_d[l_ac].pmdb031_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb031_desc
            
            IF g_pmda_m.pmdastus = 'H' THEN  #留置狀態下，顯示留置理由碼說明
               CALL s_desc_get_acc_desc('317',g_pmdb_d[l_ac].pmdb051) RETURNING g_pmdb_d[l_ac].pmdb051_desc
               DISPLAY BY NAME g_pmdb_d[l_ac].pmdb051_desc
            ELSE
               #160831-00002#1 --- add (S) ---
               IF g_pmdb_d[l_ac].pmdb032 <> '1' THEN
                  IF g_pmdb_d[l_ac].pmdb032 = '5' THEN    #單身為留置
                     CALL s_desc_get_acc_desc('317',g_pmdb_d[l_ac].pmdb051) RETURNING g_pmdb_d[l_ac].pmdb051_desc
                     DISPLAY BY NAME g_pmdb_d[l_ac].pmdb051_desc
                  ELSE
               #160831-00002#1 --- add (E) ---
                     CALL s_desc_get_acc_desc('258',g_pmdb_d[l_ac].pmdb051) RETURNING g_pmdb_d[l_ac].pmdb051_desc
                     DISPLAY BY NAME g_pmdb_d[l_ac].pmdb051_desc
               #160831-00002#1 --- add (S) ---
                  END IF
               END IF
               #160831-00002#1 --- add (E) ---
            END IF

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_pmdb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
            LET g_pmdb2_d[l_ac].pmdbseq = g_pmdb_d[l_ac].pmdbseq
            LET g_pmdb2_d[l_ac].imaal001 = g_pmdb_d[l_ac].pmdb004
            LET g_pmdb2_d[l_ac].imaal003 = g_pmdb_d[l_ac].pmdb004_desc
            LET g_pmdb2_d[l_ac].imaal004 = g_pmdb_d[l_ac].imaal004
            
            CALL apmt400_pmdb012_ref(g_pmdb2_d[l_ac].pmdb012) RETURNING g_pmdb2_d[l_ac].pmdb012_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb012_desc
            #
            #CALL apmt400_pmdb015_ref(g_pmdb2_d[l_ac].pmdb015) RETURNING g_pmdb2_d[l_ac].pmdb015_desc
            #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb015_desc
            #
            #CALL apmt400_pmdb016_ref(g_pmdb2_d[l_ac].pmdb016) RETURNING g_pmdb2_d[l_ac].pmdb016_desc
            #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb016_desc
            #
            #CALL apmt400_pmdb017_ref(g_pmdb2_d[l_ac].pmdb017) RETURNING g_pmdb2_d[l_ac].pmdb017_desc
            #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb017_desc
            #
            #CALL apmt400_pmdb037_ref(g_pmdb2_d[l_ac].pmdb037) RETURNING g_pmdb2_d[l_ac].pmdb037_desc
            #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb037_desc

            CALL apmt400_pmdb038_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038) RETURNING g_pmdb2_d[l_ac].pmdb038_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb038_desc
            
            CALL apmt400_pmdb039_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039) RETURNING g_pmdb2_d[l_ac].pmdb039_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb039_desc

            #CALL apmt400_pmda003_ref(g_pmdb2_d[l_ac].pmdb046) RETURNING g_pmdb2_d[l_ac].pmdb046_desc
            #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb046_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apmt400_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apmt400_detail_show()
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
 
{<section id="apmt400.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmt400_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pmda_t.pmdadocno 
   DEFINE l_oldno     LIKE pmda_t.pmdadocno 
 
   DEFINE l_master    RECORD LIKE pmda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmdb_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_pmda_m.pmdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
    
   LET g_pmda_m.pmdadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmda_m.pmdaownid = g_user
      LET g_pmda_m.pmdaowndp = g_dept
      LET g_pmda_m.pmdacrtid = g_user
      LET g_pmda_m.pmdacrtdp = g_dept 
      LET g_pmda_m.pmdacrtdt = cl_get_current()
      LET g_pmda_m.pmdamodid = g_user
      LET g_pmda_m.pmdamoddt = cl_get_current()
      LET g_pmda_m.pmdastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmda_m.pmdastus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "TJ"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/committed.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_pmda_m.pmdadocno_desc = ''
   DISPLAY BY NAME g_pmda_m.pmdadocno_desc
 
   
   CALL apmt400_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pmda_m.* TO NULL
      INITIALIZE g_pmdb_d TO NULL
      INITIALIZE g_pmdb2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apmt400_show()
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
   CALL apmt400_set_act_visible()   
   CALL apmt400_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmdaent = " ||g_enterprise|| " AND",
                      " pmdadocno = '", g_pmda_m.pmdadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL apmt400_idx_chk()
   
   LET g_data_owner = g_pmda_m.pmdaownid      
   LET g_data_dept  = g_pmda_m.pmdaowndp
   
   #功能已完成,通報訊息中心
   CALL apmt400_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmt400_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmdb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE  l_imaf171       LIKE imaf_t.imaf171
   DEFINE  l_imaf172       LIKE imaf_t.imaf172
   DEFINE  l_imaf173       LIKE imaf_t.imaf173
   DEFINE  l_imaf174       LIKE imaf_t.imaf174
   DEFINE  l_imaf175       LIKE imaf_t.imaf175
   DEFINE  l_time1         LIKE imaf_t.imaf171
   DEFINE  l_time2         LIKE imaf_t.imaf171
   DEFINE  l_pmdbseq       LIKE pmdb_t.pmdbseq
   DEFINE  l_pmdb004       LIKE pmdb_t.pmdb004
   DEFINE  l_pmdb030       LIKE pmdb_t.pmdb030
   DEFINE  l_pmdb033       LIKE pmdb_t.pmdb033
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmt400_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmdb_t
    WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmdadocno_t
 
    INTO TEMP apmt400_detail
 
   #將key修正為調整後   
   UPDATE apmt400_detail 
      #更新key欄位
      SET pmdbdocno = g_pmda_m.pmdadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pmdb_t SELECT * FROM apmt400_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
              
   UPDATE pmdb_t SET pmdb032 = '1',pmdb049 = 0,pmdb051 = '' WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
   
   #更新緊急度欄位
   DECLARE upd_pmdb033 CURSOR FOR
      SELECT pmdbseq,pmdb004 FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
    FOREACH upd_pmdb033 INTO l_pmdbseq,l_pmdb004,l_pmdb030
       LET l_imaf171 = 0
       LET l_imaf172 = 0
       LET l_imaf173 = 0
       LET l_imaf174 = 0
       LET l_imaf175 = 0
       LET l_time1 = 0
       LET l_time2 = 0
       
       SELECT imaf171,imaf172,imaf173,imaf174,imaf175 INTO l_imaf171,l_imaf172,l_imaf173,l_imaf174,l_imaf175
         FROM imaf_t 
         WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb004
       LET l_time1 = l_pmdb030 - g_today         #需求日期 - g_today
       LET l_time2 = l_imaf171+l_imaf172+l_imaf173+l_imaf174  #[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數
       
       LET l_pmdb033 = '1'
       
       #1.若輸入的需求日期 - g_today >[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數時，則[C:緊急度] = '1'(一般)
       IF l_time1 >= l_time2 THEN
          LET l_pmdb033 = '1'
       END IF
       
       #2.若輸入的需求日期 - g_today <[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數，
       #   且需求日期 - g_today >[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '2'(緊急)
       IF l_time1 < l_time2 AND l_time1 >= l_imaf175 THEN
          LET l_pmdb033 = '2'
       END IF
       
       #3.若輸入的需求日期 - g_today <[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '3'(特急)
       IF l_time1 < l_imaf175 THEN
          LET l_pmdb033 = '3'
       END IF
       
       UPDATE pmdb_t  SET pmdb033 = l_pmdb033 WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno AND pmdbseq = l_pmdbseq

   END FOREACH
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apmt400_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmt400_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_success       LIKE type_t.num5     #2015/08/20 by stellar add
   DEFINE  l_pmdb002       LIKE pmdb_t.pmdb002
   DEFINE  l_pmdb034       LIKE pmdb_t.pmdb034
   DEFINE  l_pmdb035       LIKE pmdb_t.pmdb035
   DEFINE  l_pmdb006       LIKE pmdb_t.pmdb006
   DEFINE  l_pmdb004       LIKE pmdb_t.pmdb004
   DEFINE  l_pmdb007       LIKE pmdb_t.pmdb007
   DEFINE  l_pjbd006       LIKE pjbd_t.pjbd006
   DEFINE  l_sql           STRING

   DEFINE  l_pmdb005       LIKE pmdb_t.pmdb005
   DEFINE  l_n             LIKE type_t.num5    #160920-00035#1
   #160920-00035#1---s
   DEFINE l_pspcsite       LIKE pspc_t.pspcsite
   DEFINE l_pspc001        LIKE pspc_t.pspc001
   DEFINE l_pspc002        LIKE pspc_t.pspc002
   DEFINE l_pspc004        LIKE pspc_t.pspc004
   DEFINE l_pspc061        LIKE pspc_t.pspc061
   DEFINE l_pmdbseq        LIKE pmdb_t.pmdbseq
   DEFINE l_pmdb001        LIKE pmdb_t.pmdb001
   #160920-00035#1--e
   DEFINE l_ooff012        LIKE ooff_t.ooff012  #161031-00025#8
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_pmda_m.pmdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN apmt400_cl USING g_enterprise,g_pmda_m.pmdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt400_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt400_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmdadocno, 
       g_pmda_m.pmda001,g_pmda_m.pmdadocdt,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004, 
       g_pmda_m.pmda010,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008,g_pmda_m.pmda009, 
       g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda022, 
       g_pmda_m.pmda024,g_pmda_m.pmda025,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp, 
       g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda005_desc,g_pmda_m.pmda007_desc,g_pmda_m.pmda021_desc, 
       g_pmda_m.pmda023_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid_desc, 
       g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT apmt400_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmda_m_mask_o.* =  g_pmda_m.*
   CALL apmt400_pmda_t_mask()
   LET g_pmda_m_mask_n.* =  g_pmda_m.*
   
   CALL apmt400_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmt400_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
 
      DELETE FROM pmda_t
       WHERE pmdaent = g_enterprise AND pmdadocno = g_pmda_m.pmdadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_pmda_m.pmdadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_pmda_m.pmdadocno,g_pmda_m.pmdadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #161031-00025#8---s
#      IF NOT s_aooi360_del('6','apmt400',g_pmda_m.pmdadocno,'','','','','','','','','4') THEN
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF 
      #161031-00025#8---e
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      #2015/08/20 by stellar add ----- (S)
      CALL s_apmt400_stus_abg1(g_pmda_m.pmdadocno,'D')
           RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #2015/08/20 by stellar add ----- (E)
      
      #add by lixh 20151012  
      #專案回寫
      LET l_sql = " SELECT DISTINCT pmdb002,pmdb034,pmdb035,pmdb006,pmdb004,pmdb007, ",
                  "                 pmdb001,pmdb005,pmdbseq ",    
                  "   FROM pmdb_t ",
                  "  WHERE pmdbent = ",g_enterprise,
                  "    AND pmdbdocno = '",g_pmda_m.pmdadocno,"'",
                  "    AND pmdb034 IS NOT NULL "
      PREPARE apmt400_pjbd_sel FROM l_sql
      DECLARE apmt400_pjbd_curs CURSOR FOR apmt400_pjbd_sel                  
      FOREACH apmt400_pjbd_curs INTO l_pmdb002,l_pmdb034,l_pmdb035,l_pmdb006,l_pmdb004,l_pmdb007
         #add by lixh 20151023
         #單位換算
         SELECT pjbd006 INTO l_pjbd006 FROM pjbd_t
          WHERE pjbdent = g_enterprise
            AND pjbd001 = l_pmdb034
            AND pjbd002 = l_pmdb035
            AND pjbd003 = l_pmdb002  
               
         CALL s_aooi250_convert_qty(l_pmdb004,l_pmdb007,l_pjbd006,l_pmdb006)   
              RETURNING l_success,l_pmdb006                 
         #add by lixh 20151023      
         UPDATE pjbd_t SET pjbd011 = pjbd011 - l_pmdb006
          WHERE pjbdent = g_enterprise
            AND pjbd001 = l_pmdb034
            AND pjbd002 = l_pmdb035
            AND pjbd003 = l_pmdb002   
      END FOREACH
      #add by lixh 20151012
      
      #160920-00035#1---s
      DECLARE aps_cs1 CURSOR FOR 
          SELECT DISTINCT pmdbseq,pmdb001,pmdb004,pmdb005,pmdb006 FROM pmdb_t 
             WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
      LET l_sql =  " SELECT DISTINCT pspcsite,pspc001,pspc002,pspc004,pspc061 FROM pspc_t ",
                   "    WHERE pspcent = ",g_enterprise," AND pspc004 = ? ", 
                   "      AND pspc050 = ? AND pspc051 = ? ",
                   "      AND pspc055 = '",g_pmda_m.pmdadocno,"' AND pspc056 = ? "
      PREPARE apmt400_aps_sel FROM l_sql
      DECLARE apmt400_aps_upd1 CURSOR FOR apmt400_aps_sel      
      
      FOREACH aps_cs1 INTO l_pmdbseq,l_pmdb001,l_pmdb004,l_pmdb005,l_pmdb006
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         FOREACH apmt400_aps_upd1 USING l_pmdb001,l_pmdb004,l_pmdb005,l_pmdbseq 
                 INTO l_pspcsite,l_pspc001,l_pspc002,l_pspc004,l_pspc061
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            IF l_pspc061 > l_pmdb006 THEN
               UPDATE pspc_t SET pspc061 = pspc061 - l_pmdb006
                  WHERE pspcent = g_enterprise AND pspcsite = l_pspcsite AND pspc001 = l_pspc001
                    AND pspc004 = l_pspc004
            ELSE
               UPDATE pspc_t SET pspc055 = '',
                                 pspc056 = '',
                                 pspc061 = 0
                  WHERE pspcent = g_enterprise AND pspcsite = l_pspcsite AND pspc001 = l_pspc001
                    AND pspc004 = l_pspc004
            END IF
         END FOREACH
      END FOREACH
      #160920-00035#1--e
      
      #end add-point
      
      DELETE FROM pmdb_t
       WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      #161031-00025#8---s
      #单头的aooi360_01的备注单身资料同步删除
      DECLARE ooff_cs CURSOR FOR
         SELECT ooff012 INTO l_ooff012 FROM ooff_t WHERE ooffent = g_enterprise AND ooff001 = '6' AND ooff002 = g_pmda_m.pmdadocno AND ooff003 = 0
      FOREACH ooff_cs INTO l_ooff012   
         IF NOT s_aooi360_del('6',g_prog,g_pmda_m.pmdadocno,'','','','','','','','',l_ooff012) THEN
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END FOREACH
      CALL aooi360_01_clear_detail()   #清除备注单身  
      
      #单身的长备注栏位也要同步删除
      IF NOT s_aooi360_del('7',g_prog,g_pmda_m.pmdadocno,'','','','','','','','','1') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #161031-00025#8---e
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmda_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apmt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pmdb_d.clear() 
      CALL g_pmdb2_d.clear()       
 
     
      CALL apmt400_ui_browser_refresh()  
      #CALL apmt400_ui_headershow()  
      #CALL apmt400_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apmt400_browser_fill("")
         CALL apmt400_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmt400_cl
 
   #功能已完成,通報訊息中心
   CALL apmt400_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmt400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmt400_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE  l_success LIKE type_t.num5
   DEFINE l_errno          LIKE gzze_t.gzze001     #2015/08/20 by stellar
   DEFINE l_bgaf016        LIKE bgaf_t.bgaf016     #2015/08/20 by stellar
   DEFINE l_pmdb053        LIKE pmdb_t.pmdb053     #2015/08/20 by stellar
   DEFINE l_pmdb053_desc   LIKE type_t.chr80       #2015/08/20 by stellar
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pmdb_d.clear()
   CALL g_pmdb2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF apmt400_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmdbsite,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb052,pmdb004,pmdb005, 
             pmdb007,pmdb006,pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050,pmdb032, 
             pmdb051,pmdb033,pmdb049,pmdbseq,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019, 
             pmdb020,pmdb021,pmdb034,pmdb035,pmdb036,pmdb053,pmdb037,pmdb038,pmdb039,pmdb054,pmdb041, 
             pmdb042,pmdb043,pmdb044,pmdb045,pmdb046 ,t1.imaal003 ,t2.inaml004 ,t3.oocal003 ,t4.oocal003 , 
             t5.oocal003 ,t6.oocql004 ,t7.imaal003 ,t8.pmaal004 ,t9.ooibl004 ,t10.oocql004 ,t11.pjbal003 , 
             t12.pjbbl004 ,t13.pjbml004 ,t14.ooefl003 ,t15.inayl003 ,t16.inab003 ,t17.ooefl003 FROM pmdb_t", 
                
                     " INNER JOIN pmda_t ON pmdaent = " ||g_enterprise|| " AND pmdadocno = pmdbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=pmdb004 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inaml_t t2 ON t2.inamlent="||g_enterprise||" AND t2.inaml001=pmdb004 AND t2.inaml002=pmdb005 AND t2.inaml003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=pmdb007 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=pmdb009 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=pmdb011 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='274' AND t6.oocql002=pmdb048 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t7 ON t7.imaalent="||g_enterprise||" AND t7.imaal001=pmdb012 AND t7.imaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t8 ON t8.pmaalent="||g_enterprise||" AND t8.pmaal001=pmdb015 AND t8.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t9 ON t9.ooiblent="||g_enterprise||" AND t9.ooibl002=pmdb016 AND t9.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='238' AND t10.oocql002=pmdb017 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t11 ON t11.pjbalent="||g_enterprise||" AND t11.pjbal001=pmdb034 AND t11.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t12 ON t12.pjbblent="||g_enterprise||" AND t12.pjbbl001=pmdb034 AND t12.pjbbl002=pmdb035 AND t12.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN pjbml_t t13 ON t13.pjbmlent="||g_enterprise||" AND t13.pjbml001=pmdb034 AND t13.pjbml002=pmdb036 AND t13.pjbml003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent="||g_enterprise||" AND t14.ooefl001=pmdb037 AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t15 ON t15.inaylent="||g_enterprise||" AND t15.inayl001=pmdb038 AND t15.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t16 ON t16.inabent="||g_enterprise||" AND t16.inabsite=pmdb037 AND t16.inab001=pmdb038 AND t16.inab002=pmdb039  ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=pmdb046 AND t17.ooefl002='"||g_dlang||"' ",
 
                     " WHERE pmdbent=? AND pmdbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmdb_t.pmdbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
 
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt400_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmt400_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmda_m.pmdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmda_m.pmdadocno INTO g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdbseq, 
          g_pmdb_d[l_ac].pmdb001,g_pmdb_d[l_ac].pmdb002,g_pmdb_d[l_ac].pmdb003,g_pmdb_d[l_ac].pmdb052, 
          g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb006, 
          g_pmdb_d[l_ac].pmdb009,g_pmdb_d[l_ac].pmdb008,g_pmdb_d[l_ac].pmdb011,g_pmdb_d[l_ac].pmdb010, 
          g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb031,g_pmdb_d[l_ac].pmdb050, 
          g_pmdb_d[l_ac].pmdb032,g_pmdb_d[l_ac].pmdb051,g_pmdb_d[l_ac].pmdb033,g_pmdb_d[l_ac].pmdb049, 
          g_pmdb2_d[l_ac].pmdbseq,g_pmdb2_d[l_ac].pmdb012,g_pmdb2_d[l_ac].pmdb014,g_pmdb2_d[l_ac].pmdb015, 
          g_pmdb2_d[l_ac].pmdb016,g_pmdb2_d[l_ac].pmdb017,g_pmdb2_d[l_ac].pmdb018,g_pmdb2_d[l_ac].pmdb019, 
          g_pmdb2_d[l_ac].pmdb020,g_pmdb2_d[l_ac].pmdb021,g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb035, 
          g_pmdb2_d[l_ac].pmdb036,g_pmdb2_d[l_ac].pmdb053,g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038, 
          g_pmdb2_d[l_ac].pmdb039,g_pmdb2_d[l_ac].pmdb054,g_pmdb2_d[l_ac].pmdb041,g_pmdb2_d[l_ac].pmdb042, 
          g_pmdb2_d[l_ac].pmdb043,g_pmdb2_d[l_ac].pmdb044,g_pmdb2_d[l_ac].pmdb045,g_pmdb2_d[l_ac].pmdb046, 
          g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb005_desc,g_pmdb_d[l_ac].pmdb007_desc,g_pmdb_d[l_ac].pmdb009_desc, 
          g_pmdb_d[l_ac].pmdb011_desc,g_pmdb_d[l_ac].pmdb048_desc,g_pmdb2_d[l_ac].pmdb012_desc,g_pmdb2_d[l_ac].pmdb015_desc, 
          g_pmdb2_d[l_ac].pmdb016_desc,g_pmdb2_d[l_ac].pmdb017_desc,g_pmdb2_d[l_ac].pmdb034_desc,g_pmdb2_d[l_ac].pmdb035_desc, 
          g_pmdb2_d[l_ac].pmdb036_desc,g_pmdb2_d[l_ac].pmdb037_desc,g_pmdb2_d[l_ac].pmdb038_desc,g_pmdb2_d[l_ac].pmdb039_desc, 
          g_pmdb2_d[l_ac].pmdb046_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL apmt400_pmdb004_ref(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004
         DISPLAY BY NAME g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004
            
         LET g_pmdb2_d[l_ac].pmdbseq = g_pmdb_d[l_ac].pmdbseq
         LET g_pmdb2_d[l_ac].imaal001 = g_pmdb_d[l_ac].pmdb004
         LET g_pmdb2_d[l_ac].imaal003 = g_pmdb_d[l_ac].pmdb004_desc
         LET g_pmdb2_d[l_ac].imaal004 = g_pmdb_d[l_ac].imaal004
         
         #161205-00025#1--s
         #CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
         #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005_desc
         #161205-00025#1--e
         
         CALL apmt400_pmdb031_ref(g_pmdb_d[l_ac].pmdb031) RETURNING g_pmdb_d[l_ac].pmdb031_desc
         DISPLAY BY NAME g_pmdb_d[l_ac].pmdb031_desc
         
         IF g_pmda_m.pmdastus = 'H' THEN  #留置狀態下，顯示留置理由碼說明
            CALL s_desc_get_acc_desc('317',g_pmdb_d[l_ac].pmdb051) RETURNING g_pmdb_d[l_ac].pmdb051_desc
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb051_desc
         ELSE
            #160831-00002#1 --- add (S) ---
            IF g_pmdb_d[l_ac].pmdb032 <> '1' THEN
               IF g_pmdb_d[l_ac].pmdb032 = '5' THEN    #單身為留置
                  CALL s_desc_get_acc_desc('317',g_pmdb_d[l_ac].pmdb051) RETURNING g_pmdb_d[l_ac].pmdb051_desc
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb051_desc
               ELSE
            #160831-00002#1 --- add (E) ---
                  CALL s_desc_get_acc_desc('258',g_pmdb_d[l_ac].pmdb051) RETURNING g_pmdb_d[l_ac].pmdb051_desc
                  DISPLAY BY NAME g_pmdb_d[l_ac].pmdb051_desc
            #160831-00002#1 --- add (S) ---
               END IF
            END IF
            #160831-00002#1 --- add (E) ---
         END IF
         
         #161205-00025#1--s
         #CALL apmt400_pmdb012_ref(g_pmdb2_d[l_ac].pmdb012) RETURNING g_pmdb2_d[l_ac].pmdb012_desc
         #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb012_desc
         #
         #CALL apmt400_pmdb038_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038) RETURNING g_pmdb2_d[l_ac].pmdb038_desc
         #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb038_desc
         #
         #CALL apmt400_pmdb039_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039) RETURNING g_pmdb2_d[l_ac].pmdb039_desc
         #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb039_desc
         #
         #CALL s_desc_get_project_desc(g_pmdb2_d[l_ac].pmdb034) RETURNING g_pmdb2_d[l_ac].pmdb034_desc
         #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb034_desc
         #
         #CALL s_desc_get_wbs_desc(g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb035) RETURNING g_pmdb2_d[l_ac].pmdb035_desc
         #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb035_desc
         #
         #CALL s_desc_get_activity_desc(g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb036) RETURNING g_pmdb2_d[l_ac].pmdb036_desc
         #DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb036_desc
         #161205-00025#1--e
         
         #2015/08/20 by stellar add ----- (S)
         CALL apmt400_detail_abg('3')
              RETURNING l_success,l_errno,l_bgaf016,l_pmdb053,l_pmdb053_desc
         LET g_pmdb2_d[l_ac].pmdb053_desc = l_pmdb053_desc
         #2015/08/20 by stellar add ----- (E) 
         #161031-00025#8---s
         CALL s_aooi360_sel('7',g_prog,g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,'','','','','','','','1') RETURNING l_success,g_pmdb_d[l_ac].ooff013
         #161031-00025#8---e
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
   #161031-00025#8---s
   LET g_ooff001_d = '6'   #6.單據單頭備註
   LET g_ooff002_d = g_prog
   LET g_ooff003_d = g_pmda_m.pmdadocno   #单号
   LET g_ooff004_d = 0     #项次
   LET g_ooff005_d = ' '
   LET g_ooff006_d = ' '
   LET g_ooff007_d = ' '
   LET g_ooff008_d = ' '
   LET g_ooff009_d = ' '
   LET g_ooff010_d = ' '
   LET g_ooff011_d = ' '
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身 
   #161031-00025#8---e   
   #end add-point
   
   CALL g_pmdb_d.deleteElement(g_pmdb_d.getLength())
   CALL g_pmdb2_d.deleteElement(g_pmdb2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apmt400_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmdb_d.getLength()
      LET g_pmdb_d_mask_o[l_ac].* =  g_pmdb_d[l_ac].*
      CALL apmt400_pmdb_t_mask()
      LET g_pmdb_d_mask_n[l_ac].* =  g_pmdb_d[l_ac].*
   END FOR
   
   LET g_pmdb2_d_mask_o.* =  g_pmdb2_d.*
   FOR l_ac = 1 TO g_pmdb2_d.getLength()
      LET g_pmdb2_d_mask_o[l_ac].* =  g_pmdb2_d[l_ac].*
      CALL apmt400_pmdb_t_mask()
      LET g_pmdb2_d_mask_n[l_ac].* =  g_pmdb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmt400_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   DEFINE l_pjbd006   LIKE pjbd_t.pjbd006
   DEFINE l_pmdb006   LIKE pmdb_t.pmdb006
   DEFINE l_success   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      IF NOT cl_null(g_pmdb2_d[l_ac].pmdb034) THEN
         #add by lixh 20151023
         #單位換算
         SELECT pjbd006 INTO l_pjbd006 FROM pjbd_t
          WHERE pjbdent = g_enterprise
            AND pjbd001 = g_pmdb2_d[l_ac].pmdb034
            AND pjbd002 = g_pmdb2_d[l_ac].pmdb035
            AND pjbd003 = g_pmdb_d[l_ac].pmdb002 
               
         CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,l_pjbd006,g_pmdb_d[l_ac].pmdb006) 
              RETURNING l_success,l_pmdb006                 
         #add by lixh 20151023           
         UPDATE pjbd_t SET pjbd011 = pjbd011 - l_pmdb006
          WHERE pjbdent = g_enterprise
            AND pjbd001 = g_pmdb2_d[l_ac].pmdb034
            AND pjbd002 = g_pmdb2_d[l_ac].pmdb035
            AND pjbd003 = g_pmdb_d[l_ac].pmdb002 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN FALSE
         END IF         
      END IF   
      #end add-point    
      DELETE FROM pmdb_t
       WHERE pmdbent = g_enterprise AND
         pmdbdocno = ps_keys_bak[1] AND pmdbseq = ps_keys_bak[2]
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
         CALL g_pmdb_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_pmdb2_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmt400_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      IF cl_null(g_pmdb_d[g_detail_idx].pmdb011) OR cl_null(g_pmdb_d[g_detail_idx].pmdb010) THEN
         LET g_pmdb_d[g_detail_idx].pmdb010 = g_pmdb_d[g_detail_idx].pmdb006
         LET g_pmdb_d[g_detail_idx].pmdb011 = g_pmdb_d[g_detail_idx].pmdb007
      END IF
      IF cl_null(g_pmdb_d[g_detail_idx].pmdb005) THEN
         LET g_pmdb_d[g_detail_idx].pmdb005 = ' '
      END IF
      #end add-point 
      INSERT INTO pmdb_t
                  (pmdbent,
                   pmdbdocno,
                   pmdbseq
                   ,pmdbsite,pmdb001,pmdb002,pmdb003,pmdb052,pmdb004,pmdb005,pmdb007,pmdb006,pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050,pmdb032,pmdb051,pmdb033,pmdb049,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb034,pmdb035,pmdb036,pmdb053,pmdb037,pmdb038,pmdb039,pmdb054,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb046) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_pmdb_d[g_detail_idx].pmdbsite,g_pmdb_d[g_detail_idx].pmdb001,g_pmdb_d[g_detail_idx].pmdb002, 
                       g_pmdb_d[g_detail_idx].pmdb003,g_pmdb_d[g_detail_idx].pmdb052,g_pmdb_d[g_detail_idx].pmdb004, 
                       g_pmdb_d[g_detail_idx].pmdb005,g_pmdb_d[g_detail_idx].pmdb007,g_pmdb_d[g_detail_idx].pmdb006, 
                       g_pmdb_d[g_detail_idx].pmdb009,g_pmdb_d[g_detail_idx].pmdb008,g_pmdb_d[g_detail_idx].pmdb011, 
                       g_pmdb_d[g_detail_idx].pmdb010,g_pmdb_d[g_detail_idx].pmdb030,g_pmdb_d[g_detail_idx].pmdb048, 
                       g_pmdb_d[g_detail_idx].pmdb031,g_pmdb_d[g_detail_idx].pmdb050,g_pmdb_d[g_detail_idx].pmdb032, 
                       g_pmdb_d[g_detail_idx].pmdb051,g_pmdb_d[g_detail_idx].pmdb033,g_pmdb_d[g_detail_idx].pmdb049, 
                       g_pmdb2_d[g_detail_idx].pmdb012,g_pmdb2_d[g_detail_idx].pmdb014,g_pmdb2_d[g_detail_idx].pmdb015, 
                       g_pmdb2_d[g_detail_idx].pmdb016,g_pmdb2_d[g_detail_idx].pmdb017,g_pmdb2_d[g_detail_idx].pmdb018, 
                       g_pmdb2_d[g_detail_idx].pmdb019,g_pmdb2_d[g_detail_idx].pmdb020,g_pmdb2_d[g_detail_idx].pmdb021, 
                       g_pmdb2_d[g_detail_idx].pmdb034,g_pmdb2_d[g_detail_idx].pmdb035,g_pmdb2_d[g_detail_idx].pmdb036, 
                       g_pmdb2_d[g_detail_idx].pmdb053,g_pmdb2_d[g_detail_idx].pmdb037,g_pmdb2_d[g_detail_idx].pmdb038, 
                       g_pmdb2_d[g_detail_idx].pmdb039,g_pmdb2_d[g_detail_idx].pmdb054,g_pmdb2_d[g_detail_idx].pmdb041, 
                       g_pmdb2_d[g_detail_idx].pmdb042,g_pmdb2_d[g_detail_idx].pmdb043,g_pmdb2_d[g_detail_idx].pmdb044, 
                       g_pmdb2_d[g_detail_idx].pmdb045,g_pmdb2_d[g_detail_idx].pmdb046)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pmdb_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_pmdb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmt400_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmdb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL apmt400_pmdb_t_mask_restore('restore_mask_o')
               
      UPDATE pmdb_t 
         SET (pmdbdocno,
              pmdbseq
              ,pmdbsite,pmdb001,pmdb002,pmdb003,pmdb052,pmdb004,pmdb005,pmdb007,pmdb006,pmdb009,pmdb008,pmdb011,pmdb010,pmdb030,pmdb048,pmdb031,pmdb050,pmdb032,pmdb051,pmdb033,pmdb049,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb034,pmdb035,pmdb036,pmdb053,pmdb037,pmdb038,pmdb039,pmdb054,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb046) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_pmdb_d[g_detail_idx].pmdbsite,g_pmdb_d[g_detail_idx].pmdb001,g_pmdb_d[g_detail_idx].pmdb002, 
                  g_pmdb_d[g_detail_idx].pmdb003,g_pmdb_d[g_detail_idx].pmdb052,g_pmdb_d[g_detail_idx].pmdb004, 
                  g_pmdb_d[g_detail_idx].pmdb005,g_pmdb_d[g_detail_idx].pmdb007,g_pmdb_d[g_detail_idx].pmdb006, 
                  g_pmdb_d[g_detail_idx].pmdb009,g_pmdb_d[g_detail_idx].pmdb008,g_pmdb_d[g_detail_idx].pmdb011, 
                  g_pmdb_d[g_detail_idx].pmdb010,g_pmdb_d[g_detail_idx].pmdb030,g_pmdb_d[g_detail_idx].pmdb048, 
                  g_pmdb_d[g_detail_idx].pmdb031,g_pmdb_d[g_detail_idx].pmdb050,g_pmdb_d[g_detail_idx].pmdb032, 
                  g_pmdb_d[g_detail_idx].pmdb051,g_pmdb_d[g_detail_idx].pmdb033,g_pmdb_d[g_detail_idx].pmdb049, 
                  g_pmdb2_d[g_detail_idx].pmdb012,g_pmdb2_d[g_detail_idx].pmdb014,g_pmdb2_d[g_detail_idx].pmdb015, 
                  g_pmdb2_d[g_detail_idx].pmdb016,g_pmdb2_d[g_detail_idx].pmdb017,g_pmdb2_d[g_detail_idx].pmdb018, 
                  g_pmdb2_d[g_detail_idx].pmdb019,g_pmdb2_d[g_detail_idx].pmdb020,g_pmdb2_d[g_detail_idx].pmdb021, 
                  g_pmdb2_d[g_detail_idx].pmdb034,g_pmdb2_d[g_detail_idx].pmdb035,g_pmdb2_d[g_detail_idx].pmdb036, 
                  g_pmdb2_d[g_detail_idx].pmdb053,g_pmdb2_d[g_detail_idx].pmdb037,g_pmdb2_d[g_detail_idx].pmdb038, 
                  g_pmdb2_d[g_detail_idx].pmdb039,g_pmdb2_d[g_detail_idx].pmdb054,g_pmdb2_d[g_detail_idx].pmdb041, 
                  g_pmdb2_d[g_detail_idx].pmdb042,g_pmdb2_d[g_detail_idx].pmdb043,g_pmdb2_d[g_detail_idx].pmdb044, 
                  g_pmdb2_d[g_detail_idx].pmdb045,g_pmdb2_d[g_detail_idx].pmdb046) 
         WHERE pmdbent = g_enterprise AND pmdbdocno = ps_keys_bak[1] AND pmdbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmt400_pmdb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="apmt400.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apmt400_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt400.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmt400_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt400.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmt400_lock_b(ps_table,ps_page)
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
   #CALL apmt400_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "pmdb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmt400_bcl USING g_enterprise,
                                       g_pmda_m.pmdadocno,g_pmdb_d[g_detail_idx].pmdbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt400_bcl:",SQLERRMESSAGE 
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
 
{<section id="apmt400.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmt400_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apmt400_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmt400_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("pmdadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmdadocno",TRUE)
      CALL cl_set_comp_entry("pmdadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      #CALL cl_set_comp_entry("pmdadocdt",TRUE)  #160711-00041#1
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("pmda002,pmda003,pmda004,pmda010,pmda005,pmda007,pmda021,pmda020,pmda022",TRUE)
   CALL cl_set_comp_entry("pmdadocdt",TRUE)  #160711-00041#1
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmt400_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_fields  STRING 
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmdadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      #CALL cl_set_comp_entry("pmdadocdt",FALSE)  #160711-00041#1
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("pmdadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("pmdadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #IF g_flag THEN
   #   CALL cl_set_comp_entry("pmdadocno,pmdadocdt",FALSE)
   #END IF
   #依單據別設定判斷欄位是否需要做輸入控制
   IF NOT cl_null(g_pmda_m.pmdadocno) THEN
      LET l_fields = ''
      CALL s_aooi200_get_doc_fields(g_site,'1',g_pmda_m.pmdadocno) RETURNING l_fields
      CALL cl_set_comp_entry(l_fields,FALSE)
   END IF

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmt400_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("pmdb005,pmdb008,pmdb010,pmdb011,pmdb039",TRUE)
   
   #150526 by whitney add start
   #當pmda004(單價為必要輸入)='N'時,單身的pmdb019(參考單價)不開放輸入   
   CALL cl_set_comp_entry("pmdb019",TRUE)
   #150526 by whitney add end

   #2015/08/19 by stellar add -----(S)
   CALL cl_set_comp_entry("pmdb053",TRUE)
   #2015/08/19 by stellar add -----(E)
   
   CALL cl_set_comp_entry("pmdb015",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="apmt400.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmt400_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaa005   LIKE imaa_t.imaa005
   DEFINE l_imaf015   LIKE imaf_t.imaf015
   #DEFINE l_imaf144   LIKE imaf_t.imaf144
   DEFINE l_inaa007   LIKE inaa_t.inaa007
   DEFINE l_success   LIKE type_t.num5       #2015/08/19 by stellar add
   DEFINE l_slip      LIKE pmda_t.pmdadocno  #2015/08/19 by stellar add
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"

   LET l_imaa005 = ''
   CALL apmt400_get_imaa005(g_enterprise,g_pmdb_d[l_ac].pmdb004) RETURNING l_imaa005
   IF cl_null(l_imaa005) THEN
      CALL cl_set_comp_entry("pmdb005",FALSE)
   END IF
   
   #當料件不使用參考單位管理時，則參考數量不允許輸入
   LET l_imaf015 = ''
   LET g_imaf144 = ''
   SELECT imaf015,imaf144 INTO l_imaf015,g_imaf144 FROM imaf_t WHERE imafent = g_enterprise AND imaf001 = g_pmdb_d[l_ac].pmdb004 AND imafsite = g_site
   
   IF cl_null(l_imaf015) THEN
      CALL cl_set_comp_entry("pmdb008",FALSE)
      LET g_pmdb_d[l_ac].pmdb009 = ''
      LET g_pmdb_d[l_ac].pmdb009_desc = ''
      LET g_pmdb_d[l_ac].pmdb008 = ''
   END IF
   
   #料件不使用計價單位是，計價單位、計價數量不可維護
   IF cl_null(g_imaf144) THEN
      CALL cl_set_comp_entry("pmdb010,pmdb011",FALSE)
      LET g_pmdb_d[l_ac].pmdb011 = g_pmdb_d[l_ac].pmdb007
      LET g_pmdb_d[l_ac].pmdb011_desc = g_pmdb_d[l_ac].pmdb007_desc
      LET g_pmdb_d[l_ac].pmdb010 = g_pmdb_d[l_ac].pmdb006
   END IF
   
   #若[T:庫位資料檔].[C:儲位管理]='5'(不使用儲位管理)時，則[C:限定儲位]不可以維護
   SELECT inaa007 INTO l_inaa007 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_pmdb2_d[l_ac].pmdb037 AND inaa001 = g_pmdb2_d[l_ac].pmdb038
   IF l_inaa007 = '5' THEN
      CALL cl_set_comp_entry("pmdb039",FALSE)
      LET g_pmdb2_d[l_ac].pmdb039 = ' '
      LET g_pmdb2_d[l_ac].pmdb039_desc = ''
   END IF

   #150526 by whitney add start
   #當pmda004(單價為必要輸入)='N'時,單身的pmdb019(參考單價)不開放輸入
   IF g_pmda_m.pmda004 = 'N' THEN
      CALL cl_set_comp_entry("pmdb019",FALSE)
   END IF
   #150526 by whitney add end

   #2015/08/19 by stellar add -----(S)
   CALL s_aooi200_get_slip(g_pmda_m.pmdadocno)
        RETURNING l_success,l_slip
   IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'N' THEN
      CALL cl_set_comp_entry("pmdb053",FALSE)
   END IF
   #2015/08/19 by stellar add -----(E)
   
   IF g_pmdb2_d[l_ac].pmdb014 MATCHES '[1]' THEN
      LET g_pmdb2_d[l_ac].pmdb015 = ''
      LET g_pmdb2_d[l_ac].pmdb015_desc = ''
      CALL cl_set_comp_entry("pmdb015",FALSE)
      DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb015,g_pmdb2_d[l_ac].pmdb015_desc
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="apmt400.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmt400_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   
   CALL cl_set_act_visible("apmt400_01",TRUE)   #160804-00021#1
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmt400_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_pmda_m.pmdastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      
      CALL cl_set_act_visible("apmt400_01",FALSE)   #160804-00021#1
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmt400_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmt400_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmt400_default_search()
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
      LET ls_wc = ls_wc, " pmdadocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #add by lixh 20150529
  #LET ls_wc = ' 1=1 '    #160407-00023
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " pmdadocno = '", g_argv[02], "' AND "
   END IF
   
   #傳單號範圍至apmt400,一次查詢可查詢出多個單號資料
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc , g_argv[03], " AND "
   END IF
   #add by lixh 20150529
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
               WHEN la_wc[li_idx].tableid = "pmda_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pmdb_t" 
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
   #給予批次串程式使用
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = " ", g_argv[02]
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt400.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmt400_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_pmda_m.pmdastus = 'X' THEN
      RETURN
   END IF
   IF g_pmda_m.pmdastus = 'C' THEN  #結案狀態
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pmda_m.pmdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apmt400_cl USING g_enterprise,g_pmda_m.pmdadocno
   IF STATUS THEN
      CLOSE apmt400_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt400_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmt400_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmdadocno, 
       g_pmda_m.pmda001,g_pmda_m.pmdadocdt,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004, 
       g_pmda_m.pmda010,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008,g_pmda_m.pmda009, 
       g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda022, 
       g_pmda_m.pmda024,g_pmda_m.pmda025,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp, 
       g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda005_desc,g_pmda_m.pmda007_desc,g_pmda_m.pmda021_desc, 
       g_pmda_m.pmda023_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid_desc, 
       g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT apmt400_action_chk() THEN
      CLOSE apmt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocno_desc,g_pmda_m.pmdadocdt, 
       g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmda003,g_pmda_m.pmda003_desc,g_pmda_m.pmdastus, 
       g_pmda_m.pmda004,g_pmda_m.pmda010,g_pmda_m.pmda010_desc,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005, 
       g_pmda_m.pmda005_desc,g_pmda_m.ooan005,g_pmda_m.pmda008,g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda007_desc, 
       g_pmda_m.pmda021,g_pmda_m.pmda021_desc,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda023_desc, 
       g_pmda_m.pmda022,g_pmda_m.pmda024,g_pmda_m.pmda024_desc,g_pmda_m.oofb017,g_pmda_m.pmda025,g_pmda_m.pmda025_desc, 
       g_pmda_m.oofb017_1,g_pmda_m.pmdaownid,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp,g_pmda_m.pmdaowndp_desc, 
       g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdacrtdt, 
       g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfid_desc, 
       g_pmda_m.pmdacnfdt
 
   CASE g_pmda_m.pmdastus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "TJ"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/committed.png")
      WHEN "C"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "UH"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
      WHEN "H"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_pmda_m.pmdastus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "TJ"
               HIDE OPTION "committed"
            WHEN "C"
               HIDE OPTION "closed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "UH"
               HIDE OPTION "unhold"
            WHEN "H"
               HIDE OPTION "hold"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,unhold,hold",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("committed",FALSE)   #161220-00059#6  by 08172      
      
      CASE g_pmda_m.pmdastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,unhold,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
            
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,unhold,hold",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,unhold,hold",FALSE)
   

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,unhold,hold",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unhold",FALSE)
            
         WHEN "C"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,unhold,hold",FALSE)

         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,unhold,hold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,unhold,hold",FALSE)
             
         WHEN "H"   #留置
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)


      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT apmt400_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt400_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT apmt400_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt400_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION committed
         IF cl_auth_chk_act("committed") THEN
            LET lc_state = "TJ"
            #add-point:action控制 name="statechange.committed"
            
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
      ON ACTION unhold
         IF cl_auth_chk_act("unhold") THEN
            LET lc_state = "UH"
            #add-point:action控制 name="statechange.unhold"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION hold
         IF cl_auth_chk_act("hold") THEN
            LET lc_state = "H"
            #add-point:action控制 name="statechange.hold"
            
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
   IF (lc_state <> "Y" 
      AND lc_state <> "N"
      AND lc_state <> "TJ"
      AND lc_state <> "C"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "UH"
      AND lc_state <> "H"
      AND lc_state <> "X"
      ) OR 
      g_pmda_m.pmdastus = lc_state OR cl_null(lc_state) THEN
      CLOSE apmt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
      CALL s_transaction_begin()
      IF lc_state = 'Y' THEN
         CALL s_apmt400_conf_chk(g_pmda_m.pmdadocno) RETURNING l_success
         IF NOT l_success THEN
            #160728-00008#1--s
            CLOSE apmt400_cl
            CALL s_transaction_end('N','0')
            #160728-00008#1---e
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN
               #160728-00008#1--s
               CLOSE apmt400_cl
               CALL s_transaction_end('N','0')
               #160728-00008#1---e
               RETURN
            ELSE
               CALL s_apmt400_conf_upd(g_pmda_m.pmdadocno) RETURNING l_success
               IF NOT l_success THEN
                  CLOSE apmt400_cl  #160728-00008#1
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF
      IF lc_state = 'N' THEN
         CALL s_apmt400_unconf_chk(g_pmda_m.pmdadocno) RETURNING l_success
         IF NOT l_success THEN
            #160728-00008#1--s
            CLOSE apmt400_cl
            CALL s_transaction_end('N','0')
            #160728-00008#1---e
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00110') THEN
               #160728-00008#1--s
               CLOSE apmt400_cl
               CALL s_transaction_end('N','0')
               #160728-00008#1---e
               RETURN
            ELSE
               CALL s_apmt400_unconf_upd(g_pmda_m.pmdadocno) RETURNING l_success
               IF NOT l_success THEN
                  CLOSE apmt400_cl  #160728-00008#1
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF
      IF lc_state = 'X' THEN
         CALL s_apmt400_invalid_chk(g_pmda_m.pmdadocno) RETURNING l_success
         IF NOT l_success THEN
            #160728-00008#1--s
            CLOSE apmt400_cl
            CALL s_transaction_end('N','0')
            #160728-00008#1---e
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00109') THEN
               #160728-00008#1--s
               CLOSE apmt400_cl
               CALL s_transaction_end('N','0')
               #160728-00008#1---e
               RETURN
            ELSE
               CALL s_apmt400_invalid_upd(g_pmda_m.pmdadocno) RETURNING l_success
               IF NOT l_success THEN
                  CLOSE apmt400_cl  #160728-00008#1
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF
      #留置
      IF lc_state = 'H' THEN
         CALL s_apmt400_hold_chk(g_pmda_m.pmdadocno) RETURNING l_success
         IF NOT l_success THEN
            #160728-00008#1--s
            CLOSE apmt400_cl
            CALL s_transaction_end('N','0')
            #160728-00008#1---e
            RETURN
         ELSE
            IF NOT cl_ask_confirm('apm-00737') THEN
               #160728-00008#1--s
               CLOSE apmt400_cl
               CALL s_transaction_end('N','0')
               #160728-00008#1---e
               RETURN
            ELSE
               IF NOT apmt400_upd_pmda023() THEN
                  #160728-00008#1--s
                  CLOSE apmt400_cl
                  CALL s_transaction_end('N','0')
                  #160728-00008#1---e
                  RETURN
               ELSE
                  CALL s_apmt400_hold_upd(g_pmda_m.pmdadocno) RETURNING l_success
                  IF NOT l_success THEN
                     CLOSE apmt400_cl  #160728-00008#1
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
            END IF
         END IF
      END IF
      #取消留置
      IF lc_state = 'UH' THEN
         CALL s_apmt400_unhold_chk(g_pmda_m.pmdadocno) RETURNING l_success
         IF NOT l_success THEN
            #160728-00008#1--s
            CLOSE apmt400_cl
            CALL s_transaction_end('N','0')
            #160728-00008#1---e
            RETURN
         ELSE
            IF NOT cl_ask_confirm('apm-00738') THEN
               #160728-00008#1--s
               CLOSE apmt400_cl
               CALL s_transaction_end('N','0')
               #160728-00008#1---e
               RETURN
            ELSE
               CALL s_apmt400_unhold_upd(g_pmda_m.pmdadocno) RETURNING l_success
               IF NOT l_success THEN
                  CLOSE apmt400_cl  #160728-00008#1
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF
   
   #因為取消留置時，狀態碼應給'Y',而不是更新為'UH'
   SELECT pmdastus INTO lc_state FROM pmda_t WHERE pmdaent = g_enterprise AND pmdadocno = g_pmda_m.pmdadocno
   #end add-point
   
   LET g_pmda_m.pmdamodid = g_user
   LET g_pmda_m.pmdamoddt = cl_get_current()
   LET g_pmda_m.pmdastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pmda_t 
      SET (pmdastus,pmdamodid,pmdamoddt) 
        = (g_pmda_m.pmdastus,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt)     
    WHERE pmdaent = g_enterprise AND pmdadocno = g_pmda_m.pmdadocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "TJ"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/committed.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "UH"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unhold.png")
         WHEN "H"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/hold.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE apmt400_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmdadocno, 
          g_pmda_m.pmda001,g_pmda_m.pmdadocdt,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004, 
          g_pmda_m.pmda010,g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008,g_pmda_m.pmda009, 
          g_pmda_m.pmda007,g_pmda_m.pmda021,g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda022, 
          g_pmda_m.pmda024,g_pmda_m.pmda025,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid, 
          g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid, 
          g_pmda_m.pmdacnfdt,g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda005_desc,g_pmda_m.pmda007_desc, 
          g_pmda_m.pmda021_desc,g_pmda_m.pmda023_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc, 
          g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocno_desc, 
          g_pmda_m.pmdadocdt,g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmda003,g_pmda_m.pmda003_desc, 
          g_pmda_m.pmdastus,g_pmda_m.pmda004,g_pmda_m.pmda010,g_pmda_m.pmda010_desc,g_pmda_m.pmda011, 
          g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda005_desc,g_pmda_m.ooan005,g_pmda_m.pmda008, 
          g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda007_desc,g_pmda_m.pmda021,g_pmda_m.pmda021_desc, 
          g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda023,g_pmda_m.pmda023_desc,g_pmda_m.pmda022, 
          g_pmda_m.pmda024,g_pmda_m.pmda024_desc,g_pmda_m.oofb017,g_pmda_m.pmda025,g_pmda_m.pmda025_desc, 
          g_pmda_m.oofb017_1,g_pmda_m.pmdaownid,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp,g_pmda_m.pmdaowndp_desc, 
          g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdacrtdt, 
          g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfid_desc, 
          g_pmda_m.pmdacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   #CALL apmt400_b_fill()  #160728-00008#1
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE apmt400_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt400_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt400.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmt400_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pmdb_d.getLength() THEN
         LET g_detail_idx = g_pmdb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmdb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmdb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_pmdb2_d.getLength() THEN
         LET g_detail_idx = g_pmdb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmdb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmdb2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmt400_b_fill2(pi_idx)
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
   
   CALL apmt400_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmt400_fill_chk(ps_idx)
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
 
{<section id="apmt400.status_show" >}
PRIVATE FUNCTION apmt400_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt400.mask_functions" >}
&include "erp/apm/apmt400_mask.4gl"
 
{</section>}
 
{<section id="apmt400.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION apmt400_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL apmt400_show()
   CALL apmt400_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #確認前檢核段
   IF NOT s_apmt400_conf_chk(g_pmda_m.pmdadocno) THEN
      CLOSE apmt400_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF

   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_pmda_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_pmdb_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_pmdb2_d))
 
 
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
   #CALL apmt400_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL apmt400_ui_headershow()
   CALL apmt400_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION apmt400_draw_out()
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
   CALL apmt400_ui_headershow()  
   CALL apmt400_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="apmt400.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmt400_set_pk_array()
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
   LET g_pk_array[1].values = g_pmda_m.pmdadocno
   LET g_pk_array[1].column = 'pmdadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt400.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apmt400.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmt400_msgcentre_notify(lc_state)
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
   CALL apmt400_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt400.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmt400_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#26--s
   SELECT pmdastus INTO g_pmda_m.pmdastus FROM pmda_t WHERE pmdaent = g_enterprise AND pmdadocno = g_pmda_m.pmdadocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
      LET g_errno = NULL
      CASE g_pmda_m.pmdastus  
        WHEN "Y"
           LET g_errno = 'sub-00178'
        WHEN "C"
           LET g_errno = 'ain-00197'
        WHEN "W"
           LET g_errno = 'sub-01347'
        WHEN "UH"
           LET g_errno = 'sub-01358'
        WHEN "H"
           LET g_errno = 'sub-01348'
        WHEN "X"
           LET g_errno = 'sub-00229'
      
      END CASE
      
      IF NOT cl_null(g_errno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = g_pmda_m.pmdastus
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_errno = NULL
         CALL apmt400_set_act_visible()
         CALL apmt400_set_act_no_visible()
         CALL apmt400_show()
         RETURN FALSE
      END IF
   END IF
   #160818-00017#26---e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt400.other_function" readonly="Y" >}

PRIVATE FUNCTION apmt400_pmda002_ref(p_pmda002)
DEFINE p_pmda002      LIKE pmda_t.pmda002
DEFINE r_pmda002_desc LIKE ooag_t.ooag011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmda002
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET r_pmda002_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmda002_desc

END FUNCTION

PRIVATE FUNCTION apmt400_pmda003_ref(p_pmda003)
DEFINE p_pmda003      LIKE pmda_t.pmda003
DEFINE r_pmda003_desc LIKE ooefl_t.ooefl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmda003
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmda003_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmda003_desc

END FUNCTION
#複製時欄位初始化
PRIVATE FUNCTION apmt400_reproduce_init()
      LET g_pmda_m.pmdadocno = ''
      LET g_pmda_m.pmdadocno_desc = ''
      LET g_pmda_m.pmdadocdt = g_today
      DISPLAY BY NAME g_pmda_m.pmdadocno,g_pmda_m.pmdadocno_desc,g_pmda_m.pmdadocdt
      LET g_pmda_m.pmdastus = 'N'
      CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      DISPLAY BY NAME g_pmda_m.pmdastus
      LET g_pmda_m.pmda002 = g_user
      LET g_pmda_m.pmda003 = g_dept
      CALL apmt400_pmda002_ref(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
      DISPLAY BY NAME g_pmda_m.pmda002,g_pmda_m.pmda002_desc
      
      CALL apmt400_pmda003_ref(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
      DISPLAY BY NAME g_pmda_m.pmda003,g_pmda_m.pmda003_desc
      
      LET g_pmda_m.pmdaownid = g_user
      LET g_pmda_m.pmdaowndp = g_dept
      LET g_pmda_m.pmdacrtid = g_user
      LET g_pmda_m.pmdacrtdp = g_dept 
      LET g_pmda_m.pmdacrtdt = cl_get_current()
      LET g_pmda_m.pmdamodid = NULL
      LET g_pmda_m.pmdamodid_desc = NULL
      LET g_pmda_m.pmdamoddt = NULL
      LET g_pmda_m.pmdacnfid = NULL
      LET g_pmda_m.pmdacnfid_desc = NULL
      LET g_pmda_m.pmdacnfdt = NULL
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmda_m.pmdaownid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_pmda_m.pmdaownid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_pmda_m.pmdaownid_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmda_m.pmdaowndp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pmda_m.pmdaowndp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_pmda_m.pmdaowndp_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmda_m.pmdacrtid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_pmda_m.pmdacrtid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_pmda_m.pmdacrtid_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmda_m.pmdacrtdp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pmda_m.pmdacrtdp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_pmda_m.pmdacrtdp_desc
            
      DISPLAY BY NAME g_pmda_m.pmdaownid,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp,g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfid_desc,g_pmda_m.pmdacnfdt
   
      INITIALIZE g_pmda_m_t.* TO NULL
      LET g_pmda_m_t.* = g_pmda_m.*
      
END FUNCTION

PRIVATE FUNCTION apmt400_set_required()
  
    IF g_pmda_m.pmda004 = 'Y' THEN
       CALL cl_set_comp_required("pmda010,pmda005,pmdb019",TRUE)
    END IF
    
    
END FUNCTION

PRIVATE FUNCTION apmt400_set_no_required()
    
    CALL cl_set_comp_required("pmda010,pmda005,pmdb019",FALSE)
    
END FUNCTION

PRIVATE FUNCTION apmt400_pmda010_ref(p_pmda010)
DEFINE p_pmda010      LIKE pmda_t.pmda010
DEFINE r_pmda010_desc LIKE oodbl_t.oodbl004
DEFINE l_ooef019      LIKE ooef_t.ooef019

       LET l_ooef019 = ''
       SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
       
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmda010
       CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001 = '"||l_ooef019||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmda010_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmda010_desc
      
END FUNCTION

PRIVATE FUNCTION apmt400_pmda005_ref(p_pmda005)
DEFINE p_pmda005      LIKE pmda_t.pmda005
DEFINE r_pmda005_desc LIKE ooail_t.ooail003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmda005
       CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmda005_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmda005_desc
     
END FUNCTION

PRIVATE FUNCTION apmt400_pmda021_ref(p_pmda021)
DEFINE p_pmda021      LIKE pmda_t.pmda021
DEFINE r_pmda021_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmda021
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmda021_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmda021_desc

END FUNCTION
#料件编号检查
PRIVATE FUNCTION apmt400_pmdb004_chk(p_pmdb004)
DEFINE p_pmdb004     LIKE pmdb_t.pmdb004
DEFINE l_success     LIKE type_t.num5
DEFINE l_flag        LIKE type_t.num5
DEFINE r_success     LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT cl_null(p_pmdb004) THEN
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_pmdb004
    
          #呼叫檢查存在並帶值的library
          IF cl_chk_exist("v_imaa001") THEN
             IF NOT cl_chk_exist("v_imaf001_14") THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
          ELSE
             LET r_success = FALSE
             RETURN r_success
          END IF
          
          #判斷輸入的料件編號是否在控制組限制的產品範圍內，若不在限制內則不允許請購此料
          CALL s_control_chk_group('3','3',g_user,g_dept,p_pmdb004,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00252'
                LET g_errparam.extend = p_pmdb004
                LET g_errparam.popup = TRUE
                CALL cl_err()

                LET r_success = FALSE
                RETURN r_success
             END IF 
          END IF
          
          #檢核輸入的料件的生命週期是否在單據別限制範圍內，若不在限制內則不允許請購此料
          CALL s_control_chk_doc('4',g_pmda_m.pmdadocno,p_pmdb004,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                #CALL cl_err(p_pmdb004,'ain-00015',1)
                LET r_success = FALSE
                RETURN r_success
             END IF 
          END IF
          
          #檢核輸入的料件的產品分類是否在單據別限制範圍內，若不在限制內則不允許請購此料
          CALL s_control_chk_doc('5',g_pmda_m.pmdadocno,p_pmdb004,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                LET r_success = FALSE
                #CALL cl_err(p_pmdb004,'apm-00238',1)
                RETURN r_success
             END IF 
          END IF
          
          #檢核料件AVL控管點(imaa044)設置
          IF NOT s_apmt400_item_avl_chk(g_pmda_m.pmdadocdt,p_pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb2_d[l_ac].pmdb015,g_pmdb_d[l_ac].pmdb006) THEN  #add by lixiang 2015/10/15 pmdb006
             LET r_success = FALSE
             RETURN r_success
          END IF
          
       END IF    
       
       RETURN r_success
       
END FUNCTION
#單身新增時欄位初始化
PRIVATE FUNCTION apmt400_pmdb_init()
DEFINE l_seq    LIKE pmdb_t.pmdbseq

       LET g_pmdb_d[l_ac].pmdbsite = g_site
       
       #LET g_pmdb2_d[l_ac].pmdbseq = g_pmdb_d[l_ac].pmdbseq
       #LET g_pmdb2_d[l_ac].imaal001 = g_pmdb_d[l_ac].pmdb004
       #LET g_pmdb2_d[l_ac].imaal003 = g_pmdb_d[l_ac].pmdb004_desc
       #LET g_pmdb2_d[l_ac].imaal004 = g_pmdb_d[l_ac].imaal004
       
       LET g_pmdb_d[l_ac].pmdb032= "1"    #行狀態
       LET g_pmdb_d[l_ac].pmdb033 = "1"   #緊急度
       LET g_pmdb_d[l_ac].pmdb049 = 0     #已轉採購量
       
       LET g_pmdb2_d[l_ac].pmdb018 = g_pmda_m.pmda011  #稅率
       LET g_pmdb2_d[l_ac].pmdb020 = 0
       LET g_pmdb2_d[l_ac].pmdb021 = 0
       
       LET g_pmdb2_d[l_ac].pmdb046 = g_pmda_m.pmda007  #費用部門
       CALL apmt400_pmda003_ref(g_pmdb2_d[l_ac].pmdb046) RETURNING g_pmdb2_d[l_ac].pmdb046_desc
       DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb046_desc
       
       LET g_pmdb2_d[l_ac].pmdb044 = g_pmda_m.pmda020  #MRP/MPS計算
       LET g_pmdb2_d[l_ac].pmdb045 = "N"   #MRP交期凍結
       LET g_pmdb2_d[l_ac].pmdb041 = "N"   #允許部分交貨
       LET g_pmdb2_d[l_ac].pmdb042 = "N"   #允許提前交貨
       
       LET l_seq = g_pmdb_d[l_ac].pmdbseq -1

       IF l_seq > 0 THEN   #單身已經有資料
          
          SELECT pmdb030,pmdb048,pmdb031,pmdb050,pmdb014,pmdb015,pmdb016,pmdb017,pmdb034,pmdb035,pmdb036,pmdb037,pmdb038,pmdb039,
                 pmdb041,pmdb042,pmdb043,pmdb045      
              INTO g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb031,g_pmdb_d[l_ac].pmdb050,
                   g_pmdb2_d[l_ac].pmdb014,g_pmdb2_d[l_ac].pmdb015,g_pmdb2_d[l_ac].pmdb016,g_pmdb2_d[l_ac].pmdb017,
                   g_pmdb2_d[l_ac].pmdb034,g_pmdb2_d[l_ac].pmdb035,g_pmdb2_d[l_ac].pmdb036,g_pmdb2_d[l_ac].pmdb037,
                   g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039,g_pmdb2_d[l_ac].pmdb041,g_pmdb2_d[l_ac].pmdb042,
                   g_pmdb2_d[l_ac].pmdb043,g_pmdb2_d[l_ac].pmdb045
             FROM pmdb_t WHERE pmdbent= g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno AND pmdbseq = l_seq
             
          #LET g_pmdb_d[l_ac].pmdb030 = g_pmdb_d[l_ac-1].pmdb030    #需求日期
          
          #LET g_pmdb_d[l_ac].pmdb048 = g_pmdb_d[l_ac-1].pmdb048    #收貨時段
          CALL apmt400_pmdb048_ref(g_pmdb_d[l_ac].pmdb048) RETURNING g_pmdb_d[l_ac].pmdb048_desc
          DISPLAY BY NAME g_pmdb_d[l_ac].pmdb048_desc
          
          #LET g_pmdb_d[l_ac].pmdb031 = g_pmdb_d[l_ac-1].pmdb031    #理由碼
          CALL apmt400_pmdb031_ref(g_pmdb_d[l_ac].pmdb031) RETURNING g_pmdb_d[l_ac].pmdb031_desc
          DISPLAY BY NAME g_pmdb_d[l_ac].pmdb031_desc
          
          #LET g_pmdb_d[l_ac].pmdb050 = g_pmdb_d[l_ac-1].pmdb050    #備註
          
          #LET g_pmdb2_d[l_ac].pmdb014 = g_pmdb2_d[l_ac-1].pmdb014  #供應商選擇
          #LET g_pmdb2_d[l_ac].pmdb015 = g_pmdb2_d[l_ac-1].pmdb015  #供應商
          CALL apmt400_pmdb015_ref(g_pmdb2_d[l_ac].pmdb015) RETURNING g_pmdb2_d[l_ac].pmdb015_desc
          DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb015_desc
          
          #LET g_pmdb2_d[l_ac].pmdb016 = g_pmdb2_d[l_ac-1].pmdb016  #付款條件
          CALL apmt400_pmdb016_ref(g_pmdb2_d[l_ac].pmdb016) RETURNING g_pmdb2_d[l_ac].pmdb016_desc
          DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb016_desc
          
          #LET g_pmdb2_d[l_ac].pmdb017 = g_pmdb2_d[l_ac-1].pmdb017  #交易條件
          CALL apmt400_pmdb017_ref(g_pmdb2_d[l_ac].pmdb017) RETURNING g_pmdb2_d[l_ac].pmdb017_desc
          DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb017_desc
          
          #LET g_pmdb2_d[l_ac].pmdb034 = g_pmdb2_d[l_ac-1].pmdb034  #專案編號
          #LET g_pmdb2_d[l_ac].pmdb035 = g_pmdb2_d[l_ac-1].pmdb035  #WBS
          #LET g_pmdb2_d[l_ac].pmdb036 = g_pmdb2_d[l_ac-1].pmdb036  #活動編號
          #LET g_pmdb2_d[l_ac].pmdb037 = g_pmdb2_d[l_ac-1].pmdb037  #收貨據點
          CALL apmt400_pmdb037_ref(g_pmdb2_d[l_ac].pmdb037) RETURNING g_pmdb2_d[l_ac].pmdb037_desc
          DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb037_desc
          
          #LET g_pmdb2_d[l_ac].pmdb038 = g_pmdb2_d[l_ac-1].pmdb038  #收貨庫位
          CALL apmt400_pmdb038_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038) RETURNING g_pmdb2_d[l_ac].pmdb038_desc
          DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb038_desc
          
          #LET g_pmdb2_d[l_ac].pmdb039 = g_pmdb2_d[l_ac-1].pmdb039  #收貨儲位
          CALL apmt400_pmdb039_ref(g_pmdb2_d[l_ac].pmdb037,g_pmdb2_d[l_ac].pmdb038,g_pmdb2_d[l_ac].pmdb039) RETURNING g_pmdb2_d[l_ac].pmdb039_desc
          DISPLAY BY NAME g_pmdb2_d[l_ac].pmdb039_desc
          
          #LET g_pmdb2_d[l_ac].pmdb041 = g_pmdb2_d[l_ac-1].pmdb041  #允許部分交貨
          #LET g_pmdb2_d[l_ac].pmdb042 = g_pmdb2_d[l_ac-1].pmdb042  #允許提前交貨
          #LET g_pmdb2_d[l_ac].pmdb043 = g_pmdb2_d[l_ac-1].pmdb043  #保稅
          #LET g_pmdb2_d[l_ac].pmdb045 = g_pmdb2_d[l_ac-1].pmdb045  #MRP交期凍結
          
       END IF
            
END FUNCTION

PRIVATE FUNCTION apmt400_pmdb004_ref(p_pmdb004)
DEFINE p_pmdb004      LIKE pmdb_t.pmdb004
DEFINE r_imaal003     LIKE imaal_t.imaal003
DEFINE r_imaal004     LIKE imaal_t.imaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb004
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imaal003 = '', g_rtn_fields[1] , ''
       LET r_imaal004 = '', g_rtn_fields[2] , ''
       RETURN r_imaal003,r_imaal004
       
END FUNCTION

PRIVATE FUNCTION apmt400_unit_ref(p_pmdb007)
DEFINE p_pmdb007      LIKE pmdb_t.pmdb007
DEFINE r_pmdb007_desc LIKE oocal_t.oocal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb007
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdb007_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdb007_desc
       
END FUNCTION

PRIVATE FUNCTION apmt400_pmdb048_ref(p_pmdb048)
DEFINE p_pmdb048      LIKE pmdb_t.pmdb048
DEFINE r_pmdb048_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb048
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='274' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdb048_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdb048_desc

END FUNCTION

PRIVATE FUNCTION apmt400_pmdb012_ref(p_pmdb012)
DEFINE p_pmdb012      LIKE pmdb_t.pmdb012
DEFINE r_imaal003     LIKE imaal_t.imaal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb012
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imaal003 = '', g_rtn_fields[1] , ''
       RETURN r_imaal003

END FUNCTION
#單位檢查
PRIVATE FUNCTION apmt400_unit_chk(p_pmdb007)
DEFINE p_pmdb007    LIKE pmdb_t.pmdb007
DEFINE r_success    LIKE type_t.num5
       
       LET r_success = TRUE
       
       IF NOT cl_null(p_pmdb007) THEN 
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = g_pmdb_d[l_ac].pmdb004
          LET g_chkparam.arg2 = p_pmdb007
   
          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_imao002") THEN
             LET r_success = FALSE
             RETURN r_success             
          END IF
       END IF 
       RETURN r_success 

END FUNCTION
#根據單位對數量進行取位
PRIVATE FUNCTION apmt400_unit_round(p_pmdb007,p_pmdb006)
DEFINE p_pmdb007   LIKE pmdb_t.pmdb007     #單位
DEFINE p_pmdb006   LIKE pmdb_t.pmdb006     #數量
DEFINE l_success   LIKE type_t.num5
DEFINE l_ooca002   LIKE ooca_t.ooca002      #小数位数
DEFINE l_ooca004   LIKE ooca_t.ooca004      #舍入类型 
DEFINE r_pmdb006   LIKE pmdb_t.pmdb006     #數量
        
       LET l_success = NULL
       LET l_ooca002 = 0
       LET l_ooca004 = NULL
       LET r_pmdb006 = 0
       
       #抓取单位档中的小数位数和舍入类型
       IF NOT cl_null(p_pmdb007) THEN
          CALL s_aooi250_get_msg(p_pmdb007) RETURNING l_success,l_ooca002,l_ooca004
          IF l_success THEN
             IF NOT cl_null(p_pmdb006) THEN
                CALL s_num_round(l_ooca004,p_pmdb006,l_ooca002) RETURNING r_pmdb006
                RETURN r_pmdb006
             END IF
          END IF
       END IF
       RETURN r_pmdb006
       
END FUNCTION
#
PRIVATE FUNCTION apmt400_set_required_b()
DEFINE l_imea003  LIKE imea_t.imea003
DEFINE l_imaa005  LIKE imaa_t.imaa005
DEFINE l_imaa004  LIKE imaa_t.imaa004  #doirslai-20150831-add

     IF g_pmdb2_d[l_ac].pmdb014 MATCHES '[23]' THEN
        CALL cl_set_comp_required("pmdb015",TRUE)
     END IF
     
     #對應的特徵群組有 勾選'需求來源可以不指定產品特徵'時，可以不指定產品特徵
     LET l_imaa005 = ''
     CALL apmt400_get_imaa005(g_enterprise,g_pmdb_d[l_ac].pmdb004) RETURNING l_imaa005
     IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' AND NOT cl_null(l_imaa005) THEN
        LET l_imea003 =  ''
        SELECT imea003 INTO l_imea003 FROM imea_t WHERE imeaent = g_enterprise AND imea001 = l_imaa005
        IF l_imea003 = 'N' THEN
           CALL cl_set_comp_required("pmdb005",TRUE)
        END IF
     END IF
     #20150831-dorislai-add----(S)
     SELECT imaa004  INTO l_imaa004 FROM imaa_t
      WHERE imaaent=g_enterprise AND imaa001=g_pmdb_d[l_ac].pmdb004
     #IF l_imaa004 MATCHES '[EF]' THEN   #160815-00031#1
     IF l_imaa004 MATCHES '[E]' THEN     #160815-00031#1
        CALL cl_set_comp_required("pmdb050",TRUE)
     END IF
     #20150831-dorislai-add----(E)
     
     #151217-00005#1--add---begin---
     #单价为必要输入栏位勾选后，单身的参考单价栏位必输
     IF g_pmda_m.pmda004 = 'Y' THEN
        CALL cl_set_comp_required("pmdb019",TRUE)
     END IF  
     #151217-00005#1--add---end---
     
END FUNCTION

PRIVATE FUNCTION apmt400_set_no_required_b()
     #20160831-dorislai-modify----(S)  
#    CALL cl_set_comp_required("pmdb015,pmdb005",FALSE)
     CALL cl_set_comp_required("pmdb015,pmdb005,pmdb050",FALSE)
     #20160831-dorislai-modify----(E)
     
     #151217-00005#1--add---begin---
     CALL cl_set_comp_required("pmdb019",FALSE)
     #151217-00005#1--add---end---
     
END FUNCTION
#供應商資料檢查
PRIVATE FUNCTION apmt400_pmdb015_chk(p_pmdb015)
DEFINE p_pmdb015    LIKE pmdb_t.pmdb015
DEFINE l_success    LIKE type_t.num5
DEFINE l_flag       LIKE type_t.num5 
DEFINE r_success    LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT cl_null(p_pmdb015) THEN
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_pmdb015
             
          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_pmaa001_1") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
          
          #判斷輸入的供應商編號是否在控制組限制的供應商範圍內，若不在限制內則不允許跟此供應商採購  
          CALL s_control_chk_group('2','3',g_user,g_dept,p_pmdb015,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00253'
                LET g_errparam.extend = p_pmdb015
                LET g_errparam.popup = TRUE
                CALL cl_err()

                LET r_success = FALSE
                RETURN r_success
             END IF 
          END IF
          
          #檢核輸入的供應商是否在單據別限制範圍內，若不在限制內則不允許跟此供應商採購
          CALL s_control_chk_doc('2',g_pmda_m.pmdadocno,p_pmdb015,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                #CALL cl_err(p_pmdb015,'apm-00239',1)
                LET r_success = FALSE
                RETURN r_success
             END IF 
          END IF
          
          #檢核料件AVL控管點(imaa044)設置
          IF NOT s_apmt400_item_avl_chk(g_pmda_m.pmdadocdt,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,p_pmdb015,g_pmdb_d[l_ac].pmdb006) THEN  #add by lixiang 2015/10/15 pmdb006
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       RETURN r_success
       
END FUNCTION

PRIVATE FUNCTION apmt400_pmdb015_ref(p_pmdb015)
DEFINE p_pmdb015     LIKE pmdb_t.pmdb015
DEFINE r_pmaal004    LIKE pmaal_t.pmaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb015
       CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaal004 = '', g_rtn_fields[1] , ''
       RETURN r_pmaal004
       
END FUNCTION
#付款条件检查
PRIVATE FUNCTION apmt400_pmdb016_chk(p_pmdb015,p_pmdb016)
DEFINE p_pmdb015    LIKE pmdb_t.pmdb015
DEFINE p_pmdb016    LIKE pmdb_t.pmdb016
DEFINE r_success    LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT cl_null(p_pmdb016) THEN
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          IF NOT cl_null(p_pmdb015) THEN
             LET g_chkparam.arg1 = p_pmdb015
             LET g_chkparam.arg2 = p_pmdb016
            
             #呼叫檢查存在並帶值的library
             IF NOT cl_chk_exist("v_pmad002_1") THEN
                LET r_success = FALSE
                RETURN r_success
             END IF            
          ELSE
             LET g_chkparam.arg1 = p_pmdb016
              #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="apm-00186:sub-01302|aooi716|",cl_get_progname("aooi716",g_lang,"2"),"|:EXEPROGaooi716"
               #160318-00025#16 by 07900 --add-end
             #呼叫檢查存在並帶值的library
             IF NOT cl_chk_exist("v_ooib002") THEN
                LET r_success = FALSE
                RETURN r_success
             END IF          
          END IF
       END IF   
       RETURN r_success
       
END FUNCTION

PRIVATE FUNCTION apmt400_pmdb016_ref(p_pmdb016)
DEFINE p_pmdb016      LIKE pmdb_t.pmdb016
DEFINE r_ooibl004     LIKE ooibl_t.ooibl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb016
       CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_ooibl004 = g_rtn_fields[1]
       RETURN r_ooibl004
       
END FUNCTION

PRIVATE FUNCTION apmt400_pmdb017_ref(p_pmdb017)
DEFINE p_pmdb017      LIKE pmdb_t.pmdb017
DEFINE r_oocql004     LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb017
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_oocql004 = g_rtn_fields[1]
       RETURN r_oocql004
       
END FUNCTION
#計算單身含稅金額、未稅金額
PRIVATE FUNCTION apmt400_money_amount()
      #若單頭的[C:單價含稅否]為Y
      IF cl_null(g_pmdb2_d[l_ac].pmdb019) THEN  #參考單價
         LET g_pmdb2_d[l_ac].pmdb019 = 0
      END IF
      
      IF cl_null(g_pmdb_d[l_ac].pmdb010) THEN   #計價數量
         LET g_pmdb_d[l_ac].pmdb010 = 0
      END IF
      
      IF cl_null(g_pmdb_d[l_ac].pmdb006) THEN   #參考數量
         LET g_pmdb_d[l_ac].pmdb006 = 0
      END IF

      IF cl_null(g_pmdb2_d[l_ac].pmdb018) THEN  #稅率
         LET g_pmdb2_d[l_ac].pmdb018 = 0
      END IF
      
      IF g_pmdb2_d[l_ac].pmdb019 = 0 THEN  #單價為0
         LET g_pmdb2_d[l_ac].pmdb020 = 0   #未稅金額
         LET g_pmdb2_d[l_ac].pmdb021 = 0   #含稅金額
         RETURN
      END IF
 
      #若單頭的[C:單價含稅否]為Y
      IF g_pmda_m.pmda012 = 'Y' THEN
         #整體參數有使用計價單位時,
         #則自動計算[C:含稅金額]=[C:計價數量]*[C:單價]，
         #         [C:未稅金額]=[C:計價數量]*[C:單價]*(1-[C:單身稅率]/100)
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
            LET g_pmdb2_d[l_ac].pmdb021 = g_pmdb_d[l_ac].pmdb010 * g_pmdb2_d[l_ac].pmdb019
            LET g_pmdb2_d[l_ac].pmdb020 = g_pmdb_d[l_ac].pmdb010 * g_pmdb2_d[l_ac].pmdb019 * (1 - g_pmdb2_d[l_ac].pmdb018/100)
         END IF
         
         #整體參數不使用計價單位時，
         #則自動計算[C:含稅金額]=[C:需求數量]*[C:單價]，
         #         [C:未稅金額]=[C:需求數量]*[C:單價]*(1-[C:單身稅率]/100)
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" THEN
            LET g_pmdb2_d[l_ac].pmdb021 = g_pmdb_d[l_ac].pmdb006 * g_pmdb2_d[l_ac].pmdb019
            LET g_pmdb2_d[l_ac].pmdb020 = g_pmdb_d[l_ac].pmdb006 * g_pmdb2_d[l_ac].pmdb019 * (1 - g_pmdb2_d[l_ac].pmdb018/100)
         END IF
      END IF
      
      #若單頭的[C:單價含稅否]為N
      IF g_pmda_m.pmda012 = 'N' THEN
         #整體參數有使用計價單位時,
         #則自動計算[C:未稅金額]=[C:計價數量]*[C:單價]，
         #         [C:含稅金額]=[C:計價數量]*[C:單價]*(1+[C:單身稅率]/100)
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
            LET g_pmdb2_d[l_ac].pmdb020 = g_pmdb_d[l_ac].pmdb010 * g_pmdb2_d[l_ac].pmdb019
            LET g_pmdb2_d[l_ac].pmdb021 = g_pmdb_d[l_ac].pmdb010 * g_pmdb2_d[l_ac].pmdb019 * (1 + g_pmdb2_d[l_ac].pmdb018/100)
         END IF
         
         #整體參數不使用計價單位時，
         #則自動計算[C:未稅金額]=[C:需求數量]*[C:單價]，
         #         [C:含稅金額]=[C:需求數量]*[C:單價]*(1+[C:單身稅率]/100)
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" THEN
            LET g_pmdb2_d[l_ac].pmdb020 = g_pmdb_d[l_ac].pmdb006 * g_pmdb2_d[l_ac].pmdb019
            LET g_pmdb2_d[l_ac].pmdb021 = g_pmdb_d[l_ac].pmdb006 * g_pmdb2_d[l_ac].pmdb019 * (1 + g_pmdb2_d[l_ac].pmdb018/100)
         END IF
      END IF
      
      #根據幣別對金額欄位進行取位
      CALL s_curr_round(g_site,g_pmda_m.pmda005,g_pmdb2_d[l_ac].pmdb020,'2') RETURNING g_pmdb2_d[l_ac].pmdb020
      CALL s_curr_round(g_site,g_pmda_m.pmda005,g_pmdb2_d[l_ac].pmdb021,'2') RETURNING g_pmdb2_d[l_ac].pmdb021
         
END FUNCTION
#檢核理由碼
PRIVATE FUNCTION apmt400_pmdb031_chk(p_pmdb031)
DEFINE p_pmdb031  LIKE pmdb_t.pmdb031
DEFINE l_success  LIKE type_t.num5
DEFINE r_success  LIKE type_t.num5
DEFINE l_flag     LIKE type_t.num5

        LET r_success = TRUE
        
        IF NOT cl_null(p_pmdb031) THEN
           CALL s_azzi650_chk_exist(g_acc,p_pmdb031) RETURNING l_success
           IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
           END IF
           
           #s_control_chk_doc('8',pmdadocno,pmdb031,'','','','')應用元件，
           #檢核輸入的理由碼是否在單據別限制範圍內，若不在限制內則不允許使用此理由碼
           CALL s_control_chk_doc('8',g_pmda_m.pmdadocno,p_pmdb031,'','','','') RETURNING l_success,l_flag
           IF NOT r_success THEN
              LET r_success = FALSE
              RETURN r_success
           ELSE
              IF NOT l_flag THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
        END IF           
        RETURN r_success

END FUNCTION

PRIVATE FUNCTION apmt400_pmdb031_ref(p_pmdb031)
DEFINE p_pmdb031  LIKE pmdb_t.pmdb031
DEFINE r_oocql004 LIKE oocql_t.oocql004

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = p_pmdb031
        CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET r_oocql004 = '', g_rtn_fields[1] , ''
        RETURN r_oocql004
            
END FUNCTION
#檢查庫位
PRIVATE FUNCTION apmt400_pmdb038_chk()
DEFINE r_success    LIKE type_t.num5

      LET r_success = TRUE
      
      IF NOT cl_null(g_pmdb2_d[l_ac].pmdb038) THEN
         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
         INITIALIZE g_chkparam.* TO NULL
         
         #設定g_chkparam.*的參數
         LET g_chkparam.arg1 = g_pmdb2_d[l_ac].pmdb037
         LET g_chkparam.arg2 = g_pmdb2_d[l_ac].pmdb038
           
         #呼叫檢查存在並帶值的library
         IF NOT cl_chk_exist("v_inaa001_1") THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      RETURN r_success
      
END FUNCTION
#儲位檢查
PRIVATE FUNCTION apmt400_pmdb039_chk()
DEFINE r_success    LIKE type_t.num5

      LET r_success = TRUE
      
      IF NOT cl_null(g_pmdb2_d[l_ac].pmdb039) THEN 
         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
         INITIALIZE g_chkparam.* TO NULL
         
         #設定g_chkparam.*的參數
         LET g_chkparam.arg1 = g_pmdb2_d[l_ac].pmdb037
         LET g_chkparam.arg2 = g_pmdb2_d[l_ac].pmdb038
         LET g_chkparam.arg3 = g_pmdb2_d[l_ac].pmdb039
    
         #呼叫檢查存在並帶值的library
         IF NOT cl_chk_exist("v_inab002_1") THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      RETURN r_success
      
END FUNCTION

PRIVATE FUNCTION apmt400_pmdb037_ref(p_pmdb037)
DEFINE p_pmdb037      LIKE pmdb_t.pmdb037
DEFINE r_ooefl003     LIKE ooefl_t.ooefl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb037
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_ooefl003 = '', g_rtn_fields[1] , ''
       RETURN r_ooefl003
       
END FUNCTION

PRIVATE FUNCTION apmt400_pmdb038_ref(p_pmdb037,p_pmdb038)
DEFINE p_pmdb037    LIKE pmdb_t.pmdb037
DEFINE p_pmdb038    LIKE pmdb_t.pmdb038
DEFINE r_inaa002    LIKE inaa_t.inaa002
       #20150824-dorilsai-modify----(S)  
#       INITIALIZE g_ref_fields TO NULL
#       LET g_ref_fields[1] = p_pmdb038
#       CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite='"||p_pmdb037||"' AND inaa001=? ","") RETURNING g_rtn_fields
#       LET r_inaa002 = '', g_rtn_fields[1] , ''
       CALL s_desc_get_stock_desc(g_site,p_pmdb038) RETURNING r_inaa002 
       #20150824-dorilsai-modify----(E)
       RETURN r_inaa002
       
END FUNCTION
################################################################################
# Descriptions...: 取得未稅金額、含稅金額、稅額
# Memo...........:
# Usage..........: CALL apmt400_get_amount(p_pmdbseq,p_pmdb006,p_pmdb019,p_pmda010)
#                  RETURNING r_pmdb020,r_pmdb021
# Input parameter: p_pmdbseq      項次
#                : p_pmdb006      數量
#                : p_pmdb019      單價
#                : p_pmda010      稅別
# Return code....: r_pmdb020      未稅金額
#                : r_pmdb021      含稅金額
# Date & Author..: 2014/03/11 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt400_get_amount(p_pmdbseq,p_pmdb006,p_pmdb019,p_pmda010)
DEFINE p_pmdbseq         LIKE pmdb_t.pmdbseq
DEFINE p_pmdb006         LIKE pmdb_t.pmdb006
DEFINE p_pmdb019         LIKE pmdb_t.pmdb019
DEFINE p_pmda010         LIKE pmda_t.pmda010
DEFINE r_pmdb020         LIKE pmdb_t.pmdb020
DEFINE r_pmdb021         LIKE pmdb_t.pmdb021
DEFINE l_pmdb020_1       LIKE pmdb_t.pmdb020
DEFINE l_money           LIKE pmdb_t.pmdb020
DEFINE l_xrcd113         LIKE xrcd_t.xrcd113
DEFINE l_xrcd114         LIKE xrcd_t.xrcd114
DEFINE l_xrcd115         LIKE xrcd_t.xrcd115
DEFINE l_xrcd123         LIKE xrcd_t.xrcd113
DEFINE l_xrcd124         LIKE xrcd_t.xrcd114
DEFINE l_xrcd125         LIKE xrcd_t.xrcd115
DEFINE l_xrcd133         LIKE xrcd_t.xrcd113
DEFINE l_xrcd134         LIKE xrcd_t.xrcd114
DEFINE l_xrcd135         LIKE xrcd_t.xrcd115

   LET r_pmdb020 = 0
   LET r_pmdb021 = 0

   IF cl_null(p_pmdbseq) OR cl_null(p_pmdb006) OR
      cl_null(p_pmdb019) OR cl_null(p_pmda010) OR cl_null(g_pmda_m.pmda005) THEN
      RETURN r_pmdb020,r_pmdb021
   END IF

   LET l_money = p_pmdb006 * p_pmdb019
   CALL s_tax_ins(g_pmda_m.pmdadocno,p_pmdbseq,0,g_pmda_m.pmdasite,l_money,p_pmda010,
                  p_pmdb006,g_pmda_m.pmda005,1,' ',1,1)
        RETURNING r_pmdb020,l_pmdb020_1,r_pmdb021,l_xrcd113,l_xrcd114,l_xrcd115,
                  l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135

   IF cl_null(r_pmdb020) THEN LET r_pmdb020 = 0 END IF
   IF cl_null(r_pmdb021) THEN LET r_pmdb021 = 0 END IF

   RETURN r_pmdb020,r_pmdb021

END FUNCTION

PRIVATE FUNCTION apmt400_pmdb039_ref(p_pmdb037,p_pmdb038,p_pmdb039)
DEFINE p_pmdb037    LIKE pmdb_t.pmdb037
DEFINE p_pmdb038    LIKE pmdb_t.pmdb038
DEFINE p_pmdb039    LIKE pmdb_t.pmdb039
DEFINE r_inab002    LIKE inab_t.inab002


       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb039
       CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||p_pmdb037||"' AND inab001='"||p_pmdb038||"' AND inab002=? ","") RETURNING g_rtn_fields
       LET r_inab002 = '', g_rtn_fields[1] , ''
       RETURN r_inab002

END FUNCTION
################################################################################
# Descriptions...: 取得單據別設定的欄位預設值
# Memo...........: 需搭配單據別aooi200的設定
# Usage..........: CALL apmt400_get_col_default()
# Date & Author..: 2014/03/11 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt400_get_col_default()
DEFINE l_ooef016  LIKE ooef_t.ooef016
DEFINE l_success  LIKE type_t.num5
DEFINE l_oodb011  LIKE oodb_t.oodb011

   LET g_pmda_m.pmdadocdt = s_aooi200_get_doc_default(g_site,'1',g_pmda_m.pmdadocno,'pmdadocdt',g_pmda_m.pmdadocdt)
   LET g_pmda_m.pmda002 = s_aooi200_get_doc_default(g_site,'1',g_pmda_m.pmdadocno,'pmda002',g_pmda_m.pmda002)
   LET g_pmda_m.pmda003 = s_aooi200_get_doc_default(g_site,'1',g_pmda_m.pmdadocno,'pmda003',g_pmda_m.pmda003)
   LET g_pmda_m.pmda004 = s_aooi200_get_doc_default(g_site,'1',g_pmda_m.pmdadocno,'pmda004',g_pmda_m.pmda004)
   LET g_pmda_m.pmda010 = s_aooi200_get_doc_default(g_site,'1',g_pmda_m.pmdadocno,'pmda010',g_pmda_m.pmda010)
   LET g_pmda_m.pmda005 = s_aooi200_get_doc_default(g_site,'1',g_pmda_m.pmdadocno,'pmda005',g_pmda_m.pmda005)
   LET g_pmda_m.pmda007 = s_aooi200_get_doc_default(g_site,'1',g_pmda_m.pmdadocno,'pmda007',g_pmda_m.pmda007)
   LET g_pmda_m.pmda021 = s_aooi200_get_doc_default(g_site,'1',g_pmda_m.pmdadocno,'pmda021',g_pmda_m.pmda021)
   LET g_pmda_m.pmda020 = s_aooi200_get_doc_default(g_site,'1',g_pmda_m.pmdadocno,'pmda020',g_pmda_m.pmda020)
   LET g_pmda_m.pmda022 = s_aooi200_get_doc_default(g_site,'1',g_pmda_m.pmdadocno,'pmda022',g_pmda_m.pmda022)
   
   #根據稅別帶出稅率、含稅否等
   IF NOT cl_null(g_pmda_m.pmda010) THEN
      CALL s_tax_chk(g_site,g_pmda_m.pmda010)
          RETURNING l_success,g_pmda_m.pmda010_desc,g_pmda_m.pmda012,g_pmda_m.pmda011,l_oodb011
   END IF
   
   DISPLAY BY NAME g_pmda_m.pmdadocdt,g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmdadocno_desc,g_pmda_m.pmda003, 
       g_pmda_m.pmda003_desc,g_pmda_m.pmdastus,g_pmda_m.pmda004,g_pmda_m.pmda010,g_pmda_m.pmda010_desc, 
       g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda005_desc,g_pmda_m.ooan005,g_pmda_m.pmda008, 
       g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda007_desc,g_pmda_m.pmda021,g_pmda_m.pmda021_desc, 
       g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda022
       
   
   CALL apmt400_pmda002_ref(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
   DISPLAY BY NAME g_pmda_m.pmda002_desc
   
   CALL apmt400_pmda003_ref(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
   DISPLAY BY NAME g_pmda_m.pmda003_desc
   
   CALL apmt400_pmda010_ref(g_pmda_m.pmda010) RETURNING g_pmda_m.pmda010_desc
   DISPLAY BY NAME g_pmda_m.pmda010_desc
   
   CALL apmt400_pmda005_ref(g_pmda_m.pmda005) RETURNING g_pmda_m.pmda005_desc
   DISPLAY BY NAME g_pmda_m.pmda005_desc
   
   LET g_pmda_m.ooan005 = ''
   IF NOT cl_null(g_pmda_m.pmda005) THEN
      LET l_ooef016 = ''
      SELECT ooef016 INTO l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
      CALL s_aooi160_get_exrate('1',g_site,g_today,g_pmda_m.pmda005,l_ooef016,0,'11') RETURNING g_pmda_m.ooan005
   END IF
   DISPLAY BY NAME g_pmda_m.ooan005            
   
   CALL apmt400_pmda003_ref(g_pmda_m.pmda007) RETURNING g_pmda_m.pmda007_desc
   DISPLAY BY NAME g_pmda_m.pmda007_desc
   
   CALL apmt400_pmda021_ref(g_pmda_m.pmda021) RETURNING g_pmda_m.pmda021_desc
   DISPLAY BY NAME g_pmda_m.pmda021_desc
   
   #ming 20150821 add -----------------------------(S) 
   CALL apmt400_pmda024_ref(g_pmda_m.pmda024)
        RETURNING g_pmda_m.pmda024_desc
   DISPLAY BY NAME g_pmda_m.pmda024_desc

   CALL apmt400_pmda025_ref(g_pmda_m.pmda025)
        RETURNING g_pmda_m.pmda025_desc
   DISPLAY BY NAME g_pmda_m.pmda025_desc
   #ming 20150821 add -----------------------------(E) 
   
END FUNCTION

################################################################################
# Descriptions...: 取得產品特徵類別
# Memo...........:
# Usage..........: CALL apmt400_get_imaa005(p_enterprise,p_imaa001)
#                  RETURNING r_imaa005
# Input parameter: p_enterprise   企業編號
#                : p_imaa001      料號
# Return code....: r_imaa005      特徵類別
# Date & Author..: 2014/06/12 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt400_get_imaa005(p_enterprise,p_imaa001)
   DEFINE p_enterprise   LIKE type_t.num5,
          p_imaa001      LIKE imaa_t.imaa001
   DEFINE r_imaa005      LIKE imaa_t.imaa005

   LET r_imaa005 = ''
   SELECT imaa005 INTO r_imaa005 
     FROM imaa_t 
    WHERE imaaent = p_enterprise 
      AND imaa001 = p_imaa001
      
   RETURN r_imaa005   
END FUNCTION
#請購時，檢查料件據點設置的採購單位批量與最小採購量,
#請購單先提示，因為請購轉採購時，有可能會進行匯總，採購單再做控管
PRIVATE FUNCTION apmt400_pmdb006_chk()
DEFINE l_imaf143    LIKE imaf_t.imaf143  #採購單位
DEFINE l_imaf145    LIKE imaf_t.imaf145  #採購單位批量
DEFINE l_imaf146    LIKE imaf_t.imaf146  #採購最小數量
DEFINE l_imaf147    LIKE imaf_t.imaf147  #單位批量控管方式
DEFINE l_success    LIKE type_t.num5
DEFINE l_qty        LIKE pmdb_t.pmdb006  #數量
DEFINE l_mod        LIKE type_t.num10
DEFINE l_qty1       LIKE pmdb_t.pmdb006  
DEFINE l_n_qty      LIKE type_t.num10    
DEFINE l_msg        STRING               
DEFINE l_min_qty    LIKE pmdb_t.pmdb006
DEFINE l_qty2       LIKE pmdb_t.pmdb006 

       IF cl_null(g_pmdb_d[l_ac].pmdb004) OR cl_null(g_pmdb_d[l_ac].pmdb007) OR cl_null(g_pmdb_d[l_ac].pmdb006) THEN
          RETURN 
       END IF
       
       SELECT imaf143,imaf145,imaf146,imaf147 INTO l_imaf143,l_imaf145,l_imaf146,l_imaf147
         FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdb_d[l_ac].pmdb004
       IF SQLCA.SQLCODE = 100 THEN
          SELECT imaf143,imaf145,imaf146,imaf147 INTO l_imaf143,l_imaf145,l_imaf146,l_imaf147
            FROM imaf_t WHERE imafent = g_enterprise AND imafsite = "ALL" AND imaf001 = g_pmdb_d[l_ac].pmdb004
       END IF
       
       IF cl_null(l_imaf145) THEN
          LET l_imaf145 = 0
       END IF
       IF cl_null(l_imaf146) THEN
          LET l_imaf146 = 0
       END IF
       LET l_qty = g_pmdb_d[l_ac].pmdb006
       #需求單位與採購不一致時，需換算成採購單位對應的數量進行計算
       IF NOT cl_null(l_imaf143) THEN
          IF l_imaf143 <> g_pmdb_d[l_ac].pmdb007 AND (NOT cl_null(l_imaf143)) THEN
             CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,l_imaf143,g_pmdb_d[l_ac].pmdb006)
                 RETURNING l_success,l_qty
          END IF
          
          CALL s_aooi250_take_decimals(l_imaf143,l_qty) RETURNING l_success,l_qty
          CALL s_aooi250_take_decimals(l_imaf143,l_imaf145) RETURNING l_success,l_imaf145
          CALL s_aooi250_take_decimals(l_imaf143,l_imaf146) RETURNING l_success,l_imaf146
          
          IF NOT cl_null(l_imaf146) THEN
             IF l_imaf146 > l_qty THEN
                LET l_min_qty = l_imaf146
             ELSE 
                LET l_min_qty = l_qty
             END IF
          END IF 
          
          IF NOT cl_null(l_imaf145) AND l_imaf145 != 0 THEN
             LET l_n_qty = l_min_qty / l_imaf145
             IF l_min_qty != l_imaf145 * l_n_qty THEN
                IF l_min_qty > l_imaf145 * l_n_qty THEN
                   LET l_qty1 = l_imaf145 * (l_n_qty + 1)
                ELSE
                   LET l_qty1 = l_imaf145 * l_n_qty
                END IF
             ELSE
                LET l_qty1 = l_imaf145 * l_n_qty
             END IF
          ELSE
             LET l_qty1 = l_min_qty
          END IF
          
          #IF l_imaf145 > 0 THEN  #有維護最小批量時，檢查
          #   LET l_mod = l_qty MOD l_imaf145
          #   IF l_mod <> 0 THEN  #有餘數，說明不是整除
          #      IF l_imaf147 = '1' THEN   #警告
          #         INITIALIZE g_errparam TO NULL
          #         LET g_errparam.code = 'apm-00599'
          #         LET g_errparam.extend = g_pmdb_d[l_ac].pmdb004
          #         LET g_errparam.popup = TRUE
          #         CALL cl_err()
          #      END IF
          #   END IF
          #END IF
          IF l_qty < l_qty1 THEN
             IF l_imaf147 MATCHES '[12]' THEN
                #轉換成當前輸入的請購單位對應的數量進行報錯
                IF l_imaf143 <> g_pmdb_d[l_ac].pmdb007 AND (NOT cl_null(l_imaf143)) THEN
                   CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,l_imaf143,g_pmdb_d[l_ac].pmdb007,l_qty1)
                       RETURNING l_success,l_qty2
                END IF
                LET l_msg = cl_getmsg('apm-00600',g_lang),l_qty2 USING '---,---,---,--&.&&&'
                IF cl_ask_promp(l_msg) THEN
                   LET l_qty = l_qty1
                END IF
             END IF
          END IF
          
          #IF l_qty < l_imaf146 THEN
          #   INITIALIZE g_errparam TO NULL
          #   LET g_errparam.code = 'apm-00600'
          #   LET g_errparam.extend = g_pmdb_d[l_ac].pmdb004
          #   LET g_errparam.popup = TRUE
          #   CALL cl_err()
          #END IF
          IF l_imaf143 <> g_pmdb_d[l_ac].pmdb007 AND (NOT cl_null(l_imaf143)) THEN
             CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,l_imaf143,g_pmdb_d[l_ac].pmdb007,l_qty)
                 RETURNING l_success,g_pmdb_d[l_ac].pmdb006
          ELSE
             LET g_pmdb_d[l_ac].pmdb006 = l_qty
          END IF
       END IF
END FUNCTION

#留置時，維護留置理由碼
PRIVATE FUNCTION apmt400_upd_pmda023()
DEFINE r_success   LIKE type_t.num5
DEFINE l_pmdamoddt LIKE pmda_t.pmdamoddt
DEFINE l_sql       STRING

   LET r_success = TRUE
   
   IF g_pmda_m.pmdadocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_sql = "SELECT pmdasite,pmdadocno,pmda001,pmdadocdt,pmda002,pmda003,pmdastus, ",
                      " pmda004,pmda010,pmda011,pmda012,pmda005,pmda008,pmda009,pmda007,pmda021,pmda020, ",
                      " pmda006,pmda022,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,pmdacrtdt,pmdamodid,pmdamoddt, ",
                      " pmdacnfid,pmdacnfdt FROM pmda_t WHERE pmdaent= ? AND pmdadocno=? FOR UPDATE"
   LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   DECLARE apmt400_pmda023_cl CURSOR FROM l_sql
   
   OPEN apmt400_pmda023_cl USING g_enterprise,g_pmda_m.pmdadocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN apmt400_pmda023_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE apmt400_pmda023_cl
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #鎖住將被更改的資料
   FETCH apmt400_pmda023_cl INTO g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocdt, 
                                 g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004,g_pmda_m.pmda010, 
                                 g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008, 
                                 g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda021,
                                 g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda022,g_pmda_m.pmdaownid,
                                 g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,
                                 g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
                                 g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt
   
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_pmda_m.pmdadocno 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CLOSE apmt400_pmda023_cl
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL apmt400_show()
    
   CALL cl_set_comp_entry("pmda023",TRUE)
   
   LET g_pmda_m_t.* = g_pmda_m.*
   
   INPUT BY NAME g_pmda_m.pmda023 WITHOUT DEFAULTS
             
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            LET r_success = FALSE
            RETURN r_success
         END IF

      AFTER FIELD pmda023
         CALL s_desc_get_acc_desc('317',g_pmda_m.pmda023) RETURNING g_pmda_m.pmda023_desc
         DISPLAY BY NAME g_pmda_m.pmda023_desc
         IF NOT cl_null(g_pmda_m.pmda023) THEN
            IF NOT s_azzi650_chk_exist('317',g_pmda_m.pmda023) THEN
               LET g_pmda_m.pmda023 = g_pmda_m_t.pmda023
               CALL s_desc_get_acc_desc('317',g_pmda_m.pmda023) RETURNING g_pmda_m.pmda023_desc
               DISPLAY BY NAME g_pmda_m.pmda023_desc
               NEXT FIELD pmda023
            END IF
         END IF
         
      ON ACTION controlp INFIELD pmda023
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE

         LET g_qryparam.default1 = g_pmda_m.pmda023             
         #給予arg
         LET g_qryparam.arg1 = "317" 
         CALL q_oocq002()                                #呼叫開窗

         LET g_pmda_m.pmda023 = g_qryparam.return1    
         DISPLAY g_pmda_m.pmda023 TO pmda023 
         CALL s_desc_get_acc_desc('317',g_pmda_m.pmda023) RETURNING g_pmda_m.pmda023_desc
         DISPLAY BY NAME g_pmda_m.pmda023_desc         
         NEXT FIELD pmda023                          #返回原欄位

      
   END INPUT
   
   IF INT_FLAG OR g_pmda_m.pmda023 IS NULL THEN
      LET INT_FLAG = 0
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET l_pmdamoddt = cl_get_current()

   UPDATE pmda_t SET pmda023 = g_pmda_m.pmda023,
                     pmdamodid = g_user,
                     pmdamoddt = l_pmdamoddt
     WHERE pmdaent = g_enterprise AND pmdadocno = g_pmda_m.pmdadocno

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "g_pmda_m"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE apmt400_pmda023_cl
      LET r_success = FALSE
      RETURN r_success 
   END IF
   
   CALL cl_set_comp_entry("pmda023",FALSE)
    
   CLOSE apmt400_pmda023_cl
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 科目預算的處理
# Memo...........:
# Usage..........: CALL apmt400_detail_abg(p_type)
#                  RETURNING r_success,r_errno,r_bgaf016,r_bgae001,r_bgae001_desc
# Input parameter: p_type         1.預算項目開窗
#                                 2.預算項目檢核
#                                 3.預算項目說明
#                                 4.檢核金額
# Return code....: r_success      TRUE/FALSE
#                : r_errno        錯誤訊息
#                : r_bgaf016      錯誤處理方式
#                : r_bgae001      預算項目
#                : r_bgae001_desc 說明
# Date & Author..: 2015/08/19 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt400_detail_abg(p_type)
DEFINE p_type             LIKE type_t.chr10
DEFINE r_success          LIKE type_t.num5
DEFINE r_errno            LIKE gzze_t.gzze001
DEFINE r_bgaf016          LIKE bgaf_t.bgaf016
DEFINE r_bgae001          LIKE bgae_t.bgae001
DEFINE r_bgae001_desc     LIKE type_t.chr80 
DEFINE l_success          LIKE type_t.num5
DEFINE l_slip             LIKE pmda_t.pmdadocno
DEFINE l_imaa009          LIKE imaa_t.imaa009
DEFINE l_tran             RECORD
         act              LIKE type_t.chr10,   #[1].chr 動作
         site             LIKE ooef_t.ooef001, #[2].chr 預算組織
         dat              LIKE type_t.dat,     #[3].dat 日期
         bgae001          LIKE bgae_t.bgae001, #[4].chr 預算項目
         bgbd013          LIKE bgbd_t.bgbd013, #[5].chr 部門
         bgbd014          LIKE bgbd_t.bgbd014, #[6].chr 利潤成本中心
         bgbd015          LIKE bgbd_t.bgbd015, #[7].chr 區域
         bgbd016          LIKE bgbd_t.bgbd016, #[8].chr 交易客商
         bgbd017          LIKE bgbd_t.bgbd017, #[9].chr 收款客商
         bgbd018          LIKE bgbd_t.bgbd018, #[10].chr 客群
         bgbd019          LIKE bgbd_t.bgbd019, #[11].chr 產品類別
         bgbd020          LIKE bgbd_t.bgbd020, #[12].chr 人員
         bgbd021          LIKE bgbd_t.bgbd021, #[13].chr 專案
         bgbd022          LIKE bgbd_t.bgbd022, #[14].chr WBS
         bgbd023          LIKE bgbd_t.bgbd023, #[15].chr 經營方式
         bgbd024          LIKE bgbd_t.bgbd024, #[16].chr 自由核算項一
         bgbd025          LIKE bgbd_t.bgbd025, #[17].chr 自由核算項二
         bgbd026          LIKE bgbd_t.bgbd026, #[18].chr 自由核算項三
         bgbd027          LIKE bgbd_t.bgbd027, #[19].chr 自由核算項四
         bgbd028          LIKE bgbd_t.bgbd028, #[20].chr 自由核算項五
         bgbd029          LIKE bgbd_t.bgbd029, #[21].chr 自由核算項六
         bgbd030          LIKE bgbd_t.bgbd030, #[22].chr 自由核算項七
         bgbd031          LIKE bgbd_t.bgbd031, #[23].chr 自由核算項八
         bgbd032          LIKE bgbd_t.bgbd032, #[24].chr 自由核算項九
         bgbd033          LIKE bgbd_t.bgbd033, #[25].chr 自由核算項十
         bgbd042          LIKE bgbd_t.bgbd042, #[26].chr 渠道
         bgbd043          LIKE bgbd_t.bgbd043, #[27].chr 品牌
         used036          LIKE bgbd_t.bgbd036, #[28].chr 使用程式
         used037          LIKE bgbd_t.bgbd037, #[29].chr 使用單號 
         used038          LIKE bgbd_t.bgbd038, #[30].chr 使用項次
         sour036          LIKE bgbd_t.bgbd036, #[31].chr 轉出程式
         sour037          LIKE bgbd_t.bgbd037, #[32].chr 轉出單號
         sour038          LIKE bgbd_t.bgbd038, #[33].chr 轉出項次
         curr             LIKE ooai_t.ooai001, #[34].chr 幣別
         account          LIKE type_t.num20_6  #[35].chr 金額
                          END RECORD
DEFINE ls_js              STRING

   LET r_success = TRUE
   LET r_errno = ''
   LET r_bgaf016 = ''
   LET r_bgae001 = ''
   LET r_bgae001_desc = ''
   
   CALL s_aooi200_get_slip(g_pmda_m.pmdadocno)
        RETURNING l_success,l_slip
   IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'N' THEN
      RETURN r_success,r_errno,r_bgaf016,r_bgae001,r_bgae001_desc
   END IF
   
   #160106-00006#1---add---begin---
   #當傳入類型的金額檢核時，但預算科目為空，則無需進行檢核，否則會出現畫面上預算科目為空，修改數量時卻一直報錯，無法繼續報錯
   IF p_type MATCHES '[24]' AND cl_null(g_pmdb2_d[l_ac].pmdb053) THEN
       RETURN r_success,r_errno,r_bgaf016,r_bgae001,r_bgae001_desc
   END IF
   #160106-00006#1---add---end---
      
   SELECT imaa009 INTO l_imaa009
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_pmdb_d[l_ac].pmdb004
   
   INITIALIZE l_tran.* TO NULL
   LET l_tran.site = g_site
   LET l_tran.dat = g_pmda_m.pmdadocdt
   LET l_tran.bgae001 = g_pmdb2_d[l_ac].pmdb053
   LET l_tran.bgbd013 = g_pmda_m.pmda003
   LET l_tran.bgbd016 = g_pmdb2_d[l_ac].pmdb015 
   LET l_tran.bgbd019 = l_imaa009
   LET l_tran.bgbd020 = g_pmda_m.pmda002
   LET l_tran.bgbd021 = g_pmdb2_d[l_ac].pmdb034
   LET l_tran.bgbd022 = g_pmdb2_d[l_ac].pmdb035
   LET l_tran.used036 = 'apmt400'
   LET l_tran.used037 = g_pmda_m.pmdadocno
   LET l_tran.used038 = g_pmdb2_d[l_ac].pmdbseq
   LET l_tran.curr    = g_pmda_m.pmda005
   LET l_tran.account = g_pmdb2_d[l_ac].pmdb020
   
   LET ls_js = util.JSON.stringify(l_tran)
   
   #1.預算項目開窗
   #2.預算項目檢核
   #3.預算項目說明
   #4.檢核金額
   CASE p_type
      WHEN '1'
           CALL s_abg_bgae001_query2(ls_js)
                RETURNING r_bgae001
                
           LET l_tran.bgae001 = r_bgae001
           LET ls_js = util.JSON.stringify(l_tran)
           CALL s_abg_bgae001_desc2(ls_js)
                RETURNING r_bgae001_desc
      WHEN '2'
           CALL s_abg_bgae001_chk2(ls_js)
                RETURNING r_success,r_errno
           IF r_success THEN
              CALL s_abg_bgae001_desc2(ls_js)
                   RETURNING r_bgae001_desc
           END IF
      WHEN '3'
           CALL s_abg_bgae001_desc2(ls_js)
                RETURNING r_bgae001_desc
      WHEN '4'
           CALL s_abg_bg_used_chk(ls_js)
                RETURNING r_success,r_errno,r_bgaf016
   END CASE
   
   RETURN r_success,r_errno,r_bgaf016,r_bgae001,r_bgae001_desc

END FUNCTION

PRIVATE FUNCTION apmt400_pmda024_ref(p_pmda024)
   DEFINE p_pmda024     LIKE pmda_t.pmda024
   DEFINE r_oofb011     LIKE oofb_t.oofb011

   LET r_oofb011 =  ''
   SELECT oofb011 INTO r_oofb011
     FROM oofb_t
    WHERE oofbent = g_enterprise
      AND oofb002 = g_oofa001
      AND oofb008 = '3'
      AND oofb019 = p_pmda024

   RETURN r_oofb011
END FUNCTION

PRIVATE FUNCTION apmt400_pmda025_ref(p_pmda025)
   DEFINE p_pmda025     LIKE pmda_t.pmda025
   DEFINE r_oofb011     LIKE oofb_t.oofb011

   LET r_oofb011 =  ''
   SELECT oofb011 INTO r_oofb011
     FROM oofb_t
    WHERE oofbent = g_enterprise
      AND oofb002 = g_oofa001
      AND oofb008 = '5'
      AND oofb019 = p_pmda025

   RETURN r_oofb011
END FUNCTION

################################################################################
# Descriptions...: 來源為訂單時，數量不可大於訂購量
# Memo...........:
# Usage..........: CALL apmt400_order_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success
# Date & Author..: 151210-00002#1 151221 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt400_order_chk()
DEFINE l_xmdd006 LIKE xmdd_t.xmdd006
DEFINE l_pmdb006 LIKE pmdb_t.pmdb006
DEFINE r_success LIKE type_t.num5


  LET r_success = TRUE
  IF cl_null(g_pmdb_d[l_ac].pmdb001) OR cl_null(g_pmdb_d[l_ac].pmdb002) OR
     cl_null(g_pmdb_d[l_ac].pmdb003) OR cl_null(g_pmdb_d[l_ac].pmdb052) THEN
     RETURN r_success
  END IF   
  SELECT SUM(xmdd006) INTO l_xmdd006 
    FROM xmdd_t
   WHERE xmddent = g_enterprise
     AND xmdddocno = g_pmdb_d[l_ac].pmdb001
     AND xmddseq = g_pmdb_d[l_ac].pmdb002
     AND xmddseq1 = g_pmdb_d[l_ac].pmdb003
     AND xmddseq2 = g_pmdb_d[l_ac].pmdb052
  IF cl_null(l_xmdd006) THEN
     RETURN r_success  
  END IF
  
   LET l_pmdb006 = 0
   SELECT SUM(pmdb006) INTO l_pmdb006
     FROM pmda_t,pmdb_t
    WHERE pmdaent = pmdbent
      AND pmdadocno = pmdbdocno
      AND pmdaent = g_enterprise
      AND pmdastus <> 'X'
      AND (pmdbdocno <> g_pmda_m.pmdadocno AND pmdbseq = g_pmdb_d[l_ac].pmdbseq )
      AND pmdb001 = g_pmdb_d[l_ac].pmdb001
      AND pmdb002 = g_pmdb_d[l_ac].pmdb002
      AND pmdb003 = g_pmdb_d[l_ac].pmdb003
      AND pmdb052 = g_pmdb_d[l_ac].pmdb052
      
   IF cl_null(l_pmdb006) THEN LET l_pmdb006 = 0 END IF  
   
   IF l_pmdb006 + g_pmdb_d[l_ac].pmdb006  > l_xmdd006 THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
  
END FUNCTION

#160727-00025#9
#来源是工单時，須檢核不可超過工單總應發數量
PRIVATE FUNCTION apmt400_work_order_chk()
DEFINE l_sfba014     LIKE sfba_t.sfba014
DEFINE l_sfba013     LIKE sfba_t.sfba013
DEFINE l_pmdb006     LIKE pmdb_t.pmdb006
DEFINE l_pmdb007     LIKE pmdb_t.pmdb007
DEFINE l_pmdb006_sum LIKE pmdb_t.pmdb006
DEFINE r_success     LIKE type_t.num5
DEFINE  l_success    LIKE type_t.num5

   LET r_success = TRUE
   IF cl_null(g_pmdb_d[l_ac].pmdb001) OR cl_null(g_pmdb_d[l_ac].pmdb002) OR
      cl_null(g_pmdb_d[l_ac].pmdb003) THEN
      RETURN r_success
   END IF   
   SELECT sfba013,sfba014 INTO l_sfba013,l_sfba014 
     FROM sfba_t
    WHERE sfbaent = g_enterprise
      AND sfbadocno = g_pmdb_d[l_ac].pmdb001
      AND sfbaseq = g_pmdb_d[l_ac].pmdb002
      AND sfbaseq1 = g_pmdb_d[l_ac].pmdb003
   IF cl_null(l_sfba013) THEN
      RETURN r_success  
   END IF
   
   IF g_pmdb_d[l_ac].pmdb007 <> l_sfba014 THEN
      CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,l_sfba014,g_pmdb_d[l_ac].pmdb007,l_sfba013)
        RETURNING l_success,l_sfba013
   END IF
  
   LET l_pmdb006 = 0
   LET l_pmdb006_sum = 0
   #計算可以轉請購數量
   DECLARE pmdb006_cs CURSOR FOR
      SELECT pmdb006,pmdb007 FROM pmda_t,pmdb_t 
         WHERE pmdaent = pmdbent
           AND pmdadocno = pmdbdocno
           AND pmdaent = g_enterprise
           AND (pmdbdocno <> g_pmda_m.pmdadocno OR pmdbseq <> g_pmdb_d[l_ac].pmdbseq )
           AND pmdastus <> 'X'
           AND pmdb001 = g_pmdb_d[l_ac].pmdb001
           AND pmdb002 = g_pmdb_d[l_ac].pmdb002
           AND pmdb003 = g_pmdb_d[l_ac].pmdb003
   FOREACH pmdb006_cs INTO l_pmdb006,l_pmdb007
      IF cl_null(l_pmdb006) THEN LET l_pmdb006 = 0 END IF  
      IF l_pmdb007 <> g_pmdb_d[l_ac].pmdb007 THEN
         CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,l_pmdb007,g_pmdb_d[l_ac].pmdb007,l_pmdb006)
           RETURNING l_success,l_pmdb006
      END IF
      LET l_pmdb006_sum = l_pmdb006_sum + l_pmdb006  #總應發數量 - 已轉請購量
   END FOREACH
   
   IF l_pmdb006_sum + g_pmdb_d[l_ac].pmdb006 > l_sfba013 THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
  
END FUNCTION

################################################################################
# Descriptions...: 維護備註單身
# Memo...........: #161031-00025#8 add
################################################################################
PRIVATE FUNCTION apmt400_memos()
DEFINE l_sql      STRING

   IF g_pmda_m.pmdadocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   LET l_sql = "SELECT pmdasite,pmdadocno,pmda001,pmdadocdt,pmda002,pmda003,pmdastus, ",
               " pmda004,pmda010,pmda011,pmda012,pmda005,pmda008,pmda009,pmda007,pmda021,pmda020, ",
               " pmda006,pmda022,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,pmdacrtdt,pmdamodid,pmdamoddt, ",
               " pmdacnfid,pmdacnfdt FROM pmda_t WHERE pmdaent= ? AND pmdadocno=? FOR UPDATE"
   LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   DECLARE apmt400_ooff_cl CURSOR FROM l_sql
   
   CALL s_transaction_begin()
   
   OPEN apmt400_ooff_cl USING g_enterprise,g_pmda_m.pmdadocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN apmt400_ooff_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE apmt400_ooff_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #鎖住將被更改的資料
   FETCH apmt400_ooff_cl INTO g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocdt, 
                              g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004,g_pmda_m.pmda010, 
                              g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008, 
                              g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda021,
                              g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda022,g_pmda_m.pmdaownid,
                              g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,
                              g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
                              g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt
                              
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_pmda_m.pmdadocno 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CLOSE apmt400_ooff_cl
      CALL s_transaction_end('N','0')
      RETURN 
   END IF
 
   #檢查是否允許此動作
   IF NOT apmt400_action_chk() THEN
      CLOSE apmt400_ooff_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmdadocdt, 
                   g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda004,g_pmda_m.pmda010, 
                   g_pmda_m.pmda011,g_pmda_m.pmda012,g_pmda_m.pmda005,g_pmda_m.pmda008, 
                   g_pmda_m.pmda009,g_pmda_m.pmda007,g_pmda_m.pmda021,
                   g_pmda_m.pmda020,g_pmda_m.pmda006,g_pmda_m.pmda022,g_pmda_m.pmdaownid,
                   g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,
                   g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
                   g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt
                              
   LET g_detail_insert = cl_auth_detail_input("insert")
   LET g_detail_delete = cl_auth_detail_input("delete")
   
   LET g_ooff001_d = '6'   #6.單據單頭備註
   LET g_ooff002_d = g_prog   
   LET g_ooff003_d = g_pmda_m.pmdadocno   #单号  
   LET g_ooff004_d = 0    #项次
   LET g_ooff005_d = ' '
   LET g_ooff006_d = ' '
   LET g_ooff007_d = ' '
   LET g_ooff008_d = ' '
   LET g_ooff009_d = ' '
   LET g_ooff010_d = ' '
   LET g_ooff011_d = ' '
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      SUBDIALOG aoo_aooi360_01.aooi360_01_input   #备注单身
      
      ON ACTION accept  
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄) 
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
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
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
    
   CLOSE apmt400_ooff_cl
   
   CALL s_transaction_end('Y','0')
   
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身 

END FUNCTION

 
{</section>}
 
